Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9251139593
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024942; cv=fail; b=XdBNiXHa4zQF3oSdQ3dNEIJD91EQSQZ6Uo0Vw1t0UG5MFDuz2Jq/sZ4ifjOe3ABC9CKNJsghyopGqOuNWhBs4PwRezCCRvC7Gb3O0Ti0lJsAUb+jUpWd7aDe4GedCgVnosj7mh4XZvlnxjWQqKV9x+nZBS3E87iQcCJN2DCMsTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024942; c=relaxed/simple;
	bh=VyBFtv+XFNPjmqnQMz1aYSaZ2AqPpQvh12ehq7BsZm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q1Gaq3xEgOJIhCXguqSoOnBaKPh75Ofio3UhMU9s02+vOMti5JXgjBnScgwGe17Ya4o22k7oyGUufc8keSB4leBLhJiV7fVIqBWKzv9JkXVJCNdKRWb4V3ibbLDHVSqr+EKoB28EWIsDGIddRDmnVLb5GMk+DE10YRjvY+ddx9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n256K1Lx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nDInrCfu; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n256K1Lx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nDInrCfu"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6830F83CD5
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 19:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkMyJRLGUOSL
	for <virtualization@lists.linux-foundation.org>;
	Thu, 15 Feb 2024 19:22:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=jonah.palmer@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3E80A83CD6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E80A83CD6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=n256K1Lx;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=nDInrCfu
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E80A83CD6
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 19:22:18 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSvSR021416;
	Thu, 15 Feb 2024 19:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tbYpFTcCM2lv+9hL5xqbT6C1nnepHtpR0yO56fgKuac=;
 b=n256K1LxyyAXmDjY0K3NRiD0WpOJDDiQzu3rrbf751hUH7N62NcyHE+sfJcjkvfJXjjM
 z1RWmvypK+0jokLw+atBFQzPgyli8B6Idt5R25hdDiXa8LRbG+CoG8Q1S1QK6AiF5Fkk
 35rY11AU8GxqOrctWIFJlngwOVgpDmsAkkMHbVf89wm7UUaz8kbTMNAvt6o02gLjSu4+
 R67iVdpauT4hcYvsEV2Is3J6JEgtCGh/6onPJ5yqWpCvbZUnWyFFGeFmj8m0niYLFKYN
 v9elK0Gtt7BjX9mHofvds7dra/gOd+cI5mUZ88gI50soDsJtjQCl4SkqDK/oC4ALWJZH nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0k3mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 19:22:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJ5wYS024665;
	Thu, 15 Feb 2024 19:22:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykha8df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 19:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StqRYKR4Lt2mBOwPQR9uXLrGtv6mpNcPJXtTuyUQU0a3LiDxEOqDU/9PBrxqIeylzJmDxVjH5URA/xZeyKWTLZj031yIgFU2IbcJrxD0Slkzj4z187dvWY+CnxJgnmrnefpGHW5kgkqE0RSb1fqUzt638GQKVR1zKRfEghqnE3js1pD4q6anoppeqPp0QgjoYCaSyTEUeOhpyRpdoYCugutlIB5h1VZXEeWQS4sL06WxxXzYVv427Hc7Y3F5AKrnUg94b+c/y4d5ay8HRxEI4vy8vsw2ctE9l0byCulrxdZYbzzKfi9FNXtg0+DV5L/+yO1pwCK+CcMUN2BJ3P6/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbYpFTcCM2lv+9hL5xqbT6C1nnepHtpR0yO56fgKuac=;
 b=eS/oAl4F7j/tHoEreUQsqQuEWsjdf4Y4dSuVweRJmx127YTsfooLME2/1nQTc5y6Nw9ynhWKf0jFOlI+G0pfs1DE0lTEbzXhFV8BmMDwHnNexrwYMOgV4uuhLAnQqxPXxhXg+ItyGw4XhY5sECx+dFs1N3BVWhPBxK9KNYXbl12bdi3H9OqXA9/hBTalQf/BWA5mE5pN+lwmD9yVgb4Mb5f3gzF8+R066MC9wH3JaREF7Gd8IBvx0/siBAod07IkBTplALghQlQ0Nyv0MOQVkHWCCx2XDI7cRnkJ748vAdn+ByClOWixSxcwJ56m30GRnnjFpy+so5GUZZg/C4uiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbYpFTcCM2lv+9hL5xqbT6C1nnepHtpR0yO56fgKuac=;
 b=nDInrCfu9yoEYYj2ZqKQeaSvQACgh+o8u+f6/KXVBP3gqYeRfDHxZOXDRA6hlx2qyzUYDNCf7bTyyLTktbID4l3mk6tA7t5N3BRdlA21hfW/HGGemZDdtY/cWHzi7O/PA+W2hf68H4tjRghU8Qnjso2IWhJ7mMpExQlEjyD2Wqs=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by PH0PR10MB4438.namprd10.prod.outlook.com (2603:10b6:510:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 19:22:15 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::6ae5:3f77:eff7:c427]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::6ae5:3f77:eff7:c427%5]) with mapi id 15.20.7292.028; Thu, 15 Feb 2024
 19:22:15 +0000
Message-ID: <421df664-07c2-41a3-9456-cb27f3b903ee@oracle.com>
Date: Thu, 15 Feb 2024 14:22:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: vdpa/mlx5: Allow CVQ size changes
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org,
        dtatulea@nvidia.com, boris.ostrovsky@oracle.com, leiyang@redhat.com
References: <20240215170507.3865986-1-jonah.palmer@oracle.com>
 <CAJaqyWfRYj5+BCV5KRmj1xRUtaFg5ixU9SPciqyMRLfJ7ztu2g@mail.gmail.com>
 <CAJaqyWcJyzjHB54oPOzjqHwc0JnFWj-wMd+3w0FHBNswDJ3Mpg@mail.gmail.com>
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcJyzjHB54oPOzjqHwc0JnFWj-wMd+3w0FHBNswDJ3Mpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::16) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|PH0PR10MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d2e1ff-b5a4-4d9f-6092-08dc2e5b6acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EPeepVVQ4p8njMMr0fhVnLbsWD6hOyy3TrB69wXWIiYOd9lWK3qAXMUOenmRTf78xxSk/4GbMUvQL3klsH8XIHlevyFr8ceWh3UgRfsp9iRM2UlPx69q9++AatdkdPn0lxVSc+/MZXCSssGmD9bFH9h5iZTbv8m+qXSAmK3Y453JUftrDLrLYdgW73C/Nts7zCgr/6kRnr5i2grB+EDdNEU4ExoynGSnXVa9Xeo4qrJhh2ZZJ5GBvM+C+iIBUIn6WzI24y9eEC9P5gtr7o1bet4pYdUFoj93gI1ZD0v3RGi6UqD4spYjTd4rCnoQPirB15e9r0kQxzhfJfvSeRGkjFLgOqzLWJPf6rpELXsYyQlQ9Oby9y4W4t8sIcQzNar0aobQaZdF9dAl5JpgxtXp3jw10xDyXu36UFldUoz+GSBDo33RYig7PELiGAuQoP2UNbztJBeywXunbQTKvPVwi5CROeTONmZ2t9oleNgcY0RDSjbwSaIvpKE3ek61l2EsbDLXArnkx4SWNu4SGcc8fJ8N54ebS9/QcDy4HNfGNGWLXPH2tdCYYWZo4UNGAio/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4664.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(44832011)(38100700002)(5660300002)(41300700001)(6506007)(6486002)(53546011)(478600001)(31696002)(36756003)(83380400001)(66574015)(86362001)(6512007)(2616005)(8936002)(4326008)(8676002)(66476007)(66946007)(66556008)(316002)(6916009)(6666004)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OTFEcUtlV0Z4OGxzNEtNNFhOVmtYZzlaV21iZzE1eUFNT2ZtbmhMTVdndkM2?=
 =?utf-8?B?NmNlNzN4T2ZzZjZZMHkwa3lnNmVkWGdieTkxMkRhMWczYUtJN0NoREh5UlRD?=
 =?utf-8?B?UDZCc1BzbXpVQi9Ub3dEMVlPS3BGNEUvWHVsRXl4RVdXdXZCZE01RzlvVnY2?=
 =?utf-8?B?ZEFaeGRjRWgvUGUzYldDdFRTNWhKVDJkM2hvcnh5L1RHcTJ1dFdtNUhhbUxs?=
 =?utf-8?B?Y0VYYXFtZ0JWSkVhRi9jb1pIS3hXR0pUK2dPY1JCN0xQdUNFaVlyK2E4alV3?=
 =?utf-8?B?OE1CdTZ6YVV3RmduNnl3VURibU10cVVKRmR0djN1ckcwYnMxK214KzUwNkxt?=
 =?utf-8?B?bVQxcHQvYldpRVNwYTVMdEhLYmlTS0o4TnpScnlyb09LdXJTdmU4MWJEMVR0?=
 =?utf-8?B?aERFNzdyMld4d0UwaHdLbmpmM3BGQzhWRkNmSFlZRjVRanAxOGNQRVZJU3Fo?=
 =?utf-8?B?TkZ6S2Q3YmJSeXQ2R0JQZHFQWUFkVERzcUg3dVJONy9Pd2RkaE05OEJLZ1BJ?=
 =?utf-8?B?QUQ2dkhwL1NkY205VU9JQjM4SGcyUWhVNUhzY085RitSUTFrRENlaURlSFZW?=
 =?utf-8?B?bHFRQXlsb2xvVGRrb014L09ML0N1dDdRVjFJekU2WUlESWw2SmpFSUlsdStW?=
 =?utf-8?B?U2NoVVhTZ2Z6czAyZzZSQjdIWExOR1gxSm00ZFo0NWxkSHVRZnAzNXc0RDc4?=
 =?utf-8?B?L2NVbTlTdXRjaG5KTC8rUDZZUUljQnlYa0xzNnJZTjFERFhnazZkdnBPa3lq?=
 =?utf-8?B?cFp2TkhmdWh6YlRHQ2ZsN25MQSttUm81WTJ2UEQ2ekJ0ZnFGcmFCTFV6Rk03?=
 =?utf-8?B?SkRzQXdua3JMTnF4aTBaVjVHQ3FWMzVHbU9nOXBLV1dBN2JOV1RyZzRTYmIy?=
 =?utf-8?B?VHpjVllaNkV5ODBRKzVtTDVNWjdGT0plN0htalhpYzZjU3dUT2dFUEVreXU3?=
 =?utf-8?B?NFlscXBBQk1NRGg4ZFo4Wkt0S09Hb2VydHNtMVZQRk1QQUpqT0doaHNHRnFm?=
 =?utf-8?B?ZHFwY1k5RXRpV1ZwWE9iZVFnV25UaEdwYThFaFRpeGhoeW9XL29NMjNCKzdj?=
 =?utf-8?B?by9sUkRFTEdNcVRGTkFvYyt2YTZwb0MzVGNwTFZjbW11dU4yc1NJM1ZYdGZX?=
 =?utf-8?B?QzhRcnM5SzRnYUdQYlI3QXU1YkhlYSs2bHpwTFVHNGJYQnRpMVE3SzVtZEdn?=
 =?utf-8?B?b0FaeUt1bXBtSWNCdWdENjg3RlNtQlgwRjZ5ZVd3VjJZcFU3Zk9XYVY5NGVl?=
 =?utf-8?B?dFZNNytwQUhrZVVIZXNMSGlhWlZ6aEQrclM3U0d6TExMd0E1MWFnZkhORXRP?=
 =?utf-8?B?Z3cyQkxnSkFoeUczL3N6aHlTUGhUaXpIYVhLSXJlTytvN1NDbk1Wbk9GVHgv?=
 =?utf-8?B?QjVGZUc0bWhmRkt0L1FHQlorU2YxSUwrUVBKV1J1bHkwMis2UTBOcDFhekFB?=
 =?utf-8?B?TDNKUTJsdFREbDNDNm8rZ0MydlpuVkpQaUl3M1VxNnpiUklldG9Jdi9jcmZY?=
 =?utf-8?B?Qnk0REpPWWVjZkpvaWxNRk1ibTdiSDVzR28xNFAvSVJneGtUa0tqQW1RenF2?=
 =?utf-8?B?VXFUL2pwOUFZWjZDQmJYWlhvU2d1Q0lzL2tNMEU1K2hQRmgvQjE5d1BuRFlN?=
 =?utf-8?B?WVBVNGlnL3Y5WFBSbXBBd1E5NkhrV3F2bFo0UUIxMkdLRGFTdWhlUVJqRDhm?=
 =?utf-8?B?U0VjV2RJNWNlc2ZybnFBb0dmMHJYM0NTS3J0MU1MSzE3UHJHTU5FS0NQMXo4?=
 =?utf-8?B?Y1VzNUlGTjVwdkRoUTRqTVRsNUxZdEhhaGdlUmdwbEcwMnhLVGxjUzdXaWtv?=
 =?utf-8?B?RDVhUlZaTTkyYVA1VTgzcFdxbWRGQ2IxN20waGVkQmZYTkhRR3JOTytpRjNX?=
 =?utf-8?B?dmExaGM4dHlmNXNCeFdZUjF4RWQ2SVA5MFE1OTAxMFFDU2ZjeVNWRmpjSVEx?=
 =?utf-8?B?TVFNYThONW01UjZHRnNNSzJxTnVPNG8vMTVkWHlzWkhQeUlBUkJTS0dCQ0ZK?=
 =?utf-8?B?UmRJUWZwQXhRSkcvdXZoc0lCWUszYjIyY2lIeXozc2tGU3FrdzJvdGRoejRu?=
 =?utf-8?B?ZUowUGJnY3ZITWF4MGMvRjlmQzJVNTM0TEx2TXF4MGJOWE53L3oxcWtJU2Uy?=
 =?utf-8?B?OHBNMHJ0WEx6UkFzTmI1RTUzQkNGSzlHWEFMbHljUjUrSWkvNWlEYkM2R3Vs?=
 =?utf-8?Q?S6iEmr9etv6Lve+PU9xcYiI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yay2ELKVK9tFMNgIpPsHtWlNgZLsMJXiy6WVyt8IDE2lpo6gMJK82WC7FW5tlMShwxhG0NzT9s6b8bmrjIO1rn54Uscx/fZnvBCJWkxHSr/PMX2lZ/ckObZpEb/86FIwfy5WwBTqdta/PWBfx7ci04nZMkRkwhW5TmrXQ2RZNh4ztP3vvh+JyhKAcRgQC94xj9pJaGGTac2u7nOpiL3e6rvh4ZoBTqd0nYj2uVKX0/jHq23Asskql4RyqetoLmqAwHHTpHYGcnEjG4fqXgPUaqBZwRfElH9rvWRyfwJmiHxhYl6LslD/UjXex20+1CLeTnNq14T/9RznD/KdE4qh+BrD+hjMu3irXwftTelvyNO/CQV9ZwwP+KNgJc0XGYeK2EN/IKFw9Blc+bFoDIGCgKPoX4YUa/MpqVLRIBXwF+F70r1SIbGHpeQrsNenOXMEhPydlZrKqdsDnjb8PP9+sPjAfsdlwlOzG1ucjmZIAwtrxzXwRjiAI3Q8+BTqUvewcPov7URqO204ykH2Jo51hCnLbSraUZwND0hBpzXDLggXAGmjeI73KERuhCCvIaFjpQAsJ46dqHB4DXgpnoJpnojb3pwYEr5TtXt1uhBKTvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d2e1ff-b5a4-4d9f-6092-08dc2e5b6acb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:22:15.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dxKsRyfXVTRuOLlJHgWo34OGfS1+aiVvNit7yPf1dcVFXXlgSQv45R08LBIuQ1gdSUCvN6hKEjiuUpPTn0xYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4438
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150155
X-Proofpoint-GUID: POug4JNuIbF25HiZSX9PJ_JXH5gegF7s
X-Proofpoint-ORIG-GUID: POug4JNuIbF25HiZSX9PJ_JXH5gegF7s



On 2/15/24 2:02 PM, Eugenio Perez Martin wrote:
> On Thu, Feb 15, 2024 at 7:55 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
>>
>> On Thu, Feb 15, 2024 at 6:05 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>
>>> The MLX driver was not updating its control virtqueue size at set_vq_num
>>> and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
>>> setup_cvq_vring.
>>>
>>> Qemu would try to set the size to 64 by default, however, because the
>>> CVQ size always was initialized to 16, an error would be thrown when
>>> sending >16 control messages (as used-ring entry 17 is initialized to 0).
>>> For example, starting a guest with x-svq=on and then executing the
>>> following command would produce the error below:
>>>
>>>   # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
>>>
>>>   qemu-system-x86_64: Insufficient written data (0)
>>>   [  435.331223] virtio_net virtio0: Failed to set mac address by vq command.
>>>   SIOCSIFHWADDR: Invalid argument
>>>
>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>
>> Acked-by: Eugenio Pérez <eperezma@redhat.com>
>>
>> Thanks!
>>
>>> ---
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 778821bab7d9..c74de1fe6a94 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2276,9 +2276,15 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
>>>          struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>          struct mlx5_vdpa_virtqueue *mvq;
>>>
>>> -       if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
>>> +       if (!is_index_valid(mvdev, idx))
>>>                  return;
>>>
>>> +        if (is_ctrl_vq_idx(mvdev, idx)) {
>>> +                struct mlx5_control_vq *cvq = &mvdev->cvq;
>>> +                cvq->vring.vring.num = num;
>>> +                return;
>>> +        }
>>> +
>>>          mvq = &ndev->vqs[idx];
>>>          mvq->num_ent = num;
>>>   }
>>> @@ -2963,7 +2969,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>>>                  u16 idx = cvq->vring.last_avail_idx;
>>>
>>>                  err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>>> -                                       MLX5_CVQ_MAX_ENT, false,
> 
> Actually there is one nitpick: MLX5_CVQ_MAX_ENT macro should be
> deleted as there are no more usages :). With that change and Dragos'
> request you can post a V2 with my Acked-by included.
> 
> Thanks!

Will do, thank you!

Jonah

> 
>>> +                                       cvq->vring.vring.num, false,
>>>                                          (struct vring_desc *)(uintptr_t)cvq->desc_addr,
>>>                                          (struct vring_avail *)(uintptr_t)cvq->driver_addr,
>>>                                          (struct vring_used *)(uintptr_t)cvq->device_addr);
>>> --
>>> 2.39.3
>>>
> 
