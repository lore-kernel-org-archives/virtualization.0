From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 14:38:55 -0800
Message-ID: <45510AFF.3040304@goop.org>
References: <4550E512.1020706@goop.org> <45510672.4000301@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45510672.4000301@vmware.com>
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
>> ie, the vaddr and the ptep bear no relationship to each other.  Is =

>> this a bug in kunmap_atomic (it shouldn't try to clear the pte for =

>> lowmem addresses), or should set_pte_at's implementation be able to =

>> cope with this.
>
> Ok, that is really strange, but it seems harmless.

Well, it kills Xen.  It ends up zeroing the pte for vaddr, ignoring the =

ptep; in my case, it meant that get_zeroed_page ends up returning an =

unmapped address.  I just pushed a patch to fix this (into the repo, not =

upstream).

> None that I'm aware of.  The interface here is supposed to be passing =

> the "addr" field as the linear address whose mapping in the current =

> address space is changing, and the "ptep" field as a pointer to the PTE.

You mean for the mm that's passed in?

>> Also, it would be useful for Xen to have a set_pte_at_sync, which =

>> also does a TLB flush if necessary, since we can do that in a single =

>> operation.
>
> We could either add new operators or use a flags field which passes a =

> "defer this update and piggyback on the next TLB flush" hint - which =

> is how the Xen VMI interface worked.

Do you mean by queuing updates to then submit them all in a single =

batched hypercall?  Or something else?  That sort of batching certainly =

works for Xen.

I guess _sync and "may batch" are opposite senses of the same thing; if =

you don't sync the tlb, then I presume any pagetable update is =

effectively deferred until the tlb sync.  Though isn't there some rule =

about not needing to do an explicit tlb flush if you're increasing the =

access permissions on a page (since the tlb miss/fault will rewalk the =

pagetable before actually deciding to raise an exception)?

> I haven't really dealt with the HIGHMEM_PTE case thoroughly yet - do =

> we want to bother with that?

I'm planning a patch to get rid of them altogether.

    J
