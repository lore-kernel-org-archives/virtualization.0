Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C8C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:31:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61029613F1
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61029613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1419E4052E;
	Thu,  3 Jun 2021 14:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmGgbUoaJARS; Thu,  3 Jun 2021 14:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D73AC40520;
	Thu,  3 Jun 2021 14:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9AA4C000D;
	Thu,  3 Jun 2021 14:31:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C16B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0F4F83DEF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T0cl3FodelK1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:30:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 087A583DF8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622730654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eqg8Q9bNDRb2RIhF7mtZ+7gv11vPV4oBdAd/k8p9s3k=;
 b=c3vqBY4sK9MTZBJ8PHNRq0zvcKBLc1qcGUJ722lZJuuP0BYcA/Cmy3UjsArhuXZgCQOnFP
 Mz0MQ1l/DJ0zQFLuS7jPjX4Bzx9tU2vZjsyagAGJ3QCHvi1DDMiWwmngNsfGexDXL2GDX/
 CEmMrdHQvSnTVgFE1cWB1QGz/bj9zOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-y83vpja5NwmeYSp3JPcNOw-1; Thu, 03 Jun 2021 10:30:49 -0400
X-MC-Unique: y83vpja5NwmeYSp3JPcNOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACAA919251AA;
 Thu,  3 Jun 2021 14:30:48 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 350D05DEAD;
 Thu,  3 Jun 2021 14:30:45 +0000 (UTC)
Date: Thu, 3 Jun 2021 15:30:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 7/9] vhost: allow userspace to create workers
Message-ID: <YLjnk5GpFaCCOqCU@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-8-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-8-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 pbonzini@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3561073980758160093=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3561073980758160093==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m2v0+d/R+VEr8M4q"
Content-Disposition: inline


--m2v0+d/R+VEr8M4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:58PM -0500, Mike Christie wrote:
> This patch allows userspace to create workers and bind them to vqs, so you
> can have N workers per dev and also share N workers with M vqs. The next
> patch will allow sharing across devices.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c            | 94 +++++++++++++++++++++++++++++++-
>  drivers/vhost/vhost.h            |  3 +
>  include/uapi/linux/vhost.h       |  6 ++
>  include/uapi/linux/vhost_types.h | 12 ++++
>  4 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 345ade0af133..981e9bac7a31 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -30,6 +30,7 @@
>  #include <linux/interval_tree_generic.h>
>  #include <linux/nospec.h>
>  #include <linux/kcov.h>
> +#include <linux/hashtable.h>
> =20
>  #include "vhost.h"
> =20
> @@ -42,6 +43,9 @@ module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>  	"Maximum number of iotlb entries. (default: 2048)");
> =20
> +static DEFINE_HASHTABLE(vhost_workers, 5);
> +static DEFINE_SPINLOCK(vhost_workers_lock);
> +
>  enum {
>  	VHOST_MEMORY_F_LOG =3D 0x1,
>  };
> @@ -617,8 +621,17 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm =3D NULL;
>  }
> =20
> -static void vhost_worker_free(struct vhost_worker *worker)
> +static void vhost_worker_put(struct vhost_worker *worker)
>  {
> +	spin_lock(&vhost_workers_lock);
> +	if (!refcount_dec_and_test(&worker->refcount)) {
> +		spin_unlock(&vhost_workers_lock);
> +		return;
> +	}
> +
> +	hash_del(&worker->h_node);
> +	spin_unlock(&vhost_workers_lock);
> +
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	kthread_stop(worker->task);
>  	kfree(worker);
> @@ -632,7 +645,7 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  		return;
> =20
>  	for (i =3D 0; i < dev->num_workers; i++)
> -		vhost_worker_free(dev->workers[i]);
> +		vhost_worker_put(dev->workers[i]);
> =20
>  	kfree(dev->workers);
>  	dev->num_workers =3D 0;
> @@ -652,6 +665,8 @@ static struct vhost_worker *vhost_worker_create(struc=
t vhost_dev *dev)
>  	worker->id =3D dev->num_workers;
>  	worker->dev =3D dev;
>  	init_llist_head(&worker->work_list);
> +	INIT_HLIST_NODE(&worker->h_node);
> +	refcount_set(&worker->refcount, 1);
> =20
>  	task =3D kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
>  	if (IS_ERR(task))
> @@ -664,6 +679,9 @@ static struct vhost_worker *vhost_worker_create(struc=
t vhost_dev *dev)
>  	if (ret)
>  		goto stop_worker;
> =20
> +	spin_lock(&vhost_workers_lock);
> +	hash_add(vhost_workers, &worker->h_node, worker->task->pid);
> +	spin_unlock(&vhost_workers_lock);
>  	return worker;
> =20
>  stop_worker:
> @@ -673,6 +691,67 @@ static struct vhost_worker *vhost_worker_create(stru=
ct vhost_dev *dev)
>  	return NULL;
>  }
> =20
> +static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid=
_t pid)
> +{
> +	struct vhost_worker *worker, *found_worker =3D NULL;
> +
> +	spin_lock(&vhost_workers_lock);
> +	hash_for_each_possible(vhost_workers, worker, h_node, pid) {
> +		if (worker->task->pid =3D=3D pid) {
> +			/* tmp - next patch allows sharing across devs */
> +			if (worker->dev !=3D dev)
> +				break;
> +
> +			found_worker =3D worker;
> +			refcount_inc(&worker->refcount);
> +			break;
> +		}
> +	}
> +	spin_unlock(&vhost_workers_lock);
> +	return found_worker;
> +}
> +
> +/* Caller must have device mutex */
> +static int vhost_vq_set_worker(struct vhost_virtqueue *vq,
> +			       struct vhost_vring_worker *info)
> +{
> +	struct vhost_dev *dev =3D vq->dev;
> +	struct vhost_worker *worker;
> +
> +	if (vq->worker) {
> +		/* TODO - support changing while works are running */
> +		return -EBUSY;
> +	}
> +
> +	if (info->pid =3D=3D VHOST_VRING_NEW_WORKER) {
> +		worker =3D vhost_worker_create(dev);

The maximum number of kthreads created is limited by
vhost_dev_init(nvqs)? For example VHOST_SCSI_MAX_VQ 128.

IIUC kthread_create is not limited by or accounted against the current
task, so I'm a little worried that a process can create a lot of
kthreads.

I haven't investigated other kthread_create() users reachable from
userspace applications to see how they bound the number of threads
effectively.

Any thoughts?

> +		if (!worker)
> +			return -ENOMEM;
> +
> +		info->pid =3D worker->task->pid;
> +	} else {
> +		worker =3D vhost_worker_find(dev, info->pid);
> +		if (!worker)
> +			return -ENODEV;
> +	}
> +
> +	if (!dev->workers) {
> +		dev->workers =3D kcalloc(vq->dev->nvqs,
> +				       sizeof(struct vhost_worker *),
> +				       GFP_KERNEL);

Another candidate for GFP_KERNEL_ACCOUNT.

> +		if (!dev->workers) {
> +			vhost_worker_put(worker);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	vq->worker =3D worker;
> +
> +	dev->workers[dev->num_workers] =3D worker;
> +	dev->num_workers++;

Hmm...should we really append to workers[] in the vhost_worker_find()
case?

> +	return 0;
> +}
> +
>  /* Caller must have device mutex */
>  static int vhost_worker_try_create_def(struct vhost_dev *dev)
>  {
> @@ -1680,6 +1759,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *arg
>  	struct eventfd_ctx *ctx =3D NULL;
>  	u32 __user *idxp =3D argp;
>  	struct vhost_virtqueue *vq;
> +	struct vhost_vring_worker w;
>  	struct vhost_vring_state s;
>  	struct vhost_vring_file f;
>  	u32 idx;
> @@ -1794,6 +1874,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *arg
>  		if (copy_to_user(argp, &s, sizeof(s)))
>  			r =3D -EFAULT;
>  		break;
> +	case VHOST_SET_VRING_WORKER:
> +		if (copy_from_user(&w, argp, sizeof(w))) {
> +			r =3D -EFAULT;
> +			break;
> +		}
> +		r =3D vhost_vq_set_worker(vq, &w);
> +		if (!r && copy_to_user(argp, &w, sizeof(w)))
> +			r =3D -EFAULT;
> +		break;
>  	default:
>  		r =3D -ENOIOCTLCMD;
>  	}
> @@ -2726,6 +2815,7 @@ EXPORT_SYMBOL_GPL(vhost_set_backend_features);
> =20
>  static int __init vhost_init(void)
>  {
> +	hash_init(vhost_workers);
>  	return 0;
>  }
> =20
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 0a252dd45101..75b884ad1f17 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -14,6 +14,7 @@
>  #include <linux/atomic.h>
>  #include <linux/vhost_iotlb.h>
>  #include <linux/irqbypass.h>
> +#include <linux/refcount.h>
> =20
>  struct vhost_work;
>  typedef void (*vhost_work_fn_t)(struct vhost_work *work);
> @@ -28,6 +29,8 @@ struct vhost_work {
>  struct vhost_worker {
>  	struct task_struct	*task;
>  	struct llist_head	work_list;
> +	struct hlist_node	h_node;

h_node is a generic name. If you're willing to use a longer name then
vhost_workers_node would make it clear which hlist this is associated
with.

> +	refcount_t		refcount;
>  	struct vhost_dev	*dev;
>  	int			id;
>  };
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..ce32119cb139 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -70,6 +70,12 @@
>  #define VHOST_VRING_BIG_ENDIAN 1
>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vri=
ng_state)
>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vri=
ng_state)
> +/* Create/bind a vhost worker to a virtqueue. If pid > 0 and matches an =
existing
> + * vhost_worker thread it will be bound to the vq. If pid is
> + * VHOST_VRING_NEW_WORKER, then a new worker will be created and bound t=
o the
> + * vq.
> + */

Please document when this ioctl must be called (before kick is set up).

> +#define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vr=
ing_worker)
> =20
>  /* The following ioctls use eventfd file descriptors to signal and poll
>   * for events. */
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index f7f6a3a28977..5113baa8bc3e 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -47,6 +47,18 @@ struct vhost_vring_addr {
>  	__u64 log_guest_addr;
>  };
> =20
> +#define VHOST_VRING_NEW_WORKER -1
> +
> +struct vhost_vring_worker {
> +	unsigned int index;
> +	/*
> +	 * The pid of the vhost worker that the vq will be bound to. If
> +	 * pid is VHOST_VRING_NEW_WORKER a new worker will be created and it's

s/it's/its/

> +	 * pid will be returned in pid.
> +	 */
> +	__kernel_pid_t pid;
> +};
> +
>  /* no alignment requirement */
>  struct vhost_iotlb_msg {
>  	__u64 iova;
> --=20
> 2.25.1
>=20

--m2v0+d/R+VEr8M4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC455MACgkQnKSrs4Gr
c8gAAAf+Pbxd4/zLO3H2sX/yDw7zjilzX6BLxVW5RS39EAj16qpRKzfboNrJ9ilh
xiMwnFfuCXIvglqNo++rJVZfGxA4oOYJbc/vVfkC9av/3rFIPrXrkn8vb4pVxyEA
ZncXqDfpiGwdFptAGmCpcPo4sL13mGPdEFh9Lu/o+WTnE3h4mGgrGWPJGugNNJLd
/ixXySLYcmwOJezapQr51AJ44oBMzUAeYzDUcQy5hFBZ/htQZyZxRzYJiqDEbXlx
E/bejfizfeNFbB0T0miRwkwH14acy7SE3t9hBWMdb2k+qAwNHMmGsVkUQqIJw3cU
Jf6rQxWPbgkuIrdzXspfOKU0w0ldyQ==
=BUw8
-----END PGP SIGNATURE-----

--m2v0+d/R+VEr8M4q--


--===============3561073980758160093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3561073980758160093==--

