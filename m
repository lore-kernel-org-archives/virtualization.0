Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D9BC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 02:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B4816FC41;
	Fri,  7 Jan 2022 02:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ypnXrodrkzFy; Fri,  7 Jan 2022 02:12:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 530B66FC3C;
	Fri,  7 Jan 2022 02:12:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24B9FC002F;
	Fri,  7 Jan 2022 02:12:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7094EC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48B944040D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="a8m+GSPp";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="c/Zq/RTL"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNX3T06RSqvx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 765E1400E5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:12:18 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206KdrmL016699; 
 Fri, 7 Jan 2022 02:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LtJgbowX2YMJE0BCHrnxP36ke6wqwDHXnTPWNYybmeE=;
 b=a8m+GSPpjZK38VC4C/Ka8sgMjncchKccKcXgi24AaJI8KHOiYUWANiR/KjKP8+A3RKKu
 K2SXTLN0drDkRBJeMDXqoJvVD9tRtwlyog8mCjm7VxjwF+3qm1oEnysvAdsbi7HlnTXC
 vXVVfgWjS2/m2xpPm6a46TiojZahQnIooSz8LfILK+aKbStNDkzvwD6J8cS/1bviXRgS
 +vISB0lvNavlWQPOZUZkO2DQW4gFl/o+S8k59t6isSgV+vwfeLXSvngii0mNjH8dwevH
 SOqZhvBffQxTbrqSPsoAFXKCkxhycvTbnoZoSbw7Q0s3jL8RDJwWng+H9O4mY3XNPoHZ Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4v88xy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 02:12:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2072Bjt4119664;
 Fri, 7 Jan 2022 02:12:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by aserp3020.oracle.com with ESMTP id 3de4vvmxjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 02:12:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSY69K1YeFnXwA606h5GLhMn41XGRiOH6V6ZZyATiWY4z8HB6NE0uYXn2p3qkE5OqEXWz1BJvH9awLWrHTnGGM2fFwi+nH0bESMTtprpxmQ6CiTVgakWxc7D9p2JTgKWtBf2VQvRtw2TGX0w8kcy0inB0MWP2lLrZ4vtJpoEXx64ElI2a2aFfZuMro3+7JgrPYFxlCN06r8IQweB5g37zAatAzLzi1VCy+NKHZLdWbnOWHsClUzmHNZ+UcCwluQHLwuTVHIOiwb+yjjwmJyDKkG1MnNQRAxnJERAI6KUT1oGlEa3yvwYxzdr09sx3jBIP833xYzNF0A7eIAUmtg9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtJgbowX2YMJE0BCHrnxP36ke6wqwDHXnTPWNYybmeE=;
 b=ANQc7EPqvaqLwBqjXuVYwrDUC/pLPj/65fCNZyKLzwVLGGI0mec2HOBFFuW3s0XAfKN/Mxc7ZN3RtZm4DGL78vkUQr6871TymygmDP7RO8N71nnBx91gBr04orAohtsxq7SvJguP1PC9VHeDBuQ5w9jULWSgpd+vUv6qn4la2cdEHYcvt4s/xI2bRNJQbLbVwEAdodBJhW8vf9jXmO3ujQSKyLt/f24YU+ze3oTPvYK3VXsWqLS0aCyMI3fxI9TQtZ81z4VIpdzDqQiEyq1H4zpwdoeXdCeOmddHb0Erq+BcQqCTEgfaoVIOVC3FeXKdvFs8IgYR4+iemih9n0Qzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtJgbowX2YMJE0BCHrnxP36ke6wqwDHXnTPWNYybmeE=;
 b=c/Zq/RTLPsZC9W/Iy7ssjy6oYgCVMDJ6lUXtSomVkAwLhGQd5fsXaqUP14btwWpzN+0fJk5aEIs03etPt3zGWpupup4QxvWetAbzsHWhN6D5hNMeqQN4fxleztfAloEt5uPvPEaNBkOx/kwWPxV7nDLys4lkGaeCy7/cy5wSMsE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5440.namprd10.prod.outlook.com (2603:10b6:a03:3bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 02:12:13 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 02:12:13 +0000
Message-ID: <308df335-aff8-07f3-618c-4b964f3cbc14@oracle.com>
Date: Thu, 6 Jan 2022 18:12:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 10/14] vdpa: Support reporting max device capabilities
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-11-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220105114646.577224-11-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:806:121::18) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40d12594-b930-4669-e6db-08d9d1831ea1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5440:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5440DC353D0164DC5BC28517B14D9@SJ0PR10MB5440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nODI+/XfOn+5Oqf6+XoXaxSXE1TkgqPnauK6A2BDFjU9sfv2Eaz5INhV17SyjP1493z8v124sAieDmWO3tobO7Me7/uCo8HSC57wRgtxrlLqpFAYPD5RSVO/sJX8bclLIn+H9jpdzfK+SpLoI83n2CyhUb9CF6OhzimMuEgdEz+4Bi02Ntu6/rw18wfd3B541ps2y1MVeSR+dxAPO0FvHGmZhbfjgLQVKH3WsJG2PeFJbwyGpPqB3rOxughrtgOwP3s6TKNwsYWkgkfzyl5T+E3uxzDqT4xvLXqj7YGLGN87gsY7Z1jlQdAjF/UJr8eEVb3dadJzzJZ8l/k2McGvXgarpEuSQjl21OiHYTGBjgHEuQc4zvyHGke9sPrZz+su65a20kh4pG8PBRtVwcK7ymay/QTTtzoPjt1PQWw6Wgv7kWH+yCF1JCAKho9I1jAJ/KFhiL7J3opX4RhJ7NoBhrZIwJ20WAi5frqTttOyuupPxGVmqan3KsKcYWQA3yMtTUNnBIh2VB8SY55MqanEFraCmMQHt064llkDNfg5zzgbVDRZp/WsDCZ9OQjynv/TZiE+k4ZIsWAXBUkLoXYDWiyzNlLYDWjtSwlORoGVZqH30fxjWfGsg1mBEPC6MDQTrP6Z+KxGXYJpYTuEgpCz+Xrcp8H1SeWcF0HRv2iwp1SG7oR+9r1tqHFtWsjN41asEzLdmA9KT8ROQC5psjD1VYh9zgjVBQrTKEby39QYfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(66476007)(2906002)(66946007)(2616005)(31696002)(26005)(508600001)(8936002)(53546011)(36756003)(86362001)(6512007)(31686004)(186003)(8676002)(36916002)(6666004)(38100700002)(6506007)(4326008)(316002)(83380400001)(6486002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkNsT2VZbGdOY3I5YjlFRDVVY3dhYjNLNHJINlN0andmRC9rMVZqUHM2OC9j?=
 =?utf-8?B?UTFhc0xUeExHRnlaaHVzdUtnQVBVYXE0QzhzYjNSUXZVeDVmY251NE53cVhC?=
 =?utf-8?B?YzdGSXd0WTBGc3BrYk5kVnIzOURKL051RlJsL1dsaUQrcitQTVN3SlpGcitx?=
 =?utf-8?B?RE1vU3k1VHFxdllGUWRuclQ1S3RyZlNxWUltTm1zWGFqdSt6THMxbFo1Tkpu?=
 =?utf-8?B?ZnlYbm1WSTdpYWdsaUc1VkJ4MC9VV0VQMDVUVC8xQ00wc3lNVkZBd0U4K1dR?=
 =?utf-8?B?am94NThxeG5yT3NJdkZRcFNvWGZVOWN2d0RScjkrK1hibllqNDR2a0xaQkZR?=
 =?utf-8?B?S2drR3JkZ0ZLclBGSXJseVZnVmxOTFdDNVFUNkwvYzBMWlVxbGU3OWVWVWRW?=
 =?utf-8?B?L0E4SHN4c3dpMmZkZEF1OUVFbHpvWEJSaS9md29KaDAyRWQrbHlzM2VmRk1J?=
 =?utf-8?B?amZnbThCenJoY1VkTktrNmJRK2liMVZERXlmUnE0RUl0MU0vd1NLWGtFejI5?=
 =?utf-8?B?Y1VZRjA0THNEMUxBK0wvVUtUbkFhdzByR0IvdFpEMS9KWHU1UE1QQVhUNkh2?=
 =?utf-8?B?N1VFZHREeDJhOEpTWDhzQlR4ak1YYjdNblRaOWR5ODFrTlNwbmJGRThCUFNE?=
 =?utf-8?B?T2RuWWszemZnaEYzRVRYQWxJeTlYbGRmVEZneWtkU0tsSVRlVCs4UXBVN3N2?=
 =?utf-8?B?bWlQWks0eXl1dmptaEVKU3JkMFlPQjRkd3U4STQ0b1pBYU9kRUhSbTJxb1hT?=
 =?utf-8?B?UUR5Y0hDcHBmZFIvVDdEcmI4a3lhSVQreXBGQ0srK2c5a2dEWW12V1pPVkdS?=
 =?utf-8?B?a1VoWVNMR3FGaWJmMFdRMlZlNVkrSEdzRVlHeHZBKzdVaG1yc290RmhpSlNw?=
 =?utf-8?B?RVlBNjgvMGRCYklqYzNNNUdNeGtnTzZWQkZXZkJCRXIvWHVSYTF1RGl1SFND?=
 =?utf-8?B?YTdzdm5PQTNYRE1yL2dTZmc4ZWZSdklDdFlHR2RNU2JLa2ZaS0FKcHJVc21B?=
 =?utf-8?B?elFEVFNlcE1DaUs1MFpoaHlZd0VDVG1hLzkxUEwzN2I1K2ZRUXllTWZ0WERm?=
 =?utf-8?B?bDFEbHRaMG5QRWtKTUxqVzVUQ0VvVU5OYjNwK0xCUEkvZzE1NVg1UFloRVpN?=
 =?utf-8?B?Y2I3L2Z1aFBnRktXcll5Y3VBVlhOMjl6eE9UTEhUWUpYdzQ5S0ExQ0g3YzZZ?=
 =?utf-8?B?Uk1kR0k1YmhQRzNZME9wbVNLdmljaDA3STFlWG5vWW1ISWZzMkVxZjJtMWRS?=
 =?utf-8?B?VHJuc2JwME01Ym5ycGp5L2puMWdJNmhQVVFoSUxlMVR2MnRqZVBvV1NZLy9t?=
 =?utf-8?B?bFNyRFhlTTdHV3JuN1BZajFmOVZlLzI3WjV5dnp0NVJlZm5KZnBNYTV4SFoz?=
 =?utf-8?B?bHNyQkNUczJ5RUp1dTFRc2xUVTJSR29Zc1g5djd2WnUrcjFEYTY2aytuWitH?=
 =?utf-8?B?R0lpOG1wYXJvRldsWVkrY1FndnREWFpxVlFxQ1ZoZ1BGa3VrR1BYMmdjWHA0?=
 =?utf-8?B?bjBXNFJ5d0RPL1gxWVBvaXJtckZ4REdJdzlNblkwUW5oRk8wSW5oMHBnV2NO?=
 =?utf-8?B?Z2ZuNEltSUVXTkNkdnZGN2lTWk40QzhRNnVENU1MQ0h6MW1aRElWc2Zxd2I3?=
 =?utf-8?B?NE9iMy9RUzE5WkN4TnRtMzBxeGNmenpaTTdnZ0lkazdOYVRsY0d0dVlVZEZa?=
 =?utf-8?B?RE1uaCtsbjVoMmxlRzFlN25MMm5UN2xkbDluTkRDdWVqcWlGWlNuTUxQYjNO?=
 =?utf-8?B?WTR4U2x6emJLb1RqUnEvNGdqSWlHWUpBeHRmVEwxUTU0SFdoYU9YLzh6dFRG?=
 =?utf-8?B?M0ozV0NIaXJiUDFwUU5tSWNNcTJyTUZIVzEvMXA5Tzh6SGZ3MHJWVS9BNEdD?=
 =?utf-8?B?QnJxZ05mRlBCSTQwbjlITW05STQxeUI3N1VGUjVydVpyaW0yUlUyeUhYdVIy?=
 =?utf-8?B?K1c0UW5LQlJsUmpIQSsxd1NKVzVqOUtTMjVhQkxCTDJ6Z2t2K1VNK3NNN1Nh?=
 =?utf-8?B?UnFSWmJBZDk2U1NWaVJsNS9MMnhUVDZ3NTNOSFhEUFFITlNBUjgzNFVVOC9O?=
 =?utf-8?B?K29MWHhtaXhJdW1PUGQ1aThKK1d6R3grb1RsWTE0T2hESUFnbDdLY2FlOTJs?=
 =?utf-8?B?M3M1ZzJzb3ZBclI5UURObVBVR29MQVVuSUZTNjI0dTFiMTlpZmE5MEZXWjNE?=
 =?utf-8?Q?mfLNHTj8yMo4wMzkt7RxMv4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d12594-b930-4669-e6db-08d9d1831ea1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 02:12:13.6202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA9bnE4zRUku/eAnnV6d7zT6GrwznUr+f8O/pRJlpL/MYG3xVcTNqOi/qvX+aSRyzW/biGhBaL2/ph3kTBluHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070013
X-Proofpoint-ORIG-GUID: yEqD4o_6x2lxJJHIX9nbzkjfWqyhFZTV
X-Proofpoint-GUID: yEqD4o_6x2lxJJHIX9nbzkjfWqyhFZTV
Cc: lvivier@redhat.com, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 1/5/2022 3:46 AM, Eli Cohen wrote:
> Add max_supported_vqs and supported_features fields to struct
> vdpa_mgmt_dev. Upstream drivers need to feel these values according to
> the device capabilities.
>
> These values are reported back in a netlink message when showing management
> devices.
>
> Examples:
>
> $ auxiliary/mlx5_core.sf.1:
Missing the exact 'vdpa mgmtdev show ...' command, otherwise:

Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
>    supported_classes net
>    max_supported_vqs 257
>    dev_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
>                 CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> $ vdpa -j mgmtdev show
> {"mgmtdev":{"auxiliary/mlx5_core.sf.1":{"supported_classes":["net"], \
>    "max_supported_vqs":257,"dev_features":["CSUM","GUEST_CSUM","MTU", \
>    "HOST_TSO4","HOST_TSO6","STATUS","CTRL_VQ","MQ","CTRL_MAC_ADDR", \
>    "VERSION_1","ACCESS_PLATFORM"]}}}
>
> $ vdpa -jp mgmtdev show
> {
>      "mgmtdev": {
>          "auxiliary/mlx5_core.sf.1": {
>              "supported_classes": [ "net" ],
>              "max_supported_vqs": 257,
>              "dev_features": ["CSUM","GUEST_CSUM","MTU","HOST_TSO4", \
>                               "HOST_TSO6","STATUS","CTRL_VQ","MQ", \
>                               "CTRL_MAC_ADDR","VERSION_1","ACCESS_PLATFORM"]
>          }
>      }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v6 -> v7:
> 1. Fix comment
> 2. Fix error flow
> 3. Add device features
>
>   drivers/vdpa/vdpa.c       | 10 ++++++++++
>   include/linux/vdpa.h      |  2 ++
>   include/uapi/linux/vdpa.h |  2 ++
>   3 files changed, 14 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 60cf821175fa..34fa251db8cc 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -514,6 +514,16 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>   		err = -EMSGSIZE;
>   		goto msg_err;
>   	}
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
> +			mdev->max_supported_vqs)) {
> +		err = -EMSGSIZE;
> +		goto msg_err;
> +	}
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_SUPPORTED_FEATURES,
> +			      mdev->supported_features, VDPA_ATTR_PAD)) {
> +		err = -EMSGSIZE;
> +		goto msg_err;
> +	}
>   
>   	genlmsg_end(msg, hdr);
>   	return 0;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d4d7e4fe208..a6047fd6cf12 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -460,6 +460,8 @@ struct vdpa_mgmt_dev {
>   	const struct virtio_device_id *id_table;
>   	u64 config_attr_mask;
>   	struct list_head list;
> +	u64 supported_features;
> +	u32 max_supported_vqs;
>   };
>   
>   int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index db3738ef3beb..1061d8d2d09d 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -44,6 +44,8 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
>   
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> +	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
> +	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
