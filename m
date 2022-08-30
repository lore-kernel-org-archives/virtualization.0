Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F67FECAAD4
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 09:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFD5F410B9;
	Tue, 30 Aug 2022 09:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFD5F410B9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DC0eO+CY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZdljSfxQ1Xa7; Tue, 30 Aug 2022 09:21:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7C0E410A1;
	Tue, 30 Aug 2022 09:21:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7C0E410A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0D6AC0032;
	Tue, 30 Aug 2022 09:21:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98B6CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 664C3813BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:21:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 664C3813BC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=DC0eO+CY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZylE5u2tQNAc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:21:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E090C813B9
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E090C813B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D83F66601BF7;
 Tue, 30 Aug 2022 10:21:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1661851298;
 bh=5MqHbTRYy6l5lgCvLwpmGQliNMEWJ6SYv1uoPV54uU0=;
 h=From:To:Cc:Subject:Date:From;
 b=DC0eO+CY+5+DsUP6AVVgORDfHToYFIuWnjvJo71+AAOvP8B876gZF/faMOUhMyL/V
 EU8gKiJzqAkIhswI3P1WLcBApwA5eVnY5XYpZKRzqzArMmTY4n8sRQebVBhZddJOoo
 4aF+eHEXOxkhLglrxIUzJpZG6ZZllhRGXm9cFH+/Wg0YQMeMahYZbVCWUitrphZjfB
 l8r41/uwDLtkBCIvom544zBmDLO7oqavjpEUa5vp33x98e6e9UEot5Pqnlm+4fPZ06
 ZsoRAxgb4i29Nm2xmLGLNzAf4m/jrDC8VhYVxlyrYbK8bh8Ab1k5SJe4P/Amdparw5
 GSfaTWCc9QD0Q==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RESEND] tools/virtio: initialize spinlocks in vring_test.c
Date: Tue, 30 Aug 2022 11:21:04 +0200
Message-Id: <20220830092104.637070-1-ricardo.canuelo@collabora.com>
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
