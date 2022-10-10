Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC28C433FE
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 152F340983;
	Mon, 10 Oct 2022 17:44:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 152F340983
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cSLE1j5B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=z766ox/U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcQOxrBx1mX2; Mon, 10 Oct 2022 17:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B8E740143;
	Mon, 10 Oct 2022 17:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B8E740143
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5887CC0032;
	Mon, 10 Oct 2022 17:44:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E921C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56EF44040B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:44:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56EF44040B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cSLE1j5B; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=z766ox/U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6dLFWmAi80u
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:44:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 270DC403B4
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 270DC403B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:44:14 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AHE4sq030273;
 Mon, 10 Oct 2022 17:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HEnmrQBGsYM5vPC5+tG+w+S2xzru6DY/7kntFKIkYBQ=;
 b=cSLE1j5BJFtcIoRYuZ4jARAp8343DBndCZXNE8Uwp81l0866c6OAE+WjqpcV/yV8QJh4
 3/CKqy0ZEta1jK6MoAF0D5OOM4HU2ZVyqgdXRSDOKqiCpxO01UAD1oxujCMol/wOEoxK
 DqxhGXH2hGmyYEIuOO01FJvuwInfqy+eKLS3aOywX4RBplrB6mYE84x4pepkTVEXencC
 H6DgfqB8shiIKRCUOTb5ICKu7WiccqvuolxpNFtCBrLDkIWEXJUtH2oazW1kpxFVWsDH
 G5R9rtEnnbjguitswBKXhNJ9SN8BBhULWMbWXAbq3yCFj5Og1NL1DVVRjv+9yxgAUAPt Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1cfa0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Oct 2022 17:44:09 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29AHTLLV002881; Mon, 10 Oct 2022 17:44:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3k2yn2vnk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Oct 2022 17:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKcU64xkFwI8WUO+K8RfD1yQk+bBJ9QIr3SfHcJOJ2xSmAY8d1DY9mTLNMOMMxG7P3PRGlsamwo5sSyvg3SMA7kkbSt364/PNaQVtleSYpEGO6uaKpQuPHK+7bk1hi/yK4BfNWE3BCkuYaLSKl+8mnx0U6vGUS3fd0zja0EvR6W3HUIVQBHdH+DJH/jmnd8ppSYESZTyarxSmzmHiHs0gBOlaLBXheDEe2iSSv9Bt8Q3l9rkrWTLY8/COHtxHxpBxbNJp7XpQEvFsmzm1S1DKr2Zq9h8zd5S3HK2fP9UUclQIJQx6n6OSHvZqGpHJaBi3VjsqRgQNAB4h/wbkg5Edg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEnmrQBGsYM5vPC5+tG+w+S2xzru6DY/7kntFKIkYBQ=;
 b=QHsb2Kxg7O81UxgbEw0EEyCpo7QVSR3y/6yQBIfeiFMYhO+riqXYEhTzr4oNdhal1yAGSq3isOhG1s37Y8rYprJVRpgnadkdmtVVv6agB6wBmdseqANPoqD4nNk3oS27aXI2mRxXCdvmJbmwHGETTwsLHkt9H79eY2pIE6ActLheXyX+6ao4GeOj9soDQqKwNdxe3PN1iGJgc8sNt5kmaKMXRjXLXOWcEnrmJcxxZj+sI/qgOG4jhqTBCOaZjayZV0Rk8o8UIUo8bwFUh37Qk1g2rxC03R8ONV+wQbOGv7Eda4QJtePh8VhyEVwC6nHPVCrQ5M4geOhzgx97wNwACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEnmrQBGsYM5vPC5+tG+w+S2xzru6DY/7kntFKIkYBQ=;
 b=z766ox/U0qEF2zYz8J+J/wwbQke4uVSGjheAEd1jpfUlqNg/H2+uGA06G70kZBEVSLWnDVE4ouCbOLGdyookN9fpN/JGErIvsMA+zcm7HXWHNWCJqvkFUYoW0JupeKQQtds8a+LmTlXZnMKzAx/eHF8gXkBoqSjU3+Vv9mEsAhk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM4PR10MB6741.namprd10.prod.outlook.com (2603:10b6:8:10f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 17:44:06 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bd57:f68a:ddd2:7edc]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bd57:f68a:ddd2:7edc%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 17:44:06 +0000
Message-ID: <3a43d0c6-1537-8396-1b7b-68cc24f50c18@oracle.com>
Date: Mon, 10 Oct 2022 10:44:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Content-Language: en-US
To: mst <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Parav Pandit <parav@nvidia.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
 <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
 <CACGkMEsWPbTs+D4PBHQL2hUOtGWj_6zo-669cUhYK5zK039QCQ@mail.gmail.com>
 <CACGkMEuQHV-pECAPy3EozDE20Gdeh6QjaBvu6u0djeL3PZT2NA@mail.gmail.com>
 <7c555830-6909-d482-ea05-4316a02012df@oracle.com>
 <CACGkMEsvnE6Kuvmd+5gh=mQfb57DQYnJEWegXVVO+6pWs=KY3g@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsvnE6Kuvmd+5gh=mQfb57DQYnJEWegXVVO+6pWs=KY3g@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM4PR10MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fb45cb-8acc-48df-78ab-08daaae70783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ae16sn3pchJsumoZ63xmWXKYidq0SWLtfcVW3VWMpxfcMmnAv6QmHRgTMGgH8D7XFLM3580PGoLxGRO2Z3Wis7eJ/RA6LNLsEd8L+i9PbOIQ3MEV/jataZol/PgmgifOZ5+ZlFoZUsdYhKCoS37ot3GMuLFT1UJU9wYZOsHLpZ8k347rIF5SLvAPFFxE0fXIR7P4scGzxEawTBFSkTsUhWPiei3JR6CzfNf2n3X8LI9vgJOap9iAmfyGAzazYfU/MS9FM0Ctm/N/06MYBjBa5oeq8w7nW/3SFcOFqtxJ0g0RKwN1UVlwzJGXNZsZ0ThY2376IV8ba3AcTpRbmvjQgKniaMWsdpxMVh2HMqCKWqowoc4G+c3ZUMKB+2N33Y4HAN2NvS4EomJpEquMOoyZe52fcfcNES8lHA/PZTMYzT0e00jQfXwctkyhKwATKMlpEK0sEiac7UmbpwxGOi4DGfMrgWJKkMXoOqXoceVnDXf7kMrLzk7BMElAmYM7wCaQFfupwClVMYuENYqjihMQ8HvoeyyOCJOm35AkBkTOeHqflJlYFZktHZQZd5t6UbXXeJyIU7mJFDgMDiPBSgXsxitcnQ+aQBIqVk/A/g6jkFvmfwTBklyaWDrg9HNNx/Ika9WtJ8Gr2yz/6SadGP8OtbR03MiJLbMUMeBBkiyKCqCaXa57nigQCJZlXUHIRU3Owj3j9xWjbogXjPNJkR8IOcSfF/yFtafS+SUz6h8iIul9/CIVG5OO8zsghsdGzEHr6ft2DRMa2dAt7vv0FuF92GOUKFuWHRYnXHM7pEduWkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(8676002)(31686004)(66476007)(8936002)(7416002)(2906002)(41300700001)(36756003)(110136005)(5660300002)(4326008)(54906003)(316002)(66946007)(31696002)(86362001)(66556008)(2616005)(6506007)(478600001)(26005)(36916002)(53546011)(6512007)(6486002)(186003)(38100700002)(83380400001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNabSs5QU1xbVVrWFBJekJMZk9xcmtKK3NHMnBiNnF4UkJhSlJyaGxtSGVR?=
 =?utf-8?B?aG5JU2FkQ1JnYjVQZ0NHWGtiK095aEhFRTJrYk5wQVZMMnZXT0JZYmY4RU9q?=
 =?utf-8?B?UHhPOUszVmVKSlpNQXJ1U2lFbW1QYkNsTHJGZUN1SnJvMi9jVVh3UDB2Sm1v?=
 =?utf-8?B?cFpCWm5XSWRUSmNncFZ5SnFsVjl4Tjh3UTk1NUN4UmpmbDgwSWt5bmowdS9K?=
 =?utf-8?B?V01QL1ZScVRMTEE2dDNYWlNVQm5Qa0I1V01TeE1meS84Ky9zbnNEdUp2dkUy?=
 =?utf-8?B?MktiaXlGMGNhS3M4MlhDb3FvSS9jNmJXcXJPV0pSeGhNemtjdTV5SVFIL1lO?=
 =?utf-8?B?c2JEeWxFNEJSOWEvVnhaeE80cWZMV09BV0FneFJPS0plcjRYck9NMXF4clE4?=
 =?utf-8?B?Uzh3NjR0c0puTVRZbENaMm9zVjQ1QUp5cW83cndsejVEQWVvZ0xJWmZ2aEsx?=
 =?utf-8?B?SFloNExMS0R5dTRxQm5QTzZlMzUxcnR0d0plVFlrSHlkeHpJaGV0b25VRTlt?=
 =?utf-8?B?dWQrVGp4SGQzRENTM3pvZ0x0OUxxa0lGc3JicFJxM3pjK0JJNmRGT0ZyTi9n?=
 =?utf-8?B?L2V1OGFEYTA5RWRKd2NybFV4ZnRLK0twUXlXb3FFdlVQbk5QMFlUMHhOWkc3?=
 =?utf-8?B?T1E2Qi8zZlVWK2ZFQVlqdlhvYW1CaFQyeVBLS2JkelJmY0c2eVVtSkZPQmxk?=
 =?utf-8?B?cS9yMGE5dmxTalJtdzNJOXpONFZ2L05BN3g4SGhuamUva2JsY09rZFAwc054?=
 =?utf-8?B?TmFGY3JXSGEwQWV5b25Td01KcWtTMC9zUnJnTVQvSDQ3MkkxYVJmS29GYUpx?=
 =?utf-8?B?VEFPTVBrdEYwOW1wTStPWnJIU2RUK3l0dElHY2JWRXM1YWY4WXd2MEowZE81?=
 =?utf-8?B?WmNpZ0VKRFF2ZWtkazRqRURWSlZDUHh5ZGNDRGdubUphQUZBK2VHWEZJcmgw?=
 =?utf-8?B?RUtUcFZyK0hzeVF4cmQ5amdmR0NlUkNCTnhNY2JMNVpuZlRiWEZtSVJod1hJ?=
 =?utf-8?B?Rkwza2YrbHgybklPcEI1ZnFtazcrUit4dlN5WkxlSmtKaFh1dUZwbjdmRVdi?=
 =?utf-8?B?M0pCL25hN3ZPVXdMZEVJRFVvaWltVnBOMnAyZUtvYlpqWE1mcy9zWm9HOTN1?=
 =?utf-8?B?aDV0d004SG9uUDhNbHQrRVZGWWFsM21aQUNSc0k0ZGoyZk9hSnRvUFV1Y01z?=
 =?utf-8?B?aFJyWjB1bDBLWlN4ZENqNUQxNVcxTVRid2o1c2o1ZXowRktzUG5WQTl4TGdQ?=
 =?utf-8?B?QWp1L0xzb3JTT25kUVZYTjl0K1ZVUnhGVDhkWk9UYkNoWEhlOHg2WmptMzhC?=
 =?utf-8?B?emFGb0FsL05Ya0pqTVk4WEtVV1NEQkY2NGxhQ1N5bm01ckVYYzZjSjVyUmZM?=
 =?utf-8?B?b2N6RkJBbjBVaTMxU25mUGhyUlJhaFRXQ3JnWG95NUU4REJuczEwUjRJRlB1?=
 =?utf-8?B?MGx6NkpnWFR1RHFEdlBYQ29DQkhrWVZQSUM4bjllQlhmcCtwTEUxOW1mQXlO?=
 =?utf-8?B?QkQrdTU5MCtYTDdBMERNVzV1NUtXU28zOU50c2ovelRhZGF3WEI2NVJtVkJ5?=
 =?utf-8?B?THNqRFRLdnR5ODZMOVVYQWZwWXVMbkRhbTFsaXdTMyt0empiQW9XOVo2T2No?=
 =?utf-8?B?V3dML0o2Q3RtZlU1NUk3TWJKMkhYQWs1blRDSmZkM1BSQmd0Q0xlb2gxTVlw?=
 =?utf-8?B?YVBwQlZIM0tmMW96eHpnSSs5RnFsNm0xU0RTOVMyaG1CYlhGeHdxaTZsMVYr?=
 =?utf-8?B?cm81ditOZFFYMDdxenhnZ2pkM3JoVG5oN0MzMERtZ1NTS0RQVGtEV0k1cW96?=
 =?utf-8?B?NXhhRnFGcmZ1eFUxRHZMeWJ0bU5nNExZVDd1TUtNdXdzbjUraGt2d01uQjFE?=
 =?utf-8?B?RjBmNTF1cWlFaUNwc0thNWlmVzVZZzcrL0o1VEtTTGlBdWdjQ29BVkQvRm1O?=
 =?utf-8?B?R0dicm5vdzV0b0svV21xeWtRSjI2K2pJMXNBL0wwTmlqc1k1bmQ5eldwcVAr?=
 =?utf-8?B?NVo4R1dKTTU2S0U5SGYybnlBQVlRT2piZDh2ZkZJTXlxRW5jY0dKQ25lalg4?=
 =?utf-8?B?bUdOaEpKWlg4cUdiZHpLVjVXMWN3RS8yUE9qbitxZHhWS1o0dlV2d1YyM0VB?=
 =?utf-8?Q?DZr8gMTir08/Hl+Jo0cyL8xKy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fb45cb-8acc-48df-78ab-08daaae70783
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:44:06.7818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldL23f26uE7YQlJLARLu0z94/bLOJtxqljs8izsJrvs4Pj+5j6JcAznnUC7j0do37kPULcUIY80qE173lSmbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_11,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100104
X-Proofpoint-GUID: qQPB96ZTQrV3SDktY-C6VAgclKukYVua
X-Proofpoint-ORIG-GUID: qQPB96ZTQrV3SDktY-C6VAgclKukYVua
Cc: Cindy Lu <lulu@redhat.com>, Yongji Xie <xieyongji@bytedance.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgTWljaGFlbCwKCk5vdGljZWQgdGhhdCB5b3UganVzdCBtZXJnZWQgdGhpcyBzZXJpZXMgdGhh
dCB3ZSBub3cgZ290IHR3byBub21pbmFsbHkgCmR1cGxpY2F0ZWQgYXR0cmlidXRlczogVkRQQV9B
VFRSX1ZEUEFfREVWX1NVUFBPUlRFRF9GRUFUVVJFUyBhbmQgClZEUEFfQVRUUl9ERVZfRkVBVFVS
RVMuIEkgdGhpbmsgSmFzb24gYWdyZWVkIHRvIHJlbW92ZSBvbmUgb2YgdGhlbSBidXQgCmRpZCBu
b3QgZ2V0IGNoYW5jZSB0byBwb3N0IGEgbmV3IHNlcmllcyB0byBjYXRjaCB1cCB3aXRoIHRoZSBt
ZXJnZSAKd2luZG93LiBEbyB5b3UgbWluZCBpZiBJIHBvc3QgYSBmb3JtYXQgcGF0Y2ggc2ltaWxh
ciBhcyBiZWxvdyB0byByZWN0aWZ5IAp0aGlzIHF1aWNrbHkgZnJvbSBsaW51eC1uZXh0LCB3aXRo
b3V0IHVubmVjZXNzYXJpbHkgZ2V0dGluZyB0aGUgZHVwIApleHBvc2VkIHRvIHRoZSB1QVBJPwoK
VGhhbmtzLAotU2l3ZWkKCi0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKKysrIGIvZHJpdmVycy92
ZHBhL3ZkcGEuYwpAQCAtODU1LDcgKzg1NSw3IEBAIHN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X2Nv
bmZpZ19maWxsKHN0cnVjdCAKdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICptcwoK
IMKgwqDCoMKgwqDCoMKgIGZlYXR1cmVzX2RldmljZSA9IHZkZXYtPmNvbmZpZy0+Z2V0X2Rldmlj
ZV9mZWF0dXJlcyh2ZGV2KTsKCi3CoMKgwqDCoMKgwqAgaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1z
ZywgClZEUEFfQVRUUl9WRFBBX0RFVl9TVVBQT1JURURfRkVBVFVSRVMsIGZlYXR1cmVzX2Rldmlj
ZSwKK8KgwqDCoMKgwqDCoCBpZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLCBWRFBBX0FUVFJfREVW
X0ZFQVRVUkVTLCBmZWF0dXJlc19kZXZpY2UsCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZEUEFfQVRUUl9QQUQpKQogwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7CgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91YXBpL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92ZHBhLmgKaW5kZXgg
OWJkNzkyMy4uNmU2MjBjMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZkcGEuaAor
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmRwYS5oCkBAIC01MywxMCArNTMsOCBAQCBlbnVtIHZk
cGFfYXR0ciB7CiDCoMKgwqDCoMKgwqDCoCBWRFBBX0FUVFJfREVWX1ZFTkRPUl9BVFRSX05BTUUs
wqDCoMKgwqDCoMKgwqDCoCAvKiBzdHJpbmcgKi8KIMKgwqDCoMKgwqDCoMKgIFZEUEFfQVRUUl9E
RVZfVkVORE9SX0FUVFJfVkFMVUUswqDCoMKgwqDCoMKgwqAgLyogdTY0ICovCgotwqDCoMKgwqDC
oMKgIFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogdTY0ICovCi0KIMKgwqDCoMKgwqDCoMKgIC8qIHZpcnRpbyBmZWF0dXJlcyB0aGF0IGFy
ZSBzdXBwb3J0ZWQgYnkgdGhlIHZEUEEgZGV2aWNlICovCi3CoMKgwqDCoMKgwqAgVkRQQV9BVFRS
X1ZEUEFfREVWX1NVUFBPUlRFRF9GRUFUVVJFUyzCoCAvKiB1NjQgKi8KK8KgwqDCoMKgwqDCoCBW
RFBBX0FUVFJfREVWX0ZFQVRVUkVTLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IHU2NCAqLwoKIMKgwqDCoMKgwqDCoMKgIC8qIG5ldyBhdHRyaWJ1dGVzIG11c3QgYmUgYWRkZWQg
YWJvdmUgaGVyZSAqLwogwqDCoMKgwqDCoMKgwqAgVkRQQV9BVFRSX01BWCwKCgpPbiA5LzI4LzIw
MjIgOToxMCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBJIHRoaW5rIFZEUEFfQVRUUl9WRFBBX0RF
Vl9TVVBQT1JURURfRkVBVFVSRVMgYW5kCj4gVkRQQV9BVFRSX0RFVl9GRUFUVVJFUyBhcmUgZXF1
aXZhbGVudCwgd2UgY2FuIHJlYmFzZSBvbiBlYWNoIG90aGVyIGlmCj4gaXQgaXMgbmVlZGVkLgo+
Cj4gVGhhbmtzCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
