Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF14C48BCD
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3211F613F0
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3211F613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAA8083658;
	Wed,  9 Jun 2021 23:27:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iNsPWwTE3inB; Wed,  9 Jun 2021 23:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A050182E42;
	Wed,  9 Jun 2021 23:27:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57F29C000E;
	Wed,  9 Jun 2021 23:27:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53905C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48A39832C6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6b_FyZzF9rO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F93A82E42
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:25 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id v12so13544034plo.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rPwFm+rW5VJo250kQOZcru/sRI6+UZ6fSWYAEKjNOl8=;
 b=koQ9XOS9Ahh++/EJkQYsM/lmckBNtNk3H15jg9UrEF+0vJyfvFlAa/gQhNntz9gu1w
 Oqs61SCcdSCMc9H5FE4ZdoooczAaIPcxe7jAJxGaFaFKASEslnvZ6mQDqd5rYc8npZmh
 0isbpH8z/+CjhFiJHWfargQyKl+5Ht4rUjK5jpkUo31LpnfC9GTUkrgEmEXjVgd4V0DC
 V6WlFXcSgBGg7EKnZDJcgXtuOk5CErlGosgLzxm0O0L+Gak1ws8U/hS7hyAv4/PA0bPh
 8K9yGOI3EaKetOMc1Ru2ifH5BxK58xfPsr/H8Q9ofhN51F4bQ43i8Vv6FFy7qXVo5p/z
 Sg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rPwFm+rW5VJo250kQOZcru/sRI6+UZ6fSWYAEKjNOl8=;
 b=W/zEBDv6gmpJKwtL62xV+RanxzsVnJRmNvEnaxl7L2ke5Z4roK45l8ddfa41Az9XLm
 pz5sCV3QaI3vo8I0Q96YpNcXsqQzqcMzrS0n0xVxm7gvSK0/v+LiWO9mNdopiUcnwOHv
 D7Rr7o52qh9s6BzA59+VtcUA9zR1xxJltmwzlwoJPc/H3dWsVNLQ262KYT9cvC2Lvb3O
 kB38Lmv1q2Wxh3yoEfyBBINxSGJVgOuXH1UzMp3AyB9yAPkLav+yP2F3HHyK0RGoDQKF
 N5e2rIhThhtrEOOK6S+ZpJuZknw7eu7WgP2BWuDw1aENULeZQ5uLGHnd+6PWorpvERNn
 /7jA==
X-Gm-Message-State: AOAM532cXtCJWDCpXe5rtE0zg7uQj5vYr8qRw6i15hSjecSHpjYIsEGw
 k00E9Gz+57fr0cinjTIUL+cH+w==
X-Google-Smtp-Source: ABdhPJx7y5w6Y2cekg09LzZc1GmAicnE6+tSkLAtxpBWIyREqveDAqIwuJX1FGXwpqEcOmgaufVpkg==
X-Received: by 2002:a17:90a:dc04:: with SMTP id i4mr135874pjv.75.1623281244893; 
 Wed, 09 Jun 2021 16:27:24 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id k1sm526783pfa.30.2021.06.09.16.27.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jun 2021 16:27:24 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: sgarzare@redhat.com
Subject: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
Date: Wed,  9 Jun 2021 23:24:52 +0000
Message-Id: <20210609232501.171257-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 duanxiongchun@bytedance.com, xieyongji@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>, Steven Rostedt <rostedt@goodmis.org>,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>, arseny.krasnov@kaspersky.com,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

VGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHN1cHBvcnQgb2YgU09DS19ER1JBTSBmb3IgdmlydGlv
CnRyYW5zcG9ydC4KCkRhdGFncmFtIHNvY2tldHMgYXJlIGNvbm5lY3Rpb25sZXNzIGFuZCB1bnJl
bGlhYmxlLiBUbyBhdm9pZCB1bmZhaXIgY29udGVudGlvbgp3aXRoIHN0cmVhbSBhbmQgb3RoZXIg
c29ja2V0cywgYWRkIHR3byBtb3JlIHZpcnRxdWV1ZXMgYW5kCmEgbmV3IGZlYXR1cmUgYml0IHRv
IGluZGljYXRlIGlmIHRob3NlIHR3byBuZXcgcXVldWVzIGV4aXN0IG9yIG5vdC4KCkRncmFtIGRv
ZXMgbm90IHVzZSB0aGUgZXhpc3RpbmcgY3JlZGl0IHVwZGF0ZSBtZWNoYW5pc20gZm9yCnN0cmVh
bSBzb2NrZXRzLiBXaGVuIHNlbmRpbmcgZnJvbSB0aGUgZ3Vlc3QvZHJpdmVyLCBzZW5kaW5nIHBh
Y2tldHMgCnN5bmNocm9ub3VzbHksIHNvIHRoZSBzZW5kZXIgd2lsbCBnZXQgYW4gZXJyb3Igd2hl
biB0aGUgdmlydHF1ZXVlIGlzIGZ1bGwuCldoZW4gc2VuZGluZyBmcm9tIHRoZSBob3N0L2Rldmlj
ZSwgc2VuZCBwYWNrZXRzIGFzeW5jaHJvbm91c2x5CmJlY2F1c2UgdGhlIGRlc2NyaXB0b3IgbWVt
b3J5IGJlbG9uZ3MgdG8gdGhlIGNvcnJlc3BvbmRpbmcgUUVNVQpwcm9jZXNzLgoKVGhlIHZpcnRp
byBzcGVjIHBhdGNoIGlzIGhlcmU6IApodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51
eC12aXJ0dWFsaXphdGlvbi9tc2c1MDAyNy5odG1sCgpGb3IgdGhvc2Ugd2hvIHByZWZlciBnaXQg
cmVwbywgaGVyZSBpcyB0aGUgbGluayBmb3IgdGhlIGxpbnV4IGtlcm5lbO+8mgpodHRwczovL2dp
dGh1Yi5jb20vSmlhbmcxMTU1L2xpbnV4L3RyZWUvdnNvY2stZGdyYW0tdjEKCnFlbXUgcGF0Y2gg
bGluazoKaHR0cHM6Ly9naXRodWIuY29tL0ppYW5nMTE1NS9xZW11L3RyZWUvdnNvY2stZGdyYW0t
djEKCgpUbyBkbzoKMS4gdXNlIHNrYiB3aGVuIHJlY2VpdmluZyBwYWNrZXRzCjIuIHN1cHBvcnQg
bXVsdGlwbGUgdHJhbnNwb3J0CjMuIHN1cHBvcnQgbWVyZ2VhYmxlIHJ4IGJ1ZmZlcgoKCkppYW5n
IFdhbmcgKDYpOgogIHZpcnRpby92c29jazogYWRkIFZJUlRJT19WU09DS19GX0RHUkFNIGZlYXR1
cmUgYml0CiAgdmlydGlvL3Zzb2NrOiBhZGQgc3VwcG9ydCBmb3IgdmlydGlvIGRhdGFncmFtCiAg
dmhvc3QvdnNvY2s6IGFkZCBzdXBwb3J0IGZvciB2aG9zdCBkZ3JhbS4KICB2c29ja190ZXN0OiBh
ZGQgdGVzdHMgZm9yIHZzb2NrIGRncmFtCiAgdmhvc3QvdnNvY2s6IGFkZCBrY29uZmlnIGZvciB2
aG9zdCBkZ3JhbSBzdXBwb3J0CiAgdmlydGlvL3Zzb2NrOiBhZGQgc3lzZnMgZm9yIHJ4IGJ1ZiBs
ZW4gZm9yIGRncmFtCgogZHJpdmVycy92aG9zdC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDggKwogZHJpdmVycy92aG9zdC92c29jay5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyMDcgKysrKysrKystLQogaW5jbHVkZS9saW51eC92aXJ0aW9fdnNvY2su
aCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKwogaW5jbHVkZS9uZXQvYWZfdnNvY2suaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogLi4uL3RyYWNlL2V2ZW50cy92c29j
a192aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5oICAgfCAgIDUgKy0KIGluY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fdnNvY2suaCAgICAgICAgICAgICAgICAgIHwgICA0ICsKIG5ldC92bXdfdnNvY2sv
YWZfdnNvY2suYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEyICsKIG5ldC92bXdfdnNv
Y2svdmlydGlvX3RyYW5zcG9ydC5jICAgICAgICAgICAgICAgICAgIHwgNDMzICsrKysrKysrKysr
KysrKysrKy0tLQogbmV0L3Ztd192c29jay92aXJ0aW9fdHJhbnNwb3J0X2NvbW1vbi5jICAgICAg
ICAgICAgfCAxODQgKysrKysrKystCiB0b29scy90ZXN0aW5nL3Zzb2NrL3V0aWwuYyAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDEwNSArKysrKwogdG9vbHMvdGVzdGluZy92c29jay91dGlsLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKwogdG9vbHMvdGVzdGluZy92c29jay92c29j
a190ZXN0LmMgICAgICAgICAgICAgICAgICAgfCAxOTUgKysrKysrKysrKwogMTIgZmlsZXMgY2hh
bmdlZCwgMTA3MCBpbnNlcnRpb25zKCspLCA5NyBkZWxldGlvbnMoLSkKCi0tIAoyLjExLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
