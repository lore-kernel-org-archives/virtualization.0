Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA0C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 15:32:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5240361A09
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 15:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5240361A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 197A940121;
	Wed, 24 Mar 2021 15:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G7vkrObw0MnM; Wed, 24 Mar 2021 15:32:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E03F40134;
	Wed, 24 Mar 2021 15:32:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D859C000E;
	Wed, 24 Mar 2021 15:32:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D00EC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37FDB60AFD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ity_5XmZxomS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:31:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AAA1606FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616599915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8kn0B/D+pZ7zXWK7MZP4nFqRkdMczx4RoGNwPla3Io=;
 b=HeNCHANGBahiH1FMvKxfPihAR1tinA/DjElc3oQc3OPj3Xn25ZQAgOSs8yoH4EVWEiDsbM
 Fd5Xdm3HwYplnsIwnbuLOYo20FGFNL8gkMot1ZWyiiwdDtyGCeRDn2wzdn+qlujK/UeNGS
 iLxUikKwtraYwQEkd7K5LXLofFppjq0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-QVjUauRvPnuuvR6nz9oF5A-1; Wed, 24 Mar 2021 11:31:52 -0400
X-MC-Unique: QVjUauRvPnuuvR6nz9oF5A-1
Received: by mail-oo1-f70.google.com with SMTP id a1so1446193oop.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 08:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N8kn0B/D+pZ7zXWK7MZP4nFqRkdMczx4RoGNwPla3Io=;
 b=F+aaBe9AzLJxSSCC8Qrw5TRNgKJ1YSuT5K1URIa9FlXPHlWjlRTUAPhqdOxSzubls+
 j9THpT7RLQEpuPb2FXFWfscP1ibKr1KCVXH/R3zdEoNiiOxLSX5eVJ7yemFU8aF289wj
 kUiChLH+6v6o7GQjZyIMjsB+QlvvX0QzB+gi32emEPra9S1L/zh+3l2FxYQLbkBGgb/j
 qxtYya7GGFQQs3eBw38EXBvNfGWWXhmH8vy5pPYku7zOMq9ln6hWQbEkDoqmQ3ABLh1f
 zwTuAd2eMoZr7+lsje761TgSOrZD44axocDIg42qEVFStqrqoC8uNBZ7R/ekBEB2cGWz
 n6Pw==
X-Gm-Message-State: AOAM532vmpil17RM46DZqndKJ9wZ7djoF6Sbvmfv1Kscjn4Q2yVukmFE
 BAFOvvC4gqaG2uT3jjeEyZ+NS2pmP6StrUS5cWVlLRGCzOVLOOmnvYIKkLfBOruoF1osKiCEGvl
 LS7NcplIMeAtGAyBfcCsYP2AZCIWVxsoDeCs7ezwEhg==
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3703296otk.178.1616599911303; 
 Wed, 24 Mar 2021 08:31:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHcAMbU8Mdirt+zw6MDCjjmFcHf0Mz7Xosca571WY68Qps4nDv94Vb8jBdRKynlG/lxwuTWw==
X-Received: by 2002:a9d:6390:: with SMTP id w16mr3703287otk.178.1616599911158; 
 Wed, 24 Mar 2021 08:31:51 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 k24sm457636oic.51.2021.03.24.08.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Mar 2021 08:31:50 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To: Miklos Szeredi <miklos@szeredi.hu>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
 <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
 <CAJfpeguzdPV13LhXFL0U_bfKcpOHQCvg2wfxF6ryksp==tjVWA@mail.gmail.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <9879ca3f-548a-25d4-78f0-f307e1189231@redhat.com>
Date: Wed, 24 Mar 2021 10:31:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJfpeguzdPV13LhXFL0U_bfKcpOHQCvg2wfxF6ryksp==tjVWA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
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

On 3/24/21 10:30 AM, Miklos Szeredi wrote:
> On Wed, Mar 24, 2021 at 4:09 PM Connor Kuehl <ckuehl@redhat.com> wrote:
>>
>> On 3/18/21 10:17 AM, Miklos Szeredi wrote:
>>> I removed the conditional compilation and renamed the limit.  Also made
>>> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
>>
>> Hi Miklos,
>>
>> Has this patch been queued?
> 
> It's in my internal patch queue at the moment.   Will push to
> fuse.git#for-next in a couple of days.

Cool! Thank you :-)

Connor

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
