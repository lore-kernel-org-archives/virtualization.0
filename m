Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0BC4361B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 09:32:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2EE23B7D
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 09:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2EE23B7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB5DE20522;
	Wed,  9 Dec 2020 09:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lb-cx1sLAQm2; Wed,  9 Dec 2020 09:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 83939273D7;
	Wed,  9 Dec 2020 09:32:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62AC0C0893;
	Wed,  9 Dec 2020 09:32:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC7DC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B8E3986DE1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsdHQa433jQ7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:32:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1E92A86DA9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 09:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607506322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6cW4CaC6vRkex8b1uivDQizxuPVFLQvTcxdJxTGoT8=;
 b=deHDM0ijhpV3OkJR/4d/wPKnEiV5EtZooLGT5bWxKyjKG6D/hFo9Fd1woCmumn+WPvLuyA
 a8kgE2jFlZKzixHbC1YaNhjrVR2yKFusXNEN/CrvaEcUddh5wN6gRn7t+A+77hLlXXAj3B
 0qA5A/ToYjknbMvHDTvhmxAXm3f3tj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-mt-nlmTxMZmaliXtXLKgmg-1; Wed, 09 Dec 2020 04:31:58 -0500
X-MC-Unique: mt-nlmTxMZmaliXtXLKgmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A079802B40;
 Wed,  9 Dec 2020 09:31:56 +0000 (UTC)
Received: from [10.72.12.31] (ovpn-12-31.pek2.redhat.com [10.72.12.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89EBE5275D;
 Wed,  9 Dec 2020 09:31:42 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <96aca1e6-2d5a-deb1-2444-88f938c7a9de@metux.net>
 <20201205142218-mutt-send-email-mst@kernel.org>
 <842519cc-94ca-3c11-ddd6-543e5a89c998@redhat.com>
 <20201207085247-mutt-send-email-mst@kernel.org>
 <0a9c19bd-0d25-1035-57e3-b1f5f204c309@redhat.com>
 <500d0c68-0c6d-f5fb-665b-74aec6d59f99@metux.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e11f1ab-6b7c-d50e-d7db-633ebc3d358c@redhat.com>
Date: Wed, 9 Dec 2020 17:31:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <500d0c68-0c6d-f5fb-665b-74aec6d59f99@metux.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: stefanha@redhat.com, linux-doc@vger.kernel.org, linus.walleij@linaro.org,
 corbet@lwn.net, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, msuchanek@suse.de,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

Ck9uIDIwMjAvMTIvOCDkuIvljYgzOjAyLCBFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3Vs
dCB3cm90ZToKPiBPbiAwOC4xMi4yMCAwMzozNiwgSmFzb24gV2FuZyB3cm90ZToKPgo+IEhpLAo+
Cj4+IFNvIHdlIGVuZHVwIHdpdGggdHdvIHNvbHV0aW9ucyAod2l0aG91dCBhIHByb21wdCk6Cj4+
Cj4+IDEpIHVzaW5nIHNlbGVjdCwgdXNlciBtYXkgZW5kIHVwIHdpdGggZHJpdmVyIHdpdGhvdXQg
dHJhbnNwb3J0Cj4gSU1ITyBub3QgYW4gZW50aXJlbHkgdW51c3VhbCBzaXR1YXRpb24gaW4gb3Ro
ZXIgcGxhY2VzIG9mIHRoZSBrZXJuZWwsCj4gZWcuIG9uZSBjYW4gZW5hYmxlIFVTQiBkZXZpY2Vz
LCB3L28gaGF2aW5nIGFuIHVzYiBob3N0IGFkYXB0ZXIgZW5hYmxlZC4KPgo+IEFuZCBldmVuIGlm
IHNvbWUgVVNCLUhBIGRyaXZlciBpcyBlbmFibGVkLCB0aGUgYWN0dWFseSBtYWNoaW5lIGRvZXNu
J3QKPiBuZWNlc3NhcmlseSBoYXZlIHRoZSBjb3JyZXNwb25kaW5nIGRldmljZS4KCgpPaywgdGhl
biBzZWxlY3Qgd29ya3MgZm9yIG1lLgoKCj4KPj4gMikgdXNpbmcgZGVwZW5kcywgdXNlciBuZWVk
IHRvIGVuYWJsZSBhdCBsZWFzdCBvbmUgdHJhbnNwb3J0Cj4+Cj4+IDIpIGxvb2tzIGEgbGl0dGxl
IGJpdCBiZXR0ZXIgSSBhZG1pdC4KPiBTbywgYWxsIHZpcnRpbyBkZXZpY2VzIHNob3VsZCBkZXBl
bmQgb24gVFJBTlNQT1JUX0EgfHwgVFJBTlNQT1JUX0IgfHwKPiBUUkFOU1BPUlRfQyB8fCAuLi4g
PyAoYW5kIGFsc28gY2hhbmdlIGFsbCB0aGVzZSBwbGFjZXMgaWYgYW5vdGhlcgo+IHRyYW5zcG9y
dCBpcyBhZGRlZCkgPwoKCkkgdGhpbmsgbm90LiBUaGUgaWRlYSBpcywgaWYgbm9uZSBvZiB0aGUg
dHJhbnNwb3J0IChzZWxlY3QgVklSVElPKSBpcyAKZW5hYmxlZCwgdXNlciBjYW4gbm90IGVuYWJs
ZSBhbnkgdmlydGlvIGRyaXZlcnMgKGRlcGVuZHMgb24gVklSVElPKS4KClRoYW5rcwoKCj4KPiAt
LW10eAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
