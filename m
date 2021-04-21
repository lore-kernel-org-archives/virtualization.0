Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F40C433B4
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 02:16:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BF461406
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 02:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BF461406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16E7240652;
	Wed, 21 Apr 2021 02:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hx2lOrzwgCb4; Wed, 21 Apr 2021 02:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AD5C4062A;
	Wed, 21 Apr 2021 02:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 080ADC000F;
	Wed, 21 Apr 2021 02:16:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AF9AC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3152F60AFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3jvW-M2hE2tG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BE65608BD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618971369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGr/qnvxYi2YAhXaRHoOb50iJM5aPIsNbPEVK2bwH+s=;
 b=L+yOF8yYDL1ZJXrqTP43j5nz9IGUqb+PdLQcK9J6XxvxNryfEX99kDl82s9u1qkqAwwW+Z
 5GOEmVV+Q0ad1SbfhRtmojY+mOY0r/aObGIRnYuxITiptyb7CphStGq3Ouep/GS/sUMtea
 o4R68uQSwr5hxzDkZXHLlUQ64UI5/LY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-WvnCbF-eO5iUlx5b1dMO6g-1; Tue, 20 Apr 2021 22:16:05 -0400
X-MC-Unique: WvnCbF-eO5iUlx5b1dMO6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E091882FD8;
 Wed, 21 Apr 2021 02:16:03 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-189.pek2.redhat.com
 [10.72.13.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 959A85C1A1;
 Wed, 21 Apr 2021 02:15:55 +0000 (UTC)
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in page_to_skb()
To: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20210420094341.3259328-1-eric.dumazet@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3224f3bb-ab26-0106-ea61-9a1e2fe49a57@redhat.com>
Date: Wed, 21 Apr 2021 10:15:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210420094341.3259328-1-eric.dumazet@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 syzbot <syzkaller@googlegroups.com>, Guenter Roeck <linux@roeck-us.net>
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

CtTaIDIwMjEvNC8yMCDPws7nNTo0MywgRXJpYyBEdW1hemV0INC0tcA6Cj4gRnJvbTogRXJpYyBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgo+Cj4gS0FTQU4vc3l6Ym90IGhhZCA0IHJlcG9y
dHMsIG9uZSBvZiB0aGVtIGJlaW5nOgo+Cj4gQlVHOiBLQVNBTjogc2xhYi1vdXQtb2YtYm91bmRz
IGluIG1lbWNweSBpbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6MTkxIFtpbmxpbmVdCj4g
QlVHOiBLQVNBTjogc2xhYi1vdXQtb2YtYm91bmRzIGluIHBhZ2VfdG9fc2tiKzB4NWNmLzB4Yjcw
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo0ODAKPiBSZWFkIG9mIHNpemUgMTIgYXQgYWRkciBm
ZmZmODg4MDE0YTVmODAwIGJ5IHRhc2sgc3lzdGVtZC11ZGV2ZC84NDQ1Cj4KPiBDUFU6IDAgUElE
OiA4NDQ1IENvbW06IHN5c3RlbWQtdWRldmQgTm90IHRhaW50ZWQgNS4xMi4wLXJjOC1uZXh0LTIw
MjEwNDE5LXN5emthbGxlciAjMAo+IEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29nbGUgQ29tcHV0
ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2dsZSAwMS8wMS8yMDExCj4g
Q2FsbCBUcmFjZToKPiAgIDxJUlE+Cj4gICBfX2R1bXBfc3RhY2sgbGliL2R1bXBfc3RhY2suYzo3
OSBbaW5saW5lXQo+ICAgZHVtcF9zdGFjaysweDE0MS8weDFkNyBsaWIvZHVtcF9zdGFjay5jOjEy
MAo+ICAgcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMC5jb2xkKzB4NWIvMHgy
ZjggbW0va2FzYW4vcmVwb3J0LmM6MjMzCj4gICBfX2thc2FuX3JlcG9ydCBtbS9rYXNhbi9yZXBv
cnQuYzo0MTkgW2lubGluZV0KPiAgIGthc2FuX3JlcG9ydC5jb2xkKzB4N2MvMHhkOCBtbS9rYXNh
bi9yZXBvcnQuYzo0MzYKPiAgIGNoZWNrX3JlZ2lvbl9pbmxpbmUgbW0va2FzYW4vZ2VuZXJpYy5j
OjE4MCBbaW5saW5lXQo+ICAga2FzYW5fY2hlY2tfcmFuZ2UrMHgxM2QvMHgxODAgbW0va2FzYW4v
Z2VuZXJpYy5jOjE4Ngo+ICAgbWVtY3B5KzB4MjAvMHg2MCBtbS9rYXNhbi9zaGFkb3cuYzo2NQo+
ICAgbWVtY3B5IGluY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJpbmcuaDoxOTEgW2lubGluZV0KPiAg
IHBhZ2VfdG9fc2tiKzB4NWNmLzB4YjcwIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo0ODAKPiAg
IHJlY2VpdmVfbWVyZ2VhYmxlIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxMDA5IFtpbmxpbmVd
Cj4gICByZWNlaXZlX2J1ZisweDJiYzAvMHg2MjUwIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzox
MTE5Cj4gICB2aXJ0bmV0X3JlY2VpdmUgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjE0MTEgW2lu
bGluZV0KPiAgIHZpcnRuZXRfcG9sbCsweDU2OC8weDEwYjAgZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jOjE1MTYKPiAgIF9fbmFwaV9wb2xsKzB4YWYvMHg0NDAgbmV0L2NvcmUvZGV2LmM6Njk2Mgo+
ICAgbmFwaV9wb2xsIG5ldC9jb3JlL2Rldi5jOjcwMjkgW2lubGluZV0KPiAgIG5ldF9yeF9hY3Rp
b24rMHg4MDEvMHhiNDAgbmV0L2NvcmUvZGV2LmM6NzExNgo+ICAgX19kb19zb2Z0aXJxKzB4Mjli
LzB4OWZlIGtlcm5lbC9zb2Z0aXJxLmM6NTU5Cj4gICBpbnZva2Vfc29mdGlycSBrZXJuZWwvc29m
dGlycS5jOjQzMyBbaW5saW5lXQo+ICAgX19pcnFfZXhpdF9yY3UrMHgxMzYvMHgyMDAga2VybmVs
L3NvZnRpcnEuYzo2MzcKPiAgIGlycV9leGl0X3JjdSsweDUvMHgyMCBrZXJuZWwvc29mdGlycS5j
OjY0OQo+ICAgY29tbW9uX2ludGVycnVwdCsweGE0LzB4ZDAgYXJjaC94ODYva2VybmVsL2lycS5j
OjI0MAo+Cj4gRml4ZXM6IGZiMzI4NTZiMTZhZCAoInZpcnRpby1uZXQ6IHBhZ2VfdG9fc2tiKCkg
dXNlIGJ1aWxkX3NrYiB3aGVuIHRoZXJlJ3Mgc3VmZmljaWVudCB0YWlscm9vbSIpCj4gU2lnbmVk
LW9mZi1ieTogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgo+IFJlcG9ydGVkLWJ5
OiBzeXpib3QgPHN5emthbGxlckBnb29nbGVncm91cHMuY29tPgo+IFJlcG9ydGVkLWJ5OiBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Cj4gUmVwb3J0ZWQtYnk6IE1hdCBNYXJ0aW5l
YXUgPG1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20+Cj4gQ2M6IFh1YW4gWmh1byA8
eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4gQ2M6ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4KPiBD
YzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiAtLS0KCgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIHwgNSArKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDhjZDc2MDM3YzcyNDgxMjAwZWEz
ZTg0MjllOWZkZmVjMDA1ZGFkODUuLjJlMjhjMDRhYTYzNTFkMmI0MDE2ZjdkMjc3Y2UxMDRjNDk3
MDA2OWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTM4NSw2ICszODUsNyBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCXN0cnVj
dCBza19idWZmICpza2I7Cj4gICAJc3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19yeGJ1ZiAqaGRy
Owo+ICAgCXVuc2lnbmVkIGludCBjb3B5LCBoZHJfbGVuLCBoZHJfcGFkZGVkX2xlbjsKPiArCXN0
cnVjdCBwYWdlICpwYWdlX3RvX2ZyZWUgPSBOVUxMOwo+ICAgCWludCB0YWlscm9vbSwgc2hpbmZv
X3NpemU7Cj4gICAJY2hhciAqcCwgKmhkcl9wOwo+ICAgCj4gQEAgLTQ0NSw3ICs0NDYsNyBAQCBz
dGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LAo+ICAgCQlpZiAobGVuKQo+ICAgCQkJc2tiX2FkZF9yeF9mcmFnKHNrYiwgMCwgcGFnZSwgb2Zm
c2V0LCBsZW4sIHRydWVzaXplKTsKPiAgIAkJZWxzZQo+IC0JCQlwdXRfcGFnZShwYWdlKTsKPiAr
CQkJcGFnZV90b19mcmVlID0gcGFnZTsKPiAgIAkJZ290byBvazsKPiAgIAl9Cj4gICAKPiBAQCAt
NDc5LDYgKzQ4MCw4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCWhkciA9IHNrYl92bmV0X2hkcihza2IpOwo+ICAgCQlt
ZW1jcHkoaGRyLCBoZHJfcCwgaGRyX2xlbik7Cj4gICAJfQo+ICsJaWYgKHBhZ2VfdG9fZnJlZSkK
PiArCQlwdXRfcGFnZShwYWdlX3RvX2ZyZWUpOwo+ICAgCj4gICAJaWYgKG1ldGFzaXplKSB7Cj4g
ICAJCV9fc2tiX3B1bGwoc2tiLCBtZXRhc2l6ZSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
