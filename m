Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0771C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 07:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D8F081911;
	Wed, 27 Jul 2022 07:50:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D8F081911
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=EDUOEXNK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ezh7bFaA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zf0EnE85Mzym; Wed, 27 Jul 2022 07:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D0948194C;
	Wed, 27 Jul 2022 07:50:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D0948194C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F737C0033;
	Wed, 27 Jul 2022 07:50:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC86C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2110240990
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:50:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2110240990
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=EDUOEXNK; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ezh7bFaA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jtN1KnH9r0PU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:50:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25C894098E
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25C894098E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 07:50:43 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R7C2Dr030020;
 Wed, 27 Jul 2022 07:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZoXHW5xjCyNy7eTS4/KKBqsmACn27brQZCb/CsEEjjE=;
 b=EDUOEXNKAjAsQJCsaR0nidumAhXYsKdyn1TV/TbFAJqv8LP8PgmfSpCiFIOsasqfvO/h
 Lpv72Ub7jIEqafehFpAl4vaByFXyq+ZtPQ5UvsBEYUkI2g1Tm29YSgJE6TBIry0cTIPL
 9eYv3XMyJgKntUR6+Z6wOABEr/7CEZ7BG44JQKPDFQfs2/XFlNapcTUocWlEfWuYekdY
 gupvAx1fzHkjr5VKl+oyrAUc3Cn9QLNJnTxMOySNetJBoqZfrKXbuQE0NVN82XcpuQf9
 e/r0w2lEd6HkvDTOeGIdl2Lzw8H4xm8Y5Tz0zrizkUN1gQ4jBiT/ArC2KoNsD13obgUL sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsrv7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 07:50:39 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26R7NwND017671; Wed, 27 Jul 2022 07:50:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh651kvns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 07:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWmzRUwtHlUa9dqi+Vju3qyCaolm8Cu3X2IsbUMYOajTvsOdn/pNSUix4gD+E10DJAm4DdR4dIxEIKzLyIu4GmhUm/RTo1FGUvyWi7tECZRrt5A40iJ3petQCThfil7SdaO+68wdiWv/4LA+i3XQPbBtyeWK1gyY+eroq7CQtz48rxpGpfASKCOHzE/qvtW0Ug2Cr6RVR8FdLSIGHdzjSZSD8CaIPNKBKTF9dZzr+FWo1k96qSCn55VlZoLp0DzujWyQypIc3OJtKH9WLXWFQXPtx80fRCm9gxr40ULXrwD5SjJU+g3VQs7UgdruXs1hDHwj2xjAm+/9FvgjRBo7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoXHW5xjCyNy7eTS4/KKBqsmACn27brQZCb/CsEEjjE=;
 b=VxtDD5zqSOlF1eVHq/llXkR17S8plMRfxTw6gWBZMj3yMsDRmwwEQO2iMhac0kE/PrxYNYUN5AMl+3p++mPU5gMzdMk2VoW245dQYR2wUpbC+d5LWTYKrm9IMJtpZT3axXT7G1Q86TurIFggoLTnWKZiZ7Jh9o4xzsziZH1ujLzC5TrFDMN9RfP/EnRHbn7/LtVN8Q/o6Wxd6GPE0HL+tIt8UIjTLE2pXH72qz8bJv0wqhiDDxAgmuAulBs53hXFfx7Ji78bKzoqTBfC477j0oFL42YyKmd34WWBth3+RzvYOWVb5/680xIgMIgvHWVLnHTlx+EhwDkq2Dq0MlXtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoXHW5xjCyNy7eTS4/KKBqsmACn27brQZCb/CsEEjjE=;
 b=ezh7bFaAAJlZNwaDnPF6XjHGsP14cDO1cqMVsIePrnqcBYFeza+kY0SLJ+2Jmn9iW2+keZHForVeHLkJ3zf5atlqss0yzNiQnJOlXMlWzRdTT1vAT1tsry7hgw7qOvQNXzbiwQZK7wte4H4DJm4RP0OgHlFRMEk885ZI6tGE3lo=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 27 Jul
 2022 07:50:36 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 07:50:36 +0000
Message-ID: <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
Date: Wed, 27 Jul 2022 00:50:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
 <PH0PR12MB54817863E7BA89D6BB5A5F8CDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220727015626-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DM5PR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:4:60::27) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14a9aa4b-959e-4e93-1b0d-08da6fa4b105
X-MS-TrafficTypeDiagnostic: SN4PR10MB5573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbaRsVQfaJr5cKbYzkPkVlYaN2c61fCfUf7AfpQEXxc5yr3P4oyFSGwgkXSnrPC1EhEKOWMiYr1+FPU2BJ3tt06oJ8dI6uO3FooSmcJHzVqs+dwhgP6O4fFwMj2iWRzCBiS1HXXrpAHVRWfW93QsuITbqZMqZqFT+0Mg5lLmKza7D9qSqQQbARCV4dcHb1Qlcn9usPLVtOZmnoRgy8eS4jyY2WA9AWlcu/X4aNDX+2blKkkaVl8oAEzhoO4pdRxawOP73z7Nz85v2NuC7dnkJqH7JtDJPvnrJPkbQZEERmLUKyAO1KN64WSvSXbAf9HPxxRdxD0OPOXVwVZLCSFKM7knuxAP8X4IMrZn3nnhGEQzhJZybYGNCLhFo1OlB55NQKMjZaz8kmeDYwEmKUiHYFU1KNQW8wuzYiCYZKjuCubZfq3lCmI7dV0yQBN8yKZAn71ARDE1vtquPYEuXiKtzRZuXmfCqxudzlP2uz043UbZpFpVhIa5PvdhZQz0+Nz9zjWFH+e6jdhPq4KIwiVem8C0GRayF4LlvKqKpEMu6ju8okrJ5sc5z69xouod6HWqdBUBjLCDl6S0f8GGZzW4CO7kgbyBh8GvuwqU1EYXj5XcXDCH9LonJP/3BiCdgBs8S2qn9Bf+5l3xqb+M7d3Zssim/tFNY4YEDUZiAPEc3fmmzSjfo1grwZtj2DrduKlcRv9wGK48FgI2KZ5y2c6scokNCYmJ49wIAclBSC+nZYWDYCFZlXv8KQxn5kmC68N5qsf8LV2gOnUnxFTG0+X/P52Hi13XL1SUwROqtUjmgeW12mmlaX8hzfhAJoRpZ5qTG2Iav5SJgmtoEeck3fvjRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(136003)(366004)(346002)(376002)(396003)(6666004)(83380400001)(110136005)(36756003)(316002)(54906003)(41300700001)(38100700002)(6506007)(8676002)(5660300002)(66556008)(36916002)(2906002)(478600001)(8936002)(31696002)(4326008)(86362001)(6486002)(2616005)(66476007)(6512007)(26005)(66946007)(31686004)(186003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hzQVZybFBvWnRZNjB1QmZGWU9WWlUyM2E0a2RVbFZBZ2RUcXQyUTg4QmFJ?=
 =?utf-8?B?Ync2S2Y0ZHpCWTlEdTZ2ZmFQRXZ1Z0JyajAzM2Y5cGZJMmp6THpoSTA0bDlN?=
 =?utf-8?B?YU92LzJVWDZuV09EakhFaGNTaTJkQ3FGRUYvK3kxSVlNZEpwbGtMYit2c3Bu?=
 =?utf-8?B?eXd1bkhUQWlTSjdPNklueFdFNmdubzBUSU9KMkZSUnFJTUg1c2w5VTZscHpl?=
 =?utf-8?B?RFJOV0RpNkxLVjZGRzA3cVZEV1lvNllaL0VjY1kzOG4vQm1UQVh3d3ZMTnNV?=
 =?utf-8?B?enlYQm5HeGdHaUtqVXJIM0psUytEM2FLQ01pR3Y1OVFZbjhacTlodXhoYi9R?=
 =?utf-8?B?U0ZRb2xDYTFFaE9FQkNqa2ZaYTJzcmJ2VlVaZVRBbURFcU5uR2dVUDEwM3FB?=
 =?utf-8?B?ZnBHcTR2Q053dTZNcGVEc1hpU2ZleXBsNHhLRFJtSHlkd3VGTVcvWUc5eTAy?=
 =?utf-8?B?alRsSXZiRk1sWFdQSlZtVEk5NTdsZ0FieDFNV2FUb1JEMk5XbVYyajArRUww?=
 =?utf-8?B?ODA5VmJkeEFGNVVYd05Mem41QVp5c0xCd3M0OVNvRmVjT0d5VkNnUUpxOXkr?=
 =?utf-8?B?RHdHN2hXamRRRlU1MkMxb25ROG1KajBLdnRSMlFlV2w3S21Hc0dKRUdBamJH?=
 =?utf-8?B?WkkrRTA4TVhtUmtycTZXazJPSzg1MURaelBBMnBqTzBJd3YxMzVkL2gzR1o3?=
 =?utf-8?B?ell2M1huZUM2eGtYQ1pUZXNvdmxZVVpSTGc4d2NiQ0VUU2N2b0c3TG9lYmIv?=
 =?utf-8?B?dWJobmI3bCt4dFVZaU54R0Z5RXpmMXpXZ0ZXOFZOM3QyNGxPZWpYV2JvTXZQ?=
 =?utf-8?B?NnVQeWMxeFlsSnE4cEVMeEJzQ2x2OTJxemp2RkkwUmYvUThlZ0VPTUZYZ1Zq?=
 =?utf-8?B?MzRwWElHa3pweHV1SXpyWElQV0lQMWk5SllhOURkVTVkNTYrOGsxZkdwbXVC?=
 =?utf-8?B?TjZubnBVcmJSSkpKVDNJQVJuM3BaTC85MFl2YkdLS1RKNm5lK3dnVlRzTHVN?=
 =?utf-8?B?NDdHeG5SbGFPYU9SZXVDaHZydXR5YXJSVEpNdEl4dFZqN3hOOFhaRkZkSXkz?=
 =?utf-8?B?Qy9vSmtKYWl6SFM0cG1kTmJ3OEtybitydHVtb2xhdHVvQ2FkdWRRajdFVXB1?=
 =?utf-8?B?OUlWblh2Ujg0VUpwOUlDb1lHN2dNVHRoYlpPLzhPczQ5eXdMbUIycTduRzFh?=
 =?utf-8?B?VC85alpSYk9SdHhScjlHYitpY0J3Z0lFNWhtUWo2cnRYQ2ZtNzl4bFRNMzRz?=
 =?utf-8?B?TVhwRVZkVWlKbU81K28rbk9mR1g0Tjl6MW92MWFpYlpjOXYweFR6V0hBSVBQ?=
 =?utf-8?B?QS9RK2ljNUJlQTV0cXh1Y2xmUVlXSlBJZmVWc0ZYZkZ2K2hrRERQdGtHZXdB?=
 =?utf-8?B?Z3ZOZmJrcVNqSDR2SkVFbEdrb2RSN2duNG5pTGs0M1k1dEYralZaUVMyRHdq?=
 =?utf-8?B?OXhYOVhIbWJvZllpQU1RTTNTUlBkN2RDblZobXhweWRxS09YbisveDJPSTMv?=
 =?utf-8?B?WUJWSjdycDdkT0owL253eTM2OEMwUmRXcm56ZjQ1WU1vQ2JsUUJ2Sld2ZmRa?=
 =?utf-8?B?UEJZOFUzM0t6L2FadzMwZW9oV25WeTNDNzEzMUt5NldNMXp0Tkc1V29IMHh4?=
 =?utf-8?B?VHBFYzhDWUZLRFVuOVkwL2Exd2ViMnUvb01QbWFjTFFoYmpkMTAvWEEvdHBM?=
 =?utf-8?B?TmxFdVRDTDVnK2REQ0wva2NCQ3hFeElBME5kZ3JVN3Y2c1E0NlZBaWlmQmVw?=
 =?utf-8?B?TGUzbjZOd1FYM045dHRZZWNyN0QvRlhoZ25RMGQrb2pPRTlFTlZveWhJbVFG?=
 =?utf-8?B?Zk5LcEsyenJYNUd1ZmErSVNhT0lwcnIvRzg3S2M0YlNXTk9DMFg4Sk0wdVpZ?=
 =?utf-8?B?eG9WZzNrV1VLM1NFL1JzN3RwL3h0dWJxYUgvcjlRQ3pHd01xVWg5Q2NMRmJm?=
 =?utf-8?B?Tis2NlNaa1lrYSt0M2o5VjdlazJqWUVqSUtiTkV1Y1NrVXVJSndsWlpDb1c3?=
 =?utf-8?B?Q0dlVHdtc1JBT0gzNkd2NGJPVEs1UHhUUmVGSkpNelA0blltSUdCWEtoYkZ6?=
 =?utf-8?B?aVdKdTFtdU12YmRIak5seTB3d1RGbDZadUlZeE5qL0Z6dVEyb2lLRzRnczlT?=
 =?utf-8?Q?pFAMQ2/cxM3AUFeP7+jelZU2C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a9aa4b-959e-4e93-1b0d-08da6fa4b105
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 07:50:36.3286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KKaTluxR6HpOkJ8yjA6DFJGZq2++NPURZTzYGigm/IPtw6Q5y2EKrVpDDrJLulBsj5q2EXmDIGLDM7u5vB/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270029
X-Proofpoint-ORIG-GUID: 4njW8EwyC8Xg1fNwgdiKPb_TMsKebz-v
X-Proofpoint-GUID: 4njW8EwyC8Xg1fNwgdiKPb_TMsKebz-v
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiA3LzI2LzIwMjIgMTE6MDEgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIEp1bCAyNywgMjAyMiBhdCAwMzo0NzozNUFNICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6
Cj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4gU2Vu
dDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDo1MyBQTQo+Pj4KPj4+IE9uIDcvMjcvMjAyMiAx
MDoxNyBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIy
IDEwOjE1IFBNCj4+Pj4+Cj4+Pj4+IE9uIDcvMjYvMjAyMiAxMTo1NiBQTSwgUGFyYXYgUGFuZGl0
IHdyb3RlOgo+Pj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+Cj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+Pj4+Pj4+
PiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNoIGludm9rZXMgbmV0bGluayBjb21tYW5kcywgZGV0
ZWN0cyB0aGF0Cj4+Pj4+IF9NUQo+Pj4+Pj4+IGlzIG5vdCBzdXBwb3J0ZWQsIGhlbmNlIGl0IHRh
a2VzIG1heF9xdWV1ZV9wYWlyID0gMSBieSBpdHNlbGYuCj4+Pj4+Pj4gSSB0aGluayB0aGUga2Vy
bmVsIG1vZHVsZSBoYXZlIGFsbCBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIGl0IGlzCj4+Pj4+
Pj4gdGhlIG9ubHkgb25lIHdoaWNoIGhhdmUgcHJlY2lzZSBpbmZvcm1hdGlvbiBvZiBhIGRldmlj
ZSwgc28gaXQKPj4+Pj4+PiBzaG91bGQgYW5zd2VyIHByZWNpc2VseSB0aGFuIGxldCB0aGUgdXNl
ciBzcGFjZSBndWVzcy4gVGhlIGtlcm5lbAo+Pj4+Pj4+IG1vZHVsZSBzaG91bGQgYmUgcmVsaWFi
bGUgdGhhbiBzdGF5IHNpbGVudCwgbGVhdmUgdGhlIHF1ZXN0aW9uIHRvCj4+Pj4+Pj4gdGhlIHVz
ZXIgc3BhY2UKPj4+Pj4gdG9vbC4KPj4+Pj4+IEtlcm5lbCBpcyByZWxpYWJsZS4gSXQgZG9lc27i
gJl0IGV4cG9zZSBhIGNvbmZpZyBzcGFjZSBmaWVsZCBpZiB0aGUKPj4+Pj4+IGZpZWxkIGRvZXNu
4oCZdAo+Pj4+PiBleGlzdCByZWdhcmRsZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZlIGRlZmF1bHQg
b3Igbm8gZGVmYXVsdC4KPj4+Pj4gc28gd2hlbiB5b3Uga25vdyBpdCBpcyBvbmUgcXVldWUgcGFp
ciwgeW91IHNob3VsZCBhbnN3ZXIgb25lLCBub3QgdHJ5Cj4+Pj4+IHRvIGd1ZXNzLgo+Pj4+Pj4g
VXNlciBzcGFjZSBzaG91bGQgbm90IGd1ZXNzIGVpdGhlci4gVXNlciBzcGFjZSBnZXRzIHRvIHNl
ZSBpZiBfTVEKPj4+Pj4gcHJlc2VudC9ub3QgcHJlc2VudC4gSWYgX01RIHByZXNlbnQgdGhhbiBn
ZXQgcmVsaWFibGUgZGF0YSBmcm9tIGtlcm5lbC4KPj4+Pj4+IElmIF9NUSBub3QgcHJlc2VudCwg
aXQgbWVhbnMgdGhpcyBkZXZpY2UgaGFzIG9uZSBWUSBwYWlyLgo+Pj4+PiBpdCBpcyBzdGlsbCBh
IGd1ZXNzLCByaWdodD8gQW5kIGFsbCB1c2VyIHNwYWNlIHRvb2xzIGltcGxlbWVudGVkIHRoaXMK
Pj4+Pj4gZmVhdHVyZSBuZWVkIHRvIGd1ZXNzCj4+Pj4gTm8uIGl0IGlzIG5vdCBhIGd1ZXNzLgo+
Pj4+IEl0IGlzIGV4cGxpY2l0bHkgY2hlY2tpbmcgdGhlIF9NUSBmZWF0dXJlIGFuZCBkZXJpdmlu
ZyB0aGUgdmFsdWUuCj4+Pj4gVGhlIGNvZGUgeW91IHByb3Bvc2VkIHdpbGwgYmUgcHJlc2VudCBp
biB0aGUgdXNlciBzcGFjZS4KPj4+PiBJdCB3aWxsIGJlIHVuaWZvcm0gZm9yIF9NUSBhbmQgMTAg
b3RoZXIgZmVhdHVyZXMgdGhhdCBhcmUgcHJlc2VudCBub3cgYW5kCj4+PiBpbiB0aGUgZnV0dXJl
Lgo+Pj4gTVEgYW5kIG90aGVyIGZlYXR1cmVzIGxpa2UgUlNTIGFyZSBkaWZmZXJlbnQuIElmIHRo
ZXJlIGlzIG5vIF9SU1NfWFgsIHRoZXJlCj4+PiBhcmUgbm8gYXR0cmlidXRlcyBsaWtlIG1heF9y
c3Nfa2V5X3NpemUsIGFuZCB0aGVyZSBpcyBub3QgYSBkZWZhdWx0IHZhbHVlLgo+Pj4gQnV0IGZv
ciBNUSwgd2Uga25vdyBpdCBoYXMgdG8gYmUgMSB3aWh0b3V0IF9NUS4KPj4gIndlIiA9IHVzZXIg
c3BhY2UuCj4+IFRvIGtlZXAgdGhlIGNvbnNpc3RlbmN5IGFtb25nIGFsbCB0aGUgY29uZmlnIHNw
YWNlIGZpZWxkcy4KPiBBY3R1YWxseSBJIGxvb2tlZCBhbmQgdGhlIGNvZGUgc29tZSBtb3JlIGFu
ZCBJJ20gcHV6emxlZDoKPgo+Cj4gCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7
fTsKPiAJdTY0IGZlYXR1cmVzOwo+IAl1MTYgdmFsX3UxNjsKPgo+IAl2ZHBhX2dldF9jb25maWdf
dW5sb2NrZWQodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwo+Cj4gCWlmIChubGFf
cHV0KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIsIHNpemVvZihjb25maWcubWFj
KSwKPiAJCSAgICBjb25maWcubWFjKSkKPiAJCXJldHVybiAtRU1TR1NJWkU7Cj4KPgo+IE1hYyBy
ZXR1cm5lZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01BQwo+Cj4KPiAJdmFsX3UxNiA9IGxl
MTZfdG9fY3B1KGNvbmZpZy5zdGF0dXMpOwo+IAlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FU
VFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQo+IAkJcmV0dXJuIC1FTVNHU0laRTsKPgo+Cj4g
c3RhdHVzIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfU1RBVFVTCj4KPiAJdmFs
X3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5tdHUpOwo+IAlpZiAobmxhX3B1dF91MTYobXNnLCBW
RFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCB2YWxfdTE2KSkKPiAJCXJldHVybiAtRU1TR1NJWkU7
Cj4KPgo+IE1UVSByZXR1cm5lZCBldmVuIHdpdGhvdXQgVklSVElPX05FVF9GX01UVQo+Cj4KPiBX
aGF0J3MgZ29pbmcgb24gaGVyZT8KPgo+CkkgZ3Vlc3MgdGhpcyBpcyBzcGVjIHRoaW5nIChoaXN0
b3JpY2FsIGRlYnQpLCBJIHZhZ3VlbHkgcmVjYWxsIHRoZXNlIApmaWVsZHMgYXJlIGFsd2F5cyBw
cmVzZW50IGluIGNvbmZpZyBzcGFjZSByZWdhcmRsZXNzIHRoZSBleGlzdGVuY2Ugb2YgCmNvcnJl
c3BvbmRpbmcgZmVhdHVyZSBiaXQuCgotU2l3ZWkKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
