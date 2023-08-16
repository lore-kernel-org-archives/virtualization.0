Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA1CC0015E
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 00:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09BFF41B5E;
	Wed, 16 Aug 2023 00:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09BFF41B5E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=cN7u5Oyp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=UDv3ki/W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fY95k2-Y412I; Wed, 16 Aug 2023 00:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2186B41B5D;
	Wed, 16 Aug 2023 00:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2186B41B5D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB5CCC0071;
	Wed, 16 Aug 2023 00:02:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A517FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 00:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 670E741B5E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 00:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 670E741B5E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7VfQcqM5Kc7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 00:02:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19F4C41B5D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 00:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19F4C41B5D
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37FNPcMU011289; Wed, 16 Aug 2023 00:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CcnFnKH87/iCLKKSkmRQJSJE/jH/fA0wzSxigE5SMwU=;
 b=cN7u5OypYDITygF/UJzNjUbFm9qQRBQCgWX8NSlEE7m71DwfkgIQ/lLfttyWfD5Mh9Bf
 TEKaY5eZxS1AeJB/N6vP+59tV6dXaNKzSnNcJJfzu0esSXrrBZsVXeIVRiVZ0rHPDWDu
 u83BC7+EQ2A/LEs0O8OoIDhKl2Gro9ifO2//aYbc1x76F9SVt+QmqyJfVsEA3N7oD8wv
 J1vAqjXr/68dUd5h8dNnwcz4s1Ryn3oVdnKX+bIvui6hNJIaX6oUP98uMtkVb2MCzzj0
 wK/rkCk7mAI8OrG8PabTQXoLbw4R/gvxA/R0Y+qzpmdcL64eEY8ADjs1hGwtWGFj8VMq +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c5ssm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 00:02:29 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37FMIRRd005521; Wed, 16 Aug 2023 00:02:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey2dq8q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 00:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmImBHCT/6tRhM8Ob5MZBYBHCmkcn5ANOXF1g4ridEcu+OP313IUadTuCkDdR0tysz/S+DmEva+IT8aedZqpGcMMOm254udFumvENKKMkJdtJMJ/62FVGcSOUnO4r4Ftt/lvUPp+u7RhjSAytCjh+TIxI77Z5pa0tWGynJYwlANm4jgYVuofFWTnD8xAk+2omYV1BAd0PU9sT2hUwNw4ndBP17TdBZa8SYgqmBDRZkp7max6NGKdjsXd1tE3cTWPuijDB/8smO64dQte4aVkhV5DWijA3qLdPT9gg7ZZWmntTMSmJF9GC6f80fAgd0vPBbT3ORxaTSqo+3PC1RkPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcnFnKH87/iCLKKSkmRQJSJE/jH/fA0wzSxigE5SMwU=;
 b=WzZOa5k2lAVCGhQKtgXt69ke66HKK4UA1XcL9QXGuobR8K2MxgiUkwV5C/o7Hu//OUNNshnqYjHUp6K6K7kjjKVPl8pguXcX9jRiaon5pBxu9xpneOm5b1yEWMb7IZ9/bHIGunrnljhS2JZ3wYev67iqfHq4bIZKlmKvpVCklTKYJgL46n7W76Ax9p4FBB0pkraKH8S6pR5jrNl846mrD5FTCDt2EPzgfu89UVuHHaUQNRYsoO/oU5tQB0HEzGIFxkz8Jl74api1nGJUGMMvpCn+opsLS95wskGiRPt3XJ+WLnyL0WH9ZblUx79uvDutc6ZG/raOBJR48UQ4u5fn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcnFnKH87/iCLKKSkmRQJSJE/jH/fA0wzSxigE5SMwU=;
 b=UDv3ki/W7X1pttsPJyfS8sHTdUWx4s6yHEYbbXTkDWv7q9LxKClkInr283lbFQcRZxNLujxP9+300Iw9Uzi5ORE6WSbLIgQGf+XPDWJDLHcWCzWcEmYSfXtM8J42qOVwzODiIoSkpZHV/TNl7dAKzHDbCfUCOfcQu6vi8V0hoxM=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5575.namprd10.prod.outlook.com (2603:10b6:806:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 00:02:27 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 00:02:26 +0000
Message-ID: <c22b96cf-3fbe-618e-8980-004ea063d30c@oracle.com>
Date: Tue, 15 Aug 2023 17:02:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 0/3] vdpa: dedicated descriptor table group
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuUEHA9d3FXVvrzGm0_t6C3FJsNH+zkOYoH6EWpitfwqw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuUEHA9d3FXVvrzGm0_t6C3FJsNH+zkOYoH6EWpitfwqw@mail.gmail.com>
X-ClientProxiedBy: DS0PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:8:191::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: 419776ca-c6f9-4b43-43fd-08db9dec136d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc7DFt3nxTtiD7srugasWpqIPxA5YEWAMv8UDPKICt7mpDmgBjhyXTR5gFP/BrUTXZ7dlyoL0Ei3x6Q04T7rnaVrW/NH2FYyOVPmJS3qOS1OomvlVIhOXrDaoInjprdU6pVKc+b4+90ewNZnzRZJg8hutqIYVqAI4W5QQ1VFrTGVH9DdYe6FwOYQovW9iTwFQp4AmWV65gu1zULNa2UCqThQcMLqmnspqZ7a/cR4o2EuZEl7iKvz8v0dYAK384ouNKjdhfXmoepl5s4b1mfDkZXIE4rOImChb5jgMMpd3gONtC6ERmF072PKGAl0vAUj9UXTD7jDhwerV1ohVlRJA5Bb1uzYV5JgM6RnPCyUOoMY+Pru5Z3Qq2gGGmdGQ0e/8OKW9YjFYWhLQNKTwq4f5JAC1b6DyPTpRz2myWiaoJzdZ3GX0ezAvBek4voVIlKLS2A3FATgOVNKBIvmMh7W1L7353hwFq8Q++0h3IzQhP9/GAFoQzdbY7GYi7zIpOH/coWuNhT/CFWeIRuZmIHtXa9Av4Jh6G6kxSIxK84JHB1yaj1372liLFqQgOALGf/16u/Qk1321NTdfr4nywWxD9gwVvrKE8mNzX934wm9IUNTI8pMAZNLbYqUOUAJ2kIKF0hhL6Y80LrP48Lil+P7ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199024)(186009)(1800799009)(86362001)(4326008)(41300700001)(6916009)(31686004)(2906002)(316002)(478600001)(5660300002)(2616005)(38100700002)(83380400001)(66556008)(53546011)(26005)(36916002)(8936002)(6506007)(6666004)(6512007)(8676002)(6486002)(36756003)(66946007)(31696002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhqRmlRZndkUWplU2FFVVROVkVkWC9tendZT25IVTExRzFQUXhaaGhYRzFN?=
 =?utf-8?B?eVdrZXljQ2NSbzdHMnhwZ1FEeDdscSt2NkRGa1dWRUdZZHFkN3EvWHdiZjda?=
 =?utf-8?B?aXZiSVNJTlgyb3ZTTEpBY3Z3VlBZaUpWOGdkY201VEZSQW5MUzRFejBlMC92?=
 =?utf-8?B?UEkrTVpqSllrMkVnYUxvTHp0M1RURElnOGNUWWc5VGlaL3JQN2pBbzZubnpW?=
 =?utf-8?B?WHZ3VFlPWk9POW9kVmQ3emRKb0FXSHMzT3pRclp5QVB6dFlrMXZPcFIrYmlQ?=
 =?utf-8?B?bkFDZitWcFF5b00vVVhnWVFDWHViRmlUOTlUS2RwMEZSbkVHeTZUKy9aNkRt?=
 =?utf-8?B?RmJTc0p6RjlVT3Z3a0hWWU1vZC8vK2RYMVMzTzQybys2WExnQjZxUDdTOVN5?=
 =?utf-8?B?ODl6UlhRMWxxOWlNQUVFRHZMemorMDdkM2xjZ2dJZkZoRWc0L0lxUEVKd2x1?=
 =?utf-8?B?UnAwSmFFaXRPd3N0MDJlOEh6eTk4NVhBR3AvNFkvNUVDSDZGSzRSKysxNmhX?=
 =?utf-8?B?algvZnlwWkdSRFkxTHBqaGVjS3Bua3Q0SGlTS1NrVW80VzlDcDJRelJBTGU1?=
 =?utf-8?B?aEE3ci91U0lHd01RQ1FURTNsMjF4ZGozMlJFK1FqbmZueDZOb3BYQWQrTThi?=
 =?utf-8?B?Sk96aGpHSGZvc2VoQ3NOV09BNWwwS3lQNzNYM3lqTVlPZm1aRk5pQkN6ZXhQ?=
 =?utf-8?B?S1M2bGtqdWdtYW90VUk0bVdvYlJrU0V5S3lsWnhGak1lRUQxUFBpV0o1aG5X?=
 =?utf-8?B?QlduazlJSVIvU0dzTU0rb2x4R0hjYkhhdU1hQTJRS0VIVEdJSXRsTE9SNjJK?=
 =?utf-8?B?elVvcnk2TEN1SEI5cjFRbnlqNjJaS0tPZk5UaDU2OTA5NkJsMjRqUXhOeitW?=
 =?utf-8?B?SEQ3RlpQY0crcUNQcTNhTk5CQ0NieHE2L0grQ0xlUDNUR1Z3RUcxbXVKRzYv?=
 =?utf-8?B?dWZlTmZseWpub1VzaytUaVROaklLNWxGYUFDTzAvejN0cmd1VzhvVmUyTXQ3?=
 =?utf-8?B?c1ZzTW1xZlc4dDM0bVVKYnFyZ0NiOUFFK0VvTklMOS9yMEpZbWhTYlZaNVl4?=
 =?utf-8?B?STd2aHRqNHJ3S1RnVng2UndCYnM2MGlBNlZmSSt3SFpiOURlWWN5R0oraGF6?=
 =?utf-8?B?V1I4djhtVzl6YWJuclBMeldqL2dRdjlSOXpKelQ0aDI5ZUJHcHFucE4vSFNt?=
 =?utf-8?B?amt2VUZ3RlhlbStkQ3JGY0NkelhvbEkvdFh4Q2JUZlZONFJNd2VDMmw1MXNC?=
 =?utf-8?B?alJOWEtOQzBuTnhBYmRMRDJTaWl0b0JTU0c1dnVxdnVCZ0pmbnhwWlpZTi9C?=
 =?utf-8?B?MU1wbVh5R1EvYjBzaE1xSklKY3E3VzhVZnZXbXdaaEJ5R2Y3RXZFMGtkU0RD?=
 =?utf-8?B?Q1pZWnBjVmpzL1FwN0RQVFhYajJUMU5lczhrSGxFWE1uMlM5a1drRkROd3FR?=
 =?utf-8?B?YXdsNTRkc01LY3FPOExieWRxOS9FRmdqbk1OMkRBVVlINlRvZDJJSjhqT0wr?=
 =?utf-8?B?N3AvV0VkWWpRbXB3NGZlS0JlNWhMa29XR3RZV3FFL0FGWHg5Q3VGK0VrQjF6?=
 =?utf-8?B?UWxYNitsaldRWlNCenVmb1VyeWVUM3BmMGFYN1J0bGVqU0RZcGxXSTBJa0F4?=
 =?utf-8?B?MTBNZGlVMWROUnpzYURBcU1QWENXUVU4Z2dSOUVlZ1dLTHlIN2o4b3BOUHpr?=
 =?utf-8?B?bDlLMnNZV3JjK2dVMVhHa0Q0blF3d2hwN3lDMkZhRUdkZm5pUWs3QXZxbkFX?=
 =?utf-8?B?cDR4NkYzKzlxRUpKak5xYkYrQWRlWXdheU1sT2phWHRmL1Vvbzd3NzhDa1VE?=
 =?utf-8?B?WWVnVmc2RTU4bVJXY1ZyK25iR2VlbXFxSlZCT0cxdUNPc1ZSZXY3dTdVR3pB?=
 =?utf-8?B?a2hMdEpsR1ozUXhpbTRDTVp2NzNCWjRuby95YStTSjBMWEVDUkNrYzZZQ2Jy?=
 =?utf-8?B?V3gwa1JaWjN2SFZtUEhva0NwWWxjanF4aUQyUzduSU1pcmIrdnB5TlhqOEtH?=
 =?utf-8?B?TGRCdXlKL044aXVvdytLNVUvS01oeEhyUktxYm9WUEhsSUVpbmgxSVVSL3Jm?=
 =?utf-8?B?WnE3cnBCTkU5N2g3ajlqS1FXd1FCOSs2cnJ4cW8yTGdGNXNBSW9xVENDdUZK?=
 =?utf-8?Q?CsMfpI7sfuuOuXdlzzHu/I7to?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lTTnyZ9xjy4awHBs16pY8xkTvuX4YIjAlcmje3yFXlwazDopu/O0AaAKxr3OFgc+ToWkwJKZTWnF20E/VAXeJ0GoM44EdKOPNAF+HUWjlkRuchDO3dOMJv28mD6DOjBSU7d80QCiWQj+Lhq89U/Ocv5RgiyT5QI2DYrQzvXrUtkXIieQ9BcKKWEL+H2CR/AelTEtcYlvK9DhhEV8TAAX3LV6FJADGGWHyFuTm4yd6PROTf3DeJDP/czQjehPSbiGWookgtzufeDMhwTshderx57BZiOoHi8sWJ7tnz/nqVmdV7+W+aVsZDvQU9FR9xp42ntbpr9glgKU9/bqzuO7CqXEJID1aa3A1Xi8xarQMoOSEBaAXzOd7tVTbdClUPiIy4+z8GFohIgJspWiCYakb5pORSj8fIiiN73Ut7gtS/qPI08rlZoP1JJnp1zwpGwzhKVbOwCp9xvEMDsbEOZkNJtAfvb+aPLhqrIhAj3dP4bnP95zJO0W0HUGCP3z+9vUMlXL81OnQ18fzYs0j6rlPwv5DfddbgJHphrSvmojSraC7YCRJc8AZyryesRm0UZtP063LIUa55z+SnPL3fdDiqX1oeSG7rD+HuJdNugFTESKztTaDRY4oq1UeHKOgoMqyNPbmVjsftv+5Ns7Iaa7cIKQKzuB1RCZ3ftKZVQ7cY7t1NsC4neJFN64IK2OBTJasqi8xPv12aW7Zph9+2xQMXb07DNJ9tSYjj9eR68Z+JKef+/RwynuQgMV4KE9ukG8wDVV9Pap7i3/zqo6nHJI3jRBXdX5Jw8ICfDQSTlUyONGNzp9Ofw/J+OqcGBzEL3msP+OLkOyvAVXMTgeeDbPZxvd0p4axLGe35UwC+QrWEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419776ca-c6f9-4b43-43fd-08db9dec136d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 00:02:26.8323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGjYxVhADvTzd4hWZtMprJ8wNGkPGStD75pgFqNlhRAYRXehHYL259kONYkxbVjrQx3HB26aSkKSCn5MCFpt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_20,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=599 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150216
X-Proofpoint-GUID: KtTrXHraQLVjQkKNQRxRI4EtVqsuK4Wp
X-Proofpoint-ORIG-GUID: KtTrXHraQLVjQkKNQRxRI4EtVqsuK4Wp
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

CgpPbiA4LzkvMjAyMyA4OjUwIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFdlZCwgQXVnIDks
IDIwMjMgYXQgODo1NuKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3Jv
dGU6Cj4+IEZvbGxvd2luZyBwYXRjaHNldCBpbnRyb2R1Y2VzIGRlZGljYXRlZCBncm91cCBmb3Ig
ZGVzY3JpcHRvciB0YWJsZSB0bwo+PiByZWR1Y2UgbGl2ZSBtaWdyYXRpb24gZG93bnRpbWUgd2hl
biBwYXNzdGhyb3VnaCBWUSBpcyBiZWluZyBzd2l0Y2hlZAo+PiB0byBzaGFkb3cgVlEuIEFzIHRo
aXMgUkZDIHNldCBpcyB0byBzZWVrIGVhcmx5IGZlZWRiYWNrIG9uIHRoZSB1QVBJCj4+IGFuZCBk
cml2ZXIgQVBJIHBhcnQsIGZvciBub3cgdGhlcmUncyBubyBhc3NvY2lhdGVkIGRyaXZlciBwYXRj
aCBjb25zdW1pbmcKPj4gdGhlIEFQSS4gQXMgc29vbiBhcyB0aGUgc3VwcG9ydCBpcyBpbiBwbGFj
ZSBvbiBib3RoIGhhcmR3YXJlIGRldmljZSBhbmQKPj4gZHJpdmVyLCBwZXJmb3JtYW5jZSBkYXRh
IHdpbGwgYmUgc2hvdyB1c2luZyByZWFsIGhhcmR3YXJlIGRldmljZS4gVGhlCj4+IHRhcmdldCBn
b2FsIG9mIHRoaXMgc2VyaWVzIGlzIHRvIHJlZHVjZSB0aGUgU1ZRIHN3aXRjaGluZyBvdmVyaGVh
ZAo+PiB0byBsZXNzIHRoYW4gMzAwbXMgb24gYSB+MTAwR0IgZ3Vlc3Qgd2l0aCAyIG5vbi1tcSB2
aG9zdC12ZHBhIGRldmljZXMuCj4+Cj4+IFRoZSBwbGFuIG9mIHRoZSBpbnRlbmRlZCBkcml2ZXIg
aW1wbGVtZW50YXRpb24gaXMgdG8gdXNlIGEgZGVkaWNhdGVkCj4+IGdyb3VwIChzcGVjaWZpY2Fs
bHksIDIgaW4gYmVsb3cgdGFibGUpIHRvIGhvc3QgZGVzY3JpcHRvciB0YWJsZSBmb3IKPj4gYWxs
IGRhdGEgdnFzLCBkaWZmZXJlbnQgZnJvbSB3aGVyZSBidWZmZXIgYWRkcmVzc2VzIGFyZSBjb250
YWluZWQgKGluCj4+IGdyb3VwIDAgYXMgYmVsb3cpLiBjdnEgZG9lcyBub3QgaGF2ZSB0byBhbGxv
Y2F0ZSBkZWRpY2F0ZWQgZ3JvdXAgZm9yCj4+IGRlc2NyaXB0b3IgdGFibGUsIHNvIGl0cyBidWZm
ZXJzIGFuZCBkZXNjcmlwdG9yIHRhYmxlIHdvdWxkIGFsd2F5cwo+PiBiZWxvbmcgdG8gYSBzYW1l
IGdyb3VwICgxKS4KPiBJJ20gZmluZSB3aXRoIHRoaXMsIGJ1dCBJIHRoaW5rIHdlIG5lZWQgYW4g
aW1wbGVtZW50YXRpb24gaW4gdGhlCj4gZHJpdmVyIChlLmcgdGhlIHNpbXVsYXRvcikuClllcy4g
RldJVyBmb3IgdGhlIHNha2Ugb2YgdGltZSBzYXZpbmcgYW5kIGdldCB0aGlzIHNlcmllcyBhY2Nl
cHRlZCAKcHJvbXB0bHkgaW4gdGhlIHVwY29taW5nIHY2LjYgbWVyZ2Ugd2luZG93LCB0aGUgZHJp
dmVyIHdlJ3JlIGdvaW5nIHRvIApzdXBwb3J0IGFsb25nIHdpdGggdGhpcyBzZXJpZXMgd2lsbCBi
ZSBtbHg1X3ZkcGEgaW4gdGhlIGZvcm1hbCAKc3VibWlzc2lvbiwgYW5kIHNpbXVsYXRvciBzdXBw
b3J0IG1heSBjb21lIHVwIGxhdGVyIGFmdGVyIGlmIEkgZ290IHNwYXJlIApjeWNsZS4gRG8geW91
IGZvcmVzZWUgYW55IGlzc3VlIHdpdGhvdXQgc2ltdWxhdG9yIGNoYW5nZT8gV2Ugd2lsbCBoYXZl
IAptbHg1X3ZkcGEgZHJpdmVyIGNvbnN1bWluZyB0aGUgQVBJIGZvciBzdXJlLCB0aGF0J3MgdGhl
IHRhcmdldCBvZiB0aGlzIAp3b3JrIGFuZCBpdCBoYXMgdG8gYmUgcHJvdmVkIHdvcmtpbmcgb24g
cmVhbCBkZXZpY2UgYXQgZmlyc3QuCgpUaGFua3MsCi1TaXdlaQoKPgo+IFRoYW5rcwo+Cj4+Cj4+
ICAgICAgICAgICAgICAgIHwgIGRhdGEgdnEgfCBjdHJsIHZxCj4+ID09PT09PT09PT09PT09Kz09
PT09PT09PT0rPT09PT09PT09PT0KPj4gdnFfZ3JvdXAgICAgICB8ICAgIDAgICAgIHwgICAgMQo+
PiB2cV9kZXNjX2dyb3VwIHwgICAgMiAgICAgfCAgICAxCj4+Cj4+Cj4+IC0tLQo+Pgo+PiBTaS1X
ZWkgTGl1ICgzKToKPj4gICAgdmRwYTogaW50cm9kdWNlIGRlZGljYXRlZCBkZXNjcmlwdG9yIGdy
b3VwIGZvciB2aXJ0cXVldWUKPj4gICAgdmhvc3QtdmRwYTogaW50cm9kdWNlIGRlc2NyaXB0b3Ig
Z3JvdXAgYmFja2VuZCBmZWF0dXJlCj4+ICAgIHZob3N0LXZkcGE6IHVBUEkgdG8gZ2V0IGRlZGlj
YXRlZCBkZXNjcmlwdG9yIGdyb3VwIGlkCj4+Cj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAg
ICAgICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaCAgICAgICAgICAgICB8IDExICsrKysrKysrKysrCj4+ICAgaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0LmggICAgICAgfCAgOCArKysrKysrKwo+PiAgIGluY2x1ZGUvdWFwaS9saW51
eC92aG9zdF90eXBlcy5oIHwgIDUgKysrKysKPj4gICA0IGZpbGVzIGNoYW5nZWQsIDUxIGluc2Vy
dGlvbnMoKykKPj4KPj4gLS0KPj4gMS44LjMuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
