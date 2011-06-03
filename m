From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] xen: off by one errors in multicalls.c
Date: Fri, 03 Jun 2011 11:24:20 -0700
Message-ID: <4DE926D4.9010009__6822.35801728002$1307125519$gmane$org@goop.org>
References: <20110603044528.GD3661@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110603044528.GD3661@shale.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <error27@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, kernel-janitors@vger.kernel.org, "open list:XEN HYPERVISOR IN..." <virtualization@lists.linux-foundation.org>, "open list:XEN HYPERVISOR IN..." <xen-devel@lists.xensource.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/02/2011 09:45 PM, Dan Carpenter wrote:
> b->args[] has MC_ARGS elements, so the comparison here should be
> ">=" instead of ">".  Otherwise we read past the end of the array
> one space.

Yeah, looks like a correct fix.  Fortunately I don't think anything
currently hits that path in practice, though there are some pending
patches which will exercise it more.

Thanks,
    J

> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> This is a static checker patch and I haven't tested it.  Please
> review carefully.
>
> diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
> index 8bff7e7..1b2b73f 100644
> --- a/arch/x86/xen/multicalls.c
> +++ b/arch/x86/xen/multicalls.c
> @@ -189,10 +189,10 @@ struct multicall_space __xen_mc_entry(size_t args)
>  	unsigned argidx = roundup(b->argidx, sizeof(u64));
>  
>  	BUG_ON(preemptible());
> -	BUG_ON(b->argidx > MC_ARGS);
> +	BUG_ON(b->argidx >= MC_ARGS);
>  
>  	if (b->mcidx == MC_BATCH ||
> -	    (argidx + args) > MC_ARGS) {
> +	    (argidx + args) >= MC_ARGS) {
>  		mc_stats_flush(b->mcidx == MC_BATCH ? FL_SLOTS : FL_ARGS);
>  		xen_mc_flush();
>  		argidx = roundup(b->argidx, sizeof(u64));
> @@ -206,7 +206,7 @@ struct multicall_space __xen_mc_entry(size_t args)
>  	ret.args = &b->args[argidx];
>  	b->argidx = argidx + args;
>  
> -	BUG_ON(b->argidx > MC_ARGS);
> +	BUG_ON(b->argidx >= MC_ARGS);
>  	return ret;
>  }
>  
> @@ -216,7 +216,7 @@ struct multicall_space xen_mc_extend_args(unsigned long op, size_t size)
>  	struct multicall_space ret = { NULL, NULL };
>  
>  	BUG_ON(preemptible());
> -	BUG_ON(b->argidx > MC_ARGS);
> +	BUG_ON(b->argidx >= MC_ARGS);
>  
>  	if (b->mcidx == 0)
>  		return ret;
> @@ -224,14 +224,14 @@ struct multicall_space xen_mc_extend_args(unsigned long op, size_t size)
>  	if (b->entries[b->mcidx - 1].op != op)
>  		return ret;
>  
> -	if ((b->argidx + size) > MC_ARGS)
> +	if ((b->argidx + size) >= MC_ARGS)
>  		return ret;
>  
>  	ret.mc = &b->entries[b->mcidx - 1];
>  	ret.args = &b->args[b->argidx];
>  	b->argidx += size;
>  
> -	BUG_ON(b->argidx > MC_ARGS);
> +	BUG_ON(b->argidx >= MC_ARGS);
>  	return ret;
>  }
>  
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
>
