From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Tue, 4 Feb 2020 12:07:00 +0800
Message-ID: <d2babc39-8583-bf06-20d1-1a3be990f711@redhat.com>
References: <20200128033215.GO1870@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200128033215.GO1870@kadam>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc: kbuild-all@lists.01.org, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org


On 2020/1/28 =E4=B8=8A=E5=8D=8811:32, Dan Carpenter wrote:
> Hi Jason,
>
> url:    https://github.com/0day-ci/linux/commits/Jason-Wang/vDPA-suppor=
t/20200117-170243
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git l=
inux-next


Will fix this.

Thanks


>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/virtio/vdpa/vdpa_sim.c:288 vdpasim_alloc_coherent() warn: retur=
ning freed memory 'addr'
>
> # https://github.com/0day-ci/linux/commit/55047769b3e974d68b2aab5ce0022=
459b172a23f
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 55047769b3e974d68b2aab5ce0022459b172a23f
> vim +/addr +288 drivers/virtio/vdpa/vdpa_sim.c
>
> 55047769b3e974 Jason Wang 2020-01-16  263  static void *vdpasim_alloc_c=
oherent(struct device *dev, size_t size,
> 55047769b3e974 Jason Wang 2020-01-16  264  				    dma_addr_t *dma_addr=
, gfp_t flag,
> 55047769b3e974 Jason Wang 2020-01-16  265  				    unsigned long attrs)
> 55047769b3e974 Jason Wang 2020-01-16  266  {
> 55047769b3e974 Jason Wang 2020-01-16  267  	struct vdpa_device *vdpa =3D=
 dev_to_vdpa(dev);
> 55047769b3e974 Jason Wang 2020-01-16  268  	struct vdpasim *vdpasim =3D=
 vdpa_to_sim(vdpa);
> 55047769b3e974 Jason Wang 2020-01-16  269  	struct vhost_iotlb *iommu =3D=
 vdpasim->iommu;
> 55047769b3e974 Jason Wang 2020-01-16  270  	void *addr =3D kmalloc(size=
, flag);
> 55047769b3e974 Jason Wang 2020-01-16  271  	int ret;
> 55047769b3e974 Jason Wang 2020-01-16  272
> 55047769b3e974 Jason Wang 2020-01-16  273  	if (!addr)
> 55047769b3e974 Jason Wang 2020-01-16  274  		*dma_addr =3D DMA_MAPPING_=
ERROR;
> 55047769b3e974 Jason Wang 2020-01-16  275  	else {
> 55047769b3e974 Jason Wang 2020-01-16  276  		u64 pa =3D virt_to_phys(ad=
dr);
> 55047769b3e974 Jason Wang 2020-01-16  277
> 55047769b3e974 Jason Wang 2020-01-16  278  		ret =3D vhost_iotlb_add_ra=
nge(iommu, (u64)pa,
> 55047769b3e974 Jason Wang 2020-01-16  279  					    (u64)pa + size - 1,
> 55047769b3e974 Jason Wang 2020-01-16  280  					    pa, VHOST_MAP_RW);
> 55047769b3e974 Jason Wang 2020-01-16  281  		if (ret) {
> 55047769b3e974 Jason Wang 2020-01-16  282  			kfree(addr);
>                                                                  ^^^^^^=
^^^^^
> 55047769b3e974 Jason Wang 2020-01-16  283  			*dma_addr =3D DMA_MAPPING=
_ERROR;
> 55047769b3e974 Jason Wang 2020-01-16  284  		} else
> 55047769b3e974 Jason Wang 2020-01-16  285  			*dma_addr =3D (dma_addr_t=
)pa;
> 55047769b3e974 Jason Wang 2020-01-16  286  	}
> 55047769b3e974 Jason Wang 2020-01-16  287
> 55047769b3e974 Jason Wang 2020-01-16 @288  	return addr;
>                                                  ^^^^^^^^^^^^
> 55047769b3e974 Jason Wang 2020-01-16  289  }
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology=
 Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corp=
oration
>
