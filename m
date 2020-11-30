Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C50C64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 02:20:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A78C20757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 02:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MS61W6n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A78C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7960686208;
	Mon, 30 Nov 2020 02:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vXn5kbWeTXpz; Mon, 30 Nov 2020 02:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BBD18861F6;
	Mon, 30 Nov 2020 02:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90DE9C0859;
	Mon, 30 Nov 2020 02:20:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79C6FC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5B62786D01
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qlUkESsFn4gB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B1F6286BF1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606702850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+xbRADCNKOvYBKYT87lWC6tQYrlTC4el3mQzUGbbMk=;
 b=MS61W6n32NwMf2OnkwhoLPn+4u8seCqHxe4gvtRXLZfUPyrKijWQyNurkr2kKQgCywJBc1
 ocM40dcyAlxEe5of7ttt5WVbVMdSvD8cMX3Ia9Dl6F9KPBN6wT0bXZvfZ9yPD40clK2zIe
 TPKJl0RyDTMrbU+K0DtalPnpKkHHzdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-SwTHeKNcM1CxPpFYeZtw7A-1; Sun, 29 Nov 2020 21:20:46 -0500
X-MC-Unique: SwTHeKNcM1CxPpFYeZtw7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C1D107AD50;
 Mon, 30 Nov 2020 02:20:44 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F3F560657;
 Mon, 30 Nov 2020 02:20:35 +0000 (UTC)
Subject: Re: [PATCH] vdpa: ifcvf: Use dma_set_mask_and_coherent to simplify
 code
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mst@redhat.com,
 lingshan.zhu@intel.com, eli@mellanox.com, parav@mellanox.com
References: <20201129125434.1462638-1-christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4576b2bb-d4d3-6413-c2cb-54e7d781eebf@redhat.com>
Date: Mon, 30 Nov 2020 10:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201129125434.1462638-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTEvMjkg5LiL5Y2IODo1NCwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOgo+ICdw
Y2lfc2V0X2RtYV9tYXNrKCknICsgJ3BjaV9zZXRfY29uc2lzdGVudF9kbWFfbWFzaygpJyBjYW4g
YmUgcmVwbGFjZWQgYnkKPiBhbiBlcXVpdmFsZW50ICdkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50
KCknIHdoaWNoIGlzIG11Y2ggbGVzcyB2ZXJib3NlLgo+Cj4gV2hpbGUgYXQgaXQsIGZpeCBhIHR5
cG8gKHMvY29uZml1Z3JhdGlvbi9jb25maWd1cmF0aW9uKQo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4KPiAtLS0KCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+ICAgZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDExICsrLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4gaW5kZXggOGI0MDI4NTU2Y2I2Li5mYTFhZjMwMWNmNTUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPiBAQCAtNDE3LDE2ICs0MTcsOSBAQCBzdGF0aWMgaW50IGlmY3ZmX3Byb2Jl
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4g
ICAJCXJldHVybiByZXQ7Cj4gICAJfQo+ICAgCj4gLQlyZXQgPSBwY2lfc2V0X2RtYV9tYXNrKHBk
ZXYsIERNQV9CSVRfTUFTSyg2NCkpOwo+ICsJcmV0ID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVu
dChkZXYsIERNQV9CSVRfTUFTSyg2NCkpOwo+ICAgCWlmIChyZXQpIHsKPiAtCQlJRkNWRl9FUlIo
cGRldiwgIk5vIHVzYWJsZSBETUEgY29uZml1Z3JhdGlvblxuIik7Cj4gLQkJcmV0dXJuIHJldDsK
PiAtCX0KPiAtCj4gLQlyZXQgPSBwY2lfc2V0X2NvbnNpc3RlbnRfZG1hX21hc2socGRldiwgRE1B
X0JJVF9NQVNLKDY0KSk7Cj4gLQlpZiAocmV0KSB7Cj4gLQkJSUZDVkZfRVJSKHBkZXYsCj4gLQkJ
CSAgIk5vIHVzYWJsZSBjb2hlcmVudCBETUEgY29uZml1Z3JhdGlvblxuIik7Cj4gKwkJSUZDVkZf
RVJSKHBkZXYsICJObyB1c2FibGUgRE1BIGNvbmZpZ3VyYXRpb25cbiIpOwo+ICAgCQlyZXR1cm4g
cmV0Owo+ICAgCX0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
