Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD40AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 11 Oct 2022 07:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E53440B71;
	Tue, 11 Oct 2022 07:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E53440B71
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2swaoPG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cozOv2zBbDKX; Tue, 11 Oct 2022 07:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACFDB40148;
	Tue, 11 Oct 2022 07:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACFDB40148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E812C0033;
	Tue, 11 Oct 2022 07:58:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35078C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 07:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 093CD827A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 07:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 093CD827A5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D2swaoPG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QIx_c1mIQ-7v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 07:58:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3A7D81BB2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3A7D81BB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665475080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5IMc410YeVnl3Sqez6F7ezBcpM1qVzhXkGhzsygGr4=;
 b=D2swaoPGsU1ptY6XAt6XbVojQqm5koZGozKlwGxOUdFx2+K45b2A0Cc9nCLuFyv/dvYGzA
 MvgwiUIdP2KKprH5oGpiiXkfLmkaRYBLWthfHbWD5TQ2gC5iOLIyxdNOVPq9Bo2ca4wuLQ
 c7/cAM1HPyiI22DPuQqYiLCtd7joPek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-erze4i6pP1GBdBKQbyaorQ-1; Tue, 11 Oct 2022 03:57:59 -0400
X-MC-Unique: erze4i6pP1GBdBKQbyaorQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F44F882825;
 Tue, 11 Oct 2022 07:57:59 +0000 (UTC)
Received: from localhost (unknown [10.39.193.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B08A11402BD9;
 Tue, 11 Oct 2022 07:57:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RESEND PATCH v5 1/1] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <9732990d-f362-fd38-4855-48f226da94a8@gmail.com>
Organization: Red Hat GmbH
References: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
 <20221010064359.1324353-2-ricardo.canuelo@collabora.com>
 <Y0QYTq7KW9C731s0@debian.me> <877d17n699.fsf@redhat.com>
 <20221010130951-mutt-send-email-mst@kernel.org>
 <8735buetuu.fsf@redhat.com>
 <9732990d-f362-fd38-4855-48f226da94a8@gmail.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 11 Oct 2022 09:57:57 +0200
Message-ID: <87zge2dc6y.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@collabora.com
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

T24gVHVlLCBPY3QgMTEgMjAyMiwgQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+
IHdyb3RlOgoKPiBPbiAxMC8xMS8yMiAxMzo1MSwgQ29ybmVsaWEgSHVjayB3cm90ZToKPj4gT24g
TW9uLCBPY3QgMTAgMjAyMiwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPj4gCj4+PiBPbiBNb24sIE9jdCAxMCwgMjAyMiBhdCAwMzo0Mzo0NlBNICswMjAwLCBD
b3JuZWxpYSBIdWNrIHdyb3RlOgo+Pj4+IE9uIE1vbiwgT2N0IDEwIDIwMjIsIEJhZ2FzIFNhbmph
eWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPiB3cm90ZToKPj4+Pgo+Pj4+PiBPbiBNb24sIE9jdCAx
MCwgMjAyMiBhdCAwODo0Mzo1OUFNICswMjAwLCBSaWNhcmRvIENhw7F1ZWxvIHdyb3RlOgo+Pj4+
Pj4gKwo+Pj4+Pj4gK1JlZmVyZW5jZXMKPj4+Pj4+ICs9PT09PT09PT09Cj4+Pj4+PiArCj4+Pj4+
PiArX2BbMV1gIFZpcnRpbyBTcGVjIHYxLjI6Cj4+Pj4+PiAraHR0cHM6Ly9kb2NzLm9hc2lzLW9w
ZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEuMi92aXJ0aW8tdjEuMi5odG1sCj4+Pj4+PiArCj4+Pj4+
PiArQ2hlY2sgZm9yIGxhdGVyIHZlcnNpb25zIG9mIHRoZSBzcGVjIGFzIHdlbGwuCj4+Pj4+PiAr
Cj4+Pj4+Cj4+Pj4+IFRoZSB2ZXJzaW9uIGNoZWNraW5nIHNob3VsZCBiZSBtYWRlIGNvbW1lbnQg
KG5vdCB2aXNpYmxlIG9uIHRoZSBvdXRwdXQpOgo+Pj4+Pgo+Pj4+PiAtLS0tID44IC0tLS0KPj4+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJz
dCBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdAo+Pj4+PiBpbmRl
eCA3MGIzYWE2YmNmNTUxOC4uNGYzYWJiZWM0ZThiMmMgMTAwNjQ0Cj4+Pj4+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdAo+Pj4+PiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QKPj4+Pj4gQEAgLTEzNCw3ICsxMzQs
NyBAQCBSZWZlcmVuY2VzCj4+Pj4+ICBfYFsxXWAgVmlydGlvIFNwZWMgdjEuMjoKPj4+Pj4gIGh0
dHBzOi8vZG9jcy5vYXNpcy1vcGVuLm9yZy92aXJ0aW8vdmlydGlvL3YxLjIvdmlydGlvLXYxLjIu
aHRtbAo+Pj4+PiAgCj4+Pj4+IC1DaGVjayBmb3IgbGF0ZXIgdmVyc2lvbnMgb2YgdGhlIHNwZWMg
YXMgd2VsbC4KPj4+Pj4gKy4uIENoZWNrIGZvciBsYXRlciB2ZXJzaW9ucyBvZiB0aGUgc3BlYyBh
cyB3ZWxsLgo+Pj4+PiAgCj4+Pj4+ICBfYFsyXWAgVmlydHF1ZXVlcyBhbmQgdmlydGlvIHJpbmc6
IEhvdyB0aGUgZGF0YSB0cmF2ZWxzCj4+Pj4+ICBodHRwczovL3d3dy5yZWRoYXQuY29tL2VuL2Js
b2cvdmlydHF1ZXVlcy1hbmQtdmlydGlvLXJpbmctaG93LWRhdGEtdHJhdmVscwo+Pj4+Pgo+Pj4+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vd3JpdGluZ192
aXJ0aW9fZHJpdmVycy5yc3QgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3dyaXRp
bmdfdmlydGlvX2RyaXZlcnMucnN0Cj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4+Pj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5lMTRjNTg3OTZkMjUKPj4+Pj4+IC0tLSAvZGV2L251bGwKPj4+
Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vd3JpdGluZ192aXJ0aW9f
ZHJpdmVycy5yc3QKPj4+Pj4+IDxzbmlwcGVkPi4uLgo+Pj4+Pj4gK1JlZmVyZW5jZXMKPj4+Pj4+
ICs9PT09PT09PT09Cj4+Pj4+PiArCj4+Pj4+PiArX2BbMV1gIFZpcnRpbyBTcGVjIHYxLjI6Cj4+
Pj4+PiAraHR0cHM6Ly9kb2NzLm9hc2lzLW9wZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEuMi92aXJ0
aW8tdjEuMi5odG1sCj4+Pj4+PiArCj4+Pj4+PiArQ2hlY2sgZm9yIGxhdGVyIHZlcnNpb25zIG9m
IHRoZSBzcGVjIGFzIHdlbGwuCj4+Pj4+Cj4+Pj4+IFNhbWUgcmVwbHkuCj4+Pj4KPj4+PiBJIGRv
bid0IHRoaW5rIHdlIHNob3VsZCBoaWRlIHRoYXQgaW4gYSBjb21tZW50IC0tIHVubGVzcyB5b3Ug
d2FudCB0bwo+Pj4+IHVwZGF0ZSB0aGlzIGZpbGUgZXZlcnkgdGltZSBhIG5ldyB2ZXJzaW9uIG9m
IHRoZSB2aXJ0aW8gc3BlYyBnZXRzCj4+Pj4gcmVsZWFzZWQuCj4+Pgo+Pj4gV2hhdCBkbyB5b3Ug
c3VnZ2VzdD8gSnVzdCBodHRwOi8vZG9jcy5vYXNpcy1vcGVuLm9yZy92aXJ0aW8vdmlydGlvLyA/
Cj4+IAo+PiBUaGF0IG9uZSBpcyB1Z2x5LCBhcyBpdCBpcyBqdXN0IGEgZGlyZWN0b3J5IGxpc3Rp
bmcuLi4gbXkgcHJlZmVyZW5jZSBpcwo+PiB0byBsaW5rIHRvIHRoZSBsYXRlc3QgdmVyc2lvbiBh
dCB0aGUgdGltZSBvZiB3cml0aW5nLCBhbmQgbWVudGlvbmluZwo+PiB0aGF0IHRoZXJlIG1heSBi
ZSBsYXRlciB2ZXJzaW9ucyBhdmFpbGFibGUsIGkuZS4gd2hhdCB0aGUgcGF0Y2ggZG9lcwo+PiBy
aWdodCBub3cuCj4+IAo+Cj4gSU1PLCB3ZSBjYW4gbGluayB0byBjdXJyZW50IHNwZWMgdmVyc2lv
biBhbmQgdXBkYXRlIGl0IGFzIG5ld2VyIHZlcnNpb24KPiBiZWNvbWVzIHB1YmxpYzsgd2l0aG91
dCBhZGRpbmcgImNoZWNrIGZvciBsYXRlciB2ZXJzaW9uIiBjb21tZW50IG5vdGUuCgpJcyBpdCBy
ZWFsbHkgdGhhdCBpbXBvcnRhbnQgdG8gdXBkYXRlPyBVbmxlc3MgdGhlIHZpcnRpbyBpbm5hcmRz
IGNoYW5nZQpyYWRpY2FsbHksIGxvb2tpbmcgYXQgYW4gb2xkZXIgdmVyc2lvbiBpcyBsaWtlbHkg
dG8gYmUgc3VmZmljaWVudC4KClsiV2Ugc2hvdWxkIHVwZGF0ZSBpdCIgaXMgbGlrZWx5IHRvIGJl
Y29tZSAiT2gsIHdlIHNob3VsZCBoYXZlIHVwZGF0ZWQKaXQgc29tZSB0aW1lIGFnbyIgSU1FIDop
XQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
