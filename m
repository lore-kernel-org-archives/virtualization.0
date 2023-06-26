Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F5EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A6F660E91;
	Mon, 26 Jun 2023 23:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A6F660E91
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=PsMN+WJ0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xrczjo3w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p74NcDQlRSkf; Mon, 26 Jun 2023 23:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1BF160B16;
	Mon, 26 Jun 2023 23:23:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1BF160B16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFD4C0037;
	Mon, 26 Jun 2023 23:23:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42F96C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 071FB4187E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 071FB4187E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=PsMN+WJ0; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=xrczjo3w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bOJBjK4wn6Np
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D77304187A
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D77304187A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMiQNO001846; Mon, 26 Jun 2023 23:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BDQKoTL8e6NNA8y/5wFGvkFsEOuRqRtDb1pHkWAf4CA=;
 b=PsMN+WJ0uLNg8sBWku33Uv5bNqw4VzsvdpGkcg47EXzJVsXluA5fc00LdTjP+MkowoWS
 4OYoX5xVQdt3QV1E3a1ovIMdvqfQhi72VfjUj/51DIKR4LZZYGonmMpCfq59A5EAvML0
 t7GHV4PupIlBbukOnJt4v2aJq1RwJqZ7g14P0ktA4HXuOSCMQEwv/txv/y+++h1GdN/K
 00vRx42hfj6iEbiUyO3RB0bcsLftuME6ED9TuhPUj4LnucMuZd9MK8C2EwVqe7ydxV6o
 8/ztrBq6mdEBF6yUPA2n0GrhZPYH+A3DroBdMia2ZN8gqE0YFkke5y3ZyoLAase2jer5 iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca3p1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:38 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QM19KA005090; Mon, 26 Jun 2023 23:23:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx9rj4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv5zSPZot/iyKHxm6BqDDM5XfOsdEn8kV23qH9RKCMcz60ergEHwzNzU8zRQ4yORfLD3jGH0jxnMe+Q83kWX5XeDJ/8/w73xmZ55WZfJFPL0YvnJq/4Ay1rjF7gdzoKdr2i81h47M6VX0geYh+fEE0UxO6tbsSUA2bpA9zThLDuBZpsmYNF/jadUtweew8KQPKSBktU96i4aW43+g+W3i9VKPFkjtq5N6vHnQf/faaPDLWiK8+/OyrwuSWz6wOvcl38SQ1zTTG/GwhQh8qvEnoIMoMNkUsR93KkrAqym0bEAwFZNbJ6kbIGs4eVXZFrWILRLn2srrEwu+xueZAP2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDQKoTL8e6NNA8y/5wFGvkFsEOuRqRtDb1pHkWAf4CA=;
 b=edNauzzUKjcNHULoZ7hy1k+yFuogNj0vZVVwjjE57ffoUeBnLuAfDfT5tP6wpl6+CDT09ByY/bXBHE9u4ClmshsbRPhGzaxl+xoiwqiLqhi/JAZH03UKU4PuHXY53h9nmXtXeDNOpW6f3qWDqlzfB3jj530oqcV9a3qslB9XovEAkLf7E5MrYYXDZEeJX80LSpsQtdPd5/575UVEaavZcPPefsLL2bC0xAaQak4X7qC9UZ/5Bn3grTPmAqpUc8NeiydksuAf6909oa8If2AjUDzKme8twaadXESUItmBzbcKjqciHEIE1WWFdkmQpC0oRUfaFLhst2a01vXcXXtnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDQKoTL8e6NNA8y/5wFGvkFsEOuRqRtDb1pHkWAf4CA=;
 b=xrczjo3wMS//HtC90WzWXw2Chd3AhYzhYp8tcUIOj0nc1zLjL/FqHvjtOK35v5ZyCkubljgOXx9CSKoV9PtbELj9h7C2pLrFjY86D2dRYeAi6XtVollfGLE0B4Z6ICFRKuuBrUkfazzhPGM0o3DObuWnLKfGMua6L3Hvds9ES8M=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:35 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:35 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 16/17] vhost_scsi: add support for worker ioctls
Date: Mon, 26 Jun 2023 18:23:06 -0500
Message-Id: <20230626232307.97930-17-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::7) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 30db7ecf-5cd9-4dd8-303b-08db769c5d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCJw7xVE+gMLgCJgZhKPx1e4WPWvmeO4bfjrfLavgPmcabLVIrb1pf9uoHXETq01yosbSnTsg/97fc8EYeY7pboUr7J2rk67tR7JPHpm3D5CB467IDQ85pYSyZV62V/HDq0lbe7ZGnsC/koE7lUnc/jlC3F4Qx6Kbq0a6XcF1sanK0QSvkx7VjFnsmGTkYncnkKF3tASoKaih+uyEU4UrCgWyW1ilzg3vrNQC70MCZ4d0UZ/wiQWnLiR/xomMwwnDqjgWvr137BIRG+1B1EmtxPIqn0qu8C4RBkPK3VmvZF8jno7Ifxu0U9E/dCHwNw2SRC4zKMM9hDVD+hFSa4KS75hgZAucPVvVOHuHaV4Rh777LuN2xQKKMbVFRiPnsEmuzMjX8kGFaGQjhNlOv5WzS9/42RsdZSU66VVE6dmnAadbo8s7Q7YvM1tpkGav4dwlCniaO3nmt/9Be5MIDTCUZt/3N0G2mxEkdmjKWlEH+i60xFEqLAFXehviFR3ooaBJkM+vYSUSU5odbslSH8D9WchCwr3x2ojRT9Y1Rk7eDFy3EFwMPZAwsRS5ELPGs3RNoP5IoSemReL+pug+LzbQ61iEkAZQZ4fBQ7Lr/5iMgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/KkgsV0OVPmorL6bQhy4J0NFwY+43W3FD/UZQ8eIGys0KXZ6dobHrxOLJQP?=
 =?us-ascii?Q?OYaHjaoCs5cUkq8AYCdUIe7aWG74VSfj2cKQEaKeA8NETjKO1MGeuiypovrx?=
 =?us-ascii?Q?vIqsNxM8TEdUczjqn9EViBDIVb4BNZYirqh21xYkaVsWvXiuqH3tx9WtQc0n?=
 =?us-ascii?Q?RxXAFsWIpfqxREEv/S/18TTfcb4yW8hLLq9fW4s3klUQJCjOuvPKN++6oDN+?=
 =?us-ascii?Q?GQWgqyryXk3TVtxA5yv8lnDirKobxtASQmw4i1ji6V2lVh7EGfWrqraYoXj9?=
 =?us-ascii?Q?Dxa4bEFideuZay6Nu7DXkILEt4i6XikQ2mA12OOBpHk1M+6wPlczVZH/sAF+?=
 =?us-ascii?Q?y0Cf/NFjot1vC40zxoPE82QAX0sVFxPSZGyYUDmphZZUP5TsfzGzDpNpAR30?=
 =?us-ascii?Q?28EhiHE0LVZZ3ye07j5hvkmpzThrFd3XySDVQbrfl4hpYhicRjWV660zAnT1?=
 =?us-ascii?Q?gpcS3krW5dhvJ73VQoxe04jRQ5amHgfzisrl+2zm8Xv2Nf4dGPFAwqlmEvJU?=
 =?us-ascii?Q?HWXS8Rj3EtJGQ9S7kfvLLNU+DzZBIvOjRfNXHV/CcHiXhpuqeoHBmVCEWj8L?=
 =?us-ascii?Q?YF/B7LpdGYlSTSVdG0/qiiOWrAlHhoLrhyE5ybLIApi38i0FJOLQid7D25UX?=
 =?us-ascii?Q?UM/RnOeuUc6m0/ao4+PJrGy7KI20PwnZ6hnVXEWP99MJvroGvoxMUNpVHHE5?=
 =?us-ascii?Q?L6abBp0zW1VXxNtpqqYOhdcf+GpQrD/3zvPBYUc6EH6rIqwjMzIZ9LUjEpW8?=
 =?us-ascii?Q?u4fTUPQx3PR1IGLwEaT7Qhg3O1B+AwbMoV912vQ+3WfgGI5Dv7h+F8SWSB29?=
 =?us-ascii?Q?JByEW9SaCWGHUcSdPbtEOvwMJKi9bBo2c/hZx8RTarP4pUfCvk7+n7F7YvF5?=
 =?us-ascii?Q?w59NFcQw8d+83FzZA32qGP9BJb72Hf0BoyUB7O683+qpBkEGXb1H3RmwH5Jx?=
 =?us-ascii?Q?1DXJB9JQRNQYLTOf9XAYUR4sbvJNszP+baW08zJm8Sjdlp0zUwiEP1aU17Y6?=
 =?us-ascii?Q?is3BiD9UD/20TfeBibQY0OS6qPkMIZevvhZSTHadKaDnQo4uODJIUprbegla?=
 =?us-ascii?Q?Zukz1TpXRtRdf45RrZG04EwgNlfbp+OobJgEo/mgCd6ZAN8WreDrqAS4Emko?=
 =?us-ascii?Q?LMLkHowFLjsQdee1AK/KOze9qcIweCopEmFMRzDc+8qulKgaoEKq30QBlnNM?=
 =?us-ascii?Q?b4/FZBin9NwIX3z+exHlxstu0PcCU+40KCprHbc49W9tK/UkEcmaBtjirCko?=
 =?us-ascii?Q?f88RO2v+queWW+2n6fjWHNWbNtPAGnGcQ7/6rA1FbevtdK93Qdhe5zg6z8UC?=
 =?us-ascii?Q?DaF4X8GZU44Fdeaiy1xkiDjgwZLJcSNfiUqxqNph1YiiuRDgdeuLtuOsWWAN?=
 =?us-ascii?Q?e2o8kfG1nQMg7gZquJQvaoNjftxnJ0uK+h1M3p3lHxgX935Cq0f1Ro5xEJSh?=
 =?us-ascii?Q?5Afum89b/9IA70OQcR3x+1avH7+vhqbkg29y3eIASlA/lxPjm/luDE48EVR3?=
 =?us-ascii?Q?ZK6D5AWePWzn4EucUvzQrcjqCVncP5mrBw+owJwNQ6YhZiAt1I5hdrsXOdV2?=
 =?us-ascii?Q?B6tFlZvVE8+Eny1tliC69owVDQde4KCt7W5yInHFpsPgFLm3opn+y3GAz/Xh?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E97Z8TQGwKSTr80PEY1AAcv8CI6UmbNpeUdBLRprhmZf9wQ/V10vD49c0rCxMiIZBi9zu+x1fmOs35Mje5LVrqX5YiPvC/wnFTN99SmLoKnRqBaA6Z7Qk3aJ6L7XY+A0s02h3pjMq55PJCYEcTsP8jb3I+CtgXs2rmf2RUt11EsNex+PkuBO4N8v4+HnM3i868RzHaAvw5Xl0QcF6uaXGkWBOToEQ1YHWLd8XW92nufupkHoxTfqHQwHMlEjEf1c1Yj9eX1cf+21aEwz3fFjOYcRL9pAf/WJP7iXHza0Tv+b6oAaOy3KrUbmADsK2MBPiuV7+E8blRpzaPys7T0Hqp21JtRSziStEA3LSOfGZJo/vtv1HD57irjwbkTzP/Xg+7FzhgNUPwH50tpszHcKNOXmAqx1InPvUjxphUxMqyRzyih3+ykz6Wk6iv63o1Dzhw4K3HPQPticxUAN962RBBy/C7cOCqQZldDOJcKRU4QBD06DD9lvhGYAvxgks5Lpw+wfAzwBMs6pjpcxRiOzeELILLJ4es8Whip+8GwX2HeSTNxUhlXFTJqOHtQQKe8PhDnYnFsmgM2rmU/afjlmowT2Cx22HzOsSmTc0U/HY6GCkas3QfqsSah8+0c5k1Xg6YD22tfm/bDOGF8M0e7vW0dVxEmMMCNkM+iO8li8j5WfIgdjRPpAIxTTUO5hEpe/wOWoxfG9m+oxzFcXVRNRWskFGz3MOhtO7MIJYoiyvDXlYfvLwxKMYvlF+9+nbwBCiTt9h+uXgcX7JmM/vKzc6pAIdEUj2w7dPM67051Ge96YRUAxtydVR+vlc2dvjZSA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db7ecf-5cd9-4dd8-303b-08db769c5d48
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:35.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoHUS9I03EBxpm/hqUvQ4QF5qc6nILkE1GX9btMtDh9WW+f01SLGQRO8v6HBW+vVvTvszCWOOxyYtMu8/oE74yr67EUeSj9SU333vuXtY0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: xwB5KylTBV1UkowC0kIvSXZF29LfE7oy
X-Proofpoint-GUID: xwB5KylTBV1UkowC0kIvSXZF29LfE7oy
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

This has vhost-scsi support the worker ioctls by calling the
vhost_worker_ioctl helper.

With a single worker, the single thread becomes a bottlneck when trying
to use 3 or more virtqueues like:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=128  --numjobs=3

With the patches and doing a worker per vq, we can scale to at least
16 vCPUs/vqs (that's my system limit) with the same command fio command
above with numjobs=16:

fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
--ioengine=libaio --iodepth=64  --numjobs=16

which gives around 2002K IOPs.

Note that for testing I dropped depth to 64 above because the vhost/virt
layer supports only 1024 total commands per device. And the only tuning I
did was set LIO's emulate_pr to 0 to avoid LIO's PR lock in the main IO
path which becomes an issue at around 12 jobs/virtqueues.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 2c3cf487cc71..c83f7f043470 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1927,6 +1927,14 @@ vhost_scsi_ioctl(struct file *f,
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
 		return vhost_scsi_set_features(vs, features);
+	case VHOST_NEW_WORKER:
+	case VHOST_FREE_WORKER:
+	case VHOST_ATTACH_VRING_WORKER:
+	case VHOST_GET_VRING_WORKER:
+		mutex_lock(&vs->dev.mutex);
+		r = vhost_worker_ioctl(&vs->dev, ioctl, argp);
+		mutex_unlock(&vs->dev.mutex);
+		return r;
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
