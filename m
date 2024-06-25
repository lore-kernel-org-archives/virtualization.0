Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632916C840
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327033; cv=fail; b=k09zPdTYFve8IwnCNbV6eOV9w6UBh4B4fBTPMNmaHXL/Bb0YJC6uvtc/VqVxMWN1jWb1gFPpd38coWaS1KENsjkih2ZG0GCoG+ufXgRcT+CRd4aHiMtdqNm0Sn40jCYA3qfaBxohkkG9fjflEU3KLmD2aBp/Ld5jT3hibE6r1vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327033; c=relaxed/simple;
	bh=bRhTIZPul64+045SPb4oEjUaYIYbtPoy9GinhDQho6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJf4wFqYArM58e8oP5kHmNFoauN1u3FCpKI8Ub3QVG6mDG1mu45EunGoBEOvzPAGN7Hvqbil3d7r6rfWXQzcuvqGGTZSzLMYIHVN2/GKCaCtr2k6Fjqp9OQhKTHst1iNTZEEzkqjxp6H4YZpfZy9Umc4kibIULnz9ZQWQP1N7wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Itr00jD5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Itr00jD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719327032; x=1750863032;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bRhTIZPul64+045SPb4oEjUaYIYbtPoy9GinhDQho6E=;
  b=Itr00jD5MhHXFKu4iy011LzhEG2su55oqRnWM3oBA1iOa7DHVF72GDrt
   7tA7pHCqS706tLcaQOyhdS1V07eL7Jq5l/sC+dcHMhQYQ8GQIu1DBkq3G
   /5C0Knjwm/4uW0VY4r9SujTQhKWwgfRY0ZK2cdszoQ22Zqwq394X4FTTQ
   YcVapEjhAjcO1re16Cf5Sj0ZvLkZhuPYPlq8qcexl+7SwDKjSRav9kLBF
   GosMAbq1UOskIDRALRMewWWDDGXW7vVDbOhDidDrpG9tshJlQqMAP4AyE
   y/bblsTZoQaLjUqXppxy/tP4Olk0ApFq+wurDTLuFBBOK5KdX/L2eWSJ0
   g==;
X-CSE-ConnectionGUID: aHB4LDacQ5KdWgrltk7kKg==
X-CSE-MsgGUID: 16RUl6xSSlir4RrzLo/CXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27485764"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="27485764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:50:31 -0700
X-CSE-ConnectionGUID: qm9rsXUPTuWr8EDhjMD6sQ==
X-CSE-MsgGUID: /SgloaEwQy6c9O5+nPx1gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="74882293"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 07:50:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:50:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:50:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 07:50:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 07:50:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxwthKGHvqCxypYzvZuPWVqYmcynxUH1lxhI5pH+aK49xdA5LTx8K1hwj+B8Wvik0jEfdPGNkaGPOnXGXao8uoxoUYP2piswnb07knQGu8Zz+4akHO70QKzcLz2oZTMmsef0k1ELZn+49rAJ56p4QsZyJVKoVm0HKLPdk+9Pfovww/2caJp+RP1RtorOn363jl7fBrxCvRwkL1VRMX96+IiJ14iSQpz0quSCcBspwUtgTuxgDgZOrIsS3NqdN3hHp4EX612GGu05y5tFVN4MRWDbSWgVVaONNNtn5rFiFiFfreubFT0JZ470q16KaUPNdNWFrcB8zvCmrHN7+MEUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2UmjmLnqv4z1Hh0PtVGhCOAdYfgxZGKpnzZMXZS98M=;
 b=P4eH818qJYsP6oUTXVxEyt9tTfWVLX/d6sylGK7kLKexkxQz7lzwfNAfn0vsObpD5+lVx7ijAV+dxBW4p/z6gFj+Q86HaOCRsM6daTYMOUMKWz7fDvVnJG3Bp9+Z8zwG2B0prkPVGF4ZNWUDO88Tz2Dn6J2xaNz6wuchytX6ja7vLkLddDx6ImZwM724TT/AFUh1FLmNw+Fp+r31d/dSXZR46phPGzPPb4I9fopY9ITWivoMjYwJALp/Daj6qipeYTIqZ+QlrfA+gSWI1zLa9GVK926eAhzFVcwcI2PG6cF19KgNLqwgbl4kIvojJp9MEyKJLfw/QAVsmAMSdrZD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Tue, 25 Jun 2024 14:50:29 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:50:29 +0000
Date: Tue, 25 Jun 2024 22:50:11 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Arnd
 Bergmann" <arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Prem Nath Dey
	<prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZnrZI9MtP8PqZzl/@chenyu5-mobl2>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
 <224793a4-da57-4621-ac29-7eac35c2da08@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <224793a4-da57-4621-ac29-7eac35c2da08@suse.com>
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: a3362b4b-7d7f-41f1-6a82-08dc952627c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlBuREFFYjVqSzdDSkZ4S1BMY2xVeXM2cFhGaDIvdlBtZXVodVVucnBvTWo2?=
 =?utf-8?B?enhVV2FJUWd0MkcxMmdCWW1MN3UzOGpkeEFBWWFVTDZFVGF5MUFXQkVWV1hr?=
 =?utf-8?B?ZEkzSE5OYXdSM1UzalJBRmJ4SW9jOHJVVFdQWkdXTHVjbjAvZHJCZnZiZCta?=
 =?utf-8?B?TVgrTytFNzFlZEFWUmVjTHRDWElPUGxhZXZoTllmdXdoSFI1MzlodkJERWpv?=
 =?utf-8?B?SE1ySUd3bUNMT2c5eUtQeWZGWFhyc2hoNmJFWUU4Rko2alNQSWNuZnZzOFlw?=
 =?utf-8?B?NWN1bjBkS0dzWHVTcWl0c2hXQlFPQjhYV25mR0UwS3AyUVo0OVkrT2Y5UU1h?=
 =?utf-8?B?U21ZTzNPSmhUNnR3N21jRGZwemVIZ2ZPU0p6VUx3emhWVUdDL0ZRKzhwSEtp?=
 =?utf-8?B?NndKYzJpNHAxUXBHVE9iSGN0cE9vTjNIY0ZZNmxkMm8xcFpvOVhudjlzeW1l?=
 =?utf-8?B?WGQ3MWZheTdrcnN4ckpQWk9RaWtDOFV5T1M4aEx3cVRPcEhGemZDNWw1NkFC?=
 =?utf-8?B?ZXVkc3JueG9uQjVnTkZzZ2VhT1l0NkwvVGhRWjB4dS92anp0K2lNVm94bW5O?=
 =?utf-8?B?TUJhRTJmTERGYUJ0OElscExFZ0w0SVNSV0NNYzFnaElGYkMycVUvenQ4UWN4?=
 =?utf-8?B?Y0ZtZnVqbkFSc25qbTBzdW8vY3RKWWhsa3U2S2FNSUVFSUlYV3B6WnVxaXlr?=
 =?utf-8?B?aytWY2ZrQVZpNzAweHVMQkFUdVVtOGpDN3N3em1QUWRUai9EdWJrdHZWVFlJ?=
 =?utf-8?B?NHhvbGJqNGVMTzhXYWZBbjJ3TlgydjJOeVMwLzZNajJuOWdZSVBiWlZlMmVp?=
 =?utf-8?B?bzkyb1hXMDRHN1N6alZsMGZlSVRsR05wZ3YrYzdYSE5mUWQ5dlNucmNad21m?=
 =?utf-8?B?VUtsT2JsNFI2TkVmYXJsZWFmT2hFeXZpMlcyYXZZYkVSMzdyS2ZEU0NIQ253?=
 =?utf-8?B?cEN6dnJZKzYrZWZHZ1dhaHRTeGI4Vk9ha2ZGdjNGUnJ0aXQzRWlXdDZlWkND?=
 =?utf-8?B?WDZRNXJiWkNaTE8xaFMxL1VJdHV6b1pUdlRxVGpjWXErTmlBTisyTldzdGU4?=
 =?utf-8?B?U05NdGZSRGQrcHhXSmlGVDVNU0FVUm16QUZseWpTSzVqdlBPRitHcGRUREpl?=
 =?utf-8?B?Yjc0SEhaVUVhNGRqeHkzSE8wR3VUSnl0RGEzN1ZMZHArNDFVN3grMWFQa3lH?=
 =?utf-8?B?S3JJSHE4d1BqM0lKZUpPcWVleWxzbDB1dEhPLzM4TjVJbEhCTUgxd3NtRGdo?=
 =?utf-8?B?eGYxakxaa3dOamFMeHg1U2RSMWhuMGZSUE9aQ1c1L2ExZEUwc28zYk9mT1Zr?=
 =?utf-8?B?RERUZEZSZHFHamIyU0ZGQlV2RExjbmJmZURrRmpRMmdnQnBDNiszV2xYejhS?=
 =?utf-8?B?d3ZoeVIwZUxMOXZDZlhiYjVtQ2dPdWRlV2ZpSkJnRzdYNmdYUFE1ZHhrTTRj?=
 =?utf-8?B?ZUs3OFd6UUtJa0pweFlxOEhoTUc1cVFGWmh5VlJyQ0lza0g0N3dBMGx1WitY?=
 =?utf-8?B?cTlZYWhYd0xCZCtjSTBNZllqWEYyaXlHRTM3MVNUSFNSS2FsSU5nbFgzc29P?=
 =?utf-8?B?Y1VxamRMUTlleUJHZldLRWhxdytJaDZMTXY5czk5bTZvanN4OWtDQi95WVUw?=
 =?utf-8?B?YWVxbURRNUZ6N0VjYlQrTEJCbTNNUmY5YzBianoySFFHenVxNlgvY0x0Yi9F?=
 =?utf-8?B?Ry9Dd3JFeUNNZndkRzRpNDdWQm5wNWt5TjAzTzJMWjRMa0hJSGFoL2dqTmJj?=
 =?utf-8?Q?fRJX3g92WHOkMrEHNRZ1hHxVF3ozGXLcetJcSn1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNnK0gvSi8wSS9kVTYrVkVjZTZsRHZsSHdULzU5c2pRMWxKak55bzBwTVBI?=
 =?utf-8?B?OHo4SmN1VXpYY1R5ZjhyQmpkeUt6Y2crQkFiMk1nY3lpTzc5QWt0eTJCb29D?=
 =?utf-8?B?bHR1Y1J4TXdKMHp6UDRGN1ZZS1FRcW9CdHptUEZ4N0pIN3JyQWZwN0dHR1k5?=
 =?utf-8?B?c2gzRkN3TlpBWjBHNXRBN0I2dmFObFVKRURKSVliTWxucGprMG1DNUZKTTBo?=
 =?utf-8?B?TTV6aE1rYnBYc1BXY2JyK1lEQXQwMDF4d3Yyby9WQ1pzSUZrZnFMemZiZEYz?=
 =?utf-8?B?ZnVDQThFQXU2SDczSWpqWkM3NDJjR25YVi92NG50VkZQWGdwMHBNcFFaWTR0?=
 =?utf-8?B?eCtNbU5FczlvbGY1NnJDTE9YVVlCVGpjSjNQcGRtK2V3ZDY0Q2M4VGcvdTlw?=
 =?utf-8?B?M08zODJwd2hkTndNNGVhUmxQQUlGSTRwWTZjL2xScEpidjA2WEVtTFZKUFd4?=
 =?utf-8?B?TmxQNU9XOXMzUWpnVS95d2g2TnFPVG9YZENOU2ZvMGFCYm5MVXRyT043elRt?=
 =?utf-8?B?UGZkKy9lM05sTldzKzJCK3UrZ3l6amIzR0pKSm9wQmxRNkkvb2Zldm9aN3JJ?=
 =?utf-8?B?Zk5kakxNa053VzIwNUpFSDBhaDhpUjFBZ2c1SXFkUEI0Z3NkQi82SzRMTm1G?=
 =?utf-8?B?cmxxRFplM0xyeFQ2WVpuQjlDZHMyajFPMmtiMVFJYlZlT0ZqeUN1TnNqWVN2?=
 =?utf-8?B?d2piRS8yMW9KTlk1MkJTeFdJS2tBS3laS1M4ZXp5dXhOUkpzM0FQVDdIamRr?=
 =?utf-8?B?NmJVNjBFNDdXbFhGZlZoclBHVktOSVIvYUMyN0E4SGhlSngxSkFIOXVYYkEr?=
 =?utf-8?B?QnVhVnNWZENaNGNBN28vOVR0c0V2N0lWYWpDa1hZd3NzWlJVRHNmNjQrS0l0?=
 =?utf-8?B?Y0xJdVhQOVROSys1UGlTNDRPRFdnais2di9uc2t1em5IaUVaNXlCTVAvNzlr?=
 =?utf-8?B?bFliUS9GN1ozV2xVMTFHVUdsekRkaWZjSXVHM2pGbVZKLzk4bnp5aXVSbnhn?=
 =?utf-8?B?akZXYnZIZ1VUbEtGdGtDWThMeXl3N3NGcnAvNzR6Z2pCWWo1RWgwaVZNcmhs?=
 =?utf-8?B?S2NQZ1hxaXd4Y1pvL3JRb05CbzNtWkIxSHQ4Nzl5ZFM5ZHZOV3NxRVdkdkZH?=
 =?utf-8?B?YS9CWllodUlLVjJNaVowdytKR3NId0VYY0JYanZvZ1FoS016cU04QVJYNGw0?=
 =?utf-8?B?dUQ2YVc1Y1EzTXQ5SlpDY3YybENBYkYwdUYyWTBEK0txTWl0M01aQXBqYjRu?=
 =?utf-8?B?eFpYNWRCOEQ2cE1aVVowajZSU3E0N1pJK2tyQXMzQi93cW05WVJLQ09nSjBV?=
 =?utf-8?B?eWlycGx5UzNZTjFRT3NjNzZqNml2d0VGMEZvUXUyMzlYSXJyS1hkN0hWeEZK?=
 =?utf-8?B?c1RWL0tpOC9vNEFYZHFUUlBvTFU2YkZ0ZlJjZmJjQkpnL3kzb0dvbDk1MUhF?=
 =?utf-8?B?M3B3SFBCRVFLVGtDb2h0NlA3RXpWSEt2RStTNWIxZWpGUGJ6ZHQ0MGhUdVYy?=
 =?utf-8?B?WEVHNzlpQVN6cE1nUEowYjZtWlhrcG1nRXIvamZjZ0EwK2Q0a3liTWZYNEM4?=
 =?utf-8?B?TUdvQTA5TTYrMW5zZG5LVFR1T29RQzRnVEJSaGdpRzBYRkpyUEU0Z2ZOckxK?=
 =?utf-8?B?VUZzUXFwNVlUTFZHQnJPVE1sZmp0blBvNWw5cUJLVHVVUmpsc1RnelNQc2l2?=
 =?utf-8?B?WTZnNGxoeGhmZ0VCbXZUdDRoT0ZEeWdkT1diUXg4UWRJVy95MXlIajNXS3Fh?=
 =?utf-8?B?N1l5N1M2K05zVXM4dEpLUVAxdEZUNEZzQ1J6NU1WbXhKTmVwT21heHlUUXFR?=
 =?utf-8?B?czdoQkFmN2g2R2pOVmwwaXJmSVpEM0NhYmVqT2dxVFlYcXB3eUZoYWYxcHRM?=
 =?utf-8?B?ZnRWNDdyVWZGaUx3YkNlRmIvU0FxVXhnSmJ4b2VkTTluSmt0eVF0bzFPMnVE?=
 =?utf-8?B?N1NNbDFVcjdsOGJPS3FuQndEZzlwKzlmNHlrR2JGTUREaHgvV2Q1dnUzSlkx?=
 =?utf-8?B?N1NCekUwRU1MWGxYL3I3WlU1b3FuNUxzRVNJVDBtZm0yQmJXSEpMQ2FNRDVN?=
 =?utf-8?B?bWJkY1lXY3J5aEVwd3FUV0tpTmRObXhJU1JmaWd2ZkpkcFJwTUsxZWI4VXhI?=
 =?utf-8?Q?wVbSo/rYBzHlhVTctbw2V3N7M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3362b4b-7d7f-41f1-6a82-08dc952627c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:50:28.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtmGePwGJfmaFV2dJ59eeaFz9zkjE6jFUazG8AkVqZEpkHzRXOySImcRH7JKTgfa0wdxRXv/nm2dObX4MLXADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com

On 2024-06-25 at 16:42:11 +0300, Nikolay Borisov wrote:
> 
> 
> On 25.06.24 г. 15:54 ч., Chen Yu wrote:
> > The kernel can change spinlock behavior when running as a guest. But
> > this guest-friendly behavior causes performance problems on bare metal.
> > So there's a 'virt_spin_lock_key' static key to switch between the two
> > modes.
> > 
> > The static key is always enabled by default (run in guest mode) and
> > should be disabled for bare metal (and in some guests that want native
> > behavior).
> > 
> > Performance drop is reported when running encode/decode workload and
> > BenchSEE cache sub-workload.
> > Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> > native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> > is disabled the virt_spin_lock_key is incorrectly set to true on bare
> > metal. The qspinlock degenerates to test-and-set spinlock, which
> > decrease the performance on bare metal.
> > 
> > Set the default value of virt_spin_lock_key to false. If booting in a VM,
> > enable this key. Later during the VM initialization, if other
> > high-efficient spinlock is preferred(paravirt-spinlock eg), the
> > virt_spin_lock_key is disabled accordingly. The relation is described as
> > below:
> > 
> > X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> > CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> > PV spinlock                    Y    N    N     Y/N
> > 
> > virt_spin_lock_key             N    N    Y     N
> > 
> > -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >   void __init native_pv_lock_init(void)
> >   {
> > -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
> 
> Actually now shouldn't the CONFIG_PARAVIRT_SPINLOCKS check be retained?
> Otherwise we'll have the virtspinlock enabled even if we are a guest but
> CONFIG_PARAVIRT_SPINLOCKS is disabled, no ?
>

It seems to be the expected behavior? If CONFIG_PARAVIRT_SPINLOCKS is disabled,
should the virt_spin_lock_key be enabled in the guest?
The previous behavior before commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"): kvm_spinlock_init() is NULL if
CONFIG_PARAVIRT_SPINLOCKS is disabled, and static_branch_disable(&virt_spin_lock_key)
can not be invoked, so the virt_spin_lock_key keeps enabled.

thanks,
Chenyu

