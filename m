Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92CCC4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5690B6101C
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5690B6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F423840467;
	Tue, 24 Aug 2021 09:52:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oH7OBojM6n7w; Tue, 24 Aug 2021 09:52:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88EE040462;
	Tue, 24 Aug 2021 09:52:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABF7C0010;
	Tue, 24 Aug 2021 09:52:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D59CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 628D640365
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Oc7zlxpXJjJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:52:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 677C2400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629798736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kg6z7dt36I6LiVKwFciZ2psrGVbf2/o69+fbyjnvf4U=;
 b=UnzAdDBmFgkC3bDaCapP8/ePkUIbFgvAZ2ioAXqjAnEPMhjkeavPA9VwPJ8dppKxgDfjYW
 sbNhXBs8Jiuv4TGkDLNz2BBnOjyj2Ar+jwWoSKc6S/fwYyPuFgMj1k/jOl4zfSPtYMsuXb
 z6QLLWLckuGBwJJDe8eRJVUsfp26ubM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-OCgaFg3SP0axt7uiJsU9VA-1; Tue, 24 Aug 2021 05:52:14 -0400
X-MC-Unique: OCgaFg3SP0axt7uiJsU9VA-1
Received: by mail-ed1-f72.google.com with SMTP id
 d12-20020a50fe8c0000b02903a4b519b413so1554957edt.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kg6z7dt36I6LiVKwFciZ2psrGVbf2/o69+fbyjnvf4U=;
 b=fEA86clbLhqlZJF2W7u4c+p/VpyHtCEsGa1GTu/TMLpgDgy67xNrwZoVsvhpQRUfWY
 0rL44UaQ/VW4vF00kI5pa8OQD3mE9rsovMmUo/rgcf1OZULlRW6nBVU2mGCU9vsVqlEc
 B5t/O1iaqInwhNGREiPEvW9yymEu+NLGKdG3KKXU9Tl5HwAiIRegu35CY5czQvoST8ke
 Wz4k71xz87Zhk/7is8RfKjvys8A/jPxNi/5GJYLDKyHE3dub3HL4CplmVPOkpBRm45/p
 o7Zxkqz5ik/IrOeYjdsf+32Mu9RnahDfeq0VYZRRnVxYdo2O8sBBfwLve1fbU2jWH7GO
 65yw==
X-Gm-Message-State: AOAM530qoAzFbRe6dWq1xEG9L6iPnvLPvGrNrTgOxwKmXR3Mqkhrhhj8
 FmUiY6u6Jf5y+FoCM0FH84DnVyZJxnBnR8plM9iN+RMvh9yGDf3TtT8N/2IUwBHPre7Rrpqj4hf
 4V6rsRVt+KuclJmg2ARDDHyOBTttVAtjrLoXsz0XC0w==
X-Received: by 2002:a05:6402:358d:: with SMTP id
 y13mr42408328edc.300.1629798733740; 
 Tue, 24 Aug 2021 02:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4YQVPnF4P439rZmYEXIkrS86lreoMk06pzGCFXpJnDrLV059NdnDnDKyu+XUq3zGXCMLhIw==
X-Received: by 2002:a05:6402:358d:: with SMTP id
 y13mr42408309edc.300.1629798733637; 
 Tue, 24 Aug 2021 02:52:13 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id h8sm9152292ejj.22.2021.08.24.02.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 02:52:13 -0700 (PDT)
Date: Tue, 24 Aug 2021 11:52:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 1/6] virtio/vsock: rename 'EOR' to 'EOM' bit.
Message-ID: <20210824095210.z3iwnjmyztys3yja@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <20210816085112.4173869-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210816085112.4173869-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.co, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Aug 16, 2021 at 11:51:09AM +0300, Arseny Krasnov wrote:
>This current implemented bit is used to mark end of messages
>('EOM' - end of message), not records('EOR' - end of record).
>Also rename 'record' to 'message' in implementation as it is
>different things.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c                   | 12 ++++++------
> include/uapi/linux/virtio_vsock.h       |  2 +-
> net/vmw_vsock/virtio_transport_common.c | 14 +++++++-------
> 3 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
