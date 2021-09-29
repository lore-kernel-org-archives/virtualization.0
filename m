Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5500C433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 13:54:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BDD6140F
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 13:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66BDD6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FB7C406F9;
	Wed, 29 Sep 2021 13:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rRgBL-xtQw6H; Wed, 29 Sep 2021 13:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5163040015;
	Wed, 29 Sep 2021 13:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23535C0011;
	Wed, 29 Sep 2021 13:54:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E13C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 13:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38A2760656
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 13:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="hGhZZr+Y";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="kFEfR7Wh"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lNJWhfy0PhWp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 13:54:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC73960619
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 13:54:41 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TDa5RK013615; 
 Wed, 29 Sep 2021 13:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WPAAou6wVHMgUCVMdPxkNpFIF1NlNXSS679xtOlXse8=;
 b=hGhZZr+YFx8Yq2VxjJfxoG/+QScmYDforazSyqkWlx1iH/7aqbyiJEvr32bN+34Uwuve
 wIIL73zxIffiwlNVdxIvdPy8AIGhsGin9FD5vIidAyKZNet1GH5Gr1m09w+7E3Uy8Wnt
 DFdz3hecsIPeEOdGJCcD1U1qKUXuUn7xxgHfEC4KWuqN5djAGo/ZGek9VxgPjaw40dQ7
 9BbTpY9+j1QnKMJQtlKTSFgbgXt0jSu5RZOOAqAC1uQXt8d+yLsIZqeeZ4HA0bHXMuH6
 hXYPqVeNwpNwpcTbgvnFkZ4JzBjohX3UAZVK8zacK6eKvYTUDg5HEFBRnbf5Ly467UHW Mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6cuanr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 13:54:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TDFi50147865;
 Wed, 29 Sep 2021 13:22:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by aserp3020.oracle.com with ESMTP id 3bceu5dtf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 13:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itxPsvOQRyEphxRry6tVP+7yOalt6wsmV+1HnaPnqO9E1R9yxvx9rLag7oj7XD5F+lFwI9++w1ATyOI+fCmX6ZiUpq+f6RChFSM0cZbT8pA+R7YiQ294ueOYgQzuq1n6QpPjE3hqA0HBEulSklOOkPSbEDbboqIcWv4T66PNmLyl66b60v+en7TRT0BW8mYYPVWMQukEzl8HspBL9pLrTr1HNKFhrtwqUwon6cAf90w81f3PfFvyk+fv+WuwGkHKpxhnoKyOFIPFT+e3IivI1owEU83CdQJSPDPYm+nLicZcXyf9wNBr+l4Ofu+svIFH2chmt7fkuSJUBRJSwAjp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WPAAou6wVHMgUCVMdPxkNpFIF1NlNXSS679xtOlXse8=;
 b=UX0K/MwiCi1IdNH3okY3JdhpLy3Rx77wBGB/YPQb4xLw23+DuOYF1lJuR3hCeyJcmrGgyIsHaIVJQ55EY1lmkZJes8DNxkvg3fs7vI5ND4282k6VJLvrr/HGvOJ5mbqewgJpHC5ksKY5SmzKMiz+WZRVr/d/gjGGKgIeURGatvEmt8Zri2sTGrZJIDmV8KXRuOPWTT7Ck/JFFgl0/I+yInDhzCJbGgIgDOcfXmLt2BvXCC0Q9ZsjtkIWMG7On8EAAKpjvIQPAkc27bDd0z6qLLdOMmnoIoXuuxVyhxuPkp533cjneRUydRnyIrumy2UnnBipFfU4KrHJsTV1mPxM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPAAou6wVHMgUCVMdPxkNpFIF1NlNXSS679xtOlXse8=;
 b=kFEfR7Wh6dCYCzmy2tk4KuMOOVopiOeAic16e7jtk4PvHQ8bGqn7MZFdJHPwkcphPzxmilRhc+OyL31Sc95Tlrs6Ywr8svLTDaoaCrz+1z5KGE0NqTqekqNNHgHcdcVO6QaKb0g+KaLT56EvThKQ+qdxukU7lZ3zuXzD+Hx4BEc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5556.namprd10.prod.outlook.com
 (2603:10b6:303:143::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 13:22:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 13:22:44 +0000
Date: Wed, 29 Sep 2021 16:22:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [bug report] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20210929132230.GW2083@kadam>
References: <20210929113742.GA7928@kili> <20210929114652.GV2083@kadam>
 <20210929120712.annzkdwfy2g3sa2e@steredhat>
Content-Disposition: inline
In-Reply-To: <20210929120712.annzkdwfy2g3sa2e@steredhat>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0014.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:0:19::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 13:22:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4230526a-362c-4083-ffe4-08d9834c38c5
X-MS-TrafficTypeDiagnostic: CO6PR10MB5556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB55560737C6A12E57774BFD8D8EA99@CO6PR10MB5556.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DvknH1nFnHdWBmur3bKRs2UnDUScyUSzfAekTWBp9XLv44D4DxqtTHrDwmeCiN6ex3NUpzDt5+cMneQnymbjilp57tK9yo93DPwYiXdowz8zyEk0joluRSfntrAsGkF/GORDyJ11wsmzbIEwjfw7QpQEXliTwPnYlbOCN2Rew2Viz6rJmx3SAhtwP6bMyIj2lH4wiHUX7qPzhvHZswblI/d9HOrgQoY90wCaxqcLUC3qPmp5Cgc6+syxc/qkasipFDUBkDBjA93r1pCeiQza0rfso82JaNELUdHpXrzDM2qC5KLBg5eps0yV5INBrumLXO5anFuL8ROtprtw2xgdBemEOnx5q4DljlA4BUEAmSVifogp3PBRTIFyDl7nhxs+UmSRg7+UwQo//8pJ9O1I2KZtO4Y3Pf2HihVt2Royomi2EpeIqPeJvy0xe4sYxJ2v53GDww11Jb3yrT7OwTG36IDWkKuhyMAVDhCgTmRl/70mbtGIPC5bj9tPCFuxQ7Ql9b/Lb5Z6pAKkG3SF8CCr36Bd/fNeeGhQ2ryPDFWz+ioeaH7XRRQhbukm6eTeNvVXCVY/brY1T3UYIOWT0raVlmAtLP6bmBcQEQkN5w/nG5sxXtrbW882dUwooa49hLPA0I5FvKhZjOprPmUF9mLz99iyhzT0OMhnLkT6iDVfSgVjQFnsFzxzYp7e7NbZMVJvHENqT0M0GKojbqK7H13oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6496006)(6666004)(38100700002)(2906002)(44832011)(4326008)(86362001)(52116002)(83380400001)(5660300002)(508600001)(9576002)(55016002)(8676002)(956004)(9686003)(6916009)(66946007)(66476007)(66556008)(1076003)(38350700002)(33716001)(26005)(8936002)(33656002)(316002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OArRYaJW2LaVdADTBbdOUBh6+JB/eJu+K9joAY6F77XKhjCdD0cZBkueW/Jm?=
 =?us-ascii?Q?uA9VsM36JNWSsf3hsinA5Srk8743kbusy6/D2CSdPBrfV/cIdLT5uaU7Kq1V?=
 =?us-ascii?Q?xpeB7enDh893XZyvuhI9lnYEk0LVT0dttfA9jHJzHW5w+d3MKjtBTyl5Y2li?=
 =?us-ascii?Q?gqUmRaaPfaQu1B0STRO8pVuafiDNHYY9aRXaQuPyqz1eoZ187lsjxMjv66ex?=
 =?us-ascii?Q?t2OhvbUWqWsTK7hrFXPc8dv9R5L+G1ohaDtOO1jqXI3poQz+o45COu9D1hEh?=
 =?us-ascii?Q?e/00IUKEEhx7+q1U/eBd9WDXtgbXM5jXEI8OZxNPjV8R+Dk+W89gw5noW/zV?=
 =?us-ascii?Q?xEDDwoRXxuRO7hi/YHEIDRH+ShHh2/Q+cwPYm3oFF3Wk0OrxJjmV5b4LRi82?=
 =?us-ascii?Q?9bdY129t76gfmTifnPkGrA+U9rOnfB18571/3jzNfI+6EHHJSv0+Uaf6xa5a?=
 =?us-ascii?Q?b30ZhKeAN/eiKrm0zwWkIzHYMdkEBXx8a/Utin4HKD8m9hKRceT6KSVIgKAs?=
 =?us-ascii?Q?/dZcG4BO7yXR+MV5OMCBqV8XbKTT3N5LGwae4X+4ffbcyZXV2/za8CbnoA43?=
 =?us-ascii?Q?vjsEPGn5u9YEoqmdPuLijumUZd1cuUlmDvsVTM/nwDpklsmxSGFtGlzLRQ6/?=
 =?us-ascii?Q?tWqje4s/XuGywlF1wrY1zOBUY5EzD+oQ9aBMmOlXkoQydyn1q95nPCyJht5N?=
 =?us-ascii?Q?dXBlkTdigaOTj8r25Gczracaub70wuXLFo9Pi4ybM/VVpIdjJ5pvOyuyRkuH?=
 =?us-ascii?Q?BR1bTneUCISv1s8uaRfzJKlE3Q09OgWTrnZwV30PcuCscw2ZZaIwnsYKH47d?=
 =?us-ascii?Q?S6I64m3kg+0r3tFzRNNtRjMyRbfcEOhCPMLdtSz6h53ff18aAswniTD+FlZy?=
 =?us-ascii?Q?euqLamxc+wDlNHS58omoRJ8r1hg1qMF8UnFjIb/q0le1ZLt3T5ZvH7Tva2y5?=
 =?us-ascii?Q?MLWPpB6zy3e5tKQxGYqJ240JlGEEwvt30bLBhMUt//mgYUUBKT0LtB633ANH?=
 =?us-ascii?Q?DzWD1R3NrrZ6fPIDZpJxcPXnpJKpxTRp4CfYYHuB28IcQ9U+NCuUm6NJVf+r?=
 =?us-ascii?Q?hWNbylRqoTTWxt/JLjrQXrOVyssU/POBinIp/ye2HZvpiaRprPw7zu/ce9Bf?=
 =?us-ascii?Q?sGIIW8CO62DB9coNXntSFVnTbJixO101CLz9LbZ9h5QzjRdqh6MPbvf2l1BV?=
 =?us-ascii?Q?HA+0dicew+P0ui8fuXOY0ZfgP7etau4JnVH7cEvcarQsjTA2ihD/YB62dRbu?=
 =?us-ascii?Q?inm8SBvgPN/1LloPh5We1QB1znW9vPiK+Dp4920K4sqGk+ucLYIR3Crp9jZ9?=
 =?us-ascii?Q?D9zoB+DjrIhwl1KVZMzkmbMw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4230526a-362c-4083-ffe4-08d9834c38c5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 13:22:44.4438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpJEzKHtAy2jhOqO+YxBH0rq/nH/moRRZXv9RpZrwlJ0sSd0ffFE/aqI6BwDwj9hDlGZXCd+xqm4uEpbO6IcircfZ28DMn3nPT6gefJQOLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290083
X-Proofpoint-GUID: bcVa-Y0HLypYAOQInk_0YrQe2OblYXly
X-Proofpoint-ORIG-GUID: bcVa-Y0HLypYAOQInk_0YrQe2OblYXly
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

On Wed, Sep 29, 2021 at 02:07:12PM +0200, Stefano Garzarella wrote:
> On Wed, Sep 29, 2021 at 02:46:52PM +0300, Dan Carpenter wrote:
> > On Wed, Sep 29, 2021 at 02:37:42PM +0300, Dan Carpenter wrote:
> > >     89         /* The last byte is the status and we checked if the last iov has
> > >     90          * enough room for it.
> > >     91          */
> > >     92         to_push = vringh_kiov_length(&vq->in_iov) - 1;
> > > 
> > > Are you positive that vringh_kiov_length() cannot be zero?  I looked at
> > > the range_check() and there is no check for "if (*len == 0)".
> > > 
> > >     93
> > >     94         to_pull = vringh_kiov_length(&vq->out_iov);
> > >     95
> > >     96         bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
> > >     97                                       sizeof(hdr));
> > >     98         if (bytes != sizeof(hdr)) {
> > >     99                 dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
> > >     100                 return false;
> > >     101         }
> > >     102
> > >     103         to_pull -= bytes;
> > > 
> > > The same "bytes" is used for both to_pull and to_push.  In this
> > > assignment it would only be used for the default case which prints an
> > > error message.
> > > 
> > 
> > Sorry, no.  This part is wrong.  "bytes" is not used for "to_push"
> > either here or below.  But I still am not sure "*len == 0" or how we
> 
> At line 84 we check that the last `in_iov` has at least one byte, so
> vringh_kiov_length(&vq->in_iov) cannot be zero.
> It will return the sum of all lengths, so at least 1.
> 
> Maybe better to add a comment.
> 
> > know that "to_push >= VIRTIO_BLK_ID_BYTES".
> 
> vringh_iov_push_iotlb() will push at least the bytes available in `in_iov`,
> if these are less, it will copy less bytes of VIRTIO_BLK_ID_BYTES.
> 
> Maybe here it would be better to add a check because the driver isn't
> following the specification.
> 
> And I'd avoid the subtraction highlighted by Smatch static checker.
> 
> Thanks for reporting. I'll send patches to fix these issues.

Nothing to fix, really.  I've looked at what you've explained and it's
all true so the code is fine as-is.  Thanks so much.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
