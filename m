Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4998C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 00:27:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EF764E4F
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 00:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EF764E4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B3CA0870AF;
	Wed, 10 Feb 2021 00:27:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zz0ceewcY+jm; Wed, 10 Feb 2021 00:27:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C0A1087041;
	Wed, 10 Feb 2021 00:27:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF9D8C0174;
	Wed, 10 Feb 2021 00:27:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79575C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 00:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 638FF86767
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 00:27:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PvMsKDaJAB5i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 00:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6588A86765
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 00:27:07 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A0NtxX013657;
 Wed, 10 Feb 2021 00:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9/y2xqYZdAVA2eLu4Eady3GhobXAy4M+KrLahjlb+/o=;
 b=DZRHX4Bj+gPxa/YInq6tgwkPy4PgE99d79WQLIUYtFvP/LxOgEd5ozAjFiyAg4UzuL6z
 fljWBc4QoIjg2QWtkgB014R5DW01IAVfnysxKA2vAeQfnnmePtpF3cMeiZ4oZsblA0pw
 pleyQ60LTVAnm9Ww8SUDOKV4s4UARYKBwCOKAY/hjv6sNCgaE8FXvyqxnlrN8ohZZltp
 GMSIYNO3nL3JdcOOD01OF+Nm2Z/4HmjJizZ8jFOUFJ0PlFm1MH7P82KzP9sL7/ehsK63
 LyPvlS/8cQUWpEc3F8k83zABQQDMMGPFDIpUIQ9vBIxOe7SE6+8mp0WlsA4fk3c7bbD0 eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 36hgmahksa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 00:27:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A0PwKv180540;
 Wed, 10 Feb 2021 00:27:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2057.outbound.protection.outlook.com [104.47.36.57])
 by aserp3030.oracle.com with ESMTP id 36j4ppfrgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 00:27:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0YKJrEcBP9zxTApeEzME8i2Pj85HUiarWQSDpkppnFuciTe4uf7RCYZW/S+OwoLoP8IqZWiNV21y5IiW38R8MIWZb034a/B0qh2/2e/yug07JJdsGmKc+Klaf04IwZXhs4lP/h+rHfiAnhiKrHE30k8FtFU2+mDWagrFI0A9XL6Z7JvpMmN9F3tRqUHqoi4sQNr0zkVUUHgIhgKO0GP2xPaDVb3BfyrRDEoWGN2ECp+gxhrs2lTSB6BEZzk81yjX/kv+1l8ARvWWqHFxSv0P4Iz4N+4EuFseSOgLNEtRqdFpP0DMrpS1WHhBYaPWUelg4e6RYrlwWhhu/vF5RKGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/y2xqYZdAVA2eLu4Eady3GhobXAy4M+KrLahjlb+/o=;
 b=cnOp5Ok8cW4SFQM448poVecP6P2HCZT2niTyYgs5AYK2Gar06g7lQwShuAmo0332wOY4rRQXKoPcxTmGqs+r2So00XfVEMu2oUiu3huABLe3pNyX7qncOwilBG4GauK+uWK9zW3BVQSrnuIoxtuYXS0B5L1nKASOXFnCRyDa+JrEWN8J1o62AutTxqTeSVCeZwkCkiRnFFkruelS2vTYZlerLdwpL0NYUuP3mGxkGzVymr1IFYD//I0AKKSPdY9x/Vp1IF0NynlILQQSdXBglpHjr5tgIHoerqVMxbn3tB8QmT6aEOMZSOSzFK5/kh5Jiae60oSyZRGxO4XnDKM9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/y2xqYZdAVA2eLu4Eady3GhobXAy4M+KrLahjlb+/o=;
 b=wrs96b6sr/+PwpAI5GBFGHW8Nf91NlQk6J1oO/4Sg5zKS81JpY5ZRC368WtOzuHzbEwkW3XXDEdssuCnmpJnoupGay0p/JcKRq8AXSYkzdx/xh9lEKaWhPvpxWI0aW+ud6E/k5dffifp6QwTHyLZIn6od/5QW03ISn8aFdIY1wI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3285.namprd10.prod.outlook.com (2603:10b6:a03:159::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Wed, 10 Feb
 2021 00:27:03 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3846.026; Wed, 10 Feb 2021
 00:27:03 +0000
Subject: Re: [PATCH 3/3] mlx5_vdpa: defer clear_virtqueues to until DRIVER_OK
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, elic@nvidia.com
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
 <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
 <2e2bc8d7-5d64-c28c-9aa0-1df32c7dcef3@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <00d3ec60-3635-a5f1-15fc-21e6ce53202b@oracle.com>
Date: Tue, 9 Feb 2021 16:26:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <2e2bc8d7-5d64-c28c-9aa0-1df32c7dcef3@redhat.com>
Content-Language: en-US
X-Originating-IP: [73.189.186.83]
X-ClientProxiedBy: SN7PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:806:121::18) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (73.189.186.83) by
 SN7PR04CA0073.namprd04.prod.outlook.com (2603:10b6:806:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend
 Transport; Wed, 10 Feb 2021 00:27:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b9d6e9-73ac-4ea1-afe8-08d8cd5a9684
X-MS-TrafficTypeDiagnostic: BYAPR10MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR10MB32853F84E97E924FC07130C1B18D9@BYAPR10MB3285.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLiNl76kN9leIVhcGh8EsKGkC+JJBlCpFCNt+/CoXB+qdNXOkUPGKpTJKuGn5GSpYGajgvkWPPF19MFCGPuSfuPU21s/rlF4MU0NqR1Wj8IFxRAxKrSRhODfGubye1QZFCcYQT4sbHtfY7SzRAHvK5od1+hb5YsjDtQNl42BE0w8a1SCdJZgYMcuu3hYPQtAv5jNFxHryjKtuHL0FPE0hciaDMS5nYKXRALOFvmxdqBSf7ZBujE/wwG3OKwIO4LPz3t/tiwAyFT7+oKKJAbLgDGjUNgV6BqK9Nz57xVrCvUa63mQW5+FVZW36hgfL9OjjAOigYyPu4d8MfPxzKD2ySatyURTGFZ1dNEYDJDs+k+amglfuTjvgyJxKgPLvJVpcFrQSpOCHHVdXZ/2eDVxsmesbViNoJbBGcAY+bxMqZPuXNBTlAPRfuS70cGdkzFq/hygIExdKFVIGPWLMOFyyP1TDXIdqkq41iI4RNZbkXVS0CngTVu+30Pd3cU0/GU2gNW9MPeuEHDj8hOf3N2m/V0ouQ/Rl0M4LAbmCBpBrKLmxobpa1l50kunjxx3NVqJXLQCCMSdhmsR4c6lwQLMstw4HJ4PDP+FijhkPQ6QNDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(16526019)(2616005)(66946007)(66556008)(66476007)(478600001)(31686004)(36756003)(6486002)(26005)(186003)(956004)(8676002)(6666004)(5660300002)(4326008)(53546011)(36916002)(2906002)(8936002)(31696002)(83380400001)(16576012)(86362001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjdubG5vRUd6K3lJaFROOGtHVHIwNEVyMTN5aVdEWkR4c3d2bmFEZUNYRm5I?=
 =?utf-8?B?ZkxaZGorVWVROFpzb0tXMzRDNi85WVFpQlp2YVFaZHFJR3E2aGVyRlg0S2p3?=
 =?utf-8?B?cU9WbTEyaVZ3MG9yT0dJVnR0eGQyVnYxeGN4dlJsZWoxaTRDNE9RUE1GR2dQ?=
 =?utf-8?B?elpIc21MZ3lMSklGdHAvbGlwTEpSNEFsMHkxYUZDWGxlVmREb2dUdmxrZVZ5?=
 =?utf-8?B?SGttOURkSUVFVVFkaTFMUGZIeFlqRjcwWE5YU0pkT1NkeFBDS3dlemlsRnNM?=
 =?utf-8?B?aG9WY3JhOHNMTk1LQndrQ3gyeEdzazhHNnJFQlI2OTZ2cG5FKzBiaTJzbVc5?=
 =?utf-8?B?anplRGFnaGVGTGgrSEdacDExRzRtZ3cybmsxQTluMHpZdTRUOGR6YmZnR0Nj?=
 =?utf-8?B?K0MwN01FUXR4WnlSbDFteGNGb3pYWVlzaXM2S3VocEtyTnZseVR3Nzc3dElW?=
 =?utf-8?B?cUpWelZGNGRDWFRlVnloYmdmOFkxVG1adjVXUzdEVUpjRHV0V2xOME9hU0E0?=
 =?utf-8?B?c0wxWUFiR1FlcDFycVJxRlZhZFowcDhMQWZnazlRRlkwNTQzRUQyQUZ5ZUtD?=
 =?utf-8?B?SWp6bENGM2dlZWNoRTF3ZG9yY1pmM1NWOXRJb0pjRDVBS28xSEZnUGZ2ZFJM?=
 =?utf-8?B?UWhVNXg3bEU4empISDU1Rm1xU28rTkpFM3VuK1ZmQ0RXS1BQRlpNaGRmQWdU?=
 =?utf-8?B?Q0w0V1lWQXlLdEFmSWpOSC9JQlFWR2M1dlNQMzFlZ1RPOU9tN1dIYk52T2RN?=
 =?utf-8?B?eUZEb1JSZmwxT1NIanFDT1NNVzRvUXFBbVgvbTlabFhyRnhKdWVCSGFrdnhH?=
 =?utf-8?B?RDN1Ynp5VGpXT2hwNkQ2OWhHZUFCcHpWWVZJU0ROcnNDbXNzV2prQjV6OEhn?=
 =?utf-8?B?aXFBVUExNHVxcm95dnBxQTB2cHpZQ2RsckFiTHpxNXJpd2hjVlllajlSMEQy?=
 =?utf-8?B?a2wyK1Y3WGdSU29HVm05MzVkNGcvbzFLR0t6QjBEVm85V3NOS3hSVzBMSCt6?=
 =?utf-8?B?c1lXd0lTNDYrTThsS0w5aUZhcTNEUEx6UkdJaFRZdktxdkFQMmRUdzRsd3Ba?=
 =?utf-8?B?eGZ6bDA5NWVCNnIxQUFKWk8zZ21WRTFmd2NROWtING5XVUNTd0dZbXB4bEZl?=
 =?utf-8?B?SmdJb2VJYVdJRUp1bzVnOE5NWWMyejFXazREMzJyVFBWTEI4MlAxN3liRFla?=
 =?utf-8?B?NUswUDVhNlU3bE1CZmllSVpGMDVqVml0V25QRlJhK0JuVFJtRTBhdysxNnFG?=
 =?utf-8?B?VFplZVMzcURSNm9EVXJZYUhybzYycjVHSkVISUVWVzJvcUNYdGUrdFlxTVE3?=
 =?utf-8?B?TU1lejNnWjgzZ05qOFVENHEzeUYwb0FxcDlGK3Y2MEkxeDhyZk5qRnZKbW9N?=
 =?utf-8?B?NERQTXhvb3Q4cHdPdHJBYU00RTVCeVhJMklmZ0w2YVplTUVGRWI5VWdWdnE2?=
 =?utf-8?B?SFh0c1VGa2tJdDhxeGR1QU9OMlV1VjJnM1pGcDcyMHVXY2c3bTd0cFFWZlJP?=
 =?utf-8?B?U3J6WkhoL1ZYdnphMU96dEtFMVkzMGJUbWxpbGdxNWxKMmtSVWdmNUxVK1F2?=
 =?utf-8?B?VkdYaVltVDJlcUlHRTlKOHFPejFKbWJmcHVxYmxHb3BaVGlxZmh6TUNMVTZM?=
 =?utf-8?B?L3A0azhMY3FRaUJXSkNyQm53dVVQV213TmlMZFEzd281ZXRFczRDKzhBTFpt?=
 =?utf-8?B?UkZraUZ1Z1lLSzRhTXlEQlJBZGxpRnpoU1VzOGNXSTVHNDR1UnBJZjFkTStj?=
 =?utf-8?Q?xNBen8YqstB1ecmrL+pM4qFndqxs6A6qCCHChoZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b9d6e9-73ac-4ea1-afe8-08d8cd5a9684
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 00:27:03.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +un4OSHraDT9dE8Gd4z90qW9xWcbbgEVyO17ALVQIxIVVh5xxwkElAtTyp8K4oyCYkN32UT2KMQZ/eJU/Oh4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3285
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100002
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

CgpPbiAyLzgvMjAyMSA3OjM3IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAyMS8yLzYg
5LiL5Y2IODoyOSwgU2ktV2VpIExpdSB3cm90ZToKPj4gV2hpbGUgdmlydHEgaXMgc3RvcHBlZCzC
oCBnZXRfdnFfc3RhdGUoKSBpcyBzdXBwb3NlZCB0bwo+PiBiZcKgIGNhbGxlZCB0b8KgIGdldMKg
IHN5bmMnZWTCoCB3aXRowqAgdGhlIGxhdGVzdCBpbnRlcm5hbAo+PiBhdmFpbF9pbmRleCBmcm9t
IGRldmljZS4gVGhlIHNhdmVkIGF2YWlsX2luZGV4IGlzIHVzZWQKPj4gdG8gcmVzdGF0ZcKgIHRo
ZSB2aXJ0ccKgIG9uY2UgZGV2aWNlIGlzIHN0YXJ0ZWQuwqAgQ29tbWl0Cj4+IGIzNWNjZWJlM2Vm
NyBpbnRyb2R1Y2VkIHRoZSBjbGVhcl92aXJ0cXVldWVzKCkgcm91dGluZQo+PiB0b8KgIHJlc2V0
wqAgdGhlIHNhdmVkwqAgYXZhaWxfaW5kZXgswqAgaG93ZXZlciwgdGhlIGluZGV4Cj4+IGdldHMg
Y2xlYXJlZCBhIGJpdCBlYXJsaWVyIGJlZm9yZSBnZXRfdnFfc3RhdGUoKSB0cmllcwo+PiB0byBy
ZWFkIGl0LiBUaGlzIHdvdWxkIGNhdXNlIGNvbnNpc3RlbmN5IHByb2JsZW1zIHdoZW4KPj4gdmly
dHEgaXMgcmVzdGFydGVkLCBlLmcuIHRocm91Z2ggYSBzZXJpZXMgb2YgbGluayBkb3duCj4+IGFu
ZCBsaW5rIHVwIGV2ZW50cy4gV2XCoCBjb3VsZMKgIGRlZmVywqAgdGhlwqAgY2xlYXJpbmcgb2YK
Pj4gYXZhaWxfaW5kZXjCoCB0b8KgIHVudGlswqAgdGhlwqAgZGV2aWNlwqAgaXMgdG8gYmUgc3Rh
cnRlZCwKPj4gaS5lLiB1bnRpbMKgIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0vCoCBpcyBzZXQg
YWdhaW4gaW4KPj4gc2V0X3N0YXR1cygpLgo+Pgo+PiBGaXhlczogYjM1Y2NlYmUzZWY3ICgidmRw
YS9tbHg1OiBSZXN0b3JlIHRoZSBoYXJkd2FyZSB1c2VkIGluZGV4IAo+PiBhZnRlciBjaGFuZ2Ug
bWFwIikKPj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29t
Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMiArLQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAKPj4gYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gaW5kZXggYWE2ZjhjZC4uNDQ0YWI1OCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PiBAQCAtMTc4NSw3ICsxNzg1LDYg
QEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IAo+PiB2ZHBhX2Rldmlj
ZSAqdmRldiwgdTggc3RhdHVzKQo+PiDCoMKgwqDCoMKgIGlmICghc3RhdHVzKSB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBtbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1pbmcgZGV2aWNlIHJl
c2V0XG4iKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRlYXJkb3duX2RyaXZlcihuZGV2KTsKPj4g
LcKgwqDCoMKgwqDCoMKgIGNsZWFyX3ZpcnRxdWV1ZXMobmRldik7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBtbHg1X3ZkcGFfZGVzdHJveV9tcigmbmRldi0+bXZkZXYpOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgbmRldi0+bXZkZXYuc3RhdHVzID0gMDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgICsrbXZk
ZXYtPmdlbmVyYXRpb247Cj4+IEBAIC0xNzk0LDYgKzE3OTMsNyBAQCBzdGF0aWMgdm9pZCBtbHg1
X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMp
Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKChzdGF0dXMgXiBuZGV2LT5tdmRldi5zdGF0dXMpICYgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSykgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHN0YXR1
cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY2xlYXJfdmlydHF1ZXVlcyhuZGV2KTsKPgo+Cj4gUmV0aGluayBhYm91dCB0aGlzLiBBcyBt
ZW50aW9uZWQgaW4gYW5vdGhlciB0aHJlYWQsIHRoaXMgaW4gZmFjdCAKPiBicmVha3Mgc2V0X3Zx
X3N0YXRlKCkuwqAgKFNlZSB2aG9zdF92aXJ0cXVldWVfc3RhcnQoKSAtPiAKPiB2aG9zdF92ZHBh
X3NldF92cmluZ19iYXNlKCkgaW4gcWVtdSBjb2RlcykuCkkgYXNzdW1lIHRoYXQgdGhlIGNsZWFy
aW5nIGZvciB2aG9zdC12ZHBhIHdvdWxkIGJlIGRvbmUgdmlhIChxZW11IGNvZGUpLAoKdmhvc3Rf
ZGV2X3N0YXJ0KCktPnZob3N0X3ZkcGFfZGV2X3N0YXJ0KCktPnZob3N0X3ZkcGFfY2FsbChzdGF0
dXMgfCAKVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykKCndoaWNoIGlzIF9hZnRlcl8gdmhvc3Rf
dmlydHF1ZXVlX3N0YXJ0KCkgZ2V0cyBjYWxsZWQgdG8gcmVzdG9yZSB0aGUgCmF2YWlsX2lkeCB0
byBoL3cgaW4gdmhvc3RfZGV2X3N0YXJ0KCkuIFdoYXQgYW0gSSBtaXNzaW5nIGhlcmU/CgotU2l3
ZWkKCgo+Cj4gVGhlIGlzc3VlIGlzIHRoYXQgdGhlIGF2YWlsIGlkeCBpcyBmb3Jnb3QsIHdlIG5l
ZWQga2VlcCBpdC4KPgo+IFRoYW5rcwo+Cj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXJyID0gc2V0dXBfZHJpdmVyKG5kZXYpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoZXJyKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWx4NV92ZHBh
X3dhcm4obXZkZXYsICJmYWlsZWQgdG8gc2V0dXAgZHJpdmVyXG4iKTsKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
