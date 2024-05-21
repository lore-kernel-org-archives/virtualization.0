Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A87E57C
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298773; cv=fail; b=BQHrhAnqxcWSDH97x89uZNMhAe9ojkwrVUm1OMExCiz/MsDN+KwGf/9JKeUTCUiAVJs5f0IDfyRTyTx/1Zx4fVRJW796E9dQ2SMLTeOoIGNREzC4wGZ54vnK8E+v1zoKqBhHQByE6U7DD9KCHxXcLRlvlJug1bu6I+tOA0uYJKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298773; c=relaxed/simple;
	bh=sZZLaJ6o7VLGlhj6dYfkv6eBmkUF8ORkV7vD0Z2LxlM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ItEG/r7IVl3AbxGZIYJvpTuWr7tLjZsciHhnxMjvVV83zulb17pSSCxjT3xUI1ves8udWYLjUKdDe2I4UMFaruQKZA5HnbSg5F41A9Bumm0y5seb/avXRFw0qXRx47J+GxyIc07h5Q7+hYrqQj/5ywSdTlGkSw8bJhJGDoQulsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wb7/GfsT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oYlveBEE; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wb7/GfsT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oYlveBEE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB9E4608D3
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPbbe9XIvjCa for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 13:39:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DD539608D0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD539608D0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=Wb7/GfsT;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oYlveBEE
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD539608D0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:39:30 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LD07H4031389;
	Tue, 21 May 2024 13:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MfrmIveKY+yCDKgM6LNBIA1hcrEUIT7Y3LGdMPoCiKM=;
 b=Wb7/GfsTfoiqX+CleGM19wqg9LgTpfCmSoj72NjjrSZ0SOI4e/R6rKlsTaT0Nv9qQ4Pc
 9nM9W+JdwMYzvy8+s+ulnLghbpNUQTlRGalbaYF+MbQho7tRB4z4MZkDT/2kftNj0cxp
 IR86KewbBfFAbzYeN0Y/YT+EaQ+KM4mosxG5kLrOCrQuvPk+6ks74WgCkvxw2ETVcL74
 TD0ATrsQSYqdSb5zzImfRULVGfbcpdqpjRlfE6xigez7XXghbYaeNB+Q1DB8AZ/0xV+i
 HXUZzJHxhYmXWV14kkJYHgCbhuOckCvkYThcUMJD4sozItwUUP7/HisJup14qv3WPId9 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8d5b7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 13:39:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LCpUT0002694;
	Tue, 21 May 2024 13:39:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7qjg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 13:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfYoYt8CMyWK3Rhkvpad3MLDEkrhwhnjzj6QEXKLuOA9Kv2rQSsGCDt2avFlLbTTXW58+NwdjinP3rMfBodbBWD+CWxS1AFPprB2v9kfB3VRPYJkSeW8GTkWzHumFu69PIJMHQM7dXLgKwPGqwDHEBNblS57wlvLBlydWCP81kCq/xMd1T/TVWhnD+5+pvMYJ5aaQTx2rMeGuRd/3wF5XeCN/gAEXXAk7UJAgZdn8vTCtsaEpP80J946lQmUHAB+a6vlk5BWIDeaZ4aSJOllSA707vXA82bJ5m/mXeljaIHgQfhdLm0gkxUDSc22ODeogxyupGFbGbNK9At1OU3HKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfrmIveKY+yCDKgM6LNBIA1hcrEUIT7Y3LGdMPoCiKM=;
 b=ThA8vD5WPkTw3Mnbj4WCHVs0pDmD/h9CXXp8XzkU5+vd5grmgNAmqhSWHbEUCu+RXMrh91MX3mxau4qaHSn8+ycYa1DOCRDTfVJRg3LWNr+g320j8EUzMUCg+V13oairBLPsCovzoFB1/8zVjweZLJuKdKKK4cCqj6CZDTwaV03H8rj4WNSHSGCJ5tiOjxjnxC8WC1+rdxZN4LYJjOB5eAVWLgRbbU9cmSMtZv6+iQZJBMRkpfmO0lk79hSWJWGNY7ywVjqSIuh7dMoyHS3RTn8OFxfTM3bsvN7JrR/IeJCrYxsd3EFV4uUEzU3kXwGkXgQRQh/gHnp//Qsh0BQ8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfrmIveKY+yCDKgM6LNBIA1hcrEUIT7Y3LGdMPoCiKM=;
 b=oYlveBEEsqiBx8YzuNFGqzdzSD9ANaSbMVlb5bMcWn7YECOYk71qsyZKaJrypv7xNyHvULSN916/CGtcGIbea8Yy8sIQGNbXK98ld9ob8+F+HvE6DpOoyeMgrhtNnDRgrlrR6mFJeZPwHEf/F7Dp+sphU+/nit4G7LArN5I9pEo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:39:18 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:39:18 +0000
Message-ID: <46f91e76-6f88-4f83-8854-10baed4e82c9@oracle.com>
Date: Tue, 21 May 2024 09:39:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEur=CoU1GgxNdweu-SfuutSN-a+LaHLkdtoWYJMnE+LOg@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEur=CoU1GgxNdweu-SfuutSN-a+LaHLkdtoWYJMnE+LOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f02b79-954a-4369-a943-08dc799b6999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZVJ6d0UrN2xiR2YxMGtuOXdkbUI2UXIyWWFDdkU0VWJRaXNaMDRZaVRPQ3lv?=
 =?utf-8?B?cE42aFFpREh1V2c2ZmVxR1gzNGRTVzA0UituV2E0U2MzbjNXSklqdi9TTXhZ?=
 =?utf-8?B?eERNTTdxb09XYXlOejVLaldkNGpmeVZyeVk5enM1SlRBMzErOTFERDNnLzFm?=
 =?utf-8?B?aERXVmFZTTNVcjlTbzZuakFsZ3JmeEpBMmFkdzlyakZaSEViVHNuaDVxSURk?=
 =?utf-8?B?T0hsMlhXOUNHNWlndWFRSng3dHpHRDBVb3FGbjJMNXluV2Q5VEt3eU1oMldN?=
 =?utf-8?B?cklDTDhxc2xnTWkwemlma2h4WHhha21nQ3czQzdPanJDcVdVYmdNVjNUSXMw?=
 =?utf-8?B?QmpQYk9uUEhkekRWWFNoWk1rRWhBc210Wi9nTUZHSDdaL0VtZThUcnpkN2gx?=
 =?utf-8?B?SWtGekN3YXNDVFpNenpXNE1KbDQ3QzgvdHBNY0FCdUZoUk1mMmMreW1KZkNv?=
 =?utf-8?B?bVZsU2VScko3NnZkUDhGcy9zT1QyQXBzYisvMWJqbWVjZkdRLzgyM1ZxSktp?=
 =?utf-8?B?bWtPNlZYUHB0MWxTQVJzWk1jUVpFL0RzYTlPL1BzVTN6NFBJNC9Ec1JMYnRs?=
 =?utf-8?B?dXZWS2VwVTBUSnB3VWN1YkZUVHEzNFdhV0MxZnl3NkRZNWp2MXc0U0gxbmsx?=
 =?utf-8?B?NysxRjZPcjY0d2NFTmlvMGphUEROMWxBSktBa29EOXdIU0F3MWtZK3hiNlFT?=
 =?utf-8?B?UjBlRmxmNFdxOFVxamlLaWJ1dlp4V0R4eUphdHhXWERtSHFSNnRpUnlGK20z?=
 =?utf-8?B?UFhQTG50MG0yVG1LM2l3NnZRNGx5aWRXQldpMXNtK1psRDRMTUhBYVhCV1Uz?=
 =?utf-8?B?REtobDgrakY3dDBKN1VyR3E4RGJFUVFCRTZBNmI3YXhObmVubzZhMlQ5MCty?=
 =?utf-8?B?d0NsSWlBeWMvTHZ4OFEzWFIxVW1rYzM4aUNzckg2Nm5OK2FkU2c3NVJUczhx?=
 =?utf-8?B?b2prWnh4WE5BSks1cVN5TnVwZDEzSG1ZMmFEcU5oNWhMSjNCN0E2blI5OFdi?=
 =?utf-8?B?Zjd1VW94U1JDMFA4UmJCNlMvclJEMk9JUmxjTUh0emIyS0RhWjE3UDc3OWho?=
 =?utf-8?B?cjQ5d2taeUxScjRKeHRydjRPcWlmcVpSK0NaQ0JlRTgwSlQ5ZE5DMjBsRXNx?=
 =?utf-8?B?WkV3ZE4zQWNCOEdhSTNxd0hQQUF0R2NXUXFxeDl1UkduMFgwNFVSZ3dvcHhn?=
 =?utf-8?B?Z21ZdTlmYTJYaFVTeVpsakdLQnpiN2tlNWpVWTV5bjY2M09hSE9vTzF5V0Ru?=
 =?utf-8?B?ZU9JbElSNjhPd1dPVFRUREV6dERtb3pWTzZURW1ydC9FMHljOTNxK2t5VVAr?=
 =?utf-8?B?R0JaK1AvU2dIMVg3cDNzWXFXVDgxTWxhWnBkZlpEdU1SUTZTbjRlazN5Umll?=
 =?utf-8?B?ektKMVJwMnVhVlFlemFvb2l2WVRiQXZaNjFpZ2wrRlZ2b1poTUpHZWpJMnpa?=
 =?utf-8?B?Rno0RW90cEQvakJjUTVzT1FKY1F1Ym12SWR1d012cjk0UXN6YURxSGphSGE0?=
 =?utf-8?B?NTI2TDYveVFNN21QNytvTkhFUStyQnpnQTkyblMrRmhNdGxwUU9LODJyaGJo?=
 =?utf-8?B?YlFZU0xVZFd0QzhWZTl5Ky84aEw4YUZTL2dBQW9FL0dmTkdjdEVsNWUvTUVz?=
 =?utf-8?B?RDRMUStwVkU4Mm5icWJ2QmhEZnRMOHdLTTF5WVMwVktrMWptbzlPclNMVmQx?=
 =?utf-8?B?VHh2bXFqd1ZCdnRWL0xKQ0grM2xBS09yYmxmeVNwV2luZ0c5VzNiVWRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkN1SWtQY2paWVFEMThIeGJtTGJqL3FPSmVYeitzMngzSVY4SnBFenR1SXRh?=
 =?utf-8?B?a1o3c1Zqb0krNEpsWWxXb0RtNk9YYm9vSTNoQTN5cGV4OHlRSHJvNTc3L3VB?=
 =?utf-8?B?OW1UZVRSdjl1eFl2YlkwSW1zbG05N0FFNnhWTVhxRG1nWEJ1bGdvK2VWYS9Y?=
 =?utf-8?B?SmEvRG0yVnJwNUNINDhHZWJRWDVNQnFjYkZ2TUR4NkdKK2w2c3I3SGxWbmlQ?=
 =?utf-8?B?OFJoUW5RS2o5YWs4cERORE9SMFdHRzExUVFwcVNrZ08xN0o0MzA3NmRkazFM?=
 =?utf-8?B?bjVLMm9xcCs4N05oQndHaDQvaWgzVVA2RHR0RjZwbkVMMGI3L29wampjMXV0?=
 =?utf-8?B?MEZrZS9tV0N1MGFoNzYzekF4dVd1SVF1c3VEN2xKcmIvWnZYOE16ZzlsUFJh?=
 =?utf-8?B?MktyVnhiNDhmTjA5cWJPVVg1azgzOXhkeWlnVGIxbVpBd1FGWHloejNvd3ky?=
 =?utf-8?B?SkZXTkdqanZydXpMYjV6d3FDTENXY0cyTDJSU1pIdG14UHRIVlpJWmZiekFJ?=
 =?utf-8?B?elltT0FibFkzcmJRdFZ0NSsrV1Jma0NhdWZicExFUXdmU0thREtmTXF3Z2FN?=
 =?utf-8?B?N1F2VHpWUll4MjFxYnBKNFdWVE5tVnkxMSsxSXNKSCt4M3k4MGR3ZUxRVnFU?=
 =?utf-8?B?WDk5Q3BVSXdCUEF3a2ppd0RwMjdEWXg4MEFCaGNEV1YwZDNEYTVkUlFiS2xH?=
 =?utf-8?B?MXc5TUxNMVpMeWhXZkhheTJWODJMMXB3N3k1Z1hubkNycmJrT1Y1bEptUlVO?=
 =?utf-8?B?OUdQOVNrUjhrSlJZamNUbk1acHV1TFpvV2svWXFWbHBHMHVYMHpPc0pZWXJh?=
 =?utf-8?B?NnRVUUdSd3ZqMDRPakpHVDN4dnBNbjVsRkNmZkU3akJkOVlWVnk2QWdGQTM3?=
 =?utf-8?B?cjlrQnZycU5VSkJXdkwySXlsSXdwd0VEQ1Z4N2hwMkk1UlV0dW9XVHV6SERa?=
 =?utf-8?B?aXpMWjRxeHBNbDNVa3BMbVhZUXpxbU9OMFczL1NJQmNqRzlrUjZzb1RkZjkz?=
 =?utf-8?B?VWEyUmxmNUFJbkx2bFR3N3VNWDdaQ1FlSXNscExqMWNJbFJmZ0VXU1RvcXZD?=
 =?utf-8?B?QVZxaTlWT2IrTUpxQ0c5Y0l1bG9yRVhuLy9hTnZFSE1ScE82MmdXSTBucXZJ?=
 =?utf-8?B?UlpGZVBIZTRCbVVsdVljZ2drN1c0aXpac3pscHNPRFBDb2FOVHhUTGR6MFAx?=
 =?utf-8?B?VlpBUGd1TnhMcXoybG5qd1gzMWFlUFJJTWN3dVJ6eEh3VEl1WHRRTU9qOWNU?=
 =?utf-8?B?eFI1UFkwQW1lc3JtRFg3bVlpSW90TkZKYWZ1cTl6VzRYaTRUTmhzSDh1SWhP?=
 =?utf-8?B?enRRTnlQRGc3RkFSSHRZem9ySU9WYnZYejgvelRlTTAzTnhjbGViUCt5bURy?=
 =?utf-8?B?Zjl4OXFOSjR0OWF0bDBQOTdtTmQ0ZEFyZzZtS0YrUW04NmMxZk1Wc3lOYU5w?=
 =?utf-8?B?a0ltNWk0a1Z4cC9CWlNUNUE1eFZwbDJUaC9sZDNzVUhGeHVUVFM5aE1xRW40?=
 =?utf-8?B?SlFFYzYzTzFxZ2U3ZklyVCtmU3IvM1ZYRGtOMm9nNUJQbzdPU1c1QWlRb25m?=
 =?utf-8?B?ZllGanBHWCtBM2tRN1BPY1dWeU94MEhjQVRVbDMwWGFyRHRYdy92MkpRTVpB?=
 =?utf-8?B?aEtHWEJ2WGlibEJBako2Z05ZRHdQVU5TR0NJNWphd0xQdzl1UUJZazlKWU1x?=
 =?utf-8?B?OTJ5YThGNjlkbnBoYmU0K1BxMEFGVVFHT2ppN1A0U2pCVzV2cTRtNldiRDhr?=
 =?utf-8?B?bitLQ3UxY0VKalZpNWcyb2ZWaDhscnMyLzUzMHRFOTdsR3h0M3RuaDh1VHFN?=
 =?utf-8?B?eTdtbXFzOWFRUE5Wa1UzRFRBSnVjMmVRdkFmaGdvUklRSWg3UGJXUjE4aWhV?=
 =?utf-8?B?RVM2dkN5LzdVV3hyQkpDZ3VOSTZkcDhYQ052cEZUTmM3U2tNRVpaT05KK3o3?=
 =?utf-8?B?MnFTZE5nbitPVkN4bGN3ZWRoaWVzOUg2dlJQVXh5ekVmQ3o0SUZ1d0pwT1k2?=
 =?utf-8?B?WUZGYjZiN1IybVRFV2UyUUhwSEhmMldzL092dzAwWGFURVhPT3RGamdJdEEz?=
 =?utf-8?B?STMwNG5hOWU1REpLU2R6QjJHd1htbkkycFY2NnRuVkhNaUpLSGVvN3hMTlA5?=
 =?utf-8?B?b095NGRZNnNXcTZxQk54OWpwWGtaNEJqUUgxbHIwdExRdGFtSnZ2WlRJOW13?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0AwtJEGdjxVJvf8xjSPIGChtQAuJPbyA1CEf3kL41GEgk11xg9gZz4yxwD+KQ84XU0YK0ZGVUI3gF7Cvo7neXa/r8jkIp4kFxyn1UUHfmMdaiydo2uqfMshWTeGU7AcCVh6h2Ix0vC6aV9Nq4tDapIlpMB2MXVQEp1uZLkw6IgdGgQ0hUJrESSpdR5vfdMbcDNONbxqOTmVBFfT6qxCOgxtP9bNBG9IX2MpcTOWFqDi6xmnXq3dfkqDYU1seU4vdfJC4WM87lPp6vxbniuF1neoLmTUTvyU52RUd2qyzsvNkJalPm5nSZ7dOiRZSL36MgEgJlnXfBBTZwavIYUmVb1yS1KU2BXwdNcir+gJclNRQNeG2omoLP0PBhkdHTFo7ClLek9YW/QEhdQLoZfpRTkmSSMmOZbR9g5lFzVRLFJk1FnewZjbArG1+yPaGoiehQFyl4F2paxxoBtgghJcy+TL9Bh8x8jarUwbIwVvpW5wSqsP1m3NcJ54jlyhNimzzv7EvRcPPRoPfXBlSnMHtIa+8v1QwU9I30+GwfdFsYrlihTLYZKgtP+eZG6UTOzcEFc0a0HPYzyhdd3M39w0m51RIFauQJyIpuVFa3QMvbhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f02b79-954a-4369-a943-08dc799b6999
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 13:39:18.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsHjzsYJbLfieFarAaMsGyPkdPTWLk97OrED5ehtV56N7Hxh2bkfFmJBFtIXxD1G4r8RoEE3V9Ic6w1dRDHq3PGze30z9jDPsAw4O8lbGh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_08,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210103
X-Proofpoint-GUID: knnh2ao1iLl686udbjPYxBoyf8hdMohU
X-Proofpoint-ORIG-GUID: knnh2ao1iLl686udbjPYxBoyf8hdMohU

On 5/20/2024 10:32 PM, Jason Wang wrote:
> On Mon, May 20, 2024 at 11:21 PM Steve Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> Flush to guarantee no workers are running when suspend returns.
>> Add a lock to enforce ordering between clearing running, flushing,
>> and posting new work in vdpasim_kick_vq.  It must be a spin lock
>> because vdpasim_kick_vq may be reached va eventfd_write.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
>>   drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>>   2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 8ffea8430f95..67ed49d95bf0 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device *vdpa, u16 idx)
>>                  return VDPASIM_QUEUE_MAX;
>>   }
>>
>> -static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>> +static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
>>   {
>>          struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>          struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> @@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>>                  vdpasim_schedule_work(vdpasim);
>>   }
>>
>> +static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>> +{
>> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>> +
>> +       spin_lock(&vdpasim->kick_lock);
>> +       vdpasim_do_kick_vq(vdpa, idx);
>> +       spin_unlock(&vdpasim->kick_lock);
>> +}
>> +
>>   static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
>>                                struct vdpa_callback *cb)
>>   {
>> @@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>>          struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>
>>          mutex_lock(&vdpasim->mutex);
>> +       spin_lock(&vdpasim->kick_lock);
>>          vdpasim->running = false;
>> +       spin_unlock(&vdpasim->kick_lock);
>>          mutex_unlock(&vdpasim->mutex);
>> +       kthread_flush_work(&vdpasim->work);
>>
>>          return 0;
>>   }
>> @@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>>          if (vdpasim->pending_kick) {
>>                  /* Process pending descriptors */
>>                  for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
>> -                       vdpasim_kick_vq(vdpa, i);
>> +                       vdpasim_do_kick_vq(vdpa, i);
>>
>>                  vdpasim->pending_kick = false;
>>          }
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> index bb137e479763..5eb6ca9c5ec5 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>> @@ -75,6 +75,7 @@ struct vdpasim {
>>          bool pending_kick;
>>          /* spinlock to synchronize iommu table */
>>          spinlock_t iommu_lock;
>> +       spinlock_t kick_lock;
> 
> It looks to me this is not initialized?

Yup, I lost that line while fiddling with different locking schemes.
Thanks, will fix in V4.

@@ -236,6 +236,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr 
*dev_attr,

         mutex_init(&vdpasim->mutex);
         spin_lock_init(&vdpasim->iommu_lock);
+       spin_lock_init(&vdpasim->kick_lock);

With that fix, does this patch earn your RB?

- Steve

>>   };
>>
>>   struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
>> --
>> 2.39.3
>>
> 
