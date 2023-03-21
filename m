Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB19C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 04:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B074181E9F;
	Tue, 21 Mar 2023 04:49:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B074181E9F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=a/Q+9Iee;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Fq4tcC50
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pjM0RYBtRTPZ; Tue, 21 Mar 2023 04:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE5D281E31;
	Tue, 21 Mar 2023 04:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE5D281E31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF796C0071;
	Tue, 21 Mar 2023 04:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B85C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7606781E43
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7606781E43
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id osI1-0ELr4Uo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:49:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D04A81E31
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D04A81E31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:49:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4akv031298; Tue, 21 Mar 2023 04:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VSf/6NiY+igpF7J+DWjHCDdJ+O5nnGjKwSTWLnrJAuw=;
 b=a/Q+9IeeleBuHPNpu/wTdK859miSjxqLJMSAGQ4WniRwgCg6d6AfRiEEayuyIom2QEcO
 O3HKQvLJSfJaRgtOQ8q9lNiRa/AltFhKm9CU8k0Erx0Bh1LMxJSVhFuY73zvKOpsbspR
 qE0W4UUIxll2rATL55KEFLSXXB/lLbrnWgGxM4qXdPjYuOsc1d2sOu7x1evPMauDOdtL
 Dk1d7wNevpwILjGGozW9ZN1vv9+uqVOwqBEViFv8gfHNoVpEM+Jor16AyseRh3Czazil
 E1UfaweVrX54KFKtZZFI29og6HvheLh1joiBr4aGhZ+7Zoqu82JpnWS5Mza6NkaolYTU xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56aw3e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 04:49:25 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32L2Cp7a036895; Tue, 21 Mar 2023 04:49:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3peg5p7k7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 04:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c27T2DiVbGkniulJ7A28kx8jRVWviXgLGpZf3s2WSJl6W4erR5/vu3B9BM9X/QUHPALs7JVrsYvg1hdzo9kx6gvnk7BYadeeUB1arqleY3tUYhaM7XHTh6JYP58YOHr1C1K7qqLcPpVYTVtZwFVyENDMKNspvG8QRt6aVtnvSykYZCOYIELxnKGPqGzzntSbpZnkTK0Ie9psi4LAz3x2j36Xfsk41e0hfjheS1IpxPJWEDUh5p2tYqGi/1ys58IEzY3ge9pMglo4xHWu+YJSMt/L6jbCAaisHLpzT9N+6rIv8gVXFUoX6/qUMTyUMbZ1szK74UNs261jxAKbfEM7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSf/6NiY+igpF7J+DWjHCDdJ+O5nnGjKwSTWLnrJAuw=;
 b=mGMs9wWySeFNy1sFNhLEoXrjqY5oZeS8CKs+8Xp+XQhxbn4xbTD+vqyf2gYM1sHVdk0HpSh8dInt6m5DBiHb5WDhwEzNbUZm3UHUUxr1o2e+5VXBiONU9f9fl7wPtCu+UErg2GEKygsd2X4mcMHJAkJwAKAxn2SB+teZr7/Vp3GaY3hpqHqhieerE8qWxnWr6dc7tpNJspSW+9kgLe2+ISAuYD9yCA4KMiXxlPJfer0ncjI8ASJ2mu2C2IQ3BOeMIFw+p/jarKKC/pOQ2TPAkm7/zdGOezhMJ6KbJxXlyu6F0zfp5+7D4Vq6t1/DAmlEXhhJH23AWXiG096km27C9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSf/6NiY+igpF7J+DWjHCDdJ+O5nnGjKwSTWLnrJAuw=;
 b=Fq4tcC50N2HP9/70jq36A1SE2tnZ/KHaSDivsQtephggvFNG7GoTLutvGVuKDYckhWnPr7fMbo1Ruyuk4ySG5yYrN+HVmAJlYYcOuX5wZr/2eOESkn1iabg8B4ZQvqSEbf7+Ph+5XmlP4S3ppjlER/E69G98EJs9cg3JPpRGdvU=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 04:49:22 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 04:49:22 +0000
Message-ID: <798878cc-34ee-3082-39c0-5d44c943dbb5@oracle.com>
Date: Mon, 20 Mar 2023 21:49:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Extend driver support for new features
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, virtualization@lists.linux-foundation.org
References: <20230320114930.8457-1-elic@nvidia.com>
 <20230320114930.8457-2-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230320114930.8457-2-elic@nvidia.com>
X-ClientProxiedBy: SA1PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ceadc94-7f29-4eea-97c7-08db29c7a378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+Efavh1kL4TeRKcdPZ51LUvWgOmc+tCRsKenIUcLNIxA8JpiZ0dxWJbD7QekhthpwcM3hSiOS0IULZUz5g4h9QtgCFVHvfrAY8+65F+Ya9d8+LCeqmH8waVRz8ytzo0EDISWXtDx9tNucCj2rsqIah2fTgyO9cTtwcjuSNKyvxpmpROYhyBt1kbU2vkUasOq47OBKpfDOiwDlzForFeo3w66t8cFLM2p6m0r+BCohQIfZAP5U8z7ML6gPrl7PyXyT6QNvb+L5QqnT7C+zne4O0fuoeTNxibzB2X01UB7ucAAVBZSbPGFLmpM1uzQsG6gMOvRoNzSutcRqg+HICv6sh7pLKlEHysfjSAL4am09fsPgvUfYmrEGA5fvF99mlwP+zJp0iJElw/AdoIJb2lCzxFYek2+wyGVl0gbTTubNPbPczljQFpDzYOYPCP0BlNFyh4lDhkgripN6dHmCp24CIDQPknSSHKzpggZomdkAH7Po0X9H5cdjl5qOEd06Yo6f4cqRCXM/4vuwYrJXxKPXXSsylmnvYdMUByduKvT+DlexEgBc2ncK9zRqtAz7focB5qhL7sPkz1yY4UT/a9AJsCbtlz9Qg3SmiRUofvof1o9vkrtx/ZokBvGbHPYf7Lw+++bHX0E5Tt0RmxP+rmgZDQaMBtEa1xAfe9ApnBoqcWFIIE6Pl7IxALPmPr3pYei4mq7fbu66mnarasEi3kS+qh+qaQUoQ/ZFXnB9hmgT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(8936002)(5660300002)(41300700001)(86362001)(31696002)(36756003)(38100700002)(2906002)(4326008)(6486002)(478600001)(83380400001)(6666004)(36916002)(2616005)(186003)(6512007)(53546011)(6506007)(26005)(31686004)(66476007)(316002)(8676002)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1EwbVpXb2I1Tzc0VVJHa2FZMXJIdXdVcnIrY0lBRTRMQ2czTTF0a2swRVUx?=
 =?utf-8?B?dEIvUm40M1Q1K2lRWUxTeDNFY3NWNGJMajRNMGxJa3pvU0o3TWhCVlZ3ZmQv?=
 =?utf-8?B?TzNmcWZYZmZNNzhyZlVndjFGTTdjejdkaVhGaytPM2ZDbytMUHhieGxWMEti?=
 =?utf-8?B?ZUVxUEg1eUlSMWl3MUFvNXRMK001bVJqZ0sza2dES29UTVROUXpIRUNra0Mv?=
 =?utf-8?B?cnUycWNEZmhkWWZCbnd5RWYwakZzKzdRZllFV3crNHBRa3ExWThDMklocW5E?=
 =?utf-8?B?NzVra0U0alJ2eVhNdjJBRTdleG5jQTlDQStWM0RnSXRSYTA4elpnTURqOEY2?=
 =?utf-8?B?U1o4bzdSa3lSYnpGS3NKVmdHRXRuejRFWjUxbi9pdlRGQ3U3VjZYdkJIVjlW?=
 =?utf-8?B?ZldwVlRvbVBvM1o3L1RPK1BQU3QvckZ2NGpINGFZR29QV2REV1BBSmw1VTUv?=
 =?utf-8?B?ZEY2L1pPWWc2c1k0SVN0NlFGTlJXSWQvM3VvNUE4UTdYZC9nYmZYM1hEbzJE?=
 =?utf-8?B?WWgycHU5UzE0K1U4bjFhSE53aTNIMTZNeHdjMFVMTDFqVFpXYjViWDZVd3JO?=
 =?utf-8?B?ZzQyZjRIOWtuS3U2ZytmMmFweXNNS2Zrdjl1bWplaERRaDRrUDg5Q3F1RUlr?=
 =?utf-8?B?bWF4TmdCelErSXJKc0dGZlhnYUxQaGRXL0pZM21oL3pEZk9oZnNyc0JoeVBm?=
 =?utf-8?B?SDJaYytid3FXb2JsWXlGeU9STzV6amM1WWszMlZwUUlTVno0Y0FtWUpDZ0cr?=
 =?utf-8?B?UE5KSExUVXRVWFhNM2JvNWFFVUhhUUMrZjFrSXFwYkN2NGFGRHlHbkN4bEs0?=
 =?utf-8?B?dGpzZHljYWZlbzlscC9WdGl3dkF4TU9QeGh6OW9EMkpIdUJ3K0JHcWdpZ1hH?=
 =?utf-8?B?VVhaRXRhQy9YMi9vNEFRNHBUNmZmNWpndk0wK29pWTh6S2pkL2dpTWsvdnlI?=
 =?utf-8?B?QjVUaUVPVWJwVkNLUGxySmU4bnlZalVFa0N1UHRYbXovYWZPWG1CbEI5c2cx?=
 =?utf-8?B?bGZSa2pHeEk1NjFWUDFwRFBaOENsLzN3YnFKMmRKL3VDY1gxSjFTU3J3SzRN?=
 =?utf-8?B?bk9JdG5qMTZ6OXJoaFpqdklZUjBMTWRDdTJNd1cvdXRIWFdOV28vY0NZMG9T?=
 =?utf-8?B?RWRjbWNQOFYrZzBlaEJTL0JFd3pKQlUrc3VkRkVIMzY5ZnFyVnF3QkdpNVdl?=
 =?utf-8?B?QXBkTU42Q0EvR0FGcHlSUXFYV2pIT3podWdYeVVEdWxocGo2NHUzNkN0eExt?=
 =?utf-8?B?OXNuU2RKTW8rSmpQb1NKQjR0amJkTC9MOVdwU2Y3TituV2ZJa3dNcllWa0Zm?=
 =?utf-8?B?Z25sdDlWakhQVzNPWFo4cm5oNnBocXJZVFQ2aWpWdU5jNXo0dDBuMzhQRkRv?=
 =?utf-8?B?c21pakYxR09qOG5DSXFFMnJaM3EwWXRFTGxMVkZWcjVUTkI0QURKMkd0MHZJ?=
 =?utf-8?B?U2JnOGRIc09LSTlzNHRzZnYxbmd5QnZ3T0NvZWFJbWR5VHY0MGpMZzhMSHgw?=
 =?utf-8?B?TW4rclZLblFkSHJiSHlpYVVNNzNFM2dJTk9HQzdOMTl2eHAra3BoeFNkT2xu?=
 =?utf-8?B?VE5naUpyZlNMZnBxN1VUY1BtQjVqUU9MdEkwS2J0VTcwblpTdEs2dGkwYlZv?=
 =?utf-8?B?WTlmVlhSMXhBeDgzK1V3OVNwZXdzVmxZYUIzMFUva2hpTmJuSE9nREpUOGNj?=
 =?utf-8?B?elhzSEdvdG1IRm9sT21tZklLNXhKc2ZzSktoRnNOSkhKWjRkVVhiaHVNYXBn?=
 =?utf-8?B?TUJIR0tNYVQ4aEh4S3N3WURId3BYcnV1VkgraWlYM2N1VXo4Y2ZjZ3pRYkh4?=
 =?utf-8?B?TnBQZXlSOEVSOU5EVkhkRnFYZEhnSmI3STNuYTdHZGdWUnRUMzlmTk5jNnhN?=
 =?utf-8?B?SkhiekRNSDQvU0FlQUsvZ0FrYVY1dm1raGtZMVR0ZUt3U0c4SkxaOHRrcmJp?=
 =?utf-8?B?T252WWFJSUc4dVQyWng4ZXhLY2lCRXE0cDEveElITE5rcnRPcVVUcWlqY1Bh?=
 =?utf-8?B?RGxESjZVSmpYelUvZUhVUHZSTllhWm1nUjBsc3YwQlVRS05lZG56WEl2M256?=
 =?utf-8?B?bUM1YlVDQ3JmS3dlcHhKeXplTFpXZWFCY1NkUUo5L3lJcUtYNlNqWXh5b2Fu?=
 =?utf-8?Q?sUpz+V+AWF2NVF7MCdqDJ+iFJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wFQGQ+ofOKhMsjEww6lsLq9g8SzPJM2UvlE0gkKgVqPXbZYYSpi+nKEeBn2qRVsY+dEtIAeFf+7tH5KgsZmL6NqO1UmHBBiBER5PkfNYukQYcpWwHPahrVoioa1KjyZ93XneqosgIeqvO7N4ebwxy4gTinpw0JVnq1JlY3nsgi26mcQSmAsykNnXVEQoodsI2bvXnMQQje8zinh5jKRwi05laC5HzirnmbxRG73hLySOXJAJaO1tmmAozl48WUUV0J2ce+p6wqa2Zl93w//JGVkfuEoulrplgyOjH/2VnmaPQyQybj5fqDmOoE9yxSHexOEd4zD+SJsZZxCEX99oGoCWMgbN/Tbo6rhXVLnQFqyFFwaHFrWAhqEyrLGziw0fYcJWiIptml+OirChDn9HUy6WqX/zQBx+8x8T/zq0xnEC1i0VZE3YIR0KM/ZU7tJtlcJgnl6Y0g+ZnTGv0ajmhNJuRmbMtienW8xiqo5L3pYuAljWmbuCS+QafbyGDzT7qD0sb+aonJ8QfuypX/w7vU/uc+Kv4eo4d2xC8O3Tz/2Rd+/uFNZi4C5U8KZw8VmJN+chJwPlFXhsxLovx81SB37qrcylnn6VJHVFsFYy9lmvWFhMRKm/F0jM8hOxqwnqQitG04xJ+8j9S1i+sVN5vNxJfvaTymObHUTYigcjbacv6S2hKltSUlYeKVMrOWg2FEW+PXH9IQl+FlZgL+c1UKYZyAh6d3oObriB3jj3vuF4TY9KiY8RX1iQbCEywQsq118l8uAwm3zwR9YzFtW6CJPx+Jn8dfY0hKQngiVnX6Da1ZP7i+DV4QztSv8uIGAnv4GNLL76PXUbv89qsOM1Yedb5d6QL+6kz38UteOHGjFSaVdikC9LWuOFcWkVqdMY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceadc94-7f29-4eea-97c7-08db29c7a378
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:49:22.2763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8to6ckAyyw7srRaJaeBr1pY+UVBZQmqnfXbPkRBBSly5/tk/y45V9lyLMQJ2QOLyfoe+dHraLV7xgwp/wudpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_02,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210038
X-Proofpoint-ORIG-GUID: HuKubKEB81oQhO159e03rL-3VaoH8ROO
X-Proofpoint-GUID: HuKubKEB81oQhO159e03rL-3VaoH8ROO
Cc: parav@mellanox.com
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



On 3/20/2023 4:49 AM, Eli Cohen wrote:
> Extend the possible list for features that can be supported by firmware.
> Note that different versions of firmware may or may not support these
> features. The driver is made aware of them by querying the firmware.
>
> While doing this, improve the code so we use enum names instead of hard
> coded numerical values.
>
> The new features supported by the driver are the following:
>
> VIRTIO_NET_F_MRG_RXBUF
> VIRTIO_NET_F_HOST_ECN
> VIRTIO_NET_F_GUEST_ECN
> VIRTIO_NET_F_GUEST_TSO6
> VIRTIO_NET_F_GUEST_TSO4
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 56 ++++++++++++++++++++++---------
>   1 file changed, 40 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 520646ae7fa0..5285dd76c793 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -778,12 +778,28 @@ static bool vq_is_tx(u16 idx)
>   	return idx % 2;
>   }
>   
> -static u16 get_features_12_3(u64 features)
> +enum {
> +	MLX5_VIRTIO_NET_F_MRG_RXBUF = 2,
> +	MLX5_VIRTIO_NET_F_HOST_ECN = 4,
> +	MLX5_VIRTIO_NET_F_GUEST_ECN = 6,
> +	MLX5_VIRTIO_NET_F_GUEST_TSO6 = 7,
> +	MLX5_VIRTIO_NET_F_GUEST_TSO4 = 8,
> +	MLX5_VIRTIO_NET_F_GUEST_CSUM = 9,
> +	MLX5_VIRTIO_NET_F_CSUM = 10,
> +	MLX5_VIRTIO_NET_F_HOST_TSO6 = 11,
> +	MLX5_VIRTIO_NET_F_HOST_TSO4 = 12,
> +};
> +
> +static u16 get_features(u64 features)
>   {
> -	return (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO4)) << 9) |
> -	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO6)) << 8) |
> -	       (!!(features & BIT_ULL(VIRTIO_NET_F_CSUM)) << 7) |
> -	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_CSUM)) << 6);
> +	return (!!(features & BIT_ULL(VIRTIO_NET_F_MRG_RXBUF)) << MLX5_VIRTIO_NET_F_MRG_RXBUF) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_ECN)) << MLX5_VIRTIO_NET_F_HOST_ECN) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_ECN)) << MLX5_VIRTIO_NET_F_GUEST_ECN) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_TSO6)) << MLX5_VIRTIO_NET_F_GUEST_TSO6) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_GUEST_TSO4)) << MLX5_VIRTIO_NET_F_GUEST_TSO4) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_CSUM)) << MLX5_VIRTIO_NET_F_CSUM) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO6)) << MLX5_VIRTIO_NET_F_HOST_TSO6) |
> +	       (!!(features & BIT_ULL(VIRTIO_NET_F_HOST_TSO4)) << MLX5_VIRTIO_NET_F_HOST_TSO4);
>   }
>   
>   static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
> @@ -797,6 +813,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
>   	u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] = {};
>   	void *obj_context;
> +	u16 mlx_features;
>   	void *cmd_hdr;
>   	void *vq_ctx;
>   	void *in;
> @@ -812,6 +829,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   		goto err_alloc;
>   	}
>   
> +	mlx_features = get_features(ndev->mvdev.actual_features);
>   	cmd_hdr = MLX5_ADDR_OF(create_virtio_net_q_in, in, general_obj_in_cmd_hdr);
>   
>   	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
> @@ -822,7 +840,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mvq->avail_idx);
>   	MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->used_idx);
>   	MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_12_3,
> -		 get_features_12_3(ndev->mvdev.actual_features));
> +		 mlx_features >> 3);
> +	MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_2_0,
> +		 mlx_features & 7);
>   	vq_ctx = MLX5_ADDR_OF(virtio_net_q_object, obj_context, virtio_q_context);
>   	MLX5_SET(virtio_q, vq_ctx, virtio_q_type, get_queue_type(ndev));
>   
> @@ -2171,23 +2191,27 @@ static u32 mlx5_vdpa_get_vq_group(struct vdpa_device *vdev, u16 idx)
>   	return MLX5_VDPA_DATAVQ_GROUP;
>   }
>   
> -enum { MLX5_VIRTIO_NET_F_GUEST_CSUM = 1 << 9,
> -	MLX5_VIRTIO_NET_F_CSUM = 1 << 10,
> -	MLX5_VIRTIO_NET_F_HOST_TSO6 = 1 << 11,
> -	MLX5_VIRTIO_NET_F_HOST_TSO4 = 1 << 12,
> -};
> -
>   static u64 mlx_to_vritio_features(u16 dev_features)
>   {
>   	u64 result = 0;
>   
> -	if (dev_features & MLX5_VIRTIO_NET_F_GUEST_CSUM)
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_MRG_RXBUF))
> +		result += BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_HOST_ECN))
> +		result += BIT_ULL(VIRTIO_NET_F_HOST_ECN);
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_GUEST_ECN))
> +		result += BIT_ULL(VIRTIO_NET_F_GUEST_ECN);
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_GUEST_TSO6))
> +		result += BIT_ULL(VIRTIO_NET_F_GUEST_TSO6);
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_GUEST_TSO4))
> +		result += BIT_ULL(VIRTIO_NET_F_GUEST_TSO4);
It would be more consistent to use OR rather than ADD.

With that,

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_GUEST_CSUM))
>   		result |= BIT_ULL(VIRTIO_NET_F_GUEST_CSUM);
> -	if (dev_features & MLX5_VIRTIO_NET_F_CSUM)
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_CSUM))
>   		result |= BIT_ULL(VIRTIO_NET_F_CSUM);
> -	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO6)
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_HOST_TSO6))
>   		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO6);
> -	if (dev_features & MLX5_VIRTIO_NET_F_HOST_TSO4)
> +	if (dev_features & BIT_ULL(MLX5_VIRTIO_NET_F_HOST_TSO4))
>   		result |= BIT_ULL(VIRTIO_NET_F_HOST_TSO4);
>   
>   	return result;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
