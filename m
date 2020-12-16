Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E128C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 05:56:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305AA2333E
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 05:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305AA2333E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9ED022033E;
	Wed, 16 Dec 2020 05:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SPPyZ0PeBvj; Wed, 16 Dec 2020 05:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6914420414;
	Wed, 16 Dec 2020 05:56:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0AFC088E;
	Wed, 16 Dec 2020 05:56:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F3CCC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 05:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 552D220414
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 05:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lcsZMfp+G4dw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 05:56:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 131842033E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 05:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608098194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FqvnzyOC+7mLnS9oy1AAJEj1mGXM0+0Ror/7MkANS0=;
 b=ZlfmpDYcFLbbt6Lj4yWvhJp9ZWs45hIiZRu288ae4hTgbrS1lzLU8AakL0Z7fKe64E1ml9
 zFIHrC564HAQCwSIM6wCSvEnCqnUpVpoNSJLjglXruyX4qgJCAQukd5FDVd8Hq74s1Chlp
 fu83v5QkRfUEV4NblbyuNzGXwZ0JD20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-aW_0H7fbOZmrkY45sCqfgQ-1; Wed, 16 Dec 2020 00:56:32 -0500
X-MC-Unique: aW_0H7fbOZmrkY45sCqfgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43764801A9D;
 Wed, 16 Dec 2020 05:56:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3942E60C5E;
 Wed, 16 Dec 2020 05:56:31 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id ECF574BB40;
 Wed, 16 Dec 2020 05:56:30 +0000 (UTC)
Date: Wed, 16 Dec 2020 00:56:30 -0500 (EST)
From: Jason Wang <jasowang@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Message-ID: <205304638.36191504.1608098190622.JavaMail.zimbra@redhat.com>
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB82A73@DGGEMM533-MBX.china.huawei.com>
References: <cover.1608024547.git.wangyunjian@huawei.com>
 <4be47d3a325983f1bfc39f11f0e015767dd2aa3c.1608024547.git.wangyunjian@huawei.com>
 <e853a47e-b581-18d9-f13c-b449b176a308@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB82A73@DGGEMM533-MBX.china.huawei.com>
Subject: Re: [PATCH net 2/2] vhost_net: fix high cpu load when sendmsg fails
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.8]
Thread-Topic: [PATCH net 2/2] vhost_net: fix high cpu load when sendmsg fails
Thread-Index: AQHW0oRuvV7yNtzm006vlEv0Vf1dkan3BR2AgADGt5Bmnr+pAA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: willemdebruijn kernel <willemdebruijn.kernel@gmail.com>, mst@redhat.com,
 netdev@vger.kernel.org, "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gCj4gCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQo+ID4gRnJvbTogSmFzb24gV2FuZyBbbWFpbHRvOmphc293YW5nQHJlZGhhdC5j
b21dCj4gPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxNSwgMjAyMCAxMjoxMCBQTQo+ID4gVG86
IHdhbmd5dW5qaWFuIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsKPiA+IG1zdEByZWRoYXQuY29tOyB3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29t
Cj4gPiBDYzogdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExpbGlq
dW4gKEplcnJ5KQo+ID4gPGplcnJ5LmxpbGlqdW5AaHVhd2VpLmNvbT47IGNoZW5jaGFuZ2h1IDxj
aGVuY2hhbmdodUBodWF3ZWkuY29tPjsKPiA+IHh1ZGluZ2tlIDx4dWRpbmdrZUBodWF3ZWkuY29t
PjsgaHVhbmdiaW4gKEopCj4gPiA8YnJpYW4uaHVhbmdiaW5AaHVhd2VpLmNvbT4KPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggbmV0IDIvMl0gdmhvc3RfbmV0OiBmaXggaGlnaCBjcHUgbG9hZCB3aGVu
IHNlbmRtc2cKPiA+IGZhaWxzCj4gPiAKPiA+IAo+ID4gT24gMjAyMC8xMi8xNSDkuIrljYg5OjQ4
LCB3YW5neXVuamlhbiB3cm90ZToKPiA+ID4gRnJvbTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlh
bkBodWF3ZWkuY29tPgo+ID4gPgo+ID4gPiBDdXJyZW50bHkgd2UgYnJlYWsgdGhlIGxvb3AgYW5k
IHdha2UgdXAgdGhlIHZob3N0X3dvcmtlciB3aGVuIHNlbmRtc2cKPiA+ID4gZmFpbHMuIFdoZW4g
dGhlIHdvcmtlciB3YWtlcyB1cCBhZ2Fpbiwgd2UnbGwgbWVldCB0aGUgc2FtZSBlcnJvci4gVGhp
cwo+ID4gPiB3aWxsIGNhdXNlIGhpZ2ggQ1BVIGxvYWQuIFRvIGZpeCB0aGlzIGlzc3VlLCB3ZSBj
YW4gc2tpcCB0aGlzCj4gPiA+IGRlc2NyaXB0aW9uIGJ5IGlnbm9yaW5nIHRoZSBlcnJvci4gV2hl
biB3ZSBleGNlZWRzIHNuZGJ1ZiwgdGhlIHJldHVybgo+ID4gPiB2YWx1ZSBvZiBzZW5kbXNnIGlz
IC1FQUdBSU4uIEluIHRoZSBjYXNlIHdlIGRvbid0IHNraXAgdGhlIGRlc2NyaXB0aW9uCj4gPiA+
IGFuZCBkb24ndCBkcm9wIHBhY2tldC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVuamlh
biBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJz
L3Zob3N0L25ldC5jIHwgMjEgKysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gPiA+Cj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L25ldC5jIGIvZHJpdmVycy92aG9zdC9uZXQuYyBpbmRleAo+
ID4gPiBjODc4NGRmYWZkZDcuLmY5NjY1OTJkODkwMCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVy
cy92aG9zdC9uZXQuYwo+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gPiA+IEBAIC04
MjcsMTYgKzgyNywxMyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfY29weShzdHJ1Y3Qgdmhvc3Rf
bmV0ICpuZXQsCj4gPiBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+ID4gPiAgIAkJCQltc2cubXNnX2Zs
YWdzICY9IH5NU0dfTU9SRTsKPiA+ID4gICAJCX0KPiA+ID4KPiA+ID4gLQkJLyogVE9ETzogQ2hl
Y2sgc3BlY2lmaWMgZXJyb3IgYW5kIGJvbWIgb3V0IHVubGVzcyBFTk9CVUZTPyAqLwo+ID4gPiAg
IAkJZXJyID0gc29jay0+b3BzLT5zZW5kbXNnKHNvY2ssICZtc2csIGxlbik7Cj4gPiA+IC0JCWlm
ICh1bmxpa2VseShlcnIgPCAwKSkgewo+ID4gPiArCQlpZiAodW5saWtlbHkoZXJyID09IC1FQUdB
SU4pKSB7Cj4gPiA+ICAgCQkJdmhvc3RfZGlzY2FyZF92cV9kZXNjKHZxLCAxKTsKPiA+ID4gICAJ
CQl2aG9zdF9uZXRfZW5hYmxlX3ZxKG5ldCwgdnEpOwo+ID4gPiAgIAkJCWJyZWFrOwo+ID4gPiAt
CQl9Cj4gPiAKPiA+IAo+ID4gQXMgSSd2ZSBwb2ludGVkIG91dCBpbiBsYXN0IHZlcnNpb24uIElm
IHlvdSBkb24ndCBkaXNjYXJkIGRlc2NyaXB0b3IsIHlvdQo+ID4gcHJvYmFibHkKPiA+IG5lZWQg
dG8gYWRkIHRoZSBoZWFkIHRvIHVzZWQgcmluZy4gT3RoZXJ3aXNlIHRoaXMgZGVzY3JpcHRvciB3
aWxsIGJlIGFsd2F5cwo+ID4gaW5mbGlnaHQgdGhhdCBtYXkgY29uZnVzZSBkcml2ZXJzLgo+IAo+
IFNvcnJ5IGZvciBtaXNzaW5nIHRoZSBjb21tZW50Lgo+IAo+IEFmdGVyIGRlbGV0aW5nIGRpc2Nh
cmQgZGVzY3JpcHRvciBhbmQgYnJlYWssIHRoZSBuZXh0IHByb2Nlc3Npbmcgd2lsbCBiZSB0aGUK
PiBzYW1lCj4gYXMgdGhlIG5vcm1hbCBzdWNjZXNzIG9mIHNlbmRtc2coKSwgYW5kIHZob3N0X3pl
cm9jb3B5X3NpZ25hbF91c2VkKCkgb3IKPiB2aG9zdF9hZGRfdXNlZF9hbmRfc2lnbmFsKCkgbWV0
aG9kIHdpbGwgYmUgY2FsbGVkIHRvIGFkZCB0aGUgaGVhZCB0byB1c2VkCj4gcmluZy4KCkl0J3Mg
dGhlIG5leHQgaGVhZCBub3QgdGhlIG9uZSB0aGF0IGNvbnRhaW5zIHRoZSBidWdneSBwYWNrZXQ/
CgpUaGFua3MKCj4gCj4gVGhhbmtzCj4gPiAKPiA+IAo+ID4gPiAtCQlpZiAoZXJyICE9IGxlbikK
PiA+ID4gLQkJCXByX2RlYnVnKCJUcnVuY2F0ZWQgVFggcGFja2V0OiBsZW4gJWQgIT0gJXpkXG4i
LAo+ID4gPiAtCQkJCSBlcnIsIGxlbik7Cj4gPiA+ICsJCX0gZWxzZSBpZiAodW5saWtlbHkoZXJy
IDwgMCB8fCBlcnIgIT0gbGVuKSkKPiA+IAo+ID4gCj4gPiBJdCBsb29rcyB0byBtZSBlcnIgIT0g
bGVuIGNvdmVycyBlcnIgPCAwLgo+IAo+IE9LCj4gCj4gPiAKPiA+IFRoYW5rcwo+ID4gCj4gPiAK
PiA+ID4gKwkJCXZxX2Vycih2cSwgIkZhaWwgdG8gc2VuZGluZyBwYWNrZXRzIGVyciA6ICVkLCBs
ZW4gOiAlemRcbiIsIGVyciwKPiA+ID4gK2xlbik7Cj4gPiA+ICAgZG9uZToKPiA+ID4gICAJCXZx
LT5oZWFkc1tudnEtPmRvbmVfaWR4XS5pZCA9IGNwdV90b192aG9zdDMyKHZxLCBoZWFkKTsKPiA+
ID4gICAJCXZxLT5oZWFkc1tudnEtPmRvbmVfaWR4XS5sZW4gPSAwOwo+ID4gPiBAQCAtOTIyLDcg
KzkxOSw2IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShzdHJ1Y3Qgdmhvc3RfbmV0
Cj4gPiAqbmV0LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+ID4gPiAgIAkJCW1zZy5tc2dfZmxhZ3Mg
Jj0gfk1TR19NT1JFOwo+ID4gPiAgIAkJfQo+ID4gPgo+ID4gPiAtCQkvKiBUT0RPOiBDaGVjayBz
cGVjaWZpYyBlcnJvciBhbmQgYm9tYiBvdXQgdW5sZXNzIEVOT0JVRlM/ICovCj4gPiA+ICAgCQll
cnIgPSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywgJm1zZywgbGVuKTsKPiA+ID4gICAJCWlmICh1
bmxpa2VseShlcnIgPCAwKSkgewo+ID4gPiAgIAkJCWlmICh6Y29weV91c2VkKSB7Cj4gPiA+IEBA
IC05MzEsMTMgKzkyNywxNCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfemVyb2NvcHkoc3RydWN0
IHZob3N0X25ldAo+ID4gKm5ldCwgc3RydWN0IHNvY2tldCAqc29jaykKPiA+ID4gICAJCQkJbnZx
LT51cGVuZF9pZHggPSAoKHVuc2lnbmVkKW52cS0+dXBlbmRfaWR4IC0gMSkKPiA+ID4gICAJCQkJ
CSUgVUlPX01BWElPVjsKPiA+ID4gICAJCQl9Cj4gPiA+IC0JCQl2aG9zdF9kaXNjYXJkX3ZxX2Rl
c2ModnEsIDEpOwo+ID4gPiAtCQkJdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPiA+ID4g
LQkJCWJyZWFrOwo+ID4gPiArCQkJaWYgKGVyciA9PSAtRUFHQUlOKSB7Cj4gPiA+ICsJCQkJdmhv
c3RfZGlzY2FyZF92cV9kZXNjKHZxLCAxKTsKPiA+ID4gKwkJCQl2aG9zdF9uZXRfZW5hYmxlX3Zx
KG5ldCwgdnEpOwo+ID4gPiArCQkJCWJyZWFrOwo+ID4gPiArCQkJfQo+ID4gPiAgIAkJfQo+ID4g
PiAgIAkJaWYgKGVyciAhPSBsZW4pCj4gPiA+IC0JCQlwcl9kZWJ1ZygiVHJ1bmNhdGVkIFRYIHBh
Y2tldDogIgo+ID4gPiAtCQkJCSAiIGxlbiAlZCAhPSAlemRcbiIsIGVyciwgbGVuKTsKPiA+ID4g
KwkJCXZxX2Vycih2cSwgIkZhaWwgdG8gc2VuZGluZyBwYWNrZXRzIGVyciA6ICVkLCBsZW4gOiAl
emRcbiIsIGVyciwKPiA+ID4gK2xlbik7Cj4gPiA+ICAgCQlpZiAoIXpjb3B5X3VzZWQpCj4gPiA+
ICAgCQkJdmhvc3RfYWRkX3VzZWRfYW5kX3NpZ25hbCgmbmV0LT5kZXYsIHZxLCBoZWFkLCAwKTsK
PiA+ID4gICAJCWVsc2UKPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
