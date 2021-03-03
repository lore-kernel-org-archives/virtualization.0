Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A9AC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 08:29:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A0664ED9
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 08:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A0664ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD5B6FAD4;
	Wed,  3 Mar 2021 08:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hvqnsZjVIOIG; Wed,  3 Mar 2021 08:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84CB3605F6;
	Wed,  3 Mar 2021 08:29:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59D2CC000B;
	Wed,  3 Mar 2021 08:29:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 974D1C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FF59400A9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uFR9oEvdGrC7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:29:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26A474002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614760158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YtKbwEmP7H421NTmXaZCzpu8hrW/nWzRy135iMLmxUk=;
 b=hz/Vst5Le5DCmmcFr1aZDkbZ8nOf8ZC8nH/rDSswygNAU5PAPy4BnjS+ODBhWHgsrOm9bn
 qVri0lEJF3GrdiaGpXib7VD9Rp9XVSmbq28jH4JkvW8mExJM9pgnfd3txEweBx9sZjHSo+
 4Jsgw/q82pydIUgOs1/Fb/3hX5RqrvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-Qzbk6FMePyuxAZzVB2-Njw-1; Wed, 03 Mar 2021 03:29:16 -0500
X-MC-Unique: Qzbk6FMePyuxAZzVB2-Njw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93B7D80196C;
 Wed,  3 Mar 2021 08:29:14 +0000 (UTC)
Received: from gondolin (ovpn-113-85.ams2.redhat.com [10.36.113.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED0395C257;
 Wed,  3 Mar 2021 08:29:07 +0000 (UTC)
Date: Wed, 3 Mar 2021 09:29:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210303092905.677eb66c.cohuck@redhat.com>
In-Reply-To: <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
References: <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
 <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
 <20210228162306-mutt-send-email-mst@kernel.org>
 <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
 <20210302130812.6227f176.cohuck@redhat.com>
 <5f6972fe-7246-b622-958d-9cab8dd98e21@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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

T24gV2VkLCAzIE1hciAyMDIxIDEyOjAxOjAxICswODAwCkphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPiBPbiAyMDIxLzMvMiA4OjA4IOS4i+WNiCwgQ29ybmVsaWEgSHVj
ayB3cm90ZToKPiA+IE9uIE1vbiwgMSBNYXIgMjAyMSAxMTo1MTowOCArMDgwMAo+ID4gSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAgCj4gPj4gT24gMjAyMS8zLzEg
NToyNSDkuIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+ID4+PiBPbiBGcmksIEZl
YiAyNiwgMjAyMSBhdCAwNDoxOToxNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOiAgCj4gPj4+
PiBPbiAyMDIxLzIvMjYgMjo1MyDkuIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+
ID4+Pj4+IENvbmZ1c2VkLiBXaGF0IGlzIHdyb25nIHdpdGggdGhlIGFib3ZlPyBJdCBuZXZlciBy
ZWFkcyB0aGUKPiA+Pj4+PiBmaWVsZCB1bmxlc3MgdGhlIGZlYXR1cmUgaGFzIGJlZW4gb2ZmZXJl
ZCBieSBkZXZpY2UuICAKPiA+Pj4+IFNvIHRoZSBzcGVjIHNhaWQ6Cj4gPj4+Pgo+ID4+Pj4gIgo+
ID4+Pj4KPiA+Pj4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbWF4X3Zp
cnRxdWV1ZV9wYWlycyBvbmx5IGV4aXN0cyBpZgo+ID4+Pj4gVklSVElPX05FVF9GX01RIGlzIHNl
dC4KPiA+Pj4+Cj4gPj4+PiAiCj4gPj4+Pgo+ID4+Pj4gSWYgSSByZWFkIHRoaXMgY29ycmVjdGx5
LCB0aGVyZSB3aWxsIGJlIG5vIG1heF92aXJ0cXVldWVfcGFpcnMgZmllbGQgaWYgdGhlCj4gPj4+
PiBWSVJUSU9fTkVUX0ZfTVEgaXMgbm90IG9mZmVyZWQgYnkgZGV2aWNlPyBJZiB5ZXMgdGhlIG9m
ZnNldG9mKCkgdmlvbGF0ZXMKPiA+Pj4+IHdoYXQgc3BlYyBzYWlkLgo+ID4+Pj4KPiA+Pj4+IFRo
YW5rcyAgCj4gPj4+IEkgdGhpbmsgdGhhdCdzIGEgbWlzdW5kZXJzdGFuZGluZy4gVGhpcyB0ZXh0
IHdhcyBuZXZlciBpbnRlbmRlZCB0bwo+ID4+PiBpbXBseSB0aGF0IGZpZWxkIG9mZnNldHMgY2hh
bmdlIGJlYXNlZCBvbiBmZWF0dXJlIGJpdHMuCj4gPj4+IFdlIGhhZCB0aGlzIHBhaW4gd2l0aCBs
ZWdhY3kgYW5kIHdlIG5ldmVyIHdhbnRlZCB0byBnbyBiYWNrIHRoZXJlLgo+ID4+Pgo+ID4+PiBU
aGlzIG1lcmVseSBpbXBsaWVzIHRoYXQgd2l0aG91dCBWSVJUSU9fTkVUX0ZfTVEgdGhlIGZpZWxk
Cj4gPj4+IHNob3VsZCBub3QgYmUgYWNjZXNzZWQuIEV4aXN0cyBpbiB0aGUgc2Vuc2UgImlzIGFj
Y2Vzc2libGUgdG8gZHJpdmVyIi4KPiA+Pj4KPiA+Pj4gTGV0J3MganVzdCBjbGFyaWZ5IHRoYXQg
aW4gdGhlIHNwZWMsIGpvYiBkb25lLiAgCj4gPj4KPiA+PiBPaywgYWdyZWUuIFRoYXQgd2lsbCBt
YWtlIHRoaW5ncyBtb3JlIGVhaXNlci4gIAo+ID4gWWVzLCB0aGF0IG1ha2VzIG11Y2ggbW9yZSBz
ZW5zZS4KPiA+Cj4gPiBXaGF0IGFib3V0IGFkZGluZyB0aGUgZm9sbG93aW5nIHRvIHRoZSAiQmFz
aWMgRmFjaWxpdGllcyBvZiBhIFZpcnRpbwo+ID4gRGV2aWNlL0RldmljZSBDb25maWd1cmF0aW9u
IFNwYWNlIiBzZWN0aW9uIG9mIHRoZSBzcGVjOgo+ID4KPiA+ICJJZiBhbiBvcHRpb25hbCBjb25m
aWd1cmF0aW9uIGZpZWxkIGRvZXMgbm90IGV4aXN0LCB0aGUgY29ycmVzcG9uZGluZwo+ID4gc3Bh
Y2UgaXMgc3RpbGwgcHJlc2VudCwgYnV0IHJlc2VydmVkLiIgIAo+IAo+IAo+IFRoaXMgYmVjYW1l
IGludGVyZXN0aW5nIGFmdGVyIHJlLXJlYWRpbmcgc29tZSBvZiB0aGUgcWVtdSBjb2Rlcy4KPiAK
PiBFLmcgaW4gdmlydGlvLW5ldC5jIHdlIGhhZDoKPiAKPiAqc3RhdGljIFZpcnRJT0ZlYXR1cmUg
ZmVhdHVyZV9zaXplc1tdID0gewo+ICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05F
VF9GX01BQywKPiAgwqDCoMKgwqAgLmVuZCA9IGVuZG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZp
ZywgbWFjKX0sCj4gIMKgwqDCoCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfU1RBVFVT
LAo+ICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBzdGF0
dXMpfSwKPiAgwqDCoMKgIHsuZmxhZ3MgPSAxVUxMIDw8IFZJUlRJT19ORVRfRl9NUSwKPiAgwqDC
oMKgwqAgLmVuZCA9IGVuZG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgbWF4X3ZpcnRxdWV1
ZV9wYWlycyl9LAo+ICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElPX05FVF9GX01UVSwK
PiAgwqDCoMKgwqAgLmVuZCA9IGVuZG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywgbXR1KX0s
Cj4gIMKgwqDCoCB7LmZsYWdzID0gMVVMTCA8PCBWSVJUSU9fTkVUX0ZfU1BFRURfRFVQTEVYLAo+
ICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBkdXBsZXgp
fSwKPiAgwqDCoMKgIHsuZmxhZ3MgPSAoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfUlNTKSB8ICgxVUxM
IDw8IAo+IFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCksCj4gIMKgwqDCoMKgIC5lbmQgPSBlbmRv
ZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIHN1cHBvcnRlZF9oYXNoX3R5cGVzKX0sCj4gIMKg
wqDCoCB7fQo+IH07Kgo+IAo+ICpJdCBoYXMgYSBpbXBsaWN0IGRlcGVuZGVuY3kgY2hhaW4uIEUu
ZyBNVFUgZG9lc24ndCBwcmVzbmV0IGlmIAo+IERVUExFWC9SU1MgaXMgbm90IG9mZmVyZWQgLi4u
Cj4gKgoKQnV0IEkgdGhpbmsgaXQgY292ZXJzIGV2ZXJ5dGhpbmcgdXAgdG8gdGhlIHJlbGV2YW50
IGZpZWxkLCBubz8gU28gTVRVCmlzIGluY2x1ZGVkIGlmIHdlIGhhdmUgdGhlIGZlYXR1cmUgYml0
LCBldmVuIGlmIHdlIGRvbid0IGhhdmUKRFVQTEVYL1JTUy4KCkdpdmVuIHRoYXQgYSBjb25maWcg
c3BhY2UgbWF5IGJlIHNob3J0ZXIgKGJ1dCBtdXN0IG5vdCBjb2xsYXBzZQpub24tZXhpc3Rpbmcg
ZmllbGRzKSwgbWF5YmUgYSBiZXR0ZXIgd29yZGluZyB3b3VsZCBiZToKCiJJZiBhbiBvcHRpb25h
bCBjb25maWd1cmF0aW9uIGZpZWxkIGRvZXMgbm90IGV4aXN0LCB0aGUgY29ycmVzcG9uZGluZwpz
cGFjZSB3aWxsIHN0aWxsIGJlIHByZXNlbnQgaWYgaXQgaXMgbm90IGF0IHRoZSBlbmQgb2YgdGhl
CmNvbmZpZ3VyYXRpb24gc3BhY2UgKGkuZS4sIGZ1cnRoZXIgY29uZmlndXJhdGlvbiBmaWVsZHMg
ZXhpc3QuKSBUaGlzCmltcGxpZXMgdGhhdCBhIGdpdmVuIGZpZWxkLCBpZiBpdCBleGlzdHMsIGlz
IGFsd2F5cyBhdCB0aGUgc2FtZSBvZmZzZXQKZnJvbSB0aGUgYmVnaW5uaW5nIG9mIHRoZSBjb25m
aWd1cmF0aW9uIHNwYWNlLiIKCgo+ID4KPiA+IChEbyB3ZSBuZWVkIHRvIHNwZWNpZnkgd2hhdCBh
IGRldmljZSBuZWVkcyB0byBkbyBpZiB0aGUgZHJpdmVyIHRyaWVzIHRvCj4gPiBhY2Nlc3MgYSBu
b24tZXhpc3RpbmcgZmllbGQ/IFdlIGNhbm5vdCByZWFsbHkgbWFrZSBhc3N1bXB0aW9ucyBhYm91
dAo+ID4gY29uZmlnIHNwYWNlIGFjY2Vzc2VzOyB2aXJ0aW8tY2N3IGNhbiBqdXN0IGNvcHkgYSBj
aHVuayBvZiBjb25maWcgc3BhY2UKPiA+IHRoYXQgY29udGFpbnMgbm9uLWV4aXN0aW5nIGZpZWxk
cy4uLiAgCj4gCj4gCj4gUmlnaHQsIGl0IGxvb2tzIHRvIG1lIGNjdyBkb2Vzbid0IGRlcGVuZHMg
b24gY29uZmlnIGxlbiB3aGljaCBpcyBraW5kIG9mIAo+IGludGVyZXN0aW5nLiBJIHRoaW5rIHRo
ZSBhbnN3ZXIgZGVwZW5kcyBvbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgYm90aCAKPiB0cmFuc3Bv
cnQgYW5kIGRldmljZToKCih2aXJ0aW8tY2N3IGlzIGEgYml0IG9kZCwgYmVjYXVzZSBjaGFubmVs
IEkvTyBkb2VzIG5vdCBoYXZlIHRoZSBjb25jZXB0Cm9mIGEgY29uZmlnIHNwYWNlIGFuZCBJIG5l
ZWRlZCB0byBjb21lIHVwIHdpdGggc29tZXRoaW5nKQoKPiAKPiBMZXQncyB0YWtlIHZpcnRpby1u
ZXQtcGNpIGFzIGFuIGV4YW1wbGUsIGl0IGZpbGxzIHN0YXR1cyB1bmNvbmRpdGlvbmFsbHkgCj4g
aW4gdmlydGlvX25ldF9zZXRfY29uZmlnKCkgZXZlbiBpZiBWSVJUSU9fTkVUX0ZfU1RBVFVTIGlz
IG5vdCAKPiBuZWdvdGlhdGVkLiBTbyB3aXRoIHRoZSBhYm92ZSBmZWF0dXJlX3NpemVzOgo+IAo+
IDEpIGlmIG9uZSBvZiB0aGUgTVEsIE1UVSwgRFVQTEVYIG9yIFJTUyBpcyBpbXBsZW1lbnRlZCwg
ZHJpdmVyIGNhbiBzdGlsbCAKPiByZWFkIHN0YXR1cyBpbiB0aGlzIGNhc2UKPiAyKSBpZiBub25l
IG9mIHRoZSBhYm92ZSBmb3VyIGlzIG5lZ290aWVkLCBkcml2ZXIgY2FuIG9ubHkgcmVhZCBhIDB4
RkYgCj4gKHZpcnRpb19jb25maWdfcmVhZGIoKSkKPiAKPiAKPiA+IEkgZ3Vlc3MgdGhlIGRldmlj
ZSBjb3VsZCBpZ25vcmUKPiA+IHdyaXRlcyBhbmQgcmV0dXJuIHplcm9lcyBvbiByZWFkPykgIAo+
IAo+IAo+IFNvIGNvbnNpZGVyIHRoZSBhYm92ZSwgaXQgbWlnaHQgYmUgdG9vIGxhdGUgdG8gZml4
L2NsYXJpZnkgdGhhdCBpbiB0aGUgCj4gc3BlYyBvbiB0aGUgZXhwZWN0ZWQgYmVoYXZpb3VyIG9m
IHJlYWRpbmcvd3JpdGluZyBub24tZXhpc3QgZmllbGRzLgoKV2UgY291bGQgc3RpbGwgYWR2aXNl
IGJlaGF2aW91ciB2aWEgU0hPVUxELCB0aG91Z2ggSSdtIG5vdCBzdXJlIGl0IGFkZHMKbXVjaCBh
dCB0aGlzIHBvaW50IGluIHRpbWUuCgpJdCByZWFsbHkgZmVlbHMgYSBiaXQgb2RkIHRoYXQgYSBk
cml2ZXIgY2FuIHN0aWxsIHJlYWQgYW5kIHdyaXRlIGZpZWxkcwpmb3IgZmVhdHVyZXMgdGhhdCBp
dCBkaWQgbm90IG5lZ290aWF0ZSwgYnV0IEkgZmVhciB3ZSdyZSBzdHVjayB3aXRoIGl0LgoKPiAK
PiBUaGFua3MKPiAKPiAKPiA+Cj4gPiBJJ3ZlIG9wZW5lZCBodHRwczovL2dpdGh1Yi5jb20vb2Fz
aXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy85OCBmb3IgdGhlCj4gPiBzcGVjIGlzc3Vlcy4KPiA+
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
