Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410315CD6D
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963945; cv=fail; b=t/LQQABMbbhs54grferr61ZvtcraZiaXF3+zsu+17CHgjYU1agwgkuS0lnF06sAJy4XpIHL9tccYRdWL0TtAoSS96S52SVxAjuXscO02s12zm0IE3w8Q6cOAl9tWHi+2rBo0YWaQOwV/ifjM9h/kFfWxON6Ngp7nLuZjaxQD2sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963945; c=relaxed/simple;
	bh=tpScNstgN6O5ILbnR5B/2V3X7rWrqSW8JgYbiByY8JE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BqZsRP6D3gptIiT+wSBX4j+WW7ejEsNGMyqirjubf9RTLdpBeaJ3q0EyWLArQOqgprBaYilBRqafNI88c7LCAtCHZRVuSp/E/MfEnRJFENd+zMSzHWOpdy8AZg14yeCLLh8ql/OHHgNL27jqLC1/1wFDZPMfVA4KNlUv95keGNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=EF1dRw3P; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="EF1dRw3P"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OCaeis026703;
	Wed, 24 Apr 2024 06:05:28 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xq28482mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3s92Q6UaAZQarbQqHxlAOMafvCZK64I4EG+lBficiSwOEpgwxmHFDmHdrkwFXoFjLIHJCbewQ85EyBAKogqPX1WJCUFZQxwWkRXGx2QG3D2GqBryQWSccS3Umo7IEJmLOQ44FwvdVqVllATYAcNG5fTR2VmfbqWykqyXyHC9WcehcT/alnuTJPUpdfHGvEieXC2nBLs/iPr2yA5InTwltCPtqC0Sv2NVM4HJnOKRWzINHPN+NdhLl4rNRdmuGwLxXZRn3HNXyieIMi45nFsH1oWll12OphFk+ZC4Ka4lWnQZKT8Jd1wBa2qmuc7DZWzq0B4g6d5STidZ2wSq38gCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpScNstgN6O5ILbnR5B/2V3X7rWrqSW8JgYbiByY8JE=;
 b=hw6X6ztzH/37g+Sq+g/N3zdECMw+pA4D+FXIFS0x0gHFwwSI42y5/UP1FH3C83jTX6LerwBGQ5P23myL2PKy2NBKDWm1XO9d+MsS64Fq48gBTDAv7MSK77DPA1/WEELsOStUEBwV98dyuRrWXhRq+08cd+riBUxcPl0taY8qmqyAuDEEx9LKAS9NdtrVLv3FpHS2eR2cyVhqUXp8xTeSuOOmQwzMeQ14ctWZgYKrmescwUv4dBB2AYc27YQiW6v4Y2FTRD/kQ7VnUEbJBUnoadkDydceQ2pzvksiyiBnRgpWfgDVsodlBpIc0KiWKUfdSqE+990p4FcM+g8irhdryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpScNstgN6O5ILbnR5B/2V3X7rWrqSW8JgYbiByY8JE=;
 b=EF1dRw3P4QqqhWxDraKzbUejBjaZGV8nFHi7wn5pcxme6VGVsTSSL3v2iIeGQYbP9lYITksJGx9W3HV0zx5rhHvT+q7JxnoCn283zTquAtq6xrtE2DLJVTsrCy2LeAspWI1O4CnphF7hprQY2ovHDqE7N+UlkBfQSKo4j1RlsMw=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by SJ0PR18MB5138.namprd18.prod.outlook.com (2603:10b6:a03:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 13:05:22 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::dbb9:f11e:dc25:d2f8]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::dbb9:f11e:dc25:d2f8%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:05:21 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
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
 AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQgAAU+ACAAAv1kIABLXgAgAGCvNCAABqmgIAALTNQgASL+ACAAFOSAIABA74AgAqSAICAAieakA==
Date: Wed, 24 Apr 2024 13:05:21 +0000
Message-ID: 
 <DS0PR18MB53689F93A92A48928582BF95A0102@DS0PR18MB5368.namprd18.prod.outlook.com>
References: 
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
 <20240422164108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422164108-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jasowang@redhat.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|SJ0PR18MB5138:EE_
x-ms-office365-filtering-correlation-id: b11cd781-2138-42a0-acc3-08dc645f32b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?a3lQT1JkRXEwdWc4aDZTK0FCMDlRMmh5SVNQZTd1VE5vWVJCWWY3L2tVRkV5?=
 =?utf-8?B?a2dxUGpFd1VMN2kyVEpBNmJwbDVBaG1ndnFzWHJjbm9vdjcwNXYyM1FBVXBa?=
 =?utf-8?B?emVLQzZYRXlra2JNK1lUeVkrWVJzNURSTDFTWWVFQlYwRnBaZzBoSmRKWUVI?=
 =?utf-8?B?Z3hKRTM2V0xVQkVJN3BuNm1oNml4S1FQL3hGaTUyK2VXTHcwclQvajhHQkhU?=
 =?utf-8?B?TTdCOGhlemNuKzVhMkJKVjYzcjA2KzhqMmU2cTcxRVhyZEM5ak83MWV5WE1B?=
 =?utf-8?B?WlJPQXRGMzRnQ2dJZ3IxSTlXZUYyeWptbFdkZjNQVGh5ZkVFVVBPSlBqdTFa?=
 =?utf-8?B?NGZaWWl1dit0QldUNTdUWlNqKzNST3ZONDVpb3B2QXZYL3NSWVlLL2EyMFRm?=
 =?utf-8?B?Tm1JdWpjd3VxSmhNRVVaYnhqa1pCSmJSUzlLcFZDcXNZNmJNOStHUE02Y1FH?=
 =?utf-8?B?cEpyMS9wTHhTbkJnRis4MVdWZ1dMWE92NEljekFncTNLM3hOdTZGTkNlZ0VM?=
 =?utf-8?B?TlR2c3I5YTBmT29YQWZXYVVWN0VHd3F2YktucExyZzdzWVFuTVlNWE1aWTlr?=
 =?utf-8?B?YlVsVCtjaXE1cG8zVFozTE84blNZTlAvTHI1OWxrZ0s3RHdZWEVNMTd5QTh0?=
 =?utf-8?B?Q1NsKzh4WFoyK3JsTCtkSFZmWFZvTkVkeW9uQXpnME4zZGloK1BhSlkySFcx?=
 =?utf-8?B?OG5XdytySGNKL2hEdlA1c21tZHJlV1BtaGc0SkNpTnpyUlFSeHY1WmtPblMw?=
 =?utf-8?B?S1JHSDRnVUgzem1lM3ZGRFRPMUpTeTlhckF2T1prcGFWVkxheHRwdlZNdjR1?=
 =?utf-8?B?TFVWdnFISkFoekVGbWZ1dlF1TEpvVDQzeWhFWlVhcHZva0lEQ3J4RUppazRh?=
 =?utf-8?B?bW45YjcrV3hSbmxtV1Z4ek80bkt0RVpFQTFORmZadXU1dVVzNU5WbHVYMll6?=
 =?utf-8?B?N0g0WnZGZVl2eFpPWWFzMUJiRW1YYld2UCtUVDQvSzZLdVloOXNZVDdCcGNv?=
 =?utf-8?B?eWpUQ2dYMDE1RFljZ2JmbUtvZ1NnaVd5MXRiVnloQVcwUFVsSTVwTE5EWXdB?=
 =?utf-8?B?dmpySEJCVHVwV2gzbGpUWm01UTNDY09hRDh1cHJZbkQ5bHNhVHBZbm1nZDJx?=
 =?utf-8?B?RFl2akx0b2JzNnZFN2dJSTVTclNUZDFSRFlYTlUrcFFsNXJEbEltcDlKRmpN?=
 =?utf-8?B?TUIyVXVkdk1Ja2ZRQ3NwSUFtTGR2WGRKYld1bU1EajA1TDlhRUpqaG9rZHN5?=
 =?utf-8?B?cXBFd1gzMVdEb3QxeTFqWGVId2tUYU4rVlhhTG13aFcrOTMrNkI4RGRvTXpZ?=
 =?utf-8?B?VkNPQnpzcjQ2cnB3UzE3OEI2MzZJcUJ4cmEybm94QUd6ejZqM1p3ZDhkeTl0?=
 =?utf-8?B?Q3l4dWc2cXhhWEtSa1p1YVVMMjNSODVpaEFnb2hiazExcUkvYmZnSUNYNlhL?=
 =?utf-8?B?ajVCUGVmWTRuMG5lU1RwWXdQZnN5a3UyWUhJV3EwZWRmeHFQRjBQaHRHb0Yx?=
 =?utf-8?B?YjJKVTRKYXhhL3I4ZkM5NGJzWmQyQTdGRWRzSHdmN0tCUjNxdWhFK2VwOFJn?=
 =?utf-8?B?RlZjbGd5VThkTEVEV2diQUFTbkc0UWFrWnV3dTRzc05Lb0dyd2tSR0RaMC9t?=
 =?utf-8?B?emt5UHY1N1JFcldvdFRmcVl6MjA3NVpKUWhCNngzVDgvRklnM1Y3WGlPbE9O?=
 =?utf-8?B?dWVuUDZ3TXNOUldCR2w2d1hBTlcwNitqdTN5dVpRUzZXWEplQjlMNmVIaGZW?=
 =?utf-8?B?bmtVcDAxMW1wUGZReWFUbW9HNmwycjZMTG9RaWRhMGNVTEJ3MTNHZjBZOS9t?=
 =?utf-8?B?eDhCNFhvUWlIRUV1cWRrUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cjRZZFlRUlhzSkpldEhRTzIrV2R1U0JRcnpER2FkMWtPbDE2YjVzdEV5UzM3?=
 =?utf-8?B?Z1BpOWc1SjRxVXJzNEdhUU00aUhqK3lBYVVtVlRrVkZGYmdmUUlLR01lNGwv?=
 =?utf-8?B?bTlkN25WaFJKQVBBTy9UOWhlTjlVT045dkFCS0RXd1lZdmhtV2hmU0RCYnl5?=
 =?utf-8?B?RGFjb0N2bWw3RG9vNEVUMGxFV25oTGVuRmxlSGpULzllWExQWnNkTFczZS81?=
 =?utf-8?B?a09DU3lob3hvd2FaN1ZzYkwyMUZhdnVzR3Q2NWxyN09VdVZlOERWUzllb1M5?=
 =?utf-8?B?YzlmQkV2WXRtVzZNQVJBNlJOanJnS1NjS3JITExVcC9tTndHMHJRNnViSGln?=
 =?utf-8?B?ZjRVSmVsUFhJeFVURURLR1lQdU1GWTBnNUdTZ0QrcUl0aEZUWlN4MnpkaHZ4?=
 =?utf-8?B?YVUxaGQrdUpBb0x3czhOY2Njd3dRaTBzaFZ0UFo5MGlYeWtmRFV5bTJvOTd3?=
 =?utf-8?B?bTRKZENuM3g3alliSVNzR3pkbVdlb21hZ1VhMjZHaENZa2E2RnpDdnBiNXk0?=
 =?utf-8?B?OWx1dWJBZm5TSFZaTVV2V2hnT0lOMzJLeFdmQjNOT2JFeVhBR2RyUS9jMTlw?=
 =?utf-8?B?RDlKMTl6S2l5Q0JnQmZBamt1QXRnaFNJb3hMcnJSK0twcWVhazViVVFvL3A1?=
 =?utf-8?B?dHV2dENtRnNJdlFjVXJaTDBQWTJnTGZjNVRFd0QwUHR3elM5N09OWmhRNmRD?=
 =?utf-8?B?UU8vVXpHME1NcFlNbHlQanlWUkFodFp0ZTFvM0h5Ry9YVTVjUytPSFptT01S?=
 =?utf-8?B?ZjdpWG8xc2VZcnFVQjg5RGtZOHZmSkVZdTFZcXVFSk5BdFN1OXI3WkdHdzZI?=
 =?utf-8?B?cFBHdjVoMEhFZTYrT1V1VHVNRHgvN1ovTi9uRDJkTzVIazZFMExQNExhQWh4?=
 =?utf-8?B?VFpnSzB2ekxvbXRWS2xYUFlYdzBnSzVhMXE5V2FKK1Q4TnB0R1d0R3RjbytH?=
 =?utf-8?B?cytSM2ZzU2ZDM3FVdGdmMU5ZUmlVRTErMHhORnBBbGg1MDlqY3FJUlluM3pS?=
 =?utf-8?B?U2tSVlBRKzNqbk15Mk4xU0M3b0RHYjlHSEMyc0Z3U1N1Tm1aYmt4ZW5iMmRk?=
 =?utf-8?B?UHF1ODB1eERsK2VLUGRHT3dObmN6Wm10NGV2dzBKc3NTVFZ1eXZ3bit2OGI5?=
 =?utf-8?B?a3pneWdkVkZ6d0NXRGVZdjdmVnI1K3lpTjdnT2ZpUFBZKzArUVNXU3FyaWMx?=
 =?utf-8?B?eUNyNDhQY2xmTDQ2WU12MWJHMlRjUkdOcUxjd3RaUW1jbXMydUJrMUxVZmVP?=
 =?utf-8?B?TUFZVHVnREIzSTgvbDlZUHdXSStQN0UvUm14OUQxWGVGTStTcWFRQlUzd2wr?=
 =?utf-8?B?dFlyNFdXM0dlWXNsaktrMUh2QU1neGFJajg3dzdWMDFDemRWbXBLS0pSU1pL?=
 =?utf-8?B?NjNOWHlhcktjNHlSK2RNWmxoN3NMQzFiTjZSdVVGMU9Gc0UrcjNEUE5ycWd1?=
 =?utf-8?B?ajZwRUxLNWo1aXF4bHc1dkxIbWYvaW9RbHNISEpvYkhBQjZIdS9NVTczNXdX?=
 =?utf-8?B?Uk9GZWsyaVRlU0dzMjhFakxUQmR5TE9TODA4eGdKNHBRUDdPU3lPZ0d5WUVG?=
 =?utf-8?B?SzlPaktpRGNFMFp2QmNHMHN4VFIvRFZIcWE3c0VuemdtY2l2cEV1VEVFbFJO?=
 =?utf-8?B?emZzdnp3RUxtZmVpMGd3L3pQWkE5eTVPbE9aalFROUNGTHNwY0htSnFlVmJ5?=
 =?utf-8?B?TGhCWHhLaGd2VHdLZThjUjFJUkJkVHdCdUpmNTBxVjljZ2lvSlE3VklsbVIy?=
 =?utf-8?B?ZllGQnl1U2hLVlFjbjN2YVpXOFVXbVEzRDladktnNVNqYmlnaEhPbGhNZlBV?=
 =?utf-8?B?cDFMV0NaZERBSDhtZUFmTDZMMjRFTTk0SGhjbHZqVXVtb1FZMnhEWnNncDAz?=
 =?utf-8?B?K2ZNbDV6ZVhrUzNOUTNFUWVQNS9xbXJML0dVTWFWcDZlazIwRWx0YjZYRnhi?=
 =?utf-8?B?UnJwREs0TzJXRVBpTC9TME9LWVhSRUg4eVE4ZFNnU1ZMU24xY2h6S0hPeE01?=
 =?utf-8?B?aitXSUdNMnQwRDFvY01nT3lZUDRZVWxnYzd4cjBrWTVMS3hvSnpIZW1kR1dk?=
 =?utf-8?B?bjRvKzBibUhNNk4wb1ZHUWJzaWNuYzlVMjlYSi95djlrSTBQNk4rTDBqMDZM?=
 =?utf-8?Q?6IdSeG8onlQXLiOwYTnnHZapF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cd781-2138-42a0-acc3-08dc645f32b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:05:21.5069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wO7lGswYMNpNnMYZAlhxA4GB1gpPZoKIk2HHGS4jrcPiLi6uPesjorFNINlUzkKuzrHT7lvvPuTIsxfPVdg7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5138
X-Proofpoint-GUID: tNK1h2F2JRTrEOx2IQSrxpVuqOSUo6kt
X-Proofpoint-ORIG-GUID: tNK1h2F2JRTrEOx2IQSrxpVuqOSUo6kt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02

PiA+ID4gPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIXSB2
aXJ0aW86IHZkcGE6IHZEUEENCj4gPiA+ID4gPiA+ID4gPiA+ID4gZHJpdmVyIGZvciBNYXJ2ZWxs
IE9DVEVPTiBEUFUgZGV2aWNlcw0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBPbiBXZWQsIEFwciAxMCwgMjAyNCBhdCAxMDoxNTozN0FNICswMDAwLCBTcnVqYW5hIENo
YWxsYQ0KPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9m
b3JfZGV2KGRldik7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIGlmICgh
ZG9tYWluIHx8IGRvbWFpbi0+dHlwZSA9PQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
KyBJT01NVV9ET01BSU5fSURFTlRJVFkpDQo+ID4gPiA+ID4gPiA+ID4gew0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgIk5PLUlPTU1V
XG4iKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBvY3Rl
cF92ZHBhX29wcy5zZXRfbWFwID0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsgb2N0
ZXBfdmRwYV9zZXRfbWFwOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gSXMgdGhpcyBhIHNob3J0Y3V0IHRvIGhhdmUgZ2V0IGJldHRlciBw
ZXJmb3JtYW5jZT8NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBETUEgQVBJIHNob3VsZCBo
YXZlIHRob3NlIGdyZWFjZWZ1bGx5IEkgdGhpbmsuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFdoZW4gSU9NTVUgaXMgZGlzYWJsZWQgb24gaG9zdCBhbmQNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gc2V0X21hcC9kbWFfbWFwIGlzIG5vdCBzZXQsIHZob3N0LXZkcGEgaXMNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gcmVwb3J0aW5nIGFuIGVycm9yICJGYWlsZWQgdG8gYWxsb2NhdGUg
ZG9tYWluLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2UgaXMgbm90DQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiBJT01NVSBjYWNoZSBjb2hlcmVudCBjYXBhYmxlXG4iLg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBIZW5jZSB3ZSBhcmUgZG9pbmcgdGhpcyB3YXkgdG8gZ2V0IGJl
dHRlciBwZXJmb3JtYW5jZS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBUaGUgcHJvYmxlbSBpcywgYXNzdW1pbmcgdGhlIGRldmljZSBkb2VzIG5vdCBo
YXZlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhbnkgaW50ZXJuYWwNCj4gPiA+ID4gPiA+ID4g
PiBJT01NVS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAxKSBJZiB3ZSBhbGxvdyBpdCBydW5uaW5nIHdpdGhvdXQgSU9NTVUsIGl0IG9wZW5zDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBhIHdpbmRvdyBmb3IgZ3Vlc3QgdG8gYXR0YWNrIHRoZSBob3N0
Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gMikgSWYgeW91IHNlZSBwZXJmb3JhbW5jZSBpc3N1
ZSB3aXRoDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJT01NVV9ET01BSU5fSURFTlRJVFksIGxl
dCdzIHJlcG9ydCBpdCB0bw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRE1BL0lPTU1VIG1haW50
aW5lciB0byBmaXggdGhhdA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEl0IHdpbGwgYmUgaGVscGZ1
bCBmb3IgaG9zdCBuZXR3b3JraW5nIGNhc2Ugd2hlbiBpb21tdSBpcw0KPiBkaXNhYmxlZC4NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBDYW4gd2UgdGFrZSB0aGUgdmZpbyBwY2kgZHJpdmVyIGFwcHJv
YWNoIGFzIGENCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZWZlcmVuY2Ugd2hlcmUgdXNlciBleHBs
aWNpdGx5IHNldA0KPiAiZW5hYmxlX3Vuc2FmZV9ub2lvbW11X21vZGUiDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gdXNpbmcgbW9kdWxlDQo+ID4gPiA+ID4gPiBwYXJhbT8NCj4gPiA+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gdmZpbyBpcyBhIHVzZXJzcGFjZSBkcml2ZXIgc28g
aXQncyB1c2Vyc3BhY2UncyByZXNwb25zaWJpbGl0eS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gd2hh
dCBleGFjdGx5IGVuc3VyZXMgY29ycmVjdG5lc3MgaGVyZT8gZG9lcyB0aGUgZGV2aWNlDQo+ID4g
PiA+ID4gPiA+ID4gPiA+IGhhdmUgYW4gb24tY2hpcCBpb21tdT8NCj4gPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+IE91ciBkZXZpY2UgZmVhdHVyZXMgYW4gb24tY2hpcCBJT01N
VSwgYWx0aG91Z2ggaXQgaXMgbm90DQo+ID4gPiA+ID4gPiA+ID4gPiB1dGlsaXplZCBmb3IgaG9z
dC1zaWRlIHRhcmdldGVkIERNQSBvcGVyYXRpb25zLiBXZQ0KPiA+ID4gPiA+ID4gPiA+ID4gaW5j
bHVkZWQgbm8taW9tbXUgbW9kZSBpbiBvdXIgZHJpdmVyIHRvIGVuc3VyZSB0aGF0IGhvc3QNCj4g
PiA+ID4gPiA+ID4gPiA+IGFwcGxpY2F0aW9ucywgc3VjaCBhcyBEUERLIFZpcnRpbyB1c2VyIFBN
RCwgY29udGludWUgdG8NCj4gPiA+ID4gPiA+ID4gPiA+IGZ1bmN0aW9uIGV2ZW4gd2hlbiBvcGVy
YXRpbmcgaW4gYSBuby0NCj4gPiA+ID4gPiA+IElPTU1VIG1vZGUuDQo+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiBJIG1heSBtaXNzIHNvbWV0aGluZyBidXQgc2V0X21hcCgpIGlzIGVt
cHR5IGluIHRoaXMNCj4gPiA+ID4gPiA+ID4gPiBkcml2ZXIuIEhvdyBjb3VsZCBzdWNoIGlzb2xh
dGlvbiBiZSBkb25lPw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJbiBuby1pb21tdSBj
YXNlLCB0aGVyZSB3b3VsZCBiZSBubyBkb21haW4gcmlnaHQsIGFuZCB0aGUNCj4gPiA+ID4gPiA+
ID4gdXNlciBvZiB2aG9zdC12ZHBhKERQREsgdmlydGlvIHVzZXIgcG1kKSwgd291bGQgY3JlYXRl
IHRoZQ0KPiA+ID4gPiA+ID4gPiBtYXBwaW5nIGFuZCBwYXNzIHRoZSBQQSAoPSBJT1ZBKSB0byB0
aGUgZGV2aWNlIGRpcmVjdGx5LiBTbw0KPiA+ID4gPiA+ID4gPiB0aGF0LCBkZXZpY2UgY2FuIGRp
cmVjdGx5IERNQSB0byB0aGUNCj4gPiA+ID4gPiA+IFBBLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IFllcywgYnV0IHRoaXMgZG9lc24ndCBkaWZmZXIgdG9vIG11Y2ggZnJvbSB0aGUgY2FzZSB3
aGVyZSBETUENCj4gPiA+ID4gPiA+IEFQSSBpcyB1c2VkIHdpdGggSU9NTVUgZGlzYWJsZWQuDQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQXJlIHlvdSBzYXlpbmcgRE1BIEFQSSBpbnRyb2R1Y2Vz
IG92ZXJoZWFkcyBpbiB0aGlzIGNhc2U/DQo+ID4gPiA+ID4gTm8gYWN0dWFsbHksIGN1cnJlbnQg
dmhvc3QtdmRwYSBjb2RlIGlzIG5vdCBhbGxvd2luZyBJT01NVQ0KPiA+ID4gPiA+IGRpc2FibGVk
IG1vZGUsIElmIHNldF9tYXAvZG1hX21hcCBvcCBpcyBub3Qgc2V0LiBIZW5jZSwgd2UgYXJlDQo+
ID4gPiA+ID4gc2V0dGluZyBzZXRfbWFwIHdpdGggZHVtbXkgYXBpIHRvIGFsbG93IElPTU1VIGRp
c2FibGVkIG1vZGUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGb2xsb3dpbmcgaXMgdGhlIGNvZGUg
c25pcHBldCBmcm9tIGRyaXZlcnMvdmhvc3QvdmRwYS5jDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAg
ICAgICAvKiBEZXZpY2Ugd2FudCB0byBkbyBETUEgYnkgaXRzZWxmICovDQo+ID4gPiA+ID4gICAg
ICAgICBpZiAob3BzLT5zZXRfbWFwIHx8IG9wcy0+ZG1hX21hcCkNCj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgICAgICAgIGJ1cyA9IGRt
YV9kZXYtPmJ1czsNCj4gPiA+ID4gPiAgICAgICAgIGlmICghYnVzKQ0KPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgICBp
ZiAoIWRldmljZV9pb21tdV9jYXBhYmxlKGRtYV9kZXYsDQo+ID4gPiA+IElPTU1VX0NBUF9DQUNI
RV9DT0hFUkVOQ1kpKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1RTVVBQ
Ow0KPiA+ID4gPg0KPiA+ID4gPiBSaWdodCwgc28gaGVyZSdzIHRoZSBxdWVzdGlvbi4NCj4gPiA+
ID4NCj4gPiA+ID4gV2hlbiBJT01NVSBpcyBkaXNhYmxlZCwgaWYgdGhlcmUncyBubyBpc29sYXRp
b24gZnJvbSB0aGUgZGV2aWNlDQo+ID4gPiA+IG9uLWNoaXAgSU9NTVUuIEl0IG1pZ2h0IGhhdmUg
c2VjdXJpdHkgaW1wbGljYXRpb25zLiBGb3IgZXhhbXBsZSBpZg0KPiA+ID4gPiB3ZSdyZSB1c2lu
ZyBQQSwgdXNlcnNwYWNlIGNvdWxkIGF0dGFjayB0aGUga2VybmVsLg0KPiA+ID4gPg0KPiA+ID4g
PiBTbyB0aGVyZSBzaG91bGQgYmUgc29tZSBsb2dpYyBpbiB0aGUgc2V0X21hcCgpIHRvIHByb2dy
YW0gdGhlDQo+ID4gPiA+IG9uLWNoaXAgSU9NTVUgdG8gaXNvbGF0ZSBETUEgaW4gdGhhdCBjYXNl
IGJ1dCBJIGRvbid0IHNlZSBzdWNoDQo+ID4gPiA+IGltcGxlbWVudGF0aW9uIGRvbmUgaW4gc2V0
X21hcCgpLg0KPiA+ID4NCj4gPiA+IE91ciBjaGlwIGxhY2tzIHN1cHBvcnQgZm9yIG9uLWNoaXAg
SU9NTVUgZm9yIGhvc3Qtc2lkZSB0YXJnZXRlZCBETUENCj4gb3BlcmF0aW9ucy4NCj4gPiA+IFdo
ZW4gdXNpbmcgdGhlIERQREsgdmlydGlvIHVzZXIgUE1ELCB3ZeKAmXZlIG5vdGljZWQgYSBzaWdu
aWZpY2FudCA4MCUNCj4gPiA+IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IHdoZW4gSU9NTVUgaXMg
ZGlzYWJsZWQgb24gc3BlY2lmaWMgeDg2DQo+ID4gPiBtYWNoaW5lcy4gVGhpcyBwZXJmb3JtYW5j
ZSBpbXByb3ZlbWVudCBjYW4gYmUgbGV2ZXJhZ2VkIGJ5IGVtYmVkZGVkDQo+ID4gPiBwbGF0Zm9y
bXMgd2hlcmUgYXBwbGljYXRpb25zIHJ1biBpbiBjb250cm9sbGVkIGVudmlyb25tZW50Lg0KPiA+
ID4gTWF5IGJlIGl0J3MgYSB0cmFkZS1vZmYgYmV0d2VlbiBzZWN1cml0eSBhbmQgcGVyZm9ybWFu
Y2UuDQo+ID4gPg0KPiA+ID4gV2UgY2FuIGRpc2FibGUgdGhlIG5vLWlvbW11IHN1cHBvcnQgYnkg
ZGVmYXVsdCBhbmQgZW5hYmxlIGl0IHRocm91Z2gNCj4gPiA+IHNvbWUgbW9kdWxlIHBhcmFtZXRl
ciBhbmQgdGFpbnQgdGhlIGtlcm5lbCBzaW1pbGFyIHRvIFZGSU8NCj4gZHJpdmVyKGVuYWJsZV91
bnNhZmVfbm9pb21tdV9tb2RlKSByaWdodD8NCj4gPg0KPiA+IENvdWxkIGJlIG9uZSB3YXkuDQo+
ID4NCj4gPiBNaWNoYWVsLCBhbnkgdGhvdWdodHMgb24gdGhpcz8NCj4gPg0KPiA+IFRoYW5rcw0K
PiANCj4gTXkgdGhvdWdodCBpcyB0aGVyZSdzIG5vdGhpbmcgc3BlY2lhbCBhYm91dCB0aGUgTWFy
dmVsbCBjaGlwIGhlcmUuDQo+IE1lcmdlIGl0IG5vcm1hbGx5LiBUaGVuIGlmIHlvdSBsaWtlIHdv
cmsgb24gYSBuby1pb21tdSBtb2RlIGluIHZkcGEuDQpGb3Igbm93IHdlIHdpbGwgcmVtb3ZlIG5v
LWlvbW11IGNvZGUgZnJvbSB0aGlzIHBhdGNoIGFuZCB3ZSB3aWxsDQp3b3JrIHdpdGggSmFzb24g
Zm9yIGFkZGluZyBuby1pb21tdSBtb2RlIGluIHZkcGEuDQpASmFzb24gV2FuZyBDYW4geW91IGNv
bmZpcm0gaWYgaXQgc291bmRzIGZpbmU/DQo+IA0KPiANCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uIHdoZW4gaW9tbXUgZW5hYmxlZCBpcyBub3Qg
d2l0aCBETUEgQVBJDQo+ID4gPiA+ID4gYnV0IHRoZQ0KPiA+ID4gPiA+IHg4NiBIVyBJT01NVSB0
cmFuc2xhdGlvbiBwZXJmb3JtYW5jZSBvbiBjZXJ0YWluIGxvdyBlbmQgeDg2DQo+IG1hY2hpbmVz
Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIG1pZ2h0IGJlIHRydWUgYnV0IGl0J3Mgbm90IHNwZWNp
ZmljIHRvIHZEUEEgSSB0aGluaz8NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFdlIG9ic2Vy
dmVkIHBlcmZvcm1hbmNlIGltcGFjdHMgb24gY2VydGFpbiBsb3ctZW5kIHg4Ng0KPiA+ID4gPiA+
ID4gPiA+ID4gbWFjaGluZXMgd2hlbiBJT01NVSBtb2RlIHdhcyBlbmFibGVkLg0KPiA+ID4gPiA+
ID4gPiA+ID4gSSB0aGluaywgY29ycmVjdG5lc3MgaXMgSG9zdCB1c2Vyc3BhY2UgYXBwbGljYXRp
b24ncw0KPiA+ID4gPiA+ID4gPiA+ID4gcmVzcG9uc2liaWxpdHksIGluIHRoaXMgY2FzZSB3aGVu
IHZob3N0LXZkcGEgaXMgdXNlZA0KPiA+ID4gPiA+ID4gPiA+ID4gd2l0aCBIb3N0IGFwcGxpY2F0
aW9uIHN1Y2ggYXMgRFBESw0KPiA+ID4gPiA+ID4gPiA+IFZpcnRpbyB1c2VyIFBNRC4NCj4gPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gVGhhbmtzLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPg0KDQo=
