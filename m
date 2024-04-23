Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9298208D7
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850824; cv=fail; b=E9yEcrYBRTjISKWWknfn8jQYnwTEUdNJ7YX7Z1Tt/xsgKRgQGl4L43rpZPZQkizINhunfLAwS+iZCgjfRP5ridFxurS1e5GAVxT6PEyeM6hhuo3dpVC/Qm7KBm1Le2KGQS9A5JaPLh4jn+41upVmnzt1GO96kwOFcxv9WeJIFgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850824; c=relaxed/simple;
	bh=N9KqGNLheeE5bwvHWs1U5fRMAnHr5GVDmsafDVoHWvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYfdpkW0mW3ScSZEtPZ71LYRobf2aMRo/PHHnFZyXq9xVjf5mm+AWg5UKFlRnaRIMCZKKuD8Zpw/VrFoYnzxFJydNL8FK1jcKBKSWdiKIIg/bmSf6rZWjA3MCVBUUo9CSWVSHY9QCgHqNgA8wC0/LwixBWq1XTmcQG1JwWX2hh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mfP1KFpA; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mfP1KFpA"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MJ66uw011793;
	Mon, 22 Apr 2024 22:40:15 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xnngcuyrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEmkRq7h488NuS2xpSAGsJ5PPLyK4KTI5Q7dXuWwWdNb+NNj+mzRtAO4UUbbl4TWFoyjQhLtVEAEGvFvkW2hJhGBEii2p3G3GOhMFZhFMjP+6yNGU5V6mXZ3GodtFcpwkfhlKGOgj83LCZwPfIokxeT9SqGBybAuB0Ut/o/Z9Uc9gMFHF8ycKN5inD7acWfZwDd3XZyAj0t8e2l+dYdFOLpuYhlbdqfThRFp+HeOtkTuWpyMSM9lrH1fYraxxhX7m6wlBZSQ/2mND0J12kBwzGgtGTOM8rfS7wRrOChE4My+g/HkWgc7Bdx3aRQYDazbl6uV7Zh5UXUlruAim6DUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9KqGNLheeE5bwvHWs1U5fRMAnHr5GVDmsafDVoHWvU=;
 b=imqsrXm5A5fAogW2q91tLwn43zgAVlKI3KBVUR27V3cN03lzWc9i/H69Qi9x4O+QRuKPAbL8Vs1eVeBMT1YSEhkRqHJjNfR7WUraR5wnlJRCY5tKN6tyN75uxdKHPPGEqIo2iJVa3a5wO/YRoTuAqiAOuTyXZBNOVKDTbK1T4PbJ1J+vs1xDvhweIm8CvfBCmugQ1cCeEq4O0kbAfMPggP7M2HZ4sTpSTg+iUxlrx4pY3xBhXOC6kclL34aiJa7YRF0w5JFawTmqSTcl77k0VnU+BY4wCADXJbdZ5iVSGKU6x6EAq0GmDuQv+MKf56YsPcuprDBn30A+WR0Uu9zoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9KqGNLheeE5bwvHWs1U5fRMAnHr5GVDmsafDVoHWvU=;
 b=mfP1KFpAeIHoomlrtAOVza3oYqOnLSItjZqa9JLMMV5zdUbXL4e4rTYsh95Nlm+XikQjtUHdePuvh3tf5+gS2Tc90B/hoa7miSvpYZw2lv6uAkplumE/E/QvRLKIAFh3pXUkL2yh+L1Qkpt+nkUfj04fzJZJxkEzCQkvtprLocg=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by PH0PR18MB4921.namprd18.prod.outlook.com (2603:10b6:510:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:40:10 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::dbb9:f11e:dc25:d2f8]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::dbb9:f11e:dc25:d2f8%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 05:40:10 +0000
From: Srujana Challa <schalla@marvell.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Vamsi Krishna
 Attunuru <vattunuru@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
        Jerin Jacob
	<jerinj@marvell.com>, eperezma <eperezma@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Topic: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Index: 
 AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQgAAU+ACAAAv1kIABLXgAgAGCvNCAABqmgIAALTNQgASL+ACAAFOSAIABA74AgAsnOPA=
Date: Tue, 23 Apr 2024 05:40:10 +0000
Message-ID: 
 <DS0PR18MB5368128C81833B8257B76632A0112@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240410071350-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
 <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com>
 <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEtR-eEc3-MEMMvixZ4w93wNoJjeuqhgNsP=62oZfZHd5A@mail.gmail.com>
 <PH7PR18MB535426965C489176FA9D8281A0092@PH7PR18MB5354.namprd18.prod.outlook.com>
 <CACGkMEtMvb6HOebVxjn8070+PvtPp=9FAvuNA6uKd4NK+L996Q@mail.gmail.com>
In-Reply-To: 
 <CACGkMEtMvb6HOebVxjn8070+PvtPp=9FAvuNA6uKd4NK+L996Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mst@redhat.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|PH0PR18MB4921:EE_
x-ms-office365-filtering-correlation-id: 783ae445-2467-4cf6-7fb6-08dc6357d711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NlRTSXdBYy90b2pKSittN0dsanRYNHQ2N08vdVI2T3hES1RIOG9oYXBTZUhX?=
 =?utf-8?B?cFlyS2RGUmdCSGQ4cG9NV01pMi9XZ2VBWmF5NFd4aEN3YVZ0MHlleHg0RHdF?=
 =?utf-8?B?ektrOVdIN3lyZnA5OVhnWFVGTWR3b1dPTlVOdFhaNHlYb0pFOHRnUlVSa01O?=
 =?utf-8?B?b0RRSENzMjJsSVAxUU9peXhSbXIzdEpOamphZzBDWFIyd0Y1VHltNFIrMUpl?=
 =?utf-8?B?eDc3QjYzRXMwcDBHTWIxS01PY2U3OW13bjRTR2N4RXNXRTVJOUs2d0Rwdmgv?=
 =?utf-8?B?YTVYcjlmcXJWdS9EQ1hMSkYvNVMxMHZyOHM1eWdTOHpSVzQxbWg3TTNNdTR2?=
 =?utf-8?B?UUFUYmhzamp5WFpuTzUxZlM1M2xKUGFFMjdRM2FYNWx2SGdOMFNTUnFWcEFZ?=
 =?utf-8?B?S2xlVzVHR0cvV3ViZHI2MmNBOG5janVpazVQTGNxL2N3L3BQTi9YZEwyY3hJ?=
 =?utf-8?B?Vk5TQjg4WVR2TXJTT1hzUWViOEQ0bnc5aXNhclNZK2RpKzEzNEtsUG9TRTMz?=
 =?utf-8?B?NEFnaEF3c0J6MVUwYS9Ld040b1UraDJRVHl4OVFyV3I3L09ZRnJpdUhXYUtn?=
 =?utf-8?B?a1JlNXg5ZmpsSFBad1ZoNVA5Tll1UFFEQkFlNlNKbXl5c1dJVzQ3cHRkck1W?=
 =?utf-8?B?b1plSWhINXJ1UVJPd2hpd3N1c0FSZVF4c0dJSGVxRjVvQkUvTnlFMXZEVUNB?=
 =?utf-8?B?RHJRalBoMVpUdUZXSUNSZ0t3WlhiV2tQV3FiZy81bm9FbHBGK1RjTC8xeExy?=
 =?utf-8?B?djhQdFpISzRzcFk3V1dkdEVmUndyV2IvaTBieTdpK3NZWW1SN1JrMmt1b2Fn?=
 =?utf-8?B?ay9qbXBLSTFybE9URGVSandIeWZMZ1NlUlNXTWNaRkpxSThIdjVIcGttejFQ?=
 =?utf-8?B?UTUzMXhRUHBQeGlZRWoreXpJNHdnTU5vbnZBa1VubllUR2dqa1d4ckxzWWlk?=
 =?utf-8?B?b3lEOU5OeDdrcnpyWTZqbFBjU1UvNXhSbk0zTi80UFMvR0kwSkFkc3BOdDRR?=
 =?utf-8?B?VmM5MU5TcXdaRmw0b3RzZmE4Uy9KVVUvcDd5Q1dDQVAxdEduelFYT3Z5Rlpt?=
 =?utf-8?B?OHRnVzJidmZNbHRZWnVIT1F5b3hIZm1mTVdiemV1WExIcVZWcHZSYVlKSlo5?=
 =?utf-8?B?UUtURjBNTW1wVHRqK25pSUhXb1Z2Q1VkWkhpaXkrNmZZSWRnUmMvb2dyU1ZL?=
 =?utf-8?B?UXlYSjdkei9rYkRMaXNuODFDR1NVV3NraUFYQStaY2liVVQyWGJueVFOeXRK?=
 =?utf-8?B?S1hPWk1Oa2w2SUFMUW9KaFlReXIrNk1sNkRoYU4xcTRnR0YyQWwvK0pBREp6?=
 =?utf-8?B?YnBQUDBaRGVuQ1ozRlFUd0t4eHgvc2lkQjhvbTlNRTVadFU0UUJBVjdNcHdH?=
 =?utf-8?B?YkRvTkhwRU94QmhKd0Rra0dVbHdIM2YxZGxjd1dmL1VuUDZCL2tmUkkvSHVq?=
 =?utf-8?B?Y1RZWHEvOCsvN1BDdUNOYzdFd00vcEpKalgyMzl1V2x3QXBwM1JMUExPUWx4?=
 =?utf-8?B?bE5Tb3kvTmVmZmRLcTVubmJ5amN0Vmc4MmluNXZhTG5lWnB0NjVPcG1nZ2s2?=
 =?utf-8?B?Qm43ajBGaThpZ2U0aklIYmFCb0pGTm1OQ2k1a0s4ckJkcTFOWXloL0ZWVE9i?=
 =?utf-8?B?TXMybEhDQytlU2dUN3NmdThpZkN3VEtVWUVKbTlVN2pjQ1JmSStlSWlhUGNz?=
 =?utf-8?B?eWFIZUNxWHk2YlhBdURXVEVKelp6YUZsc01VRlNMSSs0K09FRmk0cUE1ekUz?=
 =?utf-8?B?NDJkTmhlYkNHK1dnWE1zM3RsTWpNaEEzNGd2K2RYU0k0WWptcUllVkZ5eDYw?=
 =?utf-8?B?VTJKTmV2MWZKTGJyQkpudz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SzhpSWRZSUI2Q3c2b01EaFQ5RVNPODdXa3R3TS9PSitNeC9YTm83OWNxeTFN?=
 =?utf-8?B?U0Rpbk0rU0IrL203a2hHOE50K0o2eG9TbmVta1JRcjdOYWprVlJjREU2NnVv?=
 =?utf-8?B?TFc5NTV2U3RxRTE0cklOWTc1OTJhanJGSXF4LzAva0RxVXJOd056SkdKVllR?=
 =?utf-8?B?ZzNGeEhoanhHSHVNelNPb3ltNnhIR3ViVVRSb3d6d0d3L2hiQlRtbjlGRFJG?=
 =?utf-8?B?RkptMFBwbk1Pb3NKZ1htb1hXV3ZMd0g5N1RISjFUeVhBcVh5ZFlhWjY2UXQ5?=
 =?utf-8?B?ZnpJSGZEN3c0ejJxY3lkUlZqQS8vUkh0d0FtOEsvVk5VL0lDYjdCUTJNWmNx?=
 =?utf-8?B?ZUd1K0pNMkVEV2E1eU94VFhQUlJYTzR0OUY2RHBKd29kWTY2Snh1M3RnRW9m?=
 =?utf-8?B?cFNWU1lNUVh2SncvMkNtRlJxVWg2MUNxS05YSTBEYzNwbGhVU3lFNktKVldq?=
 =?utf-8?B?WjBjdE1DSHc5S3h5YmJyYjFkdDFCdUdkTkx0WDdMckNVY0RPOTlYM0ZCT0RR?=
 =?utf-8?B?aDdiYytrTWREeHRiNms3WlFVR0ZQVDA3NzJQNVhNQXdpVDI1NHU2MXBqSDdi?=
 =?utf-8?B?eS85c3Y3NGtyNWJFaVpiU29jR2FmSzZ2SmQ3UWpQVzhMR2lnMkZieEkzU1lB?=
 =?utf-8?B?UVhzdXR3Y2pHUHFWZHNnNzEvWWh4WXhreGVuR2dhUTd1UlJFeC8yNzNTYXdq?=
 =?utf-8?B?Ty9XVFBrQytmZVozbUE2MzMxa2pQUVdWL1dWN1JlWFVrdnowM2NKc1pZY2x2?=
 =?utf-8?B?dDlOUXNUY1E4SkYrT2JOV3UySFNsSGg1VEt1cjVsS2VoMDJZUmVKeUxBSm9S?=
 =?utf-8?B?ZTBMbWtFQTlwWWVxVVZscUlUVWpIYXdDclczSkowZi9vVWgyVVRnbU5tZ3Zz?=
 =?utf-8?B?VmN2QWFKc214eFBCK3VXaEZqNEpheTFPZXlMZG1FaURpbGFES0NOaWVRNnhW?=
 =?utf-8?B?Vnh3b3d3ZkRoWEtjU3BTTndGVDJnNlFwKzZ4TEFhZlQxMU1xckxLd2tGWU91?=
 =?utf-8?B?UkdyVmpoSzZWWFp6U2dqNXdyZXh4M0VYdjE1Z1RHcy84aVpKanNKcTl6VFdX?=
 =?utf-8?B?clFWY3Z0ZGIrc2QwQzA4WWlCOVR1bFZLdGdOeWhKLzVCakxObmdPVWcrTXBW?=
 =?utf-8?B?a283OTdWK015TDNhUUVBcGUwZFkrQ3JOWkNOM0d5Q1hJaFI2UFBTaDlaSHE1?=
 =?utf-8?B?WjdRVkV2a3k3QjArN3RHREVQNElKOHNhd2hnV1Z0Wmt2aWZ0SE1oZEs5S2xx?=
 =?utf-8?B?c3VTZnQ0Rjlib1g4dDZsTmMyZFhHQ0tSdzRmVFBrUlcyM3dUTE5JRW93UVVP?=
 =?utf-8?B?OUNwcTN3dWV2YUR1ZjZUUERIcS9kcERuRGhwZjh4clhYVUx0OHhxSHRhNUho?=
 =?utf-8?B?L0NTT09sZnJXZXdPbGRwL1RyNmVkSFBtM3JZaTgwQjZoZE9BaHVYTkZUUUxi?=
 =?utf-8?B?NGRPVzB0bSszRzk2ZnZsTUFNRlFOOGxPUlJGWkt2SXZwYW5sSjQ1UnllVHZX?=
 =?utf-8?B?RHUrQ0R0Wm1lQjhYNDNBclVnVG16Y1BEWmxTcU9rM3czRUtLOFpVMnpqTm9m?=
 =?utf-8?B?MTA3amswL1lCT2RQTUxNcjV6QXpKZUV6NHBadUR4R2dlaUNYQ3RHWSt0VzNQ?=
 =?utf-8?B?WGtnT1dCU0oyNzN3aDZFWXUvV2VqSFJEcDdnSk1LV1ViMnlNbmttNG5HSDZL?=
 =?utf-8?B?RlVoVWpHeGtPVHdWQ1JtY1FhTUJ3aWNCR1Y5ZkFGRWNQeXFOcjY2dWpoZG1N?=
 =?utf-8?B?REM2MnQ1UXpqaml1ckRkNWhqeVkzeEk5a1FCL0d3THBEMm9obll1aEh2bm5O?=
 =?utf-8?B?QjAxSjNYUmJmRWx0YU1XVFlSTEJMNDU3a05LMk9mSDhEVkZqYnBnUzNwUysw?=
 =?utf-8?B?NjZaTHhxNTNaKzRsMTJoR1ZKQ3dLb2hMby9kM1l6WEN3bEgweUcvbk1qc3Z3?=
 =?utf-8?B?SVozaWQ3a0F0ZCtUcVFaUkROb01iczhMWXJDREsxUnJmR0ZkKzhJelBMSVJz?=
 =?utf-8?B?Qnl4MnV4VVNJV2ZUR2ZJQU9qYnlKUjFUQ2FlVEEvdkt5a2hIY2ZubVVjZC9E?=
 =?utf-8?B?TTV0ZmFYc3VlejlxMGRac2hWRlFoZlJIMlNMRyt5LzZyTEVYcUVEcWZZMEV2?=
 =?utf-8?Q?AsFU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783ae445-2467-4cf6-7fb6-08dc6357d711
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 05:40:10.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLn8vlI/wpNB5DJvfVJLNHzccexWMipa8F4njNrISZMrhIzc1O/A1Gtc1gz6eU972HYS9ElCuj4uRgxHwagMWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4921
X-Proofpoint-GUID: HkyTm2l96alj9V5luMcTOrp_pt_yR0rB
X-Proofpoint-ORIG-GUID: HkyTm2l96alj9V5luMcTOrp_pt_yR0rB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02

PiA+ID4gPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gdmly
dGlvOiB2ZHBhOiB2RFBBDQo+ID4gPiA+ID4gPiA+ID4gPiBkcml2ZXIgZm9yIE1hcnZlbGwgT0NU
RU9OIERQVSBkZXZpY2VzDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gT24g
V2VkLCBBcHIgMTAsIDIwMjQgYXQgMTA6MTU6MzdBTSArMDAwMCwgU3J1amFuYSBDaGFsbGENCj4g
d3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ICsgICAgICAgZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KGRldik7
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBpZiAoIWRvbWFpbiB8fCBkb21h
aW4tPnR5cGUgPT0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArIElPTU1VX0RPTUFJTl9J
REVOVElUWSkNCj4gPiA+ID4gPiA+ID4gew0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJOTy1JT01NVVxuIik7DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIG9jdGVwX3ZkcGFfb3BzLnNldF9tYXAgPQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgb2N0ZXBfdmRwYV9zZXRfbWFwOw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJcyB0aGlzIGEg
c2hvcnRjdXQgdG8gaGF2ZSBnZXQgYmV0dGVyIHBlcmZvcm1hbmNlPw0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBETUEgQVBJIHNob3VsZCBoYXZlIHRob3NlIGdyZWFjZWZ1bGx5IEkgdGhpbmsu
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGVuIElPTU1VIGlzIGRpc2FibGVkIG9uIGhvc3Qg
YW5kIHNldF9tYXAvZG1hX21hcA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaXMgbm90IHNldCwg
dmhvc3QtdmRwYSBpcyByZXBvcnRpbmcgYW4gZXJyb3INCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ICJGYWlsZWQgdG8gYWxsb2NhdGUgZG9tYWluLCBkZXZpY2UgaXMgbm90DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gSU9NTVUgY2FjaGUgY29oZXJlbnQgY2FwYWJsZVxuIi4NCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IEhlbmNlIHdlIGFyZSBkb2luZyB0aGlzIHdheSB0byBnZXQgYmV0dGVyIHBlcmZv
cm1hbmNlLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhl
IHByb2JsZW0gaXMsIGFzc3VtaW5nIHRoZSBkZXZpY2UgZG9lcyBub3QgaGF2ZQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGFueSBpbnRlcm5hbA0KPiA+ID4gPiA+ID4gPiBJT01NVS4NCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDEpIElmIHdlIGFsbG93IGl0IHJ1
bm5pbmcgd2l0aG91dCBJT01NVSwgaXQgb3BlbnMgYQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHdp
bmRvdyBmb3IgZ3Vlc3QgdG8gYXR0YWNrIHRoZSBob3N0Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IDIpIElmIHlvdSBzZWUgcGVyZm9yYW1uY2UgaXNzdWUgd2l0aA0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IElPTU1VX0RPTUFJTl9JREVOVElUWSwgbGV0J3MgcmVwb3J0IGl0IHRvIERNQS9JT01NVQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IG1haW50aW5lciB0byBmaXggdGhhdA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiBJdCB3aWxsIGJlIGhlbHBmdWwgZm9yIGhvc3QgbmV0d29ya2luZyBjYXNlIHdoZW4g
aW9tbXUgaXMNCj4gZGlzYWJsZWQuDQo+ID4gPiA+ID4gPiA+ID4gPiA+IENhbiB3ZSB0YWtlIHRo
ZSB2ZmlvIHBjaSBkcml2ZXIgYXBwcm9hY2ggYXMgYQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiByZWZl
cmVuY2Ugd2hlcmUgdXNlciBleHBsaWNpdGx5IHNldA0KPiAiZW5hYmxlX3Vuc2FmZV9ub2lvbW11
X21vZGUiDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHVzaW5nIG1vZHVsZQ0KPiA+ID4gPiA+IHBhcmFt
Pw0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IHZmaW8gaXMgYSB1c2Vyc3Bh
Y2UgZHJpdmVyIHNvIGl0J3MgdXNlcnNwYWNlJ3MgcmVzcG9uc2liaWxpdHkuDQo+ID4gPiA+ID4g
PiA+ID4gPiB3aGF0IGV4YWN0bHkgZW5zdXJlcyBjb3JyZWN0bmVzcyBoZXJlPyBkb2VzIHRoZSBk
ZXZpY2UNCj4gPiA+ID4gPiA+ID4gPiA+IGhhdmUgYW4gb24tY2hpcCBpb21tdT8NCj4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gT3VyIGRldmljZSBmZWF0dXJlcyBhbiBvbi1jaGlw
IElPTU1VLCBhbHRob3VnaCBpdCBpcyBub3QNCj4gPiA+ID4gPiA+ID4gPiB1dGlsaXplZCBmb3Ig
aG9zdC1zaWRlIHRhcmdldGVkIERNQSBvcGVyYXRpb25zLiBXZQ0KPiA+ID4gPiA+ID4gPiA+IGlu
Y2x1ZGVkIG5vLWlvbW11IG1vZGUgaW4gb3VyIGRyaXZlciB0byBlbnN1cmUgdGhhdCBob3N0DQo+
ID4gPiA+ID4gPiA+ID4gYXBwbGljYXRpb25zLCBzdWNoIGFzIERQREsgVmlydGlvIHVzZXIgUE1E
LCBjb250aW51ZSB0bw0KPiA+ID4gPiA+ID4gPiA+IGZ1bmN0aW9uIGV2ZW4gd2hlbiBvcGVyYXRp
bmcgaW4gYSBuby0NCj4gPiA+ID4gPiBJT01NVSBtb2RlLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgc2V0X21hcCgpIGlzIGVtcHR5IGluIHRo
aXMgZHJpdmVyLg0KPiA+ID4gPiA+ID4gPiBIb3cgY291bGQgc3VjaCBpc29sYXRpb24gYmUgZG9u
ZT8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJbiBuby1pb21tdSBjYXNlLCB0aGVyZSB3b3Vs
ZCBiZSBubyBkb21haW4gcmlnaHQsIGFuZCB0aGUgdXNlcg0KPiA+ID4gPiA+ID4gb2Ygdmhvc3Qt
dmRwYShEUERLIHZpcnRpbyB1c2VyIHBtZCksIHdvdWxkIGNyZWF0ZSB0aGUgbWFwcGluZw0KPiA+
ID4gPiA+ID4gYW5kIHBhc3MgdGhlIFBBICg9IElPVkEpIHRvIHRoZSBkZXZpY2UgZGlyZWN0bHku
IFNvIHRoYXQsDQo+ID4gPiA+ID4gPiBkZXZpY2UgY2FuIGRpcmVjdGx5IERNQSB0byB0aGUNCj4g
PiA+ID4gPiBQQS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFllcywgYnV0IHRoaXMgZG9lc24ndCBk
aWZmZXIgdG9vIG11Y2ggZnJvbSB0aGUgY2FzZSB3aGVyZSBETUENCj4gPiA+ID4gPiBBUEkgaXMg
dXNlZCB3aXRoIElPTU1VIGRpc2FibGVkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQXJlIHlvdSBz
YXlpbmcgRE1BIEFQSSBpbnRyb2R1Y2VzIG92ZXJoZWFkcyBpbiB0aGlzIGNhc2U/DQo+ID4gPiA+
IE5vIGFjdHVhbGx5LCBjdXJyZW50IHZob3N0LXZkcGEgY29kZSBpcyBub3QgYWxsb3dpbmcgSU9N
TVUNCj4gPiA+ID4gZGlzYWJsZWQgbW9kZSwgSWYgc2V0X21hcC9kbWFfbWFwIG9wIGlzIG5vdCBz
ZXQuIEhlbmNlLCB3ZSBhcmUNCj4gPiA+ID4gc2V0dGluZyBzZXRfbWFwIHdpdGggZHVtbXkgYXBp
IHRvIGFsbG93IElPTU1VIGRpc2FibGVkIG1vZGUuDQo+ID4gPiA+DQo+ID4gPiA+IEZvbGxvd2lu
ZyBpcyB0aGUgY29kZSBzbmlwcGV0IGZyb20gZHJpdmVycy92aG9zdC92ZHBhLmMNCj4gPiA+ID4N
Cj4gPiA+ID4gICAgICAgLyogRGV2aWNlIHdhbnQgdG8gZG8gRE1BIGJ5IGl0c2VsZiAqLw0KPiA+
ID4gPiAgICAgICAgIGlmIChvcHMtPnNldF9tYXAgfHwgb3BzLT5kbWFfbWFwKQ0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgYnVzID0g
ZG1hX2Rldi0+YnVzOw0KPiA+ID4gPiAgICAgICAgIGlmICghYnVzKQ0KPiA+ID4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICBpZiAoIWRl
dmljZV9pb21tdV9jYXBhYmxlKGRtYV9kZXYsDQo+ID4gPiBJT01NVV9DQVBfQ0FDSEVfQ09IRVJF
TkNZKSkNCj4gPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+ID4gPg0K
PiA+ID4gUmlnaHQsIHNvIGhlcmUncyB0aGUgcXVlc3Rpb24uDQo+ID4gPg0KPiA+ID4gV2hlbiBJ
T01NVSBpcyBkaXNhYmxlZCwgaWYgdGhlcmUncyBubyBpc29sYXRpb24gZnJvbSB0aGUgZGV2aWNl
DQo+ID4gPiBvbi1jaGlwIElPTU1VLiBJdCBtaWdodCBoYXZlIHNlY3VyaXR5IGltcGxpY2F0aW9u
cy4gRm9yIGV4YW1wbGUgaWYNCj4gPiA+IHdlJ3JlIHVzaW5nIFBBLCB1c2Vyc3BhY2UgY291bGQg
YXR0YWNrIHRoZSBrZXJuZWwuDQo+ID4gPg0KPiA+ID4gU28gdGhlcmUgc2hvdWxkIGJlIHNvbWUg
bG9naWMgaW4gdGhlIHNldF9tYXAoKSB0byBwcm9ncmFtIHRoZQ0KPiA+ID4gb24tY2hpcCBJT01N
VSB0byBpc29sYXRlIERNQSBpbiB0aGF0IGNhc2UgYnV0IEkgZG9uJ3Qgc2VlIHN1Y2gNCj4gPiA+
IGltcGxlbWVudGF0aW9uIGRvbmUgaW4gc2V0X21hcCgpLg0KPiA+DQo+ID4gT3VyIGNoaXAgbGFj
a3Mgc3VwcG9ydCBmb3Igb24tY2hpcCBJT01NVSBmb3IgaG9zdC1zaWRlIHRhcmdldGVkIERNQQ0K
PiBvcGVyYXRpb25zLg0KPiA+IFdoZW4gdXNpbmcgdGhlIERQREsgdmlydGlvIHVzZXIgUE1ELCB3
ZeKAmXZlIG5vdGljZWQgYSBzaWduaWZpY2FudCA4MCUNCj4gPiBwZXJmb3JtYW5jZSBpbXByb3Zl
bWVudCB3aGVuIElPTU1VIGlzIGRpc2FibGVkIG9uIHNwZWNpZmljIHg4Ng0KPiA+IG1hY2hpbmVz
LiBUaGlzIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGNhbiBiZSBsZXZlcmFnZWQgYnkgZW1iZWRk
ZWQNCj4gPiBwbGF0Zm9ybXMgd2hlcmUgYXBwbGljYXRpb25zIHJ1biBpbiBjb250cm9sbGVkIGVu
dmlyb25tZW50Lg0KPiA+IE1heSBiZSBpdCdzIGEgdHJhZGUtb2ZmIGJldHdlZW4gc2VjdXJpdHkg
YW5kIHBlcmZvcm1hbmNlLg0KPiA+DQo+ID4gV2UgY2FuIGRpc2FibGUgdGhlIG5vLWlvbW11IHN1
cHBvcnQgYnkgZGVmYXVsdCBhbmQgZW5hYmxlIGl0IHRocm91Z2gNCj4gPiBzb21lIG1vZHVsZSBw
YXJhbWV0ZXIgYW5kIHRhaW50IHRoZSBrZXJuZWwgc2ltaWxhciB0byBWRklPDQo+IGRyaXZlcihl
bmFibGVfdW5zYWZlX25vaW9tbXVfbW9kZSkgcmlnaHQ/DQo+IA0KPiBDb3VsZCBiZSBvbmUgd2F5
Lg0KPiANCj4gTWljaGFlbCwgYW55IHRob3VnaHRzIG9uIHRoaXM/DQoNCkBNaWNoYWVsIFMuIFRz
aXJraW4gQ291bGQgeW91IGNvbmZpcm0gb24gYWJvdmUuIEkgd2lsbCBzZW5kIHRoZSB2MiBpZiBp
dCBpcyBmaW5lIGZvciB5b3UuDQoNClRoYW5rcw0KPiANCj4gVGhhbmtzDQo+IA0KPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gUGVyZm9ybWFuY2UgZGVncmFkYXRpb24gd2hlbiBpb21tdSBlbmFibGVk
IGlzIG5vdCB3aXRoIERNQSBBUEkgYnV0DQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiB4ODYgSFcgSU9N
TVUgdHJhbnNsYXRpb24gcGVyZm9ybWFuY2Ugb24gY2VydGFpbiBsb3cgZW5kIHg4Ng0KPiBtYWNo
aW5lcy4NCj4gPiA+DQo+ID4gPiBUaGlzIG1pZ2h0IGJlIHRydWUgYnV0IGl0J3Mgbm90IHNwZWNp
ZmljIHRvIHZEUEEgSSB0aGluaz8NCj4gPiA+DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBXZSBvYnNlcnZlZCBwZXJmb3JtYW5jZSBpbXBh
Y3RzIG9uIGNlcnRhaW4gbG93LWVuZCB4ODYNCj4gPiA+ID4gPiA+ID4gPiBtYWNoaW5lcyB3aGVu
IElPTU1VIG1vZGUgd2FzIGVuYWJsZWQuDQo+ID4gPiA+ID4gPiA+ID4gSSB0aGluaywgY29ycmVj
dG5lc3MgaXMgSG9zdCB1c2Vyc3BhY2UgYXBwbGljYXRpb24ncw0KPiA+ID4gPiA+ID4gPiA+IHJl
c3BvbnNpYmlsaXR5LCBpbiB0aGlzIGNhc2Ugd2hlbiB2aG9zdC12ZHBhIGlzIHVzZWQgd2l0aA0K
PiA+ID4gPiA+ID4gPiA+IEhvc3QgYXBwbGljYXRpb24gc3VjaCBhcyBEUERLDQo+ID4gPiA+ID4g
PiA+IFZpcnRpbyB1c2VyIFBNRC4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhhbmtz
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiBUaGFua3MuDQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4NCg0K
