Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5194FC4332F
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 00:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE8BC606CB;
	Wed, 19 Oct 2022 00:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE8BC606CB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=QLO/hS5+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=sG3b3lv/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHWDaWVuByLL; Wed, 19 Oct 2022 00:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF97261136;
	Wed, 19 Oct 2022 00:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF97261136
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78AEDC0032;
	Wed, 19 Oct 2022 00:40:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B627EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BB1783E80
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:40:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BB1783E80
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=QLO/hS5+; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=sG3b3lv/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oSYWy-nRAOY6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94D9983E7D
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94D9983E7D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 00:40:13 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29INiTra025375;
 Wed, 19 Oct 2022 00:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tpa19C/Y+CSf5NzFcvN5waLvC7pbfqYjnLSm/qij2dI=;
 b=QLO/hS5+GJ8c2128yz0x/lSWN2bQD0RwQ7eny1RsfMt1y+9vMSQo1h0UouvcBh/2BUYg
 x++fWHsCn0ZQoYKWMse8t+yvHWhIRYWtGvqTPzbGQiN0cmZFZElA61C3HB3tGtYMyEHp
 XGkoRdO9ReNM1msx5y7gRwxtAccWb+H0r7DiFErz1wULJy+/5q6rmm081z1ialJgkZ35
 0vGkylvTFTPSPE5/GqNg+ECtd+OPfnp3WhWlO9xAd9AC+S+nd85RRRKq0NLg25H7qF02
 pPXLh7ucL1qInWXjDGBNB3vIw4GRSTo/fUfTIvHtnkNFpLAMYXV2DiIZ3KJnFNqhpZ64 oQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww41td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 00:40:12 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29ILr9tL024452; Wed, 19 Oct 2022 00:40:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3k8hu6y7n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 00:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzpFDDwbNY20NBmtkhLJmesq2qdU4xabI6GITUX+b7ZPPzs6QKQnuEi2LNPkDSWwSMB509wYbDYoUNxxS/+C2U/RSt2q+9kkNRGuEHRL55a0rFwrKJGYNJqDP5ACSBgbtw1y8wGNLGWkwRAWmIlhIbYcfFOWurWQBHAXabQoJxBfroCValJR+hChAW8gT1aLK9JK3DLPeJxBtzmis48MTyuYGDHS/5Vip0ElRXjxEkH9dOBnugqUYRaRHcb7Lcl3tTzuqu0fBN106805zbIBSCoBe9XE2r1KdE71gHoPZ8kH3hNOpK7PmxuUV1mruTHhiqCM7ZklqHaqera9jgURHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpa19C/Y+CSf5NzFcvN5waLvC7pbfqYjnLSm/qij2dI=;
 b=avMGuKFcBvNJakaC01BL9piAAvmqtbc3soWPJvbSxwaY6pk0y8STHwrje8rj7IihQqfaNPGctTf2zZq49dpLg6dORDk1lM/0oag9UsjyWRoM89P4v+SBFM9ZlnpbYljmF9WLNyaibMh7rIeiFnUtagkcaPuP/U1wfoDwNckVdp2+TW0nksBv1X0tCRa9txhItdjfMqOGrva2AuGGPT26ZAUzHKoZpVkH0kFl219JYP7YVmkCwonEwjMrGsFCJubfwksMrj4XCu4TiiDRa5ldhnSt2s2N6Kyp2jC2zZBNzw44dXQqwxGFMwk9qSHUe4Pi5SSG27AWcIJghPFbZJn/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpa19C/Y+CSf5NzFcvN5waLvC7pbfqYjnLSm/qij2dI=;
 b=sG3b3lv/N67gyr4dHVA/D6ZtBN72A5SXI7K7N7Yfp2uQLotBPoVZnn7/p8eixprYTmnbRn1CevhGTs+prdJ3S3UfxWvDhyS4Lqu0NER5BBA+Sn7O15sJmSluRBSb6BAlVsY3G0GdU5SnHwSxtLMJ2RrDFfM/DVNknKq036mo+u8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB6490.namprd10.prod.outlook.com (2603:10b6:930:5e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 00:40:10 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 00:40:09 +0000
Message-ID: <5c0691e8-fbf4-c77f-918b-c7fef91e850b@oracle.com>
Date: Tue, 18 Oct 2022 17:40:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
 <4f76d968-3086-0280-48fc-fcf250f11c67@oracle.com>
 <CACGkMEs6tsPUsoP1TmEB3metqCHQF-i95G+oP3koJGAOS_5PWQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs6tsPUsoP1TmEB3metqCHQF-i95G+oP3koJGAOS_5PWQ@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acd01da-76ad-454f-a98c-08dab16a79de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1mDMMSsdpfP2XlyyQ2zged2dm0444r8/sXUOlslX61HX9sJpvalgL/I5TUl8JrRaW2o/w7uZFwBrs+RF5FhOvKOv4dIGG6dAecHijDlxZtdGNEnf3tL5HVFGHhF/8Glqfq932QosRiXqFVK67aQeti1TxUO87gBADpgvdldnZSmaUzcXYTrLbQFjK8vgN10hS8A3W8h0pRASSq+coI2qupuwLf1qpOTt4SjA6+9xTNhHWBOE9tzwteobuUK9vlGPc2md90/Noq3/IWdpYwBx0DmNfsnEWFyhBxlhsb0cDbWdMpggNtiMXRaFYF2citFksDcyZ3eXwuUpsx1x+4HXhfYzMxgwAf5L5N2nRy9hz0AOk/SKqb39rrj73sf03AfeRMBi4zpaS2gmCCPFVsNuxCssoHvNMe2wauv5O4ChcRFDRhcJt2A138wCJ9xc+/+udEVzYSMfq3wgiFbshL7i5NK8k829XWzMK0Gi7Q7QN16Oy4Ms7M9Hn1nH4R2XFrqQ+8BH9S9EmGg8aFVXGdR1dxws3TT0a046T8qIFL2HDqMqxZ8za2D3m1NzdzXHvFd7txK+wu5+K+dww6qjMHfhoF386PyfV3g0YzbfgLzJLEB2SoyTEZkQ1DCjeU+I7rl9phOdNC4vekGRKzJTgZ4ljzFywHw6luyqcla3111Hu+wW29nThtRLLu6Ttv4U77XaAxtC0MIJiYd0gocb9EUlXGtN6Ig0Qnmn7rYGbvZ2T1Pn8QbkosZ/iMKbqjMKK4ekTmxav9oSuCl4squtWkIj8QUpFihXVqquG+9QLOMbI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(31686004)(6486002)(478600001)(83380400001)(54906003)(6916009)(316002)(33964004)(186003)(36916002)(6506007)(38100700002)(8676002)(4326008)(30864003)(66946007)(66556008)(66476007)(86362001)(36756003)(2906002)(6512007)(8936002)(2616005)(26005)(41300700001)(53546011)(5660300002)(6666004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdNQ0FFTTJITWlUVmNuYTZRSVBPUUtBT1h4cTUwcmI3WWVMbUZoc0ZJYkdE?=
 =?utf-8?B?akVYMUFPdkVkdkFYWWZ2UU1FMGc1WlJncHRndExzVlhYZnVQOW9TTGczRzEv?=
 =?utf-8?B?Q2lYanNVaUZOOUhaTDJ4R3VJZW1NaHVaSVo3YTdncm9rWmFieWV1RXdmL04w?=
 =?utf-8?B?SGhrZitDTVZZV3Y5ZlNJdGtOVWhmTUpTcWZkcDMxbC9FYzZQVmRhWFZQYWJS?=
 =?utf-8?B?SjVRQmptdmlkMENrZ01KdVozUWluTHhBeWVZa1k0TGFRSWlZZHVXR1NhWWRo?=
 =?utf-8?B?RTRmNytTVnhhdmVrS0tsUGF6WkU5M2NGcGxIeWt6RE1IZlFjTDRpZEYzN081?=
 =?utf-8?B?TDU0SmFCVFpsZFA1aFlFTzY0N1B1WEIwVjJZLzFnYUg4dnFXNjJEYkxHbGFN?=
 =?utf-8?B?RnhabDR1NXpKVzVaeTI3NTZwT2pwQWNtWktJWEd2aGpNbVhaRlBJRGtEOEJn?=
 =?utf-8?B?cEE1ak41NzhzOTRRN0xBSjZkbnpUZ1pobTRuWHdXV0J6d2V1eTBQc0orK2tI?=
 =?utf-8?B?NlBDMSszZEJCcnZzWlo5UmMxTmNST3lkMUpYdEVyckZIbGZQOVhwdHFXMnR1?=
 =?utf-8?B?Zmdmam9HSnBwN0dlTEtBeXBpS1Nxa1FBWFBRMHM3Y2t6dmZER0VQSG1YN0Ex?=
 =?utf-8?B?V0h6d1I3WDVFVVhBc21EcmdsSTRHcW5xaWljbkZXaWRsMzFkWmZtckl5eFls?=
 =?utf-8?B?cU90cmxGTFlrT3ljdlA1dzkrSFRzdTN5cWZWUUJrc2FUcUNOMm5UR016RUdG?=
 =?utf-8?B?NmhhRmRJTkUyRnRjbGd2QTB6OTA0U0xOZEdrVzRBOVkwUjJYRTdHMU9BSG90?=
 =?utf-8?B?eUV5clhsSnhRYkIzVGJnTmJrMkVJVmgzcE94T3VHY2s4MklSdEpWNXI5ODJE?=
 =?utf-8?B?QjN0NmZRRGwxdndEbDIrcUdsSDNhSExydDh5VitDdnpDUXVxSDQyZDFXWGZI?=
 =?utf-8?B?SzFJN1dUTFBvaVlsUWFyU0kyclJCdU5jekhWNitxSUQxeFgwNXZOaXhkKzBU?=
 =?utf-8?B?UU4rL25TNjZMM1laU1BDQ3dxc3lvY3dTelFhRGl2bXFyaENnZDJLVEdIUlFW?=
 =?utf-8?B?RGxHcmpQVElPSUVOQmlPQjBhUzkzNFRJM2pKYWZWMWNKZjBxMFBISVlQejVy?=
 =?utf-8?B?eWZ3d1hWQVNWMERIWko0ZEhWT0JqTkM2dHVybDBCT1pZdmVlZ3RFTUkwLzF5?=
 =?utf-8?B?V0JGOUl0Q1V4N2RIZzhKVGppOGRqd1lHUThudEtobkRjWW91NWxFdWxtWUVE?=
 =?utf-8?B?RVprcnVtcnl6c3VZVWVFWi9PR2phWUs1TVlSN0VZSjFmTUd1RVpkUGpxQ0F0?=
 =?utf-8?B?RWZQREhhNUI0bmp6TXlqd1hSNTlsNHVVdm1KQmM5WC93NTBhWVVQVitJc3JR?=
 =?utf-8?B?a2N5VXFBWC96bVFTRHhJNllSUG41WmR4dFV3TGUyRTBteFptbU02dS83VHQx?=
 =?utf-8?B?Q2RyNWZxWTljS3pvdjE1UmVqdWdzSjQvZFFTd3FyQjJIbzFZREkvV3VEMTFn?=
 =?utf-8?B?VXdIMEU4QlFwbFIrZHpVaktTdmpid3doMnBtd3pLTGM5S1Q2RUxFVWdBRnIv?=
 =?utf-8?B?ejhKd2xYQkczV1g4U1RNcEE5ZGNSb0ViYkUvZ1ZpaGhMT3NmMWJibHdibDJS?=
 =?utf-8?B?K0RhZUp1WmVOcE1ZUURsdUFUeS9GMER5TXd0OXc3VEgySHFmS2hMTmQxNVdi?=
 =?utf-8?B?ckg3NGpXTUoxSDlVdlRBWnZJTlFncSsxT21DT2ovV2JJRGV6SlhsSEhCbmtD?=
 =?utf-8?B?aDlpUGEzeDdmcE80N09uOWNreGp2MllIREs0bXRrQ0YvRXkwYjdpUkkxTExY?=
 =?utf-8?B?TWJnU1I0R1ZvRWtxbnFPWGxnUy9YeTY0WHk1UWExSmhIeTViZG5tMjlKWS83?=
 =?utf-8?B?UHo5b3RmMjMyTFpXU1pzR3M4SzFTb3hPRDFjbkpOQ0JyR1VnWlZzUzhzS0cw?=
 =?utf-8?B?NVlXTk5xZmx6ckJmOG83WVNFRk1UdDRZR3hqUnVqWXpxWEpCZlBlUGRQZmUy?=
 =?utf-8?B?czJWVTR5dDZCOUNha3JRMklDYnlCUG93N21yVU1EVGtqSUoxRis1SndHUmtQ?=
 =?utf-8?B?eUhkc1MzdTV6OWZxVmZ1Z2NwNXpLNDlydm5Rb1c3ZG4zQXE3VHFwNmpEZ0Yw?=
 =?utf-8?Q?8vU/aoYDQCiVMHojNCn6gjIMC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acd01da-76ad-454f-a98c-08dab16a79de
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 00:40:09.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztjoI9jIMvvdhDTNpVJ8lKRO+F1eqKoNbPtgWSOduacWvBjd0Uib3pIKCXtiBLDaXBg8SNeWTn4b7zVqmGO60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_09,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190001
X-Proofpoint-GUID: -Vb-dW7y1VRIBm_MFrmVw-eOXKkZCYQX
X-Proofpoint-ORIG-GUID: -Vb-dW7y1VRIBm_MFrmVw-eOXKkZCYQX
Cc: Sean Mooney <smooney@redhat.com>, virtualization@lists.linux-foundation.org,
 Daniel Berrange <berrange@redhat.com>, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============4251433472337724457=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4251433472337724457==
Content-Type: multipart/alternative;
 boundary="------------20NUoKN2kV3a7sQquPSiawrv"
Content-Language: en-US

--------------20NUoKN2kV3a7sQquPSiawrv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/2022 1:41 AM, Jason Wang wrote:
> On Tue, Oct 18, 2022 at 6:58 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>
>>
>> On 10/17/2022 12:08 AM, Jason Wang wrote:
>>> Adding Sean and Daniel for more thoughts.
>>>
>>> On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>>> Live migration of vdpa would typically require re-instate vdpa
>>>> device with an idential set of configs on the destination node,
>>>> same way as how source node created the device in the first place.
>>>>
>>>> In order to allow live migration orchestration software to export the
>>>> initial set of vdpa attributes with which the device was created, it
>>>> will be useful if the vdpa tool can report the config on demand with
>>>> simple query.
>>> For live migration, I think the management layer should have this
>>> knowledge and they can communicate directly without bothering the vdpa
>>> tool on the source. If I was not wrong this is the way libvirt is
>>> doing now.
>> I think this series doesn't conflict with what libvirt is doing now. For
>> example it can still remember the supported features for the parent
>> mgmtdev, and mtu and mac properties for vdpa creation, and use them to
>> replicate vdpa device on  destination node. The extra benefit is - the
>> management software (for live migration) doesn't need to care those
>> mgmtdev specifics - such as what features the parent mgmtdev supports,
>> whether some features are mandatory, and what are the default values for
>> those, whether there's enough system or hardware resource available to
>> create vdpa with requested features et al. This kind of process can be
>> simplified by just getting a vdpa created with the exact same features
>> and configus exposed via the 'vdpa dev show' command. Essentially this
>> export facility just provides the layer of abstraction needed for virtio
>> related device configuration and for the very core need of vdpa live
>> migration. For e.g. what're exported can even be useful to facilitate
>> live migration from vdpa to software virtio. Basically, it doesn't
>> prevent libvirt from implementing another layer on top to manage vdpa
>> between mgmtdev devices and vdpa creation, and on the other hand, would
>> benefit light-weighted mgmt software implementation with device
>> management and live migration orchestration decoupled in the upper level.
> Ok, I think this is fine.
>
>>>> This will ease the orchestration software implementation
>>>> so that it doesn't have to keep track of vdpa config change, or have
>>>> to persist vdpa attributes across failure and recovery, in fear of
>>>> being killed due to accidental software error.
>>>>
>>>> In this series, the initial device config for vdpa creation will be
>>>> exported via the "vdpa dev show" command.
>>>> This is unlike the "vdpa
>>>> dev config show" command that usually goes with the live value in
>>>> the device config space, which is not reliable subject to the dynamics
>>>> of feature negotiation and possible change in device config space.
>>>>
>>>> Examples:
>>>>
>>>> 1) Create vDPA by default without any config attribute
>>>>
>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>>>> $ vdpa dev show vdpa0
>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>> $ vdpa dev -jp show vdpa0
>>>> {
>>>>       "dev": {
>>>>           "vdpa0": {
>>>>               "type": "network",
>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>               "vendor_id": 5555,
>>>>               "max_vqs": 9,
>>>>               "max_vq_size": 256,
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> 2) Create vDPA with config attribute(s) specified
>>>>
>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>>       mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>> $ vdpa dev show
>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>>     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>> $ vdpa dev -jp show
>>>> {
>>>>       "dev": {
>>>>           "vdpa0": {
>>>>               "type": "network",
>>>>               "mgmtdev": "pci/0000:41:04.2",
>>> So "mgmtdev" looks not necessary for live migration.
>> Right, so once the resulting device_features is exposed to the 'vdpa dev
>> show' output, the mgmt software could infer the set of config options to
>> recreate vdpa with, and filter out those unwanted attributes (or pick
>> what it really wants).
> Ok,  so I wonder if it is this better to have a new command instead of
> mixing it with "dev show"?
>
> Or at least have separated key for virtio like
>
> "vdpa0": {
>       "mgmtdev": "vdpasim_net",
>       "virtio config: {
>            ....
>        }
> }
Yep I can put it under a separate key "virtio_config". I slightly prefer 
not introducing a separate command as there could be other dev related 
info (such as type and mgmtdev) needed for identification or reference 
purpose in a single inquiry.

Thanks,
-Siwei
>
> Thanks
>
>> -Siwei
>>
>>> Thanks
>>>
>>>>               "vendor_id": 5555,
>>>>               "max_vqs": 9,
>>>>               "max_vq_size": 256,
>>>>               "mac": "e4:11:c6:d3:45:f0",
>>>>               "max_vq_pairs": 4
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> ---
>>>>
>>>> Si-Wei Liu (4):
>>>>     vdpa: save vdpa_dev_set_config in struct vdpa_device
>>>>     vdpa: pass initial config to _vdpa_register_device()
>>>>     vdpa: show dev config as-is in "vdpa dev show" output
>>>>     vdpa: fix improper error message when adding vdpa dev
>>>>
>>>>    drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>>>>    drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
>>>>    drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>>>>    drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>>>>    drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
>>>>    include/linux/vdpa.h                 | 26 ++++++++-------
>>>>    8 files changed, 80 insertions(+), 22 deletions(-)
>>>>
>>>> --
>>>> 1.8.3.1
>>>>

--------------20NUoKN2kV3a7sQquPSiawrv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/18/2022 1:41 AM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEs6tsPUsoP1TmEB3metqCHQF-i95G+oP3koJGAOS_5PWQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Oct 18, 2022 at 6:58 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">


On 10/17/2022 12:08 AM, Jason Wang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Adding Sean and Daniel for more thoughts.

On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Live migration of vdpa would typically require re-instate vdpa
device with an idential set of configs on the destination node,
same way as how source node created the device in the first place.

In order to allow live migration orchestration software to export the
initial set of vdpa attributes with which the device was created, it
will be useful if the vdpa tool can report the config on demand with
simple query.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">For live migration, I think the management layer should have this
knowledge and they can communicate directly without bothering the vdpa
tool on the source. If I was not wrong this is the way libvirt is
doing now.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I think this series doesn't conflict with what libvirt is doing now. For
example it can still remember the supported features for the parent
mgmtdev, and mtu and mac properties for vdpa creation, and use them to
replicate vdpa device on  destination node. The extra benefit is - the
management software (for live migration) doesn't need to care those
mgmtdev specifics - such as what features the parent mgmtdev supports,
whether some features are mandatory, and what are the default values for
those, whether there's enough system or hardware resource available to
create vdpa with requested features et al. This kind of process can be
simplified by just getting a vdpa created with the exact same features
and configus exposed via the 'vdpa dev show' command. Essentially this
export facility just provides the layer of abstraction needed for virtio
related device configuration and for the very core need of vdpa live
migration. For e.g. what're exported can even be useful to facilitate
live migration from vdpa to software virtio. Basically, it doesn't
prevent libvirt from implementing another layer on top to manage vdpa
between mgmtdev devices and vdpa creation, and on the other hand, would
benefit light-weighted mgmt software implementation with device
management and live migration orchestration decoupled in the upper level.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ok, I think this is fine.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">This will ease the orchestration software implementation
so that it doesn't have to keep track of vdpa config change, or have
to persist vdpa attributes across failure and recovery, in fear of
being killed due to accidental software error.

In this series, the initial device config for vdpa creation will be
exported via the &quot;vdpa dev show&quot; command.
This is unlike the &quot;vdpa
dev config show&quot; command that usually goes with the live value in
the device config space, which is not reliable subject to the dynamics
of feature negotiation and possible change in device config space.

Examples:

1) Create vDPA by default without any config attribute

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
$ vdpa dev show vdpa0
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
$ vdpa dev -jp show vdpa0
{
     &quot;dev&quot;: {
         &quot;vdpa0&quot;: {
             &quot;type&quot;: &quot;network&quot;,
             &quot;mgmtdev&quot;: &quot;pci/0000:41:04.2&quot;,
             &quot;vendor_id&quot;: 5555,
             &quot;max_vqs&quot;: 9,
             &quot;max_vq_size&quot;: 256,
         }
     }
}

2) Create vDPA with config attribute(s) specified

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev show
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
   mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev -jp show
{
     &quot;dev&quot;: {
         &quot;vdpa0&quot;: {
             &quot;type&quot;: &quot;network&quot;,
             &quot;mgmtdev&quot;: &quot;pci/0000:41:04.2&quot;,
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">So &quot;mgmtdev&quot; looks not necessary for live migration.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Right, so once the resulting device_features is exposed to the 'vdpa dev
show' output, the mgmt software could infer the set of config options to
recreate vdpa with, and filter out those unwanted attributes (or pick
what it really wants).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ok,  so I wonder if it is this better to have a new command instead of
mixing it with &quot;dev show&quot;?

Or at least have separated key for virtio like

&quot;vdpa0&quot;: {
     &quot;mgmtdev&quot;: &quot;vdpasim_net&quot;,
     &quot;virtio config: {
          ....
      }
}</pre>
    </blockquote>
    Yep I can put it under a separate key &quot;virtio_config&quot;. I slightly
    prefer not introducing a separate command as there could be other
    dev related info (such as type and mgmtdev) needed for
    identification or reference purpose in a single inquiry.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:CACGkMEs6tsPUsoP1TmEB3metqCHQF-i95G+oP3koJGAOS_5PWQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
-Siwei

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">             &quot;vendor_id&quot;: 5555,
             &quot;max_vqs&quot;: 9,
             &quot;max_vq_size&quot;: 256,
             &quot;mac&quot;: &quot;e4:11:c6:d3:45:f0&quot;,
             &quot;max_vq_pairs&quot;: 4
         }
     }
}

---

Si-Wei Liu (4):
   vdpa: save vdpa_dev_set_config in struct vdpa_device
   vdpa: pass initial config to _vdpa_register_device()
   vdpa: show dev config as-is in &quot;vdpa dev show&quot; output
   vdpa: fix improper error message when adding vdpa dev

  drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
  drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
  drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
  drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
  include/linux/vdpa.h                 | 26 ++++++++-------
  8 files changed, 80 insertions(+), 22 deletions(-)

--
1.8.3.1

</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------20NUoKN2kV3a7sQquPSiawrv--

--===============4251433472337724457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4251433472337724457==--
