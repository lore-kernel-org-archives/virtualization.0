Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C3C74A5B
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 13:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C20617AC;
	Fri, 17 Mar 2023 13:43:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72C20617AC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=iayRnwKn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKZsn_01123m; Fri, 17 Mar 2023 13:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1DBE617A3;
	Fri, 17 Mar 2023 13:43:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1DBE617A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6B0CC0071;
	Fri, 17 Mar 2023 13:43:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E558EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 13:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E2C8401FA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 13:43:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E2C8401FA
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=microsoft.com header.i=@microsoft.com
 header.a=rsa-sha256 header.s=selector2 header.b=iayRnwKn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNvJyFSSq6Vc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 13:43:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DF88401DE
Received: from BN3PR00CU001.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DF88401DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 13:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXDQe55fMztjgtTLWX38oSz2zDoWizE0s4ShVJoq7gwjhTHOOSBQhEekSv2dZdBKhR1r6RWQ7jVppa7xdpYtNDssHTKFcvaZIo22bE/FRMnLS+Ud2nhug3NL+EDKP3FccvhOMbPeKz8gKSbH1PK82SQJBxrATegLb0DaTy9lxH3kdMEZwdGwIKpFSPWCW8DfcMLkiYPA++o7vefBOVQaSrkzHqsoCZt2wRyolS/D0/Xb9fW8PfbYQHt5B8oUhFZkoywgqKgTjXK8XT1G3hUTRE8uVM1lJbeHYhFcdH735QtE/hpGNPn8Tb+w6p8QeBDQPmVUTnVy/QebNsV+1tYoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t/DUGZtKBqdPVnMN2laKxAatKUr887wBLAjY0ao7tM=;
 b=Z+liVLK54W3XF0CUzmEvFf5A3JU5fif16OtXdYRhMXn8nzCGXVr87ArqNgR/1En7YqZvWI8MOXJ9a1jGl3U/3RcTAP2MtDUnWxbZI6rmu73EKX4hyMcWUrVv52ASMNvxKbL3kptqmwXJliIdvOhAVk1LdO3qfTtbyTYpF/XBUboPtuzmTgtm59NVDafP5uqHMoznMA5Zk5WwZYbe/P2PcZ9HD8Lp0nZbZmxSWmz1xZsXCWjZER39vUqxw62MYH93tnIgCzk/B8kzfVQkD4L7fMiAH9MakE8S9RWA+CbwitdZCFQNq1PC2GusOWOAEgMHtqgeQAh8t/265H+ZQJ9ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t/DUGZtKBqdPVnMN2laKxAatKUr887wBLAjY0ao7tM=;
 b=iayRnwKnG6YVuYYLbuEXi3ROfH0lNk394Z0e11NUeZaKaLV2vipxn1Ka4/WYpC+1zM/kuBZkq+SW9bLAeQEKLv9S4ftJSchXoBd0Erp3Z+V2nMbt5eVbz3cautqZKQoyH/7xNKx9cqVz+FQHcFZgSLVZ60tHxswUvxF/PKDn/2Q=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3922.namprd21.prod.outlook.com (2603:10b6:510:24c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 13:43:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%6]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 13:43:09 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Topic: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Index: AQHZUTma1YX9/OQzMkiQz3mMWYqOma70Wb1QgATkhYCAAEg44IAC+ROAgAKKJhA=
Date: Fri, 17 Mar 2023 13:43:09 +0000
Message-ID: <BYAPR21MB16888B1E88318BCCD5685E89D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1678223570-25242-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BYAPR21MB16889A9D76888A485D7BB19FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <e777ad2e-0bad-3a04-b831-ebd07edb7fc3@linux.microsoft.com>
 <BYAPR21MB1688FBD79441A4D75BBDAB24D7BE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <726a61de-61e6-18c7-e1f2-6dd8a7630d38@linux.microsoft.com>
In-Reply-To: <726a61de-61e6-18c7-e1f2-6dd8a7630d38@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb27fca8-39ef-405d-9682-f7e7b9126278;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-17T13:40:45Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3922:EE_
x-ms-office365-filtering-correlation-id: b67468d2-f84f-4f7d-d34a-08db26ed8b99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAfgAor30bxMa7MTZ/azRSDcuJ7vHYn+yPA829yR0zuDq94SIIbVt/MyXyvKo6XtmLHdThWVFkI0eFC0Ybcsj3yXB/TJIRAQO8neIi9A1DUbQQtRRos6pDbFpoCP66ZNH/B94oC/42xn5O14Q/eI99B1pChmPUL6ZexmOFG3d6YutVx7qqpAyn9vlnU2XVaan4Tm35Q62pY3cn6aMfsoFXiWpSOHe0PxRnnWeoA6Viko5CLEN/57MMHIgJ4z124Ste91Q2KwKgsVtkK9u2jZhIGtrcKTyUJLpBvk9dyoRtOTvvc0IdqCxlcG/BQDGNlwPIJyqUhjFLcaTet5yWTJdiOPWL3YqFPqklO+4hVb4nhtk59Wi67ZCyyDCbIzU2m430KpdrNiXxkhyzo6MINgsOQ7/o2/9ZdI8HaVouWuKCUmUJ/cgj9sPCHutHNT+HEMbnUuDkxkl0C/QCyGsrNRABAO7Dkc2Vgr4xm2mWYPH53ks04YZUdBL1faetA3sduDCJv4WvChQBhZBclb/cjxAuOWzVQfaZm5qpPraZ/Vla8YTSAf/RL70d38yJghNdFU/NGwXk5swmEYFGcGqvOuu8qf9GilDjdvg2ROAKQVY2n/AOW13fevPLL97neIVoOlShAIUj5cjEpaUHwEDrrOYb3GRoNowb+vNKIkWlV/cmaIK9dZvGKFqEs2B2hGjCs+Gbr8a2zybob954Na2/CSQoo0CYEgaaEw+84yeetdO5BHwuDloQRUgPGF4pczDJMw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR21MB1688.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(4326008)(41300700001)(66476007)(8676002)(64756008)(66556008)(66446008)(76116006)(66946007)(83380400001)(5660300002)(8936002)(26005)(52536014)(6506007)(186003)(9686003)(54906003)(110136005)(316002)(71200400001)(478600001)(7696005)(10290500003)(2906002)(38070700005)(53546011)(33656002)(55016003)(82950400001)(8990500004)(82960400001)(38100700002)(122000001)(66899018)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRCK3UwMWVOV0EzaFFySWlsOE5MNTJVMk5idlpud1NpeVlqR0s3U1pPeWhv?=
 =?utf-8?B?MUFodThvYVpsUld2bWZyLzg1dHorUzBGL2t2Qy9rMmtrUzliaVBtN0xCeGEx?=
 =?utf-8?B?dkYwNEJTTFdmUmVRZGdXSFpZZFoxYzFCWW1nUWVBNUVJckhKQkJsY2IvQ0U1?=
 =?utf-8?B?ZXZ4dVBBZHJtV094dTI4OUNLYnJCWXpTMjlvYStvQkNaTlhHaDJEZWVHbUM5?=
 =?utf-8?B?QWJHbXdYOVhXZ1JZdXFoUHFGZTRVdVVtVG5mV1pOVElPci9MZDEvZ3drcENG?=
 =?utf-8?B?dE0rTnZkMTdsZzNSS3BHU0RNcjc1RTBrMlVMR0Y0dDkvaW95cEF0cXFTK0x0?=
 =?utf-8?B?N0lmNjBWZ0RDc1AzNzNJMmxzNytJRGhqK2lXeUJ3dXRxMGVVVzlYSVlMT2Vi?=
 =?utf-8?B?N3V5a0JCTzA4UmRnRi9ScVFqNkRQMWJBbFZCVC9ZbnFGWmtpYXpaeCtraFRQ?=
 =?utf-8?B?b091U1FyTkdQdm8weHRZc0Nyb0hoZDAzZTdiUHJoRmZhcDZrUlJORmJpV1pv?=
 =?utf-8?B?Rm02WW9GbXNtUW9oenpZeDkzbnpaL1Z2Z25uU1JTQ3RpRzRnTmxnL2xyT3Js?=
 =?utf-8?B?Y2k2T0RySUM4azJ6Q3E3akJsUG54SkNWaXNWUUk0Z1FjNENnbkc2ZVZWTk9P?=
 =?utf-8?B?RmNDSlZzOXdEdFhKY3RqTE0xam1pbGhjaDdNNFBBWkZGZStQc3p0dVI2WjVs?=
 =?utf-8?B?YXJ3NDhpdXE1ZGF0ekNsc3dkVVlXRVRuZitXLy8vbDRYRDRjOUI2K2ZIZGc2?=
 =?utf-8?B?WDNDOHY1MHJkQ1FPRHNRUnE3Rjh5R1JXRU5XbWxvS0N4L1pERjdCMSthS05Y?=
 =?utf-8?B?Y0lJVWFEbmxsM3FodDNHakJzc2VpdC83S2owN2x5cGNDTHpLVE50bTRlZXhK?=
 =?utf-8?B?UDh4TlFueitlK3R1N0pwWGJqTllkZVRFaUZSdlhMQkc3c1Z2SnVZaW93eEk1?=
 =?utf-8?B?Tmo3aW0zdExEaG45UllEay9vK1ZVWHZNM1NWa01DVi9iWEFGKy9IazhhVlQ1?=
 =?utf-8?B?THJIVlNVNzJFb2FuUWI1dzYxOTNSbnhqMHhXZlE1cmtObWhidzRTdURobHcw?=
 =?utf-8?B?MlZsTUdEK3lxd0pyeWNMRzE1c28weXRURzF0RW1Wdnh5K1BqRERiUEVTNmJm?=
 =?utf-8?B?RDM2M05vWVdBMUFydnlPa08zOHRlM0daUWxjdGJXTTBrYjRsS3QzelNZdjNM?=
 =?utf-8?B?VXI0Y2lzaVIxUStacGxpRUpyS0tZZWc5OXR3d0RwZHVrVTl4aG1VS0tRMXpy?=
 =?utf-8?B?VEpMVVVPVnNqaTlhNURYclg2M3plblZ4VnJ6dFRMcEo0QkZDZm1EbllHMEZh?=
 =?utf-8?B?ZVJTcEVnSS8zUlAzS0xMd3hjTm85RXVINHVSSzF2Y0RXbGlwSkFndW40bFZp?=
 =?utf-8?B?OEsyeG54eUVpMjJUTXJzMnJjQmYrY2F1Q2JRSU9zQWV2Q2NFaXdUbVFTVzdk?=
 =?utf-8?B?MUZPdlhFa2hqVDJwMjRKV0tQTm1PVnlKM3c0N21VSEJ4L1N0VXhmbWREdzVl?=
 =?utf-8?B?R2hrN2hadHZDb2ttaWs4MXUyYzN5VzhxM1U3L3F3bDJVc3NOenN5WHBvS3RE?=
 =?utf-8?B?bWt4aXRrZkl3b2hBczlaK3JySjRtVXhBQjJsSVFRMHZJVkRURG0zYUgyVFNF?=
 =?utf-8?B?ZUNNS29MaHNkcDRQL0syeEtsT2ZtTjVEdFFMbHZ1anRvS2szTUtiQjJSZ0J0?=
 =?utf-8?B?K25ERzBCNlZtQWVlcmh1RnZIK1MzYmZJeVlJNmRlWmQ0eEk0UkNnblB3QjQ0?=
 =?utf-8?B?VzFkVjUxTzZ5L1RLNGpvcVFHdkZrcnkyWFRzZXVRcnd2R1BtMW42aE5xTEdD?=
 =?utf-8?B?eDNlcU11U2RqbXpFYld5ZmZJNm1DNDhFb2E2bVhtdmZ2VHZ4dXk0aHh6RHlZ?=
 =?utf-8?B?T2MzcWNTQ25WcHRXbWFTYnpOVCswNEhrNzNzTXJPaEpZNDJ5QUJ4TTREN0hs?=
 =?utf-8?B?aFhwSW5pcEduaTVtY1FuVHlEZXRiRXdlR2JOR3FodEhlUFA3aTllRTBGV2tQ?=
 =?utf-8?B?akxabFprK0lyMXp5d2hwdHR0bUFtWEpoUmhWSWFBcjFnQkswc3NPRGVIZDB6?=
 =?utf-8?B?ZmdVQVJhc3M3M1JqK2szNVErM1R4MXFNZGFhSDBzVDFrYWVGOFNSZ09LYjND?=
 =?utf-8?B?Wlc3Vk5Sd0hPTmFNcU9MZVZ5UTMxcEhYTHRLa0I2bnNQMDNTcWFybi8weGF1?=
 =?utf-8?B?UHc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67468d2-f84f-4f7d-d34a-08db26ed8b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 13:43:09.4155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bgb8OYk1Mitx0S0xhjIsQ1NyyCuytZRreSYn3sCBRdg8TW0ZVTt/ovbB0e9t0Z9Y5k0d6Sr8VV9A4M+XXkVChYSiFn4kek2f6DU8YGzTwLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3922
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

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, March 15, 2023 3:54 PM
> 
> On 3/13/2023 6:56 PM, Michael Kelley (LINUX) wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, March
> 13, 2023 2:11 PM
> >>
> >> On 3/10/2023 11:30 AM, Michael Kelley (LINUX) wrote:
> >>> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, March 7,
> >> 2023 1:13 PM
> >>>>
> >>>> In x86 hyperv-tlfs, HV_REGISTER_ prefix is used to indicate MSRs
> >>>> accessed via rdmsrl/wrmsrl. But in ARM64, HV_REGISTER_ instead indicates
> >>>> VP registers accessed via get/set vp registers hypercall.
> >>>>
> >>>> This is due to HV_REGISTER_* names being used by hv_set/get_register,
> >>>> with the arch-specific version delegating to the appropriate mechanism.
> >>>>
> >>>> The problem is, using prefix HV_REGISTER_ for MSRs will conflict with
> >>>> VP registers when they are introduced for x86 in future.
> >>>>
> >>>> This patch solves the issue by:
> >>>>
> >>>> 1. Defining all the x86 MSRs with a consistent prefix: HV_X64_MSR_.
> >>>>    This is so HV_REGISTER_ can be reserved for VP registers.
> >>>>
> >>>> 2. Change the non-arch-specific alias used by hv_set/get_register to
> >>>>    HV_SYNTHETIC_REG.
> >>>
> >>> I definitely messed this up when I first did the ARM64 support a
> >>> few years back.  :-(    This is a necessary fix.
> >>>
> >>> What about keeping HV_REGISTER_ as the prefix for the architecture
> >>> independent alias, and creating a new prefix for the Hyper-V register
> >>> definition?  This would allow the existing hv_get/set_register()
> >>> invocations to remain unchanged, and eliminates the code churn
> >>> in the arch independent code.
> >>>> The HV_X64_MSR_ prefix is definitely good for the MSR addresses,
> >>> especially since a lot of definitions that are x86/x64 only are still in use.
> >>> Then perhaps use HV_HYP_REG_ or something similar for the Hyper-V
> >>> register definition.
> >>
> >> This could work.
> >>
> >> Ideally, we would use HV_REGISTER_ for the vp registers as it's a direct match
> >> to the name in HyperV e.g. HvRegisterVpIndex-> HV_REGISTER_VP_INDEX
> >
> > You make a good point.
> >
> >>
> >> However if you think it's better to reduce churn and go with a different
> >> name then that's fine by me.
> >
> > I was specifically thinking about 3 large-ish patch sets for Confidential VMs
> > that we have pending.  The Confidential VM patches have various changes
> > to the synic code in hv.c so it overlaps with your changes to the register
> > naming.  The Confidential VM patches need to be backported to earlier
> > Linux kernel versions, and I was trying to avoid unrelated churn to ease
> > the backport process.   How urgent is fixing this register naming problem?
> > If it could go after the Confidential VM patches, then there's less churn for
> > the backports.
> >
> 
> It is not urgent, but I wanted feedback on the approach because this needs to be
> fixed in some way for the /dev/mshv driver which adds all the vp register names,
> and I was hoping to use HV_REGISTER_ for those.
> 
> > But in the grand scheme of things, we can deal with the churn.  It's just
> > some manual work that isn't hard.  Net, I'm OK with either approach.
> >
> 
> In that case, I'd prefer to go with my original intention of changing the
> meaning of HV_REGISTER_ to be the vp registers, and adding the generic
> HV_SYNTHETIC_REG (or a shorter name as below).

Fair enough.

> 
> But, merging this change can indeed wait - I can include it in the /dev/mshv
> patch series. Since that will take some time to review/iterate on, it's likely
> this change wouldn't actually be merged for some time.
> 
> >>
> >> HV_HYP_REG_ is ok, though maybe HV_VP_REG_ is a bit more informative?
> >> "VP_REG" indicating it's relevant to HVCALL_GET/SET_VP_REGISTERS.
> >
> > Yes, HV_VP_REG_ is good as the register prefix if you decide to keep
> > HV_REGISTER_ as the architecture independent prefix.
> >
> >>
> >>>
> >>> If you don't like that suggestion, I wonder if the HV_SYNTHETIC_REG_
> >>> prefix could be shortened to help avoid line length problems.  Maybe
> >>> HV_SYNREG_ or HV_SYN_REG_ ?
> 
> 
> This is a good idea. I'm fine with either, will go with HV_SYN_REG_ if you
> don't have a preference.

OK

> Do you think it is necessary or worthwhile to also rename hv_get/set_register
> to hv_get/set_syn_reg?

I don't have a strong preference either way.   Your choice.

Michael
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
