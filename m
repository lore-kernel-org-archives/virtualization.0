From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 02:32:26 -0600
Message-ID: <m1zm4sgaqt.fsf@ebiederm.dsl.xmission.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<4632F0E5.1060508@goop.org> <m18xcdgdus.fsf@ebiederm.dsl.xmission.com>
	<4632FD3E.401@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4632FD3E.401@goop.org> (Jeremy Fitzhardinge's message of "Sat,
	28 Apr 2007 00:52:30 -0700")
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
Cc: James.Bottomley@HansenPartnership.com, virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Eric W. Biederman wrote:
>> Next time I'm in a really tormenting mood I will fire up my 
>> my ibm ps2 with it's 16Mhz 386 and 6MB and verify that all is working
>> well there.
>>   
>
> Well, that would be interesting. From a subarch perspective, it would
> just be the normal default, and in theory it should work fine. But I
> suspect the fpu emulator is probably broken, and non-WP is likely to
> have rotted, and lots of other things. Is that an MCA machine?

Yes it's a MCA machine.  And except for some ps2 keyboard issues it
worked last time I tested it.  So earlier in 2.6 it was fine..

It was kind of fun submitting a bug report that the ps2 keyboard
support did not work on a genuine IBM ps2.

>> I really don't think it is ok to be cavalier about anything
>> that we actually support.  Usually if we can handle the general
>> case it makes for better more maintainable code.
>>
>> So far the paravirt class of machines seems every bit as much a subarch
>> as voyager and every bit as interesting.
>>   
> Well, not really. The problem with the subarch mechanism is that it
> promotes a lot of copied code with small modifications, and so making
> changes is the inherently non-general activity of trying to find all the
> various copies, work out what subtle differences they have, and try to
> make the appropriate changes in each case. This was one of the major
> objections to the original Xen-as-subarch patches, and it is the problem
> with Voyager. The mass of preprocessor tricks doesn't help either.

The subarch support on arch/i386 is silly from a maintenance
perspective.  I have had one or two occasions where I have made a
change to the entire kernel and only overlooked the necessary change
on some i386 subarch.

That said any paravirtualized subarch is more different from stock
x86 then voyager is and in that sense is very much a sub architecture.

I find it distressing that we currently have 2 subarch layers on
arch/i386.

If you look at alpha, or arm, or  ppc or ia64 they all do
subarchitectures much better then arch/i386.

The sane pattern is and seems to has always been.

arch_function()
{
        platform_ops.platform_function();
}

And on the nice architectures is you build for one particular subarch
the abstraction goes away.

At the same time I find it very distressing how many functions named
native_xxx we are accumulating.  Especially when all native refers is
to the default i386 subarch and not to anything particularly native.
Just one particular way something was implemented.

> Because paravirt_ops is intended to support both native execution as
> well as virtualized, and needs to be able to decide at boot time, we've
> been careful to use as much common code as possible, and only make
> differences where they are really needed. The executed code path for
> booting on native hardware is very similar for the CONFIG_PARAVIRT vs
> !PARAVIRT cases (which is why bugs like the PSE pagetable setup have
> leaked through), but it also means that bugs are more likely to be
> found. Virtualized execution is more different, of course, and has fewer
> people actually trying it out - this is bad, of course, but at least any
> bugs should be fairly self-contained.

In general I agree that the paravirt_ops are much saner then what we
have had before but on x86 but they still have a ways to go.

The fact that 2 level or 3 level page tables can't be selected at
runtime seems to be a failing to think of themselves as a generic 
a subarch mechanism.  I can't fault you to much for that one as
that is a little off the beaten path.

>>> Are you referring to the PSE pagetable setup problem we've been
>>> discussing, or do you have something else in mind?
>>>     
>>
>> That is what I was thinking of in particular.  But I don't currently
>> have much faith in the code review process that has been happening
>> for paravirt patches.
>>   
>
> Getting reviewer attention has obviously been a problem. We've been
> trying to come up with good code, and Andi has been doing a fairly good
> job of looking over it all, but we're in complex and subtle parts of the
> kernel and the more reviewers the better. So I'm very pleased you're
> taking the time to look over this.

Thanks I think.  I just wish the thing that I was finding were more
subtle.  Code not building?

Eric
