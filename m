From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC REPOST 1/2] paravirt: refactor struct paravirt_ops into smaller pv_*_ops
Date: Wed, 10 Oct 2007 16:35:09 +1000
Message-ID: <200710101635.10139.rusty@rustcorp.com.au>
References: <470BC758.1030504@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755478AbXJJGfm@vger.kernel.org>
In-Reply-To: <470BC758.1030504@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 10 October 2007 04:24:24 Jeremy Fitzhardinge wrote:
> [ I think this is a straight repost this patch, which addresses all the
> previous comments.  I'd like to submit this for .24 as the basis for a
> unified paravirt_ops.  Any objections? ]

Thanks Jeremy, I've actually taken time to finally review this in detail (I'm 
assuming you'll refactor as necessary after the x86 arch merger).

> +	OFFSET(PARAVIRT_enabled, pv_info, paravirt_enabled);

I think this gives the right answer for the wrong reasons?

> +struct paravirt_ops paravirt_ops;
> +

Do you actually need to define this?  See below...

> +DEF_NATIVE(, ud2a, "ud2a");

Hmm, that's ugly.  It was ugly before, but it's uglier now.  Maybe just 
use "unsigned char ud2a[] = { 0x0f, 0x0b };" in paravirt_patch_default?

>  }
>
>  struct paravirt_ops paravirt_ops = {
...
> +	.pv_info = {
> +		.name = "bare hardware",
> +		.paravirt_enabled = 0,
> +		.kernel_rpl = 0,
> +		.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
> +	},

This is the bit I don't get.  Why not just declare struct pv_info pvinfo, etc, 
and use the declaration of struct paravirt_ops to get your unique 
offset-based identifiers for patching?

Rest looks fine...

Thanks!
Rusty.
