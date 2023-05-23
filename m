Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32836C77B75
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 07:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9ADFD40949;
	Tue, 23 May 2023 07:17:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9ADFD40949
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r/xO/ReC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IVemDQwYXD9m; Tue, 23 May 2023 07:17:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2396C403C4;
	Tue, 23 May 2023 07:17:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2396C403C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6FE8C0036;
	Tue, 23 May 2023 07:17:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65699C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07BD141BEB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:17:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07BD141BEB
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=r/xO/ReC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CvTu9XoByQED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:17:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 93590418AD
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93590418AD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhSE/enGCjijL7G8Q1kMne8kR+f3eBiX49p/WJSM+5AFOB2MTbW0qepbwy/ZPKP8TsaEfx49iqwpY+RKAQKSqpUPG3RVPaT8TvO0RFDlzZaKEuBYSGXlsCyKDQy4JQ5tCNT+qVnHWhNnbx0g5Ldz6yPm0KRYw+pJBIN5hILPvZVVVkuC31IuB1eqTOS/3Jos5iCqRkWvwENNFy+QEJ4zV6fYy6o15LPvFmvuJhfttsX9N0FWD6TIWaQZZNjPnKu3/oB0aszaFeOp4QXhHWaIMLG5wZDA7VHhu9buHynVeO1xXz0RTJxweNACzjWInCOyh51ZfhrG6mFvvGuPLkJP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sopYDI6m70hwHEnx+o53bkHS7XVxY7oHJ8Rb+OvNuc0=;
 b=oY1jCpkggkYzq0aKLmd9LjQoe7qklYP1+n9gKWj8IKm1S2KfYkyRPLwSsibr18oG/GyJ35ywgDJdCBeQRCb2aR5CcWkk09Uh5LEGWZuvk70EQI0Qs2nLT29x8RPRSnrB/2Y1NRe2qxhsVWy4wBFeORHZZ2QwxG7bLUNAoqX4+N1Lw4QGYr0DGSdlzwgHZ+LjC+FOeBTUY3Nhbq2iz0dLEvmXVGiVFOG9eD1xflC+UMjK8gA8W7zs6wx3TnMI6Y8KwfbUlWI4mCMLcsHoriK8rlA6KgIdaRYUUzotGPqIlE8dpa/7kOzgk2kP88UJBaMOAIPsxffl8Gb5eZJaH7ojgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sopYDI6m70hwHEnx+o53bkHS7XVxY7oHJ8Rb+OvNuc0=;
 b=r/xO/ReCNIq9dIJ2cGsRAOS8eYqwZn2rmaHLWpMzy3vHxHwcPeB5hbNbneInsBaJBJBkteAoPHf5dVOvMHJ2KxvwjjXihjiOHqf2HW4M0Cs04F+21EcZgWToYfK7Brp8pok8/XI0gAVctdi+DcVvPbQLJfDyKz3mLy9sq8ehh7AuIOsOkbQsIyJp2uqvZewqbFs3NiDZIeeBTyBu31qU+pdG6mIY0Ct2/moUY+Mt+oaW2oSEL691/bOPtX5ZHUPMWYu5cooQ/S3phMkohKN6+nX58UoY9a8OQHPesBuyrQMlwHO42+cFw4NP8uqcnc0KE08TJqAzYDLm5fYc2tXbFg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:16:59 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 07:16:59 +0000
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com"
 <mst@redhat.com>
Subject: vhost stable branch
Thread-Topic: vhost stable branch
Thread-Index: AQHZjUaQ6njl1MGLGE2KPtgjGhYoLA==
Date: Tue, 23 May 2023 07:16:58 +0000
Message-ID: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SA1PR12MB7247:EE_
x-ms-office365-filtering-correlation-id: c369d0ee-710b-414b-82a4-08db5b5db29b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lhmIkWjcAlIB60+xINS5Yysk1XBsqakgfHXfrXQAVEbu64pdGCC2gYjRVYsJGnZH6GZGp2nls2nZ6hAzgu/QtSpJXNilICab9VcVp86NmkxYQIvIZ7Z8gMZcuXlY9yERZHjPGhO/UiIGc8Z2aWf+73TigclRhqO8PApVPQ/nhi9fwX7jbFtIGtke3n2Pk42hJ1aYb80RBBdDpUJ0gL1IXankSa+mM1Rleuco5FkvjAawQyw+delA3T32WxxpU0qcFuwX6WPCh1CLU1L1C6M98cUwgS4ne+gp6+GQcmrqlZtjzCPrIUY8hlAIvTW9ilGM1JQNFNGUaHoBaiRiyDn9tgFEs5MwNGPx8ZozmrppxYEaM8/3h2wnkJOVxtBr9I6RrsH6as0uOz8DSt46qgbnOmbLi6+4RpcbhXet0icgQC5804SKVgqthcwUR0h38TkFRlFx+CAC/mMOUL14+qv6UpzkBNHkmXKVKeCSuWC+5OyTUmhzHghDFVfqD+FMF9wyncWzKcUtYFUy7r56pHNBiN4pxoKwEHc+sjLnM/uYbIWa9QgPZrJcICUh6OwUiOepZMXsdLJ0VUKDqiWKImPM4F+BHjctNvutMS1/b7a/VsgS8qApHT+gs0cuGVsV8n3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(966005)(41300700001)(6486002)(478600001)(110136005)(316002)(91956017)(66476007)(64756008)(66556008)(76116006)(66446008)(66946007)(71200400001)(7116003)(5660300002)(38070700005)(86362001)(8936002)(8676002)(38100700002)(122000001)(6512007)(6506007)(186003)(4744005)(2906002)(2616005)(36756003)(3480700007)(133083001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZWSTJ2dUt5OTFXTEw0QXpjc290TjdVcnFoNHgwcFdBOUdtckoxUEMwOEdh?=
 =?utf-8?B?UjJ5dDBnNmsrMUlOazlTNGhGZ3ZhK29mOW9GNXVEdUQ0K05VdjBPUHp6cWJk?=
 =?utf-8?B?K0xtQVlmVDdndGd5dVhTamVsY2RDTDh6Q2djTEs4NHRTMWMzU2EwclF6aG5D?=
 =?utf-8?B?WktIbmZXSjZWMjZPVTl1TkZzOTNLdDZmckJOYmhxN2U4SU5FMzdKdEhWeXMy?=
 =?utf-8?B?c0RJNTFsOHk2aU1ONCtuMWFCRGNFSEJhaUVRVzBJaHpuaUZFbm9CR09xZGVH?=
 =?utf-8?B?S0kxUU5xR2JHa0RJeHBadEtoTkhJbUNvSEwySE9JaGkvUVVzaWVSZXlWQ1pQ?=
 =?utf-8?B?VGtyVXl5bytqWE01QjBNY1B5WHlBU2RyelBBdFByL3lqUnRmdERPdVlEeEVx?=
 =?utf-8?B?b004ZjkzMk1Bek5sUlQxNGh0MS9EYVk0LzJ1eWJETzQ0aHFIR1RBbFRjSXVM?=
 =?utf-8?B?Q1BacWk0bGhDL2ExY2tlMUR5T1FvdDJJYkZGOGNzSTBtdHhQOGthQlhDWGtT?=
 =?utf-8?B?TDNXN2txZ3B1dVlPa2JiL2xhUU1nZ0VTT2JXVlZJS0lqRFpITUZkU0xRVXNT?=
 =?utf-8?B?SjhkbkllNmp0SVA2OTlpNjR3dldwalJPaGdYVjIvNnRPRlB2NHkvNllVVENC?=
 =?utf-8?B?ZWZmRFVXcVJUbU5hSGdiL2dQbHFYSEt5QTBHR0pPSXE2TGZZblZBR0F3alVy?=
 =?utf-8?B?OHJsYm9BcE1reVVaRndRM1pQOVByemdBR1M1S1hrRzFPUVpvWG5OazhuUlZl?=
 =?utf-8?B?K2s1WjZrVzd0V2JibUdUT1dIbEZLRGVvVUlQZ09jQUhqcTRSTnBXWTVkc0dB?=
 =?utf-8?B?OC9WaTJjZm00K0lGY010VitTbTZVaFN0VGtENTB1YlVGczZKU2djNU1QOUtw?=
 =?utf-8?B?dlpaV3R1RlhsS2NXamphQ0ZjK0ZHYkhObnBXY252VUc0dDB3V1Flcnk1V2xW?=
 =?utf-8?B?d2pNb1JaeHNrd0MyM3VXSmVtelpJZHBUVTdnVVFLRTBITmZvcHBmcVNpNTB4?=
 =?utf-8?B?QlBoTlhRWVJmVlQwcFJJczVKblRuQjVtOXc0MEZqdHFFOUlvaWxVTjZhMFRS?=
 =?utf-8?B?ZGlNbk54Wkt3bkxEZjNqOHhaK3pGYmptcmNxOUZFQmZ1UmRyOS9JbDhIWEdq?=
 =?utf-8?B?eEtMRGlqZ0xUNlkrRU01RGdLTHgxNkltb1VwNWtYaWJkWDkraHhHb1pzdCtI?=
 =?utf-8?B?T1BRVjBid2dnelJFS2FUL2NPNVE0UHB6d0ZEd0JhU3JQb0VsVDVvNjJNL29m?=
 =?utf-8?B?aUVqck5OQzRKcklDYWhmdDZ5VU00eUVaVW5MRjcrbldwakdhalJVaTRqaTE4?=
 =?utf-8?B?TW56eHlDeU14dFRaaDJiaDNiUjBGQmNFUEkxWC9MLzNSOWQ4TVpJa004Wjd0?=
 =?utf-8?B?ZWlTOUY0NmI2NVlEMGladUNDRWZjL1RKMFRzekZZdDR3dmJmZHNCQitZVkRw?=
 =?utf-8?B?aVlDRWZ1dmxZZ2xpdkhvbEYvOVNxSnZ5b2s1KzJKbWxITjBmd0NmSjEwcDly?=
 =?utf-8?B?K0YzYVd1bG9rUUd1UG56d3cweG1ZdnFiYjVLNnlDT1BwZU9sVzNEcVNQT2tQ?=
 =?utf-8?B?SHM3ZmZ1UjBzVXNqT2JjUFNwK2pLQ213MFVZemppbkJIRFRFRTRadHRpMENN?=
 =?utf-8?B?TCtHdWVhazkrbWdjZDBaWkFWTjQ3NkE3cDZRaFAvMnN6N0RiYTJKa2VIalFp?=
 =?utf-8?B?Z0JwUTVrUnlKSC9CcWJBUWR2eGVCa0lxVUppS0FyT1pqTitPNGtqQUt1ZUNZ?=
 =?utf-8?B?eEhiaURnUkRKemd5TVlkRVlCa3llWmUyZ3Raei9VUURVQ1JVb3ZYdGNUODBC?=
 =?utf-8?B?RTRxdko4Z3pSc0lHejRmSjVITC83TWFJN2dLVG9JbHhJbFlrN0Z5NHJOUHkz?=
 =?utf-8?B?c3NxQUtXYXNEVWx6UVpUTUxWekxTMWNjVnpOeGRlVFpoV1AyWVJhTFlOMDI0?=
 =?utf-8?B?bzlOcUQ2Y1N1VVlUV29BUC9wM0gxVXZjQU9pMFRFN3NiWWovakI2OHh5REQ3?=
 =?utf-8?B?VHliUTIxZzdoQmZLQXlpVUdaKzlkMlEyZlVjWWM1cnBhSEtJYjg0eHU4RDJw?=
 =?utf-8?B?aWpOUHlpNUlROUhUcm8rZkE2a1ZWa1k1Y1ZlUmtLdUFJNUhlS0JaTU1TbE1w?=
 =?utf-8?B?YnlQNGp4cnU5YXdMSDBseUZySkY3cG5LbFRPL3RPTHE0WUh5bFFpdGpxRkN0?=
 =?utf-8?Q?IdizMz+6Y+y/pGQ0aTuvpkp4C+AQzDZc8sr4NPWGOtrz?=
Content-ID: <5FD36679FE5A364597F69AC6364FC45A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c369d0ee-710b-414b-82a4-08db5b5db29b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 07:16:58.9473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHpPtAd6Nhq1GKAGe3XOxZ8NAFD2UvWKwpQAOEU324afDVihaCRHUusTgE2sCMarijCGzL2RJoe3OuWkzJdAlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

I am looking for the stable branch for vdpa fixes in the vhost tree [1]. There
are 3 branches that seem identical: linux-next, test and vhost. linux-next seems
to be -next branch. Which one would be the stable branch?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

Thanks,
Dragos
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
