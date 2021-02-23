Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B20C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 02:04:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1EB64E12
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 02:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1EB64E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C558A81A15;
	Tue, 23 Feb 2021 02:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XVhqrlkWgM2; Tue, 23 Feb 2021 02:04:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 02D6684032;
	Tue, 23 Feb 2021 02:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA726C000A;
	Tue, 23 Feb 2021 02:04:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DCC3C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E31CD831BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UrGvha21wloi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:04:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8D8D831DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614045851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6idrDlv3jxmFr3UwSuJjfWfYYHRXCR4c1yPFc4Gx68=;
 b=CzKhP9zGRk8xZjzEqxTk1EHQm/Pqm5sWINRoWwPe/kvJCLoQVNe188EzkZrTjT2T2dPLWj
 aND4s93HWCaNcVXjQocpQjpbprMTSty3BZPeec3J0+OyrwixtT2rbd2ACoRCAGLwsvCR1T
 QzoCvPdvXjBTtYuPMr91P3WXoBnU4f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-LStuIhLXPKaUwoKYNmhnqA-1; Mon, 22 Feb 2021 21:04:06 -0500
X-MC-Unique: LStuIhLXPKaUwoKYNmhnqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 759C310082F6;
 Tue, 23 Feb 2021 02:04:05 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-58.pek2.redhat.com
 [10.72.13.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 356865B4A0;
 Tue, 23 Feb 2021 02:03:58 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
Date: Tue, 23 Feb 2021 10:03:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev@vger.kernel.org, elic@nvidia.com, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPgo+Cj4gT24gMi8y
MS8yMDIxIDExOjM0IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+IE9uIE1vbiwgRmVi
IDIyLCAyMDIxIGF0IDEyOjE0OjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAy
MDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4gQ29tbWl0IDQ1MjYz
OWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+Pj4+IGZv
ciBsZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1ZXN0cyB0byByZXNldAo+
Pj4+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJlZm9yZSBm
ZWF0dXJlcwo+Pj4+IGFyZSBzZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2Zl
YXR1cmVzKCkgY2hlY2sKPj4+PiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhp
cyBjYXNlLgo+Pj4+Cj4+Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kg
Z3Vlc3RzIGNvdWxkIGFjY2Vzcwo+Pj4+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJl
IHNldC4gRm9yIGluc3RhbmNlLCB3aGVuCj4+Pj4gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlz
IGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4+Pj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFu
ZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+Pj4+IHNwYWNlIGJlZm9y
ZSB2aXJ0aW8gZmVhdHVyZXMgYXJlIHNldC4KPj4+Cj4+PiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVj
IHZpb2xhdGlvbjoKPj4+Cj4+PiAiCj4+Pgo+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1v
bmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYgCj4+PiBWSVJUSU9fTkVUX0ZfTVRVIGlzCj4+
PiBzZXQuCj4+PiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZSBk
cml2ZXIgdG8gdXNlLgo+Pj4gIgo+Pj4KPj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91
bmQgdGhpcz8KPj4+Cj4+PiBUaGFua3MKPj4gQW5kIGFsc286Cj4+Cj4+IFRoZSBkcml2ZXIgTVVT
VCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+PiAxLiBSZXNl
dCB0aGUgZGV2aWNlLgo+PiAyLiBTZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBn
dWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgZGV2aWNlLgo+PiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0
dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3MgaG93IHRvIGRyaXZlIHRoZSAKPj4gZGV2aWNlLgo+
PiA0LiBSZWFkIGRldmljZSBmZWF0dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZl
YXR1cmUgYml0cyAKPj4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUKPj4g
ZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJlYWQgKGJ1dCBNVVNUIE5P
VCB3cml0ZSkgdGhlIAo+PiBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbgo+PiBmaWVsZHMg
dG8gY2hlY2sgdGhhdCBpdCBjYW4gc3VwcG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcg
aXQuCj4+IDUuIFNldCB0aGUgRkVBVFVSRVNfT0sgc3RhdHVzIGJpdC4gVGhlIGRyaXZlciBNVVNU
IE5PVCBhY2NlcHQgbmV3IAo+PiBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+PiA2LiBS
ZS1yZWFkIGRldmljZSBzdGF0dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBiaXQgaXMgc3Rp
bGwgc2V0OiAKPj4gb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4+IHN1cHBvcnQgb3Vy
IHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPj4gNy4gUGVy
Zm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1
ZXVlcyAKPj4gZm9yIHRoZSBkZXZpY2UsIG9wdGlvbmFsIHBlci1idXMgc2V0dXAsCj4+IHJlYWRp
bmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZpZ3VyYXRp
b24gc3BhY2UsIAo+PiBhbmQgcG9wdWxhdGlvbiBvZiB2aXJ0cXVldWVzLgo+PiA4LiBTZXQgdGhl
IERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2
ZeKAnS4KPj4KPj4KPj4gc28gYWNjZXNzaW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVSRVNf
T0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmlnaHQ/Cj4gSXQgaXMsIGJ1dCBpdCdzIG5vdCByZWxl
dmFudCB0byB3aGF0IHRoaXMgY29tbWl0IHRyaWVzIHRvIGFkZHJlc3MuIEkgCj4gdGhvdWdodCB0
aGUgbGVnYWN5IGd1ZXN0IHN0aWxsIG5lZWRzIHRvIGJlIHN1cHBvcnRlZC4KPgo+IEhhdmluZyBz
YWlkLCBhIHNlcGFyYXRlIHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBk
cml2ZXIgCj4gaXNzdWUgd2hlcmUgdGhpcyBkaXNjcmVwYW5jeSBpcyBpbnRyb2R1Y2VkIHRvIHZp
cnRuZXRfdmFsaWRhdGUoKSAKPiAoc2luY2UgY29tbWl0IGZlMzZjYmUwNjcpLiBCdXQgaXQncyBu
b3QgdGVjaG5pY2FsbHkgcmVsYXRlZCB0byB0aGlzIAo+IHBhdGNoLgo+Cj4gLVNpd2VpCgoKSSB0
aGluayBpdCdzIGEgYnVnIHRvIHJlYWQgY29uZmlnIHNwYWNlIGluIHZhbGlkYXRlLCB3ZSBzaG91
bGQgbW92ZSBpdCAKdG8gdmlydG5ldF9wcm9iZSgpLgoKVGhhbmtzCgoKPgo+Pgo+Pgo+Pj4+IFJl
amVjdGluZyByZXNldCB0byAwCj4+Pj4gcHJlbWF0dXJlbHkgY2F1c2VzIGNvcnJlY3QgTVRVIGFu
ZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8gbG9hZAo+Pj4+IGZvciB0aGUgdmVyeSBmaXJzdCBjb25m
aWcgc3BhY2UgYWNjZXNzLCByZW5kZXJpbmcgaXNzdWVzIGxpa2UKPj4+PiBndWVzdCBzaG93aW5n
IGluYWNjdXJhdGUgTVRVIHZhbHVlLCBvciBmYWlsdXJlIHRvIHJlamVjdAo+Pj4+IG91dC1vZi1y
YW5nZSBNVFUuCj4+Pj4KPj4+PiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQg
VkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IAo+Pj4+IGRldmljZXMiKQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+PiAtLS0KPj4+
PiDCoMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0t
LS0tLQo+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNCBkZWxldGlv
bnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgCj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiBpbmRl
eCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+Pj4+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAgc3RhdGljIHU2NCBtbHg1X3ZkcGFfZ2V0X2Zl
YXR1cmVzKHN0cnVjdCAKPj4+PiB2ZHBhX2RldmljZSAqdmRldikKPj4+PiDCoMKgwqDCoMKgwqAg
cmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7Cj4+Pj4gwqDCoCB9Cj4+Pj4gLXN0YXRpYyBpbnQg
dmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU2NCAKPj4+
PiBmZWF0dXJlcykKPj4+PiAtewo+Pj4+IC3CoMKgwqAgaWYgKCEoZmVhdHVyZXMgJiBCSVRfVUxM
KFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVPUE5PVFNVUFA7Cj4+Pj4gLQo+Pj4+IC3CoMKgwqAgcmV0dXJuIDA7Cj4+Pj4gLX0KPj4+PiAt
Cj4+Pj4gwqDCoCBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9u
ZXQgKm5kZXYpCj4+Pj4gwqDCoCB7Cj4+Pj4gwqDCoMKgwqDCoMKgIGludCBlcnI7Cj4+Pj4gQEAg
LTE1NTgsMTggKzE1NTAsMTMgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0
cnVjdCAKPj4+PiB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+Pj4+IMKgwqAgewo+
Pj4+IMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2
ZGV2KTsKPj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19t
bHg1X3ZkcGFfbmRldihtdmRldik7Cj4+Pj4gLcKgwqDCoCBpbnQgZXJyOwo+Pj4+IMKgwqDCoMKg
wqDCoCBwcmludF9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMsIHRydWUpOwo+Pj4+IC3CoMKgwqAg
ZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMpOwo+Pj4+IC3CoMKgwqAg
aWYgKGVycikKPj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+PiAtCj4+Pj4gwqDC
oMKgwqDCoMKgIG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IGZlYXR1cmVzICYgCj4+Pj4g
bmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzOwo+Pj4+IMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcu
bXR1ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4+Pj4gwqDCoMKgwqDC
oMKgIG5kZXYtPmNvbmZpZy5zdGF0dXMgfD0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIAo+Pj4+
IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4+PiAtwqDCoMKgIHJldHVybiBlcnI7Cj4+Pj4gK8Kg
wqDCoCByZXR1cm4gMDsKPj4+PiDCoMKgIH0KPj4+PiDCoMKgIHN0YXRpYyB2b2lkIG1seDVfdmRw
YV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgCj4+Pj4gc3RydWN0IHZk
cGFfY2FsbGJhY2sgKmNiKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
