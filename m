Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500EEC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:24:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4485206F6
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4485206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DBC987A42;
	Thu, 17 Dec 2020 16:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqPCOZx3Vcyj; Thu, 17 Dec 2020 16:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93BDF879BF;
	Thu, 17 Dec 2020 16:24:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C28C0893;
	Thu, 17 Dec 2020 16:24:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90AA3C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 779E5875BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27ha6e9sYhOT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AD13D874B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym3FOdJ5C6plbwCWnPbYiBldTJJD/AeVhIqq6kRnLp3r+ZVmG7ga+jAROpL9mzkxFAQDY1cfiCKV/kkS9Y8wel43VUqonq21PEWzYEeVdLa2gxXj6pZx/O3AewH/BGxwqAEPST8E9x2P3/B6k+MYxBVQBHmAAKGaTMarEqupsNw1M2kFTAsReIpeHph2fxK3HEKi9EWo5fH95WoEsewgnNQBItGCz+AQOhAPU0tm78zs8F9lPAz9wH8ynwY6pFYbbzxybK2oCMuvMyZ7D3g2n8TCzgEMyLoEYpZKDKdJernQRInEuxHzabIz3RuTGIgu9LWC2+M8RAby6KUDmidzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3L/Z2JKNmBEevjM5T+b7IzYa/RSylIYJ0/QgLw7IpQ=;
 b=GGuWIApSejzEewJBWNMHQ4wXreva9evJzU0cWalrMO28vAWjGTnmDkx62ZF89+mI8wZnIiKfnqJnle4FN64aukRDAnCSO0gGaV9kE1ZgxXpYtiEkfekzkOPENWf0rS1DcXTxDBKxeC84MIbcaIgn4NpgXH4KdhdSor/GpbvFXvsz3aqhXosEzElSJKLGt5HjsHVq6G6DeUD3wABxGokrM1PKch8c/1rRS8lVaJfDEjl4gfdKv7UF6OHOfeefhM96NKuh9cb2oRgM5XNGAJ5KvhaXxhNGbiTMVGEz6evLfS72wPtydkqssQksRGcbnJOxP1lp+p2dw/5ONsM7tmu/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3L/Z2JKNmBEevjM5T+b7IzYa/RSylIYJ0/QgLw7IpQ=;
 b=V6RvASXAmTWOfVWPUuYwVtmb7aRpr6nmuhnx9C1cYx4DjnLBt1EkhA2IOJFA1d/DCmTHqk4QvW5YMOulWOJsfW5qk4HSWNvWOUiToFtmxIf14s/KHmXuIQRnvwqIXrWHjJ84wMcX0yps/YzbvZfBSxs+bWRdU4lLINiouhjnJYU=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 17 Dec
 2020 16:24:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 16:24:36 +0000
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
To: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
 <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
 <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
Date: Thu, 17 Dec 2020 17:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0154.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 16:24:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 723b400f-e7c8-411f-a1ca-08d8a2a83f16
X-MS-TrafficTypeDiagnostic: BL0PR12MB4898:
X-Microsoft-Antispam-PRVS: <BL0PR12MB489824FE7B8114309BBF33B383C40@BL0PR12MB4898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux4d5fODcnM2UfOypThGYnj/W+pEB+TBHhQEdoBTPFanTZXUi9wvGMsyRv+P42G6D4Z4b3uordoMYXNyccWBXnG7Pw5U93+iZFC+a6Ih5kTXelQhFt57dNScPP9avfTvLymQ0443Ejv91G2D9WrFd7tBr139OZwAzEYjvn27k1F6zxLoR++Hvbmu7uTbY7R/fZuuISWsDK+YOZIwEoMoc53xDUOP0xbP166+la6+U9e6AIoElwfRP/hzLCNsutvydpbNnMlfPQgfsCHtoUPgWVDlTpajd5Eg6NT7nW96mLa6fgrOEicisfWlFUuEYQdfEVyxLMxeTjD7vMylEeVGEVjqFAtNd6E2qifGA0Pn+mtLvHYvCxITK1EFFpgZj3nxnt9WMOc/HTOT2jKzf/ds5pjceuHMnJhOERVYhskRJt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(83380400001)(66476007)(52116002)(86362001)(66556008)(31696002)(31686004)(66946007)(8936002)(6666004)(5660300002)(2906002)(316002)(966005)(16526019)(2616005)(54906003)(45080400002)(478600001)(6486002)(4326008)(66574015)(8676002)(186003)(110136005)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-15?Q?+5roQga08X6/Al2BRXNYdNfdyN6bptEma3eEbmVVPICUkJFmK7gc5odIa?=
 =?iso-8859-15?Q?DVwjCInBI4Bg9023lYH46MkGgx5eazRzARSJ1Qu06I/iqO3yXK7jNb+R+?=
 =?iso-8859-15?Q?MHdWgeR59t+O6+DEZMyyDonu3OHJIpEfC1LjBJHHcIQho0BSuvkOSJdcd?=
 =?iso-8859-15?Q?8Jm7aF+QjIPJKrGNmizElqlHAoj9PG6E+K0nzVC5ySoOkBwcVV0Eh4IMe?=
 =?iso-8859-15?Q?vJa1VwpHhFdeZSWeJB7UYkA3SEfN25eQTpjZlu+Ieqi5Us2Eqwc4YOpcg?=
 =?iso-8859-15?Q?0ubkIM6DThBEBhC2MZqiOLjJq1CP329uaP3kSEc9HihGOZ5ZBfQO5EZ4g?=
 =?iso-8859-15?Q?OUHZAuWeqCk9vryiXSt9cNddStLFzrM4K6qkpYQtUGz0lgdBWn0Y2YJZ8?=
 =?iso-8859-15?Q?HlKlYdRWwTGVswOVvo0trAaFh6OU6CC4dpD77hHkRa8f2QAwkU59pvfZM?=
 =?iso-8859-15?Q?D/OnNwTFNJY0SQ7pSas9j8arRwiBwp8VH+Zw+txEdIxORgjfCMx7lcZ+X?=
 =?iso-8859-15?Q?/9oNyZzSGh8zAGWI2O02FWmg8LUY+a2n1bUVBUM14LP+TWhpdxHxDmeh2?=
 =?iso-8859-15?Q?mgMDKS3W238igBE+wf2c0iYNmNlDLerl4oNBOVOlxVEmDvAUL3lOQZfqe?=
 =?iso-8859-15?Q?jVCzuVtrT+P+FT+5GP2wBWSqSFUg03mk3YKoz+7135ZOe/poggEvnNyTs?=
 =?iso-8859-15?Q?iNMdVjVgPIqisyQEHoUEJOPWJxPl4uVSFLVl+U2qTCGy8mL2lumalrQKU?=
 =?iso-8859-15?Q?isBi0za6e5ae7UHd9N4RRqulBWax/duqsrkhlHfEAfO+6X8bt+asqrR0n?=
 =?iso-8859-15?Q?jaRGEfFriJK+PbykaxNZ2x1bqInCQPw0wipjS98ZL8UiXcotb4rx9PhU2?=
 =?iso-8859-15?Q?tY9bGX1rjuh3EnMwltn+cJ8XWgIeOIa9zPHoNPZgkBDQf2tme4A7MI/HU?=
 =?iso-8859-15?Q?AZwoN5sVmVqt2+Y7wbNn7TXbE1F0PqkH05QmhX8aIbwjRaOKSjor9e2oT?=
 =?iso-8859-15?Q?L1aTJl3+IWS8b6hH7bCcKWTaANIKEstkMTlJ/8fuEbo+W3PBuZE/0jGun?=
 =?iso-8859-15?Q?qLD77FiFc5tWeRPPr5DTr5ZCkSTjYhvMeSrvLM1iwqz9Lo3YwvhsWkd7G?=
 =?iso-8859-15?Q?16/89?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 16:24:36.9018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 723b400f-e7c8-411f-a1ca-08d8a2a83f16
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWNXSfZ3AQzvG3JRgK4WqzqprFcSj/c63BpXjo7qgY26shkg8xuCY1Lawa5MK3l+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
Cc: Dave Airlie <airlied@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Mike,

what exactly is the warning from qxl you are seeing?

Thanks,
Christian.

Am 17.12.20 um 17:21 schrieb Mike Galbraith:
> ee5d2a8e549e90325fcc31825269f89647cd6fac is the first bad commit
> commit ee5d2a8e549e90325fcc31825269f89647cd6fac
> Author: Christian K=F6nig <christian.koenig@amd.com>
> Date:   Sat Oct 24 13:10:28 2020 +0200
>
>      drm/ttm: wire up the new pool as default one v2
>
>      Provide the necessary parameters by all drivers and use the new pool=
 alloc
>      when no driver specific function is provided.
>
>      v2: fix the GEM VRAM helpers
>
>      Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
>      Reviewed-by: Dave Airlie <airlied@redhat.com>
>      Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>
>      Tested-by: Huang Rui <ray.huang@amd.com>
>      Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F397081%2F%3Fseries%3D83051%26rev%=
3D1&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C5e5b079ebef74f3ef56b0=
8d8a2a7c416%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637438189325014013=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D7dT4qkc4SEBLYDZwl5V4glm9ynvFHwAVdzn3y7e=
O7Kc%3D&amp;reserved=3D0
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
>   drivers/gpu/drm/drm_gem_vram_helper.c   |  4 ++--
>   drivers/gpu/drm/nouveau/nouveau_ttm.c   | 14 +++++++++-----
>   drivers/gpu/drm/qxl/qxl_ttm.c           |  5 ++---
>   drivers/gpu/drm/radeon/radeon_ttm.c     |  4 ++--
>   drivers/gpu/drm/ttm/ttm_bo.c            |  8 ++++++--
>   drivers/gpu/drm/ttm/ttm_memory.c        |  2 +-
>   drivers/gpu/drm/ttm/ttm_tt.c            |  5 ++---
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  5 +++--
>   include/drm/ttm/ttm_bo_driver.h         | 11 +++++++----
>   10 files changed, 36 insertions(+), 26 deletions(-)
>
> git bisect start 'drivers/gpu/drm/qxl'
> # good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
> git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
> # bad: [accefff5b547a9a1d959c7e76ad539bf2480e78b] Merge tag 'arm-soc-omap=
-genpd-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad accefff5b547a9a1d959c7e76ad539bf2480e78b
> # bad: [d635a69dd4981cc51f90293f5f64268620ed1565] Merge tag 'net-next-5.1=
1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad d635a69dd4981cc51f90293f5f64268620ed1565
> # bad: [0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb] Merge tag 'arm64-upstre=
am' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect bad 0ca2ce81eb8ee30f3ba8ac7967fef9cfbb44dbdb
> # bad: [f8aab60422c371425365d386dfd51e0c6c5b1041] drm/amdgpu: Initialise =
drm_gem_object_funcs for imported BOs
> git bisect bad f8aab60422c371425365d386dfd51e0c6c5b1041
> # bad: [c0f98d2f8b076bf3e3183aa547395f919c943a14] Merge tag 'drm-misc-nex=
t-2020-11-05' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
> git bisect bad c0f98d2f8b076bf3e3183aa547395f919c943a14
> # good: [6a6e5988a2657cd0c91f6f1a3e7d194599248b6d] drm/ttm: replace last =
move_notify with delete_mem_notify
> git bisect good 6a6e5988a2657cd0c91f6f1a3e7d194599248b6d
> # good: [f566fdcd6cc49a9d5b5d782f56e3e7cb243f01b8] drm/i915: Force VT'd w=
orkarounds when running as a guest OS
> git bisect good f566fdcd6cc49a9d5b5d782f56e3e7cb243f01b8
> # good: [e76ab2cf21c38331155ea613cdf18582f011c30f] drm/i915: Remove per-p=
latform IIR HPD masking
> git bisect good e76ab2cf21c38331155ea613cdf18582f011c30f
> # bad: [268af50f38b1f2199a2e85e38073d7a25c20190c] drm/panfrost: Support c=
ache-coherent integrations
> git bisect bad 268af50f38b1f2199a2e85e38073d7a25c20190c
> # good: [e000650375b65ff77c5ee852b5086f58c741179e] fbdev/atafb: Remove un=
used extern variables
> git bisect good e000650375b65ff77c5ee852b5086f58c741179e
> # bad: [461619f5c3242aaee9ec3f0b7072719bd86ea207] drm/nouveau: switch to =
new allocator
> git bisect bad 461619f5c3242aaee9ec3f0b7072719bd86ea207
> # good: [d099fc8f540add80f725014fdd4f7f49f3c58911] drm/ttm: new TT backen=
d allocation pool v3
> git bisect good d099fc8f540add80f725014fdd4f7f49f3c58911
> # bad: [e93b2da9799e5cb97760969f3e1f02a5bdac29fe] drm/amdgpu: switch to n=
ew allocator v2
> git bisect bad e93b2da9799e5cb97760969f3e1f02a5bdac29fe
> # bad: [ee5d2a8e549e90325fcc31825269f89647cd6fac] drm/ttm: wire up the ne=
w pool as default one v2
> git bisect bad ee5d2a8e549e90325fcc31825269f89647cd6fac
> # first bad commit: [ee5d2a8e549e90325fcc31825269f89647cd6fac] drm/ttm: w=
ire up the new pool as default one v2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
