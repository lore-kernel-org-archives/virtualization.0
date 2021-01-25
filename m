Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0987C433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 15:22:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CE0230FB
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 15:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CE0230FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6ED8885108;
	Mon, 25 Jan 2021 15:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CkyM5Q57PhiD; Mon, 25 Jan 2021 15:22:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40C3083616;
	Mon, 25 Jan 2021 15:22:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 223EBC0FA7;
	Mon, 25 Jan 2021 15:22:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77EDDC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 15:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 63BA921080
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 15:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fIrCPOihT+tZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 15:22:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 580E52094B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 15:22:36 +0000 (UTC)
IronPort-SDR: aKlrFupRGIYaKS1Ogr2ucrbxmB4O/S057bgosf0/AMC1eSjh+EW8dRH5tLdcap5Av9K5vfVm/8
 TTKMhOBG1yEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="243821026"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="243821026"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 07:22:34 -0800
IronPort-SDR: 8WpENlprasTwGdn1IpnJ+hSGeBtjOW2PW6rWNwPVFGu/1Qxn1yCzSif1DipU3vaw8K+C0ZPZvd
 sJeeCjxWmczA==
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="361543359"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.249.45.174])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 07:22:30 -0800
Date: Mon, 25 Jan 2021 16:22:27 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [PATCH v2 3/9] ALSA: virtio: handling control messages
In-Reply-To: <20210124165408.1122868-4-anton.yakovlev@opensynergy.com>
Message-ID: <7436cb6-111c-4ac5-88ee-8e103ded954b@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-4-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

I think the use of (devm_)kmalloc() and friends needs some refinement in 
several patches in the series.

On Sun, 24 Jan 2021, Anton Yakovlev wrote:

> The control queue can be used by different parts of the driver to send
> commands to the device. Control messages can be either synchronous or
> asynchronous. The lifetime of a message is controlled by a reference
> count.
>
> Introduce a module parameter to set the message completion timeout:
>  msg_timeout_ms [=1000]
>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
> sound/virtio/Makefile         |   3 +-
> sound/virtio/virtio_card.c    |  20 +++
> sound/virtio/virtio_card.h    |   7 +
> sound/virtio/virtio_ctl_msg.c | 293 ++++++++++++++++++++++++++++++++++
> sound/virtio/virtio_ctl_msg.h | 122 ++++++++++++++
> 5 files changed, 444 insertions(+), 1 deletion(-)
> create mode 100644 sound/virtio/virtio_ctl_msg.c
> create mode 100644 sound/virtio/virtio_ctl_msg.h

[snip]

> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> new file mode 100644
> index 000000000000..c1701756bc32
> --- /dev/null
> +++ b/sound/virtio/virtio_ctl_msg.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Sound card driver for virtio
> + * Copyright (C) 2020  OpenSynergy GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify

Same comment about licence, and in other patches as well.

> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/moduleparam.h>
> +#include <linux/virtio_config.h>
> +
> +#include "virtio_card.h"
> +#include "virtio_ctl_msg.h"
> +
> +/**
> + * virtsnd_ctl_msg_alloc_ext() - Allocate and initialize a control message.
> + * @vdev: VirtIO parent device.
> + * @request_size: Size of request header (pointed to by sg_request field).
> + * @response_size: Size of response header (pointed to by sg_response field).
> + * @sgs: Additional data to attach to the message (may be NULL).
> + * @out_sgs: Number of scattergather elements to attach to the request header.
> + * @in_sgs: Number of scattergather elements to attach to the response header.
> + * @gfp: Kernel flags for memory allocation.
> + *
> + * The message will be automatically freed when the ref_count value is 0.
> + *
> + * Context: Any context. May sleep if @gfp flags permit.
> + * Return: Allocated message on success, ERR_PTR(-errno) on failure.
> + */
> +struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device *vdev,
> +						 size_t request_size,
> +						 size_t response_size,
> +						 struct scatterlist *sgs,
> +						 unsigned int out_sgs,
> +						 unsigned int in_sgs, gfp_t gfp)
> +{
> +	struct virtio_snd_msg *msg;
> +	size_t msg_size =
> +		sizeof(*msg) + (1 + out_sgs + 1 + in_sgs) * sizeof(*msg->sgs);
> +	unsigned int i;
> +
> +	msg = devm_kzalloc(&vdev->dev, msg_size + request_size + response_size,
> +			   gfp);

Messages are short-lived, right? So, I think their allocation and freeing 
has to be explicit, no need for devm_.

> +	if (!msg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sg_init_one(&msg->sg_request, (u8 *)msg + msg_size, request_size);
> +	sg_init_one(&msg->sg_response, (u8 *)msg + msg_size + request_size,
> +		    response_size);
> +
> +	INIT_LIST_HEAD(&msg->list);
> +	init_completion(&msg->notify);
> +	atomic_set(&msg->ref_count, 1);
> +
> +	msg->sgs[msg->out_sgs++] = &msg->sg_request;
> +	if (sgs)
> +		for (i = 0; i < out_sgs; ++i)
> +			msg->sgs[msg->out_sgs++] = &sgs[i];
> +
> +	msg->sgs[msg->out_sgs + msg->in_sgs++] = &msg->sg_response;
> +	if (sgs)
> +		for (i = out_sgs; i < out_sgs + in_sgs; ++i)
> +			msg->sgs[msg->out_sgs + msg->in_sgs++] = &sgs[i];
> +
> +	return msg;
> +}
> +
> +/**
> + * virtsnd_ctl_msg_send() - Send an (asynchronous) control message.
> + * @snd: VirtIO sound device.
> + * @msg: Control message.
> + *
> + * If a message is failed to be enqueued, it will be deleted. If message content
> + * is still needed, the caller must additionally to virtsnd_ctl_msg_ref/unref()
> + * it.
> + *
> + * Context: Any context. Takes and releases the control queue spinlock.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
> +	struct virtio_snd_hdr *response = sg_virt(&msg->sg_response);
> +	bool notify = false;
> +	unsigned long flags;
> +	int rc = -EIO;
> +
> +	/* Set the default status in case the message was not sent or was
> +	 * canceled.
> +	 */
> +	response->code = cpu_to_virtio32(vdev, VIRTIO_SND_S_IO_ERR);
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	if (queue->vqueue) {

Is it allowed for queue->vqueue to be NULL?

> +		rc = virtqueue_add_sgs(queue->vqueue, msg->sgs, msg->out_sgs,
> +				       msg->in_sgs, msg, GFP_ATOMIC);
> +		if (!rc) {
> +			notify = virtqueue_kick_prepare(queue->vqueue);
> +			list_add_tail(&msg->list, &snd->ctl_msgs);
> +		}
> +	}
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	if (!rc) {
> +		if (!notify || virtqueue_notify(queue->vqueue))
> +			return 0;
> +
> +		spin_lock_irqsave(&queue->lock, flags);
> +		list_del(&msg->list);
> +		spin_unlock_irqrestore(&queue->lock, flags);
> +	}
> +
> +	virtsnd_ctl_msg_unref(snd->vdev, msg);
> +
> +	return -EIO;

wouldn't "return rc" be better here?

> +}
> +
> +/**
> + * virtsnd_ctl_msg_send_sync() - Send a (synchronous) control message.
> + * @snd: VirtIO sound device.
> + * @msg: Control message.
> + *
> + * After returning from this function, the message will be deleted. If message
> + * content is still needed, the caller must additionally to
> + * virtsnd_ctl_msg_ref/unref() it.
> + *
> + * The msg_timeout_ms module parameter defines the message completion timeout.
> + * If the message is not completed within this time, the function will return an
> + * error.
> + *
> + * Context: Any context. Takes and releases the control queue spinlock.
> + * Return: 0 on success, -errno on failure.
> + *
> + * The return value is a message status code (VIRTIO_SND_S_XXX) converted to an
> + * appropriate -errno value.
> + */
> +int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
> +			      struct virtio_snd_msg *msg)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
> +	struct virtio_snd_hdr *response;
> +	int rc;
> +
> +	virtsnd_ctl_msg_ref(vdev, msg);
> +
> +	rc = virtsnd_ctl_msg_send(snd, msg);
> +	if (rc)
> +		goto on_failure;
> +
> +	rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
> +	if (rc <= 0) {
> +		if (!rc) {
> +			struct virtio_snd_hdr *request =
> +				sg_virt(&msg->sg_request);
> +
> +			dev_err(&vdev->dev,
> +				"control message (0x%08x) timeout\n",
> +				le32_to_cpu(request->code));
> +			rc = -EIO;

Wouldn't -ETIMEDOUT be better here?

> +		}
> +
> +		goto on_failure;
> +	}
> +
> +	response = sg_virt(&msg->sg_response);
> +
> +	switch (le32_to_cpu(response->code)) {
> +	case VIRTIO_SND_S_OK:
> +		rc = 0;
> +		break;
> +	case VIRTIO_SND_S_BAD_MSG:
> +		rc = -EINVAL;
> +		break;
> +	case VIRTIO_SND_S_NOT_SUPP:
> +		rc = -EOPNOTSUPP;
> +		break;
> +	case VIRTIO_SND_S_IO_ERR:
> +		rc = -EIO;
> +		break;
> +	default:
> +		rc = -EPERM;

any special reason for EPERM as a default error code? I think often EINVAL 
is used in similar cases.

> +		break;
> +	}
> +
> +on_failure:

cosmetic: this path is also taken on success, so maybe better just call 
the lable "exit" or similar.

> +	virtsnd_ctl_msg_unref(vdev, msg);
> +
> +	return rc;
> +}
> +
> +/**
> + * virtsnd_ctl_msg_complete() - Complete a control message.
> + * @snd: VirtIO sound device.
> + * @msg: Control message.
> + *
> + * Context: Any context.
> + */
> +void virtsnd_ctl_msg_complete(struct virtio_snd *snd,
> +			      struct virtio_snd_msg *msg)
> +{
> +	list_del(&msg->list);
> +	complete(&msg->notify);
> +
> +	virtsnd_ctl_msg_unref(snd->vdev, msg);
> +}
> +
> +/**
> + * virtsnd_ctl_query_info() - Query the item configuration from the device.
> + * @snd: VirtIO sound device.
> + * @command: Control request code (VIRTIO_SND_R_XXX_INFO).
> + * @start_id: Item start identifier.
> + * @count: Item count to query.
> + * @size: Item information size in bytes.
> + * @info: Buffer for storing item information.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
> +			   int count, size_t size, void *info)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtio_snd_msg *msg;
> +	struct virtio_snd_query_info *query;
> +	struct scatterlist sg;
> +
> +	sg_init_one(&sg, info, count * size);
> +
> +	msg = virtsnd_ctl_msg_alloc_ext(vdev, sizeof(*query),
> +					sizeof(struct virtio_snd_hdr), &sg, 0,
> +					1, GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	query = sg_virt(&msg->sg_request);
> +	query->hdr.code = cpu_to_virtio32(vdev, command);
> +	query->start_id = cpu_to_virtio32(vdev, start_id);
> +	query->count = cpu_to_virtio32(vdev, count);
> +	query->size = cpu_to_virtio32(vdev, size);
> +
> +	return virtsnd_ctl_msg_send_sync(snd, msg);
> +}
> +
> +/**
> + * virtsnd_ctl_notify_cb() - Process all completed control messages.
> + * @vqueue: Underlying control virtqueue.
> + *
> + * This callback function is called upon a vring interrupt request from the
> + * device.
> + *
> + * Context: Interrupt context. Takes and releases the control queue spinlock.
> + */
> +void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
> +{
> +	struct virtio_snd *snd = vqueue->vdev->priv;
> +	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	while (queue->vqueue) {
> +		virtqueue_disable_cb(queue->vqueue);
> +
> +		for (;;) {
> +			struct virtio_snd_msg *msg;
> +			u32 length;
> +
> +			msg = virtqueue_get_buf(queue->vqueue, &length);
> +			if (!msg)
> +				break;
> +
> +			virtsnd_ctl_msg_complete(snd, msg);
> +		}
> +
> +		if (unlikely(virtqueue_is_broken(queue->vqueue)))
> +			break;
> +
> +		if (virtqueue_enable_cb(queue->vqueue))
> +			break;
> +	}
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +}
> diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
> new file mode 100644
> index 000000000000..0f8de8f2fd2d
> --- /dev/null
> +++ b/sound/virtio/virtio_ctl_msg.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Sound card driver for virtio
> + * Copyright (C) 2020  OpenSynergy GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef VIRTIO_SND_MSG_H
> +#define VIRTIO_SND_MSG_H
> +
> +#include <linux/atomic.h>
> +#include <linux/virtio.h>
> +
> +struct virtio_snd;
> +
> +/**
> + * struct virtio_snd_msg - Control message.
> + * @sg_request: Scattergather element containing a device request (header).
> + * @sg_response: Scattergather element containing a device response (status).
> + * @list: Pending message list entry.
> + * @notify: Request completed notification.
> + * @ref_count: Reference count used to manage a message lifetime.
> + * @out_sgs: Number of read-only sg elements in the sgs array.
> + * @in_sgs: Number of write-only sg elements in the sgs array.
> + * @sgs: Array of sg elements to add to the control virtqueue.
> + */
> +struct virtio_snd_msg {
> +/* public: */
> +	struct scatterlist sg_request;
> +	struct scatterlist sg_response;
> +/* private: internal use only */
> +	struct list_head list;
> +	struct completion notify;
> +	atomic_t ref_count;
> +	unsigned int out_sgs;
> +	unsigned int in_sgs;
> +	struct scatterlist *sgs[0];
> +};
> +
> +/**
> + * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
> + * @vdev: VirtIO parent device.
> + * @msg: Control message.
> + *
> + * Context: Any context.
> + */
> +static inline void virtsnd_ctl_msg_ref(struct virtio_device *vdev,
> +				       struct virtio_snd_msg *msg)
> +{
> +	atomic_inc(&msg->ref_count);
> +}
> +
> +/**
> + * virtsnd_ctl_msg_unref() - Decrement reference counter for the message.
> + * @vdev: VirtIO parent device.
> + * @msg: Control message.
> + *
> + * The message will be freed when the ref_count value is 0.
> + *
> + * Context: Any context.
> + */
> +static inline void virtsnd_ctl_msg_unref(struct virtio_device *vdev,
> +					 struct virtio_snd_msg *msg)
> +{
> +	if (!atomic_dec_return(&msg->ref_count))

Since you use atomic operations, this function can probably be called with 
no additional locking right? But if so, couldn't it be preempted here 
between the check and the call to kfree()? As was mentioned in a previous 
review, the use of atomic operations in this series has to be very 
carefully examined...

Thanks
Guennadi

> +		devm_kfree(&vdev->dev, msg);
> +}
> +
> +struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device *vdev,
> +						 size_t request_size,
> +						 size_t response_size,
> +						 struct scatterlist *sgs,
> +						 unsigned int out_sgs,
> +						 unsigned int in_sgs,
> +						 gfp_t gfp);
> +
> +/**
> + * virtsnd_ctl_msg_alloc() - Simplified control message allocation.
> + * @vdev: VirtIO parent device.
> + * @request_size: Size of request header (pointed to by sg_request field).
> + * @response_size: Size of response header (pointed to by sg_response field).
> + * @gfp: Kernel flags for memory allocation.
> + *
> + * The message will be automatically freed when the ref_count value is 0.
> + *
> + * Context: Any context. May sleep if @gfp flags permit.
> + * Return: Allocated message on success, ERR_PTR(-errno) on failure.
> + */
> +static inline
> +struct virtio_snd_msg *virtsnd_ctl_msg_alloc(struct virtio_device *vdev,
> +					     size_t request_size,
> +					     size_t response_size, gfp_t gfp)
> +{
> +	return virtsnd_ctl_msg_alloc_ext(vdev, request_size, response_size,
> +					 NULL, 0, 0, gfp);
> +}
> +
> +int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg);
> +
> +int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
> +			      struct virtio_snd_msg *msg);
> +
> +void virtsnd_ctl_msg_complete(struct virtio_snd *snd,
> +			      struct virtio_snd_msg *msg);
> +
> +int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
> +			   int count, size_t size, void *info);
> +
> +void virtsnd_ctl_notify_cb(struct virtqueue *vqueue);
> +
> +#endif /* VIRTIO_SND_MSG_H */
> -- 
> 2.30.0
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
