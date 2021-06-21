Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E7CC4743C
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:24:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32534610A3
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32534610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E30CF4036C;
	Mon, 21 Jun 2021 17:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cVCY7V5J9oiv; Mon, 21 Jun 2021 17:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 142E84034C;
	Mon, 21 Jun 2021 17:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C18CCC0010;
	Mon, 21 Jun 2021 17:24:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90034C000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71D2483A4C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SIEYrOgDIwML
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:24:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4249683A46
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:24:31 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id h9so8191952oih.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xKmGjgLsgWsFBaBePs7cjUDuoclC/CKZFAJTnQ9AJMs=;
 b=JlwDd3p+9HGTZoM82mSEcGnLlu8sxR3GFo+ou3kNhT/FgSBJWjVVZksAYHD9snLqOW
 t4C02M5/JrwhTMk0Ev8rvYIabC2Kk6bjAVy059EXiCL2dezvvxDtrmkWTkGi4vCDbWf9
 10M+9Rvbtotts+rFzzKWY3IdBrJcr3HgL6eIb2GLAnjpqwz7X6bKHUWsDLSykTY/APoy
 GOJfjWZqf5htG0uaZNLWmE56Sbo4iGBftsw6p6kURUVn2AaOcKkjBpADwWPqaN1VoU1l
 d6j9JDM00UGUKbyIhm34TdmSz7EmZ733coZcUYgYB3DhkA2ErfjYDiAm4Ta/fblght9t
 cE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xKmGjgLsgWsFBaBePs7cjUDuoclC/CKZFAJTnQ9AJMs=;
 b=gTVXko5XChC8hhSskqHURNhPp4iyxiONr/uvCiKKrCsG2g6iLlM7Y5tjjOQeJHhSEL
 fVOKrmJKMwLqa0UzVZwseFfwH0PBlkWFlkQVGiAMkvRWll+mlQeBoYcK1mEzi85ifPo5
 ZP57NTRjA66Tk1qVJn9YdN4WapSWmyZcfGNUKWrmlGovbrfxBec8/OmTcBXMvPNlinA8
 hpY3gJPmeTczWDtGQuFEQVs+Atvu1V1WNulZBza3hr8FxY1jsGcfnG7/zHQwH6LJr8ug
 B+AbArun5vrybLPsdNf++ih84hasYwP6F5kpzkXqDuPjyTJExUlsrTvTPbL+KjRoSFsZ
 xyuw==
X-Gm-Message-State: AOAM531F5D4RHbxm5f1+xkHLtQu21V/xpufGx+QkaAubF7p6MQ1RusHi
 I8WlNx2mgLwUmX6xfTYCKqGX9nJYrVlCoWWpRBxsyg==
X-Google-Smtp-Source: ABdhPJwwgSJtHVHbFJBIgtqJtkqt3r/pism6TPjHvnMbCkspkHQPBTtNGkFsBzAo/tU1Xi57+G30U2wnqoV1LIX+Saw=
X-Received: by 2002:aca:e0d6:: with SMTP id
 x205mr17923656oig.109.1624296271029; 
 Mon, 21 Jun 2021 10:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210609232501.171257-2-jiang.wang@bytedance.com>
 <20210618093951.g32htj3rsu2koqi5@steredhat.lan>
In-Reply-To: <20210618093951.g32htj3rsu2koqi5@steredhat.lan>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 21 Jun 2021 10:24:20 -0700
Message-ID: <CAP_N_Z-vom-8=Otjtt9wndP8KLDvy7KxQg20g4=65Y4d8N7CmA@mail.gmail.com>
Subject: Re: [External] Re: [RFC v1 1/6] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM
 feature bit
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Networking <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org,
 Yongji Xie <xieyongji@bytedance.com>,
 =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Ingo Molnar <mingo@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Popov <alex.popov@linux.com>
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

On Fri, Jun 18, 2021 at 2:40 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Jun 09, 2021 at 11:24:53PM +0000, Jiang Wang wrote:
> >When this feature is enabled, allocate 5 queues,
> >otherwise, allocate 3 queues to be compatible with
> >old QEMU versions.
> >
> >Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> >---
> > drivers/vhost/vsock.c             |  3 +-
> > include/linux/virtio_vsock.h      |  9 +++++
> > include/uapi/linux/virtio_vsock.h |  3 ++
> > net/vmw_vsock/virtio_transport.c  | 73 +++++++++++++++++++++++++++++++++++----
> > 4 files changed, 80 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 5e78fb719602..81d064601093 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -31,7 +31,8 @@
> >
> > enum {
> >       VHOST_VSOCK_FEATURES = VHOST_FEATURES |
> >-                             (1ULL << VIRTIO_F_ACCESS_PLATFORM)
> >+                             (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >+                             (1ULL << VIRTIO_VSOCK_F_DGRAM)
> > };
> >
> > enum {
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index dc636b727179..ba3189ed9345 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -18,6 +18,15 @@ enum {
> >       VSOCK_VQ_MAX    = 3,
> > };
> >
> >+enum {
> >+      VSOCK_VQ_STREAM_RX     = 0, /* for host to guest data */
> >+      VSOCK_VQ_STREAM_TX     = 1, /* for guest to host data */
> >+      VSOCK_VQ_DGRAM_RX       = 2,
> >+      VSOCK_VQ_DGRAM_TX       = 3,
> >+      VSOCK_VQ_EX_EVENT       = 4,
> >+      VSOCK_VQ_EX_MAX         = 5,
> >+};
> >+
> > /* Per-socket state (accessed via vsk->trans) */
> > struct virtio_vsock_sock {
> >       struct vsock_sock *vsk;
> >diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> >index 1d57ed3d84d2..b56614dff1c9 100644
> >--- a/include/uapi/linux/virtio_vsock.h
> >+++ b/include/uapi/linux/virtio_vsock.h
> >@@ -38,6 +38,9 @@
> > #include <linux/virtio_ids.h>
> > #include <linux/virtio_config.h>
> >
> >+/* The feature bitmap for virtio net */
> >+#define VIRTIO_VSOCK_F_DGRAM  0       /* Host support dgram vsock */
> >+
> > struct virtio_vsock_config {
> >       __le64 guest_cid;
> > } __attribute__((packed));
> >diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >index 2700a63ab095..7dcb8db23305 100644
> >--- a/net/vmw_vsock/virtio_transport.c
> >+++ b/net/vmw_vsock/virtio_transport.c
> >@@ -27,7 +27,8 @@ static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
> >
> > struct virtio_vsock {
> >       struct virtio_device *vdev;
> >-      struct virtqueue *vqs[VSOCK_VQ_MAX];
> >+      struct virtqueue **vqs;
> >+      bool has_dgram;
> >
> >       /* Virtqueue processing is deferred to a workqueue */
> >       struct work_struct tx_work;
> >@@ -333,7 +334,10 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
> >       struct scatterlist sg;
> >       struct virtqueue *vq;
> >
> >-      vq = vsock->vqs[VSOCK_VQ_EVENT];
> >+      if (vsock->has_dgram)
> >+              vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
> >+      else
> >+              vq = vsock->vqs[VSOCK_VQ_EVENT];
> >
> >       sg_init_one(&sg, event, sizeof(*event));
> >
> >@@ -351,7 +355,10 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
> >               virtio_vsock_event_fill_one(vsock, event);
> >       }
> >
> >-      virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
> >+      if (vsock->has_dgram)
> >+              virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
> >+      else
> >+              virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
> > }
> >
> > static void virtio_vsock_reset_sock(struct sock *sk)
> >@@ -391,7 +398,10 @@ static void virtio_transport_event_work(struct work_struct *work)
> >               container_of(work, struct virtio_vsock, event_work);
> >       struct virtqueue *vq;
> >
> >-      vq = vsock->vqs[VSOCK_VQ_EVENT];
> >+      if (vsock->has_dgram)
> >+              vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
> >+      else
> >+              vq = vsock->vqs[VSOCK_VQ_EVENT];
> >
> >       mutex_lock(&vsock->event_lock);
> >
> >@@ -411,7 +421,10 @@ static void virtio_transport_event_work(struct work_struct *work)
> >               }
> >       } while (!virtqueue_enable_cb(vq));
> >
> >-      virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
> >+      if (vsock->has_dgram)
> >+              virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
> >+      else
> >+              virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
> > out:
> >       mutex_unlock(&vsock->event_lock);
> > }
> >@@ -434,6 +447,10 @@ static void virtio_vsock_tx_done(struct virtqueue *vq)
> >       queue_work(virtio_vsock_workqueue, &vsock->tx_work);
> > }
> >
> >+static void virtio_vsock_dgram_tx_done(struct virtqueue *vq)
> >+{
> >+}
> >+
> > static void virtio_vsock_rx_done(struct virtqueue *vq)
> > {
> >       struct virtio_vsock *vsock = vq->vdev->priv;
> >@@ -443,6 +460,10 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> >       queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> > }
> >
> >+static void virtio_vsock_dgram_rx_done(struct virtqueue *vq)
> >+{
> >+}
> >+
> > static struct virtio_transport virtio_transport = {
> >       .transport = {
> >               .module                   = THIS_MODULE,
> >@@ -545,13 +566,29 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> >               virtio_vsock_tx_done,
> >               virtio_vsock_event_done,
> >       };
> >+      vq_callback_t *ex_callbacks[] = {
>
> 'ex' is not clear, maybe better 'dgram'?
>
sure.

> What happen if F_DGRAM is negotiated, but not F_STREAM?
>
Hmm. In my mind, F_STREAM is always negotiated. Do we want to add
support when F_STREAM is not negotiated?

> >+              virtio_vsock_rx_done,
> >+              virtio_vsock_tx_done,
> >+              virtio_vsock_dgram_rx_done,
> >+              virtio_vsock_dgram_tx_done,
> >+              virtio_vsock_event_done,
> >+      };
> >+
> >       static const char * const names[] = {
> >               "rx",
> >               "tx",
> >               "event",
> >       };
> >+      static const char * const ex_names[] = {
> >+              "rx",
> >+              "tx",
> >+              "dgram_rx",
> >+              "dgram_tx",
> >+              "event",
> >+      };
> >+
> >       struct virtio_vsock *vsock = NULL;
> >-      int ret;
> >+      int ret, max_vq;
> >
> >       ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
> >       if (ret)
> >@@ -572,9 +609,30 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> >
> >       vsock->vdev = vdev;
> >
> >-      ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
> >+      if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
> >+              vsock->has_dgram = true;
> >+
> >+      if (vsock->has_dgram)
> >+              max_vq = VSOCK_VQ_EX_MAX;
> >+      else
> >+              max_vq = VSOCK_VQ_MAX;
> >+
> >+      vsock->vqs = kmalloc_array(max_vq, sizeof(struct virtqueue *), GFP_KERNEL);
> >+      if (!vsock->vqs) {
> >+              ret = -ENOMEM;
> >+              goto out;
> >+      }
> >+
> >+      if (vsock->has_dgram) {
> >+              ret = virtio_find_vqs(vsock->vdev, max_vq,
> >+                            vsock->vqs, ex_callbacks, ex_names,
> >+                            NULL);
> >+      } else {
> >+              ret = virtio_find_vqs(vsock->vdev, max_vq,
> >                             vsock->vqs, callbacks, names,
> >                             NULL);
> >+      }
> >+
> >       if (ret < 0)
> >               goto out;
> >
> >@@ -695,6 +753,7 @@ static struct virtio_device_id id_table[] = {
> > };
> >
> > static unsigned int features[] = {
> >+      VIRTIO_VSOCK_F_DGRAM,
> > };
> >
> > static struct virtio_driver virtio_vsock_driver = {
> >--
> >2.11.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
