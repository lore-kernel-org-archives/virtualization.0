From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: pte_offset_map + lazy mmu
Date: Fri, 09 Mar 2007 22:37:18 -0800
Message-ID: <45F2521E.1000807@goop.org>
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

Is pte_offset_map allowed to happen within lazy mmu?  I presume not,
because you definitely don't want the mapping pte update to be deferred.

Or, more specifically, is kunmap_atomic ever allowed within lazy mmu? =

I'm looking at kpte_clear_flush; I've already got a patch which turns
this into a pv_op, along with a Xen implementation.  But I think its
probably an excess pv_op for a relatively minor corner case.  It seems
to me that it would be better to define kpte_clear_flush as:

    #define kpte_clear_flush(ptep, vaddr)					\
    do {									\
    	arch_enter_lazy_mmu_mode();					\
    	pte_clear(&init_mm, vaddr, ptep);				\
    	__flush_tlb_one(vaddr);						\
    	arch_leave_lazy_mmu_mode();					\
    } while (0)
      =


and take advantage of mmu batching to make this operation efficient. =

But I'm not sure if this is safe.

(Also, kmap_atomic could use set_pte_at rather than set_pte.)

What do you think?

    J
