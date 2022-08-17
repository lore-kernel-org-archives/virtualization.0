Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D660AC25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 18:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C5F84022C;
	Wed, 17 Aug 2022 18:51:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C5F84022C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=aOQnXC2v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=p7pSy9T8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nggKfcQ2Ru8q; Wed, 17 Aug 2022 18:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4315400CC;
	Wed, 17 Aug 2022 18:51:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4315400CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9799EC0032;
	Wed, 17 Aug 2022 18:51:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D129C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AA0540335
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AA0540335
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=aOQnXC2v; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=p7pSy9T8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53goFjQ1BYdi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:51:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F3FA40325
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F3FA40325
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 18:51:25 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HHJ46c018167;
 Wed, 17 Aug 2022 18:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=YQtDmU2pBE78McPCsB9isZK9WQePRPyriO+TDv5Yzts=;
 b=aOQnXC2vtghBv5CytMzdj7amK4LrhjaHXKeReQ4A7oAd27h89zCs1Mn/1MW1joejvXy7
 OPJYQ/lPSklLWXe3b6C+fI13MqHdQr3fed4E1Avb5QwCNHLc4peiMYqUlMuIiNdTkDiL
 iacgf//9ngyEA4Ny8+6FphZgKrSntn04Or9cRyGMPLHR1gVen7I+MpMJsIkkDc3fLerk
 KclbDJubipGbuUBrtUHC+Ae4oSMwlIZjQj1+Gn5VDR0fY6dX7BaPu0RSgxjYv4Og3+ci
 ibGC8Xzn90FKVtMALUtcDfw/hshxnnQDolkYawaBI/9vZXP36AgLMsF+mraXyfGe5ADN Mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j0nt92c95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Aug 2022 18:51:07 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27HHfVob025572; Wed, 17 Aug 2022 18:51:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d3s3xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Aug 2022 18:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joxVXxPeXazVsTeV8loDIti+7aM7tX3Pyo3E0B44zJVPlN1I31Mk9lYHL/Hk/P712yJNn1lyuXRt22ylVIDxGVKXiYiFWwN40MBHP1grC4GUD9YY85xo4WKId2eLgRmhjHYml+z0Op/LlDxFXYHnnuGDtfKNb+qTSP5MeI4XofPs8nWRMZUziT6+ewJ1aSTZCU7qd00iGGrfOQYZfWwSKPcmlFx3WO3vXcQZQfUWh4SC2s9EjLu5Yb22r9QvSUvJLCvnsgeOpgDkNAPjgMHYcA2CQ7IjifbneQpeqy7OnSPipYbmJrSoxDwdeAjfgu55invUKFViSGOs+4wQhTfbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQtDmU2pBE78McPCsB9isZK9WQePRPyriO+TDv5Yzts=;
 b=JJLAewjIa7/vgpI3atXIIdOHr46c2CqiLWWBLID/kR79GZ5sps5rPrE4iTSsbjuIfQtE8R8F6K1wWxC921kbCWUd11wHE1s0q86QJoMwIwefdBLv0hnAk4nBpen3QYMA/BtajTcLN9Ci9+D5P8yz01d7PB+2CzgmJwEKGAhtijuWhOkgGq55RJU3BxnP1d+TNvSHF46yPAM1JJHG86tooIL7HPR+wHAv+Uc7Adx4h6n6K/kn/bIAPys3MPMhqVnc2U6UgZlbo2ST3gtxKvYsmMU8asODgPzc8qOVjWOXGNNl4IiFphN2W8tOJgePikdjTNb/oEi7Uj+s2FSKA8andA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQtDmU2pBE78McPCsB9isZK9WQePRPyriO+TDv5Yzts=;
 b=p7pSy9T8NMjsh4Uhz+Bhsdql5Dez5/dytTSQuQsYAbBmkakuMjFsztdd/OoM0OFLzZuGOeoJwjZ9La1ffHxQMo1Fvjh33OIxk9Y3f1Za40ACH8g5u1U+opgtVQPSzKlfaJDAOB3MUCitMkY/zgjsLuPeljL+dotiZKCZ/nBp0nk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 18:51:02 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 18:51:02 +0000
Message-ID: <6fb0d3cd-cba5-986a-fd18-5419e8441a6f@oracle.com>
Date: Wed, 17 Aug 2022 11:50:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
 mst@redhat.com
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
X-ClientProxiedBy: SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::27) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051e61f1-1c2a-4786-ebe0-08da80816eae
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40VHyN/dasFCbDM5C7IlaVhNqRZ8KmBnt1yOwt7at/WDOGbruJ2dW/ZLUb73qjcSJ4wXkQn8fj/wHufAzZZmTDcwrEcFFRu1H3Ad/+foalo5LcJ9kS+iTmFFZ67Jf8MBxdgK+siT2a6cke6Z5An8jGvzNaGW/3FFY4dHQKzZyRlrnWqZQ5FMbstCAAGPjZDi3sfkyqyZ34NAUsxwLAjs7EqxOua3wFXPA7n11RBByBidt/WCnUA7xUyKr1A4ftWpYGB4XH59voynU9P4q5dXr/WAeQugVb/CWDPCw/H3HF+yu5doHLv6uEDz4hChb9/XyQniQKBX0uZzYfiu3jvRb9uNtrxgJ7xI5SSZytTFsNhmwXzMLtQhJzu110Myh0AeWHeqMBhEgK2ecUmzEPWnSdMoSZP1EfkScYdk1p+f5zuwzH9zgLedr7Q++0pPAo2EwD+RJ/rJp2Ot1RYSgDKq6mLTFCcYyBoKoj9aWbmH3mRifkRgOzyKO4AFO/2fMOGv8sJPDiwicvGYXAtap6HN2MyxuD0rJlTnSMiOii/UKWz7JYauB/r7Oz0nBf2SdewIIMbMpa749265O1WDSP7tB2ihhRpXpTGpWda5wXVHFT9TeGEfzEb34E+h0pvg/Spvh50p0fCRwlL7yXHlWlkAuauazet7A8YNHrH7maqxQXj5rTmMJEMmdGtzT3hgxlFUeT+U3ufwHZ8VV+tKbcl7VFs9joux6/eH64jbI1U60OQ+Ba0A7mWsBBJD/a3Y/4DhrJDbexD/DhcZUBbDhfkcD8Av3M6bJap573Vg6oxR47g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(136003)(39860400002)(366004)(396003)(376002)(6512007)(36916002)(33964004)(6506007)(86362001)(26005)(2616005)(31696002)(38100700002)(53546011)(186003)(83380400001)(5660300002)(478600001)(36756003)(66946007)(6486002)(8936002)(8676002)(4326008)(66476007)(66556008)(31686004)(2906002)(41300700001)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnM0ancyTDFBYWZHQzZlamU0bXRiUmNzVTdBVThpbk9FQzE2NXBjTnExNUdi?=
 =?utf-8?B?VUlhRldXVDNmTjhoTGcvNEt0RVllNWdyOGEyTXpUZXJiY00xbTFEWFlaOU02?=
 =?utf-8?B?a3A2aUtLNWwyYm41NkhidVgyblErRzlsbkVUcHg1NVFuTnY4eWFsbDUwUkZz?=
 =?utf-8?B?cmpzTHBYenN1NlRUbGVaRGJIb2tCeFh5cy9US3Q0RWY4MHNiYlptZk1ZbUZ5?=
 =?utf-8?B?ZHlvaEtQMzJHUjJ4UjJGYzNsUjdMM29YV0FlclNCMFhPd01MdkMweE5qdkE4?=
 =?utf-8?B?TjBuUWp4RnhSYUhydHlKZUFQNTRJc0hpQmdTQWhoVG9RQ2x2SWtxbHNOY1RQ?=
 =?utf-8?B?cUlDLzhhemJJYjRwNGg0QnZRVzV2WkRURFhORFZmMHFLM0wvSFowZExOYTFo?=
 =?utf-8?B?T0k0MHZ2MEdlVURKQU8wWm5Cd2t0c1FhT2txTkk5NzA0cWF3dk14YVNVK3dF?=
 =?utf-8?B?L3ZLaTA3OHRoN3MwQ2hnWXhFaUJEYUplY3BoZ29MWkRoSGxITm5KS2FrNng2?=
 =?utf-8?B?R0Y2QXhhR1JjOElabEJDS0JNMzRMcjVvQjhiUytsc2pwTGJTQjZWa05Edy9U?=
 =?utf-8?B?UjRIbjNENXhici9zOUx4YVRnOW1XWllEUy9Pd2hLbzA3MDU3VDlVakx1Q0Qv?=
 =?utf-8?B?ZFNiYStBSjJnRnpsRGhad1ErVE04Q0xXN2Q5aG1oOVlNaUs2NDYyNmF4NUpC?=
 =?utf-8?B?Szk4elIwbUJVNDJ5bXNiZGJYdFVjZ0VCNExTMzNzUjRkWlpHMzNNTno3S1U3?=
 =?utf-8?B?NytoajRhOHVRTmg2aWI4MlpQa010L1BLOEwwYUM3NUtTT0xxMVV2SjFDeWh4?=
 =?utf-8?B?YUt6R3VJVVFjd3VZUGpmc3ZOUjFRSjFLRUUzQnZmSUNVMGlaTksvRm9tU09i?=
 =?utf-8?B?elBkeUNCVkFJdmpMMEJCUEdpSlo0M1QvakllS1Y4WFlOdjVKTVIweGlJbGlK?=
 =?utf-8?B?OTJzWGlqWHl3NzJsanh5UW9JOHB3MnFCSkhRbEVBTTViRlA1V3I3QXdUTGw0?=
 =?utf-8?B?aHh6eFBOMmFkZWc0Nkl1cHV6ZHhHOFZGY0xNN1Y1K1ZZUGYyZjFqZFZSQ20v?=
 =?utf-8?B?USs3YTl4Ym92aHVacERTeXNmV0VDcHBiMmJvSTd3TXZuSGQvRVYxdVNBY3NH?=
 =?utf-8?B?Wk56SXJiL29qQllLWGJxVmthRXBjTnpCdHRUNmlrR3Q2SFkwcFNrWGhtcElB?=
 =?utf-8?B?bE5oNElrdkl6U0FIRFk2c2VhVXRGS0tPdzFST2dxbmZ1U3dFV3R1WVVOSGE0?=
 =?utf-8?B?VHV2RWFvM1FFWTVXQXRmY2FnTUZ0N0Y0SzZIdnJPaXpiTzZHTHJhSDRKaWZx?=
 =?utf-8?B?UVpRR3A0SFhwR0ZPdllxOCtScG1IZE5XOVRxbnl2anZ0T1BVTXJpaFRoT0Nu?=
 =?utf-8?B?aG5QdmhvZm4xQ0hWOThxZ1A0OXBJbkljdEFnYk53OEVxaGYxdjg4MXAyeFlC?=
 =?utf-8?B?YWNtSkpxcXpWaUY1ZlhCOUdWN3VIMjJGT0lOQnhCdzNnSXZLODlPVGxTTjM3?=
 =?utf-8?B?YVlXcmUwUm9CRFh4VDdvRFRvd0xsY29BVVlGbllkbGtWTExVeUIxdm5DbzF2?=
 =?utf-8?B?dFRwT3ZZM01Fblp1bmNUY3F5Y3NwQThXSDdtSlBITmF5aCsyZkZTTnNRQU9m?=
 =?utf-8?B?TjhJKzJQUVkrc0pzRlVuTzNMVjFzcWZyZzY2VG5aYVNVUXZiWmtBSXBzU2xQ?=
 =?utf-8?B?Uzk4bHhiVlhKMGVjZGdkTkNEVm9HRmE5cDJVblVqMEhob1ZJbHUyQml2aG1y?=
 =?utf-8?B?OWlLNk96UmFndEVJeDIrNTdwazgwM1ZrMUUya1BBc0hGcjMvRFZVUXF3cCtp?=
 =?utf-8?B?YTRnZXZPT0ZaSEZFVnk1VTd1c1lBZEhmcllSMzJBcjlqK2pQWXV5YTQ4YWU0?=
 =?utf-8?B?ZFZKSDE1amJLekhsbDVmOEhjODlwS011cnFmRWhrelRHZnNJMjBNT01DZDdn?=
 =?utf-8?B?VDNyWXBaYnk4VytZWDFpUitxdldCLzJIcUhjTTAxb2dmdWxlK1ppbmVlYlRz?=
 =?utf-8?B?MGF3MzhaalNmQnpBMXNidkNNemJnNzJldUVXNUJ1aHNIc25mZko3ZHNuZXZG?=
 =?utf-8?B?amxKQlNCZG1sQXhSSG5SZXlQUGFhb091N0JKbUNWeUY3OThkYkExWnJTcWZl?=
 =?utf-8?Q?8OLdfZ0nl/VUL/XXywsO8D3Gh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RUtZVm5yK1V4Y3JBZktqWXBlUk1KTjhvRSt0Yk5pMTI5VkV6Z0J4aW9oeDRF?=
 =?utf-8?B?b3lUdDRERysxUnhiVzBoRDNvMk5zL05XOVUwMmFXYXdTZTJSYXRUdHJ6aGNi?=
 =?utf-8?B?UDI2UDBVeUc0RDZPNGw3RmRYVFpZajZvTjU0ODRqRDV3WG83dkt3MjdHLzhO?=
 =?utf-8?B?c25veTRhUmxOdGxKYnBHMnNiVGZ4U0tMbXY4U2x2azZXMUtiek5OM2U1eUtL?=
 =?utf-8?B?MlFWUlRVZWtwT3E5QnhvcWFoRjE2YXFXMlVyZ0toQUhReWMzdGtzVkh2clZt?=
 =?utf-8?B?eGp5cytTaGM4NkRhMFk3MW1QTFVnTytLWkc0Z1dtalh4djZZaVZvRVM2N1hT?=
 =?utf-8?B?NkwvWnlqcFdZTWdHZ2tDNGw1MjBZcUdSaFpvQkNNb3pqdzlLY0NGMVRHa0xp?=
 =?utf-8?B?VkFxTVh2cndvUm5Kb3dBa085ZDYzL2ZEVjkrSm1kMG1BSEFBbGhna1Zwbnk4?=
 =?utf-8?B?dDN3d2ljM3NiKzg5aXZVQzR6eno1QXN1K3RudURzYkZxL3AwOGkwNVVRZUdj?=
 =?utf-8?B?NGJaTnFZQmlGLzR5TnZVbVgxc3UzOGpwT2hOMDlHYnlaaENJSUIxUCs1bzZJ?=
 =?utf-8?B?bFdqbEk1OXdadEpoRklINGdaKzVacnJiOTFxWGdLS1JsckhXOVVBdUx6emxE?=
 =?utf-8?B?b2NtOWVTbXgzYnQzR2lPMkthZ1pvQVBlYjZ5NDQySFBoU1dHdVc5U3hoVUtU?=
 =?utf-8?B?MkRPQlhvdk81VDY4VzA0azh2UkRsZVNjd0VURTBad0pHSWx0N3J0ZnVwOFAr?=
 =?utf-8?B?TzVSWWs5REZydk84eXc3Rkp5SFhxSEs1Rk9RTXNWWUNxcHkreE9vSjhDODJN?=
 =?utf-8?B?L0VRbUVWWU52K2U4dGtuUnJDSlEvL1hqV01oUWdlUjEvSVR3c3FwUzhvdk14?=
 =?utf-8?B?aEhlZTRpL3VpT2NTaGhTeE9zVnhHaUpCeVpVWW9Fc0RaYkd6UTA5Z01sd0pC?=
 =?utf-8?B?OFVhOTZkbzN3N1YwNnVRdFBpb3MwNlpaUEdTSjN2WmZJYmhJUHRHYktmVnpT?=
 =?utf-8?B?RGRDR0JjNTY0TXJhRmZjdGJ0RjNkbzBndTE0ZUFjY3A3SXdCdEY1NkNrdDA1?=
 =?utf-8?B?UStvZTV2a2RFN2ZsWkZ4SHZKb3FiU1p3Z2srUUhUQ203T2RES0N5ZXlKb25a?=
 =?utf-8?B?WWdsQlNDYnJNazcvOHRFSlFtWWtzWlg0eHRtaUU4SEMwWXF6VE1RNXVwNHc4?=
 =?utf-8?B?Q1Z5MUVJVEhEWFJ5M2VDenhnbWRSZEpsZFkzclppaVJ6NGwyY2pHdFV1SnVm?=
 =?utf-8?B?a3ljck9jUHgxRGU0UEVtMUltdFU1L0RCUGJTNDBYY3orN3liTTJ1YmxjOHVs?=
 =?utf-8?B?MG8vZDlzOGdNYThRZm00NFo2N0hUR2JRQzFxam41L2tUZTBKVEV2dWtPZm1R?=
 =?utf-8?B?aGpUQnFMOUNZTWVMcXJjcVFxbW9VUGc5SjFwZnFhaWNFbUJ3d1hiRk53WCtV?=
 =?utf-8?B?RzRQenpZK001WGZoK3R5SW51VUo4NEJFYlovUWRENGtvZDRxTWw3RE5QaHJS?=
 =?utf-8?B?cXN1YiswSWxBTmVnOFhnc3FjYUVhaXQ4bnZDRTJGZTduLzcraVpYSkFYbXlN?=
 =?utf-8?Q?4Md/i4oQr0iJcqgNizyEO1sJ7X1B3oIEB+nV8fIn4IHnK1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051e61f1-1c2a-4786-ebe0-08da80816eae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 18:51:02.4315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViZXpoQxOh4nlyi3Cjf+O/Llb+wlu+Yn2hR+pVcDRmhH7EGuoYtHvupCRpsIEzjW7MM1oLvoj6QkbGMlPxZeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170071
X-Proofpoint-GUID: P3S6qjGOstN5cnYX1BvnIek2u16DOfxb
X-Proofpoint-ORIG-GUID: P3S6qjGOstN5cnYX1BvnIek2u16DOfxb
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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
Content-Type: multipart/mixed; boundary="===============4051604302332315175=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4051604302332315175==
Content-Type: multipart/alternative;
 boundary="------------ALcdGzga6vuMirpMUI5Njc5I"
Content-Language: en-US

--------------ALcdGzga6vuMirpMUI5Njc5I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/2022 7:14 PM, Zhu, Lingshan wrote:
>>>
>> While the fix is fine, the comment is misleading in giving readers 
>> false hope. This is in vdpa_dev_net_config_fill() the vdpa tool query 
>> path, instead of calls from the VMM dealing with vhost/virtio 
>> plumbing specifics. I think what's missing today in vdpa core is the 
>> detection of guest type (legacy, transitional, or modern) regarding 
>> endianness through F_VERSION_1 and legacy interface access, the 
>> latter of which would need some assistance from VMM for sure. 
>> However, the presence of information via the vdpa tool query is 
>> totally orthogonal. I don't get a good reason for why it has to 
>> couple with endianness. How vdpa tool users space is supposed to 
>> tweak it? I don't get it...
> Yes it is a little messy, and we can not check _F_VERSION_1 because of 
> transitional devices, so maybe this is the best we can do for now
Can we conclude we can drop the misleading comment?

Thanks,
-Siwei
--------------ALcdGzga6vuMirpMUI5Njc5I
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 8/16/2022 7:14 PM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com">
      <blockquote type="cite" style="color: #007cff;">
        <blockquote type="cite" style="color: #007cff;"><br>
        </blockquote>
        While the fix is fine, the comment is misleading in giving
        readers false hope. This is in vdpa_dev_net_config_fill() the
        vdpa tool query path, instead of calls from the VMM dealing with
        vhost/virtio plumbing specifics. I think what's missing today in
        vdpa core is the detection of guest type (legacy, transitional,
        or modern) regarding endianness through F_VERSION_1 and legacy
        interface access, the latter of which would need some assistance
        from VMM for sure. However, the presence of information via the
        vdpa tool query is totally orthogonal. I don't get a good reason
        for why it has to couple with endianness. How vdpa tool users
        space is supposed to tweak it? I don't get it...
        <br>
      </blockquote>
      Yes it is a little messy, and we can not check _F_VERSION_1
      because of transitional devices, so maybe this is the best we can
      do for now
      <br>
    </blockquote>
    Can we conclude we can drop the misleading comment?<br>
    <br>
    Thanks,<br>
    -Siwei<br>
  </body>
</html>

--------------ALcdGzga6vuMirpMUI5Njc5I--

--===============4051604302332315175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4051604302332315175==--
