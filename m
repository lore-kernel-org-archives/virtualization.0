From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 00/11] x86: PIE support to extend KASLR randomization
Date: Tue, 6 Aug 2019 17:43:47 +0200
Message-ID: <20190806154347.GD25897__49045.7789901242$1565106242$gmane$org@zn.tnic>
References: <20190730191303.206365-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
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
Cc: Feng Tang <feng.tang@intel.com>, kristen@linux.intel.com, kernel-hardening@lists.openwall.com, "VMware,
	Inc." <pv-drivers@vmware.com>, virtualization@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <len.brown@intel.com>, keescook@chromium.org, Jann Horn <jannh@google.com>, Alexios Zavras <alexios.zavras@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Juergen Gross <jgross@suse.com>, Maran Wilson <maran.wilson@oracle.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 30, 2019 at 12:12:44PM -0700, Thomas Garnier wrote:
> These patches make some of the changes necessary to build the kernel as
> Position Independent Executable (PIE) on x86_64. Another patchset will
> add the PIE option and larger architecture changes.

Yeah, about this: do we have a longer writeup about the actual benefits
of all this and why we should take this all? After all, after looking
at the first couple of asm patches, it is posing restrictions to how
we deal with virtual addresses in asm (only RIP-relative addressing in
64-bit mode, MOVs with 64-bit immediates, etc, for example) and I'm
willing to bet money that some future unrelated change will break PIE
sooner or later. And I'd like to have a better justification why we
should enforce those new "rules" unconditionally.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
