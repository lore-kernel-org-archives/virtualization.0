From: Zachary Amsden <zach@vmware.com>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 15:33:20 -0800
Message-ID: <455117C0.2030202@vmware.com>
References: <4550E512.1020706@goop.org> <45510672.4000301@vmware.com>
	<45510AFF.3040304@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45510AFF.3040304@goop.org>
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
> Zachary Amsden wrote:
>>> ie, the vaddr and the ptep bear no relationship to each other.  Is =

>>> this a bug in kunmap_atomic (it shouldn't try to clear the pte for =

>>> lowmem addresses), or should set_pte_at's implementation be able to =

>>> cope with this.
>>
>> Ok, that is really strange, but it seems harmless.
>
> Well, it kills Xen.  It ends up zeroing the pte for vaddr, ignoring =

> the ptep; in my case, it meant that get_zeroed_page ends up returning =

> an unmapped address.  I just pushed a patch to fix this (into the =

> repo, not upstream).

Yes, seems the right thing to do.


>> None that I'm aware of.  The interface here is supposed to be passing =

>> the "addr" field as the linear address whose mapping in the current =

>> address space is changing, and the "ptep" field as a pointer to the PTE.
>
> You mean for the mm that's passed in?

Yes - which better be either the init_mm or the current mm if   you want =

to make use of the addr field constructively.


>>> Also, it would be useful for Xen to have a set_pte_at_sync, which =

>>> also does a TLB flush if necessary, since we can do that in a single =

>>> operation.
>>
>> We could either add new operators or use a flags field which passes a =

>> "defer this update and piggyback on the next TLB flush" hint - which =

>> is how the Xen VMI interface worked.
>
> Do you mean by queuing updates to then submit them all in a single =

> batched hypercall?  Or something else?  That sort of batching =

> certainly works for Xen.

Yes, I believe Xen already has a hypercall for set_pte+flush.

> I guess _sync and "may batch" are opposite senses of the same thing; =

> if you don't sync the tlb, then I presume any pagetable update is =

> effectively deferred until the tlb sync.  Though isn't there some rule =

> about not needing to do an explicit tlb flush if you're increasing the =

> access permissions on a page (since the tlb miss/fault will rewalk the =

> pagetable before actually deciding to raise an exception)?

Not quite - the effects of delayed PTE writes can create read hazards or =

consistency hazards.  If you want to use batching as such, you must =

explicitly flush under the protection of the PTE lock.  This rule =

applies to both shadow and non-shadow MMU consistency with either =

explicit queues (as shadow mode VMI uses), or implicit queues (direct =

writable page tables).

So there are two senses of "batching" - there is combining multiple PTE =

updates into one, and there is piggybacking the flush onto the PTE write.

In some cases, the TLB flush is too far away (not under the page table =

lock) to be piggybacked, so the PTE update must happen immediately.

Anything where you implicitly defer pagetable updates is far too =

vulnerable to bugs.  We played with several such schemes before, and =

although they could be made to work for a shadow mode hypervisor, =

getting them to work for both shadow and direct mode, with performance =

opportunities for everyone was just too risky and a burden on the Linux =

mm code.

There is no architectural rule about tlb flush that I am aware of, =

however, most cores will allow you to do NP->P transitions without a =

flush.  YMMV.  I believe the Linux use is fine.

>> I haven't really dealt with the HIGHMEM_PTE case thoroughly yet - do =

>> we want to bother with that?
>
> I'm planning a patch to get rid of them altogether.

Good.  It does not seem worth the effort.  I do have the code to make it =

work, but it is really ugly.  If some user comes screaming for it later, =

we can always add it back.

Zach
