Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E76C64E7B
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:41:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AC92075A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AC92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 38F1A2E210;
	Wed,  2 Dec 2020 13:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vzhPjrbFs63w; Wed,  2 Dec 2020 13:41:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 394222E183;
	Wed,  2 Dec 2020 13:41:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14D22C0859;
	Wed,  2 Dec 2020 13:41:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00288C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB2DB870E5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Igq4mDcFl5N5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:41:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3469B86FF6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606916483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vbxc9/ME5/SrQ1YXboDUD9984AjRX/c8zr65mwO3JWw=;
 b=EeWkGGphp3OoIS2BQwH75tNCxGlv9hGL1NtPbntT4uRre0tXN0gVSmF8LW3XOvaW3cAUGs
 AaGMMgpRNkiSJv0CGKW5y+KndxK6zj2mIieYS2Xcnw9BCzFMwzKvmvX1kCwwGloVo8ja0M
 oY38WOrZOmIKwiHFFJSeITPJOZxzrHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-v0V9xy5ZPbCj-sdI41EOEQ-1; Wed, 02 Dec 2020 08:41:19 -0500
X-MC-Unique: v0V9xy5ZPbCj-sdI41EOEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7322C106B6A3;
 Wed,  2 Dec 2020 13:41:17 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C8395C22B;
 Wed,  2 Dec 2020 13:41:10 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202042328-mutt-send-email-mst@kernel.org>
 <128487fe-8736-6d9e-3d07-b55dcb92c9b0@redhat.com>
 <20201202080149-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <692cfc1f-fb2d-1473-cc29-0231996de38d@redhat.com>
Date: Wed, 2 Dec 2020 21:41:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202080149-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMiDkuIvljYg5OjA0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBEZWMgMDIsIDIwMjAgYXQgMDg6NTY6MzdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAyMC8xMi8yIOS4i+WNiDU6MzAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIFdlZCwgRGVjIDAyLCAyMDIwIGF0IDEyOjE4OjM2UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4gT24gMjAyMC8xMi8xIOS4i+WNiDU6MjMsIENpbmR5IEx1IHdyb3RlOgo+Pj4+PiBP
biBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMTozMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDA2OjQxOjQ1
UE0gKzA4MDAsIENpbmR5IEx1IHdyb3RlOgo+Pj4+Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0
IDU6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+
Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjI3OjU5QU0gKzAyMDAsIEVsaSBDb2hlbiB3
cm90ZToKPj4+Pj4+Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDA0OjAwOjUxQU0gLTA1MDAs
IE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAy
MCBhdCAwODoyNzo0NkFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+IE9uIFN1
biwgTm92IDI5LCAyMDIwIGF0IDAzOjA4OjIyUE0gLTA1MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPj4+Pj4+Pj4+Pj4+IE9uIFN1biwgTm92IDI5LCAyMDIwIGF0IDA4OjQzOjUxQU0gKzAy
MDAsIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4+Pj4+Pj4+PiBXZSBzaG91bGQgbm90IHRyeSB0byB1
c2UgdGhlIFZGIE1BQyBhZGRyZXNzIGFzIHRoYXQgaXMgdXNlZCBieSB0aGUKPj4+Pj4+Pj4+Pj4+
PiByZWd1bGFyIChlLmcuIG1seDVfY29yZSkgTklDIGltcGxlbWVudGF0aW9uLiBJbnN0ZWFkLCB1
c2UgYSByYW5kb20KPj4+Pj4+Pj4+Pj4+PiBnZW5lcmF0ZWQgTUFDIGFkZHJlc3MuCj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBTdWdnZXN0ZWQgYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+Cj4+Pj4+Pj4+Pj4+Pj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZE
UEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPj4+Pj4+Pj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+Pj4+Pj4+Pj4+IEkgZGlk
bid0IHJlYWxpc2UgaXQncyBwb3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPj4+Pj4+Pj4+
Pj4+IHdpdGggYW5kIHdpdGhvdXQgdmRwYS4KPj4+Pj4+Pj4+Pj4gVXNpbmcgYSBWRiB5b3UgY2Fu
IGNyZWF0ZSBxdWl0ZSBhIGZldyByZXNvdXJjZXMsIGUuZy4gc2VuZCBxdWV1ZXMKPj4+Pj4+Pj4+
Pj4gcmVjaWV2ZSBxdWV1ZXMsIHZpcnRpb19uZXQgcXVldWVzIGV0Yy4gU28geW91IGNhbiBwb3Nz
aWJseSBjcmVhdGUKPj4+Pj4+Pj4+Pj4gc2V2ZXJhbCBpbnN0YW5jZXMgb2YgdmRwYSBuZXQgZGV2
aWNlcyBhbmQgbmljIG5ldCBkZXZpY2VzLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gQ291bGQg
eW91IGluY2x1ZGUgYSBiaXQgbW9yZSBkZXNjcmlwdGlvbiBvbiB0aGUgZmFpbHVyZQo+Pj4+Pj4+
Pj4+Pj4gbW9kZT8KPj4+Pj4+Pj4+Pj4gV2VsbCwgdXNpbmcgdGhlIE1BQyBhZGRyZXNzIG9mIHRo
ZSBuaWMgdnBvcnQgaXMgd3Jvbmcgc2luY2UgdGhhdCBpcyB0aGUKPj4+Pj4+Pj4+Pj4gTUFDIG9m
IHRoZSByZWd1bGFyIE5JQyBpbXBsZW1lbnRhdGlvbiBvZiBtbHg1X2NvcmUuCj4+Pj4+Pj4+Pj4g
UmlnaHQgYnV0IEFUTSBpdCBkb2Vzbid0IGNvZXhpc3Qgd2l0aCB2ZHBhIHNvIHdoYXQncyB0aGUg
cHJvYmxlbT8KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gVGhpcyBjYWxsIGlzIHdyb25nOiAgbWx4NV9x
dWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IElzIHN3
aXRjaGluZyB0byBhIHJhbmRvbSBtYWMgZm9yIHN1Y2ggYW4gdW51c3VhbAo+Pj4+Pj4+Pj4+Pj4g
Y29uZmlndXJhdGlvbiByZWFsbHkganVzdGlmaWVkPwo+Pj4+Pj4+Pj4+PiBTaW5jZSBJIGNhbid0
IHVzZSB0aGUgTklDJ3MgTUFDIGFkZHJlc3MsIEkgaGF2ZSB0d28gb3B0aW9uczoKPj4+Pj4+Pj4+
Pj4gMS4gVG8gZ2V0IHRoZSBNQUMgYWRkcmVzcyBhcyB3YXMgY2hvc2VuIGJ5IHRoZSB1c2VyIGFk
bWluaXN0ZXJpbmcgdGhlCj4+Pj4+Pj4+Pj4+ICAgICAgIE5JQy4gVGhpcyBzaG91bGQgaW52b2tl
IHRoZSBzZXRfY29uZmlnIGNhbGxiYWNrLiBVbmZvcnR1bmF0ZWx5IHRoaXMKPj4+Pj4+Pj4+Pj4g
ICAgICAgaXMgbm90IGltcGxlbWVudGVkIHlldC4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gMi4g
VXNlIGEgcmFuZG9tIE1BQyBhZGRyZXNzLiBUaGlzIGlzIE9LIHNpbmNlIGlmICgxKSBpcyBpbXBs
ZW1lbnRlZCBpdAo+Pj4+Pj4+Pj4+PiAgICAgICBjYW4gYWx3YXlzIG92ZXJyaWRlIHRoaXMgcmFu
ZG9tIGNvbmZpZ3VyYXRpb24uCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBJdCBsb29rcyBsaWtl
IGNoYW5naW5nIGEgTUFDIGNvdWxkIGJyZWFrIHNvbWUgZ3Vlc3RzLAo+Pj4+Pj4+Pj4+Pj4gY2Fu
IGl0IG5vdD8KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IE5vLCBpdCB3aWxsIG5vdC4gVGhlIGN1
cnJlbnQgdmVyc2lvbiBvZiBtbHg1IFZEUEEgZG9lcyBub3QgYWxsb3cgcmVndWxhcgo+Pj4+Pj4+
Pj4+PiBOSUMgZHJpdmVyIGFuZCBWRFBBIHRvIGNvLWV4aXN0LiBJIGhhdmUgcGF0Y2hlcyByZWFk
eSB0aGF0IGVuYWJsZSB0aGF0Cj4+Pj4+Pj4+Pj4+IGZyb20gc3RlZXJpbmcgcG9pbnQgb2Ygdmll
dy4gSSB3aWxsIHBvc3QgdGhlbSBoZXJlIG9uY2Ugb3RoZXIgcGF0Y2hlcyBvbgo+Pj4+Pj4+Pj4+
PiB3aGljaCB0aGV5IGRlcGVuZCB3aWxsIGJlIG1lcmdlZC4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9wYXRjaC8yMDIw
MTEyMDIzMDMzOS42NTE2MDktMTItc2FlZWRtQG52aWRpYS5jb20vCj4+Pj4+Pj4+Pj4gQ291bGQg
eW91IGJlIG1vcmUgZXhwbGljaXQgb24gdGhlIGZvbGxvd2luZyBwb2ludHM6Cj4+Pj4+Pj4+Pj4g
LSB3aGljaCBjb25maWd1cmF0aW9uIGlzIGJyb2tlbiBBVE0gKGFzIGluLCB0d28gZGV2aWNlIGhh
dmUgaWRlbnRpY2FsCj4+Pj4+Pj4+Pj4gICAgICBtYWNzPyBhbnkgb3RoZXIgaXNzdWVzKT8KPj4+
Pj4+Pj4+IFRoZSBvbmx5IHdyb25nIHRoaW5nIGlzIHRoZSBjYWxsIHRvICBtbHg1X3F1ZXJ5X25p
Y192cG9ydF9tYWNfYWRkcmVzcygpLgo+Pj4+Pj4+Pj4gSXQncyBub3QgYnJlYWtpbmcgYW55dGhp
bmcgeWV0IGlzIHdyb25nLiBUaGUgcmFuZG9tIE1BQyBhZGRyZXNzIHNldHRpbmcKPj4+Pj4+Pj4+
IGlzIHJlcXVpcmVkIGZvciB0aGUgc3RlZXJpbmcgcGF0Y2hlcy4KPj4+Pj4+Pj4gT2theSBzbyBJ
J20gbm90IHN1cmUgdGhlIEZpeGVzIHRhZyBhdCBsZWFzdCBpcyBhcHByb3ByaWF0ZSBpZiBpdCdz
IGEKPj4+Pj4+Pj4gZGVwZW5kZW5jeSBvZiBhIG5ldyBmZWF0dXJlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+IC0gd2h5IHdvbid0IGRldmljZSBNQUMgY2hhbmdlIGZyb20gZ3Vlc3QgcG9pbnQgb2Ygdmll
dz8KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSXQncyBsYWNrIG9mIGltcGxlbWVudGF0aW9uIGluIHFl
bXUgYXMgZmFyIGFzIEkga25vdy4KPj4+Pj4+Pj4gU29ycnkgbm90IHN1cmUgSSB1bmRlcnN0YW5k
LiBXaGF0J3Mgbm90IGltcGxlbWVudGVkIGluIFFFTVU/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4gSEkgTWlj
aGFlbCwgdGhlcmUgYXJlIHNvbWUgYnVnIGluIHFlbXUgdG8gc2V0X2NvbmZpZywgdGhpcyB3aWxs
IGZpeCBpbiBmdXR1cmUsCj4+Pj4+Pj4gQnV0IHRoaXMgcGF0Y2ggaXMgc3RpbGwgbmVlZGVkLCBi
ZWNhdXNlIHdpdGhvdXQgdGhpcyBwYXRjaCB0aGUgbWx4Cj4+Pj4+Pj4gZHJpdmVyIHdpbGwgZ2l2
ZSBhbiAwIG1hYyBhZGRyZXNzIHRvIHFlbXUKPj4+Pj4+PiBhbmQgcWVtdSB3aWxsIG92ZXJ3cml0
ZSB0aGUgZGVmYXVsdCBtYWMgYWRkcmVzcy4gIFRoaXMgd2lsbCBjYXVzZSB0cmFmZmljIGRvd24u
Cj4+Pj4+PiBIbW0gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHNheXMgVkYgbWFjIGFkZHJlc3MsIG5v
dCAwIGFkZHJlc3MuIENvbmZ1c2VkLgo+Pj4+Pj4gSWYgdGhlcmUncyBubyBtYWMgd2UgY2FuIGNs
ZWFyIFZJUlRJT19ORVRfRl9NQUMgYW5kIGhhdmUgZ3Vlc3QKPj4+Pj4+IHVzZSBhIHJhbmRvbSB2
YWx1ZSAuLi4KPj4+PiBJJ20gbm90IHN1cmUgdGhpcyBjYW4gd29yayBmb3IgYWxsIHR5cGVzIG9m
IHZEUEEgKGUuZyBpdCBjb3VsZCBub3QgYmUgYQo+Pj4+IGxlYXJuaW5nIGJyaWRnZSBpbiB0aGUg
c3d0aWNoKS4KPj4+Pgo+Pj4+Cj4+Pj4+IGhpIE1pY2hhZWzvvIwKPj4+Pj4gSSBoYXZlIHRyaWVk
IGFzIHlvdXIgc3VnZ2VzdGlvbiwgc2VlbXMgZXZlbiByZW1vdmUgdGhlCj4+Pj4+IFZJUlRJT19O
RVRfRl9NQUMgdGhlIHFlbXUgd2lsbCBzdGlsbCBjYWxsIGdldF9jaW5maWcgYW5kIG92ZXJ3cml0
ZSB0aGUKPj4+Pj4gZGVmYXVsdCBhZGRyZXNzIGluICBWTSwKPj4+PiBUaGlzIGxvb2tzIGEgYnVn
IGluIHFlbXUsIGluIGd1ZXN0IGRyaXZlciB3ZSBoYWQ6Cj4+Pj4KPj4+PiAgIMKgwqDCoCAvKiBD
b25maWd1cmF0aW9uIG1heSBzcGVjaWZ5IHdoYXQgTUFDIHRvIHVzZS7CoCBPdGhlcndpc2UgcmFu
ZG9tLiAqLwo+Pj4+ICAgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X05FVF9GX01BQykpCj4+Pj4gICDCoMKgwqAgwqDCoMKgIHZpcnRpb19jcmVhZF9ieXRlcyh2ZGV2
LAo+Pj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgb2Zmc2V0b2Yoc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnLCBtYWMpLAo+Pj4+ICAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqAgZGV2LT5kZXZfYWRkciwgZGV2LT5hZGRyX2xlbik7Cj4+Pj4gICDCoMKgwqAgZWxz
ZQo+Pj4+ICAgwqDCoMKgIMKgwqDCoCBldGhfaHdfYWRkcl9yYW5kb20oZGV2KTsKPj4+Pgo+Pj4+
Cj4+Pj4+IHRoaXMgcHJvY2VzcyBpcyBsaWtlCj4+Pj4+IHZkcGEgX2luaXQgLS0+cWVtdSBjYWxs
IGdldF9jb25maWcgLT5tbHggZHJpdmVyIHdpbGwgZ2l2ZSAgYW4gbWFjCj4+Pj4+IGFkZHJlc3Mg
d2l0aCBhbGwgMC0tPgo+Pj4+PiBxZW11IHdpbGwgbm90IGNoZWNrIHRoaXMgbWFjIGFkZHJlc3Mg
YW5kIHVzZSBpdCAtLT4gb3ZlcndyaXRlIHRoZSBtYWMKPj4+Pj4gYWRkcmVzcyBpbiBxZW11Cj4+
Pj4+Cj4+Pj4+IFNvIGZvciBteSB1bmRlcnN0YW5kaW5nIHRoZXJlIGFyZSBzZXZlcmFsIG1ldGhv
ZCB0byBmaXggdGhpcyBwcm9ibGVtCj4+Pj4+Cj4+Pj4+IDEsIHFlbXUgY2hlY2sgdGhlIG1hYyBh
ZGRyZXNzLCBpZiB0aGUgbWFjIGFkZHJlc3MgaXMgYWxsIDAsIHFlbXUgd2lsbAo+Pj4+PiBpZ25v
cmUgaXQgYW5kIHNldCB0aGUgcmFuZG9tIG1hYyBhZGRyZXNzIHRvIG1seCBkcml2ZXIuCj4+Pj4g
U28gbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LCBpZiBtYWMgYWRkcmVzcyBpcyBhbGwgMCwgdkRQ
QSBwYXJlbnQgc2hvdWxkIG5vdAo+Pj4+IGFkdmVydGlzZSBWSVJUSU9fTkVUX0ZfTUFDLiBBbmQg
cWVtdSBzaG91bGQgZW11bGF0ZSB0aGlzIGZlYXR1cmUgYXMgeW91IGRpZDoKPj4+Pgo+Pj4+IDEp
IGdldCBhIHJhbmRvbSBtYWMKPj4+IFRvIG1lIHRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0
aW9uLgo+Pj4KPj4+IElmIHRoZSBkcml2ZXIgbmVnb3RpYXRlcyB0aGUgVklSVElPX05FVF9GX01B
QyBmZWF0dXJlLCB0aGUgZHJpdmVyIE1VU1Qgc2V0Cj4+PiB0aGUgcGh5c2ljYWwgYWRkcmVzcyBv
ZiB0aGUgTklDIHRvIFxmaWVsZHttYWN9LiAgT3RoZXJ3aXNlLCBpdCBTSE9VTEQKPj4+IHVzZSBh
IGxvY2FsbHktYWRtaW5pc3RlcmVkIE1BQyBhZGRyZXNzIChzZWUgXGh5cGVycmVmW2ludHJvOklF
RUUgODAyXXtJRUVFIDgwMn0sCj4+PiBgYDkuMiA0OC1iaXQgdW5pdmVyc2FsIExBTiBNQUMgYWRk
cmVzc2VzJycpLgo+Pgo+PiBPbmUgcXVlc3Rpb24gaGVyZSwgd2hhdCBkaWQgInNldCIgbWVhbiBo
ZXJlIGNvbnNpZGVyIHRoZSBtYWMgaXMgZ2l2ZW4gYnkgdGhlCj4+IGRldmljZSBpdHNlbGY/Cj4+
Cj4KPiBUaGF0IGlzIG15IHVuZGVyc3RhbmRpbmcsIGFuZCB0aGlzIHNlZW1zIHRvIGJlIHdoYXQg
bGludXggZ3Vlc3RzIGRvLgo+Cj4+PiBXaGlsZSBub3Qgc2FpZCBleHBsaWNpdGx5LCB0aGUgYXNz
dW1wdGlvbiBJIHRoaW5rIGlzIHRoYXQgdGhlIGxvY2FsCj4+PiBNQUMgaXMgbm90IGEgbG9jYWwg
b25lLgo+Pj4KPj4+Cj4+Pj4gMikgYWR2ZXJ0aXNlIFZJUlRJT19ORVRfRl9NQUMKPj4+PiAzKSBz
ZXQgdGhlIHJhbmRvbSBtYWMgdG8gdkRQQSB0aHJvdWdoIHNldF9jb25maWcKPj4+IHRoYXQgcGFy
dCBsb29rcyB3cm9uZyB0byBtZS4gU2V0dGluZyBtYWMgdGhyb3VnaCBzZXRfY29uZmlnIHdhcwo+
Pj4gYSBwcmUtdmlydGlvLTEuMCB3YXkgdG8gc2VuZCBtYWMgdG8gZGV2aWNlLiBJbiAxLjAgd2Ug
aGF2ZQo+Pj4gVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBmb3IgdGhhdDoKPj4+Cj4+Pgo+
Pj4gCVdoZW4gdXNpbmcgdGhlIGxlZ2FjeSBpbnRlcmZhY2UsIFxmaWVsZHttYWN9IGlzIGRyaXZl
ci13cml0YWJsZQo+Pj4gCXdoaWNoIHByb3ZpZGVkIGEgd2F5IGZvciBkcml2ZXJzIHRvIHVwZGF0
ZSB0aGUgTUFDIHdpdGhvdXQKPj4+IAluZWdvdGlhdGluZyBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUNf
QUREUi4KPj4KPj4gTG9va3MgbGlrZSBpdCBkb2Vzbid0IHByZXZlbnQgdXMgZnJvbSBkb2luZyBz
by4KPiAgRnJvbSB3cml0aW5nIGludG8gbWFjPwo+IFllcyBpdCBkb2VzOgo+IAlEZXZpY2UgY29u
ZmlndXJhdGlvbiBmaWVsZHMgYXJlIGxpc3RlZCBiZWxvdywgdGhleSBhcmUgcmVhZC1vbmx5IGZv
ciBhIGRyaXZlci4gVGhlIFxmaWVsZHttYWN9IGFkZHJlc3MgZmllbGQKPiAJYWx3YXlzIGV4aXN0
cyAodGhvdWdoIGlzIG9ubHkgdmFsaWQgaWYgVklSVElPX05FVF9GX01BQyBpcyBzZXQpLCBhbmQK
PiAJXGZpZWxke3N0YXR1c30gb25seSBleGlzdHMgaWYgVklSVElPX05FVF9GX1NUQVRVUyBpcyBz
ZXQuCgoKT2theSwgc28gdGhpcyBpcyBhIGhpbnQgdGhhdCB0aGUgdkRQQSBwYXJlbnQgbmVlZHMg
dG8gY2hlY2sgYW5kIGlnbm9yZSAKdGhlIHdyaXRlIGlmIHZlcnNpb24gMSBpcyBuZWdvdGlhdGVk
LgoKCj4KPgo+PiBPdGhlcndpc2UgdGhpcyBicmluZ3MgYW4KPj4gaW1wbGljaXQgZGVwZW5kZW5j
eSBmb3IgY29udHJvbCB2aXJ0cXVldWUgaWYgd2Ugd2FudCB0byBzdXBwb3J0IDEuMD8KPj4KPj4g
VGhhbmtzCj4gV2l0aCAxLjAgeW91IGVpdGhlciBuZWVkIFZJUlRJT19ORVRfRl9DVFJMX01BQ19B
RERSIG9yIFZJUlRJT19ORVRfRl9NQUMuCj4KPgoKT2ssIHNvIGl0IGxvb2tzIHRvIG1lIFZJUlRJ
T19ORVRfRl9NQUMgaXMgdGhlIG9ubHkgY2hvaWNlIGZvciBtbHg1IApjb25zaWRlciBjb250cm9s
IHZxIGlzIG5vdCBzdXBwb3J0ZWQuCgpUaGFua3MKCgo+Pj4KPj4+Cj4+Pj4gNCkgYWR2ZXJ0aXNl
IHRoZSByYW5kb20gbWFjIHRvIGVtdWxhdGVkIGNvbmZpZyB0byBndWVzdAo+Pj4+Cj4+Pj4KPj4+
Pj4gMi4gbWx4IGRyaXZlciBjaGVja3MgdGhlIG1hYyBhZGRyZXNzIGFuZCBpZiB0aGlzIG1hYyBp
cyAwLCByZXR1cm4gZmFpbAo+Pj4+PiB0byBxZW11LCBidXQgdGhpcyBuZWVkIHRvIGNoYW5nZSB0
aGUgVUFQSS4KPj4+PiB1QVBJIGlzIHByb2JhYmx5IGZpbmUgc2luY2UgaW9jdGwgY2FuIGZhaWwu
wqAgV2UgY2FuIGNoYW5nZSB0aGUgdG8gYWxsb3cgdGhlCj4+Pj4gc2V0X2NvbmZpZyB0byBmYWls
IGJ1dCB2aXJpdG8gc3BlYyBkb2Vzbid0IGhhdmUgYSB3YXkgdG8gYWR2ZXJ0aXNlIHRoZSBlcnJv
cgo+Pj4+IGluIHRoaXMgY2FzZS4gQW55d2F5LCB0aGUgZHJpdmVyIG9ubHkgcmlzayBpdHNlbGYg
Zm9yIHNldHRpbmcgYSB3cm9uZyB2YWx1ZSwKPj4+PiBzbyB3ZSdyZSBwcm9iYWJseSBmaW5lLgo+
Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+PiAzLiBtbHggZHJpdmVyIGl0IHNoZWxmIHNo
b3VsZCBnZXQgYW4gY29ycmVjdCBtYWMgYWRkcmVzcyB3aGlsZSBpdCBpbml0Lgo+Pj4+PiA0LiBh
ZGQgY2hlY2sgaW4gcWVtdSBnZXRfY29uZmlnIGZ1bmN0aW9uICAsIGlmIHRoZXJlIGlzIG5vdCBG
X01BQyBUaGVuCj4+Pj4+IGlnbm9yZSB0aGUgbWFjIGFkZHJlc3MgZnJvbSBtbHggZHJpdmVyCj4+
Pj4+Cj4+Pj4+IG5vdCBzdXJlIHdoaWNoIG1ldGhvZCBpcyBtb3JlIHN1aXRhYmxlID8KPj4+Pj4K
Pj4+Pj4gVGhhbmtzCj4+Pj4+IENpbmR5Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4g
LS0tCj4+Pj4+Pj4+Pj4+Pj4gICAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8
IDUgKy0tLS0KPj4+Pj4+Pj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCA0IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4+Pj4+IGluZGV4IDFmYTZmY2FjODI5OS4uODBkMDZkOTU4
YjhiIDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYwo+Pj4+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+Pj4+Pj4+Pj4+Pj4+IEBAIC0xOTU1LDEwICsxOTU1LDcgQEAgdm9pZCAqbWx4NV92ZHBh
X2FkZF9kZXYoc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXYpCj4+Pj4+Pj4+Pj4+Pj4gICAgICAg
ICAgaWYgKGVycikKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX210dTsK
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IC0gICAgIGVyciA9IG1seDVfcXVlcnlfbmljX3Zw
b3J0X21hY19hZGRyZXNzKG1kZXYsIDAsIDAsIGNvbmZpZy0+bWFjKTsKPj4+Pj4+Pj4+Pj4+PiAt
ICAgICBpZiAoZXJyKQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgICAgICAgZ290byBlcnJfbXR1Owo+
Pj4+Pj4+Pj4+Pj4+IC0KPj4+Pj4+Pj4+Pj4+PiArICAgICBldGhfcmFuZG9tX2FkZHIoY29uZmln
LT5tYWMpOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIG12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2
LT5kZXZpY2U7Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jl
c291cmNlcygmbmRldi0+bXZkZXYpOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgIGlmIChlcnIpCj4+
Pj4+Pj4+Pj4+Pj4gLS0KPj4+Pj4+Pj4+Pj4+PiAyLjI2LjIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
