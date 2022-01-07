Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD04C433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 01:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2088D60B62;
	Fri,  7 Jan 2022 01:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTy791McyvfW; Fri,  7 Jan 2022 01:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 90A2B60BCA;
	Fri,  7 Jan 2022 01:25:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74173C002F;
	Fri,  7 Jan 2022 01:25:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE2EC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F8DF4299A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="fUjOBaCJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="wUQft4ca"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxO50fXd993t
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:25:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51CD942997
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 01:25:46 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206Kr9q1009272; 
 Fri, 7 Jan 2022 01:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SnDJR/6BmmlSTxj24HBoimsP+ih6ebAQ3OT7MDNhUDE=;
 b=fUjOBaCJs0lB7qHA49dPd9ngB9Ro3OBFhMA/mcufABV6+VnZDDNABxoW4Ljc6ECwgb1f
 WlXbVmFlrtFquPAjRnGa9bUaajEdqQLnQS+soblnvX1f/TQFqMb4VxDOYYeKUIfxNwiw
 VXp67k3Thdtg1JBj5B0L/crcrI8MypbNL9WaW+EYEh2Etgs0wHZXQmyTJESmDFyGgGTn
 WDNsAWS02N2qoYtghF0GOChrsj7Ez6vVEAE6kjZkf9+gcJEbgUYjY88og/xVh+JAeh/S
 znIYq7Gve1gH2BMWjuuMzRb+dKqpYBu5JlD/h30yK1D5krunU0gRPnj1wDQbJqYppb7s 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4vh8ur5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 01:25:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2071Fsb9150376;
 Fri, 7 Jan 2022 01:25:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by userp3030.oracle.com with ESMTP id 3de4vwxn28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jan 2022 01:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=douWQAS0AAkxllgIcaU5KheA+4V/H/Hd7WRxnV5i7KlpEEVra1PTmWgj8yXPyOcLaBFbqAIMsTtdVSNtBSAHJUVxYSpd8iwWVHFwuNYUaFpppgL3njrilBH9y6w4IaSJWFuhMrmeXme5k15AbgcDSIwE2rubgemlcAGR+XIL2og7FcCBQ2MtQGGATIrfEk0ivdNHc1YUdqrUutZxwoZazHZOrrGI/wf2qdf49sh9g0FF0GDV88SMyazVe8PbTpN61cmByn6d8i39v4uz6SBoWx5Q9KqUENGbmTwLDD9x7ma1RcxIcQoDaLLeeYKbDI5qKGYQPVyG2uif8NMlQz/ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnDJR/6BmmlSTxj24HBoimsP+ih6ebAQ3OT7MDNhUDE=;
 b=DrjFdzX97ypsWCTBIuCAqSOT0ieEwOy5yU0K76s5FREjJW/aQg6pacUWouiK5LJX5M4Ozxy7QXLnuPLvcojA4xYWhWsDMRSoOcNPe0vAXkPCXxUcZXCdpI7870a3VNYba8p9/WwCkqdR3q99kEs2NyzkMi2L2DPslUf6tFRh5tlAyj6IpfmLZY999jddd6KjybuFdhDYWQMqG2FdudN1BqmfxbpNwcEwvCwqw24EMv3btwgqFmNMtghXo0JViocICzFdXy7Y0qhqEyqyp6xXrq1TrZotWGThQqrekdrPj6os2lbXbz1vDOUw3yg4ySXJ0U+SUAcXPP4nfUXKTRvhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnDJR/6BmmlSTxj24HBoimsP+ih6ebAQ3OT7MDNhUDE=;
 b=wUQft4cadonYbIbfolPnvIvCOUzaNwrJ+0KwDy4+0NP1EWc6Lk5GvwfT9fRLIEd+8/2X5UGcH+wlpg6RYBHM6aFAJjHC99dYl1KAbWnjZkwwFWdJ1DhbOXUHKfJB/ln26D30ot/uZx1VhnZ8vbsgUbeakTlFiRYsx1hzd9qWRwo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 01:25:40 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 01:25:40 +0000
Message-ID: <65a8e234-79de-2983-e1c2-2e5dadc4ea02@oracle.com>
Date: Thu, 6 Jan 2022 17:25:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 05/14] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-6-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220105114646.577224-6-elic@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0153.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::8) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cbbd5c7-c633-45b6-0a08-08d9d17c9db2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4750:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4750BE385FBB2B952D9305D7B14D9@SJ0PR10MB4750.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9iuieZPmaAhURlh3/2eyuOwqEAAYLNOBE/AOASBRV47xf43weDs7BELJe+grPt2d7ZQPxMcDNhxmzXVg4FOaAoPCTK2jKMtNkYJlpD02rIQxxBPxI3oOugNxIuSN0w5hWJU/MY+EfSU9d73gHjBapCcYf3viZ5tiHIk1uKJcVAwxWJCdUD70tdD0T3ixYr1poO4Fq6qTG3d99J2gGBXu0L0YUS6WjTPXdhbEiKbRP8zImUFZ2ivVCDQc9GKIFpmOC8TCR4wuYgQ/qSO9Agfh583BJd1EdwA7fQuvWIGG7Td0VoFMtCPzwBCzqFB5xx94eY2/TIqwa+CEW/QlCWddNtc/9Saj7F2aFG8HnY4MjBtSJyepsVvk8PBlbZuQLwEOM3RJAgTtQp9P8ImBWWXaAZSTa9x8k8wqkMsTPx6c4/0jL6s1XC+0NWgCYezK4o1fQc35UsP0RqFkoC4hT14PEdWP5RuZZaHNQkjtU2tHOYNnMw8DjtHK7WDvAmxkrkmCzbxCe+YZZ7btatWrgEYMJsgW3SVc1fJ3ge2ahuxcjwoeE8yej8MaAm/EqSklCO3x+jv5jql3OjaSEPSsgY/7/pLEdt1XHD1tXWZdF6MriK7kCS0snF+Uwb3x9jqmtNONT7O788XAS0/tV+JcMk/SGnqQtI1w1uicRNTsmxNwoidXD2Fzbr6ev/9oGfnY36xfERGEnSkQKbctoUZgqUNs8vqYq2/oLVdg5O3HzNdAyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2906002)(5660300002)(316002)(66556008)(4326008)(36756003)(86362001)(83380400001)(26005)(31686004)(38100700002)(2616005)(8936002)(8676002)(508600001)(6512007)(31696002)(6486002)(66946007)(6666004)(53546011)(36916002)(66476007)(186003)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdjcVJ6QXJVWDFoMGZodmJRd0dQWVMvVEMwOUhEV1pid0NuUXhGY1g3K0lF?=
 =?utf-8?B?R0RrYXpSZTVWakEwQk1NanRGZ2tOQXJIWkRDZUJXQitqeUVsdGo3U29aWHJt?=
 =?utf-8?B?aHhXbktpRlRQRnludTYxdnJzeExYbUR6aEIySGhPRjF6NGdLc2dLSWo5N04v?=
 =?utf-8?B?TlFZM1BzRVE1YmZOMndSZHZCd2RIYys3SnVobm9NU2Y0NXF4L3Jnb1hFVUlq?=
 =?utf-8?B?cUI3MVZMaUhLbFMzL2krMWh3Y204TVBNSkZzR250dFBWbXQxeHBZNGFXdG1I?=
 =?utf-8?B?K2YvUGViOTNrdnpBZTQ5QWd0L2pJQ2pxUk9jWWh3bXVIeEdvUVVUQUpiU2tL?=
 =?utf-8?B?QVJOb3BSWmo5bE9JTWtNcnNZdUZzS3FkVUVaRWhmSysyZ3pZL2s4TndVQ3Zp?=
 =?utf-8?B?K2xJeFZadVNSRk11YUdMN0lCVUxmUERjbFJxTUlrU0RSUkV4WHpGZWRxcmpt?=
 =?utf-8?B?cFpYSjNZYXNQWWpCQWkrMXJ0MUx1UW9YWlRBbEY0N0taNjExVEIyMjcrT3Iz?=
 =?utf-8?B?TEZlVW9ReVNadm1sRStJSXdYRHRkRmxvWUd6cHRDSzBHSEwxRHdKZTQxQnBS?=
 =?utf-8?B?VEJrUEd6ZW5GYkNaZXdUT1NmZGN0eWcyei9IZWhYbndybDQxRVYxY25zaVFh?=
 =?utf-8?B?YTM5VGo4a3N2NHB6dFNieFVxNE1yYVZCWjRTZHZLZys1bFBGNjJVM3U4VFBv?=
 =?utf-8?B?dWVJQWt0bjVWL1MrK2tSS09PYW9RYVdEZDdwcGRCTm5JTlNlajQ0NWRlWHJS?=
 =?utf-8?B?bk1ZMEtjZ0hndnVPMDR3a2Jxb05wVHFDQ1cwK1pYSzU3aDQzS1cxNVBDbENt?=
 =?utf-8?B?NTBtcElxTGpRc3JLME9Jb3M4SGs3VTRMbmRReHE2NVo5VzFTc2VLWXluNElE?=
 =?utf-8?B?LzNRRnR1N0JrUGh5SkVUQXI4R2ZXVW5PTGUyenAyelZwL3ZtM1VWT3RJNHZs?=
 =?utf-8?B?VHZuTU9DeHJMdE5IQ1d4Y3NsWDQyZmNwUFFNYm8weGlqSDBUMDZXbUFhWHVu?=
 =?utf-8?B?em9BeWlsMmlOYW9kV3lJTVBQVlRIWW1JbXVWcVZaUkY5aFBCMzdGTStUV2wv?=
 =?utf-8?B?c1BtTGNkNnlmazNvMmRXbjRkNEd1RFhBa1BoSmdHSVp6K2VnZDdjUTBieUZ2?=
 =?utf-8?B?akx1dXpvZmlKVXNuTDZYbHNoUmJhNmdqaDZyOXFuK3RHWXJUM3ZXSTd3TUdx?=
 =?utf-8?B?VzBvQ3pnTTBCbW81V3piUTIxdjhweEJWTExyK0tMYmh1UXRkb3ZrcVVtbyth?=
 =?utf-8?B?SUpvRmUwVTdWTVNRdXBsZHR6VVhoNzNEaGpQNXdPcEIzc1JLalo2bks0Z0RE?=
 =?utf-8?B?RDZvajFWWXJkTXAxbWRnSzYwTXplVWFaQ2ZieUs4a1JaL2ZBZWdpZ29UUjB2?=
 =?utf-8?B?ckxjcytIODdVWmc3SmNwakR1WlU3cFRzZThHMWQ3RjZnUHJJZXlZczZxQTdG?=
 =?utf-8?B?VXVoSFFXanJGWEdsVVpNQ0VrYWYyU3lYSndLQ2VYVnNHVDR1UXhmQit4clVq?=
 =?utf-8?B?Z2t2YTU4VDBRbGhncEFKOHNnMmdzNU04MWNrSkRBVkZ0QTNGQmR4SUptNEpN?=
 =?utf-8?B?OEN6emtSNXNqS2xQZ1AvbDZoZzZ4Zm4yaEoyOVRPbzdMM21PcEhaaWFEZHdH?=
 =?utf-8?B?WmJlUlZncVdIY0ZzaEZPaTFHaE53QmdSTndud2F3eTJuOGNFNVdPczRlZFZB?=
 =?utf-8?B?Y2xlTlgyRUZIcDhpelZnbHF1MVpNdlZzZFNDR2Y4aUdzSFNKREo5UnNUNFpL?=
 =?utf-8?B?Z2t2QnIrNEFGSU0zVVpEbTk3ZXJpYVVrUDgra24vRXFLTHJicHc2Z3lxelhW?=
 =?utf-8?B?VHREOGM3UXd0YWdLWGdTcEdwYjZ1V3FVdzlZdHNWYzcyZEpPd2M1eUcwNWJD?=
 =?utf-8?B?TVhUck9MTk5SdmMvcnc5Qjd2ZTJUSE1TSWxrUWVqd1pHc3JrYVgrTGdtcUhK?=
 =?utf-8?B?N2xjK2lRQ0NYS2dhSERFdlhaN3pzelM0VXdqQk9nNTdLVXRub3FGUFNoSWF1?=
 =?utf-8?B?aDVzcmFrOXZuQWJFTWZtUUUxYkpBdklNTVlKZ0JNMTBFaU5PMTBwdUk3NHdQ?=
 =?utf-8?B?TitzSklPS2J6WENxNGUyRDRDd2YwYjl3elptOGpEV3ZwMzlDamNoSFZKQjBX?=
 =?utf-8?B?Y0thRDZoQzdkTlZpUFdSQ0Q0bi8zTk5OR01wNWwwQnhJWDdtVUhWclVSSVNF?=
 =?utf-8?Q?YRpXIF6AmMdIszBSNmXUEhs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbbd5c7-c633-45b6-0a08-08d9d17c9db2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 01:25:40.2882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeJvj/6uKrS7IHWMC/o5+eLlTYD7gPjeEBXscvPhNbofgLSPbVqLE5ijYtRV0MsPKSoI95IfOcAWKq02Z6KAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070007
X-Proofpoint-ORIG-GUID: l28THzQ1ERtDbbEDuwG2VnuG7ImbWzz-
X-Proofpoint-GUID: l28THzQ1ERtDbbEDuwG2VnuG7ImbWzz-
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
> Add netlink support to configure the max virtqueue pairs for a device.
> At least one pair is required. The maximum is dictated by the device.
>
> Example:
> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 4
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v6->v7:
> 1.Serialize set_features and reset using cf_mutex to ensure consistency
> with netlink set/get
>
>   drivers/vdpa/vdpa.c          | 15 +++++++++++++--
>   drivers/vhost/vdpa.c         |  2 +-
>   drivers/virtio/virtio_vdpa.c |  2 +-
>   include/linux/vdpa.h         | 19 ++++++++++++++++---
>   4 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 4494325cae91..96d31b80fdce 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -404,7 +404,7 @@ static void vdpa_get_config_unlocked(struct vdpa_device *vdev,
>   	 * If it does happen we assume a legacy guest.
>   	 */
>   	if (!vdev->features_valid)
> -		vdpa_set_features(vdev, 0);
> +		vdpa_set_features(vdev, 0, true);
Can we do it here with an internal unlocked version 
vdpa_set_features_unlocked() without taking the cf_mutex? Such that all 
API users for vdpa_set_features() won't have to change the prototype. It 
looks to me the only place that needs the unlocked API is the vdpa core 
itself, which doesn't need to expose the internal API to other modules, 
is my understanding correct?

In addition, it seems more appropriate to move the vdpa_set_features() 
related changes to a separate patch like patch #3. It's not obvious to 
me how it's logically connected to the code change for the max_vqp 
feature here (if there's anything it may be more relevant to patch #8 of 
this series).

>   	ops->get_config(vdev, offset, buf, len);
>   }
>   
> @@ -581,7 +581,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>   }
>   
>   #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>   
>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -607,6 +608,16 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>   		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>   	}
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> +		config.net.max_vq_pairs =
> +			nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> +		if (!config.net.max_vq_pairs) {
> +			NL_SET_ERR_MSG_MOD(info->extack,
> +					   "At least one pair of VQs is required");
> +			return -EINVAL;
> +		}
> +		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	}
>   
>   	/* Skip checking capability if user didn't prefer to configure any
>   	 * device networking attributes. It is likely that user might have used
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index d9d499465e2e..c37a63ba620a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -285,7 +285,7 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
>   	if (copy_from_user(&features, featurep, sizeof(features)))
>   		return -EFAULT;
>   
> -	if (vdpa_set_features(vdpa, features))
> +	if (vdpa_set_features(vdpa, features, false))
>   		return -EINVAL;
>   
>   	return 0;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 76504559bc25..7767a7f0119b 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -317,7 +317,7 @@ static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
>   	/* Give virtio_ring a chance to accept features. */
>   	vring_transport_features(vdev);
>   
> -	return vdpa_set_features(vdpa, vdev->features);
> +	return vdpa_set_features(vdpa, vdev->features, false);
>   }
>   
>   static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index ae047fae2603..6d4d7e4fe208 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>   	struct {
>   		u8 mac[ETH_ALEN];
>   		u16 mtu;
> +		u16 max_vq_pairs;
>   	} net;
>   	u64 mask;
>   };
> @@ -391,17 +392,29 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>   static inline int vdpa_reset(struct vdpa_device *vdev)
>   {
>   	const struct vdpa_config_ops *ops = vdev->config;
> +	int ret;
>   
> +	mutex_lock(&vdev->cf_mutex);
>   	vdev->features_valid = false;
> -	return ops->reset(vdev);
> +	ret = ops->reset(vdev);
> +	mutex_unlock(&vdev->cf_mutex);
> +	return ret;
>   }
Can we move the vdpa_reset() code change here to patch #3? i.e. to be in 
parallel with set_status() changes.

-Siwei

>   
> -static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> +static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features, bool locked)
>   {
>   	const struct vdpa_config_ops *ops = vdev->config;
> +	int ret;
> +
> +	if (!locked)
> +		mutex_lock(&vdev->cf_mutex);
>   
>   	vdev->features_valid = true;
> -	return ops->set_driver_features(vdev, features);
> +	ret = ops->set_driver_features(vdev, features);
> +	if (!locked)
> +		mutex_unlock(&vdev->cf_mutex);
> +
> +	return ret;
>   }
>   
>   void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
