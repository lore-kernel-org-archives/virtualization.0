Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B3DC76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 554F541020;
	Tue, 28 Mar 2023 06:30:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 554F541020
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGtdFaYd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yEN9TrhsMQrj; Tue, 28 Mar 2023 06:29:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D69D9405AA;
	Tue, 28 Mar 2023 06:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D69D9405AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB3C7C0036;
	Tue, 28 Mar 2023 06:29:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA50FC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AECC4405D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:29:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AECC4405D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWNCNOcPFTYm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:29:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3A90405AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3A90405AA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kWGgRo2lfqcj7RWVXntuwhbjC2hWpKRRKQU148NIdo=;
 b=FGtdFaYdhBFPy89oa6HsIhYHiKSSer+iJpNULFNyYyzKBmYuwfmRBF7Td41+F4jJ1+ga2o
 4f8h3cOoiKAgAsWytTaqcWj34UJRMzhq9ngHpHmJuetgF/rJY4nHR5LcLYyIzjsyY+Wg7e
 ajMlbX8XGgJaqGMahU570BWQ1KJXRcs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-p5e7qe59Nd2zKU_b75nU2g-1; Tue, 28 Mar 2023 02:29:54 -0400
X-MC-Unique: p5e7qe59Nd2zKU_b75nU2g-1
Received: by mail-oi1-f198.google.com with SMTP id
 bg21-20020a056808179500b003869b702d75so2232233oib.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4kWGgRo2lfqcj7RWVXntuwhbjC2hWpKRRKQU148NIdo=;
 b=AeowJsTtQx8I2Rdf52ENgzzJ9x/OWycocE1F1dgrEIFngWBVtsG0hKBA6145cCEO2Z
 8MyqwCIMD6EeK4eRFkmGIeDyk4Mp0C991+wiGIQY9iD/oi4ayk6YROMnLqcvBYi+Hr05
 Qh985AQ2GEvUS11FvG0gbdOVHOm3FLUmwSgsl3cUO9W6oXt4h59LoN4E4QLznHXJv4Tm
 kwOvy1t8eIW+I1hKqOcK3eybjGo4f3YShD3v5cqckZ2Z1hZSrdKV0KbHL+QDQpU9iNC2
 n2HqoDoKo2nxEY+h/GC4BjdJmPFlFT4fMjhRE9maZQdonURI5S9381ia+ZyH4alrFeL3
 5tUw==
X-Gm-Message-State: AAQBX9f7JjH1bxMa3fHydabBAU492I8RoyPu4WidLtX7Hx2etMs3Myl6
 7gnasryRn6bcduB/Sq+goeO5ahHsk4x2UqX7tKr+5y4zDIqvlCuUpW4pPbBqRRhw8KtgrBKz/qh
 oatQiNPP020LZrgcQVYf3Pr6d8nL833HMJkzB9yMnNf9e9gUV+8Ggsj877g==
X-Received: by 2002:a54:4086:0:b0:389:91b:f51e with SMTP id
 i6-20020a544086000000b00389091bf51emr2484950oii.9.1679984993616; 
 Mon, 27 Mar 2023 23:29:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZkXY0kjS8SobRiWHpYS9OhzGwJMOPpbEP2pY78DYP7EEU+flSDU/qexE70u8A5xTm8k9pUZlzHIDVHHkLW4Bw=
X-Received: by 2002:a54:4086:0:b0:389:91b:f51e with SMTP id
 i6-20020a544086000000b00389091bf51emr2484943oii.9.1679984993371; Mon, 27 Mar
 2023 23:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230327040536.48338-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 14:29:42 +0800
Message-ID: <CACGkMEtPJEAq2eAT3VC6PccLLYxKcW_7sMevPAP6d1iH_=G5tQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 06/11] virtio_ring: packed-indirect: support
 premapped
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

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMTI6MDXigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IHZpcnRpbyBjb3JlIG9ubHkgc3VwcG9ydHMgdmly
dHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4gdmlydGlvCj4gY29yZS4KPgo+IElu
IHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRoZSBBRl9YRFApLCB0aGUgbWVtb3J5IGlzIGFsbG9j
YXRlZAo+IGFuZCBETUEgbWFwcGluZyBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28gaXQgaXMg
bmVjZXNzYXJ5IGZvciB1cyB0bwo+IHN1cHBvcnQgcGFzc2luZyB0aGUgRE1BIGFkZHJlc3MgdG8g
dmlydGlvIGNvcmUuCj4KPiBEcml2ZXMgY2FuIHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyB0
aGUgbWFwcGVkIGRtYSBhZGRyZXNzIHRvIHZpcnRpbwo+IGNvcmUuIElmIG9uZSBzZy0+ZG1hX2Fk
ZHJlc3MgaXMgdXNlZCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2Ugc2ctPmRtYV9hZGRyZXNzLAo+IG90
aGVyd2lzZSBhbGwgZG1hX2FkZHJlc3MgbXVzdCBiZSBudWxsIHdoZW4gcGFzc2luZyBpdCB0byB0
aGUgQVBJcyBvZgo+IHZpcnRpby4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8
IDExICsrKysrKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCAyYWZmZjFkYzZjNzQuLmQ1ZGZm
YmU1MDA3MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysr
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0xMzM4LDYgKzEzMzgsNyBAQCBz
dGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0
cXVldWUgKnZxLAo+ICAgICAgICAgdW5zaWduZWQgaW50IGksIG47Cj4gICAgICAgICB1MTYgaGVh
ZCwgaWQ7Cj4gICAgICAgICBkbWFfYWRkcl90IGFkZHI7Cj4gKyAgICAgICBib29sIGRtYV9tYXBf
aW50ZXJuYWw7Cj4KPiAgICAgICAgIGhlYWQgPSB2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4Owo+
ICAgICAgICAgZGVzYyA9IGFsbG9jX2luZGlyZWN0X3BhY2tlZCh0b3RhbF9zZywgZ2ZwKTsKPiBA
QCAtMTM1NSw3ICsxMzU2LDggQEAgc3RhdGljIGludCB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3Bh
Y2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAgICAgICAgIGlkID0gdnEtPmZyZWVf
aGVhZDsKPiAgICAgICAgIEJVR19PTihpZCA9PSB2cS0+cGFja2VkLnZyaW5nLm51bSk7Cj4KPiAt
ICAgICAgIGlmICh2aXJ0cXVldWVfbWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3Nncywg
aW5fc2dzKSkKPiArICAgICAgIGRtYV9tYXBfaW50ZXJuYWwgPSAhc2dzWzBdLT5kbWFfYWRkcmVz
czsKPiArICAgICAgIGlmIChkbWFfbWFwX2ludGVybmFsICYmIHZpcnRxdWV1ZV9tYXBfc2dzKHZx
LCBzZ3MsIHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MpKQo+ICAgICAgICAgICAgICAgICBnb3Rv
IGVycl9tYXA7Cj4KPiAgICAgICAgIGZvciAobiA9IDA7IG4gPCBvdXRfc2dzICsgaW5fc2dzOyBu
KyspIHsKPiBAQCAtMTQxNyw2ICsxNDE5LDggQEAgc3RhdGljIGludCB2aXJ0cXVldWVfYWRkX2lu
ZGlyZWN0X3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAgICAgICAgIHZxLT5w
YWNrZWQuZGVzY19zdGF0ZVtpZF0uZGF0YSA9IGRhdGE7Cj4gICAgICAgICB2cS0+cGFja2VkLmRl
c2Nfc3RhdGVbaWRdLmluZGlyX2Rlc2MgPSBkZXNjOwo+ICAgICAgICAgdnEtPnBhY2tlZC5kZXNj
X3N0YXRlW2lkXS5sYXN0ID0gaWQ7Cj4gKyAgICAgICB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRd
LmZsYWdzID0gZG1hX21hcF9pbnRlcm5hbCA/IFZSSU5HX1NUQVRFX0ZfTUFQX0lOVEVSTkFMIDog
MDsKPiArCj4KPiAgICAgICAgIHZxLT5udW1fYWRkZWQgKz0gMTsKPgo+IEBAIC0xNDI2LDcgKzE0
MzAsOCBAQCBzdGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgcmV0dXJuIDA7Cj4KPiAgdW5tYXBfcmVsZWFz
ZToKPiAtICAgICAgIHZpcnRxdWV1ZV91bm1hcF9zZ3ModnEsIHNncywgdG90YWxfc2csIG91dF9z
Z3MsIGluX3Nncyk7Cj4gKyAgICAgICBpZiAoZG1hX21hcF9pbnRlcm5hbCkKPiArICAgICAgICAg
ICAgICAgdmlydHF1ZXVlX3VubWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5f
c2dzKTsKPgo+ICBlcnJfbWFwOgo+ICAgICAgICAga2ZyZWUoZGVzYyk7Cj4gQEAgLTE2NTMsNyAr
MTY1OCw3IEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfcGFja2VkKHN0cnVjdCB2cmluZ192aXJ0
cXVldWUgKnZxLAo+ICAgICAgICAgICAgICAgICBpZiAoIWRlc2MpCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuOwo+Cj4gLSAgICAgICAgICAgICAgIGlmICh2cS0+dXNlX2RtYV9hcGkp
IHsKPiArICAgICAgICAgICAgICAgaWYgKHZxLT51c2VfZG1hX2FwaSAmJiBkbWFfbWFwX2ludGVy
bmFsKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgbGVuID0gdnEtPnBhY2tlZC5kZXNjX2V4
dHJhW2lkXS5sZW47Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGxl
biAvIHNpemVvZihzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MpOwo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpKyspCj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
