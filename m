Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBE1E8180C
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 01:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52C04821D2;
	Tue, 26 Sep 2023 01:28:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52C04821D2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R7GAmUgx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQEkN_5QehxW; Tue, 26 Sep 2023 01:28:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B877B821CE;
	Tue, 26 Sep 2023 01:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B877B821CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9E7C0039;
	Tue, 26 Sep 2023 01:28:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6232DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 01:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F468821D0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 01:28:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F468821D0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6_EmNAXgjnqu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 01:28:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40DAD821CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 01:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40DAD821CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695691712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OhGiNLvBNZEMFqnuOuRobxprn9JRSs+NH5J7h+1BKk=;
 b=R7GAmUgxPCUghuwi1YzVhrCisG4RlsrTMBI5IUB30Zy7LeFp9C/E9SwUl0XltX+dujtt2G
 cXNousmCs0VmxesRePf4txoZfKEkjGJfIGHquDZ1QnxY2hIGXIzLxVqBPAx8vJ4mwOqK2u
 GAIbgj+2w3MmunVDM+C1FxNa+85s2wo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-OlB2hctWPDSKeJr00OCXww-1; Mon, 25 Sep 2023 21:28:26 -0400
X-MC-Unique: OlB2hctWPDSKeJr00OCXww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B0DD800962;
 Tue, 26 Sep 2023 01:28:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1596B1678B;
 Tue, 26 Sep 2023 01:28:19 +0000 (UTC)
Date: Tue, 26 Sep 2023 09:28:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V3] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Message-ID: <ZRIzr6C8tHM2N4Ng@fedora>
References: <20230908093009.540763-1-ming.lei@redhat.com>
 <58227846-6b73-46ef-957f-d9b1e0451899@kernel.dk>
 <ZPsxCYFgZjIIeaBk@fedora>
 <0f85a6b5-3ba6-4b77-bb7d-79f365dbb44c@kernel.dk>
 <ZPs81IAYfB8J78Pv@fedora>
 <CACGkMEvP=f1mB=01CDOhHaDLNL9espKPrUffgHEdBVkW4fo=pw@mail.gmail.com>
 <20230925211710.GH323580@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230925211710.GH323580@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
 ming.lei@redhat.com, mst@redhat.com, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
 io-uring@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMDU6MTc6MTBQTSAtMDQwMCwgU3RlZmFuIEhham5vY3pp
IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDE1LCAyMDIzIGF0IDAzOjA0OjA1UE0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4gPiBPbiBGcmksIFNlcCA4LCAyMDIzIGF0IDExOjI14oCvUE0gTWluZyBM
ZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBGcmksIFNlcCAw
OCwgMjAyMyBhdCAwODo0NDo0NUFNIC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOgo+ID4gPiA+IE9u
IDkvOC8yMyA4OjM0IEFNLCBNaW5nIExlaSB3cm90ZToKPiA+ID4gPiA+IE9uIEZyaSwgU2VwIDA4
LCAyMDIzIGF0IDA3OjQ5OjUzQU0gLTA2MDAsIEplbnMgQXhib2Ugd3JvdGU6Cj4gPiA+ID4gPj4g
T24gOS84LzIzIDM6MzAgQU0sIE1pbmcgTGVpIHdyb3RlOgo+ID4gPiA+ID4+PiBkaWZmIC0tZ2l0
IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKPiA+ID4gPiA+Pj4g
aW5kZXggYWQ2MzY5NTRhYmFlLi45NWEzZDMxYTFlZjEgMTAwNjQ0Cj4gPiA+ID4gPj4+IC0tLSBh
L2lvX3VyaW5nL2lvX3VyaW5nLmMKPiA+ID4gPiA+Pj4gKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcu
Ywo+ID4gPiA+ID4+PiBAQCAtMTkzMCw2ICsxOTMwLDEwIEBAIHZvaWQgaW9fd3Ffc3VibWl0X3dv
cmsoc3RydWN0IGlvX3dxX3dvcmsgKndvcmspCj4gPiA+ID4gPj4+ICAgICAgICAgICB9Cj4gPiA+
ID4gPj4+ICAgfQo+ID4gPiA+ID4+Pgo+ID4gPiA+ID4+PiArIC8qIEl0IGlzIGZyYWdpbGUgdG8g
YmxvY2sgUE9MTEVEIElPLCBzbyBzd2l0Y2ggdG8gTk9OX0JMT0NLICovCj4gPiA+ID4gPj4+ICsg
aWYgKChyZXEtPmN0eC0+ZmxhZ3MgJiBJT1JJTkdfU0VUVVBfSU9QT0xMKSAmJiBkZWYtPmlvcG9s
bF9xdWV1ZSkKPiA+ID4gPiA+Pj4gKyAgICAgICAgIGlzc3VlX2ZsYWdzIHw9IElPX1VSSU5HX0Zf
Tk9OQkxPQ0s7Cj4gPiA+ID4gPj4+ICsKPiA+ID4gPiA+Pgo+ID4gPiA+ID4+IEkgdGhpbmsgdGhp
cyBjb21tZW50IGRlc2VydmVzIHRvIGJlIG1vcmUgZGVzY3JpcHRpdmUuIE5vcm1hbGx5IHdlCj4g
PiA+ID4gPj4gYWJzb2x1dGVseSBjYW5ub3QgYmxvY2sgZm9yIHBvbGxlZCBJTywgaXQncyBvbmx5
IE9LIGhlcmUgYmVjYXVzZSBpby13cQo+ID4gPiA+ID4KPiA+ID4gPiA+IFllYWgsIHdlIGRvbid0
IGRvIHRoYXQgdW50aWwgY29tbWl0IDJiYzA1NzY5MjU5OSAoImJsb2NrOiBkb24ndCBtYWtlIFJF
UV9QT0xMRUQKPiA+ID4gPiA+IGltcGx5IFJFUV9OT1dBSVQiKSB3aGljaCBhY3R1YWxseSBwdXNo
IHRoZSByZXNwb25zaWJpbGl0eS9yaXNrIHVwIHRvCj4gPiA+ID4gPiBpb191cmluZy4KPiA+ID4g
PiA+Cj4gPiA+ID4gPj4gaXMgdGhlIGlzc3VlciBhbmQgbm90IG5lY2Vzc2FyaWx5IHRoZSBwb2xs
ZXIgb2YgaXQuIFRoYXQgZ2VuZXJhbGx5IGZhbGxzCj4gPiA+ID4gPj4gdXBvbiB0aGUgb3JpZ2lu
YWwgaXNzdWVyIHRvIHBvbGwgdGhlc2UgcmVxdWVzdHMuCj4gPiA+ID4gPj4KPiA+ID4gPiA+PiBJ
IHRoaW5rIHRoaXMgc2hvdWxkIGJlIGEgc2VwYXJhdGUgY29tbWl0LCBjb21pbmcgYmVmb3JlIHRo
ZSBtYWluIGZpeAo+ID4gPiA+ID4+IHdoaWNoIGlzIGJlbG93Lgo+ID4gPiA+ID4KPiA+ID4gPiA+
IExvb2tzIGZpbmUsIGFjdHVhbGx5IElPX1VSSU5HX0ZfTk9OQkxPQ0sgY2hhbmdlIGlzbid0IGEg
bXVzdCwgYW5kIHRoZQo+ID4gPiA+ID4gYXBwcm9hY2ggaW4gVjIgZG9lc24ndCBuZWVkIHRoaXMg
Y2hhbmdlLgo+ID4gPiA+ID4KPiA+ID4gPiA+Pgo+ID4gPiA+ID4+PiBAQCAtMzM2Myw2ICszMzY3
LDEyIEBAIF9fY29sZCB2b2lkIGlvX3VyaW5nX2NhbmNlbF9nZW5lcmljKGJvb2wgY2FuY2VsX2Fs
bCwgc3RydWN0IGlvX3NxX2RhdGEgKnNxZCkKPiA+ID4gPiA+Pj4gICAgICAgICAgIGZpbmlzaF93
YWl0KCZ0Y3R4LT53YWl0LCAmd2FpdCk7Cj4gPiA+ID4gPj4+ICAgfSB3aGlsZSAoMSk7Cj4gPiA+
ID4gPj4+Cj4gPiA+ID4gPj4+ICsgLyoKPiA+ID4gPiA+Pj4gKyAgKiBSZWFwIGV2ZW50cyBmcm9t
IGVhY2ggY3R4LCBvdGhlcndpc2UgdGhlc2UgcmVxdWVzdHMgbWF5IHRha2UKPiA+ID4gPiA+Pj4g
KyAgKiByZXNvdXJjZXMgYW5kIHByZXZlbnQgb3RoZXIgY29udGV4dHMgZnJvbSBiZWluZyBtb3Zl
ZCBvbi4KPiA+ID4gPiA+Pj4gKyAgKi8KPiA+ID4gPiA+Pj4gKyB4YV9mb3JfZWFjaCgmdGN0eC0+
eGEsIGluZGV4LCBub2RlKQo+ID4gPiA+ID4+PiArICAgICAgICAgaW9faW9wb2xsX3RyeV9yZWFw
X2V2ZW50cyhub2RlLT5jdHgpOwo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gVGhlIG1haW4gaXNzdWUg
aGVyZSBpcyB0aGF0IGlmIHNvbWVvbmUgaXNuJ3QgcG9sbGluZyBmb3IgdGhlbSwgdGhlbiB3ZQo+
ID4gPiA+ID4KPiA+ID4gPiA+IFRoYXQgaXMgYWN0dWFsbHkgd2hhdCB0aGlzIHBhdGNoIGlzIGFk
ZHJlc3NpbmcsIDotKQo+ID4gPiA+Cj4gPiA+ID4gUmlnaHQsIHRoYXQgcGFydCBpcyBvYnZpb3Vz
IDopCj4gPiA+ID4KPiA+ID4gPiA+PiBnZXQgdG8gd2FpdCBmb3IgYSB0aW1lb3V0IGJlZm9yZSB0
aGV5IGNvbXBsZXRlLiBUaGlzIGNhbiBkZWxheSBleGl0LCBmb3IKPiA+ID4gPiA+PiBleGFtcGxl
LCBhcyB3ZSdyZSBub3cganVzdCB3YWl0aW5nIDMwIHNlY29uZHMgKG9yIHdoYXRldmVyIHRoZSB0
aW1lb3V0Cj4gPiA+ID4gPj4gaXMgb24gdGhlIHVuZGVybHlpbmcgZGV2aWNlKSBmb3IgdGhlbSB0
byBnZXQgdGltZWQgb3V0IGJlZm9yZSBleGl0IGNhbgo+ID4gPiA+ID4+IGZpbmlzaC4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBGb3IgdGhlIGlzc3VlIG9uIG51bGxfYmxrLCBkZXZpY2UgdGltZW91dCBo
YW5kbGVyIHByb3ZpZGVzCj4gPiA+ID4gPiBmb3J3YXJkLXByb2dyZXNzLCBzdWNoIGFzIHJlcXVl
c3RzIGFyZSByZWxlYXNlZCwgc28gbmV3IElPIGNhbiBiZQo+ID4gPiA+ID4gaGFuZGxlZC4KPiA+
ID4gPiA+Cj4gPiA+ID4gPiBIb3dldmVyLCBub3QgYWxsIGRldmljZXMgc3VwcG9ydCB0aW1lb3V0
LCBzdWNoIGFzIHZpcnRpbyBkZXZpY2UuCj4gPiA+ID4KPiA+ID4gPiBUaGF0J3MgYSBidWcgaW4g
dGhlIGRyaXZlciwgeW91IGNhbm5vdCBzYW5lbHkgc3VwcG9ydCBwb2xsZWQgSU8gYW5kIG5vdAo+
ID4gPiA+IGJlIGFibGUgdG8gZGVhbCB3aXRoIHRpbWVvdXRzLiBTb21lb25lIEhBUyB0byByZWFw
IHRoZSByZXF1ZXN0cyBhbmQKPiA+ID4gPiB0aGVyZSBhcmUgb25seSB0d28gdGhpbmdzIHRoYXQg
Y2FuIGRvIHRoYXQgLSB0aGUgYXBwbGljYXRpb24gZG9pbmcgdGhlCj4gPiA+ID4gcG9sbGVkIElP
LCBvciBpZiB0aGF0IGRvZXNuJ3QgaGFwcGVuLCBhIHRpbWVvdXQuCj4gPiA+Cj4gPiA+IE9LLCB0
aGVuIGRldmljZSBkcml2ZXIgdGltZW91dCBoYW5kbGVyIGhhcyBuZXcgcmVzcG9uc2liaWxpdHkg
b2YgY292ZXJpbmcKPiA+ID4gdXNlcnNwYWNlIGFjY2lkZW50LCA6LSkKPiAKPiBTb3JyeSwgSSBk
b24ndCBoYXZlIGVub3VnaCBjb250ZXh0IHNvIHRoaXMgaXMgcHJvYmFibHkgYSBzaWxseSBxdWVz
dGlvbjoKPiAKPiBXaGVuIGFuIGFwcGxpY2F0aW9uIGRvZXNuJ3QgcmVhcCBhIHBvbGxlZCByZXF1
ZXN0LCB3aHkgZG9lc24ndCB0aGUgYmxvY2sKPiBsYXllciB0YWtlIGNhcmUgb2YgdGhpcyBpbiBh
IGdlbmVyaWMgd2F5PyBJIGRvbid0IHNlZSBhbnl0aGluZwo+IGRyaXZlci1zcGVjaWZpYyBhYm91
dCB0aGlzLgoKYmxvY2sgbGF5ZXIgZG9lc24ndCBoYXZlIGtub3dsZWRnZSB0byBoYW5kbGUgdGhh
dCwgaW9fdXJpbmcga25vd3MgdGhlCmFwcGxpY2F0aW9uIGlzIGV4aXRpbmcsIGFuZCBjYW4gaGVs
cCB0byByZWFwIHRoZSBldmVudHMuCgpCdXQgdGhlIGJpZyBxdWVzdGlvbiBpcyB0aGF0IGlmIHRo
ZXJlIGlzIHJlYWxseSBJTyB0aW1lb3V0IGZvciB2aXJ0aW8tYmxrLgpJZiB0aGVyZSBpcywgdGhl
IHJlYXAgZG9uZSBpbiBpb191cmluZyBtYXkgbmV2ZXIgcmV0dXJuIGFuZCBjYXVzZSBvdGhlcgpp
c3N1ZSwgc28gaWYgaXQgaXMgZG9uZSBpbiBpb191cmluZywgdGhhdCBjYW4gYmUganVzdCB0aG91
Z2h0IGFzIHNvcnQgb2YKaW1wcm92ZW1lbnQuCgpUaGUgcmVhbCBidWcgZml4IGlzIHN0aWxsIGlu
IGRldmljZSBkcml2ZXIsIHVzdWFsbHkgb25seSB0aGUgZHJpdmVyIHRpbWVvdXQKaGFuZGxlciBj
YW4gcHJvdmlkZSBmb3J3YXJkIHByb2dyZXNzIGd1YXJhbnRlZS4KCj4gCj4gRHJpdmVyLXNwZWNp
ZmljIGJlaGF2aW9yIHdvdWxkIGJlIHNlbmRpbmcgYW4gYWJvcnQvY2FuY2VsIHVwb24gdGltZW91
dC4KPiB2aXJ0aW8tYmxrIGNhbm5vdCBkbyB0aGF0IGJlY2F1c2UgdGhlcmUgaXMgbm8gc3VjaCBj
b21tYW5kIGluIHRoZSBkZXZpY2UKPiBzcGVjaWZpY2F0aW9uIGF0IHRoZSBtb21lbnQuIFNvIHNp
bXBseSB3YWl0aW5nIGZvciB0aGUgcG9sbGVkIHJlcXVlc3QgdG8KPiBjb21wbGV0ZSBpcyB0aGUg
b25seSB0aGluZyB0aGF0IGNhbiBiZSBkb25lIChhc2lkZSBmcm9tIHJlc2V0dGluZyB0aGUKPiBk
ZXZpY2UpLCBhbmQgaXQncyBnZW5lcmljIGJlaGF2aW9yLgoKVGhlbiBsb29rcyBub3Qgc2FmZSB0
byBzdXBwb3J0IElPIHBvbGxpbmcgZm9yIHZpcnRpby1ibGssIG1heWJlIGRpc2FibGUgaXQKYXQg
ZGVmYXVsdCBub3cgdW50aWwgdGhlIHZpcnRpby1ibGsgc3BlYyBzdGFydHMgdG8gc3VwcG9ydCBJ
TyBhYm9ydD8KClRoYW5rcywKTWluZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
