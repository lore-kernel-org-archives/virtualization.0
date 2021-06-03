Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F168C47097
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 17:09:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E1961407
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 17:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E1961407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B724A4018D;
	Thu,  3 Jun 2021 17:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kuWH48RXuZGK; Thu,  3 Jun 2021 17:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7AC640141;
	Thu,  3 Jun 2021 17:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA50C000D;
	Thu,  3 Jun 2021 17:09:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7772C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 17:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 840F8403C7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 17:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VkXWXpzcg331
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 17:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 207D540468
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 17:09:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UbAY0W._1622740141; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UbAY0W._1622740141) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 04 Jun 2021 01:09:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
Date: Fri,  4 Jun 2021 01:09:01 +0800
Message-Id: <20210603170901.66504-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Corentin=20No=C3=ABl?= <corentin.noel@collabora.com>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

SW4gdmlydGlvLW5ldCdzIGxhcmdlIHBhY2tldCBtb2RlLCB0aGVyZSBpcyBhIGhvbGUgaW4gdGhl
IHNwYWNlIGJlaGluZApidWYuCgogICAgaGRyX3BhZGRlZF9sZW4gLSBoZHJfbGVuCgpXZSBtdXN0
IHRha2UgdGhpcyBpbnRvIGFjY291bnQgd2hlbiBjYWxjdWxhdGluZyB0YWlscm9vbS4KClsgICA0
NC41NDQzODVdIHNrYl9wdXQuY29sZCAobmV0L2NvcmUvc2tidWZmLmM6NTI1NCAoZGlzY3JpbWlu
YXRvciAxKSBuZXQvY29yZS9za2J1ZmYuYzo1MjUyIChkaXNjcmltaW5hdG9yIDEpKQpbICAgNDQu
NTQ0ODY0XSBwYWdlX3RvX3NrYiAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjQ4NSkgWyAgIDQ0
LjU0NTM2MV0gcmVjZWl2ZV9idWYgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzo4NDkgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jOjExMzEpClsgICA0NC41NDU4NzBdID8gbmV0aWZfcmVjZWl2ZV9z
a2JfbGlzdF9pbnRlcm5hbCAobmV0L2NvcmUvZGV2LmM6NTcxNCkKWyAgIDQ0LjU0NjYyOF0gPyBk
ZXZfZ3JvX3JlY2VpdmUgKG5ldC9jb3JlL2Rldi5jOjYxMDMpClsgICA0NC41NDcxMzVdID8gbmFw
aV9jb21wbGV0ZV9kb25lICguL2luY2x1ZGUvbGludXgvbGlzdC5oOjM1IG5ldC9jb3JlL2Rldi5j
OjU4NjcgbmV0L2NvcmUvZGV2LmM6NTg2MiBuZXQvY29yZS9kZXYuYzo2NTY1KQpbICAgNDQuNTQ3
NjcyXSB2aXJ0bmV0X3BvbGwgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxNDI3IGRyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYzoxNTI1KQpbICAgNDQuNTQ4MjUxXSBfX25hcGlfcG9sbCAobmV0L2Nv
cmUvZGV2LmM6Njk4NSkKWyAgIDQ0LjU0ODc0NF0gbmV0X3J4X2FjdGlvbiAobmV0L2NvcmUvZGV2
LmM6NzA1NCBuZXQvY29yZS9kZXYuYzo3MTM5KQpbICAgNDQuNTQ5MjY0XSBfX2RvX3NvZnRpcnEg
KC4vYXJjaC94ODYvaW5jbHVkZS9hc20vanVtcF9sYWJlbC5oOjE5IC4vaW5jbHVkZS9saW51eC9q
dW1wX2xhYmVsLmg6MjAwIC4vaW5jbHVkZS90cmFjZS9ldmVudHMvaXJxLmg6MTQyIGtlcm5lbC9z
b2Z0aXJxLmM6NTYwKQpbICAgNDQuNTQ5NzYyXSBpcnFfZXhpdF9yY3UgKGtlcm5lbC9zb2Z0aXJx
LmM6NDMzIGtlcm5lbC9zb2Z0aXJxLmM6NjM3IGtlcm5lbC9zb2Z0aXJxLmM6NjQ5KQpbICAgNDQu
NTUxMzg0XSBjb21tb25faW50ZXJydXB0IChhcmNoL3g4Ni9rZXJuZWwvaXJxLmM6MjQwIChkaXNj
cmltaW5hdG9yIDEzKSkKWyAgIDQ0LjU1MTk5MV0gPyBhc21fY29tbW9uX2ludGVycnVwdCAoLi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRlbnRyeS5oOjYzOCkKWyAgIDQ0LjU1MjY1NF0gYXNtX2Nv
bW1vbl9pbnRlcnJ1cHQgKC4vYXJjaC94ODYvaW5jbHVkZS9hc20vaWR0ZW50cnkuaDo2MzgpCgpG
aXhlczogZmIzMjg1NmIxNmFkICgidmlydGlvLW5ldDogcGFnZV90b19za2IoKSB1c2UgYnVpbGRf
c2tiIHdoZW4gdGhlcmUncyBzdWZmaWNpZW50IHRhaWxyb29tIikKU2lnbmVkLW9mZi1ieTogWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KUmVwb3J0ZWQtYnk6IENvcmVudGlu
IE5vw6tsIDxjb3JlbnRpbi5ub2VsQGNvbGxhYm9yYS5jb20+ClRlc3RlZC1ieTogQ29yZW50aW4g
Tm/Dq2wgPGNvcmVudGluLm5vZWxAY29sbGFib3JhLmNvbT4KLS0tCiBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKaW5kZXggZmE0MDdlYjhiNDU3Li43OGEwMWM3MWExN2MgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYworKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKQEAgLTQwNiw3ICs0MDYsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2ti
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAogCSAqIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgpICsg
Z2V0X21lcmdlYWJsZV9idWZfbGVuKCkKIAkgKi8KIAl0cnVlc2l6ZSA9IGhlYWRyb29tID8gUEFH
RV9TSVpFIDogdHJ1ZXNpemU7Ci0JdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbiAtIGhlYWRyb29t
OworCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW4gLSBoZWFkcm9vbSAtIChoZHJfcGFkZGVkX2xl
biAtIGhkcl9sZW4pOwogCWJ1ZiA9IHAgLSBoZWFkcm9vbTsKIAogCWxlbiAtPSBoZHJfbGVuOwot
LSAKMi4zMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
