Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19199C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAEA23356
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 07:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAEA23356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0D4586381;
	Wed, 16 Dec 2020 07:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbhj0s3yK4IO; Wed, 16 Dec 2020 07:47:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 07F36862FC;
	Wed, 16 Dec 2020 07:47:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB2B8C088E;
	Wed, 16 Dec 2020 07:47:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E01DC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 07:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1656786A7A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 07:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXPN-5l+zXTG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 07:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0017E86A78
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 07:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608104858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fWj00IsPnfUCQ5MHH6U5pwD4ctNfhQxn42vbY4Hi9r0=;
 b=SoUpsGAdCd3Eb5pgBYHSoL+xd4fcWjARw/BUl0+mhOTAwrL6y6lAdCFLJ2LPhvE642371Q
 MDl4TJ2whH//VY+OrK4rYTo3QbmWcz4ewxhGv2e5V6Av4TrnAIIeTyzv4sqp2TtHFbas8s
 pC420wpn/pga7C5FSloIvJkjUQ0napA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-cbgtW64SMM2x_IsnA489kg-1; Wed, 16 Dec 2020 02:47:12 -0500
X-MC-Unique: cbgtW64SMM2x_IsnA489kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E92B1005513;
 Wed, 16 Dec 2020 07:47:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93FD47095E;
 Wed, 16 Dec 2020 07:47:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 782804BB40;
 Wed, 16 Dec 2020 07:47:10 +0000 (UTC)
Date: Wed, 16 Dec 2020 02:47:10 -0500 (EST)
From: Jason Wang <jasowang@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Message-ID: <94321592.37021268.1608104830197.JavaMail.zimbra@redhat.com>
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DB8408A@DGGEMM533-MBX.china.huawei.com>
References: <cover.1608024547.git.wangyunjian@huawei.com>
 <4be47d3a325983f1bfc39f11f0e015767dd2aa3c.1608024547.git.wangyunjian@huawei.com>
 <e853a47e-b581-18d9-f13c-b449b176a308@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB82A73@DGGEMM533-MBX.china.huawei.com>
 <205304638.36191504.1608098190622.JavaMail.zimbra@redhat.com>
 <34EFBCA9F01B0748BEB6B629CE643AE60DB8408A@DGGEMM533-MBX.china.huawei.com>
Subject: Re: [PATCH net 2/2] vhost_net: fix high cpu load when sendmsg fails
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.17]
Thread-Topic: [PATCH net 2/2] vhost_net: fix high cpu load when sendmsg fails
Thread-Index: AQHW0oRuvV7yNtzm006vlEv0Vf1dkan3BR2AgADGt5Bmnr+pAPzMlzYwSrBP9Hs=
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

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+ID4gRnJvbTogSmFzb24gV2FuZyBbbWFpbHRvOmphc293YW5nQHJlZGhhdC5jb21dCj4g
PiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDE2LCAyMDIwIDE6NTcgUE0KPiA+IFRvOiB3YW5n
eXVuamlhbiA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPiA+IENjOiBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBtc3RAcmVkaGF0LmNvbTsgd2lsbGVtZGVicnVpam4ga2VybmVsCj4gPiA8d2lsbGVt
ZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT47Cj4gPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZzsKPiA+IExpbGlqdW4gKEplcnJ5KSA8amVycnkubGlsaWp1bkBodWF3
ZWkuY29tPjsgY2hlbmNoYW5naHUKPiA+IDxjaGVuY2hhbmdodUBodWF3ZWkuY29tPjsgeHVkaW5n
a2UgPHh1ZGluZ2tlQGh1YXdlaS5jb20+OyBodWFuZ2JpbiAoSikKPiA+IDxicmlhbi5odWFuZ2Jp
bkBodWF3ZWkuY29tPgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgMi8yXSB2aG9zdF9uZXQ6
IGZpeCBoaWdoIGNwdSBsb2FkIHdoZW4gc2VuZG1zZwo+ID4gZmFpbHMKPiA+IAo+ID4gCj4gPiAK
PiA+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPiA+ID4KPiA+ID4KPiA+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gPiA+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpq
YXNvd2FuZ0ByZWRoYXQuY29tXQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDE1LCAy
MDIwIDEyOjEwIFBNCj4gPiA+ID4gVG86IHdhbmd5dW5qaWFuIDx3YW5neXVuamlhbkBodWF3ZWku
Y29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsKPiA+ID4gPiBtc3RAcmVkaGF0LmNvbTsgd2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbQo+ID4gPiA+IENjOiB2aXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgTGlsaWp1biAoSmVycnkpCj4gPiA+ID4gPGplcnJ5
LmxpbGlqdW5AaHVhd2VpLmNvbT47IGNoZW5jaGFuZ2h1IDxjaGVuY2hhbmdodUBodWF3ZWkuY29t
PjsKPiA+ID4gPiB4dWRpbmdrZSA8eHVkaW5na2VAaHVhd2VpLmNvbT47IGh1YW5nYmluIChKKQo+
ID4gPiA+IDxicmlhbi5odWFuZ2JpbkBodWF3ZWkuY29tPgo+ID4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggbmV0IDIvMl0gdmhvc3RfbmV0OiBmaXggaGlnaCBjcHUgbG9hZCB3aGVuIHNlbmRtc2cK
PiA+ID4gPiBmYWlscwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBPbiAyMDIwLzEyLzE1IOS4iuWN
iDk6NDgsIHdhbmd5dW5qaWFuIHdyb3RlOgo+ID4gPiA+ID4gRnJvbTogWXVuamlhbiBXYW5nIDx3
YW5neXVuamlhbkBodWF3ZWkuY29tPgo+ID4gPiA+ID4KPiA+ID4gPiA+IEN1cnJlbnRseSB3ZSBi
cmVhayB0aGUgbG9vcCBhbmQgd2FrZSB1cCB0aGUgdmhvc3Rfd29ya2VyIHdoZW4KPiA+IHNlbmRt
c2cKPiA+ID4gPiA+IGZhaWxzLiBXaGVuIHRoZSB3b3JrZXIgd2FrZXMgdXAgYWdhaW4sIHdlJ2xs
IG1lZXQgdGhlIHNhbWUgZXJyb3IuCj4gPiA+ID4gPiBUaGlzCj4gPiA+ID4gPiB3aWxsIGNhdXNl
IGhpZ2ggQ1BVIGxvYWQuIFRvIGZpeCB0aGlzIGlzc3VlLCB3ZSBjYW4gc2tpcCB0aGlzCj4gPiA+
ID4gPiBkZXNjcmlwdGlvbiBieSBpZ25vcmluZyB0aGUgZXJyb3IuIFdoZW4gd2UgZXhjZWVkcyBz
bmRidWYsIHRoZSByZXR1cm4KPiA+ID4gPiA+IHZhbHVlIG9mIHNlbmRtc2cgaXMgLUVBR0FJTi4g
SW4gdGhlIGNhc2Ugd2UgZG9uJ3Qgc2tpcCB0aGUKPiA+ID4gPiA+IGRlc2NyaXB0aW9uCj4gPiA+
ID4gPiBhbmQgZG9uJ3QgZHJvcCBwYWNrZXQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+ID4gPiA+ID4gLS0t
Cj4gPiA+ID4gPiAgIGRyaXZlcnMvdmhvc3QvbmV0LmMgfCAyMSArKysrKysrKystLS0tLS0tLS0t
LS0KPiA+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pCj4gPiA+ID4gPgo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvbmV0
LmMgYi9kcml2ZXJzL3Zob3N0L25ldC5jIGluZGV4Cj4gPiA+ID4gPiBjODc4NGRmYWZkZDcuLmY5
NjY1OTJkODkwMCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiA+ID4gPiA+IEBAIC04MjcsMTYgKzgy
NywxMyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfY29weShzdHJ1Y3Qgdmhvc3RfbmV0Cj4gPiAq
bmV0LAo+ID4gPiA+IHN0cnVjdCBzb2NrZXQgKnNvY2spCj4gPiA+ID4gPiAgIAkJCQltc2cubXNn
X2ZsYWdzICY9IH5NU0dfTU9SRTsKPiA+ID4gPiA+ICAgCQl9Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
LQkJLyogVE9ETzogQ2hlY2sgc3BlY2lmaWMgZXJyb3IgYW5kIGJvbWIgb3V0IHVubGVzcyBFTk9C
VUZTPwo+ID4gKi8KPiA+ID4gPiA+ICAgCQllcnIgPSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywg
Jm1zZywgbGVuKTsKPiA+ID4gPiA+IC0JCWlmICh1bmxpa2VseShlcnIgPCAwKSkgewo+ID4gPiA+
ID4gKwkJaWYgKHVubGlrZWx5KGVyciA9PSAtRUFHQUlOKSkgewo+ID4gPiA+ID4gICAJCQl2aG9z
dF9kaXNjYXJkX3ZxX2Rlc2ModnEsIDEpOwo+ID4gPiA+ID4gICAJCQl2aG9zdF9uZXRfZW5hYmxl
X3ZxKG5ldCwgdnEpOwo+ID4gPiA+ID4gICAJCQlicmVhazsKPiA+ID4gPiA+IC0JCX0KPiA+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gQXMgSSd2ZSBwb2ludGVkIG91dCBpbiBsYXN0IHZlcnNpb24uIElm
IHlvdSBkb24ndCBkaXNjYXJkIGRlc2NyaXB0b3IsCj4gPiA+ID4geW91Cj4gPiA+ID4gcHJvYmFi
bHkKPiA+ID4gPiBuZWVkIHRvIGFkZCB0aGUgaGVhZCB0byB1c2VkIHJpbmcuIE90aGVyd2lzZSB0
aGlzIGRlc2NyaXB0b3Igd2lsbCBiZQo+ID4gPiA+IGFsd2F5cwo+ID4gPiA+IGluZmxpZ2h0IHRo
YXQgbWF5IGNvbmZ1c2UgZHJpdmVycy4KPiA+ID4KPiA+ID4gU29ycnkgZm9yIG1pc3NpbmcgdGhl
IGNvbW1lbnQuCj4gPiA+Cj4gPiA+IEFmdGVyIGRlbGV0aW5nIGRpc2NhcmQgZGVzY3JpcHRvciBh
bmQgYnJlYWssIHRoZSBuZXh0IHByb2Nlc3Npbmcgd2lsbCBiZQo+ID4gPiB0aGUKPiA+ID4gc2Ft
ZQo+ID4gPiBhcyB0aGUgbm9ybWFsIHN1Y2Nlc3Mgb2Ygc2VuZG1zZygpLCBhbmQgdmhvc3RfemVy
b2NvcHlfc2lnbmFsX3VzZWQoKSBvcgo+ID4gPiB2aG9zdF9hZGRfdXNlZF9hbmRfc2lnbmFsKCkg
bWV0aG9kIHdpbGwgYmUgY2FsbGVkIHRvIGFkZCB0aGUgaGVhZCB0byB1c2VkCj4gPiA+IHJpbmcu
Cj4gPiAKPiA+IEl0J3MgdGhlIG5leHQgaGVhZCBub3QgdGhlIG9uZSB0aGF0IGNvbnRhaW5zIHRo
ZSBidWdneSBwYWNrZXQ/Cj4gCj4gSW4gdGhlIG1vZGlmaWVkIGNvZGUgbG9naWMsIHRoZSBoZWFk
IGFkZGVkIHRvIHVzZWQgcmluZyBpcyBleGVjdGx5IHRoZQo+IG9uZSB0aGF0IGNvbnRhaW5zIHRo
ZSBidWdneSBwYWNrZXQuCgotRU5PVEVBIDooIFlvdSdyZSByaWdodCwgSSBtaXNyZWFkIHRoZSBj
b2RlLgoKVGhhbmtzCgo+IAo+IFRoYW5rcwo+IAo+ID4gCj4gPiBUaGFua3MKPiA+IAo+ID4gPgo+
ID4gPiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPiAtCQlpZiAoZXJyICE9IGxlbikK
PiA+ID4gPiA+IC0JCQlwcl9kZWJ1ZygiVHJ1bmNhdGVkIFRYIHBhY2tldDogbGVuICVkICE9ICV6
ZFxuIiwKPiA+ID4gPiA+IC0JCQkJIGVyciwgbGVuKTsKPiA+ID4gPiA+ICsJCX0gZWxzZSBpZiAo
dW5saWtlbHkoZXJyIDwgMCB8fCBlcnIgIT0gbGVuKSkKPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
SXQgbG9va3MgdG8gbWUgZXJyICE9IGxlbiBjb3ZlcnMgZXJyIDwgMC4KPiA+ID4KPiA+ID4gT0sK
PiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICsJ
CQl2cV9lcnIodnEsICJGYWlsIHRvIHNlbmRpbmcgcGFja2V0cyBlcnIgOiAlZCwgbGVuIDogJXpk
XG4iLAo+ID4gZXJyLAo+ID4gPiA+ID4gK2xlbik7Cj4gPiA+ID4gPiAgIGRvbmU6Cj4gPiA+ID4g
PiAgIAkJdnEtPmhlYWRzW252cS0+ZG9uZV9pZHhdLmlkID0gY3B1X3RvX3Zob3N0MzIodnEsIGhl
YWQpOwo+ID4gPiA+ID4gICAJCXZxLT5oZWFkc1tudnEtPmRvbmVfaWR4XS5sZW4gPSAwOwo+ID4g
PiA+ID4gQEAgLTkyMiw3ICs5MTksNiBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfemVyb2NvcHko
c3RydWN0IHZob3N0X25ldAo+ID4gPiA+ICpuZXQsIHN0cnVjdCBzb2NrZXQgKnNvY2spCj4gPiA+
ID4gPiAgIAkJCW1zZy5tc2dfZmxhZ3MgJj0gfk1TR19NT1JFOwo+ID4gPiA+ID4gICAJCX0KPiA+
ID4gPiA+Cj4gPiA+ID4gPiAtCQkvKiBUT0RPOiBDaGVjayBzcGVjaWZpYyBlcnJvciBhbmQgYm9t
YiBvdXQgdW5sZXNzIEVOT0JVRlM/Cj4gPiAqLwo+ID4gPiA+ID4gICAJCWVyciA9IHNvY2stPm9w
cy0+c2VuZG1zZyhzb2NrLCAmbXNnLCBsZW4pOwo+ID4gPiA+ID4gICAJCWlmICh1bmxpa2VseShl
cnIgPCAwKSkgewo+ID4gPiA+ID4gICAJCQlpZiAoemNvcHlfdXNlZCkgewo+ID4gPiA+ID4gQEAg
LTkzMSwxMyArOTI3LDE0IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90eF96ZXJvY29weShzdHJ1Y3QK
PiA+IHZob3N0X25ldAo+ID4gPiA+ICpuZXQsIHN0cnVjdCBzb2NrZXQgKnNvY2spCj4gPiA+ID4g
PiAgIAkJCQludnEtPnVwZW5kX2lkeCA9ICgodW5zaWduZWQpbnZxLT51cGVuZF9pZHggLSAxKQo+
ID4gPiA+ID4gICAJCQkJCSUgVUlPX01BWElPVjsKPiA+ID4gPiA+ICAgCQkJfQo+ID4gPiA+ID4g
LQkJCXZob3N0X2Rpc2NhcmRfdnFfZGVzYyh2cSwgMSk7Cj4gPiA+ID4gPiAtCQkJdmhvc3RfbmV0
X2VuYWJsZV92cShuZXQsIHZxKTsKPiA+ID4gPiA+IC0JCQlicmVhazsKPiA+ID4gPiA+ICsJCQlp
ZiAoZXJyID09IC1FQUdBSU4pIHsKPiA+ID4gPiA+ICsJCQkJdmhvc3RfZGlzY2FyZF92cV9kZXNj
KHZxLCAxKTsKPiA+ID4gPiA+ICsJCQkJdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPiA+
ID4gPiA+ICsJCQkJYnJlYWs7Cj4gPiA+ID4gPiArCQkJfQo+ID4gPiA+ID4gICAJCX0KPiA+ID4g
PiA+ICAgCQlpZiAoZXJyICE9IGxlbikKPiA+ID4gPiA+IC0JCQlwcl9kZWJ1ZygiVHJ1bmNhdGVk
IFRYIHBhY2tldDogIgo+ID4gPiA+ID4gLQkJCQkgIiBsZW4gJWQgIT0gJXpkXG4iLCBlcnIsIGxl
bik7Cj4gPiA+ID4gPiArCQkJdnFfZXJyKHZxLCAiRmFpbCB0byBzZW5kaW5nIHBhY2tldHMgZXJy
IDogJWQsIGxlbiA6ICV6ZFxuIiwKPiA+IGVyciwKPiA+ID4gPiA+ICtsZW4pOwo+ID4gPiA+ID4g
ICAJCWlmICghemNvcHlfdXNlZCkKPiA+ID4gPiA+ICAgCQkJdmhvc3RfYWRkX3VzZWRfYW5kX3Np
Z25hbCgmbmV0LT5kZXYsIHZxLCBoZWFkLCAwKTsKPiA+ID4gPiA+ICAgCQllbHNlCj4gPiA+Cj4g
PiA+Cj4gCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
