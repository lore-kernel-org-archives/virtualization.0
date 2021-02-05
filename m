Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE6C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC23D64FA3
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC23D64FA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 32A61203F7;
	Fri,  5 Feb 2021 03:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mJvDkLSDs+ih; Fri,  5 Feb 2021 03:52:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2CCF8203AC;
	Fri,  5 Feb 2021 03:52:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D214C07FD;
	Fri,  5 Feb 2021 03:52:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D633C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 233F0872CC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mB3NQIWqmRD1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:52:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2EE7B872C9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612497140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8P6pdfLS5GEKfdGqSXpH34pu174A+WIrkQ5mPvKYUds=;
 b=C+SlSpr19Ti+7favdeLKS36kN9cA74zZNR59HPrFVkvuiwAspjmqkWzhinC1GN+XMeW5Rr
 awgKj+qU+PWNFEI99Xe34p2iZSxX0FCmrUqEF+lJf11yYKK9Tx2rbHhAbfaOVrK49UHCh+
 2mlKjXLeHKWy/Q+adBZXmTOBSlf5YQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-UeSIlErjPZycKm2BSpJ8VA-1; Thu, 04 Feb 2021 22:52:19 -0500
X-MC-Unique: UeSIlErjPZycKm2BSpJ8VA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77BD510066EE;
 Fri,  5 Feb 2021 03:52:17 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95DDE5D9D2;
 Fri,  5 Feb 2021 03:51:49 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <569ace3d-f2c3-8b9f-63f5-809ce7067046@redhat.com>
Date: Fri, 5 Feb 2021 11:51:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcvWyMxRuH4U2aMRrcZJHSkajO94JcH1WBfYvFrthESLw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMi80IOS4i+WNiDU6MjUsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+IE9u
IFRodSwgRmViIDQsIDIwMjEgYXQgNDoxNCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzIg5LiL5Y2INjoxNywgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4+PiBPbiBUdWUsIEZlYiAyLCAyMDIxIGF0IDQ6MzEgQU0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8yLzEg5LiL5Y2INDoy
OCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgRmViIDEsIDIwMjEg
YXQgNzoxMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+
IE9uIDIwMjEvMS8zMCDkuIrljYg0OjU0LCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+Pj4+
PiAtLS0KPj4+Pj4+PiAgICAgIGluY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggfCAgMSArCj4+Pj4+
Pj4gICAgICBody92aXJ0aW8vdmhvc3QuYyAgICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysK
Pj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+Pj4+Pj4+Cj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3Zob3N0LmggYi9pbmNsdWRlL2h3
L3ZpcnRpby92aG9zdC5oCj4+Pj4+Pj4gaW5kZXggNGE4YmM3NTQxNS4uZmNhMDc2ZTNmMCAxMDA2
NDQKPj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oCj4+Pj4+Pj4gKysrIGIv
aW5jbHVkZS9ody92aXJ0aW8vdmhvc3QuaAo+Pj4+Pj4+IEBAIC0xMjMsNiArMTIzLDcgQEAgdWlu
dDY0X3Qgdmhvc3RfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF9kZXYgKmhkZXYsIGNvbnN0IGlu
dCAqZmVhdHVyZV9iaXRzLAo+Pj4+Pj4+ICAgICAgdm9pZCB2aG9zdF9hY2tfZmVhdHVyZXMoc3Ry
dWN0IHZob3N0X2RldiAqaGRldiwgY29uc3QgaW50ICpmZWF0dXJlX2JpdHMsCj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBmZWF0dXJlcyk7Cj4+Pj4+Pj4gICAg
ICBib29sIHZob3N0X2hhc19mcmVlX3Nsb3Qodm9pZCk7Cj4+Pj4+Pj4gK3N0cnVjdCB2aG9zdF9k
ZXYgKnZob3N0X2Rldl9mcm9tX3ZpcnRpbyhjb25zdCBWaXJ0SU9EZXZpY2UgKnZkZXYpOwo+Pj4+
Pj4+Cj4+Pj4+Pj4gICAgICBpbnQgdmhvc3RfbmV0X3NldF9iYWNrZW5kKHN0cnVjdCB2aG9zdF9k
ZXYgKmhkZXYsCj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2
aG9zdF92cmluZ19maWxlICpmaWxlKTsKPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zo
b3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYwo+Pj4+Pj4+IGluZGV4IDI4YzdkNzgxNzIuLjg2ODNk
NTA3ZjUgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMKPj4+Pj4+PiArKysg
Yi9ody92aXJ0aW8vdmhvc3QuYwo+Pj4+Pj4+IEBAIC02MSw2ICs2MSwyMyBAQCBib29sIHZob3N0
X2hhc19mcmVlX3Nsb3Qodm9pZCkKPj4+Pj4+PiAgICAgICAgICByZXR1cm4gc2xvdHNfbGltaXQg
PiB1c2VkX21lbXNsb3RzOwo+Pj4+Pj4+ICAgICAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gKy8qCj4+Pj4+
Pj4gKyAqIEdldCB0aGUgdmhvc3QgZGV2aWNlIGFzc29jaWF0ZWQgdG8gYSBWaXJ0SU8gZGV2aWNl
Lgo+Pj4+Pj4+ICsgKi8KPj4+Pj4+PiArc3RydWN0IHZob3N0X2RldiAqdmhvc3RfZGV2X2Zyb21f
dmlydGlvKGNvbnN0IFZpcnRJT0RldmljZSAqdmRldikKPj4+Pj4+PiArewo+Pj4+Pj4+ICsgICAg
c3RydWN0IHZob3N0X2RldiAqaGRldjsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICBRTElTVF9GT1JF
QUNIKGhkZXYsICZ2aG9zdF9kZXZpY2VzLCBlbnRyeSkgewo+Pj4+Pj4+ICsgICAgICAgIGlmICho
ZGV2LT52ZGV2ID09IHZkZXYpIHsKPj4+Pj4+PiArICAgICAgICAgICAgcmV0dXJuIGhkZXY7Cj4+
Pj4+Pj4gKyAgICAgICAgfQo+Pj4+Pj4+ICsgICAgfQo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgIGFz
c2VydChoZGV2KTsKPj4+Pj4+PiArICAgIHJldHVybiBOVUxMOwo+Pj4+Pj4+ICt9Cj4+Pj4+PiBJ
J20gbm90IHN1cmUgdGhpcyBjYW4gd29yayBpbiB0aGUgY2FzZSBvZiBtdWx0aXF1ZXVlLiBFLmcg
dmhvc3QtbmV0Cj4+Pj4+PiBtdWx0aXF1ZXVlIGlzIGEgTjoxIG1hcHBpbmcgYmV0d2VlbiB2aG9z
dCBkZXZpY3MgYW5kIHZpcnRpbyBkZXZpY2VzLgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pj4K
Pj4+Pj4gUmlnaHQuIFdlIGNvdWxkIGFkZCBhbiAidmRldiB2cSBpbmRleCIgcGFyYW1ldGVyIHRv
IHRoZSBmdW5jdGlvbiBpbgo+Pj4+PiB0aGlzIGNhc2UsIGJ1dCBJIGd1ZXNzIHRoZSBtb3N0IHJl
bGlhYmxlIHdheSB0byBkbyB0aGlzIGlzIHRvIGFkZCBhCj4+Pj4+IHZob3N0X29wYXF1ZSB2YWx1
ZSB0byBWaXJ0UXVldWUsIGFzIFN0ZWZhbiBwcm9wb3NlZCBpbiBwcmV2aW91cyBSRkMuCj4+Pj4g
U28gdGhlIHF1ZXN0aW9uIHN0aWxsLCBpdCBsb29rcyBsaWtlIGl0J3MgZWFzaWVyIHRvIGhpZGUg
dGhlIHNoYWRvdwo+Pj4+IHZpcnRxdWV1ZSBzdHVmZnMgYXQgdmhvc3QgbGF5ZXIgaW5zdGVhZCBv
ZiBleHBvc2UgdGhlbSB0byB2aXJ0aW8gbGF5ZXI6Cj4+Pj4KPj4+PiAxKSB2aG9zdCBwcm90b2Nv
bCBpcyBzdGFibGUgQUJJCj4+Pj4gMikgbm8gbmVlZCB0byBkZWFsIHdpdGggdmlydGlvIHN0dWZm
cyB3aGljaCBpcyBtb3JlIGNvbXBsZXggdGhhbiB2aG9zdAo+Pj4+Cj4+Pj4gT3IgYXJlIHRoZXJl
IGFueSBhZHZhbnRhZ2VzIGlmIHdlIGRvIGl0IGF0IHZpcnRpbyBsYXllcj8KPj4+Pgo+Pj4gQXMg
ZmFyIGFzIEkgY2FuIHRlbGwsIHdlIHdpbGwgbmVlZCB0aGUgdmlydGlvIGxheWVyIHRoZSBtb21l
bnQgd2UKPj4+IHN0YXJ0IGNvcHlpbmcvdHJhbnNsYXRpbmcgYnVmZmVycy4KPj4+Cj4+PiBJbiB0
aGlzIHNlcmllcywgdGhlIHZpcnRpbyBkZXBlbmRlbmN5IGNhbiBiZSByZWR1Y2VkIGlmIHFlbXUg
ZG9lcyBub3QKPj4+IGNoZWNrIHRoZSB1c2VkIHJpbmcgX0ZfTk9fTk9USUZZIGZsYWcgYmVmb3Jl
IHdyaXRpbmcgdG8gaXJxZmQuIEl0Cj4+PiB3b3VsZCBlbmFibGUgcGFja2VkIHF1ZXVlcyBhbmQg
SU9NTVUgaW1tZWRpYXRlbHksIGFuZCBJIHRoaW5rIHRoZSBjb3N0Cj4+PiBzaG91bGQgbm90IGJl
IHNvIGhpZ2guIEluIHRoZSBwcmV2aW91cyBSRkMgdGhpcyBjaGVjayB3YXMgZGVsZXRlZAo+Pj4g
bGF0ZXIgYW55d2F5LCBzbyBJIHRoaW5rIGl0IHdhcyBhIGJhZCBpZGVhIHRvIGluY2x1ZGUgaXQg
ZnJvbSB0aGUgc3RhcnQuCj4+Cj4+IEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhlcmUuIEZv
ciB2aG9zdCwgd2UgY2FuIHN0aWxsIGRvIGFueXRoaW5nIHdlCj4+IHdhbnQsIGUuZyBhY2Nlc3Np
bmcgZ3Vlc3QgbWVtb3J5IGV0Yy4gQW55IGJsb2NrZXIgdGhhdCBwcmV2ZW50IHVzIGZyb20KPj4g
Y29weWluZy90cmFuc2xhdGluZyBidWZmZXJzPyAoTm90ZSB0aGF0IHFlbXUgd2lsbCBwcm9wYWdh
dGUgbWVtb3J5Cj4+IG1hcHBpbmdzIHRvIHZob3N0KS4KPj4KPiBUaGVyZSBpcyBub3RoaW5nIHRo
YXQgZm9yYmlkcyB1cyB0byBhY2Nlc3MgZGlyZWN0bHksIGJ1dCBpZiB3ZSBkb24ndAo+IHJldXNl
IHRoZSB2aXJ0aW8gbGF5ZXIgZnVuY3Rpb25hbGl0eSB3ZSB3b3VsZCBoYXZlIHRvIGR1cGxpY2F0
ZSBldmVyeQo+IGFjY2VzcyBmdW5jdGlvbi4gIk5lZWQiIHdhcyBhIHRvbyBzdHJvbmcgd29yZCBt
YXliZSA6KS4KPgo+IEluIG90aGVyIHdvcmRzOiBmb3IgdGhlIHNoYWRvdyB2cSB2cmluZyBleHBv
c2VkIGZvciB0aGUgZGV2aWNlLCBxZW11Cj4gdHJlYXRzIGl0IGFzIGEgZHJpdmVyLCBhbmQgdGhp
cyBmdW5jdGlvbmFsaXR5IG5lZWRzIHRvIGJlIGFkZGVkIHRvCj4gcWVtdS4gQnV0IGZvciBhY2Nl
c3NpbmcgdGhlIGd1ZXN0J3Mgb25lIGRvIG5vdCByZXVzZSB2aXJ0aW8uYyB3b3VsZCBiZQo+IGEg
YmFkIGlkZWEgaW4gbXkgb3Bpbmlvbi4KCgpUaGUgcHJvYmxlbSBpcywgdmlydGlvLmMgaXMgbm90
IGEgbGlicmFyeSBhbmQgaXQgaGFzIGEgbG90IG9mIGRlcGVuZGVuY3kgCndpdGggb3RoZXIgcWVt
dSBtb2R1bGVzIGJhc2ljYWxseSBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIGJlIHJldXNlZCBhdCAK
dmhvc3QgbGV2ZWwuCgpXZSBjYW4gc29sdmUgdGhpcyBieToKCjEpIHNwbGl0IHRoZSBjb3JlIGZ1
bmN0aW9ucyBvdXQgYXMgYSBsaWJyYXJ5IG9yCjIpIHN3aXRjaCB0byB1c2UgY29udHJpYi9saWIt
dmhvc3R1c2VyIGJ1dCBuZWVkcyB0byBkZWNvdXBsZSBVTklYIHNvY2tldCAKdHJhbnNwb3J0CgpO
b25lIG9mIHRoZSBhYm92ZSBsb29rcyB0cml2aWFsIGFuZCB0aGV5IGFyZSBvbmx5IGRldmljZSBj
b2Rlcy4gRm9yIApzaGFkb3cgdmlydHF1ZXVlLCB3ZSBuZWVkIGRyaXZlciBjb2RlcyBhcyB3ZWxs
IHdoZXJlIG5vIGNvZGUgY2FuIGJlIHJldXNlZC4KCkFzIHdlIGRpc2N1c3NlZCwgd2UgcHJvYmFi
bHkgbmVlZCBJT1ZBIGFsbG9jYXRlZCB3aGVuIGZvcndhcmRpbmcgCmRlc2NyaXB0b3JzIGJldHdl
ZW4gdGhlIHR3byB2aXJ0cXVldWVzLiBTbyBteSBmZWVsaW5nIGlzIHdlIGNhbiBoYXZlIG91ciAK
b3duIGNvZGVzIHRvIHN0YXJ0IHRoZW4gd2UgY2FuIGNvbnNpZGVyIHdoZXRoZXIgd2UgY2FuIHJl
dXNlIHNvbWUgZnJvbSAKdGhlIGV4aXN0aW5nIHZpcnRpby5jIG9yIGxpYi12aG9zdHVzZXIuCgpU
aGFua3MKCgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4KPj4+Cj4+Pgo+Pj4KPj4+PiBUaGFua3MKPj4+
Pgo+Pj4+Cj4+Pj4+IEkgbmVlZCB0byB0YWtlIHRoaXMgaW50byBhY2NvdW50IGluIHFtcF94X3Zo
b3N0X2VuYWJsZV9zaGFkb3dfdnEgdG9vLgo+Pj4+Pgo+Pj4+Pj4+ICsKPj4+Pj4+PiAgICAgIHN0
YXRpYyB2b2lkIHZob3N0X2Rldl9zeW5jX3JlZ2lvbihzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9u
U2VjdGlvbiAqc2VjdGlvbiwKPj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBtZmlyc3QsIHVpbnQ2NF90IG1sYXN0LAo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
