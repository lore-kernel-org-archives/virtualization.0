Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E27AECAAA1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 11:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84402414C3;
	Tue, 30 Aug 2022 11:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84402414C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eEckx69OrF0A; Tue, 30 Aug 2022 11:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2ED8409E7;
	Tue, 30 Aug 2022 11:05:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2ED8409E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83565C0033;
	Tue, 30 Aug 2022 11:05:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A47DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 11:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7166C405B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 11:05:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7166C405B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bQe6oe3xcKbN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 11:05:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D685B40129
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D685B40129
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 11:05:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VNl-Mqh_1661857549; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VNl-Mqh_1661857549) by smtp.aliyun-inc.com;
 Tue, 30 Aug 2022 19:05:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_test: fixup for vq reset
Date: Tue, 30 Aug 2022 19:05:49 +0800
Message-Id: <20220830110549.103168-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: 6ff2a51b0458
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

Rml4IHZpcnRpbyB0ZXN0IGNvbXBpbGF0aW9uIGZhaWx1cmUgY2F1c2VkIGJ5IHZxIHJlc2V0LgoK
Li4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzogSW4gZnVuY3Rpb24g4oCYdnJpbmdf
Y3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWTigJk6Ci4uLy4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmM6MTk5OTo4OiBlcnJvcjog4oCYc3RydWN0IHZpcnRxdWV1ZeKAmSBoYXMgbm8gbWVtYmVy
IG5hbWVkIOKAmHJlc2V04oCZCiAxOTk5IHwgIHZxLT52cS5yZXNldCA9IGZhbHNlOwogICAgICB8
ICAgICAgICBeCi4uLy4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6IEluIGZ1bmN0aW9u
IOKAmF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZeKAmToKLi4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYzoyNDkzOjg6IGVycm9yOiDigJhzdHJ1Y3QgdmlydHF1ZXVl4oCZIGhhcyBubyBtZW1i
ZXIgbmFtZWQg4oCYcmVzZXTigJkKIDI0OTMgfCAgdnEtPnZxLnJlc2V0ID0gZmFsc2U7CiAgICAg
IHwgICAgICAgIF4KLi4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzogSW4gZnVuY3Rp
b24g4oCYdmlydHF1ZXVlX3Jlc2l6ZeKAmToKLi4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYzoyNTg3OjE4OiBlcnJvcjog4oCYc3RydWN0IHZpcnRxdWV1ZeKAmSBoYXMgbm8gbWVtYmVy
IG5hbWVkIOKAmG51bV9tYXjigJkKIDI1ODcgfCAgaWYgKG51bSA+IHZxLT52cS5udW1fbWF4KQog
ICAgICB8ICAgICAgICAgICAgICAgICAgXgouLi8uLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jOjI1OTY6MTE6IGVycm9yOiDigJhzdHJ1Y3QgdmlydGlvX2RldmljZeKAmSBoYXMgbm8gbWVt
YmVyIG5hbWVkIOKAmGNvbmZpZ+KAmQogMjU5NiB8ICBpZiAoIXZkZXYtPmNvbmZpZy0+ZGlzYWJs
ZV92cV9hbmRfcmVzZXQpCiAgICAgIHwgICAgICAgICAgIF5+Ci4uLy4uL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmM6MjU5OToxMTogZXJyb3I6IOKAmHN0cnVjdCB2aXJ0aW9fZGV2aWNl4oCZ
IGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYY29uZmln4oCZCiAyNTk5IHwgIGlmICghdmRldi0+Y29u
ZmlnLT5lbmFibGVfdnFfYWZ0ZXJfcmVzZXQpCiAgICAgIHwgICAgICAgICAgIF5+Ci4uLy4uL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjYwMjoxMjogZXJyb3I6IOKAmHN0cnVjdCB2aXJ0
aW9fZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYY29uZmln4oCZCiAyNjAyIHwgIGVy
ciA9IHZkZXYtPmNvbmZpZy0+ZGlzYWJsZV92cV9hbmRfcmVzZXQoX3ZxKTsKICAgICAgfCAgICAg
ICAgICAgIF5+Ci4uLy4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjYxNDoxMDogZXJy
b3I6IOKAmHN0cnVjdCB2aXJ0aW9fZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYY29u
Zmln4oCZCiAyNjE0IHwgIGlmICh2ZGV2LT5jb25maWctPmVuYWJsZV92cV9hZnRlcl9yZXNldChf
dnEpKQogICAgICB8ICAgICAgICAgIF5+Cm1ha2U6ICoqKiBbPGJ1aWx0aW4+OiB2aXJ0aW9fcmlu
Zy5vXSBFcnJvciAxCgpTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgotLS0KIHRvb2xzL3ZpcnRpby9saW51eC92aXJ0aW8uaCAgICAgICAgfCAzICsr
KwogdG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDUgKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdmlydGlvL2xpbnV4
L3ZpcnRpby5oIGIvdG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpby5oCmluZGV4IDM2M2I5ODIyODMw
MS4uNWQzNDQwZjQ3NGRkIDEwMDY0NAotLS0gYS90b29scy92aXJ0aW8vbGludXgvdmlydGlvLmgK
KysrIGIvdG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpby5oCkBAIC0xNCw2ICsxNCw3IEBAIHN0cnVj
dCB2aXJ0aW9fZGV2aWNlIHsKIAl1NjQgZmVhdHVyZXM7CiAJc3RydWN0IGxpc3RfaGVhZCB2cXM7
CiAJc3BpbmxvY2tfdCB2cXNfbGlzdF9sb2NrOworCWNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyAqY29uZmlnOwogfTsKIAogc3RydWN0IHZpcnRxdWV1ZSB7CkBAIC0yMyw3ICsyNCw5IEBA
IHN0cnVjdCB2aXJ0cXVldWUgewogCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2OwogICAgICAg
ICB1bnNpZ25lZCBpbnQgaW5kZXg7CiAgICAgICAgIHVuc2lnbmVkIGludCBudW1fZnJlZTsKKwl1
bnNpZ25lZCBpbnQgbnVtX21heDsKIAl2b2lkICpwcml2OworCWJvb2wgcmVzZXQ7CiB9OwogCiAv
KiBJbnRlcmZhY2VzIGV4cG9ydGVkIGJ5IHZpcnRpb19yaW5nLiAqLwpkaWZmIC0tZ2l0IGEvdG9v
bHMvdmlydGlvL2xpbnV4L3ZpcnRpb19jb25maWcuaCBiL3Rvb2xzL3ZpcnRpby9saW51eC92aXJ0
aW9fY29uZmlnLmgKaW5kZXggZjI2NDBlNTA1YzRlLi4yYThhNzBlMmE5NTAgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3ZpcnRpby9saW51eC92aXJ0aW9fY29uZmlnLmgKKysrIGIvdG9vbHMvdmlydGlvL2xp
bnV4L3ZpcnRpb19jb25maWcuaApAQCAtMyw2ICszLDExIEBACiAjaW5jbHVkZSA8bGludXgvdmly
dGlvLmg+CiAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmlnLmg+CiAKK3N0cnVjdCB2
aXJ0aW9fY29uZmlnX29wcyB7CisJaW50ICgqZGlzYWJsZV92cV9hbmRfcmVzZXQpKHN0cnVjdCB2
aXJ0cXVldWUgKnZxKTsKKwlpbnQgKCplbmFibGVfdnFfYWZ0ZXJfcmVzZXQpKHN0cnVjdCB2aXJ0
cXVldWUgKnZxKTsKK307CisKIC8qCiAgKiBfX3ZpcnRpb190ZXN0X2JpdCAtIGhlbHBlciB0byB0
ZXN0IGZlYXR1cmUgYml0cy4gRm9yIHVzZSBieSB0cmFuc3BvcnRzLgogICogICAgICAgICAgICAg
ICAgICAgICBEZXZpY2VzIHNob3VsZCBub3JtYWxseSB1c2UgdmlydGlvX2hhc19mZWF0dXJlLAot
LSAKMi4zMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
