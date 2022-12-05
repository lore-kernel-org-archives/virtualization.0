Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C8EC4708E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 23:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF28140527;
	Mon,  5 Dec 2022 23:04:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF28140527
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=JPlRQk5L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KzsTtSBWdPL4; Mon,  5 Dec 2022 23:04:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54B59404DB;
	Mon,  5 Dec 2022 23:04:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54B59404DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18336C0033;
	Mon,  5 Dec 2022 23:04:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02CD2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 23:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 93C6980B71
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 23:04:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93C6980B71
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=JPlRQk5L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RPsZmkIZuaq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 23:04:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 327F480B38
Received: from CO1PR02CU002-vft-obe.outbound.protection.outlook.com
 (mail-westus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c002::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 327F480B38
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 23:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3ep2IoS3l1kJpO8Ef74zVH+k4QnX4JniGjGtUBFujUoJq+RUAT00IBvtu5H5jAaoJ6ebIGVb5KpcrFLw+NsIpckEivMCNfp1ckMK2U9AzBLBYOJ5fGQLAAFCd/PFeRBoIGjQoVlek5w1GR5BneuwGgJl8j1L7v1JTQJUmsPJZBZ+e06Rlw7Kq/3/Ly1AKLCCwtG1Wtd1SfZPi970AUwgtzT0rjmQA75cYZ8SDkvIGSndhyHuRgP5KC9ajk4WhqflmcFAnCY0NJw2f1G28PNP1S/QL9NMCoXTuwhd28IXdqTt5B277vbFsCf15s4AQyKq2gmSUiyaTQ7ob+uZT/wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20Kf+jnBk1nPR3nM5uqQoF//GpuyODKmmc/8P7Yj63M=;
 b=d2Qpjoa8W4uRfX8cAkNZLQ44getUk0a3ucKeg1d5LqXyvhdpZFVjqyBlo2YoZRmnZr6g/d2y/YgAukJLbZeMNM43I1pitO+aLnjh23FNOsran1zeioMtqi93HlnHuZlyhlua4JkZaq4l004I1CIuqPhrD1RADIFigzOa3iB+fRLndjTWyHRh59LRnkDGMsgTWrbFMvWiO183lj7NeH3e3f4jTHuPMbc857izhCkeH1UldCexjgp1p4mEx32ZURgmW1Y527b0qCIab+1EFD+kRxnJEuxpZoGRko5xYczXdwvu0MFtgf4EUc+Mer9Gy3Iv0YV5IxQ67c7WErMGwLYNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20Kf+jnBk1nPR3nM5uqQoF//GpuyODKmmc/8P7Yj63M=;
 b=JPlRQk5LRWAHLtRavrXREcXFymZXQ76awaWsyOf7ERGYHjYxabfttOtyumfFxWX9jtXtA/UZ2e/Y2387sQPu8nv+wQs1oN1MqRo//zVmPgn75CONKE4zO4YoIoFJCK50u8q7YlKx0X6CnNoxb9XiRV0zSpSC1UJBuj50glwYxIQ=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BN8PR05MB5971.namprd05.prod.outlook.com (2603:10b6:408:45::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 23:03:47 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::6764:941b:e0cc:c4e1]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::6764:941b:e0cc:c4e1%7]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 23:03:47 +0000
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH v3] net: vmw_vsock: vmci: Check memcpy_from_msg()
Thread-Topic: [PATCH v3] net: vmw_vsock: vmci: Check memcpy_from_msg()
Thread-Index: AQHZCKACaX0tDF5YAk21qHDUk/x20q5f6mcA
Date: Mon, 5 Dec 2022 23:03:47 +0000
Message-ID: <C39CC4BC-E87C-4C6D-ADC9-A33E7696BD20@vmware.com>
References: <20221205115200.2987942-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20221205115200.2987942-1-artem.chernyshev@red-soft.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB3960:EE_|BN8PR05MB5971:EE_
x-ms-office365-filtering-correlation-id: 62b149bc-6bef-4528-2974-08dad714f762
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YIAVwSpEPvskyW12JurUIdeP/zI+j4BZiIBLSBTzHeHe1TvC2SSzWPNoWiVuztxtRCODhUboaL0ogyqDWJJPaupBk8WTz2jEDURyo0hjKDryCuXz9+Hw9SLLWyRooUVrjp5HLMHIdTuF1W2bimRZrSyo9SK053//pfY+E6ZctwyDvynkcV/osOd7wWn8tiL/sJfWwkCeYpg7cZkiT6owPbbk0AA2lU+7NY1NWCBBAry4EZUGmoVilfcKB1WAVzPGGJ9UUXWLV9G9O6LJHzTa9KAyenQhTr14ZSBDr+UD65Zv5z01Y8gFBoxf0ksE/eQlIlAzYhmWEJJ/Rfne3MAxky2OXFxUgZ9DKFktSMoy2mpaetDPCCkprai5maP5+K9e/yVuj+rHI1hVL7G6WL1QhcNk90sPfWH2g9CCdfVHFj338NbzCxMRW1J1c8tUcwZbC4weXfrSz5F3CcS8MvQ/i5Q502otG35gdWUtYo1C0F+F5n1Y1sKyAN6Sh3vqaOWZgVfMlLKHEkewLV4tNVUT8wIosid0nz5pCHq0rfNYnAZATx+DfYSekrgQWCn6ER6oi3az8u3PyozKKz6NcHOpWGrFDyRofLwfEw5gHtM8PcrLKg7gVMejfbZejB2GeoKqb26xn6DnermrcY/e/nOYg2uUhTCnz2X5jkvXeMpEOdDGihBlOy1NgaBXUXTkJvXhEnPEnc5GuRgZWN8Iu46jZNf/rIMyy08GvlRYN5vxOM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(83380400001)(122000001)(4326008)(86362001)(5660300002)(33656002)(38070700005)(41300700001)(2906002)(38100700002)(8936002)(8676002)(186003)(6506007)(53546011)(64756008)(6512007)(6916009)(54906003)(36756003)(66476007)(478600001)(66946007)(6486002)(316002)(76116006)(2616005)(71200400001)(66446008)(66556008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/vyv772U1PFZvPppn+m2rKr52zI5IKcIKhge4dFR5Md/kabAPwZufjhn+3if?=
 =?us-ascii?Q?4xWGcUWDPzg6LZ7Ft0kJKLfF1ghb5lCcc/j56bDwTKHsGZZ9rD85vY36yvuN?=
 =?us-ascii?Q?2j0iJ65QWGWAAtxK0UYjIKUi86T/jRSf6atQTmsOz7qhfy9IA7fMYEl88pLQ?=
 =?us-ascii?Q?ywqipBX59MaQ2pE9WweozdvwLZWtidVPW8+zJ82ptpUhMuY3S6r0Ib1aJ+t3?=
 =?us-ascii?Q?JLPVVXzs1BUIXqOFkzCB0QxV0V8ciVRuiAihpH9RbEQfqAOrfaTYa6r5R5/O?=
 =?us-ascii?Q?JkyXHyXGVGIfaZICYuBUG1gDauTx14D2EBUM+pJeVo/UixTE5IHPRA9gsQpA?=
 =?us-ascii?Q?d15brHIMmWkxHJS8AFB06EEMnWvhY2T4gP2YK+5WIAoldHGFO+AO7VmVy+V9?=
 =?us-ascii?Q?GH8/ERP0Xunix9ihKxdoYvwfOWr0Z+Tm/h4KOJ9Vehl5rN05M++AwfMdC13h?=
 =?us-ascii?Q?7BiVReS5PIs6jr8haC6F15mu+ff8Lci8yJygGiJTqWiFOBZGnhI/Le56ZkYV?=
 =?us-ascii?Q?nJK3BAm6pjqgqLQnlnUVST5cieGr8353U0IB/yB/RmlvSDixoKVSMWwPrSTH?=
 =?us-ascii?Q?Eoic7GLY2NArWtisqqhvLHZZcMtcK6uk9khV187OGB+dWeF2GvYAJ0tVWgLF?=
 =?us-ascii?Q?2CkubnPeXU+WnL3aMIj0h+ErJT0lPW40e5ER9FVjg4isAUKKgh3VMX3fWEEo?=
 =?us-ascii?Q?2YKaS8mqy/oUJOlQZr9W7RmHZ45ir38d6CYyTemZm0BOjoS9ti3xvkgdIXNV?=
 =?us-ascii?Q?Ne5WP8juR1ne41FHPSDybUsmJ4A8OnHET+NtlxN3YZfUrpFbHU/etqQZs6/K?=
 =?us-ascii?Q?4KxSRz4/eYg/zfIWIClgYY/iGitzzmvKX1RNzqeOmEuz1LBhoiEyST43xxKM?=
 =?us-ascii?Q?72bQt4fGltK3nX4oxm3GqT9YMlzQ75DzyhtjqOFfuW7p7EpwYqlctMbmctSh?=
 =?us-ascii?Q?W6HKuTuLU9B7iXfL60z2N05GfWXtV8HP4eN5j+0ELqFEC0lqufKSXl5hQtKJ?=
 =?us-ascii?Q?mcyfkIX5SVDDwTFM0xXpMWBD8pBLP8xzl3DTIQOVQVdLQMVlFaxaC1MV3bgR?=
 =?us-ascii?Q?TcsscCrS2+LS2KMFRXQehwujiCfCAn9wvd9C3QQTGnEFvvZOHzTOWoddEfZ1?=
 =?us-ascii?Q?THkLRAKWK0ZFswSvfEKkMjPfgCrM+kqxj/EO5bSQo+W8nRvImarqaj/v8+XO?=
 =?us-ascii?Q?pAUPFOgrOPMhaQg1DBbWxhoqSjM1JvvA22KzSHLcLN/U3XyWvFA1kwEXuAhu?=
 =?us-ascii?Q?cUC5B0gKMJSd1feaK6NZ1cKBZvN4dWsAaSSsWkHBFzPZbLDQHYjQs4POXo6+?=
 =?us-ascii?Q?EW22mokAQrqFhWKgDDJQXQ4mduofOxOweUdEjUALwi3K3Q7erQl7+IPouWeR?=
 =?us-ascii?Q?2gL3v5Mhn9PHmX2XlnXju2HN4zWY8X28Drne3i5Ww8qd01/u8Be5JpxUr6V6?=
 =?us-ascii?Q?E4Bd0BnN0YQ37jQkKJo5I8vcyy8YIjMjgtqw/M+xKEr1iQ/9XmaqJDwC5MhC?=
 =?us-ascii?Q?7ZrYxiXi76pBb+PV+R2NtWNHFJEoTM/JKumqpVCeNoP7pXr7VnYImMc8B7ED?=
 =?us-ascii?Q?sDZvZFWN6Qh6g/+qyD8nz1gCdE+RwszdV/NHtQmbz/zdYmNcujcHkTDOQ1m8?=
 =?us-ascii?Q?m2G1REqczSE9kIXHqkRMthvY3C+ArbHUlxSyBptVBo+I?=
Content-ID: <0A050E6A132D6549A60727D6FD326561@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b149bc-6bef-4528-2974-08dad714f762
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 23:03:47.5757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcvulvCte2P47MsfkLuKtVdHfjt10A2ax2N4BfijTaM6kNEXKZCtSG3/KlFQ0h3afoDN/1XOtxSAcVwBJ2uQeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR05MB5971
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 Pv-drivers <Pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Bryan Tan <bryantan@vmware.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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
From: Vishnu Dasa via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Vishnu Dasa <vdasa@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> On Dec 5, 2022, at 3:52 AM, Artem Chernyshev <artem.chernyshev@red-soft.ru> wrote:
> 
> vmci_transport_dgram_enqueue() does not check the return value
> of memcpy_from_msg(). Return with an error if the memcpy fails.

I think we can add some more information in the description.  Sorry, I
should've said this earlier.

vmci_transport_dgram_enqueue() does not check the return value
of memcpy_from_msg().  If memcpy_from_msg() fails, it is possible that
uninitialized memory contents are sent unintentionally instead of user's
message in the datagram to the destination.  Return with an error if
memcpy_from_msg() fails.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0f7db23a07af ("vmci_transport: switch ->enqeue_dgram, ->enqueue_stream and ->dequeue_stream to msghdr")
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Thanks, Artem!  This version looks good to me modulo my suggestion
about the description above.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>

Regards,
Vishnu

> ---
> V1->V2 Fix memory leaking and updates for description
> V2->V3 Return the value of memcpy_from_msg()
> 
> net/vmw_vsock/vmci_transport.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 842c94286d31..36eb16a40745 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1711,7 +1711,11 @@ static int vmci_transport_dgram_enqueue(
> 	if (!dg)
> 		return -ENOMEM;
> 
> -	memcpy_from_msg(VMCI_DG_PAYLOAD(dg), msg, len);
> +	err = memcpy_from_msg(VMCI_DG_PAYLOAD(dg), msg, len);
> +	if (err) {
> +		kfree(dg);
> +		return err;
> +	}
> 
> 	dg->dst = vmci_make_handle(remote_addr->svm_cid,
> 				   remote_addr->svm_port);
> -- 
> 2.30.3
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
