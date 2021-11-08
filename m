Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9FC433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 21:02:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3659461177
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 21:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3659461177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E776E4034F;
	Mon,  8 Nov 2021 21:02:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hE91XQN0B2Uk; Mon,  8 Nov 2021 21:02:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12B4340322;
	Mon,  8 Nov 2021 21:02:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEE02C0019;
	Mon,  8 Nov 2021 21:02:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8744C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 21:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C54D380E65
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 21:02:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w3_Oh_xblY2i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 21:02:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4093680E64
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V0YEk6A58sEIDXhILo4RK/OlyTDAV7LyAsAqZL6Dyvk=; b=Anlh4bv3FglAiUuqcdKKbEcLyH
 v8LtWBfpHwngaOh7KNsYHjR/8bDIGF0liowggGmVP+AxohGZmClvb2j9k3aM9rKxhFpG5X58Wg9NL
 NaaItiLrl5dJRT5hQIjyA/H7jWvtZsx2MjXYU3od71fDSXYDsjE7vLqyhv3IqBBMT9tFndgJqrk3h
 Dp6dgr5OsL1pu7mSjnU5GWg3lTFfQozYBxZ+GaXE33sRrEt0aksgyUAGtH+ROboWSvV/5zhINXdfE
 EIUlvvnc8+SEtDxo6NwJiNJiMWHreXroIGrsBbsVswnWmxYNNmTp2p+jSq8rlTAvVw55HDKetJ7bd
 vWTE49gw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:55184
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mkBmr-0003A0-SB; Mon, 08 Nov 2021 22:02:41 +0100
Subject: Re: [PATCH v2 9/9] drm: Clarify semantics of struct
 drm_mode_config.{min,max}_{width,height}
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-10-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <74ab5851-ce85-ef01-4514-f729f006b9ba@tronnes.org>
Date: Mon, 8 Nov 2021 22:02:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101141532.26655-10-tzimmermann@suse.de>
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

CgpEZW4gMDEuMTEuMjAyMSAxNS4xNSwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gQWRkIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24gb24gdGhlIHNlbWFudGljcyBvZiB0aGUgc2l6ZSBmaWVsZHMg
aW4KPiBzdHJ1Y3QgZHJtX21vZGVfY29uZmlnLiBBbHNvIGFkZCBhIFRPRE8gdG8gcmV2aWV3IGFs
bCBkcml2ZXIgZm9yCj4gY29ycmVjdCB1c2FnZSBvZiB0aGVzZSBmaWVsZHMuCj4gCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4gLS0tCgpB
Y2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
