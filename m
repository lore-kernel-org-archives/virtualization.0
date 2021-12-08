Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C014C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 16:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D04E882BF5;
	Wed,  8 Dec 2021 16:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BumxK151ulY; Wed,  8 Dec 2021 16:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4500F82A4E;
	Wed,  8 Dec 2021 16:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11F93C001E;
	Wed,  8 Dec 2021 16:41:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B7CCC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CB8460726
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Gudh/4aV";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="bYi2hell"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FbdNbY1MHHAL
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:41:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FC5760703
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:41:18 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9bMj007110; 
 Wed, 8 Dec 2021 16:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MX3Kr4XgoNJtu/I0HHHf3WKBUNq7nj6YcV69w5xxMoc=;
 b=Gudh/4aVyjRDJDFTJxmuoocMe7UWWorllmy273EH/Ia0fkjUGlQLLdwXeZNUhR4j4yih
 APRaXFwZ1Za9sMuBEKM1wIEEwt7sQyItFc54Zal0dQnZjoa7CG9tRrBzy5LteJNEWZGY
 MLh/y86A64GhjV/tTn5jK713tDvy5y2fkv/k/a+hCkt1osoykVwD8qIe3VYr5e8OC4QP
 C0Yjp67d7zohhbpUFikmDBEh6+aZnAfEJ1NJo4nWTfk5UaD31THiVZOA+zuBFGueTEai
 ZAh28WBvEjFfc2EU+FwKirDxnyNSWc09+vAXuUrEEsp/tjtXL1w2v5nCAkcCYIAQqSIa Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1h429-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 16:41:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8GKlFR010493;
 Wed, 8 Dec 2021 16:41:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by userp3020.oracle.com with ESMTP id 3cr1sr02u9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 16:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fshBQ9cQgJBrrixxMOQfsb0LoWq8QPwb2hTcAhDITK/r+nmU73SGtgo6CxrGZLk3jVHu7cobBOBLDeGGhU+Rs6FxlopP8lcaOr5H6jJCg06e4KWbZJxdR20HCwiSJVdOXNHRlfUITm2XmaHDTisJfO3ilAU+EkyXduaVFLF4GSpIvNRMlCub3+2QQpYgk43I6DivXBCWlxa5/lWbf3ss0uucYLOn6ccse4E8auTjrhgLXRevraFRBBszFsOoCz2xpd6FnUJ4d5CbWuAjk2V+2sMp/qak2txcVn6LZ2435XfWmL7V1s5KtM+UbBtPxOwGhg3vrYXyNSqFmgBM8tbdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX3Kr4XgoNJtu/I0HHHf3WKBUNq7nj6YcV69w5xxMoc=;
 b=AM4UtsMK3Sjxs6JSGPuqTYyPVjO45VVrjXQYJmtw+RVjaYuXHeIwvZn3ud5ly72Tm66M57sxfZTeVJsUbTwN7GyvbnzUqbqJzoU/qOza8yuKdRBWfconZNQPsZgqB+1sJwaEUkCTMN0U0GyAlw8vJDBoZQdqp/fXzN0/ZbX1qj+u1jj2F6gEZZl5TMW3JMXS+Ok9zA8Auuodws/Z0C4XhlRWbJ0XTmqZUxADjvyC9q2RXjjRsGgjiy3R1QTT9+pELOnu2Iv5/matWh9tvUwLCv4Sj95ONVl5nQRjLHbfWsZDVsoNzAs5K7k8FVPERCWS0SQakeQpS/X9h2HkDmTAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX3Kr4XgoNJtu/I0HHHf3WKBUNq7nj6YcV69w5xxMoc=;
 b=bYi2hellU0B5j73Z4xGA3fNVuH+jGJZF7C5VALFrs4iBwY58tpkIn6rLd0nmoNEoFrT3MXLZ9lgJFugCJ7QlemFCLV/vhlV1ZOOB/9+UPvIE2jnl7R85IN9Kwl7sQzlKtJxxAso79OGeF1RqojBX0Qe6yQ0HoEvIyXWeolXE7ck=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1609.namprd10.prod.outlook.com (2603:10b6:4:11::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 16:41:14 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 16:41:14 +0000
Message-ID: <6726418f-c9ae-04ba-eae4-0f36f048dff5@oracle.com>
Date: Wed, 8 Dec 2021 10:41:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/7] vhost: get rid of vhost_poll_flush() wrapper
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-2-michael.christie@oracle.com>
 <CACGkMEskNm079dzOaxNOFA6_K4r-9=hAs8VXcxqi4SKDKtozsQ@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEskNm079dzOaxNOFA6_K4r-9=hAs8VXcxqi4SKDKtozsQ@mail.gmail.com>
X-ClientProxiedBy: DM5PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:3:7b::29) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.204] (73.88.28.6) by
 DM5PR13CA0043.namprd13.prod.outlook.com (2603:10b6:3:7b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Wed, 8 Dec 2021 16:41:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c4d6e6-232f-4c29-deb9-08d9ba698c42
X-MS-TrafficTypeDiagnostic: DM5PR10MB1609:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB16096F847D8D410714D8B9ECF16F9@DM5PR10MB1609.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek3CUIVaNLywqQLhVMIlxWgR/9pvbmQV+Txriw9bzFOatpDUhRI+lPeHoS9bRThbwvEu94mXvGSM3MMISEyzH8cH6rWlPhr1UhZvD+8pL5VgmrKKolQNitQcUW40kKDqM/vEc04SS0q6126SeyZSfNi0NbNQwVgZSKkniV+ozggMzhvt7uOwG5ruaKEx7ehKQBFmcL7LzU5FSTWJmoWpPqkhQQaFG1b64epTe/ZF+luaNLPUqVnTK3nRWwEgsSH5tps7p6O0B2kPYKTB8wbJbaJwYD0OonRXar2StqkNopqduEHGNCS3WJBI0LEzdAlhuhNuIFzHY8dW0wxv6zPHwNOUfnfBy9nJn7X6AxI4Pom6hb032lMT5n6P9naWgLSg2NIteUKxmn1SAvRNxh2L9HOy55GHG0Oo8DcTYkpErGBx8GpIaRxV1Dg+MGel4RIkfbbaAZkkDJvDw68JKM2tRsRUG1QyPZVYhdzdqHHxKXn26h/S+wkbSCSRCOiFOQo9ZrUNHCjo2zI8czp9EVnp+eYn6I04iO3i00i9XBMqng6FhMUAj/vx88aD+Kik4fOG5SVVIgCCdMXgxwvhhP9kWGFur+PkICM/4rE1twt0eCZQF0WPY8SQ7Cq1InR0JVxZHvUsaBLXwCwE0oij1F+SBTIvuBx1tO9HZbpYW4tQkLH3OYc/UZmXmVHsXc5lT6xAeNA5UmyxECNWO7soN8RzN+Ma1VL/kBYePr4IeZYrXXnaxTvCs8tpjYf7tnU8NV+LE3pIS095N/9gUSyyjUK8TTplnEJ6uu107wRX0EK1BHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(38100700002)(186003)(66556008)(31696002)(6916009)(54906003)(86362001)(66476007)(6706004)(66946007)(16576012)(8936002)(31686004)(2906002)(956004)(36756003)(316002)(26005)(508600001)(8676002)(4326008)(53546011)(6486002)(2616005)(26583001)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1CM0NYWWVxRE1zUjlDaDIzeU1KS0trZHdUN2xkcjlWczNsanZWc3EwUGsx?=
 =?utf-8?B?Zms0THQ5SUx0OTFyOXREM1ZrNEZiY3U0Q1ZTUmJGVFFCRXEyTk5OMWNZZ0Fh?=
 =?utf-8?B?MGpveEFQMVZZemRzN1JXNFRuTVFDWVUvLytnT1FtUDBiU2dVcEVaZkEyK3ZL?=
 =?utf-8?B?QTVEbnlmL1R4a2hjZFhidWtOMUxITDV0SGlET1dhNld4KzZVeElkWXRVYzBD?=
 =?utf-8?B?SlA0L1htSHg3VjBPSGhHMWdhcGNaSTRrK2xIcDdBNURPU2ZVaVgzOUJNSGt0?=
 =?utf-8?B?Q2twNHdxMG81Y3BGdEtncXVrMlZxMDBrTWNuUkhxZkFTc2c2UVpBaUhYOWVK?=
 =?utf-8?B?Q3pjUStBa2QrK1RxbytteVBEbGNjUTR6eFBLNVZ0VWVCM0pnQ1BMenA3TGtF?=
 =?utf-8?B?SzJSV1RKc3lKYnBHKzBEdHlsVlAvTlR4bTZnYVl1SG03bDlqbGtYY3NDZDlE?=
 =?utf-8?B?SlQ1VU1tUk9tMVdEYVIzRzVEcHVEeDd4T0FFSDZjdzllMm56YnVIYThTQlQ3?=
 =?utf-8?B?Sk40QXNtaFlTOXBjNTVJMzFvNDAvQTM0SVZLa1I0cmpnV1pLeEx4Qmx2eHNO?=
 =?utf-8?B?K0Q2MWJCNUJmN3BkaytLbEQ5bHRGMkR1aDJJUStVWmNNVlpod2NkMlY4YUdo?=
 =?utf-8?B?R01VczRZQnhrVnVDb2ZaampuMjdkK0RrUWhyWUUvbkNEV0dsOUY5dEhRL0pR?=
 =?utf-8?B?dWc2WEhvbUFUMWgwSmNQdFI5VU13dzlWYVRDLzdnYWIvb0JkRW9XMXNqQ2p1?=
 =?utf-8?B?RVdnUlo2SWVhNmI2c0NwOHlHV2JJMk16Qkc3OEwxZDJvV0FTNGQwcWVXNGUy?=
 =?utf-8?B?V2llNnVET05ocWhqOStRNjBXd2VlT3Z4TG1mZzdua3Bpdnp2bUlzTitHY1ho?=
 =?utf-8?B?Ynl5MG5Lbk84bVRzQ0ovemMxenA2YnFzeWZTTnFmY0ZSQmlSQlRvL1VlQit4?=
 =?utf-8?B?K0RaaFE0alVxV29KUEs5aTRJY29aTVlIY0lkbGxKdlArNVdETFFWMjR1MWFs?=
 =?utf-8?B?VzA4dFJhclBMWGd5REpCKzZRRGxYY0J6eFBlQ1NFL2JMTW9ldGhNQTFaMXF4?=
 =?utf-8?B?UnZoc1lIZTlJNjJyMXhKUFZEcFJ1eFA2UVk5NVlHVzNoRmVYV0Rxc0VkNHBV?=
 =?utf-8?B?Ti9GREdvMnZWaUdkaDBEZkhkcnUzZTcwMW9hckt1aC95M1FoZlNCNDdBSDd2?=
 =?utf-8?B?bHp2SEdVajlIcktGUnY2c0RkUzZxUld5ZkdFRnVEaGxXa3U3UmVybmJDenpU?=
 =?utf-8?B?OVkxQjJFVmdTOG5YbFlPcGpvQUtjZUw1eXRTcmh6d0xzZU5HS0ZBUkpqeWJj?=
 =?utf-8?B?SVc0a2RPditPcStac1dUaWowaitUYmVJZGJjWnFudDVWNy93MnFObDFXVHZU?=
 =?utf-8?B?YXlxdkFaWkxNU2VaQm94S3V5Nk1HMko2TjlMdmh4TndCUU1CT2NnVWczd1lL?=
 =?utf-8?B?NWJGbVdDSnRRdTNNM092bzR6WDdDZkZIRUNqR0JLbmZZZEtlcW9KTGRVN0hS?=
 =?utf-8?B?SzdZN3VsUm9WVHNSUllUd1lPOG9LVElZeHI0bUlNTDAzcXgvdHNmbmpLVXJT?=
 =?utf-8?B?RlVNTFpVSFZRTDZuRXJUSzgyeUZrUXVVR2FKV2QwNi96UkNQck55bmN6ZHZw?=
 =?utf-8?B?N3lsbERCTmlHcDI1cUFIb0VCd3hpcEE1c3F4WDBzaFQvUDNZRWVZNzlNRmlh?=
 =?utf-8?B?TEJTWHN5MEhaRmgwck5PMjd3TEQrUnJvWHN2MjB5NExNWjdORzRXaHZTUUtm?=
 =?utf-8?B?R2lUMTZTeW9WZ2V1dklCelBRRnRzbVBuaGZsUlg4c2RSaHRnTVhPOVlyMGhD?=
 =?utf-8?B?dXo5R2VMM0lmdHN2SHVudmRYMC9BSkNUbGtvZjc2aStpTis5ak9qTlIzUkRG?=
 =?utf-8?B?RGJsaGNpdGlRZ0puaFByeERxdUc5TmU5WTlCcDJ4WERncmZXZUhoeTlrTGJW?=
 =?utf-8?B?Y0tSNGtBVUVsdHFUL1RDVEVvRCtUZW5Ualp3bmhwd0hXK3pxZWlNWitTV0dB?=
 =?utf-8?B?NDIrRmVINUprYzZOTVQ1SXpoeGx3Tmwrd0JzME42akxINm5CVm1PMnM0WWpn?=
 =?utf-8?B?MEMydEFFVmp4dUdDRnZGWndmQlJobHFlVE84NG41TEtHWnJvekJSQ21iVmJU?=
 =?utf-8?B?KzY2RlhoV0hPMzNzZG1aOGxIeWpqUTArVnFBTThJVlpGSE5XdXJCMG9hYlk4?=
 =?utf-8?B?cnZkdXlLRnQzRlYydUpOdy9pZy8wSnFydlNWSFduM2NyaGhJMmNwSnY0TEFK?=
 =?utf-8?B?bGRqVm9sSlV2Y2pBSFNCbG1SVnNBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c4d6e6-232f-4c29-deb9-08d9ba698c42
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:41:13.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/fSUMEvM+3Dro0baPqzQ2WsFtdc/ORloxybOkIZP+AaDk6+19DxHWxhAPSm0MLR8ibyIPAuuB76g9Pm7+I+eKmrOfuMoe9MAqKmBbTYSf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1609
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080097
X-Proofpoint-GUID: mG4lGwerZqmtAotEFgZMt_1IeRl5eGNR
X-Proofpoint-ORIG-GUID: mG4lGwerZqmtAotEFgZMt_1IeRl5eGNR
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On 12/7/21 9:49 PM, Jason Wang wrote:
> On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
>> It gives wrong impression that we are doing some work over vhost_poll,
>> while in fact it flushes vhost_poll->dev.
> 
> This "problem" is a byproduct of 7235acdb1144 ("vhost: simplify work flushing").
> 
> Before that we indeed have per poll flush flush.
> 
>> It only complicate understanding of the code and leads to mistakes
>> like flushing the same vhost_dev several times in a row.
>>
>> Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.
> 
> Not a native speaker but since we don't have an per work flush, is it
> better to rename this simply as vhost_flush()?
> 

What about vhost_dev_flush?

For the existing naming when we have a function exported we tend to have
"vhost_" then the object/struct it works on then the action.

For work we have:

vhost_work_queue/init

(we also have vhost_has_work which doesn't follow that pattern but
would sound strange as vhost_work_has so ignore that one).

For dev operations we have:

vhost_dev_reset_owner/set_owner/has_owner/cleanup/init

For the flush operation I wanted it to reflect it flushed all work
on the device, so I mashed up the work and dev naming above and
I agree it's a little strange.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
