Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6CAC433ED
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 01:22:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB1261402
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 01:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB1261402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58A0640510;
	Wed, 28 Apr 2021 01:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-KfNRv1sYgp; Wed, 28 Apr 2021 01:22:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02611404FE;
	Wed, 28 Apr 2021 01:22:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6079C0022;
	Wed, 28 Apr 2021 01:22:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 884F4C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 01:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6960E406B9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 01:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zPy-oGhOrqtM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 01:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEC33406B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 01:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619572931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbLyFvrjSQz5/gF7VPmuPuvoiHTk2IYn/Ev/WHTHBYQ=;
 b=euZHaneLrzGBQe/QDax5dQFTwPGB+T9a405tS9Gobc02s72QIkuh73koJr3iDEUfU3Epe7
 Y5J/7k9kocG3cIOvnq1FzCdJz0MVg+QBvXyVJaQ3VAXrsq3aBNemTzESiFzEBDdUAPFlMH
 U3JeVIHESMIo2B39eawHKpMxFRIj/0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-jeoyZHpOMtOeTZPv_7ZbPg-1; Tue, 27 Apr 2021 21:22:09 -0400
X-MC-Unique: jeoyZHpOMtOeTZPv_7ZbPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAD1C802950;
 Wed, 28 Apr 2021 01:22:07 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-64.pek2.redhat.com
 [10.72.13.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C49069FD0;
 Wed, 28 Apr 2021 01:21:59 +0000 (UTC)
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1619491565.7682261-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2d6b1c0b-7a3f-dbf4-785a-9af3c6000f98@redhat.com>
Date: Wed, 28 Apr 2021 09:21:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1619491565.7682261-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

CtTaIDIwMjEvNC8yNyDJz87nMTA6NDYsIFh1YW4gWmh1byDQtLXAOgo+IE9uIFR1ZSwgMjAgQXBy
IDIwMjEgMTA6NDE6MDMgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBCdHcsIHNpbmNlIHRoZSBwYXRjaCBtb2RpZmllcyBhIGNyaXRpY2FsIHBhdGgg
b2YgdmlydGlvLW5ldCBJIHN1Z2dlc3QgdG8KPj4gdGVzdCB0aGUgZm9sbG93aW5nIGNhc2VzOgo+
Pgo+PiAxKSBuZXRwZXJmIFRDUCBzdHJlYW0KPj4gMikgbmV0cGVyZiBVRFAgd2l0aCBwYWNrZXQg
c2l6ZSBmcm9tIDY0IHRvIFBBR0VfU0laRQo+PiAzKSBYRFBfUEFTUyB3aXRoIDEpCj4+IDQpIFhE
UF9QQVNTIHdpdGggMikKPj4gNSkgWERQIG1ldGFkYXRhIHdpdGggMSkKPj4gNikgWERQIG1ldGFk
YXRhIHdpdGggMikKPiBJIGhhdmUgY29tcGxldGVkIHRoZSBhYm92ZSB0ZXN0IG9uIHRoZSBsYXRl
c3QgbmV0LW5leHQgYnJhbmNoLiBUaGUgdGVzdGVkIHNjcmlwdAo+IGFuZCB4ZHAgY29kZSBhcmUg
YXMgZm9sbG93cy4gVGhlIGtlcm5lbCBpcyB3aXRoIEtDT1YgYW5kIGV2ZXJ5dGhpbmcgaXMgbm9y
bWFsCj4gd2l0aG91dCBleGNlcHRpb24uCj4KPiBUaGFua3MuCgoKTG9va3MgZ29vZC4KClRoYW5r
cyBmb3IgdGhlIHRlc3RpbmcuCgoKPgo+ICMjIHRlc3Qgc2NyaXB0Ogo+IAkjIS91c3IvYmluL2Vu
diBzaAo+Cj4KPiAJZm9yIHMgaW4gJChzZXEgNjQgNDA5NikKPiAJZG8KPiAJICAgIG5ldHBlcmYg
LUggMTkyLjE2OC4xMjIuMjAyICAtdCBVRFBfU1RSRUFNIC0tIC1tICRzCj4gCWRvbmUKPgo+IAlm
b3IgcyBpbiAkKHNlcSA2NCA0MDk2KQo+IAlkbwo+IAkgICAgbmV0cGVyZiAtSCAxOTIuMTY4LjEy
Mi4yMDIgIC10IFRDUF9TVFJFQU0gLS0gLW0gJHMKPiAJZG9uZQo+Cj4gIyMgeGRwIHBhc3M6Cj4K
PiAJI2RlZmluZSBLQlVJTERfTU9ETkFNRSAiZm9vIgo+IAkjaW5jbHVkZSA8bGludXgvYnBmLmg+
Cj4gCSNpbmNsdWRlIDxsaW51eC9pbi5oPgo+IAkjaW5jbHVkZSA8bGludXgvaWZfZXRoZXIuaD4K
PiAJI2luY2x1ZGUgPGxpbnV4L2lmX3BhY2tldC5oPgo+IAkjaW5jbHVkZSA8bGludXgvaWZfdmxh
bi5oPgo+IAkjaW5jbHVkZSA8bGludXgvaXAuaD4KPiAJI2luY2x1ZGUgPGxpbnV4L2ljbXAuaD4K
Pgo+IAkjZGVmaW5lIERFRkFVTFRfVFRMIDY0Cj4gCSNkZWZpbmUgTUFYX1BDS1RfU0laRSA2MDAK
PiAJI2RlZmluZSBJQ01QX1RPT0JJR19TSVpFIDk4Cj4gCSNkZWZpbmUgSUNNUF9UT09CSUdfUEFZ
TE9BRF9TSVpFIDkyCj4KPgo+IAkjZGVmaW5lIFNFQyhOQU1FKSBfX2F0dHJpYnV0ZV9fKChzZWN0
aW9uKE5BTUUpLCB1c2VkKSkKPgo+Cj4gCVNFQygieGRwIikKPiAJaW50IF94ZHAoc3RydWN0IHhk
cF9tZCAqeGRwKQo+IAl7Cj4gCSAgICAgICAgcmV0dXJuIFhEUF9QQVNTOwo+IAl9Cj4KPiAJY2hh
ciBfbGljZW5zZVtdIFNFQygibGljZW5zZSIpID0gIkdQTCI7Cj4KPiAjIyB4ZHAgbWV0YWRhdGE6
Cj4KPiAJI2RlZmluZSBLQlVJTERfTU9ETkFNRSAiZm9vIgo+IAkjaW5jbHVkZSA8bGludXgvYnBm
Lmg+Cj4gCSNpbmNsdWRlIDxsaW51eC9pbi5oPgo+IAkjaW5jbHVkZSA8bGludXgvaWZfZXRoZXIu
aD4KPiAJI2luY2x1ZGUgPGxpbnV4L2lmX3BhY2tldC5oPgo+IAkjaW5jbHVkZSA8bGludXgvaWZf
dmxhbi5oPgo+IAkjaW5jbHVkZSA8bGludXgvaXAuaD4KPiAJI2luY2x1ZGUgPGxpbnV4L2ljbXAu
aD4KPgo+IAlzdGF0aWMgbG9uZyAoKmJwZl94ZHBfYWRqdXN0X21ldGEpKHN0cnVjdCB4ZHBfbWQg
KnhkcF9tZCwgaW50IGRlbHRhKSA9ICh2b2lkICopIDU0Owo+Cj4KPiAJI2RlZmluZSBTRUMoTkFN
RSkgX19hdHRyaWJ1dGVfXygoc2VjdGlvbihOQU1FKSwgdXNlZCkpCj4KPiAJc3RydWN0IG1ldGFf
aW5mbyB7Cj4gCSAgICAgICAgX191MzIgbWFyazsKPiAJfSBfX2F0dHJpYnV0ZV9fKChhbGlnbmVk
KDQpKSk7Cj4KPiAJU0VDKCJ4ZHBfbWFyayIpCj4gCWludCBfeGRwX21hcmsoc3RydWN0IHhkcF9t
ZCAqY3R4KQo+IAl7Cj4gCSAgICAgICAgc3RydWN0IG1ldGFfaW5mbyAqbWV0YTsKPiAJICAgICAg
ICB2b2lkICpkYXRhLCAqZGF0YV9lbmQ7Cj4gCSAgICAgICAgaW50IHJldDsKPgo+IAkgICAgICAg
IC8qIFJlc2VydmUgc3BhY2UgaW4tZnJvbnQgb2YgZGF0YSBwb2ludGVyIGZvciBvdXIgbWV0YSBp
bmZvLgo+IAkgICAgICAgICAqIChOb3RpY2UgZHJpdmVycyBub3Qgc3VwcG9ydGluZyBkYXRhX21l
dGEgd2lsbCBmYWlsIGhlcmUhKQo+IAkgICAgICAgICAqLwo+IAkgICAgICAgIHJldCA9IGJwZl94
ZHBfYWRqdXN0X21ldGEoY3R4LCAtKGludClzaXplb2YoKm1ldGEpKTsKPiAJICAgICAgICBpZiAo
cmV0IDwgMCkKPiAJICAgICAgICAgICAgICAgIHJldHVybiBYRFBfQUJPUlRFRDsKPgo+IAkgICAg
ICAgIC8qIE5vdGljZTogS2VybmVsLXNpZGUgdmVyaWZpZXIgcmVxdWlyZXMgdGhhdCBsb2FkaW5n
IG9mCj4gCSAgICAgICAgICogY3R4LT5kYXRhIE1VU1QgaGFwcGVuIF9hZnRlcl8gaGVscGVyIGJw
Zl94ZHBfYWRqdXN0X21ldGEoKSwKPiAJICAgICAgICAgKiBhcyBwa3QtZGF0YSBwb2ludGVycyBh
cmUgaW52YWxpZGF0ZWQuICBIZWxwZXJzIHRoYXQgcmVxdWlyZQo+IAkgICAgICAgICAqIHRoaXMg
YXJlIGRldGVybWluZWQvbWFya2VkIGJ5IGJwZl9oZWxwZXJfY2hhbmdlc19wa3RfZGF0YSgpCj4g
CSAgICAgICAgICovCj4gCSAgICAgICAgZGF0YSA9ICh2b2lkICopKHVuc2lnbmVkIGxvbmcpY3R4
LT5kYXRhOwo+Cj4gCSAgICAgICAgLyogQ2hlY2sgZGF0YV9tZXRhIGhhdmUgcm9vbSBmb3IgbWV0
YV9pbmZvIHN0cnVjdCAqLwo+IAkgICAgICAgIG1ldGEgPSAodm9pZCAqKSh1bnNpZ25lZCBsb25n
KWN0eC0+ZGF0YV9tZXRhOwo+IAkgICAgICAgIGlmICgodm9pZCAqKShtZXRhICsgMSkgPiBkYXRh
KQo+IAkgICAgICAgICAgICAgICAgcmV0dXJuIFhEUF9BQk9SVEVEOwo+Cj4gCSAgICAgICAgbWV0
YS0+bWFyayA9IDQyOwo+Cj4gCSAgICAgICAgcmV0dXJuIFhEUF9QQVNTOwo+IAl9Cj4KPgo+IAlj
aGFyIF9saWNlbnNlW10gU0VDKCJsaWNlbnNlIikgPSAiR1BMIjsKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
