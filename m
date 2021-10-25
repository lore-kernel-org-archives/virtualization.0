Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEEC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:06:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77C360F6F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A77C360F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 695C080E4D;
	Mon, 25 Oct 2021 07:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMyymcx93G0N; Mon, 25 Oct 2021 07:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEFBA80E25;
	Mon, 25 Oct 2021 07:06:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B201EC0012;
	Mon, 25 Oct 2021 07:06:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D867CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB3B180E31
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h93Bcs899tFN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:06:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A90880E25
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq+th3MtFWVG8ugZUwNRS19c/H39YBXkS8BijSzLCYMzlFAmhEgIB/J/b99IkjEwUCDgXIkbz2JlKZFG8L8NRNRral/v7PeLEeVrrCMsMPqQg1qKItGNAIpRSLRcbx/uv21f+ALk7ettioFqu1GqoSDvYRdnF44ogu1AbNF5LVHOID2t1W7NN3b8Lxy7ywcoCpBFYyyCergk3pJPefa43JZVLE8MdVxH7V3AlrHeDLW5Y+AzfhBV/YbTszQVFgl8+Mb+8+LMMcOSKgxXVoJDEGpoWH+6gdUV1lB7g+JLiF7H1GqkXRBmz2bomRFWlzsf6bykZmvDdRa0/74AfkBmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw5jM6pN4cW/dJTxU34UipxTb+EFxnhd8JSgkTtqTG4=;
 b=nrayCNIl7OJutN0Rtuk7mudxt0X21CeohzQcVzflhQHMxKEV9raJT1vWyNFitdAHpx/2C3LWsROZiIbCekkKjBznP6euXK5ed+nwfp5bwmRbHE/9hp8LnGRKfZLDBDNoHAriv4ssMdszqVtRBM0KUvDpOqO46Hdx9AlUGxO72LgcuXv+NSfEjtbEhMW1gn4qbxe1j1aB8JHUanWfqTbTJmFtqyOQVMLAF8ei4mDSwaioomjy9Ry6TCNQlEg9aNqVk4OLN/M+xKJCMq0JqM821jDlVMhsDKH46zDGusRJErcuFy1itkOFRHguPMyRoEbmoyPqz0EEwWLhNl8dSLNZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw5jM6pN4cW/dJTxU34UipxTb+EFxnhd8JSgkTtqTG4=;
 b=HASWTWw74m2i2T53g7CiErK4Zd+R5lSY5qQcSNpuE7JXxYl4WpjGgNVnYcFb8e4txgMitNEUQAAzYiTnVo3/yCSNUmYF3QSjoDG8EmH07c0yPEc4HS4f5l62icg4cu/RTvDPw8n1Z9pP8tYwjDUN6ES5tthH3eOVw5SZHxo9bkrtD4JgLU1N9+IIA3+2mPvcpfLED2Sep4UEIifNfslUGP4HPsj/02v/LRTPOFx8XJkTK2Tp+OEnJRnmL76v+Ye8CLe7QM4MXHZUNK8NOOzjGifpl7+9w01s76WKKaNkZyPcnspEGVi3AORgWL/GkMBvOh3Irn4cHoDO6lK8cxzdIQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 07:06:42 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:06:42 +0000
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v4 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
Thread-Topic: [PATCH linux-next v4 4/8] vdpa: Enable user to set mac and mtu
 of vdpa device
Thread-Index: AQHXxpm0zkNyeacpXEGh5VnXVi6UqavjTwWAgAAAb2A=
Date: Mon, 25 Oct 2021 07:06:42 +0000
Message-ID: <PH0PR12MB54817652E2E49FD6A4F58F1BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-5-parav@nvidia.com>
 <b6f5c0e9-e3e0-0f7f-d3b6-d20d9c01d27d@redhat.com>
In-Reply-To: <b6f5c0e9-e3e0-0f7f-d3b6-d20d9c01d27d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58db7f6b-1aa9-43be-22c4-08d99785ff7f
x-ms-traffictypediagnostic: PH0PR12MB5435:
x-microsoft-antispam-prvs: <PH0PR12MB5435819881E5DAC6C6955C82DC839@PH0PR12MB5435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1o9nM6eezeCiUfyv1MgPp51WUMPfYANWZvUxPUGlGTT2MlKmtRlFKvPM5kfsPrYfGvb1HijQkWlBJEHPNqiSDjDLKFiWQCGwoYZ6hu55x5SxmsY4NfSypAY0q89gUo1Nr7n38Ou6SWGpiWtcDQ71oTL0t4VIKiBUZkE9Wp16mslk0ZXj3YAbap8eMfJkIRvoaJS21FPVQvdOjVt/6G6IovBXnCQ1FdQQb7Dqb74hZohTX8S5qRfZxOqv1/bqahlDYqGpg7s1b9a7PEe8AbbHjAzWuy7dwJKfQrAmpgROPXf64s+SG8EHyfu9gN4LGlitSEmv8alFoaqmkLZ0pqbujz+ZhSW5VvPkLVqpF051/LMB788gzhF1RRUqyepDYBH1YDo9vvyCyDPwEltIdO1TleSRcyz952d7ozK4PQEoa0L331CqpR2ud5iVDX7iqp+9GwBTQcoXjmHqN/yLrtcFdlPkGXSRLWUFp7UW0QOvT+UpLx5XXXlar4kD242oD+ktDjqXjCcK/FcrnBCFhJ3t+HFS/naVOu0ZbQFhXka3uVfDX3VUA4DgTsV+FKHmbx7peVrm0Iai3xCpu3eHUHONkvsDoYDsjMD/wrnt2WlOpXykzfIqHhoCIBGXOtzTFOXfcZh1pk2FpOHLD8cWbNAuNkIV+pybFMAJPAJzxca85uwp0iqb3WQT8apccOujBDxPGw0333RoStiWAEP/G1LE5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(8936002)(66446008)(4326008)(66556008)(64756008)(76116006)(66946007)(86362001)(66476007)(8676002)(6506007)(55016002)(122000001)(38100700002)(5660300002)(9686003)(7696005)(52536014)(33656002)(107886003)(186003)(316002)(83380400001)(508600001)(2906002)(38070700005)(71200400001)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OGV6VHBQaDNEUEVHVTlNYmJsWlU5UWV5QTd5NTlHWFJITUFEOE5OTmIv?=
 =?iso-2022-jp?B?N0RsSEYwWHlvMGRWRzBjeC9uNUFMeEQzaXo0L3pJZlZLclJxdlhGb0VP?=
 =?iso-2022-jp?B?NWErRUtGczdUaTk2TmtOTUkzVFpEa3JPVElzTjZqUlZiQ1hsbmY2SHdm?=
 =?iso-2022-jp?B?enI1aTZYYVpwT3dTY0ZPRkVzUkVHMXNacUpkd2svc2RQK1Z2eVk4Q2Zj?=
 =?iso-2022-jp?B?aWZRbi9IWmRqMzBpaFRJQy9EUG82MWdTNTJnL1QveTlaSTBEYWNaSDhp?=
 =?iso-2022-jp?B?eHo0S3B2bnU0dlhWRkxFcDhia0JITkxoMUFTODFRcHBDbUZKcDVNTW9I?=
 =?iso-2022-jp?B?cmk0S0FFUEdSMHA4WHZab25yVnp4dmZDa3F6czlYTzZkUUVmdlg4dGJE?=
 =?iso-2022-jp?B?Q1hSR2pRdTVTeVZLT1ZwV0JJTEtjOVdRNHZ3Njk4ZzM5aGhDeVFIK0hZ?=
 =?iso-2022-jp?B?VW8yM1g4OU4rQlc0amxyOGtpaXBkTUlqZG5XUUxOWXpVM2hPQXdxYlRZ?=
 =?iso-2022-jp?B?T2lWYkprbVBsUGMrbjBZVWxEbzFtSy8zcHZYd3dhYXA2YithdmFHcnFP?=
 =?iso-2022-jp?B?YjZ3VlBXNzVQemVjZWlxNVlQSkR5TUFxN1JhZ0xlQlVPWGR1VXQ1Zi9E?=
 =?iso-2022-jp?B?Ykw5WEoxRDFCQUNXeGFHM3QxaXdyeTdFUlBlbEp3WWZpQUd0T3lrbm5q?=
 =?iso-2022-jp?B?ZVNGdStzQ2lRWS94WDlETFZMd3NUQVdHN2Y5cWszNUVwR3hKS1doYUhG?=
 =?iso-2022-jp?B?OTdUT1FBUW13M2N0Ylkway9aWng3cVIvMVlCTVlPNUYvbTh3ejFPcHBi?=
 =?iso-2022-jp?B?Q0w1VDdoQlRSSUpkbmhwMkl0YzFpNW9HblVoSE1lVHAycG1vOUg3eXFS?=
 =?iso-2022-jp?B?cFlXUU5ySWRKWXhYOE5uMDZReUpQVmV4K3pzTjRZSEpWY1luY0lKMlNP?=
 =?iso-2022-jp?B?dlBsSUZYNEp0QmRjVTdnT3JJNU5jNEFhOWpDUW9XVWM3Z1Vnb0hCalY0?=
 =?iso-2022-jp?B?eUYrMHhCYjV0SEhKUnJ4OGkydUtRL3FHK3JMazcxdko0ZkhpaHhJTHJv?=
 =?iso-2022-jp?B?c0RYQU1TVnlkRE95b0h0YktQd1dRL0lBbVZxU1JZdGMwSk8zWURSYWFx?=
 =?iso-2022-jp?B?ZUVRVlhiOVF6YTBZMDZQNGVhUThhbW54UnVFaGYxeVhkUXVuem45THdW?=
 =?iso-2022-jp?B?cExDWWsyODlGSERPLzBpc21Kc1NCNlhaTDdkdnFvc25aNkNLbmlWSkkr?=
 =?iso-2022-jp?B?eW9Cdi9ra3VMZ2ljTUVHQXcvRVhsMmlkbmU1QlV4a1lXOG1lVytEaFpX?=
 =?iso-2022-jp?B?SEVuSTBEVkRaN2ZHK1AydVpFcnlPblJhdjl4ZmthZEQ3ZGtLTUswMlV1?=
 =?iso-2022-jp?B?OU1UVHZDNDkxcHRCM0xqcWt0OWpYaFljaWZJUzE3RWZtTkRibEsrdnhM?=
 =?iso-2022-jp?B?enowZ3VybTNubGpUbVRHeVVya25MeE9oZWJsRjFFZUJreXRQSHd4cEF0?=
 =?iso-2022-jp?B?WEVweUFlLzlQelh5R2F3OVNGdHE0SmhkRkhNY3BKM1FzMVlDK0tPcTg2?=
 =?iso-2022-jp?B?UWVDWHNISmc1SWpUS29XT3J3czBMNDVwWWlQTk5FaHRzeHJuWXJBWGY4?=
 =?iso-2022-jp?B?Z0hjOEY1SFQxcUMyTTRVM3RnVW9XYzREK3lVOXZOU0RyWDN2b09UbWRC?=
 =?iso-2022-jp?B?T2lLdGpRcVducHFtT3Bzb3pXbjNuT21EaGtFZk9tcDloT2pKcWlCTHNp?=
 =?iso-2022-jp?B?Vjkyenpac2w5Wm0rYUw0NTNxVEMxeGtBdW80V3YwVlc5eDBPNk4ydEl1?=
 =?iso-2022-jp?B?aU5FRXkrU0VUeEVCT0pMWnV6NUpDdENwdHMwS0NZck94bEdVVUlyai8z?=
 =?iso-2022-jp?B?SlF4dFdCMlNOZ0U4Q0dHM2pqbzJXaW52aVdLV0hQVmlobHJnY0E1ZFNa?=
 =?iso-2022-jp?B?SVNWT0tpZjY2bW44dkJyUVFoVUFLWjVRTDh0WXNTTEw0NDBQRlorZGpM?=
 =?iso-2022-jp?B?dWdjY0lqRTVQdmNxcmo3VjVDRVMzZklubTFWeFRjVk9mOHJ2ejFOWVAx?=
 =?iso-2022-jp?B?QzR2SUhhYkNkU1FlZktHL2tLQnIxa2NsMi9vMDNNUFo1cmlFejBHaDB1?=
 =?iso-2022-jp?B?TWJpUDRvN3VjeGYwWWY4dkdkWlhJK0g2N2g3MWFrQWcvMnJTWjFia2FH?=
 =?iso-2022-jp?B?YkNzMnUrUjdmZE5MdWtVKzMzUGNPMERNY0hWT2w3MFpVNjNxeWtDb0pj?=
 =?iso-2022-jp?B?UVRkL0U5M3dDUmYreGVSM1ZGbnk0aGlESDQ5S2dZbzdkWXZsNjRyeEEy?=
 =?iso-2022-jp?B?RmN4ZTlTbjh1cExrc2xHL0x4VmpaOHZwNEp2NDNoTGFNdGIrd2RsTGRt?=
 =?iso-2022-jp?B?UmJKVEU9?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58db7f6b-1aa9-43be-22c4-08d99785ff7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 07:06:42.1656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04HzOhDIx4083e1MRMIuN6GoqBHqjCLl/sHmiJh6ANAAmMuKr/fxzQ/dtVJoaeDQVCC60PAz0kLQc6Ip10OPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, October 25, 2021 12:31 PM
> 
> 在 2021/10/22 上午12:35, Parav Pandit 写道:
> > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu
> > 9000
> >
> > $ vdpa dev config show
> > bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
> >
> > $ vdpa dev config show -jp
> > {
> >      "config": {
> >          "bar": {
> >              "mac": "00:11:22:33:44:55",
> >              "link ": "up",
> >              "link_announce ": false,
> >              "mtu": 9000,
> >          }
> >      }
> > }
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > ---
> > changelog:
> > v3->v4:
> >   - provide config attributes during device addition time
> > ---
> >   drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
> >   drivers/vdpa/vdpa.c                  | 33 ++++++++++++++++++++++++++--
> >   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
> >   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
> >   drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
> >   include/linux/vdpa.h                 | 17 +++++++++++++-
> >   7 files changed, 57 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> > b/drivers/vdpa/ifcvf/ifcvf_main.c index dcd648e1f7e7..6dc75ca70b37
> > 100644
> > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > @@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
> >   	return dev_type;
> >   }
> >
> > -static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> > *name)
> > +static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> > +			      const struct vdpa_dev_set_config *config)
> >   {
> >   	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> >   	struct ifcvf_adapter *adapter;
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index bd56de7484dc..ca05f69054b6 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2404,7 +2404,8 @@ struct mlx5_vdpa_mgmtdev {
> >   	struct mlx5_vdpa_net *ndev;
> >   };
> >
> > -static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char
> > *name)
> > +static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char
> *name,
> > +			     const struct vdpa_dev_set_config *add_config)
> >   {
> >   	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct
> mlx5_vdpa_mgmtdev, mgtdev);
> >   	struct virtio_net_config *config;
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > a50a6aa1cfc4..daa34a61c898 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -14,7 +14,6 @@
> >   #include <uapi/linux/vdpa.h>
> >   #include <net/genetlink.h>
> >   #include <linux/mod_devicetable.h>
> > -#include <linux/virtio_net.h>
> >   #include <linux/virtio_ids.h>
> >
> >   static LIST_HEAD(mdev_head);
> > @@ -472,9 +471,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff
> *msg, struct netlink_callback *cb)
> >   	return msg->len;
> >   }
> >
> > +#define VDPA_DEV_NET_ATTRS_MASK ((1 <<
> VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> > +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> > +
> >   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct
> genl_info *info)
> >   {
> > +	struct vdpa_dev_set_config config = {};
> > +	struct nlattr **nl_attrs = info->attrs;
> >   	struct vdpa_mgmt_dev *mdev;
> > +	const u8 *macaddr;
> >   	const char *name;
> >   	int err = 0;
> >
> > @@ -483,6 +488,21 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> > sk_buff *skb, struct genl_info *i
> >
> >   	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> >
> > +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +		macaddr =
> nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > +		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> > +		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > +	}
> > +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
> > +		config.net.mtu =
> > +
> 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> > +		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> > +	}
> > +
> > +	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> > +	    !netlink_capable(skb, CAP_NET_ADMIN))
> > +		return -EPERM;
> 
> 
> This deserves a independent patch. And do we need backport it to stable?
This patch is adding the ability to configure mac and mtu. Hence, it is in this patch.
It cannot be a different patch after this.

> 
> Another question is that, do need the cap if not attrs were specified?
I am not sure. A user is adding the vpda device anchored on the bus.
We likely need different capability check than the NET_ADMIN.

> 
> 
> > +
> >   	mutex_lock(&vdpa_dev_mutex);
> >   	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
> >   	if (IS_ERR(mdev)) {
> > @@ -490,8 +510,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> sk_buff *skb, struct genl_info *i
> >   		err = PTR_ERR(mdev);
> >   		goto err;
> >   	}
> > +	if ((config.mask & mdev->config_attr_mask) != config.mask) {
> > +		NL_SET_ERR_MSG_MOD(info->extack,
> > +				   "All provided attributes are not supported");
> > +		err = -EOPNOTSUPP;
> > +		goto err;
> > +	}
> >
> > -	err = mdev->ops->dev_add(mdev, name);
> > +	err = mdev->ops->dev_add(mdev, name, &config);
> >   err:
> >   	mutex_unlock(&vdpa_dev_mutex);
> >   	return err;
> > @@ -822,6 +848,9 @@ static const struct nla_policy
> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> >   	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
> >   	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> >   	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> > +	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> > +	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > +	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> >   };
> >
> >   static const struct genl_ops vdpa_nl_ops[] = { diff --git
> > a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > index a790903f243e..42d401d43911 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
> >   	.release = vdpasim_blk_mgmtdev_release,
> >   };
> >
> > -static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char
> > *name)
> > +static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> > +			       const struct vdpa_dev_set_config *config)
> >   {
> >   	struct vdpasim_dev_attr dev_attr = {};
> >   	struct vdpasim *simdev;
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index a1ab6163f7d1..d681e423e64f 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
> >   	.release = vdpasim_net_mgmtdev_release,
> >   };
> >
> > -static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
> > *name)
> > +static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> > +			       const struct vdpa_dev_set_config *config)
> >   {
> >   	struct vdpasim_dev_attr dev_attr = {};
> >   	struct vdpasim *simdev;
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 841667a896dd..c9204c62f339 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev
> *dev, const char *name)
> >   	return 0;
> >   }
> >
> > -static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> > +static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> > +			const struct vdpa_dev_set_config *config)
> >   {
> >   	struct vduse_dev *dev;
> >   	int ret;
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> > 111153c9ee71..315da5f918dc 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -6,6 +6,8 @@
> >   #include <linux/device.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/vhost_iotlb.h>
> > +#include <linux/virtio_net.h>
> > +#include <linux/if_ether.h>
> >
> >   /**
> >    * struct vdpa_calllback - vDPA callback definition.
> > @@ -93,6 +95,14 @@ struct vdpa_iova_range {
> >   	u64 last;
> >   };
> >
> > +struct vdpa_dev_set_config {
> > +	struct {
> > +		u8 mac[ETH_ALEN];
> > +		u16 mtu;
> > +	} net;
> 
> 
> If we want to add block device, I guess we need a union as a container?
Right. When that occurs in future, there will be union to contain both.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
