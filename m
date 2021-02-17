Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F5C433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 00:25:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A55764DFF
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 00:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A55764DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DFB4B8720D;
	Wed, 17 Feb 2021 00:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pf6vrEd7dO3r; Wed, 17 Feb 2021 00:25:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5CEF6871EF;
	Wed, 17 Feb 2021 00:25:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ACF5C0174;
	Wed, 17 Feb 2021 00:25:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 170A8C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 00:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 05ED9871EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 00:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMFEX+6R8YgY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 00:25:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0E5F6871EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 00:25:30 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11H0O7WV133864;
 Wed, 17 Feb 2021 00:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZQBp0ZqMrq547/rEt/E09ashwCd9qFg2pnzSajNJkFg=;
 b=lfAhoWcoEQzdVN/TvAUpV29SfQljwL637hTQw2e4H+dTq9EFc3CsEeXYL9U4nfEqMFlb
 gPhYQi74TuQD4XjL3Kd/8vqtZjraeBHqo7ISlqdqQCQ0Oh385mA2wBL+oztixUIbNlyd
 daTzHfvfQe1tEbb5J1muWTgjaqGk9+GdZ5v9OfBlZR4Xhq8IJA6Ye36Ksl06+78U7Gfe
 dkL2BP01XrzaykwsSy+efmWURA41UVbgZAIPnpgv8WPVn14c3nEiDcNsTwiwKwCfSQKE
 2mA7c+0rWoxdA/7/4lwOFvpKZpjYypc24KCmpF2TQGG+N2Mp1HpEgi065Gm1z+kG3M9G VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 36p7dngmhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Feb 2021 00:25:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11H0K4Kg137412;
 Wed, 17 Feb 2021 00:25:29 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
 by userp3030.oracle.com with ESMTP id 36prpxfmkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Feb 2021 00:25:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWEGyzI4SQugmPcxKBDVIly9C1b8QFYdEgm9Bcbks50umCbQc2gpYH8wkl3Zq4LdvsVRlguAtyuJIbLc+d8O6vaset3HwgtJWSCsVtX4vh2zIPxHTd4ub4R+68UfEJkzH8mYm2ohZaM3RdPXxBNU7wxvGgGVUpUqEdcWC+3bx6MTo9JQJeN1Hce8Lv4u3ilcGnfneNxtxPAos9QbnX3zT24xw8Y+P/vI/HTWCkxEoWx/zzVUcGPLL1D1fguSHWEQzPyf8lL0KjrkRoeHBGub5LX36QxsvfuBi90gxrFtYzd3OXgBqCpdoFkF1jg18HHl8jD374ec8arQeawJDTPYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQBp0ZqMrq547/rEt/E09ashwCd9qFg2pnzSajNJkFg=;
 b=ayWcl0irvjGpvfUf6d5QkB2q3fsy173iSjCv9mlKgbmVHQOBp4egIl22v58mgaiiw5CV9gWm01aXTCtKgH3m+pS6tuCIsRzGGJricAwCt3Rqdymu1ODtb2sLI++PvGw60w7h5KHk3lABuNpfFxrR6oQ14Uh4vM9sAZRickhVQsk//DDReC0hvX/I0sdF2FqfT1c7VqIIOKtkgLMeBLL+yF8ouo72RWS7iRlgruIn0mZW+vz+4E8MdJVWfAQHtUGLt4j9WJiZJhNNN8u2lD1+qHSZQuVzDoaWed0qrni72w05JAl61LjhbKnJNs4NixiqrJNja/e1yunt6E8jIDQGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQBp0ZqMrq547/rEt/E09ashwCd9qFg2pnzSajNJkFg=;
 b=KJLB/svgqKpeObvjJck0Si4rrRcdBl9+ISNTBCmxaWYZRs6URiw/tbH7Thwqp3Lo6/ISe4MB2bWYWZoQhS+jXYXC28FvJQPakyZUkPpJPrR/3Z3iHTX32pZ2jAsb2shVb9BiBC9+ygWYQPP/CKAuYs0q1VZ0pYXmn0PmmRfRAyI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 17 Feb
 2021 00:25:25 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 00:25:25 +0000
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
 <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
 <379d79ff-c8b4-9acb-1ee4-16573b601973@redhat.com>
 <20210209061232.GC210455@mtl-vdi-166.wap.labs.mlnx>
 <411ff244-a698-a312-333a-4fdbeb3271d1@redhat.com>
 <a90dd931-43cc-e080-5886-064deb972b11@oracle.com>
 <b749313c-3a44-f6b2-f9b8-3aefa2c2d72c@redhat.com>
 <24d383db-e65c-82ff-9948-58ead3fc502b@oracle.com>
 <20210210154531.GA70716@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <fa78717a-3707-520b-35cb-c8e37503dccf@oracle.com>
Date: Tue, 16 Feb 2021 16:25:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210210154531.GA70716@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Originating-IP: [73.189.186.83]
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (73.189.186.83) by
 SN6PR05CA0019.namprd05.prod.outlook.com (2603:10b6:805:de::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.17 via Frontend Transport; Wed, 17 Feb 2021 00:25:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed86997-733b-4dad-0648-08d8d2da8457
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4479:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4479AC9A2B2C091DF0D8017BB1869@SJ0PR10MB4479.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXhfk37GWciEVtrZ3SysigCnhLTrEsQy17raxXf2UeGjHJotXrnFNwxvwQ04o4iUKGCMtfV0xTUl1yhvCT8WSdX1GIw84UrwJSG7my8KahnOXFJZyGl8pRIkFRamYAXyWO1lYSkF7nx5YTNopRnhCtN68G0Bdv8n1nTgjyU2GgxnVRL+UxYGWobbAbmzmRsneyUZDcgO9FZLfIwcFRaLRbMf67LNlSQK4pqFyjhooR3jLV8H/Dsfj7Tze482kUp1Crkbwv2Qnb+1Ya4LH9pkbxWxQ04UpcDPxm+eSXb1M0MVurAbQZatespBwMREGA5Ci+paY5zSQTrcF3DINPk4qMIW1q0rYFKre76NQKW8FrdS6ik9OZ33Q5td0q1URWacEFTmWDqImpcUOYzN5thEGAk/H+wkgGX/c3uawoEMQssFKrszgBxCFYZcOwPDrYhN+AbRsny0APdKnAJwQ2v4guHk6X91hmBF4Vr/CPTXTpbT2plDBlwZistCAq80rVYocjQLlCJFyiafnaLTE0BTqiLiR+G6G9GFkUuVtwxpQTURRDxIyp2G6cAGyPbJkchEU/cejkHYkJvYcD4H848gfjUfCyWG9UfmrbxF7B/8ifw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(31696002)(36916002)(53546011)(83380400001)(4326008)(5660300002)(26005)(36756003)(16526019)(30864003)(8676002)(6916009)(478600001)(66556008)(66476007)(186003)(2616005)(956004)(2906002)(8936002)(16576012)(86362001)(316002)(31686004)(66946007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UUVVNW1tdDFGL2UvSzlzcTB6Z0FDM2JkbUd6cmxGdFJEYk9HWS9Qb3ZLL3Vu?=
 =?utf-8?B?OXZzZHY1VkFHZEp1NVA3NTdETkJEVmZ5VGRxR2F3cnVHMkcyc3Q0SUovU2xy?=
 =?utf-8?B?ZUMyT3FjVkdSaENIOG52Wkw2SXIvdmsrcklNaDFPRTlMd0JFNzgwOGQxQWpU?=
 =?utf-8?B?NkIvNDV6VHBLTXJJVXN1YktZRGxRakk4dGVaMDJTMmpTdjRqNHpZSllLSEJm?=
 =?utf-8?B?dWpqaUFrWW1YRGhYRGpmTEJZVVhnT3ZGcm1TaUFrNWNJbWd0bWZJdEZJT2JL?=
 =?utf-8?B?bGpNUXUzbmxDUTAwbFlFQjJHNkVPUFhTcVhOTzdjY1hheDMzWlNwUFRyaVBp?=
 =?utf-8?B?ZEl1TW5LMVBhS2puemIwckV1MStNYkVDR3gxblVSYzM3cytkbXhwaHdKU2ZG?=
 =?utf-8?B?SWQ2SlI0OTE4QzR1aGgrS3NpTE9lRTZpc2tQRk5iRjZ4SkJHWVhMTVRHaWV2?=
 =?utf-8?B?ZjRUUGNZQlhJK3lrYzllVmtIUHpKSXdtcGtXc2E3bkJpVnkwTEkrYlNJc3hG?=
 =?utf-8?B?eTRUNGFNOU5KR0Rlam1EQlQ0NmhYQnZPYlNVT0p4bmpDd0RtSTBBQVNWVVNI?=
 =?utf-8?B?Y0VKRWMyNU5vUEc2QVRhcFQ3M2JpVmFJSmVWUHFaYnQ1OUtRb1lkRTkxcVVU?=
 =?utf-8?B?UUtQUnhBUVRzd25ZdUx0SGxmeWR4bjJDZ0JXNkw4blIwWm1zdEZ3VGtJRUV0?=
 =?utf-8?B?QWRPVFIzeW5BT1QwWlNaZnowbzg2ak1taGtZU0JzQS80Z0NPaGt3amk2UVQv?=
 =?utf-8?B?cWNHZ3lYWVlCckJGNHJvcnM2cG9YVlNIcmxKOFRibS9XeHhzM0o5WFplUWVH?=
 =?utf-8?B?QStzN2ZIUHBiWjNJWjkrTXRWaHJaZmtFQ1dGNU1oS3ZaUlNEYVp0T2VQbjYw?=
 =?utf-8?B?OXNwZENhZ2NhdUs2N0NNTERSaGt6Y252Z1UyOTIwZFlEQ2tJc3lmYnhsdnpP?=
 =?utf-8?B?YjVzcU1PVlcxREJpOHJwM0pHNjFLYzNhTjlYeVNBSnA0eWh6YUJiNDhHVVBa?=
 =?utf-8?B?Zng0NFV5ZEl5ekxXVW9zRXdzSTNiSFN0Y216TURmQkFOWWJqckdyNmo3Zy9O?=
 =?utf-8?B?Z09VOEptNUs4UnQ4MFM0SFBsbWhXVDVPNkI4ZHVpL1ZOaG1ZSnNPOGJUbU1s?=
 =?utf-8?B?NjJQaFVFUDZUdlVaTUl0d1BsMzdiSVpNTWpadnR5VzdMYUUrR212RVdVVlhx?=
 =?utf-8?B?YUc2djFTZG9iZ3Y1U1h2amxrdWRKUzlOWlFDYUh4aW93elZIbHBvNldVZWNL?=
 =?utf-8?B?R05XVjE4S2ZkTzNwVTRIa1VDQnlYMnR2bmQzSEpxQzYydGRyeU9mR1pMeFlC?=
 =?utf-8?B?aHBWRFZlVFhvTnlXaEVJanQ0NUEzaGZESDNxb1lCN2hZeEc1cXhnVzJEWUNW?=
 =?utf-8?B?Rit5RWx6Zkh0VU9rMWU4Y2NUTnNlQ3RwQ3g3U0htRCtMeTJ0aDQ5UUo2UEZs?=
 =?utf-8?B?amxBbjY3YndVR2ZMY21SU3hMNVphcEF4RVpucjltM05QcnQ3V0MyeXllNXA4?=
 =?utf-8?B?RmVuQjNkQ3BNMTZQUTM1UTE1LytEeTZwcXVnTkN0bWR0Z0ZxS1B2ald2cklV?=
 =?utf-8?B?OGpkNlljZXR4Sk5KOUdFZ0J3ZXdtZ0ZsTGxIY1N6S1VhUERQa1JMM2JsUzU3?=
 =?utf-8?B?cS95Z2ErOVJqT1c5RHQza2REK24raERMWUVBSVNGSERNcm83T0cvOVdyZlFP?=
 =?utf-8?B?L2YyckJVbjYvN2dUdkk1Mjl0aTlWQUI3Nk5yY01LeW5DVEw2RUZBZTI3RUNR?=
 =?utf-8?Q?IXddXizPTDrwUpiXrlN/SEp2hH08d/yWNfs6gMK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed86997-733b-4dad-0648-08d8d2da8457
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 00:25:25.3665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB/tD+VZTIdtZ51opXMY1wX4iSVnSj6nV7W8QPnopWHtJKlvYZ7FZ2zxEvQZ8Aa6hDH+qh+U1Nt23ysUtcP2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4479
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170001
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170001
Cc: lulu@redhat.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CgpPbiAyLzEwLzIwMjEgNzo0NSBBTSwgRWxpIENvaGVuIHdyb3RlOgo+IE9uIFdlZCwgRmViIDEw
LCAyMDIxIGF0IDEyOjU5OjAzQU0gLTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Cj4+IE9uIDIv
OS8yMDIxIDc6NTMgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAyMDIxLzIvMTAg5LiK5Y2I
MTA6MzAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4KPj4+PiBPbiAyLzgvMjAyMSAxMDozNyBQTSwg
SmFzb24gV2FuZyB3cm90ZToKPj4+Pj4gT24gMjAyMS8yLzkg5LiL5Y2IMjoxMiwgRWxpIENvaGVu
IHdyb3RlOgo+Pj4+Pj4gT24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMTE6MjA6MTRBTSArMDgwMCwg
SmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+PiBPbiAyMDIxLzIvOCDkuIvljYg2OjA0LCBFbGkgQ29o
ZW4gd3JvdGU6Cj4+Pj4+Pj4+IE9uIE1vbiwgRmViIDA4LCAyMDIxIGF0IDA1OjA0OjI3UE0gKzA4
MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+PiBPbiAyMDIxLzIvOCDkuIvljYgyOjM3LCBF
bGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMTI6Mjc6
MThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4+Pj4gT24gMjAyMS8yLzYg5LiK
5Y2INzowNywgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Pj4+Pj4+IE9uIDIvMy8yMDIxIDExOjM2
IFBNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4gV2hlbiBhIGNoYW5nZSBvZiBtZW1v
cnkgbWFwCj4+Pj4+Pj4+Pj4+Pj4gb2NjdXJzLCB0aGUgaGFyZHdhcmUgcmVzb3VyY2VzCj4+Pj4+
Pj4+Pj4+Pj4gYXJlIGRlc3Ryb3llZAo+Pj4+Pj4+Pj4+Pj4+IGFuZCB0aGVuIHJlLWNyZWF0ZWQg
YWdhaW4gd2l0aAo+Pj4+Pj4+Pj4+Pj4+IHRoZSBuZXcgbWVtb3J5IG1hcC4gSW4gc3VjaAo+Pj4+
Pj4+Pj4+Pj4+IGNhc2UsIHdlIG5lZWQKPj4+Pj4+Pj4+Pj4+PiB0byByZXN0b3JlIHRoZSBoYXJk
d2FyZQo+Pj4+Pj4+Pj4+Pj4+IGF2YWlsYWJsZSBhbmQgdXNlZCBpbmRpY2VzLiBUaGUKPj4+Pj4+
Pj4+Pj4+PiBkcml2ZXIgZmFpbGVkIHRvCj4+Pj4+Pj4+Pj4+Pj4gcmVzdG9yZSB0aGUgdXNlZCBp
bmRleCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gQWxz
bywgc2luY2UgdGhlIGRyaXZlciBhbHNvCj4+Pj4+Pj4+Pj4+Pj4gZmFpbHMgdG8gcmVzZXQgdGhl
IGF2YWlsYWJsZSBhbmQKPj4+Pj4+Pj4+Pj4+PiB1c2VkCj4+Pj4+Pj4+Pj4+Pj4gaW5kaWNlcyB1
cG9uIGRldmljZSByZXNldCwgZml4Cj4+Pj4+Pj4+Pj4+Pj4gdGhpcyBoZXJlIHRvIGF2b2lkIHJl
Z3Jlc3Npb24KPj4+Pj4+Pj4+Pj4+PiBjYXVzZWQgYnkKPj4+Pj4+Pj4+Pj4+PiB0aGUgZmFjdCB0
aGF0IHVzZWQgaW5kZXggbWF5IG5vdCBiZSB6ZXJvIHVwb24gZGV2aWNlIHJlc2V0Lgo+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NToKPj4+
Pj4+Pj4+Pj4+PiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZAo+Pj4+Pj4+Pj4+Pj4+IG1s
eDUKPj4+Pj4+Pj4+Pj4+PiBkZXZpY2VzIikKPj4+Pj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBF
bGkgQ29oZW48ZWxpY0BudmlkaWEuY29tPgo+Pj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+Pj4+
IHYwIC0+IHYxOgo+Pj4+Pj4+Pj4+Pj4+IENsZWFyIGluZGljZXMgdXBvbiBkZXZpY2UgcmVzZXQK
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgIGRyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYyB8IDE4ICsrKysrKysrKysrKysrKysrKwo+Pj4+Pj4+Pj4+Pj4+ICDCoMKg
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+
Pj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+
Pj4+PiBpbmRleCA4OGRkZTM0NTViZmQuLmI1ZmU2ZDJhZDIyZiAxMDA2NDQKPj4+Pj4+Pj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+Pj4+Pj4+PiBAQCAt
ODcsNiArODcsNyBAQCBzdHJ1Y3QgbWx4NV92cV9yZXN0b3JlX2luZm8gewo+Pj4+Pj4+Pj4+Pj4+
ICDCoMKgIMKgwqDCoMKgwqAgdTY0IGRldmljZV9hZGRyOwo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKg
wqDCoMKgwqAgdTY0IGRyaXZlcl9hZGRyOwo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqAg
dTE2IGF2YWlsX2luZGV4Owo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgdTE2IHVzZWRfaW5kZXg7Cj4+
Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDCoMKgwqDCoCBib29sIHJlYWR5Owo+Pj4+Pj4+Pj4+Pj4+ICDC
oMKgIMKgwqDCoMKgwqAgc3RydWN0IHZkcGFfY2FsbGJhY2sgY2I7Cj4+Pj4+Pj4+Pj4+Pj4gIMKg
wqAgwqDCoMKgwqDCoCBib29sIHJlc3RvcmU7Cj4+Pj4+Pj4+Pj4+Pj4gQEAgLTEyMSw2ICsxMjIs
NyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSB7Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDC
oMKgwqDCoCB1MzIgdmlydHFfaWQ7Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDCoMKgwqDCoCBzdHJ1
Y3QgbWx4NV92ZHBhX25ldCAqbmRldjsKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoMKgwqDCoMKgIHUx
NiBhdmFpbF9pZHg7Cj4+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pZHg7Cj4+Pj4+Pj4+
Pj4+Pj4gIMKgwqAgwqDCoMKgwqDCoCBpbnQgZndfc3RhdGU7Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAg
wqAgwqDCoMKgwqDCoCAvKiBrZWVwIGxhc3QgaW4gdGhlIHN0cnVjdCAqLwo+Pj4+Pj4+Pj4+Pj4+
IEBAIC04MDQsNiArODA2LDcgQEAgc3RhdGljIGludAo+Pj4+Pj4+Pj4+Pj4+IGNyZWF0ZV92aXJ0
cXVldWUoc3RydWN0Cj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX25ldAo+Pj4+Pj4+Pj4+Pj4+ICpu
ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoCDCoMKg
wqDCoMKgIG9ial9jb250ZXh0ID0KPj4+Pj4+Pj4+Pj4+PiBNTFg1X0FERFJfT0YoY3JlYXRlX3Zp
cnRpb19uZXRfcV9pbiwKPj4+Pj4+Pj4+Pj4+PiBpbiwKPj4+Pj4+Pj4+Pj4+PiBvYmpfY29udGV4
dCk7Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgCj4+Pj4+Pj4+Pj4+Pj4gTUxYNV9TRVQodmlydGlv
X25ldF9xX29iamVjdCwKPj4+Pj4+Pj4+Pj4+PiBvYmpfY29udGV4dCwgaHdfYXZhaWxhYmxlX2lu
ZGV4LAo+Pj4+Pj4+Pj4+Pj4+IG12cS0+YXZhaWxfaWR4KTsKPj4+Pj4+Pj4+Pj4+PiArwqDCoMKg
IE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod191c2VkX2luZGV4
LAo+Pj4+Pj4+Pj4+Pj4+IG12cS0+dXNlZF9pZHgpOwo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDC
oMKgwqAgTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4+Pj4+Pj4+
Pj4+Pj4gcXVldWVfZmVhdHVyZV9iaXRfbWFza18xMl8zLAo+Pj4+Pj4+Pj4+Pj4+IGdldF9mZWF0
dXJlc18xMl8zKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+Pj4+Pj4+Pj4+Pj4+ICDC
oMKgIMKgwqDCoMKgwqAgdnFfY3R4ID0KPj4+Pj4+Pj4+Pj4+PiBNTFg1X0FERFJfT0YodmlydGlv
X25ldF9xX29iamVjdCwKPj4+Pj4+Pj4+Pj4+PiBvYmpfY29udGV4dCwKPj4+Pj4+Pj4+Pj4+PiB2
aXJ0aW9fcV9jb250ZXh0KTsKPj4+Pj4+Pj4+Pj4+PiBAQCAtMTAyMiw2ICsxMDI1LDcgQEAgc3Rh
dGljIGludAo+Pj4+Pj4+Pj4+Pj4+IGNvbm5lY3RfcXBzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0Cj4+
Pj4+Pj4+Pj4+Pj4gKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4+Pj4+Pj4+
Pj4+Pj4gIMKgwqAgwqAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4+Pj4+Pj4+Pj4+Pj4gIMKg
wqAgwqDCoMKgwqDCoCB1OCBzdGF0ZTsKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoMKgwqDCoMKgIHUx
NiBhdmFpbGFibGVfaW5kZXg7Cj4+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pbmRleDsK
Pj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoCB9Owo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgIMKgIHN0YXRp
YyBpbnQKPj4+Pj4+Pj4+Pj4+PiBxdWVyeV92aXJ0cXVldWUoc3RydWN0Cj4+Pj4+Pj4+Pj4+Pj4g
bWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0Cj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX3ZpcnRx
dWV1ZSAqbXZxLAo+Pj4+Pj4+Pj4+Pj4+IEBAIC0xMDUyLDYgKzEwNTYsNyBAQCBzdGF0aWMgaW50
IHF1ZXJ5X3ZpcnRxdWV1ZShzdHJ1Y3QKPj4+Pj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDCoMKgwqDC
oCBtZW1zZXQoYXR0ciwgMCwgc2l6ZW9mKCphdHRyKSk7Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDC
oMKgwqDCoCBhdHRyLT5zdGF0ZSA9Cj4+Pj4+Pj4+Pj4+Pj4gTUxYNV9HRVQodmlydGlvX25ldF9x
X29iamVjdCwKPj4+Pj4+Pj4+Pj4+PiBvYmpfY29udGV4dCwgc3RhdGUpOwo+Pj4+Pj4+Pj4+Pj4+
ICDCoMKgIMKgwqDCoMKgwqAgYXR0ci0+YXZhaWxhYmxlX2luZGV4ID0gTUxYNV9HRVQodmlydGlv
X25ldF9xX29iamVjdCwKPj4+Pj4+Pj4+Pj4+PiBvYmpfY29udGV4dCwgaHdfYXZhaWxhYmxlX2lu
ZGV4KTsKPj4+Pj4+Pj4+Pj4+PiArwqDCoMKgIGF0dHItPnVzZWRfaW5kZXggPQo+Pj4+Pj4+Pj4+
Pj4+IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsCj4+Pj4+Pj4+Pj4+Pj4gb2JqX2NvbnRl
eHQsCj4+Pj4+Pj4+Pj4+Pj4gaHdfdXNlZF9pbmRleCk7Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqDC
oMKgwqDCoCBrZnJlZShvdXQpOwo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqAgcmV0dXJu
IDA7Cj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqAgQEAgLTE1MzUsNiArMTU0MCwxNiBAQAo+Pj4+Pj4+
Pj4+Pj4+IHN0YXRpYyB2b2lkCj4+Pj4+Pj4+Pj4+Pj4gdGVhcmRvd25fdmlydHF1ZXVlcyhzdHJ1
Y3QKPj4+Pj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+Pj4+Pj4+Pj4+ICDCoMKg
IMKgwqDCoMKgwqAgfQo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgIH0KPj4+Pj4+Pj4+Pj4+PiAgwqDC
oCDCoCArc3RhdGljIHZvaWQgY2xlYXJfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldikKPj4+Pj4+Pj4+Pj4+PiArewo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4+
Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgZm9yIChpID0gbmRldi0+bXZkZXYubWF4
X3ZxcyAtIDE7IGkgPj0gMDsgaS0tKSB7Cj4+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG5k
ZXYtPnZxc1tpXS5hdmFpbF9pZHggPSAwOwo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBu
ZGV2LT52cXNbaV0udXNlZF9pZHggPSAwOwo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4+
Pj4+Pj4+ICt9Cj4+Pj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgIC8qIFRPRE86
IGNyb3NzLWVuZGlhbiBzdXBwb3J0ICovCj4+Pj4+Pj4+Pj4+Pj4gIMKgwqAgwqAgc3RhdGljIGlu
bGluZSBib29sCj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0
Cj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX2Rldgo+Pj4+Pj4+Pj4+Pj4+ICptdmRldikKPj4+Pj4+
Pj4+Pj4+PiAgwqDCoCDCoCB7Cj4+Pj4+Pj4+Pj4+Pj4gQEAgLTE2MTAsNiArMTYyNSw3IEBAIHN0
YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3RydWN0Cj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBh
X25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXUKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoCDCoMKg
wqDCoMKgIHJpLT5hdmFpbF9pbmRleCA9IGF0dHIuYXZhaWxhYmxlX2luZGV4Owo+Pj4+Pj4+Pj4+
Pj4+ICvCoMKgwqAgcmktPnVzZWRfaW5kZXggPSBhdHRyLnVzZWRfaW5kZXg7Cj4+Pj4+Pj4+Pj4+
Pj4gIMKgwqAgwqDCoMKgwqDCoCByaS0+cmVhZHkgPSBtdnEtPnJlYWR5Owo+Pj4+Pj4+Pj4+Pj4+
ICDCoMKgIMKgwqDCoMKgwqAgcmktPm51bV9lbnQgPSBtdnEtPm51bV9lbnQ7Cj4+Pj4+Pj4+Pj4+
Pj4gIMKgwqAgwqDCoMKgwqDCoCByaS0+ZGVzY19hZGRyID0gbXZxLT5kZXNjX2FkZHI7Cj4+Pj4+
Pj4+Pj4+Pj4gQEAgLTE2NTQsNiArMTY3MCw3IEBAIHN0YXRpYyB2b2lkIHJlc3RvcmVfY2hhbm5l
bHNfaW5mbyhzdHJ1Y3QKPj4+Pj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+Pj4+
Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4+Pj4+
Pj4+Pj4+ICDCoMKgIMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBtdnEtPmF2YWlsX2lkeCA9IHJpLT5h
dmFpbF9pbmRleDsKPj4+Pj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbXZxLT51c2VkX2lkeCA9
IHJpLT51c2VkX2luZGV4Owo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBt
dnEtPnJlYWR5ID0gcmktPnJlYWR5Owo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqDCoMKg
wqDCoCBtdnEtPm51bV9lbnQgPSByaS0+bnVtX2VudDsKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDCoMKg
wqDCoMKgwqDCoMKgwqAgbXZxLT5kZXNjX2FkZHIgPSByaS0+ZGVzY19hZGRyOwo+Pj4+Pj4+Pj4+
Pj4+IEBAIC0xNzY4LDYgKzE3ODUsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3N0YXR1
cyhzdHJ1Y3QKPj4+Pj4+Pj4+Pj4+PiB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+Pj4+
Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgwqAgaWYgKCFzdGF0dXMpIHsKPj4+Pj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgCj4+Pj4+Pj4+Pj4+Pj4gbWx4NV92ZHBhX2luZm8obXZkZXYsCj4+Pj4+Pj4+
Pj4+Pj4gInBlcmZvcm1pbmcgZGV2aWNlIHJlc2V0XG4iKTsKPj4+Pj4+Pj4+Pj4+PiAgwqDCoCDC
oMKgwqDCoMKgwqDCoMKgwqAgdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+Pj4+Pj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCBjbGVhcl92aXJ0cXVldWVzKG5kZXYpOwo+Pj4+Pj4+Pj4+Pj4gVGhlIGNs
ZWFyaW5nIGxvb2tzIGZpbmUgYXQgdGhlIGZpcnN0Cj4+Pj4+Pj4+Pj4+PiBnbGFuY2UsIGFzIGl0
IGFsaWducyB3aXRoIHRoZSBvdGhlcgo+Pj4+Pj4+Pj4+Pj4gc3RhdGUgY2xlYW51cHMgZmxvYXRp
bmcgYXJvdW5kIGF0Cj4+Pj4+Pj4+Pj4+PiB0aGUgc2FtZSBwbGFjZS4gSG93ZXZlciwgdGhlIHRo
aW5nCj4+Pj4+Pj4+Pj4+PiBpcwo+Pj4+Pj4+Pj4+Pj4gZ2V0X3ZxX3N0YXRlKCkgaXMgc3VwcG9z
ZWQgdG8gYmUKPj4+Pj4+Pj4+Pj4+IGNhbGxlZCByaWdodCBhZnRlciB0byBnZXQgc3luYydlZAo+
Pj4+Pj4+Pj4+Pj4gd2l0aAo+Pj4+Pj4+Pj4+Pj4gdGhlIGxhdGVzdCBpbnRlcm5hbCBhdmFpbF9p
bmRleCBmcm9tCj4+Pj4+Pj4+Pj4+PiBkZXZpY2Ugd2hpbGUgdnEgaXMgc3RvcHBlZC4gVGhlCj4+
Pj4+Pj4+Pj4+PiBpbmRleCB3YXMgc2F2ZWQgaW4gdGhlIGRyaXZlcgo+Pj4+Pj4+Pj4+Pj4gc29m
dHdhcmUgYXQgdnEgc3VzcGVuc2lvbiwgYnV0Cj4+Pj4+Pj4+Pj4+PiBiZWZvcmUgdGhlCj4+Pj4+
Pj4+Pj4+PiB2aXJ0cSBvYmplY3QgaXMgZGVzdHJveWVkLiBXZQo+Pj4+Pj4+Pj4+Pj4gc2hvdWxk
bid0IGNsZWFyIHRoZSBhdmFpbF9pbmRleCB0b28KPj4+Pj4+Pj4+Pj4+IGVhcmx5Lgo+Pj4+Pj4+
Pj4+PiBHb29kIHBvaW50Lgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBUaGVyZSdzIGEgbGltaXRh
dGlvbiBvbiB0aGUgdmlydGlvIHNwZWMKPj4+Pj4+Pj4+Pj4gYW5kIHZEUEEgZnJhbWV3b3JrIHRo
YXQgd2UgY2FuIG5vdAo+Pj4+Pj4+Pj4+PiBzaW1wbHkgZGlmZmVyIGRldmljZSBzdXNwZW5kaW5n
IGZyb20gZGV2aWNlIHJlc2V0Lgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEFyZSB5b3UgdGFsa2lu
ZyBhYm91dCBsaXZlIG1pZ3JhdGlvbiB3aGVyZQo+Pj4+Pj4+Pj4+IHlvdSByZXNldCB0aGUgZGV2
aWNlIGJ1dAo+Pj4+Pj4+Pj4+IHN0aWxsIHdhbnQgdG8ga25vdyBob3cgZmFyIGl0IHByb2dyZXNz
ZWQgaW4KPj4+Pj4+Pj4+PiBvcmRlciB0byBjb250aW51ZSBmcm9tIHRoZQo+Pj4+Pj4+Pj4+IHNh
bWUgcGxhY2UgaW4gdGhlIG5ldyBWTT8KPj4+Pj4+Pj4+IFllcy4gU28gaWYgd2Ugd2FudCB0byBz
dXBwb3J0IGxpdmUgbWlncmF0aW9uIGF0IHdlIG5lZWQ6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gaW4g
c3JjIG5vZGU6Cj4+Pj4+Pj4+PiAxKSBzdXNwZW5kIHRoZSBkZXZpY2UKPj4+Pj4+Pj4+IDIpIGdl
dCBsYXN0X2F2YWlsX2lkeCB2aWEgZ2V0X3ZxX3N0YXRlKCkKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBp
biB0aGUgZHN0IG5vZGU6Cj4+Pj4+Pj4+PiAzKSBzZXQgbGFzdF9hdmFpbF9pZHggdmlhIHNldF92
cV9zdGF0ZSgpCj4+Pj4+Pj4+PiA0KSByZXN1bWUgdGhlIGRldmljZQo+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+IFNvIHlvdSBjYW4gc2VlLCBzdGVwIDIgcmVxdWlyZXMgdGhlIGRldmljZS9kcml2ZXIgbm90
IHRvIGZvcmdldCB0aGUKPj4+Pj4+Pj4+IGxhc3RfYXZhaWxfaWR4Lgo+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4gSnVzdCB0byBiZSBzdXJlLCB3aGF0IHJlYWxseSBtYXR0ZXJzIGhlcmUgaXMgdGhlCj4+Pj4+
Pj4+IHVzZWQgaW5kZXguIEJlY3Vhc2UgdGhlCj4+Pj4+Pj4+IHZyaXF0dWV1ZSBpdHNlbGYgaXMg
Y29waWVkIGZyb20gdGhlIHNyYyBWTSB0byB0aGUKPj4+Pj4+Pj4gZGVzdCBWTS4gVGhlIGF2YWls
YWJsZQo+Pj4+Pj4+PiBpbmRleCBpcyBhbHJlYXkgdGhlcmUgYW5kIHdlIGtub3cgdGhlIGhhcmR3
YXJlIHJlYWRzIGl0IGZyb20gdGhlcmUuCj4+Pj4+Pj4gU28gZm9yICJsYXN0X2F2YWlsX2lkeCIg
SSBtZWFudCB0aGUgaGFyZHdhcmUgaW50ZXJuYWwKPj4+Pj4+PiBhdmFpbCBpbmRleC4gSXQncyBu
b3QKPj4+Pj4+PiBzdG9yZWQgaW4gdGhlIHZpcnRxdWV1ZSBzbyB3ZSBtdXN0IG1pZ3JhdGUgaXQg
ZnJvbSBzcmMKPj4+Pj4+PiB0byBkZXN0IGFuZCBzZXQgdGhlbQo+Pj4+Pj4+IHRocm91Z2ggc2V0
X3ZxX3N0YXRlKCkuIFRoZW4gaW4gdGhlIGRlc3RpbmF0aW9uLCB0aGUgdmlydHF1ZXVlIGNhbiBi
ZQo+Pj4+Pj4+IHJlc3RhcnRlZCBmcm9tIHRoYXQgaW5kZXguCj4+Pj4+Pj4KPj4+Pj4+IENvbnNp
ZGVyIHRoaXMgY2FzZTogZHJpdmVyIHBvc3RlZCBidWZmZXJzIHRpbGwgYXZhaWwgaW5kZXggYmVj
b21lcyB0aGUKPj4+Pj4+IHZhbHVlIDUwLiBIYXJkd2FyZSBpcyBleGVjdXRpbmcgYnV0IG1hZGUg
aXQgdGlsbCAyMCB3aGVuIHZpcnRxdWV1ZSB3YXMKPj4+Pj4+IHN1c3BlbmRlZCBkdWUgdG8gbGl2
ZSBtaWdyYXRpb24gLSB0aGlzIGlzIGluZGljYXRlZCBieSBoYXJkd2FyZSB1c2VkCj4+Pj4+PiBp
bmRleCBlcXVhbCAyMC4KPj4+Pj4KPj4+Pj4gU28gaW4gdGhpcyBjYXNlIHRoZSB1c2VkIGluZGV4
IGluIHRoZSB2aXJ0cXVldWUgc2hvdWxkIGJlIDIwPwo+Pj4+PiBPdGhlcndpc2Ugd2UgbmVlZCBu
b3Qgc3luYyB1c2VkIGluZGV4IGl0c2VsZiBidXQgYWxsIHRoZSB1c2VkCj4+Pj4+IGVudHJpZXMg
dGhhdCBpcyBub3QgY29tbWl0dGVkIHRvIHRoZSB1c2VkIHJpbmcuCj4+Pj4gSW4gb3RoZXIgd29y
ZCwgZm9yIG1seDUgdmRwYSB0aGVyZSdzIG5vIHN1Y2ggaW50ZXJuYWwgbGFzdF9hdmFpbF9pZHgK
Pj4+PiBzdHVmZiBtYWludGFpbmVkIGJ5IHRoZSBoYXJkd2FyZSwgcmlnaHQ/Cj4+Pgo+Pj4gRm9y
IGVhY2ggZGV2aWNlIGl0IHNob3VsZCBoYXZlIG9uZSBvdGhlcndpc2UgaXQgd29uJ3Qgd29yayBj
b3JyZWN0bHkKPj4+IGR1cmluZyBzdG9wL3Jlc3VtZS4gU2VlIHRoZSBjb2RlcyBtbHg1X3ZkcGFf
Z2V0X3ZxX3N0YXRlKCkgd2hpY2ggY2FsbHMKPj4+IHF1ZXJ5X3ZpcnRxdWV1ZSgpIHRoYXQgYnVp
bGQgY29tbWFuZHMgdG8gcXVlcnkgImxhc3RfYXZhaWxfaWR4IiBmcm9tIHRoZQo+Pj4gaGFyZHdh
cmU6Cj4+Pgo+Pj4gIMKgwqDCoCBNTFg1X1NFVChnZW5lcmFsX29ial9pbl9jbWRfaGRyLCBjbWRf
aGRyLCBvcGNvZGUsCj4+PiBNTFg1X0NNRF9PUF9RVUVSWV9HRU5FUkFMX09CSkVDVCk7Cj4+PiAg
wqDCoMKgIE1MWDVfU0VUKGdlbmVyYWxfb2JqX2luX2NtZF9oZHIsIGNtZF9oZHIsIG9ial90eXBl
LAo+Pj4gTUxYNV9PQkpfVFlQRV9WSVJUSU9fTkVUX1EpOwo+Pj4gIMKgwqDCoCBNTFg1X1NFVChn
ZW5lcmFsX29ial9pbl9jbWRfaGRyLCBjbWRfaGRyLCBvYmpfaWQsIG12cS0+dmlydHFfaWQpOwo+
Pj4gIMKgwqDCoCBNTFg1X1NFVChnZW5lcmFsX29ial9pbl9jbWRfaGRyLCBjbWRfaGRyLCB1aWQs
IG5kZXYtPm12ZGV2LnJlcy51aWQpOwo+Pj4gIMKgwqDCoCBlcnIgPSBtbHg1X2NtZF9leGVjKG5k
ZXYtPm12ZGV2Lm1kZXYsIGluLCBzaXplb2YoaW4pLCBvdXQsIG91dGxlbik7Cj4+PiAgwqDCoMKg
IGlmIChlcnIpCj4+PiAgwqDCoMKgIMKgwqDCoCBnb3RvIGVycl9jbWQ7Cj4+Pgo+Pj4gIMKgwqDC
oCBvYmpfY29udGV4dCA9IE1MWDVfQUREUl9PRihxdWVyeV92aXJ0aW9fbmV0X3Ffb3V0LCBvdXQs
IG9ial9jb250ZXh0KTsKPj4+ICDCoMKgwqAgbWVtc2V0KGF0dHIsIDAsIHNpemVvZigqYXR0cikp
Owo+Pj4gIMKgwqDCoCBhdHRyLT5zdGF0ZSA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3Qs
IG9ial9jb250ZXh0LCBzdGF0ZSk7Cj4+PiAgwqDCoMKgIGF0dHItPmF2YWlsYWJsZV9pbmRleCA9
IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LAo+Pj4gaHdfYXZhaWxh
YmxlX2luZGV4KTsKPj4+Cj4+IEVsaSBzaG91bGQgYmUgYWJsZSB0byBjb3JyZWN0IG1lLCBidXQg
dGhpcyBod19hdmFpbGFibGVfaW5kZXggbWlnaHQganVzdCBiZQo+PiBhIGNhY2hlZCB2YWx1ZSBv
ZiB2aXJ0cXVldWUgYXZhaWxfaW5kZXggaW4gdGhlIG1lbW9yeSBmcm9tIHRoZSBtb3N0IHJlY2Vu
dAo+PiBzeW5jLiBJIGRvdWJ0IGl0J3MgdGhlIG9uZSB5b3UgdGFsa2VkIGFib3V0IGluIHNvZnR3
YXJlIGltcGxlbWVudGF0aW9uLiBJZiBJCj4+IHVuZGVyc3RhbmQgRWxpIGNvcnJlY3RseSwgaGFy
ZHdhcmUgd2lsbCBhbHdheXMgcmVsb2FkIHRoZSBsYXRlc3QgYXZhaWxfaW5kZXgKPj4gZnJvbSBt
ZW1vcnkgd2hlbmV2ZXIgaXQncyBiZWluZyBzeW5jJ2VkIGFnYWluLgo+IFRoYXQncyBteSB1bmRl
cnN0YW5kaW5nIHRvby4gSSBhbSBzdGlsbCB0cnlpbmcgdG8gZ2V0IGNvbmZpcm1hdGlvbiBmcm9t
Cj4gaGFyZHdhcmUgZ3V5cy4gV2lsbCBzZW5kIHdoZW4gSSBoYXZlIHRoZW0uCj4KPj4gPHF1b3Rl
Pgo+PiBUaGUgaGFyZHdhcmUgYWx3YXlzIGdvZXMgdG8gcmVhZCB0aGUgYXZhaWxhYmxlIGluZGV4
IGZyb20gbWVtb3J5LiBUaGUKPj4gcmVxdWlyZW1lbnQgdG8gY29uZmlndXJlIGl0IHdoZW4gY3Jl
YXRpbmcgYSBuZXcgb2JqZWN0IGlzIHN0aWxsIGEKPj4gcmVxdWlyZW1lbnQgZGVmaW5lZCBieSB0
aGUgaW50ZXJmYWNlIHNvIEkgbXVzdCBub3QgdmlvbGF0ZSBpbnRlcmZhY2UKPj4gcmVxdWlybWVu
dHMuCj4+IDwvcXVvdGU+Cj4+Cj4+IElmIHRoZSBoYXJkd2FyZSBkb2VzIGV2ZXJ5dGhpbmcgcGVy
ZmVjdGx5IHRoYXQgaXMgYWJsZSB0byBmbHVzaCBwZW5kaW5nCj4+IHJlcXVlc3RzLCB1cGRhdGUg
ZGVzY3JpcHRvcnMsIHJpbmdzIHBsdXMgdXNlZCBpbmRpY2VzIGFsbCBhdCBvbmNlIGJlZm9yZSB0
aGUKPj4gc3VzcGVuc2lvbiwgdGhlcmUncyBubyBuZWVkIGZvciBoYXJkd2FyZSB0byBtYWludGFp
biBhIHNlcGFyYXRlIGludGVybmFsCj4+IGluZGV4IHRoYW4gdGhlIGgvdyB1c2VkX2luZGV4LiBU
aGUgaGFyZHdhcmUgY2FuIGdldCBzdGFydGVkIGZyb20gdGhlIHNhdmVkCj4+IHVzZWRfaW5kZXgg
dXBvbiByZXN1bWluZy4gSSB2aWV3IHRoaXMgaXMgb2YgKGhhcmR3YXJlKSBpbXBsZW1lbnRhdGlv
bgo+PiBjaG9pY2VzIGFuZCB0aG91Z2h0IGl0IGRvZXMgbm90IHZpb2xhdGUgdGhlIHZpcnRpbyBz
cGVjPwo+Pgo+Pgo+Pj4KPj4+Cj4+Pj4gQW5kIHRoZSB1c2VkX2lkeCBpbiB0aGUgdmlydHF1ZXVl
IGlzIGFsd2F5cyBpbiBzeW5jIHdpdGggdGhlCj4+Pj4gaGFyZHdhcmUgdXNlZF9pbmRleCwgYW5k
IGhhcmR3YXJlIGlzIHN1cHBvc2VkIHRvIGNvbW1pdCBwZW5kaW5nIHVzZWQKPj4+PiBidWZmZXJz
IHRvIHRoZSByaW5nIHdoaWxlIGJ1bXBpbmcgdXAgdGhlIGhhcmR3YXJlIHVzZWRfaW5kZXggKGFu
ZAo+Pj4+IGFsc28gY29tbWl0dGVkIHRvIG1lbW9yeSkgYWx0b2dldGhlciBwcmlvciB0byBzdXNw
ZW5zaW9uLCBpcyBteQo+Pj4+IHVuZGVyc3RhbmRpbmcgY29ycmVjdCBoZXJlPyBEb3VibGUgY2hl
Y2tpbmcgaWYgdGhpcyBpcyB0aGUgZXhwZWN0ZWQKPj4+PiBzZW1hbnRpY3Mgb2Ygd2hhdAo+Pj4+
IG1vZGlmeV92aXJ0cXVldWUoTUxYNV9WSVJUSU9fTkVUX1FfT0JKRUNUX1NUQVRFX1NVU1BFTkQp
IHNob3VsZAo+Pj4+IGFjaGlldmUuCj4+Pj4KPiBUaGF0J3MgbXkgdW5kZXJzdGFuZGluZyB0b28u
Cj4KPj4+PiBJZiB0aGUgYWJvdmUgaXMgdHJ1ZSwgdGhlbiBpdCBsb29rcyB0byBtZSBmb3IgbWx4
NSB2ZHBhIHdlIHNob3VsZAo+Pj4+IHJlYWxseSByZXR1cm4gaC93IHVzZWRfaWR4IHJhdGhlciB0
aGFuIHRoZSBsYXN0X2F2YWlsX2lkeCB0aHJvdWdoCj4+Pj4gZ2V0X3ZxX3N0YXRlKCksIGluIG9y
ZGVyIHRvIHJlY29uc3RydWN0IHRoZSB2aXJ0IHF1ZXVlIHN0YXRlIHBvc3QKPj4+PiBsaXZlIG1p
Z3JhdGlvbi4gRm9yIHRoZSBzZXRfbWFwIGNhc2UsIHRoZSBpbnRlcm5hbCBsYXN0X2F2YWlsX2lk
eAo+Pj4+IHJlYWxseSBkb2Vzbid0IG1hdHRlciwgYWx0aG91Z2ggYm90aCBpbmRpY2VzIGFyZSBz
YXZlZCBhbmQgcmVzdG9yZWQKPj4+PiB0cmFuc3BhcmVudGx5IGFzLWlzLgo+IFJpZ2h0LCB0aGF0
J3Mgd2hhdCBJIHRoaW5rIHRvby4gSW4gZmFjdCwgSSBkaXNjdXNzZWQgdGhhdCBhbHJlYWR5IHdp
dGgKPiBKYXNvbiBvdmVyIHRoZSBwaG9uZSB5ZXN0ZXJkYXkuIFRoZSBjb25jbHVzaW9uIHdhcyBz
aW5jZSB0aGUgb25seSB0aGluZwo+IHRoYXQgbWF0dGVycyBmb3IgYSBuZXR3b3JrIGRldmljZSBp
cyB0aGUgdXNlZCBpbmRleCwgSSB0cmllZCB0byByZXR1cm4KPiB0aGUgaGFyZHdhcmUgdXNlZCBp
bmRleCBpbiBnZXRfdnFfc3RhdGUgKGluc3RlYWQgb2YgaGFyZHdhcmUgYXZhaWxhYmxlCj4gaW5k
ZXgpIGFuZCByZXN0b3JlIHRoZSB2YWx1ZSBJIGdldCBpbiBzZXRfdnFfc3RhdGUgaW50byB0aGUg
aGFyZHdhcmUKPiB1c2VkIGluZGV4LiBJIGFtIHN0aWxsIG5vdCBkb25lIHdpdGggdGhpcyBleHBl
cmltZW50IGJ1dCB3aWxsIHVwZGF0ZS4KPgo+Pj4gUmlnaHQsIGEgc3VidGxlIHRoaW5nIGhlcmUg
aXMgdGhhdDogZm9yIHRoZSBkZXZpY2UgdGhhdCBtaWdodCBoYXZlIGNhbid0Cj4+PiBub3QgY29t
cGxldGUgYWxsIHZpcnRxdWV1ZSByZXF1ZXN0cyBkdXJpbmcgdnEgc3VzcGVuZGluZywgdGhlCj4+
PiAibGFzdF9hdmFpbF9pZHgiIG1pZ2h0IG5vdCBiZSBlcXVhbCB0byB0aGUgaGFyZHdhcmUgdXNl
ZF9pZHguIFRoaW5nCj4+PiBtaWdodCBiZSB0cnVlIGZvciB0aGUgc3RvcmFnZSBkZXZpY2VzIHRo
YXQgbmVlZHMgdG8gY29ubmVjdCB0byBhIHJlbW90ZQo+Pj4gYmFja2VuZC4gQnV0IHRoaXMgaXMg
bm90IHRoZSBjYXNlIG9mIG5ldHdvcmtpbmcgZGV2aWNlLCBzbwo+Pj4gbGFzdF9hdmFpbF9pZHgg
c2hvdWxkIGJlIGVxdWFsIHRvIGhhcmR3YXJlIHVzZWRfaWR4IGhlcmUuCj4+IEVsaSwgc2luY2Ug
aXQncyB5b3VyIGhhcmR3YXJlLCBkb2VzIGl0IHdvcmsgdGhpcyB3YXk/IGkuZS4gZG9lcyB0aGUg
ZmlybXdhcmUKPj4gaW50ZXJmYWNlIHNlZSBhIGNhc2Ugd2hlcmUgdmlydHF1ZXVlIHJlcXVlc3Rz
IGNhbid0IGJlIGNvbXBsZXRlZCBiZWZvcmUKPj4gc3VzcGVuZGluZyB2cT8KPj4KPiBUaGlzIGNh
biBoYXBwZW4gcmVnYXJkbGVzcyBvZiB3aGF0IGVmZm9ydCBmaXJtd2FyZSBkb2VzIHRvIGNvbXBs
ZXRlIGFsbAo+IHBlbmRpbmcgcmVxdWVzdHMuIEFuIGV4YW1wbGUgaXMgdGhlIGhvdCBwbHVnZ2lu
ZyBvZiBtZW1vcnkuIFRoZSBzZXQgbWFwCj4gY2FsbCBpcyBjYWxsZWQgYW5kIG1seDUgdmRwYSBk
cml2ZXIgdGVhcnMgZG93biB0aGUgdml0cXVldWUgb2JqZWN0cwo+IHdoaWxlIHRoZSBndWVzdCBk
cml2ZXIgY2FuIHN0aWxsIGJlIHBvc3RpbmcgcmVxdWVzdHMgdG8gdGhlIHZpcnRxdWV1ZS4KPiBT
byB3ZSBmaW5kIG91cnNlbHZlcyBpbiBhIHNpdHVhdGlvbiBhbmQgdXNlZCBpbmRleCBpcyBiZWhp
bmUgdGhlCj4gYXZhaWxhYmxlIGluZGV4LgpUaGUgc2V0X21hcCBjYXNlIGlzIGEgYml0IHVudXN1
YWwgZnJvbSB0aGUgbWlncmF0aW9uIG9yIHJlYm9vdCBjYXNlLiAKU2luY2Ugc3VzcGVuZC9yZXN1
bWUgb24gc2V0X21hcCBpcyBkb25lIGluIGEgc2luZ2xlIGlvY3RsIGNhbGwsIEkgYXNzdW1lIAp0
aGUgZHJpdmVyIGlzIHJlc3BvbnNpYmxlIGZvciBzYXZpbmcgYW5kIHJlc3RvcmluZyB0aGUgdXNl
ZCBpbmRleCwgYW5kIApoYXJkd2FyZSBjYW4gb25seSB1cGRhdGUgdXNlZF9pbmRleCB0byB0aGUg
bWVtb3J5IHVudGlsIHRoZSBtZW1vcnkgbWFwcyAKYXJlIGZ1bGx5IHNldCB1cCAoaS5lLiBhZnRl
ciBtZW1vcnkga2V5cyBhbmQgdmlydHEgb2JqZWN0cyBnZXQgY3JlYXRlZCkuIApXaGVyZWFzIGZv
ciB0aGUgbWlncmF0aW9uIGFuZCByZWJvb3QgY2FzZSwgdXNlZF9pbmRleCBpcyByZXF1aXJlZCB0
byBiZSAKc3luYydlZCB0byBtZW1vcnkgZm9yIGFsbCBjb21wbGV0ZWQgcmVxdWVzdHMgYmVmb3Jl
IHN1c3BlbnNpb24gCihleGNlcHRpb246IG5ldHdvcmsgUnggcGF0aCB3aGVyZSBwYWNrZXQgZHJv
cCBjYW4gYmUgdG9sZXJhdGVkKS4gVGhlIApwcm9jZWR1cmUgdG8gcmVzdW1lIHZEUEEgZGV2aWNl
IGJldHdlZW4gdGhlc2UgdHdvIHNob3VsZCBkaWZmZXIgSSAKc3VwcG9zZSwgYnV0IGRpZCBub3Qg
c2VlbSBzZWUgaXQgaW4gdGhlIGNvZGU/Cgo+Cj4+PiBCdXQgdXNpbmcgdGhlICJsYXN0X2F2YWls
X2lkeCIgb3IgaGFyZHdhcmUgYXZhaWxfaWR4IHNob3VsZCBhbHdheXMgYmUKPj4+IGJldHRlciBp
biB0aGlzIGNhc2Ugc2luY2UgaXQncyBndWFyYW50ZWVkIHRvIGNvcnJlY3QgYW5kIHdpbGwgaGF2
ZSBsZXNzCj4+PiBjb25mdXNpb24uIFdlIHVzZSB0aGlzIGNvbnZlbnRpb24gaW4gb3RoZXIgdHlw
ZXMgb2Ygdmhvc3QgYmFja2VuZHMKPj4+ICh2aG9zdC1rZXJuZWwsIHZob3N0LXVzZXIpLgo+Pj4K
Pj4+IFNvIGxvb2tpbmcgYXQgbWx4NV9zZXRfdnFfc3RhdGUoKSwgaXQgcHJvYmFibHkgd29uJ3Qg
d29yayBzaW5jZSBpdAo+Pj4gZG9lc24ndCBub3Qgc2V0IGVpdGhlciBoYXJkd2FyZSBhdmFpbF9p
ZHggb3IgaGFyZHdhcmUgdXNlZF9pZHg6Cj4+IFRoZSBzYXZlZCBtdnEtPmF2YWlsX2lkeCB3aWxs
IGJlIHVzZWQgdG8gcmVjcmVhdGUgaGFyZHdhcmUgdmlydHEgb2JqZWN0IGFuZAo+PiB0aGUgdXNl
ZCBpbmRleCBpbiBjcmVhdGVfdmlydHF1ZXVlKCksIG9uY2Ugc3RhdHVzIERSSVZFUl9PSyBpcyBz
ZXQuIEkKPj4gc3VzcGVjdCB3ZSBzaG91bGQgcGFzcyB0aGUgaW5kZXggdG8gbXZxLT51c2VkX2lk
eCBpbgo+PiBtbHg1X3ZkcGFfc2V0X3ZxX3N0YXRlKCkgYmVsb3cgaW5zdGVhZC4KPj4KPiBSaWdo
dCwgdGhhdCdzIHdoYXQgSSBhbSBjaGVja2luZyBidXQgc3RpbGwgbm8gZmluYWwgY29uY2x1c2lv
bnMuIEkgbmVlZAo+IHRvIGhhcm5lc3MgaGFyZHdhcmUgZ3V5IHRvIHByb3ZpZGUgbWUgd2l0aCBj
bGVhciBhbnN3ZXJzLgpPSy4gQ291bGQgeW91IHVwZGF0ZSB3aGF0IHlvdSBmaW5kIGZyb20gdGhl
IGhhcmR3YXJlIGd1eSBhbmQgbGV0IHVzIGtub3cgCmUuZy4gaWYgdGhlIGN1cnJlbnQgZmlybXdh
cmUgaW50ZXJmYWNlIHdvdWxkIHN1ZmZpY2U/CgpUaGFua3MsCi1TaXdlaQo+PiBUaGFua3MsCj4+
IC1TaXdlaQo+Pj4gc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTE2IGlkeCwKPj4+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
wqAgY29uc3Qgc3RydWN0IHZkcGFfdnFfc3RhdGUgKnN0YXRlKQo+Pj4gewo+Pj4gIMKgwqDCoCBz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPj4+ICDCoMKgwqAg
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+
PiAgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEgPSAmbmRldi0+dnFzW2lk
eF07Cj4+Pgo+Pj4gIMKgwqDCoCBpZiAobXZxLT5md19zdGF0ZSA9PSBNTFg1X1ZJUlRJT19ORVRf
UV9PQkpFQ1RfU1RBVEVfUkRZKSB7Cj4+PiAgwqDCoMKgIMKgwqDCoCBtbHg1X3ZkcGFfd2Fybiht
dmRldiwgImNhbid0IG1vZGlmeSBhdmFpbGFibGUgaW5kZXhcbiIpOwo+Pj4gIMKgwqDCoCDCoMKg
wqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiAgwqDCoMKgIH0KPj4+Cj4+PiAgwqDCoMKgIG12cS0+YXZh
aWxfaWR4ID0gc3RhdGUtPmF2YWlsX2luZGV4Owo+Pj4gIMKgwqDCoCByZXR1cm4gMDsKPj4+IH0K
Pj4+Cj4+PiBEZXBlbmRzIG9uIHRoZSBoYXJkd2FyZSwgd2Ugc2hvdWxkIGVpdGhlciBzZXQgaGFy
ZHdhcmUgdXNlZF9pZHggb3IKPj4+IGhhcmR3YXJlIGF2YWlsX2lkeCBoZXJlLgo+Pj4KPj4+IEkg
dGhpbmsgd2UgbmVlZCB0byBjbGFyaWZ5IGhvdyBkZXZpY2UgaXMgc3VwcG9zZWQgdG8gd29yayBp
biB0aGUgdmlydGlvCj4+PiBzcGVjLgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4+Pj4gLVNpd2Vp
Cj4+Pj4KPj4+Pj4KPj4+Pj4+IE5vdyB0aGUgdnJpdHF1ZXVlIGlzIGNvcGllZCB0byB0aGUgbmV3
IFZNIGFuZCB0aGUKPj4+Pj4+IGhhcmR3YXJlIG5vdyBoYXMgdG8gY29udGludWUgZXhlY3V0aW9u
IGZyb20gaW5kZXggMjAuIFdlIG5lZWQgdG8gdGVsbAo+Pj4+Pj4gdGhlIGhhcmR3YXJlIHZpYSBj
b25maWd1cmluZyB0aGUgbGFzdCB1c2VkX2luZGV4Lgo+Pj4+Pgo+Pj4+PiBJZiB0aGUgaGFyZHdh
cmUgY2FuIG5vdCBzeW5jIHRoZSBpbmRleCBmcm9tIHRoZSB2aXJ0cXVldWUsIHRoZQo+Pj4+PiBk
cml2ZXIgY2FuIGRvIHRoZSBzeW5jaHJvbml6YXRpb24gYnkgbWFrZSB0aGUgbGFzdF91c2VkX2lk
eAo+Pj4+PiBlcXVhbHMgdG8gdXNlZCBpbmRleCBpbiB0aGUgdmlydHF1ZXVlLgo+Pj4+Pgo+Pj4+
PiBUaGFua3MKPj4+Pj4KPj4+Pj4KPj4+Pj4+ICDCoCBTbyB3aHkgZG9uJ3Qgd2UKPj4+Pj4+IHJl
c3RvcmUgdGhlIHVzZWQgaW5kZXg/Cj4+Pj4+Pgo+Pj4+Pj4+PiBTbyBpdCBwdXp6bGVzIG1lIHdo
eSBpcyBzZXRfdnFfc3RhdGUoKSB3ZSBkbyBub3QKPj4+Pj4+Pj4gY29tbXVuaWNhdGUgdGhlIHNh
dmVkCj4+Pj4+Pj4+IHVzZWQgaW5kZXguCj4+Pj4+Pj4gV2UgZG9uJ3QgZG8gdGhhdCBzaW5jZToK
Pj4+Pj4+Pgo+Pj4+Pj4+IDEpIGlmIHRoZSBoYXJkd2FyZSBjYW4gc3luYyBpdHMgaW50ZXJuYWwg
dXNlZCBpbmRleCBmcm9tCj4+Pj4+Pj4gdGhlIHZpcnRxdWV1ZQo+Pj4+Pj4+IGR1cmluZyBkZXZp
Y2UsIHRoZW4gd2UgZG9uJ3QgbmVlZCBpdAo+Pj4+Pj4+IDIpIGlmIHRoZSBoYXJkd2FyZSBjYW4g
bm90IHN5bmMgaXRzIGludGVybmFsIHVzZWQgaW5kZXgsCj4+Pj4+Pj4gdGhlIGRyaXZlciAoZS5n
IGFzCj4+Pj4+Pj4geW91IGRpZCBoZXJlKSBjYW4gZG8gdGhhdC4KPj4+Pj4+Pgo+Pj4+Pj4+IEJ1
dCB0aGVyZSdzIG5vIHdheSBmb3IgdGhlIGhhcmR3YXJlIHRvIGRlZHVjZSB0aGUKPj4+Pj4+PiBp
bnRlcm5hbCBhdmFpbCBpbmRleCBmcm9tCj4+Pj4+Pj4gdGhlIHZpcnRxdWV1ZSwgdGhhdCdzIHdo
eSBhdmFpbCBpbmRleCBpcyBzeWNuZWQuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGFua3MKPj4+Pj4+Pgo+
Pj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
