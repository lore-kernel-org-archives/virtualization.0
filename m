Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E17C2D0E4
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 03:38:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE5022280
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 03:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwdKSOYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5022280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C1DD98685E;
	Mon, 16 Nov 2020 03:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOHrZ6PuCLRb; Mon, 16 Nov 2020 03:38:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6B9786691;
	Mon, 16 Nov 2020 03:38:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C68ACC0800;
	Mon, 16 Nov 2020 03:38:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2A77C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 567322011A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxowjmIOwH2H
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:38:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 1330A20110
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605497885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJuVxD8MKBr57zv/aexgnLowqoN1xbyWUa+Emh3GwGE=;
 b=EwdKSOYVVF287ZQXZ8Lkw4/oHYGW/IA2+ewQPdqOo5XHEqrsG3tZnOWD0OZAjuqyaUw4FU
 KLRzsAGE5Od6RdDpY34iXcaMMOJIlEzj6RIh0IHq4SUq6voBZci9yDgzWVy9+7NDyLSv95
 gE5VIjmXIu2cnknwFYMkz8vtki7OlVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-xKPNSRrfMP-foyIS6wm_3Q-1; Sun, 15 Nov 2020 22:38:03 -0500
X-MC-Unique: xKPNSRrfMP-foyIS6wm_3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A458049D6;
 Mon, 16 Nov 2020 03:38:02 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 502A227CC5;
 Mon, 16 Nov 2020 03:37:50 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201113134712.69744-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
Date: Mon, 16 Nov 2020 11:37:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
YW5rcyB0byBNYXggdGhhdCBzdGFydGVkIHRoaXMgd29yayEKPiBJIHRvb2sgaGlzIHBhdGNoZXMs
IGFuZCBleHRlbmRlZCB0aGUgYmxvY2sgc2ltdWxhdG9yIGEgYml0Lgo+Cj4gVGhpcyBzZXJpZXMg
bW92ZXMgdGhlIG5ldHdvcmsgZGV2aWNlIHNpbXVsYXRvciBpbiBhIG5ldyBtb2R1bGUKPiAodmRw
YV9zaW1fbmV0KSBhbmQgbGVhdmVzIHRoZSBnZW5lcmljIGZ1bmN0aW9ucyBpbiB0aGUgdmRwYV9z
aW0gY29yZQo+IG1vZHVsZSwgYWxsb3dpbmcgdGhlIHBvc3NpYmlsaXR5IHRvIGFkZCBuZXcgdkRQ
QSBkZXZpY2Ugc2ltdWxhdG9ycy4KPiBUaGVuIHdlIGFkZGVkIGEgbmV3IHZkcGFfc2ltX2JsayBt
b2R1bGUgdG8gc2ltdWxhdGUgYSBibG9jayBkZXZpY2UuCj4KPiBJJ20gbm90IHN1cmUgYWJvdXQg
cGF0Y2ggMTEgKCJ2cmluZ2g6IGFsbG93IHZyaW5naF9pb3ZfeGZlcigpIHRvIHNraXAKPiBieXRl
cyB3aGVuIHB0ciBpcyBOVUxMIiksIG1heWJlIHdlIGNhbiBhZGQgYSBuZXcgZnVuY3Rpb25zIGlu
c3RlYWQgb2YKPiBtb2RpZnkgdnJpbmdoX2lvdl94ZmVyKCkuCj4KPiBBcyBNYXggcmVwb3J0ZWQs
IEknbSBhbHNvIHNlZWluZyBlcnJvcnMgd2l0aCB2ZHBhX3NpbV9ibGsgcmVsYXRlZCB0bwo+IGlv
dGxiIGFuZCB2cmluZ2ggd2hlbiB0aGVyZSBpcyBoaWdoIGxvYWQsIHRoZXNlIGFyZSBzb21lIG9m
IHRoZSBlcnJvcgo+IG1lc3NhZ2VzIEkgY2FuIHNlZSByYW5kb21seToKPgo+ICAgIHZyaW5naDog
RmFpbGVkIHRvIGFjY2VzcyBhdmFpbCBpZHggYXQgMDAwMDAwMDBlOGRlYjJjYwo+ICAgIHZyaW5n
aDogRmFpbGVkIHRvIHJlYWQgaGVhZDogaWR4IDYyODkgYWRkcmVzcyAwMDAwMDAwMGUxYWQxZDUw
Cj4gICAgdnJpbmdoOiBGYWlsZWQgdG8gZ2V0IGZsYWdzIGF0IDAwMDAwMDAwNjYzNWQ3YTMKPgo+
ICAgIHZpcnRpb192ZHBhIHZkcGEwOiB2cmluZ2hfaW92X3B1c2hfaW90bGIoKSBlcnJvcjogLTE0
IG9mZnNldDogMHgyODQwMDAwIGxlbjogMHgyMDAwMAo+ICAgIHZpcnRpb192ZHBhIHZkcGEwOiB2
cmluZ2hfaW92X3B1bGxfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDogMHg1OGVlMDAwIGxlbjog
MHgzMDAwCj4KPiBUaGVzZSBlcnJvcnMgc2hvdWxkIGFsbCBiZSByZWxhdGVkIHRvIHRoZSBmYWN0
IHRoYXQgaW90bGJfdHJhbnNsYXRlKCkKPiBmYWlscyB3aXRoIC1FSU5WQUwsIHNvIGl0IHNlZW1z
IHRoYXQgd2UgbWlzcyBzb21lIG1hcHBpbmcuCgoKSXMgdGhpcyBvbmx5IHJlcHJvZHVjaWJsZSB3
aGVuIHRoZXJlJ3MgbXVsdGlwbGUgY28tY3VycmVudCBhY2Nlc3Npbmcgb2YgCklPVExCPyBJZiB5
ZXMsIGl0J3MgcHJvYmFibHkgYSBoaW50IHRoYXQgc29tZSBraW5kIG9mIHN5bmNocm9uaXphdGlv
biBpcyAKc3RpbGwgbWlzc2VkIHNvbWV3aGVyZS4KCkl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBsb2cg
dGhlIGRtYV9tYXAvdW5tcCBpbiBib3RoIHZpcnRpb19yaW5nIGFuZCAKdnJpbmdoIHRvIHNlZSB3
aG8gaXMgbWlzc2luZyB0aGUgbWFwLgoKVGhhbmtzCgoKPgo+IEknbGwgZGVidWcgbW9yZSBjYXJl
ZnVsbHksIGluIHRoZSBtZWFudGltZSBjYW4geW91IGdpdmUgYSBmaXJzdCByZXZpZXc/Cj4KPiBU
aGFua3MsCj4gU3RlZmFubwo+Cj4gTWF4IEd1cnRvdm95ICg0KToKPiAgICB2aG9zdC12ZHBhOiBh
ZGQgc3VwcG9ydCBmb3IgdkRQQSBibGsgZGV2aWNlcwo+ICAgIHZkcGE6IHNwbGl0IHZkcGFzaW0g
dG8gY29yZSBhbmQgbmV0IG1vZHVsZXMKPiAgICB2ZHBhX3NpbTogcmVtb3ZlIGhhcmQtY29kZWQg
dmlydHEgY291bnQKPiAgICB2ZHBhOiBhZGQgdmRwYSBzaW11bGF0b3IgZm9yIGJsb2NrIGRldmlj
ZQo+Cj4gU3RlZmFubyBHYXJ6YXJlbGxhICg4KToKPiAgICB2ZHBhX3NpbTogcmVtb3ZlIHRoZSBs
aW1pdCBvZiBJT1RMQiBlbnRyaWVzCj4gICAgdmRwYV9zaW06IGFkZCBzdHJ1Y3QgdmRwYXNpbV9k
ZXZpY2UgdG8gc3RvcmUgZGV2aWNlIHByb3BlcnRpZXMKPiAgICB2ZHBhX3NpbTogbW92ZSBjb25m
aWcgbWFuYWdlbWVudCBvdXRzaWRlIG9mIHRoZSBjb3JlCj4gICAgdmRwYV9zaW06IHVzZSBrdm1h
bGxvYyB0byBhbGxvY2F0ZSB2ZHBhc2ltLT5idWZmZXIKPiAgICB2ZHBhX3NpbTogbWFrZSB2ZHBh
c2ltLT5idWZmZXIgc2l6ZSBjb25maWd1cmFibGUKPiAgICB2ZHBhX3NpbTogc3BsaXQgdmRwYXNp
bV92aXJ0cXVldWUncyBpb3YgZmllbGQgaW4gcmlvdiBhbmQgd2lvdgo+ICAgIHZyaW5naDogYWxs
b3cgdnJpbmdoX2lvdl94ZmVyKCkgdG8gc2tpcCBieXRlcyB3aGVuIHB0ciBpcyBOVUxMCj4gICAg
dmRwYV9zaW1fYmxrOiBpbXBsZW1lbnQgcmFtZGlzayBiZWhhdmlvdXIKPgo+ICAgZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmggICAgIHwgMTE3ICsrKysrKysrKysrCj4gICBkcml2ZXJz
L3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgfCAyODMgKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAyNTEgKysr
KysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1f
bmV0LmMgfCAxNzIgKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAg
ICAgICAgICAgICAgIHwgIDExICstCj4gICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jICAgICAgICAg
ICAgICAgfCAgMTYgKy0KPiAgIGRyaXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAgICB8
ICAxNiArLQo+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL01ha2VmaWxlICAgICAgIHwgICAyICsK
PiAgIDggZmlsZXMgY2hhbmdlZCwgNjI4IGluc2VydGlvbnMoKyksIDI0MCBkZWxldGlvbnMoLSkK
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsu
Ywo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9u
ZXQuYwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
