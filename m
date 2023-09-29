Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2692FE743FE
	for <virtualization@archiver.kernel.org>; Fri, 29 Sep 2023 09:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87C4E611BA;
	Fri, 29 Sep 2023 09:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87C4E611BA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J5NW49ym
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qbAApPv4SSaW; Fri, 29 Sep 2023 09:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0DD1760F03;
	Fri, 29 Sep 2023 09:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DD1760F03
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0381C0071;
	Fri, 29 Sep 2023 09:12:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 080EFC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE73F42228
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE73F42228
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J5NW49ym
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVNtvEzgbRh8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:12:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7ACBF4219D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Sep 2023 09:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7ACBF4219D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWGhTxhB3dGkyUJd+ZvB0A+li+V3clasR5rFEOBuS5Q=;
 b=J5NW49ymLuzqQ6+xLRpT/SIVxAQh/MJOWw93LT8nRnfcQRnuGFmY9jZFA61fdRFKxygrDf
 9fw9WVvnlmKppQMgLUUhNRWfHPwVNCfbSA9XyYsQ4rHLGMDwY/ch5Pd+aeGjATbdod4/8B
 056uZpaa5bnZQSL1x7Smv4VcA6NP2xI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-zINCMx0OMu-lnzv0G8nixg-1; Fri, 29 Sep 2023 05:12:29 -0400
X-MC-Unique: zINCMx0OMu-lnzv0G8nixg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDC473C1ACEE;
 Fri, 29 Sep 2023 09:12:28 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E46AD14171B6;
 Fri, 29 Sep 2023 09:12:26 +0000 (UTC)
Message-ID: <db93d5aa-64c4-42a4-73dc-ae25e9e3833e@redhat.com>
Date: Fri, 29 Sep 2023 11:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 3/4] vduse: update the vq_info in ioctl
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-4-lulu@redhat.com>
 <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <CACGkMEuKcgH0kdLPmWZ69fL6SYvoVPfeGv11QwhQDW2sr9DZ3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA5LzEyLzIzIDA5OjM5LCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFR1ZSwgU2VwIDEyLCAy
MDIzIGF0IDExOjAw4oCvQU0gQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+
IEluIFZEVVNFX1ZRX0dFVF9JTkZPLCB0aGUgZHJpdmVyIHdpbGwgc3luYyB0aGUgbGFzdF9hdmFp
bF9pZHgKPj4gd2l0aCByZWNvbm5lY3QgaW5mbywgQWZ0ZXIgbWFwcGluZyB0aGUgcmVjb25uZWN0
IHBhZ2VzIHRvIHVzZXJzcGFjZQo+PiBUaGUgdXNlcnNwYWNlIEFwcCB3aWxsIHVwZGF0ZSB0aGUg
cmVjb25uZWN0X3RpbWUgaW4KPj4gc3RydWN0IHZob3N0X3JlY29ubmVjdF92cmluZywgSWYgdGhp
cyBpcyBub3QgMCB0aGVuIGl0IG1lYW5zIHRoaXMKPj4gdnEgaXMgcmVjb25uZWN0ZWQgYW5kIHdp
bGwgdXBkYXRlIHRoZSBsYXN0X2F2YWlsX2lkeAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaW5keSBM
dSA8bHVsdUByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jIHwgMTMgKysrKysrKysrKysrKwo+PiAgIGluY2x1ZGUvdWFwaS9saW51eC92ZHVz
ZS5oICAgICAgICAgfCAgNiArKysrKysKPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2
LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+IGluZGV4IDJjNjlmNDAw
NGE2ZS4uNjgwYjIzZGJkZGUyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2Vy
L3ZkdXNlX2Rldi5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMK
Pj4gQEAgLTEyMjEsNiArMTIyMSw4IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1
Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPj4gICAgICAgICAgICAgICAgICBzdHJ1
Y3QgdmR1c2VfdnFfaW5mbyB2cV9pbmZvOwo+PiAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZHVz
ZV92aXJ0cXVldWUgKnZxOwo+PiAgICAgICAgICAgICAgICAgIHUzMiBpbmRleDsKPj4gKyAgICAg
ICAgICAgICAgIHN0cnVjdCB2ZHBhX3JlY29ubmVjdF9pbmZvICphcmVhOwo+PiArICAgICAgICAg
ICAgICAgc3RydWN0IHZob3N0X3JlY29ubmVjdF92cmluZyAqdnFfcmVjb25uZWN0Owo+Pgo+PiAg
ICAgICAgICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGNv
cHlfZnJvbV91c2VyKCZ2cV9pbmZvLCBhcmdwLCBzaXplb2YodnFfaW5mbykpKQo+PiBAQCAtMTI1
Miw2ICsxMjU0LDE3IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAq
ZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPj4KPj4gICAgICAgICAgICAgICAgICB2cV9pbmZvLnJl
YWR5ID0gdnEtPnJlYWR5Owo+Pgo+PiArICAgICAgICAgICAgICAgYXJlYSA9ICZ2cS0+cmVjb25u
ZWN0X2luZm87Cj4+ICsKPj4gKyAgICAgICAgICAgICAgIHZxX3JlY29ubmVjdCA9IChzdHJ1Y3Qg
dmhvc3RfcmVjb25uZWN0X3ZyaW5nICopYXJlYS0+dmFkZHI7Cj4+ICsgICAgICAgICAgICAgICAv
KmNoZWNrIGlmIHRoZSB2cSBpcyByZWNvbm5lY3QsIGlmIHllcyB0aGVuIHVwZGF0ZSB0aGUgbGFz
dF9hdmFpbF9pZHgqLwo+PiArICAgICAgICAgICAgICAgaWYgKCh2cV9yZWNvbm5lY3QtPmxhc3Rf
YXZhaWxfaWR4ICE9Cj4+ICsgICAgICAgICAgICAgICAgICAgIHZxX2luZm8uc3BsaXQuYXZhaWxf
aW5kZXgpICYmCj4+ICsgICAgICAgICAgICAgICAgICAgKHZxX3JlY29ubmVjdC0+cmVjb25uZWN0
X3RpbWUgIT0gMCkpIHsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgdnFfaW5mby5zcGxpdC5h
dmFpbF9pbmRleCA9Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnFfcmVjb25u
ZWN0LT5sYXN0X2F2YWlsX2lkeDsKPj4gKyAgICAgICAgICAgICAgIH0KPj4gKwo+PiAgICAgICAg
ICAgICAgICAgIHJldCA9IC1FRkFVTFQ7Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9f
dXNlcihhcmdwLCAmdnFfaW5mbywgc2l6ZW9mKHZxX2luZm8pKSkKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNl
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+PiBpbmRleCAxMWJkNDhjNzJjNmMuLmQ1
ODU0MjU4MDNmZCAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPj4g
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPj4gQEAgLTM1MCw0ICszNTAsMTAgQEAg
c3RydWN0IHZkdXNlX2Rldl9yZXNwb25zZSB7Cj4+ICAgICAgICAgIH07Cj4+ICAgfTsKPj4KPj4g
K3N0cnVjdCB2aG9zdF9yZWNvbm5lY3RfdnJpbmcgewo+PiArICAgICAgIF9fdTE2IHJlY29ubmVj
dF90aW1lOwo+PiArICAgICAgIF9fdTE2IGxhc3RfYXZhaWxfaWR4Owo+PiArICAgICAgIF9Cb29s
IGF2YWlsX3dyYXBfY291bnRlcjsKPiAKPiBQbGVhc2UgYWRkIGEgY29tbWVudCBmb3IgZWFjaCBm
aWVsZC4KPiAKPiBBbmQgSSBuZXZlciBzYXcgX0Jvb2wgaXMgdXNlZCBpbiB1YXBpIGJlZm9yZSwg
bWF5YmUgaXQncyBiZXR0ZXIgdG8KPiBwYWNrIGl0IHdpdGggbGFzdF9hdmFpbF9pZHggaW50byBh
IF9fdTMyLgoKQmV0dGVyIGFzIHR3byBkaXN0aW5jdHMgX191MTYgSU1ITy4KClRoYW5rcywKTWF4
aW1lCgo+IAo+IEJ0dywgZG8gd2UgbmVlZCB0byB0cmFjayBpbmZsaWdodCBkZXNjcmlwdG9ycyBh
cyB3ZWxsPwo+IAo+IFRoYW5rcwo+IAo+PiArfTsKPj4gKwo+PiAgICNlbmRpZiAvKiBfVUFQSV9W
RFVTRV9IXyAqLwo+PiAtLQo+PiAyLjM0LjMKPj4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
