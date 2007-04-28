From: Andi Kleen <ak@suse.de>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 11:34:52 +0200
Message-ID: <200704281134.53160.ak@suse.de>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com> <4632FD3E.401@goop.org>
	<m1zm4sgaqt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1zm4sgaqt.fsf@ebiederm.dsl.xmission.com>
Content-Disposition: inline
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
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


> 
> The sane pattern is and seems to has always been.
> 
> arch_function()
> {
>         platform_ops.platform_function();
> }

Yes agreed. We'll slowly move there. Patches to accelerate it are
welcome (for post .22) 

But you're flaming the wrong person for this really. Jeremy and other
paravirt implementors have  done a lot of work of moving things into this 
direction.

> At the same time I find it very distressing how many functions named
> native_xxx we are accumulating.  Especially when all native refers is
> to the default i386 subarch and not to anything particularly native.
> Just one particular way something was implemented.

How else would you name and/or implement that?

> The fact that 2 level or 3 level page tables can't be selected at
> runtime seems to be a failing to think of themselves as a generic 
> a subarch mechanism.  I can't fault you to much for that one as
> that is a little off the beaten path.

That would really require generic mm changes to do properly. I know
PA-RISC does it without that, but that wouldn't fly on x86 I think
because PAE and non PAE are more different there.

-Andi
