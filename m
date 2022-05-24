Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFAEC433F5
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 01:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03AF44016C;
	Tue, 24 May 2022 01:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6h3xubDPIemS; Tue, 24 May 2022 01:07:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94B4140BE6;
	Tue, 24 May 2022 01:07:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 649A8C0039;
	Tue, 24 May 2022 01:07:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA47C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 01:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 341D440BE6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 01:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6wYkwi2gm4u
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 01:07:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::619])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE3C64016C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 01:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAEi9fN/6FE9spT2CEVxHlIJwikZvO/wHG0EUxeub14yvHYEpVoG+NBF31PmYg6WkhajiH9jRs+a2wPOeKquoy9DDHu6LKjQG1VQ34CtIuyJikwmvyW1iRXA4VRo+eV391DQqf4CZME/nJVqQuaRffGpUVqWWGjifK8/6JuRZwDpZptsktN6M+RuZSE5ajAP0KT1MzFIbehYVoNHeFKYFC+PnqCo91YJ2GYgs99KBlA6KJah8Z+nYygKBmY5udFk2TR2dGsih+X6Ibw8A+RDd3UGUk7CyjGAOsD4KUsPOQnLr3xjpnCvB5/Qpm9Ld9NG/KPv26mQlQYPM9+HEOPnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARMBtD64waJNylicBFKFKKfgu1lDWPzJUswj7wADqKs=;
 b=A/fHGcn6rbYFtcViCLpwgyq6Hweb7nqKSSI9MddNLN4J5nR1URIGPAj+BiRAgfc7st+wifBRPEAvoXph54tJfQVogvEENirhYu9J9cOZTHD7Il1cucTzSK0EXKQOwJZaA2ROkN9hPSRdVPdqYdK2i767+kODjSTEj4OL5mlpKaN3hqFYcRDnZvKGjrK2acVyddQHAB6wV2amCoXsvuZamyBwWXQdiEnUnIEY8qtN70HzqiKMYJ+miKaafVsyEULmCHlrfSTivd6ODQQRfdHxQSY534VBOrki82/NZ0br/Xf32i7ojTshTszxPjHZ6nracExPlPx+wXeXBHxS/34dRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARMBtD64waJNylicBFKFKKfgu1lDWPzJUswj7wADqKs=;
 b=esSSvcNeBBpvAudI6G7N29vxiOcvZc4Vq7flcfrpaXJliPa57LbpH1i4nZDoJ/3x/x8whSZBHjBU0OyZ42xCjrIJWSvp25mZqLY0Pq5wPO9RqVxdyOazgxguaHAj/G8VrIXKhts7p4yeNJt9AggG1Pr0awsliTaqbKDCtDOiDBASgWMLfql6VWISxiKXvXf0fEX/F8mkHM6b2cjegS6jJsjVIn+1itPEo0uBI+mR/xTYlxptj9aYkuYjdchsuRWiUANiGT8s8E09KD6Fveb8ajzlChBOWgxn82C/lJUcNEBa3dmbnLvmMQCrqBb/UCOm4vQs7ucBmZADuvSDe4HC6Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM5PR1201MB0153.namprd12.prod.outlook.com (2603:10b6:4:57::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 01:07:30 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 01:07:30 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Topic: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Thread-Index: AQHYaOqkgz3W9mP+EUqOpcefr9+WPa0h7mWwgAC+VgCAAEk50IAAI2SAgABj/vCAANQvAIAHXd1ggAAsrICAAWTs8A==
Date: Tue, 24 May 2022 01:07:29 +0000
Message-ID: <PH0PR12MB54811072034C9FC99945DF50DCD79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <PH0PR12MB54813F96E346D591FBE238C1DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACycT3sRc4bk+3oq7FLzpBMCG_XRN7tOaeEAtNg69o3h8c3=EA@mail.gmail.com>
 <PH0PR12MB5481AD3C1517331EAC4EE078DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <YoOpBaWcaoujWqO7@kroah.com>
 <PH0PR12MB54819F4E48BE36460BC89457DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <28a689dc-a9de-ca1f-6b9f-26c735e96781@redhat.com>
 <PH0PR12MB54817B6BE5796E237A50FB2FDCD49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvrekJFMFLpgUHZ7HOTed7oRSt4Mv2ASUHLNC3ZCs-NEA@mail.gmail.com>
In-Reply-To: <CACGkMEvrekJFMFLpgUHZ7HOTed7oRSt4Mv2ASUHLNC3ZCs-NEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aabee70f-a902-4349-9dd1-08da3d21c685
x-ms-traffictypediagnostic: DM5PR1201MB0153:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB0153716BFA98FB52CA271DA3DCD79@DM5PR1201MB0153.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zum9WpsMYcnhbeVaEz0T0ueBnnORBNOIubK8t+Nv0RxtMCTIdWSSNn+KzUeqvTcBafkeQ1p5AUUElskYd9SO5NrPcwoAnZg4K8R0N0Eb/DuX0dqLkoYCTEROSdTqkhccUHagK8nP3O/vOHqS0qjobAIxFt4PNGTh1/EetvUJbDmKwitO92xRxiHFBUmzaV8izr6Nb12jwAlO1nQVghUzdW4ppRZptKZETfn6GdU8yqcZwkVL/RbcMe+6B/h/BkQNxEdqCQ7DeV3ui+MWqyWannPwveM+5ibYNWt0l0IaRCeT95cf67a+yRZM+tI419NrxJOQ1HmcwIhnq278Xu+ydzs+nXGAfYcMoSMA/aSaDw68yDIIxJOLSJ8DbunL81zrCfN8BUbaU65TyF2aBoCB3d9nsC4mg8bq+S7ArA+yZxZKIHSBg9n+PUiNo/Xz0oZ+WtMJJYZ6zzKLu8ozXrfkEpWO6A2ZHL88klXPCJYViLZkngDomxTL9Cd3EWUT8/misO581Q+X3zeReTmqjCHV7MWYXZRuRHqtiEOUSLgh43gdAeXWDWS/0HS79PQHHNfGH8QHLXcfGCNonshTR2s97vCSViQ50+1P1pUCCVju32XrbaBeyaffkBCkYhuvTCkl9BIhIQcpPXlaOyDDjGeLFjoN+/FT857U0qcHF1s6sMxszDd5MVLTTElQM19Fk284twjl+CiS40Gz5h0zyRwgy2Ocy5XwcpBicPnPeO4BiepfQk0uyqtePtF2dVMrLtuNuq/yBzDHtBTjIwgezaIzKOn+0NH0be7K//8Uz9PMy2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(316002)(122000001)(54906003)(6916009)(38070700005)(4326008)(8676002)(66446008)(64756008)(186003)(76116006)(66946007)(66556008)(66476007)(86362001)(508600001)(55016003)(71200400001)(9686003)(53546011)(33656002)(8936002)(7696005)(6506007)(52536014)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2gxNE5hZUVsSU5KSTlaNWdBZmhhM1dhSWUyc0dsVUhXTFNpelZGcEJKLzVC?=
 =?utf-8?B?cTB4dDNnRzNSckF1T1ZIaTJHRUJRc2dDejBmRFRscVVFbTBueFNWQkJ6NDV5?=
 =?utf-8?B?Z1B3MlBhZUc1Um9kanI5VmxXRTFzTmhZK0kwQVZFWDFUZ1hnZEYvbVYwZzNE?=
 =?utf-8?B?amtTSE03dUk4TGJjV01FVGwycEo3V05MOTNRcVBvVEt1aHkxbWF0TGhlMTAx?=
 =?utf-8?B?S1Q1ak1RVGQ1M1dHVTY3TENmb0VXcDMvWUZjY1ROYXVsdjBHVmkvNCtrVER1?=
 =?utf-8?B?bjFtUW9VcDI3ZkZnVnR2bXRHRmVLZVh0cHhxS1dCZXNXN2RmWi9mY2J4OVFM?=
 =?utf-8?B?bUJFTytQcEFLNjU5MWlDS01XblhsZlFTOGVkNmhqQURGUVpsR1l4S2ZreWl3?=
 =?utf-8?B?Q3BoSkVhT1BLSHREN0lzOHhDUjRVZEEvTkRpTThxMHZxSUJzcEgxdy9kTEtP?=
 =?utf-8?B?SEptVjNWbUxmeGxKd0dzVW1rcmFIMWg1T0pPajBYRGgxR3loSjN0eEROd1hF?=
 =?utf-8?B?cThNOXo5TnpjS1o3MUt2K3premtXMVpjbGV0SUNrSFAvTi9jWm16UUdVNTV5?=
 =?utf-8?B?bmFQVzdoMFlpMk5uUlFQNUFVZ1hxZ3I2Mmo3TFlZTVhma1ZUVUQ2ckVzK09o?=
 =?utf-8?B?azR2S2RxdXpiSnZjT3FEblk0RHRlb204aXV6Rk51R3dTSmVMWmRBc2lqYzlt?=
 =?utf-8?B?b2hncWV0SmF4OXZhRnhReXprYjJsTGh5SFlVaWpKVjBzU1ZQVzNmZmwxL2tJ?=
 =?utf-8?B?bU84LzVHdG4za3VmRHpoTTN1dVhyYm9qeEMzUUZtQnNxQTg3ZFN2bFovZ1RL?=
 =?utf-8?B?eTFJRFdQUlU5SS81UnB5R2tEQTJLZEVSWXQreEhTcmlaK2tyTzUzNFkyaEJ5?=
 =?utf-8?B?bW9xZVV4OTN6NHRXc3drU1IvKzQrMXFGQ1pNODdVZ2todE5Ic1k3WmMyYXkv?=
 =?utf-8?B?SkFaSlZpMTliNG51YmtCQ05RL0s4b2s3Nk94WFhjbUtMajFJdi84bzJQZUkx?=
 =?utf-8?B?UW1IRGpORTJ6bStzb3lGNm90NXVBSVFzSGsyOURCNzJxdnRGUkF1bXBMUVVo?=
 =?utf-8?B?Wklqa0NMMWY0YUJ6YlZ3aW9yeVpYSjVIOWdzNDhaS1M3TldiT2lnUURpWjNn?=
 =?utf-8?B?Q2lWRTFIbkJvRWpkZ3JDTitJV1BYYkE0MmIvMkt1VHAyV1BiWWxkZDJQT2ph?=
 =?utf-8?B?NXpWYWhNcVhndUJ3S0dUWnlhRjVVQlZoMzVtdFNaV0czVG5TV1pQMGp6U3c0?=
 =?utf-8?B?QUR1Q0QyUzVHNGQ4bmdCbXhUVkRLY3lDSXFralFyQkVSN1hNYmlBbzNWR0RT?=
 =?utf-8?B?b05CSVlXeGZlUTF1ckJDaUtIUXYwRlpBbHJrRVlqYzc2U1crWnhVelFrSFRH?=
 =?utf-8?B?aUxpMlhVeS9tVFFzM2F2V25yTGgya1laUWJhcTR2SVh2YmFIY0ZGeWRwcENs?=
 =?utf-8?B?OUJNTUJ5WVp0TEVkcEV0QVJDdWU0YXBGMklkNXNMQndtci9NRjJoM0NJUkZx?=
 =?utf-8?B?dFJlbTI3SFhmdUpFNTU0dmhCTE9RSmdCSWpQL1hhYmJYRXV2ZXM2UFRPbVg1?=
 =?utf-8?B?RnlOTHhrKzNxSFhGb2sxQTE1Y3RzeXlXeEJlbFJUQmw5dk5FdnpaMkE0MGdF?=
 =?utf-8?B?T1pjUWpzbDB6SnloRTJCNDNmODNCZGYxSjdNOEgzYml0VWJYTk1CcUVQVjFz?=
 =?utf-8?B?TW95MEtjRzZKS1VPNVBHN3VrK2hGQVB4akRhVnUzTVZZWnB1cVRzNStLUThB?=
 =?utf-8?B?ZHVVQ3lRdC9IVjRnZEkwZ1dHUFVLYkUwMk1COUxtQlF3Q0ttSXc5K3JoL3ox?=
 =?utf-8?B?VGNNSWl0dHc3MDluOWIwNU9qamV3bGhPdHNPMHJRdVQ1V1J4dmU4MmFEckxz?=
 =?utf-8?B?cHN6N0NBd012YkRwMnZVRHIrSXRBbjdjc2ZmNllxUEZQM3EydHdQL1ZTMkpu?=
 =?utf-8?B?ZXJyVk9kQ1kvTW5HUncrc3EzcHcrWWE4S3dIZ1ppTWxLMWZjY05hSFZKZXh0?=
 =?utf-8?B?NEJGWmc3QTRRaS93K2xBOG5vSGM1a3ZCQXdVb3AvMzJRUzdlZEJBRWNWUnBt?=
 =?utf-8?B?RGFqd3l5WjhEZDNHb2V1ZlNsZEJEdmk3LzJHc1dqZGpIYW1CTXNRbDl4SnJG?=
 =?utf-8?B?dW1qdjhha28wcCtXbDRma0dza0pNSHF0cjVtMUp3ZWRaVUgvUzNKNnlXK21W?=
 =?utf-8?B?TUgrc2k1VXdUUTZvSitTK0JqWVZoYU40RDNjbXFXQjM0cXE4N0QyVW8xNzRh?=
 =?utf-8?B?a042QWxmcCtkenpURlhnaVhLM0VrOEdIczB4VytBTmFzcjE3RzRrdk9iMUwv?=
 =?utf-8?B?amlwaUxZR00zNWJYUUFURTFWdDFVelBPdEd5UkJBWitvbE9xT3hjMXZsbGl6?=
 =?utf-8?Q?vDK5iTe1khHc1JDvkLLmVbL2F1d+MvnrRY80XYQD/ilhn?=
x-ms-exchange-antispam-messagedata-1: x5XCBPAEHEAaRg==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabee70f-a902-4349-9dd1-08da3d21c685
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 01:07:30.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1hTxe9DAtQ4nc6AMCVHgVQB0go0QYUxI4jjV4HUCJ8MEMYKVoWVihue/67ujPuAuLLTnS4L9pLlrDIw+WTOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
Cc: "mst@redhat.com" <mst@redhat.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgTWF5IDIyLCAyMDIyIDExOjQxIFBNDQo+IFRvOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRp
YS5jb20+DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgWW9uZ2ppIFhpZSA8eGll
eW9uZ2ppQGJ5dGVkYW5jZS5jb20+Ow0KPiBtc3RAcmVkaGF0LmNvbTsgbGluZ3NoYW4uemh1QGlu
dGVsLmNvbTsgRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Ow0KPiB2aXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10g
dmRwYTogQWRkIGEgZGV2aWNlIG9iamVjdCBmb3IgdmRwYSBtYW5hZ2VtZW50DQo+IGRldmljZQ0K
PiANCj4gT24gTW9uLCBNYXkgMjMsIDIwMjIgYXQgMTA6MDAgQU0gUGFyYXYgUGFuZGl0IDxwYXJh
dkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMTgsIDIw
MjIgNDozMiBBTQ0KPiA+ID4NCj4gPiA+IOWcqCAyMDIyLzUvMTggMDc6MDMsIFBhcmF2IFBhbmRp
dCDlhpnpgZM6DQo+ID4gPiA+Pj4gQW5kIHJlZ2FyZGluZyB2ZHVzZV9kZXZfcmVsZWFzZSgpIGFu
ZCBleGlzdGluZyBlbXB0eSByZWxlYXNlDQo+ID4gPiA+Pj4gZnVuY3Rpb24sDQo+ID4gPiA+PiB0
aGV5IGNhbiBiZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQuDQo+ID4gPiA+Pj4gVGhpcyBpcyBiZWNh
dXNlIHRoZXkgYXJlIHJlYWxseSB0aGUgc3RydWN0IGRldmljZS4NCj4gPiA+ID4+IEkgZG8gbm90
IHVuZGVyc3RhbmQgdGhpcyBzdGF0ZW1lbnQsIHNvcnJ5Lg0KPiA+ID4gPiBJdCB3YXMgYmFkIHNl
bnRlbmNlLCBteSBiYWQuDQo+ID4gPiA+DQo+ID4gPiA+IFdoYXQgSSB3YW50ZWQgdG8gc2F5IGlz
LCBwcm9iYWJseSBiZXR0ZXIgZXhwbGFpbmVkIHdpdGggcmVhbCBwYXRjaA0KPiBiZWxvdy4NCj4g
PiA+ID4gSW4gY29udGV4dCBvZiBbMV0sIHN0cnVjdCB2ZHVzZV9tZ210ZGV2IGVtcHR5IHJlbGVh
c2UgZnVuY3Rpb24gY2FuDQo+ID4gPiA+IGJlDQo+ID4gPiBhdm9pZGVkIGJ5IGJlbG93IGlubGlu
ZSBwYXRjaCBbMl0uDQo+ID4gPiA+DQo+ID4gPiA+IFsxXWh0dHBzOi8vd3d3LnNwaW5pY3MubmV0
L2xpc3RzL2xpbnV4LXZpcnR1YWxpemF0aW9uL21zZzU2MzcxLmh0bQ0KPiA+ID4gPiBsDQo+ID4g
PiA+DQo+ID4gPiA+IFsyXSBwYXRjaDoNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT2ssIGlmIHdlIGdv
IHRoaXMgd2F5IChsb29rcyBtb3JlIGxpa2UgbWRldl9wYXJlbnQpLiBJIHRoaW5rIHdlIG5lZWQN
Cj4gPiA+IGF0IGxlYXN0IHJlbmFtZSB0aGUgdmRwYV9tZ210X2RldmljZSwgbWF5YmUgdmRwYV9w
YXJlbnQgKGxpa2UNCj4gbWRldl9wYXJlbnQpPw0KPiA+ID4NCj4gPiBJdCBjYW4gYmUuDQo+ID4g
UGFyZW50IGlzIGFsc28gYSBkZXZpY2UuIFNvLi4uDQo+IA0KPiBIb3cgYWJvdXQgInZkcGFfcGFy
ZW50X2RhdGEiPyBOb3QgYSBuYXRpdmUgc3BlYWtlciBidXQgaXQncyBiZXR0ZXIgdG8NCj4gcmVt
b3ZlICJkZXZpY2UiIGZyb20gdGhlIG5hbWUgYW5ob3cuDQo+IA0KX2RhdGEgaXMgZGlsdXRpbmcg
dGhlIHJvbGUgd2hhdCB0aGlzIG9iamVjdCBkb2VzIGFzIGhhcyBvcHMuDQpBbmQgb2JqZWN0IGlz
IG1vcmUgdGhhbiBhIHBhcmVudC4NClNvIG1heSBiZSB2ZHBhX21nbXRfbGluayBhcyBpdCBlbmFi
bGVzIGhhbmRsaW5nIHZkcGEgZGV2aWNlIG1hbmFnZW1lbnQgYW5kIGxpbmthZ2UgdG8gdGhlICpk
ZXZpY2UuDQoNCkkgc3RpbGwgZmVlbCB0aGF0IGl0cyBvdmVya2lsbC4NCk1nbXRfZGV2IGlzIHBy
b2JhYmx5IGp1c3QgZmluZSwgYXMgaXRzIHRha2luZyBjYXJlIG9mIGxpZmUgY3ljbGluZyBtdWx0
aXBsZSBkZXZpY2VzLi4uDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
