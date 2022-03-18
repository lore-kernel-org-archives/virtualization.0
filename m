Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0908C433EF
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 16:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C8EE84839;
	Fri, 18 Mar 2022 16:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByVsY2WbnmbA; Fri, 18 Mar 2022 16:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E94B84832;
	Fri, 18 Mar 2022 16:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1190FC001A;
	Fri, 18 Mar 2022 16:16:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AEF3C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 16:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2832460806
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 16:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ZQ3Kg1Lw";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="0RUlwWyM"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ec3qa7vHi9Tj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 16:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE203607F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 16:16:30 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22IGBwwF017022; 
 Fri, 18 Mar 2022 16:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=joecpeVXKLYU8yix5hhXM2Xp/U/fdnMDpP6UlX4kpj4=;
 b=ZQ3Kg1Lw9JX7t6rBsCIFZnwfb2TGdlEXuFKKXfyzbMPj/Uf8eHdeMTFH2SiVTDV3ixvf
 PZbkGITDA7wwqi/mtzZf7fcDZpWo2FpvunDINPINpsMvShNM9qDXUUMCwZbO9bNmg4vf
 hcmilpjl3MP+j6KQAyT/m3XPc0410hyLLR6wzTgqLy7bSdXc3rAMdHhxkISYvzMcOCEx
 CDRgeTIY6jPKiYu+jd1ePNlN+8kpzejMrzmYvuFPvgN0LBjfxfiAKFvTMrY3Ep+YL5b5
 quU331YwOU1hJdAyldmOPrhUAIGZudDvty2+19OOdn3ljSoXOtJ8S99YzekZ8VOR//ug Fg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwuxg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Mar 2022 16:16:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22IFp3sk020338;
 Fri, 18 Mar 2022 16:16:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by aserp3030.oracle.com with ESMTP id 3et64u46e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Mar 2022 16:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W59NbxKVtew+fOt8cCi7imyQ4hLpXJGraeXH0OrUjWYg2o3hbYN0JmrOzKsQSMwl981N79uaNIuRe5fZMdTktQLc/1n5qcG3MUJcHNeTLM+CBFYk7yJPDcOWIB6pJ0+LxEKWgiBgyu3dPMbrfqYna92vjCvLgKUV49Hi1G55Eo/GUcOKz8aGlPFF7hx/TI4et3ioHv6Y2P4hLSWm1ShXurQsnRIRlG6YF4kmBWqRmE8cnJBiq0cV0HCOIFJxzoHQcTtTbr80Eow3UVOLbtdjUB+UV/N0EFmqi1xc4EDfcA0R+0O2FF5w4Y69+xV8t3xBs000D8SkSyEV0T0t0pATEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joecpeVXKLYU8yix5hhXM2Xp/U/fdnMDpP6UlX4kpj4=;
 b=LXo5oQNMcLYcSCEL9FlGk0nXQM+ll8DbE1Vf1L3TNOG9Vn6qUGG1Tf1MnqxeHc10NRfnFeadUYWnnYEVZmZ3EtwXHijbhbl1DExpoNVZyG16MkP/Bzw5pfIpMGQM1019RdkqWKECoKofuZwJQoIfzVblJc342+GIZf4Jujns6B9bC0/E7KkIBhllQmlmT7aYkKpR4jxtV6Q48NTf7Eyu3xxz9d/0dP7S0U0FggvKfbj5rgh0Qe1+JTmxEZmxf5ywl40XzkART/Njf8u78A6Q5c6r+H2IHkkgcgYvZyZljEPhxpkCI7h+4pUdL4sGHh3w6lCPk65DquXFO4NC+Ueeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joecpeVXKLYU8yix5hhXM2Xp/U/fdnMDpP6UlX4kpj4=;
 b=0RUlwWyMHJiA2mNJqan2g9IcWS317VFwl1IEnhFOQgULkyYqtZSJlGXJYt+06pJUPFcDiRcYFtt0WvpAGRYCekLRe1iVSJ3fgGOc42lUuXUxM6MlDB8oeNlRapphEZAtFjw0kJnK4iypESelHTGrkJN0j9SYiy4oHG22W8lSX8w=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR10MB2009.namprd10.prod.outlook.com (2603:10b6:3:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 16:16:23 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 16:16:23 +0000
Message-ID: <5bffe53b-5653-07e4-607d-fa5313f2a6a6@oracle.com>
Date: Fri, 18 Mar 2022 09:16:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] vdpa: Update man page with added support to configure max
 vq pair
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, dsahern@kernel.org,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jasowang@redhat.com
References: <20220315131358.7210-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220315131358.7210-1-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ce88a6a-d99a-4365-1a38-08da08faa500
X-MS-TrafficTypeDiagnostic: DM5PR10MB2009:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB2009B909C7967BAC630C486CB1139@DM5PR10MB2009.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcBtK1ML+KK/xIFG8LTuWHV+e/qYI19VjeMipbqxRXb5BKzbvD1Z9gaUqOrUJ3aLKpwbpOBWVNZjjxip8yrsxP0b78ABIqIaK0ngC4PJzeMyjUonu3caHVmaXdrxjbKXjm2KvTLyTs6Jl7alZgzpNXRi3K/e/02nhM0ouo6qzfqBdv7JK9nJOHJlWxr3LnJIZhuoIGqpKCuem1X7Fj2FiEiVN2F3oWGlMmDxF9oHEwmgoxj5ymoZpiI6EAqPgdrkeoLv0TsQyVYUxxxZubNT8zl4yAc4JUHdFIji134NBBmaR6VW3ASH/koAx+VZzjqc8slG3inDK1+doAWJdM/sBCraiJhpgyK47gFFTs4y6LG2qBmTindkQFw03N5hzp3tl9fHOZojBxDwJZhaBDFU8dvf/lmStloIDWrFou3xpjkcLICdRllHKSPAGi4cFJJw4CkwJBFXUWn7cvucWxYo42vPKPmqFlfkrtddhZCANFEnFiM+ICOimfUrRylD6yEXG8Z88yvu/ERJVXGLC6SZUVSEqY413Z2AZpkr+hDW7SEG1sEROmhRk38B/qEeGKnlCwGD2oYQ+ZhS+6maOBHK1Nu+LnQXoS1wh1/RJCKhipWbMNMPuzWJvrtCXeHHkV7ohny9LpEqYSNbjJiqKL68Q6BwQdbJmdoIQ9yKHCW5DxqsMzImCJYQCwFO2hox5qPEeFq+UrDNQh1kcn+57N8jOdbnd5lLqPdau1qW//Iilx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2616005)(31686004)(8936002)(6506007)(26005)(186003)(6486002)(4326008)(66476007)(66556008)(15650500001)(6512007)(36756003)(8676002)(86362001)(5660300002)(38100700002)(2906002)(316002)(53546011)(83380400001)(6666004)(31696002)(508600001)(33964004)(66946007)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFxeldreDRCalhhOE5ER3JKU1U0N3ZqK1B1M0dxRm5JNUlHZi9PamxIcXZI?=
 =?utf-8?B?TjczR1FNYVVtTmV1YkhlM1Axc2lhbDFSMnBzYnIyYWkyamtRNTZNeEFQVmZu?=
 =?utf-8?B?eXFmYWpNTmJ3QkJFQTA4WWc0QlF4WlBhRHA3Rkk4andvYVpYbWtBdmJjaldm?=
 =?utf-8?B?RkpvQTVudWxKVHVnaUZqM3dDb0FyblBRb0lrTUhWRk9tWE0zbCtVUFdib1RI?=
 =?utf-8?B?TlRMemY4Z0VjblN5RVd3RkNPam9aMUFUalVLUTVnR1gyM25XT3crME1GdzRX?=
 =?utf-8?B?ODFQVDN0aklZeVBtTkRJZi80RDM4MHFxTUs1VCtVM3BFZ0lqQTVIdVRSN0xt?=
 =?utf-8?B?aTJMdkRvdysvUFNCaUxnT3h2WVBwczBQbnA4ME04U0NkRkZmNXRIMGU2WmZK?=
 =?utf-8?B?N1pEN3UrRUNNZzJQNUtwTHh2cW1SbGN0UXNaY2tCNEZXNDg0SWczeWVzanBK?=
 =?utf-8?B?UDVKVnRtWU55eHdDMnR5RE05UCtwSURrSnhhM0RlYk56emlWY2lxUXAvV1dQ?=
 =?utf-8?B?RWVlTGMrcDhaTEpGOVBwUGR0REpvbGdxWDlnbXp4N2hkVkR1dFpzME51Sjc2?=
 =?utf-8?B?dlc1dEdBVEZ0TlQ3QnRud3czZU5nL3JDT2NFang4UVFqK05LdUdWSU9yN2RS?=
 =?utf-8?B?T1VHQWZWUnRzdFMzUnpseGhIZG1YaU5VK0VhUi9IbC80MHYxZUJzbjBMZk5o?=
 =?utf-8?B?SmFJYjhqYUs0QmlkTGQzZGx1MWtPSlVtbkJ1L09sQnZuRTJTL0lZS0lYbG4y?=
 =?utf-8?B?NFR5U2ZEWHB3NkFVeXZpRUw0eWRnS2JzNlgvRVdJR0RUUHNrdzlZOGMya1NE?=
 =?utf-8?B?YmE0SlhtbVBaZk13YU56WHY4a2dPbW9uR3BnS290NElVZ0lkWCtnTFAvSnU5?=
 =?utf-8?B?dldMNE1OeERxSzAwR21Nb0g5Wlo1L3oydTBWUXV1YjlHMjZSaEEzTUpDeElj?=
 =?utf-8?B?dG5IMUQrUjl3ZUtEbTN4eC9qb0JCU1k0TXhrQTdOVXRTUk5FQ3JlT0hSTnlp?=
 =?utf-8?B?aUd0TGNpKzdEOFRPR1Y4SlR6Q2FmZVFXSmp2MXlmc0N1MTRMQmhnT1ZHQVNF?=
 =?utf-8?B?cXlURjllR1U4RG1JVlZYRXhwaDZZVk5EeTUrenpvOFE1aFNuUXEwUmpqYW5a?=
 =?utf-8?B?OWo5ZnlVS1oxQ0M4L1ZkUkJFQnNqYWRPUTVrcVNKNHQwQi9obW9jbFNCQlNN?=
 =?utf-8?B?MkJVTVFMUFlOU1phQndFMDJLRmpSMitoTTNJNzFBM0JwalNhdXdhWnpneXBu?=
 =?utf-8?B?OXFaNXAyVEhDK0JSaGNZb1JKZ2NQVXl0ZUF4bUZSRzFTd0dqcHZNdkt1eG5i?=
 =?utf-8?B?ZDE2OFdTRW9LcU01cHVtYnlkSjBWS1BIbUo2UkR4REowV3pBZTFyQkdQNWtU?=
 =?utf-8?B?SkZIRnp2ZkNVNFpMTmhTSEpEOHJHOS9HWWRNcXhQMTJldHZwcnZROExCc0RT?=
 =?utf-8?B?Z0ZGZWs5Y0tzSm5oTXlBeEJLTE5ObmpRYXdHZWxoek9qTmsvQ1FReDF1bkNQ?=
 =?utf-8?B?eG1zdXJzZ0l4OURvRVNLamlMMi9TZDVIZDg2UFNLTWZrSGtvNlMzRjN1enlX?=
 =?utf-8?B?b003S1ZyTTVmZnBodXZvbndhaGYwMU94YXRRRHVLaWxadnljR3BzRWkwMGtT?=
 =?utf-8?B?ZDdjeEpNUlQyYjl5cWJHMXRyUlRCZUhnNXJGcmpaZjFuakxuZ3lkMlBXYmlm?=
 =?utf-8?B?MzgwZWFuU3lUekxqUG1nU01WU29iMGhlZXRLQ1ZmV0VVTHJ5RXBlSHBqOG15?=
 =?utf-8?B?UXJGQ3FRaHZwVHYwVysvczhaamNkYk1VUVlJOHpaWkQ3TTdXNmU0WkZNNUUv?=
 =?utf-8?B?bW9kcDF4VXpoTUM4WjJkaERYczBBb1lXdFY3MlNMNFhydU9vSVhTS0ZzOXlJ?=
 =?utf-8?B?cmYyNitYbVgzNE1VR1dhTzBnaC9IOC9nY0thazhxQ3VORTZWV0RMTnFWeHRh?=
 =?utf-8?Q?VsLpxynEsjwoKSGKhO1OiPCvgOZRsMBX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce88a6a-d99a-4365-1a38-08da08faa500
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 16:16:23.1939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tvv1aPnQtO0pML2EmqNS8wtPV9U2YNswyEpdyOAWUTk1PXwvki3h465293dOxef8bxzfrWC2E7rl79tiRBDBJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2009
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290
 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203180087
X-Proofpoint-GUID: I5xTp7nXctJFfTh8qoKHDvr74N_qXeq_
X-Proofpoint-ORIG-GUID: I5xTp7nXctJFfTh8qoKHDvr74N_qXeq_
Cc: lulu@redhat.com, mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============6797139153119049082=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6797139153119049082==
Content-Type: multipart/alternative;
 boundary="------------ur0dMhyPvPJ6I5EQ7sgM8iYj"
Content-Language: en-US

--------------ur0dMhyPvPJ6I5EQ7sgM8iYj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 3/15/2022 6:13 AM, Eli Cohen wrote:
> Update man page to include information how to configure the max
> virtqueue pairs for a vdpa device when creating one.
>
> Signed-off-by: Eli Cohen<elic@nvidia.com>
> ---
>   man/man8/vdpa-dev.8 | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
> index aa21ae3acbd8..432867c65182 100644
> --- a/man/man8/vdpa-dev.8
> +++ b/man/man8/vdpa-dev.8
> @@ -33,6 +33,7 @@ vdpa-dev \- vdpa device configuration
>   .I MGMTDEV
>   .RI "[ mac " MACADDR " ]"
>   .RI "[ mtu " MTU " ]"
> +.RI "[ max_vqp " MAX_VQ_PAIRS " ]"

Here it introduces the max_vqp option to the SYNOPSIS. I would be nice 
to describe what it means and which device type is applicable in the 
below section:

> .PP
> .BI mac " MACADDR"
> - specifies the mac address for the new vdpa device.
> This is applicable only for the network type of vdpa device. This is optional.
>
> .BI mtu " MTU"
> - specifies the mtu for the new vdpa device.
> This is applicable only for the network type of vdpa device. This is optional.
>

Otherwise looks good to me.

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

Thanks,
-Siwei
>   
>   .ti -8
>   .B vdpa dev del
> @@ -119,6 +120,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55 mtu 9000
>   Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55 and mtu of 9000 bytes.
>   .RE
>   .PP
> +vdpa dev add name foo mgmtdev auxiliary/mlx5_core.sf.1 mac 00:11:22:33:44:55 max_vqp 8
> +.RS 4
> +Add the vdpa device named foo on the management device auxiliary/mlx5_core.sf.1 with mac address of 00:11:22:33:44:55 and max 8 virtqueue pairs
> +.RE
> +.PP
>   vdpa dev del foo
>   .RS 4
>   Delete the vdpa device named foo which was previously created.

--------------ur0dMhyPvPJ6I5EQ7sgM8iYj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 3/15/2022 6:13 AM, Eli Cohen wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220315131358.7210-1-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">Update man page to include information how to configure the max
virtqueue pairs for a vdpa device when creating one.

Signed-off-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a>
---
 man/man8/vdpa-dev.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/vdpa-dev.8 b/man/man8/vdpa-dev.8
index aa21ae3acbd8..432867c65182 100644
--- a/man/man8/vdpa-dev.8
+++ b/man/man8/vdpa-dev.8
@@ -33,6 +33,7 @@ vdpa-dev \- vdpa device configuration
 .I MGMTDEV
 .RI &quot;[ mac &quot; MACADDR &quot; ]&quot;
 .RI &quot;[ mtu &quot; MTU &quot; ]&quot;
+.RI &quot;[ max_vqp &quot; MAX_VQ_PAIRS &quot; ]&quot;</pre>
    </blockquote>
    <br>
    Here it introduces the max_vqp option to the SYNOPSIS. I would be
    nice to describe what it means and which device type is applicable
    in the below section:<br>
    <br>
    <blockquote type="cite">
      <pre style="padding: 0px; margin: 0px; color: rgb(0, 0, 0); font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">.PP
.BI mac &quot; MACADDR&quot;
- specifies the mac address for the new vdpa device.
This is applicable only for the network type of vdpa device. This is optional.

.BI mtu &quot; MTU&quot;
- specifies the mtu for the new vdpa device.
This is applicable only for the network type of vdpa device. This is optional.
</pre>
      <br class="Apple-interchange-newline">
    </blockquote>
    <br>
    Otherwise looks good to me.<br>
    <br>
    Reviewed-by: Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a><br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:20220315131358.7210-1-elic@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
 
 .ti -8
 .B vdpa dev del
@@ -119,6 +120,11 @@ vdpa dev add name foo mgmtdev vdpa_sim_net mac 00:11:22:33:44:55 mtu 9000
 Add the vdpa device named foo on the management device vdpa_sim_net with mac address of 00:11:22:33:44:55 and mtu of 9000 bytes.
 .RE
 .PP
+vdpa dev add name foo mgmtdev auxiliary/mlx5_core.sf.1 mac 00:11:22:33:44:55 max_vqp 8
+.RS 4
+Add the vdpa device named foo on the management device auxiliary/mlx5_core.sf.1 with mac address of 00:11:22:33:44:55 and max 8 virtqueue pairs
+.RE
+.PP
 vdpa dev del foo
 .RS 4
 Delete the vdpa device named foo which was previously created.
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------ur0dMhyPvPJ6I5EQ7sgM8iYj--

--===============6797139153119049082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6797139153119049082==--
