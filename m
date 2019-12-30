From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v10 00/11] x86: PIE support to extend KASLR randomization
Date: Mon, 30 Dec 2019 10:52:28 -0800
Message-ID: <201912301052.16438D6__26002.3941796803$1577731966$gmane$org@keescook>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191224130310.GE21017@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191224130310.GE21017@zn.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: kristen@linux.intel.com, kernel-hardening@lists.openwall.com, "VMware,
 Inc." <pv-drivers@vmware.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, virtualization@lists.linux-foundation.org, Thomas Garnier <thgarnie@chromium.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-crypto@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Alexios Zavras <alexios.zavras@intel.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Allison Randal <allison@lohutok.net>, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfound>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 24, 2019 at 02:03:10PM +0100, Borislav Petkov wrote:
> On Wed, Dec 04, 2019 at 04:09:37PM -0800, Thomas Garnier wrote:
> > Minor changes based on feedback and rebase from v9.
> > 
> > Splitting the previous serie in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
> 
> Ok, modulo the minor commit message and comments fixup, this looks ok
> and passes testing here.
> 
> I'm going to queue patches 2-11 of the next version unless someone
> complains.

Great! Thanks very much for the reviews. :)

-- 
Kees Cook
