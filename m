Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793291985;
	b=3sgu0pqYjkHH/PGaFCWBIRvr9wxhJL41aDPXbZ6xXtR1nej5pVrBq9KWEf7oRrRPRS7e
	 Dti63CG6Im4v6A3/4VzbSlalMLg167MMnqjbcALfSqG+CemYsU2HtTWuHNsInV1qcEDiA
	 STmKF3UUmTWc9fLMmbFBgTBpukS4T9CKAdSq1nrPt8Kbhx4kgU0RClv9xs3lc8Ve42nGb
	 Uk1GxydBpNjgJTXpRudkzznz+QlTpc76hzT/J0ACI26JxDKo0mYIhlnXgx+y9byNH1Wgj
	 9jeInuBnn2S9XToG/Sd/qGaJlkg0So4F/MqpnG4K7h8CrEv41IKJ5OnlbdG0KRb5vow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291985;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UWyYqycZVKNDpPdq0LPTCf1Fqe9kP99q/1k1Y+Cyk+I=;
	b=efSJjaKELQ/OWN0PtfAYykGi+d9eLOrf0xOMpf+kJkJUHtDxHXHoF9HCNvRei4/OaWnW
	 sHkIwBh/dZXNGfxD/YU7wakFZKD7yKdCc1B2t6KBJn3/JBHhlT+ay7rp2UMQknsOj0KZJ
	 4palnpbL5BKLahvWB+flgpdv0pRnuDup8lqRnn/ytuxC51j9BKxIMHXj/ONcM//+m2dlu
	 AkVNV+N5m6DAoaDw3j4TabC/YAAySJulz2VrQLI3kdK4lM5RcPsViUFGTZDStjMJ5E/zN
	 cSUhe6UiNu96T6MELHnzkMf7N4/BSEdKdDJMUHCxaCBA42O+Buw6bDCzXMS07eDe12A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uWcfiJYv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.8
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8706606A31D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8706606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uWcfiJYv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8nI3XzwoSy/qwm/gdGgAKEmAwxcv0lMksvhA9dTsoOHWDuo5hYgJORiJV9YeTr7XxVIuOkAVd1s51oGGLuPCf3V6sjh3RHqDMtWidGOXUgOFNnlF0bKZwUxvetX0gCzL7aDWGEV5CfWu/zd38XqPY4/1uTfwOpfdgdCRoIKxiiJA+nuoDp8jna9gHvvLYZfzOTp8N0fYh3s/+GWfL007OPVAi0CC1oB/OuJhTij9JowOoBgPOe2N21xzAk4N21vtniEczkM8g6n6mLwVVwft3GaHSgsiuBaoDyakFAkUKOZy7fQ73PcFHP8CVOQJF3dXX1CDZItX0op8V2zujq8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWyYqycZVKNDpPdq0LPTCf1Fqe9kP99q/1k1Y+Cyk+I=;
 b=x5HVokzlzDDu24v0ZtbN5mPolkDxVsKw8wFwCA9/iqJ4y1B+LfW22uH95p3V+ZFiPVoz+S8A3Cml7bbpHoAQPQtGeba2xrjYn8qUSRgmVbtaEV/uB6c/wyxXOPf3Eqlp5Oy0ackXpPRdFVX2xbVWTqPGDZDzvxugqtOO99wXQ2czBVEwmM12duTeJo9j4L3iByNX9vepp7kMDCBm3aeqTsA/ICYmw2jwvL1lX5A8I+/LwNynd826RnsSt/tM9SkKGPa5CZyJLXshfHtHpcIhoeN9+vqsdmv+TpcgqPC0jqbCFN0+XP5dCwNmZlagwT4a6suedQNfdu0b1ALqsOwTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWyYqycZVKNDpPdq0LPTCf1Fqe9kP99q/1k1Y+Cyk+I=;
 b=uWcfiJYvoZYbtZy12Dd8uEzTOnTNswk3wiZ7Hbs+xA5CpC401WwIpo/Cd0x/UPmgmVxl/Br/afzy6cKaVbErNp/HpnKOv1D9RrpHUR3va/agN8OZGGR30vG5CL3VvPfCQeivOyqGzyIkCQUsczMpikO5hZqdVsuqr006qFUiy2VKmqUSIM5JoG4vsrNvVNaXB8jb005M8XkXCcKzdKCs8bVxZYjPv2O46Qn0nR0IaqgMnyIH4K+Bde24ScYQwbJhrwqb13MjiEndL+TIVvWI6uwj268n21kU93EvqExkxAgSennygWxRP5blVC6AH49HyOMJIsR4fB8Z/YgPWf6txg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) by
 SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 16:39:39 +0000
Received: from DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f]) by DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:39:39 +0000
Date: Thu, 29 Oct 2026 12:39:37 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, yury.norov@gmail.com,
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
	tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
	seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
	pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v14 04/13] cpumask: Introduce cpu_preferred_mask
Message-ID: <auN2yRZPKKWYk_CP@yury>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-5-sshegde@linux.ibm.com>
 <4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com>
 <auN0GKVMNvXbNdCN@yury>
 <b83e2d2f-681d-4e19-a680-c076493b3edd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83e2d2f-681d-4e19-a680-c076493b3edd@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0255.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::20) To DM3PR12MB9349.namprd12.prod.outlook.com
 (2603:10b6:0:49::12)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9349:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfa84b6-4279-4a29-0059-08df35db39d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|261026135527099003|261026140227099003|11063799006|4143699003|261028144727099003|261026130827099003|10067099003|56012099006|261021130227099003|261022105027099003|261022113327099003|261021135927099003|261021123027099003|261022075727099003|261021133027099003|261022115727099003|261021121427099003|261009223027099003|22082099003|261026121527099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CJnEnkpZazoaAdldqifeQngcZ+7I6rwb50LM4+NGHJNNlFb+ttpKHHkyofmtD+MrZE7kjA5l2RtBfqE4r8ZxxwbISTyZsCROJxESg6G1XlOTn7UdmDk/COGL1Fjfy8U3b72X/T91e8wZIgv5hDz4ugMur3D+GMDUrzpdNChq+dFb9WP9P/bZb3B2hnIfjVUCqBekibug0ZNHsKlXQjpx+fB1CEbgqaw7MHRZd2+Zg1DJbfcNVmRCKXPlEk+vhR2IniLr++CHtORew4iuFpt8YfKpm2HyfBBLPOum7Spbt1MHPlnlmclPRLIhnEeKbVaocAt7QNyDtb8z9nPmsoSDYTezwLKxiE9zbKRTJc79Eff7jK3FPiWZucxV6C/+ldqCqhdNuJCZXeMF3i+cOICzCWhPtzjCZhL7smGtO3HuJgY2Jh1DT3kD5jnj+gfaZcNf3/38kX/o1SO+3VFMCizP/MSTYVqRcjYCf7CokF8m2JtYQGNv4mr2o8L/xCMKarv95PAOQ727lfCPooDCCsHEUndEe4EC6s4mAsMP3GMvoXxxGoQaCpuiCYLcyQJHlegV8uX4MmOjK+kb+hRfcA8wanhCpZm0vWf/aHk8dA2wg9qdlZUysk+oX+vv2dNnbRcE7BOP4YEwQyJRtAbmD/61azjS83akq/D1J1tGFteAE1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(261026135527099003)(261026140227099003)(11063799006)(4143699003)(261028144727099003)(261026130827099003)(10067099003)(56012099006)(261021130227099003)(261022105027099003)(261022113327099003)(261021135927099003)(261021123027099003)(261022075727099003)(261021133027099003)(261022115727099003)(261021121427099003)(261009223027099003)(22082099003)(261026121527099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkhKS1JWVC91WlFHclNRbThITHRwcmprY2U2ZjduaEIrcWVPN1dWUno4R3Jv?=
 =?utf-8?B?bWw1S0cyTGlHOFVvU0NxT0JvT1AreUorN1dvMEd0aXlWb3NNb2NkckdqcFU0?=
 =?utf-8?B?MWUrWGxZU3QzWWo4aTBKTUwreklOT21CMjRza0dDQk1PeDJ3b3J3VnJQcmdt?=
 =?utf-8?B?YlFjZ3JRaVZ6NjNCTVY1Wmk0Uk5CZFdSMG0rYVFwb1B0aFVsZVNmdHV1MEFy?=
 =?utf-8?B?Q2ZuTG11azY5WjBVRFBXbDhPcVlLbUlnWjUrRUY0TnFvdXFMZ0lmNFV4UFdD?=
 =?utf-8?B?MXlud0RtUDZ1cjA3VkJzSS9NWUxXMEsvUmEydVUxMVpzUHhsYnFKMTN0QytF?=
 =?utf-8?B?TCs3TWxXaGhKOTdrUUF6a2NWYk1FOU1DTFQ3aFQzTlFxODd2STY0eHVxSGNl?=
 =?utf-8?B?NllwaFNkNFFsZW9qNzVadkZibE1MTU5DZXBBRHNQazFkYTVqV1k1VGgweTlC?=
 =?utf-8?B?REVxN0hCb1JhaGxiNUJqUGkxVVNWMjd4cC9qcVM1dEo1aDcvQkFJZ2gzNEpl?=
 =?utf-8?B?VUpBRWlNQk1LMXE0MUZVKytjalNBRkZnSnRjaFA1NEJoVTk3c1cxK2VCdDRB?=
 =?utf-8?B?WkY5K1lzanQ2YTRMUjAxc0FEbmYzTWw1TUplKytkZEYxWjJTMzVyWFU0RGw0?=
 =?utf-8?B?eW1LR3BteTM4ZmZTTTVwUmpYSGcrRElVeGtPTUxvUXZUN0x4TkRDMk81Tm1p?=
 =?utf-8?B?SE9uRVhsbjlYeGRSMGNQcXJjdzNFTVU5YzJSbFI3eXRGVlo3cEVyTTBKTXpa?=
 =?utf-8?B?RiszRnpJeWFQUTZQNVhGam1CckV6TjQvZWVFRmtkeGlCcTU5T1F3dVV6SjJV?=
 =?utf-8?B?UHMwODZtNFZnWHR6SU5EMWc4MXFScFRENUl4akhXa3F3K2IvL0lSSitqVHdR?=
 =?utf-8?B?cGpLbjBhVTVVZVlHSWE0TzJGVk5VV1gwWkxkYnoySWNuUmVCVi9FMVVxdzZ0?=
 =?utf-8?B?STNHdW9kR1hvL1d0dE9JOWs4bi9ITTVzWk4xSmNEMFo1QUgyeXpvcHNaV2FY?=
 =?utf-8?B?UGVWdnVyRUJnc1I3dERZcmlkNTR2VWk5Nm0xajVpMElnbThrYW9SMVVGQmk5?=
 =?utf-8?B?UDV5SWdXM3NXQ3BDanhXQjRNVUJZbGRrNnZseGUzM0t0VWVwYlpWTjE4NDNO?=
 =?utf-8?B?VjB3cE9McVd4S04xZWtUbTFxREM5VFFEc2FyaldpUC92eHZYeU92bVVuRFpH?=
 =?utf-8?B?WWhqTFdZUkRaQlZtd0lMK2Q4V2J5MnF0ZHEzWkYzS0MyM1NwSVZRSno0aFpE?=
 =?utf-8?B?d1ArcklOd1IvQVhKL3VXSXQya2t4QU5NT1NaT0lSYThlN1poODRnb1N3WG5D?=
 =?utf-8?B?Z2x0Z3d6aGdaMzBxTGpzUC9remF4RkR4TkJGOFg3WkRLV0VoWVFLM29UZUxP?=
 =?utf-8?B?QjQzcElzZjhCLzhUeG9sYkJHYVNTcE9PbVpBRXZaVlZQUWJmWTN4eFVCbzk1?=
 =?utf-8?B?ZXI3NXhSakZtaFpxQ0dzcHdvMWpsSUpZWHRGTHg2UWlvaUZ3ZmMyM3NqaUxx?=
 =?utf-8?B?MmpwR0ZSY1BRTFNrQS9mK3dyVmxPeUN2U1RXYWxraDRKK2lRYmVRanowbnlJ?=
 =?utf-8?B?QkZuTkU5OGxwdzZIRllpL29qU2lrdHE5N25jSlN3N3RYNkRaeWszRUlqMU02?=
 =?utf-8?B?QkVsVTcxVDcvNTNVci96RjVKdDY1MFpGTjYxZWtjbmZISlJuaVN6NEgzN25U?=
 =?utf-8?B?Q3NtUGxpQ2t3aDIrcWl3QkVsMGRzUGVNbFNra3RjQnhSai85VlV0T1I2L2pu?=
 =?utf-8?B?cGw3clg5RElLOXRBVzVoRElLS05uUnZQejlDSmNVREhEbGhZYkplOFh4eDNG?=
 =?utf-8?B?OGN3QUN0RzJwWGZ0TFUvTGZwbGM2WTdzc0lvTUVJMGp5eGVnTHFCMmVkSnlw?=
 =?utf-8?B?Rm1GcjdWYS9aYk4wRXVkR093WjNDNDVQb0lmQXRmSHMxaEw0UFpWZFdFenUz?=
 =?utf-8?B?Q1JaN3ZoMzBJTVgyd3EvQzRvTGQrVmNjZU41VEpZaHhaZStBeTRZQWpza2R0?=
 =?utf-8?B?NzBwYnptdnQzN2RMREllZWRyODdyUklNYzZJZUlTRm5nS2ppUWtnZzB6emY3?=
 =?utf-8?B?Z1VjVW0yRGp4MURyVkQvL0pTOC9qNFdFZjEzY0JWTlFDWk8xMlB1RkhRNFhS?=
 =?utf-8?B?RGJHRjRPdXA1SjdkUmhnMTVFR2hBTUlsTU1TYmhPbDh2U3YzUUtpZ2M5bitT?=
 =?utf-8?B?dXVOTGhobHJzaDhtcDllalJVWnBPMmFTMHpOQ21uM3lNVVJyeFVLWGtDV0lN?=
 =?utf-8?B?clpnM2VrL2xXUVJVYjhKUThraHR2bFlQa1lMOHNodDRpb1Z2aGpOejMxYmdH?=
 =?utf-8?B?aExGQTYyREV2T2xzVXV4K2w2SGtUZmw4TER2TE9XNVhZSU1iTmJMdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfa84b6-4279-4a29-0059-08df35db39d4
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:39:39.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Td5FHV9oAp2k+7T2uOlHtZSCcaTEFMM9b429QYLK9KLbYi5IVyROTSYgCCzOoWHheWyiYVe40rLLOdyWORW50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697

On Thu, Oct 29, 2026 at 05:36:28PM +0100, Mete Durlu wrote:
> On 29/10/2026 17:28, Yury Norov wrote:
> > On Thu, Oct 29, 2026 at 02:32:08PM +0100, Mete Durlu wrote:
> > > On 28/09/2026 07:37, Shrikanth Hegde wrote:
> > > > Provide the preferred CPU infrastructure. Define get/set macros
> > > > which could be used to get/set CPU state as preferred.
> > > > 
> > > > CONFIG_PREFERRED_CPU will be selected by the driver which handles
> > > > steal time values. It is going to set/clear preferred CPU state.
> > > > This driver will be called steal_governor and it is introduced in
> > > > subsequent patches. It periodically computes the steal ratio and
> > > > decides on preferred CPU state.
> > > > 
> > > > A CPU is set to preferred when it becomes active. Later it may be
> > > > marked as non-preferred depending on steal ratio by the steal_governor.
> > > > 
> > > > Always maintain design construct of preferred is subset of active.
> > > > i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
> > > > 
> > > > With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
> > > > method returns the active state in that case.
> > > > 
> > > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > > ---
> > > >    include/linux/cpumask.h | 24 ++++++++++++++++++++++++
> > > >    kernel/Kconfig.preempt  |  4 ++++
> > > >    kernel/cpu.c            |  6 ++++++
> > > >    kernel/sched/core.c     |  5 +++++
> > > >    4 files changed, 39 insertions(+)
> > > 
> > > [..snip..]
> > > 
> > > >    #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
> > > > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > > > index 985aea617cfe..edc067a0c422 100644
> > > > --- a/kernel/Kconfig.preempt
> > > > +++ b/kernel/Kconfig.preempt
> > > > @@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
> > > >    	  For more information:
> > > >    	    Documentation/scheduler/sched-ext.rst
> > > >    	    https://github.com/sched-ext/scx
> > > > +
> > > > +config PREFERRED_CPU
> > > > +	bool
> > > > +	depends on SMP && PARAVIRT
> > > FWICT, PREFERRED_CPU mechanism can work perfectly fine without PARAVIRT
> > > selected. It would be annoying to enable it and implement a dummy
> > > paravirt_steal_clock() just for that.
> > > 
> > > Shrikanth, would it be possible to drop that dependency?
> > 
> > Do you have a non-paravirt case in mind?
> 
> s390 LPARs are exactly that. s390 does not select PARAVIRT by default
> but enabling PREFERRED_CPU is strongly considered.
> 
> I removed the PARAVIRT dependency and gave the whole thing a quick
> spin. Builds and functions w/o any issues on s390!
> > I'm actually about to submit an RFC that drops the PARAVIRT dependency
> > and provides write access to the preferred mask. But I want to make
> > sure that we need it, and we've got no reasonable mechanism to put
> > unneeded CPUs on idle already.
> 
> You can mention s390 LPARs as valid case on your RFC if need be.

Sure, will do. I'm about submitting this before the end of week; will
add you in CC.

Thanks,
Yury
