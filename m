Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64ECC4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:09:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0061374
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3E0061374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73FCC80B94;
	Tue, 24 Aug 2021 09:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJrTDNKIu5Ss; Tue, 24 Aug 2021 09:09:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2CB5080B66;
	Tue, 24 Aug 2021 09:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083FDC0010;
	Tue, 24 Aug 2021 09:09:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CDF2C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C7924057C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KBR5wT2x2ioM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4392E40541
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629796161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgjNNvJDnjOP6uAT5kbFCQOnfX4vNHBNyPI0u7HlSaY=;
 b=PhOjEZV+DzPor5P8QDcCpGUCp06SH+RhTOQFOSumG5nrNtiIG/qYZekZ4+tltz/XDgMvIW
 NjmMNoaZGBVXhnIub7L6dcmtga5zvMNR/ynu4O11wCRn6rlm39+Fef1EysFy31younKBx1
 5xRBUiyMKP02L+tbm8THFVVcYuTBjYg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Zn0InUliPRuBKHSlQlRFuQ-1; Tue, 24 Aug 2021 05:09:19 -0400
X-MC-Unique: Zn0InUliPRuBKHSlQlRFuQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 u3-20020a6323430000b029023ba96595fdso11842735pgm.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bgjNNvJDnjOP6uAT5kbFCQOnfX4vNHBNyPI0u7HlSaY=;
 b=r0QBCzgh1kwykiQ9ZooO2g7g6YX/3407Vdxn5EnHDzxBFc8N+RjGkpdo5fG3rYQ8p1
 UxmQnBWXWbcKfRSMfX9GqYnIqHECtiuyo0JOwt/J/WIcd2TdjHBGmYOjQ+8ig9WNL9YU
 4RhUmczMSV91zgv1rCTKCO2JVdbzjya5Nbrc/Sdc8fs5SricK4exunQ6oNDFHkvI4brX
 fq8Z30RnTmc/zGSSrVosXHETXEeaepkI1Mv2fcZaaiP57z1JXXrlgfuGLCEfwVwO23vI
 8zOM4EwqzKKoXFWTpAeiRaNZ8oZHHk6BgP+IwxAQTQ61GfrrdOvs9JfG2Jn4u0oSQ/Yl
 dtEQ==
X-Gm-Message-State: AOAM530R8QQNSSOJEs4Ltch2tWdAt7r7rW9u2KPgUsnzjNvYz+n/62Am
 IyEkl6ORn9eIkAAd+I0acALNTSf3Q3MwSXiSGuQIsAqaJbBu2ILv9Qf0YBcya89NK/r6bdY1bJn
 4BNPjx/ir2Qr0+UfWJOMits7L6nAZueqVOlZ8g0/8WA==
X-Received: by 2002:a17:902:cec3:b0:12d:92c4:1ea6 with SMTP id
 d3-20020a170902cec300b0012d92c41ea6mr32362688plg.36.1629796158794; 
 Tue, 24 Aug 2021 02:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaRiEgMG2ThM4OMlvob8Bk5iQ32PUYD1NimTBW0qcgsdmlwEG74boKcrYs1MiQ/vnKplj5qw==
X-Received: by 2002:a17:902:cec3:b0:12d:92c4:1ea6 with SMTP id
 d3-20020a170902cec300b0012d92c41ea6mr32362664plg.36.1629796158540; 
 Tue, 24 Aug 2021 02:09:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t15sm22015596pgi.80.2021.08.24.02.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 02:09:18 -0700 (PDT)
Subject: Re: [PATCH v4 3/6] vdpa/mlx5: Decouple virtqueue callback from struct
 mlx5_vdpa_virtqueue
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210823052123.14909-1-elic@nvidia.com>
 <20210823052123.14909-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a0e89df9-7b34-3c08-ec2d-c31a9f9c0aca@redhat.com>
Date: Tue, 24 Aug 2021 17:09:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823052123.14909-4-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8yMyDPws7nMToyMSwgRWxpIENvaGVuINC0tcA6Cj4gSW5zdGVhZCwgZGVmaW5l
IGFuIGFycmF5IG9mIHN0cnVjdCB2ZHBhX2NhbGxiYWNrIG9uIHN0cnVjdCBtbHg1X3ZkcGFfbmV0
Cj4gYW5kIHVzZSBpdCB0byBzdG9yZSBjYWxsYmFja3MgZm9yIGFueSB2aXJ0cXVldWUgcHJvdmlk
ZWQuIFRoaXMgaXMKPiByZXF1aXJlZCBkdWUgdG8gdGhlIGZhY3QgdGhhdCBjYWxsYmFjayBjb25m
aWd1cmF0aW9ucyBhcnJpdmUgYmVmb3JlIGZlYXR1cmUKPiBuZWdvdGlhdGlvbi4gV2l0aCBjb250
cm9sIFZRIGFuZCBtdWx0aXF1ZXVlIGludHJvZHVjZWQgbmV4dCB3ZSB3YW50IHRvCj4gc2F2ZSB0
aGUgaW5mb3JtYXRpb24gdW50aWwgYWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiB3aGVyZSB3ZSBr
bm93IHRoZQo+IENWUSBpbmRleC4KPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNyArKysrKysr
KystLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCAyNDVjODU5Y2E1YWUu
LjNhZTJlNWFlMmJlMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtOTAs
NyArOTAsNiBAQCBzdHJ1Y3QgbWx4NV92cV9yZXN0b3JlX2luZm8gewo+ICAgCXUxNiBhdmFpbF9p
bmRleDsKPiAgIAl1MTYgdXNlZF9pbmRleDsKPiAgIAlib29sIHJlYWR5Owo+IC0Jc3RydWN0IHZk
cGFfY2FsbGJhY2sgY2I7Cj4gICAJYm9vbCByZXN0b3JlOwo+ICAgfTsKPiAgIAo+IEBAIC0xMDAs
NyArOTksNiBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSB7Cj4gICAJdTY0IGRldmljZV9h
ZGRyOwo+ICAgCXU2NCBkcml2ZXJfYWRkcjsKPiAgIAl1MzIgbnVtX2VudDsKPiAtCXN0cnVjdCB2
ZHBhX2NhbGxiYWNrIGV2ZW50X2NiOwo+ICAgCj4gICAJLyogUmVzb3VyY2VzIGZvciBpbXBsZW1l
bnRpbmcgdGhlIG5vdGlmaWNhdGlvbiBjaGFubmVsIGZyb20gdGhlIGRldmljZQo+ICAgCSAqIHRv
IHRoZSBkcml2ZXIuIGZ3cXAgaXMgdGhlIGZpcm13YXJlIGVuZCBvZiBhbiBSQyBjb25uZWN0aW9u
OyB0aGUKPiBAQCAtMTQwLDYgKzEzOCw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbmV0IHsKPiAgIAlz
dHJ1Y3QgbWx4NV92ZHBhX25ldF9yZXNvdXJjZXMgcmVzOwo+ICAgCXN0cnVjdCB2aXJ0aW9fbmV0
X2NvbmZpZyBjb25maWc7Cj4gICAJc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgdnFzW01MWDVf
TUFYX1NVUFBPUlRFRF9WUVNdOwo+ICsJc3RydWN0IHZkcGFfY2FsbGJhY2sgZXZlbnRfY2JzW01M
WDVfTUFYX1NVUFBPUlRFRF9WUVMgKyAxXTsKPiAgIAo+ICAgCS8qIFNlcmlhbGl6ZSB2cSByZXNv
dXJjZXMgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uLiBUaGlzIGlzIHJlcXVpcmVkCj4gICAJICog
c2luY2UgbWVtb3J5IG1hcCBtaWdodCBjaGFuZ2UgYW5kIHdlIG5lZWQgdG8gZGVzdHJveSBhbmQg
Y3JlYXRlCj4gQEAgLTQ4MSw2ICs0ODAsMTAgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfcG9sbF9v
bmUoc3RydWN0IG1seDVfdmRwYV9jcSAqdmNxKQo+ICAgCj4gICBzdGF0aWMgdm9pZCBtbHg1X3Zk
cGFfaGFuZGxlX2NvbXBsZXRpb25zKHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEsIGlu
dCBudW0pCj4gICB7Cj4gKwlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IG12cS0+bmRldjsK
PiArCXN0cnVjdCB2ZHBhX2NhbGxiYWNrICpldmVudF9jYjsKPiArCj4gKwlldmVudF9jYiA9ICZu
ZGV2LT5ldmVudF9jYnNbbXZxLT5pbmRleF07Cj4gICAJbWx4NV9jcV9zZXRfY2koJm12cS0+Y3Eu
bWNxKTsKPiAgIAo+ICAgCS8qIG1ha2Ugc3VyZSBDUSBjb3N1bWVyIHVwZGF0ZSBpcyB2aXNpYmxl
IHRvIHRoZSBoYXJkd2FyZSBiZWZvcmUgdXBkYXRpbmcKPiBAQCAtNDg4LDggKzQ5MSw4IEBAIHN0
YXRpYyB2b2lkIG1seDVfdmRwYV9oYW5kbGVfY29tcGxldGlvbnMoc3RydWN0IG1seDVfdmRwYV92
aXJ0cXVldWUgKm12cSwgaW50IG51Cj4gICAJICovCj4gICAJZG1hX3dtYigpOwo+ICAgCXJ4X3Bv
c3QoJm12cS0+dnFxcCwgbnVtKTsKPiAtCWlmIChtdnEtPmV2ZW50X2NiLmNhbGxiYWNrKQo+IC0J
CW12cS0+ZXZlbnRfY2IuY2FsbGJhY2sobXZxLT5ldmVudF9jYi5wcml2YXRlKTsKPiArCWlmIChl
dmVudF9jYi0+Y2FsbGJhY2spCj4gKwkJZXZlbnRfY2ItPmNhbGxiYWNrKGV2ZW50X2NiLT5wcml2
YXRlKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2NxX2NvbXAoc3RydWN0
IG1seDVfY29yZV9jcSAqbWNxLCBzdHJ1Y3QgbWx4NV9lcWUgKmVxZSkKPiBAQCAtMTM4NCw5ICsx
Mzg3LDggQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF92cV9jYihzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHUxNiBpZHgsIHN0cnVjdCB2ZHBhX2MKPiAgIHsKPiAgIAlzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX25l
dCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAtCXN0cnVjdCBtbHg1X3ZkcGFf
dmlydHF1ZXVlICp2cSA9ICZuZGV2LT52cXNbaWR4XTsKPiAgIAo+IC0JdnEtPmV2ZW50X2NiID0g
KmNiOwo+ICsJbmRldi0+ZXZlbnRfY2JzW2lkeF0gPSAqY2I7Cj4gICB9Cj4gICAKPiAgIHN0YXRp
YyB2b2lkIG1seDVfdmRwYV9zZXRfdnFfcmVhZHkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
MTYgaWR4LCBib29sIHJlYWR5KQo+IEBAIC0xNjIzLDcgKzE2MjUsNiBAQCBzdGF0aWMgaW50IHNh
dmVfY2hhbm5lbF9pbmZvKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92
ZHBhX3ZpcnRxdQo+ICAgCXJpLT5kZXNjX2FkZHIgPSBtdnEtPmRlc2NfYWRkcjsKPiAgIAlyaS0+
ZGV2aWNlX2FkZHIgPSBtdnEtPmRldmljZV9hZGRyOwo+ICAgCXJpLT5kcml2ZXJfYWRkciA9IG12
cS0+ZHJpdmVyX2FkZHI7Cj4gLQlyaS0+Y2IgPSBtdnEtPmV2ZW50X2NiOwo+ICAgCXJpLT5yZXN0
b3JlID0gdHJ1ZTsKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiBAQCAtMTY2OCw3ICsxNjY5LDYgQEAg
c3RhdGljIHZvaWQgcmVzdG9yZV9jaGFubmVsc19pbmZvKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpu
ZGV2KQo+ICAgCQltdnEtPmRlc2NfYWRkciA9IHJpLT5kZXNjX2FkZHI7Cj4gICAJCW12cS0+ZGV2
aWNlX2FkZHIgPSByaS0+ZGV2aWNlX2FkZHI7Cj4gICAJCW12cS0+ZHJpdmVyX2FkZHIgPSByaS0+
ZHJpdmVyX2FkZHI7Cj4gLQkJbXZxLT5ldmVudF9jYiA9IHJpLT5jYjsKPiAgIAl9Cj4gICB9Cj4g
ICAKPiBAQCAtMTc5MSw2ICsxNzkxLDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0
dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gICAJCW1seDVfdmRwYV9k
ZXN0cm95X21yKCZuZGV2LT5tdmRldik7Cj4gICAJCW5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7Cj4g
ICAJCW5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyA9IDA7Cj4gKwkJbWVtc2V0KG5kZXYtPmV2ZW50
X2NicywgMCwgc2l6ZW9mKG5kZXYtPmV2ZW50X2NicykpOwo+ICAgCQkrK212ZGV2LT5nZW5lcmF0
aW9uOwo+ICAgCQlpZiAoTUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkgewo+
ICAgCQkJaWYgKG1seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIE5VTEwpKQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
