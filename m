Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D68C433F5
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 20:49:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B2C60174
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 20:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4B2C60174
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A7C0404BE;
	Fri,  5 Nov 2021 20:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsEiSnS-MRpi; Fri,  5 Nov 2021 20:49:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A701F400BE;
	Fri,  5 Nov 2021 20:49:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 847FBC0012;
	Fri,  5 Nov 2021 20:49:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAE06C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 20:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3783407A0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 20:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tj7lpp9gcjN6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 20:49:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 549504079E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 20:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ySLsC1EnSHimHBNUlj4wMuCQlyV8d7jeRRm16O5I0YQ=; b=nbyUmWxKe75XmHh/B1M49l+ZYg
 xydu1gbFE1IVOdoZKzlSzVNMrhyuliAV+isL++SJKmBl8FKDNUM0s2TXpNODJzCpTpL9iSboepK/L
 o3rZ4Qu4aDBKukchw8NGmi1eIDpD3B2EuHuAwFV6v9ssLFaG0nHhP5Znp2y1pYotYiH6xBpC/9rXl
 gDbKu4vE8p46AghHSh2Sr+VBHcrbJjfUljZ/omRlQAtYC/xMSlrWiyJ9dCOU7sqXHqKi2qPFQWOeq
 jrYzi+GX8FNcGXn2MPX2yF0q0nSJrQkmjL38649YV0bu1+hHz1IHrkEpxOw8CySv6vD+RQqPYsSyd
 3vEqOCag==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52208
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mj68x-0006pi-OU; Fri, 05 Nov 2021 21:48:59 +0100
Subject: Re: [PATCH v2 1/9] drm/format-helper: Export drm_fb_clip_offset()
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-2-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <31701408-4e54-58a4-93c9-c946ef2488af@tronnes.org>
Date: Fri, 5 Nov 2021 21:48:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101141532.26655-2-tzimmermann@suse.de>
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

CgpEZW4gMDEuMTEuMjAyMSAxNS4xNSwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gUHJvdmlk
ZSBhIGZ1bmN0aW9uIHRoYXQgY29tcHV0ZXMgdGhlIG9mZnNldCBpbnRvIGEgYmxpdCBkZXN0aW5h
dGlvbgo+IGJ1ZmZlci4gVGhpcyB3aWxsIGFsbG93IHRvIG1vdmUgZGVzdGluYXRpb24tYnVmZmVy
IGNsaXBwaW5nIGludG8gdGhlCj4gZm9ybWF0LWhlbHBlciBjYWxsZXJzLgo+IAo+IHYyOgo+IAkq
IHByb3ZpZGUgZG9jdW1lbnRhdGlvbiAoU2FtKQo+IAkqIHJldHVybiAndW5zaWduZWQgaW50JyAo
U2FtLCBOb3JhbGYpCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1lcm1hbm4gPHR6aW1t
ZXJtYW5uQHN1c2UuZGU+Cj4gLS0tCgpSZXZpZXdlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3Jh
bGZAdHJvbm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
