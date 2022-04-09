Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75E5C433F5
	for <virtualization@archiver.kernel.org>; Sat,  9 Apr 2022 04:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EF0584582;
	Sat,  9 Apr 2022 04:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xNx6RIRVrYS4; Sat,  9 Apr 2022 04:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC44A84575;
	Sat,  9 Apr 2022 04:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A293C0089;
	Sat,  9 Apr 2022 04:51:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96D86C002C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 942EA84579
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkQMPY9UCYcp
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBAF884575
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=fe1mhxHvUNcHX31X2/v6QhlWCpL7rHNmKlyfX6pAQx8=; b=Ln3yxSObowNxJM1FMrhr+K57R6
 b4hm67oQXj8QHYSsDtTeswkmQMzhTUbmcFXZ8wSKANWZ3f2uawh1SArLLQwyfG/9xFBJpY85CXdw2
 ds/PrbeW2qhvBxLbQUlZJnupwwXSwTpD5oVVdXoHNH+XQIFpfq6JutVFrQurNrlSwXfXPm8nAVF8g
 3O6uBqOGhFXMyQobgkP5h+IgaBO6+coY7mEesusFLc5Uf97qVgiCBrdqIzpOVhA93gJW7XwjtIRj9
 o9pUqGiB3fZ23DPiIOWZiMJonzuJNE4ezkBUWAzOu6pd1udnLd7cjlnkVEEt0MQfIsCBUce9aPyz9
 Bxbzzdhw==;
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd341-0020d9-Mx; Sat, 09 Apr 2022 04:51:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/27] drbd: cleanup decide_on_discard_support
Date: Sat,  9 Apr 2022 06:50:23 +0200
Message-Id: <20220409045043.23593-8-hch@lst.de>
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

U2FuaXRpemUgdGhlIGNhbGxpbmcgY29udmVudGlvbnMgYW5kIHVzZSBhIGdvdG8gbGFiZWwgdG8g
Y2xlYW51cCB0aGUKY29kZSBmbG93LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+CkFja2VkLWJ5OiBDaHJpc3RvcGggQsO2aG13YWxkZXIgPGNocmlzdG9waC5i
b2VobXdhbGRlckBsaW5iaXQuY29tPgotLS0KIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMg
fCA2OCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzNSBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jsb2NrL2RyYmQvZHJiZF9ubC5jIGIvZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbmwuYwppbmRl
eCAwMjAzMGM5YzRkM2IxLi40MGJiMGIzNTZhNmQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2Nr
L2RyYmQvZHJiZF9ubC5jCisrKyBiL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMKQEAgLTEy
MDQsMzggKzEyMDQsNDIgQEAgc3RhdGljIHVuc2lnbmVkIGludCBkcmJkX21heF9kaXNjYXJkX3Nl
Y3RvcnMoc3RydWN0IGRyYmRfY29ubmVjdGlvbiAqY29ubmVjdGlvbikKIH0KIAogc3RhdGljIHZv
aWQgZGVjaWRlX29uX2Rpc2NhcmRfc3VwcG9ydChzdHJ1Y3QgZHJiZF9kZXZpY2UgKmRldmljZSwK
LQkJCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLAotCQkJc3RydWN0IHJlcXVlc3RfcXVldWUgKmIs
Ci0JCQlib29sIGRpc2NhcmRfemVyb2VzX2lmX2FsaWduZWQpCisJCXN0cnVjdCBkcmJkX2JhY2tp
bmdfZGV2ICpiZGV2KQogewotCS8qIHEgPSBkcmJkIGRldmljZSBxdWV1ZSAoZGV2aWNlLT5ycV9x
dWV1ZSkKLQkgKiBiID0gYmFja2luZyBkZXZpY2UgcXVldWUgKGRldmljZS0+bGRldi0+YmFja2lu
Z19iZGV2LT5iZF9kaXNrLT5xdWV1ZSksCi0JICogICAgIG9yIE5VTEwgaWYgZGlza2xlc3MKLQkg
Ki8KLQlzdHJ1Y3QgZHJiZF9jb25uZWN0aW9uICpjb25uZWN0aW9uID0gZmlyc3RfcGVlcl9kZXZp
Y2UoZGV2aWNlKS0+Y29ubmVjdGlvbjsKLQlib29sIGNhbl9kbyA9IGIgPyBibGtfcXVldWVfZGlz
Y2FyZChiKSA6IHRydWU7Ci0KLQlpZiAoY2FuX2RvICYmIGNvbm5lY3Rpb24tPmNzdGF0ZSA+PSBD
X0NPTk5FQ1RFRCAmJiAhKGNvbm5lY3Rpb24tPmFncmVlZF9mZWF0dXJlcyAmIERSQkRfRkZfVFJJ
TSkpIHsKLQkJY2FuX2RvID0gZmFsc2U7Ci0JCWRyYmRfaW5mbyhjb25uZWN0aW9uLCAicGVlciBE
UkJEIHRvbyBvbGQsIGRvZXMgbm90IHN1cHBvcnQgVFJJTTogZGlzYWJsaW5nIGRpc2NhcmRzXG4i
KTsKLQl9Ci0JaWYgKGNhbl9kbykgewotCQkvKiBXZSBkb24ndCBjYXJlIGZvciB0aGUgZ3JhbnVs
YXJpdHksIHJlYWxseS4KLQkJICogU3RhY2tpbmcgbGltaXRzIGJlbG93IHNob3VsZCBmaXggaXQg
Zm9yIHRoZSBsb2NhbAotCQkgKiBkZXZpY2UuICBXaGV0aGVyIG9yIG5vdCBpdCBpcyBhIHN1aXRh
YmxlIGdyYW51bGFyaXR5Ci0JCSAqIG9uIHRoZSByZW1vdGUgZGV2aWNlIGlzIG5vdCBvdXIgcHJv
YmxlbSwgcmVhbGx5LiBJZgotCQkgKiB5b3UgY2FyZSwgeW91IG5lZWQgdG8gdXNlIGRldmljZXMg
d2l0aCBzaW1pbGFyCi0JCSAqIHRvcG9sb2d5IG9uIGFsbCBwZWVycy4gKi8KLQkJYmxrX3F1ZXVl
X2Rpc2NhcmRfZ3JhbnVsYXJpdHkocSwgNTEyKTsKLQkJcS0+bGltaXRzLm1heF9kaXNjYXJkX3Nl
Y3RvcnMgPSBkcmJkX21heF9kaXNjYXJkX3NlY3RvcnMoY29ubmVjdGlvbik7Ci0JCWJsa19xdWV1
ZV9mbGFnX3NldChRVUVVRV9GTEFHX0RJU0NBUkQsIHEpOwotCQlxLT5saW1pdHMubWF4X3dyaXRl
X3plcm9lc19zZWN0b3JzID0gZHJiZF9tYXhfZGlzY2FyZF9zZWN0b3JzKGNvbm5lY3Rpb24pOwot
CX0gZWxzZSB7Ci0JCWJsa19xdWV1ZV9mbGFnX2NsZWFyKFFVRVVFX0ZMQUdfRElTQ0FSRCwgcSk7
Ci0JCWJsa19xdWV1ZV9kaXNjYXJkX2dyYW51bGFyaXR5KHEsIDApOwotCQlxLT5saW1pdHMubWF4
X2Rpc2NhcmRfc2VjdG9ycyA9IDA7Ci0JCXEtPmxpbWl0cy5tYXhfd3JpdGVfemVyb2VzX3NlY3Rv
cnMgPSAwOworCXN0cnVjdCBkcmJkX2Nvbm5lY3Rpb24gKmNvbm5lY3Rpb24gPQorCQlmaXJzdF9w
ZWVyX2RldmljZShkZXZpY2UpLT5jb25uZWN0aW9uOworCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpx
ID0gZGV2aWNlLT5ycV9xdWV1ZTsKKworCWlmIChiZGV2ICYmICFibGtfcXVldWVfZGlzY2FyZChi
ZGV2LT5iYWNraW5nX2JkZXYtPmJkX2Rpc2stPnF1ZXVlKSkKKwkJZ290byBub3Rfc3VwcG9ydGVk
OworCisJaWYgKGNvbm5lY3Rpb24tPmNzdGF0ZSA+PSBDX0NPTk5FQ1RFRCAmJgorCSAgICAhKGNv
bm5lY3Rpb24tPmFncmVlZF9mZWF0dXJlcyAmIERSQkRfRkZfVFJJTSkpIHsKKwkJZHJiZF9pbmZv
KGNvbm5lY3Rpb24sCisJCQkicGVlciBEUkJEIHRvbyBvbGQsIGRvZXMgbm90IHN1cHBvcnQgVFJJ
TTogZGlzYWJsaW5nIGRpc2NhcmRzXG4iKTsKKwkJZ290byBub3Rfc3VwcG9ydGVkOwogCX0KKwor
CS8qCisJICogV2UgZG9uJ3QgY2FyZSBmb3IgdGhlIGdyYW51bGFyaXR5LCByZWFsbHkuCisJICoK
KwkgKiBTdGFja2luZyBsaW1pdHMgYmVsb3cgc2hvdWxkIGZpeCBpdCBmb3IgdGhlIGxvY2FsIGRl
dmljZS4gIFdoZXRoZXIgb3IKKwkgKiBub3QgaXQgaXMgYSBzdWl0YWJsZSBncmFudWxhcml0eSBv
biB0aGUgcmVtb3RlIGRldmljZSBpcyBub3Qgb3VyCisJICogcHJvYmxlbSwgcmVhbGx5LiBJZiB5
b3UgY2FyZSwgeW91IG5lZWQgdG8gdXNlIGRldmljZXMgd2l0aCBzaW1pbGFyCisJICogdG9wb2xv
Z3kgb24gYWxsIHBlZXJzLgorCSAqLworCWJsa19xdWV1ZV9kaXNjYXJkX2dyYW51bGFyaXR5KHEs
IDUxMik7CisJcS0+bGltaXRzLm1heF9kaXNjYXJkX3NlY3RvcnMgPSBkcmJkX21heF9kaXNjYXJk
X3NlY3RvcnMoY29ubmVjdGlvbik7CisJYmxrX3F1ZXVlX2ZsYWdfc2V0KFFVRVVFX0ZMQUdfRElT
Q0FSRCwgcSk7CisJcS0+bGltaXRzLm1heF93cml0ZV96ZXJvZXNfc2VjdG9ycyA9CisJCWRyYmRf
bWF4X2Rpc2NhcmRfc2VjdG9ycyhjb25uZWN0aW9uKTsKKwlyZXR1cm47CisKK25vdF9zdXBwb3J0
ZWQ6CisJYmxrX3F1ZXVlX2ZsYWdfY2xlYXIoUVVFVUVfRkxBR19ESVNDQVJELCBxKTsKKwlibGtf
cXVldWVfZGlzY2FyZF9ncmFudWxhcml0eShxLCAwKTsKKwlxLT5saW1pdHMubWF4X2Rpc2NhcmRf
c2VjdG9ycyA9IDA7CisJcS0+bGltaXRzLm1heF93cml0ZV96ZXJvZXNfc2VjdG9ycyA9IDA7CiB9
CiAKIHN0YXRpYyB2b2lkIGZpeHVwX2Rpc2NhcmRfaWZfbm90X3N1cHBvcnRlZChzdHJ1Y3QgcmVx
dWVzdF9xdWV1ZSAqcSkKQEAgLTEyNzMsNyArMTI3Nyw2IEBAIHN0YXRpYyB2b2lkIGRyYmRfc2V0
dXBfcXVldWVfcGFyYW0oc3RydWN0IGRyYmRfZGV2aWNlICpkZXZpY2UsIHN0cnVjdCBkcmJkX2Jh
Y2tpCiAJdW5zaWduZWQgaW50IG1heF9zZWdtZW50cyA9IDA7CiAJc3RydWN0IHJlcXVlc3RfcXVl
dWUgKmIgPSBOVUxMOwogCXN0cnVjdCBkaXNrX2NvbmYgKmRjOwotCWJvb2wgZGlzY2FyZF96ZXJv
ZXNfaWZfYWxpZ25lZCA9IHRydWU7CiAKIAlpZiAoYmRldikgewogCQliID0gYmRldi0+YmFja2lu
Z19iZGV2LT5iZF9kaXNrLT5xdWV1ZTsKQEAgLTEyODIsNyArMTI4NSw2IEBAIHN0YXRpYyB2b2lk
IGRyYmRfc2V0dXBfcXVldWVfcGFyYW0oc3RydWN0IGRyYmRfZGV2aWNlICpkZXZpY2UsIHN0cnVj
dCBkcmJkX2JhY2tpCiAJCXJjdV9yZWFkX2xvY2soKTsKIAkJZGMgPSByY3VfZGVyZWZlcmVuY2Uo
ZGV2aWNlLT5sZGV2LT5kaXNrX2NvbmYpOwogCQltYXhfc2VnbWVudHMgPSBkYy0+bWF4X2Jpb19i
dmVjczsKLQkJZGlzY2FyZF96ZXJvZXNfaWZfYWxpZ25lZCA9IGRjLT5kaXNjYXJkX3plcm9lc19p
Zl9hbGlnbmVkOwogCQlyY3VfcmVhZF91bmxvY2soKTsKIAogCQlibGtfc2V0X3N0YWNraW5nX2xp
bWl0cygmcS0+bGltaXRzKTsKQEAgLTEyOTIsNyArMTI5NCw3IEBAIHN0YXRpYyB2b2lkIGRyYmRf
c2V0dXBfcXVldWVfcGFyYW0oc3RydWN0IGRyYmRfZGV2aWNlICpkZXZpY2UsIHN0cnVjdCBkcmJk
X2JhY2tpCiAJLyogVGhpcyBpcyB0aGUgd29ya2Fyb3VuZCBmb3IgImJpbyB3b3VsZCBuZWVkIHRv
LCBidXQgY2Fubm90LCBiZSBzcGxpdCIgKi8KIAlibGtfcXVldWVfbWF4X3NlZ21lbnRzKHEsIG1h
eF9zZWdtZW50cyA/IG1heF9zZWdtZW50cyA6IEJMS19NQVhfU0VHTUVOVFMpOwogCWJsa19xdWV1
ZV9zZWdtZW50X2JvdW5kYXJ5KHEsIFBBR0VfU0laRS0xKTsKLQlkZWNpZGVfb25fZGlzY2FyZF9z
dXBwb3J0KGRldmljZSwgcSwgYiwgZGlzY2FyZF96ZXJvZXNfaWZfYWxpZ25lZCk7CisJZGVjaWRl
X29uX2Rpc2NhcmRfc3VwcG9ydChkZXZpY2UsIGJkZXYpOwogCiAJaWYgKGIpIHsKIAkJYmxrX3N0
YWNrX2xpbWl0cygmcS0+bGltaXRzLCAmYi0+bGltaXRzLCAwKTsKLS0gCjIuMzAuMgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
