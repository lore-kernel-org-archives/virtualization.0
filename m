From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v10 10/11] x86/paravirt: Adapt assembly for PIE support
Date: Mon, 23 Dec 2019 18:23:50 +0100
Message-ID: <20191223172350.GH16710__32894.0281224035$1577122231$gmane$org@zn.tnic>
References: <20191205000957.112719-1-thgarnie@chromium.org>
 <20191205000957.112719-11-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191205000957.112719-11-thgarnie@chromium.org>
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
Cc: Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, keescook@chromium.org, kernel-hardening@lists.openwall.com, "VMware,
 Inc." <pv-drivers@vmware.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, kristen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 04, 2019 at 04:09:47PM -0800, Thomas Garnier wrote:
> If PIE is enabled, switch the paravirt assembly constraints to be
> compatible. The %c/i constrains generate smaller code so is kept by
> default.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
> Acked-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt_types.h | 32 +++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)

More missed feedback:

https://lkml.kernel.org/r/CAJcbSZG-JhBC9b1JMv1zq2r5uRQipYLtkNjM67sd7=eqy_iOaA@mail.gmail.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
