Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99520C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:31:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141AD601FD
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141AD601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B15E483478;
	Tue, 23 Feb 2021 10:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxbgpHyXtNNf; Tue, 23 Feb 2021 10:31:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBB2A83280;
	Tue, 23 Feb 2021 10:31:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93A03C000A;
	Tue, 23 Feb 2021 10:31:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5DA1C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D14446059C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-TLfDFFnAji
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:31:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B864605BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614076278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpwoTgqko7g1LEx2DA3+/sWA4mTXGiRDjc3guaPEp8c=;
 b=NYyIvUt8CsoS3KmculC+nRTr7bMIRPT/CxLVCGB4tRtk2BKKuVLVbjW8vh9SEXsIdit1yl
 HMziiiq36U35Ib2D8s9XA77RutEZDPu2WSHUe+4MwO837JAEUf+qZn8H04NybTLhtht5kC
 XryEG2Ak+x+wRY0k6FSqmUv9Yudtj2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-uUe_krADPIuVgxNK0dxpsA-1; Tue, 23 Feb 2021 05:31:16 -0500
X-MC-Unique: uUe_krADPIuVgxNK0dxpsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A301936B61;
 Tue, 23 Feb 2021 10:31:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-193.pek2.redhat.com
 [10.72.12.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C8B619C45;
 Tue, 23 Feb 2021 10:31:09 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: Cornelia Huck <cohuck@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
Date: Tue, 23 Feb 2021 18:31:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223110430.2f098bc0.cohuck@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMi8yMyA2OjA0IOS4i+WNiCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPiBPbiBUdWUs
IDIzIEZlYiAyMDIxIDE3OjQ2OjIwICswODAwCj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPj4gT24gMjAyMS8yLzIzIOS4i+WNiDU6MjUsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPj4+IE9uIE1vbiwgRmViIDIyLCAyMDIxIGF0IDA5OjA5OjI4QU0gLTA4MDAs
IFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4gT24gMi8yMS8yMDIxIDg6MTQgUE0sIEphc29uIFdhbmcg
d3JvdGU6Cj4+Pj4+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToK
Pj4+Pj4+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVz
IGlzIGludm9rZWQKPj4+Pj4+IGZvciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVn
YWN5IGd1ZXN0cyB0byByZXNldAo+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcgc3Bh
Y2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+Pj4+PiBhcmUgc2V0LiBXZSBzaG91bGQg
cmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4+Pj4+PiBhbmQgYWxsb3cg
ZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBjYXNlLgo+Pj4+Pj4KPj4+Pj4+IEl0J3Mgd29y
dGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nlc3MKPj4+Pj4+
IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNldC4gRm9yIGluc3RhbmNlLCB3aGVu
Cj4+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVy
biBkcml2ZXIKPj4+Pj4+IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBw
cmVzZW50IGluIHRoZSBjb25maWcKPj4+Pj4+IHNwYWNlIGJlZm9yZSB2aXJ0aW8gZmVhdHVyZXMg
YXJlIHNldC4KPj4+Pj4gVGhpcyBsb29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4+Pj4+Cj4+
Pj4+ICIKPj4+Pj4KPj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBt
dHUgb25seSBleGlzdHMgaWYKPj4+Pj4gVklSVElPX05FVF9GX01UVSBpcyBzZXQuIFRoaXMgZmll
bGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhlCj4+Pj4+IGRyaXZlciB0byB1c2Uu
Cj4+Pj4+ICIKPj4+Pj4KPj4+Pj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29ya2Fyb3VuZCB0aGlz
Pwo+Pj4+IElzbid0IHRoZSBjb21taXQgNDUyNjM5YTY0YWQ4IGl0c2VsZiBpcyBhIHdvcmthcm91
bmQgZm9yIGxlZ2FjeSBndWVzdD8KPj4+Pgo+Pj4+IEkgdGhpbmsgdGhlIHBvaW50IGlzLCBzaW5j
ZSB0aGVyZSdzIGxlZ2FjeSBndWVzdCB3ZSdkIGhhdmUgdG8gc3VwcG9ydCwgdGhpcwo+Pj4+IGhv
c3Qgc2lkZSB3b3JrYXJvdW5kIGlzIHVuYXZvaWRhYmxlLiBBbHRob3VnaCBJIGFncmVlIHRoZSB2
aW9sYXRpbmcgZHJpdmVyCj4+Pj4gc2hvdWxkIGJlIGZpeGVkICh5ZXMsIGl0J3MgaW4gdG9kYXkn
cyB1cHN0cmVhbSBrZXJuZWwgd2hpY2ggZXhpc3RzIGZvciBhCj4+Pj4gd2hpbGUgbm93KS4KPj4+
IE9oICB5b3UgYXJlIHJpZ2h0Ogo+Pj4KPj4+Cj4+PiBzdGF0aWMgaW50IHZpcnRuZXRfdmFsaWRh
dGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+PiB7Cj4+PiAgICAgICAgICAgaWYgKCF2
ZGV2LT5jb25maWctPmdldCkgewo+Pj4gICAgICAgICAgICAgICAgICAgZGV2X2VycigmdmRldi0+
ZGV2LCAiJXMgZmFpbHVyZTogY29uZmlnIGFjY2VzcyBkaXNhYmxlZFxuIiwKPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgX19mdW5jX18pOwo+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7Cj4+PiAgICAgICAgICAgfQo+Pj4KPj4+ICAgICAgICAgICBpZiAoIXZpcnRuZXRf
dmFsaWRhdGVfZmVhdHVyZXModmRldikpCj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsKPj4+Cj4+PiAgICAgICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fTkVUX0ZfTVRVKSkgewo+Pj4gICAgICAgICAgICAgICAgICAgaW50IG10dSA9IHZpcnRpb19j
cmVhZDE2KHZkZXYsCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLAo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10dSkpOwo+Pj4gICAgICAgICAg
ICAgICAgICAgaWYgKG10dSA8IE1JTl9NVFUpCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKPj4KPj4gSSB3b25k
ZXIgd2h5IG5vdCBzaW1wbHkgZmFpbCBoZXJlPwo+IEkgdGhpbmsgYm90aCBmYWlsaW5nIG9yIG5v
dCBhY2NlcHRpbmcgdGhlIGZlYXR1cmUgY2FuIGJlIGFyZ3VlZCB0byBtYWtlCj4gc2Vuc2U6ICJ0
aGUgZGV2aWNlIHByZXNlbnRlZCB1cyB3aXRoIGEgbXR1IHNpemUgdGhhdCBkb2VzIG5vdCBtYWtl
Cj4gc2Vuc2UiIHdvdWxkIHBvaW50IHRvIGZhaWxpbmcsICJ3ZSBjYW5ub3Qgd29yayB3aXRoIHRo
ZSBtdHUgc2l6ZSB0aGF0Cj4gdGhlIGRldmljZSBwcmVzZW50ZWQgdXMiIHdvdWxkIHBvaW50IHRv
IG5vdCBuZWdvdGlhdGluZyB0aGUgZmVhdHVyZS4KPgo+Pgo+Pj4gICAgICAgICAgIH0KPj4+Cj4+
PiAgICAgICAgICAgcmV0dXJuIDA7Cj4+PiB9Cj4+Pgo+Pj4gQW5kIHRoZSBzcGVjIHNheXM6Cj4+
Pgo+Pj4KPj4+IFRoZSBkcml2ZXIgTVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFs
aXplIGEgZGV2aWNlOgo+Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+IDIuIFNldCB0aGUgQUNL
Tk9XTEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZpY2Uu
Cj4+PiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3MgaG93
IHRvIGRyaXZlIHRoZSBkZXZpY2UuCj4+PiA0LiBSZWFkIGRldmljZSBmZWF0dXJlIGJpdHMsIGFu
ZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29kIGJ5IHRoZSBPUyBh
bmQgZHJpdmVyIHRvIHRoZQo+Pj4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIg
TUFZIHJlYWQgKGJ1dCBNVVNUIE5PVCB3cml0ZSkgdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1
cmF0aW9uCj4+PiBmaWVsZHMgdG8gY2hlY2sgdGhhdCBpdCBjYW4gc3VwcG9ydCB0aGUgZGV2aWNl
IGJlZm9yZSBhY2NlcHRpbmcgaXQuCj4+PiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBi
aXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldyBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhp
cyBzdGVwLgo+Pj4gNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVS
RVNfT0sgYml0IGlzIHN0aWxsIHNldDogb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4+
PiBzdXBwb3J0IG91ciBzdWJzZXQgb2YgZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51c2Fi
bGUuCj4+PiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2Nv
dmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVw
LAo+Pj4gcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8g
Y29uZmlndXJhdGlvbiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPj4+IDgu
IFNldCB0aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9pbnQgdGhlIGRldmljZSBp
cyDigJxsaXZl4oCdLgo+Pj4KPj4+Cj4+PiBJdGVtIDQgb24gdGhlIGxpc3QgZXhwbGljaXRseSBh
bGxvd3MgcmVhZGluZyBjb25maWcgc3BhY2UgYmVmb3JlCj4+PiBGRUFUVVJFU19PSy4KPj4+Cj4+
PiBJIGNvbmNsdWRlIHRoYXQgVklSVElPX05FVF9GX01UVSBpcyBzZXQgbWVhbnMgInNldCBpbiBk
ZXZpY2UgZmVhdHVyZXMiLgo+Pgo+PiBTbyB0aGlzIHByb2JhYmx5IG5lZWQgc29tZSBjbGFyaWZp
Y2F0aW9uLiAiaXMgc2V0IiBpcyB1c2VkIG1hbnkgdGltZXMgaW4KPj4gdGhlIHNwZWMgdGhhdCBo
YXMgZGlmZmVyZW50IGltcGxpY2F0aW9ucy4KPiBCZWZvcmUgRkVBVFVSRVNfT0sgaXMgc2V0IGJ5
IHRoZSBkcml2ZXIsIEkgZ3Vlc3MgaXQgbWVhbnMgInRoZSBkZXZpY2UKPiBoYXMgb2ZmZXJlZCB0
aGUgZmVhdHVyZSI7CgoKRm9yIG1lIHRoaXMgcGFydCBpcyBvayBzaW5jZSBpdCBjbGFyaWZ5IHRo
YXQgaXQncyB0aGUgZHJpdmVyIHRoYXQgc2V0IAp0aGUgYml0LgoKCgo+IGR1cmluZyBub3JtYWwg
dXNhZ2UsIGl0IG1lYW5zICJ0aGUgZmVhdHVyZQo+IGhhcyBiZWVuIG5lZ290aWF0ZWQiLgoKLz8K
Ckl0IGxvb2tzIHRvIG1lIHRoZSBmZWF0dXJlIG5lZ290aWF0aW9uIGlzIGRvbmUgb25seSBhZnRl
ciBkZXZpY2Ugc2V0IApGRUFUVVJFU19PSywgb3IgRkVBVFVSRVNfT0sgY291bGQgYmUgcmVhZCBm
cm9tIGRldmljZSBzdGF0dXM/CgoKPiAgIChUaGlzIGlzIGEgYml0IGZ1enp5IGZvciBsZWdhY3kg
bW9kZS4pCgoKVGhlIHByb2JsZW0gaXMgdGhlIE1UVSBkZXNjcmlwdGlvbiBmb3IgZXhhbXBsZToK
CiJUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBp
ZiAKVklSVElPX05FVF9GX01UVSBpcyBzZXQuIgoKSXQgbG9va3MgdG8gbWUgbmVlZCB0byB1c2Ug
ImlmIFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0IGJ5IGRldmljZSIuIApPdGhlcndpc2UgcmVhZGVy
cyAoYXQgbGVhc3QgZm9yIG1lKSwgbWF5IHRoaW5rIHRoZSBNVFUgaXMgb25seSB2YWxpZCBpZiAK
ZHJpdmVyIHNldCB0aGUgYml0LgoKCj4KPiBTaG91bGQgd2UgYWRkIGEgd29yZGluZyBjbGFyaWZp
Y2F0aW9uIHRvIHRoZSBzcGVjPwoKCkkgdGhpbmsgc28uCgpUaGFua3MKCj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
