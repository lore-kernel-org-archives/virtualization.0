Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6657DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 10:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14D73414C6;
	Mon, 14 Mar 2022 10:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fL0_TdElJ8Q3; Mon, 14 Mar 2022 10:37:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A055C410B3;
	Mon, 14 Mar 2022 10:37:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 791FEC0033;
	Mon, 14 Mar 2022 10:37:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C2DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF6BD81339
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="mAmi3ab6";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="utSa6vUX"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJlZOASi3Zbu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 831F681366
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:37:26 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EALn4U017925; 
 Mon, 14 Mar 2022 10:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jCAHN6QkDxsx4nqOjFS4Bt4uWME379IkemNFe6CkZiU=;
 b=mAmi3ab6UZ9NmzFPwJH5RJluhju1fF0FL6GpWqVHkf1H2apYuSYwmdlTrtvWphxcLYOB
 3GXmpe2U4ZwzL/ZdAcNZngg7G3CyMMAZHdbGA4MAyjNup740bsSePPm24aGyTUr3LAxF
 TBI9C2fAI7AwU4dmlX4gWVU6UTMdKHUizjfJQRGpTowHkarsu4BUopUr8RTFgj9uN7QR
 4AtgBf5E05VAUhd0xhsiaVyubVjQrR2gmLW7w08DqqPdBlbeKFsdo8HX9Mowq66dAolY
 e3ut+AhDPTkI0R9xXu9AEwfbyYRHuHSVuetHHfbiAx37qdTKaZQDiE4tDj0O4ciPi9Np QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3erm2tb6by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 10:37:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EAbJ3X062107;
 Mon, 14 Mar 2022 10:37:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by userp3020.oracle.com with ESMTP id 3et446g03v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 10:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z00+J67D4c1RqluvjOHzu4b1kZBXbq0fw0NtP4cDD/n6kpk+S0HUnq5/6cPjgP1AhsxqYPpI+m5tLxSUs4DPtV3tq4rD57SNpwZmSF9rk35//58Ea85rTv7gUc5ikWV1Gb9HrDIDVJDZCTGcDf1MCTrl61U89g/YcVyklwG6bP03n47isjajEFp2ZY8plK4nDUPIqG3gXeAPOR5TVzbnKAftVhE/r0/HRLVksmb68caZhgK0gv9P63DJ+jFm/3Eobeab9/BFXkRSdHH1jLPVfSZ964Y4jbTx0+Qf/EDqYFDF21V4WSOem4WNaEjURzUFBlmfsr8s7no26LqnAaVyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCAHN6QkDxsx4nqOjFS4Bt4uWME379IkemNFe6CkZiU=;
 b=eATxy70nlisJNlZNNJGD6UpKmPNs51MlMkG6eTlZstNW8f0Vn40ynTGh9UQxsV352eBXCLTZdo1DkUPXljvoUoLDw9dXXnMXpgI86Y9mhkCq8TYE0kVWaDlOZWuFlwznCnfUI/0VQg1jC0rXtMgJ47/rUQeq6uQNPwVEU11OBAqBcHctYc3sYtJBEI+hGB46QWFdCnBbcj7+RImU4DzfOgJ502qFJkjeWspchAjREez0L4MQIFyewJ1HeQDloeeZsvJRZjtxGfeXEILDcmL71FVfbgMXI50po9dXRGTNPNg0A5/hJlUFl+XmN+17NWMFYhcE2kGz4yTxqdcTR5XpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCAHN6QkDxsx4nqOjFS4Bt4uWME379IkemNFe6CkZiU=;
 b=utSa6vUXAzIZnGVzoCQ0M7ZMaZvFY1lTHJOcly4+h7dfN5gy7llJupIk6YfWo+tdh6x4KdkkJxvtcIq/pYiyoNBbsO02vcc5KmVSaFeVc4/4mkH7HuOb1MF3lYsMNrpLGEeIgoc9PhAU5FKgZWdhwSlwxgzHkpsdDSKJfvbfSnk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2245.namprd10.prod.outlook.com
 (2603:10b6:910:44::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 10:37:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 10:37:21 +0000
Date: Mon, 14 Mar 2022 13:37:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [bug report] vDPA/ifcvf: implement shared IRQ feature
Message-ID: <20220314103704.GR3315@kadam>
References: <20220311090013.GA7547@kili>
 <b4a33fa9-02f5-aa9d-8a62-868a1121debe@intel.com>
Content-Disposition: inline
In-Reply-To: <b4a33fa9-02f5-aa9d-8a62-868a1121debe@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cbc348a-a0f8-43d1-1738-08da05a69e95
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2245:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2245968928FA1C4FE53DE3C88E0F9@CY4PR1001MB2245.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BXzoLhMXB5WOpH6nfZTdIqkI4VQSvIaiQuQBQBUQtAMvuZ/+RYwRi8TqLSum7ljAsfXzDT71xaORl5oehSinJvOdflxr6QLMnor+3/I4RsfXcxUVREmVmG2hVsbYoXjTH5UwQRiFtFwOmoDImvroontgcHtSGxn3uzr/LNwxrzefAVb+Eee+samCjnrjTSF4u14EC9wKROf6SZEHJftWsW+hbntsyIDw4bVi5omlAG5Mm//sUiY+G3Q8KdaOd4i+chkKqlwIzqwhdkZqFzBAyUtMgoqlmD4slsquOCLhoPsfQ+paiEkKcPLCGpi+6gTAEtYZa1PNk6I1irpzp/Wrf0Y0rVRrlVV4pXWEtrt1u9cWst/DR9ship2yVuWWaEFX7Ti1OThypQJjH+gD+auZIA1qXyZsa3wpcbIwg/5V1PM2U6OZuJCO/WzHfWT58lwtR3Z1/s2/bCu9duXcdfnOmcQn4hltPE5Tc/UGCfSFjaVyqx6ezLw30RDsvKEBvx1IN+96HDXqqU4JW4bh0jv8NxJ8xVq6jrUf9oTsQqeqBMKxmmEqOP1UYmuIvJOaEWNvGR6jXdnYU8ojsuBVjqW7co0LTKHxm4Sdl4z6aRyiow6xBYTLGVoGNaoki0rDLOjENskRMIJGEtlke5Rf+8BsfYjAxpi9z/VClTtZTzk2WSIFtYsDi4X67BuDPIy3D9btieMMLnjFOIIyn3K9VRPaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(8676002)(4326008)(2906002)(86362001)(316002)(44832011)(8936002)(5660300002)(6916009)(66946007)(66556008)(66476007)(83380400001)(33656002)(508600001)(6486002)(52116002)(9686003)(6666004)(6512007)(53546011)(6506007)(33716001)(1076003)(186003)(26005)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J67WiB78We+eiQWgcbnNrcFCQPBQ9gSZVVCZ2SWsqwC2k0Hrm3PV6Akn5pDF?=
 =?us-ascii?Q?jVXDHNyGNr0nldOAqG1e6h1oCmI9wIDrO+Rs2JOt1Zf02QW9Hqz6x9sHC7uW?=
 =?us-ascii?Q?fPiwz6k3KmbPjdnu3zSNQyEwb94+2FVWhJ4FJJEiYTNHO5uOB0xKzqOHRYcm?=
 =?us-ascii?Q?T+OjMDxI5mWLI96L+GxFw+rfCaBKqJ8EOMGJYIMyQkcccQNp9Nly2AweLfmP?=
 =?us-ascii?Q?R3CB4Q3VKbG0oDfCedg5S3MSSMzWnGvT9zQ0OuRwRx7Df/yI4wf6qX6BsxBf?=
 =?us-ascii?Q?+BlUzqjEwjIVQvLzXz9FTKD7rQN3wIJANWcLoqw8Aq/YY/A2l8qn+3PDYWBg?=
 =?us-ascii?Q?HQgBT2u7Me0NRaj2lzpTRijUPh5j6Pi2aAVm+OYlz8r9rt1J1TGFpZwFz8AQ?=
 =?us-ascii?Q?1y/Q8yiD4eR0g3top/2jB5p44f+08PwID+ry02Wfvdcget6fqMAuJASx/PQT?=
 =?us-ascii?Q?Em7xvI2CF6Gvs3Xk3FzQ5DpH/zyOFs6Yv8ZWmBJuhkZsvrQYY9O5m+Tnm6qU?=
 =?us-ascii?Q?UyyO+jcubmSMrO/3O4lK7+qYoqrn1yL/9Rf7ErRFLnpWtkToJ7ZYhdIK2QL6?=
 =?us-ascii?Q?hgKLaZ+RDj7dabgdqmI7Y/VpmN7XoqRaRvzqhXmn9XCIitRPbWt99B6FTfcS?=
 =?us-ascii?Q?U85CJ2nVNQmFQr5MPeMLVdCax9/7E1RwWb9tgkPJnw/BPsGD6+v5tMxTp544?=
 =?us-ascii?Q?Bx2iA+wzQdzti0PINNqiy0EqNeWkYpr2ePl+MRrW0U2EF9cAOBsb2cCrOCJu?=
 =?us-ascii?Q?yo6y1J8S+FSoHWYiKaQ5ObXmbkyh7sv128sQThbxdkXCfx7iY5h+D3sFG6MR?=
 =?us-ascii?Q?c9wupkuDDrrO31De0XoL3xu8nmJ6CtJV72XFGQKciWEnqXgazoqSdxxjZpTj?=
 =?us-ascii?Q?3QRPJdHs5uqdfglQKF0qeBTdLZf20dfXZc74dkudF1LAG+YM25woy+bu46bX?=
 =?us-ascii?Q?iGyAvFs+djHLFXKREH0eg6y3eDyKHKbTa1Yl8D/p8z5R8WeSxTxqx3zwUEny?=
 =?us-ascii?Q?pDY84vTEU/ijF3yS33dY6yXLpRk1SNFJ+VwUkIjG/MPg7t2MMRXB9exMKK7g?=
 =?us-ascii?Q?1f8ui52XpGunMQkk9/t9kgL4VDEmXgjGUKaGYFCqelqX+XVpIOdysNUXJQJg?=
 =?us-ascii?Q?M/UjuXWUtxXSPtd+PifE9SbiTvvP5tOt/Q/Dw4+sDtQH7kBKf1F/SHn3at6C?=
 =?us-ascii?Q?x1DaGxlethbo4uTilz4w1FFK/cdwGPVN/6HgHlDFsJHmExwHqvKYNJhaha3+?=
 =?us-ascii?Q?CtSyqkbYX3FEkFCCdol95yLxoCqnlCokxaHQIj1Psh+qhfmUEWgbIkHa7og7?=
 =?us-ascii?Q?AckgUTPCUFJGGtIR+fgjKNxCYooA1Sc3+HbPlhJsUfE/E9b/LwSi3JRFds8o?=
 =?us-ascii?Q?iEL1gWn/CRX7iufR/vG1vZjBmV/Cat6u4bzlRDMqeI3cvDzCAyjKXdPaM+vZ?=
 =?us-ascii?Q?B9IrJsP/vyMJ8OP2fPyQb8aeAABaK5nbKJpkJEAWRfbxrDzaCF31WQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc348a-a0f8-43d1-1738-08da05a69e95
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 10:37:21.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0NzOMrJ52z0BHltelLpzUh3wK7Els5X7zTxPZOVPTji93jkxUgj+GK4jZk6gUk4uqnmb1T2re+d6IMDmCrTE8bjg+1JDTFUL55VMwflBXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285
 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203140068
X-Proofpoint-GUID: AbRWItXl8o5-T1yX0W_7VEFmyXq9mT1i
X-Proofpoint-ORIG-GUID: AbRWItXl8o5-T1yX0W_7VEFmyXq9mT1i
Cc: virtualization@lists.linux-foundation.org
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

On Mon, Mar 14, 2022 at 10:22:03AM +0800, Zhu, Lingshan wrote:
> Hello Dan,
> 
> Thanks for your suggestions and this auto-testing efforts!
> On handling the vector for device config interrupt, there are three
> possibilities:
> (1)it has a dedicated vector(2)it shares a vector with datapath(3)no
> vectors.
> 
> So in these code below, it handles the three cases, or it should be -EINVAL,
> so IMHO we don't need
> an else there, just leave it -EINVAL.

I'm confused about why you're talking about -EINVAL...  There is no
-EINVAL in this function.

This code is not necessarily buggy.  Right now we have GCC uninitialized
variable warnings turned off so it also doesn't cause a build issue.
But I think we should try to work towards a future where we can
re-enable the GCC warning.  GCC catches a lot of stupid uninitialized
variable bugs and it's better if we can catch them earlier instead of
relying on the kbuild-bot.

regards,
dan carpenter

> 
> Thanks for your efforts!
> Zhu Lingshan
> 
> On 3/11/2022 5:00 PM, Dan Carpenter wrote:
> > Hello Zhu Lingshan,
> > 
> > The patch 79333575b8bd: "vDPA/ifcvf: implement shared IRQ feature"
> > from Feb 22, 2022, leads to the following Smatch static checker
> > warning:
> > 
> > 	drivers/vdpa/ifcvf/ifcvf_main.c:306 ifcvf_request_config_irq()
> > 	error: uninitialized symbol 'config_vector'.> > 
> > drivers/vdpa/ifcvf/ifcvf_main.c
> >      287 static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
> >      288 {
> >      289         struct pci_dev *pdev = adapter->pdev;
> >      290         struct ifcvf_hw *vf = &adapter->vf;
> >      291         int config_vector, ret;
> >      292
> >      293         if (vf->msix_vector_status == MSIX_VECTOR_DEV_SHARED)
> >      294                 return 0;
> >      295
> >      296         if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
> >      297                 /* vector 0 ~ vf->nr_vring for vqs, num vf->nr_vring vector for config interrupt */
> >      298                 config_vector = vf->nr_vring;
> > 
> > Set here.
> > 
> >      299
> >      300         if (vf->msix_vector_status ==  MSIX_VECTOR_SHARED_VQ_AND_CONFIG)
> >      301                 /* vector 0 for vqs and 1 for config interrupt */
> >      302                 config_vector = 1;
> > 
> > And here.  But no else path.
> > 
> >      303
> >      304         snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
> >      305                  pci_name(pdev));
> > --> 306         vf->config_irq = pci_irq_vector(pdev, config_vector);
> >      307         ret = devm_request_irq(&pdev->dev, vf->config_irq,
> >      308                                ifcvf_config_changed, 0,
> >      309                                vf->config_msix_name, vf);
> >      310         if (ret) {
> >      311                 IFCVF_ERR(pdev, "Failed to request config irq\n");
> >      312                 goto err;
> >      313         }
> >      314
> >      315         ret = ifcvf_set_config_vector(vf, config_vector);
> >      316         if (ret == VIRTIO_MSI_NO_VECTOR) {
> >      317                 IFCVF_ERR(pdev, "No msix vector for device config\n");
> >      318                 goto err;
> >      319         }
> >      320
> >      321         return 0;
> >      322 err:
> >      323         ifcvf_free_irq(adapter);
> >      324
> >      325         return -EFAULT;
> >      326 }
> > 
> > regards,
> > dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
