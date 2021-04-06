Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA55C433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 07:03:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93D5613AD
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 07:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93D5613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C8DC605CD;
	Tue,  6 Apr 2021 07:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBf9uYjHngUu; Tue,  6 Apr 2021 07:03:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B1D605A3;
	Tue,  6 Apr 2021 07:03:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25377C000C;
	Tue,  6 Apr 2021 07:03:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AFF8C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 07:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7090D40366
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 07:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWKvMLQgkgSH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 07:03:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87B91401CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 07:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617692627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxo6tmkvBefpqtp+AZkpyNAyaWzhV5s1Lu6jg16B4FI=;
 b=Xg7q1iPez05OFernKiHmjp0u1pIkjvmyIBWk5rLV2Oh3wxCoAV17qrngKiEpXd5i47TTN8
 Z84RsMiYwsWcPEC+R/f4oNEQcBGWxuDm/z50aUdxYOxkXb+8GYZbvltOkHdg2/n9ia9ZWc
 lCPzG/ebtIeHZwcgR9QgcGvdfcW7urk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-wrmH6CO3NNCD7xUsJyGbYw-1; Tue, 06 Apr 2021 03:03:43 -0400
X-MC-Unique: wrmH6CO3NNCD7xUsJyGbYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298171084D68;
 Tue,  6 Apr 2021 07:03:40 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-95.pek2.redhat.com
 [10.72.13.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF1195D6DC;
 Tue,  6 Apr 2021 07:03:30 +0000 (UTC)
Subject: Re: [PATCH net-next v3 7/8] virtio-net: poll tx call xsk zerocopy xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210331071139.15473-1-xuanzhuo@linux.alibaba.com>
 <20210331071139.15473-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f8631a22-c51a-f5ee-7130-a3cadf1a8b25@redhat.com>
Date: Tue, 6 Apr 2021 15:03:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331071139.15473-8-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
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

CtTaIDIwMjEvMy8zMSDPws7nMzoxMSwgWHVhbiBaaHVvINC0tcA6Cj4gcG9sbCB0eCBjYWxsIHZp
cnRuZXRfeHNrX3J1biwgdGhlbiB0aGUgZGF0YSBpbiB0aGUgeHNrIHR4IHF1ZXVlIHdpbGwgYmUK
PiBjb250aW51b3VzbHkgY29uc3VtZWQgYnkgbmFwaS4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IER1c3QgTGkg
PGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+CgoKSSB0aGluayB3ZSBuZWVkIHNxdWFzaCB0aGlz
IGludG8gcGF0Y2ggNCwgaXQgbG9va3MgbW9yZSBsaWtlIGEgYnVnIGZpeCAKdG8gbWUuCgoKPiAt
LS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIwICsrKysrKysrKysrKysrKysrLS0t
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBpbmRleCBkN2U5NWY1NTQ3OGQuLmZhYzdkMDAyMDAxMyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBAQCAtMjY0LDYgKzI2NCw5IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ICAgCWNo
YXIgcGFkZGluZ1s0XTsKPiAgIH07Cj4gICAKPiArc3RhdGljIGludCB2aXJ0bmV0X3hza19ydW4o
c3RydWN0IHNlbmRfcXVldWUgKnNxLCBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwKPiArCQkJ
ICAgaW50IGJ1ZGdldCwgYm9vbCBpbl9uYXBpKTsKPiArCj4gICBzdGF0aWMgYm9vbCBpc194ZHBf
ZnJhbWUodm9pZCAqcHRyKQo+ICAgewo+ICAgCXJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBW
SVJUSU9fWERQX0ZMQUc7Cj4gQEAgLTE1NTMsNyArMTU1Niw5IEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiAgIAlzdHJ1
Y3Qgc2VuZF9xdWV1ZSAqc3EgPSBjb250YWluZXJfb2YobmFwaSwgc3RydWN0IHNlbmRfcXVldWUs
IG5hcGkpOwo+ICAgCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gc3EtPnZxLT52ZGV2LT5wcml2
Owo+ICAgCXVuc2lnbmVkIGludCBpbmRleCA9IHZxMnR4cShzcS0+dnEpOwo+ICsJc3RydWN0IHhz
a19idWZmX3Bvb2wgKnBvb2w7Cj4gICAJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ICsJaW50
IHdvcmsgPSAwOwo+ICAgCj4gICAJaWYgKHVubGlrZWx5KGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVl
KHZpLCBpbmRleCkpKSB7Cj4gICAJCS8qIFdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIGNiIGZvciBY
RFAgKi8KPiBAQCAtMTU2MywxNSArMTU2OCwyNCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90
eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAKPiAgIAl0eHEgPSBu
ZXRkZXZfZ2V0X3R4X3F1ZXVlKHZpLT5kZXYsIGluZGV4KTsKPiAgIAlfX25ldGlmX3R4X2xvY2so
dHhxLCByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpKTsKPiAtCWZyZWVfb2xkX3htaXRfc2ticyhzcSwg
dHJ1ZSk7Cj4gKwlyY3VfcmVhZF9sb2NrKCk7Cj4gKwlwb29sID0gcmN1X2RlcmVmZXJlbmNlKHNx
LT54c2sucG9vbCk7Cj4gKwlpZiAocG9vbCkgewo+ICsJCXdvcmsgPSB2aXJ0bmV0X3hza19ydW4o
c3EsIHBvb2wsIGJ1ZGdldCwgdHJ1ZSk7Cj4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gKwl9IGVs
c2Ugewo+ICsJCXJjdV9yZWFkX3VubG9jaygpOwo+ICsJCWZyZWVfb2xkX3htaXRfc2ticyhzcSwg
dHJ1ZSk7Cj4gKwl9Cj4gICAJX19uZXRpZl90eF91bmxvY2sodHhxKTsKPiAgIAo+IC0JdmlydHF1
ZXVlX25hcGlfY29tcGxldGUobmFwaSwgc3EtPnZxLCAwKTsKPiArCWlmICh3b3JrIDwgYnVkZ2V0
KQo+ICsJCXZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKG5hcGksIHNxLT52cSwgMCk7Cj4gICAKPiAg
IAlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykKPiAgIAkJbmV0aWZf
dHhfd2FrZV9xdWV1ZSh0eHEpOwo+ICAgCj4gLQlyZXR1cm4gMDsKPiArCXJldHVybiB3b3JrOwoK
Ck5lZWQgYSBzZXBhcmF0ZSBwYXRjaCB0byAiZml4IiB0aGUgYnVkZ2V0IHJldHVybmVkIGJ5IHBv
bGxfdHggaGVyZS4KClRoYW5rcwoKCj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQgeG1pdF9za2Io
c3RydWN0IHNlbmRfcXVldWUgKnNxLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
