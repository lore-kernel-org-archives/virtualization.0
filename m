Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E28C77B72
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 16:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 892D840500;
	Fri, 14 Apr 2023 16:49:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 892D840500
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=3G1fkNGL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=c6e7OSC1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkeUm-gbox6p; Fri, 14 Apr 2023 16:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3E2440502;
	Fri, 14 Apr 2023 16:49:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3E2440502
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA772C0036;
	Fri, 14 Apr 2023 16:49:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19D6EC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 16:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D34F16FFB3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 16:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D34F16FFB3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=3G1fkNGL; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=c6e7OSC1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Ns6moJ-CIeg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 16:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABCB66141A
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABCB66141A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 16:49:39 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33EEmv7p032163; Fri, 14 Apr 2023 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rIq5NmjttLNdNS2TOZtbL1KgU4NcXOYfo7ypMduZb/c=;
 b=3G1fkNGLicmqoCSJMhvnqElWfDT89cLQw+P6ixs3VPFr9GbiukQoxZUCLBW34v228J6e
 O51l7+vZAg+xKjvpLK0upE34eFJIMIyRQkun1qVaAeL+HuYKqoYZyrfnlObShoQl0s7N
 FUfEOLSyd/EvPzkMJ/W/4vO8LxNeavbPqKbG1/sLOdKF0My1lLqSZD8rJq2yynbU6z7m
 o/pwoXopO3el0fSXnBGGoKFQ0GzKKxoUsyiIUlD+QU8JDPG4uW1vsHponOY4SxOWtDFr
 Oo7SWmPpcbK6SNMJhV7Vl+nsbTu4p0ZoKnXYoaWLYMyX8DIs1ZyLaN+ydYjhyqPnIPDZ Qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b36fab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Apr 2023 16:49:38 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33EGQ809018840; Fri, 14 Apr 2023 16:49:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3puwbtbjd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Apr 2023 16:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dktTPbXYrM5O7ojD7Pt/RSjXjyRYqYxmLNJ1LzOP4lm0YEfZ+J5ez2faZ0m9S1j6sDnUa5L+7f49rXPBhOuyNwQClF+Z/trRc/O9DbGZkTVr5eP3L4Q8+GPVMFaqvabGioNg/WpW9vJ8isA0lqMuMCZR3YFcBcR+Rg8hT/sA/CMLWpOcNL0HSTsJ7xhVXDg8qzr/13iEg4NjShXIlsSgmRBq2MF/S9aCrZiy9Ubr4AxKO30i4l4FVIxir7U6QF7laSV2uPpHHbR5HO0Xgt9vvMVBEVZh43tvcadvjGAPasIVp/9Ic5gb000bRxw8zBwpSd4rRhYM5ZW+xODJPToOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIq5NmjttLNdNS2TOZtbL1KgU4NcXOYfo7ypMduZb/c=;
 b=KcyIlKpJ0oAEJiPYI3PBnnU+nRDFJp65vM2ICMfTRTIKZ0BF5UtAuaci6PXhJjnl6QSUCy+konTj57ZUIFluk5AnjXYQ5Jnl/ZMcf/aBL9uCfa0KZbscsu/rVg+7ecSMosHYev7NRqS05h05iuuCA1eEKkV1QR+8OikDXzYvrgz79/Vgq9CRSKUPmYxvPxERbnyW2dlI821e6/ai+AswpTrbMLbxKoy+2+LQNVYfU8Qv5Pzh+GtkrDFdZQDYNDCY7fBHOSGBAD7pgIRG4y7SX0+nX893FidIVW2ih/JXixbFBADiQUVAucuSAi9oDmDmhB7N9o3KtkyTqQgmxOpVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIq5NmjttLNdNS2TOZtbL1KgU4NcXOYfo7ypMduZb/c=;
 b=c6e7OSC1dDrYYKgVQ98DWch6D4r6wLK/nIdqDvKjd6ezm21zuPAhXpRVRwAXAC8XcgTsB2HZ4TTbmeRY4z1iCO0rb1G2B0LmSQuzdXmh9dusUbgEd8ZbBRNUKWjPMAXyM+jeztScNlkbjoLIOd24HtaTGBWeBJubGQgp2V8oMro=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS0PR10MB7453.namprd10.prod.outlook.com (2603:10b6:8:159::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 16:49:35 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6298.030; Fri, 14 Apr
 2023 16:49:35 +0000
Message-ID: <c8dde797-1dd7-31b5-64c7-9454ca8837a8@oracle.com>
Date: Fri, 14 Apr 2023 11:49:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 11/11] vhost: allow userspace to create workers
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-12-michael.christie@oracle.com>
 <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
 <faeaa023-c1ee-cd81-3397-edecc0579e8a@oracle.com>
 <CACGkMEvrvpu-xdJTzm5mVq-9JGuXRnsXZHEU7tgwfsz6qqFc4g@mail.gmail.com>
 <0ce314ff-0a1d-223d-0ccf-d2cb876b4306@oracle.com>
 <CACGkMEs5GdXuoMaOiZjWytG=JHqhzdZmCu=dK7GRRvYcx8t2+A@mail.gmail.com>
 <c7da1c60-1b89-5fab-942a-1e74214f03d5@oracle.com>
 <CACGkMEsYK5yWuFECrUM-_fLA1V4H=WayxfovT2ezMeQCmwcDoQ@mail.gmail.com>
 <26bae999-4375-ab02-a97b-056282a84ecd@oracle.com>
 <CACGkMEuU4pzDh1dbJgH_x0Oxtia3VorhLPuqU20xkoMK9HOoTQ@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEuU4pzDh1dbJgH_x0Oxtia3VorhLPuqU20xkoMK9HOoTQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:5:134::48) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS0PR10MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e991e4-174e-44b1-94ed-08db3d083a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoDMORO0mZvFxPqOuuDQm//Cw35qDpARPc/dGaldO/VVnuqa0txfVn81ixbjYkg/P6fJ6DUvUOccCl0cSbE7uK3yIcy8jgy5m3ZonbWaxgRnqaF5mLRBv9o48tOcwtjdPzfqdlMIHTFtGcWltJmSZHwrmx8z9lCELBAfYzb9lejRWCZbf59Gn01ykVCv36XSdu01+Bm8DMwYO94+QyfsBjQ1b0YsDiq7x7jq0coUX6VDh8VcajcSaDl8Xw+PwnpMsoPhhyQPrQmiQDnS9ePBXR/pU8ZTQIJ3QmfEwQGM4oG9Ytdipn13AFrr7a4m4Yj2FJB9rZ8d5oLsS+mTJbivZv44xcL+cEmsicNSuE2IvgUAgEH+DAo7G/RTmxW/mpIQm9Tl0bGdeFzjBV5Iw0Xsa7RWxG6JCvZ2ZcAp2RuICIBQI/q/M4xBTmgyBqeXfjbjeb2fSx6jGEI1flHBPUHLJh7XnLlOzahBU6Q2Mv2cV9I0FN9j/lSfTkevn800py1UqnEcOLnv0bNonsH/qrnHJAt7LDoiICcQeqVuxxiZNtptJfW7rH8KJ4OeTF1upeBFQtDhmm0/MhJ9QtOvYJx3ApGsXpM5/8Km/bNS1DLFstTKKWUIuWjIOWVWCn08iQppxKM16vMlGJhscQR3v+hfZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(31686004)(2616005)(186003)(6512007)(6506007)(26005)(53546011)(86362001)(66556008)(66476007)(66946007)(8676002)(38100700002)(6916009)(2906002)(4326008)(31696002)(41300700001)(316002)(478600001)(8936002)(5660300002)(6486002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRPOUp3RnpDTlVmdVdHTDhobkpnUm5tbVRoMzQvbmVld2VUZEJoMnVWRFZi?=
 =?utf-8?B?a2Y0V0xQOVRBRjU5TVlEK3k1Y0lQRW4vNUVmRitvNTJ2VWxvV2kzNllGM3Fx?=
 =?utf-8?B?NStqbUNEV0w4SS9uRnBnLzd5MGsyUzJURStBaURhcURnT1lkYlNYZEpBL1pM?=
 =?utf-8?B?TWw3MlZtUWdYN0RVN2VxNTlBMXpVb2lRR1gyR3Fxb2NJcUcvTU1kQ1M1VXNI?=
 =?utf-8?B?RUw5RCtxaWZDMVU5NThka2w4cHBYTnREb1Fzck5KR0tSRFJ5dXJWL01zamVL?=
 =?utf-8?B?d2N1YXAyQzkySWc0b1pGRW9pMVpKcW5Ed3NQTWQwRy81azJTbVpjWUV3dndE?=
 =?utf-8?B?b05VVGxTdDVERHhrMnN5T0JVL1J1Tk12V05FSjNrTUYydlBTN09HK0FRS21B?=
 =?utf-8?B?M0toQXc2N1cvalk5QkVydXFGcC9hcjhiK3BIbEdDVm5nQnlXZVRmZVh1Y01V?=
 =?utf-8?B?UE5ldGUyUWNRRFUrTDBJZEFXbWg3VjJIeGhzSlBiQm9RbEs0ejhtQmRMdzlU?=
 =?utf-8?B?NTZKMW1sbzBaQ09SV0YrbllMMCt0dW9Xb2ZiOWpvMWVkdkxNbS9TQVB4UTNQ?=
 =?utf-8?B?WUVkcUVTcEZFZHU0Y1lqcnZrcnYxMzVFNVhqaklMTW9yZUNLdEFnRHRyV1BB?=
 =?utf-8?B?aW02azNIZHhMa0EzRUI5NzVCY0Q4eDNkZ0x3dks0VWpNcDlYZW1Veml6NUtS?=
 =?utf-8?B?MTd0SFlELzJpSm80ZkcvTEkwcUMyL3I2L1pjdXNUUGkreFk1NndLaFVCS0M2?=
 =?utf-8?B?N3NCbG1uL0k5cytleExXMGwrcitkdVdPV3lxTTMyVnREMForUVpmZGZZc0N1?=
 =?utf-8?B?M25TOWdnaXE4Y0lhWmhlVGdtaTBJYTI0UXFYMUVZb2xvN01yZ0srRnFldWla?=
 =?utf-8?B?SDhxOGpTemswcGhRR1ZiYnJDanZyaWZmS3hwaEpQWi9MclgvWDRPeENUTEti?=
 =?utf-8?B?OTBhUS9tY2pZN01GMTliTTZRaHZuVmFhM1E0QWllcjBqcWN3RkNPNkdTbzJy?=
 =?utf-8?B?aEJVK1d6Tzk2eHJUQUtmdEVUN2ZZVURubldUSHIwM3dNRjJZeno1cnNNOVJ0?=
 =?utf-8?B?cDFmNWE0Z0tIa0l5cnI4MFA1QTBkTzlBcjZkMkRkbTdNYTV3SG1vTVZWT0lj?=
 =?utf-8?B?d0FubFZzN3p6M3pxdXUzSU1CcjFqUnZDZEd1eWRZaXJ1RXR4clVzRlFQbU52?=
 =?utf-8?B?VG9hcWp1WGFkR2RrWkZFemVhTVFtUmNjMDJaSVJ5SEl5RDJCYWp4b3AvY2cz?=
 =?utf-8?B?QlE3TWtPcURpU1NTRFBMUWxIV0NTa3gyZVBkMTBsd0lNTzlxTWdPM0swTERE?=
 =?utf-8?B?MkRSazJHclczL3daRjZiTUFydE1hc3dQY3J3clI0TWxOcDJCNDdoRWZwb3Y4?=
 =?utf-8?B?UmpYQlN1bm1helBrcmV4dktQczNhN1ZCMEdjZWs4WWRqaG1rRWlhYW5hT1h4?=
 =?utf-8?B?bktYVmVwelc0aDljYlN4djEwK2g4TGxOOXF4MUhVRDlmRFlyQVR0Rk1qL290?=
 =?utf-8?B?M2pLdHF6Zm56WkFQMHQzTXRDZWlRVmFCcVJJZFlIYmNpcFNnY1RrTDZ4MENn?=
 =?utf-8?B?T0lyTXMyaDlxTUZ4czh3ckxKTkl5dVZQeGEyY0V4SEdCV1FvdDd5SnQvcWl5?=
 =?utf-8?B?Y0J2MEdEYm1DbEdHZ09WemxUamJDSGxnbXJCS0txY0xCUU11SFptWG4xRFQv?=
 =?utf-8?B?RVhCYmwrSU1oeFpsWnRuUEhmUldGUGJXNFRFUWhrVjF5OVlXMjRSWUNVck9p?=
 =?utf-8?B?bEhVdHRuQ010UUZhSWd1TXdSVGxCQ1J0RXhpWnNGTzZMNTZ4SE9yamo3NkF5?=
 =?utf-8?B?TlJLYnFYcHpLSTRiUWx4MEppWTZ1eW16MG5TNGpVdGNGT2E0RzRDbTZjTVQ2?=
 =?utf-8?B?ODdUT2pjd3NBS0FPbUlCZHp1MmtMNmorUnVvam1WQU5BV2p6WEN0VDNQdVpL?=
 =?utf-8?B?K1MwejBVMXJ4VFh1S2VXMU5yb1A5eWxWY1FCSHpUamJPaEY1Um83MUw5NHBT?=
 =?utf-8?B?UW90RDk0UFJCOXlwcHdpODZyRGtmU3pQRnprR05HaUkzVUxmR3F6cHdGNHJR?=
 =?utf-8?B?d2pKd01EdXJRaktkdU1XSVJNcXJhcDRuc0srVXJyQzB2Sk9jUkYzSjA4WmJx?=
 =?utf-8?B?RTRKb3RONHE3VCs1aS9iaWk1WHZWRU82eHBLOW12RG1NMHBSaERaL0NSeFN6?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v1fv5fcibFZLr/8DuA7fTpQg+IvjVb5KXvWWpbMc6DyV7hUbixHZwAgUMJoJb/FyqgPktLLGMZxr0uWN2sp07k0kMzoljUV7raRRiFHqXeagzP+mr9hF5njvkb7FUQOaXvVPxsj9YF0BwXs+c0XAWR/di5juIqpuyrX8lu3sh1kTya2JQC+fzCpfWtOB+N4KY6j7AcJr1uf7TtGV5W2M4Oar1YgDYTUJXDgxVe4gMTnP06kzI3aOImjwz30kSJv3bTtx7l/rhwWYOaEdoiKxYZAdd8RmpVpIkQHhj08SR4JB/B/yon241S4piucUfpBoLUP76AdIOFJM1W+JDnmviY63YuE78XANREZnGnO4UjqyZehGpUrgaeOIuMaleif7amAMwI2oAJrM+FB/vSkeNLVOXnrHkDE+/kbuPhoePu0IaE06tyBW3/+O3ufgy3n7wlCNDPX6rvnGiH0C56fCog95tS/K5Kh3DdM53OcYYEusj4Kx/DiKBh7JH0C8pveQ14SozuhFCtNQFd6W+ccOkFxMlk6/lFxZqdxFuIax3UQ/DhvrOkS3aNSphnSL4aLtv1x/+M02QxTKG6GUW+UEt2XvpIIr9tZRZCNEP10Q+s5aX4PBQFl67Yu/V0OWRN2M+0Ca6tc+to4h/RCfeg3dUqJVDXN4P5i6RNbDcDkllEGid/+iD8z7Kw2d40Vn9f59jKp/imuXMrI4pNPtjMBIlvxixgrCqkHWkeT9oAmGiKEGStdVfwWhlHN8KOejNd0cAKJdaWehQseUND9jc4jVhCK5Oh3R+YY+8cDOPgzswbLIdx4R6oeljhrs2qKPW8+R
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e991e4-174e-44b1-94ed-08db3d083a55
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 16:49:35.2008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKsO9irYgmcOUmo5v0QQsye5BF/3elcbeIuAhS3Yuv8AHj51u/1IXJN68U7DDKhbeSAjOMPotS9n3EjQtjJsAHYILBLnOpndBA5TjRVU54Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_09,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140148
X-Proofpoint-GUID: 370vtIGck4nRNpVGETLCMSmx3yVNpQ2a
X-Proofpoint-ORIG-GUID: 370vtIGck4nRNpVGETLCMSmx3yVNpQ2a
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNC8xMy8yMyA5OjI2IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgQXByIDE0LCAy
MDIzIGF0IDY6MzbigK9BTSBNaWtlIENocmlzdGllCj4gPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xl
LmNvbT4gd3JvdGU6Cj4+Cj4+IE9uIDQvMTIvMjMgMjo1NiBBTSwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+PiBJIGNhbiBzcGluIGFub3RoZXIgcGF0Y2hzZXQgd2l0aCB0aGUgc2luZ2xlIGlvY3RsIGRl
c2lnbiBzbyB3ZSBjYW4gY29tcGFyZS4KPj4+IFNvIEknbSBmaW5lIHdpdGggdGhpcyBhcHByb2Fj
aC4gT25lIGxhc3QgcXVlc3Rpb24sIEkgc2VlIHRoaXM6Cj4+Pgo+Pj4gLyogQnkgZGVmYXVsdCwg
YSBkZXZpY2UgZ2V0cyBvbmUgdmhvc3Rfd29ya2VyIHRoYXQgaXRzIHZpcnRxdWV1ZXMgc2hhcmUu
IFRoaXMgKi8KPj4+Cj4+PiBJJ20gd29uZGVyaW5nIGlmIGl0IGlzIGJldHRlciB0byBoYXZlIGEg
dmhvc3RfZ2V0X3dvcmtlcigpIHRvIHJldHVybgo+Pj4gdGhlIHdvcmtlcl9pZCBvZiBhIHNwZWNp
ZmljIHF1ZXVlLiBJbiB0aGUgZnV0dXJlLCB0aGlzIG1pZ2h0IGJlIHVzZWZ1bAo+Pj4gZm9yIGRl
dmljZXMgdGhhdCBoYXZlIG11bHRpcGxlIHdvcmtlcnMgYnkgZGVmYXVsdD8KPj4KPj4gWWVhaCwg
aXQgd291bGQgYmUgdXNlZnVsLiBKdXN0IDIgcXVlc3Rpb25zLiBZb3UgbWVhbiBhbiBpb2N0bCBj
b21tYW5kIHRvIGdldAo+PiB0aGlzIGluZm8gcmlnaHQ/IEkgaGFkIGFkZGVkIG9uZSBpbiBvbmUg
dmVyc2lvbiBhIHdoaWxlIGJhY2ssIGJ1dCBkcm9wcGVkIGl0Cj4+IGJlY2F1c2UgZm9yIHNvbWUg
cmVhc29uIEkgdGhvdWdodCB3ZSB3ZXJlIGdvaW5nIHRvIGRvIGEgZ2VuZXJpYyB2aG9zdCBzeXNm
cwo+PiB0eXBlIG9mIGludGVyZmFjZS4gV2UgYXJlIG5vdCBkb2luZyBzeXNmcyByaWdodD8KPiAK
PiBQcm9iYWJseSwgYnV0IHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoZSBlbXVsYXRvcnBpbiBjYW4g
d29yayBmb3IgbGlidmlydCBhdCBsYXN0Lgo+IAoKWWVhaCwgaXQgd29ya3MuIFlvdSBoYWQgbWVu
dGlvbmVkIHRoYXQgdG8gbWUgYSBjb3VwbGUgeWVhcnMgYWdvIGFuZCBJIHVzZSBjb21tYW5kcwps
aWtlCgp2aXJzaCBlbXVsYXRvcnBpbgoKaW4gdGVzdGluZy4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
