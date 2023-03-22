Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB3C6FD1F
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 04:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D05B81364;
	Wed, 22 Mar 2023 04:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D05B81364
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iastate.edu header.i=@iastate.edu header.a=rsa-sha256 header.s=selector2 header.b=rj23NXd9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v7PdB7gk9pkH; Wed, 22 Mar 2023 04:30:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C7D5F8124A;
	Wed, 22 Mar 2023 04:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7D5F8124A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 978A9C0035;
	Wed, 22 Mar 2023 04:30:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FCCDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 04:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40447410BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 04:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40447410BC
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iastate.edu header.i=@iastate.edu header.a=rsa-sha256
 header.s=selector2 header.b=rj23NXd9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pk0HRZ6KIyGX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 04:30:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 849E54096C
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 849E54096C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 04:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBZLKKHSP0//cBAJnmHAjWB+2JgBwGkvhmkIibkOiTcKmd2sJMYa1ottRTyXQl+pkfNETXcLPcVmfGtdK+rm71WGbDnA2gm2bAF1KfBXsfiebZw/9hz+152HdKhTJEBkhKtJ6GnT2RcbmHhWx9H6FRWzhPkkkESC+KgtJPqvfwWSZzBpmAV/B/S7XkZk1mJYlFlHEmkzIl7Ura3TlkQMRfUSC/uBITOXG5VN65iY1BJFMPtaaLuNqfn5MX5U70hho5TTHQRo2Lr/T0uZkTKlwJNuwyiq+Ka4pNXho6k4vsTFgphBrH8h/Wf9I/lfBf6SySxiJz7+4OIUnV0Pv5QYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9/YQ/5u+TSIsXHNeSoJx6Vo4Y1kK8QkI0+q74sf0Ao=;
 b=D8g3GPG6L1RBxErieqAavpWeezz4rvLi/tJpodrjLIYSZe1LedYwcH8w/GtTQj5SWbLOw1PoqycXk7ztZN7JYy7NDkh0r25Mv8lEwdXvc4oDPQO9PrhFooHGX4nfVSwtva1SK0Dfoamcarlr9WxYlbHGtck6s+lZ92FOSBbaGIYkDp2bua1ZjTrkD69+TGjM2tpuj5wzdXq90iLrq3+Zb8XLNqzgkPnneERzZxm7zDwLJdy81VoBCGxKSCYaXGblPBHwuQhKpsoAptB4S21tiTR/9qy7KjyY5NqLxo85vPhbf4KLPOxFRL1N1AbfbIKT0dwXVxSh0hvskKET9cq8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iastate.edu; dmarc=pass action=none header.from=iastate.edu;
 dkim=pass header.d=iastate.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iastate.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9/YQ/5u+TSIsXHNeSoJx6Vo4Y1kK8QkI0+q74sf0Ao=;
 b=rj23NXd9vWUkijdXW7lIqQBga2RwxwH/hmgUFJCLGX+7BrY7qygsrOmqAqSo0MGGDhvcLhHg/X+4RVC9exfii/4p6L5y6L61YljiqKXP4ob8fC3eRL9GAzNlbpBDiKOAW9+3tN1AVW7uH7q40oV/5cTRcXsHPHIATvDG3qTyaLk=
Received: from CO6PR04MB8364.namprd04.prod.outlook.com (2603:10b6:303:143::16)
 by SJ0PR04MB8358.namprd04.prod.outlook.com (2603:10b6:a03:3d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 04:30:42 +0000
Received: from CO6PR04MB8364.namprd04.prod.outlook.com
 ([fe80::25f9:c6b0:999f:b50e]) by CO6PR04MB8364.namprd04.prod.outlook.com
 ([fe80::25f9:c6b0:999f:b50e%2]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 04:30:42 +0000
From: "Zheng, Mai [E CPE]" <mai@iastate.edu>
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: Call For Nominations: HPDC'23 Achievement Award
Thread-Topic: Call For Nominations: HPDC'23 Achievement Award
Thread-Index: AQHZXHcQeEZ0VWnN30W+BWV53Bnq2A==
Date: Wed, 22 Mar 2023 04:30:42 +0000
Message-ID: <F8856196-7315-4601-9C92-C39A4CCF1AD4@iastate.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.70.23021201
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iastate.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR04MB8364:EE_|SJ0PR04MB8358:EE_
x-ms-office365-filtering-correlation-id: 2589f57e-5062-4e60-569b-08db2a8e328c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEooSfCIsdrdXhIRlOgBXM0feWyAq8NxC9r5leg4iEgUlSVJDOCwNVhgRCGSpxF0oblqmtY5VlszE0xJp4h2FEUGySDY6SHy53wOVvg/dIPIb44p3WAgGHQLpHztxxrh1eJpdHAd7xQxMqp0h/s+BnUq6pe899FqOH77KA1a+PKJy6emBNXd+2q0XXr0gf72rf19wjTwnRcVaqzQNx3cmCpuEvoeEFf1T1yVcrPQvd3BirGmIwPcO7I3BXw8a6d4ZExLmGng8gH2m4bYNnYWieKP/w37ZMu0YXpovgHsn+HH4lHBzQEuV+WFx6AU+db4OQnS3Z0G82cdOkhaHO8Bbd7SU5e98cDb+jsKhredtSjMLnxTMDkls/+glx+AAHnXptHhwEV8wW8Ndd3vPgBppk6orKHRkslwU5iEkP59X+kgYYDnQLWy2uZwR0BabBe5VjppuiovdGNu8apWVe9kDANz4Us/AxvKSCukGP653b9ecflLF0Lh9hc4Eift6vWh15xRdJJVEYQz1jtsgGWLuNdDQ0ZUUYgZF4ICrsZ6iHk4JrKskLtS/46LW+6pfQ3rzfC5TGoiHe2yMxmvJi0mHKZL479hI4ByfBPiiLgPiZHXVEPl/xoaF2b3tGoKACtjt4sXnynqTOJalrzECj26XhO7di6DKpBOXgo4craOyMKPJtxtrScZFxpUvFBrtTgxOApTce5/5xUh11ut3HWRvNmuwz/OY58JwN4awPStkrnMLnPQ/imF9A002D/hZSs4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR04MB8364.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199018)(38100700002)(5660300002)(86362001)(75432002)(186003)(8936002)(33656002)(2616005)(41300700001)(71200400001)(38070700005)(2906002)(316002)(478600001)(786003)(6512007)(26005)(6506007)(36756003)(41320700001)(64756008)(66446008)(76116006)(66946007)(8676002)(6486002)(6916009)(966005)(122000001)(91956017)(66476007)(66556008)(557034005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWFkMTFLMXdvNTRubDIyZ1hLMXk3V0NENEpVOE84eTVMdGtBeGhXbTJiNkFu?=
 =?utf-8?B?YjZZL201UHBOcW55c3ZYR2R3RUNBUC81SkNsMWVpMk1mOUY2bkV4L3N3K2VO?=
 =?utf-8?B?SG9nZzN4dDZEOG96dWh6YVhNOGxjdjl1QjQrRlJ5Y1M1Uk8vNzhVTTBKVU9C?=
 =?utf-8?B?V3dCV1BMTExIUlM1NS93VElCOHVKQzErWTF4K29vWDhWcnVXek9sd2t6aXJH?=
 =?utf-8?B?dGw0M1ZYZnlNMFFmMmszQk1veHZzVlVYZHphbE1KS2R3OTc5UUxzRC9aTG0z?=
 =?utf-8?B?bUVJQ3ZPNWJuRXVvbGtWL2hFTE9XblV3QTZNM0N5cEZrRHNhTmx5SG1VY3Iy?=
 =?utf-8?B?ZUVtTS9hZlFHY3lSanJoRXJNZEJ1ZTdLdC9jb1FDRlFkMVJEam1mTXVOUzl6?=
 =?utf-8?B?UnVHM3A2Vk9HaXNZT3k0UC9XSVZkWHJ4RmFRQ2xYMXBzZ2ZXTVNGdFJhcUo3?=
 =?utf-8?B?a1JwWHA4ZmZBalBEeUVzUG9OSEkwK25ZNUNZSm01MENBeUludEIvNnRFazl4?=
 =?utf-8?B?dEJlNlBxYy9kUkswWGVTcm9JTzFWdzFkMGZpVkZsdFhNQVdYaWpzbFBaS3h6?=
 =?utf-8?B?Ri9OY2xqcUNyVC90NGpjL1VkTVFmbGg4eThhWHVlcVB6TUV3MmRPQm85a1JO?=
 =?utf-8?B?U2lKZ3FTYWk4RzFjenozRG5oRFBlOEdNbVdnYmU2Q1Ezdng2dXhwMHFCalhU?=
 =?utf-8?B?WVc3VmwyUXkzV2trNEwya2o5S0t4ZDB4SGNBNTBnQmVzQ0J3bWRFbUZVdFhD?=
 =?utf-8?B?czJ5UmRoYk04am44Q1Y4L216anArQVQ5dFE4ZGVieFZraUZEcnE4SmhxSGtK?=
 =?utf-8?B?bnhqaHdqVWI4aVlrMkRQSGJDUmZCMFNISGQ5ajRzem9JOFZ2aUg2UzJrNHZD?=
 =?utf-8?B?MUVrR2NMZHo5SDlUVnhVY0FlejRCdjJscjgvN25MeGFzNENTT1UzbDBzeG1t?=
 =?utf-8?B?d2V0QTlydWM4MGhBajNhWkxwZHJoa3krMTZwdlBseDY3Mm1mT3NkVUI5bWt6?=
 =?utf-8?B?dzkzMEhwdU8zb0JiNmVRVy92bkphV1VzeExib0Rqay9kNTd1TkplN3pRemdK?=
 =?utf-8?B?cWhZdzFnWHBoQVJJMXZDTmplbmQ1QW1BWnN1Z3lPalFWbWRVcnp1OHRublo3?=
 =?utf-8?B?T3ZhdW9ra09vQTRoWmp4dmVOQXVSY0hwZDY3N0pZOW0yL295N2Zydlp1U2Vo?=
 =?utf-8?B?QTdtVEVReWFuWHZpZjM1bEhMZ2xRRHo0eXZxS3dXbkdjcG1Xdnk4T05rSjJq?=
 =?utf-8?B?UU5zREtscGttMlhvNENDQURzaWR0TnJ5WHFrS0Z5RkFpTmFyYWZLUWZkbVhy?=
 =?utf-8?B?SG5xUm9MZDUrcWk3V0RXb3RwZk1yRHpNTkNUNDdpRytCU0FPMnBkUWVldjFh?=
 =?utf-8?B?YlpnaTdtWGFEckRHSUZXZmNyTjI3MHA2VDlRQlMwMW9aSytxQkE5elZ3Tjh1?=
 =?utf-8?B?dkZWYkkzMHRCMHRsVjdwT2g1UXhKR1pURmlkTitCajkrajVONi9Cc0VXRGpE?=
 =?utf-8?B?OHJiOTUvVjhFQ3FwT0prN3R2dmd0a1pTNkVYZjNsanVhV1Nyb0RDZzdXTThG?=
 =?utf-8?B?Z003QTZjZm1kdWZxbFlxN0dXakNIemhsYllTYXp6M2hpblhZeGdFN01zQ0Vn?=
 =?utf-8?B?R1ovNGxQWGZPaWlDR2djTzFBaHRjQjdMVHk5Q3doOE1RenBMclBCdkE1ZUxC?=
 =?utf-8?B?Mk1GZ1BzdXpVOVlubnAvZERmcUxYTVlBcGoxdlRBVXdpVXViQWZKV0tEa2hL?=
 =?utf-8?B?Q05MV3pUZU9LSDdHei9xTy8xdXIyYnJBSnBMSlozbU4waFYrVmVobitDbC9n?=
 =?utf-8?B?NjN5ckpoNHpkbkU0WGNQcHFxVG1LcnUwa1RSckgvZlF3V0xSZUZyeUlocXZz?=
 =?utf-8?B?S3VaMVI4YUFTcnllWFBsd1BjQjljVzZoOEN5YnpjMkVWSjBCc3FtRDNzbjho?=
 =?utf-8?B?VXhrYUZGWlZhUzZrNXBrKzd5WStSUTdjYnExbUNqV3orekhGVVNKbjJVekFv?=
 =?utf-8?B?QTM3ZTNZbS90cElpdW1OWHdNdkdDdGN5TWN1cEJZMlBOU3VJY083TFErOGRp?=
 =?utf-8?B?MzlOSVFWbmpmWjk1bGhmMVVuZHM0V1hBYXNuMDZvOURqSW1Cb0R6S2htU3lP?=
 =?utf-8?Q?ZuPYdgNfqyt9Zzzac4xLOZdwd?=
Content-ID: <45808975B760604180DF177E059828DA@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: iastate.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB8364.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2589f57e-5062-4e60-569b-08db2a8e328c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 04:30:42.4525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0347d89a-0174-4dd3-adeb-3339c89c35f5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPE6XeftWAz++bh+mD/UtYZQXx51vMnpT+fAUzwqj3xdVeWcKscmhUuGWrCuAB7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8358
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

==================
Call For Nominations: HPDC'23 Achievement Award

In 2012, HPDC established an annual achievement award, which is presented to an individual who has made long-lasting, influential contributions to the foundations or practice of the field of high-performance parallel and distributed computing (HPDC). These contributions may include one or more of the following:

*Conceptual advances that have influenced the design or operation of HPDC systems or applications;
*Innovative techniques or tools for the design or analysis of HPDC systems or applications;
*Design, implementation, and deployment of innovative (components of) HPDC systems or applications;
*Analysis of innovative (components of) HPDC systems or applications.

In selecting the achievement award recipient, the Award Selection Committee will place particular emphasis on seminal contributions and a sustained record of high-impact in the field.

---------------------
Past Winners
---------------------
2022: Franck Cappello for his pioneering contributions in methods, tools, and testbeds for resilient high performance parallel and distributed computing.
2021: Rosa Badia, for her innovations in parallel task-based programming models, workflow applications and systems, and leadership in the high performance computing research community.
2020: No winner
2019: Geoffrey Fox, for his foundational contributions to parallel computing, high-performance software, the interface between applications and systems, contributions to education, and outreach to underrepresented communities.
2018: Satoshi Matsuoka, for his pioneering research in the design, implementation, and application of high performance systems and software tools for parallel and distributed systems.
2017: David Abramson, for his pioneering research in the design, implementation, and application of high performance systems and software tools for parallel and distributed systems.
2016: Jack Dongarra, for his long-standing and far-reaching contributions in high performance linear algebra and large-scale parallel and distributed computing.
2015: Ewa Deelman, for her significant influence, contributions, and distinguished use of workflow systems in high-performance computing.
2014: Rich Wolski, for pioneering and high-impact contributions to grid, cloud, and parallel computing.
2013: Miron Livny, for his significant contribution and high impact in the area of high-throughput computing.
2012: Ian Foster, for his initiative in the creation and development of grid computing and his significant contributions to high-performance distributed computing in support of the sciences.

---------------------
Achievement Award Talk
---------------------
The award will be presented at the 32nd International Symposium on High-Performance Parallel and Distributed Computing in Orlando, Florida, United States, June 16 - June 23, 2023. The winner should be available to receive the award and present an achievement award talk at the conference.

---------------------
Nomination for the 2023 Award
---------------------
Candidates may nominate a colleague by sending a letter in PDF form to mailto:dthain@nd.edu. Each nomination received will be retained and considered by the committee for three consecutive years. The letter of nomination should be about one page and contain:
*The nominee's current professional affiliation(s).
*A brief citation (thirty words or less) precisely stating the most salient reason(s) why the nominee is qualified for the award.
*A description of the technical contributions of the nominee and their significance and impact.

---------------------
Important Dates
---------------------
Nomination deadline: Wednesday, April 12, 2023

---------------------
2023 Award Selection Committee
---------------------
Ali Butt
Franck Cappello
Kyle Chard
Ningfang Mi
Douglas Thain
Devesh Tiwari
Jon Weissman

The award selection committee is chaired by a member of the HPDC steering committee and includes the General Chair(s) and the Program Committee Chair(s) of the current HPDC conference, and the previous year's award winner. An award committee member cannot be a nominator or be selected as the winner.

More info: https://www.hpdc.org/2023/awards/achievement-award/call-for-nominations/
==================





_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
