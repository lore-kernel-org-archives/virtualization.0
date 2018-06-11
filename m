From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 6/9] x86: prevent inline distortion by paravirt ops
Date: Mon, 11 Jun 2018 09:45:07 +0200
Message-ID: <20180611074507.GP12258@hirez.programming.kicks-ass.net>
References: <20180610141911.52948-1-namit@vmware.com>
	<20180610141911.52948-7-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180610141911.52948-7-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 10, 2018 at 07:19:08AM -0700, Nadav Amit wrote:
> +/*
> + * This generates an indirect call based on the operation type number.
> + * The type number, computed in PARAVIRT_PATCH, is derived from the
> + * offset into the paravirt_patch_template structure, and can therefore be
> + * freely converted back into a structure offset.
> + */
> +.macro PARAVIRT_ALT type:req clobber:req pv_opptr:req

Unlike the marcro maze you replaced, this has the CALL hardcoded in. So
maybe name this PARAVIRT_CALL instead of PARAVIRT_ALT ?

> +771:	ANNOTATE_RETPOLINE_SAFE
> +	call *\pv_opptr
> +772:	.pushsection .parainstructions,"a"
> +	_ASM_ALIGN
> +	_ASM_PTR 771b
> +	.byte \type
> +	.byte 772b-771b
> +	.short \clobber
> +	.popsection
> +.endm
