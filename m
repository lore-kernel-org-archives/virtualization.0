From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] x86: paravirt: make native_save_fl extern inline
Date: Tue, 5 Jun 2018 23:28:54 +0200
Message-ID: <CAK8P3a0v6sr_oZmYTZV7E-uJ8JdG6D8JqUesHDPkPY2UrWKdvw__25041.8113232174$1528234025$gmane$org@mail.gmail.com>
References: <20180605170532.170361-1-ndesaulniers@google.com>
	<20180605170532.170361-3-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180605170532.170361-3-ndesaulniers@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>, Will Deacon <will.deacon@arm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, manojgupta@google.com, "H. Peter Anvin" <hpa@zytor.com>, akataria@vmware.com, tweek@google.com, mawilcox@microsoft.com, the arch/x86 maintainers <x86@kernel.org>, Greg Hackmann <ghackmann@google.com>, Matthias Kaehlcke <mka@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, David Rientjes <rientjes@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Lendacky,
	Thomas" <thomas.lendacky@amd.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Kees Cook <keescook@google.com>, Steven Rostedt <rostedt@goodmis.org>, Cao jin <caoj.f>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 5, 2018 at 7:05 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The semantics of extern inline has changed since gnu89. This means that
> folks using GCC versions >= 5.1 may see symbol redefinition errors at
> link time for subdirs that override KBUILD_CFLAGS (making the C standard
> used implicit) regardless of this patch. This has been cleaned up
> earlier in the patch set, but is left as a note in the commit message
> for future travelers.

I think the keyword you are missing is

__attribute__((gnu_inline))

which forces the gnu89 behavior on all compiler versions. It's been supported
since gcc-4.2, so it should not cause problems on any compiler that is able
to build an x86 kernel.

       Arnd
