Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF0AC11F68
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 15:55:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BA8613FB
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 15:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BA8613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC24960725;
	Fri,  2 Jul 2021 15:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7tsckb1FW1ae; Fri,  2 Jul 2021 15:55:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FA8060B5C;
	Fri,  2 Jul 2021 15:55:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D91DC001A;
	Fri,  2 Jul 2021 15:55:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B09ECC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 15:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91591401C0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 15:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5eKHFmSCZgQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 15:55:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF93940103
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625241348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=508AyhKpE8jUDrBFR0nb6Agup3ldPNqzk6KlIwcdo6g=;
 b=LpvTfE/Xx+XxBOBEfTmUYI/QfsjpiHQc0Gu+BHHdR3yz83mUE4ooCVhgda5bWfcA1zOBTW
 xytcClIOyvL59dXXPT824g80VpkdOa4Jesx3/C9QvjSknNLBabkhiZnNXeUNvEjRA+6v1r
 dj9+KQW/eQiIvFkwdJ6vEK9nSAZeJMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-zvMjgoNYM5WCm7FN7eq1jg-1; Fri, 02 Jul 2021 11:55:47 -0400
X-MC-Unique: zvMjgoNYM5WCm7FN7eq1jg-1
Received: by mail-wr1-f70.google.com with SMTP id
 v18-20020adfa1d20000b029012c379fbc45so3537328wrv.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jul 2021 08:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=508AyhKpE8jUDrBFR0nb6Agup3ldPNqzk6KlIwcdo6g=;
 b=SOsAqjSW9KIf3MC+pgZRSVxpQesdia5HZf0y7UE3/soF5NP5hS0tctBfEOyESdwODh
 dWkQ5tr54sHETVA7rj0BR8IDCj92JmBecNh0/JzVUpKO1oQCEo8CBM+zcz/Y7VYLx30h
 xY/z4iWF5iATnvKZ2JkoeaB5DoGqlh8JfzjwS2PcZupMhaAgx7lzjDOY6dp3zjGGgMKu
 kvyA5cK9/aO9ulPZhnqMwtI4y0ekCaZ7YSUL+HkApZcaZywxJZ3fjYEDfLrgFhEYVcyt
 t6I2w+mli5qzGNYK0izS/ov7eYGl1FrYQB8jJv32IVBYaFyZtWMsksrpaJjhDBmnhA+Z
 b6vQ==
X-Gm-Message-State: AOAM533bW5BPMPHq4Z+0uARPbRfQx6acFNH3excbawvAb2D//opKmpq3
 Ct+zrOOg2uitJe2eE7eSBABjdkrXXZmOio00kEgRHB1PeocuQB1ABqHIc5U0haD4d+Rn65hqY/G
 uBdZsH/1AyUZ0Bx7Kto25oGJfP/vf6DMb7zkDRcGV+w==
X-Received: by 2002:a1c:1dd1:: with SMTP id d200mr205142wmd.82.1625241346472; 
 Fri, 02 Jul 2021 08:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5g/VM21EKC5p1b+bedRgUGipGzZg9oN5IehHhOj+/WVKmexFW92+hQHKujHlDSVZapekDzw==
X-Received: by 2002:a1c:1dd1:: with SMTP id d200mr205117wmd.82.1625241346342; 
 Fri, 02 Jul 2021 08:55:46 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id n12sm4180006wmq.5.2021.07.02.08.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jul 2021 08:55:45 -0700 (PDT)
Date: Fri, 2 Jul 2021 11:55:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <20210702115430-mutt-send-email-mst@kernel.org>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210702150555.2401722-6-ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Wen Xiong <wenxiong@us.ibm.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
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

On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> blk-mq needs to know if the device uses managed irq, so add one field
> to virtio_device for recording if device uses managed irq.
> 
> If the driver use managed irq, this flag has to be set so it can be
> passed to blk-mq.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>


The API seems somewhat confusing. virtio does not request
a managed irq as such, does it? I think it's a decision taken
by the irq core.

Any way to query the irq to find out if it's managed?


> ---
>  drivers/block/virtio_blk.c         | 2 ++
>  drivers/scsi/virtio_scsi.c         | 1 +
>  drivers/virtio/virtio_pci_common.c | 1 +
>  include/linux/virtio.h             | 1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e4bd3b1fc3c2..33b9c80ac475 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -764,6 +764,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.queue_depth = queue_depth;
>  	vblk->tag_set.numa_node = NUMA_NO_NODE;
>  	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	if (vdev->use_managed_irq)
> +		vblk->tag_set.flags |= BLK_MQ_F_MANAGED_IRQ;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * sg_elems;
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index b9c86a7e3b97..f301917abc84 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -891,6 +891,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	shost->max_channel = 0;
>  	shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
>  	shost->nr_hw_queues = num_queues;
> +	shost->use_managed_irq = vdev->use_managed_irq;
>  
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (virtio_has_feature(vdev, VIRTIO_SCSI_F_T10_PI)) {
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 222d630c41fc..f2ac48fb477b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	if (desc) {
>  		flags |= PCI_IRQ_AFFINITY;
>  		desc->pre_vectors++; /* virtio config vector */
> +		vdev->use_managed_irq = true;
>  	}
>  
>  	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..85cc773b2dc7 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -109,6 +109,7 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool use_managed_irq;
>  	spinlock_t config_lock;
>  	struct device dev;
>  	struct virtio_device_id id;
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
