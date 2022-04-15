Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C4C352AA
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 04:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F91661032;
	Fri, 15 Apr 2022 04:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9GCqrSNDmorn; Fri, 15 Apr 2022 04:53:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CA6561016;
	Fri, 15 Apr 2022 04:53:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 765F1C0033;
	Fri, 15 Apr 2022 04:53:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE095C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB41C61016
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wp7yOwi2R6GV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:53:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E64A761000
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=be5XRqr6FpD/xPCRROQj1WW79ZNoTG4VrTyORPZGjVE=; b=zfdoWKjLNg8/93VMXMR/8dmem+
 WdvS+5iIu6uir1zneoGsW/PVn5k5msDFRP3cNUjzgk48HwXHEWdbPPQegdyt6x56ivnd6KhVFEdRn
 raW2CONj2YH3bKud1GU1IPcR9v/j6pw0pUmG9drywqIdz4cTw9frqxiK8uJ0qudjT7ff4EmR2zNpd
 iXKlU7IflKK7BZ1vMlEvBpbCIpEVLMDJnliSIXYAubrng3TWL7OH99pGfDALzISzxUUJefgBXG3V5
 WlBB+jh7r7m3TcfVeysrxVV3wHeAvYOUUoaQFeOXr6OBj0iU6tL7PMj+sYlQjUaSSJXCl4UqBVXnS
 NdWcSxoQ==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfDxU-008Opj-8L; Fri, 15 Apr 2022 04:53:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/27] drbd: remove assign_p_sizes_qlim
Date: Fri, 15 Apr 2022 06:52:35 +0200
Message-Id: <20220415045258.199825-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
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

Rm9sZCBlYWNoIGJyYW5jaCBpbnRvIGl0cyBvbmx5IGNhbGxlci4KClNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgpBY2tlZC1ieTogQ2hyaXN0b3BoIELDtmhtd2Fs
ZGVyIDxjaHJpc3RvcGguYm9laG13YWxkZXJAbGluYml0LmNvbT4KLS0tCiBkcml2ZXJzL2Jsb2Nr
L2RyYmQvZHJiZF9tYWluLmMgfCA0NyArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbWFpbi5jIGIvZHJpdmVycy9ibG9jay9k
cmJkL2RyYmRfbWFpbi5jCmluZGV4IDRiMGIyNWNjOTE2ZWUuLjM2NzcxNTIwNWM4NjAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX21haW4uYworKysgYi9kcml2ZXJzL2Jsb2Nr
L2RyYmQvZHJiZF9tYWluLmMKQEAgLTkwMywzMSArOTAzLDYgQEAgdm9pZCBkcmJkX2dlbl9hbmRf
c2VuZF9zeW5jX3V1aWQoc3RydWN0IGRyYmRfcGVlcl9kZXZpY2UgKnBlZXJfZGV2aWNlKQogCX0K
IH0KIAotLyogY29tbXVuaWNhdGVkIGlmIChhZ3JlZWRfZmVhdHVyZXMgJiBEUkJEX0ZGX1dTQU1F
KSAqLwotc3RhdGljIHZvaWQKLWFzc2lnbl9wX3NpemVzX3FsaW0oc3RydWN0IGRyYmRfZGV2aWNl
ICpkZXZpY2UsIHN0cnVjdCBwX3NpemVzICpwLAotCQkJCQlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
cSkKLXsKLQlpZiAocSkgewotCQlwLT5xbGltLT5waHlzaWNhbF9ibG9ja19zaXplID0gY3B1X3Rv
X2JlMzIocXVldWVfcGh5c2ljYWxfYmxvY2tfc2l6ZShxKSk7Ci0JCXAtPnFsaW0tPmxvZ2ljYWxf
YmxvY2tfc2l6ZSA9IGNwdV90b19iZTMyKHF1ZXVlX2xvZ2ljYWxfYmxvY2tfc2l6ZShxKSk7Ci0J
CXAtPnFsaW0tPmFsaWdubWVudF9vZmZzZXQgPSBjcHVfdG9fYmUzMihxdWV1ZV9hbGlnbm1lbnRf
b2Zmc2V0KHEpKTsKLQkJcC0+cWxpbS0+aW9fbWluID0gY3B1X3RvX2JlMzIocXVldWVfaW9fbWlu
KHEpKTsKLQkJcC0+cWxpbS0+aW9fb3B0ID0gY3B1X3RvX2JlMzIocXVldWVfaW9fb3B0KHEpKTsK
LQkJcC0+cWxpbS0+ZGlzY2FyZF9lbmFibGVkID0gYmxrX3F1ZXVlX2Rpc2NhcmQocSk7Ci0JCXAt
PnFsaW0tPndyaXRlX3NhbWVfY2FwYWJsZSA9IDA7Ci0JfSBlbHNlIHsKLQkJcSA9IGRldmljZS0+
cnFfcXVldWU7Ci0JCXAtPnFsaW0tPnBoeXNpY2FsX2Jsb2NrX3NpemUgPSBjcHVfdG9fYmUzMihx
dWV1ZV9waHlzaWNhbF9ibG9ja19zaXplKHEpKTsKLQkJcC0+cWxpbS0+bG9naWNhbF9ibG9ja19z
aXplID0gY3B1X3RvX2JlMzIocXVldWVfbG9naWNhbF9ibG9ja19zaXplKHEpKTsKLQkJcC0+cWxp
bS0+YWxpZ25tZW50X29mZnNldCA9IDA7Ci0JCXAtPnFsaW0tPmlvX21pbiA9IGNwdV90b19iZTMy
KHF1ZXVlX2lvX21pbihxKSk7Ci0JCXAtPnFsaW0tPmlvX29wdCA9IGNwdV90b19iZTMyKHF1ZXVl
X2lvX29wdChxKSk7Ci0JCXAtPnFsaW0tPmRpc2NhcmRfZW5hYmxlZCA9IDA7Ci0JCXAtPnFsaW0t
PndyaXRlX3NhbWVfY2FwYWJsZSA9IDA7Ci0JfQotfQotCiBpbnQgZHJiZF9zZW5kX3NpemVzKHN0
cnVjdCBkcmJkX3BlZXJfZGV2aWNlICpwZWVyX2RldmljZSwgaW50IHRyaWdnZXJfcmVwbHksIGVu
dW0gZGRzX2ZsYWdzIGZsYWdzKQogewogCXN0cnVjdCBkcmJkX2RldmljZSAqZGV2aWNlID0gcGVl
cl9kZXZpY2UtPmRldmljZTsKQEAgLTk1NywxNCArOTMyLDMyIEBAIGludCBkcmJkX3NlbmRfc2l6
ZXMoc3RydWN0IGRyYmRfcGVlcl9kZXZpY2UgKnBlZXJfZGV2aWNlLCBpbnQgdHJpZ2dlcl9yZXBs
eSwgZW51CiAJCXFfb3JkZXJfdHlwZSA9IGRyYmRfcXVldWVfb3JkZXJfdHlwZShkZXZpY2UpOwog
CQltYXhfYmlvX3NpemUgPSBxdWV1ZV9tYXhfaHdfc2VjdG9ycyhxKSA8PCA5OwogCQltYXhfYmlv
X3NpemUgPSBtaW4obWF4X2Jpb19zaXplLCBEUkJEX01BWF9CSU9fU0laRSk7Ci0JCWFzc2lnbl9w
X3NpemVzX3FsaW0oZGV2aWNlLCBwLCBxKTsKKwkJcC0+cWxpbS0+cGh5c2ljYWxfYmxvY2tfc2l6
ZSA9CisJCQljcHVfdG9fYmUzMihxdWV1ZV9waHlzaWNhbF9ibG9ja19zaXplKHEpKTsKKwkJcC0+
cWxpbS0+bG9naWNhbF9ibG9ja19zaXplID0KKwkJCWNwdV90b19iZTMyKHF1ZXVlX2xvZ2ljYWxf
YmxvY2tfc2l6ZShxKSk7CisJCXAtPnFsaW0tPmFsaWdubWVudF9vZmZzZXQgPQorCQkJY3B1X3Rv
X2JlMzIocXVldWVfYWxpZ25tZW50X29mZnNldChxKSk7CisJCXAtPnFsaW0tPmlvX21pbiA9IGNw
dV90b19iZTMyKHF1ZXVlX2lvX21pbihxKSk7CisJCXAtPnFsaW0tPmlvX29wdCA9IGNwdV90b19i
ZTMyKHF1ZXVlX2lvX29wdChxKSk7CisJCXAtPnFsaW0tPmRpc2NhcmRfZW5hYmxlZCA9IGJsa19x
dWV1ZV9kaXNjYXJkKHEpOwogCQlwdXRfbGRldihkZXZpY2UpOwogCX0gZWxzZSB7CisJCXN0cnVj
dCByZXF1ZXN0X3F1ZXVlICpxID0gZGV2aWNlLT5ycV9xdWV1ZTsKKworCQlwLT5xbGltLT5waHlz
aWNhbF9ibG9ja19zaXplID0KKwkJCWNwdV90b19iZTMyKHF1ZXVlX3BoeXNpY2FsX2Jsb2NrX3Np
emUocSkpOworCQlwLT5xbGltLT5sb2dpY2FsX2Jsb2NrX3NpemUgPQorCQkJY3B1X3RvX2JlMzIo
cXVldWVfbG9naWNhbF9ibG9ja19zaXplKHEpKTsKKwkJcC0+cWxpbS0+YWxpZ25tZW50X29mZnNl
dCA9IDA7CisJCXAtPnFsaW0tPmlvX21pbiA9IGNwdV90b19iZTMyKHF1ZXVlX2lvX21pbihxKSk7
CisJCXAtPnFsaW0tPmlvX29wdCA9IGNwdV90b19iZTMyKHF1ZXVlX2lvX29wdChxKSk7CisJCXAt
PnFsaW0tPmRpc2NhcmRfZW5hYmxlZCA9IDA7CisKIAkJZF9zaXplID0gMDsKIAkJdV9zaXplID0g
MDsKIAkJcV9vcmRlcl90eXBlID0gUVVFVUVfT1JERVJFRF9OT05FOwogCQltYXhfYmlvX3NpemUg
PSBEUkJEX01BWF9CSU9fU0laRTsgLyogLi4uIG11bHRpcGxlIEJJT3MgcGVyIHBlZXJfcmVxdWVz
dCAqLwotCQlhc3NpZ25fcF9zaXplc19xbGltKGRldmljZSwgcCwgTlVMTCk7CiAJfQogCiAJaWYg
KHBlZXJfZGV2aWNlLT5jb25uZWN0aW9uLT5hZ3JlZWRfcHJvX3ZlcnNpb24gPD0gOTQpCi0tIAoy
LjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
