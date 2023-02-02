Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAEAC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 22:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CA9D61202;
	Thu,  2 Feb 2023 22:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CA9D61202
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f+D/PRRK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKxMHDAOXv05; Thu,  2 Feb 2023 22:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E7D2E60ACF;
	Thu,  2 Feb 2023 22:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7D2E60ACF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2D8FC0033;
	Thu,  2 Feb 2023 22:01:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E651EC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 968048129A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 968048129A
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=f+D/PRRK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0onLkulRZXQn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:01:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF3AA812B1
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF3AA812B1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 22:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5/3UsoGAUS0R7faGYflOROt4kk/FLBDsz1GvO3mBJIJ9HyYpyFKNlZKLy3s/2GmPkq97c9b7uwC6a/wyoOAtS2Vq8A+dCL+9qoKtZgZYQ5mLy2lP5//eXjlaYVtRafWJcymWD9fZPLMNJSNobLM3UoLgF1IesVShnTlL93Pl8jg2SMABJX91a/i9Excq60DOuZ1+pzqTF7B8yIwuuHp5LlOclYSe5Yy/ShZnyh9PBJ+COnrreC9FP6RlNeAiYTI/KEOGemefqg9gQsjdPsLa1r+xcwZY2SVI560BrafdKZ5QKrPg0c44ABqvR43/GYGk4tVGHTsMlENdvh3z7BBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUMhWpP/ZPBOWKV8zzS/V0rVb+OUm8VH8Wq5sihnzbM=;
 b=OsVnXNQQnNMcP1WBXJgvdKFogj5XLCAr12G1C0ndXsmCW6/qnFWEfziOLazslTe32gO8IfjVtnOPox12419gOOt+Ij2M1111R6qzoSl7sO3k5Urt27f0d26y99VEYRKO1RVvP3o/WvirJhVqKhQNYqvZ0Kv28vK1N9dMX6exiFHcp7Zhm5892z7MQ8XOI2kH/ptUFbahAH5mcoWTKfrB1xJtCDrH0RvOFnn6ghTNjeIDa4NbK/TmM/frge48OkvR442sCIqIHoNNHcZdHdMlse92HWwnXH/J3LuA8eDSETOfwJwYBDhH+Ske9m2dPnZgM2HJmwJEE645BqIyLAlbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUMhWpP/ZPBOWKV8zzS/V0rVb+OUm8VH8Wq5sihnzbM=;
 b=f+D/PRRKoaZydA03j/SVNl1Zo8FrZ4RusG78eo9cRksqMRYqvDDVj3XAPzsCQxzDMcwE8PkZfgieKEZhkJrl8BR8cst6Gu7zD11uK1oylr2zw3X2gTQEjkttGRafcS1mGV+Ifa/J/n0x5pKY0tYKVpGrGQR3Jw/ju7lfxBRQ0JSIT/fwyaxGfYGG54IF4wJ7ZKdeEes+fKWiSGOjsS+CwXt1DosGUbMBvildUUOCQPK4lTD7uHo+CiYwz5IZBbMk/jJdOJLU4R+kMI7zXZd6Y4xon3/5dS7WB2MOabBRZrwXoEDHdvgt1HQ+BYQt3CVBB8YOtEYT4xVVuUanGkD2Yw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 22:01:19 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0%4]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 22:01:19 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH v2 3/7] vdpa: validate provisioned device features against
 specified attribute
Thread-Topic: [PATCH v2 3/7] vdpa: validate provisioned device features
 against specified attribute
Thread-Index: AQHZNcrul/O2ZyBovE6TfvS9k66n+q67G64QgAEbwYCAAABlkA==
Date: Thu, 2 Feb 2023 22:01:19 +0000
Message-ID: <PH0PR12MB5481281DC132B6424BF4DAD8DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-4-git-send-email-si-wei.liu@oracle.com>
 <PH0PR12MB5481759D5CA6EB5C9D63C517DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6b27b653-1d36-0ec8-c3c7-caaf1b896381@oracle.com>
In-Reply-To: <6b27b653-1d36-0ec8-c3c7-caaf1b896381@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5767:EE_
x-ms-office365-filtering-correlation-id: a63aa249-bb9c-4447-ffed-08db056903ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6shcJUkw9eQGLEXbRqRhU1b5VQGrknA/zssDtQLWooUCVA+QGDSF9S+d869p8Mmn4aANaz2Na7O7wT6oShBzKtm1UocDj/M86xxO834THVRUB89WRZZV8oJFndqWKAl6Ru1ZBlIaIWZ9yUwQ/xFQsa4cWrZP2FjBP/kg08gQX+Cd1yrCO2a6L9VcGyFdcU5JzxI8NZN2sKQpGysj4nrh5wsTjQ/SuhFcdH/QgZWT+dwBZjCI0A55coaca+1r76IS27nTHjvk0eYA6v208celSakeeViluWqZjmD1Ewz586y7d2oxM/Za14W2davUXPAnQdc+TcNyNmGAiDf+eitHHMav7ttb2Y4r1BIvHipHjgN3JhKBqihxdy9Rn+NUzhlZATj9RU4doK7NwShuy6yaxVk0A0W5MhhYGE75x1d3VfAINJqTdfhh6KQPZ3Tc+Z2jQLBgogu6LJaM3d3iMVRvPocw3XSXWQxerCv1xFiweLTxyms1OuSXsVIN5Jw/MShhX+SFK7olcAUPcxLLn3ulhdHSGgp3rb9aof+o68goy6dbCzNc/5o+bj/K4SxXty5yQ9CBqF9AgGkwK6HDbIC1ZO+5L43CUb41BHxp/7vOYz9xyPhK33w6NH2pFGOdl9dX0dUsUWHZCvQE/xJRVEAgLAjqu1/bN8GAPAtjhyyTIlHy7U4lwjBas7HO89N8f+25bDwLzqxFIoolaGo49IIIuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(76116006)(5660300002)(33656002)(86362001)(8676002)(4326008)(38070700005)(55016003)(52536014)(41300700001)(8936002)(316002)(110136005)(54906003)(6636002)(66946007)(66476007)(66446008)(66556008)(64756008)(122000001)(38100700002)(53546011)(6506007)(478600001)(71200400001)(7696005)(9686003)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFVRDU1SGdIaHZZZ1dVTFU1Vk5nY0lMaTRGUWpqQVgxTEMrTG9TbDg0ZnVP?=
 =?utf-8?B?Zlk4NGFFWDE4bzVBMXdGRXZjWUM5MGFlQ1kvMFovaXExV201b2dsMzdvT2pW?=
 =?utf-8?B?d0V3ZHlXU0psTGV4SDd5SXhLV1ZXS0M3UnZhSVR0VlM3aldvUWZXLzJYRnI5?=
 =?utf-8?B?Zkl1bjdoaS9SSytIOEFGdDdrcUZkVHR2WVhKeU1sbmNzYVIvQzNDOUNJbTJ0?=
 =?utf-8?B?VVZuSlhzTytKaTRuTzFnaEtHQ0pReXBhbmkwMngvTXZHQ3hSQ3NNbVR2U2xt?=
 =?utf-8?B?eGltR1FYSHRRMUdTWUVIRU9BVytQQ2hUSWNtc2MwUUVlM3ZtOExXdm84N0Q2?=
 =?utf-8?B?NThzTlhSYVNXY05rdjJBYytjay9uTnZhODhUZjRoK2RqYnhJcW1Wd0lieVN4?=
 =?utf-8?B?WG1TeEFuVzZHVEN6dXE5cDFnT01jUFhadEx6TVcwZWUvNmdncld5SGQzSXht?=
 =?utf-8?B?c0c0ZlBVY01WRnVPOVh5SE1SQUtmZ1ZUcVJXMm1LNC9zYWJiY21oNW5PWnVN?=
 =?utf-8?B?c1Z1Q01HQ2FKY2dNOEJjTEtWT1NLV3ZjV0I4TUVma2QvSlJqbXRXQXQ1NW9h?=
 =?utf-8?B?MldHSDg0ZVVqK3hENTdMUUh2TXZDaHd6em1ybm1QZHVXYjJSWlVoMGFqMGZJ?=
 =?utf-8?B?SFVqa29ybjhXKzgwdFowOHJlazYxSzdTUEp1ellVUkVJdGNCbk5NeUNYS2Uz?=
 =?utf-8?B?UVdsbWR1eFk5ZEpqeUVtcU9mejg4L1dpMGZrYnVvWW5TQXlxVWpFY0ZKYXFR?=
 =?utf-8?B?RG9vUndIUDZDUmRRNis5aXQwRisrNlFRcmVCT1o4MWxFdU40SUxUdVB6Slhp?=
 =?utf-8?B?RmRvN3dUeUY3b2pFT0ZhcjNzSWEvb0I4RmZhMUY4UVNScnE2WUlNRTk5aTVj?=
 =?utf-8?B?QkFmcEh0MVFoWWNsSjh0UVl5Y3hkbGM2anAxaUR2cktyTXcxNXNGRFR1RnBI?=
 =?utf-8?B?czBDQTl2Zzc4WFhabU85MFVpN2RUWEU5ZjhvTnhrZkNFR3BpZzRxcXZ5dXU3?=
 =?utf-8?B?VXlLZ2t0S1V0UVgreG1vSnUyWnFzR2piL1lET21hOVM5a2s0OExBZ1FTcm5x?=
 =?utf-8?B?K01qWVJVakQyRkNxbnQzYXNoS0JlTUxIY20xQmRYZXJQOU0zVVNQWGQ1OEJi?=
 =?utf-8?B?N2xqejNyMVJvczh1d3hIMlJkSVdkckZCQVRsbGVhc0g4eSsrSjNhUUxFc0Q3?=
 =?utf-8?B?VkF0QXhOWE54cjB2TWt2OU1ydnZRVmY1dmxpYmFUZy81QzFRVW0rTVM1ZFNL?=
 =?utf-8?B?T0g0cGR4WEk5MXhqMHRiR05oaS83UEUrcHlKS1o3RkNtRXcrZFlVV2RVdGZr?=
 =?utf-8?B?MzdYNmpnWm1GWlJVT29WaGRvZHltY0w5dy9iQUZWdnozMWlYdTJTVXV6Y0JL?=
 =?utf-8?B?TGVDcUFOb2J6NmtIZEpGckJYdThWSnRCZU94TDl4UG11YTVtS3kyckxxWjdn?=
 =?utf-8?B?L21lSGNHV3dZa09xdXlUS0FXc2ZIT29SRS9kQUlOREt4a3V2Mjh5T0R4VFZ3?=
 =?utf-8?B?U0k0OWtUb3dsR0srb2hITDRQc1U5OXhEdlJsc1NjZTh2aXlYQk5JRzV3U1I4?=
 =?utf-8?B?Q2I1S0ptalZ5MEt2Nkc3amZPWlMyeHN3aFoxdHNLL2Z5emVtV0VLMnMwSzU2?=
 =?utf-8?B?NkhubndFcEtHZ2tIMURjL0Z0SXNzZUFvNmNpZ3lTZkFXdFhXZUgrYlhlUHdU?=
 =?utf-8?B?QmdYK3JqSUJYKzhZK3NHVHBlTXkxMkR0OEl6OVFpdnN2ZExSZkRpRkZ0WEJz?=
 =?utf-8?B?bkNpSDI5MXFWRFgxbE1VK1grcWdQWG1Zd0JrTWROY01kS3QyRzNtbGZYelI2?=
 =?utf-8?B?cnNqQk9QSXpNNEEzVnY3Y0M4NnNvUUlUREdId0VhUnpXbmFHQnRoUFdSWkdO?=
 =?utf-8?B?anRhUGxtTEJCbjRrK0QwVFNacmJkRklvcVc4dWE2NndlVkFiRld3Y2M5Tyt5?=
 =?utf-8?B?OXQ4cjVENHhyWmh4Qk9UdTJNc2RRR3NucUZIaER6V3MwbGZIQWozOWszR3Zt?=
 =?utf-8?B?M2duWldaeUNycXZPdEFabHJjSjV1M0hORjduYXE4MWxlNXAxYWNwT0tSRmpZ?=
 =?utf-8?B?d1BMejQxajBUYTQrMGJMNDJrdVlISGtEVllCNHBmUW9mcm1KamxsSTZ1QXdK?=
 =?utf-8?B?NG1TUGI2VGlTQ1pDRTZ1ZXFaSVB2djNRemhpdU9QdmFERURRWDY1R1J4c0VB?=
 =?utf-8?Q?FSCo7vbD75QJIaPuaMna5X0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63aa249-bb9c-4447-ffed-08db056903ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 22:01:19.5772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEfZ+db59Swddw5QrQ0dym0GMe0KlG6UHOPIbUXp2xgz+BI4ws5PeiEuEU+Ce2WinBavvLKkH2p0Oxr1lMCxWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Thursday, February 2, 2023 4:59 PM
> 
> On 2/1/2023 9:05 PM, Parav Pandit wrote:
> >
> >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> >> Sent: Tuesday, January 31, 2023 6:22 PM
> >>
> >> With device feature provisioning, there's a chance for
> >> misconfiguration that the vdpa feature attribute supplied in 'vdpa
> >> dev add' command doesn't get selected on the device_features to be
> >> provisioned. For instance, when a @mac attribute is specified, the
> >> corresponding feature bit _F_MAC in device_features should be set for
> >> consistency. If there's conflict on provisioned features against the attribute,
> it should be treated as an error to fail the ambiguous command.
> >> Noted the opposite is not necessarily true, for e.g. it's okay to
> >> have _F_MAC set in device_features without providing a corresponding
> >> @mac attribute, in which case the vdpa vendor driver could load
> >> certain default value for attribute that is not explicitly specified.
> >>
> >> Generalize this check in vdpa core so that there's no duplicate code
> >> in each vendor driver.
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 18 ++++++++++++++++++
> >>   1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >> 21c8aa3..1eba978
> >> 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -601,8 +601,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> >> sk_buff *skb, struct genl_info *i
> >>   		config.mask |=
> >> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> >>   	}
> >>   	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
> >> +		u64 missing = 0x0ULL;
> >> +
> >>   		config.device_features =
> >>   			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
> >> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR] &&
> >> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MAC)))
> >> +			missing |= BIT_ULL(VIRTIO_NET_F_MAC);
> >> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU] &&
> >> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MTU)))
> >> +			missing |= BIT_ULL(VIRTIO_NET_F_MTU);
> >> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] &&
> >> +		    config.net.max_vq_pairs > 1 &&
> >> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >> +			missing |= BIT_ULL(VIRTIO_NET_F_MQ);
> >> +		if (missing) {
> >> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> >> +					       "Missing features 0x%llx for
> >> provided attributes",
> >> +					       missing);
> >> +			return -EINVAL;
> >> +		}
> >>   		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
> >>   	}
> >>
> >> --
> >> 1.8.3.1
> > Vdpa this layer can likely derive the feature bits for the supplied config fields
> so that user doesn't need to keep track of both.
> > Only those feature bits which are unrelated to any config, is what user should
> be setting.
> It's not I can't do this, but Jason wanted to have clear semantics around
> migration compatibility for the driver, and for that users have to explicitly
> provide device_features that we may define new driver behavior (rather that
> inheritance which is implicit and not uniformly define across drivers) for
> compatibility using the new uAPI.
Make sense to explicitly tell, just requires more careful plumbing on the user space side.
Eventually it will get orchestrated by non user, so it should be fine to explicitly define it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
