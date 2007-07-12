From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] lguest: disable SYSENTER for guests
Date: Thu, 12 Jul 2007 18:30:34 +1000
Message-ID: <1184229034.6005.780.camel__42135.9500302517$1184229162$gmane$org@localhost.localdomain>
References: <1184224595.6005.772.camel@localhost.localdomain>
	<4695DCAD.70507@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4695DCAD.70507@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-07-12 at 10:47 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
>  But what kind of daredevil coder would propose such a thing?)
> 
> Ah, so this is why you want ->next in preempt hooks.  Well, my plan for
> this sort of thing (for kvm has the same issues with the *STAR family of
> msrs) is to add a new hook on switching from kernel to userspace, and
> swap those msrs there.  This allows not only the guest1->guest2 case to
> be optimized, but also guest->kthread->guest, which is a common pattern
> with I/O (and very common with -rt, which runs interrupts in threads).

Adding instructions to the syscall path is not going to make you
popular.  But if you do it, I'll use it 8)

Thanks,
Rusty.
