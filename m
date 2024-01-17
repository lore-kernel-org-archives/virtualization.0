Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEA25573
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jan 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523513; cv=fail; b=db3tTkvX1ioxYVufR1hmNrAJlTmP+j2cyrKyhq+h4UAQKGG4Ga0ReHkyoG7CL23VA+U1B0Q5bIZJWJPKJAb0wEUH0w22qtqJynngly1G10SinmR+CEGS2piTh7qOOLTuCJFWp88ROQ1s92BJTx6L/OkHa405Tq5YJfr9PTJ81pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523513; c=relaxed/simple;
	bh=zXtCwN1qJhKtrChi/YmCj2j9EBhtWQVc6xqNKrye+F8=;
	h=Received:DKIM-Filter:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spam-Status:Received:Received:DKIM-Filter:Received:
	 DKIM-Signature:Received:Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=urIfcvSJIalHxZQpdyQ7bhMIWKPQ4OLAZhCztqYCRxMHUwcx0PZklI9bElTLvbp4Z9ybk8edwdslePY4HoDJqAMuEgI843i0ujoBsYsbGpue8FhayQM9U7oY0GfswVRsfH+9lx0TH19FY/RmxORRnzrHAfHlwU5EOvJFS3IrJbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CQlyyJ9e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ta50+T3z; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CQlyyJ9e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ta50+T3z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D94583E66
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jan 2024 20:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D94583E66
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=CQlyyJ9e;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ta50+T3z
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1VEy9s0wqr3
	for <virtualization@lists.linux-foundation.org>;
	Wed, 17 Jan 2024 20:31:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9264583E65
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jan 2024 20:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9264583E65
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcnM2021406;
	Wed, 17 Jan 2024 20:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zCxQmWY8kDghf5vUA0giKBaqEo4kFDOo0MW03UqPd/M=;
 b=CQlyyJ9eyJAo0TE/rUexrxxhurMwuc71DZHTRGItDzXcl+rA7UllCFYBE+jbccVaGGFp
 oPwZSZ/hcmQHIiAYkJ32xLPusHKEe+5cM4x2SvUbwwcLjwfrq6IJuw2kIDx7ISV7wf+n
 6e1nYXhJVvKgxvc5wXI99xotBBjMAykwAogMdsUz2JZa95o64neX2aaWYHXlyT8iDM8z
 2J+NMV7wwxK157a85NLA1uivo8VmfCb0iUh2+LCNv63CPwZ1KrUAWHXpCzdUlgf7LmgI
 ES8DO32pmTumoPRjHGBb+RFayydQnjDaz2YUGILIaZA7395A4iVgtzN/RhzMgUM3C6qv Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjegxwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJdBC9005109;
	Wed, 17 Jan 2024 20:31:40 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyh3fmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 20:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjDhAPwqzSDQQ34T2DxZMUZz7g+7YPXOGe6K4VgAfkfLFixyk9OKbE/Ld9o1YQsTZm1ZI6pIiBZ6vrv0uB5D7geBRXzxfHkPj2amloqR9DmcDbu9fRELbcB7Y5OBK2oXyv+bfeJNWqltRjNsGH0mDFY2WLpTop49abtKfRpMAcIpdLSvkiiwefdGWXYWbbhsU3bLiZigIqZRw+YJfRGK72lqUaIyff3M5pGeMLDQjtEpSzf3NRzi/qHQw/PoJ/NwE7sstG2CLnBYQHpKRlhVVAlEoW6Xl/Qk83TdpLZ8tfG0SXwbZtSprbEHls1ckpICygZSdoqXYyE2ouolut+eTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCxQmWY8kDghf5vUA0giKBaqEo4kFDOo0MW03UqPd/M=;
 b=IPO6Dm1d0UXJk+EGCfu7sS1DV/YTJz2RzbTgCwJtfNxl0DFntEpB/JFrxtTiNiI8Q5oCzT88rErKt0d6XFdx8Vx5i/Hiv80kWchbbniiWSfoz2l1M8dsy0L7PH084obA3KjFirAPrQ070iq2pNPGu4uelfp0ujHOA0RPIjBvz7uavacqE1tybl1utv8u4SbXwYTgyPlsCOlLskv1v6frktGv7WpK8Tiyam0YlfnW5tp+EOT7nHFcrlG9VXf1zkB9B5dYwc1JXicfbY6Uk4plWTSldNA62hlUpj+WyyXB3kKJ9mrD3fyPHQ5DdlAKEOURoyxNsdDyKFYzfgDt6dUyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCxQmWY8kDghf5vUA0giKBaqEo4kFDOo0MW03UqPd/M=;
 b=ta50+T3zsoaYEvHKa/YTwj5P8lawyS1WPKZsYA15EpeOHtJQVzOMO62Ignb3WwLDvmVjH6VqoDgBf+xhYjBgJFTP/KyAt3LcQJJSwB38VC4mrTU8JsPbCw6ngtW0BYQN+5trHztCNtA4LT9HCRd01q7aeh7KUt9mhWhc77KX+/A=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 20:31:38 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 20:31:38 +0000
Message-ID: <aea1681c-e04d-4678-b161-6dbd2b13b82e@oracle.com>
Date: Wed, 17 Jan 2024 15:31:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/13] vdpa live update
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea
 <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuFTRBYU+z3ZSWzMMv2650PQ=kduGxcGXaf0T5222Bh4g@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuFTRBYU+z3ZSWzMMv2650PQ=kduGxcGXaf0T5222Bh4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9e63cd-8e1a-41ec-67dc-08dc179b4e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lN+dAd6EM4p16dfUzU3Uey1pS1rBiX6JgFJor6eVDwLMAKf32pthJMlKEKsGg5ooIULgwotkDINApg1O+xDhrwAcrqJ1AqsgqXhvyP3dHS8xKHatUgvwAjrVUoTEYljOqpHdUCHPzwP78IrJHIdlsGH0edgUoPR/uLR1PAULWFfa1CMyNkCAXf5QNoAXDPyzo04UzKZsrvbQi5LWrcsGsTNgLOEfHf/BCpsDGJjIpir6eiMVEDIRW9qyEn5s2ypGI2m276puMaesgK83JpIchKEY/3TLjz45oCtnpm2cQm81f2gSYOlG87AWbZUf/Bj52R4iKluYIsbmwrdNh1juB8BJNk/RZEgTjDEvLELcwOi8SLVTMmmdoNCtO1Y8AdmYqyiteOMZ454n+s1JK5G382CKsBvYBrzTywFcOq/h68mPm1ObgpV09DAoOPnbuDIXI0nckj2GZ/vIxbaveEd+Jb57e0Y69QW/Gt7jSg7xLmVLdmEMx1Mvo6GhJpz91UBcH6N/8KEwGNlhloz+ORRtiqjDKWHkqQyp6agkAmA/OhE8TBNbp3Gx6fQJaGUwrcUfT/8+vOFDOSbvKwAOzXepA8JBwroYlnf0/oLe7wSiqw0tz5mHazkJ2nU3WVkzIdTW+0ywbnMDxyo1W8RL1Y85yQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(8936002)(4326008)(31696002)(5660300002)(15650500001)(8676002)(316002)(6916009)(86362001)(6486002)(66946007)(66476007)(66556008)(36756003)(478600001)(26005)(53546011)(6512007)(54906003)(2906002)(36916002)(2616005)(6506007)(83380400001)(38100700002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnJKT09XQmhBYkF0ZkpraXA0YTVqbW9NU3BOMEdJaXMyS0xiU2VTUWdheHRL?=
 =?utf-8?B?eVRuUkZpam9ZQXFPSUhjalNXQlZqRmZSY2pVL2xzZTNFbzBadlN6eUtUZEsw?=
 =?utf-8?B?SXp0TXBkYmFEUjY1UnU4aFNENVJYL2piUUpzWThqVnJvRjFzMXFVeVo0Sndi?=
 =?utf-8?B?N0I3dnlWeUZCSWJ6MldWRy9aS0UzRDMyNlU3dGgwK2prc0MvclladU1jZXF3?=
 =?utf-8?B?Tk81Wm5xT2pVMG0wbVdvUVlVWjNxMXVnLythMjFseUJXM0xySGF3aDBqdHgy?=
 =?utf-8?B?S3cyR2FIWVE0TDB4T0VGbGdsS1dSb29BTGxtbnBvOXZzNEVlVnNEVFNZY2lD?=
 =?utf-8?B?d3hmaEF2b1ZKRy9vdFpjbXJlRzZidW9qUFRFV3dibFdmcVJoa1p0NklKV05v?=
 =?utf-8?B?YnYrUWhyZUlpTHNucWplSDNxbVVwV3dnUUxtSThEbHRERElUUTZMNlB4QU1n?=
 =?utf-8?B?bUpySmVKRlY5cTdJQ3p0b2tud2wxdzd5OWZ5V3ZpQmovTUhSMitWSUxwMTlT?=
 =?utf-8?B?RHhXa0RVdTlTcGNCOHZlc2dTaUtvZWxuOVh1cGppT3JraGZiRnVBcU1WcDcv?=
 =?utf-8?B?T2hEeGMzd1VMUkNqclYvVzRhRDU0alA0M3llMDdnbWVMaElQZEJGbFVvbkxY?=
 =?utf-8?B?aDlqZ0VDNlJrY2YzbTFEQVVaUUFLQVA4ajQvOWlkRXp0WWJKSXdNamNGSXlB?=
 =?utf-8?B?S3QwZjFVYTM4cVp3WnRWdU01Qk9lN280REUxV1lvMUZNZWtHZUpQYlpPU0NK?=
 =?utf-8?B?c09tTW8wSEpmY3prVVVLcHF5d0t1UXNyakhzbjdOb01PbEdvOTl5MU9zSkQw?=
 =?utf-8?B?V3hsVzZTdzJRNElvUWUyQkk0M1ZhL1JVWW5EVzFnK0dFcDFKNDFIRGM4L1NJ?=
 =?utf-8?B?amJuSHM2R1VmRzFyR1hGYTdxNWtRUmtJR0l5bllZSFFtais3ZGwzdlNqUGhX?=
 =?utf-8?B?cTVMVlNWOXNXVnZEc0RtdFQ0bXpDTlg2L2NuT3RTOEQ3ZVZMck9nZGZJQkQ4?=
 =?utf-8?B?MDNwV1FJMkdONit0WEJ2SlFyYmNCSjlWMWF5YlFQMjhWUS9BenUzZHJVVEQ2?=
 =?utf-8?B?WTFTdDFxVFBuak5aY2duSkxWbXp6WFM5Mk9ISXUxaFM0dHdRZFJ2OHdCU2pl?=
 =?utf-8?B?dXBUSnV2ZzZ6VENpWDdVWnE1aWRqTVZCcG1QZ0o3RldoZGxTaXZManNNSE5y?=
 =?utf-8?B?d095OGo0a3hRUG9WYXZwWjNnd2VEOUp5VnYvVWw5K3ZXWThOZ25SSTFIamJy?=
 =?utf-8?B?MzAwaEdzSExoU1BzQTZrRU96ODRCeFB3WWhqeXY5dnMzTVBHRjVoS1NkYTZE?=
 =?utf-8?B?bStzdjk3R1V4Q25pT1dVdUhtaDhBWG8reS80WFJ4RW5KeFhXaG04NklXRmtC?=
 =?utf-8?B?cW84Qnhzb0pybkJDUncxYW16YTlzNVNIVU1PTCt0R0ZRV2ExbkJ6TW9iZmxz?=
 =?utf-8?B?dmZlazJPVmpyTjVKcDc0ZStycXlSaDF2UkE5T3VUNFkrV0dRVVY5czZ0VzBI?=
 =?utf-8?B?Z2FIMzRneHFSMG9hWDUxUjZuTFJvUUVPUHM1WjNZSTlkV2hEVVBIQS9acEZo?=
 =?utf-8?B?Znc0SXR5NU1NZTZhQmZ3ZWRCYTZQeVVVcE5kZ0hSVzRnb2dYTGJ4YVJwUExY?=
 =?utf-8?B?UlM0RlpESUJNYTh6VXVSTWFGdGgzMmpPeFRYOGRqUDZuR1VhbWJ5Zmg2SnNx?=
 =?utf-8?B?VkNqUUNNVDYvblpNc01DWUcxa3YzTzVJNWhVRU5ndXNjajZQUjJuYjdlVThN?=
 =?utf-8?B?WHA1VFlydmRJMGZaQVpVcTdNS3VkZkZhcldUcWNqQUxBRU9mL090K1RaKy8r?=
 =?utf-8?B?cUxqdkI2eG44Z21JUmlxbVpvZVVPeGphaGgySDMzUENIdGpENkFIeVZiY1J5?=
 =?utf-8?B?cFpoNmFpSDFoenRscWprV0ZiUUZIYTA5WGQ2R0s5NTlpSlNpaTkxMFErMndn?=
 =?utf-8?B?ckNBc09qWmhVQVZFQzJEU3p5U1BVK3M0S2IrYzVZcXdoQTFONkEzajIvUjZx?=
 =?utf-8?B?NHEzOEo1SVpESWlYN0lraStMY3NlSnduTzJBZ0cwZFQwQnRKcnNMb1ZXVE5i?=
 =?utf-8?B?UGpjU0t1ZkJOVHF2ZTlCTGpoWEp2MXBuYk9KMkhaSi9XM3ZpZjNJSzVpMEdl?=
 =?utf-8?B?M0YvNGZvbDE3MXVnZ1lET3UrQUVGbEE0Vm1ydmdqYy9TaWQ0NkM1NDdOdWZO?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UkMDgqvZK6C6zAlTCbvBH2ultJrV6VEG4JILAOyCF0JLwpa0cVAqUNfRpvrMyLzmX5ZUWl61uoE6Yj1mgu+vVQaWJNk2OCEQSgtEc0FGAyOVH1abDgLM6N5HTklV3uI2pzY+sDPHpAkS/GijiDOpSaF0xBhMA9GzjQfFAd1tkM8NGnHYR8QyzPaNCgIsKfvBI+5q6vzrFId0HxkBstlGn+VHZ8XDWZ5oAYfsLnxLHzEOKijkLOlbblyytGOwcMkhzDHQa6OufJbE38lnBp105rL8bQ5a4SHoq8IZ1N3vlQGga4HHr5eQrllvXIiYE7gxgDzYjdIq1zB9iHNM1XHlz4Br9p960xfosaJI5FImpGDCsGt0SVW0kZcVby7Vd7TcBEEodpSSlfMVegz28Jnl9fifXnlgvIEwHZsWadEISmh4H0gmYya+FnO9EQWxFHl8gQSj/H0ZNCplnGzRcgYLLA3Rnir1dgoQ5FINAb8eJgNFnTlxF40YyVYkFIZJsldrUB++ppASADIrocn+QTalv/fNZx2iEtylE6UNLTM9kLpyG3MKT/NBqqZbUX21W8eMl3eqAHN9NbT1R6RpRZlGBWO5RPtekij8F2sA0aOz47Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9e63cd-8e1a-41ec-67dc-08dc179b4e9f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 20:31:38.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCQQhn9GmZ+FBCXtR8o5/NscMx4FED+ourJP1463QVOdxLj7FhzOt2L4mDwesCjLYl1cnOAMPgCswRMe3Ws27hlBjXzPypSn7jRTDc2ySZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170150
X-Proofpoint-ORIG-GUID: CvoQpOU2Y3gHV1diVh6ewQDnPubACy_7
X-Proofpoint-GUID: CvoQpOU2Y3gHV1diVh6ewQDnPubACy_7

On 1/10/2024 9:55 PM, Jason Wang wrote:
> On Thu, Jan 11, 2024 at 4:40 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Live update is a technique wherein an application saves its state, exec's
>> to an updated version of itself, and restores its state.  Clients of the
>> application experience a brief suspension of service, on the order of
>> 100's of milliseconds, but are otherwise unaffected.
>>
>> Define and implement interfaces that allow vdpa devices to be preserved
>> across fork or exec, to support live update for applications such as qemu.
>> The device must be suspended during the update, but its dma mappings are
>> preserved, so the suspension is brief.
>>
>> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
>> accounting from one process to another.
>>
>> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
>> VHOST_NEW_OWNER is supported.
>>
>> The VHOST_IOTLB_REMAP message type updates a dma mapping with its userland
>> address in the new process.
>>
>> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
>> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
>> require it, because the userland address of each dma mapping is discarded
>> after being translated to a physical address.
>>
>> Here is a pseudo-code sequence for performing live update, based on
>> suspend + reset because resume is not yet available.  The vdpa device
>> descriptor, fd, remains open across the exec.
>>
>>   ioctl(fd, VHOST_VDPA_SUSPEND)
>>   ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
>>   exec
> 
> Is there a userspace implementation as a reference?

I have working patches for qemu that use these ioctl's, but they depend on other 
qemu cpr patches that are a work in progress, and not posted yet.  I'm working on
that.

>>   ioctl(fd, VHOST_NEW_OWNER)
>>
>>   issue ioctls to re-create vrings
>>
>>   if VHOST_BACKEND_F_IOTLB_REMAP
>>       foreach dma mapping
>>           write(fd, {VHOST_IOTLB_REMAP, new_addr})
> 
> I think I need to understand the advantages of this approach. For
> example, why it is better than
> 
> ioctl(VHOST_RESET_OWNER)
> exec
> 
> ioctl(VHOST_SET_OWNER)
> 
> for each dma mapping
>      ioctl(VHOST_IOTLB_UPDATE)

That is slower.  VHOST_RESET_OWNER unbinds physical pages, and VHOST_IOTLB_UPDATE
rebinds them.  It costs multiple seconds for large memories, and is incurred during the
virtual machine's pause time during live update.  For comparison, the total pause time
for live update with vfio interfaces is ~100 millis.

However, the interaction with userland is so similar that the same code paths can be used.
In my qemu prototype, after cpr exec's new qemu:
  - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWNER
  - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of VHOST_IOTLB_UPDATE

- Steve

