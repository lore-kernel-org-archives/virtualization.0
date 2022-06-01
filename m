Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74886C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Jun 2022 19:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDFFA4189E;
	Wed,  1 Jun 2022 19:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1SEXU-DqV-1; Wed,  1 Jun 2022 19:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E75B44186C;
	Wed,  1 Jun 2022 19:30:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B82B2C0039;
	Wed,  1 Jun 2022 19:30:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2465C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 19:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D473818E6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 19:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YFPoSWNHTpgK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 19:30:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A4DE818CA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 19:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ade78DQAw9LHtuON8CZwoc45S+6bTl/KjADCM4uaVMzJQS377dTE9eizUXBiTtEoQvFB5X+9cBiBKXawO7zV4p/6xIrOJ9+XZMzZtzZJI7Cyg5ESgB57Bzn5BE+imqm1opsY5QqBFsTG5P5p26J7le3x9wd8l6IWjZiMgLDaCZ7wstV+ado/02MJGlvVdKWu7FVoLMtNMmFll+J7Wqake2jACQziZIP2R229kREuhIIdhXXmTPSjN9vgryWdQFQ/T/CuCqQN3wro5+xwMPrsHCUdZr/pRoo+9BRG7H9qLSj9DXmWiWN8GeCmfzE1yxUKmdmvNy26F3kwsOaNr3og1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOi5gE4JGz7wt/S10r9yT1vkI9PFr/Q8HjucJesFT4w=;
 b=IP12MDIVeHu4375S9KSMLOCnb9pUwLv1TdM1eEnQ5h4Y46evnm7/fu/oEEjyRv4EHWKtzWwYLV/+xYJfl6DrrXof22TSJLwMmn7no6UqZE2JBz1jzFCoIStVy03VL1sTPk7/ZK0mJiQCopC3q8qnDP0AxJqjAKdUp0jKV9/XEoLS1xGtO5i2+OBfuUmAKF7oPk/QPsyYs7MaYEedt6qoVnW60Y+WrM2YGrtVYFnDEdJyAlr1LLNKuQzsuMx0GSiu3OUgahwFKzDy1rDufsjNGMDHeEbrS3//5yuf9bnfBsug4fYSo7SCIq++COpbFvQanqnMTBV6MBHVPhA+MemS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOi5gE4JGz7wt/S10r9yT1vkI9PFr/Q8HjucJesFT4w=;
 b=fRBYy4yBmcNJlAAutibmlAgh5nAIMgvYDuEpt9qtu9scYKhZr4xAcKTn/xLkaKYU4qLPJBwwlhITRn9bfiAFw0y4Vt3XB3qPcf4B8kU4TcbIROc+wFz23EsW5xHcD6JkLWANjpAqwlobQ6Yip4k6HMOfaCvLM1sZ5wbjEYyiN5sSL2ZIoA9N6Q7iNrrVA2CVkViinE9hqtf95rzzSRIzGeuFYhpJR/LmZxwn8JzbIhYWwcg7u5V+k7pirq/9DMQ4R3QT0kyAom2pu1pUNwAW7K9UHoJQ68d2xhg87bCdDGBFin1eo1glwPyT6aqTn+/yAaZAaAV4Cs2VCI+cy1HnLw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 19:30:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 19:30:08 +0000
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: RE: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Topic: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Index: AQHYcP5BrBz66eonZEeOxjwIzt98aa0xHKkwgAFx+gCABD0SgIACqRJggADjAwCAAKFokA==
Date: Wed, 1 Jun 2022 19:30:07 +0000
Message-ID: <PH0PR12MB5481DFD45D7B27A4E4783B8BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJaqyWe7YFM0anKLJvvRja-EJW5bwmb1gMGXnC62LVMKrSn3sw@mail.gmail.com>
In-Reply-To: <CAJaqyWe7YFM0anKLJvvRja-EJW5bwmb1gMGXnC62LVMKrSn3sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9fd2d7a-c6d0-47a6-a170-08da44052316
x-ms-traffictypediagnostic: DM6PR12MB4370:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4370676E5466D7A8D98963CADCDF9@DM6PR12MB4370.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYUpgvGd5fsE7wEJuZoBdU4H7b3oJqe2VEXBwYGNjWMp9mYw7Iw83VW81ggxXmqeHKyCoR+dpyeF65g6RQTOBUvStc54Eir+1fpx5ms9xhnxCeVB5wFF3NNdAGEjHVX0YQufoG5QUnkIiVj3M+Fs25cnZXaoxO5qVD/0R81otF2UrME1aD1eELBQmSJMkLBCmV5P8Hp0mcgiCj+jgT0a5UyaGQL1bWkb4DZJ3KKr2WhEPPuGitlsmoY4qUfI3H1kNoehS1dNtH2xr6AdLdpBTm3h1B+uHj+bWH1oeXCs2SXmLYwjlalkpe3QfVKyx+sFVoquj3fPirruD79IufTa4Xb7SjE9YC+6g05mzDNb9mCtek/UxXMw7ij6uQX0IeijvOG79wFRvBQivz+MxQrWjrmlAApkfL8Gw04i99S2FepdABWAEn5E9Myd2QUnGeQ+OMrcQSxxQVOAJLlfzCH21F3gO/7izTi0vmSH2dpU3WMnI2tmqejEVez2dbzomJmjBcl+413WoaBsnp8vHDx7Yrdte43TXPhnuJ97u3IAd2gz00yqoXAd3FZrdZm5Svt295iAGP+BXodrpnWUBcRFWaPktkCCifmMucLJp9sKn5C9p8wiCnd2cNZleftznfExFvYfxe2j8CeHXCvRtNGa7wDBSOztW9sKJyvP3JaahFHw37n5X/4XJeOCnVi9SU5rCY33EjaUoxED11io5KJJ4UQhuTXglPqFzg6sP9Rll804W5FNWLIzpOFPy7DJ0+8imxgswzc6fL3LrU3VESRMEZihHVFD4cfDGOsKCH8SjIw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66556008)(7416002)(53546011)(5660300002)(33656002)(66946007)(6506007)(86362001)(52536014)(7696005)(966005)(9686003)(2906002)(508600001)(122000001)(66574015)(71200400001)(38100700002)(55016003)(186003)(83380400001)(38070700005)(6916009)(54906003)(8676002)(4326008)(316002)(66446008)(76116006)(66476007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2J0bWFaK3l1Q0UvaEZEdHF6VXFQMXJmcGx6UDR2aWtkSUxEUEFSVCtFQXE2?=
 =?utf-8?B?VWkwN3hyVHlkaXRZdVZVL1JiRUg4RHRnVlRjNVJuaHh5QVg2aGgxZXlSbWwz?=
 =?utf-8?B?ZWxaYTdSK1FJdzVrNkI3N1ZUUm8wUmhodFdzQ3VKWEZqdjNZWWNVcEwrUVFI?=
 =?utf-8?B?blM5dUJzU2xrUUxFd0h1YWZtZm9YYys3dXFYOFR5Z0RVOTR1L1JEMFZOcHNR?=
 =?utf-8?B?ZGRsSzFFSEpTRFhEU0FuazgyRzc0aGFJeWE5K3AzaXIzZGZWYmxacEFtZ05i?=
 =?utf-8?B?bVRSaDYzLzl2TnpLNkJiSHRlK1NFMzd2WVBQeTdhd0NNS2ZDTTNqVVlrTktY?=
 =?utf-8?B?eGkwdVpXNFJ4YnpMZFFvUUwzQWljUVdYQTk5UjFnSEFuYjd5WS9IMjVBWitS?=
 =?utf-8?B?UzRnUXZSVHJ6SGxaRGpiK3NIaEttbTNSTS95RFk1Z3F5WEFhQWpJZWtWQ1FG?=
 =?utf-8?B?WUJ3SjZLcVBtSTFVRDYvL2VIbWNaS2RYUGdrd0RDblYzN2M2MC9hRVAzSm4v?=
 =?utf-8?B?T1U0TDd1SC9GbEk5QTBHNW5HdVlSR2ZTQnpzZ1NMK2VPUUZuUFJHODRUT1Ra?=
 =?utf-8?B?SXh5Z2tPWEN4TVFmdm1OSFB5VHEyYy9QMk8rRG0wa3htUmNOdlFjcDVuNHkv?=
 =?utf-8?B?SThkRndpWWkxWVlUUXpXQ2JINlNRVTZjR3lxOGJEWitEbnBkc1VZcE5XVU9S?=
 =?utf-8?B?TDZKaHJSdndiY2dPS0VNU0lmcVFXdlNLdEliUXo2MlBTNjFIMmRYNnpVdHh2?=
 =?utf-8?B?WWg0MnBDTHZhMUdXeTRQL2ZDOFBTanBXNFAxa0x5alREdm5iakJtVUxXUWRL?=
 =?utf-8?B?dkZvNVM2VHBMVlkyZXhFazFBMklrRGFQcnc0emtKMXpjc05MZFZEMkNLZUkz?=
 =?utf-8?B?dmd0aExzMlJNRHRRUko4dTBRemMwRXpGZHRZUkFtVnBJaUlVZm9LNHN3MWUz?=
 =?utf-8?B?VWl5ZytUK3ExMVlPanJnTjZKVGl3b3g3TlN3MGpWOE0vUjNGT0k0QWUzSDkx?=
 =?utf-8?B?cGc2Tm8xRVVlTk8rY1o4dCtGYXZxSFNueHVydUcvZk5sR2c5SEhqTTVEUzlj?=
 =?utf-8?B?cVJkNzJ4TDd0Um9EMnlJWEJMVlpLenZaN29IMld3L0IyTG5TZWwyNkhlOUtG?=
 =?utf-8?B?ZUEvTDA3YlFtYnFoNUk2d2dHamtxRWlzYU9FWE1ITFZOaDNmUGFOMi9tQ1Ro?=
 =?utf-8?B?aU1oY2p2R3V0RWNGd2x0eWZTUFdFS3RsN09ZdlQxRUMzdUVxNE55RVJKUk0v?=
 =?utf-8?B?Y2k2dUpQNnZ0eUF4S0g0cERTUmdHRERCTXp3QjJxYkhuOVAxSkdob2VWM0xk?=
 =?utf-8?B?RmlRU3lCMzZiakt5Umx6bmN1TEx0YzlBKzNQWG85QWRxdXdlOFMvMnJhUTlh?=
 =?utf-8?B?Y0pvd29pdmpjK3NTTTBHUWE3OW02bEx5L21GOEdzY1E1SVRmMGtaaFlhcVBl?=
 =?utf-8?B?YnVscFp4WjVvc3FTTy9SbmpvTTZ1cmUrZzdjMDZ2M0xJQXM2RWU5bFdreWRr?=
 =?utf-8?B?K3J3VlBPQ1pOOVR4dmI3ZTFjSHJaTXRpVXRZUjl3eHR5YWh1VFpCb3dDQ3lY?=
 =?utf-8?B?YmR0ZXB6a1FTZWY4c2pwS0VVdlBBRS9kR3VXY2tXaGFFeGh1Zzc2V0xkaVZY?=
 =?utf-8?B?OVRTYVVhVndLdFdkKzVXR0o4YXkyY2FFN210T1B0eDlTWVFCcTVkSVNkYmhD?=
 =?utf-8?B?dkNiL3c0NEJJSnNIYm44d3h0cjdCS3pQekRaaTNvcW9UMnRZODFaemlmcXZQ?=
 =?utf-8?B?N1VsQ3dkU052SVdhdVMzRXVsNW55WG8yeWpQN2tyZVNVdW9IWVpMVE9TY0I2?=
 =?utf-8?B?U1ZOa3hRQmhQbVUxTjdPblhiNWRGS2YxNm1ybjRvWHlEeUl4YUVUOVdUVERU?=
 =?utf-8?B?L2tSenhLVWVmUFpxc1lvT1FQUWZ2TDVMY2d1QXJvYjVPdUhRWEoxZGxkeGxG?=
 =?utf-8?B?RDY1NVFCYUpPbE5vMnl0MXhMM21xNm9YbUcwYmhUbkdtN29vY0drNWIvc2Uz?=
 =?utf-8?B?YzRhZE5hbmxDMmhzYk1kTG9SeGR3SUpVZDJzZnZoS1RWNGVIaitCSWxESmJG?=
 =?utf-8?B?RE5FcHZqOGZ0V1lMVForVmNpd1dadDRpTXRuZUxDWUpGTlFzMUk3NjZadEJi?=
 =?utf-8?B?NUxvREU3YXJKNVowZE1neVhpSDF3bDlZb0xlVnlyNTdnZzFUQW1Jb0FZbno2?=
 =?utf-8?B?cHJ4dHNJY08rTVNENmthREpDMXFCUWxBTHZqc21udjd2T0FEdWkvYU1pQjdP?=
 =?utf-8?B?TnZOOHVxZ1ZESFFRZ2NNbm9uNHVyY1ppRGc4R3pGeWpVTjNhbVpsWlN0UlU0?=
 =?utf-8?B?a1FIeE5aWVN0TE5sNklXNEpkZExnc1BOWjdyTGVRWkxpMHYwcXllVTRTTXFC?=
 =?utf-8?Q?SgtYjZ8zWyJC1+oJJuXeZSoNDROw5uxqiBX2ngWZXor+o?=
x-ms-exchange-antispam-messagedata-1: J81btKGXpsGHKA==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd2d7a-c6d0-47a6-a170-08da44052316
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 19:30:08.0091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERJq/+9fhCjOWD1WGNBZhKlwlS8y74xNhWr2DoA3S4eEjyPBslgsWZvFjr5hlLV+hCLm3vxlNWo6Wi99A/LzOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gRnJvbTogRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxLCAyMDIyIDU6NTAgQU0NCj4gDQo+IE9uIFR1ZSwgTWF5
IDMxLCAyMDIyIGF0IDEwOjE5IFBNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4NCj4gPiA+IFNlbnQ6IFN1bmRheSwgTWF5IDI5LCAyMDIyIDExOjM5IFBNDQo+ID4gPg0KPiA+
ID4gT24gRnJpLCBNYXkgMjcsIDIwMjIgYXQgNjo1NiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gVGh1LCBNYXkgMjYs
IDIwMjIgYXQgMTI6NTQ6MzJQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEZyb206IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUBy
ZWRoYXQuY29tPg0KPiA+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIE1heSAyNiwgMjAyMiA4OjQ0
IEFNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEltcGxlbWVudCBzdG9wIG9wZXJhdGlvbiBmb3Ig
dmRwYV9zaW0gZGV2aWNlcywgc28gdmhvc3QtdmRwYQ0KPiA+ID4gPiA+ID4gd2lsbCBvZmZlcg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IHRoYXQgYmFja2VuZCBmZWF0dXJlIGFuZCB1c2Vyc3Bh
Y2UgY2FuIGVmZmVjdGl2ZWx5IHN0b3AgdGhlIGRldmljZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoaXMgaXMgYSBtdXN0IGJlZm9yZSBnZXQg
dmlydHF1ZXVlIGluZGV4ZXMgKGJhc2UpIGZvciBsaXZlDQo+ID4gPiA+ID4gPiBtaWdyYXRpb24s
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gc2luY2UgdGhlIGRldmljZSBjb3VsZCBtb2RpZnkg
dGhlbSBhZnRlciB1c2VybGFuZCBnZXRzIHRoZW0uDQo+ID4gPiA+ID4gPiBUaGVyZSBhcmUNCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBpbmRpdmlkdWFsIHdheXMgdG8gcGVyZm9ybSB0aGF0IGFj
dGlvbiBmb3Igc29tZSBkZXZpY2VzDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gKFZIT1NUX05F
VF9TRVRfQkFDS0VORCwgVkhPU1RfVlNPQ0tfU0VUX1JVTk5JTkcsIC4uLikNCj4gYnV0DQo+ID4g
PiB0aGVyZQ0KPiA+ID4gPiA+ID4gd2FzIG5vDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gd2F5
IHRvIHBlcmZvcm0gaXQgZm9yIGFueSB2aG9zdCBkZXZpY2UgKGFuZCwgaW4gcGFydGljdWxhciwg
dmhvc3QtDQo+IHZkcGEpLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gQWZ0ZXIgdGhlIHJldHVybiBvZiBpb2N0bCB3aXRoIHN0b3AgIT0gMCwgdGhl
IGRldmljZSBNVVNUDQo+ID4gPiA+ID4gPiBmaW5pc2ggYW55DQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gcGVuZGluZyBvcGVyYXRpb25zIGxpa2UgaW4gZmxpZ2h0IHJlcXVlc3RzLiBJdCBtdXN0
IGFsc28NCj4gPiA+ID4gPiA+IHByZXNlcnZlIGFsbA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IHRoZSBuZWNlc3Nhcnkgc3RhdGUgKHRoZSB2aXJ0cXVldWUgdnJpbmcgYmFzZSBwbHVzIHRoZQ0K
PiA+ID4gPiA+ID4gcG9zc2libGUgZGV2aWNlDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gc3Bl
Y2lmaWMgc3RhdGVzKSB0aGF0IGlzIHJlcXVpcmVkIGZvciByZXN0b3JpbmcgaW4gdGhlIGZ1dHVy
ZS4NCj4gPiA+ID4gPiA+IFRoZQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRldmljZSBtdXN0
IG5vdCBjaGFuZ2UgaXRzIGNvbmZpZ3VyYXRpb24gYWZ0ZXIgdGhhdCBwb2ludC4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFmdGVyIHRoZSByZXR1
cm4gb2YgaW9jdGwgd2l0aCBzdG9wID09IDAsIHRoZSBkZXZpY2UgY2FuDQo+ID4gPiA+ID4gPiBj
b250aW51ZQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IHByb2Nlc3NpbmcgYnVmZmVycyBhcyBs
b25nIGFzIHR5cGljYWwgY29uZGl0aW9ucyBhcmUgbWV0ICh2cQ0KPiA+ID4gPiA+ID4gaXMgZW5h
YmxlZCwNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBEUklWRVJfT0sgc3RhdHVzIGJpdCBpcyBl
bmFibGVkLCBldGMpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSnVzdCB0byBiZSBjbGVhciwgd2Ug
YXJlIGFkZGluZyB2ZHBhIGxldmVsIG5ldyBpb2N0bCgpIHRoYXQNCj4gPiA+ID4gPiBkb2VzbuKA
mXQgbWFwIHRvDQo+ID4gPiBhbnkgbWVjaGFuaXNtIGluIHRoZSB2aXJ0aW8gc3BlYy4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFdoeSBjYW4ndCB3ZSB1c2UgdGhpcyBpb2N0bCgpIHRvIGluZGljYXRl
IGRyaXZlciB0byBzdGFydC9zdG9wDQo+ID4gPiA+ID4gdGhlIGRldmljZQ0KPiA+ID4gaW5zdGVh
ZCBvZiBkcml2aW5nIGl0IHRocm91Z2ggdGhlIGRyaXZlcl9vaz8NCj4gPiA+ID4gPiBUaGlzIGlz
IGluIHRoZSBjb250ZXh0IG9mIG90aGVyIGRpc2N1c3Npb24gd2UgaGFkIGluIHRoZSBMTSBzZXJp
ZXMuDQo+ID4gPiA+DQo+ID4gPiA+IElmIHRoZXJlJ3Mgc29tZXRoaW5nIGluIHRoZSBzcGVjIHRo
YXQgZG9lcyB0aGlzIHRoZW4gbGV0J3MgdXNlIHRoYXQuDQo+ID4gPg0KPiA+ID4gQWN0dWFsbHks
IHdlIHRyeSB0byBwcm9wb3NlIGEgaW5kZXBlbmRlbnQgZmVhdHVyZSBoZXJlOg0KPiA+ID4NCj4g
PiA+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWRldi8yMDIx
MTEvbXNnMDAwMjAuaHRtDQo+ID4gPiBsDQo+ID4gPg0KPiA+IFRoaXMgd2lsbCBzdG9wIHRoZSBk
ZXZpY2UgZm9yIGFsbCB0aGUgb3BlcmF0aW9ucy4NCj4gPiBPbmNlIHRoZSBkZXZpY2UgaXMgc3Rv
cHBlZCwgaXRzIHN0YXRlIGNhbm5vdCBiZSBxdWVyaWVkIGZ1cnRoZXIgYXMgZGV2aWNlDQo+IHdv
bid0IHJlc3BvbmQuDQo+ID4gSXQgaGFzIGxpbWl0ZWQgdXNlIGNhc2UuDQo+ID4gV2hhdCB3ZSBu
ZWVkIGlzIHRvIHN0b3Agbm9uIGFkbWluIHF1ZXVlIHJlbGF0ZWQgcG9ydGlvbiBvZiB0aGUgZGV2
aWNlLg0KPiA+DQo+IA0KPiBTdGlsbCBkb24ndCBmb2xsb3cgdGhpcywgc29ycnkuDQpPbmNlIGEg
ZGV2aWNlIGl0IHN0b3BwZWQgaXRzIHN0YXRlIGV0YyBjYW5ub3QgYmUgcXVlcmllZC4NCmlmIHlv
dSB3YW50IHRvIHN0b3AgYW5kIHN0aWxsIGFsbG93IGNlcnRhaW4gb3BlcmF0aW9ucywgYSBiZXR0
ZXIgc3BlYyBkZWZpbml0aW9uIGlzIG5lZWRlZCB0aGF0IHNheXMsDQoNCnN0b3AgQSwgQiwgQywg
YnV0IGFsbG93IEQsIEUsIEYsIEcuDQpBID0gc3RvcCBDVlFzIGFuZCBzYXZlIGl0cyBzdGF0ZSBz
b21ld2hlcmUNCkIgPSBzdG9wIGRhdGEgVlFzIGFuZCBzYXZlIGl0IHN0YXRlIHNvbWV3aGVyZQ0K
QyA9IHN0b3AgZ2VuZXJpYyBjb25maWcgaW50ZXJydXB0DQoNCkQgPSBxdWVyeSBzdGF0ZSBvZiBt
dWx0aXBsZSBWUXMNCkUgPSBxdWVyeSBkZXZpY2Ugc3RhdGlzdGljcyBhbmQgb3RoZXIgZWxlbWVu
dHMvb2JqZWN0cyBpbiBmdXR1cmUNCkYgPSBzZXR1cC9jb25maWcvcmVzdG9yZSBjZXJ0YWluIGZp
ZWxkcw0KRyA9IHJlc3VtZSB0aGUgZGV2aWNlDQoNCj4gDQo+IEFkZGluZyB0aGUgYWRtaW4gdnEg
dG8gdGhlIG1peCwgdGhpcyB3b3VsZCBzdG9wIGEgZGV2aWNlIG9mIGEgZGV2aWNlIGdyb3VwLA0K
PiBidXQgbm90IHRoZSB3aG9sZSB2aXJ0cXVldWUgZ3JvdXAuIElmIHRoZSBhZG1pbiBWUSBpcyBv
ZmZlcmVkIGJ5IHRoZSBQRg0KPiAoc2luY2UgaXQncyBub3QgZXhwb3NlZCB0byB0aGUgZ3Vlc3Qp
LCBpdCB3aWxsIGNvbnRpbnVlIGFjY2VwdGluZyByZXF1ZXN0cyBhcw0KPiBub3JtYWwuIElmIGl0
J3MgZXhwb3NlZCBpbiB0aGUgVkYsIEkgdGhpbmsgdGhlIGJlc3QgYmV0IGlzIHRvIHNoYWRvdyBp
dCwgc2luY2UNCj4gZ3Vlc3QgYW5kIGhvc3QgcmVxdWVzdHMgY291bGQgY29uZmxpY3QuDQo+IA0K
PiBTaW5jZSB0aGlzIGlzIG9mZmVyZWQgdGhyb3VnaCB2ZHBhLCB0aGUgZGV2aWNlIGJhY2tlbmQg
ZHJpdmVyIGNhbiByb3V0ZSBpdCB0bw0KPiB3aGF0ZXZlciBtZXRob2Qgd29ya3MgYmV0dGVyIGZv
ciB0aGUgaGFyZHdhcmUuIEZvciBleGFtcGxlLCB0byBzZW5kIGFuDQo+IGFkbWluIHZxIGNvbW1h
bmQgdG8gdGhlIFBGLiBUaGF0J3Mgd2h5IGl0J3MgaW1wb3J0YW50IHRvIGtlZXAgdGhlIGZlYXR1
cmUNCj4gYXMgc2VsZi1jb250YWluZWQgYW5kIG9ydGhvZ29uYWwgdG8gb3RoZXJzIGFzIHBvc3Np
YmxlLg0KPiANCg0KSSByZXBsaWVkIGluIG90aGVyIHRocmVhZCB0byBjb250aW51ZSB0aGVyZS4N
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
