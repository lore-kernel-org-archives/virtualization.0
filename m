Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDEFC4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:54:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B096101C
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5B096101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 707D6403A5;
	Tue, 24 Aug 2021 09:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXCyJZT_1Che; Tue, 24 Aug 2021 09:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8AF640365;
	Tue, 24 Aug 2021 09:54:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA122C0010;
	Tue, 24 Aug 2021 09:54:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41B9EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36C8080CE6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znjKGfirNA26
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 994B980CAD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629798856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OQ7wXqd35jkq9u//jEUxGDrlsnHE5KbTspU7KytW0gQ=;
 b=AM7V7dlmo1stASQ/tIHUcVKPko1uwGcn+3jiW4wUo6x+H9LFxhlTeuldxfj+TslsS0vSjc
 dywZId7SG/ucoqz1orrjP0FWx30w9szGLWd/kf24BAtjxWjxC3LvzugD1qEsHkH5RmW1U9
 /vn8hWxLu5uoBSzHoadkzxFMylCFhho=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-01J2uWnVP0uEcDjVQbY01g-1; Tue, 24 Aug 2021 05:53:07 -0400
X-MC-Unique: 01J2uWnVP0uEcDjVQbY01g-1
Received: by mail-ej1-f70.google.com with SMTP id
 v19-20020a170906b013b02905b2f1bbf8f3so6802462ejy.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OQ7wXqd35jkq9u//jEUxGDrlsnHE5KbTspU7KytW0gQ=;
 b=LfUAsCHeRqGpiPhHLgDxm8HkbBzujLjh1HPeVLSPseV7XsLgUTPJQNLMxsaDhm+/WM
 eXeTq50KHCVaJ3F9rg924f3qWB9CN0lApNpa+8HyYJ9QT8bVTYGfF2yraDqRFipbfYMe
 SriWNMiRWDdT0433Cd1StSrLHavU+XUiOk4wcO/KR0Afrt0CwqKLw2otK8G0nwIurLYw
 f2GnLnyKGumV+G/OVXzvHDGL95nN8f6/TBBEw/59YGSEn0OchfrcXHXLRw7cOysgT/aC
 hn+GJyIsdKsHqgYvYk7dm7xDtxEuBLguZz2sr11j3tw0AzGi5E4+fEv5LCn38tqma16p
 IgFw==
X-Gm-Message-State: AOAM530kFlGjZY9JS0ABDhEQxrfnSOgxG83Q7Y0++ozCLqSyuxzhAU9M
 lgUDsXoMu3j5bDUyjTcJX2XhCkyScgnWxOHOCezPE5zGJ8V48jZpkPA1KyvLn5au5dF7Hxj4Ylt
 NX3lE5awuxFRmBUebLplfOh8fCtWrOzr1XJK8ttvbKQ==
X-Received: by 2002:a17:907:1dcf:: with SMTP id
 og15mr4899933ejc.470.1629798784612; 
 Tue, 24 Aug 2021 02:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9y5QQWKGxjE2KrEc2IutIocxe55cgt45xzuJQQ4MACHDUf8AJaPA8kHZYDYQkMpudS3S8yg==
X-Received: by 2002:a17:907:1dcf:: with SMTP id
 og15mr4899921ejc.470.1629798784495; 
 Tue, 24 Aug 2021 02:53:04 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id o6sm4341681eje.6.2021.08.24.02.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 02:53:04 -0700 (PDT)
Date: Tue, 24 Aug 2021 11:53:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 2/6] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
Message-ID: <20210824095301.udvwh2hatrf2l3mh@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <20210816085126.4173978-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210816085126.4173978-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.co, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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

On Mon, Aug 16, 2021 at 11:51:23AM +0300, Arseny Krasnov wrote:
>This bit is used to handle POSIX MSG_EOR flag passed from
>userspace in 'sendXXX()' system calls. It marks end of each

Maybe better 'send*()'.

>record and is visible to receiver using 'recvmsg()' system
>call.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/uapi/linux/virtio_vsock.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 8485b004a5f8..64738838bee5 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -98,6 +98,7 @@ enum virtio_vsock_shutdown {
> /* VIRTIO_VSOCK_OP_RW flags values */
> enum virtio_vsock_rw {
> 	VIRTIO_VSOCK_SEQ_EOM = 1,
>+	VIRTIO_VSOCK_SEQ_EOR = 2,
> };
>
> #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
