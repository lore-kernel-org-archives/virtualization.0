Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055518EA84
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053781; cv=fail; b=MqX+AvHAXg+IFymjaH4mMo4MoOzCT2O3/uWFyFSD6c9k5HR4Uv1V231P+H6WqoAR4FDszOVP95FX0Tsk2xg9O6+cAr+MeV1do+kB3yQtfpV70senEkeTpvJDoou/lDUzbBjTk0YJMhh0NBhikVY/uK/dkhNc1XMOe5MIdaNl994=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053781; c=relaxed/simple;
	bh=Wvh5RwMR4Q41b+TJgzvLppzzVg/J/dqNsPkLRinI9FM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHD8zoqG/S8kZpkObZvf+7c/+JAenLC5B02eN2hBUq873ka1VUnymvDOYEuFmJjd+nIbepV94F8vtbjAvwndteCUH4rut2/l71rmcbQXfeFv7qszY5BEPVuSkROcVZoXMWI1PuRxsLwlpyObt//nQrmbH1YoJefFx5zNgDXc8iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbUp6qSw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h42l2kPH; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbUp6qSw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h42l2kPH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1B4840608
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIgZDNNargKf for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 14:29:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 32A53400D8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32A53400D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=JbUp6qSw;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=h42l2kPH
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32A53400D8
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:29:37 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENdi6002335;
	Mon, 15 Jul 2024 14:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=XYiRB5+WTeiHSbzrOZtZ/9128hlHXJPhUY9ycDAY2kQ=; b=
	JbUp6qSwnRkpC+n3go1PlsGZ6rezn11YaYpkti3dIusDa6nyKM5D9TS9CombGFer
	pGYDvApFC7WpLUX2QdYA796OaAqzGWrBzfnSVtzlmhsOW9N0gXIYP1hFX4uvHqOQ
	J/jJp1Zsl1X3XV33oLPxwe3NlX5q7lTkTSyUWKPgBBOCgS98dtO4PfLz0AfvEOch
	bW+czX/DMw89SebXhntQwFzAdSqFIZr+EPhh0S1MgOBdUqpKwP1y7KUq2aRh95lx
	Y736TOnPpYGPlTTjPYnVlbhwnk9U234kFriYzQIIs9h96W2cVjOzI+MPMdqnyWz6
	jPpAx0vUC2tlxcdn06wyLw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg0ckk3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:29:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDQDs9002694;
	Mon, 15 Jul 2024 14:29:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg1dsshc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p05wxSZjKYSYcehbWFEX1SnqwD+kF2mma+rCddLwbSS/xLotlcPItTszEKkM28mdVtTIS6dR7x3gzn3I7gPbVFT/qsGu9dcOreuSpZ364Sd/Dy/yzWYHzH5/FjTQWXUaHeGP3EwjEGWYuNKUmsCDmPBWBOlPI4rKr8vMoWjtYooBNvPRg6t4WGZizJ2jEtRNIaxPE+eO1f3cu9Qj34jjJDhFuoOW24odD1wTTzCE7C/LG5zw3MBlAbG6pp04saG6K2oTnxf49JF6s3beE0vI8BvasgGk19G5H7RNc0zxNlrR5yxfNrszdlPwngeHCwxKEdosIMEXfeA+uU5VodleeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYiRB5+WTeiHSbzrOZtZ/9128hlHXJPhUY9ycDAY2kQ=;
 b=BtGDrWXs67oqQJmZSajnoE7NnYz2XKqHoxtfIKGoMKUId3mJxlaW0o3tK/rEtcxVs9VN4UnOAj1gUzUyjVa9vk/hHaZ6zPKXs2YPyLqjnG23bdimBDFanLhDERYgmV8YsKa5YTaUoiETBCDjsQOYiqP7eb5u8TS6Prs48qDztVuxx6INJbPwrVMKgX+pjKSJ6k3OZn0NBrT9HFbJa/HcMtLbNcbT9dOfEUHmies0RWihwZdD4EH4pr3q6EqXdpzc7qLqA8kLF+NI3YAa8XNh/+p7/y4M5dv81iF3Bl9DgJZddzKoIt8UkaIlHdZXbrpZiYZaeJUeqvZN1mbg9JMTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYiRB5+WTeiHSbzrOZtZ/9128hlHXJPhUY9ycDAY2kQ=;
 b=h42l2kPHlCBjhBfJ8AN4OrXOurQ5mGSXJj3BmI5T4udk7+JVqvOGhfWV4ZG3HuUZzlwtHG0sZZLcGeq88sLj8LixxjdYb6byJhYxvOg+P8PFzeJCg/VChgVPju8LMMrckbzsyRKafgPDHNFrIfLx5i/0cqBsLj4sAdC4QqpNc/Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:29:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:29:28 +0000
Message-ID: <d414f28e-8887-418f-963a-bb986dbdcaea@oracle.com>
Date: Mon, 15 Jul 2024 10:29:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <20240715050637-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240715050637-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: eb91db67-8eb2-4ae2-f183-08dca4da888f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z2pyTkNPYXpFeG5RWElOVExsTHc3dEI3ejJlNDIzMU85eGZzTG5TWTcvME8w?=
 =?utf-8?B?aXoyb2JldmNHQ3R5WUQ5UVlyY0NMeFJ0MXk2OWVxUFdPYzFBblQ0NzFheGFy?=
 =?utf-8?B?azJUaXhTZkFYeTBJYnl1aUNNOXpkajMvWHVzTE9NWW1PRksyckpHR2NsVk5t?=
 =?utf-8?B?NHYweCs3eXhFeWNSMGdsRG1lR0N3TWk0MnRNOTVKTjJNWnlqdkZsbnVUa0Zs?=
 =?utf-8?B?N0JCSlByU0tQcWJ0YkZtYUNBUnFISW52Zjd0Q2owbFF0ZW9Za0Vqb24renY4?=
 =?utf-8?B?WjlFaTV1Wk4vR3A5LzVrelhqeGduSnlyejFDcE1IbFJJUlgxcGhjcE1GRUNE?=
 =?utf-8?B?K2tnMGw0TnNLZ1JNWFh5ZUF6ZzRXZ3JOWFNvOHowNWtyU0VyN3k2U0JSaTF4?=
 =?utf-8?B?SHpORWZlK21RSnBmdjJvSGRqNjdMMWo1cEU2RE5RZkowWVFQM3NEWW12cXp4?=
 =?utf-8?B?cjlGaEJGWU1aQmo1Y1NrZnEyMFUxU0lpWllhNHovNEIvNEZtUGpKSXdRUHpW?=
 =?utf-8?B?MEhueGdxREFiWUJrNEVxa1FPdmRWK1JuOGNXbDJJRTVSeUZoT3BsaEFVeDNn?=
 =?utf-8?B?WmZFZTZ1TWhySDk5UEEzTUxBWENkaTE0cUk5NDVpZ0JRaUdYVDlLUVNjSXJS?=
 =?utf-8?B?UTRHbnRwakFkZmtWaHFxNCsxVndOL0dFY05GanRBRGtJRzdHYy91VnVNaXpz?=
 =?utf-8?B?OVp0ckZuUzFWRXRkS0VtQi9lc1B6SFNGdExKME80YjdyWHFmbjF6cEcrck42?=
 =?utf-8?B?WHdiQ21KMzFoU2tmZm8yU0NwdEY3dVU2Rm5icHplMi9SOXg3bFRic3Ayak9w?=
 =?utf-8?B?NG1ITTgrTythRjM2OHRacWVHNk1wZGtydVJHQ1loT0xjdU8way9QNnFsQXBM?=
 =?utf-8?B?ZGpCbDNVeVVDSTI0V1Z0djViN1pvU1poRFRGd2hEeDBGLzBFNkd6TUMvZEtG?=
 =?utf-8?B?OFhWc3hzZWtqRWVtczg2SzB1Wit4QTlvMS9yYW5jWGJOVTRzZHc3SHVXZFFp?=
 =?utf-8?B?MGRPZ3BRWURIcFNiTitkTzcxbEJKd2dJQ1VtVGhOWU52Q3V6blJaK2FCTk9S?=
 =?utf-8?B?RGZCZlBFVERjcmNYb2w3VnVBa1JzTDdobzE3Ym9Na2NlUDNQRVRJYlJiYlp3?=
 =?utf-8?B?bkl1eWdJWWhSR1lHcjNmVFZCam12RjZKVWk1L3prTW9VU1dFNUJpM25UVEJY?=
 =?utf-8?B?dEJRQTFFbEZkV3l6UStMTDhKYkJOcUdiNFp0NVpNaGN5d3V6STZKV25ka0Rx?=
 =?utf-8?B?TCt1Qkp4aS9OanZZZDBFdm9IU2dUajZwM3JtaEQzK2dSVjNGUitOcHViZXdQ?=
 =?utf-8?B?RmZnMGZWeERaN09uc3BiL1ZRUkVIaTZVMFk3OWdlZkpXSzhUeTRZMGtFUDBY?=
 =?utf-8?B?Q3Z5M1ZxanJvOEhJL3BnRG9XMFJsb09SRjdWdFdzSWJ4Ym90ZUhUeFlQV2Nz?=
 =?utf-8?B?MFo0YU9zQXFqOGJLWFRWU3VEMHFoOUdOdHBicVRaYmV5WVBxeUowZm9tZ05P?=
 =?utf-8?B?ZjVud3FYUGw4MnhhM3ZLYm9Ha05JUUxHZmZtVjVXUUEwTjM3aWkxY2lsYUZj?=
 =?utf-8?B?RVVaRmh0WDUzZytTNUN3WFRqbUlCd01kVWF0RFNOZDF5UG0xbXI3OTNOVG01?=
 =?utf-8?B?U0gwTFZHSHViQW1PRG1SVjFJTk5kQXNnRjRXLzViWndIOUVBUTF5VUkwMk5x?=
 =?utf-8?B?YzNOajVaenlPa05Gc2pRSGdYTVFvbjNtT0pmemhWVi9oUXZZOXViYk9reHlt?=
 =?utf-8?B?R05NWXhsRHNlUk92NW5XbnVjcVFnNVBnelJjenlVMThzZm9vWmFRSkY2QzZx?=
 =?utf-8?B?Qnd4SEZsdXFFdHdxV0Iwdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WThPY2lac2tSQ3JEbW55MFY5TFYxTEJ1SHYwdGYxYzJ1TVBhSUFpeG84QklM?=
 =?utf-8?B?N245bVJKSjV2Z0s5a1N1LzhnQlRpTlRReVU2cXJzTUhRaHYxR3V5a0ZkZ3hL?=
 =?utf-8?B?RVU0eTY1VnN2aFh6RUhmNVZhd0paNE1pT3pOTytIRUI3K1hmaklTVW5xd0d3?=
 =?utf-8?B?MkxWdU1xYkFyUExIR1BYeStKNDJjY3pJQUU2MTltTVlpRkdvZm5KWXg5dFJr?=
 =?utf-8?B?N3krcEVFdkI3aWp1VU16aTZxVzdITjNyKzNyZ3R0cm12YjJDTHB2NEplT24z?=
 =?utf-8?B?R0NNeDlQR204cWpIbk05TWdPZWFjd0xETTVHS2JnZWlXY0kwZE50YmdhOEda?=
 =?utf-8?B?MWtWdFExUFZPN0NSUjMwL0FpSjBZcU81YUFhMjNHeWRZZCs1aEZNbTBjS0VG?=
 =?utf-8?B?djRjcnlaUXpCQmlRY2oySTZLeVB4M2pyZWZ6bU1Ra2xZY1pNUE1PdUZtZFFD?=
 =?utf-8?B?KzJpM2w1YWVwNjNseTJiZjkzRUxHV045QTltZlhjYXVmQVFDK3cxbDEyQmtO?=
 =?utf-8?B?c2dMMjhNSlBxaTM3QVc4UzZOREZPalNqSGREUmlkSU5zSUwzTTRYQnprT1I5?=
 =?utf-8?B?VERWZjEwM3hqRzIvbTBFWTFPV25rREJ3Slo4bWh6c0xNODIyNTlGU2pJb2FF?=
 =?utf-8?B?UmJ2YXJUS2NZMDZWLytuamRlenJDK0RmVlpINy9WR0JSblNjM09WS3c2dEJI?=
 =?utf-8?B?UDZ4VEFucjFwbkJPSmEvZjNNeFBSOExubWZrSmxQNGpBOEtzcWVYdkh2WTV0?=
 =?utf-8?B?RXBpZXZmbW1qUnZSVTYweHpTOHdqM3dwcG9oc1JVRmk3c1R5K0s2b0d5QkZG?=
 =?utf-8?B?OWhEY01ES20yWW1NWXBuQjRGbFVqbmhVZ0hDNVdMaTA0WjVlWGRiZVlGcHdZ?=
 =?utf-8?B?SUtNTkVCeWZoWDZEdHM2Mmd5eU1rd2NQVDI1L2VNVjZFSC9QQndsSVB4MmtN?=
 =?utf-8?B?Q3o5N3d6dXFIUFBEMkZ6VU9FL2d4N2ZreWE5cm1zdTlrZlNhLzZmc3VacTBk?=
 =?utf-8?B?b20zdEVRZGJ1RFhOTElEaHNuNHBGUmg2QXZlRVRJRXhIOXR4R3FkTnlOSlRV?=
 =?utf-8?B?UlIwRFVteUJkallZOVVSTXZPVS9qNnRzTXdVWXZEdTYrZlBoZmZuQVczQWZ6?=
 =?utf-8?B?OVROb3QrSUtjZHpBcFJ0RVV0eGVCQ2xHbVNGR0owVlRQZ2lwa3ZBejcwUW9r?=
 =?utf-8?B?N2UxMkNaUFJESmRLQ2kwWWJNOTlyNnBsVU5jbnorbm0vZGtvK0xDdkdhRHV2?=
 =?utf-8?B?S0lvZ1gybHZDdXhPdHpIdGc3T1RTSHpHRHZDOUFQSWd2UitUU29PK3JFTjll?=
 =?utf-8?B?NlVwL3pXeDZWTUNsaVQwajdZaUNxT2tJajlhZkV5NjZKUndaTk81WldPZmkz?=
 =?utf-8?B?dFVYeThnVGsxQmRTdnlKOWxrKytud3AwWjhMajZ3KzhsL0hkOFBmdWNBWTFK?=
 =?utf-8?B?TEJ5bms0cVlhb21xdU9lTzc3Vk95K04rYmQzWVl3clJWazBZdEE2MzR6cFVI?=
 =?utf-8?B?enB2a0YrSnp4bFNEdjRkYld4OUFGUG9kVHBKanpMZlMzOG9JMDlEc0IwM0F6?=
 =?utf-8?B?dlZZVWV6cWZYSHRWTEN2eWJmQVZQQzk5RjdyTHFmRWtSQzNMc09hNjgrOUl1?=
 =?utf-8?B?cGtZK1ExT01HeUhwV3J4dHlKK1B5endzbXc1U0lDYzBrVXBWc0VVTzhCcmYy?=
 =?utf-8?B?WFZuSHo1TUQ0akhQZHo1ZnoyVzcyS1JWbTB1YitZZFJGME5rRTdxUGhOOGZ2?=
 =?utf-8?B?YVp0ckVEQTZvUTlpT3NWOTNVdHd2aCttVVZHbldRc3p2NVZuVnZ3ZEVleXBF?=
 =?utf-8?B?RGo1WC9mVTdoWHJHSjdRSkl5YUxwWXV1OVc4Z3JzODUzVEZkQWxTak5mYm1n?=
 =?utf-8?B?QlNDMUo0Q0dGVGRZOUhOZHZSRjNkUWk5b1dRZ2tNcENSNXJVbG5PdzJHVzN4?=
 =?utf-8?B?QmkwTHowTUFXLzFlbmQ4MkEyaGVJSk9ScWJRZktJVVVTSm5TT2pkVkYwRGtl?=
 =?utf-8?B?ejkxblBva3phWlZIZitXQ0RMeHgzZlZWUFJDVEZwV044VDhmRHBTQVY4YU0x?=
 =?utf-8?B?aFZxbGJ0bzFzdWxKMDlKUExGUXdVMWplcXNYbWlYVW9oRTV6TGlSNHFwSHlE?=
 =?utf-8?B?dmpHemgxUGxRODgwbEkyWHVFK2ovRnEwczVOZWpldWJXdFUzNXAwdVd0ZXoz?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3rzCCadXu+RuJ85hUKe2NREahNBQ+fqM+aZywJ0h5vky4ig1xSXk//rdusnlSCNDZELGQjtUhgmWmfnNit1GjwUL1H3CHTeBnG0c+9+/6mYX8cTivEzsIhCPNGDFh969pqpzoAvFfCQzITtI4HEcFTkgiPQE7EaPkMr9+YrZUpOlGNpRwr96Ysr+G91G9/B3SAldXDwpAAhGCDvLNTTi0BDpdE0rsvylWz1554yuXhZ1swqgpYBvM8+M+u1tPt3brMFez+nlu9bJyfri6G0MgR8SVh6li7IoqnwKicxQA89pAeb23ReSvZ6wW0EkH1Q1hEzZ9geCzAT5dwU2rnEod09+jzoK0SGlnQIMkOQkEESnqzK8HpvimwzUSMoP+Jn/6RzQfRgA5OzosfkdH1bJsADwiiuosL5DoqiuFFf9opdWtsbCt39fVg96Xh2A4JCAmrho4dEWdw3yK5WEMlBdEn60ePbqFwB5ZKGVVxzAfc5XCPqZqBkvPTwoYeKOkLEKBTifjQ8oU5BTwfloBYBrT+rkYxE4J+tVgH0srahg/FmdJrR95+voR8E9m5eQSRzZdBby1MDvj46P4HNVuS8eM9Aqspkml1L/kAH/dYTnnxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb91db67-8eb2-4ae2-f183-08dca4da888f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:29:28.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVNtATxw/UiIh46eGEc9nxjfX7OYXuetq4yGfTRQu20BuGQYiNqVqtPHCzgLgsDpp+mkV7uu2r+h+vQqsfQP6r9s3XZ7wU9CG1x0OfDXwyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150114
X-Proofpoint-GUID: zLh_jZD_Rr7st7QvYV0qJV2amMtWcrzl
X-Proofpoint-ORIG-GUID: zLh_jZD_Rr7st7QvYV0qJV2amMtWcrzl

On 7/15/2024 5:07 AM, Michael S. Tsirkin wrote:
> On Fri, Jul 12, 2024 at 06:18:49AM -0700, Steve Sistare wrote:
>> Add an ioctl to transfer file descriptor ownership and pinned memory
>> accounting from one process to another.
>>
>> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
>> as that would unpin all physical pages, requiring them to be repinned in
>> the new process.  That would cost multiple seconds for large memories, and
>> be incurred during a virtual machine's pause time during live update.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Please, we just need to switch to use iommufd for pinning.
> Piling up all these hacks gets us nowhere.

I am working on iommufd kernel interfaces and QEMU changes.  But who is working
on iommufd support for vdpa? If no one, or not for years, then adding these
small interfaces to vdpa plugs a signficant gap in live update coverage.

FWIW, the iommufd interfaces for live update will look much the same: change owner
and pinned memory accounting, and update virtual addresses.  So adding that to vdpa
will not make it look like an odd duck.

- Steve

>> ---
>>   drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
>>   drivers/vhost/vhost.c      | 15 ++++++++++++++
>>   drivers/vhost/vhost.h      |  1 +
>>   include/uapi/linux/vhost.h | 10 ++++++++++
>>   4 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index b49e5831b3f0..5cf55ca4ec02 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>>   	return ret;
>>   }
>>   
>> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
>> +{
>> +	int r;
>> +	struct vhost_dev *vdev = &v->vdev;
>> +	struct mm_struct *mm_old = vdev->mm;
>> +	struct mm_struct *mm_new = current->mm;
>> +	long pinned_vm = v->pinned_vm;
>> +	unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
>> +
>> +	if (!mm_old)
>> +		return -EINVAL;
>> +	mmgrab(mm_old);
>> +
>> +	if (!v->vdpa->use_va &&
>> +	    pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
>> +		r = -ENOMEM;
>> +		goto out;
>> +	}
>> +	r = vhost_vdpa_bind_mm(v, mm_new);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = vhost_dev_new_owner(vdev);
>> +	if (r) {
>> +		vhost_vdpa_bind_mm(v, mm_old);
>> +		goto out;
>> +	}
>> +
>> +	if (!v->vdpa->use_va) {
>> +		atomic64_sub(pinned_vm, &mm_old->pinned_vm);
>> +		atomic64_add(pinned_vm, &mm_new->pinned_vm);
>> +	}
>> +
>> +out:
>> +	mmdrop(mm_old);
>> +	return r;
>> +}
>> +
>>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>   				   void __user *argp)
>>   {
>> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>   	case VHOST_VDPA_RESUME:
>>   		r = vhost_vdpa_resume(v);
>>   		break;
>> +	case VHOST_NEW_OWNER:
>> +		r = vhost_vdpa_new_owner(v);
>> +		break;
>>   	default:
>>   		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>>   		if (r == -ENOIOCTLCMD)
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index b60955682474..ab40ae50552f 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>>   
>> +/* Caller should have device mutex */
>> +long vhost_dev_new_owner(struct vhost_dev *dev)
>> +{
>> +	if (dev->mm == current->mm)
>> +		return -EBUSY;
>> +
>> +	if (!vhost_dev_has_owner(dev))
>> +		return -EINVAL;
>> +
>> +	vhost_detach_mm(dev);
>> +	vhost_attach_mm(dev);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(vhost_dev_new_owner);
>> +
>>   static struct vhost_iotlb *iotlb_alloc(void)
>>   {
>>   	return vhost_iotlb_alloc(max_iotlb_entries,
>> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>> index bb75a292d50c..8b2018bb02b1 100644
>> --- a/drivers/vhost/vhost.h
>> +++ b/drivers/vhost/vhost.h
>> @@ -187,6 +187,7 @@ void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
>>   		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>>   				       struct vhost_iotlb_msg *msg));
>>   long vhost_dev_set_owner(struct vhost_dev *dev);
>> +long vhost_dev_new_owner(struct vhost_dev *dev);
>>   bool vhost_dev_has_owner(struct vhost_dev *dev);
>>   long vhost_dev_check_owner(struct vhost_dev *);
>>   struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>> index b95dd84eef2d..543d0e3434c3 100644
>> --- a/include/uapi/linux/vhost.h
>> +++ b/include/uapi/linux/vhost.h
>> @@ -123,6 +123,16 @@
>>   #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
>>   #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>>   
>> +/* Set current process as the new owner of this file descriptor.  The fd must
>> + * already be owned, via a prior call to VHOST_SET_OWNER.  The pinned memory
>> + * count is transferred from the previous to the new owner.
>> + * Errors:
>> + *   EINVAL: not owned
>> + *   EBUSY:  caller is already the owner
>> + *   ENOMEM: RLIMIT_MEMLOCK exceeded
>> + */
>> +#define VHOST_NEW_OWNER _IO(VHOST_VIRTIO, 0x27)
>> +
>>   /* VHOST_NET specific defines */
>>   
>>   /* Attach virtio net ring to a raw socket, or tap device.
>> -- 
>> 2.39.3
> 
