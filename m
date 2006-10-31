From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Is this a typo?
Date: Mon, 30 Oct 2006 16:06:12 -0800
Message-ID: <20061031000612.GC5881@sequoia.sous-sol.org>
References: <45469194.7030306@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45469194.7030306@goop.org>
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

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> static pmd_t * __init one_md_table_init(pgd_t *pgd)
> {
> 	pud_t *pud;
> 	pmd_t *pmd_table;
> 		=

> #ifdef CONFIG_X86_PAE
> 	pmd_table =3D (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> 	paravirt_alloc_pmd(__pa(page_table) >> PAGE_SHIFT);
>                                ^^^^^^^^^^ pmd_table?

Weird, that should be fixed already

thanks,
-chris
