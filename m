Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D8BC47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 08:11:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA6A61361
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 08:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA6A61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4AF883BE7;
	Wed,  9 Jun 2021 08:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fPz5b6lZ3xBK; Wed,  9 Jun 2021 08:11:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C52682D07;
	Wed,  9 Jun 2021 08:11:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35786C000E;
	Wed,  9 Jun 2021 08:11:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD19C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E08B83BED
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBbIW1HitPIS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:11:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0901082D07
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:11:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Ubr.OIO_1623226283; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ubr.OIO_1623226283) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Jun 2021 16:11:23 +0800
MIME-Version: 1.0
Message-Id: <1623226112.296442-2-xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Date: Wed, 09 Jun 2021 16:08:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Greg KH <gregkh@linuxfoundation.org>
In-Reply-To: <YMB16VOrQXq5oagz@kroah.com>
Cc: regressions@lists.linux.dev, "Michael S.Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Corentin_No=C3=ABl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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

T24gV2VkLCA5IEp1biAyMDIxIDEwOjAzOjUzICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gT24gV2VkLCBKdW4gMDksIDIwMjEgYXQgMDM6NTE6MjBQ
TSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gT24gV2VkLCA5IEp1biAyMDIxIDA4OjI0OjIw
ICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPiA+
IE9uIFdlZCwgSnVuIDA5LCAyMDIxIGF0IDAyOjA4OjE3UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90
ZToKPiA+ID4gPiBPbiBXZWQsIDkgSnVuIDIwMjEgMDY6NTA6MTAgKzAyMDAsIEdyZWcgS0ggPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiA+ID4gPiA+IE9uIFdlZCwgSnVuIDA5
LCAyMDIxIGF0IDA5OjQ4OjMzQU0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+IFdpdGggdGhpcyBwYXRjaCBhbmQgdGhlIGxhdGVzdCBuZXQgYnJhbmNoIEkgbm8gbG9uZ2Vy
IGdldCBjcmFzaGVzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gRGlkIHRoaXMgZXZlciBn
ZXQgcHJvcGVybHkgc3VibWl0dGVkIHRvIHRoZSBuZXR3b3JraW5nIHRyZWUgdG8gZ2V0IGludG8K
PiA+ID4gPiA+ID4gPiA1LjEzLWZpbmFsPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGUgcGF0
Y2ggaGFzIGJlZW4gc3VibWl0dGVkLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAJW1BBVENIIG5l
dF0gdmlydGlvLW5ldDogZml4IGZvciBza2Jfb3Zlcl9wYW5pYyBpbnNpZGUgYmlnIG1vZGUKPiA+
ID4gPiA+Cj4gPiA+ID4gPiBTdWJtaXR0ZWQgd2hlcmU/ICBEbyB5b3UgaGF2ZSBhIGxvcmUua2Vy
bmVsLm9yZyBsaW5rIHNvbWV3aGVyZT8KPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjEwNjAzMTcwOTAxLjY2NTA0LTEteHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20vCj4gPiA+Cj4gPiA+IFNvIHRoaXMgaXMgY29tbWl0IDFhODAyNDIzOWRh
YyAoInZpcnRpby1uZXQ6IGZpeCBmb3Igc2tiX292ZXJfcGFuaWMKPiA+ID4gaW5zaWRlIGJpZyBt
b2RlIikgaW4gTGludXMncyB0cmVlLCByaWdodD8KPiA+Cj4gPiBZRVMuCj4gPgo+ID4gPgo+ID4g
PiBCdXQgd2h5IGlzIHRoYXQgcmVmZXJlbmNpbmc6Cj4gPiA+IAlGaXhlczogZmIzMjg1NmIxNmFk
ICgidmlydGlvLW5ldDogcGFnZV90b19za2IoKSB1c2UgYnVpbGRfc2tiIHdoZW4gdGhlcmUncyBz
dWZmaWNpZW50IHRhaWxyb29tIikKPiA+Cj4gPiBUaGlzIHByb2JsZW0gd2FzIGluZGVlZCBpbnRy
b2R1Y2VkIGluIGZiMzI4NTZiMTZhZC4KPiA+Cj4gPiBJIGNvbmZpcm1lZCB0aGF0IHRoaXMgY29t
bWl0IGZiMzI4NTZiMTZhZCB3YXMgZmlyc3QgZW50ZXJlZCBpbiA1LjEzLXJjMSwgYW5kIHRoZQo+
ID4gcHJldmlvdXMgNS4xMiBkaWQgbm90IGhhdmUgdGhpcyBjb21taXQgZmIzMjg1NmIxNmFkLgo+
ID4KPiA+IEknbSBub3Qgc3VyZSBpZiBpdCBoZWxwZWQgeW91Lgo+Cj4gSG0sIHRoZW4gd2hhdCBy
ZXNvbHZlcyB0aGUgcmVwb3J0ZWQgcHJvYmxlbSB0aGF0IHBlb3BsZSB3ZXJlIGhhdmluZyB3aXRo
Cj4gdGhlIDUuMTIueSBrZXJuZWwgcmVsZWFzZT8gIElzIHRoYXQgYSBzZXBhcmF0ZSBpc3N1ZT8K
CkhhcyBhbnlvbmUgcmVwb3J0ZWQgYSBwcm9ibGVtIHdpdGggNS4xMi55PyBJIGRvbuKAmXQgc2Vl
bSB0byBzZWUgaXQuIENvcmVudGluCm9ubHkgcmVwb3J0ZWQgYSBwcm9ibGVtIHdpdGggNS4xMz8g
RGlkIEkgbWlzcyBzb21ldGhpbmc/CgpJIGNvbmZpcm0gdGhhdCA1LjEyLjkgaGFzIG5vIG1vZGlm
aWNhdGlvbiBvZiBmYjMyODU2YjE2YWQuCgpUaGFua3MuCgo+Cj4gdGhhbmtzLAo+Cj4gZ3JlZyBr
LWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
