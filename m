Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC784C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:26:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BF864E59
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BF864E59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BEAD82042A;
	Mon,  8 Feb 2021 09:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W+baTpuQhMQz; Mon,  8 Feb 2021 09:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 50D6A20412;
	Mon,  8 Feb 2021 09:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 236BBC0174;
	Mon,  8 Feb 2021 09:26:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D018C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1407F86F76
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gv5WIWEaxXpq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:26:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A926982333
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612776388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYNmLVWjlxT+k3aE7QT+IAQgIjwsIKvrF+0CAZ8krTw=;
 b=cCI4ntRp/J5Ym0IjoIarPFUDvuucjjQMFG5mksW4pXAev46or/QOPxLxH1/pcqWms/1MSS
 w1R6q00eeU5k4+5zQ2J5mAdvlseVKX6Fh64J5n+y1HM+5FmCjQvSxSAmA4hZhvTsN28Wlv
 XleKaHv4/94xMU03aTK8Fk3NZAGykSo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-bg30jgVfNHauGDInPLa3xQ-1; Mon, 08 Feb 2021 04:26:26 -0500
X-MC-Unique: bg30jgVfNHauGDInPLa3xQ-1
Received: by mail-ej1-f71.google.com with SMTP id jg11so11365773ejc.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 01:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hYNmLVWjlxT+k3aE7QT+IAQgIjwsIKvrF+0CAZ8krTw=;
 b=Jy+NZAKsis31dIweRgrrPjVAqTqvYPbv00lVMGAAZGUC256aNp0wGerkTFRb5/CKYQ
 I+KYGmKewel2Tch+8NyAX9GfC+pqw9xcSpcDTOacq27a7Yf87W4VMG0V6JRA9EJ2s7JU
 X7uR9tdxNDEfK8P1yF7GsAGLwnOlNDPByx+tL3Z4WCp7aDFOYdSjf6ov3OhYl2LEhuYe
 EAAwdrQoKhNCq5b3qDpO/GwDEwTdCFgFvoCXZ/Ov2EpmzGQEF+ZxKCUBOTi9at011Qew
 VhPzB5gONaCngNAnTZBFmGR27pjzkzrR2bSWfsmPprnapGyFx/5FzMlmlldYJbnOpQqO
 cBjw==
X-Gm-Message-State: AOAM5311ivC38eOrqwQTEQmIgoCSKBYbWTYhJyS/rNL8YDGYpwXENP5S
 YuD6xqZwUYLuOgB4GgWerJzpj8yJZbY2jWzU5ggc0l9fofvKJbpWf3o8h7A1oMVhkh2TiQWh6xw
 dRk1O/ELLK+XmvX/I6zVGSst2HhOBoLlZ2iIW9zawwA==
X-Received: by 2002:a17:906:eca5:: with SMTP id
 qh5mr15724843ejb.161.1612776385083; 
 Mon, 08 Feb 2021 01:26:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyibNH61CwO8ms8feBlBM9dIeJY33HJUrYrlTUUoVvEXAxh6h+ELKUu+dYdQYCPdzKvo2AxkQ==
X-Received: by 2002:a17:906:eca5:: with SMTP id
 qh5mr15724824ejb.161.1612776384845; 
 Mon, 08 Feb 2021 01:26:24 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id y13sm4822537eds.25.2021.02.08.01.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 01:26:23 -0800 (PST)
Date: Mon, 8 Feb 2021 04:26:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
Message-ID: <20210208042512-mutt-send-email-mst@kernel.org>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMDU6MDQ6MjdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvOCDkuIvljYgyOjM3LCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiBPbiBN
b24sIEZlYiAwOCwgMjAyMSBhdCAxMjoyNzoxOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
ID4gPiBPbiAyMDIxLzIvNiDkuIrljYg3OjA3LCBTaS1XZWkgTGl1IHdyb3RlOgo+ID4gPiA+IAo+
ID4gPiA+IE9uIDIvMy8yMDIxIDExOjM2IFBNLCBFbGkgQ29oZW4gd3JvdGU6Cj4gPiA+ID4gPiBX
aGVuIGEgY2hhbmdlIG9mIG1lbW9yeSBtYXAgb2NjdXJzLCB0aGUgaGFyZHdhcmUgcmVzb3VyY2Vz
IGFyZSBkZXN0cm95ZWQKPiA+ID4gPiA+IGFuZCB0aGVuIHJlLWNyZWF0ZWQgYWdhaW4gd2l0aCB0
aGUgbmV3IG1lbW9yeSBtYXAuIEluIHN1Y2ggY2FzZSwgd2UgbmVlZAo+ID4gPiA+ID4gdG8gcmVz
dG9yZSB0aGUgaGFyZHdhcmUgYXZhaWxhYmxlIGFuZCB1c2VkIGluZGljZXMuIFRoZSBkcml2ZXIg
ZmFpbGVkIHRvCj4gPiA+ID4gPiByZXN0b3JlIHRoZSB1c2VkIGluZGV4IHdoaWNoIGlzIGFkZGVk
IGhlcmUuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEFsc28sIHNpbmNlIHRoZSBkcml2ZXIgYWxzbyBm
YWlscyB0byByZXNldCB0aGUgYXZhaWxhYmxlIGFuZCB1c2VkCj4gPiA+ID4gPiBpbmRpY2VzIHVw
b24gZGV2aWNlIHJlc2V0LCBmaXggdGhpcyBoZXJlIHRvIGF2b2lkIHJlZ3Jlc3Npb24gY2F1c2Vk
IGJ5Cj4gPiA+ID4gPiB0aGUgZmFjdCB0aGF0IHVzZWQgaW5kZXggbWF5IG5vdCBiZSB6ZXJvIHVw
b24gZGV2aWNlIHJlc2V0Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBGaXhlczogMWE4NmIzNzdhYTIx
ICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1Cj4gPiA+ID4g
PiBkZXZpY2VzIikKPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Budmlk
aWEuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiB2MCAtPiB2MToKPiA+ID4gPiA+IENsZWFy
IGluZGljZXMgdXBvbiBkZXZpY2UgcmVzZXQKPiA+ID4gPiA+IAo+ID4gPiA+ID4gIMKgIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE4ICsrKysrKysrKysrKysrKysrKwo+ID4g
PiA+ID4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+
ID4gPiA+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiBpbmRl
eCA4OGRkZTM0NTViZmQuLmI1ZmU2ZDJhZDIyZiAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiBAQCAtODcsNiArODcsNyBAQCBzdHJ1Y3Qg
bWx4NV92cV9yZXN0b3JlX2luZm8gewo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgdTY0IGRldmljZV9h
ZGRyOwo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgdTY0IGRyaXZlcl9hZGRyOwo+ID4gPiA+ID4gIMKg
wqDCoMKgwqAgdTE2IGF2YWlsX2luZGV4Owo+ID4gPiA+ID4gK8KgwqDCoCB1MTYgdXNlZF9pbmRl
eDsKPiA+ID4gPiA+ICDCoMKgwqDCoMKgIGJvb2wgcmVhZHk7Cj4gPiA+ID4gPiAgwqDCoMKgwqDC
oCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBjYjsKPiA+ID4gPiA+ICDCoMKgwqDCoMKgIGJvb2wgcmVz
dG9yZTsKPiA+ID4gPiA+IEBAIC0xMjEsNiArMTIyLDcgQEAgc3RydWN0IG1seDVfdmRwYV92aXJ0
cXVldWUgewo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgdTMyIHZpcnRxX2lkOwo+ID4gPiA+ID4gIMKg
wqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4gPiA+ID4gPiAgwqDCoMKgwqDC
oCB1MTYgYXZhaWxfaWR4Owo+ID4gPiA+ID4gK8KgwqDCoCB1MTYgdXNlZF9pZHg7Cj4gPiA+ID4g
PiAgwqDCoMKgwqDCoCBpbnQgZndfc3RhdGU7Cj4gPiA+ID4gPiAgwqAgwqDCoMKgwqDCoCAvKiBr
ZWVwIGxhc3QgaW4gdGhlIHN0cnVjdCAqLwo+ID4gPiA+ID4gQEAgLTgwNCw2ICs4MDYsNyBAQCBz
dGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQKPiA+ID4gPiA+
ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPiA+ID4gPiA+ICDCoCDCoMKgwqDCoMKg
IG9ial9jb250ZXh0ID0gTUxYNV9BRERSX09GKGNyZWF0ZV92aXJ0aW9fbmV0X3FfaW4sIGluLAo+
ID4gPiA+ID4gb2JqX2NvbnRleHQpOwo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgTUxYNV9TRVQodmly
dGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsIGh3X2F2YWlsYWJsZV9pbmRleCwKPiA+ID4g
PiA+IG12cS0+YXZhaWxfaWR4KTsKPiA+ID4gPiA+ICvCoMKgwqAgTUxYNV9TRVQodmlydGlvX25l
dF9xX29iamVjdCwgb2JqX2NvbnRleHQsIGh3X3VzZWRfaW5kZXgsCj4gPiA+ID4gPiBtdnEtPnVz
ZWRfaWR4KTsKPiA+ID4gPiA+ICDCoMKgwqDCoMKgIE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmpl
Y3QsIG9ial9jb250ZXh0LAo+ID4gPiA+ID4gcXVldWVfZmVhdHVyZV9iaXRfbWFza18xMl8zLAo+
ID4gPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdldF9mZWF0dXJlc18xMl8zKG5kZXYtPm12
ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgdnFfY3R4ID0gTUxY
NV9BRERSX09GKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LAo+ID4gPiA+ID4gdmly
dGlvX3FfY29udGV4dCk7Cj4gPiA+ID4gPiBAQCAtMTAyMiw2ICsxMDI1LDcgQEAgc3RhdGljIGlu
dCBjb25uZWN0X3FwcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldAo+ID4gPiA+ID4gKm5kZXYsIHN0cnVj
dCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4gPiA+ID4gPiAgwqAgc3RydWN0IG1seDVfdmlydHFf
YXR0ciB7Cj4gPiA+ID4gPiAgwqDCoMKgwqDCoCB1OCBzdGF0ZTsKPiA+ID4gPiA+ICDCoMKgwqDC
oMKgIHUxNiBhdmFpbGFibGVfaW5kZXg7Cj4gPiA+ID4gPiArwqDCoMKgIHUxNiB1c2VkX2luZGV4
Owo+ID4gPiA+ID4gIMKgIH07Cj4gPiA+ID4gPiAgwqAgwqAgc3RhdGljIGludCBxdWVyeV92aXJ0
cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdAo+ID4gPiA+ID4gbWx4NV92
ZHBhX3ZpcnRxdWV1ZSAqbXZxLAo+ID4gPiA+ID4gQEAgLTEwNTIsNiArMTA1Niw3IEBAIHN0YXRp
YyBpbnQgcXVlcnlfdmlydHF1ZXVlKHN0cnVjdAo+ID4gPiA+ID4gbWx4NV92ZHBhX25ldCAqbmRl
diwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldQo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgbWVtc2V0
KGF0dHIsIDAsIHNpemVvZigqYXR0cikpOwo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgYXR0ci0+c3Rh
dGUgPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgc3RhdGUpOwo+
ID4gPiA+ID4gIMKgwqDCoMKgwqAgYXR0ci0+YXZhaWxhYmxlX2luZGV4ID0gTUxYNV9HRVQodmly
dGlvX25ldF9xX29iamVjdCwKPiA+ID4gPiA+IG9ial9jb250ZXh0LCBod19hdmFpbGFibGVfaW5k
ZXgpOwo+ID4gPiA+ID4gK8KgwqDCoCBhdHRyLT51c2VkX2luZGV4ID0gTUxYNV9HRVQodmlydGlv
X25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4gPiA+ID4gPiBod191c2VkX2luZGV4KTsKPiA+
ID4gPiA+ICDCoMKgwqDCoMKgIGtmcmVlKG91dCk7Cj4gPiA+ID4gPiAgwqDCoMKgwqDCoCByZXR1
cm4gMDsKPiA+ID4gPiA+ICDCoCBAQCAtMTUzNSw2ICsxNTQwLDE2IEBAIHN0YXRpYyB2b2lkIHRl
YXJkb3duX3ZpcnRxdWV1ZXMoc3RydWN0Cj4gPiA+ID4gPiBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+
ID4gPiA+ID4gIMKgwqDCoMKgwqAgfQo+ID4gPiA+ID4gIMKgIH0KPiA+ID4gPiA+ICDCoCArc3Rh
dGljIHZvaWQgY2xlYXJfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiA+
ID4gPiA+ICt7Cj4gPiA+ID4gPiArwqDCoMKgIGludCBpOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4g
K8KgwqDCoCBmb3IgKGkgPSBuZGV2LT5tdmRldi5tYXhfdnFzIC0gMTsgaSA+PSAwOyBpLS0pIHsK
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBuZGV2LT52cXNbaV0uYXZhaWxfaWR4ID0gMDsKPiA+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBuZGV2LT52cXNbaV0udXNlZF9pZHggPSAwOwo+ID4gPiA+
ID4gK8KgwqDCoCB9Cj4gPiA+ID4gPiArfQo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gIMKgIC8qIFRP
RE86IGNyb3NzLWVuZGlhbiBzdXBwb3J0ICovCj4gPiA+ID4gPiAgwqAgc3RhdGljIGlubGluZSBi
b29sIG1seDVfdmRwYV9pc19saXR0bGVfZW5kaWFuKHN0cnVjdCBtbHg1X3ZkcGFfZGV2Cj4gPiA+
ID4gPiAqbXZkZXYpCj4gPiA+ID4gPiAgwqAgewo+ID4gPiA+ID4gQEAgLTE2MTAsNiArMTYyNSw3
IEBAIHN0YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3RydWN0Cj4gPiA+ID4gPiBtbHg1X3Zk
cGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdQo+ID4gPiA+ID4gIMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+ID4gPiA+ID4gIMKgIMKgwqDCoMKgwqAgcmktPmF2YWls
X2luZGV4ID0gYXR0ci5hdmFpbGFibGVfaW5kZXg7Cj4gPiA+ID4gPiArwqDCoMKgIHJpLT51c2Vk
X2luZGV4ID0gYXR0ci51c2VkX2luZGV4Owo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgcmktPnJlYWR5
ID0gbXZxLT5yZWFkeTsKPiA+ID4gPiA+ICDCoMKgwqDCoMKgIHJpLT5udW1fZW50ID0gbXZxLT5u
dW1fZW50Owo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgcmktPmRlc2NfYWRkciA9IG12cS0+ZGVzY19h
ZGRyOwo+ID4gPiA+ID4gQEAgLTE2NTQsNiArMTY3MCw3IEBAIHN0YXRpYyB2b2lkIHJlc3RvcmVf
Y2hhbm5lbHNfaW5mbyhzdHJ1Y3QKPiA+ID4gPiA+IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gPiA+
ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4gPiA+ID4gPiAgwqAg
wqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+YXZhaWxfaWR4ID0gcmktPmF2YWlsX2luZGV4Owo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgIG12cS0+dXNlZF9pZHggPSByaS0+dXNlZF9pbmRleDsKPiA+
ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5yZWFkeSA9IHJpLT5yZWFkeTsKPiA+ID4g
PiA+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5udW1fZW50ID0gcmktPm51bV9lbnQ7Cj4gPiA+
ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+ZGVzY19hZGRyID0gcmktPmRlc2NfYWRkcjsK
PiA+ID4gPiA+IEBAIC0xNzY4LDYgKzE3ODUsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0
X3N0YXR1cyhzdHJ1Y3QKPiA+ID4gPiA+IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4g
PiA+ID4gPiAgwqDCoMKgwqDCoCBpZiAoIXN0YXR1cykgewo+ID4gPiA+ID4gIMKgwqDCoMKgwqDC
oMKgwqDCoCBtbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1pbmcgZGV2aWNlIHJlc2V0XG4i
KTsKPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqAgdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGNsZWFyX3ZpcnRxdWV1ZXMobmRldik7Cj4gPiA+ID4g
VGhlIGNsZWFyaW5nIGxvb2tzIGZpbmUgYXQgdGhlIGZpcnN0IGdsYW5jZSwgYXMgaXQgYWxpZ25z
IHdpdGggdGhlIG90aGVyCj4gPiA+ID4gc3RhdGUgY2xlYW51cHMgZmxvYXRpbmcgYXJvdW5kIGF0
IHRoZSBzYW1lIHBsYWNlLiBIb3dldmVyLCB0aGUgdGhpbmcgaXMKPiA+ID4gPiBnZXRfdnFfc3Rh
dGUoKSBpcyBzdXBwb3NlZCB0byBiZSBjYWxsZWQgcmlnaHQgYWZ0ZXIgdG8gZ2V0IHN5bmMnZWQg
d2l0aAo+ID4gPiA+IHRoZSBsYXRlc3QgaW50ZXJuYWwgYXZhaWxfaW5kZXggZnJvbSBkZXZpY2Ug
d2hpbGUgdnEgaXMgc3RvcHBlZC4gVGhlCj4gPiA+ID4gaW5kZXggd2FzIHNhdmVkIGluIHRoZSBk
cml2ZXIgc29mdHdhcmUgYXQgdnEgc3VzcGVuc2lvbiwgYnV0IGJlZm9yZSB0aGUKPiA+ID4gPiB2
aXJ0cSBvYmplY3QgaXMgZGVzdHJveWVkLiBXZSBzaG91bGRuJ3QgY2xlYXIgdGhlIGF2YWlsX2lu
ZGV4IHRvbyBlYXJseS4KPiA+ID4gCj4gPiA+IEdvb2QgcG9pbnQuCj4gPiA+IAo+ID4gPiBUaGVy
ZSdzIGEgbGltaXRhdGlvbiBvbiB0aGUgdmlydGlvIHNwZWMgYW5kIHZEUEEgZnJhbWV3b3JrIHRo
YXQgd2UgY2FuIG5vdAo+ID4gPiBzaW1wbHkgZGlmZmVyIGRldmljZSBzdXNwZW5kaW5nIGZyb20g
ZGV2aWNlIHJlc2V0Lgo+ID4gPiAKPiA+IEFyZSB5b3UgdGFsa2luZyBhYm91dCBsaXZlIG1pZ3Jh
dGlvbiB3aGVyZSB5b3UgcmVzZXQgdGhlIGRldmljZSBidXQKPiA+IHN0aWxsIHdhbnQgdG8ga25v
dyBob3cgZmFyIGl0IHByb2dyZXNzZWQgaW4gb3JkZXIgdG8gY29udGludWUgZnJvbSB0aGUKPiA+
IHNhbWUgcGxhY2UgaW4gdGhlIG5ldyBWTT8KPiAKPiAKPiBZZXMuIFNvIGlmIHdlIHdhbnQgdG8g
c3VwcG9ydCBsaXZlIG1pZ3JhdGlvbiBhdCB3ZSBuZWVkOgo+IAo+IGluIHNyYyBub2RlOgo+IDEp
IHN1c3BlbmQgdGhlIGRldmljZQo+IDIpIGdldCBsYXN0X2F2YWlsX2lkeCB2aWEgZ2V0X3ZxX3N0
YXRlKCkKPiAKPiBpbiB0aGUgZHN0IG5vZGU6Cj4gMykgc2V0IGxhc3RfYXZhaWxfaWR4IHZpYSBz
ZXRfdnFfc3RhdGUoKQo+IDQpIHJlc3VtZSB0aGUgZGV2aWNlCj4gCj4gU28geW91IGNhbiBzZWUs
IHN0ZXAgMiByZXF1aXJlcyB0aGUgZGV2aWNlL2RyaXZlciBub3QgdG8gZm9yZ2V0IHRoZQo+IGxh
c3RfYXZhaWxfaWR4Lgo+IAo+IFRoZSBhbm5veWluZyB0aGluZyBpcyB0aGF0LCBpbiB0aGUgdmly
dGlvIHNwZWMgdGhlcmUncyBubyBkZWZpbml0aW9uIG9mCj4gZGV2aWNlIHN1c3BlbmRpbmcuIFNv
IHdlIHJldXNlIHNldF9zdGF0dXMoMCkgcmlnaHQgbm93IGZvciB2cSBzdXNwZW5kaW5nLgo+IFRo
ZW4gaWYgd2UgZm9yZ2V0IGxhc3RfYXZhaWxfaWR4IGluIHNldF9zdGF0dXMoMCksIGl0IHdpbGwg
YnJlYWsgdGhlCj4gYXNzdW1wdGlvbiBvZiBzdGVwIDIpLgo+IAo+IAo+ID4gCj4gPiA+IE5lZWQg
dG8gdGhpbmsgYWJvdXQgdGhhdC4gSSBzdWdnZXN0IGEgbmV3IHN0YXRlIGluIFsxXSwgdGhlIGlz
c3VlIGlzIHRoYXQKPiA+ID4gcGVvcGxlIGRvZXNuJ3QgbGlrZSB0aGUgYXN5bmNocm9ub3VzIEFQ
SSB0aGF0IGl0IGludHJvZHVjZXMuCj4gPiA+IAo+ID4gPiAKPiA+ID4gPiBQb3NzaWJseSBpdCBj
YW4gYmUgcG9zdHBvbmVkIHRvIHdoZXJlIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sgZ2V0cyBz
ZXQKPiA+ID4gPiBhZ2FpbiwgaS5lLiByaWdodCBiZWZvcmUgdGhlIHNldHVwX2RyaXZlcigpIGlu
IG1seDVfdmRwYV9zZXRfc3RhdHVzKCk/Cj4gPiA+IAo+ID4gPiBMb29rcyBsaWtlIGEgZ29vZCB3
b3JrYXJvdW5kLgo+IAo+IAo+IFJldGhpbmsgb2YgdGhpcywgdGhpcyB3b24ndCB3b3JrIGZvciB0
aGUgc3RlcCA0KSwgaWYgd2UgcmV1c2UgdGhlIFNfRFJJTkdfT0sKPiBmb3IgcmVzdW1pbmcuCj4g
Cj4gVGhlIG1vc3QgY2xlYW4gd2F5IGlzIHRvIGludmVudCB0aGUgZmVhdHVyZSBpbiB2aXJ0aW8g
c3BlYyBhbmQgaW1wbGVtZW50Cj4gdGhhdCBpbiB0aGUgZHJpdmVyLgo+IAo+IFRoYW5rcwoKR2l2
ZW4gaXQncyBiZXR3ZWVuIHBhcnRzIG9mIGRldmljZSAoYmV0d2VlbiBxZW11IGFuZCBob3N0IGtl
cm5lbCkKSSBkb24ndCB0aGluayB3ZSBuZWVkIGl0IGluIHRoZSBzcGVjIGV2ZW4uIEp1c3QgYWRk
IGEgbmV3IGlvY3RsLgoKCj4gCj4gCj4gPiA+IAo+ID4gPiBUaGFua3MKPiA+ID4gCj4gPiA+IAo+
ID4gPiA+IC1TaXdlaQo+ID4gPiAKPiA+ID4gWzFdCj4gPiA+IGh0dHBzOi8vbGlzdHMub2FzaXMt
b3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMDEyL21zZzAwMDI5Lmh0bWwKPiA+
ID4gCj4gPiA+IAo+ID4gPiA+ID4gbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsK
PiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYuc3RhdHVzID0gMDsKPiA+
ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzID0gMDsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
