From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH -next] virtio: vdpa: remove unused variables 'ifcvf' and
 'ifcvf_lm'
Date: Tue, 31 Mar 2020 16:11:03 +0800
Message-ID: <a69f59a7-f0cc-6b8b-6c3d-61ef72b3ec38@redhat.com>
References: <20200331080259.33056-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200331080259.33056-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, mst@redhat.com, tiwei.bie@intel.com, lingshan.zhu@intel.com, xiao.w.wang@intel.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/3/31 =E4=B8=8B=E5=8D=884:02, YueHaibing wrote:
> drivers/virtio/vdpa/ifcvf/ifcvf_main.c:34:24:
>   warning: variable =E2=80=98ifcvf=E2=80=99 set but not used [-Wunused-=
but-set-variable]
> drivers/virtio/vdpa/ifcvf/ifcvf_base.c:304:31:
>   warning: variable =E2=80=98ifcvf_lm=E2=80=99 set but not used [-Wunus=
ed-but-set-variable]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/virtio/vdpa/ifcvf/ifcvf_base.c | 2 --
>   drivers/virtio/vdpa/ifcvf/ifcvf_main.c | 2 --
>   2 files changed, 4 deletions(-)
>
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c b/drivers/virtio/vd=
pa/ifcvf/ifcvf_base.c
> index b61b06ea26d3..e24371d644b5 100644
> --- a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/virtio/vdpa/ifcvf/ifcvf_base.c
> @@ -301,12 +301,10 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 q=
id, u64 num)
>  =20
>   static int ifcvf_hw_enable(struct ifcvf_hw *hw)
>   {
> -	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
>   	struct virtio_pci_common_cfg __iomem *cfg;
>   	struct ifcvf_adapter *ifcvf;
>   	u32 i;
>  =20
> -	ifcvf_lm =3D (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
>   	ifcvf =3D vf_to_adapter(hw);
>   	cfg =3D hw->common_cfg;
>   	ifc_iowrite16(IFCVF_MSI_CONFIG_OFF, &cfg->msix_config);
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/virtio/vd=
pa/ifcvf/ifcvf_main.c
> index 8d54dc5b08d2..28d9e5de5675 100644
> --- a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> @@ -31,11 +31,9 @@ static irqreturn_t ifcvf_intr_handler(int irq, void =
*arg)
>   static int ifcvf_start_datapath(void *private)
>   {
>   	struct ifcvf_hw *vf =3D ifcvf_private_to_vf(private);
> -	struct ifcvf_adapter *ifcvf;
>   	u8 status;
>   	int ret;
>  =20
> -	ifcvf =3D vf_to_adapter(vf);
>   	vf->nr_vring =3D IFCVF_MAX_QUEUE_PAIRS * 2;
>   	ret =3D ifcvf_start_hw(vf);
>   	if (ret < 0) {
