Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114222EE8
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936992; cv=fail; b=mW+5KkGr1wsYgQmd6Zlh2ztN91kzMzz1iJtxnLKASRYaitNiHid+4SPphoT1rg4TE+7DglU3Du/P0myX48VI3gqfsTv0isBeVCrRDk4asNdNMXjLmoYtfH76snhbfFG1gvzfoo7g5rC8c24aQFGKDz7/LYQQ0RcbIdr/VGfH6pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936992; c=relaxed/simple;
	bh=TudkRLU7W9u+Dt0/IessSJG8ngc7U7fanlaXI1hTE1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qWbnNvw0dY3HK1dsMLXZZv7gVilQkPVCP1L19iAnBWM8XbA/Th5YGuOQroEN/rSv4l9tYkmayBo0qJh7XWfJAtPhHFHbi4iF9KqgbfBPnLu0GdVUHmPpXQNLbKnBRc51bdqcDpwW24lFa65gn3VnbSr+RaxlNh1oDVUs6WV/3zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=F4uC5rHW; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F4uC5rHW"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08F6A40313
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:09:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufihVhjbkLed for <virtualization@lists.linux-foundation.org>;
 Fri, 17 May 2024 09:09:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:260d::700; helo=eur03-dba-obe.outbound.protection.outlook.com; envelope-from=andrey.zhadchenko@virtuozzo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D781D40269
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D781D40269
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=F4uC5rHW
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:260d::700])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D781D40269
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd5cjwn+J2FhM5vSTlPFFJOdpYDaCkz8MidR8Co8LRYGgJAnaJ0O3DcdVqQ4BGUetJzqBKA8RU3sn4Xw7zrjesLvA2j5zvK+rIhWlnPS5fKowuEv2GAU1aI+77nYdoM7hanGawUCQwI/b3SAOpCT4Vv13NqfRztLj26X1jtjLQENwdhg7+Q9Yfk+skr+BrKhhQBmhzabNK05tPR44Ni+NLWfhfcNRdP6NMBDTZDn8EJmtUrL6silVB9+yict65X6LacwObCyWnQ8IqRfFGPok85FuUOUJ36djvYpjFrPowA9RvmcGSL9YTGXwpEQ2fhcr3h/O19Q5AptKUuGVN18fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g5JSjJfPop/UmbfyHYpPyiZm1IMzbU+mie21CCxrDA=;
 b=flTYMUNBq4eLGDeB/qOE3rpIynoA/aPB/fpzfESHlM3c1hv86ILif240Qul2glHo6OdR7jIPpuXxjh5kqCCQAPQh5tNEZS2i0IYhnPm4xJgWHj/sze8ythIBc3ygGJZ7Pv8KytGTGYdlQtTdQkwDI2LQ7t0SlKtPstAF32r6Vb/k/3sSq+kcMBCqqwBOdN24VY73mK4gZ+zyCoZlVblzndzfwPDqbZxSlq2o3DrU2qVVvx+VKhpr9yy/mHvhUl3XY3ub5c+HKKyC6dzJkGaNI4qrq5yv/r0bYLYS7j87RUB53T9m60gC9QFKltDusghLYItfyyjwf2BbJ8mXOz7uFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g5JSjJfPop/UmbfyHYpPyiZm1IMzbU+mie21CCxrDA=;
 b=F4uC5rHWqT1VPu9WnnamJ+WF6Qjq7orqUnpepFDMsev9oA0xLQp85FleUQ61AYhFC7u1lItK8S0t6XimUqUTQ7GrjLhk+Mex5WFpS8aNheRilWkedywNqmrBz+rLhdMN8CXIQL1Q6ToiRrD2WSwjK9AnBnTiBR4oN3ndkKF1TaUMFc0ProJBOlxG1aMXQ823gEcMeLOct/+ToeU9L8LGdsxZ7E7ChahWMFK1tW85Oxlvu7kHhAv56EGWaigYHeFlj1vq/oaDG0sv3uN9htk+GL/t6WWw0ZnjpZ02UMAtbQODU8ShQAQaGr7wHegj8eeWPQ1myRsZMdZqxJ/4de8oUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com (2603:10a6:20b:1d4::16)
 by DBAPR08MB5719.eurprd08.prod.outlook.com (2603:10a6:10:1a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 09:09:45 +0000
Received: from AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::74cd:9e41:6770:ba98]) by AM8PR08MB5732.eurprd08.prod.outlook.com
 ([fe80::74cd:9e41:6770:ba98%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 09:09:45 +0000
Message-ID: <af6817c2-ddee-4e69-9e55-37b0133c1d3b@virtuozzo.com>
Date: Fri, 17 May 2024 11:09:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix Issue: When VirtIO Backend providing VIRTIO_BLK_F_MQ
 feature, The file system of the front-end OS fails to be mounted.
To: Lynch <lynch.wy@gmail.com>, vzdevel <devel@openvz.org>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Konstantin Khorenko <khorenko@virtuozzo.com>
References: <5bc57d8a-88c3-2e8a-65d4-670e69d258af@virtuozzo.com>
 <20240517053451.25693-1-Lynch.wy@gmail.com>
Content-Language: en-US
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
In-Reply-To: <20240517053451.25693-1-Lynch.wy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To AM8PR08MB5732.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d4::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR08MB5732:EE_|DBAPR08MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd710e-26ee-4a82-5e36-08dc7651185c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TURnZDdxTDFjT0pNMnRIaWZzOEgwbXBBSHNmK0djLzlzcCtqUStKTzFYT1No?=
 =?utf-8?B?N2Y3UU5TMnNINmlXZUU0c3pteGxuT0FBdzk4UjJWYTRaRjFDY0xYMC9BVU84?=
 =?utf-8?B?UW9yS2ZRQ0MrYkxqdXVLb01ILys4c1pmYTI4UFdFQ2gySUNVelc2VTQyK3Fn?=
 =?utf-8?B?dmNFMzVzT2VmMWtYRGRTS29DS2RTL05xaUJWaHlKLytmTU1PVDVyYnM4K0Z0?=
 =?utf-8?B?aUtyNVYxNEhIeTFpM0VsalA3ckRLbHJaZmtpL2VETDFha2lWU2x6VjZSQ0Nw?=
 =?utf-8?B?MWp6S0NHaFUwdHRCTFd0T3VWUzVIZCtHTnA0STVlODM0c1VFaVVWNE5CbFFS?=
 =?utf-8?B?SzV2RXJyeDlTYllNTlh6dkc1ZVVEajlpT0NIZkFrc1Q4eUI4emJMS25qVjhq?=
 =?utf-8?B?RGpVVVBjellhbmhiTTdHMExyTE9va2JJQ1U5SjJoWURFTVdRMXd3alJQRFV3?=
 =?utf-8?B?NE9wNUZyV01MeGVrM0ZLVjVjQXo3OEQvUHl6T2lMaTNCazdLUWloL21Wc05k?=
 =?utf-8?B?em01MDlIbUM4cG1teEU3K0hveHRJK01pNSttcGhNOHVXWmFVS3ZlSTVaRzRP?=
 =?utf-8?B?d1ozWnhLWmdQN3JLOFE2TDF1S3BMWTdKZ1ZEVWsydkNaSGxybGcwUDFLY1Nx?=
 =?utf-8?B?QzFIeGUxc0l6UGZmcHNxOTRiUXBaY2xVQVhCNWJtVkkvVUE3UXdDaVhDcHQx?=
 =?utf-8?B?SE1pRTlMTytHc05QNkR1b0RoZGcrMWVQT2Q4Y1I3Mm5vVTJSQ3MvWG13cjFw?=
 =?utf-8?B?RFZjdlhZem9WOVhaV21nemowR3pFWXk4bEgzQ3BuK1dnRHlaZ2lLRzJOUDl4?=
 =?utf-8?B?MHU1SGdWcXVMQnZJMzRZZnNHcEJKMDU0RzlYR3pZdkZDT1RnaGtMUEJKMS94?=
 =?utf-8?B?L2cvVG01amlxSFRtdHNVNzByZWlqeEc4a0lvRkNyV1NTVXRDanRwdTdnakY1?=
 =?utf-8?B?RUZqMDBXTkVOUlA0SjJXdUx0SUNTY1p3ajFHQUJoYW5uU3hUL0lJT2VBZThJ?=
 =?utf-8?B?cUdSYUo2VDk1TWRnYUJjWXVoOGhuSGpTZkNRemFyMi91Y0ZlTCt4a2dwWHVF?=
 =?utf-8?B?bksxMklZR3Z4S2dFK0hXb1pEblJ2TFF2M3pJSTllYU9jVWF2RnhYcS9WN0JG?=
 =?utf-8?B?R1RSN01iQVJMMUJKbkFQdTNCT1dTcmdzSVNxa1VkOGxpMmtPdjQ2K2FBOWhD?=
 =?utf-8?B?NkFOanhKa0lrRDBYb0FsOWhKN2tVN1VCMmFUdWtLelhCZ21Pejl5TnJXY3Rl?=
 =?utf-8?B?d2Q4YTNqLzBWQnJkZTAwRmc1a1paa0JVTFNQRDRIVzZJY2VIRi93MWRneDdP?=
 =?utf-8?B?blVYRFZvdHA0Z25pY09lUUxTS29mb0x6TUZCOGhBQjBvdllZSk9aaGovMXE4?=
 =?utf-8?B?Ymhyb0VFRmpHUGUzYUd6MkNIaGoxTDdiV2FFVkhxalRETkVFS2NXMUVmeW5K?=
 =?utf-8?B?QnRneC81N1p2V0toRVFWOWZ1eVNUQmdDTkZXQWNHb1ZhRXdoVjJUNTBxQUw3?=
 =?utf-8?B?MUJIaUtVci9uRUFmWGRNYnhtOXIzcUIzaGoxRDhFS3RGbUlCcXJFeGZrcktt?=
 =?utf-8?B?UjdnSi9JenVIV1BDRE42N1lzdmlNek82RlhXSGpsQW9UeU1XNXBNL214a1Zt?=
 =?utf-8?B?Um5aYzJpeVh5TVZqMzc2QzRYRXdZdUZtbFUwNDVCanV0V1lGOXdUTXdKR0Ji?=
 =?utf-8?B?UU95NGtVZXVQQnY1aW5YZlM5eXc2VU95cldzREtOdUxUMFNkaWhwSlFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5732.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajRUeXBUbVg3a1lNdG1rZERsOFBqd29uU01DMlh3OWFROTZIN0VFZHBRTW1v?=
 =?utf-8?B?NlFLc2xwNnZ5QWhHeVE4VEYyU1RoT01uQ1ZMS0I3cG5NSGMwckFWUFNHUHU1?=
 =?utf-8?B?ZjR2amxQcFRaSTVGOWlBQ1d1bEIzbExudlRPbXdCTGRJd0pXSGhVRmxlWndH?=
 =?utf-8?B?M1NHTENSSXZaeW5sQitqUUwwNnRJa1g5eERUTFZIR21nblRoa09ib3BtWWt5?=
 =?utf-8?B?WUI3UGh3eGJoQnZVZ2lYTnRUM05NNTg0dXRhRnB5L0hTRWMyc2wreDMyV2FD?=
 =?utf-8?B?UXhYNHo3alBpTEdZbEVPZWpBUVlBTHczR05ZdU41VWtvMW5DOXh6cW5XVFpV?=
 =?utf-8?B?dzZrUXpsWHc2N3d2UVVMaExKeVJ2S2FPeTlxeEhYVGk3ck12ZGNLQXBNcmJ2?=
 =?utf-8?B?bGZzSkhHdnVNZFd0MC9IVDk3UnlMVGthdjFHTEdUc3JzQ3V5SmNVS1d2Rjcr?=
 =?utf-8?B?RjRuTE5yMnFJV0ZTS0pwenVVWUVZeWRjNmNSQUJkVEZuWkNOalFBYngyT0pC?=
 =?utf-8?B?a0hkUDRNQVlHa3VuMXk1dS9JQVNobkpIaEtuNUU4M0xUWEJlcFRsdEJaRzdt?=
 =?utf-8?B?dU9HQnNMVlREK3R4R0dsdXB2VlZ3dDhCNkcvRE1GWVY1OUF1ejg5cWIwOUZS?=
 =?utf-8?B?MXVRVWJpVSs5ZzdaQzhiSDhpS3l2YndYRi9YbEJ1aTdPYlRid2czSHltMld2?=
 =?utf-8?B?c1F4KytIVWlKbkhWT2V2R3ozUEt4TTVORHJCMWw1WXJQMXBXZnEzWmlZN1hS?=
 =?utf-8?B?a2VUVXlYSDhkQTRZWWNtQVhlblFQdmxEWE8xSkdXd3R6WFlvNXFIUFl1RUxB?=
 =?utf-8?B?Y2p1WDgxUVRLMnFJbUthdTgwMDJleXRmSndqMXJjbGR6ZFh3dUdydnFkWVdW?=
 =?utf-8?B?eUQ4UzNBMU1wODNKWDFMOEQ2em85UlgxZS9TUmc0WU1QK3ZYeWRqaDBpZ0ND?=
 =?utf-8?B?Qlh6dG1EeitBL0NLcGRmY01jVXo0Q0YrS0VhdGRtWUkySGtibFZXVU5HaWEy?=
 =?utf-8?B?NjlUMmNpb0Zqc0t2WXR0ME94ckRweUpHZU1pRFJ1SnNsZjgvSkJSYWJZclpj?=
 =?utf-8?B?ZTl0ZVAvMWlmOXVmd0Q4dGg5Nk1FajJlc0NjOUpUSlRldk9VSGRzdHoxTUdC?=
 =?utf-8?B?WGdoV3BJU3gra3V3alBDR00zY3QzSUE3eGticUdPVFl3K2dZUHhlZVZQTDNr?=
 =?utf-8?B?MmhGMkpLSXg5ZmlBYjM5N0liWGhabXJFbG5WVXlTU3d1OGUxQWlnMmg1YWpK?=
 =?utf-8?B?MDZuYmNDQ2ZrdVVVcnJibjNPRU5JcFRQaVlSRUptajlPajNMekxvRklQQ1RV?=
 =?utf-8?B?R2R1Tm1Lbityd25IanhaWmFnL2VEZjRXU0kwVTVpQVZjYVFPdGhGT0M1byts?=
 =?utf-8?B?N0F1RE1DVU5tVXZ0VHlpYmwxamtNSS9ZRGsySUh6OGVHZVJ5NndaNG94SGoy?=
 =?utf-8?B?U0h6cERHMXRmSWNHODVlb2F3Q0RLR0gvUGdiNlgwM0xyUzBDcHRkL0lyNGRB?=
 =?utf-8?B?VU82cS9UVVpQOTkwTWNiR1F4a3JHRUxValViMkVobHlRNmFTNWpJeE16T1pN?=
 =?utf-8?B?UVJoRnQ2dStkUVZtLzdDVjh6SEorRFJpSk9lcnc3NEMxZEZLQUFsb3lZeEJr?=
 =?utf-8?B?ejVaODZGbmg1QUQ2Ri9nU2xGOGs4b3RpTmN1Vm1NbjFxR1BoMGJSd2EzM3VQ?=
 =?utf-8?B?aG5hMTVzZ01NZkJkS3A2Y1duL1lkV0ZqcHRUY0IrL09tVnZ6MUcvakNwWExC?=
 =?utf-8?B?NE1ZWmxpQ0ZsVUVqQUxxOTdqYUhLR2lTdkZHcEw3VnZGYmRlUndlTjQ0THBM?=
 =?utf-8?B?dCtEZGxnUUlnNkJtNUVuUVRkdDJTaldKN2pXN3hoZVFqTzVIaDVrVUY3VG5v?=
 =?utf-8?B?SkpKN09mUWp2WmpVai9HN3Q2ZTVkcjkzL2YyNTU2VTB1M3VMSHVMeCtVTTZN?=
 =?utf-8?B?a3p1bTBCQ0lXckxlckZ2eXJYUkNEcm1kS0NUSzR6VTlFKzNuNEpaejByMkFH?=
 =?utf-8?B?RGp2aWxZNEM2YXllVEFYRmtvRnJvZFg0WUpEM0lBMXdGaCtuRzhhMC9VWGlQ?=
 =?utf-8?B?Z0JDYS9rZXFVcXlsaENoQ0xhcVJ1Y3NFOWlFTkV0dnNQS2NzTmlTcHhndzVC?=
 =?utf-8?B?ZDdIQmxJcU5halFrcXdLWmM5MnZwREQyaVEwbXF6Q2d4elV2aFNPSS8yOWZn?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd710e-26ee-4a82-5e36-08dc7651185c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR08MB5732.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 09:09:45.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edCUDgtuA0v7UHPHrmDyJxn8gSCE4wJipd+nHtTQV6cKaCMxiRLadLL4iRtkFFnIRj/aORhmfg/jBVdtLFuiG5dJwRsFnSZL16iLwNrnyMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5719

Hi

Thank you for the patch.
vhost-blk didn't spark enough interest to be reviewed and merged into 
the upstream and the code is not present here.
I have forwarded your patch to relevant openvz kernel mailing list.

On 5/17/24 07:34, Lynch wrote:
> ---
>   drivers/vhost/blk.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/blk.c b/drivers/vhost/blk.c
> index 44fbf253e773..0e946d9dfc33 100644
> --- a/drivers/vhost/blk.c
> +++ b/drivers/vhost/blk.c
> @@ -251,6 +251,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
>   	struct page **pages, *page;
>   	struct bio *bio = NULL;
>   	int bio_nr = 0;
> +	sector_t sector_tmp;
>   
>   	if (unlikely(req->bi_opf == REQ_OP_FLUSH))
>   		return vhost_blk_bio_make_simple(req, bdev);
> @@ -270,6 +271,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
>   		req->bio = req->inline_bio;
>   	}
>   
> +	sector_tmp = req->sector;
>   	req->iov_nr = 0;
>   	for (i = 0; i < iov_nr; i++) {
>   		int pages_nr = iov_num_pages(&iov[i]);
> @@ -302,7 +304,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
>   				bio = bio_alloc(GFP_KERNEL, pages_nr_total);
>   				if (!bio)
>   					goto fail;
> -				bio->bi_iter.bi_sector  = req->sector;
> +				bio->bi_iter.bi_sector  = sector_tmp;
>   				bio_set_dev(bio, bdev);
>   				bio->bi_private = req;
>   				bio->bi_end_io  = vhost_blk_req_done;
> @@ -314,7 +316,7 @@ static int vhost_blk_bio_make(struct vhost_blk_req *req,
>   			iov_len		-= len;
>   
>   			pos = (iov_base & VHOST_BLK_SECTOR_MASK) + iov_len;
> -			req->sector += pos >> VHOST_BLK_SECTOR_BITS;
> +			sector_tmp += pos >> VHOST_BLK_SECTOR_BITS;
>   		}
>   
>   		pages += pages_nr;
