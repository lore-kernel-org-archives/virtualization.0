From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Mon, 30 Apr 2007 13:03:15 +1000
Message-ID: <1177902195.30071.203.camel__22171.4372783483$1177902265$gmane$org@localhost.localdomain>
References: <20070428758.455116000@suse.de>
	<20070428175909.1D09D151CA@wotan.suse.de> <46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com> <4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
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
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-04-29 at 09:11 -0600, Eric W. Biederman wrote:
>   Right now I'm a little frustrated that insanity below slipped into
>   head.S right after the 32bit entry point after the review said
>   use the normal linux parameters for parameter passing.
>   
>   > #ifdef CONFIG_PARAVIRT
>   >         movl %cs, %eax
>   >         testl $0x3, %eax
>   >         jnz startup_paravirt
>   > #endif
>   
>   The whole thing should be based on a value in the linux parameter block
>   pointed to by %esi, instead of the insane preserve all registers and
>   attempt to be super compatible with everyone.

Dammit, Eric, you spend a lot of time using words like "insane" where
you mean we didn't do everything all at once.

It's *not* clear that using %esi is sane, but nothing in the current
code prevents that.

I was trying to get Xen to use this entry point rather than their own: I
failed, and only lguest now uses it.

Fortunately, this also means it's trivial to change.
Rusty.
