Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB80C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 05:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D823403E0;
	Thu, 25 Nov 2021 05:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZ6AYGuMniXa; Thu, 25 Nov 2021 05:29:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C00B74029F;
	Thu, 25 Nov 2021 05:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E6EDC002F;
	Thu, 25 Nov 2021 05:29:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17170C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E610D402B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o7WTotcscgDU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:29:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2080.outbound.protection.outlook.com [40.107.102.80])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68AE54029F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP1y2rUkFQSWJRtTGgSPmRg/pfXUgzTB3/RkKAzE5sTpDZ9itv4qDYgZAf8rnWwpiIak9NdN/LAdLBF9DsTIqt2JBxvQ4zhx1yUSPt4alKq2OmEp6JHrYqpA8uwwmzHWt3rcxKvU9Jjo1oyhgT1fqgnfGTHqrwNaZ9uia2I9yIhb64acAgBnncdkdbRY2RGEyDis76BbcI+DpVXsMUhRRoISaEiE4J8Rf2jtIYMOdIixR27v/Hz4BRe2SF62VXrNrHgUlXjRQAQx8dAWUbLwg07CC/Op++YlWeO35fA1R/++Vq4pKmEjp4YD7/Fn9edflufot92Y5leWEvhI0CxHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLSDYWOlRlmf7uky50Q+dTRGb5TS6jcetj/0VulMVog=;
 b=i4C3PII6BRW9WA2TdoOKQ5QMOD2/cmesnM7bWDR6JCU99O/hBYjCY/a6zmWVipBe/kaKKl4BfYjl+CzFuvm+LSlhoqkitXkVqa4ooUDEkwaLapyAnkpQVBBP9Y/753ik3Y0BZ2rJoKarWXGOlIkOWe+COuDRj5jmUB0QTHVDh6lEuyZfX2kXQaMakNGVxnxgco+g1oVNddhFP87N5La1C8efVDpSTkA6DoWQqSbK7lXPouO2sM16jOnxslxtQhjK4jVwrvHQqJsdcKGjBTSEiBVZMa4kEqiJV68eJ/JqKl+cEYUkTIrINlijM4XJPdRGd+8TdmbvAHwSQZa3R3r8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLSDYWOlRlmf7uky50Q+dTRGb5TS6jcetj/0VulMVog=;
 b=DkqeExyUM5Rq+yRjtWSrX77Hv6K08WhKIV63QBciqBmUPzSo2KPhs47Yrx5FSQDE2zS0tgfrfYZWoC7aoQoyIF9SYmG4QsiAThateJ+H+vfXrPA2Kx7BzeZqhPDdmYf9TJNoef0xicXZJfHe6IrMntJHL4nMutwdomQ+Ia9v3Spd98jMB7Tz+ezgrBWNGEo6JRREt73FbhvD356/JUt38KkeVh6EcC6n/SMgfvUU9RTnwzSvYKazIudcJvFSn0V9g3CbMCefwz9zEsUO/SjFGByCK9kmCTQZQJz4CdQ+rpeXMbKLfJCfi8b5cEG5kjtWXbQAR1oB3T2AJ8CzvdYNOg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 05:29:19 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 05:29:19 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
Thread-Topic: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
Thread-Index: AQHX4VYkiZKl8sfu3Eqo3IWvXH+WXqwTtRfQ
Date: Thu, 25 Nov 2021 05:29:18 +0000
Message-ID: <PH0PR12MB5481CD17327097D7E7865B8DDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211124170949.51725-1-elic@nvidia.com>
In-Reply-To: <20211124170949.51725-1-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44b4c792-a70c-43f6-4cfa-08d9afd48786
x-ms-traffictypediagnostic: PH0PR12MB5402:
x-microsoft-antispam-prvs: <PH0PR12MB5402F9A16518955EFD50BEEFDC629@PH0PR12MB5402.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eQLxW2yZndl0VTBwxCUvOHBM/+tkOw05iIbCLZ4eNXNQOwK7CfBaB+AeU/2I45N0XJtIRYaLqtqwonttkKs4+ng+huuZqfZGFU36hEixT2dPhdTNh6ogQ5JVzlgg9ZIitSdKPR2PhHvb4Jnd3azW91dwhUmFmv95wXUsmGASSLlTNAIXqkBT6NgQ7OYJz1fnwDPiG4phvb/YqUp/SgoRzEflodm8Emrn6VZcS4HG20CHNxWQaRmq5Jq8+e1onM9H1/K/+Dq1KhiC0is2PN1fqvhedIJighR8Dk3tLKOHhzGH3WwZ2N7+BoBkHRE+PkX4fAplNPqFsDpowf8+77UToNqSY5XEeAkCsAMgUEOSzZntcDGhZyFAhY3c9wA7XP2PJCke4bRom4okZBp7b+am4h+ZkLmmYibicglLiriqDtisg9corFFmdBlr0bpVVT62pmcdlNfPBeLZmsCqGGlkniffFyRx6iPRkHv0DRBQ82VCM/JQLZGwrYVbVvhgLQOXOc/Unz33LAb28PToZfW4LUKTxuxGmA5Z7fGV6Y+Kx51AShL6n3IeRciRHFd+ohriMKhkT0OiwkYEpogcorxP96MpqdQMyg5hFgGWHcpFOYkKn6ZuNi/6M5UPOMXObIxVHfTL4zJLh7lzeq7nUECFugavF1CKdWQqZd4m9ObZ8sFcBsPce1nUccclUcpCJaBm9+bG4vKZ/RWGCWqPzmFyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(5660300002)(7696005)(122000001)(66556008)(8936002)(8676002)(110136005)(33656002)(6506007)(71200400001)(52536014)(64756008)(66476007)(54906003)(9686003)(55016003)(508600001)(76116006)(4326008)(26005)(38070700005)(66446008)(38100700002)(66946007)(316002)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E4q/4TRn6RKoYQjcO43iIbXQLDNBUhZEvUqLlBbTUK3xNuAt7kPaFEnoYnxi?=
 =?us-ascii?Q?LDeeYc0FIP1ZRp0j1LOPvuImKhDm7+cGH+uXfGqO2FsHI/eiqXbeafc1Twsu?=
 =?us-ascii?Q?MYiuYJdwMmJgGq/GMVqG6J1oL3GsnujRh7hpC+aPNXYNXaiIoNq//fDdP4Xf?=
 =?us-ascii?Q?3h5MTRDYNP3qJvPr8UPHkktWmyyPR0tekFdTD4AjgFvXJN3kzkYY2RjXU2gH?=
 =?us-ascii?Q?MZYRXbPSPs5OocI57fECKnexlnMgk1LtLfNQ/USa/9L4H+3oD2YT1rS1x5R2?=
 =?us-ascii?Q?CcM+QFNZjexpgelTV2mn2/cKw5yuW2IQlK7K7XgrY2UiBC4sABQwuuEYyJnL?=
 =?us-ascii?Q?b7eflhCzJAL/Hc9XOQAWvKU/RIV7mIFAaCuKY4FvDyvIoGMT8pdUw12xEw8C?=
 =?us-ascii?Q?E6TNGwWzK1XU2ciyB80U6ngYAhrOXMOi19/yJrSwOvx/U03l2wgkzY03e62B?=
 =?us-ascii?Q?s8CIcUDpJSXjAPWJB1rKitv/OhkhykR2aY23ziKEBDCVoffDDeIf3SAnUfKU?=
 =?us-ascii?Q?sStnfrHIbMBQMDHhKaF6cEqTf366j+YynCoeHbGrMaweGkuh0bNUQjllk7QZ?=
 =?us-ascii?Q?91I5HwxoVq4FOTxlE3U9iVR7KKHjTXkCqpUmvdbe6OfhShajXlSoWy5WaMj4?=
 =?us-ascii?Q?/+HGjIu119Q+Ny64j1W2qqR5Sjl4gpqq8GYakSzSA80j4JKSPlDn+JUucDNX?=
 =?us-ascii?Q?lPBdn96632UlI7YBQm15Zf24KJ+aIRVbKi7Tk4EXIyrmoA9yt/qVnqZvPA+Y?=
 =?us-ascii?Q?0Alug1iM4tfWrqKmJBMZ52/bS5uQ9RJCUi0bC/ylvUWEUk8KPHBfAu9RHU8k?=
 =?us-ascii?Q?eEfpst2Q8dBTjAvHU+LoRloBskGSVc1izkxhdrvwBeWY1/9Kusi/PioT4ZtO?=
 =?us-ascii?Q?bwSnczY933DlMunLk2/j3hhc5qsAypxaCDi9kyDMlP6zRqQ8dM+lr2re9ZxB?=
 =?us-ascii?Q?ZZA0DTLa5CkUs0kuXd6l6DlhvHU9R92lVWHPG0C/TT3Bx4l9oMpSwp1xoqYt?=
 =?us-ascii?Q?/5+XsUbVoD5VK8YjbdWxAdZTC+TmpkUfKN//WvMrzqcGIQ3DPM5XGFnUuJKU?=
 =?us-ascii?Q?n7mqTy+M8fuxctdTLRer1RJSzQr+OxP9lVTtZWyP/KtMsRYlddja9/NT0LaL?=
 =?us-ascii?Q?l7ujtd5vTk9pEoStuN0GXsm8uXgkITzEHeRLGIqqnQSUTAieT7+xomtu9IM7?=
 =?us-ascii?Q?rseKkXBBDqWFi63yWfnFJ/C9WXXbOlxuSbBulba3VMoM3W3UNOUYyScmBLlm?=
 =?us-ascii?Q?SkcFFqFnO0CyqzXdt3NEfMwYAtGdP/EDSXVLMrchepnKuFgvLo6frjI2hCBS?=
 =?us-ascii?Q?R8L1wsHuQSrAg9kytu6cXdJ2w602AfTM2ltzN4DkJRJ+A9bxvoIoAkpPLI/h?=
 =?us-ascii?Q?42Hl6oojVz09jb4sFHmzFuCQqzW/VPKmG3N8XyAdZwi2dNg8+4mHvB/v+/uo?=
 =?us-ascii?Q?AvsB2I6dTp4LCyxxnjduyZgIanJUNqleJ6CJss85ecWvRcgPTlFZz3Nb/ftH?=
 =?us-ascii?Q?uNP46nqdb8EjcScqF4kz3ssSHmKq7CP6StamnyZrZousipjTRMye9Ka4QIfz?=
 =?us-ascii?Q?UFxK+hGab/dCmLKDtBoqcQZbAtZ4c2y9F6JaD9eUpEKOnVhPPLM0MD90KutX?=
 =?us-ascii?Q?5g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b4c792-a70c-43f6-4cfa-08d9afd48786
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 05:29:18.9636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUQcuhOsaNi7M9OV+tygvhKJyJyYi0HXdtvZviSL2OzBEnTlSlxhQvCqKExtjXXIu0eFGqW0FYsYNNx4j1QEwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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



> From: Eli Cohen <elic@nvidia.com>
> Sent: Wednesday, November 24, 2021 10:40 PM
> 
> Make sure to offer VIRTIO_NET_F_MTU since we configure the MTU based on
> what was queried from the device.
> 
> This allows the virtio driver to allocate large enough buffers based on the
> reported MTU.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 465e832f2ad1..ed7a63e48335 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1956,6 +1956,7 @@ static u64 mlx5_vdpa_get_features(struct
> vdpa_device *vdev)
>  	ndev->mvdev.mlx_features |=
> BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
>  	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
>  	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
It is better to set this feature bit along with the writing the RO config.mtu area, adjacent to query_mtu() call.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
