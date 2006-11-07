From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: how set_pte_at()'s vaddr and ptep args relate
Date: Tue, 07 Nov 2006 11:57:06 -0800
Message-ID: <4550E512.1020706@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
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

Hi Zach,

I'm wondering what the interface requirements of set_pte_at()'s "addr" =

and "ptep" args are.  I presume that in general the ptep points to the =

pte entry which corresponds to the vaddr, but is this necessarily the case?

For example, it is valid to pass a non-highmem page kmap_atomic(), which =

will simply return a direct pointer to the page.

kunmap_atomic() takes this address, as well as the kmap slot index, and =

ends up calling:

    set_pte_at(&init_mm, lowmem_vaddr, kmap_ptep, 0);

ie, the vaddr and the ptep bear no relationship to each other.  Is this =

a bug in kunmap_atomic (it shouldn't try to clear the pte for lowmem =

addresses), or should set_pte_at's implementation be able to cope with this.

Certainly at the moment, having mismatched ptep and vaddr makes the =

interface useless for Xen, since it will use one or the other depending =

on whether we modifying the current pagetable or not, and it assume they =

correspond to the same thing.

For now I've changed kunmap_atomic() to only clear the kmap pte for =

mapped high page addresses, but I'm wondering what other places might =

use set_pte_at in this way.

Also, it would be useful for Xen to have a set_pte_at_sync, which also =

does a TLB flush if necessary, since we can do that in a single operation.

    J
