From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 2/7] Added generic lg.h in lguest directory.
Date: Wed, 8 Aug 2007 21:56:37 -0300
Message-ID: <5d6222a80708081756r21bbc7e3ifd357c9c548ac57f__27937.8637242646$1186621108$gmane$org@mail.gmail.com>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.310187242@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809003343.310187242@goodmis.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 8/8/07, Steven Rostedt <rostedt@goodmis.org> wrote:
> Add a generic lg.h file to call the architecture specific one.
>
> diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
> new file mode 100644
> index 0000000..4c4356e
> --- /dev/null
> +++ b/drivers/lguest/lg.h
> @@ -0,0 +1,3 @@
> +#ifdef CONFIG_X86_32
> +#include "i386/lg.h"
> +#endif

Wouldn't it be cleaner to do something like the asm/ includes?
I understand that lguest now lives in drivers/ and so we don't put
headers directly in asm-i386 , but we could come up with a similar
thing here.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
