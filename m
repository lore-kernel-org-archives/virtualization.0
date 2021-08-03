Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD641C432BE
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 08:09:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDD160F92
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 08:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EDD160F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4180B40185;
	Tue,  3 Aug 2021 08:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVQYUxlKcFv7; Tue,  3 Aug 2021 08:09:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E983400E6;
	Tue,  3 Aug 2021 08:09:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 537DDC0010;
	Tue,  3 Aug 2021 08:09:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAD07C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8A4E4016B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QOCPK7cas9US
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:09:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4CD6400E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627978178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/r6zvhdFIL6U9mMpelz1ZP/rGx2CiqZiJxW3s2xgLY=;
 b=LOFwDr1VQuRJSPoCcXU7iZPYXL1N6dXCiShUeot75AojJ2dC082rcTa0pg4nbiIZnhZiGu
 vndbAIxYvVnaW2xkCSaa7QdgXtCs4WTRILHqt4boUXY4Ij4UhcLWbG4ty8TesmV5roE+DE
 IfFlnu8x0Bj9bnXUxKzUOMBjBYQeUio=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-UQeMfIhEN7y9xempAmJcpg-1; Tue, 03 Aug 2021 04:09:37 -0400
X-MC-Unique: UQeMfIhEN7y9xempAmJcpg-1
Received: by mail-pl1-f198.google.com with SMTP id
 u2-20020a170902e5c2b029012cb0f6543aso5661314plf.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 01:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=d/r6zvhdFIL6U9mMpelz1ZP/rGx2CiqZiJxW3s2xgLY=;
 b=rBlSQn3LlAmGa5BTPHVtcOCg5qo5zM2O57bvn3/K0FgrFngfz8yRGzcNzLvmYBTVmE
 BwwtMwJvY9EolhktUDAziJozU3EIWEQyROOAiDgTjdHY9WAY1gzvQg3Pe/IKaQtUA3+W
 rUZrgUfP9ax9nOsdz/ONeX8OTZYR4ESfkIsr3eQMNCzpAzpGOWtNEirF7XA/YarZdwRM
 uoyGM5AInhIbMGsi/mtI1c1nhtM8gR+cWCzQCKRwc30Lvwdea6bJnxoQwshV684r2MOh
 6MNo4ZOXlHEmnWh02Pau1Ycs0+Fk2QSHwrtzxcxvltZvWBYp0zY47E1p+yMBxYDdTV1a
 9MQA==
X-Gm-Message-State: AOAM530W19HaANtSSx4rGa3m7U0x5w/fhbb70lvqnX7HhvJKCs+oGw0i
 Bj+jjFqH4VF1Fv5V43Qswdl1GE/68+Kj6aqbV1Wbf1ZgNFAEZZz5UVFCeamu3+eUR3GF+Z/VYW7
 FbfXl6x5bniCGBCUhO/qv8wBYSY9UucNJVNNgtm7ETA==
X-Received: by 2002:aa7:8e51:0:b029:332:920f:1430 with SMTP id
 d17-20020aa78e510000b0290332920f1430mr21300583pfr.1.1627978176642; 
 Tue, 03 Aug 2021 01:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7eB41SimgYU81rcElaZj+nONhqTjmXUgDQCX8JCwgqwPPspHzUgCCQ+CXUVfMnpfJwz3SQw==
X-Received: by 2002:aa7:8e51:0:b029:332:920f:1430 with SMTP id
 d17-20020aa78e510000b0290332920f1430mr21300550pfr.1.1627978176387; 
 Tue, 03 Aug 2021 01:09:36 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j10sm15534492pfd.200.2021.08.03.01.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Aug 2021 01:09:35 -0700 (PDT)
Subject: Re: [PATCH v10 10/17] virtio: Handle device reset failure in
 register_virtio_device()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 hch@infradead.org, christian.brauner@canonical.com, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com, joro@8bytes.org, gregkh@linuxfoundation.org,
 zhe.he@windriver.com, xiaodong.liu@intel.com, joe@perches.com
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-11-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6bb6c689-e6dd-cfa2-094b-a0ca4258aded@redhat.com>
Date: Tue, 3 Aug 2021 16:09:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-11-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

CtTaIDIwMjEvNy8yOSDPws7nMzozNCwgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSBkZXZpY2UgcmVz
ZXQgbWF5IGZhaWwgaW4gdmlydGlvLXZkcGEgY2FzZSBub3csIHNvIGFkZCBjaGVja3MgdG8KPiBp
dHMgcmV0dXJuIHZhbHVlIGFuZCBmYWlsIHRoZSByZWdpc3Rlcl92aXJ0aW9fZGV2aWNlKCkuCgoK
U28gdGhlIHJlc2V0KCkgd291bGQgYmUgY2FsbGVkIGJ5IHRoZSBkcml2ZXIgZHVyaW5nIHJlbW92
ZSBhcyB3ZWxsLCBvciAKaXMgaXQgc3VmZmljaWVudCB0byBkZWFsIG9ubHkgd2l0aCB0aGUgcmVz
ZXQgZHVyaW5nIHByb2JlPwoKVGhhbmtzCgoKPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkg
PHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
LmMgfCAxNSArKysrKysrKysrLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
by5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvLmMKPiBpbmRleCBhMTViZWI2YjU5M2IuLjhkZjc1
NDI1ZmI0MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW8uYwo+ICsrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpby5jCj4gQEAgLTM0OSw3ICszNDksOSBAQCBpbnQgcmVnaXN0ZXJf
dmlydGlvX2RldmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KQo+ICAgCj4gICAJLyogV2Ug
YWx3YXlzIHN0YXJ0IGJ5IHJlc2V0dGluZyB0aGUgZGV2aWNlLCBpbiBjYXNlIGEgcHJldmlvdXMK
PiAgIAkgKiBkcml2ZXIgbWVzc2VkIGl0IHVwLiAgVGhpcyBhbHNvIHRlc3RzIHRoYXQgY29kZSBw
YXRoIGEgbGl0dGxlLiAqLwo+IC0JZGV2LT5jb25maWctPnJlc2V0KGRldik7Cj4gKwllcnIgPSBk
ZXYtPmNvbmZpZy0+cmVzZXQoZGV2KTsKPiArCWlmIChlcnIpCj4gKwkJZ290byBlcnJfcmVzZXQ7
Cj4gICAKPiAgIAkvKiBBY2tub3dsZWRnZSB0aGF0IHdlJ3ZlIHNlZW4gdGhlIGRldmljZS4gKi8K
PiAgIAl2aXJ0aW9fYWRkX3N0YXR1cyhkZXYsIFZJUlRJT19DT05GSUdfU19BQ0tOT1dMRURHRSk7
Cj4gQEAgLTM2MiwxMCArMzY0LDEzIEBAIGludCByZWdpc3Rlcl92aXJ0aW9fZGV2aWNlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICpkZXYpCj4gICAJICovCj4gICAJZXJyID0gZGV2aWNlX2FkZCgmZGV2
LT5kZXYpOwo+ICAgCWlmIChlcnIpCj4gLQkJaWRhX3NpbXBsZV9yZW1vdmUoJnZpcnRpb19pbmRl
eF9pZGEsIGRldi0+aW5kZXgpOwo+IC1vdXQ6Cj4gLQlpZiAoZXJyKQo+IC0JCXZpcnRpb19hZGRf
c3RhdHVzKGRldiwgVklSVElPX0NPTkZJR19TX0ZBSUxFRCk7Cj4gKwkJZ290byBlcnJfYWRkOwo+
ICsKPiArCXJldHVybiAwOwo+ICtlcnJfYWRkOgo+ICsJdmlydGlvX2FkZF9zdGF0dXMoZGV2LCBW
SVJUSU9fQ09ORklHX1NfRkFJTEVEKTsKPiArZXJyX3Jlc2V0Ogo+ICsJaWRhX3NpbXBsZV9yZW1v
dmUoJnZpcnRpb19pbmRleF9pZGEsIGRldi0+aW5kZXgpOwo+ICAgCXJldHVybiBlcnI7Cj4gICB9
Cj4gICBFWFBPUlRfU1lNQk9MX0dQTChyZWdpc3Rlcl92aXJ0aW9fZGV2aWNlKTsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
