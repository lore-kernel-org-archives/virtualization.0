Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A3EB64DC
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 00:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B2749404A6;
	Tue,  4 Jul 2023 00:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2749404A6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=bavXmkgl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=knZObl8c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDWr9YVPVrV4; Tue,  4 Jul 2023 00:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28DC3400C4;
	Tue,  4 Jul 2023 00:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28DC3400C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDB08C0072;
	Tue,  4 Jul 2023 00:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD53C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0154C60BBE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0154C60BBE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=bavXmkgl; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=knZObl8c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0vW0hjpL_447
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:26:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4FD69607EC
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FD69607EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 00:26:13 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363G8LFL029183; Tue, 4 Jul 2023 00:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rRNxmyaJnbOnyIUTN+Nb8x00Ap3D53Z9EgnLjL5g7cw=;
 b=bavXmkglSgGNGnkdoG/59Qw6Qt0YvnDJeV8xt3TVFjyUfGEVx4s0A1UrwlyUu+pH0d33
 UIyr+xgtgmHL4wRShdxjATRlAa5imygEvczBDw8SeU5JPMuHhbk3CaN3qW3D9y3atX5Z
 pxWOQLEB9XnH32D04ro2x5DII/Fqnjc6awS5dmmNgjPmcd8+Jok6Xsr9THs4gQIPxCTd
 bTyupmc53PPOZH6+WuH+CyjY4+mat5LFWrS0WGNZoMIJg/BAOWXcQJxhcnzJD8QznHne
 lpGtIz/fYQDJN6xcSVvokrFUK6jbhHaCy0+PF368yntnH4t+euGiJ5djG5DivSekQgd/ /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1bm4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jul 2023 00:26:10 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 363MUkOY004182; Tue, 4 Jul 2023 00:26:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rjak464b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jul 2023 00:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KosCqiLxaYF5a87zPVx8NOOEHd5dxDF56Q81ZdEevWJlJAKG9+ZuUG6nrDNA1gAULIk/VVHlIJCSMXOdB0QGXvKd+QPfPkcl6v/rFU4au7QQsVepRWQgbft5sGRi+t9FJgQzirYLQLXRMXBrdmJxAqW++RUrzLF6udeAS5ZzOGzAm10nRGPenaNBTjOv1J9X661r52lvHez64UMeC2EPxqH6WZwTR9pk8KIK10DnWEzOjpzmFEGXW91qeE3b1xFWAsX38KWW83o1lD0eCu5/bS79x2sZrdy7izaZB/I/lOFB8VtrmXslSxRYSoDq0DfNw1JGm0dm3Q2+g/q8/EmiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRNxmyaJnbOnyIUTN+Nb8x00Ap3D53Z9EgnLjL5g7cw=;
 b=P7PH9B3dn3T9C5+5yg7ZLgb7jQvuYq9TaQkFH4w/+QeqInw11BATwz23RSXOIYO9PM6MmIjKZMl914WfgdlsAbmFVIcaYsJUZD8kQ8MMQgCmUiWqBMhqtDyDToOkReGNWmG5N+SsKffwb2QQmnqxwg+zYY4EKDZR87cn57VUH0bDwcjfIqfkAiZJY6mwbN9XoiR0b68sx1ZvurERP8CvaG/n0L38jN3uGAIVlvuSVO3f7pnaPwKsrfrPLE8HqjOOMrC5WT5Ah0jlKFCOZxRnnwTUC9LI0OBpwsQxja3s4wfMgiGWjHnVhR5m/vPC9UrfTpvo8MU6z6821l6z9jqHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRNxmyaJnbOnyIUTN+Nb8x00Ap3D53Z9EgnLjL5g7cw=;
 b=knZObl8cIET8aYPFLzCZsToINV+PcKWkbRdCUZdlElYNGa3M3lmG9HCQPR1utTOR4BbDh7j2nRv+Rkwr8CByhUPKz6/tmPn0ja1MtLUtBQl5P+mpyp1zB1WW+aVcHwD8VfFbF566YeGsScndAnwd33pKY02b+w9LpkEN/+0tokI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 00:26:08 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9842:10ce:30cd:cd06]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9842:10ce:30cd:cd06%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 00:26:06 +0000
Message-ID: <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
Date: Mon, 3 Jul 2023 17:26:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230703110241-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:806:28::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d63327-9327-4409-e746-08db7c254213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP3vDiDmS7DvCNCV9sue9DlU3OfS+oID70FxqfqMhkR14W1McAuf+7iDCd7futeUvOxD7FnOIiPz9zEeTDKCcCkS9fYAAKxlpLUYtDHMxHgH8Ho/38k2XWPRD8qwYCVMVi/QIflsk+x2nMQQqq6wA7TG0uwqdtLC7vjXX6J6Z/vuToJyX4xusKmpSRG/RDxGv4N8jktYH0n6aRXYfbHYMOF5PkiqWDD7L0uG37XGKDeyK2D6SANSB0eOaSyu1Ms+260TFr77LWICdJ0BzbuWeO7JoKErmc6lVbE9Vr2j49PUMedAkygTy17XF6kn3I5dbm5Et+AoMeX3Psz9tb5AyJuy8H4RZPgc61BFp9uhOYN3FYci50jMZrhuzMsR/msg8UPCIjk1Vm5OG3QJERiZJUS7eU0Okkcl/X6EyYJ7JlikRgLUUMuewrSikDLfFtd9ple0lI9kMfGCHN9fpCWyhlNW8draG+f4WmsJthfAW86wqKJJmLZ0t9HRReLMfe0w1XZGixqnYt3OWAV7E4s9h9hPNk4Jtb8SRxD6gaYW3DOb1288Hmo0fAkC/pa1bIy21MU7xG5tTjHrd1OvqkRrX1XlhcCx4J4ldczK1MPbPx+2XmrKAOWkxZ17HhcEbtfnY8LnUQ3BGW+195DmhdCeiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(66899021)(478600001)(54906003)(110136005)(6666004)(5660300002)(8676002)(8936002)(2906002)(36756003)(86362001)(31696002)(38100700002)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(31686004)(53546011)(6506007)(186003)(26005)(2616005)(6512007)(36916002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGw1Zk5XMXRIMDhSeFVPSkI5V1RXVnltVzJVQmQ2Qjh6OHJQZGFualBCT1Bu?=
 =?utf-8?B?STl5akx6UU54WEViWE9Ub3J3K2VUVS9EalB4UXU0b3Q2REc2a3FlL0g3Mi9T?=
 =?utf-8?B?NCtZalFKR1puUU9XWjEyQlFkVkZQenpSNUsvZjJPN1dLOURCWmpuMU5YTWdF?=
 =?utf-8?B?RG9MMEdybTdkTXVxWXp1dEVBOVdQUVpaRE4zTTNzTExuUUplOFRWcmxxMWYv?=
 =?utf-8?B?WEtRSGsvSFlHdWdRM00zUnEyazFyckg3b2M2V01ldk1xWDJxZjl5K2FkZGgy?=
 =?utf-8?B?Y1drcU1WUGJwWXE2YjNJaFU5c2dXZCtOZDNycDNoelZubG95UUJ3SGdTVVI3?=
 =?utf-8?B?SlF2Zm4vaXdLSTRWWS9XZGQxdUhzRENSY2lvanplSFYxeXQ0bVdIV3dFQ1c5?=
 =?utf-8?B?OFJ6R0VUSUlreFF3NjRvSDl5REYvZk9hc05IWmxpcWI2aGVaenRNSUF4bzU3?=
 =?utf-8?B?ZE9EbDlMZlUwTnNkTnBDMTVWRXVjRXMxVXNXa0hjaEJiOEZRbmU3NnlDT0pz?=
 =?utf-8?B?bWFqYllPVVVTdXBJWkM2VzgzTDBqWEtTN2hPTmdJajc1SGVuM2RWMUFqU2JD?=
 =?utf-8?B?MHF0N1Z4Y0JMOWpjYk0rOTNXK0V3QWNEdDVIdU8xZ2RpRkQ1aVN1M29wRWJ1?=
 =?utf-8?B?VS9SNDMxQ1l1dlVEbFN6OVBnUlFZMnRMUlI0VDJ0R0xyU2kwS3lNU25hdHZ0?=
 =?utf-8?B?cnl1UlFDbUtVL0lkNWhOQjRCdW9rUFUvWkRFMng3R1hPclJqdG9FdDk4OUMv?=
 =?utf-8?B?eFN2K2dTSzEyVDdpSTJaZ1hqSUVxenlQVWdzR1ZDRm0xYVFKMFBZMWQyYkZC?=
 =?utf-8?B?bEIyZTR1UHJnVEpTVVhXbkNibU5vb3cyUlQrK1ZMaWdwL2lBcnlrcDFYbW10?=
 =?utf-8?B?bjZOS09VNjRLWUl0WENqMjk2bVJBbW5SWmFUaS9FdE12WFkvdXBleHhQaHkv?=
 =?utf-8?B?eHlLNG15ZlE3Wk1VQjNpanRJUk1CRDZzUy9jV1NnVVRseVNtaFFjUERIcnZT?=
 =?utf-8?B?RTBQaDNpMUF3T05GQTVqVklkK1VnbW4xZVVRNEdVeGtDV29BZjE3TWRmalJB?=
 =?utf-8?B?SFhMSnNmdGVPNEg1UU0xVkpObmpHUURFVUxGTmZRNS9FSWViOGZMOE1ZMXhQ?=
 =?utf-8?B?WWNvNXBGak4rSnhKZHdjSVd4NGtHaVcvWVdsOGFSLzVJdmhTVjZwazdPYlZi?=
 =?utf-8?B?aTIxd3UzSGphdTNURlhxdktxYzlpaGZxeUp2Y2VXK2VmRjlUaXV5dDZRNHJj?=
 =?utf-8?B?R0phWnpsTjR4TjdNa0lMekdLd0MxaFB1T1lSMFRkQ0hoN2l0cnorelFBcjkx?=
 =?utf-8?B?aU51RE9kanRtNnhvcVBqMXVuTExxbXhQNGNDQ25BMEd0aldWbTdNMERudFM4?=
 =?utf-8?B?blRlZktLYnk1WGllUk5LVWxSd2FCSUdyZDE5VEVCT205UFlFTU9HRjFjemc0?=
 =?utf-8?B?Mi9FWFUwYUdCYUZOalNsYkQzY09ydlEvZlRRbk5JNWU2ZWprNU55TWMxK1Fp?=
 =?utf-8?B?akwvMHY3b0JRQVJXZk11bWh6RmphWWczK0VQYkJ1cXJqNWNad0tBMUdTRFIy?=
 =?utf-8?B?ZXFSVmRoWUhKc2tZTWdzWlRMSzhiMysvTnNkM3FnVjE4WlVPQXVqMXJmVGRi?=
 =?utf-8?B?OE1lbWZNb1pETG1CcDlDaDBHV3UvUnFqOHM5aWxDczhMNVNEeFMvZWYwRHVU?=
 =?utf-8?B?bFFDOG44dTBHQ2dSMWJTbytCajJYUkVnYTU1cFlXeS9LUmYvcWFIR21TWm54?=
 =?utf-8?B?bFZlVFZNd2hKL3V5ZnBIK0hGSnJIRkE0dk9EU2FPMEJ2RFo2V3JyeU5jazJT?=
 =?utf-8?B?VE1ydGU3MVFZUFlFRm9aRFk0MndiNTRBVmQ5dWVNU0hTTzI4UHhMOGxvZlZz?=
 =?utf-8?B?Vk5jdVh6RU51bUhPYjFWY2RmMEZrUFhxZ0xJalVWanE5WkU2TUx5ZmIwdDdT?=
 =?utf-8?B?UUZpUUJGUUVaNk1HdVpBb21NenN1clltdzEzdkVKYW1BT2VrTWFTOXcxcTRa?=
 =?utf-8?B?L0FjVDNIbTdLcDArQUxNK2hhMEMyODdudStHR3E1M0M4ZlhiNXVCSlNCeTV2?=
 =?utf-8?B?VW5vT1BIVTB4QUY1aU1Pa2hodmVZMGxBZmZOWitEMXJkQmpWdFBXN2lrc1ZX?=
 =?utf-8?Q?A1BgooOLxbuXZKfMm3Tw0HYny?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ckZUR3ZwcHd3aXRTMmphY2dzRVNkVnNqQmFVZitjM1lQWkRlQXluUFhJckZy?=
 =?utf-8?B?RmZPNyszdWd5UHRobHVLaGFzZXVINzVEc1c4aXlnNHVuNEZpdW55RjNLY2Ra?=
 =?utf-8?B?QTVNQ1YwYUtBYWdlVU1nVU1EZlh2NjAyL0Vlem5jS1EzZ0duQzRtNU5Ia2FK?=
 =?utf-8?B?VVRHYU91UGloQ0Nucjk3a1lsYWsrTFdoK2xtbVNiQXlXRWlpNVdRcXJMZ0Jh?=
 =?utf-8?B?SjhjdXZHM0JGZFdpbjJ4a1g1ZnFNU0ZnWGx6VUZhdS9IMzhoK2xnYThOek5S?=
 =?utf-8?B?eHM5Nmd0MnZZYzBOa1lBdTVBNitTN3hjcnY0T3JwWUFGbnVsampBQlNQTU5j?=
 =?utf-8?B?RFAxYWE4K0FFcWxZZXlzY0l1ZWlWRm5KSXBvZmNTMzJOc1F0M2xBK2h1U3Qv?=
 =?utf-8?B?NTBlSGU5c1B5eDR3NTYvSThxaHdTeGh3a3NyMnBKVVVGUFZMNVNWUENDRXJE?=
 =?utf-8?B?NzJycGpadFl1NXJuS3I5TTJyWVh3Ri9neUFrdXpXUTB4ME5NSERnZVpDV0xL?=
 =?utf-8?B?R3kwSkFBT2EwTXFPUGpOUGU2cG8vb09iT2dobHl0QTBoNkg3bUtlN1l0Yk11?=
 =?utf-8?B?aWx1WXpmNzd6ekliRzlTMUtML3BkeWFUbzZFdG1DeUczVGlmTEhwbDVna2RN?=
 =?utf-8?B?OHE0aGhVSStUOUJkWEIwNWR6TVpOMHpMendGaDVrTzI1blliTE5VcGdYeTFR?=
 =?utf-8?B?TU05NjkyNEJqSWFnNDFTN0pTOTN2WTdwYzU1MGxZVkpRS3hiNWN3aGRPOHMz?=
 =?utf-8?B?THErWmdyY1ZHU2VHOHh6Zk4wbHppQVc4dTE4TUxQYU9jaEprcmRZNkZWbTA0?=
 =?utf-8?B?T2FId1RDWGs3aTd0Zk5pTWphQVAzS3VaR3V3OXQ5dFJreG14Y1p4ZlFRMktI?=
 =?utf-8?B?SGtTT1RGMi9ucVZuejhZeTJveWY4bmYyU0g1UUw5MkV1WTRxWFZyUXlUY01R?=
 =?utf-8?B?SU9HUVlSRUxnaGJlYXZCd3dkUzZlOTk0UHJUMk5OWnkzdk1Yb0ZtMXJZNTZR?=
 =?utf-8?B?ZkJOVmlEMjNldWxwbCtQT3VVN2xSZGZ6NmZzYk5YY2JyUzI0YU02K1JiQmly?=
 =?utf-8?B?aldmb2FFZ3hjUmlWRDdrZUNXZ3E5SmtUMzg2d3FwQm5HVU80WXVISVljTGM1?=
 =?utf-8?B?SzdWTkFvRzJMYnZOQ29EYWhWQUJleFZNOUh2bGhaZUcvdHh2UDFmUThhemJY?=
 =?utf-8?B?a3Z4b2NkUW83STYzZ3QwRmg1SUs5MzUzUEkvN2RsSkVZMzZmNHFoOUZjVEI4?=
 =?utf-8?Q?sQOeODnpe24M1Tt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d63327-9327-4409-e746-08db7c254213
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 00:26:06.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqaeEtnQNsY4OGV6rsCwJXAOkrDsC8zAZwR27rNHwc496D3hbOR1vXPFNzAgGQqzTjDnt7vsatvYq9f1VU6WAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_17,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040002
X-Proofpoint-ORIG-GUID: rqVd3TyNeSUbkVWEZXzeLD4UH6wzL8zQ
X-Proofpoint-GUID: rqVd3TyNeSUbkVWEZXzeLD4UH6wzL8zQ
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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

CgpPbiA3LzMvMjAyMyA4OjQ2IEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24gTW9u
LCBKdWwgMDMsIDIwMjMgYXQgMDQ6MjU6MTRQTSArMDIwMCwgRXVnZW5pbyBQw6lyZXogd3JvdGU6
Cj4+IE9mZmVyIHRoaXMgYmFja2VuZCBmZWF0dXJlIGFzIG1seDUgaXMgY29tcGF0aWJsZSB3aXRo
IGl0LiBJdCBhbGxvd3MgaXQKPj4gdG8gZG8gbGl2ZSBtaWdyYXRpb24gd2l0aCBDVlEsIGR5bmFt
aWNhbGx5IHN3aXRjaGluZyBiZXR3ZWVuIHBhc3N0aHJvdWdoCj4+IGFuZCBzaGFkb3cgdmlydHF1
ZXVlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0
LmNvbT4KPiBTYW1lIGNvbW1lbnQuCnRvIHdoaWNoPwoKLVNpd2VpCgo+Cj4+IC0tLQo+PiAgIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDcgKysrKysrKwo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
PiBpbmRleCA5MTM4ZWYyZmIyYzguLjVmMzA5YTE2YjlkYyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYwo+PiBAQCAtNyw2ICs3LDcgQEAKPj4gICAjaW5jbHVkZSA8dWFwaS9saW51
eC92aXJ0aW9fbmV0Lmg+Cj4+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2lkcy5oPgo+
PiAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZkcGEuaD4KPj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4
L3Zob3N0X3R5cGVzLmg+Cj4+ICAgI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19jb25maWcuaD4KPj4g
ICAjaW5jbHVkZSA8bGludXgvYXV4aWxpYXJ5X2J1cy5oPgo+PiAgICNpbmNsdWRlIDxsaW51eC9t
bHg1L2NxLmg+Cj4+IEBAIC0yNDk5LDYgKzI1MDAsMTEgQEAgc3RhdGljIHZvaWQgdW5yZWdpc3Rl
cl9saW5rX25vdGlmaWVyKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+PiAgIAkJZmx1c2hf
d29ya3F1ZXVlKG5kZXYtPm12ZGV2LndxKTsKPj4gICB9Cj4+ICAgCj4+ICtzdGF0aWMgdTY0IG1s
eDVfdmRwYV9nZXRfYmFja2VuZF9mZWF0dXJlcyhjb25zdCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGEpCj4+ICt7Cj4+ICsJcmV0dXJuIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRF
Ul9EUklWRVJfT0spOwo+PiArfQo+PiArCj4+ICAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2Ry
aXZlcl9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPj4g
ICB7Cj4+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+
PiBAQCAtMzE0MCw2ICszMTQ2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19v
cHMgbWx4NV92ZHBhX29wcyA9IHsKPj4gICAJLmdldF92cV9hbGlnbiA9IG1seDVfdmRwYV9nZXRf
dnFfYWxpZ24sCj4+ICAgCS5nZXRfdnFfZ3JvdXAgPSBtbHg1X3ZkcGFfZ2V0X3ZxX2dyb3VwLAo+
PiAgIAkuZ2V0X2RldmljZV9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1cmVz
LAo+PiArCS5nZXRfYmFja2VuZF9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfYmFja2VuZF9mZWF0
dXJlcywKPj4gICAJLnNldF9kcml2ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9m
ZWF0dXJlcywKPj4gICAJLmdldF9kcml2ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfZ2V0X2RyaXZl
cl9mZWF0dXJlcywKPj4gICAJLnNldF9jb25maWdfY2IgPSBtbHg1X3ZkcGFfc2V0X2NvbmZpZ19j
YiwKPj4gLS0gCj4+IDIuMzkuMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
