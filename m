Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133A71B48
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298736; cv=fail; b=Ifw61RT8J37dUC4figb66JxH/AqKtb6+BESL2XKKIn5n6Y6Djos1WVTURPNNNThicEvNtz+D57x6k2yNLnZ+/oisyUW+/lT32i9eFGpwfQUAKOaxDTis8NqJr3RTTq+CMZcp5Lrpkkelm8I4oFrKfWe33eDVCjuJH0tCotGqjYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298736; c=relaxed/simple;
	bh=51o6r9bdVcODuJSofVue62AoY8R6O5PydSCLodm8keM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUdOlCednZPfMur++SJP4+Qnv4Ku/f86lO3v0hUCj3M2iOH0ZEc++B64tlOWzZik1J5OfKvIQKeTeAKBYR4hdn/a8xAd5rLJOP15KRHYJJaXzAWjTZPvvO/TXze5/s8nJemJ+7M15j6r54PBx1cvuYzQ4cLkN0+GYFGjsUxqK7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VODySkte; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OzJPBea/; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VODySkte";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OzJPBea/"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF66A608D3
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:38:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phQXbwsn5rrk for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 13:38:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D6CC8608D0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6CC8608D0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=VODySkte;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=OzJPBea/
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D6CC8608D0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:38:52 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCxvPU014980;
	Tue, 21 May 2024 13:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=X6QsKKpF84uMyllc53d0qWxsLsP8KzpQdS7v4ecB+oY=;
 b=VODySkteQb668VS74+g9ApyuP9/d0gvgpwJkbp7L1kVJSbuywNIJhIgUs2s7xPIAAF3n
 IO1CTl+XcoEfN8y0xiLC+lys0ZeCxA5fxtHga1oEat7eRDDrPQEjkeQee/2pUYLgtbz2
 4sfcPdXMbkVh6mpiW6klpyW9eQZfXvzMdOM6HFLL1AmTKupiBzmxf1M0T3Z+QWl5SsDn
 SbgSLc/iuiiz36jH5H5Br4gPR+kKsr8paX2sGNgiCQM177XBEf6Gx6x2YSYvx4FZdrbO
 FNmkc1NYuFmK0OTJmpds+yYxEU9IxNk5ootDd7F8AD4S+ASopEhvSm+/4XN55H7yCH5+ sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b55gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 13:38:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LDSOmZ038382;
	Tue, 21 May 2024 13:38:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsdr94w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 13:38:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdcCb+Wcoa9dLY91tLFk+QN3xxdvLufITUJ+ga5ynOH4EsaKFlsViAty54AeL6C+BCCQ5VW1UjHFgRnf1W/AzvlCSZZirDMvBCgs45igGTs8eimO3UZ/iOSno088Wba9o6BMzr+OHcnF8CE3DUNyihNt9G+b3KbCcxQODFGGbjUCpP8ELfxbUJ2/Z3ZG00LaN6pXINRAGa2j0DQwwqVA/oAsg+jMHqLAVzOpjJnaXfnAycx/xXGGh68UBfIa8iUnJUUmGR+zUodiU+aGLx+uiwUmgFlhNoTAkjO+RbiS/4K3qX+CHj2Yr7l3qjTlgxNy4uqx9vrjiRkNPwlUIRL5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6QsKKpF84uMyllc53d0qWxsLsP8KzpQdS7v4ecB+oY=;
 b=oDpAiPVG1tDeKJD4lmzYB4z/A+KOmdYSqLaWZk/HFkKgQTMY0Kb6S9+ABh7c0n/hphqMgGyGqdlJVjWNciKmGipKYY0XRcabTRsaT+fNGoc0sBoikRWVmqLicHbsuDGWDiRYXDWYIUvWr8SoXmqaQoLM853OkIjVWGYY4MwCtd3alnpPeLJWEb3xRtp2zqdwSDlXj9od20SWROlTcKkaFzpZ2x2RnJncGkN8HsnsJYQe3+hROEukGtyFdhKLs9ilJXrPetVWz4gbjfh9OgtfVBuIhfEl/t/WTTiVUHWtDpJo8vsfUe5An5Fl3M7xOROUzcZsOMd0DSrdQi83baxKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6QsKKpF84uMyllc53d0qWxsLsP8KzpQdS7v4ecB+oY=;
 b=OzJPBea/BLfWilYWX7xXDhxFGD8p692i45szbX8Oan6ynDmRiGpUndui4PjyK0c3sni69ANlIF0LXwPrtOwTZlZH6F27/r7pvFI4lDn4UzfnmDgcoxkk7Fx0y0iI+P9bc0MNeCrj7BC8LiZfdIxCwnJmGed5Y9eMaEoMmz9XCn8=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:38:36 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:38:36 +0000
Message-ID: <c4b73d50-2896-4bcc-ae61-6d72f9471978@oracle.com>
Date: Tue, 21 May 2024 09:38:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] vhost-vdpa: flush workers on suspend
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-2-git-send-email-steven.sistare@oracle.com>
 <CACGkMEvhs_-wD4p-i2VCmQnmdNPLsH9FkhkGePB5LxZQf4B30A@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvhs_-wD4p-i2VCmQnmdNPLsH9FkhkGePB5LxZQf4B30A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 446ccf5d-89a2-4dd6-6c59-08dc799b50b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cFlaaGpzdVNpNlVaMFNQOUtuZUxjbi9BQWV6UU9yQkFCV1NGRVVhYjRWOGdl?=
 =?utf-8?B?WEVJVURiMk1VYW5hMlBCK3NUZ01OeXB5Rnd1N2R5NEpFdGtCdFZ6bUZKV0NR?=
 =?utf-8?B?VTZBaU5lZ3lBTXRBWS8ra29kay9yd1p0NS9YVUhDTkFmWmtaMzhUYU9OZWVF?=
 =?utf-8?B?MXNxTnZwdmZOV3dqeG85V0hHVmJ1VDBBM3FxWkdwY0R6akx4em9WRzRmSlpB?=
 =?utf-8?B?TDhzdm0rZ1ZNVHVuQS9uM0VIeUNDL0hTWGF2YzM0U05lK2tZVG9Xc0hTRXps?=
 =?utf-8?B?KzVvcUU2bWhEV0c2b0Q2OWI1VVJ1bThFcCs3cU50VXI0WU9QSHJDVmhXTzdO?=
 =?utf-8?B?LzQ1UVVjUWZzbllmS09qOVIxdHBaZEQrTm8rSmxCSlRDSUVYMHpUd1h1OHQ4?=
 =?utf-8?B?d3k5cjhSVnJvdTVubDVCRU1ibUpwK29sQVNEdGZsUkZid2RFU0g5R1dURXVj?=
 =?utf-8?B?VVRGdzZZdHM2cW9wWFFxYmpZQ2VhNDFIamVVUHVTUjZFNy9mWlZ6K2xDZ05q?=
 =?utf-8?B?VDdVTWhVaTZTVDBPdFllSzNUOWEyZExVb3pIWlQ4aGNHbEgxRUxxMVdJSkxC?=
 =?utf-8?B?TW5qcDRXYnRQeGNiQ28ybFhZT3NnN252ZDA3cmprMVBvd1JIb21yZlA0OHQz?=
 =?utf-8?B?RWdXWTAxSE9CU1BBaS8yVHpUNTMyTzBJdi9obWVuU1NjRit0UThqVWF6SGt6?=
 =?utf-8?B?YjZFT2diM3ZZZU42Y0VFRGpmT2FGRnFrVFNTaW0xdTAya0owT0UwU0xoazA1?=
 =?utf-8?B?QmJnQ2VKbEw5Y1lMY3IwakN1ei9kYkxCcnA1Nksxa1I3WFRmU0ljM0hSTFRF?=
 =?utf-8?B?bmpybkEzeUVSMm0wWmhqczlXQ3drZXpGSUxBa0dHY2tiQXlya3B1alhON0RG?=
 =?utf-8?B?a3BTOFdDRkVUQmhQL29DRHlzYkM5a2N2WGNqZlhJeFJzL3JDU2Y5d29yd1J2?=
 =?utf-8?B?bERBNWlqMGJZa2c0ZEF6QWI1K3RaWHRvL01CZXpIQXV2dHVIaWc2K2MwSzIw?=
 =?utf-8?B?ajhOOFNoaS8veWNKVDRuTlNMSkVVL0dpOXFhM0UxVjg0OWNJMTVwUEpBajh3?=
 =?utf-8?B?ZW5zbkozWEh6VVpJR3gzbENuN3JXRU9BT2NueUpSNzJiOEExK2g2eXFUM2hL?=
 =?utf-8?B?NW1qcXJCVmFCZC9sWWZ6c1daWk9PbmxzTXkwN2hBMTVZTVhCckg1UXRLZHl3?=
 =?utf-8?B?Zm1ZRVl5YyswYXlBYmhhUlg4V1hNMmNHazdOVE5LZzZ4TEM3MmpJc3IzRnMr?=
 =?utf-8?B?QUpzM094NUhOQXJaRkNXMmZGWVA1b0ErekgrSWJKOU5OejZYZW9nMnl4cTRP?=
 =?utf-8?B?OHVUNjdzalV2S0h1dW55RW5pYjhaTVpNZXcyejB6UGlWdGZSekZ0Qjhxd21u?=
 =?utf-8?B?SkFBM2pwSXJCOEl4d1dCUUw0aW5ta2Rxb3pUdW9Vb3A0OUxoMmtzODJ2aHpJ?=
 =?utf-8?B?Q3FISnhaMkZIcDJIa3p3dGJUZjI5MEFsT3g1NnBBK01ZYk0rT01IdER0VE1m?=
 =?utf-8?B?cmxSWUg5T1k3ZkE0TnZ5VnhJU0xKRVdsaGhiR0Nsa1lTcmdMSUdKemxHQnZq?=
 =?utf-8?B?clBrNXBHdlBuaUhUM3UwV2I3UFNDelJ4QTI2NHV2NmplbzJiMU1wcVprK0s1?=
 =?utf-8?B?aFE2WVl0Nng0WUFLOEdORGRFN0Rsb1Nzby9UdWdZWWxpdzJrcnhxa0dsNlBh?=
 =?utf-8?B?R3pIUHowcTBrRnR2dm1NSGRpaDNNRTFJcjc2cHUxejRERUM3WHFkS0VBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aE43bzNPVkxRdnVoT1BBb09GV1A1a1JEWW5FODA2dFg5Q2JPQTRvbkNCL2Vy?=
 =?utf-8?B?a0IzbE5iMDFoL0FaUjhUWDV0cSttK2pYUXdXRVRDZVQraVNiYjhOYWdqd21v?=
 =?utf-8?B?eC9lWC9TVnZFRHp4SVNIQXpaSWZJT2VzNnc1N2F2Z1RFcjk0L2ZBS2ZkQlY5?=
 =?utf-8?B?Rzl3M2dJUVB1anpjVWpKekxWdWdkM0x6Vzlycit3T1pQVnVDMkY4SVcxN1k3?=
 =?utf-8?B?aW81N2V3QzA0bVV4eXdWeU55ejJYc1E1MTdkQ0x0ZytzYStCejR2d2FQelcv?=
 =?utf-8?B?cVpQUVFXNWMrT3pVbzB3Sm1nb3FyVVplZGN1WUtmNVBzVU54Q3k3RHppMjRV?=
 =?utf-8?B?Y28weG4yR2w3bFU1K2JaMTAxM1hONFRxK0ZMWGg2R0p3YXFWbTZRSkI1UzZl?=
 =?utf-8?B?RGorSTBsY2E4QWR0anh1cDZoemNEY1hic3d4NTRSb2hNZmplSE1tUkpqa0tP?=
 =?utf-8?B?Zks5TXZCalZFUEZET1kyU2g4VHVBTGQxdFEyVTAweERzK3NPVUo4M3FWMUt5?=
 =?utf-8?B?SklJNkN0QUZVOW00UHRpdUVTUFpHaVVDTitnRjh1R0g2djRzbzFmSmNSRjVr?=
 =?utf-8?B?RWlmcUhUdUdCUHMvUWozUVlyeUJnd3BGMXU0bTQ5N3E2MkhYeEh3RG8xVlZx?=
 =?utf-8?B?UGpYMXlyZ05oZnc0Y3NTb212SEZFR2pNV1gxVE5odkQrUE9FUjJiakZsbE5w?=
 =?utf-8?B?WUR1Z0N6M0VUc0dCR0pCR2Rka2NVSFYrNzRxSkxoUUZiWkFWL2J1QVVoUGpP?=
 =?utf-8?B?WXdXazhEUUk4L2NVSUhDVWgzdSswSWU3a0gvbzcwanptM0dVMU5YdENNY3lw?=
 =?utf-8?B?NUNIemcrSExsb0hIZFBSZ0lSVUovc0VmYk51UFBaRnlxMk5rMnV0RVg4ZzBQ?=
 =?utf-8?B?Z2FsWU04RW11TXkzMjlvdDdJeldKYVV0MkU1QmVXcHVhQ1NMT0JVMk13c0Fr?=
 =?utf-8?B?S3NJbGxxZHV1QlpFTEh1TFRWL1RWYUhtWGVSb1J3Q1A5b3NxOVpZTnZBZmhW?=
 =?utf-8?B?ZXB5TW9heHExbmRvNDdhMzVjdkFLRlNKMGVmWVI3L2sxZm40ZndkMWx4NHI2?=
 =?utf-8?B?QnV0cC9TYnkxbGxqN2RXelQwUHRJR1RhM2owZU5zaFdIWFhiejN0Y1ZDNzBR?=
 =?utf-8?B?bFQwVHloZkwxajlOUkxOM3plRk5wUDN2Y1BmZkNuTlhQYkdPeWttMlpJb2x1?=
 =?utf-8?B?bHBzUkY5VXFuSzlUL2dtclpuYUx6RHZEOWI1dHlXLzlZY1dsNG9vbTJjNlJS?=
 =?utf-8?B?dHZzNHFyL1NXcE5La2Nick5tY3I5S25FYklyL2xMUGU3Rk5tRWhjTi9idGFG?=
 =?utf-8?B?Vk5zcWRLZUo5Z0JnUVNGZnhNZTZQRk5QdmxJSlh3Mjh3N3loSEdPRThic2VD?=
 =?utf-8?B?ZzBXbENSZ3hVRjZuSE5tNmhtUi9ETUtKQjZ5aWN3Vi9HZ20xS3E3RUx1bllr?=
 =?utf-8?B?OG1oN3RseVFEc09zZ3dZaE1GcWxWVmZvTS82b01uRDhmU1pFN0VrWHJtQS8x?=
 =?utf-8?B?eVdiaFhNN0ZDK3ZqZ1psVXBLb1hTOVRaNjRUMHJhUUJyZERpZUphdFJ1RnIr?=
 =?utf-8?B?SlNKWERMOUpKTy9VZUZPbElncGdvMHZmTWxMMDNUejk5K0ZCcUlxdGdCeG51?=
 =?utf-8?B?Y2lRSnBJZUxYTXJ5REozVy91VUtub29LdVEzU2xlVjZvSEk1WmlFR0luNWlI?=
 =?utf-8?B?L0UrcmpjVWtHdWRybW8yZzFPT1dFUGN6eC9wZmNLakVZcHFURnJSUUxNWVpN?=
 =?utf-8?B?YTNWUG9IU1BxZVg4OHdPb29mbHdYY3lTd1I1VHBjdTFKR3VsK0IwVEJGUlNs?=
 =?utf-8?B?dFErbCtITU1lT1kxUXFyVGlNdXUyNXF0QlFURktnd2NBa2FkY1NnTkhtcTVC?=
 =?utf-8?B?aXZURGxCUTd1QTBMVkIyc2VWTU9tcU1rVDJnZGRYcVRKZ1BsSDFpVy91M2NW?=
 =?utf-8?B?ck9lamRML05JNTNBdkpHSnNJeU5Taml6U201L1RaVWtkSWxZQ1h1a2ExSTlV?=
 =?utf-8?B?Znl1QWhGN0ZqbFVNUWNUK0daK29HU2FGMUZiME1jcW83UFNGeUhvRUsycm9i?=
 =?utf-8?B?UFZ6aEJSSVRlZEltS2pKMlR0b3g1R2l4cDgwV0gyb0p6ZDNWTy9wVlFObUpM?=
 =?utf-8?B?b3Q4cDNnRm5zZ3R3TGlHNFExRUdtNWJZQzdIOWhHTGxzS1ZqMms5Wm5weXJr?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R5QW9ZJ3umUHWGYZQ26CXHduO7ly3PW+towmF77TahLLwXG9qfAs44B6eGaA3b9/7mDlIA0lfPEM05OidfmFoOcWY9qcVHPhHdmRTGyEhSoq4PW58KFTzn4ffmubmgz6wQgOv8JVOlCWpIAEFlPB3DXDf3BVQ5/BuREmymjpUjcGR4lO0rmz7v1PgKNJLEsnaK6Md+mBc58q155wyy4GWxTPM76y/tLWdSJDUfJ5jP9wR8Z1TJuAkSmMHkYPG63T+R2CFYb7J8oUoZl8TbDAwEhoylHeUch4MnIMX4GwDxLFwSHsQ4Opq1QeTTE7hSEz0j23lsZZmaXkabnMdswpirghlSkgId067V0hKnC+NQJnty/Mmgqdd2kF5U1bPMxb6xcxBwUebkSdVVZu+hPkwYknW1UEnphATs9pAjqe9X3Alf0t6u979lypP10IpUvtG9xKCbOt3XSkB3+P4vcQ1iuxvsYcHR724aH6Vek68SRr/eb25IJPswpmFrnFSlQ6xTolZYeEpuvCPRUftg/FktctbHDxvDruQmOMVlN2riaRSBhxLNHkbKQ3W9CuCKXsj0DulXai/ZoaDtQMELl0DvBgjAKvJZci8NwzVkWpipE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446ccf5d-89a2-4dd6-6c59-08dc799b50b2
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 13:38:36.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDiXU02hM+62LOfE+c/soG3R6OowYiOTx3N1MA3m0UceVSlCFjU793E0JOWLSm9SThi5uOxQ4CMb15duOqpevn/+epGdAZm2ZLiioswqW78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210103
X-Proofpoint-ORIG-GUID: unqyrUCrkVxFPd243rTJbskGc35c3xHM
X-Proofpoint-GUID: unqyrUCrkVxFPd243rTJbskGc35c3xHM

On 5/20/2024 10:28 PM, Jason Wang wrote:
> On Mon, May 20, 2024 at 11:21 PM Steve Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> Flush to guarantee no workers are running when suspend returns.
>>
>> Fixes: f345a0143b4d ("vhost-vdpa: uAPI to suspend the device")
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Acked-by: Eugenio Pérez <eperezma@redhat.com>
>> ---
>>   drivers/vhost/vdpa.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index ba52d128aeb7..189596caaec9 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -594,6 +594,7 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>          struct vdpa_device *vdpa = v->vdpa;
>>          const struct vdpa_config_ops *ops = vdpa->config;
>>          int ret;
>> +       struct vhost_dev *vdev = &v->vdev;
>>
>>          if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
>>                  return 0;
>> @@ -601,6 +602,8 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>>          if (!ops->suspend)
>>                  return -EOPNOTSUPP;
>>
>> +       vhost_dev_flush(vdev);
> 
> vhost-vDPA doesn't use workers, see:
> 
>          vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
>                         vhost_vdpa_process_iotlb_msg);
> 
> So I wonder if this is a must.

True, but I am adding this to be future proof.  I could instead log a warning
or an error message if vhost_vdpa_suspend is called and v->vdev.use_worker=true,
but IMO we should just fix it, given that the fix is trivial.

- Steve



