Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43021F9EC
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721057927; cv=fail; b=DQcabxdUI2FTh2ta4NpvhiMwqg/YPeN6uSQ2i6/rp6U2/Dnqq6hQv4vCfMJ5g3OTmoWJG7+RQ0VyI/23flE3m2HvmzNRcnljauEBrfri6c8evwK2ozrVeZoGn/NQ4PJAWQNehGsdunLmVvtsA1+p9jMsLyThAefjX12VhKDqi4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721057927; c=relaxed/simple;
	bh=NujqL1KUbwWqnchtNZHw3qDgDvcPORSfUfhCmkiWZi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYb1r7+W7XHGviNL3Q3XcEFCOfXEwx1KwZFQLVq3mmeoJZR/HhIJgLfaDoF9ts67pxc1kogvPbaWh50vr6ufPB/5M6ex11d/TFynYzIV7kobru4Gs/S5qIn7q/jT/pVNxa07OehawB8oItWwqdlWigSV+14sY6r/vJjftwXLpCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XXlukoHM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mGqe+iz3; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XXlukoHM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mGqe+iz3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAA2C605B0
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 15:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kXl8ceFlg9vy for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 15:38:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1248760008
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1248760008
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=XXlukoHM;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=mGqe+iz3
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1248760008
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 15:38:42 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENaKG005743;
	Mon, 15 Jul 2024 15:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=P8aAOqDlG36m4Q6L1XxsVvPsJXLaS5GQ7yXtPBcj99E=; b=
	XXlukoHMCnJjP7JvSTwGpuUzbPXXWWdsBGq6OCmhybcclN1ddFMcCb7+1GEt2h3b
	WV3OQ1+vrGQvF0YDqV6eaJtpz4qeI/kj+uRcycPXR/Xtd/zsJbaSjVYQbiQxcOXp
	BvY2XaYOeVuGuTstfHx97sZSmnHoq62Id5HOmn4sifTDp8p1SzhEAJj0rQcI1gPz
	SakkTqKyhkel8JOHCoFh9n2AlarICnoReQy6mjEe3C7EHt+gOPyKtHVyC8PGUVjK
	cj+4A9sEKjXRlmvM3pS8BNwPulUqKYlTEA3cUF10yP5FDpudrE4YqNXfh/vXulgZ
	Sd3ji2gpgWsB543ByVEhwA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bgc2bt6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:38:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FEfx0j039212;
	Mon, 15 Jul 2024 15:38:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17yrhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 15:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iceAqZUOHGKpGAGu4Eg27dnFvyMRId/fPgKI90Dtr7k8yQNsn23QezDrPcCKI0+85qs+da3cG0IO93Hj4sgM1TRKxypIUhFPWg3wHj4fq+xLUaHhxrZLoMH1JMsehYLjCA4ZyXCEXVVhhJuDUzkwAJj/hvMVV8umV2USnRoIN9zEPW28KAmFiC3rnHyN7JRG59AjU/K7aOGMIWIn8yYECdNlnMWJTJndNu+tjyc2M8E8tfvLKfkNUPJAFsZZoKBcp/UcApEeYxL5o/PZ+eTMU1xiyCkgot++KhBRSY/pd0kVb4eBR91bm6yLy18Z69TmmA5jqzKh3014nEJrGlQ5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8aAOqDlG36m4Q6L1XxsVvPsJXLaS5GQ7yXtPBcj99E=;
 b=lJ6in6GSFrEyIEv+59z/EEKCW+sDIf3VFE7Lo9LMVchRtKZCRnj2/Aqd45XezwhLNxPLu1Hykobhoh9qnnWP8H75iAAarynFffpdJgcsyN3vtM4kghMbSXJFTI4UNi8weWqb6bn+J4LGJeAQKZoaIp+K40rUI96nKbwpE/Ce7WEC1Ya2GFObR8sJMU9YuOBEd3gminE0X9hWTpXo+Up2KNPCZ1Wrz7aQjiJ9Z/MT8nVtT/5WHx+q652vlqe857WgPSwOXG++TEvaLKku7oQr03nthSEmHmWOn/SNaLjvqR6yO8IYwGalQSRk2kIXxsbdv+8aYTNIYcHKz4VDjOt8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8aAOqDlG36m4Q6L1XxsVvPsJXLaS5GQ7yXtPBcj99E=;
 b=mGqe+iz3AEktyh1sffDJOlLweDeSIQ25YS509ZicankIO5JuS95rqX69EpFShiqxzT2BKHWw054b37fg1znwYW5KnzZJwapxh+Sxm4nUXYQAx6KXL3KAuRfgZVkhAmdcuq24cnGnTExYEscLZeEv4czEc9yVfxTSVMLT6kZvwDk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 15:38:33 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 15:38:33 +0000
Message-ID: <9686e6ff-70fb-46a2-9828-720379b350fb@oracle.com>
Date: Mon, 15 Jul 2024 11:38:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <20240715050637-mutt-send-email-mst@kernel.org>
 <d414f28e-8887-418f-963a-bb986dbdcaea@oracle.com>
 <20240715103021-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240715103021-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 677e8107-aed3-4d90-6a5d-08dca4e42f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RDg2RWpVbC9EUUhqV3dySi9kNHJxUUpRNlJQYktNRW1RbXhLbXhBQ2xTaEpq?=
 =?utf-8?B?dTBoMHl6Y3Nib3ZNZktSVThKNWVVWGNmTEh1QXFFM21kYk4vaDZsd1R6b0s2?=
 =?utf-8?B?UXZNZ2lERGtZV3dEY2plREpQS3VpUGRGWGpzTEFSSGZ5TnFUZzEwVEF0cmZG?=
 =?utf-8?B?Z3gvdUJFSE5iNWd4RlJBR0U0T1JNejdUUVh3QzZkc3NuQTkxbnkwQW9YSEI4?=
 =?utf-8?B?UkhTaXBCa1B5eU5Od3cvSXk2K1VhOXpMY1M1RDM3ZWMxVW8yM3ArZW1MKzBY?=
 =?utf-8?B?RDVKZG52WmJzOFRVUGdIMkxKNWtUd0VPSWxERTZaTFNMRkNOanlZeGJZTjlS?=
 =?utf-8?B?U2RvWlVyM3E4Zkdlc3Y2R0hrYWMwN3lHdXgzQnJJK0NxWFBNR1UrWHRKUlVy?=
 =?utf-8?B?SXBZTTRrZGNGNFZOOVVtSTVIMGMrSWVCOHNrRTVGbHpWeWwzSTVpdjRFejFr?=
 =?utf-8?B?bUtGT0FhZGkvSFRYcUo3SDc5a3JiN1R6bU4yS2Vvalp4TU94azM0UDBOZ3ZW?=
 =?utf-8?B?SFF0cGVmZE5DWHgxNHBYOUFLY1ZqUTdia2pSeHlZamhETlpGOGdHOUFBV2Vs?=
 =?utf-8?B?MnU0MWRLdHJOcGg2aVJ3Zzg4TVFMY3puVGxROWEwWk5xY0pUeU9zekhzTFpo?=
 =?utf-8?B?akZUZTV4Q0pNa1E0cC9XMzBlV1c3Q3NJbWNpVXEwaDE4Sm9nZVR6OUdMVVpW?=
 =?utf-8?B?amRmeWJHa0ZLMmhCQ3lZNm9NakxWR2lZV0Zoc1owNHhTQ1kvTlNaL0MwWStR?=
 =?utf-8?B?dlJFNlhvTTg1NTdvWFRaR2M4cDBNYURiRVc3ZFluMUQrZGEzWEo3MVZ4emV0?=
 =?utf-8?B?ai9ia0FNZWQyQ3JlRjZ0Tk1JWjBXck00Ym5mcjZSNEMvT09YZWZxajNxVjlO?=
 =?utf-8?B?dzBCblBCNnc0TW5RbEhQM1dKL2tzVVUwWnZIZHVuTXF6YldxWEs4UWp2TGNo?=
 =?utf-8?B?SWRsWGRlSmpZTjh3M2MxWXhkQy9HaXVEUDZHOUxCbm83UE0vVWo2N09PeVl2?=
 =?utf-8?B?VlpWRUFDaUFlZWZXOTJubTA3U3ZwWHZOaGVacmF0MHBtNWR6YkF5bVNoRDUw?=
 =?utf-8?B?R2IxQW1tNWNkMFJqSjExQ2JaTXRtYUJmbkVTNFBoQmg4MDc5NmU3cmZBTjZM?=
 =?utf-8?B?RmlUdUx4MjBwSkkxN3ZwcVhYckx5U0Z0UGJOY0JjRzl3UUlWVUhTejErWFdh?=
 =?utf-8?B?Z29teURhRGZFRkw2a1hBVXExMERCWFRQMlkwOWVIUm1rRGs2bGZiRnl1Sk1V?=
 =?utf-8?B?Nm5BSGI4MXV0OXpQTTFmUEVISzhGOWdHUFFkbFIrTVFtM0dkRjNFWCtBdzNO?=
 =?utf-8?B?c3k4YlA3L2hvZXRCVGc2UWRUWE56amVmN1ViYkJiWkZHdmsrZHNOWStLZVZu?=
 =?utf-8?B?V0FCdHBESS94dXp5QjlCcmJvUDFwSzR4REY1Si84dHNYY2wvWExHTmxxSVZW?=
 =?utf-8?B?SVNJZ0dTUElpYWhyaHdFSGNCWmJyK2J4OHg0T2lwcFMzWENFcWFDSEtmTkNJ?=
 =?utf-8?B?V2IrUS9ZSU9TTjFOV29nRjZQR1crOWdWWnRod2xiZ2ZXVW8rNUV5WFBsaGUr?=
 =?utf-8?B?NDU1Z0hQRG8xbWl4bm5zL1NiQ0tuZTJBZnJ0R3k2MmZyNEtIaUNPaHdGY0Zk?=
 =?utf-8?B?MGJmZ25nTDMvdnN3MFN3RGhQRHVKSE5YZk92cUdYckFvVEh1cjV1WHZ5SU12?=
 =?utf-8?B?MlZTVkNXaEdyT216bU1xUkVjRm13M0YvRmpGTHdSL2gxU1VweUZjSjU0SHJv?=
 =?utf-8?B?YTlXZE1DbkoyZTMvNVZzVXovVFRqRjltd1NtUE50Y0FsaEZrM2tiYWRJRXNG?=
 =?utf-8?B?L0p6UUFTR3BpRE1VbnNEZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVF5WmtROUMvMXpUaDVlLzNzbWdUMWJISkpWSmZPQWY1SUI2aUlLZXhjOVJV?=
 =?utf-8?B?THJoWUtDWWVjeDBmK1VnSXBuWXdMMWhGN2hVSUlLL0pyTUMzZGZjV0J1NHlP?=
 =?utf-8?B?QytUK2F2THAyZHg5NXRQTmp4TFBJd3Vxa0VvakdQaDlabGkrMGp2REhFUzBF?=
 =?utf-8?B?NmJ0RkxiYWVmRzNiUDhDdmE0U3VMWVgvcjFDaWovUXM3WFBneGZsM2JMMExF?=
 =?utf-8?B?aGpXTUN6Z2Z4L1ZmTzRwZ0N5Zkhubi9yanJneXpqRVdZQnJXME5YYUYwT1pS?=
 =?utf-8?B?NmhtcEtQWFFBN2FzSUcreXlqamNQeUVBdVdWakNoMEdhUXAwYUpWTk8vLzFx?=
 =?utf-8?B?Q1p1cWlXOXJ0SXBqcCtDRE1ZVjNSdGtXc29QeURUYnFrSExSVzNPMUxJSFA5?=
 =?utf-8?B?TGdxdEJGNHZWQVFZQndNNXFVUUY1eitlaktIdDE0dG56SE1XUHRVVktjSUVU?=
 =?utf-8?B?RDFvZXFVYkFsM2R3ZXVIUUJZa0FQaDBtN1lTd1lTWi9tdDdnQStHNUxGNVYx?=
 =?utf-8?B?TlFGZnhUb1luOTk2d0xkSFEzQUMxakl4SExHWi9vUUtlMDgxeHkxWTk2c0da?=
 =?utf-8?B?ZER4NE4wSW16Znp6ODNGK1FvdllydTY1WlFRV0hPYlY1ejBjMlRtMjRHSUJ2?=
 =?utf-8?B?a2gyQTBIRE5XV1VRNTFLZERwcGd2dCs5NGJwRHZ3NUpaYktRZ0xXVy9BNU5C?=
 =?utf-8?B?QjZvcUhDaU9LUTREM3ozUW8wRkluT2RyK1FJRnNjRUZDSGxmdXNJcmZDQWd3?=
 =?utf-8?B?cFNzNll6N1BsT2M3OGdid2JLMDRRNXE3OXVVWGRLWmxPTFNMcGIwY1hXdm5t?=
 =?utf-8?B?SCt5UmwwUTlPSElYUC9SUXRIMUk2MStBeGVnSU1QdkNzZ2NjMDdFeDlwZXFs?=
 =?utf-8?B?Rjg5eFVFZXA4SG11b3ZYWUdTWmtwb0tOSWRDOUVHT284QUtYNlZNeUxNam8v?=
 =?utf-8?B?U0dPbTF6MldQZlBzTDk0My92Y3NlckNnS1I0TGUxU2htTTh3TDlNRXE5NzhU?=
 =?utf-8?B?eDgwMlBKenpPL0FRbFZFTlM4TktwY0h4SXJuMHhUbFhHdCttTXlhMmk2TjZJ?=
 =?utf-8?B?NW8yQ3hNcUk4Q0hpS08xUnpjbUJZd1FJdGdzZnZqS3lPTWZNZXRCd3ZPUGpo?=
 =?utf-8?B?YXpHbndxWW5zcGd3Z0pQZlZ5OVJYeGNvZWF5cnJmVW5PdXlBcVRZK3VnSkZQ?=
 =?utf-8?B?eXFvYlFxZi9PaWRyNlEvL0xRMHZMbGZlazZNajd2LyszTUgwR3ZDWjFCcEg3?=
 =?utf-8?B?R1BGUENweHhOV1VaNlBaaFdlVjFBZjlOR1NTT21HTkdacjJCbEZiNTBkQ3Bq?=
 =?utf-8?B?NG9ObjM2ajlzOTlqZ0RzclVjWVQ2K2dkdzJkYWRwNXhUSFFQbkpDeEpZSzFp?=
 =?utf-8?B?TVNXV1lJYStwVlRlNTBnMjNoQUFwbCtHRG9oNko5b0FUWFRaSWliUXUxVnFP?=
 =?utf-8?B?UWs5NnRmRGNKVURqQlVqWis2SzBzWGp0cHErTjlORi9HaEh1T2IvdkRZSndP?=
 =?utf-8?B?VzZZY1NPbzhUMy9GZkNPRDlnTDJQQi9LNnJFS1RTYVdzUE5pclErMVljTWh0?=
 =?utf-8?B?T08yZW5vSkxTVFJ1TWFjNEpYR2FGSjdldWRxcVo3RUhLNXI5RnMzTFJQTmZE?=
 =?utf-8?B?ZG1wQUxHK2VSd1o0RC9HZzNqWmxjcFkxeXMxaGpQZm1TejVvdnlqbVBHUVBj?=
 =?utf-8?B?aEZ0NXAzSVJXZUZxNGpqeWRuaHBjaG4rZFk1dTRpMWRZb0F5dVFXVlFRL3hC?=
 =?utf-8?B?bUJ0M0dobXVpVW4wOGNpSGtLQ3VYOEFaaEhSNDhCdDZFdE1zcE1mTXdiYURr?=
 =?utf-8?B?TmYwc1FYekh4bkgwOTVzMjBIeHJxUFlNc0FYcW5RNmEweStaMjJoYlgzMnNC?=
 =?utf-8?B?Yk9DbHhHSXM1NEgwTFlNMjRueC8wdWVqTk91YkV2WUJtRzZQSlB0UVNKQVBr?=
 =?utf-8?B?WjBYd0lOSU9CYWVPc3BxSzdtTDBGQThMUDNDUHpFb2JoTTVWUDNTaXkreVlD?=
 =?utf-8?B?bG0wNVppNUp6R2ZuQjNKbnM0bVB6NTJwcngrNzMyaG1xQzYwNzFGVGx0UFFt?=
 =?utf-8?B?SXYzTm9GMFhpWlZ3dEJaSmV0b0VOZGlWMHNVRk5nN0kvY2lCM3oyb1c4OVZo?=
 =?utf-8?B?WXNZVEhJSzBzbzVQbUZtMmY0UjNadEFRRTVVcTRHMm1BdGVrRFhjZlFSN29Q?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HsZO3eu4vEWDsXZi9buoFcoP3/Jo0l5TxNCmtZpz4XWVDHuYQ0pF3JfT12nWcYK15DLyv5jFmpau8ieQlpw9SdfRYPVRfTZ+y7sgGOx4hA9AgRvjIVUdhvMK3dNckeOqzcm9viISB/Uj/HcWdntTT6R4rsXzaPHts5wEKo0ahVFe9t2IwuNEMw3Rm9uwL+C9JTck0DT9lGcwlEophiBfMSyCUAmTV4jUBnV5QpPScXxUpq6Y/VPyWnmq2GUjOn7Oa7SAJ6jkBZV5Yyxx7LYlf7ypNet5Rg0cP+3CQOVGo55ZFWnze9rGkUZgFL+PjBRY1lwoT/kCvZtLIhNJePV5gBL3jwvlSE5MVSpsmuQ42rarhe76dtCFPeRl2gPlTlxL+mtlHZB/49nM1727X2+z9ef3SSbyaM5RUd2oagY4Nv0eO16bupu3fU6HeoD5sNW37dor7eI77+tRRV6uA2LFR3VGT1BpC08eQxwNWT/vqhYoegf0U3pprwA7rWHjRLqgS2flhDpYoRmu1pF4Wl9bWmrqj59FdSUyQddIILs2hUo0AL14P97xrI+9MGpEibKc1K1XGSAIjQ24J5RFUkrhC765g1y9NXUAexkHy3hpfUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e8107-aed3-4d90-6a5d-08dca4e42f38
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 15:38:33.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vlAFpSsqnKwocILXIHmnB1Zc3Zh4MgkQfg62nC6ajqJW6ZsUJLFrGGyYW5vyzzxDZzMjXvuhbFz7U/9VNw0rhOIVgczvnZ07q+Cdp/aKro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150123
X-Proofpoint-GUID: VeWjP55F1FW885G1aSigI7QD4E1CaP7J
X-Proofpoint-ORIG-GUID: VeWjP55F1FW885G1aSigI7QD4E1CaP7J

On 7/15/2024 10:38 AM, Michael S. Tsirkin wrote:
> On Mon, Jul 15, 2024 at 10:29:26AM -0400, Steven Sistare wrote:
>> On 7/15/2024 5:07 AM, Michael S. Tsirkin wrote:
>>> On Fri, Jul 12, 2024 at 06:18:49AM -0700, Steve Sistare wrote:
>>>> Add an ioctl to transfer file descriptor ownership and pinned memory
>>>> accounting from one process to another.
>>>>
>>>> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
>>>> as that would unpin all physical pages, requiring them to be repinned in
>>>> the new process.  That would cost multiple seconds for large memories, and
>>>> be incurred during a virtual machine's pause time during live update.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Please, we just need to switch to use iommufd for pinning.
>>> Piling up all these hacks gets us nowhere.
>>
>> I am working on iommufd kernel interfaces and QEMU changes.  But who is working
>> on iommufd support for vdpa? If no one, or not for years, then adding these
>> small interfaces to vdpa plugs a signficant gap in live update coverage.
>>
>> FWIW, the iommufd interfaces for live update will look much the same: change owner
>> and pinned memory accounting, and update virtual addresses.  So adding that to vdpa
>> will not make it look like an odd duck.
>>
>> - Steve
> 
> I think that no one is working on it - Cindy posted some rfcs in January
> ("vhost-vdpa: add support for iommufd").  Feel free to pick that up.
> What you described is just more of a reason not to duplicate this code.
> And it's always the same: a small extension here, a small extension there.
> If you can make do with existing kernel interfaces, fine,
> one can argue that userspace code is useful to support existing kernels.

Respectfully, I will not be volunteering to take that on.  My work funnel to
deliver live update is already too wide.  I hope that folks on this distribution
find the functionality interesting and useful enough to continue to review this
current proposal.

- Steve
