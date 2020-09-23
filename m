Return-Path: <SRS0=DI/B=DA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EDDC4363D
	for <virtualization@archiver.kernel.org>; Wed, 23 Sep 2020 07:30:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9DE2076B
	for <virtualization@archiver.kernel.org>; Wed, 23 Sep 2020 07:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9DE2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ACF2422EC9;
	Wed, 23 Sep 2020 07:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sA34BznGL0fU; Wed, 23 Sep 2020 07:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D699822E96;
	Wed, 23 Sep 2020 07:30:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFF5AC0889;
	Wed, 23 Sep 2020 07:30:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FB42C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 07:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E36186031
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 07:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id okHv9Tox2Tdl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 07:30:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 69EEF85FFC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 07:30:33 +0000 (UTC)
IronPort-SDR: m9KPBkja3Um4Ws+1iHSitdWSyejzh1rQ0l2e1YE5fMVxxHoknkurw9naZM12lBLStBt2crVzPE
 aArHSjzNYHdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148554400"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
 d="scan'208,217";a="148554400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 00:30:32 -0700
IronPort-SDR: XKyKGPDA4pPAOu8dLRAfmUZR53QAYw+ehj5dOW1l1hBK+fcWl/yGEB4MTF6rWAXEBUFCdlaBlM
 a79qEXKggTEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
 d="scan'208,217";a="454798418"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga004.jf.intel.com with ESMTP; 23 Sep 2020 00:30:31 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 00:30:30 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 15:30:28 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 15:30:28 +0800
From: "Deng, Jie" <jie.deng@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
Thread-Topic: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
Thread-Index: AQHWkIxPyynJxpe3OEi9jK7MOSHMUalz/nkAgAHVd4A=
Date: Wed, 23 Sep 2020 07:30:28 +0000
Message-ID: <4b0bcab709324767b13fea577c5cebf5@intel.com>
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <20200922112348.GL3956970@smile.fi.intel.com>
In-Reply-To: <20200922112348.GL3956970@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ms-exchange-imapappendstamp: SHSMSX601.ccr.corp.intel.com (15.01.1713.001)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.108.32.68]
MIME-Version: 1.0
Cc: "Sergey.Semin@baikalelectronics.ru" <Sergey.Semin@baikalelectronics.ru>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "loic.poulain@linaro.org" <loic.poulain@linaro.org>, "Wang,
 Yu1" <yu1.wang@intel.com>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "wsa@kernel.org" <wsa@kernel.org>,
 "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
 "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "Liu, Shuo A" <shuo.a.liu@intel.com>,
 "tali.perry1@gmail.com" <tali.perry1@gmail.com>, "Chen, 
 Conghui" <conghui.chen@intel.com>, "jdelvare@suse.de" <jdelvare@suse.de>
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
Content-Type: multipart/mixed; boundary="===============9178172919796281040=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9178172919796281040==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4b0bcab709324767b13fea577c5cebf5intelcom_"

--_000_4b0bcab709324767b13fea577c5cebf5intelcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpPbiAyMDIwLzkvMjIgMTk6MjMsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCg0KDQoNCisgICAg
ICAgICAgaWYgKCghdm1zZykgfHwgKHZtc2cgIT0gJnZpLT52bXNnKSkgew0KDQoNCg0KVGhpcyBp
cyBhIGJpdCBkaWZmaWN1bHQgdG8gcmVhZCAoZXNwLiB0YWtpbmcgaW50byBhY2NvdW50IHRoZSBh
Ym92ZSBjb21tZW50KQ0KDQpiZXNpZGVzIHRoZSBmYWN0IG9mIHJlZHVuZGFudCBwYXJlbnRoZXNl
cy4gV2h5IG5vdCBzaW1wbHk6DQoNCg0KDQogICAgICAgICBpZiAoISh2bXNnICYmIHZtc2cgPT0g
JnZpLT52bXNnKSkgew0KDQoNCg0KPw0KDQpUaGFua3MgQW5keS4gSXQgbG9va3MgYmV0dGVyLg0K
DQoNCg0KDQoNCi0tDQoNCjIuNy40DQoNCg0KDQoNCg==

--_000_4b0bcab709324767b13fea577c5cebf5intelcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <41CFDC4671C9454F9198678DF70668AC@intel.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkRlbmdYaWFuOw0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAx
IDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJpOw0KCXBhbm9zZS0xOjIgMTUg
NSAyIDIgMiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6IlxARGVuZ1hpYW4i
Ow0KCXBhbm9zZS0xOjIgMSA2IDAgMyAxIDEgMSAxIDE7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZh
bWlseTpDb25zb2xhczsNCglwYW5vc2UtMToyIDExIDYgOSAyIDIgNCAzIDIgNDt9DQovKiBTdHls
ZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1h
bA0KCXttYXJnaW46MGNtOw0KCW1hcmdpbi1ib3R0b206LjAwMDFwdDsNCglmb250LXNpemU6MTEu
MHB0Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmO30NCnByZQ0KCXttc28tc3R5
bGUtcHJpb3JpdHk6OTk7DQoJbXNvLXN0eWxlLWxpbms6IkhUTUwgUHJlZm9ybWF0dGVkIENoYXIi
Ow0KCW1hcmdpbjowY207DQoJbWFyZ2luLWJvdHRvbTouMDAwMXB0Ow0KCWZvbnQtc2l6ZToxMC4w
cHQ7DQoJZm9udC1mYW1pbHk6IkNvdXJpZXIgTmV3Ijt9DQpzcGFuLkhUTUxQcmVmb3JtYXR0ZWRD
aGFyDQoJe21zby1zdHlsZS1uYW1lOiJIVE1MIFByZWZvcm1hdHRlZCBDaGFyIjsNCgltc28tc3R5
bGUtcHJpb3JpdHk6OTk7DQoJbXNvLXN0eWxlLWxpbms6IkhUTUwgUHJlZm9ybWF0dGVkIjsNCglm
b250LWZhbWlseToiQ29uc29sYXMiLHNlcmlmO30NCnNwYW4uRW1haWxTdHlsZTIxDQoJe21zby1z
dHlsZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7fQ0KLk1zb0NocERlZmF1bHQNCgl7bXNvLXN0eWxl
LXR5cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1zaXplOjEwLjBwdDt9DQpAcGFnZSBXb3JkU2VjdGlv
bjENCgl7c2l6ZTo2MTIuMHB0IDc5Mi4wcHQ7DQoJbWFyZ2luOjcyLjBwdCA3Mi4wcHQgNzIuMHB0
IDcyLjBwdDt9DQpkaXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwv
c3R5bGU+PCEtLVtpZiBndGUgbXNvIDldPjx4bWw+DQo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJl
ZGl0IiBzcGlkbWF4PSIxMDI2IiAvPg0KPC94bWw+PCFbZW5kaWZdLS0+PCEtLVtpZiBndGUgbXNv
IDldPjx4bWw+DQo8bzpzaGFwZWxheW91dCB2OmV4dD0iZWRpdCI+DQo8bzppZG1hcCB2OmV4dD0i
ZWRpdCIgZGF0YT0iMSIgLz4NCjwvbzpzaGFwZWxheW91dD48L3htbD48IVtlbmRpZl0tLT4NCjwv
aGVhZD4NCjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSIjMDU2M0MxIiB2bGluaz0iIzk1NEY3MiI+
DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHA+PG86cD4mbmJzcDs8L286cD48L3A+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gMjAyMC85LzIyIDE5OjIzLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJt
YXJnaW4tdG9wOjUuMHB0O21hcmdpbi1ib3R0b206NS4wcHQiPg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PGJyPg0KPGJyPg0KPG86cD48L286cD48L3A+DQo8YmxvY2txdW90ZSBzdHlsZT0ibWFyZ2lu
LXRvcDo1LjBwdDttYXJnaW4tYm90dG9tOjUuMHB0Ij4NCjxwcmU+JiM0MzsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgaWYgKCghdm1zZykgfHwg
KHZtc2cgIT0gJmFtcDt2aS0mZ3Q7dm1zZykpIHs8bzpwPjwvbzpwPjwvcHJlPg0KPC9ibG9ja3F1
b3RlPg0KPHByZT48bzpwPiZuYnNwOzwvbzpwPjwvcHJlPg0KPHByZT5UaGlzIGlzIGEgYml0IGRp
ZmZpY3VsdCB0byByZWFkIChlc3AuIHRha2luZyBpbnRvIGFjY291bnQgdGhlIGFib3ZlIGNvbW1l
bnQpPG86cD48L286cD48L3ByZT4NCjxwcmU+YmVzaWRlcyB0aGUgZmFjdCBvZiByZWR1bmRhbnQg
cGFyZW50aGVzZXMuIFdoeSBub3Qgc2ltcGx5OjxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+
Jm5ic3A7PC9vOnA+PC9wcmU+DQo8cHJlPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBpZiAoISh2bXNnICZhbXA7JmFtcDsgdm1zZyA9PSAmYW1wO3ZpLSZn
dDt2bXNnKSkgezxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9wcmU+
DQo8cHJlPj88bzpwPjwvbzpwPjwvcHJlPg0KPC9ibG9ja3F1b3RlPg0KPHA+VGhhbmtzIEFuZHku
IEl0IGxvb2tzIGJldHRlci48bzpwPjwvbzpwPjwvcD4NCjxwPjxvOnA+Jm5ic3A7PC9vOnA+PC9w
Pg0KPGJsb2NrcXVvdGUgc3R5bGU9Im1hcmdpbi10b3A6NS4wcHQ7bWFyZ2luLWJvdHRvbTo1LjBw
dCI+DQo8cHJlPjxvOnA+Jm5ic3A7PC9vOnA+PC9wcmU+DQo8cHJlPi0tIDxvOnA+PC9vOnA+PC9w
cmU+DQo8cHJlPjIuNy40PG86cD48L286cD48L3ByZT4NCjxwcmU+PG86cD4mbmJzcDs8L286cD48
L3ByZT4NCjxwcmU+PG86cD4mbmJzcDs8L286cD48L3ByZT4NCjwvYmxvY2txdW90ZT4NCjwvZGl2
Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_4b0bcab709324767b13fea577c5cebf5intelcom_--

--===============9178172919796281040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9178172919796281040==--
