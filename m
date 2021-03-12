Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29352C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:29:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C293B64FF9
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C293B64FF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 782636F7D5;
	Fri, 12 Mar 2021 15:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kwULYYPZDSu9; Fri, 12 Mar 2021 15:29:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3890C60682;
	Fri, 12 Mar 2021 15:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2174BC000B;
	Fri, 12 Mar 2021 15:29:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D39DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B1DC43035
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jaFevQafa6vZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:29:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D6A34017B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615562971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=czotstymJyYNFdPhwwa87kqjbZU6tULSaV4jVggza0c=;
 b=LxJ6AcaLlAICH0lZGFa3nmKYbIBZvYY/p685EJfxmuOpEUzD9sCHw0LjnQcYxchsW93SwK
 9qVeGphAJafDOgUzbYGlViRdrS1eqAVvdKr/y+kcHvFwYgAGxmao10EAzwyyZECBRDD5/I
 OTMVw4wUWZA6VQtrhwjKb5Tm9NiRZN4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-T0ajCxxXPziHt0B5igVC8A-1; Fri, 12 Mar 2021 10:29:30 -0500
X-MC-Unique: T0ajCxxXPziHt0B5igVC8A-1
Received: by mail-wr1-f70.google.com with SMTP id z17so11286233wrv.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=czotstymJyYNFdPhwwa87kqjbZU6tULSaV4jVggza0c=;
 b=RxEG39Fhhi3TvNJmeXx1a+2QfOReVig5DZnYuDK5+GwRQLL8KNOSimERZywOnDNqfQ
 Zwg2mxuM+uyGjxHZASsPbaukexuU+S7gFYQZMZB4vVMLy7wadAl4rom33uTTrnoOMY+s
 T8xsl84ZzjngR98ot8EJCJxnadTVYIKDs81i6lkJdEzAXWSLOiJi7yXnRgXDqyllIoeW
 9sC0v1j2p9GLscxWTH5DJn47c7jh+djEULf//xSw98hBtKGccbvQtZNQbVIitkG30XVv
 QUfgJp5zi9p+zBC4vJ497Yzc6FihFgh3hvdAf6dILW1U9S3yNmPp3wE5LJ3nx0NWoXIl
 8yog==
X-Gm-Message-State: AOAM532Lwu+BtZ1ozRKRUOClAnlTUesC6XSWSz/XGn74Oy6+aBLszZLB
 r50NtPQtsysWU1zqnWqli8x92uDjrA7b4a1u79YZqgk/QZIj8adNxvT7lxiA8CSHWlyfwot2C+s
 EVDs53Zf6vlz0MJGPhPXglqA24Gg/oxihvQGEKlkRoQ==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr14795818wrn.349.1615562968738; 
 Fri, 12 Mar 2021 07:29:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+1YroWw/KII86Gtcw8KIDCORZXNuDVgfD6MmoqYoTncwOuB+icviQJbIfWvZiUkdd1sVuqQ==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr14795794wrn.349.1615562968586; 
 Fri, 12 Mar 2021 07:29:28 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id n66sm2411295wmn.25.2021.03.12.07.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:29:28 -0800 (PST)
Date: Fri, 12 Mar 2021 16:29:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 08/22] af_vsock: update comments for stream sockets
Message-ID: <20210312152926.p75hjd3oghgu6b3i@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180108.3465422-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180108.3465422-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 09:01:05PM +0300, Arseny Krasnov wrote:
>This replaces 'stream' to 'connection oriented' in comments as
>SEQPACKET is also connection oriented.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 31 +++++++++++++++++--------------
> 1 file changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
