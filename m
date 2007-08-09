From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: [PATCH 5/7] Change lguest launcher to use asm generic include
Date: Wed, 8 Aug 2007 22:05:53 -0300
Message-ID: <5d6222a80708081805t633455cr381f9b4d687c73fb__12716.8942978189$1186621645$gmane$org@mail.gmail.com>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.829371800@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809003343.829371800@goodmis.org>
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

> --- a/Documentation/lguest/lguest.c
> +++ b/Documentation/lguest/lguest.c
> @@ -46,7 +46,7 @@ typedef uint32_t u32;
>  typedef uint16_t u16;
>  typedef uint8_t u8;
>  #include "../../include/linux/lguest_launcher.h"
> -#include "../../include/asm-i386/e820.h"
> +#include "../../include/asm/e820.h"

Couldn't we add the ../../../../../../../etc to the Makefile and avoid it here?

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
