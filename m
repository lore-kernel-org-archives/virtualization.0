From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: Re: Re: [PATCH 3/5] trace-cmd: Support trace-agent of virtio-trace
Date: Thu, 23 Aug 2012 12:13:17 +0900
Message-ID: <50359FCD.4010908@hitachi.com>
References: <20120822084251.17293.69086.stgit@ltc189.sdl.hitachi.co.jp>
	<20120822084322.17293.70186.stgit@ltc189.sdl.hitachi.co.jp>
	<1345643505.5069.36.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345643505.5069.36.camel@gandalf.local.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>, yrl.pp-manager.tt@hitachi.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Steven,

(2012/08/22 22:51), Steven Rostedt wrote:
> On Wed, 2012-08-22 at 17:43 +0900, Yoshihiro YUNOMAE wrote:
>> Add read path and control path to use trace-agent of virtio-trace.
>> When we use trace-agent, trace-cmd will be used as follows:
>> 	# AGENT_READ_DIR=/tmp/virtio-trace/tracing \
>> 	  AGENT_CTL=/tmp/virtio-trace/agent-ctl-path.in \
>> 	  TRACING_DIR=/tmp/virtio-trace/debugfs/tracing \\
>
> Ha! You used "TRACING_DIR" but patch one introduces TRACE_DIR. Lets
> change this to DEBUG_TRACING_DIR instead anyway.

Oh, sorry for the confusion.

> Also, I don't like the generic environment variables. Perhaps
> VIRTIO_TRACE_DIR, or AGENT_TRACE_DIR and AGENT_TRACE_CTL. Lets try to
> keep the environment namespace sparse.

OK, I'll change these name of environment variables as follows:
     AGENT_READ_DIR
     AGENT_TRACE_CTL
     GUEST_TRACING_DIR

>> 	  trace-cmd record -e "sched:*"
>> Here, AGENT_READ_DIR is the path for a reading directory of virtio-trace,
>> AGENT_CTL is a control path of trace-agent, and TRACING_DIR is a debugfs path
>> of a guest.
>>
>> Signed-off-by: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
>> ---
>>
>>   trace-cmd.h      |    1 +
>>   trace-recorder.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   trace-util.c     |   18 +++++++++++++++++
>>   3 files changed, 75 insertions(+), 1 deletions(-)
>>
>> diff --git a/trace-cmd.h b/trace-cmd.h
>> index f904dc5..75506ed 100644
>> --- a/trace-cmd.h
>> +++ b/trace-cmd.h
>> @@ -72,6 +72,7 @@ static inline int tracecmd_host_bigendian(void)
>>   }
>>
>>   char *tracecmd_find_tracing_dir(void);
>> +char *guest_agent_tracing_read_dir(void);
>>
>>   /* --- Opening and Reading the trace.dat file --- */
>>
>> diff --git a/trace-recorder.c b/trace-recorder.c
>> index 215affc..3b750e9 100644
>> --- a/trace-recorder.c
>> +++ b/trace-recorder.c
>> @@ -33,6 +33,7 @@
>>   #include <unistd.h>
>>   #include <ctype.h>
>>   #include <errno.h>
>> +#include <stdbool.h>
>>
>>   #include "trace-cmd.h"
>>
>> @@ -43,6 +44,8 @@ struct tracecmd_recorder {
>>   	int		page_size;
>>   	int		cpu;
>>   	int		stop;
>> +	int		ctl_fd;
>> +	bool		agent_existing;
>
> Thanks for the reminder. I need to convert a lot to use 'bool' instead.

I'll change 'int' just for flag to use 'bool' as much as possible
after finishing this patch set.

>>   };
>>
>>   void tracecmd_free_recorder(struct tracecmd_recorder *recorder)
>> @@ -59,11 +62,29 @@ void tracecmd_free_recorder(struct tracecmd_recorder *recorder)
>>   	free(recorder);
>>   }
>>
>> +static char *use_trace_agent_dir(char *ctl_path,
>> +					struct tracecmd_recorder *recorder)
>> +{
>> +	ctl_path = strdup(ctl_path);
>> +	if (!ctl_path)
>> +		die("malloc");
>> +	warning("Use environmental control path: %s\n", ctl_path);
>
> s/Use/Using/

OK, I'll correct this.

Thank you,

-- 
Yoshihiro YUNOMAE
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: yoshihiro.yunomae.ez@hitachi.com
