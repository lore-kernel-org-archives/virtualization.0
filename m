Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2D3C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Oct 2022 06:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B1FF40518;
	Tue, 11 Oct 2022 06:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B1FF40518
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RsdGUgAs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BwaoSxw4ifYs; Tue, 11 Oct 2022 06:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 954B5403C7;
	Tue, 11 Oct 2022 06:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 954B5403C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69295C0033;
	Tue, 11 Oct 2022 06:51:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4179EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 06:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 076004170D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 06:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 076004170D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RsdGUgAs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9guAhOGtLkl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 06:51:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A98EF4168F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A98EF4168F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665471073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RA9d/CydApg8OyFFovca4PNnFRnqPkAdMHsVOTLNTuQ=;
 b=RsdGUgAsuiNSUMrXIOJw/nF53NYqm1MspzBaNrKCnI8pytRAUEPiwDudTM9kXjwl9wvUvu
 elYyO+seYyvoeHGAgwnZn6eO6Gp+NrOcLdIO2T41qmYXLi1lMpWZmGWIUH0yauV4SGWt/c
 gMpGsr5EHtbMW3AMo4XT+4rUli60t6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-l-IF7wmsM6mXthUIkJOhfw-1; Tue, 11 Oct 2022 02:51:08 -0400
X-MC-Unique: l-IF7wmsM6mXthUIkJOhfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBF32857F8F;
 Tue, 11 Oct 2022 06:51:07 +0000 (UTC)
Received: from localhost (unknown [10.39.193.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 480D2C15BB1;
 Tue, 11 Oct 2022 06:51:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RESEND PATCH v5 1/1] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <20221010130951-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
 <20221010064359.1324353-2-ricardo.canuelo@collabora.com>
 <Y0QYTq7KW9C731s0@debian.me> <877d17n699.fsf@redhat.com>
 <20221010130951-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 11 Oct 2022 08:51:05 +0200
Message-ID: <8735buetuu.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, kernel@collabora.com
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

T24gTW9uLCBPY3QgMTAgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gTW9uLCBPY3QgMTAsIDIwMjIgYXQgMDM6NDM6NDZQTSArMDIwMCwgQ29y
bmVsaWEgSHVjayB3cm90ZToKPj4gT24gTW9uLCBPY3QgMTAgMjAyMiwgQmFnYXMgU2FuamF5YSA8
YmFnYXNkb3RtZUBnbWFpbC5jb20+IHdyb3RlOgo+PiAKPj4gPiBPbiBNb24sIE9jdCAxMCwgMjAy
MiBhdCAwODo0Mzo1OUFNICswMjAwLCBSaWNhcmRvIENhw7F1ZWxvIHdyb3RlOgo+PiA+PiArCj4+
ID4+ICtSZWZlcmVuY2VzCj4+ID4+ICs9PT09PT09PT09Cj4+ID4+ICsKPj4gPj4gK19gWzFdYCBW
aXJ0aW8gU3BlYyB2MS4yOgo+PiA+PiAraHR0cHM6Ly9kb2NzLm9hc2lzLW9wZW4ub3JnL3ZpcnRp
by92aXJ0aW8vdjEuMi92aXJ0aW8tdjEuMi5odG1sCj4+ID4+ICsKPj4gPj4gK0NoZWNrIGZvciBs
YXRlciB2ZXJzaW9ucyBvZiB0aGUgc3BlYyBhcyB3ZWxsLgo+PiA+PiArCj4+ID4KPj4gPiBUaGUg
dmVyc2lvbiBjaGVja2luZyBzaG91bGQgYmUgbWFkZSBjb21tZW50IChub3QgdmlzaWJsZSBvbiB0
aGUgb3V0cHV0KToKPj4gPgo+PiA+IC0tLS0gPjggLS0tLQo+PiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QgYi9Eb2N1bWVudGF0aW9uL2Ry
aXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QKPj4gPiBpbmRleCA3MGIzYWE2YmNmNTUxOC4uNGYz
YWJiZWM0ZThiMmMgMTAwNjQ0Cj4+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3Zp
cnRpby92aXJ0aW8ucnN0Cj4+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRp
by92aXJ0aW8ucnN0Cj4+ID4gQEAgLTEzNCw3ICsxMzQsNyBAQCBSZWZlcmVuY2VzCj4+ID4gIF9g
WzFdYCBWaXJ0aW8gU3BlYyB2MS4yOgo+PiA+ICBodHRwczovL2RvY3Mub2FzaXMtb3Blbi5vcmcv
dmlydGlvL3ZpcnRpby92MS4yL3ZpcnRpby12MS4yLmh0bWwKPj4gPiAgCj4+ID4gLUNoZWNrIGZv
ciBsYXRlciB2ZXJzaW9ucyBvZiB0aGUgc3BlYyBhcyB3ZWxsLgo+PiA+ICsuLiBDaGVjayBmb3Ig
bGF0ZXIgdmVyc2lvbnMgb2YgdGhlIHNwZWMgYXMgd2VsbC4KPj4gPiAgCj4+ID4gIF9gWzJdYCBW
aXJ0cXVldWVzIGFuZCB2aXJ0aW8gcmluZzogSG93IHRoZSBkYXRhIHRyYXZlbHMKPj4gPiAgaHR0
cHM6Ly93d3cucmVkaGF0LmNvbS9lbi9ibG9nL3ZpcnRxdWV1ZXMtYW5kLXZpcnRpby1yaW5nLWhv
dy1kYXRhLXRyYXZlbHMKPj4gPgo+PiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kcml2
ZXItYXBpL3ZpcnRpby93cml0aW5nX3ZpcnRpb19kcml2ZXJzLnJzdCBiL0RvY3VtZW50YXRpb24v
ZHJpdmVyLWFwaS92aXJ0aW8vd3JpdGluZ192aXJ0aW9fZHJpdmVycy5yc3QKPj4gPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPj4gPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lMTRjNTg3OTZkMjUKPj4g
Pj4gLS0tIC9kZXYvbnVsbAo+PiA+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmly
dGlvL3dyaXRpbmdfdmlydGlvX2RyaXZlcnMucnN0Cj4+ID4+IDxzbmlwcGVkPi4uLgo+PiA+PiAr
UmVmZXJlbmNlcwo+PiA+PiArPT09PT09PT09PQo+PiA+PiArCj4+ID4+ICtfYFsxXWAgVmlydGlv
IFNwZWMgdjEuMjoKPj4gPj4gK2h0dHBzOi8vZG9jcy5vYXNpcy1vcGVuLm9yZy92aXJ0aW8vdmly
dGlvL3YxLjIvdmlydGlvLXYxLjIuaHRtbAo+PiA+PiArCj4+ID4+ICtDaGVjayBmb3IgbGF0ZXIg
dmVyc2lvbnMgb2YgdGhlIHNwZWMgYXMgd2VsbC4KPj4gPgo+PiA+IFNhbWUgcmVwbHkuCj4+IAo+
PiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBoaWRlIHRoYXQgaW4gYSBjb21tZW50IC0tIHVubGVz
cyB5b3Ugd2FudCB0bwo+PiB1cGRhdGUgdGhpcyBmaWxlIGV2ZXJ5IHRpbWUgYSBuZXcgdmVyc2lv
biBvZiB0aGUgdmlydGlvIHNwZWMgZ2V0cwo+PiByZWxlYXNlZC4KPgo+IFdoYXQgZG8geW91IHN1
Z2dlc3Q/IEp1c3QgaHR0cDovL2RvY3Mub2FzaXMtb3Blbi5vcmcvdmlydGlvL3ZpcnRpby8gPwoK
VGhhdCBvbmUgaXMgdWdseSwgYXMgaXQgaXMganVzdCBhIGRpcmVjdG9yeSBsaXN0aW5nLi4uIG15
IHByZWZlcmVuY2UgaXMKdG8gbGluayB0byB0aGUgbGF0ZXN0IHZlcnNpb24gYXQgdGhlIHRpbWUg
b2Ygd3JpdGluZywgYW5kIG1lbnRpb25pbmcKdGhhdCB0aGVyZSBtYXkgYmUgbGF0ZXIgdmVyc2lv
bnMgYXZhaWxhYmxlLCBpLmUuIHdoYXQgdGhlIHBhdGNoIGRvZXMKcmlnaHQgbm93LgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
