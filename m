Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10925C433FE
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 13:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95B1F60F5E;
	Wed, 27 Apr 2022 13:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XkqjAhc4G8CK; Wed, 27 Apr 2022 13:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1DF6660EE7;
	Wed, 27 Apr 2022 13:38:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F316DC0032;
	Wed, 27 Apr 2022 13:38:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 682C1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 404814097E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PVU-tWKNvyt0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C7374071E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651066696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PSHs414nLmIXHY0MNvy/DxlhGuFhzSSXxRrlOw3+ock=;
 b=FqkyDlh8W61TWFUsn375FwGhxt/JEJjo/sW5x32YcAJYcwiHaYXgGN0Y/IeZ8P1EoGY9op
 3JEdpzX/cvS9a+dBMVRL0GkBibUU3QYkvq0zknWZNpKLakWQlFfj7JDCUR/fmI4MmEAtM5
 5+kT+ymKidQA5sXvGtm2azz4Hzs1wg8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-Vni7PWQMNb-LYyjCBzJ_-w-1; Wed, 27 Apr 2022 09:38:13 -0400
X-MC-Unique: Vni7PWQMNb-LYyjCBzJ_-w-1
Received: by mail-wr1-f71.google.com with SMTP id
 s14-20020adfa28e000000b0020ac7532f08so759946wra.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PSHs414nLmIXHY0MNvy/DxlhGuFhzSSXxRrlOw3+ock=;
 b=DrtLh53D/Mq9OWl4vRUhLA3hWVw/iW5ixog1kPM7zHQu/gLCYdXG1W50O4uRSCzNpa
 v/5XDziApmoMllr0UA7SZnD4sfZ3gL9LeDWLf5ws6ICSkO6xvC7WDlGBTjBLXhuTPKG4
 XxQmxI0Ec7fz++GksWMd6xPq4uy8yrqPjiNIW7DOBj25yVquXrBiX9M++ys17JRQJIeW
 xBYoLbQEdjQEowGtpmDGNcW9BOhoM2TRcbB0LulfgUrd/TPD+zZibYwUoZgyis9FFD+X
 XUNd2XADMVjcFqWhuwphX8vBp7xejjCc1Oi2J5iBgRFiuEKNr/nlve9h6iyMBLWAdDlj
 RNdg==
X-Gm-Message-State: AOAM531Cg/bjDMMtG+jaQ9XgoooYY00Mhz+kapZzbaVfNIkueMxuRykn
 eJ3jtXY7YoHHkQXU9/OCJWQSbeuvtcad8BQpQmC3WO9TDzEiu4sgY4I5IHOIHkSuBWGJfYAvslF
 ANbBhQbxq6hVTVqbhp8ddqqlQEaTZA0Tw1EFbRl5nOw==
X-Received: by 2002:a5d:40ca:0:b0:20a:cf97:f1b4 with SMTP id
 b10-20020a5d40ca000000b0020acf97f1b4mr18244195wrq.121.1651066692512; 
 Wed, 27 Apr 2022 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzosLJXqvRwF4U/eGOveNg83nSH/OQqj2msqvMJzBqQTXR97GmklzXkcLwfNLij7D2eSiit9g==
X-Received: by 2002:a5d:40ca:0:b0:20a:cf97:f1b4 with SMTP id
 b10-20020a5d40ca000000b0020acf97f1b4mr18244166wrq.121.1651066692307; 
 Wed, 27 Apr 2022 06:38:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c2c4700b0038eb7d8df69sm1565757wmg.11.2022.04.27.06.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 06:38:11 -0700 (PDT)
Date: Wed, 27 Apr 2022 15:38:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: Re: [PATCH v2 2/5] hv_sock: Copy packets sent by Hyper-V out of the
 ring buffer
Message-ID: <20220427133808.elbrvtvl6xplx62n@sgarzare-redhat>
References: <20220427131225.3785-1-parri.andrea@gmail.com>
 <20220427131225.3785-3-parri.andrea@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220427131225.3785-3-parri.andrea@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
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

On Wed, Apr 27, 2022 at 03:12:22PM +0200, Andrea Parri (Microsoft) wrote:
>Pointers to VMbus packets sent by Hyper-V are used by the hv_sock driver
>within the guest VM.  Hyper-V can send packets with erroneous values or
>modify packet fields after they are processed by the guest.  To defend
>against these scenarios, copy the incoming packet after validating its
>length and offset fields using hv_pkt_iter_{first,next}().  Use
>HVS_PKT_LEN(HVS_MTU_SIZE) to initialize the buffer which holds the
>copies of the incoming packets.  In this way, the packet can no longer
>be modified by the host.
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 943352530936e..8c37d07017fc4 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -78,6 +78,9 @@ struct hvs_send_buf {
> 					 ALIGN((payload_len), 8) + \
> 					 VMBUS_PKT_TRAILER_SIZE)
>
>+/* Upper bound on the size of a VMbus packet for hv_sock */
>+#define HVS_MAX_PKT_SIZE	HVS_PKT_LEN(HVS_MTU_SIZE)
>+
> union hvs_service_id {
> 	guid_t	srv_id;
>
>@@ -378,6 +381,8 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
> 	}
>
>+	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>+
> 	ret = vmbus_open(chan, sndbuf, rcvbuf, NULL, 0, hvs_channel_cb,
> 			 conn_from_host ? new : sk);
> 	if (ret != 0) {
>@@ -602,7 +607,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
> 		return -EOPNOTSUPP;
>
> 	if (need_refill) {
>-		hvs->recv_desc = hv_pkt_iter_first_raw(hvs->chan);
>+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
> 		if (!hvs->recv_desc)
> 			return -ENOBUFS;
> 		ret = hvs_update_recv_data(hvs);
>@@ -618,7 +623,7 @@ static ssize_t hvs_stream_dequeue(struct vsock_sock *vsk, struct msghdr *msg,
>
> 	hvs->recv_data_len -= to_read;
> 	if (hvs->recv_data_len == 0) {
>-		hvs->recv_desc = hv_pkt_iter_next_raw(hvs->chan, hvs->recv_desc);
>+		hvs->recv_desc = hv_pkt_iter_next(hvs->chan, hvs->recv_desc);
> 		if (hvs->recv_desc) {
> 			ret = hvs_update_recv_data(hvs);
> 			if (ret)
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
