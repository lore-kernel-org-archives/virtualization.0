From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 00/12] x86: PIE support to extend KASLR randomization
Date: Mon, 10 Jun 2019 14:32:47 -0700
Message-ID: <201906101432.B642E297F__28074.5264770061$1560202382$gmane$org@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Garnier <thgarnie@chromium.org>
Cc: Feng Tang <feng.tang@intel.com>, kristen@linux.intel.com, kernel-hardening@lists.openwall.com, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Jan Beulich <JBeulich@suse.com>, Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>, Jann Horn <jannh@google.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pm@vger.kernel.org, Maran Wilson <maran.wilson@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 20, 2019 at 04:19:25PM -0700, Thomas Garnier wrote:
> Splitting the previous serie in two. This part contains assembly code
> changes required for PIE but without any direct dependencies with the
> rest of the patchset.

Thanks for doing this! It should be easier to land the "little" fixes so
there's less to review for the big PIE changes down the road.

-- 
Kees Cook
