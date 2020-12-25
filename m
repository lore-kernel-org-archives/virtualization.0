Return-Path: <SRS0=2ixu=F5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A84C433DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:58:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A929A22AAA
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A929A22AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 37EE186599;
	Fri, 25 Dec 2020 06:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3MBh5ECqxmmP; Fri, 25 Dec 2020 06:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 660E786521;
	Fri, 25 Dec 2020 06:58:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEE2C1825;
	Fri, 25 Dec 2020 06:58:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 175A2C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A4F486591
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T4qBTtK5G2wK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:58:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3813586521
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608879500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBTp23RhCF2lNaGdXuKBZ6xR632uHIkymwYyPE70oOU=;
 b=IA4Ua3naXxbrY0tsVTYFCP6FFneeXf/h3cXU+blBsXYa92FYnx7uJ2ofzOdR3hETDDQ6jp
 EqXjFjyk3XKiUN2zTTiaeemYftRywUiuyrG6YGuMyI3krSHetVdauJq09HrWFe+sfi8Cs8
 cuy3W5pcYNoO78T15bAPtInaX7kPkxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-jwRdfOAsMsGt45YAWXmUug-1; Fri, 25 Dec 2020 01:58:16 -0500
X-MC-Unique: jwRdfOAsMsGt45YAWXmUug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E8DC10054FF;
 Fri, 25 Dec 2020 06:58:13 +0000 (UTC)
Received: from [10.72.12.97] (ovpn-12-97.pek2.redhat.com [10.72.12.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3962B62462;
 Fri, 25 Dec 2020 06:58:00 +0000 (UTC)
Subject: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb
 message
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-10-xieyongji@bytedance.com>
 <6818a214-d587-4f0b-7de6-13c4e7e94ab6@redhat.com>
 <CACycT3vVU9vg6R6UujSnSdk8cwxWPVgeJJs0JaBH_Zg4xC-epQ@mail.gmail.com>
 <595fe7d6-7876-26e4-0b7c-1d63ca6d7a97@redhat.com>
 <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0e6faf9c-117a-e23c-8d6d-488d0ec37412@redhat.com>
Date: Fri, 25 Dec 2020 14:57:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjQg5LiL5Y2IMzozNywgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUaHUsIERl
YyAyNCwgMjAyMCBhdCAxMDo0MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4gT24gMjAyMC8xMi8yMyDkuIvljYg4OjE0LCBZb25namkgWGllIHdyb3RlOgo+
Pj4gT24gV2VkLCBEZWMgMjMsIDIwMjAgYXQgNTowNSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIwLzEyLzIyIOS4i+WNiDEwOjUyLCBYaWUgWW9u
Z2ppIHdyb3RlOgo+Pj4+PiBUbyBzdXBwb3J0IHZob3N0LXZkcGEgYnVzIGRyaXZlciwgd2UgbmVl
ZCBhIHdheSB0byBzaGFyZSB0aGUKPj4+Pj4gdmhvc3QtdmRwYSBiYWNrZW5kIHByb2Nlc3MncyBt
ZW1vcnkgd2l0aCB0aGUgdXNlcnNwYWNlIFZEVVNFIHByb2Nlc3MuCj4+Pj4+Cj4+Pj4+IFRoaXMg
cGF0Y2ggdHJpZXMgdG8gbWFrZSB1c2Ugb2YgdGhlIHZob3N0IGlvdGxiIG1lc3NhZ2UgdG8gYWNo
aWV2ZQo+Pj4+PiB0aGF0LiBXZSB3aWxsIGdldCB0aGUgc2htIGZpbGUgZnJvbSB0aGUgaW90bGIg
bWVzc2FnZSBhbmQgcGFzcyBpdAo+Pj4+PiB0byB0aGUgdXNlcnNwYWNlIFZEVVNFIHByb2Nlc3Mu
Cj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFu
Y2UuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gICAgIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZHVz
ZS5yc3QgfCAgMTUgKysrLQo+Pj4+PiAgICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9k
ZXYuYyB8IDE0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+Pj4+ICAg
ICBpbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaCAgICAgICAgIHwgIDExICsrKwo+Pj4+PiAgICAg
MyBmaWxlcyBjaGFuZ2VkLCAxNzEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4K
Pj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZHVzZS5yc3QgYi9E
b2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmR1c2UucnN0Cj4+Pj4+IGluZGV4IDYyM2Y3YjA0MGNj
Zi4uNDhlNGIxYmEzNTNmIDEwMDY0NAo+Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1h
cGkvdmR1c2UucnN0Cj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZHVzZS5y
c3QKPj4+Pj4gQEAgLTQ2LDEzICs0NiwyNiBAQCBUaGUgZm9sbG93aW5nIHR5cGVzIG9mIG1lc3Nh
Z2VzIGFyZSBwcm92aWRlZCBieSB0aGUgVkRVU0UgZnJhbWV3b3JrIG5vdzoKPj4+Pj4KPj4+Pj4g
ICAgIC0gVkRVU0VfR0VUX0NPTkZJRzogUmVhZCBmcm9tIGRldmljZSBzcGVjaWZpYyBjb25maWd1
cmF0aW9uIHNwYWNlCj4+Pj4+Cj4+Pj4+ICstIFZEVVNFX1VQREFURV9JT1RMQjogVXBkYXRlIHRo
ZSBtZW1vcnkgbWFwcGluZyBpbiBkZXZpY2UgSU9UTEIKPj4+Pj4gKwo+Pj4+PiArLSBWRFVTRV9J
TlZBTElEQVRFX0lPVExCOiBJbnZhbGlkYXRlIHRoZSBtZW1vcnkgbWFwcGluZyBpbiBkZXZpY2Ug
SU9UTEIKPj4+Pj4gKwo+Pj4+PiAgICAgUGxlYXNlIHNlZSBpbmNsdWRlL2xpbnV4L3ZkcGEuaCBm
b3IgZGV0YWlscy4KPj4+Pj4KPj4+Pj4gLUluIHRoZSBkYXRhIHBhdGgsIFZEVVNFIGZyYW1ld29y
ayBpbXBsZW1lbnRzIGEgTU1VLWJhc2VkIG9uLWNoaXAgSU9NTVUKPj4+Pj4gK1RoZSBkYXRhIHBh
dGggb2YgdXNlcnNwYWNlIHZEUEEgZGV2aWNlIGlzIGltcGxlbWVudGVkIGluIGRpZmZlcmVudCB3
YXlzCj4+Pj4+ICtkZXBlbmRpbmcgb24gdGhlIHZkcGEgYnVzIHRvIHdoaWNoIGl0IGlzIGF0dGFj
aGVkLgo+Pj4+PiArCj4+Pj4+ICtJbiB2aXJ0aW8tdmRwYSBjYXNlLCBWRFVTRSBmcmFtZXdvcmsg
aW1wbGVtZW50cyBhIE1NVS1iYXNlZCBvbi1jaGlwIElPTU1VCj4+Pj4+ICAgICBkcml2ZXIgd2hp
Y2ggc3VwcG9ydHMgbWFwcGluZyB0aGUga2VybmVsIGRtYSBidWZmZXIgdG8gYSB1c2Vyc3BhY2Ug
aW92YQo+Pj4+PiAgICAgcmVnaW9uIGR5bmFtaWNhbGx5LiBUaGUgdXNlcnNwYWNlIGlvdmEgcmVn
aW9uIGNhbiBiZSBjcmVhdGVkIGJ5IHBhc3NpbmcKPj4+Pj4gICAgIHRoZSB1c2Vyc3BhY2UgdkRQ
QSBkZXZpY2UgZmQgdG8gbW1hcCgyKS4KPj4+Pj4KPj4+Pj4gK0luIHZob3N0LXZkcGEgY2FzZSwg
dGhlIGRtYSBidWZmZXIgaXMgcmVzaWRlIGluIGEgdXNlcnNwYWNlIG1lbW9yeSByZWdpb24KPj4+
Pj4gK3doaWNoIHdpbGwgYmUgc2hhcmVkIHRvIHRoZSBWRFVTRSB1c2Vyc3BhY2UgcHJvY2Vzc3Mg
dmlhIHRoZSBmaWxlCj4+Pj4+ICtkZXNjcmlwdG9yIGluIFZEVVNFX1VQREFURV9JT1RMQiBtZXNz
YWdlLiBBbmQgdGhlIGNvcnJlc3BvbmRpbmcgYWRkcmVzcwo+Pj4+PiArbWFwcGluZyAoSU9WQSBv
ZiBkbWEgYnVmZmVyIDwtPiBWQSBvZiB0aGUgbWVtb3J5IHJlZ2lvbikgaXMgYWxzbyBpbmNsdWRl
ZAo+Pj4+PiAraW4gdGhpcyBtZXNzYWdlLgo+Pj4+PiArCj4+Pj4+ICAgICBCZXNpZGVzLCB0aGUg
ZXZlbnRmZCBtZWNoYW5pc20gaXMgdXNlZCB0byB0cmlnZ2VyIGludGVycnVwdCBjYWxsYmFja3Mg
YW5kCj4+Pj4+ICAgICByZWNlaXZlIHZpcnRxdWV1ZSBraWNrcyBpbiB1c2Vyc3BhY2UuIFRoZSBm
b2xsb3dpbmcgaW9jdGxzIG9uIHRoZSB1c2Vyc3BhY2UKPj4+Pj4gICAgIHZEUEEgZGV2aWNlIGZk
IGFyZSBwcm92aWRlZCB0byBzdXBwb3J0IHRoYXQ6Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVz
ZV9kZXYuYwo+Pj4+PiBpbmRleCBiOTc0MzMzZWQ0ZTkuLmQyNGFhYWNiNjAwOCAxMDA2NDQKPj4+
Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+Pj4+PiArKysgYi9k
cml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+Pj4+IEBAIC0zNCw2ICszNCw3IEBA
Cj4+Pj4+Cj4+Pj4+ICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyB7Cj4+Pj4+ICAgICAgICAgc3Ry
dWN0IHZkdXNlX2Rldl9yZXF1ZXN0IHJlcTsKPj4+Pj4gKyAgICAgc3RydWN0IGZpbGUgKmlvdGxi
X2ZpbGU7Cj4+Pj4+ICAgICAgICAgc3RydWN0IHZkdXNlX2Rldl9yZXNwb25zZSByZXNwOwo+Pj4+
PiAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgbGlzdDsKPj4+Pj4gICAgICAgICB3YWl0X3F1ZXVl
X2hlYWRfdCB3YWl0cTsKPj4+Pj4gQEAgLTMyNSwxMiArMzI2LDgwIEBAIHN0YXRpYyBpbnQgdmR1
c2VfZGV2X3NldF92cV9zdGF0ZShzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4+Pj4+ICAgICAgICAg
cmV0dXJuIHJldDsKPj4+Pj4gICAgIH0KPj4+Pj4KPj4+Pj4gK3N0YXRpYyBpbnQgdmR1c2VfZGV2
X3VwZGF0ZV9pb3RsYihzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYsIHN0cnVjdCBmaWxlICpmaWxlLAo+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgb2Zmc2V0LCB1NjQgaW92YSwg
dTY0IHNpemUsIHU4IHBlcm0pCj4+Pj4+ICt7Cj4+Pj4+ICsgICAgIHN0cnVjdCB2ZHVzZV9kZXZf
bXNnICptc2c7Cj4+Pj4+ICsgICAgIGludCByZXQ7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAgaWYgKCFz
aXplKQo+Pj4+PiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4+PiArCj4+Pj4+ICsg
ICAgIG1zZyA9IHZkdXNlX2Rldl9uZXdfbXNnKGRldiwgVkRVU0VfVVBEQVRFX0lPVExCKTsKPj4+
Pj4gKyAgICAgbXNnLT5yZXEuc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdmR1c2VfaW90bGIpOwo+Pj4+
PiArICAgICBtc2ctPnJlcS5pb3RsYi5vZmZzZXQgPSBvZmZzZXQ7Cj4+Pj4+ICsgICAgIG1zZy0+
cmVxLmlvdGxiLmlvdmEgPSBpb3ZhOwo+Pj4+PiArICAgICBtc2ctPnJlcS5pb3RsYi5zaXplID0g
c2l6ZTsKPj4+Pj4gKyAgICAgbXNnLT5yZXEuaW90bGIucGVybSA9IHBlcm07Cj4+Pj4+ICsgICAg
IG1zZy0+cmVxLmlvdGxiLmZkID0gLTE7Cj4+Pj4+ICsgICAgIG1zZy0+aW90bGJfZmlsZSA9IGdl
dF9maWxlKGZpbGUpOwo+Pj4+PiArCj4+Pj4+ICsgICAgIHJldCA9IHZkdXNlX2Rldl9tc2dfc3lu
YyhkZXYsIG1zZyk7Cj4+Pj4gTXkgZmVlbGluZyBpcyB0aGF0IHdlIHNob3VsZCBwcm92aWRlIGNv
bnNpc3RlbnQgQVBJIGZvciB0aGUgdXNlcnNwYWNlCj4+Pj4gZGV2aWNlIHRvIHVzZS4KPj4+Pgo+
Pj4+IEUuZyB3ZSdkIGJldHRlciBjYXJyeSB0aGUgSU9UTEIgbWVzc2FnZSBmb3IgYm90aCB2aXJ0
aW8vdmhvc3QgZHJpdmVycy4KPj4+Pgo+Pj4+IEl0IGxvb2tzIHRvIG1lIGZvciB2aXJ0aW8gZHJp
dmVycyB3ZSBjYW4gc3RpbGwgdXNlIFVQREFUX0lPVExCIG1lc3NhZ2UKPj4+PiBieSB1c2luZyBW
RFVTRSBmaWxlIGFzIG1zZy0+aW90bGJfZmlsZSBoZXJlLgo+Pj4+Cj4+PiBJdCdzIE9LIGZvciBt
ZS4gT25lIHByb2JsZW0gaXMgd2hlbiB0byB0cmFuc2ZlciB0aGUgVVBEQVRFX0lPVExCCj4+PiBt
ZXNzYWdlIGluIHZpcnRpbyBjYXNlcy4KPj4KPj4gSW5zdGVhZCBvZiBnZW5lcmF0aW5nIElPVExC
IG1lc3NhZ2VzIGZvciB1c2Vyc3BhY2UuCj4+Cj4+IEhvdyBhYm91dCByZWNvcmQgdGhlIG1hcHBp
bmdzICh3aGljaCBpcyBhIGNvbW1vbiBjYXNlIGZvciBkZXZpY2UgaGF2ZQo+PiBvbi1jaGlwIElP
TU1VIGUuZyBtbHg1ZSBhbmQgdmRwYSBzaW1sYXRvciksIHRoZW4gd2UgY2FuIGludHJvZHVjZSBp
b2N0bAo+PiBmb3IgdXNlcnNwYWNlIHRvIHF1ZXJ5Pwo+Pgo+IElmIHNvLCB0aGUgSU9UTEIgVVBE
QVRFIGlzIGFjdHVhbGx5IHRyaWdnZXJlZCBieSBpb2N0bCwgYnV0Cj4gSU9UTEJfSU5WQUxJREFU
RSBpcyB0cmlnZ2VyZWQgYnkgdGhlIG1lc3NhZ2UuIElzIGl0IGEgbGl0dGxlIG9kZD8KCgpHb29k
IHBvaW50LgoKU29tZSBxdWVzdGlvbnMgaGVyZToKCjEpIFVzZXJzcGFjZSB0aGluayB0aGUgSU9U
TEIgd2FzIGZsdXNoZWQgYWZ0ZXIgSU9UTEJfSU5WQUxJREFURSBzeXNjYWxsIAppcyByZXR1cm5l
ZC4gQnV0IHRoaXMgcGF0Y2ggZG9lc24ndCBoYXZlIHRoaXMgZ3VhcmFudGVlLiBDYW4gdGhpcyBs
ZWFkIApzb21lIGlzc3Vlcz8KMikgSSB0aGluayBhZnRlciBWRFVTRSB1c2Vyc3BhY2UgcmVjZWl2
ZXMgSU9UTEJfSU5WQUxJREFURSwgaXQgbmVlZHMgdG8gCmlzc3VlIGEgbXVubWFwKCkuIFdoYXQg
aWYgaXQgZG9lc24ndCBkbyB0aGF0PwoKCj4gICBPcgo+IGhvdyBhYm91dCB0cmlnZ2VyIGl0IHdo
ZW4gdXNlcnNwYWNlIGNhbGwgbW1hcCgpIG9uIHRoZSBkZXZpY2UgZmQ/CgoKT25lIHBvc3NpYmxl
IGlzc3VlIGlzIHRoYXQgdGhlIElPVExCX1VQREFURS9JTlZBTElEQVRFIG1pZ2h0IGNvbWUgYWZ0
ZXIgCm1tYXAoKToKCjEpIFdoZW4gdklPTU1VIGlzIGVuYWJsZWQKMikgR3Vlc3QgbWVtb3J5IHRv
cG9sb2d5IGhhcyBiZWVuIGNoYW5nZWQgKG1lbW9yeSBob3RwbHVnKS4KClRoYW5rcwoKCj4KPiBU
aGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
