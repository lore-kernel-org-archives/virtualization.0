From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: SVM: Use __packed shorthard
Date: Tue, 24 Mar 2020 13:43:17 +0100
Message-ID: <20200324124317.GA6287@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-2-joro@8bytes.org>
 <20200323132315.GB4649@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200323132315.GB4649@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 23, 2020 at 02:23:15PM +0100, Borislav Petkov wrote:
> I guess we can do that ontop.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 23 Mar 2020 14:20:08 +0100
> 
> ... to make it more readable.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/svm.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Added it to the patch-set, thanks Boris.
