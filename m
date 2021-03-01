Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE892C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 03:51:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495B360230
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 03:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495B360230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E927F83147;
	Mon,  1 Mar 2021 03:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wP8raPjb6y5b; Mon,  1 Mar 2021 03:51:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1278883134;
	Mon,  1 Mar 2021 03:51:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6035C000B;
	Mon,  1 Mar 2021 03:51:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 294CBC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0181B414F1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6LrJUIgkQOg
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:51:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCE39414E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614570681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5AV9txea6W6j85fvcTimyfYzuW7KnS11GDlbniChJY=;
 b=hHIydsCk3s6myM9xezr1evTvKx41nQxc+zjK4JNS//pWopBLj5Z7RtpgL6F0wxrXGho01t
 mpwCnbBQlcCFUTCYfZL9fkIG/oh78EBlyhZpYh2Xwt7hFGq2z7SUeV9AtOuFSkdX3kD1Yp
 K3iIZxj/3y24j5Rdt78RCUFMTrFkJcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-fBO-8IKZMOmnUGmdSdLJBQ-1; Sun, 28 Feb 2021 22:51:19 -0500
X-MC-Unique: fBO-8IKZMOmnUGmdSdLJBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E807C8030CC;
 Mon,  1 Mar 2021 03:51:16 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-164.pek2.redhat.com
 [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCEA460636;
 Mon,  1 Mar 2021 03:51:09 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cdd72199-ac7b-cc8d-2c40-81e43162c532@redhat.com>
Date: Mon, 1 Mar 2021 11:51:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210228162306-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMy8xIDU6MjUg5LiK5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
RnJpLCBGZWIgMjYsIDIwMjEgYXQgMDQ6MTk6MTZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAyMS8yLzI2IDI6NTMg5LiK5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+
PiBPbiBUaHUsIEZlYiAyNSwgMjAyMSBhdCAxMjozNjowN1BNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4+IE9uIDIwMjEvMi8yNCA3OjEyIOS4i+WNiCwgQ29ybmVsaWEgSHVjayB3cm90ZToK
Pj4+Pj4gT24gV2VkLCAyNCBGZWIgMjAyMSAxNzoyOTowNyArMDgwMAo+Pj4+PiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4KPj4+Pj4+IE9uIDIwMjEvMi8yMyA2
OjU4IOS4i+WNiCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPj4+Pj4+PiBPbiBUdWUsIDIzIEZlYiAy
MDIxIDE4OjMxOjA3ICswODAwCj4+Pj4+Pj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+Pj4+Pj4+IE9uIDIwMjEvMi8yMyA2OjA0IOS4i+WNiCwgQ29ybmVsaWEgSHVj
ayB3cm90ZToKPj4+Pj4+Pj4+IE9uIFR1ZSwgMjMgRmViIDIwMjEgMTc6NDY6MjAgKzA4MDAKPj4+
Pj4+Pj4+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4+
IE9uIDIwMjEvMi8yMyDkuIvljYg1OjI1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+
Pj4+Pj4+IE9uIE1vbiwgRmViIDIyLCAyMDIxIGF0IDA5OjA5OjI4QU0gLTA4MDAsIFNpLVdlaSBM
aXUgd3JvdGU6Cj4+Pj4+Pj4+Pj4+PiBPbiAyLzIxLzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Pj4+Pj4+Pj4+PiBPbiAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUg
d3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtlIHN1
cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPj4+Pj4+Pj4+Pj4+Pj4gZm9yIGxlZ2FjeSIpIG1h
ZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4+Pj4+Pj4+Pj4+Pj4+
IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJlZm9yZSBmZWF0
dXJlcwo+Pj4+Pj4+Pj4+Pj4+PiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5
X21pbl9mZWF0dXJlcygpIGNoZWNrCj4+Pj4+Pj4+Pj4+Pj4+IGFuZCBhbGxvdyBmZWF0dXJlcyBy
ZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEl0
J3Mgd29ydGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nlc3MK
Pj4+Pj4+Pj4+Pj4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0LiBGb3Ig
aW5zdGFuY2UsIHdoZW4KPj4+Pj4+Pj4+Pj4+Pj4gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlz
IGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4+Pj4+Pj4+Pj4+Pj4+IHdpbGwgdHJ5IHRv
IGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVzZW50IGluIHRoZSBjb25maWcKPj4+Pj4+
Pj4+Pj4+Pj4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0Lgo+Pj4+Pj4+Pj4+
Pj4+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4gIgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2
ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPj4+Pj4+Pj4+Pj4+PiBWSVJU
SU9fTkVUX0ZfTVRVIGlzIHNldC4gVGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRV
IGZvciB0aGUKPj4+Pj4+Pj4+Pj4+PiBkcml2ZXIgdG8gdXNlLgo+Pj4+Pj4+Pj4+Pj4+ICIKPj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQg
dGhpcz8KPj4+Pj4+Pj4+Pj4+IElzbid0IHRoZSBjb21taXQgNDUyNjM5YTY0YWQ4IGl0c2VsZiBp
cyBhIHdvcmthcm91bmQgZm9yIGxlZ2FjeSBndWVzdD8KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
PiBJIHRoaW5rIHRoZSBwb2ludCBpcywgc2luY2UgdGhlcmUncyBsZWdhY3kgZ3Vlc3Qgd2UnZCBo
YXZlIHRvIHN1cHBvcnQsIHRoaXMKPj4+Pj4+Pj4+Pj4+IGhvc3Qgc2lkZSB3b3JrYXJvdW5kIGlz
IHVuYXZvaWRhYmxlLiBBbHRob3VnaCBJIGFncmVlIHRoZSB2aW9sYXRpbmcgZHJpdmVyCj4+Pj4+
Pj4+Pj4+PiBzaG91bGQgYmUgZml4ZWQgKHllcywgaXQncyBpbiB0b2RheSdzIHVwc3RyZWFtIGtl
cm5lbCB3aGljaCBleGlzdHMgZm9yIGEKPj4+Pj4+Pj4+Pj4+IHdoaWxlIG5vdykuCj4+Pj4+Pj4+
Pj4+IE9oICB5b3UgYXJlIHJpZ2h0Ogo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
PiBzdGF0aWMgaW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYp
Cj4+Pj4+Pj4+Pj4+IHsKPj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICBpZiAoIXZkZXYtPmNvbmZp
Zy0+Z2V0KSB7Cj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZ2ZGV2
LT5kZXYsICIlcyBmYWlsdXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4iLAo+Pj4+Pj4+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7Cj4+Pj4+Pj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4+Pj4+Pj4+Pj4gICAgICAgICAg
ICAgICB9Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgaWYgKCF2aXJ0bmV0
X3ZhbGlkYXRlX2ZlYXR1cmVzKHZkZXYpKQo+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAg
aWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewo+Pj4+Pj4+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgaW50IG10dSA9IHZpcnRpb19jcmVhZDE2KHZkZXYs
Cj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLAo+Pj4+Pj4+Pj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10dSkpOwo+
Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgaWYgKG10dSA8IE1JTl9NVFUpCj4+Pj4+
Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2
ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKPj4+Pj4+Pj4+PiBJIHdvbmRlciB3aHkgbm90IHNpbXBs
eSBmYWlsIGhlcmU/Cj4+Pj4+Pj4+PiBJIHRoaW5rIGJvdGggZmFpbGluZyBvciBub3QgYWNjZXB0
aW5nIHRoZSBmZWF0dXJlIGNhbiBiZSBhcmd1ZWQgdG8gbWFrZQo+Pj4+Pj4+Pj4gc2Vuc2U6ICJ0
aGUgZGV2aWNlIHByZXNlbnRlZCB1cyB3aXRoIGEgbXR1IHNpemUgdGhhdCBkb2VzIG5vdCBtYWtl
Cj4+Pj4+Pj4+PiBzZW5zZSIgd291bGQgcG9pbnQgdG8gZmFpbGluZywgIndlIGNhbm5vdCB3b3Jr
IHdpdGggdGhlIG10dSBzaXplIHRoYXQKPj4+Pj4+Pj4+IHRoZSBkZXZpY2UgcHJlc2VudGVkIHVz
IiB3b3VsZCBwb2ludCB0byBub3QgbmVnb3RpYXRpbmcgdGhlIGZlYXR1cmUuCj4+Pj4+Pj4+Pj4+
ICAgICAgICAgICAgICAgfQo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgIHJl
dHVybiAwOwo+Pj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEFuZCB0aGUgc3Bl
YyBzYXlzOgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBUaGUgZHJpdmVyIE1V
U1QgZm9sbG93IHRoaXMgc2VxdWVuY2UgdG8gaW5pdGlhbGl6ZSBhIGRldmljZToKPj4+Pj4+Pj4+
Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+Pj4+Pj4+Pj4gMi4gU2V0IHRoZSBBQ0tOT1dMRURH
RSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzIG5vdGljZWQgdGhlIGRldmljZS4KPj4+Pj4+
Pj4+Pj4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dzIGhv
dyB0byBkcml2ZSB0aGUgZGV2aWNlLgo+Pj4+Pj4+Pj4+PiA0LiBSZWFkIGRldmljZSBmZWF0dXJl
IGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29kIGJ5
IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZQo+Pj4+Pj4+Pj4+PiBkZXZpY2UuIER1cmluZyB0aGlz
IHN0ZXAgdGhlIGRyaXZlciBNQVkgcmVhZCAoYnV0IE1VU1QgTk9UIHdyaXRlKSB0aGUgZGV2aWNl
LXNwZWNpZmljIGNvbmZpZ3VyYXRpb24KPj4+Pj4+Pj4+Pj4gZmllbGRzIHRvIGNoZWNrIHRoYXQg
aXQgY2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+Pj4+Pj4+Pj4+
PiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1Qg
YWNjZXB0IG5ldyBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+Pj4+Pj4+Pj4+PiA2LiBS
ZS1yZWFkIGRldmljZSBzdGF0dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBiaXQgaXMgc3Rp
bGwgc2V0OiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKPj4+Pj4+Pj4+Pj4gc3VwcG9y
dCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVudXNhYmxlLgo+Pj4+
Pj4+Pj4+PiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2Nv
dmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVw
LAo+Pj4+Pj4+Pj4+PiByZWFkaW5nIGFuZCBwb3NzaWJseSB3cml0aW5nIHRoZSBkZXZpY2XigJlz
IHZpcnRpbyBjb25maWd1cmF0aW9uIHNwYWNlLCBhbmQgcG9wdWxhdGlvbiBvZiB2aXJ0cXVldWVz
Lgo+Pj4+Pj4+Pj4+PiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBv
aW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4gSXRlbSA0IG9uIHRoZSBsaXN0IGV4cGxpY2l0bHkgYWxsb3dzIHJlYWRpbmcgY29u
ZmlnIHNwYWNlIGJlZm9yZQo+Pj4+Pj4+Pj4+PiBGRUFUVVJFU19PSy4KPj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4gSSBjb25jbHVkZSB0aGF0IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0IG1lYW5zICJz
ZXQgaW4gZGV2aWNlIGZlYXR1cmVzIi4KPj4+Pj4+Pj4+PiBTbyB0aGlzIHByb2JhYmx5IG5lZWQg
c29tZSBjbGFyaWZpY2F0aW9uLiAiaXMgc2V0IiBpcyB1c2VkIG1hbnkgdGltZXMgaW4KPj4+Pj4+
Pj4+PiB0aGUgc3BlYyB0aGF0IGhhcyBkaWZmZXJlbnQgaW1wbGljYXRpb25zLgo+Pj4+Pj4+Pj4g
QmVmb3JlIEZFQVRVUkVTX09LIGlzIHNldCBieSB0aGUgZHJpdmVyLCBJIGd1ZXNzIGl0IG1lYW5z
ICJ0aGUgZGV2aWNlCj4+Pj4+Pj4+PiBoYXMgb2ZmZXJlZCB0aGUgZmVhdHVyZSI7Cj4+Pj4+Pj4+
IEZvciBtZSB0aGlzIHBhcnQgaXMgb2sgc2luY2UgaXQgY2xhcmlmeSB0aGF0IGl0J3MgdGhlIGRy
aXZlciB0aGF0IHNldAo+Pj4+Pj4+PiB0aGUgYml0Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4gZHVyaW5nIG5vcm1hbCB1c2FnZSwgaXQgbWVhbnMgInRoZSBmZWF0dXJlCj4+Pj4+Pj4+PiBo
YXMgYmVlbiBuZWdvdGlhdGVkIi4KPj4+Pj4+Pj4gLz8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gSXQgbG9v
a3MgdG8gbWUgdGhlIGZlYXR1cmUgbmVnb3RpYXRpb24gaXMgZG9uZSBvbmx5IGFmdGVyIGRldmlj
ZSBzZXQKPj4+Pj4+Pj4gRkVBVFVSRVNfT0ssIG9yIEZFQVRVUkVTX09LIGNvdWxkIGJlIHJlYWQg
ZnJvbSBkZXZpY2Ugc3RhdHVzPwo+Pj4+Pj4+IEknZCBjb25zaWRlciBmZWF0dXJlIG5lZ290aWF0
aW9uIGRvbmUgd2hlbiB0aGUgZHJpdmVyIHJlYWRzIEZFQVRVUkVTX09LCj4+Pj4+Pj4gYmFjayBm
cm9tIHRoZSBzdGF0dXMuCj4+Pj4+PiBJIGFncmVlLgo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4+PiAg
ICAgICAoVGhpcyBpcyBhIGJpdCBmdXp6eSBmb3IgbGVnYWN5IG1vZGUuKQo+Pj4+Pj4+IC4uLmJl
Y2F1c2UgbGVnYWN5IGRvZXMgbm90IGhhdmUgRkVBVFVSRVNfT0suCj4+Pj4+Pj4+IFRoZSBwcm9i
bGVtIGlzIHRoZSBNVFUgZGVzY3JpcHRpb24gZm9yIGV4YW1wbGU6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+
ICJUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBp
Zgo+Pj4+Pj4+PiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldC4iCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEl0
IGxvb2tzIHRvIG1lIG5lZWQgdG8gdXNlICJpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldCBieSBk
ZXZpY2UiLgo+Pj4+Pj4+ICJvZmZlcmVkIGJ5IHRoZSBkZXZpY2UiPyBJIGRvbid0IHRoaW5rIGl0
IHNob3VsZCAnZGlzYXBwZWFyJyBmcm9tIHRoZQo+Pj4+Pj4+IGNvbmZpZyBzcGFjZSBpZiB0aGUg
ZHJpdmVyIHdvbid0IHVzZSBpdC4gKFNhbWUgZm9yIG90aGVyIGNvbmZpZyBzcGFjZQo+Pj4+Pj4+
IGZpZWxkcyB0aGF0IGFyZSB0aWVkIHRvIGZlYXR1cmUgYml0cy4pCj4+Pj4+PiBCdXQgd2hhdCBo
YXBwZW5zIGlmIGUuZyBkZXZpY2UgZG9lc24ndCBvZmZlciBWSVJUSU9fTkVUX0ZfTVRVPyBJdCBs
b29rcwo+Pj4+Pj4gdG8gYWNjb3JkaW5nIHRvIHRoZSBzcGVjIHRoZXJlIHdpbGwgYmUgbm8gbXR1
IGZpZWxkLgo+Pj4+PiBJIHRoaW5rIHNvLCB5ZXMuCj4+Pj4+Cj4+Pj4+PiBBbmQgYSBtb3JlIGlu
dGVyZXN0aW5nIGNhc2UgaXMgVklSVElPX05FVF9GX01RIGlzIG5vdCBvZmZlcmVkIGJ1dAo+Pj4+
Pj4gVklSVElPX05FVF9GX01UVSBvZmZlcmVkLiBUbyBtZSwgaXQgbWVhbnMgd2UgZG9uJ3QgaGF2
ZQo+Pj4+Pj4gbWF4X3ZpcnRxdWV1ZV9wYWlycyBidXQgaXQncyBub3QgaG93IHRoZSBkcml2ZXIg
aXMgd3JvdGUgdG9kYXkuCj4+Pj4+IFRoYXQgd291bGQgYmUgYSBidWcsIGJ1dCBpdCBzZWVtcyB0
byBtZSB0aGF0IHRoZSB2aXJ0aW8tbmV0IGRyaXZlcgo+Pj4+PiByZWFkcyBtYXhfdmlydHF1ZXVl
X3BhaXJzIGNvbmRpdGlvbmFsbHkgYW5kIGhhbmRsZXMgYWJzZW5jZSBvZiB0aGUKPj4+Pj4gZmVh
dHVyZSBjb3JyZWN0bHk/Cj4+Pj4gWWVzLCBzZWUgdGhlIGF2b3ZlIGNvZGVzOgo+Pj4+Cj4+Pj4g
ICDCoMKgwqDCoMKgwqDCoCBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRf
Rl9NVFUpKSB7Cj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IG10dSA9
IHZpcnRpb19jcmVhZDE2KHZkZXYsCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZz
ZXRvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcsCj4+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdHUpKTsKPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAobXR1IDwgTUlOX01UVSkKPj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJ
T19ORVRfRl9NVFUpOwo+Pj4+ICAgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+Cj4+Pj4gU28gaXQncyBw
cm9iYWJseSB0b28gbGF0ZSB0byBmaXggdGhlIGRyaXZlci4KPj4+Pgo+Pj4gQ29uZnVzZWQuIFdo
YXQgaXMgd3Jvbmcgd2l0aCB0aGUgYWJvdmU/IEl0IG5ldmVyIHJlYWRzIHRoZQo+Pj4gZmllbGQg
dW5sZXNzIHRoZSBmZWF0dXJlIGhhcyBiZWVuIG9mZmVyZWQgYnkgZGV2aWNlLgo+Pgo+PiBTbyB0
aGUgc3BlYyBzYWlkOgo+Pgo+PiAiCj4+Cj4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25s
eSBmaWVsZCwgbWF4X3ZpcnRxdWV1ZV9wYWlycyBvbmx5IGV4aXN0cyBpZgo+PiBWSVJUSU9fTkVU
X0ZfTVEgaXMgc2V0Lgo+Pgo+PiAiCj4+Cj4+IElmIEkgcmVhZCB0aGlzIGNvcnJlY3RseSwgdGhl
cmUgd2lsbCBiZSBubyBtYXhfdmlydHF1ZXVlX3BhaXJzIGZpZWxkIGlmIHRoZQo+PiBWSVJUSU9f
TkVUX0ZfTVEgaXMgbm90IG9mZmVyZWQgYnkgZGV2aWNlPyBJZiB5ZXMgdGhlIG9mZnNldG9mKCkg
dmlvbGF0ZXMKPj4gd2hhdCBzcGVjIHNhaWQuCj4+Cj4+IFRoYW5rcwo+IEkgdGhpbmsgdGhhdCdz
IGEgbWlzdW5kZXJzdGFuZGluZy4gVGhpcyB0ZXh0IHdhcyBuZXZlciBpbnRlbmRlZCB0bwo+IGlt
cGx5IHRoYXQgZmllbGQgb2Zmc2V0cyBjaGFuZ2UgYmVhc2VkIG9uIGZlYXR1cmUgYml0cy4KPiBX
ZSBoYWQgdGhpcyBwYWluIHdpdGggbGVnYWN5IGFuZCB3ZSBuZXZlciB3YW50ZWQgdG8gZ28gYmFj
ayB0aGVyZS4KPgo+IFRoaXMgbWVyZWx5IGltcGxpZXMgdGhhdCB3aXRob3V0IFZJUlRJT19ORVRf
Rl9NUSB0aGUgZmllbGQKPiBzaG91bGQgbm90IGJlIGFjY2Vzc2VkLiBFeGlzdHMgaW4gdGhlIHNl
bnNlICJpcyBhY2Nlc3NpYmxlIHRvIGRyaXZlciIuCj4KPiBMZXQncyBqdXN0IGNsYXJpZnkgdGhh
dCBpbiB0aGUgc3BlYywgam9iIGRvbmUuCgoKT2ssIGFncmVlLiBUaGF0IHdpbGwgbWFrZSB0aGlu
Z3MgbW9yZSBlYWlzZXIuCgpUaGFua3MKCgo+Cj4KPgo+Cj4+Pgo+Pj4+Pj4+PiBPdGhlcndpc2Ug
cmVhZGVycyAoYXQgbGVhc3QgZm9yIG1lKSwgbWF5IHRoaW5rIHRoZSBNVFUgaXMgb25seSB2YWxp
ZAo+Pj4+Pj4+PiBpZiBkcml2ZXIgc2V0IHRoZSBiaXQuCj4+Pj4+Pj4gSSB0aGluayBpdCB3b3Vs
ZCBzdGlsbCBiZSAndmFsaWQnIGluIHRoZSBzZW5zZSB0aGF0IGl0IGV4aXN0cyBhbmQgaGFzCj4+
Pj4+Pj4gc29tZSB2YWx1ZSBpbiB0aGVyZSBmaWxsZWQgaW4gYnkgdGhlIGRldmljZSwgYnV0IGEg
ZHJpdmVyIHJlYWRpbmcgaXQKPj4+Pj4+PiB3aXRob3V0IG5lZ290aWF0aW5nIHRoZSBmZWF0dXJl
IHdvdWxkIGJlIGJ1Z2d5LiAoTGlrZSBpbiB0aGUga2VybmVsCj4+Pj4+Pj4gY29kZSBhYm92ZTsg
dGhlIGtlcm5lbCBub3QgbGlraW5nIHRoZSB2YWx1ZSBkb2VzIG5vdCBtYWtlIHRoZSBmaWVsZAo+
Pj4+Pj4+IGludmFsaWQuKQo+Pj4+Pj4gU2VlIE1pY2hhZWwncyByZXBseSwgdGhlIHNwZWMgYWxs
b3dzIHJlYWQgdGhlIGNvbmZpZyBiZWZvcmUgc2V0dGluZwo+Pj4+Pj4gZmVhdHVyZXMuCj4+Pj4+
IFllcywgdGhlIHBlcmlvZCBwcmlvciB0byBmaW5pc2hpbmcgbmVnb3RpYXRpb24gaXMgb2J2aW91
c2x5IHNwZWNpYWwuCj4+Pj4+Cj4+Pj4+Pj4gTWF5YmUgYSBzdGF0ZW1lbnQgY292ZXJpbmcgZXZl
cnl0aGluZyB3b3VsZCBiZToKPj4+Pj4+Pgo+Pj4+Pj4+ICJUaGUgZm9sbG93aW5nIGRyaXZlci1y
ZWFkLW9ubHkgZmllbGQgbXR1IG9ubHkgZXhpc3RzIGlmIHRoZSBkZXZpY2UKPj4+Pj4+PiBvZmZl
cnMgVklSVElPX05FVF9GX01UVSBhbmQgbWF5IGJlIHJlYWQgYnkgdGhlIGRyaXZlciBkdXJpbmcg
ZmVhdHVyZQo+Pj4+Pj4+IG5lZ290aWF0aW9uIGFuZCBhZnRlciBWSVJUSU9fTkVUX0ZfTVRVIGhh
cyBiZWVuIHN1Y2Nlc3NmdWxseQo+Pj4+Pj4+IG5lZ290aWF0ZWQuIgo+Pj4+Pj4+Pj4gU2hvdWxk
IHdlIGFkZCBhIHdvcmRpbmcgY2xhcmlmaWNhdGlvbiB0byB0aGUgc3BlYz8KPj4+Pj4+Pj4gSSB0
aGluayBzby4KPj4+Pj4+PiBTb21lIGNsYXJpZmljYXRpb24gd291bGQgYmUgbmVlZGVkIGZvciBl
YWNoIGZpZWxkIHRoYXQgZGVwZW5kcyBvbiBhCj4+Pj4+Pj4gZmVhdHVyZTsgdGhhdCB3b3VsZCBi
ZSBxdWl0ZSB2ZXJib3NlLiBNYXliZSB3ZSBjYW4gZ2V0IGF3YXkgd2l0aCBhCj4+Pj4+Pj4gY2xh
cmlmeWluZyBzdGF0ZW1lbnQ/Cj4+Pj4+Pj4KPj4+Pj4+PiAiU29tZSBjb25maWcgc3BhY2UgZmll
bGRzIG1heSBkZXBlbmQgb24gYSBjZXJ0YWluIGZlYXR1cmUuIEluIHRoYXQKPj4+Pj4+PiBjYXNl
LCB0aGUgZmllbGQgZXhpdHMgaWYgdGhlIGRldmljZSBoYXMgb2ZmZXJlZCB0aGUgY29ycmVzcG9u
ZGluZwo+Pj4+Pj4+IGZlYXR1cmUsCj4+Pj4+PiBTbyB0aGlzIGltcGxpZXMgZm9yICFWSVJUSU9f
TkVUX0ZfTVEgJiYgVklSVElPX05FVF9GX01UVSwgdGhlIGNvbmZpZwo+Pj4+Pj4gd2lsbCBsb29r
IGxpa2U6Cj4+Pj4+Pgo+Pj4+Pj4gc3RydWN0IHZpcnRpb19uZXRfY29uZmlnIHsKPj4+Pj4+ICAg
ICDCoMKgwqDCoMKgwqDCoCB1OCBtYWNbNl07Cj4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqAgbGUx
NiBzdGF0dXM7Cj4+Pj4+PiAgICAgwqDCoMKgwqDCoMKgwqAgbGUxNiBtdHU7Cj4+Pj4+PiB9Owo+
Pj4+Pj4KPj4+Pj4gSSBhZ3JlZS4KPj4+PiBTbyBjb25zaWRlciBpdCdzIHByb2JhYmx5IHRvbyBs
YXRlIHRvIGZpeCB0aGUgZHJpdmVyIHdoaWNoIGFzc3VtZXMgc29tZQo+Pj4+IGZpZWxkIGFyZSBh
bHdheXMgcGVyc2VudCwgaXQgbG9va3MgdG8gbWUgbmVlZCBmaXggdGhlIHNwZWMgZG8gZGVjbGFy
ZSB0aGUKPj4+PiBmaWVsZHMgYXJlIGFsd2F5cyBleGlzdGluZyBpbnN0ZWFkLgo+Pj4+Cj4+Pj4K
Pj4+Pj4+PiAgICAgIGFuZCBtYXkgYmUgcmVhZCBieSB0aGUgZHJpdmVyIGR1cmluZyBmZWF0dXJl
IG5lZ290aWF0aW9uLCBhbmQKPj4+Pj4+PiBhY2Nlc3NlZCBieSB0aGUgZHJpdmVyIGFmdGVyIHRo
ZSBmZWF0dXJlIGhhcyBiZWVuIHN1Y2Nlc3NmdWxseQo+Pj4+Pj4+IG5lZ290aWF0ZWQuIEEgc2hv
cnRoYW5kIGZvciB0aGlzIGlzIGEgc3RhdGVtZW50IHRoYXQgYSBmaWVsZCBvbmx5Cj4+Pj4+Pj4g
ZXhpc3RzIGlmIGEgY2VydGFpbiBmZWF0dXJlIGJpdCBpcyBzZXQuIgo+Pj4+Pj4gSSdtIG5vdCBz
dXJlIHVzaW5nICJzaG9ydGhhbmQiIGlzIGdvb2QgZm9yIHRoZSBzcGVjLCBhdCBsZWFzdCB3ZSBj
YW4KPj4+Pj4+IGxpbWl0IHRoZSBpdHMgc2NvcGUgb25seSB0byB0aGUgY29uZmlndXJhdGlvbiBz
cGFjZSBwYXJ0Lgo+Pj4+PiBNYXliZSAiYSBzaG9ydGhhbmQgZXhwcmVzc2lvbiI/Cj4+Pj4gU28g
dGhlIHF1ZXN0aW9ucyBpcyBzaG91bGQgd2UgdXNlIHRoaXMgZm9yIGFsbCBvdmVyIHRoZSBzcGVj
IG9yIGl0IHdpbGwgYmUKPj4+PiBvbmx5IHVzZWQgaW4gdGhpcyBzcGVpY2lmYyBwYXJ0IChkZXZp
Y2UgY29uZmlndXJhdGlvbikuCj4+Pj4KPj4+PiBUaGFua3MKPj4+PgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
