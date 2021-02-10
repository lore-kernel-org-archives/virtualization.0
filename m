Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF2BC433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B8F64E45
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B8F64E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0819C6F51A
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xx7qrioyS3lA for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 04:11:04 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 68B8D6F566; Wed, 10 Feb 2021 04:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 595436F4FE;
	Wed, 10 Feb 2021 04:11:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38597C0891;
	Wed, 10 Feb 2021 04:11:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71168C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 65CCB86785
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xlYwov58A6uQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2C63986776
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612930256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nA99BmjpKt6+09OtQs5vZeW+xzoSp2W0CQzq7UWp6To=;
 b=RPR45mQ/6cNAmkpf21r4CrnlOdvzns7Mh8GilEW7XoNNB7xsyzZJ6dFkT9/XH+fdyG6i39
 5IKrpfAN5ZRhYCrM0JUmmFPl0qK7sWctJyhp4HKJzn7VBHUWsDnSqe62b6D+GMFlEgQNa3
 QVqWm7r0QyPoEZYm/BXuxMYJ+52/ofk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-hSdtbohNNJemIzmw3Q-KPw-1; Tue, 09 Feb 2021 23:10:55 -0500
X-MC-Unique: hSdtbohNNJemIzmw3Q-KPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A592D10066F1;
 Wed, 10 Feb 2021 04:10:53 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C45D60C05;
 Wed, 10 Feb 2021 04:10:48 +0000 (UTC)
Subject: Re: [PATCH RFC v2 2/4] virtio-net: support receive timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <20210208185558.995292-3-willemdebruijn.kernel@gmail.com>
 <c089cb3e-96cb-b42a-5ce1-d54d298987c4@redhat.com>
 <CAF=yD-Jkm-Cfs2tHKhC17KfPp+=18y=9_XSuY-LNgkC-2_NfLA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ed23e65-b6b9-c699-b9aa-69aaf07034d0@redhat.com>
Date: Wed, 10 Feb 2021 12:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-Jkm-Cfs2tHKhC17KfPp+=18y=9_XSuY-LNgkC-2_NfLA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Willem de Bruijn <willemb@google.com>,
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

Ck9uIDIwMjEvMi85IOS4i+WNiDk6NTMsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24gTW9u
LCBGZWIgOCwgMjAyMSBhdCAxMToxMyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzkg5LiK5Y2IMjo1NSwgV2lsbGVtIGRlIEJydWlqbiB3
cm90ZToKPj4+IEZyb206IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4KPj4+
Cj4+PiBBZGQgb3B0aW9uYWwgUFRQIGhhcmR3YXJlIHJ4IHRpbWVzdGFtcCBvZmZsb2FkIGZvciB2
aXJ0aW8tbmV0Lgo+Pj4KPj4+IEFjY3VyYXRlIFJUVCBtZWFzdXJlbWVudCByZXF1aXJlcyB0aW1l
c3RhbXBzIGNsb3NlIHRvIHRoZSB3aXJlLgo+Pj4gSW50cm9kdWNlIHZpcnRpbyBmZWF0dXJlIFZJ
UlRJT19ORVRfRl9SWF9UU1RBTVAuIElmIG5lZ290aWF0ZWQsIHRoZQo+Pj4gdmlydGlvLW5ldCBo
ZWFkZXIgaXMgZXhwYW5kZWQgd2l0aCByb29tIGZvciBhIHRpbWVzdGFtcC4KPj4+Cj4+PiBBIGRl
dmljZSBtYXkgcGFzcyByZWNlaXZlIHRpbWVzdGFtcHMgZm9yIGFsbCBvciBzb21lIHBhY2tldHMu
IEZsYWcKPj4+IFZJUlRJT19ORVRfSERSX0ZfVFNUQU1QIHNpZ25hbHMgd2hldGhlciBhIHRpbWVz
dGFtcCBpcyByZWNvcmRlZC4KPj4+Cj4+PiBBIGRyaXZlciB0aGF0IHN1cHBvcnRzIGhhcmR3YXJl
IHRpbWVzdGFtcGluZyBtdXN0IGFsc28gc3VwcG9ydAo+Pj4gaW9jdGwgU0lPQ1NIV1RTVEFNUC4g
SW1wbGVtZW50IHRoYXQsIGFzIHdlbGwgYXMgaW5mb3JtYXRpb24gZ2V0dGVycwo+Pj4gaW9jdGwg
U0lPQ0dIV1RTVEFNUCBhbmQgZXRodG9vbCBnZXRfdHNfaW5mbyAoYGV0aHRvb2wgLVQgJERFVmAp
Lgo+Pj4KPj4+IFRoZSB0aW1lc3RhbXAgc3RyYWRkbGVzICh2aXJ0dWFsKSBoYXJkd2FyZSBkb21h
aW5zLiBMaWtlIFBUUCwgdXNlCj4+PiBpbnRlcm5hdGlvbmFsIGF0b21pYyB0aW1lIChDTE9DS19U
QUkpIGFzIGdsb2JhbCBjbG9jayBiYXNlLiBUaGUgZHJpdmVyCj4+PiBtdXN0IHN5bmMgd2l0aCB0
aGUgZGV2aWNlLCBlLmcuLCB0aHJvdWdoIGt2bS1jbG9jay4KPj4+Cj4+PiBUZXN0ZWQ6Cj4+PiAg
ICAgZ3Vlc3Q6IC4vdGltZXN0YW1waW5nIGV0aDAgXAo+Pj4gICAgICAgICAgICAgU09GX1RJTUVT
VEFNUElOR19SQVdfSEFSRFdBUkUgXAo+Pj4gICAgICAgICAgICAgU09GX1RJTUVTVEFNUElOR19S
WF9IQVJEV0FSRQo+Pj4gICAgIGhvc3Q6IG5jIC00IC11IDE5Mi4xNjguMS4xIDMxOQo+Pj4KPj4+
IENoYW5nZXMgUkZDIC0+IFJGQ3YyCj4+PiAgICAgLSByZW5hbWUgdmlydGlvX25ldF9oZHJfdjEy
IHRvIHZpcnRpb19uZXRfaGRyX2hhc2hfdHMKPj4+ICAgICAtIGFkZCBldGh0b29sIC5nZXRfdHNf
aW5mbyB0byBxdWVyeSBjYXBhYmlsaXRpZXMKPj4+ICAgICAtIGFkZCBpb2N0bCBTSU9DW0dTXUhX
VFNUQU1QIHRvIGNvbmZpZ3VyZSBmZWF0dXJlCj4+PiAgICAgLSBhZGQgdmktPmVuYWJsZV9yeF90
c3RhbXAgdG8gc3RvcmUgY29uZmlndXJhdGlvbgo+Pj4gICAgIC0gY29udmVydCB2aXJ0aW9YWF90
b19jcHUgdG8gbGVYWF90b19jcHUKPj4+ICAgICAtIGNvbnZlcnQgcmVzZXJ2ZWQgdG8gX191MzIK
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdvb2dsZS5j
b20+Cj4+PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIHZpcnRuZXRfbmV0
ZGV2ID0gewo+Pj4gICAgICAgIC5uZG9fb3BlbiAgICAgICAgICAgID0gdmlydG5ldF9vcGVuLAo+
Pj4gICAgICAgIC5uZG9fc3RvcCAgICAgICAgICAgID0gdmlydG5ldF9jbG9zZSwKPj4+IEBAIC0y
NTczLDYgKzI2NzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzIHZpcnRu
ZXRfbmV0ZGV2ID0gewo+Pj4gICAgICAgIC5uZG9fZmVhdHVyZXNfY2hlY2sgICAgID0gcGFzc3Ro
cnVfZmVhdHVyZXNfY2hlY2ssCj4+PiAgICAgICAgLm5kb19nZXRfcGh5c19wb3J0X25hbWUgPSB2
aXJ0bmV0X2dldF9waHlzX3BvcnRfbmFtZSwKPj4+ICAgICAgICAubmRvX3NldF9mZWF0dXJlcyAg
ICAgICA9IHZpcnRuZXRfc2V0X2ZlYXR1cmVzLAo+Pj4gKyAgICAgLm5kb19kb19pb2N0bCAgICAg
ICAgICAgPSB2aXJ0bmV0X2lvY3RsLAo+Pj4gICAgfTsKPj4+Cj4+PiAgICBzdGF0aWMgdm9pZCB2
aXJ0bmV0X2NvbmZpZ19jaGFuZ2VkX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+Pj4g
QEAgLTMwNjksNiArMzE3MywxMSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYpCj4+PiAgICAgICAgICAgICAgICB2aS0+aGRyX2xlbiA9IHNpemVv
ZihzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCk7Cj4+PiAgICAgICAgfQo+Pj4KPj4+ICsg
ICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX1JYX1RTVEFNUCkp
IHsKPj4+ICsgICAgICAgICAgICAgdmktPmhhc19yeF90c3RhbXAgPSB0cnVlOwo+Pj4gKyAgICAg
ICAgICAgICB2aS0+aGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9oZHJfaGFzaF90
cyk7Cj4+Cj4+IERvZXMgdGhpcyBtZWFuIGV2ZW4gaWYgdGhlIGRldmljZSBkb2Vzbid0IHBhc3Mg
dGltZXN0YW1wLCB0aGUgaGVhZGVyCj4+IHN0aWxsIGNvbnRhaW5zIHRoZSB0aW1lc3RhbXAgZmll
bGRzLgo+IFllcy4gQXMgaW1wbGVtZW50ZWQsIHRoZSBzaXplIG9mIHRoZSBoZWFkZXIgaXMgY29u
c3RhbnQgYWNyb3NzCj4gcGFja2V0cy4gSWYgYm90aCBzaWRlcyBuZWdvdGlhdGUgdGhlIGZlYXR1
cmUsIHRoZW4gYWxsIGhlYWRlcnMgcmVzZXJ2ZQo+IHNwYWNlLCB3aGV0aGVyIG9yIG5vdCB0aGUg
c3BlY2lmaWMgcGFja2V0IGhhcyBhIHRpbWVzdGFtcC4KPgo+IFNvIGZhciBoZWFkZXJzIGFyZSBm
aXhlZCBzaXplLiBJIHN1cHBvc2Ugd2UgY291bGQgaW52ZXN0aWdhdGUgdmFyaWFibGUKPiBzaXpl
IGhlYWRlcnMuIFRoaXMgZ29lcyBiYWNrIHRvIG91ciBkaXNjdXNzaW9uIGluIHRoZSBwcmV2aW91
cwo+IHBhdGNoc2V0LCB0aGF0IHdlIGNhbiBhbHdheXMgYWRkIGEgcGFja2VkLWhlYWRlciBmZWF0
dXJlIGxhdGVyLCBpZiB0aGUKPiBudW1iZXIgb2Ygb3B0aW9uYWwgZmVhdHVyZXMgcmVhY2hlcyBh
IHNpemUgdGhhdCBtYWtlcyB0aGUgY29tcGxleGl0eQo+IHdvcnRod2hpbGUuCgoKUmlnaHQsIHNv
IGZvciB0aW1zdGFtcCBpdCdzIHByb2JhYmx5IE9LIGJ1dCB3ZSBwcm9iYWJseSBuZWVkIHRvIGRv
IGFzIAp5b3Ugc2FpZCBoZXJlIGlmIHdlIHdhbnQgdG8gYWRkIG1vcmUgaW4gdGhlIGhlYWRlci4g
TGV0J3Mgc2VlIGhvdyAKTWljaGFlbCB0aGluayBhYm91dCB0aGlzLgoKCj4KPj4+ICsgICAgIH0K
Pj4+ICsKPj4+ICAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX0FO
WV9MQVlPVVQpIHx8Cj4+PiAgICAgICAgICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fRl9WRVJTSU9OXzEpKQo+Pj4gICAgICAgICAgICAgICAgdmktPmFueV9oZWFkZXJfc2cgPSB0
cnVlOwo+Pj4gQEAgLTMyNjAsNyArMzM2OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydGlvX2Rldmlj
ZV9pZCBpZF90YWJsZVtdID0gewo+Pj4gICAgICAgIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERS
LCBcCj4+PiAgICAgICAgVklSVElPX05FVF9GX01UVSwgVklSVElPX05FVF9GX0NUUkxfR1VFU1Rf
T0ZGTE9BRFMsIFwKPj4+ICAgICAgICBWSVJUSU9fTkVUX0ZfU1BFRURfRFVQTEVYLCBWSVJUSU9f
TkVUX0ZfU1RBTkRCWSwgXAo+Pj4gLSAgICAgVklSVElPX05FVF9GX1RYX0hBU0gKPj4+ICsgICAg
IFZJUlRJT19ORVRfRl9UWF9IQVNILCBWSVJUSU9fTkVUX0ZfUlhfVFNUQU1QCj4+Pgo+Pj4gICAg
c3RhdGljIHVuc2lnbmVkIGludCBmZWF0dXJlc1tdID0gewo+Pj4gICAgICAgIFZJUlRORVRfRkVB
VFVSRVMsCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCBi
L2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPj4+IGluZGV4IDI3M2Q0M2MzNWY1OS4u
YTVjODQ0MTBjZjkyIDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19u
ZXQuaAo+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4gQEAgLTU3
LDYgKzU3LDcgQEAKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IFN0ZWVyaW5nICovCj4+PiAgICAjZGVmaW5lIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSIDIz
ICAgICAgIC8qIFNldCBNQUMgYWRkcmVzcyAqLwo+Pj4KPj4+ICsjZGVmaW5lIFZJUlRJT19ORVRf
Rl9SWF9UU1RBTVAgICAgICAgICA1NSAgICAvKiBEZXZpY2Ugc2VuZHMgVEFJIHJlY2VpdmUgdGlt
ZSAqLwo+Pj4gICAgI2RlZmluZSBWSVJUSU9fTkVUX0ZfVFhfSEFTSCAgICAgICAgICA1NiAgICAv
KiBEcml2ZXIgc2VuZHMgaGFzaCByZXBvcnQgKi8KPj4+ICAgICNkZWZpbmUgVklSVElPX05FVF9G
X0hBU0hfUkVQT1JUICA1NyAgICAgICAgLyogU3VwcG9ydHMgaGFzaCByZXBvcnQgKi8KPj4+ICAg
ICNkZWZpbmUgVklSVElPX05FVF9GX1JTUyAgICAgIDYwICAgIC8qIFN1cHBvcnRzIFJTUyBSWCBz
dGVlcmluZyAqLwo+Pj4gQEAgLTEyNiw2ICsxMjcsNyBAQCBzdHJ1Y3QgdmlydGlvX25ldF9oZHJf
djEgewo+Pj4gICAgI2RlZmluZSBWSVJUSU9fTkVUX0hEUl9GX05FRURTX0NTVU0gMSAgICAgICAv
KiBVc2UgY3N1bV9zdGFydCwgY3N1bV9vZmZzZXQgKi8KPj4+ICAgICNkZWZpbmUgVklSVElPX05F
VF9IRFJfRl9EQVRBX1ZBTElEIDIgICAgICAgLyogQ3N1bSBpcyB2YWxpZCAqLwo+Pj4gICAgI2Rl
ZmluZSBWSVJUSU9fTkVUX0hEUl9GX1JTQ19JTkZPICAgNCAgICAgICAvKiByc2MgaW5mbyBpbiBj
c3VtXyBmaWVsZHMgKi8KPj4+ICsjZGVmaW5lIFZJUlRJT19ORVRfSERSX0ZfVFNUQU1QICAgICAg
ICAgICAgICA4ICAgICAgIC8qIHRpbWVzdGFtcCBpcyByZWNvcmRlZCAqLwo+Pj4gICAgICAgIF9f
dTggZmxhZ3M7Cj4+PiAgICAjZGVmaW5lIFZJUlRJT19ORVRfSERSX0dTT19OT05FICAgICAgICAg
ICAgIDAgICAgICAgLyogTm90IGEgR1NPIGZyYW1lICovCj4+PiAgICAjZGVmaW5lIFZJUlRJT19O
RVRfSERSX0dTT19UQ1BWNCAgICAxICAgICAgIC8qIEdTTyBmcmFtZSwgSVB2NCBUQ1AgKFRTTykg
Ki8KPj4+IEBAIC0xODEsNiArMTgzLDE3IEBAIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNo
IHsKPj4+ICAgICAgICB9Owo+Pj4gICAgfTsKPj4+Cj4+PiArc3RydWN0IHZpcnRpb19uZXRfaGRy
X2hhc2hfdHMgewo+Pj4gKyAgICAgc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxIGhkcjsKPj4+ICsg
ICAgIHN0cnVjdCB7Cj4+PiArICAgICAgICAgICAgIF9fbGUzMiB2YWx1ZTsKPj4+ICsgICAgICAg
ICAgICAgX19sZTE2IHJlcG9ydDsKPj4+ICsgICAgICAgICAgICAgX19sZTE2IGZsb3dfc3RhdGU7
Cj4+PiArICAgICB9IGhhc2g7Cj4+Cj4+IEFueSByZWFzb24gZm9yIG5vdCBlbWJlZGRpbmcgc3Ry
dWN0dXJlIHZpcnRpb19uZXRfaGRyX3YxX2hhc2g/Cj4gSnVzdCB0aGF0IGl0IGJlY29tZXMgYW4g
b25pb24gb2Ygc3RydWN0IGluc2lkZSBzdHJ1Y3RzLiBJIGNhbiBjaGFuZ2UKPiBpZiB5b3UgcHJl
ZmVyLgoKClllcyBwbGVhc2UgKHVubGVzcyBNaWNoYWVsIGhhcyBvdGhlciBvcGluaW9uKS4KCgo+
Cj4+IFRoYW5rcwo+IEFzIGFsd2F5cywgdGhhbmtzIGZvciByZXZpZXdpbmcsIEphc29uLgo+CgpZ
b3UncmUgd2VsY29tZSA6KQoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
