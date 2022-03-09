Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735CFC43217
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 04:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 140A884260;
	Wed,  9 Mar 2022 04:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OXGiqlzJCId; Wed,  9 Mar 2022 04:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7706A84255;
	Wed,  9 Mar 2022 04:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47640C001D;
	Wed,  9 Mar 2022 04:46:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85BDAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A2AC400D6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RsS_Fyps54hk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:46:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0196A4002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 04:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646801175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9y7hYtf8DIbE/b1LIIjEL5hDziwE2SHgt9FQ5yzHZY=;
 b=XmRAWvN5wwpVluEX7C8tOVdQ1FUYTF3orvLPCtMVSYynlmZt9ulsviK64j9jFyfRgQE8Y1
 UwH8CvXou1LCnD9jAoTsRDQ3gtxSFtUbhle0I59KApHBq5lMquTAq4hzFruSM8jM3h/gEt
 g97uC7KTm+DSTnab5kbfdzfL7RDKSro=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-oqz-Acn0O8iLXdAGkhjjZA-1; Tue, 08 Mar 2022 23:46:13 -0500
X-MC-Unique: oqz-Acn0O8iLXdAGkhjjZA-1
Received: by mail-pg1-f198.google.com with SMTP id
 t7-20020a634447000000b0036579648983so668798pgk.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 20:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=O9y7hYtf8DIbE/b1LIIjEL5hDziwE2SHgt9FQ5yzHZY=;
 b=Fr7q3G7ObGHS9m2xBdSwXM5H5tCLKyH4no6SpDFQbgVbkUsSSl0IklG54n67o8OoS6
 1VKjqEdAe7EjsNY0cZl7noThqR8FpSaRD53beVkhAUFgAo61cPQvxpA+7oX2+yWKp5eG
 hyKma9zxTOK7mflx9YTApH8PWmsc4rgTV9x+6gTRVqGrUPW+Wulnw2EStqaD6LajNQqy
 iX6itsIJud3PYnozW9o25u5jWCHEP8IEvIFrDpMmv4elfFn0AD6Y6qMUeqltN0L4rdtI
 cwygLAYWYLdIhbpk6kHwzYpdb04VA2oLy90Go6Gicu3NtWScCbRU4wYzRyAa4Q7oJM0M
 8P5A==
X-Gm-Message-State: AOAM533P5ZC+rAgCxEwTZfTxWSFYyqixxH/PYU/XZyFyNLgetAfbakgx
 dcDmuetjypJY+AE1+T+1fsB+3OL5lLHnyfx0khk6nSPiEiMQXpVZVCXZkDs+ZB5hiW305NueYjx
 cXEvbxEJaNulZIUtOwu3ve8PCF8RFNSLwS/NtjuKJsg==
X-Received: by 2002:a17:90a:17ab:b0:1bf:9519:fe86 with SMTP id
 q40-20020a17090a17ab00b001bf9519fe86mr5407278pja.25.1646801172046; 
 Tue, 08 Mar 2022 20:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNoaLCqq9sRt9psO5uqafOMqGFVYmxmfOSqOlDkq0FsYupDy1WKwY2W2xGCXK65aGhCKiuiQ==
X-Received: by 2002:a17:90a:17ab:b0:1bf:9519:fe86 with SMTP id
 q40-20020a17090a17ab00b001bf9519fe86mr5407253pja.25.1646801171689; 
 Tue, 08 Mar 2022 20:46:11 -0800 (PST)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a056a00214500b004bd7036b50asm810863pfk.172.2022.03.08.20.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 20:46:11 -0800 (PST)
Message-ID: <2c823fed-8024-39e7-f6f5-176fb518fc1a@redhat.com>
Date: Wed, 9 Mar 2022 12:45:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 00/26] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 kvm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFRoZSB2aXJ0aW8g
c3BlYyBhbHJlYWR5IHN1cHBvcnRzIHRoZSB2aXJ0aW8gcXVldWUgcmVzZXQgZnVuY3Rpb24uIFRo
aXMgcGF0Y2ggc2V0Cj4gaXMgdG8gYWRkIHRoaXMgZnVuY3Rpb24gdG8gdGhlIGtlcm5lbC4gVGhl
IHJlbGV2YW50IHZpcnRpbyBzcGVjIGluZm9ybWF0aW9uIGlzCj4gaGVyZToKPgo+ICAgICAgaHR0
cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTI0Cj4KPiBBbHNv
IHJlZ2FyZGluZyBNTUlPIHN1cHBvcnQgZm9yIHF1ZXVlIHJlc2V0LCBJIHBsYW4gdG8gc3VwcG9y
dCBpdCBhZnRlciB0aGlzCj4gcGF0Y2ggaXMgcGFzc2VkLgo+Cj4gUGVyZm9ybWluZyByZXNldCBv
biBhIHF1ZXVlIGlzIGRpdmlkZWQgaW50byBmb3VyIHN0ZXBzOgo+ICAgICAgIDEuIHZpcnRpb19y
ZXNldF92cSgpICAgICAgICAgICAgICAtIG5vdGlmeSB0aGUgZGV2aWNlIHRvIHJlc2V0IHRoZSBx
dWV1ZQo+ICAgICAgIDIuIHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZigpICAtIHJlY3ljbGUg
dGhlIGJ1ZmZlciBzdWJtaXR0ZWQKPiAgICAgICAzLiB2aXJ0cXVldWVfcmVzZXRfdnJpbmcoKSAg
ICAgICAgLSByZXNldCB0aGUgdnJpbmcgKG1heSByZS1hbGxvYykKPiAgICAgICA0LiB2aXJ0aW9f
ZW5hYmxlX3Jlc2V0cSgpICAgICAgICAgLSBtbWFwIHZyaW5nIHRvIGRldmljZSwgYW5kIGVuYWJs
ZSB0aGUgcXVldWUKPgo+IFRoZSBmaXJzdCBwYXJ0IDEtMTcgb2YgdGhpcyBwYXRjaCBzZXQgaW1w
bGVtZW50cyB2aXJ0aW8gcGNpJ3Mgc3VwcG9ydCBhbmQgQVBJCj4gZm9yIHF1ZXVlIHJlc2V0LiBU
aGUgbGF0dGVyIHBhcnQgaXMgdG8gbWFrZSB2aXJ0aW8tbmV0IHN1cHBvcnQgc2V0X3JpbmdwYXJh
bS4gRG8KPiB0aGVzZSB0aGluZ3MgZm9yIHRoaXMgZmVhdHVyZToKPgo+ICAgICAgICAxLiB2aXJ0
aW8tbmV0IHN1cHBvcnQgcngsdHggcmVzZXQKPiAgICAgICAgMi4gZmluZF92cXMoKSBzdXBwb3J0
IHRvIHNwZWNpYWwgdGhlIG1heCBzaXplIG9mIGVhY2ggdnEKPiAgICAgICAgMy4gdmlydGlvLW5l
dCBzdXBwb3J0IHNldF9yaW5ncGFyYW0KPgo+ICMxIC0jMyA6ICAgICAgIHByZXBhcmUKPiAjNCAt
IzEyOiAgICAgICB2aXJ0aW8gcmluZyBzdXBwb3J0IHJlc2V0IHZyaW5nIG9mIHRoZSB2cQo+ICMx
My0jMTQ6ICAgICAgIGFkZCBoZWxwZXIKPiAjMTUtIzE3OiAgICAgICB2aXJ0aW8gcGNpIHN1cHBv
cnQgcmVzZXQgcXVldWUgYW5kIHJlLWVuYWJsZQo+ICMxOC0jMjE6ICAgICAgIGZpbmRfdnFzKCkg
c3VwcG9ydCBzaXplcyB0byBzcGVjaWFsIHRoZSBtYXggc2l6ZSBvZiBlYWNoIHZxCj4gIzIzLSMy
NDogICAgICAgdmlydGlvLW5ldCBzdXBwb3J0IHJ4LCB0eCByZXNldAo+ICMyMiwgIzI1LCAjMjY6
IHZpcnRpby1uZXQgc3VwcG9ydCBzZXQgcmluZ3BhcmFtCj4KPiBUZXN0IGVudmlyb25tZW50Ogo+
ICAgICAgSG9zdDogNC4xOS45MQo+ICAgICAgUWVtdTogUUVNVSBlbXVsYXRvciB2ZXJzaW9uIDYu
Mi41MCAod2l0aCB2cSByZXNldCBzdXBwb3J0KQo+ICAgICAgVGVzdCBDbWQ6ICBldGh0b29sIC1H
IGV0aDEgcnggJDEgdHggJDI7IGV0aHRvb2wgLWcgZXRoMQo+Cj4gICAgICBUaGUgZGVmYXVsdCBp
cyBzcGxpdCBtb2RlLCBtb2RpZnkgUWVtdSB2aXJ0aW8tbmV0IHRvIGFkZCBQQUNLRUQgZmVhdHVy
ZSB0byB0ZXN0Cj4gICAgICBwYWNrZWQgbW9kZS4KPgo+Cj4gUGxlYXNlIHJldmlldy4gVGhhbmtz
Lgo+Cj4gdjc6Cj4gICAgMS4gZml4ICM2IHN1YmplY3QgdHlwbwo+ICAgIDIuIGZpeCAjNiByaW5n
X3NpemVfaW5fYnl0ZXMgaXMgdW5pbml0aWFsaXplZAo+ICAgIDMuIGNoZWNrIGJ5OiBtYWtlIFc9
MTIKPgo+IHY2Ogo+ICAgIDEuIHZpcnRpb19wY2k6IHVzZSBzeW5jaHJvbml6ZV9pcnEoaXJxKSB0
byBzeW5jIHRoZSBpcnEgY2FsbGJhY2tzCj4gICAgMi4gSW50cm9kdWNlIHZpcnRxdWV1ZV9yZXNl
dF92cmluZygpIHRvIGltcGxlbWVudCB0aGUgcmVzZXQgb2YgdnJpbmcgZHVyaW5nCj4gICAgICAg
dGhlIHJlc2V0IHByb2Nlc3MuIE1heSB1c2UgdGhlIG9sZCB2cmluZyBpZiBudW0gb2YgdGhlIHZx
IG5vdCBjaGFuZ2UuCj4gICAgMy4gZmluZF92cXMoKSBzdXBwb3J0IHNpemVzIHRvIHNwZWNpYWwg
dGhlIG1heCBzaXplIG9mIGVhY2ggdnEKPgo+IHY1Ogo+ICAgIDEuIGFkZCB2aXJ0aW8tbmV0IHN1
cHBvcnQgc2V0X3JpbmdwYXJhbQo+Cj4gdjQ6Cj4gICAgMS4ganVzdCB0aGUgY29kZSBvZiB2aXJ0
aW8sIHdpdGhvdXQgdmlydGlvLW5ldAo+ICAgIDIuIFBlcmZvcm1pbmcgcmVzZXQgb24gYSBxdWV1
ZSBpcyBkaXZpZGVkIGludG8gdGhlc2Ugc3RlcHM6Cj4gICAgICAxLiByZXNldF92cTogcmVzZXQg
b25lIHZxCj4gICAgICAyLiByZWN5Y2xlIHRoZSBidWZmZXIgZnJvbSB2cSBieSB2aXJ0cXVldWVf
ZGV0YWNoX3VudXNlZF9idWYoKQo+ICAgICAgMy4gcmVsZWFzZSB0aGUgcmluZyBvZiB0aGUgdnEg
YnkgdnJpbmdfcmVsZWFzZV92aXJ0cXVldWUoKQo+ICAgICAgNC4gZW5hYmxlX3Jlc2V0X3ZxOiBy
ZS1lbmFibGUgdGhlIHJlc2V0IHF1ZXVlCj4gICAgMy4gU2ltcGxpZnkgdGhlIHBhcmFtZXRlcnMg
b2YgZW5hYmxlX3Jlc2V0X3ZxKCkKPiAgICA0LiBhZGQgY29udGFpbmVyIHN0cnVjdHVyZXMgZm9y
IHZpcnRpb19wY2lfY29tbW9uX2NmZwo+Cj4gdjM6Cj4gICAgMS4ga2VlcCB2cSwgaXJxIHVucmVs
ZWFzZWQKCgpUaGUgc2VyaWVzIGJlY2FtZSBraW5kIG9mIGh1Z2UuCgpJJ2Qgc3VnZ2VzdCB0byBz
cGxpdCBpdCBpbnRvIHR3byBzZXJpZXMuCgoxKSByZWZhY3RvcmluZyBvZiB0aGUgdmlydGlvX3Jp
bmcgdG8gcHJlcGFyZSBmb3IgdGhlIHJlc2l6ZQoyKSB0aGUgcmVzZXQgc3VwcG9ydCArIHZpcnRp
by1uZXQgc3VwcG9ydAoKVGhhbmtzCgoKPgo+ICoqKiBCTFVSQiBIRVJFICoqKgo+Cj4gWHVhbiBa
aHVvICgyNik6Cj4gICAgdmlydGlvX3BjaTogc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBh
ZGQgcXVldWVfbm90aWZ5X2RhdGEKPiAgICB2aXJ0aW86IHF1ZXVlX3Jlc2V0OiBhZGQgVklSVElP
X0ZfUklOR19SRVNFVAo+ICAgIHZpcnRpbzogYWRkIGhlbHBlciB2aXJ0cXVldWVfZ2V0X3ZyaW5n
X21heF9zaXplKCkKPiAgICB2aXJ0aW9fcmluZzogc3BsaXQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9m
IGNyZWF0aW5nIHZyaW5nCj4gICAgdmlydGlvX3Jpbmc6IHNwbGl0OiBleHRyYWN0IHRoZSBsb2dp
YyBvZiBpbml0IHZxIGFuZCBhdHRhY2ggdnJpbmcKPiAgICB2aXJ0aW9fcmluZzogcGFja2VkOiBl
eHRyYWN0IHRoZSBsb2dpYyBvZiBjcmVhdGluZyB2cmluZwo+ICAgIHZpcnRpb19yaW5nOiBwYWNr
ZWQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGluaXQgdnEgYW5kIGF0dGFjaCB2cmluZwo+ICAgIHZp
cnRpb19yaW5nOiBleHRyYWN0IHRoZSBsb2dpYyBvZiBmcmVlaW5nIHZyaW5nCj4gICAgdmlydGlv
X3Jpbmc6IHNwbGl0OiBpbXBsZW1lbnQgdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nX3NwbGl0KCkKPiAg
ICB2aXJ0aW9fcmluZzogcGFja2VkOiBpbXBsZW1lbnQgdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nX3Bh
Y2tlZCgpCj4gICAgdmlydGlvX3Jpbmc6IGludHJvZHVjZSB2aXJ0cXVldWVfcmVzZXRfdnJpbmco
KQo+ICAgIHZpcnRpb19yaW5nOiB1cGRhdGUgdGhlIGRvY3VtZW50IG9mIHRoZSB2aXJ0cXVldWVf
ZGV0YWNoX3VudXNlZF9idWYKPiAgICAgIGZvciBxdWV1ZSByZXNldAo+ICAgIHZpcnRpbzogcXVl
dWVfcmVzZXQ6IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyBhZGQgY2FsbGJhY2tzIGZvcgo+ICAg
ICAgcXVldWVfcmVzZXQKPiAgICB2aXJ0aW86IGFkZCBoZWxwZXIgZm9yIHF1ZXVlIHJlc2V0Cj4g
ICAgdmlydGlvX3BjaTogcXVldWVfcmVzZXQ6IHVwZGF0ZSBzdHJ1Y3QgdmlydGlvX3BjaV9jb21t
b25fY2ZnIGFuZAo+ICAgICAgb3B0aW9uIGZ1bmN0aW9ucwo+ICAgIHZpcnRpb19wY2k6IHF1ZXVl
X3Jlc2V0OiBleHRyYWN0IHRoZSBsb2dpYyBvZiBhY3RpdmUgdnEgZm9yIG1vZGVybiBwY2kKPiAg
ICB2aXJ0aW9fcGNpOiBxdWV1ZV9yZXNldDogc3VwcG9ydCBWSVJUSU9fRl9SSU5HX1JFU0VUCj4g
ICAgdmlydGlvOiBmaW5kX3ZxcygpIGFkZCBhcmcgc2l6ZXMKPiAgICB2aXJ0aW9fcGNpOiBzdXBw
b3J0IHRoZSBhcmcgc2l6ZXMgb2YgZmluZF92cXMoKQo+ICAgIHZpcnRpb19tbWlvOiBzdXBwb3J0
IHRoZSBhcmcgc2l6ZXMgb2YgZmluZF92cXMoKQo+ICAgIHZpcnRpbzogYWRkIGhlbHBlciB2aXJ0
aW9fZmluZF92cXNfY3R4X3NpemUoKQo+ICAgIHZpcnRpb19uZXQ6IGdldCByaW5ncGFyYW0gYnkg
dmlydHF1ZXVlX2dldF92cmluZ19tYXhfc2l6ZSgpCj4gICAgdmlydGlvX25ldDogc3BsaXQgZnJl
ZV91bnVzZWRfYnVmcygpCj4gICAgdmlydGlvX25ldDogc3VwcG9ydCByeC90eCBxdWV1ZSByZXNl
dAo+ICAgIHZpcnRpb19uZXQ6IHNldCB0aGUgZGVmYXVsdCBtYXggcmluZyBzaXplIGJ5IGZpbmRf
dnFzKCkKPiAgICB2aXJ0aW9fbmV0OiBzdXBwb3J0IHNldF9yaW5ncGFyYW0KPgo+ICAgYXJjaC91
bS9kcml2ZXJzL3ZpcnRpb191bWwuYyAgICAgICAgICAgICB8ICAgMiArLQo+ICAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jICAgICAgICAgICAgICAgICB8IDI1NyArKysrKysrKy0tCj4gICBkcml2
ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlmby5jIHwgICAzICstCj4gICBkcml2ZXJz
L3JlbW90ZXByb2MvcmVtb3RlcHJvY192aXJ0aW8uYyAgIHwgICAyICstCj4gICBkcml2ZXJzL3Mz
OTAvdmlydGlvL3ZpcnRpb19jY3cuYyAgICAgICAgIHwgICAyICstCj4gICBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fbW1pby5jICAgICAgICAgICAgIHwgIDEyICstCj4gICBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2NvbW1vbi5jICAgICAgIHwgIDI4ICstCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2NvbW1vbi5oICAgICAgIHwgICAzICstCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeS5jICAgICAgIHwgICA4ICstCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X21vZGVybi5jICAgICAgIHwgMTQ2ICsrKysrLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9tb2Rlcm5fZGV2LmMgICB8ICAzNiArKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyAgICAgICAgICAgICB8IDU4NCArKysrKysrKysrKysrKysrKy0tLS0tLQo+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3ZkcGEuYyAgICAgICAgICAgICB8ICAgMiArLQo+ICAgaW5jbHVkZS9saW51
eC92aXJ0aW8uaCAgICAgICAgICAgICAgICAgICB8ICAxMiArCj4gICBpbmNsdWRlL2xpbnV4L3Zp
cnRpb19jb25maWcuaCAgICAgICAgICAgIHwgIDc0ICsrLQo+ICAgaW5jbHVkZS9saW51eC92aXJ0
aW9fcGNpX21vZGVybi5oICAgICAgICB8ICAgMiArCj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmly
dGlvX2NvbmZpZy5oICAgICAgIHwgICA3ICstCj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlv
X3BjaS5oICAgICAgICAgIHwgIDE0ICsKPiAgIDE4IGZpbGVzIGNoYW5nZWQsIDk3OSBpbnNlcnRp
b25zKCspLCAyMTUgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuMzEuMAo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
