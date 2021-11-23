Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D61C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 03:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D29780E06;
	Tue, 23 Nov 2021 03:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PoF5bRmIIlFp; Tue, 23 Nov 2021 03:12:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0ED6680DFE;
	Tue, 23 Nov 2021 03:12:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA651C001E;
	Tue, 23 Nov 2021 03:12:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 864B1C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F56380E04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kMuoWJD1o0OI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:12:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48B5E80DFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 03:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWR7y8OXrBdu0h8KmOcFkVczYl/ro9dKFSl+lt7eW0aupUS0EilN19YruSR/h4Ls91Q62LKjIrAOp6XdECGVXGCFeibpl81SnpghoTF1GpUqMmYn13o/COevxpvSCTSqaCaGH0a65fi3qtePRvgbqmSrC88XWPmBX+C89oq/QtckDX+IQ36ZB2H8Vz+53uuBnj5Za6Mc5OUrtZjnsUYlwM+iQYrPmndlZe2UelB9YFoV0dHB7iyxp+KRveE1EJNS0ADcKU6q12hGP66PZNZsLJxIWgn8XrEEG/S4vNxwZrCcWuiSp4FdDoh3yiizOzutlMJbazCYEETtcKYujbfk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev4b1rZDM538EpSxPVek0grVPe2pqPCaKLWZTq726zY=;
 b=LvGcZk4TVmslD391v5BLMBe2UE/55BrFIxcru3EPmEKAc8qYm4QfJNedFb7JzikJSDDS844nRMOSqA87AVOIvvRVC53FzNahMjQwrpfjJrF7ZUR/LbyvFu3GzilaVuIqhdBuO0EAHPLWrWpKMV2iZPcvurR7WjCt8Zzp8tvKA0p0SxJkFmOKP1+h+8Wy9Jh/nq/VLeCAWEOFVvTf/1/Y69VfWSQSCdcsX5mly5N1XFSCo8/HO3kuST0gtay7xm0ggShpR6E6GF1G/wZHHxUJIEyW5OuAba1Rs+1wcwOhIqDWWz8c9cSBLNZWAqhPFxql6plVxLsdF2TFMFSZTVlX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev4b1rZDM538EpSxPVek0grVPe2pqPCaKLWZTq726zY=;
 b=qYosKzFQVvRTqVCUGbafdQbYX1xLSEf7aLoqLwejREQtEOFDCp1zdovhmNBQow3SxLF+HBAEzN7vJ+Qr5CianvUq/ozMUy0GsGPkWOA/rN9S9q82CrJ81IU3zNqqdgKe/pamfI9ab8xt/kHMaad4CZtHr03m7NIRvWidx6eU+J7W4ev3O877csqG+beTjqkS3wETH8py3R4+PmNunV8rL4zPxr56qjkXUiB0shJom0OMszSsevHkVNc0HirZYKxUb9lwd8Qb8L3GvG/B/w69w9ax4WI6429Ec+SPp+Zfi/nF/B7jKXtzveIGhBdbcwNPAJbwDFbrnyATNUhRnaS2iQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 03:12:31 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.022; Tue, 23 Nov 2021
 03:12:31 +0000
To: "Longpeng(Mike)" <longpeng2@huawei.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Thread-Topic: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
Thread-Index: AQHX35ueaWYQw4IqXUGs9TH2rQN8bawQcIOA
Date: Tue, 23 Nov 2021 03:12:31 +0000
Message-ID: <PH0PR12MB54811F4CC671312DFB2FACCDDC609@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211122122221.56-1-longpeng2@huawei.com>
In-Reply-To: <20211122122221.56-1-longpeng2@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 823045e2-9453-4d13-c315-08d9ae2f16b1
x-ms-traffictypediagnostic: PH0PR12MB5482:
x-microsoft-antispam-prvs: <PH0PR12MB54824A4F201C23F033F082C5DC609@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gMSnNee4px6WUdh1gagYC762gQ3nTeN1i39orhFJ1P8feMemAe8m7GLTAQpAoMt4/OOoxCOSapkMxo9ijz2kkJ1R3om1U5BZkpbxV2BC3LlFnmepM+k1aHGIsjcy8ANlPEnhqmmLnCztKM3XKTGRtLRpWa6a3/FmJbCxCe752eJhAJiwl3ablIobQSktbowCfDfxgJmM31tycSvVtpnhHdt07CfBrOzohPiglzfe0yycb1UnA3Pr/+PiH86K3XhoQNOU+3cacsgalP5og1r9RXNUoVydVNYwNGoKdLzSWZ8tgEUzeN//0ERH6sts5aZfVVNaQOKJxWQgP3ayJi4Eu0wPBH/Oty8yznsjHSqXQIQYL2QbisAooOVljjyvSUP/DovAan0qj/xBskKqUYrXLxY4JD7ITGTN0WrIvQ+xdEEcSMJCA948IbckyqZqlnQBjGsoZOJOmfxLw34o0ZpJpQ31liUd6/qhg3FPYBb5sN5mQB2Daj3GZDPAQ/NLpTGHc23t1wVaAclTtdyf2CpdryaCFMPutGvijLCD26pMkr0SbPELTFriAY9rnzpQNy6Y9ddLBWBk35/n/MNEPOprVPDjEy755q6D6WfAtDPwH9B352G4Qlz+Tu7CIoD3lahk2GOEFls86x4JfZTLmy6jhTw02vUfU5X/HY7y3zS+e6hsY42ksH6syqaa+s/HnJ6Di3MT0XWIMXqaznXTOy4JpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(6506007)(66446008)(8936002)(52536014)(5660300002)(86362001)(64756008)(4326008)(38100700002)(9686003)(2906002)(26005)(54906003)(110136005)(316002)(38070700005)(7696005)(508600001)(186003)(66476007)(122000001)(76116006)(83380400001)(33656002)(66556008)(71200400001)(8676002)(55236004)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0xgIg9TYiG0uMNeQEHIK52P+sJuAHuzxv8N1UN5Cu2daKoHoqg7e4Uer3K9k?=
 =?us-ascii?Q?pJLglyHYl8+rQFW3WSVGU9hEB+kcvrhpJ0dxn0JE/9g+0e2y4HA2inhRRNNm?=
 =?us-ascii?Q?QxzdYZSum61C2Nb1Rh7v/t4HzR64j9rLSnhhRwMZYYrRqTfaR7LukufGJDbL?=
 =?us-ascii?Q?+UCRdIcs0zVzT6cymVkeoYazeT9erROxqLRmZKW1eJrRGj52MeNmhKLCblN5?=
 =?us-ascii?Q?mfLldJXuxGrDlq51DcTZPzmlKjnRcbeO/L7I0WQ1fNOGhpSzBsGR4Y8of8Cl?=
 =?us-ascii?Q?HuhTcS7fk+R91T5FfuCzJDio49p+uKEmLYHXcQRCXoz3BhTTcoDNQSiKDqWu?=
 =?us-ascii?Q?yyvXvGyEQBpt8WMyQ1agQ3LFcieJJudaLM6RH5DWqkDzSftTB0XGzImEhZBs?=
 =?us-ascii?Q?MF3TP8tBG57wDZg68kaClChp1kwpO2gSzlZvnIWot9HyT1eGtLPnHndIQrv7?=
 =?us-ascii?Q?jVkm3lkeRzoY7NhTJYQz3G3cT61kmOBnlK6zGcLntwXKS3gqKdk1Ph/qKeAn?=
 =?us-ascii?Q?ww+HI1CK9cZ2KvtyExN7d5Wrj9UDK4bvtk+MbA5Rj6D4FSVkpsOwCX/H3j5z?=
 =?us-ascii?Q?xZC9W39p2qMyqsRh3vYLH+Ad20UtlW1GhICaVxFS+e0ApK1MoYS6OdgZmIqp?=
 =?us-ascii?Q?pmHHD/rOeLubIG2v3BxoEYVBbtPts1ys3wwTlQo+QrvT1RJKAltd0dUAQFjt?=
 =?us-ascii?Q?sLDSA8HwZgKtfEL6WHziuyOAFvBjC7WR7tk3NmPKKzL8XH+ZX2oy+e9Fq9aK?=
 =?us-ascii?Q?aDgckYOwx4zZtyWEoyj0NTopE8pkJKjFRee7NXID6PHDWcZeipFFanBAf0Ev?=
 =?us-ascii?Q?xJkC4B14spc3E9jVvMvflE+rOf7ah8yzF3uFyoAKF90admgh6Q9Hfo2j4z/w?=
 =?us-ascii?Q?Kx34AQSHRyOv2CN3QefEi1FU57CE12jw+BItxr11t4maWyqsf6GarEfLyL1c?=
 =?us-ascii?Q?lvkJ0ptw9oj3LrDHZnDSv6TuOx7N/CwjeNUAEFf7VNIPIdTOTiGVrL4O2R9W?=
 =?us-ascii?Q?5oXcVf1P4NbbAk5F0Jjm21CA3l9mPVWDyHLoAdLmyYM6bh0RkI05DWGCS0Ql?=
 =?us-ascii?Q?eHPymVfX27AT6w1LgXz+A9+tWpVxItPThQqUiCeGZXLt82jvtTafsmECOUxB?=
 =?us-ascii?Q?Hznx5rUJpBil2VpHqZPH2x/2gMeG4IMrLaYPkDukURql9y4W+quTSL9/3/2w?=
 =?us-ascii?Q?GVuCTpM97cjNpqHtrpqzziYg2gIcv0gTlZTNdLkujdzlTra+uLTFSGs+d+Ta?=
 =?us-ascii?Q?pNHMZkQsAe+Q9tOojtkWZ+QlXBPqmP0i1RWxA2MHmVAskJopwwUzAPgNa18L?=
 =?us-ascii?Q?JZmpsY8zK4xiTQvGpC9iQdj49MG3k1LQUDhnDQ+Ou59KjbYumua/y1mvu1qc?=
 =?us-ascii?Q?SpZNpyWN1EkOoIP4r11uE6jAJkHJ6q5kjQfhKzW6pltgDG46uRNfZyihxjDY?=
 =?us-ascii?Q?PkWVzl/Wj6+vWY3lxzSjoPHAaRTHfyNPRjshq8rqiCnEetkqKhHKFqcmJ+2E?=
 =?us-ascii?Q?oldAlFcvVA1MUp4CIz0SH6dr1PcvMTOyrXwJQXTVdy0kCK/plOpqnLFHK6Bd?=
 =?us-ascii?Q?GDkTq18Gt9o8HwaR2D+RXV5Qd+RYSYc/da5ar+YzNwX7E4Lz8Ut3cwKyuQEJ?=
 =?us-ascii?Q?Snxosd+KMsh8vOYzqPXXsf4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823045e2-9453-4d13-c315-08d9ae2f16b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 03:12:31.5805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JY80v87WKSrqPGQcH6LEu2QkrwG3HAyUqpHIQdiBgclVm8f6tArHmwAVsKmadvvPZCT+6WNjn83brxXoKGprpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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



> From: Longpeng(Mike) <longpeng2@huawei.com>
> Sent: Monday, November 22, 2021 5:52 PM
> 
> From: Longpeng <longpeng2@huawei.com>
> 
> The system will crash if we put an uninitialized iova_domain, this could
> happen when an error occurs before initializing the iova_domain in
> vdpasim_create().
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000 ...
> RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
> ...
> Call Trace:
>  <TASK>
>  put_iova_domain+0x29/0x220
>  vdpasim_free+0xd1/0x120 [vdpa_sim]
>  vdpa_release_dev+0x21/0x40 [vdpa]
>  device_release+0x33/0x90
>  kobject_release+0x63/0x160
>  vdpasim_create+0x127/0x2a0 [vdpa_sim]
>  vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
>  vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
>  genl_family_rcv_msg_doit+0x112/0x140
>  genl_rcv_msg+0xdf/0x1d0
>  ...
> 
> So we must make sure the iova_domain is already initialized before put it.
> 
> In addition, we may get the following warning in this case:
> WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
> 
> So we must make sure the iova_cache_put() is invoked only if the
> iova_cache_get() is already invoked. Let's fix it together.
> 
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Can you please add the fixes tag here so that older kernels can take this fix?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
