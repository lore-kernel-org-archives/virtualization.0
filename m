Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B375AC433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 06:02:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C32164D90
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 06:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C32164D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCF1F8671E;
	Tue,  2 Feb 2021 06:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THYBSz6HdVS0; Tue,  2 Feb 2021 06:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6E3D8667A;
	Tue,  2 Feb 2021 06:02:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E69DC0174;
	Tue,  2 Feb 2021 06:02:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F364C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 06:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7EBDF85550
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 06:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CIjm3Ighaurt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 06:02:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4830A854B4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 06:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612245757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv+JO+o92kqfUO0/yiRUpJMXYvQ7l6Zv4xglUcA9zbk=;
 b=LClPfzsIUoiW7t5ZSHu8b9mB+MflJ8frcJLw3oWEgRJReuVYf+M8Xj64FvEA4n+vo7ecZ8
 i3+Lde2387J9xpECcLa00LoSlIv8cWTBJrqCiC3OTpIC/zm69AnKE2FmGPwXy4KpS+Spaz
 XikNA25usoYLa8RCWqTR94lrGZBX2H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-vxzO02PZNzWru9DGqfcFAA-1; Tue, 02 Feb 2021 01:02:35 -0500
X-MC-Unique: vxzO02PZNzWru9DGqfcFAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B734F8049C0;
 Tue,  2 Feb 2021 06:02:33 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2241C5D9C6;
 Tue,  2 Feb 2021 06:02:26 +0000 (UTC)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Avoid unnecessary query virtqueue
To: Si-Wei Liu <siwliu.kernel@gmail.com>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-2-elic@nvidia.com>
 <CAPWQSg0XtEQ1U5N3a767Ak_naoyPdVF1CeE4r3hmN11a-aoBxg@mail.gmail.com>
 <CAPWQSg3U9DCSK_01Kzuea5B1X+Ef9JB23wBY82A3ss-UXGek_Q@mail.gmail.com>
 <9d6058d6-5ce1-0442-8fd9-5a6fe6a0bc6b@redhat.com>
 <CAPWQSg3KOAypcrs9krW8cGE7EDLTehCUCYFZMUYYNaYPH1oBZQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c65808bf-b336-8718-f7ea-b39fcc658dfb@redhat.com>
Date: Tue, 2 Feb 2021 14:02:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPWQSg3KOAypcrs9krW8cGE7EDLTehCUCYFZMUYYNaYPH1oBZQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: lulu@redhat.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjEvMi8yIOS4i+WNiDEyOjE1LCBTaS1XZWkgTGl1IHdyb3RlOgo+IE9uIE1vbiwgRmVi
IDEsIDIwMjEgYXQgNzoxMyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8yLzIg5LiK5Y2IMzoxNywgU2ktV2VpIExpdSB3cm90ZToKPj4+IE9u
IE1vbiwgRmViIDEsIDIwMjEgYXQgMTA6NTEgQU0gU2ktV2VpIExpdSA8c2l3bGl1Lmtlcm5lbEBn
bWFpbC5jb20+IHdyb3RlOgo+Pj4+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDU6NDYgQU0gRWxp
IENvaGVuIDxlbGljQG52aWRpYS5jb20+IHdyb3RlOgo+Pj4+PiBzdXNwZW5kX3ZxIHNob3VsZCBv
bmx5IHN1c3BlbmQgdGhlIFZRIG9uIG5vdCBzYXZlIHRoZSBjdXJyZW50IGF2YWlsYWJsZQo+Pj4+
PiBpbmRleC4gVGhpcyBpcyBkb25lIHdoZW4gYSBjaGFuZ2Ugb2YgbWFwIG9jY3VycyB3aGVuIHRo
ZSBkcml2ZXIgY2FsbHMKPj4+Pj4gc2F2ZV9jaGFubmVsX2luZm8oKS4KPj4+PiBIbW1tLCBzdXNw
ZW5kX3ZxKCkgaXMgYWxzbyBjYWxsZWQgYnkgdGVhcmRvd25fdnEoKSwgdGhlIGxhdHRlciBvZgo+
Pj4+IHdoaWNoIGRvZXNuJ3Qgc2F2ZSB0aGUgYXZhaWxhYmxlIGluZGV4IGFzIHNhdmVfY2hhbm5l
bF9pbmZvKCkgZG9lc24ndAo+Pj4+IGdldCBjYWxsZWQgaW4gdGhhdCBwYXRoIGF0IGFsbC4gSG93
IGRvZXMgaXQgaGFuZGxlIHRoZSBjYXNlIHRoYXQKPj4+PiBhZ2V0X3ZxX3N0YXRlKCkgaXMgY2Fs
bGVkIGZyb20gdXNlcnNwYWNlIChlLmcuIFFFTVUpIHdoaWxlIHRoZQo+Pj4+IGhhcmR3YXJlIFZR
IG9iamVjdCB3YXMgdG9ybiBkb3duLCBidXQgdXNlcnNwYWNlIHN0aWxsIHdhbnRzIHRvIGFjY2Vz
cwo+Pj4+IHRoZSBxdWV1ZSBpbmRleD8KPj4+Pgo+Pj4+IFJlZmVyIHRvIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL25ldGRldi8xNjAxNTgzNTExLTE1MTM4LTEtZ2l0LXNlbmQtZW1haWwtc2ktd2Vp
LmxpdUBvcmFjbGUuY29tLwo+Pj4+Cj4+Pj4gdmhvc3QgVlEgMCByaW5nIHJlc3RvcmUgZmFpbGVk
OiAtMTogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUgKDExKQo+Pj4+IHZob3N0IFZR
IDEgcmluZyByZXN0b3JlIGZhaWxlZDogLTE6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxh
YmxlICgxMSkKPj4+Pgo+Pj4+IFFFTVUgd2lsbCBjb21wbGFpbiB3aXRoIHRoZSBhYm92ZSB3YXJu
aW5nIHdoaWxlIFZNIGlzIGJlaW5nIHJlYm9vdGVkCj4+Pj4gb3Igc2h1dCBkb3duLgo+Pj4+Cj4+
Pj4gTG9va3MgdG8gbWUgZWl0aGVyIHRoZSBrZXJuZWwgZHJpdmVyIHNob3VsZCBjb3ZlciB0aGlz
IHJlcXVpcmVtZW50LCBvcgo+Pj4+IHRoZSB1c2Vyc3BhY2UgaGFzIHRvIGJlYXIgdGhlIGJ1cmRl
biBpbiBzYXZpbmcgdGhlIGluZGV4IGFuZCBub3QgY2FsbAo+Pj4+IGludG8ga2VybmVsIGlmIFZR
IGlzIGRlc3Ryb3llZC4KPj4+IEFjdHVhbGx5LCB0aGUgdXNlcnNwYWNlIGRvZXNuJ3QgaGF2ZSB0
aGUgaW5zaWdodHMgd2hldGhlciB2aXJ0IHF1ZXVlCj4+PiB3aWxsIGJlIGRlc3Ryb3llZCBpZiBq
dXN0IGNoYW5naW5nIHRoZSBkZXZpY2Ugc3RhdHVzIHZpYSBzZXRfc3RhdHVzKCkuCj4+PiBMb29r
aW5nIGF0IG90aGVyIHZkcGEgZHJpdmVyIGluIHRyZWUgaS5lLiBpZmN2ZiBpdCBkb2Vzbid0IGJl
aGF2ZSBsaWtlCj4+PiBzby4gSGVuY2UgdGhpcyBzdGlsbCBsb29rcyB0byBtZSB0byBiZSBNZWxs
YW5veCBzcGVjaWZpY3MgYW5kCj4+PiBtbHg1X3ZkcGEgaW1wbGVtZW50YXRpb24gZGV0YWlsIHRo
YXQgc2hvdWxkbid0IGV4cG9zZSB0byB1c2Vyc3BhY2UuCj4+Cj4+IFNvIEkgdGhpbmsgd2UgY2Fu
IHNpbXBseSBkcm9wIHRoaXMgcGF0Y2g/Cj4gWWVwLCBJIHRoaW5rIHNvLiBUbyBiZSBob25lc3Qg
SSBkb24ndCBrbm93IHdoeSBpdCBoYXMgYW55dGhpbmcgdG8gZG8KPiB3aXRoIHRoZSBtZW1vcnkg
aG90cGx1ZyBpc3N1ZS4KCgpFbGkgbWF5IGtub3cgbW9yZSwgbXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0LCBkdXJpbmcgbWVtb3J5IGhvdHBsdXQsIHFlbXUgCm5lZWQgdG8gcHJvcGFnYXRlIG5ldyBt
ZW1vcnkgbWFwcGluZ3MgdmlhIHNldF9tYXAoKS4gRm9yIG1lbGxhbm94LCBpdCAKbWVhbnMgaXQg
bmVlZHMgdG8gcmVidWlsZCBtZW1vcnkga2V5cywgc28gdGhlIHZpcnRxdWV1ZSBuZWVkcyB0byBi
ZSAKc3VzcGVuZGVkLgoKVGhhbmtzCgoKPgo+IC1TaXdlaQo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4+
IC1TaXdlaQo+Pj4+Cj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCA4IC0tLS0tLS0tCj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygt
KQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+IGluZGV4IDg4ZGRl
MzQ1NWJmZC4uNTQ5ZGVkMDc0ZmYzIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4+Pj4+IEBAIC0xMTQ4LDggKzExNDgsNiBAQCBzdGF0aWMgaW50IHNldHVwX3ZxKHN0
cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZx
KQo+Pj4+Pgo+Pj4+PiAgICBzdGF0aWMgdm9pZCBzdXNwZW5kX3ZxKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxKQo+Pj4+PiAgICB7Cj4+
Pj4+IC0gICAgICAgc3RydWN0IG1seDVfdmlydHFfYXR0ciBhdHRyOwo+Pj4+PiAtCj4+Pj4+ICAg
ICAgICAgICBpZiAoIW12cS0+aW5pdGlhbGl6ZWQpCj4+Pj4+ICAgICAgICAgICAgICAgICAgIHJl
dHVybjsKPj4+Pj4KPj4+Pj4gQEAgLTExNTgsMTIgKzExNTYsNiBAQCBzdGF0aWMgdm9pZCBzdXNw
ZW5kX3ZxKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRx
dWV1ZSAqbQo+Pj4+Pgo+Pj4+PiAgICAgICAgICAgaWYgKG1vZGlmeV92aXJ0cXVldWUobmRldiwg
bXZxLCBNTFg1X1ZJUlRJT19ORVRfUV9PQkpFQ1RfU1RBVEVfU1VTUEVORCkpCj4+Pj4+ICAgICAg
ICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKCZuZGV2LT5tdmRldiwgIm1vZGlmeSB0byBzdXNw
ZW5kIGZhaWxlZFxuIik7Cj4+Pj4+IC0KPj4+Pj4gLSAgICAgICBpZiAocXVlcnlfdmlydHF1ZXVl
KG5kZXYsIG12cSwgJmF0dHIpKSB7Cj4+Pj4+IC0gICAgICAgICAgICAgICBtbHg1X3ZkcGFfd2Fy
bigmbmRldi0+bXZkZXYsICJmYWlsZWQgdG8gcXVlcnkgdmlydHF1ZXVlXG4iKTsKPj4+Pj4gLSAg
ICAgICAgICAgICAgIHJldHVybjsKPj4+Pj4gLSAgICAgICB9Cj4+Pj4+IC0gICAgICAgbXZxLT5h
dmFpbF9pZHggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+Pj4gICAgfQo+Pj4+Pgo+Pj4+PiAg
ICBzdGF0aWMgdm9pZCBzdXNwZW5kX3ZxcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPj4+
Pj4gLS0KPj4+Pj4gMi4yOS4yCj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
