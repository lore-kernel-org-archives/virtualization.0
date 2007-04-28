From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 01:52:30 -0700
Message-ID: <46330B4E.6060608@goop.org>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>	<4632F0E5.1060508@goop.org>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com>	<4632FD3E.401@goop.org>
	<m1zm4sgaqt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1zm4sgaqt.fsf@ebiederm.dsl.xmission.com>
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
> That said any paravirtualized subarch is more different from stock
> x86 then voyager is and in that sense is very much a sub architecture.
>   

Well, a goal was that there should be no downside to enabling
CONFIG_PARAVIRT all the time, even if you don't compile in any
hypervisor support. I think we're close to that now, at least for plain
i386. And while I don't expect it to ever happen, we could get rid of
CONFIG_PARAVIRT fairly easily, and simplify a pile of headers. Maybe it
could happen if it becomes platform_ops.

> I find it distressing that we currently have 2 subarch layers on
> arch/i386.
>
> If you look at alpha, or arm, or  ppc or ia64 they all do
> subarchitectures much better then arch/i386.
>   

Yes. Given that we're starting on i386 and the existing subarch
mechanism is clearly inappropriate for what we want to do, the result is
that we're effectively building a parallel subarch mechanism and when it
becomes capable enough it can take over from the existing one. Its
another example of the earliest adopter gets the cruddiest technology.

> At the same time I find it very distressing how many functions named
> native_xxx we are accumulating.  Especially when all native refers is
> to the default i386 subarch and not to anything particularly native.
> Just one particular way something was implemented.
>   

The native_* stuff came from the need to have some kind of consistent
naming convention, but I agree it probably isn't the best. i386_* or
x86_* might be better for many of them.

> In general I agree that the paravirt_ops are much saner then what we
> have had before but on x86 but they still have a ways to go.
>   

Yep. Like everything else in the kernel, it's an iterative development
process.

> The fact that 2 level or 3 level page tables can't be selected at
> runtime seems to be a failing to think of themselves as a generic 
> a subarch mechanism.  I can't fault you to much for that one as
> that is a little off the beaten path.
>   

That's something I've been thinking about, because Xen requires the
PAEness of the guest to match the hypervisor, so it would be useful to
switch on the fly (not that non-PAE Xen is really a preferred option
these days). Hm... You might be able to do it now by compiling the
kernel in PAE mode, and then have a set of PAE->non-PAE pagetable
operations in paravirt_ops do the conversion. It nearly works, but you'd
ideally want to abstract all the higher-level pagetable walkers rather
than just the get/set pte operations.

> Thanks I think.  I just wish the thing that I was finding were more
> subtle.  Code not building?

Well, yes, its a bit embarrassing. I just got some more disk so I can
afford to have a few more build trees around.

J
