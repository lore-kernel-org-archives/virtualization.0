Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0093164D4
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790568; cv=none; b=sGtH5k3uuP8oc59Kqf1HH80sXKkRaS77chCQLtDh6Oga+wmEEcbsyQBVr6y3kNAGgSN4dQPiUva6Yh4HGgMEHO31UpK+zmYYZSFNE9XOqnCoIVGd9QW2PxVuPGckGFROJJFT+R/20yhck2//xXJjcZ7Q41v27ZhjO45ZH/8UV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790568; c=relaxed/simple;
	bh=gehgadIBMbFmn8YSj3oqxxVXX2aJs9/yB4l+Ewe5+ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LOtW1h/HvRGWdpXDmWAy1OKdGx45YaXNYR2GlzSkZwlxWCjUWAUYGNuNOWrcP0YDfG2S9+eP6k8yU8/1iPA8zBEF8DTpL1M0tQtTm+UYNnjggj7k/cM6sol7RXjiiQdFM5aI2ONxOgKsT6SJl718yHIOJAnD6ffazLLI7rdkDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwSd/kSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwSd/kSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764790563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDKHvUOu0bFuY++4nzgZHrOJ+vb0qWUG2Nb3Tv/ozOk=;
	b=SwSd/kSAsXqvDyn7mbzTPylzvdiYavlIQJwOnFdePdeHtMMb1986JxXOxxOaoOOhwtseQ6
	lEKm5VI6hFjMt0NkNnt89KKg7siDD+ZBueIJkWBn2Haagg8m3C6aL7qfnwS14yQkMeG2IN
	njRgxKYl0nu26xj9OWSE5QYw0JmidAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-VEc2kqUYOvu_iZtZK8ldZw-1; Wed, 03 Dec 2025 14:36:02 -0500
X-MC-Unique: VEc2kqUYOvu_iZtZK8ldZw-1
X-Mimecast-MFC-AGG-ID: VEc2kqUYOvu_iZtZK8ldZw_1764790561
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso1006475e9.2
        for <virtualization@lists.linux.dev>; Wed, 03 Dec 2025 11:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764790561; x=1765395361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDKHvUOu0bFuY++4nzgZHrOJ+vb0qWUG2Nb3Tv/ozOk=;
        b=G2lA7vGFGupfq5FGtcqqGylSOkGv4tKE0w+dGW4IOe13RqTtHQa3Qugx95ZUYjMikR
         slktOv+5Mtc7xNhSHGXxs8hlWgb21DZ63Jm6OBM3eNtr0vaBNzeQnKdUZZcGdS1hsKnr
         tlr2swd6GkJjx8Z1GcbSztUf5Hfxhz7pyNPlxnNkNo7plXuy/NMgmr8qCuNms0f0GPy6
         QTbtmUN9rsLemzq5848GYjc/f8hkQuoISWvf3jfMjn/zYa9xj+QO/dJ9OdvMUaHjTWNj
         gmuCBra0JJhaHzS0NukZed+BbHkqTQSNyHgbzB/1OfgDl62FKLyoycf73ehri1QlzZNO
         kEmw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJkPvmydCvBBaspYXIhbZvEt/DzfmIQoLZXKKyY1OeXF1OGbtjPvEfluSAW4vCe3LxgHo0Ev10u1k5XITyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yys8K5bn+X+XZIUovR2e8Qq2z/brZs2bHmQEROaRvLenCu4dF26
	fTRldsgkokfKogYzKl3ayahnQYSEy+q3EIHepI29/vIVP2KOnOnkIvKKLJBpIF+Y37DDJtEbf2h
	aU2MVE47UwWky3nVfY6K9QqBQ4S9g/pGtpQnyjXrFe/IUX1Ljr6QstYsKz0tP6+ZZLPrA
X-Gm-Gg: ASbGncvQJj7wsHzurb66dCCBeVnPpmB5ABdsGyhPP//pVQ+nCQ+kn1m2T7O9Lti2+UN
	TqZyje+r/Kbj6sm+dyJHhd0Kq4MAZuSNHoCTz0oQXWogjnJqYnrzsnOFPevTnyZx7IndYxFart+
	ZOUNDqQDkUmTqzus/NPjqYIGynV6dfZnFfM3BZPBg02Rf5icdcouTlogjQ2AR473VRGrY+FOXNS
	v8gRNUlwfoB9pWDMAab0HpC7drDqkgqExSpTEx9HT7kCN9C0Axq6UuuIHauPL2N0cN3J3nc4cLz
	YfIpouY3w/2BRs8C0SzMn+VtL/2JqhtnBXK7CyqxQPW1hB4vslCktYjcMB59WFKIJg/UIYcrFfM
	=
X-Received: by 2002:a05:600c:3113:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-4792f39ccc1mr2881705e9.31.1764790560807;
        Wed, 03 Dec 2025 11:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2gMzUt3AciF37iQnu23AojUz8WmnCudBpsFCEq4S/0xBHIyrLxqqCXKRH83F2ZBI4cZjZkA==
X-Received: by 2002:a05:600c:3113:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-4792f39ccc1mr2881375e9.31.1764790560244;
        Wed, 03 Dec 2025 11:36:00 -0800 (PST)
Received: from redhat.com ([31.187.78.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792afd47b3sm22672645e9.0.2025.12.03.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:35:59 -0800 (PST)
Date: Wed, 3 Dec 2025 14:35:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, andersson@kernel.org,
	mathieu.poirier@linaro.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	virtualization@lists.linux.dev, xiaoxiang@xiaomi.com,
	Xiang Xiao <xiaoxiang781216@gmail.com>,
	arnaud.pouliquen@foss.st.com
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
Message-ID: <20251203142540-mutt-send-email-mst@kernel.org>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
 <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iqyHVY_GYxmWJf0MPTGBhk0WUUh6JZP3Z8J1Zo22Hms_1764790561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 03, 2025 at 12:12:46PM -0600, Tanmay Shah wrote:
> Hello,
> 
> Thanks for your reviews. Please find the response below.
> 
> On 11/22/25 6:05 AM, Zhongqiu Han wrote:
> > On 11/15/2025 2:46 AM, Tanmay Shah wrote:
> > > From: Xiang Xiao <xiaoxiang781216@gmail.com>
> > > 
> > > 512 bytes isn't always suitable for all case, let firmware
> > > maker decide the best value from resource table.
> > > enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> > > 
> > > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >   drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
> > >   include/linux/virtio_rpmsg.h     | 24 +++++++++++
> > >   2 files changed, 74 insertions(+), 18 deletions(-)
> > >   create mode 100644 include/linux/virtio_rpmsg.h
> > > 
> > > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/
> > > virtio_rpmsg_bus.c
> > > index cc26dfcc3e29..03dd5535880a 100644
> > > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > @@ -25,6 +25,7 @@
> > >   #include <linux/sched.h>
> > >   #include <linux/virtio.h>
> > >   #include <linux/virtio_ids.h>
> > > +#include <linux/virtio_rpmsg.h>
> > >   #include <linux/virtio_config.h>
> > >   #include <linux/wait.h>
> > > @@ -39,7 +40,8 @@
> > >    * @sbufs:    kernel address of tx buffers
> > >    * @num_rbufs:    total number of buffers for rx
> > >    * @num_sbufs:    total number of buffers for tx
> > > - * @buf_size:    size of one rx or tx buffer
> > > + * @rbuf_size:    size of one rx buffer
> > > + * @sbuf_size:    size of one tx buffer
> > >    * @last_sbuf:    index of last tx buffer used
> > >    * @bufs_dma:    dma base addr of the buffers
> > >    * @tx_lock:    protects svq, sbufs and sleepers, to allow
> > > concurrent senders.
> > > @@ -60,7 +62,8 @@ struct virtproc_info {
> > >       void *rbufs, *sbufs;
> > >       unsigned int num_rbufs;
> > >       unsigned int num_sbufs;
> > > -    unsigned int buf_size;
> > > +    unsigned int rbuf_size;
> > > +    unsigned int sbuf_size;
> > >       int last_sbuf;
> > >       dma_addr_t bufs_dma;
> > >       struct mutex tx_lock;
> > > @@ -70,9 +73,6 @@ struct virtproc_info {
> > >       atomic_t sleepers;
> > >   };
> > > -/* The feature bitmap for virtio rpmsg */
> > > -#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service
> > > notifications */
> > > -
> > >   /**
> > >    * struct rpmsg_hdr - common header for all rpmsg messages
> > >    * @src: source address
> > > @@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
> > >    * processor.
> > >    */
> > >   #define MAX_RPMSG_NUM_BUFS    (256)
> > > -#define MAX_RPMSG_BUF_SIZE    (512)
> > > +#define DEFAULT_RPMSG_BUF_SIZE    (512)
> > >   /*
> > >    * Local addresses are dynamically allocated on-demand.
> > > @@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
> > >       /* either pick the next unused tx buffer */
> > >       if (vrp->last_sbuf < vrp->num_sbufs)
> > > -        ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> > > +        ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
> > >       /* or recycle a used one */
> > >       else
> > >           ret = virtqueue_get_buf(vrp->svq, &len);
> > > @@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct
> > > rpmsg_device *rpdev,
> > >        * messaging), or to improve the buffer allocator, to support
> > >        * variable-length buffer sizes.
> > >        */
> > > -    if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> > > +    if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
> > >           dev_err(dev, "message is too big (%d)\n", len);
> > >           return -EMSGSIZE;
> > >       }
> > > @@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct
> > > rpmsg_endpoint *ept)
> > >       struct rpmsg_device *rpdev = ept->rpdev;
> > >       struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> > > -    return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
> > > +    return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
> > >   }
> > >   static int rpmsg_recv_single(struct virtproc_info *vrp, struct
> > > device *dev,
> > > @@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct
> > > virtproc_info *vrp, struct device *dev,
> > >        * We currently use fixed-sized buffers, so trivially sanitize
> > >        * the reported payload length.
> > >        */
> > > -    if (len > vrp->buf_size ||
> > > +    if (len > vrp->rbuf_size ||
> > >           msg_len > (len - sizeof(struct rpmsg_hdr))) {
> > >           dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
> > >           return -EINVAL;
> > > @@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct
> > > virtproc_info *vrp, struct device *dev,
> > >           dev_warn_ratelimited(dev, "msg received with no recipient\n");
> > >       /* publish the real size of the buffer */
> > > -    rpmsg_sg_init(&sg, msg, vrp->buf_size);
> > > +    rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
> > >       /* add the buffer back to the remote processor's virtqueue */
> > >       err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> > > @@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > >       else
> > >           vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
> > > -    vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> > > +    /*
> > > +     * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
> > > +     * size from virtio device config space from the resource table.
> > > +     * If the feature is not supported, then assign default buf size.
> > > +     */
> > > +    if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> > > +        /* note: virtio_rpmsg_config is defined from remote view */
> > > +        virtio_cread(vdev, struct virtio_rpmsg_config,
> > > +                 txbuf_size, &vrp->rbuf_size);
> > > +        virtio_cread(vdev, struct virtio_rpmsg_config,
> > > +                 rxbuf_size, &vrp->sbuf_size);
> > > +
> > > +        /* The buffers must hold rpmsg header atleast */
> > > +        if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
> > > +            vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
> > 
> > 
> > Hello Tanmay,
> > 
> > May I know if the omission of = here is to accommodate the ping/pong/ack
> > scenarios? mtu will 0
> > 
> > 
> 
> Yes. At minimum RPMsg header is needed to ping the correct endpoint. We
> don't need to have any payload attached to the packet. MTU will be sizeof
> rpmsg_hdr I think.
> 
> > > +            dev_err(&vdev->dev,
> > > +                "vdev config: rx buf sz = %d, tx buf sz = %d\n",
> > > +                vrp->rbuf_size, vrp->sbuf_size);
> > > +            err = -EINVAL;
> > > +            goto vqs_del;
> > > +        }
> > > +
> > > +        dev_dbg(&vdev->dev,
> > > +            "vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
> > > +            vrp->rbuf_size, vrp->sbuf_size);
> > > +    } else {
> > > +        vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> > > +        vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> > > +    }
> > > -    total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
> > > +    total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> > > +              (vrp->num_sbufs * vrp->sbuf_size);
> > > +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
> > >       /* allocate coherent memory for the buffers */
> > >       bufs_va = dma_alloc_coherent(vdev->dev.parent,
> > > @@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > >       vrp->rbufs = bufs_va;
> > >       /* and second part is dedicated for TX */
> > > -    vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
> > > +    vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
> > >       /* set up the receive buffers */
> > >       for (i = 0; i < vrp->num_rbufs; i++) {
> > >           struct scatterlist sg;
> > > -        void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> > > +        void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
> > > -        rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> > > +        rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
> > >           err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
> > >                         GFP_KERNEL);
> > > @@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct device
> > > *dev, void *data)
> > >   static void rpmsg_remove(struct virtio_device *vdev)
> > >   {
> > >       struct virtproc_info *vrp = vdev->priv;
> > > -    unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> > > -    size_t total_buf_space = num_bufs * vrp->buf_size;
> > > +    size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> > > +                 (vrp->num_sbufs * vrp->sbuf_size);
> > >       int ret;
> > >       virtio_reset_device(vdev);
> > > @@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct virtio_device
> > > *vdev)
> > >       vdev->config->del_vqs(vrp->vdev);
> > > +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
> > >       dma_free_coherent(vdev->dev.parent, total_buf_space,
> > >                 vrp->rbufs, vrp->bufs_dma);
> > > @@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
> > >   static unsigned int features[] = {
> > >       VIRTIO_RPMSG_F_NS,
> > > +    VIRTIO_RPMSG_F_BUFSZ,
> > >   };
> > >   static struct virtio_driver virtio_ipc_driver = {
> > > diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
> > > new file mode 100644
> > > index 000000000000..6406bc505383
> > > --- /dev/null
> > > +++ b/include/linux/virtio_rpmsg.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > 
> > 
> > Echo Arnaud's comments. If it is intended for UAPI, please keep it in
> > include/uapi/linux
> > 
> > 
> 
> It's not intended for UAPI. I need to fix the license. I will check other
> virtio headers in the same directory and fix the license accordingly.
> 
> > > +/*
> > > + * Copyright (C) Pinecone Inc. 2019
> > > + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> > > + */
> > > +
> > > +#ifndef _LINUX_VIRTIO_RPMSG_H
> > > +#define _LINUX_VIRTIO_RPMSG_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +/* The feature bitmap for virtio rpmsg */
> > > +#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service
> > > notifications */
> > > +#define VIRTIO_RPMSG_F_BUFSZ    2 /* RP get buffer size from config
> > > space */
> > 
> > May I know why skip bit 1?
> > 
> > 
> 
> Thanks, that's a good question. I keept id 2 unmodified from the original
> series. I don't know why ID 2 was chosen in the original series. I will have
> to discuss this with the linux remoteproc/rpmsg maintainers and choose the
> correct ID.
> 
> I don't see any problem choosing ID 1, but for some reason if ID 1 was
> assigned and deprecated (I don't think that is the case) then only we should
> use ID 2.
> 
> 
> Arnaud, Mathieu, Bjorn any input here?
> 
> > > +
> > > +struct virtio_rpmsg_config {
> > > +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> > > +    __u32 txbuf_size;
> > > +    __u32 rxbuf_size;
> > > +    __u32 reserved[14]; /* Reserve for the future use */
> > 
> > Should we use __virtio32 instead of __u32 to avoid endianness issues?
> > 
> > 
> 
> Sure, if that is the standard in other virtio headers I will modify it.
> 
> Thanks,
> Tanmay

rpmsg is still not standardized, sadly. It's really time it was.



Modern virtio devices use __le32.
Accordingly, accessed with virtio_cread_le


__virtioXX and virtio_cread are for legacy compatible parts of config space.


Does rpmsg want to be modern or keep using legacy? I donnu.

Ideally it should finally be documented and at that point we
definitely will want to switch to __le32.


For now, run sparse to make sure you don't introduce new endian-ness
issues.


> > > +    /* Put the customize config here */
> > > +} __attribute__((packed));
> > > +
> > > +#endif /* _LINUX_VIRTIO_RPMSG_H */
> > 
> > 

