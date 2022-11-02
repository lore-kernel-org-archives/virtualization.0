Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBC0C433FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Nov 2022 09:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD27E607F1;
	Wed,  2 Nov 2022 09:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD27E607F1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V7MrpPYa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C246wXJ9i5fb; Wed,  2 Nov 2022 09:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5172B607FF;
	Wed,  2 Nov 2022 09:31:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5172B607FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 231A6C0032;
	Wed,  2 Nov 2022 09:31:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88512C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 472B84091E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:31:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 472B84091E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V7MrpPYa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sp4fLiyso2TP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:31:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D355B40912
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D355B40912
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667381505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiXyFbNQfgw1EbxRUL2H94emHZF9fnomkSKKEY8Wyhw=;
 b=V7MrpPYaCoCQytswCrFkezV6dc19wkNirVYzr3S42jh/mvmaeyRWzgQBV/EKqodoivsRfC
 M/0lurqfsxhssyWjYte7ZzMXGPOOxP+s7bAmNYF5GPOIf3V8MrcklsYPmETs+5kn0YuO9w
 vX7mFc1Xqxb1NUp/taSkj35muy9a9FQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-sIuwCl7MNcSwcmp314NSHg-1; Wed, 02 Nov 2022 05:31:44 -0400
X-MC-Unique: sIuwCl7MNcSwcmp314NSHg-1
Received: by mail-qv1-f70.google.com with SMTP id
 mi12-20020a056214558c00b004bb63393567so9678417qvb.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Nov 2022 02:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiXyFbNQfgw1EbxRUL2H94emHZF9fnomkSKKEY8Wyhw=;
 b=SOr9h6E9gnhao5DAYxxP91BjwuXFkmeBJoQXIyP1LZWdN8vOeKlO6En67tiMFdIfgm
 tIJRb+OkTQI66U/IpREXBP9Z0zymghYdXJCne41N6yVuLHDJYjIPghRnLqCuKx7iYT5J
 wPOhCG60VyxOSy69t3NRqr1FR7oeedVyaVfsJ4Jb461o1V3iKxFNl/frbiSAojeUu/Ql
 gDnv+CQ7ezkmK3GP42VplGSpUO8lGmonRZjpUwGLoh/K8dK2IWGb0Q+SiS7eBHFgOyef
 VC4+pvp7wB95VLPxMlPIuies5QiH/cmqcMx9x/BKLuXb1+VxSsYcbUzDOC04bqS4Hqpc
 iYIA==
X-Gm-Message-State: ACrzQf2TAP38tEUQP8NArk0tO7GZ0a24NZNyq4rqCjoqu4g2n6mkqWDM
 aMyj+KmFAv+k276eEDVR43t0a5NLRym4XyN18C4TAJuBRQIy9wHon7JHdZVp4gufUHqmUpvQGiT
 jEbIHFpR9JnQBM233WXGNDN1H3Zashdfb/ZIAp0MuJQ==
X-Received: by 2002:a0c:e2d4:0:b0:4bb:5902:922c with SMTP id
 t20-20020a0ce2d4000000b004bb5902922cmr20026043qvl.57.1667381504103; 
 Wed, 02 Nov 2022 02:31:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7fwcDDdofDJz+WZYfF1ydzjXTJWpUN8/UcIhN3q3TEjSy7NElKUQE03Ks6CSlPZF4dfR2Qnw==
X-Received: by 2002:a0c:e2d4:0:b0:4bb:5902:922c with SMTP id
 t20-20020a0ce2d4000000b004bb5902922cmr20026034qvl.57.1667381503910; 
 Wed, 02 Nov 2022 02:31:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bs33-20020a05620a472100b006fa617ac616sm486080qkb.49.2022.11.02.02.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 02:31:43 -0700 (PDT)
Date: Wed, 2 Nov 2022 10:31:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221102093137.2il5u7opfyddheis@sgarzare-redhat>
References: <20221101021706.26152-1-decui@microsoft.com>
 <20221101021706.26152-3-decui@microsoft.com>
MIME-Version: 1.0
In-Reply-To: <20221101021706.26152-3-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 edumazet@google.com, kuba@kernel.org, arseny.krasnov@kaspersky.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Mon, Oct 31, 2022 at 07:17:06PM -0700, Dexuan Cui wrote:
>Currently vsock_connectible_has_data() may miss a wakeup operation
>between vsock_connectible_has_data() == 0 and the prepare_to_wait().
>
>Fix the race by adding the process to the wait queue before checking
>vsock_connectible_has_data().
>
>Fixes: b3f7fd54881b ("af_vsock: separate wait data loop")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Changes in v2 (Thanks Stefano!):
>  Fixed a typo in the commit message.
>  Removed the unnecessary finish_wait() at the end of the loop.

LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> net/vmw_vsock/af_vsock.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d258fd43092e..884eca7f6743 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1905,8 +1905,11 @@ static int vsock_connectible_wait_data(struct sock *sk,
> 	err = 0;
> 	transport = vsk->transport;
>
>-	while ((data = vsock_connectible_has_data(vsk)) == 0) {
>+	while (1) {
> 		prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);
>+		data = vsock_connectible_has_data(vsk);
>+		if (data != 0)
>+			break;
>
> 		if (sk->sk_err != 0 ||
> 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
