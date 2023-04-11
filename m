Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0F8C76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DA2B410A8;
	Tue, 11 Apr 2023 05:22:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DA2B410A8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jDrsxS2h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fBUcEZqykqDt; Tue, 11 Apr 2023 05:22:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3245C409EF;
	Tue, 11 Apr 2023 05:22:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3245C409EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 087E6C0036;
	Tue, 11 Apr 2023 05:22:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99F67C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BFCC410A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:21:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BFCC410A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Rlaa3pIg4S2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:21:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FA58409EF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FA58409EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681190516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSyPEz0dj4QPkw4b3m+T4Qhl57EVSXpALtV9sEZUqeI=;
 b=jDrsxS2hFmwjwDV1xqSX1vMvJbXzixPzowC2xHRcGZ6ax9fIESDRqtQYg1n4X9cD4dE11H
 d8PH4DSboLVIHj2jH9/Fd6sCNNJ6bIptlT3CNfBVt7CCQ7BAOeh2lt9FY11hmGDvYH5W0/
 Zh89+aA+d9fzClYNotJOD9FCRg2VGBc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-bq-awRl6Mta_FW1yN0Kjng-1; Tue, 11 Apr 2023 01:21:52 -0400
X-MC-Unique: bq-awRl6Mta_FW1yN0Kjng-1
Received: by mail-pl1-f200.google.com with SMTP id
 k7-20020a170902c40700b001a20f75cd40so4484204plk.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 22:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681190511; x=1683782511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CSyPEz0dj4QPkw4b3m+T4Qhl57EVSXpALtV9sEZUqeI=;
 b=YW+ZhORoB64eF3l6TSBIoljDbyf/yGa5p81IeSzTOLWc8rRe3l2ehRtrl+4FmWVFv1
 fVk6YofuIQfiMDJWOVLxeYGAeNdbBfQKg2Jcouz3BQuy1K2c4oW7hj0mJ/OlMoV3IQ7u
 h9reUX+kYB4WrF+efHUBU4I4Mt16qcTwpNClgq9tYKkntT7q6x4FbWGOALRwUmtGVKHR
 eWIrXPsUkJIDRrwOJJ9vSCc0JXcVOb9yM7Wi8lF/EjO9FwJsaCdiZbwIqPD6SDwqjiep
 eH4byfXzT6Su3rY3GqFzQWk7IbB/1mzHqd+t807mObY8BR+TzMNjorNNhRdR1ENmSx9r
 DAUg==
X-Gm-Message-State: AAQBX9du2cZ3VgaCBoIZyxjCF+r6reHIm26kb6UMsEaWCpm8G/dxAerB
 axH79zVwhRy0LHiJAxtHEgBgVgZCtmjMkBWq5Sj1chm1HXG4bc0nyUdnVNwGdfnLYAcnfj8WItq
 76m/TUvqv7Wm4HpzVzXxeJgA2VgAL68euCXHM9jPqCQ==
X-Received: by 2002:a17:902:c70b:b0:1a2:7d:8a8d with SMTP id
 p11-20020a170902c70b00b001a2007d8a8dmr11435217plp.57.1681190511560; 
 Mon, 10 Apr 2023 22:21:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YvTulxGObdkv1SmgfzXPJ3eJht+HFc7seBNvl/iPRuLfK6egB3Yt6XVYkzZDpVLBdsT6nfZQ==
X-Received: by 2002:a17:902:c70b:b0:1a2:7d:8a8d with SMTP id
 p11-20020a170902c70b00b001a2007d8a8dmr11435206plp.57.1681190511279; 
 Mon, 10 Apr 2023 22:21:51 -0700 (PDT)
Received: from [10.72.12.112] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a170902849300b001a520f9071dsm6042047plo.7.2023.04.10.22.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 22:21:50 -0700 (PDT)
Message-ID: <e519afc9-c7de-e579-5df5-34e024e32273@redhat.com>
Date: Tue, 11 Apr 2023 13:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] vdpa/snet: support the suspend vDPA callback
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, mst@redhat.com
References: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
 <20230410100237.3499578-3-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230410100237.3499578-3-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzQvMTAgMTg6MDIsIEFsdmFybyBLYXJzeiDlhpnpgZM6Cj4gV2hlbiBzdXNwZW5k
IGlzIGNhbGxlZCwgdGhlIGRyaXZlciBzZW5kcyBhIHN1c3BlbmQgY29tbWFuZCB0byB0aGUgRFBV
Cj4gdGhyb3VnaCB0aGUgY29udHJvbCBtZWNoYW5pc20uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbHZh
cm8gS2Fyc3ogPGFsdmFyby5rYXJzekBzb2xpZC1ydW4uY29tPgoKCldoaWxlIGF0IHRoaXMsIGhv
dyBhYm91dCBpbXBsZW1lbnQgcmVzdW1lIGFzIHdlbGw/CgpUaGFua3MKCgo+IC0tLQo+ICAgZHJp
dmVycy92ZHBhL3NvbGlkcnVuL3NuZXRfY3RybC5jIHwgIDYgKysrKysrCj4gICBkcml2ZXJzL3Zk
cGEvc29saWRydW4vc25ldF9tYWluLmMgfCAxNSArKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMv
dmRwYS9zb2xpZHJ1bi9zbmV0X3ZkcGEuaCB8ICAxICsKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0
X2N0cmwuYyBiL2RyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X2N0cmwuYwo+IGluZGV4IGY3YjNi
Mjg4N2Q2Li5jMDQ0OTY3MWJhZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvc29saWRydW4v
c25ldF9jdHJsLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9jdHJsLmMKPiBA
QCAtMTUsNiArMTUsNyBAQAo+ICAgZW51bSBzbmV0X2N0cmxfb3Bjb2RlcyB7Cj4gICAJU05FVF9D
VFJMX09QX0RFU1RST1kgPSAxLAo+ICAgCVNORVRfQ1RSTF9PUF9SRUFEX1ZRX1NUQVRFLAo+ICsJ
U05FVF9DVFJMX09QX1NVU1BFTkQsCj4gICB9Owo+ICAgCj4gICAjZGVmaW5lIFNORVRfQ1RSTF9U
SU1FT1VUCSAgICAgICAgMjAwMDAwMAo+IEBAIC0zMjEsMyArMzIyLDggQEAgaW50IHNuZXRfcmVh
ZF92cV9zdGF0ZShzdHJ1Y3Qgc25ldCAqc25ldCwgdTE2IGlkeCwgc3RydWN0IHZkcGFfdnFfc3Rh
dGUgKnN0YXRlKQo+ICAgCXJldHVybiBzbmV0X2N0cmxfcmVhZF9mcm9tX2RwdShzbmV0LCBTTkVU
X0NUUkxfT1BfUkVBRF9WUV9TVEFURSwgaWR4LCBzdGF0ZSwKPiAgIAkJCQkgICAgICAgc2l6ZW9m
KCpzdGF0ZSkpOwo+ICAgfQo+ICsKPiAraW50IHNuZXRfc3VzcGVuZF9kZXYoc3RydWN0IHNuZXQg
KnNuZXQpCj4gK3sKPiArCXJldHVybiBzbmV0X3NlbmRfY3RybF9tc2coc25ldCwgU05FVF9DVFJM
X09QX1NVU1BFTkQsIDApOwo+ICt9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9zb2xpZHJ1
bi9zbmV0X21haW4uYyBiL2RyaXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X21haW4uYwo+IGluZGV4
IDU2NDdhNzViNDU3Li41MjE2YjI3ZTExMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvc29s
aWRydW4vc25ldF9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvc29saWRydW4vc25ldF9tYWlu
LmMKPiBAQCAtNDgzLDYgKzQ4MywyMCBAQCBzdGF0aWMgdm9pZCBzbmV0X3NldF9jb25maWcoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICAgCQlpb3dyaXRl
OCgqYnVmX3B0cisrLCBjZmdfcHRyICsgaSk7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCBzbmV0
X3N1c3BlbmQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICt7Cj4gKwlzdHJ1Y3Qgc25ldCAq
c25ldCA9IHZkcGFfdG9fc25ldCh2ZGV2KTsKPiArCWludCByZXQ7Cj4gKwo+ICsJcmV0ID0gc25l
dF9zdXNwZW5kX2RldihzbmV0KTsKPiArCWlmIChyZXQpCj4gKwkJU05FVF9FUlIoc25ldC0+cGRl
diwgIlNORVRbJXVdIHN1c3BlbmQgZmFpbGVkLCBlcnI6ICVkXG4iLCBzbmV0LT5zaWQsIHJldCk7
Cj4gKwllbHNlCj4gKwkJU05FVF9EQkcoc25ldC0+cGRldiwgIlN1c3BlbmQgU05FVFsldV0gZGV2
aWNlXG4iLCBzbmV0LT5zaWQpOwo+ICsKPiArCXJldHVybiByZXQ7Cj4gK30KPiArCj4gICBzdGF0
aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBzbmV0X2NvbmZpZ19vcHMgPSB7Cj4gICAJ
LnNldF92cV9hZGRyZXNzICAgICAgICAgPSBzbmV0X3NldF92cV9hZGRyZXNzLAo+ICAgCS5zZXRf
dnFfbnVtICAgICAgICAgICAgID0gc25ldF9zZXRfdnFfbnVtLAo+IEBAIC01MDgsNiArNTIyLDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgc25ldF9jb25maWdfb3BzID0g
ewo+ICAgCS5zZXRfc3RhdHVzICAgICAgICAgICAgID0gc25ldF9zZXRfc3RhdHVzLAo+ICAgCS5n
ZXRfY29uZmlnICAgICAgICAgICAgID0gc25ldF9nZXRfY29uZmlnLAo+ICAgCS5zZXRfY29uZmln
ICAgICAgICAgICAgID0gc25ldF9zZXRfY29uZmlnLAo+ICsJLnN1c3BlbmQJCT0gc25ldF9zdXNw
ZW5kLAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIGludCBwc25ldF9vcGVuX3BmX2JhcihzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgc3RydWN0IHBzbmV0ICpwc25ldCkKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3NvbGlkcnVuL3NuZXRfdmRwYS5oIGIvZHJpdmVycy92ZHBhL3NvbGlkcnVuL3NuZXRf
dmRwYS5oCj4gaW5kZXggNDYxMzNkYjMwNjMuLmUzMzUyOGYyOGJkIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9zb2xpZHJ1bi9zbmV0X3ZkcGEuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9zb2xp
ZHJ1bi9zbmV0X3ZkcGEuaAo+IEBAIC0yMDMsNSArMjAzLDYgQEAgdm9pZCBwc25ldF9jcmVhdGVf
aHdtb24oc3RydWN0IHBjaV9kZXYgKnBkZXYpOwo+ICAgdm9pZCBzbmV0X2N0cmxfY2xlYXIoc3Ry
dWN0IHNuZXQgKnNuZXQpOwo+ICAgaW50IHNuZXRfZGVzdHJveV9kZXYoc3RydWN0IHNuZXQgKnNu
ZXQpOwo+ICAgaW50IHNuZXRfcmVhZF92cV9zdGF0ZShzdHJ1Y3Qgc25ldCAqc25ldCwgdTE2IGlk
eCwgc3RydWN0IHZkcGFfdnFfc3RhdGUgKnN0YXRlKTsKPiAraW50IHNuZXRfc3VzcGVuZF9kZXYo
c3RydWN0IHNuZXQgKnNuZXQpOwo+ICAgCj4gICAjZW5kaWYgLy9fU05FVF9WRFBBX0hfCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
