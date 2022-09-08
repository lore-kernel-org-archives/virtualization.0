Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4B4ECAAD5
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 08:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B3AB41A55;
	Thu,  8 Sep 2022 08:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B3AB41A55
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBOOVvfB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TFLw5tQzcHDj; Thu,  8 Sep 2022 08:30:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A6E64192C;
	Thu,  8 Sep 2022 08:30:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A6E64192C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF168C0032;
	Thu,  8 Sep 2022 08:30:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE74AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 08:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F2A683F06
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 08:30:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F2A683F06
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GBOOVvfB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HKrWA1FUcXca
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 08:30:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6001E83E2E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6001E83E2E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662625814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=opHRLepQrfUm0+zOxWDE1IyemjcpUteMhEnVxI/dcAo=;
 b=GBOOVvfB7N910BwqnZyjc6ssrS+1olqzqN0DYqvtgWPsfKcGfZWR2lKo8Zuy+eJaeHRExR
 dh5mMFYinuRLVu+x5+E9TPTFe2jHImIkc+6wunX71lTOBFPkfuV3vd77Z7x9u2GEz332bf
 fO8xtxtrI/VW670uhKBfZafrJIKJDZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-AWWjrWNnOGyR1YKl51tqiA-1; Thu, 08 Sep 2022 04:30:13 -0400
X-MC-Unique: AWWjrWNnOGyR1YKl51tqiA-1
Received: by mail-wm1-f71.google.com with SMTP id
 ay21-20020a05600c1e1500b003a6271a9718so8228385wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Sep 2022 01:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=opHRLepQrfUm0+zOxWDE1IyemjcpUteMhEnVxI/dcAo=;
 b=x5nJzt6YyaYTEObh8CqYgqcDVLg5eTNLwLxCng7BJITi2qXJIX4iqo71MhS5vWt+os
 Ny/iXk+qUmyisB1fAhQldP+DLr+zs0ct02bh/5/dVOjgs/HTtuRNgVxLp8rXFnJ7yST2
 Jw7ptJ0fZKXQVHxWMw3UEszux03FLAHV563SAw/eGYXLc69KmS4O0Jk/DbwO2Z4Ko0Ck
 DWWT5aKbkLwFU/cIJlhi/6S7d9lZFjVhB6gFn6ZtEPaNByPeTej8w5E3Vq1AhZgn1Jys
 TuV7zKARFEOwAOLrjKbJ5kIUa/03b7GStXBOiygbMT+KigOgzcxHcSDwcz8SmtMeDj4R
 Ee9A==
X-Gm-Message-State: ACgBeo3J8PQlhUBh0hbfXQOyZyosfQ5GXfsQPgHL0U3TigEhhXUTiqGl
 31i+FEteaYzR1zayTraOk6c7mHVbZpYZJbJBzEwnNEtlxH636pIPF5zqZ8PEpbLYZ7DNinGtzYV
 UqaBig2gEvVGY76BJdE1mm0MWrhEHz7UWQTyjQWqqCw==
X-Received: by 2002:a7b:cb88:0:b0:3a5:ea1c:c541 with SMTP id
 m8-20020a7bcb88000000b003a5ea1cc541mr1496487wmi.114.1662625812029; 
 Thu, 08 Sep 2022 01:30:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SwMIElGNbgYD/YsZ20ljCMhRe+R4cc7VaydN9lljIdfCNE3iz4v1UCtSVpJzo90tDWyI+9g==
X-Received: by 2002:a7b:cb88:0:b0:3a5:ea1c:c541 with SMTP id
 m8-20020a7bcb88000000b003a5ea1cc541mr1496455wmi.114.1662625811803; 
 Thu, 08 Sep 2022 01:30:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 a22-20020a05600c2d5600b003a541d893desm1731720wmg.38.2022.09.08.01.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Sep 2022 01:30:11 -0700 (PDT)
Date: Thu, 8 Sep 2022 10:30:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220908083003.qsivb5j2f6pn4f2d@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <YxdKiUzlfpHs3h3q@fedora> <Yv5PFz1YrSk8jxzY@bullseye>
MIME-Version: 1.0
In-Reply-To: <Yv5PFz1YrSk8jxzY@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
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

On Thu, Aug 18, 2022 at 02:39:32PM +0000, Bobby Eshleman wrote:
>On Tue, Sep 06, 2022 at 09:26:33AM -0400, Stefan Hajnoczi wrote:
>> Hi Bobby,
>> If you are attending Linux Foundation conferences in Dublin, Ireland
>> next week (Linux Plumbers Conference, Open Source Summit Europe, KVM
>> Forum, ContainerCon Europe, CloudOpen Europe, etc) then you could meet
>> Stefano Garzarella and others to discuss this patch series.
>>
>> Using netdev and sk_buff is a big change to vsock. Discussing your
>> requirements and the future direction of vsock in person could help.
>>
>> If you won't be in Dublin, don't worry. You can schedule a video call if
>> you feel it would be helpful to discuss these topics.
>>
>> Stefan
>
>Hey Stefan,
>
>That sounds like a great idea!

Yep, I agree!

>I was unable to make the Dublin trip work
>so I think a video call would be best, of course if okay with everyone.

It will work for me, but I'll be a bit busy in the next 2 weeks:

 From Sep 12 to Sep 14 I'll be at KVM Forum, so it may be difficult to 
arrange, but we can try.

Sep 15 I'm not available.
Sep 16 I'm traveling, but early in my morning, so I should be available.

Form Sep 10 to Sep 23 I'll be mostly off, but I can try to find some 
slots if needed.

 From Sep 26 I'm back and fully available.

Let's see if others are available and try to find a slot :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
