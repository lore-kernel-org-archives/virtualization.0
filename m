From: Zachary Amsden <zach@vmware.com>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 14:19:30 -0800
Message-ID: <45510672.4000301@vmware.com>
References: <4550E512.1020706@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <4550E512.1020706@goop.org>
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
> Hi Zach,
>
> I'm wondering what the interface requirements of set_pte_at()'s "addr" =

> and "ptep" args are.  I presume that in general the ptep points to the =

> pte entry which corresponds to the vaddr, but is this necessarily the =

> case?

Yes, it must pass a pointer to the PTE in ptep.  The "addr" field must =

match the linear address of the mapping changed by the pte - the address =

you would invlpg if required.

> For example, it is valid to pass a non-highmem page kmap_atomic(), =

> which will simply return a direct pointer to the page.
>
> kunmap_atomic() takes this address, as well as the kmap slot index, =

> and ends up calling:
>
>    set_pte_at(&init_mm, lowmem_vaddr, kmap_ptep, 0);
>
> ie, the vaddr and the ptep bear no relationship to each other.  Is =

> this a bug in kunmap_atomic (it shouldn't try to clear the pte for =

> lowmem addresses), or should set_pte_at's implementation be able to =

> cope with this.

Ok, that is really strange, but it seems harmless.

>
> Certainly at the moment, having mismatched ptep and vaddr makes the =

> interface useless for Xen, since it will use one or the other =

> depending on whether we modifying the current pagetable or not, and it =

> assume they correspond to the same thing.
>
> For now I've changed kunmap_atomic() to only clear the kmap pte for =

> mapped high page addresses, but I'm wondering what other places might =

> use set_pte_at in this way.

None that I'm aware of.  The interface here is supposed to be passing =

the "addr" field as the linear address whose mapping in the current =

address space is changing, and the "ptep" field as a pointer to the PTE.

> Also, it would be useful for Xen to have a set_pte_at_sync, which also =

> does a TLB flush if necessary, since we can do that in a single =

> operation.

We could either add new operators or use a flags field which passes a =

"defer this update and piggyback on the next TLB flush" hint - which is =

how the Xen VMI interface worked.

In any case, the address field and hints / operators here are supposed =

to be liberal enough to accommodate using LA hints to update currently =

mapped PTEs and piggyback the flush, and if they are not, it is a bug or =

an oversight.

I haven't really dealt with the HIGHMEM_PTE case thoroughly yet - do we =

want to bother with that?

Zach
