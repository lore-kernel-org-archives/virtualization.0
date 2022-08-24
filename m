Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468E8C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 07:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF9AA4161D;
	Wed, 24 Aug 2022 07:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF9AA4161D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NBG4l28CO9sf; Wed, 24 Aug 2022 07:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E140A402BA;
	Wed, 24 Aug 2022 07:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E140A402BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8847C0033;
	Wed, 24 Aug 2022 07:43:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80D53C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FBFB60773
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FBFB60773
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayX0lmw2_13e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A055D60B64
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A055D60B64
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.168.186.86])
 (Authenticated sender: fdalleau@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8D47219F72D;
 Wed, 24 Aug 2022 09:43:43 +0200 (CEST)
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/1] vsock: Fix stalled communication on vhost sockets
Date: Wed, 24 Aug 2022 09:42:51 +0200
Message-Id: <20220824074251.2336997-2-frederic.dalleau@docker.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220824074251.2336997-1-frederic.dalleau@docker.com>
References: <20220824074251.2336997-1-frederic.dalleau@docker.com>
MIME-Version: 1.0
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
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
 <frederic.dalleau@docker.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QWZ0ZXIga2VybmVsIHVwZ3JhZGUsIHdlIGZhY2VkIHNvbWUgc3RhbGxlZCBjb21tdW5pY2F0aW9u
IG9uIEh5cGVyViBWTXMKd2l0aCBvdXIgZ29sYW5nIGNsaWVudHMuIFdlIGJpc2VjdGVkIHRoZSBp
c3N1ZSB0byBwYXRjaApbYjNmN2ZkNTQ4ODFiY2JhNWRjNTI5OTM1ZjM4XSBhZl92c29jazogc2Vw
YXJhdGUgd2FpdCBkYXRhIGxvb3AKCldoZW4gdGhpcyBvY2N1cnJlZCB0aGUgZm9sbG93aW5nIHNl
cXVlbmNlIGFwcGVhcmVkIGluIGZ0cmFjZToKaHZzX3N0cmVhbV9oYXNfZGF0YSA8LSB2c29ja19j
b25uZWN0aWJsZV93YWl0X2RhdGEKaHZzX2NoYW5uZWxfY2IgPC0gdm1idXNfb25fZXZlbnQKaHZz
X25vdGlmeV9yZWN2X3ByZV9ibG9jayA8LSB2c29ja19jb25uZWN0aWJsZV93YWl0X2RhdGEKCkl0
IHR1cm5lZCBvdXQgdGhhdCBpdCB3YXMgcG9zc2libGUgdG8gZW50ZXIgaHZzX25vdGlmeV9yZWN2
X3ByZV9ibG9jawp3aXRoIGRhdGEgcGVuZGluZyBpbiB0aGUgc3RyZWFtLiBUaGlzIGlzIGJlY2F1
c2UgdGhlIGRhdGEgY29uZGl0aW9uIG11c3QKYmUgY2hlY2tlZCBiZXR3ZWVuIHByZXBhcmVfdG9f
d2FpdCBhbmQgc2NoZWR1bGUsIGlmIG5vdCB0aGUgcmVjZWl2ZXIgbWF5Cm5vdCBiZSB3b2tlbiB1
cCBpZiBhbiBldmVudCBvY2N1cnMgYWZ0ZXIgY2hlY2tpbmcgdGhlIGNvbmRpdGlvbiBhbmQKYmVm
b3JlIHByZXBhcmVfdG9fd2FpdC4gVGhpcyBwYXRjaCBtb3ZlcyBwcmVwYXJlX3RvX3dhaXQgY2Fs
bCBiZWZvcmUKdGhlIGNvbmRpdGlvbiBhbmQgYXQgdGhlIGVuZCBvZiBsb29wLCBzaW1pbGFyIHRv
IHdoYXQgaXMgZG9uZSBlbHNld2hlcmUKaW4gdGhlIHNhbWUgZmlsZS4KClNpZ25lZC1vZmYtYnk6
IEZyw6lkw6lyaWMgRGFsbGVhdSA8ZnJlZGVyaWMuZGFsbGVhdUBkb2NrZXIuY29tPgotLS0KIG5l
dC92bXdfdnNvY2svYWZfdnNvY2suYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L3Ztd192c29jay9hZl92c29j
ay5jIGIvbmV0L3Ztd192c29jay9hZl92c29jay5jCmluZGV4IGVlNDE4NzAxY2RlZS4uY2Q1ZTBk
YmNhYmUwIDEwMDY0NAotLS0gYS9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMKKysrIGIvbmV0L3Zt
d192c29jay9hZl92c29jay5jCkBAIC0xOTA0LDkgKzE5MDQsOSBAQCBzdGF0aWMgaW50IHZzb2Nr
X2Nvbm5lY3RpYmxlX3dhaXRfZGF0YShzdHJ1Y3Qgc29jayAqc2ssCiAJdnNrID0gdnNvY2tfc2so
c2spOwogCWVyciA9IDA7CiAJdHJhbnNwb3J0ID0gdnNrLT50cmFuc3BvcnQ7CisJcHJlcGFyZV90
b193YWl0KHNrX3NsZWVwKHNrKSwgd2FpdCwgVEFTS19JTlRFUlJVUFRJQkxFKTsKIAogCXdoaWxl
ICgoZGF0YSA9IHZzb2NrX2Nvbm5lY3RpYmxlX2hhc19kYXRhKHZzaykpID09IDApIHsKLQkJcHJl
cGFyZV90b193YWl0KHNrX3NsZWVwKHNrKSwgd2FpdCwgVEFTS19JTlRFUlJVUFRJQkxFKTsKIAog
CQlpZiAoc2stPnNrX2VyciAhPSAwIHx8CiAJCSAgICAoc2stPnNrX3NodXRkb3duICYgUkNWX1NI
VVRET1dOKSB8fApAQCAtMTkzNyw2ICsxOTM3LDcgQEAgc3RhdGljIGludCB2c29ja19jb25uZWN0
aWJsZV93YWl0X2RhdGEoc3RydWN0IHNvY2sgKnNrLAogCQkJZXJyID0gLUVBR0FJTjsKIAkJCWJy
ZWFrOwogCQl9CisJCXByZXBhcmVfdG9fd2FpdChza19zbGVlcChzayksIHdhaXQsIFRBU0tfSU5U
RVJSVVBUSUJMRSk7CiAJfQogCiAJZmluaXNoX3dhaXQoc2tfc2xlZXAoc2spLCB3YWl0KTsKLS0g
CjIuMzQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
