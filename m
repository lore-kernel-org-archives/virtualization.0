Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC35C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 06:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 374B68435F;
	Tue, 22 Mar 2022 06:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6_ULyJ8QDFBN; Tue, 22 Mar 2022 06:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C04C84350;
	Tue, 22 Mar 2022 06:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71AEEC001A;
	Tue, 22 Mar 2022 06:30:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A93AC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40239611B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jwq7RTPPDxI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0679C60E39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647930638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Swgde3XGNHCqeVj+vrP9qoHKUX+tOSBU6QaU2X3s7ZM=;
 b=XfrT1M2AtSRFLqV0V6FNsuMErE0MeD7f+AjjbkyQaurEdHdV9GM5oGZBoIfQyt1r+PiZjZ
 r0YqJyd1A5IoIJZbCQt4uXX1fEEmcoQThlK/cuvRULE4MdjNEm6/K/M7ZxVtACS5x75PjN
 ytoW+tGRclSeWwDT2oHmfJshF16pknM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-mrcWyb5CM6qzfm4mzBnTEA-1; Tue, 22 Mar 2022 02:30:37 -0400
X-MC-Unique: mrcWyb5CM6qzfm4mzBnTEA-1
Received: by mail-pg1-f199.google.com with SMTP id
 b18-20020a63d812000000b0037e1aa59c0bso8342036pgh.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 23:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Swgde3XGNHCqeVj+vrP9qoHKUX+tOSBU6QaU2X3s7ZM=;
 b=6dgdz49p6zEXWUGMYeEvawXa00iCaqf+Dhzqu3YHLisNC6Kc+vzBVZyggOmM1sWRF2
 9g5kXJt/jzLLyk1q/d3S1zR9faCgx25zBbG2rtZQ2KfEi4VZishepNDuw7RUScAyK+9v
 hlRxgkTcefb62DkcPp3wR7nqez9aXcR5vN5nZO22QWHH4dQNtI+4qTJ2/p6izSZHw4zb
 LYqknjy/8EHQmIZoUBCMWwShkb8BFDeU0/JNWbDZyiUIJIh5PZeyRfTTFDCevZUUGbH0
 OS4Uz1R/ZhqYlHX6KSI7pVFjf9icPnlsrTMT/U8FVm2lQXHoDIDFPTMB15FXj6Umpnnx
 elqg==
X-Gm-Message-State: AOAM532vR6AEAdlIDToQOwsuWzxNM53Qz/sUTkaMkYMuTHHl+C/ZdAav
 DmoydoCMX98kgSXLPleknFZ1G9EccNzNR4DCv0hFG5+qn4U0Zg47FkFP+Z1Sxzm+JgEoL7Qv81T
 O/Yi4nPi5WiFd22/Rocgz3bMXLa0lNxx6W4lG1tC63Q==
X-Received: by 2002:a17:903:2351:b0:154:5ab7:873d with SMTP id
 c17-20020a170903235100b001545ab7873dmr8616907plh.57.1647930636051; 
 Mon, 21 Mar 2022 23:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFjayBzaX/ZWM6489owuvixGsCKIIcZTCYue0XFptT0Djo28Z2qBA5xoHwb03smpMs96JGVg==
X-Received: by 2002:a17:903:2351:b0:154:5ab7:873d with SMTP id
 c17-20020a170903235100b001545ab7873dmr8616889plh.57.1647930635699; 
 Mon, 21 Mar 2022 23:30:35 -0700 (PDT)
Received: from [10.72.13.61] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a639a11000000b0038160e4a2f7sm17391047pge.48.2022.03.21.23.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 23:30:34 -0700 (PDT)
Message-ID: <a75ecf24-6d00-b790-4da8-602205381b1d@redhat.com>
Date: Tue, 22 Mar 2022 14:30:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 10/16] virtio_ring: split: implement
 virtqueue_resize_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzMvMTQg5LiL5Y2INTozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiB2aXJ0aW8gcmlu
ZyBzcGxpdCBzdXBwb3J0cyByZXNpemUuCj4KPiBPbmx5IGFmdGVyIHRoZSBuZXcgdnJpbmcgaXMg
c3VjY2Vzc2Z1bGx5IGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUgbmV3IG51bSwKPiB3ZSB3aWxsIHJl
bGVhc2UgdGhlIG9sZCB2cmluZy4gSW4gYW55IGNhc2UsIGFuIGVycm9yIGlzIHJldHVybmVkLAo+
IGluZGljYXRpbmcgdGhhdCB0aGUgdnJpbmcgc3RpbGwgcG9pbnRzIHRvIHRoZSBvbGQgdnJpbmcu
IEluIHRoZSBjYXNlIG9mCj4gYW4gZXJyb3IsIHdlIHdpbGwgcmUtaW5pdGlhbGl6ZSB0aGUgc3Rh
dGUgb2YgdGhlIHZyaW5nIHRvIGVuc3VyZSB0aGF0Cj4gdGhlIHZyaW5nIGNhbiBiZSB1c2VkLgo+
Cj4gSW4gYWRkaXRpb24sIHZyaW5nX2FsaWduLCBtYXlfcmVkdWNlX251bSBhcmUgbmVjZXNzYXJ5
IGZvciByZWFsbG9jYXRpbmcKPiB2cmluZywgc28gdGhleSBhcmUgcmV0YWluZWQgZm9yIGNyZWF0
aW5nIHZxLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2MiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA2MiBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCA4MWJiZmQ2NTQxMWUuLmEx
NTg2OTUxNDE0NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0xMzksNiArMTM5LDEyIEBA
IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgCQkJLyogRE1BIGFkZHJlc3MgYW5kIHNpemUg
aW5mb3JtYXRpb24gKi8KPiAgIAkJCWRtYV9hZGRyX3QgcXVldWVfZG1hX2FkZHI7Cj4gICAJCQlz
aXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCj4gKwkJCS8qIFRoZSBwYXJhbWV0ZXJzIGZv
ciBjcmVhdGluZyB2cmluZ3MgYXJlIHJlc2VydmVkIGZvcgo+ICsJCQkgKiBjcmVhdGluZyBuZXcg
dnJpbmdzIHdoZW4gZW5hYmxpbmcgcmVzZXQgcXVldWUuCj4gKwkJCSAqLwo+ICsJCQl1MzIgdnJp
bmdfYWxpZ247Cj4gKwkJCWJvb2wgbWF5X3JlZHVjZV9udW07Cj4gICAJCX0gc3BsaXQ7Cj4gICAK
PiAgIAkJLyogQXZhaWxhYmxlIGZvciBwYWNrZWQgcmluZyAqLwo+IEBAIC0xOTgsNiArMjA0LDE2
IEBAIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ICAgI2VuZGlmCj4gICB9Owo+ICAgCj4gK3N0
YXRpYyB2b2lkIF9fdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+ICtzdGF0aWMg
dm9pZCBfX3ZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxLAo+ICsJCQkJCSBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4gK3N0YXRpYyB2b2lk
IF9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2
cSwKPiArCQkJCQkgICBzdHJ1Y3QgdnJpbmcgdnJpbmcsCj4gKwkJCQkJICAgc3RydWN0IHZyaW5n
X2Rlc2Nfc3RhdGVfc3BsaXQgKmRlc2Nfc3RhdGUsCj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rl
c2NfZXh0cmEgKmRlc2NfZXh0cmEpOwo+ICtzdGF0aWMgaW50IF9fdnJpbmdfYWxsb2Nfc3RhdGVf
ZXh0cmFfc3BsaXQodTMyIG51bSwKPiArCQkJCQkgICBzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9z
cGxpdCAqKmRlc2Nfc3RhdGUsCj4gKwkJCQkJICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKipk
ZXNjX2V4dHJhKTsKPiAgIAo+ICAgLyoKPiAgICAqIEhlbHBlcnMuCj4gQEAgLTk5MSw2ICsxMDA3
LDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3Bs
aXQoCj4gICAJCXJldHVybiBOVUxMOwo+ICAgCX0KPiAgIAo+ICsJdG9fdnZxKHZxKS0+c3BsaXQu
dnJpbmdfYWxpZ24gPSB2cmluZ19hbGlnbjsKPiArCXRvX3Z2cSh2cSktPnNwbGl0Lm1heV9yZWR1
Y2VfbnVtID0gbWF5X3JlZHVjZV9udW07Cj4gICAJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1h
X2FkZHIgPSBkbWFfYWRkcjsKPiAgIAl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5
dGVzID0gcXVldWVfc2l6ZV9pbl9ieXRlczsKPiAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9
IHRydWU7Cj4gQEAgLTk5OCw2ICsxMDE2LDUwIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2
cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCXJldHVybiB2cTsKPiAgIH0KPiAgIAo+
ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNpemVfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3Zx
LCB1MzIgbnVtKQo+ICt7Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShf
dnEpOwo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4gKwlzdHJ1
Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCAqc3RhdGU7Cj4gKwlzdHJ1Y3QgdnJpbmdfZGVzY19l
eHRyYSAqZXh0cmE7Cj4gKwlzaXplX3QgcXVldWVfc2l6ZV9pbl9ieXRlczsKPiArCWRtYV9hZGRy
X3QgZG1hX2FkZHI7Cj4gKwlzdHJ1Y3QgdnJpbmcgdnJpbmc7Cj4gKwlpbnQgZXJyID0gLUVOT01F
TTsKPiArCXZvaWQgKnF1ZXVlOwo+ICsKPiArCUJVR19PTighdnEtPndlX293bl9yaW5nKTsKCgpJ
IGRvbid0IHNlZSBhbnkgY2hlY2tzIGluIHZpcnRxdWV1ZV9yZXNpemUoKS4gU28gSSB0aGluayBp
dCdzIGJldHRlciB0byAKZWl0aGVyCgoxKSByZXR1cm4gLUVJTlZBTCBoZXJlCgpvcgoKMikgYWRk
IGEgY2hlY2sgaW4gdmlydHF1ZXVlX3Jlc2l6ZSBhbmQgZmFpbCB0aGVyZQoKCj4gKwo+ICsJcXVl
dWUgPSB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCh2ZGV2LCAmZG1hX2FkZHIsICZudW0sCj4gKwkJ
CQkJdnEtPnNwbGl0LnZyaW5nX2FsaWduLAo+ICsJCQkJCXZxLT53ZWFrX2JhcnJpZXJzLAo+ICsJ
CQkJCXZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAoIXF1ZXVlKQo+ICsJCWdvdG8g
aW5pdDsKPiArCj4gKwlxdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmdfc2l6ZShudW0sIHZxLT5z
cGxpdC52cmluZ19hbGlnbik7Cj4gKwo+ICsJZXJyID0gX192cmluZ19hbGxvY19zdGF0ZV9leHRy
YV9zcGxpdChudW0sICZzdGF0ZSwgJmV4dHJhKTsKPiArCWlmIChlcnIpIHsKPiArCQl2cmluZ19m
cmVlX3F1ZXVlKHZkZXYsIHF1ZXVlX3NpemVfaW5fYnl0ZXMsIHF1ZXVlLCBkbWFfYWRkcik7Cj4g
KwkJZ290byBpbml0Owo+ICsJfQo+ICsKPiArCV9fdnJpbmdfZnJlZSgmdnEtPnZxKTsKPiArCj4g
Kwl2cmluZ19pbml0KCZ2cmluZywgbnVtLCBxdWV1ZSwgdnEtPnNwbGl0LnZyaW5nX2FsaWduKTsK
PiArCV9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdCh2cSwgdnJpbmcsIHN0YXRlLCBleHRy
YSk7CgoKSSB3b25kZXIgaWYgd2UgbmVlZCBhIHN5bW1ldHJpYyB2aXJ0cXVldWVfcmVzaXplX2Rl
dGFjaCgpIGludGVybmFsIGhlbHBlci4KCgo+ICsJdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0g
ZG1hX2FkZHI7Cj4gKwl2cS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHF1ZXVlX3NpemVf
aW5fYnl0ZXM7Cj4gKwo+ICsJZXJyID0gMDsKPiArCj4gK2luaXQ6Cj4gKwlfX3ZyaW5nX3ZpcnRx
dWV1ZV9pbml0X3NwbGl0KHZxLCB2ZGV2KTsKPiArCXZxLT53ZV9vd25fcmluZyA9IHRydWU7CgoK
VGhlbiB3ZSBjYW4gbGVhdmUgdGhpcyB1bmNoYW5nZWQuCgpUaGFua3MKCgo+ICsJcmV0dXJuIGVy
cjsKPiArfQo+ICsKPiAgIAo+ICAgLyoKPiAgICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0
aW9ucyAtICpfcGFja2VkKCkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
