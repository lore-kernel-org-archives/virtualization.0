From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 00:52:32 -0700
Message-ID: <465E7EC0.6080108@goop.org>
References: <465E78D2.9080609@goop.org> <465E7CA2.6090201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465E7CA2.6090201@zytor.com>
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
> The more I'm thinking about this whole issue, the more I'm thinking this
> is really misdirected.
>
> I'm starting to think that the right thing to do might very well be as
> follows:
>
> - Change the payload of the bzImage file from a flat binary to an ELF
>   file -- a stripped vmlinux.gz.
> - Change the decompressor to incorporate a (simple) ELF parser.
> - Incorporate a couple of pointer fields in the bzImage header that
>   points directly to the payload, the format of which can be identified
>   via its magic number (currently gzip).
>   

I don't see a lot of benefit in doing this.  Having some form of
executable I can just run is probably simpler for me to implement than
trying to unwrap a vmlinux.gz from an envelope, even if that's what
we're currently booting.  The Xen domain builder simply wants an ELF
file it can load; if its a self-decompressing kernel image, then that's
OK.  The only real problem is setting up the initial mappings so that
the booting code can run as if paging is enabled.  The simplest answer
to that is to simply 1:1 map all lowmem and set it running, but having
specific Phdrs laying out the mappings would be a bit more refined.

Now if the bzImage were simply some 16-bit startup code prepended onto a
self-decompressing 32-bit ELF kernel file, then that would be fairly
easy to deal with too, since that would just be a matter of looking at
the boot_params to find the start of the ELF file and continue from there.

> The more I hear about copying notes and various things from vmlinux to
> bzImage the more I'm convinced that this is a huge kluge.

Copying notes?  I don't think we'll need to do that.  I'll put the Xen
notes on the outermost envelope, but aside from that, there's no need to
copy.  It would definitely be useful to have ELF notes at the same level
as the boot_params block, so that I can use one to find the other.

>   Furthermore,
> there are *definitely* virtual environments which would be much happier
> to be able to decompress in host space.  The decompressor doesn't run
> well in many simulators.

I'm not sure why you say that.  Rusty managed to get unmodified
bzImage's booting in lguest within a few hours of hacking.  I don't
expect Xen would be much different.


    J
