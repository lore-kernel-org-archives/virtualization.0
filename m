Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BAEC64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 12:57:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B282222C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 12:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B282222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 416AB87083;
	Wed,  2 Dec 2020 12:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SUFwJmbMbgu8; Wed,  2 Dec 2020 12:56:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38F2487062;
	Wed,  2 Dec 2020 12:56:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 255F0C163C;
	Wed,  2 Dec 2020 12:56:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD5C0C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 12:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B1B4876C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 12:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3txCKHPCTW1M
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 12:56:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 72648876C7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606913812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCRThPKyABM0bfMnN8HG/aiK0xkbuP/KVlWYOy50uMc=;
 b=c8/GK7S4a8m57yAUcagXO7YUerg/kmIt3u0aQBqfd9DzIcM3yn3QI854nAAkEtALEHDzzn
 Zs1FJ0efSbhdzY6LFpT4PoRtEMt6NqRdvzz/TepR2Z3h1LzZiL9RS68TQQgfDOdFJY63X3
 L1WCljwoIl6CJ2QcpHU/J9LG/B98lGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-fLKMDLe4Pz2tLz5TbiZNTg-1; Wed, 02 Dec 2020 07:56:46 -0500
X-MC-Unique: fLKMDLe4Pz2tLz5TbiZNTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E36DDF8C9;
 Wed,  2 Dec 2020 12:56:41 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCE7760BFA;
 Wed,  2 Dec 2020 12:56:38 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202042328-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <128487fe-8736-6d9e-3d07-b55dcb92c9b0@redhat.com>
Date: Wed, 2 Dec 2020 20:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202042328-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Ck9uIDIwMjAvMTIvMiDkuIvljYg1OjMwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBEZWMgMDIsIDIwMjAgYXQgMTI6MTg6MzZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAyMC8xMi8xIOS4i+WNiDU6MjMsIENpbmR5IEx1IHdyb3RlOgo+Pj4gT24gTW9uLCBO
b3YgMzAsIDIwMjAgYXQgMTE6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+Pj4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDY6NDE6NDVQTSArMDgwMCwg
Q2luZHkgTHUgd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDU6MzMgUE0gTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiBNb24sIE5v
diAzMCwgMjAyMCBhdCAxMToyNzo1OUFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4g
T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDQ6MDA6NTFBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+Pj4+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwODoyNzo0NkFNICsw
MjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBhdCAw
MzowODoyMlBNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24g
U3VuLCBOb3YgMjksIDIwMjAgYXQgMDg6NDM6NTFBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+
Pj4+Pj4+Pj4+PiBXZSBzaG91bGQgbm90IHRyeSB0byB1c2UgdGhlIFZGIE1BQyBhZGRyZXNzIGFz
IHRoYXQgaXMgdXNlZCBieSB0aGUKPj4+Pj4+Pj4+Pj4gcmVndWxhciAoZS5nLiBtbHg1X2NvcmUp
IE5JQyBpbXBsZW1lbnRhdGlvbi4gSW5zdGVhZCwgdXNlIGEgcmFuZG9tCj4+Pj4+Pj4+Pj4+IGdl
bmVyYXRlZCBNQUMgYWRkcmVzcy4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gU3VnZ2VzdGVkIGJ5
OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+Pj4+Pj4+Pj4+PiBGaXhlczogMWE4NmIzNzdh
YTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmlj
ZXMiKQo+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4KPj4+Pj4+Pj4+PiBJIGRpZG4ndCByZWFsaXNlIGl0J3MgcG9zc2libGUgdG8gdXNlIFZGIGlu
IHR3byB3YXlzCj4+Pj4+Pj4+Pj4gd2l0aCBhbmQgd2l0aG91dCB2ZHBhLgo+Pj4+Pj4+Pj4gVXNp
bmcgYSBWRiB5b3UgY2FuIGNyZWF0ZSBxdWl0ZSBhIGZldyByZXNvdXJjZXMsIGUuZy4gc2VuZCBx
dWV1ZXMKPj4+Pj4+Pj4+IHJlY2lldmUgcXVldWVzLCB2aXJ0aW9fbmV0IHF1ZXVlcyBldGMuIFNv
IHlvdSBjYW4gcG9zc2libHkgY3JlYXRlCj4+Pj4+Pj4+PiBzZXZlcmFsIGluc3RhbmNlcyBvZiB2
ZHBhIG5ldCBkZXZpY2VzIGFuZCBuaWMgbmV0IGRldmljZXMuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
IENvdWxkIHlvdSBpbmNsdWRlIGEgYml0IG1vcmUgZGVzY3JpcHRpb24gb24gdGhlIGZhaWx1cmUK
Pj4+Pj4+Pj4+PiBtb2RlPwo+Pj4+Pj4+Pj4gV2VsbCwgdXNpbmcgdGhlIE1BQyBhZGRyZXNzIG9m
IHRoZSBuaWMgdnBvcnQgaXMgd3Jvbmcgc2luY2UgdGhhdCBpcyB0aGUKPj4+Pj4+Pj4+IE1BQyBv
ZiB0aGUgcmVndWxhciBOSUMgaW1wbGVtZW50YXRpb24gb2YgbWx4NV9jb3JlLgo+Pj4+Pj4+PiBS
aWdodCBidXQgQVRNIGl0IGRvZXNuJ3QgY29leGlzdCB3aXRoIHZkcGEgc28gd2hhdCdzIHRoZSBw
cm9ibGVtPwo+Pj4+Pj4+Pgo+Pj4+Pj4+IFRoaXMgY2FsbCBpcyB3cm9uZzogIG1seDVfcXVlcnlf
bmljX3Zwb3J0X21hY19hZGRyZXNzKCkKPj4+Pj4+Pgo+Pj4+Pj4+Pj4+IElzIHN3aXRjaGluZyB0
byBhIHJhbmRvbSBtYWMgZm9yIHN1Y2ggYW4gdW51c3VhbAo+Pj4+Pj4+Pj4+IGNvbmZpZ3VyYXRp
b24gcmVhbGx5IGp1c3RpZmllZD8KPj4+Pj4+Pj4+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBOSUMn
cyBNQUMgYWRkcmVzcywgSSBoYXZlIHR3byBvcHRpb25zOgo+Pj4+Pj4+Pj4gMS4gVG8gZ2V0IHRo
ZSBNQUMgYWRkcmVzcyBhcyB3YXMgY2hvc2VuIGJ5IHRoZSB1c2VyIGFkbWluaXN0ZXJpbmcgdGhl
Cj4+Pj4+Pj4+PiAgICAgIE5JQy4gVGhpcyBzaG91bGQgaW52b2tlIHRoZSBzZXRfY29uZmlnIGNh
bGxiYWNrLiBVbmZvcnR1bmF0ZWx5IHRoaXMKPj4+Pj4+Pj4+ICAgICAgaXMgbm90IGltcGxlbWVu
dGVkIHlldC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAyLiBVc2UgYSByYW5kb20gTUFDIGFkZHJlc3Mu
IFRoaXMgaXMgT0sgc2luY2UgaWYgKDEpIGlzIGltcGxlbWVudGVkIGl0Cj4+Pj4+Pj4+PiAgICAg
IGNhbiBhbHdheXMgb3ZlcnJpZGUgdGhpcyByYW5kb20gY29uZmlndXJhdGlvbi4KPj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4gSXQgbG9va3MgbGlrZSBjaGFuZ2luZyBhIE1BQyBjb3VsZCBicmVhayBzb21l
IGd1ZXN0cywKPj4+Pj4+Pj4+PiBjYW4gaXQgbm90Pwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBObywg
aXQgd2lsbCBub3QuIFRoZSBjdXJyZW50IHZlcnNpb24gb2YgbWx4NSBWRFBBIGRvZXMgbm90IGFs
bG93IHJlZ3VsYXIKPj4+Pj4+Pj4+IE5JQyBkcml2ZXIgYW5kIFZEUEEgdG8gY28tZXhpc3QuIEkg
aGF2ZSBwYXRjaGVzIHJlYWR5IHRoYXQgZW5hYmxlIHRoYXQKPj4+Pj4+Pj4+IGZyb20gc3RlZXJp
bmcgcG9pbnQgb2Ygdmlldy4gSSB3aWxsIHBvc3QgdGhlbSBoZXJlIG9uY2Ugb3RoZXIgcGF0Y2hl
cyBvbgo+Pj4+Pj4+Pj4gd2hpY2ggdGhleSBkZXBlbmQgd2lsbCBiZSBtZXJnZWQuCj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L25ldGRldi9w
YXRjaC8yMDIwMTEyMDIzMDMzOS42NTE2MDktMTItc2FlZWRtQG52aWRpYS5jb20vCj4+Pj4+Pj4+
IENvdWxkIHlvdSBiZSBtb3JlIGV4cGxpY2l0IG9uIHRoZSBmb2xsb3dpbmcgcG9pbnRzOgo+Pj4+
Pj4+PiAtIHdoaWNoIGNvbmZpZ3VyYXRpb24gaXMgYnJva2VuIEFUTSAoYXMgaW4sIHR3byBkZXZp
Y2UgaGF2ZSBpZGVudGljYWwKPj4+Pj4+Pj4gICAgIG1hY3M/IGFueSBvdGhlciBpc3N1ZXMpPwo+
Pj4+Pj4+IFRoZSBvbmx5IHdyb25nIHRoaW5nIGlzIHRoZSBjYWxsIHRvICBtbHg1X3F1ZXJ5X25p
Y192cG9ydF9tYWNfYWRkcmVzcygpLgo+Pj4+Pj4+IEl0J3Mgbm90IGJyZWFraW5nIGFueXRoaW5n
IHlldCBpcyB3cm9uZy4gVGhlIHJhbmRvbSBNQUMgYWRkcmVzcyBzZXR0aW5nCj4+Pj4+Pj4gaXMg
cmVxdWlyZWQgZm9yIHRoZSBzdGVlcmluZyBwYXRjaGVzLgo+Pj4+Pj4gT2theSBzbyBJJ20gbm90
IHN1cmUgdGhlIEZpeGVzIHRhZyBhdCBsZWFzdCBpcyBhcHByb3ByaWF0ZSBpZiBpdCdzIGEKPj4+
Pj4+IGRlcGVuZGVuY3kgb2YgYSBuZXcgZmVhdHVyZS4KPj4+Pj4+Cj4+Pj4+Pj4+IC0gd2h5IHdv
bid0IGRldmljZSBNQUMgY2hhbmdlIGZyb20gZ3Vlc3QgcG9pbnQgb2Ygdmlldz8KPj4+Pj4+Pj4K
Pj4+Pj4+PiBJdCdzIGxhY2sgb2YgaW1wbGVtZW50YXRpb24gaW4gcWVtdSBhcyBmYXIgYXMgSSBr
bm93Lgo+Pj4+Pj4gU29ycnkgbm90IHN1cmUgSSB1bmRlcnN0YW5kLiBXaGF0J3Mgbm90IGltcGxl
bWVudGVkIGluIFFFTVU/Cj4+Pj4+Pgo+Pj4+PiBISSBNaWNoYWVsLCB0aGVyZSBhcmUgc29tZSBi
dWcgaW4gcWVtdSB0byBzZXRfY29uZmlnLCB0aGlzIHdpbGwgZml4IGluIGZ1dHVyZSwKPj4+Pj4g
QnV0IHRoaXMgcGF0Y2ggaXMgc3RpbGwgbmVlZGVkLCBiZWNhdXNlIHdpdGhvdXQgdGhpcyBwYXRj
aCB0aGUgbWx4Cj4+Pj4+IGRyaXZlciB3aWxsIGdpdmUgYW4gMCBtYWMgYWRkcmVzcyB0byBxZW11
Cj4+Pj4+IGFuZCBxZW11IHdpbGwgb3ZlcndyaXRlIHRoZSBkZWZhdWx0IG1hYyBhZGRyZXNzLiAg
VGhpcyB3aWxsIGNhdXNlIHRyYWZmaWMgZG93bi4KPj4+PiBIbW0gdGhlIHBhdGNoIGRlc2NyaXB0
aW9uIHNheXMgVkYgbWFjIGFkZHJlc3MsIG5vdCAwIGFkZHJlc3MuIENvbmZ1c2VkLgo+Pj4+IElm
IHRoZXJlJ3Mgbm8gbWFjIHdlIGNhbiBjbGVhciBWSVJUSU9fTkVUX0ZfTUFDIGFuZCBoYXZlIGd1
ZXN0Cj4+Pj4gdXNlIGEgcmFuZG9tIHZhbHVlIC4uLgo+Pgo+PiBJJ20gbm90IHN1cmUgdGhpcyBj
YW4gd29yayBmb3IgYWxsIHR5cGVzIG9mIHZEUEEgKGUuZyBpdCBjb3VsZCBub3QgYmUgYQo+PiBs
ZWFybmluZyBicmlkZ2UgaW4gdGhlIHN3dGljaCkuCj4+Cj4+Cj4+PiBoaSBNaWNoYWVs77yMCj4+
PiBJIGhhdmUgdHJpZWQgYXMgeW91ciBzdWdnZXN0aW9uLCBzZWVtcyBldmVuIHJlbW92ZSB0aGUK
Pj4+IFZJUlRJT19ORVRfRl9NQUMgdGhlIHFlbXUgd2lsbCBzdGlsbCBjYWxsIGdldF9jaW5maWcg
YW5kIG92ZXJ3cml0ZSB0aGUKPj4+IGRlZmF1bHQgYWRkcmVzcyBpbiAgVk0sCj4+Cj4+IFRoaXMg
bG9va3MgYSBidWcgaW4gcWVtdSwgaW4gZ3Vlc3QgZHJpdmVyIHdlIGhhZDoKPj4KPj4gIMKgwqDC
oCAvKiBDb25maWd1cmF0aW9uIG1heSBzcGVjaWZ5IHdoYXQgTUFDIHRvIHVzZS7CoCBPdGhlcndp
c2UgcmFuZG9tLiAqLwo+PiAgwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX01BQykpCj4+ICDCoMKgwqAgwqDCoMKgIHZpcnRpb19jcmVhZF9ieXRlcyh2ZGV2
LAo+PiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgb2Zmc2V0b2Yoc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnLCBtYWMpLAo+PiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqAgZGV2LT5kZXZfYWRkciwgZGV2LT5hZGRyX2xlbik7Cj4+ICDCoMKgwqAgZWxzZQo+PiAgwqDC
oMKgIMKgwqDCoCBldGhfaHdfYWRkcl9yYW5kb20oZGV2KTsKPj4KPj4KPj4+IHRoaXMgcHJvY2Vz
cyBpcyBsaWtlCj4+PiB2ZHBhIF9pbml0IC0tPnFlbXUgY2FsbCBnZXRfY29uZmlnIC0+bWx4IGRy
aXZlciB3aWxsIGdpdmUgIGFuIG1hYwo+Pj4gYWRkcmVzcyB3aXRoIGFsbCAwLS0+Cj4+PiBxZW11
IHdpbGwgbm90IGNoZWNrIHRoaXMgbWFjIGFkZHJlc3MgYW5kIHVzZSBpdCAtLT4gb3ZlcndyaXRl
IHRoZSBtYWMKPj4+IGFkZHJlc3MgaW4gcWVtdQo+Pj4KPj4+IFNvIGZvciBteSB1bmRlcnN0YW5k
aW5nIHRoZXJlIGFyZSBzZXZlcmFsIG1ldGhvZCB0byBmaXggdGhpcyBwcm9ibGVtCj4+Pgo+Pj4g
MSwgcWVtdSBjaGVjayB0aGUgbWFjIGFkZHJlc3MsIGlmIHRoZSBtYWMgYWRkcmVzcyBpcyBhbGwg
MCwgcWVtdSB3aWxsCj4+PiBpZ25vcmUgaXQgYW5kIHNldCB0aGUgcmFuZG9tIG1hYyBhZGRyZXNz
IHRvIG1seCBkcml2ZXIuCj4+Cj4+IFNvIG15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCwgaWYgbWFj
IGFkZHJlc3MgaXMgYWxsIDAsIHZEUEEgcGFyZW50IHNob3VsZCBub3QKPj4gYWR2ZXJ0aXNlIFZJ
UlRJT19ORVRfRl9NQUMuIEFuZCBxZW11IHNob3VsZCBlbXVsYXRlIHRoaXMgZmVhdHVyZSBhcyB5
b3UgZGlkOgo+Pgo+PiAxKSBnZXQgYSByYW5kb20gbWFjCj4gVG8gbWUgdGhpcyBsb29rcyBsaWtl
IGEgc3BlYyB2aW9sYXRpb24uCj4KPiBJZiB0aGUgZHJpdmVyIG5lZ290aWF0ZXMgdGhlIFZJUlRJ
T19ORVRfRl9NQUMgZmVhdHVyZSwgdGhlIGRyaXZlciBNVVNUIHNldAo+IHRoZSBwaHlzaWNhbCBh
ZGRyZXNzIG9mIHRoZSBOSUMgdG8gXGZpZWxke21hY30uICBPdGhlcndpc2UsIGl0IFNIT1VMRAo+
IHVzZSBhIGxvY2FsbHktYWRtaW5pc3RlcmVkIE1BQyBhZGRyZXNzIChzZWUgXGh5cGVycmVmW2lu
dHJvOklFRUUgODAyXXtJRUVFIDgwMn0sCj4gYGA5LjIgNDgtYml0IHVuaXZlcnNhbCBMQU4gTUFD
IGFkZHJlc3NlcycnKS4KCgpPbmUgcXVlc3Rpb24gaGVyZSwgd2hhdCBkaWQgInNldCIgbWVhbiBo
ZXJlIGNvbnNpZGVyIHRoZSBtYWMgaXMgZ2l2ZW4gYnkgCnRoZSBkZXZpY2UgaXRzZWxmPwoKCj4K
PiBXaGlsZSBub3Qgc2FpZCBleHBsaWNpdGx5LCB0aGUgYXNzdW1wdGlvbiBJIHRoaW5rIGlzIHRo
YXQgdGhlIGxvY2FsCj4gTUFDIGlzIG5vdCBhIGxvY2FsIG9uZS4KPgo+Cj4+IDIpIGFkdmVydGlz
ZSBWSVJUSU9fTkVUX0ZfTUFDCj4+IDMpIHNldCB0aGUgcmFuZG9tIG1hYyB0byB2RFBBIHRocm91
Z2ggc2V0X2NvbmZpZwo+IHRoYXQgcGFydCBsb29rcyB3cm9uZyB0byBtZS4gU2V0dGluZyBtYWMg
dGhyb3VnaCBzZXRfY29uZmlnIHdhcwo+IGEgcHJlLXZpcnRpby0xLjAgd2F5IHRvIHNlbmQgbWFj
IHRvIGRldmljZS4gSW4gMS4wIHdlIGhhdmUKPiBWSVJUSU9fTkVUX0NUUkxfTUFDX0FERFJfU0VU
IGZvciB0aGF0Ogo+Cj4KPiAJV2hlbiB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFjZSwgXGZpZWxk
e21hY30gaXMgZHJpdmVyLXdyaXRhYmxlCj4gCXdoaWNoIHByb3ZpZGVkIGEgd2F5IGZvciBkcml2
ZXJzIHRvIHVwZGF0ZSB0aGUgTUFDIHdpdGhvdXQKPiAJbmVnb3RpYXRpbmcgVklSVElPX05FVF9G
X0NUUkxfTUFDX0FERFIuCgoKTG9va3MgbGlrZSBpdCBkb2Vzbid0IHByZXZlbnQgdXMgZnJvbSBk
b2luZyBzby4gT3RoZXJ3aXNlIHRoaXMgYnJpbmdzIGFuIAppbXBsaWNpdCBkZXBlbmRlbmN5IGZv
ciBjb250cm9sIHZpcnRxdWV1ZSBpZiB3ZSB3YW50IHRvIHN1cHBvcnQgMS4wPwoKVGhhbmtzCgoK
Pgo+Cj4KPj4gNCkgYWR2ZXJ0aXNlIHRoZSByYW5kb20gbWFjIHRvIGVtdWxhdGVkIGNvbmZpZyB0
byBndWVzdAo+Pgo+Pgo+Pj4gMi4gbWx4IGRyaXZlciBjaGVja3MgdGhlIG1hYyBhZGRyZXNzIGFu
ZCBpZiB0aGlzIG1hYyBpcyAwLCByZXR1cm4gZmFpbAo+Pj4gdG8gcWVtdSwgYnV0IHRoaXMgbmVl
ZCB0byBjaGFuZ2UgdGhlIFVBUEkuCj4+Cj4+IHVBUEkgaXMgcHJvYmFibHkgZmluZSBzaW5jZSBp
b2N0bCBjYW4gZmFpbC7CoCBXZSBjYW4gY2hhbmdlIHRoZSB0byBhbGxvdyB0aGUKPj4gc2V0X2Nv
bmZpZyB0byBmYWlsIGJ1dCB2aXJpdG8gc3BlYyBkb2Vzbid0IGhhdmUgYSB3YXkgdG8gYWR2ZXJ0
aXNlIHRoZSBlcnJvcgo+PiBpbiB0aGlzIGNhc2UuIEFueXdheSwgdGhlIGRyaXZlciBvbmx5IHJp
c2sgaXRzZWxmIGZvciBzZXR0aW5nIGEgd3JvbmcgdmFsdWUsCj4+IHNvIHdlJ3JlIHByb2JhYmx5
IGZpbmUuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gMy4gbWx4IGRyaXZlciBpdCBzaGVsZiBzaG91
bGQgZ2V0IGFuIGNvcnJlY3QgbWFjIGFkZHJlc3Mgd2hpbGUgaXQgaW5pdC4KPj4+IDQuIGFkZCBj
aGVjayBpbiBxZW11IGdldF9jb25maWcgZnVuY3Rpb24gICwgaWYgdGhlcmUgaXMgbm90IEZfTUFD
IFRoZW4KPj4+IGlnbm9yZSB0aGUgbWFjIGFkZHJlc3MgZnJvbSBtbHggZHJpdmVyCj4+Pgo+Pj4g
bm90IHN1cmUgd2hpY2ggbWV0aG9kIGlzIG1vcmUgc3VpdGFibGUgPwo+Pj4KPj4+IFRoYW5rcwo+
Pj4gQ2luZHkKPj4+Cj4+Pgo+Pj4KPj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4+ICAgIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDUgKy0tLS0KPj4+Pj4+Pj4+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4+IGluZGV4IDFm
YTZmY2FjODI5OS4uODBkMDZkOTU4YjhiIDEwMDY0NAo+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4+IEBAIC0xOTU1LDEwICsxOTU1LDcgQEAg
dm9pZCAqbWx4NV92ZHBhX2FkZF9kZXYoc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXYpCj4+Pj4+
Pj4+Pj4+ICAgICAgICAgaWYgKGVycikKPj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX210dTsKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gLSAgICAgZXJyID0gbWx4NV9xdWVyeV9u
aWNfdnBvcnRfbWFjX2FkZHJlc3MobWRldiwgMCwgMCwgY29uZmlnLT5tYWMpOwo+Pj4+Pj4+Pj4+
PiAtICAgICBpZiAoZXJyKQo+Pj4+Pj4+Pj4+PiAtICAgICAgICAgICAgIGdvdG8gZXJyX210dTsK
Pj4+Pj4+Pj4+Pj4gLQo+Pj4+Pj4+Pj4+PiArICAgICBldGhfcmFuZG9tX2FkZHIoY29uZmlnLT5t
YWMpOwo+Pj4+Pj4+Pj4+PiAgICAgICAgIG12ZGV2LT52ZGV2LmRtYV9kZXYgPSBtZGV2LT5kZXZp
Y2U7Cj4+Pj4+Pj4+Pj4+ICAgICAgICAgZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcygm
bmRldi0+bXZkZXYpOwo+Pj4+Pj4+Pj4+PiAgICAgICAgIGlmIChlcnIpCj4+Pj4+Pj4+Pj4+IC0t
Cj4+Pj4+Pj4+Pj4+IDIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
