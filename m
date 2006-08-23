From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 11:55:31 +1000
Message-ID: <1156298131.12015.42.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org>
	<1156254965.27114.17.camel@localhost.localdomain>
	<200608221544.26989.ak@muc.de> <44EB3BF0.3040805@vmware.com>
	<1156271386.2976.102.camel@laptopd505.fenrus.org>
	<1156275004.27114.34.camel@localhost.localdomain>
	<44EB584A.5070505@vmware.com> <44EB5A76.9060402@vmware.com>
	<p73y7tg7cg7.fsf@verdi.suse.de>  <44EB7F0C.60402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44EB7F0C.60402@vmware.com>
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 15:02 -0700, Zachary Amsden wrote:
> Well, I don't think anything is sufficient for a preemptible kernel.  I =

> think that's just plain not going to work.  You could have a kernel =

> thread that got preempted in a paravirt-op patch point

Patching over the 6 native cases is actually not that bad: they're
listed below (each one has trailing noops).

	cli
	sti
	push %eax; popf
	pushf; pop %eax
	pushf; pop %eax; cli
	iret
	sti; sysexit

If you're at the first insn you don't have to do anything, since you're
about to replace that code.  If you're in the noops, you can just
advance EIP to the end.  You can't be preempted between sti and sysexit,
since we only use that when interrupts are already disabled.  And
reversing either "push %eax" or "pushf; pop %eax" is fairly easy.

Depending on your hypervisor, you might need to catch those threads who
are currently doing the paravirt_ops function calls, as well.  This
introduces more (and more complex) cases.

That all said, I've long speculated about a stop_machine which schedules
all the preempted threads, to ensure every thread is in a happy
unpreempt place.  This would involve scheduler hacks, but would allow us
to remove the preempt_disable() calls around try_module_get() and any
other areas which use stop_machine as the write side of locking.

Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
