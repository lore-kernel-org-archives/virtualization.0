Return-Path: <SRS0=tWAs=GS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783DC433DB
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 06:05:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8C623356
	for <virtualization@archiver.kernel.org>; Fri, 15 Jan 2021 06:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8C623356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D8E884C9F;
	Fri, 15 Jan 2021 06:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miw1Pa-yZSCu; Fri, 15 Jan 2021 06:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5FD984312;
	Fri, 15 Jan 2021 06:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7697C0893;
	Fri, 15 Jan 2021 06:05:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C04E0C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 06:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA2EB84506
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 06:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qybqfVKAw6SQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 06:05:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 48B3084312
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 06:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610690713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcgJAQsGzq3/dGD55HWg0SrSpgHhMOqMMxS66PkVM3Q=;
 b=FgwaBVFOr4IwewP+NVVjXDVT5Zc60d0aYr1TjprsHqrSYbAID6CYBlMg5s2zwIVtdm2I5L
 CHkIeP/PSRSS4izBCiiF6pyj8EUI/580YAfQDqAqu2Qp0K5MZ7AoI2E7OlK2whQZTgWY1P
 L2xASk1xRp2xG2v3z+OvKsEhSilE0L0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-0KUpvnWfMHWPDDzy07udnA-1; Fri, 15 Jan 2021 01:05:11 -0500
X-MC-Unique: 0KUpvnWfMHWPDDzy07udnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66CF2107ACF7;
 Fri, 15 Jan 2021 06:05:10 +0000 (UTC)
Received: from [10.72.13.19] (ovpn-13-19.pek2.redhat.com [10.72.13.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72A0F1F45F;
 Fri, 15 Jan 2021 06:05:03 +0000 (UTC)
Subject: Re: [PATCH net-next v7] vhost_net: avoid tx queue stuck when sendmsg
 fails
To: wangyunjian <wangyunjian@huawei.com>, netdev@vger.kernel.org
References: <1610685980-38608-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ff01b9da-f2a7-3559-63cc-833f52280ef6@redhat.com>
Date: Fri, 15 Jan 2021 14:05:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610685980-38608-1-git-send-email-wangyunjian@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, jerry.lilijun@huawei.com,
 virtualization@lists.linux-foundation.org, chenchanghu@huawei.com,
 brian.huangbin@huawei.com, xudingke@huawei.com
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

Ck9uIDIwMjEvMS8xNSDkuIvljYgxMjo0Niwgd2FuZ3l1bmppYW4gd3JvdGU6Cj4gRnJvbTogWXVu
amlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+Cj4gQ3VycmVudGx5IHRoZSBkcml2
ZXIgZG9lc24ndCBkcm9wIGEgcGFja2V0IHdoaWNoIGNhbid0IGJlIHNlbnQgYnkgdHVuCj4gKGUu
ZyBiYWQgcGFja2V0KS4gSW4gdGhpcyBjYXNlLCB0aGUgZHJpdmVyIHdpbGwgYWx3YXlzIHByb2Nl
c3MgdGhlCj4gc2FtZSBwYWNrZXQgbGVhZCB0byB0aGUgdHggcXVldWUgc3R1Y2suCj4KPiBUbyBm
aXggdGhpcyBpc3N1ZToKPiAxLiBpbiB0aGUgY2FzZSBvZiBwZXJzaXN0ZW50IGZhaWx1cmUgKGUu
ZyBiYWQgcGFja2V0KSwgdGhlIGRyaXZlcgo+ICAgICBjYW4gc2tpcCB0aGlzIGRlc2NyaXB0b3Ig
YnkgaWdub3JpbmcgdGhlIGVycm9yLgo+IDIuIGluIHRoZSBjYXNlIG9mIHRyYW5zaWVudCBmYWls
dXJlIChlLmcgLUVOT0JVRlMsIC1FQUdBSU4gYW5kIC1FTk9NRU0pLAo+ICAgICB0aGUgZHJpdmVy
IHNjaGVkdWxlcyB0aGUgd29ya2VyIHRvIHRyeSBhZ2Fpbi4KPgo+IFNpZ25lZC1vZmYtYnk6IFl1
bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+IHY3Ogo+ICAgICAqIGNvZGUgcmViYXNl
Cj4gdjY6Cj4gICAgICogdXBkYXRlIGNvZGUgc3R5bGVzIGFuZCBjb21taXQgbG9nCj4gLS0tCj4g
ICBkcml2ZXJzL3Zob3N0L25ldC5jIHwgMjYgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L25ldC5jIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+IGlu
ZGV4IDNiNzQ0MDMxZWM4Zi4uZGY4MmIxMjQxNzBlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvbmV0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gQEAgLTgyOCwxNCArODI4LDE1
IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF9jb3B5KHN0cnVjdCB2aG9zdF9uZXQgKm5ldCwgc3Ry
dWN0IHNvY2tldCAqc29jaykKPiAgIAkJCQltc2cubXNnX2ZsYWdzICY9IH5NU0dfTU9SRTsKPiAg
IAkJfQo+ICAgCj4gLQkJLyogVE9ETzogQ2hlY2sgc3BlY2lmaWMgZXJyb3IgYW5kIGJvbWIgb3V0
IHVubGVzcyBFTk9CVUZTPyAqLwo+ICAgCQllcnIgPSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywg
Jm1zZywgbGVuKTsKPiAgIAkJaWYgKHVubGlrZWx5KGVyciA8IDApKSB7Cj4gLQkJCXZob3N0X2Rp
c2NhcmRfdnFfZGVzYyh2cSwgMSk7Cj4gLQkJCXZob3N0X25ldF9lbmFibGVfdnEobmV0LCB2cSk7
Cj4gLQkJCWJyZWFrOwo+IC0JCX0KPiAtCQlpZiAoZXJyICE9IGxlbikKPiArCQkJaWYgKGVyciA9
PSAtRUFHQUlOIHx8IGVyciA9PSAtRU5PTUVNIHx8IGVyciA9PSAtRU5PQlVGUykgewo+ICsJCQkJ
dmhvc3RfZGlzY2FyZF92cV9kZXNjKHZxLCAxKTsKPiArCQkJCXZob3N0X25ldF9lbmFibGVfdnEo
bmV0LCB2cSk7Cj4gKwkJCQlicmVhazsKPiArCQkJfQo+ICsJCQlwcl9kZWJ1ZygiRmFpbCB0byBz
ZW5kIHBhY2tldDogZXJyICVkIiwgZXJyKTsKPiArCQl9IGVsc2UgaWYgKHVubGlrZWx5KGVyciAh
PSBsZW4pKQo+ICAgCQkJcHJfZGVidWcoIlRydW5jYXRlZCBUWCBwYWNrZXQ6IGxlbiAlZCAhPSAl
emRcbiIsCj4gICAJCQkJIGVyciwgbGVuKTsKPiAgIGRvbmU6Cj4gQEAgLTkyNCw3ICs5MjUsNiBA
QCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfemVyb2NvcHkoc3RydWN0IHZob3N0X25ldCAqbmV0LCBz
dHJ1Y3Qgc29ja2V0ICpzb2NrKQo+ICAgCQkJbXNnLm1zZ19mbGFncyAmPSB+TVNHX01PUkU7Cj4g
ICAJCX0KPiAgIAo+IC0JCS8qIFRPRE86IENoZWNrIHNwZWNpZmljIGVycm9yIGFuZCBib21iIG91
dCB1bmxlc3MgRU5PQlVGUz8gKi8KPiAgIAkJZXJyID0gc29jay0+b3BzLT5zZW5kbXNnKHNvY2ss
ICZtc2csIGxlbik7Cj4gICAJCWlmICh1bmxpa2VseShlcnIgPCAwKSkgewo+ICAgCQkJaWYgKHpj
b3B5X3VzZWQpIHsKPiBAQCAtOTMzLDExICs5MzMsMTMgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3R4
X3plcm9jb3B5KHN0cnVjdCB2aG9zdF9uZXQgKm5ldCwgc3RydWN0IHNvY2tldCAqc29jaykKPiAg
IAkJCQludnEtPnVwZW5kX2lkeCA9ICgodW5zaWduZWQpbnZxLT51cGVuZF9pZHggLSAxKQo+ICAg
CQkJCQklIFVJT19NQVhJT1Y7Cj4gICAJCQl9Cj4gLQkJCXZob3N0X2Rpc2NhcmRfdnFfZGVzYyh2
cSwgMSk7Cj4gLQkJCXZob3N0X25ldF9lbmFibGVfdnEobmV0LCB2cSk7Cj4gLQkJCWJyZWFrOwo+
IC0JCX0KPiAtCQlpZiAoZXJyICE9IGxlbikKPiArCQkJaWYgKGVyciA9PSAtRUFHQUlOIHx8IGVy
ciA9PSAtRU5PTUVNIHx8IGVyciA9PSAtRU5PQlVGUykgewo+ICsJCQkJdmhvc3RfZGlzY2FyZF92
cV9kZXNjKHZxLCAxKTsKPiArCQkJCXZob3N0X25ldF9lbmFibGVfdnEobmV0LCB2cSk7Cj4gKwkJ
CQlicmVhazsKPiArCQkJfQo+ICsJCQlwcl9kZWJ1ZygiRmFpbCB0byBzZW5kIHBhY2tldDogZXJy
ICVkIiwgZXJyKTsKPiArCQl9IGVsc2UgaWYgKHVubGlrZWx5KGVyciAhPSBsZW4pKQo+ICAgCQkJ
cHJfZGVidWcoIlRydW5jYXRlZCBUWCBwYWNrZXQ6ICIKPiAgIAkJCQkgIiBsZW4gJWQgIT0gJXpk
XG4iLCBlcnIsIGxlbik7Cj4gICAJCWlmICghemNvcHlfdXNlZCkKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
