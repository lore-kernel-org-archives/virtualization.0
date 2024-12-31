Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D913FD72
	for <virtualization@lists.linux.dev>; Tue, 31 Dec 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735669369; cv=fail; b=IYBeZTgWxcqeDGlfV7Tl1j63TvNn/pbzzxrUndXbRBI+YTADyHQNGLv1kQHY1waSULrj0sg0lPDBnPqMDBPa6xTfiirBaFBqVtnSL1eK//nZQx4WdMur8TS6wuYkOq353POmshvvx6vbWwgoXex/aC84232VunfkX3eYF1BgqyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735669369; c=relaxed/simple;
	bh=e0DPBFAfadnw5/7lqcJk4u2iw+nVNcQ7ImGY0JDil7s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qJgMma2YB+cg1WW4btgAvGO5ly4ikeqkde5dc7/5XvAqhUzVCHQEETVkv4aBGp7lbD81tA9gec3HKVYyfgx4clDbwswNN8tGkA7y+SZ9ulh1rr2lg55yoPrRYUK6YcMF8J142NVnlhB8yhv44Ls0AwEg2Dr7Wv86yPIRuT71NAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TT5ah0MD; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TT5ah0MD"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BVCuW4F010298;
	Tue, 31 Dec 2024 10:22:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=s2048-2021-q4; bh=e0DPBFA
	fadnw5/7lqcJk4u2iw+nVNcQ7ImGY0JDil7s=; b=TT5ah0MDY8eX0/rbldcsced
	Il0pLbMuf0gwkqgTl6Ui+2kIhEEP74rwrzwtzO5ItkHxsFF9phjWCqMNZ3EizFMo
	ma5a1/PPZu7Z062T/sN7V/wo544miKy6N39qOhzvRbz/14kHWyZzlnJoh4QTFNR5
	KDf1/tzNKwJ6PZMOhLjTYhxcympQA2XHjcwmt0pjd0M7B+N3vtGV8A34oxXmrkyD
	OieAg4/qX/XgKlgXC8eSkbnRtowOuB6wCB6fdQFJUYsQo3I6Lbbk70kozrkbK6F8
	FJGYjVCElXNitfbUI40mhI39w8A5VTNC4GmpGGtBTLCKzhxw+lumKuPGYL5C57A=
	=
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by m0089730.ppops.net (PPS) with ESMTPS id 43vgchu72b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 10:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw91sNV3Rtll/ODHjjBdRJG57L4HbCOD2ElzSgpPf8d5oKDc2k8L9I6p2pdV6ED9fF+RrPxMtaunPpSPIVHs60JWaACe2qnDj79XVCgwVAzvqW9B8kabiKSKWZ0qpS/Tcs6tSCCkBFLapMF3IZJJkNBUY1JGJwG8S06ag/NbIvsdoLMaW6C9kQjNfWkb4leG49mp57dRl60ry5JxPbyzIhxPnPMmp9OpWlFnj19rjHRTRDSDFjJiINBfh3F7Sx/PScSr+MWKIPCodWbfTSDVCpnIdvl3dLKqrVCyI7DXvgQ63cuW+yptZbI7llVno7RfV5d3gdpu6kpwr/IU40pJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0DPBFAfadnw5/7lqcJk4u2iw+nVNcQ7ImGY0JDil7s=;
 b=Iy9dt12YCEP3kdwOlJ/LrP69wXwFjFVGVsCkGpR76rp5SyiJY10ziTLS872u4OS8289GXX5hO0gYJnCrB6GL/pVuaLYtAjxWJfIgi1AryUvqvZEQ/o0/Xaq2e4Ttm+4zhH/mnTLHdMsLAW9VMytNMGdQ0Mb/FE8koUHZrdl1GOAPKzlOY7GyWVVCmJ/72l9ZdpuUj5F6RBIlixPGG/o13vxZGaA65viNy0HOcgGpGSg+whrI36Mm8Eoycw9HPnBCc1CLcs79EjgXQLSpzNptPNBAKWHgq6njf9oEeD8K86f39DEVDFcKoURO7nLAR3KQHw23UshWfhgYz2HEVu3ZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH0PR15MB5240.namprd15.prod.outlook.com (2603:10b6:510:143::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Tue, 31 Dec
 2024 18:22:40 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 18:22:39 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: problems with virtio and microvm in ACPI mode
Thread-Topic: problems with virtio and microvm in ACPI mode
Thread-Index: AQHbW7D5GNoyOetG8kejk3jwWvKxaQ==
Date: Tue, 31 Dec 2024 18:22:39 +0000
Message-ID: <a02be605-7aa1-4d31-bbb4-835dc3948ad8@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH0PR15MB5240:EE_
x-ms-office365-filtering-correlation-id: 8f484958-271b-4fde-4447-08dd29c81c0b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkY0WVlRL3VIYnNHak00OGdNOHhMTzFSK1RGeUIxUnRROEdLeTFkRWZoQ1c4?=
 =?utf-8?B?YXZMSm9Vc0tEaU52TllKN0FCYWdnQmlPMURNQUd1ZVBqY0oyTDdpWm05b1Bw?=
 =?utf-8?B?UTh5VE5oYk9TckQ2N2ZQTmhDalhiNEpzZGxtUVlGZzF0TGpSaTJDZHJDWGFC?=
 =?utf-8?B?UEN2NERPMktyYlJMdUlnNk5zUzdVcjlzVGc1VENEUU9WS3Q5ZUprYnFtVDhP?=
 =?utf-8?B?OXRuN1hQd3cveE5BNE9udnlDNjZPRE80R0xDd05IL3JTRm1zNGJVeEUxV3FU?=
 =?utf-8?B?cmJtaEt4Ym9vL2FqcjNselNLV01qaDlOSHoyRVhIRnBPczQwU09wbUY3Wngv?=
 =?utf-8?B?QUdlWmppQmxsbUdUZXgrZ2FpOFBMazY0cktqQnVxay9UdlNPTU94ZG8wQW0w?=
 =?utf-8?B?YVl5YTk5WU5HdDVmT0dLKzJFWHZzUnVFekJwOG90eThQRE5oWE9UUk9mMnh1?=
 =?utf-8?B?NmpPNjNwMU1lNXRHeHZ2d0JVWDRoWEhXQWM5ckxpR3hpQVJVZjJpOHVSM1ZE?=
 =?utf-8?B?TlZHVkQ0cklBeTh2aVhDc0MyMXpEdkQzQm9yLysrcDdMRjc0Y2N5RXh4MjJo?=
 =?utf-8?B?QTZZR2YrOS85R0pIU2xXdUJHMDhoQkRhOFpSbFcwZFNITDd1UktMMXdNSHFV?=
 =?utf-8?B?OVJYUTVyVktoaEpvTmZ4UFF6WlgwcUZTRjZsUnZrRGNWYUxxdStyR0ZON2py?=
 =?utf-8?B?eSs2S0d5UEw1V1lRWmJMNzgxMFdxRnd2dnlCR0NTYllOYnZPeVRocVRlSTBv?=
 =?utf-8?B?b1BBdWJsc1RnajZqbGZ0YzV3bWJqRDUyVlk4VEtjM1NucVhUVVd4VXRaZjlS?=
 =?utf-8?B?dXJpTmgyODJtdlIzU3NoKytneFE3RElGSlo3aUxUcWpwMVNpQmozU3Bqejlk?=
 =?utf-8?B?NEQ2RkpZeUJvQTVHWjhmbngrS1l1QXpXblRoQnl4bjhUdTR2RVV4ZjFlR1Zq?=
 =?utf-8?B?Z2hZcHV4VkxWUUVTdmMxd294YnFUWDF5OTBKTnh5emNORnZhUUxnVDMxMjAr?=
 =?utf-8?B?UXVyejdrbkJMWlpXSU83eVRTTXVuT2lkeFBKL2NURllyRzkrOW5maUFOY0hX?=
 =?utf-8?B?QXZUUWUzeThING9SbFN1RzZhS2hwOC8yd1FLMjV4OHFXbVNYKzk1TElIamU4?=
 =?utf-8?B?SFQxbG9FQ2x5b2JpR0c0bjh0c0ZFemgxUmRqS0dOVHdYRlhQekFlMmFOUTVu?=
 =?utf-8?B?Q1hnSG1ua2YrbG1oN1dRWm95R0R0ckY3WE1RM3NvM2IvQ0JwcDVFajlJTmhs?=
 =?utf-8?B?Z282QXlEeTlDQTFhSXRxRGRLaTFqWk5FQ2YyY3VodDFQNGNHSlNCT2t1Rkxv?=
 =?utf-8?B?NkdXaWpYU2xXZFEwdUZxK1QwcGFFZUphSGdnb3ZyODA5U01OcGw0SnVGMWlN?=
 =?utf-8?B?ZUc3blo4b2FRSlp5WmhtSDVmbTI0c0FzWm9UWFVidmdWMjZVMkhSTTVramRv?=
 =?utf-8?B?aVBibkw2ZnhDZ1ZKUXhUZzhlOU1yajhVVWl4dFpjNnpBcWZnMDN4Wjg5NTNO?=
 =?utf-8?B?TmMxaUdsNGVuOEtvb3JFbkFhZXlpamtFaW9WWjU1aHZkSmtXVDN5cWc5bXNN?=
 =?utf-8?B?OXp4UzZTL2U5WGtGS2hvWkV6N0JYZHVzMi9kMlFZS21pRVovSzN5aE5xRXZ1?=
 =?utf-8?B?WE1HQXVXcXZtTzgybyszZERmaG00cEpHUENFUUtQMFF6SzVJbW8zS3RPME1z?=
 =?utf-8?B?a3RIVEpHdEhzMkhQZWFpMDJpWUdIQjJTRVE2VEkxcXhKSys4L0dJcEdhWERr?=
 =?utf-8?B?NVhCQ2tLMm8wdVZDakVQdTI3cXZSaDZLMWxVQitEbXB6bUFwbjkxK20rTGlj?=
 =?utf-8?B?SmRhZFNCcW1ZZ1N1ZXFqSThqRjRSeVVBTG9ROWY0VUppMHE1Ym11QTNXMkoz?=
 =?utf-8?B?MzRFM3kzU01vMWFleThIMTFuRnRYeU1GTHI4dUZ1V2dtK28vWWpMRFdJUDhM?=
 =?utf-8?Q?lmi4uu8TpPjxwycj+YSBh0IDlH7ACkIf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGh2UzY5MG53cFR1YVRENDlFWTNXVGN6YkllZzVEOVRpMVFTV01FSThReHQx?=
 =?utf-8?B?RDFVUjcyNFk3N3M2WUhlY2xxVUNidVFPWHR4aWFJMzVXWE1LbWtoV1E1cWZz?=
 =?utf-8?B?cmpWZTNjWmlIbzhnMnQ3MTlyQnhrL1JET1h4UXV1N2l3UGVGL2JEb1pGSG15?=
 =?utf-8?B?blY0bENaSGw0NzhWOXFFRVRSYmE2M3FOT2JZbXpXVmcvMm9vU3hkMXBqd3Mx?=
 =?utf-8?B?YWhVU01BU3gyQW84YWRBWkxCQ3A0SEhjaEszenpEK3d4YVQxSUhNZEdyRFd5?=
 =?utf-8?B?VlpZbGZPREwxSHlqSUNGbG9qeUJCOTJHWTJGTkM0Zll2NS9oWklDamdsc2xK?=
 =?utf-8?B?K044dUVpeUVmWUo2N3AzMm8wNSszSkpOWFN3U080SHhKL3cyWVk4bHNCakN6?=
 =?utf-8?B?aW1wTTNlRmVKRjcrQktyNlZBeWs1ejFFWWpaOENhdzRsZkx2Mk45VVJKRkpi?=
 =?utf-8?B?YzRweVdRSXg0eXpJZ1NQSHcrNnRLNCtNUFZOd2grQk53azR2SmQ4VjVPL0Jp?=
 =?utf-8?B?SlRmMlZmVmV4bjVXU2RWbkV0eTFwUW0xMXo5RlJ6cUpuWUdYaEhxMWRUbEx2?=
 =?utf-8?B?SG9sSW8vUHppdCtyTFhoVFpLeDF0OVRFWHRacThrSDg0blRuK2JYMjZHaWtl?=
 =?utf-8?B?czAzQ2pudjBMck9hL2dEZVJFemhlTFlMYUdFQ1Zkc2NIWklVNHNPdWRpTjFu?=
 =?utf-8?B?SHFBQ0VDV0V2d2xKSFpUeFN4djlocXhjYTZIZW1ZYU5SNUJNUmxtakdSd3FZ?=
 =?utf-8?B?d1ZMdFZqZHVxdXl2OVp4eUZxTFhYY2NjdHo4ZW1XZXNnQTM0WkxpNXkrSm4w?=
 =?utf-8?B?NVl4ZkcrOGd5d2VYRUx5cGdtTDhHUzhQeHdPQm1VSDQ4djVlUWYxem8rZzBz?=
 =?utf-8?B?YVJLZ0xGenVHcHduWVRwZHlEa0F1TTl3dE56dVF2MlY1Vll3ekRLYXFMMWlC?=
 =?utf-8?B?dklqUXFJZUFNMW1kV3EwWTR0K3hnT2J6TXhIMk1CdXRUTDFsZUhSL0ZWSzV3?=
 =?utf-8?B?cm80aldWMGNMNlRvanM3RDNxaVZlQXJ6OEw0NjBxdjdRNlRnTjFuL09wSzhF?=
 =?utf-8?B?NzMzYjUxNEJhQWc3RmRpYi85dlBabUtDbUw2YU1CYzVNN2lvZmhCNXp3UmdZ?=
 =?utf-8?B?VTZHYXdXSndwQmdvRFFiMUJ4aVl0S1llMmJGMDB5WnAwZlV0cXhpUkJXeE53?=
 =?utf-8?B?SFRyd2JwbnI5NTVHUGZMdXgvakovMmw3N0wvVVFTVm1raUZMYmVMa25XT3JR?=
 =?utf-8?B?bWwwTXVYMlNCdy8rU1dZUEZKQkhFa0FDdE9nY2pwVUlBaE5Ya3ZGY2RVeGZD?=
 =?utf-8?B?VktXQktWN0E4YkhCYmYwdE01T0Y5aVlhS1krYUpHQ3g1eURqcGdwNmoxM1I0?=
 =?utf-8?B?cThTanFEVFZxcEU2UTFVRUtxcHhaRkx2V0duQWVadXB2ZDlWdUlINk5GUEFq?=
 =?utf-8?B?b2FQRFFUMWlldUlRaUxsN0UwczdJRlFISmNlaGdlemJaWnRZWEJ4d3h5aGpo?=
 =?utf-8?B?aXdNaU8wbzlhRy9LNFhrZ2tiUDIrYnlXSnZaV3FPYzJXamYyMzRyU0JxQ0pl?=
 =?utf-8?B?dmR1OWhtSk1WM1lWZWp4RGdZaEQvdk9SUEx2UStWUWtFTUt0YVd5dWpOdU1G?=
 =?utf-8?B?dHlIbUFaWFpkN1RMajEvdzdCdlVxeXF3b3U0R0V5dFN2eFhLcGlRM1FFZWxw?=
 =?utf-8?B?THJ1TjZvUnB4Um1WTG8wbm1aVWZ1NWlPZ1lFUG5VZll0Z0F2ZzlUS01lOEhq?=
 =?utf-8?B?ZFhKb1pCRmRQQ3puQ2JUc012MmZaSmhMc3JiTmJRTTgzSGlSZUpQYXZtWHg4?=
 =?utf-8?B?aEgvdzh3ZnRNT29FbXdJelYwZmF0VUVOOTRORkJ6SzhCWFQrYUNYUWJCRUEw?=
 =?utf-8?B?ZmhmRjYvdGlFNFUwaGpLSjU1bVJRRTgyZ3hOV0p1bXc4enhXeUNsdDZzL3pF?=
 =?utf-8?B?ZWdCMk11aVNMK1QvY00zdTNHYTZlODdVWmdLclIrSENUNjNWS3p1ODl0bTd5?=
 =?utf-8?B?dHZiSHg0VHNMbjhORERUQi9qVkhLMjN2WnRyZmcvT285c2I2c3RkSllza2pC?=
 =?utf-8?B?T3lDUnFwZVBMRHFvcGxBQ3VOcVFwUGQxM09IQnFNR240QWNaamx6OE9mWi9m?=
 =?utf-8?B?N2xpU0wydFdGTGU2WTJlaFRReVo4NHV1TkhKRXVxVnUwNEg4NWZZVEUrenF3?=
 =?utf-8?Q?XVafpYl4Sq56GAnHdkpx774=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0A2D1C69833EE408409079F4338BC7A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f484958-271b-4fde-4447-08dd29c81c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2024 18:22:39.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4o66YtUfx+RwGN6ylhJ1c/j//hKEqGB5SZDJcg1YpqljJcV780CIPTD1ojiNCpheq/+iYpc/Zb96yYoTNETxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5240
X-Proofpoint-GUID: 9Ocq2v9RmV7SMgLY9cpQtEW70g-qUIM2
X-Proofpoint-ORIG-GUID: 9Ocq2v9RmV7SMgLY9cpQtEW70g-qUIM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgYWxsLA0KDQpJJ3ZlIGVuY291bnRlcmVkIGEgcmVhbGx5IHdlaXJkIGJ1ZyB3aGVuIHRyeWlu
ZyB0byBydW4gdGhlIGZzdGVzdCANCmdlbmVyaWMvNDc2IGluIGEgbG9vcCBvbiBhIG1pY3Jvdm0g
Vk0uIFRoZSBibG9jayBkZXZpY2UgaXMgYQ0KdmlydGlvLWJsay1kZXZpY2UsIGZvcm1hdHRlZCBh
cyBidHJmcy4NCg0KV2l0aCBhY3BpPW9uLCBpdCBldmVudHVhbGx5IGdyaW5kcyB0byBhIGhhbHQs
IGFuZCBwcmludHMgYSBoYW5nIG1lc3NhZ2UuIA0KSSB0cmFja2VkIHRoZSBwcm9ibGVtIGRvd24g
dG8gYmUgd2l0aGluIHdhaXRfZGV2X3N1cGVycywgaS5lLiBpdCdzIA0KYXBwYXJlbnRseSBpc3N1
aW5nIGEgd3JpdGUgZm9yIHRoZSBzdXBlcmJsb2NrIHRoYXQgbmV2ZXIgcmV0dXJucy4gVGhlIA0K
c3RyYW5nZSB0aGluZyBpcyB0aGF0IHdpdGggYWNwaT1vZmYgZXZlcnl0aGluZyB3b3JrcyBhcyBp
dCBzaG91bGQuDQoNCmFjcGk9b2ZmIGFkZHMgdGhpcyB0byB0aGUgY21kbGluZTogdmlydGlvX21t
aW8uZGV2aWNlPTUxMkAweGZlYjAwZTAwOjEyDQoNCmFjcGk9b24gYWRkcyB0aGlzIHRvIHRoZSBE
U0RUOg0KDQpEZXZpY2UgKFZSMDcpDQp7DQogICAgIE5hbWUgKF9ISUQsICJMTlJPMDAwNSIpICAv
LyBfSElEOiBIYXJkd2FyZSBJRA0KICAgICBOYW1lIChfVUlELCAweDA3KSAgLy8gX1VJRDogVW5p
cXVlIElEDQogICAgIE5hbWUgKF9DQ0EsIE9uZSkgIC8vIF9DQ0E6IENhY2hlIENvaGVyZW5jeSBB
dHRyaWJ1dGUNCiAgICAgTmFtZSAoX0NSUywgUmVzb3VyY2VUZW1wbGF0ZSAoKSAgLy8gX0NSUzog
Q3VycmVudCBSZXNvdXJjZSBTZXR0aW5ncw0KICAgICB7DQogICAgICAgICBNZW1vcnkzMkZpeGVk
IChSZWFkV3JpdGUsDQogICAgICAgICAgICAgMHhGRUIwMEUwMCwgICAgICAgICAvLyBBZGRyZXNz
IEJhc2UNCiAgICAgICAgICAgICAweDAwMDAwMjAwLCAgICAgICAgIC8vIEFkZHJlc3MgTGVuZ3Ro
DQogICAgICAgICAgICAgKQ0KICAgICAgICAgSW50ZXJydXB0IChSZXNvdXJjZUNvbnN1bWVyLCBM
ZXZlbCwgQWN0aXZlSGlnaCwgRXhjbHVzaXZlLCAsLCApDQogICAgICAgICB7DQogICAgICAgICAg
ICAgMHgwMDAwMDAwQywNCiAgICAgICAgIH0NCiAgICAgfSkNCn0NCg0KLi4uYW5kIHRvIG15IHVu
dHJhaW5lZCBleWUgaXQncyBub3Qgb2J2aW91cyBpZiB0aGVyZSdzIHNvbWV0aGluZyB3cm9uZyAN
CnRoZXJlLg0KDQpEb2VzIHRoaXMgcmluZyBhIGJlbGwgdG8gYW55b25lPyBJcyB0aGUgYnVnIGlu
IFFlbXUsIHRoZSBrZXJuZWwsIG9yIGFtIEkNCmluYWR2ZXJ0ZW50bHkgZG9pbmcgc29tZXRoaW5n
IHN0dXBpZD8gSSdtIGhhcHB5IHRvIGhlbHAgc29tZW9uZSANCnJlcHJvZHVjZSB0aGlzLg0KDQpU
aGFua3MNCg0KTWFyaw0K
