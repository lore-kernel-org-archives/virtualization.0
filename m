Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E971BC47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 05:50:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F67461363
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 05:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F67461363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56620402E9;
	Wed,  2 Jun 2021 05:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1p5YKOdJm58M; Wed,  2 Jun 2021 05:50:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 469F7402E0;
	Wed,  2 Jun 2021 05:50:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C447C000E;
	Wed,  2 Jun 2021 05:50:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5916AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 05:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 397E66064C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 05:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0A_1rsHFOUI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 05:50:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A478605DE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 05:50:50 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A713161360;
 Wed,  2 Jun 2021 05:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622613050;
 bh=D52BA1TKwtARtppT4vzXwF1FMjDUS7v+afZJl5NMqhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YAEe4BsGeoDBwhLRcW2MC+qqQPKO0RzuYvo855vjZ+7PlTdDhLa7hcMLN1hyLehy5
 cr8fSUnZVkuWitgEaiev4i+fkY8qpSuo2iPoduBxbbxlE2J/RpMyYDxfctDB0V44N0
 OeiOOWucg6Cb5DXQ0lXBPPGm3z11zg0is46/quMhY9DIO98PtSWrR0cK6PZ/YAw/CO
 FTD+lq2911PSop3DCY3/YF7/ZXAawuPzE2dJOtq2BBTreJ4mS0InA6q0TAg+K9ER4Z
 gz4N/x+wfz9CqieFL1G7O/QiMjnqLidqzBOAh+F9kcZd3YFvb0XCyoaSEnCVsUDCPh
 N3UiCLC2H4LMg==
Date: Wed, 2 Jun 2021 08:50:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: fix the kzalloc/kfree mismatch problem
Message-ID: <YLccNiOW8UGFowli@unreal>
References: <1621821978.04102-1-xuanzhuo@linux.alibaba.com>
 <36d1b92c-7dc5-f84e-ef86-980b15c39965@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <36d1b92c-7dc5-f84e-ef86-980b15c39965@redhat.com>
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

T24gTW9uLCBNYXkgMjQsIDIwMjEgYXQgMTA6Mzc6MTRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS81LzI0IOS4iuWNiDEwOjA2LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4g
T24gTW9uLCAyNCBNYXkgMjAyMSAwMTo0ODo1MyArMDAwMCwgR3VvZGVxaW5nIChBKSA8Z2VmZnJl
eS5ndW9AaHVhd2VpLmNvbT4gd3JvdGU6Cj4gPiA+IAo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tCj4gPiA+ID4gRnJvbTogTWF4IEd1cnRvdm95IFttYWlsdG86bWd1cnRvdm95QG52
aWRpYS5jb21dCj4gPiA+ID4gU2VudDogU3VuZGF5LCBNYXkgMjMsIDIwMjEgMTU6MjUKPiA+ID4g
PiBUbzogR3VvZGVxaW5nIChBKSA8Z2VmZnJleS5ndW9AaHVhd2VpLmNvbT47IG1zdEByZWRoYXQu
Y29tCj4gPiA+ID4gQ2M6IGphc293YW5nQHJlZGhhdC5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGt1YmFAa2VybmVsLm9yZzsKPiA+ID4gPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZwo+ID4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHZpcnRpby1uZXQ6IGZpeCB0aGUga3phbGxvYy9rZnJlZSBtaXNtYXRjaCBwcm9ibGVt
Cj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gT24gNS8yMi8yMDIxIDExOjAyIEFNLCBndW9kZXFp
bmcgd3JvdGU6Cj4gPiA+ID4gPiBJZiB0aGUgdmlydGlvX25ldCBkZXZpY2UgZG9lcyBub3Qgc3Vw
cHVydCB0aGUgY3RybCBxdWV1ZSBmZWF0dXJlLCB0aGUKPiA+ID4gPiA+IHZpLT5jdHJsIHdhcyBu
b3QgYWxsb2NhdGVkLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGZyZWUgaXQuCj4gPiA+ID4geW91
IGRvbid0IG5lZWQgdGhpcyBjaGVjay4KPiA+ID4gPiAKPiA+ID4gPiBmcm9tIGtmcmVlIGRvYzoK
PiA+ID4gPiAKPiA+ID4gPiAiSWYgQG9ianAgaXMgTlVMTCwgbm8gb3BlcmF0aW9uIGlzIHBlcmZv
cm1lZC4iCj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBpcyBub3QgYSBidWcuIEkndmUgc2V0IHZpLT5j
dHJsIHRvIGJlIE5VTEwgaW4gY2FzZSAhdmktPmhhc19jdnEuCj4gPiA+ID4gCj4gPiA+ID4gCj4g
PiA+ICAgIHllcywgIHRoaXMgaXMgbm90IGEgYnVnLCB0aGUgcGF0Y2ggaXMganVzdCBhIG9wdGlt
aXphdGlvbiwgYmVjYXVzZSB0aGUgdmktPmN0cmwgbWF5YmUKPiA+ID4gICAgYmUgZnJlZWQgd2hp
Y2ggIHdhcyBub3QgYWxsb2NhdGVkLCB0aGlzIG1heSBnaXZlIHBlb3BsZSBhIG1pc3VuZGVyc3Rh
bmRpbmcuCj4gPiA+ICAgIFRoYW5rcy4KPiA+IAo+ID4gSSB0aGluayBpdCBtYXkgYmUgZW5vdWdo
IHRvIGFkZCBhIGNvbW1lbnQsIGFuZCB0aGUgY29kZSBkb2VzIG5vdCBuZWVkIHRvIGJlCj4gPiBt
b2RpZmllZC4KPiA+IAo+ID4gVGhhbmtzLgo+IAo+IAo+IE9yIGV2ZW4ganVzdCBsZWF2ZSB0aGUg
Y3VycmVudCBjb2RlIGFzIGlzLiBBIGxvdCBvZiBrZXJuZWwgY29kZXMgd2FzIHdyb3RlCj4gdW5k
ZXIgdGhlIGFzc3VtcHRpb24gdGhhdCBrZnJlZSgpIHNob3VsZCBkZWFsIHdpdGggTlVMTC4KCkl0
IGlzIG5vdCBhc3N1bXB0aW9uIGJ1dCBzdGFuZGFyZCBwcmFjdGljZSB0aGF0IGNhbiBiZSBzZWVu
IGFzIHNpZGUKZWZmZWN0IG9mICI3KSBDZW50cmFsaXplZCBleGl0aW5nIG9mIGZ1bmN0aW9ucyIg
c2VjdGlvbiBvZiBjb2Rpbmctc3R5bGUucnN0LgoKVGhhbmtzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
