Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C28C433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 03:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8781C81346;
	Tue, 18 Jan 2022 03:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJqifg6lsnf2; Tue, 18 Jan 2022 03:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F60381336;
	Tue, 18 Jan 2022 03:07:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D873EC0039;
	Tue, 18 Jan 2022 03:07:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A78AC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68DD240217
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GZMMcZrbuYoI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:07:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B65DE4020E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 03:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642475268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CQmErdVbSRr9mtW1+GyxSplP9tubMADIUUmh9Y+ayg=;
 b=RRs87RMkYCJl+mUZsopuZkbmBCLWShGxMcq3HiFwVU3BbaoXLrXpVHmWY09WUOXYY+W0cw
 wtsopjdvkYnRnzJRWHv2k54tW6JDDFT3kQPKc1GO1eUg7zc2hOUwMgAn0lYWClXTsDw8Nf
 /jYQBjHw0Z0fxtq8eBUPM87CY8UEvvg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-wkVMexYxOXCns_fH8t2jAg-1; Mon, 17 Jan 2022 22:07:47 -0500
X-MC-Unique: wkVMexYxOXCns_fH8t2jAg-1
Received: by mail-pf1-f200.google.com with SMTP id
 h196-20020a6283cd000000b004bed33745c9so7288865pfe.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 19:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9CQmErdVbSRr9mtW1+GyxSplP9tubMADIUUmh9Y+ayg=;
 b=HuIeckXHYTZmd+zR1k92LlEO8Rig4s2KtCuKsynu3P/cTwf7x/iZvhw7eZnhGexZZ6
 VDpWbTeImMm2q0qpoSTZrH4zJamLjn02qZtCnByxwt4UkFpct1t3RvciJhKkAxNe/WTY
 r6we2zqBwaF1z7Y19cCloV6ofCVXb2FUuS02W1t4Yp0D1HIUd2LHT8kMSl7fFZIC/a7L
 jf58psdCciqavdUPfQi0mUQFEL5QFbGd6hLJSuZ1Vo41K+egNyOGmBy7/2uL8RVIL96H
 cZmFse5N66oPkq6nWV/JWSbopTM8hhjM8/HV8kCVF1Xb0jzQj7UMSUUp1xYhIhTNFrzq
 5OFQ==
X-Gm-Message-State: AOAM532MZXvbwaUQpAxDsL4I2wAg+qJbNAetDr4Ov/KOSjtabyakF7ME
 wqIVZg0ZCAMwSIbxu5g0GdtRdWo8x8jn9XGxaHWVXlrt4sWQoOUlazHYGSmsHp1enxmmjQPIx6y
 QLAh/UQs/FV9HtwMZLjyVFztSMG0ahzPO7XJUL49g8w==
X-Received: by 2002:a63:9dc8:: with SMTP id
 i191mr21688285pgd.601.1642475266022; 
 Mon, 17 Jan 2022 19:07:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGn88ixeCz13kpjGb4SysE+JIuenybALI9UvqarO/71VSQGXiBlHPncz3hIYzN/LcoVqqxiA==
X-Received: by 2002:a63:9dc8:: with SMTP id
 i191mr21688268pgd.601.1642475265770; 
 Mon, 17 Jan 2022 19:07:45 -0800 (PST)
Received: from [10.72.13.83] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a19sm4801961pfh.198.2022.01.17.19.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jan 2022 19:07:45 -0800 (PST)
Message-ID: <1a26d7b3-1020-50c5-f0a3-ebc645cdcddf@redhat.com>
Date: Tue, 18 Jan 2022 11:07:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC 2/3] vdpa: support exposing the count of vqs to userspace
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com
References: <20220117092921.1573-1-longpeng2@huawei.com>
 <20220117092921.1573-3-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117092921.1573-3-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEvMTcg5LiL5Y2INToyOSwgTG9uZ3BlbmcoTWlrZSkg5YaZ6YGTOgo+IEZyb206
IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPgo+IC0gR0VUX1ZRU19DT1VOVDogdGhl
IGNvdW50IG9mIHZpcnRxdWV1ZXMgdGhhdCBleHBvc2VkCj4KPiBTaWduZWQtb2ZmLWJ5OiBMb25n
cGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEu
YyAgICAgICB8IDEzICsrKysrKysrKysrKysKPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdC5o
IHwgIDMgKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5k
ZXggMWVlYTE0YTRlYTU2Li5jMTA3NDI3OGZjNmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0zNjksNiArMzY5LDE2
IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZ19zaXplKHN0cnVjdCB2aG9zdF92
ZHBhICp2LCB1MzIgX191c2VyICphcmdwKQo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gK3N0
YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X3Zxc19jb3VudChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwg
dTMyIF9fdXNlciAqYXJncCkKPiArewo+ICsJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+
dmRwYTsKCgpXaGlsZSBhdCBpdCwgSSB0aGluayBpdCdzIGJldHRlciB0byBjaGFuZ2UgdmRwYS0+
bnZxcyB0byB1c2UgdTMyPwoKVGhhbmtzCgoKPiArCj4gKwlpZiAoY29weV90b191c2VyKGFyZ3As
ICZ2ZHBhLT5udnFzLCBzaXplb2YodmRwYS0+bnZxcykpKQo+ICsJCXJldHVybiAtRUZBVUxUOwo+
ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV92cmlu
Z19pb2N0bChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwKPiAgIAkJCQkg
ICB2b2lkIF9fdXNlciAqYXJncCkKPiAgIHsKPiBAQCAtNTA5LDYgKzUxOSw5IEBAIHN0YXRpYyBs
b25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ICAgCWNh
c2UgVkhPU1RfVkRQQV9HRVRfQ09ORklHX1NJWkU6Cj4gICAJCXIgPSB2aG9zdF92ZHBhX2dldF9j
b25maWdfc2l6ZSh2LCBhcmdwKTsKPiAgIAkJYnJlYWs7Cj4gKwljYXNlIFZIT1NUX1ZEUEFfR0VU
X1ZRU19DT1VOVDoKPiArCQlyID0gdmhvc3RfdmRwYV9nZXRfdnFzX2NvdW50KHYsIGFyZ3ApOwo+
ICsJCWJyZWFrOwo+ICAgCWRlZmF1bHQ6Cj4gICAJCXIgPSB2aG9zdF9kZXZfaW9jdGwoJnYtPnZk
ZXYsIGNtZCwgYXJncCk7Cj4gICAJCWlmIChyID09IC1FTk9JT0NUTENNRCkKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3Qu
aAo+IGluZGV4IGJjNzRlOTVhMjczYS4uNWQ5OWU3YzI0MmEyIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvdWFwaS9saW51eC92aG9zdC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgK
PiBAQCAtMTU0LDQgKzE1NCw3IEBACj4gICAvKiBHZXQgdGhlIGNvbmZpZyBzaXplICovCj4gICAj
ZGVmaW5lIFZIT1NUX1ZEUEFfR0VUX0NPTkZJR19TSVpFCV9JT1IoVkhPU1RfVklSVElPLCAweDc5
LCBfX3UzMikKPiAgIAo+ICsvKiBHZXQgdGhlIGNvdW50IG9mIGFsbCB2aXJ0cXVldWVzICovCj4g
KyNkZWZpbmUgVkhPU1RfVkRQQV9HRVRfVlFTX0NPVU5UCV9JT1IoVkhPU1RfVklSVElPLCAweDgw
LCBfX3UzMikKPiArCj4gICAjZW5kaWYKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
