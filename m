Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A906C05027
	for <virtualization@archiver.kernel.org>; Mon,  6 Feb 2023 04:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4304606DC;
	Mon,  6 Feb 2023 04:53:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4304606DC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Usj+7OIk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xNKDBLt0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6q3ctFycuScV; Mon,  6 Feb 2023 04:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2381860648;
	Mon,  6 Feb 2023 04:53:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2381860648
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBD88C0032;
	Mon,  6 Feb 2023 04:53:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E2AC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB1E7813B1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB1E7813B1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Usj+7OIk; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=xNKDBLt0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Rwe6Ucg8D7i
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C7B3813AE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C7B3813AE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 04:53:44 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 315NFDB0006662; Mon, 6 Feb 2023 04:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kJikUNem+UXyvWL1BbsbGObhqq81a38vQwM2FC41YbE=;
 b=Usj+7OIk0eVnGiMVG6KtlxfbWMTVhg2l0W5Hm22v7I3hBfhezyKxbCW1NGRCRPKPjwbg
 SxYwhLUYI1z+s+iapVJWno5Y0Te/stU9cBGEaCUaVXwvX2PyQKnT/1qNLnVQZGkyxgBW
 2vD87z8fkFPalr+YseYZOkEM15n7l1vxGYoi9yE30wnx6K6exmFTwkOEPZFx8j34Wd/t
 f9jPvstYOcHPiMH7W014g1h/8Xkfd9F0L65vMuQmKSXaAOWPzvz7AOCi3rh1cYdaDycl
 8UwI1F6rMaPFmy5WNkJAv1B8tlt96y8J/WVUu1aVzqxSWypnhSR7xMM0U1cQvkJuP8VO 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytt092-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Feb 2023 04:53:43 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 3161v1fC016767; Mon, 6 Feb 2023 04:53:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3njrb837jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Feb 2023 04:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO5re6EfSgzrggfF6wmh3PrJLb/+Wg9FKF7TMO2Ytx57FY0tWpaDDoTqZo5kKWuBp6aG60VL7QBKD6ALRft3A3F4HNoIFMGc69M1JWzZzAYVFhl5uMEdYie23lV6YMjISxZBKteusWl51rOgLfqDIW3xvfEUqdLHepdW4V8M7/AtrJcnDMjoYYDlWYv/4cIv+9sHSvM4Wc+MAOKpPRJvgc2+7efk1t4U/1D6JXkOwYFoLZeL9qrX7nhd8z1Un53Gx/0PlTDDouSUJo0sTmUOG8CNjt3dlCaB6/T7zY2l+YiZtGpbYrLov6H8Cej4lB0wG8gFvcTV40Q8wACs07pAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJikUNem+UXyvWL1BbsbGObhqq81a38vQwM2FC41YbE=;
 b=CMvUmxcAef+vt70BnHhhUvetPUvTcLrhHuiJxJV4xUubcaOHkq10Rvty+Qj3IpXWEhzDEyUSA3YwkaZgqBgJcrXf91Ztf3ilTTwSHQGqiwCathF/cs1Cl+m5gXmUKornQDNM4sRxuBGFQ5x4K8zAwsEUBtu529Lv771zKSlL5k6K8pmxSHdd6bFqzIUTIMp19y3kmyBd8ZmJGWmpfmU8Cx/zyrsQPefhzxbvt7UG9rBD4xjEf9Z9oFmO3V4Uz+5OSJXxHKsvPXsIxFkHITf/+Gu1ylAVCXkrRtEpNSid4gbp2yrAwUzrysOMvnvABH6CL1nuyQVwyAM7GpQFt2X8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJikUNem+UXyvWL1BbsbGObhqq81a38vQwM2FC41YbE=;
 b=xNKDBLt0dvmwwmXisvUoltwgorffWDFAEZZQ3j5WAc71nfm5oEuRQI6zVfr8ywGV/BmJD6DXMbd98Ve64shLjOaBw09El53gptyHhMq04W5dSehLX3AwoMtz09IX+cfRnYFehwGPbjf3aMvHPAoQxhpxdxD9MsgRETGPHw1oins=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 04:53:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Mon, 6 Feb 2023
 04:53:33 +0000
Message-ID: <92e5a001-a17f-9d05-5412-355e1c436b30@oracle.com>
Date: Sun, 5 Feb 2023 20:53:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/6] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-6-git-send-email-si-wei.liu@oracle.com>
 <d6265719-a423-2798-4cd0-b4b57a34878b@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d6265719-a423-2798-4cd0-b4b57a34878b@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 34df053b-7bc8-4940-5fc5-08db07fe1989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt2LGDmr/5UPubUTsKqFVs5Y2GYDAUTymfdvTBSIMoXHlmCQ+V7e3RlLUsmUdVPKs4x5R8JewqlGtk638mrQH2bWXCfDhO1dJZQqAcB/GlVqhDe3txNi79o1leN441P9erNhXlQ6vvdW4x655uyzBrF41u7wUTKQSgx9zGQjru/laAGaTYUuaeb4tQ0w4+gq0mDjCkOpkI0Ra8eAx3lQfEGkjjTBc6PEQhFZ91V1GrESjr+lpMmkY7gI2KkgYSOJm9D3TxDWvg38JawbRgbvFmNHREgilUWaOTVDoLxaI0HWvvVivDcuNM1GJenS5hWI0dre8IEkOGQilPwL8GXdOksZka9TfL3hOFVL9bBZoImcf51Vu157m6AH2o5pYRffpBV5kH/U0vZVX0O3LiqsZD2ZjgoZIYSxhowvq23Q1mvzGKYwVWiOK51/LOVlEwFRcmkzecDXFsbEeoD277a3EyPXZtpqaKpiBTmIkOy0ItzjI6C1wc9jREYFoUxfNnoAWlui7pPhJarjczqQ31Q0MjzGcjWTSwwXpnpd7PKk8CPN6bbq9eGT2+fRIXbGfml7guul3J7f0vRD6nSjFIN3OtOosrq2R9tnaCNfNBX6S9OTA1zeHzMu4bx/kNLIX3JY+Ek1ss8IJPlC2o3PyqhnVNSTjNF2kAN4lUCRm7hjHuxpgGwdj0nRYt9OfVFBK437H+8Rzb3ncpgKvSNV6V8GPeF8r+UPdSsv59APqgCD/U8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(2616005)(36916002)(83380400001)(41300700001)(4326008)(316002)(66476007)(8936002)(66946007)(8676002)(6512007)(86362001)(53546011)(6486002)(186003)(6506007)(31696002)(66556008)(26005)(5660300002)(36756003)(38100700002)(2906002)(478600001)(31686004)(66899018)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjhka2Z4VGhNOEVBTXk4cnozNlpUdXVEZEVsbm9MYU96MTlCWUNtVjROV3o5?=
 =?utf-8?B?QjcxQ002Umc3YS95VlRTMG0wWkd0TFg1ZGFCR2FQTVJIZloyempBNmxXUmU1?=
 =?utf-8?B?U1dPdy8yWFBQL2RtWkthK1Z0eXZ0R2o2c3ZUTGpkdVF2cjFjWmhpZGZuQVJJ?=
 =?utf-8?B?MnkvdGdmUXJBL0NTbm9mNUgrYkhCcGppTGUvdXdsSzY0UWlTSy94YVUzTDVM?=
 =?utf-8?B?bTAyaVFXRVIwRUMyRDdxcXJQdDkvaWcxMXRhUkY2R2p5ejF6cFZ2ZGtBNzc2?=
 =?utf-8?B?SHdQRWRIcTlpOHNPdmNGdnIxdW9QWU4yVjZRelZ4dnc0czhHVWFEdEdsYUxH?=
 =?utf-8?B?TllGV2ZaakwxRlcwcDNHbXBzalBHQzJ3NW5idUljMGNhcTY3TStYaFU1M3cv?=
 =?utf-8?B?OTV0anRJZ2d5RWFYU0E0aWJJOWhJOE5zZzdiemJ5NlVSZ1hDU1pyT2x4RkxD?=
 =?utf-8?B?RFBGdlRKem5HRFJEVXhRUldFM0JpUE1qQ3ZnRjZNWVI2MEVVb3RrM2ZzYXBO?=
 =?utf-8?B?b0ZYZXM1aHJYR3JIZnpUbU5uc3c1SVp4TWhyMDNWQ1lMRXFzenhYbmVUVmd2?=
 =?utf-8?B?RFBlN3djbGVlOWxoSlFEK0NzUVlpU0pXWWtjQ0Q1UHl0cUh2UVUydVhlclAx?=
 =?utf-8?B?dXVUaG9oWFlsbHN3elQvZjVsaC9sLzJrNDRoNnFNRGV2MFp2NXJnbUt5dUx2?=
 =?utf-8?B?RGNHdDcrOVB4T1FEOXNxMUd5ZUQwUnFlQ280a0xlWUVOdGs2V3kvY3dmZDZE?=
 =?utf-8?B?bnRpbXg4ZmtqeTBrUHBsTW9xOUlVUldMMDhPajlySE5FVUNxUFVLNUhyMHZu?=
 =?utf-8?B?M0FWM1NjYkNWVGhpazRFL0xLS0RWUE84eCsranl6U2l3MjcrVDBmTFloUXVE?=
 =?utf-8?B?RlNCYmtSakduN1ZUUlBMVVdodXVna1hUb29Wa2p6bk41RXZ1cUQ2RElvQlVr?=
 =?utf-8?B?dXZrSXNUWU1kOW5Vekd5ZjlFUWNGNDJnT3lPVnVmWlgyYnlyOG5RVkZTS0dY?=
 =?utf-8?B?cEZ5UHpyaVlxZ25ROHNmVlByNzlVdmRHaVpUYkNQZDArcUJZSlB5bGpQRTZo?=
 =?utf-8?B?azVVQmowbXBLeVVyZVUwelEvaUZMeTFnVVpTU2grN0hRYVQzWGh1L3hVajFi?=
 =?utf-8?B?VGxrRWJDdmFjcVlzd0xsWjk1ajg2OXJNcktuN3pJWVJ5UU9saFhETU5MTkZa?=
 =?utf-8?B?QWZsbUNpTlB3ejNxV3NiQ29zdzloOHRNN3ltYWpSWXBidmgvcmtqUW8rU25n?=
 =?utf-8?B?SXk4RHRPaVVwbmVsVFBmNzAwNXRnZXRSUnpvaEFBYU56Z2pTZGdqYXNSQjBF?=
 =?utf-8?B?TWZQRmdFUFdleVNhTmJMcHErNU05R3d5TTJqeUtVdmFkU0VYWTB2OExxcDVp?=
 =?utf-8?B?b29rL2tjZ3I3M2NYd1hDNjk1NkllKzVPNzhweWk0VURvQjRXZG45bWZ6ZWdH?=
 =?utf-8?B?eHR4MlhYSnZWVHY0UVJGTVpnY1NCU09EekR6WjBLd1EwazhtbXp5b1FCZTRx?=
 =?utf-8?B?YzMwbU44U2IwMUM4Yit4Mzl6YUFvWjJaTkE1OHBYajZJa281NWhEVGFrV0da?=
 =?utf-8?B?M3hRdG4ycEZ2VzlWY0paaS9waUZrUk1aeUI4V09EcVoyWXhSUDJiT0p3MW1T?=
 =?utf-8?B?SzRMK2czRWNoeWFLSkJGM2g5VzdjZHBhbTdZTm5MK0xtWEV2elBGT3Q4d1hr?=
 =?utf-8?B?dGdUVzJ6MzRJM0c3dHJ6MG4vYUtPTU9VeG1YQ2FuUkswc3VKejBpVmNaL245?=
 =?utf-8?B?bEpqd1VrQWdWZmhsdmwrUTZWRWxKSkpjN01XUTlrMTAxYUlETTVKb3FiWFla?=
 =?utf-8?B?elVpTklXVEJPUnZHd1lOMnRIS1YyR2hqQVpxUHBPbHNUSzd2TUJacXNmZTl0?=
 =?utf-8?B?bDhIQmRZR1BaMmtGWTBxcjZ2c3VJTmVzUmc3K05XOENhRmR5WlhjcjloWnZ6?=
 =?utf-8?B?T0Z4NmVyWXFmeFEydmpiY1BsNTY3djZVWWwyb05USVMzbTlUalAzQjlIcmdV?=
 =?utf-8?B?aXRpazM2YStDNEVrMTZHRzgxTnVLNC9yRG5hOXRBQjY0WTgrWjR0UG9mbVd3?=
 =?utf-8?B?QzkwVWRPTXFKcGVOOHZwRWdzbEVQTmFxU0xRRHAxNnZYRFZJNFlzRjRYa1JJ?=
 =?utf-8?Q?wxlFzZJbGVc7tq+Y6uTJNcpVP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mosFwjzI8peUKJ/rJ9tExlx+BKvwjkQM99VlaWr3bYgHTg09CBPObpMK556fHlHdUxBBCDJAYhA9u4E6AVdvGX7NChznz/yJeWNEIKFk8E7JkiJjN6pXSNApfNPI6ovFUnoEiTy4As/HiOVoBXk97VddOANQqkkjsen0E3yHQVt8MgaQHtuhHePv5zJgkaKWs6ippa9lBU/kdb3XufTkrnK2ADX0JI9ATzVr/wWfpmmaylDjtHWorN4Zz4OK5yyeCUpzT4oJMkGoDm0J3fzIX+V596Gm+YBt14onsle0MKja30QZT5EkZrWrsm+xAz5k41bSwkJ8j1rGXpyvfnNoo+/UvN6FNKVS1EpdM3Sm9mtWEXxoCNQr59S9NRhOyi+h4bk7cbL4Ovb1JgU7HoZzQdWBPQRz4UY1ICFjpf9vMUdg6rHmUAbyS50D5a65KiNEmf2PYgqhaOMHd4hc4HM1dC9NXAnooM2u3yrfk/L6p18gPcr4Ejh2Q19GNNGYOq7MfU7037SuP24kp8QvgfArioGLITpycq+c/OtibjIPIv3IitKujrxnH9NcD1P2mz0v3wNPE3ZrhyViWTTaGU4R/8eY/lQJ430GxAWMoTryLyg0by4D7YoWiOm/mXAP5V0s59AIrztrnCXFUtMHIanzYwCU66ec4SjBR4yoT3hl8HKIveYtzsPu49QNlrC6/Wl0YJzhMzcUWy/II2pdI3dP2w6yAAZoZqjI7s/GZKqoG8+1mdpDxsJ4bPQKKUWJjND9IK2TX63fjyyQkSxi3up3WvjX5jtFf1iHawRwYb7Dn0DBtVnkPIBDNQjCaiknrXXs/R+uYUx3X7FqgYC5vMV6YVBz3Rd23+bTLg+JX6iPyrlfEbGOkFM9BsNTs7ta+9GinISBx0HiIfNuXWABu/gSvA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34df053b-7bc8-4940-5fc5-08db07fe1989
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 04:53:33.5672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M292CBFVAfK+29VnKDHXbSu8cNcdbklYjCs0YTAYW7ZNAGu4kd8dbtyyfpHOKuysneyrTrdfn3Efa9Cmp8Ib1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060042
X-Proofpoint-GUID: EmNh2jID1gTdsgNxnl0GtEEf_zmFsyfT
X-Proofpoint-ORIG-GUID: EmNh2jID1gTdsgNxnl0GtEEf_zmFsyfT
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CgpPbiAyLzUvMjAyMyAxOjM2IEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4KPiBPbiAwMy8wMi8yMDIz
IDc6MDIsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+IFRoZSBzcGVjIHNheXM6Cj4+IMKgwqDCoMKgIG10
dSBvbmx5IGV4aXN0cyBpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldAo+PiDCoMKgwqDCoCBzdGF0
dXMgb25seSBleGlzdHMgaWYgVklSVElPX05FVF9GX1NUQVRVUyBpcyBzZXQKPj4KPj4gV2Ugc2hv
dWxkIG9ubHkgc2hvdyBNVFUgYW5kIFNUQVRVUyBjb25kaXRpb25hbGx5IGRlcGVuZGluZyBvbgo+
PiB0aGUgZmVhdHVyZSBiaXRzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgfCAyMiArKysrKysrKysrKysrKy0tLS0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIAo+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+PiBpbmRleCAzYTZkYmJjNi4uODY3YWMxOCAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBAQCAtMzAwOSw2ICszMDA5LDggQEAgc3RhdGljIGludCBl
dmVudF9oYW5kbGVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAKPj4gKm5iLCB1bnNpZ25lZCBsb25n
IGV2ZW50LCB2b2lkICpwCj4+IMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV93cV9lbnQgKndx
ZW50Owo+PiDCoCDCoMKgwqDCoMKgIGlmIChldmVudCA9PSBNTFg1X0VWRU5UX1RZUEVfUE9SVF9D
SEFOR0UpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0
dXJlcyAmIAo+PiBCSVRfVUxMKFZJUlRJT19ORVRfRl9TVEFUVVMpKSkKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIE5PVElGWV9ET05FOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3dp
dGNoIChlcWUtPnN1Yl90eXBlKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIE1MWDVfUE9S
VF9DSEFOR0VfU1VCVFlQRV9ET1dOOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBNTFg1X1BP
UlRfQ0hBTkdFX1NVQlRZUEVfQUNUSVZFOgo+PiBAQCAtMzExOCwxNiArMzEyMCwyMCBAQCBzdGF0
aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCAKPj4gdmRwYV9tZ210X2RldiAqdl9tZGV2
LCBjb25zdCBjaGFyICpuYW1lLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVy
cl9hbGxvYzsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIC3CoMKgwqAgZXJyID0gcXVlcnlfbXR1KG1k
ZXYsICZtdHUpOwo+PiAtwqDCoMKgIGlmIChlcnIpCj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGVy
cl9hbGxvYzsKPj4gK8KgwqDCoCBpZiAobmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzICYgQklUX1VM
TChWSVJUSU9fTkVUX0ZfTVRVKSkgewo+Cj4gVklSVElPX05FVF9GX01UVSBpcyBvZmZlcmVkIGJ5
IHRoZSBkZXZpY2UuIFNvIGNvbmRpdGlvbmFsIGlzIGFsd2F5cyB0cnVlLiAKV2l0aCB0aGUgbmV4
dCBwYXRjaCBpbiBzZXJpZXMgdGhhdCBzZWxlY3RpdmVseSBwcm92aXNpb25zIGRldmljZSAKZmVh
dHVyZXMgdG8gbWx4NV92ZHBhLCB0aGlzIGNvbmRpdGlvbmFsIHdpbGwgbm90IGJlIGFsd2F5cyB0
cnVlLiBUaGF0IAp3YXMgdGhlIHJlYXNvbiB3aHkgSSBtYWRlIHBhdGNoIDUgYW5kIDYgaW4gYSBz
aW5nbGUgY29tbWl0LCBhcyB0aGlzIApjb25kaXRpb25hbCB3aWxsIG9ubHkgYmUgbmVlZGVkIHVu
dGlsIGZlYXR1cmUgcHJvdmlzaW9uaW5nIGlzIHN1cHBvcnRlZC4gCkJhc2ljYWxseSBwYXRjaCA1
IGFuZCA2IGFyZSBsb2dpY2FsbHkgY29ubmVjdGVkIGFuZCB0ZWNobmljYWxseSBzaG91bGQgCmJl
IHNlcGFyYXRlZCBvdXQuIEknbSBub3cgcHV6emxlZCwgd2hhdCB3YXMgeW91ciB0aG91Z2h0IHRo
ZW4gdGhlIGNoYW5nZSAKaW4gcGF0Y2ggNSBzaG91bGRuJ3QgYmUgcGFydCBvZiBwYXRjaCA2PwoK
PiBXZSBhcmUgbm90IGRvbmUgd2l0aCBmZWF0dXJlIG5lZ290aWF0aW9uIGF0IHRoaXMgc3RhZ2Ug
c28geW91CidZb3UnIGFyZSB3aG8/IGRldmljZSwgZHJpdmVyIG9yIGd1ZXN0IHVzZXI/Cgo+IG1h
eSBzdGlsbCBzZXQgYSB2YWx1ZSB0byBkZXZpY2UgbXR1IGlmIE1UVSB3b24ndCBiZSBuZWdvdGlh
dGVkIAo+IGV2ZW50dWFsbHkuIEJ1dCB0aGF0IGlzIG5vdCBhIHByb2JsZW0gYmVjYXVzZSB0aGUg
c3BlYyBzYXlzOgo+Cj4gwqBWSVJUSU9fTkVUX0ZfTVRVKDMpIERldmljZSBtYXhpbXVtIE1UVSBy
ZXBvcnRpbmcgaXMgc3VwcG9ydGVkLiBJZiAKPiBvZmZlcmVkIGJ5IHRoZSBkZXZpY2UsIGRldmlj
ZQo+IGFkdmlzZXMgZHJpdmVyIGFib3V0IHRoZSB2YWx1ZSBvZiBpdHMgbWF4aW11bSBNVFUuIElm
IG5lZ290aWF0ZWQsIHRoZSAKPiBkcml2ZXIgdXNlcyBtdHUgYXMgdGhlIG1heGltdW0KPgo+IE1U
VSB2YWx1ZS4KPgo+IFNvIHRoZSBkcml2ZXIgd2lsbCB1c2Ugd2hhdGV2ZXIgdmFsdWUgaXMgdGhl
cmUgb25seSBpZiBuZWdvdGlhdGVkLgpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgJ3ZkcGEgZGV2
IGNvbmZpZycgbm93IGRpc3BsYXlzIHVzZXIgcHJvdmlzaW9uZWQgCmNvbmZpZywgb3IgZGVmYXVs
dCBjb25maWcgdmFsdWUgYWR2ZXJ0aXNlZCBieSB0aGUgZGV2aWNlLCByYXRoZXIgdGhhbiAKd2hh
dCBjb25maWcgZHJpdmVyIHdpbGwgYWN0dWFsbHkgdXNlLgoKPgo+PiArwqDCoMKgwqDCoMKgwqAg
ZXJyID0gcXVlcnlfbXR1KG1kZXYsICZtdHUpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGVycikK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfYWxsb2M7Cj4+IMKgIC3CoMKgwqAg
bmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBtdHUpOwo+PiArwqDC
oMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBt
dHUpOwo+PiArwqDCoMKgIH0KPj4gwqAgLcKgwqDCoCBpZiAoZ2V0X2xpbmtfc3RhdGUobXZkZXYp
KQo+PiAtwqDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZk
cGExNihtdmRldiwgCj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gLcKgwqDCoCBlbHNlCj4+
IC3CoMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzICY9IGNwdV90b19tbHg1dmRwYTE2
KG12ZGV2LCAKPj4gflZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gK8KgwqDCoCBpZiAobmRldi0+
bXZkZXYubWx4X2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfU1RBVFVTKSkgewo+PiAr
wqDCoMKgwqDCoMKgwqAgaWYgKGdldF9saW5rX3N0YXRlKG12ZGV2KSkKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRl
diwgCj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyAmPSBjcHVfdG9fbWx4
NXZkcGExNihtdmRldiwgCj4+IH5WSVJUSU9fTkVUX1NfTElOS19VUCk7Cj4+ICvCoMKgwqAgfQo+
IFNhbWUgdGhpbmcgaGVyZS4gRmVhdHVyZSBuZWdvdGlhdGlvbiBpcyBub3QgY29tcGxldGUgeWV0
IGFuZCBpZgo+Cj4gVklSVElPX05FVF9GX1NUQVRVUyBlbmRzIHVwIG5vdCBiZWluZyBuZWdvdGlh
dGVkLCB0aGUgZHJpdmVyIHdpbGwgCj4gaWdub3JlIHRoaXMgdmFsdWUuClNlZSBhYm92ZS4gV2l0
aCBmZWF0dXJlIHByb3Zpc2lvbmluZywgd2hldGhlciB0aGUgVklSVElPX05FVF9GX1NUQVRVUyAK
ZmVhdHVyZSBpcyBhZHZlcnRpc2VkIGJ5IGRldmljZSBpcyBzdWJqZWN0IHRvIHRoZSBkZXZpY2Vf
ZmVhdHVyZXMgdmFsdWUgCnByb3Zpc2lvbmVkIGJ5IHRoZSBob3N0IGFkbWluIHVzZXJzLgoKLVNp
d2VpCgo+Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKGFkZF9jb25maWctPm1hc2sgJiAoMSA8PCBWRFBB
X0FUVFJfREVWX05FVF9DRkdfTUFDQUREUikpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNw
eShuZGV2LT5jb25maWcubWFjLCBhZGRfY29uZmlnLT5uZXQubWFjLCBFVEhfQUxFTik7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
