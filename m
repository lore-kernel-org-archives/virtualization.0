From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Mon, 30 Apr 2007 17:35:55 -0600
Message-ID: <m1zm4p1llw.fsf@ebiederm.dsl.xmission.com>
References: <20070428758.455116000@suse.de>
	<20070428175909.1D09D151CA@wotan.suse.de> <46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com> <4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com> <46363A68.6080201@goop.org>
	<m18xc9344o.fsf@ebiederm.dsl.xmission.com> <463670D1.3000003@goop.org>
	<m14pmx31bw.fsf@ebiederm.dsl.xmission.com>
	<463678BA.5080609@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <463678BA.5080609@zytor.com> (H. Peter Anvin's message of "Mon,
	30 Apr 2007 16:16:10 -0700")
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> 
>> I'm tempted to just reload the segments in setup.S, but that might
>> break loadlin support or one of the other bootloaders that starts the
>> kernel in 32bit mode so we need to be careful.
>> 
>
> We already load all the segments in setup.S.  I'm retaining this in my
> rewrite.

Good.  I guess I had moved it there in my last cleanup but I wasn't
brave enough yet to remove the reloads from both version of head.S
yet.

We should probably load the segment registers in trampoline.S as
well that would simplify things a little bit.

> Given that I'm rewriting the whole thing, if there are things you want
> setup.S to do, now is the time to ask.

The big wish list item would be subarch detection (at least if we need
it early).  As we are quickly moving to infrastructure that can runtime
switch between subarch's if we can detect the difference.

For the paravirt subarchitectures we are actually going to skip past
setup.S

So the big thing we need to start doing is to document the 32bit entry
point and what can be expected of it etc, especially in the paravirt
context.  But that isn't a setup.S problem.

Oh.  Yes.  We need a parameter structure in the kernel, that documents
what %esi points to later.  What arguments can be found in the
bootloader data.  If you are playing with setup.S in C that tends to
be a setup.S function.

Andi already has a call to verify_cpu so we abort if the cpu can't
handle our current kernel.  While that is not perfect aborting
gracefully in setup.S is a lot better then a lot of the alternatives.

Mostly what we need is to sort through the requirements of this
next boot protocol revision for paravirt loaders so we can do that
cleanly.  It will probably need a subarch type field and a subarch
data pointer field, but except for being stored in Setup.S that
isn't much of a setup.S problem either.

Eric
