Return-Path: <SRS0=mL0J=HW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC02C433E6
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:06:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B344864EBD
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B344864EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44E8684091
	for <virtualization@archiver.kernel.org>; Sat, 20 Feb 2021 02:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkt7c-IusY2H for <virtualization@archiver.kernel.org>;
	Sat, 20 Feb 2021 02:06:03 +0000 (UTC)
Received: by smtp1.osuosl.org (Postfix, from userid 1001)
	id 924D884083; Sat, 20 Feb 2021 02:05:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC50684078;
	Sat, 20 Feb 2021 02:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8623DC000B;
	Sat, 20 Feb 2021 02:05:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A397C0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 78B6086DC4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:05:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JzJPCUZiEB7z
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:05:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C67586CB3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Feb 2021 02:05:51 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K24mJu177098;
 Sat, 20 Feb 2021 02:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=st7i2WHxVrJvl9JIPgJ/2H8rocCuaZvXX4zS/l1tyQU=;
 b=qIOUoMI4sGIGEbkdw9K26I2RDP7DQReglKx+qWrmQFgsCNUZYMCvzRxTOdrABu9oRlEg
 VjNGkBxGorhjAe+G5HWDKb9d1vp43BnWnN2kTm+HIuSOk68wyolD9InAT52dYiWVT3WH
 1g40SVHGa99+JwUpDUyqq8tKq7plpTxRF6DbIeBFz0kGfyUKqybu6VIWIjABjSf/EWKs
 H6KzZouM08Bcrir8YqehHMQgMou39FaVAeIZkjyxd0jsHa1tn0mg7nwKuUOPHiT5WQSO
 vE8xA9pEXNPtiUwL1TYcikwmX4Wnov/6T9poCHKO7+T/MBkuQ+mqVJHLSeezAtG0fMY4 Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 36tqxb82hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Feb 2021 02:05:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K20M8f017333;
 Sat, 20 Feb 2021 02:05:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by aserp3020.oracle.com with ESMTP id 36prp3juyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Feb 2021 02:05:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUp3yykwKZrXBEdGlEhXyI9y9SFTCxIA05wE8JKE3ZuFgftirJ4PPgwKlSmrbuHGE/5+vpR+NTXBK/yeI2bRC7oSld8cFb59hCb9TkglBIGT0LHIJzdGtYW4vOjAh9c62fQ3I5bwgUU83Zio5QXa8VUzIYyM4+SekWjSrpxtRzE1J17GxBZslOCFcA4vUK/TDlRG0OYvydtl9U9JBuPBgMY0bz44RvsjeOTyRCj6LoS6pEpXOvY1Bml6Zt1rfK2Op9RTXPi4J5DqFkhyZ4UXkKHmQWqvBvXKPiV0N0Z489dTV8zcoZdvLE2mge8hlRs9lvFRSQk/bK6vCoJ6jgrMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7i2WHxVrJvl9JIPgJ/2H8rocCuaZvXX4zS/l1tyQU=;
 b=RGySxK3Mgu02HSlJ+13nsIQhPo6t2/zXAAWJmLBZ6YFAoGsALTR1MaexnvlOq1sVF/t+u9Lp+miZMW4hv5K7VLnPhShRZIjdPqgYP8Q4d771D9DBDPrhxBQLVfAF4DLYCDw+vDqpvkb61BZyogJp7eox0SqFxJ7SoWyM6xfzOopgprGMYePpCcERn7eiYYVOMJkNtVv3T9IZSPSJ4w1ccTnPp6RCvPpLf1iQfwktQ1+7n3XgwHNOu8hoZytVXmHgn/EkWTuLg+rQt9UwO3mAXPi97yv6edUf8LpPKZd/dlzlVWWE6c+zVice6rqOznIbUxz3csKDU0mufA+nUC6RPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7i2WHxVrJvl9JIPgJ/2H8rocCuaZvXX4zS/l1tyQU=;
 b=X3HQ9mW+xbcLBqfbn+rw3LwA3V8+UHDeSf5DuF9Qav0p9gz9KQwsezGZq4me3OO9hfzoS0o3qCkj3agQ3QYaGOtZztVBWunFNnmKTQzGn9Q7HGq73YWTBkLZebsy/mL/r4drLM6oTQqQ0otTvQ703Oo1KYyKhMB9oSP+237tllA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3430.namprd10.prod.outlook.com (2603:10b6:a03:8f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Sat, 20 Feb
 2021 02:05:45 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3868.029; Sat, 20 Feb 2021
 02:05:44 +0000
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
 <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
 <379d79ff-c8b4-9acb-1ee4-16573b601973@redhat.com>
 <20210209061232.GC210455@mtl-vdi-166.wap.labs.mlnx>
 <411ff244-a698-a312-333a-4fdbeb3271d1@redhat.com>
 <a90dd931-43cc-e080-5886-064deb972b11@oracle.com>
 <b749313c-3a44-f6b2-f9b8-3aefa2c2d72c@redhat.com>
 <24d383db-e65c-82ff-9948-58ead3fc502b@oracle.com>
 <740b4f73-c668-5e0e-5af2-ebea7528d7a2@redhat.com>
 <9243c03b-8490-523c-2b78-928d1bcb0ddd@oracle.com>
 <b2d18964-8cd6-6bb1-1995-5b966207046d@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <5cf5e0ad-efbb-dc37-8054-5c46722b87df@oracle.com>
Date: Fri, 19 Feb 2021 18:05:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <b2d18964-8cd6-6bb1-1995-5b966207046d@redhat.com>
Content-Language: en-US
X-Originating-IP: [73.189.186.83]
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (73.189.186.83) by
 BY5PR20CA0030.namprd20.prod.outlook.com (2603:10b6:a03:1f4::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Sat, 20 Feb 2021 02:05:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79cd5d4d-9029-4f80-e077-08d8d5440804
X-MS-TrafficTypeDiagnostic: BYAPR10MB3430:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3430149FEC54F3E1A8AA486FB1839@BYAPR10MB3430.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eNB1I1ewaaIJ1+iY4i3b+YugsZ3BOPl9P2KtxM17zeWwotEjZiURcsQLsqWlR/27odjNtNynuDYXb/XTSsnLvZinoPqqsLfugg2yhj3rkAu0te+FeoC44VtKIyT5VwCZ0TM6BWA+kAV02rnijgGPHT6uQT+vkI7jvAN9UpzRdz1W+Ke69DTpPjWeAqNcGcROkheG4a36sTP3G6zIHZGFfmnmXP4hWJTxiJf/w0dlg/Kokz9ebT/kHPduziVXvH++pH5tEVhQCZGn4TG/W/pGoLS+8AWgZ07piN9MmQrSphZBwpzRlGrkF/Ekxy/RcpE9thydZIboQoddMnGYAFe1r0AKfwQL+shhZBo0a7oBeROsDARQmWoJU9Od3q3FAI4wyduoXwzz9jhgKW0xCWBQd8POSmikQbS6j1Yl/wwxw354i1IJgICvpkxUrkIkLv120e7SxXjdSQyo+KrgMX1bl5ducb4OVmc080yVLRqDiKODixMGjLK/yoWF9cuXxt6Fl1BVhhqduCcKpbnQIKiegPZnKd3tFlvwl8cMlYV+iUEtwCfNfhO0XwgwIhWDUTwbLeDlkxRkr/8PUQWgjQZAbhAOxVZorIxqMuWRO0ww64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(136003)(39860400002)(396003)(346002)(66556008)(66946007)(66476007)(36916002)(4326008)(83380400001)(2906002)(86362001)(478600001)(36756003)(31686004)(316002)(8936002)(110136005)(30864003)(5660300002)(53546011)(956004)(26005)(16576012)(8676002)(16526019)(31696002)(6486002)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VVJYQXBBRTFYK3RHenNoTm1VV0tTUnBwYzNBRHNaOGVnUzRjQnNrcjdkbDRD?=
 =?utf-8?B?djlnNFhLWHl0dVRpRy9xaUVUTnJpdU9TSVJrelYvWWliZUhua1N5YzJvNVNB?=
 =?utf-8?B?VGthMTd5Q0djakUveCthRVUzNkxhZE1vc0IrZDVwQ1FKWVQxRksxU3RtRE8w?=
 =?utf-8?B?TnlITW1leEJUSVM2MzVSR2RNWTVXdUdtOXBXdENPQVRLMUxNTlBZZzBUa0lO?=
 =?utf-8?B?c2R3MnJiRGh5Ym5zZDNLL1hzVXZqVHpJWExFSVdMbTFrbm1lQnJQNDNFZXNj?=
 =?utf-8?B?YmpOSyt3Y3VydjlPNnY3L1hmcEwyRUZlYWpVUHlTWTd0RVoxb29wSVllYXJh?=
 =?utf-8?B?WlFKQ2htNlppNlk1bXhlaUF2Um1MM1hHR2Nvb1U3bVcycHNVYzN0NG1SQnM3?=
 =?utf-8?B?TGg5a2xjQjNUWUR6eVBOK3lraENaMHAyVDZzZ08vWjJXYXRZbHhvUnY1aER4?=
 =?utf-8?B?cWV3MUVyWitKUEx0OVF0WFU2R1lZeEhiM09xR2xnZnNhSTlEaFNia2FGMkEx?=
 =?utf-8?B?QjdNQTltcWpuYTh1YmtGbkd6cDdISE4wWm5pbDltUGRDTWg2R1BtVGU4LzBV?=
 =?utf-8?B?ZWcyK0Y2Z1orTk9xdlA0cFpSanY0a1BaTy9UL2svUzIzUXVjUlJrSkxDTVM2?=
 =?utf-8?B?aE1BclVTbGFIbUo1Z0IyOXFYNDFtVDE1dzdMZFlXb0dWL0k2VzRuM2FwVi9C?=
 =?utf-8?B?TFRVNElFV1N4Rk9xYU1tR2phbmlIN1ExeDAyT3liQTErUlM5UHNpbTdlcFhu?=
 =?utf-8?B?SXJTZHZneGUvUzQzZVRLamJzWSsvaXBnMGh0eGh5cXEydkd3NG9hdEdnMGxJ?=
 =?utf-8?B?K0VnSWxSbVIzZSttbmJQQ0NlYnQyNmZFUXdRMTFuKzYwYTJhZzhSRCttTk5U?=
 =?utf-8?B?dVgyUUxZNHk1ZnFDdy9mSkd3Ti9sZm5XZ2QyUnhoZUJnUFRJNk1pYVBWSkpJ?=
 =?utf-8?B?Wjg2NHhLV21ZUlU1TTB6Rm84TmNvaUZBRTN0VURZeXZqRy9yYkppUE1mUVdn?=
 =?utf-8?B?WVFTazlEZUNSdy91S1M0WWUyUmxuSCttSm0ra3VQSlVyU2dmdjlRaUtoaUR5?=
 =?utf-8?B?UlI0N014T21IWGJiU1ROblQ2RXp3clhaalY2aUYxL0oxSERkbUVsb1Yzd0VR?=
 =?utf-8?B?LzEwd2dteEdPN2FWdzkyWGF6Z3Z5bUVkZi96MzZyVFFnVWRKa1JQRWloWE43?=
 =?utf-8?B?cGVjU2RWcVdneXhKNnRUQ01Vc3JkZWZwTGFYbkJ4aWowMzlXcU9Ldm9YZFRO?=
 =?utf-8?B?dUFTVWplWER6dDk5dXpEMHBGUjJrNkh3elhySDY4M0NlZmVsSXF5bWVsOUxH?=
 =?utf-8?B?ZnUxdjU1OTY2QUthTU8rZklobi8zTGI1SHBDYzJaN09xeFZkaFY4ZHkxSG14?=
 =?utf-8?B?OW4wRDU0WHFxUk9KL1k3TUFGM29uampINFNpNGpvVUcwdnVJcXRaVFM1SEYv?=
 =?utf-8?B?MGNWNGdwRVpOQjBLVDlQejhIblRURWYvZlhGRy9xeDZGWFV2ZWFxYVZSK0hY?=
 =?utf-8?B?RGJkejd6aW13bENRUFlNWnRoYmdObkJZbzlqalJOSmVTVUtNQ1BHcW9hbzNl?=
 =?utf-8?B?aTZXRitlRGQwd1dWZ3ZFdFhIM3FDSkkxTmNiSE9tVzBFZnJUZ2Joby9iUHg1?=
 =?utf-8?B?YmtCMTNGWG1JTEZRblBiMDBuS1ZyanJBYzdOeTFWdmdhVm1IdVpUU2pycTZl?=
 =?utf-8?B?WUNSVnBhWGlycEl6UlZpSkdLS0tBaDFyQUZGdExKa1FXVk92TEtnWit6U24x?=
 =?utf-8?Q?ttoAhhRYtFwSM5DU3pOpGe2w/F6dkARfm6IpMq+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cd5d4d-9029-4f80-e077-08d8d5440804
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 02:05:44.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWSFO5Wyjf3R2mB+3o0c2RGJrbFA66d9haPPxHt3jLgsXASSbzHdHLRiAHyeyr4HyZxKO+a+6KqtnqmFNvS1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3430
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200014
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200015
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lulu@redhat.com, mst@redhat.com
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

CgpPbiAyLzE4LzIwMjEgNzoxMCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjEvMi8x
OCA4OjQzIOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4KPj4KPj4gT24gMi8xNy8yMDIxIDg6
NDQgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pgo+Pj4gT24gMjAyMS8yLzEwIOS4i+WNiDQ6NTks
IFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDIvOS8yMDIxIDc6NTMgUE0sIEph
c29uIFdhbmcgd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjEvMi8xMCDkuIrljYgxMDozMCwgU2kt
V2VpIExpdSB3cm90ZToKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gT24gMi84LzIwMjEgMTA6MzcgUE0s
IEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiAyMDIxLzIvOSDkuIvljYgyOjEy
LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+IE9uIFR1ZSwgRmViIDA5LCAyMDIxIGF0IDExOjIw
OjE0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+PiBPbiAyMDIxLzIvOCDkuIvl
jYg2OjA0LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gTW9uLCBGZWIgMDgsIDIwMjEg
YXQgMDU6MDQ6MjdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4+Pj4gT24gMjAy
MS8yLzgg5LiL5Y2IMjozNywgRWxpIENvaGVuIHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4gT24gTW9uLCBG
ZWIgMDgsIDIwMjEgYXQgMTI6Mjc6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+
Pj4+Pj4+PiBPbiAyMDIxLzIvNiDkuIrljYg3OjA3LCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+
Pj4+Pj4+PiBPbiAyLzMvMjAyMSAxMTozNiBQTSwgRWxpIENvaGVuIHdyb3RlOgo+Pj4+Pj4+Pj4+
Pj4+Pj4gV2hlbiBhIGNoYW5nZSBvZiBtZW1vcnkgbWFwIG9jY3VycywgdGhlIGhhcmR3YXJlIAo+
Pj4+Pj4+Pj4+Pj4+Pj4gcmVzb3VyY2VzIGFyZSBkZXN0cm95ZWQKPj4+Pj4+Pj4+Pj4+Pj4+IGFu
ZCB0aGVuIHJlLWNyZWF0ZWQgYWdhaW4gd2l0aCB0aGUgbmV3IG1lbW9yeSBtYXAuIEluIAo+Pj4+
Pj4+Pj4+Pj4+Pj4gc3VjaCBjYXNlLCB3ZSBuZWVkCj4+Pj4+Pj4+Pj4+Pj4+PiB0byByZXN0b3Jl
IHRoZSBoYXJkd2FyZSBhdmFpbGFibGUgYW5kIHVzZWQgaW5kaWNlcy4gVGhlIAo+Pj4+Pj4+Pj4+
Pj4+Pj4gZHJpdmVyIGZhaWxlZCB0bwo+Pj4+Pj4+Pj4+Pj4+Pj4gcmVzdG9yZSB0aGUgdXNlZCBp
bmRleCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
IEFsc28sIHNpbmNlIHRoZSBkcml2ZXIgYWxzbyBmYWlscyB0byByZXNldCB0aGUgYXZhaWxhYmxl
IAo+Pj4+Pj4+Pj4+Pj4+Pj4gYW5kIHVzZWQKPj4+Pj4+Pj4+Pj4+Pj4+IGluZGljZXMgdXBvbiBk
ZXZpY2UgcmVzZXQsIGZpeCB0aGlzIGhlcmUgdG8gYXZvaWQgCj4+Pj4+Pj4+Pj4+Pj4+PiByZWdy
ZXNzaW9uIGNhdXNlZCBieQo+Pj4+Pj4+Pj4+Pj4+Pj4gdGhlIGZhY3QgdGhhdCB1c2VkIGluZGV4
IG1heSBub3QgYmUgemVybyB1cG9uIGRldmljZSByZXNldC4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+PiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2
ZXIgZm9yIAo+Pj4+Pj4+Pj4+Pj4+Pj4gc3VwcG9ydGVkIG1seDUKPj4+Pj4+Pj4+Pj4+Pj4+IGRl
dmljZXMiKQo+Pj4+Pj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuPGVsaWNAbnZp
ZGlhLmNvbT4KPj4+Pj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+Pj4+Pj4gdjAgLT4gdjE6Cj4+
Pj4+Pj4+Pj4+Pj4+PiBDbGVhciBpbmRpY2VzIHVwb24gZGV2aWNlIHJlc2V0Cj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCAxOCAKPj4+Pj4+Pj4+Pj4+Pj4+ICsrKysrKysrKysrKysrKysrKwo+Pj4+Pj4+Pj4+
Pj4+Pj4gwqDCoCDCoCAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4+Pj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4+Pj4+Pj4+Pj4+Pj4+PiBpbmRleCA4OGRkZTM0NTViZmQuLmI1ZmU2ZDJhZDIyZiAx
MDA2NDQKPj4+Pj4+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+Pj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4+Pj4+Pj4+Pj4+Pj4+PiBAQCAtODcsNiArODcsNyBAQCBzdHJ1Y3QgbWx4NV92cV9yZXN0
b3JlX2luZm8gewo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHU2NCBkZXZpY2VfYWRk
cjsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCB1NjQgZHJpdmVyX2FkZHI7Cj4+Pj4+
Pj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgdTE2IGF2YWlsX2luZGV4Owo+Pj4+Pj4+Pj4+Pj4+
Pj4gK8KgwqDCoCB1MTYgdXNlZF9pbmRleDsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDC
oCBib29sIHJlYWR5Owo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBh
X2NhbGxiYWNrIGNiOwo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIGJvb2wgcmVzdG9y
ZTsKPj4+Pj4+Pj4+Pj4+Pj4+IEBAIC0xMjEsNiArMTIyLDcgQEAgc3RydWN0IG1seDVfdmRwYV92
aXJ0cXVldWUgewo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHUzMiB2aXJ0cV9pZDsK
Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRl
djsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCB1MTYgYXZhaWxfaWR4Owo+Pj4+Pj4+
Pj4+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pZHg7Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgwqDC
oMKgwqAgaW50IGZ3X3N0YXRlOwo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoCDCoMKgwqDCoMKgIC8q
IGtlZXAgbGFzdCBpbiB0aGUgc3RydWN0ICovCj4+Pj4+Pj4+Pj4+Pj4+PiBAQCAtODA0LDYgKzgw
Niw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1ZShzdHJ1Y3QgCj4+Pj4+Pj4+Pj4+Pj4+
PiBtbHg1X3ZkcGFfbmV0Cj4+Pj4+Pj4+Pj4+Pj4+PiAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92
aXJ0cXVlCj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgIMKgwqDCoMKgwqAgb2JqX2NvbnRleHQgPSAK
Pj4+Pj4+Pj4+Pj4+Pj4+IE1MWDVfQUREUl9PRihjcmVhdGVfdmlydGlvX25ldF9xX2luLCBpbiwK
Pj4+Pj4+Pj4+Pj4+Pj4+IG9ial9jb250ZXh0KTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKg
wqDCoCBNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgCj4+Pj4+Pj4+
Pj4+Pj4+PiBod19hdmFpbGFibGVfaW5kZXgsCj4+Pj4+Pj4+Pj4+Pj4+PiBtdnEtPmF2YWlsX2lk
eCk7Cj4+Pj4+Pj4+Pj4+Pj4+PiArwqDCoMKgIE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3Qs
IG9ial9jb250ZXh0LCAKPj4+Pj4+Pj4+Pj4+Pj4+IGh3X3VzZWRfaW5kZXgsCj4+Pj4+Pj4+Pj4+
Pj4+PiBtdnEtPnVzZWRfaWR4KTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBNTFg1
X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwKPj4+Pj4+Pj4+Pj4+Pj4+IHF1
ZXVlX2ZlYXR1cmVfYml0X21hc2tfMTJfMywKPj4+Pj4+Pj4+Pj4+Pj4+IGdldF9mZWF0dXJlc18x
Ml8zKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDC
oMKgwqDCoMKgIHZxX2N0eCA9IE1MWDVfQUREUl9PRih2aXJ0aW9fbmV0X3Ffb2JqZWN0LCAKPj4+
Pj4+Pj4+Pj4+Pj4+IG9ial9jb250ZXh0LAo+Pj4+Pj4+Pj4+Pj4+Pj4gdmlydGlvX3FfY29udGV4
dCk7Cj4+Pj4+Pj4+Pj4+Pj4+PiBAQCAtMTAyMiw2ICsxMDI1LDcgQEAgc3RhdGljIGludCBjb25u
ZWN0X3FwcyhzdHJ1Y3QgCj4+Pj4+Pj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0Cj4+Pj4+Pj4+Pj4+
Pj4+PiAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm0KPj4+Pj4+Pj4+Pj4+Pj4+
IMKgwqAgwqAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKg
wqDCoMKgwqAgdTggc3RhdGU7Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgdTE2IGF2
YWlsYWJsZV9pbmRleDsKPj4+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgdTE2IHVzZWRfaW5kZXg7Cj4+
Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgIH07Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgIMKgIHN0YXRp
YyBpbnQgcXVlcnlfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0IAo+Pj4+Pj4+Pj4+Pj4+
Pj4gKm5kZXYsIHN0cnVjdAo+Pj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZx
LAo+Pj4+Pj4+Pj4+Pj4+Pj4gQEAgLTEwNTIsNiArMTA1Niw3IEBAIHN0YXRpYyBpbnQgcXVlcnlf
dmlydHF1ZXVlKHN0cnVjdAo+Pj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX25ldCAqbmRldiwgc3Ry
dWN0IG1seDVfdmRwYV92aXJ0cXVldQo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIG1l
bXNldChhdHRyLCAwLCBzaXplb2YoKmF0dHIpKTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKg
wqDCoCBhdHRyLT5zdGF0ZSA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIAo+Pj4+Pj4+
Pj4+Pj4+Pj4gb2JqX2NvbnRleHQsIHN0YXRlKTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKg
wqDCoCBhdHRyLT5hdmFpbGFibGVfaW5kZXggPSAKPj4+Pj4+Pj4+Pj4+Pj4+IE1MWDVfR0VUKHZp
cnRpb19uZXRfcV9vYmplY3QsCj4+Pj4+Pj4+Pj4+Pj4+PiBvYmpfY29udGV4dCwgaHdfYXZhaWxh
YmxlX2luZGV4KTsKPj4+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgYXR0ci0+dXNlZF9pbmRleCA9IE1M
WDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIAo+Pj4+Pj4+Pj4+Pj4+Pj4gb2JqX2NvbnRleHQs
Cj4+Pj4+Pj4+Pj4+Pj4+PiBod191c2VkX2luZGV4KTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDC
oMKgwqDCoCBrZnJlZShvdXQpOwo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgIHJldHVy
biAwOwo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoCBAQCAtMTUzNSw2ICsxNTQwLDE2IEBAIHN0YXRp
YyB2b2lkIAo+Pj4+Pj4+Pj4+Pj4+Pj4gdGVhcmRvd25fdmlydHF1ZXVlcyhzdHJ1Y3QKPj4+Pj4+
Pj4+Pj4+Pj4+IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgwqDC
oMKgwqAgfQo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoCB9Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKg
ICtzdGF0aWMgdm9pZCBjbGVhcl92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0IAo+Pj4+
Pj4+Pj4+Pj4+Pj4gKm5kZXYpCj4+Pj4+Pj4+Pj4+Pj4+PiArewo+Pj4+Pj4+Pj4+Pj4+Pj4gK8Kg
wqDCoCBpbnQgaTsKPj4+Pj4+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgZm9y
IChpID0gbmRldi0+bXZkZXYubWF4X3ZxcyAtIDE7IGkgPj0gMDsgaS0tKSB7Cj4+Pj4+Pj4+Pj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgbmRldi0+dnFzW2ldLmF2YWlsX2lkeCA9IDA7Cj4+Pj4+Pj4+
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbmRldi0+dnFzW2ldLnVzZWRfaWR4ID0gMDsKPj4+Pj4+
Pj4+Pj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4+Pj4+Pj4+Pj4gK30KPj4+Pj4+Pj4+Pj4+Pj4+ICsK
Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqAgLyogVE9ETzogY3Jvc3MtZW5kaWFuIHN1cHBvcnQgKi8K
Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqAgc3RhdGljIGlubGluZSBib29sIAo+Pj4+Pj4+Pj4+Pj4+
Pj4gbWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IG1seDVfdmRwYV9kZXYKPj4+Pj4+
Pj4+Pj4+Pj4+ICptdmRldikKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqAgewo+Pj4+Pj4+Pj4+Pj4+
Pj4gQEAgLTE2MTAsNiArMTYyNSw3IEBAIHN0YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3Ry
dWN0Cj4+Pj4+Pj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBh
X3ZpcnRxdQo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVy
cjsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqAgwqDCoMKgwqDCoCByaS0+YXZhaWxfaW5kZXggPSBh
dHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgcmktPnVzZWRfaW5k
ZXggPSBhdHRyLnVzZWRfaW5kZXg7Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKgwqAgcmkt
PnJlYWR5ID0gbXZxLT5yZWFkeTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCByaS0+
bnVtX2VudCA9IG12cS0+bnVtX2VudDsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBy
aS0+ZGVzY19hZGRyID0gbXZxLT5kZXNjX2FkZHI7Cj4+Pj4+Pj4+Pj4+Pj4+PiBAQCAtMTY1NCw2
ICsxNjcwLDcgQEAgc3RhdGljIHZvaWQgCj4+Pj4+Pj4+Pj4+Pj4+PiByZXN0b3JlX2NoYW5uZWxz
X2luZm8oc3RydWN0Cj4+Pj4+Pj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+Pj4+
Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+Pj4+
Pj4+Pj4+Pj4+IMKgwqAgwqAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+YXZhaWxfaWR4ID0gcmkt
PmF2YWlsX2luZGV4Owo+Pj4+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG12cS0+dXNlZF9p
ZHggPSByaS0+dXNlZF9pbmRleDsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDC
oMKgIG12cS0+cmVhZHkgPSByaS0+cmVhZHk7Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgIMKgwqDCoMKg
wqDCoMKgwqDCoCBtdnEtPm51bV9lbnQgPSByaS0+bnVtX2VudDsKPj4+Pj4+Pj4+Pj4+Pj4+IMKg
wqAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+ZGVzY19hZGRyID0gcmktPmRlc2NfYWRkcjsKPj4+
Pj4+Pj4+Pj4+Pj4+IEBAIC0xNzY4LDYgKzE3ODUsNyBAQCBzdGF0aWMgdm9pZCAKPj4+Pj4+Pj4+
Pj4+Pj4+IG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdAo+Pj4+Pj4+Pj4+Pj4+Pj4gdmRwYV9k
ZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoCBp
ZiAoIXN0YXR1cykgewo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgbWx4
NV92ZHBhX2luZm8obXZkZXYsICJwZXJmb3JtaW5nIGRldmljZSAKPj4+Pj4+Pj4+Pj4+Pj4+IHJl
c2V0XG4iKTsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgwqDCoMKgwqDCoMKgwqDCoMKgIHRlYXJkb3du
X2RyaXZlcihuZGV2KTsKPj4+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBjbGVhcl92aXJ0
cXVldWVzKG5kZXYpOwo+Pj4+Pj4+Pj4+Pj4+PiBUaGUgY2xlYXJpbmcgbG9va3MgZmluZSBhdCB0
aGUgZmlyc3QgZ2xhbmNlLCBhcyBpdCBhbGlnbnMgCj4+Pj4+Pj4+Pj4+Pj4+IHdpdGggdGhlIG90
aGVyCj4+Pj4+Pj4+Pj4+Pj4+IHN0YXRlIGNsZWFudXBzIGZsb2F0aW5nIGFyb3VuZCBhdCB0aGUg
c2FtZSBwbGFjZS4gCj4+Pj4+Pj4+Pj4+Pj4+IEhvd2V2ZXIsIHRoZSB0aGluZyBpcwo+Pj4+Pj4+
Pj4+Pj4+PiBnZXRfdnFfc3RhdGUoKSBpcyBzdXBwb3NlZCB0byBiZSBjYWxsZWQgcmlnaHQgYWZ0
ZXIgdG8gCj4+Pj4+Pj4+Pj4+Pj4+IGdldCBzeW5jJ2VkIHdpdGgKPj4+Pj4+Pj4+Pj4+Pj4gdGhl
IGxhdGVzdCBpbnRlcm5hbCBhdmFpbF9pbmRleCBmcm9tIGRldmljZSB3aGlsZSB2cSBpcyAKPj4+
Pj4+Pj4+Pj4+Pj4gc3RvcHBlZC4gVGhlCj4+Pj4+Pj4+Pj4+Pj4+IGluZGV4IHdhcyBzYXZlZCBp
biB0aGUgZHJpdmVyIHNvZnR3YXJlIGF0IHZxIHN1c3BlbnNpb24sIAo+Pj4+Pj4+Pj4+Pj4+PiBi
dXQgYmVmb3JlIHRoZQo+Pj4+Pj4+Pj4+Pj4+PiB2aXJ0cSBvYmplY3QgaXMgZGVzdHJveWVkLiBX
ZSBzaG91bGRuJ3QgY2xlYXIgdGhlIAo+Pj4+Pj4+Pj4+Pj4+PiBhdmFpbF9pbmRleCB0b28gZWFy
bHkuCj4+Pj4+Pj4+Pj4+Pj4gR29vZCBwb2ludC4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
IFRoZXJlJ3MgYSBsaW1pdGF0aW9uIG9uIHRoZSB2aXJ0aW8gc3BlYyBhbmQgdkRQQSBmcmFtZXdv
cmsgCj4+Pj4+Pj4+Pj4+Pj4gdGhhdCB3ZSBjYW4gbm90Cj4+Pj4+Pj4+Pj4+Pj4gc2ltcGx5IGRp
ZmZlciBkZXZpY2Ugc3VzcGVuZGluZyBmcm9tIGRldmljZSByZXNldC4KPj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4gQXJlIHlvdSB0YWxraW5nIGFib3V0IGxpdmUgbWlncmF0aW9uIHdoZXJlIHlv
dSByZXNldCB0aGUgCj4+Pj4+Pj4+Pj4+PiBkZXZpY2UgYnV0Cj4+Pj4+Pj4+Pj4+PiBzdGlsbCB3
YW50IHRvIGtub3cgaG93IGZhciBpdCBwcm9ncmVzc2VkIGluIG9yZGVyIHRvIAo+Pj4+Pj4+Pj4+
Pj4gY29udGludWUgZnJvbSB0aGUKPj4+Pj4+Pj4+Pj4+IHNhbWUgcGxhY2UgaW4gdGhlIG5ldyBW
TT8KPj4+Pj4+Pj4+Pj4gWWVzLiBTbyBpZiB3ZSB3YW50IHRvIHN1cHBvcnQgbGl2ZSBtaWdyYXRp
b24gYXQgd2UgbmVlZDoKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gaW4gc3JjIG5vZGU6Cj4+Pj4+
Pj4+Pj4+IDEpIHN1c3BlbmQgdGhlIGRldmljZQo+Pj4+Pj4+Pj4+PiAyKSBnZXQgbGFzdF9hdmFp
bF9pZHggdmlhIGdldF92cV9zdGF0ZSgpCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IGluIHRoZSBk
c3Qgbm9kZToKPj4+Pj4+Pj4+Pj4gMykgc2V0IGxhc3RfYXZhaWxfaWR4IHZpYSBzZXRfdnFfc3Rh
dGUoKQo+Pj4+Pj4+Pj4+PiA0KSByZXN1bWUgdGhlIGRldmljZQo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+PiBTbyB5b3UgY2FuIHNlZSwgc3RlcCAyIHJlcXVpcmVzIHRoZSBkZXZpY2UvZHJpdmVyIG5v
dCB0byAKPj4+Pj4+Pj4+Pj4gZm9yZ2V0IHRoZQo+Pj4+Pj4+Pj4+PiBsYXN0X2F2YWlsX2lkeC4K
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBKdXN0IHRvIGJlIHN1cmUsIHdoYXQgcmVhbGx5IG1hdHRl
cnMgaGVyZSBpcyB0aGUgdXNlZCBpbmRleC4gCj4+Pj4+Pj4+Pj4gQmVjdWFzZSB0aGUKPj4+Pj4+
Pj4+PiB2cmlxdHVldWUgaXRzZWxmIGlzIGNvcGllZCBmcm9tIHRoZSBzcmMgVk0gdG8gdGhlIGRl
c3QgVk0uIAo+Pj4+Pj4+Pj4+IFRoZSBhdmFpbGFibGUKPj4+Pj4+Pj4+PiBpbmRleCBpcyBhbHJl
YXkgdGhlcmUgYW5kIHdlIGtub3cgdGhlIGhhcmR3YXJlIHJlYWRzIGl0IGZyb20gCj4+Pj4+Pj4+
Pj4gdGhlcmUuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gU28gZm9yICJsYXN0X2F2YWlsX2lkeCIgSSBt
ZWFudCB0aGUgaGFyZHdhcmUgaW50ZXJuYWwgYXZhaWwgCj4+Pj4+Pj4+PiBpbmRleC4gSXQncyBu
b3QKPj4+Pj4+Pj4+IHN0b3JlZCBpbiB0aGUgdmlydHF1ZXVlIHNvIHdlIG11c3QgbWlncmF0ZSBp
dCBmcm9tIHNyYyB0byBkZXN0IAo+Pj4+Pj4+Pj4gYW5kIHNldCB0aGVtCj4+Pj4+Pj4+PiB0aHJv
dWdoIHNldF92cV9zdGF0ZSgpLiBUaGVuIGluIHRoZSBkZXN0aW5hdGlvbiwgdGhlIHZpcnRxdWV1
ZSAKPj4+Pj4+Pj4+IGNhbiBiZQo+Pj4+Pj4+Pj4gcmVzdGFydGVkIGZyb20gdGhhdCBpbmRleC4K
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+IENvbnNpZGVyIHRoaXMgY2FzZTogZHJpdmVyIHBvc3RlZCBidWZm
ZXJzIHRpbGwgYXZhaWwgaW5kZXggCj4+Pj4+Pj4+IGJlY29tZXMgdGhlCj4+Pj4+Pj4+IHZhbHVl
IDUwLiBIYXJkd2FyZSBpcyBleGVjdXRpbmcgYnV0IG1hZGUgaXQgdGlsbCAyMCB3aGVuIAo+Pj4+
Pj4+PiB2aXJ0cXVldWUgd2FzCj4+Pj4+Pj4+IHN1c3BlbmRlZCBkdWUgdG8gbGl2ZSBtaWdyYXRp
b24gLSB0aGlzIGlzIGluZGljYXRlZCBieSBoYXJkd2FyZSAKPj4+Pj4+Pj4gdXNlZAo+Pj4+Pj4+
PiBpbmRleCBlcXVhbCAyMC4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gU28gaW4gdGhpcyBjYXNl
IHRoZSB1c2VkIGluZGV4IGluIHRoZSB2aXJ0cXVldWUgc2hvdWxkIGJlIDIwPyAKPj4+Pj4+PiBP
dGhlcndpc2Ugd2UgbmVlZCBub3Qgc3luYyB1c2VkIGluZGV4IGl0c2VsZiBidXQgYWxsIHRoZSB1
c2VkIAo+Pj4+Pj4+IGVudHJpZXMgdGhhdCBpcyBub3QgY29tbWl0dGVkIHRvIHRoZSB1c2VkIHJp
bmcuCj4+Pj4+Pgo+Pj4+Pj4gSW4gb3RoZXIgd29yZCwgZm9yIG1seDUgdmRwYSB0aGVyZSdzIG5v
IHN1Y2ggaW50ZXJuYWwgCj4+Pj4+PiBsYXN0X2F2YWlsX2lkeCBzdHVmZiBtYWludGFpbmVkIGJ5
IHRoZSBoYXJkd2FyZSwgcmlnaHQ/IAo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBGb3IgZWFjaCBkZXZpY2Ug
aXQgc2hvdWxkIGhhdmUgb25lIG90aGVyd2lzZSBpdCB3b24ndCB3b3JrIAo+Pj4+PiBjb3JyZWN0
bHkgZHVyaW5nIHN0b3AvcmVzdW1lLiBTZWUgdGhlIGNvZGVzIAo+Pj4+PiBtbHg1X3ZkcGFfZ2V0
X3ZxX3N0YXRlKCkgd2hpY2ggY2FsbHMgcXVlcnlfdmlydHF1ZXVlKCkgdGhhdCBidWlsZCAKPj4+
Pj4gY29tbWFuZHMgdG8gcXVlcnkgImxhc3RfYXZhaWxfaWR4IiBmcm9tIHRoZSBoYXJkd2FyZToK
Pj4+Pj4KPj4+Pj4gwqDCoMKgIE1MWDVfU0VUKGdlbmVyYWxfb2JqX2luX2NtZF9oZHIsIGNtZF9o
ZHIsIG9wY29kZSwgCj4+Pj4+IE1MWDVfQ01EX09QX1FVRVJZX0dFTkVSQUxfT0JKRUNUKTsKPj4+
Pj4gwqDCoMKgIE1MWDVfU0VUKGdlbmVyYWxfb2JqX2luX2NtZF9oZHIsIGNtZF9oZHIsIG9ial90
eXBlLCAKPj4+Pj4gTUxYNV9PQkpfVFlQRV9WSVJUSU9fTkVUX1EpOwo+Pj4+PiDCoMKgwqAgTUxY
NV9TRVQoZ2VuZXJhbF9vYmpfaW5fY21kX2hkciwgY21kX2hkciwgb2JqX2lkLCBtdnEtPnZpcnRx
X2lkKTsKPj4+Pj4gwqDCoMKgIE1MWDVfU0VUKGdlbmVyYWxfb2JqX2luX2NtZF9oZHIsIGNtZF9o
ZHIsIHVpZCwgCj4+Pj4+IG5kZXYtPm12ZGV2LnJlcy51aWQpOwo+Pj4+PiDCoMKgwqAgZXJyID0g
bWx4NV9jbWRfZXhlYyhuZGV2LT5tdmRldi5tZGV2LCBpbiwgc2l6ZW9mKGluKSwgb3V0LCAKPj4+
Pj4gb3V0bGVuKTsKPj4+Pj4gwqDCoMKgIGlmIChlcnIpCj4+Pj4+IMKgwqDCoCDCoMKgwqAgZ290
byBlcnJfY21kOwo+Pj4+Pgo+Pj4+PiDCoMKgwqAgb2JqX2NvbnRleHQgPSBNTFg1X0FERFJfT0Yo
cXVlcnlfdmlydGlvX25ldF9xX291dCwgb3V0LCAKPj4+Pj4gb2JqX2NvbnRleHQpOwo+Pj4+PiDC
oMKgwqAgbWVtc2V0KGF0dHIsIDAsIHNpemVvZigqYXR0cikpOwo+Pj4+PiDCoMKgwqAgYXR0ci0+
c3RhdGUgPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgc3RhdGUp
Owo+Pj4+PiDCoMKgwqAgYXR0ci0+YXZhaWxhYmxlX2luZGV4ID0gTUxYNV9HRVQodmlydGlvX25l
dF9xX29iamVjdCwgCj4+Pj4+IG9ial9jb250ZXh0LCBod19hdmFpbGFibGVfaW5kZXgpOwo+Pj4+
Pgo+Pj4+IEVsaSBzaG91bGQgYmUgYWJsZSB0byBjb3JyZWN0IG1lLCBidXQgdGhpcyBod19hdmFp
bGFibGVfaW5kZXggbWlnaHQgCj4+Pj4ganVzdCBiZSBhIGNhY2hlZCB2YWx1ZSBvZiB2aXJ0cXVl
dWUgYXZhaWxfaW5kZXggaW4gdGhlIG1lbW9yeSBmcm9tIAo+Pj4+IHRoZSBtb3N0IHJlY2VudCBz
eW5jLiAKPj4+Cj4+Pgo+Pj4gSXQgc2hvdWxkIG5vdCwgb3RoZXJ3aXNlIGl0IHdpbGwgYmUgYSBi
dWcuCj4+IFRoZSBod19hdmFpbGFibGVfaW5kZXggbm90IHNob3dpbmcgdGhlIGNvcnJlY3QgbGFz
dF9hdmFpbF9pbmRleCB2YWx1ZSAKPj4gaXMgdGVjaG5pY2FsbHkgYSBmaXJtd2FyZSBidWcsIGFz
IEVsaSBhbGx1ZGVkIHRvLiBUaGF0J3Mgd2h5IEkgaGFkIAo+PiB0aGUgb3JpZ2luYWwgcXVlc3Rp
b24gZm9yIGhvdyB0aGlzIGVudGlyZSBzeW5jaHJvbml6YXRpb24gc2NoZW1lIAo+PiBjb3VsZCB3
b3JrIGlmIGp1c3Qgc2F2aW5nIGFuZCByZXN0b3JpbmcgdGhpcyBjYWNoZWQgdmFsdWUuIEluIG15
IAo+PiBvYnNlcnZhdGlvbiwgdGhlIGh3X2F2YWlsYWJsZV9pbmRleCB3YXMgc2VlbiBmYXIgb2Zm
IGZyb20gdGhlIAo+PiBod191c2VkX2luZGV4IHBvc3QgdnEgc3VzcGVuc2lvbiwgSSBqdXN0IHBv
aW50ZWQgb3V0IHRoZSBmYWN0IHRoYXQgCj4+IHRoaXMgaGFyZHdhcmUgdmFsdWUgaXMgbmVpdGhl
ciBsYXN0X2F2YWlsX2lkeCBub3IgbGFzdF91c2VkX2lkeCB0aGF0IAo+PiBpcyB1c2VmdWwgdG8g
cmVwcmVzZW50IHZxIHN0YXRlLgo+Pgo+PiBIb3dldmVyLCB0aGUgY29yZSBxdWVzdGlvbiBJJ20g
aGF2aW5nIGlzIHNob3VsZCB3ZSBjYXJlIGFib3V0IGZpeGluZyAKPj4gdGhpcyBpbiB0aGUgZmly
bXdhcmUgaW50ZXJmYWNlIGxldmVsIChhY3R1YWxseSwgdGhlIGhhcmR3YXJlIAo+PiBpbXBsZW1l
bnRhdGlvbiksIG9yIHJhdGhlciwganVzdCBhcyBzYWlkLCBzb21lIGRldmljZXMgZS5nLiBuZXR3
b3JrIAo+PiBkZXZpY2UgY291bGQgbGl2ZSB3aXRoIHRoZSBzaW1wbGlmaWVkIGZvcm0gb2YgYXNz
dW1wdGlvbiAodXNlZF9pZHggCj4+ID09wqAgbGFzdF91c2VkX2lkeMKgID09IGxhc3RfYXZhaWxf
aWR4KSB3aGVyZSBwZW5kaW5nIHJlcXVlc3RzIGNhbiBiZSAKPj4gZHJhaW5lZCBhbmQgY29tcGxl
dGVkIGJlZm9yZSBkZXZpY2UgaXMgc3RvcHBlZCBvciBzdXNwZW5kZWQuIERlc3BpdGUgCj4+IG9m
IHdoYXQgZGV2aWNlIGJlaGF2aW9yIHdvdWxkIGJlIGV4cGVjdGVkIG9yIGRlZmluZWQgaW4gdGhl
IHZpcnRpbyAKPj4gc3BlYywgdGhlIGdldC9zZXRfdnFfc3RhdGUoKSBBUEkgc2hvdWxkIGhhdmUg
dmVyeSBjbGVhciBzZW1hbnRpY3M6IAo+PiB3aGV0aGVyIGJvdGggZm9ybXMgKGkuZS4gcmVzdG9y
ZSBlaXRoZXIgb25lIG9mIHVzZWRfaWR4IG9yIAo+PiBsYXN0X2F2YWlsX2lkeCBpcyBmaW5lKSBh
cmUgYWNjZXB0YWJsZSwgb3IgaXQgbmVlZHMgdG8gYmUgcmVsaWdpb3VzIAo+PiB0byByZXN0b3Jl
IHZxIHN0YXRlIHZpYSBsYXN0X2F2YWlsX2lkeCBvbmx5LiBJbiB0aGUgbGF0dGVyIGNhc2UsIGJv
dGggCj4+IHRoZSBtbHg1IHZkcGEgbmV0IGRyaXZlciBhbmQgdGhlIGZpcm13YXJlIGludGVyZmFj
ZSBuZWVkcyB0byBiZSBmaXhlZCAKPj4gdG8gYWNjb21tb2RhdGUgdGhlIHN0cmljdGVyIEFQSSBy
ZXF1aXJlbWVudC4KPj4KPj4gRldJVyBJIGRvbid0IHRoaW5rIG5ldHdvcmsgKEV0aGVybmV0KSBk
ZXZpY2Ugc2hvdWxkIGFsd2F5cyBhc3N1bWUgCj4+ICh1c2VkX2lkeCA9PcKgIGxhc3RfdXNlZF9p
ZHjCoCA9PSBsYXN0X2F2YWlsX2lkeCkgd2hpbGUgYmVpbmcgc3RvcHBlZCAKPj4gKHdlcmUgdGhl
cmUgdmlydGlvIFJETUEgZGV2aWNlIGluIHJlYWxpdHkgdGhpcyBhc3N1bXB0aW9uIHdvdWxkIGJy
ZWFrKTogCj4KPgo+IFJpZ2h0LCBpdCdzIHRoZSBjaG9pY2Ugb2YgZGV2aWNlIGFuZCBpdCB3b3Vs
ZCBiZSBtb3JlIGNvbXBsaWNhdGVkIGlmIAo+IHdlIGhhZCBkZXZpY2VzIHdpdGhvdXQgdGhpcyBh
c3N1bXB0aW9uLiBUaGUgbWFpbiBpc3N1ZSBpcyB3aHRoZXIgb3IgCj4gbm90IHdlIG5lZWQgdG8g
d2FpdCBmb3IgdGhlIGRyYWluIG9mIHRoZSByZXF1ZXN0IGFuZCBpZiBzdWNoIGRhcmluaW5nIAo+
IGNhbiBvbmx5IHRha2UgcmVhc29uYWJsZSB0aW1lIHRvIGZpbmlzaC4KPgo+Cj4+IGl0IGNvdWxk
IHdlbGwgZm9sbG93IHRoZSBnb2xkZW4gcnVsZXMgaW4gdmlydGlvIFMvVyBpbXBsZW1lbnRhdGlv
biB0byAKPj4gaGF2ZSBzZXBhcmF0ZSBsYXN0X3VzZWRfaWR4IGFuZCBsYXN0X2F2YWlsX2lkeCBp
biB0aGUgaGFyZHdhcmUsIHRoZW4gCj4+IGl0J2xsIGJlIDEwMCUgQVBJIGNvbXBsaWFudC4uIEJ1
dCB3ZSBrbm93IHRoYXQgc3VjaCBpbXBsZW1lbnRhdGlvbiBpcyAKPj4gdW5uZWNlc3NhcmlseSBj
b21wbGljYXRlZCBmb3IgRXRoZXJuZXQgZGV2aWNlLiBIZW5jZSBJIHRob3VnaHQgdGhlcmUgCj4+
IGNvdWxkIGJlIHNvcnQgb2YgcmVsaWVmcyBmb3Igc29tZSBkcml2ZXIvZGV2aWNlIGFuZCBpdCdz
IHRvdGFsbHkgdXAgCj4+IHRvIHRoZSBkZXZpY2UvZHJpdmVyIHRvIGNob29zZSB0aGUgaW1wbGVt
ZW50YXRpb24uCj4KPgo+IFllcywgdGhlIGN1cnJlbnQgQVBJIGxlYXZlcyB0aGUgcm9vbSBmb3Ig
bGFzdF91c2VkX2lkeCBidXQgd2UgbWF5IAo+IHN0aWxsIG5lZWQgdG8gbWlncmF0ZSB0aGUgaW5k
aWNlcyAoYXMgSSBtZW50aW9uZWQgYmVsb3cpLgo+Cj4KPj4KPj4+Cj4+Pgo+Pj4+IEkgZG91YnQg
aXQncyB0aGUgb25lIHlvdSB0YWxrZWQgYWJvdXQgaW4gc29mdHdhcmUgaW1wbGVtZW50YXRpb24u
Cj4+Pgo+Pj4KPj4+IEFjdHVhbGx5IG5vdCwgaXQncyBhIHZpcnRpbyBnZW5lcmFsIGlzc3VlOgo+
Pj4KPj4+IENvbnNpZGVyIHRoZXJlJ3Mgbm90IGluZGljZXMgd3JhcC4gQW5kOgo+Pj4gLSB1c2Vk
X2lkeCBpcyB0aGUgdXNlZCBpbmRleCBpbiB0aGUgdmlydHF1ZXVlCj4+PiAtIGxhc3RfdXNlZF9p
ZHggaXMgdGhlIHVzZWQgaW5kZXggbWFpbnRhaW5lZCBieSB0aGUgZGV2aWNlLCBpdCAKPj4+IHBv
aW50cyB0byB0aGUgbG9jYXRpb24gd2hlcmUgdG8gcHV0IHRoZSBuZXh0IGRvbmUgcmVxdWVzdHMg
dG8gdGhlIAo+Pj4gdXNlZF9yaW5nCj4+PiAtIGF2YWlsX2lkeCBpcyB0aGUgYXZhaWxhYmxlIGlu
ZGV4IGluIHRoZSB2aXJ0cXVldWUKPj4+IC0gbGFzdF9hdmFpbF9pZHggaXMgdGhlIGluZGV4IG1h
aW50YWluZWQgYnkgdGhlIGRldmljZSwgaXQgcG9pbnRzIHRvIAo+Pj4gdGhlIGxvY2F0aW9uIHdo
ZXJlIGRldmljZSBuZWVkIHRvIHJlYWQgZnJvbSB0aGUgYXZhaWxhYmxlLgo+Pj4KPj4+IFNvIGJh
c2NpYWxseSwgZnJvbSBkZXZpY2UgUE9WLCBpdCBvbmx5IGNhcmVzIHRoZSBidWZmZXIgdGhhdCBi
ZWxvbmcgCj4+PiB0byBpdHNlbGYgd2hpY2ggYXJlIFt1c2VkX2lkeCwgYXZhaWxfaWR4KS4gU28g
d2UgaGF2ZToKPj4+Cj4+PiBbdXNlZF9pZHgsIGxhc3RfdXNlZF9pZHgpIFRoZSByZXF1ZXN0cyB0
aGF0IGhhdmUgYmVlbiBjb21wbGV0ZWQgYnkgCj4+PiB0aGUgZGV2aWNlIGJ1dCBub3QgY29tcGxl
dGVkIHRvIHRoZSB1c2VkIHJpbmcgKG9yIGF0IGxlYXN0IHVzZWRfaWR4IAo+Pj4gaXMgbm90IHVw
ZGF0ZWQpLgo+Pj4gW2xhc3RfdXNlZF9pZHgsIGxhc3RfYXZhaWxfaWR4KSBUaGUgcmVxdWVzdHMg
dGhhdCBhcmUgYmVpbmcgCj4+PiBwcm9jZXNzZWQgYnkgdGhlIGRldmljZS4KPj4+IFtsYXN0X2F2
YWlsX2lkeCwgYXZhaWxfaWR4KSBUaGUgcmVxdWVzdHMgdGhhdCBhcmUgbWFkZSBhdmFpbGFibGUg
YnkgCj4+PiB0aGUgZHJpdmVyIGJ1dCBub3QgcHJvY2Vzc2VkIGJ5IHRoZSBkZXZpY2UuCj4+Pgo+
Pj4gRHVyaW5nIGRldmljZSBzdG9wL3N1c3BlbmQsIHRoZSBkZXZpY2Ugc2hvdWxkOgo+Pj4KPj4+
IC0gc3RvcCByZWFkaW5nIG5ldyByZXF1ZXN0IGZyb20gYXZhaWxhYmxlIHJpbmcgKG9yIHJlYWQg
dW50aWwgdGhlIAo+Pj4gZW5kIG9mIGRlc2NyaXB0b3IgY2hhaW4pCj4+PiAtIHN5bmMgdXNlZF9p
ZHggd2l0aCBsYXN0X3VzZWRfaWR4LiBPdGhlcndpc2Ugd2UgbmVlZCBhIGNvbXBsaWNhdGVkIAo+
Pj4gYnV0IG5vdCBuZWNlc3NhcnkgQVBJIHRvIHN5bmMgbGFzdF91c2VkX2lkeCBhbmQgdGhlIGlu
ZGljZXMgdGhhdCBhcmUgCj4+PiBub3QgY29tbWl0dGVkIHRvIHVzZWQgcmluZyAoc2luY2UgZGV2
aWNlIG1heSBjb21wbGV0ZSB0aGUgcmVxdWVzdCAKPj4+IG91dCBvZiBvcmRlcikKPj4+Cj4+PiBT
byB3ZSBrbm93IHVzZWRfaWR4ID09IGxhc3RfdXNlZF9pZHggaW4gdGhpcyBjYXNlLCBzbyB3ZSBo
YXZlOgo+Pj4KPj4+IFt1c2VkX2lkeC9sYXN0X3VzZWRfaWR4LCBsYXN0X2F2YWlsX2lkeCkgVGhl
IHJlcXVlc3RzIHRoYXQgYXJlIGJlaW5nIAo+Pj4gcHJvY2Vzc2VkLgo+Pj4gW2xhc3RfYXZhaWxf
aWR4LCBhdmFpbF9pZHgpIFRoZSByZXF1ZXN0cyB0aGF0IGFyZSBhdmFpbGFibGUgZm9yIHRoZSAK
Pj4+IGRyaXZlciBidXQgbm90IHlldCBwcm9jZXNzZWQuCj4+Pgo+Pj4gRm9yIG5ldHdvcmtpbmcg
ZGV2aWNlLCBpdCdzIHN1ZmZpY2llbnQgdG8gdGhpbmsgdGhlIHJlcXVlc3RzIGFyZSAKPj4+IGNv
bXBsZXRlZCB3aGVuIFRYL1JYIERNQSBhcmUgZmluaXNoZWQuIFNvIHRoZXJlJ3Mgbm8gcmVxdWVz
dHMgdGhhdCAKPj4+IGFyZSBiZWluZyBwcm9jZXNzZWQgYWZ0ZXIgdGhlIHN0b3AuIEluIHRoaXMg
Y2FzZSB3ZSBoYWQ6IHVzZWRfaWR4ID09IAo+Pj4gbGFzdF91c2VkX2lkeCA9PSBsYXN0X2F2YWls
X2lkeC4gVGhlbiB3ZSBvbmx5IGhhZDoKPj4+Cj4+PiBbdXNlZF9pZHgvbGFzdF91c2VkX2lkeC9s
YXN0X2F2YWlsX2lkeCwgYXZhaWxfaWR4XSBUaGUgcmVxdWVzdHMgdGhhdCAKPj4+IGFyZSBtYWRl
IGF2YWlsYWJsZSBieSB0aGUgZHJpdmVyIGJ1dCBub3QgcHJvY2Vzc2VkIGJ5IHRoZSBkZXZpY2Uu
IAo+Pj4gVGhhdCdzIHdoeSB5b3UgbWF5IHRoaW5rIG9ubHkgdXNlZF9pZHggbWF0dGVycyBoZXJl
Lgo+Pj4KPj4+IEZvciBibG9jayBkZXZpY2UsIHRoZSBjb21wbGV0aW9uIG9mIHRoZSByZXF1ZXN0
IG1pZ2h0IHJlcXVpcmUgdGhlIAo+Pj4gY29tbXVuaWNhdGlvbiB3aXRoIHRoZSByZW1vdGUgYmFj
a2VuZCwgc28gd2UgY2FuJ3QgYXNzdW1lIAo+Pj4gbGFzdF91c2VkX2lkeCBpcyBlcXVhbCB0byB0
aGUgbGFzdF9hdmFpbF9pZHguIFdoZXRoZXIgb3Igbm90IHRvIHdhaXQgCj4+PiBmb3IgdGhlIGRy
YWluIHRoZSByZXF1ZXN0IGlzIHN0aWxsIGJlaW5nIGRpc2N1c3NlZFsxXS4KPj4gSSBndWVzcyB0
aGlzIHJlcXVpcmVtZW50IGlzIHZlcnkgc3ViamVjdCB0byB0aGUgc3BlY2lmaWMgc3RvcmFnZSAK
Pj4gc2V0dXAgKG5ldHdvcmtlZCB2LnMuIGxvY2FsKSBpbmNsdWRpbmcgdGhlIGd1ZXN0IGFwcC9j
b25maWd1cmF0aW9uIAo+PiAocmV0cnkgdi5zLiB0aW1lIG91dCkuIElNSE8gdGhlcmUgc2hvdWxk
bid0IGJlIGEgZGVmaW5pdGUgeWVzLW9yLW5vIAo+PiBhbnN3ZXIgaGVyZS4gQnV0IGluIGdlbmVy
YWwsIGZvciByZXEtYWNrIHR5cGUgb2YgcmVxdWVzdCBpZiB0aGUgCj4+IGNvbXBsZXRpb24gKGFj
aykgY2Fubm90IHNpbXBseSByZXBsaWNhdGUgYWNyb3NzIGxpdmUgbWlncmF0aW9uLCBpdCAKPj4g
c2hvdWxkIHdhaXQgdW50aWwgdGhlIHBlbmRpbmcgcmVxdWVzdHMgYXJlIGNvbXBsZXRlbHkgZHJh
aW5lZC4KPgo+Cj4gWWVzLCBhbmQgcWVtdSBtYXkgZmFpbCB0aGUgbWlnYXJ0aW9uIGlmIHRoZSBw
ZW5kaW5nIHJlcXVldHMgdGFrZXMgdG9vIAo+IGxvbmcgdG8gYmUgZHJhaW5lZCwgdGhhdCdzIHdo
eSBhbiBhc3luY2hvcm5vdXMgQVBJIGlzIGludHJvZHVjZWQgaW4gWzFdLgoKSnVzdCBjdXJpb3Vz
LCB3aGF0IGlzIHRoZSBsaW5rIGZvciBbMV0/IFNvcnJ5LCBJIGRvbid0IGZpbmQgaXQgaW4geW91
ciAKcHJldmlvdXMgcmVwbHkuCgo+Cj4KPj4KPj4+Cj4+PiBTbyB5b3UgY2FuIHNlZSwgZm9yIGFs
bCB0aGUgY2FzZXMsIHdoYXQgcmVhbGx5IG1hdHRlcnMgaXMgdGhlIAo+Pj4gbGFzdF9hdmFpbF9p
ZHguIFRoZSBkZXZpY2Ugc2hvdWxkIGtub3cgd2hlcmUgaXQgbmVlZCB0byBzdGFydCAKPj4+IHJl
YWRpbmcgZm9yIHRoZSBuZXh0IHJlcXVlc3QsIGFuZCBpdCBpcyBub3QgbmVjZXNzYXJpbHkgZXF1
YWwgdG8gCj4+PiBsYXN0X3VzZWRfaWR4IG9yIHVzZWRfaWR4LiBXaGF0IG1ha2VzIHRoaW5ncyBh
IGxpdHRsZSBiaXQgZWFzaWVyIGlzIAo+Pj4gdGhlIG5ldHdvcmtpbmcgZGV2aWNlIHdob3NlIGxh
c3RfdXNlZF9pZHggaXMgZXF1YWwgdG8gbGFzdF9hdmFpbF9pZHguCj4+Pgo+Pj4KPj4+PiBJZiBJ
IHVuZGVyc3RhbmQgRWxpIGNvcnJlY3RseSwgaGFyZHdhcmUgd2lsbCBhbHdheXMgcmVsb2FkIHRo
ZSAKPj4+PiBsYXRlc3QgYXZhaWxfaW5kZXggZnJvbSBtZW1vcnkgd2hlbmV2ZXIgaXQncyBiZWlu
ZyBzeW5jJ2VkIGFnYWluLgo+Pj4+Cj4+Pj4gPHF1b3RlPgo+Pj4+IFRoZSBoYXJkd2FyZSBhbHdh
eXMgZ29lcyB0byByZWFkIHRoZSBhdmFpbGFibGUgaW5kZXggZnJvbSBtZW1vcnkuIAo+Pj4+IFRo
ZSByZXF1aXJlbWVudCB0byBjb25maWd1cmUgaXQgd2hlbiBjcmVhdGluZyBhIG5ldyBvYmplY3Qg
aXMgc3RpbGwgCj4+Pj4gYSByZXF1aXJlbWVudCBkZWZpbmVkIGJ5IHRoZSBpbnRlcmZhY2Ugc28g
SSBtdXN0IG5vdCB2aW9sYXRlIAo+Pj4+IGludGVyZmFjZSByZXF1aXJtZW50cy4KPj4+PiA8L3F1
b3RlPgo+Pj4+Cj4+Pj4gSWYgdGhlIGhhcmR3YXJlIGRvZXMgZXZlcnl0aGluZyBwZXJmZWN0bHkg
dGhhdCBpcyBhYmxlIHRvIGZsdXNoIAo+Pj4+IHBlbmRpbmcgcmVxdWVzdHMsIHVwZGF0ZSBkZXNj
cmlwdG9ycywgcmluZ3MgcGx1cyB1c2VkIGluZGljZXMgYWxsIAo+Pj4+IGF0IG9uY2UgYmVmb3Jl
IHRoZSBzdXNwZW5zaW9uLCB0aGVyZSdzIG5vIG5lZWQgZm9yIGhhcmR3YXJlIHRvIAo+Pj4+IG1h
aW50YWluIGEgc2VwYXJhdGUgaW50ZXJuYWwgaW5kZXggdGhhbiB0aGUgaC93IHVzZWRfaW5kZXgu
IFRoZSAKPj4+PiBoYXJkd2FyZSBjYW4gZ2V0IHN0YXJ0ZWQgZnJvbSB0aGUgc2F2ZWQgdXNlZF9p
bmRleCB1cG9uIHJlc3VtaW5nLiBJIAo+Pj4+IHZpZXcgdGhpcyBpcyBvZiAoaGFyZHdhcmUpIGlt
cGxlbWVudGF0aW9uIGNob2ljZXMgYW5kIHRob3VnaHQgaXQgCj4+Pj4gZG9lcyBub3QgdmlvbGF0
ZSB0aGUgdmlydGlvIHNwZWM/Cj4+Pgo+Pj4KPj4+IFllcywgYnV0IGFzIHlvdSBzYWlkLCBpdCBo
YXMgYSBsb3Qgb2YgYXNzdW1wdGlvbnMgd2hpY2ggbWF5IG5vdCB3b3JrIAo+Pj4gZm9yIG90aGVy
IHR5cGUgb2YgZGV2aWNlcy4gU28gd2hhdCBJIHJlZmVyICJsYXN0X2F2YWlsX2lkeCIgaXMgCj4+
PiBwcm9iYWJseSB0aGUgInVzZWRfaWR4IiBpbiB5b3VyIGRlc2NyaXB0aW9uIGhlcmUuIEl0IG1p
Z2h0IGJlIHRoZSAKPj4+IHNhbWUgaW4gdGhpcyBjYXNlIGZvciBuZXR3b3JraW5nIGRldmljZS4K
Pj4+Cj4+Pgo+Pj4+Cj4+Pj4KPj4+Pj4KPj4+Pj4KPj4+Pj4KPj4+Pj4+IEFuZCB0aGUgdXNlZF9p
ZHggaW4gdGhlIHZpcnRxdWV1ZSBpcyBhbHdheXMgaW4gc3luYyB3aXRoIHRoZSAKPj4+Pj4+IGhh
cmR3YXJlIHVzZWRfaW5kZXgsIGFuZCBoYXJkd2FyZSBpcyBzdXBwb3NlZCB0byBjb21taXQgcGVu
ZGluZyAKPj4+Pj4+IHVzZWQgYnVmZmVycyB0byB0aGUgcmluZyB3aGlsZSBidW1waW5nIHVwIHRo
ZSBoYXJkd2FyZSB1c2VkX2luZGV4IAo+Pj4+Pj4gKGFuZCBhbHNvIGNvbW1pdHRlZCB0byBtZW1v
cnkpIGFsdG9nZXRoZXIgcHJpb3IgdG8gc3VzcGVuc2lvbiwgaXMgCj4+Pj4+PiBteSB1bmRlcnN0
YW5kaW5nIGNvcnJlY3QgaGVyZT8gRG91YmxlIGNoZWNraW5nIGlmIHRoaXMgaXMgdGhlIAo+Pj4+
Pj4gZXhwZWN0ZWQgc2VtYW50aWNzIG9mIHdoYXQgCj4+Pj4+PiBtb2RpZnlfdmlydHF1ZXVlKE1M
WDVfVklSVElPX05FVF9RX09CSkVDVF9TVEFURV9TVVNQRU5EKSBzaG91bGQgCj4+Pj4+PiBhY2hp
ZXZlLgo+Pj4+Pj4KPj4+Pj4+IElmIHRoZSBhYm92ZSBpcyB0cnVlLCB0aGVuIGl0IGxvb2tzIHRv
IG1lIGZvciBtbHg1IHZkcGEgd2Ugc2hvdWxkIAo+Pj4+Pj4gcmVhbGx5IHJldHVybiBoL3cgdXNl
ZF9pZHggcmF0aGVyIHRoYW4gdGhlIGxhc3RfYXZhaWxfaWR4IHRocm91Z2ggCj4+Pj4+PiBnZXRf
dnFfc3RhdGUoKSwgaW4gb3JkZXIgdG8gcmVjb25zdHJ1Y3QgdGhlIHZpcnQgcXVldWUgc3RhdGUg
cG9zdCAKPj4+Pj4+IGxpdmUgbWlncmF0aW9uLiBGb3IgdGhlIHNldF9tYXAgY2FzZSwgdGhlIGlu
dGVybmFsIGxhc3RfYXZhaWxfaWR4IAo+Pj4+Pj4gcmVhbGx5IGRvZXNuJ3QgbWF0dGVyLCBhbHRo
b3VnaCBib3RoIGluZGljZXMgYXJlIHNhdmVkIGFuZCAKPj4+Pj4+IHJlc3RvcmVkIHRyYW5zcGFy
ZW50bHkgYXMtaXMuCj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFJpZ2h0LCBhIHN1YnRsZSB0aGluZyBoZXJl
IGlzIHRoYXQ6IGZvciB0aGUgZGV2aWNlIHRoYXQgbWlnaHQgaGF2ZSAKPj4+Pj4gY2FuJ3Qgbm90
IGNvbXBsZXRlIGFsbCB2aXJ0cXVldWUgcmVxdWVzdHMgZHVyaW5nIHZxIHN1c3BlbmRpbmcsIAo+
Pj4+PiB0aGUgImxhc3RfYXZhaWxfaWR4IiBtaWdodCBub3QgYmUgZXF1YWwgdG8gdGhlIGhhcmR3
YXJlIHVzZWRfaWR4LiAKPj4+Pj4gVGhpbmcgbWlnaHQgYmUgdHJ1ZSBmb3IgdGhlIHN0b3JhZ2Ug
ZGV2aWNlcyB0aGF0IG5lZWRzIHRvIGNvbm5lY3QgCj4+Pj4+IHRvIGEgcmVtb3RlIGJhY2tlbmQu
IEJ1dCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBvZiBuZXR3b3JraW5nIAo+Pj4+PiBkZXZpY2UsIHNv
IGxhc3RfYXZhaWxfaWR4IHNob3VsZCBiZSBlcXVhbCB0byBoYXJkd2FyZSB1c2VkX2lkeCBoZXJl
LiAKPj4+PiBFbGksIHNpbmNlIGl0J3MgeW91ciBoYXJkd2FyZSwgZG9lcyBpdCB3b3JrIHRoaXMg
d2F5PyBpLmUuIGRvZXMgdGhlIAo+Pj4+IGZpcm13YXJlIGludGVyZmFjZSBzZWUgYSBjYXNlIHdo
ZXJlIHZpcnRxdWV1ZSByZXF1ZXN0cyBjYW4ndCBiZSAKPj4+PiBjb21wbGV0ZWQgYmVmb3JlIHN1
c3BlbmRpbmcgdnE/Cj4+Pgo+Pj4KPj4+IEZvciBzdG9yYWdlIGRldmljZSwgSSB0aGluayBpdCBj
YW4gaGFwcGVuLgo+Pj4KPj4+Cj4+Pj4KPj4+Pj4gQnV0IHVzaW5nIHRoZSAibGFzdF9hdmFpbF9p
ZHgiIG9yIGhhcmR3YXJlIGF2YWlsX2lkeCBzaG91bGQgYWx3YXlzIAo+Pj4+PiBiZSBiZXR0ZXIg
aW4gdGhpcyBjYXNlIHNpbmNlIGl0J3MgZ3VhcmFudGVlZCB0byBjb3JyZWN0IGFuZCB3aWxsIAo+
Pj4+PiBoYXZlIGxlc3MgY29uZnVzaW9uLiBXZSB1c2UgdGhpcyBjb252ZW50aW9uIGluIG90aGVy
IHR5cGVzIG9mIAo+Pj4+PiB2aG9zdCBiYWNrZW5kcyAodmhvc3Qta2VybmVsLCB2aG9zdC11c2Vy
KS4KPj4+Pj4KPj4+Pj4gU28gbG9va2luZyBhdCBtbHg1X3NldF92cV9zdGF0ZSgpLCBpdCBwcm9i
YWJseSB3b24ndCB3b3JrIHNpbmNlIGl0IAo+Pj4+PiBkb2Vzbid0IG5vdCBzZXQgZWl0aGVyIGhh
cmR3YXJlIGF2YWlsX2lkeCBvciBoYXJkd2FyZSB1c2VkX2lkeDoKPj4+PiBUaGUgc2F2ZWQgbXZx
LT5hdmFpbF9pZHggd2lsbCBiZSB1c2VkIHRvIHJlY3JlYXRlIGhhcmR3YXJlIHZpcnRxIAo+Pj4+
IG9iamVjdCBhbmQgdGhlIHVzZWQgaW5kZXggaW4gY3JlYXRlX3ZpcnRxdWV1ZSgpLCBvbmNlIHN0
YXR1cyAKPj4+PiBEUklWRVJfT0sgaXMgc2V0LiBJIHN1c3BlY3Qgd2Ugc2hvdWxkIHBhc3MgdGhl
IGluZGV4IHRvIAo+Pj4+IG12cS0+dXNlZF9pZHggaW4gbWx4NV92ZHBhX3NldF92cV9zdGF0ZSgp
IGJlbG93IGluc3RlYWQuCj4+Pj4KPj4+Cj4+PiBJdCBkZXBlbmRzIG9uIHdoYXQgZGlkIG12cS0+
dXNlZF9pZHggbWVhbnQ/IElmIGl0J3MgbGFzdF91c2VkX2lkeCwgCj4+PiBpdCBzaG91bGQgYmUg
dGhlIHNhbWUgd2l0aCBtdnEtPmF2YWlsX2lkeCBmb3IgbmV0d29ya2luZyBkZXZpY2UuCj4+IEl0
J3MgdGhlIGxhc3RfdXNlZF9pZHguIE5vdGUsIEVsaSBhbHJlYWR5IHBvc3RlZCBhIHBhdGNoICgi
dmRwYS9tbHg1OiAKPj4gRml4IHN1c3BlbmQvcmVzdW1lIGluZGV4IHJlc3RvcmF0aW9uIikgdG8g
cmVwdXJwb3NlIHNldF92cV9zdGF0ZSgpIHRvIAo+PiByZXN0b3JlIGJvdGggdXNlZF9pZHggYW5k
IGF2YWlsX2lkeCAoYm90aCBpbmRpY2VzIHNob3VsZCBiZSAKPj4gY29uY2VwdHVhbGx5IGVxdWFs
IGluIHRoYXQgZGV2aWNlIG1vZGVsKSBhY3Jvc3MgcmVzZXQuIAo+Cj4KPiBXaWxsIGNoZWNrLCBi
dXJyaWVkIGJ5IG1haWxzIDooCgpVbmRlcnN0b29kLiBXaWxsIHBvaW50IHlvdSB0byB0aGUgZXhh
Y3QgZW1haWwgc2hvd2luZyB0aGUgY29kZSBjaGFuZ2UuCgo+Cj4KPj4gV2hpY2ggaW1wbGllcyB0
aGUgc2ltcGxpZmllZCBhc3N1bXB0aW9uIEkgbWVudGlvbmVkIGVhcmxpZXIuIFRoZSAKPj4gcmVx
dWlyZW1lbnQgb2Ygc2V0X3ZxX3N0YXRlKCkgQVBJIHNob3VsZCBtYWtlIGl0IGNsZWFyIGlmIHRo
aXMga2luZCAKPj4gb2YgYXNzdW1wdGlvbiBpcyBhY2NlcHRhYmxlLgo+Cj4KPiBSaWdodCBub3cg
dGhlIHZhbHVlIGlzIGV4cG9zZWQgdG8gdXNlcnNwYWNlIHZpYSBHRVRfVlJJTkdfQkFTRSwgc28g
Cj4gb25seSBsYXN0X2F2YWlsX2lkeCBpcyBzeW5jZWQuIElmIHdlIG5lZWQgc3luYyBsYXN0X3Vz
ZWRfaWR4LCB3ZSAKPiBzaG91bGQgYWxzbyBzeW5jIHBlbmRpbmcgaW5kaWNlcyB3aGljaCByZXF1
aXJlcyBtb3JlIHRob3VnaHRzLgpUZWNobmljYWxseSBpdCBkb2Vzbid0IHNvdW5kIHJpZ2h0IC0g
Y3Jvc3NpbmcgdGhlIGJvdW5kYXJ5IGEgYml0IGV2ZW4gCndpdGggc2ltcGxpZmllZCBmb3JtIG9m
IGFzc3VtcHRpb24uIEJ1dCBkZXBlbmRpbmcgb24gaG93IHVzZXJzcGFjZSBjb3VsZCAKbWFrZSB1
c2Ugb2YgdGhpcyBBUEksIGl0IGRvZXNuJ3Qgc2VlbSBpdCBicmVha3MgZXhpc3RpbmcgZnVuY3Rp
b25hbGl0eSAKZm9yIHRoZSBtb21lbnQuCgpQUywgaGFwcHkgTHVuYXIgTmV3IFllYXIuIDopCgot
U2l3ZWkKCj4KPiBUaGFua3MKPgo+Cj4+Cj4+Cj4+IFRoYW5rcywKPj4gLVNpd2VpCj4+Cj4+Cj4+
Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4KPj4+Pgo+Pj4+IFRoYW5rcywKPj4+PiAtU2l3ZWkKPj4+Pj4K
Pj4+Pj4gc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldiwgdTE2IGlkeCwKPj4+Pj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgIGNv
bnN0IHN0cnVjdCB2ZHBhX3ZxX3N0YXRlICpzdGF0ZSkKPj4+Pj4gewo+Pj4+PiDCoMKgwqAgc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+Pj4+IMKgwqDCoCBz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPj4+
Pj4gwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEgPSAmbmRldi0+dnFzW2lk
eF07Cj4+Pj4+Cj4+Pj4+IMKgwqDCoCBpZiAobXZxLT5md19zdGF0ZSA9PSBNTFg1X1ZJUlRJT19O
RVRfUV9PQkpFQ1RfU1RBVEVfUkRZKSB7Cj4+Pj4+IMKgwqDCoCDCoMKgwqAgbWx4NV92ZHBhX3dh
cm4obXZkZXYsICJjYW4ndCBtb2RpZnkgYXZhaWxhYmxlIGluZGV4XG4iKTsKPj4+Pj4gwqDCoMKg
IMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+Pj4gwqDCoMKgIH0KPj4+Pj4KPj4+Pj4gwqDCoMKg
IG12cS0+YXZhaWxfaWR4ID0gc3RhdGUtPmF2YWlsX2luZGV4Owo+Pj4+PiDCoMKgwqAgcmV0dXJu
IDA7Cj4+Pj4+IH0KPj4+Pj4KPj4+Pj4gRGVwZW5kcyBvbiB0aGUgaGFyZHdhcmUsIHdlIHNob3Vs
ZCBlaXRoZXIgc2V0IGhhcmR3YXJlIHVzZWRfaWR4IG9yIAo+Pj4+PiBoYXJkd2FyZSBhdmFpbF9p
ZHggaGVyZS4KPj4+Pj4KPj4+Pj4gSSB0aGluayB3ZSBuZWVkIHRvIGNsYXJpZnkgaG93IGRldmlj
ZSBpcyBzdXBwb3NlZCB0byB3b3JrIGluIHRoZSAKPj4+Pj4gdmlydGlvIHNwZWMuCj4+Pj4+Cj4+
Pj4+IFRoYW5rcwo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IC1TaXdlaQo+Pj4+Pj4KPj4+Pj4+
Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+IE5vdyB0aGUgdnJpdHF1ZXVlIGlzIGNvcGllZCB0byB0aGUgbmV3
IFZNIGFuZCB0aGUKPj4+Pj4+Pj4gaGFyZHdhcmUgbm93IGhhcyB0byBjb250aW51ZSBleGVjdXRp
b24gZnJvbSBpbmRleCAyMC4gV2UgbmVlZCAKPj4+Pj4+Pj4gdG8gdGVsbAo+Pj4+Pj4+PiB0aGUg
aGFyZHdhcmUgdmlhIGNvbmZpZ3VyaW5nIHRoZSBsYXN0IHVzZWRfaW5kZXguCj4+Pj4+Pj4KPj4+
Pj4+Pgo+Pj4+Pj4+IElmIHRoZSBoYXJkd2FyZSBjYW4gbm90IHN5bmMgdGhlIGluZGV4IGZyb20g
dGhlIHZpcnRxdWV1ZSwgdGhlIAo+Pj4+Pj4+IGRyaXZlciBjYW4gZG8gdGhlIHN5bmNocm9uaXph
dGlvbiBieSBtYWtlIHRoZSBsYXN0X3VzZWRfaWR4IAo+Pj4+Pj4+IGVxdWFscyB0byB1c2VkIGlu
ZGV4IGluIHRoZSB2aXJ0cXVldWUuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGFua3MKPj4+Pj4+Pgo+Pj4+
Pj4+Cj4+Pj4+Pj4+IMKgIFNvIHdoeSBkb24ndCB3ZQo+Pj4+Pj4+PiByZXN0b3JlIHRoZSB1c2Vk
IGluZGV4Pwo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFNvIGl0IHB1enpsZXMgbWUgd2h5IGlzIHNldF92
cV9zdGF0ZSgpIHdlIGRvIG5vdCBjb21tdW5pY2F0ZSAKPj4+Pj4+Pj4+PiB0aGUgc2F2ZWQKPj4+
Pj4+Pj4+PiB1c2VkIGluZGV4Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFdlIGRvbid0IGRvIHRoYXQg
c2luY2U6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gMSkgaWYgdGhlIGhhcmR3YXJlIGNhbiBzeW5jIGl0
cyBpbnRlcm5hbCB1c2VkIGluZGV4IGZyb20gdGhlIAo+Pj4+Pj4+Pj4gdmlydHF1ZXVlCj4+Pj4+
Pj4+PiBkdXJpbmcgZGV2aWNlLCB0aGVuIHdlIGRvbid0IG5lZWQgaXQKPj4+Pj4+Pj4+IDIpIGlm
IHRoZSBoYXJkd2FyZSBjYW4gbm90IHN5bmMgaXRzIGludGVybmFsIHVzZWQgaW5kZXgsIHRoZSAK
Pj4+Pj4+Pj4+IGRyaXZlciAoZS5nIGFzCj4+Pj4+Pj4+PiB5b3UgZGlkIGhlcmUpIGNhbiBkbyB0
aGF0Lgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEJ1dCB0aGVyZSdzIG5vIHdheSBmb3IgdGhlIGhhcmR3
YXJlIHRvIGRlZHVjZSB0aGUgaW50ZXJuYWwgCj4+Pj4+Pj4+PiBhdmFpbCBpbmRleCBmcm9tCj4+
Pj4+Pj4+PiB0aGUgdmlydHF1ZXVlLCB0aGF0J3Mgd2h5IGF2YWlsIGluZGV4IGlzIHN5Y25lZC4K
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBUaGFua3MKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pgo+Pj4+Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
