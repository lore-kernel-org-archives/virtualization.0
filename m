Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA8C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:15:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE4164E4B
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE4164E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E45F8671F;
	Wed, 10 Feb 2021 04:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NtFHmzXuVEO; Wed, 10 Feb 2021 04:15:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D74B864E0;
	Wed, 10 Feb 2021 04:15:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 376EFC0174;
	Wed, 10 Feb 2021 04:15:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E84CC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 17C3B86501
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DcOPFFaNPcVY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16F43864E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612930548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWkZGceImgODZQt4JilFUnzdPSObR5bScucQBFdzS90=;
 b=Mses/uAFiymxkOihHOsRJUeXGyT4lOwzcrZN3rjVJW5MVjCcwd7a2Fb27ufBYhsCPH6i6H
 Q8uzqoFVbHGjEuIgoh1o5Ywr3g4SYwHVHS+8TRHE3cezaTbacmOv2f5klOgM2vdOrLfo30
 GG62/AXHDfWYwqOx+6juCeuAkmXWU/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-uHbe-3d8PpiZJtK2MnObKQ-1; Tue, 09 Feb 2021 23:15:46 -0500
X-MC-Unique: uHbe-3d8PpiZJtK2MnObKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2B72801962;
 Wed, 10 Feb 2021 04:15:44 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC00D60C4D;
 Wed, 10 Feb 2021 04:15:38 +0000 (UTC)
Subject: Re: [PATCH RFC v2 3/4] virtio-net: support transmit timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <20210208185558.995292-4-willemdebruijn.kernel@gmail.com>
 <6bfdf48d-c780-bc65-b0b9-24a33f18827b@redhat.com>
 <20210209113643-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lw7LKypTLEfQmcqR9SwcL6f9wH=_yjQdyGak4ORegRug@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af5b16fb-8b22-f081-3aa0-92839b7153d6@redhat.com>
Date: Wed, 10 Feb 2021 12:15:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-Lw7LKypTLEfQmcqR9SwcL6f9wH=_yjQdyGak4ORegRug@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemb@google.com>,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8xMCDkuIrljYgxMDozNiwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBPbiBU
dWUsIEZlYiA5LCAyMDIxIGF0IDExOjM5IEFNIE1pY2hhZWwgUy4gVHNpcmtpbjxtc3RAcmVkaGF0
LmNvbT4gIHdyb3RlOgo+PiBPbiBUdWUsIEZlYiAwOSwgMjAyMSBhdCAwMTo0NToxMVBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24gMjAyMS8yLzkg5LiK5Y2IMjo1NSwgV2lsbGVtIGRl
IEJydWlqbiB3cm90ZToKPj4+PiBGcm9tOiBXaWxsZW0gZGUgQnJ1aWpuPHdpbGxlbWJAZ29vZ2xl
LmNvbT4KPj4+Pgo+Pj4+IEFkZCBvcHRpb25hbCBQVFAgaGFyZHdhcmUgdHggdGltZXN0YW1wIG9m
ZmxvYWQgZm9yIHZpcnRpby1uZXQuCj4+Pj4KPj4+PiBBY2N1cmF0ZSBSVFQgbWVhc3VyZW1lbnQg
cmVxdWlyZXMgdGltZXN0YW1wcyBjbG9zZSB0byB0aGUgd2lyZS4KPj4+PiBJbnRyb2R1Y2Ugdmly
dGlvIGZlYXR1cmUgVklSVElPX05FVF9GX1RYX1RTVEFNUCwgdGhlIHRyYW5zbWl0Cj4+Pj4gZXF1
aXZhbGVudCB0byBWSVJUSU9fTkVUX0ZfUlhfVFNUQU1QLgo+Pj4+Cj4+Pj4gVGhlIGRyaXZlciBz
ZXRzIFZJUlRJT19ORVRfSERSX0ZfVFNUQU1QIHRvIHJlcXVlc3QgYSB0aW1lc3RhbXAKPj4+PiBy
ZXR1cm5lZCBvbiBjb21wbGV0aW9uLiBJZiB0aGUgZmVhdHVyZSBpcyBuZWdvdGlhdGVkLCB0aGUg
ZGV2aWNlCj4+Pj4gZWl0aGVyIHBsYWNlcyB0aGUgdGltZXN0YW1wIG9yIGNsZWFycyB0aGUgZmVh
dHVyZSBiaXQuCj4+Pj4KPj4+PiBUaGUgdGltZXN0YW1wIHN0cmFkZGxlcyAodmlydHVhbCkgaGFy
ZHdhcmUgZG9tYWlucy4gTGlrZSBQVFAsIHVzZQo+Pj4+IGludGVybmF0aW9uYWwgYXRvbWljIHRp
bWUgKENMT0NLX1RBSSkgYXMgZ2xvYmFsIGNsb2NrIGJhc2UuIFRoZSBkcml2ZXIKPj4+PiBtdXN0
IHN5bmMgd2l0aCB0aGUgZGV2aWNlLCBlLmcuLCB0aHJvdWdoIGt2bS1jbG9jay4KPj4+Pgo+Pj4+
IE1vZGlmeSBjYW5fcHVzaCB0byBlbnN1cmUgdGhhdCBvbiB0eCBjb21wbGV0aW9uIHRoZSBoZWFk
ZXIsIGFuZCB0aHVzCj4+Pj4gdGltZXN0YW1wLCBpcyBpbiBhIHByZWRpY2F0YWJsZSBsb2NhdGlv
biBhdCBza2Jfdm5ldF9oZHIuCj4+Pj4KPj4+PiBSRkM6IHRoaXMgaW1wbGVtZW50YXRpb24gcmVs
aWVzIG9uIHRoZSBkZXZpY2Ugd3JpdGluZyB0byB0aGUgYnVmZmVyLgo+Pj4+IFRoYXQgYnJlYWtz
IERNQV9UT19ERVZJQ0Ugc2VtYW50aWNzLiBGb3Igbm93LCBkaXNhYmxlIHdoZW4gRE1BIGlzIG9u
Lgo+Pj4+IFRoZSB2aXJ0aW8gY2hhbmdlcyBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCBhdCB0
aGUgbGVhc3QuCj4+Pj4KPj4+PiBUZXN0ZWQ6IG1vZGlmaWVkIHR4dGltZXN0YW1wLmMgdG8gd2l0
aCBoL3cgdGltZXN0YW1waW5nOgo+Pj4+ICAgICAtICAgICAgIHNvY2tfb3B0ID0gU09GX1RJTUVT
VEFNUElOR19TT0ZUV0FSRSB8Cj4+Pj4gICAgICsgICAgICAgc29ja19vcHQgPSBTT0ZfVElNRVNU
QU1QSU5HX1JBV19IQVJEV0FSRSB8Cj4+Pj4gICAgICsgZG9fdGVzdChmYW1pbHksIFNPRl9USU1F
U1RBTVBJTkdfVFhfSEFSRFdBUkUpOwo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogV2lsbGVtIGRl
IEJydWlqbjx3aWxsZW1iQGdvb2dsZS5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jICAgICAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LQo+Pj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgICAgfCAgMyArLQo+Pj4+ICAg
IGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAgfCAgMSArCj4+Pj4gICAgaW5jbHVkZS91
YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCB8ICAxICsKPj4+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDU2
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+IGlu
ZGV4IGFjNDRjNWVmYTBiYy4uZmM4ZWNkM2EzMzNhIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+
IEBAIC0yMTAsNiArMjEwLDEyIEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+Pj4+ICAgICAgLyog
RGV2aWNlIHdpbGwgcGFzcyByeCB0aW1lc3RhbXAuIFJlcXVpcmVzIGhhc19yeF90c3RhbXAgKi8K
Pj4+PiAgICAgIGJvb2wgZW5hYmxlX3J4X3RzdGFtcDsKPj4+PiArICAgLyogRGV2aWNlIGNhbiBw
YXNzIENMT0NLX1RBSSB0cmFuc21pdCB0aW1lIHRvIHRoZSBkcml2ZXIgKi8KPj4+PiArICAgYm9v
bCBoYXNfdHhfdHN0YW1wOwo+Pj4+ICsKPj4+PiArICAgLyogRGV2aWNlIHdpbGwgcGFzcyB0eCB0
aW1lc3RhbXAuIFJlcXVpcmVzIGhhc190eF90c3RhbXAgKi8KPj4+PiArICAgYm9vbCBlbmFibGVf
dHhfdHN0YW1wOwo+Pj4+ICsKPj4+PiAgICAgIC8qIEhhcyBjb250cm9sIHZpcnRxdWV1ZSAqLwo+
Pj4+ICAgICAgYm9vbCBoYXNfY3ZxOwo+Pj4+IEBAIC0xNDAxLDYgKzE0MDcsMjAgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3JlY2VpdmUoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLCBpbnQgYnVkZ2V0
LAo+Pj4+ICAgICAgcmV0dXJuIHN0YXRzLnBhY2tldHM7Cj4+Pj4gICAgfQo+Pj4+ICtzdGF0aWMg
dm9pZCB2aXJ0bmV0X3JlY29yZF90eF90c3RhbXAoY29uc3Qgc3RydWN0IHNlbmRfcXVldWUgKnNx
LAo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpz
a2IpCj4+Pj4gK3sKPj4+PiArICAgY29uc3Qgc3RydWN0IHZpcnRpb19uZXRfaGRyX2hhc2hfdHMg
KmggPSBza2Jfdm5ldF9oZHJfaHQoc2tiKTsKPj4+PiArICAgY29uc3Qgc3RydWN0IHZpcnRuZXRf
aW5mbyAqdmkgPSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4+Pj4gKyAgIHN0cnVjdCBza2Jfc2hhcmVk
X2h3dHN0YW1wcyB0czsKPj4+PiArCj4+Pj4gKyAgIGlmIChoLT5oZHIuZmxhZ3MgJiBWSVJUSU9f
TkVUX0hEUl9GX1RTVEFNUCAmJgo+Pj4+ICsgICAgICAgdmktPmVuYWJsZV90eF90c3RhbXApIHsK
Pj4+PiArICAgICAgICAgICB0cy5od3RzdGFtcCA9IG5zX3RvX2t0aW1lKGxlNjRfdG9fY3B1KGgt
PnRzdGFtcCkpOwo+Pj4+ICsgICAgICAgICAgIHNrYl90c3RhbXBfdHgoc2tiLCAmdHMpOwo+Pj4g
VGhpcyBwcm9iYWJseSB3b24ndCB3b3JrIHNpbmNlIHRoZSBidWZmZXIgaXMgcmVhZC1vbmx5IGZy
b20gdGhlIGRldmljZS4gKFNlZQo+Pj4gdmlydHF1ZXVlX2FkZF9vdXRidWYoKSkuCj4+Pgo+Pj4g
QW5vdGhlciBpc3N1ZSB0aGF0IEkgdmFndWVseSByZW1lbWJlciB0aGF0IHRoZSB2aXJ0aW8gc3Bl
YyBmb3JiaWRzIG91dAo+Pj4gYnVmZmVyIGFmdGVyIGluIGJ1ZmZlci4KPj4gQm90aCBEcml2ZXIg
UmVxdWlyZW1lbnRzOiBNZXNzYWdlIEZyYW1pbmcgYW5kIERyaXZlciBSZXF1aXJlbWVudHM6IFNj
YXR0ZXItR2F0aGVyIFN1cHBvcnQKPj4gaGF2ZSB0aGlzIHN0YXRlbWVudDoKPj4KPj4gICAgICAg
ICAgVGhlIGRyaXZlciBNVVNUIHBsYWNlIGFueSBkZXZpY2Utd3JpdGFibGUgZGVzY3JpcHRvciBl
bGVtZW50cyBhZnRlciBhbnkgZGV2aWNlLXJlYWRhYmxlIGRlc2NyaXB0b3IgZWxlLQo+PiAgICAg
ICAgICBtZW50cy4KPj4KPj4KPj4gc2ltaWxhcmx5Cj4+Cj4+IERldmljZSBSZXF1aXJlbWVudHM6
IFRoZSBWaXJ0cXVldWUgRGVzY3JpcHRvciBUYWJsZQo+PiAgICAgICAgICBBIGRldmljZSBNVVNU
IE5PVCB3cml0ZSB0byBhIGRldmljZS1yZWFkYWJsZSBidWZmZXIsIGFuZCBhIGRldmljZSBTSE9V
TEQgTk9UIHJlYWQgYSBkZXZpY2Utd3JpdGFibGUKPj4gICAgICAgICAgYnVmZmVyLgo+IFRoYW5r
cy4gVGhhdCdzIGNsZWFyLiBTbyB0aGUgY2xlYW4gc29sdXRpb24gd291bGQgYmUgdG8gYWRkIGEK
PiBkZXZpY2Utd3JpdGFibGUgZGVzY3JpcHRvciBhZnRlciB0aGUgZXhpc3RpbmcgZGV2aWNlLXJl
YWRhYmxlIG9uZXMuCgoKSSB0aGluayBzbywgYnV0IGEgcXVlc3Rpb24gaXMgdGhlIGZvcm1hdCBm
b3IgdGhpcyB0YWlsZXIuIEkgdGhpbmsgaXQgCm1pZ2h0IGJlIGJldHRlciB0byBwb3N0IGEgc3Bl
YyBwYXRjaCB0byBkaXNjdXNzLgoKVGhhbmtzCgoKPgo+IEFuZCB0aGUgZGV2aWNlIG11c3QgYmUg
YXdhcmUgdGhhdCB0aGlzIGlzIHRvIHJldHVybiB0aGUgdHN0YW1wIG9ubHkuCj4gSW4gdGhlIGV4
YW1wbGUgaW1wbGVtZW50YXRpb24gb2Ygdmhvc3QsIGl0IGhhcyB0byBleGNsdWRlIHRoaXMgbGFz
dAo+IGRlc2NyaXB0b3IgZnJvbSB0aGUgbXNnLT5tc2dfaXRlciBpb3ZlYyBhcnJheSB3aXRoIHBh
Y2tldCBkYXRhCj4gaW5pdGlhbGl6ZWQgYXQgZ2V0X3R4X2J1ZnMvaW5pdF9pb3ZfaXRlci4KPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
