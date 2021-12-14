Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD62AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 00:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BA2360B60;
	Tue, 14 Dec 2021 00:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxDEHzRJRnOL; Tue, 14 Dec 2021 00:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88A72607B4;
	Tue, 14 Dec 2021 00:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD78C002F;
	Tue, 14 Dec 2021 00:47:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE43CC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 947E74025D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="IqCs8+JW";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="V6w82idF"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 003USz0xYqLJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F35240128
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:47:34 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLHvvj004117; 
 Tue, 14 Dec 2021 00:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DANpJHa552RWxFkC4MKrcMQwpXMMnZMlSCrBkurgsDA=;
 b=IqCs8+JWU26aG3N68qcYrlRIZ6iAl5lGuY92vt1H6y7AMtIOualfl+3Kug9Z2McHI4Xm
 /41yQsST/eg2Nbtbmxb+VQy2EgfBE5T4OxRgwCnqgZr9Z8J2IjV9YGvZf36jHHNMR6va
 vH2t+j63QUtgIdrkhsNWnBqb16rmKOx/pSOV2c6XkFw2N8CzQKKylVI7pdwFogDkmw9F
 1sdkNGhIpbYnn35IjRkFfec0cmAUubmelDhOU4D5ypYyoBg7lVqXV3xdiKNjgXOXfGVp
 UoYV+4BqDfazcHjo872hsHIB4qKOPcq41DV4q5N5g8/XPew7rBNp0JQh8WLSGtafXn5h mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py2b7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 00:47:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE0fnp3122528;
 Tue, 14 Dec 2021 00:47:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by aserp3030.oracle.com with ESMTP id 3cvj1d32xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 00:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMzMhIZaJRHSWeQWURTtNd3BWUjADTHMpYjiC9bpqPz7g1nDAHWu6jAZ4HjMGMXFuwUiOcz0m8vJBVRlfMFh6Nj0HYiFgk156NWXIk90WHwWs6/FISLul0nuCRSE1+eRgAqr9Stur7FDmsFRnmrPxAmPA31pUQDskdPFfPGeqrjj1wnZahDlSdA1zHiqoNHy8FtEY/Llbcmxzvpk46RZDSDgl6+NYup+m5UE+YODdBcYbs69PzBRtIKEFB8smMna3Uokz6CF6Jh6tchXIn5DQMmtuIfRkZIX4kqh6Al/VGrPRO8W5LurxOzmoXBzsYvWqrsVuHCNTKVGDLf+3Fx0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DANpJHa552RWxFkC4MKrcMQwpXMMnZMlSCrBkurgsDA=;
 b=ah+P4AzxwwT3oDGYn0kCSXjrSQs52BnTP74jiwYCWusm59Ic2s5GZv3dKiJ0AuHRUJLIE24HjmRefEVzW2CjbF0WAFgj1T3IMEd6Yg0dM+Fmf5nm44eKB+AmZPkygxa/DYW0JAP8BZR17urYqEloA6KfCGERVNySiocWhLXyTMw0BjfxEhjqKw6V2wLWGGo5KWS1dHSwT0GYP+PbIHE73I4nESFTGBNftOQ6kVC+4yYebgT/tL4rdGGPstXyFQ8dZXk3eVA7ssycaDFkEEIQyk9u1NvCX9YJAyKLXMEnL3lv0NLAUvE7WbLNd+r487DxCypyiqlHBpBy0Oj6Y0RXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DANpJHa552RWxFkC4MKrcMQwpXMMnZMlSCrBkurgsDA=;
 b=V6w82idFZyaDMrMzm024IP5CqcWoKzQBnRJzNBA6hsR+CHkmZXnQGVm3+ipPT91+afsxJrsE3+NeHdEVr342oRoI323JzMfVBSqxGQBF3xV0M6S8ba2bd6/LD1BIfACroS/nhewiLTj2N6Gk7sM9qLCwQSU+ToPoIiuXgkmgjQk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3655.namprd10.prod.outlook.com (2603:10b6:a03:127::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 00:47:30 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 00:47:30 +0000
Message-ID: <4ed0122a-037d-df87-3018-adb2461468f2@oracle.com>
Date: Mon, 13 Dec 2021 16:47:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 3/7] vdpa: Allow to configure max data virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-4-elic@nvidia.com>
 <5a9d9d83-fbe2-000a-9084-456c2a0ac094@oracle.com>
 <CACGkMEs2jydoBY8xLqNy_Uvurxft7rGzPon542Gup9DDuAyE=Q@mail.gmail.com>
 <9978f096-b0d4-1926-839c-fcaab28f7e44@oracle.com>
 <CACGkMEuUjf9gqBFiD7vzVaxn5vMxP+xbD5V7DGAjKj9TwmWKZg@mail.gmail.com>
 <20211213064453.GD41423@mtl-vdi-166.wap.labs.mlnx>
 <20211213130734.GB44427@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211213130734.GB44427@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b608b81d-e5ff-4528-5434-08d9be9b4ed6
X-MS-TrafficTypeDiagnostic: BYAPR10MB3655:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB365529A52390112660AAF863B1759@BYAPR10MB3655.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykNe+iPorK6OMELdLvu8k4qWFKytXtlabbPhx7ERv5zvFyynqW9x6pXpkpvmeL1jUZEeMiZeNz9qwFkaVGRqJt4jUVpn4v2d035cGh3Zxz01DhrJLJgp7YyQZX3mE8MksDhChxIud/a8/GIq7Kc2P+GvzoQRWgd5U/1fgsNdYc7vmUXvu/eagSUsdqsssj7WLlpr+WTkrg+AvPEJSOPOIqfRUzyUwfwfTyLDYx7U66kXXKti7AkZ4p9vvsUi87+20vE2jTjOOJu1CmCvGlaCzGwmjnE7SK+m6z/ebm+d9uN8uAvEsJ9jF27KvlYNgOKDsYzhciF+SHn8O+BJgOWrZ8uOIC0QOA+kEHxVhkcx781YVxNtJQkNzKwACv2Y/lyKWp3netKRci0Qu4SG4QB4LkbTXmQ75aSAgUFC8HKvBvJrEbojiTiVKkZ2NK3B3QdvomPJgja9lpPWEs59BwPmizOKeesnmKJVDd6eqkF0F1BfpfjQgKFDorCBr99IFgI9GYbmls2/2keX8bll42Iuqqy/X5W7m2MfQ2NOQh2YofseFA/UrAkL1DYsfM3S+9quxh3bf+7SsxDk+mteL4S7IMA7g3NmjdGNWjsOHQZMWPIOvB2tmhQRNxii65ySspFFQw7ZvVbAl+P10jsNz7nbaKwl+vA4OEQdZeY1WgdjEIqOGDu6ecATnHcd+pGM6NmBA1iLRhvojoIdKn4RG/4mV0QtA+rNrjf2/yZGTyGdeSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(5660300002)(4326008)(86362001)(66556008)(2906002)(66946007)(26005)(6486002)(66476007)(6666004)(31696002)(36756003)(6512007)(31686004)(38100700002)(8936002)(8676002)(54906003)(53546011)(6506007)(83380400001)(186003)(2616005)(110136005)(36916002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1IwaGp1c1ZCT0JJR2gzdGU2Qkp2cDJTdy9vV1BVOVFVT3Z5OC9oN0ZSV1g4?=
 =?utf-8?B?SVBSQUFYb3pHeVA1VHBKYy85L2N5cGQ3eHlZZ0ZmOGlWM0VaQ3RpRlY1dFo1?=
 =?utf-8?B?ODFtLzA5OVBLT2tsWmJnRlNoYnpLSEJTTEVhMlQwVTJDaEgwdFcxRVlSK3A3?=
 =?utf-8?B?WlNRSVJYTTZFWit2NmV1ekVRNEJlaG5GekZRTE9ZU1lXeGZsMXhDOXgycUJY?=
 =?utf-8?B?SGtrUkV0TGQraGt3UnlNZjdUYmNjU2ErdG1mRkhnTGJqSFMyYnRQWCtyVFpG?=
 =?utf-8?B?YktuK0JkVGx4T2tYd1VBNmsvdFkvYmxGNFhwMUVUd2l2Tjc2SnVCekxwOStr?=
 =?utf-8?B?L0RKSFdGdDl6bWhBWlVLc3lwT3FOaHVLbmNqRExmM20wT3k1Q21weGY5aGY4?=
 =?utf-8?B?R2RiVmd3RkY5RXplajZUSW16aUxtQ2tWeDF1ZzhwWEhzem5hb2IraHg0VlR1?=
 =?utf-8?B?ejRNcUdtbWtkc2JCSy9tb3BlaXNjNjhDdUxMc2RWVzIwcTRiQUNtVTdpeWxV?=
 =?utf-8?B?Zm5Palg1ZkxDZFlydUdWZG1CSTZkZU5sWE9EY3Bqd2l6b0RDZUFqWGVKRGRw?=
 =?utf-8?B?Y3MySmR3dkZhRnd5NW1rZTlucjhydFFSNUtPZkpPK2h3QVpsMHFyUFA5dy9w?=
 =?utf-8?B?TXVXYXhKRmlwZTE5MnIxZ3Q5NmpNYmFMZlcwVHR6UGhJNzlwTnA4c2tsTFdw?=
 =?utf-8?B?ck1SOFAvcHJEVXZmbStGNjFWSmc3elp0RHNRa1RvY3c2OGhLNkxXSzFQLzM0?=
 =?utf-8?B?YkU3SW1idGNkNjFhY3hoYkpZRWhkc1g4T1c4ZkNyT3BqTzlWaE1OdzA4ZzNr?=
 =?utf-8?B?SVRPcDU0OXBYVXVoRGZiTW5nOXRnZWhYZW95dXUzS2doSlIxc1JkeDRWQU5i?=
 =?utf-8?B?dFlFdVptSmdmUGxZYUt4RGZ4c3FqVXkxdmNKZU5Jc0dOc296RVNra3UwMEdC?=
 =?utf-8?B?bDJJRFVnbkF5MG0wSG9NSjFEZXpka0E5b2xidDdCSVUzaFR1OFZrdHJvMCt0?=
 =?utf-8?B?S0ZGVjgyRXlKa3VRR3k1ZzdUOWtaaFliUXdvSXJmUGJ3WEZ1b0l0Q3FibG8v?=
 =?utf-8?B?NXZTby8rL3NkWmdKb0EwbWhjMGJoNTl0WkxXWmhkcHFOdjZIS1BzQkpFNnZD?=
 =?utf-8?B?elR5SldMOGd6cU85US83cXpQbHozRGFmMUxIOGQvbEU3TXNuVU5PajJVZWFk?=
 =?utf-8?B?TFFHT0RqMW9jcldaVWU3cnZUYUtZT1U3RExBRm1HWTVpeUdxZmUvaUkxbHpw?=
 =?utf-8?B?SXJLSHJwV1FiMHlKWnROOGRyY2lBeU9QUzFUQ2VUMU4wZVgrVU5iOFVZTkNQ?=
 =?utf-8?B?RThuYk5xd2pFL3doSWFGaENJK0hkL1gyK01YRHpxaXhlOHdveGJ3UTQrL211?=
 =?utf-8?B?dHh4OU9UYnJSTVhrdENUUEwxZGUyeElNYXlobkNmK3JTU1Z5QlVRRW1NbHl5?=
 =?utf-8?B?cFJWQzRYcjdjZWlhL2VlSXVaTENwc0E2THF0c2Q3VUJPbGhmbGFaVHBvMWRK?=
 =?utf-8?B?NjBBTWpQdk42dXVwU3RHZTJjZTN0V0FuSlV5V3Y1N0dRWEJSVyt0bDVXM2dG?=
 =?utf-8?B?dWFDV0pRT3BhaFJZYW9NYnZjdE5qcm5HZ2NXaWMzdHRzYTJuQ0ZKcSs0aHFJ?=
 =?utf-8?B?ZFZoZVowd1VmU3RLNUdkZTNnQWxHak51K09JaWxIOUt2cWlKSFY0MExLN2FQ?=
 =?utf-8?B?VEs1TE1TQXh0dEgrc002N3gyVERjS3ZNYU1yZm9xQURlTWp6c1kvVW10b2Fa?=
 =?utf-8?B?Z3E0ME52RVZORnJYaUo1MzJ2YnJ3SDlaS2IzczNsNWt0cC8rTEx4NFFxRmtz?=
 =?utf-8?B?K09RbEk5ckcxb0FteXF0c1lkMUdQZW5BV2V6QlRtK0ZpRW1oMHBsSHJSOWxr?=
 =?utf-8?B?ZmxpWjlXdy9TVHMxaG1sdlRSSGExME5hazI3USsxNlJ4cXcxdzJ4bkg3ckt2?=
 =?utf-8?B?RmlSMkpEdmkwM0dQL2ZuaDR6K2xhS2lWYzQ4WWZIcUsvTkkyMmUyWXFHZENa?=
 =?utf-8?B?UWVNd0ZIbUE1c1RORStkZHRoRGxFZlpReVBJZWNsbTdTaENFbHdkRlNWWk10?=
 =?utf-8?B?VEdPU0xnVkRBSWhMV3RVSlIxUFBTQmkySzBQYW9rYnFDRC8vd0RvdDExV0xT?=
 =?utf-8?B?RHR5OVk2RjBlYk9YYWJGS1k3Rk9lZTdCV0dMYlhvb1MxSEZrLzlNcThKNmhY?=
 =?utf-8?Q?gLlByIVRHZ4wUl91/G7S3go=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b608b81d-e5ff-4528-5434-08d9be9b4ed6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 00:47:30.3856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BdHIgfsXPtWAntytO3iTnaIl+LfXgHKBeo5UXk5OGdVkipLAWm9SIUNdosil+0VyrtuhqkUdSZ5fbkh1H3+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3655
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140001
X-Proofpoint-ORIG-GUID: 6U95pv1KLw7GdjjvImCYimAtGJtqNES_
X-Proofpoint-GUID: 6U95pv1KLw7GdjjvImCYimAtGJtqNES_
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

CgpPbiAxMi8xMy8yMDIxIDU6MDcgQU0sIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBNb24sIERlYyAx
MywgMjAyMSBhdCAwODo0NDo1M0FNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+IE9uIEZyaSwg
RGVjIDEwLCAyMDIxIGF0IDEwOjI5OjQzQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBP
biBGcmksIERlYyAxMCwgMjAyMSBhdCA1OjUxIEFNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDEyLzgvMjAyMSA5OjM2IFBNLCBKYXNv
biBXYW5nIHdyb3RlOgo+Pj4+PiBPbiBUaHUsIERlYyA5LCAyMDIxIGF0IDg6MjUgQU0gU2ktV2Vp
IExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBPbiAxMi84
LzIwMjEgMTI6MTQgUE0sIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4+PiBBZGQgbmV0bGluayBzdXBw
b3J0IHRvIGNvbmZpZ3VyZSB0aGUgbWF4IHZpcnRxdWV1ZSBwYWlycyBmb3IgYSBkZXZpY2UuCj4+
Pj4+Pj4gQXQgbGVhc3Qgb25lIHBhaXIgaXMgcmVxdWlyZWQuIFRoZSBtYXhpbXVtIGlzIGRpY3Rh
dGVkIGJ5IHRoZSBkZXZpY2UuCj4+Pj4+Pj4KPj4+Pj4+PiBFeGFtcGxlOgo+Pj4+Pj4+Cj4+Pj4+
Pj4gJCB2ZHBhIGRldiBhZGQgbmFtZSB2ZHBhLWEgbWdtdGRldiBhdXhpbGlhcnkvbWx4NV9jb3Jl
LnNmLjEgbWF4X3ZxcCA1Cj4+Pj4+PiBOb3QgdGhpcyBwYXRjaCwgYnV0IEkgdGhpbmsgdGhlcmUg
c2hvdWxkIGJlIGEgbWVnYSBhdHRyaWJ1dGUgZGVmaW5lZAo+Pj4+Pj4gYWhlYWQgdG8gc3BlY2lm
eSB0aGUgdmlydGlvIGNsYXNzL3R5cGUgdG8gY3JlYXRlIHZkcGEgaW5zdGFuY2Ugd2l0aC4KPj4+
Pj4+IExpa2UgdGhlIGV4aXN0aW5nIG9uZXMgZS5nLiBtYWNfYWRkciBhbmQgbXR1LCBtYXhfdnFw
IGlzIGFsc28gdmRwYSBuZXQKPj4+Pj4+IHNwZWNpZmljIGF0dHJpYnV0ZS4KPj4+Pj4gUHJvYmFi
bHksIGJ1dCB0aGlzIG9ubHkgd29ya3MgZm9yIHRoZSBjYXNlIHdoZW4gYSBzaW5nbGUgcGFyZW50
IGlzCj4+Pj4+IGFsbG93ZWQgdG8gY3JlYXRlIGRpZmZlcmVudCB0eXBlcyBvZiBkZXZpY2VzLiBJ
dCBsb29rcyB0byBtZSB0aGUKPj4+Pj4gY3VycmVudCBtb2RlbCB0byBoYXZlIGEgcGVyIHR5cGUg
cGFyZW50Lgo+Pj4+IFllcywgdGhhdCBpcyB0aGUgY3VycmVudCBzaXR1YXRpb24gYW5kIGltcGxl
bWVudGF0aW9uLCBhbHRob3VnaCB0aGUKPj4+PiBtb2RlbCBkb2VzIGFsbG93IG11bHRpLXR5cGUg
cGFyZW50IHRocm91Z2gKPj4+PiBWRFBBX0FUVFJfTUdNVERFVl9TVVBQT1JURURfQ0xBU1NFUy4K
Pj4+IFJpZ2h0LCBzbyBJIGFncmVlIHdpdGggeW91LCB3ZSBuZWVkIHRvIHNwZWNpZnkgdGhlIGNs
YXNzIGZpcnN0Lgo+Pj4KPj4gT3IgbWF5YmUgZmFpbCBkZXZpY2UgY3JlYXRpb24gaWYgdGhlIHBh
cmVudCBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCBuZXQKPj4gY2xhc3MuCj4gQlRXLCB3ZSBhbHJl
YWR5IGhhdmUgdGhlIG1lY2hhbmlzbSBpbiBwbGFjZSB0byBlbmZvcmNlIHRoYXQuIElmIGEgZGV2
aWNlCj4gZG9lcyBub3Qgc3VwcG9ydCBjb25maWd1cmF0aW9uIG9mIG1heF92cXAsIGl0IHdpbGwg
bm90IHNldAo+IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSIGluIGl0cyBjb25maWdfYXR0
cl9tYXNrIHNvIHlvdSB3aWxsIG5vdCBiZQo+IGFibGUgYWRkIGl0IGlmIHlvdSBhdHRlbXB0IHRv
IHNwZWNpZnkgbWF4X3ZxcCB1cG9uIGNyZWF0aW9uLgpZZXMsIGJ1dCB0aGF0IGlzIGFub3RoZXIg
bGV2ZWwgb2YgdmFsaWRhdGlvbiBkb3duIHRvIHRoZSBzcGVjaWZpYyBjbGFzcyAKb2YgdmRwYSBj
b25maWcuIEl0IHNob3VsZCBiZSBjb21wbGV0ZWx5IGZpbmUgZm9yIHVzZXIgbm90IHRvIHNwZWNp
ZnkgCm1heF92cXAgb3IgbWFjIGFkZHJlc3Mgd2hlbiB2ZHBhIGlzIGNyZWF0ZWQuIFRob3VnaCB0
aGV5IG1heSBub3QgY3JlYXRlIAp0aGUgZXhwZWN0ZWQgdmRwYSBjbGFzcyBhcyB0aGV5IHdpc2gg
aW4gdGhlIGZpcnN0IHBsYWNlIGlmIHRoZSBjbGFzcyAKdmFsaWRhdGlvbiBpcyBtaXNzaW5nLgoK
SGF2aW5nIHNhaWQsIEkgZ3Vlc3MgaXQgd291bGQgYmUgZ3JlYXQgaWYgdXNlcnMgd2hvIHdhbnQg
dG8gY3JlYXRlIHZkcGEgCmNhbiBnZXQga25vd24gb2YgdGhlIHBhcmVudCdzIHN1cHBvcnRlZCBj
bGFzcyBhbmQgY2FwYWJpbGl0eSBhaGVhZCAKdGhyb3VnaCBzb21lIG1nbXRkZXYgY29tbWFuZCwg
bGlrZSB3aGF0IEkgc3VnZ2VzdGVkIGVhcmxpZXI6CgokIHZkcGEgbWdtdGRldiBjYXBhYiBzaG93
CnBjaS8wMDAwOjQxOjAwLjI6CiDCoCBjbGFzczogbmV0CiDCoMKgwqDCoCBtYWM6IG9mZgogwqDC
oMKgwqAgbXR1OiBvbgogwqDCoMKgwqAgbWF4X210dTogOTAwMAogwqDCoMKgwqAgbWF4X3ZxcDog
MQphdXhpbGlhcnkvbWx4NV9jb3JlLnNmLjE6CiDCoCBjbGFzczogbmV0CiDCoMKgwqDCoCBtYWM6
IG9uCiDCoMKgwqDCoCBtdHU6IG9mZgogwqDCoMKgwqAgbWF4X210dTogMTUwMAogwqDCoMKgwqAg
bWF4X3ZxcDogMjU2CgoKUmVnYXJkcywKLVNpd2VpCgo+Cj4+IFlvdSBjaGVjayBmaXJzdCB0aGUg
c3VwcG9ydGVkIGNsYXNzIHdpdGggInZkcGEgbWdtdGRldiBzaG93IiBhbmQgaWYgbmV0Cj4+IGlz
IHN1cHBvcnRlZCB5b3UgbWF5IHVzZSBtYXhfdnFwLgo+Pgo+Pj4+IFJlZ2FyZGxlc3MsIGV2ZW4g
dGhvdWdoIHdpdGgKPj4+PiBzaW5nbGUtdHlwZSBwYXJlbnQsIHNvIGZhciBvbiB2ZHBhIGNyZWF0
aW9uIHRoZXJlJ3Mgbm8gdmFsaWRhdGlvbiBkb25lCj4+Pj4geWV0IGFnYWluc3Qgd2hpY2ggY2xh
c3MvdHlwZSB0aGUgcGFyZW50IGNhbiBzdXBwb3J0LiBUaGUgbWF4LXZxcCBpcwo+Pj4+IGVzc2Vu
dGlhbGx5IHZkcGEgbmV0d29yayBkZXZpY2Ugb25seSwgYnV0IGNvbW1hbmQgbGluZSB1c2VycyBk
b24ndCBoYXZlCj4+Pj4gYSBtZWFucyB0byBpbmZlciBpdCBpcyBzdHJ1Y3R1cmVkIHRoaXMgd2F5
LCBhbmQvb3Igd2hpY2ggdmRwYSBwYXJlbnQgbWF5Cj4+Pj4gc3VwcG9ydCB0aGlzIGNvbmZpZyBh
dHRyaWJ1dGUuIFRoYXQgc2FpZCwgd2VyZSB0aGUgY29tbWFuZCBsaW5lIHVzYWdlCj4+Pj4gc3Ry
dWN0dXJlZCBsaWtlIGJlbG93LCBJIHdvdWxkIGhhdmUgbGVzcyB3b3JyeS4KPj4+Pgo+Pj4+ICQg
dmRwYSBkZXYgYWRkIG5hbWUgdmRwYS1hIG1nbXRkZXYgYXV4aWxpYXJ5L21seDVfY29yZS5zZi4x
IG5ldC5tYXhfdnFwIDUKPj4+IEl0IG1pZ2h0IGJlIGVhc2llciB0byBzcGVjaWZ5IGNsYXNzIGFz
IGEgZGVkaWNhdGVkIHBhcmFtZXRlciwgc2luY2Ugd2UKPj4+IG1heSB3YW50IHRvIHNwZWNpZnkg
bXR1IGFuZCBtYWMuCj4+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4+IEFsdGVybmF0aXZlbHksIGlmIHRo
ZSBnb2FsIGlzIHRvIGtlZXAgdGhlIGF0dHJpYnV0ZSBmbGF0LCB3ZSBtYXkgc2hvdwo+Pj4+IHRo
ZSBtYXBwaW5nIGZvciB0aGUgcGFyZW50IGNhcGFiaWxpdHkgYW5kIHRoZSBzdXBwb3J0ZWQgY2xh
c3M6Cj4+Pj4KPj4+PiAkIHZkcGEgbWdtdGRldiBjYXBhYiBzaG93Cj4+Pj4gcGNpLzAwMDA6NDE6
MDAuMjoKPj4+PiAgICAgY2xhc3M6IG5ldAo+Pj4+ICAgICAgICBtYWM6IG9mZgo+Pj4+ICAgICAg
ICBtdHU6IG9uCj4+Pj4gICAgICAgIG1heF9tdHU6IDkwMDAKPj4+PiAgICAgICAgbWF4X3ZxcDog
MQo+Pj4+IGF1eGlsaWFyeS9tbHg1X2NvcmUuc2YuMToKPj4+PiAgICAgY2xhc3M6IG5ldAo+Pj4+
ICAgICAgICBtYWM6IG9uCj4+Pj4gICAgICAgIG10dTogb2ZmCj4+Pj4gICAgICAgIG1heF9tdHU6
IDE1MDAKPj4+PiAgICAgICAgbWF4X3ZxcDogMjU2Cj4+Pj4KPj4+PiBUaGFua3MsCj4+Pj4gLVNp
d2VpCj4+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4+Cj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Cj4+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4gLS0tCj4+
Pj4+Pj4gdjAgLT4gdjE6Cj4+Pj4+Pj4gMS4gZml4IHR5cG8KPj4+Pj4+PiAyLiBtb3ZlIG1heF92
cV9wYWlycyB0byBuZXQgc3BlY2lmaWMgc3RydWN0Cj4+Pj4+Pj4KPj4+Pj4+PiAgICAgZHJpdmVy
cy92ZHBhL3ZkcGEuYyAgfCAxNCArKysrKysrKysrKysrLQo+Pj4+Pj4+ICAgICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaCB8ICAxICsKPj4+Pj4+PiAgICAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+Pj4+PiBpbmRleCBjMzdkMzg0
YzBmMzMuLjNiZjAxNmUwMzUxMiAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRw
YS5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+IEBAIC00ODAsNyAr
NDgwLDggQEAgdmRwYV9ubF9jbWRfbWdtdGRldl9nZXRfZHVtcGl0KHN0cnVjdCBza19idWZmICpt
c2csIHN0cnVjdCBuZXRsaW5rX2NhbGxiYWNrICpjYikKPj4+Pj4+PiAgICAgfQo+Pj4+Pj4+Cj4+
Pj4+Pj4gICAgICNkZWZpbmUgVkRQQV9ERVZfTkVUX0FUVFJTX01BU0sgKCgxIDw8IFZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NQUNBRERSKSB8IFwKPj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSkpCj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICgxIDw8IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUp
IHwgXAo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoMSA8PCBWRFBBX0FU
VFJfREVWX05FVF9DRkdfTUFYX1ZRUCkpCj4+Pj4+Pj4KPj4+Pj4+PiAgICAgc3RhdGljIGludCB2
ZHBhX25sX2NtZF9kZXZfYWRkX3NldF9kb2l0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBn
ZW5sX2luZm8gKmluZm8pCj4+Pj4+Pj4gICAgIHsKPj4+Pj4+PiBAQCAtNTA2LDYgKzUwNywxNyBA
QCBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9hZGRfc2V0X2RvaXQoc3RydWN0IHNrX2J1ZmYg
KnNrYiwgc3RydWN0IGdlbmxfaW5mbyAqaQo+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
IG5sYV9nZXRfdTE2KG5sX2F0dHJzW1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFVdKTsKPj4+Pj4+
PiAgICAgICAgICAgICAgICAgY29uZmlnLm1hc2sgfD0gKDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01UVSk7Cj4+Pj4+Pj4gICAgICAgICB9Cj4+Pj4+Pj4gKyAgICAgaWYgKG5sX2F0dHJzW1ZE
UEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQXSkgewo+Pj4+Pj4+ICsgICAgICAgICAgICAgY29u
ZmlnLm5ldC5tYXhfdnFfcGFpcnMgPQo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBubGFf
Z2V0X3UxNihubF9hdHRyc1tWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUF0pOwo+Pj4+Pj4+
ICsgICAgICAgICAgICAgaWYgKCFjb25maWcubmV0Lm1heF92cV9wYWlycykgewo+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICBOTF9TRVRfRVJSX01TR19NT0QoaW5mby0+ZXh0YWNrLAo+Pj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkF0IGxlYXN0IG9u
ZSBwYWlyIG9mIFZRcyBpcyByZXF1aXJlZCIpOwo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICBlcnIgPSAtRUlOVkFMOwo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsK
Pj4+Pj4+PiArICAgICAgICAgICAgIH0KPj4+Pj4+PiArICAgICAgICAgICAgIGNvbmZpZy5tYXNr
IHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApOwo+Pj4+Pj4+ICsgICAg
IH0KPj4+Pj4+Pgo+Pj4+Pj4+ICAgICAgICAgLyogU2tpcCBjaGVja2luZyBjYXBhYmlsaXR5IGlm
IHVzZXIgZGlkbid0IHByZWZlciB0byBjb25maWd1cmUgYW55Cj4+Pj4+Pj4gICAgICAgICAgKiBk
ZXZpY2UgbmV0d29ya2luZyBhdHRyaWJ1dGVzLiBJdCBpcyBsaWtlbHkgdGhhdCB1c2VyIG1pZ2h0
IGhhdmUgdXNlZAo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4+Pj4gaW5kZXggZGIyNDMxN2Q2MWI2Li5iNjIwMzI1NzM3
ODAgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+Pj4+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4+IEBAIC05OSw2ICs5OSw3IEBAIHN0cnVjdCB2
ZHBhX2Rldl9zZXRfY29uZmlnIHsKPj4+Pj4+PiAgICAgICAgIHN0cnVjdCB7Cj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgIHU4IG1hY1tFVEhfQUxFTl07Cj4+Pj4+Pj4gICAgICAgICAgICAgICAgIHUx
NiBtdHU7Cj4+Pj4+Pj4gKyAgICAgICAgICAgICB1MTYgbWF4X3ZxX3BhaXJzOwo+Pj4+Pj4+ICAg
ICAgICAgfSBuZXQ7Cj4+Pj4+Pj4gICAgICAgICB1NjQgbWFzazsKPj4+Pj4+PiAgICAgfTsKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
