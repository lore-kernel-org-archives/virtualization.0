Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF9DC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 07:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2182560D71;
	Tue, 16 Aug 2022 07:41:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2182560D71
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=qOrbwdho;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=uCFJR5vr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBHDSkWurWyy; Tue, 16 Aug 2022 07:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7511560E66;
	Tue, 16 Aug 2022 07:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7511560E66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45FE4C0032;
	Tue, 16 Aug 2022 07:41:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACB0CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:41:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74F504093D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74F504093D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=qOrbwdho; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=uCFJR5vr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5UxNL-gEdv_5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:41:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3EF6C404E9
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EF6C404E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:41:33 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G3TdqO019992;
 Tue, 16 Aug 2022 07:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+izGpqbVAQm2C56q8HKmJmGdbaBr4oa6mtMRNgtebdI=;
 b=qOrbwdhoLaGqMN6q6cPTtMztaMQI3XNxt4krgzr2PANe5uriJEo0vMcpLNGQA/ZqCz89
 eRJ2xT460aF2By8Nd6wPR/PxKZAGjpSVpp5ReYOfrqoTaC3D1a3dOrwuU4ap6zIQh+9M
 ePzqsqfz6S/JEW4acreuuIgv63KbWAuHwAx51BM3xAiGe4ACqb0lEoNCYGX5KMVygC74
 dTw1qOEMHanqmFwywmIRzhMMFfCSqFuBG21wGfEQvFlUEzmYQNOBz7XLxazQ1+PsBMqF
 bRcGWlyjZXDtJ5/Bwo2A4CMdLS2dQHHPPcrLH9/TVcmpgEh5hWzycd/GW8l2UHSW0x97 jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3ua4x0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 07:41:27 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27G5GmN4027040; Tue, 16 Aug 2022 07:41:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d2f9q3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 07:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXkcsU/z/+reSiU1yH8swy6YweAcMOhRu2SR+uCFfTpq4wJuP8Yhd9au6A+1iBkglgpbUBCQe2PMd508j/n2mf6JfMGUOnS+quG6T7sxDItuGmE0VbnatfOydyOBKDqQMSY7cwdriXMIcJE+SgXma2BvsCy/cmKnIsQwKB1C++gdDTr1nDZPnG4+fJXH700sIPCRZ/fkk04retempfwxHlZSbdCFvlomoat6/D5/jXhvbMCd9OZ4DGud3z5N7md3J6hq+hjVbAb+h+7vCXsQK0a01BFAGd67NiPVLnMGTSJUc4C/WLITMQK9J/C3DJZH4JDOTDpScfvzkRJ2sRF0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+izGpqbVAQm2C56q8HKmJmGdbaBr4oa6mtMRNgtebdI=;
 b=iBBVigqcYWdSccoRebRze3wyaH/rh1M99V5PN6u864aBOY7yzjORfYEEeeT1NvFWoTtmCtEr8cv7qItBYmaN2XQ8612G40hWH/Q9ejFn2f1jVJmigNc1AAzwPg0ASeTpi4VSRgT3DVArdJwNU2yOa9pc/iWpIWN/TI2orlPIoz0bJ8r2JyaX3M51h0OglRalKLUark6AzenLO115UNgTS1Ab8eayO2AnWBCUR6QjXqMfDxgTOihi5HQ3yXGTb2YwFhQ9uNdcX1iO6LgxTgKOFKPjUSyYyvrTGTq4tJgFRptnuDlja+/qAv+xOPSNG1GLdUfvPF5h3/SVDQrqbw3ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+izGpqbVAQm2C56q8HKmJmGdbaBr4oa6mtMRNgtebdI=;
 b=uCFJR5vrYGrf8s3Fzg0Y3P5Z8m0Xzfh7OZKRfjeKmKe5HEF3BWwesBUj0Wv3FXWDHBZYe8wAEiR5cDD51RfId4xxYmnYqRpUDJkfoJ4TUrfIkQz9m7KZFkizOPyzvoBE1vvkqQrMjJc14LVlyuHnLNWayi1udzXt1zcIlQ5KInM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4447.namprd10.prod.outlook.com (2603:10b6:a03:2dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 07:41:25 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 07:41:25 +0000
Message-ID: <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
Date: Tue, 16 Aug 2022 00:41:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: mst@redhat.com, Zhu Lingshan <lingshan.zhu@intel.com>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220812104500.163625-5-lingshan.zhu@intel.com>
X-ClientProxiedBy: SA9PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:806:28::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5e37a2-1183-4816-03e3-08da7f5ab8db
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4447:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCFiJg2afA7r+DJNEzEA7EqF+oicr7LQpgorIy2Gry2iPLAt2fSf7MzPLZPa1h0i+XHtmiVSveXXgPbslD/n4WvRH5If2zOimBv2/AfNKnygRVDbXmoAFoD216gDI2A9hwsemVajj7uVZ2L6AiigusAUIqp8nLjd6bR0OTKYL+pBCyeXJ0S0rQFwBwnZXapp3BcW2qUFurTcw+OGjMtNfkpwUEVi7ns39/dH4Zt0HI3zipVcDkS5zZojup9KYeB7JqSkFFLjhOzPEk4miOZ1CuPpk7JD5iFnIJC9BM5xhu4Cs6OYnRI7hKu8ddYS8gGf6UjBHGkxtHN92w1DORf2YQs0pHB/gAWcStmcK/DNhc6/ZIQXi/+OK8dZuJkr/YEIlR4k8gS6t4xQ/PMHYtaWoqy6FwY3UJAF6TA2OvmOoSu+hBe2wghbgk0cIo37NrtSIROF1OuPXTjdhtUH9HKMFU8qOXV0oqP7JiMiesqzKc+Fdtm8B7oCEGfp4NEHPF6A6ziN9swhNK7bxIC1wGHw0OjheI416B49C49rpV4tSfkkDJmG6bf6hw5cuGVa73L61Wyvb4dqG0qFKd+k4PM4Xdo3fg3DZP/ELQIB86V/XxN/pyOVpTbayCao6oPYToaEo0WvVy/2ly0bFFxW6aokl6CUw/wlQI+kSYx3h47raue/KG2P8t91SbhVS+0JOxruydTyyo+xMjEpN7LyRX2HwYBApB6DE/19lmjJWc0gqeELMpKBn3rYpCa8R2fF6Wm8xmPCulv5oB3jVF3eY6/4PYu1VGuckmLTJ8WNJoyB9EO143awt8Qh+a+jt0ASpW+KnBJGjmYnM0Uqh0fSzfmqKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(376002)(39860400002)(396003)(346002)(36756003)(2906002)(31686004)(38100700002)(2616005)(186003)(83380400001)(4326008)(6666004)(31696002)(26005)(41300700001)(86362001)(6512007)(8936002)(5660300002)(36916002)(6506007)(53546011)(6916009)(8676002)(478600001)(66476007)(6486002)(66556008)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3NPZGI2dENGRDBHVGpaQ2ttVER6UU43OUJIbitGcEVGRmx4eUg5b0VYOTdx?=
 =?utf-8?B?K3lBa2NQbzNTaHE0YndzTEh4UHJGQkxnVUNLMUhuV1pUWGNxaVF4ZDNFbDlQ?=
 =?utf-8?B?bnlwdS9vdnRNZnFsWjdzcXpQYlBZb0VHbjlteE1tNlZyY3BFdncvUmNGem5z?=
 =?utf-8?B?STg2TXhiaHpub0tGTU9SSU5pdDVLdTFIVUtZWFRsV09xV0oySmtMQXp1NE8v?=
 =?utf-8?B?TmxjQVQ0Vnloa3RjOUdXQ1ptLzk3d1l6VHRJMkZpT3BYbDVacmVyTGdvSysr?=
 =?utf-8?B?TUIzV3BmdHJKckZGeC9MUCtxbnR1Z0w1T05VVmdGSWR5Zys3RjFTTFdMeEp4?=
 =?utf-8?B?bnBKY1ptRXl1bTIrREEzS1hVdlN3ZU1yVWJHMG00ajUwQjlPQk05clRhbnVq?=
 =?utf-8?B?REgyUG82NG1ZcVJJVmxGdlY1MDlPc05HakppZjU1UmtSTmk0OGgwbGVhaUF0?=
 =?utf-8?B?bmR1WWVHZElrOC9ERldGZlVDbnkzcVZ6NTFHdjBnK2JGeEloMkdNWHJXYzRw?=
 =?utf-8?B?RHlXcDc2ZXNPL3RTTUZmcW9mcmZRbzZpb1U4RXdJMWcxNmdRYkpkdm9ucFh3?=
 =?utf-8?B?UWRmU3lzZklrMGpVQjJPRGFaTlQyNDRSTzNKaGd4OEFqNzE1MGpUMUVONmV0?=
 =?utf-8?B?amIxdWtGREJBcWZ1S2VWQ0hBNUN0a1U2ek5adWltbVNiTGtBYnBmQTBLanYx?=
 =?utf-8?B?VGlrUzlrWXg4ZXRqY09rUUZRWHU4UXNqam1xczRHRG1SVHJrWW5VNy9Ha3Ar?=
 =?utf-8?B?LzJjT2FTV0pxbFJQQXNxMUp3RWpnOVZtYmxCQXJ3YjBkL3NjdjVGK2xXb0xQ?=
 =?utf-8?B?eURybnFFaGgvR3ltOGNNZ3dxY0tHa0hyaE50bnRRWHUrMXA3UHRicUU0dDdy?=
 =?utf-8?B?SkJPYmhmdTAvUnpCcmtoTFZTRnZzaFdIZzlOTXRjdVRwb2NEaTNaMDdRZmc2?=
 =?utf-8?B?NXFaMnNsT3ZIWnUybFd1andiZGhRS3o3Mi8wSXhvaTA2S3FlSHcrSHZXMFFI?=
 =?utf-8?B?SEl0VUdjZVZ0VHp3N1JCSjBOdzVWREJCK3JEd1Z0WEZEVmJBQzFNWVVibURW?=
 =?utf-8?B?KzhpT2VSYUhzd0VSQm1zU3UwNXcwQUM1WXlqYzlLalYvSG1LaHNaSFpPeDNs?=
 =?utf-8?B?a0RVbDY1VHpxTkpIQnFidlM5cDVpaW1ndm16WVd4TS9zVmphc0xXeXRYczJZ?=
 =?utf-8?B?VmdiVXFFdVQ4STZJMlR1L0hySUNxSUpLVGpvNlQ5Z0FpdUswcGh6cHVqcFBz?=
 =?utf-8?B?bmkxaC9IY0Evb0hiZVcwMkdxUkNhOXRXUHlGZ0ZyUkszQkF3cWNPOWJqLy9n?=
 =?utf-8?B?OUdwYWdGaHNYU0hwMG1tWGZLSzlvWnk5eWZQd0QyRWJTNk9FYXFQSTVRNHNM?=
 =?utf-8?B?a1Y5RVd0c1V3WDNpeVhDUU56dTN4bjByQTV1QXQxclNjZVhaYlNEeEJHQnJ4?=
 =?utf-8?B?Rlh2WlJ2REt4ZmRwZjVoUXVnZERFdU9wRlZ5M0dUVk1lUWp2VTV2YmZlSE9Z?=
 =?utf-8?B?c1hnTmx6WlY2Yk05M3c0RDJMYmx6SDg0bDNSb3Q5NWd6N3UvWlZxSTFUeGVk?=
 =?utf-8?B?VW9kY0duOVBjVGQ4dGVRN0U5eFg3Q2NpVGdhTDRHckFvN040bDVzRUhjREtE?=
 =?utf-8?B?T1pFSzdWeVY0OTVmRjIzYXk0UnhMSEorRjUydXkrZEFwMEx5TWFyREFWVjdJ?=
 =?utf-8?B?UDVCdGNWRnVhSUp4aW5ieGNTSFFKVGgzeHVGWFZVUEpDR2g5R01SVWUxM2M5?=
 =?utf-8?B?VkVqYXlQOTdCRkI3dGU4TFdZcXY4L24xM21ocnBqaGJza0QvaDRWM1lKdDVl?=
 =?utf-8?B?TGU2SWhiOXk4enhQUW1La0xhcElXbDRPQ1I5Q0lFVlAyYkMycVVrRm9YNUlN?=
 =?utf-8?B?ZHo1eG93K3cyOHNSTnpXblNvZFhkdktQM3ZGSEk2NmlHQUZZRUJ0UkNWbWty?=
 =?utf-8?B?Mkxpb25VamZkN2lEOUxtWVRRL1l6WjRzcktJL0ZYT2p1aXJyK0k4bHMxdURN?=
 =?utf-8?B?VytnTldTV1hjMkFDY2RTanFDVDJiQ0JxaVo0NERlTDFBZDB2WVk1ZWlTZnRB?=
 =?utf-8?B?NWFzN2Vmc2p4Z1lpSERvY2p2cStLZEtxRXBDVXA4Snl5RzdTNWpzbzc3VHMx?=
 =?utf-8?Q?UreagvoIoXhWaOvDES04Y1+9R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SVd0VHlwMFJzcDNMVnFZZ01HSHF1Slh1Q0pSR0VUY3dqVUY2eTNOV3RxZHAw?=
 =?utf-8?B?Q1VwL3h6TVcySGJlL0locXBRbWRIV1YrclpmQjJiYi83dnJjaUhaaTZSQk9U?=
 =?utf-8?B?ZmY4Ny8yNk4xbTlZSHBaMHhDYlB1bjlYUFZBL3BFY01tUlNqbmgxZTNuREJv?=
 =?utf-8?B?bXVlbUR2N1FUWmh3NUJzWDRmUmFHWnJJaXgvb1FLbld5b1Y0QW1BZzQyY2Y4?=
 =?utf-8?B?cDN6M21lMUkxcWVBNWxDcXdBZHJwVUhUMHdvWU1XTHNENlg2NWpxZ0g4aFRV?=
 =?utf-8?B?NEJYdkh2UmxQYk9zbkx4a1N2c2RGRGE2Z2huZHcvajM0ZVQvb2NhQVB4cFVH?=
 =?utf-8?B?NEd5VW1SblFjc2pHMUgrY0lUazFpL1VNMVh4azRRRmhYOTBkZ0MxL3JtYkQy?=
 =?utf-8?B?OS9IK2VIT3lMbzFRN1hBeW5yYysrQnQydlJrdmYraXpYTGM5bmJwazNGN21J?=
 =?utf-8?B?VmFGaUV2bjhxVVRlTDBHMjJlSzFQMld5L0wreVhrTitiSThrdm5paVB6Skt0?=
 =?utf-8?B?a1ZtZUNpVjBPVlB1OTJqRWluTnJxbnJSSG1OU1VsbzRTREt6eFN3WXdmaDJ4?=
 =?utf-8?B?UytOYTVtZzlDUXpXUUxpZGx3RDB6SHR6WEVqNkwralA3V0pOV3p5bXRXU1VX?=
 =?utf-8?B?bGhuQ2FXS2pERGFEeVRWZTduOHJ4cHNpTlBjYXJIczFDVXlKQ25MWTlnS0lX?=
 =?utf-8?B?MzQ3NW10cjEyMXg2TGhDWWJMVUVpbEZyR3RnVGpiMDU0M2hsZm9TbWxKbEZ5?=
 =?utf-8?B?YnNJR2YrbS9pK1RxUG9zK2ZPZUx3dUxsNm43L1d1NHM5c01nNGUwNTB6cTJ6?=
 =?utf-8?B?dGdGZnlDZzFHcUw0L21rQ240OGdxK2ppbFAxR0QybjhJTjlFbS9YYUZaUy8w?=
 =?utf-8?B?OEkxdS8yQVBNTWZBd1RHVVFPTnVKeEhzSFZ3aE5FWjNPOTEwQ3hNaGVaMHo3?=
 =?utf-8?B?SXhhak5OYUZYclBJNkRTVW9pWm1yZDNobkgxUGs5c3FtY1VxMVcvQ3I0dy8y?=
 =?utf-8?B?bUJ2WVZ0RzR0QXVuc2NTZnlMOFQ4TG5hWFo5SDN1VVVmY3lML28xT0UwSzFH?=
 =?utf-8?B?QUtvUWs4VjRjWVA0ems0bkl1YnpJMjVKZmNFMUc4aDZPa0RLWDIzUk5EdCtT?=
 =?utf-8?B?WU9jdHJkWFM1bjRjMnU2ZzVyZnBNZGxDSWtQeEUvZU1zQVk0Zm1XeUZpd3RN?=
 =?utf-8?B?RDZNczlUK2dNNU1mem4reFc2VWQ1dGovM1pDWS81YXFiV29ORjl3YmtNT0lx?=
 =?utf-8?B?azEyRnJBamN3d1RJbGVsajlFQS9jNzZhVnVldERoNnBhaWpUM1JqU2dKcDZE?=
 =?utf-8?B?Z1g5VllPU3M2Nm9mSWxacHlMUzBVMFR6Yktza2srakdSUUxOUmpCSmY5VlZQ?=
 =?utf-8?B?OWlzN0dscDdVSkJrMEFVL3NkTGJQT2JFNld1KzFyWUhybWVxVWIrK1Q2ZU5L?=
 =?utf-8?B?UWIzem1keENMTUxlSEZ5SVcrcU5TNjJYL0p4K1RrK3JrTU9wWURObDh1eWww?=
 =?utf-8?B?Y3pLaE5EK1o3NExWcHJEZ3lqOHFtUWVkMm5yUWM2Y1JxUkFjMkVlYzgvQ0FT?=
 =?utf-8?Q?O2MbI/uU6ypPBm7xxBUa9fWkKEx+HZudiQTh/xWKBr/PV+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5e37a2-1183-4816-03e3-08da7f5ab8db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:41:25.3366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC+akGhxFgqEzkHqmxc6JZ4AncgdH+PsQOlhvH6AZ76HGdtju4HCGFcD7ICK35lTcQiBd0Ht+DTM9+aMWWDvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_06,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160029
X-Proofpoint-ORIG-GUID: tE-lbBv3VKcCaEtwBJ4JcBgkDmuwWAd1
X-Proofpoint-GUID: tE-lbBv3VKcCaEtwBJ4JcBgkDmuwWAd1
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

SGkgTWljaGFlbCwKCkkganVzdCBub3RpY2VkIHRoaXMgcGF0Y2ggZ290IHB1bGxlZCB0byBsaW51
eC1uZXh0IHByZW1hdHVyZWx5IHdpdGhvdXQgCmdldHRpbmcgY29uc2Vuc3VzIG9uIGNvZGUgcmV2
aWV3LCBhbSBub3Qgc3VyZSB3aHkuIEhvcGUgaXQgd2FzIGp1c3QgYW4gCm92ZXJzaWdodC4KClVu
Zm9ydHVuYXRlbHkgdGhpcyBpbnRyb2R1Y2VkIGZ1bmN0aW9uYWxpdHkgcmVncmVzc2lvbiB0byBh
dCBsZWFzdCB0d28gCmNhc2VzIHNvIGZhciBhcyBJIHNlZToKCjEuIChib2d1cykgVkRQQV9BVFRS
X0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTIGFyZSBpbmFkdmVydGVudGx5IGV4cG9zZWQgCmFuZCBk
aXNwbGF5ZWQgaW4gInZkcGEgZGV2IGNvbmZpZyBzaG93IiBiZWZvcmUgZmVhdHVyZSBuZWdvdGlh
dGlvbiBpcyAKZG9uZS4gTm90ZWQgdGhlIGNvcnJlc3BvbmRpbmcgZmVhdHVyZXMgbmFtZSBzaG93
biBpbiB2ZHBhIHRvb2wgaXMgY2FsbGVkIAoibmVnb3RpYXRlZF9mZWF0dXJlcyIgcmF0aGVyIHRo
YW4gImRyaXZlcl9mZWF0dXJlcyIuIEkgc2VlIGluIG5vIHdheSB0aGUgCmludGVuZGVkIGNoYW5n
ZSBvZiB0aGUgcGF0Y2ggc2hvdWxkIGJyZWFrIHRoaXMgdXNlciBsZXZlbCBleHBlY3RhdGlvbiAK
cmVnYXJkbGVzcyBvZiBhbnkgc3BlYyByZXF1aXJlbWVudC4gRG8geW91IGFncmVlIG9uIHRoaXMg
cG9pbnQ/CgoyLiBUaGVyZSB3YXMgYWxzbyBhbm90aGVyIGltcGxpY2l0IGFzc3VtcHRpb24gdGhh
dCBpcyBicm9rZW4gYnkgdGhpcyAKcGF0Y2guIFRoZXJlIGNvdWxkIGJlIGEgdmRwYSB0b29sIHF1
ZXJ5IG9mIGNvbmZpZyB2aWEgCnZkcGFfZGV2X25ldF9jb25maWdfZmlsbCgpLT52ZHBhX2dldF9j
b25maWdfdW5sb2NrZWQoKSB0aGF0IHJhY2VzIHdpdGggCnRoZSBmaXJzdCB2ZHBhX3NldF9mZWF0
dXJlcygpIGNhbGwgZnJvbSBWTU0gZS5nLiBRRU1VLiBTaW5jZSB0aGUgClNfRkVBVFVSRVNfT0sg
YmxvY2tpbmcgY29uZGl0aW9uIGlzIHJlbW92ZWQsIGlmIHRoZSB2ZHBhIHRvb2wgcXVlcnkgCm9j
Y3VycyBlYXJsaWVyIHRoYW4gdGhlIGZpcnN0IHNldF9kcml2ZXJfZmVhdHVyZXMoKSBjYWxsIGZy
b20gVk1NLCB0aGUgCmZvbGxvd2luZyBjb2RlIHdpbGwgdHJlYXQgdGhlIGd1ZXN0IGFzIGxlZ2Fj
eSBhbmQgdGhlbiB0cmlnZ2VyIGFuIAplcnJvbmVvdXMgdmRwYV9zZXRfZmVhdHVyZXNfdW5sb2Nr
ZWQoLi4uICwgMCkgY2FsbCB0byB0aGUgdmRwYSBkcml2ZXI6CgogwqAzNzTCoMKgwqDCoMKgwqDC
oMKgIC8qCiDCoDM3NcKgwqDCoMKgwqDCoMKgwqDCoCAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qg
c3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUgCmZlYXR1cmVzIGFyZSBzZXQuCiDCoDM3NsKgwqDC
oMKgwqDCoMKgwqDCoCAqIElmIGl0IGRvZXMgaGFwcGVuIHdlIGFzc3VtZSBhIGxlZ2FjeSBndWVz
dC4KIMKgMzc3wqDCoMKgwqDCoMKgwqDCoMKgICovCiDCoDM3OMKgwqDCoMKgwqDCoMKgwqAgaWYg
KCF2ZGV2LT5mZWF0dXJlc192YWxpZCkKIMKgMzc5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdmRwYV9zZXRfZmVhdHVyZXNfdW5sb2NrZWQodmRldiwgMCk7CiDCoDM4MMKgwqDCoMKg
wqDCoMKgwqAgb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwoKRGVwZW5k
aW5nIG9uIHZlbmRvciBkcml2ZXIncyBpbXBsZW1lbnRhdGlvbiwgTDM4MCBtYXkgZWl0aGVyIHJl
dHVybiAKaW52YWxpZCBjb25maWcgZGF0YSAob3IgaW52YWxpZCBlbmRpYW5uZXNzIGlmIG9uIEJF
KSBvciBvbmx5IGNvbmZpZyAKZmllbGRzIHRoYXQgYXJlIHZhbGlkIGluIGxlZ2FjeSBsYXlvdXQu
IFdoYXQncyBtb3JlIHNldmVyZSBpcyB0aGF0LCB2ZHBhIAp0b29sIHF1ZXJ5IGluIHRoZW9yeSBz
aG91bGRuJ3QgYWZmZWN0IGZlYXR1cmUgbmVnb3RpYXRpb24gYXQgYWxsIGJ5IAptYWtpbmcgY29u
ZnVzaW5nIGNhbGxzIHRvIHRoZSBkZXZpY2UsIGJ1dCBub3cgaXQgaXMgcG9zc2libGUgd2l0aCB0
aGUgCnBhdGNoLiBGaXhpbmcgdGhpcyB3b3VsZCByZXF1aXJlIG1vcmUgZGVsaWNhdGUgd29yayBv
biB0aGUgb3RoZXIgcGF0aHMgCmludm9sdmluZyB0aGUgY2ZfbG9jayByZWFkZXIvd3JpdGUgc2Vt
YXBob3JlLgoKTm90IHN1cmUgd2hhdCB5b3UgcGxhbiB0byBkbyBuZXh0LCBwb3N0IHRoZSBmaXhl
cyBmb3IgYm90aCBpc3N1ZXMgYW5kIApnZXQgdGhlIGNvbW11bml0eSByZXZpZXc/IE9yIHNpbXBs
eSByZXZlcnQgdGhlIHBhdGNoIGluIHF1ZXN0aW9uPyBMZXQgdXMgCmtub3cuCgpUaGFua3MsCi1T
aXdlaQoKCk9uIDgvMTIvMjAyMiAzOjQ0IEFNLCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4gVXNlcnMg
bWF5IHdhbnQgdG8gcXVlcnkgdGhlIGNvbmZpZyBzcGFjZSBvZiBhIHZEUEEgZGV2aWNlLAo+IHRv
IGNob29zZSBhIGFwcHJvcHJpYXRlIG9uZSBmb3IgYSBjZXJ0YWluIGd1ZXN0LiBUaGlzIG1lYW5z
IHRoZQo+IHVzZXJzIG5lZWQgdG8gcmVhZCB0aGUgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJF
U19PSywgYW5kCj4gdGhlIGV4aXN0ZW5jZSBvZiBjb25maWcgc3BhY2UgY29udGVudHMgZG9lcyBu
b3QgZGVwZW5kIG9uCj4gRkVBVFVSRVNfT0suCj4KPiBUaGUgc3BlYyBzYXlzOgo+IFRoZSBkZXZp
Y2UgTVVTVCBhbGxvdyByZWFkaW5nIG9mIGFueSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlv
bgo+IGZpZWxkIGJlZm9yZSBGRUFUVVJFU19PSyBpcyBzZXQgYnkgdGhlIGRyaXZlci4gVGhpcyBp
bmNsdWRlcwo+IGZpZWxkcyB3aGljaCBhcmUgY29uZGl0aW9uYWwgb24gZmVhdHVyZSBiaXRzLCBh
cyBsb25nIGFzIHRob3NlCj4gZmVhdHVyZSBiaXRzIGFyZSBvZmZlcmVkIGJ5IHRoZSBkZXZpY2Uu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgOCAtLS0tLS0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEu
YyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiBpbmRleCA2ZWIzZDk3MmQ4MDIuLmJmMzEyZDljNTlh
YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGEuYwo+IEBAIC04NTUsMTcgKzg1NSw5IEBAIHZkcGFfZGV2X2NvbmZpZ19maWxsKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNrX2J1ZmYgKm1zZywgdTMyIHBvcnRpZCwKPiAg
IHsKPiAgIAl1MzIgZGV2aWNlX2lkOwo+ICAgCXZvaWQgKmhkcjsKPiAtCXU4IHN0YXR1czsKPiAg
IAlpbnQgZXJyOwo+ICAgCj4gICAJZG93bl9yZWFkKCZ2ZGV2LT5jZl9sb2NrKTsKPiAtCXN0YXR1
cyA9IHZkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyh2ZGV2KTsKPiAtCWlmICghKHN0YXR1cyAmIFZJ
UlRJT19DT05GSUdfU19GRUFUVVJFU19PSykpIHsKPiAtCQlOTF9TRVRfRVJSX01TR19NT0QoZXh0
YWNrLCAiRmVhdHVyZXMgbmVnb3RpYXRpb24gbm90IGNvbXBsZXRlZCIpOwo+IC0JCWVyciA9IC1F
QUdBSU47Cj4gLQkJZ290byBvdXQ7Cj4gLQl9Cj4gLQo+ICAgCWhkciA9IGdlbmxtc2dfcHV0KG1z
ZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25sX2ZhbWlseSwgZmxhZ3MsCj4gICAJCQkgIFZEUEFfQ01E
X0RFVl9DT05GSUdfR0VUKTsKPiAgIAlpZiAoIWhkcikgewoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
