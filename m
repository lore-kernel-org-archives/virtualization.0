Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FDBC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 17:09:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4261564E41
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 17:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4261564E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0158782E42;
	Mon, 22 Feb 2021 17:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EifB8FW3lrgT; Mon, 22 Feb 2021 17:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4E9B82E29;
	Mon, 22 Feb 2021 17:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4717C000B;
	Mon, 22 Feb 2021 17:09:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98374C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 790036F535
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqdaK2yQPC3N
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 225076F510
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 17:09:36 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MH6Tr9037353;
 Mon, 22 Feb 2021 17:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LNKajXk+Bwu5GRLJQEa4Ic2UNlP1kbr1RVLdGBai5UQ=;
 b=SnHGVkDpSFGhZreeAz27jJ5DRiXcC2k9azHgiigFJxR5NGQlR3kTaw4OcCzRc64wU/Rk
 Vw6ZY/w2NWCkQDR1b6vSaa27cIzt5W1i+N8o5X2xcQuILr3JQS3vYdzwPA6n3m+bDHlh
 e6Pw+QvNl9vou5qVtzTOsiK1yGSCBf2ojKTn9V+YlNPHaKokhU0iYz2haxJnTAR9W/Ya
 EbBhiFvnEXf2iRBZ9lD7figrEpGWaDsZX+9fstPQ5Al4xSbL1pNJn8fIvHyVjRQ/33NL
 kpnXLbkmNw3kd1bNF4+7ZFnXNDxH/Du+Smjaoo6hqyySFDQagazot8u74ic3IBG58914 CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 36tsuqvdr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Feb 2021 17:09:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MH6IFj147914;
 Mon, 22 Feb 2021 17:09:35 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
 by aserp3030.oracle.com with ESMTP id 36v9m3h8kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Feb 2021 17:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE/zrKjuEwutyu9WgFLI4BIguu+AhOyom9FDZcSAS7QgUkoOltiyI0+pbVzN2tvRqANEjLsN+pip2hxGpRIqUZj3ehpK/AcOp7hnbvSQk2y6VAbKg4lQdXezmEXSMjhLFEETpp6b+EPcR+RjPVG03U41afaFPgXTMiOlTrMgdPpQG43O3dWCtJkaz3Gr1QnNNJpjc6Pz8S8ISwhjIhrCACIZNcK9neZ/ORx7Q01TbFvQQ5a5JpBsLtFjOkUGOY8IrLYVvY04wC1pjDRN00xEGekJsMQcv960ia8NOc+iaHpIbcf2TIdHAgb1FdtRiFef5MrcmV9VDWZyFN0h2vyKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNKajXk+Bwu5GRLJQEa4Ic2UNlP1kbr1RVLdGBai5UQ=;
 b=AqfDhW+F9bos2LG1bUDxBr8Muk9Zi2Vf6vbD+BvOKb95UMS4WBfp0I6lNGnO5SrN3VY77ZW+1ex+OHaws99VprBcpY+iQBG0mKl+bnLVcA6cA6yBEc2oz/1B4rC/eu35W104/oP5D6AzyY1nEYXOeV3bvB1YTeX2IHvDeGf+b/+dT0fU5EEVPP09VkYzOXwPc+HLlG9V3YggUfMqHr9D7qbuxirrz27x4fPWlDMHrvekHBotuojpIuTTAEvpd2zEyrx0usE8bZZzWmxocrli8KGpEwpKb+NI5fJHXxcIEd2u7SLCNNmOyVoY0nsp2bmU6W1WhGLQCIBSu6XcMuqx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNKajXk+Bwu5GRLJQEa4Ic2UNlP1kbr1RVLdGBai5UQ=;
 b=tA+YnlDnAtLq+cVLXHeYcm8h8zd0mKOXQO73T5l0xiIdfw9RSDfSbCvRut3hQ323P+jAGZI46LyBiiJxflYusUq7dX4NbWI7KiiWoypt3Vl7rqEx4RhP94hsTyj7somUfE8oM7MWv4SFfzr5ZFsX6iDl3hveAMpQuKlS8AyOpTs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4340.namprd10.prod.outlook.com (2603:10b6:a03:210::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 17:09:32 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3868.031; Mon, 22 Feb 2021
 17:09:31 +0000
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, elic@nvidia.com
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
Date: Mon, 22 Feb 2021 09:09:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
Content-Language: en-US
X-Originating-IP: [24.6.170.153]
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.6.170.153) by
 BYAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:c0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.9 via Frontend Transport; Mon, 22 Feb 2021 17:09:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28870827-3275-4275-0cad-08d8d7549ee3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4340:
X-Microsoft-Antispam-PRVS: <BY5PR10MB434059F0096FC22E98B40089B1819@BY5PR10MB4340.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cS9RGvqys2H0TwYxOLW9GXihvZmN1dJvznlVDWz/ySzBREpPQcmd7Rp42xn8jUhiYewjxcuF+/Lw0vugtJOAa0RlzHICpNcEF3sN9FvVy8sTsbudi6mK5MmQtAQEmreRZfksG5o9B5ykoXGVA/XK+6kUsXJ5V0zvldICK1y8iJ8EuF3WJnIzh7354jb2S3sISO1ocIynZmzpWP9FmD9d6bMgcmM6QJp24WtX7WpwOXceYgr/MabcR+TN0vFwbGNPgTwvQKJzJeAaEfUPSr8RelFsk5q6KwJAVPA0ZeFQaJ7KAGvyGslBPPI/OsBDZ08USQ5CroxCQ16HRl7ANf1X5MwSvhjJPFYUk9RnzEW9DIs9rSop8IOSigs41nvBmNNwDcDNrYeHxF5rWBm1ZyDj5nQHaC/yB4IF8RIVFGnE2k0rAJgyUFtH7zfSjr6mDlInYFWw5gu2No9h3eYzV9boa4QxEgtMSoJ6c/C78QXRUG2caSM2L/NzMyOidqHDq55TExn0VhfgGtxGeTeDtMDCQpvaQwpsr7lbcTSshgwZ0NZ2Dq/mDir0DIdVk9Ev0U6+bPzbghIKFICIrcPMosZ/mVKmGmD5x4e2q5daq8uNdFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(366004)(346002)(396003)(376002)(478600001)(6666004)(2616005)(66946007)(36916002)(956004)(66476007)(16526019)(31696002)(26005)(5660300002)(66556008)(2906002)(316002)(186003)(53546011)(31686004)(8676002)(86362001)(4326008)(6486002)(16576012)(36756003)(83380400001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXd5YjRTUWd5WWh2TUg5MW9YMmR3blZ4S3ZJRjlIRVN0RlpGNldIZGdwblZX?=
 =?utf-8?B?TUcwQUFSeTdsSmk4QmVVdVFXU1hBMFpYTk0zK2hKOVlBdHlJRm5hWndjK3kw?=
 =?utf-8?B?bjFacmhnQ3VRQjlidHB3cnprWTVBTmhTTEkvbXlJOVMxYjc0UHRJNnU3VVhm?=
 =?utf-8?B?VUZhbFpkdXlHck9uaGFGL3VXaE4yTklzeXk1aFkvMElBcFFlazA5YWhqYm9W?=
 =?utf-8?B?SlFPd2lvZVRSeThGeFh0SjZPNmhkRkxENzgxVHF6SlRBdnR6Zm9FV3FaK0xV?=
 =?utf-8?B?bHdlckxKcWU3MFRVOC9TbE5TUUtsUXRJVzdJRC8ra214dXFlVUE2czBCRDRJ?=
 =?utf-8?B?UDVpb2haNHFZd01VMEowNW1BUEREZG9WWWx4eHhjRkNrY2FOdllEUFhvbTQw?=
 =?utf-8?B?bG4rTW9VZTBCNjUzeDRpT3QzUFFaa3lQZzYySGJxRlpPeG1uUldNVFcwVnRZ?=
 =?utf-8?B?MWZjaW9lcDMyL2VPemRPZCsranVVNld1Q3JHVEthYXFhQVZPS1NwREd4bkpE?=
 =?utf-8?B?eDNoQk9QQldGT2dIMTlXUjhHaFo1MnpiNTdSUHBZSm85eFdLUEkvOEFMTzdN?=
 =?utf-8?B?NmZGQ3F5cXRTRDJhWXJ4TTRzREVEelFjc2haM2J4ODJZSnZyeFc4MTkrUW9m?=
 =?utf-8?B?T08xYkRUVGZsNjZOM1ZheloxN2xpb1NvT1NNclhmWEdVaHpoSy9YWXZvOW5C?=
 =?utf-8?B?ZUNJUUovQzYxOUFFQmdCM0VCOEJyNklKWXpJTG1sWUpzalpIc0hoMmppQ2Rw?=
 =?utf-8?B?RXpvNWMvMC9ENmVTRHZmVjQ1Q3RhZVN5MGptaFNHK0xSb29jYVk0cFdYNGpE?=
 =?utf-8?B?d2dTeTdDT0k3NFJWNGc0VWVLTmhYalRaU2xLN2NNZ3pCTjZ0aE1oellBZVpM?=
 =?utf-8?B?YVEyTkdCRUR6d2Z6aWtKQUY5elhxTWE5Mm1DdDRRMnhBYnJPZlBlUmxlRWZG?=
 =?utf-8?B?RTExVjBhYmpZcDJhbXZLVlIycno1SHpORU9mOWtRV0dhcGNyU1NsZmUrZ1dH?=
 =?utf-8?B?ZHBPRzdoeFBPbDhCS2VjZW0xVVJhRE56MUVWTytWRDlyeHVya1RNa1k4VERZ?=
 =?utf-8?B?eDFocVI5emo1eXdqeTdCb2wzN3RpVUl3NDh5OVRUeElxSjYycktCMFhVNXFu?=
 =?utf-8?B?NUtuWFF5T0pXR3kxM3k2bHFiN3haUUI1bnFaeFFlS1doYUdibElzWGZ4aGRu?=
 =?utf-8?B?YTl5NGxyY21CT2QyeThhaGhJelEwZzFnVVA5M05FMEJDV1dFTFpaOTQ1dzZG?=
 =?utf-8?B?YkpvQ3gwbXpXTmRET1dmTUJvMFRTa1JJSkk3RFE2QTZSUGFlc0RVTlVsckpS?=
 =?utf-8?B?ejRmSFpCVUJ6QTVtZXdJS2VJTENtRGRBcTBLQWVHUnFYSHlXYWdDc0pPL2xP?=
 =?utf-8?B?Z2FFQ3BnRHp0S3JIMG1TQlB3V20xRTlrZU03YWFaUGZWNklVbGJ3eUpueDBn?=
 =?utf-8?B?WkswTVdjcG1DNHRieGVDeEw2RU5xeW5RZGxhTFc4TmdOaW5Uc3ZOYWljNG9U?=
 =?utf-8?B?NVdZNjVFV0dGZkZibWtXSDR5dGIxQ3FkTWM5aGNCZDc5cFJYUCsxOWJqVm1h?=
 =?utf-8?B?SDJBQmtGZlJyWUtGWUZTVUtkQmw2V1gvSS96czVzTkt4TFh5cEVRRTdEeHZ6?=
 =?utf-8?B?b2hPS3NhanozekFsbFJUZk5xbmtNakI1TXlQdGVQdjM1VHpPQ3lrSWo4aFNn?=
 =?utf-8?B?OEV6NjlKS3NqREU2UlZDUmpjM2czdUZPQWoyb1IrMnJ2SnBaUHp1TVRIdmZ0?=
 =?utf-8?Q?y4hxSTASlQ2NI7EaL4PTADs45p78Ee38JnUBphP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28870827-3275-4275-0cad-08d8d7549ee3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:09:31.7518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av4wrRhsozycllxjx6J8HIkhRV42UECUTLApbHN2gIp6NGhjgXCkjX5zuiQulFa7rYm1Iq12HFC2gQXtcmU6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4340
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220153
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyLzIxLzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjEvMi8x
OSA3OjU0IOS4i+WNiCwgU2ktV2VpIExpdSB3cm90ZToKPj4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAo
InZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+PiBmb3IgbGVnYWN5Iikg
bWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8gcmVzZXQKPj4gZmVhdHVyZXMg
dG8gMCwgd2hlbiBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4+IGFy
ZSBzZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sK
Pj4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4KPj4gSXQn
cyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNvdWxkIGFjY2Vzcwo+
PiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hl
bgo+PiBmZWF0dXJlIFZJUlRJT19ORVRfRl9NVFUgaXMgYWR2ZXJ0aXNlZCBzb21lIG1vZGVybiBk
cml2ZXIKPj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFuZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQg
aW4gdGhlIGNvbmZpZwo+PiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4K
Pgo+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+Cj4gIgo+Cj4gVGhlIGZvbGxv
d2luZyBkcml2ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYgCj4gVklSVElP
X05FVF9GX01UVSBpcyBzZXQuIFRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBm
b3IgdGhlIAo+IGRyaXZlciB0byB1c2UuCj4gIgo+Cj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29y
a2Fyb3VuZCB0aGlzPwoKSXNuJ3QgdGhlIGNvbW1pdCA0NTI2MzlhNjRhZDggaXRzZWxmIGlzIGEg
d29ya2Fyb3VuZCBmb3IgbGVnYWN5IGd1ZXN0PwoKSSB0aGluayB0aGUgcG9pbnQgaXMsIHNpbmNl
IHRoZXJlJ3MgbGVnYWN5IGd1ZXN0IHdlJ2QgaGF2ZSB0byBzdXBwb3J0LCAKdGhpcyBob3N0IHNp
ZGUgd29ya2Fyb3VuZCBpcyB1bmF2b2lkYWJsZS4gQWx0aG91Z2ggSSBhZ3JlZSB0aGUgdmlvbGF0
aW5nIApkcml2ZXIgc2hvdWxkIGJlIGZpeGVkICh5ZXMsIGl0J3MgaW4gdG9kYXkncyB1cHN0cmVh
bSBrZXJuZWwgd2hpY2ggCmV4aXN0cyBmb3IgYSB3aGlsZSBub3cpLgoKLVNpd2VpCgo+Cj4gVGhh
bmtzCj4KPgo+PiBSZWplY3RpbmcgcmVzZXQgdG8gMAo+PiBwcmVtYXR1cmVseSBjYXVzZXMgY29y
cmVjdCBNVFUgYW5kIGxpbmsgc3RhdHVzIHVuYWJsZSB0byBsb2FkCj4+IGZvciB0aGUgdmVyeSBm
aXJzdCBjb25maWcgc3BhY2UgYWNjZXNzLCByZW5kZXJpbmcgaXNzdWVzIGxpa2UKPj4gZ3Vlc3Qg
c2hvd2luZyBpbmFjY3VyYXRlIE1UVSB2YWx1ZSwgb3IgZmFpbHVyZSB0byByZWplY3QKPj4gb3V0
LW9mLXJhbmdlIE1UVS4KPj4KPj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRk
IFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSAKPj4gZGV2aWNlcyIpCj4+IFNpZ25lZC1v
ZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4gLS0tCj4+IMKgIGRy
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDE1ICstLS0tLS0tLS0tLS0tLQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIAo+PiBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+IEBAIC0xNDkwLDE0ICsxNDkwLDYg
QEAgc3RhdGljIHU2NCBtbHg1X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCAKPj4gdmRwYV9kZXZp
Y2UgKnZkZXYpCj4+IMKgwqDCoMKgwqAgcmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7Cj4+IMKg
IH0KPj4gwqAgLXN0YXRpYyBpbnQgdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsIHU2NCAKPj4gZmVhdHVyZXMpCj4+IC17Cj4+IC3CoMKgwqAgaWYgKCEoZmVh
dHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+PiAtwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+PiAtCj4+IC3CoMKgwqAgcmV0dXJuIDA7Cj4+IC19
Cj4+IC0KPj4gwqAgc3RhdGljIGludCBzZXR1cF92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgaW50IGVycjsKPj4gQEAgLTE1NTgsMTgg
KzE1NTAsMTMgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCAKPj4g
dmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+PiDCoMKgwqDCoMKg
IHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+
PiAtwqDCoMKgIGludCBlcnI7Cj4+IMKgIMKgwqDCoMKgwqAgcHJpbnRfZmVhdHVyZXMobXZkZXYs
IGZlYXR1cmVzLCB0cnVlKTsKPj4gwqAgLcKgwqDCoCBlcnIgPSB2ZXJpZnlfbWluX2ZlYXR1cmVz
KG12ZGV2LCBmZWF0dXJlcyk7Cj4+IC3CoMKgwqAgaWYgKGVycikKPj4gLcKgwqDCoMKgwqDCoMKg
IHJldHVybiBlcnI7Cj4+IC0KPj4gwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVy
ZXMgPSBmZWF0dXJlcyAmIG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPj4gwqDCoMKgwqDCoCBu
ZGV2LT5jb25maWcubXR1ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4+
IMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRl
diwgCj4+IFZJUlRJT19ORVRfU19MSU5LX1VQKTsKPj4gLcKgwqDCoCByZXR1cm4gZXJyOwo+PiAr
wqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IMKgIMKgIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9z
ZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgCj4+IHN0cnVjdCB2ZHBhX2Nh
bGxiYWNrICpjYikKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
