Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDDCC433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 06:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3612A827F0;
	Mon, 14 Mar 2022 06:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-eGL71Ys__K; Mon, 14 Mar 2022 06:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC209827D9;
	Mon, 14 Mar 2022 06:04:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91A46C001D;
	Mon, 14 Mar 2022 06:04:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D2E2C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D18E60BE2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0S6y4VKPMVh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:04:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F97C60BDA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647237847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XWjbqYvqLIcliuu04CPptAo3wxpLIB8KYTjyLRm6Co=;
 b=b957BwVgMAX529zRUk62js2uw9oTrwCMyhYNP4vOjryb4a4DiXEHpVf9+y1UCdsUIqVwq0
 1syFwW34/qvcEwj+Kkl4XvoPBQys5+7ti0/sE8Ul1xXZUxT2ImgXSv9krM9F+F4pIoKJpz
 4PD3aVSvEOYs3M03oRvcq1w2dzH5Glw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-RzAER585MkCDB8ElI94Axg-1; Mon, 14 Mar 2022 02:04:05 -0400
X-MC-Unique: RzAER585MkCDB8ElI94Axg-1
Received: by mail-pg1-f198.google.com with SMTP id
 r11-20020a63440b000000b0038068f34b0cso9447050pga.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Mar 2022 23:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2XWjbqYvqLIcliuu04CPptAo3wxpLIB8KYTjyLRm6Co=;
 b=xckbuZwVdiIdS5z6M9kuIjG9Ydu76iRnJpx6paGM9uXA80t0+MCtWMh17n18UwVRlu
 JFUBZOidF/rpaurgW8nh0QFIktim8UBkfqy300QRhkj2g+t052iPaJCw50Ym5FpIEeHN
 JQ6g5ntRLq9U4yI8+NpKjmdKXHQkBpc3/knJzaQHe0nd1m0hvyxgex5pZRxyPSCrd6xl
 goYLCXNlLQNdBJTSAQ8oRbum6wUQDIpFkpVKU0vCkkiKrw43kGHRCPS2GrkjTbdkcKG3
 d3T+VBzb/t/811rj8POYMy3/eUUNuK5+xIJPGVXqv/RVYg/JmpDFrZV+Vwi4C35cXTOb
 7rHw==
X-Gm-Message-State: AOAM532m+pERxov9D7y607tHO8yG6nbSnsk1V8vxLT3D7hHcxwTpjfUB
 TiDV1PoTdID+0Y01cGzSvP3INrASJOTvSvJkVsA5Ky8k919lztRq0bwpl0dNfru/JVtYOzLN45T
 P5Wo0o0TP+6puElMQ7huzHjvLpiCTaGeHOjBPH5A98Q==
X-Received: by 2002:a63:7e43:0:b0:374:75ce:4d80 with SMTP id
 o3-20020a637e43000000b0037475ce4d80mr18764266pgn.589.1647237844690; 
 Sun, 13 Mar 2022 23:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO7HvxYfUJ+fU3+y7Rq7dQeKdgwueK3KHb/k4WgR6BCnKo7nRgyKt6rA8fOZWbZufNvs0EAQ==
X-Received: by 2002:a63:7e43:0:b0:374:75ce:4d80 with SMTP id
 o3-20020a637e43000000b0037475ce4d80mr18764244pgn.589.1647237844397; 
 Sun, 13 Mar 2022 23:04:04 -0700 (PDT)
Received: from [10.72.13.210] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t8-20020aa79468000000b004f764340d8bsm17045588pfq.92.2022.03.13.23.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 23:04:03 -0700 (PDT)
Message-ID: <7f7553d0-2217-6122-227a-a3bfd5706ac5@redhat.com>
Date: Mon, 14 Mar 2022 14:03:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] vdpa: support exposing the count of vqs to
 userspace
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com,
 sgarzare@redhat.com, stefanha@redhat.com
References: <20220310072051.2175-1-longpeng2@huawei.com>
 <20220310072051.2175-3-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220310072051.2175-3-longpeng2@huawei.com>
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
IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPgo+IC0gR0VUX1ZRU19DT1VOVDogdGhl
IGNvdW50IG9mIHZpcnRxdWV1ZXMgdGhhdCBleHBvc2VkCj4KPiBBbmQgY2hhbmdlIHZkcGFfZGV2
aWNlLm52cXMgYW5kIHZob3N0X3ZkcGEubnZxcyB0byB1c2UgdTMyLgoKClBhdGNoIGxvb2tzIGdv
b2QsIGEgbml0IGlzIHRoYXQgd2UnZCBiZXR0ZXIgdXNlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRo
ZSAKdTMyIGNvbnZlcnRpbmcuCgpUaGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogTG9uZ3Blbmcg
PGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAg
ICAgfCAgNiArKystLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgIHwgMjMgKysrKysr
KysrKysrKysrKysrKy0tLS0KPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgIHwgIDYgKysr
LS0tCj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCB8ICAzICsrKwo+ICAgNCBmaWxlcyBj
aGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IGluZGV4IDFlYTUy
NTQuLjJiNzVjMDAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS92ZHBhLmMKPiBAQCAtMjMyLDcgKzIzMiw3IEBAIHN0YXRpYyBpbnQgdmRwYV9u
YW1lX21hdGNoKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgdm9pZCAqZGF0YSkKPiAgIAlyZXR1
cm4gKHN0cmNtcChkZXZfbmFtZSgmdmRldi0+ZGV2KSwgZGF0YSkgPT0gMCk7Cj4gICB9Cj4gICAK
PiAtc3RhdGljIGludCBfX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgaW50IG52cXMpCj4gK3N0YXRpYyBpbnQgX192ZHBhX3JlZ2lzdGVyX2RldmljZShzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUzMiBudnFzKQo+ICAgewo+ICAgCXN0cnVjdCBkZXZpY2Ug
KmRldjsKPiAgIAo+IEBAIC0yNTcsNyArMjU3LDcgQEAgc3RhdGljIGludCBfX3ZkcGFfcmVnaXN0
ZXJfZGV2aWNlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgaW50IG52cXMpCj4gICAgKgo+ICAg
ICogUmV0dXJuOiBSZXR1cm5zIGFuIGVycm9yIHdoZW4gZmFpbCB0byBhZGQgZGV2aWNlIHRvIHZE
UEEgYnVzCj4gICAgKi8KPiAtaW50IF92ZHBhX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkZXYsIGludCBudnFzKQo+ICtpbnQgX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTMyIG52cXMpCj4gICB7Cj4gICAJaWYgKCF2ZGV2LT5tZGV2
KQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiBAQCAtMjc0LDcgKzI3NCw3IEBAIGludCBfdmRwYV9y
ZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBpbnQgbnZxcykKPiAgICAq
Cj4gICAgKiBSZXR1cm46IFJldHVybnMgYW4gZXJyb3Igd2hlbiBmYWlsIHRvIGFkZCB0byB2RFBB
IGJ1cwo+ICAgICovCj4gLWludCB2ZHBhX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIGludCBudnFzKQo+ICtpbnQgdmRwYV9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1MzIgbnZxcykKPiAgIHsKPiAgIAlpbnQgZXJyOwo+ICAgCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBp
bmRleCA2MDVjN2FlLi42OWIzZjA1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtNDIsNyArNDIsNyBAQCBzdHJ1Y3Qg
dmhvc3RfdmRwYSB7Cj4gICAJc3RydWN0IGRldmljZSBkZXY7Cj4gICAJc3RydWN0IGNkZXYgY2Rl
djsKPiAgIAlhdG9taWNfdCBvcGVuZWQ7Cj4gLQlpbnQgbnZxczsKPiArCXUzMiBudnFzOwo+ICAg
CWludCB2aXJ0aW9faWQ7Cj4gICAJaW50IG1pbm9yOwo+ICAgCXN0cnVjdCBldmVudGZkX2N0eCAq
Y29uZmlnX2N0eDsKPiBAQCAtMTU4LDcgKzE1OCw4IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
c2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAg
CXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gICAJY29uc3Qgc3RydWN0IHZk
cGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ICAgCXU4IHN0YXR1cywgc3RhdHVz
X29sZDsKPiAtCWludCByZXQsIG52cXMgPSB2LT5udnFzOwo+ICsJdTMyIG52cXMgPSB2LT5udnFz
Owo+ICsJaW50IHJldDsKPiAgIAl1MTYgaTsKPiAgIAo+ICAgCWlmIChjb3B5X2Zyb21fdXNlcigm
c3RhdHVzLCBzdGF0dXNwLCBzaXplb2Yoc3RhdHVzKSkpCj4gQEAgLTM2OSw2ICszNzAsMTYgQEAg
c3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfY29uZmlnX3NpemUoc3RydWN0IHZob3N0X3ZkcGEg
KnYsIHUzMiBfX3VzZXIgKmFyZ3ApCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiArc3RhdGlj
IGxvbmcgdmhvc3RfdmRwYV9nZXRfdnFzX2NvdW50KHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIg
X191c2VyICphcmdwKQo+ICt7Cj4gKwlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBh
Owo+ICsKPiArCWlmIChjb3B5X3RvX3VzZXIoYXJncCwgJnZkcGEtPm52cXMsIHNpemVvZih2ZHBh
LT5udnFzKSkpCj4gKwkJcmV0dXJuIC1FRkFVTFQ7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiAr
Cj4gICBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgCQkJCSAgIHZvaWQgX191c2VyICphcmdwKQo+ICAg
ewo+IEBAIC01MDksNiArNTIwLDkgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9p
b2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gICAJY2FzZSBWSE9TVF9WRFBBX0dFVF9DT05GSUdf
U0laRToKPiAgIAkJciA9IHZob3N0X3ZkcGFfZ2V0X2NvbmZpZ19zaXplKHYsIGFyZ3ApOwo+ICAg
CQlicmVhazsKPiArCWNhc2UgVkhPU1RfVkRQQV9HRVRfVlFTX0NPVU5UOgo+ICsJCXIgPSB2aG9z
dF92ZHBhX2dldF92cXNfY291bnQodiwgYXJncCk7Cj4gKwkJYnJlYWs7Cj4gICAJZGVmYXVsdDoK
PiAgIAkJciA9IHZob3N0X2Rldl9pb2N0bCgmdi0+dmRldiwgY21kLCBhcmdwKTsKPiAgIAkJaWYg
KHIgPT0gLUVOT0lPQ1RMQ01EKQo+IEBAIC05NjUsNyArOTc5LDggQEAgc3RhdGljIGludCB2aG9z
dF92ZHBhX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+ICAg
CXN0cnVjdCB2aG9zdF92ZHBhICp2Owo+ICAgCXN0cnVjdCB2aG9zdF9kZXYgKmRldjsKPiAgIAlz
dHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICoqdnFzOwo+IC0JaW50IG52cXMsIGksIHIsIG9wZW5lZDsK
PiArCWludCByLCBvcGVuZWQ7Cj4gKwl1MzIgaSwgbnZxczsKPiAgIAo+ICAgCXYgPSBjb250YWlu
ZXJfb2YoaW5vZGUtPmlfY2Rldiwgc3RydWN0IHZob3N0X3ZkcGEsIGNkZXYpOwo+ICAgCj4gQEAg
LTEwMTgsNyArMTAzMyw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9vcGVuKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmhvc3Rf
dmRwYV9jbGVhbl9pcnEoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gICB7Cj4gLQlpbnQgaTsKPiAr
CXUzMiBpOwo+ICAgCj4gICAJZm9yIChpID0gMDsgaSA8IHYtPm52cXM7IGkrKykKPiAgIAkJdmhv
c3RfdmRwYV91bnNldHVwX3ZxX2lycSh2LCBpKTsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IGluZGV4IGE1MjY5MTkuLjg5NDNhMjAg
MTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4
L3ZkcGEuaAo+IEBAIC04Myw3ICs4Myw3IEBAIHN0cnVjdCB2ZHBhX2RldmljZSB7Cj4gICAJdW5z
aWduZWQgaW50IGluZGV4Owo+ICAgCWJvb2wgZmVhdHVyZXNfdmFsaWQ7Cj4gICAJYm9vbCB1c2Vf
dmE7Cj4gLQlpbnQgbnZxczsKPiArCXUzMiBudnFzOwo+ICAgCXN0cnVjdCB2ZHBhX21nbXRfZGV2
ICptZGV2Owo+ICAgfTsKPiAgIAo+IEBAIC0zMzgsMTAgKzMzOCwxMCBAQCBzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKl9fdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IGRldmljZSAqcGFyZW50LAo+ICAgCQkJ
CSAgICAgICBkZXZfc3RydWN0LCBtZW1iZXIpKSwgbmFtZSwgdXNlX3ZhKSwgXAo+ICAgCQkJCSAg
ICAgICBkZXZfc3RydWN0LCBtZW1iZXIpCj4gICAKPiAtaW50IHZkcGFfcmVnaXN0ZXJfZGV2aWNl
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgaW50IG52cXMpOwo+ICtpbnQgdmRwYV9yZWdpc3Rl
cl9kZXZpY2Uoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MzIgbnZxcyk7Cj4gICB2b2lkIHZk
cGFfdW5yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPiAgIAo+IC1p
bnQgX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgaW50IG52
cXMpOwo+ICtpbnQgX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdTMyIG52cXMpOwo+ICAgdm9pZCBfdmRwYV91bnJlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYpOwo+ICAgCj4gICAvKioKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+IGluZGV4IGJjNzRl
OTUuLjVkOTllN2MgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmgKPiAr
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+IEBAIC0xNTQsNCArMTU0LDcgQEAKPiAg
IC8qIEdldCB0aGUgY29uZmlnIHNpemUgKi8KPiAgICNkZWZpbmUgVkhPU1RfVkRQQV9HRVRfQ09O
RklHX1NJWkUJX0lPUihWSE9TVF9WSVJUSU8sIDB4NzksIF9fdTMyKQo+ICAgCj4gKy8qIEdldCB0
aGUgY291bnQgb2YgYWxsIHZpcnRxdWV1ZXMgKi8KPiArI2RlZmluZSBWSE9TVF9WRFBBX0dFVF9W
UVNfQ09VTlQJX0lPUihWSE9TVF9WSVJUSU8sIDB4ODAsIF9fdTMyKQo+ICsKPiAgICNlbmRpZgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
