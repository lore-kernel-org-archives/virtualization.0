Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2285C433EF
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 12:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39B67404E5;
	Wed, 18 May 2022 12:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nUkul5f0rS0; Wed, 18 May 2022 12:51:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AEE76404DD;
	Wed, 18 May 2022 12:51:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B0CBC0032;
	Wed, 18 May 2022 12:51:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC9B0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 12:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB525817AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 12:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 281Sh8mIJlXJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 12:51:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB4F8813CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 12:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFmL9h2Va0EOFHQh/cFr5JxIZJ2xMlWrBIcl/jiwvwale3k3I9tR1iHDtFpAavX09W8I+86cEoCUeZueKsUTw/34XtZm0vlduZtAzOcsmGupODbJUdhNwru3aiT44/FXYh7VufAVLji3hg8oCyVv88JJ0woKvuwv+yEQ7Xfhks66iWAuIw6fyIU1q0hy/3gDkaSxrV6k4iwyXpvP+c247EHeZwl2eiqsrk9F6vUpVcprlpP41VecdQKKZhBMlm7VXvtpSJrcQE9FhEREkKs6h+X3T9OiPVl/CM/95TEkeLOKtbYv+/G2WouarQcuiyv0si16ygAPsk+t61Q+dCS+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJAuN1fSL1fhIl3K3eWQBuWSorIPXeKcEkdlScbScPg=;
 b=hib2vEW/CgeS/iu5jOa6T+7xKV0IeH+wyIurp7AQozFKiad8ruryVTmy1Nm1xoL5kKM6w2kOIjLTr978H3eBjvJsZOC4lVD/RkLqPavTJv00u4E0X2ZJup1YmYWvtttlR4Wmcn0eY1JvVtEjnLJ+7U2IcRBIgCgBub8CRWODUCJOAPUi7Kh1D4bKjkGk4Ak0V3tewHT1pKAxyaQL1xP9NFJW8lfDqf4r94iu8dI+Wm/J0AwQn1EtlfQLlybOHRCVibtcV6+EZAae9NVCeD/2lja1gCCd2tLKujoErd5iSznWl6JCyXNzLoPN4z8M/NzqaPZaGP6XIa9fdtH6kvYqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJAuN1fSL1fhIl3K3eWQBuWSorIPXeKcEkdlScbScPg=;
 b=bhAjTyU90Ch6UU4sBq7MDm1dw/FL4/7PCeFXLR8jPd3aT7JmAiaz8ICqov7znaI5QMq17aBJJn+FPIMsfYuC4bh/1hWZgqt1D0m3cA5wnwU1m0GTzXeU69u5L1vovRvvFwh4H8Do8/FeSmb0GAfjuTUh/TEwnhCdqNwNAJ9ecV1EhzXHIg7HUFTeI+qrGG5xMUaly7QDm8C7DlxoAZuxjwHqHfQBOpRSlymVOeRMQpzaaDGFnPSUOFMIZ1mrQsYwenwaXB+yo5O30uYWNMJxH2wXYqyVwHnWXi66zTKJ/p49VH2lJBZcVIFe3Ud6z8eSVtY+jNxljClZ+PxbZwBxZA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 12:51:48 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 12:51:47 +0000
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: RE: About restoring the state in vhost-vdpa device
Thread-Topic: About restoring the state in vhost-vdpa device
Thread-Index: AQHYZW+JxbBQ1h+RIkS7iyhFOVHKbK0c5lPggAAyGwCAAAYJcIAEGq4AgAC/8WCAAMebAIAB37MQ
Date: Wed, 18 May 2022 12:51:47 +0000
Message-ID: <PH0PR12MB5481846910A230F6F8F58DA9DCD19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
 <PH0PR12MB5481AF0B02B0FB00885FF2AEDCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BY5PR02MB698052EE53B707C6C04C3C8CB1CA9@BY5PR02MB6980.namprd02.prod.outlook.com>
 <PH0PR12MB54811C88B389ACB495BD5AB2DCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWe2dQx1s7wQr8OLp-0eAQZJcCBuFwdxBA=sgeNm_u4N6A@mail.gmail.com>
 <PH0PR12MB54812F8306F5B9650BA10783DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWfqugjApohFBejiFQTLhkuLFEfgFjKhmGGc5-yMDmM6Hg@mail.gmail.com>
In-Reply-To: <CAJaqyWfqugjApohFBejiFQTLhkuLFEfgFjKhmGGc5-yMDmM6Hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77bcc225-796c-4b34-d46c-08da38cd2bb8
x-ms-traffictypediagnostic: CH2PR12MB4326:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4326B4A8A03DD3D347B5A875DCD19@CH2PR12MB4326.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IuR+qlFy4KVOZEgLuQLKMOeDcc9woKKBMgRzzYQksnigbp6v1UfASyGn+a+0GVnk9xyT0RQfFuI3y9+e8WQR29ncHmVzv+6H/kdDypxGhwOpuXuX8vWYfA35Iq/U6bdD2pbvoLWVTyr4C79ssbUrCs4FoULj32txMSiBvSk2Ru3QdmTUPQPlzXlyPAtnDwOJYkZoTi0oj4LDjo1aXBuvLbaLh2w/UyAUIxV+BFBFPjhiOUZ0m/9JEvrVtfvV5/eZiFbEzNxnv+T2SQGQEiR6MAJs9muqL2jtI9esuQR1uyOSb0w3rXQpXYrLdmObPYv4wTf8v9HI6MypC3kGl98kaUGoPtr5kw3l5MDVv41bT+u/yzepzVs9De24uZC6XNA+IqnwK/i6lw7eUW71gKF9hpkK3wz5gPs3LUalZw1n2pZEBpXxtaDGQre/nlkHQwhpjEwRF/9kgEc272hBWoyDZl/g8fCSwzSuWJ+LIvR8A9rDzmOfbZdghF0TWE7hPC9H5l8o1YhpX1+NgJ7Nr1NizXDkdikAOebTwDdmuSt24TZLOiaoc1iu/SQ0k4bRyZg4KNqIt4NpCmR/MIaWstO80Sysb1PH9QLsil9MviVBdLYbrekOnNhbUmuCewoyPG1w9OZrGwBC+3DiyhZvHtB6IIY9G+us5HW3DIGOOs/w6lh5v7CUoZeKJ9G4H3Yi5c1QGYLXyTt7CalsD1KizWEnvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(8936002)(38070700005)(508600001)(38100700002)(33656002)(5660300002)(55016003)(71200400001)(122000001)(186003)(9686003)(86362001)(83380400001)(7696005)(66476007)(2906002)(6506007)(66556008)(66446008)(76116006)(66946007)(64756008)(316002)(6916009)(54906003)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRhWG9KQkFpOGR3UWtHT25lMlVhUzBTZUZmOTYwUitNN29aQ3NUb3RxQ1l6?=
 =?utf-8?B?ZlVCbEJiV3p1TXlSZ3N6Mmd4Tkg2NHVqZFh2R014RldyNVhSVktRTHZBSm0x?=
 =?utf-8?B?Tk90WlVPeVFhNEdIUkR1ZGhWNCtxNmhhQ1BTQmllSFZQNXA0YXhKdlJ0ZThL?=
 =?utf-8?B?am9uc1YyaWtpelBXNUYzUlVxcktSR3l4TzkwL3VjVithRnU5Y3YvNzUvOTh0?=
 =?utf-8?B?a2tTYVREUHAxcnMyQWFVbjNseUxtbVVzcC80WU9YdHdsT3JIRTBxK3BOdGRt?=
 =?utf-8?B?dGxkR3pIRWFVa0lLNm5PaTRhUHJaSTYvY1hoQ0dIU3VQVDRDRGhFK0JaNXJZ?=
 =?utf-8?B?aWZiYldXT0p1T2huQ2x3TFU2QmNhWDRhZUpDQ3FmMTFuTnZYYWlQbzJoL0Nq?=
 =?utf-8?B?RDR0N3NVOW0vWjNSSE1Femw3bWVSNCtuVUFYRklXT2dSaWR6K2hMenZNYkRx?=
 =?utf-8?B?RkJ1MnVLRG1XdTBjNUxSbE5DdnoybythNGhzb0d3VGhJaE56bFdlTE1sdHh2?=
 =?utf-8?B?UlVwU0RnOGdsTEpqdThtRWhBU3h0SWNpSmM1TU5OdWNrbE9YNUJZZ0Nua0NN?=
 =?utf-8?B?aXdxMnRUTGFLMnlUdVc0NUJBcm1NZ1N4bUVBVXBoYjdmbmI3djlEMGgrNnZD?=
 =?utf-8?B?UmMyUmhnNzBaUzVoUUFpcnpBSXBIT3RqNDlxbTJad2tubzJTNm0xM1NLSXRT?=
 =?utf-8?B?KzNkWnJjRnMzcFRmUHJ0bm91Y1RiQkFucGlqUzB6VFVXRkFnSURoSjkxUjBO?=
 =?utf-8?B?bUIxbzI0L2ZCNVdobEo4QUgxSThvQ0Z5dXFJTUdMeWlPOCs1aHNGNlorS1ZZ?=
 =?utf-8?B?bU94SWhHZTlwMHFXcEs4UHdldFNUWjMrcmtKeUc5RldqS0NoeFViRWpiWi9J?=
 =?utf-8?B?alNmdnhFL0pZUTI3ZHNXcDBlWHhIaE1SamNJNnE0cU5zWk1KanFGN25wR0o4?=
 =?utf-8?B?b0hHclZZV1NJaTJydm9PK0dtTlNEckNOZTVzTE5EOW5iZmE5TnRUamwrbDh5?=
 =?utf-8?B?dW8xTlR4NW02TEdtSUphTTBiNTVBSFo5cmtVTDNSelJFVXBJQ2dBeDZXaGxX?=
 =?utf-8?B?cmg5M3dZdlJrdHB4SzZoYi9vK3RJUlhqTlNaNGlxVTdQSVdwOThIV25xblpk?=
 =?utf-8?B?NXFDb01ad1Q2QlZzVCs3bHQ3TzN5RE1BbjRSWTVFWWtqMU1PT3c1SUpKUnlX?=
 =?utf-8?B?MVJpZkw5RFZJcnJhSjZQYjNtcU5mbVAvZnJzclVPQytpem1nUSs1SWVMcUNJ?=
 =?utf-8?B?ZFpwcmdGaDVxSlUveWFrUHZyRVNEM3JvVks2Z3AwOERiWmsxc1daaVlZUlhE?=
 =?utf-8?B?UkxwT0ZnMURDSjZ0eHJtUFNJSW9UN3dGRnlGYjd1VUlpTjhKUGV4aVRLdlJ2?=
 =?utf-8?B?Y3VBbnNEeDY2amtnREpnQ205RUVocVJVbVBicmVKd2RDdlpZcHdtbDJ1R3B5?=
 =?utf-8?B?UnIzenpLWlZNQkkzclZ6OXBrcXVlWjBCTFFCNURIbWxEbVl4eXYxL3Y0NmZs?=
 =?utf-8?B?MzNQTGplWEpvL0ZxbFZDWFJoOFhYdncybGZjdlZCcnVFUDY4WFBRWjFJWHFT?=
 =?utf-8?B?TEd4UUNYejQwN0p3ZUNFbitSeWowNzNRbUhwaXk3d3Jyd1p1d283c1BIeVRW?=
 =?utf-8?B?dzdkY3pqUmtIUnplODJNcDg3dUwxQmkvUWJreTl1SHdrOEp4TE1CRmJXSExr?=
 =?utf-8?B?MzJUSWtpTmpCRUtxck8xU0xMNWtRQ2xtMEJUL2xWZDVoWG15dkFGVWRpQzhq?=
 =?utf-8?B?WjZRWkcwRVVFbVRHK0FCWGNVRDQzdmdDUUpUSzZKWjEzaGJnd21GbkllQ2JN?=
 =?utf-8?B?Z0Q3NDBVbmhpZzllc201dDZWYklkNHhjRzhjeTNmWU9WWnNIY28vdkI1Zldp?=
 =?utf-8?B?S2k0RnhqQzhuZi9yQ3c1dW56QWtLR3ZYSVYrY0R5RVdTenlSZEJ5VDhUTzh6?=
 =?utf-8?B?RHM5b0FRNFdrR2lnK09Va2xzZXl0STZLbjMxMmJvdXJ2L1hUR1paUXBYYjVL?=
 =?utf-8?B?RUlvSnVud3FDTkwrV2t4QVVsdlRaRDJ0RnM3dFlLWjVDNWNVdUt4UWo4dXE1?=
 =?utf-8?B?YTMvYjJZbml1Y1hZSVZYNFZsSEk0RVR5RGtjRVUyeWs2anR6NnFpVHRmMW5y?=
 =?utf-8?B?WUZoS1pMRFRCdmQzWkg2b1lVQTBBdTc1dlJsVStmQlhSRlJBbkFFUW1BaWg2?=
 =?utf-8?B?NDBTY0F2NXU2WisxODlrbXMvZnhsRTlCYVRWVXUzTGkvdlF2YlFGUWpXaFpy?=
 =?utf-8?B?aVZIbnVJQWdDK0R5SldscmZjVmRSSHA5Q1psNHBkemdRVGpXY0hLREdMdmpW?=
 =?utf-8?B?MUxLYldkWnJ1TWVjeTFsOHhqZXhZOWNkbzF0Vk1WSUorWHJuZUpmUnBWK2NO?=
 =?utf-8?Q?65GJM2SrQFLzghu/1sLY900GmWNdPenInWsl8GV/5DRUF?=
x-ms-exchange-antispam-messagedata-1: THUI981TVlV4gg==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bcc225-796c-4b34-d46c-08da38cd2bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 12:51:47.9174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwSf5/l9SMyBvzm75o1pGJjWovr7s0OHpuV3zEpeFPrp85MWVaEnrJygQBnx3ZRy97r2h86TjNLdtZbj6028QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
Cc: Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "virtio-networking@redhat.com" <virtio-networking@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Eugenio Perez Martin <eperezma@redhat.com>
> Sent: Tuesday, May 17, 2022 4:12 AM
 
> > 2. Each VQ enablement one at a time, requires constant steering update
> > for the VQ While this information is something already known. Trying to
> reuse brings a callback result in this in-efficiency.
> > So better to start with more reusable APIs that fits the LM flow.
> 
> We can change to that model later. Since the model proposed by us does not
> add any burden, we can discard it down the road if something better arises.
> The proposed behavior should already work for all
> devices: It comes for free regarding kernel / vdpa code.
It is not for free.
It comes with higher LM downtime.
And that makes it unusable as the queues scale.

> 
> I think that doing at vhost/vDPA level is going to cause the same problem as
> VRING_SET_BASE: We will need to maintain two ways of performing the
> same, and the code will need to synchronize them. I'm not *against* adding
> it by itself, I'm just considering it an optimization that needs to be balanced
> against what already enables the device to perform state restoring.

We only need to change the sequencing of how we restore and abstract it out how to restore in the vdpa layer.
CVQ or something else it the choice internal inside the vpda vendor driver.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
