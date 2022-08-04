Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F205C25B08
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 10:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A79F960E56;
	Thu,  4 Aug 2022 10:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A79F960E56
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gUBJdtNS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jEwSDt55OoIV; Thu,  4 Aug 2022 10:59:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19CEE60E26;
	Thu,  4 Aug 2022 10:59:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19CEE60E26
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9318C007D;
	Thu,  4 Aug 2022 10:59:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2008C007D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A72B14091A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A72B14091A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=gUBJdtNS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EXqQvKq43iN7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9407740278
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9407740278
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 049E26601B55;
 Thu,  4 Aug 2022 11:59:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659610772;
 bh=Akv0OxsX5sK3P0lVvrgbvRzqAJS0DhcYgT0/P1iUyYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gUBJdtNSGYyxYWFI53vZ8n/q7W1gGz9OG/nATvEQTV8jHwYatNGyqV7L4y9tsvKyc
 ZZu98CGjh97NEJFEvD8EAXmY5FnSDibxZwYEbH7xk4D97oFcGbfeyonQQ/1/xRMkPA
 zHVedjgZrXfZLpZYO3UBy6dxtbMou1ERQi1kG6+YFQ0S6R8SiZHMrMitiq/y8UhXKM
 IGDryao/Z3NTPSA6m7grWZz7iBjEs+5hylgR5Z/uRoASPiJeglJ3P/PC2Db8/YXND5
 4s4aCVLGsWZn6vuEkOkPfq/WJsKZ4p+PZpKmrRFt43PL2kjJI6+zYhY/0e1MeArBse
 TVCDsUW2tZd8Q==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] virtio: kerneldocs fixes and enhancements
Date: Thu,  4 Aug 2022 12:59:13 +0200
Message-Id: <20220804105914.3707389-2-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
References: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Cc: mst@redhat.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, bagasdotme@gmail.com,
 kernel@collabora.com
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

Rml4IHZhcmlhYmxlIG5hbWVzIGluIHNvbWUgaHRtbGRvY3MsIG5hbWluZyBpbiBvdGhlcnMuCkFk
ZCBodG1sZG9jcyBmb3Igc3RydWN0IHZyaW5nX2Rlc2MgYW5kIHZyaW5nX2ludGVycnVwdC4KClNp
Z25lZC1vZmYtYnk6IFJpY2FyZG8gQ2HDsXVlbG8gPHJpY2FyZG8uY2FudWVsb0Bjb2xsYWJvcmEu
Y29tPgotLS0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgICAgIHwgIDggKysrKysrKysK
IGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgICAgIHwgIDYgKysrLS0tCiBpbmNsdWRlL2xp
bnV4L3ZpcnRpb19jb25maWcuaCAgICB8ICA2ICsrKy0tLQogaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19yaW5nLmggfCAxNiArKysrKysrKysrKy0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDI1IGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCmluZGV4IGE1ZWM3
MjRjMDFkOC4uZTIwOTEzNDVjNWMyIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCisrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKQEAgLTIxNDcsNiArMjE0
NywxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbW9yZV91c2VkKGNvbnN0IHN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxKQogCXJldHVybiB2cS0+cGFja2VkX3JpbmcgPyBtb3JlX3VzZWRfcGFja2Vk
KHZxKSA6IG1vcmVfdXNlZF9zcGxpdCh2cSk7CiB9CiAKKy8qKgorICogdnJpbmdfaW50ZXJydXB0
IC0gbm90aWZ5IGEgdmlydHF1ZXVlIG9uIGFuIGludGVycnVwdAorICogQGlycTogdGhlIElSUSBu
dW1iZXIKKyAqIEBfdnE6IHRoZSBzdHJ1Y3QgdmlydHF1ZXVlIHRvIG5vdGlmeQorICoKKyAqIENh
bGxzIHRoZSBjYWxsYmFjayBmdW5jdGlvbiBvZiBAX3ZxIHRvIHByb2Nlc3MgdGhlIHZpcnRxdWV1
ZQorICogbm90aWZpY2F0aW9uLgorICovCiBpcnFyZXR1cm5fdCB2cmluZ19pbnRlcnJ1cHQoaW50
IGlycSwgdm9pZCAqX3ZxKQogewogCXN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZx
KF92cSk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51
eC92aXJ0aW8uaAppbmRleCBkOGZkZjE3MDYzN2MuLmZkODQ0MGU4NTkzMyAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9saW51eC92aXJ0aW8uaAorKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCkBAIC0x
MSw3ICsxMSw3IEBACiAjaW5jbHVkZSA8bGludXgvZ2ZwLmg+CiAKIC8qKgotICogdmlydHF1ZXVl
IC0gYSBxdWV1ZSB0byByZWdpc3RlciBidWZmZXJzIGZvciBzZW5kaW5nIG9yIHJlY2VpdmluZy4K
KyAqIHN0cnVjdCB2aXJ0cXVldWUgLSBhIHF1ZXVlIHRvIHJlZ2lzdGVyIGJ1ZmZlcnMgZm9yIHNl
bmRpbmcgb3IgcmVjZWl2aW5nLgogICogQGxpc3Q6IHRoZSBjaGFpbiBvZiB2aXJ0cXVldWVzIGZv
ciB0aGlzIGRldmljZQogICogQGNhbGxiYWNrOiB0aGUgZnVuY3Rpb24gdG8gY2FsbCB3aGVuIGJ1
ZmZlcnMgYXJlIGNvbnN1bWVkIChjYW4gYmUgTlVMTCkuCiAgKiBAbmFtZTogdGhlIG5hbWUgb2Yg
dGhpcyB2aXJ0cXVldWUgKG1haW5seSBmb3IgZGVidWdnaW5nKQpAQCAtOTAsNyArOTAsNyBAQCBk
bWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7
CiBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKnZx
KTsKIAogLyoqCi0gKiB2aXJ0aW9fZGV2aWNlIC0gcmVwcmVzZW50YXRpb24gb2YgYSBkZXZpY2Ug
dXNpbmcgdmlydGlvCisgKiBzdHJ1Y3QgdmlydGlvX2RldmljZSAtIHJlcHJlc2VudGF0aW9uIG9m
IGEgZGV2aWNlIHVzaW5nIHZpcnRpbwogICogQGluZGV4OiB1bmlxdWUgcG9zaXRpb24gb24gdGhl
IHZpcnRpbyBidXMKICAqIEBmYWlsZWQ6IHNhdmVkIHZhbHVlIGZvciBWSVJUSU9fQ09ORklHX1Nf
RkFJTEVEIGJpdCAoZm9yIHJlc3RvcmUpCiAgKiBAY29uZmlnX2VuYWJsZWQ6IGNvbmZpZ3VyYXRp
b24gY2hhbmdlIHJlcG9ydGluZyBlbmFibGVkCkBAIC0xNDYsNyArMTQ2LDcgQEAgc2l6ZV90IHZp
cnRpb19tYXhfZG1hX3NpemUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpOwogCWxpc3RfZm9y
X2VhY2hfZW50cnkodnEsICZ2ZGV2LT52cXMsIGxpc3QpCiAKIC8qKgotICogdmlydGlvX2RyaXZl
ciAtIG9wZXJhdGlvbnMgZm9yIGEgdmlydGlvIEkvTyBkcml2ZXIKKyAqIHN0cnVjdCB2aXJ0aW9f
ZHJpdmVyIC0gb3BlcmF0aW9ucyBmb3IgYSB2aXJ0aW8gSS9PIGRyaXZlcgogICogQGRyaXZlcjog
dW5kZXJseWluZyBkZXZpY2UgZHJpdmVyIChwb3B1bGF0ZSBuYW1lIGFuZCBvd25lcikuCiAgKiBA
aWRfdGFibGU6IHRoZSBpZHMgc2VydmljZWQgYnkgdGhpcyBkcml2ZXIuCiAgKiBAZmVhdHVyZV90
YWJsZTogYW4gYXJyYXkgb2YgZmVhdHVyZSBudW1iZXJzIHN1cHBvcnRlZCBieSB0aGlzIGRyaXZl
ci4KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW9fY29uZmlnLmgKaW5kZXggYjQ3YzJlN2VkMGVlLi45OTc4MDEwMThhZTQgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvdmlydGlvX2NvbmZpZy5oCkBAIC0yMjUsNyArMjI1LDcgQEAgaW50IHZpcnRpb19maW5kX3Zx
c19jdHgoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIG52cXMsCiAKIC8qKgog
ICogdmlydGlvX3N5bmNocm9uaXplX2NicyAtIHN5bmNocm9uaXplIHdpdGggdmlydHF1ZXVlIGNh
bGxiYWNrcwotICogQHZkZXY6IHRoZSBkZXZpY2UKKyAqIEBkZXY6IHRoZSBkZXZpY2UKICAqLwog
c3RhdGljIGlubGluZQogdm9pZCB2aXJ0aW9fc3luY2hyb25pemVfY2JzKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICpkZXYpCkBAIC0yNDQsNyArMjQ0LDcgQEAgdm9pZCB2aXJ0aW9fc3luY2hyb25pemVf
Y2JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpCiAKIC8qKgogICogdmlydGlvX2RldmljZV9y
ZWFkeSAtIGVuYWJsZSB2cSB1c2UgaW4gcHJvYmUgZnVuY3Rpb24KLSAqIEB2ZGV2OiB0aGUgZGV2
aWNlCisgKiBAZGV2OiB0aGUgZGV2aWNlCiAgKgogICogRHJpdmVyIG11c3QgY2FsbCB0aGlzIHRv
IHVzZSB2cXMgaW4gdGhlIHByb2JlIGZ1bmN0aW9uLgogICoKQEAgLTI5Miw3ICsyOTIsNyBAQCBj
b25zdCBjaGFyICp2aXJ0aW9fYnVzX25hbWUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCiAv
KioKICAqIHZpcnRxdWV1ZV9zZXRfYWZmaW5pdHkgLSBzZXR0aW5nIGFmZmluaXR5IGZvciBhIHZp
cnRxdWV1ZQogICogQHZxOiB0aGUgdmlydHF1ZXVlCi0gKiBAY3B1OiB0aGUgY3B1IG5vLgorICog
QGNwdV9tYXNrOiB0aGUgY3B1IG1hc2sKICAqCiAgKiBQYXkgYXR0ZW50aW9uIHRoZSBmdW5jdGlv
biBhcmUgYmVzdC1lZmZvcnQ6IHRoZSBhZmZpbml0eSBoaW50IG1heSBub3QgYmUgc2V0CiAgKiBk
dWUgdG8gY29uZmlnIHN1cHBvcnQsIGlycSB0eXBlIGFuZCBzaGFyaW5nLgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmly
dGlvX3JpbmcuaAppbmRleCA0NzZkM2U1YzBmZTcuLmY4YzIwZDNkZThkYSAxMDA2NDQKLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4
L3ZpcnRpb19yaW5nLmgKQEAgLTkzLDE1ICs5MywyMSBAQAogI2RlZmluZSBWUklOR19VU0VEX0FM
SUdOX1NJWkUgNAogI2RlZmluZSBWUklOR19ERVNDX0FMSUdOX1NJWkUgMTYKIAotLyogVmlydGlv
IHJpbmcgZGVzY3JpcHRvcnM6IDE2IGJ5dGVzLiAgVGhlc2UgY2FuIGNoYWluIHRvZ2V0aGVyIHZp
YSAibmV4dCIuICovCisvKioKKyAqIHN0cnVjdCB2cmluZ19kZXNjIC0gVmlydGlvIHJpbmcgZGVz
Y3JpcHRvcnMsCisgKiAxNiBieXRlcyBsb25nLiBUaGVzZSBjYW4gY2hhaW4gdG9nZXRoZXIgdmlh
IEBuZXh0LgorICoKKyAqIEBhZGRyOiBidWZmZXIgYWRkcmVzcyAoZ3Vlc3QtcGh5c2ljYWwpCisg
KiBAbGVuOiBidWZmZXIgbGVuZ3RoCisgKiBAZmxhZ3M6IGRlc2NyaXB0b3IgZmxhZ3MKKyAqIEBu
ZXh0OiBpbmRleCBvZiB0aGUgbmV4dCBkZXNjcmlwdG9yIGluIHRoZSBjaGFpbiwKKyAqICAgICAg
ICBpZiB0aGUgVlJJTkdfREVTQ19GX05FWFQgZmxhZyBpcyBzZXQuIFdlIGNoYWluIHVudXNlZAor
ICogICAgICAgIGRlc2NyaXB0b3JzIHZpYSB0aGlzLCB0b28uCisgKi8KIHN0cnVjdCB2cmluZ19k
ZXNjIHsKLQkvKiBBZGRyZXNzIChndWVzdC1waHlzaWNhbCkuICovCiAJX192aXJ0aW82NCBhZGRy
OwotCS8qIExlbmd0aC4gKi8KIAlfX3ZpcnRpbzMyIGxlbjsKLQkvKiBUaGUgZmxhZ3MgYXMgaW5k
aWNhdGVkIGFib3ZlLiAqLwogCV9fdmlydGlvMTYgZmxhZ3M7Ci0JLyogV2UgY2hhaW4gdW51c2Vk
IGRlc2NyaXB0b3JzIHZpYSB0aGlzLCB0b28gKi8KIAlfX3ZpcnRpbzE2IG5leHQ7CiB9OwogCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
