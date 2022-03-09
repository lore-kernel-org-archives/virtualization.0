Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA132C43219
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 08:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B7FFC40159;
	Wed,  9 Mar 2022 08:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vErqU-zQn4TC; Wed,  9 Mar 2022 08:54:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC17C4018B;
	Wed,  9 Mar 2022 08:54:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE109C001D;
	Wed,  9 Mar 2022 08:54:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5526C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC02E83E8E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sECa0RMqtDcm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:54:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8516B837C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646816067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ZhhBbOUupAA6M+k9Rz4Ll5OHg5ZJcNqZJUdl8Vkv/g=;
 b=FCEQXqhDLbaInIadnjKzfk0UDGsC4aGC2Q7HgE9kgXjZsu20rjV3Oyv1gnz1P1UuIO6SBd
 e2L22Ym8cNz3MHvWqCRceGav1FYCiqEIfYcyLP4sYOyYkuMS0aOTTKDiH3NshmhpYcHGhN
 AbH68JXhk4v9cFSdyU/IUgFfvN04ne8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-prncYYknMZSuiBxCHkrtoA-1; Wed, 09 Mar 2022 03:54:26 -0500
X-MC-Unique: prncYYknMZSuiBxCHkrtoA-1
Received: by mail-pj1-f70.google.com with SMTP id
 m14-20020a17090a4d8e00b001bf2d4926c5so3408922pjh.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 00:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+ZhhBbOUupAA6M+k9Rz4Ll5OHg5ZJcNqZJUdl8Vkv/g=;
 b=6eGXwTj9jFuNd69aMIPaxqB8kElYN+wzAAlE550CGyHmtzG/nIpgcJy3bDkAeWFISQ
 +Fjm6ouPgVNMuS0YiK8ccDXXPODG06s+TlsXdUcuQgZOafaHJQSQx/6wN2M8Q4IbPrZB
 Opdxpqcei1E1xbFmlu+dyGjoJJYQ1TFhn/2ccCssnbDOLFlqvtm4GmRBfKfOIyM9WRXi
 MI0TcgX2paQhoBupifi1Jte2c8EWpLZ62KpSxirtx7brTjHpmGEck6QiqikMSXq/axPa
 eGoxMYmj+FEckxkVQDSr11MYvX/XDZnGDXREBqJAAh2H13bHvwDckKPcX76Xo2PWsRwL
 J0LA==
X-Gm-Message-State: AOAM533yWv8e+ORWkae8teCDGjm2b+4lcd9MXe3FtbvhXVgdyhIZ82k7
 BBHwkKD8pORUB59exwXowvJo0dGfthk0CERpiAOpF+EZRch36jNLSKIOgw0UXm7OXTmqSfr/6Ni
 KNvlbQkkrTcN9utBT/gdzLyuVcpfVryqRKVFjVC/uVA==
X-Received: by 2002:a05:6a00:b92:b0:4f6:dfe0:9abb with SMTP id
 g18-20020a056a000b9200b004f6dfe09abbmr19856132pfj.68.1646816065157; 
 Wed, 09 Mar 2022 00:54:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyRePfc4L0AEaEhCl772NZ5fZoJQRardXXak7jcB75evudlHCNm1wIaBIuQxq5B0gxMurNvg==
X-Received: by 2002:a05:6a00:b92:b0:4f6:dfe0:9abb with SMTP id
 g18-20020a056a000b9200b004f6dfe09abbmr19856114pfj.68.1646816064828; 
 Wed, 09 Mar 2022 00:54:24 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 pi16-20020a17090b1e5000b001bd1ffaf2basm1829407pjb.0.2022.03.09.00.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 00:54:24 -0800 (PST)
Message-ID: <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
Date: Wed, 9 Mar 2022 16:54:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 17/26] virtio_pci: queue_reset: support
 VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-18-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-18-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFRoaXMgcGF0Y2gg
aW1wbGVtZW50cyB2aXJ0aW8gcGNpIHN1cHBvcnQgZm9yIFFVRVVFIFJFU0VULgo+Cj4gUGVyZm9y
bWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlkZWQgaW50byB0aGVzZSBzdGVwczoKPgo+ICAg
MS4gdmlydGlvX3Jlc2V0X3ZxKCkgICAgICAgICAgICAgIC0gbm90aWZ5IHRoZSBkZXZpY2UgdG8g
cmVzZXQgdGhlIHF1ZXVlCj4gICAyLiB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoKSAgLSBy
ZWN5Y2xlIHRoZSBidWZmZXIgc3VibWl0dGVkCj4gICAzLiB2aXJ0cXVldWVfcmVzZXRfdnJpbmco
KSAgICAgICAgLSByZXNldCB0aGUgdnJpbmcgKG1heSByZS1hbGxvYykKPiAgIDQuIHZpcnRpb19l
bmFibGVfcmVzZXRxKCkgICAgICAgICAtIG1tYXAgdnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxl
IHRoZSBxdWV1ZQo+Cj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIHZpcnRpb19yZXNldF92cSgpLCB2
aXJ0aW9fZW5hYmxlX3Jlc2V0cSgpIGluIHRoZQo+IHBjaSBzY2VuYXJpby4KPgo+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgIDggKy0tCj4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX21vZGVybi5jIHwgODMgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiBpbmRleCBmZGJkZTFkYjVlYzUuLjg2
M2QzYThhMDk1NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1v
bi5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+IEBAIC0yNDgs
OSArMjQ4LDExIEBAIHN0YXRpYyB2b2lkIHZwX2RlbF92cShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkK
PiAgIAlzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvID0gdnBfZGV2LT52cXNbdnEtPmlu
ZGV4XTsKPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICAgCj4gLQlzcGluX2xvY2tfaXJxc2F2
ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gLQlsaXN0X2RlbCgmaW5mby0+bm9kZSk7Cj4gLQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCWlmICghdnEt
PnJlc2V0KSB7Cj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+
ICsJCWxpc3RfZGVsKCZpbmZvLT5ub2RlKTsKPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2
cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCX0KPiAgIAo+ICAgCXZwX2Rldi0+ZGVsX3ZxKGluZm8p
Owo+ICAgCWtmcmVlKGluZm8pOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+IGluZGV4
IDQ5YTQ0OTM3MzJjZi4uM2M2N2QzNjA3ODAyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbW9kZXJuLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21v
ZGVybi5jCj4gQEAgLTM0LDYgKzM0LDkgQEAgc3RhdGljIHZvaWQgdnBfdHJhbnNwb3J0X2ZlYXR1
cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gICAJaWYgKChm
ZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfU1JfSU9WKSkgJiYKPiAgIAkJCXBjaV9maW5kX2V4
dF9jYXBhYmlsaXR5KHBjaV9kZXYsIFBDSV9FWFRfQ0FQX0lEX1NSSU9WKSkKPiAgIAkJX192aXJ0
aW9fc2V0X2JpdCh2ZGV2LCBWSVJUSU9fRl9TUl9JT1YpOwo+ICsKPiArCWlmIChmZWF0dXJlcyAm
IEJJVF9VTEwoVklSVElPX0ZfUklOR19SRVNFVCkpCj4gKwkJX192aXJ0aW9fc2V0X2JpdCh2ZGV2
LCBWSVJUSU9fRl9SSU5HX1JFU0VUKTsKPiAgIH0KPiAgIAo+ICAgLyogdmlydGlvIGNvbmZpZy0+
ZmluYWxpemVfZmVhdHVyZXMoKSBpbXBsZW1lbnRhdGlvbiAqLwo+IEBAIC0xOTksNiArMjAyLDgy
IEBAIHN0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MTYgbXNp
eF92ZWMpCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2cF9tb2Rlcm5f
cmVzZXRfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9fcGNp
X2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPiArCXN0cnVjdCB2aXJ0
aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsJc3RydWN0IHZp
cnRpb19wY2lfdnFfaW5mbyAqaW5mbzsKPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gKwl1bnNp
Z25lZCBpbnQgaXJxOwo+ICsKPiArCWlmICghdmlydGlvX2hhc19mZWF0dXJlKHZxLT52ZGV2LCBW
SVJUSU9fRl9SSU5HX1JFU0VUKSkKPiArCQlyZXR1cm4gLUVOT0VOVDsKPiArCj4gKwl2cF9tb2Rl
cm5fc2V0X3F1ZXVlX3Jlc2V0KG1kZXYsIHZxLT5pbmRleCk7Cj4gKwo+ICsJaW5mbyA9IHZwX2Rl
di0+dnFzW3ZxLT5pbmRleF07Cj4gKwo+ICsJLyogZGVsZXRlIHZxIGZyb20gaXJxIGhhbmRsZXIg
Ki8KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCWxpc3Rf
ZGVsKCZpbmZvLT5ub2RlKTsKPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZwX2Rldi0+bG9j
aywgZmxhZ3MpOwo+ICsKPiArCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2RlKTsKPiArCj4gKwl2
cS0+cmVzZXQgPSBWSVJUSU9fVlFfUkVTRVRfU1RFUF9ERVZJQ0U7Cj4gKwo+ICsJLyogc3luYyBp
cnEgY2FsbGJhY2suICovCj4gKwlpZiAodnBfZGV2LT5pbnR4X2VuYWJsZWQpIHsKPiArCQlpcnEg
PSB2cF9kZXYtPnBjaV9kZXYtPmlycTsKPiArCj4gKwl9IGVsc2Ugewo+ICsJCWlmIChpbmZvLT5t
c2l4X3ZlY3RvciA9PSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikKPiArCQkJcmV0dXJuIDA7Cj4gKwo+
ICsJCWlycSA9IHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaW5mby0+bXNpeF92ZWN0
b3IpOwo+ICsJfQo+ICsKPiArCXN5bmNocm9uaXplX2lycShpcnEpOwoKClN5bmNocm9uaXplX2ly
cSgpIGlzIG5vdCBzdWZmaWNpZW50IGhlcmUgc2luY2UgaXQgYnJlYWtzIHRoZSBlZmZvcnQgb2Yg
CnRoZSBpbnRlcnJ1cHQgaGFyZGVuaW5nIHdoaWNoIGlzIGRvbmUgYnkgY29tbWl0czoKCjA4MGNk
N2MzYWM4NyB2aXJ0aW8tcGNpOiBoYXJkZW4gSU5UWCBpbnRlcnJ1cHRzCjllMzUyNzZhNTM0NCB2
aXJ0aW9fcGNpOiBoYXJkZW4gTVNJLVggaW50ZXJydXB0cwoKVW5mb3J0dW5hdGVsecKgIDA4MGNk
N2MzYWM4NyBpbnRyb2R1Y2VzIGFuIGlzc3VlIHRoYXQgZGlzYWJsZV9pcnEoKSB3ZXJlIAp1c2Vk
IGZvciB0aGUgYWZmaW5pdHkgbWFuYWdlZCBpcnEgYnV0IHdlJ3JlIGRpc2N1c3NpbmcgYSBmaXgu
CgoKPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiArc3RhdGljIGludCB2cF9tb2Rlcm5fZW5h
YmxlX3Jlc2V0X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydGlv
X3BjaV9kZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2cS0+dmRldik7Cj4gKwlzdHJ1Y3Qg
dmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+bWRldjsKPiArCXN0cnVj
dCB2aXJ0aW9fcGNpX3ZxX2luZm8gKmluZm87Cj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzLCBpbmRl
eDsKPiArCWludCBlcnI7Cj4gKwo+ICsJaWYgKHZxLT5yZXNldCAhPSBWSVJUSU9fVlFfUkVTRVRf
U1RFUF9WUklOR19BVFRBQ0gpCj4gKwkJcmV0dXJuIC1FQlVTWTsKPiArCj4gKwlpbmRleCA9IHZx
LT5pbmRleDsKPiArCWluZm8gPSB2cF9kZXYtPnZxc1tpbmRleF07Cj4gKwo+ICsJLyogY2hlY2sg
cXVldWUgcmVzZXQgc3RhdHVzICovCj4gKwlpZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9yZXNldCht
ZGV2LCBpbmRleCkgIT0gMSkKPiArCQlyZXR1cm4gLUVCVVNZOwo+ICsKPiArCWVyciA9IHZwX2Fj
dGl2ZV92cSh2cSwgaW5mby0+bXNpeF92ZWN0b3IpOwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4g
ZXJyOwo+ICsKPiArCWlmICh2cS0+Y2FsbGJhY2spIHsKPiArCQlzcGluX2xvY2tfaXJxc2F2ZSgm
dnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gKwkJbGlzdF9hZGQoJmluZm8tPm5vZGUsICZ2cF9kZXYt
PnZpcnRxdWV1ZXMpOwo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnZwX2Rldi0+bG9jaywg
ZmxhZ3MpOwo+ICsJfSBlbHNlIHsKPiArCQlJTklUX0xJU1RfSEVBRCgmaW5mby0+bm9kZSk7Cj4g
Kwl9Cj4gKwo+ICsJdnBfbW9kZXJuX3NldF9xdWV1ZV9lbmFibGUoJnZwX2Rldi0+bWRldiwgaW5k
ZXgsIHRydWUpOwoKCkFueSByZWFzb24gd2UgbmVlZCB0byBjaGVjayBxdWV1ZV9lbmFibGUoKSBo
ZXJlPwoKVGhhbmtzCgoKPiArCXZxLT5yZXNldCA9IFZJUlRJT19WUV9SRVNFVF9TVEVQX05PTkU7
Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gICBzdGF0aWMgdTE2IHZwX2NvbmZpZ192ZWN0
b3Ioc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYsIHUxNiB2ZWN0b3IpCj4gICB7Cj4g
ICAJcmV0dXJuIHZwX21vZGVybl9jb25maWdfdmVjdG9yKCZ2cF9kZXYtPm1kZXYsIHZlY3Rvcik7
Cj4gQEAgLTQwNyw2ICs0ODYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdf
b3BzIHZpcnRpb19wY2lfY29uZmlnX25vZGV2X29wcyA9IHsKPiAgIAkuc2V0X3ZxX2FmZmluaXR5
ID0gdnBfc2V0X3ZxX2FmZmluaXR5LAo+ICAgCS5nZXRfdnFfYWZmaW5pdHkgPSB2cF9nZXRfdnFf
YWZmaW5pdHksCj4gICAJLmdldF9zaG1fcmVnaW9uICA9IHZwX2dldF9zaG1fcmVnaW9uLAo+ICsJ
LnJlc2V0X3ZxCSA9IHZwX21vZGVybl9yZXNldF92cSwKPiArCS5lbmFibGVfcmVzZXRfdnEgPSB2
cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0X3ZxLAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIGNvbnN0IHN0
cnVjdCB2aXJ0aW9fY29uZmlnX29wcyB2aXJ0aW9fcGNpX2NvbmZpZ19vcHMgPSB7Cj4gQEAgLTQy
NSw2ICs1MDYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRp
b19wY2lfY29uZmlnX29wcyA9IHsKPiAgIAkuc2V0X3ZxX2FmZmluaXR5ID0gdnBfc2V0X3ZxX2Fm
ZmluaXR5LAo+ICAgCS5nZXRfdnFfYWZmaW5pdHkgPSB2cF9nZXRfdnFfYWZmaW5pdHksCj4gICAJ
LmdldF9zaG1fcmVnaW9uICA9IHZwX2dldF9zaG1fcmVnaW9uLAo+ICsJLnJlc2V0X3ZxCSA9IHZw
X21vZGVybl9yZXNldF92cSwKPiArCS5lbmFibGVfcmVzZXRfdnEgPSB2cF9tb2Rlcm5fZW5hYmxl
X3Jlc2V0X3ZxLAo+ICAgfTsKPiAgIAo+ICAgLyogdGhlIFBDSSBwcm9iaW5nIGZ1bmN0aW9uICov
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
