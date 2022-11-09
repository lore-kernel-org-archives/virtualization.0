Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F88C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 08:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E3624019D;
	Wed,  9 Nov 2022 08:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E3624019D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKZJX8GA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mn-nuhRSNFVK; Wed,  9 Nov 2022 08:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3191340AE2;
	Wed,  9 Nov 2022 08:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3191340AE2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05B89C0033;
	Wed,  9 Nov 2022 08:18:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBC0AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E16E40AE2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E16E40AE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-RwcexKGTY1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD8F44019D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD8F44019D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 08:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667981913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgGprYoeTN22cTQDR5YOz3sASLNpnLaaRp5I0puxy0k=;
 b=FKZJX8GAVQJ44/fOSi3H55Yn3h+lCPyDSoXKYbeBvu4AQY2BBTpgZQDwFWzy8B9HdXYgUA
 r8m66AZscOZBp4DfKAb3rb9U7XGDWQyC54vz6vMXKDQeYxKgOLvnFL6rlfP8sYuO+P3n6q
 039JsLBu5lccY1Zxb2+cVT4og5cXhEk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-lMetNaTFPcW6ck49x51l_w-1; Wed, 09 Nov 2022 03:18:32 -0500
X-MC-Unique: lMetNaTFPcW6ck49x51l_w-1
Received: by mail-qv1-f69.google.com with SMTP id
 c6-20020ad44306000000b004bb8352cb4cso11336864qvs.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 00:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgGprYoeTN22cTQDR5YOz3sASLNpnLaaRp5I0puxy0k=;
 b=ZId8XS7dd8Xi82BBYInZ0LcqIjT2eIzYDItd5arhe1IYEP5m1f2QsFtT7Kynv++tjN
 igO7GxX5UCSBopZs+YGnT1s0p/PLdbXENJicryLGmsFPgwAh805llK+4IqSdi9Ce+uAH
 oGb84w8bf/8PQIQzPcUnGP5XToJ2Tv+NLnnVx1hFg3IaH1GDs0prG/ccyWlAewob/XQS
 ZcFb6Ytd1gtt1p7YjXB2KkAC5nao1fMDDt/TRsb4O1HEOzwYXfN66qbbZYH39ZrnADhf
 ah/z36G/mfpR7vJNnGfn917niS+KXAXkis297r7z2SIcW47u7kYEFv5GBA8kP8VoCXVb
 KSLQ==
X-Gm-Message-State: ACrzQf3TpPYUN6zJrjO+RTvWnkOcUXaCGZuMcPQJmHwPYXKq9yDVo23B
 qCyP+eNWwmC2qX4afKrUcz5Ddg5LCgv42DIPFab1yGFOGFBERd/pNra1ZE7CSvb6+6XPWbmKiTy
 Q9uOMyxt7Jq5Imkr28N6tjzeN4LFIEAC2JtFDE7VBAw==
X-Received: by 2002:a0c:de07:0:b0:4bc:187a:7085 with SMTP id
 t7-20020a0cde07000000b004bc187a7085mr38386057qvk.13.1667981912273; 
 Wed, 09 Nov 2022 00:18:32 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5nr5OeV6fr2CjoyWBfrNdvGZsceXntb36rsvEakUXbxiiIfozncmPJPob44jTHHjm5hBECkg==
X-Received: by 2002:a0c:de07:0:b0:4bc:187a:7085 with SMTP id
 t7-20020a0cde07000000b004bc187a7085mr38386045qvk.13.1667981912018; 
 Wed, 09 Nov 2022 00:18:32 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bi14-20020a05620a318e00b006b929a56a2bsm10711570qkb.3.2022.11.09.00.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 00:18:31 -0800 (PST)
Date: Wed, 9 Nov 2022 09:18:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vhost: fix range used in translate_desc()
Message-ID: <20221109081823.tg5roitl26opqe6k@sgarzare-redhat>
References: <20221108103437.105327-1-sgarzare@redhat.com>
 <20221108103437.105327-3-sgarzare@redhat.com>
 <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Nov 09, 2022 at 11:28:41AM +0800, Jason Wang wrote:
>On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> vhost_iotlb_itree_first() requires `start` and `last` parameters
>> to search for a mapping that overlaps the range.
>>
>> In translate_desc() we cyclically call vhost_iotlb_itree_first(),
>> incrementing `addr` by the amount already translated, so rightly
>> we move the `start` parameter passed to vhost_iotlb_itree_first(),
>> but we should hold the `last` parameter constant.
>>
>> Let's fix it by saving the `last` parameter value before incrementing
>> `addr` in the loop.
>>
>> Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> I'm not sure about the fixes tag. On the one I used this patch should
>> apply cleanly, but looking at the latest stable (4.9), maybe we should
>> use
>>
>> Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")
>
>I think this should be the right commit to fix.

Yeah, @Michael should I send a v2 with that tag?

>
>Other than this
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>

Thanks for the review,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
