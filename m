Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410B3399A
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221485; cv=fail; b=D1S8R6em9PLEBnkCWSfTS0ecPce7myhEeA5Ff2I1WgcSUQ/DOHENsoE1YUIoDonxyMUfy66FZwso+tG9e+IKc1WUZS/DF9Jn49IZQ+rscdm9EZibCEENLYXybZsXmSslbIr9kdoZndQ0j6696neu+SGqWnSP/QHp5UA8ffNPdYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221485; c=relaxed/simple;
	bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WZH9mvaA63HyMGb8qWNfp2l5SJcxWk26TJhV1S/4k4Z84B1c2Q1w8PHSG5fpsSjoeuIvPL8uYNi71adgCE9c7OgxpLPpmREQM68ERdTfhrFFQrQ5fd+mVdfF823mJQMXGggDf7kdBgHYK1EItUwJEY20kgTxhJu3Q9Znc1x7mzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b=hUtexo1L; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phd.unipi.it header.i=@phd.unipi.it header.b="hUtexo1L"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C57640B40
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 09:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.002
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBDAf-Ff2q1W for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Apr 2024 09:04:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2611::700; helo=eur04-vi1-obe.outbound.protection.outlook.com; envelope-from=alberto.ottimo@phd.unipi.it; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EC4374038B
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=phd.unipi.it
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC4374038B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=phd.unipi.it header.i=@phd.unipi.it header.a=rsa-sha256 header.s=selector1 header.b=hUtexo1L
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:2611::700])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EC4374038B
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 09:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqX6Zttj0M3Oppf5YTOumxLgs34U2Im/FKbWJyDudccFxXpMvRgsABg2PsJj8Z4Y1EBTkX7UyFEDfKkalN0ZP5Y4hySCsisu6USbZ133mkyYaYYPqysLAjay+lvxTdktMG7v6h3d8daxlPxckgbYcgytLKBgY0Z5zZtU3XDvaOH+QbdkPK+MYhEOGApQTzvoyCzLrZUGtyetRrXmePhibju+H/Guu3H8EC5Cr/pIF7GI34FAd1Dgar8ovgwCTkO6fmR1adEoafxPs9PCqinbYsrPj+Xvxfk7NPn2mZAC3DmpzujHUHzYjJ8XZzX/S0cahxK/1E2jtAEHi/WwwULDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
 b=OnFi8B8I3mqiUh0yPehFt/00KTvA/emb5zBIgTWynIiUrctewE3L4ei4MI5H8IMm6Kwmu/NE+Lr8b283u/x8l7OMoUNd8roTeR3fMzCRqKINviE1AlPPwVd/UMvXdbWfnp7R4dhK1AxPic+uCPRHnJp82mDojZFMwc7KtQOLUCD72pHyIN9fMwFNomEF7gWn4TA+hGRL/OTqaclH8fdMdKnV99f+ePQ/7DrIg+iKnRq4edkW9i7E+pOVig49szOTIypFmfHYEd/DuGHXZO8weEDfMgI+lQ/K6ibpRWbeuL7301+6nWT9lgp0EvicUBUprC82ZeD2VcLz8+aaiTjRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phd.unipi.it; dmarc=pass action=none header.from=phd.unipi.it;
 dkim=pass header.d=phd.unipi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phd.unipi.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LbQY8T1IqnB28yWxXThEUouDV7cW54hh3moMAUnnZQ=;
 b=hUtexo1LOrb7rtpZXLw0yiy49a4NBBQbB+B2benHebVSr9c+R2uO+LvjUXRxGH5oETJ6mGQGP3wmTZpZO3F1Mhss3nLEIo8z5UJiY3SlwaKBckSM7ggZdjN+zfUAz16TQEQtkv4dXh06+Lin+nmFc9C8F2HEvIO7Vx3jx962XNQ=
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com (2603:10a6:20b:4c4::17)
 by GV1PR07MB9069.eurprd07.prod.outlook.com (2603:10a6:150:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 09:04:35 +0000
Received: from AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::1a84:daa4:7969:dd41]) by AS1PR07MB8408.eurprd07.prod.outlook.com
 ([fe80::1a84:daa4:7969:dd41%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 09:04:35 +0000
From: Alberto Ottimo <alberto.ottimo@phd.unipi.it>
To: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on Scalable
 Compute Continuum
Thread-Topic: [CFP] WSCC 2024: Euro-Par 2024 International Workshop on
 Scalable Compute Continuum
Thread-Index: AQHahm8dJAKAX9VDZ0i0kg/DbM+Qqw==
Date: Thu, 4 Apr 2024 09:04:34 +0000
Message-ID: <A3BBF64F-5E2F-4792-92EB-CBC251D2DD6B@studenti.unipi.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR07MB8408:EE_|GV1PR07MB9069:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TmEq2ovzYCz9sLhGuo0NZBpsy4OR9x4he4j20DykqT1oc2fl+mz6XXwHnnCMEpKiMskwMNgX+KwJdSxwVy90fVYFVYlrRHFT4FOkbgEUIuhPzdMvPiX6giys3fNd+o7Yp+mWr68JZwFrveYrk0DYGyN1l+Iiqg0MVEXGMc9UBehcgrJ529b0QT6OkPwGHNxDGIyuSwbxZzqX8oM79HKnROThvcG6iZeq/+c4PLNu2LZZQ6gfxGEpvm4jl47k0U/mVsVlPKGFH9N3MKDZVAWRIVd81euhz15PxKyrutf8PhVTq7GkB1UxH8FKP1NavastAcA4HeGqdT0AlwgrWdk8UMq0FaNlPLQbl/5HC1IQ6LqdErJ/WTFNshvNIEzL3mYkV1X/I8vx3+yDY1Wlbb3fwRgDva+F6ivJ/Ke0BXECV1i4vjLSlNcUssoP7VwNvtsE/MrlumcpTWi1WKQswrhQcMgN6InsvLcZDdixBkUa1dmi3R2eQ64qH+jIM9Kvey4y+lg6qBUKuh6wdQz3r9TwNgNorb1rXrOAjDGqtUVJbw7OUQWSINgQ9QYt+3fFjUebFj6k1rdmJotzsmoalDHgflJSlbL735isvHKeZEIqi30=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR07MB8408.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlNORVNoN3NUQTN2cjJKbm5vT3dvdWNtdHZCMGV3djF3UmNDWXBqYXZCU2Rh?=
 =?utf-8?B?dnlLV0FYTHJyakoyNEtIblRYbVFBM0JLWXBxR3dHeWhrNUFvNWxGMnlDRXk1?=
 =?utf-8?B?dk5HQ2svNlRybmR5RlZBelZFeFpwdzl1cGpKK1l4RkxwcFhDenYzQzZ6MUJL?=
 =?utf-8?B?UDBld3J6a1FhTFVVYmJtV1NjOWFnM2lsbXVHWE84YmlGTnZ1SUZid2F3VHN5?=
 =?utf-8?B?aWQ2VEp4WXArMGtGTjZjQjVRc2FycEVhZEx4SDd5bjBSZlgvNjJSV0gyckRa?=
 =?utf-8?B?QnZIVUtXb2RTTk41UnRNaTMxVzFFU21hYkliSHQzOU5Jdmh2bmNMZUVKL2dO?=
 =?utf-8?B?QnBVdlFRTzZKTWNCRkVFQVptVDBpUWk1K0RyQ3pZcDVUUk53VXhpZFFrNGVi?=
 =?utf-8?B?RVJjZjFxbFlRWHBpRDMrZ1RhU1I0eFpIQXFacGJtWVFlV0h3QzNWaElHSXVj?=
 =?utf-8?B?RUpnRlV1YkI3Z0lQL1pBZjgxS3JkdlltMWNYclBYVklJNFkreFQ0dUdKaGth?=
 =?utf-8?B?d2NpVkFUdUd5Z3JPOSsxOVJmUXBBYUIrNkxNS2VKWnFzQWc0cXJJaHhWOTVy?=
 =?utf-8?B?V01scnFJbFR5YmVnTENNZE5UTWttN3ZqTlMxUXZpb2ZFSEhzUGhzNXpydHhU?=
 =?utf-8?B?YXdOL0ZJRmFyTWlreVlnNXMrRDdHODV6UENNMmVuRmRjTUlsLytVMzVkeEVZ?=
 =?utf-8?B?YXNZa2ZueDZ6c2kvS2ZtVG9hRHN1K01ZaDdseXhhWVk3dkRseEovRSt4dHZG?=
 =?utf-8?B?b1FKQ3JkR2c2T1lwV2p6Tzg5SnJRaTFCdDVFbjA3MU5CbjRlMHJrbGwyWTFX?=
 =?utf-8?B?U29TT1RlZmtTb1NhWmpZV1prclBJLzFpcG9TV0FuZlFSYmhMUGt2K2VYVXBw?=
 =?utf-8?B?c0lUZnFmUW5MV1o2bElnL3A3cUpBYVVmTFRIVFZhQ3RNc3JvQnlqM2g2SkVM?=
 =?utf-8?B?L0V4UllnOG5aRERlYU9ZTHZ5SDNoa2RrZ2k4NXdBajFGT3gxdXBsN1FHdXRv?=
 =?utf-8?B?S0loeUNwS0hEMFN5eFVwWmw0U2ZjR1IwOUt1dUc1ZmYvcjQ0NEhzWHM5Vm1q?=
 =?utf-8?B?bS8ybE1hVERZcXpScDZXaDgwU1NwZUZjTVZ2RG5NVmI1cE9FRlRZMG0vV2dx?=
 =?utf-8?B?Vnlwb0FPblRIQldsMlNUZVJuSXhFK1d3RTFzb3JsYTZNUWpDWUw4L3NqZzYv?=
 =?utf-8?B?aGdSZFRXSVlha1BWVnpIUU5rSWt3aktxeU1kQjlKQXlEOGFGTktCa1Ficjg1?=
 =?utf-8?B?azF0WUtOS01pMnhzSHJPVHdyeVBCVE1TYmZIMmRyeS9BcnNod2EzTVFSZ0hr?=
 =?utf-8?B?eTNIelU3K3VtUUFEQkduRjE4NThjV1I1aGpYbXdTUldKaXo2OEF0YmRpWmkw?=
 =?utf-8?B?RHA1cHV3QjVnb1hSSys4ZFRYemM2Z1g1dDZWb0xRdWduenpGYVpjQkZ5bGlo?=
 =?utf-8?B?MFB2YU1FNllKYTBFQnBHclFTQzBPb2NwVGZlYmlrVXE1SUhHWFR3NmhUYlpU?=
 =?utf-8?B?OFVDYllhNC9IUDNscGY1ZnBnb3lqaW9Vb3MxS280YVpzZEp5QklrQnZnV09G?=
 =?utf-8?B?aEp4NWZVVXRTWDJIeTVydWFYSXVWQlNIREpDNnhkSXJBZGZJeE0xd0drYkJH?=
 =?utf-8?B?eUo5NThtRzI2KzB1ZjFwTlN6YkNzaXBmM3dGeXBNS2lqSnBYMDJoT1NlQWVj?=
 =?utf-8?B?cVd6MEVFT01wM1U1M0tUWFNQRXQvVWRoNlBLYlh0ZHB5M1cya3pOSFV3QUk0?=
 =?utf-8?B?VFJaNGxDRlVadkVKdHFTemxFQmcxTmorNWpRQmZTdlNkNDRwMmQvbGVvbXpk?=
 =?utf-8?B?TEh1bmgybTZvN1JaZ0RreENVVGttbFpWM0drTlVkRlQvUG8rK3BTQVZhRFlC?=
 =?utf-8?B?VVljY0ZjYTdaRk5jSWxrSUlKYUZqWDZQVHh4ZzhVbjNscFZReWErTE0rZmJo?=
 =?utf-8?B?T01CL3BJSDhvR0lEMFZUMXpkcXdxNHRWeGFWbThpeTN6N01XdFNLanltb0da?=
 =?utf-8?B?M0FOcjJBUlRGVGFJLzBQZDlxYW9mQ3poaFM1UnFrV1RSQkZwNVRVeWxRT3pm?=
 =?utf-8?B?Vk1ac3d6cjZYZ1U1MklLbWdQZ0NQZWdsWVpqWkxITWRsbC9ZM3VuWkdMOHRY?=
 =?utf-8?B?ckF0L2JaanZXYmR2dWI4WktKZGFLaHFueEJUQkg3bTVkbDdjd2JFdTRUSUNt?=
 =?utf-8?Q?OE2C7JXtqNaccYgDHEzlNDkZ5/QMAPnoLEVSWvInvSBW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A8433B43B1A7C468773DB5C950CA61D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: phd.unipi.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR07MB8408.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23fd045-8cb9-453d-acaf-08dc54863fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 09:04:34.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c7456b31-a220-47f5-be52-473828670aa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3RdhP7G6KAFoysIifmQ7nfXPEeUI4oC7XHkvJTETeSNhH/Ir3ZTWB1dWhAiElv4/a1+B19VPLhnISU6rlLSKPinxHbUkX7MN2N5E+oT38c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9069

KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCldTQ0MgMjAyNDogRXVy
by1QYXIgMjAyNCBJbnRlcm5hdGlvbmFsIFdvcmtzaG9wIG9uIFNjYWxhYmxlIENvbXB1dGUgQ29u
dGludXVtDQpEYXRlOiAyNi0yNyBBdWd1c3QgMjAyNA0KTG9jYXRpb246IE1hZHJpZCwgU3BhaW4N
CldvcmtzaG9wIHdlYiBwYWdlOiBodHRwczovL3dzY2MuZGkudW5pcGkuaXQvDQpFdXJvLVBhciB3
ZWIgcGFnZTogaHR0cHM6Ly8yMDI0LmV1cm8tcGFyLm9yZy8NCioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqDQoNCiogQ2FsbCBmb3IgUGFwZXJzDQpUaGUg4oCcQ29tcHV0
ZSBDb250aW51dW3igJ0gcGFyYWRpZ20gcHJvbWlzZXMgdG8gbWFuYWdlIHRoZSBoZXRlcm9nZW5l
aXR5IGFuZCBkeW5hbWlzbSBvZiB3aWRlc3ByZWFkIGNvbXB1dGluZyByZXNvdXJjZXMsIGFpbWlu
ZyB0byBzaW1wbGlmeSB0aGUgZXhlY3V0aW9uIG9mIGRpc3RyaWJ1dGVkIGFwcGxpY2F0aW9ucyBp
bXByb3ZpbmcgZGF0YSBsb2NhbGl0eSwgcGVyZm9ybWFuY2UsIGF2YWlsYWJpbGl0eSwgYWRhcHRh
YmlsaXR5LCBlbmVyZ3kgbWFuYWdlbWVudCBhcyB3ZWxsIGFzIG90aGVyIG5vbi1mdW5jdGlvbmFs
IGZlYXR1cmVzLiBUaGlzIGlzIG1hZGUgcG9zc2libGUgYnkgb3ZlcmNvbWluZyByZXNvdXJjZSBm
cmFnbWVudGF0aW9uIGFuZCBzZWdyZWdhdGlvbiBpbiB0aWVycywgZW5hYmxpbmcgYXBwbGljYXRp
b25zIHRvIGJlIHNlYW1sZXNzbHkgZXhlY3V0ZWQgYW5kIHJlbG9jYXRlZCBhbG9uZyBhIGNvbnRp
bnV1bSBvZiByZXNvdXJjZXMgc3Bhbm5pbmcgZnJvbSB0aGUgZWRnZSB0byB0aGUgY2xvdWQuIEJl
c2lkZXMgY29uc29saWRhdGVkIHZlcnRpY2FsIGFuZCBob3Jpem9udGFsIHNjYWxpbmcgcGF0dGVy
bnMsIHRoaXMgcGFyYWRpZ20gYWxzbyBvZmZlcnMgbW9yZSBkZXRhaWxlZCBhZGFwdGF0aW9uIGFj
dGlvbnMgdGhhdCBzdHJpY3RseSBkZXBlbmQgb24gdGhlIHNwZWNpZmljIGluZnJhc3RydWN0dXJl
IGNvbXBvbmVudHMgKGUuZy4sIHRvIHJlZHVjZSBlbmVyZ3kgY29uc3VtcHRpb24sIG9yIHRvIGV4
cGxvaXQgc3BlY2lmaWMgaGFyZHdhcmUgc3VjaCBhcyBHUFVzIGFuZCBGUEdBcykuIFRoaXMgZW5h
YmxlcyB0aGUgZW5oYW5jZW1lbnQgb2YgbGF0ZW5jeS1zZW5zaXRpdmUgYXBwbGljYXRpb25zLCB0
aGUgcmVkdWN0aW9uIG9mIG5ldHdvcmsgYmFuZHdpZHRoIGNvbnN1bXB0aW9uLCB0aGUgaW1wcm92
ZW1lbnQgb2YgcHJpdmFjeSBwcm90ZWN0aW9uLCBhbmQgdGhlIGRldmVsb3BtZW50IG9mIG5vdmVs
IHNlcnZpY2VzIGFpbWVkIGF0IGltcHJvdmluZyBsaXZpbmcsIGhlYWx0aCwgc2FmZXR5LCBhbmQg
bW9iaWxpdHkuIEFsbCBvZiB0aGlzIHNob3VsZCBiZSBhY2hpZXZhYmxlIGJ5IGFwcGxpY2F0aW9u
IGRldmVsb3BlcnMgd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgaG93IGFuZCB3aGVyZSB0
aGUgZGV2ZWxvcGVkIGNvbXBvbmVudHMgd2lsbCBiZSBleGVjdXRlZC4gVGhlcmVmb3JlLCB0byB1
bmxlYXNoIHRoZSB0cnVlIHBvdGVudGlhbCBvZmZlcmVkIGJ5IHRoZSBDb21wdXRlIENvbnRpbnV1
bSwgcHJvYWN0aXZlLCBhdXRvbm9tb3VzLCBhbmQgaW5mcmFzdHJ1Y3R1cmUtYXdhcmUgbWFuYWdl
bWVudCBpcyBkZXNpcmFibGUsIGlmIG5vdCBtYW5kYXRvcnksIGNhbGxpbmcgZm9yIG5vdmVsIGlu
dGVyZGlzY2lwbGluYXJ5IGFwcHJvYWNoZXMgdGhhdCBleHBsb2l0IG9wdGltaXphdGlvbiB0aGVv
cnksIGNvbnRyb2wgdGhlb3J5LCBtYWNoaW5lIGxlYXJuaW5nLCBhbmQgYXJ0aWZpY2lhbCBpbnRl
bGxpZ2VuY2UgbWV0aG9kcy4NCg0KSW4gdGhpcyBsYW5kc2NhcGUsIHRoZSB3b3Jrc2hvcCBpcyB3
aWxsaW5nIHRvIGF0dHJhY3QgY29udHJpYnV0aW9ucyBpbiB0aGUgYXJlYSBvZiBkaXN0cmlidXRl
ZCBzeXN0ZW1zIHdpdGggcGFydGljdWxhciBlbXBoYXNpcyBvbiBzdXBwb3J0IGZvciBnZW9ncmFw
aGljYWxseSBkaXN0cmlidXRlZCBwbGF0Zm9ybXMgYW5kIGF1dG9ub21pYyBmZWF0dXJlcyB0byBk
ZWFsIHdpdGggdmFyaWFibGUgd29ya2xvYWRzIGFuZCBlbnZpcm9ubWVudGFsIGV2ZW50cywgYW5k
IHRha2UgdGhlIGJlc3Qgb2YgaGV0ZXJvZ2VuZW91cyBhbmQgZGlzdHJpYnV0ZWQgaW5mcmFzdHJ1
Y3R1cmVzLiBBIHBhcnRpYWwgbGlzdCBvZiBpbnRlcmVzdGluZyB0b3BpY3Mgb2YgdGhpcyB3b3Jr
c2hvcCBpcyB0aGUgZm9sbG93aW5nOg0KDQotIFNjYWxhYmxlIGFyY2hpdGVjdHVyZXMgYW5kIHN5
c3RlbXMgZm9yIENvbXB1dGUgQ29udGludXVtDQotIFN5c3RlbSBzb2Z0d2FyZSBmb3IgY2xvdWQt
ZWRnZS1Jb1Qgb3JjaGVzdHJhdGlvbg0KLSBEaXN0cmlidXRlZCBhbmQgZGVjZW50cmFsaXplZCBt
YW5hZ2VtZW50IG9mIHJlc291cmNlcyBhbmQgYXBwbGljYXRpb24gZGVwbG95bWVudCBpbiB0aGUg
Q29tcHV0ZSBDb250aW51dW0NCi0gUHJvZ3JhbW1pbmcgbW9kZWxzLCBsYW5ndWFnZXMgYW5kIHBh
dHRlcm5zIGZvciB0aGUgQ29tcHV0ZSBDb250aW51dW0NCi0gQ29tcHV0ZSBDb250aW51dW0gcGVy
Zm9ybWFuY2UgbW9kZWxpbmcgYW5kIGFuYWx5c2lzDQotIEZ1bmN0aW9uLWFzLWEtU2VydmljZSBh
bmQgQmFja2VuZC1hcy1hLVNlcnZpY2UgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQotIEVuZXJn
eS1lZmZpY2llbnQgc29sdXRpb25zIGZvciBzdXN0YWluYWJsZSBDb21wdXRlIENvbnRpbnV1bQ0K
LSBBSSBpbiBhbmQgZm9yIHRoZSBDb21wdXRlIENvbnRpbnV1bQ0KLSBTY2FsYWJsZSBhcHBsaWNh
dGlvbnMgZm9yIENvbXB1dGUgQ29udGludXVtIChJb1QsIG1pY3Jvc2VydmljZXMsIHNlcnZlcmxl
c3MpDQotIERhdGEtaW50ZW5zaXZlIGFuZCBzdHJlYW0gcHJvY2Vzc2luZyBzeXN0ZW1zIGFuZCBh
cHBsaWNhdGlvbnMgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQotIERpZ2l0YWwgVHdpbnMgYW5k
IGluZHVzdHJ5IGFwcGxpY2F0aW9ucyBpbiB0aGUgQ29tcHV0ZSBDb250aW51dW0NCi0gUHJvdG90
eXBlcyBhbmQgcmVhbC1saWZlIGV4cGVyaW1lbnRzIGludm9sdmluZyBDb21wdXRlIENvbnRpbnV1
bQ0KLSBCZW5jaG1hcmtzIGFuZCBleHBlcmltZW50YWwgcGxhdGZvcm1zIGZvciByZXByb2R1Y2li
bGUgZXhwZXJpbWVudHMgaW4gdGhlIENvbXB1dGUgQ29udGludXVtDQoNCiogU3VibWlzc2lvbiBJ
bnN0cnVjdGlvbnMNClRoZSBwYXBlcnMgc2hvdWxkIGJlIGZvcm1hdHRlZCBhY2NvcmRpbmcgdG8g
dGhlIExOQ1MgZ3VpZGVsaW5lcy4gVGhleSBzaG91bGQgYmUgYmV0d2VlbiBhIG1pbmltdW0gb2Yg
MTAgYW5kIG1heGltdW0gb2YgMTIgcGFnZXMuDQoNCiogU3BlY2lhbCBJc3N1ZQ0KU2VsZWN0ZWQg
cGFwZXJzIHdpbGwgYmUgaW52aXRlZCB0byBzdWJtaXQgYW4gZXh0ZW5kZWQgdmVyc2lvbiB0byBh
IEpvdXJuYWwgU3BlY2lhbCBJc3N1ZS4gV2UgYXJlIGluIGNvbnRhY3QgdG8gcHJvcG9zZSBhIFNw
ZWNpYWwgSXNzdWUgaW4gYSBoaWdoLXF1YWxpdHkgam91cm5hbC4gSW5mb3JtYXRpb24gd2lsbCBh
cHBlYXIgc29vbiBvbiB0aGUgV1NDQyB3ZWIgc2l0ZS4NCg0KKiBJbXBvcnRhbnQgRGF0ZXMNCiAg
TWF5IDZ0aCwgMjAyNCAgICAgICBQYXBlciBzdWJtaXNzaW9uIGRlYWRsaW5lDQogIEp1bmUgMTd0
aCwgMjAyNCAgICBQYXBlciBhY2NlcHRhbmNlIG5vdGlmaWNhdGlvbnMNCiAgSnVseSAxc3QsIDIw
MjQgICAgICAgQ2FtZXJhLXJlYWR5IGR1ZQ0KDQoqIFdvcmtzaG9wIENvLUNoYWlycw0KLSBWYWxl
cmlhIENhcmRlbGxpbmksIFVuaXZlcnNpdHkgb2YgUm9tZSBUb3IgVmVyZ2F0YSwgSXRhbHkNCi0g
UGF0cml6aW8gRGF6emksICAgICBVbml2ZXJzaXR5IG9mIFBpc2EsIEl0YWx5DQotIEdhYnJpZWxl
IE1lbmNhZ2xpLCAgVW5pdmVyc2l0eSBvZiBQaXNhLCBJdGFseQ0KLSBNYXR0ZW8gTmFyZGVsbGks
ICAgIEJhbmsgb2YgSXRhbHksIEl0YWx5DQotIE1hc3NpbW8gVG9ycXVhdGksICAgVW5pdmVyc2l0
eSBvZiBQaXNhLCBJdGFseQ0KDQpMb29raW5nIGZvcndhcmQgdG8gcmVjZWl2aW5nIHlvdXIgZXhj
ZWxsZW50IHN1Ym1pc3Npb25zIHNvb24uDQoNCkJlc3QgcmVnYXJkcywNCg0KVmFsZXJpYSBDYXJk
ZWxsaW5pLCBQYXRyaXppbyBEYXp6aSwgR2FicmllbGUgTWVuY2FnbGksIE1hdHRlbyBOYXJkZWxs
aSwgYW5kIE1hc3NpbW8gVG9ycXVhdGkNCg0KDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KQWxiZXJ0byBPdHRpbW8NClBoRCBTdHVkZW50DQpEZXBhcnRtZW50IG9mIENv
bXB1dGVyIFNjaWVuY2UNClVuaXZlcnNpdHkgb2YgUGlzYSwgSXRhbHkNCkUtbWFpbDogYWxiZXJ0
by5vdHRpbW9AcGhkLnVuaXBpLml0DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0=
