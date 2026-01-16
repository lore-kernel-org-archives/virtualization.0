Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDD2040B6
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588901; cv=fail; b=eiN+LOv2VC+tT5VRHJR3QvhHoIbDc+375xwo8r5Xy12bYZa0W1vHBl6DmCdzbzIPSDWFuTFXBfRCg1c0VDvPv3WPSLbAypjOiYYJc5Em06rzyjff2OQWlCsW6L5tOYSdfLQhb0VIyHfQDkFouKtFg4/EcEgqTmgRHnkG0MBKlUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588901; c=relaxed/simple;
	bh=AbjOr1d60qrGX2hne0mnGHDsIUilYuorwdfWyK4m3kU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2hpJ+UZI6adUHyIakLRlDBDIKTVbYTxsitSZifVG5GpCHacqk7uH6kcZwvKPxnY12iOzEc9nf2vf8xPR9JXq0gnAoBBYhToP5gEcL+1qkqU1r13OGEhpb7NIuemcck6icCzhoAO2vWfjFnMCg4yxXo6U+v3y6IO4EuqnJ5/Um8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WDkSHGOe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gvVD/OnV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WDkSHGOe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvVD/OnV"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GEDUom1910018;
	Fri, 16 Jan 2026 18:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KEdQxOSfW8L+F05eucE9UifTUiA0HsZlJLRU7EfwAOA=; b=
	WDkSHGOemzLmmq54sRhcv2EnvCfnSRLH+E5OIuEjDTZjt60I5UT6TYOdzQD/hFoS
	PWZCibdn3AwlCQmBVLIh/Z6jebYiIqcwMYs0/fGn/PkcC2eXe00Vam5iPNiKcH9q
	zjywGzQM4dvnKJREMAIPKB12aggjQTs9TuxMRUWtVoeAaf1XxWLTvvOEqW7GkFSt
	LxZKAQKyzxiH/HRH7++p3WCLnmdDGbIXTYecxXw45xuRBgRkgz7z9d1a3Zfnmr45
	5Qe+qoyrPCMlifjHymQjnNkEDhpEht4QEPR9HvPqFx27bTt/iSZZPwGPFDVRIi2t
	TUJMFHtsDhDJBbvmvyz7Kg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkh7ntk19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 18:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GGsGps008138;
	Fri, 16 Jan 2026 18:41:27 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7d0255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 18:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3xvfWEv70K3EsoiZhQHsTrxKEcaRn5qm1VG8TWESiQWjAe1d9QqpXOc39+Vb2HcLgbJgu9QwDgPxFTou8od8ckHAdESa1+r785MMmWlqMfEINEJACfu+Yb42jlbMoPO2HdycBrG5anG7BzhISjmjrA5RONG2xxQp0iKO16FcXRcCJDuyqPvSPk+r0VNgjlTqw5msI+nqylMu6ueZ/mZu840BHsQPtI3ZKtNB1azpmpBLk+6mg0BlPnREQ4cENOWPvavKVtpDpFanLd59omCWxCYTAVM4ka6zkB6nxTBWP8ymnJaxFfrN1unpyvIWPTelA4JZPIZ3qG9t3c+8nkk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEdQxOSfW8L+F05eucE9UifTUiA0HsZlJLRU7EfwAOA=;
 b=WUaAukw+7r4uQ+DZGQmtkEHlnma+5h2iWcONul84vVvGZGO/lV2FBU7sWqEtubdDNyJYPE6Mu1Gf9evSaMDdYSEhvdqBSxwBpX8ugnf4HtGnovhFtPzgRA1DLJyJafihSwxLyT5XOAcY4883mLfzRC8nUJGBT4tO43OcI/I9XkliPXGjWBNLziOP0YFuQwZr3zhqv/xZ3WDjk36HsHi70zGNYgfLq6IGq9GmAkIhG9ikUQvJTCBYCMRmcPCymc8VoJJ0nTwO9zHKZXcp4APb0XFBkKm2v4mbn2gThnqb1JLShHcPiZkHnZyMM2+wcdl1rqpv5RnsiKPOWdRhERmfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEdQxOSfW8L+F05eucE9UifTUiA0HsZlJLRU7EfwAOA=;
 b=gvVD/OnVhm5R/Rd9LdxAVgGVZBPhZlNFZG6GbUXM6MHTz13rX3RHMz9XLFHqsunuAV0421Wt/rsub2bQmRXa79Wz/kkZ85DdoQ3QEd8dwIhdtYgSh4x5B5o4cTdxcStOefYSo14HdkoyjWW8VwOw4Ft83Yp6hobgyrHMpuuzk3M=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 18:41:24 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:41:24 +0000
Message-ID: <85d3c2e7-3608-4a60-b088-912877ef2e65@oracle.com>
Date: Sat, 17 Jan 2026 00:11:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/13] Documentation: Add documentation for VDUSE
 Address Space IDs
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>,
        virtualization@lists.linux.dev, Yongji Xie <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <20260116140455.1560491-1-eperezma@redhat.com>
 <20260116140455.1560491-14-eperezma@redhat.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260116140455.1560491-14-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bae4af3-2a4f-4a60-d8b6-08de552ed961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnMwUUt0QVFHNldacmhEMzJadVVIUk5ibGlWMXpUR0wvS2RpWHZlb3JOT3hk?=
 =?utf-8?B?RjdBYkVTb0t5emtkclNpM1M3L0laV3ZpOCtuWFJzSzZCWU1TNWNMQTJPUFF6?=
 =?utf-8?B?V2QweGJrUkZ2VkR2N1NRUWQzRWF5WjJDYlkxRTVNcGRFK1JrbTdwQWJWRU5G?=
 =?utf-8?B?Z0hPdTRtT2xLcm5xNElGTHI0ZGVjVjYrUzNVMjRXRXIyMzE0ckNxdXNydnFS?=
 =?utf-8?B?TFhCVGpYNDF5SC92TjFOQUxmSVUyakdvbzRiVzhqY1cyWk90K0x6d2N5UjZY?=
 =?utf-8?B?L2lDSXhpZDhRL2hYWGNuL2ZpcEpLZENJNHZlOGhYWS8vL1J4Q3JPWis0N1BR?=
 =?utf-8?B?SDVHdTF6VFVwOFZGQkxtTXpnVnJVMzlIS1poTGhwekI1bExUdzlqVExSMUdB?=
 =?utf-8?B?RmhBUnpsMW9aOU5CRmwwb2s5bGtqdCtHREZ0UEdlaUVMQzlnZDBFQ083M0Ux?=
 =?utf-8?B?NmZNeElBQzBEaGRQaTRaMWxiZ0tiWDFoT0cwMXdLdEZjaGpzSEM5bGI4Mm8z?=
 =?utf-8?B?ZCsrblhobXR4aHovVDVJL1FSUy9VVnZ0TStIYUpGeVprRDQ3SlVnYWVKR1ds?=
 =?utf-8?B?WEE2bEwzcXRLdUY1M1djUnNGQUNoZzcvelg3UHVLcVFhcHhJNzVtVkZyN2tL?=
 =?utf-8?B?anVwNFNCdjFvNzAzZVFUbDVNVWNseEFZRHovdmNTaU43b20vbkp6dnZPYk9n?=
 =?utf-8?B?TThJNTByeWwxUXJGRjF2TkEyVkJHTE80My9GSFVMbW01TWp5SHU3bWZPTEJE?=
 =?utf-8?B?eWVuakxJM0prc3IzZUMzVDNMMGRyUllhcDN6V3RNZnpoSC9velJPdHJxeVVS?=
 =?utf-8?B?dnFPcFpnZkxXL1pWZ2dYdlBpYU83YS9Sdi9VL2Qwd3B3SXFxeHQyRmE3eXlS?=
 =?utf-8?B?bWtEWTRDWEMvdkgwZ0pQNmc0SjFIWGgrNXFhVVQ5em9tTGpvblBZT1JtMTBW?=
 =?utf-8?B?VDFRcGo0K2plL0doekh3MkhnRCtkMXd2TkdXMVpLMUcyQldHMlRXQjA1SFVT?=
 =?utf-8?B?dnZoNVcyWHdhaFVrWEpvT0Z2eHgwRU9xclN5QVU5REd0QWdGZ1V6c0tjMzhD?=
 =?utf-8?B?SUVqZldUdW11bjU2OTRCVHM0VFNEZ3Y1OW9MdURBb1JNb1oxK2FWYnd1Z0JZ?=
 =?utf-8?B?M0NGT3hlajNTSzFlckZRTVdxMlg3Y2dtTkorSzZTZXBFOEQxNytnYmlGTEph?=
 =?utf-8?B?aEh1VEt6K1dJQ3B5R2g5N3M5SjVOM3Q3YnhjNUhiZEJZSzd3QTV5UWhoRlhR?=
 =?utf-8?B?V0ZIV0JzVDdNTHVSZ0N3WDdlRGdoaTlJaWRxVStnTUQyS3VZSzZ2Tm1QMGMx?=
 =?utf-8?B?TlNoMUhZOWlLbFk2VThGYzJQWm9tMlNOMldiZkErOHYveVBoZGh4bExCdVJB?=
 =?utf-8?B?eUlnWnduTUw4SC9odk9jTVVpYnh1WVNmbk9LQkpEZk0zejhkdksvQUhVTXp1?=
 =?utf-8?B?QkNpVVBUTEZsQVMwR0FrSkNYcE5XRjFYZ1JNa2NDbU9Ba0tsT012N1ZFVWVx?=
 =?utf-8?B?ZjcxVGVOZ2VGUzlZYytsRUp1NlZjZmlzS2NuaERSUUlkTWRjM3VsV2t3WGU0?=
 =?utf-8?B?cDdnSU12S3MxOU9lZGZlN3ZwM2VoaUtHSldFRzhGMEJwU05uU3lJR2JacmN3?=
 =?utf-8?B?Z2JKbythcWp6a0w3VEtpUXNxMnIxcHVmRnprOWJUSXN3SVoyZUlZVy9NNFd1?=
 =?utf-8?B?ZzRHUjVuazZsUjJTOCt5QlBVdUFFRjFjNGN2UFZXL0VqNlRMaGdsajNwMXJv?=
 =?utf-8?B?NEdpaEhrR0ZQdjM1eVAwaEFYbmlzdjFzTzBOUk5GVjFocHRFK2lzbC9NQ2Z0?=
 =?utf-8?B?MERZYjNrUFlNRmJlT254SEhBNFR6ZVJiUkRhMlpFWDRUMzQzNHIxcUdqTmdu?=
 =?utf-8?B?azhmMjVaeTBKZ2lERGNza0NHS0pTZDFQREdlaWc2ZnFMV3VPRERwaTRqbWtt?=
 =?utf-8?B?ZGJUak9rdVpKZW5Nc0FqNStvS296NG9UUU5FSzNWUU15MU5Lb0ZQNHA1RGsx?=
 =?utf-8?B?eW1PVHdkcmcrWGg2aldSbzlqaGk0YU96cmNkTG1NamtRNzd0Sm10VFZDZEsy?=
 =?utf-8?B?WXArNjR2ci9jdmxwaEZ5OUx1aVl1L1E5ZnAzdzhBa29Uckw4alJhV0Zua1dt?=
 =?utf-8?Q?00+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFJWMlJVOTBwamJva3FqSGdlWHF1cjN6N2kzZnd2aGlJZFNVenFJYm1TUDlu?=
 =?utf-8?B?REZiT1F6ZVFlaFNQVDJiU0NVTFk1U3ZJWFNNNUFYbkVnY2xpR3BaNWUxKzVh?=
 =?utf-8?B?OEhhVzZYL0t0eVFqMHJiVzBEU1g1TjA1SWJhNHloNlJqZG43YUlXOWc0dUdN?=
 =?utf-8?B?OWk4WlU2bnh6eFdEY2dTdDJDamZHSmhyYkJOaHRrOHo5OW4xbjc2anIyN2FO?=
 =?utf-8?B?K3g4Z3BucUtZamdoOTN1VUMzdktJNXBUSjVoL2ZsT2ZjYWxNdTcrZ1BkcU9G?=
 =?utf-8?B?aEVFalJ5WThOQkRVNTlzcGl6WW1DMjFUM2FFYUNpZ1JPYllYTi9lMUxQWVdm?=
 =?utf-8?B?VXBQTkR2NlpyQlhqNEtQNW1vRWsyb0pzb3ZyeVA0di9RM1hpSEZnVzhhUFNx?=
 =?utf-8?B?eTh5Tmw3bnkwdDJZejA4dEJrRG04TmxWZnNZWTFTbVpraFdCS3gvdnhEaXBS?=
 =?utf-8?B?Mk9GQ29VbnN1RVBQWXF4TitEdkNsVGZGa1JyL2NvdFFsbGZZVUpNWHFZS2w3?=
 =?utf-8?B?am1nMEp6cmt0VG5lcGdyUTFvSzdDRXhFWUg5SnRPcWQrdFBSOVF6Y1BDdnlH?=
 =?utf-8?B?QnIrMDFNZGZVU245cVUzSnNhVUsyRDJ4Qkp1L3d6UWgvb0k5dS9WVUxxVEo5?=
 =?utf-8?B?QUt2ckM2bk9Da0kwNDZYQVliM1h4SENCQU53UnU5WDRoanhXSDlIekpKMTVv?=
 =?utf-8?B?dkNZZUZTdTFlcXRyd0hxRFhGbnc3UXZRRXA0eXRyY3duaGFpaURWdHJSZU1V?=
 =?utf-8?B?QkEvSjBmKzI0WlJKajdTbEoxeWdGU0pONVQwTEUrRnR4MGt3RE5nMzJ1VURU?=
 =?utf-8?B?OGNkRHI3VDUrZGZ6QVZZVWtqUjgrVGdVZ0pxa3hNRWE0dFJUSlFSMDA0WDB5?=
 =?utf-8?B?d3g5SmE3M01MeUwrSDFBeWdxWGR3THMwV0xSdjNJZHZmOUxCelhoMzRoZ3Ir?=
 =?utf-8?B?d1ZRR0ljTnc5aXBKWWovdHFnM0p6REkwaGFJdGFtWndIcXNUcjMwWFRoNmdl?=
 =?utf-8?B?ZEhvbzUyMXJjQjVnN2FkZ1E5aHprZnZZSHcrcmxMU2l3Uk1xMTdUdE1xdzN0?=
 =?utf-8?B?d1htbG9yN1VDdy9QVUgyTTdxRkxQamwxakJrMjRMTDZRVnRabS9kRXBDU08x?=
 =?utf-8?B?dXpPa2RiYS8wVkdQdW9KaUlXRFoyZ0d3Mk84MGxBVWlScDJ3Mmx5NnRNTko2?=
 =?utf-8?B?dTE1cThsK1phLzV0M3hJamZVNk5YWk41WVBGR2k3QTBzVWFVNmlwVWFoU3lk?=
 =?utf-8?B?QUxaT3RxV2NoT0hyQzlVTkdpRTFXTit3RFRwU3NtMTBMOHFJRkZheTJVd1k2?=
 =?utf-8?B?a0lUN2hPVzNFdjVjTGxNNTVkWWlra3NzQ1ZUU2lUMm03a0Exc29DWFFXWGhH?=
 =?utf-8?B?QmpIWGpSQVpIRUlOL2JleEtEUjN4MEVyVURkV0hMYXZzeWlnWVJEaDE5Qm41?=
 =?utf-8?B?QVBycGc5Um9xVVpscnYzVXZVMnQ1bVNIMnVhWXZDcW9UbkpqbkRqSVJxQTRN?=
 =?utf-8?B?ZFlJejR6TVVEWDlMSzhQZkxJSXVPZGZ2QTJzcmFKTUxPVlpBNFdHVkRnMm05?=
 =?utf-8?B?VkJMY2VsbVM3VFlhWG8vaHl3YnJLMjVkWU95eWhudjZQNCtZWEprczh6VCtS?=
 =?utf-8?B?WFZra0t3MFc1QkJ2c1R0OUozT0FjeVFCQ3gzdFJkVldCUVZoRklQdXVaTTBu?=
 =?utf-8?B?QmFkUW96aUtZcy9IVXAxalZVZkUzVFdQN082WDNmRXBZN2ZsdmxNQnpZcXhD?=
 =?utf-8?B?UGlVK1J6NFlpbzRXaWZScUVOTEgzdi9JZzJtMUZiUVROZGpuNnJic3E4Z2FN?=
 =?utf-8?B?RG9HY05DQ3dSRnBqLzFKd2pPangwYk80dlNrRDdORGxEb1hScXZuTGFIWTYy?=
 =?utf-8?B?M0V1cnlRNmZISTBlbCtlYm9PL3p6d29XMExrd081WmxtakluejNOYkg5bGlR?=
 =?utf-8?B?TlB6SG16bUZGRjRJUkRmRnBOV1l6aGFHUHRaNm04bTFsOFVmbEV3ejNrbzVS?=
 =?utf-8?B?Sk83L3ozRDBxODk4M2lXUzhtd3RNeWF1RTVieEtZUi9nUFg5ZWtlN2tTQlJ1?=
 =?utf-8?B?OWRKODBHTThISGJjem5EaWRFN21ibHY2blR1VEltSHhid0M1Qld0aFdQZUZu?=
 =?utf-8?B?WW13VmVGb3IwaFN1RzF2aVV5VitGVExvVlRqRDdPb3JSNW9SVmZ3NTJCeCtL?=
 =?utf-8?B?Z2NLNmxkcEdFdDhyYU8wRWtnMWZtV0hHUjNlSDMxaENGYlJ5WDdXT0JCdndJ?=
 =?utf-8?B?YXF5eis4eVQyWEpjdCtMQVMwK01xdlcvT3kxTk5TNFp6VW5tK2JMSXZwd0tR?=
 =?utf-8?B?SXQ1cFZnQWNEQ2hjMDI5VE4wUnFSMjhiZS9qVXBCZVBBYm5sS3lja2VGanZo?=
 =?utf-8?Q?1mW/g33AJcDndxRg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q9h3tR7pWExAt0HFtn+q1xJbr0DVEWvWNNO7RSjDtPGSWsKwhZPWWKd2s/+YDMsAEfhflB/MBuoa6JFvHWm52vlS6ymHtCA8Q0CceFw9qqsIA7V5svttFu1pddDl80QWzphTxJJFxAj8klSrTwDuMQGuGKY22nnfqbiutcFp3k89gqk2QdzAL9p5/F2L77z1oh24xlyx3f5RVJ92MFhYbeq3s2UDhmQMyoBLiNimZGEU2pnfwxd7wA11+OOVOk47A8dpArbPhKqk3o1LSG/hI3Eqm8SX1s/88gv0uugP6ZaOJEeJ8M1K6qhhHVUXFSUhzCNYMJJiO5PcdnJa7f/o1ZlzpBF3yMW2xj9OUJc5QbDqQkiFqkjDmmHydA0KJb5Mjsjz+TRL4ta4OJ6EDB04JvpgYrdtc1m92+k15KexODGfTytx+PusTPCREI54D6p3FsI67ts4/OZUDx0BevMDV5VMTG/YSwWeGJd2gwa60lknXrvzdEUzU+RDFzSZiwG5k0oFTf2nrPeB5PzaAOatXr2D5CdXYMRUfNDBRW+cOZoXU3nzzuGD9NI4kRhlZc5zO5WCn1ldt0RumehC/+BMz2ScR2fjFK1Tdki17rWBtlc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bae4af3-2a4f-4a60-d8b6-08de552ed961
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:41:23.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcJVNpnNdvZ8XK7AwCI8RgFTTCwMQSUzC3go1KahOsfCJdqk6y5Suj9ZuScexm95VPpbsiDgpYO5/TBulrEukOOJprOeyYWApv4KDfOPUeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160138
X-Proofpoint-GUID: G1e9NTcjpRNby_quKmmy7afwwQUFfi17
X-Authority-Analysis: v=2.4 cv=X7Bf6WTe c=1 sm=1 tr=0 ts=696a8658 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=56RJl6BGkv0ZYzQ-WK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzOCBTYWx0ZWRfX7rzbVYaCl0rf
 gsGdBF0wJS+vK/LK9wrpxJeZnXyeIEUQkV/vJMOwhVGxck/JxAVa4NJxhWJgNGbX+MPWM1RUtQe
 rItO4Fv3XM/hPktPBrgFv5/83gorP2aoR91zqa2ZgKuZI6L0QASiuKXOUt17z0pTb5MQBgWNEUL
 DIi81ckli6ohgO7UDC8oFoUGBWRqja/qmwQeCtsp4REPrCwWAuXHMJXDhacqV9T0UJyFEV9Kd65
 or/ubSphsvg6LXLtWC3T5GtaA7GePnEtao+ZG8Rfoelspe8tT+HLwfgHZ6/LaMz1ARkJCAAql75
 vDgCWktCzuqXjRegr+BXWbC2z2i7v4HwfnRez0+UqXXdkqB/Syf+/Zz66snEPQiW2pjELFedkby
 KYNd1OpJRtDnx63bFgxr/R3n/nwa3dkUTddC0M2I6BvvDzfuotCxcs+EbDmG4DIMfAXBA4rN7Ny
 PLx4yWW3I0SdgRm6hsg==
X-Proofpoint-ORIG-GUID: G1e9NTcjpRNby_quKmmy7afwwQUFfi17



On 1/16/2026 7:34 PM, Eugenio Pérez wrote:
> Address Space IDs allows the VDUSE framework to support devices able to
> expose different virtqueues to different part of the drivers.  For
> example, to let QEMU handle the net device control virtqueue, so QEMU
> always knows the state of the device like mac address or number of
> queues enabled, while leaving the dataplane passthrough to the guest
> intact.  This enables live migration.
> 
> Expands the VDUSE documentation to explain how to use the new ioctls or
> the new struct members of old ioctls.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
> v13:
> * Fix s/VDUSE_IOTLB_GET_INFO/VDUSE_VQ_SETUP/.
> * Document VDUSE_SET_VQ_GROUP_ASID VDUSE message (Jason).
> * Fix typos (MST and Jason).
> 
> v12: New in V12. Requested by Jason.
> ---
>   Documentation/userspace-api/vduse.rst | 53 +++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> index bdb880e01132..aa067da92cf5 100644
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -230,4 +230,57 @@ able to start the dataplane processing as follows:
>   5. Inject an interrupt for specific virtqueue with the VDUSE_INJECT_VQ_IRQ ioctl
>      after the used ring is filled.
>   
> +Enabling ASID (API version 1)
> +------------------------------
> +
> +VDUSE supports per-address-space identifiers (ASIDs) starting with API
> +version 1. Set it up with ioctl(VDUSE_SET_API_VERSION) on `/dev/vduse/control`
> +and pass `VDUSE_API_VERSION_1` before creating a new VDUSE instance with
> +ioctl(VDUSE_CREATE_DEV).
> +
> +Afterwards, you can use the member asid of ioctl(VDUSE_VQ_SETUP) argument to
> +select the address space of the IOTLB you are querying.  The driver could
> +change the address space of any virtqueue group by using the
> +VDUSE_SET_VQ_GROUP_ASID VDUSE message type, and the VDUSE instance needs to
> +reply with VDUSE_REQ_RESULT_OK if it was possible to change it.
> +
> +Similarly, you can use ioctl(VDUSE_IOTLB_GET_FD2) to obtain the file descriptor
> +describing an IOVA region of a specific ASID. Example usage:
> +
> +.. code-block:: c
> +
> +	static void *iova_to_va(int dev_fd, uint32_t asid, uint64_t iova,
> +	                        uint64_t *len)
> +	{
> +		int fd;
> +		void *addr;
> +		size_t size;
> +		struct vduse_iotlb_entry_v2 entry = { 0 };
> +
> +		entry.v1.start = iova;
> +		entry.v1.last = iova;
> +		entry.asid = asid;
> +
> +		fd = ioctl(dev_fd, VDUSE_IOTLB_GET_FD2, &entry);
> +		if (fd < 0)
> +			return NULL;
> +
> +		size = entry.v1.last - entry.v1.start + 1;
> +		*len = entry.v1.last - iova + 1;
> +		addr = mmap(0, size, perm_to_prot(entry.v1.perm), MAP_SHARED,
> +			    fd, entry.v1.offset);
> +		close(fd);
> +		if (addr == MAP_FAILED)
> +			return NULL;
> +
> +		/*
> +		 * Using some data structures such as linked list to store
> +		 * the iotlb mapping. The munmap(2) should be called for the
> +		 * cached mapping when the corresponding VDUSE_UPDATE_IOTLB
> +		 * message is received or the device is reset.
> +		 */
> +
> +		return addr + iova - entry.start;

typo entry.start; -> entry.v1.start;

> +	}
> +
>   For more details on the uAPI, please see include/uapi/linux/vduse.h.


Thanks,
Alok
