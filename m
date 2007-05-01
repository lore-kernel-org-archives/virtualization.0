From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Mon, 30 Apr 2007 21:57:05 -0600
Message-ID: <m18xc919im.fsf@ebiederm.dsl.xmission.com>
References: <20070428758.455116000@suse.de>
	<20070428175909.1D09D151CA@wotan.suse.de> <46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com> <4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<1177902195.30071.203.camel@localhost.localdomain>
	<463572B7.90202@zytor.com>
	<1177909434.30071.216.camel@localhost.localdomain>
	<m1ejm16flv.fsf@ebiederm.dsl.xmission.com>
	<1177990722.28659.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177990722.28659.39.camel@localhost.localdomain> (Rusty
	Russell's message of "Tue, 01 May 2007 13:38:42 +1000")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> On Mon, 2007-04-30 at 09:34 -0600, Eric W. Biederman wrote:
>> Reading this it occurs to me what I object to wasn't that clear.
>> 
>> I have no problem with the testing of %cs to see if we are not in ring0.
>> That part while a little odd is fine, and we will certainly need a test
>> to skip the protected instructions in head.S
>> 
>> What I object to in particular is having (struct lguest_info?) instead
>> of using the standard format for kernel parameters pointed to in %esi.
>
> Here's a rough patch to see what it looks like from an lguest POV.  It's
> an improvement in many ways: I chose to hardcode the search for matching
> backend rather than use paravirt_probe-style magic.

Cool.

> It'd be nicer if there were a "struct boot_params" declaration, but we
> can't have everything.

Well it will come.  I have an old one in kexec-tools and HPA looks like
he has one in his C rewrite.

I'm not going to worry about going farther until the patches in flight
settle down a little bit, but this looks promising.

Eric
