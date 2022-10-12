Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB4C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 06:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC89C82E14;
	Wed, 12 Oct 2022 06:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC89C82E14
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=I5oUlg20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHUw2vww0LBa; Wed, 12 Oct 2022 06:30:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3614982C3C;
	Wed, 12 Oct 2022 06:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3614982C3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E515C0033;
	Wed, 12 Oct 2022 06:30:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F37B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE0DF60BF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE0DF60BF2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=I5oUlg20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gh48R0aMMxoh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD17660AF4
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD17660AF4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B4926601704;
 Wed, 12 Oct 2022 07:30:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1665556216;
 bh=5MqHbTRYy6l5lgCvLwpmGQliNMEWJ6SYv1uoPV54uU0=;
 h=From:To:Cc:Subject:Date:From;
 b=I5oUlg2010s02KKwavLnrRqZUR6vdS0LPKReKmmIXB6loSpqlIBaI3ekwicvTgSqv
 +CrDWycXt4h/OyQx7SO84UpzJi0ib96bEZ62iyHpsDO0koOt4+jnUNLLytiuVaonUk
 8hoZbG5T3yAKqKtZN0bmborTstPea8A+qlpbkS/9AYxohasV2+T06tpj9vu1lXnViv
 O98syB5TeBnxGluEe1Y9se93T75Ac4pg8+gkcqcM1l/c3tciiIDUd67ljZOW+Q2lmw
 tfYwwoQ/SNggdjlD42uyE/cMDwEC37AZZj1/N26mIPjTVlr3XLxhWdy4JeIDW+Z7Ya
 ZlJhlyQ+8kyUA==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RESEND] tools/virtio: initialize spinlocks in vring_test.c
Date: Wed, 12 Oct 2022 08:29:49 +0200
Message-Id: <20221012062949.1526176-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kernel@collabora.com, mst@redhat.com
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

VGhlIHZpcnRpb19kZXZpY2UgdnFzX2xpc3Qgc3BpbmxvY2tzIG11c3QgYmUgaW5pdGlhbGl6ZWQg
YmVmb3JlIHVzZSB0bwpwcmV2ZW50IGZ1bmN0aW9ucyB0aGF0IG1hbmlwdWxhdGUgdGhlIGRldmlj
ZSB2aXJ0dWFscXVldWVzLCBzdWNoIGFzCnZyaW5nX25ld192aXJ0cXVldWUoKSwgZnJvbSBibG9j
a2luZyBpbmRlZmluaXRlbHkuCgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIENhw7F1ZWxvIDxyaWNh
cmRvLmNhbnVlbG9AY29sbGFib3JhLmNvbT4KLS0tCiB0b29scy92aXJ0aW8vdnJpbmdoX3Rlc3Qu
YyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90
b29scy92aXJ0aW8vdnJpbmdoX3Rlc3QuYyBiL3Rvb2xzL3ZpcnRpby92cmluZ2hfdGVzdC5jCmlu
ZGV4IGZhODdiNThiZDVmYS4uOThmZjgwOGQ2ZjBjIDEwMDY0NAotLS0gYS90b29scy92aXJ0aW8v
dnJpbmdoX3Rlc3QuYworKysgYi90b29scy92aXJ0aW8vdnJpbmdoX3Rlc3QuYwpAQCAtMzA4LDYg
KzMwOCw3IEBAIHN0YXRpYyBpbnQgcGFyYWxsZWxfdGVzdCh1NjQgZmVhdHVyZXMsCiAKIAkJZ3Zk
ZXYudmRldi5mZWF0dXJlcyA9IGZlYXR1cmVzOwogCQlJTklUX0xJU1RfSEVBRCgmZ3ZkZXYudmRl
di52cXMpOworCQlzcGluX2xvY2tfaW5pdCgmZ3ZkZXYudmRldi52cXNfbGlzdF9sb2NrKTsKIAkJ
Z3ZkZXYudG9faG9zdF9mZCA9IHRvX2hvc3RbMV07CiAJCWd2ZGV2Lm5vdGlmaWVzID0gMDsKIApA
QCAtNDU1LDYgKzQ1Niw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJZ2V0
cmFuZ2UgPSBnZXRyYW5nZV9pb3Y7CiAJdmRldi5mZWF0dXJlcyA9IDA7CiAJSU5JVF9MSVNUX0hF
QUQoJnZkZXYudnFzKTsKKwlzcGluX2xvY2tfaW5pdCgmdmRldi52cXNfbGlzdF9sb2NrKTsKIAog
CXdoaWxlIChhcmd2WzFdKSB7CiAJCWlmIChzdHJjbXAoYXJndlsxXSwgIi0taW5kaXJlY3QiKSA9
PSAwKQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
