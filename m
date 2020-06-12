From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 59/75] x86/sev-es: Handle MONITOR/MONITORX Events
Date: Fri, 12 Jun 2020 11:25:49 +0200
Message-ID: <20200612092549.GB3701@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-60-joro@8bytes.org>
 <20200520063845.GC17090@linux.intel.com>
 <20200611131045.GE11924@8bytes.org>
 <20200611171305.GJ29918@linux.intel.com>
 <eac2d02f-951c-16d4-d4f7-55357e790bcd@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eac2d02f-951c-16d4-d4f7-55357e790bcd@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 02:33:12PM -0500, Tom Lendacky wrote:
> I don't think there is any guarantee that MONITOR/MWAIT would work within a
> guest (I'd have to dig some more on that to get a definitive answer, but
> probably not necessary to do). As you say, if KVM emulates it as a NOP,
> there's no sense in exposing the GPA - make it a NOP in the handler. I just
> need to poke some other hypervisor vendors and hear what they have to say.

Okay, makes sense. I made monitor/mwait nops in the patch-set.

Regards,

	Joerg
