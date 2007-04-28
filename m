From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 00:52:30 -0700
Message-ID: <4632FD3E.401@goop.org>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>	<4632F0E5.1060508@goop.org>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m18xcdgdus.fsf@ebiederm.dsl.xmission.com>
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
Cc: James.Bottomley@HansenPartnership.com, virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Next time I'm in a really tormenting mood I will fire up my 
> my ibm ps2 with it's 16Mhz 386 and 6MB and verify that all is working
> well there.
>   

Well, that would be interesting. From a subarch perspective, it would
just be the normal default, and in theory it should work fine. But I
suspect the fpu emulator is probably broken, and non-WP is likely to
have rotted, and lots of other things. Is that an MCA machine?

> I really don't think it is ok to be cavalier about anything
> that we actually support.  Usually if we can handle the general
> case it makes for better more maintainable code.
>
> So far the paravirt class of machines seems every bit as much a subarch
> as voyager and every bit as interesting.
>   
Well, not really. The problem with the subarch mechanism is that it
promotes a lot of copied code with small modifications, and so making
changes is the inherently non-general activity of trying to find all the
various copies, work out what subtle differences they have, and try to
make the appropriate changes in each case. This was one of the major
objections to the original Xen-as-subarch patches, and it is the problem
with Voyager. The mass of preprocessor tricks doesn't help either.

Because paravirt_ops is intended to support both native execution as
well as virtualized, and needs to be able to decide at boot time, we've
been careful to use as much common code as possible, and only make
differences where they are really needed. The executed code path for
booting on native hardware is very similar for the CONFIG_PARAVIRT vs
!PARAVIRT cases (which is why bugs like the PSE pagetable setup have
leaked through), but it also means that bugs are more likely to be
found. Virtualized execution is more different, of course, and has fewer
people actually trying it out - this is bad, of course, but at least any
bugs should be fairly self-contained.

>> Are you referring to the PSE pagetable setup problem we've been
>> discussing, or do you have something else in mind?
>>     
>
> That is what I was thinking of in particular.  But I don't currently
> have much faith in the code review process that has been happening
> for paravirt patches.
>   

Getting reviewer attention has obviously been a problem. We've been
trying to come up with good code, and Andi has been doing a fairly good
job of looking over it all, but we're in complex and subtle parts of the
kernel and the more reviewers the better. So I'm very pleased you're
taking the time to look over this.

> Well at least in 2.6.21-rc7-mm2 init_gdt was still static, and
> still in smpboot.c

Yes, there are newer patches in Andi's queue.

Thanks,
J
