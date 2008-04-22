From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 11/15] ia64/pv_ops: paravirtualize NR_IRQS
Date: Tue, 22 Apr 2008 19:11:13 +0900
Message-ID: <20080422101113.GH28863%yamahata__550.85535063899$1208859373$gmane$org@valinux.co.jp>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<1207716549755-git-send-email-yamahata@valinux.co.jp>
	<yq08wz6l0jd.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <yq08wz6l0jd.fsf@jaguar.mkp.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 22, 2008 at 05:08:22AM -0400, Jes Sorensen wrote:
> 
> > Make NR_IRQ overridable by each pv instances.
> > Pv instance may need each own number of irqs so that
> > NR_IRQS should be the maximum number of nr_irqs each
> > pv instances need.
> 
> This really looks dodgy.
> 
> +#ifdef CONFIG_PARAVIRT
> +
> +/* Determine the maximal NR_IRQ which each pv instances require.
> + * i.e. NR_IRQS = max(IA64_NATIVE_NR_IRQS, XEN_NR_IRQS, ...)
> + */
> +
> +#define NR_IRQS 1
> +
> +#if IA64_NATIVE_NR_IRQS > NR_IRQS
> +#undef NR_IRQS
> +#define NR_IRQS IA64_NATIVE_NR_IRQS
> +#endif
> +
> +#ifdef CONFIG_XEN
> +#include <asm/xen/irq.h>
> +#if XEN_NR_IRQS > NR_IRQS
> +#undef NR_IRQS
> +#define NR_IRQS XEN_NR_IRQS
> +#endif
> +#endif /* CONFIG_XEN */
> 
> I don't see why Xen needs special casing here, it really makes the
> code gross. Please use one typedef for this, like PARAVIRT_NR_IRQS or
> something like that, so we don't end up with a KVM special case, an
> LGUEST special case and a Xen special case.

I'm willing to introduce something like PARAVIRT_NR_IRQS,
but I don't see how PARAVIRT_NR_IRQS solves the issues.
What I want here is to define by cpp
#define PARAVIRT_NR_IRQS                                                \
        max(                                                            \
                IA64_NATIVE_NR_IRQS,                                    \
                XEN_NR_IRQS,            /* only if CONFIG_XEN */        \
                LGUSET_NR_IRQS,         /* only if CONFIG_LGUSET */     \
                KVM_GUEST_NR_IRQS,      /* only if CONFIG_KVM_GUEST */  \
                MORE_FUTURE_VM_NR_IRQS, /* only if ...*/                \
                ....    \
        )

Probably I'm missing something.
Could you suggest more concretly? Hopefully (pseudo) code snippet.

-- 
yamahata
