From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Tue, 3 Mar 2020 10:55:14 +0100
Message-ID: <20200303095514.GA2596@hirez.programming.kicks-ass.net>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <202003022100.54CEEE60F@keescook>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: kristen@linux.intel.com, kernel-hardening@lists.openwall.com, "VMware,
 Inc." <pv-drivers@vmware.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, virtualization@lists.linux-foundation.org, Thomas Garnier <thgarnie@chromium.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-crypto@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Cao jin <caoj.fnst@cn.fujitsu.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Juergen
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
> On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> > Minor changes based on feedback and rebase from v10.
> > 
> > Splitting the previous serie in two. This part contains assembly code
> > changes required for PIE but without any direct dependencies with the
> > rest of the patchset.
> > 
> > Note: Using objtool to detect non-compliant PIE relocations is not yet
> > possible as this patchset only includes the simplest PIE changes.
> > Additional changes are needed in kvm, xen and percpu code.
> > 
> > Changes:
> >  - patch v11 (assembly);
> >    - Fix comments on x86/entry/64.
> >    - Remove KASLR PIE explanation on all commits.
> >    - Add note on objtool not being possible at this stage of the patchset.
> 
> This moves us closer to PIE in a clean first step. I think these patches
> look good to go, and unblock the work in kvm, xen, and percpu code. Can
> one of the x86 maintainers pick this series up?

But,... do we still need this in the light of that fine-grained kaslr
stuff?

What is the actual value of this PIE crud in the face of that?
