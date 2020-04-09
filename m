From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vdpa: Fix pointer math bug in vdpasim_get_config()
Date: Thu, 9 Apr 2020 10:06:35 +0800
Message-ID: <d463d227-92ff-d35f-6b3c-b86b85613da1@redhat.com>
References: <20200406144552.GF68494@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20200406144552.GF68494@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/6 =E4=B8=8B=E5=8D=8810:45, Dan Carpenter wrote:
> If "offset" is non-zero then we end up copying from beyond the end of
> the config because of pointer math.  We can fix this by casting the
> struct to a u8 pointer.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Is it really worth letting people specify the offset?
>
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> index b3c800653056..e03c25765513 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -509,7 +509,7 @@ static void vdpasim_get_config(struct vdpa_device *=
vdpa, unsigned int offset,
>   	struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>  =20
>   	if (offset + len < sizeof(struct virtio_net_config))
> -		memcpy(buf, &vdpasim->config + offset, len);
> +		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
>   }
>  =20
>   static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int=
 offset,


Acked-by: Jason Wang <jasowang@redhat.com>
