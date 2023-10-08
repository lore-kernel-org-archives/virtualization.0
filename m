Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4889CE95A8E
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB3E181799;
	Sun,  8 Oct 2023 04:31:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB3E181799
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDfrwUoa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yx3X5Hd9oEqs; Sun,  8 Oct 2023 04:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43DAB8176C;
	Sun,  8 Oct 2023 04:31:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43DAB8176C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19025C0071;
	Sun,  8 Oct 2023 04:31:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA93AC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B13AE41955
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B13AE41955
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDfrwUoa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CSoWlQPIUM0i
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:31:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEF9141953
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:31:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEF9141953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696739483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPw8/pN0gBELe3wZwgeZ9xv7HGmgrQQK4VXX4QJ1Lk8=;
 b=YDfrwUoaQ8kTGZ37t6pQ0IPbkPUfcn+UI+Pe5WuTRBe8WYZwZjw7j85QAxCEWM/iSmazTL
 DgWFPQRq3lSlGQ8vZlYXriZK2y+mpGjQ2jXjTyP+OzgYW8pWdE6mCptnLojQcdMhEP6JGn
 9OB3qgBf0I+Y48p/K/ncUColaAs1NcA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-50uRrqAiOlSTqamIH8AFmg-1; Sun, 08 Oct 2023 00:31:17 -0400
X-MC-Unique: 50uRrqAiOlSTqamIH8AFmg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50483ed1172so266646e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696739475; x=1697344275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPw8/pN0gBELe3wZwgeZ9xv7HGmgrQQK4VXX4QJ1Lk8=;
 b=PxzSurF/wjJIgndd62BkKZ6TlBgzMAT1dB3BhIOVSaME+yxA/CGBf9X7JDTcyyWIvz
 hiyIHdBUHi+OBetuAPOthPXgK4nlmqg6wXrpc9433KCbjussBNSMgQ6CgHTGA0DXqZCI
 9lbdl18LQmiJ+BeynTn9xGCKQ0eI/8KqbRveby7uVZXneeVbiV8/4wCFwDFUhKp57NjQ
 OZEPLoiYo7ou+THSlS15ZZ/IkDCVXeXvrvTagQ7K6oDtHn/kyQiyLLXyRUVzrqxJEaW8
 3CP088NBzNm7sSbD0SrQ68xQdwRDSkVSGrRPcNVfwrrPss2RjLZou/Xs0UfZr8IgT03J
 PrrQ==
X-Gm-Message-State: AOJu0YwUKR76r2qwpxwERGWzRN0bsVUKQezR2xW7WNOFQOMsn+CKrukG
 ZwuUZvN6HDpjJu4F+SiNM8jQOhq7le9UeLBHy1VIuQkh9ldW1D/1TP29/phwXFGNQ5yb1FDs0m2
 gySpb2n6kSxNytdDcoctoYsHeCkjOUa7S9wv5ehA5co+HDpJnGziwvwQZtQ==
X-Received: by 2002:a05:6512:230d:b0:500:b7ed:105a with SMTP id
 o13-20020a056512230d00b00500b7ed105amr13100670lfu.29.1696739475630; 
 Sat, 07 Oct 2023 21:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jZpo+s8ScauMDsaeTBt1P1hEncbOVacCg5EesWoXqzhpKcrJyrUxDGMogFHMSvQpAmZs1xhLh4qw7cIJH14=
X-Received: by 2002:a05:6512:230d:b0:500:b7ed:105a with SMTP id
 o13-20020a056512230d00b00500b7ed105amr13100658lfu.29.1696739475312; Sat, 07
 Oct 2023 21:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230925035830.117710-1-xuanzhuo@linux.alibaba.com>
 <20230925035830.117710-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230925035830.117710-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:31:03 +0800
Message-ID: <CACGkMEvQT2=LviVvxe=+L1pbXWxH+82C3m_ZttQcKqjRTGcw3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_pci: fix the common map size and add check for
 vq-reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMTE6NTjigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE5vdywgdGhlIGZ1bmN0aW9uIHZwX21vZGVybl9t
YXBfY2FwYWJpbGl0eSgpIHRha2VzIHRoZSBzaXplIHBhcmFtZXRlciwKPiB3aGljaCBjb3JyZXNw
b25kcyB0byB0aGUgc2l6ZSBvZiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcuIEFzIGEgcmVzdWx0LCB0
aGUKPiBwY2lfaW9tYXBfcmFuZ2UoKSBmdW5jdGlvbiBtYXBzIHRoZSBtZW1vcnkgYXJlYSBmb3IK
PiB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcuCj4KPiBIb3dldmVyLCBpZiB0aGUgX0ZfUklOR19SRVNF
VCBpcyBuZWdvdGlhdGVkLCB0aGUgZXh0cmEgaXRlbXMgd2lsbCBiZQo+IHVzZWQuIFRoZXJlZm9y
ZSwgd2UgbmVlZCB0byB1c2UgdGhlIHNpemUgb2YgdmlydGlvX3BjaV9tb2RyZV9jb21tb25fY2Zn
Cj4gdG8gbWFwIG1vcmUgc3BhY2UuCj4KPiBNZWFud2hpbGUsIEkgaGF2ZSBpbnRyb2R1Y2VkIGEg
bmV3IHZhcmlhYmxlIGNhbGxlZCBjb21tb25fbGVuIGluIHRoZQo+IG1kZXYuIFRoaXMgYWxsb3dz
IHVzIHRvIGNoZWNrIGNvbW1vbl9sZW4gd2hlbiBhY2Nlc3NpbmcgdGhlIG5ldyBpdGVtIG9mCj4g
dmlydGlvX3BjaV9tb2RyZV9jb21tb25fY2ZnLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCA4ICsrKysrKy0tCj4gIGluY2x1ZGUvbGludXgvdmlydGlv
X3BjaV9tb2Rlcm4uaCAgICAgIHwgMSArCj4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbW9kZXJuX2Rldi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2
LmMKPiBpbmRleCBhYWQ3ZDkyOTZlNzcuLmVmNjY2N2RlMWIzOCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybl9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4gQEAgLTI5MSw4ICsyOTEsOCBAQCBpbnQgdnBfbW9k
ZXJuX3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYpCj4gICAgICAg
ICBlcnIgPSAtRUlOVkFMOwo+ICAgICAgICAgbWRldi0+Y29tbW9uID0gdnBfbW9kZXJuX21hcF9j
YXBhYmlsaXR5KG1kZXYsIGNvbW1vbiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZihzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnKSwgNCwKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIHNpemVvZihzdHJ1Y3QgdmlydGlvX3Bj
aV9jb21tb25fY2ZnKSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5V
TEwsIE5VTEwpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgc2l6
ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnKSwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZtZGV2LT5jb21tb25fbGVuLCBOVUxMKTsKPiAgICAg
ICAgIGlmICghbWRldi0+Y29tbW9uKQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9tYXBfY29t
bW9uOwo+ICAgICAgICAgbWRldi0+aXNyID0gdnBfbW9kZXJuX21hcF9jYXBhYmlsaXR5KG1kZXYs
IGlzciwgc2l6ZW9mKHU4KSwgMSwKPiBAQCAtNDkzLDYgKzQ5Myw4IEBAIGludCB2cF9tb2Rlcm5f
Z2V0X3F1ZXVlX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UgKm1kZXYsIHUx
NiBpbmRleCkKPiAgewo+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9j
ZmcgX19pb21lbSAqY2ZnOwo+Cj4gKyAgICAgICBCVUdfT04obWRldi0+Y29tbW9uX2xlbiA8IG9m
ZnNldG9mZW5kKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnLCBxdWV1ZV9yZXNl
dCkpOwoKSW5zdGVhZCBvZiB1c2luZyBCVUcgZm9yIGJ1Z2d5IGhhcmR3YXJlLCB3aHkgbm90IHNp
bXBseSBmYWlsIHRoZSBwcm9iZQppbiB0aGlzIGNhc2U/CgpUaGFua3MKCj4gKwo+ICAgICAgICAg
Y2ZnID0gKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnIF9faW9tZW0gKiltZGV2
LT5jb21tb247Cj4KPiAgICAgICAgIHZwX2lvd3JpdGUxNihpbmRleCwgJmNmZy0+Y2ZnLnF1ZXVl
X3NlbGVjdCk7Cj4gQEAgLTUwOSw2ICs1MTEsOCBAQCB2b2lkIHZwX21vZGVybl9zZXRfcXVldWVf
cmVzZXQoc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAqbWRldiwgdTE2IGluZGV4KQo+
ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fY29tbW9uX2NmZyBfX2lvbWVt
ICpjZmc7Cj4KPiArICAgICAgIEJVR19PTihtZGV2LT5jb21tb25fbGVuIDwgb2Zmc2V0b2ZlbmQo
c3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcsIHF1ZXVlX3Jlc2V0KSk7Cj4gKwo+
ICAgICAgICAgY2ZnID0gKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnIF9faW9t
ZW0gKiltZGV2LT5jb21tb247Cj4KPiAgICAgICAgIHZwX2lvd3JpdGUxNihpbmRleCwgJmNmZy0+
Y2ZnLnF1ZXVlX3NlbGVjdCk7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3Bj
aV9tb2Rlcm4uaCBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+IGluZGV4IDA2
N2FjMWQ3ODliYy4uZWRmNjJiYWUwNDc0IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaAo+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4u
aAo+IEBAIC0yOCw2ICsyOCw3IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2Ugewo+
ICAgICAgICAgLyogU28gd2UgY2FuIHNhbml0eS1jaGVjayBhY2Nlc3Nlcy4gKi8KPiAgICAgICAg
IHNpemVfdCBub3RpZnlfbGVuOwo+ICAgICAgICAgc2l6ZV90IGRldmljZV9sZW47Cj4gKyAgICAg
ICBzaXplX3QgY29tbW9uX2xlbjsKPgo+ICAgICAgICAgLyogQ2FwYWJpbGl0eSBmb3Igd2hlbiB3
ZSBuZWVkIHRvIG1hcCBub3RpZmljYXRpb25zIHBlci12cS4gKi8KPiAgICAgICAgIGludCBub3Rp
ZnlfbWFwX2NhcDsKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
