Received: from baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD738156C8
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: songyang23 <songyang23@baidu.com>, liubokai <liubokai@baidu.com>,
	"Song,Zhan" <songzhan@baidu.com>
Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Topic: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48wACc8LwAALG6zAAAJr3EAAAKxJA
Date: Thu, 11 Jan 2024 11:58:29 +0000
Message-ID: <97deda0df378468bae852859cb1c5317@baidu.com>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
 <PH0PR12MB54813F1133C29AC8FF0097E6DC682@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a26b34bcb1fb4b5d9f64f0f277b8e85d@baidu.com>
 <PH0PR12MB54818702AF205B65C676E68DDC682@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54818702AF205B65C676E68DDC682@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.14
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM



> -----Original Message-----
> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, January 11, 2024 7:55 PM
> To: Li,Rongqing <lirongqing@baidu.com>; mst@redhat.com;
> jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
> virtualization@lists.linux.dev
> Cc: songyang23 <songyang23@baidu.com>; liubokai <liubokai@baidu.com>;
> Song,Zhan <songzhan@baidu.com>
> Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of virtio=
 pci
>=20
>=20
> > From: Li,Rongqing <lirongqing@baidu.com>
> > Sent: Thursday, January 11, 2024 5:18 PM
> >
> >
> > > -----Original Message-----
> > > From: Parav Pandit <parav@nvidia.com>
> > > Sent: Thursday, January 11, 2024 6:18 PM
> > > To: Li,Rongqing <lirongqing@baidu.com>; mst@redhat.com;
> > > jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
> > > virtualization@lists.linux.dev
> > > Cc: songyang23 <songyang23@baidu.com>; liubokai
> > <liubokai@baidu.com>;
> > > Song,Zhan <songzhan@baidu.com>
> > > Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of
> > > virtio pci
> > >
> > >
> > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > Sent: Thursday, January 11, 2024 2:45 PM
> > > >
> > > > Revert "virtio_pci: Support surprise removal of virtio pci device"
> > > >
> > > > This reverts commit 43bb40c5b92659966bdf4bfe584fde0a3575a049.
> > > >
> > > > Marking the device as broken will cause the uncompleted IO request
> > > > on virtio-blk since virtblk_done will not continue when it find
> > > > the broken virtqueu at last it will cause the failure of removal
> > > > of virtio-blk device because of uncompleted IO request
> > > >
> > > > The correct fix for the issue that commit 43bb40c5b9 ("virtio_pci:
> > > > Support surprise removal of virtio pci device") tried to fix is
> > > > that virtio backend always complete the IO request as soon as
> > > > possible
> > > >
> > > This can never be guaranteed by a device and by pci spec given it is
> > > surprise removal by definition.
> > >
> > > For Linux virtio blk is not the only block device which has surprised=
 removal.
> > > Nvme blk driver has supported surprise removal for several years now.
> > > I am sure nbd and others would have too given its network.
> > >
> > > I am not familiar with the blk driver stack.
> > > So please explore with blk community of how to complete an
> > > aborted/never completed io which never completed by the device.
> > > Since the blk driver knows exactly that the device is removed, it
> > > can 100% complete the io to upper layer with the error in determinist=
ic way.
> > >
> >
> >
> > Without the commit 43bb40c5b92("virtio_pci: Support surprise removal
> > of virtio pci device"), My virtio-blk device can be removed
> > successfully, with this commit, and if we use fio to send io requests
> > the virtio-blk, The removal always failed.
> >
> How can it complete when the device is not going complete the io ever?
>=20

Now this issue is that the virtio backend (device) has completed the io req=
uest, but virtio-blk=20
Can not get the completed io request, since the virtqueue is marked as brok=
en.

-Li

> >
> > Once virt queue is marked as broken, io request can not be finished
> > since lots of virtio functions will check If the vq is broken, if
> > broken, exit directly, like virtqueue_get_buf_ctx_packed
> >
> > static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >                       unsigned int *len,
> >                       void **ctx)
> > {
> >     struct vring_virtqueue *vq =3D to_vvq(_vq);
> >     u16 last_used, id, last_used_idx;
> >     bool used_wrap_counter;
> >     void *ret;
> >
> >     START_USE(vq);
> >
> >     if (unlikely(vq->broken)) {
> >         END_USE(vq);
> >         return NULL;
> >     }
> >
> > Nvme is different from virtio, it can ensure that all requests are
> > flushed to completion, like below patch:
> >
> Who is "it" in your above comment? Is it Driver or device?
>=20
> In below commit who (driver/device) flushes the completions?
> If it is device, then it is not surprise removal, right?
>=20
> > commit 1d39e6928cbd0eb737c51545210b5186d5551ba1
> > Author: Keith Busch <keith.busch@intel.com>
> > Date:   Wed Jun 6 08:13:08 2018 -0600
> >
> >     nvme-pci: unquiesce dead controller queues
> >
> >     This patch ensures the nvme namsepace request queues are not
> quiesced
> >     on a surprise removal. It's possible the queues were previously kil=
led
> >     in a failed reset, so the queues need to be unquiesced to ensure al=
l
> >     requests are flushed to completion.
> >
> >     Signed-off-by: Keith Busch <keith.busch@intel.com>
> >     Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> >     Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >
> >
> > -Li

