From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 03/20] x86/ticketlock: Use C for __ticket_spin_unlock
Date: Sat, 13 Nov 2010 18:05:27 +0800
Message-ID: <20101113100527.GG3837__31833.2999515862$1289837763$gmane$org@hack>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<20092775a9df07a5a75820ac250194b535279d51.1288794124.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20092775a9df07a5a75820ac250194b535279d51.1288794124.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 03, 2010 at 10:59:44AM -0400, Jeremy Fitzhardinge wrote:
>  * On PPro SMP or if we are using OOSTORE, we use a locked operation to unlock
>  * (PPro errata 66, 92)
>  */
>-# define UNLOCK_LOCK_PREFIX LOCK_PREFIX
>+static __always_inline void __ticket_unlock_release(struct arch_spinlock *lock)
>+{
>+	if (sizeof(lock->tickets.head) == sizeof(u8))
>+		asm (LOCK_PREFIX "incb %0"
>+		     : "+m" (lock->tickets.head) : : "memory");
>+	else
>+		asm (LOCK_PREFIX "incw %0"
>+		     : "+m" (lock->tickets.head) : : "memory");

This 'if/else' really should be done with #ifdef, even though
the compiler may be smart enough to remove it.

>+
>+}
> #else
>-# define UNLOCK_LOCK_PREFIX
>+static __always_inline void __ticket_unlock_release(struct arch_spinlock *lock)
>+{
>+	barrier();
>+	lock->tickets.head++;
>+	barrier();

The second barrier() is not needed.

Thanks.
