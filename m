Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B315C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 06:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 018AA60B91;
	Mon, 14 Mar 2022 06:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mrJK2n_Y8UH; Mon, 14 Mar 2022 06:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 814E260B06;
	Mon, 14 Mar 2022 06:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50C24C001D;
	Mon, 14 Mar 2022 06:03:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC61C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F6BF405BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CxCLRuILKEf5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:03:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC60B400D6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647237808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bVeXSAPAIyLEMvADgvGsIj3wikzII/B9d4vv1jFOjU=;
 b=GvIMzyYfR2BWKuKRWlta4wpiqOx7VkglSjdUzV0dschE37M4812GxhEVTMtG3Mnte08F/x
 rHvP3MnQQwyU7TosVTrgO9f3LNZ9kcVPGCMZuknlc+pKp7hhd+7GHXVuF4AGYOzZvK5/P4
 sm98ZQl5ij7AItbsvBdn4Lbe/DtUE2c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-VcwUG1G3O4qh2I56xXpIdg-1; Mon, 14 Mar 2022 02:03:26 -0400
X-MC-Unique: VcwUG1G3O4qh2I56xXpIdg-1
Received: by mail-pl1-f198.google.com with SMTP id
 z10-20020a170902708a00b0014fc3888923so5891054plk.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 23:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+bVeXSAPAIyLEMvADgvGsIj3wikzII/B9d4vv1jFOjU=;
 b=KH4YOoI96lZvgVI3Ij9qNWCprlUg24/6K6t/494JA+2da9aNfweeJ7M19V48jwMQ8q
 u8elLM6+qA0iKANW0kp0baIZMfgDpIVzjzSqBTmWL+RQVUy+UEo+AMnljLb6jTJpG/GJ
 tKTnugX7ql6slERz3bxt0IPJL3RLqnzMtuOIs1fVoxHSQyXpLN6F4Yo6fP651LpR1BNx
 xsEMFQR17IDkrJQ/jVJCTV3TNCBMeCDLIiWFu1A9zQJtW2eP7XJEtjZwfU52kEg1qBEJ
 XXFi33BpdegPlKvPEGg9JXKxxLwuRKBKxpexs1U3s7u07RkxwFUX1vzZBx8HJCaNSJhD
 6Ldg==
X-Gm-Message-State: AOAM530TFjP6IF3DCQtpwSzU09KUYTaSRkod68mNbofkojKv+OHZbzhM
 AbrC/tmDEaGYVbOHMrWVedF1tY3ixpUVwhxWOGVY6LmPTGJrOdyy9T7/9/1rTkAql7NJSieQKBZ
 s/+W3YaGsH+JHekFjdlTx1rLNzeVcTu1By0gaYoVC4A==
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr23310096pjg.93.1647237805715; 
 Sun, 13 Mar 2022 23:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHJLlKsy+iGZWFfSSZs5522fWpCLPCuJ5+r/iAxz9GOr2pZgULqn0VLRevvecGY0GD+eDtZQ==
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr23310068pjg.93.1647237805387; 
 Sun, 13 Mar 2022 23:03:25 -0700 (PDT)
Received: from [10.72.13.210] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a17090ad59600b001b7deb42251sm19777664pju.15.2022.03.13.23.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 23:03:24 -0700 (PDT)
Message-ID: <dc92c90e-fbb6-dc60-a73b-5415c40cbf5b@redhat.com>
Date: Mon, 14 Mar 2022 14:03:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/2] vdpa: support exposing the config size to userspace
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com
References: <20220310072051.2175-1-longpeng2@huawei.com>
 <20220310072051.2175-2-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220310072051.2175-2-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, yechuan@huawei.com, huangzhichao@huawei.com,
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

CuWcqCAyMDIyLzMvMTAg5LiL5Y2IMzoyMCwgTG9uZ3BlbmcoTWlrZSkg5YaZ6YGTOgo+IEZyb206
IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPgo+IC0gR0VUX0NPTkZJR19TSVpFOiBy
ZXR1cm4gdGhlIHNpemUgb2YgdGhlIHZpcnRpbyBjb25maWcgc3BhY2UuCj4KPiBUaGUgc2l6ZSBj
b250YWlucyB0aGUgZmllbGRzIHdoaWNoIGFyZSBjb25kaXRpb25hbCBvbiBmZWF0dXJlCj4gYml0
cy4KPgo+IFNpZ25lZC1vZmYtYnk6IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJp
dmVycy92aG9zdC92ZHBhLmMgICAgICAgfCAxNyArKysrKysrKysrKysrKysrKwo+ICAgaW5jbHVk
ZS9saW51eC92ZHBhLmggICAgICAgfCAgMyArKy0KPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aG9z
dC5oIHwgIDQgKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+IGluZGV4IGVjNTI0OWUuLjYwNWM3YWUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0zNTUs
NiArMzU1LDIwIEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uoc3RydWN0
IHZob3N0X3ZkcGEgKnYsIHUzMiBfX3VzZXIgKmFyZ3ApCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4g
ICAKPiArc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZob3N0
X3ZkcGEgKnYsIHUzMiBfX3VzZXIgKmFyZ3ApCj4gK3sKPiArCXN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYSA9IHYtPnZkcGE7Cj4gKwljb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2
ZHBhLT5jb25maWc7Cj4gKwl1MzIgc2l6ZTsKPiArCj4gKwlzaXplID0gb3BzLT5nZXRfY29uZmln
X3NpemUodmRwYSk7Cj4gKwo+ICsJaWYgKGNvcHlfdG9fdXNlcihhcmdwLCAmc2l6ZSwgc2l6ZW9m
KHNpemUpKSkKPiArCQlyZXR1cm4gLUVGQVVMVDsKPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICsK
PiAgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X3ZkcGEg
KnYsIHVuc2lnbmVkIGludCBjbWQsCj4gICAJCQkJICAgdm9pZCBfX3VzZXIgKmFyZ3ApCj4gICB7
Cj4gQEAgLTQ5Miw2ICs1MDYsOSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiAgIAljYXNlIFZIT1NUX1ZEUEFfR0VUX0lPVkFfUkFO
R0U6Cj4gICAJCXIgPSB2aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHYsIGFyZ3ApOwo+ICAgCQli
cmVhazsKPiArCWNhc2UgVkhPU1RfVkRQQV9HRVRfQ09ORklHX1NJWkU6Cj4gKwkJciA9IHZob3N0
X3ZkcGFfZ2V0X2NvbmZpZ19zaXplKHYsIGFyZ3ApOwo+ICsJCWJyZWFrOwo+ICAgCWRlZmF1bHQ6
Cj4gICAJCXIgPSB2aG9zdF9kZXZfaW9jdGwoJnYtPnZkZXYsIGNtZCwgYXJncCk7Cj4gICAJCWlm
IChyID09IC1FTk9JT0NUTENNRCkKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmgg
Yi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IGluZGV4IDcyMTA4OWIuLmE1MjY5MTkgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
IEBAIC0yMDcsNyArMjA3LDggQEAgc3RydWN0IHZkcGFfbWFwX2ZpbGUgewo+ICAgICogQHJlc2V0
OgkJCVJlc2V0IGRldmljZQo+ICAgICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAgKgkJCQlS
ZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4gLSAqIEBnZXRfY29u
ZmlnX3NpemU6CQlHZXQgdGhlIHNpemUgb2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UKPiArICog
QGdldF9jb25maWdfc2l6ZToJCUdldCB0aGUgc2l6ZSBvZiB0aGUgY29uZmlndXJhdGlvbiBzcGFj
ZSBpbmNsdWRlcwo+ICsgKgkJCQlmaWVsZHMgdGhhdCBhcmUgY29uZGl0aW9uYWwgb24gZmVhdHVy
ZSBiaXRzLgo+ICAgICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAgKgkJCQlSZXR1cm5zIHNp
emVfdDogY29uZmlndXJhdGlvbiBzaXplCj4gICAgKiBAZ2V0X2NvbmZpZzoJCQlSZWFkIGZyb20g
ZGV2aWNlIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gc3BhY2UKPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+IGluZGV4
IGM5OTg4NjAuLmJjNzRlOTUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0
LmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+IEBAIC0xNTAsNCArMTUwLDgg
QEAKPiAgIC8qIEdldCB0aGUgdmFsaWQgaW92YSByYW5nZSAqLwo+ICAgI2RlZmluZSBWSE9TVF9W
RFBBX0dFVF9JT1ZBX1JBTkdFCV9JT1IoVkhPU1RfVklSVElPLCAweDc4LCBcCj4gICAJCQkJCSAg
ICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSkKPiArCj4gKy8qIEdldCB0aGUgY29uZmln
IHNpemUgKi8KPiArI2RlZmluZSBWSE9TVF9WRFBBX0dFVF9DT05GSUdfU0laRQlfSU9SKFZIT1NU
X1ZJUlRJTywgMHg3OSwgX191MzIpCj4gKwo+ICAgI2VuZGlmCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
