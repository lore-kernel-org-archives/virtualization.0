Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E925BC433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:33:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B6760F22
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96B6760F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25DEA40022;
	Sun, 24 Oct 2021 08:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id if1hA_KBOrE9; Sun, 24 Oct 2021 08:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 850C6401F9;
	Sun, 24 Oct 2021 08:33:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A35B8C0037;
	Sun, 24 Oct 2021 08:33:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C709C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E3B640342
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mg3iAr-Y8vKF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D012F4033F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H7HzjyYNwVZDLpgzpPdiysmiKwCwBzklPeiEZLIob20=; b=MU/A9jJnzJ1wan42GmGn8SY6aF
 vrvtaSK6CNc/2ahF+r3lH1ar2fq+1UqSZeFtpMI94WA3/wRl80+GNd89bS1DGVCkgTgTOdHBuhQZm
 2SsMJ0i0JWdrJqhY2mXHWi7Xc1RnfxpXSOTRF78GMWvBT0ATN8Yvt32lgmxWsKsNdgclrjeL7q3NJ
 joVX9gNSc9V/QLR24AwXK8yKXlOKDdSgkgheEF2otNo+8UbG0+GFVUPBsZK3FjyE+bigV8RQ1fHKw
 U9wcJ1cICDdBxD+Bv91nl0U21Jv6rKGVglenBsGHxzaJlheNN0TQg2xBgBlORFp3XRgthGacVPWGb
 WH1SdtGA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:56065
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1meYp2-0005UD-P2; Sun, 24 Oct 2021 10:25:40 +0200
Subject: Re: [PATCH 2/9] drm/format-helper: Rework format-helper memcpy
 functions
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-3-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <454a88ca-618d-3947-247a-52d8c5b4db08@tronnes.org>
Date: Sun, 24 Oct 2021 10:25:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-3-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpEZW4gMjIuMTAuMjAyMSAxNS4yOCwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gTW92ZSBk
ZXN0aW5hdGlvbi1idWZmZXIgY2xpcHBpbmcgZnJvbSBhbGwgZm9ybWF0LWhlbHBlciBtZW1jcHkK
PiBmdW5jdGlvbiBpbnRvIGNhbGxlcnMuIFN1cHBvcnQgZGVzdGluYXRpb24tYnVmZmVyIHBpdGNo
LiBPbmx5Cj4gZGlzdGluZ3Vpc2ggYmV0d2VlbiBzeXN0ZW0gYW5kIEkvTyBtZW1vcnksIGJ1dCB1
c2Ugc2FtZSBsb2dpYwo+IGV2ZXJ5d2hlcmUuCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFpp
bW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4gLS0tCgpUZXN0ZWQtYnk6IE5vcmFsZiBU
csO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVz
IDxub3JhbGZAdHJvbm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
