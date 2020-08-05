Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB8C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:13:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5D72177B
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 08:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7jS+4Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5D72177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FB2D877BF;
	Wed,  5 Aug 2020 08:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b6GG0QsfogBd; Wed,  5 Aug 2020 08:13:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52004877A8;
	Wed,  5 Aug 2020 08:13:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB12C0050;
	Wed,  5 Aug 2020 08:13:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66225C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EFB4A20337
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spYmRXTBSJ3C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:12:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 3F77E20115
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596615178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yx93n3fvknsCbsGgxpzpAFDzQVp4vq3Y5G/8h3L0gvs=;
 b=U7jS+4Ia/Tn9vGTYaF+PVK+BO0oVxcf3+VeuuNb5IgBSDXAk8sEDQjUvlI4TviujlHudWe
 QNESLlzlSodu3ukX1qoshs9sre06o98OIheMjuFn4Kbf8X1aPX3bmDNtqlQZTUvOewlBLn
 PSu0sCXub2gEpWrYgDyBCtIx20i2has=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ipkOzgpqOdyP_vp2LDShcA-1; Wed, 05 Aug 2020 04:12:55 -0400
X-MC-Unique: ipkOzgpqOdyP_vp2LDShcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 814D6800138;
 Wed,  5 Aug 2020 08:12:53 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1CC171769;
 Wed,  5 Aug 2020 08:12:47 +0000 (UTC)
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
To: Eli Cohen <eli@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804172726-mutt-send-email-mst@kernel.org>
 <20200805050105.GA5442@nps-server-21.mtl.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7b4b4944-9428-a6ca-8b94-69bfc2675286@redhat.com>
Date: Wed, 5 Aug 2020 16:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805050105.GA5442@nps-server-21.mtl.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: shahafs@mellanox.com, saeedm@mellanox.com, linux-kernel@vger.kernel.org,
 parav@mellanox.com, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC81IOS4i+WNiDE6MDEsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBUdWUsIEF1ZyAw
NCwgMjAyMCBhdCAwNToyOTowOVBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+
IE9uIFR1ZSwgQXVnIDA0LCAyMDIwIGF0IDA3OjIwOjM2UE0gKzAzMDAsIEVsaSBDb2hlbiB3cm90
ZToKPj4+IEhpIE1pY2hhZWwsCj4+PiBwbGVhc2Ugbm90ZSB0aGF0IHRoaXMgc2VyaWVzIGRlcGVu
ZHMgb24gbWx4NSBjb3JlIGRldmljZSBkcml2ZXIgcGF0Y2hlcwo+Pj4gaW4gbWx4NS1uZXh0IGJy
YW5jaCBpbgo+Pj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L21lbGxhbm94L2xpbnV4LmdpdC4KPj4gVGhhbmtzISBPSyBzbyB3aGF0J3MgdGhlIHBsYW4gZm9y
IG1lcmdpbmcgdGhpcz8KPj4gRG8gcGF0Y2hlcyBhdCBsZWFzdCBidWlsZCB3ZWxsIGVub3VnaCB0
aGF0IEkgY2FuIHB1c2ggdGhlbQo+PiB1cHN0cmVhbT8gT3IgZG8gdGhleSBoYXZlIHRvIGdvIG9u
IHRvcCBvZiB0aGUgbWVsbGFub3ggdHJlZT8KPj4KPiBUaGUgcGF0Y2hlcyBhcmUgYnVpbHQgb24g
eW91ciBsaW51eC1uZXh0IGJyYW5jaCB3aGljaCBJIHVwZGF0ZWQKPiB5ZXN0ZXJkYXkuCj4KPiBJ
IGFtIGJhc2VkIG9uIHRoaXMgY29tbWl0Ogo+IDc3NmI3YjI1ZjEwYiAob3JpZ2luL2xpbnV4LW5l
eHQpIHZob3N0OiBhZGQgYW4gUlBNc2cgQVBJCj4KPiBPbiB0b3Agb2YgdGhhdCBJIG1lcmdlZAo+
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tZWxsYW5veC9s
aW51eC5naXQKPgo+IGFuZCBhZnRlciB0aGF0IEkgaGF2ZSBKYXNvbidzIHBhdGNoZXMgKGZpdmUg
cGF0Y2hlcyksIHRoYW4gb25lIHBhdGNoCj4gZnJvbSBNYXggYW5kIHRoZW4gbXkgcGF0Y2hlcyAo
c2V2ZW4pLgo+Cj4gSXQgYnVpbGRzIGZpbmUgb24geDg0XzY0Lgo+IEkgZml4ZWQgc29tZSBjb25m
bGljdHMgb24gSmFzb24ncyBwYXRjaGVzLgo+Cj4gSSBhbHNvIHRlc3RlZCBpdCB0byB2ZXJpZnkg
aXQncyB3b3JraW5nLgo+Cj4gQlRXLCBmb3Igc29tZSByZWFzb24gSSBkaWQgbm90IGdldCBhbGwg
dGhlIHBhdGNoZXMgaW50byBteSBtYWlsYm94IGFuZCBJCj4gc3VzcGVjdCB0aGV5IHdlcmUgbm90
IGFsbCBzZW50LiBEaWQgeW91IGdldCBhbGwgdGhlIHNlcmllcyAwLTEzPwoKCkkgY2FuIHNlZSBw
YXRjaCAwIHRvIHBhdGNoIDEyIGJ1dCBub3QgcGF0Y2ggMTMgKEkgZ3Vlc3MgMTIgaXMgYWxsKS4K
ClRoYW5rcwoKCj4KPiBQbGVhc2UgbGV0IG1lIGtub3csIGFuZCBpZiBuZWVkZWQgSSdsbCByZXNl
bmQuCj4KPj4+IGdpdCBwdWxsIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9tZWxsYW5veC9saW51eC5naXQgbWx4NS1uZXh0Cj4+Pgo+Pj4gVGhleSBhbHNvIGRl
cGVuZCBKYXNvbiBXYW5nJ3MgcGF0Y2hlczogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8x
LzMwMQo+PiBUaGUgb25lcyB5b3UgaW5jbHVkZWQsIHJpZ2h0Pwo+Pgo+IFJpZ2h0Lgo+ICAgCj4+
PiBKYXNvbiwgSSBoYWQgdG8gcmVzb2x2ZSBzb21lIGNvbmZsaWN0cyBzbyBJIHdvdWxkIGFwcHJl
Y2lhdGUgb2YgeW91IGNhbiB2ZXJpZnkKPj4+IHRoYXQgaXQgaXMgb2suCj4+Pgo+Pj4gVGhlIGZv
bGxvd2luZyBzZXJpZXMgb2YgcGF0Y2hlcyBwcm92aWRlIFZEUEEgc3VwcG9ydCBmb3IgTWVsbGFu
b3gKPj4+IGRldmljZXMuIFRoZSBzdXBwb3J0ZWQgZGV2aWNlcyBhcmUgQ29ubmVjdFg2IERYIGFu
ZCBuZXdlci4KPj4+Cj4+PiBDdXJyZW50bHksIG9ubHkgYSBuZXR3b3JrIGRyaXZlciBpcyBpbXBs
ZW1lbnRlZDsgZnV0dXJlIHBhdGNoZXMgd2lsbAo+Pj4gaW50cm9kdWNlIGEgYmxvY2sgZGV2aWNl
IGRyaXZlci4gaXBlcmYgcGVyZm9ybWFuY2Ugb24gYSBzaW5nbGUgcXVldWUgaXMKPj4+IGFyb3Vu
ZCAxMiBHYnBzLiAgRnV0dXJlIHBhdGNoZXMgd2lsbCBpbnRyb2R1Y2UgbXVsdGkgcXVldWUgc3Vw
cG9ydC4KPj4+Cj4+PiBUaGUgZmlsZXMgYXJlIG9yZ2FuaXplZCBpbiBzdWNoIGEgd2F5IHRoYXQg
Y29kZSB0aGF0IGNhbiBiZSB1c2VkIGJ5Cj4+PiBkaWZmZXJlbnQgVkRQQSBpbXBsZW1lbnRhdGlv
bnMgd2lsbCBiZSBwbGFjZWQgaW4gYSBjb21tb24gYXJlIHJlc2lkZXMgaW4KPj4+IGRyaXZlcnMv
dmRwYS9tbHg1L2NvcmUuCj4+Pgo+Pj4gT25seSB2aXJ0dWFsIGZ1bmN0aW9ucyBhcmUgY3VycmVu
dGx5IHN1cHBvcnRlZC4gQWxzbywgY2VydGFpbiBmaXJtd2FyZQo+Pj4gY2FwYWJpbGl0aWVzIG11
c3QgYmUgc2V0IHRvIGVuYWJsZSB0aGUgZHJpdmVyLiBQaHlzaWNhbCBmdW5jdGlvbnMgKFBGcykK
Pj4+IGFyZSBza2lwcGVkIGJ5IHRoZSBkcml2ZXIuCj4+Pgo+Pj4gVG8gbWFrZSB1c2Ugb2YgdGhl
IFZEUEEgbmV0IGRyaXZlciwgb25lIG11c3QgbG9hZCBtbHg1X3ZkcGEuIEluIHN1Y2gKPj4+IGNh
c2UsIFZGcyB3aWxsIGJlIG9wZXJhdGVkIGJ5IHRoZSBWRFBBIGRyaXZlci4gQWx0aG91Z2ggb25l
IGNhbiBzZWUgYQo+Pj4gcmVndWxhciBpbnN0YW5jZSBvZiBhIG5ldHdvcmsgZHJpdmVyIG9uIHRo
ZSBWRiwgdGhlIFZEUEEgZHJpdmVyIHRha2VzCj4+PiBwcmVjZWRlbmNlIG92ZXIgdGhlIE5JQyBk
cml2ZXIsIHN0ZWVyaW5nLXdpemUuCj4+Pgo+Pj4gQ3VycmVudGx5LCB0aGUgZGV2aWNlL2ludGVy
ZmFjZSBpbmZyYXN0cnVjdHVyZSBpbiBtbHg1X2NvcmUgaXMgdXNlZCB0bwo+Pj4gcHJvYmUgZHJp
dmVycy4gRnV0dXJlIHBhdGNoZXMgd2lsbCBpbnRyb2R1Y2UgdmlydGJ1cyBhcyBhIG1lYW5zIHRv
Cj4+PiByZWdpc3RlciBkZXZpY2VzIGFuZCBkcml2ZXJzIGFuZCBWRFBBIHdpbGwgYmUgYWRhcHRl
ZCB0byBpdC4KPj4+Cj4+PiBUaGUgbWx4NSBtb2RlIG9mIG9wZXJhdGlvbiByZXF1aXJlZCB0byBz
dXBwb3J0IFZEUEEgaXMgc3dpdGNoZGV2IG1vZGUuCj4+PiBPbmNlIGNhbiB1c2UgTGludXggb3Ig
T1ZTIGJyaWRnZSB0byB0YWtlIGNhcmUgb2YgbGF5ZXIgMiBzd2l0Y2hpbmcuCj4+Pgo+Pj4gSW4g
b3JkZXIgdG8gcHJvdmlkZSB2aXJ0aW8gbmV0d29ya2luZyB0byBhIGd1ZXN0LCBhbiB1cGRhdGVk
IHZlcnNpb24gb2YKPj4+IHFlbXUgaXMgcmVxdWlyZWQuIFRoaXMgdmVyc2lvbiBoYXMgYmVlbiB0
ZXN0ZWQgYnkgdGhlIGZvbGxvd2luZyBxdWVtdQo+Pj4gdmVyc2lvbjoKPj4+Cj4+PiB1cmw6IGh0
dHBzOi8vZ2l0aHViLmNvbS9qYXNvd2FuZy9xZW11LmdpdAo+Pj4gYnJhbmNoOiB2ZHBhCj4+PiBD
b21taXQgSUQ6IDZmNGU1OWI4MDdkYgo+Pj4KPj4+Cj4+PiBWMi0+VjMKPj4+IEZpeCBtYWtlZmls
ZSB0byB1c2UgaW5jbHVkZSBwYXRoIHJlbGF0aXZlIHRvIHRoZSByb290IG9mIHRoZSBrZXJuZWwK
Pj4+Cj4+PiBWMy1WNAo+Pj4gUmViYXNlIEphc29uJ3MgcGF0Y2hlcyBvbiBsaW51eC1uZXh0IGJy
YW5jaAo+Pj4gRml4IGtyb2JvdCBlcnJvciBvbiBtaXBzIGFyY2gKPj4+IE1ha2UgdXNlIG9mIHRo
ZSBmcmVlIGNhbGxiYWNrIHRvIGRlc3Ryb3kgcmVzb3J1Y2VzIG9uIHVubG9hZAo+Pj4gVXNlIFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSBpbnN0ZWFkIG9mIGxlZ2FjeSBWSVJUSU9fRl9JT01NVV9Q
TEFURk9STQo+Pj4gQWRkIGVtcHR5IGltcGxlbWVudGF0aW9ucyBmb3IgZ2V0X3ZxX25vdGlmaWNh
dGlvbigpIGFuZCBnZXRfdnFfaXJxKCkKPj4+Cj4+Pgo+Pj4gRWxpIENvaGVuICg2KToKPj4+ICAg
IG5ldC92ZHBhOiBVc2Ugc3RydWN0IGZvciBzZXQvZ2V0IHZxIHN0YXRlCj4+PiAgICB2ZHBhOiBN
b2RpZnkgZ2V0X3ZxX3N0YXRlKCkgdG8gcmV0dXJuIGVycm9yIGNvZGUKPj4+ICAgIHZkcGEvbWx4
NTogQWRkIGhhcmR3YXJlIGRlc2NyaXB0aXZlIGhlYWRlciBmaWxlCj4+PiAgICB2ZHBhL21seDU6
IEFkZCBzdXBwb3J0IGxpYnJhcnkgZm9yIG1seDUgVkRQQSBpbXBsZW1lbnRhdGlvbgo+Pj4gICAg
dmRwYS9tbHg1OiBBZGQgc2hhcmVkIG1lbW9yeSByZWdpc3RyYXRpb24gY29kZQo+Pj4gICAgdmRw
YS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMKPj4+Cj4+
PiBKYXNvbiBXYW5nICg1KToKPj4+ICAgIHZob3N0LXZkcGE6IHJlZmluZSBpb2N0bCBwcmUtcHJv
Y2Vzc2luZwo+Pj4gICAgdmhvc3Q6IGdlbmVyaWFsaXplIGJhY2tlbmQgZmVhdHVyZXMgc2V0dGlu
Zy9nZXR0aW5nCj4+PiAgICB2aG9zdC12ZHBhOiBzdXBwb3J0IGdldC9zZXQgYmFja2VuZCBmZWF0
dXJlcwo+Pj4gICAgdmhvc3QtdmRwYTogc3VwcG9ydCBJT1RMQiBiYXRjaGluZyBoaW50cwo+Pj4g
ICAgdmRwYXNpbTogc3VwcG9ydCBiYXRjaCB1cGRhdGluZwo+Pj4KPj4+IE1heCBHdXJ0b3ZveSAo
MSk6Cj4+PiAgICB2ZHBhOiByZW1vdmUgaGFyZCBjb2RlZCB2aXJ0cSBudW0KPj4+Cj4+PiAgIGRy
aXZlcnMvdmRwYS9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgICAxOSArCj4+PiAgIGRyaXZl
cnMvdmRwYS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAgMSArCj4+PiAgIGRyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgICAgICAgIHwgICAgNCArLQo+Pj4gICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5oICAgICAgICB8ICAgIDQgKy0KPj4+ICAgZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYyAgICAgICAgfCAgIDEzICstCj4+PiAgIGRyaXZlcnMvdmRwYS9t
bHg1L01ha2VmaWxlICAgICAgICAgICAgIHwgICAgNCArCj4+PiAgIGRyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbWx4NV92ZHBhLmggICAgIHwgICA5MSArKwo+Pj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21seDVfdmRwYV9pZmMuaCB8ICAxNjggKysKPj4+ICAgZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tci5jICAgICAgICAgICAgfCAgNDg0ICsrKysrKwo+Pj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL3Jlc291cmNlcy5jICAgICB8ICAyODQgKysrKwo+Pj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWFpbi5jICAgICAgICAgICB8ICAgNzYgKwo+Pj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgICAgICB8IDE5NjUgKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiAgIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuaCAgICAgIHwgICAyNCArCj4+PiAgIGRyaXZl
cnMvdmRwYS92ZHBhLmMgICAgICAgICAgICAgICAgICAgIHwgICAgMyArCj4+PiAgIGRyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICAgICAgIHwgICA1MyArLQo+Pj4gICBkcml2ZXJzL3Zo
b3N0L25ldC5jICAgICAgICAgICAgICAgICAgICB8ICAgMTggKy0KPj4+ICAgZHJpdmVycy92aG9z
dC92ZHBhLmMgICAgICAgICAgICAgICAgICAgfCAgIDc2ICstCj4+PiAgIGRyaXZlcnMvdmhvc3Qv
dmhvc3QuYyAgICAgICAgICAgICAgICAgIHwgICAxNSArCj4+PiAgIGRyaXZlcnMvdmhvc3Qvdmhv
c3QuaCAgICAgICAgICAgICAgICAgIHwgICAgMiArCj4+PiAgIGluY2x1ZGUvbGludXgvdmRwYS5o
ICAgICAgICAgICAgICAgICAgIHwgICAyNCArLQo+Pj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhv
c3QuaCAgICAgICAgICAgICB8ICAgIDIgKwo+Pj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3Rf
dHlwZXMuaCAgICAgICB8ICAgMTEgKwo+Pj4gICAyMiBmaWxlcyBjaGFuZ2VkLCAzMjg0IGluc2Vy
dGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy92ZHBhL21seDUvTWFrZWZpbGUKPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhX2lmYy5oCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tYWluLmMKPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5oCj4+Pgo+Pj4gLS0gCj4+PiAyLjI2LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
