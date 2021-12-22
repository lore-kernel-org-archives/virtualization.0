Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD6EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 22:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04063402E9;
	Wed, 22 Dec 2021 22:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vESUnUSRAsre; Wed, 22 Dec 2021 22:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80BAE4007B;
	Wed, 22 Dec 2021 22:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B9F6C002F;
	Wed, 22 Dec 2021 22:58:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE6CEC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 22:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD18C60A98
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 22:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="CqUkFCHh";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Obof8P6X"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z3kftuV9X3WE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 22:58:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD7E360A88
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 22:58:28 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMJmnZ7015883; 
 Wed, 22 Dec 2021 22:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aBd2MipcecErB7m6tqeKytgoPE3z929G74grL+cFxtI=;
 b=CqUkFCHhisOk7BNX8bD8k1oNKFe82VKVv5JbsS776RwfSk09IZzjmMIZ0ZO7UGxKTWjn
 gd1xGficrFuv06dko+yIiBn6OJNsYLujLNq7qfBOZsMTZQvPGYUdjPFxHTgkrTfLJYdx
 u7pjeqQFmCe+X4dOiTgP52j2n1N3lR2GT5guNIvN4Cd9wwJsETIe11tZtCS9w4Uabexn
 PSJ8JXSc4rWKkYR7COOvnOCvxAFxE5isl9+eCWHm1j9g5Eu8dy/IWZTogKru6ZlQCmHa
 fgQZDhuKlgLdyirgYS/4ej0+roWktmuXQrNKH6vn9BJOAhDbzRCAZvaDvqPQUBoVfH9a ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d46rm17db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 22:58:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BMMuYdR100598;
 Wed, 22 Dec 2021 22:58:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by userp3020.oracle.com with ESMTP id 3d193qje6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 22:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHrE2iI+5fGP3QQTEK2vkyLyrgmnLsJVbr1QGQjYW3ifgM649YUXIv7lqZcTJ3TV34dwnXSy2RiTqgAE7EzE9KlD8Z6KHZ/pNxYJ3n+tu9JhW6Tlg4i/4qR0yoEwbaqu4SSgTxMDtLgLWDWfYWpklEcPvtElvzxVRdwoku3eOSry0qUNlqjvv3oRFMReRTmG4c9zf2IyUY/xOkwfIAI3Lw9hu7T425CFlzwwR8vq/UlmEj9Ybv2cLnR0NCfTd4Ivqo+f8yV/RjsYTd0mz6XcE3W3oSE9rFgCxfwq62xwKgRzX+p12oZvRMcrkI5hKr/UokqsGKoLc46bbNXypDjwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBd2MipcecErB7m6tqeKytgoPE3z929G74grL+cFxtI=;
 b=Kf7leMJrcF1QtXOWXT2pKtMcmNal6lfZ6utyHsqw6+fyl70DWM6Im8xgHoQbqOZnsFoxAEVc1I82E1PMDK2Kf284rF1G1LfXf9ftAgWJss8eCu42HrFBozz2k4a15bhbD3bgJtlH9ZeIP8IVC1SC3jOHtLcXx3h9i1NMvJHfvPU1SPDYbi4thQLgwo29+rxKp1Les/7SqGUGev5d6IICJIcr34xDWq0PTvUGqu9guBSsVtzLS25WsLuxG3CNwNaufoeMqP2pFCrScwZzkWnOJnQhJRRQxP21ZDiALSkW6nnwZJBlANOjk6JceKj85pV0Tazgb6bKdgvqGtHiTgMSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBd2MipcecErB7m6tqeKytgoPE3z929G74grL+cFxtI=;
 b=Obof8P6XXxmsA05tD5qsCnyxsPGLUQXLzigu7zYWBg5o2LBo7KHstSOOgD20MHFpPyz/K96Eili00F2BDgMjq/iqNtAIamg+4sVXCHrtgmteUxANPIvsyjPEMj8Yj+0Q3n2fyHuKgSRFWCZsouqYbA0osXSls6L9GqfWC2BzRYY=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3125.namprd10.prod.outlook.com (2603:10b6:a03:14c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 22:58:23 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.024; Wed, 22 Dec 2021
 22:58:23 +0000
Message-ID: <29ada96c-7ae6-4cdd-92e1-45b90334983a@oracle.com>
Date: Wed, 22 Dec 2021 14:58:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 03/13] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211222142100.158423-1-elic@nvidia.com>
 <20211222142100.158423-4-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211222142100.158423-4-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3682339b-b92d-4aec-3b23-08d9c59e8e72
X-MS-TrafficTypeDiagnostic: BYAPR10MB3125:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB31254FB2C4A6EA96B0AEA8D7B17D9@BYAPR10MB3125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WoXSmX/GXs79wWMICWOLfoyneGWGA1zUOdLWsbDpTpwUMuKFxFEN5PkJyqJt8po4mniI850KZPDM4qfeybEzT76rdy1FEfObfB6yp98cTFrUcewGHfMR9uYUonFhlrQ0j7sW75Sc2+7IL5T5tj1Qh3nXo7JUvBmfKiLKFAhOdRihnbfM440ucLqsZFCiAyrIZwCDi+PDUCXuaDLJyhxo3IOhRGv8JOHt/sqrEfalIK68nLYyIYH8kqx8SV64ev9cL8yCf/PHZJCqjMtQabDxJuXFPjsLpHmncK6alNVsAZ+9bj4KKEtbvp11sqgOcuvW9TJw9XyM4HYn9it7FcCcN6Fa7fxMX8Y+ydhB0jUoFN6WpTpoDTUCZedlT5/IxtpF50rvbXWudzA03QM3jNj50mMMIhxYzaD/roAl90B9zufnmREgDdBCVHfKMQcpIBCbzpv7Rs7IouGB7BncV1KFfCgWCvAkdw4+USky3WM1ssV18yNgv+rVQA5hBZJ2FxMFVm8LQ5DlScyg7sw4/CoqAQY2eD4X3/EeKZxpJvhpK7OKqSGPsdlwcwkesOaG+DhwcXasityFvPoadeeXOB8WO5Y8gpi4WREj8Bn/ufxBWMWzNuqMzrXfflVwVL9wlM0taVDAFNDurRsZ0/3axgyH6exMf/hNAVsERd8MvV/UJRrV5Xq98LBH+WeoVNhERtScdV+7+17ZNFCJQPSRURNg6rsaPjJjxnQ4js1/7eHMz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(8676002)(83380400001)(36916002)(6506007)(4326008)(8936002)(2616005)(36756003)(53546011)(2906002)(86362001)(6486002)(31696002)(508600001)(26005)(5660300002)(316002)(186003)(38100700002)(66556008)(31686004)(66946007)(66476007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JrUkpXTkdQem9makJ1azlFaUhqQmFzWVorYUpYOWQxd2RlYm80QXBPUlFV?=
 =?utf-8?B?a2Fxdy9QWUJPVVZCSzdwa0pmZlhRUmllUVQzY3BXeHhiYVhrcHNGY3ljYmNz?=
 =?utf-8?B?U0t4S0psbUoySlJrZU1hUE5HUEZodE9mT2pkK1I2ZXZienZ1L3h2N2tDRjVU?=
 =?utf-8?B?eFZkSXJRYmxXQVhWeVhuS2pFMTRaRVZLUzF5UElCcTVWL25tYno0WE5GUUR5?=
 =?utf-8?B?eHMzTWRkVkFNWUpxL3hnajBkR2oxazZuVTZzRW9Leml6Y2dndDB2eG5OWW16?=
 =?utf-8?B?Q0tlR1RXSVFEUnNZd3V5ZnRrSktMUytCOE85aUo0WUUvWEVVME9mWExET1Yw?=
 =?utf-8?B?RUxHeU83QVlialdOUzVsUjNDdDRENHNkRmpjM05jT0YvOHl0cXM5UUtST1Mw?=
 =?utf-8?B?VFMxdm9GdnVzeUkrazBEai9MbXZuUS9nWU1ITEdUTjlJaFU3TWQ5dXNWbFNP?=
 =?utf-8?B?aDFkM2NXTk5GWXFFK3pjR3BGQkZzSHNyUk5TY0hKRE5ucGlucHFEcDcvdit2?=
 =?utf-8?B?U3RBSFZkMVAvUTFUQUFKV29kcjBXa1ZqdUt1aDJiQy9nQTlrL3E5TmZyQndl?=
 =?utf-8?B?Z1p2Z0dvVktGZ2ZIMkpiaGY3ZjUzSUcwL0RxdlF4R1puRUpEZUk5V2hHRVdj?=
 =?utf-8?B?ais1RGR5MCtHQlRZNHlOOXdvUFVCdjMydUM0ZHlidVk2OGRxN2lLRjRFaDRu?=
 =?utf-8?B?NjVlUzNydElHSldUM2ZRR1lUTWpRbHNTS1dMdjBsaDk0MHRpd2QvczJWU0U5?=
 =?utf-8?B?SUo2R2tIK25ycHBzTTFOQUdHYnhmWitVM0hCZDhESDArVDZlWFYyZ3piVE10?=
 =?utf-8?B?N052RkJndWF2cE9UY2FLY0MxODNoL0c0RktqSUlvQWtDTjltaVlua095S0ZX?=
 =?utf-8?B?VUVUWldHZVpENXhjSGQzYUJDRjlmM2lUY0J2ckw2aUJwMDdDVHJwM01CeWRv?=
 =?utf-8?B?Qy9HK3RVN09tZFpNTzdialoyekRUeDlGUFB1WnY5bVp3Q2NCMm1DZ1FIQTFS?=
 =?utf-8?B?TGo5RWw1RHd2dWJ2Snd5THM0Zk5YSFVpMldkbWVNZlJJVjhZY1Y0NUhmamhy?=
 =?utf-8?B?dEdObEk0WFJLVGxvUGJVc3ErcWEvOFBLWGdXdUs3SStPTXV4UE9BaW1UOFdQ?=
 =?utf-8?B?bGdWeHVyRTFZMTg3NUdTYjFvVTU5alUwRmhBSUlGUGJSMTlBQmd3WlNUYUc2?=
 =?utf-8?B?K24yTElkNHJNbDFFTEplTzZTZTUwd3AxNHlET2FDWUl0ajdQYk9NUjF3YVZs?=
 =?utf-8?B?bndnMXNvbGUwNnlrVVdUcUU0U01ablY5ZGRwRHhkSWtSSXcwRk0wMi85MWZJ?=
 =?utf-8?B?UWF6ckFYa0tZS05Ka3FQN1pZMXRqT1NINU12Rmt6cjh0djc5M0hGVkJiU296?=
 =?utf-8?B?cHVXOWFEeDZjMXJWeG1sMnJMMGVkbU03UDNndmVWeFlYUERENFhVTnVLNGNP?=
 =?utf-8?B?eTFhc0NSVCtxRUVIRnkxNGZYZllFNy9IV1NHbmY3emVoR3hHdTk3U3Qxd2hm?=
 =?utf-8?B?LzlxdjZiRittOGtzaWpmOUVqQTNjWnFlQWhOUWRpdTl3SUR2QlR3RG83SlNv?=
 =?utf-8?B?Q1hHVkVkNWtJbjJUelVlSnhORm9DSzFNVXRYZDV4YVlVSExvS1RNTHlLOXhO?=
 =?utf-8?B?M3NHMGY5enM1cllQcTBNL2pCS2Q2Z05BR29SUWNDUjVnMmJpTEVDbElLVyth?=
 =?utf-8?B?Z3hOQmxUSkdkSHk4K2FHY2I3M0VJazlYK2c2dVZRUVdjVytZRjZsK0lhNHJU?=
 =?utf-8?B?Ui9GRXFPMUtSNkpBSjA0Q0JEaStxS25BWnBFTlNCb1N5SklNTFhmSThwQU1w?=
 =?utf-8?B?a1c1ZE9RUWhLa2xVS2NxMGcrK1dPYzFsVDN5U0dqUDdWYzVJS0thVXBuWGZX?=
 =?utf-8?B?VnA4UExQWnJ2aVhjUW5DKzRwVDM3c3lQejUxcWFmcXFkZ0lNL2FGOVM4Y2U3?=
 =?utf-8?B?aWVtUUFRaTBsc1BXYWtyQTlrd2x2TDB4UjhMczhVUzNjRG94YTV0WXlpeUhQ?=
 =?utf-8?B?OTJxMzhZOU5KVlROazJwcnJtNyt6Qld4RW0wTEFmaDdwMFRyNFRjTzVjL01i?=
 =?utf-8?B?YlBHSEUwaUNtRmpZYzhRT3hBU1JHSHgzVUM2NTlqL013cnV5RzYyN2xndUtV?=
 =?utf-8?B?ZjNmclZxT2VTZHZkVlczeGdaTUh4WmpwYTZWc3hzbDhpekdidXVWMTRzSXZj?=
 =?utf-8?Q?SIwG3DKrdO9IE3+PmUyR8ic=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3682339b-b92d-4aec-3b23-08d9c59e8e72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:58:23.7022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wIbmtiFbAjmc3e/8xzOrhWMC3ZAGwI0W1f0s+28FbqVy+uaDgmoQiqxQVL03jovCitORac6jzztNgxHesMM7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3125
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220119
X-Proofpoint-GUID: tf1Bvn1UYm5_mnatzKpcuAo30c50Equv
X-Proofpoint-ORIG-GUID: tf1Bvn1UYm5_mnatzKpcuAo30c50Equv
Cc: lvivier@redhat.com, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/22/2021 6:20 AM, Eli Cohen wrote:
> Add wrappers to get/set status and protect these operations with
> cf_mutex to serialize these operations with respect to get/set config
> operations.

Need to protect vdpa_reset() which is essentially vdpa_set_status(0)

-Siwei
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c          | 19 +++++++++++++++++++
>   drivers/vhost/vdpa.c         |  7 +++----
>   drivers/virtio/virtio_vdpa.c |  3 +--
>   include/linux/vdpa.h         |  3 +++
>   4 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 42d71d60d5dc..5134c83c4a22 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -21,6 +21,25 @@ static LIST_HEAD(mdev_head);
>   static DEFINE_MUTEX(vdpa_dev_mutex);
>   static DEFINE_IDA(vdpa_index_ida);
>   
> +u8 vdpa_get_status(struct vdpa_device *vdev)
> +{
> +	u8 status;
> +
> +	mutex_lock(&vdev->cf_mutex);
> +	status = vdev->config->get_status(vdev);
> +	mutex_unlock(&vdev->cf_mutex);
> +	return status;
> +}
> +EXPORT_SYMBOL(vdpa_get_status);
> +
> +void vdpa_set_status(struct vdpa_device *vdev, u8 status)
> +{
> +	mutex_lock(&vdev->cf_mutex);
> +	vdev->config->set_status(vdev, status);
> +	mutex_unlock(&vdev->cf_mutex);
> +}
> +EXPORT_SYMBOL(vdpa_set_status);
> +
>   static struct genl_family vdpa_nl_family;
>   
>   static int vdpa_dev_probe(struct device *d)
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ebaa373e9b82..d9d499465e2e 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -142,10 +142,9 @@ static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
>   static long vhost_vdpa_get_status(struct vhost_vdpa *v, u8 __user *statusp)
>   {
>   	struct vdpa_device *vdpa = v->vdpa;
> -	const struct vdpa_config_ops *ops = vdpa->config;
>   	u8 status;
>   
> -	status = ops->get_status(vdpa);
> +	status = vdpa_get_status(vdpa);
>   
>   	if (copy_to_user(statusp, &status, sizeof(status)))
>   		return -EFAULT;
> @@ -164,7 +163,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	if (copy_from_user(&status, statusp, sizeof(status)))
>   		return -EFAULT;
>   
> -	status_old = ops->get_status(vdpa);
> +	status_old = vdpa_get_status(vdpa);
>   
>   	/*
>   	 * Userspace shouldn't remove status bits unless reset the
> @@ -182,7 +181,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   		if (ret)
>   			return ret;
>   	} else
> -		ops->set_status(vdpa, status);
> +		vdpa_set_status(vdpa, status);
>   
>   	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>   		for (i = 0; i < nvqs; i++)
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index a84b04ba3195..76504559bc25 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -91,9 +91,8 @@ static u8 virtio_vdpa_get_status(struct virtio_device *vdev)
>   static void virtio_vdpa_set_status(struct virtio_device *vdev, u8 status)
>   {
>   	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> -	const struct vdpa_config_ops *ops = vdpa->config;
>   
> -	return ops->set_status(vdpa, status);
> +	return vdpa_set_status(vdpa, status);
>   }
>   
>   static void virtio_vdpa_reset(struct virtio_device *vdev)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 9cc4291a79b3..ae047fae2603 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -408,6 +408,9 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>   		     void *buf, unsigned int len);
>   void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>   		     const void *buf, unsigned int length);
> +u8 vdpa_get_status(struct vdpa_device *vdev);
> +void vdpa_set_status(struct vdpa_device *vdev, u8 status);
> +
>   /**
>    * struct vdpa_mgmtdev_ops - vdpa device ops
>    * @dev_add: Add a vdpa device using alloc and register

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
