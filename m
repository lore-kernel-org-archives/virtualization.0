Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ACAC4708F
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:28:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC815613DC
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 01:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC815613DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F33560AF4;
	Thu,  3 Jun 2021 01:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mDteBu175pRs; Thu,  3 Jun 2021 01:28:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17E3860AF6;
	Thu,  3 Jun 2021 01:28:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1AD7C000D;
	Thu,  3 Jun 2021 01:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68127C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D81F404B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K_6Vr7ex5Gqf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:28:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C0B9400DA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 01:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw2QR8SADwt5dKNUCouJF2qkfhFwkN0gdGfpdztfBrEL2EPPr0vWZR0MTR2c+sLyvgg4UgQKvMrh2FvfEFoStZWSGC2PM8VbSomAVQozuSfnju7IlIgRn7EAH9L6coPIF6k8XQJ5ayI9fttnHZRpSRmZPvJh161sl5Lks2MfLji/KNaX2yBlEJjGZAHBC9FNHXAF8K2y53TwwIwTOeE05b0mNfoUwfbMXWi7bqH3StvgS4lmuW5IEiYc1vFgqV2Q6XQZz5VKOZRiqnawCIFgv8P06eo7JP/ZUa7TkXF7MYZLfEsKE5rKA0enFvbOHtux6TOa+rMfHOsfN1YrTzZ50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX4nXgGk1siZU0Bf0PqqTO7mnRLXWvPrHkMU9yVwG98=;
 b=i+dfOmVph7+RFqcjUueD26FN6ykEnPXwmwyfH4lKvKBJ2a3aIXyYnB8xttVFzacLrJ8TA1+Fxw56A10IzJtMoVrle+svgBi/KVcG8QN6iAhfds/ADE3t0ZyS4Z+Y9IQPxw0Ijp0E+FyVQlXnXRDlbRpAh5nQu27K+KCf6eGjyZnDWo2mRcFmCsWq5JnD7gwk55GcbWpHP5KwUEkV0/8PMSIqV0ogVkQg7stpfwxP7Hj/gY4KVSuQAHQxE0ztL9H6dTqnz5GtUhH2IO8IG3Zpt2WFJPfl17YWxhg1kFMrduY/Flm/S4zUGgEed12x7cQt4fZdyfoSzgaFIpwFb2ut2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX4nXgGk1siZU0Bf0PqqTO7mnRLXWvPrHkMU9yVwG98=;
 b=RMgkz87JeMZOCK4nROHjUlbdPG2OF5EYOuaLdfwTV+9LK3xQYtOe++wyiJEbab8y+KoiRa5JrYlBdVxt3nWSNQhdkMsABEIKMNN7Nvq8vt0Grkkeny33fgDv+4wIf0EwiC/anjGgGG9uPO202G2A6W2d2Om+1OZkXCQiNR2aMNY=
Received: from MW4PR21MB2004.namprd21.prod.outlook.com (2603:10b6:303:68::24)
 by MW2PR2101MB0922.namprd21.prod.outlook.com (2603:10b6:302:10::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3; Thu, 3 Jun
 2021 01:28:08 +0000
Received: from MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::bd8a:c616:27d:77a2]) by MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::bd8a:c616:27d:77a2%8]) with mapi id 15.20.4219.010; Thu, 3 Jun 2021
 01:28:08 +0000
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
Thread-Topic: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
Thread-Index: AQHXVBLqkkWi1wc3SES2ayhRv8Vib6sBXHLg
Date: Thu, 3 Jun 2021 01:28:08 +0000
Message-ID: <MW4PR21MB2004EB3380731C8102DB7D16C03C9@MW4PR21MB2004.namprd21.prod.outlook.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:88be:327a:d038:fef5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa92c9b8-4960-4cd5-74c3-08d9262ed818
x-ms-traffictypediagnostic: MW2PR2101MB0922:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0922F3441D8A416467BAA9E0C03C9@MW2PR2101MB0922.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRObCj0I5ZbIAvw4yT3KpPsnRfkcLatJrQ3rIfjR7JG2nbmnUMe5R1cWEpbqfgT6MZAp13Ep1oRFa3d30odJKjfpisHRQtnLYKsa1av7DONtXnJX0Ovo3sk/DkliAueJ62/cp04swDTGlN/Y1n58Zc91M1Mp8V6YoQ2GN/stTWGCJLrmrpl3XFpsNn9sWOxdCXPrI68TzfxtDQzBMB5S9c9WfINgKq0HADwA11oqgvToPW9l3mkK7HN0dZNxgTDedGbJpeGX/Xd+D1gPSBqxlZ9W53sZTp7VzfwJbjzakRf0aNwYCpCPQVhMrdJI6+sndQaM3hQVh6Gz0VKDUqnKofa4tq7dMWsegiV2i+6tE5aEg7dFroFUHM7LsnYvFNJXjaVN0lk08mP5qQ4Z9UnU5n8lRatrFcNBwFLuGKVe9VqZcbWsXbWbI14VCb5nhOedwOrb3XWhvQC9ZPgRkg8FRJg45ley2WL2LZA9PoXfvqAyu60ScKh4taTC9JvpsPGPTvEaUG/OzAp1QJ1iyCfUOnGay/2uiPwFVvmbyZMemCr36yXdWQ3kqOt/lpWGelukHlVsNBV1PT2MVpTW6PEBMg52g7qUKnritgPiaQBKE8OyBMgizc+Fa43u7K8r9ltrQNzHLKfHbjvS77tPKWzE1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR21MB2004.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8990500004)(110136005)(316002)(5660300002)(54906003)(86362001)(83380400001)(82950400001)(82960400001)(10290500003)(186003)(4326008)(478600001)(52536014)(9686003)(107886003)(38100700002)(122000001)(8936002)(7696005)(33656002)(8676002)(71200400001)(66946007)(76116006)(2906002)(55016002)(66556008)(66476007)(6506007)(66446008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?txckjnTgZfz5mEdntOG5RXwcOy2QBrQqBdXw+sTRnRyRYUy12h2mqpO93f4x?=
 =?us-ascii?Q?RmY+MtgOToB4CguLsamMBNIPxS9dzbZwwnWtGV9otpt633I7i/xhBMe5ILbF?=
 =?us-ascii?Q?tsX5Edkp+YWVzDcOHuBjYG8V4qWwCWHJsAbN7f7xJw7V8h4mhw539pIArKn4?=
 =?us-ascii?Q?ap8Dqn3yQnnj8E5DEIrE/FGORW+yDQdA5w/BubdiWD0qPd8OpJIxoo2zV28i?=
 =?us-ascii?Q?xiQG/nB2Wbglw2o5tibo0vZlWnNchEyREN7fy6Pr1otBasGO+xgXfUWXlV4G?=
 =?us-ascii?Q?2Uji+2hdR4phcJsYDAGS8uTNBTF/oqXD4QI5tg/KpN5i4rRaHkufF/okPgdf?=
 =?us-ascii?Q?33HWl31R7lKaCBPvKcqdBSuUwtfqQXgko5ZcmCJUJvIblapdtqfZuEABNKbJ?=
 =?us-ascii?Q?cRV3U5U78kly/ZGFiBNRTUmZ0jvfYf6nbdE3BlUeUl/HRto/EPokPYeK+266?=
 =?us-ascii?Q?B5PD6zN0uZ5TTMNk10gfqwPcBZ1zNSRz9nbG1jxgBc07C8kPtO5VYvQ/Uc3y?=
 =?us-ascii?Q?ZCoMGLecwHyl43t2Bc+eUijgWZ7U4Wpc6RalJdtLsBlQWhrbAzCYpZC+wrN6?=
 =?us-ascii?Q?2/1nlSt5pSa8J5YwBnkj6xA44le1Xszc9YSGQyrwNmwodAEnWX7kGJykOmPS?=
 =?us-ascii?Q?izcTCwPM1B2N3v7pNLjfu9SK9WD4BBwpyEV/pHot3WvnA0PjgIaOofAWvfQg?=
 =?us-ascii?Q?4n8jFBXsiNTw56gkKbMyMUQH7bkqZX+bVbUXZn9TxaYqsdRMggR5QzDzYh0N?=
 =?us-ascii?Q?do+Vx8R4GOS3Gc3MHUfBREB3sC+E4OFChRGTCPmdFlMvNrfSkhX2eZG6NLy7?=
 =?us-ascii?Q?pQP+3QqVJlv9A3oRqGLMK4ezXcZea1K1gi4smRWQfCThK6UCvO0k39aMcu73?=
 =?us-ascii?Q?NhB6JbEPq2ZhVZYe+jDIT5EIoWnOAO2mJsPXmpds5e1aVALrzWYs/6B+75Xd?=
 =?us-ascii?Q?9AgQ9kHRhKX16sVVclZa2cr6ByPY343tzDQpkKbW?=
x-ms-exchange-antispam-messagedata-1: zy5eQjynOE0IidPB/kw8Pd5v9MmmE/ZqBeqd4JzxITmVk2ysu5Jq+hF3xEpN8LFQzo2bHtcqaN229FmDQI11UgKueNKQhyPj79qj+pEhnK+R1/yFSNQ0MjChITCCyvrDhn0bvLY9XP88NTccFVjj56FOV4URI8XqcWd1v0TEYoCpZzCVLV45YajFChLNhe00GjE5d1Zfz6xZB9CKI1GgUNZfox1ddZ4r+0kACeXcWS6OZB+idXuNym3yDlWYWkWsaT4ah7jOUI/UULwJhJLuV1A1pTnl/NX1X39+MKbKBM8qXD58wscgGzwiKPa2YCYtn6DGhQG+ru+xFHVIDrpCi/0XJ8k/BtMjmbEG5EdoLg6jrVGtMyabTcS3VnqH2STXfzO3y1Y3pCrJDJytBSzJ2bKn
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2004.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa92c9b8-4960-4cd5-74c3-08d9262ed818
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 01:28:08.3337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMtVC0ESQ++Er74NaXWZ2ug0M8E9UHgtj+kqB1ADT3CNgqYXBf2pyToXGyomBdKZmvTL2O1wRsFg29RbzzjXEpoNYbISvNNsoNGmUyll2Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0922
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>
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
From: Sunil Muthuswamy via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Sunil Muthuswamy <sunilmut@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d92391..d618b1fab2bb 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -27,4 +27,22 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
> 
> +config HYPERV_ROOT_API

A more suitable place to put this would be under the "VIRTUALIZATION"
config menu option, where we have the "KVM" option today.

> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
> +	depends on HYPERV
> +	help
> +	  Provides access to interfaces for managing guest virtual machines
> +	  running under the Microsoft Hypervisor.

These are technically not "root" interfaces. As you say it too, these are
interfaces to manage guest VMs. Calling it "HYPERV_ROOT_API" would
be confusing. Something along the lines of "HYPERV_VMM_API" or
"HYPERV_VM_API" seems more appropriate to me.

> new file mode 100644
> index 000000000000..c68cc84fb983
> --- /dev/null
> +++ b/drivers/hv/mshv_main.c
Why not in /virt/hv or something under /virt?

> +static int mshv_dev_open(struct inode *inode, struct file *filp);
> +static int mshv_dev_release(struct inode *inode, struct file *filp);
> +static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);

Do we need to have both 'mshv' & 'dev' in the name? How about just
calling these 'mshv_xyz'? Like you have for init/exit.

> +
> +static struct miscdevice mshv_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "mshv",
> +	.fops = &mshv_dev_fops,
> +	.mode = 600,
> +};
For the default mode, I think we want to keep it the same as that for 'kvm'.

- Sunil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
