Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439BBC4332F
	for <virtualization@archiver.kernel.org>; Sun, 29 Oct 2023 20:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95A8285200;
	Sun, 29 Oct 2023 20:17:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95A8285200
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Huwjv1Yq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2Fga1W17Fpt; Sun, 29 Oct 2023 20:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBBCF851FA;
	Sun, 29 Oct 2023 20:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBBCF851FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C824AC0071;
	Sun, 29 Oct 2023 20:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 525DDC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D53E851FA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D53E851FA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8rfET8iUjMVp
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:17:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A3A3851E8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 20:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A3A3851E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698610660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6nQ/uPmqXrILOSIy8EDaFkLr4tKSdMkC7He2nMFTXw=;
 b=Huwjv1YqjePqM3H4pTOjQWaQntGZEI8BFS8RDK9MJN67GZFqPXQBg3942GL+5RTdy7CeBc
 /t/Ev+Ox1ZdIgnYbop+ETq6dy1C3aYGr5Kmz0/0J7KEBPOOdELmijErhjkoSota931IE0Y
 tCEeKowO98xBKarclIUWcd/GyW+qf48=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-BY5dDRbwPhqi8Q7iij7CKQ-1; Sun, 29 Oct 2023 16:17:28 -0400
X-MC-Unique: BY5dDRbwPhqi8Q7iij7CKQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so257584166b.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 13:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698610647; x=1699215447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6nQ/uPmqXrILOSIy8EDaFkLr4tKSdMkC7He2nMFTXw=;
 b=bhTcBGLhrkmu9wCQVsTh+LiGnmrUJrhQS4Sk91AXir9MoyfIa8nCRpHCqNTN1wjGme
 i6j0PWElNkZLzMqyVdmonrCrOOT+zIC40fxjezey7sMEQVRwsAXLZmVTRDzC3wNlR2ki
 tW7/fgZo0C6ZNGJuAtjy+pM+b+c2ksbA1jyVF7kvtAqqdpGHiPj5R0e/RU5u9L88Ybfc
 FRKwMlJzF6saEwNE3vjb1yFQ3RVOn0caclD+Q+6ijNjk6gTQZ+r6HVPwjcMHhktUiGKu
 GbqKuNL/VDDXTBEam6eNBcn6JhMFQ7NarOlFucJZbrporeaIe+voUpYn2ROHGw7mOBW0
 VyaA==
X-Gm-Message-State: AOJu0YwwkKYSUBCmT4gNGqjRYlHuvq6pSlA0umJPfvvfifB6qIQ2S8RB
 k+dQWXO6aj4Xjdztw8EWhnKooxHk47yD8xz3zSYAKMtv67Lm74cEK5lNTHYT3yvglPUKhJFw38Y
 2hzpoXHZp9CSGRGPXwt7sBW0n8cVc0PekM2r9FQAOpA==
X-Received: by 2002:a17:907:31c8:b0:9a1:891b:6eed with SMTP id
 xf8-20020a17090731c800b009a1891b6eedmr6713923ejb.76.1698610647708; 
 Sun, 29 Oct 2023 13:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8IKgGkLVvf6ym0XSYuQ6eR4W1aZCo630KEUhtmQx5tH0RQPV6TJseigiQ9aspXaXugV45GA==
X-Received: by 2002:a17:907:31c8:b0:9a1:891b:6eed with SMTP id
 xf8-20020a17090731c800b009a1891b6eedmr6713903ejb.76.1698610647356; 
 Sun, 29 Oct 2023 13:17:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16f:5c91:cfe8:a545:4338:bf76])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a170906471900b0099bcd1fa5b0sm4864404ejq.192.2023.10.29.13.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 13:17:26 -0700 (PDT)
Date: Sun, 29 Oct 2023 16:17:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin
 commands
Message-ID: <20231029160750-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-6-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231029155952.67686-6-yishaih@nvidia.com>
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

On Sun, Oct 29, 2023 at 05:59:48PM +0200, Yishai Hadas wrote:
> Initialize the supported admin commands upon activating the admin queue.
> 
> The supported commands are saved as part of the admin queue context, it
> will be used by the next patches from this series.
> 
> Note:
> As we don't want to let upper layers to execute admin commands before
> that this initialization step was completed, we set ref count to 1 only
> post of that flow and use a non ref counted version command for this
> internal flow.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.h |  1 +
>  drivers/virtio/virtio_pci_modern.c | 77 +++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index a21b9ba01a60..9e07e556a51a 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -46,6 +46,7 @@ struct virtio_pci_admin_vq {
>  	struct virtio_pci_vq_info info;
>  	struct completion flush_done;
>  	refcount_t refcount;
> +	u64 supported_cmds;
>  	/* Name of the admin queue: avq.$index. */
>  	char name[10];
>  	u16 vq_index;
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index ccd7a4d9f57f..25e27aa79cab 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -19,6 +19,9 @@
>  #define VIRTIO_RING_NO_LEGACY
>  #include "virtio_pci_common.h"
>  
> +static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> +				    struct virtio_admin_cmd *cmd);
> +

I don't much like forward declarations. Just order functions sensibly
and they will not be needed.

>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -59,6 +62,42 @@ vp_modern_avq_set_abort(struct virtio_pci_admin_vq *admin_vq, bool abort)
>  	WRITE_ONCE(admin_vq->abort, abort);
>  }
>  
> +static void virtio_pci_admin_init_cmd_list(struct virtio_device *virtio_dev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist result_sg;
> +	struct scatterlist data_sg;
> +	__le64 *data;
> +	int ret;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return;
> +
> +	sg_init_one(&result_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> +	cmd.result_sg = &result_sg;
> +
> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +	if (ret)
> +		goto end;
> +
> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = NULL;
> +
> +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> +	if (ret)
> +		goto end;
> +
> +	vp_dev->admin_vq.supported_cmds = le64_to_cpu(*data);
> +end:
> +	kfree(data);
> +}
> +
>  static void vp_modern_avq_activate(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> @@ -67,6 +106,7 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
>  	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>  		return;
>  
> +	virtio_pci_admin_init_cmd_list(vdev);
>  	init_completion(&admin_vq->flush_done);
>  	refcount_set(&admin_vq->refcount, 1);
>  	vp_modern_avq_set_abort(admin_vq, false);
> @@ -562,6 +602,35 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
>  	return true;
>  }
>  
> +static int __virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> +				    struct scatterlist **sgs,
> +				    unsigned int out_num,
> +				    unsigned int in_num,
> +				    void *data,
> +				    gfp_t gfp)
> +{
> +	struct virtqueue *vq;
> +	int ret, len;
> +
> +	vq = admin_vq->info.vq;
> +
> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, data, gfp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (unlikely(!virtqueue_kick(vq)))
> +		return -EIO;
> +
> +	while (!virtqueue_get_buf(vq, &len) &&
> +	       !virtqueue_is_broken(vq))
> +		cpu_relax();
> +
> +	if (virtqueue_is_broken(vq))
> +		return -EIO;
> +
> +	return 0;
> +}
> +


This is tolerable I guess but it might pin the CPU for a long time.
The difficulty is handling suprize removal well which we currently
don't do with interrupts. I would say it's ok as is but add
a TODO comments along the lines of /* TODO: use interrupts once these virtqueue_is_broken */

>  static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>  				    struct scatterlist **sgs,
>  				    unsigned int out_num,
> @@ -653,7 +722,13 @@ static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
>  		in_num++;
>  	}
>  
> -	ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> +	if (cmd->opcode == VIRTIO_ADMIN_CMD_LIST_QUERY ||
> +	    cmd->opcode == VIRTIO_ADMIN_CMD_LIST_USE)
> +		ret = __virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> +				       out_num, in_num,
> +				       sgs, GFP_KERNEL);
> +	else
> +		ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
>  				       out_num, in_num,
>  				       sgs, GFP_KERNEL);
>  	if (ret) {
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
