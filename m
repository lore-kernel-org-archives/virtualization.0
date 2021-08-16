Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98DDC4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 17:47:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B0C60C3F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 17:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63B0C60C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA55608A2;
	Mon, 16 Aug 2021 17:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zJdBM5xN7sf4; Mon, 16 Aug 2021 17:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7EDB8608FB;
	Mon, 16 Aug 2021 17:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5103CC001A;
	Mon, 16 Aug 2021 17:47:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC739C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 17:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4981402A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 17:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOD5fUOFRrKD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 17:47:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F14840163
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 17:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXP8UXTkEJ/YjvHw7tXnK/ZISZOu8H1FyheZzL5TUwDdUWUMcQRh0KHJALbXFw+TiU5xGyJyDNVvzyM2dQD8YnOWH2d1+rJs3v9lLcEYeYASJmf5eDYrN9ImBSCMaQWBtVeSFXkg07lDae0wGHordWW/ZrR4JU8ddQkQJJWLDjIQbpyHvnRIXTQb6oRHvHRjMKVuQlQFUjtNWjQcKfV1SX9fnlN2y0k9jv0VnQ7WuFrVye70I8Dd62NYcmMfpV6GkdPKCJZu5lFrqYGJ8XuT24b6GQWfPfDO9sVPAcuL5QhXYtXnuf/MBw/IALz4FDR2ax1vX7LrEmQMbPh4SZM35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqcIGqW0DMqTJkqfI2C1yEwp1lAn3JlE2yyQy9SvzEE=;
 b=EKuslFi/8N3FTDOj38hWjqABjz9Djw+HIVoSN7e18/7jaOpA1rhICz4wcO3e9/ZgjF1p2MmbMRrWebxc2VxM5ELBgOYx2V02wbjzixuDqOLMISvqHVDzMAsoPsdHcomm52OXsqDWm+Sz4QtO4BQAt3VKKCnJlW0rJzKUNi1p65SLVeGJuJoZxVeV/5a5Iz7T0TBgVG7BsJB5Za8zCTIszLyLLP+6uelbsk5NeZpru8ZH0Zu1E31NxYQjY7bWDQXwYG0Z/BLhps1qndlkTVtOp9SXcXz2ZyvEuRB2o+MhAILM+pojZDP41DTHV+uvTW4SKx8PGHvcIQjLtU60n9sFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqcIGqW0DMqTJkqfI2C1yEwp1lAn3JlE2yyQy9SvzEE=;
 b=W3EmUUPNtjbET1fU+kYgLzT1PfxRiFKWgqCyKoszRUhMkbKBgsQSrcCqjuNS8EqXNrjSHnx9+A7ymcVbUlfH5drRvcc7TLWK8sqbQQgKPpkFStCCMrGaaREYGZDODp+2Sfg6/Ma/9sdnCqbKXybq+kQ0LEyh7XO9XadzOECbOOAUbbiLzrOFnL12Gq3qF811/5lrBlhtI6icOK/5snWS0IjOVnBCgtJzzijQIRxcRv30iDXqVxvnH8Su063DuIFU0vE6iQVNEYj3eEsWK/ng4h/AzyX1XoBEXEFOUP3CNwOEISynVJj2hN0IEy3+sH6Gi5PaxQwAUoWCHKSlDJMOKQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 17:47:33 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 17:47:33 +0000
To: Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
Thread-Topic: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
Thread-Index: AQHXjSf/zh/XAFr59kGudCv/3ZyFhatsKNwAgAHI24CAAAxIAIAAKN+AgAEQfoCAABrmgIAAHygAgAAEH4CAAADEgIAALmGAgAXr6QCAABmTAIAAAuMAgAC4F4CAAA17sA==
Date: Mon, 16 Aug 2021 17:47:33 +0000
Message-ID: <PH0PR12MB54819AC5330D650091990618DCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
 <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56bd1281-d1f1-4122-77bf-08d960dded77
x-ms-traffictypediagnostic: PH0PR12MB5452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5452FD1A0FA7C733F9E03531DCFD9@PH0PR12MB5452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWhbgIIv5hnnyWVoOHdMhE9PGIdlAJ5GuMEdJNK2uh7/RQ+JAN3vVmZTGFz19I8zgQ5+AlVurJ3hGHd0dQutH62I8PrrhxLdkniNU6wH4rScXq4tYOxdK1gpe/p5bnc8oQDC4QX9mC84685KXP0mQPrLwwrbtOddHqr5chDI9vgZnCxEnwzaf38luvJB6ZT0Jl7Sa+6bnAUJsKY6DcJpIMSMM8rvq6ArnhdVjbHZCECqHAzM9u/UUCkPy+WwmcMMFwotuJ9/EK+A6yOBE48bJnwP7tXR16JP0AmOG0vU99K61Vcd/OrOqbQIpYfpCZJk7PnkfKIRe5fjv/yVFNS/xin/vwGA96BqN7ZWeq96OnACtDy9R/iwzOTiEs3nyCKLxqslBA/Zhubx5qyUSMN1sckPvMOfti3hsvn/G+oGNrTtNMgk0GfAYNEYNfqhoS8BknUwDdqhzyI3AmuKkgtfkTaicPYulXd0Uw8eEPtt9nFfPtuBKVZw+llKKE6YLWXCVVjQS3GvuRt6WXaaAVRh+tqLzYm6OR+lw1OVpjwDQd1R/I/1U+XUCCVVCBzrEBJ1+oko+cPImHX/N9dwUzQPi8bZgxdTZF8s0s+i/44Qg8Rz5Qm3b/XdeJstu6Qv8AOwA2EnpBjvU2jsXAPJ60kAbFH/f0VWQOQQtHP25DEcoOK7P/4SFKavVvRHyBuEUOnirYrA0yOWojJyQ56rbfrWvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(122000001)(38070700005)(316002)(38100700002)(8676002)(86362001)(478600001)(110136005)(64756008)(66446008)(66556008)(76116006)(8936002)(66946007)(66476007)(55236004)(2906002)(71200400001)(9686003)(186003)(54906003)(4744005)(4326008)(6506007)(7696005)(52536014)(55016002)(26005)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0FvZUpMOHpDcjJJTjE5WG1HLzZIZjkyYVRLM2diam5sL3VTSVVYbUREWW93?=
 =?utf-8?B?WGpYQ0s2OXNOYVh0M2JCZlpCTzBJczgzZXJrd1J3N0NLM3paSE44N1Nnbk5E?=
 =?utf-8?B?QUJObFVKWkxTSlV2elV0YkZVSWlnd2RkTTNoWi9vUGhhb2VFQmlLejlZTzJ5?=
 =?utf-8?B?TW5icVEvQ3FCRjByZDlxUE85OERFVTB4T0ZxR1drM012NTdQYk5JVW82S09o?=
 =?utf-8?B?RmRWcWd0SGZWYjNhUTdYSE9GYk14dTloK2pjNkVVbGI5a1Q4SWxHUXJxYkxT?=
 =?utf-8?B?bVM1c1dpcEM5TTNnRXpITlk5Q3crWnRnSFhYRE9NaTVqZTR5SGFuSHdDVnM1?=
 =?utf-8?B?SVBRSXFCbjVlWG5qSTJkSnNJaSt6d3paYUxqdmZYcDR0NlZpN2FPdC9yZ3lP?=
 =?utf-8?B?Y1QyZU5yYU9TUktzKzgvYkQyVTN0NFFGL3lrSDY2SUM4TzBTUWt0L0haVUlK?=
 =?utf-8?B?dUgyK2NGZThEMXFBMlUzRnRLSUhHT0ZnSzBPK21KRU43aHRQVWJNaUluOFRR?=
 =?utf-8?B?K3pnUmlOV1FuVzFMbzRoV1hFZW9IK3ZNblpGeERNYlg1d2doMFFkUGZ2eEE5?=
 =?utf-8?B?bW51c2Z1c2pXSGJpTU9WTlRvMDFUM1dOS2RuRDZPWGx0VTBlQWwyUXdITmJB?=
 =?utf-8?B?VWY4cXdhR3hoNWx3cFdCc3dqY0RMSVViaE9nQnpQZ2I1SGtjNWxkSFZ5UHlt?=
 =?utf-8?B?Q0F6OGdWa3B6eWx2czBqaGJtMW5KTW12UlVPZituWnVtY3hqMHJFQStBeWZT?=
 =?utf-8?B?cmRuOGhLUkNyZjcxbVlmdW5sNjl3ekt1SXJyTmRZNzU5YnMzd0NJM3V3V2Va?=
 =?utf-8?B?TWp0QzJPaFZZR1FJNGNidlE3bHFZS0JZVGwxWmNJZHE5SWEwUFd2eGwwV3Ar?=
 =?utf-8?B?SHA5VnNBeXFqRVVMWlpDT1FFU2pFME1jOVF2RWtOZ0RCbEcyWkd3Mk5pSkJC?=
 =?utf-8?B?eEFZUEtvK1Nic1hCdXdwaFJtbHpnLzhBdkRRK0llSFdsM2NSTk5IU1h0cVI1?=
 =?utf-8?B?SjBRNlpYRXhPVVFHRnNzaVpQb25VYW8yVWFSUUREeGZWOGFPaWVwTFJHeEZS?=
 =?utf-8?B?V21VU1k0SHdqVW5IUTVmeWZQeFpPcldjVzlhb0RlTTA4bEYxeXlTTU5PRlg4?=
 =?utf-8?B?VWg4eGROVndzR3c2cmtGZWo2V3BGalQ5NFRJZEdpNUE4ZVdGTUxvQ3FENWdY?=
 =?utf-8?B?MVZQSUYrWkNCVUxsbXJDQnNyQUNyZUV2UVFtZFpCcUhQYjJkR2VIQWR3MG1a?=
 =?utf-8?B?eGVucUM4RWxZS2ErU1NzZk9kYjNCR0llbWovREJyN0UyLzR3dWtva01kZ1Y5?=
 =?utf-8?B?amNmVFJGOUFXVWpVU2pxQW1NNEVRZFlNVWhpVzlKTWI4aURSbEZYUHBJMXVW?=
 =?utf-8?B?emtiSUdNeHUzZE12MzgwUDY2dFlteFpkdTVDOFZvbzlhMGF5dHlLTUo4d2pm?=
 =?utf-8?B?ZTRGckljQkZPSjYxVmFFNG9XZVFoZ0RBWDVnd0RWQUo3dXc0TVZBT3UyOGQw?=
 =?utf-8?B?SlgyR3c1aXRPK0VzVzVGL1FROXFxWmt4R095WU9Jb05oOFZ1enVqZHVCR1Zm?=
 =?utf-8?B?U01aM1lNTXdSMjUyUU1hcDd1Zjd3TnlYV1JxSDhqY29jaVhqSGVJV0xzMFVK?=
 =?utf-8?B?eFQvYTYxUEN2MThPWW95TS9KR2V0Zk9tT2QrcHdyYzdqV0JVcVVVMFdjTlg2?=
 =?utf-8?B?bjJYeXl5Y21ZK0drWTM1N1dWeWs4MlF5VW44bW4zSDd3elZrVFNqQVczNHo4?=
 =?utf-8?Q?oRTVSmxvB92njhT/BZnSJmum3vmmmbcUtmdWQ6z?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bd1281-d1f1-4122-77bf-08d960dded77
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 17:47:33.7087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ3GwEvGIn1GHNlFa9zWhzaYPDffJpzkyfK9Vs61qrfzEwkvp/9/l3G+kr7HzhosrKviyKiUIiW5Sv2zUj8DkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> From: Eli Cohen <elic@nvidia.com>
> Sent: Monday, August 16, 2021 10:27 PM
> 
> It works fine when I am working with your version of qemu with support for
> multi queue.
> 
> The problem is that it is broken on qemu v6.0.0. If I register my vdpa device
> with more than 2 data virtqueues, qemu won't even create a netdevice in the
> VM.
> 
> I am not sure how to handle this. Is there some kind of indication I can get as
> to the version of qemu so I can avoid using multiqueue for versions I know
> are problematic?

When user is creating the vdpa device, user should mention how many VQs to use.
We already expose max vqs that device can support.
Instead of some driver arbitrary value, it should be user specified.
At least for Netdev, it make sense to have number of VQs to be <= vcpus.
This knowledge is with QEMU users.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
