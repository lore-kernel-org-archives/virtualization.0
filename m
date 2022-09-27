Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C3CC6FA90
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 09:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0789D404AF;
	Tue, 27 Sep 2022 09:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0789D404AF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=rISPtdvD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=UUW1vWNv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZyZJv5y943s; Tue, 27 Sep 2022 09:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3DF40400FC;
	Tue, 27 Sep 2022 09:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DF40400FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC30C0032;
	Tue, 27 Sep 2022 09:41:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 058F0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 09:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D332F82605
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 09:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D332F82605
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=rISPtdvD; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=UUW1vWNv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rPjKyWk94owI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 09:41:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 374ED81D4F
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 374ED81D4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 09:41:28 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8SthS032658;
 Tue, 27 Sep 2022 09:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=UH8ROOrsRahiowD4wwZgMJx7gsE0RBiakFwPDvp+nmU=;
 b=rISPtdvDdZXmufZ2g857xSoELP8IyGcVMSZ7lmJ3k8omqTPAPqVRtTEeseL4M4nZvKK7
 2dINP+xAOJ2SEYZ3uAi4z5zJgerT2US9MGbk6uZi1GkVEMJke2QN+Fg4B7arR0/Pv905
 PhfvIyS5S2eW+BWPDLAU2R/THGfrkDEbg/ELVl9xB9XXGGdeDcR09APBAZG/XWAg/FqZ
 ZBo3/44YugeEeJcfy7Al2dNmTDVOtQIpxOv4w/XC61S6l14UvH07SwTKvUFlFkb9EfZ1
 xAvEPy1Qah+mSoPNPmgOw0/0uXp0PYyZllmxw6nAhaFZ69PV+JzMtQIzqeaGBMPKCCQ6 Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwe56t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Sep 2022 09:41:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 28R85GAG001523; Tue, 27 Sep 2022 09:41:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3jtpv0auaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Sep 2022 09:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONJPY11l+unmjQWvHJmEcwmV+IMFGBTNvqH8nwzGCKYBig9Q7gnWXbVboTBGsKvEHvk/TG3VkA0vY8m7I5I62nMDVIhHih0mbC0YUcB55D16AksZ/f88MUBkyWyz54wfg7SIbcHOu1CL2qmFuEENuUkXhcV85Gg0o7a99sc5XVPZlE36aM0B6hXN6+ejwR32km132zgBlYGCAUrKku6scKmsK1Zy2vgpE+2xHbFRVyD1CywdPgqF8pz63zTcP8Frxl+1SC1ogsDMXXutcplniFOHb4GQhjlEtLeuk47rXPUTvClgNtrm1PH5tW26O2+/cDB686rYMJ3r6yjqJISpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH8ROOrsRahiowD4wwZgMJx7gsE0RBiakFwPDvp+nmU=;
 b=gimbsGHggLiLVv282ke2+YULuqlibJ4llfB+T8gzygNeyNGlv/FOcoEw6fQ4AmuAvTWceLQkmYK9Odo9wo4o5qV7y4RVAiTiB8FACvDK9ITleGbUbCvuk2z1a2PMHW1q6eb87NTlD0W8ZTq0T1uxTnELJncYBMBSTF5XdLcjMoZLbMIjj90YvT0v+hoPdBakqdpax0cWAjtLbTaH/8R7G6xo2BgFcBgq95lV6PEOnAigA4Idrs28f6i+RA5inzEQtoDdLErlWBf1j02qPIEQs0xY10oq74gkn3piqmelLlHbMTfk4l3vFPwhDKwuTFb0NGi6I4mqtmEmQNL1a5lPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH8ROOrsRahiowD4wwZgMJx7gsE0RBiakFwPDvp+nmU=;
 b=UUW1vWNvfHje3RMr3UwB7AUESNe3rwzQRwVa5UKG4kVEfIwaaxFj9a2JkzXkofaGFzLF5CwIes5FhJhpQh1GW5hTCZiFIg2FLU1INg/kUo2VqSLyQKjtbr/v4kFlCqNNPjxVyd3+cTXjCxUV1ICwgI7QDTUBmR50YSPm+NrXiWA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB4824.namprd10.prod.outlook.com (2603:10b6:408:12f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:41:13 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13%8]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 09:41:13 +0000
Message-ID: <c5a96de5-699a-8b5e-0e89-bfe1822e1105@oracle.com>
Date: Tue, 27 Sep 2022 02:41:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
 <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR14CA0071.namprd14.prod.outlook.com
 (2603:10b6:5:18f::48) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 083336a1-b6d0-48db-53ad-08daa06c6a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VXRUCupsQUxXCzPK6xkCFIvJZfKkBDdcD2pcPbtf+vRVHmtOiGPkd+s73nf1gCeeFuCTCN/MSQVj2uFbnhXRJcKnsslcLGnaTkUn7PyPeabHQVpV+2/DxnxTzkHY8UVS9tv/hG2y7Bx1sQEngox4DphOd7lNBpZIsmGdctX4ewLXJHgRDLKIaL7VXKTs1WU4WiTb7un+OgB5s94dRUQLMnLnOebcezCBXYO2wOHxBBlpbt84zGxZ1u30getaDzYhxqRjsHNePi2ecKegIYcT8bwQ/1ELFU74HTEI9bskg6YF90Rfj0aZjJK5+U7osqlB+dkRKbiiVZQ4Ae8rjzfA4ibRVF3q4sXTjCLkqAGqNHdi4PVGo01r9cl6pxVvEZ9GAE7KBgLeq+ic88YDv2MfIDYEwTFXt1/BRHAx3cA0YtdouyY4Gj01qMpyTgsc0qgr2qKR1pgJUThRW0vk1N6snFORyXsg8G+fqR3upx/pz1xy/gPluH3EJJaA5PFoU8k/7S8MNpjpRNZDI+l9QBV8pRqbwI8fSn3AwlPQZ0l7stFNmMkruPFTyEtuylHm+spknoEmxukFD7a/Y8wumPobdqSBByq+BesxmNpSbgDnw4KMuIEruZVe3u9lax40SptGPp3l+Tg2zh8d+yWEe33c2wrHYTgZZWXqAgRdF7X/filLcCe9jxVtPRTzcJOeZY8241gP0poq3NWmhB9a3fC+4QQ5VvYS9vMjWStXsfvrrHpFAi566UBiwvxpTvEk0slx6XC89zwTJmGJ189jXJphfeJWp5V7T7cR643Wh6Hu9xaGcytV7K/6tU0Q/th4blKRIaJL/svwtL5oZdE69jMcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(478600001)(5660300002)(6512007)(26005)(966005)(36756003)(8936002)(38100700002)(30864003)(66946007)(6486002)(7416002)(53546011)(6666004)(83380400001)(6506007)(36916002)(166002)(33964004)(41300700001)(4326008)(8676002)(66556008)(2616005)(316002)(31696002)(54906003)(6916009)(186003)(66476007)(31686004)(86362001)(2906002)(66899015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0dZODhiTi9wdmgwKzJ4ajlpeWc5QXhMVjZMNllXcEJ2ZVdaMit6eXQ3NHZ2?=
 =?utf-8?B?dVNwT3ExcWZ1b1ByTVpRL2piUHRHRVVPV3NtQmNQaUNqR3JpL0JLU3VYZXIw?=
 =?utf-8?B?YlRyNVU0Z1FwbTVWelp5L0hqRGxsSFVhRU83NGtzb1N1T0NiOGx2L3lBU0kr?=
 =?utf-8?B?dlFQV04rdFVQUEQzOGdFeDRCNTZKWWQvTlVOZ2hpSjJ5eVVoSEhrKzZkYkhx?=
 =?utf-8?B?bFpvVnVSK1FJRnllYUtpdFYrNitMOEVoVEw1SkNJb2ZGMXIvSHhXdEpsYlJt?=
 =?utf-8?B?SmNUSnNNT05leUFrRkYyMEhqNlBKWHpIU2FJajNsVHUvMGdjdE50WGR4YXNQ?=
 =?utf-8?B?andidlpNelIyZnpXcnd1VmpldUxTS0ZjajZxUmZDSTdKTU8xUVhJelB6ME9M?=
 =?utf-8?B?MklPS3AzdXVGN09GV0ZVa2FqQTNIVlZ6RHdCRXo2ZnNET2dMNGRvbTVnSEQz?=
 =?utf-8?B?NHAyU1hzZUhhQ1hUSDQ4dE5yYnJJQm1MOUd3aW81R3R2NHBOMzRlZ3RkYlA4?=
 =?utf-8?B?YlRiOWxYUzZhVkNzSWwvUWdnRFJDV0R6c0dtNG1KNFc3WTNhVHBIMTk4a1FQ?=
 =?utf-8?B?MVJTdkZPRnlzTXhmR2lvQlUva3o4MUo2akkrcSs1UFFwYUppUXpvSk1Bam42?=
 =?utf-8?B?ZTNDY0xPalp2RDREUGlRRUlTbEEvY29jRHF5TSs5T3BHOFdqY0dycFd1VWNI?=
 =?utf-8?B?ejhUenFXMmxuSVQwNi9sTU9hc2ZrM1JmRnBOM0F5bDcvOEZrNEJtdktsQXd0?=
 =?utf-8?B?eW8vNzZydDNlWnZaZlFleEdYZnVPQWFkZ0FIRk0yVTBOR1ZQRzBQdDRRS3Iy?=
 =?utf-8?B?azZqb2Yrc3dTUFNuUWx1SXkxVlhVM2FpTjRNUDJablVHblhWdk1jNVRKZGt2?=
 =?utf-8?B?R3oya0VRQ1JRZkJGYzRFNnJaVUw2Uks5OXJOektUcm1hMnpNZFNXZUYxemcw?=
 =?utf-8?B?amRoSFhVK2ltaDFzK1dSUEpmSHBmZ2xYMTMzc1lvZkd1TER2STBlZnBjRlVY?=
 =?utf-8?B?N0poRUlyTDc2eWZTQVJ6UWdnaWhZM2JDczRYNkVjeEVrZmo2MkFiYmhLT1Zr?=
 =?utf-8?B?NDErZUZlaFdFUHdXR1NzTXFCelUyYmxSSmRTL2RuUWd4YzNTMEc5NjZwY3FV?=
 =?utf-8?B?MktnTnpZYkJUSEZkM0VZbE40dU9oQnV6ODhMUlJEWmdTSnFCSy9JcWg0MlRX?=
 =?utf-8?B?Q0p4eTJNeVFoK2dQeGVMclUvcVkvcnNOMVJoWHdMQy9pZjBDTE1tQmY4WlNN?=
 =?utf-8?B?TnhPSG1wRjVtRmwxaW5OS0toVTA2TXFNWWQvNWwyNTJMOTdKbmc5aktlTXdJ?=
 =?utf-8?B?Sk04TXVtSmVxNGhuM2VjUG5SRk5Td3RjK3VkWFBMRVVML1dzSFQ1bFZRcWlM?=
 =?utf-8?B?Ym5ZbzUza1lrL2N1WUJIaXpSSmRoZ1B6d0V5alpKNlJNQW90MlcyejFDUXY4?=
 =?utf-8?B?UEk3ayt3SHVabU5iU0pQUWU4SGprU2RBelRMcEljdXBuTTlZSVBUTW91UHZC?=
 =?utf-8?B?bmR3M2hCMFNrRU52OEJvNi9PMis0ZTB3MWU0aTFXOEozRFMyNmsrZmFYdHpo?=
 =?utf-8?B?K3I5TVh6YWZmeENOb1JxVC82NVBxOGdTZ0U4MFQxc2lLRC9YazZGRjE5YjdK?=
 =?utf-8?B?UHp5UU1KWnlEYnJZSEFmL2VBK2pWZThTV21LK3hIS01tQkVjMnFBbUZFekRY?=
 =?utf-8?B?ZXVHRlpYN2dXelF1NFBmMjRHREhiU0ZNRkZWVlpFYStEeGJHc0ZLZ08xY01N?=
 =?utf-8?B?d0J0M1VJTmpQQ1A5N0ZWYjlFUFJvTnB3OTVtOXdGQk1KcnpON3lrQ2dxWjRx?=
 =?utf-8?B?MzdUcXZ0VWZOY1hhd3RpTzVqdUZVMTZsZ01XQ2VRN29nd2d5QnRaYmJwVitM?=
 =?utf-8?B?ajhrVkViczB3RUlkKy9LbVhta2xUUHFLYkRSWUpRTTFtTDMxV0RIdmhmemNO?=
 =?utf-8?B?RDJ4TVBxenZ0cnJmNUJvQUx2VW41emVKY3JJYmh6Z3RqbTVDV093VVQyc1VB?=
 =?utf-8?B?cnRmUGkvUjRlRWU2NGxDM0tLck9pMHovV1NBYVA5UTZHWEJ6R1ViMlY0Rm9R?=
 =?utf-8?B?OTEzMUJlOWkxQTZpMEFpSTFtY01yYmc4cXNwN09tTnB1TXUzMHRLSmkzUE56?=
 =?utf-8?Q?TUoTyxDAd/UtLc7du7mw82lA7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083336a1-b6d0-48db-53ad-08daa06c6a49
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 09:41:12.8943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDUy0JfaP8EQwlJZdNcohAWdy2quBfmI46Wa1qcpk1avXicMnqpL+g2zZzkk9XNwBrGlDd4p6aIWmYK5tG6lPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270057
X-Proofpoint-ORIG-GUID: KnWFLnLKl7GlO0S7QtHXkm1oCewib5Hv
X-Proofpoint-GUID: KnWFLnLKl7GlO0S7QtHXkm1oCewib5Hv
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 Yongji Xie <xieyongji@bytedance.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============5673252994065809161=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5673252994065809161==
Content-Type: multipart/alternative;
 boundary="------------OPVXMuG5tY6NPojYb4PRJo35"
Content-Language: en-US

--------------OPVXMuG5tY6NPojYb4PRJo35
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/26/2022 8:59 PM, Jason Wang wrote:
> On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>
>>
>> On 9/26/2022 12:11 AM, Jason Wang wrote:
>>
>> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>
>>
>> On 9/21/2022 7:43 PM, Jason Wang wrote:
>>
>> This patch implements features provisioning for vdpa_sim_net.
>>
>> 1) validating the provisioned features to be a subset of the parent
>>      features.
>> 2) clearing the features that is not wanted by the userspace
>>
>> For example:
>>
>> # vdpa mgmtdev show
>> vdpasim_net:
>>     supported_classes net
>>     max_supported_vqs 3
>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>>
>> Sighs, not to blame any one and it's perhaps too late, but this
>> "dev_features" attr in "mgmtdev show" command output should have been
>> called "supported_features" in the first place.
>>
>> Not sure I get this, but I guess this is the negotiated features actually.
>>
>> Actually no, that is why I said the name is a bit confusing and "supported_features" might sound better.
> You're right, it's an mgmtdev show actually.
>
>> This attribute in the parent device (mgmtdev) denotes the real device capability for what virtio features can be supported by the parent device. Any unprivileged user can check into this field to know parent device's capability without having to create a child vDPA device at all. The features that child vDPA device may support should be a subset of, or at most up to what the parent device offers. For e.g. the vdpa device dev1 you created below can expose less or equal device_features bit than 0x308820028 (MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be no more than what the parent device can actually support.
> Yes, I didn't see anything wrong with "dev_features",
Yep, it didn't appear to me anything wrong either at first sight, then I 
gave my R-b on the series introduced this attribute. But it's not a 
perfect name, either, on the other hand. Parav later pointed out that 
the corresponding enum definition for this attribute should follow 
pre-existing naming convention that we should perhaps do 
s/VDPA_ATTR_DEV_SUPPORTED_FEATURES/VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES/ 
to get it renamed, as this is a mgmtdev level attribute, which I agree. 
Now that with the upcoming "device_features" attribute (vdpa dev level) 
from this series, it's subject to another confusions between these two 
similar names, but actually would represent things at different level. 
While all other attributes in "mgmtdev dev show" seem to be aligned with 
the "supported_" prefix, e.g. supported_classes, max_supported_vqs, from 
which I think the stance of device is already implied through "mgmtdev" 
in the command. For the perspective of clarify and easy distinction, 
"supported_features" seems to be a better name than "dev_features".

>   it aligns to the
> virtio spec which means the features could be used to create a vdpa
> device. But if everyone agree on the renaming, I'm fine.
Never mind, if it's late don't have to bother.

>
>>
>> I think Ling Shan is working on reporting both negotiated features
>> with the device features.
>>
>> Does it imply this series is connected to another work in parallel? Is it possible to add a reference in the cover letter?
> I'm not sure, I remember Ling Shan did some work to not block the
> config show in this commit:
>
> commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
> Author: Zhu Lingshan<lingshan.zhu@intel.com>
> Date:   Fri Jul 22 19:53:07 2022 +0800
>
>      vDPA: !FEATURES_OK should not block querying device config space
>
> We need some changes in the vdpa tool to show device_features
> unconditionally in the "dev config show" command.
That's true, I think I ever pointed it out to Lingshan before, that it's 
not needed to bother exposing those config space fields in "dev config 
show" output, if the only intent is for live migration of device 
features between nodes. For vDPA live migration, what cares most is 
those configuration parameters specified on vdpa creation, and userspace 
VMM (QEMU) is supposed to take care of saving and restoring live device 
states. I think it's easier to extend "vdpa dev show" output to include 
device_features and other config params as well, rather than count on 
validity of various config space fields.

https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/

It's not just insufficient, but sometimes is incorrect to create vDPA 
device using the config space fields.  For instance, MAC address in 
config space can be changed temporarily (until device reset) via ctrl_vq 
VIRTIO_NET_CTRL_MAC_ADDR_SET command. It's incorrect to create vDPA 
using the MAC address shown in the config space.  Another example, if 
the source vDPA device has MAC address table size limit of 100, then in 
the destination we should pick parent device with size limit no smaller 
than that, and create vDPA on remote node matching the exact same size. 
There's nothing config space field can assist here.

One example further, in the future, if we are going to introduce 
mandatory feature (for e.g. VERSION_1, RING_PACKED) that the device is 
unable to support the opposite case, the destination device should be 
created with equally same mandatory device features, which only vDPA 
creation parameters should matter. While I can't think of a case that 
the mgmt software or live migration tool would have to count on config 
space fields only.


>
>>
>> 1) provision vDPA device with all features that are supported by the
>>      net simulator
>>
>> # vdpa dev add name dev1 mgmtdev vdpasim_net
>> # vdpa dev config show
>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>     negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>>
>> Maybe not in this patch, but for completeness for the whole series,
>> could we also add device_features to the output?
>>
>> Lingshan, could you please share your thoughts or patch on this?
>>
>> Noted here the device_features argument specified during vdpa creation is introduced by this series itself, it somehow slightly changed the original semantics of what device_features used to be.
> I'm not sure I get this, we don't support device_features in the past
> and it is used to provision device features to the vDPA device which
> seems to be fine.
Before this change, only look at the dev_features in "mgmtdev show" and 
remember creation parameters is sufficient to get to all needed info for 
creating vDPA at destination. After this change, dev_features in 
"mgmtdev show" becomes less relevant, as it would need to remember vdpa 
creation parameters plus the device_features attribute. While this 
series allows cross vendor live migration, it would complicate the 
implementation of mgmt software, on the other hand.

>
>>
>> When simply look at the "vdpa dev config show" output, I cannot really
>> tell the actual device_features that was used in vdpa creation. For e.g.
>> there is a missing feature ANY_LAYOUT from negotiated_features compared
>> with supported_features in mgmtdev, but the orchestration software
>> couldn't tell if the vdpa device on destination host should be created
>> with or without the ANY_LAYOUT feature.
>>
>> I think VERSION_1 implies ANY_LAYOUT.
>>
>> Right, ANY_LAYOUT is a bad example. A good example might be that, I knew the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I don't find it in negotiated_features.
> I think we should use the features that we got from "mgmtdev show"
> instead of "negotiated features".
That was how it's supposed to work previously, but with this series, I 
think the newly introduced device_features will be needed instead of the 
one in "mgmtdev show".

>
>> On the migration destination node, the parent device does support all features as the source offers, including CTRL_MAC_ADDR. What device features you would expect the mgmt software to create destination vdpa device with, if not otherwise requiring mgmt software to remember all the arguments on device creation?
> So in this example, we need use "dev_features" so we get exact the
> same features after and operation as either src or dst.
If the device_features vDPA created with at the source doesn't include 
CTRL_MAC_ADDR even though parent supports it, then the vDPA to be 
created at the destination shouldn't come with CTRL_MAC_ADDR either, 
regardless of whether or not CTRL_MAC_ADDR is present in destination 
"mgmtdev show".

However, if just taking look at negotiated_features, some mgmt software 
implementations which don't persist the creation parameters can't get 
the device features a certain vDPA device at the source node was created 
with.

>
>> SOURCE# vdpa mgmtdev show
>> vdpasim_net:
>>     supported_classes net
>>     max_supported_vqs 3
>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>> SOURCE# vdpa dev config show
>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>     negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>
>> DESTINATION# vdpa mgmtdev show
>> vdpasim_net:
>>     supported_classes net
>>     max_supported_vqs 3
>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>>
>>   But it should be sufficient to
>> use features_src & feature_dst in this case. Actually, it should work
>> similar as to the cpu flags, the management software should introduce
>> the concept of cluster which means the maximal set of common features
>> is calculated and provisioned during device creation to allow
>> migration among the nodes inside the cluster.
>>
>> Yes, this is one way mgmt software may implement, but I am not sure if it's the only way. For e.g. for cpu flags, mgmt software can infer the guest cpus features in use from all qemu command line arguments and host cpu features/capability, which doesn't need to remember creation arguments and is easy to recover from failure without having to make the VM config persistent in data store. I thought it would be great if vdpa CLI design could offer the same.
> One minor difference is that we have cpu model abstraction, so we can
> have things like:
>
> ./qemu-system-x86_64 -cpu EPYC
>
> Which implies the cpu features/flags where vDPA doesn't have. But
> consider it's just a 64bit (or 128 in the future), it doesn't seems to
> be too complex for the management to know, we probably need to start
> from this and then we can try to introduce some generation/model after
> it is agreed on most of the vendors.
What you refer to is the so-called named model for CPU flags. I think 
it's a good addition to have some generation or named model defined for 
vDPA. But I don't get the point for how it relates to exposing the 
actual value of device features? Are you saying in this case you'd 
rather expose the model name than the actual value of feature bits? 
Well, I think we can expose both in different fields when there's really 
such a need.

BTW with regard to the cpu model in mgmt software implementation, the 
one implemented in libvirt is a mixed "Host model" [1] with taking 
advantage of QEMU named model and exposing additional individual CPU 
features that gets close to what host CPU offers. I think this implies 
that mgmt software should have to understand what the model name really 
means in terms of individual CPU features, so having feature bit value 
exposed will just do more help if vDPA goes the same way.


Regards,
-Siwei

[1] 
https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm

>
> Thanks
>
>> Thanks,
>> -Siwei
>>
>>
>> Thanks
>>
>> Thanks,
>> -Siwei
>>
>>
>> 2) provision vDPA device with a subset of the features
>>
>> # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
>> # vdpa dev config show
>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>     negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>
>> Reviewed-by: Eli Cohen<elic@nvidia.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> index 886449e88502..a9ba02be378b 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>        dev_attr.work_fn = vdpasim_net_work;
>>        dev_attr.buffer_size = PAGE_SIZE;
>>
>> +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>> +             if (config->device_features &
>> +                 ~dev_attr.supported_features)
>> +                     return -EINVAL;
>> +             dev_attr.supported_features &=
>> +                      config->device_features;
>> +     }
>> +
>>        simdev = vdpasim_create(&dev_attr);
>>        if (IS_ERR(simdev))
>>                return PTR_ERR(simdev);
>> @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>>        .id_table = id_table,
>>        .ops = &vdpasim_net_mgmtdev_ops,
>>        .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>> -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>> +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>> +                          1 << VDPA_ATTR_DEV_FEATURES),
>>        .max_supported_vqs = VDPASIM_NET_VQ_NUM,
>>        .supported_features = VDPASIM_NET_FEATURES,
>>    };
>>
>>

--------------OPVXMuG5tY6NPojYb4PRJo35
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 9/26/2022 8:59 PM, Jason Wang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Sep 27, 2022 at 9:02 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">


On 9/26/2022 12:11 AM, Jason Wang wrote:

On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:


On 9/21/2022 7:43 PM, Jason Wang wrote:

This patch implements features provisioning for vdpa_sim_net.

1) validating the provisioned features to be a subset of the parent
    features.
2) clearing the features that is not wanted by the userspace

For example:

# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

Sighs, not to blame any one and it's perhaps too late, but this
&quot;dev_features&quot; attr in &quot;mgmtdev show&quot; command output should have been
called &quot;supported_features&quot; in the first place.

Not sure I get this, but I guess this is the negotiated features actually.

Actually no, that is why I said the name is a bit confusing and &quot;supported_features&quot; might sound better.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You're right, it's an mgmtdev show actually.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This attribute in the parent device (mgmtdev) denotes the real device capability for what virtio features can be supported by the parent device. Any unprivileged user can check into this field to know parent device's capability without having to create a child vDPA device at all. The features that child vDPA device may support should be a subset of, or at most up to what the parent device offers. For e.g. the vdpa device dev1 you created below can expose less or equal device_features bit than 0x308820028 (MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be no more than what the parent device can actually support.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, I didn't see anything wrong with &quot;dev_features&quot;,</pre>
    </blockquote>
    Yep, it didn't appear to me anything wrong either at first sight,
    then I gave my R-b on the series introduced this attribute. But it's
    not a perfect name, either, on the other hand. Parav later pointed
    out that the corresponding enum definition for this attribute should
    follow pre-existing naming convention that we should perhaps do
    s/VDPA_ATTR_DEV_SUPPORTED_FEATURES/VDPA_ATTR_MGMTDEV_SUPPORTED_FEATURES/
    to get it renamed, as this is a mgmtdev level attribute, which I
    agree. Now that with the upcoming &quot;device_features&quot; attribute (vdpa
    dev level) from this series, it's subject to another confusions
    between these two similar names, but actually would represent things
    at different level. While all other attributes in &quot;mgmtdev dev show&quot;
    seem to be aligned with the &quot;supported_&quot; prefix, e.g.
    supported_classes, max_supported_vqs, from which I think the stance
    of device is already implied through &quot;mgmtdev&quot; in the command. For
    the perspective of clarify and easy distinction,
    &quot;supported_features&quot; seems to be a better name than &quot;dev_features&quot;.<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap=""> it aligns to the
virtio spec which means the features could be used to create a vdpa
device. But if everyone agree on the renaming, I'm fine.</pre>
    </blockquote>
    Never mind, if it's late don't have to bother. <br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

I think Ling Shan is working on reporting both negotiated features
with the device features.

Does it imply this series is connected to another work in parallel? Is it possible to add a reference in the cover letter?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm not sure, I remember Ling Shan did some work to not block the
config show in this commit:

commit a34bed37fc9d3da319bb75dfbf02a7d3e95e12de
Author: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Date:   Fri Jul 22 19:53:07 2022 +0800

    vDPA: !FEATURES_OK should not block querying device config space

We need some changes in the vdpa tool to show device_features
unconditionally in the &quot;dev config show&quot; command.</pre>
    </blockquote>
    That's true, I think I ever pointed it out to Lingshan before, that
    it's not needed to bother exposing those config space fields in &quot;dev
    config show&quot; output, if the only intent is for live migration of
    device features between nodes. For vDPA live migration, what cares
    most is those configuration parameters specified on vdpa creation,
    and userspace VMM (QEMU) is supposed to take care of saving and
    restoring live device states. I think it's easier to extend &quot;vdpa
    dev show&quot; output to include device_features and other config params
    as well, rather than count on validity of various config space
    fields.<br>
    <br>
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/">https://lore.kernel.org/virtualization/454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com/</a><br>
    <br>
    It's not just insufficient, but sometimes is incorrect to create
    vDPA device using the config space fields.&nbsp; For instance, MAC
    address in config space can be changed temporarily (until device
    reset) via ctrl_vq VIRTIO_NET_CTRL_MAC_ADDR_SET command. It's
    incorrect to create vDPA using the MAC address shown in the config
    space.&nbsp; Another example, if the source vDPA device has MAC address
    table size limit of 100, then in the destination we should pick
    parent device with size limit no smaller than that, and create vDPA
    on remote node matching the exact same size. There's nothing config
    space field can assist here.<br>
    <br>
    One example further, in the future, if we are going to introduce
    mandatory feature (for e.g. VERSION_1, RING_PACKED) that the device
    is unable to support the opposite case, the destination device
    should be created with equally same mandatory device features, which
    only vDPA creation parameters should matter. While I can't think of
    a case that the mgmt software or live migration tool would have to
    count on config space fields only.<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

1) provision vDPA device with all features that are supported by the
    net simulator

# vdpa dev add name dev1 mgmtdev vdpasim_net
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM

Maybe not in this patch, but for completeness for the whole series,
could we also add device_features to the output?

Lingshan, could you please share your thoughts or patch on this?

Noted here the device_features argument specified during vdpa creation is introduced by this series itself, it somehow slightly changed the original semantics of what device_features used to be.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm not sure I get this, we don't support device_features in the past
and it is used to provision device features to the vDPA device which
seems to be fine.</pre>
    </blockquote>
    Before this change, only look at the dev_features in &quot;mgmtdev show&quot;
    and remember creation parameters is sufficient to get to all needed
    info for creating vDPA at destination. After this change,
    dev_features in &quot;mgmtdev show&quot; becomes less relevant, as it would
    need to remember vdpa creation parameters plus the device_features
    attribute. While this series allows cross vendor live migration, it
    would complicate the implementation of mgmt software, on the other
    hand.<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

When simply look at the &quot;vdpa dev config show&quot; output, I cannot really
tell the actual device_features that was used in vdpa creation. For e.g.
there is a missing feature ANY_LAYOUT from negotiated_features compared
with supported_features in mgmtdev, but the orchestration software
couldn't tell if the vdpa device on destination host should be created
with or without the ANY_LAYOUT feature.

I think VERSION_1 implies ANY_LAYOUT.

Right, ANY_LAYOUT is a bad example. A good example might be that, I knew the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but I don't find it in negotiated_features.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think we should use the features that we got from &quot;mgmtdev show&quot;
instead of &quot;negotiated features&quot;.</pre>
    </blockquote>
    That was how it's supposed to work previously, but with this series,
    I think the newly introduced device_features will be needed instead
    of the one in &quot;mgmtdev show&quot;.<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On the migration destination node, the parent device does support all features as the source offers, including CTRL_MAC_ADDR. What device features you would expect the mgmt software to create destination vdpa device with, if not otherwise requiring mgmt software to remember all the arguments on device creation?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
So in this example, we need use &quot;dev_features&quot; so we get exact the
same features after and operation as either src or dst.</pre>
    </blockquote>
    If the device_features vDPA created with at the source doesn't
    include CTRL_MAC_ADDR even though parent supports it, then the vDPA
    to be created at the destination shouldn't come with CTRL_MAC_ADDR
    either, regardless of whether or not CTRL_MAC_ADDR is present in
    destination &quot;mgmtdev show&quot;.<br>
    <br>
    However, if just taking look at negotiated_features, some mgmt
    software implementations which don't persist the creation parameters
    can't get the device features a certain vDPA device at the source
    node was created with. <br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
SOURCE# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
SOURCE# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM

DESTINATION# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

 But it should be sufficient to
use features_src &amp; feature_dst in this case. Actually, it should work
similar as to the cpu flags, the management software should introduce
the concept of cluster which means the maximal set of common features
is calculated and provisioned during device creation to allow
migration among the nodes inside the cluster.

Yes, this is one way mgmt software may implement, but I am not sure if it's the only way. For e.g. for cpu flags, mgmt software can infer the guest cpus features in use from all qemu command line arguments and host cpu features/capability, which doesn't need to remember creation arguments and is easy to recover from failure without having to make the VM config persistent in data store. I thought it would be great if vdpa CLI design could offer the same.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
One minor difference is that we have cpu model abstraction, so we can
have things like:

./qemu-system-x86_64 -cpu EPYC

Which implies the cpu features/flags where vDPA doesn't have. But
consider it's just a 64bit (or 128 in the future), it doesn't seems to
be too complex for the management to know, we probably need to start
from this and then we can try to introduce some generation/model after
it is agreed on most of the vendors.</pre>
    </blockquote>
    What you refer to is the so-called named model for CPU flags. I
    think it's a good addition to have some generation or named model
    defined for vDPA. But I don't get the point for how it relates to
    exposing the actual value of device features? Are you saying in this
    case you'd rather expose the model name than the actual value of
    feature bits? Well, I think we can expose both in different fields
    when there's really such a need.<br>
    <br>
    BTW with regard to the cpu model in mgmt software implementation,
    the one implemented in libvirt is a mixed &quot;Host model&quot; [1] with
    taking advantage of QEMU named model and exposing additional
    individual CPU features that gets close to what host CPU offers. I
    think this implies that mgmt software should have to understand what
    the model name really means in terms of individual CPU features, so
    having feature bit value exposed will just do more help if vDPA goes
    the same way.<br>
    <br>
    <br>
    Regards,<br>
    -Siwei<br>
    <br>
    [1]
<a class="moz-txt-link-freetext" href="https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm">https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html#two-ways-to-configure-cpu-models-with-qemu-kvm</a><br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Thanks,
-Siwei


Thanks

Thanks,
-Siwei


2) provision vDPA device with a subset of the features

# vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Reviewed-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a>
Signed-off-by: Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a>
---
  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 886449e88502..a9ba02be378b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
      dev_attr.work_fn = vdpasim_net_work;
      dev_attr.buffer_size = PAGE_SIZE;

+     if (config-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+             if (config-&gt;device_features &amp;
+                 ~dev_attr.supported_features)
+                     return -EINVAL;
+             dev_attr.supported_features &amp;=
+                      config-&gt;device_features;
+     }
+
      simdev = vdpasim_create(&amp;dev_attr);
      if (IS_ERR(simdev))
              return PTR_ERR(simdev);
@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
      .id_table = id_table,
      .ops = &amp;vdpasim_net_mgmtdev_ops,
      .config_attr_mask = (1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MACADDR |
-                          1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MTU),
+                          1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MTU |
+                          1 &lt;&lt; VDPA_ATTR_DEV_FEATURES),
      .max_supported_vqs = VDPASIM_NET_VQ_NUM,
      .supported_features = VDPASIM_NET_FEATURES,
  };


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------OPVXMuG5tY6NPojYb4PRJo35--


--===============5673252994065809161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5673252994065809161==--


