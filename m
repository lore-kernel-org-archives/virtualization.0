From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Wed, 15 Jul 2020 11:55:56 +0200
Message-ID: <20200715095556.GI10769@hirez.programming.kicks-ass.net>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200715093426.GK16200@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, virtualization@lists.linux-foundation.org, Martin Radev <martin.b.radev@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 11:34:26AM +0200, Joerg Roedel wrote:
> On Wed, Jul 15, 2020 at 11:24:56AM +0200, Peter Zijlstra wrote:
> > Can we get some more words -- preferably in actual code comments, on
> > when exactly #VC happens?
> 
> Sure, will add this as a comment before the actual runtime VC handler.

Thanks!

> > Because the only thing I remember is that #VC could happen on any memop,
> > but I also have vague memories of that being a later extention.
> 
> Currently it is only raised when something happens that the hypervisor
> intercepts, for example on a couple of instructions like CPUID,
> RD/WRMSR, ..., or on MMIO/IOIO accesses.
> 
> With Secure Nested Paging (SNP), which needs additional enablement, a #VC can
> happen on any memory access. I wrote the IST handling entry code for #VC
> with that in mind, but do not actually enable it. This is the reason why
> the #VC handler just panics the system when it ends up on the fall-back
> (VC2) stack, with SNP enabled it needs to handle the SNP exit-codes in
> that path.

And recursive #VC was instant death, right? Because there's no way to
avoid IST stack corruption in that case.
