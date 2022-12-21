Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175B1C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 08:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A3284185F;
	Wed, 21 Dec 2022 08:22:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A3284185F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AsKRqygf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 60CQxtYx_mud; Wed, 21 Dec 2022 08:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 863F54168E;
	Wed, 21 Dec 2022 08:22:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 863F54168E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 255CEC0071;
	Wed, 21 Dec 2022 08:22:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25AB6C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 08:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AED3160D96
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 08:22:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AED3160D96
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AsKRqygf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L10UAGbV6Klc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 08:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8CB760A82
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8CB760A82
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 08:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671610925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oH4xR+6GHPxwyourQ1So44EBmZiMwR8a5z9E2ZObjNc=;
 b=AsKRqygfKjusxqGPsDDU4owaF+bgnfpUq0oQZep74/7KjGnreVf2yP8MWXACKgINaM3VMC
 EspdYSVcFJQIO6esFbKju+mJrXPhLlL1AoOHNVP1EKD+3mmj8ec7DwONkUnOxinMj4DkDu
 9Khw1vIucLb2ibGbbDcQsR29zkTxRvI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-81-TuDHNvBkNuKEcUUOjNEKiA-1; Wed, 21 Dec 2022 03:22:04 -0500
X-MC-Unique: TuDHNvBkNuKEcUUOjNEKiA-1
Received: by mail-oo1-f69.google.com with SMTP id
 y25-20020a4a6519000000b004a398cd439bso6605410ooc.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 00:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oH4xR+6GHPxwyourQ1So44EBmZiMwR8a5z9E2ZObjNc=;
 b=uVodrGIRSCF8VpDsB5j7RCuRlqYK8wwqNXRQCD5yRh79OQVTEp9NQMKKT0meKg34F8
 2+yKb9UC1c5hVTu6mA7r843tfZmafRdZmx0j38ORbeLNOIcOMMU2zevs7te3kXpldcw2
 PMac6WDiu5E9qBOOk4hdKypzy8bUXECDxSucjmcS7i2w4D4hZGcIlG55jx0VG9NpOYLN
 iA9yEew/mxJFvRcOTYECeVZhOwxxZq2v6xyEqbwPDzRxlwEm4fnXfU2jMd0pz7LUpcbJ
 MjxTJ6gS5Rsb5P+UktVN6f7J/RaEWQBCX85w+kESJpRqBomc1ebGhRZ/R8EDzzdjJDTN
 9jHQ==
X-Gm-Message-State: AFqh2kqJlSzMXe+ZGW2pxDpV87UYwlP/KFlKn+FHQR+QAUxV5kTMq752
 WdeNL5uAML2eyTOe0aP6NtaAmmIQc5NOZd9/kK2WlYLlV2WlFAkufX8SoJjK2J8Iv8Nh6Vwjom4
 mmx5BW4hD6wZHA1R0Say+HTdc1MKVCNyL/pvZN51tpPS1FUXhhh825Z0tMg==
X-Received: by 2002:a05:6830:4a3:b0:670:8334:ccf2 with SMTP id
 l3-20020a05683004a300b006708334ccf2mr63237otd.201.1671610923618; 
 Wed, 21 Dec 2022 00:22:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv1QgX5oNaFRL+esvIe2wzkXWV7DRjGd86V2hWO4JJsn9J3zuQYV7VCnMIRuGtVaJQH8nbwm1p1aqCGGZyC5Zk=
X-Received: by 2002:a05:6830:4a3:b0:670:8334:ccf2 with SMTP id
 l3-20020a05683004a300b006708334ccf2mr63218otd.201.1671610923360; Wed, 21 Dec
 2022 00:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20221215113144.322011-1-eperezma@redhat.com>
 <20221215113144.322011-7-eperezma@redhat.com>
 <CACGkMEtE_6nci5zwQZbOMbu3e9gh4aa_88WjTgkWkjKqQBB3Zw@mail.gmail.com>
 <CAJaqyWcxeuOiHYBb_ftedSrJpNpN9vQJ2sZZ_5cZh4RsQSdgVQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcxeuOiHYBb_ftedSrJpNpN9vQJ2sZZ_5cZh4RsQSdgVQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Dec 2022 16:21:52 +0800
Message-ID: <CACGkMEtkWJQVrnuG7CKJ+zFcMFhhZs3=iFPjv85U7KAjkpd=EA@mail.gmail.com>
Subject: Re: [PATCH v9 06/12] vdpa: request iova_range only once
To: Eugenio Perez Martin <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>,
 Longpeng <longpeng2@huawei.com>
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

T24gRnJpLCBEZWMgMTYsIDIwMjIgYXQgNTo1MyBQTSBFdWdlbmlvIFBlcmV6IE1hcnRpbgo8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBGcmksIERlYyAxNiwgMjAyMiBhdCA4OjI5
IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRo
dSwgRGVjIDE1LCAyMDIyIGF0IDc6MzIgUE0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBDdXJyZW50bHkgaW92YSByYW5nZSBpcyByZXF1ZXN0
ZWQgb25jZSBwZXIgcXVldWUgcGFpciBpbiB0aGUgY2FzZSBvZgo+ID4gPiBuZXQuIFJlZHVjZSB0
aGUgbnVtYmVyIG9mIGlvY3RscyBhc2tpbmcgaXQgb25jZSBhdCBpbml0aWFsaXphdGlvbiBhbmQK
PiA+ID4gcmV1c2luZyB0aGF0IHZhbHVlIGZvciBlYWNoIHZob3N0X3ZkcGEuCj4gPiA+Cj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+ID4g
PiAtLS0KPiA+ID4gIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgfCAxNSAtLS0tLS0tLS0tLS0tLS0K
PiA+ID4gIG5ldC92aG9zdC12ZHBhLmMgICAgICAgfCAyNyArKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRp
b25zKC0pCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jIGIv
aHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+ID4gPiBpbmRleCA2OTFiY2M4MTFhLi45YjdmNGVmMDgz
IDEwMDY0NAo+ID4gPiAtLS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gPiA+ICsrKyBiL2h3
L3ZpcnRpby92aG9zdC12ZHBhLmMKPiA+ID4gQEAgLTM2NSwxOSArMzY1LDYgQEAgc3RhdGljIGlu
dCB2aG9zdF92ZHBhX2FkZF9zdGF0dXMoc3RydWN0IHZob3N0X2RldiAqZGV2LCB1aW50OF90IHN0
YXR1cykKPiA+ID4gICAgICByZXR1cm4gMDsKPiA+ID4gIH0KPiA+ID4KPiA+ID4gLXN0YXRpYyB2
b2lkIHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gPiA+
IC17Cj4gPiA+IC0gICAgaW50IHJldCA9IHZob3N0X3ZkcGFfY2FsbCh2LT5kZXYsIFZIT1NUX1ZE
UEFfR0VUX0lPVkFfUkFOR0UsCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
di0+aW92YV9yYW5nZSk7Cj4gPiA+IC0gICAgaWYgKHJldCAhPSAwKSB7Cj4gPiA+IC0gICAgICAg
IHYtPmlvdmFfcmFuZ2UuZmlyc3QgPSAwOwo+ID4gPiAtICAgICAgICB2LT5pb3ZhX3JhbmdlLmxh
c3QgPSBVSU5UNjRfTUFYOwo+ID4gPiAtICAgIH0KPiA+ID4gLQo+ID4gPiAtICAgIHRyYWNlX3Zo
b3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodi0+ZGV2LCB2LT5pb3ZhX3JhbmdlLmZpcnN0LAo+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdi0+aW92YV9yYW5nZS5sYXN0
KTsKPiA+ID4gLX0KPiA+ID4gLQo+ID4gPiAgLyoKPiA+ID4gICAqIFRoZSB1c2Ugb2YgdGhpcyBm
dW5jdGlvbiBpcyBmb3IgcmVxdWVzdHMgdGhhdCBvbmx5IG5lZWQgdG8gYmUKPiA+ID4gICAqIGFw
cGxpZWQgb25jZS4gVHlwaWNhbGx5IHN1Y2ggcmVxdWVzdCBvY2N1cnMgYXQgdGhlIGJlZ2lubmlu
Zwo+ID4gPiBAQCAtNDY1LDggKzQ1Miw2IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9pbml0KHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVycnApCj4gPiA+ICAg
ICAgICAgIGdvdG8gZXJyOwo+ID4gPiAgICAgIH0KPiA+ID4KPiA+ID4gLSAgICB2aG9zdF92ZHBh
X2dldF9pb3ZhX3JhbmdlKHYpOwo+ID4gPiAtCj4gPiA+ICAgICAgaWYgKCF2aG9zdF92ZHBhX2Zp
cnN0X2RldihkZXYpKSB7Cj4gPiA+ICAgICAgICAgIHJldHVybiAwOwo+ID4gPiAgICAgIH0KPiA+
ID4gZGlmZiAtLWdpdCBhL25ldC92aG9zdC12ZHBhLmMgYi9uZXQvdmhvc3QtdmRwYS5jCj4gPiA+
IGluZGV4IDJjMGZmNmQ3YjAuLmI2NDYyZjAxOTIgMTAwNjQ0Cj4gPiA+IC0tLSBhL25ldC92aG9z
dC12ZHBhLmMKPiA+ID4gKysrIGIvbmV0L3Zob3N0LXZkcGEuYwo+ID4gPiBAQCAtNTQxLDE0ICs1
NDEsMTUgQEAgc3RhdGljIGNvbnN0IFZob3N0U2hhZG93VmlydHF1ZXVlT3BzIHZob3N0X3ZkcGFf
bmV0X3N2cV9vcHMgPSB7Cj4gPiA+ICB9Owo+ID4gPgo+ID4gPiAgc3RhdGljIE5ldENsaWVudFN0
YXRlICpuZXRfdmhvc3RfdmRwYV9pbml0KE5ldENsaWVudFN0YXRlICpwZWVyLAo+ID4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmRldmlj
ZSwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBjaGFyICpuYW1lLAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCB2ZHBhX2RldmljZV9mZCwKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnQgcXVldWVfcGFpcl9pbmRleCwKPiA+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnZxcywKPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGlzX2RhdGFwYXRoLAo+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc3Zx
LAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZob3N0
SU9WQVRyZWUgKmlvdmFfdHJlZSkKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKmRldmljZSwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgdmRwYV9kZXZpY2VfZmQsCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcXVldWVfcGFpcl9pbmRleCwK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBudnFzLAo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc19kYXRh
cGF0aCwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
c3ZxLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlLAo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVmhvc3RJT1ZBVHJlZSAqaW92YV90cmVlKQo+ID4KPiA+
IE5pdDogaXQncyBiZXR0ZXIgbm90IG1peCBzdHlsZSBjaGFuZ2VzLgo+ID4KPgo+IFRoZSBzdHls
ZSBjaGFuZ2VzIGFyZSBiZWNhdXNlIHRoZSBuZXcgcGFyYW1ldGVyIGlzIGxvbmdlciB0aGFuIDgw
Cj4gY2hhcmFjdGVycywgZG8geW91IHByZWZlciBtZSB0byBzZW5kIGEgcHJldmlvdXMgcGF0Y2gg
cmVkdWNpbmcKPiBpbmRlbnRhdGlvbj8KPgoKTWljaGFsZSwgd2hhdCdzIHlvdXIgcHJlZmVyZW5j
ZT8gSSdtIGZpbmUgd2l0aCBib3RoLgoKVGhhbmtzCgo+IFRoYW5rcyEKPgo+ID4gT3RoZXIgdGhh
biB0aGlzOgo+ID4KPiA+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvbndhbmdAcmVkaGF0LmNv
bT4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiA+ICB7Cj4gPiA+ICAgICAgTmV0Q2xpZW50U3RhdGUg
Km5jID0gTlVMTDsKPiA+ID4gICAgICBWaG9zdFZEUEFTdGF0ZSAqczsKPiA+ID4gQEAgLTU2Nyw2
ICs1NjgsNyBAQCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9zdF92ZHBhX2luaXQoTmV0
Q2xpZW50U3RhdGUgKnBlZXIsCj4gPiA+ICAgICAgcy0+dmhvc3RfdmRwYS5kZXZpY2VfZmQgPSB2
ZHBhX2RldmljZV9mZDsKPiA+ID4gICAgICBzLT52aG9zdF92ZHBhLmluZGV4ID0gcXVldWVfcGFp
cl9pbmRleDsKPiA+ID4gICAgICBzLT52aG9zdF92ZHBhLnNoYWRvd192cXNfZW5hYmxlZCA9IHN2
cTsKPiA+ID4gKyAgICBzLT52aG9zdF92ZHBhLmlvdmFfcmFuZ2UgPSBpb3ZhX3JhbmdlOwo+ID4g
PiAgICAgIHMtPnZob3N0X3ZkcGEuaW92YV90cmVlID0gaW92YV90cmVlOwo+ID4gPiAgICAgIGlm
ICghaXNfZGF0YXBhdGgpIHsKPiA+ID4gICAgICAgICAgcy0+Y3ZxX2NtZF9vdXRfYnVmZmVyID0g
cWVtdV9tZW1hbGlnbihxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKSwKPiA+ID4gQEAgLTY0Niw2
ICs2NDgsNyBAQCBpbnQgbmV0X2luaXRfdmhvc3RfdmRwYShjb25zdCBOZXRkZXYgKm5ldGRldiwg
Y29uc3QgY2hhciAqbmFtZSwKPiA+ID4gICAgICBpbnQgdmRwYV9kZXZpY2VfZmQ7Cj4gPiA+ICAg
ICAgZ19hdXRvZnJlZSBOZXRDbGllbnRTdGF0ZSAqKm5jcyA9IE5VTEw7Cj4gPiA+ICAgICAgZ19h
dXRvcHRyKFZob3N0SU9WQVRyZWUpIGlvdmFfdHJlZSA9IE5VTEw7Cj4gPiA+ICsgICAgc3RydWN0
IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlOwo+ID4gPiAgICAgIE5ldENsaWVudFN0
YXRlICpuYzsKPiA+ID4gICAgICBpbnQgcXVldWVfcGFpcnMsIHIsIGkgPSAwLCBoYXNfY3ZxID0g
MDsKPiA+ID4KPiA+ID4gQEAgLTY4OSwxNCArNjkyLDEyIEBAIGludCBuZXRfaW5pdF92aG9zdF92
ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ID4gPiAgICAgICAg
ICByZXR1cm4gcXVldWVfcGFpcnM7Cj4gPiA+ICAgICAgfQo+ID4gPgo+ID4gPiArICAgIHZob3N0
X3ZkcGFfZ2V0X2lvdmFfcmFuZ2UodmRwYV9kZXZpY2VfZmQsICZpb3ZhX3JhbmdlKTsKPiA+ID4g
ICAgICBpZiAob3B0cy0+eF9zdnEpIHsKPiA+ID4gLSAgICAgICAgc3RydWN0IHZob3N0X3ZkcGFf
aW92YV9yYW5nZSBpb3ZhX3JhbmdlOwo+ID4gPiAtCj4gPiA+ICAgICAgICAgIGlmICghdmhvc3Rf
dmRwYV9uZXRfdmFsaWRfc3ZxX2ZlYXR1cmVzKGZlYXR1cmVzLCBlcnJwKSkgewo+ID4gPiAgICAg
ICAgICAgICAgZ290byBlcnJfc3ZxOwo+ID4gPiAgICAgICAgICB9Cj4gPiA+Cj4gPiA+IC0gICAg
ICAgIHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2UodmRwYV9kZXZpY2VfZmQsICZpb3ZhX3Jhbmdl
KTsKPiA+ID4gICAgICAgICAgaW92YV90cmVlID0gdmhvc3RfaW92YV90cmVlX25ldyhpb3ZhX3Jh
bmdlLmZpcnN0LCBpb3ZhX3JhbmdlLmxhc3QpOwo+ID4gPiAgICAgIH0KPiA+ID4KPiA+ID4gQEAg
LTcwNSw3ICs3MDYsNyBAQCBpbnQgbmV0X2luaXRfdmhvc3RfdmRwYShjb25zdCBOZXRkZXYgKm5l
dGRldiwgY29uc3QgY2hhciAqbmFtZSwKPiA+ID4gICAgICBmb3IgKGkgPSAwOyBpIDwgcXVldWVf
cGFpcnM7IGkrKykgewo+ID4gPiAgICAgICAgICBuY3NbaV0gPSBuZXRfdmhvc3RfdmRwYV9pbml0
KHBlZXIsIFRZUEVfVkhPU1RfVkRQQSwgbmFtZSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwgaSwgMiwgdHJ1ZSwgb3B0cy0+eF9zdnEs
Cj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW92YV90cmVlKTsK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb3ZhX3JhbmdlLCBp
b3ZhX3RyZWUpOwo+ID4gPiAgICAgICAgICBpZiAoIW5jc1tpXSkKPiA+ID4gICAgICAgICAgICAg
IGdvdG8gZXJyOwo+ID4gPiAgICAgIH0KPiA+ID4gQEAgLTcxMyw3ICs3MTQsNyBAQCBpbnQgbmV0
X2luaXRfdmhvc3RfdmRwYShjb25zdCBOZXRkZXYgKm5ldGRldiwgY29uc3QgY2hhciAqbmFtZSwK
PiA+ID4gICAgICBpZiAoaGFzX2N2cSkgewo+ID4gPiAgICAgICAgICBuYyA9IG5ldF92aG9zdF92
ZHBhX2luaXQocGVlciwgVFlQRV9WSE9TVF9WRFBBLCBuYW1lLAo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdmRwYV9kZXZpY2VfZmQsIGksIDEsIGZhbHNlLAo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0cy0+eF9zdnEsIGlvdmFfdHJlZSk7
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHRzLT54X3N2cSwgaW92
YV9yYW5nZSwgaW92YV90cmVlKTsKPiA+ID4gICAgICAgICAgaWYgKCFuYykKPiA+ID4gICAgICAg
ICAgICAgIGdvdG8gZXJyOwo+ID4gPiAgICAgIH0KPiA+ID4gLS0KPiA+ID4gMi4zMS4xCj4gPiA+
Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
