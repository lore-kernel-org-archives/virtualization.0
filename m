Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C01A4884
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523285; cv=fail; b=sSKViqoKMnWMn6B7kmPgg8jQ5cbpiahcXefOM72NoMoMi0xoQSq/cajdKfqWd9+xTa6CuzIxVtnHmf89picWY3pOL2ZOz/xWTe+9XL2O3ICtustzo3BwbOl2sT+aOUWBaJjJ6bAvy6mgVAysvjJfkzg6i+xj4ASVgIpQc8IHLOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523285; c=relaxed/simple;
	bh=dr7Xm07oqmyrsbpbi1nPf6GDFWapFXz7pejL2uplbQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BzFluQbNQ1weGXVvfQD9p4SgcvrW5Q8fXJMS7hi2gCS0ygzN8y14BNxQzzaIuiW72IRNZeYXATymy++MhVVjOdIRZmzOY4dJcEVsL0XkN15T4i1ysYQ/SdAKBHzOOvQE/1kb/alEDxvzwXA+fZ8klWtDivYP4MrJHNpswDyozDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJc10Hb9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJc10Hb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722523283; x=1754059283;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dr7Xm07oqmyrsbpbi1nPf6GDFWapFXz7pejL2uplbQQ=;
  b=NJc10Hb9JFmt32yWgWreupiI4g+/Gy+9CI4STt3YCmEPTE1hYt1F7GoX
   Xavol6tTzu5mSodFSCs8JbTRzmB8WuzoY4G2gjOpPC1Vrw5SmOCV2Kru3
   IfAQ8aWxpnfWXOxha3DrlTE3hlmZhBWAAiGAScXK5xtRp6W9sGvSJVPnW
   pjF0LQpure+1LPW51HmXThZdVAgAvEuY9XaSgVOgUgJSlZ+SpUgTTogpU
   oUfpnQ+GovrNSoK9jcEZS6gZ66GY/4VuV0uaWqw36FXnGJs+nPwrXuLaT
   QHi22pP5m5V0Js0RoAPOc9KRW7GrX29cjeQUgza8ZFMHitUhgEH2j/xY4
   A==;
X-CSE-ConnectionGUID: 3NnJOnqdTqC7ogRRzfK3bw==
X-CSE-MsgGUID: 7CLF0TQOS7OCmaGNyEnhFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="37944785"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="37944785"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 07:40:53 -0700
X-CSE-ConnectionGUID: wFxSkbSQQWuM0+H/I1m+qw==
X-CSE-MsgGUID: jWfLWEU7T42+pp8n8wMMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59706119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 07:40:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 07:40:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 07:40:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 07:40:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 07:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m16fL6mcURdsiTsBWbq2RphqpRaOn67r1dye9zyaZ94UmmE8coukblWY6KG5oPgUD4sWquVAjK2yXbBYkpACCiymzhdPM5ILavZMTjyuFfELiAgzu46Zn3l9NXcoM4UwaPtMSPrjDS23O9/qDkHtp8NbxMrI4LilrJ1W6BJN2V2KXX7BUDf+CCokwzbX1duUNxXKiCyFtzHIg5tKsRXGNdzanEFexkILWQ/3QZwLMjPaFBKjJioCWTo95rg0lH8kttEAc0hAy6nGTOgKSWB3kHcJSKcUJ2iCohutVpOxl7HoFHW6j/YXB7b8f53fhy4oh8rGXLPgSC+7FvIR0tystA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6olSpFO/CJ2PuUC3gaQRbNJg2NcnaGra5XzgiLe9k5M=;
 b=gJH9rx7oPxMFDhATOuewL1paCkE8qxD40xeAiYT/PiPQqeR7n+HAOdrmyuj1va/m/jlXyiGDmm5oxxRZH/urYOQ711WuGcqghLyZcm1xI55IJvyH+Ld4h0YppVGd5cdw41WboU7MhO7xrLv6iTzP+LTFHsdH7cAddVWBkGT7G08TDrheqj6PjFhHAoK68G8tcxn5ps1WzI0aOC2BHTXSsLbrd4yLyIxdQDjCNWB4udzGpiZTVsU5vuLZAyGcSu+YqBkDfzfVADCKz4rlMszZ2P7HF4tADBqw7gFT9n59+vfGjbQWp0fX/Jkvvvu95jvzfk5qCJZX9xnhncqzMcMNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Thu, 1 Aug 2024 14:40:45 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 14:40:45 +0000
Date: Thu, 1 Aug 2024 22:40:26 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: maobibo <maobibo@loongson.cn>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, "Nikolay
 Borisov" <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Prem
 Nath Dey" <prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZqueWhX6lqS+1vwg@chenyu5-mobl2>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ddc097-3713-4c95-2f95-08dcb237ed3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2xrZVhLK3hqSWFqMnpQVzM4MVhXaXVJOUgxQytLQkR5cmd0aHl1eW8wOEh4?=
 =?utf-8?B?dGZ4MXhqV25HcnNMVHhaelJkc1lEcVpoRVdSaUdPSWlhQ014U1phRzFSMGR6?=
 =?utf-8?B?VkQ5LytHeUordFEyUmpXdVBuOHZJWWZMZmR4enZSV2NlRkZpMDVlbTRyMk9F?=
 =?utf-8?B?QXpPcDcxeU4yMXQ0U2ZZZWZrcHFhMWtvZi9qWjJFc2pWVmU5dkFVRTlaRFEy?=
 =?utf-8?B?UUw5L0ZsdVRDaEdFcUJRRnRBenpzbEg4bndNckNwbTJjeEhjVCtVTHZQUUpj?=
 =?utf-8?B?WXFnajZWYm9YMzQ5d09sM1kvczJsVkI5RlJFN2hDVUs0NzhLN3hoTUhiZmJt?=
 =?utf-8?B?cFJ5bDlwcElPVjBuTS9RK1JWV0p0WnZnRTlpY0RQN2E1RHlPYkdZeEJURVBC?=
 =?utf-8?B?Vk80V2ZKUEZMbU1FMTIySmY5bTRlRW9tNk45cmI4UEFhcFpxcTNsazVWYm9h?=
 =?utf-8?B?aUhpMGtKS0JzWUMyRkttSGpjbnd3bjJMbDlRdWNOaTJ2c0NGUzdXZHpxWVhI?=
 =?utf-8?B?dWE5WGtLUnhLTkxGRGMrYUFWOHBTcC9MRWlrSFpLc1IzbmR3MW5RejY3S1VI?=
 =?utf-8?B?WVpxNEhWMUlXTkhMc3p6M0ROb0JreitYc0JGeU1taE1Dbm1YZ1craStCRmxr?=
 =?utf-8?B?NnlJZ0xrS1BoUmlQZGUwd01Pa3RSMWhVVHN4amNnT3pZanptcmV0Y09jM2pa?=
 =?utf-8?B?Q09rT2lucGVOb1F0dFZGc29naWZhNDFRMDd1a0FQaGpkbTBJT0pSWUNYY0xa?=
 =?utf-8?B?MnZMNFMvcEZsd3FWM2xtQndRT1RsZDcremk5K0VvM1pHZ0pPamE0NThMQ214?=
 =?utf-8?B?SXNkdkRSSEhNV29vc1hZdWZySmtDa2JDRHFqTW1zYk8yUWoxdVc0MGh6YnUz?=
 =?utf-8?B?UnVyWVRYWDJSanlZMHZUdFlpUDFIREFwelo4ZEZ2cHJudWdLLzRiS0F0amJT?=
 =?utf-8?B?RzkySGJ4WmJhUE93QXVuY0hVZzluWTYzY21KcFdlejVCdEF4WGhzOVZUYjgv?=
 =?utf-8?B?a2dFR1ZHMHJvNVV4VitSeENqUUJhTEpFdkJZUEdvdDJZVXNBYVUzMmZpU1h0?=
 =?utf-8?B?eDlDdVh5VWFxazhBODN0eEYrSmY1Wmk1eVFBcVlDY1JiVEViZDlJWDFCbS9M?=
 =?utf-8?B?RDB5MTRDN1hUamtneVRZd01YUURsdEZiczJDaHAxOVNZYUJ1UHdKVXRSeDNi?=
 =?utf-8?B?TFpSb2h4ZDRlSzhqenJjek10ZU1FdUJyODdNQ0lFNlRPSTVaQXBzOUlZVSti?=
 =?utf-8?B?N09JQ3R1WDZ2KzA0ZkJDTTBtWHEwYmJDanAzME94M01CcStxd1AxQzRmNFNY?=
 =?utf-8?B?UXovc2s5WTdJZTBleFdDOTBUQkJOTDQ5SHF1anV0OU4xMEd2amkxS3N6eXFj?=
 =?utf-8?B?RFRaUmRBSWFQN1kxZWNSdURHY3BtTmxKRFlZR216ZlRnd2tTcXc0V1pxOHcr?=
 =?utf-8?B?bllWUXZDN3RuYzRIbHdhQUpWaUh3enhWR1BYOWRyWnlJbHpKUHFjeTg2Z0J3?=
 =?utf-8?B?UHplMUVINGhEdGluUm8zYkMvd1FuNjB6S2VORkJ3VFhNWkEyckhLKzk1N3pJ?=
 =?utf-8?B?L3NVKzQvdnZnQVpsaFBGazM2NTl0Nm00U1NzNkwzNUt5YzR6eEtmWS9mczJZ?=
 =?utf-8?B?SUd6VHZmRk5XdW9DcmxRRk9hQmlHS2Y0WDlrbEVvZmNOa0EvTkFOdGFuVjJ2?=
 =?utf-8?B?VlhPd3ExKzRSalNhbm9OTGxZYWlSZElKUVRLYTYxR3lhQzlkTmQ1THRGMHAy?=
 =?utf-8?B?VEtJZTdNcFlBTGIxZnpxaEkxd3JZVnFDNWg4cUlmVzBNcmNPWWJYVU1mTzU1?=
 =?utf-8?B?ZHFDcW1VdFd1NUJ4VmphZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tBc09RMlQzMlZ1Tkh1YzlrNDNJRks2QU9RZkNyTEtzR2hFckh3N0dEMm9N?=
 =?utf-8?B?MTZkb2FBZHQvd1hPU3g4SWYrTytPNnN4NThIbExSd2ZzRXRaUnRudTVjMzAz?=
 =?utf-8?B?ZXFCOG1NOWNzRFV6TFIrVDZtYkIzZEZ2V3I1bnB0anRFVVJnYzJmZEFmVDFH?=
 =?utf-8?B?bXd3Tjg0QWY2eFJaa1R5a1ovclp1aEZVNHlERk9XbHQ2NEduUUhEZ0FGQ0N3?=
 =?utf-8?B?SEQ3TUpQOGVTNUg4QXY4eHRHKzdVSGtMZ1NFSlZGa2Q4aTNiOFlEZUx2VEkx?=
 =?utf-8?B?cDhpZW40VGkyS24vQWVFV2pWdFhrckRzbnpRSUR1N0huRjVCcE1nVm9WL1p5?=
 =?utf-8?B?bFh1Q2xWLzA0NzlXN0cwZklvWk5GeStHZGowVENOSkFpUWdWZXFMSXhtbTdv?=
 =?utf-8?B?Mi9DcG0rUCtIeGZzMFlsQkRtUkltc3dPTFp4c00zSXdKc1QyRkZ4N0JyYm42?=
 =?utf-8?B?SDNNK0h3bzBUYmZCQWVRNGxTSG1BNFErbjUyejlIcEdvTFdLVklpQ2EzTkxU?=
 =?utf-8?B?NW82QUdpSC84MU1nTHk1ZEd2WVdiZDNPNHE5eEhERlBBa0xDY2VraGhYUThn?=
 =?utf-8?B?M2FGTnNpYk1yRFM4NEpkRFZhK2cwdk1UcUxpZE9QZVIwZUF5Sm9DYkZLbEE0?=
 =?utf-8?B?WUx3bGwzK3pndU9NMHVuOWQ3QU5jK3FkdmMva055VmVPWVNzN2pNRCtrUEl1?=
 =?utf-8?B?KzhPOGs5R3g1SXNYUlhsTzNjWFBzanljbDhuSUc5dVhTcGp0MXdKYlBRVUF5?=
 =?utf-8?B?U09xTEFyZjBaSXZtcmxPRUZka2tBbTNEbyt1NFFRNEMxRERWZ01qN1JML3ha?=
 =?utf-8?B?K2R6ODF4ckJzbkM1bTBtczJYa3RCVmJYYkxONThJT3dvSzJSMnNGQk51ODJr?=
 =?utf-8?B?S0plWkdWby83VFFjTDF3NVBMR0JTYlpYcm9mUWRsMUVFaThrcFB4a1lUcXMy?=
 =?utf-8?B?akxPbStGL2xTcWhnc2oxcVV5TTlwRmxPajVOYU43N21mMk93UW9uWG1jbnZR?=
 =?utf-8?B?cTFPclRBT3AvbURrczR4dUxlRUZaYTkreFpheHBnTEt5c2JxZUFpbXZTbUpE?=
 =?utf-8?B?TTNZZkFRN3hIcmFZUCs0WHFEQjUxSERKdnRUSEFxZm9LSXBpUXdqS3N2a3RR?=
 =?utf-8?B?RWZNVnRLRkRGcXdnV2J5RXdsRGlrNVJPa3lRMGdTbElMTlFaMndKYjlWL0VF?=
 =?utf-8?B?elZVcFV2QkZ2amtzbTE4OXNVSFRLWEZ2OEhtUS9UNk5YMzFFejRxOVBBTHVZ?=
 =?utf-8?B?QXd6djM5WU5aSy9KeUhhTUhTUUdVL2kvN3ZUVlBsV0pVSVRiUHRRaC91dENn?=
 =?utf-8?B?SUJ6MU9mWnczbnJCRnhIZjRkS2J4TXdqckFQbU9SRUlQY0tlNVg4ZW5wSHlH?=
 =?utf-8?B?dHRJUEYxTUxtT3RydHpKeEZRMGxYWkQyV1drTzEwWk1GM0JRdElKWFZ4c29N?=
 =?utf-8?B?ai85OC9ZQ2lDRUlBVDBLWXBTRTNEUTFGQjVUWktEN2lRM3NwOXpGOFhjRU1P?=
 =?utf-8?B?SnZUZEhLNGtzZW13OEdVbjZXaWVrU0RzSnhiSjIxUTlUMEdQYURxWTkwZmZx?=
 =?utf-8?B?WSthSVl0Q3h1L1ZmZmNTRzEvTmRMQ0xPTTJOZVo1c3kwMHVEdzhYV0ZLeWxw?=
 =?utf-8?B?Q0FHY1Q2ZExIcHpVc3g0aXN4TzBETzhER1pjdnpscnY2RkJ5TkplUHhleldK?=
 =?utf-8?B?YTZvYUpmVldleERLNDFiY0twYnJ6R05qVm1LWkRFRkgzUERmb1Mvd3F3UVRH?=
 =?utf-8?B?aER1d1lNUWFQWjZBMzBVbVFodUNLb29UWEFudmxBbVJVYjVacGs3NVAreXhQ?=
 =?utf-8?B?dkVSa1hkM3A0SWdXc2VTakF3aGVqK00zSFo5MzBYcmxKVHNNd25lbEJaeWlV?=
 =?utf-8?B?ZTYxeVV3dlJBZWtpem1aOXMwZ250NWM2dEF6dkhkYzhHamg5cW1kYndEMDdR?=
 =?utf-8?B?SjcrTG5lN0VMMC9ZcEhYRElnQzFhWXRzMnpYV2VVc3V4THhJSzNNQSt4L1lR?=
 =?utf-8?B?MGlIY1l2MEtvYmVzMGhyTERLQkhRem03TWJ5RVVnM2hrSzFMTkMwMTh2YTNl?=
 =?utf-8?B?YWxnSWFhU1RiNTAwYmxIYjljR216Q0NzRlVzVjRRK0VIWC9uc0pXZE13MzIv?=
 =?utf-8?Q?VaZw1gBGqTAWMIUswdO9WFhgf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ddc097-3713-4c95-2f95-08dcb237ed3a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 14:40:45.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EToCGQaAKnqLHkKdD1I6b+tzsPFBd2GDOJX722kWRyielQ9Eam2Z3Xna/FMpAyHX4jPrdivkCmn47iZBDzZbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com

Hi Bibo,

On 2024-08-01 at 16:00:19 +0800, maobibo wrote:
> Chenyu,
> 
> I do not know much about x86, just give some comments(probably incorrected)
> from the code.
> 
> On 2024/7/29 下午2:52, Chen Yu wrote:
> > X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> > CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> > PV spinlock                    Y    N    N     Y/N
> > 
> > virt_spin_lock_key             N    N    Y     N
> > 
> > -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> 
> @@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>  {
>         int val;
> 
> -       if (!static_branch_likely(&virt_spin_lock_key))
> +       if (!static_branch_unlikely(&virt_spin_lock_key))
>                 return false;
> 
> Do we need change it with static_branch_unlikely() if value of key is false
> by fault?

My understanding is that, firstly, whether it is likely() or unlikely()
depends on the 'expected' value of the key, rather than its default
initialized value. The compiler can arrange the if 'jump' condition to
avoid the overhead of branch jump(to keep the instruction pipeline)
as much as possible. Secondly, before this patch, the 'expected' value
of virt_spin_lock_key is 'true', so I'm not sure if we should change
its behavior. Although it seems that in most VM guest, with para-virt
spinlock enabled, this key should be false at most time, but just in
case of any regression...

> >   /*
> >    * Shortcut for the queued_spin_lock_slowpath() function that allows
> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index 5358d43886ad..fec381533555 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
> >   DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
> >   #endif
> > -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >   void __init native_pv_lock_init(void)
> >   {
> > -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
> > -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > -		static_branch_disable(&virt_spin_lock_key);
> > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > +		static_branch_enable(&virt_spin_lock_key);
> >   }
> 
> From my point, the sentence static_branch_disable(&virt_spin_lock_key) can
> be removed in file arch/x86/xen/spinlock.c and arch/x86/kernel/kvm.c, since
> function native_smp_prepare_boot_cpu() is already called by
> xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().
>

The key is enabled by native_smp_prepare_boot_cpu() for VM guest as
the initial value(default to true). And later either arch/x86/xen/spinlock.c
or arch/x86/kernel/kvm.c disable this key in a on-demand manner.

thanks,
Chenyu
