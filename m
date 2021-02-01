Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7151C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 16:03:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F99564E3C
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 16:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F99564E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F2B3986F77;
	Mon,  1 Feb 2021 16:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kknwiPsZFvd7; Mon,  1 Feb 2021 16:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C922F86F66;
	Mon,  1 Feb 2021 16:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8671EC1825;
	Mon,  1 Feb 2021 16:03:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58D66C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 16:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 340FB86F77
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 16:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zyCmANAz40qQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 16:03:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9A3B986F66
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 16:03:20 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111FdTPh002079;
 Mon, 1 Feb 2021 16:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=d0kWJDuormIwpUPZZtYMjOZdCeJxjvmiUtkloSbA/wM=;
 b=v5M5anzWijPZcdVJZPvWGvmZ1a3vx+FmPnGvuY58pPALutjqkZM1qttS4s3OPzWH8kJr
 A40so8nuCiDV9G4xRyFQ+nhNOqlRwfRsWeXCnkgVEzhH8ytfEby1qJ2LDqL9jni2A0F3
 fwqUeBEnD/A4JBewUOlU4ZiKiOgSpi5PXtIliXnotnoZopsormx6OczXoO1mF/oSK8zY
 nzcE5tJi5YEGC9f0+J8n8dTZ6lZOa+Uj9r+gyYf/j1JvPjg78rhsuy35/442pt9mSTdI
 6RwLGRBdj3Mjmf2bPfhjKxVdGbKUFNW5HMmAOOJ//wejSDww9EwXnLnQ1OIk5Ns4atyg 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 36cvyap7mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Feb 2021 16:03:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111FfRV5162451;
 Mon, 1 Feb 2021 16:03:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by aserp3030.oracle.com with ESMTP id 36dh1mjd4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Feb 2021 16:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISH8XQXyojhhCASnveylQ+VcKSYIkoUG++C3bTaxjXmB7yeVwLvPVDDCUspU41u6YcGqvZFTDj1acvGVoa48MmCOSQERx+DRBmhqOR/RL1wUoDhY3J0tgSmnQQ6JBBWiun/YnkqJwcaRY5Er8hD820BekLrERAjwrSRXbuWmuOvYB/RI61iwkd9P/tJ5yQmyvw9KGPVf99pPXv4x+H9Ib0EooJ1L6BRqwxlB6EAa6Y7KENVyYO9b7pKhH2oGvVs0FVeS00hq4X2upBrf+5Uf15iJSoewXCBU5bEg1usa1YLaDGT8jtHL7yoA64bEt3fq5ATZz4iJRZSV5o6h0EEY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0kWJDuormIwpUPZZtYMjOZdCeJxjvmiUtkloSbA/wM=;
 b=eKqNu5hxlga/AFdxiqM99Aud2Rqs0ey3vA0H2+2xFDJPaX62IyWjCZb80AhS1oqxUDFMwoe37fibwpRNsYujifxZmtbt6Dkb6Ogej1U3FvsB4UgTM3b6NQWqjR01CrPL0WsHIp8GaflMVBMsP3S9u29W3NXLr4yZiwn3G7ILb/Kawz4kKxR2fbLN6zBonrJINd4E6nfXNCV4MYmL5rAf5afmrJbFWkFN6QA9ohk3535X5/QVbKZPhYS+7HKIHBqg/q5q7lGeCCug9MXjijYP/Tyly5/yKLNmgR/ti+bLa3NwUyrUrFflrLnbO+AUDL2Ex+uKfOIF1QDD80ykP7ps6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0kWJDuormIwpUPZZtYMjOZdCeJxjvmiUtkloSbA/wM=;
 b=HxeAqs7jfnBqHfTXY3Ac+6jng4XFn8rdDfeZiwAW+ktnWvYhpdYWguZJzqTv1awMaOhB5byu1H+DwD3EOGycIYmYK2ZyPuSYjQm2+F/KjY/wxfbhbP8H6RFOuuC4+1cp/NfrpYYDyAk+B/4Ga1TQVHDrPOgkMcHAf/X1GzbR9gQ=
Received: from CY4PR10MB1717.namprd10.prod.outlook.com (2603:10b6:910:c::16)
 by CY4PR10MB1782.namprd10.prod.outlook.com (2603:10b6:910:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 16:03:13 +0000
Received: from CY4PR10MB1717.namprd10.prod.outlook.com
 ([fe80::96d:fd40:560c:3b0e]) by CY4PR10MB1717.namprd10.prod.outlook.com
 ([fe80::96d:fd40:560c:3b0e%11]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 16:03:13 +0000
Subject: Re: [PATCH v2 1/1] vhost scsi: alloc vhost_scsi with kvzalloc() to
 avoid delay
To: Jason Wang <jasowang@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>, 
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 netdev@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>
References: <20210123080853.4214-1-dongli.zhang@oracle.com>
 <61ed58d6-052b-9065-361d-dc6010fc91ef@redhat.com>
From: Joe Jin <joe.jin@oracle.com>
Message-ID: <7f9c745b-6944-ab6c-e231-ae0c55687c6d@oracle.com>
Date: Mon, 1 Feb 2021 08:03:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <61ed58d6-052b-9065-361d-dc6010fc91ef@redhat.com>
Content-Language: en-US
X-Originating-IP: [2601:646:c601:8dd0:74df:cf15:e9d8:2385]
X-ClientProxiedBy: CH0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:610:76::13) To CY4PR10MB1717.namprd10.prod.outlook.com
 (2603:10b6:910:c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:646:c601:8dd0:74df:cf15:e9d8:2385]
 (2601:646:c601:8dd0:74df:cf15:e9d8:2385) by
 CH0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:76::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 16:03:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e04dde-db1e-4c16-609e-08d8c6cae0f9
X-MS-TrafficTypeDiagnostic: CY4PR10MB1782:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB17828241C6EBCED7F2CF59C380B69@CY4PR10MB1782.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r83ZeQ374nsqwyfgZV494hMshxo/IjnwuEDJ10qrIV4hA2XHrhJdMCstZ4E3PQlSYzxS5CDRBMLmJeBkxoKA3nvaWaf88ZEXhKaYk91pbfR7Mb+o9yhnEODfJ8+9RUYGDv8lTPdv2ifzre3UK8mZlZdCA8/jHfAXXl/Sy6FJYEZ9Z06XDNeB1MDOG4o4OxCG5Ey4oZwVpUg1qQdRqmA7gQRLRsH3CwZU8n+PJTvd6LGytvacz4f8fiKUb3fXC6tC9XGUitxf+RnL+K+TYSGyYpdog+9dZrJ/IqOFbDU95npQCZMkginfl5mMWqK00xxNUUBNQZ8VM96T9h6Nu47/A+UaQrCClkYHQ+AoDyLBJIDi5C1Ndvs/xGxyJGurSrtoFjaMSpsa8YeBiuGJK7nb1lwMM/TpEYJSlFRPRjoPt7HyuiNuQ9cMKPk0CGUir4n1Fs1grlsUgp7rtbsuPSNEc8JiiZKOG8N25Fply5wQunMynU6wjFRK8VmWulqUZ4kjQLi9fXU6vmLPURPlYJnNFb5JJYr1RU/C2fKAelZzAufaWRmQc4ksVFnbAjTrtJDLc3cM5onA2v0hrMH8nHDfiyLqR/+1wHDwGzLbHd+xcd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR10MB1717.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(366004)(396003)(39860400002)(346002)(86362001)(31696002)(36756003)(44832011)(478600001)(2906002)(4326008)(6666004)(16526019)(186003)(107886003)(8676002)(2616005)(6486002)(53546011)(66476007)(66946007)(316002)(110136005)(8936002)(5660300002)(31686004)(83380400001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OTdtR2NIVmlBeURoeEE2UjJMMVhWZWZVMCtFa3g0cWM3bE9NTExDZUp6WTV3?=
 =?utf-8?B?VFg5TnN5bGlGN3FQMEdJY2loRjlZN0FzU2ljSE0yOE55NTRabm42MTdLRWVP?=
 =?utf-8?B?aHFlSSt3aUNQazV3SEtsVE9EaG8zeWZodkRubmcrNzVoc0Q5bXdiSzEvSnEz?=
 =?utf-8?B?Sll0ZXJLLzRwb2xDaGUwN3I5SDk3YWtzUVVRbE94MEx5d0xpQ3RuWU5hc3Ro?=
 =?utf-8?B?RStWaHFQbzhMcnl1cUhUSGorYmI3OTNEVk5mc2dKZmIwcVkxYkFJTmlWTE1j?=
 =?utf-8?B?V0E0Skc5bk9hVWc3VDVsK2NITUxLMzN6alAwcU43UVFic0FMS2EzclRsM3pl?=
 =?utf-8?B?bEpMaFlwSWJwNnc2azYxNkcrMlJXaHNGekxpOEhqSHZkQ2RUd1huNE9wZ2R3?=
 =?utf-8?B?RlJxSDZjcDhwTUhKRWlGZFByR1JUUGFGUTJmeWNEQlhlWFU4d1MxVnVBQTNZ?=
 =?utf-8?B?cUZkWnhKSVRtNHJsSy92dy9xeTF1NWVuY0NYbFpGOVoyQjVaOUEwOGRKRnhx?=
 =?utf-8?B?V2VsZGdLRzl5K1dDakFBVXF5dU5WQlQ0c1QyRU9nS2FrT3UrMnZsVVNQTHlX?=
 =?utf-8?B?OVpkNkM5cTJTUmF1VmpVcmlsQnlJMGNVd2x6aVFxZHg5bGE0QjRiRStzNi95?=
 =?utf-8?B?RmE4Ry8zYlJubWpob2FkMXAvZTlsb0pGRGRCbWNFekdtUFJwVFd1RWJjclU4?=
 =?utf-8?B?NnBXZ1ZyMzdhQjdWSDZPdzZ5cGFhNW5JTE04QjdEUU44VVM2bjdIMy92YW1I?=
 =?utf-8?B?S0d2TExuN3BpQXZyWmdyT2M5MjFSTDQwK083RGJrbjVjdHNBN1h3UzBPYk9S?=
 =?utf-8?B?T2I1eXhPUTcwZm92RHBvQzR3bVNGL0ZaaXFuM0Znb2NaWldEdEFLMWhhWG9Z?=
 =?utf-8?B?VDZsRDU2K09wUHNvb3NWb0g5NEJvN2hqL2l1MzB6d2JpMjFUcGtiY1BKRVdt?=
 =?utf-8?B?VTRVMEg3QTk1RTZsd2ZjaGVaZlpIeVIyN2JmaldVemg0NFBvOFZVa094VFJ2?=
 =?utf-8?B?MlZOU2NNVis5YW1pYjBMOHRaQWpsNjlnTjlyMmNRd2dIOExaMGEvM2hSMlNS?=
 =?utf-8?B?aEVsdVNKSnlIQU81SThybUlDeEQvQmEyNzJmWkxIbENpTEg1bGQzN0JjQWds?=
 =?utf-8?B?UU1HOWJTZFVOVnh4U0dqRnVNNmdOVDlGNnRaUXN5RW1DN0xQY2E5a0ZkR0FW?=
 =?utf-8?B?WEF3Q2YwR0NOVnVjTXRRNktKOWxXMWpKV0xXNkdDMko1bVlWNGlBZnZSSUhv?=
 =?utf-8?B?MGlwSlMvd1d2MGJUVjIzeGtoMnI4NkFtdExOSklDM05Kc3padW5GTVJUcFBz?=
 =?utf-8?B?R3ZLUnk2d3FiSDN0WEVhZldYaTYydDZkVGRqSzBnTHBtR1c5dm94NXB1cTRS?=
 =?utf-8?B?NzFqb0NSbSsrZnQ4SXl4akJmU0lRdkljSmxRY2xCQmJtQVMvQ1NtQllPWWw3?=
 =?utf-8?B?RDZoaTNHM05wZUMrd3hwS2RLcXExVmorb0t5MWR1MFdZVEw3WFc5S3pyblhp?=
 =?utf-8?Q?E6kKAFTIJsOqZdDmDGfOkRjaYF6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e04dde-db1e-4c16-609e-08d8c6cae0f9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1717.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 16:03:13.5147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zdqk7VSypfW+P3/byr5NpXl5Pm37CIT6c6yP8/QSEtayL5AkIcUmdVs775BAooYEOi7fTfzwiNkS567zI2IRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1782
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010084
Cc: pbonzini@redhat.com, aruna.ramakrishna@oracle.com,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, mst@redhat.com
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

Q2FuIGFueW9uZSBoZWxwIHRvIHJldmlldyB0aGlzIHBhdGNoIGFuZCBnaXZlIGEgcmV2aWV3LWJ5
IGZvciBpdCBwbGVhc2U/CgpUaGFua3MsCkpvZQpPbiAxLzI0LzIxIDc6MTIgUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4KPiBPbiAyMDIxLzEvMjMg5LiL5Y2INDowOCwgRG9uZ2xpIFpoYW5nIHdyb3Rl
Ogo+PiBUaGUgc2l6ZSBvZiAnc3RydWN0IHZob3N0X3Njc2knIGlzIG9yZGVyLTEwICh+Mi4zTUIp
LiBJdCBtYXkgdGFrZSBsb25nIHRpbWUKPj4gZGVsYXkgYnkga3phbGxvYygpIHRvIGNvbXBhY3Qg
bWVtb3J5IHBhZ2VzIGJ5IHJldHJ5aW5nIG11bHRpcGxlIHRpbWVzIHdoZW4KPj4gdGhlcmUgaXMg
YSBsYWNrIG9mIGhpZ2gtb3JkZXIgcGFnZXMuIEFzIGEgcmVzdWx0LCB0aGVyZSBpcyBsYXRlbmN5
IHRvCj4+IGNyZWF0ZSBhIFZNICh3aXRoIHZob3N0LXNjc2kpIG9yIHRvIGhvdGFkZCB2aG9zdC1z
Y3NpLWJhc2VkIHN0b3JhZ2UuCj4+Cj4+IFRoZSBwcmlvciBjb21taXQgNTk1Y2I3NTQ5ODNkICgi
dmhvc3Qvc2NzaTogdXNlIHZtYWxsb2MgZm9yIG9yZGVyLTEwCj4+IGFsbG9jYXRpb24iKSBwcmVm
ZXJzIHRvIGZhbGxiYWNrIG9ubHkgd2hlbiByZWFsbHkgbmVlZGVkLCB3aGlsZSB0aGlzIHBhdGNo
Cj4+IGFsbG9jYXRlcyB3aXRoIGt2emFsbG9jKCkgd2l0aCBfX0dGUF9OT1JFVFJZIGltcGxpY2l0
bHkgc2V0IHRvIGF2b2lkCj4+IHJldHJ5aW5nIG1lbW9yeSBwYWdlcyBjb21wYWN0IGZvciBtdWx0
aXBsZSB0aW1lcy4KPj4KPj4gVGhlIF9fR0ZQX05PUkVUUlkgaXMgaW1wbGljaXRseSBzZXQgaWYg
dGhlIHNpemUgdG8gYWxsb2NhdGUgaXMgbW9yZSB0aGFuCj4+IFBBR0VfU1pJRSBhbmQgd2hlbiBf
X0dGUF9SRVRSWV9NQVlGQUlMIGlzIG5vdCBleHBsaWNpdGx5IHNldC4KPj4KPj4gQ2M6IEFydW5h
IFJhbWFrcmlzaG5hIDxhcnVuYS5yYW1ha3Jpc2huYUBvcmFjbGUuY29tPgo+PiBDYzogSm9lIEpp
biA8am9lLmppbkBvcmFjbGUuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBEb25nbGkgWmhhbmcgPGRv
bmdsaS56aGFuZ0BvcmFjbGUuY29tPgo+PiAtLS0KPj4gQ2hhbmdlZCBzaW5jZSB2MToKPj4gwqDC
oCAtIFRvIGNvbWJpbmUga3phbGxvYygpIGFuZCB2emFsbG9jKCkgYXMga3Z6YWxsb2MoKQo+PiDC
oMKgwqDCoCAoc3VnZ2VzdGVkIGJ5IEphc29uIFdhbmcpCj4+Cj4+IMKgIGRyaXZlcnMvdmhvc3Qv
c2NzaS5jIHwgOSArKystLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvc2NzaS5j
IGIvZHJpdmVycy92aG9zdC9zY3NpLmMKPj4gaW5kZXggNGNlOWYwMGFlMTBlLi41ZGUyMWFkNGJk
MDUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4+ICsrKyBiL2RyaXZlcnMv
dmhvc3Qvc2NzaS5jCj4+IEBAIC0xODE0LDEyICsxODE0LDkgQEAgc3RhdGljIGludCB2aG9zdF9z
Y3NpX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmYpCj4+IMKgwqDCoMKg
wqAgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqKnZxczsKPj4gwqDCoMKgwqDCoCBpbnQgciA9IC1F
Tk9NRU0sIGk7Cj4+IMKgIC3CoMKgwqAgdnMgPSBremFsbG9jKHNpemVvZigqdnMpLCBHRlBfS0VS
TkVMIHwgX19HRlBfTk9XQVJOIHwgX19HRlBfUkVUUllfTUFZRkFJTCk7Cj4+IC3CoMKgwqAgaWYg
KCF2cykgewo+PiAtwqDCoMKgwqDCoMKgwqAgdnMgPSB2emFsbG9jKHNpemVvZigqdnMpKTsKPj4g
LcKgwqDCoMKgwqDCoMKgIGlmICghdnMpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
ZXJyX3ZzOwo+PiAtwqDCoMKgIH0KPj4gK8KgwqDCoCB2cyA9IGt2emFsbG9jKHNpemVvZigqdnMp
LCBHRlBfS0VSTkVMKTsKPj4gK8KgwqDCoCBpZiAoIXZzKQo+PiArwqDCoMKgwqDCoMKgwqAgZ290
byBlcnJfdnM7Cj4+IMKgIMKgwqDCoMKgwqAgdnFzID0ga21hbGxvY19hcnJheShWSE9TVF9TQ1NJ
X01BWF9WUSwgc2l6ZW9mKCp2cXMpLCBHRlBfS0VSTkVMKTsKPj4gwqDCoMKgwqDCoCBpZiAoIXZx
cykKPgo+Cj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4KPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
