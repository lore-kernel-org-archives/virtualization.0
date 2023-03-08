Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2769C76188
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8098181200;
	Wed,  8 Mar 2023 14:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8098181200
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uk1riDgh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8Om0jhbx5YR; Wed,  8 Mar 2023 14:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1D8181091;
	Wed,  8 Mar 2023 14:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1D8181091
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5E60C0071;
	Wed,  8 Mar 2023 14:40:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F6AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2744040309
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:40:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2744040309
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=uk1riDgh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8dfYlvc5D-C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:40:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDA8440305
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDA8440305
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBRmUuY5ZCk2BP4AkIu6smcnRXoOU1HCUbnr93bCCIxt5DWqTZKP37xWzw8WouQpMeozbEIUpAXO7cZ1MOpbGJCNa6JbO2T02IEoe+mHiOacc1w9PpBQ8A6/A+VrEVN7Uikj+PINShV5LRtBltbPmRn4HuROMxCeZL77ApiHoeyLYfc4p9Ul1OE7hpfkJkv7AP8IwxLFQ+LlIpTID01mGtgfFbTYxx9u4Rbs4twUomKAXIaX01OXdWEvJ/lIx4ge1p9K3muB3A5CU+dbMLHxdTBmnqg6a1EWkVoyZ60WRCEJRhAa2/ylUPwVWaoje+sVeBgQYm1FSPGzOg66uMnAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vO2iP+Yfs4faS1xB5RHxxpuOrbf2mMN3aw7IAsEKD4=;
 b=GIa6PwhDryqE3LbruOZuJvNgMcCUICJY7smINsowPKrQ9hgbJC6XXay4Ayelk5FBctnSX3yIYDzhTi3OoIu6bPQCAxxapBgfQeWPkAQKstI00hVwFeaggPFgvROasYvIfHG/q1nZMPG62NDcmbirpakHEyr/lA1hAERhnzGliwTBExBbQQTuJjHTpdLkr1ZFX9h/4wt+B5MXpKeTmANQ+bMxGrZVJu9iij6iFESJNKAGJYuVfm9xk1QQnJJw7luzAG4RKonErYE5WfW1RUhM91gl1mBKwKomdT6smfYglvmFE5Jp8TPAIRO+8BDqvCjPdXQ/bDCjCfGt9+ou3+tfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vO2iP+Yfs4faS1xB5RHxxpuOrbf2mMN3aw7IAsEKD4=;
 b=uk1riDghlu4qj+AKUfbW+D8wW/Q03JezoB/1be7beGygYWP+qlC7YVWQjgivVixB1LYA8HzuSGp87DD+anTuhUQbyNDZUjdH94kukJR32Nc49gHfiZjfSZI2JRP5Sv7q7BNFRM6tRgpOF5+H7Uj9GsX9025YcHoj36TA94FTiMJ2jDTlRj0vly4Nj4T9QD2MgklL9qzTz/tMIb7GSHoleMfBr9cyuxdVjENMbE0ZQhX3a3b03y4NIJwF0hevEzHhSB1HB4K+rfE2p52yyc4oTTVp7L3FKamHr5ihdN9Z09qPH2PzlFuVfq03J20V1NY5oU1KogwDUP8XSgSZJuLpiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 14:40:12 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:40:12 +0000
Message-ID: <cc5de402-ad79-7bce-74d3-77356a6fb66a@nvidia.com>
Date: Wed, 8 Mar 2023 09:40:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
 <20230308091442-mutt-send-email-mst@kernel.org>
 <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
 <20230308092541-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308092541-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4819f793-7743-4a90-be86-08db1fe3061e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OTYWIvJJr/HL46uXuwpfNjZdKPvhttofj6UpfCY2DaQKsZu+JuTwmogVIIdKB1SN1ISyTIAcfD+776YrMtQQMEgdAnUycbR50Z/jfOwRn1KrOawh1hc7nkyqd+9PA+VtoIfytv9d/EBBbr5l9+k5tUHG/a1RqNy9tp6Y0dP4ZwFSO+ppEVFG7sXO1+ZYFyFWJbwKNPPjAARoPFWj1z5euZwC7k3U5MgznYjnFDC/HkwdBKjlohJzBTjZA8tcaQUfC6HlPazLvMRPSTOWKB4YmefqXgBxNB8/4c/56os8l5zoZVTiCpxuWxY/4UR238CKNoTXzShzEj09cJb0Ica0Od0SHVpG913TNga0Sg3OeZ+344jNF8sytsoJGRYr/X54iF0dtg6nmZqz1r0KgDdte8B7Xmg3DiYwdtqXtWht0X1tfqwnguWy8okFc2lcEU0iotK5BeOk0w9AKTYGBQ57MI8fpG7Q6nWDHDLdSd+FZ5k5uhErDYZdaqt4wmCtEyCXRFapb+IteTdRhzTGEtqzMy/e9unswGunvYegJ54ecX5HMLn496+KrWdjtdgE0BI20iuTaS1KH06jM4CugyD7MeFAJzB/r+U5SEQO1Pg2cKHlSImXUYQyPKeLf+6oKHdOaeQH3b+L8DgMMpsl2JB0R3edjSyJNaWcB4U9nrqll/Yukzm888R8aI7Y3JNueEeLv2Reiay9/SCsyl2vyZclEY56UoDjCEWYjGlZSceDWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199018)(6916009)(31696002)(86362001)(66476007)(38100700002)(36756003)(5660300002)(2906002)(66946007)(66556008)(4326008)(8676002)(41300700001)(8936002)(186003)(6506007)(53546011)(2616005)(26005)(6512007)(83380400001)(478600001)(6666004)(54906003)(6486002)(107886003)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FKMVljZkc4RWdvMXJiMm1OTUU4WkNVZ0ZXMWNFOHFKeE5VVlVoWVhMdml2?=
 =?utf-8?B?R1pvWnlVRlJYejUrSW1FVlNuSEo4TlBrN2FzVDhGSkl1VFloc083NVQ5c3M2?=
 =?utf-8?B?QnFqUC9rRzB6bWp4ekE0UFFHNHdVWkxGNmpBKzR1MlNaNzNKQm9qTjVxTS9t?=
 =?utf-8?B?RUJnYjRvQ2JtRTc4eEgyNW45Z29UUjJXNjY4ZmFZSUIxSGcrT0l4NE5WYkxT?=
 =?utf-8?B?bUFmL0ZHYTRoTTZxNCtESlkzd3lhMmhoT3JsbGRLTFlvUWEyaW1DaVpLU3ZQ?=
 =?utf-8?B?RHREdUlnUkhOTVU2b2FHdFJyMGZ3akdTRlV2cDBydk9OcFZyS0l1d3JrWGdU?=
 =?utf-8?B?NGpydndpclRQL1R6dTdiaW1zeUhJeWJSTDJ1QzlTdDI1WlArcUN1NU1sSHo3?=
 =?utf-8?B?Z2d2WFlhN0lxWURGMjVDRkxKMWpJRmpIZWVWVi9RUE10VTZCNFgveFZiLzZ2?=
 =?utf-8?B?WDlVY2ZBTGZodmRqNUJFMWdsNG8rWmkxSFRpbUdJa3JZQ0VkdGJIMnEzT2hw?=
 =?utf-8?B?dEFNNm1kMFZsK0tLZ2lIUXgzalo1ZElEaXFNTUtwQmN5eGN1YnlmR2pCSUxt?=
 =?utf-8?B?bUJ1TVJZZCtCUHVSSDgyY0RVOVdxak9PUlk4blBNRkY2ajBJaWlpSUZONGhF?=
 =?utf-8?B?cytMdXFibTRPYVhMSnZ0cmUrd20rSkVaTU1iUjNxbWdoK29IWXNFSWU3Yjk1?=
 =?utf-8?B?cis3cXZaRjU2WmVTanRQMWNYbFdIUHZSa095ZUtEVFdmajFpNDE4bkNlcUc4?=
 =?utf-8?B?c2IyekFvR0haNytVbkNDcG96Qyt1Sy9BUnhwLzJhbDlMVGxRUzBxb0srZWR0?=
 =?utf-8?B?Rjk3Q0FBWEFLMDJuekg2b3hhaEx4MXVEZkliVWdMcWtIQlZkbkZhek9qUFcr?=
 =?utf-8?B?aXdWdStPa0prdmYzZDRyT0E1THdqSGphczZuaTZpYWQvalduM2N6cUNHUjRU?=
 =?utf-8?B?TWdQM0hUVjIvdVhZV2tPME4xaGpWRkNyaUY5YWV2cEF0eFpBR1FvUDhQUG0r?=
 =?utf-8?B?MjBESHIwR2V5NGdDMmJRR1RqR0hzS1lDOFJrY2NRSlgwcGtLQXRzMXloSkRj?=
 =?utf-8?B?L3p6S0FmdVE4V0dtS0FqZTRlOW5DSmErZklGSFdENXpCampkT3R5TEJEbjRl?=
 =?utf-8?B?ZEFEblZuOFVGblczVTF1dStKdnZVNEwrMjhRMnRkOWk4Ryt4cEdsSTZFbXln?=
 =?utf-8?B?cW5JbXc0NVQzZVBtcG9kSnhoYmNRWERFNDZMTlFmTkM5R3N6eENoN0NSdnRt?=
 =?utf-8?B?cXZ5d0R6TUtudzYvUFNQaVd3SHREcm44eU13RitLdEx4Y0NyQ09yNlFkbFBG?=
 =?utf-8?B?UEJMNm1GcnljVWEyQWgxbytVKy9mb09XMWc3dFl5SVQ3c0JJL0c0cmhmb3pv?=
 =?utf-8?B?UVEvZlgwWmVPbFAwVmcrR0FtNWRHV1VHS1RTNUlBRUh0L3VJS3BIUGhROTRw?=
 =?utf-8?B?aDJDZ2p6V05xSnpaaXhzczcyOXcrV0M4V3BSK1lFRlh0ZTRobHJrOTY0R2Z2?=
 =?utf-8?B?M0JpeERDQ2tKa3A1VnlleGl5QXE1N09Dc0pBWWFkK0VqeWJmVHVORGszRTBU?=
 =?utf-8?B?NmtkalFEZERXOGJEeVZsZmlidDlIY3FaY25LQ09vUGxSbVpGWHA5NlZrS2d6?=
 =?utf-8?B?K0YzNUNLUnZzZExvUnpXWjFGVkI5QTd1YXA5WDM1WDg5QkloQit0a0RWVHdl?=
 =?utf-8?B?MnBDV2hIWlloSDVUUEgzUy9ScFhlc3dQeDlhckRLTk1qdk1Za1R2bGNJeS9r?=
 =?utf-8?B?U05IcEhuYmgrNmpnUDFKWnJDYXFwV2hRNGgvUFo3T1Zabm5Kb3MrczdxR1o0?=
 =?utf-8?B?S25rNFJjUXphUXNSQ0RNTDNGc1d0TktabGNtUlphdC9Uakg4WW4ycGx6bUFM?=
 =?utf-8?B?bkt4Zk4zR2NNQ3JSOXB6Tmg2ZnVDcTU0WjNvRVJCYlR3ekkrMkVHWC9ibkRj?=
 =?utf-8?B?ampuTlZwRkRVSTIwYVJ6cjU5UGRySTBKNHlDdlpPNlIvaGgxZXpQblQ3cE1Z?=
 =?utf-8?B?V1Q5VWR5K0VpcnZBRWxQVXNBeFN6SEdBNHBFSzdHK1lxMHRMUFFZSjFDc1Bv?=
 =?utf-8?B?YnpVU1pGN2dnRmlYZHRxRlJaU0RjT3BXZVB2NEVSak93cy9kTVpBb0xoeFo4?=
 =?utf-8?Q?0oMKtBVqUWkZHotb4Paus1sSS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4819f793-7743-4a90-be86-08db1fe3061e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:40:12.5022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgD34h2uFliHIM6cQ6L23xOYnrt2NuIwqFef5iQg0zfZmXL47h6AbUhPIt3n69p4UOj1ZDAtuPmEpSr7bM/iZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTAzLTA4IGEubS45OjI4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPiAK
PiAKPiBPbiBXZWQsIE1hciAwOCwgMjAyMyBhdCAwOToxOTozOEFNIC0wNTAwLCBGZW5nIExpdSB3
cm90ZToKPj4KPj4KPj4gT24gMjAyMy0wMy0wOCBhLm0uOToxNiwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMKPj4+Cj4+Pgo+Pj4gT24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMDk6MDc6NDlB
TSAtMDUwMCwgRmVuZyBMaXUgd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDIwMjMtMDMtMDggYS5t
LjEyOjU4LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRp
b24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBPbiBUdWUs
IE1hciA3LCAyMDIzIGF0IDExOjU34oCvQU0gRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+IHdy
b3RlOgo+Pj4+Pj4KPj4+Pj4+IEFkZCBjb25zdCB0byBtYWtlIHRoZSByZWFkLW9ubHkgcG9pbnRl
ciBwYXJhbWV0ZXJzIGNsZWFyLCBzaW1pbGFyIHRvCj4+Pj4+PiBtYW55IGV4aXN0aW5nIGZ1bmN0
aW9ucy4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVsaXVAbnZpZGlh
LmNvbT4KPj4+Pj4+IFJldmlld2VkLWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4+
Pj4+PiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+Pj4+Pj4g
UmV2aWV3ZWQtYnk6IEdhdmluIExpIDxnYXZpbmxAbnZpZGlhLmNvbT4KPj4+Pj4+IFJldmlld2Vk
LWJ5OiBCb2RvbmcgV2FuZyA8Ym9kb25nQG52aWRpYS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAg
ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjUgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLQo+Pj4+Pj4gICAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAxMiArKysrKyst
LS0tLS0KPj4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE5IGRl
bGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gWy4uLl0KPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiAt
LyoKPj4+Pj4+IC0gKiBUaGlzIHNob3VsZCBwcmV2ZW50IHRoZSBkZXZpY2UgZnJvbSBiZWluZyB1
c2VkLCBhbGxvd2luZyBkcml2ZXJzIHRvCj4+Pj4+PiArLyBUaGlzIHNob3VsZCBwcmV2ZW50IHRo
ZSBkZXZpY2UgZnJvbSBiZWluZyB1c2VkLCBhbGxvd2luZyBkcml2ZXJzIHRvCj4+Pj4+PiAgICAg
ICogcmVjb3Zlci4gIFlvdSBtYXkgbmVlZCB0byBncmFiIGFwcHJvcHJpYXRlIGxvY2tzIHRvIGZs
dXNoLgo+Pj4+Pj4gICAgICAqLwo+Pj4+Pgo+Pj4+PiBBbnkgcmVhc29uIGZvciB0aGlzIGNoYW5n
ZT8KPj4+Pj4KPj4+PiBIaSwgSmFzb24KPj4+PiBUaGUgb3JpZ2luYWwgY29tbWVudCBvZiB0aGUg
Y29kZSBoYWQgYSBzeW50YXggcHJvYmxlbSBhbmQgY291bGRuJ3QgY29tcGlsZSwKPj4+PiBJIGZp
eGVkIGl0IGhlcmUKPj4+Cj4+PiBUaGlzIGlzIGhvdyBpdCBsb29rZWQgYmVmb3JlIHlvdXIgcGF0
Y2g6Cj4+Pgo+Pj4gLyoKPj4+ICAgICogVGhpcyBzaG91bGQgcHJldmVudCB0aGUgZGV2aWNlIGZy
b20gYmVpbmcgdXNlZCwgYWxsb3dpbmcgZHJpdmVycyB0bwo+Pj4gICAgKiByZWNvdmVyLiAgWW91
IG1heSBuZWVkIHRvIGdyYWIgYXBwcm9wcmlhdGUgbG9ja3MgdG8gZmx1c2guCj4+PiAgICAqLwo+
Pj4KPj4+IEkgc2VlIG5vIHByb2JsZW0gaGVyZS4KPj4+Cj4+IFllcywgeW91IGFyZSByaWdodC4g
SSBtYWRlIGEgbWlzdGFrZSBoZXJlLCBJIHdpbGwgZml4IGl0Cj4gCj4gTmljZSBidXQgdGhlIGJp
Z2dlciBwcm9ibGVtIGlzIG5vdCB0aGUgbWlzdGFrZSAtIGl0IGlzIHRoZSBwb3N0aW5nIG9mCj4g
dW50ZXN0ZWQgY29kZS4gSXQgbWlnaHQgYmUgYW4gb2sgdGhpbmcgdG8gZG8gLSBhcyBsb25nIGFz
IHlvdSBtYWtlIGl0Cj4gc3VwZXIgYWJ1bmRhbnRybHkgY2xlYXIgdGhhdCB0aGlzIGlzIHdoYXQg
aXQgaXMsIGFuZCBleHBsYWluIHdoeQo+IHlvdSBhcmUgcG9zdGluZyBpdCBub3cgYW5kIG5vdCBh
ZnRlciB0ZXN0aW5nLgo+IAoKSW4gZmFjdCwgSSBjb21waWxlZCBhbmQgdGVzdGVkIGxvY2FsbHku
IEkganVzdCBsb29rZWQgaXQgdXAgYW5kIGl0IG1pZ2h0IApiZSB0aGF0IEkgd2FzIG1pc3Npbmcg
YSDigJxnaXQgYWRk4oCdIGFjdGlvbiB3aGljaCBjYXVzZWQgdGhlIHByb2JsZW0uIApCZWZvcmUg
SSBwb3N0IHRoZSBwYXRjaCBpbiBmdXR1cmUsIEkgd2lsbCBmaW5kIGEgY2xlYW4ga2VybmVsIHNv
dXJjZSBhbmQgCmFwcGx5IG15IHBhdGNoIGZvciB0ZXN0aW5nIGluc3RlYWQgb2Ygb24gdGhlIGJy
YW5jaCB3aGVyZSB0aGUgY29kZSBpcyAKbW9kaWZpZWQsIHNvIGFzIHRvIGF2b2lkIHRoaXMga2lu
ZCBvZiBwcm9ibGVtIGZyb20gaGFwcGVuaW5nIGFnYWluLiAKVmVyeSBzb3JyeSBmb3IgdGhpcyBw
cm9ibGVtLCBJIHdpbGwgYmUgY2FyZWZ1bCBhbmQgcGF5IGF0dGVudGlvbiB0byBpdCBsYXRlcgoK
Pj4+Cj4+Pj4+IFRoYW5rcwo+Pj4+Pgo+Pj4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
