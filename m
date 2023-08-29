Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A0AC83F12
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DA4181FC4;
	Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DA4181FC4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=H27OUgf1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p6o7Iz6lYMoc; Tue, 29 Aug 2023 13:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2227281D0B;
	Tue, 29 Aug 2023 13:32:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2227281D0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFBC7C0039;
	Tue, 29 Aug 2023 13:32:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3F9AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A3F881CE3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A3F881CE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YMiOJKPPWfxv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45A1981D0C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45A1981D0C
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 762A164330;
 Tue, 29 Aug 2023 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00EDC433C8;
 Tue, 29 Aug 2023 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693315943;
 bh=8V1JkwAzu5VZdGESa+X98BKD0oGzH8Czi5Y7HrS2MII=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H27OUgf17NJiTTpfEV7/ZUkTNcsWTDQBxVrkqhdi6o8bdHaTJoOFshzVM1/HsttUC
 C5qdy5r4h7DxdjIa6Dp16RqFLb9WBOlhVsXd45OVfHWBUJWTGmPEegPsUfxMV68X+x
 ooLaC5EQtZRANl+BhJYD98F9OQLlDL+URAr/aw2p05GMbHLID2lSnjDZMxMzdhGO/I
 100e/HSiNYBF4Kh7gzsj/4r/NKgfySpZz4XoF65wB3eFw/8i6rlC8IG+VJCJxb7oeS
 Ydm4NQoybQa7vEbJa+ocewKo3NESnajQcsiMxaeqMwbHHPOkS/JHh41quM/P4cKddF
 5y472jtW0n5XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 05/17] vdpa/mlx5: Correct default number of queues
 when MQ is on
Date: Tue, 29 Aug 2023 09:31:52 -0400
Message-Id: <20230829133211.519957-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, elic@nvidia.com
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

RnJvbTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+CgpbIFVwc3RyZWFtIGNv
bW1pdCAzZmUwMjQxOTMzNDBiMjI1ZDFmZDQxMGQ3OGM0OTU0MzRhOWQ2OGUwIF0KClRoZSBzdGFu
ZGFyZCBzcGVjaWZpZXMgdGhhdCB0aGUgaW5pdGlhbCBudW1iZXIgb2YgcXVldWVzIGlzIHRoZQpk
ZWZhdWx0LCB3aGljaCBpcyAxICgxIHR4LCAxIHJ4KS4KClNpZ25lZC1vZmYtYnk6IERyYWdvcyBU
YXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgpSZXZpZXdlZC1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIzMDcyNzE3MjM1NC42ODI0My0y
LWR0YXR1bGVhQG52aWRpYS5jb20+ClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgpUZXN0ZWQtYnk6IExlaSBZYW5nIDxsZWl5YW5nQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6
IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgfCAxMCArKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4IDI3
OWFjNmE1NThkMjkuLjkzYTI1MjAyMjNiNjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
QEAgLTI0NDcsNyArMjQ0NywxNSBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfZHJpdmVyX2Zl
YXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQogCWVsc2UKIAkJ
bmRldi0+cnF0X3NpemUgPSAxOwogCi0JbmRldi0+Y3VyX251bV92cXMgPSAyICogbmRldi0+cnF0
X3NpemU7CisJLyogRGV2aWNlIG11c3Qgc3RhcnQgd2l0aCAxIHF1ZXVlIHBhaXIsIGFzIHBlciBW
SVJUSU8gdjEuMiBzcGVjLCBzZWN0aW9uCisJICogNS4xLjYuNS41ICJEZXZpY2Ugb3BlcmF0aW9u
IGluIG11bHRpcXVldWUgbW9kZSI6CisJICoKKwkgKiBNdWx0aXF1ZXVlIGlzIGRpc2FibGVkIGJ5
IGRlZmF1bHQuCisJICogVGhlIGRyaXZlciBlbmFibGVzIG11bHRpcXVldWUgYnkgc2VuZGluZyBh
IGNvbW1hbmQgdXNpbmcgY2xhc3MKKwkgKiBWSVJUSU9fTkVUX0NUUkxfTVEuIFRoZSBjb21tYW5k
IHNlbGVjdHMgdGhlIG1vZGUgb2YgbXVsdGlxdWV1ZQorCSAqIG9wZXJhdGlvbiwgYXMgZm9sbG93
czogLi4uCisJICovCisJbmRldi0+Y3VyX251bV92cXMgPSAyOwogCiAJdXBkYXRlX2N2cV9pbmZv
KG12ZGV2KTsKIAlyZXR1cm4gZXJyOwotLSAKMi40MC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
