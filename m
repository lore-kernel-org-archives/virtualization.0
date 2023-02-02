Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD5C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 05:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44A7F6109B;
	Thu,  2 Feb 2023 05:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44A7F6109B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=beAX8vuw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7l5rBC9zbV0; Thu,  2 Feb 2023 05:05:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC4E960BA6;
	Thu,  2 Feb 2023 05:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC4E960BA6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA6FC0032;
	Thu,  2 Feb 2023 05:05:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03855C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA2626109B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:05:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA2626109B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOfWbFLamXYp
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:05:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C40AC60BA6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C40AC60BA6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP1UPrRSBGoSJzmJVkajr9b0Y1ycEwg16+ZzxNcW7KQIbYhhBjDWtagwkEp+YOVqJE2DqbM+eGbSVltY/w4GBeafTRZlZMaH7Orz84e2d3LEV1vZO25pRBLjGihs+S6B1v5E9ZRDWMM8yJ5kE9vyGn8lKnLu3iPvVhYo3bKA30K68uPbrrUJPs+mZbbn5h/czeRblkwJ3hid22csTc8AxpBpAZri/mzr1oMmzQiQO7G56FRVi2cTwUx6tzjmxqlzt6kc6A3qgOUPGMSLEHSrxmQbfTduyXW5q7WQkRlW1JCum2KesKjWixbimA7pW2C+ucdUh/0I2d2k8nOCpFKBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7TTyEYi9ksCuNCeoI3EWgi0pMSNUv8s/GkS34U7O9M=;
 b=Z6+4yGn/J9Z4lanIqEZzGNuOvsJLAgtzhKqY3hLo2q+1jo6TzWazGRFsBTVkAVSpuc/WANkKN4zbuBXNeQN49LaENXHpNHZ3Cg78eh5y0Q8sZR6SqTrLvwOzFlFXfTgza0Yv2gYAuZeHblsk0OQeFFy4CGbcNS63RIOi9E3U11RledlOJ3UASYlH4fUySpluryEzr3Txnj1B3OHB+t3V0ia452SRN9P5dP7knExjjfv/SvTpzlKn8uJW+n0kP2w0iMxutFQ6RqlRZFN4Rye0P5a2uC0i64DhddVyAL7Xz4oNfhw8vSywtwUpN2yXjpdohVbTvrFIl6v9XIks6n0q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7TTyEYi9ksCuNCeoI3EWgi0pMSNUv8s/GkS34U7O9M=;
 b=beAX8vuwqhK2ZgsLAaTl5BiHqToDsygoUj8DTMybAsdUmtu0/jlpyXbZxG+Y55bjq8V2IxO5/woV/2sb3QwyAK6wff52jKtZgb9r0jniLvWOLEZJhfW7Cl2Wb0ZD40WT5Aq1iW1YmxR8cUplmOvIkRv0kODq6hddsHOO3G4RpYl3P/s9gASlVJG38Zuf2rRb8mKsYHlVQOzfyWtFFzKKpRny9fNBZL3Z4U4KGxt6Lmbu78uY5jLTDR7OqvpAMLOPR4Z2IAt903Gy/yWLhKJved4FlKjDKBNEOqJKr6qonToZ/crfV++zG/ocN5PrIjVvMizq7tzosz4DWuCgjO1D3g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 05:05:47 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0%4]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 05:05:47 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH v2 3/7] vdpa: validate provisioned device features against
 specified attribute
Thread-Topic: [PATCH v2 3/7] vdpa: validate provisioned device features
 against specified attribute
Thread-Index: AQHZNcrul/O2ZyBovE6TfvS9k66n+q67G64Q
Date: Thu, 2 Feb 2023 05:05:46 +0000
Message-ID: <PH0PR12MB5481759D5CA6EB5C9D63C517DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-4-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1675207345-22328-4-git-send-email-si-wei.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4542:EE_
x-ms-office365-filtering-correlation-id: 838f1d95-568c-4d9c-5b4e-08db04db2521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYJlJPLBtyVXnBO4wflOEhh1AWIYa2vGR6PzHgjfthWrrtNShEKu1fj0uirkRwRpboSbB8N+SJTSdagA9C9orpX4OPE+4ZVO7AayEHR+kFZ8gmfbPLmddQc/h2zH0hJAAJJ7pEuhgw05mIJklV3HABb/BiTHtS2YeHcP4Tes+9QHW//Q+UfFKHwdPO/l/iqTLRncQ0bdRxB8slG+whrlWDfdRibKEgKZwPRfKTDeBLZedO7FQLDsLPydAa0nNNIkE73YFDmE2Q3Vj++4ossxFsDxFXIux5PsJUKtx0E8zNmrAZeHdTjpO0bWKuSRulp+W9nSfO9tgByWuMZJ5k+5SOFzVY8m+q/iJO9VlJCjbdNUMjHKp4Q88mBkGsFB45AjF48lvCjvn1hrKH24RMukg49clJXUcKDGXvE2X0AqOx64SBz9q1zi0NIl0393gbYGENzJ16M3J5xzYF+OwzWsSP5qU6SZYkBUl0SM2OacFO02PgiKpIcod2MaC5Y3aw++eCHilfc51v1HhlX9xVp9FRAZVLNS2qekYc4pPPfrH3mizpLhFWwrvb760SbGjMqT7BXD4o4ojBPpkEIDcvANdGJ+ScEpYS8PFro/ah097RLS06MK1lPS0Vzce5xxnSqFUPnOGAqkHsID9YhzXMjx3LrwNEJME74QM+rHjZixued0ak0YVjONKQFDJZJnA2bso/TwQAH0N5LCVBlG5EXmpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(5660300002)(41300700001)(52536014)(8936002)(66556008)(66476007)(478600001)(4326008)(66446008)(76116006)(64756008)(8676002)(66946007)(26005)(9686003)(6506007)(186003)(110136005)(2906002)(122000001)(38100700002)(33656002)(55016003)(86362001)(38070700005)(54906003)(6636002)(316002)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sK1XMug5whuk5SoPCaSTZV3mz0vYl2dcA+plVA7AGxSmdVSOdYQA4ikQeP25?=
 =?us-ascii?Q?/MMSZdABpESP7sZPXkFiW5SvVzjdGOtH9TgDACxB/+NlVTysiX66XCPtBgTb?=
 =?us-ascii?Q?jaYmEwQsXfJ26dqnUZORDfkGxy+MPPq/rRQEfsThY0DcbtQDv+4uJ50SAmyd?=
 =?us-ascii?Q?N00tpbY0qaYp9lG1zVVJ2m8EdQx8mNgrAQ3hu8rBiLGIsyRVQB2lZmUYBArr?=
 =?us-ascii?Q?IwPtKpCSI9BsL2/I6dykjgiiR1daqYLHCzrfvzFqfow7vF2g7u5azcnJnHzW?=
 =?us-ascii?Q?R4YtqtT+bGbXbYoqfAUMgvHyNWGx6RS5cs3qj+i4GkktuJ7sgyJsJysxj/x9?=
 =?us-ascii?Q?p4jB5lZ3y388lagrWTPRIq6NxXAxR0b5rJAFpx+cEDAU94JWq0b/X+8VZVrJ?=
 =?us-ascii?Q?V5wgdo4/DwIJqaOtbYtpCK5WTe3ih3+pX8KlG9KTt8iYpA9GLORuME9nE83f?=
 =?us-ascii?Q?VElAsv7P3Iqg4HkHl6AygJamF1IFBCbv2MruMcW00BZ6a9zB/lnTN75r/4FI?=
 =?us-ascii?Q?uetyPUvuJ2iB5HQt2cW8AwTtsuKsQC1yef17uOfT6TxJ5uOQlmU0k7rwCygx?=
 =?us-ascii?Q?WCWdh9oRN0TI/rZJB+Fykzce2ezgqruiNXtDvAodzYZrPpWf9HgYxcRdWSAD?=
 =?us-ascii?Q?bMnHiWxgFW9HoXuK4veLKH3JKHJ/qr5s9cwghBx+A3Xf+4tr/YjsZ/UqDkHM?=
 =?us-ascii?Q?ergBklaNvV7AyvmgxqZJ4bq5/jP9OCZpYHr9tE4qhH37EGqT+rV+AGVnhfn4?=
 =?us-ascii?Q?dMammGStFBzTtihQFMDG4/uW1pyGAvvaWm89pMqNo0Y5pdLYbMUOXt5yRSaB?=
 =?us-ascii?Q?Dyug8x5c1Kdpgx9gRGX4cK4IOij6jyU3JT4WcIyKtJhxJrUlb9N7XTOSegKG?=
 =?us-ascii?Q?+salOOe9iURnH2zaxWK4P4rpFjSLF0y5t0bnhHDhopXa/hPJWUbTgp8K447E?=
 =?us-ascii?Q?OLAc25mfcorKr48QODnAUs+rvGZy8cjdl2+JgKjYzxjp7Wsqdp8yFAKI9U8A?=
 =?us-ascii?Q?FR72K+hzoH//sGieSJZktDDSYmqFh4CYlGY/nVZVRuPhh9Ea0ii5h4q3mMuT?=
 =?us-ascii?Q?A1ytc9ZhaO2JWik5FDHEDPPdVwnCm7uKuwskBKcAytcEoC0aiiEj9gjosyAC?=
 =?us-ascii?Q?6uTwszI7qcY5ruNekp14XggcuCnedYaQN1kboWEj2ffeTRk4MEiRvMCaKWqY?=
 =?us-ascii?Q?gJ52VJmHkwUn1YeVtwPzan3Xet+lpq1YA374QnxQ0ZgLLg4hNPNvWkKOo+TM?=
 =?us-ascii?Q?9swo4xiiAjbS5IaTqOsGWDWIRzEnvNXgOYwD7CDRRyw50nXxmykDy667Vo8v?=
 =?us-ascii?Q?pJW86YfQEft8cEqKoTZVRwtFdBNXyL1n+dIQiaNKKtVwS+Bfm2HV2ID/evrZ?=
 =?us-ascii?Q?Cz1hThCpgt5d/3BHgC1+bkxysR9+B13d0xi+kkQgq3ZAL7IsCfamZdsQQjTL?=
 =?us-ascii?Q?DD7VR/HCXxV1eDA59krwRHrbJqRq8xssQelQkRrnZFzpiB1cnQ18iRnmlfUM?=
 =?us-ascii?Q?s9tVOBXRC1VVuGJVqoSrOIkccUNYvb1gWXCplsJnaX6hmADHqbgDTZQbekzL?=
 =?us-ascii?Q?8Vl3CP4pmX88m8fkX48=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838f1d95-568c-4d9c-5b4e-08db04db2521
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 05:05:47.0193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+KG/D3Zfwxv+et+aVppr2o1lrsDuGnUYHCWMRNs8F4+n1X9G13fGI5AXfV+7IESnPeQxyx0AKoCd5dfnel5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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



> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Tuesday, January 31, 2023 6:22 PM
> 
> With device feature provisioning, there's a chance for misconfiguration that the
> vdpa feature attribute supplied in 'vdpa dev add' command doesn't get
> selected on the device_features to be provisioned. For instance, when a @mac
> attribute is specified, the corresponding feature bit _F_MAC in device_features
> should be set for consistency. If there's conflict on provisioned features against
> the attribute, it should be treated as an error to fail the ambiguous command.
> Noted the opposite is not necessarily true, for e.g. it's okay to have _F_MAC set
> in device_features without providing a corresponding @mac attribute, in which
> case the vdpa vendor driver could load certain default value for attribute that is
> not explicitly specified.
> 
> Generalize this check in vdpa core so that there's no duplicate code in each
> vendor driver.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index 21c8aa3..1eba978
> 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -601,8 +601,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> sk_buff *skb, struct genl_info *i
>  		config.mask |=
> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>  	}
>  	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
> +		u64 missing = 0x0ULL;
> +
>  		config.device_features =
>  			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR] &&
> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MAC)))
> +			missing |= BIT_ULL(VIRTIO_NET_F_MAC);
> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU] &&
> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MTU)))
> +			missing |= BIT_ULL(VIRTIO_NET_F_MTU);
> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] &&
> +		    config.net.max_vq_pairs > 1 &&
> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> +			missing |= BIT_ULL(VIRTIO_NET_F_MQ);
> +		if (missing) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "Missing features 0x%llx for
> provided attributes",
> +					       missing);
> +			return -EINVAL;
> +		}
>  		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>  	}
> 
> --
> 1.8.3.1
Vdpa this layer can likely derive the feature bits for the supplied config fields so that user doesn't need to keep track of both.
Only those feature bits which are unrelated to any config, is what user should be setting.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
