Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F47C46467
	for <virtualization@archiver.kernel.org>; Sat, 14 Jan 2023 17:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDF8A81E2A;
	Sat, 14 Jan 2023 17:46:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDF8A81E2A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Jbz5yar0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id me8JgcXHXAXm; Sat, 14 Jan 2023 17:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6146B81DF1;
	Sat, 14 Jan 2023 17:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6146B81DF1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3775AC0033;
	Sat, 14 Jan 2023 17:46:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26D7BC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 17:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D66A560F24
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 17:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D66A560F24
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Jbz5yar0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDvJpd5oEuLb
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 17:46:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C18A60D6C
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C18A60D6C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 17:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7p5kX3Wf0ez338n5ooawoNUJBh/mWZ7COPXq7hkcc5PIuNyibdXBH9KSi2yRawN9i8S5M6rPV2HJUwADy/uj/MNWhW80DXK9+TBQAvRBp3Z8kyZ4osfGtXWl9HfMNluqfCui72123HIRDVwDX0GIUBOqZgptvvETgGA7gKnhmaUpIym4RxaVo3MIyYvpr9jB1cHmec25PUopAuhcDJeckvx7wM8yjQUjJRy5mZDFEbA08a5QFHyMexzVv/HjPcEfYJCOJVKthBuq9LloTDT37Lxcp39QO2uMLioxorUbhB8S+wSpRS0XXDz3Ecs+D2Dn+uXHQqUr3JHNCyCkPMOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HucRTOacQKZIfftBnGub/pbpmterjMrBWkSuUOvSI0E=;
 b=aHLNmsHzjmBfK1TcILOFP27gYsWc3gqG9PAQvaJnpGNKItYQqBLzaEn5kmPBHspTHMH6Ncron07+CngidorSd5315xKFdZRWcxMhc6lhyug6lbU/rVzpBVbgkddk/MMvRIpdsj5gJEcO/AOgTabBQwWTr/EMHMIKDgVXzzVUr75gbaMKffdcwqGMy82/LcUDmeN2tjMV5ogJ344ZH2ZcI1qi0n3YYP5bNoV4FNGBq6NQku9b+WmFQppIh0v1L0ESA99w45Xj5PSXcILsX3nIh0qSAt6+cRt0j93cAjz8H3tc8LChDN9u5zWyDXfVffbD1c86avOitwB5WiWdf0QKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HucRTOacQKZIfftBnGub/pbpmterjMrBWkSuUOvSI0E=;
 b=Jbz5yar0CLObow/8rDxj/zMPTQpkf4oiHsPpDi6HR+AAUkwAgQVQQ4rG1hDh5cBTLX3GD5LH3WcLmI/7CjZ1e9CZcsm4B6p2JzkvVBvsU2g0PApGF6NRvAUZ8Drv4W5ujY1mIw+OGo2IYNebYfOzbBA8H3wF6p12LKYa8CBS3xGN2cEAsasStUim9e4JCCCBRYyX/XHCVRWh5hlz9JTgkyxrZAn1O6pn5UhNQeFBfz7BJqHeNeXbYErc/lZvBLHMg9g/YBQcuLqQVA7zmP5Md+TlYYFHzq7YcDB8EkjTXMFRuVjpy/7oLas0jdK6G7yjHn+t28PW1cV5bYm+yQKxSw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sat, 14 Jan
 2023 17:46:25 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::a891:beb7:5440:3f0%5]) with mapi id 15.20.5986.023; Sat, 14 Jan 2023
 17:46:25 +0000
To: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>
Subject: RE: [PATCH net-next 0/2] Small packet processing handling changes
Thread-Topic: [PATCH net-next 0/2] Small packet processing handling changes
Thread-Index: AQHZJ5+KRYcxJ9e3z06xRfKK0riMPa6eMJKA
Date: Sat, 14 Jan 2023 17:46:25 +0000
Message-ID: <PH0PR12MB54814E482B05FCB4CE24D7CBDCC39@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230113223619.162405-1-parav@nvidia.com>
In-Reply-To: <20230113223619.162405-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5172:EE_
x-ms-office365-filtering-correlation-id: 8d86244f-b26d-40d3-8843-08daf65741ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kh/ilFCq4hGgcx6pQSzTdRj2NHP3XndSOP5tTa+ozYnrQ0ihkwX1TCRahChfEXv9XD5TORNEaPhQDLDduaRKd+gvwWj+1Schf+ILrvyoyP33feRAtZITknjw+Nt+8fHyebDfc/PmpGsEuUiDa/sGCuxHvKOJ+miLW9tnfIxpl1AammrB0RRFhoEUXMZqYe/WFE+eTszAFatJT2WCmLsfMqwNTavUEydUrSE2LblYaIUVjResYKaf7+OdTAe+u99dctYiqb0VcrNc0SpainridMEYMlh99ex1PfC2XlCyZc5HHwEZDV02ctXwU+LSl4asOxQ/MNVaxGUpCj8F2pGltUuc1R32GXRMTuuW/gIvF5c0A7Q3P5q2l9LLYEuxPKzjqbUtrR0rSYUeOedqQ+wqHVLbnEL6GLAYpi7fxAjig1Drzn8J6/iT+A0dWMBWLwSc4QlmbZC8hJ6BrxANygiLttpY8TFc31sOJ88y9koe3QF6MHEsVTx1wA+x1s7aic7m8kong3ypvEm+Dz1oYUuJO4lPpo9GEEvTvOr5naNVNn6s3ONVhZc2QET+84nCddI+3E9k5Cwi7FzlyosmLjVirSADRvIyeh+WotLPODHslkwEqGPUGQZCUOLcFTbxb0k/Nry5Bic15X1K6l33xbzUJNu0YwY5eQaSJIDJsxPl2wIbCwTPrSC71rbTpWJkFadAcGI+aaNrnKH7R3Wui1uf1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(6506007)(2906002)(122000001)(76116006)(5660300002)(52536014)(4744005)(8936002)(8676002)(4326008)(64756008)(66446008)(38100700002)(9686003)(478600001)(41300700001)(38070700005)(33656002)(186003)(66946007)(66476007)(7696005)(55016003)(71200400001)(66556008)(86362001)(54906003)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ywVwOAM+q+8i938UFd/WIYy2kipLsAWTlXLI5ZrG/I8OjpdssGrWzajEtJCy?=
 =?us-ascii?Q?m021UWl1SioD97J9P6meT0Seisx/c2fYZjvYMZMGwM7sePw0NDCNf5ZVcInu?=
 =?us-ascii?Q?nXATdHZi+rpt291QgBUmfVzomuMUqgIgs806xZz7tg8Mdxdl4iVtR6ythXSh?=
 =?us-ascii?Q?PeVhQ38Fj4R3t1eadc0Xg8FB/xuokKcOgH8dhXQpWmvoq38hsiTAMZ3LXA5y?=
 =?us-ascii?Q?pYGx4kBgc5G9qIRWhhFrtHMf9XryVYYjBQbW74qKdLIzTNTh3VzVC847Nz2q?=
 =?us-ascii?Q?ShBHNTpLsZVtOTW9oj5oMsk6Ico8kjFAvbQu53Ag/Haw5Q3VVmWVg4XCzB0e?=
 =?us-ascii?Q?dS+KZcSQu8gtxcNEzQ2UyLr8wB/iai3tYG6xkCW0WVr81+hiDohWkGnE9KdQ?=
 =?us-ascii?Q?hxItFAnXOM8JYm2Oi+MCNexK/jGNYP5D+vEeYClHkEW7/NTmWtGq+QsWxoX6?=
 =?us-ascii?Q?HHz2Oxp1jeCb4ZMScu/ZbsFl/pb41+8T1V9UtS1PyrZEFb7Nxx1XD/jcebEv?=
 =?us-ascii?Q?+iC3GzTQbZvC5ZDcgxoQlvOk5EGp1eI+NZPP92RvV/aF9EttDy8baQLoBViH?=
 =?us-ascii?Q?FqgPZswDrg6zK8Ko73UWKXe7VHgIfzJa3zfxulARqlBFNIuV3vyV5OgXdM9L?=
 =?us-ascii?Q?EIz3yFQYU+ZscG9QezxZfZyG5RRwfCoq3RxjnwwveKS8Fc1TldG/QIKowul1?=
 =?us-ascii?Q?DzWD08nb3tETHF1xAB/qWSi5Jzf7Hu5qfxqT5vBNdGReLf07MoAOYyDGqRc9?=
 =?us-ascii?Q?xdZUG2f6NA/qbxocZ8fqMDr/i4SPBenMOJtaxEeqJaRAYk+danoj1DR0UGUN?=
 =?us-ascii?Q?EZzEJoeeEsrNeuUJvggzE6jcvH0OdnMZlerI/CMHf+D4Xsx3q/hRVwXEeIah?=
 =?us-ascii?Q?4IZS/+Enr6phyGn0C4TeUOOHgVt+fSf7+1N2VtxPL8W/NlnqSB6u803XbtPp?=
 =?us-ascii?Q?OfTvqvV8NlF5PIbKIMdbyv/DadKfoRsuZE6G5AWuUoZ5fp8kXa/kj4MPAGcc?=
 =?us-ascii?Q?QiUnm2zD9XJLtJ40LYlerlD1mrJ51ZCLjHMdwfYjkYVFrRWuTuu5sXN5EWc+?=
 =?us-ascii?Q?godrLCmH8q4dDuEyltWj2EEJdI6vOAFo+qfb95mIaUzPKxS3/ohY36A+049I?=
 =?us-ascii?Q?wrCfKGF72eo8YtdXy+ACwGefThFBuk8HBM/bN3i7ZniHMC3xozvlViNpBcQQ?=
 =?us-ascii?Q?qVPoorVUZFd+CxHlDbElObRH8J/+IAv+XgaNzJ1OJbYvr7Rt1O9c1wYZHeX+?=
 =?us-ascii?Q?dQnovTYJCjcLeRpwQ3GT4mWyhtG0MnhLJM1DggFRL2x2ExCl2rk9TScVoJNX?=
 =?us-ascii?Q?p+KPrEr7r5Nu5I0cd/4gwCT7XQOqY0yJxvjXeUleiMUj2mzlbf3RegWE6NG+?=
 =?us-ascii?Q?wHnzN7hdOKpm6PxO92sCd+HkFYt1gsPl5cQCBkH2Xw4J6mb+79TLXfAJagfO?=
 =?us-ascii?Q?znVmpXwE6uPp0IPxxP3jMYTgKiW0C7+q5o/O+xVh6/ICs56b4vy/ch0wRlFb?=
 =?us-ascii?Q?5RSTgbvrdvNV9OwVXakYeUBfPFC7YJ74Xbl0keMiNAsaeFTsm9j1yE4ceZWq?=
 =?us-ascii?Q?ezqD92t1i2Z291r0F9KtmqtdwsWGV6kuSXv/9z+M4PXu1fTCHGxLLFSDr8ns?=
 =?us-ascii?Q?VJRyNes7MNBsOV10SiAnVE8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d86244f-b26d-40d3-8843-08daf65741ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 17:46:25.2257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdu7gqeehsnlsqd5VPEP00ZVrfMNYsFh4FIPiN+asM6XUxseTzZc+PsUNG5Jxy7ISsR1Z+QyGu/edmsURSCoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
Cc: "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
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

Hi Jakub, Dave,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Friday, January 13, 2023 5:36 PM
> 
> Hi,
> 
> These two changes improve the small packet handling.
> 
> Patch summary:
> patch-1 fixes the length check by considering Ethernet 60B frame size
> patch-2 avoids code duplication by reuses existing buffer free helper
> 
> Please review.
> 
> Parav Pandit (2):
>   virtio_net: Fix short frame length check
>   virtio_net: Reuse buffer free function
> 
Please drop this series.
I will drop first patch as it was wrong.
Will send 2nd patch as v2 which was reviewed.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
