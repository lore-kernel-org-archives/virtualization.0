Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB39C4321E
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 07:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01DF760D55;
	Wed,  9 Mar 2022 07:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KxyCMvm5wguo; Wed,  9 Mar 2022 07:51:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7917C60D4E;
	Wed,  9 Mar 2022 07:51:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52440C001D;
	Wed,  9 Mar 2022 07:51:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2DA8C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A104460D4E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsQZb2gf3Dr2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:51:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB702606EC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646812296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EooiEDUIiNqsLqksX/5gFpvlfrwnXfbsnSG7xyKFRM=;
 b=hNK1RfRLODPTnqeWOLM64QckM1ELf/KRJ9fgqTVeieFX7lDs2p0G900CTjPEI9s02hhmbt
 Lg0U7IFqu/51HZ9a7nT43c/KmlCeup8oefYX+1kDLWAsvdqmtW4nH+chOJkAooXHeiC5Kz
 3n+cRBpoJT2aS2y/usoFGkY1uQLGulg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-r3xk9e2IPSOv8AtYRbMvpw-1; Wed, 09 Mar 2022 02:51:35 -0500
X-MC-Unique: r3xk9e2IPSOv8AtYRbMvpw-1
Received: by mail-pj1-f72.google.com with SMTP id
 c14-20020a17090a674e00b001bf1c750f9bso3292221pjm.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 23:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8EooiEDUIiNqsLqksX/5gFpvlfrwnXfbsnSG7xyKFRM=;
 b=aX+uPvsJp/X3h1wgfC4iSylipsYWPiBTdIkM6mxuaUGL5nQWgNfGObjmWdMRAhCe85
 ExsxozrUh7CgNo3XBLrcD9uab9+CjYiyXiQIjuSGR0S77Faun9Z9l/R496/kiv5HrKjO
 R+HuKbx9Y2VbOw1SPeP/Pg6i+zGv47ZAVmaqRJz7+mzsUW9pRHQhi+iKOrTFv65GmYmu
 cApDP58ReuhbnixwCG8r1cVLaxGC82evx0SMSdIudmoYrgalVifwLzuex3Box2nQe6Lr
 0gUQALAZ5eDgWPJCp1Ozuh/Yd2Burl9tseMszVTPqIskCeRHC5ut5qTb06JngcfmtPAr
 nb2A==
X-Gm-Message-State: AOAM532jaCTI5x2HoX9fcua30yIYBbWc1pTIuXBRdCP1G6mK7Sna8FJs
 w+lEUq+sq6G53xpmV1+hpVg/D5b/JvX/1gsOjN2ng9jKjqksslrw5OVhnyWIrRlbZLahljmQhCW
 FV6p+/zjpUh/7ADel8BNcXyDdjkgJ0jpTU2SpAEU4tg==
X-Received: by 2002:a05:6a00:1aca:b0:4e1:a2b6:5b9 with SMTP id
 f10-20020a056a001aca00b004e1a2b605b9mr22032667pfv.4.1646812294750; 
 Tue, 08 Mar 2022 23:51:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7Di4SBo0vIcLZV8aD0YrzixtPGak4ozbl1xizUy139HXfoBpN9nPz+x4ygNPWdbKEaJoHaw==
X-Received: by 2002:a05:6a00:1aca:b0:4e1:a2b6:5b9 with SMTP id
 f10-20020a056a001aca00b004e1a2b605b9mr22032623pfv.4.1646812294417; 
 Tue, 08 Mar 2022 23:51:34 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a63ff50000000b003650ee901e1sm1468074pgk.68.2022.03.08.23.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 23:51:33 -0800 (PST)
Message-ID: <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
Date: Wed, 9 Mar 2022 15:51:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IEludHJvZHVjZSB2
cmluZ19mcmVlKCkgdG8gZnJlZSB0aGUgdnJpbmcgb2YgdnEuCj4KPiBQcmV2ZW50IGRvdWJsZSBm
cmVlIGJ5IHNldHRpbmcgdnEtPnJlc2V0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4
dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKy0tLS0tCj4gICBpbmNsdWRlL2xpbnV4
L3ZpcnRpby5oICAgICAgIHwgIDggKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGI1
YTliZjRmNDViMy4uZTA0MjJjMDRjOTAzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTI0
NDIsMTQgKzI0NDIsMTAgQEAgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1
bnNpZ25lZCBpbnQgaW5kZXgsCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19uZXdf
dmlydHF1ZXVlKTsKPiAgIAo+IC12b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRx
dWV1ZSAqX3ZxKQo+ICtzdGF0aWMgdm9pZCBfX3ZyaW5nX2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxKQo+ICAgewo+ICAgCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7
Cj4gICAKPiAtCXNwaW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+IC0JbGlz
dF9kZWwoJl92cS0+bGlzdCk7Cj4gLQlzcGluX3VubG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0
X2xvY2spOwo+IC0KPiAgIAlpZiAodnEtPndlX293bl9yaW5nKSB7Cj4gICAJCWlmICh2cS0+cGFj
a2VkX3JpbmcpIHsKPiAgIAkJCXZyaW5nX2ZyZWVfcXVldWUodnEtPnZxLnZkZXYsCj4gQEAgLTI0
ODAsNiArMjQ3NiwyNSBAQCB2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxKQo+ICAgCQlrZnJlZSh2cS0+c3BsaXQuZGVzY19zdGF0ZSk7Cj4gICAJCWtmcmVlKHZx
LT5zcGxpdC5kZXNjX2V4dHJhKTsKPiAgIAl9Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHZyaW5n
X2ZyZWUoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCV9fdnJpbmdfZnJlZSh2cSk7Cj4g
Kwl2cS0+cmVzZXQgPSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9WUklOR19SRUxFQVNFOwo+ICt9Cj4g
Kwo+ICt2b2lkIHZyaW5nX2RlbF92aXJ0cXVldWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICt7
Cj4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsKPiArCXNw
aW5fbG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+ICsJbGlzdF9kZWwoJl92cS0+
bGlzdCk7Cj4gKwlzcGluX3VubG9jaygmdnEtPnZxLnZkZXYtPnZxc19saXN0X2xvY2spOwo+ICsK
PiArCWlmIChfdnEtPnJlc2V0ICE9IFZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX1JFTEVBU0Up
Cj4gKwkJX192cmluZ19mcmVlKF92cSk7Cj4gKwo+ICAgCWtmcmVlKHZxKTsKPiAgIH0KPiAgIEVY
UE9SVF9TWU1CT0xfR1BMKHZyaW5nX2RlbF92aXJ0cXVldWUpOwo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGQ1OWFk
YzRiZTA2OC4uZTM3MTRlNmRiMzMwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTEwLDYgKzEwLDEzIEBACj4g
ICAjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+Cj4gICAjaW5jbHVkZSA8bGludXgv
Z2ZwLmg+Cj4gICAKPiArZW51bSB2aXJ0aW9fdnFfcmVzZXRfc3RlcCB7Cj4gKwlWSVJUSU9fVlFf
UkVTRVRfU1RFUF9OT05FLAo+ICsJVklSVElPX1ZRX1JFU0VUX1NURVBfREVWSUNFLAo+ICsJVklS
VElPX1ZRX1JFU0VUX1NURVBfVlJJTkdfUkVMRUFTRSwKPiArCVZJUlRJT19WUV9SRVNFVF9TVEVQ
X1ZSSU5HX0FUVEFDSCwKPiArfTsKCgpUaGlzIHBhcnQgbG9va3Mgbm90IHJlbGF0ZWQgdG8gdGhl
IHN1YmplY3QuCgpBbmQgaXQgbmVlZHMgZGV0YWlsIGRvY3VtZW50YXRpb24gb24gdGhpcy4KCkJ1
dCBJIHdvbmRlciBob3cgdXNlZnVsIGl0IGlzLCBhbnl3YXkgd2UgY2FuIGNoZWNrIHRoZSByZXNl
dCBzdGF0dXMgdmlhIAp0cmFuc3BvcnQgc3BlY2lmaWMgd2F5IGFuZCBpbiB0aGUgZnV0dXJlIHdl
IG1heSB3YW50IHRvIGRvIG1vcmUgdGhhbiAKanVzdCByZXNpemluZyAoZS5nIFBBU0lEKS4KClRo
YW5rcwoKCj4gKwo+ICAgLyoqCj4gICAgKiB2aXJ0cXVldWUgLSBhIHF1ZXVlIHRvIHJlZ2lzdGVy
IGJ1ZmZlcnMgZm9yIHNlbmRpbmcgb3IgcmVjZWl2aW5nLgo+ICAgICogQGxpc3Q6IHRoZSBjaGFp
biBvZiB2aXJ0cXVldWVzIGZvciB0aGlzIGRldmljZQo+IEBAIC0zMyw2ICs0MCw3IEBAIHN0cnVj
dCB2aXJ0cXVldWUgewo+ICAgCXVuc2lnbmVkIGludCBudW1fZnJlZTsKPiAgIAl1bnNpZ25lZCBp
bnQgbnVtX21heDsKPiAgIAl2b2lkICpwcml2Owo+ICsJZW51bSB2aXJ0aW9fdnFfcmVzZXRfc3Rl
cCByZXNldDsKPiAgIH07Cj4gICAKPiAgIGludCB2aXJ0cXVldWVfYWRkX291dGJ1ZihzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
