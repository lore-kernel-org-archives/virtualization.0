Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D7C433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 08:36:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06892065D
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 08:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06892065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 539C8867D9;
	Tue,  5 Jan 2021 08:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iR2JNOtuG03N; Tue,  5 Jan 2021 08:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 72946867D2;
	Tue,  5 Jan 2021 08:36:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F38EC088B;
	Tue,  5 Jan 2021 08:36:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C87AEC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 08:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AB05A867D5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 08:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDSy13JYDG5s
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 08:36:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9611C867D2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609835790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pl2VjgHgWM+ZojCAv4JjpepIhqYoZRtiH5P0VsatjuQ=;
 b=DUsNWzRFvZ628QDt4Q3/FLRa/6uzp2+dMpSVHadx/QToLARK3kde9iPlXOoUcT85bVoih8
 5OitF/0SGupRFjE4nEdL5sHaX3FcKOQkvBnu7l8i06IV4CrXj4sZftjw51dtCGiBmQhawN
 vfQBvdWiEZSAnWoWJuxrzvSlvG1vrVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-_5rRbaXXMsS_rSZnqxIeug-1; Tue, 05 Jan 2021 03:36:28 -0500
X-MC-Unique: _5rRbaXXMsS_rSZnqxIeug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A85E800D53;
 Tue,  5 Jan 2021 08:36:27 +0000 (UTC)
Received: from [10.72.13.192] (ovpn-13-192.pek2.redhat.com [10.72.13.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C59F460BE5;
 Tue,  5 Jan 2021 08:36:20 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 4/7] vdpa: Define vdpa mgmt device, ops and
 a netlink interface
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
 <20210104033141.105876-5-parav@nvidia.com>
 <b08ede5d-e393-b4f8-d1d8-2aa29e409872@redhat.com>
 <BY5PR12MB432236DE09EBC2E584C07FCDDCD20@BY5PR12MB4322.namprd12.prod.outlook.com>
 <b7a4602d-daae-dde1-a064-2ee07cf84309@redhat.com>
 <BY5PR12MB4322EB5AD78BBAB2311AD877DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <449d2860-c75f-04fa-9080-c99dc6df7288@redhat.com>
Date: Tue, 5 Jan 2021 16:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322EB5AD78BBAB2311AD877DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS81IOS4i+WNiDI6MzMsIFBhcmF2IFBhbmRpdCB3cm90ZToKPgo+PiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDUsIDIwMjEgOTo0MCBBTQo+Pgo+PiBPbiAyMDIxLzEvNCDkuIvljYgzOjI0LCBQYXJhdiBQYW5k
aXQgd3JvdGU6Cj4+Pj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+
PiBTZW50OiBNb25kYXksIEphbnVhcnkgNCwgMjAyMSAxMjozMyBQTQo+Pj4+Cj4+Pj4gT24gMjAy
MS8xLzQg5LiK5Y2IMTE6MzEsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4gVG8gYWRkIG9uZSBv
ciBtb3JlIFZEUEEgZGV2aWNlcywgZGVmaW5lIGEgbWFuYWdlbWVudCBkZXZpY2Ugd2hpY2gKPj4+
Pj4gYWxsb3dzIGFkZGluZyBvciByZW1vdmluZyB2ZHBhIGRldmljZS4gQSBtYW5hZ2VtZW50IGRl
dmljZSBkZWZpbmVzCj4+Pj4+IHNldCBvZiBjYWxsYmFja3MgdG8gbWFuYWdlIHZkcGEgZGV2aWNl
cy4KPj4+Pj4KPj4+Pj4gVG8gYmVnaW4gd2l0aCwgaXQgZGVmaW5lcyBhZGQgYW5kIHJlbW92ZSBj
YWxsYmFja3MgdGhyb3VnaCB3aGljaCBhCj4+Pj4+IHVzZXIgZGVmaW5lZCB2ZHBhIGRldmljZSBj
YW4gYmUgYWRkZWQgb3IgcmVtb3ZlZC4KPj4+Pj4KPj4+Pj4gQSB1bmlxdWUgbWFuYWdlbWVudCBk
ZXZpY2UgaXMgaWRlbnRpZmllZCBieSBpdHMgdW5pcXVlIGhhbmRsZQo+Pj4+PiBpZGVudGlmaWVk
IGJ5IG1hbmFnZW1lbnQgZGV2aWNlIG5hbWUgYW5kIG9wdGlvbmFsbHkgdGhlIGJ1cyBuYW1lLgo+
Pj4+Pgo+Pj4+PiBIZW5jZSwgaW50cm9kdWNlIHJvdXRpbmUgdGhyb3VnaCB3aGljaCBkcml2ZXIg
Y2FuIHJlZ2lzdGVyIGEKPj4+Pj4gbWFuYWdlbWVudCBkZXZpY2UgYW5kIGl0cyBjYWxsYmFjayBv
cGVyYXRpb25zIGZvciBhZGRpbmcgYW5kIHJlbW92ZQo+Pj4+PiBhIHZkcGEgZGV2aWNlLgo+Pj4+
Pgo+Pj4+PiBJbnRyb2R1Y2UgdmRwYSBuZXRsaW5rIHNvY2tldCBmYW1pbHkgc28gdGhhdCB1c2Vy
IGNhbiBxdWVyeQo+Pj4+PiBtYW5hZ2VtZW50IGRldmljZSBhbmQgaXRzIGF0dHJpYnV0ZXMuCj4+
Pj4+Cj4+Pj4+IEV4YW1wbGUgb2Ygc2hvdyB2ZHBhIG1hbmFnZW1lbnQgZGV2aWNlIHdoaWNoIGFs
bG93cyBjcmVhdGluZyB2ZHBhCj4+Pj4+IGRldmljZSBvZiBuZXR3b3JraW5nIGNsYXNzIChkZXZp
Y2UgaWQgPSAweDEpIG9mIHZpcnRpbyBzcGVjaWZpY2F0aW9uCj4+Pj4+IDEuMSBzZWN0aW9uIDUu
MS4xLgo+Pj4+Pgo+Pj4+PiAkIHZkcGEgbWdtdGRldiBzaG93Cj4+Pj4+IHZkcGFzaW1fbmV0Ogo+
Pj4+PiAgICAgIHN1cHBvcnRlZF9jbGFzc2VzOgo+Pj4+PiAgICAgICAgbmV0Cj4+Pj4+Cj4+Pj4+
IEV4YW1wbGUgb2Ygc2hvd2luZyB2ZHBhIG1hbmFnZW1lbnQgZGV2aWNlIGluIEpTT04gZm9ybWF0
Lgo+Pj4+Pgo+Pj4+PiAkIHZkcGEgbWdtdGRldiBzaG93IC1qcAo+Pj4+PiB7Cj4+Pj4+ICAgICAg
ICAic2hvdyI6IHsKPj4+Pj4gICAgICAgICAgICAidmRwYXNpbV9uZXQiOiB7Cj4+Pj4+ICAgICAg
ICAgICAgICAgICJzdXBwb3J0ZWRfY2xhc3NlcyI6IFsgIm5ldCIgXQo+Pj4+PiAgICAgICAgICAg
IH0KPj4+Pj4gICAgICAgIH0KPj4+Pj4gfQo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXJh
diBQYW5kaXQ8cGFyYXZAbnZpZGlhLmNvbT4KPj4+Pj4gUmV2aWV3ZWQtYnk6IEVsaSBDb2hlbjxl
bGljQG52aWRpYS5jb20+Cj4+Pj4+IFJldmlld2VkLWJ5OiBKYXNvbiBXYW5nPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiBDaGFuZ2Vsb2c6Cj4+Pj4+IHYxLT52MjoKPj4+Pj4g
ICAgIC0gcmViYXNlZAo+Pj4+PiAgICAgLSB1cGRhdGVkIGNvbW1pdCBsb2cgZXhhbXBsZSBmb3Ig
bWFuYWdlbWVudCBkZXZpY2UgbmFtZSBmcm9tCj4+Pj4+ICAgICAgICJ2ZHBhc2ltIiB0byAidmRw
YXNpbV9uZXQiCj4+Pj4+ICAgICAtIHJlbW92ZWQgZGV2aWNlX2lkIGFzIG5ldCBhbmQgYmxvY2sg
bWFuYWdlbWVudCBkZXZpY2VzIGFyZQo+Pj4+PiBzZXBhcmF0ZWQKPj4+PiBTbyBJIHdvbmRlciB3
aGV0aGVyIHRoZXJlIGNvdWxkIGJlIGEgdHlwZSBvZiBtYW5hZ2VtZW50IGRldmljZXMgdGhhdAo+
Pj4+IGNhbiBkZWFsIHdpdGggbXVsdGlwbGUgdHlwZXMgb2YgdmlydGlvIGRldmljZXMuIElmIHll
cywgd2UgcHJvYmFibHkKPj4+PiBuZWVkIHRvIGFkZCBkZXZpY2UgaWQgYmFjay4KPj4+IEF0IHRo
aXMgcG9pbnQgbWx4NSBwbGFuIHRvIHN1cHBvcnQgb25seSBuZXQuCj4+PiBJdCBpcyB1c2VmdWwg
dG8gc2VlIHdoYXQgdHlwZSBvZiB2ZHBhIGRldmljZSBpcyBzdXBwb3J0ZWQgYnkgYSBtYW5hZ2Vt
ZW50Cj4+IGRldmljZS4KPj4+IEluIGZ1dHVyZSBpZiBhIG1nbXQgZGV2IHN1cHBvcnRzIG11bHRp
cGxlIHR5cGVzLCB1c2VyIG5lZWRzIHRvIGNob29zZQo+PiBkZXNpcmVkIHR5cGUuCj4+PiBJIGd1
ZXNzIHdlIGNhbiBkaWZmZXIgdGhpcyBvcHRpb25hbCB0eXBlIHRvIGZ1dHVyZSwgd2hlbiBzdWNo
IG1nbXQuIGRldmljZQo+PiB3aWxsL21heSBiZSBhdmFpbGFibGUuCj4+Cj4+Cj4+IEkgd29ycnkg
aWYgd2UgcmVtb3ZlIGRldmljZV9pZCwgaXQgbWF5IGdpdmVzIGEgaGludCB0aGF0IG11bHRpcGxl
IG1nbXQKPj4gZGV2aWNlcyBuZWVkcyB0byBiZSByZWdpc3RlcmVkIGlmIGl0IHN1cHBvcnRzIG11
bHRpcGxlIHR5cGVzLgo+Pgo+IE5vIGl0IHNob3VsZG4ndC4gYmVjYXVzZSB3ZSBkbyBleHBvc2Ug
bXVsdGlwbGUgc3VwcG9ydGVkIHR5cGVzIGluIG1nbXRkZXYgYXR0cmlidXRlcy4KCgpSaWdodC4K
Cgo+Cj4+IFNvIGlmIHBvc3NpYmxlIEkgd291bGQgbGlrZSB0byBrZWVwIHRoZSBkZXZpY2VfaWQg
aGVyZS4KPj4KPiBJdHMgcG9zc2libGUgdG8ga2VlcCBpdC4gQnV0IHdpdGggY3VycmVudCBkcml2
ZXJzLCBtYWlubHkgbWx4NSBhbmQgdmRwYV9zaW0sIGl0IGlzIHJlZHVuZGFudC4KPiBOb3Qgc3Vy
ZSBvZiB0aGUgaWZjJ3MgcGxhbi4KPiBXZSBoYXZlIGJlZW4gc3BsaXR0aW5nIG1vZHVsZXMgdG8g
aGFuZGxlIG5ldCBhbmQgYmxvY2sgZGlmZmVyZW50bHkgaW4gbWx4NSBhcyB3ZWxsIGFzIHZkcGFf
c2ltLgo+IFNvIGl0IGxvb2tzIHRvIG1lIHRoYXQgYm90aCBtYXkgYmUgc2VwYXJhdGUgbWFuYWdl
bWVudCBkcml2ZXJzIChhbmQgbWFuYWdlbWVudCBkZXZpY2VzKS4KPiBTdWNoIGFzIHZkcGFzaW1f
bmV0IGFuZCB2ZHBhc2ltX2Jsb2NrLgo+IG1seDUgZG9lc24ndCBoYXZlIHBsYW4gZm9yIGJsb2Nr
IHlldC4KCgpPay4gVGhlbiBpdCdzIGZpbmUuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
