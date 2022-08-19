Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA6FC25B0E
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 06:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFD6260AFA;
	Fri, 19 Aug 2022 06:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFD6260AFA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=NLOr77bT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KF3VfdJyZJZh; Fri, 19 Aug 2022 06:07:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5AF660AE1;
	Fri, 19 Aug 2022 06:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5AF660AE1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CBE3C0032;
	Fri, 19 Aug 2022 06:07:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5D1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BD3460AFA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:07:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BD3460AFA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ucxNbcxNjTUJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:07:12 +0000 (UTC)
X-Greylist: delayed 00:05:12 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F77560AE1
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F77560AE1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 06:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1660889227;
 bh=MOCsnQKUtAhXlHqssFSM8e9zPQnE4nRVmCO+9ySWwD8=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=NLOr77bT7Q8lcW6IJGoxOjH8SdP/LaywGmiLVAcscSpR4Oo/Pxp3cQ6hsmlC27DYm
 v+Ckft4tH8KrhUcXgcYd/eKnknhTpYjspH+LfkoDJuCgOS1nOJOfz2cmcHRqxUBveG
 mDIDLvUy+MCNUYN0tKVfYdqEQ6nHkNIjk0Q1XW6Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.72]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1oLckm1T2a-003Jn6; Fri, 19
 Aug 2022 08:01:44 +0200
Message-ID: <f75cb32b7c262fe852c53544034f5b6047d29b65.camel@gmx.de>
Subject: Re: [PATCH v5 3/5] vduse: Support using userspace pages as bounce
 buffer
From: Mike Galbraith <efault@gmx.de>
To: Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
 mst@redhat.com,  xiaodong.liu@intel.com, maxime.coquelin@redhat.com,
 stefanha@redhat.com
Date: Fri, 19 Aug 2022 08:01:42 +0200
In-Reply-To: <20220803045523.23851-4-xieyongji@bytedance.com>
References: <20220803045523.23851-1-xieyongji@bytedance.com>
 <20220803045523.23851-4-xieyongji@bytedance.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:ID0sMTVYy3r3ajuvly3x/Qa+Opaue78Rbt3wTx4fEj5BT/3Hz53
 bdOlV+5UEOdhuXKQ2XhIpddyk9+zTTCmRJZrzHlOMhWcy8B5p/nyXLr/YYl/587a/uTlj4v
 7KWCHZ3Osyv4A79qGad8cDxLWuGo+y31xxYn3/D+Er4BLuJiAjtw2P4RANpdlqW9v8lncUG
 4/fndY1uK0k6eyLV8p/3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWqMvYXvK2g=:lE53Onaqs/5dERELl12Jji
 pMU6QpWTnNY6sKIEE2V9nqP0VmRS5bJptRJTr9B3vfcKGz8XN+a54ZgxD6leYDW6vWh1F3ew2
 uU9Rn2zJZgWtOViGGFjpvwUOPRSbLt/Gz8I8QOmyOuljMLuZmXrngOLcQNUpaO0G8L1NIM8Il
 5iZlQJ+V4NGa/t/JhoMqIoOAvmrXSKqr2ycp/IUE8hRQGgR9cBlc1af+fS8dSa3Yw5C3i4EPl
 9tF4DbwdH2K37hVzI1kQHF9Zo1kKFIDWTuUMSflLxATJwvmxOEPqY09Y1VtYjWcchfWA2I6y7
 9NAMViXh89cnOyojnA3M5q+ubuowAxq56IcJ5MwLFbGz0o3ZJUMVYDN5QUmXsB41Nzz0a+9v7
 FIKAh1xtmGmv2t/eLyVTaBx5EGdDEflbwRssW2PvN4sgbOFqme8iOFK1JySuqObNCylSSGdMk
 9mCmjW5JpN/mfGqHPC/dBQuPosKuzaYgHAftQ7KBl0/RpGIHdfTodtklg5pVSjBf/qYIsxldC
 Af8rDASwF36M1kVQEhzwsIDjAytKziWmrree0uaXgOlBwD+OC+kx03fugbe0tdDQoW965tN/S
 qrSzuD+Gboubs90UDeSn8NjjLF/POhOxR0zlHtIvibiKAjxQjxwkxen6nDmp3ru4lseis+bTz
 bvmjoj6uPa58uLggW3WfezmVrlFFgai0TP30lYgN1i33AIxkspiaG6BsvYlt2CV++V7m5g6V2
 SUNBV37gctkNL0a8EM/IzwBuY8bVPQRSDgaZ5L7kncDOXBWwdFTVIgmc+mJwoe3IWnkGWsPmo
 01piL/OMBKJnAua5f4Txc/60pmCczFhceDHrYbrcViXAGVCUotHYMMSQwL+sj0vBhvb8HoNIw
 jZl4XfabNnhvnrEW45N3oFh0lH8KuGwm84BBQPzvNhoVYrCGXePx9b5pElmmoSNYvmZhwMYNk
 AR3lqmUdXVsayGAJxaT1wZTjEFO2o0xCtSInbaSvsS3uXP1jRpNfwmrWGYuibb1v5iwn2Nji4
 XYTtNiVb58VZW4bo2MPWVPRwTAaIGiylETIoFXJlXvJRSUZ0z6D+HG402Z4mlhz9tdScASwCv
 +G/U+6gNJKSzWADDq8PTfQJNKNkoOGDT0fpUbmjaHpZD5gNIwOnV+UuKQ==
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 songmuchun@bytedance.com
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

R3JlZXRpbmdzLAoKT24gV2VkLCAyMDIyLTA4LTAzIGF0IDEyOjU1ICswODAwLCBYaWUgWW9uZ2pp
IHdyb3RlOgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvaW92YV9kb21h
aW4uaCBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvaW92YV9kb21haW4uaAo+IGluZGV4IDI3MjJk
OWI4ZTIxYS4uNGUwZTUwZTdhYzE1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3Vz
ZXIvaW92YV9kb21haW4uaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvaW92YV9kb21h
aW4uaAo+IEBAIC0xNCw2ICsxNCw3IEBACj4gwqAjaW5jbHVkZSA8bGludXgvaW92YS5oPgo+IMKg
I2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvdmhvc3Rf
aW90bGIuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3J3bG9jay5oPgogICAgICAgICAgICAgICAgICAg
Xl5eXl5eXl4KCkVybSwgdGhhdCBzaG91bGQgYmUgc3BpbmxvY2suaC4KCiNpZm5kZWYgX19MSU5V
WF9SV0xPQ0tfSAojZGVmaW5lIF9fTElOVVhfUldMT0NLX0gKCiNpZm5kZWYgX19MSU5VWF9TUElO
TE9DS19ICiMgZXJyb3IgInBsZWFzZSBkb24ndCBpbmNsdWRlIHRoaXMgZmlsZSBkaXJlY3RseSIK
I2VuZGlmCgpUaGlzIGJlbGF0ZWQgY29tbWVudCBpbnNwaXJlZCBieSBQUkVFTVBUX1JUIGJ1aWxk
IG1lZXRpbmcgdGhlIGFib3ZlIDopCgoJLU1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
