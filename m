Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACBC433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A607261051
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A607261051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 676A240264;
	Mon,  1 Nov 2021 14:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SvXx6rqA4-6q; Mon,  1 Nov 2021 14:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D9D2B40255;
	Mon,  1 Nov 2021 14:15:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CFFEC0023;
	Mon,  1 Nov 2021 14:15:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62ED2C0023
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50C034024C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yN7e-qzd0-tg
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F3CD400BD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B16421FD76;
 Mon,  1 Nov 2021 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635776136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBHgiHuqCfBFiBqdtgPNsgJGdnZyaBZsccEznn1hKBw=;
 b=vTPQCSvaDymhoWdqZUf9JycsWNvnJ+4yt2kaq8479BmSP/MiDBlcHxKsvLAybhVrWChpv8
 6C41VZ3PoD+E91tT7LHMZfkBRKhahIOpw6GfY2Qygdv0QiahpKP9M1nTVdoxBHMC4V95u8
 8sg5ppjfHxUxvxF/W/mcAMrOp/+N7gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635776136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBHgiHuqCfBFiBqdtgPNsgJGdnZyaBZsccEznn1hKBw=;
 b=xVseMeQhipMaeYqAmPZ/ASRvHWLF0kDpYs08TmvIHc1aqbH+XmCguAJnGVMCju3bGe2F9x
 p8NxjJOCxPZAhvDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AE761342A;
 Mon,  1 Nov 2021 14:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qHgoEYj2f2GlHwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v2 6/9] drm/fb-helper: Allocate shadow buffer of surface height
Date: Mon,  1 Nov 2021 15:15:29 +0100
Message-Id: <20211101141532.26655-7-tzimmermann@suse.de>
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

QWxsb2NhdGluZyBhIHNoYWRvdyBidWZmZXIgb2YgdGhlIGhlaWdodCBvZiB0aGUgYnVmZmVyIG9i
amVjdCBkb2VzCm5vdCBzdXBwb3J0IGZiZGV2IG92ZXJhbGxvY2F0aW9uLiBVc2Ugc3VyZmFjZSBo
ZWlnaHQgaW5zdGVhZC4KClNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVy
bWFubkBzdXNlLmRlPgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5l
cy5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZmJfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hl
bHBlci5jCmluZGV4IDhlN2ExMjRkNmM1YS4uOTcyN2E1OWQzNWZkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vZHJtX2ZiX2hlbHBlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZmJf
aGVscGVyLmMKQEAgLTIzMzgsNyArMjMzOCw3IEBAIHN0YXRpYyBpbnQgZHJtX2ZiX2hlbHBlcl9n
ZW5lcmljX3Byb2JlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIsCiAJCXJldHVybiBQ
VFJfRVJSKGZiaSk7CiAKIAlmYmktPmZib3BzID0gJmRybV9mYmRldl9mYl9vcHM7Ci0JZmJpLT5z
Y3JlZW5fc2l6ZSA9IGZiLT5oZWlnaHQgKiBmYi0+cGl0Y2hlc1swXTsKKwlmYmktPnNjcmVlbl9z
aXplID0gc2l6ZXMtPnN1cmZhY2VfaGVpZ2h0ICogZmItPnBpdGNoZXNbMF07CiAJZmJpLT5maXgu
c21lbV9sZW4gPSBmYmktPnNjcmVlbl9zaXplOwogCiAJZHJtX2ZiX2hlbHBlcl9maWxsX2luZm8o
ZmJpLCBmYl9oZWxwZXIsIHNpemVzKTsKLS0gCjIuMzMuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
