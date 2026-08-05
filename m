Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEF3E92B5
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962449; cv=fail; b=vBbgmb3yzvA18vs1MHDMsSTZLQi8LYDVjpGajRx0weSS0GowbnvabJyXrgAl/fsanmI16//OQgaH5bG1NcrkgNOriKg7va3Jr38HD6Iz0VURp+YLvb039BbZtR2QyPs35KmoCARsn4PJiYN3O5acYf7Z14UlS7jFoW2UlGmsXY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962449; c=relaxed/simple;
	bh=fcVKNLBcz2AISrsoRTRxWfSszOMEeRpLflWnO3aTpss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hL5vRZwr+7j/Z4VS5e27GrGo9hd1fPmCo2luT2WuHQSNNNSYh/0mvoPlotdUhwzbMUzENPztUSA3PH4NMTBjK+Yu9n0ned12fuiim0xAhn/2ry4dasv7hKo9bwASy4DXOAyVJpuJo4d/MZ8p+C8b2TFOAfH6FjwfkwTGrvgBxqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=laPLvAaF; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="laPLvAaF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5Yr0ESS1MKslYa80ya/ipYI2f7vd8LVcgTpajnFVY5ir6lLuDUPOokAbXfNP86fwUCosFY2blnrpOgSvDAkUFojd20vjXfohXLQAVivInBN5TdmHuFRJ6jH3+zjiNezG815QpJOhF58wR5xBR3iZGVprr5R6dqPH3tamoqcPZzMySSR3K5Wch2/MK8wqTCG9X7Iyy/WJycgaklO0s0xzA85B/xgtaa9XcQFLeCVaYY6AQVhac7/N6AsinKhn0ExRU8iXpNpPmkwhf4F8dgqx7kVf/PF47AFICWMhlz6E8r64LABPoGH3hp28zntH3LkNedPoLfOahmmo59eMtFuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qwUGxBNwrUhoagTkDAycPYLQzl31oM7PuLAhM9ArSM=;
 b=JMVkLVRq2X3LnzhzcEzaL1ZycZtoL7gN551doRSjYRtHHqx2eLMwBWlms/7059/YT6MuicrIYuC/yW18hP9f9kjGf30/s7WldjnN2V3tiuiYIIMwBHEB7RnsEFv438/PXD7eNJbTONdigm0t8faS3I7dNrAFPQb5LQ4MZJ1eW9FpgG51ulxWWzaeJicYbyym3bIlKcIeHedf58cmGIMWjjap0/fmMiQ6sjrVnnrqTHOnJvBNyWfnpOWMbms7YjUkQ1T+h262S3mVz7g3VaD3z5sksuKKigoiraYVKGZeXuU+dX9J4eQCtDTeBpypMidItMMSGTuWFGbCKdk7V0uOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qwUGxBNwrUhoagTkDAycPYLQzl31oM7PuLAhM9ArSM=;
 b=laPLvAaFu2sbzLaC09noIFbCUeL8+xXyVbD4hfb/1Q2q4CMJhyhS7Ygnk3oCVjUybibZ6LXCJtlYFkRDA6WhWNvz37rHkvOm+fs1PzT7fTXUbIPcTbqDBCPbxbext77JP9EmC2dwh9br0k8YNDzc7+l6wq8R2gcd3dnSl6cyFUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 20:40:43 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 20:40:42 +0000
Message-ID: <08a8f40b-6c01-4296-8e49-432c9dbc3a9f@amd.com>
Date: Wed, 5 Aug 2026 13:40:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/pds: check virtqueue notify mapping
To: Xiong Weimin <xiongweimin@kylinos.cn>,
 Brett Creeley <brett.creeley@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260804085341.1333303-1-xiongweimin@kylinos.cn>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260804085341.1333303-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::27) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb314f2-719b-439c-42ea-08def331d136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MvS/RukWywDLR+LTZaC0v7jXfSrpUtHlbHQdzGllUHPQbIQ5fN9O31OMihO2MQt0vRDRYWI2iRJxYvO1Nc5DJ88vBIf81LAcGga1rk612nB664xzU2pJMTBAiDYSONcHOOAYMZdoLOr2+8Ds3cF2Xsw0QTfh9u0QixbCzg5eLO7BYXTbAh5g3vx0GzbiRO/2ado6HIPyH3iQbV6erTPgojSzq+CwJ/RShDIWjarooGTSjES6cv3BKgBMx9l6ArharQYDORR+dRK+8+HuXrj/MAamhSHVFxbsGbSlYh7OUeeyJ9cV9AwEkNNME36jCjz9P1xieX/anLyf6bUxccz0W7Dkvcp0+kWpUM6BNMW6LoZZuFHzIxGMRs9jJp9hTULd9vULlsEMy6asp3ysY8Na8qX68/5XokNrN4TBlvvFz0KX/Ew6lY+MpQtNKoPwKx67Kx+dQo0TnqEG+zD0zqGjnH7h5jhM815EDcs9/meeBBcRfQVtIbKJ84TQCRi0bpdmU4ngtfsxrFZT8EA1OLz97vTZqaF2j/hoYEmtIOUy3pgMSZtwk0r/h+YbB0H8kcMtSx6UL6my1PS09eRKNB8Dbttcb97PtNxpfMtcCr1T9auOkJx6Y3pgT9PhC4oCmcCVXXRfzk8UYYiC4+/sIwSRviaNp+JRDgodepuKIS90+UM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDMxQnpkWFpKZUVWMURGZFVaN2ZXWUVNNHpvNWs1U1hsNzZJbjRqYUExMWpn?=
 =?utf-8?B?YnFvVmxvTXlxbFZHeU9EOUluRmlRZ1dCZGQvWnlYVUp3NS9pSHJMd01TVW9r?=
 =?utf-8?B?cEUwcy81cmZBTDhsTDhwTndSdzVoQ08zc245MWVnVnlLTmVUT1dnQXFyVHZa?=
 =?utf-8?B?M1lhVFBObU05bFZjMGtTeWg3OWtuVUZzTWRadkZPcHdkTHEvdlFsdkZWQ2JF?=
 =?utf-8?B?WnFLb0FQSUQweHJRdW4wejQ1MDlYNHM3bmpRV3NBbnZIWExwWG03TDNKdEE0?=
 =?utf-8?B?dUJDMUF6YkVCRlJHNHFINlN0ZkZXU2JDbTVPYjc1QWVrcjN4WVlIc2dVUzVW?=
 =?utf-8?B?WGJvdDByQjZheHQ0bVM0cTc1T1pnd1A3b3Q3ajEyZm0rb1ZuVTJlbDRvSGdp?=
 =?utf-8?B?bVYwbGY3dUFmajNTc09JQitrTGdKcnNsTE9JcjA3djc1MERqNW9mSkNtLzVS?=
 =?utf-8?B?cE1qcnY4QlhZUjgrYzl1elVvWklaVjRxVnNtWTR5Wk5paWw4NkF6bDIwMTNB?=
 =?utf-8?B?ditlWkN2Sm5FNzVlVnNrNHB1ZkxmV3VZSm9OTDFZTXFSOGVlZDNTdzRVcFpZ?=
 =?utf-8?B?MDZ2RkQvSGVvSzY1SjlBN3ZSalYrMHNKUkQ2L0ZqL2xvd28wekp3Y29KMGF3?=
 =?utf-8?B?N1krLzlOWFVNZzVvNmhjM2pZczZBY25yVVlCWlpVVXd5citEbTN1aVhoYzFC?=
 =?utf-8?B?VjdMOGpWczIxQVp1d1BuY1l5NlFMVlZRdi9mczdwWmc0RWNSb20rek9vdC9B?=
 =?utf-8?B?ekhVWkxQTXJwMTVMUWoxTENUb2VCczJLVWVrUHpOMVczZDNWQzdJRGN6UkY0?=
 =?utf-8?B?VEsycTNlMDNiTGs4aVBEY2hjUXEzVmR5Z2pUcTBxdGJWV2xhdlJIY3NUM2Vn?=
 =?utf-8?B?eGxtMTkxNUh1QjZjSVF2OGhLbVpZOEVzdjlNOFdaVFZZZTlTZy82RmhHUnRw?=
 =?utf-8?B?cWVvYjlpRFFHMWxPaWQxRkhKUlZPQ21CM2NGRExzV3FVZ1VnQjhKazZSeTds?=
 =?utf-8?B?KzNHMEk4QnplTWhtVnNqUTN2ZFpSRU5pdEd6eHlMVHZ3MjEzSk9kOW5CeHBq?=
 =?utf-8?B?eEs5blBITjZlWUIvTVNENWE2RTNiTUJZVmNrbGZaR2k1a1o0RWc2akgzNXl3?=
 =?utf-8?B?WCsrMG4vU2lnZk1LRE5kS0Q5MlJYM3NOVHl2M3QwcDRwc0RNQk9jMGFxcHV0?=
 =?utf-8?B?SVV0MC9DYmxqeFNUUFNqemJaZXhDWnlHKzFtOHhFeU1zQ0lIelBBNG5oZm5Q?=
 =?utf-8?B?Ymc5QnpFM3k4VzZsNFlLSk1sUWRhdGdpWG9SS2JWQUJFRlhEZzNwVWFQaFky?=
 =?utf-8?B?N0ZZTU01L253MHRmRHZQRml6VEFaZ2JOblA2NENzWG0zSW44M1FBaUpneWZp?=
 =?utf-8?B?Qk9NSmtOTjJHZzFiSkdKSHlDRllWRHdEUC9IeVhqTFJNU0R2dDZNTUlhVlAx?=
 =?utf-8?B?SVI0QnJ0SEREQndYSzRPdERyNWtQNkdCNjVXN014NHBRaDhWaTJoc2FnT3hG?=
 =?utf-8?B?ZVJsakxyQnJvWkx2YTVKYVZPQmduTllKclh4SXpzTXhoTFJyV3NoSjFwNUlx?=
 =?utf-8?B?OXJBWGhwSFZibDZNVkx1NnRxb3FLUk1GK0lycHBhZldwWWFRNXRyL3V2a3B2?=
 =?utf-8?B?Mks5TUIyTDhEQzRLdGwvSnhWd1FCR3ZrVm1qVFd0c3laQ0pROTdtS1NEem9x?=
 =?utf-8?B?K28xbXI3eGUwZnE5bCtpWXpxeE5MRVBTVTloMCtpR1lENEVVcVlyNkRMQ0hU?=
 =?utf-8?B?Y1phZ1Q5VkJqWlJ1Z0g5Qk1zUSs2eGdaM21WR1NqeXg3Rm1RdDNydVlVNzJ6?=
 =?utf-8?B?Szk4MGVaRUFtMGVXY3czQ1lQNE5HdFl0eFhIRDNPWmQ0Vm01bVpqaWRIWXRD?=
 =?utf-8?B?djQ4UEdBYUZNRWk3YnhPbndac2QvMzk5a3JoUGludFNQNTY4QjFkT0pvNEhX?=
 =?utf-8?B?T2xBNmJLbzc4bm9mM01EWlVxRUNaMVZMQUNPWEQwMGV3UGViL3d6Vk5KZEIw?=
 =?utf-8?B?WlVoVTR3WWpjM0djcURwQW5CZittSDlpSGxEUTJUVTlROUx4OUhqaUpkRXUy?=
 =?utf-8?B?ZjNxdmpDb2JtZXIrbE5iWjhybUpKbGE4TVVoQ2NYTm9NQmZYNHVWUGZtTXRI?=
 =?utf-8?B?ZXZNOHJGbHRka0U4cXNOY1ROODFBdjFQTGlYRkIzbXk3QUNPcUZXQTN4ZkdO?=
 =?utf-8?B?RVhXTk41ajJxYkk2ZlpQVFdzWU11Umw1SWg3Q3YrYkdmT3lzUmVoYTFhNjc2?=
 =?utf-8?B?NW1hVmY3YzJUU0x5Vm5oaVM2VGM0enZ1K0plS0p2dmFzRWg4a01JN3puTlZt?=
 =?utf-8?B?dGtEVFVVNklQL2lsUFJBdGRtY1VUVXlwZ1RWK0xEd0lacGZ0ODA1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb314f2-719b-439c-42ea-08def331d136
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 20:40:42.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7sKXxS/T9VRxFb4Z+TMJVMGCoRZUWM01Dq0fBE2sfMlFHeqQmwLbKjep9Lc06NuJrOKKq4h1CzX0+sD7O45GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267



On 8/4/2026 1:53 AM, Xiong Weimin wrote:
> [You don't often get email from xiongweimin@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> vp_modern_map_vq_notify() can fail and return NULL.  Check the notify
> mapping while adding a pds vDPA device and use the existing teardown path
> instead of storing a NULL doorbell pointer in the virtqueue state.
>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>   drivers/vdpa/pds/vdpa_dev.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 43426bd97..df53cfce9 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -731,6 +731,12 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>
>                  notify = vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
>                                                   i, &pdsv->vqs[i].notify_pa);
> +               if (!notify) {
> +                       err = -EINVAL;
> +                       dev_warn(dev, "Fail to map vq notify %d\n", i);

Nit, but why dev_warn() instead of dev_err()? It looks like this was 
copied, but I wonder if the other spot should be a dev_err() instead of 
dev_warn too?

Other than that, LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> +                       goto err_unmap;
> +               }
> +
>                  pds_vdpa_init_vqs_entry(pdsv, i, notify);
>          }
>
> --
> 2.43.0
>

