Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2939AC433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 16:38:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA18B64F76
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 16:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA18B64F76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AC828704B;
	Tue,  2 Feb 2021 16:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H6NtFgDA1ME1; Tue,  2 Feb 2021 16:38:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6131B86D52;
	Tue,  2 Feb 2021 16:38:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 415D6C0FA7;
	Tue,  2 Feb 2021 16:38:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49DC5C013A;
 Tue,  2 Feb 2021 16:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 36401867D2;
 Tue,  2 Feb 2021 16:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GvQkVUspmegf; Tue,  2 Feb 2021 16:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D48B867DE;
 Tue,  2 Feb 2021 16:38:33 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112GJhOY009437;
 Tue, 2 Feb 2021 16:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=KNjrX0rK55s9aWETWv1OLbCJnKqJuWYa5q+oV4dZTfE=;
 b=eh9M60Ig82Y0s8W/59/crxYMJpnbPLOxnuwRH7httzRf6kCLen3YxyDd0w1dGpfpBmLP
 oMQKuscj52l2sSjXjKi6G3zC7O/+P2z0ePEydRW2acZYyD+aB7IYr7ymijB2+VrtFAad
 J/BRVeJoBzcdQ68hqf9r+9jhAwvOoRt4Ts/n/JnjYcJ4XzDhcr8ADluLln5TVfREaayz
 IwPPrXFLKi+7UVwSXramYklVL0dHF2agj5vUYmO3u5UnrpOnZq90g8x0qXCYgoG3YMGa
 ycoKYlK7OG8QbE3MZghXHC4enmJhdP6T9VNmSYSuKhKD86GGnAoXy4lM/6q/cUUvVtv2 Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 36cvyauwb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Feb 2021 16:38:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 112GGfN2095797;
 Tue, 2 Feb 2021 16:38:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by userp3030.oracle.com with ESMTP id 36dhcwyj9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Feb 2021 16:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnhbZoXIBljYbeuVqjTuz8NVZu9cxsl8bg9MvSkCa1kfnHnV4W7uDd1u8pdxah9XqUK7EoeNaNLDrHaMr6pJUfNy6vlB710iVBU0ZWxB9eq/3cH/mVwKEW6G0MSAciyhe/wycrPK6SFBWHY687y47p6cRS4Kv7G9Q0SiIYfAqSL1q53kafRl0jeAqcRiQEpUywmVb46Y48qK0nnydPWkURLakbCWC45QDJ0eI8uruYTY9qqPObggnCf1fQpAzmUymg9AXTqFG7HnxqILSxcpxHkVq9TvvQNhC6lorB8lCwsDqHJifP3aId2PFAfyA2g6RObhbW0CCJzXWIret5HrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNjrX0rK55s9aWETWv1OLbCJnKqJuWYa5q+oV4dZTfE=;
 b=lyq7gqbyIjqVHA9C6YWl6puvapxy82ajRS9SOLAbzekI4SBB4Dpx4GcsNHxXwTaUiZaXsPQTLCmXKTqnj6l1RKsqv0OV0blNeSy/QapS1DVkU0AlVIErjaXFAj6btyf22/PAy/ASLkgUTYLSlMnTsb6qbLvLgMfBqvtCikWEVcueXB67XEmLM6iByQfXLoOJbpzu8QJQSPzgEoSiR3jDIr5yNugtBxRWlC8WicVy3T2p5TDuxbz6n2Z7C3NRgzWvACNoDBN6RuhHJI8UNUv1kPFMb/mduI5VSaBZKA1O/NCVSMm5sf4uJiEIDSk74QpnKpF8B5tADv/HQsDJmLy1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNjrX0rK55s9aWETWv1OLbCJnKqJuWYa5q+oV4dZTfE=;
 b=pw4M6ocrqjDOOc/zcon9ry+oIGgXAEZhVL4v1w30JvXUrcbp2bjm6CA9waV+kh2hlMXMu7c9bHcHf0nXvrjl83x0K/ACSYCuVrBwehJhBl7JA+vMOy6PclGuNH5x3aeNTk8yyE/ubJbW98IAu5NxRY1Z4JWX2saLH9r0sWYDHIo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 16:38:01 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3825.019; Tue, 2 Feb 2021
 16:38:01 +0000
Date: Tue, 2 Feb 2021 11:37:53 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Martin Radev <martin.b.radev@gmail.com>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <YBl/4c9j+KCTA0iQ@Konrads-MacBook-Pro.local>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin> <20210118151428.GA72213@fedora>
 <YA8O/2qBBzZo5hi7@martin>
Content-Disposition: inline
In-Reply-To: <YA8O/2qBBzZo5hi7@martin>
X-Originating-IP: [138.3.200.4]
X-ClientProxiedBy: MWHPR22CA0037.namprd22.prod.outlook.com
 (2603:10b6:300:69::23) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.4) by
 MWHPR22CA0037.namprd22.prod.outlook.com (2603:10b6:300:69::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 16:37:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4549ced7-10a7-4951-911b-08d8c798e7b8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4115F6B824B114B011A7667D89B59@BY5PR10MB4115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pz3YfKUoMuDBvS1njt8CXWXJojnL04ZzBRJtdA6DLcfYX8gFKS42fnO/Ejhan6WmqBv/Vmu6BxIz9b7hb5v462MzX719VxiLGwtTNlySDeJb9jcPtO7ozzoWHA19NRigXsoPBuO5puu2CxKu0tNWA2uF3Ymye9ZY0x3GEwlxQIUSJvIi6+NT8tTjEqXPi5wU4QTavAT9roL4pALWS+uD94ENxqz6WHeRcI4OXc3Ib9qovK24IDK8dR2lvb1fuiahjw0IKOtH8o/e6WPhHv8a708mPxrOdMYgfOZGaGFG1T+d+Z1oug5setLp2j40F1prvjZhk8PIQRPTgeYK7ApYtSsCg6qHvJaVbgtnrji7WSvswXh+0wfkThEPnAg0heW0LiO3i0nKNXxyvB6LulL5y37Ffcy2sEyXcXgdETnxY6h4pIrjXDSe6XTTOh1MQa/b0y+lY+NLOJfMHNQKdO5a7618N5vyws6IfEEtIpCyI42zy/O1BWtjmdikBEQJ5Dk5Tg9HLkr+2umif6DpVWqesOXhCJ901P1IyrAaKd0iiNUIEBv+RuxeCq5Mv7Qa8NREZIPoMX6P5ZbD+YVr9SGDt8mGZiSKurhRKASS1HYZEMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(16526019)(478600001)(86362001)(6666004)(186003)(6506007)(966005)(55016002)(26005)(9686003)(83380400001)(5660300002)(2906002)(54906003)(66556008)(316002)(956004)(8936002)(6916009)(52116002)(66946007)(66476007)(7696005)(7416002)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T5iFtJautGxKGgRlTBFkAqU12YZ8LrteL7YthkwCHlBAahUF1mMvMKdVkpYY?=
 =?us-ascii?Q?RdJ3iHK2P2jRX2IvneHUOrG8Cywowkqh8n6sqB7Uuquh5rSlBcDboYi+GVMJ?=
 =?us-ascii?Q?njx6ZMLu4lA+aJbLAc28mxS0Dxb6UWkltQIFTqifCAMfuO0fz3voNJhKW9FM?=
 =?us-ascii?Q?BuSwKhqriA7N8uisf99G+KYU2i7D/Sk8F31wIBQtOdXdDAZuJEhkb7sinCVO?=
 =?us-ascii?Q?+gmMvR0/N9wabNgGx+Ty2/WVAFqRJeaOvIh4lhfi8iHiBWRkAr1P5mqAjgS/?=
 =?us-ascii?Q?IR3SyBGQNWMjTknrfKuLhODfKqcig/gzE9UntIRtTTfcdJ+R7D71GyZUeSXS?=
 =?us-ascii?Q?aFQo6uLNRlW7nCyz3BFgmO+sqDRB8v8MHXEyrzTFRRFiGacr6F1R27qIWBwH?=
 =?us-ascii?Q?/UreUTpP6fqlT10i4FlOmMTKbCzwnthoaTE/G4s5cuKp9zGJ24BgnB7H6ZdK?=
 =?us-ascii?Q?otxGg4YPQhk0uITJ3ItBOPwoE1lpyASY6garoK4FBYqQ+2g5EfoK0MejRFJQ?=
 =?us-ascii?Q?KXYpYMS8spRUyGiM+ASFl9Z/uTP3acG8zpG3Qhi21qvEc2VRG8PrV+EMTwQy?=
 =?us-ascii?Q?DJGdQcNgYwmGEPRl6iYuVixq+1qzgP2oIkDn5z6yTY3m6nGJ7bo0ruvYOTud?=
 =?us-ascii?Q?UHKAdkvVKORL9fjB6i6Hel2MhQV75i3/UMRWau9dcMHN2MqGKc/tWBN3vNub?=
 =?us-ascii?Q?cz58jFVOH/MsL3DPlCT9fF9f70XGWyr1TAaRQQsgMTE2kEWVuDeVt/l4CbpH?=
 =?us-ascii?Q?f9El/iAFHoSwM3wLSEsl0lIgmmH5qeVwo7+Dd9TSnWU4piAfuIyjard80N6e?=
 =?us-ascii?Q?0/MlmQJOjAVfTLZZAhum97DcghFGUsq6iOJV87Pmu3P4aMVy/JoTfTxTKLqd?=
 =?us-ascii?Q?y6s9CUXrstZkY0NdRaau3KWscDMu/e8YLtsRnPZBCY8+l5vKvyWFfF/teDne?=
 =?us-ascii?Q?3RW/AIa3oKLK3A2g/GdA7qTFDmeYSBMu7HLXdOUa6iWaypQgvXGLERgsDWVr?=
 =?us-ascii?Q?9xmuSiSI0ZNo9q6x+r/9/qVQs+M/plFQvd6RRk7K0fbzRom+jbuLdizKjOj1?=
 =?us-ascii?Q?7Ob3ke2s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4549ced7-10a7-4951-911b-08d8c798e7b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 16:38:01.7059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+KNOeZQpiAXrpqkQIT59g+IJArD5HXCQsl/x6i6yWxmLIhcL+wo72xmizkxrfsWoUbzLudefGh2dgWAkew90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020108
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020108
Cc: thomas.lendacky@amd.com, file@sect.tu-berlin.de,
 robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 mathias.morbitzer@aisec.fraunhofer.de, Christoph Hellwig <hch@lst.de>,
 kirill.shutemov@linux.intel.com
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

On Mon, Jan 25, 2021 at 07:33:35PM +0100, Martin Radev wrote:
> On Mon, Jan 18, 2021 at 10:14:28AM -0500, Konrad Rzeszutek Wilk wrote:
> > On Mon, Jan 18, 2021 at 12:44:58PM +0100, Martin Radev wrote:
> > > On Wed, Jan 13, 2021 at 12:30:17PM +0100, Christoph Hellwig wrote:
> > > > On Tue, Jan 12, 2021 at 04:07:29PM +0100, Martin Radev wrote:
> > > > > The size of the buffer being bounced is not checked if it happens
> > > > > to be larger than the size of the mapped buffer. Because the size
> > > > > can be controlled by a device, as it's the case with virtio devices,
> > > > > this can lead to memory corruption.
> > > > > 
> > > > 
> > > > I'm really worried about all these hodge podge hacks for not trusted
> > > > hypervisors in the I/O stack.  Instead of trying to harden protocols
> > > > that are fundamentally not designed for this, how about instead coming
> > > > up with a new paravirtualized I/O interface that is specifically
> > > > designed for use with an untrusted hypervisor from the start?
> > > 
> > > Your comment makes sense but then that would require the cooperation
> > > of these vendors and the cloud providers to agree on something meaningful.
> > > I am also not sure whether the end result would be better than hardening
> > > this interface to catch corruption. There is already some validation in
> > > unmap path anyway.
> > > 
> > > Another possibility is to move this hardening to the common virtio code,
> > > but I think the code may become more complicated there since it would
> > > require tracking both the dma_addr and length for each descriptor.
> > 
> > Christoph,
> > 
> > I've been wrestling with the same thing - this is specific to busted
> > drivers. And in reality you could do the same thing with a hardware
> > virtio device (see example in http://thunderclap.io/) - where the
> > mitigation is 'enable the IOMMU to do its job.'.
> > 
> > AMD SEV documents speak about utilizing IOMMU to do this (AMD SEV-SNP)..
> > and while that is great in the future, SEV without IOMMU is now here.
> > 
> > Doing a full circle here, this issue can be exploited with virtio
> > but you could say do that with real hardware too if you hacked the
> > firmware, so if you say used Intel SR-IOV NIC that was compromised
> > on an AMD SEV machine, and plumbed in the guest - the IOMMU inside
> > of the guest would be SWIOTLB code. Last line of defense against
> > bad firmware to say.
> > 
> > As such I am leaning towards taking this code, but I am worried
> > about the performance hit .. but perhaps I shouldn't as if you
> > are using SWIOTLB=force already you are kind of taking a
> > performance hit?
> > 
> 
> I have not measured the performance degradation. This will hit all AMD SEV,
> Intel TDX, IBM Protected Virtualization VMs. I don't expect the hit to
> be large since there are only few added operations per hundreads of copied
> bytes. I could try to measure the performance hit by running some benchmark
> with virtio-net/virtio-blk/virtio-rng.
> 
> Earlier I said:
> > > Another possibility is to move this hardening to the common virtio code,
> > > but I think the code may become more complicated there since it would
> > > require tracking both the dma_addr and length for each descriptor.
> 
> Unfortunately, this doesn't make sense. Even if there's validation for
> the size in the common virtio layer, there will be some other device
> which controls a dma_addr and length passed to dma_unmap* in the
> corresponding driver. The device can target a specific dma-mapped private
> buffer by changing the dma_addr and set a good length to overwrite buffers
> following it.
> 
> So, instead of doing the check in every driver and hitting a performance
> cost even when swiotlb is not used, it's probably better to fix it in
> swiotlb.
> 
> @Tom Lendacky, do you think that it makes sense to harden swiotlb or
> some other approach may be better for the SEV features?

I am not Tom, but this change seems the right way forward regardless if
is TDX, AMD SEV, or any other architecture that encrypt memory and use
SWIOTLB.

Let me queue it up in development branch and do some regression testing.
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
