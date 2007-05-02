From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Wed, 02 May 2007 11:31:54 +0200
Message-ID: <46385A8A.6070405__47827.9220559218$1178151026$gmane$org@redhat.com>
References: <20070428758.455116000@suse.de>	<20070428175909.1D09D151CA@wotan.suse.de>	<46338D72.70402@garzik.org>	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>	<4634483E.9030307@goop.org>	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<46363A68.6080201@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46363A68.6080201@goop.org>
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Eric W. Biederman wrote:
>> I have several ideas on how we can make this work but first I have to
>> ask what is it that you are trying to accomplish?
> 
> The requirements are:
> 
>    1. the domain builder needs to get various information about the
>       guest kernel by inspecting its ELF notes

Doesn't need to be ELF notes.  The current (3.0.5+) domain builder has 
pluggable binary parsers.  Right now there are two:  ELF (obviously ...) 
and binary (with a multiboot-like header).  Filling the informations 
such as virt_base is a function of the parser, so when adding one more 
parser to the domain builder for bzImage kernels the parser could do 
something completely different to gather the needed information ...

> That works OK for a kernel which is compiled to run under Xen and can't
> run in any other environment, but now that we can generate a single
> kernel which can run in any number of different environments, its
> unfortunate that we still need multiple variants of the kernel image.

Yep, although already much better than completely different kernels. 
Most space of a typical distro kernel is modules which are shared even 
with different kernel binaries.

> So, I have no problem in also building a boot protocol info structure,
> and passing that in %esi, so long as I can store a pointer to the
> Xen-specific info as well.

Yep, should work fine.

> I think I'd prefer to have the domain builder decompress/relocate the
> kernel from the bzImage and start it directly, rather than have it
> decompress/relocate itself,

I'd expect that work better too.

> It depends
> on how well it can deal with having paging enabled and being in ring 1. 

Xen direct paging mode requiring (leaf) page tables being mapped 
read-only makes page table manipulation a bit difficult.  Xen has to 
care whenever the memory it maps is a page table.  Native hasn't.

Also switching to a completely different set of page tables isn't easy 
under Xen.  My xen guest kexec patches have to perform some intresting 
tricks because of that ...

> Looks like it might just be a matter of starting up with "enough" memory
> mapped.

Doesn't solve the problem of having to switch from identity mapping to 
the 0xc0000000 one ...

cheers,
   Gerd
