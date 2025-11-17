Received: from sg-1-105.ptr.blmpb.com (sg-1-105.ptr.blmpb.com [118.26.132.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671525FA13
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349026; cv=none; b=D6JLXFQIHOTdky71lplcvYcFopmuzVnI3ioCiHi1tX31XJ1BWAKwFr7PaWe1owLzl73fiGHb0ahG2gJUu7K0oVXQwRTxXqjtQrLqp/9Xf94dphw/wJHMVflf7iYwAjzTX7aO+NveZ/1UPgb3N2WDAFvK24gJ3W7BtsWvYeDji74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349026; c=relaxed/simple;
	bh=fcYK3e1A3cCAZiBLq2clrt4zSt70xqKP72ZUbNg45DQ=;
	h=Date:To:References:In-Reply-To:Content-Type:Message-Id:Cc:Subject:
	 From:Mime-Version; b=rx+X623frbA+ums0y9x1XMI6u/0zxfo/je8+PPt0BecAk3clHHuaDkCHCQEcUgVjLU02CXbtn7OLkpLpXwRHVQ7bfzuosoKrT4i0HKHXxMXkkoKzjStIdT1eQquz2u06ZTXMrSk6V2hiPRG6d7R9sEt7luACrlkIIX1LMYTNzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R7k6jOBs; arc=none smtp.client-ip=118.26.132.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R7k6jOBs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763349015; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fcYK3e1A3cCAZiBLq2clrt4zSt70xqKP72ZUbNg45DQ=;
 b=R7k6jOBsSYlhul1xx9QyrlVE3cD8Sfn17ijQvsL6Z4BUKbvnVgesLZ0OcRnAkzicvCdERt
 dPu/A3hwvxhgExJlWJqaT6cV5J3UrOd5psXQHvfKUZnXUUl5PoWHcnn90RKCPpHOLk5XeL
 rK8A/1rr5veUf4ZCRxnI0eIQiF4kz2dNh4BUK5x7c3VuZLxQDg6tV2K8OxJppMI4AFpKZd
 qgyPkuFNQWXKGFmKElfk1JSutEcYnpfQbRDrjQT8IDR/lQkI51EncAJez5eaYvoAUuGs+h
 i7TS+8SBdQvp6MpK9R+cAJt9Yvl+WrUI1FiUmUFEJKCpVS343vqfuUWPUSffLg==
Date: Mon, 17 Nov 2025 11:10:12 +0800
To: "Eugenio Perez Martin" <eperezma@redhat.com>
References: <20251113115558.1277981-1-eperezma@redhat.com>
	<20251113115558.1277981-6-eperezma@redhat.com>
In-Reply-To: <20251113115558.1277981-6-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <e1c8f03799732f82abe873d494e50c8d157670ad.a04fe0df.59e1.4e7b.ba43.fc004fb5f4db@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
	"Laurent Vivier" <lvivier@redhat.com>, 
	"virtualization" <virtualization@lists.linux.dev>, 
	"Maxime Coquelin" <mcoqueli@redhat.com>, "Cindy Lu" <lulu@redhat.com>, 
	"Jason Wang" <jasowang@redhat.com>, 
	"linux-kernel" <linux-kernel@vger.kernel.org>, 
	"Eugenio Perez Martin" <eperezma@redhat.com>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, 
	"Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v9 5/6] vduse: add vq group asid support
From: =?utf-8?q?=E8=B0=A2=E6=B0=B8=E5=90=89?= <xieyongji@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+1691a9215+67c8df+lists.linux.dev+xieyongji@bytedance.com>

> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group. =C2=A0This enables mapping each group into a distinct memory space=
.
>=C2=A0
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>=C2=A0
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v9:
> * Replace mutex with RCU, as the vdpa map_ops can run from atomic
> =C2=A0 context.
>=C2=A0
> v8:
> * Revert the mutex to rwlock change, it needs proper profiling to
> =C2=A0 justify it.
>=C2=A0
> v7:
> * Take write lock in the error path (Jason).
>=C2=A0
> v6:
> * Make vdpa_dev_add use gotos for error handling (MST).
> * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
> =C2=A0 (MST).
> * Fix struct name not matching in the doc.
>=C2=A0
> v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
> =C2=A0 ioctl (Jason).
> * Properly set domain bounce size to divide equally between nas (Jason).
> * Exclude "padding" member from the only >V1 members in
> =C2=A0 vduse_dev_request.
>=C2=A0
> v4:
> * Divide each domain bounce size between the device bounce size (Jason).
> * revert unneeded addr =3D NULL assignment (Jason)
> * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> =C2=A0 return; } (Jason)
> * Change a bad multiline comment, using @ caracter instead of * (Jason).
> * Consider config->nas =3D=3D 0 as a fail (Jason).
>=C2=A0
> v3:
> * Get the vduse domain through the vduse_as in the map functions
> =C2=A0 (Jason).
> * Squash with the patch creating the vduse_as struct (Jason).
> * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> =C2=A0 (Jason)
>=C2=A0
> v2:
> * Convert the use of mutex to rwlock.
>=C2=A0
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> =C2=A0 value to reduce memory consumption, but vqs are already limited to
> =C2=A0 that value and userspace VDUSE is able to allocate that many vqs.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> =C2=A0 VDUSE_IOTLB_GET_INFO.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Move the umem mutex to asid struct so there is no contention between
> =C2=A0 ASIDs.
>=C2=A0
> RFC v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> =C2=A0 part of the struct is the same.
> ---
> =C2=A0drivers/vdpa/vdpa_user/vduse_dev.c | 370 ++++++++++++++++++++------=
---
> =C2=A0include/uapi/linux/vduse.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A053 +=
+++-
> =C2=A02 files changed, 314 insertions(+), 109 deletions(-)
>=C2=A0
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 97be04f73fbf..ff95ed56f22d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -11,6 +11,7 @@
> =C2=A0#include "linux/virtio_net.h"
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/rcupdate.h>
> =C2=A0#include <linux/cdev.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/eventfd.h>
> @@ -41,6 +42,7 @@
>=C2=A0
> =C2=A0#define VDUSE_DEV_MAX (1U << MINORBITS)
> =C2=A0#define VDUSE_DEV_MAX_GROUPS 0xffff
> +#define VDUSE_DEV_MAX_AS 0xffff
> =C2=A0#define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> =C2=A0#define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> =C2=A0#define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -86,7 +88,14 @@ struct vduse_umem {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mm_struct *mm;
> =C2=A0};
>=C2=A0
> +struct vduse_as {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_umem *umem;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex mem_lock;
> +};
> +
> =C2=A0struct vduse_vq_group {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as __rcu;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *dev;
> =C2=A0};
>=C2=A0
> @@ -94,7 +103,7 @@ struct vduse_dev {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_vdpa *vdev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_virtqueue **vqs;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *name;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t msg_lock;
> @@ -122,9 +131,8 @@ struct vduse_dev {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vq_num;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vq_align;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 ngroups;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_umem *umem;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 nas;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_vq_group *groups;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex mem_lock;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int bounce_size;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex domain_lock;
> =C2=A0};
> @@ -314,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vduse_dev_msg_sync(dev, &msg);
> =C2=A0}
>=C2=A0
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 start, u64 last)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev_msg msg =3D { 0 };
> @@ -323,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.type =3D VDUSE_UPDATE_IOTLB;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova.start =3D start;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova.last =3D last;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev->api_version < VDUSE_API_VERSION_1) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova.sta=
rt =3D start;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova.las=
t =3D last;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova_v2.=
start =3D start;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova_v2.=
last =3D last;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.iova_v2.=
asid =3D asid;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vduse_dev_msg_sync(dev, &msg);
> =C2=A0}
> @@ -436,14 +450,32 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mask;
> =C2=A0}
>=C2=A0
> +/* Force set the asid to a vq group without a message to the VDUSE devic=
e */
> +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int=
 group, unsigned int asid)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Two concurrent updates to this pointer ar=
e valid as they cannot
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * point to an invalid region. =C2=A0It is o=
k for them to race as long as
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the readers see a consistent state throug=
h RCU.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_assign_pointer(dev->groups[group].as, &d=
ev->as[asid]);
> +}
> +
> =C2=A0static void vduse_dev_reset(struct vduse_dev *dev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain =3D dev->do=
main;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The coherent mappings are handled in=
 vduse_dev_free_coherent() */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (domain && domain->bounce_map)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_res=
et_bounce_map(domain);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < dev->nas; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iov=
a_domain *domain =3D dev->as[i].domain;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (domain && do=
main->bounce_map)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0vduse_domain_reset_bounce_map(domain);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < dev->ngroups; i++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_set_group_=
asid_nomsg(dev, i, 0);
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0down_write(&dev->rwsem);
>=C2=A0
> @@ -623,6 +655,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
_device *vdpa, u16 idx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>=C2=A0
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int g=
roup,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int asid)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *dev =3D vdpa_to_vduse(vdpa=
);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev_msg msg =3D { 0 };
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev->api_version < VDUSE_API_VERSION_1 |=
|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0group >=3D dev->ngroups || asi=
d >=3D dev->nas)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.vq_group_asid.group =3D group;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0msg.req.vq_group_asid.asid =3D asid;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vduse_dev_msg_sync(dev, &msg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_set_group_asid_nomsg(dev, group, asid)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> +}
> +
> =C2=A0static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 id=
x,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_vq_state *state)
> =C2=A0{
> @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *dev =3D vdpa_to_vduse=
(vdpa);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vduse_domain_set_map(dev->domain, io=
tlb);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vduse_domain_set_map(dev->as[asid].d=
omain, iotlb);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vduse_dev_update_iotlb(dev, 0ULL, UL=
LONG_MAX);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vduse_dev_update_iotlb(dev, asid, 0U=
LL, ULLONG_MAX);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_cle=
ar_map(dev->domain, iotlb);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_cle=
ar_map(dev->as[asid].domain, iotlb);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>=C2=A0
> @@ -843,6 +898,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.get_vq_affinity =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D vduse_vdpa_get_vq_affinity,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reset =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vduse_vdpa_reset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_map =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vduse_vdpa_set_map,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_group_asid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vduse_set_group_asid,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.get_vq_map =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vduse_get_vq_map,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.free =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D vduse_vdpa_free,
> =C2=A0};
> @@ -852,14 +908,17 @@ static void vduse_dev_sync_single_for_device(union =
virtio_map token,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 enum dma_data_direction dir)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> -
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_sync_single_for_device(dom=
ain, dma_addr, size, dir);
> =C2=A0}
>=C2=A0
> @@ -868,14 +927,17 @@ static void vduse_dev_sync_single_for_cpu(union vir=
tio_map token,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 enum dma_data_direction dir)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> -
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_sync_single_for_cpu(domain=
, dma_addr, size, dir);
> =C2=A0}
>=C2=A0
> @@ -885,15 +947,21 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long a=
ttrs)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t r;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return DMA_=
MAPPING_ERROR;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vduse_domain_map_page(domain, page, of=
fset, size, dir, attrs);
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return vduse_domain_map_page(domain, page, o=
ffset, size, dir, attrs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;
> =C2=A0}
>=C2=A0
> =C2=A0static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t=
 dma_addr,
> @@ -901,21 +969,25 @@ static void vduse_dev_unmap_page(union virtio_map t=
oken, dma_addr_t dma_addr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long attrs)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return vduse_domain_unmap_page(domain, dma_a=
ddr, size, dir, attrs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_unmap_page(domain, dma_addr, si=
ze, dir, attrs);
> =C2=A0}
>=C2=A0
> =C2=A0static void *vduse_dev_alloc_coherent(union virtio_map token, size_=
t size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_=
t *dma_addr, gfp_t flag)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long iova;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *addr;
> @@ -925,13 +997,14 @@ static void *vduse_dev_alloc_coherent(union virtio_=
map token, size_t size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL=
;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D vduse_domain_alloc_coherent(do=
main, size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (dma_addr_t *)&iova, flag);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!addr)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0*dma_addr =3D (dma_addr_t)iova;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*dma_addr =3D (d=
ma_addr_t)iova;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return addr;
> =C2=A0}
> @@ -941,29 +1014,39 @@ static void vduse_dev_free_coherent(union virtio_m=
ap token, size_t size,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long at=
trs)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> -
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vduse_domain_free_coherent(domain, size=
, vaddr, dma_addr, attrs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&vdev->domain_lock);
> =C2=A0}
>=C2=A0
> =C2=A0static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t =
dma_addr)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t bounce_size;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fals=
e;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bounce_size =3D domain->bounce_size;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return dma_addr < domain->bounce_size;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return dma_addr < bounce_size;
> =C2=A0}
>=C2=A0
> =C2=A0static int vduse_dev_mapping_error(union virtio_map token, dma_addr=
_t dma_addr)
> @@ -976,15 +1059,22 @@ static int vduse_dev_mapping_error(union virtio_ma=
p token, dma_addr_t dma_addr)
> =C2=A0static size_t vduse_dev_max_mapping_size(union virtio_map token)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_dev *vdev;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_as *as;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vduse_iova_domain *domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t bounce_size;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!token.group)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vdev =3D token.group->dev;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D vdev->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0as =3D rcu_dereference(token.group->as);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D as->domain;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0domain =3D token.group->as->domain;

This line should be removed?

Thanks,
Yongji
