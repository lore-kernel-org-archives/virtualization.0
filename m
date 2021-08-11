Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7383EC4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:22:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BACE60FC0
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BACE60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C559F60809;
	Wed, 11 Aug 2021 09:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ELYhIq7MkIla; Wed, 11 Aug 2021 09:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61134605C7;
	Wed, 11 Aug 2021 09:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34C52C0010;
	Wed, 11 Aug 2021 09:22:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F442C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C59460824
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sY25rgs6Osw5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B29160809
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628673748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OLGJiyz5UaykHTThCz8bOAjGg8pe3qYt43SOMCUzTo=;
 b=caf/lhGZaHeW8uGt+8UWTun7B34FoccULjwmIx53jBFzv8Eq5Tl6HACmFN7Abl3U7gcluE
 2CHwqOxF1cjLeiHwSY2T16n42FGAgzALQqDL7vjLhukISO6b6A8rgK3BT38jY+KRRO0eSd
 hB/Pb+lavP4XsegoS9OzjqS372OiQOE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-d208EJVHOMeNScZtwzvOuA-1; Wed, 11 Aug 2021 05:22:26 -0400
X-MC-Unique: d208EJVHOMeNScZtwzvOuA-1
Received: by mail-ed1-f71.google.com with SMTP id
 n4-20020aa7c6840000b02903be94ce771fso364082edq.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2OLGJiyz5UaykHTThCz8bOAjGg8pe3qYt43SOMCUzTo=;
 b=rTkt+nxrSAurF+xTIIR65KQyG4J8Sll9AuFx8RKtUNQ0ete3seyz+dduvWam7CzcJs
 WaQaWnHuLINHFYv++siosDcUyrH3FgBeiq/Ly5uQM66//qvQyG7RxxnLXZC5tnj/E1Cl
 5m1yW1aVD8tqWYjC0oFJ4oRoWR4jJ1P3EImPX6JrT7d3bmPRcj0PGHZcP/URakec9bKW
 zEqyMwYqkSpdsGr+7MILAzgpO/Lj79GHmRy15m1ZPDHpBJLmzZhrkZCTH7AhcQkqarU/
 7pVxaufw+SCzsiIWXrJyQMpWfQYLqfSep4ZlhPPYxCMQtCx+MFzOqNeR9Qo9PBOr/R8z
 gzFA==
X-Gm-Message-State: AOAM533YaBtJH0+v8I7F32jpr1dhZdG0BU2jk2FyIbj8WMm4YrajB4xu
 y2L5Xcj9+WVOxL4D1Gn6YfUK7571z6Fbo5+IPfZCXZiiHfbWjq9e8hFb0ViIG63QJ+CNJl8sX2J
 6L89AgJeT8/5VBV5+Hw5WiXVcvWY1IdubQcmuNpfjHw==
X-Received: by 2002:a17:906:ac1:: with SMTP id
 z1mr2618370ejf.261.1628673745796; 
 Wed, 11 Aug 2021 02:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXzGekdwf/b0v/VzWVWjv1GzKpDuBNLFQla3yFB/mlHFrJDQkHRw2W4dWl+bab5+yUTgokeA==
X-Received: by 2002:a17:906:ac1:: with SMTP id
 z1mr2618352ejf.261.1628673745617; 
 Wed, 11 Aug 2021 02:22:25 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id jo17sm3962562ejb.40.2021.08.11.02.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 02:22:25 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:22:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] [RFC PATCH v7 1/2] virtio-vsock: use C style
 defines for constants
Message-ID: <20210811092223.5huvk5mewtalnkdg@steredhat>
References: <20210810114616.1216243-1-arseny.krasnov@kaspersky.com>
 <20210810114653.1216436-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210810114653.1216436-1-arseny.krasnov@kaspersky.com>
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

On Tue, Aug 10, 2021 at 02:46:49PM +0300, Arseny Krasnov wrote:
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
