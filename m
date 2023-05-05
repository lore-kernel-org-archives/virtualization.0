Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84159C77B7C
	for <virtualization@archiver.kernel.org>; Fri,  5 May 2023 22:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0B1A840D5;
	Fri,  5 May 2023 22:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0B1A840D5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=FU3GJwYf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=XcsrTwrX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spEv-mjy3AnM; Fri,  5 May 2023 22:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 30A2C840C9;
	Fri,  5 May 2023 22:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30A2C840C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1307BC0037;
	Fri,  5 May 2023 22:38:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7273C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 22:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7916060AE3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 22:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7916060AE3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=FU3GJwYf; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=XcsrTwrX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THQug6cpkUub
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 22:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C23E60A9A
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C23E60A9A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 May 2023 22:38:02 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 345Hh3Ie029130; Fri, 5 May 2023 22:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=o3ri/9C8+6fXq73K+OmRcN9+dFFMjczy0SIBgI71+KM=;
 b=FU3GJwYfhPuq/oCXspX6QSiVdEl0ZYuh/8sqK1HTttFMvNHBX/IYF0QsO3jwYr1EDU5A
 +UtHrMjVZk+18kB0IzS0OQ+1f1xT+YTQvw4liXlJn5Nxs3nzjcuEXEKPVFT816lZjOKa
 HMkCu1E1V6M9d3mZ6U2Qlq0dMSPwG5DRXxb9HbUoEMwm8bdi/pnUcJMDt9lgod4tXKcc
 EPYkkQ6ToVmKmSZzOys/rHUXQi5cItyhAgPQ7calhHTr2PAV0oq7YCd0NUpC2auW7Pn2
 27jhzSWvocM5nWekMfQbO4yqKj5AtwX31MG3KUCJIpwxeE3jrwJjfZ9jQJlYVdcdQ4wH DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1wvcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 May 2023 22:37:52 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 345M0ZcX026747; Fri, 5 May 2023 22:37:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q8spgqgt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 May 2023 22:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGLiRiaQdu3zy1Vo2kD6IhXoq22L8IeuRcyFpIM1r6PGTye6GoGMfyNIJGpP0m67sKD07/vQ9/scXxMdD2emMFof+iioa3IuW3vS/IsSyARr5YNTmdj0zKQlu9zJv5kCLo8iSe4IKHFpy1JPe3MmK/iFcTZXMBZtcRh0u3q0Go2PkdcgVrUA3myvD3wpCLr2wx/xHNCrz8t+5rohW1B0Uf9mKO5FfYZAf380GP3wqAVAXhPmAgs8fNP40cAix+D4S0OkAS0WYwjRd7g4A2EnvqFgDuO1kOSRyrEd877nV+k0/36AfgLQyNgr3/FEXuMkRqyzkEYkjsgu8AO0fAMV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3ri/9C8+6fXq73K+OmRcN9+dFFMjczy0SIBgI71+KM=;
 b=dXTaYYDnAIcuKaREclgRONe4ZUEhp4WxXOfSUQHK2+S12lObD8MqJfNfFLLb7A3rvWCr70ptoSoRHcruhzCk/sr3e88YZDcUf7ocGYTFgvCh/BDu19qZXrcoBMjWKy2vtZpAuyikH9vXp5i0pmX9YgqMStEXkrTlf8D1BVxflSEspdlH3md8mC9cQdosra42ASSckq4osi7FyxsUiBKM8PZCLPTRQ35Uxh0iRyLX1XkO/9impPYq8JOy0YHhVjGbvIZwfDUL2a+seLDajrAusp26RsQUUuUHgLipBxWLbL9GUxDMw8yyaEqMbAZwHkWYdJy9/r5aq7jOOZvklS4qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3ri/9C8+6fXq73K+OmRcN9+dFFMjczy0SIBgI71+KM=;
 b=XcsrTwrX5s07Jj4O+172mgYcxk4DuoPjkj9hwY6i78S0mw+KYDtIPWOP3Aj7AkEOCeUwm+zqIJFBcVALtPGsxj4zFzSkD7UDQZHwrgx7DtW8qsI/mh80zlMCWz9DgUjAzGvAY13n6qEtipK85kn9sWTwrTj7xTL2O/8y8pC2JNY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 22:37:49 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::264c:5118:2153:91ef]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::264c:5118:2153:91ef%12]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 22:37:42 +0000
Message-ID: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
Date: Fri, 5 May 2023 17:37:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Linus Torvalds <torvalds@linux-foundation.org>, nicolas.dichtel@6wind.com, 
 Christian Brauner <brauner@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
X-ClientProxiedBy: DS7PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:8:56::15) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: af943cd4-0093-461b-178f-08db4db95680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsNHjkKiSVZa3FaqunBtcFU1EQx6Lb8VhAHZHbgkZrohZDkluKl1XggWyo4KPreNi19HnElhRvbhuayKXJvtKMyQQqNk0lqKw/C/K7BT6JcM4elkPR9+3/5eAM5V1MKLIKjTWavup52Uh1JJAn9wXdcAkugHM8wBOEI0MiqoDjR5mfKeyJZ/sw2EhUPe/Ov+70glVhwnPr5IRSKzqj2zFmhodfsnUgG3zra7J2Z+BPuhGEYsoCNwWN4Zd/Z3tlZKDhx2RSzt7Uv3Sm0iG2LEbWWn9R5rTJ9ApIcenlgpLEaRiavtVo1KqkcB2myggdwLfm9GgvflPDoatBIGAmOcRIX0i8Vjj/A3bl4cpZuFHNN9O25Iq83Zmk3cRXHu5HIUR63wti5Gl9/ETf+onE9x0BIxxmMkXjokvjXrZdohB0Jmuwd2B/uGL+f8CczTk+dYwIFM5GogULL10qMFJFTQpYZPBpWmhoV4jDJF35T30AgJkf/6LBjQ8hOIb+Ecr3mgHXnzKtIxpDxcyYg6RMLBzw05R6efgP7Zu+hVaehofHKvS405mwpjnbx92QLf9VQs7gseqeOH3t2tmpfAU2JqpADK4vMQ+8mrawcwcgQ5NvY3Hmwki+E86XQzsbzYMphuDEHKRebW6jQ3diXXch9nAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(31686004)(8676002)(6512007)(6506007)(26005)(2616005)(8936002)(53546011)(7416002)(2906002)(83380400001)(186003)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(316002)(110136005)(41300700001)(5660300002)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtlNHIwNnhkNXk1NTRjUHpYSXFxOU5zaU9RNUlFK1NiVmxDc05RZldXWExh?=
 =?utf-8?B?SGJrRG5FN2M0Ym5xYjhiOFRYR3c3WEdET016Y0dlQkhqTCtIZzRQMXJoTmVV?=
 =?utf-8?B?d3E2UWo2QTRmOElQN1p1QndJblVSMC8ySDVHbGIyMXJOeUJ5WllQa2kyV2ky?=
 =?utf-8?B?eEthckhjeHJyb0FPY0EyNEE2MngvTjFZVktRdzJTODMzQzkwamZheDRpdWZu?=
 =?utf-8?B?RXlKYUl5YkRpcnFNcE1NMkhUcTVlajJJWlBEeG1sTXRpbEZSQXZpZm9IS2xS?=
 =?utf-8?B?eUl2SVltMTdKN2tTMGpVRUpUSW51Sll2MWtUNDFad3Z4SlNaVmJCbnA3Qnhk?=
 =?utf-8?B?L3p1SHdRYVNpS29LTkNGbW9Ed01EUWNoRktuejYwS0RIbzFsZ0UxYmM5Sll6?=
 =?utf-8?B?S0czZGJOZ3J2S2JERStIWTZ6RHY1Nk4vMkVsbk1ETWhWN2xTaWZDWVh3VmFi?=
 =?utf-8?B?V1ZNWWs1OFdBV3IvVitCRVRMM1llcFEvWlhHRFJSTjJRWTRheitrMnkvM0pH?=
 =?utf-8?B?aUYrMnBSTitkSFRNMllpMGNXVklzMG9kdzcydE95elZ0OHYwd1dUOFZvbHhQ?=
 =?utf-8?B?NVc4dlBQNXVMUzhXYnJaNzFIWjBua2ZzRnQ1R0NLNTB4WHBjZXRvT2liWmhK?=
 =?utf-8?B?Qnp4bU40YjRnOXhrbHBtQWhTV3J5U1lkeFNaSW4vWklCbG85emJOTXFSWG9C?=
 =?utf-8?B?ME5GTkhSaVphb0lndXNIdExVdEgrZnl2RFVhdkVvbW5pVkV5UTUrTHpIVzBV?=
 =?utf-8?B?eDJ6SWNFNS9LNWgzTEF5a0V6WDZUUVk3TmkvcXI5eU5BcHFVYU53ejFEUnRp?=
 =?utf-8?B?MXNRNENPaGVxQWpNbytDdml6THZ1eGRiU3J5a00yK05VaVJqK0ZhaVU4YjNO?=
 =?utf-8?B?eWU0QmNKOUZ5eFVDMEE0WGdLdXNhdFV4VHVHWW90Zmc5VEtWb3pmeW42U0to?=
 =?utf-8?B?UFJudlNmenFyUENITDNuOFhNSXVweElCZVR5ZzdWTDRlczNtWlR0K0dBcFpm?=
 =?utf-8?B?K08xSjlGelFQTm9HbWdHeWIxOE5xYWdzNnJpY3lZRkxxQTJGUmwrM1FkdFg2?=
 =?utf-8?B?WVEyN0JtcVowRnhheHZDcDdQdHdSbU5HNmpwS2FCbDNLTjlQREsvMVFzNXlP?=
 =?utf-8?B?NDJUYURkd0gyZm9DOGtwMjlGM1BQWlRmc05lSVhhNXh4VEpBTXc4M2xZR3FU?=
 =?utf-8?B?WGlQZ2p6UzlHMjNzeGxRMkEzY0tsN28xNkU5YjF0b2NCeksvOHFCRzBwdGVr?=
 =?utf-8?B?blRLb3hTa280dlZOYm1Jc1Y1Z0psT09DcTRaeTYrdFJSSGNwZzQza1lRVDhF?=
 =?utf-8?B?aXBCZjBZN1k2cEFhWVVaNEh1ZlBzVmJxeGhwNVViSXFEMTNPNEtQS2x5T1Bh?=
 =?utf-8?B?RitqdUc2Nys0UFZ0UzIvMHI4ZjROYytmMTR3OGpMS3liRGpzMkdZNUFTWEx4?=
 =?utf-8?B?MlNWTVJjRWxXNmpVcHlVOU5sWCtiaFR4SDZ3Z2RNdkRtcnJpclZEUGVDdTY3?=
 =?utf-8?B?TEp5YVRsUm1RMWxYb0psVzdFSmk1eXB5cy9DZFFrSzdwb1pIK25WTEk2L24r?=
 =?utf-8?B?ejU0NmVhUUdNN2hWYkR6MUVFNk5FMlFNS3JveFJIVUFTWCtzNU1QSkc5VXFk?=
 =?utf-8?B?MENNS2hKd1VNYkVndTVmeTk0Rm9GV3l6ZW4zQjdEK0grMHlRRC9DK3ZNUFgx?=
 =?utf-8?B?dXFxSHdWTXhuWFV0R0ZhQTdoTVhpcW9MRTgxdTlvQXBoOVQ0cFFTeUI2Wklv?=
 =?utf-8?B?akt2dmc1ckkvTGJ0Mlc2TUhqbk5leTBlTU1GRERqcDB4ZFJWbXRCQ1hodUFD?=
 =?utf-8?B?eGI5QjJrczZ3bldtQzk5dXdrRXBWbS9qS0RKaWRwL05lblNpNDQ1bmRSbWJ3?=
 =?utf-8?B?bEZLN284V2xvZG8yWEVDZmNsNi9BRzBkTXJ5ZmdmV3JMUXEvaFJ4YzdoOTdB?=
 =?utf-8?B?bUE4cWxPMkxXYkQrT1NVeG5JY0Fiek1IVlQycTJTSjhPZWM1Y1l6TEg3S0tL?=
 =?utf-8?B?SlpNaU53c2pjRGVqUnFjZ1ZzUnN0ODVSc0c0dUdDUmFDeHdic0pHcGx4NkpO?=
 =?utf-8?B?UTY3SklvSXJvWHFIeFA0Ylk5L1BJVFdLTXFGZVFyamlHUFpIcFovSVgwc2gw?=
 =?utf-8?B?Rlh1UUpGZTdlcEhnMDhqczJiZ0VZUndQUDF2Z0plZ2MwUHNhVkJjUnJlSEhv?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R2NIbTV5am9XaXJ5RUZZcFBRQXdCK2ljQWYydHdaV0U5blo4QUdzRWx1SlF6?=
 =?utf-8?B?aWVOd0hVNjEzcERJdjRoTVZmQjZYN3EzZ3ZFYkY5czBzQXh2Wk1qOUtzN0lH?=
 =?utf-8?B?TWJOczFOV1NVQU1Hc3pmUGhUYjY3NUpXUE1saUdSRjRtTXdiNzhCVU1lcGNE?=
 =?utf-8?B?a0lBQWt0SXlGZUNmcWMyQ3BuNDdoYUVQQmNHWTlPREpkanRkVFN2dmpkMTdt?=
 =?utf-8?B?N1FiN2xKVWxKZzNIMzdsd2NkMFZDZWNtcXlOSnhBT2FXdWJHM3VuQXFzNnYz?=
 =?utf-8?B?R3lrN1UzTjZNdGJnMko3YWhwQXBkTlAveTI0eGNWbE9NU3hHckw0SEkxTytm?=
 =?utf-8?B?WGUrYVlmRG9TUU9zZmtaMk1rRC9yU2RYdlljY0JZZGUxYjNpTHVjVlVwWWty?=
 =?utf-8?B?SWhNTE8vbElramEzTytUMUozWG45L2E5S0lOeW52ZHFRb2FZOEhTYjBSaGli?=
 =?utf-8?B?TFJvaTc0dG9oWDIxWVp4aTZFWG52RVpOOFBSVHNFenFPbFU3d3dRcWJDVVJp?=
 =?utf-8?B?Vys3YkhvMVBxRE9jdmlRaDRzOUZPaUdzYUtkcklzZTdQMUtQV2ppeHQ1K0hL?=
 =?utf-8?B?anEvMWZ3Z0x0RnpyOXFZS1ZPTUw0Umo2Zmg0YnlpTUFDSVppazcwRlBjN0Va?=
 =?utf-8?B?TlhxYytYYXA4SkdFRkptN3c2N2tEV1VnUHc4UVEwUWp4TGxNcWp5ZWhWMjBE?=
 =?utf-8?B?UEtVZlZueGtZbVYxb2t6N0NVUzdlV2VWNU1mZ3N2R2Z3RkFXbWNoZjBwNGdZ?=
 =?utf-8?B?eXZvK2g3MytTVUw0ZWVSUW10ZHU4YzhyZ2QrTzZCSzMzSGRNanBRZERES09i?=
 =?utf-8?B?Rm1FUk1IcnlzUjBYSjFvcWpwWE5zazFDdUY1ZDR2VFNmMC9GeFBFdlFXWk5V?=
 =?utf-8?B?NVVCN1QwRHBpMnFjZGtCNWZ6TG9lZmpwWlhZdHh6bTdyZTc0MHB6T1FUalpD?=
 =?utf-8?B?dFBjN2xNa2VvZGI4bFlGQTQ2TFVkODJmRXlnVmRLcG1uY3NwSkpHWVE4Nmgv?=
 =?utf-8?B?NjhyNndTSlFzaWJ5cWRZMy96MlBRb2drM1lPUXErSkJRTWRRMHdYZDdhT3Qw?=
 =?utf-8?B?M0VqVXZxRUZUa09INVQ4VlZFbndrT2RjNFQ5YUt2R0cra3VwYnhRZWZBR0VY?=
 =?utf-8?B?ZnRXcVIxYU5CcnY5QnJCR0Y1eEdDT2hkL2ozdURkOVhQOTl1b01ocS9jS1Uw?=
 =?utf-8?B?ZUs3M0JQM1UzdUZPbVFRa1FFdm0vUjZ3SVN6TEk2eHpjS3lRbWJNZGg5MjNj?=
 =?utf-8?B?T1NteTNlQmNDT05qbkh5Y1lkN21CdXVsZUVMajhYT1hRVnA2WGN0b21ubDlZ?=
 =?utf-8?B?em9BdVRMd3lXcHBNbm5yOVhUYlNyYVQ2ZXQxRmcwZGYzakVGOGV3MVVQNkVt?=
 =?utf-8?Q?OILR0wrSHcp+waJX5XwcxfRSdBSMKb5E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af943cd4-0093-461b-178f-08db4db95680
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 22:37:42.0062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ/fTT91m/gojNKtLI6/ZRakvOVSxGnP1asLo9WGd1G4jR+7e/mhjKGMmQiezvuUWsqwRw0J1sl0sm0SKdtiAL5zhhtF5lTSijN/etllK80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050182
X-Proofpoint-GUID: wJP1GlFObZhCiBKFKdGarfhi3BgJCAG1
X-Proofpoint-ORIG-GUID: wJP1GlFObZhCiBKFKdGarfhi3BgJCAG1
Cc: mst@redhat.com, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS81LzIzIDE6MjIgUE0sIExpbnVzIFRvcnZhbGRzIHdyb3RlOgo+IE9uIEZyaSwgTWF5IDUs
IDIwMjMgYXQgNjo0MOKAr0FNIE5pY29sYXMgRGljaHRlbAo+IDxuaWNvbGFzLmRpY2h0ZWxANndp
bmQuY29tPiB3cm90ZToKPj4KPj4gSXMgdGhpcyBhbiBpbnRlbmRlZCBiZWhhdmlvcj8KPj4gVGhp
cyBicmVha3Mgc29tZSBvZiBvdXIgc2NyaXB0cy4KPiAKPiBJdCBkb2Vzbid0IGp1c3QgYnJlYWsg
eW91ciBzY3JpcHRzICh3aGljaCBjb3VudHMgYXMgYSByZWdyZXNzaW9uKSwgSQo+IHRoaW5rIGl0
J3MgcmVhbGx5IHdyb25nLgo+IAo+IFRoZSB3b3JrZXIgdGhyZWFkcyBzaG91bGQgc2hvdyB1cCBh
cyB0aHJlYWRzIG9mIHRoZSB0aGluZyB0aGF0IHN0YXJ0ZWQKPiB0aGVtLCBub3QgYXMgcHJvY2Vz
c2VzLgo+IAo+IFNvIHRoZXkgc2hvdWxkIHNob3cgdXAgaW4gJ3BzJyBvbmx5IHdoZW4gb25lIG9m
IHRoZSAic2hvdyB0aHJlYWRzIiBmbGFnIGlzIHNldC4KPiAKPiBCdXQgSSBzdXNwZWN0IHRoZSBm
aXggaXMgdHJpdmlhbDogIHRoZSB2aXJ0aW8gY29kZSBzaG91bGQgbGlrZWx5IHVzZQo+IENMT05F
X1RIUkVBRCBmb3IgdGhlIGNvcHlfcHJvY2VzcygpIGl0IGRvZXMuCj4gCj4gSXQgc2hvdWxkIGxv
b2sgbW9yZSBsaWtlICJjcmVhdGVfaW9fdGhyZWFkKCkiIHRoYW4gImNvcHlfcHJvY2VzcygpIiwg
SSB0aGluay4KPiAKPiBGb3IgZXhhbXBsZSwgZG8gdmlydGlvIHdvcmtlciB0aHJlYWRzIHJlYWxs
eSB3YW50IHRoZWlyIG93biBzaWduYWxzCj4gYW5kIGZpbGVzPyBUaGF0IHNvdW5kcyB3cm9uZy4g
Y3JlYXRlX2lvX3RocmVhZCgpIHVzZXMgYWxsIG9mCj4gCj4gIENMT05FX0ZTfENMT05FX0ZJTEVT
fENMT05FX1NJR0hBTkR8Q0xPTkVfVEhSRUFEfENMT05FX0lPCj4gCj4gdG8gc2hhcmUgbXVjaCBt
b3JlIG9mIHRoZSBjb250ZXh0IHdpdGggdGhlIHByb2Nlc3MgaXQgaXMgYWN0dWFsbHkgcnVuIHdp
dGhpbi4KPiAKCkZvciB0aGUgdmhvc3QgdGFza3MgYW5kIHRoZSBDTE9ORSBmbGFnczoKCjEuIEkg
ZGlkbid0IHVzZSBDTE9ORV9GSUxFUyBpbiB0aGUgdmhvc3QgdGFzayBwYXRjaGVzIGJlY2F1c2Ug
eW91IGFyZSByaWdodAphbmQgd2UgZGlkbid0IG5lZWQgb3VyIG93bi4gV2UgbmVlZGVkIGl0IHRv
IHdvcmsgbGlrZSBrdGhyZWFkcyB3aGVyZSB0aGVyZQphcmUgbm8gZmlsZXMsIHNvIEkgc2V0IHRo
ZSBrZXJuZWxfY2xvbmVfYXJncy5ub19maWxlcyBiaXQgdG8gaGF2ZSBjb3B5X2ZpbGVzCm5vdCBk
byBhIGR1cCBvciBjbG9uZSAodGFzay0+ZmlsZXMgaXMgTlVMTCkuCgoyLiB2aG9zdCB0YXNrcyBk
aWRuJ3QgdXNlIENMT05FX1NJR0hBTkQsIGJlY2F1c2UgdXNlcnNwYWNlIGFwcHMgbGlrZSBxZW11
IHVzZQpzaWduYWxzIGZvciBtYW5hZ2VtZW50IG9wZXJhdGlvbnMuIEJ1dCwgdGhlIHZob3N0IHRo
cmVhZCdzIHdvcmtlciBmdW5jdGlvbnMKYXNzdW1lIHNpZ25hbHMgYXJlIGlnbm9yZWQgbGlrZSB0
aGV5IHdlcmUgd2l0aCBrdGhyZWFkcy4gU28gaWYgdGhleSB3ZXJlIGRvaW5nCklPIGFuZCBnb3Qg
YSBzaWduYWwgbGlrZSBhIFNJR0hVUCB0aGV5IG1pZ2h0IHJldHVybiBlYXJseSBhbmQgZmFpbCBm
cm9tIHdoYXRldmVyCm5ldHdvcmsvYmxvY2sgZnVuY3Rpb24gdGhleSB3ZXJlIGNhbGxpbmcuIEFu
ZCBjdXJyZW50bHkgdGhlIHBhcmVudCBsaWtlIHFlbXUKaGFuZGxlcyBzb21ldGhpbmcgbGlrZSBh
IFNJR1NUT1AgYnkgc2h1dHRpbmcgZXZlcnl0aGluZyBkb3duIGJ5IGNhbGxpbmcgaW50bwp0aGUg
dmhvc3QgaW50ZXJmYWNlIHRvIHJlbW92ZSB0aGUgZGV2aWNlLgoKU28gc2ltaWxhciB0byBmaWxl
cyBJIHVzZWQgdGhlIGtlcm5lbF9jbG9uZV9hcmdzLmlnbm9yZV9zaWduYWxzIGJpdCBzbwpjb3B5
X3Byb2Nlc3MgaGFzIHRoZSB2aG9zdCB0aHJlYWQgaGF2ZSBpdCdzIG93biBzaWduYWwgaGFuZGxl
IHRoYXQganVzdCBpZ25vcmVzCnNpZ25hbHMuCgozLiBJIGRpZG4ndCB1c2UgQ0xPTkVfVEhSRUFE
IGJlY2F1c2UgYmVmb3JlIG15IHBhdGNoZXMgeW91IGNvdWxkIGRvCiJwcyAtdSByb290IiBhbmQg
c2VlIGFsbCB0aGUgdmhvc3QgdGhyZWFkcy4gSWYgd2UgdXNlIENMT05FX1RIUkVBRCwgdGhlbiB3
ZQpjYW4gb25seSBzZWUgaXQgd2hlbiB3ZSBkbyBzb21ldGhpbmcgbGlrZSAicHMgLVQgLXAgJHBh
cmVudCIgbGlrZSB5b3UgbWVudGlvbmVkCmFib3ZlLiBJIGd1ZXNzIEkgbWVzc2VkIHVwIGFuZCBk
aWQgdGhlIHJldmVyc2UgYW5kIHRob3VnaHQgaXQgd291bGQgYmUgYQpyZWdyZXNzaW9uIGlmICJw
cyAtdSByb290IiBubyBsb25nZXIgc2hvd2VkIHRoZSB2aG9zdCB0aHJlYWRzLgoKSWYgaXQncyBv
ayB0byBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mICJwcyAtdSByb290IiwgdGhlbiB3ZSBjYW4gZG8g
dGhpcyBwYXRjaDoKKE5pY29sYXMsIEkgY29uZmlybWVkIGl0IGZpeGVzIHRoZSAncHMgYScgY2Fz
ZSwgYnV0IGNvdWxkbid0IHJlcGxpY2F0ZSB0aGUgJ3BzJwpjYXNlLiBJZiB5b3UgY291bGQgdGVz
dCB0aGUgcHMgb25seSBjYXNlIG9yIGdpdmUgbWUgaW5mbyBvbiB3aGF0IC91c3IvYmluL2V4YW1w
bGUKd2FzIGRvaW5nIEkgY2FuIHJlcGxpY2F0ZSBhbmQgdGVzdCBoZXJlKToKCgpkaWZmIC0tZ2l0
IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMKaW5kZXggZWQ0ZTAxZGFjY2FhLi5lYjlm
ZmM1OGUyMTEgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpA
QCAtMjI2OSw4ICsyMjY5LDE0IEBAIF9fbGF0ZW50X2VudHJvcHkgc3RydWN0IHRhc2tfc3RydWN0
ICpjb3B5X3Byb2Nlc3MoCiAJLyoKIAkgKiBUaHJlYWQgZ3JvdXBzIG11c3Qgc2hhcmUgc2lnbmFs
cyBhcyB3ZWxsLCBhbmQgZGV0YWNoZWQgdGhyZWFkcwogCSAqIGNhbiBvbmx5IGJlIHN0YXJ0ZWQg
dXAgd2l0aGluIHRoZSB0aHJlYWQgZ3JvdXAuCisJICoKKwkgKiBBIHVzZXJ3b3JrZXIncyBwYXJl
bnQgdGhyZWFkIHdpbGwgbm9ybWFsbHkgaGF2ZSBhIHNpZ25hbCBoYW5kbGVyCisJICogdGhhdCBw
ZXJmb3JtcyBtYW5hZ2VtZW50IG9wZXJhdGlvbnMsIGJ1dCB0aGUgd29ya2VyIHdpbGwgbm90CisJ
ICogYmVjYXVzZSB0aGUgcGFyZW50IHdpbGwgaGFuZGxlIHRoZSBzaWduYWwgdGhlbiB1c2VyIGEg
d29ya2VyCisJICogc3BlY2lmaWMgaW50ZXJmYWNlIHRvIG1hbmFnZSB0aGUgdGhyZWFkIGFuZCBy
ZWxhdGVkIHJlc291cmNlcy4KIAkgKi8KLQlpZiAoKGNsb25lX2ZsYWdzICYgQ0xPTkVfVEhSRUFE
KSAmJiAhKGNsb25lX2ZsYWdzICYgQ0xPTkVfU0lHSEFORCkpCisJaWYgKChjbG9uZV9mbGFncyAm
IENMT05FX1RIUkVBRCkgJiYgIShjbG9uZV9mbGFncyAmIENMT05FX1NJR0hBTkQpICYmCisJICAg
ICFhcmdzLT51c2VyX3dvcmtlciAmJiAhYXJncy0+aWdub3JlX3NpZ25hbHMpCiAJCXJldHVybiBF
UlJfUFRSKC1FSU5WQUwpOwogCiAJLyoKZGlmZiAtLWdpdCBhL2tlcm5lbC92aG9zdF90YXNrLmMg
Yi9rZXJuZWwvdmhvc3RfdGFzay5jCmluZGV4IGI3Y2JkNjZmODg5ZS4uMzcwMGMyMWVhMzlkIDEw
MDY0NAotLS0gYS9rZXJuZWwvdmhvc3RfdGFzay5jCisrKyBiL2tlcm5lbC92aG9zdF90YXNrLmMK
QEAgLTc1LDcgKzc4LDggQEAgc3RydWN0IHZob3N0X3Rhc2sgKnZob3N0X3Rhc2tfY3JlYXRlKGlu
dCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsCiAJCQkJICAgICBjb25zdCBjaGFyICpuYW1lKQog
ewogCXN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyBhcmdzID0gewotCQkuZmxhZ3MJCT0gQ0xPTkVf
RlMgfCBDTE9ORV9VTlRSQUNFRCB8IENMT05FX1ZNLAorCQkuZmxhZ3MJCT0gQ0xPTkVfRlMgfCBD
TE9ORV9USFJFQUQgfCBDTE9ORV9WTSB8CisJCQkJICBDTE9ORV9VTlRSQUNFRCwKIAkJLmV4aXRf
c2lnbmFsCT0gMCwKIAkJLmZuCQk9IHZob3N0X3Rhc2tfZm4sCiAJCS5uYW1lCQk9IG5hbWUsCgoK
CgoKCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
