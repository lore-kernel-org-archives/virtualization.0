From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 06/11] xen: move arch/x86/xen/events.c undedr drivers/xen
	and split out arch specific part.
Date: Thu, 21 Feb 2008 11:38:18 -0800
Message-ID: <47BDD32A.6030201__18861.6176405505$1203623412$gmane$org@goop.org>
References: <20080221084530.470680000@ls.local.valinux.co.jp>
	<20080221091002.222498000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080221091002.222498000@ls.local.valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yamahata@valinux.co.jp
Cc: xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

yamahata@valinux.co.jp wrote:
> diff --git a/arch/x86/xen/events.c b/drivers/xen/events.c
> similarity index 95%
> rename from arch/x86/xen/events.c
> rename to drivers/xen/events.c
> index dcf613e..7474739 100644
> --- a/arch/x86/xen/events.c
> +++ b/drivers/xen/events.c
> @@ -37,7 +37,9 @@
>  #include <xen/interface/xen.h>
>  #include <xen/interface/event_channel.h>
>  
> -#include "xen-ops.h"
> +#ifdef CONFIG_X86
> +# include "../arch/x86/xen/xen-ops.h"
> +#endif

Hm.  Perhaps it would be better to move whatever definition you need 
into a header in a common place (or move xen-ops.h entirely).

    J
