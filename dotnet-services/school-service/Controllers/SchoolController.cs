using System.Net.Http;
using System.Threading.Tasks;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

using Steeltoe.Common.Discovery;
using Steeltoe.Discovery.Client;

namespace school_service.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SchoolController : ControllerBase
    {
        private readonly ILogger<SchoolController> _logger;

        private readonly HttpClient _client;

        public SchoolController(ILogger<SchoolController> logger, IHttpClientFactory httpClientFactory)
        {
            _logger = logger;
            _client = httpClientFactory.CreateClient(Consts.DiscoveryClientName);
        }

        [HttpGet("Students/Count")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<int>> QueryStudentsCount()
        {
            var result = await _client.GetStringAsync("http://Student_Service/Student/12345");
            var json = Newtonsoft.Json.JsonConvert.DeserializeObject(result);
            return Ok(1);
        }
    }
}
