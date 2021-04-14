Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40338C433ED
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 03:34:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE39613BB
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 03:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE39613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64D0D404B7;
	Wed, 14 Apr 2021 03:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dWm5l5TAZO9G; Wed, 14 Apr 2021 03:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCDD140370;
	Wed, 14 Apr 2021 03:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E28FC000B;
	Wed, 14 Apr 2021 03:34:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32D86C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C2C383DE6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6LO19ZIWyaJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:34:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 460AC83BD6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618371263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLfRM/TFiz4bH/Fuoa5M4fK7KllTM/752Rs7vsgn1IA=;
 b=DADUx0a7WsyGOwWzSxo6Qg+GJyLjN/uwfIKg8qLhjGRHrPsot3VJSzNmW8SCOgKhjQpPBt
 Y1uH0YagOaJm9CugwO0AEgH9zZpIY+ExfaBgNvTQThpILKRw5SKhjMDswUQfC/tk0yIB5i
 M/+NZCilcq+SSFm5ojd+Z9/IulCkai8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-UM4ytrdeP_6nttRSXdU59Q-1; Tue, 13 Apr 2021 23:34:19 -0400
X-MC-Unique: UM4ytrdeP_6nttRSXdU59Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C0A0192AB70;
 Wed, 14 Apr 2021 03:34:17 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 470F5710A6;
 Wed, 14 Apr 2021 03:34:09 +0000 (UTC)
Subject: Re: [PATCH net-next v4 07/10] virtio-net: virtnet_poll_tx support
 budget check
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210413031523.73507-1-xuanzhuo@linux.alibaba.com>
 <20210413031523.73507-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ad27f0b5-713f-f6f3-ba51-0468db9897ca@redhat.com>
Date: Wed, 14 Apr 2021 11:34:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413031523.73507-8-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xMyDJz87nMTE6MTUsIFh1YW4gWmh1byDQtLXAOgo+IHZpcnRuZXRfcG9sbF90
eCgpIGNoZWNrIHRoZSB3b3JrIGRvbmUgbGlrZSBvdGhlciBuZXR3b3JrIGNhcmQgZHJpdmVycy4K
Pgo+IFdoZW4gd29yayA8IGJ1ZGdldCwgbmFwaV9wb2xsKCkgaW4gZGV2LmMgd2lsbCBleGl0IGRp
cmVjdGx5LiBBbmQKPiB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZSgpIHdpbGwgYmUgY2FsbGVkIHRv
IGNsb3NlIG5hcGkuIElmIGNsb3NpbmcgbmFwaQo+IGZhaWxzIG9yIHRoZXJlIGlzIHN0aWxsIGRh
dGEgdG8gYmUgcHJvY2Vzc2VkLCB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZSgpCj4gd2lsbCBtYWtl
IG5hcGkgc2NoZWR1bGUgYWdhaW4sIGFuZCBubyBjb25mbGljdHMgd2l0aCB0aGUgbG9naWMgb2YK
PiBuYXBpX3BvbGwoKS4KPgo+IFdoZW4gd29yayA9PSBidWRnZXQsIHZpcnRuZXRfcG9sbF90eCgp
IHdpbGwgcmV0dXJuIHRoZSB2YXIgJ3dvcmsnLCBhbmQKPiB0aGUgbmFwaV9wb2xsKCkgaW4gZGV2
LmMgd2lsbCByZS1hZGQgbmFwaSB0byB0aGUgcXVldWUuCj4KPiBUaGUgcHVycG9zZSBvZiB0aGlz
IHBhdGNoIGlzIHRvIHN1cHBvcnQgeHNrIHhtaXQgaW4gdmlydGlvX3BvbGxfdHggZm9yCj4gc3Vi
c2VxdWVudCBwYXRjaC4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDYgKysrKy0tCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+IGluZGV4IGYzNzUyYjI1NDk2NS4uZjUyYTI1MDkxMzIyIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBA
IC0xNTI5LDYgKzE1MjksNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFw
aV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkg
PSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4gICAJdW5zaWduZWQgaW50IGluZGV4ID0gdnEydHhxKHNx
LT52cSk7Cj4gICAJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ICsJaW50IHdvcmtfZG9uZSA9
IDA7Cj4gICAKPiAgIAlpZiAodW5saWtlbHkoaXNfeGRwX3Jhd19idWZmZXJfcXVldWUodmksIGlu
ZGV4KSkpIHsKPiAgIAkJLyogV2UgZG9uJ3QgbmVlZCB0byBlbmFibGUgY2IgZm9yIFhEUCAqLwo+
IEBAIC0xNTQxLDEyICsxNTQyLDEzIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVj
dCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiAgIAlmcmVlX29sZF94bWl0KHNxLCB0
cnVlKTsKPiAgIAlfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ICAgCj4gLQl2aXJ0cXVldWVfbmFw
aV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+ICsJaWYgKHdvcmtfZG9uZSA8IGJ1ZGdldCkK
PiArCQl2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+ICAgCj4gICAJ
aWYgKHNxLT52cS0+bnVtX2ZyZWUgPj0gMiArIE1BWF9TS0JfRlJBR1MpCj4gICAJCW5ldGlmX3R4
X3dha2VfcXVldWUodHhxKTsKPiAgIAo+IC0JcmV0dXJuIDA7Cj4gKwlyZXR1cm4gd29ya19kb25l
Owo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW50IHhtaXRfc2tiKHN0cnVjdCBzZW5kX3F1ZXVlICpz
cSwgc3RydWN0IHNrX2J1ZmYgKnNrYikKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
