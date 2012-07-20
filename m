From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: hv: use Linux version in guest ID
Date: Fri, 20 Jul 2012 08:26:50 -0700
Message-ID: <20120720152650.GA5201@kroah.com>
References: <87fw8mlv7e.fsf@nemi.mork.no>
 <1342771388-24389-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1342771388-24389-1-git-send-email-bjorn@mork.no>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: KY Srinivasan <kys@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 20, 2012 at 10:03:08AM +0200, Bj=F8rn Mork wrote:
> Use OS version number in the guest ID as recommended by Microsoft
>=20
> Signed-off-by: Bj=F8rn Mork <bjorn@mork.no>
> ---
> So how about something like this?  Yes, I know including
> linux/version.h often is unwanted, but the spec does
> recommend using the actual OS version in the guest ID
>=20
> Yes, this will be offensive again when Linux is at=20
> version 181.0, but we might have found a better solution by
> then :-)
>=20
>=20
>  drivers/hv/hyperv_vmbus.h |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index b9426a6..cc0c3f0 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -29,6 +29,7 @@
>  #include <asm/sync_bitops.h>
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
> +#include <linux/version.h>
> =20
>  /*
>   * The below CPUID leaves are present if VersionAndFeatures.Hypervis=
orPresent
> @@ -410,10 +411,21 @@ enum {
> =20
>  #define HV_PRESENT_BIT			0x80000000
> =20
> -#define HV_LINUX_GUEST_ID_LO		0x00000000
> -#define HV_LINUX_GUEST_ID_HI		0xB16B00B5
> -#define HV_LINUX_GUEST_ID		(((u64)HV_LINUX_GUEST_ID_HI << 32) | \
> -					   HV_LINUX_GUEST_ID_LO)
> +/* Linux vendor ID allocated by Microsoft */
> +#define HV_LINUX_GUEST_ID_VENDOR	0xB16B
> +
> +/* Creating a guest ID conforming to the encoding recommended by
> + * Microsoft, with variant and build fixed to 0

We could use the kernel build number here as well, if we really wanted
it, right?

Otherwise, I like this patch, KY, any objection to me taking it?

thanks,

greg k-h
