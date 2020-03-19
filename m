From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 70/70] x86/sev-es: Add NMI state tracking
Date: Thu, 19 Mar 2020 20:41:31 +0100
Message-ID: <20200319194131.GF611@suse.de>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-71-joro@8bytes.org>
 <d5cdbf9a-2f5f-cb2b-9c52-61fd844e3f3b@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d5cdbf9a-2f5f-cb2b-9c52-61fd844e3f3b@nextfour.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 06:53:29PM +0200, Mika Penttilä wrote:
> > +SYM_CODE_START(sev_es_iret_user)
> 
> 
> What makes kernel jump here? Can't see this referenced from anywhere?

Sorry, it is just a left-over from a previous version of this patch
(which implemented the single-step-over-iret). This label is not used
anymore. The jump to it was in
swapgs_restore_regs_and_return_to_usermode, after checking the
sev_es_in_nmi flag.

Regards,

	Joerg
