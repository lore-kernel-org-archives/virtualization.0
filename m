Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862F14F115
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639418; cv=fail; b=kbqdqhKa58acBO+YP/wjlizQaUqtIh9Q6HIlhSLFQYDQj+tbxIFNvrF07nJ6c5A8clfKts2FWinlHyfZdX9R3fV6yMVBNdsoNWx1Qtu3by8BOYQsyIGgXHkKnDtZ77/K2pJZsqJKrenNSjptrvam6qkltc8mRcrsCf2vu6a4dZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639418; c=relaxed/simple;
	bh=oL4jtveVmErXvizAmles+R2GrWDt4fLu6ezeW2aL8hA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B0JNDDV6aUH3tQb/8WlSObKXuxQBkNIurfVE6qa7xDHUEq/nUl3EcfEwMLB2Q4Z6YmJQe4JhG9+HdL56nF9VBjysv/R5CQvn3FLmFrHJ1ynI00cDIVcd5VMR6p7vIp2SzpQthk8aDZnNLG6P0bWOObwu6HTGnxlYj5TnULtLQV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhgZU8nA; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhgZU8nA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C79E814A0
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 15:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CqnozCGvGtXg for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 15:50:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:200a::619; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=dtatulea@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0FB7B8119E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FB7B8119E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qhgZU8nA
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20619.outbound.protection.outlook.com [IPv6:2a01:111:f403:200a::619])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FB7B8119E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 15:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2aJvkejHMte3blRG4hypp6XcFSea301st5N/OrBURyxBHtmkz78gZrzlddLZoJ+All1MvAcU633Oci0Scu//wwEGSPaXGLHTJEABwyjbRIDgtHtB0clCYYyyJwp5VzXzdS5IWNosz/4bRjyv2VgIRdka7qDSzNv1QVQ6oTIz3HP5e8MYpR++yA/U4Zy4lxLHPT8j+1gAOcpRKGw5usyNqFZiKJrBbT7BpFxVt90SntxY+Iu+EUCnznvHl4lAKhxJB1xvcq56pRUUHTkLGQqa7itXwSC/sPeq+Vgb/tlewlCIFQjUrIfQ3MtUYjY9NSM194XPWYVqjpIVcZ2dCRb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL4jtveVmErXvizAmles+R2GrWDt4fLu6ezeW2aL8hA=;
 b=YTQNOp6ddddqO7Rt87rFCBkbLXyb6A9m1hu3igkFhnHzJgbTAfMkO2a18sTb82BrjvkHpDv+BF29AxkpKKLLSkAMzbzUkXs7dnDDnXhKOeBuUhAbW3YUt6cUfMSGALd9b9f3yi0zjnkICxXgTBizBpIT41rJayiFw2TUCKmV47DVewzMnXw5ZNLfvcLgZ70+fylsI1rzN40qHMjaX6w05ozSprdLmFW7NZV8M7PLmF6icpG/heAUqV0Plpo5Phen4c6Y8noDhhgWNGaQH3HKw+k5bMtqS7Hzpb3EPgnlebbUOG5WFK33NskG2K7s//DH0Hb7PipZ7ui9I/8HYncuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL4jtveVmErXvizAmles+R2GrWDt4fLu6ezeW2aL8hA=;
 b=qhgZU8nARCvWyp5isCDRK0IfUzNx8MdsyT7f8XlWUtRpdtiTpy47JAf3weLyDxqhjZ9l3zu8LpdZxVaWVSqO0dXGKUzhd6lE1a/CZFG+3v5mpOT9MQ4xrFXBT66ZpW3ov2sHjNVU75riNBEfn2P6ZCD/NEPmJMW2ioybKfkjnwkdI3LngEemrkj5zUv3hsXuXCweV3mizE4Q5lEHWAROBCRVltcJ7G5sSbkfUC/RwcPbRUBbsYdqf+WKXQf8m8fuuWHHsIoCep4q87XDtOomURGAiNgx6+ZwOgngwRFzOE8weE7Hkr3o0QNDO8lh8CanzpGuazO4RCYMSF5x6Zmk6w==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:50:10 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 15:50:10 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>
CC: "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Thread-Topic: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Thread-Index: AQHawM4I1/zRB3CmoUOTMvVFPy5VHQ==
Date: Mon, 17 Jun 2024 15:50:10 +0000
Message-ID: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MN0PR12MB6272:EE_
x-ms-office365-filtering-correlation-id: 2cc23c94-81dd-4687-cfa8-08dc8ee52b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEp0UEl6dTdBbUdDZDNhMG9NMlF0TWlKdDZJOHdTRWVqQWNSKzFaTFZtajli?=
 =?utf-8?B?NmY0cU5EQkJVUlIwVjNoNC8zd0kzbnU5Zzk5ODhLMmJyRUk2V05XK1NrVVc3?=
 =?utf-8?B?K1lpVmtlWVVQZGgxN01aMXJHa2s1bkhhY01tbGlQaFBHQ2ttUEgzNjRqbjBq?=
 =?utf-8?B?U2Fxc2YrWjFJREZPZWRZMkY2Uko0b1VSZzhPVXZ5RFNMMXp1NkNUTWN3dWJh?=
 =?utf-8?B?U0RzcnEybFhKVFBmaHFGdmxpUlVyUjRicDZ1dmY4N09pOVpySlRZUlUvN3I5?=
 =?utf-8?B?UG9rNTd1TWtCZ1lNRE5XZlh6R1dIeVkzR1lpM0RBUERMcHpPVkN2RU4rc2NJ?=
 =?utf-8?B?YWRKMlBIZjNleGVUWFdvOUdhV2tHQzdsa0RTQXFtOUYxOHZJMzdLd0dCU3pB?=
 =?utf-8?B?clNGTnM0a1IyTE9WS05aZFY0Lzh0QUJSb1FIVU54V0M2WmRYMktJcHU0QnN2?=
 =?utf-8?B?bGFnSUlLNjVhcHJyWENNVlZDTHkzM1JtK2Z5K3k4K1pHVCtCZkl6T2NSQ0hl?=
 =?utf-8?B?Z3RkTkkweUtDcUhBaWdXK1hIb09hTXZ1SDMyNlhlTkN0SjhuL05TR2ZST0RH?=
 =?utf-8?B?MjZLeWdKN1ZLVnZDQnEvODRkcmVXRVBud0s3cmQxa1Q2U3pJQmpiQUpTSkRv?=
 =?utf-8?B?cDlPQkp5TjhVZjZPS0h0MEU5amk3dXVXNG9MVWxEUS9VR0hEVG10V3VEMnFl?=
 =?utf-8?B?dUg5QWhucGdUV3ZzcU5qK2h6V1NNRjhTRzNWdS9jb0YwRHF0dy9UQWttZEli?=
 =?utf-8?B?UTlEeUVaWnV0VlVmZzBpNWxKOXlTNUpPQk5rME56R3dSZ1IwcUZLK0xrOEVJ?=
 =?utf-8?B?QUsrWGUyWTZWNDloMkR5YmtQSDNOWjVJdnlxSGtkei9nRlRYTzQwVnlKUXk3?=
 =?utf-8?B?Y2Ezamw4cjkyWjQ1c3RFR29wSTdHaW9aOXlaVlN6dUVoUkxzckl4QzFSWG16?=
 =?utf-8?B?cDFYcTc2S2NsMytOYWpISGJUL3FCREJZZ0gyaVRQODUvUStKZmxxaGdLQVl2?=
 =?utf-8?B?WlBYL2p6bXNwRXhaMWVaZ29CNzVjY0t4K2hoK0ZXZnNoYkR2bDYwWlo3V0Js?=
 =?utf-8?B?TXJFOTdhTGpMYW5ucVNTdEtsVXIyRWVnUFR2NXViMzl1MU5mMCtUdEZvU3Bq?=
 =?utf-8?B?NlZ5aVpTN05qK2hLRkRlM003REJsRjlES05jcURmVEQwcERTQmpvRFJTSTBC?=
 =?utf-8?B?Mm15cThPMm5NQTJ0Z0hLdEtqMnRlRXdLWkFxT1JTcUphVS9YVzlBMUVoclNk?=
 =?utf-8?B?ejMxRThNZmtrelhpTGVnUWJwKzhOODU3S21JU3VjTlBNaWJ2SEhLMEwzemNC?=
 =?utf-8?B?aVQ0N0Z1TUQxbFo1Vm5YZUNxdk5pcFp4TXBlQzhkaTh4Nm9vOE9LSlZwMGtk?=
 =?utf-8?B?S0VBK3hTbkw2MElORGxIUEVYQ0VWWlBkT1dBYyswdGVzd2NzUU90Lzdvc1RS?=
 =?utf-8?B?bXI1ZDJiM05QT2pYYkJpQ3FjTWZmbUJhckpibDEwZVI1RVhsanh5NllQQmRZ?=
 =?utf-8?B?RFdjeGpHWGx3MlZXd2k4b2JFVnc0M2Y5YkFwUnNpSnFFa0ZZZ1VjUWs4dTg3?=
 =?utf-8?B?bU9xZzFSWC9hUkNBWnh5OTRkVjR0RzIxVlRad0hSWVVsTEo0Nnh2ZXJwMzE2?=
 =?utf-8?B?blJuMFJmUGluZk1uMVNrYzlvaUpHWnVIUWtGNExjUnhYS3Q4QSt5OFV2WEQy?=
 =?utf-8?B?c2RlZGx2Yko1NGZPeTEzRHdveTV6aW00K1NUdVVqbjRQMHJ2VTYwUFhsdnpC?=
 =?utf-8?B?ZnpaZi9CSFNJRm1HMWZuWitFMlBHanBORFQvWU9reG5jVmU5L0YvVGJWUThR?=
 =?utf-8?Q?kgM1pL7rNnW0oZmNOHvt9RGAjaW9htgkr56Bc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm5RRkMyRm5nZWg5YWlUbmVvZFVyOFlrbndhZ1l4WnlEZWgzVCs1QWlhRzRt?=
 =?utf-8?B?M0x2enZIZFRIR3IrU2x1VVN3aEFMTk1vblN2WS9iVTBFSXQvd2R2M2FpL0V3?=
 =?utf-8?B?K2l6bU5Tb0xRNW1EVU9RZUt6SVZaZG5KSHd4SGJmbGFGMENmME42L2RodUky?=
 =?utf-8?B?M3pzUTlsYlFodmxCU1UrVkRPUG9haiswaldnWkdKNHdvWDMwbVJ2Q09zemls?=
 =?utf-8?B?R05ZZDN3dXlIZnpicTZQd2UwTVFNdkhFWnJrYytjTlVZeFk4YlJrY2o2WnVz?=
 =?utf-8?B?b1VSMktJK2tQVmRwR3RJUE5oeFE4Zkw0V2pHQVBRakNILzAvZUF2OVNEazFk?=
 =?utf-8?B?SzkwdzBLZFd6b1RnR0pNbkQxS2NPUExUMVJuY0VMTzZwL2dDRVVoYlR1aWxM?=
 =?utf-8?B?K0I4NHpMclMyanhmUEJwWHNhNzYvbFYxNkwwbjR5clo2V1lhenJJU1NNYWJX?=
 =?utf-8?B?NWo3bnJFY2pDMk8xMmQ4cThqNkFnQTVEK3M3YWw2ZXhGMGpJLzh3bHpmL0Vq?=
 =?utf-8?B?RFU1NFZzNDlaOHc0Tk5WTkxpL29MRVZXQzBmNEtGbUZseWNRZWF6Q0pBR01Y?=
 =?utf-8?B?cE03SkRIb1VSbFFEcjhKZ1NUV08vWDlublBXc0M3NmRNM3ZUQXhWYmRTTldM?=
 =?utf-8?B?dTZGZUpiUGxYczFYMDFHT2VsMEFpU20ybEQ3cWNoZmVoZExIZG4rMEJvU3JC?=
 =?utf-8?B?dGQwcXZqbnRTR2RuakZFTEpqRXlpQy85ZlIzdDZiUHdUYTdLK2pTUm9USEZn?=
 =?utf-8?B?K0dCME5Td2ZNY0dpQ0JOTzc3UnRtOXVUdzZBbmh3dDB6UzJKVE5GTzVNek13?=
 =?utf-8?B?N3VGUHZxMHBPUE4vQU9DNGNLZkRzOGdTQllZTUJuclVJeHN1MlJNVllTT0sx?=
 =?utf-8?B?d05NSTNZN0U0K3hCQXB2NEpWSUpzdFZEWGd2VGw0aVowUU5jSVJLWjdtVFk3?=
 =?utf-8?B?QkVUUkFqcnh3d3JWLy8rQmFXdk50dDRhWitFcTdFd0NILzBvWUpQbWZYOUQ5?=
 =?utf-8?B?Ylg1Zk4xa2JUZHFzMzd4aG9waEhVSnFmeFl5OHp3S0VyRTdYZGtWcW1nZlBX?=
 =?utf-8?B?eUltdHFZVDQ0cnFCdEh0aVlrU044bmwybjVHUUdOZHQ3MStPclZkdDJVcm5a?=
 =?utf-8?B?ZFZmZnJOalZqWFZrZGx1aVFsNzNGRE5FZFo5MFlLTmhPRTVyeXUrV1Y2UDBP?=
 =?utf-8?B?SklsZmU2Q2l1NHBELzVDbFp6RHJNVXhjTkRQektuMm1tMG9FRXJyL1N2QmlR?=
 =?utf-8?B?VG41QW9qNllNRnZrL3AxNzBrS1ZOZjBKcDZ6azRWU0NRcFIzSG5hY25ZcS9L?=
 =?utf-8?B?dDh0dXdrblF4VS9RV0w4MmhpaTBvYVp1Y1A3UVJGR3c3UWpnVVRNM1MwdElr?=
 =?utf-8?B?QU1vZHZ3VWkyTVUrUktIdnZnczNwNXh6MlVpbXBKZm8waVlreXZyelhNZjFh?=
 =?utf-8?B?dFB6UDBCQnFjZWJzK0RuQWFrNjN3Vjg0WHJELzhWdU1SMmZHVXkxNklkRElQ?=
 =?utf-8?B?ZXdlTnVXWi9vTHdxcXZzbEV2TFJiZFd1Q2hzSU8zemV3QVdyUkNmU2RiY1Rz?=
 =?utf-8?B?eUcyVTBSRlhleEdaUURPY2lhSzJGcjBlRGZTcytPWWc4eTkrM0pwaE1weWFN?=
 =?utf-8?B?bENrelVjdkVzTmVxTlp4L2hPWERlL2lSSFNKRllSY0xWYmpCT1lrQWwxdDdn?=
 =?utf-8?B?SEU3VUNOL01lR1NjQzB1Q0VUOEZoaHlwamVsalptd0VmVVNEdFkxUnR4NGtQ?=
 =?utf-8?B?QXVZS0hLTFdGb0xydi93b2k3M1g0UDN0NUlZZTRrc08vdDdySndxd1NqZ2Ru?=
 =?utf-8?B?SEd6VkN4amJLRXV2NUhoU1RpUG5nUkhCVzJWN3owSWl0RE81MmZ2M08vb1la?=
 =?utf-8?B?SlBxMFNsa044VzRXUjVZMkNIbk5acDZtbWRCQk5QOFlBRmdRRjdEWXBxcFdj?=
 =?utf-8?B?b0E1UzBmc2F2em9kKzV3TWRvYjhvN0lERFJBSzhXVDMxUDlhQlFFSkFLcC9X?=
 =?utf-8?B?SkpYdWdvUnozMEhqZEp4MVpzWlZmNS95L0FTb05EckpnNVpiYVJ1UGFLRVpV?=
 =?utf-8?B?Y0R3bWRMMHlzcy90Z1ZRVVB2Z1p6OUM5dTRFYS9lOTMraDN2aWl1RnRvYU9J?=
 =?utf-8?B?eFptMlBKZUlFVGZaaG8xVXczN3piSDBLQVo5U1I5S2hMNm1VUnBRUElEY2Nm?=
 =?utf-8?Q?yvfx9OqWV6nhvcIXKVySimAupKkCJjI+zKWW4zPZpLcK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F7D871B9157C146B53908D28E2374E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc23c94-81dd-4687-cfa8-08dc8ee52b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 15:50:10.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10T6uTZTildfs7kcThYWu6/6bzAtR6dTNJK/I76boIbnm5ZWlZX7QLjxqsFSv+uBDwhWd7z1ItLjMAOmzwo15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

SGksDQoNCkFmdGVyIGNvbW1pdCBiYTE2OGI1MmJmOGUgIm1tOiB1c2UgcndzZW0gYXNzZXJ0aW9u
IG1hY3JvcyBmb3LCoA0KbW1hcF9sb2NrIikgd2FzIHN1Ym1pdHRlZCwgd2Ugc3RhcnRlZCBnZXR0
aW5nIGEgbG90IG9mIHRoZQ0KZm9sbG93aW5nIHdhcm5pbmdzIGFib3V0IGEgbWlzc2luZyBtbWFw
IHdyaXRlIGxvY2sgZHVyaW5nIFZNIGJvb3Q6DQoNCi0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0t
LS0tLS0tLS0tLQ0KV0FSTklORzogQ1BVOiAxIFBJRDogNTg2MzMgYXQgaW5jbHVkZS9saW51eC9y
d3NlbS5oOjg1DQp0cmFja19wZm5fcmVtYXArMHgxMmIvMHgxMzANCk1vZHVsZXMgbGlua2VkIGlu
OiBhY3RfbWlycmVkIGFjdF9za2JlZGl0IHZob3N0X3ZkcGEgY2xzX21hdGNoYWxsDQpuZm5ldGxp
bmtfY3R0aW1lb3V0IGFjdF9nYWN0IGNsc19mbG93ZXIgc2NoX2luZ3Jlc3MgbWx4NV92ZHBhIHZy
aW5naCB2ZHBhDQpvcGVudnN3aXRjaCBuc2ggdmhvc3RfbmV0IHZob3N0IHZob3N0X2lvdGxiIHRh
cCBpcDZ0YWJsZV9tYW5nbGUgaXA2dGFibGVfbmF0DQppcHRhYmxlX21hbmdsZSBuZl90YWJsZXMg
aXA2dGFibGVfZmlsdGVyIGlwNl90YWJsZXMgeHRfY29ubnRyYWNrIHh0X01BU1FVRVJBREUNCm5m
X2Nvbm50cmFja19uZXRsaW5rIG5mbmV0bGluayB4dF9hZGRydHlwZSBpcHRhYmxlX25hdCBuZl9u
YXQgYnJfbmV0ZmlsdGVyDQpycGNzZWNfZ3NzX2tyYjUgYXV0aF9ycGNnc3Mgb2lkX3JlZ2lzdHJ5
IG92ZXJsYXkgcnBjcmRtYSByZG1hX3VjbSBpYl9pc2VyDQpsaWJpc2NzaSBpYl91bWFkIHNjc2lf
dHJhbnNwb3J0X2lzY3NpIGliX2lwb2liIHJkbWFfY20gaXdfY20gaWJfY20gbWx4NV9pYg0KaWJf
dXZlcmJzIGliX2NvcmUgZnVzZSBtbHg1X2NvcmUNCkNQVTogMSBQSUQ6IDU4NjMzIENvbW06IENQ
VSAwL0tWTSBUYWludGVkOiBHICAgICAgICBXDQo2LjEwLjAtcmMxX2Zvcl91cHN0cmVhbV9taW5f
ZGVidWdfMjAyNF8wNV8yOV8xN18wNiAjMQ0KSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQ
QyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MNCnJlbC0xLjEzLjAtMC1nZjIxYjVhNGFlYjAyLXBy
ZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNClJJUDogMDAxMDp0cmFja19wZm5fcmVtYXArMHgx
MmIvMHgxMzANCkNvZGU6IDQ4IDgzIGM0IDA4IGI4IGVhIGZmIGZmIGZmIDViIDVkIDQxIDVjIDQx
IDVkIGMzIDQ4IDgzIGM0IDA4IDQ4IDg5IGVmIDQ4DQo4OSBmMiA1YiAzMSBjOSA0YyA4OSBjNiA1
ZCA0MSA1YyA0MSA1ZCBlOSBmNSBmYiBmZiBmZiA8MGY+IDBiIGViIDliIDkwIDBmIDFmIDQ0DQow
MCAwMCA4MCAzZCBhYyA1OSA5NiAwMSAwMCA3NCAwMSBjMyA0OCA4OQ0KUlNQOiAwMDE4OmZmZmY4
ODgzNTBmOGI4ZTAgRUZMQUdTOiAwMDAxMDI0Ng0KUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDog
MDAwMDAwMDAwMDAwMTAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClJEWDogZmZmZjg4ODEwODBj
YTMwMCBSU0k6IDAwMDAwMDAwMDAwMDEwMDAgUkRJOiAwMDAwMDAwNTQ0MDAzMDAwDQpSQlA6IDAw
MDAwMDA1NDQwMDMwMDAgUjA4OiBmZmZmODg4MTA2NzMwYTYwIFIwOTogMDAwMDAwMDAwMDAwMDAw
MA0KUjEwOiBmZmZmODg4MTE2ZWVmZjYwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4
ODgzNTBmOGI5MTgNClIxMzogZmZmZjg4ODE0OWY5OWRhOCBSMTQ6IDAwMDAwMDAwMDAwMDEwMDAg
UjE1OiAwMDAwMDAwMDAwMDAxMDAwDQpGUzogIDAwMDA3ZjY3OGQ4MDA3MDAoMDAwMCkgR1M6ZmZm
Zjg4ODUyYzg4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpDUzogIDAwMTAgRFM6
IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpDUjI6IDAwMDAwMDAwMDA0ZTU0
ZjggQ1IzOiAwMDAwMDAwMTEyMjkwMDA0IENSNDogMDAwMDAwMDAwMDM3MmViMA0KQ2FsbCBUcmFj
ZToNCiA8VEFTSz4NCiA/IF9fd2FybisweDc4LzB4MTEwDQogPyB0cmFja19wZm5fcmVtYXArMHgx
MmIvMHgxMzANCiA/IHJlcG9ydF9idWcrMHgxNmQvMHgxODANCiA/IGhhbmRsZV9idWcrMHgzYy8w
eDYwDQogPyBleGNfaW52YWxpZF9vcCsweDE0LzB4NzANCiA/IGFzbV9leGNfaW52YWxpZF9vcCsw
eDE2LzB4MjANCiA/IHRyYWNrX3Bmbl9yZW1hcCsweDEyYi8weDEzMA0KIHJlbWFwX3Bmbl9yYW5n
ZSsweDQxLzB4YTANCiB2aG9zdF92ZHBhX2ZhdWx0KzB4NmMvMHhhMCBbdmhvc3RfdmRwYV0NCiBf
X2RvX2ZhdWx0KzB4MmYvMHhiMA0KIF9faGFuZGxlX21tX2ZhdWx0KzB4MTNkMy8weDIyMTANCiBo
YW5kbGVfbW1fZmF1bHQrMHhiMC8weDI2MA0KIGZpeHVwX3VzZXJfZmF1bHQrMHg3Ny8weDE3MA0K
IGh2YV90b19wZm4rMHgyYzUvMHg0YjANCiBrdm1fZmF1bHRpbl9wZm4rMHhkNy8weDUxMA0KIGt2
bV90ZHBfcGFnZV9mYXVsdCsweDExMS8weDE5MA0KIGt2bV9tbXVfZG9fcGFnZV9mYXVsdCsweDEw
NS8weDIzMA0KIGt2bV9tbXVfcGFnZV9mYXVsdCsweDdkLzB4NjIwDQogPyB2bXhfZGVsaXZlcl9p
bnRlcnJ1cHQrMHgxMTAvMHgxOTANCiA/IF9fYXBpY19hY2NlcHRfaXJxKzB4MTZjLzB4MjcwDQog
PyB2bXhfdm1leGl0KzB4OGQvMHhjMA0KIHZteF9oYW5kbGVfZXhpdCsweDExMC8weDY0MA0KIGt2
bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKzB4ZGIwLzB4MWMyMA0KIGt2bV92Y3B1X2lvY3RsKzB4MjYz
LzB4NmEwDQogPyBmdXRleF93YWtlKzB4ODEvMHgxODANCiBfX3g2NF9zeXNfaW9jdGwrMHg0YTcv
MHg5ZDANCiA/IF9feDY0X3N5c19mdXRleCsweDczLzB4MWMwDQogPyBrdm1fb25fdXNlcl9yZXR1
cm4rMHg4Ni8weDkwDQogZG9fc3lzY2FsbF82NCsweDRjLzB4MTAwDQogZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NGIvMHg1Mw0KUklQOiAwMDMzOjB4N2Y2NzkxODZhMTdiDQpDb2Rl
OiAwZiAxZSBmYSA0OCA4YiAwNSAxZCBhZCAwYyAwMCA2NCBjNyAwMCAyNiAwMCAwMCAwMCA0OCBj
NyBjMCBmZiBmZiBmZiBmZg0KYzMgNjYgMGYgMWYgNDQgMDAgMDAgZjMgMGYgMWUgZmEgYjggMTAg
MDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMQ0KYzMgNDggOGIgMGQgZWQg
YWMgMGMgMDAgZjcgZDggNjQgODkgMDEgNDgNClJTUDogMDAyYjowMDAwN2Y2NzhkN2ZmNzg4IEVG
TEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMTANClJBWDogZmZmZmZmZmZm
ZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMGFlODAgUkNYOiAwMDAwN2Y2NzkxODZhMTdiDQpSRFg6
IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDBhZTgwIFJESTogMDAwMDAwMDAwMDAw
MDA1OQ0KUkJQOiAwMDAwNTVkYTVlZTIyMDUwIFIwODogMDAwMDU1ZGE0NGIyODE2MCBSMDk6IDAw
MDAwMDAwMDAwMDAwMDANClIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IDAwMDAwMDAwMDAwMDAy
NDYgUjEyOiAwMDAwMDAwMDAwMDAwMDAwDQpSMTM6IDAwMDA1NWRhNDUyYjA1ZTAgUjE0OiAwMDAw
MDAwMDAwMDAwMDAxIFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KIDwvVEFTSz4NCi0tLVsgZW5kIHRy
YWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQpUaGUgd2FybmluZ3Mgc2hvdyB1cCBvbmx5IHdo
ZW4gdGhlIHZkcGEgcGFnZS1wZXItdnEgb3B0aW9uIGlzIHVzZWQgKGRvb3JiZWxsDQptYXBwaW5n
IHRvIGd1ZXN0KS4NCg0KVGhlIGlzc3VlIHNlZW1zIHRvIGhhdmUgZXhpc3RlZCBiZWZvcmUsIGJ1
dCB3YXMgdmlzaWJsZSBvbmx5IHdpdGggQ09ORklHX0xPQ0tERVANCmVuYWJsZWQuIEkgdHJpZWQg
ZmluZGluZyBpZiB0aGlzIHdhcyBpbnRyb2R1Y2VkIGluIG1vcmUgcmVjZW50IGtlcm5lbHMsIGJ1
dA0Kc3RvcHBlZCBhZnRlciBnb2luZyBhcyBmYXIgYmFjayBhcyA2LjU6IHRoZSBpc3N1ZSB3YXMg
c3RpbGwgdmlzaWJsZSB0aGVyZS4NCg0KVGhlIHdhcm5pbmcgaXMgdHJpZ2dlcmVkIGZvciB0aGUg
Zm9sbG93aW5nIGNhbGwgY2hhaW46DQp2aG9zdF92ZHBhX2ZhdWx0KCkNCiAtPiByZW1hcF9wZm5f
cmFuZ2UoKQ0KICAtPiByZW1hcF9wZm5fcmFuZ2Vfbm90cmFjaygpDQogICAtPiB2bV9mbGFnc19z
ZXQoKQ0KICAgIC0+IHZtYV9zdGFydF93cml0ZSgpDQogICAgIC0+IF9faXNfdm1hX3dyaXRlX2xv
Y2tlZCgpDQogICAgICAtPiBtbWFwX2Fzc2VydF93cml0ZV9sb2NrZWQoKQ0KDQoNCkkndmUgYmVl
biB0cnlpbmcgdG8gZm9sbG93IGhvdyB0aGUgbW0gd3JpdGUgbG9jayBpcyBkcm9wcGVkIGluIHRo
ZSBhYm92ZSBjYWxsDQpjaGFpbiBvciBub3QgdGFrZW4gYXQgYWxsLiBCdXQgSSBjb3VsZG4ndCBt
YWtlIG11Y2ggc2Vuc2Ugb2YgaXQuLi4NCkFueSBpZGVhcyBvZiB3aGF0IGNvdWxkIGhhdmUgZ29u
ZSB3cm9uZyBoZXJlPw0KDQpUaGFua3MsDQpEcmFnb3MNCg==
