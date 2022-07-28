Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C259FC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 21:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C3D44173B;
	Thu, 28 Jul 2022 21:48:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C3D44173B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=1Gj1KU8o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=UcHibRs1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d83lLnPGxq_s; Thu, 28 Jul 2022 21:48:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B7D041732;
	Thu, 28 Jul 2022 21:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B7D041732
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF763C0033;
	Thu, 28 Jul 2022 21:48:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CC5EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53309404A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53309404A9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=1Gj1KU8o; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=UcHibRs1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mEIrCF3uE00p
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:48:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47CB9402F2
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47CB9402F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:48:46 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKIkwD021661;
 Thu, 28 Jul 2022 21:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=GKcQt0tQwsmsV4yN+3a1ey08wq7Iun7alwnmW6ELgZY=;
 b=1Gj1KU8omBoCVMgG1IC5iq7vjOI2IGwTMA6RBEenG2kolKritZVBRUEzIUV36/EOonUS
 HPrYKRFWVbfY6MB57Y9EkFz6JFbnuEz5fnRXIobszvkcKvDtCsiKrGRPG2D1BhdaVyJ1
 eLjzZvhoxpTYRmxG6mrRlT6yzQXo1RO5TAi3OO5uNVKoG4Z0APhU9ANqJ61yX9iAGrdy
 evyTJ2/b1i4SyHSwqKyUDfjwrEskluIVMO0otljsi95ZnGFKfQV6VkRraYtavIZQD9JL
 JxV/FiLuG9KIA7f7Hw4OMo7ZN7/czF4I6QQM4h1DfYNf13kpJfpBmLl82anZ7/9Fb+n+ 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9nwfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 21:48:41 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26SKghCn016627; Thu, 28 Jul 2022 21:48:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh653qu08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 21:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDgogyq7/E//ChoECdjXOwClaMnHDhCq3cuC84nsNTzUpdxwsujAgLd40puBvMV6IueSP+6RIAiR62eYZ2yetpDoIdQ4cbpn3dciV3EnetVt4DjTU5HMYAWUruvBBjg/etU0/79K8/B2IMgqZgjdqjz/IzEH4m4KbklQpAuWukci+ziwgrY6yNx2ZbNDVrkOZx03bvFLcPfxZoDJIeofBFrO1SxvNFb8dtOFUEbB1AH8E9UsaLwbCF/PPUbD8TK/uJcNTQQhLOXppMfhTquBauXKkWjVoFOFQYqz6tDhzVDLj5bQkFJahW0T41XA10g7V7DFcdb6vMB8XUKUAWmwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKcQt0tQwsmsV4yN+3a1ey08wq7Iun7alwnmW6ELgZY=;
 b=VqMXnaUOraxiUvPV7jfDK2yi8o82Mox0sfD+hk01flqzfbsH2yiGVM6er2V+q2PY9pX8OZQM2GWTojP2uhS3c/wd5pT/Ej4d3xIuTQlsnJz4bI5iBDDdsk3gTRHllcAXSVP+gmpqfZJzb0S48T7tPh0FuT9wU59pH5ND/OWrwymYrmGDz09yNOk9vfV26DdFlad9bNAxZbcXBaVdoBtqdq21pXzyOCk4PfyR/E2wV14mJGW3Cg54irGqCtMStjit/Dp2SGiPNzRNzP24C1kgje9cBooW1W+1R5O6ERqe1/d6XXlRNWjc7RknduK6YuBIDJSpfi0VdA/xLmQO48b7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKcQt0tQwsmsV4yN+3a1ey08wq7Iun7alwnmW6ELgZY=;
 b=UcHibRs1bdDyEJ7tSNvaBw9OU9nNClux2+OIa608awBfMVs3HgEuDK0N2hTHeJLz3upB9jLsRRFy/T5ZnChz7Ymy0uc0Q3BubOXEEyJUXk2O9UdfoW1obt5ax8u4f+UFKU29YSHAru8fX7Fx1dIa5Go423KwmSHzf7Z7jS5zxHk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SA1PR10MB6296.namprd10.prod.outlook.com (2603:10b6:806:253::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 28 Jul
 2022 21:48:37 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 21:48:37 +0000
Message-ID: <b58dba25-3258-d600-ea06-879094639852@oracle.com>
Date: Thu, 28 Jul 2022 14:48:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com>
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2b98fba-6690-4af2-654e-08da70e2ed73
X-MS-TrafficTypeDiagnostic: SA1PR10MB6296:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI54EKvmUpsp7q+hxBUXMkAwlB/YD2brldGjMccHzM7N9m8LSaAJtSDKshgvdD0fmjv9DoVQHR9QC9cukhZua4ncQcZw/1wJ6X6xPSStxJkgeUf0nqSmfilhWYgCSBoCbKsiHYJewjmQ34rZUKIa5aQs5KoDz4kESR5mm1t+MgpBNlarIqQbzNMmAAouy+xdTgiC3V8PkDHIYVZTYzDgLsSjravkr8FKs6AgqCOKkOWpJre6w65bPnBSMW7lv7GVfq1RhUZLAjKSyn3iYemtfc/MkNyHUkKPWSxrYcbDr1RwBAc0/1s0xMtSlsqWKp80CdV93BGfpdibJ5KExEu8nm7LNGkj+kX9PisdgLRYuxGSykr64IKmYCDprDv2fZId9uGapFS9wy/xB1Zx5ZRAy+V39PmUCuWw1Jtyp/7pJDkNv5jnIrNkB2G2DxShJRL8FYv2VEVV0mc9PfK+WEYV29l+0wIQKqChcbWV4BI+8X9CQfUDxl/QoMqkFO8zS3u+6O4JttYX8j/INSTVZ1vtB5SPY5w0XGPXI2fJxNZAuXPvAcC9IMOSTu0rSuVAkYuook8yRZDD+9W7NEtDPitLDJh8SMNLJueT+JYCrJnCFDXApilFwf4aPBG5Kde76fH+n6ddEFAo3ciIHx++gg677qCwQ3ch8831OryH5R/EuePOvHPOPcNVCzYTtbiedHPr1M/s/GSBBMNlPK0kodWapsVZExJVIQwz6NHUruArjPPrFdi7cDMbHrOZiDBMj8YLLdC0ApsMgmkOdEckvBAku466/BRZghB1pGg6H8HD3ldo77GSvhILBpD1UzZXxvxZ5QHg8LNA+78j6oTWx10+7oGMcUoaJZvYJm/Tf9NoCzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(366004)(376002)(346002)(136003)(396003)(2616005)(6486002)(166002)(41300700001)(186003)(110136005)(83380400001)(30864003)(38100700002)(66946007)(6506007)(31696002)(54906003)(8676002)(4326008)(316002)(66476007)(966005)(6512007)(8936002)(53546011)(86362001)(66556008)(26005)(33964004)(2906002)(36756003)(36916002)(478600001)(5660300002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpoNFZBcUdPYjdTVi9CaDFPanNGbkpHaHNCNEJtL2ZnQTJsd3NJaWdRVUlZ?=
 =?utf-8?B?STZmdHoralZUWHZXMWxjd0lBK1RGaWNrcXZEdWgyM2l1ZjJhSlltWlM5R1Y0?=
 =?utf-8?B?Z3NQL1c3L2lzWVN2TTc2QTk3RG1yc3JJRTRtZHdBUGJpU0p6c1A3YjF1UG0r?=
 =?utf-8?B?dXJKQjgwSk9ldG1zdU1zeHFvazh1TCs1QjJkdUt3N0lGVkl4NlJRaFNQZERY?=
 =?utf-8?B?akR1djhaTFE1Qm1la293SjhFcldQS1RSbDNPOFhFK0tGNXp1V0hBRW1tYWlI?=
 =?utf-8?B?T3VoVzdjVFRUL2N5V1E1S3dWbHpWcnJrZ3FDTWZiVWdwMmZOL1JEM042cHRu?=
 =?utf-8?B?SVdwRTBSTXJPTjJuRHJYK3dyYnlXVWsrNmhybjZBWTdjNUJsZ0dkb1MwOG0w?=
 =?utf-8?B?MjNoVFl5T0FRZ05jaUZNMXZMbnhkUkFqbUZVQ3RjWjZtS2pTSHNuVy9Wc0VJ?=
 =?utf-8?B?Yk9DUjRmYmJWOFZDN3pJUm9Fc29HeDBkdDRHb2htQTVJNVNvUEVta1Q0S3cv?=
 =?utf-8?B?aW1xKzl5SjNzQm5jOEUxYk5ENnd2dmxWaWIyRFpjSXkzZ2tIcU5QeTBxNjBn?=
 =?utf-8?B?SzJCTGh0aGtMaG1xbzdTVDB2ODd4d1l2N2M5Ym1aMXhwRzRJZm1maVY1c2Ny?=
 =?utf-8?B?dzBIQ3lsRkVVSGJhUU9ZTFNESkdGUFRySURieGZzYk1PaW1XYTRpYmYrVkVR?=
 =?utf-8?B?R1pVTXdDOUM3N0hmMkh2a2drWE9CMFlXZVdtTXZlQ2tNVHBqQXlBS0E2QlFk?=
 =?utf-8?B?eUZqNFZEekJuN3EvN1RlcTRkVXRoTElEdzJUVmZSU09KMFpGc1U4UWV1YUMz?=
 =?utf-8?B?MjNUTlA4ejcwUmU4STdSaUpHNFJtUGJGai9yU1NiZEwrOGh3bXJhUCtRMUwv?=
 =?utf-8?B?RHk4WVBtVmg3YmNNQmU0S2JVVlUzZHhBNDZ6YkI0YUVuL0l6WlBPbTh5M2Za?=
 =?utf-8?B?OUx1eTJGT01hUmU4Z1BlMERTelAzKzdvUDZjTFFFclJSVEorbHlXNS9qNXFB?=
 =?utf-8?B?M3ZZK25UTi9FUnFhMjRYVDh5TXNiWG5KRUNPM2ZNNm9xd1RET1ZOMW1xNWxm?=
 =?utf-8?B?a1AwMHoxMTNTN0RSTlRsenRtTitRc0lPQ0x2QVF4TDdzc3ZMQ01OUlhrZnM5?=
 =?utf-8?B?K3VleDV3TVdjODN3d3lhTDRhR0gzOWtBMjNGaTRodkRha055cndmcjVhU3lV?=
 =?utf-8?B?di9wcXNTdmlja25WLzY2OGJRaVUwdTVKdExZOXlseXVrRnpPM1FlTEhudHBX?=
 =?utf-8?B?L1R2TjdCMWdsak9lYUsyY1ZVR0ZLZTcrWmIwdThPbFRPNCtsSmQwK0FHMWNG?=
 =?utf-8?B?d29VYUFDbEdTQU1NdWVGYWk5VCtxVklaWlRZT1plTzlWeFM4bE9aU3plT3ls?=
 =?utf-8?B?L2Q0Z3lkb3JXbU5qYkczdkhILzFyei83NEl4LzhkemlaSTk5MkhXN3M4NzhV?=
 =?utf-8?B?K1ptY25KQ2VNUlhTVW1SNks1MVNRMlQ3MGRCWlVzZEJPTGRYTnUwRGQ3TjFM?=
 =?utf-8?B?NXZxUTlyYWdDMWpsVVJOWEJHWXlJWkh5WEUrZGxEcCtNbFhLNWIydWVMVU94?=
 =?utf-8?B?QWNZSUY4SGpHQ1JHQ1ZlWVFtRU5idUxPOGN0NlNuaWpDd0xzNytUT1hTVnVL?=
 =?utf-8?B?QzJ6N0VxVWw5eDZYdUpEc3BPSytUV0tZOHlDNEZZSWhDWkFkeTBnQ3lpZkps?=
 =?utf-8?B?TFZtUkVhM0lyYkN1enBVOXhGKzFhTDJ0b1dIWkNJZGUvVnMvdFNuNEhSenVH?=
 =?utf-8?B?VDhqVUxJSXZvS1dsZ3FCNEtQTUt4cjd4QVZvT1JKUW1zSWdjYlN5dERjSERj?=
 =?utf-8?B?eVlLSlQwazRIV0xLeER6Ni93cEdNdGZGR0NybExlR2wwU2pVaFpKWGhqdnlX?=
 =?utf-8?B?OXkwOTMwbU1la055Z1Y4KytCZTkrbTVoWHRPeks5eHB1MXgrRUlaQ3BkaStF?=
 =?utf-8?B?NDhTRUk2RmNRUHJQdXg4UmJqWW93SVdWaGhBc3BMUXFvc1crQmdhV2xxamdt?=
 =?utf-8?B?MCt1VHg0TGdLRkpHaUl5Rm9Pb0tyN09Db3ptYWovcnQ1d0lXNFFVcHg4cVJn?=
 =?utf-8?B?SUJYd2VkRmM4eGF6Szh2eDYweEJtMEhEUzZnalRtL2k5d2NkMVpFak1mNm1C?=
 =?utf-8?Q?4z3QY8wJWEhopPmGtl+NeLjFA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b98fba-6690-4af2-654e-08da70e2ed73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 21:48:37.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a/kWNevdnbI0lzi9EG4uRSAWodNBqnNk4RDsmkYHiShFXkzLdePAPsYsXksNAKiFEps16DJcb1vX9Cj6t1XkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280097
X-Proofpoint-GUID: cSEvCWaP1PZEiNO_LUZ8l3d1SkjEueRf
X-Proofpoint-ORIG-GUID: cSEvCWaP1PZEiNO_LUZ8l3d1SkjEueRf
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============5070048044420088093=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5070048044420088093==
Content-Type: multipart/alternative;
 boundary="------------OeNK0JD9uLvIIq5f1y4H8FIc"
Content-Language: en-US

--------------OeNK0JD9uLvIIq5f1y4H8FIc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/2022 7:43 PM, Zhu, Lingshan wrote:
>
>
> On 7/28/2022 8:56 AM, Si-Wei Liu wrote:
>>
>>
>> On 7/27/2022 4:47 AM, Zhu, Lingshan wrote:
>>>
>>>
>>> On 7/27/2022 5:43 PM, Si-Wei Liu wrote:
>>>> Sorry to chime in late in the game. For some reason I couldn't get 
>>>> to most emails for this discussion (I only subscribed to the 
>>>> virtualization list), while I was taking off amongst the past few 
>>>> weeks.
>>>>
>>>> It looks to me this patch is incomplete. Noted down the way in 
>>>> vdpa_dev_net_config_fill(), we have the following:
>>>>          features = vdev->config->get_driver_features(vdev);
>>>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
>>>>                                VDPA_ATTR_PAD))
>>>>                  return -EMSGSIZE;
>>>>
>>>> Making call to .get_driver_features() doesn't make sense when 
>>>> feature negotiation isn't complete. Neither should present 
>>>> negotiated_features to userspace before negotiation is done.
>>>>
>>>> Similarly, max_vqp through vdpa_dev_net_mq_config_fill() probably 
>>>> should not show before negotiation is done - it depends on driver 
>>>> features negotiated.
>>> I have another patch in this series introduces device_features and 
>>> will report device_features to the userspace even features 
>>> negotiation not done. Because the spec says we should allow driver 
>>> access the config space before FEATURES_OK.
>> The config space can be accessed by guest before features_ok doesn't 
>> necessarily mean the value is valid. You may want to double check 
>> with Michael for what he quoted earlier:
> that's why I proposed to fix these issues, e.g., if no _F_MAC, vDPA 
> kernel should not return a mac to the userspace, there is not a 
> default value for mac.
Then please show us the code, as I can only comment based on your latest 
(v4) patch and it was not there.. To be honest, I don't understand the 
motivation and the use cases you have, is it for debugging/monitoring or 
there's really a use case for live migration? For the former, you can do 
a direct dump on all config space fields regardless of endianess and 
feature negotiation without having to worry about validity (meaningful 
to present to admin user). To me these are conflict asks that is 
impossible to mix in exact one command.

>>> Nope:
>>>
>>> 2.5.1  Driver Requirements: Device Configuration Space
>>>
>>> ...
>>>
>>> For optional configuration space fields, the driver MUST check that the corresponding feature is offered
>>> before accessing that part of the configuration space.
>>
>> and how many driver bugs taking wrong assumption of the validity of 
>> config space field without features_ok. I am not sure what use case 
>> you want to expose config resister values for before features_ok, if 
>> it's mostly for live migration I guess it's probably heading a wrong 
>> direction.
>>
>>
>>>>
>>>>
>>>> Last but not the least, this "vdpa dev config" command was not 
>>>> designed to display the real config space register values in the 
>>>> first place. Quoting the vdpa-dev(8) man page:
>>>>
>>>>> vdpa dev config show - Show configuration of specific device or 
>>>>> all devices.
>>>>> DEV - specifies the vdpa device to show its configuration. If this 
>>>>> argument is omitted all devices configuration is listed.
>>>> It doesn't say anything about configuration space or register 
>>>> values in config space. As long as it can convey the config 
>>>> attribute when instantiating vDPA device instance, and more 
>>>> importantly, the config can be easily imported from or exported to 
>>>> userspace tools when trying to reconstruct vdpa instance intact on 
>>>> destination host for live migration, IMHO in my personal 
>>>> interpretation it doesn't matter what the config space may present. 
>>>> It may be worth while adding a new debug command to expose the real 
>>>> register value, but that's another story.
>>> I am not sure getting your points. vDPA now reports device feature 
>>> bits(device_features) and negotiated feature bits(driver_features), 
>>> and yes, the drivers features can be a subset of the device 
>>> features; and the vDPA device features can be a subset of the 
>>> management device features.
>> What I said is after unblocking the conditional check, you'd have to 
>> handle the case for each of the vdpa attribute when feature 
>> negotiation is not yet done: basically the register values you got 
>> from config space via the vdpa_get_config_unlocked() call is not 
>> considered to be valid before features_ok (per-spec). Although in 
>> some case you may get sane value, such behavior is generally 
>> undefined. If you desire to show just the device_features alone 
>> without any config space field, which the device had advertised 
>> *before feature negotiation is complete*, that'll be fine. But looks 
>> to me this is not how patch has been implemented. Probably need some 
>> more work?
> They are driver_features(negotiated) and the device_features(which 
> comes with the device), and the config space fields that depend on 
> them. In this series, we report both to the userspace.
I fail to understand what you want to present from your description. May 
be worth showing some example outputs that at least include the 
following cases: 1) when device offers features but not yet acknowledge 
by guest 2) when guest acknowledged features and device is yet to accept 
3) after guest feature negotiation is completed (agreed upon between 
guest and device).

Thanks,
-Siwei
>>
>> Regards,
>> -Siwei
>>
>>>>
>>>> Having said, please consider to drop the Fixes tag, as appears to 
>>>> me you're proposing a new feature rather than fixing a real issue.
>>> it's a new feature to report the device feature bits than only 
>>> negotiated features, however this patch is a must, or it will block 
>>> the device feature bits reporting. but I agree, the fix tag is not a 
>>> must.
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>> On 7/1/2022 3:12 PM, Parav Pandit via Virtualization wrote:
>>>>>> From: Zhu Lingshan<lingshan.zhu@intel.com>
>>>>>> Sent: Friday, July 1, 2022 9:28 AM
>>>>>>
>>>>>> Users may want to query the config space of a vDPA device, to choose a
>>>>>> appropriate one for a certain guest. This means the users need to read the
>>>>>> config space before FEATURES_OK, and the existence of config space
>>>>>> contents does not depend on FEATURES_OK.
>>>>>>
>>>>>> The spec says:
>>>>>> The device MUST allow reading of any device-specific configuration field
>>>>>> before FEATURES_OK is set by the driver. This includes fields which are
>>>>>> conditional on feature bits, as long as those feature bits are offered by the
>>>>>> device.
>>>>>>
>>>>>> Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
>>>>> Fix is fine, but fixes tag needs correction described below.
>>>>>
>>>>> Above commit id is 13 letters should be 12.
>>>>> And
>>>>> It should be in format
>>>>> Fixes: 30ef7a8ac8a0 ("vdpa: Read device configuration only if FEATURES_OK")
>>>>>
>>>>> Please use checkpatch.pl script before posting the patches to catch these errors.
>>>>> There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.
>>>>>
>>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@intel.com>
>>>>>> ---
>>>>>>   drivers/vdpa/vdpa.c | 8 --------
>>>>>>   1 file changed, 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>>>> 9b0e39b2f022..d76b22b2f7ae 100644
>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>> @@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
>>>>>> struct sk_buff *msg, u32 portid,  {
>>>>>>   	u32 device_id;
>>>>>>   	void *hdr;
>>>>>> -	u8 status;
>>>>>>   	int err;
>>>>>>
>>>>>>   	down_read(&vdev->cf_lock);
>>>>>> -	status = vdev->config->get_status(vdev);
>>>>>> -	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>>>>> -		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not
>>>>>> completed");
>>>>>> -		err = -EAGAIN;
>>>>>> -		goto out;
>>>>>> -	}
>>>>>> -
>>>>>>   	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>>>   			  VDPA_CMD_DEV_CONFIG_GET);
>>>>>>   	if (!hdr) {
>>>>>> --
>>>>>> 2.31.1
>>>>> _______________________________________________
>>>>> Virtualization mailing list
>>>>> Virtualization@lists.linux-foundation.org
>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>>>
>>>
>>
>

--------------OeNK0JD9uLvIIq5f1y4H8FIc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 7/27/2022 7:43 PM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com">
      
      <font face="monospace"><br>
        <br>
      </font>
      <div class="moz-cite-prefix"><font face="monospace">On 7/28/2022
          8:56 AM, Si-Wei Liu wrote:<br>
        </font></div>
      <blockquote type="cite" cite="mid:8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com"> <font face="monospace"> <br>
        </font> <font face="monospace"><br>
        </font>
        <div class="moz-cite-prefix"><font face="monospace">On 7/27/2022
            4:47 AM, Zhu, Lingshan wrote:<br>
          </font> </div>
        <blockquote type="cite" cite="mid:63242254-ba84-6810-dad8-34f900b97f2f@intel.com"> <font face="monospace"><br>
          </font> <font face="monospace"><br>
          </font>
          <div class="moz-cite-prefix"><font face="monospace">On
              7/27/2022 5:43 PM, Si-Wei Liu wrote:<br>
            </font> </div>
          <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com">
            <font face="monospace"> Sorry to chime in late in the game.
              For some reason I couldn't get to most emails for this
              discussion (I only subscribed to the virtualization list),
              while I was taking off amongst the past few weeks. <br>
            </font> <font face="monospace"><br>
              It looks to me this patch is incomplete. Noted down the
              way in vdpa_dev_net_config_fill(), we have the following:
            </font>
            <pre id="b" style="font-size: 13px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">        features = vdev-&gt;config-&gt;get_driver_features(vdev);
        if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
                              VDPA_ATTR_PAD))
                return -EMSGSIZE;

</pre>
            <font face="monospace"> Making call to
              .get_driver_features() doesn't make sense when feature
              negotiation isn't complete. Neither should present
              negotiated_features to userspace before negotiation is
              done.<br>
            </font> <font face="monospace"><br>
              Similarly, max_vqp through vdpa_dev_net_mq_config_fill()
              probably should not show before negotiation is done - it
              depends on driver features negotiated.</font></blockquote>
          <font face="monospace">I have another patch in this series
            introduces device_features and will report device_features
            to the userspace even features negotiation not done. Because
            the spec says we should allow driver access the config space
            before FEATURES_OK.<br>
          </font> </blockquote>
        <font face="monospace"> The config space can be accessed by
          guest before features_ok doesn't necessarily mean the value is
          valid. You may want to double check with Michael for what he
          quoted earlier:<br>
        </font></blockquote>
      <font face="monospace">that's why I proposed to fix these issues,
        e.g., if no _F_MAC, vDPA kernel should not return a mac to the
        userspace, there is not a default value for mac.</font><br>
    </blockquote>
    Then please show us the code, as I can only comment based on your
    latest (v4) patch and it was not there.. To be honest, I don't
    understand the motivation and the use cases you have, is it for
    debugging/monitoring or there's really a use case for live
    migration? For the former, you can do a direct dump on all config
    space fields regardless of endianess and feature negotiation without
    having to worry about validity (meaningful to present to admin
    user). To me these are conflict asks that is impossible to mix in
    exact one command.<br>
    <br>
    <blockquote type="cite" cite="mid:00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com">
      <blockquote type="cite" cite="mid:8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Nope:

2.5.1  Driver Requirements: Device Configuration Space

...

For optional configuration space fields, the driver MUST check that the corresponding feature is offered
before accessing that part of the configuration space.
</pre>
        </blockquote>
        <font face="monospace"><br>
          and how many driver bugs taking wrong assumption of the
          validity of config space field without features_ok. I am not
          sure what use case you want to expose config resister values
          for before features_ok, if it's mostly for live migration I
          guess it's probably heading a wrong direction.<br>
        </font> <font face="monospace"><br>
        </font> <font face="monospace"><br>
        </font>
        <blockquote type="cite" cite="mid:63242254-ba84-6810-dad8-34f900b97f2f@intel.com">
          <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com">
            <font face="monospace"><br>
            </font> <font face="monospace"><br>
              Last but not the least, this &quot;vdpa dev config&quot; command was
              not designed to display the real config space register
              values in the first place. Quoting the vdpa-dev(8) man
              page:<br>
            </font> <font face="monospace"><br>
            </font>
            <blockquote type="cite"><font face="monospace">vdpa dev
                config show - Show configuration of specific device or
                all devices.<br>
                DEV - specifies the vdpa device to show its
                configuration. If this argument is omitted all devices
                configuration is listed.</font></blockquote>
            <font face="monospace"> It doesn't say anything about
              configuration space or register values in config space. As
              long as it can convey the config attribute when
              instantiating vDPA device instance, and more importantly,
              the config can be easily imported from or exported to
              userspace tools when trying to reconstruct vdpa instance
              intact on destination host for live migration, IMHO in my
              personal interpretation it doesn't matter what the config
              space may present. It may be worth while adding a new
              debug command to expose the real register value, but
              that's another story.<br>
            </font> </blockquote>
          <font face="monospace">I am not sure getting your points. vDPA
            now reports device feature bits(device_features) and
            negotiated feature bits(driver_features), and yes, the
            drivers features can be a subset of the device features; and
            the vDPA device features can be a subset of the management
            device features. <br>
          </font> </blockquote>
        <font face="monospace"> What I said is after unblocking the
          conditional check, you'd have to handle the case for each of
          the vdpa attribute when feature negotiation is not yet done:
          basically the register values you got from config space via
          the vdpa_get_config_unlocked() call is not considered to be
          valid before features_ok (per-spec). Although in some case you
          may get sane value, such behavior is generally undefined. If
          you desire to show just the device_features alone without any
          config space field, which the device had advertised *before
          feature negotiation is complete*, that'll be fine. But looks
          to me this is not how patch has been implemented. Probably
          need some more work?<br>
        </font></blockquote>
      <font face="monospace">They are driver_features(negotiated) and
        the device_features(which comes with the device), and the config
        space fields that depend on them. In this series, we report both
        to the userspace.</font><br>
    </blockquote>
    I fail to understand what you want to present from your description.
    May be worth showing some example outputs that at least include the
    following cases: 1) when device offers features but not yet
    acknowledge by guest 2) when guest acknowledged features and device
    is yet to accept 3) after guest feature negotiation is completed
    (agreed upon between guest and device).<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com">
      <blockquote type="cite" cite="mid:8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com"> <font face="monospace"><br>
          Regards,<br>
          -Siwei<br>
        </font> <font face="monospace"><br>
        </font>
        <blockquote type="cite" cite="mid:63242254-ba84-6810-dad8-34f900b97f2f@intel.com">
          <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com">
            <font face="monospace"><br>
              Having said, please consider to drop the Fixes tag, as
              appears to me you're proposing a new feature rather than
              fixing a real issue.<br>
            </font> </blockquote>
          <font face="monospace">it's a new feature to report the device
            feature bits than only negotiated features, however this
            patch is a must, or it will block the device feature bits
            reporting. but I agree, the fix tag is not a must.<br>
          </font>
          <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com">
            <font face="monospace"><br>
              Thanks,<br>
              -Siwei<br>
            </font> <font face="monospace"><br>
            </font>
            <div class="moz-cite-prefix"><font face="monospace">On
                7/1/2022 3:12 PM, Parav Pandit via Virtualization wrote:<br>
              </font> </div>
            <blockquote type="cite" cite="mid:PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com">
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">From: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Friday, July 1, 2022 9:28 AM

Users may want to query the config space of a vDPA device, to choose a
appropriate one for a certain guest. This means the users need to read the
config space before FEATURES_OK, and the existence of config space
contents does not depend on FEATURES_OK.

The spec says:
The device MUST allow reading of any device-specific configuration field
before FEATURES_OK is set by the driver. This includes fields which are
conditional on feature bits, as long as those feature bits are offered by the
device.

Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Fix is fine, but fixes tag needs correction described below.

Above commit id is 13 letters should be 12.
And 
It should be in format
Fixes: 30ef7a8ac8a0 (&quot;vdpa: Read device configuration only if FEATURES_OK&quot;)

Please use checkpatch.pl script before posting the patches to catch these errors.
There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a>
---
 drivers/vdpa/vdpa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
9b0e39b2f022..d76b22b2f7ae 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
struct sk_buff *msg, u32 portid,  {
 	u32 device_id;
 	void *hdr;
-	u8 status;
 	int err;

 	down_read(&amp;vdev-&gt;cf_lock);
-	status = vdev-&gt;config-&gt;get_status(vdev);
-	if (!(status &amp; VIRTIO_CONFIG_S_FEATURES_OK)) {
-		NL_SET_ERR_MSG_MOD(extack, &quot;Features negotiation not
completed&quot;);
-		err = -EAGAIN;
-		goto out;
-	}
-
 	hdr = genlmsg_put(msg, portid, seq, &amp;vdpa_nl_family, flags,
 			  VDPA_CMD_DEV_CONFIG_GET);
 	if (!hdr) {
--
2.31.1
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">_______________________________________________
Virtualization mailing list
<a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:Virtualization@lists.linux-foundation.org" moz-do-not-send="true">Virtualization@lists.linux-foundation.org</a>
<a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lists.linuxfoundation.org/mailman/listinfo/virtualization__;!!ACWV5N9M2RV99hQ!LDynmbymNkIgZ-j_42iYXBJp8Vhi4QiQkE8Q0FdeqMPWsM_uIZ4pT5CnK8kWg9c8kmxlTr-37myDtRbsLlTaVuA$" moz-do-not-send="true">https://lists.linuxfoundation.org/mailman/listinfo/virtualization</a>
</pre>
            </blockquote>
            <font face="monospace"><br>
            </font> </blockquote>
          <font face="monospace"><br>
          </font> </blockquote>
        <font face="monospace"><br>
        </font> </blockquote>
      <font face="monospace"><br>
      </font> </blockquote>
    <br>
  </body>
</html>

--------------OeNK0JD9uLvIIq5f1y4H8FIc--

--===============5070048044420088093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5070048044420088093==--
