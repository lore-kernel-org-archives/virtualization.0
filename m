Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530B3B1B3
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925002; cv=none; b=odGm/Waafe6oRErDbEPQtCFxaSgVu5dxgDBTL/2dtzQ4sHbNz8KSglcvkbIAq1X/eYL2p/6RYpGyFxdjPcJnVtKwsZaYIUHo4wHcZB58kGUkLc0c1ErqC870iryHUtvpgF1xPCQd/ttG/V3cf5aZCEo5BsiDDARo+qVTBAjtFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925002; c=relaxed/simple;
	bh=5m/koOPy6G0lZRWTJ4470I+GfRttX+2WNMqz69CcYKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx05YtKBYjGZdcX1Dn2SqpMJsAIiin9IrVBXAiYVBSvERJY53HjxEMpGuY1efS1GeaazifsNWpjrtKq7871foarphhZC0ghNZjGI40THRzomt2qxA56eaxyJGcbigVAJfWB7kWZYgl6ZpukvG7T1F831FBXQMJdWO1BN67ms4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXBHtTzJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXBHtTzJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4182383b3a.0
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 14:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765925000; x=1766529800; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pmhs9R5yujRMsXI7hGVvqKn/i96+V/UX6HQAMgAQFEQ=;
        b=UXBHtTzJdPNh8+4IjYkrNlUkwCjzpHQKl1T4VXgNYQx6hc/eIr3iaMNll1tz6E6i1L
         RjylFJ7Cf6W+YG516Yc50I5c82bUiRS1SpUe6oLlMp3QoM5mrDjQl0TJvFqD6jJ32sRX
         RP0F3kZukrdWFegg9VZ9G1c9NO0oNxx39OMuDwBZE4IoyuBosGnY00VzbnpoN2ACEwDJ
         fYsSvUoXUdnZJi/ecCLKFN0KIF4fgJO3rx8q20PqEbcaB1yqCk3VeLJLyhgieoTyVWIg
         eFmd+IXo9lzwutQNO5o4u3GkVRttRw2/+cKCg1PY0wXPyT+9JzshY2dsUWe3v66AH+yJ
         Yxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925000; x=1766529800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pmhs9R5yujRMsXI7hGVvqKn/i96+V/UX6HQAMgAQFEQ=;
        b=Pah9BEWA0vLTvD5PAKG3YX+8E3O12dGCAjwBYvo/gSHj5+FO3dpryiYiAZPL4iRBVk
         8bp0ZNODuWCAM4zUyjii9CaCCh2dHHWon0FFSnlGLINv16oeGA2QfSITF/kXWoCwlQwC
         4svjsxj0WT4VgjoEwc1vq8xAg2A2oqP2/OZijOhBIfZEH4wDyhZH6kYGh5dJppHQbdtt
         TVWUaCwTCxRpahyQv7OPh0Ipnd9HrTkd6Du00ZFZl2g6gLLjOHasqC3Tyzqza70sVZ6D
         lWQnzubIwJ7fyoR1FWky9FmQi4U+IkkBiAtV3sMOUurdAHoxZrfugmu0iM3PYT3QGjKs
         4e/w==
X-Forwarded-Encrypted: i=1; AJvYcCVT9oZHpakTSEruL7Z6FjSTc5wdGcxda7B1YClncAXfpOllvEzlJk9ceWM/n4diyENmB14QPO2K30lhSbwKnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLnnPP6aU9GR2RaobEttHVjRdubZq+vBrTJn1Oww4lJuhzd/Hu
	BbLvS3HyR62BDTZ8C1Nk9+qvcHZEwpTLQvfk+oR6w/vFogF6OMIZpVZxege9QHY1FIA=
X-Gm-Gg: AY/fxX734uN5AFSIv9BcW8efduhEPeMTreaIion0W1qFKeiJo6EA02xdH3+7pTPlu+4
	Q9Q8OHrzYfTzHy4TvB+Y4oqizkRcq9ljcKhLEJ513lDrB+NJEOTUUhfK0zml758HNBuZK6oY1Y2
	gZ6ZrJt3dHqn2NNn/wammhBqJRd1RAHWOHRMd3IET2Wea3mO/srlwRaRHyBpwa2ezSqQAkQKFnL
	ebhsJHrYyVa+J7vFXog2CmW2FRLIkDBudGme9SvN+GfqQJQvbhlXtA+w2igqxVZJt9kIG9SDgyY
	eS/XoXrUHwf06ZeRxGiNP7JuzjkpcvbGkXOFyMD3pRAkjuEYsyekjSJOoJmyp2ZHcy4dFwUW5VJ
	rdiXnhmnKxZqhpFASfvy1UjL2sG6zsG4q8Xp5/XZnKmKrg4H+ojmme9Yi2X1P/XELtcXN5qPaLL
	Mz1gFSZkgDlg8hUw==
X-Google-Smtp-Source: AGHT+IHNPXQ3Xi+tz8BLzdIHyswnzFSrmIiz2RKZNeo8HDdj6iPZTnOaGHAJ1FBKZe5fiFy0jIZHqw==
X-Received: by 2002:a05:6a00:b486:b0:7e8:43f5:bd57 with SMTP id d2e1a72fcca58-7f669c8d79bmr14641653b3a.67.1765924999794;
        Tue, 16 Dec 2025 14:43:19 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:ba5d:91e2:900a:fb01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb92f9686sm598475b3a.26.2025.12.16.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:43:19 -0800 (PST)
Date: Tue, 16 Dec 2025 15:43:16 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc: tanmay.shah@amd.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	andersson@kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	virtualization@lists.linux.dev, xiaoxiang@xiaomi.com,
	Xiang Xiao <xiaoxiang781216@gmail.com>
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
Message-ID: <aUHghNsj-GEAYUUx@p14s>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
 <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
 <324fdbe2-037a-4daa-84de-8b63dbac8117@foss.st.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <324fdbe2-037a-4daa-84de-8b63dbac8117@foss.st.com>

On Fri, Dec 05, 2025 at 05:01:17PM +0100, Arnaud POULIQUEN wrote:
> Hi,
> 
> On 12/3/25 19:12, Tanmay Shah wrote:
> > Hello,
> > 
> > Thanks for your reviews. Please find the response below.
> > 
> > On 11/22/25 6:05 AM, Zhongqiu Han wrote:
> > > On 11/15/2025 2:46 AM, Tanmay Shah wrote:
> > > > From: Xiang Xiao <xiaoxiang781216@gmail.com>
> > > > 
> > > > 512 bytes isn't always suitable for all case, let firmware
> > > > maker decide the best value from resource table.
> > > > enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> > > > 
> > > > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > ---
> > > >   drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
> > > >   include/linux/virtio_rpmsg.h     | 24 +++++++++++
> > > >   2 files changed, 74 insertions(+), 18 deletions(-)
> > > >   create mode 100644 include/linux/virtio_rpmsg.h
> > > > 
> > > > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/
> > > > virtio_rpmsg_bus.c
> > > > index cc26dfcc3e29..03dd5535880a 100644
> > > > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > @@ -25,6 +25,7 @@
> > > >   #include <linux/sched.h>
> > > >   #include <linux/virtio.h>
> > > >   #include <linux/virtio_ids.h>
> > > > +#include <linux/virtio_rpmsg.h>
> > > >   #include <linux/virtio_config.h>
> > > >   #include <linux/wait.h>
> > > > @@ -39,7 +40,8 @@
> > > >    * @sbufs:    kernel address of tx buffers
> > > >    * @num_rbufs:    total number of buffers for rx
> > > >    * @num_sbufs:    total number of buffers for tx
> > > > - * @buf_size:    size of one rx or tx buffer
> > > > + * @rbuf_size:    size of one rx buffer
> > > > + * @sbuf_size:    size of one tx buffer
> > > >    * @last_sbuf:    index of last tx buffer used
> > > >    * @bufs_dma:    dma base addr of the buffers
> > > >    * @tx_lock:    protects svq, sbufs and sleepers, to allow
> > > > concurrent senders.
> > > > @@ -60,7 +62,8 @@ struct virtproc_info {
> > > >       void *rbufs, *sbufs;
> > > >       unsigned int num_rbufs;
> > > >       unsigned int num_sbufs;
> > > > -    unsigned int buf_size;
> > > > +    unsigned int rbuf_size;
> > > > +    unsigned int sbuf_size;
> > > >       int last_sbuf;
> > > >       dma_addr_t bufs_dma;
> > > >       struct mutex tx_lock;
> > > > @@ -70,9 +73,6 @@ struct virtproc_info {
> > > >       atomic_t sleepers;
> > > >   };
> > > > -/* The feature bitmap for virtio rpmsg */
> > > > -#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service
> > > > notifications */
> > > > -
> > > >   /**
> > > >    * struct rpmsg_hdr - common header for all rpmsg messages
> > > >    * @src: source address
> > > > @@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
> > > >    * processor.
> > > >    */
> > > >   #define MAX_RPMSG_NUM_BUFS    (256)
> > > > -#define MAX_RPMSG_BUF_SIZE    (512)
> > > > +#define DEFAULT_RPMSG_BUF_SIZE    (512)
> > > >   /*
> > > >    * Local addresses are dynamically allocated on-demand.
> > > > @@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
> > > >       /* either pick the next unused tx buffer */
> > > >       if (vrp->last_sbuf < vrp->num_sbufs)
> > > > -        ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> > > > +        ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
> > > >       /* or recycle a used one */
> > > >       else
> > > >           ret = virtqueue_get_buf(vrp->svq, &len);
> > > > @@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct
> > > > rpmsg_device *rpdev,
> > > >        * messaging), or to improve the buffer allocator, to support
> > > >        * variable-length buffer sizes.
> > > >        */
> > > > -    if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> > > > +    if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
> > > >           dev_err(dev, "message is too big (%d)\n", len);
> > > >           return -EMSGSIZE;
> > > >       }
> > > > @@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct
> > > > rpmsg_endpoint *ept)
> > > >       struct rpmsg_device *rpdev = ept->rpdev;
> > > >       struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> > > > -    return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
> > > > +    return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
> > > >   }
> > > >   static int rpmsg_recv_single(struct virtproc_info *vrp, struct
> > > > device *dev,
> > > > @@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct
> > > > virtproc_info *vrp, struct device *dev,
> > > >        * We currently use fixed-sized buffers, so trivially sanitize
> > > >        * the reported payload length.
> > > >        */
> > > > -    if (len > vrp->buf_size ||
> > > > +    if (len > vrp->rbuf_size ||
> > > >           msg_len > (len - sizeof(struct rpmsg_hdr))) {
> > > >           dev_warn(dev, "inbound msg too big: (%d, %d)\n", len,
> > > > msg_len);
> > > >           return -EINVAL;
> > > > @@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct
> > > > virtproc_info *vrp, struct device *dev,
> > > >           dev_warn_ratelimited(dev, "msg received with no recipient\n");
> > > >       /* publish the real size of the buffer */
> > > > -    rpmsg_sg_init(&sg, msg, vrp->buf_size);
> > > > +    rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
> > > >       /* add the buffer back to the remote processor's virtqueue */
> > > >       err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> > > > @@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > >       else
> > > >           vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
> > > > -    vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> > > > +    /*
> > > > +     * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
> > > > +     * size from virtio device config space from the resource table.
> > > > +     * If the feature is not supported, then assign default buf size.
> > > > +     */
> > > > +    if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> > > > +        /* note: virtio_rpmsg_config is defined from remote view */
> > > > +        virtio_cread(vdev, struct virtio_rpmsg_config,
> > > > +                 txbuf_size, &vrp->rbuf_size);
> > > > +        virtio_cread(vdev, struct virtio_rpmsg_config,
> > > > +                 rxbuf_size, &vrp->sbuf_size);
> > > > +
> > > > +        /* The buffers must hold rpmsg header atleast */
> > > > +        if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
> > > > +            vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
> > > 
> > > 
> > > Hello Tanmay,
> > > 
> > > May I know if the omission of = here is to accommodate the ping/pong/ack
> > > scenarios? mtu will 0
> > > 
> > > 
> > 
> > Yes. At minimum RPMsg header is needed to ping the correct endpoint. We
> > don't need to have any payload attached to the packet. MTU will be
> > sizeof rpmsg_hdr I think.
> > 
> > > > +            dev_err(&vdev->dev,
> > > > +                "vdev config: rx buf sz = %d, tx buf sz = %d\n",
> > > > +                vrp->rbuf_size, vrp->sbuf_size);
> > > > +            err = -EINVAL;
> > > > +            goto vqs_del;
> > > > +        }
> > > > +
> > > > +        dev_dbg(&vdev->dev,
> > > > +            "vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
> > > > +            vrp->rbuf_size, vrp->sbuf_size);
> > > > +    } else {
> > > > +        vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> > > > +        vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
> > > > +    }
> > > > -    total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp-
> > > > >buf_size;
> > > > +    total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> > > > +              (vrp->num_sbufs * vrp->sbuf_size);
> > > > +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
> > > >       /* allocate coherent memory for the buffers */
> > > >       bufs_va = dma_alloc_coherent(vdev->dev.parent,
> > > > @@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > >       vrp->rbufs = bufs_va;
> > > >       /* and second part is dedicated for TX */
> > > > -    vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
> > > > +    vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
> > > >       /* set up the receive buffers */
> > > >       for (i = 0; i < vrp->num_rbufs; i++) {
> > > >           struct scatterlist sg;
> > > > -        void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> > > > +        void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
> > > > -        rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> > > > +        rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
> > > >           err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
> > > >                         GFP_KERNEL);
> > > > @@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct
> > > > device *dev, void *data)
> > > >   static void rpmsg_remove(struct virtio_device *vdev)
> > > >   {
> > > >       struct virtproc_info *vrp = vdev->priv;
> > > > -    unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> > > > -    size_t total_buf_space = num_bufs * vrp->buf_size;
> > > > +    size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
> > > > +                 (vrp->num_sbufs * vrp->sbuf_size);
> > > >       int ret;
> > > >       virtio_reset_device(vdev);
> > > > @@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct
> > > > virtio_device *vdev)
> > > >       vdev->config->del_vqs(vrp->vdev);
> > > > +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
> > > >       dma_free_coherent(vdev->dev.parent, total_buf_space,
> > > >                 vrp->rbufs, vrp->bufs_dma);
> > > > @@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
> > > >   static unsigned int features[] = {
> > > >       VIRTIO_RPMSG_F_NS,
> > > > +    VIRTIO_RPMSG_F_BUFSZ,
> > > >   };
> > > >   static struct virtio_driver virtio_ipc_driver = {
> > > > diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
> > > > new file mode 100644
> > > > index 000000000000..6406bc505383
> > > > --- /dev/null
> > > > +++ b/include/linux/virtio_rpmsg.h
> > > > @@ -0,0 +1,24 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > 
> > > 
> > > Echo Arnaud's comments. If it is intended for UAPI, please keep it in
> > > include/uapi/linux
> > > 
> > > 
> > 
> > It's not intended for UAPI. I need to fix the license. I will check
> > other virtio headers in the same directory and fix the license
> > accordingly.
> > 
> > > > +/*
> > > > + * Copyright (C) Pinecone Inc. 2019
> > > > + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> > > > + */
> > > > +
> > > > +#ifndef _LINUX_VIRTIO_RPMSG_H
> > > > +#define _LINUX_VIRTIO_RPMSG_H
> > > > +
> > > > +#include <linux/types.h>
> > > > +
> > > > +/* The feature bitmap for virtio rpmsg */
> > > > +#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service
> > > > notifications */
> > > > +#define VIRTIO_RPMSG_F_BUFSZ    2 /* RP get buffer size from
> > > > config space */
> > > 
> > > May I know why skip bit 1?
> > > 
> > > 
> > 
> > Thanks, that's a good question. I keept id 2 unmodified from the
> > original series. I don't know why ID 2 was chosen in the original
> > series. I will have to discuss this with the linux remoteproc/rpmsg
> > maintainers and choose the correct ID.
> > 
> > I don't see any problem choosing ID 1, but for some reason if ID 1 was
> > assigned and deprecated (I don't think that is the case) then only we
> > should use ID 2.
> 
> 
> The ID 1 was proposed in an openamp PR [1]. If we
> enter VIRTIO_RPMSG_F_BUFSZ first it makes sense to set its ID to 1.
>

I agree.
 
> [1]https://github.com/OpenAMP/open-amp/pull/160/commits/d4a13128f94e46180285c05a20da78fdca54f7d7
> 
> 
> Regards,
> Arnaud
> 
> > 
> > 
> > Arnaud, Mathieu, Bjorn any input here?
> > 
> > > > +
> > > > +struct virtio_rpmsg_config {
> > > > +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> > > > +    __u32 txbuf_size;
> > > > +    __u32 rxbuf_size;
> > > > +    __u32 reserved[14]; /* Reserve for the future use */
> > > 
> > > Should we use __virtio32 instead of __u32 to avoid endianness issues?
> > > 
> > > 
> > 
> > Sure, if that is the standard in other virtio headers I will modify it.
> > 
> > Thanks,
> > Tanmay
> > 
> > > > +    /* Put the customize config here */
> > > > +} __attribute__((packed));
> > > > +
> > > > +#endif /* _LINUX_VIRTIO_RPMSG_H */
> > > 
> > > 
> > 
> 
