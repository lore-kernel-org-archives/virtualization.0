Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794164730;
	b=t0XwLqH/yOcqr9Mv7ru/0ubXBnhb4R+sDVCOwEd8DNogvgHOoK5o6E02QjqID86at5LP
	 wSFSIn+Bzts+PSD2ATF2NDOTLrQ6PXK4mANcfjHt1Uu4rXj+x8kXdLSm7vplh4WcZCSLG
	 /D7H4J4QeqQAHBYnTrKpgqZ9CTuEwLQVxOMmn8B7uyHALeP7u1G7Td90QidXGc4CqejIw
	 SV85qSTQvzJkB/8BIDVPdYx2jMLyYrU2NqHEQ3/zS998mSEQatTWGjFleeJpszoTKKE/7
	 +3BuQFMqbGMRMN/AIu7Rp53TsqnuHGuvRNwH0bq2cHpDMJoXW3czCvigZZnT97LB1OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info;
	bh=sg7+yW5RzLutB8Jcy/tffHJsYSKVVxCGAqKkP1vp/YU=;
	b=YjoEB/y9Tcf9nXGQxmqcTJn8UHynL11CGTOABJ/+2MNh+UhItr2rDSymqgU0t70rlXdR
	 cX6bfm31jHqZyJGeH+avUczxTdBfEbc7882h1LynGDA+57kOp5qeFg1DulZRxU2LI23H/
	 JVktIDiVnjI9keKyzGj3a3HK6HPYNEkFThbGBwvryD8CEIQU7x4qatIzyT/6XunHWMB60
	 BOItzccYXg6rC+oOiIJTQv7vhisSygq1VX+4Ao9INfOYctbrIpqt517gy0MPG+lk3kQrA
	 i2xpFrP2rDmhQ3HNZeVTKs3v68djtGdAhW6kPFa47UuZ9zafMYcacn87+ApuMUJZ1QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GmEqNRew;
	dkim=fail reason="signature verification failed" header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=BlWHDWqE;
	arc=fail smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC0606A31C
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 19:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32AC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GmEqNRew;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=BlWHDWqE
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8J1a7R3494087;
	Sun, 8 Nov 2026 19:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sg7+yW5RzLutB8Jcy/tffHJsYSKVVxCGAqKkP1vp/YU=; b=
	GmEqNRewI9fpRV9v+hH6s+tvpw9jrd32lV7WfSjzV7BqL9bO3gBRVv/HwPmf9oAA
	gJph9KR/kdkgkgr43ZF8CE2QT6aO8LKDz0TwlxmtpsPtySLLm0QNzlyrMWkdra+w
	2f13PO1MXEtcQHyxE8+i3OwQVLpb0THAA5OoUdrYzjXtObOB+FpExhpQsS2Kp6Eo
	Mp08AQlyJKSRag8eMlep5W3EUgY9dyu1Mh6cweaKPaDmtqRSnRUJbSt3qwcnVt5A
	DrFjRIG3XHldR5CLQODUP/4Bofo5D5SoVH4wJxRzAZDIwgTxNqyMr8vHSocqUPvC
	+++U91MahRQvb3jytEkYnQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsv1b9hpq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 08 Nov 2026 19:05:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A8Ho1ia1886316;
	Sun, 8 Nov 2026 19:05:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4htu4nbctr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Sun, 08 Nov 2026 19:05:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYQdLNGxOUvkh4v+ce2O6wzffbNVIPxx56i/Fqvt8XOqjGf8wDwP2rDhwneQQj0au8S/aVFvmz0DypuzaJSS2xIHkeaV3AlSym98j2aAfOrbzYyZhTdsDfKB+OWB7kiN1lWrm9VRapn2bR8Eauimy7T89rwPn7qj8klXwBl6K66++D/gvE1X+aqEV7nNLa4ivLckeiYn+h/iRGKPlYvI2C3qjjnLiAYiM5i5/Z+ezpQcLyoXFIdHwLHTihN4r4+o1dk0d9YMrRULLnm/TstwUOB8TjR5A2uksNlNDuYjCuW8j6pa3ctB1qqawvKRvE0yhdGg+gCn7/PJWlDIkKk8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiR9V2hBzGGM/AIGLuY3JcZr8j8FLmzlaHpkffd3YeU=;
 b=zRA89xA+I6tFWwOdtzE2S4D5I5SBrACpAKX3XHeYH+pbWKnuriFfYz6YHBje73JgB0Mbu+bQjoSSVhTgUK1Zajmtwmlv7SqPBKlqkgowSS12yXWorHue4Gr19+CxeistFX0jhL8wxB0prPNweVHvbkRbpO8JQn6RQJay/DLJ+11md6JhpSs82ggOqNWiThw4uNGKmgYjHtuNmQyoun2IJ86Kd1bEfdsHotjQlAe5E5nPHeHl6iiDU5Z2wr+VTEOgvlvvUxoka24ixgOuYGbppd+RW1LKIJ8vgjx4jHj6JMUj7gbyMyFk5PsUiwRjFlp0/lHrO8kU1FMk/1l/37F/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiR9V2hBzGGM/AIGLuY3JcZr8j8FLmzlaHpkffd3YeU=;
 b=BlWHDWqEfzyhLjSLP5gIBhoM9rOz1vwXI6tCficWF0Wm0APMZwReR01j8Z80kRt9V4aJlPmjdvdjc3ND1Lhue9Ztis/KVI6F9QxgRZf+gqoVlDDS7YCVRpQyls7hMeqsYeiCb7Jt6VEULiHN+oUhpBFdtsh5EntwZronNb3PG1w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by DS7PR10MB5168.namprd10.prod.outlook.com
 (2603:10b6:5:3a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 19:05:24 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::903b:7d56:3ec6:a45f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::903b:7d56:3ec6:a45f%5]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 19:05:24 +0000
Message-ID: <add2bfe5-0d8a-4b64-a8dd-5e02be00e425@oracle.com>
Date: Sun, 8 Nov 2026 13:05:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vhost-scsi: do not validate vrings during endpoint
 teardown
To: Yuho Choi <oss.patchbox@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi
 <stefanha@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261106054811.281798-2-oss.patchbox@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20261106054811.281798-2-oss.patchbox@gmail.com>
X-ClientProxiedBy: DS1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:455::11) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|DS7PR10MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 3116f842-a6c4-47d1-d95a-08df3dcb3e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|10067099003|4133799003|3023799007|56012099006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	CmxxplS/VmFMQ9s2n+t2GmirYSWpPrE+/ROn+6rnbKvyDpCTbGjtSLTLJ5plgtxPrq3C4zSPrVu1DDqhdEW88I8gNe20MU4Q3R9OC0ezfPGfg59xx06IO7qn521sXwdtjEtS9qbdXTiOkapdFHA4NGQ+r3unQlPEoInHCiMVFad8727/aZ/snf2muiA6AoCA9hFNCR6iKbfhl4NXxRjfRj+zWeEkEv+OcidQBmMQ9g+F0Q95cTUrKCBH2LvNCSZKpcIIwwwW5BlATx6bPRLJSPsnvWZVQXgyEWb753RGUu6hbVFsZkSTfWxig7fLHgpKa1dRa/oWaP/bQoiiJy5ej2ENzB00CjNquln3cMO1ClBT3Uk31Qg2fQWVr8wnMIDhgeR4s8hA2TJKCfw/fu6mWkZOASgjrkzZWZ5oTnittCfdaiMIsqzKkvCbYkRjZ6H+D5Lb+6jNjK2xOmRzIP+LcccIRKkmbTwUz3znZJoZI+n9j45JvqHpYvl1mbAap4B59Rnq4XSS8q9ChvcInbGtbFYtvKsHe1cotgJ6NZMdthxHYunmGRb3gTVI3T9rXu3YyNstVIxDve5j+F77Zo7CqUjWk1EG64TOo3RUQOPINt2hFXOSkxZVtSaKbq6nu4k2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(4133799003)(3023799007)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmx6L2daeWwzczYrTjhKclgveFZjRy9GQWYwalpRNnF1ZTVWU21tTy9STkZj?=
 =?utf-8?B?WDluVGdEd3hrNDc1c1B1RitpVkVPRk4xY2xJTlZiQTB4Ymc2Nnh5R1pYT1h0?=
 =?utf-8?B?Z3BQZ05ISTYyWG8wWEpKczFvN1MxSjlqWXVmSWF5Z1NzdGJDcTBEbG5qY1lu?=
 =?utf-8?B?UjJMZEp1T3B0R1hoZ2Zsd0Z6aWNRei9ZN25md3VYVkJpRXppMGhiblMrSGUx?=
 =?utf-8?B?Vjl0UDNtdjRxcEZVNVk1Y3B3eEd2RFFCT3RWQUQ0eDJpUXB1dC9mcGZnenVR?=
 =?utf-8?B?TUtmWjZNS2F1NUtqSGNac015bEwwcDlNUHFCSWRibXFlMUVHcy82REpGTC9H?=
 =?utf-8?B?bjZMeDVYS2lPeEJyRC9idTNkMEVKVkJ3eC8zUUQ0VDA3TVlqN052Nng4SkZV?=
 =?utf-8?B?bW9iMURkZi9BU3RablIwOXFOSGpkZVN3ZUM5bTRFSzJDdk4wVkY4a21yQWVz?=
 =?utf-8?B?VytzT1pCZU9ibDRBL1AxcjhoeG50S2VDaitmNGs2U25kaGJzQlhiVS8zcU5E?=
 =?utf-8?B?SVEzK2xWZzJoZmxwbldvTlZPVFFvQU9YS3NDT3ZYTUlMelEvazBTbUxCbEpK?=
 =?utf-8?B?aC9lVVpjL2hZeHpzaDUvdFNaZUpaUk80ZTl3SWcvdzV0QWpMM0lucVc1Rnlp?=
 =?utf-8?B?SUJGeFJ1bUI4aFlkTndhakFmTjZTZU1tMW1wSWx5WHVVYzhSL0U3VUQ3VFkz?=
 =?utf-8?B?ZzJUUWtvSFM4Q3hwTHdZR0hEalZSYkJXd09JQkd4OXRta3BhYnRTeENKZTFO?=
 =?utf-8?B?QVpCUGtJNExveEw2TE5FNVdvT0ZQaGx0eTdoazJ2MHZLYXRMR3NyVVZVTHRw?=
 =?utf-8?B?RENRbkYzb3ZkcllUTUt6aWh4SXMzc2h6WHREZzlhRUhjQ0I4MlA4RjBieDJF?=
 =?utf-8?B?OTd0QUxId01tMVYvbmgvY0pON3hGdWIwbjBtblFGUjBWMUVUODg2NEtrdUJL?=
 =?utf-8?B?MnpKd0JGMTZZcVJNNVc4VGQxYUZDWlh0c3E5TGU2L2JiUUFLdUx5bnBWWFFo?=
 =?utf-8?B?eFVjbXNLUTdDWVVZZlpzNEdSR3IrSzBnMWs0ZXAzTUxHSGdrNGc5U1liUXNR?=
 =?utf-8?B?VWVRYUs2bXYvZVFNcGxKbXoxVTRQeU1vRGdOSW1tZzFWanFiWHkwS1VkYjlP?=
 =?utf-8?B?RnB0Z3NIaXd4SFBuVXFBUmpvV1FFSllPamhMaTk1QlZDYkFXcGFtNzQ3L3ZW?=
 =?utf-8?B?cEczUWlBWVFUS0dzc3JrdmpnMGJoREZUdStkVzJJSFU1UDN1VE9ESGZtQ0Q2?=
 =?utf-8?B?YlVFd05VQ2QrKzQvUXVmNkJCZHc2VWc4aGp2TlR5SlZyNDBLaVo0ek03Mm1v?=
 =?utf-8?B?cTM3MDNTeHNWS28zclJHNzhQOGJlUXU5MTkxakJhV2F3bUpKRzBxd2lTakZC?=
 =?utf-8?B?RHVMMStUclczV1BqUlpmSzIvRnJPbzhlM1FlY0NHY20zSlFpQm1XRjZnMlZT?=
 =?utf-8?B?MDJrRXhGRVRuVCtsaFM2b3ExeFN6dE94SG9xYmJhemVzcU12VVVLNWRGWjR5?=
 =?utf-8?B?T1M0NERpRjBlQ2xCQ3BwdGdDbTQ4dnU5N09TTDJLRUZGeDlNNUJhMDNuWk1v?=
 =?utf-8?B?aUQyT1BKUEYybWRhNHZXa1U3K0Z5N0RGV044cXB3aTNJeklRWjVKZEtKTjh4?=
 =?utf-8?B?M0RRVitqV29oeS9lQXdJZHRBOVowazVuUFBEc2JJdFdkZTRJcWQrbzVrZ1R1?=
 =?utf-8?B?ak9aUXE0cDFob2lJSjdnelVXSU8wYmNCaStCTHhPdnlHNWQ3SHZDRHcvY3JZ?=
 =?utf-8?B?aEZBYWZWTDdxcDJMNkwxTmxtSlhWbUdndlIzcVRjeEY3ckpIUWlFSkRjSWxR?=
 =?utf-8?B?eCt4eVIwc1pvaFJIU3M4cWY3L3lHVC9FSmwwUWU2NXNyYTlpR1pvSno5ZDR3?=
 =?utf-8?B?bE43NWgyd3J5UW0yRmx3clhXaVRlNjhCUlFwRVFEZ0I0Nms2aEtVaDJ1cWQ0?=
 =?utf-8?B?eFZsWThYQ0k3d1BmOTJBMjdkeTBycnVrUnMyNnBOUmJSTEhKdG14cjVuaWJI?=
 =?utf-8?B?aXFCWkdhSjhFZVpUcWl0a3Vzb2sxdk1nQlBCZU9HaEtHdnpwUlQrMFNSK1pa?=
 =?utf-8?B?aW1NbWhIcXpDL3R4TEJBdTJ3QmI2VXdNcUx3Y2l4ZVk3NVZOMVlRV2NGTms0?=
 =?utf-8?B?WlBVVkNsRWJjWkFMVkk3WlAxQU1la0dsTlhDckNZMFhwaFFFeXRKTU1KUGxq?=
 =?utf-8?B?aHYzUGx3T2VSNUVwUEVHUEs4bGxnckYrUHhZaTlUeWViWDRBZGNlN0o4UzJx?=
 =?utf-8?B?TmwzMkNyb0RQbVRuajBZNWpNQ1Vsb1pYYVRta2tpNDRTaWljM1JrVTBIOUN0?=
 =?utf-8?B?N3NaUDZ5SjQzQXhnMVBtaHNiNFBhUmtkNHFzbnFpaXBaQnVTVDcwQUhHeDRu?=
 =?utf-8?Q?IRHr55Ve1O8swd4o=3D?=
X-Exchange-RoutingPolicyChecked:
	Al8ToofSYnHzZ7/ax+Y242aog/3qfprD7WdSYqz3ZdrHaVNz7h1kUTLbDXBqAtmx5ng9OPxbmdkKPzfGDu+RzcTuB2LqLR2dQv4zxyWP50Ig1coxWGizjUtEO3qsixnlW9gyOK9UlGBaM1YMbgyAvjszw+sD5EA7SBfTE2Mc3hTMPVIThB9ANA5W4xXHUBG8RQDSFxIPHGNtLIQLJ24tVy8LLNROMctTvFATL1g5Ecm5M0nve80cfZSneUQw63QxNzp6Qz4cBRZRvm7eot1Z7lF5qKpG/yn0O8cNxD7HLRtH9XpyR5fWSLSwi8VDi11qB3WNW/TY8hDh2dd/qfgqWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vx7QIIa648+tJvKWYDNqj+y83VyDYH60gULqFvAJCvhqDauHK9KOMWP8iz0TuXiB85g2PkCB3tGiOUrbOzXRjb2lPwK3CSRxW7xz41/K1tPNcfl4aV+xLgcOmMWoybBif3aKekMsFiShUSzKbm9mMYURfmjPTE6ahvqH9XwcZjriVMNRMYSJUeDogozfywB+/VtUd4rr8wHPVsfqqU+qdbgISk9JMDEDzZmQgkPYoAGtDoYzZGYYrHRvWXr/fc/jyINKmgWsKXWxvD6vadVxFn//GwCMrt2H9xdzD1pu2pL9+mXPTEov+qaYhMat4IYSELf9y6168bG6UFipllZDPINjoLhmy3FKxvaaK66ROo2mgKG+eClV3YdB+7FJ9Xw4ACXzB4QjNo5C/U17Q85ckqFPz48OM92ahvcXw/OZRGhpJw8TMKbVxXoG4VrJnyGoRY/MdDkWocVcDE01d+uQwmgoRaHiMHrABXxyYWJc6Jdb4yMDRxk65dDOKggeceFcNCZFGkSOOEMmQZxSgf2Pe99UHMlBioAHXxdIv/ooI1jPV3PjxKCVCWIoIuys+lAs5HseN48x76hm03+qlz7MjueCWl9PcqoYtEhuK3Twz9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3116f842-a6c4-47d1-d95a-08df3dcb3e23
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 19:05:24.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjJ8GfQHSZjIPxOwLDr+D6nOi4LPkwBw2Y3Zj3v2lABuoAROYk/3jL37evd7Br1LXIXFIk5tEzwOkC93nIm2oV1mBVrosObP2eZGQsX1v9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611080075
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Bg-I4_jmnE6D3ebtpvH6goRNbvz_vWYJ
X-Authority-Analysis: v=2.4 cv=Y8NtIReN c=1 sm=1 tr=0 ts=6af0c7f6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=RpNjiQI2AAAA:8
 a=aUaz3pNcqSWJXo6QNZoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA3NSBTYWx0ZWRfX1Y6xQTiReZqb
 dvE//eDF6EerCsI5+QQ59s/ntM6whNLGmppuKRle0/owk6s5VuvM4v5jAiSwJpg3aZwbOsdrlWy
 YSHGd+d1n/FB0m11lX2rwmSSiDmfWMyJwBWZ+DlDFPGzGe8GIkSFcFEEFLK7TOvmNvgk6aMvcht
 2R9/03nWjSYyYrjjdFNh12r3o56Bj2wtcWxEE2EHcgDS1+fW8CUWXwlDBYEg9I0WXj0OqMEnEOd
 Y5jNtdLFbAXVl7A00mSc2PSyVsZ4V1L98hSRZcySOEHfsQqxZzOB+ZLlTDvVg7/lFxMy7kcAUwM
 FNLaA02WrM0C8PJbd9ZDtxpcGZGE4lKZXIFeNM13yF0Q82nHXNojVpkLO2Aa9zynznUG1PKhhZm
 Qr2Nom13TwvUQ8nE2pi73TXacsd1gQ1CBBVq5w1gO2vs4nYbVTn6dygJtJ+BL3uNTYNCxhhNV2E
 7dw/arz76TkVpREDNLGbVMEzHxyWaTgvSJvGZCQY=
X-Proofpoint-ORIG-GUID: Bg-I4_jmnE6D3ebtpvH6goRNbvz_vWYJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA3NSBTYWx0ZWRfX8SHTP52FBtD2
 2KFn8qTgGsiDsDqf8OeSZ34iDvPpyhsgXuo/UvKRJK4EKzqhbh9R9fzOqzYK6+KPzaSUz+i11hM
 X/+odFodMsinx+gQJ+CJkg/rf/qFl+IdgACU73OmQdPHGMfkniqS

On 11/5/26 11:48 PM, Yuho Choi wrote:
> vhost_scsi_clear_endpoint() checks every virtqueue with vhost_vq_access_o=
k() before disabling the backends and waiting for in-flight SCSI commands. =
If that check fails, endpoint teardown is skipped. vhost_scsi_release() ign=
ores the error and
>=20
>=20
> vhost_scsi_clear_endpoint() checks every virtqueue with
> vhost_vq_access_ok() before disabling the backends and waiting for
> in-flight SCSI commands.  If that check fails, endpoint teardown is
> skipped.
>=20
> vhost_scsi_release() ignores the error and frees the vhost-scsi state.
> vhost_dev_stop() drains vhost work, but it does not wait for commands
> owned by the target core.  A later command or TMF completion can therefore
> dereference its saved virtqueue pointer after the virtqueue has been free=
d.
>=20
> Vring access is not a prerequisite for tearing an endpoint down.  Remove
> the check so teardown always disables the backends and waits for in-flight
> commands before releasing their state.
>=20
Can you describe the bug a little more?

If we have done vhost_scsi_set_endpoint successfully, are you saying a later
call to vhost_scsi_clear_endpoint could fail the vhost_vq_access_ok check
and not teardown the endpoint?

Or are you saying that even if we never did vhost_scsi_set_endpoint then
when vhost_scsi_release is called, a command could be running in the
vhost-scsi driver and so we need to do something? Is the something a
"vhost_vq_set_backend(vq, NULL)" and vhost_scsi_flush(vs)?


