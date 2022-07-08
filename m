Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB66C433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 16:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052C261412;
	Fri,  8 Jul 2022 16:13:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 052C261412
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a6Izhv1S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RozDRLJhx69J; Fri,  8 Jul 2022 16:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 407AB613DC;
	Fri,  8 Jul 2022 16:13:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 407AB613DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E250C0035;
	Fri,  8 Jul 2022 16:13:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FD4AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA534424AB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:13:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA534424AB
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=a6Izhv1S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8jMrCNMolpIu
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:13:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 770174248D
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 770174248D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 16:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0+Hcudo/KD2dMSHlAaR/ZhB5KE166Qj9IwKswNlWa/Lqt/fS6smgLmcY9erOMS5i0/F0IoYMzC9tyl1Z1VKhJ8INR/dv4c3UUDK6FFsCPni42n3++aNt7/YjlhtzgBLEATg+gOOL+7MpsJmZCnoKTjOOfHp42vTi4Ij7KZSxId/52uZUSMF6ia8VvoK3ftAeky72byk4Bs58IFPSvTTiHPjQ3sNcrWjP85Qv8fG+JxNa3x82zdxZjbf9ECDdh+3UAOeG9+S719qhO0QTRC+KIHN3s/47hQgluTfLMIFercIoC060pqs/BlSrrcC/bry40YSKDOgHMzogYeDbTOX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqUKcEA9aWL2ObS5mfX9hPQDbOtWckaJEp4uN308G4Q=;
 b=ayKAi64XHG6EUUNGaaIlYU4Uk0UlJBHSI8VW98IYTeAG4vQECi99N/EgIHxOpgKIv9JV4a9BRzCMet82M3+I2fnoDS7dhuyuaEr5rzKbWQhRu0ywbIMgLfHq9DoY3FAvk1wSPRTzP5lw4QM+ZeLxWngsBGTHeVTyV4u6Xb7nHVCRxQ50nrZlnnkajEdmdc0TyT9THQFwo9fqrUuv7gWgaS7kQOxqWaFu2bcn9R8KzUvbWCaIdusYOUMvGAkLl5Al2Q24tg4aQAFWqgJFaX4llowt7jUANbHPp2wyYlMbQaMlrmLs5aDfnw1kq9LCtLVURBZCMlAHzn/fUQEkRZ3iHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqUKcEA9aWL2ObS5mfX9hPQDbOtWckaJEp4uN308G4Q=;
 b=a6Izhv1SrcvA8hkZ9yTBYotXpfHBh5ylfQVGM2Chr+E86dIymjUMKk0PIeLR5EKzecxbsryb3CRnDEq0Xq0pLSlWIMb/OZcZtqM/yUU+qbiGSMXpZUHlPkpeVuTRyOrfQO1nV0R7cJutGJ1Q25ZjfcDeFeeDLausSFMmXkfWMvP7bv8VLFcrXmWbZiS2oEDxfdObFEE+uDFubmY169u+gCuhsNM5b+usrRPYoGUfHBDOyuVlyoNpfiKdSnCLx2Vgud6bfEo7NScfAw57FZQRfTSgNz+pZbbh/G3P2MuOwfNerXN/BpKy6nuspo1vuEhP5+S8TO7RlKCWaVxldro0ag==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 8 Jul
 2022 16:13:27 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 16:13:27 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V3 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V3 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYjU+MYrbSKcBokU6ni+IvOk3zwK1qDqQggAn7HwCAAKXIYA==
Date: Fri, 8 Jul 2022 16:13:27 +0000
Message-ID: <PH0PR12MB54816D143AAB834616FAEF67DC829@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-4-lingshan.zhu@intel.com>
 <PH0PR12MB5481AEB53864F35A79AAD7F5DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bfd46eb1-bc82-b1c8-f492-7bcaaada8aa4@intel.com>
In-Reply-To: <bfd46eb1-bc82-b1c8-f492-7bcaaada8aa4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b7b176-2535-4096-03e1-08da60fccae6
x-ms-traffictypediagnostic: SN1PR12MB2477:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ht40wUZDL2TMcAIqMcvHcJaOWM9Lz3WuXoZHsDDTYTVqHHtiTZP/mfarLs00+uuF6cXt18N4e19HwnVUpG/AadFGNbHtFvyZENhvxYRKoL0r6p7MnMAjp77jrSFekPVeKVa1zmbLx7S7fMu4QrrZZZXNLbTt1lHqgN2bWnOvWVykIuHKjh5QVSk2sG/bqlrhnSef4G63N01ifQM1hmuuSNg239Ln5M1DVcmUpgKqiivZRq0UTGKDHeiGjB7MpEHt6Or2pThz4HIBfzBb+pJm1bJv6PBGUu/zgeNeTq2iSLti2RyeRLagiOrDwQZJ1aizg6oxmBGL+r3oMY2a5Kc0YLrKL89/jytC/YBY/u7Lt/U3S5oqFqE7vWJTe6qGCGl6Yrxl6rUMxHMj03TTOV46/3O3l4woEDllJ7Zr84J/xgHQNeBBA2rkc4HUH3b5pfvxiFC9KUV+kos86OlPoUQYtem4A/98/Oaqr0DY5B339sUhl+9tsLfd/sekiZsGAJ0zaaYIlgd2jqw2+DAaCFJG/FrpONbK/fsnKMWnaRDl9rLQhs6WYRpBdLj/2e1gGn+0LZdWEkEI8NA+qBxHmqSOEcav98Q/d/PewbAJTsLyXpX/97Oyn3tRsR61oGF6XUiMdNaMbRM+ELncA0pgYvNGpBrDdm7y8h91UyoZwWP5DjWYIuARarK9mI2qdXrjJqr0YOz9WhbrmxYSONZ9p/9n40SvXl0M4UsPoRzwPeh8pMr/z3YaTiziskHGZ23wfULgfegPErcMpNi8YGBUYIYurxeghIMo2a08uxvmOr+VXxBjsgDXnn3pijXFvVMKRwL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(71200400001)(478600001)(4326008)(122000001)(38100700002)(33656002)(53546011)(9686003)(26005)(41300700001)(66476007)(6506007)(7696005)(110136005)(54906003)(66946007)(76116006)(66446008)(64756008)(66556008)(8676002)(316002)(186003)(55016003)(2906002)(52536014)(5660300002)(8936002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmtIOFJxTm5xdWZ6V0NwSmVpUmF0b0ordktObkxIQWZLNU1ZSGV2TW9OQXlQ?=
 =?utf-8?B?Nmo5WVdKMlk3SFd5WXk3V2lQMzhIb3hSbHBNelZwQU1SbXd0YVVGU1dPbVVN?=
 =?utf-8?B?clJ1eDU0dnYzbWppN292MHV5Qlhpb21hekJaZk1Fak1MTm03eW9PeEE0MjVu?=
 =?utf-8?B?K2NmUzEwUCt5T0NndHloUUI2eWFFL0Jjc1FrMXl4NmhIdGo1Zyt1S1BLNnZ4?=
 =?utf-8?B?OTM1SzhuQVo0VlFFQmMwd2grTnF1YkFIS28xSUZNSEswU1hnS0ZjUmErZElT?=
 =?utf-8?B?Tk40THBmMGxyZkhPbUg1MHpsWHJXY0N5VUorcG51OHVNWWk0bVdDbDRKOEV1?=
 =?utf-8?B?Zm5mZ1JreVY5TDFaakhNY3NLWURKb3gwRkFNYnRTWUpveGk5YmQ5L3B2cHdQ?=
 =?utf-8?B?MkJ4OW41WWRGZFFKaW1nZ0hodGRhSllwNFJaTGRvOFV4Y21KVXQ1UGM4bFRB?=
 =?utf-8?B?bEoxWmZXNFFyWDNKTDIrcU1iWG1LdHBOd3ZaZkNUNEZ0cGRtMmtUVlNlYisz?=
 =?utf-8?B?RmZhVGR6MFJ6RVB4QjZSYzl2WmU4NmxGRllIUlNlZzBYUkN0MzJML0Q4a0Qy?=
 =?utf-8?B?cGR4NmsyZmJIaS9yZ3ZDeDVKM1ZzTlczL0FJVWRHRlhoNjNSUHZ3MmcrMGt4?=
 =?utf-8?B?SDFzWTJYc2Z1SVN0RGZnaTd0MUE1ZVJtOEJQTGVHb05KeE8rM2tWYVY1KzZ2?=
 =?utf-8?B?M0dlYjUrbjZwczd0Y0plY1dUVkJreFUyVU9lYmROQW1ScG9Ya3RnUklUcG45?=
 =?utf-8?B?OElKZ3dZT1FVL0M1UTVKeGh4dFlWZWJmVjBJdCtxOUFkN0ZMZTBSaTI1OTdv?=
 =?utf-8?B?UElubDJyT3BQS3hZZ3VJVUVJSGxjNEdmVHRSVWNIekw4NnBBQnR3VnBiZXB2?=
 =?utf-8?B?SVBhQnNrdldzYVhJOTFYNUF0RkRseUZSeHp3RDBybHlzTnMvUjNMUE4wV3A0?=
 =?utf-8?B?TnU1akRMVDd3VDVFK3d5YVhCTjNHVjc2MkhUcThtMTUramswdjdkY2xrNkZC?=
 =?utf-8?B?dS9idCtBcjhSak9aLy9CY1pXMm9WdExjR2k1WkRJcS84cmRUVm5mZHRpS1ht?=
 =?utf-8?B?WHdjNWU2ZHB3eG05TFpZWmxxUDhqM2pXZkkrMXRZcVU5L0Nkb2xkNEV6c29Z?=
 =?utf-8?B?Uk44UDkyZkVUVnhBcXliSWtzT3RRS1BMazIrc1UzTzBkNFFHK1MvQ2VFeHdY?=
 =?utf-8?B?VnVYWUZDLzJ6citSK1A0Rk5vU1dUUk9RVWtOQVlVaVA3cGk1YlRPeUYzRkhF?=
 =?utf-8?B?UEJRWk1mT2NnQ24rN054UXJyRkpMcnRzbjhTNzFqSjRtb3lJOUR3UzNabFZC?=
 =?utf-8?B?elA0OHp5Mm1ZOTFaSG9ZQWxtZXlWeVYzZUZqREt0NmRpcXBlT1ZNL2ExRDZy?=
 =?utf-8?B?QlF5UEdwdUQvYmRlNitPR0FyQlg2Yzc2QjdLTHR5VWRBRzNqdlVVWXBqTnFX?=
 =?utf-8?B?U05JbDRKV0hzaXJlRTBLL2hiLzAxSTV6Rlpxdk1jaG9yODF1VVFnNk1xOUZ5?=
 =?utf-8?B?SWExY2x0RGVxaEhFbFBBQUd0aWdSMWdsTFFyQkJIRHhIaGR0UW9QUjJKVklq?=
 =?utf-8?B?WlNvTTFIL2hoWUVmZGJLTmdFWHh6S3NGUW05bStTS2UySGhyOGt0N3Qzcnkw?=
 =?utf-8?B?NTlJZXB6NTJ4UUZxVGpKaFJoK21yMzNLbmhuVVNiY3FsYmpxeGtQVS92S1Fl?=
 =?utf-8?B?aHpjcHY0VXREZ0FXY25LSVNvVTFiKzFlbzVpSWw3eVRPNWJ1eDNuYzlPVWU3?=
 =?utf-8?B?UkxTQnBsbk5oejlQNVZXaS9peVhMSHlwSVhvZ1A4ZmJUZzlBdzVKRmE2VXQ3?=
 =?utf-8?B?OEJQQjNwZzFYSUZqN1JCVjRkQ1hkQ0N1aGZSaE8ybUd2ZUpZbmJKOE1kZGww?=
 =?utf-8?B?V0htcXJnVUhGb1lKaWlmUHBwNFMwZ3ZTaC9qUUlFODY2UWRmbTlnTWFqTkZi?=
 =?utf-8?B?d2ZqN3RrcEVkK2lCUlc2NGJrWHFuMmJBTGVCVU1Kb1RsTXBoY3NnRzA4ZGFF?=
 =?utf-8?B?aHFwT2NKZitEck5UNE1oV0RhQkVKamRETVl6aFlRL3dQNGhycDFWNGhnVmpH?=
 =?utf-8?B?Wjc0M09EMEFFSFdVaEZFb2U2TWdoUkdmajV5M0lmMlN4aytwZEVuQVhlYWxz?=
 =?utf-8?Q?kfTY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b7b176-2535-4096-03e1-08da60fccae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 16:13:27.8131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2DovzV3/jvrtXezgB/cxmUeKT5W3wWlBzJdi/OgobbOgStxa+bdlAjrOnTYUP5JPaqrcbHRDMY551R/b+j6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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



> From: Zhu, Lingshan <lingshan.zhu@intel.com>
> Sent: Friday, July 8, 2022 2:16 AM
> 
> On 7/2/2022 6:02 AM, Parav Pandit wrote:
> >
> >> From: Zhu Lingshan <lingshan.zhu@intel.com>
> >> Sent: Friday, July 1, 2022 9:28 AM
> >>
> >> This commit adds a new vDPA netlink attribution
> >> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features
> >> of vDPA devices through this new attr.
> >>
> >> Fixes: a64917bc2e9b vdpa: (Provide interface to read driver feature)
> > Missing the "" in the line.
> will fix
> > I reviewed the patches again.
> >
> > However, this is not the fix.
> > A fix cannot add a new UAPI.
> I think we have discussed this, on why we can not re-name the existing
> wrong named attr, and why we can not re-use the attr.
> So are you suggesting remove this fixes tag?
> And why a fix can not add a new uAPI?

Because a new attribute cannot fix any existing attribute.

What is done in the patch is show current attributes of the vdpa device (which sometimes contains a different value than the mgmt. device).
So it is a new functionality that cannot have fixes tag.

> >
> > Code is already considering negotiated driver features to return the device
> config space.
> > Hence it is fine.
> No, the spec says:
> The device MUST allow reading of any device-specific configuration field
> before FEATURES_OK is set by the driver.
> >
> > This patch intents to provide device features to user space.
> > First what vdpa device are capable of, are already returned by features
> attribute on the management device.
> > This is done in commit [1].
> we have discussed this in another thread, vDPA device feature bits can be
> different from the management device feature bits.
> >
Yes. 
> > The only reason to have it is, when one management device indicates that
> feature is supported, but device may end up not supporting this feature if
> such feature is shared with other devices on same physical device.
> > For example all VFs may not be symmetric after large number of them are
> in use. In such case features bit of management device can differ (more
> features) than the vdpa device of this VF.
> > Hence, showing on the device is useful.
> >
> > As mentioned before in V2, commit [1] has wrongly named the attribute to
> VDPA_ATTR_DEV_SUPPORTED_FEATURES.
> > It should have been,
> VDPA_ATTR_DEV_MGMTDEV_SUPPORTED_FEATURES.
> > Because it is in UAPI, and since we don't want to break compilation of
> > iproute2, It cannot be renamed anymore.
> Yes, rename it will break current uAPI, so I can not rename it.
> >
I know, which is why this patch needs to do following listed changes described in previous email.

> > Given that, we do not want to start trend of naming device attributes with
> additional _VDPA_ to it as done in this patch.
> > Error in commit [1] was exception.
> >
> > Hence, please reuse VDPA_ATTR_DEV_SUPPORTED_FEATURES to return
> for device features too.
> >
> > Secondly, you need output example for showing device features in the
> commit log.
> >
> > 3rd, please drop the fixes tag as new capability is not a fix.
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
