Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C678C433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 08:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BBA841592;
	Tue, 15 Mar 2022 08:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r1OfbY0ky5_9; Tue, 15 Mar 2022 08:54:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F09F415CD;
	Tue, 15 Mar 2022 08:54:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4377AC001A;
	Tue, 15 Mar 2022 08:54:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B94D2C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F6AE415CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75tboz4_71uO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8052F41592
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:54:30 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F8Luqf008028; 
 Tue, 15 Mar 2022 08:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=yQqXXqY6ygF7m7yq1dVDDx7A4JAeooUYzMqpXr+4YDc=;
 b=aFVoqZ1JL+cqYOKd+K9p3tSDDsnEJ+/Gz2LUNj35UU3zcsG+WF0XAkRx/hAIoQfUbM6I
 8PQgFeUyYAvMNwSebwRS4mvgf2NF8Es37DEp7nHKHu+yLPxwyDWCAdCAaSpOcsv7AS7D
 kRKAEPyStiu19ScdTyOKE1as2wQdEsuGgnJ/8fMQ6X5K9zX6ckP9v0NH3m5YdgDWBTrs
 PWuvOX2Oc6sBUknqW8dtSCEVzQeemW5FftFVbtwuM+8BUYJWdyEDf6IyF30ic0w4NAix
 zrdq48cl11z3MMFaCADOIct1B3q9lxTLffPAp9QOr5s/qUmTA/xR0sasehL6XnWGZ0pM Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6jj6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 08:54:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F8koBE119020;
 Tue, 15 Mar 2022 08:54:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
 by userp3030.oracle.com with ESMTP id 3et65pdty7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 08:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr+peYa0dJsCUj1iwEsPJx9TK6izyqM6q61DbF3SFqE/XP5TofoMRlY/kwdyn5WHmnQVoKq+PkiXJ8PgeIEI6dyTyqseJjED5DXC01cbSAq4egJxI81mn8dLcLrUiwJZ9OyFsqbowaxMkFvjHXck0JkSk9am/GzP+F6IXCXkJQEYoT5tyeX49RuImvqEy+jZyBrfXwwrUNTfhJxOzYf9vWbDqYeVA7ELYthlPS+2BDdLlBE01E2r8JNfbjc9DkbhTV66irz6KoNB6NOAogZTFGrOrDMzY5VnQbdaXHP1Ruzf0scQQySZYfI7KlKdcmmQqLVlwHpTsEIJcL3U2SCDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQqXXqY6ygF7m7yq1dVDDx7A4JAeooUYzMqpXr+4YDc=;
 b=hBHzzBhgizgNtce0agxMVf/LqJ5WgpcySZbjZpRmFzLl/K7CbXxV7sLUxMeIqrAmrCUc/FCGZpNcshtLe/JemUxD12vG4TBLE3hBBUAqVP7dN1ewoRdsp90MahGYUanFlx3tXFDpx3YjTYrJSLZo4c0u+A61ECuhcYxb/P/2RuicaPYCo+IXkds1PQM4WJtJ/2eMmtfVuRL8nrRjbe/rRLCMEgWqASSkigk5jiNhmv6NBzE4B8FXqa5YGOmFN6wQ+CxTmPHPLHw4rqtpt2ic+XB86BzThEQ9dwrtVcgi1h+OGANiLJipnzEcFLJdMW5yysdDnEIihJFXQWxENKydaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQqXXqY6ygF7m7yq1dVDDx7A4JAeooUYzMqpXr+4YDc=;
 b=BXFwoCgRK3e8Ca/lJKWepNRxrghAEql7AfKuj+Zv1ONpmGwBCIWWv0hpfZ9LlC4YitlReeYMYULWj7Alq+61qv46eQX1RNxhDTOV7QvoK4UrqPEyWlOP/g3S31joma4eInp/3QwAB4MoroYa4SjDW130IbX3+cLx2Pxnq2s4jRE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3230.namprd10.prod.outlook.com
 (2603:10b6:208:128::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 08:54:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 08:54:24 +0000
Date: Tue, 15 Mar 2022 11:54:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [bug report] vDPA/ifcvf: implement shared IRQ feature
Message-ID: <20220315085403.GU3315@kadam>
References: <20220311090013.GA7547@kili>
 <b4a33fa9-02f5-aa9d-8a62-868a1121debe@intel.com>
 <20220314103704.GR3315@kadam>
 <5a0462a2-8361-4b08-19b3-d4771e177764@intel.com>
Content-Disposition: inline
In-Reply-To: <5a0462a2-8361-4b08-19b3-d4771e177764@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dcb2bda-a0f0-4f55-b221-08da06616717
X-MS-TrafficTypeDiagnostic: MN2PR10MB3230:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3230F7EBFD22DD0C34F2B2678E109@MN2PR10MB3230.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7Eur4qJ/bqVCOerMK2MmgyKfmvm98OEntMGPETw1ybVVDAffK3b9FMEw90sQeD/ZXERXhjA1y+47gAOiyxkZxfqSr+IfLd2pYM5j7A4zPxAuAALsZXDeTo3b+vuQAG7L0vLBXSJElo2XQmLDctBznnuaUs7F30PgAfHDtgF6o9oYku9v+tO0e4bq2LstRBqExDzzQ+eUEO8Fdzir3NVIDb3AssfhJDvLPMGlOctWFA8WRwDQYvNZO6Bw32vO48AJLBLDbXiB18ALZuaWKqy8xC3+O2JujnPwLctwdSCG8Sjsd3Nt58wN/RugEwL4V8P0H5PBGQNdEyo2sUDVzRgFZWOUF64SmWYz8/h5J9qdWLTYi8p1lyxHQG1809Vz63hOU3RKLiYoQ3Qkhh2co5eY21YyKgmUyh/0PP9GFj5u45TJzkbd3k6031JEK1G7A3ebc32+LE3yLr+uG9QZs6QRyj0/wVqQJom/gWLpYKjwptHEvesNTfmb7bAOcRGtzA1SFe5tLHInWT8J6qBUNJYeHeP3ZdJtCcLZqR87Afl6TD6eud2nZGsg7OHRjut4mUovvtHITRvONS2SZAwozzQPHQKdUdb1xx9LcnoJSW7wD8eo9wyGta/7n/KBzlyrSnNN7td+2KACkMN3oCBwAvKC1K8jgdORqWl8Vk6jMPrFIVdGhKCLIUZjckpsgyu+P33I7tqcjovp1i8YaE/NAmwlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(86362001)(2906002)(1076003)(38100700002)(44832011)(5660300002)(26005)(8936002)(38350700002)(53546011)(52116002)(33656002)(9686003)(6666004)(6916009)(316002)(33716001)(6512007)(6506007)(508600001)(83380400001)(8676002)(6486002)(4326008)(66476007)(66556008)(186003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8E8avyn2MseQVDApRYiuSC0kJG3l3etcbe7hglFQJDv4F9Y6LrgHgAM4LA8?=
 =?us-ascii?Q?tNt3ZOW4jCLdvPZQogVucl+oDREnkFVNUIX79hv9RrbZr8N83t4Pe5e2dsRK?=
 =?us-ascii?Q?h2s7OY+E9D3yGTlnloY4iOHKvgb+rmGrBTeQk1m1tCfqnEMozWyJQshUZZvm?=
 =?us-ascii?Q?ErdqBCqoJlKxfPtMcfLyzrBQyMaJBqCvY3dviXDTH5JHJe9TTffrWAirIi+T?=
 =?us-ascii?Q?lvQG+UGRqYozeIxsT2TxabAU+s2wJdpf5BZGpnyyBU8zijo23UdFwz1xvE/w?=
 =?us-ascii?Q?9V2qHurnzRPbXuYnxI8KpPR+1VynUDd3fkx8iWQu+Mrg02yw2QTzB/A2q50k?=
 =?us-ascii?Q?kRORP1/KdvD2i3Cbik64QCPwXow5IeWQF6SR0Ef91QR95qDFqGDKOsybCm92?=
 =?us-ascii?Q?i1j7HfVYlA8hwKeo13C+NRKL82X1TMIA5IRXzX2FsTJ4oMJEpJK0jhRK6dFb?=
 =?us-ascii?Q?Xnvz/4H2KcTzvCF/k+Ejs/Wf1ktVnm3fy4ExS670ntyCX4wJkLklAKMGi3/c?=
 =?us-ascii?Q?jomvpZyu/nKCh98k+nOxYLH99iSQFR0ELJeHHYHZiD69h1kVws1se6cXdGOv?=
 =?us-ascii?Q?8HrmbtMMv+umlLXycaXSjdHjDOGlFprZVcz9vjK+bvZl0IezPA8VE+yIfJdo?=
 =?us-ascii?Q?4iUoEApPTSSfrlLZJ3omICSYTfrkRtxFkdrAs/TKhjp91fDvg042zpY4OREz?=
 =?us-ascii?Q?9Bgv6pAQhSiM7Wp0emKVK2vl3eXXkimwf7hWh3eJgtqwobLT607d9LLdt5rp?=
 =?us-ascii?Q?lhMct6I+vknTpoFNFYAjp6bOCebhS3eA/8WM6jqPCmdS5QUHwY2bF+A8+5EI?=
 =?us-ascii?Q?ADYuYAOQHAT6ARBM/IyqnXbdT5y+9DJlMlSR2IMiQx2ZtJJOrXuu2jTYptTd?=
 =?us-ascii?Q?BeSq04AvzCSyCE4IfIl0tiI1Mz/LFOWHVssEwfUm/ZcaNM+PuvoMAsonCsrB?=
 =?us-ascii?Q?V0/53EIbi3JetDSg0BPUtDTUYPy+iiaG152KKtan/WrNq3MprYGzECkGb1IU?=
 =?us-ascii?Q?v3RzWUslZNUHy4+AeIivWwexM1ssnXqB5cFUCqEF80VeonkJHN2ZTVnfogaA?=
 =?us-ascii?Q?VYi1ncaNfb4SS/MWQdUMiqYyL8U19eMCRCh4nzJ7n/q0o9f+hAwdRReqOXB8?=
 =?us-ascii?Q?4KWkXxqtOXcVuaKE5dYmH10cqTk1Ul4xgqIIjX8WuaQ6MyJMN+zkzBQjZCZT?=
 =?us-ascii?Q?ushTHaJtVrOh1LOPt/LjXWJvQkcZEfY+HxhWIhWR/UvWDSTVjUs1TU2WQiwG?=
 =?us-ascii?Q?XHHcjTn7knvxvrgNIJFA4ho1RuePlqkC5kSnUMOvhwuJi+cYLGm2d+ESCMPy?=
 =?us-ascii?Q?Zps3v1KyvRgg6BJ9XyGOude4zusXsUxbx9E15uLv7FugDQAY+ScgOSg9fWqc?=
 =?us-ascii?Q?L0ur4jqU0ySjjCIhN5JInQqxb2I9xAimoFU3O252g0YIzK0IxojX9Rjbh6dp?=
 =?us-ascii?Q?5jkBzS/qFlQLqbAPzFPqSiswAZeU+oYz0IQOyfsFqLbI2Ht56og2XA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb2bda-a0f0-4f55-b221-08da06616717
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 08:54:24.3484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtIJIR5RCUMetEDemhVPHXw9nMeeMdN5MWMMG+7qP3BvBq6axBkwJxMdR/Wa4Hpqb9sr7m6TJYZ8ykTczxNYQaKspTua5A+kSTgG2HC9Q58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3230
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286
 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150057
X-Proofpoint-GUID: Q5hTNuruL3MMtUWL7tSbKVHfqDzXNL8j
X-Proofpoint-ORIG-GUID: Q5hTNuruL3MMtUWL7tSbKVHfqDzXNL8j
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

On Tue, Mar 15, 2022 at 10:27:35AM +0800, Zhu, Lingshan wrote:
> 
> 
> On 3/14/2022 6:37 PM, Dan Carpenter wrote:
> > On Mon, Mar 14, 2022 at 10:22:03AM +0800, Zhu, Lingshan wrote:
> > > Hello Dan,
> > > 
> > > Thanks for your suggestions and this auto-testing efforts!
> > > On handling the vector for device config interrupt, there are three
> > > possibilities:
> > > (1)it has a dedicated vector(2)it shares a vector with datapath(3)no
> > > vectors.
> > > 
> > > So in these code below, it handles the three cases, or it should be -EINVAL,
> > > so IMHO we don't need
> > > an else there, just leave it -EINVAL.
> > I'm confused about why you're talking about -EINVAL...  There is no
> > -EINVAL in this function.
> Oh, sorry I didn't explain this well. It is a series of patches, in other
> patches, we initialize hw->config_irq = -EINVAL
> as a safe default value. In this function ifcvf_request_config_irq(),
> hw->config_irq is generated by request_config_irq().
> 
> Then config_vector matters, there are only three possible values the
> config_vector can be(listed above),
> depending on vf->msix_vector_status. And vf->msix_vector_status depends on
> how many MSI vectors we got,
> 
> so there are only three values it can take, IMHO, it is a complete set of
> the possibilities, we already
> handled "else" in ifcvf_request_irq().

Alright, fine.  Yes, I verified this and it's a false positive.  But GCC
will also warn about this code if we manage to enable the GCC warning
again.

If we make a chart like this:

              [looks correct] [ looks buggy ]
[ no warnings]     1                 2
  [ warnings ]     3                 4


Where you want to be is in box 1 where it looks correct and has no
warnings.  Boxes 2 and 3 are a second best option because if it doesn't
have static checker warnings, people won't notice it.  Or if the
warnings are obvious false postives they can skip over it quickly.

But this code is box 4 where it is a big waste of time for anyone
running a static checker.

I almost prefer actual bugs to code which is deliberately written to
fit in box 4.

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
