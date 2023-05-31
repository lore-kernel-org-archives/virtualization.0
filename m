Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E462C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 15:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EA3F83926;
	Wed, 31 May 2023 15:15:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EA3F83926
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=XwLGV5fU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=bL8MrYMN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aiVptTI9sgaX; Wed, 31 May 2023 15:15:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC74A82CA5;
	Wed, 31 May 2023 15:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC74A82CA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C6DC007C;
	Wed, 31 May 2023 15:15:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6141BC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 15:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AC0A4054E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 15:15:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AC0A4054E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=XwLGV5fU; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=bL8MrYMN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLcRy3nNv3UW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 15:15:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3124540194
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3124540194
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 15:15:13 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VERHdU031545; Wed, 31 May 2023 15:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DLT3nLGkBnr4440mVYZhr5Fum7yk612uNkqxs5BQI6I=;
 b=XwLGV5fUxi4o7IvWmoF6Sctz4Dou4ze+UdB6MdVN3ag3uHC3Dz4De2+ntgOuU8Auws23
 +zBxI/riEwVu9p9jenwxY7dWf3T5+fZZodpylociP0091U9VcBSUZ3ZilFJmpL/Mdre/
 lo7uut6pIRGjKucFrihlAlRFdVMIEtCc/7HZo0HlkhS6L0NswI6yRgmXiY49jwnhHNec
 23Sqfy4NVBXfsvM5ISW/drNSQTbEB+stQc19wodhh25XwuvKgknzxS0ERRSKDfKHC2N6
 jZSv+1A6XENpYuZS5hDVwI67Tzab1rssJpxDmRkeTz/G38+SYR50EfRfF3zRiRqwpDkb 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4x4e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 15:15:11 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34VEa97l019825; Wed, 31 May 2023 15:15:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a5yet5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 15:15:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3tU480wHML/JOnuVfckhnEfoGOlaTbJstd2yqE5IvvTot45CrS9GyyYxnb3Ms0mG29fWD6jLGEJq8Z0jXK+ZBxEtbHedtz5yPtDcIB0bF0S7whlCJmk74IHKmaz/zWGyjK8/4lGqe7PN90STuGpmjMg3EK62mFNWX8wxq/bGQw7/99JF1Zk3AkZ2eYDkdziEMhYxFINURXiF4H+iGQ7sSnu4ihbXYuMoUXhhRZnxXXoD6MjuETpbtBQfAYLXFjHUSD4HfmmIi8yngtD5+QzDjO+0vgkApGMqxb/1IjlX7EZ/YMwpwrIcjB2XeJXUpJtZUaOe7gY/+/63OBMZBaPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLT3nLGkBnr4440mVYZhr5Fum7yk612uNkqxs5BQI6I=;
 b=JCXS1eWzVy2Zq8fj1FrxSWFhImhdvaTCe2CWdvygp1U2pyV4vfD8FFd7pKZE22cLwBkcVL/eLi7TMaMw3GJow/ccvstMray+XGLPK6PCLjSt5Zc6ibuZnpVeb6M0fi4oModsGZ0qnyVZ5UicfvVysZJWzXJiMpcEFp9hK4sbMeNGtcKATmcD6hNQRgIfUi6va5m4I4Nf5H6guYLi/ynwydo89fu8MJBsIO8ypk8Zo4sQjprHNiTfS75fG0lmB3zA1Ic15JuKPHNRU50NS8Kuo5YJANDpGCChklZCsXJF7HOF+LHwWJ8goueH9rkoMLpcKACEQpBKt3hhyJr6GOE1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLT3nLGkBnr4440mVYZhr5Fum7yk612uNkqxs5BQI6I=;
 b=bL8MrYMNcnebWbdsqF3tyAo6u59AcBzb9ehTCh57fxe7LlnITsDlrEYXqAgasZPFCim/QB9OodekUONcvIdW6s9dspA361oGo3wg8HOUj/A2TNiKbivrq5r8vSxK1tTWjI/Z0H+YAsCzXtilJ4ScKLQNgifOTc4MmWeCIU81kJ0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 15:15:08 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 15:15:08 +0000
Message-ID: <43f67549-fe4d-e3ca-fbb0-33bea6e2b534@oracle.com>
Date: Wed, 31 May 2023 10:15:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <0000000000001777f605fce42c5f@google.com>
 <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
 <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
 <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
 <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
X-ClientProxiedBy: DM6PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:5:335::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DM4PR10MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0c4e90-f696-40a7-cc3c-08db61e9d214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmu/820h2+WGJfrXXrrHcQ9OIQ0FAMxEDQWuBt8ujrSL4KVWrUG3R0OCez0isHpG7uzLw8uqLe+DpLThCkL5kSNyOMYR/zgQiPMgN1rNk3NyV+9Qnfdc+mFoJ2J0FHWevgcV7mHG3twBdCPt+NnL63Z6bdsy4/P/hj93LJMp7Ypg5vNsBUJshu4wMdWHMWwCq/1fDK1PlzXwcdAGhSOZLMKYpGn7x1Ipq2NT88/jBMzJAO98v28+wIFb/wD03aQYBjayz66IWvwSjBlqHNDGqAyAAA4bJUnIbHZWJJdV1VT8t9rt0zRp90SzSsF4cyB7PGKgIu2au0h2aWkJjfs0n8I+vBfuaE5hTEte2VKaVua7CR/Yzxyz28mNqwXZ1cIDCa3ASlDFv0QChpDJd5p7k+SifZqsVGd++EpMUnUAmWzuURyKQS9qRfWqgYUxWCQTM07E1lDBvLl6ZSH89X/zeHDXJRcRaPnOj9WgXvTYl0fmrs7mixhKwPT7B6iIu2la90ag/CXKHpwhfjLVOuCxcIeC1HMCJx+w/zDmaz5yCWUl/HHlsau3x8iORUGez2ciLuS029AjMIW8Gz60SEEG49pLRtYInBcoUf7RSWTTXDv835C0NtqcpTwpobeZ5D//kMJKYTl8Qmb0JgKl3pt/7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(316002)(66476007)(66556008)(4326008)(6916009)(478600001)(54906003)(5660300002)(36756003)(7416002)(66946007)(31686004)(8676002)(6486002)(41300700001)(38100700002)(8936002)(86362001)(2616005)(6512007)(53546011)(186003)(83380400001)(31696002)(6506007)(26005)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtJUHBQbDhHSEppbnkxVlhPanp0WGVJSFZXd2lVeHhxelVGa0FjQzVvRjVq?=
 =?utf-8?B?OU1yT1A4QzZDblZ4bXpyMkwrMEUybXlYcEFFZE1Edm5MMy80TlpMK3hNYWZq?=
 =?utf-8?B?bzVSbmxjeS93YTR1cmpuMTY2aHNkakQyZkpseEZhNkdyTXlOLzhRR0RWdWUy?=
 =?utf-8?B?NU1ycjBBQWxLUkpsMDlwSUlJQVE5bnZXYVprazFURnBjTlNTWEJRVGkxTFlY?=
 =?utf-8?B?S0tVN0hQc0V0SnVQYzIzUUFwTzllK3VMMGt5S05WVWNpcVJkRjZjVTZLK0ox?=
 =?utf-8?B?UjZBaGZXM20wL0M5bEdjcTVGUzhPdFVuTFdtR3B2OEVHaENoVkpXOWlxd0pO?=
 =?utf-8?B?eXVOa2FuYXNQbUpuWnY3TTM2M0FNOHBHU052dnU5L0xpYktpNzFYOGt5UFZq?=
 =?utf-8?B?Mmc1ZDZKcFVRWVRpUSs0c21ESHk1WVdFRW8xT2hyQlVjOTFVdzNLc1hsWS94?=
 =?utf-8?B?N245Y09qbSt6VTlFdk4yeVBCb3cycHJwVWRtMW5qYlpseGxPaHhBQU5mKzMr?=
 =?utf-8?B?SEs5Vm9LYWgrdk9xcm8wTFlwbXlEa3dQK0lNblRKYlhaY21ZVVBZN0pMaXBW?=
 =?utf-8?B?Z1dUcmdFZ3VNMDgwM3pTd3REUGM5NXM3dXhWZFhGVEx6eFBNRUtXeFdVcE1i?=
 =?utf-8?B?ZUQ4NGg3bTE1QUJjZEc1S0k1ZjQ2MllUVE5XVU1IRndjK0RIUkoxNk5YSUZj?=
 =?utf-8?B?a3lmRDJnNUxJenhhU09XS3BleUw3aUx1S0hKanZialRuc081bTdJK3pyd2ZI?=
 =?utf-8?B?dm5uVVZHSENhZ241ck9VeVdWdTBkczZZd1RNSW5TUUFPN1I5L2ptaVovdi9i?=
 =?utf-8?B?T3NGbnJ4ejUyZUhKRFk4ZFRQVG9pelRIZ2VrTE53Skx3eFlmOXpVT3hlS1Z3?=
 =?utf-8?B?MFNrWWhrVkZ6S2tVb1NvVDVTU0I3MmdDa0JTUG4rTklKUGRqMGNQZFdUM0M1?=
 =?utf-8?B?QzROaFhBZTMrQ1NHTG0vakMxZEJMY1R4aENlZFpSdGM2MlpkNUxsSjNBMXBy?=
 =?utf-8?B?R01qMUVNWmRsYkZOM2ZpL29zbzVuNXJ3bEpVeXpjQmJhekgyUHR5M0Zzb2Jy?=
 =?utf-8?B?ZDZ1MjkrU1IrbWgzY2FvNWZPak8raG5ic2J4aTRvOGwzUGRaZ1JsUUlOeTl1?=
 =?utf-8?B?TG1ocmduWXhGS283RFZ2YTJlTU1ESjFtY0wvaStURzFrcjNtemp6d1l6ZTlt?=
 =?utf-8?B?NnE1SzJuMTBsSWFUc2tPd2xUZGlIcDl2TDA1YjJlUVNGc292U004VWlxaVdr?=
 =?utf-8?B?Vkc4Q051T1hRUXMrWVhyVUF0aGVxd0pqMEdPU1lnME53WnA4OTdMQUIwc2Zi?=
 =?utf-8?B?Tlh3N2JHeFhHdWVCeGthOUp3SFFuUFluanZwa3VEVndQSU5ZZ2FlUW5vNjVB?=
 =?utf-8?B?YW82NG5UZXllUUNrRXpNa2FWTEZsaGtDZGlFaDhBVzA3SHdjYWVOQTE0U2Vo?=
 =?utf-8?B?NVJ4YXE4Nk5YUFA3bDVoRDNvb2lhRWxSVjU1RUU5OFE0ZzZQQXA2bi9XdTZx?=
 =?utf-8?B?dmFZTlFFcUdLRTF6clo5akxwRTAvQ0Y4dmhoOEhEK2hiMUhsRmxzcXhMVmp2?=
 =?utf-8?B?dXlTZnJFb3lSdTQxUm5zTnIwWDh4cmdjdG1VTlozNzE5eGkwL1JjQW9aaGl1?=
 =?utf-8?B?b0tsVWVXMkt0SnFWcmM1OU9OM1B5R25maXlGQUZUbjNvOFhnWm1pSVRnUmlh?=
 =?utf-8?B?SlNUNmR1WjBkUFcvaGdWU1VyMzF0a0g1UFJMeHhBei8rZDZYNnVqM2RIQUIx?=
 =?utf-8?B?ajB6cUlVbFI4OW1iU0o2UUxxVmp6UWlpc29MejVZaTFQWUZDYUVJRzNPdlo0?=
 =?utf-8?B?d1Flcm83ZUhYRlFIUVhrNldnVm1pVlp3NGJmcy9Ba3A2Mklyb3c2UnlxMFJl?=
 =?utf-8?B?K3RINkM0NFpYRGxvdXN1czF5MXhyN3Voc2NQL1VrelppQ3lzZGVNejRNSnFo?=
 =?utf-8?B?RlVWdzEwY1BaVjhPTXJPeTF0K0Z6SlBlWFA3WldWai9QcWtYYWhQVTQ5MWx1?=
 =?utf-8?B?YmZ3dzZaMGxjUTQwdllzZGZSM09vdWxHQlBtdkF1aTdCVUtxWG5IaWtsYWMz?=
 =?utf-8?B?M1JBSnQzaTREMlZGZEMvNzJqTkdITVRvaHVRaXFub3AxVHdaRW92MTc3UGpk?=
 =?utf-8?B?RkUrMS92RnRjQVRTL3Zod3VJTk8yWFVCaHRKWWh1MU1jS3l0clhDNDlaUVJM?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S2t4V0VKV1BGUlhqcjhKa1Q2SVEzcm9rdFUxUUF4SUkyUkFGVVlXQUFGWXpj?=
 =?utf-8?B?bW4zSlUwQ09yQWN1MW5QUHRNYW5XVWRJNTc1NHliWnMvaFduTnZXYjg0cmxR?=
 =?utf-8?B?ODMwZk9KQzJoWjFUSGRpTGRUdlNzWVI5a0dEc0lsSFV4b0doUWwyajVZZkZ5?=
 =?utf-8?B?Unl3dlVnVnVKdXF0aFQySGdOeG5wRk9EWnV0MlBuZHR3V1p6dmcrYWtxODNW?=
 =?utf-8?B?ZkE5eG1adWpNQXR1TGpibU9aaFNJT0NZVVo0N0xvekMraEJlMVFGQ3dkbFJD?=
 =?utf-8?B?K2ZRcThpMGFGNGllM0Q5YXNOSWo2dGFsOXFTSDhoeWRzNldabWRDdWpUaTdj?=
 =?utf-8?B?a1Yxa01vNTREcXFXWVNOT013ZXdmR0xRaFlYeXpvcE5HSDNrVndYOVlaeTVW?=
 =?utf-8?B?N291V3ppdTQvL1VYS2dwdDNsaHB1ekozUUtOWHNCTXc1T0lmZlZsSHlVeEts?=
 =?utf-8?B?d0Evd3JZL05vNUprWGtsNWIreDMwQ3JaM2dpV2x6a2UvYnRJWis5K0g3ZXNG?=
 =?utf-8?B?RmNOQXFUZVVQUUd0SGpQRzJCa01ZUE1HQlBYeHkyTmJ1aWJLRE1lOEJ0aVl0?=
 =?utf-8?B?S3VnUDB6N2ZnT2UrQWJDTjd1T1dzSjFiU2V6aTZFQTZGZS96ZVN6MjQrenpn?=
 =?utf-8?B?ZkVQamdMWlJWYm5PZnd5YjNTdnh0Wms4cFFENCtJU1FaS2dPMXM4WHBkQzBo?=
 =?utf-8?B?RHNYV3ZqWHBXUlE2MGJNc1I2RnJzQzhBUElCWWdDcUFuNGE0dXJlYVpLVVFC?=
 =?utf-8?B?NEVSTDVRenM5Uk1jQzdyV3pGMW44dGdUNExFVkZObFByK3A2K0lVYURJZGVl?=
 =?utf-8?B?emh1bzQyaWpBVW1OYVlKK1dKN0FLN1dPVXlNNW9BZlZNRW9zd0w3SC82RFFj?=
 =?utf-8?B?VUFncmgwYTU1dHJRQ09BTlkzRmxxTWRGczY0aHdRYTZJSWF0MkhDQlR5ODB0?=
 =?utf-8?B?bFN6a3MraXRWTWVsbnpzT0pBOUdFeVluWmZncFRhRU4vNnd1SGRZQ2Q5SzRO?=
 =?utf-8?B?K0Zsd0o4RGxPMVBtRDJYQ1M5eVlIUVpDV2tkQWZ4V2NvTnd3c2dQbmNRMjNS?=
 =?utf-8?B?SWR0ekVWTXVYWCtZSERNN01pZFFoU05YUUwrTThMczBPTE9QTnZsd0ViUm5S?=
 =?utf-8?B?VzR1WVp4UnZFYkMvdVUrbC96UmwwYXhMMnhJdXE3Y2R1SUpUZmFRdzFzV25j?=
 =?utf-8?B?c28vdW01UDVkOTgvT2pVektibitvZjU1NG9ma0p4Qk1MeGdxNkxkQ1M2SUJo?=
 =?utf-8?B?WmhQSTNqY2V5bzhTdU1RVVByTWRtcTgveTJJeXJkZDZUa0pKV2FvV0FpQ3Vx?=
 =?utf-8?Q?nSlCbGG5c7kCE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0c4e90-f696-40a7-cc3c-08db61e9d214
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:15:08.3872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xd2l0QhMCyDz+fGmSAALQosdOcDqzEnkPErYdWPtqgYyvWJeNFTD/qA3UUn9txx3vfWsTVXDBpCGSeNUFG9XisweH40DyRgZ+vMMCNrPKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310130
X-Proofpoint-GUID: gmWdtDezSndEFaGTwnoxf_4tOUl4ptfu
X-Proofpoint-ORIG-GUID: gmWdtDezSndEFaGTwnoxf_4tOUl4ptfu
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

T24gNS8zMS8yMyAyOjI3IEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24gVHVlLCBN
YXkgMzAsIDIwMjMgYXQgNjozMOKAr1BNIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+IHdy
b3RlOgo+Pgo+PiBPbiA1LzMwLzIzIDExOjE3IEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+PiBPbiBUdWUsIE1heSAzMCwgMjAyMyBhdCAxMTowOTowOUFNIC0wNTAwLCBNaWtlIENocmlz
dGllIHdyb3RlOgo+Pj4+IE9uIDUvMzAvMjMgMTE6MDAgQU0sIFN0ZWZhbm8gR2FyemFyZWxsYSB3
cm90ZToKPj4+Pj4gSSB0aGluayBpdCBpcyBwYXJ0aWFsbHkgcmVsYXRlZCB0byBjb21taXQgNmU4
OTBjNWQ1MDIxICgidmhvc3Q6IHVzZQo+Pj4+PiB2aG9zdF90YXNrcyBmb3Igd29ya2VyIHRocmVh
ZHMiKSBhbmQgY29tbWl0IDFhNWY4MDkwYzZkZSAoInZob3N0OiBtb3ZlCj4+Pj4+IHdvcmtlciB0
aHJlYWQgZmllbGRzIHRvIG5ldyBzdHJ1Y3QiKS4gTWF5YmUgdGhhdCBjb21taXRzIGp1c3QKPj4+
Pj4gaGlnaGxpZ2h0ZWQgdGhlIGlzc3VlIGFuZCBpdCB3YXMgYWxyZWFkeSBleGlzdGluZy4KPj4+
Pgo+Pj4+IFNlZSBteSBtYWlsIGFib3V0IHRoZSBjcmFzaC4gQWdyZWUgd2l0aCB5b3VyIGFuYWx5
c2lzIGFib3V0IHdvcmtlci0+dnRzawo+Pj4+IG5vdCBiZWluZyBzZXQgeWV0LiBJdCdzIGEgYnVn
IGZyb20gbXkgY29tbWl0IHdoZXJlIEkgc2hvdWxkIGhhdmUgbm90IHNldAo+Pj4+IGl0IHNvIGVh
cmx5IG9yIEkgc2hvdWxkIGJlIGNoZWNraW5nIGZvcgo+Pj4+Cj4+Pj4gaWYgKGRldi0+d29ya2Vy
ICYmIHdvcmtlci0+dnRzaykKPj4+Pgo+Pj4+IGluc3RlYWQgb2YKPj4+Pgo+Pj4+IGlmIChkZXYt
PndvcmtlcikKPj4+Cj4+PiBZZXMsIHRob3VnaCwgaW4gbXkgb3BpbmlvbiB0aGUgcHJvYmxlbSBt
YXkgcGVyc2lzdCBkZXBlbmRpbmcgb24gaG93IHRoZQo+Pj4gaW5zdHJ1Y3Rpb25zIGFyZSByZW9y
ZGVyZWQuCj4+Cj4+IEFoIG9rLgo+Pgo+Pj4KPj4+IFNob3VsZCB3ZSBwcm90ZWN0IGRldi0+d29y
a2VyKCkgd2l0aCBhbiBSQ1UgdG8gYmUgc2FmZT8KPj4KPj4gRm9yIHRob3NlIG11bHRpcGxlIHdv
cmtlciBwYXRjaHNldHMgSmFzb24gaGFkIGFza2VkIG1lIGFib3V0IHN1cHBvcnRpbmcKPj4gd2hl
cmUgd2UgZG9uJ3QgaGF2ZSBhIHdvcmtlciB3aGlsZSB3ZSBhcmUgc3dhcHBpbmcgd29ya2VycyBh
cm91bmQuIFRvIGRvCj4+IHRoYXQgSSBoYWQgYWRkZWQgcmN1IGFyb3VuZCB0aGUgZGV2LT53b3Jr
ZXIuIEkgcmVtb3ZlZCBpdCBpbiBsYXRlciBwYXRjaHNldHMKPj4gYmVjYXVzZSBJIGRpZG4ndCB0
aGluayBhbnlvbmUgd291bGQgdXNlIGl0Lgo+Pgo+PiByY3Ugd291bGQgd29yayBmb3IgeW91ciBj
YXNlIGFuZCBmb3Igd2hhdCBKYXNvbiBoYWQgcmVxdWVzdGVkLgo+IAo+IFllYWgsIHNvIHlvdSBh
bHJlYWR5IGhhdmUgc29tZSBwYXRjaGVzPwo+IAo+IERvIHlvdSB3YW50IHRvIHNlbmQgaXQgdG8g
c29sdmUgdGhpcyBwcm9ibGVtPwo+IAoKWWVhaCwgSSdsbCBicmVhayB0aGVtIG91dCBhbmQgc2Vu
ZCB0aGVtIGxhdGVyIHRvZGF5IHdoZW4gSSBjYW4gcmV0ZXN0CnJlYmFzZWQgcGF0Y2hlcy4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
