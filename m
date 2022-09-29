Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80E8C433F5
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 16:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25EB160BED;
	Thu, 29 Sep 2022 16:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25EB160BED
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGjMVZFR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IYbDAaZs9Txd; Thu, 29 Sep 2022 16:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B9EF560AFC;
	Thu, 29 Sep 2022 16:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9EF560AFC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E2EEC0033;
	Thu, 29 Sep 2022 16:25:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDCD6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 16:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6A3E40117
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 16:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6A3E40117
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGjMVZFR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cJdpWd1Q1_CU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 16:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B107400DB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B107400DB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664468721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wP+ERui3HiyMQ5txVX6VKAqSsbRuHdNYsyw/tUJPBgg=;
 b=dGjMVZFRkZn/kNuLNaxiIwYSHOXZxB7+/k8CSYtSZmIcuPWLqizYcuT5tHRGcR16l04BQS
 +X9sqyVtRL7bI25mLV+tEarPE6qdro7XLQN5aJGyws1dhY2DigUVvqH6rnXau41vrmbcE+
 YA+Nh/iykrNF92NbHwaEM+yXxqCwuag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-vEnevMhWOdWz7umflGbCSQ-1; Thu, 29 Sep 2022 12:25:20 -0400
X-MC-Unique: vEnevMhWOdWz7umflGbCSQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 i1-20020adfa501000000b0022cd1e1137bso724518wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 09:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=wP+ERui3HiyMQ5txVX6VKAqSsbRuHdNYsyw/tUJPBgg=;
 b=xuDuoLJBXsHebFhl3FE8t8GuN+8fkUTLsFXkrpCwpchypeGwop3w/HXjN1BL9rO97u
 6kbVKcNv9JzcW+c4LmT8jOR2mqzh43Sl7+aSWIXmJjPlKz4LYjHTIGDLfEe8hs6G/pRB
 HKpbUgibeztQ9NVHQdOaZ8lT+iofgteU9sGU1dJrNkJTjqSEddY6TogPdh35HOBRGdZj
 rogMVHP51pxYAmeGO7kMBJeaGousn0kv4nA03ET5wDIl+Knrw+Iji2EOa4qFNn5lmCDb
 eTtB4xLVT8JcXsltuArZrYzywA8aM+NbF7ti3kxe/izopl1vhgPlb8eWB/Flvx/lnO4q
 V5mg==
X-Gm-Message-State: ACrzQf2bDsvYSy4p1Pzt2o0r95Cep/2zWFSjQtj0coAxicXhNnId9Trq
 cz5O8g6k8eyVwP3TagdNI6dqc6SxMxTZV8DOqMr0uKAHzLrPW5chvg8jMxNk86KrGr1GMQJn7En
 HQNse0T2BeoIqszVUXMl/O1c1aRo0/RuvrqhksjiaMQ==
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id
 r5-20020a05600c320500b003b33813ae3fmr3196828wmp.158.1664468719680; 
 Thu, 29 Sep 2022 09:25:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7GXSxx1LBarzR7zq6U/e87GpBhC/rEY4V4sODPzyAV8maunzFx+24hSqCxT0BLh73br06cHw==
X-Received: by 2002:a05:600c:3205:b0:3b3:3813:ae3f with SMTP id
 r5-20020a05600c320500b003b33813ae3fmr3196805wmp.158.1664468719486; 
 Thu, 29 Sep 2022 09:25:19 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 t18-20020adfe452000000b00228cd9f6349sm7243877wrm.106.2022.09.29.09.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 09:25:18 -0700 (PDT)
Date: Thu, 29 Sep 2022 12:25:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929122444-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <CADgJSGHxPWXJjbakEeWnqF42A03yK7Dpw6U1SKNLhk+B248Ymg@mail.gmail.com>
 <20220929031419-mutt-send-email-mst@kernel.org>
 <20220929074606.yqzihpcc7cl442c5@sgarzare-redhat>
 <20220929034807-mutt-send-email-mst@kernel.org>
 <20220929090731.27cda58c@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220929090731.27cda58c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 davem@davemloft.net,
 Junichi Uekawa =?utf-8?B?KCDkuIrlt53ntJTkuIAp?= <uekawa@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Sep 29, 2022 at 09:07:31AM -0700, Jakub Kicinski wrote:
> On Thu, 29 Sep 2022 03:49:18 -0400 Michael S. Tsirkin wrote:
> > net tree would be preferable, my pull for this release is kind of ready ... kuba?
> 
> If we're talking about 6.1 - we can take it, no problem.

I think they want it in 6.0 as it fixes a crash.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
