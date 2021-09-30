Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF4C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 12:40:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1DC613D1
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 12:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F1DC613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1FCE440217;
	Thu, 30 Sep 2021 12:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4zWsM_FnrrP; Thu, 30 Sep 2021 12:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6899A401D9;
	Thu, 30 Sep 2021 12:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23CA7C0011;
	Thu, 30 Sep 2021 12:40:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D900EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 12:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB60442592
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 12:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tHOIWQQlbkpQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 12:40:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B37104161A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1633005643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UzkodQ49bAvtqugBvJlj6VWSRv+bPY2sUUvBiRlmeK0=;
 b=Yt1cwJOh8MWrtWN3PFqLSTWtKdFqKs8RlOqZoKNGnNSaek3bdQA/O4/MSmUvSxaKXUfVp2
 UMxvXWTLDseSt+GmapklLiY1RnQ1RhKJWIhVo25TT25lF6xOCrd+9tl/F4G8ptXGyp7wjc
 u9KV41i470carxRuIpUYor2gJl36MVs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-ke_ngKcQMPKEqemCr0qJ2A-1; Thu, 30 Sep 2021 14:40:42 +0200
X-MC-Unique: ke_ngKcQMPKEqemCr0qJ2A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QabQrtWy6s7hvIyICbr+zFmtiHXpkIYzpce8lP+UXFQUzI+DZrMqvwA/9ikM71dWu2sKlSpS/GxrJN4g1Ovi+QlmbT4GyPNpNfKIF3VU5E3lOCljSma23xlhxlSzDF8OWLp5yKGhuTIVR69CArbXTAQrxtIZ9N19v8z21SqZpSkk6AzSHYA1mjRC9paQR8E3kcs5vwPSzByoMUDl8ExnJUX8wO1PIGpD42xqzviU936vXbcJzdnPPr6mxv3NsPl2Dg8UIHhCqvBSOyJnx7Hzr6aPgnaIr9RrgjWP+DtdIC1pfbKcsLy7LW7eqnU6UZRIkMvwFUPGeksJvLcpO5FrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UzkodQ49bAvtqugBvJlj6VWSRv+bPY2sUUvBiRlmeK0=;
 b=DawtSFE016xopLltBENJmJkBMbcxadQuPsISdwgkHe6POit3qMoYIZ1FezNWxDdMyT6S1RJ9mpIlSoF8uwU/QPYnJxyW1vsvWhaIbIvRxbqy7ai2iMKZUOEmtJWWF73o3km4Y8FkGBAzD8AVijojyHsjP9wm/r0+s2mgU4I/PaG08kRnSYRolX0jfhx8iLqTem+1l/iLi4UU1N7V3+XwHhmfTBoyNtQjJLLlQabVLS3sCMN/q4tYV+4cIKWJh/NzBwfOJ0R80GN4IecGMo9L17qjz6Nb/oa0Nmqteo4OvbtkRt4FJoEuPRsYjf7OlK0GodXGvxNTDsKJFUutv7O+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 12:40:40 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 12:40:40 +0000
To: Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
 "VMware, Inc." <pv-drivers@vmware.com>
Subject: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
Message-ID: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
Date: Thu, 30 Sep 2021 14:40:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Language: en-US
X-ClientProxiedBy: AM5PR0101CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::27) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
Received: from [10.156.60.236] (37.24.206.209) by
 AM5PR0101CA0014.eurprd01.prod.exchangelabs.com (2603:10a6:206:16::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Thu, 30 Sep 2021 12:40:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82ba7ddd-1bcf-4086-503e-08d9840f829f
X-MS-TrafficTypeDiagnostic: VI1PR04MB7037:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB70378B04EF9E01D9252A30C4B3AA9@VI1PR04MB7037.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdgYFtsHJMp5HxL9F4KdIN+kEXWPjyQEqPtjuSEetkSIbUxucH1M4ykopwg1pFOTW/FCRlZWn1chM4j+rGTdH1s2AD1qjdalu7sCWz5D0TkXJFYgdcx26Q6QqOTTz/t/6GgH2vHwQfrObeP4xJtsn//vit2h6MdJPo+yweV/4ORCKwP4ueT1pGGmeJcudhCpVaEM/N6dFIAv8Q679CZOm1YmemnW6DILQeCbfkzLeArFdFg6RI+Z+FWWtWeP+OW1MQ9IAOZ+MK10BxfLj7gYAwaTkrKjzBlRUZjFvnROrcs8erzGNa5qMGI22nqce+2eDjimFZF8NDOm6bDUPbUvTDKQWlbrxL2mQL0jbEErcqloNZHmDOTOWKQTpa/B+I/OktiyOetzqQM+fv+1z6gTtSXKnBBL6mHSZt0AgeVj5XbkGNdCSIYYy+6TYgDdP0kXQYN4IFFpNd3Ignb1DqDl9dTa3WzK1Bl1Pwdn3blFuI9wd47IJb7cOB74ZeXRw5iqcrseXEfl7fsv0+V9XhLFXkTaEm2WGWg2U7+SKAtyebQkyUhrrUi2rE58eIXfYd4IHC6gRfk/e2ozyl1cqJ7+ybmQDRfrEzan9t7ILIRBIfqiBiiHEbxh43rUFzynLz6yV3K3sF7mbWZvEGV63Ab6bEFN7dARcN3JOJwqdwFyxO475Xmsfl/CZfmJh/d42VKnzLC9GkqxVHyIok2pWrIQBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB5600.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(4326008)(26005)(31686004)(38100700002)(186003)(956004)(2616005)(36756003)(5660300002)(16576012)(2906002)(66556008)(66476007)(66946007)(508600001)(86362001)(110136005)(8936002)(8676002)(316002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THkxWUd6M0lJcSs3QWsrL2l3czB6d3pVcUE5WEtyeGVlQkwzK0oxRUhoTU1w?=
 =?utf-8?B?cS9SdDhQd1M3L3hDcWNsWUtvVm1RRUFIVVFINm9iVC9qbDZNaS8zQ2F2VUNm?=
 =?utf-8?B?TTdEaWZDQ3dGOWpOZ2ZSMmZnTEgrVWxDUTNkT29RQkhuVVJ4NXBHUnBBWW54?=
 =?utf-8?B?cTFsdVlBRklDeWZJV2VkNG8wMzZObTdhM2VUYXY1R2V4M0tjVUdIdVNMZnV3?=
 =?utf-8?B?RGtIemlpS2FIMDFTdnV4V29UbnowbjROKzg2MVUxRkJmRHpxYkRIZFZmanBt?=
 =?utf-8?B?K0xYRG1wZi9rYzl3Qk1Fa3BRRkg1U1UwR011K0lTcVB0Q0FJSTA5NFV2RlZZ?=
 =?utf-8?B?RW9HWm93aGZ5TDBvOVNKR3dEYkJCMVVxVmdWQXAvbzNCR0JZeEc0ZTlyUkxQ?=
 =?utf-8?B?SmlTaTl5Tm1ENmNVU1Y4aHZEUEtCNUdWYUt1MkhxcHVhZDZNTWtZMFFIUlhN?=
 =?utf-8?B?bmRvaHRxSlBzZTFPOS83Unc5WjlGNmMwMHE1WUtYdHUvbEZBTGoyRUxUMjJY?=
 =?utf-8?B?dzNZL1ZpTUZTMm16bWpiZmhuT3pXU2dlOWtaUE1tVHNmQm1kL3BmclA5WW43?=
 =?utf-8?B?WG5ZeG9DamFscUNaaXl1RHNhZDJac09NV1RMRnFiZmNUY0Zod1BJQTIwcUkw?=
 =?utf-8?B?T01qRWd5U2hjdWgvYjIveUZ4alhvM1IxRWpaNzFLRVpWRmIyN2pOd0tQaGgz?=
 =?utf-8?B?YkY5bGp2VkxHc0JwcDdTMWo4a3o5VzlWSDdBbmRCUGltaE1VWURQOFVWWDU2?=
 =?utf-8?B?SVhINkZnK3lPY2VOUWVBZVlVTlRtL0RwSnpGdE53bVlsOXlKNXp0cGdkM3JB?=
 =?utf-8?B?eUdiZEZtZlFSZmh2eGNRWURXbVRGUzMzWGtkQjZVKzdvVnJMVWZjRkhUY1Uy?=
 =?utf-8?B?RXhJU05ibVhNbmM4WGFFV0gzd0t0bXJDNmxiSkVsY3d3L2xGdVpyMytzbXFv?=
 =?utf-8?B?R0k3MEpjVTJ3eVZLWnEvTGp1dTk5ekVYZ2EzNThWdTFZNUJXaUY5cTB1THE3?=
 =?utf-8?B?UTRWYXNwUm50d1FwV243eC82eG0waVdyaURlVDVmMFFKd3FYTkVsMjMwUjBO?=
 =?utf-8?B?OExTN2dCaFZtSkg2YWRSOVkxSjAyZDlwa0J3cG9Welo1T3BlNEs0RnRNdVBt?=
 =?utf-8?B?MkhROHhBSi9PWFdYSHhVUUs0TXZHSHpyNEFHb1B6L1NuOWVSWmFsOE9zbDN3?=
 =?utf-8?B?NkJUNGVrUTJ3aTJudk9UUVo0eld5WjRMQ0Y3cU9YS1dzMlFkdVkydWJWd0N6?=
 =?utf-8?B?clpsOGR5SExvQXRENVF5TU5CSjBwZnhpMW1IRkRQTDFGaDhWNGNCd0dnVlFD?=
 =?utf-8?B?MVBUbFZqUW0xaE11cjkvbHhqT04wb1R1bGZ3djhJYWRsZGlESDlJZWpHYlIr?=
 =?utf-8?B?dVozOXdjKzY5b0xYWVZRSGZnZ0xrWE1JVUg2MnZENXIyRk1GQzNuYzFPQVBk?=
 =?utf-8?B?QkY1K1RHNnkva1g2Zk9FMUsxZ21Va3dZU1NaUVlBaUhHTkZDTm9UK29jd21F?=
 =?utf-8?B?Tzc2a1ZIaXhWamxMVGdOOGlNUStLNGVsRC83VU01d3pYazcvdGp4d09MbWJ2?=
 =?utf-8?B?N2VFYmp5ZU1PblVDaERIbzh6WHB0MHBSVTJMUWhmK1VuMnVpK1ZHblVyck1J?=
 =?utf-8?B?MjFSejRrM2c2ek1nd1gvWHU5ZlpHNUNKTENFRFVvdVUwTWFHM1lYaTRoVG9q?=
 =?utf-8?B?aUl2Q05ESTNVaUNGUStjeEZPb3RWUFRQcjE2V0ZDYklDV2ZRckQ2dUV3Z3FH?=
 =?utf-8?Q?kf6DcxObu/g4Fe0Pst2rp+/xdvaofa//cJ7zbjE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ba7ddd-1bcf-4086-503e-08d9840f829f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:40:40.1609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDcVL1OG4r3kvDTx5tV9emhxB4oNiaugPH4enmSe9pMHvVdHaNsyp5g1d/2joQtbMdgzYlcV15ucA8lU48PxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>
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
From: Jan Beulich via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jan Beulich <jbeulich@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

While using a plain (constant) address works, its use needlessly invokes
a SIB addressing mode, making every call site one byte larger than
necessary. Instead of using an "i" constraint with address-of operator
and a 'c' operand modifier, simply use an ordinary "m" constraint, which
the 64-bit compiler will translate to %rip-relative addressing. This way
we also tell the compiler the truth about operand usage - the memory
location gets actually read, after all.

32-bit code generation is unaffected by the change.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -278,7 +278,7 @@ extern void (*paravirt_iret)(void);
 
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] "m" (pv_ops.op)
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -315,7 +315,7 @@ int paravirt_disable_iospace(void);
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+	"call *%[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
