Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4025DC38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 22:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9423E41523;
	Tue, 31 Jan 2023 22:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9423E41523
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=iH+t4oV4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=DZV4ktRW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dA7q43fsLk1t; Tue, 31 Jan 2023 22:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE8C74148B;
	Tue, 31 Jan 2023 22:51:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE8C74148B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5ECCC0032;
	Tue, 31 Jan 2023 22:51:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F905C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A80760DE5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A80760DE5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=iH+t4oV4; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=DZV4ktRW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N7MvZF1-oj7C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:51:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C564060759
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C564060759
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 22:51:12 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30VIi74N014092; Tue, 31 Jan 2023 22:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jJ4KfvMfg90s+3rgp8QDwBjFaecMWDlKgD1dYRijtxM=;
 b=iH+t4oV4osCLyyO1aIiauhin7aBMaYh1W361y9VufsDVvIUT1jBKk5p4M4M5+uDHp6Ou
 DuusvFFL4yivqDdqkAZUggvIP1yqR139X39sZAYZmHP3dS4GXaUZzwwr+16FGAuO/NmG
 2eIZrZ2ntnInI8qTfRr/UI23Im6AJjNB6EXSl2qakbXYgo3Z7FQWgJHqJxvrMp6HzEzI
 3lpAqVq1mJQTUHq7UybCt3S+0Pyrg3YC012/zk7Vkm0FueFMpubo+ZjU7SZ8xF0DrBBk
 FIl9D/y3cKV9M8sNsb5Qusr21g/hY/bJZgjBlvx3/YTUnLaNHQXJVmuLUlgumDLUdc5L iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9xxrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Jan 2023 22:51:11 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30VLKZgK033984; Tue, 31 Jan 2023 22:51:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3nct56e8df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Jan 2023 22:51:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWDCgUPE48gi74UbcoGPxbdO5CXm841+Xaaudabyp6ftLfAMui8omdQoYapPQR19vIx1wo+dLoFb69x/pg2cIijeYX4n7iP1WiKqwB0tAHOeaE1R2Y6BG5eey89Zu5kRAIofgtEIwV1+hrBrzwFAydnRq3GXYMvFJ0TlpfZdi4Yw/MSSAlSODZr5B/imaZHnQdZI4vdhOtCZXn6liERColHX0gQH3hikIvjyKmg3hjRyguHWhabhY176zgXs9HtGXpvm3oc8w2NwNHxaU9moyKjIGqE91Pz2d9FR0WUQRQDlErOx9bn40D7nNvLWdHmQJnJ6EAeLaIUP2r2ee1iWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ4KfvMfg90s+3rgp8QDwBjFaecMWDlKgD1dYRijtxM=;
 b=gpleh3Jxad+u2+Z0tv/9xRn7UaEM3K7TGALRYo2YuACjDS4fV+XKdpP+t08wyhZmRE1IPQBvwTDT8ZgaUq+UEdi8LHKq9VkGqzCGm1tHcj7nAEQ76KRe4Ow00mJpu5tUqfeCr3mI2sRH/qE1+/nEAfCkiCxcfCJGN1KE6kgdkfhTy31TGrMum1CmvJqeFFw2tmHEIktiF8FMBBh7mCap3STrVbsylrMMear2hYt3EvOM+kDOdEfVU+KQHKOQY9QuS6oYw5S4XytzIqNDzxbfuZMmX4y44VW+kDJ0bv+JN2qf80cdWi+RbxnwBYP1e0itSajdwmy+811o3YvcgjHhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ4KfvMfg90s+3rgp8QDwBjFaecMWDlKgD1dYRijtxM=;
 b=DZV4ktRWNAMwqHXCP6EsbcIuf1G1HDP9iGF+B37wrqVFuh/3JsQEdbV8DG9vn+YHTU0XwNTI/tGfzo1sjBv6dimDbZGWY0yqbzgDqNw/OuXdhE08NCp8acqpAFZgUT6LuOA4rEHjL/flGx32WBeiiF8Qs1boPjvm31RO6h+T/n0=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB4639.namprd10.prod.outlook.com (2603:10b6:a03:2db::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:51:08 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%7]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:51:08 +0000
Message-ID: <d48c157e-73d0-17c6-85c9-8753643ed03b@oracle.com>
Date: Tue, 31 Jan 2023 14:51:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] vdpa: fix improper error message when adding vdpa dev
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 parav@nvidia.com
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-2-git-send-email-si-wei.liu@oracle.com>
 <07f5a4cb-2a55-c774-6b23-d3fa6605cb43@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <07f5a4cb-2a55-c774-6b23-d3fa6605cb43@nvidia.com>
X-ClientProxiedBy: DS7PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB4639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c532f54-6297-4088-4971-08db03dda40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJQg6FyajDfGkan2SbvDUFum90l+yz0949Ck9zKeIJ/zNpthp8ji3dhU7Lz1xFTH2+uPRd5Eyamnf34MDzlK8WjqFDNKj64u4eJcpr+X0Xe+n3Bor0yfJ9eutLwexAmmAjQaP5g1jDR9LCE9998CHgkr0MBCvVsglndoTcwVeZVEs0ZsD0BzJEIebHrcdnv7w/Hq9hQatpvGDoR968Xu4HZ+X64KRwCyLka+44dVU79uknmJRAv2PeZjX2DL7vG+P2pnfrvYcVReyFGwziczRjgtI5oqgPq+aHEJIwJNscUoeomc91TlrLppF18Q/Rd28rUmZqUz9DHnoGYou7eVir5ANBw2ZpXUcHOnO4UDfr7+01ILHWwSb+b4O2n7Cfs2gfaLSVJ1rYC7XU1IgMHo6eafM7e5NW3xeqJvs83JVqt61NYuaJyEQLanT5I18qRfamgWgsH8UTVW8nqenkjRVrdtGNaZFNYurbPiIu/0HPl+u+8TcJRJc0NkY0sE1tyW7Z0N4RO2ugcYTQHg71LpC90lWmF4JlZZ44xYmG2n53KGZA2SzfpmHr8X8zc2pL9X1JSIMCQohV/THe5beuba1y3jljZtk62PTcsAthFLwlYeqe++Tf0GTEjd69MArhzVyO9qCM5Pq7XyuSZMOSMV2aD0t+rWlG155Gl9i0iolGpnTlFmocUkVptwEUSHVoNgtyoR2XSI8rgD+mKK/EKHlxcfWr+XfCILkreefEIxkSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(4326008)(2906002)(15650500001)(31686004)(5660300002)(6506007)(53546011)(6666004)(8936002)(66946007)(36756003)(83380400001)(2616005)(26005)(41300700001)(186003)(6512007)(66476007)(66556008)(8676002)(478600001)(31696002)(86362001)(6486002)(316002)(36916002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEVHZlk2dXdZUllFS2pHRUhENVluVitGRmU0emJaNkFobm11NE4wbWJONHVk?=
 =?utf-8?B?ZUJnc3lRUHhmbGZtZmttTkNNTWtPQ09EeUlpVlJXTVozUDF3ZTFQYXduUUxN?=
 =?utf-8?B?b0JrNWR0MlU5L1JqWDZSVzk3WFp1TjN1V0xadXRJVE1IT2Y3QUJRS0lORkpa?=
 =?utf-8?B?VGNhTGkrcjZtMUV5dGRWRTNMWm1kWVJIQWc4WDdQQWtudTlwaldIVGtGUDhQ?=
 =?utf-8?B?Wlpua3pzeXdPaHBJbE5acWdibjdqcDRWRUhlMytsZjNYMElFdnRYWG91Y0hy?=
 =?utf-8?B?bnc3bk54ZFFNTVZNc09XODNNVi9iY0JjV1hMeGNpa3NINGJoUzJLd2VxK2d2?=
 =?utf-8?B?aFZZSVNLdHZJcnhrb0ZNSjh6dnNGOW95RE5sSU5uQW1TT1Ivcm1LMU5ibmpJ?=
 =?utf-8?B?dzZlWDU2ZllZRUhuazJxRlMrdmJSM01aOWJELzlkOFdnNEN0M3JFRGhoNG42?=
 =?utf-8?B?dTFkQmUrd1NSaW40SGNEYUN5VmlnRTEwdVMySXF0UTk3Wmh0bThXT2dGOWdl?=
 =?utf-8?B?VXo2cUozRjJmTmNYSFZTaTlweG5sR20rbGhhYUNRaVdUYW5DVzlncGthRlpG?=
 =?utf-8?B?anNET1d4VzE3VnNoOXppaHNMNGhjMmJVR2t4SFpWMXhtTnB4L1l6N0ROaVpK?=
 =?utf-8?B?Rzcya0ZMSE9JNmJvWHlqTzlhOUk0ajU1UmtvMXFtNWRyTWJnb2I5SDNSNWN4?=
 =?utf-8?B?N2d4bU9WTDBkTkI2enJabDU1NWoreEtUS0x0OEJuemhFa2NPbm10L0wra2tD?=
 =?utf-8?B?RjFQYmgyRURkSStNdU9oYjNlTlNMUVZKaXlabk5GS3hqaVVyazI4YVV5RWZY?=
 =?utf-8?B?RVMzSFNzTXI3NFB1NTRlSWoraWFsTDJtNGc4QnVMZ0QwQWdpeGxMMHFEWmVx?=
 =?utf-8?B?ejJ5Yk13ejhHTWJRZWVKUWJsa2VFN1J4d2FuRnQ0di93Ulowblc1eUxvVEJI?=
 =?utf-8?B?TnpCRW5LMUxHU1djTDFpajVHMTdKa2VrUys4d1RrUmx0akhGb3kyaEtZamdx?=
 =?utf-8?B?ZTg2SFFIcFY0dTJab01rdVNpWmQ5Wk5jQmhkMFZwem16RHJGaEpDRWJyaEJE?=
 =?utf-8?B?TEVnTE0vYmplSTZFV1hnU3IwQ3J6SHdENUNzQ294WGdwbVkrMGkxLzc3Ymo5?=
 =?utf-8?B?OTRaMklQb3EwV3Fib2EzemFhZ0ljenhIU3JoeDFySW5KR29XYStTSkc3aUow?=
 =?utf-8?B?dHBCcE1aaEQwWU1DenhWZk5aVGlYTjNQbXZTWDJTK0tNTnZkcGtZMlkrTGs0?=
 =?utf-8?B?bHdZbW90TW9CS3I1UVFOMTNvMlVlVythaVkyOGhVTCtkenk0YytuM2E1d1R1?=
 =?utf-8?B?eW9zR1ZGckdvT0tKUFY0NXJUOTNlTmU3bHcxRjRZb1ZMQ2Y2cERqTFV6U1Ru?=
 =?utf-8?B?TzY2T1Z3QnEwOUx5VHRKMHhVZE9jc2YweE0rSlJZc2RnSW16ZjduM25YU0du?=
 =?utf-8?B?bXRqMEIrYnpyUFhGSTd0MHYwRmlJZEIyTldCU1dndCtEeUNFTGY2YzQ4Tms1?=
 =?utf-8?B?ZWlsWjRDdjQxTDJpYm1zN2cxbm1QWkxsWHBmakc2OUhwWU4wN1hScWhLV3ll?=
 =?utf-8?B?Z2Zjb21JQWJaZGVjVWZoUzFXV1NTR1MyK2lDMGFTb2VTaGlyWksreW55eDFs?=
 =?utf-8?B?UVRiN2ZiUUFYeU00YUJvekpFdkhUUXhTcHV2MVdmQi9sT3EvR3huL29xM1ZM?=
 =?utf-8?B?cUJnNXNIdXlxQ0FJaGh4NTljTUJaVXFOSkw3V1JIdmFyZnlxSTJRUldWelR0?=
 =?utf-8?B?b2JyMXdFRWxzWFNpNUM5blRyQlkzcDhaa0s3T2JJYldrcVpncDIzNWRnRVVy?=
 =?utf-8?B?T015UTc2Z2M5b0lrNXVLNWU4TlU1MllIRUFPSW5LbFBrWXlRU0N6RFFyWnU2?=
 =?utf-8?B?MmJHaEM0UWNLanJmaFo2dVMraGhZaWpoK2xLNDJ6NlhERG5CUXNUQjk5d0VL?=
 =?utf-8?B?ZXRCbnJqbm9OZlJRaUV4SnRxYkxVSUFvRnR0Vyt2R3Z3VmNpYWV0N0hXTTlh?=
 =?utf-8?B?V000OGJPOTk3bzlJQ3RwS3dtbk1QSHNGOHNZM3hMbkYwYXNxYzZDbjQ4OUpZ?=
 =?utf-8?B?bW4zdzQ4SzF5U2FUYTBmd3g0bjNZdXFVUlIrMnhPMktmRVNOWkdyamxJemQ3?=
 =?utf-8?Q?IIvaxe2w/JHYbJc0ALMUIQgcC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l93HzhxY3NJ3cTZK8G7ddbXJ95tgeiznLZ5pVdbek7aXfat72+TiyhfZcr5LK8vbXpkNLXE396L6hmFHBJ4Vfl3JJNghtwF8Iqbs6xQyDF94+4qu3ExOSSSPFwy2HSmvuPz3dZHvSo8v0SsVRKDCLEflv4r8iEmMwvS2b7EYDqdg1/5PV2/bVM4NC0bqVpaET7HTZhXBxQI/GRP/Q7XGL63GTL7nv6TdSmipSFMguKkjlFEcrKl17UlU/RWjVOLI9Kkpk/8fcFcUTSoXf6HmJBZdGPfLqtAnWG2EmecEF7NfZ8xvhVWwmSrfEXlpSzl4SXZVeHHGCfAuGNWsaH3ClFwNFPrZyj/fnxLN1x0Jf+rM+izdFJQR5Z0FnsY9sn6axnLMcW3PYxpvn9N98wU0XugYJEcxjsMOfXFbHjFcOyOO0iGIXL3WwPhBSBMGGmJT8f6IVprtUD8WksaawDkp+CJIJW7hB/yCaEJhpcfulwnLZwe2CKdMyh/ZGt8zRWA8jEsV+gVWV994aD8Y63nelzIVf0aKvhyrFfMjL7dtUw6QhsAejU7zfGBNIOco0ag0HkgQHEEcK7lqejowA+Cr4oITyGadQbuiHgOEpSH0mv72pUF2e5ixToXiULBDt31w9O9JHXY8XxTiJu3DzXDYi5Lw/Oxklqx9XhBJcqUd9uMi/BmdacXzlR5Jmue2bT0zCG6Han7ViOMT29WV/WycgtrRk/vBclihng0AQGM+nNwMJZXe+Ve0l4dJ1odLt9dYVyzpswwqksd9w+PGKnoztQJAHWiaFWEFByTQNkXfS717qAAunNWD6gQs/x2uTqP9kVEaHR23MHNc4H0eMFa1fSnwr9bPHhSrwN/u+5gaQ3Rp3or/ldU7LSy6SWEj1ZL5kgqcfwV2anE4F39Qn6Qs6Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c532f54-6297-4088-4971-08db03dda40c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:51:07.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPSXFzidDLsOrjsAR+065a15qPNg/qtoX/anPJ0JQEfVE2pxuxQhWyWUkYDupO4ABqsxkJ8nDJ53uZT1/YNb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310196
X-Proofpoint-GUID: L4_AXiD_t9KdMT71gMi5Qg63Fv34RVyB
X-Proofpoint-ORIG-GUID: L4_AXiD_t9KdMT71gMi5Qg63Fv34RVyB
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CgpPbiAxLzMxLzIwMjMgMzo0MiBBTSwgRWxpIENvaGVuIHdyb3RlOgo+Cj4gT24gMzAvMDEvMjAy
MyAyMjozMCwgU2ktV2VpIExpdSB3cm90ZToKPj4gSW4gYmVsb3cgZXhhbXBsZSwgYmVmb3JlIHRo
ZSBmaXgsIG10dSBhdHRyaWJ1dGUgaXMgc3VwcG9ydGVkCj4+IGJ5IHRoZSBwYXJlbnQgbWdtdGRl
diwgYnV0IHRoZSBlcnJvciBtZXNzYWdlIHNob3dpbmcgIkFsbAo+PiBwcm92aWRlZCBhcmUgbm90
IHN1cHBvcnRlZCIgaXMganVzdCBtaXNsZWFkaW5nLgo+Pgo+PiAkIHZkcGEgbWdtdGRldiBzaG93
Cj4+IHZkcGFzaW1fbmV0Ogo+PiDCoMKgIHN1cHBvcnRlZF9jbGFzc2VzIG5ldAo+PiDCoMKgIG1h
eF9zdXBwb3J0ZWRfdnFzIDMKPj4gwqDCoCBkZXZfZmVhdHVyZXMgTVRVIE1BQyBDVFJMX1ZRIENU
UkxfTUFDX0FERFIgQU5ZX0xBWU9VVCBWRVJTSU9OXzEgCj4+IEFDQ0VTU19QTEFURk9STQo+Pgo+
PiAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHZkcGFzaW1fbmV0IG5hbWUgdmRwYXNpbTAgbXR1IDUw
MDAgbWF4X3ZxcCAyCj4+IEVycm9yOiB2ZHBhOiBBbGwgcHJvdmlkZWQgYXR0cmlidXRlcyBhcmUg
bm90IHN1cHBvcnRlZC4KPj4ga2VybmVsIGFuc3dlcnM6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVk
Cj4+Cj4+IEFmdGVyIGZpeCwgdGhlIHJlbGV2YW50IGVycm9yIG1lc3NhZ2Ugd2lsbCBiZSBsaWtl
Ogo+Pgo+PiAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHZkcGFzaW1fbmV0IG5hbWUgdmRwYXNpbTAg
bXR1IDUwMDAgbWF4X3ZxcCAyCj4+IEVycm9yOiB2ZHBhOiBTb21lIHByb3ZpZGVkIGF0dHJpYnV0
ZXMgYXJlIG5vdCBzdXBwb3J0ZWQuCj4+IGtlcm5lbCBhbnN3ZXJzOiBPcGVyYXRpb24gbm90IHN1
cHBvcnRlZAo+Pgo+PiAkIHZkcGEgZGV2IGFkZCBtZ210ZGV2IHZkcGFzaW1fbmV0IG5hbWUgdmRw
YXNpbTAgbWF4X3ZxcCAyCj4+IEVycm9yOiB2ZHBhOiBBbGwgcHJvdmlkZWQgYXR0cmlidXRlcyBh
cmUgbm90IHN1cHBvcnRlZC4KPj4ga2VybmVsIGFuc3dlcnM6IE9wZXJhdGlvbiBub3Qgc3VwcG9y
dGVkCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNv
bT4KPj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+
PiDCoCBkcml2ZXJzL3ZkcGEvdmRwYS5jIHwgOSArKysrKysrKy0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4gaW5kZXggOGVmN2FhMS4u
NWU1NzkzNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+PiArKysgYi9kcml2
ZXJzL3ZkcGEvdmRwYS5jCj4+IEBAIC02MjIsMTMgKzYyMiwyMCBAQCBzdGF0aWMgaW50IHZkcGFf
bmxfY21kX2Rldl9hZGRfc2V0X2RvaXQoc3RydWN0IAo+PiBza19idWZmICpza2IsIHN0cnVjdCBn
ZW5sX2luZm8gKmkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IFBUUl9FUlIobWRldik7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsKPj4gwqDCoMKgwqDCoCB9Cj4+IC3CoMKgwqAg
aWYgKChjb25maWcubWFzayAmIG1kZXYtPmNvbmZpZ19hdHRyX21hc2spICE9IGNvbmZpZy5tYXNr
KSB7Cj4+ICvCoMKgwqAgaWYgKGNvbmZpZy5tYXNrICYmIChjb25maWcubWFzayAmIG1kZXYtPmNv
bmZpZ19hdHRyX21hc2spID09IDApIHsKPiBJZiBjb25maWcubWFzayBpcyB6ZXJvIHRoYW4gdGhl
IGNvbmRpdGlvbiBpcyBmYWxzZSBldmVuIHdpdGhvdXQgdGhlIAo+IGNoYW5nZSBzbyBJIGRvbid0
IHNlZSB3aHkgaXMgdGhpcyBjaGFuZ2UgbmVlZGVkLgpUaGlzIHdheSBpdCBzcGV3cyBlcnJvciBt
ZXNzYWdlIHdoZW4gbm9uZSBvZiB0aGUgYXR0cmlidXRlcyBwcm92aWRlZCBieSAKdXNlciBpcyBz
dXBwb3J0ZWQgYnkgZGV2aWNlLgpJIGNhbiByZW1vdmUgdGhlIGNoZWNrIGlmIGltcHJvdmluZyBl
cnJvciBtZXNzYWdlIGZvciB0aGUgb3RoZXIgY2hlY2sgCnJpZ2h0IGJlbG93LCBidXQgdGhhdCBp
cyB0aGUgZXhwZWN0ZWQgY29uZGl0aW9uYWwgaWYgdGhlIHNhbWUgZXJyb3IgCm1lc3NhZ2UgaGFz
IHRvIGJlIGtlcHQuCgo+PiBOTF9TRVRfRVJSX01TR19NT0QoaW5mby0+ZXh0YWNrLAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJBbGwgcHJvdmlkZWQgYXR0cmli
dXRlcyBhcmUgbm90IHN1cHBvcnRlZCIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gLUVP
UE5PVFNVUFA7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsKPj4gwqDCoMKgwqDCoCB9
Cj4+IMKgICvCoMKgwqAgaWYgKChjb25maWcubWFzayAmIG1kZXYtPmNvbmZpZ19hdHRyX21hc2sp
ICE9IGNvbmZpZy5tYXNrKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBOTF9TRVRfRVJSX01TR19NT0Qo
aW5mby0+ZXh0YWNrLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJT
b21lIHByb3ZpZGVkIGF0dHJpYnV0ZXMgYXJlIG5vdCBzdXBwb3J0ZWQiKTsKPiBDaGFuZ2luZyB0
aGUgbWVzc2FnZSBpcyBuZWVkZWQgYnV0IG1heWJlIGxpc3QgdGhlIGF0dHJpYnV0ZXMgdGhhdCB3
ZXJlIAo+IHNwZWNpZmllZCBidXQgYXJlIG5vdCBzdXBwb3J0ZWQ/CklmIHlvdSBjYW4gbGl2ZSB3
aXRoIG51bWVyaWMgcmVwcmVzZW50aW5nIHRoZSBhdHRyaWJ1dGVzIGluc3RlYWQgb2YgCnN0cmFp
Z2h0IGF0dHJpYnV0ZSBzdHJpbmcsIGNlcnRhaW5seSBJIGNhbiBkbyB0aGF0LiBPciBlbHNlIEkg
YW50aWNpcGF0ZSAKdXNlcnNwYWNlIHRvIHF1ZXJ5IGFuZCBmYWlsIHRoZSBjb21tYW5kIHJhdGhl
ciB0aGFuIHByZXNlbnQgYXR0cmlidXRlIApzdHJpbmdzIGluIGtlcm5lbC4KCi1TaXdlaQoKPj4g
K8KgwqDCoMKgwqDCoMKgIGVyciA9IC1FT1BOT1RTVVBQOwo+PiArwqDCoMKgwqDCoMKgwqAgZ290
byBlcnI7Cj4+ICvCoMKgwqAgfQo+PiArCj4+IMKgwqDCoMKgwqAgZXJyID0gbWRldi0+b3BzLT5k
ZXZfYWRkKG1kZXYsIG5hbWUsICZjb25maWcpOwo+PiDCoCBlcnI6Cj4+IMKgwqDCoMKgwqAgdXBf
d3JpdGUoJnZkcGFfZGV2X2xvY2spOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
