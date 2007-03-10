From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: pte_offset_map + lazy mmu
Date: Sat, 10 Mar 2007 08:06:36 -0800
Message-ID: <45F2D78C.7050307@goop.org>
References: <45F2521E.1000807@goop.org> <45F2561C.8010604@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F2561C.8010604@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> This could also be genericized in a different way.  PTE updates should
> be limited in scope to just a couple operations.  We don't want to
> have pv-ops for every possible combination of weirdness that can be
> efficiently combined, because then pv-ops explodes.
Yes, but...

> I propose adding a hint or flags field to the PV-op.  In fact, the
> address argument vaddr can be compressed down do a VPN, which gives 12
> more bits for flags to use.  Now, you can pass hints:
>
> PV_LAZY_UPDATE
> PV_DEAD_TABLE
> PV_VADDR_VALID

> which the backend can use.  In the kpte_flush example, you can now
> pass PV_LAZY_UPDATE to combine the pte write with the flush.

Are you saying that PV_LAZY_UPDATE would open a one operation lazy-mmu
window?  I don't like this much at all; this kind of stateful interface
really makes it complex to use, implement and understand.  What happens
if you keep setting this flag on a whole series of operations?  Does it
make them all lazy?  Or are they paired?  How does this interact with
explicitly setting lazy_mmu_mode?

No, I think we should implement laziness with just one mechanism, and
the current one seems just fine to me - though I'd consider adding args
to it to give advance hints about what you're going to be doing in the
lazy region.

>   And in address space destruction, you can pass PV_DEAD_TABLE, which
> allows you to optimize away the pte writes which would otherwise trap
> to the hypervisor, but are not needed, because in the Xen case, you
> switch off the current process page tables during exit() (or should,
> anyway, to avoid spurious traps to Xen before the page tables are freed),

I don't need that because I detach and unpin the pagetable entirely in
the exit_mmap hook.  All the teardown happens on just ordinary unpinned
memory.  Couldn't you do that too?

> and in our case, gets rid of these pte clears that don't need to be
> reflected in the shadows because the shadow is about to die.
>
> And for updates in the current address space, you can pass
> PV_VADDR_VALID to indicate the virtual address field is actually valid
> (note that vaddr =3D=3D 0 is not a sufficient test, as updates to VPN 0
> mappings).  This allows for various flush optimizations as well.

Hm.  I think if you're using a set_pte_at interface, you should always
pass a valid vaddr.  If you don't have a valid vaddr to pass, you should
use set_pte.

> This also gets rid of all the update_pte_defer junk in asm-i386
> includes.  As long as we cooperate on the flags definition and native
> is not adversely affect by shifting the vaddr down (P4 shift are slow
> - our metrics with VMI showed no measurable high level disadvantage
> here for native, but the design has changed, and we should re-verify),
> then this solution is workable.  It just requires us to cooperate to
> come up with a common flags definition.

I don't use that hook, and I never really understood what its for.

    J
