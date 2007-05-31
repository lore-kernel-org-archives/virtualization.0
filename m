From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 13:07:57 -0700
Message-ID: <465F2B1D.5030704@goop.org>
References: <465E78D2.9080609@goop.org> <465E7CA2.6090201@zytor.com>
	<465E7EC0.6080108@goop.org> <465F0B71.60303@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465F0B71.60303@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
>   
>> H. Peter Anvin wrote:
>>     
>>> The more I'm thinking about this whole issue, the more I'm thinking this
>>> is really misdirected.
>>>
>>> I'm starting to think that the right thing to do might very well be as
>>> follows:
>>>
>>> - Change the payload of the bzImage file from a flat binary to an ELF
>>>   file -- a stripped vmlinux.gz.
>>> - Change the decompressor to incorporate a (simple) ELF parser.
>>> - Incorporate a couple of pointer fields in the bzImage header that
>>>   points directly to the payload, the format of which can be identified
>>>   via its magic number (currently gzip). 
>>>       
>> I don't see a lot of benefit in doing this.  Having some form of
>> executable I can just run is probably simpler for me to implement than
>> trying to unwrap a vmlinux.gz from an envelope, even if that's what
>> we're currently booting.  The Xen domain builder simply wants an ELF
>> file it can load; if its a self-decompressing kernel image, then that's
>> OK.  The only real problem is setting up the initial mappings so that
>> the booting code can run as if paging is enabled.  The simplest answer
>> to that is to simply 1:1 map all lowmem and set it running, but having
>> specific Phdrs laying out the mappings would be a bit more refined.
>>
>> Now if the bzImage were simply some 16-bit startup code prepended onto
>> a self-decompressing 32-bit ELF kernel file, then that would be fairly
>> easy to deal with too, since that would just be a matter of looking at
>> the boot_params to find the start of the ELF file and continue from
>> there.
>>     
>
> You're focusing entirely on Xen here, but if Xen really is the only user
> of this, then I say there isn't much benefit into doing this at all.
>   

No, I'm using Xen as a concrete example of something which already
exists with well-understood requirements.  I don't think its
requirements are so wacky that it's unrepresentative of other things
which may want to use the same mechanism.  It's much better to talk
about concrete examples rather than just wave an
"architecture-in-the-abstract" wand around.

> So it really comes down to: what are the bigger problems we're solving?
>   

I think the concise statement is: how do we boot a kernel in 32/64-bit
mode, bypassing as much cruft as possible while supporting the widest
possible range of environments?

I think the environment space can be broadly parameterised by:

    paging enabled: yes(pae)/yes(non-pae)/no
    running in ring: 0/1/3
    mode: paravirtualized/native


> Anything that's a true virtualizer should just be able to load and run a
> bzImage file from the 16-bit entrypoint, obviously.  That's not what
> Rusty is doing, but all he'd need is the bit (already proposed) to
> inhibit cli and segment reloads.
>   

Yes, well, we're not talking about full virtualization.  If we were then
there'd be nothing to talk about.

Avoiding cli and segment reloads are part of the general "running
paravirtualized" (or perhaps "running in non-ring 0") part of the
environment space, which is common to all the current paravirt
implementations (though I think vmi and kvm will both be running fully
virtualized at the point in the boot).

    J
