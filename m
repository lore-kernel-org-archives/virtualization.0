Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78555C77B73
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 03:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09F6781E6E;
	Wed, 26 Apr 2023 03:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09F6781E6E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EcyEqvuM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aWJBTWeGGU0c; Wed, 26 Apr 2023 03:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 65E3881AAB;
	Wed, 26 Apr 2023 03:39:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65E3881AAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45048C0037;
	Wed, 26 Apr 2023 03:39:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06881C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C224881E6E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C224881E6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jntn-eBk13yI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:39:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58CB381AAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58CB381AAB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682480391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W48aKc20cD3fFOixLKXrMrZR4FXqog+onZdHHEJAi0A=;
 b=EcyEqvuMmW4xgxKeuxXKUlq00/DjbS7sBoyU0WXYGe5MlDdiPWX+VMg3RBb3eebWjewO7S
 Klre0utrSn7XSDyHf743PwpFQN7ZxnLwHtqJNlM/dIxVsTH1BuBklU6fu3ujpZg1+nGTqu
 +z5Z8gR/GRJcaLD1aQQzP5HiMBSAihE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-opPVBEiXOu6s-4qgmS1kwg-1; Tue, 25 Apr 2023 23:39:49 -0400
X-MC-Unique: opPVBEiXOu6s-4qgmS1kwg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-63b679e4c09so4600824b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 20:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682480388; x=1685072388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W48aKc20cD3fFOixLKXrMrZR4FXqog+onZdHHEJAi0A=;
 b=k0xzCls/8xnjMkC7EZtGFwJuTc3hcuQjtHz+kz4lsuAso6b4j8+pjIpgdHnFiWH2JL
 VBp2GLw5CvvF+e8XX7cQqQcZ3ZWk5KGTVg62R10l/Cj71rnIzw765i3/HOYkKk/oW2q9
 /ycJbg5qlQ9OSM0sUHGh2rcHvepAM+sHBQpRiuJOCt7fPtelJPF9pCY1h8ZZAy6GXqJA
 94EisihcYE0/039XFLNyXZ8cfkwtlRfBAsM39P9lLWP9QC75prTKQDnvTFgJ3VwpVWI4
 0P22qsgHMyf3jT0qHC3dZijrPVLvVkBDVzbIM0Za0HL9g3I8qQmIKA8ovmoTBeAV6lEQ
 AjdQ==
X-Gm-Message-State: AAQBX9fOmiVlWj56Zpz9Ti64DRybso5yv+FWsVjd4Mc9VjdYXWCqJTfg
 2WEAAcBU9thZ1e1whpZkFazm3/Qi8Dr94q1uZxLn1T1MMV/KJlXBV6reL1aMAGM5Id/A3ZZdyi5
 UyOPchhoJlE55WlxFBSDdZX690T/u8/8FEC2M7sYKaQ==
X-Received: by 2002:a05:6a00:230b:b0:63b:7954:987c with SMTP id
 h11-20020a056a00230b00b0063b7954987cmr27656499pfh.13.1682480388693; 
 Tue, 25 Apr 2023 20:39:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVXn2o2D0AofsPkejOnbv6TX3cpRAwvRwNw7ZTRn/fhbb0fuJ1R2J+ulk/+dRAzOZFfASraw==
X-Received: by 2002:a05:6a00:230b:b0:63b:7954:987c with SMTP id
 h11-20020a056a00230b00b0063b7954987cmr27656478pfh.13.1682480388365; 
 Tue, 25 Apr 2023 20:39:48 -0700 (PDT)
Received: from [10.72.13.54] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a056a0014ce00b0063ba9108c5csm10393568pfu.149.2023.04.25.20.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Apr 2023 20:39:47 -0700 (PDT)
Message-ID: <26414cc1-c713-eb11-17c4-64f7b77f26d4@redhat.com>
Date: Wed, 26 Apr 2023 11:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] virt queue ops take immediate actions
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230331204854.20082-2-lingshan.zhu@intel.com>
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

CuWcqCAyMDIzLzQvMSAwNDo0OCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBJbiB0aGlzIGNvbW1p
dCwgdmlydHF1ZXVlIG9wZXJhdGlvbnMgaW5jbHVkaW5nOgo+IHNldF92cV9udW0oKSwgc2V0X3Zx
X2FkZHJlc3MoKSwgc2V0X3ZxX3JlYWR5KCkKPiBhbmQgZ2V0X3ZxX3JlYWR5KCkgYWNjZXNzIFBD
SSByZWdpc3RlcnMgZGlyZWN0bHkKPiB0byB0YWtlIGltbWVkaWF0ZSBhY3Rpb25zLgo+Cj4gU2ln
bmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDU4ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDEw
ICsrKy0tLQo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDE2ICsrKy0tLS0t
LQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAzOSBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+IGluZGV4IDU1NjNiM2E3NzNjNy4uNmM1NjUwZjcz
MDA3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gQEAgLTMyOSwzMSArMzI5LDQ5IEBA
IGludCBpZmN2Zl9zZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTE2
IG51bSkKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW50IGlmY3ZmX2h3X2Vu
YWJsZShzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICt2b2lkIGlmY3ZmX3NldF92cV9udW0oc3RydWN0
IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTMyIG51bSkKPiAgIHsKPiAtCXN0cnVjdCB2aXJ0aW9f
cGNpX2NvbW1vbl9jZmcgX19pb21lbSAqY2ZnOwo+IC0JdTMyIGk7Cj4gKwlzdHJ1Y3QgdmlydGlv
X3BjaV9jb21tb25fY2ZnIF9faW9tZW0gKmNmZyA9IGh3LT5jb21tb25fY2ZnOwo+ICAgCj4gLQlj
ZmcgPSBody0+Y29tbW9uX2NmZzsKPiAtCWZvciAoaSA9IDA7IGkgPCBody0+bnJfdnJpbmc7IGkr
Kykgewo+IC0JCWlmICghaHctPnZyaW5nW2ldLnJlYWR5KQo+IC0JCQlicmVhazsKPiArCXZwX2lv
d3JpdGUxNihxaWQsICZjZmctPnF1ZXVlX3NlbGVjdCk7Cj4gKwl2cF9pb3dyaXRlMTYobnVtLCAm
Y2ZnLT5xdWV1ZV9zaXplKTsKPiArfQo+ICAgCj4gLQkJdnBfaW93cml0ZTE2KGksICZjZmctPnF1
ZXVlX3NlbGVjdCk7Cj4gLQkJdnBfaW93cml0ZTY0X3R3b3BhcnQoaHctPnZyaW5nW2ldLmRlc2Ms
ICZjZmctPnF1ZXVlX2Rlc2NfbG8sCj4gLQkJCQkgICAgICZjZmctPnF1ZXVlX2Rlc2NfaGkpOwo+
IC0JCXZwX2lvd3JpdGU2NF90d29wYXJ0KGh3LT52cmluZ1tpXS5hdmFpbCwgJmNmZy0+cXVldWVf
YXZhaWxfbG8sCj4gLQkJCQkgICAgICAmY2ZnLT5xdWV1ZV9hdmFpbF9oaSk7Cj4gLQkJdnBfaW93
cml0ZTY0X3R3b3BhcnQoaHctPnZyaW5nW2ldLnVzZWQsICZjZmctPnF1ZXVlX3VzZWRfbG8sCj4g
LQkJCQkgICAgICZjZmctPnF1ZXVlX3VzZWRfaGkpOwo+IC0JCXZwX2lvd3JpdGUxNihody0+dnJp
bmdbaV0uc2l6ZSwgJmNmZy0+cXVldWVfc2l6ZSk7Cj4gLQkJaWZjdmZfc2V0X3ZxX3N0YXRlKGh3
LCBpLCBody0+dnJpbmdbaV0ubGFzdF9hdmFpbF9pZHgpOwo+IC0JCXZwX2lvd3JpdGUxNigxLCAm
Y2ZnLT5xdWV1ZV9lbmFibGUpOwo+IC0JfQo+ICtpbnQgaWZjdmZfc2V0X3ZxX2FkZHJlc3Moc3Ry
dWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTY0IGRlc2NfYXJlYSwKPiArCQkJIHU2NCBkcml2
ZXJfYXJlYSwgdTY0IGRldmljZV9hcmVhKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9jb21t
b25fY2ZnIF9faW9tZW0gKmNmZyA9IGh3LT5jb21tb25fY2ZnOwo+ICsKPiArCXZwX2lvd3JpdGUx
NihxaWQsICZjZmctPnF1ZXVlX3NlbGVjdCk7Cj4gKwl2cF9pb3dyaXRlNjRfdHdvcGFydChkZXNj
X2FyZWEsICZjZmctPnF1ZXVlX2Rlc2NfbG8sCj4gKwkJCSAgICAgJmNmZy0+cXVldWVfZGVzY19o
aSk7Cj4gKwl2cF9pb3dyaXRlNjRfdHdvcGFydChkcml2ZXJfYXJlYSwgJmNmZy0+cXVldWVfYXZh
aWxfbG8sCj4gKwkJCSAgICAgJmNmZy0+cXVldWVfYXZhaWxfaGkpOwo+ICsJdnBfaW93cml0ZTY0
X3R3b3BhcnQoZGV2aWNlX2FyZWEsICZjZmctPnF1ZXVlX3VzZWRfbG8sCj4gKwkJCSAgICAgJmNm
Zy0+cXVldWVfdXNlZF9oaSk7Cj4gICAKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtib29s
IGlmY3ZmX2dldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKQo+ICt7Cj4g
KwlzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIF9faW9tZW0gKmNmZyA9IGh3LT5jb21tb25f
Y2ZnOwo+ICsJdTE2IHF1ZXVlX2VuYWJsZTsKPiArCj4gKwl2cF9pb3dyaXRlMTYocWlkLCAmY2Zn
LT5xdWV1ZV9zZWxlY3QpOwo+ICsJcXVldWVfZW5hYmxlID0gdnBfaW9yZWFkMTYoJmNmZy0+cXVl
dWVfZW5hYmxlKTsKPiArCj4gKwlyZXR1cm4gKGJvb2wpcXVldWVfZW5hYmxlOwo+ICt9Cj4gKwo+
ICt2b2lkIGlmY3ZmX3NldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCBi
b29sIHJlYWR5KQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIF9faW9tZW0g
KmNmZyA9IGh3LT5jb21tb25fY2ZnOwo+ICsKPiArCXZwX2lvd3JpdGUxNihxaWQsICZjZmctPnF1
ZXVlX3NlbGVjdCk7Cj4gKwl2cF9pb3dyaXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2VuYWJsZSk7
Cj4gK30KPiArCj4gICBzdGF0aWMgdm9pZCBpZmN2Zl9od19kaXNhYmxlKHN0cnVjdCBpZmN2Zl9o
dyAqaHcpCj4gICB7Cj4gICAJdTMyIGk7Cj4gQEAgLTM2NiwxNiArMzg0LDEyIEBAIHN0YXRpYyB2
b2lkIGlmY3ZmX2h3X2Rpc2FibGUoc3RydWN0IGlmY3ZmX2h3ICpodykKPiAgIAo+ICAgaW50IGlm
Y3ZmX3N0YXJ0X2h3KHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gICB7Cj4gLQlpZmN2Zl9yZXNldCho
dyk7CgoKVGhpcyBzZWVtcyB1bnJlbGF0ZWQgdG8gdGhlIGltbWVkaWF0ZSBhY3Rpb25zPwoKVGhl
IHJlc3QgbG9va3MgZ29vZC4KClRoYW5rcwoKCj4gICAJaWZjdmZfYWRkX3N0YXR1cyhodywgVklS
VElPX0NPTkZJR19TX0FDS05PV0xFREdFKTsKPiAgIAlpZmN2Zl9hZGRfc3RhdHVzKGh3LCBWSVJU
SU9fQ09ORklHX1NfRFJJVkVSKTsKPiAgIAo+ICAgCWlmIChpZmN2Zl9jb25maWdfZmVhdHVyZXMo
aHcpIDwgMCkKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAtCWlmIChpZmN2Zl9od19lbmFi
bGUoaHcpIDwgMCkKPiAtCQlyZXR1cm4gLUVJTlZBTDsKPiAtCj4gICAJaWZjdmZfYWRkX3N0YXR1
cyhodywgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSyk7Cj4gICAKPiAgIAlyZXR1cm4gMDsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBpbmRleCBjMjBkMWM0MDIxNGUuLmQ1NDVhOTQxMTE0MyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gKysrIGIvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IEBAIC00NywxMiArNDcsNyBAQAo+ICAgI2Rl
ZmluZSBNU0lYX1ZFQ1RPUl9ERVZfU0hBUkVECQkJMwo+ICAgCj4gICBzdHJ1Y3QgdnJpbmdfaW5m
byB7Cj4gLQl1NjQgZGVzYzsKPiAtCXU2NCBhdmFpbDsKPiAtCXU2NCB1c2VkOwo+IC0JdTE2IHNp
emU7Cj4gICAJdTE2IGxhc3RfYXZhaWxfaWR4Owo+IC0JYm9vbCByZWFkeTsKPiAgIAl2b2lkIF9f
aW9tZW0gKm5vdGlmeV9hZGRyOwo+ICAgCXBoeXNfYWRkcl90IG5vdGlmeV9wYTsKPiAgIAl1MzIg
aXJxOwo+IEBAIC0xMzcsNCArMTMyLDkgQEAgaW50IGlmY3ZmX3Byb2JlZF92aXJ0aW9fbmV0KHN0
cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgdTMyIGlmY3ZmX2dldF9jb25maWdfc2l6ZShzdHJ1Y3Qg
aWZjdmZfaHcgKmh3KTsKPiAgIHUxNiBpZmN2Zl9zZXRfdnFfdmVjdG9yKHN0cnVjdCBpZmN2Zl9o
dyAqaHcsIHUxNiBxaWQsIGludCB2ZWN0b3IpOwo+ICAgdTE2IGlmY3ZmX3NldF9jb25maWdfdmVj
dG9yKHN0cnVjdCBpZmN2Zl9odyAqaHcsIGludCB2ZWN0b3IpOwo+ICt2b2lkIGlmY3ZmX3NldF92
cV9udW0oc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTMyIG51bSk7Cj4gK2ludCBpZmN2
Zl9zZXRfdnFfYWRkcmVzcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCB1NjQgZGVzY19h
cmVhLAo+ICsJCQkgdTY0IGRyaXZlcl9hcmVhLCB1NjQgZGV2aWNlX2FyZWEpOwo+ICtib29sIGlm
Y3ZmX2dldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKTsKPiArdm9pZCBp
ZmN2Zl9zZXRfdnFfcmVhZHkoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgYm9vbCByZWFk
eSk7Cj4gICAjZW5kaWYgLyogX0lGQ1ZGX0hfICovCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
aW5kZXggN2Y3OGM0N2U0MGQ2Li4xMzU3YzY3MDE0YWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMKPiBAQCAtMzgyLDEwICszODIsNiBAQCBzdGF0aWMgdm9pZCBpZmN2Zl9yZXNldF92cmlu
ZyhzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcikKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkg
PCB2Zi0+bnJfdnJpbmc7IGkrKykgewo+ICAgCQl2Zi0+dnJpbmdbaV0ubGFzdF9hdmFpbF9pZHgg
PSAwOwo+IC0JCXZmLT52cmluZ1tpXS5kZXNjID0gMDsKPiAtCQl2Zi0+dnJpbmdbaV0uYXZhaWwg
PSAwOwo+IC0JCXZmLT52cmluZ1tpXS51c2VkID0gMDsKPiAtCQl2Zi0+dnJpbmdbaV0ucmVhZHkg
PSAwOwo+ICAgCQl2Zi0+dnJpbmdbaV0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+ICAgCQl2Zi0+dnJp
bmdbaV0uY2IucHJpdmF0ZSA9IE5VTEw7Cj4gICAJfQo+IEBAIC01NDIsMTQgKzUzOCwxNCBAQCBz
dGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF92cV9yZWFkeShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2LAo+ICAgewo+ICAgCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPiAgIAo+IC0JdmYtPnZyaW5nW3FpZF0ucmVhZHkgPSByZWFkeTsKPiArCWlmY3ZmX3Nl
dF92cV9yZWFkeSh2ZiwgcWlkLCByZWFkeSk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBib29sIGlm
Y3ZmX3ZkcGFfZ2V0X3ZxX3JlYWR5KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUxNiBx
aWQpCj4gICB7Cj4gICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYp
Owo+ICAgCj4gLQlyZXR1cm4gdmYtPnZyaW5nW3FpZF0ucmVhZHk7Cj4gKwlyZXR1cm4gaWZjdmZf
Z2V0X3ZxX3JlYWR5KHZmLCBxaWQpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBpZmN2Zl92
ZHBhX3NldF92cV9udW0oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTE2IHFpZCwKPiBA
QCAtNTU3LDcgKzU1Myw3IEBAIHN0YXRpYyB2b2lkIGlmY3ZmX3ZkcGFfc2V0X3ZxX251bShzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1MTYgcWlkLAo+ICAgewo+ICAgCXN0cnVjdCBpZmN2
Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPiAgIAo+IC0JdmYtPnZyaW5nW3FpZF0u
c2l6ZSA9IG51bTsKPiArCWlmY3ZmX3NldF92cV9udW0odmYsIHFpZCwgbnVtKTsKPiAgIH0KPiAg
IAo+ICAgc3RhdGljIGludCBpZmN2Zl92ZHBhX3NldF92cV9hZGRyZXNzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYV9kZXYsIHUxNiBxaWQsCj4gQEAgLTU2NiwxMSArNTYyLDcgQEAgc3RhdGljIGlu
dCBpZmN2Zl92ZHBhX3NldF92cV9hZGRyZXNzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYs
IHUxNiBxaWQsCj4gICB7Cj4gICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRw
YV9kZXYpOwo+ICAgCj4gLQl2Zi0+dnJpbmdbcWlkXS5kZXNjID0gZGVzY19hcmVhOwo+IC0JdmYt
PnZyaW5nW3FpZF0uYXZhaWwgPSBkcml2ZXJfYXJlYTsKPiAtCXZmLT52cmluZ1txaWRdLnVzZWQg
PSBkZXZpY2VfYXJlYTsKPiAtCj4gLQlyZXR1cm4gMDsKPiArCXJldHVybiBpZmN2Zl9zZXRfdnFf
YWRkcmVzcyh2ZiwgcWlkLCBkZXNjX2FyZWEsIGRyaXZlcl9hcmVhLCBkZXZpY2VfYXJlYSk7Cj4g
ICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIGlmY3ZmX3ZkcGFfa2lja192cShzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkcGFfZGV2LCB1MTYgcWlkKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
