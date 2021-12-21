Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EB3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 08:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF78C82662;
	Tue, 21 Dec 2021 08:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWciVr8n-Npq; Tue, 21 Dec 2021 08:03:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4228E81A4E;
	Tue, 21 Dec 2021 08:03:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10DF0C002F;
	Tue, 21 Dec 2021 08:03:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 721BEC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 08:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5169B81BFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 08:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYFobHBQM4nc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 08:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1496481A5C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 08:02:57 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BL4jXgG022358; 
 Tue, 21 Dec 2021 08:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jHVNBkVu8mx5IpiMEr9AiEgoxs0hDqvQesbcVTazmKk=;
 b=J86D614Pa+9vQqhiRnrtXKbJitRKeWVNk/v0jiV4O4Dfctgo/vAjQNTqIccfvV0Lo9Wn
 QxotNvhJiMfelRHylf2dFyoSsGcTunAXw2xCOKHeFc7oIdZQ0rVTJukOwTKQkw7cvLZb
 k8SSvkuWzfS3UTAHmiYkSrlr6TtERQ7sd/pZ0m4CJBKZASpFSbjboAlFLgYWWBFMy074
 oEIiu49ofz5V7QQUC4Jgqmx1NxJpATbxqmZnTQ6who4WqMnYqfZMiWGuda+9jgCnHgKi
 eTRfbw0nw4qyQwZQR7boZO4/Q5KcOIGXTIxrQWuXhlH1/+pBiBA8iKk1IRiJNVQ7lPcs bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2rkujdx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Dec 2021 08:02:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BL80Qmv176122;
 Tue, 21 Dec 2021 08:02:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by userp3020.oracle.com with ESMTP id 3d193mq8rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Dec 2021 08:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+SMhrqBd+txBa7cj2XiebSCbhSN7ZSZEU6OSVOuFNGLcVqOkimDrIMh+B5E3VwuXKfBrDOFx0cmO1hlTNimdBkLHqRuBFqb223cAPKucBBSmVoMY7Eibui98enr2QnbLqfU8e0fi8gjyBZ0zuMPgtTTbdUezRWnQR5KqRkxyCdX7wJ+fhv+w7o3V9dv8tIApqKsvsRU1iPE2xIlOZ2t+E+3oyb/LcHlYun9j/djnjLwta6D0p82+MXRqRgdsj/IRvirGZRhJfC3Orqosy+FppRNQdniO5FsSwIblDmDrzMaO3YyKtdysufKeCz3859xTyDeJPuK82zmQMJhmKuIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHVNBkVu8mx5IpiMEr9AiEgoxs0hDqvQesbcVTazmKk=;
 b=ST8pNzxxmIw8SnPUQkJMJjpOCkN0fMJwgChTFD8CdC2VhFQc1TWjr+FbHr9Whp6D+HDb0/zZO0SvUFW+KEDAL4bPFEtx8gUnUk8O5fKoBfrppdXiRCw+71sldCO9ol2Er3z4c/MkJI7DC4loq0Y4DgfjPHlJF8l8OrHwzV4lZtpCwrlHSU52/29tbyTkVtoKIq0apgh7i7Omo0MQKWpj0hoChH5jbQttWzKMDsFcr3H3cKRuz3jJLjdennOgZlytENu4FaiSI8qsuvZMngOPi2o2qXmbRAl+V7P9R/RfynTIN+qJ49vltwpQGK/ljl/tOgfKMzB4TeiupyLvfarYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHVNBkVu8mx5IpiMEr9AiEgoxs0hDqvQesbcVTazmKk=;
 b=xJo/f9NTZz00sXdpgzC2gUFZ8YDtzuEfh5r6WQip7Z+6FhNvpntvYLGIVK1cOMy/EPq7Q1tUU31tY9U4536eOh2/ZY0YL12qFObYWO8+lxUjF8rJpUcAT1xfbhaEo/l0zHu7lboTIaWfnV7AV2fRnG86UrkzatQswtGVuhxqOIM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2600.namprd10.prod.outlook.com (2603:10b6:a02:aa::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Tue, 21 Dec
 2021 08:02:51 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 08:02:51 +0000
Message-ID: <28c8d325-1373-38be-fc9d-d1635bf53dfb@oracle.com>
Date: Tue, 21 Dec 2021 00:02:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 09/10] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-10-elic@nvidia.com>
 <3c04815d-1ecc-f8e2-08b2-7f21d5149d91@oracle.com>
 <20211214082229.GE89087@mtl-vdi-166.wap.labs.mlnx>
 <70af2d6e-bd4b-27d5-f3d9-3f745e91b9fd@oracle.com>
 <20211219120839.GA84946@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211219120839.GA84946@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::25) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bbaa71a-2a6a-4296-ec21-08d9c4584932
X-MS-TrafficTypeDiagnostic: BYAPR10MB2600:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2600254A540CA7EB1CEDE57CB17C9@BYAPR10MB2600.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64Ved70fnLoBceWWDG6H1UYRJ6MKszmD0YVLR7zRlYxRPB8H8ljnZXM7Bc65RakUVygkJgER/clHGMp+mbFyDXlYgQ3pogaIKNHh8UpkthNele/PHJL8a8shgGIVW0R/+Et6kq1z1eF2PjT5+P6nUKRmwmcquaIViwxdcq1KUDj0Pod7zlj1BwTdhMwickoXn+KIAbUQyGfUJ5Erjqp4sEz/mIIcM+hUs3a1/BODsndLcFV0E8JxRz7F7FpDAwwOaQKH9zJ7zs/HbYTn1vMO3cjJa6PV6EwWFACxTnOfhXLamVQy/iMTHhlMqzGUijGu4nxeEW/1QQFqkUWSxwC2hJC8BFcB0dw6AHCX0L6dAnS9N+F0FlDgtIkknAxwJmT3cmfqbyhytPavPU7Chhpjn8WHCTodmz7oX70VGzLbUw1zj7xZ3lmk4zsGu2RkQSypcGv6qcuDmDJmXzkzccQpP+IcdbdfuhqMawiOC1XxAMowmL8x1ipMrLg57KhJuZaVOCTK3ZbXKTCrRfi/w+dVr0DpqENFRFyjtEt9PBUx7ox3gr8IXR0/BgI6F51ryKcR7PaWvvTQ5z1m5D7WpLMji/2hU6ck4N4Pn3PNC49zDI1kZf3Lh4sOR/tJ3E+rgy7AIbvuk5eK1Bd81gD83Fl4pEgCJ27nX+W5k0hblF5FEr6m7hr2HhXbBHu8wixX8YAmWim38lfSFdpLOWQOqOPTVr41dIPKiZ0b1yYXQyt1BCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66556008)(2616005)(8936002)(6916009)(36916002)(8676002)(38100700002)(66476007)(86362001)(31686004)(66946007)(36756003)(186003)(31696002)(6512007)(83380400001)(53546011)(6506007)(6486002)(5660300002)(6666004)(4326008)(316002)(26005)(508600001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXh4Z1M0UFN1WEJaRHhhcXNQanlHa3Q1YnpGTFRnWUF0THVMb1ZOK1RETFN4?=
 =?utf-8?B?cEZNODRQRjFFNE5RNnJYWktTZEZpbUpZWk1PVzlaT2c5b3NqSzV0VkZqL1U4?=
 =?utf-8?B?NXZxUEpWNjZ0ZkRRVDZKRmVBV01KR0JQR0JtNEtpNWhjUTR1MUNMQWMvYk10?=
 =?utf-8?B?SC90TFc3bC9WNzFUcTk0UjMvck9NeGkvU2M1RXFvUzVNL2xkRi9XZ1hhaWpY?=
 =?utf-8?B?NFM2TVc0emlON2xGSTdBcksvVG40Q3JvR1lydkZicEdYdVZ3NExCVnh1R091?=
 =?utf-8?B?Q0JsaDlub3JYaFZMMzZUazEwUWdIZGVrZ28xU3Y2WkRMYjZCZWxjalpDTGhP?=
 =?utf-8?B?MzluSHJzOVdtaEdqQ3JqTnZZNVM5TnhNQWhiVjNGRnFYVjQwQkdRWXhXK3k4?=
 =?utf-8?B?RHJwMFZpdzlpN1Rjd0JoNVRrR1NCU0duZGduL3hLWjJ0L2wvNXBjU0hKVCs3?=
 =?utf-8?B?YjlSUGkxalFRZmZzWjVvWGk0WnR0cXZaMFJ2NGh0bW5uZTBHeVdOTDhDUHpu?=
 =?utf-8?B?dkE0VkN5eHR2QkZzVVUzdVJCTzFFc3ZmMTNOTTJqS1FkRmFmRndsN1JIUDgw?=
 =?utf-8?B?Sm04dXlWT0owcDQvQkZKcGhMa2Z5RG4zMm9zSEE3aDJ0TGJLWVcwS09zL2Nh?=
 =?utf-8?B?SHpwd0dhdWNLVUNGdFAzWlFQQ084RDhUTCtUWnU0WndUVDhUci9DcitUcnBT?=
 =?utf-8?B?dXphSmtmeEZGZHk3dHN2RGtMbnU5MnFSRkVSbFVtendxY0J4czhvZVdWa01w?=
 =?utf-8?B?cGxuUlJyNUlpQ1huOHdvVnRKRWJhdXcycjBRTHFOcGo3anBoK2c3SW95THRl?=
 =?utf-8?B?dy9ZMWl5QmdZWTc5NkJQOENHRWladFExK2JMTTFTWlBPOUkydG1POW9CZGh2?=
 =?utf-8?B?QndKRXZhc0t5aVpLZUwrVWJVQ0Y2TXpvdkwxOWc5WUIxdHdDN2thdTlPODUv?=
 =?utf-8?B?UTlpaXYrNURMQTBpNk4xNXRJUW1aOWJINmJ2bFNpMS83YmJjWHppV0tQNkoy?=
 =?utf-8?B?azJNQ1h1YXhkZGUrVzlnOThkTlcrTkprYUhFRlFjZ0JnYSs2SldKRUEzUjcv?=
 =?utf-8?B?TCtmR3JMNmltSW9Ic3dCZlNpUWtCdS95K1VxTGYwT21yMHE3MFZjVnRCYlgz?=
 =?utf-8?B?UzhFTkZLbW1xME5VNlZ4UStaSndVZjdNN3d2ejdLLzMyUWFHZjZBVW5HbTRO?=
 =?utf-8?B?aXJ0bDdyMXA3ZVJra1JMbVl3azc3VUROclMzbU4zcEhxb1FCN3hWVWxkenFQ?=
 =?utf-8?B?Sks5QUZYd05DTWVFb2ZidzZ2OUhBZVhGTXk5Sng0T3pEdkltVERGRnBIZmtJ?=
 =?utf-8?B?dTdxMnlaYXhTREVtVlB1N25FcDA0Q2NIZEhxNUlmeFl0Wkg1T1pzemg3V0xx?=
 =?utf-8?B?bmFUdXdqcVFwWTBFWWowRWl4KzhJVUpOZXY5ZjJyOGlVcG80Vnc0M1FwM1VY?=
 =?utf-8?B?Y2RNSVEwTWNaaDh2bUZmRm1pZHJBeGdQNDdaTXlJTlZneHpNTUhKZi9VN3g1?=
 =?utf-8?B?NVIwb2QzNjd5KzVNQk5iNzVOZTRNMmR5SSt1dHJ0c0kvdTFZYWlRWi9hY0lF?=
 =?utf-8?B?ZzUrUVg0RG9VaUhKWXdvVkd6NERtWnM0eFN0STYyQlVVV0QzR0YrT2F6OTcr?=
 =?utf-8?B?dE5xelZPVzErYVpwYmpwZGU4S1hoQW5OUDQ5M2VTRTJHUjZadXVXTjhQVDhv?=
 =?utf-8?B?NmQxQS9JNVhJTTNBcklXRVBPL3Z4YjVCSUs5SzhyQXVWTGN3cXJYTjBLUlds?=
 =?utf-8?B?QjNuQWZVeFQ2NGtPOUhRYllTOGs5Z0JHRSt2Y0Y0TzVwVy9IZmlYWmV5Skxj?=
 =?utf-8?B?R2dpaFdmbmkzOHBYOFgvSkN3aTFQTUhkL0pXUE9iMlVpWXhSRGs2TVhCejI4?=
 =?utf-8?B?a0tOTlZycFZmbHk3U3p0KzJ0NFVOQmlsbUtZMWREU0cwU3JzNGN6UDM4dlRs?=
 =?utf-8?B?U2J2Y3MwUUx4MW1EaExFcTNsVUlPdGFzSnVvNkdXcTM5aVRqOENEUnZQWUtK?=
 =?utf-8?B?R0xSbiszeU5DQ2lodVEzdUxIRzlqRTRnTnh2QUJjMXlYWmhTWEx2NEJraVJI?=
 =?utf-8?B?emxId1hicFYzVFNwbEtWQ2lHMGtOcUx5L1psTU5tL2J6K3ZaQ3lZYmtVMjdJ?=
 =?utf-8?B?SzB6aFl2YXRQdDBqck5pY29WMVlWNFZIc1VVODJWaThkcXhKMVBwOXJNdnA5?=
 =?utf-8?Q?4oeeizjnbKCofj3sK6DdHhs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbaa71a-2a6a-4296-ec21-08d9c4584932
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 08:02:51.6063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnDd2cz5w4utdFUXd6o/ophHP+DZx3yvQ3ltYdISA4E5WxB8CWylK93lcmXH8Oj9XnnblkGLO4OucJZnFAPAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2600
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10204
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210034
X-Proofpoint-ORIG-GUID: PV8IzOdxfyHVrp4y7Dfv3ggHJDnI_uD-
X-Proofpoint-GUID: PV8IzOdxfyHVrp4y7Dfv3ggHJDnI_uD-
Cc: lvivier@redhat.com, mst@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/19/2021 4:08 AM, Eli Cohen wrote:
> On Wed, Dec 15, 2021 at 06:56:40PM -0800, Si-Wei Liu wrote:
>>
>> On 12/14/2021 12:22 AM, Eli Cohen wrote:
>>> On Mon, Dec 13, 2021 at 05:00:18PM -0800, Si-Wei Liu wrote:
>>>> On 12/13/2021 6:42 AM, Eli Cohen wrote:
>>>>> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
>>>>> need to feel this value according to the device capabilities.
>>>>>
>>>>> This value is reported back in a netlink message when showing a device.
>>>>>
>>>>> Example:
>>>>>
>>>>> $ vdpa dev show
>>>>> vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
>>>>> 	max_vqp 3 max_vq_size 256 max_supported_vqs 256
>>>>>
>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>> ---
>>>>>     drivers/vdpa/vdpa.c       | 2 ++
>>>>>     include/linux/vdpa.h      | 1 +
>>>>>     include/uapi/linux/vdpa.h | 1 +
>>>>>     3 files changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index 130a8d4aeaed..b9dd693146be 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -695,6 +695,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>>>>>     		goto msg_err;
>>>>>     	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>>>>     		goto msg_err;
>>>>> +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_DEV_VQS, vdev->mdev->max_supported_vqs))
>>>>> +		goto msg_err;
>>>> What is the default value if vendor driver doesn't expose this value?
>>> I think each vendor should put a value here. If you don't, you can still
>>> add a vdpa device but you'll have to guess.
>>> Alternatively, I can provide a patch that sets this value to 2 for all
>>> vendors.
>>>
>>>> And it
>>>> doesn't seem this is something to stash on struct vdpa_mgmt_dev, only some
>>>> vdpa vendor for network drive may need to expose it; if otherwise not
>>>> exposed we can assume it's 32767 by the spec.
>>> I am not sure there's any device capable of so many VQs. In any case, I
>>> think use 2 as defauly is better since any device can support that.
>> OK, default to 2 is fine (for net).
>>
>>>> A generic vdpa op
>>>> (get_device_capability?)
>>> The point is that you need this info to create a vdpa device so I don't
>>> see how it can be a vdpa device operation.
>> I wonder if this info should belong to mgmtdev rather than vdpa dev? It
>> should be visible before user ever attempts to create a vdpa device.
>>
> Every vendor lists its devices in the management bus. The you use vdpa
> tool to instantiate a management device so I think management device is
> the right place.
>
>>>> to query device capability might be better I guess
>>>> (define a VDPA_CAPAB_NET_MAX_VQS subtype to get it).
>>> Why limit this capablity only for net devices? Any kind of vdpa device
>>> may want to report this capability.
>> I thought what you report here is the max number for data queues the device
>> can support, no? The control or event queue that is emulated in userspace
>> isn't much interesting to users IMHO.
>>
>> User needs to take the hint from this value to create vdpa net device and
>> specify a proper max_vqp value. It's rather counter intuitive if what they
>> see is not what they would use.
> I am not following you here.
> We report the max the device is capable of. The user uses this to create
> a device and specify valid number of virtqueues.
I mean why don't you expose this value in "vdpa mgmtdev show" before 
user attempts to create a vdpa device to know the max number of queues 
the parent may support? How can a user infer this value without having 
to create a vdpa device?

Thanks,
-Siwei


>
>> Thanks,
>> -Siwei
>>
>>>> -Siwei
>>>>
>>>>>     	genlmsg_end(msg, hdr);
>>>>>     	return 0;
>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>>> index 9245dfbf1b08..72ea8ad7ba21 100644
>>>>> --- a/include/linux/vdpa.h
>>>>> +++ b/include/linux/vdpa.h
>>>>> @@ -444,6 +444,7 @@ struct vdpa_mgmt_dev {
>>>>>     	const struct vdpa_mgmtdev_ops *ops;
>>>>>     	const struct virtio_device_id *id_table;
>>>>>     	u64 config_attr_mask;
>>>>> +	u16 max_supported_vqs;
>>>>>     	struct list_head list;
>>>>>     };
>>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>>> index 23b854e3e5e2..1b758d77e228 100644
>>>>> --- a/include/uapi/linux/vdpa.h
>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>> @@ -42,6 +42,7 @@ enum vdpa_attr {
>>>>>     	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>>>>>     	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
>>>>>     	VDPA_ATTR_DEV_FLAGS,			/* u64 */
>>>>> +	VDPA_ATTR_DEV_MAX_DEV_VQS,		/* u16 */
>>>>>     	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
>>>>>     	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
