From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v8 00/11] x86: PIE support to extend KASLR randomization
Date: Tue, 30 Jul 2019 12:09:42 -0700
Message-ID: <CAJcbSZEZNk-YoE-dH=N1QpAeUdzm9wGpEqU644bO30WmYcnCtQ__43906.1099592195$1564514301$gmane$org@mail.gmail.com>
References: <20190708174913.123308-1-thgarnie@chromium.org>
	<201907301100.90BB865078@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201907301100.90BB865078@keescook>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Feng Tang <feng.tang@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Herbert Xu <herbert@gondor.apana.org.au>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>, Jann Horn <jannh@google.com>, Alexios Zavras <alexios.zavras@intel.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, Maran Wilson <maran.wilson@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rj>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 30, 2019 at 11:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 08, 2019 at 10:48:53AM -0700, Thomas Garnier wrote:
> > Splitting the previous series in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
> >
> > Changes:
> >  - patch v8 (assembly):
> >    - Fix issues in crypto changes (thanks to Eric Biggers).
> >    - Remove unnecessary jump table change.
> >    - Change author and signoff to chromium email address.
>
> With -rc2 done, is this a good time for this to land in -tip? Are there
> more steps needed for review?

I have a minor feedback and rebase that I am about to send (v9). It
seems like a good one to send to tip if there is no major feedback.

>
> Thanks!
>
> -Kees
>
> >  - patch v7 (assembly):
> >    - Split patchset and reorder changes.
> >  - patch v6:
> >    - Rebase on latest changes in jump tables and crypto.
> >    - Fix wording on couple commits.
> >    - Revisit checkpatch warnings.
> >    - Moving to @chromium.org.
> >  - patch v5:
> >    - Adapt new crypto modules for PIE.
> >    - Improve per-cpu commit message.
> >    - Fix xen 32-bit build error with .quad.
> >    - Remove extra code for ftrace.
> >  - patch v4:
> >    - Simplify early boot by removing global variables.
> >    - Modify the mcount location script for __mcount_loc intead of the address
> >      read in the ftrace implementation.
> >    - Edit commit description to explain better where the kernel can be located.
> >    - Streamlined the testing done on each patch proposal. Always testing
> >      hibernation, suspend, ftrace and kprobe to ensure no regressions.
> >  - patch v3:
> >    - Update on message to describe longer term PIE goal.
> >    - Minor change on ftrace if condition.
> >    - Changed code using xchgq.
> >  - patch v2:
> >    - Adapt patch to work post KPTI and compiler changes
> >    - Redo all performance testing with latest configs and compilers
> >    - Simplify mov macro on PIE (MOVABS now)
> >    - Reduce GOT footprint
> >  - patch v1:
> >    - Simplify ftrace implementation.
> >    - Use gcc mstack-protector-guard-reg=%gs with PIE when possible.
> >  - rfc v3:
> >    - Use --emit-relocs instead of -pie to reduce dynamic relocation space on
> >      mapped memory. It also simplifies the relocation process.
> >    - Move the start the module section next to the kernel. Remove the need for
> >      -mcmodel=large on modules. Extends module space from 1 to 2G maximum.
> >    - Support for XEN PVH as 32-bit relocations can be ignored with
> >      --emit-relocs.
> >    - Support for GOT relocations previously done automatically with -pie.
> >    - Remove need for dynamic PLT in modules.
> >    - Support dymamic GOT for modules.
> >  - rfc v2:
> >    - Add support for global stack cookie while compiler default to fs without
> >      mcmodel=kernel
> >    - Change patch 7 to correctly jump out of the identity mapping on kexec load
> >      preserve.
> >
> > These patches make some of the changes necessary to build the kernel as
> > Position Independent Executable (PIE) on x86_64. Another patchset will
> > add the PIE option and larger architecture changes.
> >
> > The patches:
> >  - 1, 3-11: Change in assembly code to be PIE compliant.
> >  - 2: Add a new _ASM_MOVABS macro to fetch a symbol address generically.
> >
> > diffstat:
> >  crypto/aegis128-aesni-asm.S         |    6 +-
> >  crypto/aegis128l-aesni-asm.S        |    8 +--
> >  crypto/aegis256-aesni-asm.S         |    6 +-
> >  crypto/aes-x86_64-asm_64.S          |   45 ++++++++++------
> >  crypto/aesni-intel_asm.S            |    8 +--
> >  crypto/aesni-intel_avx-x86_64.S     |    3 -
> >  crypto/camellia-aesni-avx-asm_64.S  |   42 +++++++--------
> >  crypto/camellia-aesni-avx2-asm_64.S |   44 ++++++++--------
> >  crypto/camellia-x86_64-asm_64.S     |    8 +--
> >  crypto/cast5-avx-x86_64-asm_64.S    |   50 ++++++++++--------
> >  crypto/cast6-avx-x86_64-asm_64.S    |   44 +++++++++-------
> >  crypto/des3_ede-asm_64.S            |   96 ++++++++++++++++++++++++------------
> >  crypto/ghash-clmulni-intel_asm.S    |    4 -
> >  crypto/glue_helper-asm-avx.S        |    4 -
> >  crypto/glue_helper-asm-avx2.S       |    6 +-
> >  crypto/morus1280-avx2-asm.S         |    4 -
> >  crypto/morus1280-sse2-asm.S         |    8 +--
> >  crypto/morus640-sse2-asm.S          |    6 +-
> >  crypto/sha256-avx2-asm.S            |   18 ++++--
> >  entry/entry_64.S                    |   16 ++++--
> >  include/asm/alternative.h           |    6 +-
> >  include/asm/asm.h                   |    1
> >  include/asm/paravirt_types.h        |   25 +++++++--
> >  include/asm/pm-trace.h              |    2
> >  include/asm/processor.h             |    6 +-
> >  kernel/acpi/wakeup_64.S             |   31 ++++++-----
> >  kernel/head_64.S                    |   16 +++---
> >  kernel/relocate_kernel_64.S         |    2
> >  power/hibernate_asm_64.S            |    4 -
> >  29 files changed, 306 insertions(+), 213 deletions(-)
> >
> > Patchset is based on next-20190708.
> >
> >
>
> --
> Kees Cook
