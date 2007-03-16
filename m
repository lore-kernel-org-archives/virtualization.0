From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 05:56:00 -0600
Message-ID: <m17itho10v.fsf@ebiederm.dsl.xmission.com>
References: <45FA054F.6020107@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45FA054F.6020107@vmware.com> (Zachary Amsden's message of "Thu,
	15 Mar 2007 18:47:43 -0800")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden <zach@vmware.com> writes:

> Paravirt-ops guests which move the fixmap also end up moving the syscall =
VDSO.
> This fails if it is prelinked at a fixed address, which is why COMPAT_VDS=
O is
> broken under CONFIG_VMI (and also under CONFIG_XEN).  Several options are
> available to try to address this.  Jan had cooked up a patch for Xen that=
 used
> build magic to find the parts of the VDSO that need relocation.  I don't =
like
> the idea of having auto-generated relocations, as someday something could=
 change
> between two linked objects (timestamp, elf notes perhaps) that is not a
> relocation.  So I prefer human supervision over the relocation and explic=
itly
> fixing everything by hand.  I'm not necessarily advocating one solution o=
ver the
> other; my way is more code to maintain if the VDSO linkage changes.  I'm =
looking
> for feedback about which way is best.
>
> Also, it appears that COMPAT_VDSO could disappear entirely.  Since this a=
pproach
> should work with older broken ld.so (2.3.2 is the version, I believe), we=
 should
> be able to switch over completely to using the gate vma style of linking =
the
> vdso.  One can even get the address randomization benefits by simply runn=
ing
> fixup on the vdso if you are prepared to take the cost of allocating an e=
xtra
> page per process.  Or you could randomize just once at boot, which makes =
the
> randomization per-machine, still sufficient to slow network based worm at=
tacks
> which might rely on a fixed VDSO address.
>
> Clearly this patch needs more testing and feedback, which I'm sure it will
> get...
>
> <zach ducks>
>
> Zach
>
> P.S. - Eric, I've copied you as you appear to be an ELF expert, or at lea=
st have
> a greater grasp of Elven Magic than me, and I'm hoping I got all the dyna=
mic
> tags which need relocation right.
> Invoke black magic to relocate the VDSO even when COMPAT_VDSO is enabled
> by fixing up the ELF object.

I'm not quite familiar with the context.  And I'm to lazy to look right now.
What is the difference with COMPAT_VDSO that it doesn't do relocation?
What are we preserving?

The practical question here is if we already have all of the relocation log=
ic
for the VDSO why do we need to add more?

I'm tempted to rant on the pure insanity of address space randomization but
that is a whole other issue...

Eric
