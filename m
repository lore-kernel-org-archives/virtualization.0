Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB2C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 05:55:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2418764DF6
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 05:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2418764DF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6DFF6F5B2
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 05:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EiIQZlkZDpUk for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 05:55:14 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id BDD556F5D0; Wed, 10 Feb 2021 05:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54A146F558;
	Wed, 10 Feb 2021 05:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17692C0891;
	Wed, 10 Feb 2021 05:55:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29D3CC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 05:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1BAF285308
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 05:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EX1QmAlEI5DY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 05:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 814B385135
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 05:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612936505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Je5p7aN/jqBrz0XrAj1lI4ldSNVdB/VBKt3tWiHiYvw=;
 b=ZxcohGrNIqmm8mwHo+v/gfgSVVYPrJrGDRyB8loprRtx51RQ+ft4mZSZTKqKcPwGljVFts
 yidkeuz5y8wqmGwxEAfbjaN4/boXNKI6HJhgXVPxIIeqcxrbYizFYS3xNUWtnXAaGlODfM
 J5/jVgB0MCvjY1gemugOsghpkZXl0Ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-o-gX3yZhOjyEE_crabprfQ-1; Wed, 10 Feb 2021 00:55:03 -0500
X-MC-Unique: o-gX3yZhOjyEE_crabprfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03AAF10066EF;
 Wed, 10 Feb 2021 05:55:02 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 186F457;
 Wed, 10 Feb 2021 05:54:50 +0000 (UTC)
Subject: Re: [RFC 05/10] vhost: Add vhost_dev_from_virtio
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210129205415.876290-1-eperezma@redhat.com>
 <20210129205415.876290-6-eperezma@redhat.com>
 <acf16fd6-2282-c220-e642-0868ac839b70@redhat.com>
 <CAJaqyWeRK_i3MMZVgXJUwUNfLaq_h80jChZfQ3sRmWAcQnGLkQ@mail.gmail.com>
 <a526b3ac-91d9-28e6-5ffc-2308aab4fbd6@redhat.com>
 <CAJaqyWf-qsr5eLzk4Sum=GYhHoW_+V-9arfbssSjd6G6WnretQ@mail.gmail.com>
 <a37502d6-b83f-fd34-7634-1060f4661540@redhat.com>
 <CAJaqyWcvWyMxRuH4U2aMRrcZJHSkajO94JcH1WBfYvFrthESLw@mail.gmail.com>
 <569ace3d-f2c3-8b9f-63f5-809ce7067046@redhat.com>
 <CAJaqyWcBdkOd1WFWqWVtHtgm11ti7DKKa0BS1oN5k6acX6T9rw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ddc8982-b422-beec-8812-60706105fb72@redhat.com>
Date: Wed, 10 Feb 2021 13:54:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcBdkOd1WFWqWVtHtgm11ti7DKKa0BS1oN5k6acX6T9rw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Harpreet Singh Anand <hanand@xilinx.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Michael Lilja <ml@napatech.com>, Jim Harford <jim.harford@broadcom.com>,
 Rob Miller <rob.miller@broadcom.com>
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

Ck9uIDIwMjEvMi85IOS4i+WNiDExOjM1LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPiBP
biBGcmksIEZlYiA1LCAyMDIxIGF0IDQ6NTIgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMi80IOS4i+WNiDU6MjUsIEV1Z2VuaW8gUGVyZXog
TWFydGluIHdyb3RlOgo+Pj4gT24gVGh1LCBGZWIgNCwgMjAyMSBhdCA0OjE0IEFNIEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIDIwMjEvMi8yIOS4i+WNiDY6
MTcsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+Pj4+PiBPbiBUdWUsIEZlYiAyLCAyMDIx
IGF0IDQ6MzEgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+
PiBPbiAyMDIxLzIvMSDkuIvljYg0OjI4LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToKPj4+
Pj4+PiBPbiBNb24sIEZlYiAxLCAyMDIxIGF0IDc6MTMgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+IE9uIDIwMjEvMS8zMCDkuIrljYg0OjU0LCBFdWdl
bmlvIFDDqXJleiB3cm90ZToKPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6
IDxlcGVyZXptYUByZWRoYXQuY29tPgo+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+PiAgICAgICBpbmNs
dWRlL2h3L3ZpcnRpby92aG9zdC5oIHwgIDEgKwo+Pj4+Pj4+Pj4gICAgICAgaHcvdmlydGlvL3Zo
b3N0LmMgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4+Pj4+Pj4+PiAgICAgICAyIGZp
bGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaCBiL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0
LmgKPj4+Pj4+Pj4+IGluZGV4IDRhOGJjNzU0MTUuLmZjYTA3NmUzZjAgMTAwNjQ0Cj4+Pj4+Pj4+
PiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oCj4+Pj4+Pj4+PiArKysgYi9pbmNsdWRl
L2h3L3ZpcnRpby92aG9zdC5oCj4+Pj4+Pj4+PiBAQCAtMTIzLDYgKzEyMyw3IEBAIHVpbnQ2NF90
IHZob3N0X2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpoZGV2LCBjb25zdCBpbnQgKmZl
YXR1cmVfYml0cywKPj4+Pj4+Pj4+ICAgICAgIHZvaWQgdmhvc3RfYWNrX2ZlYXR1cmVzKHN0cnVj
dCB2aG9zdF9kZXYgKmhkZXYsIGNvbnN0IGludCAqZmVhdHVyZV9iaXRzLAo+Pj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZmVhdHVyZXMpOwo+Pj4+Pj4+Pj4g
ICAgICAgYm9vbCB2aG9zdF9oYXNfZnJlZV9zbG90KHZvaWQpOwo+Pj4+Pj4+Pj4gK3N0cnVjdCB2
aG9zdF9kZXYgKnZob3N0X2Rldl9mcm9tX3ZpcnRpbyhjb25zdCBWaXJ0SU9EZXZpY2UgKnZkZXYp
Owo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgIGludCB2aG9zdF9uZXRfc2V0X2JhY2tlbmQoc3Ry
dWN0IHZob3N0X2RldiAqaGRldiwKPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX2ZpbGUgKmZpbGUpOwo+Pj4+Pj4+Pj4gZGlmZiAtLWdp
dCBhL2h3L3ZpcnRpby92aG9zdC5jIGIvaHcvdmlydGlvL3Zob3N0LmMKPj4+Pj4+Pj4+IGluZGV4
IDI4YzdkNzgxNzIuLjg2ODNkNTA3ZjUgMTAwNjQ0Cj4+Pj4+Pj4+PiAtLS0gYS9ody92aXJ0aW8v
dmhvc3QuYwo+Pj4+Pj4+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LmMKPj4+Pj4+Pj4+IEBAIC02
MSw2ICs2MSwyMyBAQCBib29sIHZob3N0X2hhc19mcmVlX3Nsb3Qodm9pZCkKPj4+Pj4+Pj4+ICAg
ICAgICAgICByZXR1cm4gc2xvdHNfbGltaXQgPiB1c2VkX21lbXNsb3RzOwo+Pj4+Pj4+Pj4gICAg
ICAgfQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICsvKgo+Pj4+Pj4+Pj4gKyAqIEdldCB0aGUgdmhvc3Qg
ZGV2aWNlIGFzc29jaWF0ZWQgdG8gYSBWaXJ0SU8gZGV2aWNlLgo+Pj4+Pj4+Pj4gKyAqLwo+Pj4+
Pj4+Pj4gK3N0cnVjdCB2aG9zdF9kZXYgKnZob3N0X2Rldl9mcm9tX3ZpcnRpbyhjb25zdCBWaXJ0
SU9EZXZpY2UgKnZkZXYpCj4+Pj4+Pj4+PiArewo+Pj4+Pj4+Pj4gKyAgICBzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpoZGV2Owo+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4gKyAgICBRTElTVF9GT1JFQUNIKGhkZXYs
ICZ2aG9zdF9kZXZpY2VzLCBlbnRyeSkgewo+Pj4+Pj4+Pj4gKyAgICAgICAgaWYgKGhkZXYtPnZk
ZXYgPT0gdmRldikgewo+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIHJldHVybiBoZGV2Owo+Pj4+Pj4+
Pj4gKyAgICAgICAgfQo+Pj4+Pj4+Pj4gKyAgICB9Cj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+PiArICAg
IGFzc2VydChoZGV2KTsKPj4+Pj4+Pj4+ICsgICAgcmV0dXJuIE5VTEw7Cj4+Pj4+Pj4+PiArfQo+
Pj4+Pj4+PiBJJ20gbm90IHN1cmUgdGhpcyBjYW4gd29yayBpbiB0aGUgY2FzZSBvZiBtdWx0aXF1
ZXVlLiBFLmcgdmhvc3QtbmV0Cj4+Pj4+Pj4+IG11bHRpcXVldWUgaXMgYSBOOjEgbWFwcGluZyBi
ZXR3ZWVuIHZob3N0IGRldmljcyBhbmQgdmlydGlvIGRldmljZXMuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IFRoYW5rcwo+Pj4+Pj4+Pgo+Pj4+Pj4+IFJpZ2h0LiBXZSBjb3VsZCBhZGQgYW4gInZkZXYgdnEg
aW5kZXgiIHBhcmFtZXRlciB0byB0aGUgZnVuY3Rpb24gaW4KPj4+Pj4+PiB0aGlzIGNhc2UsIGJ1
dCBJIGd1ZXNzIHRoZSBtb3N0IHJlbGlhYmxlIHdheSB0byBkbyB0aGlzIGlzIHRvIGFkZCBhCj4+
Pj4+Pj4gdmhvc3Rfb3BhcXVlIHZhbHVlIHRvIFZpcnRRdWV1ZSwgYXMgU3RlZmFuIHByb3Bvc2Vk
IGluIHByZXZpb3VzIFJGQy4KPj4+Pj4+IFNvIHRoZSBxdWVzdGlvbiBzdGlsbCwgaXQgbG9va3Mg
bGlrZSBpdCdzIGVhc2llciB0byBoaWRlIHRoZSBzaGFkb3cKPj4+Pj4+IHZpcnRxdWV1ZSBzdHVm
ZnMgYXQgdmhvc3QgbGF5ZXIgaW5zdGVhZCBvZiBleHBvc2UgdGhlbSB0byB2aXJ0aW8gbGF5ZXI6
Cj4+Pj4+Pgo+Pj4+Pj4gMSkgdmhvc3QgcHJvdG9jb2wgaXMgc3RhYmxlIEFCSQo+Pj4+Pj4gMikg
bm8gbmVlZCB0byBkZWFsIHdpdGggdmlydGlvIHN0dWZmcyB3aGljaCBpcyBtb3JlIGNvbXBsZXgg
dGhhbiB2aG9zdAo+Pj4+Pj4KPj4+Pj4+IE9yIGFyZSB0aGVyZSBhbnkgYWR2YW50YWdlcyBpZiB3
ZSBkbyBpdCBhdCB2aXJ0aW8gbGF5ZXI/Cj4+Pj4+Pgo+Pj4+PiBBcyBmYXIgYXMgSSBjYW4gdGVs
bCwgd2Ugd2lsbCBuZWVkIHRoZSB2aXJ0aW8gbGF5ZXIgdGhlIG1vbWVudCB3ZQo+Pj4+PiBzdGFy
dCBjb3B5aW5nL3RyYW5zbGF0aW5nIGJ1ZmZlcnMuCj4+Pj4+Cj4+Pj4+IEluIHRoaXMgc2VyaWVz
LCB0aGUgdmlydGlvIGRlcGVuZGVuY3kgY2FuIGJlIHJlZHVjZWQgaWYgcWVtdSBkb2VzIG5vdAo+
Pj4+PiBjaGVjayB0aGUgdXNlZCByaW5nIF9GX05PX05PVElGWSBmbGFnIGJlZm9yZSB3cml0aW5n
IHRvIGlycWZkLiBJdAo+Pj4+PiB3b3VsZCBlbmFibGUgcGFja2VkIHF1ZXVlcyBhbmQgSU9NTVUg
aW1tZWRpYXRlbHksIGFuZCBJIHRoaW5rIHRoZSBjb3N0Cj4+Pj4+IHNob3VsZCBub3QgYmUgc28g
aGlnaC4gSW4gdGhlIHByZXZpb3VzIFJGQyB0aGlzIGNoZWNrIHdhcyBkZWxldGVkCj4+Pj4+IGxh
dGVyIGFueXdheSwgc28gSSB0aGluayBpdCB3YXMgYSBiYWQgaWRlYSB0byBpbmNsdWRlIGl0IGZy
b20gdGhlIHN0YXJ0Lgo+Pj4+IEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhlcmUuIEZvciB2
aG9zdCwgd2UgY2FuIHN0aWxsIGRvIGFueXRoaW5nIHdlCj4+Pj4gd2FudCwgZS5nIGFjY2Vzc2lu
ZyBndWVzdCBtZW1vcnkgZXRjLiBBbnkgYmxvY2tlciB0aGF0IHByZXZlbnQgdXMgZnJvbQo+Pj4+
IGNvcHlpbmcvdHJhbnNsYXRpbmcgYnVmZmVycz8gKE5vdGUgdGhhdCBxZW11IHdpbGwgcHJvcGFn
YXRlIG1lbW9yeQo+Pj4+IG1hcHBpbmdzIHRvIHZob3N0KS4KPj4+Pgo+Pj4gVGhlcmUgaXMgbm90
aGluZyB0aGF0IGZvcmJpZHMgdXMgdG8gYWNjZXNzIGRpcmVjdGx5LCBidXQgaWYgd2UgZG9uJ3QK
Pj4+IHJldXNlIHRoZSB2aXJ0aW8gbGF5ZXIgZnVuY3Rpb25hbGl0eSB3ZSB3b3VsZCBoYXZlIHRv
IGR1cGxpY2F0ZSBldmVyeQo+Pj4gYWNjZXNzIGZ1bmN0aW9uLiAiTmVlZCIgd2FzIGEgdG9vIHN0
cm9uZyB3b3JkIG1heWJlIDopLgo+Pj4KPj4+IEluIG90aGVyIHdvcmRzOiBmb3IgdGhlIHNoYWRv
dyB2cSB2cmluZyBleHBvc2VkIGZvciB0aGUgZGV2aWNlLCBxZW11Cj4+PiB0cmVhdHMgaXQgYXMg
YSBkcml2ZXIsIGFuZCB0aGlzIGZ1bmN0aW9uYWxpdHkgbmVlZHMgdG8gYmUgYWRkZWQgdG8KPj4+
IHFlbXUuIEJ1dCBmb3IgYWNjZXNzaW5nIHRoZSBndWVzdCdzIG9uZSBkbyBub3QgcmV1c2Ugdmly
dGlvLmMgd291bGQgYmUKPj4+IGEgYmFkIGlkZWEgaW4gbXkgb3Bpbmlvbi4KPj4KPj4gVGhlIHBy
b2JsZW0gaXMsIHZpcnRpby5jIGlzIG5vdCBhIGxpYnJhcnkgYW5kIGl0IGhhcyBhIGxvdCBvZiBk
ZXBlbmRlbmN5Cj4+IHdpdGggb3RoZXIgcWVtdSBtb2R1bGVzIGJhc2ljYWxseSBtYWtlcyBpdCBp
bXBvc3NpYmxlIHRvIGJlIHJldXNlZCBhdAo+PiB2aG9zdCBsZXZlbC4KPj4KPiBXaGlsZSB2aXJ0
aW8uYyBhcyBhIHdob2xlIGhhcyBkZXBlbmRlbmNpZXMsIEkgdGhpbmsgdGhhdCB0aGUgZnVuY3Rp
b25zCj4gbmVlZGVkIGluIHRoZSBvcmlnaW5hbCBSRkMgZG8gbm90IGhhdmUgdGhlc2UgZGVwZW5k
ZW5jaWVzLgo+Cj4gSG93ZXZlciBJIHNlZSBob3cgdG8gc3BsaXQgdnJpbmcgZGF0YXBsYW5lIGZy
b20gdmlydGlvIGRldmljZQo+IG1hbmFnZW1lbnQgY2FuIGJlbmVmaXQuCgoKSWYgeW91IGNhbiBz
cGxpdCB0aGVtIG91dCwgdGhhdCB3b3VsZCBiZSBmaW5lLgoKCj4KPj4gV2UgY2FuIHNvbHZlIHRo
aXMgYnk6Cj4+Cj4+IDEpIHNwbGl0IHRoZSBjb3JlIGZ1bmN0aW9ucyBvdXQgYXMgYSBsaWJyYXJ5
IG9yCj4+IDIpIHN3aXRjaCB0byB1c2UgY29udHJpYi9saWItdmhvc3R1c2VyIGJ1dCBuZWVkcyB0
byBkZWNvdXBsZSBVTklYIHNvY2tldAo+PiB0cmFuc3BvcnQKPj4KPj4gTm9uZSBvZiB0aGUgYWJv
dmUgbG9va3MgdHJpdmlhbCBhbmQgdGhleSBhcmUgb25seSBkZXZpY2UgY29kZXMuIEZvcgo+PiBz
aGFkb3cgdmlydHF1ZXVlLCB3ZSBuZWVkIGRyaXZlciBjb2RlcyBhcyB3ZWxsIHdoZXJlIG5vIGNv
ZGUgY2FuIGJlIHJldXNlZC4KPj4KPj4gQXMgd2UgZGlzY3Vzc2VkLCB3ZSBwcm9iYWJseSBuZWVk
IElPVkEgYWxsb2NhdGVkIHdoZW4gZm9yd2FyZGluZwo+PiBkZXNjcmlwdG9ycyBiZXR3ZWVuIHRo
ZSB0d28gdmlydHF1ZXVlcy4gU28gbXkgZmVlbGluZyBpcyB3ZSBjYW4gaGF2ZSBvdXIKPj4gb3du
IGNvZGVzIHRvIHN0YXJ0IHRoZW4gd2UgY2FuIGNvbnNpZGVyIHdoZXRoZXIgd2UgY2FuIHJldXNl
IHNvbWUgZnJvbQo+PiB0aGUgZXhpc3RpbmcgdmlydGlvLmMgb3IgbGliLXZob3N0dXNlci4KPj4K
PiBBcyBJIHNlZSBpdCwgaWYgd2UgZGV2ZWxvcCBvdXIgb3duIGNvZGUgYSBsb3Qgb2YgaXQgd2ls
bCBiZSBjb3BpZWQKPiBmcm9tIGN1cnJlbnQgdmlydGlvLmMsIHdoaWNoIGl0c2VsZiBkdXBsaWNh
dGVzIGEgbG90IG9mIGNvbnRyaWIvIGxpYgo+IGZ1bmN0aW9uYWxpdHkuCj4KPiBNYXliZSBpdCdz
IGJldHRlciB0byBjb21iaW5lIHlvdXIgcHJvcG9zYWxzIGFuZCBkZWNvdXBsZSB0aGUgdnJpbmcK
PiBmdW5jdGlvbnMsIHRoZSB2aG9zdCB0cmFuc3BvcnQsIGFuZCB0aGUgcWVtdSB2aXJ0aW8gZGV2
aWNlIG1hbmFnZW1lbnQsCj4gc28gb3RoZXIgcHJvamVjdHMgY2FuIHJldXNlIHRoZW0gZGlyZWN0
bHk/CgoKSSB0aGluayB0aGlzIGNhbiB3b3JrLgoKCj4KPiBJIHN0aWxsIHRoaW5rIHRoaXMgY2Fu
IGJlIGxlZnQgZm9yIGEgbGF0ZXIgc2VyaWVzIHdpdGggYnVmZmVyCj4gZm9yd2FyZGluZyBvbiB0
b3Agb2YgdGhpcyBvbmUsIGRvIHlvdSB0aGluayB0aGV5IGNhbi9zaG91bGQgYmUgbWVyZ2VkCj4g
aW5kZXBlbmRlbnRseT8KCgpTaW5jZSB5b3UgcG9zdCBhIG5ldyBzZXJpZXMsIGxldCdzIHNlZS4K
ClRoYW5rcwoKCj4KPiBUaGFua3MhCj4KPj4gVGhhbmtzCj4+Cj4+Cj4+Pj4gVGhhbmtzCj4+Pj4K
Pj4+Pgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+
PiBJIG5lZWQgdG8gdGFrZSB0aGlzIGludG8gYWNjb3VudCBpbiBxbXBfeF92aG9zdF9lbmFibGVf
c2hhZG93X3ZxIHRvby4KPj4+Pj4+Pgo+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4gICAgICAgc3RhdGlj
IHZvaWQgdmhvc3RfZGV2X3N5bmNfcmVnaW9uKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1vcnlSZWdpb25T
ZWN0aW9uICpzZWN0aW9uLAo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQ2NF90IG1maXJzdCwgdWludDY0X3QgbWxhc3QsCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
