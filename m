Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5C291E
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676226; cv=fail; b=M0w9qZCSHBbwSaqL5OQLlC6t6eWIkYiIDHsrmRarSRgefAEeAuBra6xyY9iaTWa6BvpBcjx6ZI8/7EojsWEfSa//aTQWOtcG4b7D/0pzJo4Gh3HV742ULaMBFpOAzlfwyXzG+eEwcIw+y7Fe1nsD7PVt9FG78pSoZSDRh7Y89ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676226; c=relaxed/simple;
	bh=7F/eNS7SEdeZW/T0qtxIXJjPplBYMlAvEvjxfa/uaE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QecDB6EuenvYoH8D43U4FAXfIDwtdDJJSQ7uDYnBk+UI+MJ6t+G6DhOSaJibUoJ/o4ca91wRrYfX+hVj9I9IvgESzUPSOXG5lWFFRuK8mKSBs9RrqM7NAPL7y0YMBMKCuUvIfG/eNK/S7LNUAKWxocUe74wPOODpX5nRJbeHLVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH/icEPE; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH/icEPE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43DF64021E
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 02:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrEpnjpwczj0 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jun 2024 02:03:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8ABA240210
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8ABA240210
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RH/icEPE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8ABA240210
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 02:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718676223; x=1750212223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7F/eNS7SEdeZW/T0qtxIXJjPplBYMlAvEvjxfa/uaE4=;
  b=RH/icEPE8d2u/h60LCVEgyJ3qh+455KJIoU+UhyRJvyJzvYbHqgZHX/6
   TLRTmaDnho2nRdo2VCMfPtrcUCW9az/k7aah3S3sUWqkNxn7xj6yn300M
   IoooGtWU/zSK/KrghynH5MCNo4usV7Q/6D229sFddXZ5Xfi1X6Bkjbk98
   cl+KlllHicK0VJ1/lCt3rPMTGknPtMRsYs2y5ZVN7g0Q8VSnxH2S0rLCm
   txhc3NMuQsGYtf/UeeulFV2kolWOck5CglY97Jn6So1DQAMi5DFbnQ1GN
   nVvmcgrXdphWgavZkQqKoccBPkdZB2eGuSNIhEUAVzKW/SNGZ2xefdDF0
   g==;
X-CSE-ConnectionGUID: 4syeG3a3R0KqX82I4qG4Qw==
X-CSE-MsgGUID: OLb5izi5Ro6J1Uuf63G7wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15362785"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15362785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 19:03:41 -0700
X-CSE-ConnectionGUID: FdtZ96GqRCyNBgCk7v5p4w==
X-CSE-MsgGUID: aJ1fyPApRbKEaYpvQoSm2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="78844573"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 19:03:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 19:03:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 19:03:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 19:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgNoJ2YLjGn4x6s/03pbz2OlVC1J/JNZjg6xRIZzGISTVR2oKcvu4eN5p9nz7/2M9syYtmUqsnnNhWdYF8vRN5LPmTdCkydlGL68sYt92xeBR+ryzX7D3ep0TELvWr1TT8pnsoCu9lmfNCcKNC/seFA9wxFfo+n13xk7muVPGp2th6R7ayfk94tFxXGpadS9VtqjTEltFzh+eAUjfPM/Z8BYoEPnQ4olPSbWWVqdSK02PpGI8GlQJsF/cGmkqb0DRLb6DxFsPjv7l83wiw2y/CAr6hXsjjoRx37g55gX6Isg1c9r4DI3z/2/JXXnHpul6em91K1tCNDzk7N4wpgoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7F/eNS7SEdeZW/T0qtxIXJjPplBYMlAvEvjxfa/uaE4=;
 b=LINtanW+doyaYMgGwVXIYaYrIuAsuqaLlfWD/aq4zq5Yfb8+ayqJ6NssVUYPXNM6Vybj9uVk3stOdgHkdeApU67We7Q016tiKiY1mJZ1FG9hZKDZbZjwxUBpss7XVGPVVA4VrNokWLFyAXCJlyp0Al5qvN6JBg9ZuaAX9VLpqUUozX7od6EFLLclE9LDGJ/r2SMrEH0FGexxn9YRJZY0+8xYbYirSt3hKZWRWh8ggjF01miU1yRBFFPzWwKq/YdmFlt446t5j7VguGZczED7avhnZGSe2g7QgRVssS3y+MxsDLPNdfa30eBt4adaSHD3rp2/GyCiLFvBSuN9m8KjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Tue, 18 Jun
 2024 02:03:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:03:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
CC: "mst@redhat.com" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, Peter Xu <peterx@redhat.com>
Subject: RE: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Thread-Topic: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Thread-Index: AQHawM4I1/zRB3CmoUOTMvVFPy5VHbHMuROAgAALyTA=
Date: Tue, 18 Jun 2024 02:03:38 +0000
Message-ID: <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
 <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
In-Reply-To: <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5008:EE_
x-ms-office365-filtering-correlation-id: b760d7fb-faf7-4187-c3c8-08dc8f3ade8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?VjhrRlk4Mkhmck5oWWFDeVg0UTVDbjBSNVJjVWswVkF5ai9oaU5YemZGc2xG?=
 =?utf-8?B?VGhjaW5meCtUWS9zMlFzdHQ4WUdiRk9mS2kxTUkrclhLQzl4NkY1Y3lFOVVp?=
 =?utf-8?B?blFWRUdJekd5cWdDKzBPU2tTYXVxeWcrai8wTklkLytlQlkwUGNHdVBZUkZl?=
 =?utf-8?B?aTYvU01ocWk0WC9UYS9IeFBZTVBTQWZGbC83OERmYUNRZUoyQ3Q5WVhWNkNW?=
 =?utf-8?B?M0hIQWg5cm1OS2tkV3k1T0dCajlYcHBiSTJuWTJtZDBGUG1peVhlSHJabGEy?=
 =?utf-8?B?VTRMR29HZkQ0U0NGUVYwL2d0TDlxVEVRWk55eEpodUhxWUFHTDJMUkY3bDdR?=
 =?utf-8?B?NVBjbkpIeGdGUHVKZXRlTjBuTUluM0tKTHNveUsrTTdKL3Q0Rm5qelFmbytN?=
 =?utf-8?B?UG1yVmEzTzVHdWdBZjlKdHNDdUVob1p3K3liTXRMMUk0RUEzQVgyY0hPR2RO?=
 =?utf-8?B?eXIzaXFZUkRRZjNRY1ljenBsbUNWTU9XQXYwY2xkZFliWlFPUS9EdFpNaWpN?=
 =?utf-8?B?WU81M3NMNkpHM0NiRVQ4anc0L1JORlJRZmNubEVoOHZtZjh2SjFYS0F4Ty9X?=
 =?utf-8?B?ZHNMRkpJRUc5KzYrZDNBTFMvTGYydkEyVEUrRGFaQy9wOTA0TGRBTDZyNFhi?=
 =?utf-8?B?M2xaaHZlcFFWcGk4WjJNYytwUklQaGkwWG02bUE4TU1zUkxzVzFKUFNpLzJk?=
 =?utf-8?B?d1A2eGVvTHRYWVZpOVlBVmpKYTZYK1NEL1AvV2ZjWXZqbDNGS3l0bVlIalY0?=
 =?utf-8?B?YjBPL1JBZDJPL2pqL3VGc2ZoSk1zWERlMnMrekxVcW11OE4wcDZPWlRaY0Y0?=
 =?utf-8?B?TFI5SUprVzNWNWU1MFNiRkwvVHdYR0ZoWGVHYitlc2pqNE5EclRrOTJpdFdV?=
 =?utf-8?B?M2VtY1BiaHZQWUs1WDVhK01RU0R5L3JOeFlSVkNEQUJYQisrOVRGUXZYbENL?=
 =?utf-8?B?L0pacEcybGlsZHZxby80a0cwYW8zekNFeU1VOE9OSmhYK3dSOVg5YTVPZy8r?=
 =?utf-8?B?OE16YXdCVTJuOTR0UTFoNVVPZFEybGxJRGE5cGhMSFhZc3IrVEtRMEc3aW0z?=
 =?utf-8?B?cXNMQUhMTlV1T00vVWNGMGN3eUp3eUtBYkZ1cEZqMUQrVEEwN3FZelBKbUM2?=
 =?utf-8?B?MFpQT01vdENEN0xNNGlJT0x1TXFlbEZDelR6WW9CV1ROcGlDWXJENm9PdGEz?=
 =?utf-8?B?UWh0MEFCa0s0ZmF2WndlaXFwd2lrNFBKYzlKRDBrMWMwL3VXK2hMUGdjbE9t?=
 =?utf-8?B?RUZqdGxQTXk3OFRPNi9QNEtONExaQjlaL0dxejdqNmJSYm9LVitmeVQwZ3hP?=
 =?utf-8?B?bWRKVTdOaDJQY2pLZ1VBSVJhV3BNM054VzVCaVRzS242MU9UN2UxdmVhcW5O?=
 =?utf-8?B?d2pvRXRscXhhY3lyOXFQMXU4aHdCODRWSGVkaWFNbHhxdE0xWENtVFFLcmJO?=
 =?utf-8?B?UXBhN2ZaN254bng1WTZRNHkwSHpWY3RBblcyMzNJME9FRjdRUUZEcGpZeWdq?=
 =?utf-8?B?UHA3dDFYWFFlZmVlL1lLTldFcVZQTjVZK242bHgzK1ZpVUJ3RWhSaGZ5QUNx?=
 =?utf-8?B?b2tVaXA4SWdzTWRNUjVPUWhBUi9pOGNNbmtpYi82elE3SW5wUjVvWmRVNEZv?=
 =?utf-8?B?MFhUTmNUK1YvajRhODQ0RDZBSFR6T053M3o4NWp5ekhQV3VzQXBpTHVEVWti?=
 =?utf-8?B?WXZyOUVITVRpM0FmSjNDMUQwUDVaOVI0cStWVFlXVjVWU2hJTGdVcU9XTWgx?=
 =?utf-8?Q?FZ2yAtuydZh9Kuzt+A4KkrUqIIxKSVoqH1KSz1e?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVcycXRwMlhGaVg4S2ZaR0xYTUxOYWcvSjdRdXIzU1lWYzU0bGZtZ0lFOTBK?=
 =?utf-8?B?NmhIbzZUelJhaWVBclF3cVpRdDdBaHhXTTJTVFVGU3didkZ4NG9EbWg4cTlt?=
 =?utf-8?B?VFF0eEUwQmF0WGl6THhxbTk3dWJaOXlRZjdVbFc4d0xybjRvVm16MHdHQmVM?=
 =?utf-8?B?Z2hwWGoyOVh1bkt3NXRuQ0licHJheEZNNytMRWpRbEswaVphNHB6MEJ2MXl3?=
 =?utf-8?B?bzFOZjFvMFFOMUVKYUo5TDQvejFiWUNuazYwM1R6Z3F2aW9udm1IWFJWUWtC?=
 =?utf-8?B?M25XMkU0VWlWaXNwb1lRL2E1c3BXL3VDWkZQWlRFQjVFNTd0T3hPbnVZd09p?=
 =?utf-8?B?VktFa1dHSFN2Rk1Oc3hHSUUvblBKUFRQV010ZXVTUzFycC9pckNwSzBkVkNM?=
 =?utf-8?B?VmlnTm5IbmJWN2xITk1lNEx4Z1RuSEVmalhOZzBFQmlNc0tIelp6TFVZU3A4?=
 =?utf-8?B?M3gyOHgxZUcrajZZaXVNaXo1aDBObU4zMm9aNEVVTFR4ek1td3V5bjQyNUxr?=
 =?utf-8?B?LzMxYklKMVcwbDZFZmtVWE5JaWNJTUt2ZFo1QWNwaWNneWorWVFuRnhncm9k?=
 =?utf-8?B?Qm9hTUUzZmxKeEtSVG03S3BxMlhOZlRlVStKRlp6R1BNMy9pL1dLMjdzL0FD?=
 =?utf-8?B?OTRpQ2Z0NTJJRGxGc0U3VEJYOG9CazRRZTdYd1lEL2R4aUhHVm9jem53R0pr?=
 =?utf-8?B?bnNlbENNZS84c3lrWGVuWWNWQ0dxNGRMQmprVlluZVl4UmpDeFhSbzdmM2NB?=
 =?utf-8?B?dnhhRER3dnV1NzF3cFJjUG5BUWkzby9UOHBVcFNGcFlkMWppSGJWQkZlcmRU?=
 =?utf-8?B?ODluYXZOc0pZTFlRSDBYUHo1UVBNSGJSYU1WbjZqSnJDR1ZNd2NpcXltN2kv?=
 =?utf-8?B?NkI3VkNPRktzWmRlNVJGbG1oQjMwcit1ZE1KMDNMQ3M1L0xVb3U3TDA2ekE0?=
 =?utf-8?B?SEFTcW9DUTg5SXlrNG8wWGdyZzg1Nk5UdjQzYTJ2VG42anVsb1Y2RlNaU3dm?=
 =?utf-8?B?c0F0RTNKWHVoR0lYTjZIL1lVR1BDc1I1Rm5SRGVxMENjN3BhQ0MyUlVMbjc2?=
 =?utf-8?B?dzVJQmgzMGI0R1JxOHRSWldKMFV2WU55MUh1Ui9SNU1OZU9pKy9zNnZEOFY0?=
 =?utf-8?B?WGRPUXdaNFh4RE1KS0c3a2lSYjc3SzRydUI5YXJzYWYvL2RPRXlpeFRlYXFu?=
 =?utf-8?B?cUFUTXpXWjJ5d0hZd0luSERwbjBRLzdSQkVKQXZoZEhIaGhzbTAwMnpFWm5M?=
 =?utf-8?B?WTkwVktGRVhuZGhHVHpTMzBQQXNQQ1pQbmQ2MEpJS2gwNjdGZ1JJSW1PWjRn?=
 =?utf-8?B?bHZ1RUFVa21Pamxxa1hBNk9OM1JkWjhzeHVRZVNlTkdLMFpRdE1ScUZySmFz?=
 =?utf-8?B?VWs4amhHN2dXL0NRU2Y2SEFtTktzSmpXMU5idTl1NitFbHZFOTJ1dldpZ0NU?=
 =?utf-8?B?M3BKUVNzKzFsNnJJTDNuU2ZwMUxCMCtJd2lCUG9nbmJaNkFzSUdCTzJna0dS?=
 =?utf-8?B?b25RRGRySmtNSUJ0QzBScTlQaVhOekQwQzN5RGtjMnhhOXUrM0VMYkF0Yk1S?=
 =?utf-8?B?Z0crRkF0SU95T3FvOEQ1RkR4RlRHd0ZnVUlOZ0FINWtCV3JIVTUzMjMydXNG?=
 =?utf-8?B?eHhwalFraS9wNzZQVjZMcmRTZmlXSUI2SnI2dU1hTjRvOGg4UlpQeGdsNUww?=
 =?utf-8?B?NlV5cWlGeE9lTHRvSC83Yk9Mcm84RkR3MWYyQWNQMmZxNjlEb0NXdi9tRFIy?=
 =?utf-8?B?Nko1UHM3RkdHWHZUSDZzWVRzN2pUUEJKcFZTYlduakI3YUdteE9LSWxxZ2R5?=
 =?utf-8?B?RFhtWmV1VlN2K29iUEVrbURvLytocVVvNkk4eW01ZUxQck9jaGxnQmk2UC9k?=
 =?utf-8?B?RnNCUEkyZi9GUHRnbXJoMTdDeWw2OS9yeFFnL0cvQzYvR1RKV211YkNWT08w?=
 =?utf-8?B?bzZjSjgzYjA3WE5hdGNIK2VuNVlmZElYNGEranAranA2M3VCRWQ2aHMzeVJ1?=
 =?utf-8?B?ZkV3OHp4SlBNWXZHdzBXcjJrNTV4bFR6UkRpbWhjamt2SFRGd0xlT0syd3M1?=
 =?utf-8?B?L0V1STR1NHpxRHZtWjM0Vk5aL095UHNMcXJYZ0ZaRnJHYXRmVVB0SHFLT3Bk?=
 =?utf-8?Q?HGtxqHTU3yJsxrXqLm+cw6Rnv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b760d7fb-faf7-4187-c3c8-08dc8f3ade8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 02:03:38.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IwlcOluLIcgazONkm2qwAdqPmAR/jyd57il/G1WV0EJAk1G5L0/6soZakEiGCvAgNSwDJi/y2gepAuFzShuRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKdW5lIDE4LCAyMDI0IDk6MTggQU0NCj4gDQo+IE9uIE1vbiwgSnVuIDE3LCAyMDI0IGF0IDEx
OjUx4oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gSGksDQo+ID4NCj4gPiBBZnRlciBjb21taXQgYmExNjhiNTJiZjhlICJtbTogdXNl
IHJ3c2VtIGFzc2VydGlvbiBtYWNyb3MgZm9yDQo+ID4gbW1hcF9sb2NrIikgd2FzIHN1Ym1pdHRl
ZCwgd2Ugc3RhcnRlZCBnZXR0aW5nIGEgbG90IG9mIHRoZQ0KPiA+IGZvbGxvd2luZyB3YXJuaW5n
cyBhYm91dCBhIG1pc3NpbmcgbW1hcCB3cml0ZSBsb2NrIGR1cmluZyBWTSBib290Og0KPiA+DQo+
ID4gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ID4gV0FSTklORzogQ1BV
OiAxIFBJRDogNTg2MzMgYXQgaW5jbHVkZS9saW51eC9yd3NlbS5oOjg1DQo+ID4gdHJhY2tfcGZu
X3JlbWFwKzB4MTJiLzB4MTMwDQo+ID4gTW9kdWxlcyBsaW5rZWQgaW46IGFjdF9taXJyZWQgYWN0
X3NrYmVkaXQgdmhvc3RfdmRwYSBjbHNfbWF0Y2hhbGwNCj4gPiBuZm5ldGxpbmtfY3R0aW1lb3V0
IGFjdF9nYWN0IGNsc19mbG93ZXIgc2NoX2luZ3Jlc3MgbWx4NV92ZHBhIHZyaW5naCB2ZHBhDQo+
ID4gb3BlbnZzd2l0Y2ggbnNoIHZob3N0X25ldCB2aG9zdCB2aG9zdF9pb3RsYiB0YXAgaXA2dGFi
bGVfbWFuZ2xlDQo+IGlwNnRhYmxlX25hdA0KPiA+IGlwdGFibGVfbWFuZ2xlIG5mX3RhYmxlcyBp
cDZ0YWJsZV9maWx0ZXIgaXA2X3RhYmxlcyB4dF9jb25udHJhY2sNCj4geHRfTUFTUVVFUkFERQ0K
PiA+IG5mX2Nvbm50cmFja19uZXRsaW5rIG5mbmV0bGluayB4dF9hZGRydHlwZSBpcHRhYmxlX25h
dCBuZl9uYXQgYnJfbmV0ZmlsdGVyDQo+ID4gcnBjc2VjX2dzc19rcmI1IGF1dGhfcnBjZ3NzIG9p
ZF9yZWdpc3RyeSBvdmVybGF5IHJwY3JkbWEgcmRtYV91Y20NCj4gaWJfaXNlcg0KPiA+IGxpYmlz
Y3NpIGliX3VtYWQgc2NzaV90cmFuc3BvcnRfaXNjc2kgaWJfaXBvaWIgcmRtYV9jbSBpd19jbSBp
Yl9jbQ0KPiBtbHg1X2liDQo+ID4gaWJfdXZlcmJzIGliX2NvcmUgZnVzZSBtbHg1X2NvcmUNCj4g
PiBDUFU6IDEgUElEOiA1ODYzMyBDb21tOiBDUFUgMC9LVk0gVGFpbnRlZDogRyAgICAgICAgVw0K
PiA+IDYuMTAuMC1yYzFfZm9yX3Vwc3RyZWFtX21pbl9kZWJ1Z18yMDI0XzA1XzI5XzE3XzA2ICMx
DQo+ID4gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSks
IEJJT1MNCj4gPiByZWwtMS4xMy4wLTAtZ2YyMWI1YTRhZWIwMi1wcmVidWlsdC5xZW11Lm9yZyAw
NC8wMS8yMDE0DQo+ID4gUklQOiAwMDEwOnRyYWNrX3Bmbl9yZW1hcCsweDEyYi8weDEzMA0KPiA+
IENvZGU6IDQ4IDgzIGM0IDA4IGI4IGVhIGZmIGZmIGZmIDViIDVkIDQxIDVjIDQxIDVkIGMzIDQ4
IDgzIGM0IDA4IDQ4IDg5IGVmIDQ4DQo+ID4gODkgZjIgNWIgMzEgYzkgNGMgODkgYzYgNWQgNDEg
NWMgNDEgNWQgZTkgZjUgZmIgZmYgZmYgPDBmPiAwYiBlYiA5YiA5MCAwZiAxZiA0NA0KPiA+IDAw
IDAwIDgwIDNkIGFjIDU5IDk2IDAxIDAwIDc0IDAxIGMzIDQ4IDg5DQo+ID4gUlNQOiAwMDE4OmZm
ZmY4ODgzNTBmOGI4ZTAgRUZMQUdTOiAwMDAxMDI0Ng0KPiA+IFJBWDogMDAwMDAwMDAwMDAwMDAw
MCBSQlg6IDAwMDAwMDAwMDAwMDEwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gUkRYOiBm
ZmZmODg4MTA4MGNhMzAwIFJTSTogMDAwMDAwMDAwMDAwMTAwMCBSREk6IDAwMDAwMDA1NDQwMDMw
MDANCj4gPiBSQlA6IDAwMDAwMDA1NDQwMDMwMDAgUjA4OiBmZmZmODg4MTA2NzMwYTYwIFIwOTog
MDAwMDAwMDAwMDAwMDAwMA0KPiA+IFIxMDogZmZmZjg4ODExNmVlZmY2MCBSMTE6IDAwMDAwMDAw
MDAwMDAwMDAgUjEyOiBmZmZmODg4MzUwZjhiOTE4DQo+ID4gUjEzOiBmZmZmODg4MTQ5Zjk5ZGE4
IFIxNDogMDAwMDAwMDAwMDAwMTAwMCBSMTU6IDAwMDAwMDAwMDAwMDEwMDANCj4gPiBGUzogIDAw
MDA3ZjY3OGQ4MDA3MDAoMDAwMCkgR1M6ZmZmZjg4ODUyYzg4MDAwMCgwMDAwKQ0KPiBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQo+ID4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAw
MDAwMDA4MDA1MDAzMw0KPiA+IENSMjogMDAwMDAwMDAwMDRlNTRmOCBDUjM6IDAwMDAwMDAxMTIy
OTAwMDQgQ1I0OiAwMDAwMDAwMDAwMzcyZWIwDQo+ID4gQ2FsbCBUcmFjZToNCj4gPiAgPFRBU0s+
DQo+ID4gID8gX193YXJuKzB4NzgvMHgxMTANCj4gPiAgPyB0cmFja19wZm5fcmVtYXArMHgxMmIv
MHgxMzANCj4gPiAgPyByZXBvcnRfYnVnKzB4MTZkLzB4MTgwDQo+ID4gID8gaGFuZGxlX2J1Zysw
eDNjLzB4NjANCj4gPiAgPyBleGNfaW52YWxpZF9vcCsweDE0LzB4NzANCj4gPiAgPyBhc21fZXhj
X2ludmFsaWRfb3ArMHgxNi8weDIwDQo+ID4gID8gdHJhY2tfcGZuX3JlbWFwKzB4MTJiLzB4MTMw
DQo+ID4gIHJlbWFwX3Bmbl9yYW5nZSsweDQxLzB4YTANCj4gPiAgdmhvc3RfdmRwYV9mYXVsdCsw
eDZjLzB4YTAgW3Zob3N0X3ZkcGFdDQo+ID4gIF9fZG9fZmF1bHQrMHgyZi8weGIwDQo+ID4gIF9f
aGFuZGxlX21tX2ZhdWx0KzB4MTNkMy8weDIyMTANCj4gPiAgaGFuZGxlX21tX2ZhdWx0KzB4YjAv
MHgyNjANCj4gPiAgZml4dXBfdXNlcl9mYXVsdCsweDc3LzB4MTcwDQo+ID4gIGh2YV90b19wZm4r
MHgyYzUvMHg0YjANCj4gPiAga3ZtX2ZhdWx0aW5fcGZuKzB4ZDcvMHg1MTANCj4gPiAga3ZtX3Rk
cF9wYWdlX2ZhdWx0KzB4MTExLzB4MTkwDQo+ID4gIGt2bV9tbXVfZG9fcGFnZV9mYXVsdCsweDEw
NS8weDIzMA0KPiA+ICBrdm1fbW11X3BhZ2VfZmF1bHQrMHg3ZC8weDYyMA0KPiA+ICA/IHZteF9k
ZWxpdmVyX2ludGVycnVwdCsweDExMC8weDE5MA0KPiA+ICA/IF9fYXBpY19hY2NlcHRfaXJxKzB4
MTZjLzB4MjcwDQo+ID4gID8gdm14X3ZtZXhpdCsweDhkLzB4YzANCj4gPiAgdm14X2hhbmRsZV9l
eGl0KzB4MTEwLzB4NjQwDQo+ID4gIGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKzB4ZGIwLzB4MWMy
MA0KPiA+ICBrdm1fdmNwdV9pb2N0bCsweDI2My8weDZhMA0KPiA+ICA/IGZ1dGV4X3dha2UrMHg4
MS8weDE4MA0KPiA+ICBfX3g2NF9zeXNfaW9jdGwrMHg0YTcvMHg5ZDANCj4gPiAgPyBfX3g2NF9z
eXNfZnV0ZXgrMHg3My8weDFjMA0KPiA+ICA/IGt2bV9vbl91c2VyX3JldHVybisweDg2LzB4OTAN
Cj4gPiAgZG9fc3lzY2FsbF82NCsweDRjLzB4MTAwDQo+ID4gIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDRiLzB4NTMNCj4gPiBSSVA6IDAwMzM6MHg3ZjY3OTE4NmExN2INCj4gPiBD
b2RlOiAwZiAxZSBmYSA0OCA4YiAwNSAxZCBhZCAwYyAwMCA2NCBjNyAwMCAyNiAwMCAwMCAwMCA0
OCBjNyBjMCBmZiBmZiBmZiBmZg0KPiA+IGMzIDY2IDBmIDFmIDQ0IDAwIDAwIGYzIDBmIDFlIGZh
IGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDENCj4gPiBjMyA0
OCA4YiAwZCBlZCBhYyAwYyAwMCBmNyBkOCA2NCA4OSAwMSA0OA0KPiA+IFJTUDogMDAyYjowMDAw
N2Y2NzhkN2ZmNzg4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6DQo+IDAwMDAwMDAwMDAwMDAw
MTANCj4gPiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDBhZTgwIFJDWDog
MDAwMDdmNjc5MTg2YTE3Yg0KPiA+IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAw
MDAwMGFlODAgUkRJOiAwMDAwMDAwMDAwMDAwMDU5DQo+ID4gUkJQOiAwMDAwNTVkYTVlZTIyMDUw
IFIwODogMDAwMDU1ZGE0NGIyODE2MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiBSMTA6IDAw
MDAwMDAwMDAwMDAwMDEgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAw
MA0KPiA+IFIxMzogMDAwMDU1ZGE0NTJiMDVlMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDEgUjE1OiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4gIDwvVEFTSz4NCj4gPiAtLS1bIGVuZCB0cmFjZSAwMDAwMDAw
MDAwMDAwMDAwIF0tLS0NCj4gPg0KPiA+IFRoZSB3YXJuaW5ncyBzaG93IHVwIG9ubHkgd2hlbiB0
aGUgdmRwYSBwYWdlLXBlci12cSBvcHRpb24gaXMgdXNlZA0KPiAoZG9vcmJlbGwNCj4gPiBtYXBw
aW5nIHRvIGd1ZXN0KS4NCj4gPg0KPiA+IFRoZSBpc3N1ZSBzZWVtcyB0byBoYXZlIGV4aXN0ZWQg
YmVmb3JlLCBidXQgd2FzIHZpc2libGUgb25seSB3aXRoDQo+IENPTkZJR19MT0NLREVQDQo+ID4g
ZW5hYmxlZC4gSSB0cmllZCBmaW5kaW5nIGlmIHRoaXMgd2FzIGludHJvZHVjZWQgaW4gbW9yZSBy
ZWNlbnQga2VybmVscywgYnV0DQo+ID4gc3RvcHBlZCBhZnRlciBnb2luZyBhcyBmYXIgYmFjayBh
cyA2LjU6IHRoZSBpc3N1ZSB3YXMgc3RpbGwgdmlzaWJsZSB0aGVyZS4NCj4gPg0KPiA+IFRoZSB3
YXJuaW5nIGlzIHRyaWdnZXJlZCBmb3IgdGhlIGZvbGxvd2luZyBjYWxsIGNoYWluOg0KPiA+IHZo
b3N0X3ZkcGFfZmF1bHQoKQ0KPiA+ICAtPiByZW1hcF9wZm5fcmFuZ2UoKQ0KPiA+ICAgLT4gcmVt
YXBfcGZuX3JhbmdlX25vdHJhY2soKQ0KPiA+ICAgIC0+IHZtX2ZsYWdzX3NldCgpDQo+ID4gICAg
IC0+IHZtYV9zdGFydF93cml0ZSgpDQo+ID4gICAgICAtPiBfX2lzX3ZtYV93cml0ZV9sb2NrZWQo
KQ0KPiA+ICAgICAgIC0+IG1tYXBfYXNzZXJ0X3dyaXRlX2xvY2tlZCgpDQo+ID4NCj4gPg0KPiA+
IEkndmUgYmVlbiB0cnlpbmcgdG8gZm9sbG93IGhvdyB0aGUgbW0gd3JpdGUgbG9jayBpcyBkcm9w
cGVkIGluIHRoZSBhYm92ZQ0KPiBjYWxsDQo+ID4gY2hhaW4gb3Igbm90IHRha2VuIGF0IGFsbC4g
QnV0IEkgY291bGRuJ3QgbWFrZSBtdWNoIHNlbnNlIG9mIGl0Li4uDQo+IA0KPiBJJ3ZlIGFsc28g
aGFkIGEgZ2xhbmNlIGF0IHZmaW9fcGNpX21tYXBfZmF1bHQsIGl0IHNlZW1zIHRvIGRvIHNvbWV0
aGluZw0KPiBzaW1pbGFyLg0KPiANCj4gPiBBbnkgaWRlYXMgb2Ygd2hhdCBjb3VsZCBoYXZlIGdv
bmUgd3JvbmcgaGVyZT8NCj4gDQo+IEFkZGluZyBQZXRlciBmb3IgbW9yZSB0aG91Z2h0IGhlcmUu
DQo+IA0KDQp2ZmlvLXNpZGUgZml4IHdhcyBqdXN0IHF1ZXVlZCBmb3IgcmM0Og0KDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA2MTQxNTU2MDMuMzQ1NjdlYjcuYWxleC53aWxsaWFt
c29uQHJlZGhhdC5jb20vVC8NCg==
