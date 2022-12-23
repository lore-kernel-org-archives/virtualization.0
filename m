Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E5CC4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 05:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7683F81E05;
	Fri, 23 Dec 2022 05:56:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7683F81E05
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HEoatJdd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLXTdqMLd9ri; Fri, 23 Dec 2022 05:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1356281DEC;
	Fri, 23 Dec 2022 05:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1356281DEC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F05CBC0071;
	Fri, 23 Dec 2022 05:56:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33FD9C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F43C81E05
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F43C81E05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROkWsbAIebJb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8EB681DEC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8EB681DEC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671774964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLU/kz5L7+duj2YuqM8Cn1XKSLMK19mcv5UshCyXuUg=;
 b=HEoatJddi4Vw2F4mldhb1k7bTOthmlr4PbUH50sCAf11euPjDyvWrzA2vHKe/73TRzK+QC
 InUqTraTQ+xkmcJb0qrUu6HhVviPK5V99qcCWNJ1r+bzl6GnjNPt1EkFgvZNQKWUnF2wZ8
 cCX/8l5z6a3qDrnGbvQsPQz2vK7t9tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-wl2gBfz3Mf-QsAlqqC1xNQ-1; Fri, 23 Dec 2022 00:56:00 -0500
X-MC-Unique: wl2gBfz3Mf-QsAlqqC1xNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D09F101A521;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com
 [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FBB140C2064;
 Fri, 23 Dec 2022 05:55:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 2/4] vdpasim: customize allocation size
Date: Fri, 23 Dec 2022 13:55:46 +0800
Message-Id: <20221223055548.27810-3-jasowang@redhat.com>
In-Reply-To: <20221223055548.27810-1-jasowang@redhat.com>
References: <20221223055548.27810-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

QWxsb3cgaW5kaXZpZHVhbCBzaW11bGF0b3IgdG8gY3VzdG9taXplIHRoZSBhbGxvY2F0aW9uIHNp
emUuCgpSZXZpZXdlZC1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29t
PgpBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMgICAgIHwgNSArKysrLQogZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmggICAgIHwgMSArCiBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxr
LmMgfCAxICsKIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDEgKwogNCBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jCmluZGV4IDExOGRiYzhlNWQ2Ny4uMzQxZGExMDdlN2RhIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYworKysgYi9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW0uYwpAQCAtMjU0LDYgKzI1NCw5IEBAIHN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciAqZGV2X2F0dHIsCiAJc3RydWN0IGRl
dmljZSAqZGV2OwogCWludCBpLCByZXQgPSAtRU5PTUVNOwogCisJaWYgKCFkZXZfYXR0ci0+YWxs
b2Nfc2l6ZSkKKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7CisKIAlpZiAoY29uZmlnLT5tYXNr
ICYgQklUX1VMTChWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKSkgewogCQlpZiAoY29uZmlnLT5kZXZp
Y2VfZmVhdHVyZXMgJgogCQkgICAgfmRldl9hdHRyLT5zdXBwb3J0ZWRfZmVhdHVyZXMpCkBAIC0y
NjksNyArMjcyLDcgQEAgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRlKHN0cnVjdCB2ZHBh
c2ltX2Rldl9hdHRyICpkZXZfYXR0ciwKIAogCXZkcGEgPSBfX3ZkcGFfYWxsb2NfZGV2aWNlKE5V
TEwsIG9wcywKIAkJCQkgICBkZXZfYXR0ci0+bmdyb3VwcywgZGV2X2F0dHItPm5hcywKLQkJCQkg
ICBzaXplb2Yoc3RydWN0IHZkcGFzaW0pLAorCQkJCSAgIGRldl9hdHRyLT5hbGxvY19zaXplLAog
CQkJCSAgIGRldl9hdHRyLT5uYW1lLCBmYWxzZSk7CiAJaWYgKElTX0VSUih2ZHBhKSkgewogCQly
ZXQgPSBQVFJfRVJSKHZkcGEpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmggYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAppbmRleCAwZTc4NzM3
ZGNjMTYuLjUxYzA3MGE1NDNmMSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmgKKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKQEAgLTM3LDYg
KzM3LDcgQEAgc3RydWN0IHZkcGFzaW1fZGV2X2F0dHIgewogCXN0cnVjdCB2ZHBhX21nbXRfZGV2
ICptZ210X2RldjsKIAljb25zdCBjaGFyICpuYW1lOwogCXU2NCBzdXBwb3J0ZWRfZmVhdHVyZXM7
CisJc2l6ZV90IGFsbG9jX3NpemU7CiAJc2l6ZV90IGNvbmZpZ19zaXplOwogCXNpemVfdCBidWZm
ZXJfc2l6ZTsKIAlpbnQgbnZxczsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbV9ibGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwppbmRl
eCBmNzQ1OTI2MjM3YTguLjUxMTc5NTliZWQ4YSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltX2Jsay5jCisrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bV9ibGsuYwpAQCAtMzc4LDYgKzM3OCw3IEBAIHN0YXRpYyBpbnQgdmRwYXNpbV9ibGtfZGV2X2Fk
ZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKIAlkZXZfYXR0
ci5udnFzID0gVkRQQVNJTV9CTEtfVlFfTlVNOwogCWRldl9hdHRyLm5ncm91cHMgPSBWRFBBU0lN
X0JMS19HUk9VUF9OVU07CiAJZGV2X2F0dHIubmFzID0gVkRQQVNJTV9CTEtfQVNfTlVNOworCWRl
dl9hdHRyLmFsbG9jX3NpemUgPSBzaXplb2Yoc3RydWN0IHZkcGFzaW0pOwogCWRldl9hdHRyLmNv
bmZpZ19zaXplID0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZyk7CiAJZGV2X2F0dHIu
Z2V0X2NvbmZpZyA9IHZkcGFzaW1fYmxrX2dldF9jb25maWc7CiAJZGV2X2F0dHIud29ya19mbiA9
IHZkcGFzaW1fYmxrX3dvcms7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRw
YV9zaW1fbmV0LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMKaW5kZXgg
ZThhMTE1ZmJlNDlmLi41YWJkNGVmZDkwMjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9uZXQuYworKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1f
bmV0LmMKQEAgLTI1Myw2ICsyNTMsNyBAQCBzdGF0aWMgaW50IHZkcGFzaW1fbmV0X2Rldl9hZGQo
c3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCiAJZGV2X2F0dHIu
bnZxcyA9IFZEUEFTSU1fTkVUX1ZRX05VTTsKIAlkZXZfYXR0ci5uZ3JvdXBzID0gVkRQQVNJTV9O
RVRfR1JPVVBfTlVNOwogCWRldl9hdHRyLm5hcyA9IFZEUEFTSU1fTkVUX0FTX05VTTsKKwlkZXZf
YXR0ci5hbGxvY19zaXplID0gc2l6ZW9mKHN0cnVjdCB2ZHBhc2ltKTsKIAlkZXZfYXR0ci5jb25m
aWdfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpOwogCWRldl9hdHRyLmdl
dF9jb25maWcgPSB2ZHBhc2ltX25ldF9nZXRfY29uZmlnOwogCWRldl9hdHRyLndvcmtfZm4gPSB2
ZHBhc2ltX25ldF93b3JrOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
