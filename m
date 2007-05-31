From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 10:52:49 -0700
Message-ID: <465F0B71.60303@zytor.com>
References: <465E78D2.9080609@goop.org> <465E7CA2.6090201@zytor.com>
	<465E7EC0.6080108@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465E7EC0.6080108@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> H. Peter Anvin wrote:
>> The more I'm thinking about this whole issue, the more I'm thinking this
>> is really misdirected.
>>
>> I'm starting to think that the right thing to do might very well be as
>> follows:
>>
>> - Change the payload of the bzImage file from a flat binary to an ELF
>>   file -- a stripped vmlinux.gz.
>> - Change the decompressor to incorporate a (simple) ELF parser.
>> - Incorporate a couple of pointer fields in the bzImage header that
>>   points directly to the payload, the format of which can be identified
>>   via its magic number (currently gzip). 
> 
> I don't see a lot of benefit in doing this.  Having some form of
> executable I can just run is probably simpler for me to implement than
> trying to unwrap a vmlinux.gz from an envelope, even if that's what
> we're currently booting.  The Xen domain builder simply wants an ELF
> file it can load; if its a self-decompressing kernel image, then that's
> OK.  The only real problem is setting up the initial mappings so that
> the booting code can run as if paging is enabled.  The simplest answer
> to that is to simply 1:1 map all lowmem and set it running, but having
> specific Phdrs laying out the mappings would be a bit more refined.
> 
> Now if the bzImage were simply some 16-bit startup code prepended onto
> a self-decompressing 32-bit ELF kernel file, then that would be fairly
> easy to deal with too, since that would just be a matter of looking at
> the boot_params to find the start of the ELF file and continue from
> there.

You're focusing entirely on Xen here, but if Xen really is the only user
of this, then I say there isn't much benefit into doing this at all.
Hopefully we're trying to solve something bigger than the Xen domain
builder being way too rigidly written, here.

So it really comes down to: what are the bigger problems we're solving?

> I'm not sure why you say that.  Rusty managed to get unmodified
> bzImage's booting in lguest within a few hours of hacking.  I don't
> expect Xen would be much different.

Anything that's a true virtualizer should just be able to load and run a
bzImage file from the 16-bit entrypoint, obviously.  That's not what
Rusty is doing, but all he'd need is the bit (already proposed) to
inhibit cli and segment reloads.

	-hpa
