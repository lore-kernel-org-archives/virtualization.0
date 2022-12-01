Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F059C43217
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 09:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A918860585;
	Thu,  1 Dec 2022 09:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A918860585
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEb7MM5P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ea0N9J1tZUVR; Thu,  1 Dec 2022 09:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3521E61074;
	Thu,  1 Dec 2022 09:18:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3521E61074
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAE2C0032;
	Thu,  1 Dec 2022 09:18:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32C2BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F39844012E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:18:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F39844012E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEb7MM5P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sj4DqH9CNZG5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:18:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D1A640157
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D1A640157
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669886300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vIuTEZiHlEaLkOOiRuwwN1u46N3S1zvX6DQsFHhXfNs=;
 b=eEb7MM5Pbiu/uXrzkjTla1jRUcneYtKyGZXtG6RdzeFAZ27ki+YuhgiNsLHVBttwneQB+t
 FIBcs6SKXEZLYOUjOZVct5ouBKGsurL9OWCBNRJX/HJKktikH81AUQlTUUhVaCEYdiNtVP
 PMXSPtgTvPiMD2QpWrbkDBWAdeLtDrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-bWXIyPjtOCK5eOERZmx5YA-1; Thu, 01 Dec 2022 04:18:17 -0500
X-MC-Unique: bWXIyPjtOCK5eOERZmx5YA-1
Received: by mail-wm1-f71.google.com with SMTP id
 f18-20020a7bcd12000000b003d077f0e3e5so442866wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 01:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIuTEZiHlEaLkOOiRuwwN1u46N3S1zvX6DQsFHhXfNs=;
 b=78qs9abWLHe91iXbRdz9QmvAgKhUA3AfoY8ujyIv7YBHqEvhOeuHmubSH1CKIZUlhO
 X3OcRREqfRELYfJlrKH1TdY2yQT5fNv0RolaVeO8PuKZjSCUR/lDZdO5gXbyXXTwCvzC
 FYo/VBS4iK3nnq7FlIB/OEBEe0areqOqRTIEMD3BEymEU4q15XsicEd8sYn3QbGF7re9
 ldt7/5nNTWSspZewGAIcu/LnKFb2F1mwHQIexhpVVR8qZ2GluXgIzJf2Pcr7hTd61aBU
 UiMjrguXdmPQ3AD7nWd6O5osWGmDtJqF1lPU9jQkCx4GOSCvgr+tPbMCo1TTsRpDFgb4
 hH3w==
X-Gm-Message-State: ANoB5pl/1qXdhBj6xae95LZG1Wx4vWdLScYpRHnCc2uI33580cXGgbXm
 3Tu90AajrZaFPjEuUCg90wvUD2ssqS06K8z5TmPSuVlSNOaIYYQDAFs8+C6Qt4inkztjNMr6tEk
 uzeAIPa5P/dyCSubJnRUh62HK2OKQCoKxTUAW8PnT3w==
X-Received: by 2002:a5d:5948:0:b0:241:e929:fc44 with SMTP id
 e8-20020a5d5948000000b00241e929fc44mr25586482wri.27.1669886296307; 
 Thu, 01 Dec 2022 01:18:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf56QBIAqebrTf81srtx8Wms1KunBwXJwbQrplf/Bwb4UBr5M9FHfw01rhXcxCuBcF+looDkuA==
X-Received: by 2002:a5d:5948:0:b0:241:e929:fc44 with SMTP id
 e8-20020a5d5948000000b00241e929fc44mr25586457wri.27.1669886296097; 
 Thu, 01 Dec 2022 01:18:16 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 n22-20020a7bc5d6000000b003c6c5a5a651sm4692542wmk.28.2022.12.01.01.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 01:18:15 -0800 (PST)
Date: Thu, 1 Dec 2022 10:17:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/6] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <20221201091722.p7fth4vkbbpq2zx4@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <84f44358-dd8b-de8f-b782-7b6f03e0a759@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <84f44358-dd8b-de8f-b782-7b6f03e0a759@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Nov 25, 2022 at 05:03:06PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This removes behaviour, where error code returned from any
>transport was always switched to ENOMEM.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

This patch LGTM, but I would move after the 2 patches that change vmci 
and hyperv transports.

First we should fix the transports by returning the error we think is 
right, and then expose it to the user.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 884eca7f6743..61ddab664c33 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1862,8 +1862,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			written = transport->stream_enqueue(vsk,
> 					msg, len - total_written);
> 		}
>+
> 		if (written < 0) {
>-			err = -ENOMEM;
>+			err = written;
> 			goto out_err;
> 		}
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
