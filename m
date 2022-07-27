Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7B0C19F2C
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 04:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2E1160ABB;
	Wed, 27 Jul 2022 04:34:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2E1160ABB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O1b5tU95
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e2CC-n_vGxEv; Wed, 27 Jul 2022 04:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3293460601;
	Wed, 27 Jul 2022 04:34:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3293460601
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC553C0035;
	Wed, 27 Jul 2022 04:34:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66C38C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4090D8142F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4090D8142F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O1b5tU95
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z2ltJvNbaAEs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F407813A8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F407813A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 04:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658896447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmsJFhYx/U7wRWY1QXPRuk0DZiGyI1mt4/EGEseZMos=;
 b=O1b5tU95vioAajCzMK050gjhpfd5PViij6ZqmquqBultmZUvTBZHxZq+Knb8egJGo4YdhC
 3A3l5qpUZ6LnBAbgd9XqwpmasJRrZPVMyJreMNhFOBji2okn3dlpec/Vmmk5o+OaA7Yl44
 Adm1DTbE2aqGUBu+2i6Kteh8U5SBJiQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-z31NdJucOCCGFk6Bl-fWBg-1; Wed, 27 Jul 2022 00:34:05 -0400
X-MC-Unique: z31NdJucOCCGFk6Bl-fWBg-1
Received: by mail-pg1-f199.google.com with SMTP id
 o10-20020a655bca000000b00412787983b3so7334644pgr.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 21:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zmsJFhYx/U7wRWY1QXPRuk0DZiGyI1mt4/EGEseZMos=;
 b=bzd+ULEr0rbhjKb6fv8JfxSybyTAWRRey4Q8qHH3HMUjs/dqZ69FC038xVdFFkT55a
 az8ORL0JsnyW2wqBj+kYAQmKhKVvw3dqh78QDaBNImhxZZgNPSNwI6y4Z4caGSYpE7dJ
 xmPlt87KziaNlOXMVW4NeOjsDrMAWmLJhTY+SkYP6BlpB0e9VEz+4kGH1xc7S+PaTYLX
 4+cHBoIbCbmtQ4eL1/YjfIfMthC0YLipG87+5vo9tLTEQl7d5CI2zcGoDA8m5pDROy3v
 1SBV9qOO8KXfhmhOFmUfqXsz3SNpdNHMELEAXlVd4zJ4eaBHkNJFeyHds1dBpRjlV4E+
 vxrQ==
X-Gm-Message-State: AJIora8vgqrbWQiZe/zil36GOQOLtPZFTZVkk2JJ4wSbNX+u19FOBC16
 +Kzn1ZIjUCoMTgVjzflJf7deKDcToUlGK1SYmequ00zMX25u6KIbBdPyzCYxfGjvrN9VEzml6Y1
 GQewoVw64aaGruPypsjXPboukdQiIF6yxna3ueF1h7A==
X-Received: by 2002:a65:6907:0:b0:415:c9c1:eb4f with SMTP id
 s7-20020a656907000000b00415c9c1eb4fmr17446498pgq.193.1658896444741; 
 Tue, 26 Jul 2022 21:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLOTTMSwZn23J72vfWRP8aVjMiYXEHs6Q/e6N32SFoFq1t32q5shVi3/mZ0Ya8jurhHaEXXg==
X-Received: by 2002:a65:6907:0:b0:415:c9c1:eb4f with SMTP id
 s7-20020a656907000000b00415c9c1eb4fmr17446476pgq.193.1658896444474; 
 Tue, 26 Jul 2022 21:34:04 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090322cc00b0016c9e5f291bsm9114120plg.111.2022.07.26.21.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 21:34:00 -0700 (PDT)
Message-ID: <11a17272-7318-0217-7e45-83a3b237ed7f@redhat.com>
Date: Wed, 27 Jul 2022 12:33:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 20/42] virtio_ring: packed: extract the logic of vring
 init
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-21-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-21-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzcvMjYgMTU6MjIsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIGluaXRpYWxpemluZyB2cmluZywgYW5kIHN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsCj4g
Y2FsbCBpdCBzZXBhcmF0ZWx5Lgo+Cj4gVGhpcyBmdW5jdGlvbiBjb21wbGV0ZXMgdGhlIHZhcmlh
YmxlIGluaXRpYWxpemF0aW9uIG9mIHBhY2tlZCB2cmluZy4gSXQKPiB0b2dldGhlciB3aXRoIHRo
ZSBsb2dpYyBvZiBhdGF0Y2ggY29uc3RpdHV0ZXMgdGhlIGluaXRpYWxpemF0aW9uIG9mCj4gdnJp
bmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEu
Y29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0t
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjggKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMzI1OTBkNzYzYzNiLi5mYzRlM2Ri
OWY5M2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTkzNSw2ICsxOTM1LDIyIEBAIHN0
YXRpYyBpbnQgdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0
cXVldWVfcGFja2VkICp2cmluZ19wCj4gICAJcmV0dXJuIC1FTk9NRU07Cj4gICB9Cj4gICAKPiAr
c3RhdGljIHZvaWQgdmlydHF1ZXVlX3ZyaW5nX2luaXRfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0
cXVldWVfcGFja2VkICp2cmluZ19wYWNrZWQsCj4gKwkJCQkJYm9vbCBjYWxsYmFjaykKPiArewo+
ICsJdnJpbmdfcGFja2VkLT5uZXh0X2F2YWlsX2lkeCA9IDA7Cj4gKwl2cmluZ19wYWNrZWQtPmF2
YWlsX3dyYXBfY291bnRlciA9IDE7Cj4gKwl2cmluZ19wYWNrZWQtPmV2ZW50X2ZsYWdzX3NoYWRv
dyA9IDA7Cj4gKwl2cmluZ19wYWNrZWQtPmF2YWlsX3VzZWRfZmxhZ3MgPSAxIDw8IFZSSU5HX1BB
Q0tFRF9ERVNDX0ZfQVZBSUw7Cj4gKwo+ICsJLyogTm8gY2FsbGJhY2s/ICBUZWxsIG90aGVyIHNp
ZGUgbm90IHRvIGJvdGhlciB1cy4gKi8KPiArCWlmICghY2FsbGJhY2spIHsKPiArCQl2cmluZ19w
YWNrZWQtPmV2ZW50X2ZsYWdzX3NoYWRvdyA9IFZSSU5HX1BBQ0tFRF9FVkVOVF9GTEFHX0RJU0FC
TEU7Cj4gKwkJdnJpbmdfcGFja2VkLT52cmluZy5kcml2ZXItPmZsYWdzID0KPiArCQkJY3B1X3Rv
X2xlMTYodnJpbmdfcGFja2VkLT5ldmVudF9mbGFnc19zaGFkb3cpOwo+ICsJfQo+ICt9Cj4gKwo+
ICAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2Vk
KAo+ICAgCXVuc2lnbmVkIGludCBpbmRleCwKPiAgIAl1bnNpZ25lZCBpbnQgbnVtLAo+IEBAIC0x
OTg0LDExICsyMDAwLDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92
aXJ0cXVldWVfcGFja2VkKAo+ICAgCj4gICAJdnEtPnBhY2tlZC52cmluZyA9IHZyaW5nX3BhY2tl
ZC52cmluZzsKPiAgIAo+IC0JdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeCA9IDA7Cj4gLQl2cS0+
cGFja2VkLmF2YWlsX3dyYXBfY291bnRlciA9IDE7Cj4gLQl2cS0+cGFja2VkLmV2ZW50X2ZsYWdz
X3NoYWRvdyA9IDA7Cj4gLQl2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3MgPSAxIDw8IFZSSU5H
X1BBQ0tFRF9ERVNDX0ZfQVZBSUw7Cj4gLQo+ICAgCWVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4
dHJhX3BhY2tlZCgmdnJpbmdfcGFja2VkKTsKPiAgIAlpZiAoZXJyKQo+ICAgCQlnb3RvIGVycl9z
dGF0ZV9leHRyYTsKPiBAQCAtMTk5NiwxMiArMjAwNyw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1
ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiAgIAl2cS0+cGFja2VkLmRlc2Nf
c3RhdGUgPSB2cmluZ19wYWNrZWQuZGVzY19zdGF0ZTsKPiAgIAl2cS0+cGFja2VkLmRlc2NfZXh0
cmEgPSB2cmluZ19wYWNrZWQuZGVzY19leHRyYTsKPiAgIAo+IC0JLyogTm8gY2FsbGJhY2s/ICBU
ZWxsIG90aGVyIHNpZGUgbm90IHRvIGJvdGhlciB1cy4gKi8KPiAtCWlmICghY2FsbGJhY2spIHsK
PiAtCQl2cS0+cGFja2VkLmV2ZW50X2ZsYWdzX3NoYWRvdyA9IFZSSU5HX1BBQ0tFRF9FVkVOVF9G
TEFHX0RJU0FCTEU7Cj4gLQkJdnEtPnBhY2tlZC52cmluZy5kcml2ZXItPmZsYWdzID0KPiAtCQkJ
Y3B1X3RvX2xlMTYodnEtPnBhY2tlZC5ldmVudF9mbGFnc19zaGFkb3cpOwo+IC0JfQo+ICsJdmly
dHF1ZXVlX3ZyaW5nX2luaXRfcGFja2VkKCZ2cmluZ19wYWNrZWQsICEhY2FsbGJhY2spOwo+ICAg
Cj4gICAJdmlydHF1ZXVlX2luaXQodnEsIG51bSk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
