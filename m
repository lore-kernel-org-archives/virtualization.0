From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/3] xen: Move manage.c to drivers/xen for ia64/xen
	support.
Date: Wed, 23 Apr 2008 17:00:31 -0700
Message-ID: <480FCD9F.3020403__37621.5000208051$1208995423$gmane$org@goop.org>
References: <12088476062604-git-send-email-yamahata@valinux.co.jp>
	<12088476061989-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12088476061989-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> move arch/x86/xen/manage.c under drivers/xen/to share codes
> with x86 and ia64.
> ia64/xen also uses manage.c
>   

Hm, I've got patches to add suspend/resume to manage.c.  I guess they're 
going to be at least partially arch-specific.  Well, no problem to split 
those out.

    J

> Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
> ---
>  arch/x86/xen/Makefile              |    2 +-
>  drivers/xen/Makefile               |    2 +-
>  {arch/x86 => drivers}/xen/manage.c |    0 
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename {arch/x86 => drivers}/xen/manage.c (100%)
>
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index 3d8df98..40b119b 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -1,4 +1,4 @@
>  obj-y		:= enlighten.o setup.o multicalls.o mmu.o \
> -			time.o manage.o xen-asm.o grant-table.o
> +			time.o xen-asm.o grant-table.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 37af04f..363286c 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -1,4 +1,4 @@
> -obj-y	+= grant-table.o features.o events.o
> +obj-y	+= grant-table.o features.o events.o manage.o
>  obj-y	+= xenbus/
>  obj-$(CONFIG_XEN_XENCOMM)	+= xencomm.o
>  obj-$(CONFIG_XEN_BALLOON)	+= balloon.o
> diff --git a/arch/x86/xen/manage.c b/drivers/xen/manage.c
> similarity index 100%
> rename from arch/x86/xen/manage.c
> rename to drivers/xen/manage.c
>   
