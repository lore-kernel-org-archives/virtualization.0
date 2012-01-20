From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] xen-blkfront: use bitmap_set() and bitmap_clear()
Date: Sat, 21 Jan 2012 00:27:06 +0900
Message-ID: <CAC5umygu32iS=OaioHYaYtemt7uBOiW51ef7L5UhNPezf3JBsQ@mail.gmail.com>
References: <1327072528-8479-1-git-send-email-akinobu.mita@gmail.com>
	<1327072528-8479-4-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1327072528-8479-4-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

I used Jeremy Fitzhardinge's old email address...

2012/1/21 Akinobu Mita <akinobu.mita@gmail.com>:
> Use bitmap_set and bitmap_clear rather than modifying individual bits
> in a memory region.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Cc: Jeremy Fitzhardinge <jeremy@goop.org>

> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> ---
> =A0drivers/block/xen-blkfront.c | =A0 =A07 +++----
> =A01 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 2f22874..619868d 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -43,6 +43,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/mutex.h>
> =A0#include <linux/scatterlist.h>
> +#include <linux/bitmap.h>
>
> =A0#include <xen/xen.h>
> =A0#include <xen/xenbus.h>
> @@ -177,8 +178,7 @@ static int xlbd_reserve_minors(unsigned int minor, un=
signed int nr)
>
> =A0 =A0 =A0 =A0spin_lock(&minor_lock);
> =A0 =A0 =A0 =A0if (find_next_bit(minors, end, minor) >=3D end) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; minor < end; ++minor)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(minor, minors);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bitmap_set(minors, minor, nr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D 0;
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rc =3D -EBUSY;
> @@ -193,8 +193,7 @@ static void xlbd_release_minors(unsigned int minor, u=
nsigned int nr)
>
> =A0 =A0 =A0 =A0BUG_ON(end > nr_minors);
> =A0 =A0 =A0 =A0spin_lock(&minor_lock);
> - =A0 =A0 =A0 for (; minor < end; ++minor)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(minor, minors);
> + =A0 =A0 =A0 bitmap_clear(minors, =A0minor, nr);
> =A0 =A0 =A0 =A0spin_unlock(&minor_lock);
> =A0}
>
> --
> 1.7.4.4
>
