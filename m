Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB7EC6FA82
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 19:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95ACC40895;
	Tue, 20 Sep 2022 19:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95ACC40895
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LSp7Oxkf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gMQW74KPzRp; Tue, 20 Sep 2022 19:17:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2D8E400D1;
	Tue, 20 Sep 2022 19:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2D8E400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8590C0032;
	Tue, 20 Sep 2022 19:17:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 340FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 19:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02F23826A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 19:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02F23826A4
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=LSp7Oxkf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FXR0fpA9VNJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 19:17:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A498781CEF
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A498781CEF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 19:17:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umuq7Rt4qfecwN9j9UPn8d5cXBA4n6Sw9VMS7MDYu0XxCqoOk0FgyV6l9vVB0nU26B83mvl+herMVe++2ken1eLvYtMFojOalJTxDuzH+GxIFkj2/3QzlvqywwX3iHDTpVyeEW5SRMWSBOV7IBMnhYdUBW7QhoDTBkIoW7GdaqvSZGqh1Gpfic2ooiWuLF3090bm4HCuSXYL4itVz4n0fLpmGVF/36xkXo0eZ6NaU9sxY3F7Njaau0JHS3tn4uzUa5+p5p7wX5CE1OUNqV5VXihmX3HPpnBBKqJ1pbr/0PR+cAvDvry2Dlwthakl8gI434Z5iV3b6+mtgRDJUs4OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1++ptXMXQQjXaSpqI/QhCLlnNMIK6DOJH6HIldjRyc=;
 b=SMXRbWs5ZnMEjWwRXtbLUDT9HmMVxyTx2+5RfArK5PqVeZSvf3dQZB7/fbt70wknNdkjLSJHXFMTfLztCqWMz7n7FPJ8RWyNRw8fMXeOZ6Rk51mrFkQ/vX47utOBEAn/rFdTmHxJk2T8y63xwuXxtBncKDw39h9dpvOQwhRpPSVtPOXELHfXc/55mSl6dErGGaYunK2jpMuYmnkr+bTjaG+NilY2DkGnzeLj8mVAHUEQHaCkCw1PoBqZJy0lH0YSAndqJb6W8YLAZ3ha7AKA13oD9gLHFCmoswEoKj2A06Vs/ywFIGnexkDo9SSxiH7ugu2uifbi35CdSfMeS3SKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1++ptXMXQQjXaSpqI/QhCLlnNMIK6DOJH6HIldjRyc=;
 b=LSp7Oxkf3q2nrb20BPb/fVdQMUmNOT0rbvfMnUhLj9novylIgBEzTm3YcCxpWCpCiZKt1B/CcUzfpM3Tksk9QNnoLmDFN5J52SIczC+AJtB2RT+CoTFPMac5FnpJDMuMtHXZ+XHwX/sYlGsFxi0I2St7HwSbq8mFl807d7xMoR0Z9uFGYl9SBBDJTxon9Yw3kazBTEXunbalBWttjDfWvBiCdnIiNmIgI8C2kLp+KGHYryUnayTRlb2YpS1yoCGIzc3x4xiy3J2N2944oF7hXOrQeUyuRn2vQFefsYLc2FBBydIVw1ZczsIKtrpBRnQccIX/93BXER123j9D6d3AWw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 19:17:23 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%8]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 19:17:23 +0000
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH 0/3] vdpa: device feature provisioning
Thread-Topic: [PATCH 0/3] vdpa: device feature provisioning
Thread-Index: AQHYyOBJr1VSNY1wu0yqqTgKlaS10a3ouSJg
Date: Tue, 20 Sep 2022 19:17:22 +0000
Message-ID: <PH0PR12MB548115F4597D409F94AB1E77DC4C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7649:EE_
x-ms-office365-filtering-correlation-id: 754ac0e8-673b-43e7-cd94-08da9b3cbefa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5Kdd+4n9hNFkzwYRmCCOjJVTl3BzvU1aYRg3nFskFtyVMIUuZe3g6GQmj+Bo0DH5DAobMd6xvi9R8pHnqm1SgT/zoblNdI7BCqr4/pa9CXv1F8URkh0OnSVZ0KeM2boB1vzhz4q8KWSu9OPKDka/uph2qaXirS/adz22sxuD7t6fF4ElLp+8icc8zoTNcTnsfuE7jv0/kH5LBbodTaK03AkOSHjU1YG8dB+CzrPEaNIPHYCf3HVw2rg/J/V/Q2PQKjFaAUOWu9fi1qeCAJ9g2A70qbM0bBADw7Us3AEY9iRzYfxC6ctDDYaZAAnDm3TxWxzWOPZ+JuBQmL2CjgG7cb+OGfTjhnIh47hjrh4Y6AISxNr5AD15PT/dg7BsgRak0Oac/18q+VgeK/dACbsA4moXYOYXuQtZCqvFA+3nq1/WOy8cwuE3U7L2vKhgfQWSY5yPK3KoPe0MIP7FJ5f3gRCMJz1uSrfmNVsKELqCe3MEyhJe7ofFdJ7RJnx99yG5WVsb4eyFAh7dQLjm/r1+D0UBnV4Lr3j8ktm4fnnFbIBEdSAbiV0O41fb1lcfq1b8cKh6LlCGiWG74IuQZjs++TR71+9NZbTYMIVo7UXPrCYSZ6vVMZW0b6eqsHuPlZfqGMxWRZ1DgE9tcErCTZoSNLjGtR8L/7fBUaE/cZZQHjowgVD7NXVoIzWjdgGksQSLHMjp5UAd8fmosj+EgAwexpcaJjIl7VMio2ffxq0QHfRVqjC9IaCqMh1d+BqX1immInlxpoyRVfw0x2Kfxi/Wg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(38100700002)(7416002)(122000001)(71200400001)(5660300002)(478600001)(55016003)(8936002)(41300700001)(86362001)(66476007)(66556008)(64756008)(66446008)(7696005)(53546011)(26005)(316002)(110136005)(52536014)(54906003)(186003)(38070700005)(76116006)(83380400001)(4326008)(66946007)(9686003)(6506007)(33656002)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pSYf5CWIZvE8+B/gHGBkCoNBPjPaCwXrt7SE+zDY23VN9INdrnf+vr5cINmx?=
 =?us-ascii?Q?3mxFoP8M/sN+47LYZ4R/gQnBB5REIG7Cm+h8bXqffYihdIjZehFn/+uQQMFg?=
 =?us-ascii?Q?Jq7D2XHWb981u1nw/0h2Q2yq0WMxkmSDVhZQpvSXxX3JNSqyekN2gRaHG/LX?=
 =?us-ascii?Q?15yQ6M/SAgrYkPTmL638He4NZxhFwe1qGQ+HN1cYzmrDSPrrK31vt/CY4nrk?=
 =?us-ascii?Q?CruQuzYjlfHlr8Y4HocW0LFeB5UpxueCbvOrsFxq0coZloemu2+rmhrQBotG?=
 =?us-ascii?Q?LL/Qz52L3SWJSujA69WiVx6h6McJ04BxDZqAlPO5U3EDSOb5mQIdw/fqwkYV?=
 =?us-ascii?Q?6LZvVpk2DPEXZZUILNtwtpwr7k9Jdfjrct4/oy8gRJ2tCK8Jtw92bGbIKXH0?=
 =?us-ascii?Q?1rcZXDhfZA8uZXAFRDiBf05lJtfcamBskS360FiIi/q7svvW8vkhXHDHX8Al?=
 =?us-ascii?Q?79n8fXsmjsA83tBq+LRaVEOw0of7mgOEjJnJFSCo8o97AjwxWiGpDB193A+g?=
 =?us-ascii?Q?4DWe/4U7lN2cmW85PHlOiTnC5sTGuCpZ+jaq2kif2lERppys+aAjHEAvdNt3?=
 =?us-ascii?Q?qRywH+UJsETvW0hTWdWafKE2LoUoO5OYkgaACfxd0EFghPxk3aJ5LG9UEwrT?=
 =?us-ascii?Q?jzQHg5EduUCPu5egT4Vgd6yTx+qZbQn+Xdy/Rf8PPBZIkLDGCLk6uGHnDEcm?=
 =?us-ascii?Q?5Rij0M6N7eePmrCWFueaX0idPm7WJS/9Gv9u6ZLYzLzwg0kZN0zadVwz+vcG?=
 =?us-ascii?Q?3V59SHg1peutq1O9K2iGQne4dOfs7BFrcgnI8SieTeq0OhddoSYWGOH7+wYs?=
 =?us-ascii?Q?gyEFcciOHpplFAIlUKcRTsOk2wvicqzCFKAfsTNgW5jQkC3Gsa5uNodJX/6i?=
 =?us-ascii?Q?WFkR9CUypzb05dx/un/7MHNg0TaWRKv7BEEgV75sMUSoXsLyz54xCveDgnlX?=
 =?us-ascii?Q?yWP3d9Sgpq7VEFaz3Tz8gCqBuLZSX7JbV0LGZWo4DAK4cSjvuRlDXPrFzX6d?=
 =?us-ascii?Q?86ytOV/tWFI7fvP89kWt4Gc1tWoZadoODkBL3PDlj8EW4GXRN/dFsA/5XpcQ?=
 =?us-ascii?Q?pv23glSN8VdHanW0WXeQc+9PgPk/UBTYnh3HxrfPUTlyEdz2YbFKV+qoBHSB?=
 =?us-ascii?Q?2xtks1WXAiJYP6zcLemW+WZ6gRI///DqaZekI+XBHHJjgRYA+qeFqtXZca8A?=
 =?us-ascii?Q?J/FztG+1Te6fdUuOwECkRkh6mCuKZ6Iln77X2w6thHUeuKW/QjJg9vJfDwUg?=
 =?us-ascii?Q?+SYiEIQPTBaOwHVK0SZhQBAfx0SULDOBFfQxxc8IChbqExS0LkrJAWE38ORr?=
 =?us-ascii?Q?GaOj+GGdLNZ7cmfEkGafFZS0o3XEVnJd7aU+/cveWrse/X2+D9cyh9hNLuvm?=
 =?us-ascii?Q?20QYpKT39JcGFDskZ/fZX9YJkkqHoXozKwD8UEVXsctsTYSXYoKVXDaHcnGd?=
 =?us-ascii?Q?iILYfw3+T8Azox4Mf67uJKn09eKw/EffYssqrNt+g+kwmpFv0BRIYr7EmbrQ?=
 =?us-ascii?Q?5DBKg1/KZoBDb34YrGNel0UEgOmlKPv4zIQLU4bDxou7EncR2bGBd/sxLyfm?=
 =?us-ascii?Q?UJVeceDl1R0v9X2QUqo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ac0e8-673b-43e7-cd94-08da9b3cbefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 19:17:23.0172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srYZwb/OUaYi+X49cmsYPeJxBlOIMmdEizgY65pvqCm2yjajQGXDRmwZ6G66bj3da7pNG/Tvlvxeeh3NKdyI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
Cc: "lulu@redhat.com" <lulu@redhat.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gdawar@xilinx.com" <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

Hi Jason,

> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, September 15, 2022 4:51 AM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> lulu@redhat.com; xieyongji@bytedance.com
> Subject: [PATCH 0/3] vdpa: device feature provisioning
> 
> Hi All:
> 
> Virtio features are neogiated between the device and the drivers. This allows
> the mediation layer like vDPA to hide some features from the driver to
> faciliate the cross vendor live migration:
> 
> vDPA on the source supports feature set X vDPA on the destination supports
> feature set Y
> 
> Management can simply provision the vDPA instance with features X&Y on
> both source and destination to let the vDPA can be migrate-able between
> the two vDPA devies with different features support.
> 
> This series tries to allow the device features to be provisioned via netlink to
> achieve this.
Very useful series.
Can you please add vdpa example command with and without -jp option in each of the commit logs?

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
