Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE30C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:23:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AFC207CF
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AFC207CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6A88086FB6;
	Wed, 20 Jan 2021 03:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q5Rv5m6wnpsM; Wed, 20 Jan 2021 03:23:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C13E186FB3;
	Wed, 20 Jan 2021 03:23:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA34AC088B;
	Wed, 20 Jan 2021 03:23:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF16C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C250866EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdMWSq-0StkV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F2DC85D21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611113003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p66laDTr1B6Q5naOwBpyBU0QwMyd3LCvYkkvKvp7/Zo=;
 b=PkbMSsrrDw90o0l1cIqsS36RQHTK31CRR4ngWiyybpLoAVObLdlV+/9lYwEVyMe0DIxNxl
 Y56k07TvS9WOw7lST438XrfSRT2UHu2uhc2cz3JrM+NLgfRdzKV6zbjvI65lGaCgzEHLU/
 KC+hmT05fST+qwefTOVA5lDDrLPrNV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-aRwCRJpnON6rqjOGrmUoaw-1; Tue, 19 Jan 2021 22:23:19 -0500
X-MC-Unique: aRwCRJpnON6rqjOGrmUoaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3D50806660;
 Wed, 20 Jan 2021 03:23:16 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B31027CAA;
 Wed, 20 Jan 2021 03:23:07 +0000 (UTC)
Subject: Re: [PATCH net-next v2 2/7] virtio-net, xsk: distinguish XDP_TX and
 XSK XMIT ctx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1610970895.0597434-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc6d27c7-6f00-4871-65d0-dffdcb2e1925@redhat.com>
Date: Wed, 20 Jan 2021 11:23:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610970895.0597434-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS8xOCDkuIvljYg3OjU0LCBYdWFuIFpodW8gd3JvdGU6Cj4gT24gTW9uLCAxOCBK
YW4gMjAyMSAxNDo0NToxNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IE9uIDIwMjEvMS8xNiDkuIrljYgxMDo1OSwgWHVhbiBaaHVvIHdyb3RlOgo+Pj4g
SWYgc3VwcG9ydCB4c2ssIGEgbmV3IHB0ciB3aWxsIGJlIHJlY292ZXJlZCBkdXJpbmcgdGhlCj4+
PiBwcm9jZXNzIG9mIGZyZWVpbmcgdGhlIG9sZCBwdHIuIEluIG9yZGVyIHRvIGRpc3Rpbmd1aXNo
IGJldHdlZW4gY3R4IHNlbnQKPj4+IGJ5IFhEUF9UWCBhbmQgY3R4IHNlbnQgYnkgeHNrLCBhIHN0
cnVjdCBpcyBhZGRlZCBoZXJlIHRvIGRpc3Rpbmd1aXNoCj4+PiBiZXR3ZWVuIHRoZXNlIHR3byBz
aXR1YXRpb25zLiB2aXJ0bmV0X3hkcF90eXBlLnR5cGUgSXQgaXMgdXNlZCB0bwo+Pj4gZGlzdGlu
Z3Vpc2ggZGlmZmVyZW50IGN0eCwgYW5kIHZpcnRuZXRfeGRwX3R5cGUub2Zmc2V0IGlzIHVzZWQg
dG8gcmVjb3JkCj4+PiB0aGUgb2Zmc2V0IGJldHdlZW4gInRydWUgY3R4IiBhbmQgdmlydG5ldF94
ZHBfdHlwZS4KPj4+Cj4+PiBUaGUgbmV3bHkgYWRkZWQgdmlydG5ldF94c2tfaGRyIHdpbGwgYmUg
dXNlZCBmb3IgeHNrLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+Cj4+Cj4+IEFueSByZWFzb24gdGhhdCB5b3UgY2FuJ3Qgc2ltcGx5
IGVuY29kZSB0aGUgdHlwZSBpbiB0aGUgcG9pbnRlciBpdHNlbGYKPj4gYXMgd2UgdXNlZCB0byBk
bz8KPj4KPj4gI2RlZmluZSBWSVJUSU9fWFNLX0ZMQUfCoMKgwqAgQklUKDEpCj4+Cj4+ID8KPiBT
aW5jZSB4ZHAgc29ja2V0IGRvZXMgbm90IHVzZSB4ZHBfZnJhbWUsIHdlIHdpbGwgZW5jb3VudGVy
IHRocmVlIGRhdGEgdHlwZXMgd2hlbgo+IHJlY3ljbGluZzogc2tiLCB4ZHBfZnJhbWUsIHhkcCBz
b2NrZXQuCgoKSnVzdCB0byBtYWtlIHN1cmUgd2UgYXJlIGluIHRoZSBzYW1lIHBhZ2UuIEN1cnJl
bnRseSwgdGhlIHBvaW50ZXIgdHlwZSAKaXMgZW5jb2RlZCB3aXRoIDEgYml0IGluIHRoZSBwb2lu
dGVyLiBDYW4gd2Ugc2ltcGx5IHVzZSAyIGJpdCB0byAKZGlzdGluZ3Vpc2ggc2tiLCB4ZHAsIHhz
az8KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
