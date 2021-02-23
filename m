Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC46C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 19:36:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF2264E61
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 19:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF2264E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97E2E83BF3;
	Tue, 23 Feb 2021 19:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYuD5SKyQRAV; Tue, 23 Feb 2021 19:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C1C383B31;
	Tue, 23 Feb 2021 19:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5480CC000A;
	Tue, 23 Feb 2021 19:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67A96C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5578D4DDE9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N5U2MUamuBy9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:36:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDC1D44673
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 19:36:05 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NJUW29167720;
 Tue, 23 Feb 2021 19:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=65+iVLhJ5nlitb1iXhwgUDRKg8fiqShej4FrSlsUl40=;
 b=VH5+1C8GsRuwnWz7fcJcQvvOH0igHSwgUHss2bYl6djTvGj74zIGnS4eCJVAM9hTpXgz
 /pRxdlvP7Lt16QQjooRsUJLu8BgqmgrTewg3pvQix27HcJXDqDw/K9D4M0ANQk8oDAGG
 nL8QfBMJ6Jq+G4ghirprfk1452xtheBI1pG6Vo39/d9D4uLW9RuZoEObqA2AqF1woHtQ
 U8pO3XPsh6wI9FZAIsNfLjFaSlF3ZBuHPnZ6imFgrGXHJJWwrF1N15vfx+N+07nm0D3i
 Ra373UeTNsR0w+VYE6fTzzl49hgrewND8cO0YtgXdiZR7q6Fru8UYBhObZXaDXG48Xm1 uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 36ugq3ffkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Feb 2021 19:36:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NJUTTq023492;
 Tue, 23 Feb 2021 19:36:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
 by aserp3030.oracle.com with ESMTP id 36v9m51ktq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Feb 2021 19:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4PcMk/F2nPEPSBTL8YcUMPS7VwITjm+Nrzu0RbyiCI4MQ0lyoPxGEdPdDGBkpc92GoaR3k6zG12I/mhAyCcBvNY9IkmN2pS8e7V7wDQj00XNa9liX66jM9xL7altaBQr/Ct20Y/XTkQsUFtGSVwdJK48F7LdTmdIyzv354yFxXX/Dt3ahJ3pjg/hcGfeUgs8qhjhSYpsF09NXBiiTUwAXbxb5ZelVK0LyGr9/eogmhDCXJNMV/rLZ7DSK4sJM/ZZsd+7vsh4VzQiuzLZ0VBBonVlowYCTsmkm6vM2x6u0qCSm0xGSPPk5fqm1Sk1eCp4hC6eK+P8NpdxwnEIkR00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65+iVLhJ5nlitb1iXhwgUDRKg8fiqShej4FrSlsUl40=;
 b=EGiI0nulukGQZu791lzP0VN7hlBjpCC2UORSI/ek2GpW9T3Yoetda8B90Va3hqAmLyin4JIn96y2ph99AXp/FNpOJBhboWTaXxCRCSNiOiVWpGOFFrbspA1rn0lW/hptlQWqkAlCEfkNKDdIYXtAzDXaZ8iVvou2zP24YsCgQCEU3eo2FC3PkItbp+D6tjqi4aole+3c2KrL6p+CFa6GUQgYL2GU7gdBL9in3S/lTMFlYIGUGj93ih43QDqKJlS4wzgmtSYo4ZBkThk2ukms8UzZ9yVlaVF49EgxH5WmxhpYqS4g+Z8lN79WanJeEg9p5qXL5CJdp2rArGAd6CO2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65+iVLhJ5nlitb1iXhwgUDRKg8fiqShej4FrSlsUl40=;
 b=AJPp1t51+mSeaHqVev6H186XJRbErQ7kMzpn40gGn/E4Rt9Gk4w945hkXRGxmQ4MGkYoSN3RN5+G4WZPJFMmy9ctR5IUsQRlFbFSeAKbc5Vm6fwhhO7P7c7Pv8w45YXmmMWe7191F86anjuuu3Byq4aFakoFvN/E0PPmteBiNKc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BN8PR10MB3283.namprd10.prod.outlook.com (2603:10b6:408:d1::28)
 by BN6PR10MB1937.namprd10.prod.outlook.com (2603:10b6:404:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 23 Feb
 2021 19:36:01 +0000
Received: from BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::3dd4:e8fe:49e6:2fd3]) by BN8PR10MB3283.namprd10.prod.outlook.com
 ([fe80::3dd4:e8fe:49e6:2fd3%7]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 19:36:01 +0000
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
Date: Tue, 23 Feb 2021 11:35:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210223082536-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Originating-IP: [24.6.170.153]
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To BN8PR10MB3283.namprd10.prod.outlook.com
 (2603:10b6:408:d1::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.6.170.153) by
 SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.11 via Frontend
 Transport; Tue, 23 Feb 2021 19:36:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0642142c-7c7e-49c5-4478-08d8d832407f
X-MS-TrafficTypeDiagnostic: BN6PR10MB1937:
X-Microsoft-Antispam-PRVS: <BN6PR10MB1937C53CAFFE78B587A0780CB1809@BN6PR10MB1937.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5TaBG5XmgL2QkQbnJ9kejUk1tgfUzcLayNedNicwCNQr8CJje33rkrFqSWdZIhuuDkjsjmYKZrc/YCHMqY/XN8ADH/yxNoB5EeLZwuKEggJA7xGJ/LX9D/MzS3YH8BSmw3I2zi0UBHSDAGYTsXyJPN41SobhAyCHJ+G6TDK+T+EK83jxVMrsfvcOvGxLHSM4rCfd34lXQnvQ3ZKwB+Rk1dKseHEYqZ3U7qf7u9GirhMZ9H7cq6vYGv34nBNUv4JPSJOCQHoe6J813rIMCdRjp5/tw+PJ9WtSFWdabaSBAcvfC54kEnfYXQhy29ZN4bedzuZHk8DrjpAAdj5soDaT4L7h+J1XfYjfYa8r67d38r9L/XYKCyWlEYF1K1NoPMSOpd7b1e6uoU7zBIUsJi8IlspIJZyQGfvzLVRvXePKIysFHsYNx/JcWTkXih17qEZP3G0f1oRE8XCgR/9d8ta+XifhIrhvik9oSZikQvQDqOrDzXpwZiT6K9jGnmVnpIe+tIrw/u4xdeIOf+VJHaSyJ+LC7QyLVqaJb3tTfoGghtM5Osuyv3mzjy2fRmI1BwzWN8opoXo4qrkUVB+6C7fTU22xG0/d6BkEz/aGt5CV9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR10MB3283.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39850400004)(366004)(136003)(376002)(346002)(396003)(6666004)(53546011)(8676002)(66476007)(2906002)(110136005)(31686004)(26005)(86362001)(66946007)(16576012)(16526019)(186003)(66556008)(2616005)(316002)(956004)(4326008)(83380400001)(36756003)(6486002)(478600001)(5660300002)(31696002)(36916002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a29SYUZmUGtnMVU3QzNabk9KMFBjVEF2aGRMMHBCazZJMExBbzhoengwcmNW?=
 =?utf-8?B?NHg4Q2xrSFdPUGFLbkp3YVpvQ0NycUJuREtQQ2FVaHpiNE0wZWM4eWIwRWxk?=
 =?utf-8?B?TkhRelZ1TGZnRFNyODVIN1hQS1FxUEpHOTBnWVZMLzAyQ2R0cThIQUowdDJW?=
 =?utf-8?B?RU5JSXpWa0ZwK0dRdU1FZVdxY3ROaDV1c0pmM0REM2t5Si8xM3F0aW9JY1pw?=
 =?utf-8?B?Q3hjczZlVkZCUlk5RkZWbHowUXZpODJwZnhqRk9RMHFXZUFrWTg3OVRiWS9Y?=
 =?utf-8?B?K25nMDVqUDQ5d2pOYm9KOUZCd2plaHdDbXVCZE84TnNiY0FOMGtXVFNFY3k3?=
 =?utf-8?B?dE91OU9pd0gyeXgwalBYeXdGb00vVVFMamlsb2JLSFRhL0hkUFQ5NUN2V0sw?=
 =?utf-8?B?RmJmV0Y1VkR0a0dkSHRWQUFzZ2xhRXp5VEJUZDQ0MC9zK21oRXRvL0tJN2lU?=
 =?utf-8?B?RW1GWFkwT3drdHhCbmxYZFRIWWFObEZHa1pNL3VrcXZLN2lOenNRVWRYMW9o?=
 =?utf-8?B?YzJRQWpacmt0Z2NYSVU0d3hZQTJoVDBiUXkyaiswUm5aTER6OGRYRWpxM1l5?=
 =?utf-8?B?Ty9JWHFIbG40YlhEWkJzRTJvd2ozT0R0czlRZERNam9TKzFzUzhQaGp6Z2xM?=
 =?utf-8?B?MTc4TEI2b2FJY2JwZ1E0eEQxazRvdGp3VWxFbDZOemRKZmJKUzV5VThKSWMx?=
 =?utf-8?B?K2lRWFlMekhXc1JIalMxdUttTnBhQ2JWQzF6am9uR3pYcUM0bllITm54WUdi?=
 =?utf-8?B?QWpnODVJZkQ0Qm10R0JQcVp3elQ1NEdYNmwvZXNoQmsvekdVUitMVW56WDl0?=
 =?utf-8?B?U3RLYTAwck5mMzIzbmttU3hSK0NqVWRSSGJZcjBpNy9waUZSRVc5M0t5NXd5?=
 =?utf-8?B?MnZnUWVNN1gzSTU4akNIUUlmTTBORjQyMXBvckMrM2ExM0dDdnBqbHBrRm5x?=
 =?utf-8?B?eE9VVm95SFJJViszN1lLUVd2ZkxHK0dSSk44TUQzemtNeE1JT0VrQlp3cEd6?=
 =?utf-8?B?bnd2d2tqdWsvQmg0ZXRXd0svc1ZBeU8zN3poaGwxa202Tm5Ta0phRVRLWUpj?=
 =?utf-8?B?L2tmbGNpa0c0eXQ1c1d5SjU2ZjBoVWhpbGlIYTBjd0VGZ1laeTJGanJZUjNN?=
 =?utf-8?B?ZGtVTm91a3BHSlFUN1NYMWd6TzhWb2dkMzdIWnpCeCtacVQyOVFYVndmbEtY?=
 =?utf-8?B?RXkxcDM3SzlsaUk0ZFFsQ09LV1RoY1Q2WCtRb3dkTlB3NGNCbnZrKzFHaEdr?=
 =?utf-8?B?WmdDdEpyUTQ4M0l1SU1xdGFXclBSSExYTkY2MDg5emNnbXZvWDFuaVhaci9F?=
 =?utf-8?B?OTdOc3pCWGZQZmpOWGJZM0FwMmhxVHMybUhWRU93SWMwbXlQU0J1ZEhxYnQy?=
 =?utf-8?B?eXFzY0t1d3JOVkFGYzlwc0p1WVVLSURGTUN2cEFzem9GVS9vQm1pMHdETGQv?=
 =?utf-8?B?a3JrMCtwNXZ1OGZnVXd5MEZvM00wMVp1UkRNMFprM3VyNWViQ2piMGZIUU1T?=
 =?utf-8?B?VGZ5Q1ZuNTAzM3Bmelo0NnNUNnczaHdiZnFrcjN0OHo3aXpDSTcwZ2IzSmF4?=
 =?utf-8?B?MUtVRTR5WGE2dXNSTXNYV1ZFdFA4SU1wQ0NpZkJ0MUFhTjVLV3JiV1JrZXFy?=
 =?utf-8?B?aDVqeTFYcWhtcVFMd2ppZ1c5UEVLTVMvOWhDRTh6Sk5TMjRkN1VrK0Ewdlk4?=
 =?utf-8?B?WVFxeDI2QVNJbi94UUFEMHZtcjRYejAvaVArc2JYOVdlejlFZitEM2FvdFVG?=
 =?utf-8?Q?xXrrlBTNm6qQ1QElMrwTLSlsOqnC7sd5QXtQs+D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0642142c-7c7e-49c5-4478-08d8d832407f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3283.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 19:36:01.7520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBRdljOM/3y9JqKEd2qu6N6+nnpG+kfQSzXgMzO7T/R65y7QhRqEidDZjENPaXY/z24Ly9fbB/GGXcwZ8IXaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1937
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230163
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230163
Cc: netdev@vger.kernel.org, elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CgpPbiAyLzIzLzIwMjEgNToyNiBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFR1
ZSwgRmViIDIzLCAyMDIxIGF0IDEwOjAzOjU3QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IE9uIDIwMjEvMi8yMyA5OjEyIOS4iuWNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Cj4+PiBPbiAy
LzIxLzIwMjEgMTE6MzQgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+PiBPbiBNb24s
IEZlYiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+
PiBPbiAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+PiBDb21t
aXQgNDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2Vk
Cj4+Pj4+PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMg
dG8gcmVzZXQKPj4+Pj4+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vz
c2VkIGJlZm9yZSBmZWF0dXJlcwo+Pj4+Pj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhl
IHZlcmlmeV9taW5fZmVhdHVyZXMoKSBjaGVjawo+Pj4+Pj4gYW5kIGFsbG93IGZlYXR1cmVzIHJl
c2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+Cj4+Pj4+PiBJdCdzIHdvcnRoIG5vdGluZyB0
aGF0IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4+Pj4+PiBjb25maWcgc3Bh
Y2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+Pj4+Pj4gZmVh
dHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4+
Pj4+PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0
aGUgY29uZmlnCj4+Pj4+PiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4+
Pj4+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+Pj4+Pgo+Pj4+PiAiCj4+Pj4+
Cj4+Pj4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkgZXhp
c3RzIGlmCj4+Pj4+IFZJUlRJT19ORVRfRl9NVFUgaXMKPj4+Pj4gc2V0Lgo+Pj4+PiBUaGlzIGZp
ZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZSBkcml2ZXIgdG8gdXNlLgo+Pj4+
PiAiCj4+Pj4+Cj4+Pj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQgdGhpcz8KPj4+
Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4gQW5kIGFsc286Cj4+Pj4KPj4+PiBUaGUgZHJpdmVyIE1VU1Qg
Zm9sbG93IHRoaXMgc2VxdWVuY2UgdG8gaW5pdGlhbGl6ZSBhIGRldmljZToKPj4+PiAxLiBSZXNl
dCB0aGUgZGV2aWNlLgo+Pj4+IDIuIFNldCB0aGUgQUNLTk9XTEVER0Ugc3RhdHVzIGJpdDogdGhl
IGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZpY2UuCj4+Pj4gMy4gU2V0IHRoZSBEUklWRVIg
c3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dzIGhvdyB0byBkcml2ZSB0aGUKPj4+PiBkZXZp
Y2UuCj4+Pj4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRzLCBhbmQgd3JpdGUgdGhlIHN1YnNl
dCBvZiBmZWF0dXJlIGJpdHMKPj4+PiB1bmRlcnN0b29kIGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRv
IHRoZQo+Pj4+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSByZWFkIChi
dXQgTVVTVCBOT1Qgd3JpdGUpCj4+Pj4gdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9u
Cj4+Pj4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZv
cmUgYWNjZXB0aW5nIGl0Lgo+Pj4+IDUuIFNldCB0aGUgRkVBVFVSRVNfT0sgc3RhdHVzIGJpdC4g
VGhlIGRyaXZlciBNVVNUIE5PVCBhY2NlcHQgbmV3Cj4+Pj4gZmVhdHVyZSBiaXRzIGFmdGVyIHRo
aXMgc3RlcC4KPj4+PiA2LiBSZS1yZWFkIGRldmljZSBzdGF0dXMgdG8gZW5zdXJlIHRoZSBGRUFU
VVJFU19PSyBiaXQgaXMgc3RpbGwgc2V0Ogo+Pj4+IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2Vz
IG5vdAo+Pj4+IHN1cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBp
cyB1bnVzYWJsZS4KPj4+PiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVk
aW5nIGRpc2NvdmVyeSBvZiB2aXJ0cXVldWVzCj4+Pj4gZm9yIHRoZSBkZXZpY2UsIG9wdGlvbmFs
IHBlci1idXMgc2V0dXAsCj4+Pj4gcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2
aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlvbgo+Pj4+IHNwYWNlLCBhbmQgcG9wdWxhdGlvbiBv
ZiB2aXJ0cXVldWVzLgo+Pj4+IDguIFNldCB0aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRo
aXMgcG9pbnQgdGhlIGRldmljZSBpcyDigJxsaXZl4oCdLgo+Pj4+Cj4+Pj4KPj4+PiBzbyBhY2Nl
c3NpbmcgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFUVVJFU19PSyBpcyBhIHNwZWMgdmlvbGF0aW9u
LCByaWdodD8KPj4+IEl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlzIGNv
bW1pdCB0cmllcyB0byBhZGRyZXNzLiBJCj4+PiB0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vlc3Qgc3Rp
bGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgo+Pj4KPj4+IEhhdmluZyBzYWlkLCBhIHNlcGFyYXRl
IHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2ZXIKPj4+IGlzc3Vl
IHdoZXJlIHRoaXMgZGlzY3JlcGFuY3kgaXMgaW50cm9kdWNlZCB0byB2aXJ0bmV0X3ZhbGlkYXRl
KCkgKHNpbmNlCj4+PiBjb21taXQgZmUzNmNiZTA2NykuIEJ1dCBpdCdzIG5vdCB0ZWNobmljYWxs
eSByZWxhdGVkIHRvIHRoaXMgcGF0Y2guCj4+Pgo+Pj4gLVNpd2VpCj4+Cj4+IEkgdGhpbmsgaXQn
cyBhIGJ1ZyB0byByZWFkIGNvbmZpZyBzcGFjZSBpbiB2YWxpZGF0ZSwgd2Ugc2hvdWxkIG1vdmUg
aXQgdG8KPj4gdmlydG5ldF9wcm9iZSgpLgo+Pgo+PiBUaGFua3MKPiBJIHRha2UgaXQgYmFjaywg
cmVhZGluZyBidXQgbm90IHdyaXRpbmcgc2VlbXMgdG8gYmUgZXhwbGljaXRseSBhbGxvd2VkIGJ5
IHNwZWMuCj4gU28gb3VyIHdheSB0byBkZXRlY3QgYSBsZWdhY3kgZ3Vlc3QgaXMgYm9ndXMsIG5l
ZWQgdG8gdGhpbmsgd2hhdCBpcwo+IHRoZSBiZXN0IHdheSB0byBoYW5kbGUgdGhpcy4KVGhlbiBt
YXliZSByZXZlcnQgY29tbWl0IGZlMzZjYmUwNjcgYW5kIGZyaWVuZHMsIGFuZCBoYXZlIFFFTVUg
ZGV0ZWN0IApsZWdhY3kgZ3Vlc3Q/IFN1cHBvc2VkbHkgb25seSBjb25maWcgc3BhY2Ugd3JpdGUg
YWNjZXNzIG5lZWRzIHRvIGJlIApndWFyZGVkIGJlZm9yZSBzZXR0aW5nIEZFQVRVUkVTX09LLgoK
LVNpd2llCgo+Pj4+Cj4+Pj4+PiBSZWplY3RpbmcgcmVzZXQgdG8gMAo+Pj4+Pj4gcHJlbWF0dXJl
bHkgY2F1c2VzIGNvcnJlY3QgTVRVIGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8gbG9hZAo+Pj4+
Pj4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3MsIHJlbmRlcmluZyBpc3N1
ZXMgbGlrZQo+Pj4+Pj4gZ3Vlc3Qgc2hvd2luZyBpbmFjY3VyYXRlIE1UVSB2YWx1ZSwgb3IgZmFp
bHVyZSB0byByZWplY3QKPj4+Pj4+IG91dC1vZi1yYW5nZSBNVFUuCj4+Pj4+Pgo+Pj4+Pj4gRml4
ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvcgo+Pj4+Pj4g
c3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1
IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICDCoMKgIGRyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+Pj4+Pj4gIMKg
wqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNCBkZWxldGlvbnMoLSkKPj4+Pj4+
Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+
Pj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4gaW5kZXggN2Mx
Zjc4OS4uNTQwZGQ2NyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4+Pj4+PiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0YXRpYyB1NjQKPj4+Pj4+IG1seDVfdmRw
YV9nZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+Pj4+Pj4gIMKgwqDCoMKg
wqDCoCByZXR1cm4gbXZkZXYtPm1seF9mZWF0dXJlczsKPj4+Pj4+ICDCoMKgIH0KPj4+Pj4+IC1z
dGF0aWMgaW50IHZlcmlmeV9taW5fZmVhdHVyZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
LAo+Pj4+Pj4gdTY0IGZlYXR1cmVzKQo+Pj4+Pj4gLXsKPj4+Pj4+IC3CoMKgwqAgaWYgKCEoZmVh
dHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+Pj4gLcKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4+Pj4+IC0KPj4+Pj4+IC3CoMKgwqAgcmV0
dXJuIDA7Cj4+Pj4+PiAtfQo+Pj4+Pj4gLQo+Pj4+Pj4gIMKgwqAgc3RhdGljIGludCBzZXR1cF92
aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+Pj4gIMKgwqAgewo+Pj4+
Pj4gIMKgwqDCoMKgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4gQEAgLTE1NTgsMTggKzE1NTAsMTMgQEAg
c3RhdGljIGludAo+Pj4+Pj4gbWx4NV92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIHU2NAo+Pj4+Pj4gZmVhdHVyZXMpCj4+Pj4+PiAgwqDCoCB7Cj4+Pj4+PiAgwqDC
oMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+
Pj4+Pj4gIMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVf
dmRwYV9uZGV2KG12ZGV2KTsKPj4+Pj4+IC3CoMKgwqAgaW50IGVycjsKPj4+Pj4+ICDCoMKgwqDC
oMKgwqAgcHJpbnRfZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzLCB0cnVlKTsKPj4+Pj4+IC3CoMKg
wqAgZXJyID0gdmVyaWZ5X21pbl9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMpOwo+Pj4+Pj4gLcKg
wqDCoCBpZiAoZXJyKQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4+Pj4+PiAt
Cj4+Pj4+PiAgwqDCoMKgwqDCoMKgIG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcyA9IGZlYXR1
cmVzICYKPj4+Pj4+IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPj4+Pj4+ICDCoMKgwqDCoMKg
wqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBuZGV2LT5tdHUp
Owo+Pj4+Pj4gIMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1
dmRwYTE2KG12ZGV2LAo+Pj4+Pj4gVklSVElPX05FVF9TX0xJTktfVVApOwo+Pj4+Pj4gLcKgwqDC
oCByZXR1cm4gZXJyOwo+Pj4+Pj4gK8KgwqDCoCByZXR1cm4gMDsKPj4+Pj4+ICDCoMKgIH0KPj4+
Pj4+ICDCoMKgIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBh
X2RldmljZQo+Pj4+Pj4gKnZkZXYsIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpjYikKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
