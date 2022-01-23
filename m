Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E112C433F5
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2434405B0;
	Sun, 23 Jan 2022 00:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a_nyXcRPVBQ8; Sun, 23 Jan 2022 00:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 34916405B3;
	Sun, 23 Jan 2022 00:14:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CD3CC0039;
	Sun, 23 Jan 2022 00:14:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE1AC007B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE24983E2A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HnaXJ4cHUSB3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E4E483E07
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 2B76DCE0ADA;
 Sun, 23 Jan 2022 00:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A2CC340E5;
 Sun, 23 Jan 2022 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896870;
 bh=I6JUIP3YQtj+ZM5pthyUzl9iUgDWByA3Z3meRZYFfzg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MJOMKgLHtlOdJS4ZYKgqG0mi1ZFp9XI+KTCuq5awe1TksvbcFCQ6uBLMOOZ+OV+WT
 J0Td7SmeBrrquzTy/6fPtL9576TqhxiF7ktfQMDIOhtsksZ7BpQLsbHGf7y1VOFjTb
 TrRbEddVhi+TyV2WNF69Hocxci60Mp3eh++XidYB5GWLzacJDYk1Gna8HBU5ASymop
 m+sCvnKJ5tfEd5CMciGKrm7vNxi7JVN0PARuI0hV801E5Cl9Z79itd2REkHrYmU3Q+
 l7R0GHa/ZSR45cqBraxx1qeA/uM0x3gIoGzCiq0AVQnYVcEp4YO89A4fAXsGO0QWyw
 M664Uvi05H7dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 3/4] virtio-pci: fix the confusing error message
Date: Sat, 22 Jan 2022 19:14:20 -0500
Message-Id: <20220123001423.2461009-3-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001423.2461009-1-sashal@kernel.org>
References: <20220123001423.2461009-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: =?UTF-8?q?=E7=8E=8B=E8=B4=87?= <yun.wang@linux.alibaba.com>,
 Sasha Levin <sashal@kernel.org>, virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>
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

RnJvbTog546L6LSHIDx5dW4ud2FuZ0BsaW51eC5hbGliYWJhLmNvbT4KClsgVXBzdHJlYW0gY29t
bWl0IDYwMTc1OTliYjI1YzIwYjdhNjhjYmI4ZTdkNTM0YmRjMWMzNmI1ZTQgXQoKVGhlIGVycm9y
IG1lc3NhZ2Ugb24gdGhlIGZhaWx1cmUgb2YgcGZuIGNoZWNrIHNob3VsZCB0ZWxsCnZpcnRpby1w
Y2kgcmF0aGVyIHRoYW4gdmlydGlvLW1taW8sIGp1c3QgZml4IGl0LgoKU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBXYW5nIDx5dW4ud2FuZ0BsaW51eC5hbGliYWJhLmNvbT4KU3VnZ2VzdGVkLWJ5OiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yL2FlNWUxNTRlLWFjNTktZjBmYS1hN2M3LTA5MWEyMjAxZjU4MUBsaW51eC5hbGli
YWJhLmNvbQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19wY2lfbGVnYWN5LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5j
CmluZGV4IGZiYzQ3NjE5ODdlODUuLmJlNGUwOTljMTE3YWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMKKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9sZWdhY3kuYwpAQCAtMTQzLDcgKzE0Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICpz
ZXR1cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiwKIAlxX3BmbiA9IHZpcnRx
dWV1ZV9nZXRfZGVzY19hZGRyKHZxKSA+PiBWSVJUSU9fUENJX1FVRVVFX0FERFJfU0hJRlQ7CiAJ
aWYgKHFfcGZuID4+IDMyKSB7CiAJCWRldl9lcnIoJnZwX2Rldi0+cGNpX2Rldi0+ZGV2LAotCQkJ
InBsYXRmb3JtIGJ1ZzogbGVnYWN5IHZpcnRpby1tbWlvIG11c3Qgbm90IGJlIHVzZWQgd2l0aCBS
QU0gYWJvdmUgMHglbGx4R0JcbiIsCisJCQkicGxhdGZvcm0gYnVnOiBsZWdhY3kgdmlydGlvLXBj
aSBtdXN0IG5vdCBiZSB1c2VkIHdpdGggUkFNIGFib3ZlIDB4JWxseEdCXG4iLAogCQkJMHgxVUxM
IDw8ICgzMiArIFBBR0VfU0hJRlQgLSAzMCkpOwogCQllcnIgPSAtRTJCSUc7CiAJCWdvdG8gb3V0
X2RlbF92cTsKLS0gCjIuMzQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
