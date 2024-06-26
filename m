Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3573450
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372717; cv=fail; b=Nrgu3Rc0fNDBPLu8H2fWo1k26nqGOHwTQrUrvmMX5xtHHXsA53pvLlQR3D5M35x0uQUnmA7Nkq2+bmFBq+ezLkUX7HG5xnphUGOB1aef+J7i3EPcHywMQu4EcRwt5qQVETmxmYFxi1PpUa5Q0MtuQxvkZUpdLNnChVHCNSKvv8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372717; c=relaxed/simple;
	bh=9Xe1CegMNCU0qbIV4NMizvrdIeBtlp/MaotplETjR2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GFqwkr489YtWRwT/wr9eWd4HxjYl+DnMNwRSqDGTr8TIkyDP+U4im08XdxydXnZ1QDVn+GTS+56CgjE21smV6LrZS+TnofEsfzNlDb84Rpi1xS8x0Okq1cN09urFIebCQpH000XrpvYgf/EthHQ7YdJQTcLLhjt2jR6a0LJIGfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yxr1PTcb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yxr1PTcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719372715; x=1750908715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Xe1CegMNCU0qbIV4NMizvrdIeBtlp/MaotplETjR2g=;
  b=Yxr1PTcbqDkWyWtAu0LxMOdP3+XQxC1Ujg2df0HsD9KGEYwvMLsRoat3
   lXEZXLMGDKrSaUMBueTGKIGeZTZKjUubaSvJJm0rG5BX6b/tfpqyKBjZ4
   5RSjPKfX9YgMA46CqJLD+0D1sPUjwXfapKktEOgbQaD6fmbYTqtOFjsL/
   F4uAEFaPKDXubgqpULxcU2HE6JjtEWDyyjo68WM9dFyhIYVgihL4gaLI8
   reZTZzTPqjOuMhBDB6Cc7CUigMyQSnSu6JrPF/yGHoExl7T7tUBeMU/xY
   t+mM+iK0kJ/BxMXFtRcPFPk7hoQnWWWrX1bKDlJ9Nm20zXq+cQU1XeVaU
   Q==;
X-CSE-ConnectionGUID: Wfs/ZQHpSRCB4E8QX8usPQ==
X-CSE-MsgGUID: fDWtYZUoQPWPCShGh25aaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27112059"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27112059"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 20:31:54 -0700
X-CSE-ConnectionGUID: 6EXUojH/Sp27qvLvq/dQ1g==
X-CSE-MsgGUID: MGawANAyQwWeo1S6Zc75CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48777760"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 20:31:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 20:31:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 20:31:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 20:31:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 20:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2Fdo2tw11CNx2BRvX7ceKbLjQkd5oimjSqvqDn9wJnm822SlmuhUXUSRODaJ3KYv01UOrRrSria3N0nzRQdGQtixGLSUKkpggwgkbF325MJo6KUgu816hdYA9PdzBDTRf4KEaTz41er2wJkkahUVccT7ORRk/zy4ya6edqFTxuf1dzXZ+wEquFZQ+rg105CYReCNE9vgtLjOWWRIC/jBUlIRfJxoxAjBniDmNogiPKj3PQPV9EVN2Oa5McwS+H65bg4/pGSwG22gHaO6H6wz7WJ7L83LgD9MxJlUnbqXe+rWEruNRncrjjdeMDfSdpma/bR2FWLz/mfzQVhfKRRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xe1CegMNCU0qbIV4NMizvrdIeBtlp/MaotplETjR2g=;
 b=cTvHtmMpuBmasNTpVaahJ+l4r5x5o7qp2wXGXvTqip61KWgS1hEFHCo4DzDVCzgsm6a9t3YwQg5wU4V+GMXanfk6VtTOWAvxI/ExCxXzDqugGZm+KmLkIxSz/n2FOIJgxHgoGveQRQi9uEOrDfQEbe7VCqTmw1iSkxAf3C+7BwZTLGE+8cr8A3+Vz9JsmO5pS3aaVGwTMIuG6Mv4fMns/KH6Rh7KSqh61+Ob/WnfuDG04TFXwQRD2kH4agTu04o5eoorFTdCJoEs5Wzv39a8lmCu4oPZo8m7WurqBZadBpqZ5EJg0q2m2MPDQo93KBAUsVDlVKCGa9oFHbOc1x1ITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 03:31:50 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 03:31:50 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Juergen Gross
	<jgross@suse.com>, Chen Yu <yu.chen.surf@gmail.com>, "Dey, Prem Nath"
	<prem.nath.dey@intel.com>, "Zhou, Xiaoping" <xiaoping.zhou@intel.com>
Subject: RE: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
Thread-Topic: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
Thread-Index: AQHaxv9B/cOdoav4t0uow9CgFu9X3bHYfPeAgAAS/4CAAAUJAIAAys0g
Date: Wed, 26 Jun 2024 03:31:50 +0000
Message-ID: <CY8PR11MB7134C965E373B3711ABF182389D62@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
 <224793a4-da57-4621-ac29-7eac35c2da08@suse.com>
 <ZnrZI9MtP8PqZzl/@chenyu5-mobl2>
 <11774366-4264-4e7a-bb7a-ee3d39c60522@suse.com>
In-Reply-To: <11774366-4264-4e7a-bb7a-ee3d39c60522@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB4892:EE_
x-ms-office365-filtering-correlation-id: 385c95c5-75c5-41bf-565c-08dc95908427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?Z05ldUoyQ2p4L1dFUXFVRyt5ZVlkWDREVzRtQ2NFNFB4STVhcWlZRXZJOURS?=
 =?utf-8?B?K3lqd1lSVCtrNlkyNFBZT3JIamltZ1Z1dk5SUmZ6ZWN6a2s4bkd1aTdMbW1Z?=
 =?utf-8?B?eDVoc1RvU2pneEFLYWd5bElGdCt3NGdaLzNzSWRPQUZJdVpCSWxDaUxLVmZN?=
 =?utf-8?B?YXpQekh6V0ZQb0JJc3BSakx5d2l1YlZmeDc4R2Q4Q216Y0F6U0JVUGtiYU9W?=
 =?utf-8?B?di9udGlMRzFZL2dYWTIzVkltMkhVYUtCWDBacUwreVFabW5NQ3lHdExBbVh1?=
 =?utf-8?B?VmJVUnRmQVlYcHFBaHRYbS9oQ1h6NTJPVysrdFFwVTFsZ1lIRlU3RTZUL3c1?=
 =?utf-8?B?NnBSNCtGamYvUjdTaUIxRHV6VjVLc2ZCSXdxMVJWa0k3WDdsOEhORTBLc3h0?=
 =?utf-8?B?eUR5cUF2THV5Mk5oRWN0djNobldISnlzVlhBaCs4NndPMXNML2Y1YTdPTTR0?=
 =?utf-8?B?RXYxVkhRN3lOMVZMNDBQbUxrWEFUK2RldDNXWDFLak4ybGhUZXVQZTg4UGRL?=
 =?utf-8?B?aHVnWEZTQnhDNGI2NVNRdnpmU3k3R3p0S0xHeXkvYURuU2xJZGFiQnIwdnlv?=
 =?utf-8?B?VU9tMUFpQmhJNmVvcnBoSWxURzhLMk5aMndyVDdTaTdUK0Z0cGtjbjY4Z2lK?=
 =?utf-8?B?QlJKMTNZTlpaU3ZzVjJtVnVONmtpS2ZBV2IzT0ZnY21UWVRJK21KVkp5dStZ?=
 =?utf-8?B?RXE0NXlqSFJNNXlzS2ZScjA0Yk9VaitXNmV6Y0VMTENORExhRG1iVDlZZmFa?=
 =?utf-8?B?bWVDdC9nVlhuVWNHQ3NkNnlqUUFwSHVxZHFtRGlDYnNSUCtSZUdGeUlGek1n?=
 =?utf-8?B?eWM4U1Z2WXJkN0RPVkRzZDNYOEsvNG9KeXlqOWNaUElxcEZzTlV5YXh0cng2?=
 =?utf-8?B?bFYvR3ZwVUVqbGlOK2ZQV3N0VFowbzBIbGNlR200TE1yak0xcGdmQTdTa1NK?=
 =?utf-8?B?L1RTSUVpRmUvNERBRlJzY3grcDJBaC9mTFA3amR6OWtUYjNyVmFMckdCWFQw?=
 =?utf-8?B?bTJ2ZkhuMW00anFaUUZlNC9hMmFNejZJeUt1L0RuYzdUR0l3NnZsWXBUNVN4?=
 =?utf-8?B?ejV5cjQ5ZE1lR3hWLzcxL0NvRk1LTjNTeU15eUkvUVlDRERHTVBXd3NHZFNz?=
 =?utf-8?B?VWZnYnlnVVJheW1uL0NpTFVJUGRmMkwwamJvL3VNWEYyTUVYMm9mbitmQkFF?=
 =?utf-8?B?WVBhandTbitKVmhMNDREdUZNeThUMEFjS2daVkpqaFhxeWJvUzBpeFVJUkxx?=
 =?utf-8?B?bnpKUVVna1dWN2U4SnZUWUN2aDg1dHdtUmd4c0lnS3hHckoxV0JzenVHK0th?=
 =?utf-8?B?akRNTW9xSHRVK2ZXTFFuSlpUdDlTaUpXTEo0WUtJV0VUdFRmbVRCb2lIMnpj?=
 =?utf-8?B?YUNQejMwU08yeUNSc1lkMFdzRTR1Z2tDYW5uTFJHbllyVXF5UnljdEpqS0ZF?=
 =?utf-8?B?cytvelZuQWptaFBsRVlxb1lxVlhTMXBIRGpYakRXQTlNMCtMTVhSdXhDQ3Bx?=
 =?utf-8?B?aFpyelI3UllyREZCbGZZS3hyeG0xamlESGdXemZTeUVxbnN0eHo5V2VaMmxB?=
 =?utf-8?B?ZnNsSHowaERaMENjdjVOMVFkYlJlTVZ2TVNRUC90WWZRU2MwYWs5TnVhcWhR?=
 =?utf-8?B?QVlwOGZXK3NxNlBwcFRlT25XcnkxTGR1M3BrNmxaQUdrNGJXRlZzSVQrNElv?=
 =?utf-8?B?dU1seFdhL0tpWnVrQ1JBcWQ4eDN5RnZiMi9ka1FUWlQ2RUE1T05ibWJISDFL?=
 =?utf-8?B?c3NPdFN5RG9hNkFiRmdiWXY1UEJ1WmJDNU5QajVLK2d1TnpoZFZmbDRrK0l2?=
 =?utf-8?Q?47FRORhsRjd8yrVAUo4ZkaYIE7b4V0bo9elKI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEYvb1BGY3lRM3hDQ01wdlEreW9vamU4YURYQ0NMZDFwS3ZKeDB0SFN1dWFG?=
 =?utf-8?B?YTFYMTZZSlpYZ2tjRjYvMHVySjRTMlRpZG5WYnhPaUtZZVBseG1NKzJnZWg5?=
 =?utf-8?B?VWNLMmJzMHpLVE1uODg4ZlZvZFJGUlh4UGJQcXVsUTlsamgrL1ZXSlE1WE9F?=
 =?utf-8?B?Z1ZTY3dERURqcHdsZzhqVVFPYi9JanhhVXEyMTdqejdtcE4ycE9MbVRneXlk?=
 =?utf-8?B?RWpqMzhFWjZaaGxWYzB5bjBnNUhYUE4xQ3J4UXlHUUhDS2VERStGVFoyR2li?=
 =?utf-8?B?ejd1K0R1cWluQXJDcS9nbytRWUVkczNhOFRodFdURHlUMDVwTGpEYmxrcVF5?=
 =?utf-8?B?WS8yZ3p5MmdMQTlFbVZPY25hT05vQWt0emE2WFBFNUtVYTZDYUJEMjNoZDhk?=
 =?utf-8?B?SU9sNXpFZkp6T2xvbUNCak1sZXIyMGJzcEJaak5DRzg5N2taN0xxbytVeXVw?=
 =?utf-8?B?bmkzOThtcEhiZ2o1YUp0MjBpM1hyeDduTEZyY2dKTjduN01ESTFKamthU3FO?=
 =?utf-8?B?T2JuUWFIMzVaUU5Zcm8vM1hZOGJZbVVLVktlbDV0cWZ3cXNORzJRaEpuYzFT?=
 =?utf-8?B?OXArNWVvTnRXQm0yZXBkWW9zOTlyaWppR2p2MWtNdituUzI0ZUNsTUlSYUQ1?=
 =?utf-8?B?U25aSlV4ZnhhRFN6QWt5MHAybllhR2VqWTdsVjROdWMxWDRUeHdXZW5XRGc0?=
 =?utf-8?B?Y09aZW5VUkc3QVdjY21xVkQzczMrMVlqcHBDS3FrN3VZNHFGU25RMnlpaC9w?=
 =?utf-8?B?UkdzRUx3ZTlWVGpwSlhYaXJ1djBRdDFnbzMycUVZL1RIRE10aDVmVnhqTkpK?=
 =?utf-8?B?QkErL2FNZ1VEMmF6alZFbEMvTnJvVjdRNVkwNC9nZG9pMVRzRDFjQjN0TEhR?=
 =?utf-8?B?SHY0czFabVhsclBzRENJRXpvZG13bklZVTNCZFhkd05ESk1tSE9PYlE3NWU3?=
 =?utf-8?B?cC9GMUViNWhzc1FpMVlZY3pSWXNpWWYvUkJOMEMwUURrbjR5YzZxZEdGK0ov?=
 =?utf-8?B?N1JQendXL09EZVdWR01yeC9pUkt4MWtQcUdCUkUvOFNjR01yUUVhUy9QbDg5?=
 =?utf-8?B?N09tNXliME1PZVVka0pHR1doaEFyQlNJWnk1VTh4c01MYUs4L3JsanRjZHVl?=
 =?utf-8?B?Mm1vQmNhZ1lqVVZyenEzT1czVUJHVGRINFhsbldDVHo3YmZ3UDRwSG5pNDVo?=
 =?utf-8?B?YlMxQnFTZjJHNTNQdFNLbFVjWVlIQWRjZ1JycXU2NUg0SXZkcHdpb0x5TjJN?=
 =?utf-8?B?ZWh5MVREZVZVUEgwb1Y0YVBvQ09kV1FrUmF6dklua2VnUDZ5aVh4S2RDOG9L?=
 =?utf-8?B?alQ3OTdzZWtDelR4MHRNN1RBaFRqdkswM3lYNUdveTVkYUlBcFZGejNhQVFS?=
 =?utf-8?B?WFZmaVhxSWNzNGVzOHlQTGY2Nk5JazZPUlZOTHZYOW43dkl5T24wZVlWN2FO?=
 =?utf-8?B?SzlIRDJyOWI2NC9mKytuZkhKc3N2M3hUV2hydzMyTERsSXB2STNucFU3M0t0?=
 =?utf-8?B?UTRibkRjSnBFUisvOHRDSXAxVm9zaEVzK1N3TzNkTTk3dnc0ejdjQTJnOWNt?=
 =?utf-8?B?UGFSTDFBM0lxUVZ5bGJhQWJwZVZqVy9hUWR0T3pKWnBNVzFKL3N6dnpSTFdX?=
 =?utf-8?B?OFZpS2dKaWdsSzRrVm1CUWFDMWdTdEoyMmo0WjRJTFNQL2Q5cE55Zy9qNEFy?=
 =?utf-8?B?N1hwbnQ0a1ZTL29DUnhLS09zaDBRekNNUGwyL1UzaHBSTGpWbk5lbXI3V3Nw?=
 =?utf-8?B?RUphZzhoVjN3K3lkbnVXeWo3cFl4bFhNaDI2ZzVBc01mWThaUTlScWN1bENy?=
 =?utf-8?B?SnFPTm5FZU9mcllaQk9SL1ZtQ28rNlhjcDlIOEljdjRHNm1yMHBWckF6cFl6?=
 =?utf-8?B?Y1J1eGRYMzE2UXRkMy94bm1oSFdzSmx1MktWYitsL0F0aFhjMTBnOGE0OUJP?=
 =?utf-8?B?QlllUHpYQjFiMHRvcTVVSUk2TzExUW9wcTFaVys0UWp4Wk9FM2JvYzc5dGl4?=
 =?utf-8?B?VE1RWUNQNDVMRXkvdEhiZ2lqdDUrRFY1SW0zbTJ4QmxuSTJzV2l3OURaUWRC?=
 =?utf-8?B?TEVmNHFVcUo0ZWZDRWVuUHAyaUs2elFma05WZGgwZ2NXVllHdVd6UWdjZ09I?=
 =?utf-8?Q?pH0uxBKnklbq28EpnnuUlDYIV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385c95c5-75c5-41bf-565c-08dc95908427
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 03:31:50.4167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9fhg9+LV0qqSe7AlMsdkeE+czR18Zg/gHSGZCSaDmsWugtxvRLEMOnXjkA20qeeXFjzjwUh3jD3AizcJompIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBbLi4uXQ0K
PiA+PiBBY3R1YWxseSBub3cgc2hvdWxkbid0IHRoZSBDT05GSUdfUEFSQVZJUlRfU1BJTkxPQ0tT
IGNoZWNrIGJlDQo+IHJldGFpbmVkPw0KPiA+PiBPdGhlcndpc2Ugd2UnbGwgaGF2ZSB0aGUgdmly
dHNwaW5sb2NrIGVuYWJsZWQgZXZlbiBpZiB3ZSBhcmUgYSBndWVzdA0KPiA+PiBidXQgQ09ORklH
X1BBUkFWSVJUX1NQSU5MT0NLUyBpcyBkaXNhYmxlZCwgbm8gPw0KPiA+Pg0KPiA+DQo+ID4gSXQg
c2VlbXMgdG8gYmUgdGhlIGV4cGVjdGVkIGJlaGF2aW9yPyBJZiBDT05GSUdfUEFSQVZJUlRfU1BJ
TkxPQ0tTIGlzDQo+ID4gZGlzYWJsZWQsIHNob3VsZCB0aGUgdmlydF9zcGluX2xvY2tfa2V5IGJl
IGVuYWJsZWQgaW4gdGhlIGd1ZXN0Pw0KPiANCj4gTm8sIGJ1dCBpZiBpdCdzIGRpc2FibGVkIGFu
ZCB3ZSBhcmUgdW5kZXIgYSBoeXBlcnZpc29yIHNob3VsZG4ndCB0aGUgdmlydA0KPiBzcGlubG9j
ayBiZSBrZXB0IGRpc2FibGVkPyANCg0KTm8sIHRoZSB2aXJ0X3NwaW5fbG9ja19rZXkgc2hvdWxk
bid0IGJlIGtlcHQgZGlzYWJsZWQuDQoNCkFjY29yZGluZyB0byB0aGUgY29tbWVudHMgWzFdLCBp
biB0aGUgaHlwZXJ2aXNvciBpZiBDT05GSUdfUEFSQVZJUlRfU1BJTkxPQ0tTDQppcyBkaXNhYmxl
ZCwgIHRoZSB2aXJ0X3NwaW5fbG9ja19rZXkgc2hvdWxkIGJlIGVuYWJsZWQgdG8gZmFsbCBiYWNr
IHRvIHRoZSBUQVMgc3BpbmxvY2suDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMv
bGludXgvYmxvYi9tYXN0ZXIvYXJjaC94ODYvaW5jbHVkZS9hc20vcXNwaW5sb2NrLmgjTDk0DQoN
CkFjY29yZGluZyB0byB0aGUgY29tbWVudHMgWzJdOg0KU28gbXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IGluIGh5cGVydmlzb3Iga2VlcGluZyB2aXJ0X3NwaW5fbG9ja19rZXkgZW5hYmxlZCBhbGxv
d3MNCnRoZSBzcGlubG9jayBmYWxsYmFjayB0byBUQVMgaWYgUFYgc3BpbmxvY2sgaXMgbm90IHN1
cHBvcnRlZCAoZWl0aGVyIENPTkZJR19QQVJBVklSVF9TUElOTE9DS1M9bg0Kb3IgdGhlIGhvc3Qg
ZG9lc24ndCBzdXBwb3J0IHRoZSBQViBmZWF0dXJlKQ0KDQpbMl0gaHR0cHM6Ly9naXRodWIuY29t
L3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2FyY2gveDg2L2tlcm5lbC9rdm0uYyNMMTA3Mw0K
DQo+IEFzIGl0IHN0YW5kcyBub3cgZXZlcnl0aW1lIHdlIGFyZSB1bmRlciBhDQo+IGh5cGVydmlz
b3IgdGhlIHZpcnQgc3BpbmxvY2sgaXMgZW5hYmxlZCBpcnJlc3BlY3RpdmUgb2YgdGhlIFBBUkFW
SVJUX1NQSU5MT0NLDQo+IGNvbmZpZyBzdGF0ZS4NCg0KQWNjb3JkaW5nIHRvIFsxXSBbMl0sIHll
cywgSSB0aGluayBzbywgDQoNCi1RaXV4dSANCg0K
