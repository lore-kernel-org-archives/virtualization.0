Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86616C433DB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 07:44:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101FF64DDB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 07:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101FF64DDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 854358664C;
	Fri, 29 Jan 2021 07:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PucYicSB5V9i; Fri, 29 Jan 2021 07:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C1679865D4;
	Fri, 29 Jan 2021 07:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFD07C08A1;
	Fri, 29 Jan 2021 07:43:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08EB7C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F1894869C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-NljAjMI1dW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:43:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9CD26869C0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611906235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdvP+XB+ujK4GwLPOzeUg9idInwSrrIU7VqOTnRaTYc=;
 b=DC6rBaLbegs9VTM64v2AwtVedNCV0mHliFawxR/aoavX5tV/DKtnbQV/uIu/0YD0Ich6dB
 kXUsfeHi9eNXN+FrGubDQzJIQk+Nhu/MZL/5BnsPSFAavp7ClKGkrPNNQgHGnZ6EKc6E65
 KnuhbSh92NAgvV69VKAcK8mDHkSsLeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-6hE_-NqCOc6xnv-fnGRljg-1; Fri, 29 Jan 2021 02:43:52 -0500
X-MC-Unique: 6hE_-NqCOc6xnv-fnGRljg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA3DD107ACFA;
 Fri, 29 Jan 2021 07:43:50 +0000 (UTC)
Received: from [10.72.14.10] (ovpn-14-10.pek2.redhat.com [10.72.14.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C0E371C8E;
 Fri, 29 Jan 2021 07:43:41 +0000 (UTC)
Subject: Re: [PATCH RFC v2 02/10] vringh: add 'iotlb_lock' to synchronize
 iotlb accesses
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <017f6e69-b2ec-aed0-5920-a389199e4cf9@redhat.com>
Date: Fri, 29 Jan 2021 15:43:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-3-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFVz
dWFsbHkgaW90bGIgYWNjZXNzZXMgYXJlIHN5bmNocm9uaXplZCB3aXRoIGEgc3BpbmxvY2suCj4g
TGV0J3MgcmVxdWVzdCBpdCBhcyBhIG5ldyBwYXJhbWV0ZXIgaW4gdnJpbmdoX3NldF9pb3RsYigp
IGFuZAo+IGhvbGQgaXQgd2hlbiB3ZSBuYXZpZ2F0ZSB0aGUgaW90bGIgaW4gaW90bGJfdHJhbnNs
YXRlKCkgdG8gYXZvaWQKPiByYWNlIGNvbmRpdGlvbnMgd2l0aCBhbnkgbmV3IGFkZGl0aW9ucy9k
ZWxldGlvbnMgb2YgcmFuZ2VzIGZyb20KPiB0aGUgaW9sdGIuCgoKUGF0Y2ggbG9va3MgZmluZSBi
dXQgSSB3b25kZXIgaWYgdGhpcyBpcyB0aGUgYmVzdCBhcHByb2FjaCBjb21wYXJpbmcgdG8gCmRv
IGxvY2tpbmcgYnkgdGhlIGNhbGxlci4KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gICBpbmNsdWRlL2xp
bnV4L3ZyaW5naC5oICAgICAgICAgICB8IDYgKysrKystCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW0uYyB8IDMgKystCj4gICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jICAgICAgICAg
ICB8IDkgKysrKysrKystCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92cmluZ2guaCBiL2lu
Y2x1ZGUvbGludXgvdnJpbmdoLmgKPiBpbmRleCA1OWJkNTBmOTkyOTEuLjljMDc3ODYzYzhmNiAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4gKysrIGIvaW5jbHVkZS9saW51
eC92cmluZ2guaAo+IEBAIC00Niw2ICs0Niw5IEBAIHN0cnVjdCB2cmluZ2ggewo+ICAgCS8qIElP
VExCIGZvciB0aGlzIHZyaW5nICovCj4gICAJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYjsKPiAg
IAo+ICsJLyogc3BpbmxvY2sgdG8gc3luY2hyb25pemUgSU9UTEIgYWNjZXNzZXMgKi8KPiArCXNw
aW5sb2NrX3QgKmlvdGxiX2xvY2s7Cj4gKwo+ICAgCS8qIFRoZSBmdW5jdGlvbiB0byBjYWxsIHRv
IG5vdGlmeSB0aGUgZ3Vlc3QgYWJvdXQgYWRkZWQgYnVmZmVycyAqLwo+ICAgCXZvaWQgKCpub3Rp
ZnkpKHN0cnVjdCB2cmluZ2ggKik7Cj4gICB9Owo+IEBAIC0yNTgsNyArMjYxLDggQEAgc3RhdGlj
IGlubGluZSBfX3ZpcnRpbzY0IGNwdV90b192cmluZ2g2NChjb25zdCBzdHJ1Y3QgdnJpbmdoICp2
cmgsIHU2NCB2YWwpCj4gICAKPiAgICNpZiBJU19SRUFDSEFCTEUoQ09ORklHX1ZIT1NUX0lPVExC
KQo+ICAgCj4gLXZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHN0cnVj
dCB2aG9zdF9pb3RsYiAqaW90bGIpOwo+ICt2b2lkIHZyaW5naF9zZXRfaW90bGIoc3RydWN0IHZy
aW5naCAqdnJoLCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+ICsJCSAgICAgIHNwaW5sb2Nr
X3QgKmlvdGxiX2xvY2spOwo+ICAgCj4gICBpbnQgdnJpbmdoX2luaXRfaW90bGIoc3RydWN0IHZy
aW5naCAqdnJoLCB1NjQgZmVhdHVyZXMsCj4gICAJCSAgICAgIHVuc2lnbmVkIGludCBudW0sIGJv
b2wgd2Vha19iYXJyaWVycywKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IDIxODNh
ODMzZmNmNC4uNTMyMzg5ODk3MTNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBA
QCAtMjg0LDcgKzI4NCw4IEBAIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3Qg
dmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIpCj4gICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCj4g
ICAJZm9yIChpID0gMDsgaSA8IGRldl9hdHRyLT5udnFzOyBpKyspCj4gLQkJdnJpbmdoX3NldF9p
b3RsYigmdmRwYXNpbS0+dnFzW2ldLnZyaW5nLCB2ZHBhc2ltLT5pb21tdSk7Cj4gKwkJdnJpbmdo
X3NldF9pb3RsYigmdmRwYXNpbS0+dnFzW2ldLnZyaW5nLCB2ZHBhc2ltLT5pb21tdSwKPiArCQkJ
CSAmdmRwYXNpbS0+aW9tbXVfbG9jayk7Cj4gICAKPiAgIAlyZXQgPSBpb3ZhX2NhY2hlX2dldCgp
Owo+ICAgCWlmIChyZXQpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9k
cml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gaW5kZXggODVkODVmYWJhMDU4Li5mNjgxMjI3MDU3MTkg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2guYwo+ICsrKyBiL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMKPiBAQCAtMTA3NCw2ICsxMDc0LDggQEAgc3RhdGljIGludCBpb3RsYl90cmFu
c2xhdGUoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJoLAo+ICAgCWludCByZXQgPSAwOwo+ICAgCXU2
NCBzID0gMDsKPiAgIAo+ICsJc3Bpbl9sb2NrKHZyaC0+aW90bGJfbG9jayk7Cj4gKwo+ICAgCXdo
aWxlIChsZW4gPiBzKSB7Cj4gICAJCXU2NCBzaXplLCBwYSwgcGZuOwo+ICAgCj4gQEAgLTExMDMs
NiArMTEwNSw4IEBAIHN0YXRpYyBpbnQgaW90bGJfdHJhbnNsYXRlKGNvbnN0IHN0cnVjdCB2cmlu
Z2ggKnZyaCwKPiAgIAkJKytyZXQ7Cj4gICAJfQo+ICAgCj4gKwlzcGluX3VubG9jayh2cmgtPmlv
dGxiX2xvY2spOwo+ICsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgCj4gQEAgLTEyNjIsMTAg
KzEyNjYsMTMgQEAgRVhQT1JUX1NZTUJPTCh2cmluZ2hfaW5pdF9pb3RsYik7Cj4gICAgKiB2cmlu
Z2hfc2V0X2lvdGxiIC0gaW5pdGlhbGl6ZSBhIHZyaW5naCBmb3IgYSByaW5nIHdpdGggSU9UTEIu
Cj4gICAgKiBAdnJoOiB0aGUgdnJpbmcKPiAgICAqIEBpb3RsYjogaW90bGIgYXNzb2NpYXRlZCB3
aXRoIHRoaXMgdnJpbmcKPiArICogQGlvdGxiX2xvY2s6IHNwaW5sb2NrIHRvIHN5bmNocm9uaXpl
IHRoZSBpb3RsYiBhY2Nlc3Nlcwo+ICAgICovCj4gLXZvaWQgdnJpbmdoX3NldF9pb3RsYihzdHJ1
Y3QgdnJpbmdoICp2cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4gK3ZvaWQgdnJpbmdo
X3NldF9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIs
Cj4gKwkJICAgICAgc3BpbmxvY2tfdCAqaW90bGJfbG9jaykKPiAgIHsKPiAgIAl2cmgtPmlvdGxi
ID0gaW90bGI7Cj4gKwl2cmgtPmlvdGxiX2xvY2sgPSBpb3RsYl9sb2NrOwo+ICAgfQo+ICAgRVhQ
T1JUX1NZTUJPTCh2cmluZ2hfc2V0X2lvdGxiKTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
