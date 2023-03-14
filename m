Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842AC7618E
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 01:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E83781322;
	Tue, 14 Mar 2023 01:57:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E83781322
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=OZTRdQ4j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxW1oFzva7ho; Tue, 14 Mar 2023 01:57:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8241A80C25;
	Tue, 14 Mar 2023 01:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8241A80C25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6227DC0071;
	Tue, 14 Mar 2023 01:57:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C225C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 01:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67E4240218
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 01:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67E4240218
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=microsoft.com header.i=@microsoft.com
 header.a=rsa-sha256 header.s=selector2 header.b=OZTRdQ4j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhlDCDb0R1N5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 01:56:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 054CB40155
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com
 (mail-cusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 054CB40155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 01:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqrD9Vur3wc5agpzmcd2QQZl9t+e6VgmXsFh8S55FH1TsbAZaMJQlx/8gnbm5q+6pg+41RPfL8/AhKS2G4+t1Ny6GVmfRvCblv0hOhTaFABvctIzwjw8vKpJWMiYi/jrYZFd+pz912LBMHCMCpVGfIo/PrSek0GOwUfbcltlCCWTMA6NOkQ725M6rG4yfMztrJ72ctqZPL52QBY2nfzzmIl++qe8avrqenIzyWpYBpfaNUFY5M519mroqhVQHUQSEAGKiYKdZD/A4SvGWW+4OlGQK2rgo+KndcUz9dHXfcfWjCaIriPNq1JjbLd05VszuxD5RrE6K1VDf3UW6OeVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5lLwixqmQjMsRnPLE+o99ICNmxMoWGQhOWi/FjPtAg=;
 b=E0pcn7ZvOCEIn9WUUMg0UgyDf+hWB4HjUyPswCWRbaGSjTfZY6/jUDHuUirbkiLvpVaPVyapOgcfmgcmcGpYBtlrPnLnCdqMr+ThgKbvSxsnpSk12yeZfp662aFQ89gsQk+LmwVEQRqCDQ+YcIrVGlNYFVNR8ANAFmCJagKIX1gnAmBhLvkHmdw4C6GYKU9x0xF0UxEQwl2heXcxQvpewzRNC1DZxEAsN5TZWZ4eU5eCfFoy3HICeSRF6VgvY3vFZ/MGAvG0tiwNjV+otnpo1pVpsj+1mxuuazxbLh5fMBkyK5lV6l0RQKxOxlrqbXx1Qyp5eZXygRbRkKJb0Zcr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5lLwixqmQjMsRnPLE+o99ICNmxMoWGQhOWi/FjPtAg=;
 b=OZTRdQ4jueIm9tBQXSKuOvStCkQedfaSmKv3Iqht1TOILmqp6hf5VJY9pLN/jrGDxFpdBQdkNQBe4s2S+OxM94ynprJukNvUNeqd6XAjipQVkWu2Rt2Ey1O6hozn3y12C0vWDzTKiv124g0xxzQpovLxd93hsXxtV8CybXQpoKo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH2PR21MB1495.namprd21.prod.outlook.com (2603:10b6:610:8d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.5; Tue, 14 Mar
 2023 01:56:54 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6222.003; Tue, 14 Mar 2023
 01:56:54 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Topic: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Index: AQHZUTma1YX9/OQzMkiQz3mMWYqOma70Wb1QgATkhYCAAEg44A==
Date: Tue, 14 Mar 2023 01:56:54 +0000
Message-ID: <BYAPR21MB1688FBD79441A4D75BBDAB24D7BE9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1678223570-25242-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BYAPR21MB16889A9D76888A485D7BB19FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <e777ad2e-0bad-3a04-b831-ebd07edb7fc3@linux.microsoft.com>
In-Reply-To: <e777ad2e-0bad-3a04-b831-ebd07edb7fc3@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bfbc7f8b-e3cd-4fc3-a47a-9e907290199b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-14T01:29:47Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH2PR21MB1495:EE_
x-ms-office365-filtering-correlation-id: 621b5e48-b96c-4cad-acc6-08db242f62c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RkXcyFb4yqyxM7tzaHngsjKlte8QTVtUajPI+6wdfuQQM7Uh/5vVjZLBX3vGoYs95+4l6HxG2drgA6ZTSrr7k5rhyu3XXDhtjLpUDJRVhaLifsqTxqKhs/QqVmQP9mHK0yaou3Fs+Gaf/puW7s8tuaTyjs3c8eGm/zdgNVU1N5TPBj8HKEnczXpmdNvMmmyWTr1aqE33WoBp3TV2rNnn8oQerWC07TfD3WYk45pyXRwVX9gbdQgFjzFK7Og8kW22Hhz9rADks+QX7sDIHL+Nk6FbGpotQMLpfHG8qT92Sa0fVHZE8FekCG13FDWiDQznvZqqpkhSbDU0NGLaShcGUCqCQ+QhoA7yASLq88V/qBjwk+FABEq1qVb8aZ8JWH5LR7vQghHB4lDZu+0yDkwWZL3iEP2t4NseNr6VvFizqP3RMyQMXklRua8FOLq61GTCqvZTdPvSEG62hjJO9axGBsiYmLhccEW7uOHAiugKsbrJFTuTerU2hcO89VnIQK8FAX2NeNoxLVK4i4Z63eaHcXeZpBau5TxRZuBLDoibPyWXV5Bp27snOEX4ex9HgHDKYPWvfS3VK7kIPcz50pdNQdVD9+wAqO70FigedIQmIMqgCgHRCWsuXTzQDRkTiWfYOn7eQ8tcNHD1udHM3AaLxvN7KC0JA+6WLLUrVWWaEuDEGDmPONAFP7Co6wP6XUoJGb0eJRJSLbXyXd3O5ced9ykXRPTGpy996yOGDmSwevJNoWG2t5qOKBZB33/Kgr9A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR21MB1688.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(33656002)(316002)(54906003)(110136005)(76116006)(55016003)(83380400001)(7696005)(71200400001)(26005)(478600001)(10290500003)(9686003)(53546011)(186003)(6506007)(8936002)(5660300002)(52536014)(38070700005)(8990500004)(86362001)(30864003)(2906002)(4326008)(8676002)(66446008)(64756008)(66476007)(66946007)(66556008)(38100700002)(41300700001)(82960400001)(82950400001)(122000001)(66899018)(579004)(559001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjJ0TEJLWWNlZWgzSGxWYy9oVTlEVlJBNkY1bnh6d1ZiTmhDSlY3OEI5MFFa?=
 =?utf-8?B?eXNldlRycmdmWHhweVpudk96Mm9PdjhmVGE3ZlBBbGR2UUp4MWtRRnVwV2U4?=
 =?utf-8?B?Nko5WEtpa3prVUQ4VU9oT2hnVUc5TjE2SmtHWlZBRVh3RkxpU1dXOE82TEZ5?=
 =?utf-8?B?N2wwL2FMQTROV1Y1NThQZlAvWjdJNEt3bmhaeEdWNXdOaForbEFybTcwaG1i?=
 =?utf-8?B?QTM4T0lReXB6KzBPWktNL0ZlVFY3S21Ka1VFR2tGTGVWeENYdzRBRGcvTDhi?=
 =?utf-8?B?eGwzeTBlMWVSU01MTGJGSFRaN1Zyb2lwTi9nb0tkZWxXd0IvYWxmUUFEQlVa?=
 =?utf-8?B?UlIzOHBGQkNKbzRTZXRiemQ2MlFBQVZRVWxWcTNiS2RVTmRrRWgzcGk5TFZr?=
 =?utf-8?B?OVdxNDM1WS9mVXFRM3Y4TXQ4ZTdlMFd6UHJxRnUxTEtVejZxSkhuTFNOYklH?=
 =?utf-8?B?Y2JtNzZCWG1mYTlNSnhtaWUxOFBXTElXSnJaVXEwWHBEdXJNa1F6eU1LaUwz?=
 =?utf-8?B?M0pWYmlvcWRxSDR2T3J1MXFhOVhITHZsU2M3bjl1a3I2N2VnZzhQUGFGREt1?=
 =?utf-8?B?TXRGOTVKa3hqZVpQWlpJNEJCbDVwTDdVeVpkR0hUbXF2dEtmOWFNOVV0LzJU?=
 =?utf-8?B?WmVPMmJmODlBZ3JJaVQxOUREOVhYY1phY3ZlcFpDamxOdnlBdG5seXBkUGYy?=
 =?utf-8?B?MUZyZkJob2dkZmJnMm00Q2hmYklVZXRBdHZGNUNBSC9NR1JkQkdwMExyQXg3?=
 =?utf-8?B?Sm1BQmhxa0liVEZ4Tys2TEVxSVVKYjVsYUpSaFQ2U0ZkU2FONEFnLzhzejlJ?=
 =?utf-8?B?Z3E2RHdiZndHZzlUQ0lCUEkrSHp2eW9iVE0rNkFpMDVORHRlcWxkS290WG0r?=
 =?utf-8?B?bnZEMDU3UDhnclNxcmd2ZnJaV3JhNnhDY3FLZ1dLQzl6bzFPUmtwVHgzb1JT?=
 =?utf-8?B?TDdLWmhXaGJLbFBGM1JkZjhxRi9UUDhoN1g4SG1TZ203R0JEZkRLT0NMYlFR?=
 =?utf-8?B?T3RnWDR3VHFOV3YwNmVEUDJmdVRoR01CUm5QbnlYRjRBK2pwLzhXVHdXZDJL?=
 =?utf-8?B?MTFYUVZmV1FrR0VUck5hNUxKaCtNb1Jjc2dYcFcwRS9zMDc3ZnB0RUxNNTYv?=
 =?utf-8?B?ZU9XRHk5d3FTS3E0ZG5OU2dYZE1kM2U3SzE5SkRHb3FQMCtjVU5YM0VNenFJ?=
 =?utf-8?B?Y1UrdkVBWmlTK1YyUEtCWXRaWXVMa0I4dS9FWkI5LzI1Z1ZvTHlrTFVsQkEz?=
 =?utf-8?B?Q2dyRnZUQnV5KzVENk5ldWp4UXRFYlNJajdPRGd1WDl1RnUxdFljMkVYWkV2?=
 =?utf-8?B?b3dKYXkvRFYwZHc3RmlSM3RqUzVZeW9lZWVxYk1Qd244UnZqVXBwbW1jMXFt?=
 =?utf-8?B?UjZ4UzAydWFmL0ZqTzdUSHREemRwZ0RtK09Gd0kxWUp5SHBlc0F2cjNlMnZn?=
 =?utf-8?B?NitGV1Q3eEkrR0ZyRTRqaXlBSHdYcUkvNFdJMGxoODVZWjdaNGw4ME5WbVVw?=
 =?utf-8?B?bENaR3lFV1ppSXErUlBrYkUyL2lmeis3L2o1RWo5WkF3MEFGWFFvbmh2Q2lT?=
 =?utf-8?B?YkttR0xtODR3NTZCUXhDa1UrWnFJTE0vRXB4dDcxTHZLOG9UWW1KUzZQRTdK?=
 =?utf-8?B?bS9LaHVPV3JRNTVNN1dNanM5dkNHcCtGbkZaVHBVRm5MZDB5clFQNS9kRTd1?=
 =?utf-8?B?ZVU4dVArK2JCSGlOMWlpdklPYXFvTVd4KzAxa1ZDajJJcE1sMk11eWJqNnR3?=
 =?utf-8?B?TERXQS8vNE95ZzY3Z2d0SnN6WnA1VEQ0amtHSWFqWmR4UGpVcGk0TVAvcjVJ?=
 =?utf-8?B?WGxCV1N1NVpmaitwdkhHcGRTTVRHY3ZIcERjT2JjZ0xJTXlQaE9adzhnRUxY?=
 =?utf-8?B?aCtFaFNWV1A0a2NxUzdFKzZ2bVdlbVl5dlhYRFhZcXhuRHpzYWRKMHhDS0tx?=
 =?utf-8?B?TTNrNmpYa1dWM0ZrN2o1ZGVRU3I2YnB0RlNGV2lyUFpTVjU2WUtlL3YyVW5n?=
 =?utf-8?B?OExIWkhSbUhjZjlrOWc1dkgyTFVOMW11TEVSakxaNmJmdDVtSmtKemZTcEp0?=
 =?utf-8?B?QXkrZUM0S2E0OVlRT1MrR0lvNVduR05VeEdWMDMzL0dXK0hzK3pFRGpWVFJF?=
 =?utf-8?B?Qlc0SEordzR6Rk1CakRGMm9weXRuL1M4NDVSK1dLWTFQYWtITVV3ZzdjOWV1?=
 =?utf-8?B?Y2c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621b5e48-b96c-4cad-acc6-08db242f62c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 01:56:54.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXv7ANQlZoWnK/UiNXj2HGObseAfqRpNGYh0d2vAkdpD84tCtqXTQZbo5t+k4pXgEaeJYaCChjbQY52lzBzEPGQ4E9zrr3sTGvRHK9RBF3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1495
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
From: "Michael Kelley \(LINUX\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, March 13, 2023 2:11 PM
> 
> On 3/10/2023 11:30 AM, Michael Kelley (LINUX) wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, March 7,
> 2023 1:13 PM
> >>
> >> In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
> >> accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
> >> VP registers accessed via get/set vp registers hypercall.
> >>
> >> This is due to HV_REGISTER_* names being used by hv_set/get_register,
> >> with the arch-specific version delegating to the appropriate mechanism.
> >>
> >> The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
> >> VP registers when they are introduced for x86 in future.
> >>
> >> This patch solves the issue by:
> >>
> >> 1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
> >>    This is so HV_REGISTER_ can be reserved for VP registers.
> >>
> >> 2. Change the non-arch-specific alias used by hv_set/get_register to
> >>    HV_SYNTHETIC_REG.
> >
> > I definitely messed this up when I first did the ARM64 support a
> > few years back.  :-(    This is a necessary fix.
> >
> > What about keeping HV_REGISTER_ as the prefix for the architecture
> > independent alias, and creating a new prefix for the Hyper-V register
> > definition?  This would allow the existing hv_get/set_register()
> > invocations to remain unchanged, and eliminates the code churn
> > in the arch independent code.
> >> The HV_X64_MSR_ prefix is definitely good for the MSR addresses,
> > especially since a lot of definitions that are x86/x64 only are still in use.
> > Then perhaps use HV_HYP_REG_ or something similar for the Hyper-V
> > register definition.
> 
> This could work.
> 
> Ideally, we would use HV_REGISTER_ for the vp registers as it's a direct match
> to the name in HyperV e.g. HvRegisterVpIndex-> HV_REGISTER_VP_INDEX

You make a good point.

> 
> However if you think it's better to reduce churn and go with a different
> name then that's fine by me.

I was specifically thinking about 3 large-ish patch sets for Confidential VMs
that we have pending.  The Confidential VM patches have various changes
to the synic code in hv.c so it overlaps with your changes to the register
naming.  The Confidential VM patches need to be backported to earlier
Linux kernel versions, and I was trying to avoid unrelated churn to ease
the backport process.   How urgent is fixing this register naming problem?
If it could go after the Confidential VM patches, then there's less churn for
the backports.

But in the grand scheme of things, we can deal with the churn.  It's just
some manual work that isn't hard.  Net, I'm OK with either approach.

> 
> HV_HYP_REG_ is ok, though maybe HV_VP_REG_ is a bit more informative?
> "VP_REG" indicating it's relevant to HVCALL_GET/SET_VP_REGISTERS.

Yes, HV_VP_REG_ is good as the register prefix if you decide to keep
HV_REGISTER_ as the architecture independent prefix.

> 
> >
> > If you don't like that suggestion, I wonder if the HV_SYNTHETIC_REG_
> > prefix could be shortened to help avoid line length problems.  Maybe
> > HV_SYNREG_ or HV_SYN_REG_ ?
> >>>
> >> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> >> ---
> >>  arch/arm64/include/asm/hyperv-tlfs.h |  25 +++++
> >>  arch/x86/include/asm/hyperv-tlfs.h   | 137 +++++++++++++--------------
> >>  arch/x86/include/asm/mshyperv.h      |   8 +-
> >>  arch/x86/kernel/cpu/mshyperv.c       |  22 ++---
> >>  drivers/clocksource/hyperv_timer.c   |  24 ++---
> >>  drivers/hv/hv.c                      |  32 +++----
> >>  drivers/hv/hv_common.c               |   4 +-
> >>  drivers/hv/vmbus_drv.c               |  14 +--
> >>  include/asm-generic/mshyperv.h       |   2 +-
> >>  9 files changed, 146 insertions(+), 122 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-
> >> tlfs.h
> >> index bc6c7ac934a1..474025eb3d7e 100644
> >> --- a/arch/arm64/include/asm/hyperv-tlfs.h
> >> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> >> @@ -64,6 +64,31 @@
> >>  #define HV_REGISTER_STIMER0_CONFIG	0x000B0000
> >>  #define HV_REGISTER_STIMER0_COUNT	0x000B0001
> >>
> >> +/*
> >> + * To support non-arch-specific code calling hv_set/get_register:
> >> + * - On x86, HV_SYNTHETIC_REG_ indicates an MSR accessed via rdmsrl/wrmsrl
> >> + * - On ARM, HV_SYNTHETIC_REG_ indicates a VP register accessed via hypercall
> >
> > Nit:  Let's use the full "ARM64" instead of just "ARM" here so that there's no
> > confusion about whether 32-bit ARM is supported.
> >
> 
> Good point
> 
> >> + */
> >> +#define HV_SYNTHETIC_REG_VP_INDEX		(HV_REGISTER_VP_INDEX)
> >> +#define HV_SYNTHETIC_REG_TIME_REF_COUNT
> >> 	(HV_REGISTER_TIME_REF_COUNT)
> >> +#define HV_SYNTHETIC_REG_REFERENCE_TSC
> >> 	(HV_REGISTER_REFERENCE_TSC)
> >> +
> >> +#define HV_SYNTHETIC_REG_STIMER0_CONFIG
> >> 	(HV_REGISTER_STIMER0_CONFIG)
> >> +#define HV_SYNTHETIC_REG_STIMER0_COUNT
> >> 	(HV_REGISTER_STIMER0_COUNT)
> >> +
> >> +#define HV_SYNTHETIC_REG_SCONTROL		(HV_REGISTER_SCONTROL)
> >> +#define HV_SYNTHETIC_REG_SIEFP			(HV_REGISTER_SIEFP)
> >> +#define HV_SYNTHETIC_REG_SIMP			(HV_REGISTER_SIMP)
> >> +#define HV_SYNTHETIC_REG_EOM			(HV_REGISTER_EOM)
> >> +#define HV_SYNTHETIC_REG_SINT0			(HV_REGISTER_SINT0)
> >> +
> >> +#define HV_SYNTHETIC_REG_CRASH_P0		(HV_REGISTER_CRASH_P0)
> >> +#define HV_SYNTHETIC_REG_CRASH_P1		(HV_REGISTER_CRASH_P1)
> >> +#define HV_SYNTHETIC_REG_CRASH_P2		(HV_REGISTER_CRASH_P2)
> >> +#define HV_SYNTHETIC_REG_CRASH_P3		(HV_REGISTER_CRASH_P3)
> >> +#define HV_SYNTHETIC_REG_CRASH_P4		(HV_REGISTER_CRASH_P4)
> >> +#define HV_SYNTHETIC_REG_CRASH_CTL		(HV_REGISTER_CRASH_CTL)
> >> +
> >>  union hv_msi_entry {
> >>  	u64 as_uint64[2];
> >>  	struct {
> >> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> >> index 566ac26239ba..0dbb0218d0fa 100644
> >> --- a/arch/x86/include/asm/hyperv-tlfs.h
> >> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> >> @@ -178,7 +178,7 @@ enum hv_isolation_type {
> >>  #define HV_X64_MSR_HYPERCALL			0x40000001
> >>
> >>  /* MSR used to provide vcpu index */
> >> -#define HV_REGISTER_VP_INDEX			0x40000002
> >> +#define HV_X64_MSR_VP_INDEX			0x40000002
> >>
> >>  /* MSR used to reset the guest OS. */
> >>  #define HV_X64_MSR_RESET			0x40000003
> >> @@ -187,10 +187,10 @@ enum hv_isolation_type {
> >>  #define HV_X64_MSR_VP_RUNTIME			0x40000010
> >>
> >>  /* MSR used to read the per-partition time reference counter */
> >> -#define HV_REGISTER_TIME_REF_COUNT		0x40000020
> >> +#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
> >>
> >>  /* A partition's reference time stamp counter (TSC) page */
> >> -#define HV_REGISTER_REFERENCE_TSC		0x40000021
> >> +#define HV_X64_MSR_REFERENCE_TSC		0x40000021
> >>
> >>  /* MSR used to retrieve the TSC frequency */
> >>  #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
> >> @@ -205,61 +205,61 @@ enum hv_isolation_type {
> >>  #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
> >>
> >>  /* Define synthetic interrupt controller model specific registers. */
> >> -#define HV_REGISTER_SCONTROL			0x40000080
> >> -#define HV_REGISTER_SVERSION			0x40000081
> >> -#define HV_REGISTER_SIEFP			0x40000082
> >> -#define HV_REGISTER_SIMP			0x40000083
> >> -#define HV_REGISTER_EOM				0x40000084
> >> -#define HV_REGISTER_SINT0			0x40000090
> >> -#define HV_REGISTER_SINT1			0x40000091
> >> -#define HV_REGISTER_SINT2			0x40000092
> >> -#define HV_REGISTER_SINT3			0x40000093
> >> -#define HV_REGISTER_SINT4			0x40000094
> >> -#define HV_REGISTER_SINT5			0x40000095
> >> -#define HV_REGISTER_SINT6			0x40000096
> >> -#define HV_REGISTER_SINT7			0x40000097
> >> -#define HV_REGISTER_SINT8			0x40000098
> >> -#define HV_REGISTER_SINT9			0x40000099
> >> -#define HV_REGISTER_SINT10			0x4000009A
> >> -#define HV_REGISTER_SINT11			0x4000009B
> >> -#define HV_REGISTER_SINT12			0x4000009C
> >> -#define HV_REGISTER_SINT13			0x4000009D
> >> -#define HV_REGISTER_SINT14			0x4000009E
> >> -#define HV_REGISTER_SINT15			0x4000009F
> >> +#define HV_X64_MSR_SCONTROL			0x40000080
> >> +#define HV_X64_MSR_SVERSION			0x40000081
> >> +#define HV_X64_MSR_SIEFP			0x40000082
> >> +#define HV_X64_MSR_SIMP				0x40000083
> >> +#define HV_X64_MSR_EOM				0x40000084
> >> +#define HV_X64_MSR_SINT0			0x40000090
> >> +#define HV_X64_MSR_SINT1			0x40000091
> >> +#define HV_X64_MSR_SINT2			0x40000092
> >> +#define HV_X64_MSR_SINT3			0x40000093
> >> +#define HV_X64_MSR_SINT4			0x40000094
> >> +#define HV_X64_MSR_SINT5			0x40000095
> >> +#define HV_X64_MSR_SINT6			0x40000096
> >> +#define HV_X64_MSR_SINT7			0x40000097
> >> +#define HV_X64_MSR_SINT8			0x40000098
> >> +#define HV_X64_MSR_SINT9			0x40000099
> >> +#define HV_X64_MSR_SINT10			0x4000009A
> >> +#define HV_X64_MSR_SINT11			0x4000009B
> >> +#define HV_X64_MSR_SINT12			0x4000009C
> >> +#define HV_X64_MSR_SINT13			0x4000009D
> >> +#define HV_X64_MSR_SINT14			0x4000009E
> >> +#define HV_X64_MSR_SINT15			0x4000009F
> >>
> >>  /*
> >>   * Define synthetic interrupt controller model specific registers for
> >>   * nested hypervisor.
> >>   */
> >> -#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> >> -#define HV_REGISTER_NESTED_SVERSION            0x40001081
> >> -#define HV_REGISTER_NESTED_SIEFP               0x40001082
> >> -#define HV_REGISTER_NESTED_SIMP                0x40001083
> >> -#define HV_REGISTER_NESTED_EOM                 0x40001084
> >> -#define HV_REGISTER_NESTED_SINT0               0x40001090
> >> +#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
> >> +#define HV_X64_MSR_NESTED_SVERSION		0x40001081
> >> +#define HV_X64_MSR_NESTED_SIEFP			0x40001082
> >> +#define HV_X64_MSR_NESTED_SIMP			0x40001083
> >> +#define HV_X64_MSR_NESTED_EOM			0x40001084
> >> +#define HV_X64_MSR_NESTED_SINT0			0x40001090
> >>
> >>  /*
> >>   * Synthetic Timer MSRs. Four timers per vcpu.
> >>   */
> >> -#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
> >> -#define HV_REGISTER_STIMER0_COUNT		0x400000B1
> >> -#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
> >> -#define HV_REGISTER_STIMER1_COUNT		0x400000B3
> >> -#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
> >> -#define HV_REGISTER_STIMER2_COUNT		0x400000B5
> >> -#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
> >> -#define HV_REGISTER_STIMER3_COUNT		0x400000B7
> >> +#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
> >> +#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
> >> +#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
> >> +#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
> >> +#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
> >> +#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
> >> +#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
> >> +#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
> >>
> >>  /* Hyper-V guest idle MSR */
> >>  #define HV_X64_MSR_GUEST_IDLE			0x400000F0
> >>
> >>  /* Hyper-V guest crash notification MSR's */
> >> -#define HV_REGISTER_CRASH_P0			0x40000100
> >> -#define HV_REGISTER_CRASH_P1			0x40000101
> >> -#define HV_REGISTER_CRASH_P2			0x40000102
> >> -#define HV_REGISTER_CRASH_P3			0x40000103
> >> -#define HV_REGISTER_CRASH_P4			0x40000104
> >> -#define HV_REGISTER_CRASH_CTL			0x40000105
> >> +#define HV_X64_MSR_CRASH_P0			0x40000100
> >> +#define HV_X64_MSR_CRASH_P1			0x40000101
> >> +#define HV_X64_MSR_CRASH_P2			0x40000102
> >> +#define HV_X64_MSR_CRASH_P3			0x40000103
> >> +#define HV_X64_MSR_CRASH_P4			0x40000104
> >> +#define HV_X64_MSR_CRASH_CTL			0x40000105
> >>
> >>  /* TSC emulation after migration */
> >>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> >> @@ -269,31 +269,30 @@ enum hv_isolation_type {
> >>  /* TSC invariant control */
> >>  #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
> >>
> >> -/* Register name aliases for temporary compatibility */
> >> -#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
> >> -#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
> >> -#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
> >> -#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
> >> -#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
> >> -#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
> >> -#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
> >> -#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
> >> -#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
> >> -#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
> >> -#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
> >> -#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
> >> -#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
> >> -#define HV_X64_MSR_EOM			HV_REGISTER_EOM
> >> -#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
> >> -#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
> >> -#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
> >> -#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
> >> -#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
> >> -#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
> >> -#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
> >> -#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
> >> -#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
> >> -#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
> >> +/*
> >> + * To support non-arch-specific code calling hv_set/get_register:
> >> + * - On x86, HV_SYNTHETIC_REG_ indicates an MSR accessed via rdmsrl/wrmsrl
> >> + * - On ARM, HV_SYNTHETIC_REG_ indicates a VP register accessed via hypercall
> >
> > Same here:  "ARM64" instead of "ARM".
> >
> 
> Will do
> 
> >> + */
> >> +#define HV_SYNTHETIC_REG_VP_INDEX		(HV_X64_MSR_VP_INDEX)
> >> +#define HV_SYNTHETIC_REG_TIME_REF_COUNT
> >> 	(HV_X64_MSR_TIME_REF_COUNT)
> >> +#define HV_SYNTHETIC_REG_REFERENCE_TSC
> >> 	(HV_X64_MSR_REFERENCE_TSC)
> >> +
> >> +#define HV_SYNTHETIC_REG_STIMER0_CONFIG
> >> 	(HV_X64_MSR_STIMER0_CONFIG)
> >> +#define HV_SYNTHETIC_REG_STIMER0_COUNT
> >> 	(HV_X64_MSR_STIMER0_COUNT)
> >> +
> >> +#define HV_SYNTHETIC_REG_SCONTROL		(HV_X64_MSR_SCONTROL)
> >> +#define HV_SYNTHETIC_REG_SIEFP			(HV_X64_MSR_SIEFP)
> >> +#define HV_SYNTHETIC_REG_SIMP			(HV_X64_MSR_SIMP)
> >> +#define HV_SYNTHETIC_REG_EOM			(HV_X64_MSR_EOM)
> >> +#define HV_SYNTHETIC_REG_SINT0			(HV_X64_MSR_SINT0)
> >> +
> >> +#define HV_SYNTHETIC_REG_CRASH_P0		(HV_X64_MSR_CRASH_P0)
> >> +#define HV_SYNTHETIC_REG_CRASH_P1		(HV_X64_MSR_CRASH_P1)
> >> +#define HV_SYNTHETIC_REG_CRASH_P2		(HV_X64_MSR_CRASH_P2)
> >> +#define HV_SYNTHETIC_REG_CRASH_P3		(HV_X64_MSR_CRASH_P3)
> >> +#define HV_SYNTHETIC_REG_CRASH_P4		(HV_X64_MSR_CRASH_P4)
> >> +#define HV_SYNTHETIC_REG_CRASH_CTL		(HV_X64_MSR_CRASH_CTL)
> >>
> >>  /* Hyper-V memory host visibility */
> >>  enum hv_mem_host_visibility {
> >> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> >> index 4c4c0ec3b62e..1afa77ab9a04 100644
> >> --- a/arch/x86/include/asm/mshyperv.h
> >> +++ b/arch/x86/include/asm/mshyperv.h
> >> @@ -224,14 +224,14 @@ extern bool hv_isolation_type_snp(void);
> >>
> >>  static inline bool hv_is_synic_reg(unsigned int reg)
> >
> > Should this function name be changed to hv_is_synic_msr() since
> > it is based on MSR values and not register values?  Argument
> > name should probably also be "msr", not "reg" to avoid
> > any confusion.
> >
> 
> If we keep the generic prefix as HV_REGISTER, then I suppose it should remain
> hv_is_synic_reg.

Hmmm, I don't think so.  hv_is_synic_reg() is x86 specific code,
not architecture independent code.  And your naming change below
makes it clear that this code is operating on the MSR values, not
the register values.   As such, the code doesn't work on ARM64.
If we were to implement the equivalent of Confidential VMs on
ARM64, the ARM64 implementation of hv_get/set_register() would
need to call a different function to detect SYNIC regs (not MSRs) that
need special casing.  Same with the caller of hv_is_sint_reg() and
hv_get_nested_reg().  So I think renaming to hv_is_synic_msr()
still makes sense.  But maybe you have an alternate way of looking
at it .....

> 
> >>  {
> >> -	return (reg >= HV_REGISTER_SCONTROL) &&
> >> -	       (reg <= HV_REGISTER_SINT15);
> >> +	return (reg >= HV_X64_MSR_SCONTROL) &&
> >> +	       (reg <= HV_X64_MSR_SINT15);
> >>  }
> >>
> >>  static inline bool hv_is_sint_reg(unsigned int reg)
> >
> > Same here.
> >
> >>  {
> >> -	return (reg >= HV_REGISTER_SINT0) &&
> >> -	       (reg <= HV_REGISTER_SINT15);
> >> +	return (reg >= HV_X64_MSR_SINT0) &&
> >> +	       (reg <= HV_X64_MSR_SINT15);
> >>  }
> >>
> >>  u64 hv_get_register(unsigned int reg);
> >> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> >> index f924a76c6923..7140ee32d7be 100644
> >> --- a/arch/x86/kernel/cpu/mshyperv.c
> >> +++ b/arch/x86/kernel/cpu/mshyperv.c
> >> @@ -45,19 +45,19 @@ struct ms_hyperv_info ms_hyperv;
> >>  static inline unsigned int hv_get_nested_reg(unsigned int reg)
> >
> > Same here.
> >
> 
> If we keep the generic prefix as HV_REGISTER, then I suppose it should remain
> hv_get_nested_reg.

As above.

> 
> >>  {
> >>  	if (hv_is_sint_reg(reg))
> >> -		return reg - HV_REGISTER_SINT0 + HV_REGISTER_NESTED_SINT0;
> >> +		return reg - HV_X64_MSR_SINT0 + HV_X64_MSR_NESTED_SINT0;
> >>
> >>  	switch (reg) {
> >> -	case HV_REGISTER_SIMP:
> >> -		return HV_REGISTER_NESTED_SIMP;
> >> -	case HV_REGISTER_SIEFP:
> >> -		return HV_REGISTER_NESTED_SIEFP;
> >> -	case HV_REGISTER_SVERSION:
> >> -		return HV_REGISTER_NESTED_SVERSION;
> >> -	case HV_REGISTER_SCONTROL:
> >> -		return HV_REGISTER_NESTED_SCONTROL;
> >> -	case HV_REGISTER_EOM:
> >> -		return HV_REGISTER_NESTED_EOM;
> >> +	case HV_X64_MSR_SIMP:
> >> +		return HV_X64_MSR_NESTED_SIMP;
> >> +	case HV_X64_MSR_SIEFP:
> >> +		return HV_X64_MSR_NESTED_SIEFP;
> >> +	case HV_X64_MSR_SVERSION:
> >> +		return HV_X64_MSR_NESTED_SVERSION;
> >> +	case HV_X64_MSR_SCONTROL:
> >> +		return HV_X64_MSR_NESTED_SCONTROL;
> >> +	case HV_X64_MSR_EOM:
> >> +		return HV_X64_MSR_NESTED_EOM;
> >>  	default:
> >>  		return reg;
> >>  	}
> >> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> >> index c0cef92b12b8..0ab3fbca34c7 100644
> >> --- a/drivers/clocksource/hyperv_timer.c
> >> +++ b/drivers/clocksource/hyperv_timer.c
> >> @@ -81,14 +81,14 @@ static int hv_ce_set_next_event(unsigned long delta,
> >>
> >>  	current_tick = hv_read_reference_counter();
> >>  	current_tick += delta;
> >> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
> >> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_COUNT, current_tick);
> >>  	return 0;
> >>  }
> >>
> >>  static int hv_ce_shutdown(struct clock_event_device *evt)
> >>  {
> >> -	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
> >> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
> >> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_COUNT, 0);
> >> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_CONFIG, 0);
> >>  	if (direct_mode_enabled && stimer0_irq >= 0)
> >>  		disable_percpu_irq(stimer0_irq);
> >>
> >> @@ -119,7 +119,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
> >>  		timer_cfg.direct_mode = 0;
> >>  		timer_cfg.sintx = stimer0_message_sint;
> >>  	}
> >> -	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_STIMER0_CONFIG, timer_cfg.as_uint64);
> >>  	return 0;
> >>  }
> >>
> >> @@ -387,7 +387,7 @@ static u64 notrace read_hv_clock_tsc(void)
> >>  	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
> >>
> >>  	if (current_tick == U64_MAX)
> >> -		current_tick = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> >> +		current_tick = hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
> >>
> >>  	return current_tick;
> >>  }
> >> @@ -408,9 +408,9 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
> >>  	union hv_reference_tsc_msr tsc_msr;
> >>
> >>  	/* Disable the TSC page */
> >> -	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> >> +	tsc_msr.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
> >>  	tsc_msr.enable = 0;
> >> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
> >>  }
> >>
> >>
> >> @@ -419,10 +419,10 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
> >>  	union hv_reference_tsc_msr tsc_msr;
> >>
> >>  	/* Re-enable the TSC page */
> >> -	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> >> +	tsc_msr.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
> >>  	tsc_msr.enable = 1;
> >>  	tsc_msr.pfn = tsc_pfn;
> >> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
> >>  }
> >>
> >>  #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
> >> @@ -456,7 +456,7 @@ static u64 notrace read_hv_clock_msr(void)
> >>  	 * is set to 0 when the partition is created and is incremented in
> >>  	 * 100 nanosecond units.
> >>  	 */
> >> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> >> +	return hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
> >>  }
> >>
> >>  static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
> >> @@ -543,14 +543,14 @@ static bool __init hv_init_tsc_clocksource(void)
> >>  	 * thus TSC clocksource will work even without the real TSC page
> >>  	 * mapped.
> >>  	 */
> >> -	tsc_msr.as_uint64 = hv_get_register(HV_REGISTER_REFERENCE_TSC);
> >> +	tsc_msr.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_REFERENCE_TSC);
> >>  	if (hv_root_partition)
> >>  		tsc_pfn = tsc_msr.pfn;
> >>  	else
> >>  		tsc_pfn = HVPFN_DOWN(virt_to_phys(tsc_page));
> >>  	tsc_msr.enable = 1;
> >>  	tsc_msr.pfn = tsc_pfn;
> >> -	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_REFERENCE_TSC, tsc_msr.as_uint64);
> >>
> >>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> >>
> >> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> >> index 8b0dd8e5244d..319f21205a9c 100644
> >> --- a/drivers/hv/hv.c
> >> +++ b/drivers/hv/hv.c
> >> @@ -213,7 +213,7 @@ void hv_synic_enable_regs(unsigned int cpu)
> >>  	union hv_synic_scontrol sctrl;
> >>
> >>  	/* Setup the Synic's message page */
> >> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
> >> +	simp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIMP);
> >>  	simp.simp_enabled = 1;
> >>
> >>  	if (hv_isolation_type_snp() || hv_root_partition) {
> >> @@ -227,10 +227,10 @@ void hv_synic_enable_regs(unsigned int cpu)
> >>  			>> HV_HYP_PAGE_SHIFT;
> >>  	}
> >>
> >> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_SIMP, simp.as_uint64);
> >>
> >>  	/* Setup the Synic's event page */
> >> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
> >> +	siefp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIEFP);
> >>  	siefp.siefp_enabled = 1;
> >>
> >>  	if (hv_isolation_type_snp() || hv_root_partition) {
> >> @@ -245,12 +245,12 @@ void hv_synic_enable_regs(unsigned int cpu)
> >>  			>> HV_HYP_PAGE_SHIFT;
> >>  	}
> >>
> >> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_SIEFP, siefp.as_uint64);
> >>
> >>  	/* Setup the shared SINT. */
> >>  	if (vmbus_irq != -1)
> >>  		enable_percpu_irq(vmbus_irq, 0);
> >> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
> >> +	shared_sint.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SINT0 +
> >>  					VMBUS_MESSAGE_SINT);
> >>
> >>  	shared_sint.vector = vmbus_interrupt;
> >> @@ -266,14 +266,14 @@ void hv_synic_enable_regs(unsigned int cpu)
> >>  #else
> >>  	shared_sint.auto_eoi = 0;
> >>  #endif
> >> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> >> +	hv_set_register(HV_SYNTHETIC_REG_SINT0 + VMBUS_MESSAGE_SINT,
> >>  				shared_sint.as_uint64);
> >>
> >>  	/* Enable the global synic bit */
> >> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
> >> +	sctrl.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SCONTROL);
> >>  	sctrl.enable = 1;
> >>
> >> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_SCONTROL, sctrl.as_uint64);
> >>  }
> >>
> >>  int hv_synic_init(unsigned int cpu)
> >> @@ -297,17 +297,17 @@ void hv_synic_disable_regs(unsigned int cpu)
> >>  	union hv_synic_siefp siefp;
> >>  	union hv_synic_scontrol sctrl;
> >>
> >> -	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
> >> +	shared_sint.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SINT0 +
> >>  					VMBUS_MESSAGE_SINT);
> >>
> >>  	shared_sint.masked = 1;
> >>
> >>  	/* Need to correctly cleanup in the case of SMP!!! */
> >>  	/* Disable the interrupt */
> >> -	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
> >> +	hv_set_register(HV_SYNTHETIC_REG_SINT0 + VMBUS_MESSAGE_SINT,
> >>  				shared_sint.as_uint64);
> >>
> >> -	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
> >> +	simp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIMP);
> >>  	/*
> >>  	 * In Isolation VM, sim and sief pages are allocated by
> >>  	 * paravisor. These pages also will be used by kdump
> >> @@ -322,9 +322,9 @@ void hv_synic_disable_regs(unsigned int cpu)
> >>  		simp.base_simp_gpa = 0;
> >>  	}
> >>
> >> -	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_SIMP, simp.as_uint64);
> >>
> >> -	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
> >> +	siefp.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SIEFP);
> >>  	siefp.siefp_enabled = 0;
> >>
> >>  	if (hv_isolation_type_snp() || hv_root_partition) {
> >> @@ -334,12 +334,12 @@ void hv_synic_disable_regs(unsigned int cpu)
> >>  		siefp.base_siefp_gpa = 0;
> >>  	}
> >>
> >> -	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_SIEFP, siefp.as_uint64);
> >>
> >>  	/* Disable the global synic bit */
> >> -	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
> >> +	sctrl.as_uint64 = hv_get_register(HV_SYNTHETIC_REG_SCONTROL);
> >>  	sctrl.enable = 0;
> >> -	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
> >> +	hv_set_register(HV_SYNTHETIC_REG_SCONTROL, sctrl.as_uint64);
> >>
> >>  	if (vmbus_irq != -1)
> >>  		disable_percpu_irq(vmbus_irq);
> >> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> >> index 52a6f89ccdbd..77a68f16bc6e 100644
> >> --- a/drivers/hv/hv_common.c
> >> +++ b/drivers/hv/hv_common.c
> >> @@ -142,7 +142,7 @@ int hv_common_cpu_init(unsigned int cpu)
> >>  		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> >>  	}
> >>
> >> -	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
> >> +	msr_vp_index = hv_get_register(HV_SYNTHETIC_REG_VP_INDEX);
> >>
> >>  	hv_vp_index[cpu] = msr_vp_index;
> >>
> >> @@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> >>   */
> >>  static u64 __hv_read_ref_counter(void)
> >>  {
> >> -	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
> >> +	return hv_get_register(HV_SYNTHETIC_REG_TIME_REF_COUNT);
> >>  }
> >>
> >>  u64 (*hv_read_reference_counter)(void) = __hv_read_ref_counter;
> >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> >> index 1901556efe79..9ca8a7b73b81 100644
> >> --- a/drivers/hv/vmbus_drv.c
> >> +++ b/drivers/hv/vmbus_drv.c
> >> @@ -1405,17 +1405,17 @@ static void hv_kmsg_dump(struct kmsg_dumper
> >> *dumper,
> >>  	 * contain the size of the panic data in that page. Rest of the
> >>  	 * registers are no-op when the NOTIFY_MSG flag is set.
> >>  	 */
> >> -	hv_set_register(HV_REGISTER_CRASH_P0, 0);
> >> -	hv_set_register(HV_REGISTER_CRASH_P1, 0);
> >> -	hv_set_register(HV_REGISTER_CRASH_P2, 0);
> >> -	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
> >> -	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
> >> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P0, 0);
> >> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P1, 0);
> >> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P2, 0);
> >> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P3,
> >> virt_to_phys(hv_panic_page));
> >> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_P4, bytes_written);
> >>
> >>  	/*
> >>  	 * Let Hyper-V know there is crash data available along with
> >>  	 * the panic message.
> >>  	 */
> >> -	hv_set_register(HV_REGISTER_CRASH_CTL,
> >> +	hv_set_register(HV_SYNTHETIC_REG_CRASH_CTL,
> >>  	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
> >>  }
> >>
> >> @@ -1555,7 +1555,7 @@ static int vmbus_bus_init(void)
> >>  		 * Register for panic kmsg callback only if the right
> >>  		 * capability is supported by the hypervisor.
> >>  		 */
> >> -		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
> >> +		hyperv_crash_ctl = hv_get_register(HV_SYNTHETIC_REG_CRASH_CTL);
> >>  		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
> >>  			hv_kmsg_dump_register();
> >>
> >> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> >> index 8845a2eca339..76bf968d77a8 100644
> >> --- a/include/asm-generic/mshyperv.h
> >> +++ b/include/asm-generic/mshyperv.h
> >> @@ -147,7 +147,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg,
> >> u32 old_msg_type)
> >>  		 * possibly deliver another msg from the
> >>  		 * hypervisor
> >>  		 */
> >> -		hv_set_register(HV_REGISTER_EOM, 0);
> >> +		hv_set_register(HV_SYNTHETIC_REG_EOM, 0);
> >>  	}
> >>  }
> >>
> >> --
> >> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

