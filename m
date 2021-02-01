Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11884C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:31:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9792364E25
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9792364E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 684BC86049;
	Mon,  1 Feb 2021 06:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOaI3j_5T7Hx; Mon,  1 Feb 2021 06:31:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 811A085FA6;
	Mon,  1 Feb 2021 06:31:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E95AC0174;
	Mon,  1 Feb 2021 06:31:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42409C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B76720243
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:31:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tXxbNtYTqqc8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:31:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 6B4F020117
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612161088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQnIWQf9C6+iWPjav1rsxJB9F4geXbdqF7FYdnK6OQI=;
 b=cwqwa80BF/ppzZvfaxufEk+neNRX+bolSCMwFgSxSme1EPT9mAQs7Rysjkzgu5b5ZkcsmA
 1LfcSt/eaI7iUF8LNDQNILKtvInBhPrd3dbmAQrL7rByBU50RnMRBD4kDyp/1vEF9FIFo8
 Prgc9/NLsN5LXXVvUfCDPxnhDaW/Yys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-wcxT8NBqOf2e-cmHFTfOkw-1; Mon, 01 Feb 2021 01:31:24 -0500
X-MC-Unique: wcxT8NBqOf2e-cmHFTfOkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 286191842140;
 Mon,  1 Feb 2021 06:31:23 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F25210016F5;
 Mon,  1 Feb 2021 06:31:13 +0000 (UTC)
Subject: Re: [PATCH RFC v2 02/10] vringh: add 'iotlb_lock' to synchronize
 iotlb accesses
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-3-sgarzare@redhat.com>
 <017f6e69-b2ec-aed0-5920-a389199e4cf9@redhat.com>
 <20210129091850.gatf3ih3knw2p4l4@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <40e6c307-b3e0-6bc1-05a1-804500b6fe3f@redhat.com>
Date: Mon, 1 Feb 2021 14:31:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129091850.gatf3ih3knw2p4l4@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMS8yOSDkuIvljYg1OjE4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
RnJpLCBKYW4gMjksIDIwMjEgYXQgMDM6NDM6NDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4KPj4gT24gMjAyMS8xLzI4IOS4i+WNiDEwOjQxLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+PiBVc3VhbGx5IGlvdGxiIGFjY2Vzc2VzIGFyZSBzeW5jaHJvbml6ZWQgd2l0aCBhIHNwaW5s
b2NrLgo+Pj4gTGV0J3MgcmVxdWVzdCBpdCBhcyBhIG5ldyBwYXJhbWV0ZXIgaW4gdnJpbmdoX3Nl
dF9pb3RsYigpIGFuZAo+Pj4gaG9sZCBpdCB3aGVuIHdlIG5hdmlnYXRlIHRoZSBpb3RsYiBpbiBp
b3RsYl90cmFuc2xhdGUoKSB0byBhdm9pZAo+Pj4gcmFjZSBjb25kaXRpb25zIHdpdGggYW55IG5l
dyBhZGRpdGlvbnMvZGVsZXRpb25zIG9mIHJhbmdlcyBmcm9tCj4+PiB0aGUgaW9sdGIuCj4+Cj4+
Cj4+IFBhdGNoIGxvb2tzIGZpbmUgYnV0IEkgd29uZGVyIGlmIHRoaXMgaXMgdGhlIGJlc3QgYXBw
cm9hY2ggY29tcGFyaW5nIAo+PiB0byBkbyBsb2NraW5nIGJ5IHRoZSBjYWxsZXIuCj4KPiBJbml0
aWFsbHkgSSB0cmllZCB0byBob2xkIHRoZSBsb2NrIGluIHRoZSB2ZHBhc2ltX2Jsa193b3JrKCks
IGJ1dCBzaW5jZQo+IHdlIGhhdmUgYSBsb3Qgb2YgZGlmZmVyZW50IGZ1bmN0aW9ucyBmb3IgdnJp
bmdoLCBJIG9wdGVkIHRvIHRha2UgdGhlIAo+IGxvY2sgYXQgdGhlIGJlZ2lubmluZyBhbmQgcmVs
ZWFzZSBpdCBhdCB0aGUgZW5kLgo+IEFsc28gYmVjYXVzZSBzZXZlcmFsIHRpbWVzIEkgd2VudCB0
byBzZWUgaWYgdGhhdCBjYWxsIHVzZWQgCj4gaW90bGJfdHJhbnNsYXRlIG9yIG5vdC4KPgo+IFRo
aXMgY291bGQgYmUgYSBwcm9ibGVtIGZvciBleGFtcGxlIGlmIHdlIGhhdmUgbXVsdGlwbGUgd29y
a2VycyB0byAKPiBoYW5kbGUgbXVsdGlwbGUgcXVldWVzLgo+Cj4gQWxzbywgc29tZSBmdW5jdGlv
bnMgYXJlIHF1aXRlIGxvbmcgKGUuZy4gdnJpbmdoX2dldGRlc2NfaW90bGIpIGFuZCAKPiBob2xk
aW5nIHRoZSBsb2NrIGZvciB0aGF0IGxvbmcgY291bGQgcmVkdWNlIHBhcmFsbGVsaXNtLgo+Cj4g
Rm9yIHRoZXNlIHJlYXNvbnMgSSB0aG91Z2h0IGl0IHdhcyBiZXR0ZXIgdG8gaGlkZSBldmVyeXRo
aW5nIGZyb20gdGhlIAo+IGNhbGxlciB3aG8gZG9lc24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0IHdo
aWNoIGZ1bmN0aW9uIGNhbGxzIAo+IGlvdGxiX3RyYW5zbGF0ZSgpIGFuZCB0aHVzIGhvbGQgdGhl
IGxvY2suCgoKRmluZSB3aXRoIG1lLgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+CgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgo+Pgo+PiBUaGFua3MK
Pj4KPj4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJl
QHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+IMKgaW5jbHVkZS9saW51eC92cmluZ2guaMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgNiArKysrKy0KPj4+IMKgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMgfCAzICsrLQo+Pj4gwqBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCA5ICsrKysrKysrLQo+Pj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdnJp
bmdoLmggYi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4+PiBpbmRleCA1OWJkNTBmOTkyOTEuLjlj
MDc3ODYzYzhmNiAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPj4+ICsr
KyBiL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPj4+IEBAIC00Niw2ICs0Niw5IEBAIHN0cnVjdCB2
cmluZ2ggewo+Pj4gwqDCoMKgwqAgLyogSU9UTEIgZm9yIHRoaXMgdnJpbmcgKi8KPj4+IMKgwqDC
oMKgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGI7Cj4+PiArwqDCoMKgIC8qIHNwaW5sb2NrIHRv
IHN5bmNocm9uaXplIElPVExCIGFjY2Vzc2VzICovCj4+PiArwqDCoMKgIHNwaW5sb2NrX3QgKmlv
dGxiX2xvY2s7Cj4+PiArCj4+PiDCoMKgwqDCoCAvKiBUaGUgZnVuY3Rpb24gdG8gY2FsbCB0byBu
b3RpZnkgdGhlIGd1ZXN0IGFib3V0IGFkZGVkIGJ1ZmZlcnMgKi8KPj4+IMKgwqDCoMKgIHZvaWQg
KCpub3RpZnkpKHN0cnVjdCB2cmluZ2ggKik7Cj4+PiDCoH07Cj4+PiBAQCAtMjU4LDcgKzI2MSw4
IEBAIHN0YXRpYyBpbmxpbmUgX192aXJ0aW82NCBjcHVfdG9fdnJpbmdoNjQoY29uc3QgCj4+PiBz
dHJ1Y3QgdnJpbmdoICp2cmgsIHU2NCB2YWwpCj4+PiDCoCNpZiBJU19SRUFDSEFCTEUoQ09ORklH
X1ZIT1NUX0lPVExCKQo+Pj4gLXZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2
cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpOwo+Pj4gK3ZvaWQgdnJpbmdoX3NldF9pb3Rs
YihzdHJ1Y3QgdnJpbmdoICp2cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpbmxvY2tfdCAqaW90bGJfbG9jayk7Cj4+PiDCoGlu
dCB2cmluZ2hfaW5pdF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHU2NCBmZWF0dXJlcywKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IG51bSwgYm9vbCB3ZWFr
X2JhcnJpZXJzLAo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bS5jIAo+Pj4gYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+Pj4gaW5kZXggMjE4
M2E4MzNmY2Y0Li41MzIzODk4OTcxM2QgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2lt
LmMKPj4+IEBAIC0yODQsNyArMjg0LDggQEAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRl
KHN0cnVjdCAKPj4+IHZkcGFzaW1fZGV2X2F0dHIgKmRldl9hdHRyKQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycl9pb21tdTsKPj4+IMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBkZXZfYXR0
ci0+bnZxczsgaSsrKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHZyaW5naF9zZXRfaW90bGIoJnZkcGFz
aW0tPnZxc1tpXS52cmluZywgdmRwYXNpbS0+aW9tbXUpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHZy
aW5naF9zZXRfaW90bGIoJnZkcGFzaW0tPnZxc1tpXS52cmluZywgdmRwYXNpbS0+aW9tbXUsCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnZkcGFzaW0tPmlvbW11X2xvY2sp
Owo+Pj4gwqDCoMKgwqAgcmV0ID0gaW92YV9jYWNoZV9nZXQoKTsKPj4+IMKgwqDCoMKgIGlmIChy
ZXQpCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92cmluZ2guYyBiL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMKPj4+IGluZGV4IDg1ZDg1ZmFiYTA1OC4uZjY4MTIyNzA1NzE5IDEwMDY0NAo+
Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2guYwo+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92
cmluZ2guYwo+Pj4gQEAgLTEwNzQsNiArMTA3NCw4IEBAIHN0YXRpYyBpbnQgaW90bGJfdHJhbnNs
YXRlKGNvbnN0IHN0cnVjdCB2cmluZ2ggCj4+PiAqdnJoLAo+Pj4gwqDCoMKgwqAgaW50IHJldCA9
IDA7Cj4+PiDCoMKgwqDCoCB1NjQgcyA9IDA7Cj4+PiArwqDCoMKgIHNwaW5fbG9jayh2cmgtPmlv
dGxiX2xvY2spOwo+Pj4gKwo+Pj4gwqDCoMKgwqAgd2hpbGUgKGxlbiA+IHMpIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqAgdTY0IHNpemUsIHBhLCBwZm47Cj4+PiBAQCAtMTEwMyw2ICsxMTA1LDggQEAg
c3RhdGljIGludCBpb3RsYl90cmFuc2xhdGUoY29uc3Qgc3RydWN0IHZyaW5naCAKPj4+ICp2cmgs
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgICsrcmV0Owo+Pj4gwqDCoMKgwqAgfQo+Pj4gK8KgwqDCoCBz
cGluX3VubG9jayh2cmgtPmlvdGxiX2xvY2spOwo+Pj4gKwo+Pj4gwqDCoMKgwqAgcmV0dXJuIHJl
dDsKPj4+IMKgfQo+Pj4gQEAgLTEyNjIsMTAgKzEyNjYsMTMgQEAgRVhQT1JUX1NZTUJPTCh2cmlu
Z2hfaW5pdF9pb3RsYik7Cj4+PiDCoCAqIHZyaW5naF9zZXRfaW90bGIgLSBpbml0aWFsaXplIGEg
dnJpbmdoIGZvciBhIHJpbmcgd2l0aCBJT1RMQi4KPj4+IMKgICogQHZyaDogdGhlIHZyaW5nCj4+
PiDCoCAqIEBpb3RsYjogaW90bGIgYXNzb2NpYXRlZCB3aXRoIHRoaXMgdnJpbmcKPj4+ICsgKiBA
aW90bGJfbG9jazogc3BpbmxvY2sgdG8gc3luY2hyb25pemUgdGhlIGlvdGxiIGFjY2Vzc2VzCj4+
PiDCoCAqLwo+Pj4gLXZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4+PiArdm9pZCB2cmluZ2hfc2V0X2lvdGxiKHN0cnVj
dCB2cmluZ2ggKnZyaCwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzcGlubG9ja190ICppb3RsYl9sb2NrKQo+Pj4gwqB7Cj4+PiDCoMKg
wqDCoCB2cmgtPmlvdGxiID0gaW90bGI7Cj4+PiArwqDCoMKgIHZyaC0+aW90bGJfbG9jayA9IGlv
dGxiX2xvY2s7Cj4+PiDCoH0KPj4+IMKgRVhQT1JUX1NZTUJPTCh2cmluZ2hfc2V0X2lvdGxiKTsK
Pj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
