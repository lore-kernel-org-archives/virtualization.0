From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 6/7] i386: make the bzImage payload an ELF file
Date: Wed, 06 Jun 2007 18:01:30 -0700
Message-ID: <466758EA.1070501__20700.4617820077$1181178179$gmane$org@goop.org>
References: <20070606225837.654272428@goop.org>
	<20070606230922.476662240@goop.org>
	<4667462A.2010404@zytor.com> <466749C8.2010700@goop.org>
	<46674C96.7090104@zytor.com> <46674F68.6030100@goop.org>
	<4667547B.8080502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4667547B.8080502@zytor.com>
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
Cc: lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> It doesn't if we simply declare that a certain chunk of memory is
> available to it, for the case where it runs in the native configuration.
> Since it doesn't have to support *any* ELF file, just the kernel one,
> that's an option.
>   

I suppose.  But given that its always built at the same time as - and
linked to - the kernel itself, it can have private knowledge about the
kernel.

> On the other hand, I guess with the decompressor/ELF parser being PIC,
> one would simply look for the highest used address, and relocate itself
> above that point.  It's not really all that different from what the
> decompressor does today, except that it knows the address a priori.
>   

Yes, it would have to decompress the ELF file into a temp buffer, and
then rearrange itself and the decompressed ELF file to make space for
the ELF file's final location.  Seems a bit more complex because it has
to be done in the middle of execution rather that at start of day.  But
perhaps that doesn't matter very much.

>> I was thinking of making the ELF file entirely descriptive, since its
>> just a set of ELF headers inserted into the existing bzImage structure,
>> and it still relies on the bzImage being build properly in the first place.
>>     
>
> Again, it's an option.  The downside is that you don't get the automatic
> test coverage of having it be exercised as often as possible.

I don't follow your argument at all.

I'm proposing the kernel take the same code path regardless of how its
booted, with the only two variations:

   1. boot all the way up from 16-bit mode, or
   2. start directly in 32-bit mode

which is essentially the current situation (setup vs code32_start).  All
I'm adding is a bit more metadata for the domain builder to work with. 
The code will get exercised on every boot in every environment, and the
metadata will be tested by whichever environment cares about it.

You're proposing that we add a third booting variation, where the
bootloader takes on the responsibility for decompressing and loading the
kernel's ELF image.  In addition, you're proposing changing the existing
32-bit portion of the boot to perform the same job as the third method,
but in a way which is not reusable by a paravirtual domain builder. 
This means that the boot path is unique for each boot environment, and
so will overall get less coverage.

Given that one axis of the test matrix - "number of subarchtectures" -
is the same in both cases, and the other axis - "number of ways of
booting" - is larger in your proposal, it seems to me that your's has
the higher testing burden.

Anyway, I added an extra pointer in the boot_params so that you can
implement it that way if you really want (no real reason you can have
ELF within ELF within bzImage, but it starts to look a bit
engineering-by-compromise at that point).  It isn't, however, the
approach I want to take with Xen.

    J
