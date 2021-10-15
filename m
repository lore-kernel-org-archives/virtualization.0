Return-Path: <SRS0=T5WV=PD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C025C433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:24:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E3F6115C
	for <virtualization@archiver.kernel.org>; Fri, 15 Oct 2021 08:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7E3F6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DE6440281;
	Fri, 15 Oct 2021 08:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gn2hPuESB7iV; Fri, 15 Oct 2021 08:24:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E24A40001;
	Fri, 15 Oct 2021 08:24:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E796AC000F;
	Fri, 15 Oct 2021 08:24:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFF07C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C39260789
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zWEY5IpwfRYt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:24:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF488605BD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634286251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6oRndYVyUJ0nIQPFPw3PV1+lgajKjDZ9UQHCW0KsQA=;
 b=OReA2bgi/8OjyMmb9LI9KoeFJlV0+RsdpJ3B4oYJEwQpOYOSzQhgvbaHVJOdQ1lHXwrT6s
 frZ5n8TscB8qvqxz9COIIuDYMF/+Dw59n0ifvFTjaD9evxIwwVLHx2Jw3rTgJNnhy+db5s
 +fwtQbHeVVtGOnc+cYCGqgFWpIHbbWQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-EQSe2tXRPnepZIpJYn6c_A-1; Fri, 15 Oct 2021 04:24:09 -0400
X-MC-Unique: EQSe2tXRPnepZIpJYn6c_A-1
Received: by mail-pg1-f199.google.com with SMTP id
 a16-20020a63d410000000b00268ebc7f4faso4667719pgh.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 01:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=E6oRndYVyUJ0nIQPFPw3PV1+lgajKjDZ9UQHCW0KsQA=;
 b=1KD1bMX7i/0gYLTT8SN4v9qBstnYOzWx1qqqTn+kAh4OS7SiYeU+z53X7vJ1mkJtCL
 H2bs5Fj+6LK8HgFq16eGMpNkI+KWf0KLdVf0ezHU/kg1/sM/C5qL+H5K2oF1cKfbXtwM
 Qg96i5mfsaihrxdXwa1QeMcyxsWj1VQDSVgnzKd/YuDRGskZCcXiAEYHBE7ZFoozMny4
 0lUhUmsdyFzJ4siwEw4YIxuAQDJl2/dJN+UOoL4vHvxpVb9/xsP2LNX6Dz0tVldBCndx
 czqgzmmBkUDx3Svj2ua8b2lKfvghwWHPhvkPB7oHwGK+iL8AutPXZWHmgGAgYHC1kT44
 TpgA==
X-Gm-Message-State: AOAM530PxdSAg3VJCrkdkKB98X2dkLmVg/vIBZ1qmNvjfgFtcDeULrow
 vuRLwS8OXbkcTbtEs1DW3v+og/1f2YPh3H5FNyLX23GMnckVozfsL5MhYRTQRN2YO8slmwSaRyF
 k6M7CmWBjOwbhE6miIYVuZfCdWVM77QNpzaEHpp1+7A==
X-Received: by 2002:a05:6a00:a1e:b0:44c:7602:e1ee with SMTP id
 p30-20020a056a000a1e00b0044c7602e1eemr10474796pfh.80.1634286248406; 
 Fri, 15 Oct 2021 01:24:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/nA+3l2rR57+xSkS94d2Z5z+fm5u6cjavYeX5oNBR8m5wROIDtX5M3W5LEKVAenv0EB+yhg==
X-Received: by 2002:a05:6a00:a1e:b0:44c:7602:e1ee with SMTP id
 p30-20020a056a000a1e00b0044c7602e1eemr10474774pfh.80.1634286248166; 
 Fri, 15 Oct 2021 01:24:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w18sm4536129pfj.170.2021.10.15.01.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Oct 2021 01:24:07 -0700 (PDT)
Subject: Re: [PATCH v5 5/8] vdpa: min vq num of vdpa device cannot be greater
 than max vq num
To: Wu Zongyong <wuzongyong@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <5b75093fc4a866a4502485ec208ca0e55440bdf7.1634281805.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b3566d6-0c03-7861-ff89-e7a10c689833@redhat.com>
Date: Fri, 15 Oct 2021 16:24:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5b75093fc4a866a4502485ec208ca0e55440bdf7.1634281805.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: wei.yang1@linux.alibaba.com
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

CtTaIDIwMjEvMTAvMTUgz8LO5zM6MTQsIFd1IFpvbmd5b25nINC0tcA6Cj4gSnVzdCBmYWlsZWQg
dG8gcHJvYmUgdGhlIHZkcGEgZGV2aWNlIGlmIHRoZSBtaW4gdmlydHF1ZXVlIG51bSByZXR1cm5l
ZAo+IGJ5IGdldF92cV9udW1fbWluIGlzIGdyZWF0ZXIgdGhhbiB0aGUgbWF4IHZpcnRxdWV1ZSBu
dW0gcmV0dXJuZWQgYnkKPiBnZXRfdnFfbnVtX21heC4KPgo+IFNpZ25lZC1vZmYtYnk6IFd1IFpv
bmd5b25nIDx3dXpvbmd5b25nQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92
ZHBhL3ZkcGEuYyB8IDggKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3Zk
cGEuYwo+IGluZGV4IDFkYzEyMWEwN2E5My4uZmQwMTRlY2VjNzExIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gQEAgLTI2LDgg
KzI2LDE2IEBAIHN0YXRpYyBpbnQgdmRwYV9kZXZfcHJvYmUoc3RydWN0IGRldmljZSAqZCkKPiAg
IHsKPiAgIAlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYgPSBkZXZfdG9fdmRwYShkKTsKPiAgIAlz
dHJ1Y3QgdmRwYV9kcml2ZXIgKmRydiA9IGRydl90b192ZHBhKHZkZXYtPmRldi5kcml2ZXIpOwo+
ICsJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+ICsJ
dTMyIG1heF9udW0sIG1pbl9udW0gPSAwOwoKCkFzIGRpc2N1c3NlZCBpbiBwcmV2aW91cyB2ZXJz
aW9uLCAxIHNlZW1zIGJldHRlcj8KClRoYW5rcwoKCj4gICAJaW50IHJldCA9IDA7Cj4gICAKPiAr
CW1heF9udW0gPSBvcHMtPmdldF92cV9udW1fbWF4KHZkZXYpOwo+ICsJaWYgKG9wcy0+Z2V0X3Zx
X251bV9taW4pCj4gKwkJbWluX251bSA9IG9wcy0+Z2V0X3ZxX251bV9taW4odmRldik7Cj4gKwlp
ZiAobWF4X251bSA8IG1pbl9udW0pCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICAgCWlmIChk
cnYgJiYgZHJ2LT5wcm9iZSkKPiAgIAkJcmV0ID0gZHJ2LT5wcm9iZSh2ZGV2KTsKPiAgIAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
