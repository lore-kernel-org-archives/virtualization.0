Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9BEC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 07:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D9548283D;
	Wed,  9 Mar 2022 07:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RfUdTnDT3UQM; Wed,  9 Mar 2022 07:56:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F69E84286;
	Wed,  9 Mar 2022 07:56:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E868BC001D;
	Wed,  9 Mar 2022 07:56:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58063C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28234417B2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12tG8vMPsRE8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:56:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34A6B4179D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646812566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXuB3B5jDtB5OBhHstqyNyrujXVHiDK4qma1A4MbOm0=;
 b=Bs2vgeoFTJeiA/Xv0iuZS7ktCfeWz5pkq9DTEI/3kWiuGaJOdADr+rP8TEpthNbOckMqeA
 7RMwDNXz+XeZZ4+PueVMa1wV6MRuA98JKSM0gypBZw30kbrpU3IIvjxRKLYjDWRABTzx0T
 l+/KcVTsTTwyQ1ja8deHNn29mA3WlLo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-9kukFrGMOjmMJsgbDi2pJQ-1; Wed, 09 Mar 2022 02:56:05 -0500
X-MC-Unique: 9kukFrGMOjmMJsgbDi2pJQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 z13-20020a1709027e8d00b001518de7a06cso753269pla.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 23:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nXuB3B5jDtB5OBhHstqyNyrujXVHiDK4qma1A4MbOm0=;
 b=GGA0ANn4S68ImCFshPmb6nasZCO6iyf36dPJ8cv6q7F6RZQ2soZK8BX0dIWVVR8UrC
 shmXHACvwqoZc3fa9eK0Ln2OJ+ZrxnJceqIyEqy40JSlf8PcblANbQTzE/0MuwbZxUqh
 ZpvFbJAf71eu9OuNm3gwxvboU+lC04Q9OC5e/mDkPUYjg9jxmsrZS3bmrNrSux4ACWkU
 OjNegY7xxftwJ6OB80DvNk92CziJG+KorDH3Eas6DIUOWxOMGe/LkXlw0e4HyISrzUAj
 Z5mQ7aQr068m1zoumqa8bv/ATv6NCPeI8f9Sm92cX+C8cFdDFYHYEdJoXJ9dl3oOqKzR
 EJ1A==
X-Gm-Message-State: AOAM530BDrV9ORCgPKTXJauliHcftpT9wTA5mS3XHeRz6vlcrV47b6/e
 Vhpxei3FikkZvzL4jqCs5jRIZyhEfLJ70hccFjJuj65jyXzNKD+nCcdGfLzwg17kmS+Snxb1UF3
 mvz69E2J0h3eul4CO3JiUeRImvLNvyv7u57361RUaCQ==
X-Received: by 2002:a17:903:32c4:b0:151:c6ae:e24b with SMTP id
 i4-20020a17090332c400b00151c6aee24bmr22112788plr.85.1646812563890; 
 Tue, 08 Mar 2022 23:56:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybDKg7kAlq7E11Ti35K1Cy6HiZbN5h1MuN+e0cBpBT9cOyctGw5IATTQsVpIPtETRU/6u7tg==
X-Received: by 2002:a17:903:32c4:b0:151:c6ae:e24b with SMTP id
 i4-20020a17090332c400b00151c6aee24bmr22112759plr.85.1646812563582; 
 Tue, 08 Mar 2022 23:56:03 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 bd10-20020a056a00278a00b004f6fe0f4cbasm1395974pfb.101.2022.03.08.23.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 23:56:03 -0800 (PST)
Message-ID: <512de020-b36e-8473-69c8-8b3925fbb6c1@redhat.com>
Date: Wed, 9 Mar 2022 15:55:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IHZpcnRpbyByaW5n
IHN1cHBvcnRzIHJlc2V0Lgo+Cj4gUXVldWUgcmVzZXQgaXMgZGl2aWRlZCBpbnRvIHNldmVyYWwg
c3RhZ2VzLgo+Cj4gMS4gbm90aWZ5IGRldmljZSBxdWV1ZSByZXNldAo+IDIuIHZyaW5nIHJlbGVh
c2UKPiAzLiBhdHRhY2ggbmV3IHZyaW5nCj4gNC4gbm90aWZ5IGRldmljZSBxdWV1ZSByZS1lbmFi
bGUKPgo+IEFmdGVyIHRoZSBmaXJzdCBzdGVwIGlzIGNvbXBsZXRlZCwgdGhlIHZyaW5nIHJlc2V0
IG9wZXJhdGlvbiBjYW4gYmUKPiBwZXJmb3JtZWQuIElmIHRoZSBuZXdseSBzZXQgdnJpbmcgbnVt
IGRvZXMgbm90IGNoYW5nZSwgdGhlbiBqdXN0IHJlc2V0Cj4gdGhlIHZxIHJlbGF0ZWQgdmFsdWUu
Cj4KPiBPdGhlcndpc2UsIHRoZSB2cmluZyB3aWxsIGJlIHJlbGVhc2VkIGFuZCB0aGUgdnJpbmcg
d2lsbCBiZSByZWFsbG9jYXRlZC4KPiBBbmQgdGhlIHZyaW5nIHdpbGwgYmUgYXR0YWNoZWQgdG8g
dGhlIHZxLiBJZiB0aGlzIHByb2Nlc3MgZmFpbHMsIHRoZQo+IGZ1bmN0aW9uIHdpbGwgZXhpdCwg
YW5kIHRoZSBzdGF0ZSBvZiB0aGUgdnEgd2lsbCBiZSB0aGUgdnJpbmcgcmVsZWFzZQo+IHN0YXRl
LiBZb3UgY2FuIGNhbGwgdGhpcyBmdW5jdGlvbiBhZ2FpbiB0byByZWFsbG9jYXRlIHRoZSB2cmlu
Zy4KPgo+IEluIGFkZGl0aW9uLCB2cmluZ19hbGlnbiwgbWF5X3JlZHVjZV9udW0gYXJlIG5lY2Vz
c2FyeSBmb3IgcmVhbGxvY2F0aW5nCj4gdnJpbmcsIHNvIHRoZXkgYXJlIHJldGFpbmVkIHdoZW4g
Y3JlYXRpbmcgdnEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDY5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQs
IDY5IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGUwNDIyYzA0Yzkw
My4uMTQ4ZmIxZmQzZDVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE1OCw2ICsxNTgs
MTIgQEAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4gICAJCQkvKiBETUEgYWRkcmVzcyBhbmQg
c2l6ZSBpbmZvcm1hdGlvbiAqLwo+ICAgCQkJZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPiAg
IAkJCXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+ICsKPiArCQkJLyogVGhlIHBhcmFtZXRl
cnMgZm9yIGNyZWF0aW5nIHZyaW5ncyBhcmUgcmVzZXJ2ZWQgZm9yCj4gKwkJCSAqIGNyZWF0aW5n
IG5ldyB2cmluZ3Mgd2hlbiBlbmFibGluZyByZXNldCBxdWV1ZS4KPiArCQkJICovCj4gKwkJCXUz
MiB2cmluZ19hbGlnbjsKPiArCQkJYm9vbCBtYXlfcmVkdWNlX251bTsKPiAgIAkJfSBzcGxpdDsK
PiAgIAo+ICAgCQkvKiBBdmFpbGFibGUgZm9yIHBhY2tlZCByaW5nICovCj4gQEAgLTIxNyw2ICsy
MjMsMTIgQEAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4gICAjZW5kaWYKPiAgIH07Cj4gICAK
PiArc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gK3N0YXRp
YyB2b2lkIF9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4gKwkJCQkJIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KTsKPiArc3RhdGljIGlu
dCBfX3ZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEsCj4gKwkJCQkJICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiArCQkJCQkgIHN0cnVj
dCB2cmluZyB2cmluZyk7Cj4gICAKPiAgIC8qCj4gICAgKiBIZWxwZXJzLgo+IEBAIC0xMDEyLDYg
KzEwMjQsOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1
ZV9zcGxpdCgKPiAgIAkJcmV0dXJuIE5VTEw7Cj4gICAJfQo+ICAgCj4gKwl0b192dnEodnEpLT5z
cGxpdC52cmluZ19hbGlnbiA9IHZyaW5nX2FsaWduOwo+ICsJdG9fdnZxKHZxKS0+c3BsaXQubWF5
X3JlZHVjZV9udW0gPSBtYXlfcmVkdWNlX251bTsKPiAgIAl0b192dnEodnEpLT5zcGxpdC5xdWV1
ZV9kbWFfYWRkciA9IHZyaW5nLmRtYV9hZGRyOwo+ICAgCXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVl
X3NpemVfaW5fYnl0ZXMgPSB2cmluZy5xdWV1ZV9zaXplX2luX2J5dGVzOwo+ICAgCXRvX3Z2cSh2
cSktPndlX293bl9yaW5nID0gdHJ1ZTsKPiBAQCAtMTAxOSw2ICsxMDMzLDU5IEBAIHN0YXRpYyBz
dHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCXJldHVy
biB2cTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9yZXNldF92cmluZ19zcGxp
dChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gK3sKCgpTbyB3aGF0IHRoaXMgZnVu
Y3Rpb24gZG9lcyBpcyB0byByZXNpemUgdGhlIHZpcnRxdWV1ZSBhY3R1YWxseSwgSSAKc3VnZ2Vz
dCB0byByZW5hbWUgaXQgYXMgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdCgpLgoKCj4gKwlzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsJc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYgPSBfdnEtPnZkZXY7Cj4gKwlzdHJ1Y3QgdnJpbmdfc3BsaXQgdnJpbmc7Cj4gKwlp
bnQgZXJyOwo+ICsKPiArCWlmIChudW0gPiBfdnEtPm51bV9tYXgpCj4gKwkJcmV0dXJuIC1FMkJJ
RzsKPiArCj4gKwlzd2l0Y2ggKHZxLT52cS5yZXNldCkgewo+ICsJY2FzZSBWSVJUSU9fVlFfUkVT
RVRfU1RFUF9OT05FOgo+ICsJCXJldHVybiAtRU5PRU5UOwo+ICsKPiArCWNhc2UgVklSVElPX1ZR
X1JFU0VUX1NURVBfVlJJTkdfQVRUQUNIOgo+ICsJY2FzZSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9E
RVZJQ0U6Cj4gKwkJaWYgKHZxLT5zcGxpdC52cmluZy5udW0gPT0gbnVtIHx8ICFudW0pCj4gKwkJ
CWJyZWFrOwo+ICsKPiArCQl2cmluZ19mcmVlKF92cSk7Cj4gKwo+ICsJCWZhbGx0aHJvdWdoOwo+
ICsKPiArCWNhc2UgVklSVElPX1ZRX1JFU0VUX1NURVBfVlJJTkdfUkVMRUFTRToKPiArCQlpZiAo
IW51bSkKPiArCQkJbnVtID0gdnEtPnNwbGl0LnZyaW5nLm51bTsKPiArCj4gKwkJZXJyID0gdnJp
bmdfY3JlYXRlX3ZyaW5nX3NwbGl0KCZ2cmluZywgdmRldiwKPiArCQkJCQkgICAgICAgdnEtPnNw
bGl0LnZyaW5nX2FsaWduLAo+ICsJCQkJCSAgICAgICB2cS0+d2Vha19iYXJyaWVycywKPiArCQkJ
CQkgICAgICAgdnEtPnNwbGl0Lm1heV9yZWR1Y2VfbnVtLCBudW0pOwo+ICsJCWlmIChlcnIpCj4g
KwkJCXJldHVybiAtRU5PTUVNOwoKCldlJ2QgYmV0dGVyIG5lZWQgYSBzYWZlIGZhbGxiYWNrIGhl
cmUgbGlrZToKCklmIHdlIGNhbid0IGFsbG9jYXRlIG5ldyBtZW1vcnksIHdlIGNhbiBrZWVwIHVz
aW5nIHRoZSBjdXJyZW50IG9uZS4gCk90aGVyd2lzZSBhbiBldGh0b29sIC1HIGZhaWwgbWF5IG1h
a2UgdGhlIGRldmljZSBub3QgdXNhYmxlLgoKVGhpcyBjb3VsZCBiZSBkb25lIGJ5IG5vdCBmcmVl
aW5nIHRoZSBvbGQgdnJpbmcgYW5kIHZpcnRxdWV1ZSBzdGF0ZXMgCnVudGlsIG5ldyBpcyBhbGxv
Y2F0ZWQuCgoKPiArCj4gKwkJZXJyID0gX192cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHZx
LCB2ZGV2LCB2cmluZy52cmluZyk7Cj4gKwkJaWYgKGVycikgewo+ICsJCQl2cmluZ19mcmVlX3F1
ZXVlKHZkZXYsIHZyaW5nLnF1ZXVlX3NpemVfaW5fYnl0ZXMsCj4gKwkJCQkJIHZyaW5nLnF1ZXVl
LAo+ICsJCQkJCSB2cmluZy5kbWFfYWRkcik7Cj4gKwkJCXJldHVybiAtRU5PTUVNOwo+ICsJCX0K
PiArCj4gKwkJdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gdnJpbmcuZG1hX2FkZHI7Cj4gKwkJ
dnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSB2cmluZy5xdWV1ZV9zaXplX2luX2J5dGVz
Owo+ICsJfQo+ICsKPiArCV9fdnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQodnEsIHZkZXYpOwo+
ICsJdnEtPndlX293bl9yaW5nID0gdHJ1ZTsKCgpUaGlzIHNlZW1zIHdyb25nLCB3ZSBoYXZlIHRo
ZSB0cmFuc3BvcnQgKHJwcm9jL21seHRiZikgdGhhdCBhbGxvY2F0ZSB0aGUgCnZyaW5nIGJ5IHRo
ZW1zZWx2ZXMuIEkgdGhpbmsgd2UgbmVlZCB0byBmYWlsIHRoZSByZXNpemUgZm9yIHdlX293bl9y
aW5nIAo9PSBmYWxzZS4KClRoYW5rcwoKCgo+ICsJdnEtPnZxLnJlc2V0ID0gVklSVElPX1ZRX1JF
U0VUX1NURVBfVlJJTkdfQVRUQUNIOwo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICAgCj4g
ICAvKgo+ICAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNrZWQoKS4K
PiBAQCAtMjMxNyw2ICsyMzg0LDggQEAgc3RhdGljIGludCBfX3ZyaW5nX3ZpcnRxdWV1ZV9hdHRh
Y2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICBzdGF0aWMgdm9pZCBfX3Zy
aW5nX3ZpcnRxdWV1ZV9pbml0X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAg
CQkJCQkgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICB7Cj4gKwl2cS0+dnEucmVzZXQg
PSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9OT05FOwo+ICsKPiAgIAl2cS0+cGFja2VkX3JpbmcgPSBm
YWxzZTsKPiAgIAl2cS0+d2Vfb3duX3JpbmcgPSBmYWxzZTsKPiAgIAl2cS0+YnJva2VuID0gZmFs
c2U7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
