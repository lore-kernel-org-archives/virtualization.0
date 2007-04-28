From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 03:15:33 -0600
Message-ID: <m1k5vwg8qy.fsf@ebiederm.dsl.xmission.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com> <4632FD3E.401@goop.org>
	<200704281042.48440.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281042.48440.ak@suse.de> (Andi Kleen's message of "Sat, 28
	Apr 2007 10:42:48 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen <ak@suse.de> writes:

> On Saturday 28 April 2007 09:52:30 Jeremy Fitzhardinge wrote:
>> Well, not really. The problem with the subarch mechanism is that it
>> promotes a lot of copied code with small modifications, and so making
>> changes is the inherently non-general activity of trying to find all the
>> various copies, work out what subtle differences they have, and try to
>> make the appropriate changes in each case. This was one of the major
>> objections to the original Xen-as-subarch patches, and it is the problem
>> with Voyager. The mass of preprocessor tricks doesn't help either.
>
> Yes I agree. Current i386 subarch is a mess and I hope to slowly phase
> it out. mach-{es7000,summit} should just be folded into mach-generic
> always (like x86-64) and I'm somewhat hoping that mach-voyager and 
> perhaps mach-visws too will just go away at some point.

There is a possibility, that arch/i386 will seen renewed life as an
embedded architecture.  At which point things like mach-visws may
start proliferating.

So I think it makes a lot of sense to see if we can fold mach-visws
and mach-voyager into appropriate pluggable interfaces.

Xen is stranger than anything voyager does.

> The future direction are focussed pluggable interfaces like genapic, smp_ops
> etc.

Sounds good.  Although it may be nice to do the standard platform
trick of having them compile out if you only compile for one
subarchitecture.

Eric
