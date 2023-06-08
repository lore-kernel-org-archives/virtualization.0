Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08753C7EE23
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 00:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 810C58217D;
	Thu,  8 Jun 2023 00:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 810C58217D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=xYYZTOGr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oLgbGkh5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KbpZZTm0DwFP; Thu,  8 Jun 2023 00:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 087F081521;
	Thu,  8 Jun 2023 00:39:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 087F081521
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D74C7C007A;
	Thu,  8 Jun 2023 00:39:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4FD5C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC6598217D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC6598217D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OeTwtqX5iGIz
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:39:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD74881521
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD74881521
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 00:39:19 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357LxlZE017140; Thu, 8 Jun 2023 00:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ExQFX9vIk2qzsHHIrs+IHBoW5ndM/XQ65MqzbrEuoJA=;
 b=xYYZTOGrWc5NYzb6xu09eMI8+/KcwEy9mpgAxPWE0RhKgnKqP210vYWH9EtVwcK3Hhy0
 aPz2dN57DzwEsX2zRJ65AHSnm4BHqqGxklADkqrQdFNQyr9XOUGzozCaerRKz5uyGXLt
 NiBd029wRzc3tHCXXUfQHIXKqItnCtxZwAAmNGK28pB9031DJyLvPM1U3rNMuWDY0qWC
 I4fGZtScnJbN2q7xYcbqDYYJRRXAdSR7UvTMNUGfX4hOYH4An4re2bR4D87kW2Q/Ls5+
 zjNbmw3bp6v7QqUz1RdSmgrUZcJ5kvh6z4TmMsTCkOF8NDw5U5DyudMYBrwm1Uiz+Izt jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pk3c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Jun 2023 00:39:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3580b8HT036877; Thu, 8 Jun 2023 00:39:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6kembv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Jun 2023 00:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl4CQ96kYUdsgcYVxLVpeqmx5x2KlHbzqSvpCuLWA/6uE5pYOQ7c3bGL/smAwIAnf/yrktu34Magp0ffLleanZeAfnCN2uCo533cpFD8hoxRcxvBN9XL4M+UMhyEzfsLwO0lut/H0S8hy5GhkbJFYk338HGb21QFzCwxDBNCJLWUWjhR3EHVN1YGYi/6xHPXddClhF1D9JxPOpvKm2R0B/CkzKoVrFR0BuTnQRbkwU6ybVOQNBrXnpXUV2mjLsSNGfdUT4BVXCM3pf/dfO5jGcGJTab5NIukU6mUXqVqMmXqvYGaPZ68APoQwKNWO8oEizCacCQGywbR5HxvOWDhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExQFX9vIk2qzsHHIrs+IHBoW5ndM/XQ65MqzbrEuoJA=;
 b=Oa0x8eC7qgmT39sDF0UBdqjAn/ExanT4x3xZ7I2Mpt0UNiPbAhafO11TB16hlQeSrWMPDAlxxUbGVKcRBcwfzmMouSGSRgS4ak1+SCb2yi2RsRZyJVsMxtqVxq/qz/94jGsKmVrPJTyniBK4VclJtcHBukm8ktCR0txnlvT1XJAVfzJJ+yTUvsB1NMRX2VKsjwFhpO1hPgPNfkaBv/5wHKQ4LsQIAj9zyhO19zwKzaB9M7Il+kq7qAaB/yQJqEbWzenRJBC90Q1icyO1js4Q1FQnZGtK2flFhoNMxtJKRvkxmjVr/8XknXebvkRrfAcVXa4gsf/hRBborAe23T7ydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExQFX9vIk2qzsHHIrs+IHBoW5ndM/XQ65MqzbrEuoJA=;
 b=oLgbGkh5JiaEiMYMsFdeM+QaMkF+tsnPMxA3LSB2V1SzdMQ4g08rVA7zlNgy3qGUmPoZOzLDPyqHju+xZMIEyMewS6mbpvwwRZf7NEjr0uHu/mVkR/Zv9pb0jgQkoTu2PMLvSSRXcKM+sTDUbYYplPjxz66SSzpT7ndhTWArrB4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 00:39:00 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 00:38:59 +0000
Message-ID: <32ae757a-1dc6-9c2f-3e3b-a1f39683f556@oracle.com>
Date: Wed, 7 Jun 2023 19:38:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: vhost: Fix vhost_task regressions in 6.4-rc
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230607192338.6041-1-michael.christie@oracle.com>
 <20230607162028-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230607162028-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DS7PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::22) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 52551a0e-d5e6-44d5-f778-08db67b8bffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JESfg/yJL+drwTcWG8WSS/XlDQi4ZjBjFvlu7jigUyg1u01QQPbspo4AQSEM9LJl9pADl6ewwHi5Z99SZP9T1/AVOnIW2HIIY1lgsd8pht/roZvC70Xzz7QmCjgsPmyGcNPvSf5B7s9WlwGzpOrm9/TUNIBJ9m9lgfD5w5PEXZbUfwj9wyZOGRjOEppv68i8myobZWFD8W7Z0XlnTREkrKwknIKYPp9hrUbKzjy92vavD0Gu+qiEdH+HsBBtE7hLV6TVJDcFQ1Z3ytPpfwvTOZVbHj8/UiL9gdmhFeJ+C/KDcKwHhd6j9jT/RuLSgZao4GoVsZdBj3el8pNrdsnlxf3ZwQzUwCFw1kTadWyE2HRGzbxfLedAacIibt8ziYsxjEiDEt645ifqcUW3ddm/uraOBr+vdv7lwPWdLlyAr+PrP0Ibj3+cSkISdO9H3crUpWe3GT1ENtbPWtHEsnxFFuaRqr9kxYC5zFU1VIJA0MMrkD1/dpWzhGA0DqHjzQf/tSIQEed9Kpbp0cDskvt3Ai32HQ4iMt2Ci62oe0VWnUorGDX1TDANVHCkenaJL6rN8fdf1n+zywkzvMG7kmMxbBNkx2kSEVwA4WsKuS0Fu/+K/0wQ9HMkpvuFoTtU2eujgzzchSQGbMH5eb81Sd7Mjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(66946007)(478600001)(6916009)(4326008)(4744005)(8676002)(316002)(31686004)(2906002)(41300700001)(8936002)(66556008)(5660300002)(6486002)(66476007)(6506007)(26005)(53546011)(6512007)(186003)(38100700002)(2616005)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhER3IwRWtYSjVHUUJnR2h1Y0g0UFBZQ3NpSTN2MzZJUHlDN1IxQTRYbHVT?=
 =?utf-8?B?WWlFNytIUWFmNlR0aVRLdG83akRnRTBHVTFWVDNyRWpxL0pSK2tSbzFNUS9R?=
 =?utf-8?B?VHpKQmVQczlaVlQ4M3lOdHJuSDhlM2hRc0dyL2VvREdMN3d1L3UwTG9HOWxH?=
 =?utf-8?B?dytpYjdWY1pRNC9KRUNCSFd3MGdhZ1E3cHZUQTBDRzFuNDhjNDdZeHpRN1hu?=
 =?utf-8?B?dGdkZjRvODAvdnB4ZWJxVjdvUnUzczhibVkvd0d6NmNHWUdhRWZQUnZ5T2Nq?=
 =?utf-8?B?SXE0M0J1Y21vWDhydXdheHlucEhMNENhZ216cFAwVlZlbFdQRWpYZE9iRm5Q?=
 =?utf-8?B?c0IwVzFmc1NqRHVyUlNMSWdab0dlWUVRWEpkVDcvK1h2U0JFM21kdGtxS2JL?=
 =?utf-8?B?QjRPQ1V2T2pKbmcyOUdZTndDaERrQys0VzBuYnk0VktaQWFiMlRzQU5UMmpq?=
 =?utf-8?B?ZXo2NEtLTkM4UmpWUS9kcm15d2FnQTBNeW9oTWJSNHdUamd2UDVaOGFibVlv?=
 =?utf-8?B?ZUNnckRoakhXWHNLS3duNzNoQldZeElBWFQxWGNycWNMd0tycmUwMHY1U2o0?=
 =?utf-8?B?dVpyd2w5YWdmNGRYcGNRUExvbm5qeml4VVpEUFdzRTF3VVF2Q3krQnROQTM1?=
 =?utf-8?B?elBwR3FkQm5IOS9jczVKY212d3VtekpiMnN1cmxQQ0RpQnlzMzNsd2M0UUhJ?=
 =?utf-8?B?UTRBcmFtVVA3TGVOZklJcHZvcU5QTEFsZzN5Tjg1NUVKUmRsNFZORnVhSDhq?=
 =?utf-8?B?SllEd3NmYkg4a2ZvY2ZEdTRibnhCcXNEcU5CSTlNQ3lSNlRHTjhQUUJJZ2tu?=
 =?utf-8?B?SGRKNHNxWjEydnlrLzFlTWlsQ2FJU0IzamNGN3psckNaZVJUeDd3bzJVM3Bl?=
 =?utf-8?B?YjViWHp6Mk1lYlU0aHk4Tk05dnYvVW9CUEVlaUpZaGxDbk1xdWlEYUNXVVJy?=
 =?utf-8?B?dUhKN3diWE0vSmZzZlp5YlhiVlBvQUJ6Y0RrbTFsMnhNbko1ZUQvWlRlWEFS?=
 =?utf-8?B?eGNobGJBVDNIa0o4TjVPcHlJYzBlMmdnU3RtSmVIemJkUktKVEUrdXZuTXpj?=
 =?utf-8?B?VzI3aVhYU0F1U1hxQ1kzQ3EySzFzZm5hMTdDUVhjd25ReDhmYjQvUm5sN2Fr?=
 =?utf-8?B?OVRzclBjaU9TdzliTE1LaThaamRrc3BaMDdZSm5HbnBJemlJNWNJQnFwdkgw?=
 =?utf-8?B?T3RRdk1CRkVSVFY3L2l0cEk4ZGV1eEpoRE85QVVFNjVBK1R4N2VjT21UQnhK?=
 =?utf-8?B?cXluRFZHRU1jTTJWZWZXU21xMnhES3ZRamt6eDVFYXZNdjEwaXE2T3UvTTVE?=
 =?utf-8?B?M2YvZ1d5TlVhajlESVoyNkt5a2dSSXB5NEZ1OEFMZGlrWmpwWktuL3Zsb2FB?=
 =?utf-8?B?amZ6THdQZURseGxpVlE3bEdmUkVhZ3lvQTdZK1dSaDFDdGtBdlp1bnkzdzZH?=
 =?utf-8?B?UzVMNG5RYk9leXg5bE1ETzV6Vzk5NVUxN1J1Qm9FSHIvNklrQUdHendWTHgy?=
 =?utf-8?B?b0lmM0pCSk8vYUZQNy8xQzR2ZEhCcWVDb1YxamZLVlJXMmZOMVgramJMckZ5?=
 =?utf-8?B?cUptejBqM3RMMzE2RGVMdW8vdnN6S2FkeGZRZzVJV21FSi9uYU5uZmJnSith?=
 =?utf-8?B?UW5Zeno2aEczMmhzZ3BUV1ZSSzVjbTVrTTliYW1FZko4L2JSaEg1UTZlenIw?=
 =?utf-8?B?aEZFUzVhVXYvNGJXemVGUFNzUUtYL2ZNalZoZC9vWDQwS0UvMWRSSml6ak9L?=
 =?utf-8?B?cjRaNUdjSU1JSCtXRENXdU8vK0FuckpXU283U3Z0SW5rWm5NajlFZHAxVlc4?=
 =?utf-8?B?cjlaSytNQ3hrd0RvbGJyN2FQME5ad0xVdVZBTUl1Q1ArNUtQRVg0TWxVVGZl?=
 =?utf-8?B?dElWVWkwcDZwRFZrbEFaWDY5MUV2dGQ5WWhlVlR2YjFxYnAvbHZXL2FzVGtN?=
 =?utf-8?B?TmNkMVBFUldFTVZpTXhqRUNGeCtyRWZhalFCejJHQncxNk5FazZULzVwU090?=
 =?utf-8?B?dGIvTXZJWTQ2ajhLQTdYbzdSSkpMOXlJUDJvY1NLQWpLbXdtRXVjdG1YdnRq?=
 =?utf-8?B?cXpPUHRiN0haZTN3WituRCsyclluMlRsTXYrWVlSay9iOGw4VVQxaG1LQ0pU?=
 =?utf-8?B?OHFCMDg4QW1MWFdLYTEvdTlHcXYxL1gyd2wzWTlqRk9NaitiMmhsbDQvaFRK?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bosdV1jwRV3kpXbsR5UlmFYmZkdsZPBwV3qF4Z2xH8gvklZyaoXADN5e8h7PrwL3V3Sbml3QE+7JWACtlhDdMrOwFQG8qzvdQ+QMrlv/VMHmf+p9xU5NM00L8c+DB3pO9e2usUTo6rvhZzwAIQD35HAqbEtKOyFiIl1MOgC80GLy7KIV9HCvbJJ0UEMGEpE0TJMuVkwIf4sde8rgcuM5v0edyHNil5H+NmMtcaCgKU4H5k1jO6WO3ag0Zt4gfxTWaiPEjE2R5Anr7wzojArTaEvrj9oyxcr0lpz32XNRX/D/t9DwGdQWMHpaoibMMXmqTaYeoTsWYbL2Ac8GbN1jG5xtaygrcgQJFU2U55sZU95W5CFQPtKP6gWCVrAM5WNsL8tCfpKXJtM5vUgA62dJ73zJwCfP27BeOcogr5X5AsnNQER0uF6U+TTpBm90awBMke9DteOClpLSNEO7P+zcDR/Yoz9j8+KsEJ81Fq/DungR/GwvrzsuZCV3jDchndH5OohyLWz4idRoQRfk1knX++Xl8WbrxuTrO4wv78o10ndLnOU7ay2UQZ5JxLjLLZDdu0Oe7yArFBV4JL2vWaoiVCmSoVWq479l/gRSHcyF+ZbNAgQqfuxfyalExAonP+zOirOabQaY0HdR6E5rq0LbFrp2JWLctYVpB4Ve9cxdU/rVcYIRgcefJcv9atnrwssBhcwduCY39wJsKxCpY5uaQvNgjv4lvx0XDwgBm1qCNvZ1Fk8PM9QJeHG7v3YorGirvTcwB2ju8RcxXhocIXqFQPCFnPjgq+EGVOECmbPFt0v6R5/TuCV/KVP6OXmiBm3T
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52551a0e-d5e6-44d5-f778-08db67b8bffe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 00:38:59.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGfUT0UDhE3hIy1KUAadk04RHYN04pNIOIkDhNZuCE8WL9bmJi1DyRTEwWbkelpggEsHe4ot9ockFUSxf+exEqUIco/bvSEwN4ojLDRuCdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=963 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080004
X-Proofpoint-ORIG-GUID: 4EKnJMxX2Cpt02d7RPFfma8m4HPWLbyX
X-Proofpoint-GUID: 4EKnJMxX2Cpt02d7RPFfma8m4HPWLbyX
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 6/7/23 3:22 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 07, 2023 at 02:23:36PM -0500, Mike Christie wrote:
>> The following patches were made over Linus's tree which contains a
>> vhost change missing in mst's vhost branch. These patches fix two
>> issues caused by the vhost_task patches:
>> 1. I was setting dev->worker too early and this caused crashes when
>> vsock would queue work before VHOST_SET_OWNER.
>>
>> 2. The patch that Linus's tree contains which vhost does not yet
>> have converted vhost_tasks to use CLONE_THREAD. That required a
>> change to how we set the task state, but I completely messed up
>> and moved when we set ourself to interruptible too late.
>>
> 
> Right. and that's in rc5 yes?
> 

Yes.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
