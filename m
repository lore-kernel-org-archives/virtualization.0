From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 13:17:17 -0700
Message-ID: <465F2D4D.6060606@goop.org>
References: <465E78D2.9080609@goop.org>
	<465E7CA2.6090201@zytor.com>	<465E7EC0.6080108@goop.org>
	<465F0B71.60303@zytor.com>
	<m1hcps3j86.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1hcps3j86.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>   
>> Jeremy Fitzhardinge wrote:
>>     
>>> H. Peter Anvin wrote:
>>>       
>>>> The more I'm thinking about this whole issue, the more I'm thinking this
>>>> is really misdirected.
>>>>
>>>> I'm starting to think that the right thing to do might very well be as
>>>> follows:
>>>>
>>>> - Change the payload of the bzImage file from a flat binary to an ELF
>>>>   file -- a stripped vmlinux.gz.
>>>> - Change the decompressor to incorporate a (simple) ELF parser.
>>>> - Incorporate a couple of pointer fields in the bzImage header that
>>>>   points directly to the payload, the format of which can be identified
>>>>   via its magic number (currently gzip). 
>>>>         
>>> I don't see a lot of benefit in doing this.  Having some form of
>>> executable I can just run is probably simpler for me to implement than
>>> trying to unwrap a vmlinux.gz from an envelope, even if that's what
>>> we're currently booting.  The Xen domain builder simply wants an ELF
>>> file it can load; if its a self-decompressing kernel image, then that's
>>> OK.  The only real problem is setting up the initial mappings so that
>>> the booting code can run as if paging is enabled.  The simplest answer
>>> to that is to simply 1:1 map all lowmem and set it running, but having
>>> specific Phdrs laying out the mappings would be a bit more refined.
>>>
>>> Now if the bzImage were simply some 16-bit startup code prepended onto
>>> a self-decompressing 32-bit ELF kernel file, then that would be fairly
>>> easy to deal with too, since that would just be a matter of looking at
>>> the boot_params to find the start of the ELF file and continue from
>>> there.
>>>       
>> You're focusing entirely on Xen here, but if Xen really is the only user
>> of this, then I say there isn't much benefit into doing this at all.
>> Hopefully we're trying to solve something bigger than the Xen domain
>> builder being way too rigidly written, here.
>>     
>
> We are.  But it is honest to focus on the problems that you see.
> Jeremy I believe has already committed to changing the Xen domain
> builder.
>
> I haven't seen much that Jeremy has been saying with respect to Xen
> that I haven't noted when working on /sbin/kexec.
>
> However there is one more thing that is probably worth addressing.
> Having a bImage target where we do not compress the raw kernel binary.
> For embedded targets like OLPC they can actually store the kernel in
> less room by using a separate decompressor.
>   

Well, I think that comes pretty naturally if we treat bzImage = 16-bit
startup + ELF kernel image,
where the ELF file can either be a whole vmlinux, or a
self-decompressing kernel.

> I don't think it would be very interesting to our traditional 
>   
...?  Uncompressed kernel not interesting to existing/traditional boot
environments?


>> So it really comes down to: what are the bigger problems we're solving?
>>     
>
> There are two basic core problems.
> 1) Cleaning starting a kernel in it's native mode. (32bit x86/64bit x86_64).
> 2) For bootloaders that boot a diverse set of standalone programs a
>    minimal amount of code needed to support something different.
>
>    For kexec this is the cross architecture problem.
>    For things like Xen  or Grub this is the multiple operating systems.
>
>    Keeping to a standard format helps here.
>    Reporting information about our selves that a standard query
>    mechanism can use helps here.
>
> I think we have seen this problems often enough it is worth solving
> things relatively cleanly.
>   

Also there seem to be enough current diverse users of this mechanism
that any design we come up with to satisfy existing requirements will
likely be a good start for any future users (ie, it may work as-is, or
failing that it should be relatively extensible, so long as we manage to
not introduce some unfortunate limitation).

> The refined bit of more accurate headers reporting which memory the kernel
> can use before it runs may be nice, and in there.
>
> Right now I suspect that changing the decompressor in the bzImage so
> that we are decompressing a vmlinux and then loading that could be a
> pain.  At the moment we don't have code on the table for that.
>
> Further if we manually roll our own headers and are not slaves to
> binutils we get a level of control that we might not have otherwise,
> and that we may need.
>   

Well, that's orthogonal.  So long as we don't get carried away, its not
too hard to arrange to get ld to do all the heavy lifting, while letting
us use gas to generate finely tuned ELF headers.  We can use the same
technique for both bzImage and/or the kernel image itself.

> So we have 3 pieces to this puzzle.
> - The linux boot parameters enhancement (I proposed some specific
>   things that seemed essentially agreed upon).
>   In particular:
>   - A flag to say skip the cli and segment reload.
>     (We can just kill the cli (redundant) but things are just touchy
>      enough I'm not comfortable with unconditionally throwing out
>      the segment reload code, and a flag that we set by default is cheap)
>   

(So long as segment reload includes a gdt reload.)

    J
