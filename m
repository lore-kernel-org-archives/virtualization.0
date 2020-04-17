From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 05/70] x86/insn: Make inat-tables.c suitable for
 pre-decompression code
Date: Fri, 17 Apr 2020 15:39:59 +0200
Message-ID: <20200417133959.GE21900@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-6-joro@8bytes.org>
 <20200325153945.GD27261@zn.tnic>
 <20200327120232.c8e455ca100dc0d96e4ddc43@kernel.org>
 <20200416152406.GB4290@8bytes.org>
 <20200417215000.47141001f80005f41153d22e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200417215000.47141001f80005f41153d22e@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 17, 2020 at 09:50:00PM +0900, Masami Hiramatsu wrote:
> On Thu, 16 Apr 2020 17:24:06 +0200
> Joerg Roedel <joro@8bytes.org> wrote:

> Ah, I got it. So you intended to port the instruction decoder to
> pre-decompression boot code, correct?

Right, it is needed there to decode instructions which cause #VC
exceptions when running as an SEV-ES guest.

> > The call-site is added with the patch that includes the
> > instruction decoder into the pre-decompression code. If possible I'd
> > like to keep those things separate, as both patches are already pretty
> > big by themselfes (and they do different things, in different parts of
> > the code).
> 
> OK, if you will send v2, please CC both to me.

Will do, I added you to the cc-list for future posts of this series.


Regards,

	Joerg
