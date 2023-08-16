Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A3BC0015E
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 03:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DEF141507;
	Wed, 16 Aug 2023 03:01:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DEF141507
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z3Ac4P4s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JICsbUYurara; Wed, 16 Aug 2023 03:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37EA1405F8;
	Wed, 16 Aug 2023 03:01:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37EA1405F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2EB0C0072;
	Wed, 16 Aug 2023 03:01:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9334DC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42927405F8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:00:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42927405F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WzCFl4Ysprt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:00:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::609])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6D50400C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:00:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6D50400C6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le/xzgpb35FDLKwVZKjXmctoK3ax5xC059cOhek+Uw6gAt9aWCnjh8b2PZOg+B3FEd8sR3AZcwQwB4MHXTqkIzS4JrvD6qlLJLtZwmFN1AYLyVUFtXojc3CV2okpHa5G64DWN6ouO6jij7t75n/b57bQGWMNKfelTaKxId83pi6NvjYzjOg1psV3rCPywR1iiM3YBbpdsG4rCohuuQ1DcCs9GwxSkr5j/bFzpO0fjpwbIM7zFbfhArjMMJT52NNwkhNCczd2YkYDGK1Igk6H6eRKsVUbxqtCpMQa3jImsJyQZr0drGjOfIOGbbKIrvFfuykG5JzQ4ZiycnA7q8FQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCyOIP/uyxVyZtyqLq9xfiQS29wIxXRBNMOAsqWVxyo=;
 b=lSRPo3K0FWFvHAkf9PQ66D9OtS8jAkN5mlNFohAw/XneBgaK+cJzdzxHLQEaOGUOc6SCpWAa1wJP2nYTYdzPIiLGXSKNbk/65y1aNcFWabXQaOLeKfvV8PsLr50OA4oLGr46SvrvL16VayJe2Q0KjEKb6ZGRAkr0w74REWdXvURun3po/K31EBWbGrQLhT6XeS2vXGghxd4NnUNty7v6dbHNSe+S49tRrZAIN+fUzW/OL3OhYW5FfIiXWLihNArzfDCgRff1kzB4S8Qa7yQVy5Q0PrgPhz7DlQiMSQvOmrg///CFI7tqVDCSbSCm8ukO5SE+vOIar9AjYiFyHBFqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCyOIP/uyxVyZtyqLq9xfiQS29wIxXRBNMOAsqWVxyo=;
 b=Z3Ac4P4s7ndhB6EsMpGR2p7pvYuyQRHyQgZOy37FyvXwhZJXJmQLJ9h3p/+wagMQtarAiO/FCeSCf9LMxROKN+Bj3ixcWJitRJn21wxCIVp1JvNH5NS6cGunbH6W7j4QI8c9BaxeWIHdmQfXlLdbX31BZsSkoKH0LJuGPmkQ/9CbVE1VYycvJ0h8QujVkbI6ITDOTYb9KF1hcrR/QIfCQZOdmXOteXkQIJqLPc0Pb7ekl7dgqDiNrXlhIfUw9UrUMeRDGNwZoCSGxfgPFa/hwooV78JIKUmDYT7N7whJo+94XYbvQ49r2wrt10V8YArBNHMxuAU6HIZWOezZBOvtXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 03:00:54 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 03:00:54 +0000
Message-ID: <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
Date: Tue, 15 Aug 2023 23:00:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to avoid
 typecasting
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Simon Horman <horms@kernel.org>
References: <20230814171845.65930-1-feliu@nvidia.com>
 <ZNtYpohWyjnb883M@vergenet.net>
 <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>
 <ZNunz1hbqPKpcOgA@vergenet.net>
 <CAF=yD-L+d34Uuvt3sOFOnxXhMmoMXNfHzcaSPk=t1PtiPUHZ1g@mail.gmail.com>
In-Reply-To: <CAF=yD-L+d34Uuvt3sOFOnxXhMmoMXNfHzcaSPk=t1PtiPUHZ1g@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: d6118c14-2cc0-4dfb-575f-08db9e050182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MhDqEIcGc9ltMPSS9IHEZFS7zoWTyjUpbTBTS5NjaUf7CVDXeG/wlHpTiY8jnbgV+BxnqBZlpMSyPaJ6anqRpaZkhEgk4OLc9oi+79TDmN4MIiaVlWBIbrIiKF6jVXh1ZePHwbNJxSsDZpXtPoRv/NrTJmxmuMsHAYadBtZMH1kiguYe+1RV3eeoUL/vG8a+SGCAy4KBivqPpQ+4EPsBm4Z1RXMNKgTMUvgc++jkkefrbU+A2uR7BaKbE83AVHOALjy1XHN3RaMQgVAZOVB9TCnJTTvH5bQ2/kFH5LB2N7GTrf1dt0HICb+QMJlpSPuCRYf/btg3Ac7xqkjnmFH9LwEOfj4j4zEYQPMAI8snMwSXHcGEcKZARGJ8UEV6P0CBDT0qlCOhLK8iH5giqETKzrZ4D0T4HD80EPncdL7tLPc8OIZslnJf4kbVKEAMYS4GczzLeNE+wn6KTC1aUvusMJBu4QRTHB+DXoW/yVikeXdgtPXNLJZw/vVrjAgoRftvULbrSMQvcoQlQr3/twO35ioreL7AEVnFzv5pQPGeJqfrYTn5krunjtpuwOXcZjZ05ehsKW7VKxevXvANOEuxttATrpMqjHhqCbWzax0cV2HJB4yhgu8fH57wgVilpGgXz0awADCohInuAF2xjpDjLZPpZ4AHnKG8lxkXVG3bnNCDwLsoQfAB65658RDJ5TB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(54906003)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(966005)(26005)(110136005)(7416002)(5660300002)(2616005)(83380400001)(41300700001)(316002)(53546011)(8936002)(4326008)(8676002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJnYWRuYWR4RDJsN3ZMeW1zdkRQSEluK2VEYW9WSS9Ua1NUeTIwQkZVN1Zx?=
 =?utf-8?B?bHhHOFlvOWI5ZkpiVXZGRnQvVTlzVGEycWZFbmNPZ3lJL3N1UWZKa1ZQNWRy?=
 =?utf-8?B?aFdVcVdDRHd5UlVoNUtvVldzckVNRFd3SkFYZWQ1TE5CRGIxaFkwTG1qK0RF?=
 =?utf-8?B?bmFnL1FTQ3dveW50ZXgzazR5OUo0NDdaN2xLMmxiWU9iZjNWQTRlU1Ribmox?=
 =?utf-8?B?UzltTTdRazlNcjUxNkRhVmY0cGMvWW5CdkVUSjZDUHRES1NxS0Q2RlJwMDZa?=
 =?utf-8?B?SVMrVXRaQ3pRR0VNZTZ1QzRjcnZkeTJlU1p4NDBXdUJpU1p1aVVRUTNkVWda?=
 =?utf-8?B?eUdwS2JsZ0ltMklBVUdYSjJSSkd4THlQdDFiNmVDWlVMTW1VbFdlQkU4Sit3?=
 =?utf-8?B?SmxjUTFIMjVWVUFrV080YXQ1MEE0YStVbFI3QlRpM3FHYTZsUGpaK1F4Mjc2?=
 =?utf-8?B?b0tNcWhPWmdscm9VOTI5cGNwQnZISTdQc0ZrYVcrY0xweWRpWXFuaDZYMVJK?=
 =?utf-8?B?VW5UdUpKaGtlNEJTL25qSFpWcG5xMXNBdTlKRlQwZi8xTlRsc3N4TGVUTXVQ?=
 =?utf-8?B?elhoT1BJKzRiTnR5Z2hqOGEwTU1iaEtCaU1wMG84UkFqZDJndG4xYjNDQVIy?=
 =?utf-8?B?OElKVmN2Qmw3MVBWcGlZbkgwbkZmTFJveThhcDFrQUZnMDZnY1NudHluSVBK?=
 =?utf-8?B?TmlndnZpcEpwdUlyZklaODBScGpydmRWTTE2VkFNYjBxM1k4YlJ1RjhUc3c1?=
 =?utf-8?B?WXJ1enE3OHRBNnR1bG92R0ZxbHo1V0d2N0g0V1BObExpSTNzcVc2NG0vV3E4?=
 =?utf-8?B?dlRwVmFMNlR5VFd5dXlrem5TdjNMU0hPazNqc01CY2UrUW5xSmNoTjl2clJV?=
 =?utf-8?B?VGFtSGkrR3hXdjFSQ3huNTZQM045NjhBYzlXUWZoOTh6cW9lSldUMEdGQlht?=
 =?utf-8?B?NjAvVEI2ZWxWVEFhMmZkOXVBb0UvZ0ZVZUY5MG9sbDhETVhYUFJyK1AwdUFa?=
 =?utf-8?B?emtSODZZbmZnY0Z5OWY3UWs0VE9rNDF0eHF3QVhsUGFiMnBuSndoK0xNc1M3?=
 =?utf-8?B?UzFEWWp1SWZiV2xBcTlSaTBKZjJPbGVSNVkrbExCZE1sUkQ5QzBzSXltNUpz?=
 =?utf-8?B?OTdCV1lhai9Mclg0NUZqSEMxUzNlWWZFemVLRWJhZTQ1Tkh3NDF2TFRHNGEx?=
 =?utf-8?B?NjdpMGM0cEF0WlhGL0VCTE56YlI3SE5aUjY2U1dlSEEyeXIrRHFRV0J3WEoy?=
 =?utf-8?B?VVM1UDM5ZWp4N2krWm1tNXNFc0NSbUZ1b1BNdXhPWXp3MXpKelAyanBXZkU4?=
 =?utf-8?B?Qy94QVZOK3poYnU1c3ArTmtYV3p5NXVKd0ZDTWpMZGVTMC9KSDZpSUxCVmY3?=
 =?utf-8?B?YlZsQVpCWnpwSC9HUFVQdVZUVHhIZUh0U0k1UkNZTithQ0pOYmEvNUErMHk0?=
 =?utf-8?B?bitUOTEyOW1Ba2JId0hjR2lSeU1VQ3J4ZlpNeXoyelhDdTNYT1NJTzAvMTBP?=
 =?utf-8?B?aW5YbUNKcmFaek9jbVgvd1ROWlV6WDljdnNTU3BId2JLRXdwbjZySUZKaHNR?=
 =?utf-8?B?RkpEUW5ydTE3Rm1pY2lSTGJ4TkZsc3BabFluMlJ2RjdsUUgzdXdmTkgrVzVm?=
 =?utf-8?B?NVd0UE1jalJQN0VDbTVOQ2dpNW9nZWFYeU5Kd01HQUFVY3NEcFdRdWpiczZD?=
 =?utf-8?B?elpZSythS3o4a1laK0J4T0hva0pXTGNLYjdIOHIvSy9HbmxUcjR4R21UdlB3?=
 =?utf-8?B?T0pDTHEvd0FpamRRRVZBdTB1NDJmTURocnhaNytYUGhpZFFpdEJmUTJPSlZh?=
 =?utf-8?B?MlREUGQxakhKWDdKbEtoM2dPblVNbGZ4aUJoejJpYmJRMEc4SGNOM2xiV2tB?=
 =?utf-8?B?WGovNE9Rd0ZnK2NvTllCaWVtNm8xNE1VZ2F6NktnVXd0UDd1TGtDVFlkYTdD?=
 =?utf-8?B?RTVOWTJtUXBRVCtSRFJzTklPUWhrSWhzY0piZ1dPNG1Jbzhhbm1GT3dadlda?=
 =?utf-8?B?UXJTbnZIVlRXM096Q1B1cHNGQVpBMEd4dDdpYnlWbGVTVEMvM2RBWUx5SlJ4?=
 =?utf-8?B?ZWVQakFtL043S001MTVrSUFtVmdZcEt1VkY1elp5bmlxZkM4SnpOdzQ0Mkxv?=
 =?utf-8?Q?RuIwbAswTyz6jTa+CbOkffEYc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6118c14-2cc0-4dfb-575f-08db9e050182
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:00:54.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXFke1T6OW4te5BenTAvAH9WCARbRsyWc1l/AJ6TITqjIIKfsYNurxnj6mCiN1+Gk2r++gWUp2RvsjZz92om1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

CgpPbiAyMDIzLTA4LTE1IHAubS4yOjEzLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gCj4g
Cj4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgMTI6MjnigK9QTSBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAxMTowOTow
MkFNIC0wNDAwLCBGZW5nIExpdSB3cm90ZToKCj4+IFRvIGNsYXJpZnk6IEluIGdlbmVyYWwgbmV3
IE5ldHdvcmtpbmcgZmVhdHVyZXMgZ28gdmlhIHRoZSBuZXQtbmV4dCB0cmVlLAo+PiB3aGlsZSBi
dWcgZml4ZXMgZ28gdmlhIHRoZSBuZXQgdHJlZS4gSSB3YXMgc3VnZ2VzdGluZyB0aGlzCj4+IGlz
IG1vcmUgYXBwcm9wcmlhdGUgZm9yIG5ldC1uZXh0LCBhbmQgdGhhdCBzaG91bGQgYmUgcmVmbGVj
dGVkIGluIHRoZQo+PiBzdWJqZWN0Lgo+Pgo+PiAgICAgICAgICBTdWJqZWN0OiBbUEFUQ0ggbmV0
LW5leHRdIC4uLgo+Pgo+PiBTb3JyeSBmb3Igbm90IGJlaW5nIGNsZWFyZXIgdGhlIGZpcnN0IHRp
bWUgYXJvdW5kLgo+IAo+IFJpZ2h0LCB0aGlzIHNob3VsZCBnbyB0byBuZXQtbmV4dC4KPiAKV2ls
bCBkbywgdGhhbmtzCgo+Pgo+Pj4KCj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX25ldC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4+PiBp
bmRleCAxMmMxYzk2OTk5MzUuLmRiNDBmOTNhZThiMyAxMDA2NDQKPj4+Pj4gLS0tIGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaAo+Pj4+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX25ldC5oCj4+Pj4+IEBAIC0yMDEsNiArMjAxLDEzIEBAIHN0cnVjdCB2aXJ0aW9fbmV0
X2hkcl9tcmdfcnhidWYgewo+Pj4+PiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkciBoZHI7
Cj4+Pj4+ICAgICAgICAgX192aXJ0aW8xNiBudW1fYnVmZmVyczsgLyogTnVtYmVyIG9mIG1lcmdl
ZCByeCBidWZmZXJzICovCj4+Pj4+ICAgIH07Cj4+Pj4+ICsKPj4+Pj4gK3N0cnVjdCB2aXJ0aW9f
bmV0X2NvbW1vbl9oZHIgewo+Pj4+PiArICAgICB1bmlvbiB7Cj4+Pj4+ICsgICAgICAgICAgICAg
c3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19yeGJ1ZiBtcmdfaGRyOwo+Pj4+PiArICAgICAgICAg
ICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoIGhhc2hfdjFfaGRyOwo+Pj4+PiArICAg
ICB9Owo+Pj4+PiArfTsKPj4+Pgo+Pj4+IERvZXMgdGhpcyBiZWxvbmcgaW4gdGhlIFVBUEk/Cj4+
Pj4gSSB3b3VsZCBoYXZlIGFzc3VtZWQgaXQncyBhIEtlcm5lbCBpbXBsZW1lbnRhdGlvbiBkZXRh
aWwuCj4+Pj4KPj4+IFRoZSBleGlzdGluZyBjb2RlcywgdmlydGlvX25ldC5oIGlzIGluIHVhcGkv
bGludXgvLCBJIGFkZGVkIHRoZSBuZXcKPj4+IHN0cnVjdHVyZSBhbmQgZm9sbG93ZWQgZXhpc3Rp
bmcgY29kZS4gTXkgbW9kaWZpY2F0aW9uIGlzIHJlbGF0ZWQgdG8gS2VybmVsCj4+PiBpbXBsZW1l
bnRhdGlvbiBkZXRhaWwgbm93Lgo+Pgo+PiBUaGUgaGVhZGVyIHlvdSBoYXZlIG1vZGlmaWVkIGZv
cm1zIHBhcnQgb2YgdGhlIHVzZXJzcGFjZSBBUEkgKFVBUEkpLgo+PiBQZXJoYXBzIHRoZXJlIGlz
IHNvbWV0aGluZyBhYm91dCB2aXJ0aW9fbmV0IHRoYXQgbWFrZXMgdGhpcyBjb3JyZWN0LCBidXQg
aXQKPj4gc2VlbXMgdG8gbWUgdGhhdCBrZXJuZWwtaW50ZXJuYWwgZGV0YWlscyBkb24ndCBiZWxv
bmcgdGhlcmUuCj4gCj4gRldJVywgSSByYW4gaW50byBzaW1pbGFyIGlzc3VlcyBiZWZvcmUgaW4g
YSBkcmFmdCB0aGF0IGFkZGVkIHRpbWVzdGFtcAo+IHN1cHBvcnQgWzFdCj4gCj4gSWYgd2UncmUg
Z29pbmcgdG8gY2hhbmdlIHRoaXMgc3RydWN0dXJlLCB3ZSBzaG91bGQgZG8gaXQgaW4gYSB3YXkg
dGhhdAo+IGlzIGZvcndhcmQgcHJvb2YgdG8gZnV0dXJlIGV4dGVuc2lvbnMgdG8gdGhlIHZpcnRp
byBzcGVjIGFuZCB3aXRoIHRoYXQKPiB0aGUgZmllbGRzIGluIHRoaXMgc3RydWN0LiBFc3BlY2lh
bGx5IGluIFVBUEkuCj4gCj4gSXMgdmlydGlvX25ldF9oZHJfdjFfaGFzaCB0aGUgbGF0ZXN0IHZp
cnRpby1zcGVjIGNvbXBsaWFudCBoZWFkZXI/IEFuZAo+IGRvIHdlIGV4cGVjdCBmb3IgdjEuMyB0
byBqdXN0IGFkZCBzb21lIGZpZWxkcyB0byB0aGlzPwo+IAo+IFRoZSBzdHJ1Y3QgY29tbWVudCBv
ZiB2aXJ0aW9fbmV0X2hkcl92MSBzdGF0ZXMgIlRoaXMgaXMKPiBiaXR3aXNlLWVxdWl2YWxlbnQg
dG8gdGhlIGxlZ2FjeSBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmLCBvbmx5Cj4gZmxh
dHRlbmVkLiIuIEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB3aGF0IHRoZSBmbGF0dGVuaW5nIGJv
dWdodCwgdnMKPiBoYXZpbmcgc3RydWN0IHZpcnRpb19uZXRfaGRyIGFzIGZpcnN0IG1lbWJlci4g
QW5vdGhlciBkaWZmZXJlbmNlIG1heQo+IGJlIHRoZSBlbmRpYW5uZXNzIGJldHdlZW4gbGVnYWN5
ICgwLjkpIGFuZCB2MS4wKy4KPiAKPiBTaW5jZSBsZWdhY3kgdmlydGlvIHdpbGwgbm8gbG9uZ2Vy
IGJlIG1vZGlmaWVkLCBJIGRvbid0IHRoaW5rIHRoZXJlIGlzCj4gbXVjaCB2YWx1ZSBpcyBleHBv
c2luZyB0aGlzIG5ldyB1bmlvbiBhcyBVQVBJLiBJIGRvIGFwcHJlY2lhdGUgdGhlCj4gYmVuZWZp
dCB0byB0aGUgaW1wbGVtZW50YXRpb24uCj4gCj4gWzFdIGh0dHBzOi8vcGF0Y2hlcy5saW5hcm8u
b3JnL3Byb2plY3QvbmV0ZGV2L3BhdGNoLzIwMjEwMjA4MTg1NTU4Ljk5NTI5Mi0zLXdpbGxlbWRl
YnJ1aWpuLmtlcm5lbEBnbWFpbC5jb20vCkhpLCBXaWxsaWFtIGFuZCBTaW1vbgoKVGhhbmtzIGZv
ciB0aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24uCgpJIGtlcHQgdmlydGlvX25ldF9oZHJfbXJnX3J4
YnVmIGFuZCB2aXJ0aW9fbmV0X2hkcl92MV9oYXNoIHN0cnVjdHVyZXMgaW4gCnZpcnRpb19uZXQu
aCwgd2hpY2ggY2FuIGJlIGZvcndhcmQgY29tcGF0aWJsZSB3aXRoIGV4aXN0aW5nIHVzZXIgCmFw
cGxpY2F0aW9ucyB3aGljaCB1c2UgdGhlc2Ugc3RydWN0dXJlcy4KCkFmdGVyIGNoZWNraW5nIGtl
cm5lbCBjb2RlLCB0aGUgdmlydGlvX25ldF9oZHJfdjFfaGFzaCBzdHJ1Y3R1cmUgZG9lcyAKb25s
eSBhZGQgbmV3IG1lbWJlcnMgdG8gdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmLCBzbyB0aGUgc3Bl
YyBzaG91bGQgCm9ubHkgYWRkIG5ldyBtZW1iZXJzLCBvdGhlcndpc2UgdGhlcmUgd2lsbCBiZSBj
b21wYXRpYmlsaXR5IHByb2JsZW1zIGluIApzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCBz
dHJ1Y3R1cmUuCgpzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCB7CglzdHJ1Y3QgdmlydGlv
X25ldF9oZHJfdjEgaGRyOyAvKnNhbWUgc2l6ZSBhcyB2aXJ0aW9fbmV0X2hkciovClsuLi5dCglf
X2xlMzIgaGFzaF92YWx1ZTsgLypuZXcgbWVtYmVyKi8KCV9fbGUxNiBoYXNoX3JlcG9ydDsgLypu
ZXcgbWVtYmVyKi8KCV9fbGUxNiBwYWRkaW5nOwkvKm5ldyBtZW1iZXIqLwp9OwoKdmlydGlvX25l
dF9oZHJfdjFfaGFzaCBjYW5ub3QgdXNlIHZpcnRpb19uZXRfaGRyIGFzIHRoZSBmaXJzdCBtZW1i
ZXIsIApiZWNhdXNlIGluIHZpcnRpb19uZXRfaGRyX3YxLCBjc3VtX3N0YXJ0IGFuZCBjc3VtX29m
ZnNldCBhcmUgc3RvcmVkIGluIAp1bmlvbiBhcyBhIHN0cnVjdHVyZSwgYW5kIHZpcnRpb19uZXRf
aGRyIGNhbm5vdCBiZSB1c2VkIGluc3RlYWQuCgpzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjEgewpb
Li4uXQoJdW5pb24gewoJCXN0cnVjdCB7CgkJCV9fdmlydGlvMTYgY3N1bV9zdGFydDsKCQkJX192
aXJ0aW8xNiBjc3VtX29mZnNldDsKCQl9OwoJCVsuLi5dCgl9OwoJX192aXJ0aW8xNiBudW1fYnVm
ZmVyczsJLyogTnVtYmVyIG9mIG1lcmdlZCByeCBidWZmZXJzICovCn07CgoKc3RydWN0IHZpcnRp
b19uZXRfaGRyIHsKWy4uLl0KCV9fdmlydGlvMTYgY3N1bV9zdGFydDsJCglfX3ZpcnRpbzE2IGNz
dW1fb2Zmc2V0OwkKfTsKCgoKSW4gYWRkaXRpb24sIEkgcHV0IHRoaXMgbmV3IHN0cnVjdHVyZSB2
aXJ0aW9fbmV0X2NvbW1vbl9oZHIgaW4gdWFwaSwgCmhvcGluZyBpdCBjb3VsZCBiZSB1c2VkIGlu
IGZ1dHVyZSB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIHRvIGF2b2lkIApwb3RlbnRpYWwgcmlza3Mg
Y2F1c2VkIGJ5IHR5cGUgY29lcmNpb24gKHN1Y2ggYXMgdGhlIHByb2JsZW1zIG1lbnRpb25lZCAK
aW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uICkuIFNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGluIHRo
aXMgaGVhZGVyIGZpbGUuCldoYXQgZG8geW91IHRoaW5rPwoKCgoKCgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
