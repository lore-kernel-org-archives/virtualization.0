From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 09:25:19 -0700
Message-ID: <45FAC4EF.4060305@goop.org>
References: <45FA054F.6020107@vmware.com>
	<m17itho10v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <m17itho10v.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> I'm not quite familiar with the context.  And I'm to lazy to look right n=
ow.
> What is the difference with COMPAT_VDSO that it doesn't do relocation?
> What are we preserving?
>
>   =


The issue is that with COMPAT_VDSO, the vdso gets mapped at two places:
one random address, and one fixed address (traditionally 0xffffe000 I
think, but that's not mandatory).  The important point is that the
fixed-address is the same one that the vdso itself is linked for, so
that old broken glibcs that some vendors shipped won't explode (because
they use AT_SYSINFO but not AT_SYSINFO_EHDR, so they don't account for
the difference in link and map address).

The problem with the COMPAT_VDSO with paravirt is that the hypervisor
may steal some of the kernel address space, and so push down the address
where the fixed address vdso can be mapped.

Zach's patch relocates the immobile COMPAT_VDSO version of the vdso page
so that map=3Dlink address, regardless of where the kernel's runtime
environment puts the top of the kernel address space.

I guess the other solution is to simply put the compat_vdso mapping at
some low address (like the top of the user address space), and not worry
about it moving.  I don't know if this would work, but I seem to
remember someone mentioning that it had been done in the past.

> The practical question here is if we already have all of the relocation l=
ogic
> for the VDSO why do we need to add more?
>   =


The kernel doesn't normally ever relocate the vdso; usermode can
generally cope with it where ever it gets mapped.


    J
