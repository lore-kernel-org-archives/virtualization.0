From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
	space.
Date: Sun, 06 Aug 2006 09:17:29 +1000
Message-ID: <1154819850.29151.3.camel@localhost.localdomain>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
	<20060802231912.ed77f930.akpm@osdl.org> <44D1A6B6.8040003@vmware.com>
	<20060803004144.554d9882.akpm@osdl.org> <44D1BAB8.8070509@vmware.com>
	<20060805145840.653912a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20060805145840.653912a2.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@sous-sol.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2006-08-05 at 14:58 -0700, Andrew Morton wrote:
> On Thu, 03 Aug 2006 01:58:32 -0700
> Zachary Amsden <zach@vmware.com> wrote:
> =

> > Add a bootparameter to reserve high linear address space for hypervisor=
s.
> > This is necessary to allow dynamically loaded hypervisor modules, which
> > might not happen until userspace is already running, and also provides a
> > useful tool to benchmark the performance impact of reduced lowmem addre=
ss
> > space.
> =

> Andi has gone and rotorooted the x86 boot parameter handling in there. =


That was me, via Andi, but yep:

> diff -puN arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-hig=
h-linear-address-space arch/i386/kernel/setup.c
> --- a/arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-li=
near-address-space
> +++ a/arch/i386/kernel/setup.c
> @@ -149,6 +149,12 @@ static char command_line[COMMAND_LINE_SI
>  =

>  unsigned char __initdata boot_params[PARAM_SIZE];
>  =

> +static int __init setup_reservetop(char *s)
> +{
> +	return 1;
> +}
> +__setup("reservetop", setup_reservetop);
> +
>  static struct resource data_resource =3D {
>  	.name	=3D "Kernel data",
>  	.start	=3D 0,

Please remove this hunk: it's now junk.

Cheers,
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
