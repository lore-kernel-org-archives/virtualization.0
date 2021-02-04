Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331FC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 03:15:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A5A64E2C
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 03:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A5A64E2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D4CC8619E;
	Thu,  4 Feb 2021 03:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDpItgrJ6tnD; Thu,  4 Feb 2021 03:15:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 699AC860C1;
	Thu,  4 Feb 2021 03:15:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 455E9C0174;
	Thu,  4 Feb 2021 03:15:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4659CC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2CB39860C1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6CTB8_CPOhF4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 314818600D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612408496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3nSOkJ4+1o5Qg644rs4bNZhLAp4rDjJyu++BsMPd2E=;
 b=O+hwFlP96jNoNTeXsNEiZQTAjOAh/tS/3CLxWt8f7l9ry2A5UlP/AuR96YxUTAW7GWAtrR
 2xv14lxnwcPyP4YIKIrNVVb9DmRHGqoiFMFpyQj3s6FvPJHw3npTntGU5DIqJ9ResuNXSc
 88K7HEMWnkw5zLa1+1E7wsb+KsGYALE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-2eaBbwwBM96jJ8AtkWZVOA-1; Wed, 03 Feb 2021 22:14:55 -0500
X-MC-Unique: 2eaBbwwBM96jJ8AtkWZVOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49337107ACE3;
 Thu,  4 Feb 2021 03:14:53 +0000 (UTC)
Received: from [10.72.14.1] (ovpn-14-1.pek2.redhat.com [10.72.14.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C1C25D9C0;
 Thu,  4 Feb 2021 03:14:42 +0000 (UTC)
Subject: Re: [RFC 05/10] vhost: Add vhost_dev_from_virtio
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-6-eperezma@redhat.com>
 <acf16fd6-2282-c220-e642-0868ac839b70@redhat.com>
 <CAJaqyWeRK_i3MMZVgXJUwUNfLaq_h80jChZfQ3sRmWAcQnGLkQ@mail.gmail.com>
 <a526b3ac-91d9-28e6-5ffc-2308aab4fbd6@redhat.com>
 <CAJaqyWf-qsr5eLzk4Sum=GYhHoW_+V-9arfbssSjd6G6WnretQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a37502d6-b83f-fd34-7634-1060f4661540@redhat.com>
Date: Thu, 4 Feb 2021 11:14:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf-qsr5eLzk4Sum=GYhHoW_+V-9arfbssSjd6G6WnretQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Rob Miller <rob.miller@broadcom.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 virtualization@lists.linux-foundation.org, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>
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

Ck9uIDIwMjEvMi8yIOS4i+WNiDY6MTcsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+IE9u
IFR1ZSwgRmViIDIsIDIwMjEgYXQgNDozMSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzEg5LiL5Y2INDoyOCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAxLCAyMDIxIGF0IDc6MTMgQU0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8xLzMwIOS4iuWNiDQ6
NTQsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+Pj4gLS0tCj4+Pj4+ICAgICBpbmNsdWRlL2h3
L3ZpcnRpby92aG9zdC5oIHwgIDEgKwo+Pj4+PiAgICAgaHcvdmlydGlvL3Zob3N0LmMgICAgICAg
ICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDE4IGlu
c2VydGlvbnMoKykKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zo
b3N0LmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oCj4+Pj4+IGluZGV4IDRhOGJjNzU0MTUu
LmZjYTA3NmUzZjAgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmgK
Pj4+Pj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaAo+Pj4+PiBAQCAtMTIzLDYgKzEy
Myw3IEBAIHVpbnQ2NF90IHZob3N0X2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpoZGV2
LCBjb25zdCBpbnQgKmZlYXR1cmVfYml0cywKPj4+Pj4gICAgIHZvaWQgdmhvc3RfYWNrX2ZlYXR1
cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmhkZXYsIGNvbnN0IGludCAqZmVhdHVyZV9iaXRzLAo+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZmVhdHVyZXMpOwo+Pj4+PiAg
ICAgYm9vbCB2aG9zdF9oYXNfZnJlZV9zbG90KHZvaWQpOwo+Pj4+PiArc3RydWN0IHZob3N0X2Rl
diAqdmhvc3RfZGV2X2Zyb21fdmlydGlvKGNvbnN0IFZpcnRJT0RldmljZSAqdmRldik7Cj4+Pj4+
Cj4+Pj4+ICAgICBpbnQgdmhvc3RfbmV0X3NldF9iYWNrZW5kKHN0cnVjdCB2aG9zdF9kZXYgKmhk
ZXYsCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92cmlu
Z19maWxlICpmaWxlKTsKPj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC5jIGIvaHcv
dmlydGlvL3Zob3N0LmMKPj4+Pj4gaW5kZXggMjhjN2Q3ODE3Mi4uODY4M2Q1MDdmNSAxMDA2NDQK
Pj4+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMKPj4+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0
LmMKPj4+Pj4gQEAgLTYxLDYgKzYxLDIzIEBAIGJvb2wgdmhvc3RfaGFzX2ZyZWVfc2xvdCh2b2lk
KQo+Pj4+PiAgICAgICAgIHJldHVybiBzbG90c19saW1pdCA+IHVzZWRfbWVtc2xvdHM7Cj4+Pj4+
ICAgICB9Cj4+Pj4+Cj4+Pj4+ICsvKgo+Pj4+PiArICogR2V0IHRoZSB2aG9zdCBkZXZpY2UgYXNz
b2NpYXRlZCB0byBhIFZpcnRJTyBkZXZpY2UuCj4+Pj4+ICsgKi8KPj4+Pj4gK3N0cnVjdCB2aG9z
dF9kZXYgKnZob3N0X2Rldl9mcm9tX3ZpcnRpbyhjb25zdCBWaXJ0SU9EZXZpY2UgKnZkZXYpCj4+
Pj4+ICt7Cj4+Pj4+ICsgICAgc3RydWN0IHZob3N0X2RldiAqaGRldjsKPj4+Pj4gKwo+Pj4+PiAr
ICAgIFFMSVNUX0ZPUkVBQ0goaGRldiwgJnZob3N0X2RldmljZXMsIGVudHJ5KSB7Cj4+Pj4+ICsg
ICAgICAgIGlmIChoZGV2LT52ZGV2ID09IHZkZXYpIHsKPj4+Pj4gKyAgICAgICAgICAgIHJldHVy
biBoZGV2Owo+Pj4+PiArICAgICAgICB9Cj4+Pj4+ICsgICAgfQo+Pj4+PiArCj4+Pj4+ICsgICAg
YXNzZXJ0KGhkZXYpOwo+Pj4+PiArICAgIHJldHVybiBOVUxMOwo+Pj4+PiArfQo+Pj4+IEknbSBu
b3Qgc3VyZSB0aGlzIGNhbiB3b3JrIGluIHRoZSBjYXNlIG9mIG11bHRpcXVldWUuIEUuZyB2aG9z
dC1uZXQKPj4+PiBtdWx0aXF1ZXVlIGlzIGEgTjoxIG1hcHBpbmcgYmV0d2VlbiB2aG9zdCBkZXZp
Y3MgYW5kIHZpcnRpbyBkZXZpY2VzLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+IFJpZ2h0LiBX
ZSBjb3VsZCBhZGQgYW4gInZkZXYgdnEgaW5kZXgiIHBhcmFtZXRlciB0byB0aGUgZnVuY3Rpb24g
aW4KPj4+IHRoaXMgY2FzZSwgYnV0IEkgZ3Vlc3MgdGhlIG1vc3QgcmVsaWFibGUgd2F5IHRvIGRv
IHRoaXMgaXMgdG8gYWRkIGEKPj4+IHZob3N0X29wYXF1ZSB2YWx1ZSB0byBWaXJ0UXVldWUsIGFz
IFN0ZWZhbiBwcm9wb3NlZCBpbiBwcmV2aW91cyBSRkMuCj4+Cj4+IFNvIHRoZSBxdWVzdGlvbiBz
dGlsbCwgaXQgbG9va3MgbGlrZSBpdCdzIGVhc2llciB0byBoaWRlIHRoZSBzaGFkb3cKPj4gdmly
dHF1ZXVlIHN0dWZmcyBhdCB2aG9zdCBsYXllciBpbnN0ZWFkIG9mIGV4cG9zZSB0aGVtIHRvIHZp
cnRpbyBsYXllcjoKPj4KPj4gMSkgdmhvc3QgcHJvdG9jb2wgaXMgc3RhYmxlIEFCSQo+PiAyKSBu
byBuZWVkIHRvIGRlYWwgd2l0aCB2aXJ0aW8gc3R1ZmZzIHdoaWNoIGlzIG1vcmUgY29tcGxleCB0
aGFuIHZob3N0Cj4+Cj4+IE9yIGFyZSB0aGVyZSBhbnkgYWR2YW50YWdlcyBpZiB3ZSBkbyBpdCBh
dCB2aXJ0aW8gbGF5ZXI/Cj4+Cj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHdlIHdpbGwgbmVlZCB0
aGUgdmlydGlvIGxheWVyIHRoZSBtb21lbnQgd2UKPiBzdGFydCBjb3B5aW5nL3RyYW5zbGF0aW5n
IGJ1ZmZlcnMuCj4KPiBJbiB0aGlzIHNlcmllcywgdGhlIHZpcnRpbyBkZXBlbmRlbmN5IGNhbiBi
ZSByZWR1Y2VkIGlmIHFlbXUgZG9lcyBub3QKPiBjaGVjayB0aGUgdXNlZCByaW5nIF9GX05PX05P
VElGWSBmbGFnIGJlZm9yZSB3cml0aW5nIHRvIGlycWZkLiBJdAo+IHdvdWxkIGVuYWJsZSBwYWNr
ZWQgcXVldWVzIGFuZCBJT01NVSBpbW1lZGlhdGVseSwgYW5kIEkgdGhpbmsgdGhlIGNvc3QKPiBz
aG91bGQgbm90IGJlIHNvIGhpZ2guIEluIHRoZSBwcmV2aW91cyBSRkMgdGhpcyBjaGVjayB3YXMg
ZGVsZXRlZAo+IGxhdGVyIGFueXdheSwgc28gSSB0aGluayBpdCB3YXMgYSBiYWQgaWRlYSB0byBp
bmNsdWRlIGl0IGZyb20gdGhlIHN0YXJ0LgoKCkkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhl
cmUuIEZvciB2aG9zdCwgd2UgY2FuIHN0aWxsIGRvIGFueXRoaW5nIHdlIAp3YW50LCBlLmcgYWNj
ZXNzaW5nIGd1ZXN0IG1lbW9yeSBldGMuIEFueSBibG9ja2VyIHRoYXQgcHJldmVudCB1cyBmcm9t
IApjb3B5aW5nL3RyYW5zbGF0aW5nIGJ1ZmZlcnM/IChOb3RlIHRoYXQgcWVtdSB3aWxsIHByb3Bh
Z2F0ZSBtZW1vcnkgCm1hcHBpbmdzIHRvIHZob3N0KS4KClRoYW5rcwoKCj4KPgo+Cj4KPgo+PiBU
aGFua3MKPj4KPj4KPj4+IEkgbmVlZCB0byB0YWtlIHRoaXMgaW50byBhY2NvdW50IGluIHFtcF94
X3Zob3N0X2VuYWJsZV9zaGFkb3dfdnEgdG9vLgo+Pj4KPj4+Pj4gKwo+Pj4+PiAgICAgc3RhdGlj
IHZvaWQgdmhvc3RfZGV2X3N5bmNfcmVnaW9uKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1vcnlSZWdpb25TZWN0aW9u
ICpzZWN0aW9uLAo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NF90IG1maXJzdCwgdWludDY0X3QgbWxhc3QsCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
