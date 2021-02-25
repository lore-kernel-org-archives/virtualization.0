Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09CC433E0
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 13:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B3964F06
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B3964F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8947184025;
	Thu, 25 Feb 2021 13:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wM9s8sYcxjaN; Thu, 25 Feb 2021 13:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 024B58401B;
	Thu, 25 Feb 2021 13:26:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD509C000A;
	Thu, 25 Feb 2021 13:26:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE112C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 13:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 879966F608
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 13:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id htjbh6Xbzs6M
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 13:26:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E30F60718
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614259599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXUvZpa0/Gfdi/WbDQrtIYaPffDzy8NMBiJQiT8MF2I=;
 b=KvIsdO1iyg0GwYmLgzzX8/LJht8ZU6mEyir+iuBNkPLD+4hN+3p2YBJ/K0UTQkkUJW+Chd
 i2m5o/PcaLLi1UaJzzajWGnqDaNfdJY3LLA1+Cyk010y95d5NaG14xGhZiAylk7aGC3jHG
 f5F973aBnSGp6qDmmcCCH19AgNIKmWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-CzbjGrFwMg-IyRC5cRsJ2Q-1; Thu, 25 Feb 2021 08:26:36 -0500
X-MC-Unique: CzbjGrFwMg-IyRC5cRsJ2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CF9F801979;
 Thu, 25 Feb 2021 13:26:35 +0000 (UTC)
Received: from gondolin (ovpn-113-228.ams2.redhat.com [10.36.113.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D170C5C234;
 Thu, 25 Feb 2021 13:26:30 +0000 (UTC)
Date: Thu, 25 Feb 2021 14:26:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210225142628.3659af58.cohuck@redhat.com>
In-Reply-To: <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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

T24gVGh1LCAyNSBGZWIgMjAyMSAxMjozNjowNyArMDgwMApKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gMjAyMS8yLzI0IDc6MTIg5LiL5Y2ILCBDb3JuZWxpYSBI
dWNrIHdyb3RlOgo+ID4gT24gV2VkLCAyNCBGZWIgMjAyMSAxNzoyOTowNyArMDgwMAo+ID4gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAgCj4gPj4gT24gMjAyMS8y
LzIzIDY6NTgg5LiL5Y2ILCBDb3JuZWxpYSBIdWNrIHdyb3RlOiAgCj4gPj4+IE9uIFR1ZSwgMjMg
RmViIDIwMjEgMTg6MzE6MDcgKzA4MDAKPiA+Pj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+ID4+Pj4gVGhlIHByb2JsZW0gaXMgdGhlIE1UVSBkZXNjcmlwdGlvbiBm
b3IgZXhhbXBsZToKPiA+Pj4+Cj4gPj4+PiAiVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5
IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPiA+Pj4+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0
LiIKPiA+Pj4+Cj4gPj4+PiBJdCBsb29rcyB0byBtZSBuZWVkIHRvIHVzZSAiaWYgVklSVElPX05F
VF9GX01UVSBpcyBzZXQgYnkgZGV2aWNlIi4gIAo+ID4+PiAib2ZmZXJlZCBieSB0aGUgZGV2aWNl
Ij8gSSBkb24ndCB0aGluayBpdCBzaG91bGQgJ2Rpc2FwcGVhcicgZnJvbSB0aGUKPiA+Pj4gY29u
ZmlnIHNwYWNlIGlmIHRoZSBkcml2ZXIgd29uJ3QgdXNlIGl0LiAoU2FtZSBmb3Igb3RoZXIgY29u
ZmlnIHNwYWNlCj4gPj4+IGZpZWxkcyB0aGF0IGFyZSB0aWVkIHRvIGZlYXR1cmUgYml0cy4pICAK
PiA+Pgo+ID4+IEJ1dCB3aGF0IGhhcHBlbnMgaWYgZS5nIGRldmljZSBkb2Vzbid0IG9mZmVyIFZJ
UlRJT19ORVRfRl9NVFU/IEl0IGxvb2tzCj4gPj4gdG8gYWNjb3JkaW5nIHRvIHRoZSBzcGVjIHRo
ZXJlIHdpbGwgYmUgbm8gbXR1IGZpZWxkLiAgCj4gPiBJIHRoaW5rIHNvLCB5ZXMuCj4gPiAgCj4g
Pj4gQW5kIGEgbW9yZSBpbnRlcmVzdGluZyBjYXNlIGlzIFZJUlRJT19ORVRfRl9NUSBpcyBub3Qg
b2ZmZXJlZCBidXQKPiA+PiBWSVJUSU9fTkVUX0ZfTVRVIG9mZmVyZWQuIFRvIG1lLCBpdCBtZWFu
cyB3ZSBkb24ndCBoYXZlCj4gPj4gbWF4X3ZpcnRxdWV1ZV9wYWlycyBidXQgaXQncyBub3QgaG93
IHRoZSBkcml2ZXIgaXMgd3JvdGUgdG9kYXkuICAKPiA+IFRoYXQgd291bGQgYmUgYSBidWcsIGJ1
dCBpdCBzZWVtcyB0byBtZSB0aGF0IHRoZSB2aXJ0aW8tbmV0IGRyaXZlcgo+ID4gcmVhZHMgbWF4
X3ZpcnRxdWV1ZV9wYWlycyBjb25kaXRpb25hbGx5IGFuZCBoYW5kbGVzIGFic2VuY2Ugb2YgdGhl
Cj4gPiBmZWF0dXJlIGNvcnJlY3RseT8gIAo+IAo+IAo+IFllcywgc2VlIHRoZSBhdm92ZSBjb2Rl
czoKPiAKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fTkVUX0ZfTVRVKSkgewo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IG10
dSA9IHZpcnRpb19jcmVhZDE2KHZkZXYsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNl
dG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbXR1KSk7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAobXR1IDwgTUlOX01UVSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9GX01UVSk7
Cj4gIMKgwqDCoMKgwqDCoMKgIH0KPiAKCk91Y2gsIHlvdSdyZSByaWdodC4gVGhlIHZpcnRpb19j
cmVhZCBhY2Nlc3NvcnMgYWxsIG9wZXJhdGUgb24gb2Zmc2V0cwppbnRvIGEgc3RydWN0dXJlLCBp
dCdzIGp1c3QgbW9yZSBvYnZpb3VzIGhlcmUuCgo+IFNvIGl0J3MgcHJvYmFibHkgdG9vIGxhdGUg
dG8gZml4IHRoZSBkcml2ZXIuCgpJdCBpcyBuZXZlciB0b28gbGF0ZSB0byBmaXggYSBkcml2ZXIg
OikKCkl0IHNlZW1zIGludm9sdmVkLCB0aG91Z2guIFdlJ2QgbmVlZCBkaWZmZXJlbnQgY29uZmln
IHNwYWNlIHN0cnVjdHVyZXMKYmFzZWQgdXBvbiB3aGljaCBzZXQgb2YgZmVhdHVyZXMgaGFzIGJl
ZW4gbmVnb3RpYXRlZC4gSXQncyBub3QgdG9vIGJhZAp3aGVuIGZlYXR1cmVzIGJ1aWxkIHVwb24g
ZWFjaCBvdGhlciBhbmQgYWRkIGZpZWxkcyBhdCB0aGUgZW5kICh0aGlzCnNob3VsZCBiZSBmaW5l
IHJpZ2h0IG5vdywgaWYgdGhlIGNvZGUgcmVtZW1iZXJlZCB0byBjaGVjayBmb3IgdGhlCmZlYXR1
cmUpLCBidXQgY2FuIGJlY29tZSB1Z2x5IGlmIGFuIGluLWJldHdlZW4gZmllbGQgZGVwZW5kcyB1
cG9uIGEKZmVhdHVyZS4KCkkgZ3Vlc3Mgd2UndmUgYmVlbiBsdWNreSB0aGF0IGl0IHNlZW1zIHRv
IGJlIGFuIGV4dHJlbWVseSB1bmNvbW1vbgpjb25maWd1cmF0aW9uLgoKPiAKPiAKPiA+ICAKPiA+
PiAgCj4gPj4+ICAgICAgICAKPiA+Pj4+IE90aGVyd2lzZSByZWFkZXJzIChhdCBsZWFzdCBmb3Ig
bWUpLCBtYXkgdGhpbmsgdGhlIE1UVSBpcyBvbmx5IHZhbGlkCj4gPj4+PiBpZiBkcml2ZXIgc2V0
IHRoZSBiaXQuICAKPiA+Pj4gSSB0aGluayBpdCB3b3VsZCBzdGlsbCBiZSAndmFsaWQnIGluIHRo
ZSBzZW5zZSB0aGF0IGl0IGV4aXN0cyBhbmQgaGFzCj4gPj4+IHNvbWUgdmFsdWUgaW4gdGhlcmUg
ZmlsbGVkIGluIGJ5IHRoZSBkZXZpY2UsIGJ1dCBhIGRyaXZlciByZWFkaW5nIGl0Cj4gPj4+IHdp
dGhvdXQgbmVnb3RpYXRpbmcgdGhlIGZlYXR1cmUgd291bGQgYmUgYnVnZ3kuIChMaWtlIGluIHRo
ZSBrZXJuZWwKPiA+Pj4gY29kZSBhYm92ZTsgdGhlIGtlcm5lbCBub3QgbGlraW5nIHRoZSB2YWx1
ZSBkb2VzIG5vdCBtYWtlIHRoZSBmaWVsZAo+ID4+PiBpbnZhbGlkLikgIAo+ID4+Cj4gPj4gU2Vl
IE1pY2hhZWwncyByZXBseSwgdGhlIHNwZWMgYWxsb3dzIHJlYWQgdGhlIGNvbmZpZyBiZWZvcmUg
c2V0dGluZwo+ID4+IGZlYXR1cmVzLiAgCj4gPiBZZXMsIHRoZSBwZXJpb2QgcHJpb3IgdG8gZmlu
aXNoaW5nIG5lZ290aWF0aW9uIGlzIG9idmlvdXNseSBzcGVjaWFsLgo+ID4gIAo+ID4+ICAKPiA+
Pj4gTWF5YmUgYSBzdGF0ZW1lbnQgY292ZXJpbmcgZXZlcnl0aGluZyB3b3VsZCBiZToKPiA+Pj4K
PiA+Pj4gIlRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCBtdHUgb25seSBleGlz
dHMgaWYgdGhlIGRldmljZQo+ID4+PiBvZmZlcnMgVklSVElPX05FVF9GX01UVSBhbmQgbWF5IGJl
IHJlYWQgYnkgdGhlIGRyaXZlciBkdXJpbmcgZmVhdHVyZQo+ID4+PiBuZWdvdGlhdGlvbiBhbmQg
YWZ0ZXIgVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBzdWNjZXNzZnVsbHkKPiA+Pj4gbmVnb3Rp
YXRlZC4iCj4gPj4+ICAgICAKPiA+Pj4+ICAgICAKPiA+Pj4+PiBTaG91bGQgd2UgYWRkIGEgd29y
ZGluZyBjbGFyaWZpY2F0aW9uIHRvIHRoZSBzcGVjPyAgCj4gPj4+PiBJIHRoaW5rIHNvLiAgCj4g
Pj4+IFNvbWUgY2xhcmlmaWNhdGlvbiB3b3VsZCBiZSBuZWVkZWQgZm9yIGVhY2ggZmllbGQgdGhh
dCBkZXBlbmRzIG9uIGEKPiA+Pj4gZmVhdHVyZTsgdGhhdCB3b3VsZCBiZSBxdWl0ZSB2ZXJib3Nl
LiBNYXliZSB3ZSBjYW4gZ2V0IGF3YXkgd2l0aCBhCj4gPj4+IGNsYXJpZnlpbmcgc3RhdGVtZW50
Pwo+ID4+Pgo+ID4+PiAiU29tZSBjb25maWcgc3BhY2UgZmllbGRzIG1heSBkZXBlbmQgb24gYSBj
ZXJ0YWluIGZlYXR1cmUuIEluIHRoYXQKPiA+Pj4gY2FzZSwgdGhlIGZpZWxkIGV4aXRzIGlmIHRo
ZSBkZXZpY2UgaGFzIG9mZmVyZWQgdGhlIGNvcnJlc3BvbmRpbmcKPiA+Pj4gZmVhdHVyZSwgIAo+
ID4+Cj4gPj4gU28gdGhpcyBpbXBsaWVzIGZvciAhVklSVElPX05FVF9GX01RICYmIFZJUlRJT19O
RVRfRl9NVFUsIHRoZSBjb25maWcKPiA+PiB3aWxsIGxvb2sgbGlrZToKPiA+Pgo+ID4+IHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZyB7Cj4gPj4gICDCoMKgwqDCoMKgwqDCoCB1OCBtYWNbNl07Cj4g
Pj4gICDCoMKgwqDCoMKgwqDCoCBsZTE2IHN0YXR1czsKPiA+PiAgIMKgwqDCoMKgwqDCoMKgIGxl
MTYgbXR1Owo+ID4+IH07Cj4gPj4gIAo+ID4gSSBhZ3JlZS4gIAo+IAo+IAo+IFNvIGNvbnNpZGVy
IGl0J3MgcHJvYmFibHkgdG9vIGxhdGUgdG8gZml4IHRoZSBkcml2ZXIgd2hpY2ggYXNzdW1lcyBz
b21lIAo+IGZpZWxkIGFyZSBhbHdheXMgcGVyc2VudCwgaXQgbG9va3MgdG8gbWUgbmVlZCBmaXgg
dGhlIHNwZWMgZG8gZGVjbGFyZSAKPiB0aGUgZmllbGRzIGFyZSBhbHdheXMgZXhpc3RpbmcgaW5z
dGVhZC4KClRoZSBwcm9ibGVtIHdpdGggdGhhdCBpcyB0aGF0IGl0IGhhcyBiZWVuIGluIHRoZSBz
cGVjIGFscmVhZHksIGFuZCBhCmNvbXBsaWFudCBkZXZpY2UgdGhhdCBkaWQgbm90IHByb3ZpZGUg
dGhlIGZpZWxkcyB3aXRob3V0IHRoZSBmZWF0dXJlcwp3b3VsZCBzdWRkZW5seSBiZWNvbWUgbm9u
LWNvbXBsaWFudC4uLgoKPiAKPiAKPiA+ICAKPiA+Pj4gICAgYW5kIG1heSBiZSByZWFkIGJ5IHRo
ZSBkcml2ZXIgZHVyaW5nIGZlYXR1cmUgbmVnb3RpYXRpb24sIGFuZAo+ID4+PiBhY2Nlc3NlZCBi
eSB0aGUgZHJpdmVyIGFmdGVyIHRoZSBmZWF0dXJlIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseQo+ID4+
PiBuZWdvdGlhdGVkLiBBIHNob3J0aGFuZCBmb3IgdGhpcyBpcyBhIHN0YXRlbWVudCB0aGF0IGEg
ZmllbGQgb25seQo+ID4+PiBleGlzdHMgaWYgYSBjZXJ0YWluIGZlYXR1cmUgYml0IGlzIHNldC4i
ICAKPiA+Pgo+ID4+IEknbSBub3Qgc3VyZSB1c2luZyAic2hvcnRoYW5kIiBpcyBnb29kIGZvciB0
aGUgc3BlYywgYXQgbGVhc3Qgd2UgY2FuCj4gPj4gbGltaXQgdGhlIGl0cyBzY29wZSBvbmx5IHRv
IHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIHBhcnQuICAKPiA+IE1heWJlICJhIHNob3J0aGFuZCBl
eHByZXNzaW9uIj8gIAo+IAo+IAo+IFNvIHRoZSBxdWVzdGlvbnMgaXMgc2hvdWxkIHdlIHVzZSB0
aGlzIGZvciBhbGwgb3ZlciB0aGUgc3BlYyBvciBpdCB3aWxsIAo+IGJlIG9ubHkgdXNlZCBpbiB0
aGlzIHNwZWljaWZjIHBhcnQgKGRldmljZSBjb25maWd1cmF0aW9uKS4KCkZvciBjb21tYW5kIHN0
cnVjdHVyZXMgYW5kIHRoZSBsaWtlLCAiZmVhdHVyZSBpcyBzZXQiIHNob3VsZCBhbHdheXMKbWVh
biAiZmVhdHVyZSBoYXMgYmVlbiBuZWdvdGlhdGVkIjsgSSB0aGluayBjb25maWcgc3BhY2UgaXMg
c3BlY2lhbApiZWNhdXNlIHRoZSBkcml2ZXIgY2FuIHJlYWQgaXQgYmVmb3JlIGZlYXR1cmUgbmVn
b3RpYXRpb24gaXMgZmluaXNoZWQsCnNvIGRldmljZSBjb25maWd1cmF0aW9uIGlzIHByb2JhYmx5
IHRoZSBwcm9wZXIgcGxhY2UgZm9yIGl0LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
