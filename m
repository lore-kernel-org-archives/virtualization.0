From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: vdpa: remove unnecessary null check
Date: Tue, 31 Mar 2020 10:35:56 +0800
Message-ID: <32ae2f4c-de7c-050b-85a2-489b6813fd5f@redhat.com>
References: <20200330235040.GA9997@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200330235040.GA9997@embeddedor>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/31 =E4=B8=8A=E5=8D=887:50, Gustavo A. R. Silva wrote:
> container_of is never null, so this null check is
> unnecessary.
>
> Addresses-Coverity-ID: 1492006 ("Logically dead code")
> Fixes: 20453a45fb06 ("vhost: introduce vDPA-based backend")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/vhost/vdpa.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 421f02a8530a..3d2cb811757a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -678,8 +678,6 @@ static int vhost_vdpa_open(struct inode *inode, str=
uct file *filep)
>   	int nvqs, i, r, opened;
>  =20
>   	v =3D container_of(inode->i_cdev, struct vhost_vdpa, cdev);
> -	if (!v)
> -		return -ENODEV;
>  =20
>   	opened =3D atomic_cmpxchg(&v->opened, 0, 1);
>   	if (opened)


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks
