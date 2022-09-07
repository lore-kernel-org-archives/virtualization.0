Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5939ECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 04:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAE3540294;
	Wed,  7 Sep 2022 04:13:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAE3540294
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VPhVXT1i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSfAC9ec2Dom; Wed,  7 Sep 2022 04:13:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F119940262;
	Wed,  7 Sep 2022 04:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F119940262
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C58AFC0032;
	Wed,  7 Sep 2022 04:13:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14AB8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E217340294
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E217340294
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5qsYgASI5uIY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:13:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75E9640262
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75E9640262
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 04:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662524023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAjDz4sR+CkkuN65TaxyzVYEg4bR36wJx58FYQ4lykw=;
 b=VPhVXT1i2843BdHopm5pbxzFyuHlZ7JA5/Z4WjhypaKbbWmL5luVlufY19gpHj0NiKSAq4
 PfCF/PSv2spAvweabpii3d2NOJoqFv8/vvvoUVcsHEVDOinDvTIN3cXvxptQMjWKq2L+XR
 JcmMyoJiVHeQKkj0OQou0fYo9eIySMo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-K6Au421_Nl-yBZQEYw-mgg-1; Wed, 07 Sep 2022 00:13:41 -0400
X-MC-Unique: K6Au421_Nl-yBZQEYw-mgg-1
Received: by mail-pj1-f69.google.com with SMTP id
 on10-20020a17090b1d0a00b002005c38844fso4790251pjb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 21:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=QAjDz4sR+CkkuN65TaxyzVYEg4bR36wJx58FYQ4lykw=;
 b=UbfdLpeKfwg5tm4i2fhIOa6nl25RtShyfoOMjzqvnGFoG+aH9twi5Mfy6OilUQIxLN
 tUMOeCBbt3xai2iD2PpRa0Nu5il5leA0i8F6LvO0CfvvfHqb4jhEZof+MTNV2UpOMB62
 D/FzHBgvJ+ATrHAz/bhQDkYsZPkL1CbHPVbYhcCEXHkE1sG//wKgli/xUMHAsUtErjPI
 UQfqsqm4/kqMEY4/IAl4wjIaEe2FSuc5V2SmApVlZ3Ui2P6SO0OBdx7GJdDehQ9dPYpD
 Vtf9WPEqo2UjH4E6KtC7u3TQkKs7hi0jP9QhlKczz7jaL++oJbB0hGvuX0dmbXd5uWWu
 vJ0w==
X-Gm-Message-State: ACgBeo3JO4jy9+LjCmKsHmoAiSRzU5YDgPOR6i49FrU1btWp5xXmsx3X
 JO8mqOE34p1UB0iMdPzsKJSmaNGe0wPjKKBDsnwLzVttrJoxStOC5nIohDKJBnOHqOcYt+c409C
 lm7CNk9VL/8EC9+1IadtWNt5HRWpSZck8aD8sGJzQHQ==
X-Received: by 2002:a17:90b:164f:b0:1f5:4ced:ed81 with SMTP id
 il15-20020a17090b164f00b001f54ceded81mr27894933pjb.122.1662524020695; 
 Tue, 06 Sep 2022 21:13:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6tb2znMua0rzcLRn+uEQoCxTA59Ra17knzBtFeDBJjJ2A8wstPFAsHDWkW6ISWVk/3jYZOcA==
X-Received: by 2002:a17:90b:164f:b0:1f5:4ced:ed81 with SMTP id
 il15-20020a17090b164f00b001f54ceded81mr27894912pjb.122.1662524020456; 
 Tue, 06 Sep 2022 21:13:40 -0700 (PDT)
Received: from [10.72.13.171] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a1709027b8d00b0016c0eb202a5sm10856284pll.225.2022.09.06.21.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Sep 2022 21:13:40 -0700 (PDT)
Message-ID: <f02e4c7a-3cbe-20dd-fdea-77dfcae7b67e@redhat.com>
Date: Wed, 7 Sep 2022 12:13:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v3 0/7] In order support for virtio_ring, vhost and vsock.
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220901055434.824-1-qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIyLzkvMSAxMzo1NCwgR3VvIFpoaSDlhpnpgZM6Cj4gSW4gdmlydGlvLXNwZWMgMS4x
LCBuZXcgZmVhdHVyZSBiaXQgVklSVElPX0ZfSU5fT1JERVIgd2FzIGludHJvZHVjZWQuCj4gV2hl
biB0aGlzIGZlYXR1cmUgaGFzIGJlZW4gbmVnb3RpYXRlZCwgdmlydGlvIGRyaXZlciB3aWxsIHVz
ZQo+IGRlc2NyaXB0b3JzIGluIHJpbmcgb3JkZXI6IHN0YXJ0aW5nIGZyb20gb2Zmc2V0IDAgaW4g
dGhlIHRhYmxlLCBhbmQKPiB3cmFwcGluZyBhcm91bmQgYXQgdGhlIGVuZCBvZiB0aGUgdGFibGUu
IFZob3N0IGRldmljZXMgd2lsbCBhbHdheXMgdXNlCj4gZGVzY3JpcHRvcnMgaW4gdGhlIHNhbWUg
b3JkZXIgaW4gd2hpY2ggdGhleSBoYXZlIGJlZW4gbWFkZSBhdmFpbGFibGUuCj4gVGhpcyBjYW4g
cmVkdWNlIHZpcnRpbyBhY2Nlc3NlcyB0byB1c2VkIHJpbmcuCj4KPiBCYXNlZCBvbiB1cGRhdGVk
IHZpcnRpby1zcGVjLCB0aGlzIHNlcmllcyByZWFsaXplZCBJTl9PUkRFUiBwcm90b3R5cGUgaW4g
dmlydGlvCj4gZHJpdmVyIGFuZCB2aG9zdC4gQ3VycmVudGx5IElOX09SREVSIGZlYXR1cmUgc3Vw
cG9ydGVkIGRldmljZXMgYXJlICp2aG9zdF90ZXN0Kgo+IGFuZCAqdnNvY2sqIGluIHZob3N0IGFu
ZCB2aXJ0aW8tbmV0IGluIFFFTVUuIElOX09SREVSIGZlYXR1cmUgd29ya3Mgd2VsbAo+IGNvbWJp
bmVkIHdpdGggSU5ESVJFQ1QgZmVhdHVyZSBpbiB0aGlzIHBhdGNoIHNlcmllcy4KCgpBcyBzdGF0
ZWQgaW4gdGhlIHByZXZpb3VzIHZlcnNpb25zLCBJJ2QgbGlrZSB0byBzZWUgcGVyZm9ybWFuY2Ug
bnVtYmVycy4gCldlIG5lZWQgdG8gcHJvdmUgdGhhdCB0aGUgZmVhdHVyZSBhY3R1YWxseSBoZWxw
IGZvciB0aGUgcGVyZm9ybWFuY2UuCgpBbmQgaXQgd291bGQgYmUgZXZlbiBiZXR0ZXIgaWYgd2Ug
ZG8gdGhlIGluLW9yZGVyIGluIHRoaXMgb3JkZXIgKHZob3N0IApzaWRlKToKCjEpIGVuYWJsZSBp
bi1vcmRlciBidXQgd2l0aG91dCBiYXRjaGluZyB1c2VkCjIpIGVuYWJsZSBpbi1vcmRlciB3aXRo
IGJhdGNoaW5nIHVzZWQKClRoZW4gd2UgY2FuIHNlZSBob3c6CgoxKSBpbi1vcmRlciBoZWxwcwoy
KSBiYXRjaGluZyBoZWxwcwoKVGhhbmtzCgoKPgo+IFZpcnRpbyBkcml2ZXIgaW5fb3JkZXIgc3Vw
cG9ydCBmb3IgcGFja2VkIHZxIGhhc24ndCBiZWVuIGRvbmUgaW4gdGhpcyBwYXRjaAo+IHNlcmll
cyBub3cuCj4KPiBHdW8gWmhpICg3KToKPiAgICB2aG9zdDogZXhwb3NlIHVzZWQgYnVmZmVycwo+
ICAgIHZob3N0X3Rlc3Q6IGJhdGNoIHVzZWQgYnVmZmVyCj4gICAgdnNvY2s6IGJhdGNoIGJ1ZmZl
cnMgaW4gdHgKPiAgICB2c29jazogYW5ub3VuY2UgVklSVElPX0ZfSU5fT1JERVIgaW4gdnNvY2sK
PiAgICB2aXJ0aW86IHVubWFzayBGX05FWFQgZmxhZyBpbiBkZXNjX2V4dHJhCj4gICAgdmlydGlv
OiBpbiBvcmRlciBzdXBwb3J0IGZvciB2aXJ0aW9fcmluZwo+ICAgIHZpcnRpbzogYW5ub3VuY2Ug
VklSVElPX0ZfSU5fT1JERVIgc3VwcG9ydAo+Cj4gICBkcml2ZXJzL3Zob3N0L3Rlc3QuYyAgICAg
ICAgIHwgMTYgKysrKysrLS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyAgICAgICAgfCAxNiAr
KysrKystLQo+ICAgZHJpdmVycy92aG9zdC92c29jay5jICAgICAgICB8IDEzICsrKysrLQo+ICAg
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDc5ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMDQgaW5zZXJ0aW9ucygrKSwgMjAg
ZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
