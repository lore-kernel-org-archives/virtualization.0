Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A0CC433ED
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 02:49:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E696113C
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 02:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E696113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1995C82ECF;
	Tue, 20 Apr 2021 02:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Xdk9S6vJrFJ; Tue, 20 Apr 2021 02:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD9F982D85;
	Tue, 20 Apr 2021 02:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A053CC000E;
	Tue, 20 Apr 2021 02:49:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0672BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E076B40394
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2hyplddZjPgM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:49:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35D0D40382
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618886970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+M/CVmWpN2JlBeA9vzyPmV1x08cJ5DnvfcIZr4tzGY=;
 b=HZRfiFU+RaLo6n6I6h0gCzZ3qLFtnPHHIoDu/peRL79gF1i6j1hWEKcAZt36dswmOyHFRh
 LWUbVwz70JVxbSpIBao/H/CfbcbfOKPg1hpoCCWglN6R25TGQ4j644KsF+KE5KGm3N+PqM
 Jm3wPn9x/uDjwnq+yizUkUkefOpw4MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-6MdklkFiMneEFHK8ZXKjaQ-1; Mon, 19 Apr 2021 22:49:28 -0400
X-MC-Unique: 6MdklkFiMneEFHK8ZXKjaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBD9A87A826;
 Tue, 20 Apr 2021 02:49:26 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-125.pek2.redhat.com
 [10.72.13.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A51B107D5C8;
 Tue, 20 Apr 2021 02:49:19 +0000 (UTC)
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: David Ahern <dsahern@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
 <ebaeb57a-924a-43e4-bd5f-e41ecce9ffe6@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fadc2cdb-f6bd-394a-3bcd-9f0eaebddf26@redhat.com>
Date: Tue, 20 Apr 2021 10:49:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ebaeb57a-924a-43e4-bd5f-e41ecce9ffe6@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIxLzQvMjAg5LiK5Y2IMTI6NDgsIERhdmlkIEFoZXJuIOWGmemBkzoKPiBPbiA0LzE2
LzIxIDI6MTYgQU0sIFh1YW4gWmh1byB3cm90ZToKPj4gSW4gcGFnZV90b19za2IoKSwgaWYgd2Ug
aGF2ZSBlbm91Z2ggdGFpbHJvb20gdG8gc2F2ZSBza2Jfc2hhcmVkX2luZm8sIHdlCj4+IGNhbiB1
c2UgYnVpbGRfc2tiIHRvIGNyZWF0ZSBza2IgZGlyZWN0bHkuIE5vIG5lZWQgdG8gYWxsb2MgZm9y
Cj4+IGFkZGl0aW9uYWwgc3BhY2UuIEFuZCBpdCBjYW4gc2F2ZSBhICdmcmFncyBzbG90Jywgd2hp
Y2ggaXMgdmVyeSBmcmllbmRseQo+PiB0byBHUk8uCj4+Cj4+IEhlcmUsIGlmIHRoZSBwYXlsb2Fk
IG9mIHRoZSByZWNlaXZlZCBwYWNrYWdlIGlzIHRvbyBzbWFsbCAobGVzcyB0aGFuCj4+IEdPT0Rf
Q09QWV9MRU4pLCB3ZSBzdGlsbCBjaG9vc2UgdG8gY29weSBpdCBkaXJlY3RseSB0byB0aGUgc3Bh
Y2UgZ290IGJ5Cj4+IG5hcGlfYWxsb2Nfc2tiLiBTbyB3ZSBjYW4gcmV1c2UgdGhlc2UgcGFnZXMu
Cj4+Cj4+IFRlc3RpbmcgTWFjaGluZToKPj4gICAgICBUaGUgZm91ciBxdWV1ZXMgb2YgdGhlIG5l
dHdvcmsgY2FyZCBhcmUgYm91bmQgdG8gdGhlIGNwdTEuCj4+Cj4+IFRlc3QgY29tbWFuZDoKPj4g
ICAgICBmb3IgKChpPTA7aTw1OysraSkpOyBkbyBzb2NrcGVyZiB0cCAtLWlwIDE5Mi4xNjguMTIy
LjY0IC1tIDEwMDAgLXQgMTUwJiBkb25lCj4+Cj4+IFRoZSBzaXplIG9mIHRoZSB1ZHAgcGFja2Fn
ZSBpcyAxMDAwLCBzbyBpbiB0aGUgY2FzZSBvZiB0aGlzIHBhdGNoLCB0aGVyZQo+PiB3aWxsIGFs
d2F5cyBiZSBlbm91Z2ggdGFpbHJvb20gdG8gdXNlIGJ1aWxkX3NrYi4gVGhlIHNlbnQgdWRwIHBh
Y2tldAo+PiB3aWxsIGJlIGRpc2NhcmRlZCBiZWNhdXNlIHRoZXJlIGlzIG5vIHBvcnQgdG8gcmVj
ZWl2ZSBpdC4gVGhlIGlycXNvZnRkCj4+IG9mIHRoZSBtYWNoaW5lIGlzIDEwMCUsIHdlIG9ic2Vy
dmUgdGhlIHJlY2VpdmVkIHF1YW50aXR5IGRpc3BsYXllZCBieQo+PiBzYXIgLW4gREVWIDE6Cj4+
Cj4+IG5vIGJ1aWxkX3NrYjogIDk1Njg2NC4wMCByeHBjay9zCj4+IGJ1aWxkX3NrYjogICAgMTE1
ODQ2NS4wMCByeHBjay9zCj4+Cj4gdmlydGlvX25ldCBpcyB1c2luZyBuYXBpX2NvbnN1bWVfc2ti
LCBzbyBuYXBpX2J1aWxkX3NrYiBzaG91bGQgc2hvdyBhCj4gc21hbGwgaW5jcmVhc2UgZnJvbSBi
dWlsZF9za2IuCj4KClllcyBhbmQgd2UgcHJvYmFibHkgbmVlZCB0byBkbyB0aGlzIGluIHJlY2Vp
dmVfc21hbGwoKS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
