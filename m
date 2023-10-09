Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C04BE95A9B
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 15:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3476341734;
	Mon,  9 Oct 2023 15:18:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3476341734
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0ccwzsH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zxKnPS7HYKHQ; Mon,  9 Oct 2023 15:18:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C820D41705;
	Mon,  9 Oct 2023 15:18:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C820D41705
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A40B3C0039;
	Mon,  9 Oct 2023 15:18:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCE7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98F44607FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:17:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98F44607FF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0ccwzsH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03JzJWTDpTFl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:17:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5981160C17
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:17:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5981160C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696864676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5JcXPIqedItIu+FW3AQTSKHWl8dmpt+dQk3rJLF9AU=;
 b=F0ccwzsHhgP8+oHJCoka9H/5S0ucS9O4cMI+PQs5Z+5tz1s8lFZSEzBDNKvSy04tV/XT7Z
 64NE2ricyXcesUtn419oaAsxa2p1z6SxxKoQIOftKF2twdRwhiifkN039LcNcf6LIAQCbP
 uIXMEo3p1iRH58WPks/2MVyBj99N/xI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396--t8QMsVOPYyvx0xpivWszA-1; Mon, 09 Oct 2023 11:17:39 -0400
X-MC-Unique: -t8QMsVOPYyvx0xpivWszA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5334e22b2dbso1298914a12.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 08:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696864658; x=1697469458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5JcXPIqedItIu+FW3AQTSKHWl8dmpt+dQk3rJLF9AU=;
 b=UVGTRKreGjOhkcBg7kuetJAM/qRYB2jQkSU0Us5hcvTa4//j/RaJ4ZfCHRjIPX8iSo
 iCRzntmIAPJOnDa19iJ7qkQpQElwvGtHaqDcFthPZ7r2xFOdejtY/ryrmajQEaaL6Tyl
 8WUp9gTEQS7K8f33BSOLBDAJpIVivu96mMQeFFAVyCQUXPbRIofwH0xx/LnBp5+pF88W
 v93Spm5TH+J92kyLvEVRbmh2vEnaZrsUmEClXGQvKTQlL7YTNwaDw8mj/7J47KQoiSQo
 3t57N4JDeICLAeuKlGI/Lw7+QCQwzcz+lv4zUtResCu1wHkMGIuYiocyQBhrJ3FsHTDT
 mY1w==
X-Gm-Message-State: AOJu0YzWMGF/Q18rGi9A876el+BlMUJ+gofjsYm34PWx/O3V1usS7kpJ
 paplJSpBLOE//gsHutJjKnClTUN8nA/WKH+tPdSlfqcZ7nlQ7Hjb7+FvV7U16Hu3YYWWYiJu5/O
 trTeKIyRSX00fEEq9NfzO7RfN1CaTESK/gCqG+HIj3Q==
X-Received: by 2002:aa7:c991:0:b0:536:e5f7:b329 with SMTP id
 c17-20020aa7c991000000b00536e5f7b329mr13448864edt.33.1696864658547; 
 Mon, 09 Oct 2023 08:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqaNdjOVR8GEVS7MrW8+be1z+py7ZOPR3ncwNWSeW3qxMntltB1eh7SSq1dhz3kONe9XqOGA==
X-Received: by 2002:aa7:c991:0:b0:536:e5f7:b329 with SMTP id
 c17-20020aa7c991000000b00536e5f7b329mr13448839edt.33.1696864658056; 
 Mon, 09 Oct 2023 08:17:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 w24-20020a50fa98000000b00532bec5f768sm6197050edr.95.2023.10.09.08.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 08:17:37 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:17:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v3 11/12] test/vsock: MSG_ZEROCOPY support for
 vsock_perf
Message-ID: <afcyfpp6axca3d2ebtrp44o4wqxkutbn6eixv2gnpa2r3ievhr@yx2462i5p3e7>
References: <20231007172139.1338644-1-avkrasnov@salutedevices.com>
 <20231007172139.1338644-12-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20231007172139.1338644-12-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Sat, Oct 07, 2023 at 08:21:38PM +0300, Arseniy Krasnov wrote:
>To use this option pass '--zerocopy' parameter:
>
>./vsock_perf --zerocopy --sender <cid> ...
>
>With this option MSG_ZEROCOPY flag will be passed to the 'send()' call.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Move 'SOL_VSOCK' and 'VSOCK_RECVERR' from 'util.c' to 'util.h'.
> v2 -> v3:
>  * Use 'msg_zerocopy_common.h' for MSG_ZEROCOPY related things.
>  * Rename '--zc' option to '--zerocopy'.
>  * Add detail in help that zerocopy mode is for sender mode only.
>
> tools/testing/vsock/vsock_perf.c | 80 ++++++++++++++++++++++++++++----
> 1 file changed, 71 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
