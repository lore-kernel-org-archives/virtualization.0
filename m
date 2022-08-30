Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF85ECAAA1
	for <virtualization@archiver.kernel.org>; Tue, 30 Aug 2022 21:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB0BE81C2F;
	Tue, 30 Aug 2022 21:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB0BE81C2F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=QmMmwB5F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=QI7G7CB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I2UblHFURgiV; Tue, 30 Aug 2022 21:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C75D82605;
	Tue, 30 Aug 2022 21:05:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C75D82605
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 192B8C0033;
	Tue, 30 Aug 2022 21:05:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 236FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 21:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF02982605
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 21:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF02982605
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wM3r5GdA2hN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 21:05:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC8E381C2F
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC8E381C2F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Aug 2022 21:05:02 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UHtkqx000517;
 Tue, 30 Aug 2022 21:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IYmy3Eihoglp5icbjst8DHb1CrbDy2kTMwAdTPrfqm4=;
 b=QmMmwB5F25HIBLT0T2X5Rod/8yVmZYxNYKhh6sq9owFPlp4vVRReVctKRKCJf2QY0iFU
 ctPVjDCfr6U0zdkFu36Kb1wVHhMFDkbEk/Hpb55unIwf8keqOw6kHNX8lS8zVn3BpGwM
 DnNs8x1YmuYCOTeeioB/+p73jOmsCNkxEh+UaWs82DaPSSgcmwpt8GWM+N+hC1d8g2dn
 6Fi+VQGHrwEXNlyWt3sHfNJnpuHsbFKvPw8fzMIXnFR5sITNiNcc3Cd5mbXQf54mRuul
 EyNxL1DpHm9SmjQWqTX/P1JwSHPfv93yp2rIoEVBvun77Dke97gmcpE4vfD0n7HglpO4 Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt7jrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Aug 2022 21:05:01 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27UIXXrv007785; Tue, 30 Aug 2022 21:05:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j79qanqn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Aug 2022 21:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6hlBN/XR4S6ItU/q4l5r3nvHR5pFz0kZDJEHn7PZAPYPatwNf2gkKiEdoad0c0HrxatMNTG0FPa9ni41uYt7BMSk7ZTRakgtiZX8QWtYBSLQvagyl+Bzey528aQyXsQ/37cfM21SM2KNLhuQDXzkvDqP+vIMbl2kLhblKmzp7QFNGe8k2HbwkqbhXQtTNVoT/zMMEVLquCoWyVWQslvtSS0fO9ojXsdV2p+kzqVbCCjPjNMeFFO/Im5ZErkzPt/IZLREzIHHpajWNAoa7awOXqKcLwXki7UGh8ZArp+U/OqVqbjD49eh33cJAQ2ttYMLWsLStRFnqUhm5Nyvl8/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYmy3Eihoglp5icbjst8DHb1CrbDy2kTMwAdTPrfqm4=;
 b=LygtZHTNEJbB+UWK2jedBJrnzX0yHaSZnhjxycXa2BePOxwmFttJpuEoUQvKZ1F9/slNfrEhobha2o0F72hDyUzub+DRrkFyrtKyoMA4SYHZdQWkw1qcrCA5yjlVRLpThofSAD4uOH46e3hLz8MYA1Ul/ctRdLcbqcQj9lLvQH3M3DeZ73j/Chtc9/4RSgeFlVw2zsiXJBNsjff0bIG15fQRZA6T2CTe3F9IUHUuIlNaHXqWEDcfQkLgOQ8p+OMrZtAA/q5QanAd2yzeNEbS10SnbYR/7R3MsxgBAKgUmLrXeqYXL9dyu1T7U6CxEQTgVmUqSjfSjWhEqs6kaw5mCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYmy3Eihoglp5icbjst8DHb1CrbDy2kTMwAdTPrfqm4=;
 b=QI7G7CB2pDq5R4U3AQudJOxACwrp0H4PIvX+4wYd/4F+KFCb38SbuNszxiZYFiPWrA9nspfiDGKfHZMCpso5UEUW1YcXZ4GmsHeNCtEdGvxHkGWMIsuT0F4fxDM7jISVbI/2X5nvigyGrm3u0Sb6orT+Cox45jMSgy5NDf86MEY=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 21:04:57 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 21:04:57 +0000
Message-ID: <7460d7c7-5b44-661f-7763-3e7a6a15f138@oracle.com>
Date: Tue, 30 Aug 2022 14:04:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: RFC: control virtqueue size by the vdpa tool
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <DM8PR12MB5400FEB0322A9FD6B3271D45AB799@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220830154938-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220830154938-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006aaea9-8537-43b9-eb70-08da8acb4b76
X-MS-TrafficTypeDiagnostic: BLAPR10MB5139:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47ZhHHDHjVblh5uADUDmP1CvwRudMcqBN7zHwTszA+HufhrpH12Ax1hqBjlNS0jFc/RG7+8FRa6II8DzElLpZctOVibcvZy9JZeTGNygwz6ZInXtyMg98vCEWqxm0CVK4RdCO6IGbjN26mpxyzYEBniA3eOI+2vox0dKiG0tNGwnqyAan2uq2jn2y0Tu4L87MADfwna2sueg4Po8WLWqYAHTO3EQ4Ax5wLWdIAcwJY1EJ6lvIAbcHJmHDbXxcj5Lw8AQcQeSFKMsvJq1VBCpp2i3i4NncUs93OZBRMrACZyDrPIsfKg7QLzltcZG3nGw3cSDOcVvugiIKC/hZPsbkXnAOU1omRFdmPevXnCC+1/aypXJdIu7QUupb95U6pzjpD01477kib9yFAgnBJ4BdNcYbii6eLFApVJsrKFrNyr9NsFmZm+NHkWx2RmYfq232gW7jZDllDly3uAd8AOHiydDvrZyJDkDjvqwGjPBfSs69AV/2AaudwszILeRsqqZ9jiEaTr++aQnEpYesQ/tP4z1n+aalgPgUNMi1Xynr5KZHXLjawe6NsxsZjsCdwo1uNy0K2Rr4NW+pP0T+XvmAHbku/GwklkNvPfpRYqP9LWF6CA6QAdNVn8IY5uaBi5F0ZaqICo8UeCBySira8/wJG5LbQC+LqrIl+9kfEGjzRh9mbem9Qo2twCYcCSZns6/vzUZgsG6I/vVG3PHEXBaS4bCVH+WGYT2tlVYPBw1RetE3b7veRoFudcqjwH9871XxHXSIFtM8o5hnCVPJG3MCuk+Qxh9tTmUcv3Yn7H10wM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(136003)(366004)(39860400002)(376002)(346002)(86362001)(31696002)(36756003)(53546011)(36916002)(31686004)(38100700002)(6512007)(41300700001)(6506007)(26005)(2616005)(186003)(54906003)(110136005)(66476007)(66946007)(66556008)(4326008)(83380400001)(8676002)(6486002)(316002)(478600001)(2906002)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNnWm9ZTFBxVlFuNFRIZVphT0dLRWF0QnRuTXo2L1VyQ2I4SW1ESlNPY2x4?=
 =?utf-8?B?dU90UXlVYmJwZ3pzT0dRUGg0RDNUNW10L1ZEMUM5NWJKK3JFL0MrM1VjRXBh?=
 =?utf-8?B?bEdQc0l5eHEwMXJBUWIvRytqVFN4MVh0SCtXOXhiOVVkRHJJN1NTY2dqRFRF?=
 =?utf-8?B?d0VTSWRETnYvYkkwNklXcGM3RlFnc1NOeC83RW5QaHUrblF1V2FwODM0bVdX?=
 =?utf-8?B?K3VoWEhCTzZDU2ZERWJ5NEVmbkczU0dtalJKZitaQU9GSW9Ia2M5TEpjTTZa?=
 =?utf-8?B?cU9VOEFOWStRcDROV2JxTEJGcU9iakl4QXUyVFdhWU42ME56YlVMaUxGaU15?=
 =?utf-8?B?QTY2L0lWZWRHd0pTTEE3TDR5SElVOFFzSG1LSWpGV2QzaFprL21zd0s3cUEy?=
 =?utf-8?B?QmtISTdnY2F1aTExOVNVMkxVL3JZcGNjWURwT3h3WGNVZ2MyMm1SZGhLYTVV?=
 =?utf-8?B?bGJvaUI3cGtzcnhmSXNlanB4UHE5SnQxS3lOZVQ2d21RNGlIUHFNQ2NxQXdt?=
 =?utf-8?B?SmVHcllzdVR6a29rVjlNVXpvTmVFQTJiTE0vUjJlcGxSekVLUFloWGUybXVQ?=
 =?utf-8?B?U1JjS0hyNmFzeXlCRDVEU2dSY1NIYU1VeXFYSUNtakd4ZXZRMXpTemJ5NGpN?=
 =?utf-8?B?TFdTSWlWVGdlajRaRTMrWXhKRUxxdFJuc3JKWjJneGhjNkx1bGNuUGo3blZ1?=
 =?utf-8?B?QWI0VDRxdFErZ1JCQzE5SHhYRzZWZTRpZzFUcUFleEo4UzhmY3pWUzNGYXNi?=
 =?utf-8?B?YVNFU09IdTZ3ZGJuNm5CVi9sbjZSL1lvTjJoNFpHbjdBSXk1eHUyOEp4YXdO?=
 =?utf-8?B?N05jZWxQcUFuRTZjRnJNbStlWHhaODlmWE1aL1dNUkFKVzBDNFFCQkZnc1BP?=
 =?utf-8?B?YVdkd3lOdmYrNm4zTGVNd09GcE1PankzOFZ4MzdKclJhT2pTVlpnWWNvM2Ew?=
 =?utf-8?B?QUpBTURib2FRSDlxNUcxKzN2M0lxSFc3Q3RNQllsL2lIWWNDUzBRYU8yV09n?=
 =?utf-8?B?c2x2Z3RwK0VHblRsTURheXc2MkxqK0pvQnM3NHJ3dzZnOHJUK3F2MGs3T09Y?=
 =?utf-8?B?eGlZOW85Q2ZXSVhGZGl1MnRXeFkwc29Zb2ZjTlhMWEhPOG1uM2Irbm1udHdD?=
 =?utf-8?B?THJ3eHNzM2R3TFpWSDVvT2Rzdlg1dE9odG5tWkFvZml4NjdZVnNRcE81YUJo?=
 =?utf-8?B?cGR3SDE4WlpJY1E1Rm40OUZ6L3pJdk9YSHVxS2F2NFlxNVBQRitCWXcvQ2Y0?=
 =?utf-8?B?V2VnMGtYK3g1NUtUeHhKM2huZS94ckxrZ2xWSmtzbkkzYTZwTkVEUXA0d1lp?=
 =?utf-8?B?UXg0MlFlVGxsUk83K1drYzVObDVUMHJXZjYvOW55UnI0Ni9kckhkNjNyZnE2?=
 =?utf-8?B?MXNGc1ROTUgxaUxrVTRIYUxyVC9oR3IxdTRYWWJ4aS9VQWQ2Z25nbG9mSUZa?=
 =?utf-8?B?OHhvaWpERzVEYXRKL0FGdkZsdVZncHFaMlhMQzErbnplMGRlem95UE5tcjdh?=
 =?utf-8?B?U2Y3Uk9KZWloWVJaTUFueis3QVQxMFNIeDk5Qmcxc0FRSGhYNExwemVpTDEx?=
 =?utf-8?B?V0d1SVRJamxiZVpydUZzV2VrZDM2b2Zqb2N0S2haQWd6K3NXdTB5Kyt2eEth?=
 =?utf-8?B?ZkVORVRiQ0F6aUZtVW5HS3V4a2orUVZ1ejB4SGsrQ0ZqYjFPY2tKd1U1SHlw?=
 =?utf-8?B?WGRveVRkNkllaUpDNk4rTlEwaUdIV3VEZlZwc2dWMnZLVzlRR2tRMGhLajVo?=
 =?utf-8?B?eXNlYkpVRlRwM0x0QnB0RXpqd0ljNzJpUE93WGZYY2ZsNExzdU1wUXgra3hv?=
 =?utf-8?B?d3gyd1ZBU1RZNERZc1pCWWtOT0dHd3lRaVI0bzZkemNEaUxaZEg3bEdjQWQx?=
 =?utf-8?B?aStmYy9EMmkydEJwYTRhaHB6MGdmKzBkYVp6c0ViNGlPSjlEMDFLdkFkTmtW?=
 =?utf-8?B?OE9vWm45ZXVBMHR5aDBjNEJJbDdJSi9yekJsZHFFWDRpdURKc0YvWmljQU5j?=
 =?utf-8?B?aGVueFN5dWxMSkFqM20xV2xOSkxkMjFqVno4TTBUd2phSWlFWVdQMjBuaEp1?=
 =?utf-8?B?Y2tpODB2aW1SQzY0UGYrcUFsdjhkd0w5M3dpaDNHZVk5MUJxSVIra09oZ2ty?=
 =?utf-8?Q?zjztr5yaF0CQ41khaHel6CxrP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006aaea9-8537-43b9-eb70-08da8acb4b76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 21:04:57.6675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AII7hPwyscF5bBOmsTcpr3To46BpGzZrkNDrUCXZmqZsztpgHMr/E2ZvBEmVMLm5wrr5GrJvWejhtQ+B2eRliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300094
X-Proofpoint-ORIG-GUID: 2uVblo5GqrhU7BaUo7m-WfpRsf2fxI_u
X-Proofpoint-GUID: 2uVblo5GqrhU7BaUo7m-WfpRsf2fxI_u
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiA4LzMwLzIwMjIgMTI6NTggUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBU
dWUsIEF1ZyAzMCwgMjAyMiBhdCAwNjoyMjozMUFNICswMDAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+
ICAgCj4+Cj4+IEhpLAo+Pgo+PiAgIAo+Pgo+PiBJIGhhdmUgYmVlbiBleHBlcmltZW50aW5nIHdp
dGggZGlmZmVyZW50IHF1ZXVlIHNpemVzIHdpdGggbWx4NV92ZHBhIGFuZCBub3RpY2VkCj4+IHRo
YXQgcXVldWUgc2l6ZSBjYW4gYWZmZWN0IHBlcmZvcm1hbmNlLgo+Pgo+PiBJIHdvdWxkIGxpa2Ug
dG8gcHJvcG9zZSBhbiBleHRlbnNpb24gdG8gdmRwYSB0b29sIHRvIGFsbG93IHRvIHNwZWNpZnkg
dGhlIHF1ZXVlCj4+IHNpemUuIFZhbGlkIHZhbHVlcyB3aWxsIGNvbmZvcm0gdG8gdGhlIG1heCBv
ZiAzMjc2OCBzcGVjaWZpZWQgYnkgdGhlIHNwZWMuCj4+Cj4+ICAgCj4+Cj4+IOKAnHZkcGEgbWdt
dGRldiBzaG934oCdIHdpbGwgaGF2ZSBhbm90aGVyIGxpbmUgc3BlY2lmeWluZyB0aGUgdmFsaWQg
cmFuZ2UgZm9yIGEKPj4gbWFuYWdlbWVudCBkZXZpY2Ugd2hpY2ggY291bGQgYmUgbmFycm93ZXIg
dGhhbiB0aGUgc3BlYyBhbGxvd3MuIFRoaXMgcmFuZ2Ugd2lsbAo+PiBiZSB2YWxpZCBmb3IgZGF0
YSBxdWV1ZXMgb25seSAobm90IGZvciBjb250cm9sIFZRKS4KPj4KPj4gQW5vdGhlciBsaW5lIHdp
bGwgZGlzcGxheSB0aGUgZGVmYXVsdCBxdWV1ZSBzaXplCj4+Cj4+ICAgCj4+Cj4+IEV4YW1wbGU6
Cj4+Cj4+ICQgdmRwYSBtZ210ZGV2IHNob3cKPj4KPj4gYXV4aWxpYXJ5L21seDVfY29yZS5zZi42
Ogo+Pgo+PiAgICBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKPj4KPj4gICAgbWF4X3N1cHBvcnRlZF92
cXMgNjUKPj4KPj4gICAgZGV2X2ZlYXR1cmVzIENTVU0gR1VFU1RfQ1NVTSBNVFUgSE9TVF9UU080
IEhPU1RfVFNPNiBTVEFUVVMgQ1RSTF9WUSBDVFJMX1ZMQU4KPj4gTVEgQ1RSTF9NQUNfQUREUiBW
RVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JNCj4+Cj4+ICAgIGRhdGEgcXVldWUgcmFuZ2UgMjU2LTQw
OTYKPj4KPj4gICAgZGVmYXVsdCBxdWV1ZSBzaXplIDI1Ngo+Pgo+PiAgIAo+Pgo+PiBXaGVuIHlv
dSBjcmVhdGUgdGhlIHZkcGEgZGV2aWNlIHlvdSBjYW4gc3BlY2lmeSB0aGUgcmVxdWVzdGVkIHZh
bHVlOgo+Pgo+PiAkIHZkcGEgZGV2IGFkZCBuYW1lIHZkcGEtYSBtZ210ZGV2IGF1eGlsaWFyeS9t
bHg1X2NvcmUuc2YuNiBtYXhfdnFwIDEgbXR1IDkwMDAKPj4gcXVldWVfc2l6ZSAxMDI0Cj4+Cj4+
ICAgCj4KPiBBIGZvbGxvdyB1cCBxdWVzdGlvbjogaXNuJ3QgaXQgZW5vdWdoIHRvIGNvbnRyb2wg
dGhlIHNpemUKPiBmcm9tIHFlbXU/IGRvIHdlIG5lZWQgYWJpbGl0eSB0byBjb250cm9sIGl0IGF0
IHRoZSBrZXJuZWwgbGV2ZWw/Cj4KUmlnaHQsIEkgdGhpbmsgdG9kYXkgd2UgY2FuIG9wdGlvbmFs
bHkgY29udHJvbCB0aGUgcXVldWUgc2l6ZSBmcm9tIHFlbXUgCnZpYSByeF9xdWV1ZV9zaXplIG9y
IHR4X3F1ZXVlX3NpemUsIGJ1dCBpdCBoYXMgYSBsaW1pdCBvZiAxMDI0IChidHcgd2h5IAppdCBo
YXMgc3VjaCBsaW1pdCwgd2hpY2ggaXMgcmVsYXRpdmVseSBsb3dlciBpbiBteSBvcGluaW9uKS4g
SSB0aGluayAKd2hhdCB3YXMgbWlzc2luZyBmb3IgUUVNVSBpcyB0byBxdWVyeSB0aGUgbWF4IG51
bWJlciBvZiBxdWV1ZSBzaXplIHRoYXQgCnRoZSBoYXJkd2FyZSBjYW4gc3VwcG9ydCBmcm9tIHRo
ZSBiYWNrZW5kLgoKLVNpd2VpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
