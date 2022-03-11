Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F9FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 05:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A41D419B2;
	Fri, 11 Mar 2022 05:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B982ixYQr6Xj; Fri, 11 Mar 2022 05:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 964D34193F;
	Fri, 11 Mar 2022 05:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74568C0012;
	Fri, 11 Mar 2022 05:01:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E71BC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75F1D612C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1dXmpNwbLi9U
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7961060783
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 05:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646974897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClxhKYkVRI4wjgf/neqah0SebFq73Qnvze+JfcOkoWE=;
 b=IQq9HaLTepJW2VIKqYDuNySk2pG46XpUS+Fz8bU1QjaegPbnoMbBBH9RPVo4ux2iD5iH/8
 zOcj8/aZzTUwJCszU+oKR37vn3mbkdRmdc2uFuuPWk3gLgnP61PfedPZDAjzgsI3TrPzVv
 UT+y9Syhkl7KHJdth20CtDw1mNRasu8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-eO8_KwcEPr-jhzq8N98Jdw-1; Fri, 11 Mar 2022 00:01:36 -0500
X-MC-Unique: eO8_KwcEPr-jhzq8N98Jdw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d145-20020a621d97000000b004f7285f67e8so4559210pfd.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 21:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ClxhKYkVRI4wjgf/neqah0SebFq73Qnvze+JfcOkoWE=;
 b=SbdIYSvU85NPLSkT2OxXpc7DqU1H+ynsGjM1ebivXP11w0SBRUWEcuBku78huDPKi6
 VpX62ZJ5G4gGLsTZhLsmaZ2mDYhIZ0VCeWS6M6cPY8oqoCynlHcMORo6y5i7ucR6sq6z
 Eqz3BRfWAcpONPDSXryjejnr3gEs+LW43CliW+8Faegz9TdhqnsTD2iFrCno3xKaCF6T
 sux1bO+pVn/kka12p0FdHHY3kJpyDgO3wc8hjdYbFeoZUOCEjFR/UTAQwLrOLo76y7id
 8oOffyxobLfnnxW2h3BWlgsNp3/5BpRZd8DFvoirl6gTuxq2Qe6+LK2NETETJP2DqSkj
 rEHw==
X-Gm-Message-State: AOAM532yG8kLpkraZQ5uyMGw03nqX5d/SWNd48A5toSzU+CNN3Icy8KQ
 OU/RZ6AiD+7Qgy/5kNlp7lb8nBwiy2LQw8yS+tdjKy+Nw4XM6ccEK/UMSEdLym+MlIvzDK11BUL
 vjhrVOlxYDNYD8KYPsU5T6IB9NfezvGNbBdiXwWMmVQ==
X-Received: by 2002:a17:903:2287:b0:151:dab2:aacc with SMTP id
 b7-20020a170903228700b00151dab2aaccmr8931086plh.64.1646974894655; 
 Thu, 10 Mar 2022 21:01:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjhAHibdrN+PAZOgUOITJB4K7Do8Ys0otdg7SyrCfQr2FG1PKdSe+p69caWpelZLkCRgx01w==
X-Received: by 2002:a17:903:2287:b0:151:dab2:aacc with SMTP id
 b7-20020a170903228700b00151dab2aaccmr8931038plh.64.1646974894266; 
 Thu, 10 Mar 2022 21:01:34 -0800 (PST)
Received: from [10.72.13.226] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a17090aa38600b001bce781ce03sm7437875pjp.18.2022.03.10.21.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 21:01:33 -0800 (PST)
Message-ID: <cd774778-6cdc-9ebe-141c-1f47ad1c3109@redhat.com>
Date: Fri, 11 Mar 2022 13:01:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
 <512de020-b36e-8473-69c8-8b3925fbb6c1@redhat.com>
 <1646887597.810321-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1646887597.810321-1-xuanzhuo@linux.alibaba.com>
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
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
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

CuWcqCAyMDIyLzMvMTAg5LiL5Y2IMTI6NDYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gT24gV2VkLCA5
IE1hciAyMDIyIDE1OjU1OjQ0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4g5ZyoIDIwMjIvMy84IOS4i+WNiDg6MzUsIFh1YW4gWmh1byDlhpnpgZM6Cj4+
PiB2aXJ0aW8gcmluZyBzdXBwb3J0cyByZXNldC4KPj4+Cj4+PiBRdWV1ZSByZXNldCBpcyBkaXZp
ZGVkIGludG8gc2V2ZXJhbCBzdGFnZXMuCj4+Pgo+Pj4gMS4gbm90aWZ5IGRldmljZSBxdWV1ZSBy
ZXNldAo+Pj4gMi4gdnJpbmcgcmVsZWFzZQo+Pj4gMy4gYXR0YWNoIG5ldyB2cmluZwo+Pj4gNC4g
bm90aWZ5IGRldmljZSBxdWV1ZSByZS1lbmFibGUKPj4+Cj4+PiBBZnRlciB0aGUgZmlyc3Qgc3Rl
cCBpcyBjb21wbGV0ZWQsIHRoZSB2cmluZyByZXNldCBvcGVyYXRpb24gY2FuIGJlCj4+PiBwZXJm
b3JtZWQuIElmIHRoZSBuZXdseSBzZXQgdnJpbmcgbnVtIGRvZXMgbm90IGNoYW5nZSwgdGhlbiBq
dXN0IHJlc2V0Cj4+PiB0aGUgdnEgcmVsYXRlZCB2YWx1ZS4KPj4+Cj4+PiBPdGhlcndpc2UsIHRo
ZSB2cmluZyB3aWxsIGJlIHJlbGVhc2VkIGFuZCB0aGUgdnJpbmcgd2lsbCBiZSByZWFsbG9jYXRl
ZC4KPj4+IEFuZCB0aGUgdnJpbmcgd2lsbCBiZSBhdHRhY2hlZCB0byB0aGUgdnEuIElmIHRoaXMg
cHJvY2VzcyBmYWlscywgdGhlCj4+PiBmdW5jdGlvbiB3aWxsIGV4aXQsIGFuZCB0aGUgc3RhdGUg
b2YgdGhlIHZxIHdpbGwgYmUgdGhlIHZyaW5nIHJlbGVhc2UKPj4+IHN0YXRlLiBZb3UgY2FuIGNh
bGwgdGhpcyBmdW5jdGlvbiBhZ2FpbiB0byByZWFsbG9jYXRlIHRoZSB2cmluZy4KPj4+Cj4+PiBJ
biBhZGRpdGlvbiwgdnJpbmdfYWxpZ24sIG1heV9yZWR1Y2VfbnVtIGFyZSBuZWNlc3NhcnkgZm9y
IHJlYWxsb2NhdGluZwo+Pj4gdnJpbmcsIHNvIHRoZXkgYXJlIHJldGFpbmVkIHdoZW4gY3JlYXRp
bmcgdnEuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8
IDY5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4gICAgMSBmaWxlIGNo
YW5nZWQsIDY5IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+IGluZGV4
IGUwNDIyYzA0YzkwMy4uMTQ4ZmIxZmQzZDVhIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
Pj4gQEAgLTE1OCw2ICsxNTgsMTIgQEAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4+PiAgICAJ
CQkvKiBETUEgYWRkcmVzcyBhbmQgc2l6ZSBpbmZvcm1hdGlvbiAqLwo+Pj4gICAgCQkJZG1hX2Fk
ZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPj4+ICAgIAkJCXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVz
Owo+Pj4gKwo+Pj4gKwkJCS8qIFRoZSBwYXJhbWV0ZXJzIGZvciBjcmVhdGluZyB2cmluZ3MgYXJl
IHJlc2VydmVkIGZvcgo+Pj4gKwkJCSAqIGNyZWF0aW5nIG5ldyB2cmluZ3Mgd2hlbiBlbmFibGlu
ZyByZXNldCBxdWV1ZS4KPj4+ICsJCQkgKi8KPj4+ICsJCQl1MzIgdnJpbmdfYWxpZ247Cj4+PiAr
CQkJYm9vbCBtYXlfcmVkdWNlX251bTsKPj4+ICAgIAkJfSBzcGxpdDsKPj4+Cj4+PiAgICAJCS8q
IEF2YWlsYWJsZSBmb3IgcGFja2VkIHJpbmcgKi8KPj4+IEBAIC0yMTcsNiArMjIzLDEyIEBAIHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgewo+Pj4gICAgI2VuZGlmCj4+PiAgICB9Owo+Pj4KPj4+ICtz
dGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4+ICtzdGF0aWMg
dm9pZCBfX3ZyaW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxLAo+Pj4gKwkJCQkJIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KTsKPj4+ICtzdGF0aWMg
aW50IF9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSwKPj4+ICsJCQkJCSAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4+PiArCQkJCQkg
IHN0cnVjdCB2cmluZyB2cmluZyk7Cj4+Pgo+Pj4gICAgLyoKPj4+ICAgICAqIEhlbHBlcnMuCj4+
PiBAQCAtMTAxMiw2ICsxMDI0LDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2Ny
ZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4+PiAgICAJCXJldHVybiBOVUxMOwo+Pj4gICAgCX0KPj4+
Cj4+PiArCXRvX3Z2cSh2cSktPnNwbGl0LnZyaW5nX2FsaWduID0gdnJpbmdfYWxpZ247Cj4+PiAr
CXRvX3Z2cSh2cSktPnNwbGl0Lm1heV9yZWR1Y2VfbnVtID0gbWF5X3JlZHVjZV9udW07Cj4+PiAg
ICAJdG9fdnZxKHZxKS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSB2cmluZy5kbWFfYWRkcjsKPj4+
ICAgIAl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmcucXVldWVf
c2l6ZV9pbl9ieXRlczsKPj4+ICAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9IHRydWU7Cj4+
PiBAQCAtMTAxOSw2ICsxMDMzLDU5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19j
cmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+Pj4gICAgCXJldHVybiB2cTsKPj4+ICAgIH0KPj4+Cj4+
PiArc3RhdGljIGludCB2aXJ0cXVldWVfcmVzZXRfdnJpbmdfc3BsaXQoc3RydWN0IHZpcnRxdWV1
ZSAqX3ZxLCB1MzIgbnVtKQo+Pj4gK3sKPj4KPj4gU28gd2hhdCB0aGlzIGZ1bmN0aW9uIGRvZXMg
aXMgdG8gcmVzaXplIHRoZSB2aXJ0cXVldWUgYWN0dWFsbHksIEkKPj4gc3VnZ2VzdCB0byByZW5h
bWUgaXQgYXMgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdCgpLgo+IEluIGFkZGl0aW9uIHRvIHJlc2l6
ZSwgd2hlbiBudW0gaXMgMCwgdGhlIGZ1bmN0aW9uIGlzIHRvIHJlaW5pdGlhbGl6ZSB2cSByaW5n
Cj4gcmVsYXRlZCB2YXJpYWJsZXMuIEZvciBleGFtcGxlIGF2YWlsX2lkeF9zaGFkb3cuCgoKV2Ug
bmVlZCB0byBtb3ZlIHRob3NlIGxvZ2ljIHRvIHZpcnRpb19yZXNldF92cSgpIChJIHRoaW5rIHdl
IGFncmVlIHRvIApoYXZlIGEgYmV0dGVyIG5hbWUgb2YgaXQpLgoKCj4gU28gSSB0aGluayAncmVz
ZXQnIGlzIG1vcmUgYXBwcm9wcmlhdGUuCgoKVGhlIG5hbWUgaXMgY29uZnVzaW5nIGF0IGxlYXN0
IHRvIG1lLCBzaW5jZSB3ZSd2ZSBhbHJlYWR5IGhhZCAKdmlydGlvX3Jlc2V0X3ZxKCkgYW5kIG1v
c3Qgb2YgdGhlIGxvZ2ljIGlzIHRvIGRvIHRoZSByZXNpemUuCgpUaGFua3MKCgo+Cj4gVGhhbmtz
Lgo+Cj4+Cj4+PiArCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+
PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gX3ZxLT52ZGV2Owo+Pj4gKwlzdHJ1Y3Qg
dnJpbmdfc3BsaXQgdnJpbmc7Cj4+PiArCWludCBlcnI7Cj4+PiArCj4+PiArCWlmIChudW0gPiBf
dnEtPm51bV9tYXgpCj4+PiArCQlyZXR1cm4gLUUyQklHOwo+Pj4gKwo+Pj4gKwlzd2l0Y2ggKHZx
LT52cS5yZXNldCkgewo+Pj4gKwljYXNlIFZJUlRJT19WUV9SRVNFVF9TVEVQX05PTkU6Cj4+PiAr
CQlyZXR1cm4gLUVOT0VOVDsKPj4+ICsKPj4+ICsJY2FzZSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9W
UklOR19BVFRBQ0g6Cj4+PiArCWNhc2UgVklSVElPX1ZRX1JFU0VUX1NURVBfREVWSUNFOgo+Pj4g
KwkJaWYgKHZxLT5zcGxpdC52cmluZy5udW0gPT0gbnVtIHx8ICFudW0pCj4+PiArCQkJYnJlYWs7
Cj4+PiArCj4+PiArCQl2cmluZ19mcmVlKF92cSk7Cj4+PiArCj4+PiArCQlmYWxsdGhyb3VnaDsK
Pj4+ICsKPj4+ICsJY2FzZSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9WUklOR19SRUxFQVNFOgo+Pj4g
KwkJaWYgKCFudW0pCj4+PiArCQkJbnVtID0gdnEtPnNwbGl0LnZyaW5nLm51bTsKPj4+ICsKPj4+
ICsJCWVyciA9IHZyaW5nX2NyZWF0ZV92cmluZ19zcGxpdCgmdnJpbmcsIHZkZXYsCj4+PiArCQkJ
CQkgICAgICAgdnEtPnNwbGl0LnZyaW5nX2FsaWduLAo+Pj4gKwkJCQkJICAgICAgIHZxLT53ZWFr
X2JhcnJpZXJzLAo+Pj4gKwkJCQkJICAgICAgIHZxLT5zcGxpdC5tYXlfcmVkdWNlX251bSwgbnVt
KTsKPj4+ICsJCWlmIChlcnIpCj4+PiArCQkJcmV0dXJuIC1FTk9NRU07Cj4+Cj4+IFdlJ2QgYmV0
dGVyIG5lZWQgYSBzYWZlIGZhbGxiYWNrIGhlcmUgbGlrZToKPj4KPj4gSWYgd2UgY2FuJ3QgYWxs
b2NhdGUgbmV3IG1lbW9yeSwgd2UgY2FuIGtlZXAgdXNpbmcgdGhlIGN1cnJlbnQgb25lLgo+PiBP
dGhlcndpc2UgYW4gZXRodG9vbCAtRyBmYWlsIG1heSBtYWtlIHRoZSBkZXZpY2Ugbm90IHVzYWJs
ZS4KPj4KPj4gVGhpcyBjb3VsZCBiZSBkb25lIGJ5IG5vdCBmcmVlaW5nIHRoZSBvbGQgdnJpbmcg
YW5kIHZpcnRxdWV1ZSBzdGF0ZXMKPj4gdW50aWwgbmV3IGlzIGFsbG9jYXRlZC4KPj4KPj4KPj4+
ICsKPj4+ICsJCWVyciA9IF9fdnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdCh2cSwgdmRldiwg
dnJpbmcudnJpbmcpOwo+Pj4gKwkJaWYgKGVycikgewo+Pj4gKwkJCXZyaW5nX2ZyZWVfcXVldWUo
dmRldiwgdnJpbmcucXVldWVfc2l6ZV9pbl9ieXRlcywKPj4+ICsJCQkJCSB2cmluZy5xdWV1ZSwK
Pj4+ICsJCQkJCSB2cmluZy5kbWFfYWRkcik7Cj4+PiArCQkJcmV0dXJuIC1FTk9NRU07Cj4+PiAr
CQl9Cj4+PiArCj4+PiArCQl2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSB2cmluZy5kbWFfYWRk
cjsKPj4+ICsJCXZxLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmcucXVldWVfc2l6
ZV9pbl9ieXRlczsKPj4+ICsJfQo+Pj4gKwo+Pj4gKwlfX3ZyaW5nX3ZpcnRxdWV1ZV9pbml0X3Nw
bGl0KHZxLCB2ZGV2KTsKPj4+ICsJdnEtPndlX293bl9yaW5nID0gdHJ1ZTsKPj4KPj4gVGhpcyBz
ZWVtcyB3cm9uZywgd2UgaGF2ZSB0aGUgdHJhbnNwb3J0IChycHJvYy9tbHh0YmYpIHRoYXQgYWxs
b2NhdGUgdGhlCj4+IHZyaW5nIGJ5IHRoZW1zZWx2ZXMuIEkgdGhpbmsgd2UgbmVlZCB0byBmYWls
IHRoZSByZXNpemUgZm9yIHdlX293bl9yaW5nCj4+ID09IGZhbHNlLgo+Pgo+PiBUaGFua3MKPj4K
Pj4KPj4KPj4+ICsJdnEtPnZxLnJlc2V0ID0gVklSVElPX1ZRX1JFU0VUX1NURVBfVlJJTkdfQVRU
QUNIOwo+Pj4gKwo+Pj4gKwlyZXR1cm4gMDsKPj4+ICt9Cj4+PiArCj4+Pgo+Pj4gICAgLyoKPj4+
ICAgICAqIFBhY2tlZCByaW5nIHNwZWNpZmljIGZ1bmN0aW9ucyAtICpfcGFja2VkKCkuCj4+PiBA
QCAtMjMxNyw2ICsyMzg0LDggQEAgc3RhdGljIGludCBfX3ZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hf
c3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4+PiAgICBzdGF0aWMgdm9pZCBfX3Zy
aW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+Pj4g
ICAgCQkJCQkgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+PiAgICB7Cj4+PiArCXZxLT52
cS5yZXNldCA9IFZJUlRJT19WUV9SRVNFVF9TVEVQX05PTkU7Cj4+PiArCj4+PiAgICAJdnEtPnBh
Y2tlZF9yaW5nID0gZmFsc2U7Cj4+PiAgICAJdnEtPndlX293bl9yaW5nID0gZmFsc2U7Cj4+PiAg
ICAJdnEtPmJyb2tlbiA9IGZhbHNlOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
