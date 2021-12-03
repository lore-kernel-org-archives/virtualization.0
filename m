Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB31C433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 07:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 373DD4043C;
	Fri,  3 Dec 2021 07:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BO5oL-zXHqZW; Fri,  3 Dec 2021 07:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8764940433;
	Fri,  3 Dec 2021 07:31:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1D1C001C;
	Fri,  3 Dec 2021 07:31:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6F59C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBB0D4013F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id apOY5X4-Fy0Y
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:31:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8AAA400EB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtaiuTpJhoQLn3diIwqAxgFwICivrt9Q5d86opLbsLEmfM34c0zkkKIESKd3Oz8wEWHs7YMbsboegtFcSu+NFrn2HONyRKvjUArl0PQcDzYYhB6x2T4qrqp+t4LAecutc5s09y/dLYkO3eqiJizTji+RY2aloDSB5IQoQ6gAk1NOoGuXmKrFY7/8eaAQjx/BZIxv9j5Aem7ndEiaWL7qidkb3DWf8E/k3PKTlFGIx+GaJnsrJoG3MnuXzAztyqRSMi/gZW53tXjf1YOTonQHdwSvapQ1Zqigu0vIi4ApIsmfGdZ14jkFngw+c7jaxJ/L/hKUL7VEXsz6PYApLLDWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbDV1oCSr6EB+ma3XYB0yqvRH5cz3PQvGEhl3/1u3T0=;
 b=avc+zqFVtf1KSGinL+Nhvz26UnUFyKFvHjV5NXSi3kzKCXWNoKCB0nwsgO1ONn5LvEC3O7Urq0X8Kiv2zAwk5LazunXF4FPDybipq91xKDH//Vq9h29mmAQep/GeKmO4BP3boZGOamT2X/2nSySQr98inq67Gw1Ed92BMcgYErEZnstxF+CPsBUtxD5cEGXrQmpXREvqduVEPAZmJ6+aSfBlK0kRYJAo/gi+TXFdw1d2pUKObKO9v8DQsO5L8XOhBVPxdd7FzBXQusmxTHdFLs86LaWgl9fLRa7vEUxf8mzpKEtFnWqjlTXlCYLhTzmrCw5sbSmjaPJTMFO6AM3c4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbDV1oCSr6EB+ma3XYB0yqvRH5cz3PQvGEhl3/1u3T0=;
 b=iBi7F9+0R+AfpNnoxy+ZPlUJE3RZAFIQN8KmruSd6N1qTwGlHlrm+g4k3qRJ2iEGPnHWJQlhjdAJso1lQvZmtl1pVIUSZNsLNLb6q0kdObfNvsXH1OEjgwuTJES0+hIbtBn/BtxBDeC1M7rn3ajE20FQkAgh/ECAwnaZlh/ckS3PwF9PaNzhBx3Aw7GNfh+3ishIWDYKwGowiu9q8OD+ie6p+ASB8MZzEHLRdJMv9H2749HUGCO4D54WwWaTgkai2H68i82kMQk2clweiOnvRyN4hAJUz19nHY0HBhSlIT4v6b+nH45O6VyMsQH31PgswpnISVemHRV/mQmoetutdw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 07:31:37 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 07:31:37 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
Thread-Topic: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
Thread-Index: AQHX5u3Ify/T+FzRyUq4wcxSRdSTaawgYMwAgAAAjSA=
Date: Fri, 3 Dec 2021 07:31:37 +0000
Message-ID: <PH0PR12MB54813FD2D0C389E1A7F0B31FDC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-4-elic@nvidia.com>
 <0e6de504-38e8-a1a9-5dc9-00c52571b21b@oracle.com>
In-Reply-To: <0e6de504-38e8-a1a9-5dc9-00c52571b21b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65002c4a-a173-41e1-e552-08d9b62ef11b
x-ms-traffictypediagnostic: PH0PR12MB5467:
x-microsoft-antispam-prvs: <PH0PR12MB546790203ED97187B679F038DC6A9@PH0PR12MB5467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmGVSP3S0V0c0+8+EtmFcfvJPACtKQDzo4ZY+7IURQI7sXyuuXkfamQLGG3Zr2x8k89wtQTjMaqx/mbnxX546CzI7L8cJWoB2Drox4AxZjauMnG6cqPDO0AobHHzjakO/8XJAqiPbEHkWQrT7qAmPYKTXvDwVfzf0bPLKKRVRDzPEX6xwaF5kjEOqqc3TWlf2MOhF/3+KsyWswqTdKQd8W1lfR/wc/E4iBISIhlN+Qv/dlgsiDXPjGe1gXVK2jz/swFkLuKp9SMZVW0NLPaKgEJwNZ5AXC8XE5NlGRYF5iW54/oGDoS7OyG/lJ4d3i1rqH7gdtH4giZMpajpqY2lHPsQ++bzq1utOyB9tOUZ8d7aewHt36eNljAv2OWL93aciIwItGEOisCpV2JYHtTX1gd8HRy6Uf1wZlLRXpbSF6bhPEA/2xTKxpcgUbGbkgM+Ep9ROzyA25ayBC/ub4tZqVxa5ZGx/10gsm9/oWfZw9KK0rc+/QJOGFq71LlO9Vk4/qsBt3Ln6SsEPUE+Bx8/t2naTL6xKbx5KiRd54YkAPvdlgYndg06nzUXfChq+SIAc2wRIqXN6Bh0Gvr1Y9nCbFoBQ1d7vxjNElBBCoPwh4tg3eigpfSr+0WYcge/zhdktBBgn4KG8AwFC3cF3TBC+jYFdlEGVJL2dkpMNtD1BdkbyKUrbW+6apixC78AHjdYmeCQq9wvsJugX1P8xkeQfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(26005)(316002)(7696005)(52536014)(55016003)(83380400001)(54906003)(110136005)(2906002)(122000001)(4326008)(38070700005)(71200400001)(186003)(38100700002)(8676002)(33656002)(66946007)(8936002)(53546011)(66556008)(76116006)(66476007)(64756008)(66446008)(6506007)(5660300002)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVDTFo4YVUybmFESkhSOW96NjlsRkpFajMwQVJ0SkRZNFMwNTVlM3NwYUlj?=
 =?utf-8?B?MnZaRHdxMUtxZW1rY0lJQ0pXUE9Oa29yZThsNGRqZnlML3pTL2RqTDdTcEwv?=
 =?utf-8?B?WU13NUdLR2ZBdnFQK0Q1Q2IxR2I0U2xEZlE2akxlVmhMdklJSEtBdjhoRFdO?=
 =?utf-8?B?dDB0WUVxRytJK2xjOVpGTndnMjVqQVllU2dOTkpMczZ1TkFPakdCc3Z5dTZy?=
 =?utf-8?B?NzBFdjFwdlRtRjcraEs3Uy91UVk1QTI0OXIwd2k0Q0daWVVKWVF4VForcjRz?=
 =?utf-8?B?SWNqL2t1ZUMrdkl3Ymk4bW1JcTQrQnFRMVBmRzZkWGRWay9JM3BGcEZKd1RH?=
 =?utf-8?B?Zk1ENlRkbGNLVUQ1YU9tcmZHMXVEbXNNMUd4S0JyTmhSRjl0anNYbG9jcHF6?=
 =?utf-8?B?bXlrZHB4VlpYY3RyRXorWVBGZTRHb2pWMk14OG82c0wxdE1jaGxkYXZCeHF5?=
 =?utf-8?B?L2VaaVFJNFFFRkdLeFJCQVNicHJIMXVDbHlaUDlhUGlnMWcvOEpDcVpOSjMr?=
 =?utf-8?B?aUZxY0RZV2NKYlE0UzdIdjM2T2pMWkNrTkJZYjlrRHFaVkhwZ3dSM0NxLzI2?=
 =?utf-8?B?djl4akkvTkV0Z2FCRnBQUk56by9Jdmgva0djMzczSnZYZXR5VFBBOGN0aXAw?=
 =?utf-8?B?NDA3ZUdINy9PVXpSRnk1L0JUVnhweHE1R0NDaDRDU0FKcklycHhEQlNScEp3?=
 =?utf-8?B?eXZmL0hVTXBEVURPWk81QlZGVGtyeTZFYm9wSXA2VllTaXUzcDhlbHE0SkFq?=
 =?utf-8?B?Y20vYU5Cb2lka091ellrVVhiVzBqbUtHQ0JDeEZpNE0reHdQNkM3UkcyeDNo?=
 =?utf-8?B?M0FXYWtDQjN3dHNGcjFwWWZsUjBNdWlBWnNyOG84WGRzaEZWaHhZRjIxL3JT?=
 =?utf-8?B?MlJnR2dsMHZ1NU1KUVRMYWU2WTgwS3J0bTRXeFZmMHZ0dWNrc203azdMRlhk?=
 =?utf-8?B?Wng4eG0wRXQzVm85UkpnenNTblhwaitFQ3UyaXRiYkRKRHdndHpNVUZxa0xV?=
 =?utf-8?B?dlhxTm10WnU4cWF1QWZxWitDMHZudzJzSklIUXdoR0lZSjJoNThPcUxLZVBG?=
 =?utf-8?B?RjFTY0pybUx3NE1DRVFUSmplOWxNZEJVWmNNYTQ3d044RjN6SHB2QTN3bVJz?=
 =?utf-8?B?QWp3cUFWdnR1ckxPWFVHTzd3bnJZU1drWWJzL2ZnV0dFU25KSk5pZ0ZNWkZW?=
 =?utf-8?B?bTVOZWZYVlV0a24vVnV4Sm5RbmpwN0RFUWRxTndHSzFuR3FNUzlacXRpN3Bv?=
 =?utf-8?B?T1RjdUlDemF2NTRXUHNwQkhXL3BQaGJCVThubE9FNnRHZjh2N3J1WDQySEVO?=
 =?utf-8?B?UzVSc0FHd1hSN1Q5ZU80TnZrTEpFMUovMUoweFFodHBxSGZZZTBteUtqRmtN?=
 =?utf-8?B?Ulg0M3RTTnVxcjl3T1RNamZyOGdwK0tXMWR0eHFvMUhHZHRXYUY3a0VLeFBx?=
 =?utf-8?B?TGVsbHRFQ1JUWU9lMVcwVk9jYnlPOGJwTWJ4Q0Q2Q2lVaVZRVjB5alFQY3dI?=
 =?utf-8?B?c2JqU0JtSWxTTlVubkthblRibDlUbUt1SFJxUDN2a2ZYZmlFTjI3clFiY3Yw?=
 =?utf-8?B?VGFSKzZrdVM4OHFsenJVL29xbktBc3NXeGd0VUlIemhnem03RHpkT3ZrQlBD?=
 =?utf-8?B?NmRhTXZTK2w3WVByTG0yZDVkaEpZSnllcTNzRkVGaHZWMXdnZTFGWjJXSUlY?=
 =?utf-8?B?YWdRVmwyWndaYmRZYWNRaTY3eEhvT2RKN1RHeEo0T1RGTDRtSmVQdHFza2lt?=
 =?utf-8?B?b0tTQnpUTTRPRWJKQkwvL3QwcG5WVUx4WDRVQmRRTUxlQXlFR0l5aW9VdHk2?=
 =?utf-8?B?UG9DR2hrUDV1QUhoSFBBc05KLzl5ZnQxVEVvYWg5T0tKT0lhN1FOM1ViQ2dO?=
 =?utf-8?B?OXcxYjhJNGRTMk5OUFVVWlgzanNOUWFvU1hmelplQkc0WkR6Z25WdXprWDdG?=
 =?utf-8?B?L0RudjJHV1Y4ei9mb0hzVUhjdEFGMHJqd1ZSUW51NGxuTGRZakZHRkFVaHlm?=
 =?utf-8?B?ZUdUam5LY0hLVFFwMWFaWFF5YiswTlpOWHp3a3R0UjRic2hxaC9EL3FUd2Vt?=
 =?utf-8?B?d0xFcDViZDNESE1Db2R6UzkvWmdxYlBmR0JseFlHRjJRV1MybEFjYkpadXZ0?=
 =?utf-8?B?M2txcmJoWmxpY2gzY1RHRTZOWkhXV3lGWjRuay9xMmhMblNseU9Ud3g5VnlY?=
 =?utf-8?Q?Swc+OJlwP4WMR0ioSEzJ7f0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65002c4a-a173-41e1-e552-08d9b62ef11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 07:31:37.8378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uD9AqGRVzkwMwxazCyypvqwDrndbYQkItvmrD2XN9/4vOr5bBAti7CTdyrvemz1dofyWmHUllQDmmmQVb/ohsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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
> Sent: Friday, December 3, 2021 12:58 PM
> 
> On 12/1/2021 11:57 AM, Eli Cohen wrote:
> > Check whether the max number of data virtqueue pairs was provided when
> > a adding a new device and verify the new value does not exceed device
> > capabilities.
> >
> > In addition, change the arrays holding virtqueue and callback contexts
> > to be dynamically allocated.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 33 ++++++++++++++++++++-----------
> >   1 file changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index b66f41ccbac2..62aba5dbd8fa 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
> >   	struct mlx5_vq_restore_info ri;
> >   };
> >
> > -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> > - * provides for driver space allocation
> Is this comment outdated, i.e. driver space allocation in
> mlx5_vdpa_alloc_resources() already provided?
> 
> > - */
> > -#define MLX5_MAX_SUPPORTED_VQS 16
> > -
> >   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> >   {
> >   	if (unlikely(idx > mvdev->max_idx)) @@ -148,8 +143,8 @@ struct
> > mlx5_vdpa_net {
> >   	struct mlx5_vdpa_dev mvdev;
> >   	struct mlx5_vdpa_net_resources res;
> >   	struct virtio_net_config config;
> > -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> > -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> > +	struct mlx5_vdpa_virtqueue *vqs;
> > +	struct vdpa_callback *event_cbs;
> >
> >   	/* Serialize vq resources creation and destruction. This is required
> >   	 * since memory map might change and we need to destroy and create
> > @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net
> *ndev)
> >   {
> >   	int i;
> >
> > -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> > +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
> >   		suspend_vq(ndev, &ndev->vqs[i]);
> >   }
> >
> > @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >   	int i, j;
> >   	int err;
> >
> > -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> > +	max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
> >   			1 << MLX5_CAP_GEN(ndev->mvdev.mdev,
> log_max_rqt_size));
> >   	if (max_rqt < 1)
> >   		return -EOPNOTSUPP;
> > @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device
> *vdev)
> >   	clear_vqs_ready(ndev);
> >   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >   	ndev->mvdev.status = 0;
> > -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> > +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) *
> > +(mvdev->max_vqs + 1));
> >   	ndev->mvdev.actual_features = 0;
> >   	++mvdev->generation;
> >   	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) { @@ -2308,6
> +2303,8 @@
> > static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >   	}
> >   	mlx5_vdpa_free_resources(&ndev->mvdev);
> >   	mutex_destroy(&ndev->reslock);
> > +	kfree(ndev->event_cbs);
> > +	kfree(ndev->vqs);
> >   }
> >
> >   static struct vdpa_notification_area mlx5_get_vq_notification(struct
> > vdpa_device *vdev, u16 idx) @@ -2547,13 +2544,24 @@ static int
> > mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >
> >   	/* we save one virtqueue for control virtqueue should we require it */
> >   	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev,
> max_num_virtio_queues);
> > -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> > +	if (add_config->mask &
> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > +		if (add_config->max_vq_pairs & (add_config->max_vq_pairs -
> 1) ||
> > +		    add_config->max_vq_pairs > max_vqs / 2)
> > +			return -EINVAL;
> It'd be the best to describe the failing cause here, the power of 2 limitation is
> known to me, but not friendly enough for first time user.
> dev_warn would work for me.
User commands shouldn't be creating dmsg unwanted messages.
dev_warn_once() is better.
But instead, extack error message should be returned that reaches the user who issues iproute2 command and makes user aware better.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
