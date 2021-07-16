Return-Path: <SRS0=Pjyk=MI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30112C636CA
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 12:53:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C426C613F3
	for <virtualization@archiver.kernel.org>; Fri, 16 Jul 2021 12:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C426C613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EE7C4053F;
	Fri, 16 Jul 2021 12:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZhImOKwz-tOE; Fri, 16 Jul 2021 12:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A19CC40536;
	Fri, 16 Jul 2021 12:53:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7362AC0010;
	Fri, 16 Jul 2021 12:53:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 473C6C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 12:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 202C440536
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 12:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gFKBL0qEH1zX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 12:53:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC5BE404FD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626440026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPTvg/IdQ5a8q1Cw2aONE7wqYd41qCqeyO8lI1tAOio=;
 b=AQUH9sPJRUoWQjF51dsTGTiBZyVn+OQ14MRN+TUPKFoXFaAN4eeGAjT2ygyPnGOwiSWX0J
 ASznKgIpUF6hbb4EWWCYrtkVkfbnSsEDMGlfxjMKTNyd+vIfmxS0zgPfKh4rUG+cREGnJy
 9IYiFxe70WHi8/T5c/TmydgDya2MOqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-Di3LZ1KNOMmArIkSqqw3eA-1; Fri, 16 Jul 2021 08:53:45 -0400
X-MC-Unique: Di3LZ1KNOMmArIkSqqw3eA-1
Received: by mail-wm1-f71.google.com with SMTP id
 o21-20020a05600c4fd5b029023448cbd285so2488203wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 05:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZPTvg/IdQ5a8q1Cw2aONE7wqYd41qCqeyO8lI1tAOio=;
 b=N7nT0XhIxuemuqZd7jkq0VxEk3tJg6vyrlplR3lASQu4Df8WmkhAZkDQ54l9LZQM1N
 SBqTMpf+V1fGPebVKMVDl3/+lBArzGW5JtXEY1Ml8GN2CyTEx2QG6+X0kB4kfWNpXYnR
 MAIL7sCk54QXue9pJMkOroPlQqAo3SH+zCdLlrBBgEaLdVHeqJbliNSBoCqyRi5MkKzz
 mP0KuYfow5GRiKvVFHiKLYTxV1R+etLOaxR4EzqVJrkJ6GFn20cqoIS3+jhgEaq172d3
 NdGh2cdAf99mf4CbdO9FlkwojdgQ+KzpF0H70YfkKcKm/eBGPmKcJiZ4zpoQWvYkzWCM
 oQpQ==
X-Gm-Message-State: AOAM5334UnAe63Q3E0A812G6huiEJiNGbWOU4ZJD1iWwniZCer0wxJEV
 oS7L9kaKQxknJW6U1zN9YTtdn10rPF20ejVo2PTGRR6d2/QqriugZ51Zpx/4/6h4qKIITPcQtDI
 M4D671HsfwBr8xSHK3xHY2y/mtRh7NIaymZxvoviOYg==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr12290462wrq.269.1626440023951; 
 Fri, 16 Jul 2021 05:53:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6BW5q2g15VlrWMWnSGVnKtR76dMaQz5P9c1z3WEUts29V8IRrZ432wuNnnmC9NNxuPsb/EQ==
X-Received: by 2002:a5d:428d:: with SMTP id k13mr12290445wrq.269.1626440023790; 
 Fri, 16 Jul 2021 05:53:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
 by smtp.gmail.com with ESMTPSA id
 z16sm9867946wrh.58.2021.07.16.05.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jul 2021 05:53:42 -0700 (PDT)
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To: tianxianting <xianting.tian@linux.alibaba.com>,
 Xianting Tian <xianting_tian@126.com>, mst@redhat.com, jasowang@redhat.com
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
Date: Fri, 16 Jul 2021 14:53:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTYuMDcuMjEgMTQ6NDYsIHRpYW54aWFudGluZyB3cm90ZToKPiBEbyB5b3UgaW50ZXJlc3Qg
aW4gdGhpcyBwYXRjaD8ganVzdCBsaXR0bGUgaW1wcm92bWVudDopCgpJIGFtLCBlc3BlY2lhbGx5
IHdoZW4gSSdtIGNjJ2VkIGFuZCBhd2FyZSBvZiBpdCA7KQoKUmV2aWV3ZWQtYnk6IERhdmlkIEhp
bGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgoKT25lIG5pdCBiZWxvdwoKPiAKPiDU2iAyMDIx
LzcvMTMgz8LO5zExOjM4LCBYaWFudGluZyBUaWFuINC0tcA6Cj4+IEZyb206IFhpYW50aW5nIFRp
YW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+Cj4+Cj4+IFVzZSB0aGUgaGVscGVy
IHZpcnRpb19maW5kX3ZxcygpLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4
aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPgo+PiAtLS0KPj4gICAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX2JhbGxvb24uYyB8IDQgKystLQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX2JhbGxvb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMKPj4g
aW5kZXggNTEwZTkzMS4uMThlMGJmMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX2JhbGxvb24uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fYmFsbG9vbi5jCj4+
IEBAIC01MzEsOCArNTMxLDggQEAgc3RhdGljIGludCBpbml0X3ZxcyhzdHJ1Y3QgdmlydGlvX2Jh
bGxvb24gKnZiKQo+PiAgICAJCWNhbGxiYWNrc1tWSVJUSU9fQkFMTE9PTl9WUV9SRVBPUlRJTkdd
ID0gYmFsbG9vbl9hY2s7Cj4+ICAgIAl9Cj4+ICAgIAo+PiAtCWVyciA9IHZiLT52ZGV2LT5jb25m
aWctPmZpbmRfdnFzKHZiLT52ZGV2LCBWSVJUSU9fQkFMTE9PTl9WUV9NQVgsCj4+IC0JCQkJCSB2
cXMsIGNhbGxiYWNrcywgbmFtZXMsIE5VTEwsIE5VTEwpOwo+PiArCWVyciA9IHZpcnRpb19maW5k
X3Zxcyh2Yi0+dmRldiwgVklSVElPX0JBTExPT05fVlFfTUFYLCB2cXMsCj4+ICsJCQkJY2FsbGJh
Y2tzLCBuYW1lcywgTlVMTCk7CgkJCQleCndlIHRlbmQgdG8gaW5kZW50IHRoaXMgc3VjaCB0aGF0
IGl0IGlzIGFsaWduZWQgd2l0aCB0aGUgbGluZSBhYm92ZSAoc2VlIAp0aGUgb2xkIGNvZGUpLCB1
bmxlc3MgdGhlIGNvZGUgYmVjb21lcyB1bnJlYWRhYmxlCgoKLS0gClRoYW5rcywKCkRhdmlkIC8g
ZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
