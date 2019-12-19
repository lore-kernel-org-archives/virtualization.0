From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v10 00/11] x86: PIE support to extend KASLR randomization
Date: Thu, 19 Dec 2019 08:35:25 -0800
Message-ID: <CAJcbSZEubkFN0BLugoBm8fsPrNWxfFCDytC3nYUepr74dQFS=w__49754.8190922075$1576773844$gmane$org@mail.gmail.com>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191219133452.GM2827@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191219133452.GM2827@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, "VMware,
 Inc." <pv-drivers@vmware.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, virtualization@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, Will Deacon <will@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kees Cook <keescook@chromium.org>, Linux PM list <linux-pm@vger.kernel.org>, Alexios Zavras <alexios.zavras@intel.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, All
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 19, 2019 at 5:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 04, 2019 at 04:09:37PM -0800, Thomas Garnier wrote:
> > Minor changes based on feedback and rebase from v9.
> >
> > Splitting the previous serie in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
>
> ISTR suggestion you add an objtool pass that verifies there are no
> absolute text references left. Otherwise we'll forever be chasing that
> last one..

Correct, I have a reference in the changelog saying I will tackle in
the next patchset because we still have non-pie references in other
places but the fix is a bit more complex (for exemple per-cpu) and not
included in this phase. I will add a better explanation in the next
message for patch v11.
