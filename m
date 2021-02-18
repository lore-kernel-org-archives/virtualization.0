Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9973C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:05:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43ACC64E2E
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ACC64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA9FA605E5
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0IZ7nTv2JNrm for <virtualization@archiver.kernel.org>;
	Thu, 18 Feb 2021 06:05:25 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 2721C605DD; Thu, 18 Feb 2021 06:05:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9C56605D3;
	Thu, 18 Feb 2021 06:05:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 567EEC000E;
	Thu, 18 Feb 2021 06:05:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDDA6C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B0BDE87262
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IvqstR6DDBRR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:05:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 159DD8725F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613628317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4q+YxVSVW16DE0+d+Y+BYB1zXwlSir3yUCLZoTFOt0=;
 b=YCuMlcArQz7uQ42j88vuHc9R267cGU8KqW6Cb/2ciWP/tHQDSkcAutEAFJ28QDuja+4awx
 NSIZLqPxPiWXzRNZnzz5/VuB3aqZloBoJ/hBdoVwSbtV3HU2cmUdBil3i6IExnaey3B+iy
 opjGB+EZ2yjiVyrlnQ0ISYu/GNTdkMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-PZmTWchaOh2HvEa0I-vBkg-1; Thu, 18 Feb 2021 01:05:15 -0500
X-MC-Unique: PZmTWchaOh2HvEa0I-vBkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C659E801965;
 Thu, 18 Feb 2021 06:05:12 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFAFC6A03D;
 Thu, 18 Feb 2021 06:05:00 +0000 (UTC)
Subject: Re: [PATCH] arm64: defconfig: enable modern virtio pci device
To: Arnd Bergmann <arnd@kernel.org>, Anders Roxell <anders.roxell@linaro.org>
References: <20210210190506.1923684-1-anders.roxell@linaro.org>
 <CAK8P3a2ysNApoG2FDsLdNoWA7nPXvzLMzkjXWdCig9jaSWwuKw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fffdfa8f-38c1-6fd1-d043-8a4f476213dc@redhat.com>
Date: Thu, 18 Feb 2021 14:04:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2ysNApoG2FDsLdNoWA7nPXvzLMzkjXWdCig9jaSWwuKw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
List-Id: <soc.lore.kernel.org>
Cc: Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-xtensa@linux-xtensa.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 virtualization@lists.linux-foundation.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, SoC Team <soc@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Ck9uIDIwMjEvMi8xMSDkuIvljYg3OjUyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+IE9uIFdlZCwg
RmViIDEwLCAyMDIxIGF0IDg6MDUgUE0gQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5h
cm8ub3JnPiB3cm90ZToKPj4gU2luY2UgcGF0Y2ggKCJ2aXJ0aW8tcGNpOiBpbnRyb2R1Y2UgbW9k
ZXJuIGRldmljZSBtb2R1bGUiKSBnb3QgYWRkZWQgaXQKPj4gaXMgbm90IHBvc3NpYmxlIHRvIGJv
b3QgYSBkZWZjb25maWcga2VybmVsIGluIHFlbXUgd2l0aCBhIHZpcnRpbyBwY2kKPj4gZGV2aWNl
LiAgQWRkIENPTkZJR19WSVJUSU9fUENJX01PREVSTj15IGZyYWdtZW50IG1ha2VzIHRoZSBrZXJu
ZWwgYWJsZQo+PiB0byBib290Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRlcnMgUm94ZWxsIDxh
bmRlcnMucm94ZWxsQGxpbmFyby5vcmc+Cj4+IC0tLQo+PiAgIGFyY2gvYXJtL2NvbmZpZ3MvbXVs
dGlfdjdfZGVmY29uZmlnICAgICAgICAgfCAxICsKPj4gICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVm
Y29uZmlnICAgICAgICAgICAgICAgIHwgMSArCj4gQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Cj4KPiBNaWNoYWVsLCBjYW4geW91IHBpY2sgdGhpcyB1cCBpbiB0aGUgdmhv
c3QgdHJlZSB0aGF0IGludHJvZHVjZXMgdGhlIHJlZ3Jlc3Npb24/Cj4KPiAgICAgICAgICAgQXJu
ZAo+CgpIaToKCkJhc2VkIG9uIHRoZSBkaXNjdXNzaW9uIHByZXZpb3VzbHksIHRoZSBwbGFuIGlz
IHRvIHNlbGVjdCAKVklSVElPX1BDSV9NT0RFUk4sIGFuZCBkb2N1bWVudCB0aGUgbW9kdWxlIHRo
YXQgc2VsZWN0IGl0IG11c3QgZGVwZW5kIG9uIApQQ0kuCgpJIHdpbGwgcG9zdCBhIHBhdGNoIHNv
b24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
