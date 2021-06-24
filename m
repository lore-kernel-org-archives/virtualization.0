Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0957C49EA6
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 16:19:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6162B613B3
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 16:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6162B613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3737383DB3;
	Thu, 24 Jun 2021 16:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ff2Jk6bVwStC; Thu, 24 Jun 2021 16:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CE4183DBF;
	Thu, 24 Jun 2021 16:19:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35BC8C0010;
	Thu, 24 Jun 2021 16:19:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28EAEC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0955183DB9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xk1KdKGtZQ30
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:19:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF14283DB3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 16:19:05 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OGAwpN031050; Thu, 24 Jun 2021 16:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dHzrF3eQy9gf3qf+adkSvvRY0TebRvGfcuTeWFT11jw=;
 b=Prveom88nBuueu/2CaHSKCwE8jj6qn4e22KXS5JNd/S82g4KEBY0esCN8nJ4HitrXPPJ
 poigw8vhAvLrKTcwFGJ1tVSDwgPSNz4d6z5UBfgHdXGciVFqKJzztRRc2gxbEP4kJGUi
 NRiHJXNYpfxecOOjhQhE/OlJVZ5E9VNd/EqSYlt+iF+g4mTzH4jz1NUgTkepPKrlhJa5
 hTWWMEZhMGmQ71B2TFIcX8zW1MgK1zCyqGbMnVxb0lH3CLs4tCH/vSHMq2WYOjbcPmfk
 HgjzmSoBDMIwanJZM9/XSWMOAH9y7p6gHzJkrTdvecABAjGcX7OriwYvbZuVlWHC4vlG mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39cmpxhbt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 16:18:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OGA5oa001929;
 Thu, 24 Jun 2021 16:18:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
 by userp3020.oracle.com with ESMTP id 399tbw82hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 16:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNo8dtoWJNRJ8EDz7RRbKbeTax2yUmg2hoDjwZbrFXAlXKOwpMBV5JrbwHCZuIWkWh5aLPrLXC0iiE7lpyrXGUoT7S7QY5ifz5pOoSFmkSi5mZo/834bmd/bNe5yFBzFKLUjgLe8FlFgAJ0oV6CfwfnbNOV5YAvsXZll80Wfjfvh6XRvJNt1+nOUjl4dUUTvVqdhA+cjUzcuz1rb/nIwQqFyToAmi8MfWACh9UVEIRCK6kUmNV+j8YTUShBKTJsB7YpiM7y/kbXRZ89zA813CMeOtVR8wMDl2sLHpK1tbMLPTrlVqW69TBqTfFKIiHoeii3VI4TKM1BG7DrdOIS8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHzrF3eQy9gf3qf+adkSvvRY0TebRvGfcuTeWFT11jw=;
 b=ND4vMfevKXy61EKVvqloyl+piSROHuGsmaOBV6CiRj+wHQUFsL2quE2ap+VqzTOXwUlLVomsPw1+M166mN5Lh1/Ef/AJ7oI7HG1sLwMzanSgv4VJNDhQjPg2BiWm++SVU51LMJgxZj3YGlrgNjned7FypHrNtyYsbJLb7k8i5stzz7T0JgoaDoYypsI0xSxUNrrIp3FiVK+8ZV1k3Z9xwvo1MUkcEVRGevOSHSpKDgep+T5BnVMTMG3GudA21yuBbzUma0NZmMyh50tSJSPqJEup38eLdSBtbjzEBtku6kxlU+Fl5o3Nxnwnvc9bY+5VnB9aPGanBWwKG4x8CHzr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHzrF3eQy9gf3qf+adkSvvRY0TebRvGfcuTeWFT11jw=;
 b=h53BwPDvyrfHLq7nWJ0v9JmTmHK6fZlV4wsKHp1E60rfGcNCBt49MPGo4n+fzJpf7BOhdsjS1hsoTEvaVC4L38wM3p4b629AkygeTYugl5HwLN94Hbv+yopCmGLItjghr2+KuabapLot+JRzaOg8F4xU6q11r8x3JPgiqA5Hi2U=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 16:18:43 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4264.022; Thu, 24 Jun 2021
 16:18:42 +0000
Subject: Re: [PATCH 3/3] vhost: pass kthread user to check RLIMIT_NPROC
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 christian@brauner.io, akpm@linux-foundation.org, peterz@infradead.org,
 christian.brauner@ubuntu.com
References: <20210624030804.4932-4-michael.christie@oracle.com>
 <202106241618.nrJ23bPr-lkp@intel.com>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <14c70392-9fca-fb42-01ad-28821ab95aff@oracle.com>
Date: Thu, 24 Jun 2021 11:18:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <202106241618.nrJ23bPr-lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: CH0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:610:cc::32) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.204] (73.88.28.6) by
 CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 16:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88d81583-a7a2-4818-9acd-08d9372bbbd0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4511:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4511575127DAE0ABFEC452CBF1079@SJ0PR10MB4511.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfX+LPm9CqMOzZx+aPVXTMLtxAUoT3HV57Ql+mVdMDs+hMmIwuyP/s7YBpkM3eI+SZ+Bx5yCVc/X5+2MOYoUV+c7VzZ4UikCDEOt+ekO6RkzwUPXV5k1sVvyxXA5bpq0yR1Do2NfjuvMFPSU4op/3mYI5Wy49pM1dPfSFsS1rCehEL5OhBmVgzPf+JRswxcdpKynsFJBQpr9d82XFvX0gd1pz4areHCt5vFsFmOVH5P45lgZRqx0cvgfavg94NviJR5EAWV35bCaO7V7ap1UoT1vug78Mf0ySd9BY5ZK45BjZSDOhnQzqG9/HTjY5QfYL33zq7siqalAWaK9zK1dy7FztlDZ/rVPZvCZVP+xMFuZRm/AU3OIrtTQ9B2Qnuo7pgO3q7LIt/NOjeUJRdEWICDBlNVPwTm8dzlMKQoMk1OC+r1/PENxi8xPnUDpEy7polKF8iVMbAgNZXAaR8Xfd/R1JYc4f093dfrzeC1id3P20S/m9lxtJuMtd0uSTZ29u/Fu5LOvpVN3G2INZOPbJN7z2vek8VgzExD1gLU9c/H8k0V3cM/DrEMDXpDlVK5TdrDfnjYPMt2tZxu6GS/LueNKwj6K3L4w2HWpI8x8p8t9ZrF4Sk3uRQTRLdL1RBA8S9GKF8JLuDOOnsiwNgQx/6lyX6peUTXuQXNi43Or+GFoTjc4ic+P8waIJMVyoULf0tIncsLWqi+RhnbXvMum4yMGgbYuGMUu6QMeO9wbIVQN3cNiW+IWi9wUzlbL/amOVQCnm5rJ7IpKm1ELucos4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(376002)(136003)(346002)(366004)(956004)(5660300002)(86362001)(2616005)(16576012)(8936002)(31686004)(66946007)(36756003)(8676002)(7416002)(66556008)(31696002)(4744005)(921005)(316002)(16526019)(6486002)(53546011)(38100700002)(4326008)(186003)(478600001)(6706004)(26005)(2906002)(66476007)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?N5Du3Qwq8Ny91YOwmzSUk8EBBf6LlAP6DxFbxcsqZGewX1B8jdhJb993?=
 =?Windows-1252?Q?4ydawXj9cEh4j8DYaRmmlQbcL/2c61FrZUi7LQ10x/5ixUYoRKJfhSWn?=
 =?Windows-1252?Q?QDE7MfTPFHcyY0liQeIG1iSXUrCepJR6dOnz2F88BfAWI/7yaJS0hUXs?=
 =?Windows-1252?Q?B1Nd4jWzr3b85pE54sGrDnuwlWonnCWoSzUE6ordiXPt/pZETmpQxj9S?=
 =?Windows-1252?Q?Bs+Za9OKpbssOzIMb4blw7cU1TlQJUlw+ENOzzQMydrMqSsRLDxqkSe5?=
 =?Windows-1252?Q?uZpKjpNcqfjcRtp/Qs7wLgyxUmqJ5E97ZjMpAc175RgsLqmeQGBvSCA0?=
 =?Windows-1252?Q?21gr0RzeJva/YjSxERplgcZ9SvHtz0Cis5LubQKa5jx5BiKBTUUNMhzc?=
 =?Windows-1252?Q?UHbdKT64tLhH7rfngLFkMCKnXWTRRSwqUh8VMdoEIbS1LsCIEFBJyw4S?=
 =?Windows-1252?Q?LylrG8fVjSXTW2nbaApytbvO8p/xMQLVeNWknRkENhhGTTqdZCtAhrop?=
 =?Windows-1252?Q?SDjAnGyD+LDDBh6RPOm5NfMGVk6WwZO7scHO4vnejA7Y52E26TDiU/gQ?=
 =?Windows-1252?Q?pAWlENg36q8CtP5c/He6blh7O1zJJozzlgvQtqnYgpvsMihuXkwx+ssI?=
 =?Windows-1252?Q?yDXL601Gebw5tVYynsXT+Medq8HYcbgE1ukJ8EbYcvMK5hBIDkzfCGqq?=
 =?Windows-1252?Q?6cIJ/BYS4VmZjrAtETdVrIWGt0SQLXSzJFf5jA8tQf6OWKoWwMbLlkcw?=
 =?Windows-1252?Q?qpP75htEfzA4Eibax4QMplD+xKk915lyQmdqvjy5e6P39Uug9iIiLI3V?=
 =?Windows-1252?Q?OtOtl9Tf0ObA9zhCLBCXnKiTjfM0Iqb4kwXCkyjuLazS5IRzbkpZgBDt?=
 =?Windows-1252?Q?kt3QFtd2PSCYAphyvidHTrWnvjvNOmy0znBarPSYi/NH7ioTLFRGvaPB?=
 =?Windows-1252?Q?PHXVMj1eZ00QJtVU9xjQ/RXOogxujMJtuxx5WXF1m+uAbEVxXqkeXbBl?=
 =?Windows-1252?Q?Ypoe+cpv4l6da6E76GZbBpqZgWk+Qw2yz0VxCoXnY41aYU1O/P8xeNjF?=
 =?Windows-1252?Q?ZRgis/4VZF3IdkXnUlXcnW3Sri/cWDm7Khicrgoakzyo42mhnNkS6zlU?=
 =?Windows-1252?Q?Rbg2aAK3hgPI/CbKHwXvVQozobNMMfBuzTZybLYftL1fXylFJYyeMi+w?=
 =?Windows-1252?Q?jzWFFuCBGo7gg9zIw9xnsqBBYUAxjx6APe6oasNJY1xs2JnOf05DDqph?=
 =?Windows-1252?Q?YF19Xl57tUf8tpUlm8151QgIQf6AG8MSF+hkQp0TnmmJqDHALSxIIV1i?=
 =?Windows-1252?Q?1be3FO7CWKpAD7aSlT2ktY6y5WMNKKEdoJyjVj0UJW0yo2GIujpvVFLZ?=
 =?Windows-1252?Q?1kZpmGnpKrHQA3ece0VsF96LXzeuN+I0yryb+efOWh2omC+3f+1ADpHW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d81583-a7a2-4818-9acd-08d9372bbbd0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 16:18:42.8775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDgcK36LqSWLpf2CeSPnjfN1i2D5MadYWfFxyk4MxkapqjXAX4v1VfdvhUvOGAfqFP7G4gre+tdVJwkc+pi60K+EnmjXJ8xvoR8XeJ5pMPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240090
X-Proofpoint-ORIG-GUID: UwilRqDzBiXoOk2IuaqL1ULf7fjUz4AD
X-Proofpoint-GUID: UwilRqDzBiXoOk2IuaqL1ULf7fjUz4AD
Cc: kbuild-all@lists.01.org
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

On 6/24/21 3:26 AM, kernel test robot wrote:
>>> drivers/vhost/vhost.c:599:57: sparse: sparse: dereference of noderef expression
> vim +599 drivers/vhost/vhost.c
> 
>    581	
>    582	/* Caller should have device mutex */
>    583	long vhost_dev_set_owner(struct vhost_dev *dev)
>    584	{
>    585		struct task_struct *worker;
>    586		int err;
>    587	
>    588		/* Is there an owner already? */
>    589		if (vhost_dev_has_owner(dev)) {
>    590			err = -EBUSY;
>    591			goto err_mm;
>    592		}
>    593	
>    594		vhost_attach_mm(dev);
>    595	
>    596		dev->kcov_handle = kcov_common_handle();
>    597		if (dev->use_worker) {
>    598			worker = kthread_create_for_user(vhost_worker, dev,
>  > 599							 current->real_cred->user,
>    600							 "vhost-%d", current->pid);

It looks like I should be doing something like get_uid(current_user())
then a free_uid() when doing using the user_struct.

Will fix.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
