Return-Path: <SRS0=mL0J=HW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C4C433DB
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 01:51:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FAF60C41
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 01:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FAF60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AA858407F
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 01:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5ya0QIf_XO0 for <virtualization@archiver.kernel.org>;
	Sat, 20 Feb 2021 01:51:40 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id D1E7C84081; Sat, 20 Feb 2021 01:51:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C558284073;
	Sat, 20 Feb 2021 01:51:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 885A3C000B;
	Sat, 20 Feb 2021 01:51:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C711C0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 01:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EFE3386D01
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 01:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4qf8-AMXkSh4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 01:51:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2382F86CFD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 01:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613785892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLzvVRICOaSDqurNQM35DBrVE0/HYIW5Fs4l7aQkac0=;
 b=MmPDKXU/P6f8BwkL+lHQcn5ILOemGUIRAh63pAU6bOfzVtage+LLWXQE4hy7vZ2klsCZrw
 enJ6Ow4zDAXRFajCppRVmrG+gmD2QJe3rIkS6LBj2+XPr1zucoUGlHjkZC8N6uaRxjiCPE
 qnDHxXdHfuLT1ruV8CjutBxfvlZ5jpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-91lZ5CFnOhehNkOUl4SdWA-1; Fri, 19 Feb 2021 20:51:28 -0500
X-MC-Unique: 91lZ5CFnOhehNkOUl4SdWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41750801965;
 Sat, 20 Feb 2021 01:51:27 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-57.pek2.redhat.com
 [10.72.13.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14C4660BFA;
 Sat, 20 Feb 2021 01:51:21 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To: Christoph Hellwig <hch@infradead.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <20210219101321.GA651861@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e99fe7fa-1fa8-34ee-a1d7-94322419666e@redhat.com>
Date: Sat, 20 Feb 2021 09:51:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210219101321.GA651861@infradead.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>
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

Ck9uIDIwMjEvMi8xOSA2OjEzIOS4i+WNiCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24g
RnJpLCBGZWIgMTksIDIwMjEgYXQgMDM6NDU6MDlBTSAtMDUwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gV2UgdXNlZCB0byBwcm9tcHQgQ09ORklHX1ZJUlRJT19QQ0lfTU9ERVJOIHRvIHVzZXIgd2hp
Y2ggbWF5IGJyaW5nIGEKPj4gbG90IG9mIGNvbmZ1c2lvbi4gRS5nIGl0IG1heSBicmVhayB2YXJp
b3VzIGRlZmF1bHQgY29uZmlncyB3aGljaCB3YW50Cj4+IHZpcnRpbyBkZXZpY2VzLgo+Pgo+PiBT
byB0aGlzIHBhdGNoIGZpeGVzIHRoaXMgYnkgaGlkZSB0aGUgcHJvbXBvdCBhbmQgZG9jdW1lbnQg
dGhlCj4+IGRlcGVuZGVuY3kuCj4gSXMgdGhlcmUgYW55IGdvb2QgcmVhc29uIHRvIGtlZXAgdGhl
IHN5bWJvbCBhdCBhbGw/Cj4KClRoZSBwbGFuIGlzIHRvIGNvbnZlcnQgSUZDVkYgZHJpdmVyIHRv
IHVzZSB0aGlzIG1vZHVsZSAoc2VsZWN0IGl0KS4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
