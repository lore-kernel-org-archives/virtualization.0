From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] XEN: remove undefined functions
Date: Tue, 25 Aug 2009 09:32:10 -0700
Message-ID: <4A94120A.1020301@goop.org>
References: <1251194494.2399.22.camel@Fedora32.jaswinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1251194494.2399.22.camel@Fedora32.jaswinder>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/25/09 03:01, Jaswinder Singh Rajput wrote:
> mk_pirq_info(), gsi_from_irq() and vector_from_irq() are static functio=
ns
> and no one is calling them.
>
> This fixed following compilation warnings :
>
>   drivers/xen/events.c:134: warning: =E2=80=98mk_pirq_info=E2=80=99 def=
ined but not used
>   drivers/xen/events.c:180: warning: =E2=80=98gsi_from_irq=E2=80=99 def=
ined but not used
>   drivers/xen/events.c:190: warning: =E2=80=98vector_from_irq=E2=80=99 =
defined but not used
>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
>  =20

Hm, they're all about to become used.

    J
> ---
>  drivers/xen/events.c |   27 ---------------------------
>  1 files changed, 0 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
> index abad71b..d43957a 100644
> --- a/drivers/xen/events.c
> +++ b/drivers/xen/events.c
> @@ -131,13 +131,6 @@ static struct irq_info mk_virq_info(unsigned short=
 evtchn, unsigned short virq)
>  			.cpu =3D 0, .u.virq =3D virq };
>  }
> =20
> -static struct irq_info mk_pirq_info(unsigned short evtchn,
> -				    unsigned short gsi, unsigned short vector)
> -{
> -	return (struct irq_info) { .type =3D IRQT_PIRQ, .evtchn =3D evtchn,
> -			.cpu =3D 0, .u.pirq =3D { .gsi =3D gsi, .vector =3D vector } };
> -}
> -
>  /*
>   * Accessors for packed IRQ information.
>   */
> @@ -177,26 +170,6 @@ static unsigned virq_from_irq(unsigned irq)
>  	return info->u.virq;
>  }
> =20
> -static unsigned gsi_from_irq(unsigned irq)
> -{
> -	struct irq_info *info =3D info_for_irq(irq);
> -
> -	BUG_ON(info =3D=3D NULL);
> -	BUG_ON(info->type !=3D IRQT_PIRQ);
> -
> -	return info->u.pirq.gsi;
> -}
> -
> -static unsigned vector_from_irq(unsigned irq)
> -{
> -	struct irq_info *info =3D info_for_irq(irq);
> -
> -	BUG_ON(info =3D=3D NULL);
> -	BUG_ON(info->type !=3D IRQT_PIRQ);
> -
> -	return info->u.pirq.vector;
> -}
> -
>  static enum xen_irq_type type_from_irq(unsigned irq)
>  {
>  	return info_for_irq(irq)->type;
>  =20
