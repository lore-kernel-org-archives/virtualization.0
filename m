Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11246180A83
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852368; cv=fail; b=syW5qgeQvGinuzi47pLZdjRmSDFkQ8VBckQSdry50NzNPnEYW+1wiFHYexG90ZlQo9HwoaXDJ8JNt7MCyWKP61Dma4GFG6hVCQtQ9mgiw8RLnhEpyOrAHZFrB7JqVgsnqfWadX1hj/4jO0E8zPmbQxCFH7iFTUAQV69ZwU3SLIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852368; c=relaxed/simple;
	bh=WH1jUJS5yKk5TjXvdmahp7wrtI5YMmpzGjnlCeT5F6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luAAmbafUbE+DS2Xw3inA+04BvBELuI6r00eSSxGJ7wvIWIhmklRBaHEvenXh0E53Kjg+U/mOuFGLaLFBJvj7dsmbB1hkWaaKvUsWtHLd1B322MuBNVPghdTUEV6mktX1cHyYXKN2aJXnaDimKDVh7xvvqzooxoMMxTsHVmInqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGTDfbx2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jki7/Dsm; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGTDfbx2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jki7/Dsm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8707D612CF
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 16:19:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6SIejCDr_YAx for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Apr 2024 16:19:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 24646612A7
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24646612A7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=aGTDfbx2;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=jki7/Dsm
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24646612A7
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 16:19:22 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BEwrfZ013230;
	Thu, 11 Apr 2024 16:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=L1yq5H4KqPWBkR48rwAXs4ZlHodNaVdWIfNA1RPBBGo=;
 b=aGTDfbx2lvxFUQplfzfacD4Jw7y6YyCYj6jYJQG4m7onsy57WdJQE6AasQYIB2E/9XeR
 eoiLkUpwLFO9bGrdwy84TI/W6gt7V6YoJISdjf+RurhfWlgbWg8gZTocrAdrK0uqWcAC
 JvH4ExT1CC+wc9g25UHpL+IpluZ/1kvmMEM6tobxFjYzhlyYtUQ7+3yYKlRgQHvKC62k
 IIReswolW+2Iva/G7k71QVbuTzUprOn3tn1gnKF9oJm2bGr6Ai0LyTVt8Z6/DRsN8ejj
 vD6SjHKLneXKXqsVkEucVe5hKc5149tKlKGKwhaIr43vk16W8G70q3+rLrDKJ5RuH9mc ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedt474-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 16:19:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BFW6qK026353;
	Thu, 11 Apr 2024 16:19:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrssug0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 16:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+3dekD+leDi6ySjJ4BrIO09YMmtiZIEpGK3eOfE5fvvhsGBVuGfVjTMJVvJoEDikwJB1f+8z67HlDJmgbsFHjfMW3dYKceHyDYmIkpWCliyX/iE1BhP7VaPA8pqLWjXhIMBQsOHlAXX3h+4iJVIhy8qxioilC/CSMxOzJBmKFbLSaO4kM/Ws+cM0vn0uLm4YV8oulNJvemtsOLOLhVsOKzDdqnDvo0bIzxrWCc3aVLrM+4TtDpxm+11l1vJ7oFbiOG4UNKh+k+kJ9ptxxFbETgJVD+FvtJUp4SgS5k9j8l3zUeImScRRzcwO60KsxsZdL8t4eMfN7k4fiGfdxYN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1yq5H4KqPWBkR48rwAXs4ZlHodNaVdWIfNA1RPBBGo=;
 b=Z4khYSnEcf40T/0Zyi+8ydDNe2mDsQYhe4b35G10cSP7tM8Z2yMciqcbX+sZa5oPvMC0vwbvXs1lgdBUuJCTGAeLfSNMQxhuAn0VP/JwWi3As3YwNM+Q9RUplqNOTqezUWIqRJg5qU5BAlzNXb836SXGeJDS0JbGuXhUFW5WsRq38AzRX/ENchY6kZwNieVPzvVS0nnp0B6tapL3f3oB6on0f1DNxBpptdyaWZSZpdLMA04cAeN9Frl+mEIws2RMibgcZtsbZDNzEf58n8j1wkZbnDYiSnxzxq5joZQROT9xSlpszoqIp6zPpaDTil/u+JXx/C6Iu+haLWZH+xmLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1yq5H4KqPWBkR48rwAXs4ZlHodNaVdWIfNA1RPBBGo=;
 b=jki7/Dsmy/csAxKpBXYxoQWoQP/88AudHXYldIORuGukRL95+6Iu+tEyJTJAPWb4xauHqjJ1ExckoXQqR+GjeQN4OCcqJiKgPIGYRw0qCI5Wuc4w4WVLW+Fy3O2mmIzqopOwT/ewhY8uOMLPoApnUohNkFKwnnIxCPEUcClopGU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS7PR10MB7373.namprd10.prod.outlook.com (2603:10b6:8:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 11 Apr 2024 16:19:14 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2%5]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 16:19:14 +0000
Message-ID: <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
Date: Thu, 11 Apr 2024 11:19:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Jason Wang <jasowang@redhat.com>
Cc: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:610:54::36) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS7PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5581d926-679a-4c13-4617-08dc5a4320e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eQIhFSfNaWTClsRyqyfwZjuwUqbuxs3cCrmA+seGBqT01MwSSsP8cjyuugkulHexL2PsuIwQhm1Ds9vIB9ONVxdG6qX9o7ayiXbIptC5qqEav1lc7sQsZ23u5HpN9Hvz/lgimp1JI0N/PRpl/L/89QzUGpnuAAn5l1AqUczZ9hQ3/A3fsJ1AHAZNIv0rJfWU6sCe1I6U3Z9jldOo/K5Kuo6EHlzrf8S/lwSjUp2oNdvHbDMNRKFXQ3y6CNwbggBNUk3yCHy0hA/5vEBhYhJpvHKYq0eGBwIDhSlgO9DdkcNrgo8cforAcxqoZulSM5KGtnRZQBGeVrw5U1gA41sERPcw5kp9BnPIq7gIhRYk6K0uPENAFekmGbeIXBNVjspqrCzNz45be2iOwkYmSMXkOu5gv720EK7S08viqDOudnpDptl3tMx+9FXp0mQerfj9w6DLSLHMsfeXtwoHGJFQzR89uBlkgvd7JKCNwn6q3/tuhm/dfJ7wFhcfhqJKiCdwXeWIpbbumK56gKLoVsxSukxX0INcH58X2S7uQuKXjCeb/93o183mCQneAfF5jrT/R1HMftt0WrfBopMXKMWLIR1CE0i/n4GYEsTLTWBeMZv+YHv09n7ETbcL1heE/6iqk+Ut+dPpyepB9xOewkT2784r/J++o7nCDWntoLjqydg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUZWOVZLekdveG4vN2dBeTYwQmVVREI4SXowcFBzejhDQVJoWHBBSjNHc3k1?=
 =?utf-8?B?UHBHR2pVeG5rWWtWeUdDNWh1SzdVVmc4aXlITHovNlIrMGZHY3U3UWtwdXlt?=
 =?utf-8?B?djdCVzU1cUxUZTQ0anRNMjNOQ2QrN2t0RWpScFNCS0VBUVd4QlZlWW0zdG5M?=
 =?utf-8?B?c1NpeG4yK3h6NUdKNmw5eEhZRnI0dEhqcFg0SlBVdnh0SjdFNE9JRk93ZEdw?=
 =?utf-8?B?bzRodlRITjBudmV0RThKblVtL3dSL1l6VmI4aWIyV2JXYTlrQWR5TXMwZ3FY?=
 =?utf-8?B?ejViM2pSZXJTUmF6TXQ5andNclBMYTlkamZaR1RZaC85Z1RwaThXejRHUG9K?=
 =?utf-8?B?VXZlWmJQdE1pMm9rVmRFZXlpSzVuWkdCMExRK3prQzU1TEExQWhYUDdHQ3p0?=
 =?utf-8?B?bTA5OUJFcngva213elkvWDRFSUc0TUZhNDZ4ZncrWXNmTnNrM2JLcTdIZ3RQ?=
 =?utf-8?B?cFF6alByQzgzRXYrREloRlFsUUlLSndVb21IczlCQmdJWFJIczBOem1taTkx?=
 =?utf-8?B?OHlBWHloUlBlL0VveXhuOW1GUnY0dk5NUysyU1B2SXJTdTRQUzhNVzE2d1gw?=
 =?utf-8?B?b0I1Z1VtMHNPSXAvaWJRcHRGREpzQ0ZFSWhLTFFSTEh5T3ZtMDloYm5NY01X?=
 =?utf-8?B?SGhPRjV0VkVlaS9pSlhyaCtWc3J6d1pSeFI5eDZaNXg0T2RLZ0YzU0ZRRWoy?=
 =?utf-8?B?cDBwSjlaRUhkc1Q0TU4vOWNrZHR6ZWdqb2xFVkRVOHV2Z00raEdQZmQ5Vy9O?=
 =?utf-8?B?UlNKVmZpdlZTMEdrTmxwSkZBQmpxYXZ0dzZPMmRYRndOOVVNelp4NXlUTWFL?=
 =?utf-8?B?QWtGazg0WlVRSzBmemVsSFpGVkZrdUdjUi8wVFBLeXpuc1dibWo5cmhaUmMr?=
 =?utf-8?B?Zjk4TjErQUdRZmxNcWlkelZLVXNKejhjK21VTVpDTXVjZ24rZE5lL3FjZDBB?=
 =?utf-8?B?U0FFZlJUeitGeDF5MytiNXpyUTZkZkZ6L2tYQ0tLVjdDM2U0TTNtekY1OWdE?=
 =?utf-8?B?SEMzTVVJVUxWeG1YOHRQc1c0M0prU0NaOTZpeGRuS3EzYVZVeUk5dUF6UnpG?=
 =?utf-8?B?bkxLTVo1cVo3ay82MzhOMTFIZml6OVNsZk1GZDRkanZ1bXI0Z2FZZmtBN0ZZ?=
 =?utf-8?B?dDZBbXgyUGlwSmpUNjhuemhmM2VXcmUycDF5NXBpanZ5U0oxTnRoMlU0aG5Y?=
 =?utf-8?B?Wk1CclVWSm5CRmU1Qis0elJTNkVobFdzeWVsSUQ2TnI0UEI3T0ZNcm85YS9t?=
 =?utf-8?B?aTJFdDZJOEI2bUgzU1kwRy9FemNzdUNyM0VJeWlMN1k0bldJellJWDY1MDlZ?=
 =?utf-8?B?MXFoZi9JeFNZN3BpNFo5RlJ5L3VwTHNOL2lvMlhJZjdMYk9paUFnRHJkU3FU?=
 =?utf-8?B?aGZaSjRsZGlqNmJtbTRscGJZS3lsOVh5OGIxd1dqbWFKakIrOEZUbjVoZHA1?=
 =?utf-8?B?RjhFN09qMGdyUFQwbWtETzc1RllYMDErZG0xSmRYaC9aQU5nWkMwOVFXa0tZ?=
 =?utf-8?B?OGVCTmw3V2NXaW9WVW1RTGpwRVVtWmtTY2Z0eG5ybGpicUhTVmhBdnJvRWtV?=
 =?utf-8?B?ajZlY3dvQmJCSW5FaUFmUDJGWmJXOVlsTzFjSE5Eb3puYXNsc2tiR3ZFY05v?=
 =?utf-8?B?Z25YSm5taThSTXRsSXdvQVdQSzAwNURyRWE4TERoNEN6QmpnTWdvTGRHR3JU?=
 =?utf-8?B?Q0VWNVVxZXgvLzZDeVdTeUQ3SEtOSUY2blJXRWM5TCtEcFA5T1FhK0ljOTAr?=
 =?utf-8?B?WWZMZTNURlN1U0VxZFo1TStaR1p0ZURMY3BYK2ZiZWtOMjZxZldMdVB5L1d4?=
 =?utf-8?B?dTByN3JKZWJVMGUraTBJeHlIa0FvYTdVdzNDR0hyY1d6VHZwUFY1K1JSM0RU?=
 =?utf-8?B?dm5QcFVFTGlQbHpIZE1hdTI0L0Y0aElWMUd3OFRCT0ZTbk5oZnZSNUxiOWJu?=
 =?utf-8?B?eVU1SlZmblhBditnT285YWVReVNCcllSNVFVam5VbEJRWkVPdzNaQ0FaZGY0?=
 =?utf-8?B?cXA5QkdJNW53VGtqeVcwZUszRUpZVGhTRHJBaEc1OERXSEpxb21vWkhxRUdL?=
 =?utf-8?B?TVYweHhMdVB5TEtwcFRLbVRsdjdNeVE4Z0d6eUNBQURTNGQ3Wm1XVzVhMVk0?=
 =?utf-8?B?Q3dYaXlwOGdJaDlFVG1lWnh4TVkvaUxYeVB3TEc4Wnp1WisraVRiWU42R3hl?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H7FS4VX028LXIzLlldhqRbORrYKwxgKcE8RoWr24IBjoanqvlwJmLAhV3XKrBff0C3zl6iDuFjF+ZoM4/bKDuEspApsarVF638fBfzijuqo8J7fRuL+jjS9AkKpM8Qhi0KNXc1qSVB0o7TejQS010hxKjstTxMX2ZxyiulMIM7CkYPByJ2RTH/0RDyV8SXaT6yLSA/unsYw+UWu8bWiJYU5EnLPo6rm7gkPAY7h5S+7UVxl5ZGKqgPQROyCLaps341qB7H1apwXIk0241ekmmdX6FerS+4Nf9fDCTjxuoGkBgDqKCQJO1HeRhAJTUFI4DCJfongTbAFm72H3T3us3G7af+qbtwsfa+I0UQxjc1LdsfvgNszJTXdFWmNjk7RE6l5349asuLZMJKKfRpPcP+U6UKGUKj8RwYXT78NyMdshW/YtY7EnEwlWF18flIgyrdMJ+U0V2CSLN2qeD9YMN8S9Ho/Lx9v5DAu9SUBb4w7AEQlFMginf36ODxsf+B1ymI9GLpsyhLtbrNDn2ZcAC7Cz4I5TZ6HbGji5/GdQexN4TlRfS39/Af3U3jJKCZCuovfOwrX74kpTHNO99S9i05qMc+6NCs6Z7qprBLYjYIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5581d926-679a-4c13-4617-08dc5a4320e1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:19:14.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3g1IC57otsVeVC/2OrZGnXQQWSmoM5Zfdxz0S2j0J6aE9NqcYCGnNrLzdTK3pkggmq40ICiNY+SxLS6Cs2EIlvkrK3455aR4xh2GeGwXag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110119
X-Proofpoint-GUID: MTJBCLeMZQgPElaO6ZDM5CXux1Ec1AYA
X-Proofpoint-ORIG-GUID: MTJBCLeMZQgPElaO6ZDM5CXux1Ec1AYA

On 4/11/24 3:39 AM, Jason Wang wrote:
> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> The following patches were made over Linus's tree and also apply over
>> mst's vhost branch. The patches add the ability for vhost_tasks to
>> handle SIGKILL by flushing queued works, stop new works from being
>> queued, and prepare the task for an early exit.
>>
>> This removes the need for the signal/coredump hacks added in:
>>
>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
>>
>> when the vhost_task patches were initially merged and fix the issue
>> in this thread:
>>
>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
>>
>> Long Background:
>>
>> The original vhost worker code didn't support any signals. If the
>> userspace application that owned the worker got a SIGKILL, the app/
>> process would exit dropping all references to the device and then the
>> file operation's release function would be called. From there we would
>> wait on running IO then cleanup the device's memory.
> 
> A dumb question.
> 
> Is this a user space noticeable change? For example, with this series
> a SIGKILL may shutdown the datapath ...

It already changed in 6.4. We basically added a new interface to shutdown
everything (userspace and vhost kernel parts). So we won't just shutdown
the data path while userspace is still running. We will shutdown everything
now if you send a SIGKILL to a vhost worker's thread.

Here are a lots of details:

- Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signal
to a vhost worker, we ignore it. Nothing happens. kthreads are special and
can ignore all signals.

You could think of it as the worker is a completely different process than
qemu/userspace so they have completely different signal handlers. The
vhost worker signal handler ignores all signals even SIGKILL.

If you send a SIGKILL to a qemu thread, then it just exits right away. We
don't get to do an explicit close() on the vhost device and we don't get
to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exit
code runs and releases refcounts on the device/file, then the vhost device's
file_operations->release function is called. vhost_dev_cleanup then stops
the vhost worker.

- In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
can be thought of as a thread within the userspace process. With that
change we have the same signal handler as the userspace process.

If you send a SIGKILL to a qemu thread then it works like above.

If you send a SIGKILL to a vhost worker, the vhost worker still sort of
ignores it (that is the hack that I mentioned at the beginning of this
thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
then just continue to process works until file_operations->release
calls 

However, the change in behavior is that because the worker is just a
thread within qemu, qemu is going to exit since they share a signal
handler and userspace can't ignore SIGKILL. We then run perform the
steps above like in the pre-6.4 kernel description as if you sent a
SIGKILL directly to a userspace thread.

- With the patches in this thread there is no major difference in behavior
with 6.4 and newer kernels. We might exit a little faster. Instead of the
vhost thread trying to do it's hacked up version of ignoring the signal
and waiting for userspace to exit and call file_operations->release, the
vhost worker thread will exit after it flushes works and stops new ones.
So now, you can have the vhost thread exiting in parallel with the
userspace thread.
