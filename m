Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2974EC43334
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1474422E2;
	Thu, 21 Jul 2022 09:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1474422E2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WcfiQiRA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x2hc_0OiOFfW; Thu, 21 Jul 2022 09:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDB82422DD;
	Thu, 21 Jul 2022 09:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDB82422DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8093DC0033;
	Thu, 21 Jul 2022 09:15:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4620C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B6AC405EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B6AC405EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WcfiQiRA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfc3wTMnkjAY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C4C04018F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C4C04018F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658394926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKluuKiO4nPSBSIDesJ3n2h9tlkDSbj9xB+0JNp3iV8=;
 b=WcfiQiRAlmV74e9X8N+DVGVpVH/kZ3ZNYRkxl3VSsuectEykOLvVvc3PH5wa+k19T8PCwc
 LDhzLNQa/OQHYPprT0xYIV/RmlUeaOPCMU38Dnc0kupVG4i2tuL4Ed1Y81Dru0fa09cZe9
 ID8EdEBQDNYSl2yiueVvkT0cXjXeE0w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-6cz-6bDkPIe5HSRQM9GR4w-1; Thu, 21 Jul 2022 05:15:24 -0400
X-MC-Unique: 6cz-6bDkPIe5HSRQM9GR4w-1
Received: by mail-pj1-f72.google.com with SMTP id
 b10-20020a17090a6e0a00b001f221432098so568734pjk.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PKluuKiO4nPSBSIDesJ3n2h9tlkDSbj9xB+0JNp3iV8=;
 b=L3N2/U6gZ1kf5Fdfir2SNluNAjWqVygULx3xL9i47rtWGTHi9ZXb9ZbWwY3i5NgJU7
 idMy+eZVnaKsXF36MA+1BW2asS/rMSJ9A5qUnib100VzEUedFfFaD0mkvfE9XlaH1wL6
 TQbi1L+vNqos3huD1w9TJCh6DHd5A2y8coZhWDfBAKNuhGBUC6L2H3720Roy/6he8Wvd
 oKiwsh8X8PiEj8YoF7pTEzoj4TUGNeAgwCyFsk2QUaVmfNbEim8vNROI2BQgpckrVqv0
 G+x6zsD4/J1HvfPgmslGbh3iuIQVMFUBInz1RGFG8Inxlb9k3MW/Df1/9dIymIuveqbN
 EY2g==
X-Gm-Message-State: AJIora9hS/XebEbLy3J0BdizMLGaoFcX7R10NYhuem+rKq8prH2nEnfH
 HiTpT4weN7gKlHcgvri1mzJnf2+2nTZ62NfBfJumJga3tWImKMWuNx/VozlbdEIx9Zs49sO6DCB
 aTQkT3tVPKfHgVhduLzVjYLaEvyie/Hqz+hkUK2f6rw==
X-Received: by 2002:a65:42cc:0:b0:3a9:f71f:33f9 with SMTP id
 l12-20020a6542cc000000b003a9f71f33f9mr36793840pgp.391.1658394923330; 
 Thu, 21 Jul 2022 02:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sgEw6i8bsR36Y8ICw8UMYj7/O02SOjej4lcmI0dJ1BovICarsVAAvAc6/oM7JcSOz5o3pTJA==
X-Received: by 2002:a65:42cc:0:b0:3a9:f71f:33f9 with SMTP id
 l12-20020a6542cc000000b003a9f71f33f9mr36793799pgp.391.1658394922973; 
 Thu, 21 Jul 2022 02:15:22 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a170902e19400b0016c35b21901sm1077023pla.195.2022.07.21.02.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:15:22 -0700 (PDT)
Message-ID: <efb6adca-a2a8-98d2-5604-5482d8be6ec9@redhat.com>
Date: Thu, 21 Jul 2022 17:15:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 30/40] virtio_pci: support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-31-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-31-xuanzhuo@linux.alibaba.com>
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

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIHZpcnRpbyBwY2kgc3VwcG9ydCBmb3IgUVVFVUUgUkVTRVQuCj4KPiBQZXJmb3JtaW5n
IHJlc2V0IG9uIGEgcXVldWUgaXMgZGl2aWRlZCBpbnRvIHRoZXNlIHN0ZXBzOgo+Cj4gICAxLiBu
b3RpZnkgdGhlIGRldmljZSB0byByZXNldCB0aGUgcXVldWUKPiAgIDIuIHJlY3ljbGUgdGhlIGJ1
ZmZlciBzdWJtaXR0ZWQKPiAgIDMuIHJlc2V0IHRoZSB2cmluZyAobWF5IHJlLWFsbG9jKQo+ICAg
NC4gbW1hcCB2cmluZyB0byBkZXZpY2UsIGFuZCBlbmFibGUgdGhlIHF1ZXVlCj4KPiBUaGlzIHBh
dGNoIGltcGxlbWVudHMgdmlydGlvX3Jlc2V0X3ZxKCksIHZpcnRpb19lbmFibGVfcmVzZXRxKCkg
aW4gdGhlCj4gcGNpIHNjZW5hcmlvLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfY29tbW9uLmMgfCAxMiArKystCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVy
bi5jIHwgOTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDEwNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2NvbW1vbi5jCj4gaW5kZXggY2E1MWZjYzlkYWFiLi5hZDI1OGE5ZDNiOWYgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiBAQCAtMjE0LDkgKzIxNCwxNSBAQCBzdGF0aWMg
dm9pZCB2cF9kZWxfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gICAJc3RydWN0IHZpcnRpb19w
Y2lfdnFfaW5mbyAqaW5mbyA9IHZwX2Rldi0+dnFzW3ZxLT5pbmRleF07Cj4gICAJdW5zaWduZWQg
bG9uZyBmbGFnczsKPiAgIAo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxh
Z3MpOwo+IC0JbGlzdF9kZWwoJmluZm8tPm5vZGUpOwo+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4gKwkvKgo+ICsJICogSWYgaXQgZmFpbHMgZHVyaW5n
IHJlLWVuYWJsZSByZXNldCB2cS4gVGhpcyB3YXkgd2Ugd29uJ3QgcmVqb2luCj4gKwkgKiBpbmZv
LT5ub2RlIHRvIHRoZSBxdWV1ZS4gUHJldmVudCB1bmV4cGVjdGVkIGlycXMuCj4gKwkgKi8KPiAr
CWlmICghdnEtPnJlc2V0KSB7Cj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywg
ZmxhZ3MpOwo+ICsJCWxpc3RfZGVsKCZpbmZvLT5ub2RlKTsKPiArCQlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPiArCX0KPiAgIAo+ICAgCXZwX2Rldi0+ZGVs
X3ZxKGluZm8pOwo+ICAgCWtmcmVlKGluZm8pOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX21vZGVybi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4u
Ywo+IGluZGV4IDkwNDFkOWE0MWI3ZC4uNGQyOGI2OTE4YzgwIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX21vZGVybi5jCj4gQEAgLTM0LDYgKzM0LDkgQEAgc3RhdGljIHZvaWQgdnBfdHJhbnNw
b3J0X2ZlYXR1cmVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4g
ICAJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfU1JfSU9WKSkgJiYKPiAgIAkJCXBj
aV9maW5kX2V4dF9jYXBhYmlsaXR5KHBjaV9kZXYsIFBDSV9FWFRfQ0FQX0lEX1NSSU9WKSkKPiAg
IAkJX192aXJ0aW9fc2V0X2JpdCh2ZGV2LCBWSVJUSU9fRl9TUl9JT1YpOwo+ICsKPiArCWlmIChm
ZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX0ZfUklOR19SRVNFVCkpCj4gKwkJX192aXJ0aW9fc2V0
X2JpdCh2ZGV2LCBWSVJUSU9fRl9SSU5HX1JFU0VUKTsKPiAgIH0KPiAgIAo+ICAgLyogdmlydGlv
IGNvbmZpZy0+ZmluYWxpemVfZmVhdHVyZXMoKSBpbXBsZW1lbnRhdGlvbiAqLwo+IEBAIC0xOTks
NiArMjAyLDk1IEBAIHN0YXRpYyBpbnQgdnBfYWN0aXZlX3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZx
LCB1MTYgbXNpeF92ZWMpCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2
cF9tb2Rlcm5fcmVzZXRfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPiArCXN0
cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsJ
c3RydWN0IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbzsKPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
Cj4gKwo+ICsJaWYgKCF2aXJ0aW9faGFzX2ZlYXR1cmUodnEtPnZkZXYsIFZJUlRJT19GX1JJTkdf
UkVTRVQpKQo+ICsJCXJldHVybiAtRU5PRU5UOwo+ICsKPiArCXZwX21vZGVybl9zZXRfcXVldWVf
cmVzZXQobWRldiwgdnEtPmluZGV4KTsKPiArCj4gKwlpbmZvID0gdnBfZGV2LT52cXNbdnEtPmlu
ZGV4XTsKPiArCj4gKwkvKiBkZWxldGUgdnEgZnJvbSBpcnEgaGFuZGxlciAqLwo+ICsJc3Bpbl9s
b2NrX2lycXNhdmUoJnZwX2Rldi0+bG9jaywgZmxhZ3MpOwo+ICsJbGlzdF9kZWwoJmluZm8tPm5v
ZGUpOwo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4g
Kwo+ICsJSU5JVF9MSVNUX0hFQUQoJmluZm8tPm5vZGUpOwo+ICsKPiArCS8qIEZvciB0aGUgY2Fz
ZSB3aGVyZSB2cSBoYXMgYW4gZXhjbHVzaXZlIGlycSwgdG8gcHJldmVudCB0aGUgaXJxIGZyb20K
PiArCSAqIGJlaW5nIHJlY2VpdmVkIGFnYWluIGFuZCB0aGUgcGVuZGluZyBpcnEsIGNhbGwgc3lu
Y2hyb25pemVfaXJxKCksIGFuZAo+ICsJICogYnJlYWsgaXQuCj4gKwkgKgo+ICsJICogV2UgY2Fu
J3QgdXNlIGRpc2FibGVfaXJxKCkgc2luY2UgaXQgY29uZmxpY3RzIHdpdGggdGhlIGFmZmluaXR5
Cj4gKwkgKiBtYW5hZ2VkIElSUSB0aGF0IGlzIHVzZWQgYnkgc29tZSBkcml2ZXJzLiBTbyB0aGlz
IGlzIGRvbmUgb24gdG9wIG9mCj4gKwkgKiBJUlEgaGFyZGVuaW5nLgo+ICsJICoKPiArCSAqIElu
IHRoZSBzY2VuYXJpbyBiYXNlZCBvbiBzaGFyZWQgaW50ZXJydXB0cywgdnEgd2lsbCBiZSBzZWFy
Y2hlZCBmcm9tCj4gKwkgKiB0aGUgcXVldWUgdmlydHF1ZXVlcy4gU2luY2UgdGhlIHByZXZpb3Vz
IGxpc3RfZGVsKCkgaGFzIGJlZW4gZGVsZXRlZAo+ICsJICogZnJvbSB0aGUgcXVldWUsIGl0IGlz
IGltcG9zc2libGUgZm9yIHZxIHRvIGJlIGNhbGxlZCBpbiB0aGlzIGNhc2UuCj4gKwkgKiBUaGVy
ZSBpcyBubyBuZWVkIHRvIGNsb3NlIHRoZSBjb3JyZXNwb25kaW5nIGludGVycnVwdC4KPiArCSAq
Lwo+ICsJaWYgKHZwX2Rldi0+cGVyX3ZxX3ZlY3RvcnMgJiYgaW5mby0+bXNpeF92ZWN0b3IgIT0g
VklSVElPX01TSV9OT19WRUNUT1IpIHsKPiArI2lmZGVmIENPTkZJR19WSVJUSU9fSEFSREVOX05P
VElGSUNBVElPTgo+ICsJCV9fdmlydHF1ZXVlX2JyZWFrKHZxKTsKPiArI2VuZGlmCgoKSSB0aGlu
ayB3ZSBzaG91bGQgZG8gdGhpcyB1bmNvbmRpdGlvbmFsbHkgc2luY2UgaXQncyBhbiBpbmRlcGVu
ZGVudCAKZmVhdHVyZSwgdGhvdWdoIHRoZSBsaXN0X2RlbCgpIGFib3ZlIHNob3VsZCBiZSBzdWZm
aWNpZW50LgoKCj4gKwkJc3luY2hyb25pemVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNp
X2RldiwgaW5mby0+bXNpeF92ZWN0b3IpKTsKPiArCX0KPiArCj4gKwl2cS0+cmVzZXQgPSB0cnVl
Owo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IHZwX21vZGVybl9lbmFi
bGVfcmVzZXRfdnEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXN0cnVjdCB2aXJ0aW9f
cGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPiArCXN0cnVjdCB2
aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYgPSAmdnBfZGV2LT5tZGV2Owo+ICsJc3RydWN0
IHZpcnRpb19wY2lfdnFfaW5mbyAqaW5mbzsKPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3MsIGluZGV4
Owo+ICsJaW50IGVycjsKPiArCj4gKwlpZiAoIXZxLT5yZXNldCkKPiArCQlyZXR1cm4gLUVCVVNZ
Owo+ICsKPiArCWluZGV4ID0gdnEtPmluZGV4Owo+ICsJaW5mbyA9IHZwX2Rldi0+dnFzW2luZGV4
XTsKPiArCj4gKwlpZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9yZXNldChtZGV2LCBpbmRleCkpCj4g
KwkJcmV0dXJuIC1FQlVTWTsKPiArCj4gKwlpZiAodnBfbW9kZXJuX2dldF9xdWV1ZV9lbmFibGUo
bWRldiwgaW5kZXgpKQo+ICsJCXJldHVybiAtRUJVU1k7Cj4gKwo+ICsJZXJyID0gdnBfYWN0aXZl
X3ZxKHZxLCBpbmZvLT5tc2l4X3ZlY3Rvcik7Cj4gKwlpZiAoZXJyKQo+ICsJCXJldHVybiBlcnI7
Cj4gKwo+ICsJaWYgKHZxLT5jYWxsYmFjaykgewo+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZ2cF9k
ZXYtPmxvY2ssIGZsYWdzKTsKPiArCQlsaXN0X2FkZCgmaW5mby0+bm9kZSwgJnZwX2Rldi0+dmly
dHF1ZXVlcyk7Cj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdnBfZGV2LT5sb2NrLCBmbGFn
cyk7Cj4gKwl9IGVsc2Ugewo+ICsJCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5ub2RlKTsKPiArCX0K
PiArCj4gKyNpZmRlZiBDT05GSUdfVklSVElPX0hBUkRFTl9OT1RJRklDQVRJT04KPiArCWlmICh2
cF9kZXYtPnBlcl92cV92ZWN0b3JzICYmIGluZm8tPm1zaXhfdmVjdG9yICE9IFZJUlRJT19NU0lf
Tk9fVkVDVE9SKQo+ICsJCV9fdmlydHF1ZXVlX3VuYnJlYWsodnEpOwo+ICsjZW5kaWYKPiArCj4g
Kwl2cF9tb2Rlcm5fc2V0X3F1ZXVlX2VuYWJsZSgmdnBfZGV2LT5tZGV2LCBpbmRleCwgdHJ1ZSk7
Cj4gKwl2cS0+cmVzZXQgPSBmYWxzZTsKPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiAgIHN0
YXRpYyB1MTYgdnBfY29uZmlnX3ZlY3RvcihzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2Rl
diwgdTE2IHZlY3RvcikKPiAgIHsKPiAgIAlyZXR1cm4gdnBfbW9kZXJuX2NvbmZpZ192ZWN0b3Io
JnZwX2Rldi0+bWRldiwgdmVjdG9yKTsKPiBAQCAtNDEzLDYgKzUwNSw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgdmlydGlvX3BjaV9jb25maWdfbm9kZXZfb3BzID0g
ewo+ICAgCS5zZXRfdnFfYWZmaW5pdHkgPSB2cF9zZXRfdnFfYWZmaW5pdHksCj4gICAJLmdldF92
cV9hZmZpbml0eSA9IHZwX2dldF92cV9hZmZpbml0eSwKPiAgIAkuZ2V0X3NobV9yZWdpb24gID0g
dnBfZ2V0X3NobV9yZWdpb24sCj4gKwkuZGlzYWJsZV92cV9hbmRfcmVzZXQgPSB2cF9tb2Rlcm5f
cmVzZXRfdnEsCj4gKwkuZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0ID0gdnBfbW9kZXJuX2VuYWJsZV9y
ZXNldF92cSwKCgpOaXQ6CgpUbyBiZSBjb25zaXN0ZW50LCBsZXQncyB1c2UgdnBfbW9kZXJuX2Rp
c2FibGVfdnFfYW5kX3Jlc2V0KCkgYW5kIAp2cF9tb2Rlcm5fZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0
KCkKClRoYW5rcwoKCj4gICB9Owo+ICAgCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19j
b25maWdfb3BzIHZpcnRpb19wY2lfY29uZmlnX29wcyA9IHsKPiBAQCAtNDMxLDYgKzUyNSw4IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgdmlydGlvX3BjaV9jb25maWdf
b3BzID0gewo+ICAgCS5zZXRfdnFfYWZmaW5pdHkgPSB2cF9zZXRfdnFfYWZmaW5pdHksCj4gICAJ
LmdldF92cV9hZmZpbml0eSA9IHZwX2dldF92cV9hZmZpbml0eSwKPiAgIAkuZ2V0X3NobV9yZWdp
b24gID0gdnBfZ2V0X3NobV9yZWdpb24sCj4gKwkuZGlzYWJsZV92cV9hbmRfcmVzZXQgPSB2cF9t
b2Rlcm5fcmVzZXRfdnEsCj4gKwkuZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0ID0gdnBfbW9kZXJuX2Vu
YWJsZV9yZXNldF92cSwKPiAgIH07Cj4gICAKPiAgIC8qIHRoZSBQQ0kgcHJvYmluZyBmdW5jdGlv
biAqLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
