Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DB3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Jun 2022 18:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4055760034;
	Tue, 14 Jun 2022 18:38:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IdFzK_pw4Co2; Tue, 14 Jun 2022 18:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C85BD60E4A;
	Tue, 14 Jun 2022 18:38:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B21C0039;
	Tue, 14 Jun 2022 18:38:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D4E9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 18:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13BAE40384
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 18:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1rvcDIwkkqO9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 18:38:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11E5D40281
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 18:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJqMgzHh2f0S9P2ombqXEmKi6A62FARIh/U1O9R350Lb8zhSgkLSd0RyeDpTA5VF76PeLSngrnlOdLwJizeEqEdwg/0tncNShCQT6IumSDjF87aEeo0y42CBWzukZmW6qfEzrdmz/NbzpupmbacNsih7kDbuOIVi0IMTqBmUhwIxBRk3ZQw44ls+eYGBQggQ7jvYQeW4Y0pFrlHrTCMJk5OJe+m4gHH15I0rx6xUUhQOgY9vc1tFX1Vm7k3wq94doLnYZ3m0Tza3ocRZJqjBe8EYzDIgrHWGiZpZFaprtTf2dZpXt5ykd80Fjve4rV0oeyEMgKnjzE8cD6ezAh2CuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj6gQY1EfVe3G9A0UXJUYSe2gS2oonChOeLVsxp0cd4=;
 b=jXScUCQk2sw3KmzUw5YaTzgZ2po+7oKaSg5E9c/NhGncBFzFi782t8851+svvUQoeEMuY4N9f1tbSpk16IJHq1Hmo3oAdLmZZRtJa8VU1lr8H+JnvIGqVdrjOVgsRXHLAxTCsYG/3aXVXORXAC8WlPljAaFGXC6riYruA/Ln9AcfltINJLR17R5ij8AHnV+uRH6f9EvROJIlgNvfv9GsCCEK3uztf4bMTMM2bukM2X/MYV+06T0z7Q1U78xpYv5l/+Dltmiwkrgb1L9EskDzkFsZq+mkgM6bFD6icUw26eNs+SSBcQybBPp06+2PI8fWQ3Ic9iTCdyF7qvxM5slktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6gQY1EfVe3G9A0UXJUYSe2gS2oonChOeLVsxp0cd4=;
 b=qeT27vwBrlEHtojiV6o1kYVRwXzOHuexAHjGqOnDOuB4aQHVRzICKrcJcQbkbOwVC+4lOjeUeIUJNKsIm5mZjHHoBjmD+MvFZjfHP+H8EMw2EXGfR3CCrKroHBsfFOiF2E7PJAhLsNBLvLMyMJo2Lw17ckY6NUwysBSArY0fjLIElUNBTMPbibUZQRLYVBLGpI9+iK7AytO6g711t59q2hsrDc31EVYi37iwpAFLcGgSEouroBoINo+e+E4DnxHKYJizHwBFuzqlVpjuoHYiwlVYuclAAeR2Tt0EdFOMcJxRCPu9FiGi2tc460nsADZI83aIMOb7FcMkgvC3PO6Bww==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Tue, 14 Jun
 2022 18:38:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 18:38:16 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V2 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V2 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYfw/QFftqwiWMMkaiRAN4I7mCTa1NzPiQgABoqwCAAQZfMA==
Date: Tue, 14 Jun 2022 18:38:16 +0000
Message-ID: <PH0PR12MB54816E481633EEB9C24D4D5CDCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220613101652.195216-1-lingshan.zhu@intel.com>
 <20220613101652.195216-4-lingshan.zhu@intel.com>
 <PH0PR12MB548173EB919A97FF82E5E62BDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ed635bf-1c92-f3c6-f6c6-5715a5a5ac92@intel.com>
In-Reply-To: <9ed635bf-1c92-f3c6-f6c6-5715a5a5ac92@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c3fb4fe-bce3-4385-3fb6-08da4e350b99
x-ms-traffictypediagnostic: MN2PR12MB2974:EE_
x-microsoft-antispam-prvs: <MN2PR12MB2974AF3E2787881D5508F54CDCAA9@MN2PR12MB2974.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHpsnI8apTYO6Q4iDTnl/xfFxNISNPvzshErujpyFQAz/vrQlD41tfhs5LxDAxlkMYwDdUXt+VtX8v4OanwfDvoOzC0I936+1ZbmDCqn97cEQJPVZhvlFt3iesQOn35XjKb0F7d4AC2xNbixW9YmIzkLYy+mboQX/h5ZV1ExiwmQmpIXCHrsMcP7Od4iCLy02X7/nWuUOglPko2qjBGmkQeC6t4HFdx9NzNT3nqlbhTtxYFAUQVMHV07lHkwoMqsYYM0Yy/v64BDdtU7hgCkfaenbHZYCvq/BK5TYkmgGSztbR9ff910VJ/A0TPCDVwTgIHIxauyC97A8NSppngscoiTOR6U61Wv1DIouuKJhpZhyY470SPfFEvJ6H56KTu5Hnza4OF6zuxpXS0fUMhM18gz/W1Yf+x0hvBl2NaN5wVNU4vkIi+G2buPiXWt/8YxdN9zMth1cvn0QAUXsFpD+LybgvjgLlAu0Db/PfH6KfT65SOj0gInatWOQM9hfldOKwC6JmvFEBC2wOm7Z/Js57vAJGka0jgVqb87ZiZAqvzxB9EpxmKU9OU50mlVwtnDL2kv7j2ZRkXbLuM4aAhg1Iiv/V5ZlKhEb9eDKBifZS/njH4PRitjDF3dWRWR4G4pQgy/mBdilI0RLqqqAcuN9UY4WKVx0SWYwTZSySjIvJ46+RN3jXGY3qHnWFJ2muv6iIZmlEXNRZvo05naIDU6PQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(508600001)(8936002)(5660300002)(316002)(52536014)(122000001)(38070700005)(54906003)(110136005)(86362001)(71200400001)(8676002)(66446008)(66476007)(4326008)(64756008)(66946007)(66556008)(76116006)(33656002)(26005)(53546011)(83380400001)(186003)(9686003)(38100700002)(2906002)(6506007)(7696005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1NWZCtDcm92R21Rd1NWL1BzejVzVDVsSWdVcDRwNnJIcDJ3ejZsSGpiUFBV?=
 =?utf-8?B?TUxjdTBGYWRmWVdrYU1ualB4cm9MdWxEQXduWWZGS1NRamxRMFBMZlluNzhk?=
 =?utf-8?B?aFZCcWJZZVFqVWpDdFhxNDRPSTQ0WDZ0T0NkZGp1Vk1RRUg5cStURjkzTC9t?=
 =?utf-8?B?Z2YvaUJMMjhETWp3d0UxQzNXRkFiNU9razVNanNXNW50ekoyekZOTHRHTmd3?=
 =?utf-8?B?L2x3QnlXeEJwNldTMkkvY2E2OFA1d0VxMCtDVGNBYTNmdDhJd2x3UUIwbVJ3?=
 =?utf-8?B?K0VZSzNibW1nbXNEMFc5MkE5cDhjcytPNmVkOUNZajZCa0pVd1BSeHlKbEhv?=
 =?utf-8?B?aFlRZEh3QWNNbURXRzJ6VVR3WkYvV2ZIQzJRTmRDNEJUdFQ3aG9YQmxMTXkr?=
 =?utf-8?B?MmhrbnVHVUFjaVNaNG16R21nWjlYelBWLzV3RC9leWdGeXRSQnJCZEgwY0JB?=
 =?utf-8?B?TUZUY1BkYVl5eWJEUmt2Y2hycFlMKzdqL0pwVUpCSS9GREZ1V1N2YmtjQ1NP?=
 =?utf-8?B?T21RbHBHMjR5QTByOGQ4N0IvaDdTaC9GOExFczI0NFJIOEJGaEdwN2lySjFD?=
 =?utf-8?B?SDg2V3k1VEVqeU9aMnpsMWdXdGFWbUtUem1GeThHVlNkN3N1VmgzT09oM0Qy?=
 =?utf-8?B?dXNBY2xRYlRiZE1tMDVrTEI5aU04aHpUTmZ0ck1Xcko4UWZWbklLZmhrN28y?=
 =?utf-8?B?bGhqQk1zYVNTaHp0YVhtUzVPSFhZN2dKY3B6cXhLYjY5dlBKQzMxQnNHVnN6?=
 =?utf-8?B?V0dZdHUyK0x1dHRYOXB5dEdXZzM3U1p0M2hyWGQwV3hjNlFqRzVlWUtwbFlt?=
 =?utf-8?B?OHg2SG9BZFYzY2Z2a0F6TUZDT2xldVFETWpXZS92UWVOZXNtZXJqZXJHeWls?=
 =?utf-8?B?ZmdhMnpRWFNoNi9LYkFSaTFneDZvSXZCQi8zR3E0ZnUxK0Q2aWJqRnQ1MGZZ?=
 =?utf-8?B?dGMzMEVONG9mVHNndi8zWnpLSU1zemk0cWxUc2xYWmdQWklDeEQ4UjBWWVRK?=
 =?utf-8?B?VWloSzFjMzNQOHpidlZDaU5tN2JHK0N0Sm40Vm5oYVlldytEZ3JMcWUxNWJv?=
 =?utf-8?B?WDVoUUVyYTVqaHcxK2thZUNocXpSWVdTM0dWWHFORW0zT1p5Witnb2tCbklU?=
 =?utf-8?B?L05hOGJ0K3lWSVBlekFic21XekdYcGdjdWlDY0hMcU9zcU50YzNpWkNKOUFq?=
 =?utf-8?B?a1ZqMUJ0ZXpFQUZObW0xS2NOakxYb2xwTlJYRmR6OFo0RTU5blN1RWV1OEJm?=
 =?utf-8?B?b05uekVIM3lFdSsxOE1LUFZyZWJJbzFtclVpV05WaHM1bHNlOW02YjdGUSs5?=
 =?utf-8?B?OHVHMHk0UTRkSE9lOHhRTHFWSFdXb2daZVI5NnJSRTZXZDk1YmhwSTlLYXhF?=
 =?utf-8?B?bEtReTNoQXNTRlFDMXA5U29JemdGSS94THJkYVFzSVRpd1BUc3FzWU9aanJU?=
 =?utf-8?B?UVUwZldRY0dOUmdvQjlBWmF6RDFqemlhdy9WdklMOEZiZEtHbWpVZ1Jmak5n?=
 =?utf-8?B?OUlBL2FyM2xhazltV3VYU3FTSTgveGFFVmdoUUk2ZHhubjdPYm1VbUtKRXpJ?=
 =?utf-8?B?UzI5K1Z0bVhVSUVrblZ2SW0wNjBhUU9HVmhtQVQ2Q3M1ZlBOc1paTDlPZlU1?=
 =?utf-8?B?VHhQWlY4cTlEeFFpckdPVGJscE9kNEY0aGpkZllxYlFVUm1RdG4wY0dBY1d5?=
 =?utf-8?B?Z1d1bDRSNUowTjJxQk1vMyt3Y2Y1MWRCVWNpWWJ5eWN5MzNTbUg0NCt5Zkg3?=
 =?utf-8?B?K1BOUmtRK0RldHdrdHRUL0laUWNkMUwveXhTc3NEMUJjRDdjb3NCVlBDRFRD?=
 =?utf-8?B?UktRbU8xblF0d2xNR1REa08rcS9OZ2xxcTB2YkUra1NkeUd2Ym82aTZadG51?=
 =?utf-8?B?azZGYm1RQ2lSRzZPOEh4ejA4dFZuMXlOa3BITVVvelRpd1VDRHovdGFRTmI5?=
 =?utf-8?B?cjRlV2lHblA5K0tHa3dOTHJmTDdlWEdNMzFpV1VCZ0gzWkNzTjRkV3ozME85?=
 =?utf-8?B?TmtyUVpJNjI4aXJnSzBnYkhYb2k4TlZONzFENUM5NHYrZll0Yk0vMkJVVEJF?=
 =?utf-8?B?VDJZa1lidXlWSmFDTWhxdGFxZDhkZWlBeFZUSDZlTnpTd2szT0ZIYlBEalI5?=
 =?utf-8?B?eFJCcUFoU1pYV2F0bkJxdVVDM3JKK0Mxa3dOdDVyOFU3Y2xHcVZZdyt0YXZp?=
 =?utf-8?B?NHBtSzNYZmR6S25RYU5YQnBIdHM1bFpLSkNKY2hHRDdQMndoUDB1UnIvK3lQ?=
 =?utf-8?B?ejM2Q2VzcktyY0VCSzJocGxuZlNOU3VXd0RCajJONmlOWC9rY2dNZUZ6WnhO?=
 =?utf-8?Q?gG0eoaLtpGGFEMqf2G?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3fb4fe-bce3-4385-3fb6-08da4e350b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 18:38:16.0548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29vclzK2rEvoet5eP+qitqNyo187/+OPavYbdv8pT1z9joqwiipI69G8XHF/TGYpYlcVW6bwaRzw9vR/9kT8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
> Sent: Monday, June 13, 2022 10:53 PM
> 
> 
> On 6/14/2022 4:42 AM, Parav Pandit wrote:
> >
> >> From: Zhu Lingshan <lingshan.zhu@intel.com>
> >> Sent: Monday, June 13, 2022 6:17 AM
> >> device
> >>
> >> This commit adds a new vDPA netlink attribution
> >> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features
> >> of vDPA devices through this new attr.
> >>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   drivers/vdpa/vdpa.c       | 13 +++++++++----
> >>   include/uapi/linux/vdpa.h |  1 +
> >>   2 files changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >> ebf2f363fbe7..9b0e39b2f022 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -815,7 +815,7 @@ static int vdpa_dev_net_mq_config_fill(struct
> >> vdpa_device *vdev,  static int vdpa_dev_net_config_fill(struct
> >> vdpa_device *vdev, struct sk_buff *msg)  {
> >>   	struct virtio_net_config config = {};
> >> -	u64 features;
> >> +	u64 features_device, features_driver;
> >>   	u16 val_u16;
> >>
> >>   	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config)); @@ -
> >> 832,12 +832,17 @@ static int vdpa_dev_net_config_fill(struct
> >> vdpa_device *vdev, struct sk_buff *ms
> >>   	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>   		return -EMSGSIZE;
> >>
> >> -	features = vdev->config->get_driver_features(vdev);
> >> -	if (nla_put_u64_64bit(msg,
> >> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> >> +	features_driver = vdev->config->get_driver_features(vdev);
> >> +	if (nla_put_u64_64bit(msg,
> >> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >> +			      VDPA_ATTR_PAD))
> >> +		return -EMSGSIZE;
> >> +
> >> +	features_device = vdev->config->get_device_features(vdev);
> >> +	if (nla_put_u64_64bit(msg,
> >> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,
> >> +features_device,
> >>   			      VDPA_ATTR_PAD))
> >>   		return -EMSGSIZE;
> >>
> >> -	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> >> +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> >> +&config);
> >>   }
> >>
> >>   static int
> >> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> >> index
> >> 25c55cab3d7c..39f1c3d7c112 100644
> >> --- a/include/uapi/linux/vdpa.h
> >> +++ b/include/uapi/linux/vdpa.h
> >> @@ -47,6 +47,7 @@ enum vdpa_attr {
> >>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> >>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
> >>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> > I see now what was done incorrectly with commit cd2629f6df1ca.
> >
> > Above was done with wrong name prefix that missed MGMTDEV_. :(
> Please
> > don't add VDPA_ prefix due to one mistake.
> > Please reuse this VDPA_ATTR_DEV_SUPPORTED_FEATURES for device
> attribute as well.
> currently we can reuse VDPA_ATTR_DEV_SUPPORTED_FEATURES to report
> device features for sure, however this could confuse the readers since every
> attr should has its own unique purpose.
VDPA_ATTR_DEV_SUPPORTED_FEATURES is supposed to be VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES
And device specific features is supposed to be named as,
VDPA_ATTR_DEV_SUPPORTED_FEATURES.

But it was not done this way in commit cd2629f6df1ca.
This leads to the finding good name problem now.

Given that this new attribute is going to show same or subset of the features of the management device supported features, it is fine to reuse with exception with explicit comment in the UAPI header file.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
