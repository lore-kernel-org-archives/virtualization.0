Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD5C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:41:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6A164ECD
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 03:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6A164ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EAB6E87043;
	Mon, 22 Feb 2021 03:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7k8LigSNcE9u; Mon, 22 Feb 2021 03:41:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E12786ECC;
	Mon, 22 Feb 2021 03:41:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 028CAC000B;
	Mon, 22 Feb 2021 03:41:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3EFC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F26983279
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DsVIAVuCtBSj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:41:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1882583265
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613965282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eByhtyuketU2PjgP2Av/7Fbai5HOSWISKqIauwTJLI8=;
 b=UTcrUczSSBfMndS/KvuGCh9CmCBrGujhqMP4UnS6dAOshprZQbt0o5C4IKfWrcg/GjTawS
 5hpiUhHRg5u1H/7vl1Vim8hxsFxrpOK8m4X9vlOEzdB0Y8qc2nbzKnBG1BzHJEU3yu0jmL
 sW3SprqDKSxd3fzcDGhbohVyGoUIiVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-5H45XKSgN2eP3ihA-EWNkA-1; Sun, 21 Feb 2021 22:41:20 -0500
X-MC-Unique: 5H45XKSgN2eP3ihA-EWNkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B77835E20;
 Mon, 22 Feb 2021 03:41:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com
 [10.72.13.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A5165B6BE;
 Mon, 22 Feb 2021 03:41:13 +0000 (UTC)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To: Arnd Bergmann <arnd@kernel.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
 <CAK8P3a3wJDAA9X6se4EvSpoQTWyxdyeVt+8vfCCbTpe+Zqixew@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78f4f064-7e70-0765-95ef-a929f280be68@redhat.com>
Date: Mon, 22 Feb 2021 11:41:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3wJDAA9X6se4EvSpoQTWyxdyeVt+8vfCCbTpe+Zqixew@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

Ck9uIDIwMjEvMi8xOSA2OjEyIOS4i+WNiCwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBGcmks
IEZlYiAxOSwgMjAyMSBhdCA5OjQ1IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+PiBXZSB1c2VkIHRvIHByb21wdCBDT05GSUdfVklSVElPX1BDSV9NT0RFUk4gdG8g
dXNlciB3aGljaCBtYXkgYnJpbmcgYQo+PiBsb3Qgb2YgY29uZnVzaW9uLiBFLmcgaXQgbWF5IGJy
ZWFrIHZhcmlvdXMgZGVmYXVsdCBjb25maWdzIHdoaWNoIHdhbnQKPj4gdmlydGlvIGRldmljZXMu
Cj4+Cj4+IFNvIHRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBieSBoaWRlIHRoZSBwcm9tcG90IGFuZCBk
b2N1bWVudCB0aGUKPj4gZGVwZW5kZW5jeS4KPj4KPj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Cj4+IENjOiBBbmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxsQGxpbmFyby5vcmc+
Cj4+IENjOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Cj4+IFJlcG9ydGVkLWJ5
OiBOYXJlc2ggS2FtYm9qdSA8bmFyZXNoLmthbWJvanVAbGluYXJvLm9yZz4KPj4gRml4ZXM6IDg2
Yjg3YzlkODU4YjYgKCJ2aXJ0aW8tcGNpOiBpbnRyb2R1Y2UgbW9kZXJuIGRldmljZSBtb2R1bGUi
KQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IEFj
a2VkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+Cj4gTm90ZSB0aGF0IHRoaXMg
ZWZmZWN0aXZlbHkgbWFrZXMgVklSVElPX1BDSV9NT0RFUk4gYW5kIFZJUlRJT19QQ0kKPiBzeW5v
bnltcywgc28gZ2l0IGdvZXMgYmFjayB0byBub3QgYmVpbmcgYWJsZSB0byBoYXZlIFZJUlRJT19Q
Q0lfTU9ERVJOCj4gYnkgaXRzZWxmLCBidXQgaXQgc2VlbXMgdGhhdCB0aGlzIGlzIG9rIGJlY2F1
c2UgdGhlIGxlZ2FjeSBwYXJ0IHdhcyBhbHJlYWR5Cj4gc3BsaXQgb3V0LgoKClRoZXJlIHdpbGwg
YmUgYSB2RFBBIGRyaXZlciB0aGF0IHdpbGwgc2VsZWN0IFZJUlRJT19QQ0lfTU9ERVJOX0RFVi4g
SXQgCnVzZWQgdG8gYmVsb25nIHRvIG9uZSBsYXJnZSBzZXJlaXMsIGJ1dCBpdCB3YXMgbm90IG1l
cmdlZCBzaW5jZSBpdCBuZWVkcyAKc29tZSByZWJhc2UuCgpUaGFua3MKCgo+Cj4gICAgICAgICAg
QXJuZAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
