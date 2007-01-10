From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Wed, 10 Jan 2007 11:29:40 +0100
Message-ID: <45A4C014.9030909@suse.de>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A4A0C7.5050405@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Jeremy Fitzhardinge wrote:
>> Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>> paravirt kernel doesn't boot as xen guest for me, see attachment.
>>>   =

>> Hm, I just booted a pae kernel from the current paravirt repo and got it
>> to usermode.  What's your .config?  Also, what line is getting the fault?
> =

> config is attached.
> =

> It faults in fork syscall, down in pgd_walk().  It finds a pmd entry
> pointing to a machine page where the mfn_to_pfn translation returns -1
> aka 0xffffffff.  Trying to find a struct page for that one doesn't work .=
..

Looks like a slot-3 pmd got reused for slot-0, with some stale entries
for the hypervisor hole in there for some reason ...

quick and dirty sledge hammer fix:

--- paravirt-2.6.20-rc4-hg691.orig/arch/i386/paravirt-xen/enlighten.c
+++ paravirt-2.6.20-rc4-hg691/arch/i386/paravirt-xen/enlighten.c
@@ -522,6 +522,7 @@ static fastcall void xen_alloc_pd(u32 pf
 static fastcall void xen_release_pd(u32 pfn)
 {
        make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
+       memset(__va(PFN_PHYS(pfn)), 0, PAGE_SIZE);
 }

 static fastcall void xen_release_pt(u32 pfn)

OK, now I'm back to the old buggy state where the ttylinux rootfs fails
to boot up due to init being killed instantly or something like that ...

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
