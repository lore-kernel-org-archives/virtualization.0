Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F43C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 22:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA15360F48;
	Tue,  9 Aug 2022 22:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA15360F48
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Gp9tXu3S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=dcS7u5Y+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFmPb9GvrmHM; Tue,  9 Aug 2022 22:55:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C144760E2A;
	Tue,  9 Aug 2022 22:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C144760E2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B548C0033;
	Tue,  9 Aug 2022 22:55:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16678C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B873981551
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:55:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B873981551
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=Gp9tXu3S; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=dcS7u5Y+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lxk1fA8a9hB9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:55:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AA7E81396
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AA7E81396
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:55:09 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279M90rv004104;
 Tue, 9 Aug 2022 22:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l4M874KSSV0PTbVRgZlwiYa7h+3syaqilBzt/1UzldE=;
 b=Gp9tXu3S0+nr23i+DnqiHj18ck3jWB2ScV+CzHG/oyfTk6kPzFD9xoJRNu+6he3tzGVW
 iA1QGvLXx+2JIXSkSG1rmvMYoNv2gzCnu1pys76gthO5tLbPg3SVZXGDFLNxjxMTcsSy
 SAJLug+jVFB1x+wAunDzvdGcu1TT78NDUxh4v8TirC8T/60lAdAe3T4fvpWLP2IRmiwh
 cNa1acGc7ndHnLOq0XINSdpuDSLqWYG0JSPrCAmv2uWj8N0iDMXwWRdE85RfOaagPk3m
 dz6M4iA7v/Kx02E61J26R5o59+bXB5Vlv33rzgS8JArXyunq1OTo5UmDse1xx0jpe0vL 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdrctm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 22:55:05 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279Kf5iT005198; Tue, 9 Aug 2022 22:55:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqhmegp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 22:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHfFfowF3jfqi3wPxE2+PWfpMpmuBayt5CPO9onkV7+sqxfagti2qKQkj6ZdMjOtMzjegKbflzNvBe66yipE6HxGGLmeTP3ro0EDvJBT/yGvc0Ic5KP0nN1CSwFrxFf4UUhfeykjzslsZyuhQEsC43PZ4YZYYq/yGxqD9o8VSBq/VrR4drmLnsxBeePSK7VGGilhrZMRdEp9jNQaxE10vCSc4On42uPt517KP9BQDtkqexwqQtVPgJJKS5OoA/emUKnearVVHDrRzwa0BLI4s2lBShZ+mtddbDTuDlntPVyDoll/CEGCw+P5PY8QWAcbjmLyNzh2VCZV4jBa97pneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4M874KSSV0PTbVRgZlwiYa7h+3syaqilBzt/1UzldE=;
 b=Wry9U+Cfez8sAzh3y7PNRFA9tdWWpn/ZfNBPxKBJ44nBFpn6ok5vOWZqZUTWzxWgaX0tE65l8TkLf4Vtgb+x+Qd3Cb7ee6bkEYOC2DT6UI27oVBKQcuFn42EGdPt/0/PDD1qC75YhBLNxcWu5kC5Z6fVICses/M+ffgo5DRwlg2QM/yX+OSeKxmMvlYVy4iDLJokNATWVusNu4W9DOBTtR0hmaORNucj/miK4jHLRJMEmSiMVW1YKKRer2/C4JqR2HKGdeiFJDOfjjEAPx+jG6X3ErPSxCbDMKPaTCfL0Ki66b6XQPijEkVRnmMRlSxwQV0NGpT3+6RZbRJBbiJpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4M874KSSV0PTbVRgZlwiYa7h+3syaqilBzt/1UzldE=;
 b=dcS7u5Y+2MY9Fo8qbDfek961JI57jL4MOOAAVM9I0Qoe/TeNzw5gaORyzLzc7yLz0mSEzLoXgBidfS6ZcGH+o+jrJIzi7danZRCWuU5P2Nq7A834GcGbMM8uylCaZOUHP9tl7ex9cp837VCQTORDGfhoEy70ypfnuv5FMN0cp9U=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CY5PR10MB5986.namprd10.prod.outlook.com (2603:10b6:930:2a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 22:55:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 22:55:01 +0000
Message-ID: <0c6c876b-1d52-bfc8-87d4-edbe6b8581bc@oracle.com>
Date: Tue, 9 Aug 2022 15:54:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
 <20220809183516-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220809183516-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:806:27::20) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea5893cf-1c8f-49b1-f39b-08da7a5a311a
X-MS-TrafficTypeDiagnostic: CY5PR10MB5986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggskyEkwvoXrFihPtgiI+mmvG8gGC3LKkadLIH7V+csM9TMJQ9V3AVfCa3O79CoRlLuu++saBmT2DBTEIjb/uPrWwMVRVnRZVGSOPyAxNsfJSV0I76nU/Qr8uml5GWQcpX409Ufu5yGHYu7QhdO6sQ0TfQ686gn9HD2EF1qFHcBP3kz26zN6TqJG/Zp3xfwOkRp5DtyllD5Rt+QPxonS/NeTltTE7wmLzttIyGwrK0HR/6CFcJPsbQaJH/ZmBGHDzZJ5vV+lxOYqFWXFy2LWt++/oH6LveJVqzsHSB9sNQeEIWc1E+Z4QQVBn7zHREzhZ2rjw+BXksVh/OUSLK2LbYHUHTSylcBKukIfXBe/hpT2vg2uq0MHf6qLtyvMJogGiqry0wFBBsySgVsWQemTGF6iY2yMqSUFf5i2yP1/anj+iizcIH2nf/eMjmBTYtPG/W4wedl/x/ecZG1JyE8uHYWLEeRCPL0LPmDxuBYKDK9KTw6ANWgjy232qnvwYn+/AC7ejp5HsUEwoAO/0kEn2ovZvaCdi1VLncsV/UBwy6ORqPCDHo26niNxMtZuD4A3Ecw4uibVwBtBamuBqAoWtEOE/X776QsSswywGVOvtUgYXX1IkU0xcZp0O1g8RCl2wuTxQaE+6X6iHxa2YXo9Hrbtc7MFoEKcwd7z5rMiwGUXQLHJ4sUTJkY98gfhScd96+FN9SycipURPPou2dFLwoO5rMi4H7WlmFMdTpAPrxDRpnM6pixP9XMpCsVnybzi9kV1a4VuErmQZICvBaJB7wtc/X7K5Rw4ubPX7ZdbFj2ZqvCQFlq63INBbcbPjITJv8mnBFE5XX4Klu23JrHV+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(376002)(366004)(136003)(346002)(396003)(31686004)(83380400001)(8676002)(66946007)(4326008)(66476007)(66556008)(38100700002)(2906002)(31696002)(8936002)(6486002)(5660300002)(6916009)(6512007)(316002)(54906003)(7416002)(186003)(26005)(478600001)(6506007)(36916002)(41300700001)(6666004)(53546011)(86362001)(36756003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1ka284N2NzMWUxdlJHNFF4ZmRqZWxSZ1lZWXlQOExHRjk5eklkcWwwQ1J5?=
 =?utf-8?B?UWlncU1LVFpXTmg5ZTRLQUNqWHZNVVo3WSt1MDdCcUFmQUgvU01HaUNFb3Ro?=
 =?utf-8?B?K09jWUNZZUF6Y1RvNFhiTnF4Z1Z0VE8xNVI1MG9BdEZmelc4ZUVFU3dkVXQx?=
 =?utf-8?B?dllhcVN6WEhGOUd3aytxM3FuM1pSR3p2R09CaFljMzd0cFJuekdaaDZGWVAx?=
 =?utf-8?B?MzFxREV4eWNYbXFWSzFjTmRmYTVFek1mNm94Q2JSY1pFR29JSjlqOWxSNnRm?=
 =?utf-8?B?a3FkUHAvUVU2WHZQUTh3S3JyNnRZMHdWR3JCOFlRYTY3dmU3V045ckRXaGwr?=
 =?utf-8?B?YXlENkxxUnpMSm5BVXIyZU9CUGlPSDhRbDJmQkRnUHV3NTVrdml1Qk5QWkRV?=
 =?utf-8?B?eno5N054Nzh0WDZCdmlqWFppcWZ6MnhQd2JqSTR4Z29XL1VSL0E5ck9JcnI1?=
 =?utf-8?B?OTV5dWovK2l0QXp1a1RaaFpNeDc2OWFIZDAxUndLeENhd2E1SitGQkQxSkc5?=
 =?utf-8?B?emZ1ZlM5b2FSVGJJTFc1YlRCNWwvUHJFbEVteFlzZW9Xd2FKV1plVVdOVGdP?=
 =?utf-8?B?bEVhYzVxK0dQVWhLbHRIK3RxUTZTTHZRSUF1UGljTjd1ejMvdjNML015SUdp?=
 =?utf-8?B?U05USGdhVmpOZk1ZUzhjdVQ5UzloMnpSckRTd1hJTEZwdElHQzB4K2V1ajIw?=
 =?utf-8?B?WUpvYjZkVll5WXVSZVdVTXhLWS9BaC9yaWlFdFFoZGV4VVEwazR6U1lrTDJv?=
 =?utf-8?B?WTZreXVZbnAzLy9CNGJMditPdDU2UjkrMXAybzZSK1dudkhGc1pQdXNRQkxS?=
 =?utf-8?B?Q2tHV3k5Zm5UVCtBVjBoWXB3RXJzQnlFSGNmVTJWYXBMUUNKQ08zTXNjalg3?=
 =?utf-8?B?MUhRWGRVbkQ3YmJ3cGZnSDRFZk41UnRQcFJFZGpndkx4U1ZWUGh0M293WHND?=
 =?utf-8?B?OWNBSHFBWGN1Z1AzbFJKaEt1c0dkMWplT2dXdkNDNnplNjY0SER3R0tkV1JB?=
 =?utf-8?B?U3RPR0xxelAxeHJFMis3dGNSaEVRMjE0a1NRb3B4SVdJYUc4ZnFkbHRBaWs4?=
 =?utf-8?B?TGg5enl4cXhDYXVCbURtaytScGlJQlhHNzRRRnp4cm1aRXJrRUdrVWNsOFlu?=
 =?utf-8?B?MWtBQ0FkbWY3MmQ3WWE1SS9DTFEzYmZRdER1WXc1V3o2QXVnUTNEbldaWjJj?=
 =?utf-8?B?ZTg4ZS9Sa2JRMkxpeGRZTHJNUENvVWs5dUt2NlRSZTlKTm5QeUNSQXNTOHFk?=
 =?utf-8?B?czBOdUNFVHAvbzFLem05MkZodHJ0RVZhSnlYcGpITEViQ1daYmd1eE9CNjMz?=
 =?utf-8?B?UFFjQmRXc2J0QTREY0Q4UTYyQlByeVRydHVRblozaXlhLzhYdCtzTVRlbEpW?=
 =?utf-8?B?MU5nTGsveGJDTFNjT2xIdUtyVkE0Uk9YY1BoWmpxbFZQb2xZTjdoN3J0RjRU?=
 =?utf-8?B?eDZ4M0JhTHFTT1JXemthZzZsMXE2SkxqRkxwYWpYOVJYQU1mSTJ2WDQxUXM5?=
 =?utf-8?B?cGJ5TzRrWFdjUU9nSkk0KzZoVnlsNXIwbDZ1Z2hzVHpEQW1kaFRxNWZZMzU2?=
 =?utf-8?B?NjNRTWViOFllMjh3MFptdURndEdHRTRYek9kVGVXWTl5SHU4eVhvUHN5KzJl?=
 =?utf-8?B?amFZejc5b1hJejU1RFNWTk9XcXRpNWtpM3RWaWVPL2N5MkF2NHNGZW1KWjYv?=
 =?utf-8?B?cVJZdVVzeTVGK3d4aXp0ZFlWd3NKZzZ0aFk2SUNVdU5VZjBSL2FqQW9CSS85?=
 =?utf-8?B?ODlrc0paVGFzYkRuSEtqKzlySTNyYWhLU1l0NVJXbXVnVGdtd3MvUkpzUDNk?=
 =?utf-8?B?Mm1HYU12UVRCUE43R1pGYTRYbmp1SEhlMUdEUW10WVlJWjNNTnNBWWk3czZG?=
 =?utf-8?B?QThaNXR2M1FsOHhRWk5kVGRQQzdrbmlsbC9aMmExUFptOXZHVDZWUndkNnJI?=
 =?utf-8?B?YzZEMklpVDk0SjdmM1lTMk9XNWRPdEo2Wmp4b2pNU3pRc1ZGb21XL3ZOcVRl?=
 =?utf-8?B?T3dxdzBpK2J2NERCbnd5V3VsS0EwaHRTRHdRKzZZTDE3NjI3OUpnQktGSHdJ?=
 =?utf-8?B?eUx0cXU1MEVDRTFwZVo5QVgxQVFFQXJHT1JPNkUvcEdkNnVqNVVsNTVVdjBO?=
 =?utf-8?Q?IK9vZjlheo7hFkWFRy7d5Gd6u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5893cf-1c8f-49b1-f39b-08da7a5a311a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 22:55:01.7716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 896XP42my+HlevzFQJzWdU0wM9RcvDFnxp5loE4nwKqT7bzdX2DLKMkLJ01Z9dlYOvjhC0dFrOR1S/jo1MP6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208090085
X-Proofpoint-GUID: LoK0lQiSur2f1XwoMwi8qgVjylU8WjI2
X-Proofpoint-ORIG-GUID: LoK0lQiSur2f1XwoMwi8qgVjylU8WjI2
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

CgpPbiA4LzkvMjAyMiAzOjM3IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24gVHVl
LCBBdWcgMDksIDIwMjIgYXQgMDM6MzI6MjZQTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4K
Pj4gT24gOC85LzIwMjIgMjozNyBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24g
VHVlLCBBdWcgMDksIDIwMjIgYXQgMDc6MTg6MzBQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3Rl
Ogo+Pj4+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+IFNl
bnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDM6MDkgUE0KPj4+Pj4+PiBGcm9tOiBTaS1XZWkg
TGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgQXVndXN0
IDksIDIwMjIgMjozOSBQTSBDdXJyZW50bHkgaXQgaXMgbm90LiBOb3QgYQo+Pj4+Pj4+IHNpbmds
ZSBwYXRjaCBub3IgdGhpcyBwYXRjaCwgYnV0IHRoZSBjb250ZXh0IGZvciB0aGUgZXZlbnR1YWwg
Z29hbCBpcwo+Pj4+Pj4+IHRvIGFsbG93IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsgd2hlbiBndWVz
dCB1c2VycyBpbnRlbnRpb25hbGx5IGxvd2VyCj4+Pj4+Pj4gZG93biBNVFUgdG8gMTUwMC4KPj4+
Pj4+IFdoaWNoIGFwcGxpY2F0aW9uIGJlbmVmaXQgYnkgaGF2aW5nIGFzeW1tZXRyeSBieSBsb3dl
cmluZyBtdHUgdG8gMTUwMAo+Pj4+PiB0byBzZW5kIHBhY2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2
ZSA5SyBwYWNrZXRzPwo+Pj4+IEJlbG93IGRldGFpbHMgZG9lc27igJl0IGFuc3dlciB0aGUgcXVl
c3Rpb24gb2YgYXN5bW1ldHJ5LiA6KQo+Pj4+Cj4+Pj4+IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2
ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBhbmQgTVJVLCBpbiB3aGljaCBjYXNlCj4+Pj4+
IHRoZSByZWNlaXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVjZWQgdG8gZml0IHRoZSAxNTAwQiBwYXls
b2FkIHNpemUgd2hlbiBtdHUgaXMKPj4+Pj4gbG93ZXJlZCBkb3duIHRvIDE1MDAgZnJvbSA5MDAw
Lgo+Pj4+IEhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1YdSB0byAxNTAwLCBzYXkgaXQgaXMgaW1w
cm92ZWQgdG8gcG9zdCBidWZmZXJzIG9mIDE1MDAgYnl0ZXMuCj4+Pj4KPj4+PiBEZXZpY2UgZG9l
c24ndCBrbm93IGFib3V0IGl0IGJlY2F1c2UgbXR1IGluIGNvbmZpZyBzcGFjZSBpcyBSTyBmaWVs
ZC4KPj4+PiBEZXZpY2Uga2VlcCBkcm9wcGluZyA5SyBwYWNrZXRzIGJlY2F1c2UgYnVmZmVycyBw
b3N0ZWQgYXJlIDE1MDAgYnl0ZXMuCj4+Pj4gVGhpcyBpcyBiZWNhdXNlIGRldmljZSBmb2xsb3dz
IHRoZSBzcGVjICIgVGhlIGRldmljZSBNVVNUIE5PVCBwYXNzIHJlY2VpdmVkIHBhY2tldHMgdGhh
dCBleGNlZWQgbXR1Ii4KPj4+IFRoZSAibXR1IiBoZXJlIGlzIHRoZSBkZXZpY2UgY29uZmlnIGZp
ZWxkLCB3aGljaCBpcwo+Pj4KPj4+ICAgICAgICAgICAvKiBEZWZhdWx0IG1heGltdW0gdHJhbnNt
aXQgdW5pdCBhZHZpY2UgKi8KPj4+Cj4+PiB0aGVyZSBpcyBubyBndWFyYW50ZWUgZGV2aWNlIHdp
bGwgbm90IGdldCBhIGJpZ2dlciBwYWNrZXQuCj4+PiBBbmQgdGhlcmUgaXMgbm8gZ3VhcmFudGVl
IHN1Y2ggYSBwYWNrZXQgd2lsbCBiZSBkcm9wcGVkCj4+PiBhcyBvcHBvc2VkIHRvIHdlZGdpbmcg
dGhlIGRldmljZSBpZiB1c2Vyc3BhY2UgaW5zaXN0cyBvbgo+Pj4gYWRkaW5nIHNtYWxsZXIgYnVm
ZmVycy4KPj4gSXQnZCBiZSBuaWNlIHRvIGRvY3VtZW50IHRoaXMgcmVxdWlyZW1lbnQgb3Igc3Rh
dGVtZW50IHRvIHRoZSBzcGVjIGZvcgo+PiBjbGFyaXR5IHB1cnBvc2UuCj4gSXQncyBub3QgYSBy
ZXF1aXJlbWVudCwgbW9yZSBvZiBhIGJ1Zy4gQnV0IGl0J3MgYmVlbiBsaWtlIHRoaXMgZm9yCj4g
eWVhcnMuCldlbGwsIEknbSBub3Qgc3VyZSBob3cgaXQgbWF5IHdlZGdlIHRoZSBkZXZpY2UgaWYg
bm90IGNhcGFibGUgb2YgcG9zdGluZyAKdG8gc21hbGxlciBidWZmZXJzLCBpcyB0aGVyZSBvdGhl
ciBvcHRpb24gdGhhbiBkcm9wPyBUcnVuY2F0ZSB0byB3aGF0IAp0aGUgYnVmZmVyIHNpemUgbWF5
IGZpdCBhbmQgZGVsaXZlciB1cD8gU2VlbXMgZXZlbiB3b3JzZSB0aGFuIGRyb3AuLi4KCj4KPj4g
T3RoZXJ3aXNlIHZhcmlvdXMgZGV2aWNlIGltcGxlbWVudGF0aW9ucyBhcmUgaGFyZCB0bwo+PiBm
b2xsb3cuIFRoZSBjYXB0dXJlIGlzIHRoYXQgdmhvc3QtbmV0IGRyb3BzIGJpZ2dlciBwYWNrZXRz
IHdoaWxlIHRoZSBkcml2ZXIKPj4gb25seSBzdXBwbGllZCBzbWFsbGVyIGJ1ZmZlcnMuIFRoaXMg
aXMgdGhlIHN0YXR1cyBxdW8sIGFuZCB1c2VycyBzZWVtaW5nbHkKPj4gaGF2ZSByZWxpZWQgb24g
dGhpcyBiZWhhdmlvciBmb3Igc29tZSB3aGlsZS4KPj4KPj4gLVNpd2VpCj4gV2VpcmQgd2hlcmUg
ZG8geW91IHNlZSB0aGlzIGluIGNvZGU/IEkgc2VlCj4KPiAgICAgICAgICAgICAgICAgIHNvY2tf
bGVuID0gdmhvc3RfbmV0X3J4X3BlZWtfaGVhZF9sZW4obmV0LCBzb2NrLT5zaywKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmJ1c3lsb29w
X2ludHIpOwo+ICAgICAgICAgICAgICAgICAgaWYgKCFzb2NrX2xlbikKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICAgICAgICAgICBzb2NrX2xlbiArPSBzb2NrX2hs
ZW47Cj4gICAgICAgICAgICAgICAgICB2aG9zdF9sZW4gPSBzb2NrX2xlbiArIHZob3N0X2hsZW47
Cj4gICAgICAgICAgICAgICAgICBoZWFkY291bnQgPSBnZXRfcnhfYnVmcyh2cSwgdnEtPmhlYWRz
ICsgbnZxLT5kb25lX2lkeCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZob3N0X2xlbiwgJmluLCB2cV9sb2csICZsb2csCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBsaWtlbHkobWVyZ2VhYmxlKSA/IFVJT19NQVhJT1YgOiAxKTsK
PiAgICAgICAgICAgICAgICAgIC8qIE9uIGVycm9yLCBzdG9wIGhhbmRsaW5nIHVudGlsIHRoZSBu
ZXh0IGtpY2suICovCj4gICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoaGVhZGNvdW50IDwg
MCkpCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+Cj4KPiBzbyBpdCBkb2Vz
IG5vdCBkcm9wIGEgcGFja2V0LCBpdCBqdXN0IHN0b3BzIHByb2Nlc3NpbmcgdGhlIHF1ZXVlLgpI
ZXJlCgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE9uIG92ZXJydW4sIHRydW5j
YXRlIGFuZCBkaXNjYXJkICovCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHVu
bGlrZWx5KGhlYWRjb3VudCA+IFVJT19NQVhJT1YpKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvdl9pdGVyX2luaXQoJm1zZy5tc2dfaXRlciwgUkVB
RCwgdnEtPmlvdiwgMSwgMSk7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVyciA9IHNvY2stPm9wcy0+cmVjdm1zZyhzb2NrLCAmbXNnLAogwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEsIE1TR19ET05UV0FJVCB8IApNU0dfVFJV
TkMpOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9k
ZWJ1ZygiRGlzY2FyZGVkIHJ4IHBhY2tldDogbGVuICV6ZFxuIiwgCnNvY2tfbGVuKTsKIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7CiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQoKcmVjdm1zZygsICwgMSwgKSBpcyBlc3NlbnRp
YWxseSB0byBkcm9wIHRoZSBvdmVyc2l6ZWQgcGFja2V0LgoKCkluIGdldF9yeF9idWZzKCksIG92
ZXJydW4gZGV0ZWN0aW9uIHdpbGwgcmV0dXJuIHNvbWV0aGluZyBsYXJnZXIgdGhhbiAKVUlPX01B
WElPViBhcyBpbmRpY2F0b3I6CgpzdGF0aWMgaW50IGdldF9yeF9idWZzKCkKewo6CjsKIMKgwqDC
oMKgwqDCoMKgIC8qIERldGVjdCBvdmVycnVuICovCiDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtl
bHkoZGF0YWxlbiA+IDApKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IFVJ
T19NQVhJT1YgKyAxOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyOwog
wqDCoMKgwqDCoMKgwqAgfQo6CjoKCgotU2l3ZWkKCj4KPgo+Pj4KPj4+PiBTbywgSSBhbSBsb3N0
IHdoYXQgdmlydGlvIG5ldCBkZXZpY2UgdXNlciBhcHBsaWNhdGlvbiBpcyB0cnlpbmcgdG8gYWNo
aWV2ZSBieSBzZW5kaW5nIHNtYWxsZXIgcGFja2V0cyBhbmQgZHJvcHBpbmcgYWxsIHJlY2VpdmUg
cGFja2V0cy4KPj4+PiAoaXQgZG9lc27igJl0IGhhdmUgYW55IHJlbGF0aW9uIHRvIG1lcmdlYWJs
ZSBvciBvdGhlcndpc2UpLgo+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+PiBUbyB1bnN1YnNjcmliZSwgZS1t
YWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJlQGxpc3RzLm9hc2lzLW9wZW4ub3JnCj4+PiBGb3Ig
YWRkaXRpb25hbCBjb21tYW5kcywgZS1tYWlsOiB2aXJ0aW8tZGV2LWhlbHBAbGlzdHMub2FzaXMt
b3Blbi5vcmcKPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
