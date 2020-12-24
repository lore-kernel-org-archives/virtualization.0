Return-Path: <SRS0=rM6z=F4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3817C433E0
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 05:56:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BFA229CA
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 05:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BFA229CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8014B85FDB;
	Thu, 24 Dec 2020 05:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1AXUG_9EQZgZ; Thu, 24 Dec 2020 05:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4CDC885ABF;
	Thu, 24 Dec 2020 05:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32161C1787;
	Thu, 24 Dec 2020 05:56:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0F53C0893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 05:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A23218691D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 05:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O539ALVuwZ1h
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 05:56:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA9128691A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 05:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608789385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWPr/JJTfRTm5p5WCHDxnGzwlW39vVczjU0f0pHL4FM=;
 b=iYLFBBbQeH02lfe2I3dGvlpVL8FzWlnl7BwhHj5xKzspFDneMMrlKGNAsks/IA50luLncE
 X4t37HgPd3esbf+k/Zhk+ygeZANy+FnD+nTdZZ/3IpkYR52PBSBieA5MkliW8NSyAXF6r1
 UgDCbCrpX/dgseZCXgpUIBk3RuYh1LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-TQAg_WrzOcWzQS4VZyJ-SQ-1; Thu, 24 Dec 2020 00:56:21 -0500
X-MC-Unique: TQAg_WrzOcWzQS4VZyJ-SQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88F07107ACE8;
 Thu, 24 Dec 2020 05:56:19 +0000 (UTC)
Received: from [10.72.13.109] (ovpn-13-109.pek2.redhat.com [10.72.13.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5561F056;
 Thu, 24 Dec 2020 05:56:07 +0000 (UTC)
Subject: Re: [PATCH net v4 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
To: wangyunjian <wangyunjian@huawei.com>
References: <1608776746-4040-1-git-send-email-wangyunjian@huawei.com>
 <c854850b-43ab-c98d-a4d8-36ad7cd6364c@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB8ED23@DGGEMM533-MBX.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <823a1558-70fb-386d-fd28-d0c9bdbe9dac@redhat.com>
Date: Thu, 24 Dec 2020 13:56:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB8ED23@DGGEMM533-MBX.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>,
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

Ck9uIDIwMjAvMTIvMjQg5LiL5Y2IMTI6MzcsIHdhbmd5dW5qaWFuIHdyb3RlOgo+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdA
cmVkaGF0LmNvbV0KPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDI0LCAyMDIwIDExOjEwIEFN
Cj4+IFRvOiB3YW5neXVuamlhbiA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT47IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7Cj4+IG1zdEByZWRoYXQuY29tOyB3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21h
aWwuY29tCj4+IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsg
TGlsaWp1biAoSmVycnkpCj4+IDxqZXJyeS5saWxpanVuQGh1YXdlaS5jb20+OyBjaGVuY2hhbmdo
dSA8Y2hlbmNoYW5naHVAaHVhd2VpLmNvbT47Cj4+IHh1ZGluZ2tlIDx4dWRpbmdrZUBodWF3ZWku
Y29tPjsgaHVhbmdiaW4gKEopCj4+IDxicmlhbi5odWFuZ2JpbkBodWF3ZWkuY29tPgo+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIG5ldCB2NCAyLzJdIHZob3N0X25ldDogZml4IHR4IHF1ZXVlIHN0dWNr
IHdoZW4gc2VuZG1zZwo+PiBmYWlscwo+Pgo+Pgo+PiBPbiAyMDIwLzEyLzI0IOS4iuWNiDEwOjI1
LCB3YW5neXVuamlhbiB3cm90ZToKPj4+IEZyb206IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5A
aHVhd2VpLmNvbT4KPj4+Cj4+PiBDdXJyZW50bHkgdGhlIGRyaXZlciBkb2Vzbid0IGRyb3AgYSBw
YWNrZXQgd2hpY2ggY2FuJ3QgYmUgc2VudCBieSB0dW4KPj4+IChlLmcgYmFkIHBhY2tldCkuIElu
IHRoaXMgY2FzZSwgdGhlIGRyaXZlciB3aWxsIGFsd2F5cyBwcm9jZXNzIHRoZQo+Pj4gc2FtZSBw
YWNrZXQgbGVhZCB0byB0aGUgdHggcXVldWUgc3R1Y2suCj4+Pgo+Pj4gVG8gZml4IHRoaXMgaXNz
dWU6Cj4+PiAxLiBpbiB0aGUgY2FzZSBvZiBwZXJzaXN0ZW50IGZhaWx1cmUgKGUuZyBiYWQgcGFj
a2V0KSwgdGhlIGRyaXZlciBjYW4KPj4+IHNraXAgdGhpcyBkZXNjcmlwdG9yIGJ5IGlnbm9yaW5n
IHRoZSBlcnJvci4KPj4+IDIuIGluIHRoZSBjYXNlIG9mIHRyYW5zaWVudCBmYWlsdXJlIChlLmcg
LUVBR0FJTiBhbmQgLUVOT01FTSksIHRoZQo+Pj4gZHJpdmVyIHNjaGVkdWxlcyB0aGUgd29ya2Vy
IHRvIHRyeSBhZ2Fpbi4KPj4KPj4gSSBtaWdodCBiZSB3cm9uZyBidXQgbG9va2luZyBhdCBhbGxv
Y19za2Jfd2l0aF9mcmFncygpLCBpdCByZXR1cm5zIC1FTk9CVUZTCj4+IGFjdHVhbGx5Ogo+Pgo+
PiAgIMKgwqDCoCAqZXJyY29kZSA9IC1FTk9CVUZTOwo+PiAgIMKgwqDCoCBza2IgPSBhbGxvY19z
a2IoaGVhZGVyX2xlbiwgZ2ZwX21hc2spOwo+PiAgIMKgwqDCoCBpZiAoIXNrYikKPj4gICDCoMKg
wqAgwqDCoMKgIHJldHVybiBOVUxMOwo+IFllcywgYnV0IHRoZSBzb2NrX2FsbG9jX3NlbmRfcHNr
YigpIHJldHVybnMgLSBFQUdBSU4gd2hlbiBubyBzbmRidWYgc3BhY2UuCj4gU28gdGhlcmUgaXMg
bmVlZCB0byBjaGVjayByZXR1cm4gdmFsdWUgd2hpY2ggaXMgLUVBR0FJTiBvciAtRU5PTUVNIG9y
IC0gRUFHQUlOPwo+Cj4gc3RydWN0IHNrX2J1ZmYgKnNvY2tfYWxsb2Nfc2VuZF9wc2tiKCkKPiB7
Cj4gLi4uCj4gCWZvciAoOzspIHsKPiAuLi4KPiAJCXNrX3NldF9iaXQoU09DS1dRX0FTWU5DX05P
U1BBQ0UsIHNrKTsKPiAJCXNldF9iaXQoU09DS19OT1NQQUNFLCAmc2stPnNrX3NvY2tldC0+Zmxh
Z3MpOwo+IAkJZXJyID0gLUVBR0FJTjsKPiAJCWlmICghdGltZW8pCj4gCQkJZ290byBmYWlsdXJl
Owo+IC4uLgo+IAl9Cj4gCXNrYiA9IGFsbG9jX3NrYl93aXRoX2ZyYWdzKGhlYWRlcl9sZW4sIGRh
dGFfbGVuLCBtYXhfcGFnZV9vcmRlciwKPiAJCQkJICAgZXJyY29kZSwgc2stPnNrX2FsbG9jYXRp
b24pOwo+IAlpZiAoc2tiKQo+IAkJc2tiX3NldF9vd25lcl93KHNrYiwgc2spOwo+IAlyZXR1cm4g
c2tiOwo+IC4uLgo+IAkqZXJyY29kZSA9IGVycjsKPiAJcmV0dXJuIE5VTEw7Cj4gfQoKCi1FQUdB
SU4gYW5kIC1FTk9CRlMgYXJlIGZpbmUuIEJ1dCBJIGRvbid0IHNlZSBob3cgLUVOT01FTSBjYW4g
YmUgcmV0dXJuZWQuCgpUaGFua3MKCgo+PiBUaGFua3MKPj4KPj4KPj4+IEZpeGVzOiAzYTRkNWM5
NGU5NTkgKCJ2aG9zdF9uZXQ6IGEga2VybmVsLWxldmVsIHZpcnRpbyBzZXJ2ZXIiKQo+Pj4gU2ln
bmVkLW9mZi1ieTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+Pj4gLS0t
Cj4+PiAgICBkcml2ZXJzL3Zob3N0L25ldC5jIHwgMTYgKysrKysrKystLS0tLS0tLQo+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9uZXQuYyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMgaW5k
ZXgKPj4+IGM4Nzg0ZGZhZmRkNy4uZTc2MjQ1ZGFhN2Y2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy92aG9zdC9uZXQuYwo+Pj4gKysrIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+Pj4gQEAgLTgyNywx
NCArODI3LDEzIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF9jb3B5KHN0cnVjdCB2aG9zdF9uZXQg
Km5ldCwKPj4gc3RydWN0IHNvY2tldCAqc29jaykKPj4+ICAgIAkJCQltc2cubXNnX2ZsYWdzICY9
IH5NU0dfTU9SRTsKPj4+ICAgIAkJfQo+Pj4KPj4+IC0JCS8qIFRPRE86IENoZWNrIHNwZWNpZmlj
IGVycm9yIGFuZCBib21iIG91dCB1bmxlc3MgRU5PQlVGUz8gKi8KPj4+ICAgIAkJZXJyID0gc29j
ay0+b3BzLT5zZW5kbXNnKHNvY2ssICZtc2csIGxlbik7Cj4+PiAtCQlpZiAodW5saWtlbHkoZXJy
IDwgMCkpIHsKPj4+ICsJCWlmICh1bmxpa2VseShlcnIgPT0gLUVBR0FJTiB8fCBlcnIgPT0gLUVO
T01FTSkpIHsKPj4+ICAgIAkJCXZob3N0X2Rpc2NhcmRfdnFfZGVzYyh2cSwgMSk7Cj4+PiAgICAJ
CQl2aG9zdF9uZXRfZW5hYmxlX3ZxKG5ldCwgdnEpOwo+Pj4gICAgCQkJYnJlYWs7Cj4+PiAgICAJ
CX0KPj4+IC0JCWlmIChlcnIgIT0gbGVuKQo+Pj4gKwkJaWYgKGVyciA+PSAwICYmIGVyciAhPSBs
ZW4pCj4+PiAgICAJCQlwcl9kZWJ1ZygiVHJ1bmNhdGVkIFRYIHBhY2tldDogbGVuICVkICE9ICV6
ZFxuIiwKPj4+ICAgIAkJCQkgZXJyLCBsZW4pOwo+Pj4gICAgZG9uZToKPj4+IEBAIC05MjIsNyAr
OTIxLDYgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3R4X3plcm9jb3B5KHN0cnVjdCB2aG9zdF9uZXQK
Pj4gKm5ldCwgc3RydWN0IHNvY2tldCAqc29jaykKPj4+ICAgIAkJCW1zZy5tc2dfZmxhZ3MgJj0g
fk1TR19NT1JFOwo+Pj4gICAgCQl9Cj4+Pgo+Pj4gLQkJLyogVE9ETzogQ2hlY2sgc3BlY2lmaWMg
ZXJyb3IgYW5kIGJvbWIgb3V0IHVubGVzcyBFTk9CVUZTPyAqLwo+Pj4gICAgCQllcnIgPSBzb2Nr
LT5vcHMtPnNlbmRtc2coc29jaywgJm1zZywgbGVuKTsKPj4+ICAgIAkJaWYgKHVubGlrZWx5KGVy
ciA8IDApKSB7Cj4+PiAgICAJCQlpZiAoemNvcHlfdXNlZCkgewo+Pj4gQEAgLTkzMSwxMSArOTI5
LDEzIEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShzdHJ1Y3Qgdmhvc3RfbmV0Cj4+
ICpuZXQsIHN0cnVjdCBzb2NrZXQgKnNvY2spCj4+PiAgICAJCQkJbnZxLT51cGVuZF9pZHggPSAo
KHVuc2lnbmVkKW52cS0+dXBlbmRfaWR4IC0gMSkKPj4+ICAgIAkJCQkJJSBVSU9fTUFYSU9WOwo+
Pj4gICAgCQkJfQo+Pj4gLQkJCXZob3N0X2Rpc2NhcmRfdnFfZGVzYyh2cSwgMSk7Cj4+PiAtCQkJ
dmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPj4+IC0JCQlicmVhazsKPj4+ICsJCQlpZiAo
ZXJyID09IC1FQUdBSU4gfHwgZXJyID09IC1FTk9NRU0pIHsKPj4+ICsJCQkJdmhvc3RfZGlzY2Fy
ZF92cV9kZXNjKHZxLCAxKTsKPj4+ICsJCQkJdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsK
Pj4+ICsJCQkJYnJlYWs7Cj4+PiArCQkJfQo+Pj4gICAgCQl9Cj4+PiAtCQlpZiAoZXJyICE9IGxl
bikKPj4+ICsJCWlmIChlcnIgPj0gMCAmJiBlcnIgIT0gbGVuKQo+Pj4gICAgCQkJcHJfZGVidWco
IlRydW5jYXRlZCBUWCBwYWNrZXQ6ICIKPj4+ICAgIAkJCQkgIiBsZW4gJWQgIT0gJXpkXG4iLCBl
cnIsIGxlbik7Cj4+PiAgICAJCWlmICghemNvcHlfdXNlZCkKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
