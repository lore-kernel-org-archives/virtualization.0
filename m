From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch rfc wip] first cut of ELF bzImage
Date: Thu, 31 May 2007 12:27:43 -0700
Message-ID: <465F21AF.3080501@zytor.com>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Vivek Goyal <vgoyal@in.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> 
> Right now I suspect that changing the decompressor in the bzImage so
> that we are decompressing a vmlinux and then loading that could be a
> pain.  At the moment we don't have code on the table for that.
> 

Architecture comes before code.  Just saying "well, we have code for X"
is how you end up with a collected pile of crap.  Sorry.  Having said
that, I recently enough wrote code to do this kind of stuff that I feel
confident to say it's not hard.

> Further if we manually roll our own headers and are not slaves to
> binutils we get a level of control that we might not have otherwise,
> and that we may need.
>
> In particular we can set ET_DYN and set physical == virtual with no
> bad effects.  binutils won't let us set ET_DYN on the program header
> when we are ``relocatable'' because it doesn't understand our what
> we are doing to make the kernel load time relocatable.  We can't set
> physical == virtual on vmlinux or we would not be able to debug the
> loaded kernel.  Setting physical == virtual in the bootloader context
> removes one area of ambiguity.

Now you're talking about how to implement the linker.  I think that's a
secondary issue.

> The 16bit startup code at this point is modestly interesting,
> and I think we should have a standard way to find it so that
> bootloaders that want to use advanced features that can use
> it have the option.   However there is a very common intersection
> between pc's without an x86 BIOS (so we can't run 16bit code) and
> bootloaders doing things differently. 

Without any concept of what those "advanced features" are, we're just
designing blind.  The only "advanced feature" I can think of that would
be applicable is relocation, and that one is already taken care of.

>> Anything that's a true virtualizer should just be able to load and run a
>> > bzImage file from the 16-bit entrypoint, obviously.  That's not what
>> > Rusty is doing, but all he'd need is the bit (already proposed) to
>> > inhibit cli and segment reloads.
> 
> The refined bit of more accurate headers reporting which memory the kernel
> can use before it runs may be nice, and in there.

"May be nice" is pretty darn weak.  This all seems to come down to not
really thinking through the various use cases and what the overarching
architecture really needs to look like.

I personally suspect that the intersection of loaders that want to do
protected-mode/long-mode entry and the ones that have any use of these
"advanced features" you mention is, in fact, zero.  At that point, it
seems that what you really want is vmlinux.gz (whether or not it's
produced by binutils is another matter entirely.)  Users find it
frustrating to have "the kernel" be different from situations that want
vmlinux from the ones that want bzImage; what I'm suggesting is that
they can have it both ways.

	-hpa
