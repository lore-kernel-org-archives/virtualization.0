Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB66EC32772
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:09:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26BE660ECD;
	Tue, 16 Aug 2022 08:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26BE660ECD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ydb9sdn6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=OYzs4tJ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h_z2MisVhM8R; Tue, 16 Aug 2022 08:09:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 740A060E77;
	Tue, 16 Aug 2022 08:09:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 740A060E77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4507DC0032;
	Tue, 16 Aug 2022 08:09:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7353AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D4208149D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:08:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D4208149D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=ydb9sdn6; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=OYzs4tJ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fn6SPmDJIxOx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68FC081455
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68FC081455
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:08:58 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G3TB9m025363;
 Tue, 16 Aug 2022 08:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : from : to : cc : references : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=T3lrS2/RHbcKZ1q/r61b2mqIVA2Qgp7o6OiRdU3b4KY=;
 b=ydb9sdn6w/okyjEgUYzSQIdMPy70XAKvr/GcP0OAaHZbgRkrKVs/7mICNdDpPyeTJGDo
 VaMQOdDRLb5nbK+atrn7xnkJxwLqflT2goCRNolYwfepOfwBkW4cJX+HvixW/FMHipsI
 CHtC/1PnfCWOs6jdz9o1FVdQXUc88vr3jim+acRqDpjUjMsPE3qbdn/l6qJSCkwHPXwv
 riuN5RZ9mlr5KSh/qKh42dKbxrAj70Va6/6Fu5j/W/neF92N6yj8Blut1StGmL/TQLn6
 0PSLLFg4kUO8IkkCc6LYiJtuP0rW0utnMHM8XpWgTV7IEq6ZHD5VeusEDoE3o+Qr+7j8 Pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2ccn3sg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 08:08:54 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27G80TH2035012; Tue, 16 Aug 2022 08:08:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d87bd8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 08:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVWkEk7EG6Cb52j8XgdRHTOzEde8/DcqXP4bF7oGTORgXlLMB+fnbLvDdJgmiUdQ9RaWXOjshLELK7oE88gtQ8AVB3Vvn9lNpQ3+AbydAQ27vPpMf/TyBdeL3eHVf6w9AdTBBFlSV8mGv5xg1EWs1+vbqr+3Ta+ZdMcc5wP7PNMUyTlyxF+jLiqP9FJ77HQbvi8L4RcayOpG0sHg7qEW8jn3MOmbqCYgTFs1aY3wfL0EKqWZ8zRrZsrKDCtNRYKke9K2GovROjL+26wxxGHCMjQzJU1uktlKDISh+d2/wgzFO8Mzp8qyeOXDPH3CYQdz++Zu2epQgOLA9cbRc2l7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3lrS2/RHbcKZ1q/r61b2mqIVA2Qgp7o6OiRdU3b4KY=;
 b=GSH8YXlT54mNvk+TWtX2H1norpUIhuBWZlYW3/iIQosn2nsJfOEeQl0mf1y0bxZ9JKvnAOWZNdJb15qZSkEZAeB7KJxcT/hmKCoJZ4lNcF4M3rbPHbgFGe6uNth6DdI8t42AiG2g7LEHkbFM1BRqMzcBoR3FPYo4cqnkr6s+X0tvzJv5Pcpj8w8iu9NlJ6t12o5oS0KCc4Tgo3XSpZpU/H2gpykepHE8IVM14GFImjWOTTNprk9qipxnaY9wz7VGkV0Dcyy/a1E23C5DJxiH309Fwf1fA26L5EP2Pfn1HBGkkVy085D0DUpE/N+fw9zUKQRu6WOYbkBfIs9Evgmbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3lrS2/RHbcKZ1q/r61b2mqIVA2Qgp7o6OiRdU3b4KY=;
 b=OYzs4tJ7Bari2ygplHFQZd26LhdAZkkXFAxtQ56QjRpU4ip3Gx4FbtU0yG2zw23gfS44yizd4hikMszrGCX8NvzEYQsFJOKRb6iA02mX//cvoSAsWz4OZd5Nf9goS11oiM1zPQAO3KVL4CLPkwi6oXnNXxCi19NqOdrxw9U+aqw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BLAPR10MB5140.namprd10.prod.outlook.com (2603:10b6:208:320::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 08:08:50 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 08:08:50 +0000
Message-ID: <517a5f0b-e484-abdc-3ddd-7e46d8b7ff7e@oracle.com>
Date: Tue, 16 Aug 2022 01:08:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
 mst@redhat.com
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
X-ClientProxiedBy: SN7PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:806:121::10) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63e4441a-81dc-4b8f-9357-08da7f5e8d98
X-MS-TrafficTypeDiagnostic: BLAPR10MB5140:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ex2VWCbr+62TgY+E6Pd83jqBEZrfKHAHoF+1sWC4HKOpZH80+8GklMoEiBOIXO7/c/P5tY6M/6qY4de4/E833G3vK80ympPpNhOgrJShCFJWU2pP+rIeALrbP1f8T3b/qGgwOhiRqxVIlHXj16yC1fBFoidn065gGv2vFVZxU2ojOYZqQQoAb4ZtzjdZW4btPX7hWFOylN+NMdC2SpZPun6zlwXKsthsEDg0htbOY0CpfSEIYsSBJ1p4Rx3+VJuigmicNoTsp37ph4E8Gq4mW/6CvoZAeZO0u/s1uq9LLpMu9JPkEwfb7Ze3K4x13SUez0rByfMDEs5Eq43dFX4H9xsWaqxrvLdsKvN4hquDBYBbY3PuL3AHrJJSwW8bRy9v17mgp0H0f8T2TC+84SgUHrsdqlZvqiAcmrCuU4tnW7uNfeqC5zZwOfygtaaCymOSfo9Y/0Mj5f3e08QpzI6Njo/sU8ZN/CMTLVd1tIkh6tueKDGtkRWJdOfCUgxOtkv0Ms25D3eoZGJ2EXI/gI42nB6tq7lQ6ibyWG9+lGDklEHelhcb1mc4Q6HX9JMeC8TKkuJyG8XBpD8FTBqbkYN8faoIvIbzbERxP4RNKWlpRAhAR/E9bTNt+lfM0tyZaR40THeoq9LbEMYC6lqdU1xvq70XOfv0P1E0DxnAcEf2G5txgy6PJN/ARuBD2Rm/YEQ8+9PxWg5DsYRBbnuhUqLVzr982Hg/U46Ag0XTCIft5inbygvK2QeSBB8XS+YUrf7GAff4HrMYpwlpc1Hl0jhuHTUCwT5nZX8RTiEBspfsAAhPGDwRKZ1SftJvFYUAeAKEQy068156ucBHlpFVoCCKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(366004)(346002)(39860400002)(136003)(376002)(2616005)(186003)(478600001)(6486002)(38100700002)(6666004)(41300700001)(316002)(6512007)(5660300002)(53546011)(2906002)(6506007)(8676002)(8936002)(31686004)(66946007)(66556008)(33964004)(36916002)(26005)(4326008)(31696002)(36756003)(86362001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGR3RE9zZEJ3NmpJWUFnZFBvVUp2Y0srbUpTVnl3c05jNDRkc085bWRmWlN1?=
 =?utf-8?B?VHR3NDViTkVJRlg0TndHSTRaY2hiNGdUTnlKdU5yOHh1NjJCbHFtdG5VYXkw?=
 =?utf-8?B?RlgwV0UwbGNOOXV5NFd2R3k2dTZzcHhGZlAxdHZnSGZpSXB6VW03dkcrVGxy?=
 =?utf-8?B?TmtPTnpqSGJlSWhvVTZxbWx5NlNqV1h6ek5QZkNmaWluRlJJMVo0ZFk2dUZL?=
 =?utf-8?B?YStKYnppY2hicnZOTURjZ3dudEVKZlVoMU1hS281NTVxUTZ6OFBsK3RETW5L?=
 =?utf-8?B?YTJPMGpCVFlIT1hDZnpWZGYzTkp6T2t4ZkNHbTFXcjMrTFQ4K3dTSTM2dkdO?=
 =?utf-8?B?MUdUcmZFQmNmczZFdDhYRnZidy9KQjh5OVhLbEdWWXhpL3VnWnorS1ZkZFNa?=
 =?utf-8?B?akwwSFVXejBKb0xFbVpQazA3bE9FWFIzOWUvMGRncThsalNGaDBlTEpmVGk2?=
 =?utf-8?B?VlZIOTZtM25VVFFLanJLeXNITE1xMGFUWStZT1pmeVNXenVoaUErUUxoazBT?=
 =?utf-8?B?Z1Ira29BRkNuV091TUxESkVDbmFCQ3poU0dBZXBjME5TS05WWEZxSGRyRXNB?=
 =?utf-8?B?aTNXZzZxVzU4aHB3TUsyK1JhVHFwL040YUtxTGpGZHpGUU0yMSswWDFCZ1Va?=
 =?utf-8?B?ZE1VRHYxTXpyMmRtcXI1WUF2SGVnMUFBclhVTjFFV1RWTmZ5VmhQeE1JTlAy?=
 =?utf-8?B?YWxPdHRFOHlJTDRuUHVkQTVuamo2b3JCYUF4TkRxQTl5Z0xxaGNINFVXMDNy?=
 =?utf-8?B?TFZUUlVaVHBzNU9VKzk0K2lkdWFLY2NJUlgxbTNvR0pVTjFWOVc5U1pzWmpL?=
 =?utf-8?B?RW9JZDlkZWpVMVJrQzYzMzJnVEFSM1ptSHVxZ2lnSTVwOEx6V3VELzg2OWRV?=
 =?utf-8?B?WlVpVlFKZ2ZraVVzaDY4c2diSENzVnpYLy9IU2NuMWk1N094YVcvdEhyd01W?=
 =?utf-8?B?ZnJDUUo4QlM1UUh6MGZPYmQvRzg4NFhDa21KaGp6eHRQQ0pwT2JFWVFqYXp5?=
 =?utf-8?B?SU5VbXUwai84SklzeWllcDlTTS8rVU9MRTl3SDd4NVZJUXFtSVEwRnE4VjZC?=
 =?utf-8?B?dUg2RU0vZ0luZ0ZoVHRub1VuVFJnMmcwTnI4MWxZUkxnZUIrcjFIM2YzV3dM?=
 =?utf-8?B?REx1RHNUbzBkVkNIY2pOWHBVelh2RWk4aGlLbnpwa1NLeVd2S09lSEZJazdl?=
 =?utf-8?B?UTdHN2FXVUZrTFNaMjU2bFg5cGJaVGJLeTExVXFJQzRXbTZ2R2p1dU9ncW0w?=
 =?utf-8?B?TlNheEFZQmx1c29MeVhobDVVM0VENHZNOG42UjhNbi9Za0Q3ZE1LY1V3aU9r?=
 =?utf-8?B?Ym5UUnJycCt2aDNsZ1IvQStPckdiY2d0MFJYdjl2aTd3Nk52aVcvK1ZvRFg5?=
 =?utf-8?B?OFFuTWV6UU1lNmtFTWo2Q29CMi92VEQ3SkJjSHhRMkRySC8zWmthLzZraVR3?=
 =?utf-8?B?M2JDSmgrdm4wTnVJZldTSzVKZXJCTU93UGVVbHRNL1BlMTloRXBPeSt5S3lP?=
 =?utf-8?B?MDFOVnYzTEErRDQxK0cyZDVaaGRxMENOYytIVEVYRS9vd1liTkRMQmNPOGFl?=
 =?utf-8?B?WlRPQThmamc0L1J4UnpLcDI1UjVLbXVqbThZMHJ1K2lIL2NwaE5oYUVIVzM4?=
 =?utf-8?B?bVMzZVQ5N2lFZTlLcTE3N0xkbE9QRHgra0Q4ZFFlNnJSaXBBTXR5YjkxTm84?=
 =?utf-8?B?K0NIZy9aQlhwYlh4NUh2QjJxSXJBT1dWU1hPN1h4MmF3c1gzRU1qZVhnYzFI?=
 =?utf-8?B?eTZRSjU2QzFyNTBKNTdUc2IyK3RjNXhta1p5SUtxakhtMzlBOGFKS1FodEw3?=
 =?utf-8?B?eU0vUXBGVFkxalVGTzJvSnVDTVJoelZ4ejk1enloNW91ZUI5UWRQZVp2TUVS?=
 =?utf-8?B?cXhFNkdNZ1RTSkRzSGlvc1lLZ0RHMVlWQ2w1YjBiV1Nha25jZ1VGZ2ZLb2ZM?=
 =?utf-8?B?amFKZVJpTCs0elkvaVJYNG1hcTBZNllmcXlTS1V6VXRycGRpbGZQM1pROGtZ?=
 =?utf-8?B?aUhldVMwOE1ZV2ZsTVVyZ2QzL1JtSWVWbWowRzgvY2Q3WlczTE9abW9uSGlP?=
 =?utf-8?B?UzV3YmZnekFBRGJXOFdBaWlneGlyOVdaZmdWTTU0YzB6UFlHZ3NlemVWZmpE?=
 =?utf-8?Q?si0VkMBzybDAx+56w6x4tKuuz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zm9QbHBUdVYxRFhldUg1aUtFU1dQSmxxV0lUUEkzTG5INGJtUllVQjQraTNn?=
 =?utf-8?B?dDRBUVR4TkJXbUtTSktnbnpkT2JyeXRTSkRpdmY4QnhwZENMY3RoSURoZFox?=
 =?utf-8?B?MnpHTnZGdEU3VkZuWm1NMVk4eWpFK3NkbTFjaTU5Sk9ob05ZQmxLR2IyOEJ3?=
 =?utf-8?B?UThYaUdHOElDc3NaUG5mWDJsMkxsRzdKVEd2UFlOanZJVVp2TkxURUNSV1hl?=
 =?utf-8?B?M2xLZlhCUTVNRkJpM2lGeGY5VUp2YUg3SnA0MjlrbTg3bmRPdHQwWHpjenpY?=
 =?utf-8?B?Z1lndWdENWRHbVRDK2oxak1EQzl6KzZrVmdobnhzMkpjbGQvaThGc29SNDhS?=
 =?utf-8?B?NmplajFLTzBIbUNHMWx6eEJFaUIrcVpNdFJtNkF0ZHA2RzJtY3huZ2U0UXh6?=
 =?utf-8?B?TVhkOWtQQXh5dUNseDFMeWt3T2dyTFc3R290WXk2c0plbUlKTEU0L0pUdkxj?=
 =?utf-8?B?RlFLS1Qva1N5VkYzZXNRdFpmOFVXODNwbjNKSnBnOEIyMjhramkxWlJkYlp6?=
 =?utf-8?B?MWZ4ckNSbmlqOUtLME9MNFFZUFR3UWUvazlLbWVkdUhYSTJpcGVTQ21hWHZH?=
 =?utf-8?B?VmdrbkFNK3JqbW00cHdva0NGSWlmNkxmbGF4Q3B1QnBySWxRaVo0OHcxWFE4?=
 =?utf-8?B?YjRVbEUxM2xrTDBxQnFRYk90aDN4MjJCTW04VjloMVFwYjVGVG93QzU1T3pw?=
 =?utf-8?B?R2RPcWtzZExLbGtJNUZNaVJseUxRRWVRZ2kzci9LcFZZZXpJbUZldWN0N0cx?=
 =?utf-8?B?RlhPaGdqUDNZd3J1QzdiaW5lYW03WnRPUVJDVFlNYzEwcUo4QWtqY2h6WTlE?=
 =?utf-8?B?cFBrV2Y2eHZDbkdDcmpxbGEwdWVDbnlHcXNhbnlGL3FHTW5abXhoZW5XTURo?=
 =?utf-8?B?MktZbTViTUl0ZndCRWVnclNXZHN4SHlWRGJZUnk4S0c2M1QxNzJWRExhRjNJ?=
 =?utf-8?B?YmQ2SEhzd0NLTHUvalFTSlluM1Jmd09BbitibURBNzlSZDZwdVc0dVBWN3ZX?=
 =?utf-8?B?eGhYWmV2N1Rsd1NJNm1IYzYvVzEwWTZGTjJQMlVlWkJ1RUkwU0pBZUcxNC9E?=
 =?utf-8?B?N2FNSTNVUkJmdVg1dG5oMGhhcDNXSkZ5eHQxaEx4MHVOTUNJcXRoRnNHUzI0?=
 =?utf-8?B?Q25YeXc0RkdLaUZTZy90Y3pOWVptdlFieERPOTloazU2NWRTK0xQOWJIUER0?=
 =?utf-8?B?eS9objBZYlA3Uk9NMWVJUW1lczhSa05odFltVEpQRjYyYXUxV3dWTTVUQkdF?=
 =?utf-8?B?SXJhVzZkc2o1YzI1UFQ2bVN2cU5KcDUvMm1jMmVFNHFKTmU3OHJsbHhRYmR4?=
 =?utf-8?B?Ky9hbWJXZnVRYm9NZGxsSkdYWHlLaWtpNmNKSXpQWmdXN1o4bFhlZmNyMUdz?=
 =?utf-8?B?UkxXOEVYenhNTENyREZZVXJ5TmdGOHRBamNCYzRjbnRFUmdkKys1VTZYTGhE?=
 =?utf-8?B?dTRPSjhodTMyeEVTcnFYSVV5R1pCZWdJS01FTFpKS05vVUZqV0hFWjBDcERs?=
 =?utf-8?B?TjVLYUhYMTE0UmMxcVBkdHZLQ1BkNForL25VL3BUSGtsNFVnVWhyUWN4N1lW?=
 =?utf-8?B?Y2NpUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e4441a-81dc-4b8f-9357-08da7f5e8d98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 08:08:50.7773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWg8lydXe3u6TQs13xj+DiT+jgdh9CxTaW8u7lxj7Cutc6JlKQSC7WNQe1Xmnj8jAPcyqc+TKRQAc8YHCBVl5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_06,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160032
X-Proofpoint-GUID: 4SudWU5f7R34NEq0CGl6YetNAuVD47it
X-Proofpoint-ORIG-GUID: 4SudWU5f7R34NEq0CGl6YetNAuVD47it
Cc: netdev@vger.kernel.org, xieyongji@bytedance.com, gautam.dawar@amd.com,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============0767547701003776645=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0767547701003776645==
Content-Type: multipart/alternative;
 boundary="------------PuetFt01lEEREZgUTPIkyQGc"
Content-Language: en-US

--------------PuetFt01lEEREZgUTPIkyQGc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/2022 12:58 AM, Si-Wei Liu wrote:
>>
> Can you provide the context or link? It shouldn't work like this, 
> otherwise it is breaking uABI. E.g. how will a legacy/BE supporting 
> kernel/device be backward compatible with older vdpa tool (which has 
> knowledge
s/has knowledge/has no knowledge/
> of this endianness implication/assumption from day one)?
>
> -Siwei 

--------------PuetFt01lEEREZgUTPIkyQGc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 8/16/2022 12:58 AM, Si-Wei Liu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com">
      <blockquote type="cite" style="color: #007cff;"><br>
      </blockquote>
      Can you provide the context or link? It shouldn't work like this,
      otherwise it is breaking uABI. E.g. how will a legacy/BE
      supporting kernel/device be backward compatible with older vdpa
      tool (which has knowledge</blockquote>
    s/has knowledge/has no knowledge/
    <blockquote type="cite" cite="mid:9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com"> of
      this endianness implication/assumption from day one)?
      <br>
      <br>
      -Siwei
    </blockquote>
    <br>
  </body>
</html>

--------------PuetFt01lEEREZgUTPIkyQGc--

--===============0767547701003776645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0767547701003776645==--
