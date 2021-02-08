Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD59C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 17:15:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E5064DF0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 17:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E5064DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B948E85B3C;
	Mon,  8 Feb 2021 17:15:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tS5AsPsFiDG; Mon,  8 Feb 2021 17:15:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D293E87090;
	Mon,  8 Feb 2021 17:15:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE428C1DA9;
	Mon,  8 Feb 2021 17:15:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8473DC013A;
 Mon,  8 Feb 2021 17:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6CED986A35;
 Mon,  8 Feb 2021 17:15:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UwdeofnDGckg; Mon,  8 Feb 2021 17:15:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E30486A03;
 Mon,  8 Feb 2021 17:15:17 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118HDpqE087179;
 Mon, 8 Feb 2021 17:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=dKvU0UUYEyA9tuy09aeAgZwcUw48dj9vqzHRYi5wA1w=;
 b=SUxe/h+7BRFwkR0/7Bh3ZzHHMkOwJlcauSoZmP/JBwrP+ZWdSmtXKDYY73ciaUO61vQg
 tfAhOAKaNUDUslOXLKiqoQr4RGcbvw3I1srGJbmQNZZrCwnVhCXtft/km5SP6zWvaMox
 g/BetJaetzd/Wd8FI5NYB5GT+sAHBbdJjPLNDvjD6NFGeg+FvAOMZC8VUzjVGEXngD5H
 03xZxaoRU4juFRW2gpJb842Nh4GT4sxxWuPcMsuWrnGigCCZ/md3Yo8vR4cwxxuN+Vah
 dxQUexAFCEbLEkbq8E+5xHbdahgQ8X316+1PHvYf0Y7w29LUY+PJ6DS5LcKPJHJGLgAx LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 36hgmacs55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Feb 2021 17:14:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118H060d075694;
 Mon, 8 Feb 2021 17:14:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by aserp3030.oracle.com with ESMTP id 36j4pmm242-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Feb 2021 17:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2qOQp3mAlqN3hpt823r75XwDzagXTl2WNz9cI2jUtBU/SJ5uArWyv7Qaq08vrlNOe7HkN3jyNDSmcSNt5Kvbp8Kk2qLp0lmfIqRTQKAQcewbbJ3eWFVQJHAhJWQcEKKhYzv72fBv6gVv7q4DTopAyjY2AULrVrwXTL8+L1mRTv2tVuoVe+M/wdT/x8Ed/S71jjjjRkU6us7NXDIP1ps/5sikW0G5uUxHpE9GtAd01qnjUPPS5SCePeWxc2KjURwrjsbUBapLLJLJ9s+wI1R//EQYPdIRZRkDe2MngIVf+8MfAnItbqATaabl0R55i4XxqjYN3Pw4b3XciyhThW66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKvU0UUYEyA9tuy09aeAgZwcUw48dj9vqzHRYi5wA1w=;
 b=OrE461Yx+u6INxbodIWGPxV/WHnA8E6DHxpwkSTr/kuRGftFRhNWUxlyc5tPCMCpQmlHDSWkThYecdyHA+kqxR4kiTgh48xeAAzRTQTzaB2piZU5PDb8iCgEsWe2trUK9jQuh17JrqPC/eXpKkaBBMi4ydDnejl2tDvx+IslB/ZIyPSPrKBNZb9o7QXX2CMkfJ+ACQIbxssRcV6PHlLorwO8e2nRIh5+qYBOJIrWHQOLsp4A37//CegruPjRIyB4UpK8NJtm7wWuEEcvuuQbfXgC9UBwfxKEi0SR+fx0eVAgNnSo6B7iOQ3uxsbamuhSfKBDMxPCA7nRD+F1lWAQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKvU0UUYEyA9tuy09aeAgZwcUw48dj9vqzHRYi5wA1w=;
 b=ue+CRyHeUvVgg0kJszKFdlLDQ1ZKLi5lZ+3XBr5EKWjei6f5mfn32zT7AgI4cmjVzf7haSAj4SQEEwEC29NEWr/g+UqSBjhqORySuf3tp/6xEeNCM7O4Dbs4kfJVC7SPanUbGPOM4jIjnP03ubrRb1pNX+sXIWGmH4iqLxUNU/k=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3544.namprd10.prod.outlook.com (2603:10b6:a03:121::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.28; Mon, 8 Feb
 2021 17:14:55 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 17:14:54 +0000
Date: Mon, 8 Feb 2021 12:14:49 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <YCFxiTB//Iz6aIhk@Konrads-MacBook-Pro.local>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin> <20210203124922.GB16923@lst.de>
 <20210203193638.GA325136@fedora> <20210205175852.GA1021@lst.de>
Content-Disposition: inline
In-Reply-To: <20210205175852.GA1021@lst.de>
X-Originating-IP: [138.3.200.11]
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.11) by
 BYAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:a02:a8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.23 via Frontend Transport; Mon, 8 Feb 2021 17:14:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17dc5ca3-99d9-449d-5942-08d8cc550dad
X-MS-TrafficTypeDiagnostic: BYAPR10MB3544:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3544FB12003524324804690B898F9@BYAPR10MB3544.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtIrktXmwCSm7TDQADR0YEH25YumfGxFpFU/8qeCN9AiJ01sRRetjV6Gyg+tkBFZyisl2XPtdfitA76nopPm9/Ck13ZS9BPP3L3wrMtt0TKlVhbjBNfOZY297EHZuknE/XuMBbnYJD5iRkpw2TWWlgW1zqIuEmLbFmq6gYenu9dzOUFzOjVoWi7wbdxm56OQiiNPw5h3ueF8MxzxB/hPBHbcog5hL4doHW3z+96KJA5aOLCzT2EJVXzfhHU1F47VXVZyOM54WMsIIJxftzF8l2Pdqtb+OoYh3rUA1rN42SDlVLynp0J7G8xR44Igp7ZDx7iE4AKByZlhKjhSPkceoaZ8vg5/wlA+ZF3ucH9N070J2f8zYLBUGgaJmDGjaM2a2u+isqkyHr962ZAv/ngemabN9mVjwB02LQqZa7BjHfY9D3R9LP0pjMhgAfMDOxTw5/7nPT2GosBgy4mvLujDQlEjrU151S9vgvj2v3/0EbvIzFL25YhhpqAgbSs5aZrjlep6tMwFhIQqS6E14kEU6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(376002)(396003)(136003)(346002)(6506007)(7416002)(4326008)(6666004)(8676002)(186003)(16526019)(6916009)(956004)(2906002)(5660300002)(66556008)(66476007)(66946007)(83380400001)(478600001)(316002)(9686003)(55016002)(26005)(86362001)(52116002)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zfjn9oOjpRAcVOWmWZpMz0YvfhRPbOwo1+x6a3/ZyDoTDhZ6zFTwzOrYScBT?=
 =?us-ascii?Q?Uadl/anUFAKhz75+WIplcDglggx9dsRfIDv9U4QbPml0NWO3IvGLv/U9BAj1?=
 =?us-ascii?Q?MRneq2sCmrKYx49yBXsaXWvXHH0gOrWOHue2ntUkAFlIU7U4uK4icr4jLX18?=
 =?us-ascii?Q?E0oY6srbexAG+NxKzI8+algzk9nkKfydJDjbvrBTBlj23gQKWQkwRclU2lwf?=
 =?us-ascii?Q?FtwSVS9sBBZo62rC/oLosIyZYEOXXdfUeDBVR3xQaKRXemcoE8LKJOzWTrkg?=
 =?us-ascii?Q?juYiA1n5GJtGrJ8ojEZmp5M5Ovh5x5thqj3yqyPGu1I2BlYvWLyFaWyLzlcE?=
 =?us-ascii?Q?wOPvOMyUugNyCmgtPrcIOLb9x4iE9SNHwPMKOvJ1qu15XSqMxTU5X4MqVzUW?=
 =?us-ascii?Q?shMTSLs59r5Ej1rV32zGZJ6XWkPzTsvjVHrEwdagbbbNjVz3zV7IElxshtbE?=
 =?us-ascii?Q?+07nHma+Xjx/q7SIASvL8IfWRj+FQanAV/YTIFismxCVYwqcSvPf+bQSr6fY?=
 =?us-ascii?Q?hYCSDQpr9S6WqnHq0J0LRylHSJYCcltTrVV9rPJWj95M/hHva89QnsTyzRuf?=
 =?us-ascii?Q?hvTWP9mNKIhSB7FA5UjeA1Q0N1JKPhDZVAfNB9cCF1ulw6W3Qqp/AGAEfYRl?=
 =?us-ascii?Q?QotMpxyw9wdI2zxsVvwO8zYTrCdcKQDKisLLwKI4P2WW9QwBReF9pM9HojaP?=
 =?us-ascii?Q?/eG9cpc0bOPJCxXsVEGZ7MRiQI+ba/qCz2rqxR7v42ZA7EhLL3iFutDnvg6N?=
 =?us-ascii?Q?ZY/v84DQDHkEt5MVLZnGiVaFQvaT/SCqRIZJxgcgDtGKVyp41WXDz+4Y20L+?=
 =?us-ascii?Q?2MuAgvEl+e9zL60a94WquoLpZfH1M/QC/vPz9D2M+gKNoFW61wQ1KcXBI9wp?=
 =?us-ascii?Q?odge8h6kVZi/6CDM2JAjhLxptfEFjbHYva5iEHKaFpuJAgsuUl9ABflkw+w3?=
 =?us-ascii?Q?jwXsBFFyfITwpnFFMYkB2uQxvoh8Q33KI2wfhRJg+WeIN5FS2NwmxMAVfeby?=
 =?us-ascii?Q?VXs2qrk4+aBFVIOiAf9XB4TY96kDO8BCdPqGrzWJJjSUrmGtbs3HRLFNmqE/?=
 =?us-ascii?Q?z4K8QXCwDylh5AkVt47AzJG/yPXkea+JgUv/4pZwfnDiTSutWs+Dzl1WbePN?=
 =?us-ascii?Q?5JVmMJ2Y2BS/A527Jz01s+VEKPg1RX02tqusbNObc0IaWf4Jhow2QnbpkV1P?=
 =?us-ascii?Q?AFW3dJsG90MGQHfbezETlVVKDcRzdUouulxe8Yun+ThJKhcEM3V4ZCUlylwJ?=
 =?us-ascii?Q?w+XhVrgVlcHUpbzu/knVovMEHyNCQEvVakDwKsWucIKuy3tvhFD6i2F/7mGV?=
 =?us-ascii?Q?IWFGt3VOn5fR4Cx4Lw32AU/e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dc5ca3-99d9-449d-5942-08d8cc550dad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 17:14:54.8155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voenw09IqNRBluIO61Eps/EjkXX/9QyAKecH4lW2Ryw0QE9OxVFNvPkbO7bJhQtYBSmG12PkXj5uOWoEmzq0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080108
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080109
Cc: Martin Radev <martin.b.radev@gmail.com>, thomas.lendacky@amd.com,
 file@sect.tu-berlin.de, robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org,
 mathias.morbitzer@aisec.fraunhofer.de, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com, m.szyprowski@samsung.com
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

On Fri, Feb 05, 2021 at 06:58:52PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 03, 2021 at 02:36:38PM -0500, Konrad Rzeszutek Wilk wrote:
> > > So what?  If you guys want to provide a new capability you'll have to do
> > > work.  And designing a new protocol based around the fact that the
> > > hardware/hypervisor is not trusted and a copy is always required makes
> > > a lot of more sense than throwing in band aids all over the place.
> > 
> > If you don't trust the hypervisor, what would this capability be in?
> 
> Well, they don't trust the hypervisor to not attack the guest somehow,
> except through the data read.  I never really understood the concept,
> as it leaves too many holes.
> 
> But the point is that these schemes want to force bounce buffering
> because they think it is more secure.  And if that is what you want
> you better have protocol build around the fact that each I/O needs
> to use bounce buffers, so you make those buffers the actual shared
> memory use for communication, and build the protocol around it.

Right. That is what the SWIOTLB pool ends up being as it is allocated at
bootup where the guest tells the hypervisor - these are shared and
clear-text.

> E.g. you don't force the ridiculous NVMe PRP offset rules on the block
> layer, just to make a complicated swiotlb allocation that needs to
> preserve the alignment just do I/O.  But instead you have a trivial

I agree that NVMe is being silly. It could have allocated the coherent
pool and use that and do its own offset within that. That would in
essence carve out a static pool within the SWIOTLB static one..

TTM does that - it has its own DMA machinery on top of DMA API to deal
with its "passing" buffers from one application to another and the fun
of keeping track of that.

> ring buffer or whatever because you know I/O will be copied anyway
> and none of all the hard work higher layers do to make the I/O suitable
> for a normal device apply.

I lost you here. Sorry, are you saying have a simple ring protocol
(like NVME has), where the ring entries (SG or DMA phys) are statically
allocated and whenever NVME driver gets data from user-space it
would copy it in there?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
