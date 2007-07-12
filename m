From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] lguest: disable SYSENTER for guests
Date: Thu, 12 Jul 2007 10:47:57 +0300
Message-ID: <4695DCAD.70507__31874.5090779432$1184226591$gmane$org@qumranet.com>
References: <1184224595.6005.772.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184224595.6005.772.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> The SYSENTER instruction jumps to a pre-programmed address at
> privilege level 0.  We must not allow execution of guest code at that
> privilege level, so disable sysenter when we enter the guest (and
> re-enable it on return).  This fixes current case where guest
> userspace can crash host.
>
> This save/restore adds 3% to guest context switch times.  (If only
> there were some kind of scheduler hook or something which would tell
> us when we were being preempted so we could fix this up lazily.  But
> what kind of daredevil coder would propose such a thing?)
>
>   

Ah, so this is why you want ->next in preempt hooks.  Well, my plan for
this sort of thing (for kvm has the same issues with the *STAR family of
msrs) is to add a new hook on switching from kernel to userspace, and
swap those msrs there.  This allows not only the guest1->guest2 case to
be optimized, but also guest->kthread->guest, which is a common pattern
with I/O (and very common with -rt, which runs interrupts in threads).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
