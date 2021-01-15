Return-Path: <SRS0=tWAs=GS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B37CC433E0
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 05:39:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1766D239EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 05:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1766D239EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B065C86A4D;
	Fri, 15 Jan 2021 05:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GK0qNos2EmZX; Fri, 15 Jan 2021 05:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4488D869A3;
	Fri, 15 Jan 2021 05:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 294F6C088B;
	Fri, 15 Jan 2021 05:38:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BFB8C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 05:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 36F6586A37
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 05:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PkFpOLpB2c42
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 05:38:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C746786A1A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 05:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610689131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xm+u8FPGbJ3hwDDdc/PpE8k86jKpY39ODWHrF9Rtkm4=;
 b=Z+59mucsZUy9tP9ywk2bRvFsGAkIA4KU8FXUJbV7gX/lgq04j5Mm2StT81/6duJUBklKRQ
 nHe7M3nshwW/rTcXoUkNCIofcPveGh0vcxSgBMYXdJLULzO3QEC/KEcAVwZi1aBzhWdP2L
 9rkGz5dA9dcGty1oHydn6udD7HxHfgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-Ch0gzu0FOuW4-niBFcx5AQ-1; Fri, 15 Jan 2021 00:38:49 -0500
X-MC-Unique: Ch0gzu0FOuW4-niBFcx5AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 228151005D4C;
 Fri, 15 Jan 2021 05:38:48 +0000 (UTC)
Received: from [10.72.13.19] (ovpn-13-19.pek2.redhat.com [10.72.13.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF96C1349A;
 Fri, 15 Jan 2021 05:38:42 +0000 (UTC)
Subject: Re: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <66dc44ac-52da-eaba-3f5e-69254e42d75b@redhat.com>
 <BY5PR12MB43225D83EA46004E3AF50D3ADCA80@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <01213588-d4af-820a-bcf8-c28b8a80c346@redhat.com>
Date: Fri, 15 Jan 2021 13:38:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB43225D83EA46004E3AF50D3ADCA80@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Ck9uIDIwMjEvMS8xNCDkuIvljYgzOjU4LCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4KPj4gRnJvbTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gU2VudDogVGh1cnNkYXksIEphbnVh
cnkgMTQsIDIwMjEgOTo0OCBBTQo+Pgo+PiBPbiAyMDIxLzEvNyDkuIrljYgxMTo0OCwgUGFyYXYg
UGFuZGl0IHdyb3RlOgo+Pj4+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+Cj4+Pj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA1LCAyMDIxIDY6NTMgUE0KPj4+Pgo+Pj4+
IE9uIFR1ZSwgSmFuIDA1LCAyMDIxIGF0IDEyOjMwOjE1UE0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3
cm90ZToKPj4+Pj4+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4+
Pj4+PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDUsIDIwMjEgNTo0NSBQTQo+Pj4+Pj4KPj4+Pj4+
IE9uIFR1ZSwgSmFuIDA1LCAyMDIxIGF0IDEyOjAyOjMzUE0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3
cm90ZToKPj4+Pj4+Pj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
Pj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA1LCAyMDIxIDU6MTkgUE0KPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMTI6MzI6MDNQTSArMDIwMCwgUGFyYXYg
UGFuZGl0IHdyb3RlOgo+Pj4+Pj4+Pj4gRW5hYmxlIHVzZXIgdG8gY3JlYXRlIHZkcGFzaW0gbmV0
IHNpbXVsYXRlIGRldmljZXMuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICQgdmRwYSBk
ZXYgYWRkIG1nbXRkZXYgdmRwYXNpbV9uZXQgbmFtZSBmb28yCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4g
U2hvdyB0aGUgbmV3bHkgY3JlYXRlZCB2ZHBhIGRldmljZSBieSBpdHMgbmFtZToKPj4+Pj4+Pj4+
ICQgdmRwYSBkZXYgc2hvdyBmb28yCj4+Pj4+Pj4+PiBmb28yOiB0eXBlIG5ldHdvcmsgbWdtdGRl
diB2ZHBhc2ltX25ldCB2ZW5kb3JfaWQgMCBtYXhfdnFzIDIKPj4+Pj4+Pj4+IG1heF92cV9zaXpl
IDI1Ngo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICQgdmRwYSBkZXYgc2hvdyBmb28yIC1qcAo+Pj4+Pj4+
Pj4gewo+Pj4+Pj4+Pj4gICAgICAgImRldiI6IHsKPj4+Pj4+Pj4+ICAgICAgICAgICAiZm9vMiI6
IHsKPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgInR5cGUiOiAibmV0d29yayIsCj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgICJtZ210ZGV2IjogInZkcGFzaW1fbmV0IiwKPj4+Pj4+Pj4+ICAgICAgICAg
ICAgICAgInZlbmRvcl9pZCI6IDAsCj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICJtYXhfdnFzIjog
MiwKPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgIm1heF92cV9zaXplIjogMjU2Cj4+Pj4+Pj4+PiAg
ICAgICAgICAgfQo+Pj4+Pj4+Pj4gICAgICAgfQo+Pj4+Pj4+Pj4gfQo+Pj4+Pj4+PiBJJ2QgbGlr
ZSBhbiBleGFtcGxlIG9mIGhvdyBkbyBkZXZpY2Ugc3BlY2lmaWMgKGUuZy4gbmV0Cj4+Pj4+Pj4+
IHNwZWNpZmljKSBpbnRlcmZhY2VzIHRpZSBpbiB0byB0aGlzLgo+Pj4+Pj4+IE5vdCBzdXJlIEkg
Zm9sbG93IHlvdXIgcXVlc3Rpb24uCj4+Pj4+Pj4gRG8geW91IG1lYW4gaG93IHRvIHNldCBtYWMg
YWRkcmVzcyBvciBtdHUgb2YgdGhpcyB2ZHBhIGRldmljZSBvZgo+Pj4+Pj4+IHR5cGUKPj4+Pj4+
IG5ldD8KPj4+Pj4+PiBJZiBzbywgZGV2IGFkZCBjb21tYW5kIHdpbGwgYmUgZXh0ZW5kZWQgc2hv
cnRseSBpbiBzdWJzZXF1ZW50Cj4+Pj4+Pj4gc2VyaWVzIHRvCj4+Pj4+PiBzZXQgdGhpcyBuZXQg
c3BlY2lmaWMgYXR0cmlidXRlcy4KPj4+Pj4+PiAoSSBkaWQgbWVudGlvbiBpbiB0aGUgbmV4dCBz
dGVwcyBpbiBjb3ZlciBsZXR0ZXIpLgo+Pj4+Pj4+Cj4+Pj4+Pj4+PiArc3RhdGljIGludCBfX2lu
aXQgdmRwYXNpbV9uZXRfaW5pdCh2b2lkKSB7Cj4+Pj4+Pj4+PiArCWludCByZXQ7Cj4+Pj4+Pj4+
PiArCj4+Pj4+Pj4+PiArCWlmIChtYWNhZGRyKSB7Cj4+Pj4+Pj4+PiArCQltYWNfcHRvbihtYWNh
ZGRyLCBtYWNhZGRyX2J1Zik7Cj4+Pj4+Pj4+PiArCQlpZiAoIWlzX3ZhbGlkX2V0aGVyX2FkZHIo
bWFjYWRkcl9idWYpKQo+Pj4+Pj4+Pj4gKwkJCXJldHVybiAtRUFERFJOT1RBVkFJTDsKPj4+Pj4+
Pj4+ICsJfSBlbHNlIHsKPj4+Pj4+Pj4+ICsJCWV0aF9yYW5kb21fYWRkcihtYWNhZGRyX2J1Zik7
Cj4+Pj4+Pj4+PiAgICAJfQo+Pj4+Pj4+PiBIbW0gc28gYWxsIGRldmljZXMgc3RhcnQgb3V0IHdp
dGggdGhlIHNhbWUgTUFDIHVudGlsIGNoYW5nZWQ/Cj4+Pj4+Pj4+IEFuZCBob3cgaXMgdGhlIGNo
YW5nZSBlZmZlY3RlZD8KPj4+Pj4+PiBQb3N0IHRoaXMgcGF0Y2hzZXQgYW5kIHBvc3Qgd2UgaGF2
ZSBpcHJvdXRlMiB2ZHBhIGluIHRoZSB0cmVlLAo+Pj4+Pj4+IHdpbGwgYWRkIHRoZQo+Pj4+Pj4g
bWFjIGFkZHJlc3MgYXMgdGhlIGlucHV0IGF0dHJpYnV0ZSBkdXJpbmcgInZkcGEgZGV2IGFkZCIg
Y29tbWFuZC4KPj4+Pj4+PiBTbyB0aGF0IGVhY2ggZGlmZmVyZW50IHZkcGEgZGV2aWNlIGNhbiBo
YXZlIHVzZXIgc3BlY2lmaWVkCj4+Pj4+Pj4gKGRpZmZlcmVudCkgbWFjCj4+Pj4+PiBhZGRyZXNz
Lgo+Pj4+Pj4KPj4+Pj4+IEZvciBub3cgbWF5YmUganVzdCBhdm9pZCBWSVJUSU9fTkVUX0ZfTUFD
IHRoZW4gZm9yIG5ldyBkZXZpY2VzCj4+Pj4gdGhlbj8KPj4+Pj4gVGhhdCB3b3VsZCByZXF1aXJl
IGJvb2sga2VlcGluZyBleGlzdGluZyBuZXQgdmRwYV9zaW0gZGV2aWNlcwo+Pj4+PiBjcmVhdGVk
IHRvCj4+Pj4gYXZvaWQgc2V0dGluZyBWSVJUSU9fTkVUX0ZfTUFDLgo+Pj4+PiBTdWNoIGJvb2sg
a2VlcGluZyBjb2RlIHdpbGwgYmUgc2hvcnQgbGl2ZWQgYW55d2F5Lgo+Pj4+PiBOb3Qgc3VyZSBp
ZiBpdHMgd29ydGggaXQuCj4+Pj4+IFVudGlsIG5vdyBvbmx5IG9uZSBkZXZpY2Ugd2FzIGNyZWF0
ZWQuIFNvIG5vdCBzdXJlIHR3byB2ZHBhIGRldmljZXMKPj4+Pj4gd2l0aAo+Pj4+IHNhbWUgbWFj
IGFkZHJlc3Mgd2lsbCBiZSBhIHJlYWwgaXNzdWUuCj4+Pj4+IFdoZW4gd2UgYWRkIG1hYyBhZGRy
ZXNzIGF0dHJpYnV0ZSBpbiBhZGQgY29tbWFuZCwgYXQgdGhhdCBwb2ludCBhbHNvCj4+Pj4gcmVt
b3ZlIHRoZSBtb2R1bGUgcGFyYW1ldGVyIG1hY2FkZHIuCj4+Pj4KPj4+PiBXaWxsIHRoYXQgYmUg
bWFuZGF0b3J5PyBJJ20gbm90IHRvIGhhcHB5IHdpdGggYSBVQVBJIHdlIGludGVuZCB0bwo+Pj4+
IGJyZWFrIHN0cmFpZ2h0IGF3YXkgLi4uCj4+PiBOby4gU3BlY2lmeWluZyBtYWMgYWRkcmVzcyBz
aG91bGRuJ3QgYmUgbWFuZGF0b3J5LiBVQVBJIHdvbnQnIGJlCj4+IGJyb2tlbi4KPj4KPj4KPj4g
SWYgaXQncyBub3QgbWFuZGF0b3J5LiBEb2VzIGl0IG1lYW4gdGhlIHZEUEEgcGFyZW50IG5lZWQg
dG8gdXNlIGl0cyBvd24gbG9naWMKPj4gdG8gZ2VuZXJhdGUgYSB2YWxpZGF0ZSBtYWM/IEknbSBu
b3Qgc3VyZSB0aGlzIGlzIHdoYXQgbWFuYWdlbWVudCAobGlidmlydAo+PiB3YW50KS4KPj4KPiBU
aGVyZSBhcmUgZmV3IHVzZSBjYXNlcyB0aGF0IEkgc2VlIHdpdGggUEZzLCBWRnMgYW5kIFNGcyBz
dXBwb3J0aW5nIHZkcGEgZGV2aWNlcy4KPgo+IDEuIFVzZXIgd2FudHMgdG8gdXNlIHRoZSBWRiBv
bmx5IGZvciB2ZHBhIHB1cnBvc2UuIEhlcmUgdXNlciBnb3QgdGhlIFZGIHdoaWNoIHdhcyBwcmUt
c2V0dXAgYnkgdGhlIHN5c2FkbWluLgo+IEluIHRoaXMgY2FzZSB3aGF0ZXZlciBNQUMgYXNzaWdu
ZWQgdG8gdGhlIFZGIGNhbiBiZSB1c2VkIGJ5IGl0cyB2ZHBhIGRldmljZS4KPiBIZXJlLCB1c2Vy
IGRvZXNuJ3QgbmVlZCB0byBwYXNzIHRoZSBtYWMgYWRkcmVzcyBkdXJpbmcgdmRwYSBkZXZpY2Ug
Y3JlYXRpb24gdGltZS4KPiBUaGlzIGlzIGRvbmUgYXMgdGhlIHNhbWUgTUFDIGhhcyBiZWVuIHNl
dHVwIGluIHRoZSBBQ0wgcnVsZXMgb24gdGhlIHN3aXRjaCBzaWRlLgo+IE5vbiBWRFBBIHVzZXJz
IG9mIGEgVkYgdHlwaWNhbGx5IHVzZSB0aGUgVkYgdGhpcyB3YXkgZm9yIE5ldGRldiBhbmQgcmRt
YSBmdW5jdGlvbmFsaXR5Lgo+IFRoZXkgbWlnaHQgY29udGludWUgc2FtZSB3YXkgZm9yIHZkcGEg
YXBwbGljYXRpb24gYXMgd2VsbC4KPiBIZXJlIFZGIG1hYyBpcyBlaXRoZXIgc2V0IHVzaW5nCj4g
KGEpIGRldmxpbmsgcG9ydCBmdW5jdGlvbiBzZXQgaHdfYWRkciBjb21tYW5kIG9yIHVzaW5nCj4g
KGIpIGlwIGxpbmsgc2V0IHZmIG1hYwo+IFNvIHZkcGEgdG9vbCBkaWRuJ3QgcGFzcyB0aGUgbWFj
LiAob3B0aW9uYWwpLgo+IFRob3VnaCBWSVJUSU9fTkVUX0ZfTUFDIGlzIHN0aWxsIHZhbGlkLgo+
Cj4gMi4gVXNlciBtYXkgd2FudCB0byBjcmVhdGUgb25lIG9yIG1vcmUgdmRwYSBkZXZpY2Ugb3V0
IG9mIHRoZSBtZ210LiBkZXZpY2UuCj4gSGVyZSB1c2VyIHdhbnRzIHRvIG1vcmUvZnVsbCBjb250
cm9sIG9mIGFsbCBmZWF0dXJlcywgb3ZlcnJpZGluZyB3aGF0IHN5c2FkbWluIGhhcyBzZXR1cCBh
cyBNQUMgb2YgdGhlIFZGL1NGLgo+IEluIHRoaXMgY2FzZSB1c2VyIHdpbGwgc3BlY2lmeSB0aGUg
TUFDIHZpYSBtZ210IHRvb2wuCj4gKGEpIFRoaXMgaXMgYWxzbyB1c2VkIGJ5IHRob3NlIHZkcGEg
ZGV2aWNlcyB3aGljaCBkb2Vzbid0IGhhdmUgZXN3aXRjaCBvZmZsb2Fkcy4KPiAoYikgVGhpcyB3
aWxsIHdvcmsgd2l0aCBlc3dpdGNoIG9mZmxvYWRzIGFzIHdlbGwgd2hvIGRvZXMgc291cmNlIGxl
YXJuaW5nLgo+IChjKSBVc2VyIGNob3NlIHRvIHVzZSB0aGUgdmRwYSBkZXZpY2Ugb2YgYSBWRiB3
aGlsZSBWRiBOZXRkZXYgYW5kIHJkbWEgZGV2aWNlIGFyZSB1c2VkIGJ5IGh5cGVydmlzb3IgZm9y
IHNvbWV0aGluZyBlbHNlIGFzIHdlbGwuCj4gVklSVElPX05FVF9GX01BQyByZW1haW5zIHZhbGlk
IGluIGFsbCAyLnthLGIsY30uCj4KPiAzLiBBICB2ZW5kb3IgbWdtdC4gZGV2aWNlIGFsd2F5cyBl
eHBlY3RzIGl0IHVzZXIgdG8gcHJvdmlkZSBtYWMgZm9yIGl0cyB2ZHBhIGRldmljZXMuCj4gU28g
d2hlbiBpdCBpcyBub3QgcHJvdmlkZWQsIGl0IGNhbiBmYWlsIHdpdGggZXJyb3IgbWVzc2FnZSBz
dHJpbmcgaW4gZXh0YWNrIG9yIGNsZWFyIHRoZSBWSVJUSU9fTkVUX0ZfTUFDIGFuZCBsZXQgaXQg
d29yayB1c2luZyB2aXJ0aW8gc3BlYydzIDUuMS41IHBvaW50IDUgdG8gcHJvY2VlZC4KPgo+IEFz
IGNvbW1vbiBkZW5vbWluYXRvciBvZiBhbGwgYWJvdmUgY2FzZXMsIGlmIFFFTVUgb3IgdXNlciBw
YXNzIHRoZSBNQUMgZHVyaW5nIGNyZWF0aW9uLCBpdCB3aWxsIGFsbW9zdCBhbHdheXMgd29yay4K
PiBBZHZhbmNlIHVzZXIgYW5kIFFFTVUgd2l0aCBzd2l0Y2hkZXYgbW9kZSBzdXBwb3J0IHdobyBo
YXMgZG9uZSAxLmEvMS5iLCB3aWxsIG9taXQgaXQuCj4gSSBkbyBub3Qga25vdyBob3cgZGVlcCBp
bnRlZ3JhdGlvbiBvZiBRRU1VIGV4aXN0IHdpdGggdGhlIHN3aXRjaGRldiBtb2RlIHN1cHBvcnQu
Cj4KPiBXaXRoIHRoYXQgbWFjLCBtdHUgYXMgb3B0aW9uYWwgaW5wdXQgZmllbGRzIHByb3ZpZGUg
dGhlIG5lY2Vzc2FyeSBmbGV4aWJpbGl0eSBmb3IgZGlmZmVyZW50IHN0YWNrcyB0byB0YWtlIGFw
cHJvcHJpYXRlIHNoYXBlIGFzIHRoZXkgZGVzaXJlLgoKClRoYW5rcyBmb3IgdGhlIGNsYXJpZmlj
YXRpb24uIEkgdGhpbmsgd2UnZCBiZXR0ZXIgZG9jdW1lbnQgdGhlIGFib3ZlIGluIAp0aGUgcGF0
Y2ggdGhhdCBpbnRyb2R1Y2VzIHRoZSBtYWMgc2V0dGluZyBmcm9tIG1hbmFnZW1lbnQgQVBJLgoK
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
