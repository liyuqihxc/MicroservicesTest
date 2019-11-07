using System;
using System.Threading.Tasks;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

using Steeltoe.Common.Discovery;

namespace student_service.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class StudentController : ControllerBase
    {
        private readonly ILogger<StudentController> _logger;

        private readonly DiscoveryHttpClientHandler _handler;

        public StudentController(ILogger<StudentController> logger, IDiscoveryClient client)
        {
            _logger = logger;
            _handler = new DiscoveryHttpClientHandler(client, _logger);
        }

        [HttpGet("{studentId}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<StudentDto>> GetStudentAsync(int studentId)
        {
            if (studentId == 12345)
            {
                return await Task.FromResult(Ok(new StudentDto
                {
                    BithDay = new DateTime(1990, 3, 12),
                        StudentId = 12345,
                        Name = "Stanley"
                }));
            }

            return await Task.FromResult(NotFound());
        }
    }
}
