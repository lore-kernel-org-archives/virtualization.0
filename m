Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694CC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:59:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC9A64E57
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC9A64E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA8E984E1A;
	Tue, 23 Feb 2021 10:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYe463FJpO8P; Tue, 23 Feb 2021 10:58:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFAEC84D74;
	Tue, 23 Feb 2021 10:58:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D0CCC000A;
	Tue, 23 Feb 2021 10:58:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E140C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E256983032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DQar8g3z2v58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:58:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E63B82D83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614077936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkd+5jk5LHljt8qwKSET2SjckHJatWstbL8xS93DgrQ=;
 b=Va3a8j4XSXT6eaO/YV1OFuj3RsUhBHL2Q6zW79A1Yq+Hd+t/WsymR9F6bJyhzrJrt7nqL7
 0hK/oYCrge7Q3g2hlgsBfdsJBQqEVUNv7/hq78GCqeMDNLklOfha0vAkjml2gG1ru+LXkK
 uwDivR+SmUzTQDV31YY0oKTQaYdYGOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-PdIEnYWPPxuAwtoFU1FnbA-1; Tue, 23 Feb 2021 05:58:49 -0500
X-MC-Unique: PdIEnYWPPxuAwtoFU1FnbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73AD280196E;
 Tue, 23 Feb 2021 10:58:43 +0000 (UTC)
Received: from gondolin (ovpn-113-126.ams2.redhat.com [10.36.113.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72A567092D;
 Tue, 23 Feb 2021 10:58:36 +0000 (UTC)
Date: Tue, 23 Feb 2021 11:58:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210223115833.732d809c.cohuck@redhat.com>
In-Reply-To: <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

T24gVHVlLCAyMyBGZWIgMjAyMSAxODozMTowNyArMDgwMApKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gMjAyMS8yLzIzIDY6MDQg5LiL5Y2ILCBDb3JuZWxpYSBI
dWNrIHdyb3RlOgo+ID4gT24gVHVlLCAyMyBGZWIgMjAyMSAxNzo0NjoyMCArMDgwMAo+ID4gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAgCj4gPj4gT24gMjAyMS8y
LzIzIOS4i+WNiDU6MjUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZTogIAo+ID4+PiBPbiBNb24s
IEZlYiAyMiwgMjAyMSBhdCAwOTowOToyOEFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOiAgCj4g
Pj4+PiBPbiAyLzIxLzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3cm90ZTogIAo+ID4+Pj4+IE9u
IDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZTogIAo+ID4+Pj4+PiBDb21t
aXQgNDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2Vk
Cj4gPj4+Pj4+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1ZXN0
cyB0byByZXNldAo+ID4+Pj4+PiBmZWF0dXJlcyB0byAwLCB3aGVuIGNvbmZpZyBzcGFjZSBpcyBh
Y2Nlc3NlZCBiZWZvcmUgZmVhdHVyZXMKPiA+Pj4+Pj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGll
dmUgdGhlIHZlcmlmeV9taW5fZmVhdHVyZXMoKSBjaGVjawo+ID4+Pj4+PiBhbmQgYWxsb3cgZmVh
dHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBjYXNlLgo+ID4+Pj4+Pgo+ID4+Pj4+PiBJdCdzIHdv
cnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4gPj4+
Pj4+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNldC4gRm9yIGluc3RhbmNlLCB3
aGVuCj4gPj4+Pj4+IGZlYXR1cmUgVklSVElPX05FVF9GX01UVSBpcyBhZHZlcnRpc2VkIHNvbWUg
bW9kZXJuIGRyaXZlcgo+ID4+Pj4+PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRo
ZSBNVFUgcHJlc2VudCBpbiB0aGUgY29uZmlnCj4gPj4+Pj4+IHNwYWNlIGJlZm9yZSB2aXJ0aW8g
ZmVhdHVyZXMgYXJlIHNldC4gIAo+ID4+Pj4+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0
aW9uOgo+ID4+Pj4+Cj4gPj4+Pj4gIgo+ID4+Pj4+Cj4gPj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2
ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPiA+Pj4+PiBWSVJUSU9fTkVU
X0ZfTVRVIGlzIHNldC4gVGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRVIGZvciB0
aGUKPiA+Pj4+PiBkcml2ZXIgdG8gdXNlLgo+ID4+Pj4+ICIKPiA+Pj4+Pgo+ID4+Pj4+IERvIHdl
IHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQgdGhpcz8gIAo+ID4+Pj4gSXNuJ3QgdGhlIGNvbW1p
dCA0NTI2MzlhNjRhZDggaXRzZWxmIGlzIGEgd29ya2Fyb3VuZCBmb3IgbGVnYWN5IGd1ZXN0Pwo+
ID4+Pj4KPiA+Pj4+IEkgdGhpbmsgdGhlIHBvaW50IGlzLCBzaW5jZSB0aGVyZSdzIGxlZ2FjeSBn
dWVzdCB3ZSdkIGhhdmUgdG8gc3VwcG9ydCwgdGhpcwo+ID4+Pj4gaG9zdCBzaWRlIHdvcmthcm91
bmQgaXMgdW5hdm9pZGFibGUuIEFsdGhvdWdoIEkgYWdyZWUgdGhlIHZpb2xhdGluZyBkcml2ZXIK
PiA+Pj4+IHNob3VsZCBiZSBmaXhlZCAoeWVzLCBpdCdzIGluIHRvZGF5J3MgdXBzdHJlYW0ga2Vy
bmVsIHdoaWNoIGV4aXN0cyBmb3IgYQo+ID4+Pj4gd2hpbGUgbm93KS4gIAo+ID4+PiBPaCAgeW91
IGFyZSByaWdodDoKPiA+Pj4KPiA+Pj4KPiA+Pj4gc3RhdGljIGludCB2aXJ0bmV0X3ZhbGlkYXRl
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4+PiB7Cj4gPj4+ICAgICAgICAgICBpZiAo
IXZkZXYtPmNvbmZpZy0+Z2V0KSB7Cj4gPj4+ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnZk
ZXYtPmRldiwgIiVzIGZhaWx1cmU6IGNvbmZpZyBhY2Nlc3MgZGlzYWJsZWRcbiIsCj4gPj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18pOwo+ID4+PiAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsKPiA+Pj4gICAgICAgICAgIH0KPiA+Pj4KPiA+Pj4gICAgICAgICAg
IGlmICghdmlydG5ldF92YWxpZGF0ZV9mZWF0dXJlcyh2ZGV2KSkKPiA+Pj4gICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPj4+Cj4gPj4+ICAgICAgICAgICBpZiAodmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NVFUpKSB7Cj4gPj4+ICAgICAgICAgICAgICAg
ICAgIGludCBtdHUgPSB2aXJ0aW9fY3JlYWQxNih2ZGV2LAo+ID4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29u
ZmlnLAo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbXR1KSk7Cj4gPj4+ICAgICAgICAgICAgICAgICAgIGlmIChtdHUgPCBNSU5fTVRVKQo+
ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBW
SVJUSU9fTkVUX0ZfTVRVKTsgIAo+ID4+Cj4gPj4gSSB3b25kZXIgd2h5IG5vdCBzaW1wbHkgZmFp
bCBoZXJlPyAgCj4gPiBJIHRoaW5rIGJvdGggZmFpbGluZyBvciBub3QgYWNjZXB0aW5nIHRoZSBm
ZWF0dXJlIGNhbiBiZSBhcmd1ZWQgdG8gbWFrZQo+ID4gc2Vuc2U6ICJ0aGUgZGV2aWNlIHByZXNl
bnRlZCB1cyB3aXRoIGEgbXR1IHNpemUgdGhhdCBkb2VzIG5vdCBtYWtlCj4gPiBzZW5zZSIgd291
bGQgcG9pbnQgdG8gZmFpbGluZywgIndlIGNhbm5vdCB3b3JrIHdpdGggdGhlIG10dSBzaXplIHRo
YXQKPiA+IHRoZSBkZXZpY2UgcHJlc2VudGVkIHVzIiB3b3VsZCBwb2ludCB0byBub3QgbmVnb3Rp
YXRpbmcgdGhlIGZlYXR1cmUuCj4gPiAgCj4gPj4gIAo+ID4+PiAgICAgICAgICAgfQo+ID4+Pgo+
ID4+PiAgICAgICAgICAgcmV0dXJuIDA7Cj4gPj4+IH0KPiA+Pj4KPiA+Pj4gQW5kIHRoZSBzcGVj
IHNheXM6Cj4gPj4+Cj4gPj4+Cj4gPj4+IFRoZSBkcml2ZXIgTVVTVCBmb2xsb3cgdGhpcyBzZXF1
ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+ID4+PiAxLiBSZXNldCB0aGUgZGV2aWNlLgo+
ID4+PiAyLiBTZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMg
bm90aWNlZCB0aGUgZGV2aWNlLgo+ID4+PiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0
aGUgZ3Vlc3QgT1Mga25vd3MgaG93IHRvIGRyaXZlIHRoZSBkZXZpY2UuCj4gPj4+IDQuIFJlYWQg
ZGV2aWNlIGZlYXR1cmUgYml0cywgYW5kIHdyaXRlIHRoZSBzdWJzZXQgb2YgZmVhdHVyZSBiaXRz
IHVuZGVyc3Rvb2QgYnkgdGhlIE9TIGFuZCBkcml2ZXIgdG8gdGhlCj4gPj4+IGRldmljZS4gRHVy
aW5nIHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRo
ZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbgo+ID4+PiBmaWVsZHMgdG8gY2hlY2sgdGhh
dCBpdCBjYW4gc3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQuCj4gPj4+IDUu
IFNldCB0aGUgRkVBVFVSRVNfT0sgc3RhdHVzIGJpdC4gVGhlIGRyaXZlciBNVVNUIE5PVCBhY2Nl
cHQgbmV3IGZlYXR1cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAuCj4gPj4+IDYuIFJlLXJlYWQgZGV2
aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90
aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5vdAo+ID4+PiBzdXBwb3J0IG91ciBzdWJzZXQgb2Yg
ZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51c2FibGUuCj4gPj4+IDcuIFBlcmZvcm0gZGV2
aWNlLXNwZWNpZmljIHNldHVwLCBpbmNsdWRpbmcgZGlzY292ZXJ5IG9mIHZpcnRxdWV1ZXMgZm9y
IHRoZSBkZXZpY2UsIG9wdGlvbmFsIHBlci1idXMgc2V0dXAsCj4gPj4+IHJlYWRpbmcgYW5kIHBv
c3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZpZ3VyYXRpb24gc3BhY2Us
IGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4gPj4+IDguIFNldCB0aGUgRFJJVkVSX09L
IHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9pbnQgdGhlIGRldmljZSBpcyDigJxsaXZl4oCdLgo+ID4+
Pgo+ID4+Pgo+ID4+PiBJdGVtIDQgb24gdGhlIGxpc3QgZXhwbGljaXRseSBhbGxvd3MgcmVhZGlu
ZyBjb25maWcgc3BhY2UgYmVmb3JlCj4gPj4+IEZFQVRVUkVTX09LLgo+ID4+Pgo+ID4+PiBJIGNv
bmNsdWRlIHRoYXQgVklSVElPX05FVF9GX01UVSBpcyBzZXQgbWVhbnMgInNldCBpbiBkZXZpY2Ug
ZmVhdHVyZXMiLiAgCj4gPj4KPiA+PiBTbyB0aGlzIHByb2JhYmx5IG5lZWQgc29tZSBjbGFyaWZp
Y2F0aW9uLiAiaXMgc2V0IiBpcyB1c2VkIG1hbnkgdGltZXMgaW4KPiA+PiB0aGUgc3BlYyB0aGF0
IGhhcyBkaWZmZXJlbnQgaW1wbGljYXRpb25zLiAgCj4gPiBCZWZvcmUgRkVBVFVSRVNfT0sgaXMg
c2V0IGJ5IHRoZSBkcml2ZXIsIEkgZ3Vlc3MgaXQgbWVhbnMgInRoZSBkZXZpY2UKPiA+IGhhcyBv
ZmZlcmVkIHRoZSBmZWF0dXJlIjsgIAo+IAo+IAo+IEZvciBtZSB0aGlzIHBhcnQgaXMgb2sgc2lu
Y2UgaXQgY2xhcmlmeSB0aGF0IGl0J3MgdGhlIGRyaXZlciB0aGF0IHNldCAKPiB0aGUgYml0Lgo+
IAo+IAo+IAo+ID4gZHVyaW5nIG5vcm1hbCB1c2FnZSwgaXQgbWVhbnMgInRoZSBmZWF0dXJlCj4g
PiBoYXMgYmVlbiBuZWdvdGlhdGVkIi4gIAo+IAo+IC8/Cj4gCj4gSXQgbG9va3MgdG8gbWUgdGhl
IGZlYXR1cmUgbmVnb3RpYXRpb24gaXMgZG9uZSBvbmx5IGFmdGVyIGRldmljZSBzZXQgCj4gRkVB
VFVSRVNfT0ssIG9yIEZFQVRVUkVTX09LIGNvdWxkIGJlIHJlYWQgZnJvbSBkZXZpY2Ugc3RhdHVz
PwoKSSdkIGNvbnNpZGVyIGZlYXR1cmUgbmVnb3RpYXRpb24gZG9uZSB3aGVuIHRoZSBkcml2ZXIg
cmVhZHMgRkVBVFVSRVNfT0sKYmFjayBmcm9tIHRoZSBzdGF0dXMuCgo+IAo+IAo+ID4gICAoVGhp
cyBpcyBhIGJpdCBmdXp6eSBmb3IgbGVnYWN5IG1vZGUuKQoKLi4uYmVjYXVzZSBsZWdhY3kgZG9l
cyBub3QgaGF2ZSBGRUFUVVJFU19PSy4KICAKPiAKPiAKPiBUaGUgcHJvYmxlbSBpcyB0aGUgTVRV
IGRlc2NyaXB0aW9uIGZvciBleGFtcGxlOgo+IAo+ICJUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFk
LW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZiAKPiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNl
dC4iCj4gCj4gSXQgbG9va3MgdG8gbWUgbmVlZCB0byB1c2UgImlmIFZJUlRJT19ORVRfRl9NVFUg
aXMgc2V0IGJ5IGRldmljZSIuCgoib2ZmZXJlZCBieSB0aGUgZGV2aWNlIj8gSSBkb24ndCB0aGlu
ayBpdCBzaG91bGQgJ2Rpc2FwcGVhcicgZnJvbSB0aGUKY29uZmlnIHNwYWNlIGlmIHRoZSBkcml2
ZXIgd29uJ3QgdXNlIGl0LiAoU2FtZSBmb3Igb3RoZXIgY29uZmlnIHNwYWNlCmZpZWxkcyB0aGF0
IGFyZSB0aWVkIHRvIGZlYXR1cmUgYml0cy4pCiAKPiBPdGhlcndpc2UgcmVhZGVycyAoYXQgbGVh
c3QgZm9yIG1lKSwgbWF5IHRoaW5rIHRoZSBNVFUgaXMgb25seSB2YWxpZAo+IGlmIGRyaXZlciBz
ZXQgdGhlIGJpdC4KCkkgdGhpbmsgaXQgd291bGQgc3RpbGwgYmUgJ3ZhbGlkJyBpbiB0aGUgc2Vu
c2UgdGhhdCBpdCBleGlzdHMgYW5kIGhhcwpzb21lIHZhbHVlIGluIHRoZXJlIGZpbGxlZCBpbiBi
eSB0aGUgZGV2aWNlLCBidXQgYSBkcml2ZXIgcmVhZGluZyBpdAp3aXRob3V0IG5lZ290aWF0aW5n
IHRoZSBmZWF0dXJlIHdvdWxkIGJlIGJ1Z2d5LiAoTGlrZSBpbiB0aGUga2VybmVsCmNvZGUgYWJv
dmU7IHRoZSBrZXJuZWwgbm90IGxpa2luZyB0aGUgdmFsdWUgZG9lcyBub3QgbWFrZSB0aGUgZmll
bGQKaW52YWxpZC4pCgpNYXliZSBhIHN0YXRlbWVudCBjb3ZlcmluZyBldmVyeXRoaW5nIHdvdWxk
IGJlOgoKIlRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCBtdHUgb25seSBleGlz
dHMgaWYgdGhlIGRldmljZQpvZmZlcnMgVklSVElPX05FVF9GX01UVSBhbmQgbWF5IGJlIHJlYWQg
YnkgdGhlIGRyaXZlciBkdXJpbmcgZmVhdHVyZQpuZWdvdGlhdGlvbiBhbmQgYWZ0ZXIgVklSVElP
X05FVF9GX01UVSBoYXMgYmVlbiBzdWNjZXNzZnVsbHkKbmVnb3RpYXRlZC4iCgo+IAo+IAo+ID4K
PiA+IFNob3VsZCB3ZSBhZGQgYSB3b3JkaW5nIGNsYXJpZmljYXRpb24gdG8gdGhlIHNwZWM/ICAK
PiAKPiAKPiBJIHRoaW5rIHNvLgoKU29tZSBjbGFyaWZpY2F0aW9uIHdvdWxkIGJlIG5lZWRlZCBm
b3IgZWFjaCBmaWVsZCB0aGF0IGRlcGVuZHMgb24gYQpmZWF0dXJlOyB0aGF0IHdvdWxkIGJlIHF1
aXRlIHZlcmJvc2UuIE1heWJlIHdlIGNhbiBnZXQgYXdheSB3aXRoIGEKY2xhcmlmeWluZyBzdGF0
ZW1lbnQ/CgoiU29tZSBjb25maWcgc3BhY2UgZmllbGRzIG1heSBkZXBlbmQgb24gYSBjZXJ0YWlu
IGZlYXR1cmUuIEluIHRoYXQKY2FzZSwgdGhlIGZpZWxkIGV4aXRzIGlmIHRoZSBkZXZpY2UgaGFz
IG9mZmVyZWQgdGhlIGNvcnJlc3BvbmRpbmcKZmVhdHVyZSwgYW5kIG1heSBiZSByZWFkIGJ5IHRo
ZSBkcml2ZXIgZHVyaW5nIGZlYXR1cmUgbmVnb3RpYXRpb24sIGFuZAphY2Nlc3NlZCBieSB0aGUg
ZHJpdmVyIGFmdGVyIHRoZSBmZWF0dXJlIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseQpuZWdvdGlhdGVk
LiBBIHNob3J0aGFuZCBmb3IgdGhpcyBpcyBhIHN0YXRlbWVudCB0aGF0IGEgZmllbGQgb25seQpl
eGlzdHMgaWYgYSBjZXJ0YWluIGZlYXR1cmUgYml0IGlzIHNldC4iCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
