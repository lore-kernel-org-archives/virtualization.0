From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 09/27] x86/acpi: Adapt assembly for PIE support
Date: Fri, 25 May 2018 10:00:04 -0700
Message-ID: <CAJcbSZH17D01Stk4vRKKzjW6dxvK8x+S9sWL6vUopSP9=-x7Nw__13362.2286645279$1527267520$gmane$org@mail.gmail.com>
References: <20180523195421.180248-1-thgarnie@google.com>
	<20180523195421.180248-10-thgarnie@google.com>
	<20180524110306.GA20225@amd>
	<CAJcbSZFJ84+VC5xDQZGHctupdqwmMBgqzLzFRqCTBpi5t-2Gvw@mail.gmail.com>
	<20180525091447.GC9666@amd>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180525091447.GC9666@amd>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, the arch/x86 maintainers <x86@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>, Christopher Li <sparse@chrisli.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, LKML <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jan Beulich <JBeulich@suse.com>, "H . Peter Anvin" <hpa@zytor.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Christoph Lameter <cl@linux.com>, Alok Kataria <akataria@vmware.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Herbert Xu <herbert@gondor.>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 25, 2018 at 2:14 AM Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2018-05-24 09:35:42, Thomas Garnier wrote:
> > On Thu, May 24, 2018 at 4:03 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > > On Wed 2018-05-23 12:54:03, Thomas Garnier wrote:
> > > > Change the assembly code to use only relative references of symbols
for
> > the
> > > > kernel to be PIE compatible.
> > > >
> > > > Position Independent Executable (PIE) support will allow to
extended the
> > > > KASLR randomization range below the -2G memory limit.
> >
> > > What testing did this get?
> >
> > Tested boot, hibernation and performance on qemu and dedicated machine.

> Well, this is suspend, not hibernation code.

> So "sudo pm-suspend" or "echo mem > /sys/power/state" would be good
> way to test this.

Thanks, it worked. I added this to the testsuite I use for KASLR.


> Thanks,
>                                                          Pavel

> > > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S
> > b/arch/x86/kernel/acpi/wakeup_64.S
> > > > index 50b8ed0317a3..472659c0f811 100644
> > > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > > @@ -14,7 +14,7 @@
> > > >        * Hooray, we are in Long 64-bit mode (but still running in
low
> > memory)
> > > >        */
> > > >  ENTRY(wakeup_long64)
> > > > -     movq    saved_magic, %rax
> > > > +     movq    saved_magic(%rip), %rax
> > > >       movq    $0x123456789abcdef0, %rdx
> > > >       cmpq    %rdx, %rax
> > > >       jne     bogus_64_magic
> >
> > > Because, as comment says, this is rather tricky code.
> >
> > I agree, I think maintainers feedback is very important for this
patchset.


> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Thomas
