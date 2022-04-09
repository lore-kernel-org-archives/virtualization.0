Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F82C4167D
	for <virtualization@archiver.kernel.org>; Sat,  9 Apr 2022 04:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E5A960D5B;
	Sat,  9 Apr 2022 04:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rUfPVcTj-LhK; Sat,  9 Apr 2022 04:51:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DA3860AC1;
	Sat,  9 Apr 2022 04:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04E0EC0033;
	Sat,  9 Apr 2022 04:51:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09376C002C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAEFE40148
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PVJyxWbATmyX
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37CD1408D1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=mSb0+dwzgM6VKYFxP/SxijH+ZlgC/mCnwmCWElH9Px8=; b=GeHiEC33kqU3XVD5nL4JSSzw9j
 UuYbGyM2BXXR+stmsdf5DjhZy4DmQUWQMFN0vSfrL8aUhBe+6Ofrgbj+Dbx5uxEAqYOBhWREkppXD
 kdRzxDavbe8DbbMc6qyOhN2cA6i5obcc9Wc+hP+sVKryA1uBRUfBVDOlYnio24jRKSkCpFo+tSiXl
 6u0gF+2q2d7oaysxI+ClBO5UEjKSEG5mJBDObnDrEZKJSMP7hUVOwIlO/C7MDHMssw01IKDI4CTXp
 PRCDWE+Bw8zXMLtTw0QbfZSkAUMsYs8Kzz9wpJlJkYu9q6ou7iULbQ0RWrchfFLVlYlgnHKpBsjXJ
 gpZHWQ4w==;
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd33z-0020bF-0B; Sat, 09 Apr 2022 04:51:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/27] drbd: use bdev_alignment_offset instead of
 queue_alignment_offset
Date: Sat,  9 Apr 2022 06:50:22 +0200
Message-Id: <20220409045043.23593-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org,
 =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
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

VGhlIGJkZXYgdmVyc2lvbiBkb2VzIHRoZSByaWdodCB0aGluZyBmb3IgcGFydGl0aW9ucywgc28g
dXNlIHRoYXQuCgpGaXhlczogOTEwNGQzMWE3NTlmICgiZHJiZDogaW50cm9kdWNlIFdSSVRFX1NB
TUUgc3VwcG9ydCIpClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
PgpBY2tlZC1ieTogQ2hyaXN0b3BoIELDtmhtd2FsZGVyIDxjaHJpc3RvcGguYm9laG13YWxkZXJA
bGluYml0LmNvbT4KLS0tCiBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9tYWluLmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL2RyYmQvZHJi
ZF9tYWluLmMKaW5kZXggYWEyYzIxYWViNzQ3Yy4uZWFlNjI5YzRmNmVhZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jCisrKyBiL2RyaXZlcnMvYmxvY2svZHJiZC9k
cmJkX21haW4uYwpAQCAtOTM5LDcgKzkzOSw3IEBAIGludCBkcmJkX3NlbmRfc2l6ZXMoc3RydWN0
IGRyYmRfcGVlcl9kZXZpY2UgKnBlZXJfZGV2aWNlLCBpbnQgdHJpZ2dlcl9yZXBseSwgZW51CiAJ
CXAtPnFsaW0tPmxvZ2ljYWxfYmxvY2tfc2l6ZSA9CiAJCQljcHVfdG9fYmUzMihiZGV2X2xvZ2lj
YWxfYmxvY2tfc2l6ZShiZGV2KSk7CiAJCXAtPnFsaW0tPmFsaWdubWVudF9vZmZzZXQgPQotCQkJ
Y3B1X3RvX2JlMzIocXVldWVfYWxpZ25tZW50X29mZnNldChxKSk7CisJCQljcHVfdG9fYmUzMihi
ZGV2X2FsaWdubWVudF9vZmZzZXQoYmRldikpOwogCQlwLT5xbGltLT5pb19taW4gPSBjcHVfdG9f
YmUzMihiZGV2X2lvX21pbihiZGV2KSk7CiAJCXAtPnFsaW0tPmlvX29wdCA9IGNwdV90b19iZTMy
KGJkZXZfaW9fb3B0KGJkZXYpKTsKIAkJcC0+cWxpbS0+ZGlzY2FyZF9lbmFibGVkID0gYmxrX3F1
ZXVlX2Rpc2NhcmQocSk7Ci0tIAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
