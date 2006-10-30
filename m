From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Is this a typo?
Date: Mon, 30 Oct 2006 15:58:12 -0800
Message-ID: <45469194.7030306@goop.org>
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

static pmd_t * __init one_md_table_init(pgd_t *pgd)
{
	pud_t *pud;
	pmd_t *pmd_table;
		=

#ifdef CONFIG_X86_PAE
	pmd_table =3D (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
	paravirt_alloc_pmd(__pa(page_table) >> PAGE_SHIFT);
                                ^^^^^^^^^^ pmd_table?
	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
	pud =3D pud_offset(pgd, 0);
	if (pmd_table !=3D pmd_offset(pud, 0)) =

		BUG();
#else
	pud =3D pud_offset(pgd, 0);
	pmd_table =3D pmd_offset(pud, 0);
#endif

	return pmd_table;
}


Also, did you anticipate that these paravirt_alloc_* functions would be =

useful for Xen to maintain the "pagetable pages must be RO" constraint?  =

Or do you think that will need to be done in a second pass (which is how =

it seems to me).

    J
