Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A564EC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1141464E90
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1141464E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51DC0606EB;
	Wed, 24 Feb 2021 11:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAqPJ-AZqZ-R; Wed, 24 Feb 2021 11:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFEBD60673;
	Wed, 24 Feb 2021 11:12:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86A94C000A;
	Wed, 24 Feb 2021 11:12:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A0ABC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82DD04EBCE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id csnZPbeXiF5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:12:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 213E64EBCD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614165165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jz4m9vW3IwTEuWasKFpJY8ztrR2cVn8qbQcFHwfqewQ=;
 b=Z2NTXbib+nKsU998bOG99u7kBRcmd8wWKdHzbUPsXzpXYA7+indn9xb0nTMWJJmIGdXs9t
 yvcz3//TqoeczD6LVwxFiY8NwT/H/+iFp58NA/yFgxwntBjC7zZf18iEI9y9Ea8wZh0ZG1
 aNLR3rRr0pnyBMJhTR5RsFvfNpgw6GQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-dsx1tnPdNDWgM6VaZHnmhA-1; Wed, 24 Feb 2021 06:12:43 -0500
X-MC-Unique: dsx1tnPdNDWgM6VaZHnmhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A85219611C0;
 Wed, 24 Feb 2021 11:12:42 +0000 (UTC)
Received: from gondolin (ovpn-114-27.ams2.redhat.com [10.36.114.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAAB577BE5;
 Wed, 24 Feb 2021 11:12:37 +0000 (UTC)
Date: Wed, 24 Feb 2021 12:12:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210224121234.0127ae4b.cohuck@redhat.com>
In-Reply-To: <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
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

T24gV2VkLCAyNCBGZWIgMjAyMSAxNzoyOTowNyArMDgwMApKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gMjAyMS8yLzIzIDY6NTgg5LiL5Y2ILCBDb3JuZWxpYSBI
dWNrIHdyb3RlOgo+ID4gT24gVHVlLCAyMyBGZWIgMjAyMSAxODozMTowNyArMDgwMAo+ID4gSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiAgCj4gPj4gT24gMjAyMS8y
LzIzIDY6MDQg5LiL5Y2ILCBDb3JuZWxpYSBIdWNrIHdyb3RlOiAgCj4gPj4+IE9uIFR1ZSwgMjMg
RmViIDIwMjEgMTc6NDY6MjAgKzA4MDAKPiA+Pj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPj4+ICAgICAKPiA+Pj4+IE9uIDIwMjEvMi8yMyDkuIvljYg1OjI1LCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6ICAKPiA+Pj4+PiBPbiBNb24sIEZlYiAyMiwgMjAyMSBh
dCAwOTowOToyOEFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOiAgCj4gPj4+Pj4+IE9uIDIvMjEv
MjAyMSA4OjE0IFBNLCBKYXNvbiBXYW5nIHdyb3RlOiAgCj4gPj4+Pj4+PiBPbiAyMDIxLzIvMTkg
Nzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6ICAKPiA+Pj4+Pj4+PiBDb21taXQgNDUyNjM5
YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2VkCj4gPj4+Pj4+
Pj4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJl
c2V0Cj4gPj4+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNz
ZWQgYmVmb3JlIGZlYXR1cmVzCj4gPj4+Pj4+Pj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUg
dGhlIHZlcmlmeV9taW5fZmVhdHVyZXMoKSBjaGVjawo+ID4+Pj4+Pj4+IGFuZCBhbGxvdyBmZWF0
dXJlcyByZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4gPj4+Pj4+Pj4KPiA+Pj4+Pj4+PiBJdCdz
IHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4g
Pj4+Pj4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0LiBGb3IgaW5zdGFu
Y2UsIHdoZW4KPiA+Pj4+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNl
ZCBzb21lIG1vZGVybiBkcml2ZXIKPiA+Pj4+Pj4+PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZh
bGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0aGUgY29uZmlnCj4gPj4+Pj4+Pj4gc3BhY2UgYmVm
b3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0LiAgCj4gPj4+Pj4+PiBUaGlzIGxvb2tzIGxpa2Ug
YSBzcGVjIHZpb2xhdGlvbjoKPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiAiCj4gPj4+Pj4+Pgo+ID4+Pj4+
Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMg
aWYKPiA+Pj4+Pj4+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0LiBUaGlzIGZpZWxkIHNwZWNpZmll
cyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZQo+ID4+Pj4+Pj4gZHJpdmVyIHRvIHVzZS4KPiA+Pj4+
Pj4+ICIKPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5k
IHRoaXM/ICAKPiA+Pj4+Pj4gSXNuJ3QgdGhlIGNvbW1pdCA0NTI2MzlhNjRhZDggaXRzZWxmIGlz
IGEgd29ya2Fyb3VuZCBmb3IgbGVnYWN5IGd1ZXN0Pwo+ID4+Pj4+Pgo+ID4+Pj4+PiBJIHRoaW5r
IHRoZSBwb2ludCBpcywgc2luY2UgdGhlcmUncyBsZWdhY3kgZ3Vlc3Qgd2UnZCBoYXZlIHRvIHN1
cHBvcnQsIHRoaXMKPiA+Pj4+Pj4gaG9zdCBzaWRlIHdvcmthcm91bmQgaXMgdW5hdm9pZGFibGUu
IEFsdGhvdWdoIEkgYWdyZWUgdGhlIHZpb2xhdGluZyBkcml2ZXIKPiA+Pj4+Pj4gc2hvdWxkIGJl
IGZpeGVkICh5ZXMsIGl0J3MgaW4gdG9kYXkncyB1cHN0cmVhbSBrZXJuZWwgd2hpY2ggZXhpc3Rz
IGZvciBhCj4gPj4+Pj4+IHdoaWxlIG5vdykuICAKPiA+Pj4+PiBPaCAgeW91IGFyZSByaWdodDoK
PiA+Pj4+Pgo+ID4+Pj4+Cj4gPj4+Pj4gc3RhdGljIGludCB2aXJ0bmV0X3ZhbGlkYXRlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4+Pj4+IHsKPiA+Pj4+PiAgICAgICAgICAgIGlmICgh
dmRldi0+Y29uZmlnLT5nZXQpIHsKPiA+Pj4+PiAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigm
dmRldi0+ZGV2LCAiJXMgZmFpbHVyZTogY29uZmlnIGFjY2VzcyBkaXNhYmxlZFxuIiwKPiA+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7Cj4gPj4+Pj4gICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4+Pj4+ICAgICAgICAgICAgfQo+ID4+Pj4+Cj4g
Pj4+Pj4gICAgICAgICAgICBpZiAoIXZpcnRuZXRfdmFsaWRhdGVfZmVhdHVyZXModmRldikpCj4g
Pj4+Pj4gICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4+Pj4+Cj4gPj4+Pj4g
ICAgICAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NVFUp
KSB7Cj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgIGludCBtdHUgPSB2aXJ0aW9fY3JlYWQxNih2
ZGV2LAo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLAo+ID4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXR1KSk7Cj4gPj4+Pj4gICAg
ICAgICAgICAgICAgICAgIGlmIChtdHUgPCBNSU5fTVRVKQo+ID4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsg
IAo+ID4+Pj4gSSB3b25kZXIgd2h5IG5vdCBzaW1wbHkgZmFpbCBoZXJlPyAgCj4gPj4+IEkgdGhp
bmsgYm90aCBmYWlsaW5nIG9yIG5vdCBhY2NlcHRpbmcgdGhlIGZlYXR1cmUgY2FuIGJlIGFyZ3Vl
ZCB0byBtYWtlCj4gPj4+IHNlbnNlOiAidGhlIGRldmljZSBwcmVzZW50ZWQgdXMgd2l0aCBhIG10
dSBzaXplIHRoYXQgZG9lcyBub3QgbWFrZQo+ID4+PiBzZW5zZSIgd291bGQgcG9pbnQgdG8gZmFp
bGluZywgIndlIGNhbm5vdCB3b3JrIHdpdGggdGhlIG10dSBzaXplIHRoYXQKPiA+Pj4gdGhlIGRl
dmljZSBwcmVzZW50ZWQgdXMiIHdvdWxkIHBvaW50IHRvIG5vdCBuZWdvdGlhdGluZyB0aGUgZmVh
dHVyZS4KPiA+Pj4gICAgIAo+ID4+Pj4gICAgIAo+ID4+Pj4+ICAgICAgICAgICAgfQo+ID4+Pj4+
Cj4gPj4+Pj4gICAgICAgICAgICByZXR1cm4gMDsKPiA+Pj4+PiB9Cj4gPj4+Pj4KPiA+Pj4+PiBB
bmQgdGhlIHNwZWMgc2F5czoKPiA+Pj4+Pgo+ID4+Pj4+Cj4gPj4+Pj4gVGhlIGRyaXZlciBNVVNU
IGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRvIGluaXRpYWxpemUgYSBkZXZpY2U6Cj4gPj4+Pj4gMS4g
UmVzZXQgdGhlIGRldmljZS4KPiA+Pj4+PiAyLiBTZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBi
aXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgZGV2aWNlLgo+ID4+Pj4+IDMuIFNldCB0
aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBrbm93cyBob3cgdG8gZHJpdmUgdGhl
IGRldmljZS4KPiA+Pj4+PiA0LiBSZWFkIGRldmljZSBmZWF0dXJlIGJpdHMsIGFuZCB3cml0ZSB0
aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29kIGJ5IHRoZSBPUyBhbmQgZHJpdmVy
IHRvIHRoZQo+ID4+Pj4+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSBy
ZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlv
bgo+ID4+Pj4+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBkZXZpY2Ug
YmVmb3JlIGFjY2VwdGluZyBpdC4KPiA+Pj4+PiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1
cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldyBmZWF0dXJlIGJpdHMgYWZ0ZXIg
dGhpcyBzdGVwLgo+ID4+Pj4+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhl
IEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2Vz
IG5vdAo+ID4+Pj4+IHN1cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmlj
ZSBpcyB1bnVzYWJsZS4KPiA+Pj4+PiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwg
aW5jbHVkaW5nIGRpc2NvdmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2aWNlLCBvcHRpb25h
bCBwZXItYnVzIHNldHVwLAo+ID4+Pj4+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhl
IGRldmljZeKAmXMgdmlydGlvIGNvbmZpZ3VyYXRpb24gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9m
IHZpcnRxdWV1ZXMuCj4gPj4+Pj4gOC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQg
dGhpcyBwb2ludCB0aGUgZGV2aWNlIGlzIOKAnGxpdmXigJ0uCj4gPj4+Pj4KPiA+Pj4+Pgo+ID4+
Pj4+IEl0ZW0gNCBvbiB0aGUgbGlzdCBleHBsaWNpdGx5IGFsbG93cyByZWFkaW5nIGNvbmZpZyBz
cGFjZSBiZWZvcmUKPiA+Pj4+PiBGRUFUVVJFU19PSy4KPiA+Pj4+Pgo+ID4+Pj4+IEkgY29uY2x1
ZGUgdGhhdCBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldCBtZWFucyAic2V0IGluIGRldmljZSBmZWF0
dXJlcyIuICAKPiA+Pj4+IFNvIHRoaXMgcHJvYmFibHkgbmVlZCBzb21lIGNsYXJpZmljYXRpb24u
ICJpcyBzZXQiIGlzIHVzZWQgbWFueSB0aW1lcyBpbgo+ID4+Pj4gdGhlIHNwZWMgdGhhdCBoYXMg
ZGlmZmVyZW50IGltcGxpY2F0aW9ucy4gIAo+ID4+PiBCZWZvcmUgRkVBVFVSRVNfT0sgaXMgc2V0
IGJ5IHRoZSBkcml2ZXIsIEkgZ3Vlc3MgaXQgbWVhbnMgInRoZSBkZXZpY2UKPiA+Pj4gaGFzIG9m
ZmVyZWQgdGhlIGZlYXR1cmUiOyAgCj4gPj4KPiA+PiBGb3IgbWUgdGhpcyBwYXJ0IGlzIG9rIHNp
bmNlIGl0IGNsYXJpZnkgdGhhdCBpdCdzIHRoZSBkcml2ZXIgdGhhdCBzZXQKPiA+PiB0aGUgYml0
Lgo+ID4+Cj4gPj4KPiA+PiAgCj4gPj4+IGR1cmluZyBub3JtYWwgdXNhZ2UsIGl0IG1lYW5zICJ0
aGUgZmVhdHVyZQo+ID4+PiBoYXMgYmVlbiBuZWdvdGlhdGVkIi4gIAo+ID4+IC8/Cj4gPj4KPiA+
PiBJdCBsb29rcyB0byBtZSB0aGUgZmVhdHVyZSBuZWdvdGlhdGlvbiBpcyBkb25lIG9ubHkgYWZ0
ZXIgZGV2aWNlIHNldAo+ID4+IEZFQVRVUkVTX09LLCBvciBGRUFUVVJFU19PSyBjb3VsZCBiZSBy
ZWFkIGZyb20gZGV2aWNlIHN0YXR1cz8gIAo+ID4gSSdkIGNvbnNpZGVyIGZlYXR1cmUgbmVnb3Rp
YXRpb24gZG9uZSB3aGVuIHRoZSBkcml2ZXIgcmVhZHMgRkVBVFVSRVNfT0sKPiA+IGJhY2sgZnJv
bSB0aGUgc3RhdHVzLiAgCj4gCj4gCj4gSSBhZ3JlZS4KPiAKPiAKPiA+ICAKPiA+PiAgCj4gPj4+
ICAgIChUaGlzIGlzIGEgYml0IGZ1enp5IGZvciBsZWdhY3kgbW9kZS4pICAKPiA+IC4uLmJlY2F1
c2UgbGVnYWN5IGRvZXMgbm90IGhhdmUgRkVBVFVSRVNfT0suCj4gPiAgICAgIAo+ID4+Cj4gPj4g
VGhlIHByb2JsZW0gaXMgdGhlIE1UVSBkZXNjcmlwdGlvbiBmb3IgZXhhbXBsZToKPiA+Pgo+ID4+
ICJUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBp
Zgo+ID4+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0LiIKPiA+Pgo+ID4+IEl0IGxvb2tzIHRvIG1l
IG5lZWQgdG8gdXNlICJpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldCBieSBkZXZpY2UiLiAgCj4g
PiAib2ZmZXJlZCBieSB0aGUgZGV2aWNlIj8gSSBkb24ndCB0aGluayBpdCBzaG91bGQgJ2Rpc2Fw
cGVhcicgZnJvbSB0aGUKPiA+IGNvbmZpZyBzcGFjZSBpZiB0aGUgZHJpdmVyIHdvbid0IHVzZSBp
dC4gKFNhbWUgZm9yIG90aGVyIGNvbmZpZyBzcGFjZQo+ID4gZmllbGRzIHRoYXQgYXJlIHRpZWQg
dG8gZmVhdHVyZSBiaXRzLikgIAo+IAo+IAo+IEJ1dCB3aGF0IGhhcHBlbnMgaWYgZS5nIGRldmlj
ZSBkb2Vzbid0IG9mZmVyIFZJUlRJT19ORVRfRl9NVFU/IEl0IGxvb2tzIAo+IHRvIGFjY29yZGlu
ZyB0byB0aGUgc3BlYyB0aGVyZSB3aWxsIGJlIG5vIG10dSBmaWVsZC4KCkkgdGhpbmsgc28sIHll
cy4KCj4gCj4gQW5kIGEgbW9yZSBpbnRlcmVzdGluZyBjYXNlIGlzIFZJUlRJT19ORVRfRl9NUSBp
cyBub3Qgb2ZmZXJlZCBidXQgCj4gVklSVElPX05FVF9GX01UVSBvZmZlcmVkLiBUbyBtZSwgaXQg
bWVhbnMgd2UgZG9uJ3QgaGF2ZSAKPiBtYXhfdmlydHF1ZXVlX3BhaXJzIGJ1dCBpdCdzIG5vdCBo
b3cgdGhlIGRyaXZlciBpcyB3cm90ZSB0b2RheS4KClRoYXQgd291bGQgYmUgYSBidWcsIGJ1dCBp
dCBzZWVtcyB0byBtZSB0aGF0IHRoZSB2aXJ0aW8tbmV0IGRyaXZlcgpyZWFkcyBtYXhfdmlydHF1
ZXVlX3BhaXJzIGNvbmRpdGlvbmFsbHkgYW5kIGhhbmRsZXMgYWJzZW5jZSBvZiB0aGUKZmVhdHVy
ZSBjb3JyZWN0bHk/Cgo+IAo+IAo+ID4gICAgIAo+ID4+IE90aGVyd2lzZSByZWFkZXJzIChhdCBs
ZWFzdCBmb3IgbWUpLCBtYXkgdGhpbmsgdGhlIE1UVSBpcyBvbmx5IHZhbGlkCj4gPj4gaWYgZHJp
dmVyIHNldCB0aGUgYml0LiAgCj4gPiBJIHRoaW5rIGl0IHdvdWxkIHN0aWxsIGJlICd2YWxpZCcg
aW4gdGhlIHNlbnNlIHRoYXQgaXQgZXhpc3RzIGFuZCBoYXMKPiA+IHNvbWUgdmFsdWUgaW4gdGhl
cmUgZmlsbGVkIGluIGJ5IHRoZSBkZXZpY2UsIGJ1dCBhIGRyaXZlciByZWFkaW5nIGl0Cj4gPiB3
aXRob3V0IG5lZ290aWF0aW5nIHRoZSBmZWF0dXJlIHdvdWxkIGJlIGJ1Z2d5LiAoTGlrZSBpbiB0
aGUga2VybmVsCj4gPiBjb2RlIGFib3ZlOyB0aGUga2VybmVsIG5vdCBsaWtpbmcgdGhlIHZhbHVl
IGRvZXMgbm90IG1ha2UgdGhlIGZpZWxkCj4gPiBpbnZhbGlkLikgIAo+IAo+IAo+IFNlZSBNaWNo
YWVsJ3MgcmVwbHksIHRoZSBzcGVjIGFsbG93cyByZWFkIHRoZSBjb25maWcgYmVmb3JlIHNldHRp
bmcgCj4gZmVhdHVyZXMuCgpZZXMsIHRoZSBwZXJpb2QgcHJpb3IgdG8gZmluaXNoaW5nIG5lZ290
aWF0aW9uIGlzIG9idmlvdXNseSBzcGVjaWFsLgoKPiAKPiAKPiA+Cj4gPiBNYXliZSBhIHN0YXRl
bWVudCBjb3ZlcmluZyBldmVyeXRoaW5nIHdvdWxkIGJlOgo+ID4KPiA+ICJUaGUgZm9sbG93aW5n
IGRyaXZlci1yZWFkLW9ubHkgZmllbGQgbXR1IG9ubHkgZXhpc3RzIGlmIHRoZSBkZXZpY2UKPiA+
IG9mZmVycyBWSVJUSU9fTkVUX0ZfTVRVIGFuZCBtYXkgYmUgcmVhZCBieSB0aGUgZHJpdmVyIGR1
cmluZyBmZWF0dXJlCj4gPiBuZWdvdGlhdGlvbiBhbmQgYWZ0ZXIgVklSVElPX05FVF9GX01UVSBo
YXMgYmVlbiBzdWNjZXNzZnVsbHkKPiA+IG5lZ290aWF0ZWQuIgo+ID4gIAo+ID4+ICAKPiA+Pj4g
U2hvdWxkIHdlIGFkZCBhIHdvcmRpbmcgY2xhcmlmaWNhdGlvbiB0byB0aGUgc3BlYz8gIAo+ID4+
Cj4gPj4gSSB0aGluayBzby4gIAo+ID4gU29tZSBjbGFyaWZpY2F0aW9uIHdvdWxkIGJlIG5lZWRl
ZCBmb3IgZWFjaCBmaWVsZCB0aGF0IGRlcGVuZHMgb24gYQo+ID4gZmVhdHVyZTsgdGhhdCB3b3Vs
ZCBiZSBxdWl0ZSB2ZXJib3NlLiBNYXliZSB3ZSBjYW4gZ2V0IGF3YXkgd2l0aCBhCj4gPiBjbGFy
aWZ5aW5nIHN0YXRlbWVudD8KPiA+Cj4gPiAiU29tZSBjb25maWcgc3BhY2UgZmllbGRzIG1heSBk
ZXBlbmQgb24gYSBjZXJ0YWluIGZlYXR1cmUuIEluIHRoYXQKPiA+IGNhc2UsIHRoZSBmaWVsZCBl
eGl0cyBpZiB0aGUgZGV2aWNlIGhhcyBvZmZlcmVkIHRoZSBjb3JyZXNwb25kaW5nCj4gPiBmZWF0
dXJlLCAgCj4gCj4gCj4gU28gdGhpcyBpbXBsaWVzIGZvciAhVklSVElPX05FVF9GX01RICYmIFZJ
UlRJT19ORVRfRl9NVFUsIHRoZSBjb25maWcgCj4gd2lsbCBsb29rIGxpa2U6Cj4gCj4gc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnIHsKPiAgwqDCoMKgwqDCoMKgwqAgdTggbWFjWzZdOwo+ICDCoMKg
wqDCoMKgwqDCoCBsZTE2IHN0YXR1czsKPiAgwqDCoMKgwqDCoMKgwqAgbGUxNiBtdHU7Cj4gfTsK
PiAKCkkgYWdyZWUuCgo+IAo+ID4gICBhbmQgbWF5IGJlIHJlYWQgYnkgdGhlIGRyaXZlciBkdXJp
bmcgZmVhdHVyZSBuZWdvdGlhdGlvbiwgYW5kCj4gPiBhY2Nlc3NlZCBieSB0aGUgZHJpdmVyIGFm
dGVyIHRoZSBmZWF0dXJlIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseQo+ID4gbmVnb3RpYXRlZC4gQSBz
aG9ydGhhbmQgZm9yIHRoaXMgaXMgYSBzdGF0ZW1lbnQgdGhhdCBhIGZpZWxkIG9ubHkKPiA+IGV4
aXN0cyBpZiBhIGNlcnRhaW4gZmVhdHVyZSBiaXQgaXMgc2V0LiIgIAo+IAo+IAo+IEknbSBub3Qg
c3VyZSB1c2luZyAic2hvcnRoYW5kIiBpcyBnb29kIGZvciB0aGUgc3BlYywgYXQgbGVhc3Qgd2Ug
Y2FuIAo+IGxpbWl0IHRoZSBpdHMgc2NvcGUgb25seSB0byB0aGUgY29uZmlndXJhdGlvbiBzcGFj
ZSBwYXJ0LgoKTWF5YmUgImEgc2hvcnRoYW5kIGV4cHJlc3Npb24iPwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
