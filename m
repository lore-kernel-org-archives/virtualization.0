Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90389C64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 04:18:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7226221E2
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 04:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7226221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20D45877DC;
	Wed,  2 Dec 2020 04:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHpYQXB-t9Ag; Wed,  2 Dec 2020 04:18:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1383B877CE;
	Wed,  2 Dec 2020 04:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED665C0859;
	Wed,  2 Dec 2020 04:18:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF1EC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 04:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 81C4185F92
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 04:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z2L1iLC6_1zu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 04:18:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 29F3F85F8B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 04:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606882727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKLjGXRCIpjcgF67r8BnhprgVNy+jqChmRcBdfdwJYo=;
 b=Pgn9xxKNhDR2XE7w9KLyqDNkT/40sdr2v6Q5/T4TiX9q+5rTosbuPLtgOm0cuEKkyac4c6
 Pe8pjNBGsjQ0IgIDju5z8oh8ULAQHlh9F5cidrUD+yDizy53/awDR1zM78CRxK0arq6cRL
 v+rIPK8PAQrcEGCPUl6oGpR9TLfeEBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-pcG0PgjKOg6WDraIDaKtbA-1; Tue, 01 Dec 2020 23:18:43 -0500
X-MC-Unique: pcG0PgjKOg6WDraIDaKtbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3AF8558E9;
 Wed,  2 Dec 2020 04:18:42 +0000 (UTC)
Received: from [10.72.13.145] (ovpn-13-145.pek2.redhat.com [10.72.13.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4DF5D9DC;
 Wed,  2 Dec 2020 04:18:37 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20201129064351.63618-1-elic@nvidia.com>
 <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
Date: Wed, 2 Dec 2020 12:18:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvMTIvMSDkuIvljYg1OjIzLCBDaW5keSBMdSB3cm90ZToKPiBPbiBNb24sIE5vdiAz
MCwgMjAyMCBhdCAxMTozMyBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPj4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDY6NDE6NDVQTSArMDgwMCwgQ2luZHkg
THUgd3JvdGU6Cj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCA1OjMzIFBNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIw
IGF0IDExOjI3OjU5QU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4gT24gTW9uLCBOb3Yg
MzAsIDIwMjAgYXQgMDQ6MDA6NTFBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4+Pj4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMDg6Mjc6NDZBTSArMDIwMCwgRWxpIENvaGVu
IHdyb3RlOgo+Pj4+Pj4+IE9uIFN1biwgTm92IDI5LCAyMDIwIGF0IDAzOjA4OjIyUE0gLTA1MDAs
IE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4+Pj4gT24gU3VuLCBOb3YgMjksIDIwMjAg
YXQgMDg6NDM6NTFBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+Pj4+Pj4+Pj4gV2Ugc2hvdWxk
IG5vdCB0cnkgdG8gdXNlIHRoZSBWRiBNQUMgYWRkcmVzcyBhcyB0aGF0IGlzIHVzZWQgYnkgdGhl
Cj4+Pj4+Pj4+PiByZWd1bGFyIChlLmcuIG1seDVfY29yZSkgTklDIGltcGxlbWVudGF0aW9uLiBJ
bnN0ZWFkLCB1c2UgYSByYW5kb20KPj4+Pj4+Pj4+IGdlbmVyYXRlZCBNQUMgYWRkcmVzcy4KPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+PiBTdWdnZXN0ZWQgYnk6IENpbmR5IEx1IDxsdWx1QHJlZGhhdC5jb20+
Cj4+Pj4+Pj4+PiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2
ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
RWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4+IEkgZGlkbid0IHJlYWxpc2UgaXQn
cyBwb3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPj4+Pj4+Pj4gd2l0aCBhbmQgd2l0aG91
dCB2ZHBhLgo+Pj4+Pj4+IFVzaW5nIGEgVkYgeW91IGNhbiBjcmVhdGUgcXVpdGUgYSBmZXcgcmVz
b3VyY2VzLCBlLmcuIHNlbmQgcXVldWVzCj4+Pj4+Pj4gcmVjaWV2ZSBxdWV1ZXMsIHZpcnRpb19u
ZXQgcXVldWVzIGV0Yy4gU28geW91IGNhbiBwb3NzaWJseSBjcmVhdGUKPj4+Pj4+PiBzZXZlcmFs
IGluc3RhbmNlcyBvZiB2ZHBhIG5ldCBkZXZpY2VzIGFuZCBuaWMgbmV0IGRldmljZXMuCj4+Pj4+
Pj4KPj4+Pj4+Pj4gQ291bGQgeW91IGluY2x1ZGUgYSBiaXQgbW9yZSBkZXNjcmlwdGlvbiBvbiB0
aGUgZmFpbHVyZQo+Pj4+Pj4+PiBtb2RlPwo+Pj4+Pj4+IFdlbGwsIHVzaW5nIHRoZSBNQUMgYWRk
cmVzcyBvZiB0aGUgbmljIHZwb3J0IGlzIHdyb25nIHNpbmNlIHRoYXQgaXMgdGhlCj4+Pj4+Pj4g
TUFDIG9mIHRoZSByZWd1bGFyIE5JQyBpbXBsZW1lbnRhdGlvbiBvZiBtbHg1X2NvcmUuCj4+Pj4+
PiBSaWdodCBidXQgQVRNIGl0IGRvZXNuJ3QgY29leGlzdCB3aXRoIHZkcGEgc28gd2hhdCdzIHRo
ZSBwcm9ibGVtPwo+Pj4+Pj4KPj4+Pj4gVGhpcyBjYWxsIGlzIHdyb25nOiAgbWx4NV9xdWVyeV9u
aWNfdnBvcnRfbWFjX2FkZHJlc3MoKQo+Pj4+Pgo+Pj4+Pj4+PiBJcyBzd2l0Y2hpbmcgdG8gYSBy
YW5kb20gbWFjIGZvciBzdWNoIGFuIHVudXN1YWwKPj4+Pj4+Pj4gY29uZmlndXJhdGlvbiByZWFs
bHkganVzdGlmaWVkPwo+Pj4+Pj4+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBOSUMncyBNQUMgYWRk
cmVzcywgSSBoYXZlIHR3byBvcHRpb25zOgo+Pj4+Pj4+IDEuIFRvIGdldCB0aGUgTUFDIGFkZHJl
c3MgYXMgd2FzIGNob3NlbiBieSB0aGUgdXNlciBhZG1pbmlzdGVyaW5nIHRoZQo+Pj4+Pj4+ICAg
ICBOSUMuIFRoaXMgc2hvdWxkIGludm9rZSB0aGUgc2V0X2NvbmZpZyBjYWxsYmFjay4gVW5mb3J0
dW5hdGVseSB0aGlzCj4+Pj4+Pj4gICAgIGlzIG5vdCBpbXBsZW1lbnRlZCB5ZXQuCj4+Pj4+Pj4K
Pj4+Pj4+PiAyLiBVc2UgYSByYW5kb20gTUFDIGFkZHJlc3MuIFRoaXMgaXMgT0sgc2luY2UgaWYg
KDEpIGlzIGltcGxlbWVudGVkIGl0Cj4+Pj4+Pj4gICAgIGNhbiBhbHdheXMgb3ZlcnJpZGUgdGhp
cyByYW5kb20gY29uZmlndXJhdGlvbi4KPj4+Pj4+Pgo+Pj4+Pj4+PiBJdCBsb29rcyBsaWtlIGNo
YW5naW5nIGEgTUFDIGNvdWxkIGJyZWFrIHNvbWUgZ3Vlc3RzLAo+Pj4+Pj4+PiBjYW4gaXQgbm90
Pwo+Pj4+Pj4+Pgo+Pj4+Pj4+IE5vLCBpdCB3aWxsIG5vdC4gVGhlIGN1cnJlbnQgdmVyc2lvbiBv
ZiBtbHg1IFZEUEEgZG9lcyBub3QgYWxsb3cgcmVndWxhcgo+Pj4+Pj4+IE5JQyBkcml2ZXIgYW5k
IFZEUEEgdG8gY28tZXhpc3QuIEkgaGF2ZSBwYXRjaGVzIHJlYWR5IHRoYXQgZW5hYmxlIHRoYXQK
Pj4+Pj4+PiBmcm9tIHN0ZWVyaW5nIHBvaW50IG9mIHZpZXcuIEkgd2lsbCBwb3N0IHRoZW0gaGVy
ZSBvbmNlIG90aGVyIHBhdGNoZXMgb24KPj4+Pj4+PiB3aGljaCB0aGV5IGRlcGVuZCB3aWxsIGJl
IG1lcmdlZC4KPj4+Pj4+Pgo+Pj4+Pj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJv
amVjdC9uZXRkZXYvcGF0Y2gvMjAyMDExMjAyMzAzMzkuNjUxNjA5LTEyLXNhZWVkbUBudmlkaWEu
Y29tLwo+Pj4+Pj4gQ291bGQgeW91IGJlIG1vcmUgZXhwbGljaXQgb24gdGhlIGZvbGxvd2luZyBw
b2ludHM6Cj4+Pj4+PiAtIHdoaWNoIGNvbmZpZ3VyYXRpb24gaXMgYnJva2VuIEFUTSAoYXMgaW4s
IHR3byBkZXZpY2UgaGF2ZSBpZGVudGljYWwKPj4+Pj4+ICAgIG1hY3M/IGFueSBvdGhlciBpc3N1
ZXMpPwo+Pj4+PiBUaGUgb25seSB3cm9uZyB0aGluZyBpcyB0aGUgY2FsbCB0byAgbWx4NV9xdWVy
eV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKS4KPj4+Pj4gSXQncyBub3QgYnJlYWtpbmcgYW55dGhp
bmcgeWV0IGlzIHdyb25nLiBUaGUgcmFuZG9tIE1BQyBhZGRyZXNzIHNldHRpbmcKPj4+Pj4gaXMg
cmVxdWlyZWQgZm9yIHRoZSBzdGVlcmluZyBwYXRjaGVzLgo+Pj4+IE9rYXkgc28gSSdtIG5vdCBz
dXJlIHRoZSBGaXhlcyB0YWcgYXQgbGVhc3QgaXMgYXBwcm9wcmlhdGUgaWYgaXQncyBhCj4+Pj4g
ZGVwZW5kZW5jeSBvZiBhIG5ldyBmZWF0dXJlLgo+Pj4+Cj4+Pj4+PiAtIHdoeSB3b24ndCBkZXZp
Y2UgTUFDIGNoYW5nZSBmcm9tIGd1ZXN0IHBvaW50IG9mIHZpZXc/Cj4+Pj4+Pgo+Pj4+PiBJdCdz
IGxhY2sgb2YgaW1wbGVtZW50YXRpb24gaW4gcWVtdSBhcyBmYXIgYXMgSSBrbm93Lgo+Pj4+IFNv
cnJ5IG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gV2hhdCdzIG5vdCBpbXBsZW1lbnRlZCBpbiBRRU1V
Pwo+Pj4+Cj4+PiBISSBNaWNoYWVsLCB0aGVyZSBhcmUgc29tZSBidWcgaW4gcWVtdSB0byBzZXRf
Y29uZmlnLCB0aGlzIHdpbGwgZml4IGluIGZ1dHVyZSwKPj4+IEJ1dCB0aGlzIHBhdGNoIGlzIHN0
aWxsIG5lZWRlZCwgYmVjYXVzZSB3aXRob3V0IHRoaXMgcGF0Y2ggdGhlIG1seAo+Pj4gZHJpdmVy
IHdpbGwgZ2l2ZSBhbiAwIG1hYyBhZGRyZXNzIHRvIHFlbXUKPj4+IGFuZCBxZW11IHdpbGwgb3Zl
cndyaXRlIHRoZSBkZWZhdWx0IG1hYyBhZGRyZXNzLiAgVGhpcyB3aWxsIGNhdXNlIHRyYWZmaWMg
ZG93bi4KPj4gSG1tIHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBzYXlzIFZGIG1hYyBhZGRyZXNzLCBu
b3QgMCBhZGRyZXNzLiBDb25mdXNlZC4KPj4gSWYgdGhlcmUncyBubyBtYWMgd2UgY2FuIGNsZWFy
IFZJUlRJT19ORVRfRl9NQUMgYW5kIGhhdmUgZ3Vlc3QKPj4gdXNlIGEgcmFuZG9tIHZhbHVlIC4u
LgoKCkknbSBub3Qgc3VyZSB0aGlzIGNhbiB3b3JrIGZvciBhbGwgdHlwZXMgb2YgdkRQQSAoZS5n
IGl0IGNvdWxkIG5vdCBiZSBhIApsZWFybmluZyBicmlkZ2UgaW4gdGhlIHN3dGljaCkuCgoKPj4K
PiBoaSBNaWNoYWVs77yMCj4gSSBoYXZlIHRyaWVkIGFzIHlvdXIgc3VnZ2VzdGlvbiwgc2VlbXMg
ZXZlbiByZW1vdmUgdGhlCj4gVklSVElPX05FVF9GX01BQyB0aGUgcWVtdSB3aWxsIHN0aWxsIGNh
bGwgZ2V0X2NpbmZpZyBhbmQgb3ZlcndyaXRlIHRoZQo+IGRlZmF1bHQgYWRkcmVzcyBpbiAgVk0s
CgoKVGhpcyBsb29rcyBhIGJ1ZyBpbiBxZW11LCBpbiBndWVzdCBkcml2ZXIgd2UgaGFkOgoKIMKg
wqDCoCAvKiBDb25maWd1cmF0aW9uIG1heSBzcGVjaWZ5IHdoYXQgTUFDIHRvIHVzZS7CoCBPdGhl
cndpc2UgcmFuZG9tLiAqLwogwqDCoMKgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX01BQykpCiDCoMKgwqAgwqDCoMKgIHZpcnRpb19jcmVhZF9ieXRlcyh2ZGV2LAog
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnLCBtYWMpLAogwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqAgZGV2LT5k
ZXZfYWRkciwgZGV2LT5hZGRyX2xlbik7CiDCoMKgwqAgZWxzZQogwqDCoMKgIMKgwqDCoCBldGhf
aHdfYWRkcl9yYW5kb20oZGV2KTsKCgo+IHRoaXMgcHJvY2VzcyBpcyBsaWtlCj4gdmRwYSBfaW5p
dCAtLT5xZW11IGNhbGwgZ2V0X2NvbmZpZyAtPm1seCBkcml2ZXIgd2lsbCBnaXZlICBhbiBtYWMK
PiBhZGRyZXNzIHdpdGggYWxsIDAtLT4KPiBxZW11IHdpbGwgbm90IGNoZWNrIHRoaXMgbWFjIGFk
ZHJlc3MgYW5kIHVzZSBpdCAtLT4gb3ZlcndyaXRlIHRoZSBtYWMKPiBhZGRyZXNzIGluIHFlbXUK
Pgo+IFNvIGZvciBteSB1bmRlcnN0YW5kaW5nIHRoZXJlIGFyZSBzZXZlcmFsIG1ldGhvZCB0byBm
aXggdGhpcyBwcm9ibGVtCj4KPiAxLCBxZW11IGNoZWNrIHRoZSBtYWMgYWRkcmVzcywgaWYgdGhl
IG1hYyBhZGRyZXNzIGlzIGFsbCAwLCBxZW11IHdpbGwKPiBpZ25vcmUgaXQgYW5kIHNldCB0aGUg
cmFuZG9tIG1hYyBhZGRyZXNzIHRvIG1seCBkcml2ZXIuCgoKU28gbXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0LCBpZiBtYWMgYWRkcmVzcyBpcyBhbGwgMCwgdkRQQSBwYXJlbnQgc2hvdWxkIApub3Qg
YWR2ZXJ0aXNlIFZJUlRJT19ORVRfRl9NQUMuIEFuZCBxZW11IHNob3VsZCBlbXVsYXRlIHRoaXMg
ZmVhdHVyZSBhcyAKeW91IGRpZDoKCjEpIGdldCBhIHJhbmRvbSBtYWMKMikgYWR2ZXJ0aXNlIFZJ
UlRJT19ORVRfRl9NQUMKMykgc2V0IHRoZSByYW5kb20gbWFjIHRvIHZEUEEgdGhyb3VnaCBzZXRf
Y29uZmlnCjQpIGFkdmVydGlzZSB0aGUgcmFuZG9tIG1hYyB0byBlbXVsYXRlZCBjb25maWcgdG8g
Z3Vlc3QKCgo+IDIuIG1seCBkcml2ZXIgY2hlY2tzIHRoZSBtYWMgYWRkcmVzcyBhbmQgaWYgdGhp
cyBtYWMgaXMgMCwgcmV0dXJuIGZhaWwKPiB0byBxZW11LCBidXQgdGhpcyBuZWVkIHRvIGNoYW5n
ZSB0aGUgVUFQSS4KCgp1QVBJIGlzIHByb2JhYmx5IGZpbmUgc2luY2UgaW9jdGwgY2FuIGZhaWwu
wqAgV2UgY2FuIGNoYW5nZSB0aGUgdG8gYWxsb3cgCnRoZSBzZXRfY29uZmlnIHRvIGZhaWwgYnV0
IHZpcml0byBzcGVjIGRvZXNuJ3QgaGF2ZSBhIHdheSB0byBhZHZlcnRpc2UgCnRoZSBlcnJvciBp
biB0aGlzIGNhc2UuIEFueXdheSwgdGhlIGRyaXZlciBvbmx5IHJpc2sgaXRzZWxmIGZvciBzZXR0
aW5nIAphIHdyb25nIHZhbHVlLCBzbyB3ZSdyZSBwcm9iYWJseSBmaW5lLgoKVGhhbmtzCgoKPiAz
LiBtbHggZHJpdmVyIGl0IHNoZWxmIHNob3VsZCBnZXQgYW4gY29ycmVjdCBtYWMgYWRkcmVzcyB3
aGlsZSBpdCBpbml0Lgo+IDQuIGFkZCBjaGVjayBpbiBxZW11IGdldF9jb25maWcgZnVuY3Rpb24g
ICwgaWYgdGhlcmUgaXMgbm90IEZfTUFDIFRoZW4KPiBpZ25vcmUgdGhlIG1hYyBhZGRyZXNzIGZy
b20gbWx4IGRyaXZlcgo+Cj4gbm90IHN1cmUgd2hpY2ggbWV0aG9kIGlzIG1vcmUgc3VpdGFibGUg
Pwo+Cj4gVGhhbmtzCj4gQ2luZHkKPgo+Cj4KPj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4gICBkcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA1ICstLS0tCj4+Pj4+Pj4+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4+Cj4+Pj4+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+PiBpbmRleCAxZmE2ZmNhYzgy
OTkuLjgwZDA2ZDk1OGI4YiAxMDA2NDQKPj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jCj4+Pj4+Pj4+PiBAQCAtMTk1NSwxMCArMTk1NSw3IEBAIHZvaWQgKm1seDVfdmRw
YV9hZGRfZGV2KHN0cnVjdCBtbHg1X2NvcmVfZGV2ICptZGV2KQo+Pj4+Pj4+Pj4gICAgICAgIGlm
IChlcnIpCj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICBnb3RvIGVycl9tdHU7Cj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4gLSAgICAgZXJyID0gbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MobWRl
diwgMCwgMCwgY29uZmlnLT5tYWMpOwo+Pj4+Pj4+Pj4gLSAgICAgaWYgKGVycikKPj4+Pj4+Pj4+
IC0gICAgICAgICAgICAgZ290byBlcnJfbXR1Owo+Pj4+Pj4+Pj4gLQo+Pj4+Pj4+Pj4gKyAgICAg
ZXRoX3JhbmRvbV9hZGRyKGNvbmZpZy0+bWFjKTsKPj4+Pj4+Pj4+ICAgICAgICBtdmRldi0+dmRl
di5kbWFfZGV2ID0gbWRldi0+ZGV2aWNlOwo+Pj4+Pj4+Pj4gICAgICAgIGVyciA9IG1seDVfdmRw
YV9hbGxvY19yZXNvdXJjZXMoJm5kZXYtPm12ZGV2KTsKPj4+Pj4+Pj4+ICAgICAgICBpZiAoZXJy
KQo+Pj4+Pj4+Pj4gLS0KPj4+Pj4+Pj4+IDIuMjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
