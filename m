Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F081C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 10:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90F3C83FFD;
	Thu, 23 Mar 2023 10:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90F3C83FFD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaoLuc2Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXt2j7Hp6peW; Thu, 23 Mar 2023 10:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 36854812F1;
	Thu, 23 Mar 2023 10:48:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36854812F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 118E2C0035;
	Thu, 23 Mar 2023 10:48:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 797B7C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 10:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53D5E40514
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 10:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53D5E40514
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaoLuc2Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUFQr9NpeL8s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 10:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1AAC4014D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1AAC4014D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679568485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZmXocTVKetihT0r8O5N7xAJurjCNliQJkGA8ddiit8=;
 b=IaoLuc2YuTbRMc6E2O11R0Z9fZMfOco19OD7dxBcVtQyLCHbxeW1QVmpzyHBntE/EYjWpj
 45iJQAFbbvESrY3EsVqJ45zEe7epyfT7Jm7aGnWZDx6iZR2baPiPuLBHvLsULJpp/vuSAi
 oALl5rwpOHgTIMcBwtijItmuJo0VNJs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-v02n8wnBPBqJEoYIF_Smtg-1; Thu, 23 Mar 2023 06:48:04 -0400
X-MC-Unique: v02n8wnBPBqJEoYIF_Smtg-1
Received: by mail-wm1-f70.google.com with SMTP id
 e5-20020a05600c4e4500b003edc5824521so836710wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679568483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZmXocTVKetihT0r8O5N7xAJurjCNliQJkGA8ddiit8=;
 b=SZa3oaTCLUmmBfDN1+qB64J30b4SPUBqayM5WazUhB45kuG2hlQH61HR6FPiTL/bsF
 rrcI04qQsybKPau8PBEbSgadscg17+1y4vqhusJzqk+6vQYDUU2t6aaSqvbJvs3/70Ej
 pLiS7OP3Op7IfCpcG6UrUCA85ALBKhjtvZ2+wkD6YMS4hFiLN0QHFaCOphzyJ0zUlFkN
 HslWUHi12AJQn0Ow44TwmD/AOvp3EDNh5DdY81kbKriliMbIs+cHjuNr2Ve0Tyhxt3RS
 YWoWKwZKxST2KNQ8d89lWQJAOURgcSsCgv0ypFZ5wTWmliiR+ROfeZN5lZIoGHjtN+tt
 3x2w==
X-Gm-Message-State: AO0yUKVmWMbfuRGZAinIQGm0sDom2oIFyv5JYX7hjVxnRsKcG1N600sG
 Gk/OhHexgSUt0lNeC0ziU8iL2PqbU4yu+tpnJJSJ0D3CqenXBs/pxUfiekjCChtWVUiUK7++gOL
 PzJqD35/cw/NejFYyoBCCuC0jvg4n8af0d58f0R/XVQ==
X-Received: by 2002:a1c:7310:0:b0:3ed:3522:689a with SMTP id
 d16-20020a1c7310000000b003ed3522689amr2020089wmb.7.1679568483451; 
 Thu, 23 Mar 2023 03:48:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set8bEI0jSdYbR5gbAZvyCtCLmXwY6ExIXLcczwR1j7zd0riDw0ijO9qGw68PRNC9fckrcMieyQ==
X-Received: by 2002:a1c:7310:0:b0:3ed:3522:689a with SMTP id
 d16-20020a1c7310000000b003ed3522689amr2020075wmb.7.1679568483209; 
 Thu, 23 Mar 2023 03:48:03 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 u13-20020adfdb8d000000b002d2b117a6a6sm15874355wri.41.2023.03.23.03.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 03:48:02 -0700 (PDT)
Date: Thu, 23 Mar 2023 11:48:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 0/2] allocate multiple skbuffs on tx
Message-ID: <20230323104800.odrkkiuxi3o2l37q@sgarzare-redhat>
References: <f0b283a1-cc63-dc3d-cc0c-0da7f684d4d2@sberdevices.ru>
 <2e06387d-036b-dde2-5ddc-734c65a2f50d@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2e06387d-036b-dde2-5ddc-734c65a2f50d@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, Mar 23, 2023 at 01:01:40PM +0300, Arseniy Krasnov wrote:
>Hello Stefano,
>
>thanks for review!

You're welcome!

>
>Since both patches are R-b, i can wait for a few days, then send this
>as 'net-next'?

Yep, maybe even this series could have been directly without RFC ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
