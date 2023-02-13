Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C69C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 06:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 874A760EB8;
	Mon, 13 Feb 2023 06:50:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 874A760EB8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=kzc/l32K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ZnU30ges
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVPu5UffX9JP; Mon, 13 Feb 2023 06:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C057B60E02;
	Mon, 13 Feb 2023 06:50:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C057B60E02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 924C4C0033;
	Mon, 13 Feb 2023 06:50:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7AFCC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DBC340E47
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DBC340E47
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=kzc/l32K; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ZnU30ges
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hhVDuSTvMcMs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC4AE40338
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC4AE40338
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 06:50:52 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31D1iJGC026033; Mon, 13 Feb 2023 06:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k7CEHN+MdKpCGd/V9BSbt93UHPN1YRDHyAnXO/weJSQ=;
 b=kzc/l32Kz+HjJBPy3e9QS5kBSIQdB1UKZD5l2hiUcLpy0vjcpkytr5lXlZCnvv0hqg2/
 jwDXqeqBFJzROFQ4WfS1qqUlxHLl+OIoi7gXnd4Bqj8IpPdHEO6XC/U1kwC8DOqFYsUg
 bBABo8jHVOvWh34/63piNp/iCTDJkgJ2Pxai/MtuAzd+EAqcnkJwIyfNsoD0azv2dv8k
 3NzvvzzGvsGxd5L0goNxnbOL+7VuxpHyTf6BMio2HvXH3RV1h5TM0CjT9DhwhkMkwm4C
 p8gbFYWcG5cmqCzKqBLY7wSvSisWOkUlLxo6TR3eHTTR7zltSi5C8iAZ/bgcqM/qiv74 OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0t46y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 06:50:39 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31D6IPFK032783; Mon, 13 Feb 2023 06:50:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3np1f3q0md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Feb 2023 06:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e92k2RBkoG87VjKIDv73CkEJnx99iAbIeTZYeDBxUWfry+jCinasoWhBSi8ccxngmLLUiIjskp0ntkXwwYbUjZxnCLXBsaRAcBSWxyZdP8Ge081npC7yg3McOoLC6DZc2yHTmNFC2gpJAlQON2OKWN18x06BRSVtrzUPwAIjuivygWKayfx/g7kqx0x2oexq0hY5VCPTCapd6lp+LFbBv2xMgShHOmjdBdbzELgQM8RA/xT29l6fC2c25+AP+6du68xpygqsCsd4PYBcZiq4at78q3wQ0EQMzituvW3Q1msP4cwjOAddSSiayDW1eYmYPSGaMXgym0XN/ErC1iA4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7CEHN+MdKpCGd/V9BSbt93UHPN1YRDHyAnXO/weJSQ=;
 b=P0tb1bZqxgUug12839zCu863OEJxH4npthH9Mogg+kjknAMbQD7OBu/xNFrs72vAgi2O/ctRgGrFv34iApcGa5d9gy3YzlCn/4EArm9e+ZxekORFQp9pYP7up0FeE2mov3MAX9uiiSjzD43lQsaCjA59PSuE40Q62Kz9QbCiYx0q2vcJMU6PLDbs8ZKmzMVSvJfgDcFb7aHd1sJzspY3oYa4csMXCMg6Zd+V9jYHVVPdHpR03YIQHYIvoS8C9GiJS+kXYJ1Iw4OTrLoZNXhhTbk7y3WsZu8tb2cpJ1WIxL+R29pgdo0unNf8IdSVwoZWmDGugqaFHDwlO9sBozW08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7CEHN+MdKpCGd/V9BSbt93UHPN1YRDHyAnXO/weJSQ=;
 b=ZnU30ges56E4J4hSDwSV1cujGRjNqK75Sqt01FFr02OOhSS19EesMlZC4ZsLlFa9JAgRatQmszhFVk97fbTsH4SugO0NNZDtpbz3ZX4UZLDYEaVDxW6jIvcgD9lyt4kngpjNuBKHknXa0raGkqgQ9IYGjKOXuaJDlrwop7HiM20=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4272.namprd10.prod.outlook.com (2603:10b6:208:1dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 06:50:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 06:50:35 +0000
Message-ID: <a71b4dfc-67ea-ef8b-023b-8e18638bd8b2@oracle.com>
Date: Sun, 12 Feb 2023 22:50:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 01/13] vdpa net: move iova tree creation from init to
 start
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-2-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230208094253.702672-2-eperezma@redhat.com>
X-ClientProxiedBy: DM6PR07CA0111.namprd07.prod.outlook.com
 (2603:10b6:5:330::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: e6039284-4c75-4656-11be-08db0d8e9bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PI6cskVVsMtGkrS4BfpRVo2RHEcRgWX7WOfiLU0BSxWdpKJe3piGc2tKr0dkiqUhEjL5NArTwOgF/WPKLkBr1kMlpZfEaHpPor99pHQvbnX1d+C/NehXg73DwH38/eeQyOQcQ6BsN8vs2xQxxjUTNoSqKoFtvdlI/nTvOQ0USb0rG4mz2TEhWx2DZ4Rm19vYas/b0fWQIB+J6JI/9Y7fFH5ezY9Y/7NqomOqUY3qNZ2UA9yQpq1ZGtzV0RghtYNTdroUEf+fPEJyY64H8nC6wD+IY7gVHmUkWajGs4agWJ2pxcN5VaYzJqeM6pdc6qONWGsCyuIAQkmevnqKD5z9ud4L8oPFcvgVsPvpi6ypfa+FJ+4HfffNqXKvnr+Y+6Z24xcHW1oUVO5xhHO2KK+osA8SsnrmW8CtR7/sck9WO2xLfR4JETKSIcFEjtudKBYeDmmx7El6mMh2AGhUYsfSF4UNJTbsxyWSM6U35ktdqAttthI6u+amfn0WyRmbtW0FDkugVV4ISouug4D8br4RoHUBCer0/LTR+K+AOki04zwISRqhoGEbRNNqf/tuEGV/YvAJyGJVDLv4bir2JJI3RxMq4w0Xg7mlEoaYD9t5Q/1hE5qw/pX27WiWKp98L0Be4OqheCd+RDTJKhRZ/wRypc3nQDtHA1QD7KpsxnGmZUuI5ZWszk0FQqrF6CMYGkicGlOuwDBVpSv8cClHonvo7KLJb9hud1p/m4oy83MebqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(38100700002)(86362001)(31696002)(36756003)(2906002)(41300700001)(66476007)(4326008)(8676002)(5660300002)(7416002)(8936002)(66556008)(36916002)(2616005)(66946007)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(66574015)(6666004)(54906003)(316002)(478600001)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWV0cktjOTQwY1Y5N3RnSWYxZm4rb3ByWDluNDRvMkZpUDg1MStobkxWcTlq?=
 =?utf-8?B?VDFxK0FRT0dSTXhiTHBuWjFWcE14bmUrTWR1ZTIzbzF6S3A5VDEzZStSTnJ2?=
 =?utf-8?B?N1V2L0NTZGVsanFkeC9kWU5hVDJlcCtFYU5JSVJrSEN5aExFVVlPU2Q5UHpM?=
 =?utf-8?B?eC95NnpLMUFRdGZDNWVENlcrQWZOYU83Qmh2c1hld2hyd2d1dEwvTHR3WTBT?=
 =?utf-8?B?Njlsek01UUxYNi9FWXlDV0ZKdGlSTm1oNXlPcTFTdGZMV2czcVpzZlZVTTFW?=
 =?utf-8?B?eGtYK2hycEp5aWU1UEtMUnd0ZXVMa0JWM2p2ckxSRTM2dVY1ZndYOHNmLzFq?=
 =?utf-8?B?U3lIMUloN0dmNzBXSS9mbjR3bFZyN243TXB4UDNzM29JUWxKQ3pQank5cy9m?=
 =?utf-8?B?MGJaOTMvYm5lQk54bWx1ZXhKNll2TGpkMGlheWh3UU1yV1NIbFM3VnViT2tP?=
 =?utf-8?B?SnE0K3hhZDVGQ2oyR0prNy9ZWWtaaVJtVk1lTVAvRmtRZlZkM3hJTWZ6MUJk?=
 =?utf-8?B?UytTQTdDUUVsTSszODZkK1prWUJ0Q21YZjJ6N3FZc04xUllST21QbGJTZDdK?=
 =?utf-8?B?M0lLZmJYbU9zLzFJblIwTUJJV1Z0OUVlRkVlUXNEMGliWThmTUhXZmNuTTN4?=
 =?utf-8?B?SW9KcnJCR3M3dTRGL0gyMGEyRU1CV2UvTVVIbU8vRDZJQUNLcENNZytqdDNX?=
 =?utf-8?B?dU95K0pkZ2Y5RnBWbUowQVJSRkV0VkMySTdTSytsRDd3VUYxYkZ4d0daNmVJ?=
 =?utf-8?B?Vk1tNnltd25DK25BZTR4d05lOHBOVDIxWUs2clhEQ2ljWSt4ZGRONm5YKzh5?=
 =?utf-8?B?VzhxVHlNaGI4QnNCYTJBTFIxTkR5Q0ZqRldudno3enRvRm5rY29KTkNrb01Y?=
 =?utf-8?B?eTloTExwM29XRi9CUnlENElaRjdTQjJjZEJGajZEM21nUFlwcndoeEY0emp0?=
 =?utf-8?B?VkpaWFZEUEIyTWR4bHNMRjZZdWdIQlhUQ3FaUGlUaHBWeUpzdEt6My9nd1hG?=
 =?utf-8?B?cmtLM1dXZ3BSNnVkRE5DbkwxVmx3SUg1MUxMQXM1R2t0V0QzSHN0cEJaTnRC?=
 =?utf-8?B?NEkyUkw1U1lOZU50YlVjTFlXd1FZZ3RtaXMySW8rMjVxUzFLOVkvNVNGWVFE?=
 =?utf-8?B?TGwvdk1aTjR0d2FBanJ6cEhDWThFaFlkandBRVZ3VUgyUkxxamNWRk1kVDU3?=
 =?utf-8?B?SWIxVEx4Z0JwWjZVK1loZW9YQzkrUTQ3T0JqRldubWxqNGpPN0lQTzNxTjNw?=
 =?utf-8?B?M01aSm5LWkpzTnN5anlsNU5lU3BXOFNTNDBzODZnUFlTTDk3UjBvWGZZdXJL?=
 =?utf-8?B?VHlHaFhTb1BGVWx6ZEQzRnRic1RxMzdvVjQ0MzRleEMxeDFpSzdDOTU2bnhX?=
 =?utf-8?B?d2IzazBTRVRKOUgxQmxUd1V3b2pYTW5teDNMdmlyZWt6TTBKbTQ3OHRQcnQv?=
 =?utf-8?B?TmNLUFNpblpXNFpUZmhiTkVZZVN3elh6M1hWVUlaZjdDK2t5eW1Mdm42VHVi?=
 =?utf-8?B?dWN2TFJLRGx5YUNZVFJmS1FhNW1COEZIaGExbGJ5UHB6WjYreUdMOEFvZlFD?=
 =?utf-8?B?TTNwQVNOVVFUT0trMzF2dDIxRk8wZlk4MThmL1lIKzMweWtZd281RWRVYXcx?=
 =?utf-8?B?b29CSmdreFhtL2ZHUDE2UTVtNWRCWk5FYzdwZzJrdTZFRUtoR3VweTJuSFh3?=
 =?utf-8?B?bGhSNm85SE4xa0Z2Y3lPUWNZNC9GZUZ3YmFoRFRnZG8zN0JrS1M4d0ZFRG10?=
 =?utf-8?B?WXpkelEyM3MwbStsKzdldjBlOWp6bW1rOWVaem1DaU80TzhZSlJqTjBOREto?=
 =?utf-8?B?ZndoZGJvWmUvaFkxcXZPa1V6K0lHL1dqUTg1V3J2SjBzdVJEbHB0czJCQkVn?=
 =?utf-8?B?Y3R6aVArME9nckNDWGozcG1DSDlrWXFuS3BvYUdzMllsNEI3MmY1bzlqZVRT?=
 =?utf-8?B?QUFROXlVUzY0NFczT2dVNVVlbDEyTG5BbHpuSDJUQmxzZS9pVFJGL3N0MDcy?=
 =?utf-8?B?V3pvOE5JUXRGd0c3RlNjSDdmZlU5cGFVV0RJRVNQK29jQkdod0dUS3lFMFIw?=
 =?utf-8?B?bU5uazdrMDFOTDh4aWtZQVNMUVM1OU01ZlBVNmJrdDB2ZURhTVpHa1FvTUVN?=
 =?utf-8?Q?EIwdrhXFHP2r8jzKkbEqpPahd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VWErREJyZUdyaWo3WDRIOVkyMTlZR1ZJZHJEVnJtekJzRHFQbFdGRGQ2cGJG?=
 =?utf-8?B?eFBxMDZWSDJmMzQ1ZVFYRjZSd1dGbHY3Y0pXUnVkbkwzbkRlNm5WaFdLRHoz?=
 =?utf-8?B?Q1V2WEZTdjc0Y05takRzbElYTnoyM3dMcVR4WDA0Q0w0WFROc1NNY0lUYzFS?=
 =?utf-8?B?dnNVZTJmZmRSKy9VRjFSbWF2ckZ3QitrSDkyTmU0enN1TE03UHFpd0lGQzJj?=
 =?utf-8?B?NGhXV3lPcGpHeEF2bWlKQ25IUlFUS1FmS2RqUU9Edk5qYjZrTm1ISEROZmxu?=
 =?utf-8?B?bkNuZ1A2NlgxL2Q3WklMQXBDZHVYbnZ3dXlBc0RaSmh2UFZRMnk5NFZEakVj?=
 =?utf-8?B?dFRCdStzbUpTd1RwOFFvb1VyaS8xTzRWT2R6ZUZNc0V6NTU2Yzc0SnkrYWN1?=
 =?utf-8?B?TnkzTkZ3c2ljeDhIbXVXN0lqWlMrV3FHWWJQM1J6OTBKMkZUWE50TElwMnJt?=
 =?utf-8?B?VXFsSEFUZnBEYVQyWE1seWtaVDFmS2tYMGl4V3d1UStGdHRvRDJZbWVVNHVP?=
 =?utf-8?B?b2FxdUV1Q2Y1b2FxSjNmY2IrdkdNWlVaTW1ONTBsaE1UZ2FyVWYvWDhsT1hs?=
 =?utf-8?B?dXNlRFZoK2x1enp5WURlZkJ3bGVlYVZYN2RjUk9VUm5pU2VQN2ZNc05leVpM?=
 =?utf-8?B?aUEydUhNbUxYU2E3TTgwZTlrNE5IR2tlVXZJUDVTd0VHRk5taEFtTzI5NkFa?=
 =?utf-8?B?WmxiT1NKZHRrYzJDNndNdFlGSC85VGtxckNKclNuajJObitTREtiVGg0N3Fa?=
 =?utf-8?B?VVlSWExMTmNwQjFEV0JWTEhJQ1I5RjRhemFSMnJNZ1FlQlRaWCtFdnh4SjdZ?=
 =?utf-8?B?RUJGMkVsajVHWXlqbFNOZzJXRWNnSGVEWlo2SThyRFI3aG03MHJYRUJQdmVi?=
 =?utf-8?B?a3hkUmluS0ZZSUY4cS9YV3RBT01kejhnNkRHdVZmSWVRUmpHTHAzbnU1WGYw?=
 =?utf-8?B?Nk5PTWdqRDI2TWVweFJpNDBiNHRzbHdaNlROQ3FBcW9DMVlISnZieXRYckFR?=
 =?utf-8?B?eWtTR04veU9Rak54c2x1d2pPN1AzK3JIWGxlZ3l5RDhVS3FYbG1yaW5RN0xz?=
 =?utf-8?B?akJaaVJCdTJ6N3hhUFlBNExNbDVrSks2cFhKaUg1OXNXQzFZUC83bTZIaXUw?=
 =?utf-8?B?UDFhWG11SHp0SG9LMVVrRTJmTzQ3MjNUTXQ4YmwrWjd0TkNDekZoNUVGOXNS?=
 =?utf-8?B?eEtHSk9uZWU1UE9sY0hzdTk2alA4NkdtYXJ4TC92SnNKSVdzV1NhNjBYUTBW?=
 =?utf-8?B?clFvNi9NVSs4blczeER6S2daODNYZVNXWFRUTGY5VXI2UnAwK2lBYndnU3Jr?=
 =?utf-8?B?ZkllUHByZVBNclJvdVJsLzEzNGhBNkE3eExCUmNwM1lUeTNRdzkrZ1hxemJH?=
 =?utf-8?Q?nccZFssKPnmjX3YtdYulZ4P3v1NPt60o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6039284-4c75-4656-11be-08db0d8e9bf2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 06:50:35.8697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTaf1ZleUZB1Rvcd5TMwFGYtqXm5dFhUBUnqQtkI0AWTOMZvpYfybu75Obzn3N/Wv1DnLLPlwwyMgXsCETCHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4272
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130060
X-Proofpoint-GUID: Wn9wEnvM67nPcudbZ_fQC0JB935BIkAa
X-Proofpoint-ORIG-GUID: Wn9wEnvM67nPcudbZ_fQC0JB935BIkAa
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>, virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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

CgpPbiAyLzgvMjAyMyAxOjQyIEFNLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiBPbmx5IGNyZWF0
ZSBpb3ZhX3RyZWUgaWYgYW5kIHdoZW4gaXQgaXMgbmVlZGVkLgo+Cj4gVGhlIGNsZWFudXAga2Vl
cHMgYmVpbmcgcmVzcG9uc2libGUgb2YgbGFzdCBWUSBidXQgdGhpcyBjaGFuZ2UgYWxsb3dzIGl0
Cj4gdG8gbWVyZ2UgYm90aCBjbGVhbnVwIGZ1bmN0aW9ucy4KPgo+IFNpZ25lZC1vZmYtYnk6IEV1
Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IEFja2VkLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICAgbmV0L3Zob3N0LXZkcGEuYyB8IDk5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL25ldC92aG9zdC12ZHBhLmMgYi9uZXQvdmhvc3QtdmRwYS5jCj4gaW5kZXggZGU1ZWQ4ZmYy
Mi4uYTllNmM4ZjI4ZSAxMDA2NDQKPiAtLS0gYS9uZXQvdmhvc3QtdmRwYS5jCj4gKysrIGIvbmV0
L3Zob3N0LXZkcGEuYwo+IEBAIC0xNzgsMTMgKzE3OCw5IEBAIGVycl9pbml0Ogo+ICAgc3RhdGlj
IHZvaWQgdmhvc3RfdmRwYV9jbGVhbnVwKE5ldENsaWVudFN0YXRlICpuYykKPiAgIHsKPiAgICAg
ICBWaG9zdFZEUEFTdGF0ZSAqcyA9IERPX1VQQ0FTVChWaG9zdFZEUEFTdGF0ZSwgbmMsIG5jKTsK
PiAtICAgIHN0cnVjdCB2aG9zdF9kZXYgKmRldiA9ICZzLT52aG9zdF9uZXQtPmRldjsKPiAgIAo+
ICAgICAgIHFlbXVfdmZyZWUocy0+Y3ZxX2NtZF9vdXRfYnVmZmVyKTsKPiAgICAgICBxZW11X3Zm
cmVlKHMtPnN0YXR1cyk7Cj4gLSAgICBpZiAoZGV2LT52cV9pbmRleCArIGRldi0+bnZxcyA9PSBk
ZXYtPnZxX2luZGV4X2VuZCkgewo+IC0gICAgICAgIGdfY2xlYXJfcG9pbnRlcigmcy0+dmhvc3Rf
dmRwYS5pb3ZhX3RyZWUsIHZob3N0X2lvdmFfdHJlZV9kZWxldGUpOwo+IC0gICAgfQo+ICAgICAg
IGlmIChzLT52aG9zdF9uZXQpIHsKPiAgICAgICAgICAgdmhvc3RfbmV0X2NsZWFudXAocy0+dmhv
c3RfbmV0KTsKPiAgICAgICAgICAgZ19mcmVlKHMtPnZob3N0X25ldCk7Cj4gQEAgLTIzNCwxMCAr
MjMwLDY0IEBAIHN0YXRpYyBzc2l6ZV90IHZob3N0X3ZkcGFfcmVjZWl2ZShOZXRDbGllbnRTdGF0
ZSAqbmMsIGNvbnN0IHVpbnQ4X3QgKmJ1ZiwKPiAgICAgICByZXR1cm4gc2l6ZTsKPiAgIH0KPiAg
IAo+ICsvKiogRnJvbSBhbnkgdmRwYSBuZXQgY2xpZW50LCBnZXQgdGhlIG5ldGNsaWVudCBvZiBm
aXJzdCBxdWV1ZSBwYWlyICovCj4gK3N0YXRpYyBWaG9zdFZEUEFTdGF0ZSAqdmhvc3RfdmRwYV9u
ZXRfZmlyc3RfbmNfdmRwYShWaG9zdFZEUEFTdGF0ZSAqcykKPiArewo+ICsgICAgTklDU3RhdGUg
Km5pYyA9IHFlbXVfZ2V0X25pYyhzLT5uYy5wZWVyKTsKPiArICAgIE5ldENsaWVudFN0YXRlICpu
YzAgPSBxZW11X2dldF9wZWVyKG5pYy0+bmNzLCAwKTsKPiArCj4gKyAgICByZXR1cm4gRE9fVVBD
QVNUKFZob3N0VkRQQVN0YXRlLCBuYywgbmMwKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgdmhv
c3RfdmRwYV9uZXRfZGF0YV9zdGFydF9maXJzdChWaG9zdFZEUEFTdGF0ZSAqcykKPiArewo+ICsg
ICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSAmcy0+dmhvc3RfdmRwYTsKPiArCj4gKyAgICBpZiAo
di0+c2hhZG93X3Zxc19lbmFibGVkKSB7Cj4gKyAgICAgICAgdi0+aW92YV90cmVlID0gdmhvc3Rf
aW92YV90cmVlX25ldyh2LT5pb3ZhX3JhbmdlLmZpcnN0LAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdi0+aW92YV9yYW5nZS5sYXN0KTsKPiArICAgIH0KPiAr
fQo+ICsKPiArc3RhdGljIGludCB2aG9zdF92ZHBhX25ldF9kYXRhX3N0YXJ0KE5ldENsaWVudFN0
YXRlICpuYykKPiArewo+ICsgICAgVmhvc3RWRFBBU3RhdGUgKnMgPSBET19VUENBU1QoVmhvc3RW
RFBBU3RhdGUsIG5jLCBuYyk7Cj4gKyAgICBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9ICZzLT52aG9z
dF92ZHBhOwo+ICsKPiArICAgIGFzc2VydChuYy0+aW5mby0+dHlwZSA9PSBORVRfQ0xJRU5UX0RS
SVZFUl9WSE9TVF9WRFBBKTsKPiArCj4gKyAgICBpZiAodi0+aW5kZXggPT0gMCkgewo+ICsgICAg
ICAgIHZob3N0X3ZkcGFfbmV0X2RhdGFfc3RhcnRfZmlyc3Qocyk7Cj4gKyAgICAgICAgcmV0dXJu
IDA7Cj4gKyAgICB9Cj4gKwo+ICsgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+ICsg
ICAgICAgIFZob3N0VkRQQVN0YXRlICpzMCA9IHZob3N0X3ZkcGFfbmV0X2ZpcnN0X25jX3ZkcGEo
cyk7Cj4gKyAgICAgICAgdi0+aW92YV90cmVlID0gczAtPnZob3N0X3ZkcGEuaW92YV90cmVlOwo+
ICsgICAgfQo+ICsKPiArICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB2aG9z
dF92ZHBhX25ldF9jbGllbnRfc3RvcChOZXRDbGllbnRTdGF0ZSAqbmMpCj4gK3sKPiArICAgIFZo
b3N0VkRQQVN0YXRlICpzID0gRE9fVVBDQVNUKFZob3N0VkRQQVN0YXRlLCBuYywgbmMpOwo+ICsg
ICAgc3RydWN0IHZob3N0X2RldiAqZGV2Owo+ICsKPiArICAgIGFzc2VydChuYy0+aW5mby0+dHlw
ZSA9PSBORVRfQ0xJRU5UX0RSSVZFUl9WSE9TVF9WRFBBKTsKPiArCj4gKyAgICBkZXYgPSBzLT52
aG9zdF92ZHBhLmRldjsKPiArICAgIGlmIChkZXYtPnZxX2luZGV4ICsgZGV2LT5udnFzID09IGRl
di0+dnFfaW5kZXhfZW5kKSB7Cj4gKyAgICAgICAgZ19jbGVhcl9wb2ludGVyKCZzLT52aG9zdF92
ZHBhLmlvdmFfdHJlZSwgdmhvc3RfaW92YV90cmVlX2RlbGV0ZSk7Cj4gKyAgICB9Cj4gK30KPiAr
Cj4gICBzdGF0aWMgTmV0Q2xpZW50SW5mbyBuZXRfdmhvc3RfdmRwYV9pbmZvID0gewo+ICAgICAg
ICAgICAudHlwZSA9IE5FVF9DTElFTlRfRFJJVkVSX1ZIT1NUX1ZEUEEsCj4gICAgICAgICAgIC5z
aXplID0gc2l6ZW9mKFZob3N0VkRQQVN0YXRlKSwKPiAgICAgICAgICAgLnJlY2VpdmUgPSB2aG9z
dF92ZHBhX3JlY2VpdmUsCj4gKyAgICAgICAgLnN0YXJ0ID0gdmhvc3RfdmRwYV9uZXRfZGF0YV9z
dGFydCwKPiArICAgICAgICAuc3RvcCA9IHZob3N0X3ZkcGFfbmV0X2NsaWVudF9zdG9wLAo+ICAg
ICAgICAgICAuY2xlYW51cCA9IHZob3N0X3ZkcGFfY2xlYW51cCwKPiAgICAgICAgICAgLmhhc192
bmV0X2hkciA9IHZob3N0X3ZkcGFfaGFzX3ZuZXRfaGRyLAo+ICAgICAgICAgICAuaGFzX3VmbyA9
IHZob3N0X3ZkcGFfaGFzX3VmbywKPiBAQCAtMzUxLDcgKzQwMSw3IEBAIGRtYV9tYXBfZXJyOgo+
ICAgCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfbmV0X2N2cV9zdGFydChOZXRDbGllbnRTdGF0
ZSAqbmMpCj4gICB7Cj4gLSAgICBWaG9zdFZEUEFTdGF0ZSAqczsKPiArICAgIFZob3N0VkRQQVN0
YXRlICpzLCAqczA7Cj4gICAgICAgc3RydWN0IHZob3N0X3ZkcGEgKnY7Cj4gICAgICAgdWludDY0
X3QgYmFja2VuZF9mZWF0dXJlczsKPiAgICAgICBpbnQ2NF90IGN2cV9ncm91cDsKPiBAQCAtNDI1
LDYgKzQ3NSwxNSBAQCBvdXQ6Cj4gICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgIH0KPiAgIAo+
ICsgICAgczAgPSB2aG9zdF92ZHBhX25ldF9maXJzdF9uY192ZHBhKHMpOwo+ICsgICAgaWYgKHMw
LT52aG9zdF92ZHBhLmlvdmFfdHJlZSkgewo+ICsgICAgICAgIC8qIFNWUSBpcyBhbHJlYWR5IGNv
bmZpZ3VyZWQgZm9yIGFsbCB2aXJ0cXVldWVzICovCj4gKyAgICAgICAgdi0+aW92YV90cmVlID0g
czAtPnZob3N0X3ZkcGEuaW92YV90cmVlOwo+ICsgICAgfSBlbHNlIHsKPiArICAgICAgICB2LT5p
b3ZhX3RyZWUgPSB2aG9zdF9pb3ZhX3RyZWVfbmV3KHYtPmlvdmFfcmFuZ2UuZmlyc3QsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2LT5pb3ZhX3JhbmdlLmxh
c3QpOwpJIHdvbmRlciBob3cgdGhpcyBjYXNlIGNvdWxkIGhhcHBlbiwgdmhvc3RfdmRwYV9uZXRf
ZGF0YV9zdGFydF9maXJzdCgpIApzaG91bGQndmUgYWxsb2NhdGVkIGFuIGlvdmEgdHJlZSBvbiB0
aGUgZmlyc3QgZGF0YSB2cS4gSXMgemVybyBkYXRhIHZxIApldmVyIHBvc3NpYmxlIG9uIG5ldCB2
aG9zdC12ZHBhPwoKVGhhbmtzLAotU2l3ZWkKPiArICAgIH0KPiArCj4gICAgICAgciA9IHZob3N0
X3ZkcGFfY3ZxX21hcF9idWYoJnMtPnZob3N0X3ZkcGEsIHMtPmN2cV9jbWRfb3V0X2J1ZmZlciwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aG9zdF92ZHBhX25ldF9jdnFfY21k
X3BhZ2VfbGVuKCksIGZhbHNlKTsKPiAgICAgICBpZiAodW5saWtlbHkociA8IDApKSB7Cj4gQEAg
LTQ0OSwxNSArNTA4LDkgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9uZXRfY3ZxX3N0b3AoTmV0
Q2xpZW50U3RhdGUgKm5jKQo+ICAgICAgIGlmIChzLT52aG9zdF92ZHBhLnNoYWRvd192cXNfZW5h
YmxlZCkgewo+ICAgICAgICAgICB2aG9zdF92ZHBhX2N2cV91bm1hcF9idWYoJnMtPnZob3N0X3Zk
cGEsIHMtPmN2cV9jbWRfb3V0X2J1ZmZlcik7Cj4gICAgICAgICAgIHZob3N0X3ZkcGFfY3ZxX3Vu
bWFwX2J1Zigmcy0+dmhvc3RfdmRwYSwgcy0+c3RhdHVzKTsKPiAtICAgICAgICBpZiAoIXMtPmFs
d2F5c19zdnEpIHsKPiAtICAgICAgICAgICAgLyoKPiAtICAgICAgICAgICAgICogSWYgb25seSB0
aGUgQ1ZRIGlzIHNoYWRvd2VkIHdlIGNhbiBkZWxldGUgdGhpcyBzYWZlbHkuCj4gLSAgICAgICAg
ICAgICAqIElmIGFsbCB0aGUgVlFzIGFyZSBzaGFkb3dzIHRoaXMgd2lsbCBiZSBuZWVkZWQgYnkg
dGhlIHRpbWUgdGhlCj4gLSAgICAgICAgICAgICAqIGRldmljZSBpcyBzdGFydGVkIGFnYWluIHRv
IHJlZ2lzdGVyIFNWUSB2cmluZ3MgYW5kIHNpbWlsYXIuCj4gLSAgICAgICAgICAgICAqLwo+IC0g
ICAgICAgICAgICBnX2NsZWFyX3BvaW50ZXIoJnMtPnZob3N0X3ZkcGEuaW92YV90cmVlLCB2aG9z
dF9pb3ZhX3RyZWVfZGVsZXRlKTsKPiAtICAgICAgICB9Cj4gICAgICAgfQo+ICsKPiArICAgIHZo
b3N0X3ZkcGFfbmV0X2NsaWVudF9zdG9wKG5jKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHNzaXpl
X3Qgdmhvc3RfdmRwYV9uZXRfY3ZxX2FkZChWaG9zdFZEUEFTdGF0ZSAqcywgc2l6ZV90IG91dF9s
ZW4sCj4gQEAgLTY2Nyw4ICs3MjAsNyBAQCBzdGF0aWMgTmV0Q2xpZW50U3RhdGUgKm5ldF92aG9z
dF92ZHBhX2luaXQoTmV0Q2xpZW50U3RhdGUgKnBlZXIsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnQgbnZxcywKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgaXNfZGF0YXBhdGgsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBib29sIHN2cSwKPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSBpb3ZhX3JhbmdlLAo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWaG9zdElPVkFUcmVlICpp
b3ZhX3RyZWUpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgaW92YV9yYW5nZSkKPiAgIHsKPiAgICAgICBOZXRDbGll
bnRTdGF0ZSAqbmMgPSBOVUxMOwo+ICAgICAgIFZob3N0VkRQQVN0YXRlICpzOwo+IEBAIC02OTAs
NyArNzQyLDYgQEAgc3RhdGljIE5ldENsaWVudFN0YXRlICpuZXRfdmhvc3RfdmRwYV9pbml0KE5l
dENsaWVudFN0YXRlICpwZWVyLAo+ICAgICAgIHMtPnZob3N0X3ZkcGEuc2hhZG93X3Zxc19lbmFi
bGVkID0gc3ZxOwo+ICAgICAgIHMtPnZob3N0X3ZkcGEuaW92YV9yYW5nZSA9IGlvdmFfcmFuZ2U7
Cj4gICAgICAgcy0+dmhvc3RfdmRwYS5zaGFkb3dfZGF0YSA9IHN2cTsKPiAtICAgIHMtPnZob3N0
X3ZkcGEuaW92YV90cmVlID0gaW92YV90cmVlOwo+ICAgICAgIGlmICghaXNfZGF0YXBhdGgpIHsK
PiAgICAgICAgICAgcy0+Y3ZxX2NtZF9vdXRfYnVmZmVyID0gcWVtdV9tZW1hbGlnbihxZW11X3Jl
YWxfaG9zdF9wYWdlX3NpemUoKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdmhvc3RfdmRwYV9uZXRfY3ZxX2NtZF9wYWdlX2xlbigpKTsKPiBAQCAtNzYw
LDcgKzgxMSw2IEBAIGludCBuZXRfaW5pdF92aG9zdF92ZHBhKGNvbnN0IE5ldGRldiAqbmV0ZGV2
LCBjb25zdCBjaGFyICpuYW1lLAo+ICAgICAgIHVpbnQ2NF90IGZlYXR1cmVzOwo+ICAgICAgIGlu
dCB2ZHBhX2RldmljZV9mZDsKPiAgICAgICBnX2F1dG9mcmVlIE5ldENsaWVudFN0YXRlICoqbmNz
ID0gTlVMTDsKPiAtICAgIGdfYXV0b3B0cihWaG9zdElPVkFUcmVlKSBpb3ZhX3RyZWUgPSBOVUxM
Owo+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgaW92YV9yYW5nZTsKPiAgICAg
ICBOZXRDbGllbnRTdGF0ZSAqbmM7Cj4gICAgICAgaW50IHF1ZXVlX3BhaXJzLCByLCBpID0gMCwg
aGFzX2N2cSA9IDA7Cj4gQEAgLTgxMiwxMiArODYyLDggQEAgaW50IG5ldF9pbml0X3Zob3N0X3Zk
cGEoY29uc3QgTmV0ZGV2ICpuZXRkZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAgICAgICAgIGdv
dG8gZXJyOwo+ICAgICAgIH0KPiAgIAo+IC0gICAgaWYgKG9wdHMtPnhfc3ZxKSB7Cj4gLSAgICAg
ICAgaWYgKCF2aG9zdF92ZHBhX25ldF92YWxpZF9zdnFfZmVhdHVyZXMoZmVhdHVyZXMsIGVycnAp
KSB7Cj4gLSAgICAgICAgICAgIGdvdG8gZXJyX3N2cTsKPiAtICAgICAgICB9Cj4gLQo+IC0gICAg
ICAgIGlvdmFfdHJlZSA9IHZob3N0X2lvdmFfdHJlZV9uZXcoaW92YV9yYW5nZS5maXJzdCwgaW92
YV9yYW5nZS5sYXN0KTsKPiArICAgIGlmIChvcHRzLT54X3N2cSAmJiAhdmhvc3RfdmRwYV9uZXRf
dmFsaWRfc3ZxX2ZlYXR1cmVzKGZlYXR1cmVzLCBlcnJwKSkgewo+ICsgICAgICAgIGdvdG8gZXJy
Owo+ICAgICAgIH0KPiAgIAo+ICAgICAgIG5jcyA9IGdfbWFsbG9jMChzaXplb2YoKm5jcykgKiBx
dWV1ZV9wYWlycyk7Cj4gQEAgLTgyNSw3ICs4NzEsNyBAQCBpbnQgbmV0X2luaXRfdmhvc3RfdmRw
YShjb25zdCBOZXRkZXYgKm5ldGRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAgICBmb3IgKGkg
PSAwOyBpIDwgcXVldWVfcGFpcnM7IGkrKykgewo+ICAgICAgICAgICBuY3NbaV0gPSBuZXRfdmhv
c3RfdmRwYV9pbml0KHBlZXIsIFRZUEVfVkhPU1RfVkRQQSwgbmFtZSwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2ZHBhX2RldmljZV9mZCwgaSwgMiwgdHJ1ZSwgb3B0
cy0+eF9zdnEsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb3ZhX3Jh
bmdlLCBpb3ZhX3RyZWUpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW92YV9yYW5nZSk7Cj4gICAgICAgICAgIGlmICghbmNzW2ldKQo+ICAgICAgICAgICAgICAgZ290
byBlcnI7Cj4gICAgICAgfQo+IEBAIC04MzMsMTMgKzg3OSwxMSBAQCBpbnQgbmV0X2luaXRfdmhv
c3RfdmRwYShjb25zdCBOZXRkZXYgKm5ldGRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAgICBp
ZiAoaGFzX2N2cSkgewo+ICAgICAgICAgICBuYyA9IG5ldF92aG9zdF92ZHBhX2luaXQocGVlciwg
VFlQRV9WSE9TVF9WRFBBLCBuYW1lLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdmRwYV9kZXZpY2VfZmQsIGksIDEsIGZhbHNlLAo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBvcHRzLT54X3N2cSwgaW92YV9yYW5nZSwgaW92YV90cmVlKTsKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0cy0+eF9zdnEsIGlvdmFfcmFuZ2UpOwo+ICAg
ICAgICAgICBpZiAoIW5jKQo+ICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gICAgICAgfQo+ICAg
Cj4gLSAgICAvKiBpb3ZhX3RyZWUgb3duZXJzaGlwIGJlbG9uZ3MgdG8gbGFzdCBOZXRDbGllbnRT
dGF0ZSAqLwo+IC0gICAgZ19zdGVhbF9wb2ludGVyKCZpb3ZhX3RyZWUpOwo+ICAgICAgIHJldHVy
biAwOwo+ICAgCj4gICBlcnI6Cj4gQEAgLTg0OSw3ICs4OTMsNiBAQCBlcnI6Cj4gICAgICAgICAg
IH0KPiAgICAgICB9Cj4gICAKPiAtZXJyX3N2cToKPiAgICAgICBxZW11X2Nsb3NlKHZkcGFfZGV2
aWNlX2ZkKTsKPiAgIAo+ICAgICAgIHJldHVybiAtMTsKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
