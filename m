Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC44C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:29:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5305B64E7A
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5305B64E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB0CF83A57;
	Wed, 24 Feb 2021 09:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id afDA1OxUJSSk; Wed, 24 Feb 2021 09:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5361083AE1;
	Wed, 24 Feb 2021 09:29:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12352C000B;
	Wed, 24 Feb 2021 09:29:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2BDC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1B024308C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jtFnQNhzU0QT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:29:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE41B43090
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614158965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNtdDzJAxD0kMh6MRb1tqAOLmiK6v+5Rquca1MsBMDU=;
 b=JBiih789NNUoLtNaQyzQVgYGIDGpXkvp6F1+TsVB6rMvhmBnIf8mIpwXjI41PuxRDikmix
 koSzLeA1+sthhFxpb82w6T0XIcLCSlRfY4L1tQ2Qa7Q7p12oG2DZ4A2lQIPBw0XsQty7rd
 Skd4NFio0Oru0npLOcYnxDnt2ZbWJwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-6pz0pknxOPKjMau4nOB0sQ-1; Wed, 24 Feb 2021 04:29:16 -0500
X-MC-Unique: 6pz0pknxOPKjMau4nOB0sQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04EE3107ACF8;
 Wed, 24 Feb 2021 09:29:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6923F5D9D0;
 Wed, 24 Feb 2021 09:29:09 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: Cornelia Huck <cohuck@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
Date: Wed, 24 Feb 2021 17:29:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223115833.732d809c.cohuck@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMi8yMyA2OjU4IOS4i+WNiCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPiBPbiBUdWUs
IDIzIEZlYiAyMDIxIDE4OjMxOjA3ICswODAwCj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPj4gT24gMjAyMS8yLzIzIDY6MDQg5LiL5Y2ILCBDb3JuZWxpYSBIdWNr
IHdyb3RlOgo+Pj4gT24gVHVlLCAyMyBGZWIgMjAyMSAxNzo0NjoyMCArMDgwMAo+Pj4gSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+PiAgIAo+Pj4+IE9uIDIwMjEvMi8y
MyDkuIvljYg1OjI1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgRmVi
IDIyLCAyMDIxIGF0IDA5OjA5OjI4QU0gLTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+PiBP
biAyLzIxLzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+PiBPbiAyMDIxLzIv
MTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4+IENvbW1pdCA0NTI2Mzlh
NjRhZDggKCJ2ZHBhOiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPj4+Pj4+Pj4g
Zm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0
Cj4+Pj4+Pj4+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJl
Zm9yZSBmZWF0dXJlcwo+Pj4+Pj4+PiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVy
aWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4+Pj4+Pj4+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNl
dCB0byAwIGZvciB0aGlzIGNhc2UuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEl0J3Mgd29ydGggbm90aW5n
IHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nlc3MKPj4+Pj4+Pj4gY29uZmln
IHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0LiBGb3IgaW5zdGFuY2UsIHdoZW4KPj4+Pj4+
Pj4gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJp
dmVyCj4+Pj4+Pj4+IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVz
ZW50IGluIHRoZSBjb25maWcKPj4+Pj4+Pj4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBh
cmUgc2V0Lgo+Pj4+Pj4+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+Pj4+Pj4+
Cj4+Pj4+Pj4gIgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5
IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPj4+Pj4+PiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNl
dC4gVGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRVIGZvciB0aGUKPj4+Pj4+PiBk
cml2ZXIgdG8gdXNlLgo+Pj4+Pj4+ICIKPj4+Pj4+Pgo+Pj4+Pj4+IERvIHdlIHJlYWxseSB3YW50
IHRvIHdvcmthcm91bmQgdGhpcz8KPj4+Pj4+IElzbid0IHRoZSBjb21taXQgNDUyNjM5YTY0YWQ4
IGl0c2VsZiBpcyBhIHdvcmthcm91bmQgZm9yIGxlZ2FjeSBndWVzdD8KPj4+Pj4+Cj4+Pj4+PiBJ
IHRoaW5rIHRoZSBwb2ludCBpcywgc2luY2UgdGhlcmUncyBsZWdhY3kgZ3Vlc3Qgd2UnZCBoYXZl
IHRvIHN1cHBvcnQsIHRoaXMKPj4+Pj4+IGhvc3Qgc2lkZSB3b3JrYXJvdW5kIGlzIHVuYXZvaWRh
YmxlLiBBbHRob3VnaCBJIGFncmVlIHRoZSB2aW9sYXRpbmcgZHJpdmVyCj4+Pj4+PiBzaG91bGQg
YmUgZml4ZWQgKHllcywgaXQncyBpbiB0b2RheSdzIHVwc3RyZWFtIGtlcm5lbCB3aGljaCBleGlz
dHMgZm9yIGEKPj4+Pj4+IHdoaWxlIG5vdykuCj4+Pj4+IE9oICB5b3UgYXJlIHJpZ2h0Ogo+Pj4+
Pgo+Pj4+Pgo+Pj4+PiBzdGF0aWMgaW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpCj4+Pj4+IHsKPj4+Pj4gICAgICAgICAgICBpZiAoIXZkZXYtPmNvbmZpZy0+
Z2V0KSB7Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZ2ZGV2LT5kZXYsICIlcyBm
YWlsdXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4iLAo+Pj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBfX2Z1bmNfXyk7Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsKPj4+Pj4gICAgICAgICAgICB9Cj4+Pj4+Cj4+Pj4+ICAgICAgICAgICAgaWYgKCF2aXJ0
bmV0X3ZhbGlkYXRlX2ZlYXR1cmVzKHZkZXYpKQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7Cj4+Pj4+Cj4+Pj4+ICAgICAgICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVy
ZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewo+Pj4+PiAgICAgICAgICAgICAgICAgICAgaW50
IG10dSA9IHZpcnRpb19jcmVhZDE2KHZkZXYsCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLAo+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG10dSkpOwo+Pj4+PiAgICAgICAgICAgICAgICAgICAgaWYgKG10dSA8IE1JTl9NVFUpCj4+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJU
SU9fTkVUX0ZfTVRVKTsKPj4+PiBJIHdvbmRlciB3aHkgbm90IHNpbXBseSBmYWlsIGhlcmU/Cj4+
PiBJIHRoaW5rIGJvdGggZmFpbGluZyBvciBub3QgYWNjZXB0aW5nIHRoZSBmZWF0dXJlIGNhbiBi
ZSBhcmd1ZWQgdG8gbWFrZQo+Pj4gc2Vuc2U6ICJ0aGUgZGV2aWNlIHByZXNlbnRlZCB1cyB3aXRo
IGEgbXR1IHNpemUgdGhhdCBkb2VzIG5vdCBtYWtlCj4+PiBzZW5zZSIgd291bGQgcG9pbnQgdG8g
ZmFpbGluZywgIndlIGNhbm5vdCB3b3JrIHdpdGggdGhlIG10dSBzaXplIHRoYXQKPj4+IHRoZSBk
ZXZpY2UgcHJlc2VudGVkIHVzIiB3b3VsZCBwb2ludCB0byBub3QgbmVnb3RpYXRpbmcgdGhlIGZl
YXR1cmUuCj4+PiAgIAo+Pj4+ICAgCj4+Pj4+ICAgICAgICAgICAgfQo+Pj4+Pgo+Pj4+PiAgICAg
ICAgICAgIHJldHVybiAwOwo+Pj4+PiB9Cj4+Pj4+Cj4+Pj4+IEFuZCB0aGUgc3BlYyBzYXlzOgo+
Pj4+Pgo+Pj4+Pgo+Pj4+PiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVuY2UgdG8g
aW5pdGlhbGl6ZSBhIGRldmljZToKPj4+Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+Pj4gMi4g
U2V0IHRoZSBBQ0tOT1dMRURHRSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzIG5vdGljZWQg
dGhlIGRldmljZS4KPj4+Pj4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0
IE9TIGtub3dzIGhvdyB0byBkcml2ZSB0aGUgZGV2aWNlLgo+Pj4+PiA0LiBSZWFkIGRldmljZSBm
ZWF0dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0
b29kIGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZQo+Pj4+PiBkZXZpY2UuIER1cmluZyB0aGlz
IHN0ZXAgdGhlIGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKSB0aGUgZGV2aWNl
LXNwZWNpZmljIGNvbmZpZ3VyYXRpb24KPj4+Pj4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2Fu
IHN1cHBvcnQgdGhlIGRldmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+Pj4+PiA1LiBTZXQgdGhl
IEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldyBm
ZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+Pj4+PiA2LiBSZS1yZWFkIGRldmljZSBzdGF0
dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBiaXQgaXMgc3RpbGwgc2V0OiBvdGhlcndpc2Us
IHRoZSBkZXZpY2UgZG9lcyBub3QKPj4+Pj4gc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVz
IGFuZCB0aGUgZGV2aWNlIGlzIHVudXNhYmxlLgo+Pj4+PiA3LiBQZXJmb3JtIGRldmljZS1zcGVj
aWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2NvdmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2
aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+Pj4+PiByZWFkaW5nIGFuZCBwb3NzaWJseSB3
cml0aW5nIHRoZSBkZXZpY2XigJlzIHZpcnRpbyBjb25maWd1cmF0aW9uIHNwYWNlLCBhbmQgcG9w
dWxhdGlvbiBvZiB2aXJ0cXVldWVzLgo+Pj4+PiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMg
Yml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPj4+Pj4KPj4+Pj4K
Pj4+Pj4gSXRlbSA0IG9uIHRoZSBsaXN0IGV4cGxpY2l0bHkgYWxsb3dzIHJlYWRpbmcgY29uZmln
IHNwYWNlIGJlZm9yZQo+Pj4+PiBGRUFUVVJFU19PSy4KPj4+Pj4KPj4+Pj4gSSBjb25jbHVkZSB0
aGF0IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0IG1lYW5zICJzZXQgaW4gZGV2aWNlIGZlYXR1cmVz
Ii4KPj4+PiBTbyB0aGlzIHByb2JhYmx5IG5lZWQgc29tZSBjbGFyaWZpY2F0aW9uLiAiaXMgc2V0
IiBpcyB1c2VkIG1hbnkgdGltZXMgaW4KPj4+PiB0aGUgc3BlYyB0aGF0IGhhcyBkaWZmZXJlbnQg
aW1wbGljYXRpb25zLgo+Pj4gQmVmb3JlIEZFQVRVUkVTX09LIGlzIHNldCBieSB0aGUgZHJpdmVy
LCBJIGd1ZXNzIGl0IG1lYW5zICJ0aGUgZGV2aWNlCj4+PiBoYXMgb2ZmZXJlZCB0aGUgZmVhdHVy
ZSI7Cj4+Cj4+IEZvciBtZSB0aGlzIHBhcnQgaXMgb2sgc2luY2UgaXQgY2xhcmlmeSB0aGF0IGl0
J3MgdGhlIGRyaXZlciB0aGF0IHNldAo+PiB0aGUgYml0Lgo+Pgo+Pgo+Pgo+Pj4gZHVyaW5nIG5v
cm1hbCB1c2FnZSwgaXQgbWVhbnMgInRoZSBmZWF0dXJlCj4+PiBoYXMgYmVlbiBuZWdvdGlhdGVk
Ii4KPj4gLz8KPj4KPj4gSXQgbG9va3MgdG8gbWUgdGhlIGZlYXR1cmUgbmVnb3RpYXRpb24gaXMg
ZG9uZSBvbmx5IGFmdGVyIGRldmljZSBzZXQKPj4gRkVBVFVSRVNfT0ssIG9yIEZFQVRVUkVTX09L
IGNvdWxkIGJlIHJlYWQgZnJvbSBkZXZpY2Ugc3RhdHVzPwo+IEknZCBjb25zaWRlciBmZWF0dXJl
IG5lZ290aWF0aW9uIGRvbmUgd2hlbiB0aGUgZHJpdmVyIHJlYWRzIEZFQVRVUkVTX09LCj4gYmFj
ayBmcm9tIHRoZSBzdGF0dXMuCgoKSSBhZ3JlZS4KCgo+Cj4+Cj4+PiAgICAoVGhpcyBpcyBhIGJp
dCBmdXp6eSBmb3IgbGVnYWN5IG1vZGUuKQo+IC4uLmJlY2F1c2UgbGVnYWN5IGRvZXMgbm90IGhh
dmUgRkVBVFVSRVNfT0suCj4gICAgCj4+Cj4+IFRoZSBwcm9ibGVtIGlzIHRoZSBNVFUgZGVzY3Jp
cHRpb24gZm9yIGV4YW1wbGU6Cj4+Cj4+ICJUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkg
ZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZgo+PiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldC4iCj4+
Cj4+IEl0IGxvb2tzIHRvIG1lIG5lZWQgdG8gdXNlICJpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNl
dCBieSBkZXZpY2UiLgo+ICJvZmZlcmVkIGJ5IHRoZSBkZXZpY2UiPyBJIGRvbid0IHRoaW5rIGl0
IHNob3VsZCAnZGlzYXBwZWFyJyBmcm9tIHRoZQo+IGNvbmZpZyBzcGFjZSBpZiB0aGUgZHJpdmVy
IHdvbid0IHVzZSBpdC4gKFNhbWUgZm9yIG90aGVyIGNvbmZpZyBzcGFjZQo+IGZpZWxkcyB0aGF0
IGFyZSB0aWVkIHRvIGZlYXR1cmUgYml0cy4pCgoKQnV0IHdoYXQgaGFwcGVucyBpZiBlLmcgZGV2
aWNlIGRvZXNuJ3Qgb2ZmZXIgVklSVElPX05FVF9GX01UVT8gSXQgbG9va3MgCnRvIGFjY29yZGlu
ZyB0byB0aGUgc3BlYyB0aGVyZSB3aWxsIGJlIG5vIG10dSBmaWVsZC4KCkFuZCBhIG1vcmUgaW50
ZXJlc3RpbmcgY2FzZSBpcyBWSVJUSU9fTkVUX0ZfTVEgaXMgbm90IG9mZmVyZWQgYnV0IApWSVJU
SU9fTkVUX0ZfTVRVIG9mZmVyZWQuIFRvIG1lLCBpdCBtZWFucyB3ZSBkb24ndCBoYXZlIAptYXhf
dmlydHF1ZXVlX3BhaXJzIGJ1dCBpdCdzIG5vdCBob3cgdGhlIGRyaXZlciBpcyB3cm90ZSB0b2Rh
eS4KCgo+ICAgCj4+IE90aGVyd2lzZSByZWFkZXJzIChhdCBsZWFzdCBmb3IgbWUpLCBtYXkgdGhp
bmsgdGhlIE1UVSBpcyBvbmx5IHZhbGlkCj4+IGlmIGRyaXZlciBzZXQgdGhlIGJpdC4KPiBJIHRo
aW5rIGl0IHdvdWxkIHN0aWxsIGJlICd2YWxpZCcgaW4gdGhlIHNlbnNlIHRoYXQgaXQgZXhpc3Rz
IGFuZCBoYXMKPiBzb21lIHZhbHVlIGluIHRoZXJlIGZpbGxlZCBpbiBieSB0aGUgZGV2aWNlLCBi
dXQgYSBkcml2ZXIgcmVhZGluZyBpdAo+IHdpdGhvdXQgbmVnb3RpYXRpbmcgdGhlIGZlYXR1cmUg
d291bGQgYmUgYnVnZ3kuIChMaWtlIGluIHRoZSBrZXJuZWwKPiBjb2RlIGFib3ZlOyB0aGUga2Vy
bmVsIG5vdCBsaWtpbmcgdGhlIHZhbHVlIGRvZXMgbm90IG1ha2UgdGhlIGZpZWxkCj4gaW52YWxp
ZC4pCgoKU2VlIE1pY2hhZWwncyByZXBseSwgdGhlIHNwZWMgYWxsb3dzIHJlYWQgdGhlIGNvbmZp
ZyBiZWZvcmUgc2V0dGluZyAKZmVhdHVyZXMuCgoKPgo+IE1heWJlIGEgc3RhdGVtZW50IGNvdmVy
aW5nIGV2ZXJ5dGhpbmcgd291bGQgYmU6Cj4KPiAiVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1v
bmx5IGZpZWxkIG10dSBvbmx5IGV4aXN0cyBpZiB0aGUgZGV2aWNlCj4gb2ZmZXJzIFZJUlRJT19O
RVRfRl9NVFUgYW5kIG1heSBiZSByZWFkIGJ5IHRoZSBkcml2ZXIgZHVyaW5nIGZlYXR1cmUKPiBu
ZWdvdGlhdGlvbiBhbmQgYWZ0ZXIgVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBzdWNjZXNzZnVs
bHkKPiBuZWdvdGlhdGVkLiIKPgo+Pgo+Pj4gU2hvdWxkIHdlIGFkZCBhIHdvcmRpbmcgY2xhcmlm
aWNhdGlvbiB0byB0aGUgc3BlYz8KPj4KPj4gSSB0aGluayBzby4KPiBTb21lIGNsYXJpZmljYXRp
b24gd291bGQgYmUgbmVlZGVkIGZvciBlYWNoIGZpZWxkIHRoYXQgZGVwZW5kcyBvbiBhCj4gZmVh
dHVyZTsgdGhhdCB3b3VsZCBiZSBxdWl0ZSB2ZXJib3NlLiBNYXliZSB3ZSBjYW4gZ2V0IGF3YXkg
d2l0aCBhCj4gY2xhcmlmeWluZyBzdGF0ZW1lbnQ/Cj4KPiAiU29tZSBjb25maWcgc3BhY2UgZmll
bGRzIG1heSBkZXBlbmQgb24gYSBjZXJ0YWluIGZlYXR1cmUuIEluIHRoYXQKPiBjYXNlLCB0aGUg
ZmllbGQgZXhpdHMgaWYgdGhlIGRldmljZSBoYXMgb2ZmZXJlZCB0aGUgY29ycmVzcG9uZGluZwo+
IGZlYXR1cmUsCgoKU28gdGhpcyBpbXBsaWVzIGZvciAhVklSVElPX05FVF9GX01RICYmIFZJUlRJ
T19ORVRfRl9NVFUsIHRoZSBjb25maWcgCndpbGwgbG9vayBsaWtlOgoKc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnIHsKIMKgwqDCoMKgwqDCoMKgIHU4IG1hY1s2XTsKIMKgwqDCoMKgwqDCoMKgIGxl
MTYgc3RhdHVzOwogwqDCoMKgwqDCoMKgwqAgbGUxNiBtdHU7Cn07CgoKPiAgIGFuZCBtYXkgYmUg
cmVhZCBieSB0aGUgZHJpdmVyIGR1cmluZyBmZWF0dXJlIG5lZ290aWF0aW9uLCBhbmQKPiBhY2Nl
c3NlZCBieSB0aGUgZHJpdmVyIGFmdGVyIHRoZSBmZWF0dXJlIGhhcyBiZWVuIHN1Y2Nlc3NmdWxs
eQo+IG5lZ290aWF0ZWQuIEEgc2hvcnRoYW5kIGZvciB0aGlzIGlzIGEgc3RhdGVtZW50IHRoYXQg
YSBmaWVsZCBvbmx5Cj4gZXhpc3RzIGlmIGEgY2VydGFpbiBmZWF0dXJlIGJpdCBpcyBzZXQuIgoK
CkknbSBub3Qgc3VyZSB1c2luZyAic2hvcnRoYW5kIiBpcyBnb29kIGZvciB0aGUgc3BlYywgYXQg
bGVhc3Qgd2UgY2FuIApsaW1pdCB0aGUgaXRzIHNjb3BlIG9ubHkgdG8gdGhlIGNvbmZpZ3VyYXRp
b24gc3BhY2UgcGFydC4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
