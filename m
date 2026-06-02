Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1A3A8FE8
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392090; cv=fail; b=RqlQhtCMuJWPhszrvVlHSI9hsJg8849E2KbYNHf1nOy310dtvi0oeCCmfmt5GlyaPp2KfGQCRkdgN80Wkg8y/+mf8TA9VvApYU9bfSaE/t/DjqRW5BB2n8dj/h8oj/L3p2yACjt0n1CzXOOHo3ooB8xIPPcLQt4S+mThPgQPLqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392090; c=relaxed/simple;
	bh=Ole44ha8MBI0R7qh4/nyD0Gnj2IbbSOhlyOdXmHvaKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvQ2J1Xpz86QocEmIMtF/4hFlho9KrTimp4DPW6SAfjutdsxzt0YC7IMSwzh8trL+HNZ1goP1gveCCRunhhu8y8pjZohFbtT3pJAYwIIMuk7QLoD1OEwRBCWfbSJWT9tTpqr1g6ofr85Dx1xC+T1ew6/0WS+JDj31dhFdSl13Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hHy19CPQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EE0vPz7c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hHy19CPQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EE0vPz7c"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6525u2l54022935;
	Tue, 2 Jun 2026 09:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wcvOzPEm6Q8Mi+uV8DLCIdmdPIoT8tLGxZwZiKSWLzM=; b=
	hHy19CPQfuOMoZiPM/tsAzEw9TQe/xWZE4fwxkfry8oQLvioV+vdtqvB8VzOrhVH
	7ENIEGtxYp8CWbxcIPeUESZTVqk2LdogNweLAJ9esf8ssTv3fmd0UWubZcVeNxNa
	t3DYyld9G/TTxs6JJ6+dnB8G0InJ/F4KoDwtvGGorIvhBu8YFBy3h/c0u15oAnWw
	KzFBf1mnE0Jho4rqiTVW2j8IaX8djnzHyFCmF8Z2YOdSwRBXUTYU7SZrnUbzon8H
	PZ7MIgHtPdgKkwNBH0oenUYxEKkFZmhy75i3LodnS255hTr6zW4YLTetG/Gb0maK
	0uJllBccRMGHONu3mY4NXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efres3mr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 09:21:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6529Etim039831;
	Tue, 2 Jun 2026 09:21:20 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbchcub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 09:21:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCf/KjAk701kDIG6yCuEE6QI3RFJFnQgr2qAvAfMNFXL+rC3bwjaBeH/s4j4MuOrJBJUfI5qC9A8JRKRyMts21CyJ/3yh8rN53CIob5PttlfaO6zN3hxLhhJQNsIwPn5MHNvdLHHVCesM4Z1RDhj4IMmEFzA6ldVDtpyx2aort1pOmQf3t8QwMd4uM9jovREsoX0/fw1RSuvpXS2pu5yTW5UmcfSh0/biDoTsb6azTDbvE6fW2/JW/rKiAlS2o6UiHuseumL+3lppPD/ihwSrO9Psv2pAP/Xv74H8HaFoIUYSvb1cgv/WdGRniE4w+o7lkCixkV+X52TztZnN0rBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcvOzPEm6Q8Mi+uV8DLCIdmdPIoT8tLGxZwZiKSWLzM=;
 b=dbnYLh05+09cZgBrjYIR603+vD9ApLNC9GKYMZ3QEr8XImvDJADM5sTGysrBpV66UQhXe3nbIYdLFPxn7cFT3Dx2YkFX53yOyy2Eq6oRNlVyYDAGY3U5sMpIHn0O6vpwUpxNjdA3kxtHpIgDfnHoyFmCAlkPPopJaBJ9mCReDMyrfjI4bOilKK+Go/FAMkR/xFAl+nDCtKIo+TmATc5Kcwb7JbJ/beWZleEXeXYrgdFCYtTXrlEaJOKRYXKUdYxyYSFhMNh+PzIzEpOr6hMjG7h8Luqiq5aS5p2w+2LtCvkSTrRgSNKnsQ/ILp7HSJ1docDIf05mH0cPyEsLZnlLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcvOzPEm6Q8Mi+uV8DLCIdmdPIoT8tLGxZwZiKSWLzM=;
 b=EE0vPz7cJlummCUsOw8Nym8Hw5lXnMaeB8Rgp/61/pjrSwNqmForjlWgykq5jRc+gBRDYupuATthwuFTZbt5DZhjTDILOH20WjNU1vgrvE3O3pOx+hMB+Mne2UVRRzvAfGgvvrgXem+tuem3wnZFH0dTk6hEVYUgqucXBKUWQuA=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by SA2PR10MB4746.namprd10.prod.outlook.com (2603:10b6:806:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:21:16 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:21:16 +0000
Message-ID: <61c16418-0a8d-4307-99dd-1617ddcc67fc@oracle.com>
Date: Tue, 2 Jun 2026 02:21:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        yangjiale <yangjiale133@163.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <20260602025930-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260602025930-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|SA2PR10MB4746:EE_
X-MS-Office365-Filtering-Correlation-Id: b082bc78-cbcb-457d-5f0b-08dec0884ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	xIIzrNSzcuuEZMH+rsv1d0s7juGk3yT0UT8TaWd2ORLuodA6/CxLHA7Q7rkT/0qX4tDRO6Lt1WCqBpsB+dv/LQHiiAIglHuNQ2ck7NNtNgnZWltPic5YYho4SM35UKy74tOe3SPAflNne6r5u799OYEWYnt0cWP8LMiSIRricG7X266GGjBgA7M52vse9lBFSSrACtTZRK9ibrGTkkRCFekvgJ90YnHitfJoVAiy8b+VGXszzIbHbMIOFd+A9C8egsxvpSjZv84LDk/UvXmscPYHmH7CtvMqGJYzHDHiyvc2Tv/1tDPmnv91Eo0DSfLimk7pUPatUuCvZdvfftixcgB8GRRL2J7KGlAhj3YO6TpK0krL1rnpfKWXEQ9O168MImsyMZEXwgQ5jqu5WjhdMvdCKHM6iwhw0UZZRns4y0tlIZCMcXcHZnnEX20ZpCZA8fKWBlUsrclOfO/kRVKTtv8//DNd76GppfO8lqQGB2VIlaEAXbXxUx9ZaJlkjpnrLk267iLqThQTcJvHMOFvFObeknbM6cKh4Lww/vzGceuO1yb3JyVfizZn60/Ub4JbjysCHmcu/wI4T5lx5EuaBkA5fSyVibFcEKGJk0JqDRIDGZQ8MH4N2M/sJ9mCkJ8CociAHg2uJvxT7o/CGyw3ZGnk3R/9ZCphKQLb3sWIiJe3/3OfoQWy46PLwaNLzpNt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVdKNVA3VGdQaUhCQU5QSWVZQkxkR3FPWjgvbCtuc0tsb0g0YXlzdS9QV1hN?=
 =?utf-8?B?L2ROaEwxVEc0OUQwWjRpUFYzN2duTzlVazFJZ1VmRnB3a1g2UnVsNjA4VE9T?=
 =?utf-8?B?OEV3a3Z5ZlpoQU5lcmR0VE5IU3pKUm9JUmFUTUhPeG1TN0Irdm1jNGErdURm?=
 =?utf-8?B?RHh4L3dXRk9GaHVmRjZYajRuSkpEWnllU0xPMVI1dFpEeDBCMllYcVZrZnZI?=
 =?utf-8?B?VFptRkhNaHh3b0tqcUxBL2VEZmVRMFpXcWVyZWVOeldSWUtneGhHejFBOWQ2?=
 =?utf-8?B?M3h3Mi85b3JnVWk2NlBPa1FhbmpHcjN0dTBBakxxZnFLRTJMbDk1amMzS0dy?=
 =?utf-8?B?T0EvT29jMEVvbDBicXdaZlpoWHBLTkJDWGw1OS8wNUk2V3d1MUdEMlpyZGlH?=
 =?utf-8?B?YXJaR2dxTFU3cWFDa3djT0pFck95SW5sYXpodjl6V293c0pWYnlmVGZLeSt1?=
 =?utf-8?B?TjkzaFludnZEN2lucjdmOGlpVDFMVTVPQ2dFTmtjSHArNmQ5VG1RNWJIQTBT?=
 =?utf-8?B?MEF5NWQzWTBlQjd4TlZRSUpNa2Jab0VUNTVBcnd1bnMwRmNLNVRaL045c29M?=
 =?utf-8?B?UXJlV29ydSs2cEJJNENHbHF3SFIrR2daMjJwWmdRakViYUFZYStVTWJOQlRQ?=
 =?utf-8?B?am4rNi9ZZ05JdFl1bTQxQUtsTG5HNjYxZGdxTHpVcm1xSytQWkovUWpTOS9J?=
 =?utf-8?B?dGxRMkV4THRWMVVnMWRnT254RkVZdWxNd1B5WERMMXhnZDEweExLd3gydVdG?=
 =?utf-8?B?Rms1UE81cURVZDNLaC9LemFKNjlCTVZCTGtrTVZ4M0FDMTBsN2M3Qkc2b1lZ?=
 =?utf-8?B?a2ZUaUI0azU4aWp5Z1lKa2M1dm01UXBjT2tGZys0T2tYNlNlMlFSRWFGWHhC?=
 =?utf-8?B?TE92anVrc1UrbzQ3T0xNcW4rcEdleWJvbGdTV0RwQkxFZG5EdUg3am5Xa2RE?=
 =?utf-8?B?bXVXSVpTeE5KcUgwNUtYN0tRTjVrWmhoazdySEErNndaWFcxL3IxNytIUzM0?=
 =?utf-8?B?UlRGWDVUQmtkRVJTUi8xb0RqUnBlRjNHZ01tNWdzS01hMEplc1BSMDd1VExG?=
 =?utf-8?B?R1FhZ00yRHJEajdWYkFEWENxMWRjK2luc2tpT1AxVVJyMkNGUFRJZFRjOVY2?=
 =?utf-8?B?MU1ibUU0Y3Vyc3FYUHBtaG8zdHFYd2FEdHhmUE1HU1M2aXI2ZnhOVFZXYi8z?=
 =?utf-8?B?ZmkyWG80KzFqamJtbFQ4c2lWcmY2YjhvQUl4bkdzK1Z4Z09BSFFBNE9raFZa?=
 =?utf-8?B?YWowOHROc2dYSGcreDhjNkpzSURmOGdVRmpuUUZXUWQwcEVPRXh1WHJyaXhm?=
 =?utf-8?B?Q0RHSEJ0Q0s2ZVFmcXVGTml1VjRBU2EyMVB4R2VwWmNaby9WaWxYYW1oNmFu?=
 =?utf-8?B?MVE2bE0rMnBKMk9waCtydHZ3TnZWL3BpUXo4ZDVXZXdraU4vcVlwbzZGZDhz?=
 =?utf-8?B?WUw2V1BpZ3B4Q3RSbTFlRjFObCtmaENBRFkwMEE5Z2dOOFU3VUd6ZnQ5Vmta?=
 =?utf-8?B?WVNlUGRpK1BVR1R0bkFQKzlWcWQzMnlaVld2RlZ5Ymo0OFNTTm13NWpMalhu?=
 =?utf-8?B?ZDVDZjZOYnVoNStUTzNWMEh6TnJmK3hncUZTTzVLZlA2dU5sYlFITjBMQjk0?=
 =?utf-8?B?MjdudHZiT1ZFZUJiL2pwK242WmhDenhFOXpxazEwL3pXNTZEcUhycW1HT1J1?=
 =?utf-8?B?dkkvRDJONFdSNkdrbEhOeEtkSFNCaDZ5SjBXTEJYbXZsM01ZZ1AzNU8yditw?=
 =?utf-8?B?dVJnclR2RjBXamEyZkRQRVhOZ1Vyay9aZTg4SmJDRHdHQXhkUmNQTEtRZWht?=
 =?utf-8?B?UkN0eSs2eTczQzJPVU9RK1JHd3p6RUQ5cEVsU25kOFF6UTlMWTl5ZDlkUjM2?=
 =?utf-8?B?MWF2dWJwOGRxSFR1a0ZxZWoyRml2MDc5K2tCWjliN01BQ1pPd2x2MXVnYitB?=
 =?utf-8?B?NDdCK2ZON2p4ZHRwWnMyalNOWnliOGE1ZGVWT3ZzMy9QQjhwL21QMDlwWlBW?=
 =?utf-8?B?TkR0aEo1UGZIMkZLZExTdjF4RlJIKzQxTi9ITlM1dWdzNHI1VWJBd2N0WW5G?=
 =?utf-8?B?bUVvWTRua1U0Y2hmVm9zUndhSW0zdnJ3VG9XbFBsRVRPTzhmTDdrcjBWY2xp?=
 =?utf-8?B?SHpaTTNxV0dnTDM3NzlUWGFWRnI3MEw1ZTEzcDlYaUNQa295a0ZOTnF5VWpy?=
 =?utf-8?B?dEI5MzdXVVBORStGOENSS3RDOFhTQUhjY3lGVXppaU9mVVh2MmVRQVNON3J2?=
 =?utf-8?B?Ry91em9kRHpOeTdPbGtZL3hrWGowWmtuL0w5U0t1WTNHYmlOa1ZpbWpVNW4y?=
 =?utf-8?B?cFBFc0J5a3BUbmlEcW5EWmlWaWkxM1drSnZXSmpGOU15TjZsSXZGaEl2cmw2?=
 =?utf-8?Q?mTA6Tyw3sKPWM1LQ=3D?=
X-Exchange-RoutingPolicyChecked:
	XXOHqfgG0czdOtJB07JvyTUR/1mwusGBAOtVzKfQgV1JmRPdWJb/9kuzOBgHGkc1YBlcuWpO9bXeIZ5vIF/2c18l62dA1gaKankIMfw+7SsMO/hLhBS/My1w4nAg5ZX56qTUEpZNmWcEgD0ZSF1s/XJtvrjlZGL106ZmBmpJszccvRJ8GCJASfYPFG6Tnedkn5pphUFcfc5MEjHIGVhYPop38BLNnUn4j+6GjCY9e865z2sa0rE4Ie4h0GiqHQRovn+0tQz8yimR3hsYtshokwC1g45eWCteJpreMX13mcDo7jfaThcencABUIP5ukslLzNZ2489co6l7HyKJy0q2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c8j56zETUJqgLSkqvvyJUcM0WlGUO2D/dzWzyDlstayxA0eCbEPiimrLmunrUkih2FSlUCUk0sjxbnoo6gCeXiLksMuAkPcQnXaJJulXwA63UmZPWqUmZ1XZZFhIErrFuwpLnijCtptXo0JmL2PSN7gdxUwHKupEuZvPtZw6HBkgRejXUeFI4o/W/+jAcaXKH+Cpa0gXbUG23neMQpvuTtNtsyaT3yKz0Acxzy0zDYI6YvgQVvmYEHkP2sFl3YcrmjZYsJ8mbiB5MFpesshaZdCl0PPWKJAqHfojzp191KGq4wHKgw7zqB0BVuNQiLog143SEvuvgVwE4SCy3yGt0R8orFeN2PztuHcHdJ/Rje5Z5EiVBoTT1R0olvI6/YSo7YbHZ3A0tVi1Xl9eaKeseuUQDI/SDIb4MBL8bXqQxofNKK2KY8LWxnVRlAi14QNHStup6mXQP0/VMi1MTZlB/NEbuERIpOxx3kCzJb1QoiZtBgPz5lNWEkoajdPkws0N0lxeFap4Xhr1aW1UJ9Dbizqpd4QNvwQsZ6ENDgfRPn8UOyqLWNi5eBKEmaE3O5Cg4nGmKL+8wdvPDd8knwVhc2kzltKCyx0EewXqpGYHTW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b082bc78-cbcb-457d-5f0b-08dec0884ca0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:21:16.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnFrlsDDNYzgIDsMh9UfFXt+vDlo2U7oMiDpwOSuj9t94ISbUjHhJCB3O21dFcFE6mq/FjheFZFUg1HYkAf68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606020086
X-Authority-Analysis: v=2.4 cv=U4Wiy+ru c=1 sm=1 tr=0 ts=6a1ea091 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=Byx-y9mGAAAA:8
 a=gTAIRlHbaC-7MtC_GgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NyBTYWx0ZWRfXwMKLQbAAh8Nd
 r8rK4MPLIOk9y3Ex8FFxT5z/UgPirtyWZF58lEaLLbR6rvDesg4cEDaPA7sNLORDrwTup3WVrZx
 t+xX+kfdKv56fgOFKZ7uZpgN6tGvIsn1EmLcRLgDXqhn5g5XJtsSeaRs9dFxc367Ued0Q2Yq3xs
 cDhFEJnNg/P5fa+MqUXQYFzRtAzmeKPlIQ8d/ObpbL/u3fTcd8ys7uSKYUoZ3cVZO1q6c0oiLXK
 c2JImSDv7uKMML/QiEqbtR0MTGBDJtthjiT21if1K5Oox9OXAPZx6RaUXtGbnKAFRkZVF3pkI9N
 LDXwWZKzFYSqKucytCAvDHBB+JD79JUqdnYy8TEyvP7SgzjaJMrQsNuqw5huapoAts8RgTrEoGf
 TFlFQ4l5cKuOViDCOdGf/s+dXA7FAm9LOdGnwTtZsT37zcDhrBaggSUoyKi2PxtkYdwdDgOVbDU
 AdmIrDJlfSj0TUXz1jA==
X-Proofpoint-ORIG-GUID: my-N6MdjB_7Yr4fJFHGRU_R5bStWTsoA
X-Proofpoint-GUID: my-N6MdjB_7Yr4fJFHGRU_R5bStWTsoA



On 2026-06-01 11:59 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 02, 2026 at 08:04:13AM +0200, Eugenio Perez Martin wrote:
>> On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
>>>
>>> When a descriptor list spans across cache lines,
>>> updating the flag first can lead to a scenario where the device side
>>> perceives the flag as valid, yet the corresponding address and length
>>> fields remain unupdated—resulting in invalid values.
>>> Therefore, the flag field must be updated last.
>>>
>>> Signed-off-by: yangjiale <yangjiale133@163.com>
>>> ---
>>>  drivers/virtio/virtio_ring.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index fbca7ce1c6bf..036b4f90d30f 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>>>                                              &addr, &len, premapped, attr))
>>>                                 goto unmap_release;
>>>
>>> +                       desc[i].addr = cpu_to_le64(addr);
>>> +                       desc[i].len = cpu_to_le32(len);
>>> +                       desc[i].id = cpu_to_le16(id);
>>> +
>>>                         flags = cpu_to_le16(vq->packed.avail_used_flags |
>>>                                     (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>>>                                     (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
>>> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>>>                         else
>>>                                 desc[i].flags = flags;
>>>
>>> -                       desc[i].addr = cpu_to_le64(addr);
>>> -                       desc[i].len = cpu_to_le32(len);
>>> -                       desc[i].id = cpu_to_le16(id);
>>> -
>>>                         if (unlikely(vq->use_map_api)) {
>>>                                 vq->packed.desc_extra[curr].addr = premapped ?
>>>                                         DMA_MAPPING_ERROR : addr;
>>
>> These flags are updated before the flags of the head descriptor at the
>> end of the function, at "vq->packed.vring.desc[head].flags =
>> head_flags", so the device should not see these. Because of that, the
>> relative order between the rest of the fields of the same descriptor
>> or other descriptors' fields, except for the head descriptor's flags,
>> should not matter. There is a write memory barrier just before
>> updating the head's flags.
>>
>> Also, I don't get why the cache line matters here. Can you expand? Am
>> I missing something?
> 
> Oh desc is just a local thing. ENOCOFFEE )
> 
> 

Whether or not this can happen in practice, I notice
virtqueue_add_packed_in_order() has the same write pattern.

Dongli Zhang
