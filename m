Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460EFC433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E117F61051
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E117F61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B93384026C;
	Mon,  1 Nov 2021 14:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B26MSNzzTlPQ; Mon,  1 Nov 2021 14:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45F834025B;
	Mon,  1 Nov 2021 14:15:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19010C0019;
	Mon,  1 Nov 2021 14:15:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C560C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C67680CD7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="WH3ZdXsa";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="R0FyTvhE"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txQQb6WfUGWC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5080B80CC7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56EE51FD6F;
 Mon,  1 Nov 2021 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635776135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9IsAhUPp4YEufnjjVcnaYqYgvCaKcbK5WsfVABAW7A=;
 b=WH3ZdXsaazwqQnHdCcdI2il0vrlGLYuSILiur+6R/iRH6rssi83dWDw9nPVbYJS4LpiGnV
 RSDYhh3YQ2BnmaPybxV+EJgfmIkYekrnk2saS2TMbxyCQFkQiq8R9kPqQn/4/IXVAXeqcT
 DfdWH/CRWKS3d7buN4hoccwWEZ5WVSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635776135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9IsAhUPp4YEufnjjVcnaYqYgvCaKcbK5WsfVABAW7A=;
 b=R0FyTvhE11opFsx17ogFpMoMlqAUMXHMTmEOwu3LRN/979ML+exFIo6mFHjDMdh91j0k8z
 PxT+B3QqPgieOqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D98A1139FD;
 Mon,  1 Nov 2021 14:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UE//M4b2f2GlHwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v2 3/9] drm/format-helper: Add destination-buffer pitch to
 drm_fb_swab()
Date: Mon,  1 Nov 2021 15:15:26 +0100
Message-Id: <20211101141532.26655-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101141532.26655-1-tzimmermann@suse.de>
References: <20211101141532.26655-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

QWRkIGRlc3RpbmF0aW9uLWJ1ZmZlciBwaXRjaCBhcyBhcmd1bWVudCB0byBkcm1fZmJfc3dhYigp
LiBEb25lIGZvcgpjb25zaXN0ZW5jeSB3aXRoIHRoZSByZXN0IG9mIHRoZSBpbnRlcmZhY2UuCgp2
MjoKCSogdXBkYXRlIGRvY3VtZW50YXRpb24gKE5vcmFsZikKClNpZ25lZC1vZmYtYnk6IFRob21h
cyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgpUZXN0ZWQtYnk6IE5vcmFsZiBUcsO4
bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxu
b3JhbGZAdHJvbm5lcy5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVy
LmMgfCAyMSArKysrKysrKysrKysrKysrLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fbWlwaV9k
YmkuYyAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9ndWQvZ3VkX3BpcGUuYyAgICAgIHwg
IDIgKy0KIGluY2x1ZGUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmggICAgIHwgIDUgKysrLS0KIDQg
ZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZm9ybWF0X2hlbHBlci5jCmluZGV4IGZhYzM3YzY5N2Q4Yi4uZGFjMzU1MzIwMjg3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuYwpAQCAtMTAxLDYgKzEwMSw3IEBAIEVYUE9S
VF9TWU1CT0woZHJtX2ZiX21lbWNweV90b2lvKTsKIC8qKgogICogZHJtX2ZiX3N3YWIgLSBTd2Fw
IGJ5dGVzIGludG8gY2xpcCBidWZmZXIKICAqIEBkc3Q6IERlc3RpbmF0aW9uIGJ1ZmZlcgorICog
QGRzdF9waXRjaDogTnVtYmVyIG9mIGJ5dGVzIGJldHdlZW4gdHdvIGNvbnNlY3V0aXZlIHNjYW5s
aW5lcyB3aXRoaW4gZHN0CiAgKiBAc3JjOiBTb3VyY2UgYnVmZmVyCiAgKiBAZmI6IERSTSBmcmFt
ZWJ1ZmZlcgogICogQGNsaXA6IENsaXAgcmVjdGFuZ2xlIGFyZWEgdG8gY29weQpAQCAtMTEwLDIx
ICsxMTEsMjcgQEAgRVhQT1JUX1NZTUJPTChkcm1fZmJfbWVtY3B5X3RvaW8pOwogICogdGltZSB0
byBzcGVlZCB1cCBzbG93IHVuY2FjaGVkIHJlYWRzLgogICoKICAqIFRoaXMgZnVuY3Rpb24gZG9l
cyBub3QgYXBwbHkgY2xpcHBpbmcgb24gZHN0LCBpLmUuIHRoZSBkZXN0aW5hdGlvbgotICogaXMg
YSBzbWFsbCBidWZmZXIgY29udGFpbmluZyB0aGUgY2xpcCByZWN0IG9ubHkuCisgKiBpcyBhdCB0
aGUgdG9wLWxlZnQgY29ybmVyLgogICovCi12b2lkIGRybV9mYl9zd2FiKHZvaWQgKmRzdCwgdm9p
ZCAqc3JjLCBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiwKLQkJIHN0cnVjdCBkcm1fcmVjdCAq
Y2xpcCwgYm9vbCBjYWNoZWQpCit2b2lkIGRybV9mYl9zd2FiKHZvaWQgKmRzdCwgdW5zaWduZWQg
aW50IGRzdF9waXRjaCwgY29uc3Qgdm9pZCAqc3JjLAorCQkgY29uc3Qgc3RydWN0IGRybV9mcmFt
ZWJ1ZmZlciAqZmIsIGNvbnN0IHN0cnVjdCBkcm1fcmVjdCAqY2xpcCwKKwkJIGJvb2wgY2FjaGVk
KQogewogCXU4IGNwcCA9IGZiLT5mb3JtYXQtPmNwcFswXTsKIAlzaXplX3QgbGVuID0gZHJtX3Jl
Y3Rfd2lkdGgoY2xpcCkgKiBjcHA7Ci0JdTE2ICpzcmMxNiwgKmRzdDE2ID0gZHN0OwotCXUzMiAq
c3JjMzIsICpkc3QzMiA9IGRzdDsKKwljb25zdCB1MTYgKnNyYzE2OworCWNvbnN0IHUzMiAqc3Jj
MzI7CisJdTE2ICpkc3QxNjsKKwl1MzIgKmRzdDMyOwogCXVuc2lnbmVkIGludCB4LCB5OwogCXZv
aWQgKmJ1ZiA9IE5VTEw7CiAKIAlpZiAoV0FSTl9PTl9PTkNFKGNwcCAhPSAyICYmIGNwcCAhPSA0
KSkKIAkJcmV0dXJuOwogCisJaWYgKCFkc3RfcGl0Y2gpCisJCWRzdF9waXRjaCA9IGxlbjsKKwog
CWlmICghY2FjaGVkKQogCQlidWYgPSBrbWFsbG9jKGxlbiwgR0ZQX0tFUk5FTCk7CiAKQEAgLTE0
MCw2ICsxNDcsOSBAQCB2b2lkIGRybV9mYl9zd2FiKHZvaWQgKmRzdCwgdm9pZCAqc3JjLCBzdHJ1
Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiwKIAkJCXNyYzMyID0gc3JjOwogCQl9CiAKKwkJZHN0MTYg
PSBkc3Q7CisJCWRzdDMyID0gZHN0OworCiAJCWZvciAoeCA9IGNsaXAtPngxOyB4IDwgY2xpcC0+
eDI7IHgrKykgewogCQkJaWYgKGNwcCA9PSA0KQogCQkJCSpkc3QzMisrID0gc3dhYjMyKCpzcmMz
MisrKTsKQEAgLTE0OCw2ICsxNTgsNyBAQCB2b2lkIGRybV9mYl9zd2FiKHZvaWQgKmRzdCwgdm9p
ZCAqc3JjLCBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiwKIAkJfQogCiAJCXNyYyArPSBmYi0+
cGl0Y2hlc1swXTsKKwkJZHN0ICs9IGRzdF9waXRjaDsKIAl9CiAKIAlrZnJlZShidWYpOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9taXBpX2RiaS5jIGIvZHJpdmVycy9ncHUvZHJt
L2RybV9taXBpX2RiaS5jCmluZGV4IGMwOWRmOGIwNmM3YS4uN2NlODk5MTdkNzYxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX21pcGlfZGJpLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2RybV9taXBpX2RiaS5jCkBAIC0yMTEsNyArMjExLDcgQEAgaW50IG1pcGlfZGJpX2J1Zl9jb3B5
KHZvaWQgKmRzdCwgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmIsCiAJc3dpdGNoIChmYi0+Zm9y
bWF0LT5mb3JtYXQpIHsKIAljYXNlIERSTV9GT1JNQVRfUkdCNTY1OgogCQlpZiAoc3dhcCkKLQkJ
CWRybV9mYl9zd2FiKGRzdCwgc3JjLCBmYiwgY2xpcCwgIWdlbS0+aW1wb3J0X2F0dGFjaCk7CisJ
CQlkcm1fZmJfc3dhYihkc3QsIDAsIHNyYywgZmIsIGNsaXAsICFnZW0tPmltcG9ydF9hdHRhY2gp
OwogCQllbHNlCiAJCQlkcm1fZmJfbWVtY3B5KGRzdCwgMCwgc3JjLCBmYiwgY2xpcCk7CiAJCWJy
ZWFrOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2d1ZC9ndWRfcGlwZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2d1ZC9ndWRfcGlwZS5jCmluZGV4IGE5MjExMmZmZDM3YS4uZTBiMTE3YjI1NTlm
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZ3VkL2d1ZF9waXBlLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2d1ZC9ndWRfcGlwZS5jCkBAIC0yMDEsNyArMjAxLDcgQEAgc3RhdGljIGludCBn
dWRfcHJlcF9mbHVzaChzdHJ1Y3QgZ3VkX2RldmljZSAqZ2RybSwgc3RydWN0IGRybV9mcmFtZWJ1
ZmZlciAqZmIsCiAJCQlsZW4gPSBndWRfeHJnYjg4ODhfdG9fY29sb3IoYnVmLCBmb3JtYXQsIHZh
ZGRyLCBmYiwgcmVjdCk7CiAJCX0KIAl9IGVsc2UgaWYgKGd1ZF9pc19iaWdfZW5kaWFuKCkgJiYg
Zm9ybWF0LT5jcHBbMF0gPiAxKSB7Ci0JCWRybV9mYl9zd2FiKGJ1ZiwgdmFkZHIsIGZiLCByZWN0
LCAhaW1wb3J0X2F0dGFjaCk7CisJCWRybV9mYl9zd2FiKGJ1ZiwgMCwgdmFkZHIsIGZiLCByZWN0
LCAhaW1wb3J0X2F0dGFjaCk7CiAJfSBlbHNlIGlmIChjb21wcmVzc2lvbiAmJiAhaW1wb3J0X2F0
dGFjaCAmJiBwaXRjaCA9PSBmYi0+cGl0Y2hlc1swXSkgewogCQkvKiBjYW4gY29tcHJlc3MgZGly
ZWN0bHkgZnJvbSB0aGUgZnJhbWVidWZmZXIgKi8KIAkJYnVmID0gdmFkZHIgKyByZWN0LT55MSAq
IHBpdGNoOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuaCBiL2lu
Y2x1ZGUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmgKaW5kZXggMWZjM2JhN2I2MDYwLi5kZGNiYTVh
YmUzMDYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmgKKysrIGIv
aW5jbHVkZS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuaApAQCAtMTcsOCArMTcsOSBAQCB2b2lkIGRy
bV9mYl9tZW1jcHkodm9pZCAqZHN0LCB1bnNpZ25lZCBpbnQgZHN0X3BpdGNoLCBjb25zdCB2b2lk
ICp2YWRkciwKIAkJICAgY29uc3Qgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmIsIGNvbnN0IHN0
cnVjdCBkcm1fcmVjdCAqY2xpcCk7CiB2b2lkIGRybV9mYl9tZW1jcHlfdG9pbyh2b2lkIF9faW9t
ZW0gKmRzdCwgdW5zaWduZWQgaW50IGRzdF9waXRjaCwgY29uc3Qgdm9pZCAqdmFkZHIsCiAJCQlj
b25zdCBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiwgY29uc3Qgc3RydWN0IGRybV9yZWN0ICpj
bGlwKTsKLXZvaWQgZHJtX2ZiX3N3YWIodm9pZCAqZHN0LCB2b2lkICpzcmMsIHN0cnVjdCBkcm1f
ZnJhbWVidWZmZXIgKmZiLAotCQkgc3RydWN0IGRybV9yZWN0ICpjbGlwLCBib29sIGNhY2hlZCk7
Cit2b2lkIGRybV9mYl9zd2FiKHZvaWQgKmRzdCwgdW5zaWduZWQgaW50IGRzdF9waXRjaCwgY29u
c3Qgdm9pZCAqc3JjLAorCQkgY29uc3Qgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmIsIGNvbnN0
IHN0cnVjdCBkcm1fcmVjdCAqY2xpcCwKKwkJIGJvb2wgY2FjaGVkKTsKIHZvaWQgZHJtX2ZiX3hy
Z2I4ODg4X3RvX3JnYjMzMih2b2lkICpkc3QsIHZvaWQgKnZhZGRyLCBzdHJ1Y3QgZHJtX2ZyYW1l
YnVmZmVyICpmYiwKIAkJCSAgICAgICBzdHJ1Y3QgZHJtX3JlY3QgKmNsaXApOwogdm9pZCBkcm1f
ZmJfeHJnYjg4ODhfdG9fcmdiNTY1KHZvaWQgKmRzdCwgdm9pZCAqdmFkZHIsCi0tIAoyLjMzLjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
