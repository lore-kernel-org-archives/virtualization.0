Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDAACCA47B
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 00:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A81E840A42;
	Wed, 15 Jun 2022 00:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04ZndN5Bij4M; Wed, 15 Jun 2022 00:10:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0DF7E401F1;
	Wed, 15 Jun 2022 00:10:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE27CC0039;
	Wed, 15 Jun 2022 00:10:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA608C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0E7141869
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ev6XUUgF9ez9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:10:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C42841524
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 00:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljD9lo1huaF65N3ri5J9ousWDLOoQT864SisuMHYEiqohn+14/t8gmB+ZxwUt2OC6xS0OrTuuwLjJ4AKu0w/+6AtUZ7SkfFVws12dH1nMbSNroDLQjrgV08LGQgyPmXxRmmg9P9X4jd0o081idFsxozQXGmUlkGmA+/1vj1nh9/+nzJufq7SGCWkaSjZOTC0TS5FKBNItfUbmkOTtVtmHMO33uVM20M5XmnwcOrq2CHVovu8NiFW0PO7Vvv8fLd1TID17FVWmJ9mzwUE4omGHSv6tMNmxzh2yg2bmwTF64Bsf1AVyTnrJmuKteJFktSRH2UtviXbYAt2c/vd2Bn6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrQ/N03EJByYWySwcZQWizOfnr0zAj5MSvOnJI8m6Cw=;
 b=YNQB7unYGznrScSAMYSXnVwMUSqJRf843qTVlAxNuNioH6cdMOYykEPWipRmOxVBl48/rJ30iZOsWntw/jpWeD2Gta04OrOPwuNQVqn+3kmMZ33J/DunvdK8AOLvXS0UqnCcc0UbqTLv4iWtEP3AetVW84ZPoMC7IkQPytfZ18ganEKOiDCL+fAltV+0FvQ69st9OakXcMSOADM+SLtWk00TQSiSfB+MvP5ONpl6P1E+aT7ZeCgaT+jeKb4VcQcIlsxKYeYAT2DSQMpwgRw/fGBvzH0blan+V3/6+857YnIfXzb0zOfCNiiqlDrNNMXnjooTgbDA0mU3b92P4Syvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrQ/N03EJByYWySwcZQWizOfnr0zAj5MSvOnJI8m6Cw=;
 b=d6AYduUPKU02ib1NjoKWHrArBDY7Az+fIjDyyNQBtXjCDUq7M90UMcqSH/OxGNwGxDkJ4tdGtK0/iPiFba0eMsVdJ3/a0EUGS06EGKqvvEZNBY8LJqRO/e+Kl+DHPpRDVNjXSCmR5354d89BmD/RfwKfQW+/7OF3S4harL2/QuYLcUolyR4zGzkS63zC43virQmmP2QFugHfxclrmviynsT2P/RotWxNn9QycLdLVKwuLrRNb3sjzHqmmePVpOs8FbqM6aBEpJ4aNnwWMSaDPsLcHch2qowBKmAqDf0HcX4H21Hm4OK5Q2G0HjANVf2U5b16Ogu3qW7RQKPXxaUh7w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Wed, 15 Jun
 2022 00:10:06 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 00:10:06 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Topic: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Index: AQHYcP5BrBz66eonZEeOxjwIzt98aa0xHKkwgAFx+gCABD0SgIACqRJggABroACAAQ+R4IAAdxYAgAAMy4CAABLZgIAULSmg
Date: Wed, 15 Jun 2022 00:10:06 +0000
Message-ID: <PH0PR12MB5481994AF05D3B4999EC1F0EDCAD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
 <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
In-Reply-To: <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 674c09fa-493d-47b7-518f-08da4e636742
x-ms-traffictypediagnostic: SJ1PR12MB6289:EE_
x-microsoft-antispam-prvs: <SJ1PR12MB6289FF3A69D6B127716D77EBDCAD9@SJ1PR12MB6289.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nSvmL8ZcwEI5HnqEa6bqBazlHdxcihYZ4ZUUZi7jViztx0PO+LmbZtKpPRt2tKtBEbuGyUp686c/Ojx8S7puAAm6selEaOHK46hVIjgF87wcr99ZeatfUMIr5BVDHNqAeCtg9Wpp9+xzt03w0FHLM6m7VuteZWyzooe6aJstv1ObrnZJeLUUbpWW71/G2z0/bMcx4/wRGWRrA+I8TaptBUE6i5cr+SDpZHGF84xTGlDVL6LLoygxybPIAdgz4a6ReWCk/4D2xJDNENvbt1WxVQsQ+OWRhR3WrYaUkeNGBNf0k5eJVkzSbHTbm+979VaUPDiXwKPHWMyYsxBXFaE5I/PhNm60rT+WSM+8NBPP2x8q1kui/s2QReUKWLq6oHze5JYrp4MNhqkPqVn0pU4sA4ai1pG837qc6V9bax/EBsK+T722hzaUiNbu4ASldhdAIra9s1/QvuMYYHSZQZ93LGTWfj5lGYZE5J7ej3w8VJ5tstf9AGWP12Gxp3W2vmdLm2DBB8zzavUyi8KHeYZkDumePg4WMcMHGspF46ePM7325uwpOXJd2oLR9SjLh4e9a54OyRgRqWf+TTiDBiT5TqSHCVyymb/QdxEOIwhBw3+QIcW1EnABDdEgFJ9a0kVP8d1KYUE5dIxwWX9TmUd38Q471Jqtqa6Myx1gUE9kb0nqvvf65AKX8TImYMR5psz4fkraGJEHrCmNp9hbNg7rA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(186003)(5660300002)(7416002)(2906002)(83380400001)(38100700002)(71200400001)(54906003)(6916009)(508600001)(38070700005)(53546011)(64756008)(66946007)(9686003)(26005)(4326008)(6506007)(122000001)(33656002)(8936002)(7696005)(66476007)(76116006)(66556008)(52536014)(8676002)(316002)(55016003)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDlWZGRBY0kwL1lHemtBZGV4NG55R1RFU24yTS94WWorTlpFdE1RaUt5REFs?=
 =?utf-8?B?cEltZXYvcEM5K2NPVzY2MHFPeHZISmtTVE1aVG5saFo1Q0crVmJHby9TSENX?=
 =?utf-8?B?c0JycUxHblJJZ2VrMlhIOG40aTkyZ0FqRFRlM2lHS1VlYmw2TDU3Q29ua2hX?=
 =?utf-8?B?UDRqRmdwUGZZV0VScnFHaWtDRHdaRlg4UDJXZ2E4VXpnaXNOaE56SFRUMEhk?=
 =?utf-8?B?d2QvV1VvOVpnU21kVlJKVG1NNzNpKzhxVm1naTRkN0FjeVJ4dkd5M0d0Q2pu?=
 =?utf-8?B?b1hrNlQydzVCdnBTT2I4YnlRUUZ4V3hveUg2ZGorOEN5NnYwbnhaTkVxVzl6?=
 =?utf-8?B?WkppYlVTK0FablpuV1BTbzdLaW8vYXIrbFU1VkY0UlE5SUlEZjJiUVlUU1Jm?=
 =?utf-8?B?RUtCanBDZ256UlhXYlU3NG15LzVjMzlFWWEzZitaTUllNW0xOEV1akw0dE9H?=
 =?utf-8?B?VG5FWndrUzFkUnh1YnBodEZyRzRUbkxDd0d3Q3hTN2h5M1k5Z0RvNDJtMnkw?=
 =?utf-8?B?NGVJVTErTUQ3NmVOb2YySFFvNXBid08zNnRXQW1icEpTZkNpZXlzZWYrMHF1?=
 =?utf-8?B?cXZOMHFBSFBzNzdIS0E4aG4rK1NxVXE3RXNYMGExMjBJT2xqZzBOTkJRZjhB?=
 =?utf-8?B?ZFozckxaUExzMHB4UFprczZQRmgvNHg5QjBJeFRQQlBXYk50bmxBd214bUlU?=
 =?utf-8?B?QlNrVUttcmI3TTVZU09BdjJleWlRMmdRc2ZmV21DV0gySXVLdWxyZWRKRlh5?=
 =?utf-8?B?ejkwRnZ0Qmp6MUQvdzUvZjdMYmpEZWlaaU9QWFVqMTB2VjFLN3liWjB3d1VB?=
 =?utf-8?B?QUlHemEyTTRyTkFXellyOERrQ2pXd0h3OFlsbVFJLzlZWWJ1QVBQQVB4TTRN?=
 =?utf-8?B?bzZWYmV3RU56bUNjK0xobjlIRFBQZ1BEZ095bzAzWW5SQUFWSDJWMmY3S2Y2?=
 =?utf-8?B?aWdub1Q5dnhpQ2I2TGJNQytoSHlZRGNBaUpJb0VsL3JRblROVTRwTXV5L3Iz?=
 =?utf-8?B?bzM5ZlQ4UHlSSWQzcWJ0Q1BBTHdNTzBOMnpBWHUxbjBOWHh5RlZKOUJKVEZN?=
 =?utf-8?B?WGZmTlFIOStIQkRRTjN2N3lNMjdHTm1rQ1p0N2UyNFRRalN0ekh3QXRjT3VU?=
 =?utf-8?B?a0FsL1Q0bEw5MmtPVU5GNUt1bExrUjk3WWRTUzF0c3lxKzFzcy9UanN2N0Zs?=
 =?utf-8?B?Mzh5b3ZaRU5rbk0wQUN0V24zckJjTDFTWWF2NzJLdE02YzRoZ2FTVlNwZXI0?=
 =?utf-8?B?c2xaM1doRitaaTBkaVJUdzNmWkptQldFaFRlQ3ZoeDBQOTQ2bmZ2Smd3QkRx?=
 =?utf-8?B?NDZZdHpEZlpuekorT09EN2pGbzlxMitIdy9wOTIyMEVmU2pjUWNTb2xmZWhZ?=
 =?utf-8?B?cE01L1hKTFpGZzdIQWh3MEZ6Uy92YXM1ZDd6OU1FN0E3M2EvUWhHTHVxR0Zh?=
 =?utf-8?B?OEZkUHVKMnFMUldYZ0JXZEtiSHo3cFM1T0ZER1Z4RzlwNmIzU2hVL3ZjT1FD?=
 =?utf-8?B?ay9BaDhwcFZRZnNWRElzQzUzWXVmQmQ4ZDUzRW9sSjhLN0VvSEp2WTFDMENj?=
 =?utf-8?B?bnpOanR4L2ZIZkJwbi8xdldrK1RCY2VSOFFaVjI0NjhrNG8rTDN0R1hubWxY?=
 =?utf-8?B?ajl5NUJJTmU0VllMWWYyNmg1RWxaeVhndDB3b2ZZSjNTcTlIMkl5S3JzbGdC?=
 =?utf-8?B?N2xaT1dNQjVhWDJoMXZTWndiMWg1cGlrMXNSVUdab2hvN1Q4U2E4SXNiS21p?=
 =?utf-8?B?bkVvWGNYMTM0T2NuazdxYzMxSVJqRmxhR21zS0syNDJ3bTRJUHdWQ2pWeFh3?=
 =?utf-8?B?TUQweS9vakw5cmd6RmtPTnU2YytyUUs1NURIaVp5MWtHMW5TUU9YbTdBN2NN?=
 =?utf-8?B?YkdOdGlNOURUNkR0RGNtQlFDZ3BEeGllekNtMDBCWjFuRk9kU29WRUpxSUJT?=
 =?utf-8?B?eVJ0OEJjQnJuZStqSnBXa0w4Qy9mdThkOVh6dTY3MStPQzBMdGx0cjNOQU9T?=
 =?utf-8?B?Z0ZkTUVqaU9uTVI3ZENualM0M3JjVzRJdUtTUEk0WkxHQ0RJazVQUFRPV1Ri?=
 =?utf-8?B?cFdtbE1WeGJ3bUFBNndBTm1RZWZvYWhWS0tvM1FYa08zYndJSjZUR1BjQ0U4?=
 =?utf-8?B?VThwWnpKUitBRnFWT3RhK0dCdmYrNzIvTDZoTzg1Tk5CcEYrOEFkN2NOdkRE?=
 =?utf-8?B?eEtCWk1uVm9zaEIxcXk0S09LMHNJeWtaWmFSVXFzaWZlRUtFTGd0bzBza1Vz?=
 =?utf-8?B?MHF3dTMxRlpZZ2IvMW9EbWl0d2pLV245Q29ZbWpwUEdvcTRtWFc0Y2dwUmxX?=
 =?utf-8?Q?tPuAQphHCd2n8EP6Jz?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674c09fa-493d-47b7-518f-08da4e636742
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 00:10:06.6849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrTax0bw821yBX1AHfoOnZC5UsKC+VAXnba0LsX/UdSYqDgFzxOipwNZMAT/elqto28CDwjuDnEs5sAPVR22+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Wednesday, June 1, 2022 11:54 PM
> 
> On Thu, Jun 2, 2022 at 10:59 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Wednesday, June 1, 2022 10:00 PM
> > >
> > > On Thu, Jun 2, 2022 at 2:58 AM Parav Pandit <parav@nvidia.com> wrote:
> > > >
> > > >
> > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > Sent: Tuesday, May 31, 2022 10:42 PM
> > > > >
> > > > > Well, the ability to query the virtqueue state was proposed as
> > > > > another feature (Eugenio, please correct me). This should be
> > > > > sufficient for making virtio-net to be live migrated.
> > > > >
> > > > The device is stopped, it won't answer to this special vq config done
> here.
> > >
> > > This depends on the definition of the stop. Any query to the device
> > > state should be allowed otherwise it's meaningless for us.
> > >
> > > > Programming all of these using cfg registers doesn't scale for
> > > > on-chip
> > > memory and for the speed.
> > >
> > > Well, they are orthogonal and what I want to say is, we should first
> > > define the semantics of stop and state of the virtqueue.
> > >
> > > Such a facility could be accessed by either transport specific
> > > method or admin virtqueue, it totally depends on the hardware
> architecture of the vendor.
> > >
> > I find it hard to believe that a vendor can implement a CVQ but not AQ and
> chose to expose tens of hundreds of registers.
> > But maybe, it fits some specific hw.
> 
> You can have a look at the ifcvf dpdk driver as an example.
> 
Ifcvf is an example of using registers.
It is not an answer why AQ is hard for it. :)
virtio spec has definition of queue now and implementing yet another queue shouldn't be a problem.

So far no one seem to have problem with the additional queue.
So I take it as AQ is ok.

> But another thing that is unrelated to hardware architecture is the nesting
> support. Having admin virtqueue in a nesting environment looks like an
> overkill. Presenting a register in L1 and map it to L0's admin should be good
> enough.
So may be a optimized interface can be added that fits nested env.
At this point in time real users that we heard are interested in non-nested use cases. Let's enable them first.


> 
> >
> > I like to learn the advantages of such method other than simplicity.
> >
> > We can clearly that we are shifting away from such PCI registers with SIOV,
> IMS and other scalable solutions.
> > virtio drifting in reverse direction by introducing more registers as
> transport.
> > I expect it to an optional transport like AQ.
> 
> Actually, I had a proposal of using admin virtqueue as a transport, it's
> designed to be SIOV/IMS capable. And it's not hard to extend it with the
> state/stop support etc.
> 
> >
> > > >
> > > > Next would be to program hundreds of statistics of the 64 VQs
> > > > through a
> > > giant PCI config space register in some busy polling scheme.
> > >
> > > We don't need giant config space, and this method has been
> > > implemented by some vDPA vendors.
> > >
> > There are tens of 64-bit counters per VQs. These needs to programmed on
> destination side.
> > Programming these via registers requires exposing them on the registers.
> > In one of the proposals, I see them being queried via CVQ from the device.
> 
> I didn't see a proposal like this. And I don't think querying general virtio state
> like idx with a device specific CVQ is a good design.
> 
My example was not for the idx. But for VQ statistics that is queried via CVQ.

> >
> > Programming them via cfg registers requires large cfg space or synchronous
> programming until receiving ACK from it.
> > This means one entry at a time...
> >
> > Programming them via CVQ needs replicate and align cmd values etc on all
> device types. All duplicate and hard to maintain.
> >
> >
> > > >
> > > > I can clearly see how all these are inefficient for faster LM.
> > > > We need an efficient AQ to proceed with at minimum.
> > >
> > > I'm fine with admin virtqueue, but the stop and state are orthogonal to
> that.
> > > And using admin virtqueue for stop/state will be more natural if we
> > > use admin virtqueue as a transport.
> > Ok.
> > We should have defined it bit earlier that all vendors can use. :(
> 
> I agree.

I remember few months back, you acked in the weekly meeting that TC has approved the AQ direction.
And we are still in this circle of debating the AQ.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
