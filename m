From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Thu, 11 Jan 2007 15:12:19 +0100
Message-ID: <45A645C3.2060802@suse.de>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A55E29.2090207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A55E29.2090207@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>> Looks like a slot-3 pmd got reused for slot-0, with some stale entries
>> for the hypervisor hole in there for some reason ...
>>
>> quick and dirty sledge hammer fix:
>>
>> --- paravirt-2.6.20-rc4-hg691.orig/arch/i386/paravirt-xen/enlighten.c
>> +++ paravirt-2.6.20-rc4-hg691/arch/i386/paravirt-xen/enlighten.c
>> @@ -522,6 +522,7 @@ static fastcall void xen_alloc_pd(u32 pf
>>  static fastcall void xen_release_pd(u32 pfn)
>>  {
>>         make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
>> +       memset(__va(PFN_PHYS(pfn)), 0, PAGE_SIZE);
>>  }
>>
>>  static fastcall void xen_release_pt(u32 pfn)
>>   =

> =

> Does this work?
> =

> diff -r 252f3ed87072 arch/i386/mm/pgtable.c
> --- a/arch/i386/mm/pgtable.c    Mon Jan 08 16:57:56 2007 -0800
> +++ b/arch/i386/mm/pgtable.c    Wed Jan 10 13:13:40 2007 -0800
> @@ -265,6 +265,7 @@ static void pgd_ctor(pgd_t *pgd)
>                                         swapper_pg_dir + USER_PTRS_PER_PG=
D,
>                                         KERNEL_PGD_PTRS);
>                 } else {
> +                       memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>                         spin_lock_irqsave(&pgd_lock, flags);
>                         pgd_list_add(pgd);
>                         spin_unlock_irqrestore(&pgd_lock, flags);

Didn't try (yet), but I don't think so.  It's not the pgd which is
broken, but the pmd.  And I think this way:

  (1) pmd is created
  (2) pmd is taken out of the slabcache and used for the kernel/xen
      address space (i.e. slot-3 in the PAE pgd).
  (3) xen fills in the page table entries for the hypervisor hole
  (4) pmd released and put back into the slab cache.
  (5) pmd gets reused, but for userspace addresses this time (pgd
      slot 0-2).
  (6) xen_pin() finds the stale entries for the hypervisor hole
  =3D=3D> Oops.

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
