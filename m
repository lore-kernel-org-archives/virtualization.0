From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 00/11] x86: PIE support to extend KASLR randomization
Date: Thu, 19 Dec 2019 14:34:52 +0100
Message-ID: <20191219133452.GM2827__38654.0391411231$1576766005$gmane$org@hirez.programming.kicks-ass.net>
References: <20191205000957.112719-1-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Garnier <thgarnie@chromium.org>
Cc: kristen@linux.intel.com, kernel-hardening@lists.openwall.com, "VMware,
 Inc." <pv-drivers@vmware.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, virtualization@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, Will Deacon <will@kernel.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-crypto@vger.kernel.org, Len Brown <len.brown@intel.com>, keescook@chromium.org, linux-pm@vger.kernel.org, Alexios Zavras <alexios.zavras@intel.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Allison Randal <allison@lohutok.net>, Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J. W
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 04, 2019 at 04:09:37PM -0800, Thomas Garnier wrote:
> Minor changes based on feedback and rebase from v9.
> 
> Splitting the previous serie in two. This part contains assembly code
> changes required for PIE but without any direct dependencies with the
> rest of the patchset.

ISTR suggestion you add an objtool pass that verifies there are no
absolute text references left. Otherwise we'll forever be chasing that
last one..
