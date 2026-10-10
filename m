Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA03630B0
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617830; cv=fail; b=gI739ebzisNKPQF3bPrzUgiBbXKM1EesQggUcNjhU1yohH37ltCVgc39AO//2wsa+a8BGlabkRVuW0LM16YOzWCN/l4sZMSaT/oYdAHtrArAGZW2qOIxzAK0u8IYxmD+C+MvM0stzbyUzFbrYObjf+BJMPIgb9WU2fCV0ydUxxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617830; c=relaxed/simple;
	bh=NWzt/wyJSs/F+r4tbuxnQBOyYbldVhCDTt+gpSyfpuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E42o5Oj1vE0XacqJs78FxRRhXQap1LNUSLpwhbIHNMmR0S7wWowTJXDn7N+qjZ/ULWDAugZeSmt3aXBS6tAzQ9Yiwg5mksxS3+YEwODzqdo7mLewetCKKmmvZ0RU2cgyk+MVhVMYgG/OyLOQKYj1MJE/OF0g8KZxc9IeSUSR2qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svkhDxSw; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svkhDxSw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiynAwJdLWrvJ868MuzELiUsGT8VR30Bu1nDTYWRYH5iParFf31nNJRJ00lDNVKwWV2+IBlJP4e7KV2vZdk5p6WF9K/lrtuxp4e3H5LHfCIF0MpLwmtbVJUhg/x7b/h9LEG2TjyL56Bfh2ZGrD7HD6+xr/F1GeUTvejE5/uiOL9whRzEm5U5cyxSZKqmdYnAxbv5WyYkaMxCRzRlNcufp4RrXw2gb+V2yzv7pYLfraok8lG64wg5aOK4ZPRIOV3csAURbrHRWBI010vFZN6AOvtgA6oWoxcFPeYHaHOdRofbzut1Ab11wQYy0rNXzRD6O8E89r/MGCSdEFrOSaqW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuSXVrJeC/D4Ih8/nUlqpqX2jdz7Zc/ANsKREwH7ysI=;
 b=pyPSEzgIPBwjLFWNy2+fx1lUVZSAoxY2AIWgWRihPM9OoFtChReaJwfBI2zwxjQV0vaEo1wtT2yLqwmNJznMczHuyv+/Ua9mnlUtZZnfQis1TwmNHcPvRNkZV2nLQ8PlRpl75kZnJNbLVZ3T7kMul5EF9twFFjBzbOVCzXz3YvOkNCq/I6ki4SDJncgItyxMQBn54XOdKfrlXGfFPGj4UwaK6fxSze5EZVOb8WVS3n0ft2p9y3inOvHvzDWjrNlu3BjpGE4yyri8Mc5zjYjeRmX4lTuHAvXPyjXnCI6porKqyJ2Ko8OHiNKzoAU5Z7hFjPC66mlkd7ZsJC3YpR3lBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuSXVrJeC/D4Ih8/nUlqpqX2jdz7Zc/ANsKREwH7ysI=;
 b=svkhDxSwPLKRC4N7gi+RsIjUS5QmK1aPOVhd6cHP3FInyozg+73Qo0u2gWb+wIuhYP1vRGGdagxkwOXFK1Q0V130T/80xOnKiV7JAQVkrCZbffaZyPMcbnU3kI5SpUHLjsC66TAcUHJnHb+vp0R11cpGb8dArlGJqtsc6ub6aLc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 07:37:05 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0496.010; Sat, 10 Oct 2026
 07:37:04 +0000
Message-ID: <f1437a1e-387c-4eac-a5dd-e1fe42a444ff@amd.com>
Date: Sat, 10 Oct 2026 15:36:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <f2e66335-5538-442f-80ad-94626a66b4d0@collabora.com>
 <f0c5d61a-d4bd-4f92-aba9-50c67cef74c6@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <f0c5d61a-d4bd-4f92-aba9-50c67cef74c6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9e334c-91fe-43bb-85f7-08df26a147c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	FsxDwyDDoLHDSYEiDa3xa1fUP2yrdHbntiICDCGQf2nU2TNdKXXlJE2Aa8W+wBsTtrcKLbnh5rrFcR6BH4f34a6JQc++S4CTs4KApLB1ZA+Ttno8VDnj7sWWpjq/QG3z9hA60yjdlpOg5F4DFfWPbA+wezEHMtPfog4jUt3LMdE+C2SSAdb02KejHjvTC61gtmT6tzuF+hhYWj+6FgzjkbdJyu5ISlZMtdQNqhaSjHQhi0zIxhmivQvcp/g+GU0RXF5VYVHRrEwi2Bd5UxOcUG6rLjpG0yRHbNIHW7jScnB/IcZXfIvRezzK0yWn38fgr+yRbs2rifwOrKm/6+oz19CeqzvrPIBfUw0MarvXiJTc2mCysY2Wfc+N1lTkij8uLH6+xUUQYw3J6rIWK7ZaOM/MphC3A73ugJMh7aal1/wPROo8NGwQpKfZ/Z6gKrjom479hMBhz46eubqOUiL7l4DPxwx7uvBG8a7VXsH4m16LxDbXVe6Nyznjw0phcnr4vY+3INBgsT3+LHc5kM+X3yM40CPPujCbUjyl7LNI49YMx/BikCVZOxmaI9YAVOr11F94fp4+dGjBTE+22QhyteYrNbG81ZrRQVBztpQjsbBGnQuoxx5l9Yo/2nG8uXFWfiEsC8nPj4kgMQ2XVbrdgf1rCQoIlB2bZwyQvGe75Tc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjl4cnZVNGxyVW4vT3JOcnkwV0lvSm1YOThNSXhiVGFWai8yR3I1SEMyb0dM?=
 =?utf-8?B?ZDdzRTczd2hzK29NVnpiRHBrKytRcXhpMWoveEl6RUR4QUlIdUs4Vmg5dmJI?=
 =?utf-8?B?cWtwc25QMXZUYnN5SHJSd0dTZURhV3VJWlM5cmpKd1N2dThrZ0xxTVJwYzQx?=
 =?utf-8?B?U2Y4RmcwZ3BtK2xCclVXU3pZTzBNMVpoQU1iMytQQzBUbUpFaXJURjhYOHE0?=
 =?utf-8?B?Slk3UXpGbEhSdkRjSFdNU0VMNUdXRDFZS1ovQTJuUE1OejZDUUEwZFVyMnJK?=
 =?utf-8?B?NGJBUUhEQlBmUmRZUVVYZmNDMXRlVDJrRnh3V0tHbEd0ejVTYjJxWkJ3dmJo?=
 =?utf-8?B?Zkd3cVZQOXJTZ0M0TXZJOVFnMndJVTZSYlRaTGJEYlFDclp2czRGcFg0bjlC?=
 =?utf-8?B?a1E3WlJ3TzJFOUpyT0M2SUZpUUZaTkJDelkxWnNiaStPOFdEWnpzWW45QXhC?=
 =?utf-8?B?Q09obEJKaFdPcXNma3djNzNqV2k3UDBteUdFdlhaM21zcUFRTEVYS2ZydHU1?=
 =?utf-8?B?QzZnQzBWOVBuZkI3K3RJUkNNa1JJQ1RTa1VVRFUxSko3aTNMeFVuZGNEZmwy?=
 =?utf-8?B?dXhvbGtyZ3JLQVhRMXhiVS9Ec3lkQlNuU21ZeWdQZ0ZmUHNNcWQ5eFpZVmNO?=
 =?utf-8?B?RTY0MnlWdkhIeHFVdUd4Lyt2cGc1NjZQSi9sRzYrZHFCMWxzVW8wK0Roekcw?=
 =?utf-8?B?RzlHVFhKNHF5NUd0akJLSjZvS2tSbkxxbUE1bTFKaWJuRVpCQ05HL3dUcGw2?=
 =?utf-8?B?TXV0WGloRHBvQXZPRGg0UjQ5TUhvQTdyZHc4VkhLWTBLd0pzWHVXWTBJeFcz?=
 =?utf-8?B?bGhnSlhPYTNLZm5ORkdIdE4zNnRKbk9HL1RobVJmK1JCMEttY1F0Y3NFYThC?=
 =?utf-8?B?M0Nud0tlLzl4ZE9FTng0TXAxWmFOOXExYzhDcWxNQmVKUkQ5RWVzT3pSNjFk?=
 =?utf-8?B?aXptMC9ybkNsWklFSUNjcjVZZklaelpBMXhORUVwZ1cwNGNaNFNEcmRXNUFv?=
 =?utf-8?B?WDlPaDF0WVpsM3ZXMERDZTBlSXBGYWZqMmROdzVOM3ZoSUk2OXlOZXZLSjFF?=
 =?utf-8?B?czExMXFmZWtQMFovVXZMK3Joa3prb3JCQ3NpRHhGUWEybmZRa3BiQXdzME4v?=
 =?utf-8?B?RjJLUzUvbnIwZTZCcU9paTBNa29BcmxFMFdvTlA3UWRZWXBwbVNqY0RCNE5o?=
 =?utf-8?B?NE5WRlhLMXFnaUpld094aVIvT1JHMGxFb216YkNSVXU1ZFdWNmU2TktuOVl4?=
 =?utf-8?B?citmMEdxSXJDRTdJdWVCSUVZVlFmc2VFOTMrYXRGdk5mY1MzZFpwQTZ1ZTl0?=
 =?utf-8?B?R1ZpaGdleDVVM0JJOHJaRlA2clRtTGFaRGpMN2dsQjhzRUd3UWRTaVhScmVy?=
 =?utf-8?B?NHZyVSsrNXcrdHpjRlNYdXJGblZHWEwvZ3FFc2R5NjVXQ3g0YzFYeVgxWHpt?=
 =?utf-8?B?MlhBamRIL3d3UEdwTGZzRHBLdUk5MXBXOEFYZmZ0VEtWSXhkcWMzMjlKbDRq?=
 =?utf-8?B?d1NrOW50d3FXMEpjMDE4SjAvdkEzMEhCN1ZNQm1pSHpBTTBpMVVxWEVWU2JY?=
 =?utf-8?B?VFVkQ1l1Y3ZDTE0zRk9CREI2NjhJN0pYOWxLR3pJWnRGNmIyc2tUbXpnUVpZ?=
 =?utf-8?B?TlhFeHFvdFI5M011UmdPVThtVGVtWmFmV2lHdWJ6cDFGYWpnL3dpV2RQWkJR?=
 =?utf-8?B?TGRPNTlEUHpqeTltRmsreVhPRUowUVlnZ0RxWDBERktuc1k1OGttenltMnh1?=
 =?utf-8?B?THZ2eXZWREh1bm9wVGVFQitnWXMwczByRC84T2NycWwveGpZd21pUkcyaVVZ?=
 =?utf-8?B?MUZ6T1JnWTl4emZmeWFQWm92MHlJSUFrUjl0L1E0aUVDcWFVcUF5RGNmQ0R6?=
 =?utf-8?B?NWVZcWhuQkNlQ2pMTGZjV0IwSlZRYTYyclEwc1NvNWdlQ3hNVlY4bTJUcW5l?=
 =?utf-8?B?YWNVbXU3Uy9tOUM5dDZ3Zm52dVFJeTdtZUcxRk9VWEZEaUh5QllrZWNMSVds?=
 =?utf-8?B?cnhaY2Z5eDFJa09sUVhLOGxKM1d2VEt3N0NJWko4eFk4OFlqSm5GS2N2dEdY?=
 =?utf-8?B?YktiVWFjdm1sTlZERkF2ejExMjc4bmZMVmRnOW53bnE3VWp5VXdybVA1Q2Fx?=
 =?utf-8?B?eTVjZU14V3hNUmNlTWxYR1luSWczdmVpWEMrTm1WcVpKcG1sUHVHOGVwR2JZ?=
 =?utf-8?B?bmhPVStiakxxS081T2xhTDFnRDl0WHR4TkM2VUJLRzBwa2Uyd3RRWktaL2RD?=
 =?utf-8?B?b1QrSVhMSTZzaC9DK3lhaDFmcVUyd3ExYlNaUFBVeXBJeUNMVUZQTUsrY1dH?=
 =?utf-8?Q?AJnD5AM6lRIvQJQtjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9e334c-91fe-43bb-85f7-08df26a147c6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 07:37:04.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COiaj4hdSD9TxJldpRcqtF5CcMp3qnay0ugJ+cgReswsJDAyChTF8yH+QDKamzkDaaEx9MqIXzkYp2gSaZLskg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042



On 10/10/2026 2:46 AM, Dmitry Osipenko wrote:
> 09.10.2026 21:38, Dmitry Osipenko пишет:
>> 24.09.2026 12:55, Honglei Huang пишет:
>>> +	mm = current->mm;
>>> +	mmgrab(mm);
>>> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>>> +	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
>>> +	if (new_pinned < 0 ||
>>> +	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
>>> +		atomic64_sub(userptr->npages, &mm->pinned_vm)
>>
>> At a quick glance over other kernel code touching pinned_vm, nobody else
>> check for new_pinned < 0 and then doing atomic64_sub() for the negative
>> value will be incorrect.
> Though no, negative will restore pinned_vm. Still neg looks confusing
> and shouldn't be needed as such overflow shouldn't be possible.
> 


Got it will remove this check in next version

Regards,
Honglei
