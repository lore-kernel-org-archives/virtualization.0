Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324BAC04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 10:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1BD34017E;
	Wed, 27 Jul 2022 10:09:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1BD34017E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=aCB/LYCY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=AJ4f/mNM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imli7rtiiAyW; Wed, 27 Jul 2022 10:09:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 149474014D;
	Wed, 27 Jul 2022 10:09:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 149474014D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE582C0033;
	Wed, 27 Jul 2022 10:09:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB81C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 10:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06F38817A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 10:09:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06F38817A8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=aCB/LYCY; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=AJ4f/mNM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGCYn8KI-WRP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 10:09:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A61080B1A
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A61080B1A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 10:09:53 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R9loF2029985;
 Wed, 27 Jul 2022 10:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PEuAISQgt8vjenri6RT7z1yIM29Ses/9aRPddrTsviw=;
 b=aCB/LYCYdES73Rh+1xCMxZMEWMjkGQptK6iZt4c7YncLmDsIrr5VgFUnDxP+BjrtHpSk
 gZzrkRXkSA+naiQWwhWtVN92p1FFLLCQZTM01CTX2FJgVtJoSlWZ7gyb+o6CGWAyFjaq
 owsKEd/aCxsl7FA/2Zem2kn/X/gUaKzJDBIvXyQd7mu4or53SWVeg2ti6RjDHJUwUWu8
 FKWTiV4hTtFn4AzAR7JP1L5FH149wFqwodMMB5Ma4huR1l2vCG3kK+d337IcXLbt/v5n
 fpwb4rsMpHPcbKZLXEtKVwRMDMpgN3ohS9eLa+EfRa17ZUcCOQcPv8BVK6AA4OHiWV0I HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hssae6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 10:09:50 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26R8MGU1031548; Wed, 27 Jul 2022 10:09:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh64t1sfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 10:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih0V1t95c7wi+q7MbXcaTOWCz3QvNk8N+stF8Z+kleZOo7H8MDsadFQvsIN8Fl921RZPtk7TLuqc5YWcYUBwlmT43Edavj/oXlP5VY+uUmc4paX4F0JU3ififcOq1wsev4bAp9lbDzoqL+SgbFvhjEd7VUE2xxq4F9UWrOvy7N4Gum3W/BGPjRvOLY+gw9g1ed+KlgXdTrGXSkamPpmQKD6msRTllH2ymxeeLcaVTtawA+/RPJh5p+SDpG3fczhEvmy87jwnkXcZXPAoChRG53vJ37I839FfxrjwdRUqBc6+dUHhY5SRh7lp93o7mVwRtH+32qDCthZjZKVda9Ftdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEuAISQgt8vjenri6RT7z1yIM29Ses/9aRPddrTsviw=;
 b=QMY0ieZ9+QUGlUXbUkMCsDFaPPpsBdTgmXQgcjkDyKOaOAE+owdU7vBk4qlmolzvujs2lueqZCHflIJDDhA1bTleYxBa7oh31OZ4PKqZC0OUKn3RsqvcA4INwFVr21HY7kL4fRj+cn726sqj8IgU8w6G9AGlZTXFlAChGryq7wzXCRtwZXz1oJun9vYKSPfVk9jDIWEVu5LjcDGohAICZ95lua/JXAqst8jTAKxsEaZ5IjteamtLphP0ScL+8OfvMEUwv4Q4sgFNSWdyy27SeW/7YoHjNLIqkIgAQkjf6OFY0oP3f+uYqVRPuP6QkntB3Sbul12S34IsdIVgWIQc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEuAISQgt8vjenri6RT7z1yIM29Ses/9aRPddrTsviw=;
 b=AJ4f/mNMyxFsOpWid5fsr5XHF9+zMuexOMmE/qxp/lDsNGY24LJzuV5XzGTWOizssxI8wSZqzi0RvrV5PrvjB4F0P7I4xC7Vy8iymOZ6RAjlaunWWhenYMl6HX3nW26v3U1GOPVQoK+VxSBUqqDUhN977fedXmHN/VL/O+b+wvQ=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 10:09:47 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 10:09:47 +0000
Message-ID: <6d5b03ee-5362-8534-5881-a34c9ea626f0@oracle.com>
Date: Wed, 27 Jul 2022 03:09:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
 <20220727050102-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220727050102-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: CH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::27) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55536fee-bf01-4494-eecf-08da6fb82269
X-MS-TrafficTypeDiagnostic: IA1PR10MB6075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Kro/0E3cMh42eliOyx4cQwws4EDY6vvppNspPfCdpQFvS0HifFS8N6cFHqzZkB7BYazF1SsRkksJU+Da5yWRD7Fwk7sRsaOGf7dO6T9r4Le9WPbzDtJ/shqqXvWzrduAGDTSwGCNZSalXVHzfW0e7ci1M27LQO3lLAMN0Po+CzkcBmurRUSTEW/Ae7CPquUAtg8dCI/9Fan6J46NM5Fk9G7vBdS6YqzJJ3bXMGpL9+pOys0IkWmH3aAwSKxP66ddMsKD5O/MdARPml40yR4wDmQX1v1kMMP9V/Id9bxPaw4upduCosXPtCPWkho/Pjzou1qagVTns+cN/qcneaSkFg7ICBqcjUshJipeU4DHx25yPhm/r54IvR8Z1icsi+98FLLWmf1mJgQvDyaLmcdfSSfXWDHM92NTFsq1wuK0YooB0GeREOxmwp7Db+JTf5JGwWQyDiRLrzdAI8Ra/ERL0sgSvZt13DlQpa0IQGKaGF08KRrhYhyp/oCtMYczC7Ic8sDgKssDWHKtvmSOC5DmylbVd5eMLFZWGRWrbiSm+G5vbqIJzXcGp6JEXSmJQ6Ne51UTtItKXdkTjiDjSttwIwTdPYVSVm9hpfjcxkcF9B1MD24iBVEvNOmUDBXFIkEwSk22iuoGqmBI+8BN8WfKATWPDOYYwlpMZ1BcZr+EH6qht7w1n4g6+a5e1tmm+hLiAKSf6sl8mSfdt0xX6NNORxzSRycd98+2c68pEIHKm4Q8f7Kj7ZMjERZ8gSnWp8WdWs7s0aYoCQEovq3jcyGi8rmi+HgJ9KFF3NdXsImyRwKj3u1RPf8oVcfS7i12fq71yKACuKSMHH5a21nxjJEdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(478600001)(83380400001)(26005)(6512007)(186003)(5660300002)(31686004)(8936002)(36756003)(2616005)(86362001)(6916009)(6506007)(53546011)(36916002)(54906003)(31696002)(2906002)(316002)(41300700001)(4326008)(66556008)(6666004)(38100700002)(66946007)(8676002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGphRVgxT05vakFvcHZLMWpMa0xHeEgwaDE0Vm1CeW1leDFjSys4NGpROXE1?=
 =?utf-8?B?alBPSHo1cnVZRXZ4NWVIb3NlZzU4L2hwLzdlV29oVjJmbHZwcVVORWxsMmV2?=
 =?utf-8?B?T3FjS1pQeUc0VmxrT1Q1ayt0Rko3YTFtcmR3eXNWWXNDMVlTOTN6dUZINHRL?=
 =?utf-8?B?eHQvVU8zUHBqVEJ3dFQxbFl3UWNGR1ZaWWNXd0hBOFRpVEt5WWRIdFQrdnBM?=
 =?utf-8?B?V3ExUW5iSEFkSmtZN0MyY0dJZmVkZmc1WnJBUExJaVZBRjZzTUIyRjBPSGpZ?=
 =?utf-8?B?eXBoeEhWQmNvdDU2em40T2xXZThEOHZQd0xjUGppVHU4eERYT2dnLzI1bUl6?=
 =?utf-8?B?OGJ3VEN2UWd4VVdGMWdDM09lNnA2em02ZHhBU2VNUnNxcFR1eHYwdkxVV1Q2?=
 =?utf-8?B?WWVId2hIa0VlTXk1ME9pcmQ0U25FYlBGSmJOVi9pVVR2dWxqZXN4bWRHQTVh?=
 =?utf-8?B?ZkNUbWE3Y01HNFMyQTZpVjc1a2NBUG1vSTlVZ1pqaFJ0WGZ6czlqZDRWYS9I?=
 =?utf-8?B?R0c1dHF6RkNlM2pmcmJ1TjJVYkJpZGpDeWhZWndiQk5BM0VUT2JxaWkrMkdJ?=
 =?utf-8?B?RXdCMFU0TDN2V004d1FsQXVUTmFWb0c2QnBEVzlSVXBoZUJrS0VOYXA5NlVh?=
 =?utf-8?B?VmVZVG91Z3RaUkdCUHExUUt2S2FMbGxtODQzUmVBTVVYc3hjL2ZwUTRiRHdt?=
 =?utf-8?B?aW1Db1lrTkJZWThZbVU2Ulh0OHlEMU9kcmh4NmpBd3JVY2FZazhhV3AxV3Uy?=
 =?utf-8?B?a2tmYWVwS1gycGQyWDVhQUt1TTkxNDRCeVljKzJqbEdKUDRZa0JaU0xaMUJj?=
 =?utf-8?B?WW8raC9SRS85akNmSGE2WkpMZXBPZGc0cklSVmRraWVuc1E5R3VLbTE0cjBB?=
 =?utf-8?B?Skh1S0libzFhR09oN1JvVHk1S2NQd25Lekc5NGFuMHR5QjdlSUoyMEIxL3pp?=
 =?utf-8?B?ckpqa1BORzZZRUlIdEQyKzJXNjVDcUVDMjU5UFZrUEVxQlpvc1kyanBPSjZU?=
 =?utf-8?B?RDQzY29sVzF4TEowbGZBNWRWWEZMdnZmbG4wV0dYeXUvN0VyVVBQZU1vN3Jw?=
 =?utf-8?B?Wm1Nck12U1ZGZVU1OW5iWk11ZDFCeXRWbnExT2IyRFVWK2VBNHNtVEJzVEo5?=
 =?utf-8?B?ZEJOc3JwU3FSdGxFb01pSzkxcTd6SFpzUjdQSUcyZWNVRFdoN0lJeWtxSHcz?=
 =?utf-8?B?TlY0SDh4WTY4Nkp1dVE4WDIwaVloU0h4NFlBU3NGdlpuS3FqOVkrOTJvVkox?=
 =?utf-8?B?dmhaVjNDMlBJQzZ3b21qQnJFNEN3UG43bHArWHNncWV0endsajdMNW1FdE9q?=
 =?utf-8?B?UCtXaUhmT05JKzlwTktqaGNYb3ByMmR0YWprNXk0ZWJkRG9ZcFYyVitiOWgx?=
 =?utf-8?B?NlZXNkZhVzVZTlhrNXN1UUNwdGhjdWJqQzRsa0Q1YnAzN3NvYVlzTDVSeDQ1?=
 =?utf-8?B?d2lzOFB6akgvb1pkb1U4K3BqZ1NkSjNRd3JweXJ3a200bUlXRWxnaTM1TS9u?=
 =?utf-8?B?WW5pZkNEYTNiUFh3cGlpN3pSeVYxcDFuMWIvajJFcVpiSVpCdkdtNjdYSmRF?=
 =?utf-8?B?UzMwUlBiVERFRlZrdXJyTCtWOUFReURXRlhGVGVwclExU0V5YllkME5MbDRa?=
 =?utf-8?B?NHR4MFQ0ZEZtYVAyb2p6eXVFTTRxcWFMQjByd0Jpd0tlYTBHRDhrcTV4UFBp?=
 =?utf-8?B?UUp3SHpCc1U3bitXcytDREFDQkdGd056ZzFwZWVyRytLWE53V0pOaEdFWUZ5?=
 =?utf-8?B?Vzh6VXN3dmVpR1drNlNDQVk3RGxhdVFNSkJ5WXVjbWNjU2V2NUFPRWxFZzhL?=
 =?utf-8?B?NXhXWGpqOHk5cHZaWVdhamJIR1RqOW83Q3JQOGlKVXNOUWVkRFc3NVNDbWtR?=
 =?utf-8?B?NWNXT3ZMVDZRTU9PNWJsWW9UU20vUjROakVUbnQxTGFNUmFzYXpFS1pXcE5G?=
 =?utf-8?B?WWZHWG1QV01QRDF5Y1AwdHBXWi9RNWMrWll1aXRaWUJxUmo1OHBPTU1TYVEy?=
 =?utf-8?B?dkxwWmlJNnFBY0F2VlRYc3dsOExTMy9CdU52UUxSZWtLNk5nYVBTUlh5WUtN?=
 =?utf-8?B?UmpvR00rODFtYWdqVXpOVU9iM0Ixc1UzY3hvT2pPemUyY09rY1F2OVUrWGkw?=
 =?utf-8?Q?CZdYrkZXDTuSnKO6iEZrmhcDQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55536fee-bf01-4494-eecf-08da6fb82269
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 10:09:47.0254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwZnSKTtQSzmR/yHkOmAcx//BUsyIbd1gX8VLK8ZPrWuTBubKeUzsM+PMjSPGgQLm/1z3BalDM7sUolHaT561g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270042
X-Proofpoint-ORIG-GUID: 8kneqneCU_NjXKwZngpVA2G96-Qj1mS4
X-Proofpoint-GUID: 8kneqneCU_NjXKwZngpVA2G96-Qj1mS4
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
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

CgpPbiA3LzI3LzIwMjIgMjowMSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdl
ZCwgSnVsIDI3LCAyMDIyIGF0IDEyOjUwOjMzQU0gLTA3MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+
Cj4+IE9uIDcvMjYvMjAyMiAxMTowMSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4g
T24gV2VkLCBKdWwgMjcsIDIwMjIgYXQgMDM6NDc6MzVBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjUzIFBNCj4+Pj4+Cj4+Pj4+IE9u
IDcvMjcvMjAyMiAxMDoxNyBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+Pj4+IEZyb206IFpo
dSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+Pj4gU2VudDogVHVlc2Rh
eSwgSnVseSAyNiwgMjAyMiAxMDoxNSBQTQo+Pj4+Pj4+Cj4+Pj4+Pj4gT24gNy8yNi8yMDIyIDEx
OjU2IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFu
IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAx
MiwgMjAyMiAxMTo0NiBQTQo+Pj4+Pj4+Pj4+IFdoZW4gdGhlIHVzZXIgc3BhY2Ugd2hpY2ggaW52
b2tlcyBuZXRsaW5rIGNvbW1hbmRzLCBkZXRlY3RzIHRoYXQKPj4+Pj4+PiBfTVEKPj4+Pj4+Pj4+
IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRha2VzIG1heF9xdWV1ZV9wYWlyID0gMSBieSBp
dHNlbGYuCj4+Pj4+Pj4+PiBJIHRoaW5rIHRoZSBrZXJuZWwgbW9kdWxlIGhhdmUgYWxsIG5lY2Vz
c2FyeSBpbmZvcm1hdGlvbiBhbmQgaXQgaXMKPj4+Pj4+Pj4+IHRoZSBvbmx5IG9uZSB3aGljaCBo
YXZlIHByZWNpc2UgaW5mb3JtYXRpb24gb2YgYSBkZXZpY2UsIHNvIGl0Cj4+Pj4+Pj4+PiBzaG91
bGQgYW5zd2VyIHByZWNpc2VseSB0aGFuIGxldCB0aGUgdXNlciBzcGFjZSBndWVzcy4gVGhlIGtl
cm5lbAo+Pj4+Pj4+Pj4gbW9kdWxlIHNob3VsZCBiZSByZWxpYWJsZSB0aGFuIHN0YXkgc2lsZW50
LCBsZWF2ZSB0aGUgcXVlc3Rpb24gdG8KPj4+Pj4+Pj4+IHRoZSB1c2VyIHNwYWNlCj4+Pj4+Pj4g
dG9vbC4KPj4+Pj4+Pj4gS2VybmVsIGlzIHJlbGlhYmxlLiBJdCBkb2VzbuKAmXQgZXhwb3NlIGEg
Y29uZmlnIHNwYWNlIGZpZWxkIGlmIHRoZQo+Pj4+Pj4+PiBmaWVsZCBkb2VzbuKAmXQKPj4+Pj4+
PiBleGlzdCByZWdhcmRsZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZlIGRlZmF1bHQgb3Igbm8gZGVm
YXVsdC4KPj4+Pj4+PiBzbyB3aGVuIHlvdSBrbm93IGl0IGlzIG9uZSBxdWV1ZSBwYWlyLCB5b3Ug
c2hvdWxkIGFuc3dlciBvbmUsIG5vdCB0cnkKPj4+Pj4+PiB0byBndWVzcy4KPj4+Pj4+Pj4gVXNl
ciBzcGFjZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhlci4gVXNlciBzcGFjZSBnZXRzIHRvIHNlZSBp
ZiBfTVEKPj4+Pj4+PiBwcmVzZW50L25vdCBwcmVzZW50LiBJZiBfTVEgcHJlc2VudCB0aGFuIGdl
dCByZWxpYWJsZSBkYXRhIGZyb20ga2VybmVsLgo+Pj4+Pj4+PiBJZiBfTVEgbm90IHByZXNlbnQs
IGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUgVlEgcGFpci4KPj4+Pj4+PiBpdCBpcyBzdGls
bCBhIGd1ZXNzLCByaWdodD8gQW5kIGFsbCB1c2VyIHNwYWNlIHRvb2xzIGltcGxlbWVudGVkIHRo
aXMKPj4+Pj4+PiBmZWF0dXJlIG5lZWQgdG8gZ3Vlc3MKPj4+Pj4+IE5vLiBpdCBpcyBub3QgYSBn
dWVzcy4KPj4+Pj4+IEl0IGlzIGV4cGxpY2l0bHkgY2hlY2tpbmcgdGhlIF9NUSBmZWF0dXJlIGFu
ZCBkZXJpdmluZyB0aGUgdmFsdWUuCj4+Pj4+PiBUaGUgY29kZSB5b3UgcHJvcG9zZWQgd2lsbCBi
ZSBwcmVzZW50IGluIHRoZSB1c2VyIHNwYWNlLgo+Pj4+Pj4gSXQgd2lsbCBiZSB1bmlmb3JtIGZv
ciBfTVEgYW5kIDEwIG90aGVyIGZlYXR1cmVzIHRoYXQgYXJlIHByZXNlbnQgbm93IGFuZAo+Pj4+
PiBpbiB0aGUgZnV0dXJlLgo+Pj4+PiBNUSBhbmQgb3RoZXIgZmVhdHVyZXMgbGlrZSBSU1MgYXJl
IGRpZmZlcmVudC4gSWYgdGhlcmUgaXMgbm8gX1JTU19YWCwgdGhlcmUKPj4+Pj4gYXJlIG5vIGF0
dHJpYnV0ZXMgbGlrZSBtYXhfcnNzX2tleV9zaXplLCBhbmQgdGhlcmUgaXMgbm90IGEgZGVmYXVs
dCB2YWx1ZS4KPj4+Pj4gQnV0IGZvciBNUSwgd2Uga25vdyBpdCBoYXMgdG8gYmUgMSB3aWh0b3V0
IF9NUS4KPj4+PiAid2UiID0gdXNlciBzcGFjZS4KPj4+PiBUbyBrZWVwIHRoZSBjb25zaXN0ZW5j
eSBhbW9uZyBhbGwgdGhlIGNvbmZpZyBzcGFjZSBmaWVsZHMuCj4+PiBBY3R1YWxseSBJIGxvb2tl
ZCBhbmQgdGhlIGNvZGUgc29tZSBtb3JlIGFuZCBJJ20gcHV6emxlZDoKPj4+Cj4+Pgo+Pj4gCXN0
cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsKPj4+IAl1NjQgZmVhdHVyZXM7Cj4+
PiAJdTE2IHZhbF91MTY7Cj4+Pgo+Pj4gCXZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCh2ZGV2LCAw
LCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4+Pgo+Pj4gCWlmIChubGFfcHV0KG1zZywgVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIsIHNpemVvZihjb25maWcubWFjKSwKPj4+IAkJICAg
IGNvbmZpZy5tYWMpKQo+Pj4gCQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4KPj4+Cj4+PiBNYWMgcmV0
dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9NQUMKPj4+Cj4+Pgo+Pj4gCXZhbF91MTYg
PSBsZTE2X3RvX2NwdShjb25maWcuc3RhdHVzKTsKPj4+IAlpZiAobmxhX3B1dF91MTYobXNnLCBW
RFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQo+Pj4gCQlyZXR1cm4gLUVNU0dTSVpF
Owo+Pj4KPj4+Cj4+PiBzdGF0dXMgcmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9T
VEFUVVMKPj4+Cj4+PiAJdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5tdHUpOwo+Pj4gCWlm
IChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIHZhbF91MTYpKQo+
Pj4gCQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4KPj4+Cj4+PiBNVFUgcmV0dXJuZWQgZXZlbiB3aXRo
b3V0IFZJUlRJT19ORVRfRl9NVFUKPj4+Cj4+Pgo+Pj4gV2hhdCdzIGdvaW5nIG9uIGhlcmU/Cj4+
Pgo+Pj4KPj4gSSBndWVzcyB0aGlzIGlzIHNwZWMgdGhpbmcgKGhpc3RvcmljYWwgZGVidCksIEkg
dmFndWVseSByZWNhbGwgdGhlc2UgZmllbGRzCj4+IGFyZSBhbHdheXMgcHJlc2VudCBpbiBjb25m
aWcgc3BhY2UgcmVnYXJkbGVzcyB0aGUgZXhpc3RlbmNlIG9mIGNvcnJlc3BvbmRpbmcKPj4gZmVh
dHVyZSBiaXQuCj4+Cj4+IC1TaXdlaQo+IE5vcGU6Cj4KPiAyLjUuMSAgRHJpdmVyIFJlcXVpcmVt
ZW50czogRGV2aWNlIENvbmZpZ3VyYXRpb24gU3BhY2UKPgo+IC4uLgo+Cj4gRm9yIG9wdGlvbmFs
IGNvbmZpZ3VyYXRpb24gc3BhY2UgZmllbGRzLCB0aGUgZHJpdmVyIE1VU1QgY2hlY2sgdGhhdCB0
aGUgY29ycmVzcG9uZGluZyBmZWF0dXJlIGlzIG9mZmVyZWQKPiBiZWZvcmUgYWNjZXNzaW5nIHRo
YXQgcGFydCBvZiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZS4KV2VsbCwgdGhpcyBpcyBkcml2ZXIg
c2lkZSBvZiByZXF1aXJlbWVudC4gQXMgdGhpcyBpbnRlcmZhY2UgaXMgZm9yIGhvc3QgCmFkbWlu
IHRvb2wgdG8gcXVlcnkgb3IgY29uZmlndXJlIHZkcGEgZGV2aWNlLCB3ZSBkb24ndCBoYXZlIHRv
IHdhaXQgCnVudGlsIGZlYXR1cmUgbmVnb3RpYXRpb24gaXMgZG9uZSBvbiBndWVzdCBkcml2ZXIg
dG8gZXh0cmFjdCB2ZHBhIAphdHRyaWJ1dGVzL3BhcmFtZXRlcnMsIHNheSBpZiB3ZSB3YW50IHRv
IHJlcGxpY2F0ZSBhbm90aGVyIHZkcGEgZGV2aWNlIAp3aXRoIHRoZSBzYW1lIGNvbmZpZyBvbiBt
aWdyYXRpb24gZGVzdGluYXRpb24uIEkgdGhpbmsgd2hhdCBtYXkgbmVlZCB0byAKYmUgZml4IGlz
IHRvIG1vdmUgb2ZmIGZyb20gdXNpbmcgLnZkcGFfZ2V0X2NvbmZpZ191bmxvY2tlZCgpIHdoaWNo
IApkZXBlbmRzIG9uIGZlYXR1cmUgbmVnb3RpYXRpb24uIEFuZC9vciBleHBvc2UgY29uZmlnIHNw
YWNlIHJlZ2lzdGVyIAp2YWx1ZXMgdGhyb3VnaCBhbm90aGVyIHNldCBvZiBhdHRyaWJ1dGVzLgoK
LVNpd2VpCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
