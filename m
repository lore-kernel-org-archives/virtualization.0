Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B04C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:22:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A73613E3
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A73613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A89640540;
	Thu,  3 Jun 2021 15:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V2PIiqdHJv3E; Thu,  3 Jun 2021 15:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 852D0400FC;
	Thu,  3 Jun 2021 15:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64EE0C000E;
	Thu,  3 Jun 2021 15:22:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 997B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EAE9405C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Rd6kHZJviCp
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FD71405C2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622733730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tk288Zz+uIifCmQruWzx1HX+KXbfFOTwP0kxM+VMUEc=;
 b=U8LwQwctwhWDGUPTzbAdEPnOu+DroSh7QMht5ehK558ivZu1syxHd+HELRIWnTeV+atK2x
 2+8R8m9EIcaPLA5zHQ5CcxMvyjrUD759HOdDZRTTHW7cuS7obrO9B1UST53p/qzOYVaijv
 cWgsyfgi8Q/LNNiX+O/6xA7GwADSO+o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-0W81wZvnPruM8yLt4pYuhg-1; Thu, 03 Jun 2021 11:22:08 -0400
X-MC-Unique: 0W81wZvnPruM8yLt4pYuhg-1
Received: by mail-ed1-f69.google.com with SMTP id
 y7-20020aa7ce870000b029038fd7cdcf3bso3431533edv.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 08:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tk288Zz+uIifCmQruWzx1HX+KXbfFOTwP0kxM+VMUEc=;
 b=B92OfDO++Clv7WNJAbKGIDwwjVwEsEPfR1Gy1kCb2hKaVQP3UF3DOmmTeOqO1Oj+yD
 FcGEc/y2K5D1DGDxGafdk+RhD798l/MfWEobYGHTI4MWu9c6/DPQ5FWT0/Ta+szDpppQ
 47SQqUM3hFMhPUrapOuJNgw67rf7ujnijFEDELEb65+BHEAOa8KLY+QQCEzcXofTJCgi
 I0Nh7v/PqPsv36LlOx3bHrfJcdGl7Cv39+qHLEwrHh8jXWLtmOEoLy4wAQVlMcHhQCtg
 iwEwUttWKgFF8w1/OwjnC7bgnVB36uCNahw+p25xBKbm/2VSGNUGWOXb7utEWbgfVGUU
 1p3w==
X-Gm-Message-State: AOAM532LZWMKMpaG15SSgVZ2puMdAd27ifK0Xq5HgTXy+C2IesJ9HT9K
 fTpj1GRv4TPkU9ppBl8AhKMkWqcLmnDLqu9K+wdDIuurMvCEFD8p7ziFyl8BeXQNkCn7NsKNGvi
 wzDACxF8b4ydiPMTJluyShlGMMqA8DNvoXuax1ETafA==
X-Received: by 2002:a17:906:6c88:: with SMTP id
 s8mr125409ejr.129.1622733727730; 
 Thu, 03 Jun 2021 08:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoln++JLRLzRUvRIPFKCkhnzbJCumWsfqvvpdAzdKrFm/EKznU/MHMYhIJo8u5lC88unTUOw==
X-Received: by 2002:a17:906:6c88:: with SMTP id
 s8mr125391ejr.129.1622733727545; 
 Thu, 03 Jun 2021 08:22:07 -0700 (PDT)
Received: from steredhat ([5.170.129.82])
 by smtp.gmail.com with ESMTPSA id z22sm1197140ejm.71.2021.06.03.08.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 08:22:07 -0700 (PDT)
Date: Thu, 3 Jun 2021 17:22:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 14/18] virtio/vsock: enable SEQPACKET for transport
Message-ID: <20210603152203.gezrjp2xiv53eqpm@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191901.1272423-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191901.1272423-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Thu, May 20, 2021 at 10:18:57PM +0300, Arseny Krasnov wrote:
>To make transport work with SOCK_SEQPACKET two updates were
>added:

Present is better, and you can also mention that we enable it only if 
the feature is negotiated with the device.

>1) SOCK_SEQPACKET ops for virtio transport and 'seqpacket_allow()'
>   callback.
>2) Handling of SEQPACKET bit: guest tries to negotiate it with vhost.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Use 'virtio_has_feature()' to check feature bit.
> 2) Move assignment to 'seqpacket_allow' before 'rcu_assign_pointer()'.
>
> net/vmw_vsock/virtio_transport.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..bc5ee8df723a 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -62,6 +62,7 @@ struct virtio_vsock {
> 	struct virtio_vsock_event event_list[8];
>
> 	u32 guest_cid;
>+	bool seqpacket_allow;
> };
>
> static u32 virtio_transport_get_local_cid(void)
>@@ -443,6 +444,8 @@ static void virtio_vsock_rx_done(struct virtqueue 
>*vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -469,6 +472,10 @@ static struct virtio_transport virtio_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = 
>virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = virtio_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -485,6 +492,19 @@ static struct virtio_transport virtio_transport = {
> 	.send_pkt = virtio_transport_send_pkt,
> };
>
>+static bool virtio_transport_seqpacket_allow(u32 remote_cid)
>+{
>+	struct virtio_vsock *vsock;
>+	bool seqpacket_allow;
>+
>+	rcu_read_lock();
>+	vsock = rcu_dereference(the_virtio_vsock);
>+	seqpacket_allow = vsock->seqpacket_allow;
>+	rcu_read_unlock();
>+
>+	return seqpacket_allow;
>+}
>+
> static void virtio_transport_rx_work(struct work_struct *work)
> {
> 	struct virtio_vsock *vsock =
>@@ -608,6 +628,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>
>+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
>+		vsock->seqpacket_allow = true;
>+
> 	vdev->priv = vsock;
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>
>@@ -695,6 +718,7 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>+	VIRTIO_VSOCK_F_SEQPACKET
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
