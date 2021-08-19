Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF7C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:32:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0476044F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE0476044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93DF4607ED;
	Thu, 19 Aug 2021 03:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qPc6HLbf1b18; Thu, 19 Aug 2021 03:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4149C60771;
	Thu, 19 Aug 2021 03:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23333C001A;
	Thu, 19 Aug 2021 03:32:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7610EC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ECDE607A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2OLVNp1Ies4B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:32:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B31B60771
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629343939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KV/KWp/4shcmRNwYYE6uVr4sPkmYm/RRQ0DfvXM2Lb4=;
 b=QYYCkCBvvLlItscL0c8vZ7npviXCMqNOfWRrFtm6bKs0vZxfkaP3+bmxXPnENPseb/GeDs
 Is3msnEy5ozK+adaYn0db9e8O3RWScXiFSKhRXZOrw7u84h4Ml1Cq8j8gKQgTspmJvJpV8
 /DuyAZPxak45wHBznivRP84Uv4CRssA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-nqEYxpqrPcumuouKKUx4hg-1; Wed, 18 Aug 2021 23:32:17 -0400
X-MC-Unique: nqEYxpqrPcumuouKKUx4hg-1
Received: by mail-pl1-f197.google.com with SMTP id
 f9-20020a1709028609b0290128bcba6be7so1078068plo.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 20:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KV/KWp/4shcmRNwYYE6uVr4sPkmYm/RRQ0DfvXM2Lb4=;
 b=pvEZ3uPbt9q57QIvwKXrqiPHDcmyvoGan7KsxwZDFirT3XRevdopOMYjc84VXHMZFF
 MdKMu93/mpAyKlVsw8sDmRmaWJ31T0VPpAgdurcc3TcSYRUlkzSsOva2+CnyWh2Rs8FK
 GYZo5THgK3moqwsav9ym5bdnShJjNA9fUjtCmi1QgbRE65a4BH+ABtcRfp75xRkSaUaH
 LzSZ4Mc0FZ9JaZUrxgbCnkbSTKJhiZxxNznMVGas03u14qpz3dwpSxEkpDq+TfwnAgIf
 sOLOOdmWhJUgy9Tv86WT3HJb6Bw96zZuxAOCfnX47vm98Z26NFadZ3rgQi8yotjfFECt
 NmmQ==
X-Gm-Message-State: AOAM532PB0BuH9SU8uHWY8Wlnu7Vvo2G5aPanXccQbfY/1DB5hLOEdpu
 Jys9ofx835ZHeNSLHtYcr08CciMlqOZa5fA5fLgAn1Hw+a7OMXsGUsga2rnrOig/wo7QPmYl6Ew
 euMYXhMdS59IPIzJQul6RAKoGmsbZlVyB0kahaIK3kQ==
X-Received: by 2002:a65:4203:: with SMTP id c3mr11791064pgq.309.1629343936764; 
 Wed, 18 Aug 2021 20:32:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx74C+eO7N2N9GwVwuCif35YSxQ2ERNb3FuU9M79kOuEcS54rzJy5R/uEZRNo9qgNqTgwpQow==
X-Received: by 2002:a65:4203:: with SMTP id c3mr11791039pgq.309.1629343936439; 
 Wed, 18 Aug 2021 20:32:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j185sm1243616pfb.86.2021.08.18.20.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 20:32:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] vdpa/mlx5: function prototype modifications in
 preparation to control VQ
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210817060250.188705-1-elic@nvidia.com>
 <20210817060250.188705-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7cc7c018-0125-ae4e-98ec-9c3ca9a0464b@redhat.com>
Date: Thu, 19 Aug 2021 11:32:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817060250.188705-3-elic@nvidia.com>
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

CtTaIDIwMjEvOC8xNyDPws7nMjowMiwgRWxpIENvaGVuINC0tcA6Cj4gVXNlIHN0cnVjdCBtbHg1
X3ZkcGFfZGV2IGFzIGFuIGFyZ3VtZW50IHRvIHNldHVwX2RyaXZlcigpIGFuZCBhIGZldwo+IG90
aGVycyBpbiBwcmVwYXJhdGlvbiB0byBjb250cm9sIHZpcnRxdWV1ZSBzdXBwb3J0IGluIGEgc3Vi
c2VxdWVudAo+IHBhdGNoLiBUaGUgY29udHJvbCB2aXJ0cXVldWUgaXMgcGFydCBvZiBzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiBzbyB0aGlzIGlzCj4gcmVxdWlyZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBF
bGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIHwgNDAgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+IGluZGV4IGIxMjMwZmEyZjVkMS4uYTFjZjU4YTUzZDQyIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0xNTUsNyArMTU1LDcgQEAgc3RydWN0IG1seDVf
dmRwYV9uZXQgewo+ICAgCj4gICBzdGF0aWMgdm9pZCBmcmVlX3Jlc291cmNlcyhzdHJ1Y3QgbWx4
NV92ZHBhX25ldCAqbmRldik7Cj4gICBzdGF0aWMgdm9pZCBpbml0X212cXMoc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYpOwo+IC1zdGF0aWMgaW50IHNldHVwX2RyaXZlcihzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldik7Cj4gK3N0YXRpYyBpbnQgc2V0dXBfZHJpdmVyKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldik7Cj4gICBzdGF0aWMgdm9pZCB0ZWFyZG93bl9kcml2ZXIoc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXYpOwo+ICAgCj4gICBzdGF0aWMgYm9vbCBtbHg1X3ZkcGFfZGVidWc7
Cj4gQEAgLTE1MDgsMTIgKzE1MDgsMTMgQEAgc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1cmVz
KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgCXJldHVybiAw
Owo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgc2V0dXBfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldikKPiArc3RhdGljIGludCBzZXR1cF92aXJ0cXVldWVzKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldikKPiAgIHsKPiArCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0g
dG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+ICAgCWludCBlcnI7Cj4gICAJaW50IGk7Cj4gICAK
PiAtCWZvciAoaSA9IDA7IGkgPCAyICogbWx4NV92ZHBhX21heF9xcHMobmRldi0+bXZkZXYubWF4
X3Zxcyk7IGkrKykgewo+ICsJZm9yIChpID0gMDsgaSA8IDIgKiBtbHg1X3ZkcGFfbWF4X3Fwcyht
dmRldi0+bWF4X3Zxcyk7IGkrKykgewo+ICAgCQllcnIgPSBzZXR1cF92cShuZGV2LCAmbmRldi0+
dnFzW2ldKTsKPiAgIAkJaWYgKGVycikKPiAgIAkJCWdvdG8gZXJyX3ZxOwo+IEBAIC0xNjcyLDgg
KzE2NzMsOSBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX2NoYW5uZWxzX2luZm8oc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYpCj4gICAJfQo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgbWx4NV92ZHBh
X2NoYW5nZV9tYXAoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCB2aG9zdF9pb3Rs
YiAqaW90bGIpCj4gK3N0YXRpYyBpbnQgbWx4NV92ZHBhX2NoYW5nZV9tYXAoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKQo+ICAgewo+ICsJc3Ry
dWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gICAJ
aW50IGVycjsKPiAgIAo+ICAgCXN1c3BlbmRfdnFzKG5kZXYpOwo+IEBAIC0xNjgyLDU4ICsxNjg0
LDU5IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2NoYW5nZV9tYXAoc3RydWN0IG1seDVfdmRwYV9u
ZXQgKm5kZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqCj4gICAJCWdvdG8gZXJyX21yOwo+ICAgCj4g
ICAJdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+IC0JbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYt
Pm12ZGV2KTsKPiAtCWVyciA9IG1seDVfdmRwYV9jcmVhdGVfbXIoJm5kZXYtPm12ZGV2LCBpb3Rs
Yik7Cj4gKwltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldik7Cj4gKwllcnIgPSBtbHg1X3ZkcGFf
Y3JlYXRlX21yKG12ZGV2LCBpb3RsYik7Cj4gICAJaWYgKGVycikKPiAgIAkJZ290byBlcnJfbXI7
Cj4gICAKPiAtCWlmICghKG5kZXYtPm12ZGV2LnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklW
RVJfT0spKQo+ICsJaWYgKCEobXZkZXYtPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJf
T0spKQo+ICAgCQlyZXR1cm4gMDsKPiAgIAo+ICAgCXJlc3RvcmVfY2hhbm5lbHNfaW5mbyhuZGV2
KTsKPiAtCWVyciA9IHNldHVwX2RyaXZlcihuZGV2KTsKPiArCWVyciA9IHNldHVwX2RyaXZlciht
dmRldik7Cj4gICAJaWYgKGVycikKPiAgIAkJZ290byBlcnJfc2V0dXA7Cj4gICAKPiAgIAlyZXR1
cm4gMDsKPiAgIAo+ICAgZXJyX3NldHVwOgo+IC0JbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYt
Pm12ZGV2KTsKPiArCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2KTsKPiAgIGVycl9tcjoKPiAg
IAlyZXR1cm4gZXJyOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgc2V0dXBfZHJpdmVyKHN0cnVj
dCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICtzdGF0aWMgaW50IHNldHVwX2RyaXZlcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gICB7Cj4gKwlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRl
diA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAgIAlpbnQgZXJyOwo+ICAgCj4gICAJbXV0
ZXhfbG9jaygmbmRldi0+cmVzbG9jayk7Cj4gICAJaWYgKG5kZXYtPnNldHVwKSB7Cj4gLQkJbWx4
NV92ZHBhX3dhcm4oJm5kZXYtPm12ZGV2LCAic2V0dXAgZHJpdmVyIGNhbGxlZCBmb3IgYWxyZWFk
eSBzZXR1cCBkcml2ZXJcbiIpOwo+ICsJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAic2V0dXAgZHJp
dmVyIGNhbGxlZCBmb3IgYWxyZWFkeSBzZXR1cCBkcml2ZXJcbiIpOwo+ICAgCQllcnIgPSAwOwo+
ICAgCQlnb3RvIG91dDsKPiAgIAl9Cj4gLQllcnIgPSBzZXR1cF92aXJ0cXVldWVzKG5kZXYpOwo+
ICsJZXJyID0gc2V0dXBfdmlydHF1ZXVlcyhtdmRldik7Cj4gICAJaWYgKGVycikgewo+IC0JCW1s
eDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwgInNldHVwX3ZpcnRxdWV1ZXNcbiIpOwo+ICsJCW1s
eDVfdmRwYV93YXJuKG12ZGV2LCAic2V0dXBfdmlydHF1ZXVlc1xuIik7Cj4gICAJCWdvdG8gb3V0
Owo+ICAgCX0KPiAgIAo+ICAgCWVyciA9IGNyZWF0ZV9ycXQobmRldik7Cj4gICAJaWYgKGVycikg
ewo+IC0JCW1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwgImNyZWF0ZV9ycXRcbiIpOwo+ICsJ
CW1seDVfdmRwYV93YXJuKG12ZGV2LCAiY3JlYXRlX3JxdFxuIik7Cj4gICAJCWdvdG8gZXJyX3Jx
dDsKPiAgIAl9Cj4gICAKPiAgIAllcnIgPSBjcmVhdGVfdGlyKG5kZXYpOwo+ICAgCWlmIChlcnIp
IHsKPiAtCQltbHg1X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJjcmVhdGVfdGlyXG4iKTsKPiAr
CQltbHg1X3ZkcGFfd2FybihtdmRldiwgImNyZWF0ZV90aXJcbiIpOwo+ICAgCQlnb3RvIGVycl90
aXI7Cj4gICAJfQo+ICAgCj4gICAJZXJyID0gYWRkX2Z3ZF90b190aXIobmRldik7Cj4gICAJaWYg
KGVycikgewo+IC0JCW1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwgImFkZF9md2RfdG9fdGly
XG4iKTsKPiArCQltbHg1X3ZkcGFfd2FybihtdmRldiwgImFkZF9md2RfdG9fdGlyXG4iKTsKPiAg
IAkJZ290byBlcnJfZndkOwo+ICAgCX0KPiAgIAluZGV2LT5zZXR1cCA9IHRydWU7Cj4gQEAgLTE3
OTksNyArMTgwMiw3IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+ICAgCj4gICAJaWYgKChzdGF0dXMgXiBuZGV2
LT5tdmRldi5zdGF0dXMpICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+ICAgCQlpZiAo
c3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+IC0JCQllcnIgPSBzZXR1cF9k
cml2ZXIobmRldik7Cj4gKwkJCWVyciA9IHNldHVwX2RyaXZlcihtdmRldik7Cj4gICAJCQlpZiAo
ZXJyKSB7Cj4gICAJCQkJbWx4NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQgdG8gc2V0dXAgZHJp
dmVyXG4iKTsKPiAgIAkJCQlnb3RvIGVycl9zZXR1cDsKPiBAQCAtMTg0OSw3ICsxODUyLDYgQEAg
c3RhdGljIHUzMiBtbHg1X3ZkcGFfZ2V0X2dlbmVyYXRpb24oc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2KQo+ICAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X21hcChzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4gICB7Cj4gICAJc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gLQlzdHJ1Y3QgbWx4NV92ZHBhX25l
dCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAgIAlib29sIGNoYW5nZV9tYXA7
Cj4gICAJaW50IGVycjsKPiAgIAo+IEBAIC0xODYwLDcgKzE4NjIsNyBAQCBzdGF0aWMgaW50IG1s
eDVfdmRwYV9zZXRfbWFwKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHZob3N0X2lv
dGxiICppb3RsYgo+ICAgCX0KPiAgIAo+ICAgCWlmIChjaGFuZ2VfbWFwKQo+IC0JCXJldHVybiBt
bHg1X3ZkcGFfY2hhbmdlX21hcChuZGV2LCBpb3RsYik7Cj4gKwkJcmV0dXJuIG1seDVfdmRwYV9j
aGFuZ2VfbWFwKG12ZGV2LCBpb3RsYik7Cj4gICAKPiAgIAlyZXR1cm4gMDsKPiAgIH0KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
