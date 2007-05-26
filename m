From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Sun, 27 May 2007 00:47:16 +0100
Message-ID: <4658C704.2050405@goop.org>
References: <4656FB8F.4090604@goop.org> <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753911AbXEZXra@vger.kernel.org>
In-Reply-To: <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
>> What was the problem with ELF bzImage?  Is it confirmed to be
>> problematic, or just suspected?
>>     
>
> There was a problem, Andrews machine would not the kernel with the ELF
> header.  It was not root caused.  So we are not certain why.
>   

The Vaio?  Do you think we could use it as kindling when we "deal with"
James's Voyagers?


>> Could we end up using a plain ELF file
>> (which would be easiest for me, since I think the existing ELF domain
>> builder could pretty much deal with that as-is).
>>     
>
> I think we should start there and be prepared to munge the ELF
> magic number if there are problems.  Placing ELF notes is going
> to require a little work but mostly it should be a matter of
> copying the from vmlinux.
>   

I'd really prefer to keep an intact embedded ELF file rather than have a
semi-ELF file.  That way it would be easier to simply load the image and
point the normal ELF machinery at some offset into the file rather than
having to have a special handler for "\x7fBZE" or whatever.

> Most of that though is just packaging.  The meat of the issue
> is how do we upgrade the bootloader data.  Do the changes
> below sound like everything we need?
>   

How does the kernel specify what memory it requires to be mapped (both
for the image itself, and for any memory it needs to use to
decompress/relocate the final kernel image).

If its by using ELF Phdrs, then we need to:

   1. specify the constraints on what mappings are allowed,
   2. specify how the bootloader uses the mappings, and
   3. specify how the ELF file is to be found.

If the bzImage is really a plain ELF file, then 3 is a non-issue. 
Otherwise, should we allocate a field which specifies the offset of the
ELF header within the bzImage, and make all offsets contained in the ELF
header relative to the header itself rather than the overall bzImage?

As far as 1 and 2 go, I propose:

Requirements on the Phdrs in the image:

   1. the Phdrs must map the actual bzImage code and data, with
      appropriate filesz and memsz
   2. the Phdrs must also map all the other memory needed to
      decompress/relocate the kernel, with filesz=0 and memsz set
      appropriately
   3. the Phdr mappings must always be 1:1 (ie, P=V), and RW(X)
   4. the mappings must be as low as possible, to avoid any hole the
      hypervisor requires (if the mappings are too high, the bootloader
      may just fail to start the kernel)

Requirements for the bootloader:

   1. it is always correct for the bootloader to simply leave paging
      disabled; presumably the subarch will tell the kernel that it
      needs to set up its own initial mappings
   2. if paging is enabled, the bootloader creates mappings:
         1. with PAE set to match the kernel's requirements (this
            suggests that loadflags should have a PAE/non-PAE flag)
         2. all mappings are RWX (ie, RW, no NX) [ rationale: this means
            we don't need to deal with pages of different
            types/permissions at this stage of booting, which might be
            especially awkward when recycling pages ]
         3. mappings covering at least the ones specified by the Phdrs,
            but it is acceptible to over-map (for example, map the
            entire address space)
         4. Other non-1:1 mappings may exist outside the image's Phdrs
            (for example, containing the initial pagetables, hypervisor
            address space, and other mappings)


>  Field name:	loadflags
>  Type:		modify (obligatory)
>  Offset/size:	0x211/1
>  Protocol:	2.00+
>  
>    This field is a bitmask.
>  
>    Bit 0 (read):	LOADED_HIGH
>  	- If 0, the protected-mode code is loaded at 0x10000.
>  	- If 1, the protected-mode code is loaded at 0x100000.
>   
+ Bit 5 (read): PAE mode
+    If the bootloader starts kernel with paging enabled, then:
+        - if 0, enable non-PAE mode paging
+        - if 1, enable PAE mode paging

> +  Bit 6 (write): KEEP_SEGMENTS
> +	Protocol: 2.07+
> +	- if 0, reload the segment registers in the 32bit entry point.
>   

So does this mean the bootloader has set up a kernel-compatible GDT?  Or
does it also mean "set up a GDT"?

    J
