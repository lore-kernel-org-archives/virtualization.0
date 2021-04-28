Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CABFC433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 08:40:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC42A613DC
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 08:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC42A613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71EE34055E;
	Wed, 28 Apr 2021 08:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-U9wHqfzlVV; Wed, 28 Apr 2021 08:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D465C4054C;
	Wed, 28 Apr 2021 08:40:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A915AC001C;
	Wed, 28 Apr 2021 08:40:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A24AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF373842B9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yvz07BzPs-be
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14441842AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619599200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4Dnz/Lf18H3ZKwSnBLQNLUl5d7cF3q99QAsHoXknb0=;
 b=Nfv3QIRNL0x4SNcRR/fBNGdTQuU4/tmuFlJBdU+QKirCzSXse8k/ZrnVq8xGUxnuqS6Uee
 e29WkbUE90ydDYbRu9JeWlSO8FaKpjcHkVZm/eS1G9cUhoW3VrPovff0RJRCfq4PMe2MyC
 /ycp6AEQRMCmBvzgrN2iAxTZHQ6jgOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-uwjuNaFVNZq6ZBOFYppThQ-1; Wed, 28 Apr 2021 04:39:57 -0400
X-MC-Unique: uwjuNaFVNZq6ZBOFYppThQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C241008062;
 Wed, 28 Apr 2021 08:39:56 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-52.pek2.redhat.com
 [10.72.13.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64BC560CC6;
 Wed, 28 Apr 2021 08:39:49 +0000 (UTC)
Subject: Re: [PATCH 1/2] vDPA/ifcvf: record virtio notify base
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210428082133.6766-1-lingshan.zhu@intel.com>
 <20210428082133.6766-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <55217869-b456-f3bc-0b5a-6beaf34c19f8@redhat.com>
Date: Wed, 28 Apr 2021 16:39:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428082133.6766-2-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNC8yOCDPws7nNDoyMSwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
cmVjb3JkcyB2aXJ0aW8gbm90aWZ5IGJhc2UgYWRkciB0byBpbXBsZW1lbnRlCj4gZG9vcmJlbGwg
bWFwcGluZyBmZWF0dXJlCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFu
LnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5j
IHwgMSArCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgMSArCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4g
aW5kZXggMWE2NjFhYjQ1YWY1Li5jYzYxYTViZmM1YjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmMKPiBAQCAtMTMzLDYgKzEzMyw3IEBAIGludCBpZmN2Zl9pbml0X2h3KHN0cnVjdCBpZmN2
Zl9odyAqaHcsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICAgCQkJCQkgICAgICAmaHctPm5vdGlm
eV9vZmZfbXVsdGlwbGllcik7Cj4gICAJCQlody0+bm90aWZ5X2JhciA9IGNhcC5iYXI7Cj4gICAJ
CQlody0+bm90aWZ5X2Jhc2UgPSBnZXRfY2FwX2FkZHIoaHcsICZjYXApOwo+ICsJCQlody0+bm90
aWZ5X3BhID0gcGNpX3Jlc291cmNlX3N0YXJ0KHBkZXYsIGNhcC5iYXIpICsgY2FwLm9mZnNldDsK
CgpUbyBiZSBtb3JlIGdlbmVyaWMgYW5kIGF2b2lkIGZ1dHVyZSBjaGFuZ2VzLCBsZXQncyB1c2Ug
dGhlIG1hdGggZGVmaW5lZCAKaW4gdGhlIHZpcnRpbyBzcGVjLgoKWW91IG1heSByZWZlciBob3cg
aXQgaXMgaW1wbGVtZW50ZWQgaW4gdmlydGlvX3BjaSB2ZHBhIGRyaXZlclsxXS4KClRoYW5rcwoK
WzFdIApodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8yMDIxMDQxNTA3MzE0
Ny4xOTMzMS01LWphc293YW5nQHJlZGhhdC5jb20vVC8KCgo+ICAgCQkJSUZDVkZfREJHKHBkZXYs
ICJody0+bm90aWZ5X2Jhc2UgPSAlcFxuIiwKPiAgIAkJCQkgIGh3LT5ub3RpZnlfYmFzZSk7Cj4g
ICAJCQlicmVhazsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
aCBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBpbmRleCAwMTExYmZkZWIzNDIu
LmJjY2E3YzE2NjlkZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFz
ZS5oCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IEBAIC05OCw2ICs5
OCw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4gICAJY2hhciBjb25maWdfbXNpeF9uYW1lWzI1Nl07
Cj4gICAJc3RydWN0IHZkcGFfY2FsbGJhY2sgY29uZmlnX2NiOwo+ICAgCXVuc2lnbmVkIGludCBj
b25maWdfaXJxOwo+ICsJcGh5c19hZGRyX3QgIG5vdGlmeV9wYTsKPiAgIH07Cj4gICAKPiAgIHN0
cnVjdCBpZmN2Zl9hZGFwdGVyIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
