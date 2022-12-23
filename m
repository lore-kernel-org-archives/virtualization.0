Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F086CC3DA6E
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 05:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 906B860AD2;
	Fri, 23 Dec 2022 05:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 906B860AD2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UgQUzHSC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80O-1pz4zWuK; Fri, 23 Dec 2022 05:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2500760BED;
	Fri, 23 Dec 2022 05:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2500760BED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6130BC007E;
	Fri, 23 Dec 2022 05:56:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E8EFC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B652416AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B652416AB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UgQUzHSC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2E9p5NWlETZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B283416A3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B283416A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671774967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wv+IEcA7/J3RltAXesX4+KgFk8vshmbgrHzr3MZHu0Q=;
 b=UgQUzHSCTuTznPR2kQmCswj/un6KR6qM5hxnUhUuw8oia4Xs2lnfJJqKPfw3c4IJU4N8/5
 Pv5T0tKxfuWgojC0hKOCkrAhEldL6PXi5+AcuIQTW3lvb0j+qbJEF/lSyYGZExT5TK76Ik
 zKK/xbLCE5DdpIvYTZkyQLc5CCeLdWo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-sh02hvWLPMyizWEvAw7SDw-1; Fri, 23 Dec 2022 00:56:03 -0500
X-MC-Unique: sh02hvWLPMyizWEvAw7SDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AB7E1C05EAC;
 Fri, 23 Dec 2022 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com
 [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADA8A40C2004;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 3/4] vdpa_sim: support vendor statistics
Date: Fri, 23 Dec 2022 13:55:47 +0800
Message-Id: <20221223055548.27810-4-jasowang@redhat.com>
In-Reply-To: <20221223055548.27810-1-jasowang@redhat.com>
References: <20221223055548.27810-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

VGhpcyBwYXRjaCBhZGRzIGEgbmV3IGNvbmZpZyBvcHMgY2FsbGJhY2sgdG8gYWxsb3cgaW5kaXZp
ZHVhbApzaW11bGF0b3IgdG8gaW1wbGVtZW50IHRoZSB2ZW5kb3Igc3RhdHMgY2FsbGJhY2suCgpB
Y2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltLmMgfCAxNCArKysrKysrKysrKysrKwogZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmggfCAgMyArKysKIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKaW5kZXggMzQxZGExMDdlN2RhLi40NWQzZjg0Yjc5
MzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCisrKyBiL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCkBAIC00MjQsNiArNDI0LDE4IEBAIHN0YXRp
YyBpbnQgdmRwYXNpbV9nZXRfdnFfc3RhdGUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYg
aWR4LAogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IHZkcGFzaW1fZ2V0X3ZxX3N0YXRzKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTE2IGlkeCwKKwkJCQlzdHJ1Y3Qgc2tfYnVmZiAqbXNn
LAorCQkJCXN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykKK3sKKwlzdHJ1Y3QgdmRwYXNp
bSAqdmRwYXNpbSA9IHZkcGFfdG9fc2ltKHZkcGEpOworCisJaWYgKHZkcGFzaW0tPmRldl9hdHRy
LmdldF9zdGF0cykKKwkJcmV0dXJuIHZkcGFzaW0tPmRldl9hdHRyLmdldF9zdGF0cyh2ZHBhc2lt
LCBpZHgsCisJCQkJCQkgICBtc2csIGV4dGFjayk7CisJcmV0dXJuIC1FT1BOT1RTVVBQOworfQor
CiBzdGF0aWMgdTMyIHZkcGFzaW1fZ2V0X3ZxX2FsaWduKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRw
YSkKIHsKIAlyZXR1cm4gVkRQQVNJTV9RVUVVRV9BTElHTjsKQEAgLTcxMCw2ICs3MjIsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2NvbmZpZ19vcHMgPSB7
CiAJLnNldF92cV9yZWFkeSAgICAgICAgICAgPSB2ZHBhc2ltX3NldF92cV9yZWFkeSwKIAkuZ2V0
X3ZxX3JlYWR5ICAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3ZxX3JlYWR5LAogCS5zZXRfdnFfc3Rh
dGUgICAgICAgICAgID0gdmRwYXNpbV9zZXRfdnFfc3RhdGUsCisJLmdldF92ZW5kb3JfdnFfc3Rh
dHMgICAgPSB2ZHBhc2ltX2dldF92cV9zdGF0cywKIAkuZ2V0X3ZxX3N0YXRlICAgICAgICAgICA9
IHZkcGFzaW1fZ2V0X3ZxX3N0YXRlLAogCS5nZXRfdnFfYWxpZ24gICAgICAgICAgID0gdmRwYXNp
bV9nZXRfdnFfYWxpZ24sCiAJLmdldF92cV9ncm91cCAgICAgICAgICAgPSB2ZHBhc2ltX2dldF92
cV9ncm91cCwKQEAgLTc0Myw2ICs3NTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29u
ZmlnX29wcyB2ZHBhc2ltX2JhdGNoX2NvbmZpZ19vcHMgPSB7CiAJLnNldF92cV9yZWFkeSAgICAg
ICAgICAgPSB2ZHBhc2ltX3NldF92cV9yZWFkeSwKIAkuZ2V0X3ZxX3JlYWR5ICAgICAgICAgICA9
IHZkcGFzaW1fZ2V0X3ZxX3JlYWR5LAogCS5zZXRfdnFfc3RhdGUgICAgICAgICAgID0gdmRwYXNp
bV9zZXRfdnFfc3RhdGUsCisJLmdldF92ZW5kb3JfdnFfc3RhdHMgICAgPSB2ZHBhc2ltX2dldF92
cV9zdGF0cywKIAkuZ2V0X3ZxX3N0YXRlICAgICAgICAgICA9IHZkcGFzaW1fZ2V0X3ZxX3N0YXRl
LAogCS5nZXRfdnFfYWxpZ24gICAgICAgICAgID0gdmRwYXNpbV9nZXRfdnFfYWxpZ24sCiAJLmdl
dF92cV9ncm91cCAgICAgICAgICAgPSB2ZHBhc2ltX2dldF92cV9ncm91cCwKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmgKaW5kZXggNTFjMDcwYTU0M2YxLi5kMmEwOGMwYWJhZDcgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCisrKyBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbS5oCkBAIC00OCw2ICs0OCw5IEBAIHN0cnVjdCB2ZHBhc2ltX2Rldl9hdHRy
IHsKIAl3b3JrX2Z1bmNfdCB3b3JrX2ZuOwogCXZvaWQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRw
YXNpbSAqdmRwYXNpbSwgdm9pZCAqY29uZmlnKTsKIAl2b2lkICgqc2V0X2NvbmZpZykoc3RydWN0
IHZkcGFzaW0gKnZkcGFzaW0sIGNvbnN0IHZvaWQgKmNvbmZpZyk7CisJaW50ICgqZ2V0X3N0YXRz
KShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdTE2IGlkeCwKKwkJCSBzdHJ1Y3Qgc2tfYnVmZiAq
bXNnLAorCQkJIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjayk7CiB9OwogCiAvKiBTdGF0
ZSBvZiBlYWNoIHZkcGFzaW0gZGV2aWNlICovCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
