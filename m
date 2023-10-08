Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB79BE95A8F
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 05:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16691400D8;
	Sun,  8 Oct 2023 05:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16691400D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJcSpexv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ok1MktXr-lZ9; Sun,  8 Oct 2023 05:17:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E8394033A;
	Sun,  8 Oct 2023 05:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E8394033A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5748FC0039;
	Sun,  8 Oct 2023 05:17:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8BBC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0905561057
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0905561057
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJcSpexv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9rZIS4UT8Hy
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:17:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A9A060E32
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 05:17:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A9A060E32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696742257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIBFYES1oNSbgdg44IpiRY5MDLveYfd/44xts2VnIss=;
 b=FJcSpexv3rRRgxRRX/MXTULoH7+vfIGLAF4DUD3wEtzZZsbaDwMDPBfaDEVHcfRLpkvD20
 hfxBmue0SJTCs2YaiT9gcHlWkSAymARP53ZHsqIkQF2GXk39DbUuRRUleEbmwcSEP71hz1
 3Mq0SgLykO+f+yvPKv/44r5AbqCSnUA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-48Wcwd2CPDCBmEXyDLYO0g-1; Sun, 08 Oct 2023 01:17:36 -0400
X-MC-Unique: 48Wcwd2CPDCBmEXyDLYO0g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5041bea78a5so3114093e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 22:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742254; x=1697347054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIBFYES1oNSbgdg44IpiRY5MDLveYfd/44xts2VnIss=;
 b=kPFYRBrdE+5s5Mm94VfDJsVMzdOyFxTsgT3AZQLfU9j5lRgSTs8r2Tbs169O8VdCoi
 dkqNek7APGhSKMxu7i0bzpLrDxeSNcxQ75jD6YNMO9scvUs0A/PbUyy1yMXCxOGGz6Nw
 GkclCU61yYzQ1zjTBvBgcl7GOjRnje1IBPkH/32MhNy/hxvkvLXbVoM8RDvESsj+s+Jl
 Xn+zDMPIBD9BmMzGdz7AfScvoCjc2Bn99tV08WEKLNcm+DgIpaNiCIuYDSWzmJbBuZqQ
 MgZ/tmU0WBvWHBC5JW4rcKYK68fmyFh1bdxDYAhoHMbbQnXjXe/fUumM045gu/TnPHsY
 i8Ig==
X-Gm-Message-State: AOJu0Yz2QPaNzEVgbcuOr1Qzh4Zu+G/omdc5FnxC3PDtDI0Y4F8A/qC4
 K/1D824b1O5DVjdLbIIi0vE5N43JBIr4NgIxyTXCQXqw0XXR6TfdZ0YUEXj3VnTnfdTxLTwTFJX
 uBY/+MtQZf7TbFAleLRww03007BR0xt9/nUvCVFvx1v3VPeKlTTodfuhctQ==
X-Received: by 2002:a05:6512:31d2:b0:500:acf1:b432 with SMTP id
 j18-20020a05651231d200b00500acf1b432mr12100668lfe.63.1696742254618; 
 Sat, 07 Oct 2023 22:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHih9jNBj+mm3gln1ZCsXonlccj1/oAiZNJ1d8VXWVWaywkwRq06DB7RjMZgwJPLinVPauKckcWGYfUL6bhA9o=
X-Received: by 2002:a05:6512:31d2:b0:500:acf1:b432 with SMTP id
 j18-20020a05651231d200b00500acf1b432mr12100655lfe.63.1696742254306; Sat, 07
 Oct 2023 22:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
 <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com>
In-Reply-To: <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:17:23 +0800
Message-ID: <CACGkMEsNfLOQkmnWUH53iTptAmhELs_U8B4D-CfO49rs=+HfLw@mail.gmail.com>
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com
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

T24gRnJpLCBTZXAgMjksIDIwMjMgYXQgNToxMuKAr1BNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDkvMTIvMjMgMDk6MzksIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMTowMOKAr0FNIENp
bmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gSW4gVkRVU0VfVlFfR0VU
X0lORk8sIHRoZSBkcml2ZXIgd2lsbCBzeW5jIHRoZSBsYXN0X2F2YWlsX2lkeAo+ID4+IHdpdGgg
cmVjb25uZWN0IGluZm8sIEFmdGVyIG1hcHBpbmcgdGhlIHJlY29ubmVjdCBwYWdlcyB0byB1c2Vy
c3BhY2UKPiA+PiBUaGUgdXNlcnNwYWNlIEFwcCB3aWxsIHVwZGF0ZSB0aGUgcmVjb25uZWN0X3Rp
bWUgaW4KPiA+PiBzdHJ1Y3Qgdmhvc3RfcmVjb25uZWN0X3ZyaW5nLCBJZiB0aGlzIGlzIG5vdCAw
IHRoZW4gaXQgbWVhbnMgdGhpcwo+ID4+IHZxIGlzIHJlY29ubmVjdGVkIGFuZCB3aWxsIHVwZGF0
ZSB0aGUgbGFzdF9hdmFpbF9pZHgKPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IENpbmR5IEx1IDxs
dWx1QHJlZGhhdC5jb20+Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jIHwgMTMgKysrKysrKysrKysrKwo+ID4+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zk
dXNlLmggICAgICAgICB8ICA2ICsrKysrKwo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNl
cnRpb25zKCspCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92
ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiA+PiBpbmRl
eCAyYzY5ZjQwMDRhNmUuLjY4MGIyM2RiZGRlMiAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3Zk
cGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNl
ci92ZHVzZV9kZXYuYwo+ID4+IEBAIC0xMjIxLDYgKzEyMjEsOCBAQCBzdGF0aWMgbG9uZyB2ZHVz
ZV9kZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsCj4gPj4gICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfdnFfaW5mbyB2cV9pbmZvOwo+ID4+ICAgICAgICAg
ICAgICAgICAgc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSAqdnE7Cj4gPj4gICAgICAgICAgICAgICAg
ICB1MzIgaW5kZXg7Cj4gPj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2ZHBhX3JlY29ubmVjdF9p
bmZvICphcmVhOwo+ID4+ICsgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfcmVjb25uZWN0X3Zy
aW5nICp2cV9yZWNvbm5lY3Q7Cj4gPj4KPiA+PiAgICAgICAgICAgICAgICAgIHJldCA9IC1FRkFV
TFQ7Cj4gPj4gICAgICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoJnZxX2luZm8sIGFy
Z3AsIHNpemVvZih2cV9pbmZvKSkpCj4gPj4gQEAgLTEyNTIsNiArMTI1NCwxNyBAQCBzdGF0aWMg
bG9uZyB2ZHVzZV9kZXZfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQs
Cj4gPj4KPiA+PiAgICAgICAgICAgICAgICAgIHZxX2luZm8ucmVhZHkgPSB2cS0+cmVhZHk7Cj4g
Pj4KPiA+PiArICAgICAgICAgICAgICAgYXJlYSA9ICZ2cS0+cmVjb25uZWN0X2luZm87Cj4gPj4g
Kwo+ID4+ICsgICAgICAgICAgICAgICB2cV9yZWNvbm5lY3QgPSAoc3RydWN0IHZob3N0X3JlY29u
bmVjdF92cmluZyAqKWFyZWEtPnZhZGRyOwo+ID4+ICsgICAgICAgICAgICAgICAvKmNoZWNrIGlm
IHRoZSB2cSBpcyByZWNvbm5lY3QsIGlmIHllcyB0aGVuIHVwZGF0ZSB0aGUgbGFzdF9hdmFpbF9p
ZHgqLwo+ID4+ICsgICAgICAgICAgICAgICBpZiAoKHZxX3JlY29ubmVjdC0+bGFzdF9hdmFpbF9p
ZHggIT0KPiA+PiArICAgICAgICAgICAgICAgICAgICB2cV9pbmZvLnNwbGl0LmF2YWlsX2luZGV4
KSAmJgo+ID4+ICsgICAgICAgICAgICAgICAgICAgKHZxX3JlY29ubmVjdC0+cmVjb25uZWN0X3Rp
bWUgIT0gMCkpIHsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICB2cV9pbmZvLnNwbGl0LmF2
YWlsX2luZGV4ID0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZxX3JlY29u
bmVjdC0+bGFzdF9hdmFpbF9pZHg7Cj4gPj4gKyAgICAgICAgICAgICAgIH0KPiA+PiArCj4gPj4g
ICAgICAgICAgICAgICAgICByZXQgPSAtRUZBVUxUOwo+ID4+ICAgICAgICAgICAgICAgICAgaWYg
KGNvcHlfdG9fdXNlcihhcmdwLCAmdnFfaW5mbywgc2l6ZW9mKHZxX2luZm8pKSkKPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFw
aS9saW51eC92ZHVzZS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPiA+PiBpbmRleCAx
MWJkNDhjNzJjNmMuLmQ1ODU0MjU4MDNmZCAxMDA2NDQKPiA+PiAtLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgvdmR1c2UuaAo+ID4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHVzZS5oCj4gPj4g
QEAgLTM1MCw0ICszNTAsMTAgQEAgc3RydWN0IHZkdXNlX2Rldl9yZXNwb25zZSB7Cj4gPj4gICAg
ICAgICAgfTsKPiA+PiAgIH07Cj4gPj4KPiA+PiArc3RydWN0IHZob3N0X3JlY29ubmVjdF92cmlu
ZyB7Cj4gPj4gKyAgICAgICBfX3UxNiByZWNvbm5lY3RfdGltZTsKPiA+PiArICAgICAgIF9fdTE2
IGxhc3RfYXZhaWxfaWR4Owo+ID4+ICsgICAgICAgX0Jvb2wgYXZhaWxfd3JhcF9jb3VudGVyOwo+
ID4KPiA+IFBsZWFzZSBhZGQgYSBjb21tZW50IGZvciBlYWNoIGZpZWxkLgo+ID4KPiA+IEFuZCBJ
IG5ldmVyIHNhdyBfQm9vbCBpcyB1c2VkIGluIHVhcGkgYmVmb3JlLCBtYXliZSBpdCdzIGJldHRl
ciB0bwo+ID4gcGFjayBpdCB3aXRoIGxhc3RfYXZhaWxfaWR4IGludG8gYSBfX3UzMi4KPgo+IEJl
dHRlciBhcyB0d28gZGlzdGluY3RzIF9fdTE2IElNSE8uCgpGaW5lIHdpdGggbWUuCgpUaGFua3MK
Cj4KPiBUaGFua3MsCj4gTWF4aW1lCj4KPiA+Cj4gPiBCdHcsIGRvIHdlIG5lZWQgdG8gdHJhY2sg
aW5mbGlnaHQgZGVzY3JpcHRvcnMgYXMgd2VsbD8KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPj4gK307
Cj4gPj4gKwo+ID4+ICAgI2VuZGlmIC8qIF9VQVBJX1ZEVVNFX0hfICovCj4gPj4gLS0KPiA+PiAy
LjM0LjMKPiA+Pgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
