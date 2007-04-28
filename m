From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 01:25:15 -0600
Message-ID: <m18xcdgdus.fsf@ebiederm.dsl.xmission.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<4632F0E5.1060508@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4632F0E5.1060508@goop.org> (Jeremy Fitzhardinge's message of
	"Fri, 27 Apr 2007 23:59:49 -0700")
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
Cc: James.Bottomley@HansenPartnership.com, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Eric W. Biederman wrote:
>> Guys currently I am horrified by the ease at which I can find
>> bugs in the pending paravirtualization patches.  I have barely
>> even looked at arch/i386 in the -mm tree and it feels like
>> I am tripping over significant bugs left and right.
>>   
>
> Well, I appreciate any and all review comments you have to make.
>
>> Because no one has heeded my advice and put in a proper platform
>> layer on arch/i386 and we are instead doing a half baked job
>> with paravirt_ops it is still trivially easy to miss the
>> fact that subarchitectures do something different, and thus
>> it is easy to miss when you break a sub architecture on
>> arch/i386.
>>   
>
> Yes. Though in many ways paravirt_ops is approaching that platform
> layer. In the next round of work, it might be worth renaming it and
> actually using it to subsume the subarch mechanism into something that
> can deal with any architecture at runtime. While this hasn't been an
> explicit goal of the current round of work, I've tried to point things
> in that direction where I can (smp_ops and reboot_ops being specific
> examples of that).

Good.  We should do that or at the very least cleanup the 
subarchitecture support on arch/i386.


> But you're right; we've been fairly cavalier about Voyager in
> particular, with the hope that James' machine will die before he notices
> we've broken the build. (Or perhaps it has, and he just keeps building
> voyager kernels to torment us.)

Next time I'm in a really tormenting mood I will fire up my 
my ibm ps2 with it's 16Mhz 386 and 6MB and verify that all is working
well there.

I really don't think it is ok to be cavalier about anything
that we actually support.  Usually if we can handle the general
case it makes for better more maintainable code.

So far the paravirt class of machines seems every bit as much a subarch
as voyager and every bit as interesting.

>> Not that the paravirtuailzation patches are even safe on the
>> primary arch/i386.
>>   
>
> Are you referring to the PSE pagetable setup problem we've been
> discussing, or do you have something else in mind?

That is what I was thinking of in particular.  But I don't currently
have much faith in the code review process that has been happening
for paravirt patches.

>> Rusty do you think you can address this?
>
> Well, it will probably need to be done after the following patches which
> get rid of the PDA altogether. But the boot-time setup is now pretty
> simple, so it should just be a matter of putting a couple of init_gdts
> in the right places. (It is non-static now too.)

Well at least in 2.6.21-rc7-mm2 init_gdt was still static, and
still in smpboot.c

Eric
