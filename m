Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED13A1CEA
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419541; cv=fail; b=rPZa8WqtZyQ25XaklZC+7QssFpmVGBWgJlEZXrL8o+vvvB0YqkDR7z0QIspzHiYqrJYCF6ErxgxTuhAl68Hl4dgqZrGzZcxbgef1JmpbjhyUHmcqIhFRsX2toHiNtLIGBJAFbtHm0MsrL4hrR1lIpfKJTW+k780GDKhO/CBbWzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419541; c=relaxed/simple;
	bh=SkvvAyx8ajoSeId7SuneO5u1LiZ7vP5hssOM3UA28a0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsMDHNPoIaEaqRKzfOKw3nOPVvXnP1o4A0PD86p4iKZVnuuZWTxoBOQ2L6Cj9gzy/LBCrhpfMURzTU/WSobMDtdVOk3iRRCwkZk6Uo+G5ECxx0wijWp2F9YFWgR+qoSSVh5CLbUgKX5vjUjc/KYvG/jhegFVmYa1I+48eCE8EUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NlSEf7oj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v3dkt5yd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NlSEf7oj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v3dkt5yd"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EKMksO2205501;
	Mon, 14 Sep 2026 20:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oul+365kcJYZxU1FslGufaeaxRQl2Da66TBhNOT5Yb8=; b=
	NlSEf7ojIE7C8g96WvxqaICOtNbMipF3PmInz4YHR1QAIOKQYEXhcWiU4UjiDlGg
	6wkzQATflMnHhoFSByyjKxhSTh7itdram0yG4jn82RP3A5cuFv6K1flSakliYm3E
	FMo8p2szRwVJus5ITx2mjCK5xZrar0zUGFNEaBJuKvBqcZWpZKv6uQX5nkOBpmZT
	vXR09wdpVvWiMwDZPu3BBqOSVDaoHmtZBKXwoKJvWof5WtcwnLhy2uWMBpOwPHay
	6nYfRS48qUB7ywKxq/57PlBUX5PoG6fCMRkcTCwkPxeXeiNfDbKEDj2I3/6bFmA7
	JzuhyqFi+lqDcwdctb5W6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmw5b2n5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 20:58:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68EKt3XP032475;
	Mon, 14 Sep 2026 20:58:56 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6b8bcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Sep 2026 20:58:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys4zJ9wrrGU95tyhY8SSrgwJdCjv252yBx53t+ew0LOOI0KQ9wTFgctdIezxgqm+/8Pp/vLeg9yXik+wInUTdWR5zsQMiORDSH1Iw/WiPUt62VwWlUh4FcctjDXU3v/iMs0AAMXpEs7LXgz6cw/OSybbOgzowXZ/7LmzA7X0ShsykvmAD9cEW5eY9cJV8EAVLZ/OwfbluTVZwi8luX1uSSimvc86UvSem56rMquTTqk1KJQ8N4dXJD8iXNlK7aUn2V2cPT2Y9TbvR1n3Db+akHPuRU0gcDGdiPiRTD1wHZB974k0iFaT2TEKBGTLtGKHuTmmDs0Sx0CuCOfGCqBV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oul+365kcJYZxU1FslGufaeaxRQl2Da66TBhNOT5Yb8=;
 b=olRstS8V1RswkknfMqGLM6aBVk2NbW5FFD5s7JxPS+m2yFJ+Z2RREKI9VacDGNg4uqF3yb3nBen4Gz8oKbJyawyhW0KXK0MBM8XmZc7Q948uL6+gp3IzN+xq2Y5PSNTXdHgrP//DIkSAuldbmT9Ys0hAlbO2zZpVkvihcMa678BR1e+/WOIMLoOCNyf9qs4Bhj1zpL4dyn4DtBDwUwPNVdIn+C5W1ywRWSSZEmhehwylge3JTjH1zAAjUjALCoA4h8Y6vvmDk036w4lvVIs8gIxXcrbFF3CoZg+e0FQm59WSE3vTWlzMTjxX3JUm00xvHLHUmx4XNVHFL9dpD8p6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oul+365kcJYZxU1FslGufaeaxRQl2Da66TBhNOT5Yb8=;
 b=v3dkt5yd+w1KgOJM25/lFoVHX0g4nzKgi9bJ1MpdnpMH4sduzwpKYh4aR+Cmn3+QrP2RZJ1GtfuT/dgpabiYZD9zJBrrvZoxR5rrBwe9X5jQE9VDsfoNFRIQP8j0EL7SAssMOalvuOlFbnEKfSjEL3/EvmxIcVQes3SBRrJmN2c=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by DS0PR10MB7320.namprd10.prod.outlook.com
 (2603:10b6:8:fe::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 20:58:48 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 20:58:47 +0000
Message-ID: <d8371b56-3d75-401b-99ed-746930315af1@oracle.com>
Date: Mon, 14 Sep 2026 15:58:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: do not relock event vq mutex on send_evt
 fallback
To: Jia Jia <physicalmtea@gmail.com>, mst@redhat.com, jasowangio@gmail.com,
        pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260912090420.47439-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260912090420.47439-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::26) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9a9a59-d969-4ec7-4fcb-08df12a2f8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|56012099006|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	H2/PCb2dbs6QAWeSMrByIgtoV4Fi2NjKnFLl7y+6OVssG0u5260deIwcRK1u2n7GJwdqFdDeyAim99DiRZkChYUWOJGANaW5t6oHZzCCQ4bHtNl4Jvr8zAKHNM6eU4lKIsWzytdwpxbGH320WiSfSDCJn+l7hA8WeKZ6z4yfqX8weCDCUAH9kLvbp9OQ1sWhgxsF6ydr0p2CW/fzSMpC7bN5Vc6HHJcSTZxTJU81PZ/R+OZpXLbT1Sld6HwwKrtFC0WKPmpSOgaF81i8DlNEGjb7bg2aJGNR66h97QI+mCZ7eBo2tK3ePCPjn4AmCZD/IJVov6YW9q1s4agnAuaCVmtPTH+CSwSsfU9ODQnUkcNiPSV4lvj47Y5CQIPrYV18H0QEtCk0ELRZtAwZSl3ALkzyj+x8qSoTTXo9xXS+GYsMth0Sru/trQDKi1G1iiIBOGTHJ3qY4yXW7f00TLypSPvfsEW5L8IFAPlXoU86Lk6O/iIwzZDm8mqYjpMej3pIDJ+I1YowQGfWkQ/MWFuXLhrwC4Sj3D3YntT9/R+eqBqyvdS8J2yz4q1RXP9eZYixiZ0Vk7w1bof2zD0JVkxPDfPE/zV65X7nEoKhQvSMLoMji791qG/qYvSBsWOj3NaP/U1EZGOR5yK8Nv+AWM3tKQAhlT880YKmfDiw1uO0+rE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1d3SHFTVlY5R2d6SVV2UXMvOEZDSXk5UmJ6dUdERGhZUDJuNmo3RmZHOW0x?=
 =?utf-8?B?ZXRJbmhpWHNHQnhTbDVhMitXMERCQThNeHJBdkJQTFVxS0ljUm01WXI1eXVp?=
 =?utf-8?B?a0FLY3lOaFlVU2xoTnlMZmpkZ0Iyam9mUlpzYVRmS1JJWWZtbVVyTkFybC8x?=
 =?utf-8?B?SEdBOVhTUEs2a05rU3BHVHFBY09UQkZoVC9OZ0M1enhxekdtenNxcEt0LzNK?=
 =?utf-8?B?Zjd5ZFVWMFpLdThQemgvaVowWGlhelUvbnlqV1ZIRWRsd3NxNHlRUmdqOGVi?=
 =?utf-8?B?eEVERUdtaXV1MlZwQ0N3T3hnaW5qV1ZnTTVnNDFrZjRuS0JseGk5WG4ranoz?=
 =?utf-8?B?UUM0QlZvSFBJRHFQanJXQXQ0QW9YcGRTNDg5OGxZOTJHUmJDYzdVVFR3OUI2?=
 =?utf-8?B?bk8zVFQvYzF2TFF0VmI4aCtEWHNBcXlyUzk3SWtUejBKOGVHR2NSYkZETkNn?=
 =?utf-8?B?UHNDRGtkRjVJVzlMbVNtVk1tM3duWjAzOUJiV1BCb3lnc09iTmprcmdOWEJr?=
 =?utf-8?B?ZzhxRXIvNVpQQWV5ZytNbjVZWEt4MFlQZS85ekRuRXFJTjVVWXJXbW1EOHBR?=
 =?utf-8?B?bjVMYWJTWXdrNkN3TytmVkMxUnN6QVFuY1lUeGZZc1R3cWNockhXSTM4VmFE?=
 =?utf-8?B?N2lpQ29KUG1ra0orRzY3NWNxM1Jtb1ZBVjZlTlVQZkZzeitLRU5qM1JDVlli?=
 =?utf-8?B?WXljNkNaMmNTZ3dvUDhTSXUyVlRCMGF6bWZoa3hUVDFNSnd3RzE0bVozMjJr?=
 =?utf-8?B?enFoVjdIQTVyK3Qyd3ZWN09WSFhRcTJrRGkrbFc0VGM4MnVCZzJwWTI3TU5m?=
 =?utf-8?B?bzZnZUI1NVBKRll4b0RRTmF4VVdPU0hXVS9pK3UwQmVrMDZST2V6SnRPT3lr?=
 =?utf-8?B?cUFYcHJ2aFBqa2xXaGdheGVMTVFLanV3SVcyekt1eTVmb3RhV3BSUVRGcUlV?=
 =?utf-8?B?NllhR0hTM0dnWHZ6bVc4eWZyQytQZ09ldWhQNkJnME9KWWVXVnZzSWtyc203?=
 =?utf-8?B?NE9aZDlPc09FTXpYSUxORkxTSi95U2RoL3pXazlzdWU3K3lvOGNySGlLb1h3?=
 =?utf-8?B?WjMydHBhQ1NhSEphRVZ5bkZPRTIxRkgydGs5Z2RIL0wvUDZmcS9MbC9Kblkw?=
 =?utf-8?B?UkhDMzd6amhVNERoTVNOc3V1OHV2RFpXV0FDTzlLU1czYXRQaHh4Z3BnM1lt?=
 =?utf-8?B?SmJrN09vUVdwaUtNMi83STJMeFpobUtjMFlrck9kdGhPeks2WnE1bkpmU3RL?=
 =?utf-8?B?ZVlTUkk2RjVmRmZ5dkhxdG9wOTRxRWh6aDFqazZmVC9BelVtMnlPUHpiaDJn?=
 =?utf-8?B?SHVQM1ZNdy8raFhvSGJWQ1YxQk5VK240Y0lMNVBCNWJvd2YvQTNHMWdpaGVh?=
 =?utf-8?B?c25id0E5QzR6dzN5cVdzSk9obEFLWkpHR2RGUCtvMlEwbWNjMHdlekI1aWNV?=
 =?utf-8?B?YUxkeUt2RHUvVzhMQVlZblA3Ukhrak8xeXpVTjVPZHljSUhDWEdMMEQrb0lh?=
 =?utf-8?B?V0NyMXlHcWN0c0ErdnlxZnlhNHBPR1l2dDRITzRHVERUVGhVRGg4TFFWd3RW?=
 =?utf-8?B?MWViL2VrQnoxcHNLTFdFbDk3SG5ZV0hmYXRVb1E2N2RXTFArMW5HaWx1aERX?=
 =?utf-8?B?ZEJaaVIveVdCeU5QWmR6NU1JNEFpc3hSYW9hb0pRUU8rbG0zNi9RUFkyeFBK?=
 =?utf-8?B?eDZRMm5oc0c0eUhTS0R4K01HQ0Z3aURUTThpUlVwejN2UlFPSkY1aFplcnYy?=
 =?utf-8?B?N042aFdMWjdzNlRZQ2ZiRlBiY29mV2F2cEplZmJrL2w5bWhyTm9pTGZYTGtC?=
 =?utf-8?B?clFKVGF1eXAyTVpRRGxtZVFrRm82d1hLRnRseE5mRzMraWFQZzdZUjduNjdL?=
 =?utf-8?B?U3NLR2JPd01PY3RkbFFaM2xRZiswNzdxaXgwZlFyeGpXcldwTU8rVGg4SHFD?=
 =?utf-8?B?VE45SWFITEh4YnAzNDQ0aEJ0OTBTM3FWblc1bjdtRkhRTWNtdE84MVFRNXV6?=
 =?utf-8?B?K2YvdkthNHBqNnU5enMwbW92UE1OYnRTMzIycHp6OURoOVVPazJNd1VybUhu?=
 =?utf-8?B?K1dvMG1wMjdTUVBNSHRMQ0pWemFhYzNDM2Q3S1d3M0ozbzRQb1Bnb1BacjBV?=
 =?utf-8?B?ZFByMk9US0kyYmhPeGk3REJacU9ZZG16TG1lQUlITUhQNjZYbUJuS3RocXpL?=
 =?utf-8?B?NDBqY1RTWnJxZjVodThNVTU3SmtLNm1GWkM3eFpMVlE1alM4K3JmcFFOdTh2?=
 =?utf-8?B?ako3UXNoSFFlMm9IUzdFMWdmamZtWUhIQUVPbVJBc0FFaEJkRE9wdmwrck8z?=
 =?utf-8?B?L2g5amx0ZjBQNDQvMHRKT3hnUXlXMXhQSnhpcGYwL3c3MllyVlhDY2hHOVFW?=
 =?utf-8?Q?wrNyXP78CgHxW6to=3D?=
X-Exchange-RoutingPolicyChecked:
	UBttZ9joqJg1nJPES08KhwXcGmgWB107mbLHnRTHUOtKfrfQvWtRwKAXIc0lwo0BT8LVsn9w8FbzishfcPbQFueFnFRG2lM/ngChWvgk0pKTjfZabBnh5bX8NjpgVRTZF7LMs39qO2yFbR/TItzwfC0QlSVazhhBkznesNzRIQmUhCX4UJt/rqo0BiTgUeFzr18R7k4y0hUclf7/pspMH/gwt+xW5+FZx/eh1brr0WdpyFoIiyIXvcy1WVWeaLvSusNm6Sg/07jUlJLxi8isgO1wsYQjIOrshGpVyP66mglRKSGEAnmBOK/EsS9oYxuZI5WqJ8lyF0sOS35WpLHb2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LfKwn+923uaw2DF4DpflgchPC58Af5qJTKG8QXYmpaYQ21Nr1wLqRp61hC46tDIc9WzGm0qAAhlErdl+7CPu9RtlkunFXbjDdto1dZDR0bq5ssnnBARpc3zZzwafPHmlc6DsPPzGWggYpfJc6Z6YUHLCqmgGPvFKV/TkkVY+MEK15kVMTUu33Hdk6nY+mbOHYYU9JNT2kRGVsSAtbAz+YH/5zOLUaEeFFMRwnuMQrugTeDeXvA7SG4mYNaf4dxeyu6W8xiztr5Co8F5Imw6JfGURit4iFQEuJXMRClFXFYeCxUtTT3Zleq9IOu8mqVmplGqAvfrQL3uZOOpx4JFUiRBYhgkwFpPG6bia7GyNfFIvyZBK1s1G/PZ72aFy1eRyfEEKxkdaQB0cXN0pPqij4wmB8AdO76sXBSY0Fja/ycuNZdn6LI7gs8mBvczrFbl4RrDGfgqvnyfpViMTpI1KN809C2Te4YE0iY2aa1eqmqIANXEg8p1EvUISJCG2YdQSSHs9TdvSzlq026lVQhjsH0pjKwSzfaFisGLgyqRuNyB5mXj2uXEzedsTzNve5b4Vbo4SMoVioPsf2bUzvtIOmJcWnumaEM8yMYDpsIJq9qk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a9a59-d969-4ec7-4fcb-08df12a2f8bd
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 20:58:47.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slIzn1kwrNTlKNB9HcaNeRwtP4hqd+O56weE03sdq54fhKQj8IOvW7JUxmX9paCb4JvZlDz3zF5w11NSWXUjSNeMjKEhit6UFWeU68/rhko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609140299
X-Proofpoint-ORIG-GUID: -aG0NydtTTRStb3wolX6n5UglO2M0OCm
X-Authority-Analysis: v=2.4 cv=Ev9HPicA c=1 sm=1 tr=0 ts=6aa86012 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=7qycZ-XRql20Q87yfDkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwMCBTYWx0ZWRfX9DAdOwRQw3ha
 2kzmf4LDkNEf4kHVSfFv4E+LcrZvD7AiOCvmwZetowiJMeKD7zoKgx/nj5GTtlwLIvXPPyiTzdp
 tl6uDVyS3iADnCOPuuxcqds6IP4LaljOgAnlUQsHtirtj5/Bv2dg
X-Proofpoint-GUID: -aG0NydtTTRStb3wolX6n5UglO2M0OCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwMCBTYWx0ZWRfXyM2ri3JgqLU0
 jwekxkRR9arM9lNuclP/CzRV1NsasNfrKb0LrqMxf4VOxjZ0upQOJ2eEfWH65BQJiYDNb/At+SO
 hTgcFuGSBpwtSsEp3KHFFpSzZ4hJLgkFDQuRPyGjHXUAaQkat9VR3B20ESD14oAoIeJSuhBCZIZ
 Xw0VUo3holU6jOtAeGMx5xr5Xj6nmVFM+c293gJlIHekhoQQ62yLHY8Femf0L86VZLkvm0UQMs4
 et/1ke62e0BvnId9OkYMMxDWvh5cD0soq/YjhqwoDkltJGSRNFMasdB2Mafnlv6ZcRYMNIvcDbq
 iK42Om1JHg/ZIVWnwbyjHi9m0abfW2/wz751KWMZPREE+Tc5AOyyX+6gsv3OQ046CJOHMw4+j2Q
 55H77cgysysF0O/avTGsc1jzyt+UQts04CC6n8LBXEWm0RhP0DXB214LOpQdnQ0tfXGTcY0PbHs
 IiPUdfHv51tograObGw==

On 9/12/26 4:04 AM, Jia Jia wrote:
> vhost_scsi_send_evt() is called with the event virtqueue mutex held.
> If the worker is gone, the fallback currently calls
> vhost_scsi_complete_events(), which tries to acquire the same mutex again
> and deadlocks the caller.
> 
> Split event completion into a helper for callers that already hold the
> mutex and a locking wrapper for the event worker. Use the helper on the
> fallback path.
> 
> Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel.org/
> Fixes: b1b2ce58ed23 ("vhost-scsi: Handle vhost_vq_work_queue failures for events")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> Sashiko AI flagged this while reviewing
> the vhost-scsi event queue fix.
> This is a pre-existing self-deadlock. It was reproduced in a follow-up test.
> 
> Trigger: vq->worker == NULL. vhost_vq_work_queue() then returns false,
> and a subsequent vhost_scsi_do_plug() call deadlocks. I do not know what
> normal condition gets us here; the normal vhost-scsi worker detach/reset
> paths do not reach this code. The only reproduction I could come up with
> was killing the vhost-scsi worker. This still looks like a low-probability
> condition.

Reviewed-by: Mike Christie <michael.christie@oracle.com>
