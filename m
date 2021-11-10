Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F8AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:34:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EC061105
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30EC061105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA89340417;
	Wed, 10 Nov 2021 12:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wB4LysrxwrCk; Wed, 10 Nov 2021 12:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5218040407;
	Wed, 10 Nov 2021 12:34:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 273DEC0019;
	Wed, 10 Nov 2021 12:34:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 338D6C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1206D4040B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDC20VTJxBf0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:34:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07A3840407
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xun289VLWWZ82saKfNnf5+f3tJJ0jkNDF5lxfzbWlmM=; b=QFuXmqRSBOQITyzJYF6V1YmiS0
 h2SeY3zlP8LbZEBribxQij+PUF98b77082ErPi+XFtV9WTx8Lm2caNKvwYBlmMrEGX1Do3ySBaQJK
 78Ae91Xix1ZRqgoxdADS7DupOSZCrsdJfztx6U5sBqa5ub5sGLciU8kdCxIETfHBvpAarGnXSoCzh
 1NKMZD8Uo75gKvsoBj7jhkAThGCO7SD24bkCC7ojIdSKEIcBKeHDdb6BYWsGm8O40Gx5k7Z3CMADk
 MpPiel7BDPK3RsZqvq1UN9WlgNgGcVJpp6L/3iUgN0BySvFRynZNTfngQOUe61KMN5PgoS6HwF5BC
 87oT5RGg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52473
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mkmnq-0005OW-GL; Wed, 10 Nov 2021 13:34:10 +0100
Subject: Re: [PATCH v3 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211110103702.374-1-tzimmermann@suse.de>
 <20211110103702.374-8-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0e762e67-b18f-3cbd-b401-d6766a7168a3@tronnes.org>
Date: Wed, 10 Nov 2021 13:34:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211110103702.374-8-tzimmermann@suse.de>
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

CgpEZW4gMTAuMTEuMjAyMSAxMS4zNywgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gRW5hYmxl
IHRoZSBGQl9EQU1BR0VfQ0xJUFMgcHJvcGVydHkgdG8gcmVkdWNlIGRpc3BsYXktdXBkYXRlCj4g
b3ZlcmhlYWQuIEFsc28gZml4ZXMgYSB3YXJuaW5nIGluIHRoZSBrZXJuZWwgbG9nLgo+IAo+ICAg
c2ltcGxlLWZyYW1lYnVmZmVyIHNpbXBsZS1mcmFtZWJ1ZmZlci4wOiBbZHJtXSBkcm1fcGxhbmVf
ZW5hYmxlX2ZiX2RhbWFnZV9jbGlwcygpIG5vdCBjYWxsZWQKPiAKPiBGaXggdGhlIGNvbXB1dGF0
aW9uIG9mIHRoZSBibGl0IHJlY3RhbmdsZS4gVGhpcyB3YXNuJ3QgYW4gaXNzdWUgc28KPiBmYXIs
IGFzIHNpbXBsZWRybSBhbHdheXMgYmxpdHRlZCB0aGUgZnVsbCBmcmFtZWJ1ZmZlci4gVGhlIGNv
ZGUgbm93Cj4gc3VwcG9ydHMgZGFtYWdlIGNsaXBwaW5nIGFuZCB2aXJ0dWFsIHNjcmVlbiBzaXpl
cy4KPiAKPiB2MzoKPiAJKiBmaXggZHJtX2Rldl9lbnRlcigpIGVycm9yIHBhdGggKE5vcmFsZikK
PiAJKiByZW1vdmUgdW5uZWNlc3NhcnkgY2xpcHBpbmcgZnJvbSB1cGRhdGUgZnVuY3Rpb24gKE5v
cmFsZikKPiAKPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KPiAtLS0KClJldmlld2VkLWJ5OiBOb3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0cm9u
bmVzLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
