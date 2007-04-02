From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 12/17] Consistently wrap paravirt ops callsites to make
	them patchable
Date: Mon, 2 Apr 2007 09:11:50 +0200
Message-ID: <200704020911.50623.ak@suse.de>
References: <20070402055652.610711908@goop.org>
	<20070402055705.090656820@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070402055705.090656820@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 02 April 2007 07:57, Jeremy Fitzhardinge wrote:
> Wrap a set of interesting paravirt_ops calls in a wrapper which makes
> the callsites available for patching.  Unfortunately this is pretty
> ugly because there's no way to get gcc to generate a function call,
> but also wrap just the callsite itself with the necessary labels.
> =

> This patch supports functions with 0-4 arguments, and either void or
> returning a value.  64-bit arguments must be split into a pair of
> 32-bit arguments (lower word first).  Small structures are returned in
> registers.

Can you please add some comments to the code explaining this a little?
Best would be perhaps a overview document in Documentation too.

> +#define PVOP_CALL0(__rettype, __op)					\

The __s shouldn't be needed for the macro arguments because
there is no shared name space with the caller.

> +	({								\
> +		__rettype __ret;					\
> +		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
> +			unsigned long long __tmp;			\
> +			unsigned long __ecx;				\
> +			asm volatile(paravirt_alt(PARAVIRT_CALL)	\

Not having the volatile would probably generate better code, but it =

seems much safer for now.

> +				     : "=3DA" (__tmp), "=3Dc" (__ecx)	\
> +				     : paravirt_type(__op),		\
> +				       paravirt_clobber(CLBR_ANY)	\
> +				     : "memory", "cc");			\

And the cc clobber is also not needed

-Andi
