Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5900CC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 15:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE474606E6;
	Mon, 30 Oct 2023 15:57:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE474606E6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRtxG2Qg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MaKh4VZ6wQwy; Mon, 30 Oct 2023 15:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E01C60671;
	Mon, 30 Oct 2023 15:57:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E01C60671
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00BF4C0071;
	Mon, 30 Oct 2023 15:57:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29855C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0505B60671
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:57:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0505B60671
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NxTp0mhQ2RXT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:57:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15CB5605E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:57:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15CB5605E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698681470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8sHtTWZUCIDjC7jG/MuG3zJdM3yAjFtAbzIAft3DUSY=;
 b=gRtxG2QgCLj6uohe7KZfZz6eHWfmYI1Bk7MwmqsNXfVsMo+8cAP2VzIx6c+lfkd1ZPM5RB
 Fnwf3RWW/IU2GV+Jrr7TCronfNcelPYoW2Qb1+QKi7MJBkGCF6zpA8irLNZHciER9KGqOp
 PJmobeQFoLI/tlmsh+jc+pbU554HUJY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-lpxiTpRcNZqQpj4kBfIFUQ-1; Mon, 30 Oct 2023 11:57:48 -0400
X-MC-Unique: lpxiTpRcNZqQpj4kBfIFUQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so34035025e9.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 08:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698681467; x=1699286267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sHtTWZUCIDjC7jG/MuG3zJdM3yAjFtAbzIAft3DUSY=;
 b=gn/XNMLpyduc7vjTkkNg/42l0OovnxtMFOpzfNsRrF2mZ364B9o6ezOGyLHD8hDahx
 axgfd5umIr1N9O/mIabUDrByf7+ja/NQ9ypqqNxTjhPyArchK7/atz9e7JTDjXnCytlO
 0fohzpn106D8xfX9FL1igxikJ5l+joup61QNWwizBMj7zdWHaJt2daR+hFdAJ/BkHZUy
 EFiVx0LKABru4xZw05d45Viv2b+qIjgbG5HOSvFcdlDs79n8zuszHLZkFMcCK2C6aphk
 b9YeJAn9w3BQFsV6b9Wvmb8gnFcYmiBua3lmeExchZjNb0H0PXzU1wpshz8Tzi77N1Lx
 TohQ==
X-Gm-Message-State: AOJu0YyPnvtLYhIezxZHKzWfzP96dzf8h2OhFL/dS16jyBAIPSaLuNIy
 7BAi2lqhtbwCiJp4TnSTNJPLjmg40SR7l7nkJ96KoLs4pun7QQOMAxMEqXRTHHLGhhP+tkJ7q0Z
 etVfWigAqyGD7mIBoTpeZ0M0h9bVTd2XeyUw+UKDgVw==
X-Received: by 2002:a05:600c:5489:b0:402:f5c4:2e5a with SMTP id
 iv9-20020a05600c548900b00402f5c42e5amr9239981wmb.37.1698681467229; 
 Mon, 30 Oct 2023 08:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2/G3sIUwlvcydndQUuADuWDEzmKhZqtxs6hN9gu+k+Zil/0FmG6DLry9A0uZM4/jyoUeWrA==
X-Received: by 2002:a05:600c:5489:b0:402:f5c4:2e5a with SMTP id
 iv9-20020a05600c548900b00402f5c42e5amr9239960wmb.37.1698681466866; 
 Mon, 30 Oct 2023 08:57:46 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 bg9-20020a05600c3c8900b004063cd8105csm13187238wmb.22.2023.10.30.08.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:57:45 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:57:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin
 commands
Message-ID: <20231030115541-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-6-yishaih@nvidia.com>
 <20231029160750-mutt-send-email-mst@kernel.org>
 <bb8df2c8-74b5-4666-beda-550248a88890@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <bb8df2c8-74b5-4666-beda-550248a88890@nvidia.com>
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

On Mon, Oct 30, 2023 at 05:27:50PM +0200, Yishai Hadas wrote:
> On 29/10/2023 22:17, Michael S. Tsirkin wrote:
> > On Sun, Oct 29, 2023 at 05:59:48PM +0200, Yishai Hadas wrote:
> > > Initialize the supported admin commands upon activating the admin queue.
> > > 
> > > The supported commands are saved as part of the admin queue context, it
> > > will be used by the next patches from this series.
> > > 
> > > Note:
> > > As we don't want to let upper layers to execute admin commands before
> > > that this initialization step was completed, we set ref count to 1 only
> > > post of that flow and use a non ref counted version command for this
> > > internal flow.
> > > 
> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > ---
> > >   drivers/virtio/virtio_pci_common.h |  1 +
> > >   drivers/virtio/virtio_pci_modern.c | 77 +++++++++++++++++++++++++++++-
> > >   2 files changed, 77 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > index a21b9ba01a60..9e07e556a51a 100644
> > > --- a/drivers/virtio/virtio_pci_common.h
> > > +++ b/drivers/virtio/virtio_pci_common.h
> > > @@ -46,6 +46,7 @@ struct virtio_pci_admin_vq {
> > >   	struct virtio_pci_vq_info info;
> > >   	struct completion flush_done;
> > >   	refcount_t refcount;
> > > +	u64 supported_cmds;
> > >   	/* Name of the admin queue: avq.$index. */
> > >   	char name[10];
> > >   	u16 vq_index;
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index ccd7a4d9f57f..25e27aa79cab 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -19,6 +19,9 @@
> > >   #define VIRTIO_RING_NO_LEGACY
> > >   #include "virtio_pci_common.h"
> > > +static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> > > +				    struct virtio_admin_cmd *cmd);
> > > +
> > I don't much like forward declarations. Just order functions sensibly
> > and they will not be needed.
> 
> OK, will be part of V3.
> 
> > 
> > >   static u64 vp_get_features(struct virtio_device *vdev)
> > >   {
> > >   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > @@ -59,6 +62,42 @@ vp_modern_avq_set_abort(struct virtio_pci_admin_vq *admin_vq, bool abort)
> > >   	WRITE_ONCE(admin_vq->abort, abort);
> > >   }
> > > +static void virtio_pci_admin_init_cmd_list(struct virtio_device *virtio_dev)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
> > > +	struct virtio_admin_cmd cmd = {};
> > > +	struct scatterlist result_sg;
> > > +	struct scatterlist data_sg;
> > > +	__le64 *data;
> > > +	int ret;
> > > +
> > > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > +	if (!data)
> > > +		return;
> > > +
> > > +	sg_init_one(&result_sg, data, sizeof(*data));
> > > +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_QUERY);
> > > +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
> > > +	cmd.result_sg = &result_sg;
> > > +
> > > +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> > > +	if (ret)
> > > +		goto end;
> > > +
> > > +	sg_init_one(&data_sg, data, sizeof(*data));
> > > +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_LIST_USE);
> > > +	cmd.data_sg = &data_sg;
> > > +	cmd.result_sg = NULL;
> > > +
> > > +	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
> > > +	if (ret)
> > > +		goto end;
> > > +
> > > +	vp_dev->admin_vq.supported_cmds = le64_to_cpu(*data);
> > > +end:
> > > +	kfree(data);
> > > +}
> > > +
> > >   static void vp_modern_avq_activate(struct virtio_device *vdev)
> > >   {
> > >   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > @@ -67,6 +106,7 @@ static void vp_modern_avq_activate(struct virtio_device *vdev)
> > >   	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> > >   		return;
> > > +	virtio_pci_admin_init_cmd_list(vdev);
> > >   	init_completion(&admin_vq->flush_done);
> > >   	refcount_set(&admin_vq->refcount, 1);
> > >   	vp_modern_avq_set_abort(admin_vq, false);
> > > @@ -562,6 +602,35 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
> > >   	return true;
> > >   }
> > > +static int __virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> > > +				    struct scatterlist **sgs,
> > > +				    unsigned int out_num,
> > > +				    unsigned int in_num,
> > > +				    void *data,
> > > +				    gfp_t gfp)
> > > +{
> > > +	struct virtqueue *vq;
> > > +	int ret, len;
> > > +
> > > +	vq = admin_vq->info.vq;
> > > +
> > > +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, data, gfp);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (unlikely(!virtqueue_kick(vq)))
> > > +		return -EIO;
> > > +
> > > +	while (!virtqueue_get_buf(vq, &len) &&
> > > +	       !virtqueue_is_broken(vq))
> > > +		cpu_relax();
> > > +
> > > +	if (virtqueue_is_broken(vq))
> > > +		return -EIO;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > 
> > This is tolerable I guess but it might pin the CPU for a long time.
> > The difficulty is handling suprize removal well which we currently
> > don't do with interrupts. I would say it's ok as is but add
> > a TODO comments along the lines of /* TODO: use interrupts once these virtqueue_is_broken */
> 
> I assume that you asked for adding the below comment before the while loop:
> /* TODO use interrupts to reduce cpu cycles in the future */
> 
> Right ?
> 
> Yishai

Well I wrote what I meant. in the future is redundant - everyone knows
we can't change the past.

> > 
> > >   static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
> > >   				    struct scatterlist **sgs,
> > >   				    unsigned int out_num,
> > > @@ -653,7 +722,13 @@ static int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
> > >   		in_num++;
> > >   	}
> > > -	ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> > > +	if (cmd->opcode == VIRTIO_ADMIN_CMD_LIST_QUERY ||
> > > +	    cmd->opcode == VIRTIO_ADMIN_CMD_LIST_USE)
> > > +		ret = __virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> > > +				       out_num, in_num,
> > > +				       sgs, GFP_KERNEL);
> > > +	else
> > > +		ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq, sgs,
> > >   				       out_num, in_num,
> > >   				       sgs, GFP_KERNEL);
> > >   	if (ret) {
> > > -- 
> > > 2.27.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
