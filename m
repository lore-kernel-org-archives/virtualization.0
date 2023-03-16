Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CD4C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 03:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EDB460BE0;
	Thu, 16 Mar 2023 03:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EDB460BE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BpZ16kBS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FuLKwCj0evaw; Thu, 16 Mar 2023 03:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1606760B51;
	Thu, 16 Mar 2023 03:27:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1606760B51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC83BC0071;
	Thu, 16 Mar 2023 03:27:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E8BDC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 03:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC7F160BE0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 03:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC7F160BE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FL9rbmhvaoyE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 03:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F10E60B51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F10E60B51
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 03:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678937234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMb/pvY0ifAYDi1mDsSYQA0P+lv6YS8p6Jz5ap0BMTc=;
 b=BpZ16kBSC625qfEczSWfi0W0jZkeRlfDYALcI1R4vh9JA5885tlnaMGygr9WPqAVJxhEJZ
 zpaECj9fR5hMqE9QT2qByX/ivuF8ZwkthdcK9RpKOFoHdWNqS77IcOodLPFWEgtemOUe5M
 Ca8qegwrncxUAuwh3qVAc9DaNud6T2Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-_QbzFcRUPVeBTtz0efLeaQ-1; Wed, 15 Mar 2023 23:27:10 -0400
X-MC-Unique: _QbzFcRUPVeBTtz0efLeaQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 cp21-20020a17090afb9500b0023c061f2bd0so1886901pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 20:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678937229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMb/pvY0ifAYDi1mDsSYQA0P+lv6YS8p6Jz5ap0BMTc=;
 b=4c1wH/E5M5jRpIZ10buC0Q8aQFUVNT4Zl9Bz9nCrbLBsz19Ld0+MYgnigJ5f9kb455
 e9qrF0VNjZwRmCEa4JFNOSCHnHnJu5xIPr1ha3vU+B/YwBg/I9d8hlJOlkmcu/tqmLth
 JqV2HfcuVyNxRqR1YEanm9GWcBlnLRdR2XX6F7eSIypip91DBMcUADCx7rtBTGY/pUl5
 WiA+iX8+00S2jbv7F6UZGw+/Oo5vly0CFI7MABxn0jOOp0O7vEDRGBvRFR1weBez6iq9
 xkCSIz71Ps+D1XvAr4uj6SAk6ukBCmKWhb8uVr2w+ArUVSb1sKmUXhC+3Qgawgh9jOKW
 4dnw==
X-Gm-Message-State: AO0yUKU6DDtMCpG1176CfolTEbr+9j3OgO3vDHyxM8lYRZqzdORt02UX
 fr0tINuu7BMH77TxwfGio8WDiqgriM0bFyJ3uZrMpXFOIGPvm5LWSscA7LAiUzp728vF2IFTPaV
 SnMW58+IEtRktAcbhS/m4DvryXI1+GBj8ZQBsBo/sAg==
X-Received: by 2002:aa7:9559:0:b0:5a8:cbcc:4b58 with SMTP id
 w25-20020aa79559000000b005a8cbcc4b58mr1669512pfq.12.1678937229686; 
 Wed, 15 Mar 2023 20:27:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+0MYBlNOJ1EjWFYI+3aCAZeGH+7StNpyaP/qL6fDx88yyfXpqfJL+lUPl3URKvRsQhhHnZ1Q==
X-Received: by 2002:aa7:9559:0:b0:5a8:cbcc:4b58 with SMTP id
 w25-20020aa79559000000b005a8cbcc4b58mr1669500pfq.12.1678937229315; 
 Wed, 15 Mar 2023 20:27:09 -0700 (PDT)
Received: from [10.72.12.40] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 m2-20020aa79002000000b00625c6ca32b0sm1743519pfo.213.2023.03.15.20.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Mar 2023 20:27:09 -0700 (PDT)
Message-ID: <319ece63-ac4f-db05-8a55-65ecad75e437@redhat.com>
Date: Thu, 16 Mar 2023 11:27:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/11] vdpa: Add set/get_vq_affinity callbacks in
 vdpa_config_ops
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de, 
 hch@lst.de
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230228094110.37-3-xieyongji@bytedance.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzIvMjggMTc6NDEsIFhpZSBZb25namkg5YaZ6YGTOgo+IFRoaXMgaW50cm9kdWNl
cyBzZXQvZ2V0X3ZxX2FmZmluaXR5IGNhbGxiYWNrcyBpbgo+IHZkcGFfY29uZmlnX29wcyB0byBz
dXBwb3J0IGludGVycnVwdCBhZmZpbml0eQo+IG1hbmFnZW1lbnQgZm9yIHZkcGEgZGV2aWNlIGRy
aXZlcnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNl
LmNvbT4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAyOCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgIHwgMTMgKysrKysrKysr
KysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMKPiBpbmRleCBkN2Y1YWY2MmRkYWEuLmY3MjY5NmI0YzFjMiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3ZkcGEuYwo+IEBAIC0zMzcsNiArMzM3LDMyIEBAIHN0YXRpYyBjb25zdCBjaGFyICp2aXJ0aW9f
dmRwYV9idXNfbmFtZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiAgIAlyZXR1cm4gZGV2
X25hbWUoJnZkcGEtPmRldik7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aXJ0aW9fdmRwYV9z
ZXRfdnFfYWZmaW5pdHkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkgICAgICAgY29uc3Qg
c3RydWN0IGNwdW1hc2sgKmNwdV9tYXNrKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydGlvX3ZkcGFfZGV2
aWNlICp2ZF9kZXYgPSB0b192aXJ0aW9fdmRwYV9kZXZpY2UodnEtPnZkZXYpOwo+ICsJc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhID0gdmRfZGV2LT52ZHBhOwo+ICsJY29uc3Qgc3RydWN0IHZkcGFf
Y29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ICsJdW5zaWduZWQgaW50IGluZGV4ID0g
dnEtPmluZGV4Owo+ICsKPiArCWlmIChvcHMtPnNldF92cV9hZmZpbml0eSkKPiArCQlyZXR1cm4g
b3BzLT5zZXRfdnFfYWZmaW5pdHkodmRwYSwgaW5kZXgsIGNwdV9tYXNrKTsKPiArCj4gKwlyZXR1
cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjcHVtYXNrICoKPiArdmlydGlv
X3ZkcGFfZ2V0X3ZxX2FmZmluaXR5KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBpbnQgaW5k
ZXgpCj4gK3sKPiArCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZkZXYp
Owo+ICsJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+
ICsKPiArCWlmIChvcHMtPmdldF92cV9hZmZpbml0eSkKPiArCQlyZXR1cm4gb3BzLT5nZXRfdnFf
YWZmaW5pdHkodmRwYSwgaW5kZXgpOwo+ICsKPiArCXJldHVybiBOVUxMOwo+ICt9Cj4gKwo+ICAg
c3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB2aXJ0aW9fdmRwYV9jb25maWdf
b3BzID0gewo+ICAgCS5nZXQJCT0gdmlydGlvX3ZkcGFfZ2V0LAo+ICAgCS5zZXQJCT0gdmlydGlv
X3ZkcGFfc2V0LAo+IEBAIC0zNDksNiArMzc1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2aXJ0
aW9fY29uZmlnX29wcyB2aXJ0aW9fdmRwYV9jb25maWdfb3BzID0gewo+ICAgCS5nZXRfZmVhdHVy
ZXMJPSB2aXJ0aW9fdmRwYV9nZXRfZmVhdHVyZXMsCj4gICAJLmZpbmFsaXplX2ZlYXR1cmVzID0g
dmlydGlvX3ZkcGFfZmluYWxpemVfZmVhdHVyZXMsCj4gICAJLmJ1c19uYW1lCT0gdmlydGlvX3Zk
cGFfYnVzX25hbWUsCj4gKwkuc2V0X3ZxX2FmZmluaXR5ID0gdmlydGlvX3ZkcGFfc2V0X3ZxX2Fm
ZmluaXR5LAo+ICsJLmdldF92cV9hZmZpbml0eSA9IHZpcnRpb192ZHBhX2dldF92cV9hZmZpbml0
eSwKPiAgIH07Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZpcnRpb192ZHBhX3JlbGVhc2VfZGV2KHN0
cnVjdCBkZXZpY2UgKl9kKQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4gaW5kZXggNDNmNTllZjEwY2M5Li5kNjFmMzY5ZjljZDYgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+IEBAIC0yNTAsNiArMjUwLDE1IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPiAgICAq
CQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ICAgICoJCQkJUmV0dXJucyB0aGUgaW92YSByYW5nZSBz
dXBwb3J0ZWQgYnkKPiAgICAqCQkJCXRoZSBkZXZpY2UuCj4gKyAqIEBzZXRfdnFfYWZmaW5pdHk6
CQlTZXQgdGhlIGlycSBhZmZpbml0eSBvZiB2aXJ0cXVldWUgKG9wdGlvbmFsKQoKCk5pdDogaXQn
cyBiZXR0ZXIgbm90IG1lbnRpb24gSVJRIGhlcmUgYmVjYXVzZSB0aGUgdmlydHF1ZXVlIG5vdGlm
aWNhdGlvbiAKaXMgbm90IG5lY2Vzc2FyaWx5IGJhY2tlZCBvbiBJUlEuCgpUaGFua3MKCgo+ICsg
KgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiArICoJCQkJQGlkeDogdmlydHF1ZXVlIGluZGV4Cj4g
KyAqCQkJCUBjcHVfbWFzazogaXJxIGFmZmluaXR5IG1hc2sKPiArICoJCQkJUmV0dXJucyBpbnRl
Z2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+ICsgKiBAZ2V0X3ZxX2FmZmluaXR5OgkJ
R2V0IHRoZSBpcnEgYWZmaW5pdHkgb2YgdmlydHF1ZXVlIChvcHRpb25hbCkKPiArICoJCQkJQHZk
ZXY6IHZkcGEgZGV2aWNlCj4gKyAqCQkJCUBpZHg6IHZpcnRxdWV1ZSBpbmRleAo+ICsgKgkJCQlS
ZXR1cm5zIHRoZSBpcnEgYWZmaW5pdHkgbWFzawo+ICAgICogQHNldF9ncm91cF9hc2lkOgkJU2V0
IGFkZHJlc3Mgc3BhY2UgaWRlbnRpZmllciBmb3IgYQo+ICAgICoJCQkJdmlydHF1ZXVlIGdyb3Vw
IChvcHRpb25hbCkKPiAgICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+IEBAIC0zNDAsNiArMzQ5
LDEwIEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ICAgCQkJICAgY29uc3Qgdm9pZCAqYnVm
LCB1bnNpZ25lZCBpbnQgbGVuKTsKPiAgIAl1MzIgKCpnZXRfZ2VuZXJhdGlvbikoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2KTsKPiAgIAlzdHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlICgqZ2V0X2lvdmFf
cmFuZ2UpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4gKwlpbnQgKCpzZXRfdnFfYWZmaW5p
dHkpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwKPiArCQkJICAgICAgIGNvbnN0
IHN0cnVjdCBjcHVtYXNrICpjcHVfbWFzayk7Cj4gKwljb25zdCBzdHJ1Y3QgY3B1bWFzayAqKCpn
ZXRfdnFfYWZmaW5pdHkpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwKPiArCQkJCQkJIHUxNiBp
ZHgpOwo+ICAgCj4gICAJLyogRE1BIG9wcyAqLwo+ICAgCWludCAoKnNldF9tYXApKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFzaWQsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
