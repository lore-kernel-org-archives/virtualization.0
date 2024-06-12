Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF222094
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210136; cv=fail; b=eOXTbbfP5fkAmKlmFGJJrxGdOyIJCSaqZ4OeCbgKdcDeunIPZjsEYDTMR7lLA6IGXinB59AoTh/PLERoS29IyTy4BlrxXDOKId+/PDR4WAgxSCMHOdU7yloYmc+xAtqjqSyPLTa/BbrFWAeROZ+mfEcoDjjWHD+PCt96aTJVwPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210136; c=relaxed/simple;
	bh=iWo3ut0MxxvA9RCcOHJWgBx8JtlsKmSKcE+9H4n6Plw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1FUDn7DYX08C01sjz+iLzIKh1vGsYjGEQPzJUJhZbuuTfV43cu7kdAAtdtV8dBPKDAjxAjIypC+cWhlzGYmqM0vdf4tjw5Cdc4TemOBGySJO3xbD/jNFVi1khxxcTsGeOsTF/as/wIcjlruav+sryEsgSDHqB1t+JsXkcYaNDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Jj3mihP3; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Jj3mihP3"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B8CA4038C
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 16:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsFSoJjsSVM6 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 16:35:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2405::700; helo=nam02-dm3-obe.outbound.protection.outlook.com; envelope-from=doug.miller@cornelisnetworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6751140363
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6751140363
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.a=rsa-sha256 header.s=selector1 header.b=Jj3mihP3
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:2405::700])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6751140363
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 16:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfPFEuVSsGkwFvBPKswtkLC4Y3CkJ6JWXkJcTgyJ5/67dEbLPjmN68cIdpjEcLLwctNxkHD0z6LWVLLBgHMADY7teiIc6mGs58b7fMYeCtWQg68QC4Q6FOmBvCN3WluAeWmsH2vc+1YKhRvkIxWl8kDhJkJdYBcc9amdVtaDo7mKFmrSiDj49rJhs4Q+0MGXhpPOlO9wAxtkJjtJtoga78Qhz27fL6gMsWjcltZrPsP9gTYr+VKQrHaFZ7MtE9fPoCQ1/DsnSa23+hYh2P0/PaHTxXTwTj839rRs69FVOYyHYSpG4UzaN7TSwVDnh8ueU56avdrnnXNVo1yOqcG8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWo3ut0MxxvA9RCcOHJWgBx8JtlsKmSKcE+9H4n6Plw=;
 b=Q0hhQDWMNo60mQcdrAJObVD60atlQtxyH9H40oViniRUZcAzN2hsTBGgkIUOGYs+viaFbLdjomMcWw4hwek+u5O6WDiCsi4IGowHyNY2XjNXuX5W43wKiTkYUzEqd+W6RiIH/hzecqexXqpGuraNq49+dsp/MtRjUmDYoeIX3NmLebASpVNIvg/bnBiAAjsGi7FXBd7/IRtMIwtadAQbOxrU6wZki+r9dj4emSRWGI4rYcSCeC3TpG/iQVQgZsad1smjDEN8PBJkgkd9Of29eo6MJQdVqGlTYZB1nogonCx/yYC3Of2RiQGG0UV8RwfnG1lQZjyF8NxjzE99cY8Xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWo3ut0MxxvA9RCcOHJWgBx8JtlsKmSKcE+9H4n6Plw=;
 b=Jj3mihP3Xyv57J3x6NlgFMOwxrMmSmACCPTQHqP6cX1LTta7IRI50DjuFnlX3AgG/c1DrMSPKxgV1dD1oPiwlZVGeRr8q3eoIMwvcSox7aKyJsWa1u46aWzlfcYE/I2OwpWRag1WNhI/k588UMvASYgwM3PkPemxs02z4CGRpPUz5OVN5wKbwRIFvnErfQ7RBUM88YpaysTH+Y9Xy8NNXHY4go3PsXzqXSUuVAE5gIXqZ0QfuWJ+nXZaKvUg8oxEMRTr4Y/VGiFcJdFR5ol8OiGi2USAGcvgxO98g+u7a1e4loEBgXjKCGrWAgQiFxKfyiJVzRSG5Ff17D58QrOqYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM8PR01MB6901.prod.exchangelabs.com (2603:10b6:8:12::10) by
 LV8PR01MB8549.prod.exchangelabs.com (2603:10b6:408:18d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Wed, 12 Jun 2024 16:35:27 +0000
Received: from DM8PR01MB6901.prod.exchangelabs.com
 ([fe80::7850:2655:cfde:c9e0]) by DM8PR01MB6901.prod.exchangelabs.com
 ([fe80::7850:2655:cfde:c9e0%6]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 16:35:26 +0000
Message-ID: <eab4e459-b1d2-4522-98b0-0b8b1edd81d7@cornelisnetworks.com>
Date: Wed, 12 Jun 2024 11:35:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Looking for guidance on using virtqueues and virtio devices
From: Doug Miller <doug.miller@cornelisnetworks.com>
To: virtualization@lists.linux-foundation.org
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <4c719bee-b0f1-4320-86dc-c2be08f236a1@cornelisnetworks.com>
Content-Language: en-US
In-Reply-To: <4c719bee-b0f1-4320-86dc-c2be08f236a1@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::20) To DM8PR01MB6901.prod.exchangelabs.com
 (2603:10b6:8:12::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6901:EE_|LV8PR01MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0a7938-7f47-4fe1-bec5-08dc8afdaa0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDJrWFlUak1CWm9aczlWQnBvTmhQR0NwVEtqcDlCZllwZ3pvTTgrQXFmVk1L?=
 =?utf-8?B?dU5MQmhOV0ozVU5sMGdVY0pwQjFkN0RrZDVRbm1xM1UrOHovYVFxdVM3Sm42?=
 =?utf-8?B?WEF6cnBTM05oT3R6NmhsR3dxenZMVXZUWVNuL2VtZ1I5UURqL0ZlYmFDanR6?=
 =?utf-8?B?RHRqeGFtOHFRUGVYQmdxb3FoL2RqeGt1Mkw3cFZBL05NQzZyNURmOUxhUDla?=
 =?utf-8?B?MkswRlg4dXRZdEJhdFEwSjgwZnJ4SzE3a25NV2lPWldTcjJmRG05bVJybUdT?=
 =?utf-8?B?Z0VEekU2V1ZNaG50MFhDd0phelN5M1hXY0pmcU5mWGdIUGZ0U2Z6aTRoZ1RB?=
 =?utf-8?B?WEc4b2dnenJjcm1YNEExT0pJakp2b3hrQlpkTjdRNU8rd01zMWJ6OXFiN3N0?=
 =?utf-8?B?ZDBMSC9LNUoxQURwaEhSRUxjUzQwbGxveE92cWYzQVhsSWZWTHg4UFJrNS95?=
 =?utf-8?B?Y0UwYm5DYUErUERFRTNOeXczWG5RWFQ2NjVQbjBMQ0NHTmg3aWNWTWMvaDZV?=
 =?utf-8?B?SDdmSGFzNi9Dek1LTjdOTkF5b1pJQlVwVjFlQmo2TDJCODBJSGxBejIvQU5P?=
 =?utf-8?B?b29sNDVSWUtPODhVZkdDUTJGM2lUOG5tK2N1QU5vaENydU04THBQM1VoTExq?=
 =?utf-8?B?UmJLR2hRRFhxekkwOHpxb1Jnc2NGb2xLc3RMWDN4Zmh5dGdsYzJoZHBNbHo1?=
 =?utf-8?B?Zi9YR3lmWTBEU1Y5a1U4MXRtMW16RElhYkpaZzF6cDRwZnlJVGpxdmFqeXp6?=
 =?utf-8?B?QmU0NWtoQVZVY1lxZHlpWHBKbXJPY3l6SXFUdGkxeEFEVFllQ04rZHJDYXJU?=
 =?utf-8?B?SUJYbnJRM0pBZmdSbDZGbm51YUZ6VmdvOENlV24zRFFxZW9kOW1mZ0tRR3cr?=
 =?utf-8?B?K0dzeW9OUWJ5ZUszd3BFZlhRUEJ2bVRZd2VXdG85Q2V6VTZOK01uZy9jSWQ0?=
 =?utf-8?B?MHI4cXFqL3dXLzlaUnpYYWJEeDUvZHBnQWNVSGVKNTFKQWphOEZOQ0llWmN5?=
 =?utf-8?B?TGlqdnVGdGJuN2YzOWRCdGxOV1BWVDJ1TTRvWUFGdmdmR2daMVBSR2FaWCth?=
 =?utf-8?B?UTZvVnRpaTd2Nk8rUHdRQUFKdzBRelFvNlE4Y0JnNTFQbkQ1VThRdnNwWjNY?=
 =?utf-8?B?dkJ5Rll5NW9rM1JHOWVZZzlScEpNRUZPM0ZXM0NJVmZaazJLSmNuN1BnU1hL?=
 =?utf-8?B?UXU5cHMyRm81VERiYkprTFZQaWRNbHhEbmxiZnhoSi9CNGM1b1ZrMDcwL1l1?=
 =?utf-8?B?RVlGRDRoUENEa2RVcnArSWY5VjRIZXFBMENFU0Rhc2NFTysyQnFhMVp2cHM5?=
 =?utf-8?B?dzVTY3d1cExNL0ljK2NNWTRJNHFxVmxzdkpmK3Zka08zakdwVkYvMlBsUlFZ?=
 =?utf-8?B?Wm9Sbk1GWUtqRXJEeDV5ZDRQWm4wd3QwM3VhWnU0MTZ3L1U4azRtenljbUpK?=
 =?utf-8?B?TnFpNWdYU0ZxdTkyZ0x3ODFlT01tVFNSWEVaREtMMFpOUEhzY3NFaG1sYldh?=
 =?utf-8?B?bm1KWi91NkJ3V281eHpJUE5DTWxDU0dxbzNaRlFhQ3NIVHp4MkJWWVl4SmhT?=
 =?utf-8?B?N3ZZaW5NeHJLOUJpdkI0dUoxWlltUGdYRHY0dWNzSEZKcjJ1bmhGSlBpVUo2?=
 =?utf-8?B?QlJFcnBkUFNlNnJrSjM2c2hwTjIyV1J1d3NkQUZNdEJiL2ZsU3loYThsRDJE?=
 =?utf-8?B?STJEbURxd09PTEZUcjJWVDVFN1JYcno2c2xCTDRwdTRMcjhHdjZRZkNBTmZ0?=
 =?utf-8?Q?SyjXW6Wqg6kY5hb7kTIrdJXtwu8lzfN1H4ZyTYq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6901.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0hqNUtlaDQvRXhsa3hVOW1hMVAyaE5ITmg1Z0Z5ZXhjZ202T3NRanBtaFZr?=
 =?utf-8?B?R3RVbEhmcGVaRHVaYkhJWDhVSG4wNmdWNytqS0o5REIyZ1JIeFpTZVRZSUxZ?=
 =?utf-8?B?dkZPTDYvekNWQXFYaG1RVk1QWlBPcDlkQ2laUmRnU3AzUzFOUDhNbnNYaUY2?=
 =?utf-8?B?NzlGdnViQzAraUlOdi9EeHZYVnJ6RFVxSWdjbDlDN2Z2VysyRlBDcmpRalI3?=
 =?utf-8?B?bnhka1pjejRJV0JYSFpXWUYvT3Y1QUw0bmVWZVNYMWpBUis5b3pRVGk5enFN?=
 =?utf-8?B?OSsxY2RkWXY4MW1pSEo4UFhlaXl1RjkzUC84KzIxQmh1SFM1NlF3b2hNN1Z6?=
 =?utf-8?B?UE5KQ3poeDE0SThSZWxpeXJtRzNyZ09TMkdtV1NuVDdhckNCeTc5QlF6ZTBx?=
 =?utf-8?B?dk5CUW50QU1HcldVUjRrNWZ4T1RFazQ2WUNMS2NiRE9aYks5b2ZCUDYydGVJ?=
 =?utf-8?B?T2I3NlV2OFpoMWQ4SnlvVkQ4bnJTNzNNc1ZNcnFRL0IrN0Eyc1p2dUJxSUo5?=
 =?utf-8?B?RTdydUpPZUpNQ2dZVGcvMDRXaEZtVEMwNGhkcVhXaXpKTzZBYmFkZFJSU2Rn?=
 =?utf-8?B?Zm1yelF0SmVobnpNWWlXVGsyZ05rc2I5NUw1anJmWWwrdHhZM1B1anBFVnY0?=
 =?utf-8?B?b1Nia0J4eGhkekp3eXgyR240RjlzdEh5VFhLN3dRWlBXNy9KSFRod2ZvU0Qy?=
 =?utf-8?B?aW5kOUVueDBTMU1IMjFUL3dDZmJYbG5DbXhWUDBYN0NLWXZCcEF4WmlPbWp4?=
 =?utf-8?B?M0FhQUcrTC9xTlN2ckNQS2l2S2w4U1RibG1QS016N0F6ZC8wRDZZOW4rVGdh?=
 =?utf-8?B?Q21wZzVGNVMyd212aFF6WjVTMXVLdm9nbUp6a2w3bUpLcExrYUZmZDVqNXJT?=
 =?utf-8?B?c0RSakpXdWZpa0t5M3I2cjRHamVMQlBVMkUvVzBkeXdhU3F4cDB5TTY1NG02?=
 =?utf-8?B?NlY5TVNlQVNBV0NHMmJKd3Z0KzZUWG9FVFd4QW5RS0dBQkZmY3F3U3V6L1dM?=
 =?utf-8?B?TlB2dEwzSzhYUlB2a2d4WXRSQkhrVllIMXhZMm9pQ3JIUGpia2plQklieW9K?=
 =?utf-8?B?TmwwNFJzbWRVY1g0Zit4RGNwZmF4NFVadTNNSUt4Ry9yL20xZGNnWklxZ21N?=
 =?utf-8?B?d0ZtTzJlN3pKRXF0MjVUOTFaaEM3cnFvaE1uOG1YM2JrUWhZcExmaFZ6dlNO?=
 =?utf-8?B?eXdXWEF3eitTeTdqYVo0MDZQSEtSUk9mQy85ZjJFbjdVZFJ1a2pUR2RBakFQ?=
 =?utf-8?B?emlBV2lhTGY1dGJ4Vk9DaTJNZGJMbEVqR2o0MDdJT3A5bVhZdmNua2dNSlF3?=
 =?utf-8?B?bFd5NjYvVWhZWlRaS0FpcFVoS2c0K0ZxQ2JsTm5UeWtBaWk0aUpyRi9GdUhB?=
 =?utf-8?B?K3Z3LzdyNmdZMGJrc05LSzJJZWFlb1MxWUpUVG9ud0ZmQk4vRXU4SjdiTmRo?=
 =?utf-8?B?YzBmckRGUUZYTkQ0T0tUalNRMExGeVlzVXJsSEVQZUl6bHhxUzFlTHpwSERl?=
 =?utf-8?B?MTJ5NGhQRDBpN2VaWS9XVzB2Z1ZCK1MyaFB2Y3p4Vnc2NTVNWUh6b01NMXpN?=
 =?utf-8?B?OHpTMXM3UGdhS0JpMFlsbW5YeGVWMTdvcXhSeVFHZHNCdXdOb3dDMjlFZG5Y?=
 =?utf-8?B?OWd4ZFNkQmNkLzIrVDh4NGtTdFRrdDBoTGdFZ1ArRmtJalNpeCtVUlhuWjdl?=
 =?utf-8?B?RWdvSytiVVN0VURuc2huc1Q1MCt0QS9qTVB3UFhnaGpiVEsyQ252R0VwbDJ4?=
 =?utf-8?B?NlhRTDRacjFtVk4vQU5KMy93YTJ2RG55Q3M3NU9ETDlwYnlBeTYxMlYwRUF6?=
 =?utf-8?B?NnBJMy9QZXNaMFpZK2Q4bTlBWmE3MXgva3pQUkFBSkNJTlc1cE9JNkxvQUVR?=
 =?utf-8?B?dDdMak0yVDg1aFQwOGxHZmNsVVkxUjZlY1oxdkI3K0R6cW9VRFM4T2t0RWFN?=
 =?utf-8?B?WUtkakxCK0V5S1krN3c0OTVGdVZLZEZud0pLYTlleGtzT0paYm1USmcvNmN5?=
 =?utf-8?B?bkc4L0d3aVpWcStxdERyYTRsWmdrZU5pOGYwd1MvbWs4YzNhOE5OaVhPbTdh?=
 =?utf-8?B?S3Z5RUtlUHZGdUNHNGhWM001QUpuTVRjRk4xMVRjNWVERW1VTUR4VkZYcnJ2?=
 =?utf-8?B?VjBMRVIvdjZ5eGRVTTdscUxLVFdrTmZzSVZJVDBCWFFPQUNXU1dVR08wRmpk?=
 =?utf-8?Q?ge9LI1CiZT+pZ3zcmerBYak=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0a7938-7f47-4fe1-bec5-08dc8afdaa0b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6901.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 16:35:26.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grA6P9JxqMG8JHLeEzM+tSroFAgv6Mod6pTpPhbqSdIZNBFVCqfKGTQVWJd2AyYEOFkzH7e9Ade07umYyvn5zqcLjjZMWDRbjQ2PsfyJiJQEL6Iyk1v7Z0EwyvKPioQz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8549

On 6/11/2024 3:41 PM, Doug Miller wrote:
> We are adding support for a new adapter to the hfi1 driver. This new
> adapter supports SR-IOV and we need a way to communicate between VFs
> and PFO. There are some resources that need to be requested from the
> VFs and some notifications needed from PF0 to the VFs. I am looking at
> using virtqueues to allow a VF running in a VM to communicate with PF0
> on the host, but am not sure how virtio devices/drivers should be used
> for this. Is there a general-purpose message-passing virtio device
> that can be used for this? Or do we have to create a new device
> specifically for our driver to use? Or is there some other
> communication mechanism that is better suited for this?
>
> Thanks,
> Doug
>
It looks like rpmsg (over virtio) may be what we're looking for. Is this
the kind of thing rpmsg is suited for? Communication between drivers
running in different "realms"?

External recipient
