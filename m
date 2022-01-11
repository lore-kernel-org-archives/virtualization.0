Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB26C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 22:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4713E83EA8;
	Tue, 11 Jan 2022 22:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ARA_5F7YX2UJ; Tue, 11 Jan 2022 22:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A33C383E38;
	Tue, 11 Jan 2022 22:15:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75513C002F;
	Tue, 11 Jan 2022 22:15:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1DAC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 22:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0076940912
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 22:15:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="DxgEHUMo";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="m1x6usVi"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ciFBcKMHHxG1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 22:15:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C587540132
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 22:15:02 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BJO5Fk019138; 
 Tue, 11 Jan 2022 22:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2E8iu+0ek5zXC3BR+MwWlv1g+3HmP+kxrFlXlg3sDdM=;
 b=DxgEHUMo6WuS+zp3opL/EXGJ/gMxYIUVjSr/g/E6Qc8urf3Mf26NfWSBIG9zo1k60ho5
 5AgXwaSqbS+hFOE6wAZg8QiOxnKNTjELjI5YO4IoILtMOJODLMLWtHsGkHVL5WcJejT9
 JevJA6iJ02igJPfK01D9AEnw+mRmKzkN6RSJdzC5NpLlJFtvLivqj2Rt9da1F97UoJSv
 L0Ha5amTLm3N5N1s1h2hlfygIaOny+DP66xYzpqg48tKgnx4NPc+3MBn4b4hOq3Z3Hv8
 B093vr04T648HzCfMQ+hfDR4bY43rfbxuil5SDvWfqaT7Tiffh0FOMC9VadmlCoymaHg kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nmbv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 22:15:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BM5dcG158968;
 Tue, 11 Jan 2022 22:15:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
 by userp3020.oracle.com with ESMTP id 3df42nfjjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 22:15:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUUSy7V4Cp3yxLwOi5ffc5JDD/ZV3iRbYSB7JCpVeZ8RUzR0P8xhdwUp7otTtTJwM6SELTy+Xtb0pOtP7qmnXKNIzbKGBXAa+mm8CpbgTMVJRX0gYQLfdZSIt0w6YUSciP1uralTqvhqCdG++eZX6B+tGHX7mCInQT4Iq3IQXYsva67g6u8kyck5tMc75dzM0TQMCdvEMfx9lc0j/nXObwdSd2G2VR0W9TTMRjHqOcR+ssr3k1vaxwfCKCx90jDlKyTQrBdEqspscksF3oKuXxoFkM517Hv0GSxeJVTHVZNG6FFJcpFgMDCEQyDN3pGhSMGPbXULfhO/y06bFOYkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E8iu+0ek5zXC3BR+MwWlv1g+3HmP+kxrFlXlg3sDdM=;
 b=d+nwPnLzUEkm+5zgaXjEAcL5IukdZ/UFqDG+u53CeSW/O7ap5Z3zIHiIYFkvz/KH7lvBBephMQX5xzV1c5Tz9nPS/T7TL+cg/EQZ+i4Wbnbs8X/5B3z5JI+5YJ3BIL1Tws3hPW/HhIASSRxZy+Rxq6avKQwx2PPKkMl92VU9vzejdgP8QU4BKtNNZ3fKju6tK2zsfO3vks0DYQTDBgJDSTV7EEBTyvpTsSn9prOIyZoWlEKbf3vnjKSNcr1RnUyqhZHe7OtGrfYt7LOS3KQELxkc5jsSZ0Vvj3pIIYmLA+uOm6TENVlVi775On6bHJPk8EbKSZOGwyELi6Y+TB82TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E8iu+0ek5zXC3BR+MwWlv1g+3HmP+kxrFlXlg3sDdM=;
 b=m1x6usViFNEwdZAhj/E6IqAbSGikCwJNN3HyOOa1vC6gQtTtsDjENk5jtgNlFjZGDDz1viDYgk01CCemSodMGLPhyYPQJM5wMdFKuoAGSJQ8qjssYxfcKbx5ViOhJKtFZaxPdTQNJLtuQ3JwFfNCSP/8U9BFghrH4m6pBABzxSU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2582.namprd10.prod.outlook.com (2603:10b6:a02:ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 22:14:53 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 22:14:52 +0000
Message-ID: <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
Date: Tue, 11 Jan 2022 14:14:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/4] vdpa/mlx5: Fix tracking of current number of VQs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220111183400.38418-5-elic@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:806:125::19) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90ec239b-179c-4a6b-be90-08d9d54fca92
X-MS-TrafficTypeDiagnostic: BYAPR10MB2582:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2582BE405DFDBC8C433489A5B1519@BYAPR10MB2582.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9RvtiV5sk7SiCoVVWPk2G9RgskrCliHygPF0eOlzYK82QKw9A2JyX1jhqJeV6Mv1ZfOPUTryulgdgbb3P9QAAvy6ZNlARNrElILSFEajKZ/v7vGg/Q9R+uik1r8MdMzd+21PUWT2eS9breCj0PFcxo6zDCIL6OUlvz/H78Zqjfp4V3UovFyj0ieh/+Xs7s7QMjy8IFMFZ2Fl8gFn+c+vpd7+rvK7B9ac6a5WxzQzpfhTaY7SmijDceD61SynIg+6muzuck0owkTkHBsvCa1nzRBWfOxfjprr6VHYp46GHmshRV019hRmFcWH5SUQUCWHMpcb1j8I0icc/DEOQ5axyD3h9sgE2gUdQEgxbo0sw/4zd7LRMaqlw1AEetq900tpbv0rGwaOMlQT0Eq5zASDy30lE2UEo7jGIhB0BVL3JEUYn7BCEa9i9ffoNiSMvDdPoijnluwGYlPCz1JVeNcTV8xXYADb9RVizhlG/u4fb84PE09h1Feygz9xefB3Q+9TcMRCdJNx/PMpJukGPqTpTj2djtLCVFcask6egc4F3846QcQp55s8O6yHDZN4R7nxhBVdFHYqtYAkyN1UtpttwYTOLh5mDtyCFbM/g1AcSkCH0hYK2d88P6x2AgEcF/uUYO4CQVSsUu+lUSkDTnPdPAaoA1KT78uZ3iwpxCjZYAoVW6OLHicue3IC2NFVnNw1/SzhninhhcW6IroqeSLrN820Mwn1XplrHQcCNBW4S4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(26005)(66476007)(8936002)(36916002)(6486002)(66946007)(86362001)(36756003)(6506007)(53546011)(31686004)(5660300002)(4326008)(38100700002)(2906002)(316002)(508600001)(66556008)(6512007)(2616005)(83380400001)(31696002)(6666004)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlU3WldoWU50SU9LM2pzL1cxdVBIaSsrMDNWL1pacjRkUnkxT3lTVWRycHIz?=
 =?utf-8?B?cm0rb2F6ZjFLci9zYjhZMTF5WWxmQXdJKzNVRlZmbWIxdnRFaVhhbDJLOTd0?=
 =?utf-8?B?VHZxZzQ4aDBMTTEydTM2TWpsaFBtVkoyNVZ5WTFrM3BmVkxoQjFxUkFOZWhK?=
 =?utf-8?B?bEZTakxPazJlS2FIOS9ySFhoZUQxSW1ndEhVTG0rL0VnVTk5SHlHRjY1Y0l1?=
 =?utf-8?B?WE42d0piTUl2K3NIV2NPNExpRzlnSnNBYzBQWEt1eWoxK01PVjhHTzMrWi96?=
 =?utf-8?B?SHl3UHgxbVJIZE9oWlptaitpc1FsYjB0Sm5HS1FwS1Nya1pFeTJSZGQ1MTVS?=
 =?utf-8?B?Yy9RbkdkRmlkRWk4ek80RTMraVU4ZUlGSExUWEFIRkJhNGdweGVPcTdvSHNK?=
 =?utf-8?B?dFFiWEordEllLzRPUHVkaTlIZFFGeHEwNEtUWmtoOHZaL0NXcHFmLzI1NWlG?=
 =?utf-8?B?ckJOY1g0RkhJRmVPVGFTZGk0NTlaaU9xT3NHTXFISzFPZlFPcGVQQkJnVVZF?=
 =?utf-8?B?eHRyRnpiYXd0ZHJjd1lrL05iallPUElRMDE4S0lHNGd0S2tqT01pOGRUb2Fv?=
 =?utf-8?B?bWhxSWJ5UmcxMitHYnFlQ0RhVG1zbnllYzIzWS85NlNaanVNRXJzNGRqUEFv?=
 =?utf-8?B?cUpOY1NNM1JUdW1wbk5qVVYxRlBycUozejZtZU5CRDlOU2NnTEEwZURCTS81?=
 =?utf-8?B?OVBHNVVBT2xZaHZDZVp2d2xpQUdwOW0xZGE1WXpRSGNQQWVoNk1WWXUrcjg1?=
 =?utf-8?B?VlBRcUd3eWJ1WW1hQ1RFTUI3YU5rbUVnSzllY3p4SUVBcUx1QnZNdG5RUlJN?=
 =?utf-8?B?Y2Y4RVczWW1ja2tlbkE2MTdIU2l0SFZxTE9FeDgvRjYvZFFpQnltUEwvdDFJ?=
 =?utf-8?B?a2lONkxNNi9KUHIyeGRiNCtvcU8zZDNXbFdQU1hpZjNHMGk1Z3lHbkF5Rm5i?=
 =?utf-8?B?ZDBkcFAyMytXVW4xZEsxdVpTanlla2RIREJkamQxMUNUemNqZjJDVHVhdHZq?=
 =?utf-8?B?djU0MkkwUmoxSjVnekFrSG9aYmNVZmt5NWVxK2k5dENEcUZMZEgyRldCcTE4?=
 =?utf-8?B?b3VMZmsyL1dJZnhyY00rZFFBR1kzL2Q5YWYydno0K0lVVkpuNVloRmROL25q?=
 =?utf-8?B?MklZOUlibU1GczliVk5aeXdXNDdITGxzYU8zeGh3T0RMNW1rZmt4YjlHa0sy?=
 =?utf-8?B?L0ZJQ29nejczcFR6TG9DMGVjeHNiMk95dVJGakY2NEduTHV4T0NQeFkxR014?=
 =?utf-8?B?ZzNEejZ0YU5aQTNrcDQ4aTBsUmsvcDA5N1ZSdENUV3pXUUljNExSNmxqY1lQ?=
 =?utf-8?B?UGxLWHBnNXBuT3VUNDZQc3ZTSzI5T0ZNZ2tNMzF1NXd1ZFdDYk1VaW5VSkNT?=
 =?utf-8?B?R2J1bFMvQjJzWXpPVzVSQ2hZMjBuMzBhNjM5OXpxRGpvNGlkUUtHRDVSd0d2?=
 =?utf-8?B?Y3l4QUxzdnpFZ25lajZNSnNpSzBScmFSU29Xc0JQZ253QkhzMXgyM2dVTDB6?=
 =?utf-8?B?NC9rR05idEEzL2pVaVNlVFFqalBMTURCc1hxcSsyL3hBdlp5ZER6RTkzUGpk?=
 =?utf-8?B?Znh0YWFrb1daR2dBOVh5TlQ2QkNrL0NObm5EN0dhcTltTXVKVnp5Zlg5Z0xQ?=
 =?utf-8?B?MDdKSzh1Q3JodkdsNmwzbW8zYWZZM1hrUVNsUzErN3N6SzdLMlNBbGpwS2Vs?=
 =?utf-8?B?Qng4aG9UZDM4WUxlcitTTldRb3NJSmF2NVlCN3FqcmgrTTBlWkh1REc1ZWUy?=
 =?utf-8?B?VSt3czBJZ2hFRE9pVzdHWjJHZGdKUm1PZzdVQjJzOU5DRHhzUGZ6djVES05M?=
 =?utf-8?B?UG1PRHNuYWZVUVM4VFBPbzMrcmtKcDhjVERaMGRyVUhWUHhUazlvQU5NTitB?=
 =?utf-8?B?WERzSVc5UHF2N0c3ZXV1MFhJOEcydWVPclJzbzhFNjZ0K1ovVHY2VWpSODdJ?=
 =?utf-8?B?ZkZlR0JoTVd4bHo5eEJReldlQklObjRkZktGejVVdTNOREh2anFFYWR5OTJF?=
 =?utf-8?B?NHdPNWxsYTRCUFQwNFhQUGVUN29kcU1FRHloZmhHWDhwUExac0hjR2QxalRS?=
 =?utf-8?B?RmZlb1hXRHhveDhiOHFQRTBtbnFmTGZDVi82TGF0WkR5cWlsSGVwTWRySDI5?=
 =?utf-8?B?eElWSDZDL1dzQ0g4UUZKTkVxVlZmeGNJSWoxK01Pa2RxeG1NRy9UZTVPOU5v?=
 =?utf-8?Q?ef9xHxaWlONurEY9dJOUyew=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec239b-179c-4a6b-be90-08d9d54fca92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 22:14:52.9258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjXpuQNpUn7Oy2lc3ZuY/ou8h70sEXAMUVTLBJfzXe4U3ZjbCJm9RFv81QZIqUfvwqqXqXEWHB6iqIlXoGNpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2582
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110116
X-Proofpoint-GUID: PZp6ICOwCHkvEPDUS_ZNKKeNm-dwtleE
X-Proofpoint-ORIG-GUID: PZp6ICOwCHkvEPDUS_ZNKKeNm-dwtleE
Cc: lvivier@redhat.com, eperezma@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxLzExLzIwMjIgMTA6MzQgQU0sIEVsaSBDb2hlbiB3cm90ZToKPiBNb2RpZnkgdGhlIGNv
ZGUgc3VjaCB0aGF0IG5kZXYtPmN1cl9udW1fdnFzIGJldHRlciByZWZsZWN0cyB0aGUgYWN0dWFs
Cj4gbnVtYmVyIG9mIGRhdGEgdmlydHF1ZXVlcy4gVGhlIHZhbHVlIGNhbiBiZSBhY2N1cmF0ZWx5
IHJlYWxpemVkIGFmdGVyCj4gZmVhdHVyZXMgaGF2ZSBiZWVuIG5lZ290aWF0ZWQuCj4KPiBUaGlz
IGlzIHRvIHByZXZlbnQgcG9zc2libGUgZmFpbHVyZXMgd2hlbiBtb2RpZnlpbmcgdGhlIFJRVCBv
YmplY3QgaWYKPiB0aGUgY3VyX251bV92cXMgYmVhcnMgaW52YWxpZCB2YWx1ZS4KPgo+IE5vIGlz
c3VlIHdhcyBhY3R1YWxseSBlbmNvdW50ZXJlZCBidXQgdGhpcyBhbHNvIG1ha2VzIHRoZSBjb2Rl
IG1vcmUKPiByZWFkYWJsZS4KPgo+IEZpeGVzOiBjNWE1Y2QzZDMyMTcgKCJ2ZHBhL21seDU6IFN1
cHBvcnQgY29uZmlndXJpbmcgbWF4IGRhdGEgdmlydHF1ZXVlIikKPiBTaWduZWQtb2ZmLWJ5OiBF
bGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYyB8IDEyICsrKysrKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMK
PiBpbmRleCA5ZWFjZmRiNDg0MzQuLmI1MzYwM2Q5NDA4MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiBAQCAtMTI0Niw4ICsxMjQ2LDcgQEAgc3RhdGljIGludCBjcmVhdGVfcnF0
KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICAgCWlmICghKG5kZXYtPm12ZGV2LmFjdHVh
bF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01RKSkpCj4gICAJCW51bSA9IDE7Cj4g
ICAJZWxzZQo+IC0JCW51bSA9IG1seDV2ZHBhMTZfdG9fY3B1KCZuZGV2LT5tdmRldiwKPiAtCQkJ
CQluZGV2LT5jb25maWcubWF4X3ZpcnRxdWV1ZV9wYWlycyk7Cj4gKwkJbnVtID0gbmRldi0+Y3Vy
X251bV92cXMgLyAyOwpOaXQ6IHRoZSBpZiBicmFuY2ggY2FuIGJlIGNvbnNvbGlkYXRlZAoKPiAg
IAo+ICAgCW1heF9ycXQgPSBtaW5fdChpbnQsIHJvdW5kdXBfcG93X29mX3R3byhudW0pLAo+ICAg
CQkJMSA8PCBNTFg1X0NBUF9HRU4obmRldi0+bXZkZXYubWRldiwgbG9nX21heF9ycXRfc2l6ZSkp
Owo+IEBAIC0xOTgzLDYgKzE5ODIsMTEgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2RyaXZl
cl9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiAgIAkJ
cmV0dXJuIGVycjsKPiAgIAo+ICAgCW5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IGZlYXR1
cmVzICYgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzOwo+ICsJaWYgKG5kZXYtPm12ZGV2LmFjdHVh
bF9mZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01RKSkKPiArCQluZGV2LT5jdXJfbnVt
X3ZxcyA9IDIgKiBtbHg1dmRwYTE2X3RvX2NwdShtdmRldiwgbmRldi0+Y29uZmlnLm1heF92aXJ0
cXVldWVfcGFpcnMpOwpIbW1tLCBub3QgdGhpcyBwYXRjaCwgYnV0IHRoZXJlIHNob3VsZCd2ZSBi
ZWVuIHZhbGlkYXRpb24gZG9uZSBpbiB0aGUgCnVwcGVyIGxheWVyIHRvIGd1YXJhbnRlZSBzZXRf
ZmVhdHVlcnMoKSBmb3IgVklSVElPX05FVF9GX01RIGFsd2F5cyBjb21lcyAKd2l0aCBWSVJUSU9f
TkVUX0ZfQ1RSTF9WUS4gTWF5YmUgY2hlY2tpbmcgYm90aDogQklUX1VMTChWSVJUSU9fTkVUX0Zf
TVEpIAp8wqAgQklUX1VMTChWSVJUSU9fTkVUX0ZfQ1RSTF9WUSk/CgpvdGhlcndpc2UgaXQgbG9v
a3MgZ29vZCB0byBtZS4KClJldmlld2VkLWJ5OiBTaS1XZWkgTGl1PHNpLXdlaS5saXVAb3JhY2xl
LmNvbT4KPiArCWVsc2UKPiArCQluZGV2LT5jdXJfbnVtX3ZxcyA9IDI7Cj4gKwo+ICAgCXVwZGF0
ZV9jdnFfaW5mbyhtdmRldik7Cj4gICAJcmV0dXJuIGVycjsKPiAgIH0KPiBAQCAtMjIzMyw2ICsy
MjM3LDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2KQo+ICAgCWNsZWFyX3Zxc19yZWFkeShuZGV2KTsKPiAgIAltbHg1X3ZkcGFfZGVzdHJveV9t
cigmbmRldi0+bXZkZXYpOwo+ICAgCW5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7Cj4gKwluZGV2LT5j
dXJfbnVtX3ZxcyA9IDA7Cj4gICAJbWVtc2V0KG5kZXYtPmV2ZW50X2NicywgMCwgc2l6ZW9mKCpu
ZGV2LT5ldmVudF9jYnMpICogKG12ZGV2LT5tYXhfdnFzICsgMSkpOwo+ICAgCW5kZXYtPm12ZGV2
LmFjdHVhbF9mZWF0dXJlcyA9IDA7Cj4gICAJKyttdmRldi0+Z2VuZXJhdGlvbjsKPiBAQCAtMjY0
MSw5ICsyNjQ2LDggQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9t
Z210X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgCj4gICAJbmRldi0+bmIubm90
aWZpZXJfY2FsbCA9IGV2ZW50X2hhbmRsZXI7Cj4gICAJbWx4NV9ub3RpZmllcl9yZWdpc3Rlciht
ZGV2LCAmbmRldi0+bmIpOwo+IC0JbmRldi0+Y3VyX251bV92cXMgPSAyICogbWx4NV92ZHBhX21h
eF9xcHMobWF4X3Zxcyk7Cj4gICAJbXZkZXYtPnZkZXYubWRldiA9ICZtZ3RkZXYtPm1ndGRldjsK
PiAtCWVyciA9IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgmbXZkZXYtPnZkZXYsIG5kZXYtPmN1cl9u
dW1fdnFzICsgMSk7Cj4gKwllcnIgPSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJm12ZGV2LT52ZGV2
LCAyICogbWx4NV92ZHBhX21heF9xcHMobWF4X3ZxcykgKyAxKTsKPiAgIAlpZiAoZXJyKQo+ICAg
CQlnb3RvIGVycl9yZWc7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
