Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226EFC4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 08:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AF8C41723;
	Wed, 14 Dec 2022 08:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AF8C41723
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OXEHClnB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgTH2H2q2CMj; Wed, 14 Dec 2022 08:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4E3241724;
	Wed, 14 Dec 2022 08:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4E3241724
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 889F6C0033;
	Wed, 14 Dec 2022 08:58:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3191CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0699681F11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0699681F11
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OXEHClnB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id riOYVskpd2yw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3955281F0A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3955281F0A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671008284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=832mpI+gR6rtu0NTrZQMBVgIPwRT7EhuSzoHFhXLS+0=;
 b=OXEHClnBD5tYGQp8rSHqBnyotmrmtuJDQQk1UCH3WrLW0EWI5zxn8hJr1Mo4DH2kOYr06Q
 vbOqWpJgRhgFH4A1b0616jGQbTbNoWn5YGA+3km+MfYWHoEgd3AblLyPCAcVyzWc699x7o
 gk+BV4pcQQKGbo3s3zkJ69VLOEnCJyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-vkzwB3ASO9icqvZ9-BXF-A-1; Wed, 14 Dec 2022 03:58:01 -0500
X-MC-Unique: vkzwB3ASO9icqvZ9-BXF-A-1
Received: by mail-wm1-f69.google.com with SMTP id
 q21-20020a7bce95000000b003d236c91639so1276537wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 00:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=832mpI+gR6rtu0NTrZQMBVgIPwRT7EhuSzoHFhXLS+0=;
 b=fFQeHt2Qy3M58QXMGnSnhwt1Yq6W4Ej7SNWLpvRm3oJkwhevR2eOfJ1eH+CRJ7hdFg
 a8/S1VN4E2Zs6C449vDcrBnXY5PKJnFU19vk2lGM1OGVPSb5Bzc/7RRMEWp6IiCjyT9p
 iuRy5vtzkmg1B8JcILPRaCqTkoVZpCSy39fxSLr5/UcVollECIiAreSJQL/NhaYCQ7ad
 qhrpl+gdkhh2d6WteiNxF/asoIMWwPHk65Me+nVc37s3bfnjUl+QLjn1R+GBAlGbc55C
 8MMyHk1PvjfTBnvlUkAX8x2GBnZgDniIV8GdozDxGCEFw3jhXXPNYIVCiigehF7ioGQL
 n3gQ==
X-Gm-Message-State: ANoB5pnz3XsaKe15dnul+J24u1B8liR4ILyVRU4iRes96uR+uVWFDPI4
 fP/jhErFgmMlXQMxqRwxIjQukqSmwKZuxWtAeEi3nyNv06YOKijQOW3CJF836rcADYEq32h1AZo
 wD6QapGsGqTfIPDZnOdLrQiv1WqKWCZlia7cLhgiSDQ==
X-Received: by 2002:a05:600c:3d92:b0:3c6:e60f:3f4a with SMTP id
 bi18-20020a05600c3d9200b003c6e60f3f4amr18216240wmb.1.1671008280667; 
 Wed, 14 Dec 2022 00:58:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53p0lWtwtyxZpsSsSCyKb1X/sJvqIEShJdkD4rFJgOxq6InnJoxKzbHWv/g59LP540LxvirA==
X-Received: by 2002:a05:600c:3d92:b0:3c6:e60f:3f4a with SMTP id
 bi18-20020a05600c3d9200b003c6e60f3f4amr18216216wmb.1.1671008280437; 
 Wed, 14 Dec 2022 00:58:00 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 m17-20020a7bce11000000b003d2157627a8sm1685733wmc.47.2022.12.14.00.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 00:57:59 -0800 (PST)
Date: Wed, 14 Dec 2022 09:57:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v7] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221214085754.6kogsesmqcud5ggn@sgarzare-redhat>
References: <20221213192843.421032-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20221213192843.421032-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
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

On Tue, Dec 13, 2022 at 07:28:42PM +0000, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>Test Runs: 5, mean of results
>Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>
>Test: 64KB, g2h
>Before: 21.63 Gb/s
>After: 25.59 Gb/s (+18%)
>
>Test: 16B, g2h
>Before: 11.86 Mb/s
>After: 17.41 Mb/s (+46%)
>
>Test: 64KB, h2g
>Before: 2.15 Gb/s
>After: 3.6 Gb/s (+67%)
>
>Test: 16B, h2g
>Before: 14.38 Mb/s
>After: 18.43 Mb/s (+28%)
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
>
>Note: v7 only built, not retested since v6.

I re-tested and everything seems okay:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
