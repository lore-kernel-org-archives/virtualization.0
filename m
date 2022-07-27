Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3769C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 08:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80B96605B0;
	Wed, 27 Jul 2022 08:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80B96605B0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Kr+Xw40W;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=O0LPZ32E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id adxoIQ4Xnkwm; Wed, 27 Jul 2022 08:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F87E605AB;
	Wed, 27 Jul 2022 08:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F87E605AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1E43C0035;
	Wed, 27 Jul 2022 08:16:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8746AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61469819B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61469819B4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Kr+Xw40W; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=O0LPZ32E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9MA7loLOcP5J
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F80A814B6
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F80A814B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:16:09 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R7OqFY009198;
 Wed, 27 Jul 2022 08:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=00fbvGiRjb1nRpQX+P/L/r4UcnyGJMer05SRMxBA+e0=;
 b=Kr+Xw40WSCHY0D1giAsuCfhG8TIbc72A9lK8h9u6LjPC8QuA/TFWeLUOyEhu1ETIbLOO
 eX7DOTA3YRCEC8rOoP07hI92QLUAXxkmkLRWoJIJG4zk/kcrWpNVu7xpliJmY5cpwnHw
 l4/MjY6gFD3Zb+oeGJleFeGkwnJrkVEZ3dFii6Y00NIm4hwhfc5ZLTUkz50p47NUsY+M
 avcOtytar+m0iuMRtkh+BIMhnwEsxPZOeduDYCN0uqsKwBZbqjQimq3zaSesUSKpgq9E
 +l7MAm259uV6zNPFshQiSBhnkZn87aNTQ1zxmVyM2u3bx2B4qwXrb7JnTMTTNqnCLkuK Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap0dc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 08:16:04 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26R6RuUR006209; Wed, 27 Jul 2022 08:16:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh65cmajw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Jul 2022 08:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLcnI6y0zh+oUsqaCAd4D0zcrzzKw4+UuDKzkM/BAG8yDsJc8QaY+j5QeoVznGWRyW3N7w7YkrH9kteaymlLOUpPWRAwURPbUKCYxYurN2JLvvGGU3Bi7tdVJwwm/p25SpOgui2aEWlEs3bW0pafqf+8pL0/tGAmLNJvXig8/ZbC8THGGkIq3CewwO55Juapv26+itCubatnDmS5bzWCPUiC+smwJZiYWIbTxjdaB/pqho+4lO3MG0NZr7JIXGt0E7oKnhgfYAdhmglB2kEw9rS5cRRiZJKPUO0adv5ZG49MLLdGwReBdnQfHk+hz9Sy8J2A+pgMf3VaqCVGAnH9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00fbvGiRjb1nRpQX+P/L/r4UcnyGJMer05SRMxBA+e0=;
 b=lpFBwfP6NKPOE0I9MPsTogtAL52BHjwE2qZ/I6U4bi2rsuVedzLvnZQ9nHuuxviEika+1sJ1eWkEIh6v0twdKK4b054hrUtJH7sbLVqt+5B4CPnMHiDab4Ku4vtNvpFyC4dSUQ9UqZIpnCOufjy//6XTenshrM5srCdmlg2mVf1TqXQeRbolbu8QpfVI/VFzygBWq/3h5UT7lF9kVA0PfLeswPQbOuiiytygENCsYYn2R6SNcQhS31UUEyCasywF08xSeu1GZTLcklPJN4aZxCDuWMiZn1pZkktygi4ZRkleVqT8p6Uv/xo6adXBwAn9uZmRTrhf6JCipKxeazQk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00fbvGiRjb1nRpQX+P/L/r4UcnyGJMer05SRMxBA+e0=;
 b=O0LPZ32EGqNKJ/qT+QXNCeRofeQKrqaUY+qWhbW9K+tRoR4OpHkUKUZwb2PjtWb6yHyu4Ecnvi7OtCa4T7rt1cZhVVJ+xL5whKTl5PvFrx5bvf59Hi5fbjpCfXTylPMO8aQjW6M1/Ek1I6HcVrLBO6YKHQb7yfZaqqKl2k6VeB0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by PH0PR10MB4645.namprd10.prod.outlook.com (2603:10b6:510:31::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 08:16:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 08:16:00 +0000
Message-ID: <a1bb599c-63be-a85e-5cff-6eed28abd347@oracle.com>
Date: Wed, 27 Jul 2022 01:15:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 3/6] vDPA: allow userspace to query features of a vDPA
 device
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-4-lingshan.zhu@intel.com>
 <PH0PR12MB5481AEB53864F35A79AAD7F5DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e8479441-78d2-8b39-c5ad-6729b79a2f35@redhat.com>
 <PH0PR12MB54817FD9E0D8469857438F95DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1e1e5f8c-d20e-4e54-5fc0-e12a7ba818a3@intel.com>
 <PH0PR12MB5481862D47DCD61F89835B01DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB5481862D47DCD61F89835B01DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bd6e6fe-452e-4ffc-8bfa-08da6fa83d9d
X-MS-TrafficTypeDiagnostic: PH0PR10MB4645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnDriudiYObX/rH07WDfizTUUBzgBjlNstL5R7u1cmV55rcjpDhOZeSlSOzf+5SrkVQcDq3AHDVJkAtkWCwQ7GAmNP7tWaNaDWRjf0AuYVliN5n7Mi/Gb4ivJHSbLKmAXXk0RJx+jTWKDeIAuSydbvx1TCQGpkRwaLSSb/14Bdxhy8RrxA0PWA43GZPsvRLKcncBWf8d8cuBY6IBzKwmU5LXYJ6acFTkDvRRK1p1Xx+OrxcrIl9cPyspZdMWg+hNVbRCnQ56gdkQ17CzeKkBVBjVFsbvO0R4ltg738lxB7DD0RTXPBjqniUsNUh0gH0DNvwIK3zUsBmbTTK35AbSRls7adXPyRgJjzhtdItb1r5Ppe8EOmu3TNtWRXfn8hJZtbAKm1yD308ibhPk1JgeE2lyNlaArc/ggzUlh9xq2+QHTbf1I3a7w74EP/TJVSE1Ntk+Q5ap5BfyFSkFDy8RAbOILizQjOdX/lxVUBM7yWKua+NjLe4cNU/loD8JNOsti4t//4ZE7rNUNCe8sgogARLL0tTQEBeXV45MbEMy9y6CVlUeXdm8jyZn8A1xFwJNbocMCa6ysFX3HZuw91aCiYl9wu6YxBhV3R3rm24hVuRaBmLVkCy8cM+5SapZWUYoHhJpED8X8tNyfPQdIAjItIa/sJL/2ju3b+15w3aGI2sEWzky7HVfpMglxGVxDDQiiREwepQzjc7eGQqfaRqm0VlbVoZJ2w4O3c1YR2glio4j2U8s+ZeKacJOAkEhxEmoqunlgFgdVLhpR4tRoPwALGFP8YOvWFX7PTjDIbAmBosCzovho8gMvsyBz6tFQ0d16wKXM8MfenP91rOI/XMb6yp2oVNk+hbDvL4Oxtg3u7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(366004)(346002)(376002)(39860400002)(136003)(2616005)(316002)(38100700002)(83380400001)(8936002)(2906002)(966005)(31686004)(36756003)(41300700001)(5660300002)(478600001)(6486002)(8676002)(53546011)(110136005)(6512007)(54906003)(26005)(86362001)(31696002)(66476007)(4326008)(66946007)(6506007)(36916002)(186003)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNxU0kySk5iR1NwdmNQbHZzLzd3OTZieU1EdjJWL3Q1cVJPN2pWTFRNemNl?=
 =?utf-8?B?QkVVUGkyM1NJaFgwVERsWHkyM09MVW5jN3BNb2xiOHk3Zmp5OFE1VzJCSll1?=
 =?utf-8?B?akRjZ0IwVk9VSmR4bmRRa056dTJ4dGcxNkJ4eTRhNXJNWGxHS1lzQkVsR1VL?=
 =?utf-8?B?WnhPYW96eEFRNHdlejRnSitQTWR1QUtyMjZ0Y256dk5iT0JQOXVmMGVQOEZs?=
 =?utf-8?B?WXRsRWxZY24zYUJhelBUNjBjOFhablNkTUZoeERSWVZFdXNoaUlvQy9UNlNT?=
 =?utf-8?B?KzR5OEtDTkQ1MXRiUDJvYVdEKzg0SE4vdGVEd2JYNURxcHgwSWFmSFM2ZjBR?=
 =?utf-8?B?L01ZY1gvOHNUMzREMGNOcVhEb2tON3dsRHVzdnR3WVdKVnpZazZid1NEZGo3?=
 =?utf-8?B?NTJmVnhubitTeWkyeEpQKytIT1FVU0FRajJKL25kQTZhMWVjdVh3aWFxdjEz?=
 =?utf-8?B?S25ZdEtENHc3SDdKODdRKzIwc2N6VkE1T2FDVjU4YlNaVHc2bmVVYzZJVEdW?=
 =?utf-8?B?SWFyNHhXT3VVSVpybmhVVzlKcERPYWpaTmczY3BCc3ZQUkl1bkUrcGlLa29G?=
 =?utf-8?B?VTZzZHZ1bklNcWJKeWtlWVlzZHZjMzhwSVJZemduWkxOaE5kVEwxSjBVS3o4?=
 =?utf-8?B?NXFmbXJsVHVQb25sRjJVWlk1SmIxSW9pK0pCVHZ0eTdYOXk5VklHMDIwTi81?=
 =?utf-8?B?MzdUODJmOTlUcVEyMVFCZVJ2Y0FsUHV6UzJkQmlnSTFLNWxVaUxtRGVvaDd3?=
 =?utf-8?B?S2FnWW5kSkRSczU3RDVLSFhwWUlqSzV5M2lLWitkR0Nmd1JTazl3Tk9TeGRM?=
 =?utf-8?B?cU1wOThkNDdTaU5qaHlqOHF2cjZoeldtb2FlcEZJMlNTb2tQY0ZQN2J3VTZU?=
 =?utf-8?B?KzJialp4Vm1nekdYcGtKQUlWSG1aYWpQeSszVjJack83QVFZVTR0TnpXS1Fq?=
 =?utf-8?B?bVNLS3U4S1hDYlJYZkR0R0E2MnZuRHhNNHBJcFFLbXk4NFlWTTBzYXVnUlFt?=
 =?utf-8?B?VDh5WWxJVFpVaGQwQ3lOSjhHSHVRVW1hb3VFVlc3Q200SWpsSHVsc092N05n?=
 =?utf-8?B?VnZ6NSt5MzNlcExCazAybmhwYUR5dmtrbzgyWTRvYU93YlFqeGpZSndCMnlV?=
 =?utf-8?B?L3UreWxNeVpSZHYyc1g0SGNOTkZ3bkp5WlhyUEdqUk9yRkl6TFFZcHBOaUtp?=
 =?utf-8?B?V0VxS1hvU3B4R0Zrbi9Famo3aUF0eGlQeDZhQjZVc2l0RTd1cXRXU1BMUVZS?=
 =?utf-8?B?RldkZ044N3owK2xOTFNZdllGS0JQbHdiVnJ3cWdmTkFMSlJtVlpEazZaK1hW?=
 =?utf-8?B?d2lWUFhoS0tXLzZsMGVwQWtSN2did0tidERDazFzL1NHa0JJWUNrMnhLZ0VV?=
 =?utf-8?B?Mjhla2ZoSVVwRDI0OEVXYlBhWE83V2Q5SDFReGlJcGo5Q25Ld0ZTZ2IzRXZz?=
 =?utf-8?B?TEJCMFBCeDNmWklNRWpvMVpGOGxFRjJzb2wrSlZxVjl0dEEzV0Fzb2VDS1hC?=
 =?utf-8?B?MjA1dXc5M2RZYjBFNHVOWnJab1NYSFJPaWxjMk0yVCttSlNBUEJkOWM3ZUVY?=
 =?utf-8?B?RlRRalQ0MGNmR05KOXlJQWZvM2pwSm1TY3dreXUwNDF1aFc4MGZwRmFWUmVp?=
 =?utf-8?B?cHBHVnJWL1BIUW5qQ1kyQU9zN1g2SEV0UkZTR0cwSllrNmtZMW4xZVFyYXZt?=
 =?utf-8?B?SlJ4ODVseld6a3VXVlVOcWlWQU1nTmM5MldTWFp0Ny82MkNVWEM2UWZYNFRD?=
 =?utf-8?B?bmxSWlYyaHRCUTdlRVJPYnVVVVN5bXdEVDBSbGRDS2VGSDduOHkvRzJLV0JZ?=
 =?utf-8?B?M0VPTjFUMGFPT1c0bDBtd3JBUFRoUllhTGNpSmZMRTJmZlNQUEp6OGgxWGlM?=
 =?utf-8?B?SjE1SjAyN0k5b3hkT3pEdFFLdFZhREFzUmtMbG9ZZDc3b01jb25VUCt3dGpD?=
 =?utf-8?B?WTZaRjBWeEZXc3JiVGhVcW5sM1ZKbDJIQzI1NnZIR2FXR2xoTFpUa09CQ0xh?=
 =?utf-8?B?Z3F4blRiTElqWTlCdnZSOHM4T0w5eVYzT3Qxc3I1YjJNTTU1TWUzaDh2NzRj?=
 =?utf-8?B?a2E1TmZ1NXV6LytibmsrY2s2OGxGVTBoZk5QNjVtN2tMdFYvcVREbXJ6dENo?=
 =?utf-8?Q?WnOkqmnOK3fGXL3xv/UXNVob6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd6e6fe-452e-4ffc-8bfa-08da6fa83d9d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 08:16:00.6051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsrdqdenxujS7gAA7Xll5MPiQQN9yIySGh38DDvGKIQOenxdxPTzN9HLTULArFL+EhKn/Zf32BIaznJCjP9vnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270032
X-Proofpoint-ORIG-GUID: L8WZqxdQp43yjU63WoXY0D8AkxWZQIzW
X-Proofpoint-GUID: L8WZqxdQp43yjU63WoXY0D8AkxWZQIzW
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA3LzUvMjAyMiA0OjU2IEFNLCBQYXJhdiBQYW5kaXQgdmlhIFZpcnR1YWxpemF0aW9uIHdy
b3RlOgo+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+PiBT
ZW50OiBUdWVzZGF5LCBKdWx5IDUsIDIwMjIgMzo1OSBBTQo+Pgo+Pgo+PiBPbiA3LzQvMjAyMiA4
OjUzIFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KPj4+PiBTZW50OiBNb25kYXksIEp1bHkgNCwgMjAyMiAxMjo0NyBBTQo+
Pj4+Cj4+Pj4KPj4+PiDlnKggMjAyMi83LzIgMDY6MDIsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4+
Pj4+PiBGcm9tOiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+PiBT
ZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiA5OjI4IEFNCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBjb21t
aXQgYWRkcyBhIG5ldyB2RFBBIG5ldGxpbmsgYXR0cmlidXRpb24KPj4+Pj4+IFZEUEFfQVRUUl9W
RFBBX0RFVl9TVVBQT1JURURfRkVBVFVSRVMuIFVzZXJzcGFjZSBjYW4gcXVlcnkKPj4+PiBmZWF0
dXJlcwo+Pj4+Pj4gb2YgdkRQQSBkZXZpY2VzIHRocm91Z2ggdGhpcyBuZXcgYXR0ci4KPj4+Pj4+
Cj4+Pj4+PiBGaXhlczogYTY0OTE3YmMyZTliIHZkcGE6IChQcm92aWRlIGludGVyZmFjZSB0byBy
ZWFkIGRyaXZlcgo+Pj4+Pj4gZmVhdHVyZSkKPj4+Pj4gTWlzc2luZyB0aGUgIiIgaW4gdGhlIGxp
bmUuCj4+Pj4+IEkgcmV2aWV3ZWQgdGhlIHBhdGNoZXMgYWdhaW4uCj4+Pj4+Cj4+Pj4+IEhvd2V2
ZXIsIHRoaXMgaXMgbm90IHRoZSBmaXguCj4+Pj4+IEEgZml4IGNhbm5vdCBhZGQgYSBuZXcgVUFQ
SS4KPj4+Pj4KPj4+Pj4gQ29kZSBpcyBhbHJlYWR5IGNvbnNpZGVyaW5nIG5lZ290aWF0ZWQgZHJp
dmVyIGZlYXR1cmVzIHRvIHJldHVybiB0aGUKPj4+Pj4gZGV2aWNlCj4+Pj4gY29uZmlnIHNwYWNl
Lgo+Pj4+PiBIZW5jZSBpdCBpcyBmaW5lLgo+Pj4+Pgo+Pj4+PiBUaGlzIHBhdGNoIGludGVudHMg
dG8gcHJvdmlkZSBkZXZpY2UgZmVhdHVyZXMgdG8gdXNlciBzcGFjZS4KPj4+Pj4gRmlyc3Qgd2hh
dCB2ZHBhIGRldmljZSBhcmUgY2FwYWJsZSBvZiwgYXJlIGFscmVhZHkgcmV0dXJuZWQgYnkKPj4+
Pj4gZmVhdHVyZXMKPj4+PiBhdHRyaWJ1dGUgb24gdGhlIG1hbmFnZW1lbnQgZGV2aWNlLgo+Pj4+
PiBUaGlzIGlzIGRvbmUgaW4gY29tbWl0IFsxXS4KPj4+Pj4KPj4+Pj4gVGhlIG9ubHkgcmVhc29u
IHRvIGhhdmUgaXQgaXMsIHdoZW4gb25lIG1hbmFnZW1lbnQgZGV2aWNlIGluZGljYXRlcwo+Pj4+
PiB0aGF0Cj4+Pj4gZmVhdHVyZSBpcyBzdXBwb3J0ZWQsIGJ1dCBkZXZpY2UgbWF5IGVuZCB1cCBu
b3Qgc3VwcG9ydGluZyB0aGlzCj4+Pj4gZmVhdHVyZSBpZiBzdWNoIGZlYXR1cmUgaXMgc2hhcmVk
IHdpdGggb3RoZXIgZGV2aWNlcyBvbiBzYW1lIHBoeXNpY2FsIGRldmljZS4KPj4+Pj4gRm9yIGV4
YW1wbGUgYWxsIFZGcyBtYXkgbm90IGJlIHN5bW1ldHJpYyBhZnRlciBsYXJnZSBudW1iZXIgb2Yg
dGhlbQo+Pj4+PiBhcmUKPj4+PiBpbiB1c2UuIEluIHN1Y2ggY2FzZSBmZWF0dXJlcyBiaXQgb2Yg
bWFuYWdlbWVudCBkZXZpY2UgY2FuIGRpZmZlcgo+Pj4+IChtb3JlCj4+Pj4gZmVhdHVyZXMpIHRo
YW4gdGhlIHZkcGEgZGV2aWNlIG9mIHRoaXMgVkYuCj4+Pj4+IEhlbmNlLCBzaG93aW5nIG9uIHRo
ZSBkZXZpY2UgaXMgdXNlZnVsLgo+Pj4+Pgo+Pj4+PiBBcyBtZW50aW9uZWQgYmVmb3JlIGluIFYy
LCBjb21taXQgWzFdIGhhcyB3cm9uZ2x5IG5hbWVkIHRoZQo+Pj4+PiBhdHRyaWJ1dGUgdG8KPj4+
PiBWRFBBX0FUVFJfREVWX1NVUFBPUlRFRF9GRUFUVVJFUy4KPj4+Pj4gSXQgc2hvdWxkIGhhdmUg
YmVlbiwKPj4+PiBWRFBBX0FUVFJfREVWX01HTVRERVZfU1VQUE9SVEVEX0ZFQVRVUkVTLgo+Pj4+
PiBCZWNhdXNlIGl0IGlzIGluIFVBUEksIGFuZCBzaW5jZSB3ZSBkb24ndCB3YW50IHRvIGJyZWFr
IGNvbXBpbGF0aW9uCj4+Pj4+IG9mIGlwcm91dGUyLCBJdCBjYW5ub3QgYmUgcmVuYW1lZCBhbnlt
b3JlLgo+Pj4+Pgo+Pj4+PiBHaXZlbiB0aGF0LCB3ZSBkbyBub3Qgd2FudCB0byBzdGFydCB0cmVu
ZCBvZiBuYW1pbmcgZGV2aWNlCj4+Pj4+IGF0dHJpYnV0ZXMgd2l0aAo+Pj4+IGFkZGl0aW9uYWwg
X1ZEUEFfIHRvIGl0IGFzIGRvbmUgaW4gdGhpcyBwYXRjaC4KPj4+Pj4gRXJyb3IgaW4gY29tbWl0
IFsxXSB3YXMgZXhjZXB0aW9uLgo+Pj4+Pgo+Pj4+PiBIZW5jZSwgcGxlYXNlIHJldXNlIFZEUEFf
QVRUUl9ERVZfU1VQUE9SVEVEX0ZFQVRVUkVTIHRvIHJldHVybgo+Pj4+IGZvciBkZXZpY2UgZmVh
dHVyZXMgdG9vLgo+Pj4+Cj4+Pj4KPj4+PiBUaGlzIHdpbGwgcHJvYmFibHkgYnJlYWsgb3IgY29u
ZnVzZSB0aGUgZXhpc3RpbmcgdXNlcnNwYWNlPwo+Pj4+Cj4+PiBJdCBzaG91bGRuJ3QgYnJlYWss
IGJlY2F1c2UgaXRzIG5ldyBhdHRyaWJ1dGUgb24gdGhlIGRldmljZS4KPj4+IEFsbCBhdHRyaWJ1
dGVzIGFyZSBwZXIgY29tbWFuZCwgc28gb2xkIG9uZSB3aWxsIG5vdCBiZSBjb25mdXNlZCBlaXRo
ZXIuCj4+IEEgbmV0bGluayBhdHRyIHNob3VsZCBoYXMgaXRzIG93biBhbmQgdW5pcXVlIHB1cnBv
c2UsIHRoYXQncyB3aHkgd2UgZG9uJ3QgbmVlZAo+PiBsb2NrcyBmb3IgdGhlIGF0dHJzLCBvbmx5
IG9uZSBjb25zdW1lciBhbmQgb25seSBvbmUgcHJvZHVjZXIuCj4+IEkgYW0gYWZyYWlkIHJlLXVz
aW5nIChmb3IgYm90aCBtYW5hZ2VtZW50IGRldmljZSBhbmQgdGhlIHZEUEEgZGV2aWNlKSB0aGUg
YXR0cgo+PiBWRFBBX0FUVFJfREVWX1NVUFBPUlRFRF9GRUFUVVJFUyB3b3VsZCBsZWFkIHRvIG5l
dyByYWNlIGNvbmRpdGlvbi4KPj4gRS5nLiwgVGhlcmUgYXJlIHBvc3NpYmlsaXRpZXMgb2YgcXVl
cnlpbmcgRkVBVFVSRVMgb2YgYSBtYW5hZ2VtZW50IGRldmljZSBhbmQKPj4gYSB2RFBBIGRldmlj
ZSBzaW11bHRhbmVvdXNseSwgb3IgY2FuIHRoZXJlIGJlIGEgc3luY2luZyBpc3N1ZSBpbiBhIHRp
Y2s/Cj4gQm90aCBjYW4gYmUgcXVlcmllZCBzaW11bHRhbmVvdXNseS4gRWFjaCB3aWxsIHJldHVy
biB0aGVpciBvd24gZmVhdHVyZSBiaXRzIHVzaW5nIHNhbWUgYXR0cmlidXRlLgo+IEl0IHdvbnQg
bGVhZCB0byB0aGUgcmFjZS4KQWdyZWVkLiBNdWx0aXBsZSB1c2Vyc3BhY2UgY2FsbGVycyB3b3Vs
ZCBkbyByZWN2KCkgY2FsbHMgb24gZGlmZmVyZW50IApuZXRsaW5rIHNvY2tldHMuIExvb2tzIHRv
IG1lIHNob3VsZG4ndCBpbnZvbHZlIGFueSByYWNlLgo+Cj4+IElNSE8sIEkgZG9uJ3Qgc2VlIGFu
eSBhZHZhbnRhZ2VzIG9mIHJlLXVzaW5nIHRoaXMgYXR0ci4KPiBXZSBkb27igJl0IHdhbnQgdG8g
Y29udGludWUgdGhpcyBtZXNzIG9mIFZEUEFfREVWIHByZWZpeCBmb3IgbmV3IGF0dHJpYnV0ZXMg
ZHVlIHRvIHByZXZpb3VzIHdyb25nIG5hbWluZy4KV2VsbCwgeW91IGNhbiBzYXkgaXQncyBhIG1l
c3MgYnV0IHNpbmNlIHRoZSBhdHRyIG5hbWUgY2FuIGJlIHJldXNlZCBmb3IgCmRpZmZlcmVudCBj
b21tYW5kLMKgIEkgZGlkbid0IGNhcmUgdGhhdCBtdWNoIHdoaWxlIHJldmlld2luZyB0aGlzLiAK
QWN0dWFsbHksIGl0IHdhcyBpbml0aWFsbHkgbmFtZWQgdGhpcyB3YXkgdG8gc2hvdyB0aGUgZGV2
aWNlIGZlYXR1cmVzIGluIAoidmRwYSBkZXYgY29uZmlnIC4uLiIgb3V0cHV0LCBidXQgbGF0ZXIg
b24gaXQgaGFkIGJlZW4gbW92ZWQgdG8gbWdtdGRldiAKdG8gc2hvdyBwYXJlbnQncyBjYXBhYmls
aXR5LgoKLVNpd2VpCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPiBWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
