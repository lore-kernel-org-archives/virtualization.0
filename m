Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA4231C92
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939402; cv=fail; b=iqYEbTeKIRolrNmAyF3E2EJfhG9R7UTIj4iwJQZHRjeDlnY/cY2qxVTsbIaU9ClA60wgLicG41Dja9ucvQa64DTJI/vKDKJfcbwm82o5jUYJbznHoTISfL178cDkTLGHuKP61OxdpJmuI3Sp3SAu9Drnpfcr9OUOERY5cJ6GO8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939402; c=relaxed/simple;
	bh=i5+ia3c0G0ByT1KkUzOqcTfmhzu7niiyJNvuK+19Qws=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GrirtNKkGxJ9pJyXht+ibpoli+cNtc7k5QsT6R4LeY3ZAuZXk3CCbLzdBPYzYqa/M35NPBvmxZ0i/+qK0nimPIdZyWzZyZeQgJooL7V702lUEuCoZzC+GXTUGkY+EqgwdcSoQTSiaJQ4ypIBRCkDINGsx1KhAw21aNG0RdiozQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hv5XYrAR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bdn9NtWY; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hv5XYrAR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bdn9NtWY"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3306C40129
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 20:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaB0fUNc4NLH for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 20:56:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E80724000B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E80724000B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=Hv5XYrAR;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=bdn9NtWY
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E80724000B
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 20:56:39 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EKtiYt005099;
	Mon, 14 Oct 2024 20:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X8B5PionAwD2C9xp6Jxjz23bcKXwpjpjqOWxByZ7ZVg=; b=
	Hv5XYrARJe/1dIKxyXpRuUNJ+ez+NpkdolknQDHyVhBTTjA92Z9dYKpJ0/WK0+bs
	xreaN+3T0U829UqsrtesfH1xupDf6k63wUyCi5AIPtz2hc3FqFw0j4pVfZuf9RXs
	XfCGocCECson/TqZkE8XSOTMtKIVVb27MQkz+Y2E3BZcKMuAkh2jIMdPPXqYK/US
	ZSLjSknzn/1ov2SpU6pITHRyKRQz8BLtN5/NyA37umggFM620XzUaCHbIH3pAZkY
	sNr3tTcMcYrJHsV95vfQ+9X5r7X3aITsQULfAnyXVVUVcbjaD3aSwaY5+ncZiVzl
	PRki/DlFhoJAbfRlaAJiOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cfhqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 20:56:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJbUAV011049;
	Mon, 14 Oct 2024 20:56:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcv0yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 20:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rcl7pkoBV7sT500GIvbkVsqz7yawy9S7fjdzcO7Vs06czQLkKUgbmn/vhs3w7DdXct/uYHl2e/rzJq8vY0rc1gqeP+Pw+8FOEeAd2Tc5CoLVYJ07EoeLz4sq7T5u0BxqNGwtsTgie/jSUhuxq8TGyIj4En53An6hYUR039NY2Lep8fPBctOQ2uCJpVJR1deWLk+YL1ID44tePpj08wvvRiQ4+SFImPdLb1AshxHcEeJ56utX6+EJmony27v8Zx0fBlMbdO2IHtjzsZpxvPxuhFlnmNuNs6PshrhF1zNvxobhkFCHSq7lFjATVVVfdRBL86HC5COO71xowtEoT610WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8B5PionAwD2C9xp6Jxjz23bcKXwpjpjqOWxByZ7ZVg=;
 b=b6SPXIZmYFb/29gphkjxDBsHvuVLeEL7iFdVIi03FPnUrFbLIZIwWb7Xl2n0otguNRbRLnEUhgVD0yv4LQfNvf0ALCb34PmDBf/HFQzG4zjVqNE0irWsD7P0tXvvidr3ExPZEZzzX1pFOTr+DHT684+4igw4oLrl/tCO/2e9xLUz3eR5Z+Wx/jJMlO2pj7MTm1/EErbhMH+tpZKMGCFNST4QY5GgFRosu4yal0xgszeyw9UMQrE8UQDp25G9EQLaz+sO5pe5gJS8Bd3/VDspZzLfYoSqOXKbJGjOiICxYfwBjUsATKNZ2OvbtkZ/r10hyGKNgnRGqY6hRMDzMosbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8B5PionAwD2C9xp6Jxjz23bcKXwpjpjqOWxByZ7ZVg=;
 b=bdn9NtWYrfT7K0Bn0BjWYdkwLagnugRtPtNwJZRkh0Gg7/T9Dm1JRgHVLMTatwowKqk96cHv1AFyVtBD9prdA8/pnoNlJe1ZG+MycOEK+lrPlNtaXSUf5uHkPlJAwfXnp8cKNW/kB+45DiPVawyruXjMs+m+TCodkaBgKn62vSg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB5673.namprd10.prod.outlook.com (2603:10b6:510:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 20:56:35 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:56:35 +0000
Message-ID: <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com>
Date: Mon, 14 Oct 2024 15:56:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-8-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241004015937.2286459-8-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: d920f0e4-5eb2-4777-0335-08dcec92b06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bngyRmdCSmJWcXBKaGh0N2JBSVF6bW5DY0hjajBBUCt1VkNOaEdoa3VZb2U5?=
 =?utf-8?B?b01DQ3VSREc4WEIrNkhpUGFEWHdOV3Q0dkoxMVorN283c1ZUbWtsWWxOZmtJ?=
 =?utf-8?B?ZE83WTE3cElqbFpzWlBCZkd4TERtNVE1YkZXM3Qvc0pXVVdXMHp3eHh2QmN3?=
 =?utf-8?B?eVR4TFNKR091dWFxU3FpMWp5WExaVlh5MklPcFRnUyt2SGNYTVVHbEsvaS80?=
 =?utf-8?B?M1E1Y096V1FBY2loNG9hUjUzZ3dpd3JYc2JFS3ZQU0R1Tk5tckorSk5mMWpZ?=
 =?utf-8?B?cktNbHNqR2ZTd054cWs2MS9naytmWTRXQ3RCL0I4K080aWlmaEZiOG82Y3ZY?=
 =?utf-8?B?MjI2RCs2RDRWUWRsb2VaYW1UZG9DNmFwRUNKS1ZKSXZGMUJuNHpRaXpBRHpE?=
 =?utf-8?B?bzllRTE0bm5hYnRydW56NytLNjZMY0hXaldEZ1d2aFBhc0VKV1lDeWw3QXp6?=
 =?utf-8?B?VmtOQmVSVlAxS1h1QmV4d0xCcVhQbTRtTUJwaStkb3hjbXlQRkQzcVNDSUl4?=
 =?utf-8?B?YkRETHlPN21sR0tTeXpyWk41Q2Zpdm1rallEUUhnaEh1RkJTMHVINVdHWWlV?=
 =?utf-8?B?eURlem00b0lCaTNNVnh5K0NlZG94N2k5VFdNbkNodnFFS0JXckovcmE4b2Rq?=
 =?utf-8?B?SzNab3cyekk4cmcxTklsN1lRMGR5N1M4WnZmOHJtQ3pDVkd5bVU0d1JMYnJu?=
 =?utf-8?B?bWViK3M5Q1BaZGpiNUh6Ui9QczRGc25zYTJOQjE4azA4ZHcxemNJV25HTUFO?=
 =?utf-8?B?WnJNSmxlK2dmZXM1SytjMmEyUmFKQ2F6d1JiSUtDL3VkQklJVExCQ2NidGZB?=
 =?utf-8?B?UEo5SDZPdUhmdzROcUl0Y2k5UzRseTlOcWtJd0pqT3lhVi9FZ01LVjNPa0dC?=
 =?utf-8?B?YzFmdzN5TXFiUmZCYlBWYjBXRVkvaWxRZVF0VE53MWFiN2VYS3Zvbkptbnhu?=
 =?utf-8?B?ZklSOXBKSzBRM0FLcXphK0NmQWprdUUyS212MCtXdzBtWE1Ja2FYK3VGdWE4?=
 =?utf-8?B?VWJ5SjZ6T3VFWlhZVlRxcS9IQWdUYmFXbncxMkhnNWh6a2VJQVVXeGVvaC8z?=
 =?utf-8?B?dC8zMWVYWkdqbW5ZRG85YlIyS0ZHY21iZ3NHaDJtRlllbHp1QU1yMFJoUFh0?=
 =?utf-8?B?MGZVOHRYMW5YTDZ3UzYwMFZONWFkeE9SUE5ZSklLRS9uWVBuREFiNGVaTWRr?=
 =?utf-8?B?allWR0tGUVhhTHhmQnJBUnZ5R1QrUlQxYytmY3J5RjJ2WlFBNFVSYkthM3NV?=
 =?utf-8?B?eGpabWVUZnRZUHduLzZ4eEtpVXdGY1lxNWVIN0NzaTZtVUNjMVhYdUZoWVNR?=
 =?utf-8?B?bHE0TVhOQzZHSXIvL1o3YVlCZWoxRjlNaWgrbXA4WXVTb3dKSm1JeUdEVmFR?=
 =?utf-8?B?WHFZUFl2L3NsQWpCeit6MU92NVBNclZMZ2l3RDhYVVZmUHZ5akFxMjdIeDJ2?=
 =?utf-8?B?MXIrYkVrV1NiY2p3N292ZkdTRlRRZHY5S3lzUmdqcFU3Z3Y1N0psd0dRRDZ2?=
 =?utf-8?B?NkQyNWVWeStSM2RsaG1POFRPT2ZsbUZOcmh5OC8rTDllQkdvOEZydDc2NTBQ?=
 =?utf-8?B?cmh6U0FqR2lrNXhpcVFCSk85YS9QTi8zcUtrNnpFVDNmYnI5ay9XeGdLTStq?=
 =?utf-8?B?WUxsdVhKR2h3QkFqdVBPdDFmN1A1T1NHdytSN0VWK0drRWdTZU92c1dsZEFj?=
 =?utf-8?B?TU04MWNQTEk1U0JWWndHcFpZNHhCajZNaFdleEVqakhqSTY5RlhjTitRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uld4OE83UU1aeTFkdi9qT3RkZHZaTUFFcFg3ZW56MTVxSVZ4eVlNbnpiaXVo?=
 =?utf-8?B?QklZWGFnWmsvUUhYcktPMC9xeWFrVkI0Tm8wUlJGT1lDYkVGcGswSUlaZTNU?=
 =?utf-8?B?OGhZbitOV3VoLzJnVmUzeGRhbkVQQTl1TzZBSjZmSzlqQ1RFL1hBd1Z5UDVa?=
 =?utf-8?B?WHUyaDJvQStCemlBbWlwamJmNVFFNWNQTjQ4aHkxRmdTWFhDVjlGVjhiSHJp?=
 =?utf-8?B?bTlNb09XS1UwaTErNXFOMkQrSDJ3aG56RWFzdzZFKzhMbk1kM0tmOXFaTHpJ?=
 =?utf-8?B?YlJaQmVwUk1CWGxBM2ErQnh5OTRNbEE0elQ1MSttUVMrWHlsVTIwWmEvZEJL?=
 =?utf-8?B?bk1IcUhUR0paY2dDRVRadkZZVG96M3pnYi9qTFBFT1RpT2xWQjVmaG1WeTA1?=
 =?utf-8?B?bDFMclczd1FzN3ZpTzRWNGU3SzBrbFRnbXdxNUtaVUJSYWpyOGhtbHdJbDdk?=
 =?utf-8?B?ZGo3dGY0QkNaM2lzTHU3dzhWRFBHZTQ1VU9LNnFCNGIwU3crdGVidERkcldl?=
 =?utf-8?B?RUo1YmxzaGpmbnlUOFBjaGo3amZsSHY4ZzNVdUFHRDJ0ZW9XeTQyZjhCaWZK?=
 =?utf-8?B?YThSdzBRYjRsUmhrVVlORVFscmllYTdmK01wYzZGcXV5d0trVTZBSWd1LzZT?=
 =?utf-8?B?Y3VNRGhncnEzV3RYL3JZV2FteTk0TFdQa2dTVFVidm9QcGNUU0JPTzE1YnNn?=
 =?utf-8?B?cWtPNmRwUGJvZ2FVL2JDQTRQZklRditLOEpiVUtrK2Y0eWpIZ2dQZDQ0ZXZE?=
 =?utf-8?B?NEpFK3BDeWtkQmx3Q2o5ZStQUEFoek9ucTF0QmEwZFB0MVJ0WlMwREw3enBV?=
 =?utf-8?B?UnkveHNrb1VCMVhKMnBWR3lLcXNFQU4yOENvRUlrUnZkRjE3YTJtY3pjdms1?=
 =?utf-8?B?SnpTdWF5ZnQrVW5sWGZDc2hBUUMrRmg4NGtxZUh6SjRpTW14N1dwNXVJNEV6?=
 =?utf-8?B?L1d3em5oVTVXRFdVTVdQZUNDdlFzZjlpSENDZ293U201NXJTcTJMSjZRSndE?=
 =?utf-8?B?UVFyajR2OFlYMnpMY3NpNXpYRWgzT3pyZmU5R3doYWRZbkl3bkQ5anNLa2dy?=
 =?utf-8?B?bXBSeWp5c1h2eE1ONTBrU1NiMzJUZDlzcnpSN2FiTVgwdXhnR2dCSVdLaHZy?=
 =?utf-8?B?cUU4bE96cHhCNzRBMktpYXRFaElUYTRzYTdFOWN4TXhYbnprMnFQempRTlQ3?=
 =?utf-8?B?VXgrQk00QzVEU29mMXIvaHFSdXM1c0gycW5PalhjOUJZdWF3a3FaaTVGd3JG?=
 =?utf-8?B?UWNuUG9LOCsrK0RwQ0dQVU5qdjlHNnd0WndTZHVWeHdBb0lBQnpaalpTVVhP?=
 =?utf-8?B?d2ZaSmUzT0pQeDM3c3E3TFprN3lZZmEvM3pHOVozdExFcHZ6dFNmM1dlZ0Zn?=
 =?utf-8?B?WmFIWlMvWmw5a0lvSVY0SGNBOGdiczNXcWlOMTRmQStMcTZjRHRQZHRTQitm?=
 =?utf-8?B?Mld6djY5dDZaYUpjeE9zUjJNUURhVVRQaTFxNzBsR1l0cFFBQThvVWM3OVVi?=
 =?utf-8?B?UmxrNmwwNlRzbmt1SklFcGl1L0lFMThLcm9tLyt4UFRwK050T2hnNitqVFBQ?=
 =?utf-8?B?ZGJoTkhLa0hjU0ZCTWRKcVRLMWF1dVNlNG8zcDRxcVJwRitOUWszN1RIN0JM?=
 =?utf-8?B?RFpPMGFiM3puV3NTZ0NBZUNBbWI4YU1HeTdNY1ZHNGFtbjh4SlhPYXZDMUFB?=
 =?utf-8?B?aS9CR0xyV3NmdDI1c09pVWQzZ3ovNmhzQ1hubDJGVkloZjJnYkpXTW9zNmhD?=
 =?utf-8?B?TEl6Nks2VVVBNlllcWV1Z3drOGFIUzJ1ZWJHYnQ5NEVUaUo2YlhQWXBFazds?=
 =?utf-8?B?VU41SnRJMjVHMVVLTFpLTGlzRHIzNDg3QllpOW55aElFa0k3RGJVWmdhWE1Y?=
 =?utf-8?B?QmZranZ1dUhBamhPalN6ZU1Hclk0Z0VVOE1vSjd3M1dkZWRTdmRPZkdQdU1O?=
 =?utf-8?B?ekxYb1U5Ti9WOWJ3Q2xJRVh6bkgxYnlhUC9JK0JBWm9ibitlRFRmTjgyeFZm?=
 =?utf-8?B?bnZ4V21MZSs0algxeEJkVFBlS3VnbkRiTWhQYmlIY0VWMElEazJBb044bDIv?=
 =?utf-8?B?UnMzbysyOFpiMkkwd2dBWFMydTgrT2ZVWk1kRXpmTldncm9iQllkMGs0dzRs?=
 =?utf-8?B?bzFwaDBMT0hpVTBTbVpsMUxtemovL2xXNjZYWUpLdm9wSFYzSGdia0hOUUFN?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ldApi0q5OBb8Yqk5/KRi3ZzVzPv1qa7bjsFN8ltzUwZft8guxaaWRhuQY7xE48QcYiDfu52x/kPje/coh1TAe+gIU2caa6jnDn0pDZsbegI7IZL9s8hBv5sooSd0yca/+yTnQF+rzMVHlSldeLl7i69mRi9d3TZdnNSYtLIxVPHSfdOSgC9yp2TYajbC3hvk4OQkNzOykJmlVmiBctvGiU4jX3ZPqVnqAycZCsc/YHGwZI9gZBsGvuOOZnSZjaUJs1+7Bl57lp9OYaofwaxuHZdrfL2AYKdLpO0zFGe0RLh9zPWEAFLoJB8UMVUZTqClmsMWxwywckbbFlTWTmeXkzvdmYPRlYL03ZKZ9J5yWRb2ilj7LvLtdqA1B9IpttJ4kUlMlsmCtxmCO2XdVfrOG7nmUiMoHL6p7gZ/mu6H3VU6yK+o6NbLhL9xUyPiFwYeJjJDuCbdTTZR1mEKIFJoqjyLL8PMX/8sOOAnitOwbpynw8wjf1bybJZetkLbgWi774PoEjrAhwVcKL1VG5tx0+tPS50pDjO48IphHbz4RS9Pe9uwfWOarfK/wWMbENAbaJxb/CBiMCG7lGi4HvZ1gEuJQr+vO8+eG5ATJnIYvHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d920f0e4-5eb2-4777-0335-08dcec92b06b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:56:35.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FciRJ9J4Ra+UtPl9WZqUa5kvhHNAVvPqG9JPLhRDjTaI58Vmm7Fj9n6OhqOHpozDxrNd6p8NHOsTbyw39D6qKqcIw9HPtcXHL5wV4lbp6/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140148
X-Proofpoint-ORIG-GUID: bE8h1zmi5bDAb0OmgUZh_kFYrW1c3O4D
X-Proofpoint-GUID: bE8h1zmi5bDAb0OmgUZh_kFYrW1c3O4D

On 10/3/24 8:58 PM, Cindy Lu wrote:
> Add a new UAPI to support setting the vhost device to
> use task mode. The user space application needs to use
> VHOST_SET_INHERIT_FROM_OWNER to set the mode.
> This setting must be set before VHOST_SET_OWNER is set.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 18 +++++++++++++++++-
>  include/uapi/linux/vhost.h |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 08c9e77916ca..0e5c81026acd 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	bool inherit_owner;
> +
> +	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {

Maybe instead of a modparam and this ioctl we just want a new ioctl:

/*
 * This will setup the owner based on the calling thread instead of
 * using kthread.
 */
#define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)

It would initially be used by vhost-scsi when worker_per_virtqueue=true
since that is a new use case and there will be no regressions.

For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
tool XYZ can use the new ioctl when they are ready.
