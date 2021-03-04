Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567BC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 13:50:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE1564F39
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 13:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE1564F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AA396F4C3;
	Thu,  4 Mar 2021 13:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EdTZ5zlxFZGR; Thu,  4 Mar 2021 13:50:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9042B60678;
	Thu,  4 Mar 2021 13:50:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A1A2C000B;
	Thu,  4 Mar 2021 13:50:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCDACC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC93D43250
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLrSIXE2e0Zo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E95B542FB7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614865811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dKD6EMo2YP510AzFfioC+1u/tF8yICEAGoshmqfTsM=;
 b=D2dNWJukvwk5vX1JqdDPwKNpS8BBGKlxbpoURU8idTkzH5BBJMao2+Lo4SmUy+lg/vTDff
 KA6NcaNveDD6BjCkUsZuSafZdW8HkZc/MGxvmGutgDPDYFGztkSSy3KTvUprsc03BLDBRF
 SBbQSMsSDe2R9WzN2Ev+D7lFi0FOnFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ZZNokqHgORCQ1jjP6EJ2mA-1; Thu, 04 Mar 2021 08:50:10 -0500
X-MC-Unique: ZZNokqHgORCQ1jjP6EJ2mA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1275874998;
 Thu,  4 Mar 2021 13:50:08 +0000 (UTC)
Received: from gondolin (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A28D60244;
 Thu,  4 Mar 2021 13:50:03 +0000 (UTC)
Date: Thu, 4 Mar 2021 14:50:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210304145000.149706ae.cohuck@redhat.com>
In-Reply-To: <1b5b3f9b-41d7-795c-c677-c45f1d5a774e@redhat.com>
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
 <20210303092905.677eb66c.cohuck@redhat.com>
 <1b5b3f9b-41d7-795c-c677-c45f1d5a774e@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

T24gVGh1LCA0IE1hciAyMDIxIDE2OjI0OjE2ICswODAwCkphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPiBPbiAyMDIxLzMvMyA0OjI5IOS4i+WNiCwgQ29ybmVsaWEgSHVj
ayB3cm90ZToKPiA+IE9uIFdlZCwgMyBNYXIgMjAyMSAxMjowMTowMSArMDgwMAo+ID4gSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAgCj4gPj4gT24gMjAyMS8zLzIg
ODowOCDkuIvljYgsIENvcm5lbGlhIEh1Y2sgd3JvdGU6ICAKPiA+Pj4gT24gTW9uLCAxIE1hciAy
MDIxIDExOjUxOjA4ICswODAwCj4gPj4+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+ID4+PiAgICAgCj4gPj4+PiBPbiAyMDIxLzMvMSA1OjI1IOS4iuWNiCwgTWljaGFl
bCBTLiBUc2lya2luIHdyb3RlOiAgCj4gPj4+Pj4gT24gRnJpLCBGZWIgMjYsIDIwMjEgYXQgMDQ6
MTk6MTZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZTogIAo+ID4+Pj4+PiBPbiAyMDIxLzIvMjYg
Mjo1MyDkuIrljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+ID4+Pj4+Pj4gQ29uZnVz
ZWQuIFdoYXQgaXMgd3Jvbmcgd2l0aCB0aGUgYWJvdmU/IEl0IG5ldmVyIHJlYWRzIHRoZQo+ID4+
Pj4+Pj4gZmllbGQgdW5sZXNzIHRoZSBmZWF0dXJlIGhhcyBiZWVuIG9mZmVyZWQgYnkgZGV2aWNl
LiAgCj4gPj4+Pj4+IFNvIHRoZSBzcGVjIHNhaWQ6Cj4gPj4+Pj4+Cj4gPj4+Pj4+ICIKPiA+Pj4+
Pj4KPiA+Pj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtYXhfdmly
dHF1ZXVlX3BhaXJzIG9ubHkgZXhpc3RzIGlmCj4gPj4+Pj4+IFZJUlRJT19ORVRfRl9NUSBpcyBz
ZXQuCj4gPj4+Pj4+Cj4gPj4+Pj4+ICIKPiA+Pj4+Pj4KPiA+Pj4+Pj4gSWYgSSByZWFkIHRoaXMg
Y29ycmVjdGx5LCB0aGVyZSB3aWxsIGJlIG5vIG1heF92aXJ0cXVldWVfcGFpcnMgZmllbGQgaWYg
dGhlCj4gPj4+Pj4+IFZJUlRJT19ORVRfRl9NUSBpcyBub3Qgb2ZmZXJlZCBieSBkZXZpY2U/IElm
IHllcyB0aGUgb2Zmc2V0b2YoKSB2aW9sYXRlcwo+ID4+Pj4+PiB3aGF0IHNwZWMgc2FpZC4KPiA+
Pj4+Pj4KPiA+Pj4+Pj4gVGhhbmtzICAKPiA+Pj4+PiBJIHRoaW5rIHRoYXQncyBhIG1pc3VuZGVy
c3RhbmRpbmcuIFRoaXMgdGV4dCB3YXMgbmV2ZXIgaW50ZW5kZWQgdG8KPiA+Pj4+PiBpbXBseSB0
aGF0IGZpZWxkIG9mZnNldHMgY2hhbmdlIGJlYXNlZCBvbiBmZWF0dXJlIGJpdHMuCj4gPj4+Pj4g
V2UgaGFkIHRoaXMgcGFpbiB3aXRoIGxlZ2FjeSBhbmQgd2UgbmV2ZXIgd2FudGVkIHRvIGdvIGJh
Y2sgdGhlcmUuCj4gPj4+Pj4KPiA+Pj4+PiBUaGlzIG1lcmVseSBpbXBsaWVzIHRoYXQgd2l0aG91
dCBWSVJUSU9fTkVUX0ZfTVEgdGhlIGZpZWxkCj4gPj4+Pj4gc2hvdWxkIG5vdCBiZSBhY2Nlc3Nl
ZC4gRXhpc3RzIGluIHRoZSBzZW5zZSAiaXMgYWNjZXNzaWJsZSB0byBkcml2ZXIiLgo+ID4+Pj4+
Cj4gPj4+Pj4gTGV0J3MganVzdCBjbGFyaWZ5IHRoYXQgaW4gdGhlIHNwZWMsIGpvYiBkb25lLiAg
Cj4gPj4+PiBPaywgYWdyZWUuIFRoYXQgd2lsbCBtYWtlIHRoaW5ncyBtb3JlIGVhaXNlci4gIAo+
ID4+PiBZZXMsIHRoYXQgbWFrZXMgbXVjaCBtb3JlIHNlbnNlLgo+ID4+Pgo+ID4+PiBXaGF0IGFi
b3V0IGFkZGluZyB0aGUgZm9sbG93aW5nIHRvIHRoZSAiQmFzaWMgRmFjaWxpdGllcyBvZiBhIFZp
cnRpbwo+ID4+PiBEZXZpY2UvRGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UiIHNlY3Rpb24gb2Yg
dGhlIHNwZWM6Cj4gPj4+Cj4gPj4+ICJJZiBhbiBvcHRpb25hbCBjb25maWd1cmF0aW9uIGZpZWxk
IGRvZXMgbm90IGV4aXN0LCB0aGUgY29ycmVzcG9uZGluZwo+ID4+PiBzcGFjZSBpcyBzdGlsbCBw
cmVzZW50LCBidXQgcmVzZXJ2ZWQuIiAgCj4gPj4KPiA+PiBUaGlzIGJlY2FtZSBpbnRlcmVzdGlu
ZyBhZnRlciByZS1yZWFkaW5nIHNvbWUgb2YgdGhlIHFlbXUgY29kZXMuCj4gPj4KPiA+PiBFLmcg
aW4gdmlydGlvLW5ldC5jIHdlIGhhZDoKPiA+Pgo+ID4+ICpzdGF0aWMgVmlydElPRmVhdHVyZSBm
ZWF0dXJlX3NpemVzW10gPSB7Cj4gPj4gICDCoMKgwqAgey5mbGFncyA9IDFVTEwgPDwgVklSVElP
X05FVF9GX01BQywKPiA+PiAgIMKgwqDCoMKgIC5lbmQgPSBlbmRvZihzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcsIG1hYyl9LAo+ID4+ICAgwqDCoMKgIHsuZmxhZ3MgPSAxVUxMIDw8IFZJUlRJT19O
RVRfRl9TVEFUVVMsCj4gPj4gICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnLCBzdGF0dXMpfSwKPiA+PiAgIMKgwqDCoCB7LmZsYWdzID0gMVVMTCA8PCBWSVJU
SU9fTkVUX0ZfTVEsCj4gPj4gICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnLCBtYXhfdmlydHF1ZXVlX3BhaXJzKX0sCj4gPj4gICDCoMKgwqAgey5mbGFncyA9
IDFVTEwgPDwgVklSVElPX05FVF9GX01UVSwKPiA+PiAgIMKgwqDCoMKgIC5lbmQgPSBlbmRvZihz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWcsIG10dSl9LAo+ID4+ICAgwqDCoMKgIHsuZmxhZ3MgPSAx
VUxMIDw8IFZJUlRJT19ORVRfRl9TUEVFRF9EVVBMRVgsCj4gPj4gICDCoMKgwqDCoCAuZW5kID0g
ZW5kb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBkdXBsZXgpfSwKPiA+PiAgIMKgwqDCoCB7
LmZsYWdzID0gKDFVTEwgPDwgVklSVElPX05FVF9GX1JTUykgfCAoMVVMTCA8PAo+ID4+IFZJUlRJ
T19ORVRfRl9IQVNIX1JFUE9SVCksCj4gPj4gICDCoMKgwqDCoCAuZW5kID0gZW5kb2Yoc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnLCBzdXBwb3J0ZWRfaGFzaF90eXBlcyl9LAo+ID4+ICAgwqDCoMKg
IHt9Cj4gPj4gfTsqCj4gPj4KPiA+PiAqSXQgaGFzIGEgaW1wbGljdCBkZXBlbmRlbmN5IGNoYWlu
LiBFLmcgTVRVIGRvZXNuJ3QgcHJlc25ldCBpZgo+ID4+IERVUExFWC9SU1MgaXMgbm90IG9mZmVy
ZWQgLi4uCj4gPj4gKiAgCj4gPiBCdXQgSSB0aGluayBpdCBjb3ZlcnMgZXZlcnl0aGluZyB1cCB0
byB0aGUgcmVsZXZhbnQgZmllbGQsIG5vPyBTbyBNVFUKPiA+IGlzIGluY2x1ZGVkIGlmIHdlIGhh
dmUgdGhlIGZlYXR1cmUgYml0LCBldmVuIGlmIHdlIGRvbid0IGhhdmUKPiA+IERVUExFWC9SU1Mu
Cj4gPgo+ID4gR2l2ZW4gdGhhdCBhIGNvbmZpZyBzcGFjZSBtYXkgYmUgc2hvcnRlciAoYnV0IG11
c3Qgbm90IGNvbGxhcHNlCj4gPiBub24tZXhpc3RpbmcgZmllbGRzKSwgbWF5YmUgYSBiZXR0ZXIg
d29yZGluZyB3b3VsZCBiZToKPiA+Cj4gPiAiSWYgYW4gb3B0aW9uYWwgY29uZmlndXJhdGlvbiBm
aWVsZCBkb2VzIG5vdCBleGlzdCwgdGhlIGNvcnJlc3BvbmRpbmcKPiA+IHNwYWNlIHdpbGwgc3Rp
bGwgYmUgcHJlc2VudCBpZiBpdCBpcyBub3QgYXQgdGhlIGVuZCBvZiB0aGUKPiA+IGNvbmZpZ3Vy
YXRpb24gc3BhY2UgKGkuZS4sIGZ1cnRoZXIgY29uZmlndXJhdGlvbiBmaWVsZHMgZXhpc3QuKSAg
Cj4gCj4gCj4gVGhpcyBzaG91bGQgd29yayBidXQgSSB0aGluayB3ZSBuZWVkIHRvIGRlZmluZSB0
aGUgZW5kIG9mIGNvbmZpZ3VyYXRpb24gCj4gc3BhY2UgZmlyc3Q/CgpXaGF0IGFib3V0IHNpZGVz
dGVwcGluZyB0aGlzOgoKIi4uLnRoZSBjb3JyZXNwb25kaW5nIHNwYWNlIHdpbGwgc3RpbGwgYmUg
cHJlc2VudCwgdW5sZXNzIG5vIGZ1cnRoZXIKY29uZmlndXJhdGlvbiBmaWVsZHMgZXhpc3QuIgoK
PwoKPiAKPiA+IFRoaXMKPiA+IGltcGxpZXMgdGhhdCBhIGdpdmVuIGZpZWxkLCBpZiBpdCBleGlz
dHMsIGlzIGFsd2F5cyBhdCB0aGUgc2FtZSBvZmZzZXQKPiA+IGZyb20gdGhlIGJlZ2lubmluZyBv
ZiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZS4iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
