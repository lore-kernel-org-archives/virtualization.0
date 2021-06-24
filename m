Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE5FC49EA6
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 16:20:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB5A613C7
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB5A613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18FE283DB6;
	Thu, 24 Jun 2021 16:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tUkGbaVoefK4; Thu, 24 Jun 2021 16:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF40283D9B;
	Thu, 24 Jun 2021 16:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2E5AC0010;
	Thu, 24 Jun 2021 16:20:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31D36C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BF0C41610
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="yDza8RmD";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="HwEXzuck"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VKLHUwbVpKCP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:20:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CE6A4160F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:20:08 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OGBqhm028240; Thu, 24 Jun 2021 16:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zQcy5J46JTCCGTEXlsvPrwk+DcwVqcz2wXmJvYah6+U=;
 b=yDza8RmD4lrvEEowjtde2MSd0mjuwvBXkLl+FTfKavp7WMyXBwLIt2TBDzqmTfN992KV
 dNXcwu7ZT6CZGat4biYagJawDJs6M9+8P2zm6f83JD2AXCVINk1ILRF9pxy7D3zw8vNv
 tTGOaNa//4cnlEmWSdkzQ8sBmzZcD+PjY8kn6fydZmquCjK8owWuQ5r1Eb4FiFlYFwq+
 wlwOOmrqw8Qe3r+nw2L1Vfkx0w2toxZE/dTJayMIfKvelWuBVrqALPuppguqcUMm6G9y
 NGf3Og3iJMCf4ja0MX0zVBDNVhq+z06VmuvRDM1HYGci8tYotYQ2eA44xBLOLMZ6jY8B +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 39c8twafd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 16:19:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OGBZUI040169;
 Thu, 24 Jun 2021 16:19:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by aserp3020.oracle.com with ESMTP id 3998darj9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 16:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H407n9+Jm0hhzj6jaS3ANxg8uWbB4w3qi9mnm9zB5wf8u9MhWtlASlRuBIeElXO9NxtP+fXakdgNuV3SDMqGJnz4x7WA9n3KEm1KMt4oNa1eXxQlY8lkNNX/wD71RSNUR3OZW9+7v6BfEFuzef28U+zE5TLjm8NLmBRdkcFc8KIKvj4QGbI9Ua4RoO5k9tQFIeN7HncSRmlkNvXN3RQ30Qniz61TUraiM8dd4oRl9b6RgdlBAmIVGwNyawvN+F5Kp6OIC4ITXK+bv7eUykDvihokRGYz0JqtxNLyYXWGC6wCv6T8x/Q0eozTa0BrcO8A6B14jKvB/88vjPo+Akjl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQcy5J46JTCCGTEXlsvPrwk+DcwVqcz2wXmJvYah6+U=;
 b=DvVnlKjhb2XKOgaA8igaBrXZAJQ9t3lnqOao0SMNDS5wiFkB1aAT2ALNleLrP2aM7yOspZg+LR4yJgTAX0pSBL46NWoeifvodhBcLRweZu3vi1UMpuGV8kGjfreoFJxV7LR9QVUyrrF/XGMpJQIStGBys0M2eiacsUR6adUp9is3O6D9gWEbbRZMVPjjqEsaqIeZZZOus00Hh6nRuwc3I/Y1wvYo0B2slangwKwUehizJBedRHZZAFZIcnH5cN6zslost2qajalI7r2G3oslx+hkI/j7gj19KB9F/+qcpncKJWGv44xTV18U2j+CwJaDduvAMJkReczgAOgVg82Bnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQcy5J46JTCCGTEXlsvPrwk+DcwVqcz2wXmJvYah6+U=;
 b=HwEXzuckSCvhiIa5p8+QzU2qIK1GcDGixQyD4fH8dclM0Ww8klgfslZDgXrvZyGQo33IV2qDW/2BI1LkoZg1w0XC7tSXP3mal34bEKehsC5LZQ/hwOT+mkV3EC5F1Pn9rgXzkv4vnEUhuOWq0uH0PMytPiYkrLv09U63MsYX7PU=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 16:19:51 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4264.022; Thu, 24 Jun 2021
 16:19:51 +0000
Subject: Re: [PATCH 1/3] kthread: allow caller to pass in user_struct
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 christian@brauner.io, akpm@linux-foundation.org, peterz@infradead.org,
 christian.brauner@ubuntu.com
References: <20210624030804.4932-2-michael.christie@oracle.com>
 <202106241205.evMViyFN-lkp@intel.com>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <c9ec46cc-e91a-26ee-d535-0d1dfa4acf5c@oracle.com>
Date: Thu, 24 Jun 2021 11:19:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <202106241205.evMViyFN-lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: CH0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:610:cc::34) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.204] (73.88.28.6) by
 CH0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:610:cc::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 16:19:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 731492eb-3833-47b7-b185-08d9372be4ae
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4479:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44792C51153A9F11F5EA77CEF1079@SJ0PR10MB4479.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3Ku0mr8nksOhfdLAetmbtyWEjw0DJn/KdSczpUcuAAbPxtAnfYtERRqGNxxBbpZ4N7VibbmNhpHbZqUpYKVNhh/Qjvo5g7W5HOpmRpFrNgwJVYZZoAoZ8ggE4zTXfgsXdKDaZe+Fb3hN9dZTEdYTvDyXa6zQumluBezyF4veLDfW3P6Ufr7PJPdzuFjOry1IYLqdTE49B6kjf2Cicb2AtHRbGuUhOK7YqnWKBrDIrmwY0yqlpXQwx7qZHqbn4gZ5ySjXulw9b/4LPPB92vYEFzrlLaKfSAedeauvPwhiXOIEHaMulzRdQv1I99L948N23KSad440mtrQ4Fpmlaniu7SHLEw6KVinlt7CSTn7AMo3nSnUH2MpV97bMdBPhqRGOVtSwY3XXgTIYovdvYM0hXcANEzf2mGspadAuk5EXX59i2hEum438nX9xnzp5fGLTb9KVbDfaui/bZuFPFdbAx/VHoBrYbIvnTSWLkpi/oRu3Qo/uZ6CAAsnEdEqFBa0mjdcYVOP6jQCdRzANEvNTvlT1bx4GH2XBcbSl1jic1Sep0FRzeSgPErGx76xY66wE2iNyLENzdYIBypS3KZ64nJHHvbtwfW9fs3Hs89Tzt8y2oE07jBOBhEBg+QNB4s4cHbj/O2qSQqIF9kKNDqx4WU+7zX1hLaCHjg1b1qNeJT8QFfn//60N3y8sm34huNV1JYm1DBj0IJVuJ8uJGi+THShgYEgmdY9M+g8Q0ADe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(66476007)(2906002)(66946007)(558084003)(4326008)(7416002)(66556008)(53546011)(5660300002)(921005)(16526019)(186003)(26005)(6486002)(2616005)(956004)(83380400001)(36756003)(8936002)(8676002)(6706004)(86362001)(31696002)(31686004)(478600001)(16576012)(38100700002)(316002)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?sJwm829mKzPoNch8O+qNtHAQ9+SMqZyFupoAMGsnoDnAFS0kzpY7atev?=
 =?Windows-1252?Q?pb9VwMFkmf1dasizVEIHqPjSXP/4p96fF/fI0XzOKveclfMTxe9hGl8B?=
 =?Windows-1252?Q?EJpZEYSq75G9YnTS9cqPFYTLjpvFJbeji0SCn4J+m36QoOQJYW2NtZet?=
 =?Windows-1252?Q?aMt2uNCbiRqdlo2qFgg1QvsTaIGaaDaZBEf9ABvJeXVtAV/ANIcmuKNc?=
 =?Windows-1252?Q?GNl2XGdo9Iz/X13wrUmGwUGG3eQKdHFFtRTgsrPsCcO2yXYy7CXtcp36?=
 =?Windows-1252?Q?c1/dmt4uiacAAzu0ZQBI53wly2iCVJH8siyOZqTUOlbDUUWWNr2aKoxI?=
 =?Windows-1252?Q?qLJr7hICQKmvG/aFcyfa9XiJMmtI0obMmsikMgbb/U8TcbgJaP4TDvgS?=
 =?Windows-1252?Q?jYJ9ZCzfiyLTVRWA5HBlBwgb6QS0n2R7by3G075Wwt1NnhXTwxNcvS5z?=
 =?Windows-1252?Q?YzVk7RuZtPJ261MsV8i0alRV9v+0oxJYEIff8C42HDZcX6mQIyUahHCZ?=
 =?Windows-1252?Q?nvtKldDaa0tacKW+jPoBlKIZ07D0PhgXcJrVNZ+4AZ2LSmi72szoGgUd?=
 =?Windows-1252?Q?UYrH9UiM3TmXeM3Bo8DhLKDSUiN+pSKrczAilWsF4WhxknthgfVse86v?=
 =?Windows-1252?Q?pUKgfhpm1hnVt6ZNuxdA2UkxZA2kDepbyaUuXbhfH9FfMOYamjpGCti/?=
 =?Windows-1252?Q?wm52Wwd1M/RV9b0qW0UrzvjkDqyp8yAQpszHOkAPhns9vZ/ujfk8nkNf?=
 =?Windows-1252?Q?sz2SjQ7fNhu23YKSHCDkjUiotyyj4uDQOxyKLoDl5CPLkJDjK9IXtsBF?=
 =?Windows-1252?Q?KVDMQHB6hxshV6gguqCN+Ib9dDZeKU7Go9Iuuv7tnSTlk6ngA9NHHoxo?=
 =?Windows-1252?Q?NKEg67AtjO4rbYlY2iJ/numvzoEURSdNuPHo53ybYdArBRHyHXT/lROf?=
 =?Windows-1252?Q?/yJgzn31N0UkuhTlQnGkXPDknRZuVl8FofylQgWx+A2YdhsovKZfhIzW?=
 =?Windows-1252?Q?teg1xjvDmdG5RSSLED6RdKcJOwkhY55SCkcD0qmkbNL/bDQQNEPemQ7k?=
 =?Windows-1252?Q?GbiXNkb7WCQfpa4ALgWzwDt/+8YYIeFSd/R6WQnZSbybwVESLEEMM5BQ?=
 =?Windows-1252?Q?QX1hpEAv9sEWLTVowwTddoxlKlB8J6QZk33MvwwQD0DnPpsmpruiWZYK?=
 =?Windows-1252?Q?vNkN2QARmK/ANERJDI462e0WrPqFsTyHJURSHoykvO+w632M3EI3JODF?=
 =?Windows-1252?Q?i3BcnVkbdoSoCiRWKdX1jCjoKWne8GnsnCcEpCR9hCgQdvE0ZFOLSBLC?=
 =?Windows-1252?Q?fYm0vA/sA//K3F8BF3AP3HCKy5wu6U6UcK4BOqAFcq9IIuffPGsY/ToX?=
 =?Windows-1252?Q?PrTwU7HTlc6wVyt86Q9qprQlIqcUUTZ2ibj9Jb7qHw72fnHC26q4DI+9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731492eb-3833-47b7-b185-08d9372be4ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 16:19:51.1380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0M43mxKtDvFxrC4Vg0gOYu8bCmtAuBYtDltuH0e/c7oWmB14RUCdkTg0yz+Qd3PgdesTACCiOpscR6pdyB3FxxTXhPcggt2iBsBWx0j9z+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240090
X-Proofpoint-ORIG-GUID: 92g23PUdzAHVO4ZonrwjRrP7yhTJN6lC
X-Proofpoint-GUID: 92g23PUdzAHVO4ZonrwjRrP7yhTJN6lC
Cc: kbuild-all@lists.01.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 6/23/21 11:34 PM, kernel test robot wrote:
>>> kernel/kthread.c:466:6: warning: function 'kthread_create_for_user' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>      466 |      namefmt, args);
>          |      ^~~~~~~
> 

Will add a __printf(4, 5).


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
