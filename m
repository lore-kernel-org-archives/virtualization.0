Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E06FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 03:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF2D240327;
	Wed, 20 Apr 2022 03:22:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V_qiDnG2A9Bo; Wed, 20 Apr 2022 03:21:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E87A400A4;
	Wed, 20 Apr 2022 03:21:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E614EC0033;
	Wed, 20 Apr 2022 03:21:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF778C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B82E6400CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5M4E40scD3u4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:21:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EBA0400A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 03:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650424914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4Qu9Vgv3L9GdF/GCpm7gFi/cqqJoTgTzG6l8G/JRjw=;
 b=HoJj4VyCG0/BMtlPhD4v+XoGhU/oK5mWnW8l9vZW1JaLUd7LORZ4PR94fMkJ2IV+7ll6ad
 gpi/wdJ0wQGkd50akjaU4KxLCs1KJmLCgrJOpVDb7YmNDpV6CCr3ldI9OQwSvAXktBdIpH
 s14EBVQy3ft6zL30o4V3I6rjz7L68Rg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-4LkUOla6ND-jEXikkxOmlQ-1; Tue, 19 Apr 2022 23:21:53 -0400
X-MC-Unique: 4LkUOla6ND-jEXikkxOmlQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 z18-20020a631912000000b003a392265b64so251558pgl.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 20:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=N4Qu9Vgv3L9GdF/GCpm7gFi/cqqJoTgTzG6l8G/JRjw=;
 b=M4NmY0ZFRNDpJAtnc97lRTqs23E8L8n+8Ju5ykaplubtiI0XEKEgnR56qo8YeSV8Wf
 muKzvLxD1hXX2gf7QirJpFZv8bTQhlk/UJlyLD4rl0o4rzRG3Cp4/C96DNBXDmMmYSyN
 97rWk8vcxFW56YNCl4N1MQmP6ghfhUuXFx98P/P1JrTZQsyRzYbM/fqfcsgKS4/6VMEn
 3jQ+o80rB6CpZHNBKJF1wX+WoaAKEU8EFXq+975bkApOE2vtV+2kQizvRLGgj5a+VyA2
 c0NBWfAm5gUbberWqd4M+1X9jXodQYYAnaZkle9VpK0XZE9gZRHCE2+u9o/y6nQuf7FX
 eGyg==
X-Gm-Message-State: AOAM530/JZNGGYYuCmG5mPQ5MhFBj1aDckbaS3+rsIayDk9oEUxgVp9L
 zKDsGk0PQiiE33JlWpNDIFkG6o2tuyh+8O2WnCitJ+5vov0JdgeineN7OuzwwEZeYXSw1x97jsl
 udf6qbDsP0U49ht+QSG+4ZQNz2ZxjCci4M8yklcoKgQ==
X-Received: by 2002:a17:90b:19d7:b0:1c7:3413:87e0 with SMTP id
 nm23-20020a17090b19d700b001c7341387e0mr2041633pjb.132.1650424912039; 
 Tue, 19 Apr 2022 20:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfaKG8EOIcgAODaFpfwEbTUzq+ZZbbNoh/URJ8tDm6N1qcWFB7yxMhvWAv676JwqKc5ZA6lA==
X-Received: by 2002:a17:90b:19d7:b0:1c7:3413:87e0 with SMTP id
 nm23-20020a17090b19d700b001c7341387e0mr2041616pjb.132.1650424911767; 
 Tue, 19 Apr 2022 20:21:51 -0700 (PDT)
Received: from [10.72.14.13] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a63200e000000b0039d9816238fsm17655895pgg.81.2022.04.19.20.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Apr 2022 20:21:51 -0700 (PDT)
Message-ID: <32c1113d-4991-0ab0-5a85-33fe85295b93@redhat.com>
Date: Wed, 20 Apr 2022 11:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v1] vdpa/vp_vdpa : add vdpa tool support in vp_vdpa
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux-foundation.org
References: <20220419014025.218121-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220419014025.218121-1-lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIyLzQvMTkgMDk6NDAsIENpbmR5IEx1IOWGmemBkzoKPiB0aGlzIHBhdGNoIGlzIHRv
IGFkZCB0aGUgc3VwcG9ydCBmb3IgdmRwYSB0b29sIGluIHZwX3ZkcGEKPiBoZXJlIGlzIHRoZSBl
eGFtcGxlIHN0ZXBzCj4gbW9kcHJvYmUgdnBfdmRwYQo+IG1vZHByb2JlIHZob3N0X3ZkcGEKPgo+
IGVjaG8gMDAwMDowMDowNi4wPi9zeXMvYnVzL3BjaS9kcml2ZXJzL3ZpcnRpby1wY2kvdW5iaW5k
Cj4gZWNobyAxYWY0IDEwNDEgPiAvc3lzL2J1cy9wY2kvZHJpdmVycy92cC12ZHBhL25ld19pZAo+
Cj4gdmRwYSBkZXYgYWRkIG5hbWUgdmRwYTEgbWdtdGRldiBwY2kvMDAwMDowMDowNi4wCj4KPiBT
aWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgODYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIGIv
ZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4gaW5kZXggY2NlMTAxZTZhOTQwLi5k
OGExZDJmOGU5YmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRw
YS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4gQEAgLTE3LDYg
KzE3LDggQEAKPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcmluZy5oPgo+ICAgI2luY2x1ZGUg
PGxpbnV4L3ZpcnRpb19wY2kuaD4KPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpX21vZGVy
bi5oPgo+ICsjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+Cj4gKyNpbmNsdWRlIDx1
YXBpL2xpbnV4L3ZkcGEuaD4KPiAgIAo+ICAgI2RlZmluZSBWUF9WRFBBX1FVRVVFX01BWCAyNTYK
PiAgICNkZWZpbmUgVlBfVkRQQV9EUklWRVJfTkFNRSAidnBfdmRwYSIKPiBAQCAtNDEsNiArNDMs
MTggQEAgc3RydWN0IHZwX3ZkcGEgewo+ICAgCWludCB2ZWN0b3JzOwo+ICAgfTsKPiAgIAo+ICtz
dHJ1Y3QgdnBfdmRwYV9tZ210ZGV2IHsKPiArCXN0cnVjdCB2ZHBhX21nbXRfZGV2IG1ndGRldjsK
PiArCXN0cnVjdCB2cF92ZHBhICp2cF92ZHBhOwo+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4g
K307Cj4gKwo+ICsjZGVmaW5lIFZQX1ZEUEFfTkVUX0ZFQVRVUkVTICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICsJKCgxVUxMIDw8IFZJUlRJT19G
X0FOWV9MQVlPVVQpIHwgKDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKSB8ICAgICAgICBcCj4g
KwkgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkKPiArCj4gKyNkZWZpbmUgVlBf
VkRQQV9ORVRfVlFfTlVNIDIKCgpMZXQncyBub3QgZ28gYmFja3dhcmRzLCBlLmcgd2UndmUgYWxy
ZWFkeSBzdXBwb3J0IGFueSBraW5kIG9mIHZpcnRpbyAKZGV2aWNlIHdpdGggYW55IGtpbmQgb2Yg
ZmVhdHVyZXMuIHNlZSB0aGUgY29tbWVudCBpbiB2cF92ZHBhX3Byb2JlKCkuCgoKPiArCj4gICBz
dGF0aWMgc3RydWN0IHZwX3ZkcGEgKnZkcGFfdG9fdnAoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
KQo+ICAgewo+ICAgCXJldHVybiBjb250YWluZXJfb2YodmRwYSwgc3RydWN0IHZwX3ZkcGEsIHZk
cGEpOwo+IEBAIC00NTQsOSArNDY4LDE0IEBAIHN0YXRpYyB2b2lkIHZwX3ZkcGFfZnJlZV9pcnFf
dmVjdG9ycyh2b2lkICpkYXRhKQo+ICAgCXBjaV9mcmVlX2lycV92ZWN0b3JzKGRhdGEpOwo+ICAg
fQo+ICAgCj4gLXN0YXRpYyBpbnQgdnBfdmRwYV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwg
Y29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ICtzdGF0aWMgaW50IHZwX3ZkcGFfZGV2
X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICsJ
CQkgICBjb25zdCBzdHJ1Y3QgdmRwYV9kZXZfc2V0X2NvbmZpZyAqYWRkX2NvbmZpZykKPiAgIHsK
PiArCXN0cnVjdCB2cF92ZHBhX21nbXRkZXYgKnZwX3ZkcGFfbWd0ZGV2ID0KPiArCQljb250YWlu
ZXJfb2Yodl9tZGV2LCBzdHJ1Y3QgdnBfdmRwYV9tZ210ZGV2LCBtZ3RkZXYpOwo+ICsKPiAgIAlz
dHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2Owo+ICsJc3RydWN0IHBjaV9kZXYg
KnBkZXYgPSB2cF92ZHBhX21ndGRldi0+cGRldjsKPiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAm
cGRldi0+ZGV2Owo+ICAgCXN0cnVjdCB2cF92ZHBhICp2cF92ZHBhOwo+ICAgCWludCByZXQsIGk7
Cj4gQEAgLTQ2NSw4ICs0ODQsOSBAQCBzdGF0aWMgaW50IHZwX3ZkcGFfcHJvYmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiAgIAlpZiAocmV0
KQo+ICAgCQlyZXR1cm4gcmV0Owo+ICAgCj4gLQl2cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uo
c3RydWN0IHZwX3ZkcGEsIHZkcGEsCj4gLQkJCQkgICAgZGV2LCAmdnBfdmRwYV9vcHMsIE5VTEws
IGZhbHNlKTsKPiArCXZwX3ZkcGEgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdnBfdmRwYSwg
dmRwYSwgZGV2LCAmdnBfdmRwYV9vcHMsCj4gKwkJCQkgICAgbmFtZSwgZmFsc2UpOwoKCk5pdDog
bGV0J3Mga2VlcCB0aGUgbGluZSBvZiB2ZHBhX2FsbG9jX2RldmljZSgpIHVuY2hhbmdlZCB0byBy
ZWR1Y2UgdGhlIApjaGFuZ2VzZXQuCgoKPiArCj4gICAJaWYgKElTX0VSUih2cF92ZHBhKSkgewo+
ICAgCQlkZXZfZXJyKGRldiwgInZwX3ZkcGE6IEZhaWxlZCB0byBhbGxvY2F0ZSB2RFBBIHN0cnVj
dHVyZVxuIik7Cj4gICAJCXJldHVybiBQVFJfRVJSKHZwX3ZkcGEpOwo+IEBAIC00ODAsOSArNTAw
LDEwIEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29u
c3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ICAgCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJG
YWlsZWQgdG8gcHJvYmUgbW9kZXJuIFBDSSBkZXZpY2VcbiIpOwo+ICAgCQlnb3RvIGVycjsKPiAg
IAl9Cj4gKwl2cF92ZHBhX21ndGRldi0+dnBfdmRwYSA9IHZwX3ZkcGE7Cj4gICAKPiAgIAlwY2lf
c2V0X21hc3RlcihwZGV2KTsKPiAtCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCB2cF92ZHBhKTsKPiAr
CXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCB2cF92ZHBhX21ndGRldik7Cj4gICAKPiAgIAl2cF92ZHBh
LT52ZHBhLmRtYV9kZXYgPSAmcGRldi0+ZGV2Owo+ICAgCXZwX3ZkcGEtPnF1ZXVlcyA9IHZwX21v
ZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsKPiBAQCAtNTE2LDcgKzUzNyw4IEBAIHN0YXRpYyBp
bnQgdnBfdmRwYV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9k
ZXZpY2VfaWQgKmlkKQo+ICAgCX0KPiAgIAl2cF92ZHBhLT5jb25maWdfaXJxID0gVklSVElPX01T
SV9OT19WRUNUT1I7Cj4gICAKPiAtCXJldCA9IHZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZ2cF92ZHBh
LT52ZHBhLCB2cF92ZHBhLT5xdWV1ZXMpOwo+ICsJdnBfdmRwYS0+dmRwYS5tZGV2ID0gJnZwX3Zk
cGFfbWd0ZGV2LT5tZ3RkZXY7Cj4gKwlyZXQgPSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJnZwX3Zk
cGEtPnZkcGEsIHZwX3ZkcGEtPnF1ZXVlcyk7Cj4gICAJaWYgKHJldCkgewo+ICAgCQlkZXZfZXJy
KCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgdG8gdmRwYSBidXNcbiIpOwo+ICAgCQln
b3RvIGVycjsKPiBAQCAtNTI5LDEyICs1NTEsNjAgQEAgc3RhdGljIGludCB2cF92ZHBhX3Byb2Jl
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4g
ICAJcmV0dXJuIHJldDsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgdm9pZCB2cF92ZHBhX3JlbW92ZShz
dHJ1Y3QgcGNpX2RldiAqcGRldikKPiArc3RhdGljIHZvaWQgdnBfdmRwYV9kZXZfZGVsKHN0cnVj
dCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsCj4gKwkJCSAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRl
dikKPiAgIHsKPiAtCXN0cnVjdCB2cF92ZHBhICp2cF92ZHBhID0gcGNpX2dldF9kcnZkYXRhKHBk
ZXYpOwo+ICsJc3RydWN0IHZwX3ZkcGFfbWdtdGRldiAqdnBfdmRwYV9tZ3RkZXYgPQo+ICsJCWNv
bnRhaW5lcl9vZih2X21kZXYsIHN0cnVjdCB2cF92ZHBhX21nbXRkZXYsIG1ndGRldik7Cj4gKwo+
ICsJc3RydWN0IHZwX3ZkcGEgKnZwX3ZkcGEgPSB2cF92ZHBhX21ndGRldi0+dnBfdmRwYTsKPiAg
IAo+ICAgCXZwX21vZGVybl9yZW1vdmUoJnZwX3ZkcGEtPm1kZXYpOwo+IC0JdmRwYV91bnJlZ2lz
dGVyX2RldmljZSgmdnBfdmRwYS0+dmRwYSk7Cj4gKwlfdmRwYV91bnJlZ2lzdGVyX2RldmljZSgm
dnBfdmRwYS0+dmRwYSk7Cj4gKwl2cF92ZHBhX21ndGRldi0+dnBfdmRwYSA9IE5VTEw7Cj4gK30K
PiArCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9tZ210ZGV2X29wcyB2cF92ZHBhX21kZXZf
b3BzID0gewo+ICsJLmRldl9hZGQgPSB2cF92ZHBhX2Rldl9hZGQsCj4gKwkuZGV2X2RlbCA9IHZw
X3ZkcGFfZGV2X2RlbCwKPiArfTsKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdmlydGlvX2RldmljZV9p
ZCB2cF92ZHBhX2lkX3RhYmxlW10gPSB7Cj4gKwl7IFZJUlRJT19JRF9ORVQsIFZJUlRJT19ERVZf
QU5ZX0lEIH0sCj4gKwl7IDAgfSwKPiArfTsKCgpMZXQncyBub3QgbGltaXQgdGhlIHZwX3ZkcGEg
dG8gbmV0LCBpdCBjYW4gc3VwcG9ydCBhbGwgb3RoZXIgdmlydGlvIGRldmljZXMuCgoKPiArCj4g
K3N0YXRpYyBpbnQgdnBfdmRwYV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3Ry
dWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+ICt7Cj4gKwlzdHJ1Y3QgdnBfdmRwYV9tZ210ZGV2ICp2
cF92ZHBhX21ndGRldjsKPiArCXN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZ3RkZXY7Cj4gKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Owo+ICsJaW50IGVycjsKPiArCj4gKwl2cF92ZHBh
X21ndGRldiA9IGt6YWxsb2Moc2l6ZW9mKCp2cF92ZHBhX21ndGRldiksIEdGUF9LRVJORUwpOwo+
ICsJaWYgKCF2cF92ZHBhX21ndGRldikKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCW1ndGRldiA9
ICZ2cF92ZHBhX21ndGRldi0+bWd0ZGV2Owo+ICsKPiArCW1ndGRldi0+b3BzID0gJnZwX3ZkcGFf
bWRldl9vcHM7Cj4gKwltZ3RkZXYtPmRldmljZSA9IGRldjsKPiArCW1ndGRldi0+aWRfdGFibGUg
PSB2cF92ZHBhX2lkX3RhYmxlOwo+ICsJdnBfdmRwYV9tZ3RkZXYtPnBkZXYgPSBwZGV2Owo+ICsK
PiArCW1ndGRldi0+bWF4X3N1cHBvcnRlZF92cXMgPSBWUF9WRFBBX05FVF9WUV9OVU07CgoKTGV0
J3MgcmVhZCB0aGlzIGZyb20gdGhlIGRldmljZSBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBoYXJkLWNv
ZGVkIHZhbHVlLgoKCj4gKwltZ3RkZXYtPnN1cHBvcnRlZF9mZWF0dXJlcyA9IFZQX1ZEUEFfTkVU
X0ZFQVRVUkVTOwoKCkxldCdzIHJlYWQgdGhpcyBmcm9tIHRoZSBkZXZpY2UuCgoKPiArCj4gKwll
cnIgPSB2ZHBhX21nbXRkZXZfcmVnaXN0ZXIobWd0ZGV2KTsKCgpEbyB3ZSBuZWVkIHRvIGZyZWUg
dGhlIHZwX3ZkcGFfbWd0ZGV2IGhlcmU/CgpUaGFua3MKCgo+ICsKPiArCXJldHVybiBlcnI7Cj4g
K30KPiArCj4gK3N0YXRpYyB2b2lkIHZwX3ZkcGFfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
KQo+ICt7Cj4gKwlzdHJ1Y3QgdnBfdmRwYV9tZ210ZGV2ICp2cF92ZHBhX21ndGRldiA9IHBjaV9n
ZXRfZHJ2ZGF0YShwZGV2KTsKPiArCj4gKwl2ZHBhX21nbXRkZXZfdW5yZWdpc3RlcigmdnBfdmRw
YV9tZ3RkZXYtPm1ndGRldik7Cj4gKwlrZnJlZSh2cF92ZHBhX21ndGRldik7Cj4gICB9Cj4gICAK
PiAgIHN0YXRpYyBzdHJ1Y3QgcGNpX2RyaXZlciB2cF92ZHBhX2RyaXZlciA9IHsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
