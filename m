Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34089C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 16:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97D7B43062;
	Tue, 24 Oct 2023 16:21:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97D7B43062
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=TyAKOZtt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=m8gogac8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id im93GUlHWpSK; Tue, 24 Oct 2023 16:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 743AD43005;
	Tue, 24 Oct 2023 16:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 743AD43005
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32C74C0039;
	Tue, 24 Oct 2023 16:21:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05DFDC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5A516FB2D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:21:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5A516FB2D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=TyAKOZtt; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=m8gogac8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gp5m0a2fYUT5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:21:37 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB9CD6FA86
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:21:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB9CD6FA86
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OCK2mO019831; Tue, 24 Oct 2023 16:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OUW+5lLOwVU0El0YEsYLrQyI51GIhLcF3ur87ekoV70=;
 b=TyAKOZttVQ3VT8AylQeAptZm45adWkM5vrWEX/jWerI3Dv5gtaL0HtSgRxCAKyDC7tE0
 R57xrlgejiG0d6xSegKYI4njuZZPddBenelJCeDAE59/di1XyBgDQoB+esftvHia6HZd
 oL/IDBbvLd/iJTlIMvaNqlNw8VKKI59ySCq+P99q/z9ZUap1eqjGXdfGNGIPuTg3/jxh
 WUUiTrOVZ9HrGxDIO99cB+wz6VcwR/TMLRFTVLE1Ki1oqacgWNnqqSY4JPi07UIwjcfi
 9V3uKp8C3P3vt01YNFM5EFwPF3r2j2vEdgOjq5txuk6gCbqh6FVDHSF0a3qMsCgXdhj+ Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbdw4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 16:21:36 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39OGIWW4001520; Tue, 24 Oct 2023 16:21:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53bxvpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 16:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TexqB0NtlHof5wpAlFSzgrh1MVhRVj2+l/kwte2uDGJQPjkUP5MfmDm2vcpfJZr2hk/ndS25ydTQoK6feHpJreHfDqZExRzDM3FpkzRA+/ri2RN0MiLJYRpYjaz9L4Si8eS0A6FO2QrEX6bBLLGWAfvRbkv0IF8FPHGnWImrJb6GLUIHz9GIwvZUp4PSqO6Nm4GBR0aZciBU0bD4PawrRwngbB+9lUybm08uaXH3SdODSKXFUsGMeDqXl6AfLzAB/WTXh+YFQ0yPZHq61mU9xiLyCRK5Byjd5BM9mze9Q7W0bc3DmnhzU4ItSnsmDwbqY3r0LUixgqjkXcs3fDvUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUW+5lLOwVU0El0YEsYLrQyI51GIhLcF3ur87ekoV70=;
 b=GYECR5wejXnnDCnpMDCMpnL4a+mZ9S2UneL3sBhktEm2DokM9zaNDCNeyZqmOnNjvMMsog5n0NUGqhGDpYMILTxR4Ng6nIg34GGCO1ZmKyNUJZex2MENyzgfJsVMLKW7yHCK2S/32nDeCBAY3yfkzb5rt56VQiz+sb9xSyLpFpWuqGVi6jLg9D3lAj5n8J5lWYy1WQJyIP/1OeAXRM230jiogtwhQUCNuU8HDVvQ4ysqrT9hOGv8umUTEdghbF/Z2gJOQ9yDc6SQL3yb9mp4GykC/W+UEglo24pT9oBnlugrZt0IGPi/yU1Ri5XHX1N9fXNCZmgrjJvcJFQzDnhq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUW+5lLOwVU0El0YEsYLrQyI51GIhLcF3ur87ekoV70=;
 b=m8gogac8yKtf3MxozjOEJuD2NckwpPIO5z8PRvKm6K8QgxExk8kcjUDIYYMp5CVNxC1PPO89o/4lceTHaOIJggB5R/4PaXoBNCxj6XFF/SnTI/IH6xqS7KlXQ0In3WPXe3rIXiS0zBj1T9+Mc/QLGiHB9r9ixK1BgevxUtuDa4I=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7153.namprd10.prod.outlook.com (2603:10b6:8:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 16:21:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 16:21:33 +0000
Message-ID: <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
Date: Tue, 24 Oct 2023 09:21:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffa268-27ee-43c4-ee2b-08dbd4ad4960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+Msk3gGoZp/e0UgBMRm5TrgtrCXQ+OVv/DxXBHdpOxv1hhVWe+lYueNzv5w/GR+zom8cmL0kFkjBYue17Hb1Y+3sweKkiAZMhxosvjJ0A59UwaJnoSta9SXgzOw0iaNnKdUqc8BBaIp0TwSj7cZltsYBdQHpQksx/w5HA662AmR/+WYyo58zjMLqtTO/uSaRHL7iQhU9NBELBIps0+GDewHmiEucZ2Qw2iMHlmuVIMhRItms0OIhfTAba1aKraWLvqUWiloct3rIpo+NbqWBewrDcKPdisaV0EdrvDrkDDmvwGg2d0+FryD+twgWQHsaTOLhAe2KIAsEZwmIHv7HRlBIlU3QPLEsA/Zwk6TKUmiRIwtRecYo8y7gRAyd3cjhu0Vos/wjnURgIyX/dCbXTF7qgMaJLNpyfBHeQYNWwp+dMI2G8Z/Q34k4u/T3B2qoQfCUwiec05LEOcVxb39fiDGYp9okc7nFtHQxFcfWyRQXhCC+UMhyIlmcpQnxBcpRNcL9yzAdREyNyI8RvW9nbkNKruelWH7a6WfuJC8C12FDUdbnq5EODbUeNMCGUJ1aqWM3Q28W0vNymdITrLBArqtqzvjfWGVqiuOWf9xgBWGNNVVs3bs4lS7hwvo/ZKWL8jvc1aj9O/hYaY2fVUF2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6506007)(36916002)(5660300002)(6666004)(41300700001)(26005)(2906002)(83380400001)(36756003)(2616005)(38100700002)(86362001)(31696002)(6512007)(478600001)(316002)(66556008)(66476007)(66946007)(6916009)(6486002)(31686004)(8676002)(8936002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVcwL2RNYnZKbUswY3BuZG5sYmhOa2wyeXBTMHJ3RW9QSUdsZDdNQkpLMWJW?=
 =?utf-8?B?NDFIeUkvT2U0R0pidDFKVGVSYnRHdzZUK1F2clJmNWpMNnJFT0hiUVU3NmZz?=
 =?utf-8?B?VVZIcHV6Q3RPUVFUeklYWWNlTUFTVDhMMWZObUZ3SWgwVVlDK3dSVkdKbDJM?=
 =?utf-8?B?ejMxVWtUeXBLSWFYc1lORmZuZWlPcU9mNHJxS3Rydi9Jb2Y0bzNnYTNwY0RR?=
 =?utf-8?B?N3Z0bElPdGc1OW1xYURpRk5jSFcvRUJPcnV6WWc3Wk5SVkJGTDh5eVJlRFM1?=
 =?utf-8?B?ajRHY3FWRSszV2JYWGVHQUs3ellwZ1JtRytSeVdCRjB6eXpKeGwzanh2SjEz?=
 =?utf-8?B?TEVpdkoraVlZcy82WTRkOE9wZXROc2ZzUTM0MGNad3Q2ekhzaCs3bE1yV1VS?=
 =?utf-8?B?dEcwRkVCazZQYjgva1kyUkF4RFVJSG5TZXVyaGs3MnozWVdPVTE4d1NJa1Jk?=
 =?utf-8?B?WlAwdzcwRTRMUjdVLytwR29IK21UUzg2anpFQ1FRbktEdkh0S0dQQXFmeC9m?=
 =?utf-8?B?TDFqY0p2MjBoZkZOdkxoaXNWenNOZVVlb0ljY2E0YnlWUTJmQXR2bUIwQlp0?=
 =?utf-8?B?anBjUERqZXBLd2VlYWZwS0w5S1NYMlo3SUNsNys4dkFKU0dVdU5OSEFUZm1E?=
 =?utf-8?B?VUxOZmpra0hQVHlFMzFrb3FxdWZBdEViWGFZSTZqdmQ0NDRFNHF5RE1wQTZV?=
 =?utf-8?B?MDdEY2VRaUpEY0RRVWl2L0N5VnZFbkppanJzNlNOcFQ0MEtsRUcwS0l6TDVZ?=
 =?utf-8?B?ZTByUkM2Z09EbkdUZ2tFU0l6V2dxK2Vhd2tvbjh1ZDNJL0JCeDUrTE1YK2VH?=
 =?utf-8?B?RDQ2N0JOWVhsRmh0WHR2b1IzQWFCR3lsWTRWRUtmcEZzOURJTlljUy9ob0Rs?=
 =?utf-8?B?cktOaWt5WityWDZlTXI5TVhHaEZaaTdnOFZxOG1sMEtwMk9pV3VaRXVHcmhL?=
 =?utf-8?B?S2NQR09QZCtybG9IY1B3ZVN2UmVPWHNZOHR5MjI5NnFQMDNxUjN5UWFkYzA4?=
 =?utf-8?B?L21LbUxMYzgwVmZBdWRxbnVYZ3VPSVNtRTJFaEUySDVwWDNHeVFkWlFtdWI0?=
 =?utf-8?B?Z0dVUmRpRHNoeXM2NDA0MXV3cDRncHIvcUpJZzhYV0NFb3RFNHptbmVhTWhx?=
 =?utf-8?B?eGhxZXFUM1YvZGd6dFRBeHVoNjlSVXR6cEJGM3hLZ2h2OHJqNktVT3Y5akNX?=
 =?utf-8?B?R1ZubjNNSUpCVEEwc3NSUmJDMGhhaWsxR1h2ZWRJQjBMRGtpZXRoNDNKa1ZQ?=
 =?utf-8?B?VHA4WXhHQkczTmkwcFN4TTVKU05idk9XbWFPbnBFRmc1SjJBN0xpajZjL3Qy?=
 =?utf-8?B?WnZFWEd1ZEZrSytiYTdFY2YyUWpRQkF3cXQ5c3AvS2Z5SkZUWlhqTFZJVXFC?=
 =?utf-8?B?S1YwVmdpblAxV25qR1ZwcUlPc2dBeCtWRFlLWEVCbkoxbThXaDFXMWV1WXYz?=
 =?utf-8?B?dEhlOTN0VmRxdmpRV3Q3QXAySUNibE1sRXZsS2Q3Uk1OL1IwVEtDNUZ1RmJt?=
 =?utf-8?B?clA1MjRIQmNka3VHbjFmMnBOc29yaElDVGNVT2Z2LzErNUFSRk1IUWVzcVVK?=
 =?utf-8?B?VzlhZlpRelVERm0xYUlUd2VDWGh0Q0xmQWFWWkE0UjhhaktaUFZsVFQxZHlW?=
 =?utf-8?B?Yzlsc3VhdTJ2eEtXcy9tMlJKcHpiZFpEU1NzY1BmQ1Z0UjNBSzJXWFJvcVNG?=
 =?utf-8?B?Mlo2eHF2VTFWNmU1T3lCRFplcHRmSEtVVXNSdDF6T3ZsSmxRM0FoTXN4U29k?=
 =?utf-8?B?M0FiN0M2bjZ5UjQ4cFdYTXVJQzUxUE1TL01tbEUrWXZDUVpLZ0duSHNZcExz?=
 =?utf-8?B?OHFmd1d3OTRFdUFLZERsUDhGMXdtN0RYR3Rtb1JvOXZHTEZQcVlJZWNjZWRS?=
 =?utf-8?B?Y25SMVJzcHlGeHJHNE1oMmNTNG9VU1QwTXJtTUxpUjMyNFdCSXMraW5FcGVQ?=
 =?utf-8?B?MHhzTVVwb2dDekhBK3hwb1RVdU9kN0tsKzJla0QvMlNJdVdMMzNRMDFYbWZu?=
 =?utf-8?B?NXJoL3RFTXBzTmxsVlFWcTY1b05MNFNYeXF5Y3dLeVBWNGVNNUZhSEE2RWtR?=
 =?utf-8?B?dHVJbUg1aElkRjE0S0Z3d2JSeFVUeHZtTnMzUGl3ZXZ0bXVrYmdURHNFWkZ2?=
 =?utf-8?Q?1C2XvSQ0OCiIuHpFDKDBYUqOj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p5oOrRQelP6zKRveE7vmGV3oSmmv5PV329jUzczu/mr5nVb2tGNl3HJYtMdW/9/PaXWsIwORip9JyeAaQ3ZtGuJP8ptF5bjXV86i84vVuZoAU4w6TeIj7vK1itIfWnfxwoyn8L9mlWbNZW9HZk6D1p/9hdANcyj0py5iPbbl5nlhrpOT2CJfqgYUWEF6+QhZlcOXMI4t+2mDdlQqeS3h31o4w5nAtv/4Z5T2kYngEntAJEg4XRA0Dhn1Orkt4TlaRD8NGGmlo9RHCgSUe+aY1onmaSLY/SdmxC9ocSV2sz+XJPEzqmJLnNYhhh9C7NTcrYUi7ea+BTK26075NzOvs6cZ6Z8nT8MpTfrA5nu8BS1zUJKqtCo2U3YaYuIXh/EycCHtavtHtAODQbCY085OPJuGtUFA6E8zxlWMU8/4Dwa0SqIgCVVdZuWaLxUgJCxE+o40y6fgzCMlOHyhvCb3tdBFXnDo1KQVTDrain/OKIJEfRpbQmwCwS469dtQ86/wLMqtQvFX5b2XtwO40AcklnG7EZzrtBoS5RwIn+eNtl4T1sPxSAbT4jhboRvhTOBvnIt2OVQdCicQIuZY5K0+bAYHvct4cFDPLlOo9ZwLTw0BiamgBfbBIG4S3WOPm1Ooz7cqAf5PT3NP6cyX5idoIdS1OcbtUTY2ojXThzUtvIGpqBTIMf6pPhO3dLdPKtiotjShtJPz+FS4hnQzVd0qnH+IsJ6i7L9l7LYNVmx1kBHjmvjgxYpi4nPudZkpjvm0fs60dSUK24/xsSHAMG1McZRXYt5/Zl3eOpEqGt5gfModZYhzcLjOcAgdtocdv76aTEr330BTpa2Xk5HZ27hQwo0Iht+x6bZUYih6kv6YKJ/WphwvCctUt0xj9Y8fOpBsP6wEwnPS7q38GZ94QijD1g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffa268-27ee-43c4-ee2b-08dbd4ad4960
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:21:33.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIN8RU2P3auSSvZpL+nhUZk8m5dbF6rBJkbh+2Ix8mYmqnbIUW12IYDwHFa5HpVlEPDx8U9XAaFwVrx30q9vRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240141
X-Proofpoint-GUID: tlyQZ8tdL3Gf1YxfLf4ft-Dt9aF8ReQd
X-Proofpoint-ORIG-GUID: tlyQZ8tdL3Gf1YxfLf4ft-Dt9aF8ReQd
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMC8yMy8yMDIzIDEwOjQ1IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFNhdCwgT2N0
IDIxLCAyMDIzIGF0IDU6MjjigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+
IHdyb3RlOgo+PiBVc2luZyAuY29tcGF0X3Jlc2V0IG9wIGZyb20gdGhlIHByZXZpb3VzIHBhdGNo
LCB0aGUgYnVnZ3kgLnJlc2V0Cj4+IGJlaGF2aW91ciBjYW4gYmUga2VwdCBhcy1pcyBvbiBvbGRl
ciB1c2Vyc3BhY2UgYXBwcywgd2hpY2ggZG9uJ3QgYWNrIHRoZQo+PiBJT1RMQl9QRVJTSVNUIGJh
Y2tlbmQgZmVhdHVyZS4gQXMgdGhpcyBjb21wYXRpYmlsaXR5IHF1aXJrIGlzIGxpbWl0ZWQgdG8K
Pj4gdGhvc2UgZHJpdmVycyB0aGF0IHVzZWQgdG8gYmUgYnVnZ3kgaW4gdGhlIHBhc3QsIGl0IHdv
bid0IGFmZmVjdCBjaGFuZ2UKPj4gdGhlIGJlaGF2aW91ciBvciBhZmZlY3QgQUJJIG9uIHRoZSBz
ZXR1cHMgd2l0aCBBUEkgY29tcGxpYW50IGRyaXZlci4KPj4KPj4gVGhlIHNlcGFyYXRpb24gb2Yg
LmNvbXBhdF9yZXNldCBmcm9tIHRoZSByZWd1bGFyIC5yZXNldCBhbGxvd3MKPj4gdmhvc3QtdmRw
YSBhYmxlIHRvIGtub3cgd2hpY2ggZHJpdmVyIGhhZCBicm9rZW4gYmVoYXZpb3VyIGJlZm9yZSwg
c28gaXQKPj4gY2FuIGFwcGx5IHRoZSBjb3JyZXNwb25kaW5nIGNvbXBhdGliaWxpdHkgcXVpcmsg
dG8gdGhlIGluZGl2aWR1YWwgZHJpdmVyCj4+IHdoZW5ldmVyIG5lZWRlZC4gIENvbXBhcmVkIHRv
IG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQgd2l0aAo+PiBmbGFncywgLmNvbXBhdF9y
ZXNldCB3b24ndCBjYXVzZSBhbnkgZXh0cmEgYnVyZGVuIHRvIHRoZSBpbXBsZW1lbnRhdGlvbgo+
PiBvZiBldmVyeSBjb21wbGlhbnQgZHJpdmVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhvc3QvdmRw
YS5jICAgICAgICAgfCAxNyArKysrKysrKysrKysrLS0tLQo+PiAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb192ZHBhLmMgfCAgMiArLQo+PiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgfCAg
NyArKysrKy0tCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+PiBpbmRleCBhY2M3Yzc0YmE3ZDYuLjljZTQwMDAzNzkzYiAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBh
LmMKPj4gQEAgLTIyNywxMyArMjI3LDIyIEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFfdW5zZXR1
cF92cV9pcnEoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4+ICAgICAgICAgIGlycV9i
eXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKPj4gICB9
Cj4+Cj4+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVzZXQoc3RydWN0IHZob3N0X3ZkcGEgKnYp
Cj4+ICtzdGF0aWMgaW50IF9jb21wYXRfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikK
Pj4gICB7Cj4+ICAgICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+
ICsgICAgICAgdTMyIGZsYWdzID0gMDsKPj4KPj4gLSAgICAgICB2LT5pbl9iYXRjaCA9IDA7Cj4+
ICsgICAgICAgZmxhZ3MgfD0gIXZob3N0X2JhY2tlbmRfaGFzX2ZlYXR1cmUodi0+dmRldi52cXNb
MF0sCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1Rf
QkFDS0VORF9GX0lPVExCX1BFUlNJU1QpID8KPj4gKyAgICAgICAgICAgICAgICBWRFBBX1JFU0VU
X0ZfQ0xFQU5fTUFQIDogMDsKPj4gKwo+PiArICAgICAgIHJldHVybiB2ZHBhX3Jlc2V0KHZkcGEs
IGZsYWdzKTsKPj4gK30KPj4KPj4gLSAgICAgICByZXR1cm4gdmRwYV9yZXNldCh2ZHBhKTsKPj4g
K3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPj4gK3sK
Pj4gKyAgICAgICB2LT5pbl9iYXRjaCA9IDA7Cj4+ICsgICAgICAgcmV0dXJuIF9jb21wYXRfdmRw
YV9yZXNldCh2KTsKPj4gICB9Cj4+Cj4+ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9iaW5kX21t
KHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+PiBAQCAtMzEyLDcgKzMyMSw3IEBAIHN0YXRpYyBsb25n
IHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpz
dGF0dXNwKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdmRwYV91bnNldHVwX3Zx
X2lycSh2LCBpKTsKPj4KPj4gICAgICAgICAgaWYgKHN0YXR1cyA9PSAwKSB7Cj4+IC0gICAgICAg
ICAgICAgICByZXQgPSB2ZHBhX3Jlc2V0KHZkcGEpOwo+PiArICAgICAgICAgICAgICAgcmV0ID0g
X2NvbXBhdF92ZHBhX3Jlc2V0KHYpOwo+PiAgICAgICAgICAgICAgICAgIGlmIChyZXQpCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+PiAgICAgICAgICB9IGVsc2UKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fdmRwYS5jCj4+IGluZGV4IDA2Y2U2ZDhjMmUwMC4uOGQ2M2U1OTIzZDI0IDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4+ICsrKyBiL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb192ZHBhLmMKPj4gQEAgLTEwMCw3ICsxMDAsNyBAQCBzdGF0aWMgdm9pZCB2
aXJ0aW9fdmRwYV9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4gICB7Cj4+ICAg
ICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZkZXYpOwo+Pgo+
PiAtICAgICAgIHZkcGFfcmVzZXQodmRwYSk7Cj4+ICsgICAgICAgdmRwYV9yZXNldCh2ZHBhLCAw
KTsKPj4gICB9Cj4+Cj4+ICAgc3RhdGljIGJvb2wgdmlydGlvX3ZkcGFfbm90aWZ5KHN0cnVjdCB2
aXJ0cXVldWUgKnZxKQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNs
dWRlL2xpbnV4L3ZkcGEuaAo+PiBpbmRleCA2YjhjYmY3NTcxMmQuLmRiMTVhYzA3ZjhhNiAxMDA2
NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC92
ZHBhLmgKPj4gQEAgLTUxOSwxNCArNTE5LDE3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGRldmlj
ZSAqdmRwYV9nZXRfZG1hX2RldihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+ICAgICAgICAg
IHJldHVybiB2ZGV2LT5kbWFfZGV2Owo+PiAgIH0KPj4KPj4gLXN0YXRpYyBpbmxpbmUgaW50IHZk
cGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+PiArc3RhdGljIGlubGluZSBpbnQg
dmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUzMiBmbGFncykKPj4gICB7Cj4+
ICAgICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZp
ZzsKPj4gICAgICAgICAgaW50IHJldDsKPj4KPj4gICAgICAgICAgZG93bl93cml0ZSgmdmRldi0+
Y2ZfbG9jayk7Cj4+ICAgICAgICAgIHZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gZmFsc2U7Cj4+IC0g
ICAgICAgcmV0ID0gb3BzLT5yZXNldCh2ZGV2KTsKPj4gKyAgICAgICBpZiAob3BzLT5jb21wYXRf
cmVzZXQgJiYgZmxhZ3MpCj4+ICsgICAgICAgICAgICAgICByZXQgPSBvcHMtPmNvbXBhdF9yZXNl
dCh2ZGV2LCBmbGFncyk7Cj4+ICsgICAgICAgZWxzZQo+PiArICAgICAgICAgICAgICAgcmV0ID0g
b3BzLT5yZXNldCh2ZGV2KTsKPiBJbnN0ZWFkIG9mIGludmVudGluZyBhIG5ldyBBUEkgdGhhdCBj
YXJyaWVzIHRoZSBmbGFncy4gVHdlYWsgdGhlCj4gZXhpc3Rpbmcgb25lIHNlZW1zIHRvIGJlIHNp
bXBsZXIgYW5kIGJldHRlcj8KV2VsbCwgYXMgaW5kaWNhdGVkIGluIHRoZSBjb21taXQgbWVzc2Fn
ZSwgdGhpcyBhbGxvd3Mgdmhvc3QtdmRwYSBiZSBhYmxlIAp0byBrbm93IHdoaWNoIGRyaXZlciBo
YWQgYnJva2VuIGJlaGF2aW9yIGJlZm9yZSwgc28gaXQKY2FuIGFwcGx5IHRoZSBjb3JyZXNwb25k
aW5nIGNvbXBhdGliaWxpdHkgcXVpcmsgdG8gdGhlIGluZGl2aWR1YWwgZHJpdmVyIAp3aGVuIGl0
J3MgcmVhbGx5IG5lY2Vzc2FyeS4gSWYgc2VuZGluZyBhbGwgZmxhZ3MgdW5jb25kaXRpb25hbGx5
IGRvd24gdG8gCmV2ZXJ5IGRyaXZlciwgaXQncyBoYXJkIGZvciBkcml2ZXIgd3JpdGVycyB0byBk
aXN0aW5ndWlzaCB3aGljaCBhcmUgCmNvbXBhdGliaWxpdHkgcXVpcmtzIHRoYXQgdGhleSBjYW4g
c2FmZWx5IGlnbm9yZSBhbmQgd2hpY2ggYXJlIGZlYXR1cmUgCmZsYWdzIHRoYXQgYXJlIGVuY291
cmFnZWQgdG8gaW1wbGVtZW50LiBJbiB0aGF0IHNlbnNlLCBnYXRpbmcgZmVhdHVyZXMgCmZyb20g
YmVpbmcgcG9sbHV0ZWQgYnkgY29tcGF0aWJpbGl0eSBxdWlya3Mgd2l0aCBhbiBpbXBsaWNpdCBv
cCB3b3VsZCBiZSAKYmV0dGVyLgoKUmVnYXJkcywKLVNpd2VpCj4KPiBBcyBjb21wYXRfcmVzZXQo
dmRldiwgMCkgPT0gcmVzZXQodmRldikKPgo+IFRoZW4geW91IGRvbid0IG5lZWQgdGhlIHN3aXRj
aCBpbiB0aGUgcGFyZW50IGFzIHdlbGwKPgo+ICtzdGF0aWMgaW50IHZkcGFzaW1fcmVzZXQoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICt7Cj4gKyAgICAgICByZXR1cm4gdmRwYXNpbV9jb21w
YXRfcmVzZXQodmRwYSwgMCk7Cj4gK30KPgo+IFRoYW5rcwo+Cj4KPj4gICAgICAgICAgdXBfd3Jp
dGUoJnZkZXYtPmNmX2xvY2spOwo+PiAgICAgICAgICByZXR1cm4gcmV0Owo+PiAgIH0KPj4gLS0K
Pj4gMi4zOS4zCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
