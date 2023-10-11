Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2FFCD6E67
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 12:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C69D80BC6;
	Wed, 11 Oct 2023 12:54:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C69D80BC6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUrXNS+a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEqxAR-wUQnD; Wed, 11 Oct 2023 12:54:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7EFA180BD4;
	Wed, 11 Oct 2023 12:54:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EFA180BD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A8EC0071;
	Wed, 11 Oct 2023 12:54:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 118C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF9AD41E37
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:54:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF9AD41E37
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUrXNS+a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tngdWuNevv5f
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:54:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F30AA41E11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 12:54:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F30AA41E11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697028881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+7ZEoe9gqs3ohA/tE8e5TAOHw5GEtQ2AHlZY+ECy20=;
 b=YUrXNS+aJ2jX4bFV4ciu9HUIFxST2yzcS0W7yLmz9OmNplAL5bJLZPEbrVqc/ZBDzo6hN2
 Kk3mRqwSXyzYDlZAUmwiFEA6shhnF/bxJcVN64x7VK/bYMqkpM1wgnDdmJksCh/ioAyBfQ
 vnpQhr354DVMQbuKYvBcuYjUv440j/U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-snF7feLPOIGMeIKfNqsfLA-1; Wed, 11 Oct 2023 08:54:40 -0400
X-MC-Unique: snF7feLPOIGMeIKfNqsfLA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7742bab9c0cso714965785a.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 05:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697028879; x=1697633679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+7ZEoe9gqs3ohA/tE8e5TAOHw5GEtQ2AHlZY+ECy20=;
 b=rWuGg2Q3cDeMssbfg8l2K835dsfYkVaOQaMF4vSj8F+JGf3vNYW3A1VhTzSQHytL0j
 SOJ0Ap73Mq7Jj/jMhqz2CwopLZccL1fJbMKq+MT3M48NAN24dASqdhzkYOXqg2ok/Hbz
 +vzx/fhKIcOOYPNdJ87AslmYqQJ5bLHUWfnj862emyTVrQKVcCUqGrmmxnQTZA7E4pq4
 25E+ufzl4EivQlHT8BXuOU0WcguToYHyaRhGZYS8v23WhBqnLrzHhh63jh1cjCn25mTA
 5D7hmsPFKvepU87j2phovB/uckrqag9+19GqwVFZnomorJ1OEJfmyzhPlySQDMht0GvP
 psTw==
X-Gm-Message-State: AOJu0YxKLWxjbMXFHe8b9uLUHU4qhtX+BZlEwSmGx0VIOpBk131kiMxK
 gioJdNDL7zPe0ohss5FV2brFLdtZHG7KNiifcoCDIhU3qP7Q4Cu2BFeJWAaV3DFpjyfCpHjRQok
 zGC0mzRAG8DCI16VpxS8avGhaVFJWfcnRiagwUPqICw==
X-Received: by 2002:a05:620a:288c:b0:775:cf6d:a468 with SMTP id
 j12-20020a05620a288c00b00775cf6da468mr20569728qkp.49.1697028879725; 
 Wed, 11 Oct 2023 05:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9V91LsLeBU3VLmajHUFBGtvS1V1JObKngcrNenQu9Dow0QDj9KmJu20EfpX9LZg4A5flqNw==
X-Received: by 2002:a05:620a:288c:b0:775:cf6d:a468 with SMTP id
 j12-20020a05620a288c00b00775cf6da468mr20569709qkp.49.1697028879396; 
 Wed, 11 Oct 2023 05:54:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it.
 [79.46.200.251]) by smtp.gmail.com with ESMTPSA id
 oo23-20020a05620a531700b00774652483b7sm5210995qkn.33.2023.10.11.05.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 05:54:38 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:54:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v4 02/12] vsock: read from socket's error queue
Message-ID: <w3r22qa6ydaxa5ke34v6v6lruxyvxrpx2jo7dnakyyvaoqu52j@ohocxsyqpxj7>
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
 <20231010191524.1694217-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20231010191524.1694217-3-avkrasnov@salutedevices.com>
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

On Tue, Oct 10, 2023 at 10:15:14PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Place new defines for userspace to the existing file 'vm_sockets.h'
>    instead of creating new one.
> v2 -> v3:
>  * Add comments to describe 'SOL_VSOCK' and 'VSOCK_RECVERR' in the file
>    'vm_sockets.h'.
>  * Reorder includes in 'af_vsock.c' in alphabetical order.
> v3 -> v4:
>  * Update comments for 'SOL_VSOCK' and 'VSOCK_RECVERR' by adding more
>    details.
>
> include/linux/socket.h          |  1 +
> include/uapi/linux/vm_sockets.h | 17 +++++++++++++++++
> net/vmw_vsock/af_vsock.c        |  6 ++++++
> 3 files changed, 24 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
