Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A947BC001E0
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 19:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3175F41D88;
	Wed, 26 Jul 2023 19:23:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3175F41D88
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QglaE094
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqMT9T79RGGh; Wed, 26 Jul 2023 19:23:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3979241C6C;
	Wed, 26 Jul 2023 19:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3979241C6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 029EBC0072;
	Wed, 26 Jul 2023 19:23:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 921A4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 754EA41D7C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 754EA41D7C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DXL0GRRAlLE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:23:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4011441C6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:23:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4011441C6C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiK+K8XPXIf3OJyS5cr1MoTsWvMp38yMxhB2j9d9bpBaksJX7z2WGU9vcL0o+2Jmo/OuUQfyOD6smmje6bcxB2lKA11COr7sCvejML0AT34/15wmX2Ybqo22lzyRV1/Lu7AiCbCKe9upF4oSBQS0RUQW0DrGC0nw4EtVE/Aju5EELUMvKKBK/pVpBHyqU3TbFDwukQXisKSI2dPtrEAfY0N93ww8XWx67tIcc8om8wjcznC31IMEBfWy7gVPhZg6cgirg+wfIYTkXdPCmAkKSJ3ZbXcxDzGhOYqmwL2p85H49Y+eK52ywM2LODaQHSGY9bJdwLUPmZah34Q3TObeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEENZahkr/iM6VSAYmoMryqVAFyJ0KorIZaF9bcPsas=;
 b=jNp4guW+OAj6bdidAeIXIEOn9aPmtT9wlYLbTtHbolrl75sjq+GP9pG7RQF6f4E4tCW23ojBEr/mqrd+85Zpl8/IyH+xls+kg2L2bFDWawn8Xugbzo5HEwJYPTNi98kE6XNI0JQcxro1dL0reHqw8auUhGyjTkqAuuQgafztquQxsWG1nDoOFDKQKzbwlTK7d5aOcNpesLkzweUApSyXIvd8Nhpnj4a3lstkADcuhU3668AdROVXCQfAKkJjaNyrR73QFHYSqnp7zfCMgbdavV8xIyyYoCRwqhs2AKekvvMKILeQRok4ZCi5mlheiBY9P1ewvWuZLMS290J3tMsA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEENZahkr/iM6VSAYmoMryqVAFyJ0KorIZaF9bcPsas=;
 b=QglaE094twOxqqxM9P5mFB9sq9/va3PrRQT/Vpr8mZl/Z3TUy/cSTU/cEmj8khiccyEg9g0KhHpf0smi0wOjNwAsJIidj1X50BZg7woVA4yng3bipYo9LoNbnMBZb1d2q7h7VGms3vj2bYOHZvYLaY1eRQs2e/tRqSnJdts++tlAhx/wTVqnWXn8hoP1fwStOLYU/NrcZ9esF1On1/pu47jfALjUiLMFIdm0JslfqBKWpuksT6qJpT+53Be3ko+U03SFFeZDUf6xSria4EEJpVXBUZ3JO6JvAudr9kntlwNlIOfhexQAHElT5y4KYpR1iwJ+9vAohgoKPkdopzT1rw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 19:23:51 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 19:23:50 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Thread-Topic: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Thread-Index: AQHZv+9e5mifEKOj4EGSlYbK7Ha8O6/MYG+AgAAFcICAAAeqgA==
Date: Wed, 26 Jul 2023 19:23:50 +0000
Message-ID: <22afb03057250ab8d37ab977cd210719ecf0bcd1.camel@nvidia.com>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
 <20230726143640-mutt-send-email-mst@kernel.org>
 <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
In-Reply-To: <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB6907:EE_
x-ms-office365-filtering-correlation-id: 809071ca-6326-4910-7ac2-08db8e0dd78a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KheRSkJhW55M+2P9vrnAYl2YTBD/HS6IpRp8MutcwsNzwgEGXB9l1GGp6nIrQD0pTHvghrA3Diww8fqIjf0hJtyukC+EuNjTzmRv1FGTYh4T7tmiNmrnkh1P2jAGxMXI7jcms5qlBpGJrfhkPToszHW/DVjJL6mG6Pjt7w4kMHblTuTA0Q4nGwb27DKkDLtjYFxnfjEAAHeLaTPlXq9m7LYq4uzobp+pfFBORgu/k/7h8zU0Tzx0GvE/GR+TZmKK04mLgFugRUp0UVTi4g65SZyGGkzLwlHpa81rt1yFKLPRDtIEYqZBNOaLKr4Yx+QKBZVXCi0KcdlL8ysh0ZK+qPceWZdbTkR5KsveulCPRR+TF7If0uKLcbfwKvH8tJGoEupi0xh3sXtZNZzuVK3ZSi4xRH7cCR1ofp6JC7r1/ibX+oVPBZvBeuKYJfDlM5f9ZaeIw+gCfDtkQXTSaeg9Itb5DfWeHCOqckdSMH30Xjh4Tr7xzDau5Qm0uiLiuJtVjhEDlDqP0vpvd4btYzZTKpESiSZz4AkEcujCgqZTrkqrj5MDsLbgNabuFZYLPTv7Lb6ZBTdvf4DdFHPdzj4T+J53DswlqjyZvXIBbJ2ItLj4sRBEDOPWnySSgZoWTUWFEMJf4i+TEoc5pGl6XoldqwAsYQ2y8/h1zfV21pbUU/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(2906002)(186003)(6506007)(71200400001)(316002)(122000001)(38100700002)(2616005)(83380400001)(41300700001)(5660300002)(66476007)(66946007)(66556008)(91956017)(66446008)(76116006)(6916009)(4326008)(8676002)(8936002)(36756003)(38070700005)(86362001)(64756008)(54906003)(6486002)(478600001)(6512007)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emJzVHozdEpISDAvaVI2ZVIxdVdUNmgwOUxXa3pENk45OHViMTJrQ3FwWEpJ?=
 =?utf-8?B?MkpiaUptdlJvZ3p2c1M0dFVRbllFRm9pUkhwdWgxLzZiS0dRM0RqUFNxaUxZ?=
 =?utf-8?B?L0pXejQ0TlY0Uk9OTkd0dndmK1ZTUXZGK2prY3lLSW9zcnJLNEorZ1JWd2pD?=
 =?utf-8?B?MVJiNzByT1RCeDdkRUx5UU05aHlGMVBVVUVBMXNJZlVnWXQ4T3lwT1pnMHNw?=
 =?utf-8?B?SDVvZXlFOE5Kc3hUMTBQbzJlejlFdnI5cDVpMDVDc2dRczV5Mk5HeG1EOXE1?=
 =?utf-8?B?Y1FmMXhadFpkQjlSakVQNjQ2RW9mcXpQbHNZR241bWhESHVYZGx5aVcyZ3dO?=
 =?utf-8?B?djRYRGRyQVBmVnA5ajlUZGR3cmxueC9STWRjVGZMcmU5UXZEREtXVEx4ZUpW?=
 =?utf-8?B?UGNreEdhL3JMNjBMbitDMHUydThRaDFjbnlYMG1WUHI3VGVGNzVuenY1ZExU?=
 =?utf-8?B?UUh4MDBhTkpScWd5OTNsang0UVVtOEZrZDdNRDQvYUxvVVorSmlPdFh2a29a?=
 =?utf-8?B?U1BPQisrTDNWK2xlM21HelNPV2RjN1B3T00vSENWMU8xU0ZUb2xCdUVRZnoz?=
 =?utf-8?B?NUY5c0dPVlBGL0tHQ0lBcE1LWFlkRnJERmpYWDVoS1NrSjlkWWVEWDJZaVNE?=
 =?utf-8?B?TjI5RjVvcmNPMEx3a1dPOUpGWkJGalk3ZkgzQTl2L2p6UTNNRzk1K2I3dEY1?=
 =?utf-8?B?WEJPR1JlL3pJYUE0SVhTMlpQdG12YzN2WGg5RkpQR1JCdzgyTXRaM0hpd2Zn?=
 =?utf-8?B?cUwvWjJkd0Y2US95VFk4b0RQQ1ZXOE4vWERUVHNTSFAvUDJUM2k3M2lkTmdV?=
 =?utf-8?B?Mk94dXpTNHRZd0x1MlR4MWVuQXlNbjRhVk4zWXY0bWNpS3N0c08wZXRNU0RT?=
 =?utf-8?B?QWhQVXBJc1habHo2bUV4ckxDY0tiOVI5djBIUGVXRlgrTUh1UWNEY2xHK2ZI?=
 =?utf-8?B?UXFydnYzRDRzY1hVeUMxMlRCNUFVTURNS0NsUy9PU1VmUlBMUFVtaUhhbzVR?=
 =?utf-8?B?RW1WSmdyMjIxWVlBVGtzRUZjdlAwT2hic0J3dmtzWTh1bDZadUNLeWd4Skxq?=
 =?utf-8?B?YU1FSjBXb3NkMUs1M0lBRmlPM2plS3pTMHMvWFNSYjhBbHN0UUdtekhHZkpF?=
 =?utf-8?B?V2dWT2wyU0o4TDJIZE5zZitYbmZlYmkvN1c0WWpNSG5POVlKVHRBaDZ0c1lC?=
 =?utf-8?B?ZHU0YXJ4YlVuQzFvWFlLM1IyVUVUVGE0MXhrUWhuUTNxc0pNRHpvRjFqTlpL?=
 =?utf-8?B?QmtFTmtXSDdkbGQxR1hXbEsySkhrTHdjUGswTzFYMHl0NFhIbVNRS0l6K3Q1?=
 =?utf-8?B?bUUvWllidXZTc1ZVNjcvMmtEQjZaNm81UEpnbHprV1VkdGlRZDliSW53YjRC?=
 =?utf-8?B?R0QvdmlSRHdyRUlVNDRCb0cvN3BEVXpVYlV5Z2VZNGltSmxUcjFWUkZsYmpn?=
 =?utf-8?B?UzV3YTFyUGNsbUpsdWxVOVNIOXFjRVpYd3hvZjZyMmhUWmh0T2xNeStyNzV3?=
 =?utf-8?B?UWdxUVp1ckw3QjJ3QTZCa1dmNnlRejE1TmRBZ00zNmRMeVpDNlNIYW1kKzdq?=
 =?utf-8?B?cTBvSTdMWkdPUVlic1VsRnY4NlhoN3NpaTdDZkhUcThnTndEY0YycFc5YjhB?=
 =?utf-8?B?Q09YandaR1JKcHFZY3k3UmlVaW80RXhpYkJ3TDlsdkJ3UWF2MGV1YXp1NS9a?=
 =?utf-8?B?Ujh4RFYzOVNXRlN6Q3c1WnlwMlM2RzBmVVB2aDlNMEVrME1hT3hpMHFobEJK?=
 =?utf-8?B?NVlBVkg3dkJ6VVMrUEliTW5XWUtTelBJcXZFUTJNNVpQajZIY3M4dGMrVkE1?=
 =?utf-8?B?Z0YzTW93TmluUUNrVFhpdzJCV2k3MHcwQWx4aWZvWXpHWjQ4RlpWc1hGZVgr?=
 =?utf-8?B?bWZhdks3RTBqZkR6ajR1c0VzQnRkeCt0UFYwT0t2bjBKTmY4RHE3V0RCUEo1?=
 =?utf-8?B?TXhBbHYwRkQ1TFh4ZjB6c2piQmUyU1RLc2JKRVpVSTdySkJlaTMxa0xIcTlX?=
 =?utf-8?B?S0FLSUhNUzAzUEl3ZjBZU1hTdVAzdGRrR1d2Y0lpVGUrckh1eExqTHE4VGxt?=
 =?utf-8?B?WTJEUFhQUWJOSmhtcFdwVEVHQVREVzM5UGdWK3ovTFFBK0xGcmpTRGJvbjFs?=
 =?utf-8?B?c2tzNm1HaHhhblFENlFPMWpkN2h1K3pNY3A1ZVE5OHhVSFNnSk1YeFNUUUtU?=
 =?utf-8?Q?i70PcE5pD5Z433BwhNM7UWiCAxztiEFzMMAEqMBE1/7Q?=
Content-ID: <A1860EF4F3A4E5498FB180D6340B407E@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809071ca-6326-4910-7ac2-08db8e0dd78a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 19:23:50.4489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5xpaSUYw5BK5a95BhdK3qeKtZrGdjV5ICyU/IfveHA/5qe8RiQx/jNlR02cLULpozbqzuYGXlZX4OZ5pk6QiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDIwOjU2ICswMjAwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToN
Cj4gT24gV2VkLCAyMDIzLTA3LTI2IGF0IDE0OjM2IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6DQo+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMDk6MzA6NDhQTSArMDMwMCwgRHJh
Z29zIFRhdHVsZWEgd3JvdGU6DQo+ID4gPiBUaGUgb3JpZ2luYWwgcGF0Y2ggZnJvbSBMaW4gTWEg
ZW5hYmxlcyB0aGUgdmRwYSBkcml2ZXIgdG8gdXNlIHZhbGlkYXRpb24NCj4gPiA+IG5ldGxpbmsg
b3BzLg0KPiA+ID4gDQo+ID4gPiBUaGUgc2Vjb25kIHBhdGNoIHNpbXBseSBkaXNhYmxlcyB0aGUg
dmFsaWRhdGlvbiBza2lwIHdoaWNoIGlzIG5vIGxvbmdlcg0KPiA+ID4gbmVjY2VzYXJ5LiBQYXRj
aHNldCBzdGFydGVkIG9mIGZyb20gdGhpcyBkaXNjdXNzaW9uIFswXS4NCj4gPiA+IA0KPiA+ID4g
WzBdDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8yMDIzMDcy
NjA3NDcxMC1tdXR0LXNlbmQtZW1haWwtbXN0QGtlcm5lbC5vcmcvVC8jdA0KPiA+IA0KPiA+IENj
IHN0YWJsZSB3aXRoIGF0IGxlYXN0IDEvMiA/DQo+ID4gDQo+IFNlbnQgYSB2MiB3aXRoIHN0YWJs
ZSBpbiBjYy4gQnV0IGxvb2tzIGxpa2UgMS8yIGJyZWFrcyB0aGUgImZpeCBvbmUgdGhpbmcNCj4g
b25seSINCj4gcnVsZSBkdWUgdG8gdGhlIG1hbnkgRml4ZXMgdGFncyBJIGd1ZXNzLi4uDQo+IA0K
T3IgbXkgbGFjayBvZiB1bmRlcnN0YW5kaW5nOiBJIG9ubHkgbm93IHJlYWxpemUgdGhhdCAiQ2M6
IHN0YWJsZSIgaXMgYSB0YWcgaW4NCnRoZSBwYXRjaC4gTXkgYmFkLiBXaWxsIHJlLXNlbmQuDQoN
Cj4gPiA+IERyYWdvcyBUYXR1bGVhICgxKToNCj4gPiA+IMKgIHZkcGE6IEVuYWJsZSBzdHJpY3Qg
dmFsaWRhdGlvbiBmb3IgbmV0bGlua3Mgb3BzDQo+ID4gPiANCj4gPiA+IExpbiBNYSAoMSk6DQo+
ID4gPiDCoCB2ZHBhOiBDb21wbGVtZW50IHZkcGFfbmxfcG9saWN5IGZvciBubGF0dHIgbGVuZ3Ro
IGNoZWNrDQo+ID4gPiANCj4gPiA+IMKgZHJpdmVycy92ZHBhL3ZkcGEuYyB8IDkgKysrLS0tLS0t
DQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+ID4gPiANCj4gPiA+IC0tIA0KPiA+ID4gMi40MS4wDQo+ID4gDQo+IA0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
