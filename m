Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE51C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 03:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 016E441B7F;
	Fri, 16 Dec 2022 03:42:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 016E441B7F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iastate.edu header.i=@iastate.edu header.a=rsa-sha256 header.s=selector2 header.b=mZQ5wMMk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8AfByzrqgMR; Fri, 16 Dec 2022 03:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E079141B73;
	Fri, 16 Dec 2022 03:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E079141B73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADE74C0033;
	Fri, 16 Dec 2022 03:42:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF97C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 515A16109F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 515A16109F
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iastate.edu header.i=@iastate.edu header.a=rsa-sha256
 header.s=selector2 header.b=mZQ5wMMk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KyrtUX2Z5hlt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:42:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B31F96109E
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B31F96109E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j446eTV3ufEhIYtV0zjNgPboGrQQD/J9L6cBtMWgdSQx4ce9SJaH1322wSWCzadUuY18vMWObreDN+gGxXmUw/qp4CcKC6BBR5/62r7+c9MqBRic9M87JPnz7Yns2zDIUCfN5S9zYz0e2rgmZTwr4TFBSY7HEYp6VQoZwd39ttRpCpYgt6/T/z3/SUNNDp3YtryhxOk0bz8Dqe8C194NOGptFFm5tQdS2zQlAkUWwL8r8S9hKUqSkx0wBaypHWiKMIiAwUH4Bden9H/CawxCoZ2C0hIAenf1niJqSwfJWczGiPewOw7goNNFNh99tMujjqTwoSTO9/Mfp0agvtbcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSN0oJ+1p/KANVYgltVIxV3qKF2KhWRb9G9TNEHyA8k=;
 b=Ldfha5xpde51GpJy7Q5DCDDSvuobd482rYTgImtRmZM4/aO7PskP1SsAye6qWEi4d1c0J3Abn6QGINxGxAOn07qZaBmRYf8qScfYcPDEPbbkErH15m8hwkbznZNuj2vubxPYcxjxrgn19pnlUneipQrER4ypl9fMihDoxs/WX2+Q+NSW9ILg2/W4Zy+J5svbBcnvj37dQDkMFIKkFxFabSU1hf5be9BNLAdLJRvuV2P8yO3CaKF5fuDjRWt8/iCGWesyBbN71u2KLOD349PoufuX0+AmLgwHCI/fRsBNc0LbV5JACavMurroAuRdeh5Z2GlNHNja7FsK3eYqoVoJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iastate.edu; dmarc=pass action=none header.from=iastate.edu;
 dkim=pass header.d=iastate.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iastate.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSN0oJ+1p/KANVYgltVIxV3qKF2KhWRb9G9TNEHyA8k=;
 b=mZQ5wMMkjXI6XcTw/FkirUZ2gl9XXdwIrNNIsTf/NXibt4j4gWlUqMLxuHnnAl2c34aQurw2r53Cm5tQTZRbPx1lKXf97M2qpe3+monvMYKTujeEhxwMpa0C/bvfVhRSRoRkiv20mMJuyBDNOKC226SoHeaHkcBBkOcdZ/OlK8U=
Received: from SN4PR04MB8365.namprd04.prod.outlook.com (2603:10b6:806:200::20)
 by PH0PR04MB7509.namprd04.prod.outlook.com (2603:10b6:510:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 03:42:17 +0000
Received: from SN4PR04MB8365.namprd04.prod.outlook.com
 ([fe80::b4ff:85e5:923c:3ddb]) by SN4PR04MB8365.namprd04.prod.outlook.com
 ([fe80::b4ff:85e5:923c:3ddb%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 03:42:17 +0000
From: "Zheng, Mai [E CPE]" <mai@iastate.edu>
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: HPDC'23 Call for Workshops
Thread-Topic: HPDC'23 Call for Workshops
Thread-Index: AQHZEQBls5ZJaYX0j0qYklivtJL7iw==
Date: Fri, 16 Dec 2022 03:42:17 +0000
Message-ID: <EA85B793-B3C0-4D15-A25A-2EBC43AF2FD0@iastate.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.67.22111300
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iastate.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR04MB8365:EE_|PH0PR04MB7509:EE_
x-ms-office365-filtering-correlation-id: 60ed91d6-b5fd-412d-de52-08dadf17879a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwQcZlsuMJqZD1YbQBqIVB94eq6cI61DafxBRq2KPx3vDf8Wwt7ZFa8aJAH+lvu6/nI3Wwp19sXCgmxrbIdoRn8jUiYQSy6GbgjsywnAECYsN+JpZL1dgGJN3mAVXv5uLbGOScTFnQMxEuGGGgYgEyL03dO+yfRaZCK/6XWRzFY6FM5IdNNKTibYA0tV4Ia7tVbxkf5K4vl1eIv68Wj9xM1xrqKs7xZJ4T8K2W34BT2s/DsFMpTTvHdGwkC0nlhaFxvmSoPEYXC8fxq/deT3ExcxGgJoCYQWjPnbTNQIdF+KJIMngfTDWW+4igzxL8WkdTeDofEut1Z0LuNCt3ujw12wxEOZwn1h0fhwI4RPNc0XmQnywS/mm+iU+quEQFL1IABXvTvQ2qaXpArD0MP6oHai6tR9AgzAdMLSX395aHM/hRE/afYd7svIQBra29y83Wq9v+djtLmSItbZPPh2B3ai29qnJdZJnpsuL78aMprGRHy08CswauYtw9ElPtcAoX3UHzkBtU0ZFLfbyC8GCWsUFJCFzjupL2hUE1VnoYZ8hN6L0jUXONu4s6R5SHaOUVdyfzuFWwftSdmwlCSbUrdzm1piyQ/MjdNsF9/LojFchrttWc/vIAjl8u5eK2u0lbQ8PQd3VURx9pRQtzNThXgJBhFFCQshp/nFw36E+08IX3dtt1m80wzyT/dKq3Xwg+4OaRrZWn++2B2f3NmNYgiIEa0eFQfjxLLej2vFlUfTruK9Fq9hgAUEm1jYasWq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR04MB8365.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(33656002)(6512007)(2906002)(66899015)(38070700005)(122000001)(71200400001)(478600001)(86362001)(83380400001)(91956017)(316002)(8936002)(76116006)(5660300002)(66946007)(66476007)(66446008)(186003)(6506007)(26005)(6916009)(2616005)(786003)(66556008)(38100700002)(6486002)(64756008)(8676002)(75432002)(41300700001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2hCdUpoRy8vSExBN1dxejg3K2FLMTQ0MElFRG5JanM5dGlGdjdyeEh2NnNL?=
 =?utf-8?B?ejZBbnd6WU1SK1ZGYSs2SE9IVVIxTEFBQ2s4SUlLcHVkNWpJbTlheDJra0RM?=
 =?utf-8?B?QldIYVdBdGtjWmRyUHFSTmQvQ0wyRXpOQldHcVNGSERkR0lYWUNQcmRyQTRG?=
 =?utf-8?B?aHVTMlNxOElNZDRsTkovMmxvUHJSeFZNT2dCeHlYMzFEYnYxYUlvRGZTckFB?=
 =?utf-8?B?VVEwUnRXNTNWTDMxL3ZCczllUzhPcVRBdnBxejBYVVBmRTluMXloYWFWanNJ?=
 =?utf-8?B?eXJzMGdpalFRaGppUXRUbXpFZmpodURSTW1Hdm14S0RlN3lQdjhDSVUvcHBE?=
 =?utf-8?B?dTEyTmZ3VVRuVktoY0x4MVpLZDUvazFPaDNJWDN6Z2lzektxWkM5SUNha25l?=
 =?utf-8?B?V2FVYzY4bVJUNnpEdk1Ebjd3QUszbnFrZEdvK2dmcG1MODQ5cHZCOVVKMDlx?=
 =?utf-8?B?N2pMMm9wV200dHR5ZmlJdjFiSjVEYzlkTlRTVnRGdTN4RHpPMW1kZUdDQUFv?=
 =?utf-8?B?U25mQWlVZUJnWHFKL1RPM3FwMDdXZVduT1Z1K1JuYy9POHcvWG1UZCtJeE5r?=
 =?utf-8?B?VDBZZzdIdkhXMUVuTkhMNmhNSGxEbXJ2NVVGTEVYOFdLU3N4MVJiUGFqeklo?=
 =?utf-8?B?K0xOK3dwZnhkV0dYdkpSaVQ5K2IzVWw3M3lpanN6Z2VBdnpRV3JpZGZibm93?=
 =?utf-8?B?SWdPeXhKemNxMjl5N3liSFlFLzRGRFhiR0ZoMXRoNmM2MUJXNDRIVFU2K0VS?=
 =?utf-8?B?Q2Y5M295SzNUOUxYSUt2SUswZldSWkRaR3FwNXM4WkFFR2pMM09NNytyZVla?=
 =?utf-8?B?eE04cmpmSG5qRDg1b1pyWWswQjBNRWR6bVk1SVRVdzhqOHpoZnIrQzFXU05o?=
 =?utf-8?B?eHJLd2JZNmVTMFl1dGpYNURRU1BRRnhYYks4SGdwK0hyZjdDb0VRTzZNTGVX?=
 =?utf-8?B?VFU1SmFmQmYrREZwdWR6dWxyc2pnTGJnci9nVXpzOWUrU2R1LzFhL3RRR29r?=
 =?utf-8?B?Q083VlZ5dFQzYUJqejkzSDg0aHN1SnQ4alRZYTNackF5UWNLRHhIa1c0My9U?=
 =?utf-8?B?S25OOUNxSXFkNkh2djFHT0xJeC9lQTZLYTdFTXFHRTZUbmwxdzhRSWV1bk9H?=
 =?utf-8?B?ZUxBUERkNTh4ZTFxcDRJYnk3Tzc5ZVBlRjlnRWZ4cTVzdlZ2aWluSllTemNw?=
 =?utf-8?B?TEpPSjFXQ09MaVJPRDZpK0ZSWVM5T21BWTd6OCthZDVBcmFXaFVNOTV2NkNo?=
 =?utf-8?B?RzBZOGhBRGpiWnlCK1RaOUxHZkZUeDRVUEd2SndydjJHckR5OUxib2piSmVq?=
 =?utf-8?B?UjZ4bmp1TmJtcE9Ybk00YUt6L1pDZU5DSWZja2FoNXIveldMWHNJMCsxSEc0?=
 =?utf-8?B?M0JKOTFhc1VpVW05RWNWRzluaWZjOXVvcXc3MXJlRmVQM1d3U1FvdzZWSVlH?=
 =?utf-8?B?VWowMkhGK3NOS1dmWTMwTEpndzNOVlB2bE92RWpHbnpSN2FSVlM3RXd3WUJC?=
 =?utf-8?B?TVJ3cWEranBwZ2x1WmZEUUl1SkxobHJHWnlaY1BhaGVnU2liOUswYUhGVmRP?=
 =?utf-8?B?ZXVKK0M5QUxpK01uYSttVVBhQ0VaYzQvZ2hIZHZtaW5LVG11L1ZYMHdtNFBk?=
 =?utf-8?B?UHRXMSszZ0NoWmtIWXlWQXNGTVloODFDeERwOXRSREdrdUdrbFR6M2FGUGdp?=
 =?utf-8?B?YmVjclNSM1NVMUx5Q01WTFVFcXRSdGdQUXFPbWg3YnZsYzJvQlM4aGxzS2pW?=
 =?utf-8?B?Z0VMSHVjWHlwUmwvOEJvRHdNWEM3dFh1aWZrN20yZU91dzcxOUxWTWdaSW0r?=
 =?utf-8?B?UmJDcGc3elNzVGhIOUU5UDYvT1EzM0RmRytYTHAyUkltM3FOd2I5TmNoSXd6?=
 =?utf-8?B?a2NWUURuWmt3clpwU1VPenhkK21YcWFSWDFkVUxMMXNacDVyczJnc081dDhw?=
 =?utf-8?B?QTQwZGE3WUFjSXlVUGJmcGRvT0MvMDR5c1lkTnBCVUVpbmQ4dGlETzByOTR1?=
 =?utf-8?B?WGNpU3F1ZzdqbUtaMk1BQStBNHlqc1ZSOFp0MUNYVjUrWWhIYnlaT08yOFNN?=
 =?utf-8?B?VWNnc04yYm43elRDTWpUaEFESEZRWFByU2M1MndwVHQzc2NkL2RQajZ4WEcz?=
 =?utf-8?Q?dEt4c7Cmf/37JIWZ3SQE5nqu9?=
Content-ID: <56D237A22E1D3C45A003C7CE87AD31B6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: iastate.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR04MB8365.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ed91d6-b5fd-412d-de52-08dadf17879a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 03:42:17.8037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0347d89a-0174-4dd3-adeb-3339c89c35f5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gg8J3Bxu/hDd9h8624SeUACqFBit83GvPxLEvJV6uNNeQrkqYq51vLUuRViOx0i/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7509
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

---------------------
Overview
---------------------
The organizers of the 31st International ACM Symposium on High-Performance Parallel and Distributed Computing (HPDC'23) call for proposals for Workshops to be held with the main conference (https://www.hpdc.org/2023/).

The HPDC Workshops provide forums for discussion among researchers and practitioners on focused topics and/or emerging research areas relevant to HPC and distributed computing.

Workshops typically include some combination of invited talks, peer-reviewed papers, panel discussions, and work-in-progress talks. Proposers should design workshops for approximately 20-40 participants, lasting either one full day or one-half day, depending on interest and space constraints. Proposals for workshops on new topics are welcome, as are proposals to continue previously successful workshops. Tutorials that would provide attendees with an interactive learning experience will be given special consideration in acceptance. HPDC workshop proceedings will be published by ACM in the HPDC proceedings companion book.

---------------------
Proposal Submission
---------------------
To Submit: Please email your proposal to Youngjae Kim (youkim@sogang.ac.k) and Yue Cheng (mrz7dp@virginia.edu) and with the title "HPDC'23 Workshop Proposal"

---------------------
Formating Guidelines
---------------------
Workshop proposals should be formatted as a single PDF document of 2-4 pages, describing the following:

The full name and acronym of the workshop
Whether the workshop is planned for one full day or one half day
A description of the theme of the workshop and its key topics
A description of the relevance to HPDC
The structure of the workshop (peer-reviewed articles, invited articles, invited talks, panels, etc.)
Proposed names for invited speakers and panelists and their impacts on the topics discussed at the workshop
A tentative list of program committee members (optional)
Details of the review process leading to acceptance to present at the workshop
If the workshop will have a call for papers, a tentative version of such CFP (optional)
If the workshop is going to have published papers, the type of papers to be accepted and their length
A summary of the intended audience
A plan for attracting submissions and attendees to the workshop
A brief biographical information on the workshop organizers
Data about previous editions of the workshop (if any) including attendance, number of papers submitted and accepted
Accepted workshops will need to be ready to set up a website and, if a paper submission process with peer review is going to be used, provide the submission link.

---------------------
Important Dates
---------------------
Deadline for Workshop Proposals :	January 15, 2023
Notification of Workshop Acceptance:	January 31, 2023
Workshop Submission Deadlines:	Late March, 2023*
Camera-Ready Deadline:	Preferably Early May, 2023**
Workshop Dates:	TBD
* could change slightly, to allow for the flow of borderline articles from main conference to workshops
** could change slightly, to synchronize with the main conference proceeding
 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
