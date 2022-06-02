Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EE6CCA473
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 02:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCE60814B8;
	Thu,  2 Jun 2022 02:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fcBjtsl8FyYO; Thu,  2 Jun 2022 02:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3483B8145F;
	Thu,  2 Jun 2022 02:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD0B4C0032;
	Thu,  2 Jun 2022 02:59:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 570BBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F45D81494
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D6Z9yRfLYMUL
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:59:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::626])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D71568145F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 02:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N70oW/sY6ZDdbmDKs/1bZdCH1asnSGXLkg1pcRpCwBQgg2UKpRyKUaH785MFRpHLcUr5w8Ya+xMHiHD0sQ/R+0zJexMGtK57ngIiy6Zd9eAhJUzTo4z47gaXjeGr18LA4Oq0MXfBGYI1Y2P/rutI2SZAPaHGEpqUdL6eLxPPYL7IVGgswvHNha9P5FuRZ6gSqADnkdop7iO59kA2XwuM17xQ6zE3Hh9I1Fy7pNQCH9pxpV/Sb63jh/kG6ghL3O/RCENpr7OKPtmUYc1isuTwlu1JjgNuhjxNty+opm2IhyOz+kujxx/lc5YK6/nUAsNPVjRwZZVBfJajDY8INtvh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+slrO032YEnoCC2glZaak06dHkUt1m1OfWkplY9RO8=;
 b=H0kwqwkNF1wrwVh47h40glZrL0jK3zMj4VaVb/3nT2tu+7tGTyRuWC/5ltrnK78uYygoWZkfyMQqGxHdNhyUWZoV7EHLZC66ylg8a19G14TpRcODuKyNgXbL+4krlMLszvxMcJShKalK+fR2rxj9EVYRFlW+uVjl5518uGeHPPin/yaDd1jU9ljPbr5F6Qgyl2WySl5mFwKPpq/nrrdJ/KlnWT2EDkg7bf/wVLOSwKAJ2e0/ZiNC4KvdQxUaFJ/xgMfQgXWl3y0Ar0j/9Z6XJpLBJg+vhZzb0Q/h5RnXna+0paBAaQxcVmVjFakSeh6UK7jjLDUy2tEbkaGhOdJHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+slrO032YEnoCC2glZaak06dHkUt1m1OfWkplY9RO8=;
 b=jXrmcsXSyMqUyv4eE3ToMIoo3ObB+C6ghwLhHJaUS2oLzCKCS8eZKTjQO8XIowk4cR0KqZcfOqcUYdiJVYLH39ZoqEEarRkwyjeDa1oGddUrI5zNHJiCzF6xH09R4NYhrjETZLNjrq1ZcF/0r0xg15OlKtHChEBExoLlavubGyEI5sin4WRomZYoKBX2LwBdMDIrPo7tROyAJ2mwd3isCRYTqW7RSYOFu+1X/21m7F4pCZKQFCnqtk4uTpBF0Fynd5Cawdk9ZQwwIie/+f4OjYwR1VrmQU8/IOyjcetet5psohxy1fF5+ujMpadU+lxqbGonKr5ee8FO6s6UfAdmQg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 2 Jun
 2022 02:59:01 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 02:59:01 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Topic: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Index: AQHYcP5BrBz66eonZEeOxjwIzt98aa0xHKkwgAFx+gCABD0SgIACqRJggABroACAAQ+R4IAAdxYAgAAMy4A=
Date: Thu, 2 Jun 2022 02:59:01 +0000
Message-ID: <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
In-Reply-To: <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2692335d-70bc-40a3-6cae-08da4443d886
x-ms-traffictypediagnostic: BY5PR12MB4034:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4034EB84EE6FCD09FE76C17FDCDE9@BY5PR12MB4034.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIpnup9NqA7iE45ch7wnbe/bzbtlO9Ii09Eaap0kO83tZYkfN3om2EiusXACGVjPNPu4+AdA8zcw3vinQgy55/0f7NOyjaRvZh6AfZa/PikQgqRebE4BM8G6cQVUvBU4LkYkP/hjgNyvULD1M84ccSv0vMpCR+oQ8E0IEF/y71TISMnsEnx7W4xVsTmWgTaTEMkCE1VEwu8idRxnn1ivt4qe6SrS63/BCkg4y7INNr0siC02kw+JNkYh5efdBKaFzhBAJNTD1LUTEH/PnSHNXpcuIOxi0bJb/qRyAME8WiVFEDmiprgE9J2rUCl4XLIDPkistwhWC9DFPT/rrhITxTUj4998YTWrjMn/AUDvgW/Zd7M4ps/LdijH0K8Ol1l89H2VDbCWLBp3bJjHUhVTqhsCgFDBzdDUtj/cuLKpsq3sG87FHQFnUKuP/Gnpt2rzu8fQM2QqEVLimA+TNptOkMNHjkK/BEwBOKBGFqpk5CaFTYzRmGqvCIw/8RO/CFYK+B4ojl8sGHTFNWcU5meMWpydpersGGiHDKRP2glNO+5rK5YMAZdtin8OnoExRxtUCNZbASlC1EeoEK17vzs0dvCYIuoNxe4+bD3WdFyD5t0OCij3nkjOmWnCxRF8uumHyC1Bq20mLV8e1m53Prn9qMv28yese3SxGAx+Dem7Dk1oPbHWLfNrWxfeRp+ItMpeJsnLo17+ok1f0lZAiRe08A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(71200400001)(66446008)(64756008)(6916009)(86362001)(83380400001)(316002)(54906003)(76116006)(7696005)(122000001)(8676002)(4326008)(66556008)(66476007)(33656002)(6506007)(66946007)(8936002)(9686003)(52536014)(38100700002)(53546011)(26005)(186003)(38070700005)(55016003)(2906002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5UTjU5WHRjWm52N2ZhZ3c1SGNWNTFZTldPNWNzVGJtV0FzNEtSOVVTS2R3?=
 =?utf-8?B?KzgwaGFXSjJkTG1PSEVIWXY5OHR2cDFoV1M3ZCt2U25BSDQxWkxlU3paNDAz?=
 =?utf-8?B?bzhYNE1IUUNVakh4REkxNGczelczTEpQejlKR3RSTVZWMDZyenpPM204czVU?=
 =?utf-8?B?YThKZ2tTNVlua0tEbmgwQlQ3aWtRei9ScU5vamJwUTJIWi9RQVFNdUUxbGEy?=
 =?utf-8?B?TktVQzV2WWluaDNidDNGaXVnUlowU3hNTkMrcEZGbGxYTFhiWkRtZVFDVGpF?=
 =?utf-8?B?Y1hmZ21FaGNqYjV6N25yQktFS1lJY1dXWURqZ3ZHc0RoQ0VsY0hwWmUxbVdQ?=
 =?utf-8?B?Q0lCTFFJa1V0eHAva1Z4TEJOWUptNnpUdWkyRk5zSmNRY2dWWkhHbi9sYlB0?=
 =?utf-8?B?dXlha3psQkZ3YUphbHRFNEVwK2NNTFNnZ0lXY3RDUmlGQlhOMjlUWGJwd2ZX?=
 =?utf-8?B?TkkvL2lodnpiWTBEVFNHYnA5RUlqK3lFbDNxd2Y5U1Nva0FwaE9HNTBNRXRm?=
 =?utf-8?B?a05ZczBmRHFDYmovR3JhMkFKQnNXaEZpbitUSFdrRlRzRHVNM0EvMXJxMkVL?=
 =?utf-8?B?dU41SnZnR1VWWTVHUWMwSzVkVVhMUGdDWDExTklJVXRsMzh3Y1kzL1JxNW1r?=
 =?utf-8?B?WVJkTzNKWnlHZ2VnRlFwbDVWeDdlR25QZWlvSzZaMlBmWFFFbkdPUU16cG1R?=
 =?utf-8?B?MHVnSmE2SUlzeUN0TW1sZG9DSks5bDc4YXNDOU5hV1ZsMEdiWUVVRWlyenFn?=
 =?utf-8?B?YmlRMWtIQ3RSdThMN0M2MDZGODhCL0RwMW9HOFQ1bTlLZ0lRRkZpeUl6ajdN?=
 =?utf-8?B?aUY1WEc5K3dsOEpSZ21MWTRGN2dtZWc2KzRjU0xLZ2FRcWljejVvbGdBVmU4?=
 =?utf-8?B?cXEwRHdnb0dad2Z4MkhoMzZraUlWQ0lwVWIzM2ZxaVhnejd6US9ML3c5czdY?=
 =?utf-8?B?QjlJb2UzVTVWREpZYUJ5TnZPQXBBaEd5TFpXQ2NYNk5DeUxxVkZjT3VOM3ox?=
 =?utf-8?B?SGM0b2VIRjl4d0VoOVYwQXN6d1k3dkZlRDZKVnNpQU9SOHNiaUs3MWhaOUQx?=
 =?utf-8?B?NDRFYmwwbk9CblZieUwwTy9JdHBYQWFTaThCSCs1Mk5hVkx6bjJRcWF3VDdB?=
 =?utf-8?B?S0pXM3ZJeEV4aWFrTTltNUNvdEhvU3hKMmUzdWI2Y2xWa1lPazZBeUVZbGRC?=
 =?utf-8?B?TFlQMytFSlUxTHJhcHlnSjlSQ0ZqR3phUFFrdVRhQlhsTVlkc24vODI1TUFR?=
 =?utf-8?B?a3R2bnI1Y2NSR3djQ0ZheUNoekxEb2xNdzZBV0JmVEN5OXY0N091QitzVGJn?=
 =?utf-8?B?ZWZyZG5iVUc4UHhDczN0NWVKMEtFZmRzWW9LNEkyNmpSb25xVjRzQlZZRktD?=
 =?utf-8?B?SU14WGRFSk0zNUh0eDlxSXB5ekJoeVFlTGtvOWJKS1ZHb040RnhqQ1AwT20r?=
 =?utf-8?B?ZHE5a0kzdkVqYlllejBGdmZzc1RCZHdFNTdvckdMV0dYU1ovMVYreTdkOG9t?=
 =?utf-8?B?SllBT2xuQ29JTFZ4bkY3UWRlMUprcjVEcFhpRU91YWpINndYZm8yN1I4b0l3?=
 =?utf-8?B?eFFTMkhMVDA0YTVuVXBEdEIrYi9UV3E2ZU1KRUVlM2NQTVFORzlWT1M1WkZT?=
 =?utf-8?B?VmpCQzh4ODhmSCsxM0J0QUVvOWJLTHJUajZldVZQSzVPaGRRbXl2UkVKdjZi?=
 =?utf-8?B?ekZ2aDJQcmp5NDgvMmhXczhrSmxET3ZCM3pxbmRhUThzK1BqQzJ4M1hCaHlx?=
 =?utf-8?B?RTJPT2NvZWVtTUNrUzFISC8vb0RUdHRIczdwd0dFR2s5eEZJejlsNys5MEYv?=
 =?utf-8?B?MUFOTER1a2FhZFI2UTJRdjRBM0FIeGY4cTM1Zmh4RnNhV2c2VC9ZRkxZMzB5?=
 =?utf-8?B?Y1VubWl2RldBMWI5NVVFTng3cW5xK2tZb1MyN1JNUC9FblVlOUhHcmRZbVZE?=
 =?utf-8?B?L2l1QmcrRGg1b3IyT2lMM1NGeXlVc0tKcFFEUDZub3VrMFlPNDF6VWpoc2xt?=
 =?utf-8?B?ZERTLzJMbnRTTlpENlowK1l2ZjZCcmhwY0V4bWJrUmhlNkloVFVjQ2VFK2VR?=
 =?utf-8?B?M0laVHc2VzN1bG80aWpOVy9USk0yK3lOa1djRzRjSi9NS3gzWkZsQTdEbWlY?=
 =?utf-8?B?eDJBVU5aOTczMDA1aEtyQ0tnS25kY1FNMXVNTG01LzdTNDFlbjd5SDJlY0RT?=
 =?utf-8?B?clZsSDBnLyt3SElrdUlpRTBiOG9WUjUzYkx6amVrNFpHYXU5UXNaY0hvdzFG?=
 =?utf-8?B?dGNqSWNDUFo5aWJwbW9Ybm0rYmlvL1Z2eFRZUC9RNjZtOEVKaHhrTU1YdExT?=
 =?utf-8?B?WTdCVFllKzRDbDFPT1BQR1FoUUxtQW10QVNzOGc2Nk8xUjhKblBqdz09?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2692335d-70bc-40a3-6cae-08da4443d886
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 02:59:01.2220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFUdxBFR4vqsZ3K0m8gbO8M7cnEYtB0oYuCowCGoQp3sKk+10xYz0yzXJMnXKHNBDt2j5olbgt83ei42sVSfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
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
> Sent: Wednesday, June 1, 2022 10:00 PM
> 
> On Thu, Jun 2, 2022 at 2:58 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Tuesday, May 31, 2022 10:42 PM
> > >
> > > Well, the ability to query the virtqueue state was proposed as
> > > another feature (Eugenio, please correct me). This should be
> > > sufficient for making virtio-net to be live migrated.
> > >
> > The device is stopped, it won't answer to this special vq config done here.
> 
> This depends on the definition of the stop. Any query to the device state
> should be allowed otherwise it's meaningless for us.
> 
> > Programming all of these using cfg registers doesn't scale for on-chip
> memory and for the speed.
> 
> Well, they are orthogonal and what I want to say is, we should first define
> the semantics of stop and state of the virtqueue.
> 
> Such a facility could be accessed by either transport specific method or admin
> virtqueue, it totally depends on the hardware architecture of the vendor.
> 
I find it hard to believe that a vendor can implement a CVQ but not AQ and chose to expose tens of hundreds of registers.
But maybe, it fits some specific hw.

I like to learn the advantages of such method other than simplicity.

We can clearly that we are shifting away from such PCI registers with SIOV, IMS and other scalable solutions.
virtio drifting in reverse direction by introducing more registers as transport.
I expect it to an optional transport like AQ.

> >
> > Next would be to program hundreds of statistics of the 64 VQs through a
> giant PCI config space register in some busy polling scheme.
> 
> We don't need giant config space, and this method has been implemented
> by some vDPA vendors.
> 
There are tens of 64-bit counters per VQs. These needs to programmed on destination side.
Programming these via registers requires exposing them on the registers.
In one of the proposals, I see them being queried via CVQ from the device.

Programming them via cfg registers requires large cfg space or synchronous programming until receiving ACK from it.
This means one entry at a time...

Programming them via CVQ needs replicate and align cmd values etc on all device types. All duplicate and hard to maintain.


> >
> > I can clearly see how all these are inefficient for faster LM.
> > We need an efficient AQ to proceed with at minimum.
> 
> I'm fine with admin virtqueue, but the stop and state are orthogonal to that.
> And using admin virtqueue for stop/state will be more natural if we use
> admin virtqueue as a transport.
Ok.
We should have defined it bit earlier that all vendors can use. :(
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
