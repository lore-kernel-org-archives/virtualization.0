From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 11/15] ia64/pv_ops: paravirtualize NR_IRQS
Date: Wed, 23 Apr 2008 11:54:14 +0900
Message-ID: <20080423025414.GA7679%yamahata__44718.0764437237$1208919473$gmane$org@valinux.co.jp>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<1207716549755-git-send-email-yamahata@valinux.co.jp>
	<yq08wz6l0jd.fsf@jaguar.mkp.net>
	<20080422101113.GH28863%yamahata@valinux.co.jp>
	<480DD4A7.9020207@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <480DD4A7.9020207@sgi.com>
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

On Tue, Apr 22, 2008 at 02:05:59PM +0200, Jes Sorensen wrote:
> Isaku Yamahata wrote:
> >I'm willing to introduce something like PARAVIRT_NR_IRQS,
> >but I don't see how PARAVIRT_NR_IRQS solves the issues.
> >What I want here is to define by cpp
> >#define PARAVIRT_NR_IRQS                                                \
> >        max(                                                            \
> >                IA64_NATIVE_NR_IRQS,                                    \
> >                XEN_NR_IRQS,            /* only if CONFIG_XEN */        \
> >                LGUSET_NR_IRQS,         /* only if CONFIG_LGUSET */     \
> >                KVM_GUEST_NR_IRQS,      /* only if CONFIG_KVM_GUEST */  \
> >                MORE_FUTURE_VM_NR_IRQS, /* only if ...*/                \
> >                ....    \
> >        )
> >
> >Probably I'm missing something.
> >Could you suggest more concretly? Hopefully (pseudo) code snippet.
> 
> I'd rather have PARAVIRT_NR_IRQ set from Kconfig if possible given that
> all of these are constants anyway. If we cannot do that, then it would
> be better to do the #if FOO_NR_IRQ > PARAVIRT_NR_IRQ in the various
> header files for Xen/KVM/lguest so we don't get the clutter in the main
> makefile.

Unfotunately Kconfig doesn't support arithmetic comparison.
So do you want something like the followings?

irq.h:

#if (NR_VECTORS + 32 * NR_CPUS) < 1024
#define IA64_NATIVE_NR_IRQS (NR_VECTORS + 32 * NR_CPUS)
#else
#define IA64_NATIVE_NR_IRQS 1024
#endif

#define PARAVIRT_NR_IRQS	IA64_NATIVE_NR_IRQS
/* CAUTION:each asm/xxx/irq.h may redefine PARAVIRT_NR_IRQS */
#include <asm/xen/irq.h>
#include <asm/kvm/irq.h>
#include <asm/foo/irq.h>
...

#define NR_IRQS			PARAVIRT_NR_IRQS


asm/foo/irq.h:

#define FOO_NR_IRQ	...

#ifdef CONFIG_FOO
#if FOO_NR_IRQS > PARAVIRT_NR_IRQS
#undef PARAVIRT_NR_IRQS
#define PARAVIRT_NR_IRQS FOO_NR_IRQS
#endif
#endif


-- 
yamahata
