Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBEC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 02:03:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E6764E12
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 02:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6764E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B725F870E5;
	Tue, 23 Feb 2021 02:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIyECWOAaToU; Tue, 23 Feb 2021 02:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A8E4F87070;
	Tue, 23 Feb 2021 02:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6905FC000D;
	Tue, 23 Feb 2021 02:03:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55D72C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4B19605C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwl0U_c_iiKQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:03:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DB6B605C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614045799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jDvNN3dr07M3oMcu2xiN/23kS7A7X+hTtnNECpm9lbs=;
 b=QkNgcBtzrTK0jIM4pwI57JZe8KP+Yf/FC8xjhrR7JS4YGSmVqFtsBYatpv25UZHp1mxrnF
 1s7Of3CkZcq0F/mah3QLxT9KTmcLnHKx7aUjIKs2c7oCe0gqVUlBVeSq0OO0g9iWlwSzQC
 ELsS154meNSZPs1EZYvyghQowyRyf7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-rW2wH0N2Nryg4Ia4P5zb2g-1; Mon, 22 Feb 2021 21:03:17 -0500
X-MC-Unique: rW2wH0N2Nryg4Ia4P5zb2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA3528030BB;
 Tue, 23 Feb 2021 02:03:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-58.pek2.redhat.com
 [10.72.13.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0962C10016F9;
 Tue, 23 Feb 2021 02:03:09 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <716ad747-501b-4e95-9785-87161da5940f@redhat.com>
Date: Tue, 23 Feb 2021 10:03:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8yMyAxOjA5IOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPgo+Cj4gT24gMi8y
MS8yMDIxIDg6MTQgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMi8xOSA3OjU0
IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBh
OiBtYWtlIHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPj4+IGZvciBsZWdhY3kiKSBtYWRl
IGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1ZXN0cyB0byByZXNldAo+Pj4gZmVhdHVyZXMgdG8g
MCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+PiBhcmUg
c2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0dXJlcygpIGNoZWNrCj4+
PiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBjYXNlLgo+Pj4KPj4+IEl0
J3Mgd29ydGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nlc3MK
Pj4+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNldC4gRm9yIGluc3RhbmNlLCB3
aGVuCj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVy
biBkcml2ZXIKPj4+IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVz
ZW50IGluIHRoZSBjb25maWcKPj4+IHNwYWNlIGJlZm9yZSB2aXJ0aW8gZmVhdHVyZXMgYXJlIHNl
dC4KPj4KPj4KPj4gVGhpcyBsb29rcyBsaWtlIGEgc3BlYyB2aW9sYXRpb246Cj4+Cj4+ICIKPj4K
Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMg
aWYgCj4+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0LiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUg
bWF4aW11bSBNVFUgZm9yIHRoZSAKPj4gZHJpdmVyIHRvIHVzZS4KPj4gIgo+Pgo+PiBEbyB3ZSBy
ZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/Cj4KPiBJc24ndCB0aGUgY29tbWl0IDQ1MjYz
OWE2NGFkOCBpdHNlbGYgaXMgYSB3b3JrYXJvdW5kIGZvciBsZWdhY3kgZ3Vlc3Q/CgoKWWVzLCBi
dXQgdGhlIHByb2JsZW0gaXMgd2UgY2FuJ3QgZGV0ZWN0IHdoZXRoZXIgb3Igbm90IGl0J3MgYW4g
bGVnYWN5IApndWVzdCAoZS5nIGZlYXR1cmUgaXMgbm90IHNldCkuCgoKPgo+IEkgdGhpbmsgdGhl
IHBvaW50IGlzLCBzaW5jZSB0aGVyZSdzIGxlZ2FjeSBndWVzdCB3ZSdkIGhhdmUgdG8gc3VwcG9y
dCwgCj4gdGhpcyBob3N0IHNpZGUgd29ya2Fyb3VuZCBpcyB1bmF2b2lkYWJsZS4KCgpTaW5jZSBm
cm9tIHZob3N0LXZEUEEgcG9pbnQgb2YgdmlldyB0aGUgZHJpdmVyIGlzIFFlbXUsIGl0IG1lYW5z
IHdlIG5lZWQgCm1ha2UgcWVtdSB2aG9zdC12RFBBIGRyaXZlciBzcGVjIGNvbXBsYWludC4KCkUu
ZyBob3cgYWJvdXQ6CgoxKSByZXZlcnQgNDUyNjM5YTY0YWQ4IGFuZCBmaXggUWVtdT8gSW4gUWVt
dSwgZHVyaW5nIHZob3N0LXZEUEEgCmluaXRpYWxpemF0aW9uLCBkbyBhIG1pbmlhbCBjb25maWcg
c3luYyBieSBuZW9naXRhdGluZyBtaW5pbWFsIGZlYXR1cmVzIAooZS5nIGp1c3QgVklSVElPX0Zf
QUNDRVNTX1BMQVRGT1JNKS4gV2hlbiBGRUFUVVJFX09LIGlzIG5vdCBzZXQgZnJvbSAKZ3Vlc3Qs
IHdlIGNhbiBvbmx5IGFsbG93IGl0IHRvIGFjY2VzcyB0aGUgY29uZmlnIHNwYWNlIHRoYXQgaXMg
ZW11bGF0ZWQgCmJ5IFFlbXU/CgpUaGVuCgoKPiBBbHRob3VnaCBJIGFncmVlIHRoZSB2aW9sYXRp
bmcgZHJpdmVyIHNob3VsZCBiZSBmaXhlZCAoeWVzLCBpdCdzIGluIAo+IHRvZGF5J3MgdXBzdHJl
YW0ga2VybmVsIHdoaWNoIGV4aXN0cyBmb3IgYSB3aGlsZSBub3cpLgoKCjIpIEZpeCB0aGUgdmly
dGlvIGRyaXZlciBidWcuCgpPciBhIHF1aWNrIHdvcmthcm91bmQgaXMgdG8gc2V0IChWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0gaW5zdGVhZCBvZiAwKSAKaW4gdGhpcyBjYXNlLgoKVGhhbmtzCgoK
Pgo+IC1TaXdlaQo+Cj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gUmVqZWN0aW5nIHJlc2V0IHRvIDAK
Pj4+IHByZW1hdHVyZWx5IGNhdXNlcyBjb3JyZWN0IE1UVSBhbmQgbGluayBzdGF0dXMgdW5hYmxl
IHRvIGxvYWQKPj4+IGZvciB0aGUgdmVyeSBmaXJzdCBjb25maWcgc3BhY2UgYWNjZXNzLCByZW5k
ZXJpbmcgaXNzdWVzIGxpa2UKPj4+IGd1ZXN0IHNob3dpbmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUs
IG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4+PiBvdXQtb2YtcmFuZ2UgTVRVLgo+Pj4KPj4+IEZpeGVz
OiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVk
IG1seDUgCj4+PiBkZXZpY2VzIikKPj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdl
aS5saXVAb3JhY2xlLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jIHwgMTUgKy0tLS0tLS0tLS0tLS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgCj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+Pj4gaW5kZXggN2MxZjc4OS4uNTQwZGQ2NyAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jCj4+PiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0YXRpYyB1NjQg
bWx4NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgCj4+PiB2ZHBhX2RldmljZSAqdmRldikKPj4+
IMKgwqDCoMKgwqAgcmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7Cj4+PiDCoCB9Cj4+PiDCoCAt
c3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwgdTY0IAo+Pj4gZmVhdHVyZXMpCj4+PiAtewo+Pj4gLcKgwqDCoCBpZiAoIShmZWF0dXJlcyAm
IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4+PiAtwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FT1BOT1RTVVBQOwo+Pj4gLQo+Pj4gLcKgwqDCoCByZXR1cm4gMDsKPj4+IC19Cj4+
PiAtCj4+PiDCoCBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9u
ZXQgKm5kZXYpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIGludCBlcnI7Cj4+PiBAQCAtMTU1OCwx
OCArMTU1MCwxMyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IAo+
Pj4gdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPj4+IMKgIHsKPj4+IMKgwqDCoMKg
wqAgc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+PiDCoMKg
wqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZk
ZXYpOwo+Pj4gLcKgwqDCoCBpbnQgZXJyOwo+Pj4gwqAgwqDCoMKgwqDCoCBwcmludF9mZWF0dXJl
cyhtdmRldiwgZmVhdHVyZXMsIHRydWUpOwo+Pj4gwqAgLcKgwqDCoCBlcnIgPSB2ZXJpZnlfbWlu
X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcyk7Cj4+PiAtwqDCoMKgIGlmIChlcnIpCj4+PiAtwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+IC0KPj4+IMKgwqDCoMKgwqAgbmRldi0+bXZkZXYu
YWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVyZXMgJiAKPj4+IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJl
czsKPj4+IMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12
ZGV2LCBuZGV2LT5tdHUpOwo+Pj4gwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzIHw9IGNw
dV90b19tbHg1dmRwYTE2KG12ZGV2LCAKPj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4+IC3C
oMKgwqAgcmV0dXJuIGVycjsKPj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoCB9Cj4+PiDCoCDC
oCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19jYihzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIAo+Pj4gc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKQo+Pgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
