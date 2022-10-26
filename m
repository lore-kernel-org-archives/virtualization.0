Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68597C38A2D
	for <virtualization@archiver.kernel.org>; Wed, 26 Oct 2022 01:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB22F40263;
	Wed, 26 Oct 2022 01:11:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB22F40263
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cTF6BtDY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=eMmbOzMg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XkVX3Ixk55Q; Wed, 26 Oct 2022 01:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DDE440256;
	Wed, 26 Oct 2022 01:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DDE440256
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A53FC0033;
	Wed, 26 Oct 2022 01:11:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EAF4C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 01:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BAF34020B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 01:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BAF34020B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cTF6BtDY; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=eMmbOzMg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2vqapX-3NCyf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 01:11:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BBD34000B
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BBD34000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 01:11:02 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q04gZu003589;
 Wed, 26 Oct 2022 01:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=prLwBhFkh4hqitYvFgD/4t4eyTg0oKKhjeFbRbePQk0=;
 b=cTF6BtDY+jfwpOlJcTvOyfTDVII7sZAXZouoFxVfHKvJ3xci3Mm7a/7elCGSjUK5AW6m
 4ofcCNBm/E10NXVReTA5zJGVkjjC7cjLzSzJ3Z7sIiUvVUsfbWKAEjR7ywayXswdBeYw
 ZQSKjaL4e/SZbEppXNS3PSLW9ImzdjdAgcqxG9gu4KphddIBMNo2RoHwNXKgRy80fS5P
 PWB/qmVg3Q4G5BR2291fUp8FgerI8lEyWSx8dqbBMggZfsKPimrmg/IkBUrfJwHvDyAF
 M+DfVRdHLGIcZ58PAp6suZuXahFJLNOqe38kA6LK7OWc3Y7+WL6xAzd2dSYp99YjEvso ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741wnbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Oct 2022 01:11:01 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29PLrXME017305; Wed, 26 Oct 2022 01:11:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3kc6y5ed6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Oct 2022 01:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On1qXx7VVaJ3sqs+CDUt02/Byo2N6WFp/EgookrtqZnC8HjHwEWyqZZDAuHpAVXMeB372Qg05PBrbi/B5MmWFuUO+SUao+fLnPB/C3lwAhPPqmIr1snH/WqSnjawIbThAIkZGKshU8IR+ElfJH/rONFLWAzQ7UH2/zoeNrIprH1Ruy5z+D7jcK+/RVDDtdtuzWQcSagxFaohMkv9cGmQgwYEyrWLJ+PKtBWfm5HsFUvB+Qqheq1pEh5AiLvrVpnzBNy+kznhf/UlCh+dSSl1OWfeDTFztubEMbkSHdTOkuSsdz0M94ItSypiBvGynP5sOQUVRV6alcDOecZT049APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prLwBhFkh4hqitYvFgD/4t4eyTg0oKKhjeFbRbePQk0=;
 b=fczUEKrCiCeD68zInfGveWiMo7dlZLXTV3U4D+CXMsHEhBfFUTWbQeq9eYJhqCVRLx9Ec2hbOBeb7g3XttM2OorRvTHcTIbKuI6bdVsy3/IeE/R7J892Sce33GPeOGNLUWS0Oir6TIXDLf/it1a3kZ8ltTDyoZx0fV2n02dXbc6V+Lw5t6Wx8hMAWL4RA8ob546jXNU36GLgt08ZNzEHX4p4VFByd3faAL37UB2fR55pDqB7Mb7xKoZH8ewIVKrGqATqlIbhom2ye/r/sBvPChtvcyC/ehRrszAVnBPIr5u2ABAkgZRAdkgwjEyaEOdUPIMvj0Qqpmo3mxCHpkDKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prLwBhFkh4hqitYvFgD/4t4eyTg0oKKhjeFbRbePQk0=;
 b=eMmbOzMgSduxPDzmyL3zYsHIXOapS/iWcj8pViEaCMYbnjmr2yjigoqjRFMrjkNzOabRG4RTXNQCBN4sOZVu5zTJbKA2i18oQwK2zm5cTBpjUOTZF8EnHA6vIr2s0FvCocT1aXu5ASaGAKSd8ayOh0UiVLLuu42W80j0YP2fHQw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 26 Oct
 2022 01:10:58 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Wed, 26 Oct 2022
 01:10:58 +0000
Message-ID: <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
Date: Tue, 25 Oct 2022 18:10:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:d3::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 3762b2ab-9771-4cea-0312-08dab6eef07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlFq6zvUV6jWqsZEYvggxKFQDypgsxv6QU/bJvfSIiOoUXJo2BohZ25+pNH3+dJgKVuIaLcPAqx3a+Qaz+sVF47/Xw4oyb5qQ0M/UEDLrBoktPd45nQt8bholPVoELcd7W3N1nY6MNdQOm2+88Ah6XlzYgoWPdfIakxA8cp/rp4Rs8qtVDY6pOzxELGF+Lw6ZQl1G9xxnjvc/WtynmWlytwshaMUVLgSALd4GioGN7HK+Uk5XwshxiFzncj/5aHRE9yI/dlM8KSqOMkS4ek7pwNFQ5NYk0Ui3ry+GpsufPI043fkQSRMMEkfBQBIagFhc2GpqADNtc8y/JCL7zXwAKeGM98iM5nq7OrwxA9lGjQ8517cRAksn6gs9fARKNqRirqSJSKYRdlHnZKKWXUQEIoNMm2bDGWdqqTb/AlD334f78YYUqYVcHThd139hIiitaBcD9LGmE+xFs8jDtqKa+xwzB3NFm8w4e/vDL+uENBQNRYk9ZUxdQlQlJoXX52ogVvhPTJCmHYNR+faLMzTxg142Nb2ZoWJBjxLgAxrs1NPrPKL1eFHloMBnmOgw2vt4NIcPnhBfN0keOVdkBhBmFcEDsdNiW/sEVKLlSTajNjsU2/OpbNMTHn3RbZQjxilP1Y6Llu4VszGMRCRRfiNXS+wwLyWhlODOyMXSj2l9LLYTp1Zqk0+SgntNkbKs7tSWuYs9ds9E/FGdNDiMCKrpY3744kymD6/8bkBzSeVBw6Ng1r1KA+7e9KJMRcw8lqzTkYjuidPWkHsxHaEHim8lxLFKaEOtTwxZfSh6ZdZrXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(6666004)(36916002)(4326008)(316002)(6506007)(6916009)(2616005)(33964004)(36756003)(66946007)(31696002)(53546011)(66899015)(2906002)(86362001)(8936002)(66476007)(26005)(5660300002)(30864003)(8676002)(83380400001)(66556008)(6512007)(41300700001)(6486002)(186003)(38100700002)(31686004)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZlSjVLRWhXczdXNFZwUk44M05yL2ZlVGFWT2k4LzZiOFZGOHk5MS90K2w5?=
 =?utf-8?B?U3RmVE9mUFdRd3lWd2NvU0tHekxPeWQrazZKRTI1SE5GNGVPNnN2QzhKTkt1?=
 =?utf-8?B?anBqY2x4eVh3NHFpcFhkb2JvMTB4OXp4UGlrdmM5NjhnbkRXaDJnaThpWFhy?=
 =?utf-8?B?WFhlMDM5ZDIrT053a1cwc2NBTEN5OGUyaEZSVWlsUXVjSHBYb21XWktJQy9m?=
 =?utf-8?B?REREYVFXM0ZFTm0xendlbFdzRVpSTjBVTEZHemNua01pb0Y5U0VEVFFsRG9i?=
 =?utf-8?B?UG9TQ2FoTWJSVmNrUkh6RFgvTXVYWVRETUVsRGRsL2NvMWxsLytWVlBmQlh1?=
 =?utf-8?B?aG00TG5wZENUcjV5WXkwaVprMXNnd0pYT0xRa3k3cFJRN1dvbzM2R2FxN3pO?=
 =?utf-8?B?RzVDV0FMYlhlZ21qNDFENGdPWHlhOU5tMWFoRTQ2VlhVbGRwRFhCcVhuS1dv?=
 =?utf-8?B?YTU4S25ROVMwcSsyeUcvUkUreVo3S3l3NGJxYVFRTFlhWlVrUlViY1RHZm9h?=
 =?utf-8?B?NWk2UG1nWkwzbG5zeG1tbEpBM2RNVzEvT1dKM1RGdFkvNnFMZVNVb0FMbzFl?=
 =?utf-8?B?cy9PcHMvMDNKc2V1TjB1ZHN4amJ0UDdDbGVuWUR3S1RZUEE1UEdiZmNYTUZm?=
 =?utf-8?B?dit1Vi9TdVhuUzFEZTQvNGdLNWhaYzkwUXZmVmE1dXFBbXdJYzI1dFluNXlh?=
 =?utf-8?B?c3UrQ0VBUkpsN283a3BlbWhLYzZFZXo3SGJ5c0prRy9pUzgvNlpMOGRMVllv?=
 =?utf-8?B?QzlkYThGRFNvS3lqa3RwMEt0M09qWGptQXl5TTZKTkdyQ0ZNUUk1VzF2QnpY?=
 =?utf-8?B?cDhCTm5JVjZ4NGMrY3NWQkxqNm9SZjJrY2lLa1BaeFlXSGZ6Q3NGam51eW4y?=
 =?utf-8?B?UWRNcmJzQ3RhV2k2RlAvUG5STGZRMUY4VGJrZUN0YjVvVkJMRHZzbFJ0R3gw?=
 =?utf-8?B?M1laTFNoSTRFTEJvWnE5YlQrcFhBWTV2ZmxHRmJCdkRzT3daRHUxNmIyejFF?=
 =?utf-8?B?b2VJbXRhemllYnlaMnBwSlZvYVZPajdocEV0bE0wNzRIRlBjOVhFbGRXSjRY?=
 =?utf-8?B?UGpkZHpwSUZMNDBzY2owK2hYZXdkM2llZVZwem9FYnJrZ2lORjFVbTM3dVNI?=
 =?utf-8?B?SkxIWno1UjNBVndWWXJRRDdYWno0UkJybkF6YlpaS3dlMERlMExXbGxDR2Jm?=
 =?utf-8?B?R0YyUUQyMlVSaVk1NTRjRTRSNm43bzRYN0xEeVRzZFNaZ0J2YUpsak5hcXRB?=
 =?utf-8?B?NUhYb1V6Z1lsUThEZm5EZnNNbjdPaHcrUWVHeEx3eW40bVNQY0Nid1A2V0xi?=
 =?utf-8?B?YkdmWUhpdHRZS1ZCZ0hIUG1jTk5nVlV2M3ZBQlViRmVXbVE5VVBTQjhoODlO?=
 =?utf-8?B?OVRrSWRWY1V5cEpSeW0xNUZicHc2SWxWNWUrdEgzNVJ4OHBzVCs4NFhobVJD?=
 =?utf-8?B?ZDJvMEtvakE1UVoyV0dCRGorZytoUElhd0R2T1lack91clZjOFF3VVdKRWRv?=
 =?utf-8?B?Y0VnUyt0Tzc0TmRDZ0VqaUVvWUdXTHk2Y0VvSC9HaWJBbTJYZkpvaVBZT0hz?=
 =?utf-8?B?NVdvVDhiVmtXWnp6cEcxRVZrMFc5Z0kzUkFNMnczeVQvd2Z0UWoxVUszRy9h?=
 =?utf-8?B?Z21yOWE3Nnczb1I0VkdETG5ZSDVNejBnWE5YUFRVMy9CZEFha3k3cVorQTcw?=
 =?utf-8?B?ZDUzbnVJTldZYjAyMVdHaS9tWjhBUFFqcTk0ZHYrVTFGZkpObk1EY2FmNGYz?=
 =?utf-8?B?eG5xMmVZZTFnbld4bEY5MmlDQk8wbXQvckFsQzFjNm5mVXFCM1NxZUNhTUp5?=
 =?utf-8?B?aTY2RFpwYU1LZVR1R0pBeU1IbzhyamtUbTJWVWJxai82QjhrWmcxeDBKZGVv?=
 =?utf-8?B?Z3h2NVNHdEE0RUR5MGZnclhWU3RnTXpQWmpjYkJTNFpvUUtPdXpxMkFyR2tF?=
 =?utf-8?B?Um1WZ1FCWElkQWJnWmR2MWRIZDFsaHNidnZWMFJGWURnVFBlQlgxR3U3b3Zo?=
 =?utf-8?B?ZU4zMWRsbzhiSDNwelNyOG1tNkNyKzB6K3BoV0dGWWNoWkl4TGV3dm9ENTA5?=
 =?utf-8?B?TDRocGRpYTRiVVh2VjBXdWFxd2RoMlA2bjR3WDBNRDFWSXlTYmliOTY1dXJt?=
 =?utf-8?Q?JNZlZvSS6QKcb51NSNrUKjelX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3762b2ab-9771-4cea-0312-08dab6eef07d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 01:10:58.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kkAt0ntZadWb+hJf/xgwrxmL+JkwC309L01HP+U0DESMUIeNaDN2qrb3rdhIK+fcZUHqtwAL3n6HM07II20DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_15,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260004
X-Proofpoint-GUID: Jv0DUg0vKnOxGIsnT4CJCrGaNzOBrNe1
X-Proofpoint-ORIG-GUID: Jv0DUg0vKnOxGIsnT4CJCrGaNzOBrNe1
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============4911742425796879169=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4911742425796879169==
Content-Type: multipart/alternative;
 boundary="------------pdSIwXzf45WgG6AnCzkxhO8a"
Content-Language: en-US

--------------pdSIwXzf45WgG6AnCzkxhO8a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/24/2022 7:24 PM, Jason Wang wrote:
> On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>
>>
>> On 10/24/2022 1:40 AM, Jason Wang wrote:
>>> On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>>> Live migration of vdpa would typically require re-instate vdpa
>>>> device with an idential set of configs on the destination node,
>>>> same way as how source node created the device in the first
>>>> place. In order to save orchestration software from memorizing
>>>> and keeping track of vdpa config, it will be helpful if the vdpa
>>>> tool provides the aids for exporting the initial configs as-is,
>>>> the way how vdpa device was created. The "vdpa dev show" command
>>>> seems to be the right vehicle for that. It is unlike the "vdpa dev
>>>> config show" command output which usually goes with the live value
>>>> in the device config space, and is not quite reliable subject to
>>>> the dynamics of feature negotiation or possible change by the
>>>> driver to the config space.
>>>>
>>>> Examples:
>>>>
>>>> 1) Create vDPA by default without any config attribute
>>>>
>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>>>> $ vdpa dev show vdpa0
>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>> $ vdpa dev -jp show vdpa0
>>>> {
>>>>       "dev": {
>>>>           "vdpa0": {
>>>>               "type": "network",
>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>               "vendor_id": 5555,
>>>>               "max_vqs": 9,
>>>>               "max_vq_size": 256,
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> 2) Create vDPA with config attribute(s) specified
>>>>
>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>>       mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>> $ vdpa dev show
>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>>     initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>> $ vdpa dev -jp show
>>>> {
>>>>       "dev": {
>>>>           "vdpa0": {
>>>>               "type": "network",
>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>               "vendor_id": 5555,
>>>>               "max_vqs": 9,
>>>>               "max_vq_size": 256,
>>>>               "initial_config": {
>>>>                   "mac": "e4:11:c6:d3:45:f0",
>>>>                   "max_vq_pairs": 4
>>>>               }
>>>>           }
>>>>       }
>>>> }
>>>>
>>>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>>>> ---
>>>>    drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>> index bebded6..bfb8f54 100644
>>>> --- a/drivers/vdpa/vdpa.c
>>>> +++ b/drivers/vdpa/vdpa.c
>>>> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>>>    }
>>>>
>>>>    static int
>>>> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
>>>> +{
>>>> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
>>>> +       int err = -EMSGSIZE;
>>>> +
>>>> +       if (!cfg->mask)
>>>> +               return 0;
>>>> +
>>>> +       switch (device_id) {
>>>> +       case VIRTIO_ID_NET:
>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>>>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>>>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>>>> +                       return err;
>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
>>>> +                       return err;
>>>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>>>> +                               cfg->net.max_vq_pairs))
>>>> +                       return err;
>>>> +               break;
>>>> +       default:
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>>>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>>>> +                             cfg->device_features, VDPA_ATTR_PAD))
>>>> +               return err;
>>> A question: If any of those above attributes were not provisioned,
>>> should we show the ones that are inherited from the parent?
>> A simple answer would be yes, but the long answer is that I am not sure
>> if there's any for the moment - there's no  default value for mtu, mac,
>> and max_vqp that can be inherited from the parent (max_vqp by default
>> being 1 is spec defined, not something inherited from the parent).
> Note that it is by default from driver level that if _F_MQ is not
> negotiated. But I think we are talking about something different that
> is out of the spec here, what if:
>
> vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.
>
> Or is it not allowed?
My understanding is that this is not allowed any more since the 
introduction of max_vqp attribute. Noted, currently we don't have a way 
for vendor driver to report the default value for mqx_vqp, if not 
otherwise specified in the CLI. Without getting the default value 
reported in 'vdpa mgmtdev show' level, it'd just confuse mgmt software 
even more.

>    At least some time in the past, mlx5 were
> enabled with MQ with 8 queue pairs by default.
That was the situation when there's no max_vqp attribute support from 
vdpa netlink API level. I think now every driver honors the vdpa core 
disposition to get a single queue pair if max_vqp config is missing.  
And the mlx5_vdpa driver with 8 queue pairs in the wild days is just 
irrelevant to be manageable by mgmt software, regardless of live migration.
>
>> And
>> the device_features if inherited is displayed at 'vdpa dev config show'
>> output. Can you remind me of a good example for inherited value that we
>> may want to show here?
> Some other cases:
>
> 1) MTU: there should be something that the device needs to report if
> _F_MTU is negotiated even if it is not provisioned from netlink.
I am not sure I understand the ask here. Noted the QEMU argument has to 
offer host_mtu=X with the maximum MTU value for guest to use (and 
applied as the initial MTU config during virtio-net probing for Linux 
driver), and the way to get the parent device MTU and whether that's 
relevant to vdpa device's MTU is very vendor specific. I think we would 
need new attribute(s) in the mgmtdev level to support what you want here?

> 2) device_features: if device_features is not provisioned, we should
> still report it via netlink here
Not the way I expected it, but with Lingshan's series to expose fields 
out of FEATURES_OK, the device_features is now reported through 'vdpa 
dev config show' regardless being specified or not, if I am not mistaken?

Currently we export the config attributes upon vdpa creation under the 
"initial_config" key. If we want to expose more default values inherited 
from mgmtdev, I think we can wrap up these default values under another 
key "inherited_config" to display in 'vdpa dev show' output. Does it fit 
what you have in mind?

> or do you mean the mgmt can assume it
> should be the same as mgmtdev. Anyhow if we don't show device_features
> if it is not provisioned, it will complicate the mgmt software.
Yes, as I said earlier, since the device_features attr getting added to 
the 'vdpa dev config show' command, this divergence started to 
complicate mgmt software already.

Thanks,
-Siwei
>
> Thanks
>
>>
>> Thanks,
>> -Siwei
>>
>>
>>> Thanks
>>>
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int
>>>>    vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>>>>                 int flags, struct netlink_ext_ack *extack)
>>>>    {
>>>> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>>>                   goto msg_err;
>>>>
>>>> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
>>>> +       if (err)
>>>> +               goto msg_err;
>>>> +
>>>>           genlmsg_end(msg, hdr);
>>>>           return 0;
>>>>
>>>> --
>>>> 1.8.3.1
>>>>

--------------pdSIwXzf45WgG6AnCzkxhO8a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 10/24/2022 7:24 PM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">


On 10/24/2022 1:40 AM, Jason Wang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Live migration of vdpa would typically require re-instate vdpa
device with an idential set of configs on the destination node,
same way as how source node created the device in the first
place. In order to save orchestration software from memorizing
and keeping track of vdpa config, it will be helpful if the vdpa
tool provides the aids for exporting the initial configs as-is,
the way how vdpa device was created. The &quot;vdpa dev show&quot; command
seems to be the right vehicle for that. It is unlike the &quot;vdpa dev
config show&quot; command output which usually goes with the live value
in the device config space, and is not quite reliable subject to
the dynamics of feature negotiation or possible change by the
driver to the config space.

Examples:

1) Create vDPA by default without any config attribute

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
$ vdpa dev show vdpa0
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
$ vdpa dev -jp show vdpa0
{
     &quot;dev&quot;: {
         &quot;vdpa0&quot;: {
             &quot;type&quot;: &quot;network&quot;,
             &quot;mgmtdev&quot;: &quot;pci/0000:41:04.2&quot;,
             &quot;vendor_id&quot;: 5555,
             &quot;max_vqs&quot;: 9,
             &quot;max_vq_size&quot;: 256,
         }
     }
}

2) Create vDPA with config attribute(s) specified

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev show
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
   initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev -jp show
{
     &quot;dev&quot;: {
         &quot;vdpa0&quot;: {
             &quot;type&quot;: &quot;network&quot;,
             &quot;mgmtdev&quot;: &quot;pci/0000:41:04.2&quot;,
             &quot;vendor_id&quot;: 5555,
             &quot;max_vqs&quot;: 9,
             &quot;max_vq_size&quot;: 256,
             &quot;initial_config&quot;: {
                 &quot;mac&quot;: &quot;e4:11:c6:d3:45:f0&quot;,
                 &quot;max_vq_pairs&quot;: 4
             }
         }
     }
}

Signed-off-by: Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a>
---
  drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
  1 file changed, 39 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bebded6..bfb8f54 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
  }

  static int
+vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
+{
+       struct vdpa_dev_set_config *cfg = &amp;vdev-&gt;init_cfg;
+       int err = -EMSGSIZE;
+
+       if (!cfg-&gt;mask)
+               return 0;
+
+       switch (device_id) {
+       case VIRTIO_ID_NET:
+               if ((cfg-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &amp;&amp;
+                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
+                           sizeof(cfg-&gt;net.mac), cfg-&gt;net.mac))
+                       return err;
+               if ((cfg-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &amp;&amp;
+                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg-&gt;net.mtu))
+                       return err;
+               if ((cfg-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &amp;&amp;
+                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
+                               cfg-&gt;net.max_vq_pairs))
+                       return err;
+               break;
+       default:
+               break;
+       }
+
+       if ((cfg-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &amp;&amp;
+           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
+                             cfg-&gt;device_features, VDPA_ATTR_PAD))
+               return err;
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">A question: If any of those above attributes were not provisioned,
should we show the ones that are inherited from the parent?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">A simple answer would be yes, but the long answer is that I am not sure
if there's any for the moment - there's no  default value for mtu, mac,
and max_vqp that can be inherited from the parent (max_vqp by default
being 1 is spec defined, not something inherited from the parent).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Note that it is by default from driver level that if _F_MQ is not
negotiated. But I think we are talking about something different that
is out of the spec here, what if:

vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.

Or is it not allowed?</pre>
    </blockquote>
    My understanding is that this is not allowed any more since the
    introduction of max_vqp attribute. Noted, currently we don't have a
    way for vendor driver to report the default value for mqx_vqp, if
    not otherwise specified in the CLI. Without getting the default
    value reported in 'vdpa mgmtdev show' level, it'd just confuse mgmt
    software even more.<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">  At least some time in the past, mlx5 were
enabled with MQ with 8 queue pairs by default.</pre>
    </blockquote>
    That was the situation when there's no max_vqp attribute support
    from vdpa netlink API level. I think now every driver honors the
    vdpa core disposition to get a single queue pair if max_vqp config
    is missing.&nbsp; And the mlx5_vdpa driver with 8 queue pairs in the wild
    days is just irrelevant to be manageable by mgmt software,
    regardless of live migration.<br>
    <blockquote type="cite" cite="mid:CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">And
the device_features if inherited is displayed at 'vdpa dev config show'
output. Can you remind me of a good example for inherited value that we
may want to show here?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Some other cases:

1) MTU: there should be something that the device needs to report if
_F_MTU is negotiated even if it is not provisioned from netlink.</pre>
    </blockquote>
    I am not sure I understand the ask here. Noted the QEMU argument has
    to offer host_mtu=X with the maximum MTU value for guest to use (and
    applied as the initial MTU config during virtio-net probing for
    Linux driver), and the way to get the parent device MTU and whether
    that's relevant to vdpa device's MTU is very vendor specific. I
    think we would need new attribute(s) in the mgmtdev level to support
    what you want here?<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
2) device_features: if device_features is not provisioned, we should
still report it via netlink here </pre>
    </blockquote>
    Not the way I expected it, but with Lingshan's series to expose
    fields out of FEATURES_OK, the device_features is now reported
    through 'vdpa dev config show' regardless being specified or not, if
    I am not mistaken?<br>
    <br>
    Currently we export the config attributes upon vdpa creation under
    the &quot;initial_config&quot; key. If we want to expose more default values
    inherited from mgmtdev, I think we can wrap up these default values
    under another key &quot;inherited_config&quot; to display in 'vdpa dev show'
    output. Does it fit what you have in mind?<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">or do you mean the mgmt can assume it
should be the same as mgmtdev. Anyhow if we don't show device_features
if it is not provisioned, it will complicate the mgmt software.</pre>
    </blockquote>
    Yes, as I said earlier, since the device_features attr getting added
    to the 'vdpa dev config show' command, this divergence started to
    complicate mgmt software already.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <blockquote type="cite" cite="mid:CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

Thanks,
-Siwei


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+
+       return 0;
+}
+
+static int
  vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
               int flags, struct netlink_ext_ack *extack)
  {
@@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
         if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
                 goto msg_err;

+       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
+       if (err)
+               goto msg_err;
+
         genlmsg_end(msg, hdr);
         return 0;

--
1.8.3.1

</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------pdSIwXzf45WgG6AnCzkxhO8a--

--===============4911742425796879169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4911742425796879169==--
