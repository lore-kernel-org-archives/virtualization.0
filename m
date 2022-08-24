Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84C3C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 07:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CABD81025;
	Wed, 24 Aug 2022 07:43:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CABD81025
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8x69oUjl-Xp; Wed, 24 Aug 2022 07:43:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB0E880DE9;
	Wed, 24 Aug 2022 07:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB0E880DE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77DF9C0033;
	Wed, 24 Aug 2022 07:43:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD769C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4A9F408D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4A9F408D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wn5dnQSGCV-7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9E8B4056F
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9E8B4056F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.168.186.86])
 (Authenticated sender: fdalleau@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id AB3B719F740;
 Wed, 24 Aug 2022 09:43:35 +0200 (CEST)
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/1] Stalled communication on Hyper V Sockets
Date: Wed, 24 Aug 2022 09:42:50 +0200
Message-Id: <20220824074251.2336997-1-frederic.dalleau@docker.com>
X-Mailer: git-send-email 2.34.1
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

SGksCgpBZnRlciB1cGdyYWRpbmcgb3VyIFZNcyBrZXJuZWwsIG91ciBnb2xhbmcgc29mdHdhcmUg
c3RhY2sgc3RhcnRlZCBmYWNpbmcKc29tZSBjb21tdW5pY2F0aW9uIHN0YWxsaW5nIG9uIEh5cGVy
ViBwbGF0Zm9ybXMuCgpBZnRlciByZWNlaXZpbmcgYSBmZXcgaHVuZGVyZWQgTUJzIGRhdGEgZnJv
bSBhIHZzb2NrZXQgaW4gdGhlIGd1ZXN0LAp0aGUgZGF0YSBmbG93cyBzdWRkZW5seSBzdG9wcywg
YW5kIHRoZSByZWNlaXZlciBpcyBub3Qgbm90aWZpZWQuIFRoZQpzZW5kZXIgb24gdGhlIGhvc3Qg
dGltZXMgb3V0LgoKU2luY2UgdGhlIHVzZSBjYXNlIGlzIHZlcnkgc2ltcGxlLCB3ZSB3ZXJlIHN1
cnByaXNlZCB0aGF0IGl0IHdhcyBub3QKcmVwb3J0ZWQsIHNvIHdlIHRvb2sgdGltZSB0byBpbnZl
c3RpZ2F0ZS4KClRoZSBpc3N1ZSB3YXMgYmlzZWN0ZWQgdG8gcGF0Y2ggYmVsb3cKW2IzZjdmZDU0
ODgxYmNiYTVkYzUyOTkzNWYzOF0gYWZfdnNvY2s6IHNlcGFyYXRlIHdhaXQgZGF0YSBsb29wCkZy
b20gdGhlcmUgZnRyYWNlIGFsbG93ZWQgdG8gc3BvdCB0aGUgcHJvYmxlbSwgbW9yZSBkZXRhaWxz
IGFyZSBpbiB0aGUKcGF0Y2ggZGVzY3JpcHRpb24uCgpJbiB0aGUgZW5kLCBub3RlIHRoYXQgdGhl
IHBhdGNoIGlzIG5vdCBIeXBlclYgc3BlY2lmaWMuIFNvIG1heWJlIHRoZQpyZXByb2R1Y3Rpb24g
cmF0ZSBpcyBsb3dlciBvbiBvdGhlciBwbGF0Zm9ybXMuCgpMZXQgbWUga25vdyB3aGF0IHlvdSB0
aGluaywKRnLDqWTDqXJpYyBEYWxsZWF1CgpGcsOpZMOpcmljIERhbGxlYXUgKDEpOgogIHZzb2Nr
OiBGaXggc3RhbGxlZCBjb21tdW5pY2F0aW9uIG9uIHZob3N0IHNvY2tldHMKCiBuZXQvdm13X3Zz
b2NrL2FmX3Zzb2NrLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKLS0gCjIuMzQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
