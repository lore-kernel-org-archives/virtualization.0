Return-Path: <SRS0=mL0J=HW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75F5C433E0
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:42:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F5F64E57
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F5F64E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3DCAD86DAD;
	Sat, 20 Feb 2021 02:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3O98pznIgb76; Sat, 20 Feb 2021 02:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8977586DAF;
	Sat, 20 Feb 2021 02:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC00C000A;
	Sat, 20 Feb 2021 02:42:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DF82C0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0420487520
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LTHkZkJraJWs
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B8928751F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:42:12 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K2eWt7025564;
 Sat, 20 Feb 2021 02:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : from : to :
 references : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ULm+jw7W/Hk7YAdPpTLglb+aLz8d193SGPpVmK6pluA=;
 b=Sxmi0CmZS2RawTU0Cl5qPZMg3UAGzVxQqsV2v1LmFMGGaoljzvhguBmz6GyHiuS3iB9F
 ODrvzLstJP0fe6r5RaxVbk90NFDmHj4ur+sb+tEaMCnSp8NoMqsP/dXnLCcWpBQaSPrM
 JoJfvb8+ksqpFjFD6S8euIzobo2tlO8m9/ISU9Clj6hYQdT9CF9Bz+lT0y/7VSO9jzE6
 uyYvHsbp9LlKcK1BOQugVg+G/ZGrhXz033onZJVvFyuM8RAdEu/PVctdWdQmYYkue8uu
 DZ9Zq3htM0O2S9QNRdscLqakAPhPrRSPXGnnVUF3jTuFjUhDHroejl1iusE3j/WHsBsa Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 36tqxb83a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Feb 2021 02:42:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K2eMKU122282;
 Sat, 20 Feb 2021 02:42:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
 by aserp3020.oracle.com with ESMTP id 36prp3ke67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Feb 2021 02:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTh28cGZcFf8XjhgzYCqHAQjDyz5xYmpTO72d/mDK1p9oti+aXmV9aGfmrGnkWTjJbdGA0iQI0qa2PLsw0kHS4gNE2g1FCJAc7SVzP6sos4y4Y0Yt+5PmfNuMT2EVdGr12TdIBWawdrg04NjOs8v+ETA82p3bpkc+MPdQTMkzDesIjUgeT6IpJrekkG1MM3BdquLrI16mvQDFNi63Bj0+3zHF7i9z22MWTy7asqgCNbItn4k2Bk80vaqAc4r0/lbQOWRMvAM0gyPz06Aa6b69re9lvjZRekHG8nxy5lA2ouzmhjiVJa4G6bgs2NXrrp6cIlvpfhe5HMdVDbrUDfLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULm+jw7W/Hk7YAdPpTLglb+aLz8d193SGPpVmK6pluA=;
 b=BrmREe5M37CWFRA86/rL7vBQ6I2/Xq3nJAS0btOUMzt8pNI/kBxPtbUL5M3+u+5zRzcN9xWp8Bo+2OLU/sDwLFgJEP2+YLkaNdZyFfLLUO0JeNRUrjK9xj3llH79tMCExe8KeWSZqbFD+4KTpMikq2Y4sGD75gAZdgBEYO+YScVWJh4v3ebWDr3FGvYlDR1cZltkn9Vd0ASo65PpYKQMPGl93Oe5s1nL4BY3Xq/UOzsijI3ct+CZx8uKh8eelStRN81F7t2ECpzKfAc1e3jNbCeddv/rtaTRl0FNC0U2RG96HcsONpzS/M58ZhWzepvor34mQpNi2+iXu+T+IiH+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULm+jw7W/Hk7YAdPpTLglb+aLz8d193SGPpVmK6pluA=;
 b=TfZoWXL45Esii8qBCij3lrm9Cukf8cU+erKnVUdhr6NUjhJ05+6RNzy3xXjvWhgCbWBVqCw4ZH7GPX2Pe4rhncFMf7ldEjnA6MbNV/xLxwvt2/2VpmDBLvu8cyuwJIEHNLGZZ5vFLaOyvOseMS7Vsz8dJlZWMOqJ06P2hzbuX6Q=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3288.namprd10.prod.outlook.com (2603:10b6:a03:156::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 02:42:08 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3868.029; Sat, 20 Feb 2021
 02:42:07 +0000
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix suspend/resume index restoration
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: Eli Cohen <elic@nvidia.com>, jasowang@redhat.com
References: <20210216162001.83541-1-elic@nvidia.com>
 <4ecc1c7f-4f5a-68be-6734-e18dfeb91437@oracle.com>
Organization: Oracle Corporation
Message-ID: <033b0806-4037-5755-a1fa-91dbb58bab2e@oracle.com>
Date: Fri, 19 Feb 2021 18:42:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <4ecc1c7f-4f5a-68be-6734-e18dfeb91437@oracle.com>
Content-Language: en-US
X-Originating-IP: [73.189.186.83]
X-ClientProxiedBy: CY4PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:903:18::23) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (73.189.186.83) by
 CY4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:903:18::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 02:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c8190a6-2660-473a-0d95-08d8d5491d6c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR10MB328857EC93A84835C5B6A65BB1839@BYAPR10MB3288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKfIjVjeZNbUujIsMq5YHULcGtwXjJ58N5dl10vN6M0BM33m3QC29lQKmqmUJDq9cfZhLzjX/4ANujb03Aku49tLRJTb1b6Ek5IpXO0dEtHwJ5hapdGleA1FUdZi/hPyknjf1rWsjmOd3n+DRgyNPSX9lWrYspkSfjrXxc5gJNpe+J/9js8B4yax5Ld3UCVlBaOcW+QlN1cSBVqjudwOwOb/LMT2J1R+IOIdsSac5s2PSkROWhovvbmaOsmoRrO9faE+zaVhIhs1HXy5H+Fa4TvvN7DlXRB+4CT2OJMu+Wz2U+mSlLXw5bjA2/FNPP/0/eH3P9LvTMwXsbLYfruqkD+sZrQnNaSdKShwyvpp8Og44kR9xLOsEN02Orx8pK6lUYE2r/0x2GKnVQpnxrELtXk5qAAKz6YbFLqq31qFkAghuNrm9NAfi1c6BiZa2WKawT9zPQV7284f6vzWwuDIB1T6Sx9hqXbxEAkm+AqyqSwRJQpoz109la1nL20XbOH12sYOX5CETKrEwp9fSAdy0TtWbotHBzjy5wiUXqro5U4gisHYREwebEUaY8fqyyncpaMyFBmEs1BUJrOp1o2mGYPhNNfl7IoDcUG3Wc2ckS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(39860400002)(346002)(396003)(366004)(16526019)(31696002)(186003)(66946007)(4326008)(8676002)(8936002)(66556008)(66476007)(36756003)(83380400001)(2906002)(53546011)(36916002)(86362001)(6486002)(15650500001)(26005)(478600001)(5660300002)(956004)(2616005)(31686004)(16576012)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OWF2ajNBWmhBRFkvT256U04rRVJSRTU5YVMvVmlieW1NT2drbXZXR3MxMnlt?=
 =?utf-8?B?Z2poVnpJNExqa3FCbnFkTnZlcGZiTmgzVW45NENIRWdBekRSK3E5TzJrU2lx?=
 =?utf-8?B?eDVicVp4L3JBbk9wTHQvQmpKTENmOEpXVXhhN1RSL21ndlkwUWJVamFGMVVY?=
 =?utf-8?B?eDZ5cmNDM2FWaWlWUnllK3VCZkdMUHBWMFNKS3k4QjVjVTZGcDJkUzBLeSsy?=
 =?utf-8?B?SXlUcFpBZnYvMnJuZ3dPdzJDbkFlMEloMDdlRXhTZU00SmVUNWQxS2gwdFFl?=
 =?utf-8?B?U1AwZW4wd3M3MkkzckpXL2doR2Z3NTNPOXJhbjFYTkViWmlMSDlFenROaXJ6?=
 =?utf-8?B?OHlDbjN2MXJqS3VBNjBRdjZHQmZaTHV2SktmbWF4VS9MYXNVTCtpbFc0T1F1?=
 =?utf-8?B?cUxDQnlDWDdmaVVCSUl4d0NFaXprTzZVVnZNbml4bWJ3QnVLMThnU2ZRbWEw?=
 =?utf-8?B?RlBVT1dwemV2cXlDZ2hoWDlMS0Y2NzFTc3JobHVaREZERjdlK0c1RkFMQi95?=
 =?utf-8?B?dEk4aDNkSHBjZ1E4WmcvMWpGdGJiWVdUUDJBVkFTdWhXSHhpU0wxcCtJNytx?=
 =?utf-8?B?R3hZM3hNZW80ZkVqUnlnS3c1QW0vUmUwQm02eUoxaXdvYzZISlRNaFY0emd5?=
 =?utf-8?B?bmxTY3VObEtFMGM1UVQ4RE0wRURhVC9aK3JGY3pCMTk0S1dwZTFmTXNrSyta?=
 =?utf-8?B?M1dBeXlTZG9GWnFKRGgrNWxiSkc1VzlCRGhnaDhDU1M5dlJpb05pWWM5K05W?=
 =?utf-8?B?Q1I0aFZiUXNFT3VVS21KREdaS0lXMjBueGhWd0R2aTQzR09weVBZa0czTjJn?=
 =?utf-8?B?emxtZUd5Q0ZOTklmSDBiaE0zVDZoczV3MzhWaUZYQVBpczlOTkNsRkhad2hU?=
 =?utf-8?B?cXQzREYvRUVzb3hzTllRK0RyeFlpVktPQW94QkVrWEF6Q0RCUkZxUVdUbWZP?=
 =?utf-8?B?YkNEaFRJMnNiTTF6cWtwOUJ0TGI0VFBUOUwyL2h1Mnd0YWozMC8vV3RiaHJI?=
 =?utf-8?B?ZXRVRnJGTHVHRTJ1V21ZU0RjZEpub0FmVkdSK1g0WFJEVjlRSEJyKy9QQ0d0?=
 =?utf-8?B?aFJRNG1YcXordFdXd2t3Z2krTTNPV1J3QWplcUZwUFBURFlCZmFQMElrUFJs?=
 =?utf-8?B?ZjRxNFBNdmJnWDJxYzQ4WmsyUkJJSGRzYkVub0xyNnRPWFdOalhOak8raVh5?=
 =?utf-8?B?YXlxY09jeTdsZkc3NktwYzkwTS9OZlQrdk0xNDdvMmZjc3JpcUxsWlhaK05Q?=
 =?utf-8?B?alB0eW5ZWGFNaUIyWnBRTjFGMUZrSEQ4L3NmdEtIbjlxQ0J5K1ZESXU3VzZk?=
 =?utf-8?B?RnJmVC90MDZlVG9PaHEwaVJHTE9hdXJ3Y0s4WC92dTdQSGtTWk1URktsTjhr?=
 =?utf-8?B?TXRVTytFMVVibFliQWRJZ0ZGTkJuS2k0K01nWDlzdHJxdlZrS2lKMHpTZmVY?=
 =?utf-8?B?WE0wZkMwamUrUXA5L09SME12VjY4NlFvcWQzbXV0SWFRb0RRbHZwMDBiS1Fy?=
 =?utf-8?B?RlhjZWVWWXVzVGFMeDBmd0xmUXlCbTlDZ2FKaXo4TlJLa1dqZUxtSTAwaUlZ?=
 =?utf-8?B?OWdPd2JZWGpYV2ZMMGtIWUdIQittS0JyZ1JhcFB2NzRwL1d6QUF1cjJRSFgz?=
 =?utf-8?B?cjc4MFYwVEI2OSsxMEpmWUhNUmFvZDRtbVR5dWFhTGhKV2R3R2JZTFUzdHRC?=
 =?utf-8?B?MHVuRjBuaVFoSWE0K2QyN0psUHJRb1VWNXdVMFBlZVczVHorY3Z3c0hLVlJB?=
 =?utf-8?Q?F+a399V4l0cNNwcvzc4wB+OnpQCGrTMZ98LHK5w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8190a6-2660-473a-0d95-08d8d5491d6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 02:42:07.7433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b776r3UTQOqvFNInjNjkauQ/jFG5U7mJuJx/gt7YifxrHDik7OvOHxWel4RJ75YfD/aijNNPVztqA9E2FzieSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3288
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200021
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200021
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

CgpPbiAyLzE3LzIwMjEgMTE6NDIgQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4KPgo+IE9uIDIvMTYv
MjAyMSA4OjIwIEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+IFdoZW4gd2Ugc3VzcGVuZCB0aGUgVk0s
IHRoZSBWRFBBIGludGVyZmFjZSB3aWxsIGJlIHJlc2V0LiBXaGVuIHRoZSBWTSBpcwo+PiByZXN1
bWVkIGFnYWluLCBjbGVhcl92aXJ0cXVldWVzKCkgd2lsbCBjbGVhciB0aGUgYXZhaWxhYmxlIGFu
ZCB1c2VkCj4+IGluZGljZXMgcmVzdWx0aW5nIGluIGhhcmR3YXJlIHZpcnF0cXVldWUgb2JqZWN0
cyBiZWNvbWluZyBvdXQgb2Ygc3luYy4KPj4gV2UgY2FuIGF2b2lkIHRoaXMgZnVuY3Rpb24gYWxs
dG9nZXRoZXIgc2luY2UgcWVtdSB3aWxsIGNsZWFyIHRoZW0gaWYKPj4gcmVxdWlyZWQsIGUuZy4g
d2hlbiB0aGUgVk0gd2VudCB0aHJvdWdoIGEgcmVib290Lgo+Pgo+PiBNb3Jlb3Zlciwgc2luY2Ug
dGhlIGh3IGF2YWlsYWJsZSBhbmQgdXNlZCBpbmRpY2VzIHNob3VsZCBhbHdheXMgYmUKPj4gaWRl
bnRpY2FsIG9uIHF1ZXJ5IGFuZCBzaG91bGQgYmUgcmVzdG9yZWQgdG8gdGhlIHNhbWUgdmFsdWUg
c2FtZSB2YWx1ZQo+PiBmb3IgdmlydHF1ZXVlcyB0aGF0IGNvbXBsZXRlIGluIG9yZGVyLCB3ZSBz
ZXQgdGhlIHNpbmdsZSB2YWx1ZSBwcm92aWRlZAo+PiBieSBzZXRfdnFfc3RhdGUoKS4gSW4gZ2V0
X3ZxX3N0YXRlKCkgd2UgcmV0dXJuIHRoZSB2YWx1ZSBvZiBoYXJkd2FyZQo+PiB1c2VkIGluZGV4
Lgo+Pgo+PiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIg
Zm9yIHN1cHBvcnRlZCBtbHg1IAo+PiBkZXZpY2VzIikKPj4gU2lnbmVkLW9mZi1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+Cj4gQWNrZWQtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4KCkknZCB0YWtlIGl0IGJhY2sgZm9yIHRoZSBtb21lbnQsIGFjY29yZGluZyB0
byBKYXNvbidzIGxhdGVzdCBjb21tZW50LiAKRGlzY3Vzc2lvbiBzdGlsbCBnb2luZy4KCj4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE3ICsrKystLS0t
LS0tLS0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIAo+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBpbmRleCBiOGU5
ZDUyNWQ2NmMuLmE1MWIwZjg2YWZlMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+PiBAQCAtMTE2OSw2ICsxMTY5LDcgQEAgc3RhdGljIHZvaWQgc3VzcGVuZF92cShzdHJ1Y3Qg
bWx4NV92ZHBhX25ldCAKPj4gKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDCoMKg
IG12cS0+YXZhaWxfaWR4ID0gYXR0ci5hdmFpbGFibGVfaW5kZXg7Cj4+ICvCoMKgwqAgbXZxLT51
c2VkX2lkeCA9IGF0dHIudXNlZF9pbmRleDsKPj4gwqAgfQo+PiDCoCDCoCBzdGF0aWMgdm9pZCBz
dXNwZW5kX3ZxcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPj4gQEAgLTE0MjYsNiArMTQy
Nyw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF92cV9zdGF0ZShzdHJ1Y3QgCj4+IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5W
QUw7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCArwqDCoMKgIG12cS0+dXNlZF9pZHggPSBzdGF0ZS0+
YXZhaWxfaW5kZXg7Cj4+IMKgwqDCoMKgwqAgbXZxLT5hdmFpbF9pZHggPSBzdGF0ZS0+YXZhaWxf
aW5kZXg7ClRoaXMgaXMgd2hlcmUgdGhpbmdzIHN0YXJ0cyBnZXR0aW5nIGludGVyZXN0aW5nLiBB
Y2NvcmRpbmcgdG8gSmFzb24sIHRoZSAKb3JpZ2luYWwgZXhwZWN0YXRpb24gb2YgdGhpcyBBUEkg
d291bGQgYmUgdG8gcmVzdG9yZSB0aGUgaW50ZXJuYWwgCmxhc3RfYXZhaWxfaW5kZXggaW4gdGhl
IGhhcmR3YXJlLiBXaXRoIE1lbGxhbm94IG5ldHdvcmsgdkRQQSBoYXJkd2FyZSAKaW1wbGVtZW50
YXRpb24sIHRoZXJlJ3Mgbm8gc3VjaCBsYXN0X2F2YWlsX2luZGV4IHRoaW5nIGluIHRoZSBoYXJk
d2FyZSAKYnV0IG9ubHkgYSBzaW5nbGUgbGFzdF91c2VkX2luZGV4IHJlcHJlc2VudGluZyBib3Ro
IGluZGljZXMsIHdoaWNoIApzaG91bGQgYWx3YXlzIGJlIHRoZSBzYW1lIGFuZCBpbiBzeW5jIHdp
dGggZWFjaCBvdGhlci4gU28gZnJvbSBtaWdyYXRpb24gCnBvaW50IG9mIHZpZXcsIGl0IGFwcGVh
cnMgbG9naWNhbCB0byByZXN0b3JlIHRoZSBzYXZlZCBsYXN0X2F2YWlsX2luZGV4IAp0byB0aGUg
bGFzdF91c2VkX2luZGV4IGluIHRoZSBoYXJkd2FyZSwgcmlnaHQ/IEJ1dCB3aGF0IGlzIHRoZSBw
b2ludCB0byAKcmVzdG9yZSBtdnEtPmF2YWlsX2lkeD8KCkFjdHVhbGx5LCB0aGlzIGNvZGUgcGF0
aCBpcyBiZWluZyByZXB1cnBvc2VkIHRvIGFkZHJlc3MgdGhlIGluZGV4IHJlc2V0IApwcm9ibGVt
IGluIHRoZSBkZXZpY2UgcmVzZXQgc2NlbmFyaW8uIFdoZXJlIHRoZSBtdnEtPmF2YWlsX2lkeCBh
bmQgCm12cS0+dXNlZF9pZHggYXJlIGJvdGggcmVzZXQgdG8gMCBvbmNlIGRldmljZSBpcyByZXNl
dC4gVGhpcyBpcyBhIGJpdCAKY3Jvc3NpbmcgdGhlIGJvdW5kYXJ5IHRvIG1lLgoKCj4+IMKgwqDC
oMKgwqAgcmV0dXJuIDA7Cj4+IMKgIH0KPj4gQEAgLTE0NDMsNyArMTQ0NSw3IEBAIHN0YXRpYyBp
bnQgbWx4NV92ZHBhX2dldF92cV9zdGF0ZShzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZGV2LCB1
MTYgaWR4LCBzdHJ1Y3QgdmRwYQo+PiDCoMKgwqDCoMKgwqAgKiB0aGF0IGNhcmVzIGFib3V0IGVt
dWxhdGluZyB0aGUgaW5kZXggYWZ0ZXIgdnEgaXMgc3RvcHBlZC4KPj4gwqDCoMKgwqDCoMKgICov
Cj4+IMKgwqDCoMKgwqAgaWYgKCFtdnEtPmluaXRpYWxpemVkKSB7Cj4+IC3CoMKgwqDCoMKgwqDC
oCBzdGF0ZS0+YXZhaWxfaW5kZXggPSBtdnEtPmF2YWlsX2lkeDsKPj4gK8KgwqDCoMKgwqDCoMKg
IHN0YXRlLT5hdmFpbF9pbmRleCA9IG12cS0+dXNlZF9pZHg7ClRoaXMgaXMgd2hlcmUgdGhlIGxh
c3RfdXNlZF9pbmRleCBnZXRzIGxvYWRlZCBmcm9tIHRoZSBoYXJkd2FyZSAod2hlbiAKZGV2aWNl
IGlzIHN0b3BwZWQpLgoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoMKgwqDC
oMKgIH0KPj4gwqAgQEAgLTE0NTIsNyArMTQ1NCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2dl
dF92cV9zdGF0ZShzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LCBzdHJ1Y3Qg
dmRwYQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbWx4NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQg
dG8gcXVlcnkgdmlydHF1ZXVlXG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7
Cj4+IMKgwqDCoMKgwqAgfQo+PiAtwqDCoMKgIHN0YXRlLT5hdmFpbF9pbmRleCA9IGF0dHIuYXZh
aWxhYmxlX2luZGV4Owo+PiArwqDCoMKgIHN0YXRlLT5hdmFpbF9pbmRleCA9IGF0dHIudXNlZF9p
bmRleDsKVGhpcyBjb2RlIHBhdGggbmV2ZXIgZ2V0cyBjYWxsZWQgZnJvbSB1c2Vyc3BhY2UgKHdo
ZW4gZGV2aWNlIGlzIHJ1bm5pbmcpLgoKLVNpd2VpCgo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+
PiDCoCB9Cj4+IMKgIEBAIC0xNTMyLDE2ICsxNTM0LDYgQEAgc3RhdGljIHZvaWQgdGVhcmRvd25f
dmlydHF1ZXVlcyhzdHJ1Y3QgCj4+IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+IMKgwqDCoMKgwqAg
fQo+PiDCoCB9Cj4+IMKgIC1zdGF0aWMgdm9pZCBjbGVhcl92aXJ0cXVldWVzKHN0cnVjdCBtbHg1
X3ZkcGFfbmV0ICpuZGV2KQo+PiAtewo+PiAtwqDCoMKgIGludCBpOwo+PiAtCj4+IC3CoMKgwqAg
Zm9yIChpID0gbmRldi0+bXZkZXYubWF4X3ZxcyAtIDE7IGkgPj0gMDsgaS0tKSB7Cj4+IC3CoMKg
wqDCoMKgwqDCoCBuZGV2LT52cXNbaV0uYXZhaWxfaWR4ID0gMDsKPj4gLcKgwqDCoMKgwqDCoMKg
IG5kZXYtPnZxc1tpXS51c2VkX2lkeCA9IDA7Cj4+IC3CoMKgwqAgfQo+PiAtfQo+PiAtCj4+IMKg
IC8qIFRPRE86IGNyb3NzLWVuZGlhbiBzdXBwb3J0ICovCj4+IMKgIHN0YXRpYyBpbmxpbmUgYm9v
bCBtbHg1X3ZkcGFfaXNfbGl0dGxlX2VuZGlhbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAKPj4gKm12
ZGV2KQo+PiDCoCB7Cj4+IEBAIC0xNzc3LDcgKzE3NjksNiBAQCBzdGF0aWMgdm9pZCBtbHg1X3Zk
cGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4+
IMKgwqDCoMKgwqAgaWYgKCFzdGF0dXMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1seDVfdmRw
YV9pbmZvKG12ZGV2LCAicGVyZm9ybWluZyBkZXZpY2UgcmVzZXRcbiIpOwo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+PiAtwqDCoMKgwqDCoMKgwqAgY2xlYXJf
dmlydHF1ZXVlcyhuZGV2KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1seDVfdmRwYV9kZXN0cm95
X21yKCZuZGV2LT5tdmRldik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5zdGF0
dXMgPSAwOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKyttdmRldi0+Z2VuZXJhdGlvbjsKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
