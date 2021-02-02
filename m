Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B373C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:26:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACD964ECB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 03:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACD964ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4DD3A8676E;
	Tue,  2 Feb 2021 03:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2fjoCAEhfRAZ; Tue,  2 Feb 2021 03:26:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8812986747;
	Tue,  2 Feb 2021 03:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 699D0C0174;
	Tue,  2 Feb 2021 03:26:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23CA5C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A6D68545F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kiwodLzQg8To
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1F37F85450
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612236405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+0xoBytfYFL452jZI7eq1Xid/1xoGVklSAHoMYfbNM=;
 b=aYdKwX0K5+LQhpaHi3Ea8dIyR0mSy+ekoTAr1PSehhKxCxmLBjigo5SeCGfSLIaQctMU2U
 3hFPs0lb9o0iZOW5wllFxuCoPHCz6Y+E6SxLMDV7gGywni2Wi7Ska/O1SuacJsxjXkJf2l
 LAedpvdMygasiCN9gj/zHNmwzuWoXGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-1axtorIiNDm0hWhRTR7PxA-1; Mon, 01 Feb 2021 22:26:44 -0500
X-MC-Unique: 1axtorIiNDm0hWhRTR7PxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17B6C803623;
 Tue,  2 Feb 2021 03:26:43 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8EA5D9CA;
 Tue,  2 Feb 2021 03:26:32 +0000 (UTC)
Subject: Re: [PATCH RFC v2 03/10] vringh: reset kiov 'consumed' field in
 __vringh_iov()
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-4-sgarzare@redhat.com>
 <62bb2e93-4ac3-edf5-2baa-4c2be8257cf0@redhat.com>
 <20210201102120.kvbpbne3spaqv6yz@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <55287f2f-0288-ac07-8232-787612c00290@redhat.com>
Date: Tue, 2 Feb 2021 11:26:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201102120.kvbpbne3spaqv6yz@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMi8xIOS4i+WNiDY6MjEsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBPbiBN
b24sIEZlYiAwMSwgMjAyMSBhdCAwMTo0MDowMVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
Pgo+PiBPbiAyMDIxLzEvMjgg5LiL5Y2IMTA6NDEsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToK
Pj4+IF9fdnJpbmdoX2lvdigpIG92ZXJ3cml0ZXMgdGhlIGNvbnRlbnRzIG9mIHJpb3YgYW5kIHdp
b3YsIGluIGZhY3QgaXQKPj4+IHJlc2V0cyB0aGUgJ2knIGFuZCAndXNlZCcgZmllbGRzLCBidXQg
YWxzbyB0aGUgY29uc3VtZWQgZmllbGQgc2hvdWxkCj4+PiBiZSByZXNldCB0byBhdm9pZCBhbiBp
bmNvbnNpc3RlbnQgc3RhdGUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJl
bGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pgo+Pgo+PiBJIGhhZCBhIHF1ZXN0aW9uKEkgcmVt
ZW1iZXIgd2UgaGFkIHNvbWUgZGlzY3Vzc2lvbiBsaWtlIHRoaXMgYnV0IEkgCj4+IGZvcmdldCB0
aGUgY29uY2x1c2lvbik6Cj4KPiBTb3JyeSwgSSBmb3Jnb3QgdG8gdXBkYXRlIHlvdS4KPgo+Pgo+
PiBJIHNlZSBlLmcgaW4gdnJpbmdoX2dldGRlc2Nfa2VybigpIGl0IGhhcyB0aGUgZm9sbG93aW5n
IGNvbW1lbnQ6Cj4+Cj4+IC8qCj4+IMKgKiBOb3RlIHRoYXQgeW91IG1heSBuZWVkIHRvIGNsZWFu
IHVwIHJpb3YgYW5kIHdpb3YsIGV2ZW4gb24gZXJyb3IhCj4+IMKgKi8KPj4KPj4gU28gaXQgbG9v
a3MgdG8gbWUgdGhlIGNvcnJlY3Qgd2F5IGlzIHRvIGNhbGwgdnJpbmdoX2tpb3ZfY2xlYW51cCgp
IAo+PiBiZWZvcmU/Cj4KPiBMb29raW5nIGF0IHRoZSBjb2RlIHRoZSByaWdodCBwYXR0ZXJuIHNo
b3VsZCBiZToKPgo+IMKgwqDCoCB2cmluZ2hfZ2V0ZGVzY18qKC4uLiwgJm91dF9pb3YsICZpbl9p
b3YsIC4uLik7Cj4KPiDCoMKgwqAgLy8gdXNlIG91dF9pb3YgYW5kIGluX2lvdgo+Cj4gwqDCoMKg
IHZyaW5naF9raW92X2NsZWFudXAoJm91dF9pb3YpOwo+IMKgwqDCoCB2cmluZ2hfa2lvdl9jbGVh
bnVwKCZpbl9pb3YpOwo+Cj4gVGhpcyBiZWNhdXNlIHZyaW5naF9nZXRkZXNjXyooKSBjYWxscyBf
X3ZyaW5naF9pb3YoKSB3aGVyZSAKPiByZXNpemVfaW92ZWMoKSBpcyBjYWxsZWQgdG8gYWxsb2Nh
dGUgdGhlIGlvdiB3cmFwcGVkIGJ5ICdzdHJ1Y3QgCj4gdnJpbmdoX2tpb3YnIGFuZCB2cmluZ2hf
a2lvdl9jbGVhbnVwKCkgZnJlZXMgdGhhdCBtZW1vcnkuCj4KPiBMb29raW5nIGJldHRlciwgX192
cmluZ2hfaW92KCkgaXMgYWJsZSB0byBleHRlbmQgYSAndnJpbmdoX2tpb3YnIAo+IHByZS1hbGxv
Y2F0ZWQsIHNvIGluIG9yZGVyIHRvIGF2b2lkIHRvIGFsbG9jYXRlIGFuZCBmcmVlIHRoZSBpb3Yg
Zm9yIAo+IGVhY2ggcmVxdWVzdCB3ZSBjYW4gYXZvaWQgdG8gY2FsbCB2cmluZ2hfa2lvdl9jbGVh
bnVwKCksIGJ1dCB0aGlzIAo+IHBhdGNoIGlzIG5lZWRlZCB0byBhdm9pZCBhbiBpbmNvbnNpc3Rl
bnQgc3RhdGUuCj4KPiBBbmQgYWxzbyBwYXRjaCAidmRwYV9zaW06IGNsZWFudXAga2lvdnMgaW4g
dmRwYXNpbV9mcmVlKCkiIGlzIHJlcXVpcmVkIAo+IHRvIGZyZWUgdGhlIGlvdiB3aGVuIHRoZSBk
ZXZpY2UgaXMgZ29pbmcgYXdheS4KPgo+IERvZXMgdGhhdCBtYWtlIHNlbnNlIHRvIHlvdT8KCgpN
YWtlIHNlbnNlLgoKCj4KPiBNYXliZSBJIHNob3VsZCBhZGQgYSBjb21tZW50IGluIHZyaW5naC5j
IHRvIGV4cGxhaW4gdGhpcyBiZXR0ZXIuCgoKWWVzLCBwbGVhc2UuCgpUaGFua3MKCgo+Cj4gVGhh
bmtzLAo+IFN0ZWZhbm8KPgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+IC0tLQo+Pj4gwqBkcml2ZXJz
L3Zob3N0L3ZyaW5naC5jIHwgNCArKy0tCj4+PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qv
dnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+PiBpbmRleCBmNjgxMjI3MDU3MTku
LmJlZTYzZDY4MjAxYSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPj4+
ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPj4+IEBAIC0yOTAsOSArMjkwLDkgQEAgX192
cmluZ2hfaW92KHN0cnVjdCB2cmluZ2ggKnZyaCwgdTE2IGksCj4+PiDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRUlOVkFMOwo+Pj4gwqDCoMKgwqAgaWYgKHJpb3YpCj4+PiAtwqDCoMKgwqDCoMKg
wqAgcmlvdi0+aSA9IHJpb3YtPnVzZWQgPSAwOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpb3YtPmkg
PSByaW92LT51c2VkID0gcmlvdi0+Y29uc3VtZWQgPSAwOwo+Pj4gwqDCoMKgwqAgaWYgKHdpb3Yp
Cj4+PiAtwqDCoMKgwqDCoMKgwqAgd2lvdi0+aSA9IHdpb3YtPnVzZWQgPSAwOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHdpb3YtPmkgPSB3aW92LT51c2VkID0gd2lvdi0+Y29uc3VtZWQgPSAwOwo+Pj4g
wqDCoMKgwqAgZm9yICg7Oykgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB2b2lkICphZGRyOwo+Pgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
