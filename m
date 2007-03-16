From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 13:06:46 -0600
Message-ID: <m1ps79m2ih.fsf@ebiederm.dsl.xmission.com>
References: <45FA054F.6020107@vmware.com>
	<m17itho10v.fsf@ebiederm.dsl.xmission.com> <45FAC4EF.4060305@goop.org>
	<20070316163118.GA12999@elte.hu> <45FAC6E6.5090000@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <45FAC6E6.5090000@goop.org> (Jeremy Fitzhardinge's message of
	"Fri, 16 Mar 2007 09:33:42 -0700")
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
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Ingo Molnar wrote:
>> that's what is the case right now, but much of the intention behind the =

>> vma based vDSO is to enable per-process randomized vdso locations, and =

>> various distributions do that. So the 'modern' vDSO concept is very much =

>> relocatable.
>
> No, the point is that it never needs relocating.  The kernel can map it
> anywhere and userspace can cope.  Its only the broken glibcs which
> require relocation.

Ok.  So to summarize.
There are three ways of finding the VDSO.
- AT_SYSINFO
- AT_SYSINFO_EHDR
- known fixed address (see x86_64)

Currently it doesn't sound like you need to deal with the known fixed
address case but COMPAT_VDSO also provides that.

If userspace uses AT_SYSINFO the premise is that it is not expecting
not to need to perform any relocation processing.

If userspace uses AT_SYSINFO_EHDR it expects it needs to perform
relocation processing and fixes up whatever needs fixing up.

With the module code we have shown the kernel is capable of performing
relocation processing at times and it works.

So is it possible to simply relocate the normal vdso and fixup
it's program header so it shows that relocation is not necessary.
If you can do that and still export AT_SYSINFO so the problem user
space still runs you are good.  (If you can relocate the vdso
you should be able to relocate it anywhere).

Otherwise it probably just make sense to simply not export a VDSO
on those systems.

This would leave COMPAT_VDSO for the case where you must use one magic
fixed address, and if user space does not require that it means
COMPAT_VDSO could be completely removed.

Eric
