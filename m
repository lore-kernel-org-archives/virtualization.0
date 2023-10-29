Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AC2C4167B
	for <virtualization@archiver.kernel.org>; Sun, 29 Oct 2023 20:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7531D42DFD;
	Sun, 29 Oct 2023 20:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7531D42DFD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wm76Y24Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pVlBqkuAIfUD; Sun, 29 Oct 2023 20:27:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5051442DAD;
	Sun, 29 Oct 2023 20:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5051442DAD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B5A7C0071;
	Sun, 29 Oct 2023 20:27:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BCEFC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5575A84F78
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:26:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5575A84F78
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wm76Y24Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Etc7wqrfCxPr
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:26:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5D5484D66
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:26:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5D5484D66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698611213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJbbUkNvWBEodXwBkNJ7Ij9ttKOZL60NGR2gag2PH2Q=;
 b=Wm76Y24Zt/12lQZla3G+jei3EuReHByGXGndIRV36bE7xUzE0YFr+UAl4QQ5JHK5NRu70H
 dIh71LJa/jnFO/hilf9pyG8gt5anjtyitqEyogztp3prxKKRvCh13KjsRO3Aibtvqgpwba
 Rbdx7IlqM/xgnUCwIa2ekH/x63+0A/A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-eD8g8unzOLaMKlMQ6yVSJQ-1; Sun, 29 Oct 2023 16:26:52 -0400
X-MC-Unique: eD8g8unzOLaMKlMQ6yVSJQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5400c8c6392so2701412a12.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 13:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698611211; x=1699216011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJbbUkNvWBEodXwBkNJ7Ij9ttKOZL60NGR2gag2PH2Q=;
 b=slKZjd7Uem3dQm5C+dBD7Gu7pXE+EknTtXHeT9goGwaZqSALTWn14p7Z9sGz+5sinJ
 7VVDKrga7EtZCFZC9oihIyyHil7jyJ35QJ2Hkjsw3kv9lxmv4zyTmdFil2mV+E7TUEu/
 P2c+hSzOB5GYe5kZJXBXvR/d4hFftbjdOKy2ze+8QeW9YdJvzkoy6geN2kXXoj33xx4v
 waNuF8NIQ2rM1LJk0RJbqKUVhE66fwKGclF3QKrc6nzn3y8J1W9pmk+4bcNQ6Po+riG4
 V3GnnywTMmPd+K1CoeTQ2vH2NmPMe6dcB2ImNTg43285uyD/QNrciQIbqTVzFt3gZY/N
 +New==
X-Gm-Message-State: AOJu0YySICM87eKInE/NGWCMSYl1A0+bI/e232YV7yMTUKY+n12ebRnM
 ZVO9BNsSbe9Hte/QfqMZCrZmSF9ktg4TQ+V6M1+FMQqc8czLR7H3Xut3rgvKaqzYK1LZQjw/Nh6
 XUfCuC3no9rBugyg4b49MUD4O7IfgRuoK9SPbg9zjwA==
X-Received: by 2002:a17:906:dc8f:b0:9c4:bb5f:970d with SMTP id
 cs15-20020a170906dc8f00b009c4bb5f970dmr7225610ejc.45.1698611211016; 
 Sun, 29 Oct 2023 13:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmBQA9NAT8hmav8ZRqdcywEB2wxqccw+gPEpxsipOoCmtv9JqyOjyGWVHoA1MP6KDymJgmEg==
X-Received: by 2002:a17:906:dc8f:b0:9c4:bb5f:970d with SMTP id
 cs15-20020a170906dc8f00b009c4bb5f970dmr7225590ejc.45.1698611210614; 
 Sun, 29 Oct 2023 13:26:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5c91:cfe8:a545:4338:bf76])
 by smtp.gmail.com with ESMTPSA id
 kt12-20020a170906aacc00b009ad8acac02asm4902622ejb.172.2023.10.29.13.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 13:26:49 -0700 (PDT)
Date: Sun, 29 Oct 2023 16:26:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 vfio 3/9] virtio-pci: Introduce admin command sending
 function
Message-ID: <20231029162255-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-4-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231029155952.67686-4-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Sun, Oct 29, 2023 at 05:59:46PM +0200, Yishai Hadas wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> Add support for sending admin command through admin virtqueue interface.
> Abort any inflight admin commands once device reset completes.
> 
> To enforce the below statement from the specification [1], the admin
> queue is activated for the upper layer users only post of setting status
> to DRIVER_OK.
> 
> [1] The driver MUST NOT send any buffer available notifications to the
> device before setting DRIVER_OK.
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.h |   3 +
>  drivers/virtio/virtio_pci_modern.c | 174 +++++++++++++++++++++++++++++
>  include/linux/virtio.h             |   8 ++
>  include/uapi/linux/virtio_pci.h    |  22 ++++
>  4 files changed, 207 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index e03af0966a4b..a21b9ba01a60 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -44,9 +44,12 @@ struct virtio_pci_vq_info {
>  struct virtio_pci_admin_vq {
>  	/* Virtqueue info associated with this admin queue. */
>  	struct virtio_pci_vq_info info;
> +	struct completion flush_done;
> +	refcount_t refcount;

what exactly does this count?

>  	/* Name of the admin queue: avq.$index. */
>  	char name[10];
>  	u16 vq_index;
> +	bool abort;
>  };
>  
>  /* Our device structure */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 01c5ba346471..ccd7a4d9f57f 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -36,6 +36,58 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
>  	return index == vp_dev->admin_vq.vq_index;
>  }
>  
> +static bool vp_modern_avq_get(struct virtio_pci_admin_vq *admin_vq)
> +{
> +	return refcount_inc_not_zero(&admin_vq->refcount);
> +}
> +
> +static void vp_modern_avq_put(struct virtio_pci_admin_vq *admin_vq)
> +{
> +	if (refcount_dec_and_test(&admin_vq->refcount))
> +		complete(&admin_vq->flush_done);
> +}
> +
> +static bool vp_modern_avq_is_abort(const struct virtio_pci_admin_vq *admin_vq)
> +{
> +	return READ_ONCE(admin_vq->abort);
> +}
> +
> +static void
> +vp_modern_avq_set_abort(struct virtio_pci_admin_vq *admin_vq, bool abort)
> +{
> +	/* Mark the AVQ to abort, so that inflight commands can be aborted. */
> +	WRITE_ONCE(admin_vq->abort, abort);
> +}
> +
> +static void vp_modern_avq_activate(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> +		return;
> +
> +	init_completion(&admin_vq->flush_done);
> +	refcount_set(&admin_vq->refcount, 1);
> +	vp_modern_avq_set_abort(admin_vq, false);
> +}
> +
> +static void vp_modern_avq_deactivate(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> +		return;
> +
> +	vp_modern_avq_set_abort(admin_vq, true);
> +	/* Balance with refcount_set() during vp_modern_avq_activate */
> +	vp_modern_avq_put(admin_vq);
> +
> +	/* Wait for all the inflight admin commands to be aborted */
> +	wait_for_completion(&vp_dev->admin_vq.flush_done);
> +}
> +
>  static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -172,6 +224,8 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
>  	/* We should never be setting status to 0. */
>  	BUG_ON(status == 0);
>  	vp_modern_set_status(&vp_dev->mdev, status);
> +	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> +		vp_modern_avq_activate(vdev);
>  }
>  
>  static void vp_reset(struct virtio_device *vdev)
> @@ -188,6 +242,9 @@ static void vp_reset(struct virtio_device *vdev)
>  	 */
>  	while (vp_modern_get_status(mdev))
>  		msleep(1);
> +
> +	vp_modern_avq_deactivate(vdev);
> +
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
>  }
> @@ -505,6 +562,121 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  	return true;
>  }
>  
> +static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> +				    struct scatterlist **sgs,
> +				    unsigned int out_num,
> +				    unsigned int in_num,
> +				    void *data,
> +				    gfp_t gfp)
> +{
> +	struct virtqueue *vq;
> +	int ret, len;
> +
> +	if (!vp_modern_avq_get(admin_vq))
> +		return -EIO;
> +
> +	vq = admin_vq->info.vq;
> +
> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, data, gfp);
> +	if (ret < 0)
> +		goto out;
> +

virtqueue_add_sgs requires locking, it is not atomic.
Add some kind of mutex?
Will also help prevent vq overruns.

> +	if (unlikely(!virtqueue_kick(vq))) {
> +		ret = -EIO;
> +		goto out;
> +	}




> +
> +	while (!virtqueue_get_buf(vq, &len) &&
> +	       !virtqueue_is_broken(vq) &&
> +	       !vp_modern_avq_is_abort(admin_vq))
> +		cpu_relax();
> +
> +	if (vp_modern_avq_is_abort(admin_vq) || virtqueue_is_broken(vq)) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +out:
> +	vp_modern_avq_put(admin_vq);
> +	return ret;
> +}
> +
> +#define VIRTIO_AVQ_SGS_MAX	4
> +
> +static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> +				    struct virtio_admin_cmd *cmd)
> +{
> +	struct scatterlist *sgs[VIRTIO_AVQ_SGS_MAX], hdr, stat;
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_admin_cmd_status *va_status;
> +	unsigned int out_num = 0, in_num = 0;
> +	struct virtio_admin_cmd_hdr *va_hdr;
> +	struct virtqueue *avq;
> +	u16 status;
> +	int ret;
> +
> +	avq = virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ) ?
> +		vp_dev->admin_vq.info.vq : NULL;
> +	if (!avq)
> +		return -EOPNOTSUPP;
> +
> +	va_status = kzalloc(sizeof(*va_status), GFP_KERNEL);
> +	if (!va_status)
> +		return -ENOMEM;
> +
> +	va_hdr = kzalloc(sizeof(*va_hdr), GFP_KERNEL);
> +	if (!va_hdr) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	va_hdr->opcode = cmd->opcode;
> +	va_hdr->group_type = cmd->group_type;
> +	va_hdr->group_member_id = cmd->group_member_id;
> +
> +	/* Add header */
> +	sg_init_one(&hdr, va_hdr, sizeof(*va_hdr));
> +	sgs[out_num] = &hdr;
> +	out_num++;
> +
> +	if (cmd->data_sg) {
> +		sgs[out_num] = cmd->data_sg;
> +		out_num++;
> +	}
> +
> +	/* Add return status */
> +	sg_init_one(&stat, va_status, sizeof(*va_status));
> +	sgs[out_num + in_num] = &stat;
> +	in_num++;
> +
> +	if (cmd->result_sg) {
> +		sgs[out_num + in_num] = cmd->result_sg;
> +		in_num++;
> +	}


BUG_ON here to check we did not overrun sgs?

> +
> +	ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> +				       out_num, in_num,
> +				       sgs, GFP_KERNEL);
> +	if (ret) {
> +		dev_err(&vdev->dev,
> +			"Failed to execute command on admin vq: %d\n.", ret);
> +		goto err_cmd_exec;
> +	}
> +
> +	status = le16_to_cpu(va_status->status);
> +	if (status != VIRTIO_ADMIN_STATUS_OK) {
> +		dev_err(&vdev->dev,
> +			"admin command error: status(%#x) qualifier(%#x)\n",
> +			status, le16_to_cpu(va_status->status_qualifier));
> +		ret = -status;
> +	}
> +
> +err_cmd_exec:
> +	kfree(va_hdr);
> +err_alloc:
> +	kfree(va_status);
> +	return ret;
> +}
> +
>  static int vp_modern_create_avq(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -530,6 +702,7 @@ static int vp_modern_create_avq(struct virtio_device *vdev)
>  		return PTR_ERR(vq);
>  	}
>  
> +	refcount_set(&vp_dev->admin_vq.refcount, 0);
>  	vp_dev->admin_vq.info.vq = vq;
>  	vp_modern_set_queue_enable(&vp_dev->mdev, avq->info.vq->index, true);
>  	return 0;
> @@ -542,6 +715,7 @@ static void vp_modern_destroy_avq(struct virtio_device *vdev)
>  	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>  		return;
>  
> +	WARN_ON(refcount_read(&vp_dev->admin_vq.refcount));
>  	vp_dev->del_vq(&vp_dev->admin_vq.info);
>  }
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 4cc614a38376..b0201747a263 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -103,6 +103,14 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  int virtqueue_reset(struct virtqueue *vq,
>  		    void (*recycle)(struct virtqueue *vq, void *buf));
>  
> +struct virtio_admin_cmd {
> +	__le16 opcode;
> +	__le16 group_type;
> +	__le64 group_member_id;
> +	struct scatterlist *data_sg;
> +	struct scatterlist *result_sg;
> +};
> +
>  /**
>   * struct virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f703afc7ad31..68eacc9676dc 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -207,4 +207,26 @@ struct virtio_pci_cfg_cap {
>  
>  #endif /* VIRTIO_PCI_NO_MODERN */
>  
> +/* Admin command status. */
> +#define VIRTIO_ADMIN_STATUS_OK		0
> +
> +struct __packed virtio_admin_cmd_hdr {
> +	__le16 opcode;
> +	/*
> +	 * 1 - SR-IOV
> +	 * 2-65535 - reserved
> +	 */
> +	__le16 group_type;
> +	/* Unused, reserved for future extensions. */
> +	__u8 reserved1[12];
> +	__le64 group_member_id;
> +};
> +
> +struct __packed virtio_admin_cmd_status {
> +	__le16 status;
> +	__le16 status_qualifier;
> +	/* Unused, reserved for future extensions. */
> +	__u8 reserved2[4];
> +};
> +
>  #endif
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
