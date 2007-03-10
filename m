From: Zachary Amsden <zach@vmware.com>
Subject: Re: pte_offset_map + lazy mmu
Date: Fri, 09 Mar 2007 22:54:20 -0800
Message-ID: <45F2561C.8010604@vmware.com>
References: <45F2521E.1000807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F2521E.1000807@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Is pte_offset_map allowed to happen within lazy mmu?  I presume not,
> because you definitely don't want the mapping pte update to be deferred.
>
> Or, more specifically, is kunmap_atomic ever allowed within lazy mmu? =

> I'm looking at kpte_clear_flush; I've already got a patch which turns
> this into a pv_op, along with a Xen implementation.  But I think its
> probably an excess pv_op for a relatively minor corner case.  It seems
> to me that it would be better to define kpte_clear_flush as:
>
>     #define kpte_clear_flush(ptep, vaddr)					\
>     do {									\
>     	arch_enter_lazy_mmu_mode();					\
>     	pte_clear(&init_mm, vaddr, ptep);				\
>     	__flush_tlb_one(vaddr);						\
>     	arch_leave_lazy_mmu_mode();					\
>     } while (0)
>       =

>
> and take advantage of mmu batching to make this operation efficient. =

> But I'm not sure if this is safe.
>
> (Also, kmap_atomic could use set_pte_at rather than set_pte.)
>
> What do you think?
>   =


We (artificially) don't allow nesting of lazy modes, they are intended =

mostly to be isolated to make the guest interface simpler.  We could fix =

that, rather easily, but I think a better solution is possible.

This could also be genericized in a different way.  PTE updates should =

be limited in scope to just a couple operations.  We don't want to have =

pv-ops for every possible combination of weirdness that can be =

efficiently combined, because then pv-ops explodes.

I propose adding a hint or flags field to the PV-op.  In fact, the =

address argument vaddr can be compressed down do a VPN, which gives 12 =

more bits for flags to use.  Now, you can pass hints:

PV_LAZY_UPDATE
PV_DEAD_TABLE
PV_VADDR_VALID

which the backend can use.  In the kpte_flush example, you can now pass =

PV_LAZY_UPDATE to combine the pte write with the flush.  And in address =

space destruction, you can pass PV_DEAD_TABLE, which allows you to =

optimize away the pte writes which would otherwise trap to the =

hypervisor, but are not needed, because in the Xen case, you switch off =

the current process page tables during exit() (or should, anyway, to =

avoid spurious traps to Xen before the page tables are freed), and in =

our case, gets rid of these pte clears that don't need to be reflected =

in the shadows because the shadow is about to die.

And for updates in the current address space, you can pass =

PV_VADDR_VALID to indicate the virtual address field is actually valid =

(note that vaddr =3D=3D 0 is not a sufficient test, as updates to VPN 0 =

mappings).  This allows for various flush optimizations as well.

This also gets rid of all the update_pte_defer junk in asm-i386 =

includes.  As long as we cooperate on the flags definition and native is =

not adversely affect by shifting the vaddr down (P4 shift are slow - our =

metrics with VMI showed no measurable high level disadvantage here for =

native, but the design has changed, and we should re-verify), then this =

solution is workable.  It just requires us to cooperate to come up with =

a common flags definition.

Zach
