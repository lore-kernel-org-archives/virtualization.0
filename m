Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2973C433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84EC61051
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A84EC61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 358FE80D1C;
	Mon,  1 Nov 2021 14:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Snu9SjNblRXb; Mon,  1 Nov 2021 14:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 623C480D12;
	Mon,  1 Nov 2021 14:15:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C438C0047;
	Mon,  1 Nov 2021 14:15:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C624CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FBD280CE9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LH_fGpY_oYjP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B62AD80CE2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B67B1FD79;
 Mon,  1 Nov 2021 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635776138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzJUJVX8BhIEyAhs3xoMjzVdJLIuiN+AkSIr+7kNW1A=;
 b=gWkGst/R1qP2qRkp9UPyRrxC+E9mgmbTMXL+rbs+Myn7GGGOvlJjp3oVMPAy8XFq3ckRPt
 R3X4DkBNHLewVbJI29rt53ePtGzDOTqfTpb9V79G8uz0LfihINXSJhusM5A2lLIsbNkDVs
 jO/NWOIvqlC2Nyomv2lfjmt3VdoKy+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635776138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzJUJVX8BhIEyAhs3xoMjzVdJLIuiN+AkSIr+7kNW1A=;
 b=Pb3I8e/7p6oEDkFjDh7kekxJbnkTglU8H16VZMNuQ7FWbSf0N2NaMh9Ljq8R13YIXXiSDe
 4SonP46QGse4exAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 979D513A1F;
 Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wPgdJIn2f2GlHwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v2 9/9] drm: Clarify semantics of struct drm_mode_config.{min,
 max}_{width, height}
Date: Mon,  1 Nov 2021 15:15:32 +0100
Message-Id: <20211101141532.26655-10-tzimmermann@suse.de>
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

QWRkIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gb24gdGhlIHNlbWFudGljcyBvZiB0aGUgc2l6ZSBm
aWVsZHMgaW4Kc3RydWN0IGRybV9tb2RlX2NvbmZpZy4gQWxzbyBhZGQgYSBUT0RPIHRvIHJldmll
dyBhbGwgZHJpdmVyIGZvcgpjb3JyZWN0IHVzYWdlIG9mIHRoZXNlIGZpZWxkcy4KClNpZ25lZC1v
ZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgotLS0KIERvY3Vt
ZW50YXRpb24vZ3B1L3RvZG8ucnN0ICAgIHwgMTUgKysrKysrKysrKysrKysrCiBpbmNsdWRlL2Ry
bS9kcm1fbW9kZV9jb25maWcuaCB8IDEzICsrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ3B1L3RvZG8ucnN0
IGIvRG9jdW1lbnRhdGlvbi9ncHUvdG9kby5yc3QKaW5kZXggNjBkMWQ3ZWUwNzE5Li5mNGUxZDcy
MTQ5ZjcgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ3B1L3RvZG8ucnN0CisrKyBiL0RvY3Vt
ZW50YXRpb24vZ3B1L3RvZG8ucnN0CkBAIC00NjMsNiArNDYzLDIxIEBAIENvbnRhY3Q6IFRob21h
cyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPiwgQ2hyaXN0aWFuIEvDtm5pZywgRGFu
aWVsIFZldHRlCiAKIExldmVsOiBJbnRlcm1lZGlhdGUKIAorUmV2aWV3IGFsbCBkcml2ZXJzIGZv
ciBzZXR0aW5nIHN0cnVjdCBkcm1fbW9kZV9jb25maWcue21heF93aWR0aCxtYXhfaGVpZ2h0fSBj
b3JyZWN0bHkKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKK1RoZSB2YWx1ZXMgaW4g
c3RydWN0IGRybV9tb2RlX2NvbmZpZy57bWF4X3dpZHRoLG1heF9oZWlnaHR9IGRlc2NyaWJlIHRo
ZQorbWF4aW11bSBzdXBwb3J0ZWQgZnJhbWVidWZmZXIgc2l6ZS4gSXQncyB0aGUgdmlydHVhbCBz
Y3JlZW4gc2l6ZSwgYnV0IG1hbnkKK2RyaXZlcnMgdHJlYXQgaXQgbGlrZSBsaW1pdGF0aW9ucyBv
ZiB0aGUgcGh5c2ljYWwgcmVzb2x1dGlvbi4KKworVGhlIG1heGltdW0gd2lkdGggZGVwZW5kcyBv
biB0aGUgaGFyZHdhcmUncyBtYXhpbXVtIHNjYW5saW5lIHBpdGNoLiBUaGUKK21heGltdW0gaGVp
Z2h0IGRlcGVuZHMgb24gdGhlIGFtb3VudCBvZiBhZGRyZXNzYWJsZSB2aWRlbyBtZW1vcnkuIFJl
dmlldyBhbGwKK2RyaXZlcnMgdG8gaW5pdGlhbGl6ZSB0aGUgZmllbGRzIHRvIHRoZSBjb3JyZWN0
IHZhbHVlcy4KKworQ29udGFjdDogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2Uu
ZGU+CisKK0xldmVsOiBJbnRlcm1lZGlhdGUKKwogCiBDb3JlIHJlZmFjdG9yaW5ncwogPT09PT09
PT09PT09PT09PT0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5oIGIv
aW5jbHVkZS9kcm0vZHJtX21vZGVfY29uZmlnLmgKaW5kZXggNDhiN2RlODBkYWY1Li45MWNhNTc1
YTc4ZGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5oCisrKyBiL2lu
Y2x1ZGUvZHJtL2RybV9tb2RlX2NvbmZpZy5oCkBAIC0zNTksNiArMzU5LDE5IEBAIHN0cnVjdCBk
cm1fbW9kZV9jb25maWdfZnVuY3MgewogICogQ29yZSBtb2RlIHJlc291cmNlIHRyYWNraW5nIHN0
cnVjdHVyZS4gIEFsbCBDUlRDLCBlbmNvZGVycywgYW5kIGNvbm5lY3RvcnMKICAqIGVudW1lcmF0
ZWQgYnkgdGhlIGRyaXZlciBhcmUgYWRkZWQgaGVyZSwgYXMgYXJlIGdsb2JhbCBwcm9wZXJ0aWVz
LiAgU29tZQogICogZ2xvYmFsIHJlc3RyaWN0aW9ucyBhcmUgYWxzbyBoZXJlLCBlLmcuIGRpbWVu
c2lvbiByZXN0cmljdGlvbnMuCisgKgorICogRnJhbWVidWZmZXIgc2l6ZXMgcmVmZXIgdG8gdGhl
IHZpcnR1YWwgc2NyZWVuIHRoYXQgY2FuIGJlIGRpc3BsYXllZCBieQorICogdGhlIENSVEMuIFRo
aXMgY2FuIGJlIGRpZmZlcmVudCBmcm9tIHRoZSBwaHlzaWNhbCByZXNvbHV0aW9uIHByb2dyYW1t
ZWQuCisgKiBUaGUgbWluaW11bSB3aWR0aCBhbmQgaGVpZ2h0LCBzdG9yZWQgaW4gQG1pbl93aWR0
aCBhbmQgQG1pbl9oZWlnaHQsCisgKiBkZXNjcmliZSB0aGUgc21hbGxlc3Qgc2l6ZSBvZiB0aGUg
ZnJhbWVidWZmZXIuIEl0IGNvcnJlbGF0ZXMgdG8gdGhlCisgKiBtaW5pbXVtIHByb2dyYW1tYWJs
ZSByZXNvbHV0aW9uLgorICogVGhlIG1heGltdW0gd2lkdGgsIHN0b3JlZCBpbiBAbWF4X3dpZHRo
LCBpcyB0eXBpY2FsbHkgbGltaXRlZCBieSB0aGUKKyAqIG1heGltdW0gcGl0Y2ggYmV0d2VlbiB0
d28gYWRqYWNlbnQgc2NhbmxpbmVzLiBUaGUgbWF4aW11bSBoZWlnaHQsIHN0b3JlZAorICogaW4g
QG1heF9oZWlnaHQsIGlzIHVzdWFsbHkgb25seSBsaW1pdGVkIGJ5IHRoZSBhbW91bnQgb2YgYWRk
cmVzc2FibGUgdmlkZW8KKyAqIG1lbW9yeS4gRm9yIGhhcmR3YXJlIHRoYXQgaGFzIG5vIHJlYWwg
bWF4aW11bSwgZHJpdmVycyBzaG91bGQgcGljayBhCisgKiByZWFzb25hYmxlIGRlZmF1bHQuCisg
KgorICogU2VlIGFsc28gQERSTV9TSEFET1dfUExBTkVfTUFYX1dJRFRIIGFuZCBARFJNX1NIQURP
V19QTEFORV9NQVhfSEVJR0hULgogICovCiBzdHJ1Y3QgZHJtX21vZGVfY29uZmlnIHsKIAkvKioK
LS0gCjIuMzMuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
