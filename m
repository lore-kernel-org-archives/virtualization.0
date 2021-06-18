Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BEDC48BE8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 14:47:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7016008E
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 14:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7016008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3B7141575;
	Fri, 18 Jun 2021 14:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ADuHMlq4c0qB; Fri, 18 Jun 2021 14:47:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A1DD41585;
	Fri, 18 Jun 2021 14:47:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5A52C000D;
	Fri, 18 Jun 2021 14:47:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55934C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36F2F60613
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bO45RwlYtf65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:47:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECDAC605DF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624027638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMP9pRN6LXIHJXgReGQ0+2KAZJjDUIOBh1pwqrRBSmY=;
 b=ZA0csBcFsFdIhBVzNdzAgEWhV5059jbr523U3KLjzDGkU6MkTLrzY6xiuyg4wcO2Nr+moV
 Qt2u2fmUTCJxtsZuglzt+8PKhDZuzxu39XqiEdhQphwRGQNkhf1cTQzusa7q+1K1XG/caZ
 UbUn8GUhgjuexCwFzuhfUrSFtvU3gG0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-4hg2vMI9NHWCkDyQJKOQVQ-1; Fri, 18 Jun 2021 10:47:15 -0400
X-MC-Unique: 4hg2vMI9NHWCkDyQJKOQVQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 x12-20020a05640226ccb0290393aaa6e811so3772698edd.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JMP9pRN6LXIHJXgReGQ0+2KAZJjDUIOBh1pwqrRBSmY=;
 b=J0Jr4Zz3AMawalctD6uQ7oXmM6O99G/W7ExvFM7p436TpIosZytGIR/FM7e7EN1AFR
 DieDBvxZxVRNRt5Ql+TxonDzDNeyCc2QFLADrcv3WioK4pg1/jeKST8lcAlmxM9KVN2/
 2aiK1N/DfLMi5wa4eSbzU8mV4v0WEzVkumCWFpn7a5uivzGfa0boiQh+CpNoVtBphTGY
 JZUU97hI9qLNqmN1d2l8hTUJlCxC7th5LMSZ0LWWHdayXYUnisB06ZZFq+CxhKctArW8
 y8o7Pxj5T6pbJZ8FLmsYApKmmOLZX9QjSGSkFvGYN4/e3+7s+YHfl5MNFL0Jq+0wcziV
 dK8Q==
X-Gm-Message-State: AOAM533Coau1dCNfhkAifRta0VqsqswySYcSDH8njM+2M9eujzA/WJEy
 Yn/Bt3koU7eN36rzK8CPr8k7mZzXzp4Egn9GNyBgQx0Ya7ZoQMijvK+Z7/Kkx0a1v6y31DocInH
 /R+4xS8nSqfqrO48m7wqxRvM/jXcY+VzvixQIruvRLQ==
X-Received: by 2002:a17:906:a108:: with SMTP id
 t8mr11272576ejy.407.1624027634486; 
 Fri, 18 Jun 2021 07:47:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKul+fSxDD39m9+XLnvWd/Eh49SqXUpv0elzpE57HLQhIgyiwTkizOc+/rwAhwawniAB4YQg==
X-Received: by 2002:a17:906:a108:: with SMTP id
 t8mr11272565ejy.407.1624027634321; 
 Fri, 18 Jun 2021 07:47:14 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.175])
 by smtp.gmail.com with ESMTPSA id jl25sm746461ejc.94.2021.06.18.07.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 07:47:14 -0700 (PDT)
Date: Fri, 18 Jun 2021 16:47:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v6 1/2] virtio-vsock: use C style defines for constants
Message-ID: <20210618144709.yj2sc7uxbyejb67p@steredhat.lan>
References: <20210524183232.2513690-1-arseny.krasnov@kaspersky.com>
 <20210524183354.2514144-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210524183354.2514144-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
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

On Mon, May 24, 2021 at 09:33:50PM +0300, Arseny Krasnov wrote:
>This:
>1) Replaces enums with C style "defines", because
>   use of enums is not documented, while "defines"
>   are widely used in spec.
>2) Adds defines for some constants.
>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> virtio-vsock.tex | 54 +++++++++++++++++++++++++-----------------------
> 1 file changed, 28 insertions(+), 26 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
