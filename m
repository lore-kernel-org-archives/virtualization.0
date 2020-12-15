Return-Path: <SRS0=Oc7+=FT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1702CC4361B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 04:10:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977852246B
	for <virtualization@archiver.kernel.org>; Tue, 15 Dec 2020 04:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977852246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 238D281BD7;
	Tue, 15 Dec 2020 04:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GRh_MtGYKaZ7; Tue, 15 Dec 2020 04:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C8D6850E1;
	Tue, 15 Dec 2020 04:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14493C0893;
	Tue, 15 Dec 2020 04:10:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47AE4C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 04:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4021620451
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 04:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1N9klm9kEA8i
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 04:10:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 298C42001C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 04:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608005403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eb9YqhAgwHZcpT5CFtnpmMMTLEY1Grfh6mkROQiid4M=;
 b=id/SDbe/lKqGLqz6t3GS5zJEn17El+f2fX3cu+XTJy8Zh3enZaW4ftEeN35sbYhnzOvkjA
 Taaz/jxIxYoeBE1CaJN0NDxTXBcvq8dyFI1QU4f+7B3QCsnjXCKBuYaNhawTVX2rMippIr
 ulGkbqW+0ctMZw8a6ra+AzCv03x172A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-rOfXLz7GN12DgVuiZC00-Q-1; Mon, 14 Dec 2020 23:10:01 -0500
X-MC-Unique: rOfXLz7GN12DgVuiZC00-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E68107ACE3;
 Tue, 15 Dec 2020 04:10:00 +0000 (UTC)
Received: from [10.72.13.123] (ovpn-13-123.pek2.redhat.com [10.72.13.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BA351002388;
 Tue, 15 Dec 2020 04:09:50 +0000 (UTC)
Subject: Re: [PATCH net 2/2] vhost_net: fix high cpu load when sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>, netdev@vger.kernel.org,
 mst@redhat.com, willemdebruijn.kernel@gmail.com
References: <cover.1608024547.git.wangyunjian@huawei.com>
 <4be47d3a325983f1bfc39f11f0e015767dd2aa3c.1608024547.git.wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e853a47e-b581-18d9-f13c-b449b176a308@redhat.com>
Date: Tue, 15 Dec 2020 12:09:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4be47d3a325983f1bfc39f11f0e015767dd2aa3c.1608024547.git.wangyunjian@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: xudingke@huawei.com, brian.huangbin@huawei.com, jerry.lilijun@huawei.com,
 chenchanghu@huawei.com, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMTUg5LiK5Y2IOTo0OCwgd2FuZ3l1bmppYW4gd3JvdGU6Cj4gRnJvbTogWXVu
amlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+Cj4gQ3VycmVudGx5IHdlIGJyZWFr
IHRoZSBsb29wIGFuZCB3YWtlIHVwIHRoZSB2aG9zdF93b3JrZXIgd2hlbgo+IHNlbmRtc2cgZmFp
bHMuIFdoZW4gdGhlIHdvcmtlciB3YWtlcyB1cCBhZ2Fpbiwgd2UnbGwgbWVldCB0aGUKPiBzYW1l
IGVycm9yLiBUaGlzIHdpbGwgY2F1c2UgaGlnaCBDUFUgbG9hZC4gVG8gZml4IHRoaXMgaXNzdWUs
Cj4gd2UgY2FuIHNraXAgdGhpcyBkZXNjcmlwdGlvbiBieSBpZ25vcmluZyB0aGUgZXJyb3IuIFdo
ZW4gd2UKPiBleGNlZWRzIHNuZGJ1ZiwgdGhlIHJldHVybiB2YWx1ZSBvZiBzZW5kbXNnIGlzIC1F
QUdBSU4uIEluCj4gdGhlIGNhc2Ugd2UgZG9uJ3Qgc2tpcCB0aGUgZGVzY3JpcHRpb24gYW5kIGRv
bid0IGRyb3AgcGFja2V0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWXVuamlhbiBXYW5nIDx3YW5neXVu
amlhbkBodWF3ZWkuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC9uZXQuYyB8IDIxICsrKysr
KysrKy0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9uZXQuYyBiL2RyaXZl
cnMvdmhvc3QvbmV0LmMKPiBpbmRleCBjODc4NGRmYWZkZDcuLmY5NjY1OTJkODkwMCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3Zob3N0L25ldC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+
IEBAIC04MjcsMTYgKzgyNywxMyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfY29weShzdHJ1Y3Qg
dmhvc3RfbmV0ICpuZXQsIHN0cnVjdCBzb2NrZXQgKnNvY2spCj4gICAJCQkJbXNnLm1zZ19mbGFn
cyAmPSB+TVNHX01PUkU7Cj4gICAJCX0KPiAgIAo+IC0JCS8qIFRPRE86IENoZWNrIHNwZWNpZmlj
IGVycm9yIGFuZCBib21iIG91dCB1bmxlc3MgRU5PQlVGUz8gKi8KPiAgIAkJZXJyID0gc29jay0+
b3BzLT5zZW5kbXNnKHNvY2ssICZtc2csIGxlbik7Cj4gLQkJaWYgKHVubGlrZWx5KGVyciA8IDAp
KSB7Cj4gKwkJaWYgKHVubGlrZWx5KGVyciA9PSAtRUFHQUlOKSkgewo+ICAgCQkJdmhvc3RfZGlz
Y2FyZF92cV9kZXNjKHZxLCAxKTsKPiAgIAkJCXZob3N0X25ldF9lbmFibGVfdnEobmV0LCB2cSk7
Cj4gICAJCQlicmVhazsKPiAtCQl9CgoKQXMgSSd2ZSBwb2ludGVkIG91dCBpbiBsYXN0IHZlcnNp
b24uIElmIHlvdSBkb24ndCBkaXNjYXJkIGRlc2NyaXB0b3IsIAp5b3UgcHJvYmFibHkgbmVlZCB0
byBhZGQgdGhlIGhlYWQgdG8gdXNlZCByaW5nLiBPdGhlcndpc2UgdGhpcyAKZGVzY3JpcHRvciB3
aWxsIGJlIGFsd2F5cyBpbmZsaWdodCB0aGF0IG1heSBjb25mdXNlIGRyaXZlcnMuCgoKPiAtCQlp
ZiAoZXJyICE9IGxlbikKPiAtCQkJcHJfZGVidWcoIlRydW5jYXRlZCBUWCBwYWNrZXQ6IGxlbiAl
ZCAhPSAlemRcbiIsCj4gLQkJCQkgZXJyLCBsZW4pOwo+ICsJCX0gZWxzZSBpZiAodW5saWtlbHko
ZXJyIDwgMCB8fCBlcnIgIT0gbGVuKSkKCgpJdCBsb29rcyB0byBtZSBlcnIgIT0gbGVuIGNvdmVy
cyBlcnIgPCAwLgoKVGhhbmtzCgoKPiArCQkJdnFfZXJyKHZxLCAiRmFpbCB0byBzZW5kaW5nIHBh
Y2tldHMgZXJyIDogJWQsIGxlbiA6ICV6ZFxuIiwgZXJyLCBsZW4pOwo+ICAgZG9uZToKPiAgIAkJ
dnEtPmhlYWRzW252cS0+ZG9uZV9pZHhdLmlkID0gY3B1X3RvX3Zob3N0MzIodnEsIGhlYWQpOwo+
ICAgCQl2cS0+aGVhZHNbbnZxLT5kb25lX2lkeF0ubGVuID0gMDsKPiBAQCAtOTIyLDcgKzkxOSw2
IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShzdHJ1Y3Qgdmhvc3RfbmV0ICpuZXQs
IHN0cnVjdCBzb2NrZXQgKnNvY2spCj4gICAJCQltc2cubXNnX2ZsYWdzICY9IH5NU0dfTU9SRTsK
PiAgIAkJfQo+ICAgCj4gLQkJLyogVE9ETzogQ2hlY2sgc3BlY2lmaWMgZXJyb3IgYW5kIGJvbWIg
b3V0IHVubGVzcyBFTk9CVUZTPyAqLwo+ICAgCQllcnIgPSBzb2NrLT5vcHMtPnNlbmRtc2coc29j
aywgJm1zZywgbGVuKTsKPiAgIAkJaWYgKHVubGlrZWx5KGVyciA8IDApKSB7Cj4gICAJCQlpZiAo
emNvcHlfdXNlZCkgewo+IEBAIC05MzEsMTMgKzkyNywxNCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVf
dHhfemVyb2NvcHkoc3RydWN0IHZob3N0X25ldCAqbmV0LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+
ICAgCQkJCW52cS0+dXBlbmRfaWR4ID0gKCh1bnNpZ25lZCludnEtPnVwZW5kX2lkeCAtIDEpCj4g
ICAJCQkJCSUgVUlPX01BWElPVjsKPiAgIAkJCX0KPiAtCQkJdmhvc3RfZGlzY2FyZF92cV9kZXNj
KHZxLCAxKTsKPiAtCQkJdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPiAtCQkJYnJlYWs7
Cj4gKwkJCWlmIChlcnIgPT0gLUVBR0FJTikgewo+ICsJCQkJdmhvc3RfZGlzY2FyZF92cV9kZXNj
KHZxLCAxKTsKPiArCQkJCXZob3N0X25ldF9lbmFibGVfdnEobmV0LCB2cSk7Cj4gKwkJCQlicmVh
azsKPiArCQkJfQo+ICAgCQl9Cj4gICAJCWlmIChlcnIgIT0gbGVuKQo+IC0JCQlwcl9kZWJ1Zygi
VHJ1bmNhdGVkIFRYIHBhY2tldDogIgo+IC0JCQkJICIgbGVuICVkICE9ICV6ZFxuIiwgZXJyLCBs
ZW4pOwo+ICsJCQl2cV9lcnIodnEsICJGYWlsIHRvIHNlbmRpbmcgcGFja2V0cyBlcnIgOiAlZCwg
bGVuIDogJXpkXG4iLCBlcnIsIGxlbik7Cj4gICAJCWlmICghemNvcHlfdXNlZCkKPiAgIAkJCXZo
b3N0X2FkZF91c2VkX2FuZF9zaWduYWwoJm5ldC0+ZGV2LCB2cSwgaGVhZCwgMCk7Cj4gICAJCWVs
c2UKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
