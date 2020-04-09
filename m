From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: Signedness bugs in vdpasim_work()
Date: Thu, 9 Apr 2020 10:05:12 +0800
Message-ID: <6d817506-221a-7a50-540d-58ed34a18df3@redhat.com>
References: <20200406144509.GE68494@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20200406144509.GE68494@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/6 =E4=B8=8B=E5=8D=8810:45, Dan Carpenter wrote:
> The "read" and "write" variables need to be signed for the error
> handling to work.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/v=
dpa_sim.c
> index 6e8a0cf2fdeb..b3c800653056 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -132,7 +132,8 @@ static void vdpasim_work(struct work_struct *work)
>   						 vdpasim, work);
>   	struct vdpasim_virtqueue *txq =3D &vdpasim->vqs[1];
>   	struct vdpasim_virtqueue *rxq =3D &vdpasim->vqs[0];
> -	size_t read, write, total_write;
> +	ssize_t read, write;
> +	size_t total_write;
>   	int err;
>   	int pkts =3D 0;
>  =20


Acked-by: Jason Wang <jasowang@redhat.com>
