Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC0C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:50:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3542D64E31
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3542D64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D892B84EA3;
	Tue, 23 Feb 2021 09:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ym4bXKJZ1EvH; Tue, 23 Feb 2021 09:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4640484EB4;
	Tue, 23 Feb 2021 09:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BBC9C000B;
	Tue, 23 Feb 2021 09:49:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB964C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8B5E605A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LVatS0gA34Z4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 95B096059C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614073795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKyuU9LWKwPaA0W8b7Zn/93LIBS1BDs8g8bsSMSJ0MM=;
 b=V2rSybndSo2HdHM+v/dVUQEcw5i7N5Gby+Z1NoWYvW15CL9bcsTUc/M9PpfyiUSqYSAxeH
 8zKGnzlGKfRLOayvaxC/w0JKyESrR+aIjnzIRbnBufTYZ6R9PA8Fs/6HvjP71BsVPEXB7N
 bOaKlEJkteq5+eBbnVstdyM/gts+sso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-Ft6zYw1bOe-pQyUCOJ4coQ-1; Tue, 23 Feb 2021 04:48:18 -0500
X-MC-Unique: Ft6zYw1bOe-pQyUCOJ4coQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF58E1085927;
 Tue, 23 Feb 2021 09:48:16 +0000 (UTC)
Received: from [10.72.13.6] (ovpn-13-6.pek2.redhat.com [10.72.13.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC8E19C45;
 Tue, 23 Feb 2021 09:48:11 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
 <20210221165047-mutt-send-email-mst@kernel.org>
 <20210222060526.GA110862@mtl-vdi-166.wap.labs.mlnx>
 <20210223042559-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <65494f6b-9613-1c0e-4a36-e4af2965235e@redhat.com>
Date: Tue, 23 Feb 2021 17:48:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223042559-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyDkuIvljYg1OjI2LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
TW9uLCBGZWIgMjIsIDIwMjEgYXQgMDg6MDU6MjZBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+
PiBPbiBTdW4sIEZlYiAyMSwgMjAyMSBhdCAwNDo1MjowNVBNIC0wNTAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4+PiBPbiBTdW4sIEZlYiAyMSwgMjAyMSBhdCAwNDo0NDozN1BNICswMjAw
LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gT24gRnJpLCBGZWIgMTksIDIwMjEgYXQgMDY6NTQ6NThB
TSAtMDUwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZk
cGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+Pj4+PiBmb3IgbGVnYWN5Iikg
bWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8gcmVzZXQKPj4+Pj4gZmVhdHVy
ZXMgdG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+
Pj4+IGFyZSBzZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkg
Y2hlY2sKPj4+Pj4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4K
Pj4+Pj4KPj4+Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3Rz
IGNvdWxkIGFjY2Vzcwo+Pj4+PiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQu
IEZvciBpbnN0YW5jZSwgd2hlbgo+Pj4+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2
ZXJ0aXNlZCBzb21lIG1vZGVybiBkcml2ZXIKPj4+Pj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFuZCB2
YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+Pj4+PiBzcGFjZSBiZWZvcmUg
dmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuIFJlamVjdGluZyByZXNldCB0byAwCj4+Pj4+IHByZW1h
dHVyZWx5IGNhdXNlcyBjb3JyZWN0IE1UVSBhbmQgbGluayBzdGF0dXMgdW5hYmxlIHRvIGxvYWQK
Pj4+Pj4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3MsIHJlbmRlcmluZyBp
c3N1ZXMgbGlrZQo+Pj4+PiBndWVzdCBzaG93aW5nIGluYWNjdXJhdGUgTVRVIHZhbHVlLCBvciBm
YWlsdXJlIHRvIHJlamVjdAo+Pj4+PiBvdXQtb2YtcmFuZ2UgTVRVLgo+Pj4+Pgo+Pj4+PiBGaXhl
czogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRl
ZCBtbHg1IGRldmljZXMiKQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1PHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jIHwgMTUgKy0tLS0tLS0tLS0tLS0tCj4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxNCBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+Pj4+PiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+Pj4+PiAtLS0g
YS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+IEBAIC0xNDkwLDE0ICsxNDkwLDYgQEAgc3Rh
dGljIHU2NCBtbHg1X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikK
Pj4+Pj4gICAJcmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7Cj4+Pj4+ICAgfQo+Pj4+PiAgIAo+
Pj4+PiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwgdTY0IGZlYXR1cmVzKQo+Pj4+PiAtewo+Pj4+PiAtCWlmICghKGZlYXR1cmVzICYg
QklUX1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkKPj4+Pj4gLQkJcmV0dXJuIC1FT1BO
T1RTVVBQOwo+Pj4+PiAtCj4+Pj4+IC0JcmV0dXJuIDA7Cj4+Pj4+IC19Cj4+Pj4+IC0KPj4+PiBC
dXQgd2hhdCBpZiBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gaXMgbm90IG9mZmVycmVkPyBUaGlz
IGRvZXMgbm90Cj4+Pj4gc3VwcG9ydCBzdWNoIGNhc2VzLgo+Pj4gRGlkIHlvdSBtZWFuICJjYXRj
aCBzdWNoIGNhc2VzIiByYXRoZXIgdGhhbiAic3VwcG9ydCI/Cj4+Pgo+PiBBY3R1YWxseSBJIG1l
YW50IHRoaXMgZHJpdmVyL2RldmljZSBkb2VzIG5vdCBzdXBwb3J0IHN1Y2ggY2FzZXMuCj4gV2Vs
bCB0aGUgcmVtb3ZlZCBjb2RlIG1lcmVseSBmYWlsZWQgd2l0aG91dCBWSVJUSU9fRl9BQ0NFU1Nf
UExBVEZPUk0KPiBpdCBkaWRuJ3QgYWN0dWFsbHkgdHJ5IHRvIHN1cHBvcnQgYW55dGhpbmcgLi4u
CgoKSSB0aGluayBpdCdzIHVzZWQgdG8gY2F0Y2ggdGhlIGRyaXZlciB0aGF0IGRvZXNuJ3Qgc3Vw
cG9ydCBBQ0NFU1NfUExBVEZPUk0/CgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
