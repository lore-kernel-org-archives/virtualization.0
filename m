Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4DAECAAD4
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB59481392;
	Tue, 30 Aug 2022 09:34:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB59481392
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYfTmEnD3teG; Tue, 30 Aug 2022 09:34:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75A0A81391;
	Tue, 30 Aug 2022 09:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75A0A81391
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4555BC0032;
	Tue, 30 Aug 2022 09:34:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD09C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56CBE60F83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:34:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56CBE60F83
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbcPV8MNFg3k
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:34:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5233F60F7C
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5233F60F7C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:34:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R761e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VNkZ2LD_1661852060; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VNkZ2LD_1661852060) by smtp.aliyun-inc.com;
 Tue, 30 Aug 2022 17:34:20 +0800
Message-ID: <1661852011.7488828-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 00/42] virtio pci support VIRTIO_F_RING_RESET
Date: Tue, 30 Aug 2022 17:33:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Ricardo Cañuelo" <ricardo.canuelo@collabora.com>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220830091334.umvkmnehvhpubunx@rcn-XPS-13-9305>
In-Reply-To: <20220830091334.umvkmnehvhpubunx@rcn-XPS-13-9305>
Cc: kernel@collabora.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org
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

T24gVHVlLCAzMCBBdWcgMjAyMiAxMToxMzozNCArMDIwMCwgIlJpY2FyZG8gQ2HDsXVlbG8iIDxy
aWNhcmRvLmNhbnVlbG9AY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gSGkgWHVhbiwKPgo+IFBhdGNo
ZXMgMjQgKHZpcnRpb19yaW5nOiBpbnRyb2R1Y2UgdmlydHF1ZXVlX3Jlc2l6ZSgpKQo+IGFuZCAy
OCAodmlydGlvX3Jpbmc6IHN0cnVjdCB2aXJ0cXVldWUgaW50cm9kdWNlIHJlc2V0KQo+IGJyZWFr
IHRoZSB0b29scy92aXJ0aW8gYnVpbGQ6CgpDYW4geW91IHRlc3QgdGhpcyBwYXRjaD8KCmRpZmYg
LS1naXQgYS90b29scy92aXJ0aW8vbGludXgvdmlydGlvLmggYi90b29scy92aXJ0aW8vbGludXgv
dmlydGlvLmgKaW5kZXggMzYzYjk4MjI4MzAxLi41ZDM0NDBmNDc0ZGQgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3ZpcnRpby9saW51eC92aXJ0aW8uaAorKysgYi90b29scy92aXJ0aW8vbGludXgvdmlydGlv
LmgKQEAgLTE0LDYgKzE0LDcgQEAgc3RydWN0IHZpcnRpb19kZXZpY2UgewogICAgICAgIHU2NCBm
ZWF0dXJlczsKICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkIHZxczsKICAgICAgICBzcGlubG9ja190
IHZxc19saXN0X2xvY2s7CisgICAgICAgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzICpj
b25maWc7CiB9OwoKIHN0cnVjdCB2aXJ0cXVldWUgewpAQCAtMjMsNyArMjQsOSBAQCBzdHJ1Y3Qg
dmlydHF1ZXVlIHsKICAgICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldjsKICAgICAgICAg
dW5zaWduZWQgaW50IGluZGV4OwogICAgICAgICB1bnNpZ25lZCBpbnQgbnVtX2ZyZWU7CisgICAg
ICAgdW5zaWduZWQgaW50IG51bV9tYXg7CiAgICAgICAgdm9pZCAqcHJpdjsKKyAgICAgICBib29s
IHJlc2V0OwogfTsKCiAvKiBJbnRlcmZhY2VzIGV4cG9ydGVkIGJ5IHZpcnRpb19yaW5nLiAqLwpk
aWZmIC0tZ2l0IGEvdG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpb19jb25maWcuaCBiL3Rvb2xzL3Zp
cnRpby9saW51eC92aXJ0aW9fY29uZmlnLmgKaW5kZXggZjI2NDBlNTA1YzRlLi4yYThhNzBlMmE5
NTAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3ZpcnRpby9saW51eC92aXJ0aW9fY29uZmlnLmgKKysrIGIv
dG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpb19jb25maWcuaApAQCAtMyw2ICszLDExIEBACiAjaW5j
bHVkZSA8bGludXgvdmlydGlvLmg+CiAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29uZmln
Lmg+Cgorc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKKyAgICAgICBpbnQgKCpkaXNhYmxlX3Zx
X2FuZF9yZXNldCkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOworICAgICAgIGludCAoKmVuYWJsZV92
cV9hZnRlcl9yZXNldCkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOworfTsKKwogLyoKICAqIF9fdmly
dGlvX3Rlc3RfYml0IC0gaGVscGVyIHRvIHRlc3QgZmVhdHVyZSBiaXRzLiBGb3IgdXNlIGJ5IHRy
YW5zcG9ydHMuCiAgKiAgICAgICAgICAgICAgICAgICAgIERldmljZXMgc2hvdWxkIG5vcm1hbGx5
IHVzZSB2aXJ0aW9faGFzX2ZlYXR1cmUsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
