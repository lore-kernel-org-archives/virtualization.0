From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument
	registers to <asm/asm.h>
Date: Thu, 21 Jun 2018 14:28:11 +0200
Message-ID: <20180621122811.GA25066__23629.6869851232$1529584355$gmane$org@gmail.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
	<20180613210518.113983-3-ndesaulniers@google.com>
	<b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
	<CAKwvOdngs8k_T=nDKh8JYdAwwFoJRcCU0bZu0tJHQ+keZ5+RFQ@mail.gmail.com>
	<deb5a074-b057-9388-4ab7-42295b5bb46c@zytor.com>
	<CAKwvOdmE-EHJY7tgzkhyQqNT3m3oWtd6iE3sWBTz19Rijzx4Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdmE-EHJY7tgzkhyQqNT3m3oWtd6iE3sWBTz19Rijzx4Ew@mail.gmail.com>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, andrea.parri@amarulasolutions.com, linux-efi@vger.kernel.org, brijesh.singh@amd.com, "J. Kiszka" <jan.kiszka@siemens.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>, jarkko.sakkinen@linux.intel.com, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Manoj Gupta <manojgupta@google.com>, hpa@zytor.com, boris.ostrovsky@oracle.com, Thiebaud Weksteen <tweek@google.com>, mawilcox@microsoft.com, x86@kernel.org, akataria@vmware.com, Greg Hackmann <ghackmann@google.com>, mingo@redhat.com, Alistair Strachan <astrachan@google.com>, David Rientjes <rientjes@google.com>, geert@linux-m68k.org, thomas.lendacky@amd.com, Arnd Bergmann <arnd@arndb.de>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, rostedt@goodmis.org
List-Id: virtualization@lists.linuxfoundation.org


* Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Jun 14, 2018 at 5:17 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On 06/14/18 13:59, Nick Desaulniers wrote:
> > > On Thu, Jun 14, 2018 at 1:48 PM H. Peter Anvin <hpa@zytor.com> wrote:
> > >>
> > >> On 06/13/18 14:05, Nick Desaulniers wrote:
> > >>> From: "H. Peter Anvin" <hpa@linux.intel.com>
> > >>>
> > >>> i386 and x86-64 uses different registers for arguments; make them
> > >>> available so we don't have to #ifdef in the actual code.
> > >>>
> > >>> Native size and specified size (q, l, w, b) versions are provided.
> > >>>
> > >>> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > >>> Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> > >>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > >>
> > >> I still object to Suggested-by: here.  Sedat did a correction, which is
> > >> a Reviewed-by:, but unless I'm completely out to sea, there was no
> > >> suggestion on Sedat's part of this; and I had certainly not seen it when
> > >> I wrote the code.
> > >
> > > I'm fine with changing it from a Suggested-by to a Reviewed-by.  Can
> > > you do that when you apply the set, or should I send a v6?
> > >
> >
> > I'm not handling patch mechanics for x86 at the moment.
> 
> Hi Ingo and Thomas,
> Have you had a chance to review this patch series for application?
> 
> Note that Juergen (the paravirt maintainer) acked the series:
> https://bugs.llvm.org/show_bug.cgi?id=37880
> The only issue being swapping a Suggested-by for a Reviewed-by tag for
> one commit, as above.

Could you please update the series with all suggestions and tags and send a new 
series?

Thanks,

	Ingo
