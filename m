Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD92489896;
	Fri, 31 Jul 2026 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540693; cv=fail; b=kplq5se97tOyAhJDQ6GInuePzpFUyPduO0aQXKROGHTogjHZ1GDWr6ZBDGUr22/H7vb1UCt1CZ42kJvIctkkAxaSuOVO+/j+fbEJo4l+kgH6u/Pmul1h/6VsQ3YTpKaBaPJDQK9SUysSiN7O+KldPKddb2pgmCO4GdwydXbxQ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540693; c=relaxed/simple;
	bh=xXlQ618BVy2eJSp8L/9pkmV0kL2Bu5YYrcOoM/VnY90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oywHV1b+tIqIZUTDt3irZCibx0FuuNc4VxqXjcy2xm0AWJzMwjTBGhrjNkPWcZ1E+5SF3nM5pCTl2tgur9sBg45MoVaZuQg1L9PbZUsAS1hYORF99WngGBHcyX27WduIDXxnzF6EIarogQHxzLzT0ikqBsWzMbubswkeCXoKFSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKEdYm4k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fqt0lthV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKEdYm4k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fqt0lthV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VJtXQB556811;
	Fri, 31 Jul 2026 23:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ulda2ngXU2alU+XvB5xkpj3Nutsuq9CrFsZbYnQ6tfI=; b=
	IKEdYm4k9WJBsRssrnwZq/pReovKr85R5XtomKQ1viwtL9rHiEMS29qjVhgiDLdX
	FqfHkDT/32jWRhwJ/rygfoomDWz7DQTCpEpbo59rzediNTOcF5anv8IKVmMVddU9
	XFcbmhBQ0HGK1uahO06XNIZa68VBo+UEUmfxmECyurrBfZSsmNhDIKMM7UKZL+je
	Tzrw3qQ6OSK4eeCgPs0c9gur7gaM8hX4qXe+zHD5O77SLxCdw8XhKeGgYqggwSwx
	xEm24BpL4QY5kiVfV90mfoYUD7AP1tpm+IFh6L93esBGfZSzTiaTycHTAvK/sD+r
	vvEfbJeFKRBFvlaU1eMkyw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr3pvb8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 23:31:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66VNUWsX023293;
	Fri, 31 Jul 2026 23:31:30 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6h542f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Jul 2026 23:31:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPOVhQZZM/oV8G1BpvqD5mkCngLC2djHXKmDhI2SyntZ0LWC9nNxeWguaKstU8iPiRbUZRqLSuPQRqjSEKky3exZ5P13+obASgVC3nqNai/7pfsLViHBdOjoEKOuOjQdfereY7wE0L1Dl2aUdxCEwssxLzslEmzvIj0M3vAD1gfDVyRgKuhedQUDPbMHwuCx9imsD61IwsFADUkE5/bIU3aMcN+kwVaO9c3BR36/tkFy2N3N9rniCUOa0OKuBJpg9aca6kp+ESg2prV5bWejZ+OM2N8mtLRXPZbkw/krELF32nH8AC2zl4cdRJtlfsZP+ZOPA9H9hhga6voQOFONZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulda2ngXU2alU+XvB5xkpj3Nutsuq9CrFsZbYnQ6tfI=;
 b=J48GH/CBs7fx3X/CPj58TdVA72XAf3iePDTsjlE/X7MKTB60dE/nzNz/ghHlVxOTBOHhQdmQfNSrAM63UedFjFjLcqDDkDw4nH7FBU5WZOURt0ziobNU+2NoU+GIuQtIwYVvWmoVbS6EYUi2qeKqqTgh9lCW8WVIJx9nc9dSuKx71cdZyh/YpuweVZFUlxmKgEQFG1mZ/J2oLqH+ADE5WixYF817a6bBtbnvvG1HiJf+xv1woMikRTrb+TWmlc8IPLX3fFR/LufW4iXyAx51aVWrzhfqC5qT7RWCCPyE2faesWjxX3uQhNaY7p6fAlShBT7Cr8WQT4503gU1CROAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulda2ngXU2alU+XvB5xkpj3Nutsuq9CrFsZbYnQ6tfI=;
 b=Fqt0lthViM5bMa9dq1xLfD9fehQ2cEbQqBQUrKcJSgrv+cnMotZMy9vRMRxml15xeN9dPVp7asD649u8WKQJuolbiybuLe9cg/QMU53i7DJZ3w0Zlr6ILdTOroGfU+jO134jnvznegATkhgA/ZR3NvLXxlnPbMdAw0MrrIRVOmg=
Received: from CH0PR10MB5114.namprd10.prod.outlook.com (2603:10b6:610:dd::13)
 by SA1PR10MB5822.namprd10.prod.outlook.com (2603:10b6:806:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 23:31:25 +0000
Received: from CH0PR10MB5114.namprd10.prod.outlook.com
 ([fe80::3fd5:7a43:a13a:9aea]) by CH0PR10MB5114.namprd10.prod.outlook.com
 ([fe80::3fd5:7a43:a13a:9aea%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 23:31:24 +0000
Message-ID: <e09417fb-9d71-49ef-b405-5c52d8e02684@oracle.com>
Date: Fri, 31 Jul 2026 16:31:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
To: sashiko-reviews@lists.linux.dev, virtualization@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
 <20260731222633.15DE01F00AC4@smtp.kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260731222633.15DE01F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::31) To CH0PR10MB5114.namprd10.prod.outlook.com
 (2603:10b6:610:dd::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5114:EE_|SA1PR10MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bf61a5-6cc2-4813-d662-08deef5bd627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+rmB5Iif6ADhuMT5ADCYRF76guI912ZKVQ9I/LWw3h9CroFzgs2yTyzuABuvc8nVK2A7Ftv3mVOkNy2BVuK9wDbSQjCnFuuKd4vEVswW5fT2SOmVs20fxKJsGiGIm4+BMSJ3cESno2zJ2Bh6HQfRoPoQLRKkUP1Ms6Ku3Rd4+FAIX8QaKDVN72bH1SjbD/5Ijh8tgYqdi3gHQc2LmUGMo1b8l/CC83sDOzcmw9arsOKfUex1mjbbWgPqU+UYDZL2/mCq+8pZlRzJ+V33uHvHQrV3dmfBawh0GyGsLzSCe7b5YeITK08JJesmDNP6WKQXikrU6LyOAR4OQI0Ue3EBzqaS3t7mLeEHBc5kDBi4ZBUd87IIvY7wYHpILvbKq9XAYADCfrk/wyI3UP0G3y/DQA2U1b8a1Co6Tfe5TQPqEpT+6HPuKkQX+EycIInK6SUYkWEPggP4NIqPayFnkFfVj4fMM8SrKdlfSM7OtAB//ZAjyFu1U/tTJVb+dzAn/ov2ozMq1UBAxJKkz65pkutFGW3q87ElpwdgwCpOM5yhMhGg/iqsboC7lCHm0uvfNO2Hlyb/1dSU8eWYWgPk6+FM9TMVgm85cqumtaWVCE0ZTy7wIRKa/moFoZiV1RGq9r7jER/oSreckM4IX1KUaHDnNTSN/Iu5IUHsw64HWaW37So=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5114.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGlhaDBaT0x6ZkFwbUpYcDNtYWtSb242K3d2VlMvYzJwZXdXRVBJN1pxbUdn?=
 =?utf-8?B?bXpDcm9JejZ5c0lVN3BaY2Jxbk1xODlMOGpHMC9ZdW9HNVdCZm55cWM4aEpE?=
 =?utf-8?B?MTIrM09HM1V4S0dlVEcxeUZ3cHc2NG8rZHBkd1BOVThTQU82U2F6TnBEQ0Qx?=
 =?utf-8?B?WjhXajEwdU12MFJjY1pxMDVZUEkyTTBxL1hzbEtyTXlqV3UwdjRoZVVEc2xi?=
 =?utf-8?B?SFZORDk0Y29Cc3F5N3JKZ3MyTlJiUmlNOWdSYmkvczZlenY1SXB4aWt2am8w?=
 =?utf-8?B?cXdrREYvc2tsWTNKUkx5Wm9uUnF2MHJ2M3ZEN21TeWpoSFZpYmpEVXN1WWts?=
 =?utf-8?B?V0NaUGFaZXZsdklKajUrMGsrUHhxVER6TmI2SVdXbVBKN0JSbEIySk1TMVdo?=
 =?utf-8?B?SDh3S1B2bVQ5SnB0cU1rUlVFUTBoTWdLei9RcHlFYnFZaGpZSDZsN2daOE9P?=
 =?utf-8?B?NDM1NWN1MWpXNWd1SHA2OVQzR083UGNISWRRMkJXVFloejRaZk91ai84dGN6?=
 =?utf-8?B?cnFpTGVSS01ycFZoUDBCUlZDT3h5RU1sVVBqd3Y2VGRmNWpRS01MaWxWbTBN?=
 =?utf-8?B?UllrTEVwcDVQKzhHUXR3Q2Z3ZnNpNW93TFJQTG1SZ3lQckdwbmk0ejlleThn?=
 =?utf-8?B?V0ZDVTU0VHNsRkM0MTNRVXlWc2QwQktBc1lFcEFKU0tQcysrbmRybHdwdXAv?=
 =?utf-8?B?RnRuQ2dONjhUbW93NXJSakIzdXVCbUJDVGRjN1ZmRWh0UjM3MTIzaXZFZFhz?=
 =?utf-8?B?ZEhaTHVhZHM0b2xHa2lMUm95dlpsWVN6TzA3OWt2NTR5ZTFpWTZJY0c0Ymp0?=
 =?utf-8?B?czl4YVRKTitOc2xqKzcvc09xcU1oUlU5RGNUK2t4UnRMNCtFNXQvaHN5ZHlu?=
 =?utf-8?B?UlZScGdQdTJoSU1Renl3SVNvTjZQM1ZUcDB0cXp5UUFkQjRmR1Fna1pDSlVJ?=
 =?utf-8?B?R3QxdXlDNmxLdHlQbzJ6clh6djd3SzR4cnAzcUpmNXhtRE05VjEyQ2txeGs0?=
 =?utf-8?B?SWxJd1lNTGI3N2VXaEl3NGszY2NzbWZDOXU4SFNaNzQyeFRSWVZXQ0JsZ2E2?=
 =?utf-8?B?bUkwcERYZndBMGUvTlZEUzR0NnpOblVVenNNemR2UC9NcWhKSFBodEVrUG5F?=
 =?utf-8?B?NHNoUEhZdk5rT2hYOHZ0dytEZ3FZODF3QTdjQ1NqejhKemdKQSsxM1JtTmR6?=
 =?utf-8?B?M0M2c1B6OXZyYjlxRDNjVEx0TVdXbVVic2lYUTI5MWVTcjFMQUNzVlZ1Y1lU?=
 =?utf-8?B?eXozTm5zZXF0SXpuWVZLdlVjQWRvRlNXNS9RaWg3bjVENHIyVjlmOUwrc0ZO?=
 =?utf-8?B?MEtNNlhlY2o0TVAvUFA1Rm1OdmV6aTNrZmV5RHc2RmxHQ0szYkpTVlFzT3Zp?=
 =?utf-8?B?Q1hhZzdJVHg2bzlFMURBaXhRcU9FMUZCZXRzWm9lYlhlVHErU2RIZ212S1Zz?=
 =?utf-8?B?TFYwMlh1ZldqR2RMT0RTM21zRzBIMU1pUTYwOVR0MEJhbHBQTm01VDFzcy8y?=
 =?utf-8?B?MXJNanRydGtWRGtHMzh1WTJLZ29FNjZ2OGY3TGJuSjVFYVdKbDlyR08veWVq?=
 =?utf-8?B?R2hZNVp2bkNvY1hPN2NJSnFCWHRwcUFKYzBGNFlobHdxWjhhSVlLbnFFTHMx?=
 =?utf-8?B?c21tR0toUE9LNTVFNy9Pem5QZERjY2s0NnBtNGxwZlovbWdEeVRzYkFET2Vk?=
 =?utf-8?B?eVQ3UXhzb245WVJqR0FJUVBVazFvZ21SUFBrZXQ5RkNxdm1kdVdXUkEyM1Ax?=
 =?utf-8?B?QnNUZUVsWnZjY0RBYzRldk0ydm1uS0o5ZWpaRXJXd0xLQXFTWDhZQVlRZExq?=
 =?utf-8?B?Y00rY0FPV1J2MjFLMFNLQkVtNDhZVWI1NjhjcmlPMk1uSHpVaU4xYTRhWUM1?=
 =?utf-8?B?RzdJQVlOT0doSHIzM0NnVTBUWXJWZDZJZ0NLd2FLN0JXbGJ3VHpRbVVwcm1Q?=
 =?utf-8?B?eThPRGQvYW9nT2QzbzFMNWZxVXoxaDlNUEgyKzFQUE5jaElGNjdnKzhsVk1u?=
 =?utf-8?B?OE85dTY4T0trTjhId1p5RG50TnZHWTFmVnVVYUswNUF2bEtGMHg0citkUGFu?=
 =?utf-8?B?OVJQSDYrS3VSM09aYWRaVEJHbHozNVI5WXladnRLMFpvR3grYzBFVTZneDlD?=
 =?utf-8?B?NUN6a2NHNUYweU85NjNTZ25haU5TY2ppd3JJYURGd00zSTlnOVpEb09MWFhq?=
 =?utf-8?B?aVZWRlJwci9na095QWNkN2Y1VytKZnRWSUI0Z25DWllYNnptbW02ZW5JYmla?=
 =?utf-8?B?WDRoT01iN2QwMVJLZlFsSXhrT0xDQ2tWQU5FUmFaNGgrOGxJeUJNNVRCaHQr?=
 =?utf-8?B?aWdhdUtVbDl2WmRmb2ZocTN1OTd4TDJIRkRkUTlVTi85SjNkTktTQT09?=
X-Exchange-RoutingPolicyChecked:
	YZs7bQN5czYrUK4Rt0G7qkYNn2XoXCoxu4KA8dMYxn24qzAlmFrk5yuYDLUNFnbHNOpT3VnDVsANLsyEQf7uUyd6I0M2QyrQ0T6+Bmm329St9o2E/I2QKPC/0yUcXTIMX/7cr5wnLXSh4BohT03JvtwrmY+QyvdU4iSW/klKidbKagDnmXXRoRHOIQ3WcwQXEQQi1/0tPSTv8+imRf4PSpk7IYIUwEFx6sqcNEHnhQZKk9WRfOYIaf+XXNAfkHxFka2i9QnEtMGHhHaU1GIjXhrAYy6UTTZVYvw8HLZgOhnJye9ojOkvXOI38xu2VD4NxP06k3JLoC1E5nTCjm0ELQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1twpRbsdSCV6GBQ3eXU12IWhca+/2DDNKwtoc/EfXpM5q7nMNHvFNso4vqdJuUMFc2L14lxNfzuEu+v+P+3BLFsYjLJf61JtqDAYj2BBcL6HOiMr93XukxQz0jetWVEpDcz2j/WriVTGuzu4PU9ytn+Hn4gzu8u+HTxcUcIUhI1DAX4QZxfOJ4M/pyV030leiCr+yUZIsExvtnNkxoHL+qALCc4HMal/Pjg397XYCO5WT9yBqawwrXZZG+G6NeLP/zaevWA19oD2w3oetHO5OtBScBc4oexkTZ2shVzYj29Ce3eZyXu5JGvwpT1vR/v5GVeFrl/tPJW7u2w/VLT9arIkGwi52ITEzE8zgathIM+J1AEo8ucNnbbcCNHbRs69M0HdTkyt71Y+eUo8Kv5o8g53i0VLHu+rBiDrtGmwe2Yjy0/Inw3CKbuO8CddIAYWYllONoDRmjB3LufHc3OOA4vxEQZoKqyThPn9kRucMD17lc8S1KAYExC/gDHA57I4aD+5n0fCKdym9hYcRXQhcrvHuLV3e43eXi4mKyMxrh8G/gA1roS9zN5vlnktQuMvpywLWwanNK9rZJo2Iv6OYx+pN2y1xhbt9CWuKhULpJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bf61a5-6cc2-4813-d662-08deef5bd627
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5114.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 23:31:24.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS7v0ZE25OHw8B8wEdxVSf1r74kix/NYhqZwyNNQK4wG4Kk1x/dxHMRkXapo8e3F5i8DHV5+aFjm0Zb+3bTpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607310175
X-Proofpoint-GUID: RZ4tBCZkN5i2OPAduPRZg59yGVOi2LIv
X-Proofpoint-ORIG-GUID: RZ4tBCZkN5i2OPAduPRZg59yGVOi2LIv
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=6a6d3053 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=5XnUyo1y9buXH8hDG1QA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3NSBTYWx0ZWRfX/iqVSjhFKEr5
 dtAzID+Vvi5mAlwpt5e3r9oLHUQZWItPApvWE1lHQmLYrAwDKw9mqhfpPe+ItMlNkByGRcSpb6r
 KyuSCBl8U4xmQuCZZtnQKgWFzh61DrUfSdB9tYeXS5wBBZzG5y6BHrDe78CAtWqR5N37YFpNuCv
 pR0PZyxNm8Ch7lthUW5FoSCePfr4tjP57gRxvpugx7alt0NK3r/jwPC4GuVzSPN4BKpOxglflKZ
 cnROVaC+2LZjF75P+F4PmXS8X8oXv/zNwxpZz5rPYKUAEMJDlJZun5+7x/8MkwxTFyYsA1RtMtQ
 Ss2qisapd9/ri99FU3iNUGu207N1MHdVd5rn2EnmbOGxNkiBlfA43SX7j8qHhzHq64NM0wqSAZe
 NqE2zLz0CHPkXN+t1d3ffRgm/ctflAnH/bSmUXc65FVefxiezG1JWpSBNd4Hzyml7baX6LN4g1t
 gyJwtBmNvqB3ZGVxI+pErPy4aZHrQTAGRWM4a+lY=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3NSBTYWx0ZWRfX4xcg4Rlph6OU
 z21sGk79E+NbrzoKRDB5hrQSE5bAdZ+msx3BRb78KoDXmgJ949swC8Nf3Fi929WoG6qpdgNYlte
 YHaJFBaJGKzuzGuTmmrF6G7ZO5Io29Y1m0c7dw6/L2Igt5Z+s2PJ

+ virtualization@lists.linux.dev

On 2026-07-31 3:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing READ_ONCE() on module parameter allows compiler rematerialization, leading to TOCTOU array out-of-bounds access.
> --
> 
> --- Patch [2]: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module parameter ---
> commit 93f3d55f364233d31773cdb70b64bd78dafbf480
> Author: Dongli Zhang <dongli.zhang@oracle.com>
> 
> vhost-scsi: reject invalid max_io_vqs module parameter
> 
> This commit shifts the validation of the max_io_vqs module parameter from
> device open time to when the parameter is written. It removes the
> bounds-checking code from vhost_scsi_open() and uses a module parameter
> callback to reject invalid sysfs writes instead.
> 
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 0c0634eea1443..c138c29ce3dd4 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
> [ ... ]
>> @@ -2273,22 +2286,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>>  	struct vhost_scsi_virtqueue *svq;
>>  	struct vhost_scsi *vs;
>>  	struct vhost_virtqueue **vqs;
>> -	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
>> +	int r = -ENOMEM, i, nvqs;
>>  
>>  	vs = kvzalloc_obj(*vs);
>>  	if (!vs)
>>  		goto err_vs;
>>  	vs->inline_sg_cnt = vhost_scsi_inline_sg_cnt;
>>  
>> -	if (nvqs > VHOST_SCSI_MAX_IO_VQ) {
>> -		pr_err("Invalid max_io_vqs of %d. Using %d.\n", nvqs,
>> -		       VHOST_SCSI_MAX_IO_VQ);
>> -		nvqs = VHOST_SCSI_MAX_IO_VQ;
>> -	} else if (nvqs == 0) {
>> -		pr_err("Invalid max_io_vqs of %d. Using 1.\n", nvqs);
>> -		nvqs = 1;
>> -	}
>> -	nvqs += VHOST_SCSI_VQ_IO;
>> +	nvqs = vhost_scsi_max_io_vqs + VHOST_SCSI_VQ_IO;
> 
> [Severity: Medium]
> Since vhost_scsi_max_io_vqs is modifiable via sysfs (0644 permissions), could
> the compiler rematerialize nvqs by reloading the global variable from memory
> multiple times in this function?
> 
> Without a READ_ONCE(), the compiler is permitted to reload
> vhost_scsi_max_io_vqs instead of spilling nvqs to the stack across the
> subsequent kmalloc_objs() and kvzalloc_objs() calls. If a concurrent sysfs
> write occurs, the reloaded values can differ.
> 
> Could this cause the array allocation sizes to be smaller than the nvqs
> value used in the subsequent initialization loop, resulting in an
> out-of-bounds access?
> 
> For example, if the compiler decides to reload the variable:
> 
> vs->old_inflight = kmalloc_objs(*vs->old_inflight, nvqs, ...);
> // ...
> vs->vqs = kvzalloc_objs(*vs->vqs, nvqs);
> // ...
> for (i = VHOST_SCSI_VQ_IO; i < nvqs; i++) {
>         svq = &vs->vqs[i];
> 
> Previously, the complex bounds-checking block likely prevented the compiler
> from reloading the variable, but with the check removed, the value is read
> directly. Should READ_ONCE(vhost_scsi_max_io_vqs) be used here?
> 

I can make the change below, either in v2 of PATCH 2/2, or as an additional
follow-up patch, depending on whether the maintainer would prefer a v2:

nvqs = READ_ONCE(vhost_scsi_max_io_vqs) + VHOST_SCSI_VQ_IO;

Thank you very much!

Dongli Zhang


