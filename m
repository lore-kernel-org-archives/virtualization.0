From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] xen: fix non-ANSI function warning in irq.c
Date: Tue, 11 Jan 2011 10:15:05 -0500
Message-ID: <20110111151505.GA10897@dumpdata.com>
References: <20110108200036.20ab98c7.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20110108200036.20ab98c7.randy.dunlap@oracle.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 08, 2011 at 08:00:36PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix sparse warning for non-ANSI function declaration:
> 
> arch/x86/xen/irq.c:129:30: warning: non-ANSI function declaration of function 'xen_init_irq_ops'

Thanks, queued up for rc1.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc:	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> ---
>  arch/x86/xen/irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx0107.orig/arch/x86/xen/irq.c
> +++ lnx0107/arch/x86/xen/irq.c
> @@ -126,7 +126,7 @@ static const struct pv_irq_ops xen_irq_o
>  #endif
>  };
>  
> -void __init xen_init_irq_ops()
> +void __init xen_init_irq_ops(void)
>  {
>  	pv_irq_ops = xen_irq_ops;
>  	x86_init.irqs.intr_init = xen_init_IRQ;
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
