From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Wed, 02 May 2007 08:16:37 -0700
Message-ID: <4638AB55.20408__43015.5891379856$1178151764$gmane$org@goop.org>
References: <20070428758.455116000@suse.de>	<20070428175909.1D09D151CA@wotan.suse.de>	<46338D72.70402@garzik.org>	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>	<4634483E.9030307@goop.org>	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<46363A68.6080201@goop.org> <46385A8A.6070405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46385A8A.6070405@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Doesn't need to be ELF notes.  The current (3.0.5+) domain builder has
> pluggable binary parsers.  Right now there are two:  ELF (obviously
> ...) and binary (with a multiboot-like header).  Filling the
> informations such as virt_base is a function of the parser, so when
> adding one more parser to the domain builder for bzImage kernels the
> parser could do something completely different to gather the needed
> information ...

True.  But the plan is already to make bzImage an ELF file, so notes
would seem to be the best option.  At worst, it could be ELF notes
wrapped in some other container, but that's not pretty.

>> That works OK for a kernel which is compiled to run under Xen and can't
>> run in any other environment, but now that we can generate a single
>> kernel which can run in any number of different environments, its
>> unfortunate that we still need multiple variants of the kernel image.
>
> Yep, although already much better than completely different kernels.
> Most space of a typical distro kernel is modules which are shared even
> with different kernel binaries.

Yep.

>> So, I have no problem in also building a boot protocol info structure,
>> and passing that in %esi, so long as I can store a pointer to the
>> Xen-specific info as well.
>
> Yep, should work fine.
>
>> I think I'd prefer to have the domain builder decompress/relocate the
>> kernel from the bzImage and start it directly, rather than have it
>> decompress/relocate itself,
>
> I'd expect that work better too.
>
>> It depends
>> on how well it can deal with having paging enabled and being in ring 1. 
>
> Xen direct paging mode requiring (leaf) page tables being mapped
> read-only makes page table manipulation a bit difficult.  Xen has to
> care whenever the memory it maps is a page table.  Native hasn't.
>
> Also switching to a completely different set of page tables isn't easy
> under Xen.  My xen guest kexec patches have to perform some intresting
> tricks because of that ...

Yeah, that's tricky.  I ended up copying the Xen pagetables's pmd into
the kernel's so that they could share ptes.  Making a completely new
pagetable means you need to update the RO state on both old and new.

>> Looks like it might just be a matter of starting up with "enough" memory
>> mapped.
>
> Doesn't solve the problem of having to switch from identity mapping to
> the 0xc0000000 one ...

Hm.  That's right.  Xen will boot a vmlinux with its pagetable
pre-constructed to map it at its virtual address.  Going through bzImage
would mean it would be identity mapped, and someone early would need to
construct the virtual mapping.

But if the path is:

   1. enter bzImage in 32-bit mode
   2. decompress kernel
   3. jump to startup_32
   4. detect paravirt and choose appropriate backend
   5. run Xen startup code

then the Xen startup code can construct the virtual mapping before going
on with the rest of the kernel boot - steps 1-4 can be run with identity
mapping.


    J
