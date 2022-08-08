Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F1C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 13:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FF5D82560;
	Mon,  8 Aug 2022 13:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FF5D82560
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hUGyCD15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESyV7XMKnCZd; Mon,  8 Aug 2022 13:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4FDE78254D;
	Mon,  8 Aug 2022 13:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FDE78254D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC5EC0032;
	Mon,  8 Aug 2022 13:47:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 179F3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D882460A46
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:47:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D882460A46
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hUGyCD15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1n10U5PFT2NX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9104F60701
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9104F60701
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659966432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOmT+Y+kg4OOX8DXm3hPII7bzcp2Gy2mpH7jSjdpTAw=;
 b=hUGyCD15sborL+wtrfoSC2CY5+4MFEbk8NRStpd3xgXdR9q5ooDAe66HDlkn5vqsJq33SA
 0EEdXpVRsc8A8E776PCsAoyZPkL97aa9UAEPznt5GRy9DbT1KIuxqFnsjfoYUiRgg5dkrg
 eL/HNwJLzbs/bu29RDEccc/G1+SfGrs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-ap1keKVIOP2oo58dy-zYew-1; Mon, 08 Aug 2022 09:47:09 -0400
X-MC-Unique: ap1keKVIOP2oo58dy-zYew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAA7F2999B2F;
 Mon,  8 Aug 2022 13:47:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57651C15BA8;
 Mon,  8 Aug 2022 13:47:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <20220804105914.3707389-3-ricardo.canuelo@collabora.com>
Organization: Red Hat GmbH
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
 <20220804105914.3707389-3-ricardo.canuelo@collabora.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Mon, 08 Aug 2022 15:47:06 +0200
Message-ID: <87bksuetk5.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 bagasdotme@gmail.com, kernel@collabora.com
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

T24gVGh1LCBBdWcgMDQgMjAyMiwgUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNv
bGxhYm9yYS5jb20+IHdyb3RlOgoKPiBCYXNpYyBkb2MgYWJvdXQgVmlydGlvIG9uIExpbnV4IGFu
ZCBhIHNob3J0IHR1dG9yaWFsIG9uIFZpcnRpbyBkcml2ZXJzLgo+Cj4gU2lnbmVkLW9mZi1ieTog
UmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNvbGxhYm9yYS5jb20+Cj4gLS0tCj4g
IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9pbmRleC5yc3QgICAgICAgICAgICB8ICAgMSArCj4g
IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vaW5kZXgucnN0ICAgICB8ICAxMSArCj4g
IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdCAgICB8IDE1MSArKysr
KysrKysrKysrKwo+ICAuLi4vdmlydGlvL3dyaXRpbmdfdmlydGlvX2RyaXZlcnMucnN0ICAgICAg
ICAgfCAxODkgKysrKysrKysrKysrKysrKysrCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArCj4gIDUgZmlsZXMgY2hhbmdlZCwgMzUzIGluc2Vy
dGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92
aXJ0aW8vaW5kZXgucnN0Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RyaXZl
ci1hcGkvdmlydGlvL3ZpcnRpby5yc3QKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZHJpdmVyLWFwaS92aXJ0aW8vd3JpdGluZ192aXJ0aW9fZHJpdmVycy5yc3QKCiguLi4pCgo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QKPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNGI3M2M3MDVjOTRjCj4gLS0tIC9kZXYv
bnVsbAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdAo+
IEBAIC0wLDAgKzEsMTUxIEBACj4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
Cj4gKwo+ICsuLiBfdmlydGlvOgo+ICsKPiArPT09PT09PT09PT09PT09Cj4gK1ZpcnRpbyBvbiBM
aW51eAo+ICs9PT09PT09PT09PT09PT0KPiArCj4gK0ludHJvZHVjdGlvbgo+ICs9PT09PT09PT09
PT0KPiArCj4gK1ZpcnRpbyBpcyBhbiBvcGVuIHN0YW5kYXJkIGludGVyZmFjZSBmb3IgdmlydHVh
bCBtYWNoaW5lcyB0byBhY2Nlc3MKPiArcGFyYXZpcnR1YWxpemVkIGRldmljZXMsIGllLiBkZXZp
Y2VzIHRoYXQgYXJlbid0IGVtdWxhdGVkIGJ5IGEKPiAraHlwZXJ2aXNvciBidXQgcmF0aGVyIHJl
YWwgaG9zdCBkZXZpY2VzIHRoYXQgYXJlIGV4cG9zZWQgYnkgdGhlCj4gK2h5cGVydmlzb3IgdG8g
dGhlIGd1ZXN0IHRvIGFjaGlldmUgbmF0aXZlIHBlcmZvcm1hbmNlLiBJbiBvdGhlciB3b3JkcywK
PiAraXQgcHJvdmlkZXMgYSBjb21tdW5pY2F0aW9uIG1lY2hhbmlzbSBmb3IgYSBndWVzdCBPUyB0
byB1c2UgZGV2aWNlcyBvbgo+ICt0aGUgaG9zdCBtYWNoaW5lLiBBZGRpdGlvbmFsbHksIHNvbWUg
ZGV2aWNlcyBhbHNvIGltcGxlbWVudCB0aGUgdmlydGlvCj4gK2ludGVyZmFjZSBpbiBoYXJkd2Fy
ZS4KPiArCj4gK0ZvciBwYXJhdmlydHVhbGl6ZWQgZGV2aWNlcywgdGhlIGNvbmNyZXRlIGhhcmR3
YXJlIGRldGFpbHMgb2YgdGhlIHJlYWwKPiAraG9zdCBkZXZpY2VzIGFyZSBhYnN0cmFjdGVkIGlu
IHRoZSBoeXBlcnZpc29yLCB3aGljaCBwcm92aWRlcyBhIHNldCBvZgo+ICtzaW1wbGlmaWVkIHZp
cnR1YWwgZGV2aWNlcyB0aGF0IGltcGxlbWVudCB0aGUgdmlydGlvIHByb3RvY29sLiBUaGVzZQo+
ICtkZXZpY2VzIGFyZSBkZWZpbmVkIGluIENoYXB0ZXIgNSAoIkRldmljZSBUeXBlcyIpIG9mIHRo
ZSB2aXJ0aW8gc3BlYyBbMV0KPiArYW5kIHRoZXkncmUgdGhlIGRldmljZXMgdGhhdCB0aGUgZ3Vl
c3QgT1Mgd2lsbCB1bHRpbWF0ZWx5IGhhbmRsZS4gU28sIGluCj4gK3RoYXQgcmVnYXJkLCB0aGUg
Z3Vlc3QgT1Mga25vd3MgaXQncyBydW5uaW5nIGluIGEgdmlydHVhbCBlbnZpcm9ubWVudAo+ICth
bmQgdGhhdCBpdCBuZWVkcyB0byB1c2UgdGhlIGFwcHJvcHJpYXRlIHZpcnRpbyBkcml2ZXJzIHRv
IGhhbmRsZSB0aGUKPiArZGV2aWNlcyBpbnN0ZWFkIG9mIHRoZSByZWd1bGFyIGRldmljZSBkcml2
ZXJzIGl0J2QgdXNlIGluIGEgbmF0aXZlIG9yCj4gK3B1cmVseSB2aXJ0dWFsIGVudmlyb25tZW50
ICh3aXRoIGVtdWxhdGVkIGRldmljZXMpLgoKSG0uLi4gc28gSSdtIG5vdCBxdWl0ZSBoYXBweSB3
aXRoIHRob3NlIHR3byBwYXJhZ3JhcGhzLCBidXQgSSdtIG5vdCBzdXJlCmhvdyB0byBtYWtlIGl0
IGJldHRlci4KCi0gV2hpbGUgdGhlIG9yaWdpbnMgb2YgdmlydGlvIGFyZSBoeXBlcnZpc29yIGlt
cGxlbWVudGF0aW9ucywgdGhlCiAgc3RhbmRhcmQgaXMgZGVzY3JpYmluZyB0aGUgbWVjaGFuaXNt
cyBvZiBkZXZpY2UgPC0+IGRyaXZlcgogIGNvbW11bmljYXRpb24sIHJlZ2FyZGxlc3Mgd2hldGhl
ciB0aGUgZGV2aWNlIGlzIGEgaGFyZHdhcmUgZW50aXR5IG9yCiAgc29tZXRoaW5nIGVtdWxhdGVk
IGJ5IGEgaHlwZXJ2aXNvci4KLSBJJ20gbm90IHF1aXRlIHN1cmUgd2hhdCB5b3UgYXJlIHJlZmVy
cmluZyB0byB3aXRoICJyZWFsIGhvc3QKICBkZXZpY2VzIi4gV2UgY2FuIGhhdmUgZS5nLiBhIHJl
YWwgZGlzayB0aGF0IGlzIGhhbmRlZCB0byBhIGd1ZXN0IHZpYQogIHZpcnRpby1ibGsgYXMgYSB3
aG9sZSwgb3Igd2UgY2FuIGhhdmUgc29tZSBraW5kIG9mIGZpbGUgdGhhdCBpcwogIGV4cG9zZWQg
dmlhIHZpcnRpby1ibGsuIE90aGVyIGRldmljZSB0eXBlcyBjYW4gYWxzbyBiZSBjb21wbGV0ZWx5
CiAgZW11bGF0ZWQuCi0gVGhlIE9TIHBpY2tzIHRoZSBkcml2ZXIgZGVwZW5kaW5nIG9uIHdoYXQg
ZGV2aWNlIGlzIGRpc2NvdmVyczsgdmlydGlvCiAgZGV2aWNlIGRyaXZlcnMgYXJlIG5vdCBhbnkg
ZGlmZmVyZW50IGZyb20gb3RoZXIgZGV2aWNlIGRyaXZlcnMgaW4gdGhhdAogIHJlZ2FyZC4KClNv
IEkgdGhpbmsgdGhlIGtleSBwaWVjZXMgb2YgdmlydGlvIGFyZSB0aGUgZm9sbG93aW5nOgoKLSBp
dCBpcyBhbiBvcGVuIHN0YW5kYXJkCi0gaXQgZGVzY3JpYmVzIGEgcHJvdG9jb2wsIHdoaWNoIGNh
biBiZSB1c2VkIHRvIGltcGxlbWVudCBhIGxvdCBvZgogIGRpZmZlcmVudCBkZXZpY2UgdHlwZXMK
LSB0aG9zZSBkZXZpY2VzIGFyZSBleHBvc2VkIHRvIHRoZSBvcGVyYXRpbmcgc3lzdGVtIHZpYSBz
dGFuZGFyZAogIG1lY2hhbmlzbXMgc3VjaCBhcyBQQ0kKLSB2aXJ0aW8gZGV2aWNlcyBjYW4gYmUg
aW1wbGVtZW50ZWQgaW4gdmFyaW91cyB3YXlzLCBzdWNoIGFzIGluCiAgaHlwZXJ2aXNvcnMgKG1v
cmUgY29tbW9uKSBvciBhcyBhIHJlYWwgaGFyZHdhcmUgZGV2aWNlCgpGb3IgdGhlIHJlbWFpbmRl
ciBvZiB0aGlzIGRvY3VtZW50LCBpdCBpcyBwcm9iYWJseSBmaW5lIHRvIGZvY3VzIG9uIHRoZQpo
eXBlcnZpc29yIHVzZSBjYXNlLgoKKC4uLikKCj4gK0hvdyBhIHZpcnRpbyBkZXZpY2UgaXMgZm91
bmQgYW5kIGNvbmZpZ3VyZWQgYnkgdGhlIGtlcm5lbCBkZXBlbmRzIG9uIGhvdwo+ICt0aGUgaHlw
ZXJ2aXNvciBkZWZpbmVzIGl0LiBUYWtpbmcgdGhlIGBRRU1VIHZpcnRpby1jb25zb2xlCj4gKzxo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9ibG9iL21hc3Rlci9ody9jaGFy
L3ZpcnRpby1jb25zb2xlLmM+YF9fCj4gK2RldmljZSBhcyBhbiBleGFtcGxlLiBXaGVuIHVzaW5n
IFBDSSBhcyBhIHRyYW5zcG9ydCBtZXRob2QsIHRoZSBkZXZpY2UKPiArd2lsbCBwcmVzZW50IGl0
c2VsZiBpbiB0aGUgUENJIGJ1cyB3aXRoIHZlbmRvciAweDFhZjQgKFJlZEhhdCwgSW5jLikgYW5k
CgpzL2luL29uLyA/CnMvUmVkSGF0L1JlZCBIYXQvIDopCgo+ICtkZXZpY2UgaWQgMHgxMDAzICh2
aXJ0aW8gY29uc29sZSksIGFzIGRlZmluZWQgaW4gdGhlIHNwZWMsIHNvIHRoZSBrZXJuZWwKPiAr
d2lsbCBkZXRlY3QgaXQgYXMgaXQgd291bGQgZG8gd2l0aCBhbnkgb3RoZXIgUENJIGRldmljZS4K
CiguLi4pCgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3dy
aXRpbmdfdmlydGlvX2RyaXZlcnMucnN0IGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRp
by93cml0aW5nX3ZpcnRpb19kcml2ZXJzLnJzdAo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi4xMzljNzg1YTM4ZWYKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby93cml0aW5nX3ZpcnRpb19kcml2ZXJzLnJzdAo+
IEBAIC0wLDAgKzEsMTg5IEBACj4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
Cj4gKwo+ICsuLiBfd3JpdGluZ192aXJ0aW9fZHJpdmVyczoKPiArCj4gKz09PT09PT09PT09PT09
PT09PT09PT0KPiArV3JpdGluZyBWaXJ0aW8gRHJpdmVycwo+ICs9PT09PT09PT09PT09PT09PT09
PT09Cj4gKwo+ICtJbnRyb2R1Y3Rpb24KPiArPT09PT09PT09PT09Cj4gKwo+ICtDaGFwdGVyIDUg
KCJEZXZpY2UgVHlwZXMiKSBpbiB0aGUgdmlydGlvIHNwZWNpZmljYXRpb24gWzFdIGRlZmluZXMg
YWxsCj4gK3RoZSBzdXBwb3J0ZWQgdmlydGlvIGRldmljZSB0eXBlcy4gU2luY2UgdGhlc2UgZGV2
aWNlcyBhcmUsIGJ5Cj4gK2RlZmluaXRpb24sIG1lYW50IGFzIGFic3RyYWN0aW9ucyBmb3IgYSB3
aWRlIHZhcmlldHkgb2YgcmVhbCBoYXJkd2FyZSwKClNlZSBteSBjb21tZW50cyBhYm92ZSwgdmly
dGlvIGRldmljZXMgY2FuIGFsc28gYmUgZnVsbHkgZW11bGF0ZWQgb3IgcmVhbApoYXJkd2FyZSBk
ZXZpY2VzLgoKPiArdGhlIGFkZGl0aW9uIG9mIG5ldyB2aXJ0aW8gZHJpdmVycyBpcyBub3QgZXhw
ZWN0ZWQgdG8gYmUgdmVyeQo+ICtmcmVxdWVudC4gU3RpbGwsIHRoaXMgZG9jdW1lbnQgc2VydmVz
IGFzIGEgYmFzaWMgZ3VpZGVsaW5lIGZvciBkcml2ZXIKCkkgdGhpbmsgd2Ugc2hvdWxkIG5vdCBt
YWtlIGFueSBzdGF0ZW1lbnQgcmVnYXJkaW5nIGZyZXF1ZW5jeSBvZiBuZXcKYWRkaXRpb25zOyBz
b21ldGltZXMsIHRoZXJlJ3MgYSBmbHVycnkgb2YgYWN0aXZpdHksIHNvbWV0aW1lcywgdGhlcmUn
cwpub3RoaW5nIGZvciBhZ2VzIDopCgo+ICtwcm9ncmFtbWVycyB0aGF0IG5lZWQgdG8gaGFjayBh
IG5ldyB2aXJ0aW8gZHJpdmVyIG9yIHVuZGVyc3RhbmQgdGhlCj4gK2Vzc2VudGlhbHMgb2YgdGhl
IGV4aXN0aW5nIG9uZXMuIFNlZSA6cmVmOmBWaXJ0aW8gb24gTGludXggPHZpcnRpbz5gIGZvcgo+
ICthIGdlbmVyYWwgb3ZlcnZpZXcgb2YgdmlydGlvLgo+ICsKPiArCj4gK0RyaXZlciBib2lsZXJw
bGF0ZQo+ICs9PT09PT09PT09PT09PT09PT0KPiArCj4gK0FzIGEgYmFyZSBtaW5pbXVtLCBhIHZp
cnRpbyBkcml2ZXIgc2hvdWxkIHJlZ2lzdGVyIGluIHRoZSB2aXJ0aW8gYnVzIGFuZAoKcy9zaG91
bGQvbmVlZHMgdG8vID8KCj4gK2NvbmZpZ3VyZSB0aGUgdmlydHF1ZXVlcyBmb3IgdGhlIGRldmlj
ZSBhY2NvcmRpbmcgdG8gaXRzIHNwZWMsIHRoZQo+ICtjb25maWd1cmF0aW9uIG9mIHRoZSB2aXJ0
cXVldWVzIGluIHRoZSBkcml2ZXIgc2lkZSBtdXN0IG1hdGNoIHRoZQo+ICt2aXJ0cXVldWUgZGVm
aW5pdGlvbnMgaW4gdGhlIGRldmljZS4gQSBiYXNpYyBkcml2ZXIgc2tlbGV0b24gY291bGQgbG9v
awo+ICtsaWtlIHRoaXM6OgoKKC4uLikKCj4gK1RoZSBkZXZpY2UgaWQgYGBWSVJUSU9fSURfRFVN
TVlgYCBoZXJlIGlzIGEgcGxhY2Vob2xkZXIsIHZpcnRpbwo+ICtkcml2ZXJzIHNob3VsZCBiZSBk
ZWZpbmVkIG9ubHkgZm9yIGRldmljZXMgdGhhdCBhcmUgZGVmaW5lZCBpbiB0aGUKCnMvZGVmaW5l
ZC9hZGRlZC8gPwoKPiArc3BlYy4gU2VlIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9faWRzLmgu
CgpNYXliZSAiRGV2aWNlIGlkcyBuZWVkIHRvIGJlIGF0IGxlYXN0IHJlc2VydmVkIGluIHRoZSB2
aXJ0aW8gc3BlYyBiZWZvcmUKYmVpbmcgYWRkZWQgdG8gdGhhdCBmaWxlLiIgPwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
