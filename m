Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD24C636D7
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 21:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C114812D3;
	Mon, 30 Jan 2023 21:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C114812D3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=C7anBkBj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=G67DL16m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YwTYh-cMpIVF; Mon, 30 Jan 2023 21:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 81985812DA;
	Mon, 30 Jan 2023 21:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81985812DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 511D0C0033;
	Mon, 30 Jan 2023 21:06:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 049A0C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAC604DC1A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAC604DC1A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=C7anBkBj; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=G67DL16m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QRZFV7Cj5kjw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E62734ED2B
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E62734ED2B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:05:44 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30UL3uOr004241; Mon, 30 Jan 2023 21:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DjZRMKmqfkyDQ+1z7iOGVJrlQzcxrlQt1ZmMkvvoUlo=;
 b=C7anBkBjhatYUnH87t4ZAZTgKDzI/mHy0u2fl+Cy9tiCS+u2Pep+gw0RKHBH88KLMUOR
 VeljzmdEk9UwBRozHwBRtjZPe2q5i9Uh4cT0PIMeq+X7kNXbyvJZsL/ZPGcfD6X50VBx
 P6ahoaRj2sL094x7Er6BhkzjiR2/BlxegiPX38FEpSXVoj9J33daiBcaCTKRkYBk0cyw
 l3eJz2NfT0qCFCBlxbc9+iMdMWOUtIgTHZdjWqhXWC9oEFzWfKIzih/vRPOZiphsFaGA
 tGyxXNpKLCIrmlbm7GpJ61TIU0BSJicBtF4tBic+g2woXtdHAtbUbk8h2PeSRL89UeGs gQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwv1f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jan 2023 21:05:43 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30UK1d1J031739; Mon, 30 Jan 2023 21:05:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3nct54p7q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jan 2023 21:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA6iVksDdivsd4s3sohVhbNW01DH0QQR0B26ZQ2IxcD4UA9sFDpaRi7WdrjdA8Lv69wDknYfRTp2rDwVZ9YmKsfEo5oxCFf6Fv1Ba7UbQuKgJUEVNJRUbnikq7bobbqx567+Zxa5uGvogFpjg1kJs731PG3h0ue4LK0emfLWGVROT47Ia38txTj2pVnSjvtuICGGRdGqLpPreJ4XB0588LfUNwsIDiUBsHzD5eDBq+4mOn6MhyRxu+qGDu8BQWT0fWtciBFefA4zTCgMx4NsPP2xCHEwsnRZhALLZG5Ebiq/OoMCO3kQjYurCHM5JWwsxeHcmakf/iTf568mfJdszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjZRMKmqfkyDQ+1z7iOGVJrlQzcxrlQt1ZmMkvvoUlo=;
 b=QHLgSzzKUcYtUb7fKY/oO740SJTOQc3acx4eIn4gksdNOqNKbikGD+I5+mPL0Mx3nQVSeKTHQQyGYFg4Rgg28WcdpqzUeojPddtmwezOS9qjBqV90rA4w/4BUNPMYZhztNDU0ghCOrYjUJN9+WcOTnxiYTXcRuNun/0UwniGEN5uYxx7WEz5UBWW3o9nO/SQ6LuiH10utBloMT3Ytz46jOA8HqpqwnIvyWQ/V7/A71OBe3Ib9HV5jkSCCbWFOagyGwXpxkkqaI4WVEzhc/toSw5Ur2IbHsLN4EjdKRY5DF7DtiMZBHfPIzQR2a8KvadxAIf/HzgXdIuitenAkz0cwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjZRMKmqfkyDQ+1z7iOGVJrlQzcxrlQt1ZmMkvvoUlo=;
 b=G67DL16mxmq9itmwOY7AetH6JwZsrlokseepet0b9rvOLu8m4H7EafGP6LIADqJDW1zqNfgRfwPeLxvWyMrSBzmZmrV0EWovY4pcT1k+G/Hc187cuk/Y2sKr9DmVGdeEpQVCPYIgCUkaKyB/fSmm5ETbIQd8//2ia/Gj2JgpZN4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB5257.namprd10.prod.outlook.com (2603:10b6:610:df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Mon, 30 Jan
 2023 21:05:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6064.017; Mon, 30 Jan 2023
 21:05:40 +0000
Message-ID: <bbaedcb9-2290-d559-31db-def09363fd0d@oracle.com>
Date: Mon, 30 Jan 2023 13:05:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <20230127031524-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230127031524-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: b58d9087-ba7b-4372-ac03-08db0305be06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59+CreOXP0zOlsO29LSsOFPKsingvMgwNIYqMhUdVjyP7MD/aVSPzETUQRvQkQBZX7nmVgg5kDCn3B2IYP3OQUr4IGOG2Xxb1kg2ftgVcwlfujiJ6n/ioJlAabkJIU49g8wPQCu6lsHtyU5rfx7ArZMKGBCPoNEJuOw5wU9sILvtwJL3kJIS+Jko/2TMX6fm+MrIC7A0mFeodyU49fFbf9RoKQie5eFCnlmSFkEva1Q5+2H/g3B+3C+8Iey0QwMW1L07YIhLTAH/2UNjB/6FcX/qRmS0tMMsYB//XBfDvLodd/Xs2FjnzTxyZJSUghb2qW5zkaT5qua6Ursr1AiqyURm9QP5yZIkOkUqqeVegtLkBlKQbghS3c0bIqe/Uzfl9CyYuDfxB6Psze6nlsNBrUjDq6jGsaz2nG4E/+m6KfyNuBh5nsoWzn+C9LO1PRn6rfE4hJufiWna2uKWVv6wn1ongXAzCj/Mk5L+u/KowqEKtNKkxUTCdCoFVhaK/MoPBedHS9HhsbOeKzwsWeMFjGprVFpASWR+P4F4VJ4eeATPkY1xQfkCYW8aSp5Z56q3GwUXknd17aXausfTTj4BpihPSi0Ht1WrIG4j/qsh0a5Hb9J86WUfG4cgs/9pRctdXUPNzq4kSzZaoYKS44VLUsIiH2OusG3/7sqDlgQkVrv7435+FF6HucfS55p6xZnKKtdinZkSAZmhuXa8SJs2LmS+3ohA4A9Y0uWaxw1SB8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(31686004)(36756003)(478600001)(36916002)(41300700001)(6486002)(2906002)(38100700002)(86362001)(31696002)(2616005)(6506007)(53546011)(4744005)(316002)(8676002)(4326008)(6916009)(66946007)(8936002)(26005)(5660300002)(66476007)(6512007)(66556008)(186003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFRPczdna0kwdE13ODNwbTNFVFNOYit0dHkyS0VhTXhRSUtic01oM3k1YjJC?=
 =?utf-8?B?TXpiL2hPamVHOUZWWVdWZjRFRnpQK3dJdkJBTFI3ZFVlWjkxZVNkV296bnFU?=
 =?utf-8?B?a052bFJFUjdFN3lTTjdrR04xZjMrUGZhZ2tQNllNWERpdXc0cEhKVWRLRXh5?=
 =?utf-8?B?VEpvZUs3dHJTeFdSZy8xSks0TmZqK3lZdW1teEkxOFI4ZEJBQWVxc2dYbTNi?=
 =?utf-8?B?cnFxY1Q4cW43T1hCZjJKMzZ0emwrRUFUMTN3RlViQ3BIeHNYMGlBWGFCVWxI?=
 =?utf-8?B?cmo4ZXRWZkRXeGdacldFNytYWi9qUjdhZ0ZuU2Y0eW1qYjFJVzkvWU01TXFo?=
 =?utf-8?B?QUg1dEMybGgzTmNlWTAyQVk4VVhKWkpMaU1Mb0hUZFdGWlphd3ovZFRBdTlt?=
 =?utf-8?B?ampxMWVtWHIwaGU1ZDZ5UVZjRkIvbjlQZHFzNDcvZXJkSjNXNjc0WHdHdlhp?=
 =?utf-8?B?Z1NOL2pJK2ZjN2RKUXk1UExHNGNoank1R1pVN3owdWdSb2JjRXQ1Q1hvV0pz?=
 =?utf-8?B?Um1wemlNZm1RMzBWcXpYVFRQWHplaDZpVnROaTUyNGJxRktKeHp4QnE5WTdl?=
 =?utf-8?B?ZU9FYTExcW5WeXFiRjRxMk9zVW9QdkpTM1pRV1dtSWpEempHZ0tWTjJGUXdP?=
 =?utf-8?B?aS9VL29qbXNiS2xKb0cyY2xsZTByZmN3MkJiSXZoWkpoMzROdTRRRmI2N0VC?=
 =?utf-8?B?NjVXeHd3c1lKWXFPRi9VdFoxY2FCY0hFeTV0T0c4MC8zZDI4S0cwMXFQM2NS?=
 =?utf-8?B?K2R4S1V0SDNROXBrQ3p4Qkk3d1o1SCs0VW5CcE5VdWVOSU1JRFBmdGJPdHFU?=
 =?utf-8?B?dkwvejZQWm1NemV6MGpXY3g4K0NmWWdsMHJqSW00RFppbjdjVDIrZE4vOW5Y?=
 =?utf-8?B?UFB4eEl2R29YRFpFZGtjbHFraFgrSDRuMGYyZEpEUFltbUo0UFc2UU50UlA2?=
 =?utf-8?B?L2p5by9MTUFyZ0tRa3hHWFViMm1lTW1qcmxjcGg2UExSNHhUOEdPbzVmTEs5?=
 =?utf-8?B?Vno0Skh3L2hrby83aFJSN2lpdXcvV1VKMEpDOG1mbS96b0hRbnhnNTNDamUy?=
 =?utf-8?B?UWNkTE00c3FJRHU1NUlYeE1NS1dLRGNZMWI2bU5hbmNwNlRkdkJsZmJ3a3Np?=
 =?utf-8?B?WWdkeStacGtVdk80RCtuUEpiZWVzVGxlR2tXRUJSbmwzblg1aEdEY2xYTWZJ?=
 =?utf-8?B?a01STVJ3QndXZVJadlhnWm1ZRVFNNXhQaEowVjVvVjRWN0tsMmlQOTljTkFn?=
 =?utf-8?B?UkpLMDBCWHlDNWl5eE1nWHNzbTcvT0tJemwvSGZQcE00TWdyQUNWY0ExVytT?=
 =?utf-8?B?WnJvVWxkcy9ZenMrT1ZLTmZvRTk0YXh2dGtrTzdOekh3NDhlSlZsL0piUFVK?=
 =?utf-8?B?ZitPVzJzSWFWeXNVV3ZRd1l5UHZXVlJMTUNJUWQvOVl1K2V3bC9tRzJqTlZY?=
 =?utf-8?B?eDYrOFNpNDFxaVlHWklrZjZwL3A1UVR3QVRPRXdIMDVNai9QZDRXK2tCaFFE?=
 =?utf-8?B?c2JoQ1hiTkppR3FiTVVVR3NnNHJDM25HRGNHVStLcmxnQVdXRENydnd2MHQz?=
 =?utf-8?B?UmlkQndVeUg2SDE3SkZWelNjbHM0ZWJlTmhySmpVMW1Sdm1vV2lGR21PSmRr?=
 =?utf-8?B?V3ppbEMrazRHWDdnTGJKRGJicWNaNlh0L0RlSCtDd0dYVTkySlBEVkhSc0RC?=
 =?utf-8?B?WVlDVlcrQi9tK1NSMmFkMmdZY1F1OXNzc1Fic1BaTnhTeVFCazVJdHNmZjBX?=
 =?utf-8?B?Sy9JUUE2UWdZRmE5TjJHczZFaE1XK2RUelVmalF5bmFZYm01d0xEcjBiU2dB?=
 =?utf-8?B?UDk3NkhzSDluNXdpK0p3TTBLWWpRcnFjZEtOZmhKZVAzUDNYdzV4c0VzaG53?=
 =?utf-8?B?R0ZlVHVCbWVtUWEwS21tdk9ndGcxSDA1NERRN3M1V1dVbWptdFRvdWFRQ0xH?=
 =?utf-8?B?dmRiQmY1SWpSRzVrbFRtSFAya0xacWZFT1FpbFR0eE5IWnlyTDlsWjhTbFVY?=
 =?utf-8?B?K1IzWjZxY1RxTHRGemhGUTlFdFl6YWZLOWdjSG5RQzErYURFaGVkYnV5R3B5?=
 =?utf-8?B?Nk83b08venZTcWFvdmlsWTlabTVQUXJvenJrcWdSSjlIMytxTnlFVTIzdDYv?=
 =?utf-8?Q?b94YTFl8HDDyWLAeFV2BgbqAU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lKA05uksdveVtnT100cx1Dv8ydiXwNqIe2r/EqXsu12TkBt5ZpiSvmeFQ/8xWhgwkKTwFCL5mkDSRD+RTVP5cnxosBez5HoQqisTwRXmx6HIU+I3dTDq/8ZTv+7UQhT+HQh8O59Wx3ktZioSR6zS5NkRzJLRjdPGSa3hsbiEr/aJzuMhoqtLyNjpRNYFmfG/xiwEqWDIzhWV1Gv85LUR1xGxRgbHMQrRtavnt4CrgWcl5IQt3ceAw1JpY+4U0mETXu3BKdMPYR+ypN3UqisVFH+tOIsacdFcMiMfkam5Iuf1UmIDIzeCKlOQuPtIegC7eKiXSVARyY5PT7QvMItm6kCl8SxV3NsWINW7+oLvE3lmpIZGI21W7MaanHL9Kb9PNIw787SDLhGRZjvg61wFxKPEXAbYR5UE6m9PAyCM3qJeE0eUzVNikVo1P1Q9zVLJWn1ej7nUnYDK1XQjhXScHwVPAqFARu12CxzXeovhVl0jnuEPizBQ4aSms31ajHH7/mEi6lfsobJPV16xj0xThga5CgQkErHaijKkCv5yU3nq2ccrXBxutfd4E+eY9tAWFqByKzIQItBNW5Hxr8mxplLLixTVzlUOuouw2eCuZDExdyU6hT72+G0XgkzZqORza34Rz3QRUNGdAy/kADZFvHlFthD3Srnp8FT0CY9teJUHQjV9DhrMf5JmC9Bues5V0MwZ3D85Xf+KlUFeN2usaPjcZD7GPfZaudxyMvJ0IDHRj413SlmogyKDdiKsjIlnqATzkhzvOMkG0rZOhlPEdH/v6lVFHV7SS5heAqwBZ786JvDe8ixmDAwVC4zvd4FTitwu+3uqQQNFTgDBkL5u0n4gxApE5QLn/iQ6SGMpml0Y3Wqi09/jR6V8ijQrtpoC2Hztx5CfbQxXZHr+dNGOXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58d9087-ba7b-4372-ac03-08db0305be06
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 21:05:40.2759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M85mejY3mL59pDUhlL/i9k8kaxDCw8iENHrZYKuOCqV0AjEOsdNNA2JkCUmnPtpU8L/ig4tPYFoyMxAYA0qVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300198
X-Proofpoint-ORIG-GUID: KLNuypVZhQbAwt6CkhWGxtZ7gtRSVxHH
X-Proofpoint-GUID: KLNuypVZhQbAwt6CkhWGxtZ7gtRSVxHH
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Apologies, I was over booked for multiple things in parallel, and there 
had been urgent internal priorities popped up at times for the past few 
weeks. On the other hand, there were brokenness or incompleteness 
identified around features provisioning while this series was being 
developed, which makes it grow a bit larger than v3. If you are eager to 
see patches posted I can split off the series. I will send out a 
prerequisite patchset for this series shortly.

Thanks for your patience,
-Siwei

On 1/27/2023 12:16 AM, Michael S. Tsirkin wrote:
> Did you say you are going to post v4 of this?
> I'm dropping this from review for now.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
