Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60ECC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 12:59:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520DC613F1
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 12:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520DC613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E14B60AB2;
	Wed,  2 Jun 2021 12:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ton-8JuG0fKD; Wed,  2 Jun 2021 12:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3CB0608BA;
	Wed,  2 Jun 2021 12:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C102BC000E;
	Wed,  2 Jun 2021 12:59:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F749C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A9C482F57
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3a4cs3inBMRH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:59:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2A1E825BF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:59:29 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 670E8613F0;
 Wed,  2 Jun 2021 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622638769;
 bh=3pTJF8Uw7RKI6z+SHgf84kmB3egP8O9uPLS0sfmmP6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jJwn1XKGECVm249aCOaXizl2zxEJYlGwPip5pQSbzBVOUKTcvSD3V7A9zz/XUjvHQ
 9Djj/PboHWd1g7J0td/yAkFnHr7/xp/DNc9SC6HJElgU+Yq3Pnh06qK+ukHfRtdXSy
 XXF3oNcIYUWB4WOFV78kiyer8pUebR94BImLxLZJ4K2hWcx7VYfSzyHsPk2Zlynwgj
 9GhKGKcrYSH4iZD6S8i27OoT1OpGN43ejs6RHOBC07KsJiIGhRTNAE5WugiEg/tKUL
 2CLYyn7DKXbPUlhiFDYFYujTOJzs5gD5C73M1PxgBzeNRcjel5X1Kjby1l2/XbTwGt
 fwoN8lqTLZKHg==
Date: Wed, 2 Jun 2021 15:59:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: fix the kzalloc/kfree mismatch problem
Message-ID: <YLeArcxMkty2n/Xz@unreal>
References: <1621821978.04102-1-xuanzhuo@linux.alibaba.com>
 <36d1b92c-7dc5-f84e-ef86-980b15c39965@redhat.com>
 <YLccNiOW8UGFowli@unreal>
 <abcc9911-67d8-8764-b986-d749187d4977@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abcc9911-67d8-8764-b986-d749187d4977@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Guodeqing \(A\)" <geffrey.guo@huawei.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gV2VkLCBKdW4gMDIsIDIwMjEgYXQgMDM6MTk6NDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzIg5LiL5Y2IMTo1MCwgTGVvbiBSb21hbm92c2t5IOWGmemBkzoK
PiA+IE9uIE1vbiwgTWF5IDI0LCAyMDIxIGF0IDEwOjM3OjE0QU0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+IOWcqCAyMDIxLzUvMjQg5LiK5Y2IMTA6MDYsIFh1YW4gWmh1byDlhpnpgZM6
Cj4gPiA+ID4gT24gTW9uLCAyNCBNYXkgMjAyMSAwMTo0ODo1MyArMDAwMCwgR3VvZGVxaW5nIChB
KSA8Z2VmZnJleS5ndW9AaHVhd2VpLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tCj4gPiA+ID4gPiA+IEZyb206IE1heCBHdXJ0b3ZveSBbbWFpbHRvOm1n
dXJ0b3ZveUBudmlkaWEuY29tXQo+ID4gPiA+ID4gPiBTZW50OiBTdW5kYXksIE1heSAyMywgMjAy
MSAxNToyNQo+ID4gPiA+ID4gPiBUbzogR3VvZGVxaW5nIChBKSA8Z2VmZnJleS5ndW9AaHVhd2Vp
LmNvbT47IG1zdEByZWRoYXQuY29tCj4gPiA+ID4gPiA+IENjOiBqYXNvd2FuZ0ByZWRoYXQuY29t
OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBrdWJhQGtlcm5lbC5vcmc7Cj4gPiA+ID4gPiA+IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnCj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpby1uZXQ6IGZpeCB0aGUg
a3phbGxvYy9rZnJlZSBtaXNtYXRjaCBwcm9ibGVtCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAK
PiA+ID4gPiA+ID4gT24gNS8yMi8yMDIxIDExOjAyIEFNLCBndW9kZXFpbmcgd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gSWYgdGhlIHZpcnRpb19uZXQgZGV2aWNlIGRvZXMgbm90IHN1cHB1cnQgdGhlIGN0
cmwgcXVldWUgZmVhdHVyZSwgdGhlCj4gPiA+ID4gPiA+ID4gdmktPmN0cmwgd2FzIG5vdCBhbGxv
Y2F0ZWQsIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gZnJlZSBpdC4KPiA+ID4gPiA+ID4geW91IGRv
bid0IG5lZWQgdGhpcyBjaGVjay4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IGZyb20ga2ZyZWUg
ZG9jOgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gIklmIEBvYmpwIGlzIE5VTEwsIG5vIG9wZXJh
dGlvbiBpcyBwZXJmb3JtZWQuIgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gVGhpcyBpcyBub3Qg
YSBidWcuIEkndmUgc2V0IHZpLT5jdHJsIHRvIGJlIE5VTEwgaW4gY2FzZSAhdmktPmhhc19jdnEu
Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ICAgICB5ZXMsICB0aGlzIGlzIG5v
dCBhIGJ1ZywgdGhlIHBhdGNoIGlzIGp1c3QgYSBvcHRpbWl6YXRpb24sIGJlY2F1c2UgdGhlIHZp
LT5jdHJsIG1heWJlCj4gPiA+ID4gPiAgICAgYmUgZnJlZWQgd2hpY2ggIHdhcyBub3QgYWxsb2Nh
dGVkLCB0aGlzIG1heSBnaXZlIHBlb3BsZSBhIG1pc3VuZGVyc3RhbmRpbmcuCj4gPiA+ID4gPiAg
ICAgVGhhbmtzLgo+ID4gPiA+IEkgdGhpbmsgaXQgbWF5IGJlIGVub3VnaCB0byBhZGQgYSBjb21t
ZW50LCBhbmQgdGhlIGNvZGUgZG9lcyBub3QgbmVlZCB0byBiZQo+ID4gPiA+IG1vZGlmaWVkLgo+
ID4gPiA+IAo+ID4gPiA+IFRoYW5rcy4KPiA+ID4gCj4gPiA+IE9yIGV2ZW4ganVzdCBsZWF2ZSB0
aGUgY3VycmVudCBjb2RlIGFzIGlzLiBBIGxvdCBvZiBrZXJuZWwgY29kZXMgd2FzIHdyb3RlCj4g
PiA+IHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQga2ZyZWUoKSBzaG91bGQgZGVhbCB3aXRoIE5V
TEwuCj4gPiBJdCBpcyBub3QgYXNzdW1wdGlvbiBidXQgc3RhbmRhcmQgcHJhY3RpY2UgdGhhdCBj
YW4gYmUgc2VlbiBhcyBzaWRlCj4gPiBlZmZlY3Qgb2YgIjcpIENlbnRyYWxpemVkIGV4aXRpbmcg
b2YgZnVuY3Rpb25zIiBzZWN0aW9uIG9mIGNvZGluZy1zdHlsZS5yc3QuCj4gPiAKPiA+IFRoYW5r
cwo+IAo+IAo+IEkgZG9uJ3Qgc2VlIHRoZSBjb25uZWN0aW9uIHRvIHRoZSBjZW50cmFsaXplZCBl
eGl0aW5nLgo+IAo+IFNvbWV0aGluZyBsaWtlOgo+IAo+IGlmIChmb28pCj4gwqDCoMKgIGtmcmVl
KGZvbyk7Cj4gCj4gd29uJ3QgYnJlYWsgdGhlIGNlbnRyYWxpemF0aW9uLgoKVGhlIGtleSB3b3Jk
cyBhcmUgInNpZGUgZWZmZWN0Ii4gT25jZSB5b3UgY2VudHJhbGl6ZSBldmVyeXRoaW5nLCB5b3UK
d29uJ3Qgd2FudCB0byBzZWUgImlmIChmb28pIGtmcmVlKGZvbykiIHNwYWdoZXR0aSBjb2RlLgoK
T2YgY291cnNlIHN1Y2ggY29uc3RydWN0aW9uIGRvZXNuJ3QgYnJlYWsgYW55dGhpbmcsIGJ1dCB0
aGUgaWRlYSBpcwp0byByZWR1Y2UgdXNlbGVzcyBjb2RlIGFuZCBub3QgYWRkIGl0LgoKVGhhbmtz
Cgo+IAo+IFRoYW5rcwo+IAo+IAo+ID4gCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
