From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Mon, 30 Apr 2007 16:10:31 -0600
Message-ID: <m18xc9344o.fsf__36024.8258839876$1177973121$gmane$org@ebiederm.dsl.xmission.com>
References: <20070428758.455116000@suse.de>
	<20070428175909.1D09D151CA@wotan.suse.de> <46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com> <4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com> <46363A68.6080201@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46363A68.6080201@goop.org> (Jeremy Fitzhardinge's message of
	"Mon, 30 Apr 2007 11:50:16 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Eric W. Biederman wrote:
>> I have several ideas on how we can make this work but first I have to
>> ask what is it that you are trying to accomplish?
>>   
>
> The requirements are:
>
>    1. the domain builder needs to get various information about the
>       guest kernel by inspecting its ELF notes
>    2. we start the kernel in 32-bit mode with paging enabled, in ring 1
>    3. the guest kernel needs various pieces of runtime information from
>       the hypervisor about its runtime environment
>
> At the moment we just load a bare vmlinux kernel with a xen-specific
> entrypoint, so 1 and 2 are easy.  3 is achieved by having the domain
> builder start the kernel with %esi pointing to a Xen info structure
> which tells the kernel what it needs to know.
>
> That works OK for a kernel which is compiled to run under Xen and can't
> run in any other environment, but now that we can generate a single
> kernel which can run in any number of different environments, its
> unfortunate that we still need multiple variants of the kernel image.

Yes.

> Clearly the Xen domain builder needs to be extended to deal with a
> bzImage format kernel directly, so we can use the same actual kernel
> image for native and Xen booting.  Since we're changing the domain
> builder anyway, I can change the details of how it works so long as the
> 3 requirements can still be met.

Ok.

> So, I have no problem in also building a boot protocol info structure,
> and passing that in %esi, so long as I can store a pointer to the
> Xen-specific info as well.  Some info will be duplicated, like the
> initrd location, but that's OK.

Reasonable.

> I'd already reserved a Xen bootloader ID specifically with this in mind;
> all I really need is a place where I can stash the pointer.

Right.

So if you are using the standard linux kernel calling convention and
placing the standard arguments in %esi supporting bzImage gets easier.

> I think I'd prefer to have the domain builder decompress/relocate the
> kernel from the bzImage and start it directly, rather than have it
> decompress/relocate itself, but I'm not really set on that.

We can change a lot more implementation details arbitrarily if you don't
know what needs to happen for decompression and relocation.  Although
I think there is a reasonable argument to support a bImage format.
bzImage without compression.  The current bootloaders would not care
but in the embedded space you can save space but not including the
decompressor in the kernel.

We have to avoid the writes decompressor-prinnt routines and 
possibly the reload of the segment registers.  But otherwise
we should be fine.  I don't see any other privileged instructions
in arch/i386/boot/compressed/{head.S, misc.c}

> It depends
> on how well it can deal with having paging enabled and being in ring 1. 
> Looks like it might just be a matter of starting up with "enough" memory
> mapped.

Yes.  I think so.  There is an additional issue of exactly how do we
get the fixmap region allocated so we can use it but that is minor.

> So the biggest unknown is where to put the Xen ELF notes.

What I really want to do is go back to sticking an ELF header on the
bzImage.  We still can't support multiple entry points that way but we
can include ELF notes fairly easily.

It looks like for the next version of booting lguest and Xen are
actually coming closer together again.  Yea.

For boot protocol. 2.0.7  We currently need a subarchitecture field (16bits?).
default == 0, Xen, lguest, voyager?, visws?, numaq?, efi?

We need a subarchitecture data pointer field (32bits).

We need some subarchitecture kernel information for the different
bootloader.

We need to target .23 because it is to late for .22.

Eric
