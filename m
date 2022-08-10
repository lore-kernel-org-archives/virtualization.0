Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA40C25B08
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD4F9823CF;
	Wed, 10 Aug 2022 09:40:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD4F9823CF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VUQiANFK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIDwfe3trCOZ; Wed, 10 Aug 2022 09:40:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 462A482404;
	Wed, 10 Aug 2022 09:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 462A482404
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CE97C007F;
	Wed, 10 Aug 2022 09:40:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13172C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFC9E40107
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFC9E40107
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=VUQiANFK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oAmYzVOaVjwf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88FF8400FB
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88FF8400FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id A06906601C3F;
 Wed, 10 Aug 2022 10:40:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1660124428;
 bh=kLCvGXC63ijATN9bbhsEqkx6x2NBmFNJm3j2NOUAcN8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VUQiANFKXqZopxCQ8LlJg+bBmtKvXX/2TWOuEekiYlP4jGDSmR46RtoxFfE0Mg3SF
 ZhoQwQ+tflsWnc5iIssscFX3UgfdTAllOnQdgKq1CXn/Cq+X8z/4BimHGVC2G8eg7M
 7KlCTkJBpF1Sb5zZ39fnPEHtUq/3EEQKmdH/nQPmodTPc4iHc2vONOyHVS4rgNBsR/
 ZVK11hlgrkOIo9+w1PUGxqoulckkC4ASMxn8NMgL4RBcU5QmHu/mITNnCh1Opz2Ix5
 x1zcd3+MbXKCqHP0il6QQJ4hxeMomBa/yuhg2sKQbIP1WlyvHMyU6dLc6ty73KRlYL
 9mJ6P1BtaCLkQ==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [PATCH v4 1/2] virtio: kerneldocs fixes and enhancements
Date: Wed, 10 Aug 2022 11:40:03 +0200
Message-Id: <20220810094004.1250-2-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
References: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Cc: mst@redhat.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, bagasdotme@gmail.com,
 kernel@collabora.com
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

Rml4IHZhcmlhYmxlIG5hbWVzIGluIHNvbWUga2VybmVsZG9jcywgbmFtaW5nIGluIG90aGVycy4K
QWRkIGtlcm5lbGRvY3MgZm9yIHN0cnVjdCB2cmluZ19kZXNjIGFuZCB2cmluZ19pbnRlcnJ1cHQu
CgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIENhw7F1ZWxvIDxyaWNhcmRvLmNhbnVlbG9AY29sbGFi
b3JhLmNvbT4KLS0tCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICB8ICA4ICsrKysr
KysrCiBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICB8ICA2ICsrKy0tLQogaW5jbHVk
ZS9saW51eC92aXJ0aW9fY29uZmlnLmggICAgfCAgNiArKystLS0KIGluY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcmluZy5oIHwgMTYgKysrKysrKysrKystLS0tLQogNCBmaWxlcyBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwppbmRleCBh
NWVjNzI0YzAxZDguLjZlNWRhYTE5Y2ExYiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYworKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCkBAIC0yMTQ3LDYg
KzIxNDcsMTQgQEAgc3RhdGljIGlubGluZSBib29sIG1vcmVfdXNlZChjb25zdCBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSkKIAlyZXR1cm4gdnEtPnBhY2tlZF9yaW5nID8gbW9yZV91c2VkX3Bh
Y2tlZCh2cSkgOiBtb3JlX3VzZWRfc3BsaXQodnEpOwogfQogCisvKioKKyAqIHZyaW5nX2ludGVy
cnVwdCAtIG5vdGlmeSBhIHZpcnRxdWV1ZSBvbiBhbiBpbnRlcnJ1cHQKKyAqIEBpcnE6IHRoZSBJ
UlEgbnVtYmVyIChpZ25vcmVkKQorICogQF92cTogdGhlIHN0cnVjdCB2aXJ0cXVldWUgdG8gbm90
aWZ5CisgKgorICogQ2FsbHMgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uIG9mIEBfdnEgdG8gcHJvY2Vz
cyB0aGUgdmlydHF1ZXVlCisgKiBub3RpZmljYXRpb24uCisgKi8KIGlycXJldHVybl90IHZyaW5n
X2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpfdnEpCiB7CiAJc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEgPSB0b192dnEoX3ZxKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgg
Yi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCmluZGV4IGQ4ZmRmMTcwNjM3Yy4uZmQ4NDQwZTg1OTMz
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCisrKyBiL2luY2x1ZGUvbGludXgv
dmlydGlvLmgKQEAgLTExLDcgKzExLDcgQEAKICNpbmNsdWRlIDxsaW51eC9nZnAuaD4KIAogLyoq
Ci0gKiB2aXJ0cXVldWUgLSBhIHF1ZXVlIHRvIHJlZ2lzdGVyIGJ1ZmZlcnMgZm9yIHNlbmRpbmcg
b3IgcmVjZWl2aW5nLgorICogc3RydWN0IHZpcnRxdWV1ZSAtIGEgcXVldWUgdG8gcmVnaXN0ZXIg
YnVmZmVycyBmb3Igc2VuZGluZyBvciByZWNlaXZpbmcuCiAgKiBAbGlzdDogdGhlIGNoYWluIG9m
IHZpcnRxdWV1ZXMgZm9yIHRoaXMgZGV2aWNlCiAgKiBAY2FsbGJhY2s6IHRoZSBmdW5jdGlvbiB0
byBjYWxsIHdoZW4gYnVmZmVycyBhcmUgY29uc3VtZWQgKGNhbiBiZSBOVUxMKS4KICAqIEBuYW1l
OiB0aGUgbmFtZSBvZiB0aGlzIHZpcnRxdWV1ZSAobWFpbmx5IGZvciBkZWJ1Z2dpbmcpCkBAIC05
MCw3ICs5MCw3IEBAIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKHN0cnVjdCB2
aXJ0cXVldWUgKnZxKTsKIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF91c2VkX2FkZHIoc3RydWN0
IHZpcnRxdWV1ZSAqdnEpOwogCiAvKioKLSAqIHZpcnRpb19kZXZpY2UgLSByZXByZXNlbnRhdGlv
biBvZiBhIGRldmljZSB1c2luZyB2aXJ0aW8KKyAqIHN0cnVjdCB2aXJ0aW9fZGV2aWNlIC0gcmVw
cmVzZW50YXRpb24gb2YgYSBkZXZpY2UgdXNpbmcgdmlydGlvCiAgKiBAaW5kZXg6IHVuaXF1ZSBw
b3NpdGlvbiBvbiB0aGUgdmlydGlvIGJ1cwogICogQGZhaWxlZDogc2F2ZWQgdmFsdWUgZm9yIFZJ
UlRJT19DT05GSUdfU19GQUlMRUQgYml0IChmb3IgcmVzdG9yZSkKICAqIEBjb25maWdfZW5hYmxl
ZDogY29uZmlndXJhdGlvbiBjaGFuZ2UgcmVwb3J0aW5nIGVuYWJsZWQKQEAgLTE0Niw3ICsxNDYs
NyBAQCBzaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
dik7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeSh2cSwgJnZkZXYtPnZxcywgbGlzdCkKIAogLyoqCi0g
KiB2aXJ0aW9fZHJpdmVyIC0gb3BlcmF0aW9ucyBmb3IgYSB2aXJ0aW8gSS9PIGRyaXZlcgorICog
c3RydWN0IHZpcnRpb19kcml2ZXIgLSBvcGVyYXRpb25zIGZvciBhIHZpcnRpbyBJL08gZHJpdmVy
CiAgKiBAZHJpdmVyOiB1bmRlcmx5aW5nIGRldmljZSBkcml2ZXIgKHBvcHVsYXRlIG5hbWUgYW5k
IG93bmVyKS4KICAqIEBpZF90YWJsZTogdGhlIGlkcyBzZXJ2aWNlZCBieSB0aGlzIGRyaXZlci4K
ICAqIEBmZWF0dXJlX3RhYmxlOiBhbiBhcnJheSBvZiBmZWF0dXJlIG51bWJlcnMgc3VwcG9ydGVk
IGJ5IHRoaXMgZHJpdmVyLgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmln
LmggYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAppbmRleCBiNDdjMmU3ZWQwZWUuLjIy
N2E5ZmY1MzcxZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKKysr
IGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKQEAgLTIyNSw3ICsyMjUsNyBAQCBpbnQg
dmlydGlvX2ZpbmRfdnFzX2N0eChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQg
bnZxcywKIAogLyoqCiAgKiB2aXJ0aW9fc3luY2hyb25pemVfY2JzIC0gc3luY2hyb25pemUgd2l0
aCB2aXJ0cXVldWUgY2FsbGJhY2tzCi0gKiBAdmRldjogdGhlIGRldmljZQorICogQGRldjogdGhl
IHZpcnRpbyBkZXZpY2UKICAqLwogc3RhdGljIGlubGluZQogdm9pZCB2aXJ0aW9fc3luY2hyb25p
emVfY2JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCkBAIC0yNDQsNyArMjQ0LDcgQEAgdm9p
ZCB2aXJ0aW9fc3luY2hyb25pemVfY2JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCiAKIC8q
KgogICogdmlydGlvX2RldmljZV9yZWFkeSAtIGVuYWJsZSB2cSB1c2UgaW4gcHJvYmUgZnVuY3Rp
b24KLSAqIEB2ZGV2OiB0aGUgZGV2aWNlCisgKiBAZGV2OiB0aGUgdmlydGlvIGRldmljZQogICoK
ICAqIERyaXZlciBtdXN0IGNhbGwgdGhpcyB0byB1c2UgdnFzIGluIHRoZSBwcm9iZSBmdW5jdGlv
bi4KICAqCkBAIC0yOTIsNyArMjkyLDcgQEAgY29uc3QgY2hhciAqdmlydGlvX2J1c19uYW1lKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQogLyoqCiAgKiB2aXJ0cXVldWVfc2V0X2FmZmluaXR5
IC0gc2V0dGluZyBhZmZpbml0eSBmb3IgYSB2aXJ0cXVldWUKICAqIEB2cTogdGhlIHZpcnRxdWV1
ZQotICogQGNwdTogdGhlIGNwdSBuby4KKyAqIEBjcHVfbWFzazogdGhlIGNwdSBtYXNrCiAgKgog
ICogUGF5IGF0dGVudGlvbiB0aGUgZnVuY3Rpb24gYXJlIGJlc3QtZWZmb3J0OiB0aGUgYWZmaW5p
dHkgaGludCBtYXkgbm90IGJlIHNldAogICogZHVlIHRvIGNvbmZpZyBzdXBwb3J0LCBpcnEgdHlw
ZSBhbmQgc2hhcmluZy4KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmlu
Zy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgKaW5kZXggNDc2ZDNlNWMwZmU3
Li5mOGMyMGQzZGU4ZGEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmlu
Zy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmluZy5oCkBAIC05MywxNSArOTMs
MjEgQEAKICNkZWZpbmUgVlJJTkdfVVNFRF9BTElHTl9TSVpFIDQKICNkZWZpbmUgVlJJTkdfREVT
Q19BTElHTl9TSVpFIDE2CiAKLS8qIFZpcnRpbyByaW5nIGRlc2NyaXB0b3JzOiAxNiBieXRlcy4g
IFRoZXNlIGNhbiBjaGFpbiB0b2dldGhlciB2aWEgIm5leHQiLiAqLworLyoqCisgKiBzdHJ1Y3Qg
dnJpbmdfZGVzYyAtIFZpcnRpbyByaW5nIGRlc2NyaXB0b3JzLAorICogMTYgYnl0ZXMgbG9uZy4g
VGhlc2UgY2FuIGNoYWluIHRvZ2V0aGVyIHZpYSBAbmV4dC4KKyAqCisgKiBAYWRkcjogYnVmZmVy
IGFkZHJlc3MgKGd1ZXN0LXBoeXNpY2FsKQorICogQGxlbjogYnVmZmVyIGxlbmd0aAorICogQGZs
YWdzOiBkZXNjcmlwdG9yIGZsYWdzCisgKiBAbmV4dDogaW5kZXggb2YgdGhlIG5leHQgZGVzY3Jp
cHRvciBpbiB0aGUgY2hhaW4sCisgKiAgICAgICAgaWYgdGhlIFZSSU5HX0RFU0NfRl9ORVhUIGZs
YWcgaXMgc2V0LiBXZSBjaGFpbiB1bnVzZWQKKyAqICAgICAgICBkZXNjcmlwdG9ycyB2aWEgdGhp
cywgdG9vLgorICovCiBzdHJ1Y3QgdnJpbmdfZGVzYyB7Ci0JLyogQWRkcmVzcyAoZ3Vlc3QtcGh5
c2ljYWwpLiAqLwogCV9fdmlydGlvNjQgYWRkcjsKLQkvKiBMZW5ndGguICovCiAJX192aXJ0aW8z
MiBsZW47Ci0JLyogVGhlIGZsYWdzIGFzIGluZGljYXRlZCBhYm92ZS4gKi8KIAlfX3ZpcnRpbzE2
IGZsYWdzOwotCS8qIFdlIGNoYWluIHVudXNlZCBkZXNjcmlwdG9ycyB2aWEgdGhpcywgdG9vICov
CiAJX192aXJ0aW8xNiBuZXh0OwogfTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
