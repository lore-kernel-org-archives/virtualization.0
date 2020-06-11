From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 47/75] x86/sev-es: Add Runtime #VC Exception Handler
Date: Thu, 11 Jun 2020 20:16:41 +0200
Message-ID: <20200611181641.GD12636@suse.de>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-48-joro@8bytes.org>
 <20200523075924.GB27431@zn.tnic>
 <20200611114831.GA11924@8bytes.org>
 <20200611173848.GK29918@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200611173848.GK29918@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 10:38:48AM -0700, Sean Christopherson wrote:
> Isn't it possible for the #VC handler to hit a #PF, e.g. on copy_from_user()
> in insn_fetch_from_user()?  If that happens, what prevents the #PF handler
> from hitting a #VC?  AIUI, do_vmm_communication() panics if the backup GHCB
> is already in use, e.g. #VC->#PF->#VC->NMI->#VC would be fatal.

This would be possible, if the #PF handler is able to trigger a #VC. But
I am not sure how it could, except when it has to call printk.

If #PF can trigger a #VC, then a fix is to further limit the time the
GHCB is active, and make sure there are not faults of any kind when it
actually is active. Then the only vector to care about is NMI. I will
look into that.

Regards,

	Joerg
