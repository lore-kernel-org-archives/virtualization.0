Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EC7C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 22:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 377EE60B83;
	Mon, 27 Jun 2022 22:31:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 377EE60B83
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yk8zj0+v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUMPY30tYXQw; Mon, 27 Jun 2022 22:31:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A9B6B60A93;
	Mon, 27 Jun 2022 22:31:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9B6B60A93
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF2FC0032;
	Mon, 27 Jun 2022 22:31:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D03C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 22:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D4E84155B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 22:31:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D4E84155B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Yk8zj0+v
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eh_Y9IRHDo7Z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 22:31:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DFB3414CD
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DFB3414CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656369111; x=1687905111;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=cFfs79so5bDyszYGeV34Sx13DSMu8p5hKhG+YTrPg6I=;
 b=Yk8zj0+vGB1i1/ILrclww1zKfN/d4zMHVBJCTpZuSUqdNWoD4ed7CPwO
 4Jd1OazCezbrPVQ98AEA7fjlzd5NSbkFd0K3BeGQQpN3jrRtBQqmJfDmK
 iDXJ49nwe60/yFAQJqjNSdvlx4VkPUglmsqyQJBiCeX+RJakErDcJtsdn
 vrOh4DsmJeALn9i6Z9gj8038FJhVe8cdGvmgoq/WPxu9ivynTC/rpNKdO
 LXqRN8PzoMhZNwRaxgSDAttC4LIXIpUTcJppr2OzlDWfBocxbLiRbE4VJ
 YzEDbpucFxp+8BfSXz1pyP+DBrX0LQSENJwdBv/hmisxZHqyIjjBAPb4i Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264618937"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="264618937"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 15:31:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="594502569"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2022 15:31:49 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 15:31:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 15:31:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 15:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgbRU5ZSJ+1Njs1Ls5+mrC2TiMXDi6j+q1nXEW35T0vgGO9W6aK0KqFw8sLIpVNW5OEYewvET37n7OLnzZJzrdoAPvuBbKl2gKhhbMESYILsmLYunOjlbKIBJepwvrBGTXlteBN4XqKcJA3F5ktTDOcARc7D/BEWm1ouxrRANeHu7u58sV/HAAoNgfi/egYKuQLeez6w+8vyf6/t3bVzALpXu4HHE9Zu0zqEJk2ju0blX3YtecrfUxzHj/CVnr40PS3z1w1ZMy8GJZzHL7fpiQznoZJDug/Y+NOh43a03VPTMQQvWz4AoCcRi+x91siT0uSwWDqDOh7397up6lUgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fk+tjoSHkPKT19HAXvoo/zCR1SLEsyiUuNU6CruvzGM=;
 b=QI0iafA/bjqr3Gx/f278cS7Oe2x/WkoQMqIGtb6F5Dxfd8KGUdN0WY+LZsBdW5DuG/IkEiGDaJLunvc+wYSbILqxZb12Aer3pTYr7w8s46PErQpET6TL3qYW29h2Ov9/EnK7F8GH22u1w5GbZgtfq5oQQYIpUatlbQe4GzlKUmVSPR6hRnIesSOW9Vyo4AYmxRthVk7LvEDo8N/e0qC5Yke05/8T1b32FiLPtXodGmdngB9bhvjeeKmMTiW3Gs6/1vEACeKhtxeUnT3KCN0/cetAqByvXQUerrK00rSjds9UgCkj018UeCPxBTH+mSq7QbJmqLlZKctqU5S1D0VuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3615.namprd11.prod.outlook.com
 (2603:10b6:208:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Mon, 27 Jun
 2022 22:31:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 22:31:46 +0000
Date: Mon, 27 Jun 2022 15:31:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook
 <keescook@chromium.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] treewide: uapi: Replace zero-length arrays with
 flexible-array members
Message-ID: <62ba2fced98ed_103a0e29448@dwillia2-xfh.notmuch>
References: <20220627180432.GA136081@embeddedor>
Content-Disposition: inline
In-Reply-To: <20220627180432.GA136081@embeddedor>
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09857533-95a6-4ce5-821a-08da588cd147
X-MS-TrafficTypeDiagnostic: MN2PR11MB3615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8QxY2dRCssS1nOBaKo6XXukRWcQnmTJH2CTvS1oBWI5m88TdZyePC8+8Y0lOy5CTi+gHMca0W8aiZ/N99wYfzWDT4IwVc4nlPrt+m+R4p2eDFjRwAp5zJ0VpYLntAd+8A00LZQoJik2rjbu5yVMxLfzdAE/sViq6QR/ukrAYU6UH00hT/qjTfq5KJ6RNmBJjkE9wR8YlchdCVQfclNLDMwBRKAceVhlApanN3Kun5MvZcVR3nAEDzee42+78vAUhiTD75bcuXHURf9mM6NWettdBNB+fgoFRuSIfNbpFulswaXgt+/W3zFI5GI6s+IO6P7PaIkaHL5ETfxVXF7R5o8CyVUDydZpe+Wo6FiGJLus4dot7TeZ2i7BumDmuP2aPbFZpX0GbQZu4hursUXqRwE2dMGw5Mf+B4E0s5mE8SNKEUgUaTQbQGCJ+39EGCF8oMg/hVKoYY9RhxhEhjLKAozVDeQ4YIGG0uJOByhFexDi/CUzss4zWm3FPSVVNx4WelTO8Eiasy/iNjTp8PznOSLGYIo42iw/Hjo++nvz4kH45aIuzAYBtK24nNuwNzMbw4sZoThoJKGKwgdXb5MUKX0VZNuO4cSKb3qG94N5aRCJ56Wdc/+RlFCaggvApnHVcVb8WZ2tBa7ELxVh5io/heAz/fk/UX+HQSPPeKz2L/y2wd5VLtSoLAK+t2RnWXIknFIHsQEtJpjJCc3Z5XS3bsdpx9Mhe7/ar6cHw6C6qj10wOiolEM6AzvfHFUUlo6+4Fm/bKWXrtwiCf23irh7lEh8H2PSKKbYuEuqvEmBbfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1101MB2126.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(376002)(396003)(346002)(39860400002)(366004)(6666004)(7416002)(6506007)(41300700001)(38100700002)(8936002)(83380400001)(66946007)(66476007)(7406005)(66556008)(82960400001)(9686003)(26005)(6512007)(5660300002)(6486002)(110136005)(478600001)(8676002)(966005)(2906002)(316002)(4326008)(186003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG81TEp2bjd5Ui8vcXRBOE1oT2o4aFh0aE1Ma1hEaHNzOWFKMEpVOEdjc0I3?=
 =?utf-8?B?SWNnYkVSZ2gxcDgwU2twTjF4ZW5PbFcwZHpEZlc3WnBtOXhsVUNMcVhTb2hw?=
 =?utf-8?B?Z1UvTFZkSXdjc3lZU1JpbGhXSDExS2RTcUhFanJHbitxYk5nSzB2TitnUTB1?=
 =?utf-8?B?d3Npa2lreGhFanpCS2Z6WGhuaWtsYldmWXB4eVAyaE9lSG5JNHV0SG9FTG40?=
 =?utf-8?B?elVLZEpIUWZ0K0ZFamlxcHU1Qmw3T1J1VU9CK29Ib0VzanNEK0xad2VyeFM5?=
 =?utf-8?B?c1dUZzh5RE9UR0Y3Wk1mOHpMdS9FUjRTU0VKT0ErU0tGd1pvdng5Wk92WmVP?=
 =?utf-8?B?aGhLVHE5QitoeUVFSmRYd3I1UEJVckw5SXNobnQ3VkNFYzFGM0VWMjR6NHZE?=
 =?utf-8?B?MW5hbUVZR3Q1TGRXQnRIbEYyU3BuRHRzbjFoN25iQ3ZsRkRwTUNiZWpLRGwy?=
 =?utf-8?B?dUlDcnNJZlRWNjZqYzNJY1RPQnhEWTJMN056dkJtK3FMS3NNL1paZ1dtQXQ2?=
 =?utf-8?B?c2toU3JpelZQMm1yVkNiTnZReUROU2thMlN0K3ptc3lqSFpGQTc5dFZ5ZkZH?=
 =?utf-8?B?M1dRNjhzT1NSOHFBRm9lV01xSExNeWJmM0d3L3hoVXNZSVc0N0dTZ1RKSnBZ?=
 =?utf-8?B?T3l5WDhrTlVZTWNYZHI3U2V3TFFTc1hKUGxZTXFNVm1Ga2hFYTNnZmZCcWZV?=
 =?utf-8?B?d29rZjJmN2NUbGh0Y29KR2hBUkdIRHpJc2FCRHkzZjZiMkJMRExhRGtPOWZK?=
 =?utf-8?B?N3VjaFU3aEpNZHFnUC9qY0RJZGwwcUgzT2crTlVnWHI3NEdGanZPVTlna1NY?=
 =?utf-8?B?ZWdsU200UjJWTVBSWW1ENTRUWTFVMmFSbDliV0FTVlJQRCs3UFI2L0JRK2pH?=
 =?utf-8?B?Z1NWQjZGdFh2aGg0ay9FV1paWmtram9tK1M4ZzgwN3h5TThkNis1bHVXTDVP?=
 =?utf-8?B?czlJK1NnR0tNcDQvOXJrdnN6YnEyRHkyNzdiMzA5SWhGV0J0a1h2Q2poc2F3?=
 =?utf-8?B?Ri9DYkJjVm9nQWVjME1ndnFtT3Q3RjFyVEVDM0U1VFd0elBCRnlXUHJWR3Zx?=
 =?utf-8?B?S3kzV3dOM0NqSjRnOUVWdGhTN0hnbTRBOUpnT3cwc3hhTkZEMzBNbkpzbEtJ?=
 =?utf-8?B?Vm5lVE0wbUN4UEdlTHBVWG9QdzRobWdCWStjb2QvcGlPd1JhUnY1UUtHcUUx?=
 =?utf-8?B?blp4NGRWbE5SYTRrRjN1Uy80ZWJoZXBvdnRDWFpMNTZBU2NCci9McTlMelJC?=
 =?utf-8?B?VTlHaGR3cGF5UlEzR3BrSVdRalM3TnJtMXhaQnBnSXNISE9aL1lHS29qQ3RV?=
 =?utf-8?B?dFd6TytkMkVUNmNMa0Z5eHBOSGJ2UXVoZFR1dHdXemhDK29MWXBBQkowaUta?=
 =?utf-8?B?NGVZZnZmOVBaK000TUQzWXk0eG1SazBONFVrYjBuVWcrdmJtK0lQSU80RGpD?=
 =?utf-8?B?YlIwdFZvcTZIMmdyK3diQ25wRWgvV1kzZkZ4U2VyYS84eDBhZHlCYkVPbngx?=
 =?utf-8?B?VUt1WHc0NjNqR0dWM0dEbnZ4cXVscHVlOEF2V2w5Vkw0UnVrNzVjL0h0a1oz?=
 =?utf-8?B?TFlFWWhIWEI3eXFVczlqa2Juc3JZVUZ0ZUtIbHhXWGV6bkloMmw4TXVXK2hm?=
 =?utf-8?B?UDBYQjI4TVB4QlVlcDRQclZ3OFBoeDVPTTNGQnVIZ2VmZE9zcXA0M3M0cHVv?=
 =?utf-8?B?dHRETGgzWFRSQTd1ZHVkRnJiOER6WWFMb2RJbWF1T2RzYXQ1YVd4Zmh3RkFZ?=
 =?utf-8?B?M0NTTVlTdEZmT1FDUm1KRzMwZFh1SWJGMlF2SXpJUmFCTmpEN21jWU90TTNO?=
 =?utf-8?B?OEVTa29FempFTmpYeFdFMTkxa2hrL3hSWUtrUldHZUhxVTRIZVQ4WlhwUUtn?=
 =?utf-8?B?YS92UWZzL21Fc09vRE81TXZaUngzTm93L2tqOENTdHUybUtLYzlPSFozR0NG?=
 =?utf-8?B?VkJZeTlQMHQ2MnVqUEJneFVaNDFEQ3VCdXIvb0dhYnVNcmx4Z2I3dWR2ZWFr?=
 =?utf-8?B?U3FFVHNwb3VmbWxUMUY4TFFCTURWcE1hQmxVUlZzNkJaT241OEJ3Zk5vS2tw?=
 =?utf-8?B?ZlZEU1FmY3BiaG9iUDZIS0lPK1FVTnZOSVU4L2h5bE1qaXZ3ZWYrdXBtMFVw?=
 =?utf-8?B?N2RnT3VrY0Rkc1VYM3BIamw2bDJ1TnRabHlKcXdORXhocDlnWWhBdlBuc0FJ?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09857533-95a6-4ce5-821a-08da588cd147
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 22:31:45.8792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tff1Ajm5j5IjP8nC+pmHruh1VBM1HYz+iFkTnXnCZrfcWvUa1L/3YXcaJpJFmczORKhoOnLDiSvurI/2Snl4amoFHffRXHppNmqfZrAlNU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3615
X-OriginatorOrg: intel.com
Cc: nvdimm@lists.linux.dev, alsa-devel@alsa-project.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net,
 linux-stm32@st-md-mailman.stormreply.com, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 kasan-dev@googlegroups.com, lvs-devel@vger.kernel.org, coreteam@netfilter.org,
 v9fs-developer@lists.sourceforge.net, intel-gfx@lists.freedesktop.org,
 linux-can@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, io-uring@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-sctp@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

R3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToKPiBUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0
aGUga2VybmVsIHRvIHByb3ZpZGUgYSB3YXkgdG8gZGVjbGFyZQo+IGhhdmluZyBhIGR5bmFtaWNh
bGx5IHNpemVkIHNldCBvZiB0cmFpbGluZyBlbGVtZW50cyBpbiBhIHN0cnVjdHVyZS4KPiBLZXJu
ZWwgY29kZSBzaG91bGQgYWx3YXlzIHVzZSDigJxmbGV4aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFd
IGZvciB0aGVzZQo+IGNhc2VzLiBUaGUgb2xkZXIgc3R5bGUgb2Ygb25lLWVsZW1lbnQgb3IgemVy
by1sZW5ndGggYXJyYXlzIHNob3VsZAo+IG5vIGxvbmdlciBiZSB1c2VkWzJdLgo+IAo+IFRoaXMg
Y29kZSB3YXMgdHJhbnNmb3JtZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlOgo+IChsaW51
eC01LjE5LXJjMiQgc3BhdGNoIC0tam9icyAkKGdldGNvbmYgX05QUk9DRVNTT1JTX09OTE4pIC0t
c3AtZmlsZSBzY3JpcHQuY29jY2kgLS1pbmNsdWRlLWhlYWRlcnMgLS1kaXIgLiA+IG91dHB1dC5w
YXRjaCkKPiAKPiBAQAo+IGlkZW50aWZpZXIgUywgbWVtYmVyLCBhcnJheTsKPiB0eXBlIFQxLCBU
MjsKPiBAQAo+IAo+IHN0cnVjdCBTIHsKPiAgIC4uLgo+ICAgVDEgbWVtYmVyOwo+ICAgVDIgYXJy
YXlbCj4gLSAwCj4gICBdOwo+IH07Cj4gCj4gLWZzdHJpY3QtZmxleC1hcnJheXM9MyBpcyBjb21p
bmcgYW5kIHdlIG5lZWQgdG8gbGFuZCB0aGVzZSBjaGFuZ2VzCj4gdG8gcHJldmVudCBpc3N1ZXMg
bGlrZSB0aGVzZSBpbiB0aGUgc2hvcnQgZnV0dXJlOgo+IAo+IC4uL2ZzL21pbml4L2Rpci5jOjMz
NzozOiB3YXJuaW5nOiAnc3RyY3B5JyB3aWxsIGFsd2F5cyBvdmVyZmxvdzsgZGVzdGluYXRpb24g
YnVmZmVyIGhhcyBzaXplIDAsCj4gYnV0IHRoZSBzb3VyY2Ugc3RyaW5nIGhhcyBsZW5ndGggMiAo
aW5jbHVkaW5nIE5VTCBieXRlKSBbLVdmb3J0aWZ5LXNvdXJjZV0KPiAJCXN0cmNweShkZTMtPm5h
bWUsICIuIik7Cj4gCQleCj4gCj4gU2luY2UgdGhlc2UgYXJlIGFsbCBbMF0gdG8gW10gY2hhbmdl
cywgdGhlIHJpc2sgdG8gVUFQSSBpcyBuZWFybHkgemVyby4gSWYKPiB0aGlzIGJyZWFrcyBhbnl0
aGluZywgd2UgY2FuIHVzZSBhIHVuaW9uIHdpdGggYSBuZXcgbWVtYmVyIG5hbWUuCj4gCj4gWzFd
IGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0ZsZXhpYmxlX2FycmF5X21lbWJlcgo+IFsy
XSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1LjE2L3Byb2Nlc3MvZGVwcmVjYXRl
ZC5odG1sI3plcm8tbGVuZ3RoLWFuZC1vbmUtZWxlbWVudC1hcnJheXMKPiAKPiBMaW5rOiBodHRw
czovL2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvNzgKPiBCdWlsZC10ZXN0ZWQtYnk6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNjJiNjc1ZWMud0tYNkFPWjZjYkU3MXZ0RiUyNWxr
cEBpbnRlbC5jb20vCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2
b2Fyc0BrZXJuZWwub3JnPgo+IC0tLQo+IEhpIGFsbCEKPiAKPiBKRllJOiBJJ20gYWRkaW5nIHRo
aXMgdG8gbXkgLW5leHQgdHJlZS4gOikKPiAKWy4uXQo+ICBpbmNsdWRlL3VhcGkvbGludXgvbmRj
dGwuaCAgICAgICAgICAgICAgICAgICAgfCAxMCArLS0KCkZvciBuZGN0bC5oCgpBY2tlZC1ieTog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
