Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A63BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 13:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A8F7409D6;
	Thu, 21 Apr 2022 13:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NMV5r5jMB7qX; Thu, 21 Apr 2022 13:58:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A632E40BB5;
	Thu, 21 Apr 2022 13:58:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7590FC0033;
	Thu, 21 Apr 2022 13:58:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F032C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BDB5409D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4s1lYId1nLQp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:58:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C5BF405DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650549529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCDdTtfh+cTEbBhGHl6TDA/w0vVS1GSM5e8sY5ZehTw=;
 b=NFxtqG+ent5tyig8uUSSYtm2Yw+WwGApBjD7cjJzdT827tVMrRK8AxhiX9wk7An5SkSk4p
 5eBePbASd5aDooNfV/ZpyHFAsqD8bdpTqu/224aiob5lRN7KZuDE0W/O1qfnjkY8pNyIQI
 YVvEjJygnazrcbQOCyohM1Qa0yKM6aw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-S4ecl56XP96Kw_UT8zMB9A-1; Thu, 21 Apr 2022 09:58:46 -0400
X-MC-Unique: S4ecl56XP96Kw_UT8zMB9A-1
Received: by mail-ej1-f70.google.com with SMTP id
 hq19-20020a1709073f1300b006f02c6bdf4aso64526ejc.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 06:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FCDdTtfh+cTEbBhGHl6TDA/w0vVS1GSM5e8sY5ZehTw=;
 b=DsTQ7mtLHlNpgNiRpAm2IaHCcXCAMUsacaCXEKFYZeR3behuWq6BtamIAb+/MD4G6c
 OEmyD14An/WDj+9Ktf8mYtqe6exoH6sfaY0PC8gzUcQSqY7NqK4A8ppy2NBYQBY7BWG5
 U7dOCTtzmvA1e1BPIeTvvr4PyW8PtE1zYHsVXiZSjt4MjShQhlMkWrxP9GYoNWfFrwgm
 ysP7cQ6dz4EeF6fny3dX81NBoq36TterrrPsmyPND6YnJKsAV5wBP05ZXJsoeWtoJQqS
 ewNI2ipAh9BjlvDZt+V5L+T+45P9TTLgYc25LGKJx7GqVj87ZSvyIzFyxs6A4gJMcQ+T
 9DyA==
X-Gm-Message-State: AOAM530ZXlu2mm6iflQ3TwNaf2LyJ3UV5ty2S+uxcUcW7aJqiwByM3Zp
 Wf84NiPDuIX9q4qGwBktw0f+QZT4B26ZggnapoZu7ySkmWvgT6QTzLHKDeh/fsKnZx3tCcJ4swC
 1Qxk9kxtEuFUny+8KouvhFJBu9Wfg/3PbNbmWw/DfZw==
X-Received: by 2002:a05:6402:50d1:b0:423:f4a2:95c7 with SMTP id
 h17-20020a05640250d100b00423f4a295c7mr18677807edb.91.1650549525248; 
 Thu, 21 Apr 2022 06:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4JGn8p7OAUTHSbJC7sBsOiSljB3wcQ48NL5S76jPutkqPECOtv4rN6ZvZhqHRw9AZzzPQ5Q==
X-Received: by 2002:a05:6402:50d1:b0:423:f4a2:95c7 with SMTP id
 h17-20020a05640250d100b00423f4a295c7mr18677794edb.91.1650549525081; 
 Thu, 21 Apr 2022 06:58:45 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.75.76])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a056402036100b004240a3fc6b4sm3043298edw.82.2022.04.21.06.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 06:58:44 -0700 (PDT)
Date: Thu, 21 Apr 2022 15:58:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: Re: [PATCH 2/5] hv_sock: Copy packets sent by Hyper-V out of the
 ring buffer
Message-ID: <20220421135839.2fj6fk6bvlrau73o@sgarzare-redhat>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-3-parri.andrea@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220420200720.434717-3-parri.andrea@gmail.com>
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

On Wed, Apr 20, 2022 at 10:07:17PM +0200, Andrea Parri (Microsoft) wrote:
>Pointers to VMbus packets sent by Hyper-V are used by the hv_sock driver
>within the guest VM.  Hyper-V can send packets with erroneous values or
>modify packet fields after they are processed by the guest.  To defend
>against these scenarios, copy the incoming packet after validating its
>length and offset fields using hv_pkt_iter_{first,next}().  In this way,
>the packet can no longer be modified by the host.
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
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

premise, I don't know HyperV channels :-(

Is this change necessary to use hv_pkt_iter_first() instead of 
hv_pkt_iter_first_raw()?

If yes, then please mention that you set this value in the commit 
message, otherwise maybe better to have a separate patch.

Thanks,
Stefano

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
