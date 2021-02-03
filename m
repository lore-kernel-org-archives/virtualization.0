Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B13C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 19:37:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2316864DDC
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 19:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2316864DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B48D186A78;
	Wed,  3 Feb 2021 19:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dn5vZzxtQldf; Wed,  3 Feb 2021 19:37:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B63AB86AF0;
	Wed,  3 Feb 2021 19:37:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95916C1DA7;
	Wed,  3 Feb 2021 19:37:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49BAEC1DA7;
 Wed,  3 Feb 2021 19:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 433B68719E;
 Wed,  3 Feb 2021 19:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6hhK1elMZMad; Wed,  3 Feb 2021 19:37:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 49FBA871C6;
 Wed,  3 Feb 2021 19:37:06 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113JXj9m081606;
 Wed, 3 Feb 2021 19:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=TwDL1n6THzt6CQY6jlDDIVUNhEwL2Ly+10+fkkTHLbI=;
 b=uDYVm4eX46ZjOIvBeNJL2Br1hGsZW5dq642uVJvSzPuwhO+pWtp/UuagcLp8Yv9MCuQQ
 Rdo8beWJVWXWilE9oPhmRbtgRfNi5UQ/ddPrgWzKO4E2kQL9Zdo+7K1Hufiv9Sfrej/F
 8p2Xfinv+u9v0XwYwkjlwUgszWEdORtrxmCaW0TN604ohyt9e2oYNQCfoGrT3wJCocCr
 Ci39yD3Uc4AMXWVJF6e7rYmy8Lz9JMa1iflzaXG8cFKr+ki9ZNWUq+4sHd9699dSjzYW
 56NYG+4trMLYnEtWjrHUXQ4bpndL3Y7ItUN7tqDERi1MFbwMiS3epHRiGdXz8kSl9hE9 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 36cvyb20ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Feb 2021 19:36:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113JUHUI078891;
 Wed, 3 Feb 2021 19:36:45 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2056.outbound.protection.outlook.com [104.47.38.56])
 by userp3020.oracle.com with ESMTP id 36dh7u19ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Feb 2021 19:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPWBAwRPoIW5a6fJWL/EL+DZFilrB6sV8D7PpEYWJO0Ds4ZNCUIPw3XI1lBOol/1VFWZgvDb6/+0+OqCXs1DuooOIhSsK1r2JypLWEE7p7Gwyxyg44oYNUuaVVx3PvDyMjyVv17vyFBY/zbMJtG9CUN7EEUwWWhvqrh77r1SHnR85kBSPUGFMaKEYpJSPAa1WIg5s1x+dFUSvco8nqAh60f/IEqYv56efxNWhHxQMeF58wuz6wvGbyUNdKxV7BkpUlZa2rnDDx5EtS+4YSKxOpU/4TZ8Do89H4dYSmtZ/25DK9ysC06NcgPcdi+Tfm57Wk4fClSYyZPumSBcRWAACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwDL1n6THzt6CQY6jlDDIVUNhEwL2Ly+10+fkkTHLbI=;
 b=BEChOvnigolOMQj9wGS/dX7SjWb4hUST5vaOqcIH/EGwi+UqgHPCde84uXZUPgXMNi57nIQcqmBMJZgz6KX9E3vFaB9BrK49wdcMtId+05m6kua+wTA2D7jV4f/8QiIM0CZVWvTN6fRmhPvmVxIXoWoDx1KvGykJW3Q+wmcBOxUxLt0WkUgOT1S8SEv0GkQkayUma02eoqmwMxYItAGa2AzGwxSbOYGs/Q2gik5szwpsfvz58IOod/euDfSsHFfYcpnebff3ykQCAvIyNZggCt5X9A2xfJIeVQc9W5EeyxWGJGPg8f5ZtTn6EIBjgfz/r/ZkBF+qAIPEd51r7Q7lkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwDL1n6THzt6CQY6jlDDIVUNhEwL2Ly+10+fkkTHLbI=;
 b=d/Wl+SGq4ARzt7twsZh9QWFjHYkaaFUnZLtHlYv77Ewv3QJYygpXcqXVAZw/a7aHbR7B3mq2WsbG+l7A20Ow4KXI5feGskFjegMmI8wFORiCBZG2HINAOSrxdHerpph6YZK4qA+8UsSEpDzYkUgedKZ6yPHPdRuKRUW5hnPP0WQ=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 19:36:43 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3825.019; Wed, 3 Feb 2021
 19:36:43 +0000
Date: Wed, 3 Feb 2021 14:36:38 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <20210203193638.GA325136@fedora>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin> <20210203124922.GB16923@lst.de>
Content-Disposition: inline
In-Reply-To: <20210203124922.GB16923@lst.de>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: BL0PR0102CA0031.prod.exchangelabs.com
 (2603:10b6:207:18::44) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora (209.6.208.110) by BL0PR0102CA0031.prod.exchangelabs.com
 (2603:10b6:207:18::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Wed, 3 Feb 2021 19:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9802d648-09dc-4859-e017-08d8c87b08d7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4178:
X-Microsoft-Antispam-PRVS: <BY5PR10MB41785885EA430214E62DA08289B49@BY5PR10MB4178.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ1CpNlkHFV/BJx5ZjTeNcMBfPj69nCfIOwf7gnCTVnWS9PXbIKP7O/j8f4ekI9c2eWqxJS8saxSIAHyJmEs+9NS6PoUVR+YSAbN1OHcky4Y8NM9eNQAmvfcl0GpqEyhzEAQpq1NdLa1iNcJqfDeG9f5s32Yfhozc60CZFBKYRkjWeOGQLW8t+6X7s9fKwPWfjekgWXQEyNs1YcL8Xyqgz8aG4Qhf5rIZe9GWKRGhf9nCz21wiHCDBRVvsdjWP9yfrIGsttidN96KsXQRblNNXaL4MSAMdoGd2c1tl1wFL5pZMUKR+A1mZMzaKsUk4Gb29tZ2LqMIYJhSmDoE2XDzrbhFtac2bY2mTik2XuaZYZTY145JmrORdIFZfYyM/qxYijpExdzF0WsbKYawj954lX6AZ0d6NF27WVQlAIE5i5FAKGM4Cjzu98ZMLozrAE/psIdO8bifCQzIsnfZeWYAhPsjMtw3mH95iFyhQriskE2BxkB3g0geBZwoc3660LML0wSkIEuEL7/hkw5S7qWJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(346002)(396003)(136003)(366004)(1076003)(6666004)(66946007)(66476007)(66556008)(5660300002)(956004)(186003)(26005)(4326008)(52116002)(6496006)(2906002)(7416002)(86362001)(9686003)(55016002)(8936002)(33656002)(9576002)(478600001)(316002)(6916009)(8676002)(83380400001)(33716001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RoeWCw1F1uWE7oDQACHht4M5HLCzv/aL2+TkUI+j8iDj9AmxfCJ7TCMPn2Ui?=
 =?us-ascii?Q?eOKb6pwip50RZ9aproEAVaKfq7g/UKYYQJuD6qssBY1cFel7PE/9x7G/WX01?=
 =?us-ascii?Q?tmsA0Qmnr+KkYxCV/WFYlv/K8dYVvGONVUKxsklfM/6HXUl4cDHEuPEp3UQp?=
 =?us-ascii?Q?R1JzKJveYbKb7udpqIqPmhSSZOf/AYvu7P51QsMYq5px58i+i2L2Px9Bu3T/?=
 =?us-ascii?Q?0CD5IgONzFru35ZeHph5eFEJ3GaUW1lsiTr3RcQdjI7oDa2qb50ONLWGgQXn?=
 =?us-ascii?Q?eT/c8hHYkow/OTPC393xMAyxx9XNhhrSppVkGCgp8f5V5SehnHNMTfp/FpiB?=
 =?us-ascii?Q?62y7+UbGM/0YioTJjM+jr+XgFNbJCRyAK96OUF3cqx7ZL0sFeHRElWvf2i/o?=
 =?us-ascii?Q?GPOd95IsByoDpQwOzarA9fUiJzCe4YEbWd/f7Gk2oh2I4CKcduLR3UNXOuAI?=
 =?us-ascii?Q?bML9ZII4xRb5gT2/zZ06UvMIF0NsGuHBu68W4bmUF+xcWPPtoXeRIY9LzQPz?=
 =?us-ascii?Q?9gLInc95aFI+qcRCuWJxbV502O6lgVsKgmLZY7UHTZS04PLh2+PxLdxs/ATV?=
 =?us-ascii?Q?1hggyh6BSFB7CDFDjlg/bJ9TPu7glyhQxMYsjP73wWqF29vZZgeoKYC8VBya?=
 =?us-ascii?Q?nDBE/2jWZkx+nURRr0N9OqOR+kejRdSUee8QetRZ2I+eANp7x7JslYrZ2Oce?=
 =?us-ascii?Q?Yfm99PupU5JYt0sn9elQ5HnNaHSqBT9fVQmtb9GOb2RcK9kpn3j3xV9WP6tn?=
 =?us-ascii?Q?EerV2v2U409dUmWvxmlhl+FYXVSFOYe+akZ9KdxKiI8P8aFBNCbuJ+J/DlPa?=
 =?us-ascii?Q?G+DiDJBmYENrN/LtdzjwERxJNPcgTb7/6hb24LxP9wexZCtEOWURsDJPTk1O?=
 =?us-ascii?Q?jI0TqzFXTUoTmyA0aBamJQjab5Njiled+doOVYn/iupbgoDEPB8PzMQDXmwZ?=
 =?us-ascii?Q?wNyszMit3vb3BXaK2ZOLizppXZLA8cjsKNUkqxbn+vCGPezl5f24wW5PWr31?=
 =?us-ascii?Q?la4uhh9p7zFHigDntSsnwhWMVVwP55902FZZXJ62Ob8unDkFJT2qEzzVWk1t?=
 =?us-ascii?Q?V/eGEYyI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9802d648-09dc-4859-e017-08d8c87b08d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 19:36:43.0071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oiV7jULjT/RrDqtJmrYyuTiWWd6uQ8Kp7vRFG3fNzjPIA8AbRGwoXqTtvqn3eCQ7AogY/V+h7x4hYG7zhZpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=982 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030114
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

On Wed, Feb 03, 2021 at 01:49:22PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 18, 2021 at 12:44:58PM +0100, Martin Radev wrote:
> > Your comment makes sense but then that would require the cooperation
> > of these vendors and the cloud providers to agree on something meaningful.
> > I am also not sure whether the end result would be better than hardening
> > this interface to catch corruption. There is already some validation in
> > unmap path anyway.
> 
> So what?  If you guys want to provide a new capability you'll have to do
> work.  And designing a new protocol based around the fact that the
> hardware/hypervisor is not trusted and a copy is always required makes
> a lot of more sense than throwing in band aids all over the place.

If you don't trust the hypervisor, what would this capability be in?

I suppose you mean this would need to be in the the guest kernel and
this protocol would depend on .. not-hypervisor and most certainly not
the virtio or any SR-IOV device. That removes a lot of options.

The one sensibile one (since folks will trust OEM vendors like Intel
or AMD to provide the memory encryption so they will also trust the
IOMMU - I hope?) - and they do have plans for that with their IOMMU
frameworks which will remove the need for SWIOTLB (I hope).

But that is not now, but in future.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
