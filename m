Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAEBC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 13:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACFB540603;
	Wed,  8 Jun 2022 13:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mqJvzWVc4Q0O; Wed,  8 Jun 2022 13:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 18ABA40587;
	Wed,  8 Jun 2022 13:26:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC38BC0032;
	Wed,  8 Jun 2022 13:26:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E63BEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 13:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D45A440587
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 13:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d2ltElOkV21U
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 13:26:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::609])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4966D40002
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 13:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkP7iVMiewZz6BJn/+gY1IvScfduoofPihvvIOzRn4oeI3kCLVM9o8FD5UW+hd43Ayu+d+V/qbraKZApfLfgtqJxZb+gWdVHmh1INwEBtQ/Oj9fpEZqhNTQvYCHa2/QWxl1YmLoE4+LYzLE2Wi8ocWfE0xJ192mvmJQi4HV7JxxNfPKBpDZBkzLCGZub7mLImfPZVFQv9vMKpfbSDfD2Uvzm8ehmWo0xQcDhxJjagPIlYlUFz13HOtyUVBetpwrP0hBxlPn5xAJNXPaAtMcSJUQ/FzNPyJw52UQ4V6URCFu54eotDBy7xrYMLSzD4+UXkvJef5OrGIAWFLjDQtwoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3kok6TwRkWS7bXZfismBpqbuYV1+qfsbHmGIBcn+0Y=;
 b=a+crId1WG20XYlokEyXwhWKFG6t9QH42a9A8JLsf1b6jb1MNxuOiiaGWCHsidrZT/7aTD+ozBGarkOhohAdisfOM6k804zE879rSPVQLJwQqGCrnX3q3ea/4LkJGFoBu7b6psSMdByS/5lOCVDsUhBzR6Pjv4hLfjOuNx3pUy0esJ+B1pI1iwL9iGTHvtWCeUVfGa+HWONGcuUq+l58iajQKh6594950kakinBPmxzG91XP59HtvXyK2tyqls+7VEUcXGnz1LIYs2idbHdSleEg/brja78IYfc1Mu2lAN/sxMYeo+uYEQDQCpZAvCuQsxrUFF87p8+52gCI432cokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3kok6TwRkWS7bXZfismBpqbuYV1+qfsbHmGIBcn+0Y=;
 b=eFFYj7LxR3JnfPlWYBKCcrv6r02n3FsQniULnDUj2jn5QlVBaH7PEhjYZMqRQ01nf7H6mXy6AkRodczRmmdqbTPLSHvkj630EXeoY7g4D/CQ1jfFrUpS46xnzsUaB835dzIBfE8RCeb3hbFMRsZd1COokHBRYIN3OqIWdBJ9BSgxASZu2SCnWwj7/4uA0FYGMxwhMkufHagL1qFhCpEheI46N9SCW84NHLQUJayNGZJubm32Hg6JFXoaZaEyc9cN2wwgMj9gc5xZ2IslOoH/rkQbsmfRivMDPG/nUo33/U4M7okokEVSZ/9U5rPBOk0phI52JnaovMfv5riwakWtqw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 13:26:19 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 13:26:19 +0000
To: Yongji Xie <xieyongji@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Thread-Topic: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Thread-Index: AQHYWUS8lMTRd/0/2UqI8h//G1UzZa1FuoAAgAAJcAD////o4A==
Date: Wed, 8 Jun 2022 13:26:19 +0000
Message-ID: <PH0PR12MB54811B8F17B8964A53947465DCA49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426073656.229-1-xieyongji@bytedance.com>
 <YmeoSuMfsdVxuGlf@kroah.com> <20220608085133-mutt-send-email-mst@kernel.org>
 <CACycT3vjNwESmoAy14+NCGxHaXJtFq6ykHTkqcpm8nvb0=sbog@mail.gmail.com>
In-Reply-To: <CACycT3vjNwESmoAy14+NCGxHaXJtFq6ykHTkqcpm8nvb0=sbog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1595ffb5-5f6c-44af-dd15-08da49527909
x-ms-traffictypediagnostic: DM4PR12MB5296:EE_
x-microsoft-antispam-prvs: <DM4PR12MB52969E74A42D0CE04289A9CADCA49@DM4PR12MB5296.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uLIRkz8kIw9DqXFBgqMVM5DLGmPNegUHaPQ/vLUcz/z7yraIcx5U/RuUj1D59IwV9wjAYZDizUZeqP5RZzsnmMuII/gGRqG01ywNaP4vAvN5A0mYOKV60DWHlV5xM4LPL+Tw/EtmOe2mLEKIQ8A6DS2CVHsINUiq/0gBebNVBF66sIpzvIuTkt8UjyhbJjsWRidflP+wGcgqMeFmgFUQetzjXvY2CTJnWhIeOJ6k3MoSvgkfFWeJDKxvZiUKib5Ts5hsYI06wy2CPaYrTnnaFssOH+2vgQkCD5LPtHa3H3fZcWuHlnsuc/6zdNhvS+deaSRhF71oUZMJTIWV0DEOrOBr8zG9yESzFvbUHzXzY9XDnfbDas7pdj5mKAohNGnO9Z7HwbmKlWW1JzPHkh4DKVKWO4ltDzAHzAlCbCp9dPo3ykbloCh3tIOLUvlcyCoAweuu8FUk23z/XsnY1oLryW7Tju5BFiOecB/hFAzqr4EJUfU1RWE6U6a7WTZNcPzyKPU4dV2Lo8FF8UCL+rakFheCY+OKwn7n9c0Bfruv9KxekWc0CsdqsqCDElEqNpHFtnaVSau+9uys97uysN61UAq7dxJEzh2V9G1q/B/OLGwIKAEy9PC7k4AK8I9uKVnvWgYseP3xUTVdGFE3as75f2tNcExI9afgesd0lCI081xNDgGAL9swF2NsH3p8M3/p0BFZy4nG/kcua2kIaK43yX7Rtk8x4SNtxr0WObJVpcy5iqb88knbRSNkbc76EEoKFymZrtE7FNPbeLR0GC+LvIkt5aww+RppeBzLaecKSv0+bwedz1wfVnUqprtYPaBMWXaLaUfZ64zQIxb7YCZxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(52536014)(55016003)(66556008)(66946007)(66446008)(186003)(316002)(122000001)(8936002)(38070700005)(83380400001)(110136005)(9686003)(66476007)(54906003)(8676002)(38100700002)(33656002)(5660300002)(64756008)(2906002)(53546011)(6506007)(7696005)(86362001)(4326008)(76116006)(966005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzF1TzdtSUp2UWFEM1lZZGNBWnJUOUUrSzJxT3VWZlFISFhUNEErRlVMK2ZF?=
 =?utf-8?B?NSsrWjEwRGNwc2FrMHdsUGxmeTk3N3ZIV1Vtcml4bmZBelZzUzZSQVVBM3dG?=
 =?utf-8?B?a1BKUWl5RlpSSXdpamRlUXByMjhqK2h0UE85S2lOcTQ1dlViMlQzUEo4TDBs?=
 =?utf-8?B?Z0FiMVZBZTUvQTZjVlhZL0xFRnZIdnZrTnREbURqd1NndXR6ck9CYmR6QkZU?=
 =?utf-8?B?M3ZSRVpweERyS1BTdXlkRWhrWTdwc2k1cjI5RmhqNkpZSXpLRXp6bGJKTW92?=
 =?utf-8?B?UlF4Tk05RWc1a3JNeDNiQ3FyZEtQM01SSnhUWXMxeEZ3NmZqTEg3bjRORVB4?=
 =?utf-8?B?VDVYUzRSVUxMbFpVK1NnbjBqVmpYeXAramtobVppSXNxcHdtUHVSNUNsSTlC?=
 =?utf-8?B?cWNYVEhXWUpUU3VjVDVYTkRYaWlBUHZVazVGeHk5bFZMZVZEa0VOYTNZcUdG?=
 =?utf-8?B?cXR0bURQVkJwYTl4Y2tSMEhUVWRVMHFxdjVmWnVvQ0huQ1VEQ3hjY3JsSTAz?=
 =?utf-8?B?bkVoRFhaV0ZKNTJhUVZJVkFlSHhNUjNUZ3FHTkF0R3BCZzgwWWkwb1hsbjV6?=
 =?utf-8?B?SUZrYnk2SEhycUdDL1UxV3Y3MjYvdjhIcnFpRzVrOGoyNU51Q0JIOW8wZlN4?=
 =?utf-8?B?U0dRSVZZbWUvTlRtL2NhWlY2Z0c1RHpRV212OWhqYm5XUjQ3emZ3K3hKZDBQ?=
 =?utf-8?B?aVNVSi84bHY1QWFyUUxZRmJzdjFKOFZEbXAvOFBKOVpGRTFxZ1RYU0kvckds?=
 =?utf-8?B?ZTl4M09GR0tHcWlVNHpYOFNIQlJPR1FSazR0ZlhpVGsrbkZROUp2NHNpSTF4?=
 =?utf-8?B?TWIrYjRtemhsM2gyb0tFdmFZakNCcTB6ZWMrcXRac2xJWklheUkwbHBRbUdy?=
 =?utf-8?B?dFM1aHN3ZFhpQk4yMzdFNzdRR0FlLzVrVjlmb1p3ekFLUHVFQnNpeGY5OWlq?=
 =?utf-8?B?YW1qZE1zcGlwbFAvb2JCVUVzZWkxVC9XT2hwWFNsS0FySU5FT1hBWlBUSVdi?=
 =?utf-8?B?azNPV0VsajBzMnIydTI5K1hPVkRKb2JwQVU1SHlNdSt3YmR4dVFBSmEySGJW?=
 =?utf-8?B?M1k5VG5lUEkxdWJERnFNcVc2eWpwNE53WHRvaDNMQnB3YklpODZoL0hBaWZi?=
 =?utf-8?B?VitQSVFTaFZRSFowSUIxZjl1UGlMNysyNW9MbzRtUlRzR2FqYzU1b29mNUx2?=
 =?utf-8?B?dVhUNW5DbzdzcTdoT3hhelFOR3pHSEF2eHNRK3B1OTM4dWEwTE5Wbm5BRUht?=
 =?utf-8?B?WVd4ODdCckFvZVlGcmwxWUVDZWNEam1wcnluZmlsZnprRmpnY0xhZE5pVlRq?=
 =?utf-8?B?aENMeFJIdDVaQXVsbFNOWUk3Y2xxNnlzdEtxRU15dnErb2JHckozRUZ0bkZo?=
 =?utf-8?B?MzEzWkJ3UlpFSlVGbktFZ2lMeW5QMVJ0Y3VoZWcvV21KRCs0V1FxYTgyVGZI?=
 =?utf-8?B?ZkowZThLbjBINkFBQVN5bzErUld4YklDc0RZTE5yR2ZVSlBJd3FvY2ZSU1M4?=
 =?utf-8?B?NVl0dUc4cmtGT0ZVOXZGNlBINkY5UDFsSkluS1ZFUlh5bmJoM1oyVEVJNTFj?=
 =?utf-8?B?OVdTYWdzSWx4RTVONmhSc2RvQzRSZWdtS0VaWjJ1T21xNWFSS2E5cWdvaXlP?=
 =?utf-8?B?amtmTlBIZmhpc1UzSXltUzVTMEsrVVN3cW14dFJVNnFlZklWbDFicnpRbjY4?=
 =?utf-8?B?Nkhta0kveGJhN3RUVERkNmJaM295RzZWOFgzemZnNUFGVnhvZ0krM2puM3Iz?=
 =?utf-8?B?YzlmZTdDWkJrWU5JS21wa29YZzE2SWZpcW1jaXpKYWs2NklUS3VJMVFGRVho?=
 =?utf-8?B?cDlBZzdkWVdTTXRSRmg1S1dNNDRTYTlSWWxuOG5PR0tZcG9RaU8xQk14N056?=
 =?utf-8?B?MFprUVZjSVlzR1lWaVhBZURGbEdHZXkwVER6TkhtRmRKdmVCaVdEN1ZadjRF?=
 =?utf-8?B?M3dwTnpmdnYrRFpHNlVjK0hIZFlPMDBJUjJHRW5sK0pTb3Z1YktCcllVRjhY?=
 =?utf-8?B?Y3F6K3RNenNqZFFtTU9tWm45MXhVall0QnZBNTZvSmh1TkcvNTZYeTdRTllx?=
 =?utf-8?B?OUlEcHZKR0ZSUHR5bkVsNkRtcEwwbkkrT3pyNVlPSGJZdHN5aHhuNkJUZXdZ?=
 =?utf-8?B?TzRuTmd0a01EaDVqOWJDVzViQnh5MThUVkx5UW9LUUVERTA2RFVqU3k5Vng3?=
 =?utf-8?B?amlub0E4b1dKcU1IT1Q2a2tDL0ZhVVdaZlJOU2p5NmRmWkcxbVhMS1dUTUxU?=
 =?utf-8?B?L0dYQ2d3ZjV6TE02TU1TWWNpMnhoZ2h2U1crcDc3QlRyeDgrNjE4Z0NNai9D?=
 =?utf-8?B?czF3OTV0K0hvdXBJQVE5TnFFb1JWSmxnUm9QY0xDcVBKa0YxcTVxKzhDcnBG?=
 =?utf-8?Q?3rD7zvwMggy9yemmD8sQ88wzXssL0y08lyXm/PpeWfvef?=
x-ms-exchange-antispam-messagedata-1: dDB5sQX7FuXa4g==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1595ffb5-5f6c-44af-dd15-08da49527909
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 13:26:19.3019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0N9k57MYZPN4QRQclaONxEFR/SIlExWCVS/1oGFWodOz7n8mhHF+7d/3IUCRr6tUZVEZ2+bn6qX3pyODyzyOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 kernel test robot <oliver.sang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
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



> From: Yongji Xie <xieyongji@bytedance.com>
> Sent: Wednesday, June 8, 2022 9:26 AM
> 
> On Wed, Jun 8, 2022 at 8:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 10:07:38AM +0200, Greg KH wrote:
> > > On Tue, Apr 26, 2022 at 03:36:56PM +0800, Xie Yongji wrote:
> > > > The control device has no drvdata. So we will get a NULL pointer
> > > > dereference when accessing control device's msg_timeout attribute
> > > > via sysfs:
> > > >
> > > > [ 132.841881][ T3644] BUG: kernel NULL pointer dereference,
> > > > address: 00000000000000f8 [ 132.850619][ T3644] RIP:
> > > > 0010:msg_timeout_show (drivers/vdpa/vdpa_user/vduse_dev.c:1271)
> > > > [ 132.869447][ T3644] dev_attr_show (drivers/base/core.c:2094) [
> > > > 132.870215][ T3644] sysfs_kf_seq_show (fs/sysfs/file.c:59) [
> > > > 132.871164][ T3644] ? device_remove_bin_file
> > > > (drivers/base/core.c:2088) [ 132.872082][ T3644] kernfs_seq_show
> > > > (fs/kernfs/file.c:164) [ 132.872838][ T3644] seq_read_iter
> > > > (fs/seq_file.c:230) [ 132.873578][ T3644] ? __vmalloc_area_node
> > > > (mm/vmalloc.c:3041) [ 132.874532][ T3644] kernfs_fop_read_iter
> > > > (fs/kernfs/file.c:238) [ 132.875513][ T3644] __kernel_read
> > > > (fs/read_write.c:440 (discriminator 1)) [ 132.876319][ T3644]
> > > > kernel_read (fs/read_write.c:459) [ 132.877129][ T3644]
> > > > kernel_read_file (fs/kernel_read_file.c:94) [ 132.877978][ T3644]
> > > > kernel_read_file_from_fd (include/linux/file.h:45
> > > > fs/kernel_read_file.c:186) [ 132.879019][ T3644]
> > > > __do_sys_finit_module (kernel/module.c:4207) [ 132.879930][ T3644]
> > > > __ia32_sys_finit_module (kernel/module.c:4189) [ 132.880930][
> > > > T3644] do_int80_syscall_32 (arch/x86/entry/common.c:112
> > > > arch/x86/entry/common.c:132) [ 132.881847][ T3644]
> > > > entry_INT80_compat (arch/x86/entry/entry_64_compat.S:419)
> > > >
> > > > To fix it, don't create the unneeded attribute for control device
> > > > anymore.
> > > >
> > > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in
> > > > Userspace")
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index f85d1a08ed87..160e40d03084 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -1344,9 +1344,9 @@ static int vduse_create_dev(struct
> > > > vduse_dev_config *config,
> > > >
> > > >     dev->minor = ret;
> > > >     dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
> > > > -   dev->dev = device_create(vduse_class, NULL,
> > > > -                            MKDEV(MAJOR(vduse_major), dev->minor),
> > > > -                            dev, "%s", config->name);
> > > > +   dev->dev = device_create_with_groups(vduse_class, NULL,
> > > > +                           MKDEV(MAJOR(vduse_major), dev->minor),
> > > > +                           dev, vduse_dev_groups, "%s",
> > > > + config->name);
> > > >     if (IS_ERR(dev->dev)) {
> > > >             ret = PTR_ERR(dev->dev);
> > > >             goto err_dev;
> > > > @@ -1595,7 +1595,6 @@ static int vduse_init(void)
> > > >             return PTR_ERR(vduse_class);
> > > >
> > > >     vduse_class->devnode = vduse_devnode;
> > > > -   vduse_class->dev_groups = vduse_dev_groups;
> > >
> > > Ok, this looks much better.
> > >
> > > But wow, there are some problems in this code overall.  I see a
> > > number of flat-out-wrong things in there that should have been
> > > caught by code reviews.  Some examples:
> > >       - empty release() callbacks.  That is a huge sign the code
> > >         design is wrong and broken and you are just trying to make the
> > >         driver core quiet for some reason.  The documentation in the
> > >         kernel explains why this is not ok.
> > >       - __module_get(THIS_MODULE);  That's racy, buggy, and doesn't do
> > >         what you think it does.  Please never ever ever do that.  It
> > >         too is a sign of a broken design.
> > >       - no Documentation/ABI/ entries for the sysfs files here.  I
> > >         think it's burried in some other documentation file but that's
> > >         not the correct place for it and if you run scripts/get_abi.pl
> > >         with the code loaded it will rightly complain about this.
> > >
> > > Do you want to address these, or do you want patches for them?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > So, any patches?
> >
> 
> For empty release() callbacks, I think Parav is working on it based on the
> discussion [1]. I can help test and send the patch if Parav wants.
> 
As there are no more comments, I will send the patch for vduse this week based on [1] which was previously in email form.

> For Documentation, I have sent a patch [2].
> 
> [1] https://www.spinics.net/lists/linux-virtualization/msg56518.html
> [2]
> https://lore.kernel.org/all/CACGkMEuJeU6c1z8+_FqGtovbF+Sq8w_eQUcG8
> SHm_GXV5q7yNA@mail.gmail.com/
> 
> Thanks,
> Yongji
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
