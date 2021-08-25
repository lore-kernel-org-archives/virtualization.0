Return-Path: <SRS0=Jt+z=NQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE7C4338F
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 09:41:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0459D60F91
	for <virtualization@archiver.kernel.org>; Wed, 25 Aug 2021 09:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0459D60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCBC560B57;
	Wed, 25 Aug 2021 09:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYhMSNKALVH3; Wed, 25 Aug 2021 09:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5419D60636;
	Wed, 25 Aug 2021 09:41:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 330EEC001A;
	Wed, 25 Aug 2021 09:41:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6966AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45E9681B71
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="oTTgJTWZ";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="YIwnusX5";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="PEfBtjma"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUmpEl_wd3iA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:41:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40DAF81A30
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Aug 2021 09:41:37 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P6Il6x030422;
 Wed, 25 Aug 2021 09:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=nn+M37eO7GUqVkg0IITjfLoI91ke2cm9aKzCVxGFXjo=;
 b=oTTgJTWZMSIAZiOLzIWjynWqcsyfJwAfuydkP2NuzfwTKWIo1+37jaTkTJ44DKg9P+Gy
 rv+sQPICAH+mmBu6zDN9Hjeh4fFPkfvXxZNa3X2AroDa715EfOQEez81gykwFxnKyXNR
 CFo5oqclvg2XUwZhdSag/5dw4UP39IEg7PUKD1KEcXkY1jumS64EH6lEixtlJ78R0OVn
 bC7qhfGM+/cRxUYW1kfw8fN4a4NeRmIZH5TtMPI293270oYJYntZjReqOKNpKkE0TcU9
 pqSHyGGbJuqHI+0qU59w919uf775BNidm/Mvr1W9BPx6HjnP8+XhDPIw9/yTx7XJrJDr JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=nn+M37eO7GUqVkg0IITjfLoI91ke2cm9aKzCVxGFXjo=;
 b=YIwnusX5g/I3THCPF+TlN7iHhv4Loll7qn7I5UbVGX6dWvmWkYWgWTj78LytUAsddb/I
 Lxbfvhd5DbE1GkAmI5VcvALIZKePSst5xfdJ+HO/iXV0EL4DoLPFDYtnp+Vt4CxIBc69
 ESOzjD+DkFXICscVEvoyqloM+PY7qF+L9ZRwDU9x/g5UYN1LRigFveIgIcBWeEO1OuyZ
 WYhRpZYjeUMes4KFJlF8T6FryFZEKTMUnsIJeztnkH4rOh1wnt0kLFwqy0GAvyEjFdAx
 z9tFZDtMzsg1zphCtSOnroUshCscPQ8MZdMJdHq2qqAPqriDewgbAtwPBIp91rXdGmhY Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3amv67b8x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Aug 2021 09:41:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P9fW4s040992;
 Wed, 25 Aug 2021 09:41:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by userp3020.oracle.com with ESMTP id 3akb8wjmya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Aug 2021 09:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vlc2IhkMlGgnZ9usTn/RP3uc3rOND6aMs8BYHI3CNZsZdk/Kn+zi6LRewms4RSL2koFchXtavNfEJ4nOYHz5kcUFZENfhev6wuQiHo6SVGMwNeEd0SIh3TNsDZwNwL75nlqIGTJK5MvsHgBjvtGtGFV9ZqKKiClN4uffroOlNBdzbvNJQ6YVNiOWqUc847eCLx4M3IeEyzIs49iVyK/CGY3rFJDCA/KlLyn1orhAUYe4W6TMApBt/r9rDXSr6CDxCA2KMTxt24dLOWVyKOrPPInwtxNnKhEJtqH8a+o6IIX4WMbnBCPEHJnVtzGSgAKrs8/oni3xE2DEhyz5bTNmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn+M37eO7GUqVkg0IITjfLoI91ke2cm9aKzCVxGFXjo=;
 b=Ho26+qd4Mtj8Tsw3Iq31Kr2tP+58A8J8FcRx/z1vd4VXslKNRnEzQLHBD67LAmXzMWdhUZko+vwvhs3u8DcXcywudi/ODOzAT0KD43xFos3T0nU3fnjj3jTR8VQUFwbsApeXiQJbr9viiGijbgqEVipBuyWe3X4AQDJEqqLC4Y1eYbtzqxEwdTXfPgd3i416wsUHu6WB6xfcaOesnXZzqNMmdSREBA2JW0dUjViM/rrwE21jIIBAJuhBNHBb0c17bWzC3OvQwhImrApH6A0mUt8KFDNeeevL7XUnrJjah79uZwtOYpIzaioHWSknHM/Wj/yLULZSid8lZm10DrRoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn+M37eO7GUqVkg0IITjfLoI91ke2cm9aKzCVxGFXjo=;
 b=PEfBtjmaTJA1AwG2G0QaSRj9XBce8cBGUWYfkAr38N6slduhdIK0Qr6QeDvetq2fcNo+ala094hYmFFQA08Ac5muPBDUhJG3G6rodB0/vlCEwWZSAqix53YhJCmzAXb/DVUzqT6/MDYtfrT4kGV9iMapraz9zN5d5DU0XuOBN9w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2127.namprd10.prod.outlook.com
 (2603:10b6:301:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 09:41:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 09:41:14 +0000
Date: Wed, 25 Aug 2021 12:40:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: david@redhat.com
Subject: [bug report] virtio-mem: use page_offline_(start|end) when setting
 PageOffline()
Message-ID: <20210825094053.GA31594@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by
 SG2PR03CA0117.apcprd03.prod.outlook.com (2603:1096:4:91::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.6 via Frontend Transport; Wed, 25 Aug 2021 09:41:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8212e4a-5aa4-4c86-93a6-08d967ac7b17
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB212728588EC2A3CE012645888EC69@MWHPR1001MB2127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXemHG0mgMatBHCMJi8El6d2VtmH2k8bCqiPbj+V+oYvKj5xIa5OvmiboJC+hyRNfzSQ6awqrH7KAIkL3GZvLqRbiTi7glv5cVjIyMbOCB51TIIau1ios6A/AGpOok2SDWoXOTCg+cPDiNtASJm/kGbpAA9p28+y2dIXWSstDVOMytlGm3zr1T0g3KdcKjcJdKnh6UnaAH1W99MnMOhR/IIRrEVapYJqOdk7+VUwJbiEpvIUaZFvxvxHoM41G2d8p1qf5LlvrJX0KzIeHyMHx1dM1TTcA4lSd2xJZh98NchV/OGNkBAOMkzCspWcIo4ys5fWjxNKg4CdqNg3tMs0YLd2FMtODJoK1CeTLZDdPWgbPhHmX3GWnesKZFqDpWDyG+aw22zPvgfyl1d+DBj8dj1pNskVGnqSLl+XP6o9fhB+qY/6ymLE6hTJZmjKaN3DsgeUY+56RDuebxRM09I7jCsev2H1jLLNEGwR5C4tUGcjYSz2ULPJdWwUekpMi0nI/I3VoZjYh4sBnyO0ftDiVoemkzV+k3zDv05xFe4GbyEgtazNtaHVTXyMXGw7rlOT8A+TIHf2AvJ2JaGSIIn9UX8o6KYa5OhatY2S0gwe1igj5vQMcaXUX9PvW/+t/mq9rC5qXNqNTKQvvIlP5QsgfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(86362001)(6666004)(316002)(33656002)(33716001)(8936002)(9576002)(6496006)(6916009)(9686003)(478600001)(4326008)(66556008)(8676002)(38100700002)(66476007)(2906002)(66946007)(4744005)(83380400001)(5660300002)(186003)(55016002)(52116002)(1076003)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ls4yXhEIcogDfgCLfw2+nxp100GG6swJ4LXo5wwM1P6l2OvXqL98QqCt8K1?=
 =?us-ascii?Q?PZo51h0y767+Fb5YYNJNIM25r5t+py4PTBWOIvaJglZAh890gcjwpwKt9TC2?=
 =?us-ascii?Q?KVOvnS8wv9r80ej0c0UP5I/YsiI00GP3728+yvgUlhSjyPtIwqokiTfvB2BV?=
 =?us-ascii?Q?q8/SiJLV9Nmf+mn6LLUFcpRL6H80kPplrFEyM/Au/ykb6rJouwxWLow6B3C6?=
 =?us-ascii?Q?6l0toJDEB0pfZ7CMIdFVTSFPW1kxwDbCuR9le1pAO3+XvlPxYzt9K36e4l7L?=
 =?us-ascii?Q?BJV7tcOxhMXEt7w5z6vHXnR9MYvV0ZQQn6KwXa0963eYehEA7nYy+S1VdQvA?=
 =?us-ascii?Q?Br5j3t3l86AAKAThEBYaWoQdiyGQtwNFCmc1T7HwYLpBXZrfSgAH15ipubxG?=
 =?us-ascii?Q?mvenFpNmnajuWKfoGrj3wxViDTopnZuvpHGH5NtUKkUBqw/yThA86YX/C03c?=
 =?us-ascii?Q?tZft6smzrxZDvT6V/s5aVir/q6tugpM3N/QqRCDbwoV7Loba76RXcb1BiwZZ?=
 =?us-ascii?Q?Bzqb9kJ5Xs010a0HvUQMDh5PFsVnTEjjoI/FtXN0/Jil5664g9JvFV21ONW9?=
 =?us-ascii?Q?JwY0IzBc7g9HaEHt2zUSS9DAhjlvBlPJXxHAdQEFQub6NAv6uAahEXLriugj?=
 =?us-ascii?Q?deypU/4UNfJWP1Izvh/thXKnG7z770tvQ6C3QgRg+E5+xCGJZN19TyQ6orrZ?=
 =?us-ascii?Q?H5pmqeqJwRkMleds+hbePVUvwvHYZVYnDh5uzdDF0B4kJEUzzDy20O/PyFdV?=
 =?us-ascii?Q?D784neZlqK3kEMgBZFetK84NeNmxxDmcAg6hI/DYBJvp+vPxIlf4FuIbBmch?=
 =?us-ascii?Q?CdSEfT36wEPfW7tL6rtczMeyrQiVXPiKpaepcwroyoxebz+iVCFajZ51aJAn?=
 =?us-ascii?Q?jGphq8sBATSSj55TfsN4xFMZtnW0k+pGEZ/iFU3/J1BrYEafDf+iM9PLoPa0?=
 =?us-ascii?Q?yoGieKvIk0FfvT99IIBrl2DFGuW0y1Vm83pTgbNXSRfpL4R2fmaXxHZQsYKZ?=
 =?us-ascii?Q?4k/6AsIP7mHdWwPsjvrnFkH8n+OHWXMgBSQAwRmxxaHJBqqFk7o6Od0uS9hp?=
 =?us-ascii?Q?yIsxoAPVlIWkXFjeVS9q2AXCyhXd1SyuzRA7yy24RUPkZJH97OtI4w2J4ezy?=
 =?us-ascii?Q?4YOS51Hzee56ft6qgoTnWZ2R5XnTG0Bkdm/higLgH4aMi6frogROhnEoZG8r?=
 =?us-ascii?Q?E5FgeCymtkUcOT7vD528kP7Hf9PGiTjlPFuM23MX6zf9CjgWQszZH+c+laek?=
 =?us-ascii?Q?D1SVA0wrLYKNBxq4sFWW9f6y5ACoe6EG/0qd7fn7fVOjPwsD7z87p+L0lZBh?=
 =?us-ascii?Q?3IeQ/0urQXE6TnYj4uZF1bZip8wULvI1ir2BNQIEw/5OP+OScqS63OhAQ3uy?=
 =?us-ascii?Q?5ZlLfnc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8212e4a-5aa4-4c86-93a6-08d967ac7b17
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 09:41:14.7852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFp49w/SzWDK5ts4ztR4bS/TvKV03l5Kv/hS5Z+65b05L8ADriN3yqpKglQ0/eJSGkmfDbJgoiMYuQz1vxphilFjBV9jGl3gYTNjq5pN1bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=816 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250056
X-Proofpoint-ORIG-GUID: GoQSTLgyJEwj0rcK3pHOKebl9c9qXfPS
X-Proofpoint-GUID: GoQSTLgyJEwj0rcK3pHOKebl9c9qXfPS
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

Hello David Hildenbrand,

The patch 6cc26d77613a: "virtio-mem: use page_offline_(start|end)
when setting PageOffline()" from Jun 30, 2021, leads to the following
Smatch static checker warning:

	drivers/virtio/virtio_mem.c:1072 virtio_mem_set_fake_offline()
	warn: sleeping in atomic context

drivers/virtio/virtio_mem.c
    1069 static void virtio_mem_set_fake_offline(unsigned long pfn,
    1070 					unsigned long nr_pages, bool onlined)
    1071 {
--> 1072 	page_offline_begin();

virtio_mem_online_page_cb() is holding rcu_read_lock() so calling
page_offline_begin() here is sleeping in atomic bug.

    1073 	for (; nr_pages--; pfn++) {
    1074 		struct page *page = pfn_to_page(pfn);
    1075 
    1076 		__SetPageOffline(page);
    1077 		if (!onlined) {
    1078 			SetPageDirty(page);
    1079 			/* FIXME: remove after cleanups */
    1080 			ClearPageReserved(page);
    1081 		}
    1082 	}
    1083 	page_offline_end();
    1084 }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
