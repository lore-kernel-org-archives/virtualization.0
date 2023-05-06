Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767CDC77B75
	for <virtualization@archiver.kernel.org>; Sat,  6 May 2023 02:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBD894063B;
	Sat,  6 May 2023 02:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBD894063B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeS2IRv2RKYU; Sat,  6 May 2023 02:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6998E400D8;
	Sat,  6 May 2023 02:08:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6998E400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40EC0C0036;
	Sat,  6 May 2023 02:08:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F94EC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 02:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53B67405F8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 02:08:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53B67405F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrQMnNWIO_PU
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 02:08:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5FE7400D8
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5FE7400D8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 02:08:03 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0VhrSoEj_1683338876; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VhrSoEj_1683338876) by smtp.aliyun-inc.com;
 Sat, 06 May 2023 10:07:57 +0800
Message-ID: <1683338663.2120674-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4] virtio_net: suppress cpu stall when free_unused_bufs
Date: Sat, 6 May 2023 10:04:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <1683167226-7012-1-git-send-email-wangwenliang.1995@bytedance.com>
 <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
In-Reply-To: <CACGkMEs_4kUzc6iSBWvhZA1+U70Pp0o+WhE0aQnC-5pECW7QXA@mail.gmail.com>
Cc: willemdebruijn.kernel@gmail.com,
 Wenliang Wang <wangwenliang.1995@bytedance.com>, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhengqi.arch@bytedance.com, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCA1IE1heSAyMDIzIDExOjI4OjI1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUaHUsIE1heSA0LCAyMDIzIGF0IDEwOjI34oCvQU0gV2Vu
bGlhbmcgV2FuZwo+IDx3YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2UuY29tPiB3cm90ZToKPiA+
Cj4gPiBGb3IgbXVsdGktcXVldWUgYW5kIGxhcmdlIHJpbmctc2l6ZSB1c2UgY2FzZSwgdGhlIGZv
bGxvd2luZyBlcnJvcgo+ID4gb2NjdXJyZWQgd2hlbiBmcmVlX3VudXNlZF9idWZzOgo+ID4gcmN1
OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUuCj4gPgo+ID4gRml4
ZXM6IDk4NmE0ZjRkNDUyZCAoInZpcnRpb19uZXQ6IG11bHRpcXVldWUgc3VwcG9ydCIpCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXZW5saWFuZyBXYW5nIDx3YW5nd2VubGlhbmcuMTk5NUBieXRlZGFuY2Uu
Y29tPgo+ID4gLS0tCj4gPiB2MjoKPiA+IC1hZGQgbmVlZF9yZXNjaGVkIGNoZWNrLgo+ID4gLWFw
cGx5IHNhbWUgbG9naWMgdG8gc3EuCj4gPiB2MzoKPiA+IC11c2UgY29uZF9yZXNjaGVkIGluc3Rl
YWQuCj4gPiB2NDoKPiA+IC1hZGQgZml4ZXMgdGFnCj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCAyICsrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDhkODAzODUzOGZjNC4uYTEyYWUyNmRiMGUyIDEwMDY0
NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+IEBAIC0zNTYwLDEyICszNTYwLDE0IEBAIHN0YXRpYyB2b2lkIGZy
ZWVfdW51c2VkX2J1ZnMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiAgICAgICAgICAgICAg
ICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEgPSB2aS0+c3FbaV0udnE7Cj4gPiAgICAgICAgICAgICAg
ICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYodnEpKSAhPSBOVUxM
KQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgdmlydG5ldF9zcV9mcmVlX3VudXNlZF9idWYo
dnEsIGJ1Zik7Cj4gPiArICAgICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4KPiBEb2VzIHRo
aXMgcmVhbGx5IGFkZHJlc3MgdGhlIGNhc2Ugd2hlbiB0aGUgdmlydHF1ZXVlIGlzIHZlcnkgbGFy
Z2U/CgpZZXMsIEkgYWxzbyBoYXZlIHRoaXMgcXVlc3Rpb24uIEkgdGhpbmsgY29uZF9yZXNjaGVk
KCkgc2hvdWxkIGJlIGNhbGxlZCBldmVyeQp0aW1lIGEgY2VydGFpbiBudW1iZXIgb2YgYnVmZmVy
cyBhcmUgcHJvY2Vzc2VkLgoKVGhhbmtzLgoKPgo+IFRoYW5rcwo+Cj4gPiAgICAgICAgIH0KPiA+
Cj4gPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsK
PiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSA9IHZpLT5ycVtpXS52cTsK
PiA+ICAgICAgICAgICAgICAgICB3aGlsZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2Vk
X2J1Zih2cSkpICE9IE5VTEwpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0bmV0X3Jx
X2ZyZWVfdW51c2VkX2J1Zih2cSwgYnVmKTsKPiA+ICsgICAgICAgICAgICAgICBjb25kX3Jlc2No
ZWQoKTsKPiA+ICAgICAgICAgfQo+ID4gIH0KPiA+Cj4gPiAtLQo+ID4gMi4yMC4xCj4gPgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
