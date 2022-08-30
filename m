Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D320ECAAA1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 09:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA4E94025F;
	Tue, 30 Aug 2022 09:13:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA4E94025F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Bzn0Sgvu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8GCDKnn4J_a; Tue, 30 Aug 2022 09:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E39BD40268;
	Tue, 30 Aug 2022 09:13:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E39BD40268
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5078C0032;
	Tue, 30 Aug 2022 09:13:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B854C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6210E60E35
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:13:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6210E60E35
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=Bzn0Sgvu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cAg_n7wM1TvL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:13:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 712AC605E0
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 712AC605E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:13:41 +0000 (UTC)
Received: from localhost (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 324C36601B2D;
 Tue, 30 Aug 2022 10:13:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1661850818;
 bh=zBDjC+TxheeO7C8z/tW+C9ZIGR1P+XDC1o8JlEqVoNc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Bzn0SgvuRArovCYLnNwzbo4FWbPtptJap11HjDbhDLB05KZw5oRmAHbESrbczfqOH
 yk0BPYCDTy0ocxbUn/zGpc+vC0RmUcOYOi0lwVqlWeD/wNpQlYT2lCOVzUbpPEMiLB
 eXX78XVqotCE/f4B+evAcwPMAso3c9K8PoQExnOKcyAO0UJqwuq8dMGthas3hdQPcs
 I/zbuq2SxUOgoEw2kSZIBaaQomi2gRi8VeG7z550LCcUUqK/HrGQ/Yc7qvXIuF4OO0
 JfoFTvWkHalSo/lh4/v0ZGbwNBimXimOKJzt0+9fHPEt3qh8H2kXI0jp3n/tjluQry
 Hk1oG1gE2w7sw==
Date: Tue, 30 Aug 2022 11:13:34 +0200
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: xuanzhuo@linux.alibaba.com, mst@redhat.com
Subject: Re: [PATCH v14 00/42] virtio pci support VIRTIO_F_RING_RESET
Message-ID: <20220830091334.umvkmnehvhpubunx@rcn-XPS-13-9305>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
Cc: kernel@collabora.com, virtualization@lists.linux-foundation.org
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

SGkgWHVhbiwKClBhdGNoZXMgMjQgKHZpcnRpb19yaW5nOiBpbnRyb2R1Y2UgdmlydHF1ZXVlX3Jl
c2l6ZSgpKQphbmQgMjggKHZpcnRpb19yaW5nOiBzdHJ1Y3QgdmlydHF1ZXVlIGludHJvZHVjZSBy
ZXNldCkKYnJlYWsgdGhlIHRvb2xzL3ZpcnRpbyBidWlsZDoKCgouLi8uLi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jOiBJbiBmdW5jdGlvbiDigJh2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3Bh
Y2tlZOKAmToKLi4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzoxOTk5Ojg6IGVycm9y
OiDigJhzdHJ1Y3QgdmlydHF1ZXVl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYcmVzZXTigJkK
IDE5OTkgfCAgdnEtPnZxLnJlc2V0ID0gZmFsc2U7CiAgICAgIHwgICAgICAgIF4KLi4vLi4vZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzogSW4gZnVuY3Rpb24g4oCYX192cmluZ19uZXdfdmly
dHF1ZXVl4oCZOgouLi8uLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jOjI0OTM6ODogZXJy
b3I6IOKAmHN0cnVjdCB2aXJ0cXVldWXigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhyZXNldOKA
mQogMjQ5MyB8ICB2cS0+dnEucmVzZXQgPSBmYWxzZTsKICAgICAgfCAgICAgICAgXgouLi8uLi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jOiBJbiBmdW5jdGlvbiDigJh2aXJ0cXVldWVfcmVz
aXpl4oCZOgouLi8uLi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jOjI1ODc6MTg6IGVycm9y
OiDigJhzdHJ1Y3QgdmlydHF1ZXVl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYbnVtX21heOKA
mQogMjU4NyB8ICBpZiAobnVtID4gdnEtPnZxLm51bV9tYXgpCiAgICAgIHwgICAgICAgICAgICAg
ICAgICBeCi4uLy4uL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MjU5NjoxMTogZXJyb3I6
IOKAmHN0cnVjdCB2aXJ0aW9fZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYY29uZmln
4oCZCiAyNTk2IHwgIGlmICghdmRldi0+Y29uZmlnLT5kaXNhYmxlX3ZxX2FuZF9yZXNldCkKICAg
ICAgfCAgICAgICAgICAgXn4KLi4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzoyNTk5
OjExOiBlcnJvcjog4oCYc3RydWN0IHZpcnRpb19kZXZpY2XigJkgaGFzIG5vIG1lbWJlciBuYW1l
ZCDigJhjb25maWfigJkKIDI1OTkgfCAgaWYgKCF2ZGV2LT5jb25maWctPmVuYWJsZV92cV9hZnRl
cl9yZXNldCkKICAgICAgfCAgICAgICAgICAgXn4KLi4vLi4vZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYzoyNjAyOjEyOiBlcnJvcjog4oCYc3RydWN0IHZpcnRpb19kZXZpY2XigJkgaGFzIG5v
IG1lbWJlciBuYW1lZCDigJhjb25maWfigJkKIDI2MDIgfCAgZXJyID0gdmRldi0+Y29uZmlnLT5k
aXNhYmxlX3ZxX2FuZF9yZXNldChfdnEpOwogICAgICB8ICAgICAgICAgICAgXn4KLi4vLi4vZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzoyNjE0OjEwOiBlcnJvcjog4oCYc3RydWN0IHZpcnRp
b19kZXZpY2XigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhjb25maWfigJkKIDI2MTQgfCAgaWYg
KHZkZXYtPmNvbmZpZy0+ZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0KF92cSkpCiAgICAgIHwgICAgICAg
ICAgXn4KbWFrZTogKioqIFs8YnVpbHRpbj46IHZpcnRpb19yaW5nLm9dIEVycm9yIDEKCkBNaWNo
YWVsLAphcmUgY2hhbmdlcyBpbiB2aXJ0aW8gY29kZSBzdXBwb3NlZCB0byBrZWVwIHRoZSB0ZXN0
cyBzdGFibGUgb3IgYXJlIHRoZQp0ZXN0cyBtYWludGFpbmVkIHNlcGFyYXRlbHk/CgpDaGVlcnMs
ClJpY2FyZG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
