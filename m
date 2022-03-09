Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC7C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 06:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BCB683ED4;
	Wed,  9 Mar 2022 06:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nlzWxgnLRfv; Wed,  9 Mar 2022 06:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95D6383E2E;
	Wed,  9 Mar 2022 06:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62B73C001D;
	Wed,  9 Mar 2022 06:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 621CFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BD6783E4E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V_xmahy675tH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:16:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B9DD83E2E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646806608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCQcksPUdMm6JmcA9ctdwilmGIj2X4aiFpqmKR/hAfU=;
 b=RuqXPnyKGDX5pn94/YiKbVjmA8PvLbp3RYsgVY/OKUidBsLrLXPOb/ZL3ojpIrFLN7LAcM
 m53awBlTJSOtbR08AdJ8x4+LRxlUmcJYVjhszQruEScqRpvLPzSxQZ7KwiVINXghtsPUNW
 ZNJpB3CAttFirQmFA7iU7LyrH0G6Zjs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-nM9vLgU4P8OzyOMVPoOGpQ-1; Wed, 09 Mar 2022 01:16:45 -0500
X-MC-Unique: nM9vLgU4P8OzyOMVPoOGpQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 b9-20020a17090aa58900b001b8b14b4aabso975833pjq.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 22:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cCQcksPUdMm6JmcA9ctdwilmGIj2X4aiFpqmKR/hAfU=;
 b=qFlQY4IeHga5CyTfJW8KqDb9OfLtBBr4/zf80lxH6LwthyrZzqEAExTLyBOSnJvQ67
 xHNYj2ln+PVehFL++zcLe2p99ez8khatS1iWxGQsQ6eR+nbAcyX2HEcXzMthBEbCBiz6
 iKPQQ0pNsJ4iHX1Zvl1CeYiYyHrf4F+xVG86hgGMemeBMPwQhQAbbfYN7niLwXOaf1vU
 QBD2SptwYth3+W5EF6PyPbkhPi0f0grCs3V4ISBY1MK5ZKaC9LGDCX1zwsTdgrFKAo0k
 fCzV9sj8A7chcjuhCf+wL1nWrVyakQ2AuCP2ebSe9r6867kEK77XKj9XLYOXOnS61/ie
 94xw==
X-Gm-Message-State: AOAM532Q8bgUlYupTX/sp9cRl7DqtJs50PNWLpfaEK4RlWpY7N8Okjkx
 124EF55QRSCBsfQzpZKLGnnnl/zEvWLfvHlYDeBnR4rLy1fXqSlt5Ie4UB+8Ky61d9Rb9UnK3pC
 UDbS4rcxGGWHkwnEoOg3r9c4BzZ25so6xXV0GcFmVMg==
X-Received: by 2002:a17:902:e886:b0:151:ed65:fd87 with SMTP id
 w6-20020a170902e88600b00151ed65fd87mr13425805plg.161.1646806604250; 
 Tue, 08 Mar 2022 22:16:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxc7JR6EeBP4D90Qf0GHA8SP34qXakttaCcRONqPxoLgaicEsxymwyeChsATy9iRlCgcuMRYA==
X-Received: by 2002:a17:902:e886:b0:151:ed65:fd87 with SMTP id
 w6-20020a170902e88600b00151ed65fd87mr13425762plg.161.1646806603957; 
 Tue, 08 Mar 2022 22:16:43 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z2-20020aa79902000000b004f75842c97csm994252pff.209.2022.03.08.22.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Mar 2022 22:16:43 -0800 (PST)
Message-ID: <10c67feb-fe4a-9370-23a6-efc90532700d@redhat.com>
Date: Wed, 9 Mar 2022 14:16:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 03/26] virtio: add helper virtqueue_get_vring_max_size()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-4-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g5YaZ6YGTOgo+IFJlY29yZCB0aGUg
bWF4aW11bSBxdWV1ZSBudW0gc3VwcG9ydGVkIGJ5IHRoZSBkZXZpY2UuCj4KPiB2aXJ0aW8tbmV0
IGNhbiBkaXNwbGF5IHRoZSBtYXhpbXVtIChzdXBwb3J0ZWQgYnkgaGFyZHdhcmUpIHJpbmcgc2l6
ZSBpbgo+IGV0aHRvb2wgLWcgZXRoMC4KPgo+IFdoZW4gdGhlIHN1YnNlcXVlbnQgcGF0Y2ggaW1w
bGVtZW50cyB2cmluZyByZXNldCwgaXQgY2FuIGp1ZGdlIHdoZXRoZXIKPiB0aGUgcmluZyBzaXpl
IHBhc3NlZCBieSB0aGUgZHJpdmVyIGlzIGxlZ2FsIGJhc2VkIG9uIHRoaXMuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fbW1pby5jICAgICAgIHwgIDIgKysKPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbGVnYWN5LmMgfCAgMiArKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rl
cm4uYyB8ICAyICsrCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICAgIHwgMTQg
KysrKysrKysrKysrKysKPiAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAgICAgfCAg
MiArKwo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19t
bWlvLmMKPiBpbmRleCA1NjEyOGI5YzQ2ZWIuLmE0MWFiYzgwNTFiOSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X21taW8uYwo+IEBAIC0zOTAsNiArMzkwLDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZt
X3NldHVwX3ZxKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbmRleCwKPiAg
IAkJZ290byBlcnJvcl9uZXdfdmlydHF1ZXVlOwo+ICAgCX0KPiAgIAo+ICsJdnEtPm51bV9tYXgg
PSBudW07Cj4gKwo+ICAgCS8qIEFjdGl2YXRlIHRoZSBxdWV1ZSAqLwo+ICAgCXdyaXRlbCh2aXJ0
cXVldWVfZ2V0X3ZyaW5nX3NpemUodnEpLCB2bV9kZXYtPmJhc2UgKyBWSVJUSU9fTU1JT19RVUVV
RV9OVU0pOwo+ICAgCWlmICh2bV9kZXYtPnZlcnNpb24gPT0gMSkgewo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9sZWdhY3kuYwo+IGluZGV4IDM0MTQxYjlhYmUyNy4uYjY4OTM0ZmU2YjVkIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gQEAgLTEzNSw2ICsxMzUsOCBAQCBzdGF0aWMg
c3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9k
ZXYsCj4gICAJaWYgKCF2cSkKPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gICAKPiAr
CXZxLT5udW1fbWF4ID0gbnVtOwo+ICsKPiAgIAlxX3BmbiA9IHZpcnRxdWV1ZV9nZXRfZGVzY19h
ZGRyKHZxKSA+PiBWSVJUSU9fUENJX1FVRVVFX0FERFJfU0hJRlQ7Cj4gICAJaWYgKHFfcGZuID4+
IDMyKSB7Cj4gICAJCWRldl9lcnIoJnZwX2Rldi0+cGNpX2Rldi0+ZGV2LAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIGIvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm4uYwo+IGluZGV4IDU0NTViYzA0MWZiNi4uODZkMzAxZjI3MmI4IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gQEAgLTIxOCw2ICsyMTgsOCBAQCBzdGF0
aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2
cF9kZXYsCj4gICAJaWYgKCF2cSkKPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gICAK
PiArCXZxLT5udW1fbWF4ID0gbnVtOwo+ICsKPiAgIAkvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8K
PiAgIAl2cF9tb2Rlcm5fc2V0X3F1ZXVlX3NpemUobWRldiwgaW5kZXgsIHZpcnRxdWV1ZV9nZXRf
dnJpbmdfc2l6ZSh2cSkpOwo+ICAgCXZwX21vZGVybl9xdWV1ZV9hZGRyZXNzKG1kZXYsIGluZGV4
LCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRkcih2cSksCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXgg
OTYyZjE0NzdiMWZhLi5iODcxMzBjOGYzMTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAt
MjM3MSw2ICsyMzcxLDIwIEBAIHZvaWQgdnJpbmdfdHJhbnNwb3J0X2ZlYXR1cmVzKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgfQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwodnJpbmdfdHJh
bnNwb3J0X2ZlYXR1cmVzKTsKPiAgIAo+ICsvKioKPiArICogdmlydHF1ZXVlX2dldF92cmluZ19t
YXhfc2l6ZSAtIHJldHVybiB0aGUgbWF4IHNpemUgb2YgdGhlIHZpcnRxdWV1ZSdzIHZyaW5nCj4g
KyAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIGNvbnRhaW5pbmcgdGhlIHZyaW5nIG9mIGlu
dGVyZXN0Lgo+ICsgKgo+ICsgKiBSZXR1cm5zIHRoZSBtYXggc2l6ZSBvZiB0aGUgdnJpbmcuCj4g
KyAqCj4gKyAqIFVubGlrZSBvdGhlciBvcGVyYXRpb25zLCB0aGlzIG5lZWQgbm90IGJlIHNlcmlh
bGl6ZWQuCj4gKyAqLwo+ICt1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF92cmluZ19tYXhfc2l6
ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gK3sKPiArCXJldHVybiBfdnEtPm51bV9tYXg7Cj4g
K30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2dldF92cmluZ19tYXhfc2l6ZSk7Cj4g
Kwo+ICAgLyoqCj4gICAgKiB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUgLSByZXR1cm4gdGhlIHNp
emUgb2YgdGhlIHZpcnRxdWV1ZSdzIHZyaW5nCj4gICAgKiBAX3ZxOiB0aGUgc3RydWN0IHZpcnRx
dWV1ZSBjb250YWluaW5nIHRoZSB2cmluZyBvZiBpbnRlcmVzdC4KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92aXJ0aW8uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiBpbmRleCA3MjI5
MmE2MmNkOTAuLmQ1OWFkYzRiZTA2OCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRp
by5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IEBAIC0zMSw2ICszMSw3IEBAIHN0
cnVjdCB2aXJ0cXVldWUgewo+ICAgCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2Owo+ICAgCXVu
c2lnbmVkIGludCBpbmRleDsKPiAgIAl1bnNpZ25lZCBpbnQgbnVtX2ZyZWU7Cj4gKwl1bnNpZ25l
ZCBpbnQgbnVtX21heDsKPiAgIAl2b2lkICpwcml2Owo+ICAgfTsKPiAgIAo+IEBAIC04MCw2ICs4
MSw3IEBAIGJvb2wgdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHN0cnVjdCB2aXJ0cXVldWUg
KnZxKTsKPiAgIAo+ICAgdm9pZCAqdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKHN0cnVjdCB2
aXJ0cXVldWUgKnZxKTsKPiAgIAo+ICt1bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF92cmluZ19t
YXhfc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gICB1bnNpZ25lZCBpbnQgdmlydHF1ZXVl
X2dldF92cmluZ19zaXplKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPiAgIAo+ICAgYm9vbCB2aXJ0
cXVldWVfaXNfYnJva2VuKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
