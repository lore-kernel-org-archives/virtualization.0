Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF30FC6FD18
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 09:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37C4A41F46;
	Wed, 19 Apr 2023 09:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37C4A41F46
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCihjCCx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P48dBRtpSwG8; Wed, 19 Apr 2023 09:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3412041F3A;
	Wed, 19 Apr 2023 09:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3412041F3A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18008C0037;
	Wed, 19 Apr 2023 09:30:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87949C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 09:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62BEE83F12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 09:30:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62BEE83F12
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCihjCCx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BxKBpzUNjKiw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 09:30:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96FF783F0C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96FF783F0C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681896630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=To/Z2aKUn05uCqDmpdizDe13Xy/Ne8IR1ELES9feEn8=;
 b=UCihjCCxjzl0G1LpgEkFU8VhDHQ0sfVv6Kb2lDeVRzubZ4REDN8IOIo+y1m2QjDKLMtd89
 H+CHJSnve/zmi5840aX4qhXfews7lhJq1D7dxPdHGyIQQSvtyBiGldce2v6LSKAl9QqQfG
 xNSXEV105Yz25OJaPkVeKiSMw8LAKgc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-6A8pjNcpMESPpHHjKvBHHQ-1; Wed, 19 Apr 2023 05:30:28 -0400
X-MC-Unique: 6A8pjNcpMESPpHHjKvBHHQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d22-20020a05622a101600b003ef3a12c431so3271970qte.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 02:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681896628; x=1684488628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=To/Z2aKUn05uCqDmpdizDe13Xy/Ne8IR1ELES9feEn8=;
 b=aYUqW8UkfonOStKJVKg/mYI9tQmrd2lyJ/uRxTttHX/pm/iOorAnIMvgLQGu6L1H9F
 wmQm7A8M5tANqSgj+wPKQMVb/nFF9jF8i6RFpaQHFgCrjaruwLJH0At5O/ITvHJlRmHe
 BEmcFCTziKbwsp8GoMvHXWH7UV830ovnUiTmf0gcCUDjezkEBCv9xM8RQE2gB85OdXEb
 cJ7MZNKBQUappTklDLtCgNvN2A2Ic36EXJCGGko/ZApL9L8/j7gxFmWT2r3Fn7b7YY8e
 o+vnp4qWWua0QTN1G7CCqdghtAxbHjnHLb5dnXu2m4Aze2dm5lv/kDcGkkQJXraoI+RY
 ETVw==
X-Gm-Message-State: AAQBX9chmCA5Vf0cERqnuuILG6RA0BMlMtKcsRxgW3Gp+ftbBKwILclN
 Wf3Ilxqy+APQtmqd1ge8s7z1phtX7oAMoItPDYA4xct1BizETiwLtCCBUCVawFy39GFVMdq/78K
 Ewq2ckKH5hiCVmTf8kFaZOuwZRGo9+ouwV/JjkPIKeQ==
X-Received: by 2002:ac8:5856:0:b0:3e3:8ebe:ce2d with SMTP id
 h22-20020ac85856000000b003e38ebece2dmr4663805qth.68.1681896628017; 
 Wed, 19 Apr 2023 02:30:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350arWkVKYAcdMdvj77voljoNXo58Xfzci6Fuv0r9IbfMnWkq1bBapWpJIOmEljT7ApJVePXaIw==
X-Received: by 2002:ac8:5856:0:b0:3e3:8ebe:ce2d with SMTP id
 h22-20020ac85856000000b003e38ebece2dmr4663749qth.68.1681896627694; 
 Wed, 19 Apr 2023 02:30:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 z17-20020ac87cb1000000b003e64ea3faf7sm2631599qtv.59.2023.04.19.02.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Apr 2023 02:30:27 -0700 (PDT)
Date: Wed, 19 Apr 2023 11:30:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 2/4] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <nbuuohh72i4n27rzlg7sj7bwsrsrnnxxcxj6w5yotw5bhpcznt@ormwl5d6jiuw>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <20230413-b4-vsock-dgram-v2-2-079cc7cee62e@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v2-2-079cc7cee62e@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, Wei Liu <wei.liu@kernel.org>,
 Jiang Wang <jiang.wang@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
 linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Apr 14, 2023 at 12:25:58AM +0000, Bobby Eshleman wrote:
>This commit adds a feature bit for virtio vsock to support datagrams.
>This commit should not be applied without first applying the commit
>that implements datagrams for virtio.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> drivers/vhost/vsock.c             | 3 ++-
> include/uapi/linux/virtio_vsock.h | 1 +
> net/vmw_vsock/virtio_transport.c  | 8 ++++++--
> 3 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index dff6ee1c479b..028cf079225e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -32,7 +32,8 @@
> enum {
> 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
> 			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
>+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
>+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
> };
>
> enum {
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 331be28b1d30..0975b9c88292 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		2	/* Host support dgram vsock */
>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 582c6c0f788f..bb43eea9a6f9 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -29,6 +29,7 @@ static struct virtio_transport virtio_transport; /* forward declaration */
> struct virtio_vsock {
> 	struct virtio_device *vdev;
> 	struct virtqueue *vqs[VSOCK_VQ_MAX];
>+	bool has_dgram;
>
> 	/* Virtqueue processing is deferred to a workqueue */
> 	struct work_struct tx_work;
>@@ -640,7 +641,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	}
>
> 	vsock->vdev = vdev;
>-
> 	vsock->rx_buf_nr = 0;
> 	vsock->rx_buf_max_nr = 0;
> 	atomic_set(&vsock->queued_replies, 0);
>@@ -657,6 +657,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
> 		vsock->seqpacket_allow = true;
>
>+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
>+		vsock->has_dgram = true;

This is unused for now, but I think the idea is to use in
virtio_transport_dgram_allow(), right?

I would follow `seqpacket_allow` in this case.

Thanks,
Stefano

>+
> 	vdev->priv = vsock;
>
> 	ret = virtio_vsock_vqs_init(vsock);
>@@ -749,7 +752,8 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>-	VIRTIO_VSOCK_F_SEQPACKET
>+	VIRTIO_VSOCK_F_SEQPACKET,
>+	VIRTIO_VSOCK_F_DGRAM
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>
>-- 
>2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
