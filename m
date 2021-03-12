Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB91C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 14:40:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210FA64FD6
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 14:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210FA64FD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD76944C65;
	Fri, 12 Mar 2021 14:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFa3YBJjxZsw; Fri, 12 Mar 2021 14:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 349E7448EF;
	Fri, 12 Mar 2021 14:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 125ECC000A;
	Fri, 12 Mar 2021 14:40:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15E39C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAC664302E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d2a-3ACr4DbK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB0774017B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615560052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UHFz+ZfMKEJbP5t9K2bCk5hCYslzNNC+cpLu7ln61Mg=;
 b=e/LLKnXCTPu71GWT3YBPiLzffzy7ojHs83LivvDizEg5K5EdgcJtHaSr6sSOHIcL7ncKaX
 Pv8TKdmYgptST9XMXtkXAURpjMbeTjZl3gAQUICSbLQeqC+APh0nxtzkQN0o3Fd03LFYQb
 AJV5xZJeiJrRkYZ1qESQDHX4sqqRiJo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-EGGTAgMvOLW0ctJCzxRa1g-1; Fri, 12 Mar 2021 09:40:50 -0500
X-MC-Unique: EGGTAgMvOLW0ctJCzxRa1g-1
Received: by mail-wr1-f70.google.com with SMTP id h5so11210655wrr.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UHFz+ZfMKEJbP5t9K2bCk5hCYslzNNC+cpLu7ln61Mg=;
 b=ea/GtAAju/X2Xgv1gg5Q6LAq7AA9OYCntf8PozHghA+ie4vcQfgbLcAQzgP3OMRYuZ
 dh8cfVr1Yj0JSzcOOw9aLDrPuVJFKmCciKBEk9nOiC3NRkUWLwEIk58qtOq3Ht4a2kzs
 cBhePLyyvzCoZwvUEUn9kbD4/tpCIU7gkX58GbTWqWzdaegbHaL0em5T/I+7RFxEAhGD
 np2radwoRIENErXXOTKB44+IIrNYtKAQD+01/1Iy2I5jSTUtTE7a1OEHdKCIlkhmXLA1
 zqNOwAoLBLa1CwjOXrulsu3612mUIA+95G61GKsqRGxfFJFO8cvQL71ookRB4SiLMvvu
 ye2Q==
X-Gm-Message-State: AOAM5318nym98Cpjc7QAo/3fb0gKF7SasYc7rybF2nRcoGonLeb2tubO
 pl9xU5fO1W92jhtFs5XW9L5Wu9Q0WSVrOcncQSteEl30sB0DrQWGHADgFlZf6zHqeH5Q4Gjp9R0
 6LFgIk6rh6X7BN5mUZVz9uzRQHJnmI0QKr7dOjaWKHA==
X-Received: by 2002:adf:f841:: with SMTP id d1mr14157275wrq.36.1615560049592; 
 Fri, 12 Mar 2021 06:40:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgzENVDWH77SrdxqPP5xavvsUwfa0+M+2ZdEnSJauzOQ012YEkvpkDBfuH0dxQ2NcCuQ1oKw==
X-Received: by 2002:adf:f841:: with SMTP id d1mr14157254wrq.36.1615560049394; 
 Fri, 12 Mar 2021 06:40:49 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id q17sm3268632wrv.25.2021.03.12.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 06:40:49 -0800 (PST)
Date: Fri, 12 Mar 2021 15:40:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 02/22] af_vsock: separate wait data loop
Message-ID: <20210312144046.dnthewowhmkvfotd@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307175905.3464610-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307175905.3464610-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Sun, Mar 07, 2021 at 08:59:01PM +0300, Arseny Krasnov wrote:
>This moves wait loop for data to dedicated function, because later it
>will be used by SEQPACKET data receive loop. While moving the code
>around, let's update an old comment.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 156 +++++++++++++++++++++------------------
> 1 file changed, 84 insertions(+), 72 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
