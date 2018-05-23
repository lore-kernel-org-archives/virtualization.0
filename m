From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 23/27] x86/modules: Adapt module loading for PIE support
Date: Wed, 23 May 2018 15:01:38 -0700
Message-ID: <CAJcbSZHPc2w7g8Q4UZV3sx=s6LVL_+dsomro7to6RNhd-4F4Ag__35429.611898917$1527112816$gmane$org@mail.gmail.com>
References: <20180523195421.180248-1-thgarnie@google.com>
	<20180523195421.180248-24-thgarnie@google.com>
	<168ebedb-7c27-d1f3-c2f9-223d44186a52@infradead.org>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <168ebedb-7c27-d1f3-c2f9-223d44186a52@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, the arch/x86 maintainers <x86@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>, Christopher Li <sparse@chrisli.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, LKML <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jan Beulich <JBeulich@suse.com>, Pavel Machek <pavel@ucw.cz>, "H . Peter Anvin" <hpa@zytor.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Christoph Lameter <cl@linux.com>, Alok Kataria <akataria@vmware.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Herbert Xu <herbert@gondor.apan>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 23, 2018 at 2:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,

> (for several patches in this series:)
> The commit message is confusing.  See below.

Thanks for the edits, I will change the different commit messages.



> On 05/23/2018 12:54 PM, Thomas Garnier wrote:
> > Adapt module loading to support PIE relocations. Generate dynamic GOT if
> > a symbol requires it but no entry exist in the kernel GOT.

>                                      exists

> >
> > Position Independent Executable (PIE) support will allow to extended the

>                                                  will allow us to extend
the

> > KASLR randomization range below the -2G memory limit.

> Does that say "below th negative 2G memory limit"?
> I don't get it.

Yes, below 0xffffffff80000000 basically. I think I will just say that.



> >
> > Signed-off-by: Thomas Garnier <thgarnie@google.com>
> > ---
> >  arch/x86/Makefile               |   4 +
> >  arch/x86/include/asm/module.h   |  11 ++
> >  arch/x86/include/asm/sections.h |   4 +
> >  arch/x86/kernel/module.c        | 181 +++++++++++++++++++++++++++++++-
> >  arch/x86/kernel/module.lds      |   3 +
> >  5 files changed, 198 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/x86/kernel/module.lds


> Thanks,
> --
> ~Randy



-- 
Thomas
