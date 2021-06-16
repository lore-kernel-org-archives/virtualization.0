Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7348BC48BE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 10:28:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A0860FE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 10:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A0860FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 969FE401CF;
	Wed, 16 Jun 2021 10:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DLWtbjM8UrHC; Wed, 16 Jun 2021 10:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A259400CF;
	Wed, 16 Jun 2021 10:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22AFCC000E;
	Wed, 16 Jun 2021 10:28:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B998C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F124060647
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tE7m98EmZP9l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AF726061F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:28:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0UcblHWS_1623839304; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UcblHWS_1623839304) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Jun 2021 18:28:24 +0800
MIME-Version: 1.0
Message-Id: <1623839259.659196-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 03/15] virtio-net: add priv_flags
 IFF_NOT_USE_DMA_ADDR
Date: Wed, 16 Jun 2021 18:27:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <6cbab579-93a7-27db-9b8f-0f94f1b20b13@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gV2VkLCAxNiBKdW4gMjAyMSAxNzoyNzo1OSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMS82LzEwIOS4i+WNiDQ6MjEsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiB2aXJ0aW8tbmV0IG5vdCB1c2UgZG1hIGFkZHIgZGlyZWN0bHkuIFNvIGFk
ZCB0aGlzIHByaXZfZmxhZ3MKPiA+IElGRl9OT1RfVVNFX0RNQV9BRERSLgo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0K
PiA+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRl
eCAwNDE2YTdlMDA5MTQuLjZjMTIzM2YwYWIzZSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAt
MzA2NCw3ICszMDY0LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2KQo+ID4KPiA+ICAgCS8qIFNldCB1cCBuZXR3b3JrIGRldmljZSBhcyBub3Jt
YWwuICovCj4gPiAgIAlkZXYtPnByaXZfZmxhZ3MgfD0gSUZGX1VOSUNBU1RfRkxUIHwgSUZGX0xJ
VkVfQUREUl9DSEFOR0UgfAo+ID4gLQkJCSAgIElGRl9UWF9TS0JfTk9fTElORUFSOwo+ID4gKwkJ
CSAgIElGRl9UWF9TS0JfTk9fTElORUFSIHwgSUZGX05PVF9VU0VfRE1BX0FERFI7Cj4KPgo+IEkg
d29uZGVyIGluc3RlYWQgb2YgZG9pbmcgdHJpY2sgbGlrZSB0aGlzLCBob3cgYWJvdXQgdGVhY2gg
dGhlIHZpcnRpbwo+IGNvcmUgdG8gYWNjZXB0IERNQSBhZGRyZXNzIHZpYSBzZz8KCk9rLCBJIHdp
bGwgdHJ5IHRvIGRvIHRoaXMuCgpUaGFua3MuCgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICAgCWRldi0+
bmV0ZGV2X29wcyA9ICZ2aXJ0bmV0X25ldGRldjsKPiA+ICAgCWRldi0+ZmVhdHVyZXMgPSBORVRJ
Rl9GX0hJR0hETUE7Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
