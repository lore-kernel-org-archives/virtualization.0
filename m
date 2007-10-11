From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC REPOST 1/2] paravirt: refactor struct paravirt_ops into smaller pv_*_ops
Date: Fri, 12 Oct 2007 00:01:51 +1000
Message-ID: <200710120001.52456.rusty@rustcorp.com.au>
References: <470BC758.1030504@goop.org> <200710101635.10139.rusty@rustcorp.com.au> <470D13CA.3000202@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757593AbXJKOC1@vger.kernel.org>
In-Reply-To: <470D13CA.3000202@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@qumranet.com>, Glauber de Oliveira Costa <glommer@gmail.com>, "Nakajima, Jun" <jun.nakajima@intel.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 11 October 2007 04:02:50 Jeremy Fitzhardinge wrote:
> >>  struct paravirt_ops paravirt_ops = {
> >
> > ...
> >
> >> +	.pv_info = {
> >> +		.name = "bare hardware",
> >> +		.paravirt_enabled = 0,
> >> +		.kernel_rpl = 0,
> >> +		.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
> >> +	},
> >
> > This is the bit I don't get.  Why not just declare struct pv_info pvinfo,
> > etc, and use the declaration of struct paravirt_ops to get your unique
> > offset-based identifiers for patching?
>
> Given an op id number in .parainstructions, the patching code needs to
> be able to index into something to get the corresponding function
> pointer.  If each pv_* structure is its own little unrelated structure,
> then the id has to be a <structure, id> tuple, which just complicates
> things.  If I pack them all into a single structure then it becomes a
> simple offset calculation.

	Sure, but this can actually be a temporary thing inside the patch code (or at 
least static to that file if it's too big for the stack).

	struct paravirt_ops patch_template = { .pv_info = pv_info, .pv_cpu_ops = 
pv_cpu_ops, ... };

	Then you can even rename struct paravirt_ops to "struct patch_template" and 
we're well on the way to making this a generic function-call patching 
mechanism, rather than something paravirt-specific.

Hope that clarifies my thinking...
Rusty.
