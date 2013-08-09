From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH  V12 0/14] Paravirtualized ticket spinlocks
Date: Fri, 09 Aug 2013 18:39:24 +0530
Message-ID: <5204EA04.9060109@linux.vnet.ibm.com>
References: <20130806114020.20643.57235.sendpatchset@codeblue.in.ibm.com>
	<52044013.3010202@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <52044013.3010202@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/09/2013 06:34 AM, H. Peter Anvin wrote:
> The kbuild test bot is reporting some pretty serious errors for this
> patchset.  I think these are serious enough that the patchset will need
> to be respun.
>

There were two problems:
(1) we were including spinlock_types.h in 
arch/x86/include/asm/paravirt_types.h.

This was resulting in redefinition of arch_spinlock_t for non SMP kernel

solution was :
conditional inclusion of spinlock_types.h like below

#ifdef CONFIG_SMP
#include <asm/spinlock_types.h>
#else
typedef u16 __ticket_t;
#endif

(we needed __ticket_t declaration for UP)

(2) we had forward declaration of atomic_read in jumpl_label.
It was causing problem for alpha, which has macro for atomic_read
instead of static inline.

Solution was to remove forward declaration and have atomic.h included.

Peter,
  the above two changes needs small changes in patch 1 and patch 9.
I 'll be resending only those two patches.

I am happy to resend the whole series if it is better and easier for
you.
