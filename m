Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D097DC04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 12:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62BA660BD6;
	Wed, 27 Jul 2022 12:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62BA660BD6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/aiE6p+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQJ3XEt2YIJ3; Wed, 27 Jul 2022 12:17:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E3FC560BE5;
	Wed, 27 Jul 2022 12:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3FC560BE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B378CC0033;
	Wed, 27 Jul 2022 12:17:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F29D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3DE34051B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3DE34051B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/aiE6p+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cCz82KMH2ItO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:17:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 847E840424
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 847E840424
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658924238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rTHmFps6imtrmSGc8bdiFcqdRJQxILQMWRRFRNlZ68=;
 b=f/aiE6p+tQQQQ1oYNcVljOQ06SVVis8yBlakKbSS295K6M37ZjDTjoNeua2YOmIpPOV2r9
 zmpdju2+HWTfsDv8+AeRMpuczujsbGlLec03HQsT6xIG97okFqDMH4AbMQrBJo0O3UNK8N
 S3ZoHnRfWtZALENE/WzLp9WyMDswgWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-8brwAHoaN1ynPcoEF0jKfg-1; Wed, 27 Jul 2022 08:17:16 -0400
X-MC-Unique: 8brwAHoaN1ynPcoEF0jKfg-1
Received: by mail-wm1-f69.google.com with SMTP id
 v132-20020a1cac8a000000b003a34081050bso1088815wme.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 05:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4rTHmFps6imtrmSGc8bdiFcqdRJQxILQMWRRFRNlZ68=;
 b=cyBDPriqQbL+sZhi/qQhGnOMMogIqdta7Q7A0os2YVZCZGRFpLEhvxUa4HjayTH9rf
 9IjfpjOTOzep1HulEGk5njxmYO2PTGe0/SuWBrL7SURmbGZw09PFwB3SJgl0TJSR98YR
 SvkNbdfABtzZhSJgAfj821NWerhSyy7zobV+jM1X7ohLC9ICJSUi1dNuWqey6fWsvOT+
 gaaZJP0mTmorGzJXKpOnxntCa5Ob5wAPDmo2uVsfT2Zx5QF9QI704pfNNWPdPlyZw3vb
 xpQlnXB0Z8QIJdwj0i23CMJfwhgCRriBHoVYI5qK+s0ttLberJgb56XAqoiTribTEM5b
 Yl4g==
X-Gm-Message-State: AJIora9z0E4b8x2b+iC4LLD+UiUOf+zOcNsCGDcChXmhftQxjVzJGMMW
 q+cjy8+OO17NL1kDubPQX2sWmFuVDhxAdj8cbXCdZUPQD+J1sI/fkiK6fvoZyatKDJFeskFpOF2
 gg2edpYDtNiS7HFCezs3BEhHZTfGIpPNkr07EekB/DQ==
X-Received: by 2002:a5d:5252:0:b0:21e:6e28:a6da with SMTP id
 k18-20020a5d5252000000b0021e6e28a6damr12304188wrc.100.1658924235599; 
 Wed, 27 Jul 2022 05:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tD1wktJsEPz3BQ+vGkdusMkfMqeHo1K0hAUvaOWDoC8PIzZXcZgm9U3hnUKpQkGShIiKos+Q==
X-Received: by 2002:a5d:5252:0:b0:21e:6e28:a6da with SMTP id
 k18-20020a5d5252000000b0021e6e28a6damr12304167wrc.100.1658924235252; 
 Wed, 27 Jul 2022 05:17:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u9-20020adff889000000b0020fcaba73bcsm16713440wrp.104.2022.07.27.05.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 05:17:14 -0700 (PDT)
Date: Wed, 27 Jul 2022 14:17:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/9] vsock: use sk_rcvlowat to set POLLIN/POLLRDNORM
Message-ID: <20220727121709.z26dspwegqeiv55x@sgarzare-redhat>
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <aafc654d-5b42-aa18-bf74-f5277d549f73@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <aafc654d-5b42-aa18-bf74-f5277d549f73@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Jul 25, 2022 at 07:56:59AM +0000, Arseniy Krasnov wrote:
>Both bits indicate, that next data read call won't be blocked, but when
>sk_rcvlowat is not 1, these bits will be set by poll anyway, thus when
>user tries to dequeue data,it will wait until sk_rcvlowat bytes of data
>will be available.
>

The patch LGTM, but I suggest you to rewrite the title and commit of the 
message to better explain what this patch does (pass sock_rcvlowat to 
notify_poll_in as target) and then explain why as you already did (to 
set POLLIN/POLLRDNORM only when target is reached).

Thanks,
Stefano

>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..63a13fa2686a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1066,8 +1066,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		if (transport && transport->stream_is_active(vsk) &&
> 		    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
> 			bool data_ready_now = false;
>+			int target = sock_rcvlowat(sk, 0, INT_MAX);
> 			int ret = transport->notify_poll_in(
>-					vsk, 1, &data_ready_now);
>+					vsk, target, &data_ready_now);
> 			if (ret < 0) {
> 				mask |= EPOLLERR;
> 			} else {
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
