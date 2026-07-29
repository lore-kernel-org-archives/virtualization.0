Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021098.outbound.protection.outlook.com [52.101.70.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C127469823
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344739; cv=fail; b=Z1KREv4c+sQ5eozZGGXafQd8IO+iY5Yc5C9tmnzY0DphaVcNFp4m3yW2pXW/Lcj6pNlzYHEv6hPMzxip4ON2cp0HymHUoxspWj30ZH4nfuPlv+Eaayq31v4+HJlv2LtxptN7pU+W4Et+6cmJq6yR+Bq3eZFEOyx4pvMCqnOx2wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344739; c=relaxed/simple;
	bh=/jdXWcKOPDVhf3ZnZSpFiLBd7F4tatN/QpSM/H6akfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEaAJquF/hosMK6J877DB3q1MI4YwKOys3v/ucvNMajFxnmKlU/jPl/zHSLk59MfnqbNlLK41/lsSyyKOA7xPW7R6dPHKeFqFHxHpdUE7Ty0gvwzV8VYG/0cjfmlzCOswb+45FaKZ+TJEqb82blqQVFO0lAkIR+E/QBBQStxXbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=EO/+86Fl; arc=fail smtp.client-ip=52.101.70.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EO/+86Fl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzvAnMduCyIlj3tCLyqaA+5P3CJEEmLpPVLDyd0799DjjKE0Y74ZcwhfQjEFCczaLimFAZFytUs/t0NOqht+KpKFhmAbv+iddvq82/4/uvr7t766UWf8G3TktGdQq0t3tTSAsJUcqp8dC0LJkfGYsAzCxBr0eHzIlk9WnYUFwvFrY7MNR7ZQnx7HPZkr7Op7uyCgnik98SiwgUnB4Osf8kLl0YkeiR7YxLlxwFv311vu11PgBgBgExM/z5dRagb5yLJI/d2OfZ0sBMVs9MSE/xiAxnUYOpxazgnPhh1hnAj3boEdK32X8oNWssclj1PJHoe042HpKrILDWV7A9aQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+3V1RzvI/U3lGPCezaCCrmI1fAfY3sOon3iF0f1+ko=;
 b=fe3NjDJiN0loa79JeVddUP9UgLJxpH8hER+uNoPpDbfQzVSNpLyiR+CnbCQhAKdJ/3Z0yqwzm9dgh00OYzn0Kqfd4qBtSVsC4AhlDpikBvDW6cIFsLMWQmzgOsxp7BmKKxZONakPmOakgGTF6uO6U+5PYSsJRr+tCNU+Y8cHn2gmeE5E73E5EH+EsIoo2vJJhyqLhtWOzaOMUXlQ2J9tB151uVORUt8/yFM/2tNzVan5chS6xPYfI+cEoAH/smxYMiZ2l3Cu3j4G+R2oZOk6ftcMOWtixlMEG6wv3qxL7X7s7y6ZCFrk+zXlllv0vUdV+5Q9saJsFQs3P6TsJLZEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+3V1RzvI/U3lGPCezaCCrmI1fAfY3sOon3iF0f1+ko=;
 b=EO/+86Fl+dHE3ikvBda7iFSUCkqjMRCufYP59eURq7sEAZ1zZsOINStZV7PnXR19MzgRKhxCPtMm/HB3Y2ihalggj0EEDEMfJwA96mJTujb5rFl3AXleQBHRQ6XwTsc9zlJG5L4I9Mufyk9B1UqtNiTs6DHp9+9m8I33Sh+ePLM0qwhZStuj31eL5lqbhJf/C3Htv/nZg4lmaC5tiyCl5qpff5dO9yLL8QPVDfYXGoCU0KZ2v6gCt7YZWrGxw71O/22DaWSJlFSvruDA/2UlbW+3Yddj0vcoCpb/D2irr8gaH2AXTokou5pwuaza2hHoeteEvPzxTsjP8CglloZqRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9847.eurprd08.prod.outlook.com
 (2603:10a6:10:444::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 17:05:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 17:05:33 +0000
Message-ID: <a33c24b3-72e5-4329-834a-e3890331d1a5@virtuozzo.com>
Date: Wed, 29 Jul 2026 20:05:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>
 <amow-BG29pG3eSCd@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <amow-BG29pG3eSCd@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0140.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:359::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9847:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e94213-3060-4f4e-7f52-08deed939a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0egU69BxOJj1ZG6LCcVKuRU5HHxbNSwhMNzTSMnVixEpGZf7vO+kwxZVU+hENf0LYoel5M+3O+lWzYC90VFa2k9eGd+IHDxxOVjOIOMgZr7kB4RBvrVX2APxGXwwygQ9AJv5woRF8Wo/efZR0CWEbLSSXBHPnuSC7qdcFxqh0h/jn9m5AOWx/oXlwcBr/8LuyYmNqdBdu7rAlvGjIbsvI75f7bXXFB+2iMWJ0YcEjEPDLs+NzOacup8pv8XjzLDqumZtP9vRWtKa078wr63iSY5grAS7aHjNwGhGbhYY7ZzDEOlEFZ5EjP1VeacgXvv7b7HxcZs+O3ObyZgbdCgGIspSzfrXil9KISec6qfXW1Ff0prWGughqc9RJJwjJ95IturRQcFpbl1SBgQtCw/cKlo6wBbMnzi1CYFNXAtXkr2UcyDXPJEwfJ0Va+wptSmuPUWX08cKvc0pZzNfERQOekRpib44Mq+bQwxJunA93syi30xgF6YOnnR2JWjLxlfEVJfW4NRc0xnNJ4/yNi7QgWHsvZU6tBnv1EmMdfQEN6KzfErmFJhgQpp7Fk9GUe2hhjRoXqKII8vfSB/lTS4dLOgBReNBmdUMcNHZGwDWuXPygGCjw2f6p8Gs84dHJHc6Kr2TKlX7NyJhTj0UELH/xeDAAC+NV7quvxPMqqqmDrk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emdTUi9FaGdSbEdYTVhDQWFNekRtL1dKSy91SWpRR01LdnpOUEpWNjRmc2Zl?=
 =?utf-8?B?N0NBU2JaV0VYWUQ0V1Q3aWZRMU5jbGR5b1o2MkdRUTFWcUpEU3Z6eDVHOWpE?=
 =?utf-8?B?SWFUaGVuZ1ZoNEk5ZHFQYUZ4Q3UremZpSUk3K0Jjaks0OXo5SHoxTjlRT1Fl?=
 =?utf-8?B?QnJ5VHBjMk9qOFdPTjZ2T0djTHlua3NkZFBDdjFDN0kxaEQ5TVpiZFlsQnB1?=
 =?utf-8?B?N21RZ0hCd2RibUlCVWdqNjRsU0hxd082S1FENnpWWkpIN2laM2VCYi9OU2xS?=
 =?utf-8?B?NkpKWVZSbmhBalFCYkYvMUN2UGRzTVpmOVM1WVVocGV2UjBsT0c1NUNzWHBu?=
 =?utf-8?B?Z09GcWo4SENiR0NaSzVjd0p2TklLVnl2amRkRlR3aXh2WDd4K3RNdVRUOVhX?=
 =?utf-8?B?NUluTmN1SGFDVFIwNVZ2ZDRINmtQTXBnVE1xRXA0dmNwOWJrYUxQMDlsVUlp?=
 =?utf-8?B?WmcrbTJMcjl1YmJNbWc3anlUV0JyWGdIL3VmOTVUektKdmovSW9ZRXcrNlla?=
 =?utf-8?B?R014MWxVaUFwMGhKaDYwVFl1VGNpdGZIbEMwZmV3NDkzVmUvZjVFV3Q3bHVE?=
 =?utf-8?B?Nm03MVhiYWUrVTJQL3ExL29YWWxyZ084MEtuVk5QOVEvaEpyVnU2NGkrMWpF?=
 =?utf-8?B?S0FTUnRxQkpWVUUzR2ZjQ1lFbmsreWk0WXQ1L05tM1hRbWp1VDJvVDRGaWNs?=
 =?utf-8?B?YmtIU3NhYThMUk05ZElVM2dySzJTdkZTcEo5V21RbEM0NUdYQzBCYlpQdDY2?=
 =?utf-8?B?SmVMcks1dUlxM0M0aCtoRE9vUnlTV3VjS3IvMXkwQWY5UExES0d2RXpUUzl6?=
 =?utf-8?B?SHE5eHd3TVNXT0NheVhuaHlydys2UTRLZmxnZC96NEY3RW56d1p0R3RiWjAv?=
 =?utf-8?B?TXBlMUxKMWhkc3ZWMWpISXp4ays5d3R2UCs4eURZUkNZclVOd0tLNXBod1Yv?=
 =?utf-8?B?OWF5WDhPcFFXbzZ2bUJVeXU2aUlSNzNLREpDTHZmYTY1K3lYWHBSL2EwZFFS?=
 =?utf-8?B?ZjBsenhRa1gxRjRUeS82UjRpc2tQUVRVVFVSaWlLMkZQR09qSVNvSUlEYk1J?=
 =?utf-8?B?cFJxMUNCSC9WY2pEQ2tLQW9tREdGT3EyREY0ZWZQbzByZ3NtSXgvckY0Y0Rs?=
 =?utf-8?B?ZkovcGllZ1M4bFE5QndQY3JacXRJMnNhZXA4bEU1V1BpbnlwZmptTkdIc0Fo?=
 =?utf-8?B?OWxET0dtdTZucERFZlcxY0V2YTJkb0paVjJ2TVF0RHdXbXR2NGYrYkpPY04y?=
 =?utf-8?B?YlBaaVpvTHI2ZS84UVI0ZFdWWDY3dDZkTEtqMHdvTFU4VUp2bVhFQ0hhN2lQ?=
 =?utf-8?B?cTNNaU4yZ2NkVTU5ZitmMTM2Kzd1YkJGRGs5RW5KcWFPZWdaTjh3Vnd6QVF6?=
 =?utf-8?B?bTBOc2g5a2g3NFlTR1ZURkE0NGdkajVHVFQvY3h2OVVram9VbkxKL0JSY1Ja?=
 =?utf-8?B?OXYwWmRjb2w5MzhtSDg5V0FLd1NTUWw4RGJ3YmNDRXdrNXhMbzRSSjlYb3o5?=
 =?utf-8?B?N1VDMW1uMDc3MFZWazJsOW02Tkd0ZHJkZ0dNZS82MlJORmhXeHJ3Q1F6MGVv?=
 =?utf-8?B?THN1MERHWUt1cEk3U1laeXhEQ1RvRHFOcDFTZ1JUdUJJMm1ndS82cTVaSzJj?=
 =?utf-8?B?NWY1QmdyK0ljUGFSbDd4Skh2bHZadUNPNU9ya2dPZUFzb1FoN2NSb3FMUkZn?=
 =?utf-8?B?UmZIc0pIeWV4V2dackRhbkM1N1gvWVArR1BQTDg0cDRRU21FZHp1RWtzWnRh?=
 =?utf-8?B?VkJWNWtjZjdEQU9vd0JTZUV4ZXIyYlN4MzA3TXlPSjZPS1JMNGZsVHVqTVhX?=
 =?utf-8?B?SGFnREdHSk5RMkd5U0lMQVBFdEJuMVlla1AzbEFFYU5VOUFUNy8wQlVFSmwr?=
 =?utf-8?B?dm54N0VUampXc3FXYUhnVHhnSVBVekF6bGo2d0wrd2pKMno5WWRidnZkdllJ?=
 =?utf-8?B?YTFDQlFFTGgyN1pFQ2Fya2dpK01EK0FBNDQ3QmNtRktBYlFEZHkzQkExK2Ux?=
 =?utf-8?B?Z3FQZ2VTRWlaREVOV1FENUcxb29SNmR5RUYrMENFMFVkM1FuOFpFRHU4YmZE?=
 =?utf-8?B?eGZraURjNzN0czg0SzBsNlA4TlZrN1VxUFJKanFEa2lTeXNOdTJJYXFSMlpC?=
 =?utf-8?B?aE1Zcng0N3diVzRObXRqMUdYT2pXcnRpRGtJZUh3SThqdUtwMlpBdUZSOWRW?=
 =?utf-8?B?MWZMUmN2aERoYUVXejNWZGhWUithMjRoNGx6OEZaU2ZSNk1GYmsxTFFzTDF1?=
 =?utf-8?B?UGwrUUxCeU5STlBqaXZqMXFuNlJZcHMyRGYvc3hZQi9jQ01Wd1dUNkdTU2la?=
 =?utf-8?B?eU9iSHJBNWdmdGJuU0lMajBhdUl4amx0dmw1NzMzbEtIK3pYaEc5emZIVjk3?=
 =?utf-8?Q?QanUh7cdKMSBiPFc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e94213-3060-4f4e-7f52-08deed939a19
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:05:33.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19E67fDVV/Ytb8Gf1Ei3jq6tusHGAt8Me/DCtKblXXXvgvzSs6pZuEWj2rt7OEmI0xd434BvRTXOvZ6eXSxbRuRlTayLLLo+lW6e4g3eQrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9847

On 7/29/26 7:57 PM, Stefano Garzarella wrote:
> On Fri, Jul 24, 2026 at 02:45:42PM +0300, Andrey Drobyshev wrote:
>> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>
>> This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>> the guest with vhost-vsock device.  For this to work, we need to reset
>> the device ownership on the source side by calling RESET_OWNER, and then
>> claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>> AF_VSOCK connection while this happens.
>>
>> To that end, unlike the release path, RESET_OWNER keeps the guest CID
>> hashed: established connections survive, and host sends issued while
>> the device is between owners simply stay on send_pkt_queue until the
>> next device start drains them.
>>
>> Since the device stays reachable through the CID hash, the lockless
>> send/cancel paths can race with the worker teardown in
>> vhost_workers_free().  The previous commit ("vhost: synchronize with
>> RCU readers when freeing workers") makes that safe.
>>
>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> drivers/vhost/vsock.c | 32 ++++++++++++++++++++++++++++++++
>> 1 file changed, 32 insertions(+)
> 
> I thought I had already reviewed this, but anyway:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 

I explicitly dropped your R-b since the logic was slightly altered as
noted in the cover letter:

Patch 5: add 'sync' param to vhost_dev_reset_owner() call.

Thank you,
Andrey
