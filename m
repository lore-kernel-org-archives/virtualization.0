Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6613EC433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 14:59:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91E060EFE
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 14:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E91E060EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4E1A401C3;
	Sun, 24 Oct 2021 14:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtXcmjZvTtQv; Sun, 24 Oct 2021 14:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F38E401BE;
	Sun, 24 Oct 2021 14:59:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 138D6C0012;
	Sun, 24 Oct 2021 14:59:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBA69C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 14:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4AF4401C3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 14:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dSSS6fpMmRt1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 14:59:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 702B7401BE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mGt45g+3Uptl4J+LwgYLyEKcGzvmwnpkpwsNy6uYnn8=; b=IHDWcrEChDmqoRiprgLGG3ChMb
 ATYJnA4iLlvnT1xm/iqXjOK2QaCZ7etVuOCAswpATbL9HhGaHXKXtmyhyqLo+J3vIUtNw5SxK+Avm
 1dZhZiEYDUKGoaf/GlKG3t2VF/wSak5FqY4ydqMDnHNLWOC+J/KoWXDlWhLYS95IrkUBwQEZNTTCD
 VMoaIPOjbLPLMJ0umoL5dWYVzFkBFj38bgpEU8DG1tryDqPYsSTr3J77T7QVaI5s5JU7KQX03FuyE
 Ae7MRcrbyF5aK6jliY1iNH/xLh/jaOhBf7KoqWtHNJXdzv4vrvjC0s83MaLgDqrM4IrxP2fjND+tC
 ZZA3S/9Q==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51803
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1meexs-00055a-T1; Sun, 24 Oct 2021 16:59:12 +0200
Subject: Re: [PATCH 5/9] drm/format-helper: Streamline blit-helper interface
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-6-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b5e7ebab-f740-050a-27a0-ec587c95ccfb@tronnes.org>
Date: Sun, 24 Oct 2021 16:59:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-6-tzimmermann@suse.de>
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
ZXN0aW5hdGlvbi1idWZmZXIgY2xpcHBpbmcgZnJvbSBmb3JtYXQtaGVscGVyIGJsaXQgZnVuY3Rp
b24gaW50bwo+IGNhbGxlci4gUmVuYW1lIGRybV9mYl9ibGl0X3JlY3RfZHN0Y2xpcCgpIHRvIGRy
bV9mYl9ibGl0X3RvaW8oKS4gRG9uZSBmb3IKPiBjb25zaXN0ZW5jeSB3aXRoIHRoZSByZXN0IG9m
IHRoZSBpbnRlcmZhY2UuIFJlbW92ZSBkcm1fZmJfYmxpdF9kc3RjbGlwKCksCj4gd2hpY2ggaXNu
J3QgcmVxdWlyZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+Cj4gLS0tCgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3Jh
bGZAdHJvbm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
