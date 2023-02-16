Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50780C636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 14:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C14CA82049;
	Thu, 16 Feb 2023 14:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C14CA82049
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QgE9uvE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCS4DtLKodB9; Thu, 16 Feb 2023 14:02:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1C85811F9;
	Thu, 16 Feb 2023 14:02:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1C85811F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A24C0033;
	Thu, 16 Feb 2023 14:02:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42930C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D10C81212
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:02:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D10C81212
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROe20WXP6pZG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:02:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F049811F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F049811F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676556161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jLAlHrmg/N94k15P0ZdSVRRZ/25ME84tuyTznfQGswY=;
 b=QgE9uvE2+h8NtZVgX8s1ivA2TWl8RHM5rrafb4z9W4Y8yJ+wBzDuEDHoWO5Ho8uqgH6rgV
 D/2Pp6zCjtlmDTRYsbtuwBKOnZQOXYtF4i/FTzx0F6NRvRwZuuV1yXDVcS66J4TmkxvX8W
 xQd+L5g99/IcfzHI5i9T+di0nVV5c20=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-1crgs1zPNIO1CzePLEN-TA-1; Thu, 16 Feb 2023 09:02:40 -0500
X-MC-Unique: 1crgs1zPNIO1CzePLEN-TA-1
Received: by mail-qk1-f197.google.com with SMTP id
 ou17-20020a05620a621100b0073b2dc0e161so1217416qkn.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 06:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLAlHrmg/N94k15P0ZdSVRRZ/25ME84tuyTznfQGswY=;
 b=5wGIG5qHGlOsVl2TMTwEUob4C1CdlpPOZpL5kaJPaT0jZ28TJmI1JoSE3FOrPpENpL
 EEhrXmCH5/bGbYqz9IGm0SHeDm+i97pDYX5lpmCXjn10Pf8UmuItE6OkzisTZPl3zckk
 W/KnbdtHYxZs2QUMHrY3+7f7VdmTFt52OmnQIOy+CtOY26RG+vT8SedqlJB3CQ7FS8lU
 zotRfigcddqE1vaq8f4foSOirWsFtVn6Kpr9Kw9vRjq3e8klRdQpMiI04NVroAsxgR5B
 +wmQv3CEngsS3VxpjZ3nBlQdD5ax+M2PBmBRsNjloiYOFpe3ALSI2LfJn4Efs/qakWaJ
 6ykw==
X-Gm-Message-State: AO0yUKXU7v3ZCLbkJIu1D+OZV8d3v5rPUvMm93yrefLUw8PnecsEbD2a
 naIy52oZPkPel/UKoApTPhiR6unLyxOEEpLW7bNYfcjCHvd97mPINxYDEiEo2zRdEMyID8R6Tbi
 EkCVDKc+imic0EgJNVvovPleknaNdTzKhj8JdcYkAAQ==
X-Received: by 2002:ad4:5cad:0:b0:56e:af4a:11f8 with SMTP id
 q13-20020ad45cad000000b0056eaf4a11f8mr11940059qvh.4.1676556157887; 
 Thu, 16 Feb 2023 06:02:37 -0800 (PST)
X-Google-Smtp-Source: AK7set+9m6lSguHPttaA6t6O/ygFLCA9e+/4Kab1ifq4gqWCNbHN1aAIRLEgnyZQl/IvOoVqpE1rDw==
X-Received: by 2002:ad4:5cad:0:b0:56e:af4a:11f8 with SMTP id
 q13-20020ad45cad000000b0056eaf4a11f8mr11940021qvh.4.1676556157593; 
 Thu, 16 Feb 2023 06:02:37 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 w3-20020a379403000000b006bb29d932e1sm1198761qkd.105.2023.02.16.06.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 06:02:37 -0800 (PST)
Date: Thu, 16 Feb 2023 15:02:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 03/12] vsock: check for MSG_ZEROCOPY support
Message-ID: <20230216140230.3ee2362owceyflf3@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <d6c8c90f-bf0b-b310-2737-27d3741f2043@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <d6c8c90f-bf0b-b310-2737-27d3741f2043@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Feb 06, 2023 at 06:55:46AM +0000, Arseniy Krasnov wrote:
>This feature totally depends on transport, so if transport doesn't
>support it, return error.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h   | 2 ++
> net/vmw_vsock/af_vsock.c | 7 +++++++
> 2 files changed, 9 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 568a87c5e0d0..96d829004c81 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -173,6 +173,8 @@ struct vsock_transport {
>
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>+

LGTM, just add comment here for a new section following what we did for
other callaback, e.g.:

         /* Zero-copy. */
>+	bool (*msgzerocopy_allow)(void);
> };
>
> /**** CORE ****/
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f752b30b71d6..fb0fcb390113 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1788,6 +1788,13 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		goto out;
> 	}
>
>+	if (msg->msg_flags & MSG_ZEROCOPY &&
>+	    (!transport->msgzerocopy_allow ||
>+	     !transport->msgzerocopy_allow())) {
>+		err = -EOPNOTSUPP;
>+		goto out;
>+	}
>+
> 	/* Wait for room in the produce queue to enqueue our user's data. */
> 	timeout = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
