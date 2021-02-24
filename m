Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE56C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:42:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1700764E6F
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1700764E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A9D983CF5;
	Wed, 24 Feb 2021 09:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cwwWY4vLiK94; Wed, 24 Feb 2021 09:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C51583CFB;
	Wed, 24 Feb 2021 09:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7F43C000B;
	Wed, 24 Feb 2021 09:41:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08EDBC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 045F94CB15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8myPCu_5jNwK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF75E4BEF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614159714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXPrJhinqxNu3lZVvaaeAdNFvCf/ukuDgLbn0H9xKto=;
 b=JuXmKizDLAR3RWdbLTFuZPpGSmU1yZHo8Y6QS6KCjf3Sgf3PPQ9s6149Rpxv33nNdFdDbF
 frqqX3h3+QPcL0sc/rYfAPyQ/DA6Vnh2yTjP3I8BxGpJDIDr1tiAFTz59KmDIb9krihvYi
 KkKeM026rahq5OJrsrgEs8QBJzwVe4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-CCr9Nm_oO1eiukqmUCWzcA-1; Wed, 24 Feb 2021 04:41:02 -0500
X-MC-Unique: CCr9Nm_oO1eiukqmUCWzcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BB25100963A;
 Wed, 24 Feb 2021 09:40:31 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBAF019C46;
 Wed, 24 Feb 2021 09:40:25 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223045600-mutt-send-email-mst@kernel.org>
 <c188353e-9aca-a94c-e8f5-4bad5942481c@redhat.com>
Message-ID: <0e79975a-9130-f437-bcea-928968fa523e@redhat.com>
Date: Wed, 24 Feb 2021 17:40:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c188353e-9aca-a94c-e8f5-4bad5942481c@redhat.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com
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

Ck9uIDIwMjEvMi8yMyA2OjE3IOS4i+WNiCwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjEv
Mi8yMyA2OjAxIOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+PiBPbiBUdWUsIEZl
YiAyMywgMjAyMSBhdCAwNTo0NjoyMFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24g
MjAyMS8yLzIzIOS4i+WNiDU6MjUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+PiBPbiBN
b24sIEZlYiAyMiwgMjAyMSBhdCAwOTowOToyOEFNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+
Pj4+PiBPbiAyLzIxLzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IE9uIDIw
MjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+PiBDb21taXQgNDUy
NjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2VkCj4+Pj4+
Pj4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJl
c2V0Cj4+Pj4+Pj4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQg
YmVmb3JlIGZlYXR1cmVzCj4+Pj4+Pj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZl
cmlmeV9taW5fZmVhdHVyZXMoKSBjaGVjawo+Pj4+Pj4+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNl
dCB0byAwIGZvciB0aGlzIGNhc2UuCj4+Pj4+Pj4KPj4+Pj4+PiBJdCdzIHdvcnRoIG5vdGluZyB0
aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4+Pj4+Pj4gY29uZmlnIHNw
YWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0LiBGb3IgaW5zdGFuY2UsIHdoZW4KPj4+Pj4+PiBm
ZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIK
Pj4+Pj4+PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2VudCBp
biB0aGUgY29uZmlnCj4+Pj4+Pj4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0
Lgo+Pj4+Pj4gVGhpcyBsb29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4+Pj4+Pgo+Pj4+Pj4g
Igo+Pj4+Pj4KPj4+Pj4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1
IG9ubHkgZXhpc3RzIGlmCj4+Pj4+PiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldC4gVGhpcyBmaWVs
ZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRVIGZvciAKPj4+Pj4+IHRoZQo+Pj4+Pj4gZHJpdmVy
IHRvIHVzZS4KPj4+Pj4+ICIKPj4+Pj4+Cj4+Pj4+PiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3Jr
YXJvdW5kIHRoaXM/Cj4+Pj4+IElzbid0IHRoZSBjb21taXQgNDUyNjM5YTY0YWQ4IGl0c2VsZiBp
cyBhIHdvcmthcm91bmQgZm9yIGxlZ2FjeSAKPj4+Pj4gZ3Vlc3Q/Cj4+Pj4+Cj4+Pj4+IEkgdGhp
bmsgdGhlIHBvaW50IGlzLCBzaW5jZSB0aGVyZSdzIGxlZ2FjeSBndWVzdCB3ZSdkIGhhdmUgdG8g
Cj4+Pj4+IHN1cHBvcnQsIHRoaXMKPj4+Pj4gaG9zdCBzaWRlIHdvcmthcm91bmQgaXMgdW5hdm9p
ZGFibGUuIEFsdGhvdWdoIEkgYWdyZWUgdGhlIAo+Pj4+PiB2aW9sYXRpbmcgZHJpdmVyCj4+Pj4+
IHNob3VsZCBiZSBmaXhlZCAoeWVzLCBpdCdzIGluIHRvZGF5J3MgdXBzdHJlYW0ga2VybmVsIHdo
aWNoIGV4aXN0cyAKPj4+Pj4gZm9yIGEKPj4+Pj4gd2hpbGUgbm93KS4KPj4+PiBPaMKgIHlvdSBh
cmUgcmlnaHQ6Cj4+Pj4KPj4+Pgo+Pj4+IHN0YXRpYyBpbnQgdmlydG5ldF92YWxpZGF0ZShzdHJ1
Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+PiB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlm
ICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRldl9lcnIoJnZkZXYtPmRldiwgIiVzIGZhaWx1cmU6IGNvbmZpZyBhY2Nlc3MgCj4+
Pj4gZGlzYWJsZWRcbiIsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgX19mdW5jX18pOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pgo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXZpcnRuZXRfdmFsaWRhdGVfZmVhdHVyZXModmRl
dikpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZB
TDsKPj4+Pgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZk
ZXYsIFZJUlRJT19ORVRfRl9NVFUpKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbnQgbXR1ID0gdmlydGlvX2NyZWFkMTYodmRldiwKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb2Zmc2V0b2Yoc3RydWN0IAo+Pj4+IHZpcnRpb19uZXRfY29uZmlnLAo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdHUpKTsK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtdHUgPCBNSU5fTVRV
KQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKPj4+Cj4+PiBJIHdv
bmRlciB3aHkgbm90IHNpbXBseSBmYWlsIGhlcmU/Cj4+IEJhY2sgaW4gMjAxNiBpdCB3ZW50IGxp
a2UgdGhpczoKPj4KPj4gwqDCoMKgwqBPbiBUaHUsIEp1biAwMiwgMjAxNiBhdCAwNToxMDo1OVBN
IC0wNDAwLCBBYXJvbiBDb25vbGUgd3JvdGU6Cj4+IMKgwqDCoMKgPiArwqDCoMKgwqAgaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewo+PiDCoMKgwqDCoD4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXYtPm10dSA9IHZpcnRpb19jcmVhZDE2KHZkZXYs
Cj4+IMKgwqDCoMKgPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXRvZihzdHJ1Y3QgCj4+IHZp
cnRpb19uZXRfY29uZmlnLAo+PiDCoMKgwqDCoD4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbXR1KSk7Cj4+IMKgwqDCoMKgPiArwqDCoMKgwqAgfQo+PiDCoMKgwqDCoD4g
Kwo+PiDCoMKgwqDCoD7CoMKgwqDCoMKgwqAgaWYgKHZpLT5hbnlfaGVhZGVyX3NnKQo+PiDCoMKg
wqDCoD7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldi0+bmVlZGVkX2hlYWRyb29tID0g
dmktPmhkcl9sZW47Cj4+IMKgwqDCoMKgPgo+Pgo+PiDCoMKgwqDCoE9uZSBjb21tZW50IHRob3Vn
aDogSSB0aGluayB3ZSBzaG91bGQgdmFsaWRhdGUgdGhlIG10dS4KPj4gwqDCoMKgwqBJZiBpdCdz
IGludmFsaWQsIGNsZWFyIFZJUlRJT19ORVRfRl9NVFUgYW5kIGlnbm9yZS4KPj4KPj4KPj4gVG9v
IGxhdGUgYXQgdGhpcyBwb2ludCA6KQo+Pgo+PiBJIGd1ZXNzIGl0J3MgYSB3YXkgdG8gdGVsbCBk
ZXZpY2UgIkkgY2FuIG5vdCBsaXZlIHdpdGggdGhpcyBNVFUiLAo+PiBkZXZpY2UgY2FuIGZhaWwg
RkVBVFVSRVNfT0sgaWYgaXQgd2FudHMgdG8uIE1JTl9NVFUKPj4gaXMgYW4gaW50ZXJuYWwgbGlu
dXggdGhpbmcgYW5kIGF0IHRoZSB0aW1lIEkgZmVsdCBpdCdzIGJldHRlciB0bwo+PiB0cnkgdG8g
bWFrZSBwcm9ncmVzcy4KPgo+Cj4gV2hhdCBpZiBlLmcgdGhlIGRldmljZSBhZHZlcnRpc2UgYSBs
YXJnZSBNVFUuIEUuZyA2NEsgaGVyZT8KCgpPaywgY29uc2lkZXIgd2UgdXNlIGFkZF9yZWN2YnVm
X3NtYWxsKCkgd2hlbiBuZWl0aGVyIEdTTyBub3IgbXJnX3J4YnVmLiAKVGhpcyBtZWFucyB3ZSBz
aG91bGQgZmFpbCB0aGUgcHJvYmluZyBpZiBNVFUgaXMgZ3JlYXRlciB0aGFuIDE1MDAgaW4gCnRo
aXMgY2FzZS4KClRoYW5rcwoKCj4gSW4gdGhhdCBjYXNlLCB0aGUgZHJpdmVyIGNhbiBub3QgbGl2
ZSBlaXRoZXIuIENsZWFyaW5nIE1UVSB3b24ndCBoZWxwIAo+IGhlcmUuCj4KPiBUaGFua3MKPgo+
Cj4+Cj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pgo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gMDsKPj4+PiB9Cj4+Pj4KPj4+PiBBbmQgdGhlIHNwZWMgc2F5czoKPj4+Pgo+
Pj4+Cj4+Pj4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRvIGluaXRpYWxp
emUgYSBkZXZpY2U6Cj4+Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+PiAyLiBTZXQgdGhlIEFD
S05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgCj4+Pj4g
ZGV2aWNlLgo+Pj4+IDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBr
bm93cyBob3cgdG8gZHJpdmUgdGhlIAo+Pj4+IGRldmljZS4KPj4+PiA0LiBSZWFkIGRldmljZSBm
ZWF0dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyAKPj4+PiB1
bmRlcnN0b29kIGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZQo+Pj4+IGRldmljZS4gRHVyaW5n
IHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIAo+Pj4+
IHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbgo+Pj4+IGZpZWxkcyB0byBjaGVjayB0
aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBkZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBpdC4KPj4+PiA1
LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNj
ZXB0IG5ldyAKPj4+PiBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+Pj4+IDYuIFJlLXJl
YWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCAK
Pj4+PiBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5vdAo+Pj4+IHN1cHBvcnQgb3Vy
IHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPj4+PiA3LiBQ
ZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2NvdmVyeSBvZiB2aXJ0
cXVldWVzIAo+Pj4+IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+Pj4+
IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZp
Z3VyYXRpb24gCj4+Pj4gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4+Pj4g
OC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2ludCB0aGUgZGV2aWNl
IGlzIOKAnGxpdmXigJ0uCj4+Pj4KPj4+Pgo+Pj4+IEl0ZW0gNCBvbiB0aGUgbGlzdCBleHBsaWNp
dGx5IGFsbG93cyByZWFkaW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUKPj4+PiBGRUFUVVJFU19PSy4K
Pj4+Pgo+Pj4+IEkgY29uY2x1ZGUgdGhhdCBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldCBtZWFucyAi
c2V0IGluIGRldmljZSAKPj4+PiBmZWF0dXJlcyIuCj4+Pgo+Pj4gU28gdGhpcyBwcm9iYWJseSBu
ZWVkIHNvbWUgY2xhcmlmaWNhdGlvbi4gImlzIHNldCIgaXMgdXNlZCBtYW55IAo+Pj4gdGltZXMg
aW4gdGhlCj4+PiBzcGVjIHRoYXQgaGFzIGRpZmZlcmVudCBpbXBsaWNhdGlvbnMuCj4+Pgo+Pj4g
VGhhbmtzCj4+Pgo+Pj4KPj4+PiBHZW5lcmFsbHkgaXQgaXMgd29ydGggZ29pbmcgb3ZlciBmZWF0
dXJlIGRlcGVuZGVudCBjb25maWcgZmllbGRzCj4+Pj4gYW5kIGNoZWNraW5nIHdoZXRoZXIgdGhl
eSBzaG91bGQgYmUgcHJlc2VudCB3aGVuIGRldmljZSBmZWF0dXJlIGlzIHNldAo+Pj4+IG9yIHdo
ZW4gZmVhdHVyZSBiaXQgaGFzIGJlZW4gbmVnb3RpYXRlZCwgYW5kIG1ha2luZyB0aGlzIGNsZWFy
Lgo+Pj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
