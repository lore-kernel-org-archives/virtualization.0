Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BE24C086
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895487; cv=fail; b=ojgcNisR37vp91lK8EeE+fi3GJB0RLyq4uuh97m2vI7XHWsMSE4K7bTql4pw3bOW16gLguYQoZFCRbRvBVu+sCr921yc7OoBprRHKZHwwTIHpYlMzDaFxC60RRfPfjXTvSrJIdiYBHey+luCndCUPbsr0UNlc0BzssPlSMUu7M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895487; c=relaxed/simple;
	bh=NmZ2g3RVSD37OujgSpXBPHzj3H4OjDU9Hpl0kHSxROI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HsyKXU+qwZZ49exL6qIf3N6WjRiWO6GpTdULjbvwQTaD28qeoDumzoo6yzspFtbGKgGmCPe5Uc1eka45nNFD1KWOTJY4Ogg+bkWv8WSlhB7VoD/D7yarmeBBbrdPyJILUBxoSnFtaytyyjmeuTRCQaKsk+4BNK+BxFk8hUqtb+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=SrhzYUr0 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="SrhzYUr0"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HAs4g4007561;
	Thu, 17 Apr 2025 06:11:14 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjm3b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 06:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZRKIIo4RuKqZ89QD4DlzWG4yL2P2yQFUJ9PHk0jEWA1pHUx9RAuqUPL3y3y+9mJZ61isZcaIYdviwsIPkvRJM8GkbA/epQKw+hy4L4jn+/gs/nirqYet3zF5pcODjbNEVQfsx/2eyukYSjSvDK7hDN46bKPvflwiQ1oJJtcRYZ32vlZihkCSBPOZ2yc0d8GxlvAybOQCEy6PPhfiebbKZDJKYveqQwpuwcGOff2JqnOSxYnhmBxBNjgF4uxowKUCZBtCJyRUNpACxxEBKGfVGHd2xQIqBHvPXIK64Cx06l/GLYfx45i7zhepi/WWOwcfhyg02mtBFBX19DMGGd2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+WPgJW0nS8HzfUuticxKe3qbG6SYVPVpmwT+nfBw5E=;
 b=Ju3on/4ttSK9nTr5wkX/tyVnLKfyG/wpKMlGAzm/U3pPxpnWc/lRxngfyLKejbDwrtTDlnTP/X5+yAzJF8d51n6GbUiwLevzeiHv4qv6674c4R5k5vEgzfGGxcbdrXDp696/9Rr4K+/yhXEHusmMePtHRxGDvWVMjU1tQf8xwH1dEcYadHSgN95wfEubeUP5TldqisP/OylbGBMIRY/E/3BAlqE6UFIdPzFnEuZ7NP/S0MhxhgETl2rY7RrQf/1GLJNnT0xqbj08+0nMMFvwC559NbjrdrPgNyn6bGWIPEomo/gvMSYB/0k0ZUPlmOCRYYAXnLI1uGROFXRyirXrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+WPgJW0nS8HzfUuticxKe3qbG6SYVPVpmwT+nfBw5E=;
 b=SrhzYUr0DTThZLoZ5PPI84eJdT4KV3GMVxqttyvKQp5CXAc483V18UuL3dcsUUUxUR0cseMUGWDuF6AVw14H9NzXoYg0kRMWeM/UTLe21w4yhkuehGqHT+k9iSZLfEiifTgyli0KRaQdG9wQt/giSdrMqSHVqiKdzeoqsz/7xuc=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SA6PR18MB6202.namprd18.prod.outlook.com (2603:10b6:806:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 13:11:11 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 13:11:10 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: "phasta@kernel.org" <phasta@kernel.org>,
        Srujana Challa
	<schalla@marvell.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
        Shijith Thotton
	<sthotton@marvell.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Thread-Topic: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Thread-Index: AQHbr29ELSp8NJgL1kWOf97yfETcxrOnjC/QgAAe0YCAACGnMIAABZUAgAAChwA=
Date: Thu, 17 Apr 2025 13:11:10 +0000
Message-ID:
 <MW4PR18MB524432BD45DD5E2AC1F3E94DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20250417080211.19970-2-phasta@kernel.org>
	 <MW4PR18MB5244915E54967510C5356B4DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
	 <a57d5f6f47ec8ba2860df853aca324e96320eba5.camel@mailbox.org>
	 <MW4PR18MB5244B9A5E105A514BB3D5272A6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <0f5768efe0828802435affa444a615dd9fefad08.camel@mailbox.org>
In-Reply-To: <0f5768efe0828802435affa444a615dd9fefad08.camel@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SA6PR18MB6202:EE_
x-ms-office365-filtering-correlation-id: 3277c565-dd36-42fe-efbb-08dd7db15257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGM4dVhVRnR6ZHNPSmpmSlM3UllOZ2RDcUVHKzNJZnZXQWpNcUplSFlOUll6?=
 =?utf-8?B?ZWpmd1FDYXhsOE9JcFRuOUR2aWZxakl4UnR0dTMwWXFibDNWYlZWNThobGVy?=
 =?utf-8?B?UFBVYWJuV0s2V0hhOStTOHlsd1p5QU9CNXpHQ0lsMFV0bGg0NmtPMlVLdWJJ?=
 =?utf-8?B?ODN0N3lLdldyb09QSmRKTlB1eGRTS05sK3oxNU55c3BBWWJsNStjLzl3aGc0?=
 =?utf-8?B?Y0JVYm5vcXBXU1VvcG13NWpLNXJFbUtPK2RTSzdLeVgwaXI1dkx0K3JKOXhV?=
 =?utf-8?B?SzhNQVdMTUJaWWpYWjRrRENFR3F2SXRuVExaV1NhdXJwdWZVWXRDakJGaVdV?=
 =?utf-8?B?bnhncWtYdEV4MlR6cWxybWJIWHVYK1RPd3V3Z0ZQaU5QWWc4dUw2K3lWdUlx?=
 =?utf-8?B?VzQ3VDlDcmdMbzRINjNrclg2WDY0VkJYM0VMVU84Y1k2bjUxbkkvL0JDc3Uw?=
 =?utf-8?B?UHBkL1d2cC96RHZEWXYyN0JFYy8xcUtza0FweDVoWHMrbjdqSHBtcUMyK2hn?=
 =?utf-8?B?ZjAxajFJRVZNZ0VjYmNOQnp6dXBTMUo3OVU5ZENXeDRuZVErZFFuNHFjOFNV?=
 =?utf-8?B?a0ZDeFFUd3ZlZzZiYnhSaXhYK1lKNlU5QjRyUHJOTi9VSUJjRWZmamxpTzlF?=
 =?utf-8?B?SGEra040NHZoZkcyUHVLZTdna2lJV3NEVGg4dHF0WU5OUWpNQnFjdFB5YnY0?=
 =?utf-8?B?RVVMd2ZsY3NGQ05RQnc3Nnh0Z3FBcS9Zd1BCN0NyeW5UYlo3Sm5vRHlRMklJ?=
 =?utf-8?B?dzFnRXdYV0tZVFZUNDNwZmF0K0RETmsydUJ2dXJ2bytNNzdiRjhJMHFaV3d3?=
 =?utf-8?B?VXZxaG40Qk8rd2pwK3JMUXIzemF2Rk5LRVZyOCtySkFQV3VhTHc1M2xGc2Rr?=
 =?utf-8?B?VFdRUFBiaEV2dFNsWTkzVWFsdy9QQmRteUxBT3g2bVhSQXhIRCtEOFgxd1U1?=
 =?utf-8?B?YlVUWUlvc1ZjQkZFaDVjZklKSERnZzJjS2FhUmV6V1psT3hBZzYza2VaRFIy?=
 =?utf-8?B?eUFrc3o4UHp4U3VnanF2MVMxKzFnYTlBZUhBMHllNlRtcDF6UEFHS2QxRVNu?=
 =?utf-8?B?dy9UenN0Wkx0M1ZaYjdKaEErbkVpS294ZUVBdHRpRlBSbklnTm5jWm95cmxF?=
 =?utf-8?B?bWt6NlFvT2NvT0M2bi9uWjhJVGYyRFFDRlFuSDgvMkNObUNHZVAwa00wVzlZ?=
 =?utf-8?B?WUxKV3A4UDlvZWlZcElVUnBwTkZLTVpCRHpPaCs5dnliditEcDdKOGlEOEpq?=
 =?utf-8?B?M0NlQURXSE5Ecnh1ZThtR21wbXZGYm1jMzBDVmI4WGdQdW1XYUZjZEdiN1Y4?=
 =?utf-8?B?VlVuQm1qUzE3ZzJEeU9sa0VacGhtbG9PNkg5MHVkNnpYU0l4Zi9va3VQQjQ1?=
 =?utf-8?B?OHU4SVFZVS9ydGQ5T0xCelJiZjZqdGdDLzZvN1ZkR2tMd29qbFVYdVQ1V2pX?=
 =?utf-8?B?dVVGWUE5Rjk4a3dnclhueUZDOFB3WFFlNUtDZ0s1YlZ1cEwzNWd0cm1yWWZF?=
 =?utf-8?B?UjFzVHgzdzVKVkxSYU92RVdmMU1QVEUrNkJnZ1hXOS9iRDZ3em4wblMvanpW?=
 =?utf-8?B?UmpuSmVuWU4vWHBVQzl3QnBpR3pWZGIzbEZmN1pseWlPeEN2cmM0b2F6azJ3?=
 =?utf-8?B?OUNNWCtOK0lIVlllSERFMjFJRWdGMUtvbUtJOTRWQzREQmlpQjI1V1pxTDMr?=
 =?utf-8?B?WU1yaU5rZUlyTU5FdzRieU9yZzFBQ1JubWdTRWRackJlclRLSHgyTmdvdU92?=
 =?utf-8?B?WVhMSStwZDhuMUlxUTlCejV5a0kwNFpqbDNPMWhPbjNrNkx2RWt2TGFLelk4?=
 =?utf-8?B?OGVPWngxNFVhMFRyTks0a0pTcGJKVFZtMlVRa1l0RTdHOHJFVkJraFREclpk?=
 =?utf-8?B?bTJ1eTBnVDhhQUVvSmYya1hUVUJYeWtoejVORCtvQjJIY0Fmd2VuY01OcjdD?=
 =?utf-8?Q?7PoRBG61jls=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEtEb0FGbzNEY1BLV3VhUTVKQlBPZnlHSWV5YnJEbGdhd2FLR0h5eEZIdDBm?=
 =?utf-8?B?emgrSncrVXcxWVJ2QTBpRkhtRlMvcE9iM1lMRXc0Mm9IZFdoVVViT05BekJt?=
 =?utf-8?B?TVRwN1d5aStwa3ZJUytENjc2UExIRk5OSlRQZ2lUVW1FWjBPSm5ZTzJNaHAz?=
 =?utf-8?B?eTBKQ1ZKcGdzelhyZ1Y0bVhDSEdPSzc3dTZSanNDS0gzbHhYSGhTMmJUcEF4?=
 =?utf-8?B?OVExdTZQdGxXWnRJVVNzbDFBTWxSQnB4V2Q3YjBMVWpVNjlpUHhaZUs3dHo2?=
 =?utf-8?B?cXFqakhqaC9vSGlEMWRkMGU5WjlqTFk4Y3pRdWNuSjRuVUpNajRGOG16QlRF?=
 =?utf-8?B?TGFHYTdkd05vMUdqTmdIbkptYXdlenJCM01mN1hXTndwaWtzTjdDb2NMOXgw?=
 =?utf-8?B?ci9hY1IrYzhtcVpYTlNoYnRaOVpuTnlERVpjOVA4aUY2Q0xvTXRFQThiZ25q?=
 =?utf-8?B?Q3FMS0dTV1dOMG9mR0FZcTVKbmpEeVZYNVA3N1FoWDZGSEJvNVRRNGxpS0o2?=
 =?utf-8?B?eE1mektmWkhEVHAxRWZSSlEvS1ZmVUF6K3RIcm9oK2lmYzZqOXZBVi9nZE5m?=
 =?utf-8?B?eDVBMzUwZW5GenZ6OXFMcE9vcjZwQzNobGJSaWYzZXhWZUFrOVJBTU9ENDNu?=
 =?utf-8?B?akEwdGdVb1JNYUwwMzFZNGZuTEQ0ZGJkN2NLL2JudldMalNCMkxOYnlnUTVP?=
 =?utf-8?B?QmFVcHc3MUpMV1lXU0IzRzNEOVd2ckFScDNHbWVJcjFrSlBQT096bnpyL29P?=
 =?utf-8?B?MmN2eXNLNlBXdStoYXJuSlp3OFF4VlNpU0dQL3NodHRSZWxyS0FMTW9SWXYw?=
 =?utf-8?B?QXpXVEtReUFXR2NXOTJILzBoQW5MZ0l2KzM5ODJ3dTFTV1Zld01JWGZPaFZV?=
 =?utf-8?B?ZE5ZdlNEWitMeEN3Sm1rZTRtN1FJRzkxcGJBNURJMXJhSkhTSzlrSXZrVjVi?=
 =?utf-8?B?K0hRMEdBMDdoOEtDMG1YVnNhRXBsVGlCSDhqRWdrSlUxZzR2SDRhaXJFNjUv?=
 =?utf-8?B?K1FFdzVQV0x5Wm9jcXN3K1VyaDVhK3dKb3hMaWlxakZidzZnSGxkZ3JYVkRx?=
 =?utf-8?B?QmdOMnN2Zld3bVgzSFRDRUlZN21yRHVQVUVuSGgvb3RjS0UwNzdTdFQxVmRt?=
 =?utf-8?B?YVNIVXRZalU2QXJ3dks0azhUWSswUWhPZk03dFRaQTg5N05IallqdXloYjRi?=
 =?utf-8?B?TVU1ZnErWWQ5ckU0ZkVOTWp2L3MvdVNwOTZMSnNyek56aDJLSmdSeVhYeW9L?=
 =?utf-8?B?UU0zOVhENlIrcmNoaldrbGtpWkFqQ0MweXJ1SHpnQmhmVERZbmt6UUJkUkNU?=
 =?utf-8?B?Vmx3NE1uc2R2emUrckJJNEtDNHRxVlROcERpNjBhSU54Wi9ybDBwcDRZdTRZ?=
 =?utf-8?B?NVE0VHNodkRqdTdVV1FHT0E1Z2FVcC9ZR2JHTnRub0VVZUt4UGFod0tjK3dC?=
 =?utf-8?B?bEpkV2FiOHF4SkVWbm0zdy9SWVZTdllmUWt1bTNsTlV4bmVIb0dGMFdJZTBy?=
 =?utf-8?B?WkM5WGd4SXFHYmh3cElRS3hhMjJMRklYaElNMGduRFhOQ29LZEJPdVBnY3FL?=
 =?utf-8?B?ZVZ2VEJDWW5INytQaGNpeHd3WlRQMmV6clBFMFk5Ry9HT1ZBMmdKbUhBMWdy?=
 =?utf-8?B?SCtISUJRTzdHWEpYNTQ0ckw1aFVDdWhtSk9qYm5NMTBWSFRRWXZ1ZyszTG5N?=
 =?utf-8?B?Q2QrK0VZUFRVcVBKNmVRL3VYRDVMTXBuZTBCa0pUVGZvWnRaZElRRGtiY0hz?=
 =?utf-8?B?cmkzaHRrOGVWRndBemJOdlhOWFA0UDdtNzFiTzZMd3dMN3BHbFRjeW5vYWJD?=
 =?utf-8?B?Vm1LNzVKZUUvS1dXcmtCR0dqR3RCRjNtdXpmVis2VDdCZkNCdlpUMWlTZmZu?=
 =?utf-8?B?WDhpY1VvcS9MRWhJU1BoL3ZseGNwS1VUck05NHEwKzlJNFA0SGNhUDRpa2I1?=
 =?utf-8?B?ZjQ4OTZMaFVkOVh1TFZ6MU1BS3FocUtTOGE1dHgwbkVnalJuT3RBM1BlSXVD?=
 =?utf-8?B?OFFRZlVUVHhJOWdxTjN3TG5vd0RBejdNTEJQT0JDWHpvRXlaYkdINEJqQ0h4?=
 =?utf-8?B?NUVnVWJJOTFZWmVzWUhtV2ZIT1RaeVBUbGViZDN1ZzRTR0JNMHRrcFNtUjZJ?=
 =?utf-8?Q?Xbc5DybY8Bzpj3q2u//Lguzd+?=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3277c565-dd36-42fe-efbb-08dd7db15257
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 13:11:10.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcerkCYsRK3QOo+FjctioQgkKz6P9ixkLMNzWEgR75VW2x3z2URJ4giKq9cPlvHhqhmTWLOjEwgzQbV71BGf+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6202
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: LJvHaUkp7tbiiBLMDaEpndIGuoHavgwd
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=6800fdf2 cx=c_pps a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=b3CbU_ItAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=KKAkSRfTAAAA:8 a=RpNjiQI2AAAA:8 a=crUY4groxbP6IjOWAQoA:9 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LJvHaUkp7tbiiBLMDaEpndIGuoHavgwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01



>-----Original Message-----
>From: Philipp Stanner <phasta@mailbox.org>
>Sent: Thursday, April 17, 2025 6:29 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; phasta@kernel.org;
>Srujana Challa <schalla@marvell.com>; Michael S. Tsirkin <mst@redhat.com>;
>Jason Wang <jasowang@redhat.com>; Xuan Zhuo
><xuanzhuo@linux.alibaba.com>; Eugenio P=C3=A9rez <eperezma@redhat.com>;
>Shijith Thotton <sthotton@marvell.com>; Dan Carpenter
><dan.carpenter@linaro.org>; Satha Koteswara Rao Kottidi
><skoteshwar@marvell.com>
>Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>Subject: Re: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
>devres API
>
>On Thu, 2025-04-17 at 12:=E2=80=8A56 +0000, Vamsi Krishna Attunuru wrote: =
> > > > -----
>Original Message----- > > From: Philipp Stanner <phasta@=E2=80=8Amailbox.=
=E2=80=8Aorg> > >
>Sent: Thursday, April 17, 2025 4:=E2=80=8A09 PM > > To: Vamsi Krishna
>
>On Thu, 2025-04-17 at 12:56 +0000, Vamsi Krishna Attunuru wrote:
>>
>>
>> > -----Original Message-----
>> > From: Philipp Stanner <phasta@mailbox.org>
>> > Sent: Thursday, April 17, 2025 4:09 PM
>> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Philipp Stanner
>> > <phasta@kernel.org>; Srujana Challa <schalla@marvell.com>; Michael
>> > S.
>> > Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Xuan
>> > Zhuo <xuanzhuo@linux.alibaba.com>; Eugenio P=C3=A9rez
>> > <eperezma@redhat.com>; Shijith Thotton <sthotton@marvell.com>; Dan
>> > Carpenter <dan.carpenter@linaro.org>; Satha Koteswara Rao Kottidi
>> > <skoteshwar@marvell.com>
>> > Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>> > Subject: Re: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
>> > devres API
>> >
>> > On Thu, 2025-04-17 at 09:=E2=80=8A02 +0000, Vamsi Krishna Attunuru wro=
te: >
>> > > > > -----
>> > Original Message----- > > From: Philipp Stanner <phasta@=E2=80=8Akerne=
l.=E2=80=8A
>> > org> > >
>> > Sent: Thursday, April 17, 2025 1:=E2=80=8A32 PM > > To: Srujana
>> >
>> > On Thu, 2025-04-17 at 09:02 +0000, Vamsi Krishna Attunuru wrote:
>> > >
>> > >
>> > > > -----Original Message-----
>> > > > From: Philipp Stanner <phasta@kernel.org>
>> > > > Sent: Thursday, April 17, 2025 1:32 PM
>> > > > To: Srujana Challa <schalla@marvell.com>; Vamsi Krishna Attunuru
>> > > > <vattunuru@marvell.com>; Michael S. Tsirkin <mst@redhat.com>;
>> > > > Jason Wang <jasowang@redhat.com>; Xuan Zhuo
>> > <xuanzhuo@linux.alibaba.com>;
>> > > > Eugenio P=C3=A9rez <eperezma@redhat.com>; Shijith Thotton
>> > > > <sthotton@marvell.com>; Dan Carpenter
>> > > > <dan.carpenter@linaro.org>; Philipp Stanner <phasta@kernel.org>;
>> > > > Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>
>> > > > Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>> > > > Subject: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
>> > > > devres API
>> > > >
>> > > > octeon enables its PCI device with pcim_enable_device(). This,
>> > > > implicitly, switches the function pci_request_region() into
>> > > > managed mode, where it becomes a devres function. The PCI
>> > > > subsystem wants to remove this hybrid nature from its
>> > > > interfaces.
>> > > > octeon enables its PCI device with pcim_enable_device(). This,
>> > > > implicitly, switches the function pci_request_region() into
>> > > > managed mode, where it becomes a devres function.
>> > > >
>> > > > The PCI subsystem wants to remove this hybrid nature from its
>> > > > interfaces. To do so, users of the aforementioned combination of
>> > > > functions must be ported to non-hybrid functions.
>> > > >
>> > > > Moreover, since both functions are already managed in this
>> > > > driver, the calls to
>> > > > pci_release_region() are unnecessary.
>> > > >
>> > > > Remove the calls to pci_release_region().
>> > > >
>> > > > Replace the call to sometimes-managed pci_request_region() with
>> > > > one to the always-managed pcim_request_region().
>> > >
>> >
>> > Hi,
>> >
>> > > Thanks you, Philipps, for the patch. The Octeon EP driver does not
>> > > use managed calls for handling resource regions.
>> > > This is because the PCIe PF function reduces its resources to
>> > > share them with its VFs and later restores them to original size
>> > > once the VFs are released. Due to this resource sharing
>> > > requirement, the driver cannot use the always-managed request
>> > > regions calls.
>> >
>> > so this would mean that the driver is already broken.
>> > pci_request_region() in your driver is always-managed since you call
>> > pcim_enable_device(). Or am I missing something?
>>
>> Driver is not actually broken. Yes, pci_request_region is always
>> managed in the driver due to pcim_enable_device().
>> But inside pcim_request_region(), res->type is considered as
>> PCIM_ADDR_DEVRES_TYPE_REGION and
>> pcim_addr_resource_release() releases entire bar. Whereas my driver
>> needs type=3DPCIM_ADDR_DEVRES_TYPE_MAPPING
>> so that pci_iounmap() get called. If I use this patch, driver reload
>> was failing for VF devices with below errors
>>
>> [90662.789921] octep_vdpa 0000:17:02.0: BAR 4: can't reserve [mem
>> 0x207ff0000000-0x207ff07fffff 64bit pref] [90662.789922] octep_vdpa
>> 0000:17:02.0: Failed to request BAR:4 region
>>
>> As you suggested below, I prefer to have non-managed version (use
>> pci_request_region()) and explicit remove() at required places for
>> now.
>
>Would you then mind replacing pcim_enable_device() with
>pci_enable_device()? Should I send you a patch for that or do you want to =
do
>that yourself?
>
>That should do the trick.

Either is fine to me, please send the patch, I will test it locally and ack=
 it.
>
>P.
>
>>
>> >
>> > The only way for you to, currently, have non-managed versions is by
>> > using
>> > pci_enable_device() instead and then doing pci_disable_device()
>> > manually in
>> > remove() and the other appropriate places.
>> >
>> > This patch should not change behavior in any way.
>> >
>> > If you're sure that having no management is not a problem, then we
>> > could simply drop this patch and I later remove the hybrid feature
>> > from PCI. Then your call to pci_request_region() will become
>> > unmanaged, even if you keep the pcim_enable_device().
>> >
>> > Tell me if you have a preference.
>> >
>> > P.
>> >
>> > >
>> > > >
>> > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> > > > ---
>> > > > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 4 +---
>> > > > 1 file changed, 1 insertion(+), 3 deletions(-)
>> > > >
>> > > > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > > > b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > > > index f3d4dda4e04c..e0da6367661e 100644
>> > > > --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > > > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>> > > > @@ -391,7 +391,7 @@ static int octep_iomap_region(struct pci_dev
>> > > > *pdev,
>> > > > u8 __iomem **tbl, u8 bar)  {
>> > > > 	int ret;
>> > > >
>> > > > -	ret =3D pci_request_region(pdev, bar,
>> > > > OCTEP_VDPA_DRIVER_NAME);
>> > > > +	ret =3D pcim_request_region(pdev, bar,
>> > > > OCTEP_VDPA_DRIVER_NAME);
>> > > > 	if (ret) {
>> > > > 		dev_err(&pdev->dev, "Failed to request BAR:%u region\n",
>> > bar);
>> > > > 		return ret;
>> > > > @@ -400,7 +400,6 @@ static int octep_iomap_region(struct pci_dev
>> > > > *pdev,
>> > > > u8 __iomem **tbl, u8 bar)
>> > > > 	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
>> > > > 	if (!tbl[bar]) {
>> > > > 		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
>> > > > -		pci_release_region(pdev, bar);
>> > > > 		ret =3D -ENOMEM;
>> > > > 	}
>> > > >
>> > > > @@ -410,7 +409,6 @@ static int octep_iomap_region(struct pci_dev
>> > > > *pdev,
>> > > > u8 __iomem **tbl, u8 bar)  static void
>> > > > octep_iounmap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8
>> > > > bar)  {
>> > > > 	pci_iounmap(pdev, tbl[bar]);
>> > > > -	pci_release_region(pdev, bar);
>> > > > }
>> > > >
>> > > > static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
>> > > > --
>> > > > 2.48.1
>> > >
>>

