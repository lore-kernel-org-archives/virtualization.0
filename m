Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93436C77B72
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 12:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16151405FC;
	Fri, 14 Apr 2023 12:39:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16151405FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=sX9xudie
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzBxUqXcsYSJ; Fri, 14 Apr 2023 12:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F4AE40439;
	Fri, 14 Apr 2023 12:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F4AE40439
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66938C0036;
	Fri, 14 Apr 2023 12:39:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D5FBC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 082996FF0D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 082996FF0D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=sX9xudie
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYNbVKDaAOkk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A24276FF0C
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A24276FF0C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 12:39:13 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id v9so23527319pjk.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1681475952; x=1684067952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6HYNyUUEorOF+isbH7MLUIuEp6e49eMyp3D2Mh/QBec=;
 b=sX9xudieMQAT6uk2HyEujcuXLPGCVhLkbBS1MEggluyv2/BWsKTprUIhVNVt6ta/eD
 d98sadGF1z6Q/jfpnFqkVPTHYZbJI2PTpdLqsBjTS7+cCgAdc/8BOQHqNNqHPuJr6K89
 87mCXFZ5OFk1G0Jl7vPpBXS5iv9eOBQMlapv1bOtbl1ZPPBN/KZ/TRyvmmbjUZWP/MRM
 ytMhjPizvYkw5flS0uc35OUOggApRHBcgNjjhj1zHv+91dP05JQx/leVr7yL4zJaZQlt
 fUjct8dYbxDSu67+/cDb8jqZBQTwXnEGzsPNa4WogomhoENfUXiaDEPgIRaNfJ3nTQww
 BkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681475952; x=1684067952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6HYNyUUEorOF+isbH7MLUIuEp6e49eMyp3D2Mh/QBec=;
 b=Q84mornNnUG9f7drMCQ851mpmJ62IzLgZ13o+BbURaDIn2mwEmzRqkGWGE6ZMzyAik
 gShzc9iOm2A5qSBZBbqFJnP/oyAcDVsi2EGMPAS90IwVWY7CYx9UD28pneHXvdy+Lf9q
 BDkDFiYZ0I8k7GxRcH5nXBJB7JCsIPdS0SdtiqMp+g3keKZ01JwhXNQmh9456oP/qItz
 V+60QK1P7SJAwAiQTdoEY19UABun9WVQRP52pXH/0Hk2E5M9lA1fspQsmxmNJzb0wLas
 OSLB7HCZRcwfKimwxwAKuKP3W5Nid9TucQC3quaGwJOc409f0d+WVjYYGey2pMWN1pRP
 u9ug==
X-Gm-Message-State: AAQBX9e5XFrIfR5/tfG4Cm/AmQBuqsDux4qFmkjaSdxpXkfHP0hyOTJo
 O7sxNw+NN+wRAelSI/KpM519+g==
X-Google-Smtp-Source: AKy350YpGxzPLIwor8+DKH5UMTOv8E83Zu2LeKHX4c7FkRKlCbIlCR8cBym6UhA2y6HclkSFaFD8Zg==
X-Received: by 2002:a17:903:24d:b0:1a6:4a25:c7f7 with SMTP id
 j13-20020a170903024d00b001a64a25c7f7mr2653035plh.6.1681475952405; 
 Fri, 14 Apr 2023 05:39:12 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a1709028d9500b001a527761c31sm3015366plo.79.2023.04.14.05.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 05:39:12 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH 0/3] Introduce a PCIe endpoint virtio console
Date: Fri, 14 Apr 2023 21:39:00 +0900
Message-Id: <20230414123903.896914-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

UENJZSBlbmRwb2ludCBmcmFtZXdvcmsgcHJvdmlkZXMgQVBJcyB0byBpbXBsZW1lbnQgUENJZSBl
bmRwb2ludCBmdW5jdGlvbi4KVGhpcyBmcmFtZXdvcmsgYWxsb3dzIGRlZmluaW5nIHZhcmlvdXMg
UENJZSBlbmRwb2ludCBmdW5jdGlvbiBiZWhhdmlvcnMgaW4Kc29mdHdhcmUuIFRoaXMgcGF0Y2gg
ZXh0ZW5kIHRoZSBmcmFtZXdvcmsgZm9yIHZpcnRpbyBwY2kgZGV2aWNlLiBUaGUKdmlydGlvIGlz
IGRlZmluZWQgdG8gY29tbXVuaWNhdGUgZ3Vlc3Qgb24gdmlydHVhbCBtYWNoaW5lIGFuZCBob3N0
IHNpZGUuCkFkdmFudGFnZSBvZiB0aGUgdmlydGlvIGlzIHRoZSBlZmZpY2llbmN5IG9mIGRhdGEg
dHJhbnNmZXIgYW5kIHRoZSBjb25jaXNlbmVzcwpvZiBpbXBsZW1lbnRhdGlvbiBkZXZpY2UgdXNp
bmcgc29mdHdhcmUuIEl0IGFsc28gYmUgYXBwbGllZCB0byBQQ0llCmVuZHBvaW50IGZ1bmN0aW9u
LgoKV2UgZGVzaWduZWQgYW5kIGltcGxlbWVudGVkIGEgUENJZSBFUCB2aXJ0aW8gY29uc29sZSBm
dW5jdGlvbiBkcml2ZXIgdXNpbmcKdGhlIGV4dGVuZGVkIFBDSWUgZW5kcG9pbnQgZnJhbWV3b3Jr
IGZvciB2aXJ0aW8uIEl0IGNhbiBiZSBjb21tdW5pY2F0ZQpob3N0IGFuZCBlbmRwb2ludCBvdmVy
IHZpcnRpbyBhcyBjb25zb2xlLgoKQW4gYXJjaGl0ZWN0dXJlIG9mIHRoZSBmdW5jdGlvbiBkcml2
ZXIgaXMgZm9sbG93aW5nOgoKIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUkCAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUkAog4pSCdmlydGlvICAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAg
ICAgICAgIOKUgnZpcnRpbyAgICAgIOKUggog4pSCY29uc29sZSBkcnYg4pSCICAgICAgICAg4pSc
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAg4pSC
Y29uc29sZSBkcnYg4pSCCiDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lKQgICAgICAgICDilIIodmlydGlvIGNvbnNvbGXilIIgICAgICDilJzilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilKQKIOKUgiB2aXJ0aW8gYnVzIOKUgiAgICAgICAgIOKUgiBk
ZXZpY2UpICAgICAgIOKUguKXhOKUgOKUgOKUgOKUgOKWuuKUgiB2aXJ0aW8gYnVzIOKUggog4pSc
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgICAgICAg4pScLS0tLS0t
LS0tLS0tLS0t4pSkICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkCiDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgcGNpIGVwIHZpcnRpbyDilIIgICAg
ICAgICAgICAgICAgICAg4pSCCiDilIIgIHBjaSBidXMgICDilIIgICAgICAgICDilIIgIGNvbnNv
bGUgZHJ2ICDilIIgICAgICAgICAgICAgICAgICAg4pSCCiDilIIgICAgICAgICAgICDilIIgIHBj
aWUgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQg
ICAgICAgICAgICAgICAgICAg4pSCCiDilIIgICAgICAgICAgICDilIIg4peE4pSA4pSA4pSA4pSA
4pSA4pa6IOKUgiAgcGNpIGVwIEJ1cyAgIOKUgiAgICAgICAgICAgICAgICAgICDilIIKIOKUlOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAgICAgICAgIOKUlOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmAogICBQQ0llIFJvb3Qg
ICAgICAgICAgICAgIFBDSWUgRW5kcG9pbnQKCkludHJvZHVjZWQgZHJpdmVyIGlzIGBwY2kgZXAg
dmlydGlvIGNvbnNvbGUgZHJ2YCBpbiB0aGUgZmlndXJlLiBJdCB3b3JrcwphcyBlcCBmdW5jdGlv
biBmb3IgUENJZSByb290IGFuZCB2aXJ0dWFsIHZpcnRpbyBjb25zb2xlIGRldmljZSBmb3IgUENJ
ZQplbmRwb2ludC4gRWFjaCBzaWRlIG9mIHZpcnRpbyBjb25zb2xlIGRyaXZlciBoYXMgdmlydHF1
ZXVlLCBhbmQKaW50cm9kdWNlZCBkcml2ZXIgdHJhbnNmZXJzIGRhdGEgb24gdGhlIHZpcnRxdWV1
ZSB0byBlYWNoIG90aGVyLiBBIGRhdGEKb24gcm9vdCB0eCBxdWV1ZSBpcyB0cmFuc2ZlcmVkIHRv
IGVuZHBvaW50IHJ4IHF1ZXVlIGFuZCB2aWNlIHZlcnNhLgoKVGhpcyBwYXRjaHNldCBpcyBkZXBl
bmQgZm9sbHdpbmcgcGF0Y2hlcyB3aGljaCBhcmUgdW5kZXIgZGlzY3Vzc2lvbi4KCi0gW1JGQyBQ
QVRDSCAwLzNdIERlYWwgd2l0aCBhbGlnbm1lbnQgcmVzdHJpY3Rpb24gb24gRVAgc2lkZQpsaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMzAxMTMwOTAzNTAuMTEwMzQ5
NC0xLW1pZUBpZ2VsLmNvLmpwLwotIFtSRkMgUEFUQ0ggdjIgMC83XSBJbnRyb2R1Y2UgYSB2cmlu
Z2ggYWNjZXNzb3IgZm9yIElPIG1lbW9yeQpsaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy92
aXJ0dWFsaXphdGlvbi8yMDIzMDIwMjA5MDkzNC41NDk1NTYtMS1taWVAaWdlbC5jby5qcC8KCkZp
cnN0IG9mIHRoaXMgcGF0Y2hzZXQgaXMgaW50cm9kdWNlIGEgaGVscGVyIGZ1bmN0aW9uIHRvIHJl
YWxpemUgcGNpCnZpcnRpbyBmdW5jdGlvbiB1c2luZyBQQ0llIGVuZHBvaW50IGZyYW1ld29yay4g
VGhlIHNlY29uZCBvbmUgaXMgYWRkaW5nCmEgbWlzc2luZyBkZWZpbml0aW9uIGZvciB2aXJ0aW8g
cGNpIGhlYWRlci4gVGhlIGxhc3Qgb25lIGlzIGZvciBQQ0llCmVuZHBvaW50IHZpcnRpbyBjb25z
b2xlIGRyaXZlci4KClRoaXMgaXMgdGVzdGVkIG9uIGxpbnV4LTIwMjMwNDA2IGFuZCBSQ2FyIFM0
IGJvYXJkIGFzIFBDSWUgZW5kcG9pbnQuCgpTaHVuc3VrZSBNaWUgKDMpOgogIFBDSTogZW5kcG9p
bnQ6IGludHJvZHVjZSBhIGhlbHBlciB0byBpbXBsZW1lbnQgcGNpIGVwIHZpcnRpbyBmdW5jdGlv
bgogIHZpcnRpb19wY2k6IGFkZCBhIGRlZmluaXRpb24gb2YgcXVldWUgZmxhZyBpbiBJU1IKICBQ
Q0k6IGVuZHBvaW50OiBBZGQgRVAgZnVuY3Rpb24gZHJpdmVyIHRvIHByb3ZpZGUgdmlydGlvLWNv
bnNvbGUKICAgIGZ1bmN0aW9uYWxpdHkKCiBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMv
S2NvbmZpZyAgICAgICAgfCAgMTkgKwogZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL01h
a2VmaWxlICAgICAgIHwgICAyICsKIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2kt
ZXBmLXZjb24uYyB8IDU1NCArKysrKysrKysrKysrKysrKysKIC4uLi9wY2kvZW5kcG9pbnQvZnVu
Y3Rpb25zL3BjaS1lcGYtdmlydGlvLmMgICB8IDQ2OSArKysrKysrKysrKysrKysKIC4uLi9wY2kv
ZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmlydGlvLmggICB8IDEyMyArKysrCiBpbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX3BjaS5oICAgICAgICAgICAgICAgfCAgIDMgKwogNiBmaWxlcyBj
aGFuZ2VkLCAxMTcwIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Bj
aS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12Y29uLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12aXJ0aW8uYwogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZpcnRpby5o
CgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
