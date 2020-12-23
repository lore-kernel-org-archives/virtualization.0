Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D837C433DB
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 02:54:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2DD205CA
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 02:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2DD205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8777F203D0;
	Wed, 23 Dec 2020 02:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Um+hmuTjpT1X; Wed, 23 Dec 2020 02:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5769820345;
	Wed, 23 Dec 2020 02:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3492EC1825;
	Wed, 23 Dec 2020 02:54:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42A66C0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 02:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3DA6386844
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 02:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqPooUDzprRd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 02:54:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 53B0486843
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 02:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608692041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n00BcWMEg2A9HqhGHz8BATUpmDv8UaVW95nXP+Qgpw8=;
 b=MSojBjdFoESLx+MHT13zElnIf2IhyOcEhticnPkZXAGaO0QqNUXlhz4oMUJQG42YXUnDP6
 jtXUAwARaZ5yMaHNVMQe53nwNKfiHomNL6kJkglZ1pHHWf7U5ai7C+JDo55vVSGyn9M5MR
 zBSEZ2nS5bZhHMTucevqnvmP6gak5N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-y-15POxsO-W1zTRcOEfuZQ-1; Tue, 22 Dec 2020 21:53:57 -0500
X-MC-Unique: y-15POxsO-W1zTRcOEfuZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6382F107ACE3;
 Wed, 23 Dec 2020 02:53:55 +0000 (UTC)
Received: from [10.72.13.128] (ovpn-13-128.pek2.redhat.com [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8431510013C1;
 Wed, 23 Dec 2020 02:53:48 +0000 (UTC)
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
 <CAF=yD-K6EM3zfZtEh=305P4Z6ehO6TzfQC4cxp5+gHYrxEtXSg@mail.gmail.com>
 <acebdc23-7627-e170-cdfb-b7656c05e5c5@redhat.com>
 <CAF=yD-KCs5x1oX-02aDM=5JyLP=BaA7_Jg7Wxt3=JmK8JBnyiA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a309efb-0ea5-c40e-5564-b8900601da97@redhat.com>
Date: Wed, 23 Dec 2020 10:53:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-KCs5x1oX-02aDM=5JyLP=BaA7_Jg7Wxt3=JmK8JBnyiA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

Ck9uIDIwMjAvMTIvMjIg5LiL5Y2IMTA6MjQsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24g
TW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6NDEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIDIwMjAvMTIvMjIg5LiK5Y2INzowNywgV2lsbGVtIGRlIEJy
dWlqbiB3cm90ZToKPj4+IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDM6MjAgQU0gd2FuZ3l1bmpp
YW48d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4gIHdyb3RlOgo+Pj4+IEZyb206IFl1bmppYW4gV2Fu
Zzx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+Pj4+Cj4+Pj4gQ3VycmVudGx5IHdlIGJyZWFrIHRo
ZSBsb29wIGFuZCB3YWtlIHVwIHRoZSB2aG9zdF93b3JrZXIgd2hlbgo+Pj4+IHNlbmRtc2cgZmFp
bHMuIFdoZW4gdGhlIHdvcmtlciB3YWtlcyB1cCBhZ2Fpbiwgd2UnbGwgbWVldCB0aGUKPj4+PiBz
YW1lIGVycm9yLgo+Pj4gVGhlIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uIHRoYXQg
c3VjaCBlcnJvciBjYXNlcyBhbHdheXMKPj4+IHJldHVybiBFQUdBSU4uIENhbiBpdCBub3QgYWxz
byBiZSBFTk9NRU0sIHN1Y2ggYXMgZnJvbSB0dW5fYnVpbGRfc2tiPwo+Pj4KPj4+PiBUaGlzIHdp
bGwgY2F1c2UgaGlnaCBDUFUgbG9hZC4gVG8gZml4IHRoaXMgaXNzdWUsCj4+Pj4gd2UgY2FuIHNr
aXAgdGhpcyBkZXNjcmlwdGlvbiBieSBpZ25vcmluZyB0aGUgZXJyb3IuIFdoZW4gd2UKPj4+PiBl
eGNlZWRzIHNuZGJ1ZiwgdGhlIHJldHVybiB2YWx1ZSBvZiBzZW5kbXNnIGlzIC1FQUdBSU4uIElu
Cj4+Pj4gdGhlIGNhc2Ugd2UgZG9uJ3Qgc2tpcCB0aGUgZGVzY3JpcHRpb24gYW5kIGRvbid0IGRy
b3AgcGFja2V0Lgo+Pj4gdGhlIC0+IHRoYXQKPj4+Cj4+PiBoZXJlIGFuZCBhYm92ZTogZGVzY3Jp
cHRpb24gLT4gZGVzY3JpcHRvcgo+Pj4KPj4+IFBlcmhhcHMgc2xpZ2h0bHkgcmV2aXNlIHRvIG1v
cmUgZXhwbGljaXRseSBzdGF0ZSB0aGF0Cj4+Pgo+Pj4gMS4gaW4gdGhlIGNhc2Ugb2YgcGVyc2lz
dGVudCBmYWlsdXJlIChpLmUuLCBiYWQgcGFja2V0KSwgdGhlIGRyaXZlcgo+Pj4gZHJvcHMgdGhl
IHBhY2tldAo+Pj4gMi4gaW4gdGhlIGNhc2Ugb2YgdHJhbnNpZW50IGZhaWx1cmUgKGUuZywuIG1l
bW9yeSBwcmVzc3VyZSkgdGhlIGRyaXZlcgo+Pj4gc2NoZWR1bGVzIHRoZSB3b3JrZXIgdG8gdHJ5
IGFnYWluIGxhdGVyCj4+Cj4+IElmIHdlIHdhbnQgdG8gZ28gd2l0aCB0aGlzIHdheSwgd2UgbmVl
ZCBhIGJldHRlciB0aW1lIHRvIHdha2V1cCB0aGUKPj4gd29ya2VyLiBPdGhlcndpc2UgaXQganVz
dCBwcm9kdWNlcyBtb3JlIHN0cmVzcyBvbiB0aGUgY3B1IHRoYXQgaXMgd2hhdAo+PiB0aGlzIHBh
dGNoIHRyaWVzIHRvIGF2b2lkLgo+IFBlcmhhcHMgSSBtaXN1bmRlcnN0b29kIHRoZSBwdXJwb3Nl
IG9mIHRoZSBwYXRjaDogaXMgaXQgdG8gZHJvcAo+IGV2ZXJ5dGhpbmcsIHJlZ2FyZGxlc3Mgb2Yg
dHJhbnNpZW50IG9yIHBlcnNpc3RlbnQgZmFpbHVyZSwgdW50aWwgdGhlCj4gcmluZyBydW5zIG91
dCBvZiBkZXNjcmlwdG9ycz8KCgpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIG1haW4gbW90
aXZhdGlvbiBpcyB0byBhdm9pZCBoaWdoIGNwdSAKdXRpbGl6YXRpb24gd2hlbiBzZW5kbXNnKCkg
ZmFpbCBkdWUgdG8gZ3Vlc3QgcmVhc29uIChlLmcgYmFkIHBhY2tldCkuCgoKPgo+IEkgY2FuIHVu
ZGVyc3RhbmQgYm90aCBhIGJsb2NraW5nIGFuZCBkcm9wIHN0cmF0ZWd5IGR1cmluZyBtZW1vcnkK
PiBwcmVzc3VyZS4gQnV0IHBhcnRpYWwgZHJvcCBzdHJhdGVneSB1bnRpbCBleGNlZWRpbmcgcmlu
ZyBjYXBhY2l0eQo+IHNlZW1zIGxpa2UgYSBwZWN1bGlhciBoeWJyaWQ/CgoKWWVzLiBTbyBJIHdv
bmRlciBpZiB3ZSB3YW50IHRvIGJlIGRvIGJldHRlciB3aGVuIHdlIGFyZSBpbiB0aGUgbWVtb3J5
IApwcmVzc3VyZS4gRS5nIGNhbiB3ZSBsZXQgc29ja2V0IHdha2UgdXAgdXMgaW5zdGVhZCBvZiBy
ZXNjaGVkdWxpbmcgdGhlIAp3b3JrZXJzIGhlcmU/IEF0IGxlYXN0IGluIHRoaXMgY2FzZSB3ZSBr
bm93IHNvbWUgbWVtb3J5IG1pZ2h0IGJlIGZyZWVkPwoKVGhhbmtzCgoKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
