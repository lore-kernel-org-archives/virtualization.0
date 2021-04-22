Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D54CC433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:19:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9385601FD
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9385601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3525340EC3;
	Thu, 22 Apr 2021 08:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ic7vJWtGbV_I; Thu, 22 Apr 2021 08:19:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEADB4063E;
	Thu, 22 Apr 2021 08:19:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C25C000F;
	Thu, 22 Apr 2021 08:19:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5D62C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3ADB838D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UyCxfEk5RycK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:19:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA9E0831D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619079579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHywtxI3pNGHCs9NAnF/msLigH9rjPmkvDS5057lzus=;
 b=h6OOLa6NZk/88hiS/Bka4H/otRFOjw6yv1LWrytYy2+BGIfxcqY6FxhWCio/upAlrVfdsl
 xQ1CqkcN/yEZ0aTqG/kykKwxrDFxcFcWQLd8EI/nNqfe01RMJKBkcWDuVOyp88mSKn7+93
 qsgLRGhna0c9RzcKg31t0NGoxwZ4b34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-yyTTz9KuMi29o3s8dGVJbQ-1; Thu, 22 Apr 2021 04:19:30 -0400
X-MC-Unique: yyTTz9KuMi29o3s8dGVJbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5692107ACC7;
 Thu, 22 Apr 2021 08:19:28 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-214.pek2.redhat.com
 [10.72.13.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95228100AE2C;
 Thu, 22 Apr 2021 08:19:18 +0000 (UTC)
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
To: Christoph Hellwig <hch@infradead.org>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <20210422063128.GB4176641@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c61dcbb-ac5b-9815-a4a1-5f93ae640011@redhat.com>
Date: Thu, 22 Apr 2021 16:19:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422063128.GB4176641@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de,
 martin.radev@aisec.fraunhofer.de, kvm@vger.kernel.org, mst@redhat.com,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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

CtTaIDIwMjEvNC8yMiDPws7nMjozMSwgQ2hyaXN0b3BoIEhlbGx3aWcg0LS1wDoKPiBPbiBXZWQs
IEFwciAyMSwgMjAyMSBhdCAxMToyMToxMEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBU
aGUgYmVoYWl2b3IgZm9yIG5vbiBETUEgQVBJIGlzIGtlcHQgZm9yIG1pbmltaXppbmcgdGhlIHBl
cmZvcm1hbmNlCj4+IGltcGFjdC4KPiBOQUsuICBFdmVyeW9uZSBzaG91bGQgYmUgdXNpbmcgdGhl
IERNQSBBUEkgaW4gYSBtb2Rlcm4gd29ybGQuICBTbwo+IHRyZWF0aW5nIHRoZSBETUEgQVBJIHBh
dGggd29yc2UgdGhhbiB0aGUgYnJva2VuIGxlZ2FjeSBwYXRoIGRvZXMgbm90Cj4gbWFrZSBhbnkg
c2Vuc2Ugd2hhdHNvZXZlci4KCgpJIHRoaW5rIHRoZSBnb2FsIGlzIG5vdCB0cmVhdCBETUEgQVBJ
IHBhdGggd29yc2UgdGhhbiBsZWdhY3kuIFRoZSBpc3N1ZSAKaXMgdGhhdCB0aGUgbWFuYWdlbWVu
dCBsYXllciBzaG91bGQgZ3VhcmFudGVlIHRoYXQgQUNDRVNTX1BMQVRGT1JNIGlzIApzZXQgc28g
RE1BIEFQSSBpcyBndWFyYW50ZWVkIHRvIGJlIHVzZWQgYnkgdGhlIGRyaXZlci4gU28gSSdtIG5v
dCBzdXJlIApob3cgbXVjaCB2YWx1ZSB3ZSBjYW4gZ2FpbiBmcm9tIHRyeWluZyB0byAnZml4JyB0
aGUgbGVnYWN5IHBhdGguIEJ1dCBJIApjYW4gY2hhbmdlIHRoZSBiZWhhdmlvciBvZiBsZWdhY3kg
cGF0aCB0byBtYXRjaCBETUEgQVBJIHBhdGguCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
