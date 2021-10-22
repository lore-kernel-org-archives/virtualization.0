Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07DEC433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:47:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CDF604E9
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 10:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77CDF604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39EB540838;
	Fri, 22 Oct 2021 10:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AVcPyM2rCyoL; Fri, 22 Oct 2021 10:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A39F4407CE;
	Fri, 22 Oct 2021 10:47:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7085AC0020;
	Fri, 22 Oct 2021 10:47:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 536FDC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C45060F10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 234PYIM6mypt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:47:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 480CF6087A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634899638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xq7E3x1WswTfW3y4sCmSmeLNvprDEf0e/MXu/YBxCUM=;
 b=NpZkcWdWaWYXEC0V+srNUPCSxkHQfPpz7bpPTpIDZl6JGTaOuh0KnAxBZeCLyjMPjxyXw0
 cuC8hzUgLC7pSGiaxe6oIJjWqKzkbFGzd/VclBHyY3zgwZC2MUHFWhU+8pPOnXO/5mSNcs
 TUjt8TAjifRGbWEOlNlxtxkW6cU1aG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-d0kDnHHRNJKGiquTGUNL8g-1; Fri, 22 Oct 2021 06:47:17 -0400
X-MC-Unique: d0kDnHHRNJKGiquTGUNL8g-1
Received: by mail-wm1-f72.google.com with SMTP id
 k20-20020a7bc414000000b0030dcd454771so862054wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 03:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xq7E3x1WswTfW3y4sCmSmeLNvprDEf0e/MXu/YBxCUM=;
 b=yi0KTBGn+F7dIpkTOhBkk363UjYK/L/cIlRnZMYVLpr7fZQ39ynt51zRW6NNPQRw9j
 1nAvMIthHN4wxupM7GqwA508qpJdWhv9aEjPhqXUTjMGwBdhEdmyoJgfHeScexDAwr/d
 EM177EIydvSXsjbxvFR9oCbqtZ+q1yo0NX1LCDuFR3aReUwy9EU3tEa3wUj9OxGOb5q6
 u53tnI0ZLJ84yH+gW1efiHs1bA8bih3TaVSVWRoYpaSEemQ+Q9Z/v9A7uciIN2AJS7mI
 GnVMalyUNARRC+0LsOxuF2yjpC8F8uuEvfHaKVbP8zWgrztJbqUHpUMA3eDYunoGq6tK
 B4aw==
X-Gm-Message-State: AOAM530my/yzSjR4b3Bp7yJZSrqGiV3qJvDj/UngWO/OI0hrDfA6ZKRw
 DelnkXKqnWjtVId9co5an50fuUserz15v3TkiwlKyQjfJ3N0AoAwi4ln4xgtfsPAoi5jpUSQfmE
 iDwnD0yM3w6rpuSBKP/EgA0mIIc0ZbonX4E4b4yRazQ==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr5953328wmj.83.1634899636095; 
 Fri, 22 Oct 2021 03:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Ad0W5TcbRqVIhlFIc9Dz1lU0GjU3dNzpRKDEZ1Oio4goJyBEDJpIaIV/QuHE8rEekJ7ZnQ==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr5953303wmj.83.1634899635842; 
 Fri, 22 Oct 2021 03:47:15 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id l2sm3857169wrx.68.2021.10.22.03.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 03:47:14 -0700 (PDT)
Date: Fri, 22 Oct 2021 06:47:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <20211022064359-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20211022051911.108383-13-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 22, 2021 at 12:19:11AM -0500, Mike Christie wrote:
> This patch allows userspace to create workers and bind them to vqs. You
> can have N workers per dev and also share N workers with M vqs.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c            | 99 ++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h            |  2 +-
>  include/uapi/linux/vhost.h       | 11 ++++
>  include/uapi/linux/vhost_types.h | 12 ++++
>  4 files changed, 112 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 04f43a6445e1..c86e88d7f35c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -493,7 +493,6 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->umem = NULL;
>  	dev->iotlb = NULL;
>  	dev->mm = NULL;
> -	dev->worker = NULL;
>  	dev->iov_limit = iov_limit;
>  	dev->weight = weight;
>  	dev->byte_weight = byte_weight;
> @@ -576,20 +575,40 @@ static void vhost_worker_stop(struct vhost_worker *worker)
>  	wait_for_completion(worker->exit_done);
>  }
>  
> -static void vhost_worker_free(struct vhost_dev *dev)
> -{
> -	struct vhost_worker *worker = dev->worker;
>  
> +static void vhost_worker_put(struct vhost_worker *worker)
> +{
>  	if (!worker)
>  		return;
>  
> -	dev->worker = NULL;
> +	if (!refcount_dec_and_test(&worker->refcount))
> +		return;
> +
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	vhost_worker_stop(worker);
>  	kfree(worker);
>  }
>  
> -static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> +static void vhost_vq_clear_worker(struct vhost_virtqueue *vq)
> +{
> +	if (vq->worker)
> +		vhost_worker_put(vq->worker);
> +	vq->worker = NULL;
> +}
> +
> +static void vhost_workers_free(struct vhost_dev *dev)
> +{
> +	int i;
> +
> +	if (!dev->use_worker)
> +		return;
> +
> +	for (i = 0; i < dev->nvqs; i++)
> +		vhost_vq_clear_worker(dev->vqs[i]);
> +}
> +
> +static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev,
> +						int init_vq_map_count)
>  {
>  	struct vhost_worker *worker;
>  	struct task_struct *task;
> @@ -598,9 +617,9 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  	if (!worker)
>  		return NULL;
>  
> -	dev->worker = worker;
>  	worker->kcov_handle = kcov_common_handle();
>  	init_llist_head(&worker->work_list);
> +	refcount_set(&worker->refcount, init_vq_map_count);
>  
>  	/*
>  	 * vhost used to use the kthread API which ignores all signals by
> @@ -617,10 +636,58 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  
>  free_worker:
>  	kfree(worker);
> -	dev->worker = NULL;
>  	return NULL;
>  }
>  
> +static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid_t pid)
> +{
> +	struct vhost_worker *worker = NULL;
> +	int i;
> +
> +	for (i = 0; i < dev->nvqs; i++) {
> +		if (dev->vqs[i]->worker->task->pid != pid)
> +			continue;
> +
> +		worker = dev->vqs[i]->worker;
> +		break;
> +	}
> +
> +	return worker;
> +}
> +
> +/* Caller must have device mutex */
> +static int vhost_vq_setup_worker(struct vhost_virtqueue *vq,
> +				 struct vhost_vring_worker *info)
> +{
> +	struct vhost_dev *dev = vq->dev;
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker)
> +		return -EINVAL;
> +
> +	/* We don't support setting a worker on an active vq */
> +	if (vq->private_data)
> +		return -EBUSY;
> +
> +	if (info->pid == VHOST_VRING_NEW_WORKER) {
> +		worker = vhost_worker_create(dev, 1);
> +		if (!worker)
> +			return -ENOMEM;
> +
> +		info->pid = worker->task->pid;
> +	} else {
> +		worker = vhost_worker_find(dev, info->pid);
> +		if (!worker)
> +			return -ENODEV;
> +
> +		refcount_inc(&worker->refcount);
> +	}
> +
> +	vhost_vq_clear_worker(vq);
> +	vq->worker = worker;
> +	return 0;
> +}
> +
>  /* Caller should have device mutex */
>  long vhost_dev_set_owner(struct vhost_dev *dev)
>  {
> @@ -636,7 +703,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	vhost_attach_mm(dev);
>  
>  	if (dev->use_worker) {
> -		worker = vhost_worker_create(dev);
> +		worker = vhost_worker_create(dev, dev->nvqs);
>  		if (!worker)
>  			goto err_worker;
>  
> @@ -650,7 +717,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	return 0;
>  err_iovecs:
> -	vhost_worker_free(dev);
> +	vhost_workers_free(dev);
>  err_worker:
>  	vhost_detach_mm(dev);
>  err_mm:
> @@ -742,7 +809,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	dev->iotlb = NULL;
>  	vhost_clear_msg(dev);
>  	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> -	vhost_worker_free(dev);
> +	vhost_workers_free(dev);
>  	vhost_detach_mm(dev);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> @@ -1612,6 +1679,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  	struct eventfd_ctx *ctx = NULL;
>  	u32 __user *idxp = argp;
>  	struct vhost_virtqueue *vq;
> +	struct vhost_vring_worker w;
>  	struct vhost_vring_state s;
>  	struct vhost_vring_file f;
>  	u32 idx;
> @@ -1719,6 +1787,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  		if (copy_to_user(argp, &s, sizeof(s)))
>  			r = -EFAULT;
>  		break;
> +	case VHOST_SET_VRING_WORKER:
> +		if (copy_from_user(&w, argp, sizeof(w))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +		r = vhost_vq_setup_worker(vq, &w);
> +		if (!r && copy_to_user(argp, &w, sizeof(w)))
> +			r = -EFAULT;
> +		break;
>  	default:
>  		r = -ENOIOCTLCMD;
>  	}
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 33c63b24187a..0911d1a9bd3b 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -35,6 +35,7 @@ struct vhost_worker {
>  	struct llist_head	work_list;
>  	u64			kcov_handle;
>  	unsigned long		flags;
> +	refcount_t		refcount;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> @@ -160,7 +161,6 @@ struct vhost_dev {
>  	struct vhost_virtqueue **vqs;
>  	int nvqs;
>  	struct eventfd_ctx *log_ctx;
> -	struct vhost_worker *worker;
>  	struct vhost_iotlb *umem;
>  	struct vhost_iotlb *iotlb;
>  	spinlock_t iotlb_lock;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..e5c0669430e5 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -70,6 +70,17 @@
>  #define VHOST_VRING_BIG_ENDIAN 1
>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> +/* By default, a device gets one vhost_worker created during VHOST_SET_OWNER
> + * that its virtqueues share. This allows userspace to create a vhost_worker
> + * and map a virtqueue to it or map a virtqueue to an existing worker.
> + *
> + * If pid > 0 and it matches an existing vhost_worker thread it will be bound
> + * to the vq. If pid is VHOST_VRING_NEW_WORKER, then a new worker will be
> + * created and bound to the vq.
> + *
> + * This must be called after VHOST_SET_OWNER and before the vq is active.
> + */

A couple of things here:
it's probably a good idea not to make it match pid exactly,
if for no other reason than I'm not sure we want to
commit this being a pid. Let's just call it an id?
And maybe byteswap it or xor with some value
just to make sure userspace does not begin abusing it anyway.

Also, interaction with pid namespace is unclear to me.
Can you document what happens here?
No need to fix funky things like moving the fd between
pid namespaces while also creating/destroying workers, but let's
document it's not supported.


> +#define VHOST_SET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x15, struct vhost_vring_worker)
>  
>  /* The following ioctls use eventfd file descriptors to signal and poll
>   * for events. */
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index f7f6a3a28977..af654e3cef0e 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -47,6 +47,18 @@ struct vhost_vring_addr {
>  	__u64 log_guest_addr;
>  };
>  
> +#define VHOST_VRING_NEW_WORKER -1
> +
> +struct vhost_vring_worker {
> +	unsigned int index;
> +	/*
> +	 * The pid of the vhost worker that the vq will be bound to. If
> +	 * pid is VHOST_VRING_NEW_WORKER a new worker will be created and its
> +	 * pid will be returned in pid.
> +	 */
> +	__kernel_pid_t pid;
> +};
> +
>  /* no alignment requirement */
>  struct vhost_iotlb_msg {
>  	__u64 iova;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
