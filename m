Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325CC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 06:40:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C872364EF9
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 06:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C872364EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 829DF4D0A8;
	Thu,  4 Mar 2021 06:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svX50anA8vdb; Thu,  4 Mar 2021 06:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8175464C9;
	Thu,  4 Mar 2021 06:40:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C1BEC000A;
	Thu,  4 Mar 2021 06:40:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 163C3C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 06:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB35643115
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 06:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PB6OX54pCqH6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 06:40:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E17A4017F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614840006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhc8+IYGUbK4OnkoVwRYTHNFwVq12BuILz0iHs1E/Uo=;
 b=E9vgvTh10fseRZBeF1vts5+1dT9WmFwqZF+zuGnPy2XcCizWE/KvodVdr4ehCfgxZjXUxm
 +iXHm/Rl81IjUpInvEvpN3Q3MGbOzmBkecBF+6x1LvKYYnblUDQmwEWgPhHqJ0F9iFyHIr
 a8fHbpdg04rwExUsVnHtoVhr5Yxxe8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-M0FYuybqNzCq9i68Eos2Cw-1; Thu, 04 Mar 2021 01:40:05 -0500
X-MC-Unique: M0FYuybqNzCq9i68Eos2Cw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81669100CC8B;
 Thu,  4 Mar 2021 06:40:02 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-113.pek2.redhat.com
 [10.72.12.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B93D65C1C2;
 Thu,  4 Mar 2021 06:39:50 +0000 (UTC)
Subject: Re: [RFC v4 09/11] Documentation: Add documentation for VDUSE
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-10-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <366f2dcf-51ab-4d66-9c94-517349ef0bdd@redhat.com>
Date: Thu, 4 Mar 2021 14:39:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-10-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBWRFVTRSAodkRQ
QSBEZXZpY2UgaW4gVXNlcnNwYWNlKSBpcyBhIGZyYW1ld29yayB0byBzdXBwb3J0Cj4gaW1wbGVt
ZW50aW5nIHNvZnR3YXJlLWVtdWxhdGVkIHZEUEEgZGV2aWNlcyBpbiB1c2Vyc3BhY2UuIFRoaXMK
PiBkb2N1bWVudCBpcyBpbnRlbmRlZCB0byBjbGFyaWZ5IHRoZSBWRFVTRSBkZXNpZ24gYW5kIHVz
YWdlLgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5j
b20+Cj4gLS0tCj4gICBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvaW5kZXgucnN0IHwgICAx
ICsKPiAgIERvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS92ZHVzZS5yc3QgfCAxMTIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMTMgaW5z
ZXJ0aW9ucygrKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS92ZHVzZS5yc3QKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1h
cGkvaW5kZXgucnN0IGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2luZGV4LnJzdAo+IGlu
ZGV4IGFjZDJjYzJhNTM4ZC4uZjYzMTE5MTMwODk4IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRp
b24vdXNlcnNwYWNlLWFwaS9pbmRleC5yc3QKPiArKysgYi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFj
ZS1hcGkvaW5kZXgucnN0Cj4gQEAgLTI0LDYgKzI0LDcgQEAgcGxhY2Ugd2hlcmUgdGhpcyBpbmZv
cm1hdGlvbiBpcyBnYXRoZXJlZC4KPiAgICAgIGlvY3RsL2luZGV4Cj4gICAgICBpb21tdQo+ICAg
ICAgbWVkaWEvaW5kZXgKPiArICAgdmR1c2UKPiAgIAo+ICAgLi4gb25seTo6ICBzdWJwcm9qZWN0
IGFuZCBodG1sCj4gICAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBp
L3ZkdXNlLnJzdCBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS92ZHVzZS5yc3QKPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmEyMGU2ODZiYjU5Cj4gLS0t
IC9kZXYvbnVsbAo+ICsrKyBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS92ZHVzZS5yc3QK
PiBAQCAtMCwwICsxLDExMiBAQAo+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Cj4gK1ZEVVNFIC0gInZEUEEgRGV2aWNlIGluIFVzZXJzcGFjZSIKPiArPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQo+ICsKPiArdkRQQSAodmlydGlvIGRhdGEgcGF0aCBhY2NlbGVy
YXRpb24pIGRldmljZSBpcyBhIGRldmljZSB0aGF0IHVzZXMgYQo+ICtkYXRhcGF0aCB3aGljaCBj
b21wbGllcyB3aXRoIHRoZSB2aXJ0aW8gc3BlY2lmaWNhdGlvbnMgd2l0aCB2ZW5kb3IKPiArc3Bl
Y2lmaWMgY29udHJvbCBwYXRoLiB2RFBBIGRldmljZXMgY2FuIGJlIGJvdGggcGh5c2ljYWxseSBs
b2NhdGVkIG9uCj4gK3RoZSBoYXJkd2FyZSBvciBlbXVsYXRlZCBieSBzb2Z0d2FyZS4gVkRVU0Ug
aXMgYSBmcmFtZXdvcmsgdGhhdCBtYWtlcyBpdAo+ICtwb3NzaWJsZSB0byBpbXBsZW1lbnQgc29m
dHdhcmUtZW11bGF0ZWQgdkRQQSBkZXZpY2VzIGluIHVzZXJzcGFjZS4KPiArCj4gK0hvdyBWRFVT
RSB3b3Jrcwo+ICstLS0tLS0tLS0tLS0KPiArRWFjaCB1c2Vyc3BhY2UgdkRQQSBkZXZpY2UgaXMg
Y3JlYXRlZCBieSB0aGUgVkRVU0VfQ1JFQVRFX0RFViBpb2N0bCBvbgo+ICt0aGUgY2hhcmFjdGVy
IGRldmljZSAoL2Rldi92ZHVzZS9jb250cm9sKS4gVGhlbiBhIGRldmljZSBmaWxlIHdpdGggdGhl
Cj4gK3NwZWNpZmllZCBuYW1lICgvZGV2L3ZkdXNlLyROQU1FKSB3aWxsIGFwcGVhciwgd2hpY2gg
Y2FuIGJlIHVzZWQgdG8KPiAraW1wbGVtZW50IHRoZSB1c2Vyc3BhY2UgdkRQQSBkZXZpY2UncyBj
b250cm9sIHBhdGggYW5kIGRhdGEgcGF0aC4KCgpJdCdzIGJldHRlciB0byBtZW50aW9uIHRoYXQg
aW4gb3JkZXIgdG8gbGUgdGh0ZSBkZXZpY2UgdG8gYmUgcmVnaXN0ZXJlZCAKb24gdGhlIGJ1cywg
YWRtaW4gbmVlZCB0byB1c2UgdGhlIG1hbmFnZW1lbnQgQVBJKG5ldGxpbmspIHRvIGNyZWF0ZSB0
aGUgCnZEUEEgZGV2aWNlLgoKU29tZSBjb2RlcyB0byBkZW1ub25zdHJhdGUgaG93IHRvIGNyZWF0
ZSB0aGUgZGV2aWNlIHdpbGwgYmUgYmV0dGVyLgoKCj4gKwo+ICtUbyBpbXBsZW1lbnQgY29udHJv
bCBwYXRoLCBhIG1lc3NhZ2UtYmFzZWQgY29tbXVuaWNhdGlvbiBwcm90b2NvbCBhbmQgc29tZQo+
ICt0eXBlcyBvZiBjb250cm9sIG1lc3NhZ2VzIGFyZSBpbnRyb2R1Y2VkIGluIHRoZSBWRFVTRSBm
cmFtZXdvcms6Cj4gKwo+ICstIFZEVVNFX1NFVF9WUV9BRERSOiBTZXQgdGhlIHZyaW5nIGFkZHJl
c3Mgb2YgdmlydHF1ZXVlLgo+ICsKPiArLSBWRFVTRV9TRVRfVlFfTlVNOiBTZXQgdGhlIHNpemUg
b2YgdmlydHF1ZXVlCj4gKwo+ICstIFZEVVNFX1NFVF9WUV9SRUFEWTogU2V0IHJlYWR5IHN0YXR1
cyBvZiB2aXJ0cXVldWUKPiArCj4gKy0gVkRVU0VfR0VUX1ZRX1JFQURZOiBHZXQgcmVhZHkgc3Rh
dHVzIG9mIHZpcnRxdWV1ZQo+ICsKPiArLSBWRFVTRV9TRVRfVlFfU1RBVEU6IFNldCB0aGUgc3Rh
dGUgZm9yIHZpcnRxdWV1ZQo+ICsKPiArLSBWRFVTRV9HRVRfVlFfU1RBVEU6IEdldCB0aGUgc3Rh
dGUgZm9yIHZpcnRxdWV1ZQo+ICsKPiArLSBWRFVTRV9TRVRfRkVBVFVSRVM6IFNldCB2aXJ0aW8g
ZmVhdHVyZXMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIKPiArCj4gKy0gVkRVU0VfR0VUX0ZFQVRV
UkVTOiBHZXQgdmlydGlvIGZlYXR1cmVzIHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlCj4gKwo+ICst
IFZEVVNFX1NFVF9TVEFUVVM6IFNldCB0aGUgZGV2aWNlIHN0YXR1cwo+ICsKPiArLSBWRFVTRV9H
RVRfU1RBVFVTOiBHZXQgdGhlIGRldmljZSBzdGF0dXMKPiArCj4gKy0gVkRVU0VfU0VUX0NPTkZJ
RzogV3JpdGUgdG8gZGV2aWNlIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24gc3BhY2UKPiArCj4gKy0g
VkRVU0VfR0VUX0NPTkZJRzogUmVhZCBmcm9tIGRldmljZSBzcGVjaWZpYyBjb25maWd1cmF0aW9u
IHNwYWNlCj4gKwo+ICstIFZEVVNFX1VQREFURV9JT1RMQjogTm90aWZ5IHVzZXJzcGFjZSB0byB1
cGRhdGUgdGhlIG1lbW9yeSBtYXBwaW5nIGluIGRldmljZSBJT1RMQgo+ICsKPiArVGhvc2UgY29u
dHJvbCBtZXNzYWdlcyBhcmUgbW9zdGx5IGJhc2VkIG9uIHRoZSB2ZHBhX2NvbmZpZ19vcHMgaW4K
PiAraW5jbHVkZS9saW51eC92ZHBhLmggd2hpY2ggZGVmaW5lcyBhIHVuaWZpZWQgaW50ZXJmYWNl
IHRvIGNvbnRyb2wKPiArZGlmZmVyZW50IHR5cGVzIG9mIHZkcGEgZGV2aWNlLiBVc2Vyc3BhY2Ug
bmVlZHMgdG8gcmVhZCgpL3dyaXRlKCkKPiArb24gdGhlIFZEVVNFIGRldmljZSBmaWxlIHRvIHJl
Y2VpdmUvcmVwbHkgdGhvc2UgY29udHJvbCBtZXNzYWdlcwo+ICtmcm9tL3RvIFZEVVNFIGtlcm5l
bCBtb2R1bGUgYXMgZm9sbG93czoKPiArCj4gKy4uIGNvZGUtYmxvY2s6OiBjCj4gKwo+ICsJc3Rh
dGljIGludCB2ZHVzZV9tZXNzYWdlX2hhbmRsZXIoaW50IGRldl9mZCkKPiArCXsKPiArCQlpbnQg
bGVuOwo+ICsJCXN0cnVjdCB2ZHVzZV9kZXZfcmVxdWVzdCByZXE7Cj4gKwkJc3RydWN0IHZkdXNl
X2Rldl9yZXNwb25zZSByZXNwOwo+ICsKPiArCQlsZW4gPSByZWFkKGRldl9mZCwgJnJlcSwgc2l6
ZW9mKHJlcSkpOwo+ICsJCWlmIChsZW4gIT0gc2l6ZW9mKHJlcSkpCj4gKwkJCXJldHVybiAtMTsK
PiArCj4gKwkJcmVzcC5yZXF1ZXN0X2lkID0gcmVxLnVuaXF1ZTsKPiArCj4gKwkJc3dpdGNoIChy
ZXEudHlwZSkgewo+ICsKPiArCQkvKiBoYW5kbGUgZGlmZmVyZW50IHR5cGVzIG9mIG1lc3NhZ2Ug
Ki8KPiArCj4gKwkJfQo+ICsKPiArCQlsZW4gPSB3cml0ZShkZXZfZmQsICZyZXNwLCBzaXplb2Yo
cmVzcCkpOwo+ICsJCWlmIChsZW4gIT0gc2l6ZW9mKHJlc3ApKQo+ICsJCQlyZXR1cm4gLTE7Cj4g
Kwo+ICsJCXJldHVybiAwOwo+ICsJfQo+ICsKPiArSW4gdGhlIGRldGEgcGF0aCwgdkRQQSBkZXZp
Y2UncyBpb3ZhIHJlZ2lvbnMgd2lsbCBiZSBtYXBwZWQgaW50byB1c2Vyc3BhY2UKPiArd2l0aCB0
aGUgaGVscCBvZiBWRFVTRV9JT1RMQl9HRVRfRkQgaW9jdGwgb24gdGhlIFZEVVNFIGRldmljZSBm
aWxlOgo+ICsKPiArLSBWRFVTRV9JT1RMQl9HRVRfRkQ6IGdldCB0aGUgZmlsZSBkZXNjcmlwdG9y
IHRvIGlvdmEgcmVnaW9uLiBVc2Vyc3BhY2UgY2FuCj4gKyAgYWNjZXNzIHRoaXMgaW92YSByZWdp
b24gYnkgcGFzc2luZyB0aGUgZmQgdG8gbW1hcCgpLgoKCkl0IHdvdWxkIGJlIGJldHRlciB0byBo
YXZlIGNvZGVzIHRvIGV4cGxhaW4gaG93IGl0IGlzIGV4cGVjdGVkIHRvIHdvcmsgaGVyZS4KCgo+
ICsKPiArQmVzaWRlcywgdGhlIGZvbGxvd2luZyBpb2N0bHMgb24gdGhlIFZEVVNFIGRldmljZSBm
aWxlIGFyZSBwcm92aWRlZCB0byBzdXBwb3J0Cj4gK2ludGVycnVwdCBpbmplY3Rpb24gYW5kIHNl
dHRpbmcgdXAgZXZlbnRmZCBmb3IgdmlydHF1ZXVlIGtpY2tzOgo+ICsKPiArLSBWRFVTRV9WUV9T
RVRVUF9LSUNLRkQ6IHNldCB0aGUga2lja2ZkIGZvciB2aXJ0cXVldWUsIHRoaXMgZXZlbnRmZCBp
cyB1c2VkCj4gKyAgYnkgVkRVU0Uga2VybmVsIG1vZHVsZSB0byBub3RpZnkgdXNlcnNwYWNlIHRv
IGNvbnN1bWUgdGhlIHZyaW5nLgo+ICsKPiArLSBWRFVTRV9JTkpFQ1RfVlFfSVJROiBpbmplY3Qg
YW4gaW50ZXJydXB0IGZvciBzcGVjaWZpYyB2aXJ0cXVldWUKPiArCj4gKy0gVkRVU0VfSU5KRUNU
X0NPTkZJR19JUlE6IGluamVjdCBhIGNvbmZpZyBpbnRlcnJ1cHQKPiArCj4gK01NVS1iYXNlZCBJ
T01NVSBEcml2ZXIKPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICtJbiB2aXJ0aW8tdmRwYSBj
YXNlLCBWRFVTRSBmcmFtZXdvcmsgaW1wbGVtZW50cyBhbiBNTVUtYmFzZWQgb24tY2hpcCBJT01N
VQo+ICtkcml2ZXIgdG8gc3VwcG9ydCBtYXBwaW5nIHRoZSBrZXJuZWwgRE1BIGJ1ZmZlciBpbnRv
IHRoZSB1c2Vyc3BhY2UgaW92YQo+ICtyZWdpb24gZHluYW1pY2FsbHkuCj4gKwo+ICtUaGUgYmFz
aWMgaWRlYSBiZWhpbmQgdGhpcyBkcml2ZXIgaXMgdHJlYXRpbmcgTU1VIChWQS0+UEEpIGFzIElP
TU1VIChJT1ZBLT5QQSkuCj4gK1RoZSBkcml2ZXIgd2lsbCBzZXQgdXAgTU1VIG1hcHBpbmcgaW5z
dGVhZCBvZiBJT01NVSBtYXBwaW5nIGZvciB0aGUgRE1BIHRyYW5zZmVyCj4gK3NvIHRoYXQgdGhl
IHVzZXJzcGFjZSBwcm9jZXNzIGlzIGFibGUgdG8gdXNlIGl0cyB2aXJ0dWFsIGFkZHJlc3MgdG8g
YWNjZXNzCj4gK3RoZSBETUEgYnVmZmVyIGluIGtlcm5lbC4KPiArCj4gK0FuZCB0byBhdm9pZCBz
ZWN1cml0eSBpc3N1ZSwgYSBib3VuY2UtYnVmZmVyaW5nIG1lY2hhbmlzbSBpcyBpbnRyb2R1Y2Vk
IHRvCj4gK3ByZXZlbnQgdXNlcnNwYWNlIGFjY2Vzc2luZyB0aGUgb3JpZ2luYWwgYnVmZmVyIGRp
cmVjdGx5IHdoaWNoIG1heSBjb250YWluIG90aGVyCj4gK2tlcm5lbCBkYXRhLgoKCkl0J3Mgd29y
dGggdG8gbWVudGlvbiB0aGlzIGlzIGRlc2lnbmVkIGZvciB2aXJ0aW8tdmRwYSAoa2VybmVsIHZp
cnRpbyAKZHJpdmVycykuCgpUaGFua3MKCgo+ICAgRHVyaW5nIHRoZSBtYXBwaW5nLCB1bm1hcHBp
bmcsIHRoZSBkcml2ZXIgd2lsbCBjb3B5IHRoZSBkYXRhIGZyb20KPiArdGhlIG9yaWdpbmFsIGJ1
ZmZlciB0byB0aGUgYm91bmNlIGJ1ZmZlciBhbmQgYmFjaywgZGVwZW5kaW5nIG9uIHRoZSBkaXJl
Y3Rpb24gb2YKPiArdGhlIHRyYW5zZmVyLiBBbmQgdGhlIGJvdW5jZS1idWZmZXIgYWRkcmVzc2Vz
IHdpbGwgYmUgbWFwcGVkIGludG8gdGhlIHVzZXIgYWRkcmVzcwo+ICtzcGFjZSBpbnN0ZWFkIG9m
IHRoZSBvcmlnaW5hbCBvbmUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
