From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/7] paravirtualization: Patch inline replacements for
	common paravirt operations.
Date: Wed, 1 Nov 2006 15:27:15 -0800
Message-ID: <20061101152715.f1f94d5c.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
	<200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
	<1162376894.23462.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1162376894.23462.7.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 01 Nov 2006 21:28:13 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> +void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch =
*end)
> +{
> +	struct paravirt_patch *p;
> +	int i;
> +
> +	for (p =3D start; p < end; p++) {
> +		unsigned int used;
> +
> +		used =3D paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
> +					  p->len);
> +#ifdef CONFIG_DEBUG_KERNEL
> +		/* Deliberately clobber regs using "not %reg" to find bugs. */

That would be considered to be abusive of CONFIG_DEBUG_KERNEL.  A
CONFIG_DEBUG_PARAVIRT which depends on CONFIG_DEBUG_KERNEL would be more
harmonious.
