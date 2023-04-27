Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42747C77B61
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 10:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92C1E40543;
	Thu, 27 Apr 2023 10:44:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92C1E40543
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=MXoqBeEe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sddOKpCPb2Jx; Thu, 27 Apr 2023 10:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E7501400CF;
	Thu, 27 Apr 2023 10:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7501400CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8AAFC0037;
	Thu, 27 Apr 2023 10:44:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C4CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 988E241D63
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 988E241D63
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=MXoqBeEe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZaw0WTuVdB3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A371641C21
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A371641C21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:37 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-63b733fd00bso6528140b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682592277; x=1685184277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QPjgq3zlWYQFj7c/g/9N/OxqaeG5Njw/y80poNIzu/A=;
 b=MXoqBeEes7wZrkLALkHP5t+W1nwEgOd2Hsq+KKGx3YGVx3bZZbzO+3lAUhe13VKgNu
 ZZobnrBUZH1XrJOgVhERqBCThWEyc5bx/rNJOXZMWIKoUUa+LbSS4sMNvaaH6GSMGBQY
 wgu9WgHdDiH+VL22wrhyazR7yNxzimoxcDyIv0L+JFcLZdRUbvy8N8ANCNDlnZVrvJon
 KDpKI9bPWiF6oJkJ+1fb2a8WXGPMJTAZIAL/mZyoEPb8d3wuyihrdnovBnk6C8QBbaTV
 AlgXZi1l9LJXwifEKUcs9KBgM0mzHDQ30TAAxt5h7Zbpq6YYgAOpLcyN4LFDrAw9ZVMD
 nQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682592277; x=1685184277;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QPjgq3zlWYQFj7c/g/9N/OxqaeG5Njw/y80poNIzu/A=;
 b=kZKXZe8oaqv4AlUgsc+i6auwt9LRhILMD16YnbJpIszjh2CC5gkc3zl6ZuhASdUxeI
 4YDFX3MfhxtO2dpLnxvfFun462mkN3kkIGmadVSF4Q2dxtkZNspd8tyzBuYLfRPD27NS
 cBOCn60GDwjgiiAkIWIbefeS/SJAP1BSGMpdWyo4EF4UCTHkzZroXMLoQSzLyQb5Zmdy
 Bnv9MVG9jR0BU2nLbk/s2shxM0WkJPfD4V0zq03G+MpUCi3mF2/2twhq97DYhXB+sqIQ
 DQh6jY9WH7ey22cERDKQHZ0scI4iFyKtb+I0cdcQBjXO1m/D/rwJIhLgUyXEP7MWlCT2
 2Acw==
X-Gm-Message-State: AC+VfDyk1LGuQbF2ryJGwNNWO8huZDEax7xmbogl0zYM5ySXZSQV9FN+
 LggjbjO4hTurlwNZ9z8/pN1mJw==
X-Google-Smtp-Source: ACHHUZ6uU2L9eISIY6VmEOhsO9zwuUAYLUCc/j7JkEeY/3QW0LLDLHvBK0O2sX46EQbhgMALIkR9Cw==
X-Received: by 2002:a05:6a20:8402:b0:ef:ef0d:7dd9 with SMTP id
 c2-20020a056a20840200b000efef0d7dd9mr1174846pzd.51.1682592276646; 
 Thu, 27 Apr 2023 03:44:36 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a631b03000000b0050f93a3586fsm11029042pgb.37.2023.04.27.03.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 03:44:36 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH v2 0/3] Introduce a PCIe endpoint virtio console
Date: Thu, 27 Apr 2023 19:44:25 +0900
Message-Id: <20230427104428.862643-1-mie@igel.co.jp>
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
NC0xLW1pZUBpZ2VsLmNvLmpwLwotIFtQQVRDSCB2M10gdnJpbmdoOiBJT01FTSBzdXBwb3J0Cmxp
bms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uL0NBQ0drTUV1bXQ0cDdq
VStIK1QtYjlNeTBidWhkUzhhLTFHQ1NuV2puQ3dNQU09d28xUUBtYWlsLmdtYWlsLmNvbS9ULyN0
CgpGaXJzdCBvZiB0aGlzIHBhdGNoc2V0IGlzIGludHJvZHVjZSBhIGhlbHBlciBmdW5jdGlvbiB0
byByZWFsaXplIHBjaQp2aXJ0aW8gZnVuY3Rpb24gdXNpbmcgUENJZSBlbmRwb2ludCBmcmFtZXdv
cmsuIFRoZSBzZWNvbmQgb25lIGlzIGFkZGluZwphIG1pc3NpbmcgZGVmaW5pdGlvbiBmb3Igdmly
dGlvIHBjaSBoZWFkZXIuIFRoZSBsYXN0IG9uZSBpcyBmb3IgUENJZQplbmRwb2ludCB2aXJ0aW8g
Y29uc29sZSBkcml2ZXIuCgpUaGlzIGlzIHRlc3RlZCBvbiBuZXh0LTIwMjMwNDE2IGFuZCBSQ2Fy
IFM0IGJvYXJkIGFzIFBDSWUgZW5kcG9pbnQuCgpTaHVuc3VrZSBNaWUgKDMpOgogIFBDSTogZW5k
cG9pbnQ6IGludHJvZHVjZSBhIGhlbHBlciB0byBpbXBsZW1lbnQgcGNpIGVwIHZpcnRpbyBmdW5j
dGlvbgogIHZpcnRpb19wY2k6IGFkZCBhIGRlZmluaXRpb24gb2YgcXVldWUgZmxhZyBpbiBJU1IK
ICBQQ0k6IGVuZHBvaW50OiBBZGQgRVAgZnVuY3Rpb24gZHJpdmVyIHRvIHByb3ZpZGUgdmlydGlv
LWNvbnNvbGUKICAgIGZ1bmN0aW9uYWxpdHkKCiBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlv
bnMvS2NvbmZpZyAgICAgICAgfCAgMTkgKwogZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25z
L01ha2VmaWxlICAgICAgIHwgICAyICsKIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9w
Y2ktZXBmLXZjb24uYyB8IDU5NiArKysrKysrKysrKysrKysrKysKIC4uLi9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdmlydGlvLmMgICB8IDQ1OCArKysrKysrKysrKysrKwogLi4uL3Bj
aS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12aXJ0aW8uaCAgIHwgMTI2ICsrKysKIGluY2x1
ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggICAgICAgICAgICAgICB8ICAgMyArCiA2IGZpbGVz
IGNoYW5nZWQsIDEyMDQgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZjb24uYwogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZpcnRpby5jCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdmlydGlv
LmgKCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
