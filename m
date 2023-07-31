Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3351C001DC
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 06:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87A4A81430;
	Mon, 31 Jul 2023 06:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87A4A81430
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OAm5+NZj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lRGygJAttphK; Mon, 31 Jul 2023 06:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 350FA81418;
	Mon, 31 Jul 2023 06:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 350FA81418
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0729CC0071;
	Mon, 31 Jul 2023 06:24:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69BD9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4343481413
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4343481413
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kim32pDQSbyi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 878F78140E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 06:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 878F78140E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690784686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
 b=OAm5+NZjUGiGBg0/3fKniS5wqzsUKgWDzn/nqZzNxf8zY8sbwtqT13leSkyOBDHNlTbGBU
 sCesSouIIBx7O8KxFvuh0aEj9GZ7+tCTL7kIRjsEWIUFEGv8gI62rooJIrCq42jyjA1UFM
 85sbsotLqHwPZHWsyWcKvNNyz0FgB6I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-5RVSqmVhO_KHOw653BnEkg-1; Mon, 31 Jul 2023 02:24:45 -0400
X-MC-Unique: 5RVSqmVhO_KHOw653BnEkg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-686b997cdeeso4365693b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jul 2023 23:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690784684; x=1691389484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kCGfGQpNevEyxQJOi2EpZ/60FOEBzdh7x63Yvc5DA1k=;
 b=f/BQi4ip76ZEndBlgY2rgK8jlbCHOakLkkffU3u/OtRAn+5j4bayQCiCa52ROpaeYi
 zCQfHAq0uio3STcFbqsBebUlhMO49oB7bv3I/HIFBDyf58vdeP8nF1MHPEHoayyEaS29
 8/wZuRWFU/PnjMmm/Tr/ZewoACaH8Zi8aT9b54C78FHCLZxnBfeH0upOwABOC7PDVHIX
 8uCpyuPHHlsnS5GO4gYkb7uPcxzsfwAK1MPi0jtNWLuihcks0IoraJjw+Bv7OxcbA/Qj
 J+d+7GOq+hhMwSM1d9iZHd+vYGBxWYahjJ6Y+q6NVLli/MDf0KTvs4QzPuJTXqLBdLs/
 vCfQ==
X-Gm-Message-State: ABy/qLYt3TJ9F1lC1Xu3Ykacjsgx/zI/HgRpvirnh2dh+pL/GcArTHJf
 Pnuq9G6s9MnP3kVIk0MT1/CLtuq74fVGCQe7wF7pqvlC2QLG562PyS+EnU+xr7ZCK9Q7SYcVaMZ
 jn4Lc5O7k4TrICO26ij9EPs5OccWIpjf9evaaRHKRCw==
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id
 y2-20020a056a00190200b0068256343df1mr10454911pfi.10.1690784683943; 
 Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7hRSrqGoCxMOCQEWdDDgEVMWsydvLGR7y6jP66LSsLJaoK1Qrd924k7OelmyerHuJSUgtvg==
X-Received: by 2002:a05:6a00:1902:b0:682:5634:3df1 with SMTP id
 y2-20020a056a00190200b0068256343df1mr10454894pfi.10.1690784683710; 
 Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 e7-20020aa78247000000b0066f37665a63sm1200909pfn.73.2023.07.30.23.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 23:24:43 -0700 (PDT)
Message-ID: <bd76081f-e6d3-ee60-a2de-cacd3e40563d@redhat.com>
Date: Mon, 31 Jul 2023 14:24:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 3/3] virtio_net: enable per queue interrupt
 coalesce feature
To: Gavin Li <gavinl@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-4-gavinl@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230725130709.58207-4-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gavi@nvidia.com,
 virtualization@lists.linux-foundation.org, Heng Qi <hengqi@linux.alibaba.com>,
 bpf@vger.kernel.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzcvMjUgMjE6MDcsIEdhdmluIExpIOWGmemBkzoKPiBFbmFibGUgcGVyIHF1ZXVl
IGludGVycnVwdCBjb2FsZXNjZSBmZWF0dXJlIGJpdCBpbiBkcml2ZXIgYW5kIHZhbGlkYXRlIGl0
cwo+IGRlcGVuZGVuY3kgd2l0aCBjb250cm9sIHF1ZXVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogR2F2
aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+IFJldmlld2VkLWJ5OiBEcmFnb3MgVGF0dWxlYSA8
ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amlyaUBudmlk
aWEuY29tPgo+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+
IFJldmlld2VkLWJ5OiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+CgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
