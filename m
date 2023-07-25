Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC29C0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 03:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC30F410EA;
	Tue, 25 Jul 2023 03:42:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC30F410EA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f2/m8muF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YIncY0H0uIsq; Tue, 25 Jul 2023 03:42:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E809640973;
	Tue, 25 Jul 2023 03:42:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E809640973
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA65BC0072;
	Tue, 25 Jul 2023 03:42:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8C8AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75C7581AD1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:42:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75C7581AD1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f2/m8muF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id krk3jeYxXiHk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:42:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA1CB81AC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 03:42:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA1CB81AC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690256524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBqWvh4jP/z/tTFxDwlL4w0kgC2AYOxSmuBfBsWmpVQ=;
 b=f2/m8muF9srcTpjVtcJoVJhsoIDSw+urssLMJGnkdhifZUUAwra927Ln8ul8JMdVesTc4+
 o3G/k/p4RpNYjfpLvLgE3nyMjT57FN5ErJ//WNB1Rn3VCofay7xqYztKJx9rw5HkHHwDWo
 2tGJ56iO/8OACD67mdyrqgS6C+47QNg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-d_DdeTDTPFuy6BsITWJ5-g-1; Mon, 24 Jul 2023 23:42:03 -0400
X-MC-Unique: d_DdeTDTPFuy6BsITWJ5-g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb7d06a7e6so4291685e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 20:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690256522; x=1690861322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBqWvh4jP/z/tTFxDwlL4w0kgC2AYOxSmuBfBsWmpVQ=;
 b=Bga4lg8aRAUkGdaHwgZd+w6Vp9q2PDJQVAh6hHJ8LF4ZAwJ2PNbQK+mE3Mm9a3ohQg
 11WfQ1/5+Xqgpm7EVAbOZOkzxR26GwrRxqxnDYbMCfuzU3cTSjdT68ebm1juH1ek2r6h
 Z9MIjdQa8T8E1bOfVaz0e5UMkQ2UMtTL/GhJaJK76EnFmC2GfhCFBmiuL3SbuSbazRR9
 ZKVA4xv3/nK5Vqa6sqb+AIoAt5c1Ydznjojx/t7+KRIg3Tk8eWCvLZeeyzEOMia2JyA3
 Wo5i3QV8ggT+FaibWcTar5smpwpWFXpR8eJ6Cl1Q6zA/AI5LEU+D86idZhC8U6a13/DJ
 uHFA==
X-Gm-Message-State: ABy/qLaPEAuIhgSRcHBjA9c1PEV7+PPjEmxuntxk1mOAZWqvcNeXnOcb
 f6PcLjge6fWAp5BcNbHtiMIj5fubMMgcaFPBWFMrGLntekdvN0JMhrqvSa2VV6rWf8Nor17Krbr
 IxwOiRvRs88knszSaWf7IWQVaF2BwL4gFODtzFrl6gqoZCLA/fiRrjMmKEA==
X-Received: by 2002:a05:6512:3dac:b0:4f9:556b:93c2 with SMTP id
 k44-20020a0565123dac00b004f9556b93c2mr7717123lfv.1.1690256521814; 
 Mon, 24 Jul 2023 20:42:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWkHAVooO54bT1EHw02WmRL4kluBNDiEY/6H7dlW6/a0ZQV+weSwSX6KySDaHy9vgTvfNUvxt936MezoEyD9w=
X-Received: by 2002:a05:6512:3dac:b0:4f9:556b:93c2 with SMTP id
 k44-20020a0565123dac00b004f9556b93c2mr7717108lfv.1.1690256521512; Mon, 24 Jul
 2023 20:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
 <20230720131423-mutt-send-email-mst@kernel.org>
 <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
In-Reply-To: <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 11:41:50 +0800
Message-ID: <CACGkMEuk2aBhnViZkAi8tbNc8AnJ1FY9uk9rCnmmiWVGwYsLUA@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgOToxNOKAr1BNIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPiB3cm90ZToKPgo+Cj4KPiBPbiAyMDIzLTA3LTIwIHAubS4xOjE0LCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cwo+ID4KPiA+Cj4gPiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAxMDoy
NzowNEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+IE9uIFdlZCwgSnVsIDE5LCAyMDIz
IGF0IDExOjQ24oCvUE0gRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+IHdyb3RlOgo+ID4+Pgo+
ID4+PiBUaGUgJ2lzX2xlZ2FjeScgZmxhZyBpcyB1c2VkIHRvIGRpZmZlcmVudGlhdGUgYmV0d2Vl
biBsZWdhY3kgdnMgbW9kZXJuCj4gPj4+IGRldmljZS4gQ3VycmVudGx5LCBpdCBpcyBiYXNlZCBv
biB0aGUgdmFsdWUgb2YgdnBfZGV2LT5sZGV2LmlvYWRkci4KPiA+Pj4gSG93ZXZlciwgZHVlIHRv
IHRoZSBzaGFyZWQgbWVtb3J5IG9mIHRoZSB1bmlvbiBiZXR3ZWVuIHN0cnVjdAo+ID4+PiB2aXJ0
aW9fcGNpX2xlZ2FjeV9kZXZpY2UgYW5kIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2Us
IHdoZW4KPiA+Pj4gdmlydGlvX3BjaV9tb2Rlcm5fcHJvYmUgbW9kaWZpZXMgdGhlIGNvbnRlbnQg
b2Ygc3RydWN0Cj4gPj4+IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSwgaXQgYWZmZWN0cyB0aGUg
Y29udGVudCBvZiBzdHJ1Y3QKPiA+Pj4gdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlLCBhbmQgbGRl
di5pb2FkZHIgaXMgbm8gbG9uZ2VyIHplcm8sIGNhdXNpbmcKPiA+Pj4gdGhlICdpc19sZWdhY3kn
IGZsYWcgdG8gYmUgc2V0IGFzIHRydWUuIFRvIHJlc29sdmUgaXNzdWUsIHdoZW4gbGVnYWN5Cj4g
Pj4+IGRldmljZSBpcyBwcm9iZWQsIG1hcmsgJ2lzX2xlZ2FjeScgYXMgdHJ1ZSwgd2hlbiBtb2Rl
cm4gZGV2aWNlIGlzCj4gPj4+IHByb2JlZCwga2VlcCAnaXNfbGVnYWN5JyBhcyBmYWxzZS4KPiA+
Pj4KPiA+Pj4gRml4ZXM6IDRmMGZjMjI1MzRlMyAoInZpcnRpb19wY2k6IE9wdGltaXplIHZpcnRp
b19wY2lfZGV2aWNlIHN0cnVjdHVyZSBzaXplIikKPiA+Pj4gU2lnbmVkLW9mZi1ieTogRmVuZyBM
aXUgPGZlbGl1QG52aWRpYS5jb20+Cj4gPj4+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBh
cmF2QG52aWRpYS5jb20+Cj4gPj4+IFJldmlld2VkLWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRp
YS5jb20+Cj4gPj4+IC0tLQo+ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9u
LmMgfCAyIC0tCj4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDEg
Kwo+ID4+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0p
Cj4gPj4+Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1v
bi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ID4+PiBpbmRleCBhNmM4
NmY5MTZkYmQuLmMyNTI0YTcyMDdjZiAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uYwo+ID4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5jCj4gPj4+IEBAIC01NTcsOCArNTU3LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fcGNp
X3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2LAo+ID4+Pgo+ID4+PiAgICAgICAgICBwY2lf
c2V0X21hc3RlcihwY2lfZGV2KTsKPiA+Pj4KPiA+Pj4gLSAgICAgICB2cF9kZXYtPmlzX2xlZ2Fj
eSA9IHZwX2Rldi0+bGRldi5pb2FkZHIgPyB0cnVlIDogZmFsc2U7Cj4gPj4+IC0KPiA+Pj4gICAg
ICAgICAgcmMgPSByZWdpc3Rlcl92aXJ0aW9fZGV2aWNlKCZ2cF9kZXYtPnZkZXYpOwo+ID4+PiAg
ICAgICAgICByZWdfZGV2ID0gdnBfZGV2Owo+ID4+PiAgICAgICAgICBpZiAocmMpCj4gPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+ID4+PiBpbmRleCAyMjU3ZjFiM2Q4YWUuLmQ5Y2Ji
MDJiMzVhMSAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdh
Y3kuYwo+ID4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jCj4gPj4+
IEBAIC0yMjMsNiArMjIzLDcgQEAgaW50IHZpcnRpb19wY2lfbGVnYWN5X3Byb2JlKHN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2KQo+ID4+PiAgICAgICAgICB2cF9kZXYtPmNvbmZpZ192
ZWN0b3IgPSB2cF9jb25maWdfdmVjdG9yOwo+ID4+PiAgICAgICAgICB2cF9kZXYtPnNldHVwX3Zx
ID0gc2V0dXBfdnE7Cj4gPj4+ICAgICAgICAgIHZwX2Rldi0+ZGVsX3ZxID0gZGVsX3ZxOwo+ID4+
PiArICAgICAgIHZwX2Rldi0+aXNfbGVnYWN5ID0gdHJ1ZTsKPiA+Pgo+ID4+IFRoaXMgc2VlbXMg
YnJlYWsgZm9yY2VfbGVnYWN5IGZvciBtb2Rlcm4gZGV2aWNlOgo+ID4+Cj4gPj4gICAgICAgICAg
aWYgKGZvcmNlX2xlZ2FjeSkgewo+ID4+ICAgICAgICAgICAgICAgICAgcmMgPSB2aXJ0aW9fcGNp
X2xlZ2FjeV9wcm9iZSh2cF9kZXYpOwo+ID4+ICAgICAgICAgICAgICAgICAgLyogQWxzbyB0cnkg
bW9kZXJuIG1vZGUgaWYgd2UgY2FuJ3QgbWFwIEJBUjAgKG5vIElPIHNwYWNlKS4gKi8KPiA+PiAg
ICAgICAgICAgICAgICAgIGlmIChyYyA9PSAtRU5PREVWIHx8IHJjID09IC1FTk9NRU0pCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIHJjID0gdmlydGlvX3BjaV9tb2Rlcm5fcHJvYmUodnBf
ZGV2KTsKPiA+Pgo+ID4+IFRoYW5rcwo+ID4KPiA+IGRvbid0IHNlZSB0aGUgYnJlYWthZ2UgaGVy
ZSAtIGNhbiB5b3UgZXhwbGFpbiBhIGJpdCBtb3JlPwo+ID4KPiBIaSwgSmFzb24KPgo+IEkgYWxz
byB0aGluayB0aGVyZSBpcyBubyBicmVha2FnZSBoZXJlYSBhbmQgZ2F2ZSBhbiBleHBsYW5hdGlv
biBpbgo+IGFub3RoZXIgZW1haWwsIHBsZWFzZSBoYXZlIGEgc2VlLgoKSSB0aGluayBJJ3ZlIG1h
ZGUgYSBtaXN0YWtlLCB0aGUgcGF0Y2ggc2hvdWxkIGJlIGZpbmUuCgo+Cj4gU28gYXJlIHRoZXJl
IGFueSBjb21tZW50cyBhYm91dCB0aGlzIGJ1ZyBmaXggcGF0Y2g/IENhbiB0aGlzIHBhdGNoIHBh
c3MKPiB0aGUgcmV2aWV3PwoKWWVzLgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgpUaGFua3MKCj4KPiBUaGFua3MKPiBGZW5nCj4KPiA+Pj4KPiA+Pj4gICAgICAg
ICAgcmV0dXJuIDA7Cj4gPj4+ICAgfQo+ID4+PiAtLQo+ID4+PiAyLjM3LjEgKEFwcGxlIEdpdC0x
MzcuMSkKPiA+Pj4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
