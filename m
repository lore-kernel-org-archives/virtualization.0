Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E3DC433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 10:03:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2917261424
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 10:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2917261424
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6EF8843BF;
	Wed, 28 Apr 2021 10:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsECDb9cYbBZ; Wed, 28 Apr 2021 10:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27291843BC;
	Wed, 28 Apr 2021 10:03:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2C8C001C;
	Wed, 28 Apr 2021 10:03:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 084C8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCA1940581
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fmVMAf4rheyW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:03:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 840D840298
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619604224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kch3xLnz70cDbvDpj0Fifq23aWnY4BjlTmpmNAogQ4A=;
 b=UKNuR9E9ldtKX4glXhYfYJA9+3UBgqjEbFzGz30h1N4YatbzorV+2DO5tV+D5HyoDut78e
 2CuuKiFt1aUC6NBLhaSyEq3+/8IiLau8h1c7EO3heA0jQHovEwIH+2nzBfYJaLUEAFperb
 YKhRppyW7mPI6vOI8SCE2aHVCfeDJOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-JMqoHd-RMbaSkEr70xrx7w-1; Wed, 28 Apr 2021 06:03:42 -0400
X-MC-Unique: JMqoHd-RMbaSkEr70xrx7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75C078186E5;
 Wed, 28 Apr 2021 10:03:41 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-25.pek2.redhat.com
 [10.72.12.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C481B5D9C6;
 Wed, 28 Apr 2021 10:03:35 +0000 (UTC)
Subject: Re: [PATCH 2/2] vDPA/ifcvf: implement doorbell mapping for ifcvf
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210428082133.6766-1-lingshan.zhu@intel.com>
 <20210428082133.6766-3-lingshan.zhu@intel.com>
 <f6d9a424-9025-3eb5-1cb4-0ff22f7bec63@redhat.com>
 <5052fced-cd9a-e453-5cb2-39cdde60a208@intel.com>
 <1984491f-cd5e-d4bc-b328-41e2f2e935fd@redhat.com>
 <ef510c97-1f1c-a121-99db-b659a5f9518c@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4e0eda74-04ac-a889-471b-03fe65c65606@redhat.com>
Date: Wed, 28 Apr 2021 18:03:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <ef510c97-1f1c-a121-99db-b659a5f9518c@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIxLzQvMjgg5LiL5Y2INTo1NiwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDQvMjgvMjAyMSA1OjIxIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzI4
IOS4i+WNiDQ6NTksIFpodSwgTGluZ3NoYW4g5YaZ6YGTOgo+Pj4KPj4+Cj4+PiBPbiA0LzI4LzIw
MjEgNDo0MiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pgo+Pj4+IOWcqCAyMDIxLzQvMjgg5LiL
5Y2INDoyMSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+Pj4gVGhpcyBjb21taXQgaW1wbGVtZW50
cyBkb29yYmVsbCBtYXBwaW5nIGZlYXR1cmUgZm9yIGlmY3ZmLgo+Pj4+PiBUaGlzIGZlYXR1cmUg
bWFwcyB0aGUgbm90aWZ5IHBhZ2UgdG8gdXNlcnNwYWNlLCB0byBlbGltaW5hdGUKPj4+Pj4gdm1l
eGl0IHdoZW4ga2ljayBhIHZxLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMTggKysrKysrKysrKysrKysrKysrCj4+Pj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+Pj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPj4+Pj4gaW5kZXggZTQ4ZTZiNzRmZTJlLi5hZmNiNzFiYzBmNTEgMTAw
NjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+Pj4gKysr
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+PiBAQCAtNDEzLDYgKzQxMywy
MyBAQCBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfZ2V0X3ZxX2lycShzdHJ1Y3QgCj4+Pj4+IHZkcGFf
ZGV2aWNlICp2ZHBhX2RldiwKPj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gdmYtPnZyaW5nW3FpZF0u
aXJxOwo+Pj4+PiDCoCB9Cj4+Pj4+IMKgICtzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9u
X2FyZWEgCj4+Pj4+IGlmY3ZmX2dldF92cV9ub3RpZmljYXRpb24oc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhX2RldiwKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUxNiBpZHgpCj4+Pj4+ICt7Cj4+Pj4+ICvC
oMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+Pj4+PiAr
wqDCoMKgIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIGFyZWE7Cj4+Pj4+ICsKPj4+Pj4g
K8KgwqDCoCBpZiAodmYtPm5vdGlmeV9wYSAlIFBBR0VfU0laRSkgewo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgYXJlYS5hZGRyID0gMDsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFyZWEuc2l6ZSA9IDA7
Cj4+Pj4KPj4+Pgo+Pj4+IFdlIGRvbid0IG5lZWQgdGhpcyBzaW5jZToKPj4+Pgo+Pj4+IDEpIHRo
ZXJlJ3MgYSBjaGVjayBpbiB0aGUgdmhvc3QgdkRQQQo+Pj4gSSB0aGluayB5b3UgbWVhbiB0aGlz
IGNvZGUgYmxvY2sgaW4gdmRwYS5jCj4+PiDCoMKgwqDCoMKgwqDCoCBub3RpZnkgPSBvcHMtPmdl
dF92cV9ub3RpZmljYXRpb24odmRwYSwgaW5kZXgpOwo+Pj4gwqDCoMKgwqDCoMKgwqAgaWYgKG5v
dGlmeS5hZGRyICYgKFBBR0VfU0laRSAtIDEpKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4KPj4+IFRoaXMgc2hvdWxkIHdvcmssIGhvd2V2ZXIs
IEkgdGhpbmsgdGhlIHBhcmVudCBkcml2ZXIgc2hvdWxkIGVuc3VyZSAKPj4+IGl0IHBhc3NlcyBh
IFBBR0VfU0laRSBhbGlnbmVkIGFkZHJlc3MgdG8gdXNlcnNwYWNlLCB0byBiZSByb2J1c3QsIHRv
IAo+Pj4gYmUgcmVsaWFibGUuCj4+Cj4+Cj4+IFRoZSBwb2ludCBpcyBwYXJlbnQgaXMgdW5hd2Fy
ZSBvZiB3aGV0aGVyIG9yIG5vdCB0aGVyZSdzIGEgdXNlcnNwYWNlLgo+IHdoZW4gY2FsbGluZyB0
aGlzLCBJIHRoaW5rIGl0IHRhcmdldHMgYSB1c2Vyc2FwY2UgcHJvZ3JhbSwgd2h5IGtlcm5lbCAK
PiBzcGFjZSBuZWVkIGl0LCBzbyBJTUhPIG5vIGhhcm0gaWYgd2UgY2hlY2sgdGhpcyB0byBrZWVw
IHRoZSBwYXJlbnQgCj4gZHJpdmVyIHJvYnVzdC4KCgpBZ2FpbiwgdkRQQSBkZXZpY2UgaXMgdW5h
d2FyZSBvZiB3aGF0IGRyaXZlciB0aGF0IGlzIGJvdW5kLiBJdCBjb3VsZCBiZSAKdmlydGlvLXZw
ZGEsIHZob3N0LXZkcGEgb3Igb3RoZXIgaW4gdGhlIGZ1dHVyZS4gSXQncyBvbmx5IHRoZSB2RFBB
IGJ1cyAKZHJpdmVyIGtub3cgaG93IGl0IGlzIGFjdHVhbGx5IHVzZWQuCgoKPj4KPj4KPj4+PiAy
KSBkZXZpY2UgaXMgdW5hd2FyZSBvZiB0aGUgYm91bmQgZHJpdmVyLCBub24gcGFnZSBhbGlnbmVk
IGRvb3JiZWxsIAo+Pj4+IGRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVhbnQgaXQgY2FuIGJlIHVzZWQK
Pj4+IFllcywgbm9uIHBhZ2UgYWxpZ25lZCBkb29yYmVsbCBjYW4gbm90IGJlIHVzZWQsIHNvIHRo
ZXJlIGlzIGEgY2hlY2suCj4+Cj4+Cj4+IFR5cG8sIHdoYXQgSSBtZWFudCBpcyAiaXQgY2FuJ3Qg
YmUgdXNlZCIuIFRoYXQgaXMgdG8gc2F5LCB3ZSBzaG91bGQgCj4+IGxldCB0aGUgdkRQQSBidXMg
ZHJpdmVyIHRvIGRlY2lkZSB3aGV0aGVyIG9yIG5vdCBpdCBjYW4gYmUgdXNlZC4KPiBJZiBpdCBp
cyBub3QgcGFnZSBhbGlnbmVkLCB0aGVyZSB3b3VsZCBiZSBleHRyYSBjb21wbGV4aXRpZXMgZm9y
IAo+IHZob3N0L3FlbXUsIEkgc2VlIGl0IGFzIGEgaGFyZHdhcmUgZGVmZWN0LCAKCgpJdCBpcyBh
bGxvd2VkIGJ5IHRoZSB2aXJ0aW8gc3BlYywgaXNuJ3QgaXQ/CgpUaGFua3MKCgo+IHdoeSBhZGFw
dCB0byB0aGlzIGtpbmQgb2YgZGVmZWN0cz8KPgo+IFRoYW5rcwo+IFpodSBMaW5nc2hhbgo+Pgo+
PiBUaGFua3MKPj4KPj4KPj4+Cj4+PiBUaGFua3MKPj4+IFpodSBMaW5nc2hhbgo+Pj4+Cj4+Pj4g
TGV0J3MgbGVhdmUgdGhvc2UgcG9saWNlcyB0byB0aGUgZHJpdmVyLgo+Pj4+Cj4+Pj4gVGhhbmtz
Cj4+Pj4KPj4+Pgo+Pj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBh
cmVhLmFkZHIgPSB2Zi0+bm90aWZ5X3BhOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgYXJlYS5zaXpl
ID0gUEFHRV9TSVpFOwo+Pj4+PiArwqDCoMKgIH0KPj4+Pj4gKwo+Pj4+PiArwqDCoMKgIHJldHVy
biBhcmVhOwo+Pj4+PiArfQo+Pj4+PiArCj4+Pj4+IMKgIC8qCj4+Pj4+IMKgwqAgKiBJRkNWRiBj
dXJyZW50bHkgZG9lcyd0IGhhdmUgb24tY2hpcCBJT01NVSwgc28gbm90Cj4+Pj4+IMKgwqAgKiBp
bXBsZW1lbnRlZCBzZXRfbWFwKCkvZG1hX21hcCgpL2RtYV91bm1hcCgpCj4+Pj4+IEBAIC00NDAs
NiArNDU3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgCj4+Pj4+IGlm
Y192ZHBhX29wcyA9ewo+Pj4+PiDCoMKgwqDCoMKgIC5nZXRfY29uZmlnwqDCoMKgID0gaWZjdmZf
dmRwYV9nZXRfY29uZmlnLAo+Pj4+PiDCoMKgwqDCoMKgIC5zZXRfY29uZmlnwqDCoMKgID0gaWZj
dmZfdmRwYV9zZXRfY29uZmlnLAo+Pj4+PiDCoMKgwqDCoMKgIC5zZXRfY29uZmlnX2NiwqAgPSBp
ZmN2Zl92ZHBhX3NldF9jb25maWdfY2IsCj4+Pj4+ICvCoMKgwqAgLmdldF92cV9ub3RpZmljYXRp
b24gPSBpZmN2Zl9nZXRfdnFfbm90aWZpY2F0aW9uLAo+Pj4+PiDCoCB9Owo+Pj4+PiDCoCDCoCBz
dGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3Qg
Cj4+Pj4+IHBjaV9kZXZpY2VfaWQgKmlkKQo+Pj4+Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
