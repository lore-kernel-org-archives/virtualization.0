Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9ACC00140
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 00:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3C7480C36;
	Thu, 11 Aug 2022 00:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3C7480C36
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=zO4F+9i4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gFWPhwqw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f_KiXAWrAyBj; Thu, 11 Aug 2022 00:58:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F61D80C27;
	Thu, 11 Aug 2022 00:58:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F61D80C27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03115C0032;
	Thu, 11 Aug 2022 00:58:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D773C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5372340B67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5372340B67
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=zO4F+9i4; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=gFWPhwqw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KeTjiS81n-Vz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:58:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 212D14011F
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 212D14011F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 00:58:46 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B0iUg8024885;
 Thu, 11 Aug 2022 00:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WXdYrruhpj+gD0bFI+gDdNLBurhdiGGHsejtd7MH2FE=;
 b=zO4F+9i41ei5l60am/x+Fnrx0mbwAvQtFJHXVAxFME6C8taUVPqwkXvmwgZ9IJoHMG9E
 ZZRd2+kYLHhqaMv34u3bzPbY9XfmZ5vm7N6GI6XOmL8RQ+HrqcxFkxr2BL+dJjpnEKet
 MTDOqbKrIe3lSHEf4PswpHl+NqDYjzkd/vC8wkG0RyHCfs8mm9sSpD4umqGbm20Jbr9X
 0Rcvlc1SAbQYvuEEwCg7+uWBNmZN7hCj8SuslyOmkvRHtqdvf8pnJVT1V2ZOJFOXvWem
 hx/WjPjkxh0Y6aDQGmlpvqvc28KIWYzh3D5akXLKTSq41ZJ7UFlV1G5hRAzgO/kcVnM5 tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq93j9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Aug 2022 00:58:42 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27B0idJr035232; Thu, 11 Aug 2022 00:58:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqjnjsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Aug 2022 00:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G95akF4QZcyWIO4Kt/LXZyBh8YOczfWpipxcaEXR6zPPP0MZRvMlIE6aum2L73R0HJhE9QNunuWM+ZyZV/ZalKf3uEQi1BeSSeyeqvvqfaSqH/PEMT/3BGz+kjerr1hroG3/PXKNsbu6gbLtpxZ6Bu2Dk5JVEDgrPQ6jLWz2l19dq37Ma7wgK7L6gkyXPvO0GUBvsPnSb070pvoGizHILrmNrPRT6/zTiPzGIKL5qvfuXzD2Hg2AvlT62QSr8bz39AFoD/XinAiCQ4SGEcrI2Vv8/SpNniG/sJyhWLGpYxltNZVRpn8BJgAiuguEHjdEGkOhHQZfGST9A8gOD0qopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXdYrruhpj+gD0bFI+gDdNLBurhdiGGHsejtd7MH2FE=;
 b=f+7guce5HS/th8BQRecUj2ofKn5bdyuAui/Mt+1bnfxafDi7KzD9OApriRuKRF1IZAWTtmTjd3LrmPIyjzGcFdaTHasqE+zJUIYjsmbjsSr2xpaucAzpryy6vowKRXqLEUPzgbjCMe9HBugOnW9Ha0r6/SOGjKcGus5s/b+Y1M2WaAFqrk6PP048xXs4Ngm6JtXOgz6E6ostVIXSQ7IBbDyw6M2ntkYVgX03MAQ21xdkCj/fvwdzYhzihg2Wmv/Z7EoHfZb7XbVm3IT1KEUYQAipFwqpWvxWEiUwJJx01n9pWIOk4CLvka9hLI2Kc7ujSiyJZYOXAMgDEeK4X4vQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXdYrruhpj+gD0bFI+gDdNLBurhdiGGHsejtd7MH2FE=;
 b=gFWPhwqw26l8Ooqhc5bub4xNMfdirQ1q99xo1RCL0/X+zYnCUPzq3/bUK2yOAatYRijMdJKpRU/ZK9u7RPF8qIVSKYil4D0gvyXm+BwOf3pLrN4OOkQb2st409MEmbnmnz9AGRBHs2HRYpkuSwgiw5g/tNkrlCg/1DGOAcUwQFw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN0PR10MB4998.namprd10.prod.outlook.com (2603:10b6:408:120::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 00:58:39 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 00:58:32 +0000
Message-ID: <6cccf981-a443-fd7e-7c90-cadb9c56bc1a@oracle.com>
Date: Wed, 10 Aug 2022 17:58:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-6-lingshan.zhu@intel.com>
 <PH0PR12MB5481AC83A7C7B0320D6FB44CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809152457-mutt-send-email-mst@kernel.org>
 <42e6d45b-4fba-1c8e-1726-3f082dd7a629@oracle.com>
 <CACGkMEuSY=se+CnsiwH2BdaAv3Eu7L=-xJED-wSNiDwCP9RRXQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuSY=se+CnsiwH2BdaAv3Eu7L=-xJED-wSNiDwCP9RRXQ@mail.gmail.com>
X-ClientProxiedBy: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b67709-381c-4093-f95a-08da7b349c6e
X-MS-TrafficTypeDiagnostic: BN0PR10MB4998:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSjob7UuVu9JTC3ofANaMgGWxiB32713ysEEfLU0goB9UhnWM/t6KXTeStHGYZydKoV5hBMcymqzvFRx5tTuari5NVWR+rKW49/66xvb2jpd6pTxhnSqwdoDLKQMbRKO+JqzxCNZ7kFK7FsvWPPvRd8JBu11OpQnKlBZ/s/I03Rd2YaMzblwJJFLIHGKH9ups9V2UCvjmfEiTG/CBT+2S5UQgQ0ImEEkr5m3vRh8tuGufU4psa7OHOc9aT6D5HR6q5rPmPMczxgv4Rh9KrrCsAoM1TiuJ9+IciqNsE06mFK9M1BIT1UpZxqBGdb4d6UvIyqbycSwfP9JXyuenf5GR/d9RieIGBSsJsETN/f/lSLlVSxDvV8xFV0XlMeQI2DCQ0ZgYKxbz8OgdIDQqeNyUBhZcv9BOhydIsmOEYlBn7DMzYWNiDvNI4DO3NoIYBRBX2NRZcgJAblUwV/0PKa2WBvPH+YtCxUBm0lwDCmSlgYEXoNv6p6jRSOT8A3vi6m3S+2w8+IoziuDKBoBVKECXCd3RVDp8HwO72F/0mS2JqJOW0Qu3bm/mZqHh+cqMOr+Cd+MfxhC+NPhEMSYhSKQ+Y5SdbeulHYFR7aMkB2yDkJh9wfiqhbxkEFeSuYAqaE+D80MmElbDow2b3F9JWuO4vz8zR3HjrOFwVMrZlEwOA1psuK2JD900RyukLr2x5ov+h0cjAe8gzB34MxA0hkzQLKXb88BxNlDh5kWctf8qvDUUMzpAGykRTzeGkFd9z+sGQk4ZNz09sYRBjU/IVQ8PKt+KTM9PlNPu0NvwnYCXbue/65xbnEGvQp6zoyqTdaPhubwsRhuqSWGhGMr3wMSJt0y4G0sUCECFE8Uswx1tiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(136003)(396003)(376002)(346002)(39860400002)(26005)(38100700002)(6506007)(36756003)(6666004)(6512007)(41300700001)(6486002)(31696002)(36916002)(86362001)(966005)(83380400001)(478600001)(53546011)(2616005)(186003)(2906002)(66946007)(4326008)(8676002)(31686004)(8936002)(66476007)(5660300002)(316002)(54906003)(6916009)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak56YVdkTnZaQUs1d3E0azVHVkorLzlHZWlOdHk4MlZRT3pXdWdTT1ZHbkxK?=
 =?utf-8?B?c25tdUFic0NRemV5QWJtNEg2TlBhVGU3TjNjNXRRSG5saStYcThhOWdDUit1?=
 =?utf-8?B?QUl4cXBFVm9MNEVsdkRsVkhSamN5blZzc1JpK0FCK2hXTFpJOWxJSVpRc3B5?=
 =?utf-8?B?djNNV3ZBNS9oYkJtd0FuS3JTTy9QcUhCVTFQZFpBSUZMeGRzRjBpa1orNUxD?=
 =?utf-8?B?VmRISElkdUFjMzlHYXBIcXExejByaGZsVFNUa1RvT0ZZTXVGL3FqOWtSWW9I?=
 =?utf-8?B?L0N4K1hkMFIzTXo4K2d4eGUzbUt3cDlnWEZBajlzcDNVT1FnendleFFmbFha?=
 =?utf-8?B?MHBhZkZoSTRGRjlYbjN2NXNndHdZUVBVUFVPY3ZNKzZBc0RGUlc1K0VHVzZ3?=
 =?utf-8?B?Q1ltbnFoNzhHbVk4LzZJRHBabnZsbHpISWhUcUtVRUtGN0ZTNDNhd2ZZWXRl?=
 =?utf-8?B?RStYMTZ6c2VML0x0clc3emlIL2pmMjVxTXNkcjNyTVBnbVg3WjV6QmROZjJC?=
 =?utf-8?B?eURYVzhGdEcwUUJoSHBZR1dYNWVSOGFkZEhBYmtBelMvQUhyWmNSMU5yeEFH?=
 =?utf-8?B?NU1QVXNldUttTTViOWNja0cybTlhVFZGR05jblBHN2N5alR0QzhJQUZnTTBD?=
 =?utf-8?B?bEdmRzIzZy9ENVdsNEE1VTd3TWNlYWtscWNMR25hcjNJeDJWOUt5QVBydHUy?=
 =?utf-8?B?QVRWaWhaWk4zdTdFdzNXMldMWUNhZHhGYkdWWjVyQ3B3VDFrSnREYzVUbGor?=
 =?utf-8?B?MXRxcGlsNkxmNjF5QW84bE1YT284REl3M3hVbmMvb00xUU1TZ1FWWFhsTVMv?=
 =?utf-8?B?bU1IZDJIZzlmakZlVHZCV1JoQmF5aDh0S1VVbzVyN1NXMVF5WW5ESi9FdTc4?=
 =?utf-8?B?WThCb3BoN01xZVFYdFdXSWNRM2hJVXFDNWI1eHBlSFVxMktRRUFYcnlDOEh3?=
 =?utf-8?B?d1FnWDlOZ09VQ29uMlkvZHRSSURJeVh6bGtFL0pzTC9BeEh1TVl5eFFmQjBX?=
 =?utf-8?B?Nnh2WE81NWZ0eFY4UTNGa01wbG9rcmtLYkRVSHJBRThLNW45a1ZqWWYzWFJD?=
 =?utf-8?B?Z3oweE4zeTdVSTBOSVd3bG5rSlR3UThadE9SVDUxVzlJTFMxYk9vRVlCRkVW?=
 =?utf-8?B?M0FDOEY4dUs2WVRrUllaU25sbVNyOGcvUmltOUxkenhNNVVKcHZMait6cXFp?=
 =?utf-8?B?WEhpNkVLT1gydjErd05mNG9UUXYraUdUeWRFZUJlbDRURjlseSs3MFJBVk5i?=
 =?utf-8?B?eVFnNzQ5cXI2S1Bqc3RSTGRHNnRkYWNlQlNVaVlaY3p3K040azNZdTB0YXdt?=
 =?utf-8?B?dzJTaXR2MXhwVmxaWlh0M0J6WlJyTmpURDlaZE4yRXhSZEREU3ZtUTJLQmpt?=
 =?utf-8?B?TmRaY01VeFpVVDlZYit6cVJCMnBrcVNwT01Fb2JobWdXT2VLUWxaVVhFa1JJ?=
 =?utf-8?B?VmwxMWNLRFNoL0ROcXI1c09ma0xGOUJqQ0tZTTdnbnUzNnp3U09WSG5KM3dZ?=
 =?utf-8?B?L0xPSDNabVpmZ1VrYkFqVFJCOS96cHNhdXdGUERQOGFTLzkzT0M5WTNEemU3?=
 =?utf-8?B?YjkyS0ZFUnlwWTFUNVVNNzhsQ1ljSmwxNUVLYmhHQisxWjJ4L3pJSXZSODBm?=
 =?utf-8?B?Rklzb3VmMStoeUxhdWNRSENhUDI4V3FaMWx6WDBQcFVpc2N3UG5uSWR2NStX?=
 =?utf-8?B?Sm1Qb2hwekNVK2E1eHdHK1phOGQ1RC9VY2g5MHI1NjNyQ1lHSjI4SmZETjJX?=
 =?utf-8?B?cGFFaWt0TGdaT09LMnZvamVzY201YlJOekY3Wk1iL1Y0NlJUcUViSGRXajFJ?=
 =?utf-8?B?akhnT1lLc3l6WW4vbmhjY0JQSU5vMHd3TmtrVjF6SkhucXF2YUs2S3BqUlVu?=
 =?utf-8?B?blBUdmtoM0xSZG95ZDZuRk1KSlBpblJNUHB0SVZ3R0RGYmRxU0RteHZnN0dw?=
 =?utf-8?B?ZkVoRTNORmJDTEhmVjlWRnN2eVZybzRUbDRjdmFPTGNlT0dRRGZjRDRVaEpC?=
 =?utf-8?B?SzNNVGo0VEE1ZlNNeFhJNjYva0pPZlNzMGE2eUR5SXphUDVjRmFONHhzcjFu?=
 =?utf-8?B?VGdDa3JJbnQxN082NzRhWW9qaXBacU9hZmtId2ZBTEpnaHhxQitnVXFHTk1G?=
 =?utf-8?Q?J7hWVc00PVLZqmsfZQZs0VIGQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b67709-381c-4093-f95a-08da7b349c6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 00:58:32.0943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYKrdd9nHz1oIiT7n3MBsko7VdhoZ67ptHbXN4hRVjEM5r7hHnVJDHEE2ahNnikMkLTh6YiJFciW9yZe0j/HyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208110001
X-Proofpoint-GUID: yOa8OZCEV98bZc93WXPwbwTtw2RnygB0
X-Proofpoint-ORIG-GUID: yOa8OZCEV98bZc93WXPwbwTtw2RnygB0
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 8/9/2022 6:09 PM, Jason Wang wrote:
> On Wed, Aug 10, 2022 at 8:54 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/9/2022 12:36 PM, Michael S. Tsirkin wrote:
>>> On Fri, Jul 22, 2022 at 01:14:42PM +0000, Parav Pandit wrote:
>>>>> From: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>> Sent: Friday, July 22, 2022 7:53 AM
>>>>>
>>>>> If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair, so
>>>>> when userspace querying queue pair numbers, it should return mq=1 than
>>>>> zero.
>>>>>
>>>>> Function vdpa_dev_net_config_fill() fills the attributions of the vDPA
>>>>> devices, so that it should call vdpa_dev_net_mq_config_fill() so the
>>>>> parameter in vdpa_dev_net_mq_config_fill() should be feature_device than
>>>>> feature_driver for the vDPA devices themselves
>>>>>
>>>>> Before this change, when MQ = 0, iproute2 output:
>>>>> $vdpa dev config show vdpa0
>>>>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 0
>>>>> mtu 1500
>>>>>
>>>>> After applying this commit, when MQ = 0, iproute2 output:
>>>>> $vdpa dev config show vdpa0
>>>>> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 1
>>>>> mtu 1500
>>>>>
>>>> No. We do not want to diverge returning values of config space for fields which are not present as discussed in previous versions.
>>>> Please drop this patch.
>>>> Nack on this patch.
>>> Wrt this patch as far as I'm concerned you guys are bikeshedding.
>>>
>>> Parav generally don't send nacks please they are not helpful.
>>>
>>> Zhu Lingshan please always address comments in some way.  E.g. refer to
>>> them in the commit log explaining the motivation and the alternatives.
>>> I know you don't agree with Parav but ghosting isn't nice.
>>>
>>> I still feel what we should have done is
>>> not return a value, as long as we do return it we might
>>> as well return something reasonable, not 0.
>> Maybe I missed something but I don't get this, when VIRTIO_NET_F_MQ is
>> not negotiated, the VDPA_ATTR_DEV_NET_CFG_MAX_VQP attribute is simply
>> not there, but userspace (iproute) mistakenly puts a zero value there.
>> This is a pattern every tool in iproute follows consistently by large. I
>> don't get why kernel has to return something without seeing a very
>> convincing use case?
>>
>> Not to mention spec doesn't give us explicit definition for when the
>> field in config space becomes valid and/or the default value at first
>> sights as part of feature negotiation. If we want to stick to the model
>> Lingshan proposed, maybe fix the spec first then get back on the details?
> So spec said
>
> "
> The following driver-read-only field, max_virtqueue_pairs only exists
> if VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set.
> "
>
> My understanding is that the field is always valid if the device
> offers the feature.
The tricky part is to deal with VERSION_1 on transitional device that 
determines the endianness of field. I know we don't support !VERSION_1 
vdpa provider for now, but the tool should be made independent of this 
assumption.

For the most of config fields there's no actual valid "default" value 
during feature negotiation until it can be determined after negotiation 
is done. I wonder what is the administrative value if presenting those 
random value to the end user? And there's even special feature like 
VIRTIO_BLK_F_CONFIG_WCE that only present valid feature value after 
negotiation. I'm afraid it may further confuse end user, or it would 
require them to read and understand all of details in spec, which 
apparently contradict to the goal of showing meaningful queue-pair value 
without requiring user to read the spec details.

-Siwei

>
> Btw, even if the spec is unclear, it would be very hard to "fix" it
> without introducing a new feature bit, it means we still need to deal
> with device without the new feature.
>
> Thanks
>
>> -Siwei
>>
>>> And I like it that this fixes sparse warning actually:
>>> max_virtqueue_pairs it tagged as __virtio, not __le.
>>>
>>> However, I am worried there is another bug here:
>>> this is checking driver features. But really max vqs
>>> should not depend on that, it depends on device
>>> features, no?
>>>
>>>
>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>> ---
>>>>>    drivers/vdpa/vdpa.c | 7 ++++---
>>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>>> d76b22b2f7ae..846dd37f3549 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -806,9 +806,10 @@ static int vdpa_dev_net_mq_config_fill(struct
>>>>> vdpa_device *vdev,
>>>>>      u16 val_u16;
>>>>>
>>>>>      if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
>>>>> -           return 0;
>>>>> +           val_u16 = 1;
>>>>> +   else
>>>>> +           val_u16 = __virtio16_to_cpu(true, config-
>>>>>> max_virtqueue_pairs);
>>>>> -   val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
>>>>>      return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>>>>> val_u16);  }
>>>>>
>>>>> @@ -842,7 +843,7 @@ static int vdpa_dev_net_config_fill(struct
>>>>> vdpa_device *vdev, struct sk_buff *ms
>>>>>                            VDPA_ATTR_PAD))
>>>>>              return -EMSGSIZE;
>>>>>
>>>>> -   return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
>>>>> &config);
>>>>> +   return vdpa_dev_net_mq_config_fill(vdev, msg, features_device,
>>>>> +&config);
>>>>>    }
>>>>>
>>>>>    static int
>>>>> --
>>>>> 2.31.1
>>> _______________________________________________
>>> Virtualization mailing list
>>> Virtualization@lists.linux-foundation.org
>>> https://urldefense.com/v3/__https://lists.linuxfoundation.org/mailman/listinfo/virtualization__;!!ACWV5N9M2RV99hQ!NE42b1rl66ElGUzHr3b9xXGYCs2Vpb5dkhF0fPXnAyyFYzZZyzsY9NV_Qbf2AZCI3XxC13_nlWfSVN52yIM$
>> _______________________________________________
>> Virtualization mailing list
>> Virtualization@lists.linux-foundation.org
>> https://urldefense.com/v3/__https://lists.linuxfoundation.org/mailman/listinfo/virtualization__;!!ACWV5N9M2RV99hQ!NE42b1rl66ElGUzHr3b9xXGYCs2Vpb5dkhF0fPXnAyyFYzZZyzsY9NV_Qbf2AZCI3XxC13_nlWfSVN52yIM$
>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
