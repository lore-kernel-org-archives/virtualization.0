Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E3DC7618E
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 05:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95CFB40A8A;
	Wed, 26 Apr 2023 05:07:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95CFB40A8A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLRc2AE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fj3lDmXXoXxf; Wed, 26 Apr 2023 05:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 788F4400B8;
	Wed, 26 Apr 2023 05:07:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 788F4400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B49FC0036;
	Wed, 26 Apr 2023 05:07:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E98E0C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC7D241BD8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:07:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC7D241BD8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLRc2AE0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wJDMP1Bm4YQX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:07:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBFF741B6A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBFF741B6A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 05:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682485618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2oNgu35pBeiYjIuFa/xpRg0cGsI21omnVM8gGLLtzw=;
 b=RLRc2AE0ZGGi+V2Emj+31Jk3ziGmRigiE6QfZyi3VayqlwcBvU1WIeHBcX7E1rSvZSBTze
 AHM5cTHlsapzwSfx8nJm06fNZkRry67ij65VgnC5/Gzno5WkUbqnKkqBJzoZKCb/6omYr1
 GJ6Dkl5gy6mshzhNAykHG8IKVNFHbRE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325--6lFQXhSPOqnL7amLQWddg-1; Wed, 26 Apr 2023 01:06:56 -0400
X-MC-Unique: -6lFQXhSPOqnL7amLQWddg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-640f5191c79so4455131b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 22:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682485616; x=1685077616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2oNgu35pBeiYjIuFa/xpRg0cGsI21omnVM8gGLLtzw=;
 b=B+aMq35nZF/jdOetnLTkeOE2QO6dc+wksB/Jhqn5zKGlHwggdzwlkV4gMjuWv3mT2H
 Np+2TIc90rgVmRP2+Aw7VY7JiufsbAQ9W5RTW7snHk9bKbWWwphEvz23LX0Yo8ulsc4W
 mQaxEVl4q5lNPfDzd0MFggYHPhj39ZDvDb3FilaEpvz9AFVC73UxuyuhZiQ1JtDqB86Q
 xHiFEkYS0fNevsAlqhrna5ya6wcMjXZPRrbXbcoGM96ebw8/tAaeQmSdTzSwIrVoOaKS
 T73zMitGiiGHtkCCnIj9wUuCIAMxfL8L/a212EMbqhKs7+hqcHdwbGg5AkWXVZ6A6ryZ
 WljA==
X-Gm-Message-State: AC+VfDyebpUbhcFzfIhhtUosh86latKatGNNrZcr0XaON799CtgG6tvQ
 BkeTpY8+FbEpKffq+XP1HGi6ZTeSYlJfLzAXnRTpVq3+KTPHVuyRGhZp1Enp17lphxO+gVjYQsU
 WfLGC8N2PvqZInJ4IOmHl3yHzQ/Wrq1dunrNwpWnaFg==
X-Received: by 2002:a05:6a20:2451:b0:ee:4210:6ca with SMTP id
 t17-20020a056a20245100b000ee421006camr1499912pzc.7.1682485615743; 
 Tue, 25 Apr 2023 22:06:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YHXQ2cUMLOBqK/VHbEMERyCMGzcAQPoYH1iPqmkddGevT1ZxjCBXehNb1VBh9WazBwNOAyg==
X-Received: by 2002:a05:6a20:2451:b0:ee:4210:6ca with SMTP id
 t17-20020a056a20245100b000ee421006camr1499892pzc.7.1682485615412; 
 Tue, 25 Apr 2023 22:06:55 -0700 (PDT)
Received: from [10.72.12.241] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a056a000d6900b005e0699464e3sm10151242pfv.206.2023.04.25.22.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 22:06:55 -0700 (PDT)
Message-ID: <329f4dbf-442e-2171-bad4-cceb9efd6dc7@redhat.com>
Date: Wed, 26 Apr 2023 13:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] synchronize irqs in the reset routine
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230331204854.20082-5-lingshan.zhu@intel.com>
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

CuWcqCAyMDIzLzQvMSAwNDo0OCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBUaGlzIGNvbW1pdCBz
eW5jaHJvbml6ZSBpcnFzIG9mIHRoZSB2aXJ0cXVldWVzCj4gYW5kIGNvbmZpZyBzcGFjZSBpbiB0
aGUgcmVzZXQgcm91dGluZS4KPiBUaHVzIGlmY3ZmX3N0b3BfaHcoKSBhbmQgcmVzZXQoKSBhcmUg
cmVmYWN0b3JlZCBhcyB3ZWxsLgo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuYyB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ICAgZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQ1ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+IGluZGV4IDc5ZTMxM2M1ZTEwZS4uNDk5NDlhZWMyMGVmIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiArKysgYi9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gQEAgLTE3MCwxMiArMTcwLDcgQEAgdm9pZCBp
ZmN2Zl9zZXRfc3RhdHVzKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHU4IHN0YXR1cykKPiAgIAo+ICAg
dm9pZCBpZmN2Zl9yZXNldChzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICAgewo+IC0JaHctPmNvbmZp
Z19jYi5jYWxsYmFjayA9IE5VTEw7Cj4gLQlody0+Y29uZmlnX2NiLnByaXZhdGUgPSBOVUxMOwo+
IC0KPiAgIAlpZmN2Zl9zZXRfc3RhdHVzKGh3LCAwKTsKPiAtCS8qIGZsdXNoIHNldF9zdGF0dXMs
IG1ha2Ugc3VyZSBWRiBpcyBzdG9wcGVkLCByZXNldCAqLwo+IC0JaWZjdmZfZ2V0X3N0YXR1cyho
dyk7CgoKSWYgd2UgZG9uJ3QgZmx1c2ggb3IgcG9sbCBob3cgY2FuIHdlIGtub3cgdGhlIHJlc2V0
IGlzIGRvbmU/CgpFLmcgbW9kZXJuIHZpcnRpby1wY2kgZGlkOgoKIMKgwqDCoMKgwqDCoMKgIC8q
IDAgc3RhdHVzIG1lYW5zIGEgcmVzZXQuICovCiDCoMKgIMKgwqDCoMKgIHZwX21vZGVybl9zZXRf
c3RhdHVzKG1kZXYsIDApOwogwqDCoMKgwqDCoMKgwqAgLyogQWZ0ZXIgd3JpdGluZyAwIHRvIGRl
dmljZV9zdGF0dXMsIHRoZSBkcml2ZXIgTVVTVCB3YWl0IGZvciBhIApyZWFkIG9mCiDCoMKgwqDC
oMKgwqDCoMKgICogZGV2aWNlX3N0YXR1cyB0byByZXR1cm4gMCBiZWZvcmUgcmVpbml0aWFsaXpp
bmcgdGhlIGRldmljZS4KIMKgwqDCoMKgwqDCoMKgwqAgKiBUaGlzIHdpbGwgZmx1c2ggb3V0IHRo
ZSBzdGF0dXMgd3JpdGUsIGFuZCBmbHVzaCBpbiBkZXZpY2UgCndyaXRlcywKIMKgwqDCoMKgwqDC
oMKgwqAgKiBpbmNsdWRpbmcgTVNJLVggaW50ZXJydXB0cywgaWYgYW55LgogwqDCoMKgwqDCoMKg
wqDCoCAqLwogwqDCoMKgwqDCoMKgwqAgd2hpbGUgKHZwX21vZGVybl9nZXRfc3RhdHVzKG1kZXYp
KQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zbGVlcCgxKTsKIMKgwqDCoMKgwqDC
oMKgIC8qIEZsdXNoIHBlbmRpbmcgVlEvY29uZmlndXJhdGlvbiBjYWxsYmFja3MuICovCiDCoMKg
IMKgwqDCoCB2cF9zeW5jaHJvbml6ZV92ZWN0b3JzKHZkZXYpOwoKPiAgIH0KPiAgIAo+ICAgdTY0
IGlmY3ZmX2dldF9od19mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+IEBAIC0zNjgsMjAg
KzM2Myw2MiBAQCB2b2lkIGlmY3ZmX3NldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1
MTYgcWlkLCBib29sIHJlYWR5KQo+ICAgCXZwX2lvd3JpdGUxNihyZWFkeSwgJmNmZy0+cXVldWVf
ZW5hYmxlKTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgdm9pZCBpZmN2Zl9od19kaXNhYmxlKHN0cnVj
dCBpZmN2Zl9odyAqaHcpCj4gK3N0YXRpYyB2b2lkIHN5bmNocm9uaXplX3Blcl92cV9pcnEoc3Ry
dWN0IGlmY3ZmX2h3ICpodykKPiAgIHsKPiAtCXUzMiBpOwo+ICsJdTE2IHFpZDsKPiAgIAo+IC0J
aWZjdmZfc2V0X2NvbmZpZ192ZWN0b3IoaHcsIFZJUlRJT19NU0lfTk9fVkVDVE9SKTsKPiAtCWZv
ciAoaSA9IDA7IGkgPCBody0+bnJfdnJpbmc7IGkrKykgewo+IC0JCWlmY3ZmX3NldF92cV92ZWN0
b3IoaHcsIGksIFZJUlRJT19NU0lfTk9fVkVDVE9SKTsKPiArCWZvciAocWlkID0gMDsgcWlkIDwg
aHctPm5yX3ZyaW5nOyBxaWQrKykgewo+ICsJCWlmIChody0+dnJpbmdbcWlkXS5pcnEgIT0gLUVJ
TlZBTCkKPiArCQkJc3luY2hyb25pemVfaXJxKGh3LT52cmluZ1txaWRdLmlycSk7Cj4gICAJfQo+
ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIHN5bmNocm9uaXplX3Zxc19yZXVzZWRfaXJxKHN0cnVj
dCBpZmN2Zl9odyAqaHcpCj4gK3sKPiArCWlmIChody0+dnFzX3JldXNlZF9pcnEgIT0gLUVJTlZB
TCkKPiArCQlzeW5jaHJvbml6ZV9pcnEoaHctPnZxc19yZXVzZWRfaXJxKTsKPiArfQo+ICsKPiAr
c3RhdGljIHZvaWQgc3luY2hyb25pemVfdnFfaXJxKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gK3sK
PiArCXU4IHN0YXR1cyA9IGh3LT5tc2l4X3ZlY3Rvcl9zdGF0dXM7Cj4gKwo+ICsJaWYgKHN0YXR1
cyA9PSBNU0lYX1ZFQ1RPUl9QRVJfVlFfQU5EX0NPTkZJRykKPiArCQlzeW5jaHJvbml6ZV9wZXJf
dnFfaXJxKGh3KTsKPiArCWVsc2UKPiArCQlzeW5jaHJvbml6ZV92cXNfcmV1c2VkX2lycShodyk7
Cj4gK30KCgpJIHdvbmRlciBpZiB3ZSBuZWVkIHRvIGdvIHdpdGggc3VjaCBjb21wbGljYXRlZCB3
YXlzLGNhbiB3ZSBzeW5jaHJvbml6ZSAKdGhyb3VnaCB0aGUgdmVjdG9ycyBsaWtlIHZpcnRpby1w
Y2kgZGlkPwoKIMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCB2cF9kZXYtPm1zaXhfdmVj
dG9yczsgKytpKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN5bmNocm9uaXplX2ly
cShwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYsIGkpKTsKPwoKCj4gKwo+ICtzdGF0aWMg
dm9pZCBzeW5jaHJvbml6ZV9jb25maWdfaXJxKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gK3sKPiAr
CWlmIChody0+Y29uZmlnX2lycSAhPSAtRUlOVkFMKQo+ICsJCXN5bmNocm9uaXplX2lycShody0+
Y29uZmlnX2lycSk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGlmY3ZmX3Jlc2V0X3ZyaW5nKHN0
cnVjdCBpZmN2Zl9odyAqaHcpCj4gK3sKPiArCXUxNiBxaWQ7Cj4gKwo+ICsJZm9yIChxaWQgPSAw
OyBxaWQgPCBody0+bnJfdnJpbmc7IHFpZCsrKSB7Cj4gKwkJc3luY2hyb25pemVfdnFfaXJxKGh3
KTsKClNpbmNlIElSUSBjb3VsZCBiZSBzaGFyZWQsIHRoaXMgd2lsbCByZXN1bHQgZXh0cmEgY29t
cGxleGl0eSwgbGlrZSBhIGlycSAKY291bGQgYmUgZmx1c2hlZCBtdWx0aXBsZSB0aW1lcz8KClRo
YW5rcwoKCj4gKwkJaHctPnZyaW5nW3FpZF0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+ICsJCWh3LT52
cmluZ1txaWRdLmNiLnByaXZhdGUgPSBOVUxMOwo+ICsJCWlmY3ZmX3NldF92cV92ZWN0b3IoaHcs
IHFpZCwgVklSVElPX01TSV9OT19WRUNUT1IpOwo+ICsJfQo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9p
ZCBpZmN2Zl9yZXNldF9jb25maWdfaGFuZGxlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICt7Cj4g
KwlzeW5jaHJvbml6ZV9jb25maWdfaXJxKGh3KTsKPiArCWh3LT5jb25maWdfY2IuY2FsbGJhY2sg
PSBOVUxMOwo+ICsJaHctPmNvbmZpZ19jYi5wcml2YXRlID0gTlVMTDsKPiArCWlmY3ZmX3NldF9j
b25maWdfdmVjdG9yKGh3LCBWSVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4gK30KPiArCj4gICB2b2lk
IGlmY3ZmX3N0b3BfaHcoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIHsKPiAtCWlmY3ZmX2h3X2Rp
c2FibGUoaHcpOwo+IC0JaWZjdmZfcmVzZXQoaHcpOwo+ICsJaWZjdmZfcmVzZXRfdnJpbmcoaHcp
Owo+ICsJaWZjdmZfcmVzZXRfY29uZmlnX2hhbmRsZXIoaHcpOwo+ICAgfQo+ICAgCj4gICB2b2lk
IGlmY3ZmX25vdGlmeV9xdWV1ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDk2ODY4NzE1OWU0NC4uMTVjNjE1N2VlODQxIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTM0NiwzMyArMzQ2LDYgQEAgc3RhdGljIGlu
dCBpZmN2Zl9yZXF1ZXN0X2lycShzdHJ1Y3QgaWZjdmZfaHcgKnZmKQo+ICAgCXJldHVybiAwOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgaWZjdmZfc3RvcF9kYXRhcGF0aChzdHJ1Y3QgaWZjdmZf
YWRhcHRlciAqYWRhcHRlcikKPiAtewo+IC0Jc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IGFkYXB0ZXIt
PnZmOwo+IC0JaW50IGk7Cj4gLQo+IC0JZm9yIChpID0gMDsgaSA8IHZmLT5ucl92cmluZzsgaSsr
KQo+IC0JCXZmLT52cmluZ1tpXS5jYi5jYWxsYmFjayA9IE5VTEw7Cj4gLQo+IC0JaWZjdmZfc3Rv
cF9odyh2Zik7Cj4gLQo+IC0JcmV0dXJuIDA7Cj4gLX0KPiAtCj4gLXN0YXRpYyB2b2lkIGlmY3Zm
X3Jlc2V0X3ZyaW5nKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+IC17Cj4gLQlzdHJ1
Y3QgaWZjdmZfaHcgKnZmID0gYWRhcHRlci0+dmY7Cj4gLQlpbnQgaTsKPiAtCj4gLQlmb3IgKGkg
PSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKyspIHsKPiAtCQl2Zi0+dnJpbmdbaV0ubGFzdF9hdmFp
bF9pZHggPSAwOwo+IC0JCXZmLT52cmluZ1tpXS5jYi5jYWxsYmFjayA9IE5VTEw7Cj4gLQkJdmYt
PnZyaW5nW2ldLmNiLnByaXZhdGUgPSBOVUxMOwo+IC0JfQo+IC0KPiAtCWlmY3ZmX3Jlc2V0KHZm
KTsKPiAtfQo+IC0KPiAgIHN0YXRpYyBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqdmRwYV90b19hZGFw
dGVyKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gICB7Cj4gICAJcmV0dXJuIGNvbnRh
aW5lcl9vZih2ZHBhX2Rldiwgc3RydWN0IGlmY3ZmX2FkYXB0ZXIsIHZkcGEpOwo+IEBAIC00NjIs
MjMgKzQzNSwxNSBAQCBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhX2RldiwgdTggc3RhdHVzKQo+ICAgCj4gICBzdGF0aWMgaW50IGlmY3Zm
X3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPiAgIHsKPiAtCXN0cnVj
dCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyOwo+IC0Jc3RydWN0IGlmY3ZmX2h3ICp2ZjsKPiAtCXU4
IHN0YXR1c19vbGQ7Cj4gLQo+IC0JdmYgID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4gLQlhZGFw
dGVyID0gdmRwYV90b19hZGFwdGVyKHZkcGFfZGV2KTsKPiAtCXN0YXR1c19vbGQgPSBpZmN2Zl9n
ZXRfc3RhdHVzKHZmKTsKPiArCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPiArCXU4IHN0YXR1cyA9IGlmY3ZmX2dldF9zdGF0dXModmYpOwo+ICAgCj4gLQlpZiAo
c3RhdHVzX29sZCA9PSAwKQo+IC0JCXJldHVybiAwOwo+ICsJaWZjdmZfc3RvcF9odyh2Zik7Cj4g
ICAKPiAtCWlmIChzdGF0dXNfb2xkICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+IC0J
CWlmY3ZmX3N0b3BfZGF0YXBhdGgoYWRhcHRlcik7Cj4gKwlpZiAoc3RhdHVzICYgVklSVElPX0NP
TkZJR19TX0RSSVZFUl9PSykKPiAgIAkJaWZjdmZfZnJlZV9pcnEodmYpOwo+IC0JfQo+ICAgCj4g
LQlpZmN2Zl9yZXNldF92cmluZyhhZGFwdGVyKTsKPiArCWlmY3ZmX3Jlc2V0KHZmKTsKPiAgIAo+
ICAgCXJldHVybiAwOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
