Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D2152E12
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268253; cv=fail; b=b4zuRrWhiruCzJMBte52PFUzdJaNvx1fT6QTSrxcbvVChcD7ry8z4iAnRjLVrGxDitZ6UHNckOGSrRevucvqYsPk7/pvBY9TSEcIjzwjMycllGm+0hEtUUtFkNXfkTbXGv9JnQ+vvv+kq2GtfifClzvgGazeQIkDH1NBSBxyTWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268253; c=relaxed/simple;
	bh=kpFCVDMwlvlncybli3Ob8RTBPRjzJDneKSrepELKlwg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N4pk/sutn/kIrMArpgBPUFVsVH+aPBtkFs3VPSxn52ZPfPhN1S3Mz27pT3D0wYRXZadQjdrrVRmEZCqzsp0gmwEMZ6Z0oS8sf4E1H+iv9ekFbxceKKfVQV5E9RsCrdyLQ6uWpd2y4EuvQf+tNVmwn4ejuwXtpcPzdyDPe5l2Pbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sN+YHZes; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sN+YHZes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv9p/61a4LFKSnxQAATxDtDOyVY7Sim1vgaA2WIxLMkT21yWhHc/vCA9K7kLm3DgToVW/CO2G75/WhaGOX9NAW/2dOLlS0cSRB3/2jI285JzUzeCV81AyLn4OWuKOBpmV7lTRttkUplVuFv0+Z+bjDVu8LSje/oi+M5J6iIbdiobAJyKQnePss8/yC2/axOdU/6TdknCPRFGCO0ZDjte7NlA1cBlGkTNHnzpdjFAR8duXmLtCp8TGfyofmJmfhUELnQNMVi2OCtvWP2ffbRoGQkQD5If9NQSK/EbB4vi2YjTr2QiJAPTTTfmX4IG+mGhv6SRQ+iVRiuoj3tL7y/TJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BRuRAGIJI82hZHhG5nZpKYe3PqxC2w4yrMGJmNSP00=;
 b=jlyt6ho2hHeakVuYIXn5oCY8VUAC0Mqu2Zsy5WcnOV1MkfghW41HPkpD3sOtNj2DURkdQaNtYBpxzDkGdtOVo07y0oGvKu0Fu6BsXKRzI22woyPjNIOO+Q4s3GNV11DYiu5b7xYEDymb1QRFuVNxrMfX2MHefrAVSzx+LnhpMB+6l+gmz8F60Zbc1XgxfauAsYj8Z1Rr2fZDTsIBWjo5tEvMiNXJQnCjMthasQy3282IFs9qSZ7vuXa3GGdQwV02sWCmsOxP322mHQwTYlNp9sTBqlHctM/6UauORPGxDo6FTwQdy6vpWbodF9K6E89LxW6gbzoziwErwEpWoykecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BRuRAGIJI82hZHhG5nZpKYe3PqxC2w4yrMGJmNSP00=;
 b=sN+YHZesCgWkF7aBJf9crxTCFeMQhdb2snPNSchbz+dITUXaVS/Yw68eP1y6St/nIJaGMcPeZ5H9okqNY4aedtEQuuWlLelYs7ghi0M89nLFTAQqA8Dbg6RA0tfS0xg5pjVw5XCP4G+IUCq3avDg3h7P225F6EUdkUvHtvX1chdtKeOp6XUfw4kC/YUsd0Qrk4Bkd8JYR4R6Azd1Ega9tB9NdHXW4Pf7Fr2wrAV7TLHEJxkQOu9LXE7o83wp1q21f0tACzcADsJ3kErLhZaCxeQAEhk3xC1HCLRCGEOyrSXqK+MdCGZ/EXufc8mOHi4xNePOzdkPs3v7vIAFmjRxXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 09:10:47 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 09:10:47 +0000
Message-ID: <82a9a043-25de-4ac5-965b-3902b3a179a9@nvidia.com>
Date: Mon, 2 Sep 2024 11:10:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
 <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
 <CACLfguUZVDGaY4MD+_tDqM9DQC-C6cuPfCf34X59e2RkMztEkA@mail.gmail.com>
 <cfece74e-a979-4f74-8a6a-fc8869e354f7@nvidia.com>
 <750da215-adea-422c-8130-7524671a8779@nvidia.com>
 <CACLfguWu=1aZ=mhtzMGXGG2s3iG-SVAFB8QkObWfg+npdV0X9g@mail.gmail.com>
 <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
Content-Language: en-US
In-Reply-To: <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdaad91-22a8-4b39-7187-08dccb2f221a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnNsMWZqajFZMmpXbGhDRGs3OHJndXV2QzBzZWR6dUxCYmQ5N2puTmJGVzZS?=
 =?utf-8?B?WUk5VFhhY2dnd2wwUndseDdMSHlQU0VHeFhEWHE2QldldERLTmttZUNBdzA5?=
 =?utf-8?B?bW1IOGhRL2pubWQ3WElZV3AwM0VjOHhxUTk0UGNNQnhWQ0kwV2xreG1IMWhS?=
 =?utf-8?B?VHVudXdka29FUitnaFdpTDJBNDlyWDByWnhOS1lRRXZCWlBpeVp6dEZpektP?=
 =?utf-8?B?azBSbFZ1T0dOSEIraktiSy9xSUxha20veWtlcWdTdllXRFZhYW9hK2JlS2Y3?=
 =?utf-8?B?d0Fnd0tTYVBBMmtUUW5FTTZkenM4SW1UdFQ1bFdiM0UrbjZxdW5leklxRTNn?=
 =?utf-8?B?ZGhiYW4vbkt4N2FtdjZ0TjJzK2Y1L29ueFlSQi8wM081eWtVYjNtUVhtaDlK?=
 =?utf-8?B?N0pTZVpiSnRtb1JDM0JGNEpQNnlUZk5vQTJ6ZEZSYXdidUNMQlZzK0llUVpo?=
 =?utf-8?B?TytEa2pZK21ZbU1iSlRSYlUwZWJFaTBYNE1adGkwMVRvdkIrQm0zNlJhOTZJ?=
 =?utf-8?B?NzBkYVBvVVdLM0FSYmRteTY1ZmNRUmdlV0t0SzExcHZjblRpS0hBZWtabWxz?=
 =?utf-8?B?VGdRN2FNTms5THZmK1dFTVE3WkNlS3pzazNtYnhPYXNhTjRqU1llTTVOL1pE?=
 =?utf-8?B?SzFkR25BZUlQWnBrdk04NXNrMDlLSFNJVEpzS1p2RXNPMWdBaXNMU1N1clVV?=
 =?utf-8?B?dkgxdE5zY0o5ai9UUUpwQU04SnlWMloyN0wxWUhmUUhZVDMrLzFhL1FRdVRX?=
 =?utf-8?B?TnVDbXJjWHB5RVJzQWNXK2Fvc29GUTVLcFJXa0VGbWltY2ppZmNtTzNZVi9C?=
 =?utf-8?B?ek5xNmhScjNiUUlrRTVlcFJBS2JGckphLzRld2RWZFlHd0RxdWx2Wkx2S2My?=
 =?utf-8?B?QUMrdkU4cWY4NHFXYUJFekQ5eFMyK25nTE1UUExtU3M2RklKMjhoS1lsaXdG?=
 =?utf-8?B?TktpaGhBdDdyQ3MyMG1DbC84ZUdHZXNPM1hETDRlaUR1ZlpuaFVNZHNaQ0dO?=
 =?utf-8?B?M3VlMFMvY2tuQWJBeEE3YUMzSTdWZ3VNbWhqa1BEb1NGNTd0cjE5UnNibGVi?=
 =?utf-8?B?T2VvdEF1U1JHVUwzV0lnM2ZXLzJnUlpxK2ZvNld0Q3BjYlh0V1dTaHAyVE11?=
 =?utf-8?B?NXpIRFhWbTROSUlsSFhYUU1pM0dPVzY3NkNpOG9FcHp5anFDaXRvQm85cFll?=
 =?utf-8?B?NXVrM1RwQW9US3Nhak9DZi9SdXlqT09KeEdxWXYyM3hHWHNaWmI0VWVvcUVZ?=
 =?utf-8?B?YXh5S2VUT0N2eUEvTG1jY29sNjhjTnZwdlN2L2pKQnZIakhydHllKzByYWxH?=
 =?utf-8?B?N2h2WFdsbEZyV3U2K0g0dmxaaG4ySkQ4S29lQ2F4VS9IMm56L0FnaUNGU3Ra?=
 =?utf-8?B?Zk9UMmMrNE93MjFscDJ1Lyt0YmJ6bEdCMGlSeE80N0xUNkp4SjI3bHZjWU9W?=
 =?utf-8?B?YjIyK0lOaFg3T1ZkQzNTR0FoYXZrVExReEtPc0NnS2hQajdLbldYUVlJVnhv?=
 =?utf-8?B?SnhzMkFzWmRNaHE3T0VUT3J2a01mOXFjZFd5R0JDNDVlYkFnbmlDQURaMXdX?=
 =?utf-8?B?Y2o0Ui9TemRPeTNRWU52MjA5TDJHVWQ4dkdxUER6WU1DNnB2RTd3RmFucjlV?=
 =?utf-8?B?Tk1TOVVPN3FUQ1R3L094SEsrQUNRd2FXTVlvWi94c25KV2VTS1hqL25RYU9U?=
 =?utf-8?B?L0p2UFUxMHAzWmNRUXZqOFJYUjhHSGpzalIvMWVpaFlINjk5Znc2ZDZsdEdG?=
 =?utf-8?B?RHNkaDVmM1Uwc2ZQTVBhNGFidTE5RTJZakM3UmR1V2tmUjVNc3VrMlp0Mkti?=
 =?utf-8?B?NWFEQXdmZTVIdU9iRjA4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGF0WHRRSTc3N3l0VkNjRWd6ZmE2RHlaUTNibFdncWg4MDBkRllJN3gwZmJt?=
 =?utf-8?B?dlh6M0NCMGViazNZa2xuNm1WQmx3M0dmcXVuNmNaL2o0V2o0WDlOZXJrL1pF?=
 =?utf-8?B?WEV0S2w5K25SUDZqS3hEUEFrVHVEcVM0a2k4RGtHUU5mVUx2S1pJMkdFV1p0?=
 =?utf-8?B?anZiOHpjdlJxQVU0clNHV2JzZVdSeFUreFRiT1lpMTJzbUJRMzYrSnpUeDdy?=
 =?utf-8?B?T1ZWMzNncUhmNzN3bTRtQnhsaW1FMG1JQ3d1cTNPK0tZS0xCSU83SldVZHov?=
 =?utf-8?B?aGRvQVBtZTZiRGsxZWVGUCtZQi81S1NpRnU0QTB3cm9tVnk0NTlTVGE5MnUr?=
 =?utf-8?B?RXNJcm1hNGdBUXp2N0FtNyt6THBNZG5GOThNR0EvRmZFR1dCcDBsOG9Tenhr?=
 =?utf-8?B?NS9TaTc5c3dQS2NXb0phWkNmQVMxanJuU3pZNGUyNlZpVEZFOXl6dzlyYWZ4?=
 =?utf-8?B?aGMrKzRTcXVSQWJTSXdsSjRUdVpPWDdUaG03YjZmcmZFRzZrWUtpa3kzWDhT?=
 =?utf-8?B?SlBUakR1U0p3TUgrckdHNVU5ZWEwQ3dkblNlelU2Q29XaGk3QWU0Q1lra3BC?=
 =?utf-8?B?aS9QaEp4UkhCWHE5emFWWDRDVnVyd1lNSEFROTdEM0dxeVJlb2NUQnlpK0dE?=
 =?utf-8?B?S2UxeDl1YS9rMzdDSmVxWmN0Wlk2NGFjeGluU1I5Rjd3a0dQdUIrdGdKS3Ew?=
 =?utf-8?B?Q2p2S3B4ZHNUNzRwcTdWOEVDeVRxM25KdUpubno3TnFjajFVYW4yNFhXY2NV?=
 =?utf-8?B?V25pMnpvL3UyaDBtTUZxK0plYVZXbG12c25HZ3lUZVBURE1zcXh0RmtMKzUv?=
 =?utf-8?B?SzdTYlExTW5WdWd6Y2ZJWTd4dlEycVNSRUxBdHYwTFVkSHFnZHhaWFJQNVVI?=
 =?utf-8?B?NEQyaGRFVG9mOWlGWXVva0Jwdnh5RHA4Z3ppMzhCY2N1OFgwQ2NaanlrT01m?=
 =?utf-8?B?cVRmQjA1MWRNL3JjMCt3Sm5DS0dHQ1IzZ01Jd1Jwb3dORlo0Mkx6S0xVRXNI?=
 =?utf-8?B?S05HcWlmdXF3SUNWUk4wMm5rQndvME42ZHE4TFhBV0NuUWRaS2NESEhCejZ0?=
 =?utf-8?B?cGg5UnQycGd5U3p4NTVzaVUzeGJWZVdCZmExVWRLUXRjL0ViQktvL3NDUnBD?=
 =?utf-8?B?Vkp4eTZJdnVCNWc2VStGZk4wL0lTamtwMUs2cmM5K3cvRENGcVJta3ZWOFln?=
 =?utf-8?B?MDZ0TXhvVnRRU0FSdW15U0o1M1B0Si9JSlFIOExLcWtGVVoxRlAvb3VDM3Iz?=
 =?utf-8?B?WXNxL3VEcEpyakdQNnZyV2R3dnBIUEJ6a082LzVwZjNyd254WG9QTVJuckxh?=
 =?utf-8?B?aG1HbDh1b0gvRHlLM2lmQ21pOUtpTUFrNmM4bkc0a2RtbWhrbGJnT29pZ1dH?=
 =?utf-8?B?WlNOZTB1U3d3WjhXcVJHVSszWGM5aXZSQTlFNnM1ZWRJV0hKTEptdDVYLytw?=
 =?utf-8?B?dzM2YTdrZlRHM3RFeUdoM0R5dGp0UFlPM0RrbEZURjNRczh3dGV5eFVpN09K?=
 =?utf-8?B?RXZLeEJaaGpjd0p0ZC9jL21YQjRON2tNSVdmcHVPeFRnWUUvMEtONlFpZjBn?=
 =?utf-8?B?VTlEODZqMHRRNmtPUnhCTit0TytJQ0MxT3RxdUZROVlNZGlnK1JrZnFtY2xU?=
 =?utf-8?B?cHRaUEpZdFNSdWxxQS83M3JuK3FvUFhJZElmUksxWjB4QnRyVlg0by8wWnFN?=
 =?utf-8?B?VVhlbFRtMFgwY243QnpuWDk3RGVEMzBBNkoydzB2cnR3SmVIc2NyTlBzQ1Rk?=
 =?utf-8?B?OTd1aGFNQ2NyN3FIUnBYYjhtVzluMkVzRjJqMTBvRFB6Qjg1UlZQYzhkbGxr?=
 =?utf-8?B?TmVuL3NJRTlvWW1kSVpSVGZQN2F6Z0RCSEFETG9QTHRaT3lLWXM4Um1jUWVs?=
 =?utf-8?B?cDJtWUVnc1FybDdoaEpvVFRxdDBZVUJVMzl5UHB6THVvcmtFb0tjVVFzM0F1?=
 =?utf-8?B?bS9Mb0ozUmhnT1MrRWZtWDA0TkdybS9DcFpZa2lhSUZIeWNhc1ZkNEpLUVJP?=
 =?utf-8?B?a2ltZHlZMGt3QWkxd2NBRzlkR3NoUW54SGJIWjArK0g3a0JKRXVERE1SYVgw?=
 =?utf-8?B?Tm9MVHV0VFY4b0QrazBramxFV1FFY0RDcGpiWHRhWWRhR3RuUGU1Y1VwWVNi?=
 =?utf-8?Q?lUO3SS5M0UO/ijU7nN4fVEI9q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdaad91-22a8-4b39-7187-08dccb2f221a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:10:47.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/qmjycFTMaBPnwCdsLwXSseZdJkyW/Hg/1MxWjKWTPgRZ2Ii7QAza+/OUXByfUgwp0n7qD15l3UadYK89nlcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366



On 02.09.24 10:53, Dragos Tatulea wrote:
> 
> 
> On 02.09.24 10:40, Cindy Lu wrote:
>> On Fri, 30 Aug 2024 at 22:46, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>> Hi Cindy,
>>>
>>> On 30.08.24 15:52, Dragos Tatulea wrote:
>>>>
>>>>
>>>> On 30.08.24 11:12, Cindy Lu wrote:
>>>>> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 29.08.24 11:05, Cindy Lu wrote:
>>>>>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 28.08.24 11:00, Cindy Lu wrote:
>>>>>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> When the vdpa device is configured without a specific MAC
>>>>>>>>>>> address, the vport MAC address is used. However, this
>>>>>>>>>>> address can be 0 which prevents the driver from properly
>>>>>>>>>>> configuring the MPFS and breaks steering.
>>>>>>>>>>>
>>>>>>>>>>> The solution is to simply generate a random MAC address
>>>>>>>>>>> when no MAC is set on the nic vport.
>>>>>>>>>>>
>>>>>>>>>>> Now it's possible to create a vdpa device without a
>>>>>>>>>>> MAC address and run qemu with this device without needing
>>>>>>>>>>> to configure an explicit MAC address.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>>>>
>>>>>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>>>
>>>>>>>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>>
>>>>>>>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>>>>>>>> match the one in the QEMU command line, it will cause traffic loss.
>>>>>>>>>
>>>>>>>> Why is this a new issue in qemu? qemu in it's current state won't work
>>>>>>>> with a different mac address that the one that is set in HW anyway.
>>>>>>>>
>>>>>>> this is not a new bug. We are trying to fix it because it will cause
>>>>>>> traffic lose without any warning.
>>>>>>> in my fix , this setting (different mac in device and Qemu) will fail
>>>>>>> to load the VM.
>>>>>> Which is a good thing, right? Some feedback to the user that there is
>>>>>> a misconfig. I got bitten by this so many times... Thank you for adding it.
>>>>>>
>>>>>>>
>>>>>>>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>>>>>>>> and now I'm working in the fix it in qemu, the link is
>>>>>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>>>>>>>> The idea of this fix is
>>>>>>>>> There are will only two acceptable situations for qemu:
>>>>>>>>> 1. The hardware MAC address is the same as the MAC address specified
>>>>>>>>> in the QEMU command line, and both MAC addresses are not 0.
>>>>>>>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>>>>>>>> command line is 0. In this situation, the hardware MAC address will
>>>>>>>>> overwrite the QEMU command line address.
>>>>>>>>>
>>>>>>>> Why would this not work with this patch? This patch simply sets a MAC
>>>>>>>> if the vport doesn't have one set. Which allows for more scenarios to
>>>>>>>> work.
>>>>>>>>
>>>>>>> I do not mean your patch will not work, I just want to make some
>>>>>>> clarify here.Your patch + my fix may cause the VM to fail to load in
>>>>>>> some situations, and this is as expected.
>>>>>>> Your patch is good to merge.
>>>>>> Ack. Thank you for the clarification.
>>>>>>
>>>>>> Thanks,
>>>>>> Dragos
>>>>>>
>>>>> Hi Dragos，
>>>>>  I think we need to hold this patch. Because it may not be working
>>>>> with upstream qemu.
>>>>>
>>>>> MLX will create a random MAC address for your patch. Additionally, if
>>>>> there is no specific MAC in the QEMU command line, QEMU will also
>>>>> generate a random MAC.
>>>>> these two MAC are not the same. and this will cause traffic loss.
>>>> Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.
>>>>
>>>> Initially I was testing this scenario (vdpa device created with no mac
>>>> and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
>>>> able to set the qemu generated random mac addres because .set_config()
>>>> is a nop in mlx5_vdpa.
>>>>
>>>> Then I moved to qemu 9.x and saw that this scenario was working because
>>>> now the CVQ was used instead to configure the mac on the device.
>>>>
>>>> So this patch should definitely not be applied.
>>>>
>>>> I was thinking if there are ways to fix this for 8.x. The only feasible
>>>> way is to implement .set_config() in mlx5_vdpa for the mac
>>>> configuration. But as you previousy said, this is discouraged.
>>>>
>>> I just tested your referenced qemu fix from patchwork and I found that
>>> for the case when a vdpa device doesn't have a mac address (mac address
>>> 0 and VIRTIO_NET_F_MAC not set) qemu will return an error. So with this
>>> fix we'd be back to square one where the user always has to set a mac
>>> somewhere.
>>>
>>> Would it be possible to take this case into consideration with your
>>> fix?
>>>
>>> Thanks,
>>> Dragos
>>>
>> Hi Dragos
>>
>> Thanks for your test and help, I think I can add a check for
>> VIRTIO_NET_F_MAC in the qemu code. if the device's Mac is 0 and the
>> VIRTIO_NET_F_MAC is not set. The guest VM will fail to load. I will
>> double-check this
> My request was to use the random MAC from qemu in this case. qemu is
> able to configure the device via CVQ. At least this device...
Also, it makes sense that if a device doesn't have a MAC set and
VIRTIO_NET_F_CTRL_MAC_ADDR is set then qemu can set a random mac on
that device. 

Thanks,
Dragos
