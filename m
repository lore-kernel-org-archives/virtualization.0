Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC55C7EE37
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 22:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EED181ED8;
	Tue,  6 Jun 2023 22:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EED181ED8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=A1ft2FLV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hrPyr2l+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zX22vTiAzUgi; Tue,  6 Jun 2023 22:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A42E81EC0;
	Tue,  6 Jun 2023 22:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A42E81EC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C264C007A;
	Tue,  6 Jun 2023 22:56:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBDDC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 22:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 128F34035D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 22:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 128F34035D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=A1ft2FLV; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hrPyr2l+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nV1uz1VKB1sL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 22:56:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBD604021C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DBD604021C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 22:56:04 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356IZBGN015439; Tue, 6 Jun 2023 22:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5sZCZzsMiXhI2ksCsp3nYvaA9cdxaA4iuoYfbl/UfMU=;
 b=A1ft2FLVEPKefvPUc5wRd+Z7YDkKrZL7Ua8zMImRpHeodAoGFBK83wtUt23rwj4iPaP/
 kXXP7xWIe32hCkcPkNCzUv2V4rmPb0IDxix3dAQ5KwZGozZGJBjoBbQy9o2u7ZYg6GMh
 IQb2R4ZTLfCs//Ki7c6TnU+4UuS9D/hhKNFLvorCQw1N5CTSLu34Wx1o11njLubEB/2D
 mV7/v35ZjcizJm8E6xnXKHh6QX3Zf07qNpcady2BRuj7f3owwZkfB79HJMMkVJpZvsbF
 8oGzE7fPbv0kkAeiNBySmNqWMHtN6Kaj6itlkyfoAZZb2fijq7yABfa+t6Dlvydvyr0R wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uremb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 22:56:03 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 356KcAND037082; Tue, 6 Jun 2023 22:56:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6gfs4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Jun 2023 22:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjKJhO5KEEudkASb0VnMZvzCn9KDzhHl4eKHvZlkZ1MHSBSCQUwfdUmvP+4piS5PI1s53kHswi9kdnlWyB+EYUeRmaeybZRmlAfyqqH3G8UGU5c7fMC1Y7c+UqaUV4fiCiaezfa4LGZn3Rk4L4cdSjMCIfDuE8rbSaCgizYXCLtPiAxIVD+2R++GWNxhHi6EPEXfsmrQpGZVBuyFw5OML2gEUoRcx0sJHzW8L1iwzf9HXg2Orxs58UlqtLiV44hpLU/hGCK9VhtenksQkuOA+6aY3f04+EW4DmSN2YCu7Ikky2Ckzeh17EQmPYdRvWWX6bGH5kU6d+T5+Pa1H2NAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sZCZzsMiXhI2ksCsp3nYvaA9cdxaA4iuoYfbl/UfMU=;
 b=FjhSHgxrni/ua7ds3q7g1D1i5t3E0pKv15tbMvKjNSmvq/8xFPn191tFjr6A8aTC1dgR+DEat66vyFCtXb0W0TtM9+spvQlqvDpZODroNmpdAyE2n4H8vmVvn9URapW43l/z78uyFcJbxoJWTdCXjTJV1eflrGsfaW0moTgP4LDLdqV5NHEuUF7p/IpS8VhTWK2J25/Q9bX00f64Nlio+N4ZZktj2Aq6DRPePsE7caH/O9T5hbC0aM5uCj5WQymKkOcmCbw4hnzosxhjA1U+GVV8aQEyE3XRB8lk5EEMu4MJVyFkXeMeRhGOb592S0CTv13VfWBj9fSH+uBNScWXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sZCZzsMiXhI2ksCsp3nYvaA9cdxaA4iuoYfbl/UfMU=;
 b=hrPyr2l++JcCWWfRi9EA1CpyJdKYjGRnMjP+bECgWzy8p1M0uF2fDGPZSqwJhT6Ex+t9ibjbfdrNI1nnxx98zLHGmufTv7d7TgWZLpH61abDBxqq6wHYPlH0CBW1LXxSWyl3N9tgeq4+HnTM/UHwz5obyHIxCh90zJfdrRyDf48=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA0PR10MB7349.namprd10.prod.outlook.com (2603:10b6:208:40d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 22:56:00 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 22:56:00 +0000
Message-ID: <90d9866d-56a2-d788-32ac-0816cb502733@oracle.com>
Date: Tue, 6 Jun 2023 17:55:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] vhost: Fix crash during early
 vhost_transport_send_pkt calls
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230605185730.6560-1-michael.christie@oracle.com>
 <yocmdeykp2no67yaopvc3on6hqmwt2gavuhchxfl3appfsapg2@qhcor7x5e7mi>
 <efd1b26e-0286-e3a8-5343-3ff196788832@oracle.com>
 <20230606152033-mutt-send-email-mst@kernel.org>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230606152033-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DS7PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::6) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA0PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d9fc35-c000-42d2-79b4-08db66e1329a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOtpNUYjyxgXfnOZpdoUfJtjhHOuI6zAqArbug1PPykHVjv5tfewlIBNWFLTCxFJfpObO+VPyEVCkOfzPQ+FWYslDC4/31yEwSR2wxweqeVLCX/gyOMRIV7t1l62+/yqBmSaUWg508w6oQBxnpLI8U1vRuk/Zz2ZE+e4oixcvVbN2TXgkZaMmszE8UgTZC+Dt3QDNRQpGKUuHvKcy+CnGvW+OTh09PBlwkM5NXjs56SxQotA6Jai7/JptVhsUh1SxqSctOkQaAd4SwNzUkxOrvHSd0H5eAkuH9eBNHKmQlWJJtsllq+Q1v65dsMJCPDJNb5RmOs3JQE0eKiZeXT4xBwDpjknlpmDTxZkO1x6r8gVi7MTa5yrl5WAqfV96y3Vg4gAMJFdm8L7EBn72t3V4M5709sL/4xbh6QQh6odSJwtDQk8RCLg6MI4jMCirS8OmVH8EknnV87dIYkemaNJxi7B4b6rFwbLFy6cjET2o8656E4fESERtizbNQCU8ndS7vAD/97r0oM+BNaCopTv2A8njm+VJNg+SlFYV1sgAnzo2u7J+h5rX5jAvndOd2ME8OSmErhy+ew0rnar6PU9dcnCSmsXqh5woV6f5zA4s/jkFL7aatcWHPIyXiGUL90hxsNdSEm24ZsChTgeS0AxQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(83380400001)(6486002)(478600001)(8676002)(8936002)(4326008)(66476007)(316002)(66556008)(66946007)(31696002)(6916009)(38100700002)(5660300002)(41300700001)(86362001)(36756003)(2906002)(6512007)(26005)(186003)(6506007)(31686004)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3k3YW1qbUFPZmJheXZwOUdnNG9Ed0dBWU9PWTFLT3d4QnA2ZjhNRVRyMFJa?=
 =?utf-8?B?OGVGTmNScVhRWDdxMFFOaVdlQWhmOUxoVkZOLzQ4YzVoc2RHdFlxRWUwZFFW?=
 =?utf-8?B?UktDWGZRVFhqU3dEUHE2NnNGTGMzeElvRnJxbUR3cEhCTkFFdlpUK1lCZ1kz?=
 =?utf-8?B?bzJhMDZtMnFPRlY3MmNFUlFqeEtpYUVBWnM3eDNvejJldFNxMDI5eE9MREdG?=
 =?utf-8?B?K21pRnAyK29Rb3Bob21yOXFQWi9HYUM4TGNvTFVBWVpFZENlVEtYMzIxWEFw?=
 =?utf-8?B?N25vQS9oV2lpNXBuRW1WRU5jakhNb0d5MHQyT1JRUUxlRDU4aG5RRFhPV1Fr?=
 =?utf-8?B?QWxLK0FVWXRnb3RvSFpIa0lIam5PZSticURrNDdNNUhWL2JOUXUyOE95cFZF?=
 =?utf-8?B?Vy9jNjh0Zy9zczhDOUduL3hJUnFEZmlRbkV3UktqUlFodjlmYW9NbEdxdTNB?=
 =?utf-8?B?bUJhcjljSnNyZ2hDZzZYWGgzTkNRNHhPRGRzd1lCME9TMXpVS2t4OHFVSDdS?=
 =?utf-8?B?Sjl3UUlwTmttc2RHRTBTaTlXTk5hVVJUVWpHenB4dnN3ZFM1a0hnUlFxbzZC?=
 =?utf-8?B?S2s5cVRVRXNMWkhUSU9BMjQrU0J3TTBwMWhuYmQzZTR6Yzd3Q3dMRGVjSDdO?=
 =?utf-8?B?d3lWQmpGNGdVakFKVUR1dndCUk9rUnBHd0hRdmtBQXZ3c0l2NVRmTlRqSkJL?=
 =?utf-8?B?WFVuQ28rR3JxR2lpdUhWMDk1Y3dHZGUxbmh6NCtaWXdFOTlmOXFxYkExZWs5?=
 =?utf-8?B?d1lxeEhiSzBzeStOaGNLbk1qeGFvNXZlay9oNHZWUkJ3dGN2REN3OEFzeVk5?=
 =?utf-8?B?UXpLdGJ6bTdNQVhJenNRZk5xWlRhL1RvMmpIa2ZhYXo1NEw3ZjBISDZaK3pG?=
 =?utf-8?B?YkgzcW94dVJqeUJwdFZZUU5yVXczUVNoZ05UWkNHRmpZMnRESmJxYUEyTkl5?=
 =?utf-8?B?OHNGTmpZSnF2ZGtRQlNaWTNWc2RvUDlIK3BiaEdQaFBYd2xwT3dHZ203aDNr?=
 =?utf-8?B?eW9IRVQzTU9pRmlCYzFXbmRaNGFkQnlhQUlJcHUydWlEY0pPcVMzeWtNZWMz?=
 =?utf-8?B?eWpIb1NoOEk4dCtKem1XV3FPekR1SVBvNzBtTFA5ZmFiYWpWQTY0QUVrVVJ6?=
 =?utf-8?B?bVdKR1Nyb0pmS0ZOUzdYUlJpMzlvZmgxb3FFYS94WFpZZGtKdFpJVE15RHUx?=
 =?utf-8?B?Y0JmY2UyaGdiMmVRLzQ0YWVYREhNMFBMUjY3Y3hpa0JnRnlYOWtTbXZlWlpN?=
 =?utf-8?B?M3RiWFFyNmtWTDB4R0hGTWZEWVF6TW9kT3FHVUl0U1lSRSsvNm9aUzU2UG15?=
 =?utf-8?B?MXRvb1BQRGQ5YjNWam9Kc00ySzBkV3RaSXVSU1FKWVpVUlF5Q09EWFJUazUz?=
 =?utf-8?B?cnplMjR0SWdYeE52UnNSMklnTWVXOFF1OXlRQkI1RG5oWXdoUTdNWjJvZ1Zw?=
 =?utf-8?B?QTVlWllGdmNuQ0VMbzh5WVVuaTlqNXpBRG5yOFhMU0VVdTNQNkRIOFJ1Nmhl?=
 =?utf-8?B?bXVka3pqUkFvZytqSFVTbGNlVEc3VjhJaDFBd3FlWm5kTnpXbDVIRHZ5NllP?=
 =?utf-8?B?aUxja2xQc2RxK2x5NU9zaWlKRm44R3YrNE1DUm1ZT2M2OG1kL3BMNVcyRU9x?=
 =?utf-8?B?WGRaZzV1TjZIMnBHSStrZ1BkL2dCZmNRaFJLUmM5ZWJrNk1XSEd3TG13TUVj?=
 =?utf-8?B?Q3N3ZFJYbk1oZkdpdkRLNW1GYTJ3aldudGZhcEc0K3BCMWMvcWthanVLam1o?=
 =?utf-8?B?ejk5NWlDOUx6dnB2Z3dyd2RzYUhNV3FUL1pkUThRVyt2dTJaalBjbFlDMG1m?=
 =?utf-8?B?ZlZhTUJtcHpuT2l4WW1kdGJzL2VRTnhkdDFxNmV3dXhjbU1tZ1ZDRTZIeENR?=
 =?utf-8?B?OTErVi9pTG80bmlQcXNRR3Q0b2M2R0pnTU5UMlNERGFQN1JvSGxPMFI0RmRZ?=
 =?utf-8?B?QXlmajBrZ3o1aE5YWlhSa1cwSGF4bXhOa3p0YThML0RKRE0xclA2V3E2OTh0?=
 =?utf-8?B?MzZ6Yk54WHVvaDM4dVFOdTZOOGdoNnFJdHdhWHIxWGNoRlVtS3hnOUpxaGhq?=
 =?utf-8?B?bGg3OGFjVE9wZUNYTkpGZ1M3UjhyTXJlajVidjQ5UDJhSlpQYnRvcXN1cGlR?=
 =?utf-8?B?OXhZRXpxZVV3bDVRcWM5ZXpyZjRYc1k0YkFzTFdJQmVBeklORzJTUUp6dDVh?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NmNeBDPu6eYb/gMVtxpq6THjCqhJsmDUeUenys3L0YqtqB8zGwIyRa5Wb7y6oi6hVgLN2RrCcqc51Lg2TubD9ErJeLDf0ta0jRMqFqUOursKS353h9cjkpNF52A+QuxqtcvC0eMteXeKQywQv1aZGX2U41f9K6ogv0tvHamInfmlTRHObPRkSXzXBQkX9+5pbDyZFCU+xqytkMjlBnBgLI+MBhWyp9mwiqG4TmSQ0+6dq7tp9JqR5wNgQM3Fomktk6Rf7smE/H/YH44qfwAGO7CoXgwrt1ivxm1lSHHomKBrmK83mtxZv8It+cNbEAIcKNSHLlwkG+3oV+lDrUSrYR1wcbG1QndCdpxW254k5VJXmSTGkbtYoGefydqZzoDKIOxYvAsA0uNL08tURZIk9wYFHpbKlgB2OlsAQFPp6dKat94nWfkvJF73J+plGc6/8RDJ/5cpqyiaME+gRfSyGxA+6Bh1IPkBBpFZhEgZ14dm0vYXWvDIeatiRl30rJyeciGw3pb1t3eWG/TAa4K4RMlUqnC5ICLiE0Mqa/H320VM6/bwmp7j+Roh6K+QMsFER57WM+0MyEH94imJyixi+8GpiFX+gLS4sdQDFii8MZzlkFTFuQsH7YHzg59uRVFwNL/I/tQbFhRooY/fHGMSXKj0KJUZjThAs3KssRheqjekJ0dMnJCL7tehO4WeMvH1Jv5QmyV19z9es3JkkvNxoL41mIO30XcVaJDbRw3ovvYw6tUfx2P6XQiFEzdZD7lmt8+kQyt7Ygd8nGXtn5OBcSJBK3e3X2E2EqNTDboC95FcO5hHL2Sc7cRcRr9RemAY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d9fc35-c000-42d2-79b4-08db66e1329a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 22:56:00.7288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdUkZaMPeWoDDk8DzmuBpmAHelf0cJL++q+g8bKTLWAlo+BA7tvi3dRFHDo90sW7Q+6ChxfcaL+1qz2/IIiLFG8nSf958t/tvliOXYt7TiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_16,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=799 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306060191
X-Proofpoint-GUID: vwb3I-5YD6gooih3dycTUpS8rhWEQBTW
X-Proofpoint-ORIG-GUID: vwb3I-5YD6gooih3dycTUpS8rhWEQBTW
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNi82LzIzIDI6MjIgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBUdWUsIEp1
biAwNiwgMjAyMyBhdCAxMjoxOToxMFBNIC0wNTAwLCBNaWtlIENocmlzdGllIHdyb3RlOgo+PiBP
biA2LzYvMjMgNDo0OSBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4gT24gTW9uLCBK
dW4gMDUsIDIwMjMgYXQgMDE6NTc6MzBQTSAtMDUwMCwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPj4+
PiBJZiB1c2Vyc3BhY2UgZG9lcyBWSE9TVF9WU09DS19TRVRfR1VFU1RfQ0lEIGJlZm9yZSBWSE9T
VF9TRVRfT1dORVIgd2UKPj4+PiBjYW4gcmFjZSB3aGVyZToKPj4+PiAxLiB0aHJlYWQwIGNhbGxz
IHZob3N0X3RyYW5zcG9ydF9zZW5kX3BrdCAtPiB2aG9zdF93b3JrX3F1ZXVlCj4+Pj4gMi4gdGhy
ZWFkMSBkb2VzIFZIT1NUX1NFVF9PV05FUiB3aGljaCBjYWxscyB2aG9zdF93b3JrZXJfY3JlYXRl
Lgo+Pj4+IDMuIHZob3N0X3dvcmtlcl9jcmVhdGUgd2lsbCBzZXQgdGhlIGRldi0+d29ya2VyIHBv
aW50ZXIgYmVmb3JlIHNldHRpbmcKPj4+PiB0aGUgd29ya2VyLT52dHNrIHBvaW50ZXIuCj4+Pj4g
NC4gdGhyZWFkMCdzIHZob3N0X3dvcmtfcXVldWUgd2lsbCBzZWUgdGhlIGRldi0+d29ya2VyIHBv
aW50ZXIgaXMKPj4+PiBzZXQgYW5kIHRyeSB0byBjYWxsIHZob3N0X3Rhc2tfd2FrZSB1c2luZyBu
b3QgeWV0IHNldCB3b3JrZXItPnZ0c2sKPj4+PiBwb2ludGVyLgo+Pj4+IDUuIFdlIHRoZW4gY3Jh
c2ggc2luY2UgdnRzayBpcyBOVUxMLgo+Pj4+Cj4+Pj4gQmVmb3JlIGNvbW1pdCA2ZTg5MGM1ZDUw
MjEgKCJ2aG9zdDogdXNlIHZob3N0X3Rhc2tzIGZvciB3b3JrZXIKPj4+PiB0aHJlYWRzIiksIHdl
IG9ubHkgaGFkIHRoZSB3b3JrZXIgcG9pbnRlciBzbyB3ZSBjb3VsZCBqdXN0IGNoZWNrIGl0IHRv
Cj4+Pj4gc2VlIGlmIFZIT1NUX1NFVF9PV05FUiBoYXMgYmVlbiBkb25lLiBBZnRlciB0aGF0IGNv
bW1pdCB3ZSBoYXZlIHRoZQo+Pj4+IHZob3N0X3dvcmtlciBhbmQgdmhvc3RfdGFzayBwb2ludGVy
cywgc28gd2UgY2FuIG5vdyBoaXQgdGhlIGJ1ZyBhYm92ZS4KPj4+Pgo+Pj4+IFRoaXMgcGF0Y2gg
ZW1iZWRzIHRoZSB2aG9zdF93b3JrZXIgaW4gdGhlIHZob3N0X2Rldiwgc28gd2UgY2FuIGp1c3QK
Pj4+PiBjaGVjayB0aGUgd29ya2VyLnZ0c2sgcG9pbnRlciB0byBjaGVjayBpZiBWSE9TVF9TRVRf
T1dORVIgaGFzIGJlZW4gZG9uZQo+Pj4+IGxpa2UgYmVmb3JlLgo+Pj4+Cj4+Pj4gRml4ZXM6IDZl
ODkwYzVkNTAyMSAoInZob3N0OiB1c2Ugdmhvc3RfdGFza3MgZm9yIHdvcmtlciB0aHJlYWRzIikK
Pj4+Cj4+PiBXZSBzaG91bGQgYWRkOgo+Pj4KPj4+IFJlcG9ydGVkLWJ5OiBzeXpib3QrZDBkNDQy
YzIyZmE4ZGI0NWZmMGVAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQo+Pgo+Pgo+PiBPay4gV2ls
bCBkby4KPj4KPj4KPj4+PiAtwqDCoMKgIH0KPj4+PiArwqDCoMKgIHZ0c2sgPSB2aG9zdF90YXNr
X2NyZWF0ZSh2aG9zdF93b3JrZXIsICZkZXYtPndvcmtlciwgbmFtZSk7Cj4+Pj4gK8KgwqDCoCBp
ZiAoIXZ0c2spCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Pj4+Cj4+Pj4g
LcKgwqDCoCB3b3JrZXItPnZ0c2sgPSB2dHNrOwo+Pj4+ICvCoMKgwqAgZGV2LT53b3JrZXIua2Nv
dl9oYW5kbGUgPSBrY292X2NvbW1vbl9oYW5kbGUoKTsKPj4+PiArwqDCoMKgIGRldi0+d29ya2Vy
LnZ0c2sgPSB2dHNrOwo+Pj4KPj4+IHZob3N0X3dvcmtfcXVldWUoKSBpcyBjYWxsZWQgYnkgdmhv
c3RfdHJhbnNwb3J0X3NlbmRfcGt0KCkgd2l0aG91dAo+Pj4gaG9sZGluZyB2aG9zdF9kZXYubXV0
ZXggKGxpa2Ugdmhvc3RfcG9sbF9xdWV1ZSgpIGluIHNldmVyYWwgcGxhY2VzKS4KPj4+Cj4+PiBJ
ZiB2aG9zdF93b3JrX3F1ZXVlKCkgZmluZHMgZGV2LT53b3JrZXIudnRzayBub3QgTlVMTCwgaG93
IGNhbiB3ZQo+Pj4gYmUgc3VyZSB0aGF0IGZvciBleGFtcGxlIGB3b3JrX2xpc3RgIGhhcyBiZWVu
IGluaXRpYWxpemVkPwo+Pj4KPj4+IE1heWJlIEknbSBvdmVydGhpbmtpbmcgc2luY2Ugd2UgZGlk
bid0IGhhdmUgdGhpcyBwcm9ibGVtIGJlZm9yZSBvciB0aGUKPj4+IHJhY2UgaXMgcmVhbGx5IHNo
b3J0IHRoYXQgaXQgbmV2ZXIgaGFwcGVuZWQuCj4+Cj4+IFllYWgsIEkgZHJvcHBlZCB0aGUgUkVB
RC9XUklURV9PTkNFIHVzZSBiZWNhdXNlIEkgZGlkbid0IHRoaW5rIHdlIG5lZWRlZAo+PiBpdCBm
b3IgdGhlIHZob3N0X3Zzb2NrX3N0YXJ0IGNhc2UsIGFuZCBmb3IgdGhlIGNhc2UgeW91IG1lbnRp
b25lZCBhYm92ZSwgSQo+PiB3b25kZXJlZCB0aGUgc2FtZSB0aGluZyBhcyB5b3UgYnV0IHdhcyBu
b3Qgc3VyZSBzbyBJIGFkZGVkIHRoZSBzYW1lCj4+IGJlaGF2aW9yIGFzIGJlZm9yZS4gV2hlbiBJ
IHJlYWQgbWVtb3J5LWJhcnJpZXJzLnR4dCwgaXQgc291bmRzIGxpa2Ugd2UndmUKPj4gYmVlbiBn
ZXR0aW5nIGx1Y2t5Lgo+IAo+IFllYSBSRUFEL1dSSVRFX09OQ0UgaXMgb25lIG9mIHRoZXNlIHRo
aW5ncy4gT25jZSB5b3Ugc3RhcnQgYWRkaW5nCj4gdGhlbSBpdCdzIGhhcmQgdG8gc3RvcCwgeW91
IGJlZ2luIHRvIHRoaW5rIGl0J3MgbmVlZGVkIGV2ZXJ5d2hlcmUuCj4gVG8gYWN0dWFsbHkga25v
dyB5b3UgbmVlZCBhIGxhbmd1YWdlIGxhd3llciAoUkVBRC9XUklURV9PTkNFCj4gaXMgYSBjb21w
aWxlciB0aGluZyBub3QgYSBDUFUgdGhpbmcpLgoKSSBhbSB3b3JyaWVkIGFib3V0IHRoZSBjb21w
aWxlciByZW9yZGVyaW5nIHdoZW4gaW5pdF9sbGlzdF9oZWFkIHNldHMKdGhlIGxsaXN0LT5maXJz
dCBwb2ludGVyIHRvIE5VTEwgYW5kIHdoZW4gd2Ugc2V0IHRoZSB2dHNrIHBvaW50ZXIuCklmIHRo
ZXkgYXJlIGluIHJldmVyc2Ugb3JkZXIsIHRoZW4gdmhvc3Rfd29ya19xdWV1ZSBjb3VsZCBkZXRl
Y3QKdGhlcmUgaXMgYSB2dHNrLCBidXQgdGhlbiBhZnRlciB3ZSBhZGQgd29yayB0byB0aGUgd29y
a19saXN0IHdlIGNvdWxkCnNldCBsbGlzdC0+Zmlyc3QgdG8gTlVMTC4KCkhvd2V2ZXIsIHRvIGF2
b2lkIHRoaXMgdHlwZSBvZiB0aGluZyB3ZSBuZWVkIHRvIGhhdmUgaW5pdF9sbGlzdF9oZWFkCnVz
ZSBXUklURV9PTkNFIHJpZ2h0IGFzIHdlbGwgYXMgdmhvc3Rfd29ya2VyX2NyZWF0ZSB3aGVuIGl0
IHNldHMgdnRzawppbiB0aGUgcGF0Y2guCgpPbmUgb3RoZXIgdGhpbmcgaXMgdGhhdCB3ZSBjb3Vs
ZCBqdXN0IG1vdmUgdGhlIGluaXRfbGxpc3RfaGVhZCB0bwp2aG9zdF9kZXZfaW5pdCBsaWtlIGl0
IHdhcyBiZWZvcmUuIFdlIHNob3VsZCBiZSBzYWZlIGxpa2UgYmVmb3JlLgoKCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
