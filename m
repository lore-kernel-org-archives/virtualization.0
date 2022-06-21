Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83645C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 15:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20D5D418C9;
	Tue, 21 Jun 2022 15:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20D5D418C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IQT37I2b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrsmIDIlm_3t; Tue, 21 Jun 2022 15:13:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 571E8415C5;
	Tue, 21 Jun 2022 15:13:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 571E8415C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15F9FC0032;
	Tue, 21 Jun 2022 15:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E80AEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF08F60D62
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF08F60D62
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IQT37I2b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hHiqU6_Qvo9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:13:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 148806077D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 148806077D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655824410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g+NJjQlOAcWg6eecPG318LXJkkwF2T/JikgaYlmjCB0=;
 b=IQT37I2bJSo8hrklUdb07/12SgZyefoIjiWdLe87mguI+FOkLN6O4Q87rLVVxbQOK/NGmw
 k30xRtsE775KhOfmXmv/UNYUc/uMxv8ZxYXADbOg93Md0lyM/2NUgo4rGWyedGJhT4lMpm
 zpMRS6HVZfpKNUZdjoMP0tl9ABeaizU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-uv19rirLOZGjbdK-xqvTMg-1; Tue, 21 Jun 2022 11:13:29 -0400
X-MC-Unique: uv19rirLOZGjbdK-xqvTMg-1
Received: by mail-qk1-f199.google.com with SMTP id
 u8-20020a05620a454800b006a74e6b39eeso16714174qkp.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 08:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g+NJjQlOAcWg6eecPG318LXJkkwF2T/JikgaYlmjCB0=;
 b=TKcCDkvW5aSSMI6mbUOPHu6m+prPucIm7XuIJGF1auFVJTMSkctjo7i8uHdjKvgSXG
 AxAUq1oSmRV1R2QM79x8ecKopc/VXNCrDyt8XmWvFD9UI1poc8dmh455QF8DJhVe7Z5j
 6wtHA3vNGRdt2X79CctfeRNjknVXQUASV4diHs3j93lBJ6l713DivgSRMI0x+3THZAck
 aFt0EZJgJW7+Uc59OGUe5v2pC+PPvZlLEzLfBCqUUr1mV5gfaVTq+13gDY8vIjYMnqlk
 vPPxX/aWgdExUtB3zisjOEmZzmpYUquGdRpDQbS9RcjBSMJsGR6dIobLU5bRIyA/4TAa
 2eBw==
X-Gm-Message-State: AJIora+HXKrome1X6CxatiAF8AxEqFPRtzUDCC2hDB8mnvoldQ0aeDyK
 AfCx+NNy4LOJWmQ2yEBRScyZE7e6kZIwS88iryerXKoX7dT98qXTnMPHKB5CJLEwpcbI3VzVkFS
 0IsMQGDI5d5mdNl3RemXog2CzJ5vrkZDkFroGpjz+bMBtZznUcwfi/PqsQPf5fxI8PwjFBNP9bY
 9rASJpRil4Is8aqCh/EA==
X-Received: by 2002:ac8:5b50:0:b0:305:3275:b9bf with SMTP id
 n16-20020ac85b50000000b003053275b9bfmr24129996qtw.498.1655824408635; 
 Tue, 21 Jun 2022 08:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRyiOcUjGsF9W5x9EpD8vRzkOvogV2aC9PWkgpGX0OePdiWEiVSVq+pFjtElx+Cae1c1QL1Q==
X-Received: by 2002:ac8:5b50:0:b0:305:3275:b9bf with SMTP id
 n16-20020ac85b50000000b003053275b9bfmr24129957qtw.498.1655824408277; 
 Tue, 21 Jun 2022 08:13:28 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 z13-20020a05622a060d00b00304eb8e880dsm14266895qta.23.2022.06.21.08.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 08:13:27 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim_blk: set number of address spaces and virtqueue
 groups
Date: Tue, 21 Jun 2022 17:13:23 +0200
Message-Id: <20220621151323.190431-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Gautam Dawar <gautam.dawar@xilinx.com>, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Q29tbWl0IGJkYTMyNGZkMDM3YSAoInZkcGFzaW06IGNvbnRyb2wgdmlydHF1ZXVlIHN1cHBvcnQi
KSBhZGRlZCB0d28KbmV3IGZpZWxkcyAobmFzLCBuZ3JvdXBzKSB0byB2ZHBhc2ltX2Rldl9hdHRy
LCBidXQgd2UgZm9yZ290IHRvCmluaXRpYWxpemUgdGhlbSBmb3IgdmRwYV9zaW1fYmxrLgoKV2hl
biBjcmVhdGluZyBhIG5ldyB2ZHBhX3NpbV9ibGsgZGV2aWNlIHRoaXMgY2F1c2VzIHRoZSBrZXJu
ZWwKdG8gcGFuaWMgaW4gdGhpcyB3YXk6CiDCoCDCoCQgdmRwYSBkZXYgYWRkIG1nbXRkZXYgdmRw
YXNpbV9ibGsgbmFtZSBibGswCiDCoCDCoEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAzMAogwqAgwqAuLi4KIMKgIMKgUklQOiAwMDEw
OnZob3N0X2lvdGxiX2FkZF9yYW5nZV9jdHgrMHg0MS8weDIyMCBbdmhvc3RfaW90bGJdCiDCoCDC
oC4uLgogwqAgwqBDYWxsIFRyYWNlOgogwqAgwqAgPFRBU0s+CiDCoCDCoCB2aG9zdF9pb3RsYl9h
ZGRfcmFuZ2UrMHgxMS8weDgwMCBbdmhvc3RfaW90bGJdCiDCoCDCoCB2ZHBhc2ltX21hcF9yYW5n
ZSsweDkxLzB4ZDAgW3ZkcGFfc2ltXQogwqAgwqAgdmRwYXNpbV9hbGxvY19jb2hlcmVudCsweDU2
LzB4OTAgW3ZkcGFfc2ltXQogwqAgwqAgLi4uCgpUaGlzIGhhcHBlbnMgYmVjYXVzZSB2ZHBhc2lt
LT5pb21tdVswXSBpcyBub3QgaW5pdGlhbGl6ZWQgd2hlbgpkZXZfYXR0ci5uYXMgaXMgMC4KCkxl
dCdzIGZpeCB0aGlzIGlzc3VlIGJ5IGluaXRpYWxpemluZyBib3RoIChuYXMsIG5ncm91cHMpIHRv
IDEgZm9yCnZkcGFfc2ltX2Jsay4KCkZpeGVzOiBiZGEzMjRmZDAzN2EgKCJ2ZHBhc2ltOiBjb250
cm9sIHZpcnRxdWV1ZSBzdXBwb3J0IikKQ2M6IGdhdXRhbS5kYXdhckB4aWxpbnguY29tClNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KLS0tCiBk
cml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCA2ICsrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbV9ibGsuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYwpp
bmRleCA0MmQ0MDFkNDM5MTEuLjAzYTI4ZGVmOGVlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCisrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbV9ibGsuYwpAQCAtMzQsNyArMzQsMTEgQEAKICNkZWZpbmUgVkRQQVNJTV9CTEtfQ0FQQUNJ
VFkJMHg0MDAwMAogI2RlZmluZSBWRFBBU0lNX0JMS19TSVpFX01BWAkweDEwMDAKICNkZWZpbmUg
VkRQQVNJTV9CTEtfU0VHX01BWAkzMgorCisvKiAxIHZpcnRxdWV1ZSwgMSBhZGRyZXNzIHNwYWNl
LCAxIHZpcnRxdWV1ZSBncm91cCAqLwogI2RlZmluZSBWRFBBU0lNX0JMS19WUV9OVU0JMQorI2Rl
ZmluZSBWRFBBU0lNX0JMS19BU19OVU0JMQorI2RlZmluZSBWRFBBU0lNX0JMS19HUk9VUF9OVU0J
MQogCiBzdGF0aWMgY2hhciB2ZHBhc2ltX2Jsa19pZFtWSVJUSU9fQkxLX0lEX0JZVEVTXSA9ICJ2
ZHBhX2Jsa19zaW0iOwogCkBAIC0yNjAsNiArMjY0LDggQEAgc3RhdGljIGludCB2ZHBhc2ltX2Js
a19kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2LCBjb25zdCBjaGFyICpuYW1lLAog
CWRldl9hdHRyLmlkID0gVklSVElPX0lEX0JMT0NLOwogCWRldl9hdHRyLnN1cHBvcnRlZF9mZWF0
dXJlcyA9IFZEUEFTSU1fQkxLX0ZFQVRVUkVTOwogCWRldl9hdHRyLm52cXMgPSBWRFBBU0lNX0JM
S19WUV9OVU07CisJZGV2X2F0dHIubmdyb3VwcyA9IFZEUEFTSU1fQkxLX0dST1VQX05VTTsKKwlk
ZXZfYXR0ci5uYXMgPSBWRFBBU0lNX0JMS19BU19OVU07CiAJZGV2X2F0dHIuY29uZmlnX3NpemUg
PSBzaXplb2Yoc3RydWN0IHZpcnRpb19ibGtfY29uZmlnKTsKIAlkZXZfYXR0ci5nZXRfY29uZmln
ID0gdmRwYXNpbV9ibGtfZ2V0X2NvbmZpZzsKIAlkZXZfYXR0ci53b3JrX2ZuID0gdmRwYXNpbV9i
bGtfd29yazsKLS0gCjIuMzYuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
