Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DA9C2FC0E
	for <virtualization@archiver.kernel.org>; Thu, 17 Aug 2023 00:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C989061415;
	Thu, 17 Aug 2023 00:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C989061415
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=yHdxS9F6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ZlLGT7Sr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-IEDEfcxdZb; Thu, 17 Aug 2023 00:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01CCD605D5;
	Thu, 17 Aug 2023 00:05:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01CCD605D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC079C0072;
	Thu, 17 Aug 2023 00:05:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00BE4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 00:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C174B41779
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 00:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C174B41779
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=yHdxS9F6; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=ZlLGT7Sr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lp9HTev-bDRy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 00:05:24 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C03AA41776
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 00:05:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C03AA41776
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GNfr5J021114; Thu, 17 Aug 2023 00:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4DtpvQ4Kp6TWmhRO7LooPXBfALBcKql/I39PzfAdQVc=;
 b=yHdxS9F6u9Gh1lhe/X96DkDw+vJ+JpDUg02uxPEgjpztvfhyGJXqz12duDmYHJjU4qgd
 LHDMGecW1re7JfmzK/6DBRbQVIwwndphnXuObXgidG7EG9+LfotYotmzRk+uJqlgq4a+
 GbmH9/XjS1vM0/wkrSz/GgXNg/hcRlpbEV/U6V/43HyPmBFeUFMDmNh0IeEuzEL6FLv5
 snOP6wwVglNE0H+EwzWvr0fy3wsRy8FEBRftCmKYG5c8K586KneNV/xsykV0BLEuvGLJ
 TknGra4uDj7b1+ugpkUFHe00YPzCUFsA231HYli/KG0AbJoVzrssGCCbWl5pm4CD0kWK 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfr850-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Aug 2023 00:05:19 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37GLVaZe040114; Thu, 17 Aug 2023 00:05:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey0swdu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Aug 2023 00:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUvrCQ4GoXZ/wyRVlDkEEVR5pBmg4EBzZn8O+RzGNy2SBflyU0my4sdIUBW6kd3BMwjcIvERXgi4+UgNoFiqAI1TdFfS9jvxU17/hAE1Qfxdvbf10eByIpSD53qKXVUvJP+qY/G3fkAyW0N7B9LMM198RscOs/K5iqCgSM/brz7Za5Yp5IB/viLRf8AN5COlatxI71iV2hvp9QslPvjR038VR9UTuDsVNTxt5upmyVI2WYBK7Zh+YscK8AGA080nlnvOzCfLkaoH2KTQeAEpYN4Va8X4E0PR8L7mDJ++MIV4dihtmkAaa7BtmY9O2MHxXfr7Yefab3aMJLNQna8q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DtpvQ4Kp6TWmhRO7LooPXBfALBcKql/I39PzfAdQVc=;
 b=H+aIPGiL7B8DO1FMFHi8p/ktkCfl/39ar1m4bkmsTBdeljzZQ9sC4GNY3rVDtWQBB29OMbM0/QhKfi5GoMkpNf2Q6FsNalqVbyf3pFMJnKmc42+KcKxKK6jJ7sIjyx94x+VyH/TdrJ6iL1bGgp+m1YUKfeVJonnDrSR1PZDo3JxKDsfUraBJZFLwoD2oIG8LZtYcWeiAEgWt1vTjUfqrNuMywpD3/DITZ5IhhWtQ8sO9srLTVyTsu27Yppp/4nIobhjLxIAXsq1Y/WRjkg9xhMdP8tw6YO3tG1g75Cqi5LdNo9fzaCBKnmjAr7e18Piq4BGJZYbU//XNGTXQh8DcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DtpvQ4Kp6TWmhRO7LooPXBfALBcKql/I39PzfAdQVc=;
 b=ZlLGT7SrO35kPxpT8rU5Go6d9JrgBDrzcpTNGSt2q/AaM6R8ohxmcHzxKL62M2I0Yl66mpV2qBvntc1aKjUUnzWGJqKkNfcYXQ+cloJvZbQujyO+cSSVaMMLNfVw85GtsnMicDWQrNYMdhlk4GjHy+bAgUzbhUYo43Yj/hRp/Dk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 00:05:16 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 00:05:16 +0000
Message-ID: <46bd545d-6a90-fb51-3beb-dc942f9609af@oracle.com>
Date: Wed, 16 Aug 2023 17:05:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
 <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
 <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::25) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d299b98-4db2-46e8-22e1-08db9eb5a248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuFcQCCB11ksQ+MKPKgdsCcu4yt4LH6B+88JjDHqb7l85w4dO2Mkqp3wwxhJ5nfD28KuurJMhkKzr6tYhUwscXDld2bR+4L4ectwMAoZ25CjgEMfmI6jZf7+ADLr3dPiOsCw2spDr0vOyfrvwr+xcN+6xNMIwInl7dAGdv4svYE2glzV3mAJ4O/iYWrGbAjjB5Yt1+c0xP3PzlO6IitiMpAM7Ejn3OLeW8xmGuNVe3OSRJ+Ow0xgOUdYQXJKCtcwrXmrEsPKkFx2mBXRokcyRuJHu4sJhlb2RoLGJD1rmAmwvMIeStNlN/cP7wWogyolO4GZ9jUyhTCqEih9Y1e7sUMZzHjlYPPp4nXmAbE8ZErvlN2ZDje5BNQ5KgwICKfr3EN/VRcTnVcdLnD9IJ7qnEgfEof4hayNxcuFFjLAQAph79D4diFBgoKO7nr7lZVGnhT0GQYd2UAJ1uO7Q/MrYAoGPHbx3Oja4i+JVi8olnoMyNqsnLW0f3kfCiEXIHuqaskdoEGw2HymdoL2l6vFIXT0J0iPLCo1M0Nj4JZEBqNZh1n79rRli0fcpnjTT2DzmCErFtLzgurZluK/D63UdIIJNiCGtS3G+bmP0DyHIX+Vuu7xnBUOzDIDdVDQ0J/h2+S7yj6T+JGU1WMfobBHtDUB6W0vf4QobachR5L+60mqiRaNHcUugJtYju16MdAu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(2906002)(26005)(86362001)(478600001)(36756003)(6506007)(6486002)(36916002)(2616005)(6666004)(6512007)(53546011)(31696002)(5660300002)(41300700001)(316002)(66556008)(66946007)(66476007)(6916009)(31686004)(8676002)(4326008)(8936002)(38100700002)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xRdktqTnpkYkl6a2Y0eFFrV1M0Y0FTQzQxVFBKcDNSOTRlc0ZqbC9NRERi?=
 =?utf-8?B?YkxGelNxVTNHcHJYMUk5WHRJV2xGL0hWMUZnSHpDdm9xbE1nTzNHQlhOR3BR?=
 =?utf-8?B?N1FNNHM2YzhHZzVtNDVXVmQ3MzV4aVlINC90N1k1eTZTYi81bzlGWElDN3JK?=
 =?utf-8?B?ZEhVYk5mSExHQ0RZSlVjYjJ5QWF5RUFrYnRoT3NDOTRTZVpQR0JGZ2U0dVlm?=
 =?utf-8?B?RktBS01pRFZTMWE4NE8yakpqc0d1T3VhbE9tVUowK0loUVNBcVhKMlgvYjlB?=
 =?utf-8?B?Vm9IbzB4NGRCSmZTYzRpSWdHY1E2SGZtcTV4Y2pnMG4rTER6QlVmbGNmWWpP?=
 =?utf-8?B?eXdzaFZsdEJ4eStTRkdWSXIvQSt5aEtBQy9XRnU3UW5pYTl6Z051ZDVETUYw?=
 =?utf-8?B?Q3dRaWZVY0NaMDEzeFRXSkNVTmJIY0tiS2tTODdtUTU1T0hXd2kybElGOGxT?=
 =?utf-8?B?WHlwK1FnbkcyTDNOanNCcVpJbGhxaXk5T1RqTG5BWjZyVGZjOWRhUWN4Q3py?=
 =?utf-8?B?OWdjZ3NVUnFHL1FxckdCWjZnSnIvM2NQUFc5T3FvQnJ1U0YzVVBHanZRT2xw?=
 =?utf-8?B?L1FnbUxBR3RxclArSHN3V1hFOHZNd3c3TGpDN1ZwTUNqcXdOZkpTQnBHYlhU?=
 =?utf-8?B?SDJWNVh2OVZqZDBOVFAyV0dKS1JrNjBUYS9HTVM1RG9CRG9zcEVPNGROVmxO?=
 =?utf-8?B?YzArY2pVSG13YVFTbTNtd1luUEFncStEM2owVnVVWEdzNHVWOVpTVkZ5Z3Q0?=
 =?utf-8?B?S2d1YnJ3UmdvTittWit1WUNNYjNOcW1mcEcvQlpFQmRUKzltYW9vNmhDbENy?=
 =?utf-8?B?SHBRbmt4TW5zR0VqUWk4MHc1RG1NTHpMb01PVnNzVDc1WDF4M25ieUp4Sksv?=
 =?utf-8?B?U0tuOFN4ZFFmQXAvWXU3SHNMdmlvbllIWVFqL1BUU1YrNi9OZjhsR0FjcStD?=
 =?utf-8?B?b1gxNEZOdFJRaFZGb1M3cUpYczNzc21LOTA5czhkOCtkbU45cXBsNW96ZjQ0?=
 =?utf-8?B?WTRzMk1DNlQ4M2lRcXNmeWU5N1J2TmlSNHZVZGFCZ21wdUtxTnY4V09NNm4y?=
 =?utf-8?B?UURmRFpzeGdudXl3d2RodHZBR1NXOE8vcVAxZkJDRU9OdHNMUUFnOWZKanN1?=
 =?utf-8?B?cGVpaitWZTRQckhGK3FjRXpzN2hjYUZvNTg1NEY5N09YRzkxcWxNQ2dpOGNJ?=
 =?utf-8?B?ZE5RN2JpbSt3RDQ4eElBd0RxZWhjUmpPdC8weHpSakpWdzc0b0ZIWUJvVS9C?=
 =?utf-8?B?bFV6cjh4aUZwNGpEMjRLdDJROTM5QzRXTUZQRGdQM2Y1dmJQSWtJTXdINnA1?=
 =?utf-8?B?WVZHMGM0T0NhdTJENUdZRzVBZ05GNkNEOU9pTzFlbERqWEpmWUl0c29NZXRO?=
 =?utf-8?B?dWREdmZ0RTJORlNEZWNuK05SMGdXK2NCN0VDVHp6V0tGc2dpWWVpNUp5V21S?=
 =?utf-8?B?elNuMENiRlM3L25wUnZZMFN6aXJjdEJLMUFVMFczc3NNRVB1WVN3QlIxbzI3?=
 =?utf-8?B?dVNiUnA0ZmFPc1p2MmFKdFBmbDJZSlJnYUNhVGJPa2xIbzNYR2ljVGttRm1U?=
 =?utf-8?B?TUt6WHVwaktkTDBWbEZ5UEpvQkF4SG82Y1BBRlRIcHd3YmViNDR6QkhBU08w?=
 =?utf-8?B?eGROcWNSWmI4ay9CR0NtM2RsYTd2ZnJxclQ0NDhJM0NVNnVKZEZFL2pqSFB4?=
 =?utf-8?B?NVJ6YWkrQjRUSVMreUlEdEx2dXc3MFdCKzF0aGlmVlpyRXFQZUR5eHpUUlVq?=
 =?utf-8?B?ellpaHNWV2ZjTjh4OFFZellRclRvZngrYitTemw4KzJBcFZMbUc1cG1MWkJq?=
 =?utf-8?B?TlIrRjRBaWlWaVRyNVJoQXJKQ0RLMG1yU3d0b0p3M3ZBMlI5Q1lYb3hZYndI?=
 =?utf-8?B?VnRUUWtkQUx6bnhzcXo1eXNudGUvVlNvcXE3Njd0RHUzdVZydkpQTEp2N0pn?=
 =?utf-8?B?YklaUkZjYkJnRGswZWF4a0x1TTJxRjRaNXVobHhDZGdmNWZmWG5sK0xQQ1Bq?=
 =?utf-8?B?a1JKOFAwWVRsTlVHbEp5ZDBhd0htME5rMTRPWDB3M1AwTTB4bUFYMlduQ0lw?=
 =?utf-8?B?YkdTTDRxbnFOa2tZNkdMdldNUENPVHFrZ0VlTlYyY29SUFdwdnROYnlaUW5K?=
 =?utf-8?Q?EV3jd+5VRxZSnC4F/M40Q5m+J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUUzMlF3ckJvNFJSd0ErTnphekZRK1BiTU5zcU05bDlCTUxDZnJZMmszNlJX?=
 =?utf-8?B?VVBuL3BxSUFSUmlsczJGWXFRTzBCN3M2SHgwTlU5RW11anc4b0hRRFkwYkhV?=
 =?utf-8?B?dFlNSTJiSUFSeURZZjZUYmdWdVJDMFhaeHlnbDRqQUx4WE1QcCtPdzNNeHE1?=
 =?utf-8?B?cEJaMVFzbHJRSitlTEhSRmpET3V6bmViTTRteC90UkcwMUorTzJiK01WMjR2?=
 =?utf-8?B?bnlMemgyZWYxK3lVam5IdGpuNUtVdFN3NXlVSmYxbE5pcXBJY1h5UWhZTUpV?=
 =?utf-8?B?T3psVXUySWlndFFnaDhUUWZ2WnJ3TUhkdURPUFRtdVJWZGIwMUtJZnVHci80?=
 =?utf-8?B?RzE4aWprRlhCaC8vRXg2Q3J4ZFFBYVc0LzdKeWhzNTlMdFBHTmJzYWNRYlFE?=
 =?utf-8?B?eXpSc3VxTStnNDlJQTB0QTBSTnRUL2JXTzROZWNUb2UwQ3F4eG5tV0E1bUo2?=
 =?utf-8?B?M2Y0LzF1V2hXNWVEVG51QXlicTVNakVoSWZDdkdCRGozbEhyWTlKU3hkbG9y?=
 =?utf-8?B?S0hYTTZwbjNvb0trRzE3a2VHampCRHNyVllEU1ZZbmJiYWpXUFdCdUEzWWh1?=
 =?utf-8?B?bG84SkZ0SzNSSEZPelFaR3BLTzczdG14Y3Zvc25sNFlKZm9NeTJKcWRaUkxn?=
 =?utf-8?B?eE9aRlZwR2wwTXhCcUVsem9MYzB2U3VFK2tQUXlwZUlXdGRTM1BBT3dYNllm?=
 =?utf-8?B?UmNoeTE5aWk0RTFTWEs5QXpaQkhiY0ZBU3ZFWEhST2M0enltNlZXSXhjRnJQ?=
 =?utf-8?B?V2FBWk1aR2RYdFYrcWlWUWhReVA4Rk52Ym5RMElIUWxMenk4RHRkNG5nUFU4?=
 =?utf-8?B?NlkxQVBpbHpIdEwwdCswT01zaFdnc0FLYnJucmhIMEQ0cnRSdWJLSTg0dTFh?=
 =?utf-8?B?Z0hYU2wzMmgyUkwrYkNSY0xTNU5EUHFmdUYxdXFzRjVGWEJNYVVDQitONHVB?=
 =?utf-8?B?MVdqbHgrenBaWCtGaWhuTUhzSm9VVkR6enJ3OVBHQWpnNmRWeGExaC9DR0ZW?=
 =?utf-8?B?K3FMRjk5OW1hRGx4YVk5OUp3ZFcrRFdSNDNQUkFOSVRlT0JvWk1nNUh4dGtF?=
 =?utf-8?B?QzkzcjhlQVpON0Z5VlUraHJSK1hRcnVTbEF3VElrVmdHT01IaEVYRzkwN1Fx?=
 =?utf-8?B?NDhDSUV1NUtBMjhqYlpCRW15Ryt2NjRacjZaZTliYVNLaURIbmxSYmI4R05V?=
 =?utf-8?B?MS9rU25ObnpwRUhJQUVoOFJ6d0F0U1hQYm1lRWJTSjg3RHEvWjlNLzcwRWxh?=
 =?utf-8?Q?8sz7ksr52Veumij?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d299b98-4db2-46e8-22e1-08db9eb5a248
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 00:05:16.2797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePkY+Y8zfBpX/D/1DrN+vt7rI+9ZZ9Rbkh5DqShQz3NSWkdOZeNsnAFq95NoOgpOelFEJFL4laUHj6M3RQAJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160214
X-Proofpoint-ORIG-GUID: FM3gB0iDbAVrDpGwNrHlJiU_SJIXtKnF
X-Proofpoint-GUID: FM3gB0iDbAVrDpGwNrHlJiU_SJIXtKnF
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

CgpPbiA4LzE1LzIwMjMgNjo1NSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBXZWQsIEF1ZyAx
NiwgMjAyMyBhdCAzOjQ54oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3
cm90ZToKPj4KPj4KPj4gT24gOC8xNC8yMDIzIDc6MjEgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+
PiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCA5OjQ24oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPiB3cm90ZToKPj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgaW5jbHVkZS9saW51eC92ZHBhLmgg
fCA3ICsrKysrKysKPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4+Pj4K
Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3Zk
cGEuaAo+Pj4+IGluZGV4IGRiMWIwZWEuLjNhMzg3OGQgMTAwNjQ0Cj4+Pj4gLS0tIGEvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+IEBAIC0z
MTQsNiArMzE0LDEyIEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPj4+PiAgICAgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQGlvdmE6IGlvdmEgdG8gYmUgdW5tYXBwZWQKPj4+PiAgICAg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHNpemU6IHNpemUgb2YgdGhlIGFyZWEKPj4+
PiAgICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNj
ZXNzICgwKSBvciBlcnJvciAoPCAwKQo+Pj4+ICsgKiBAcmVzZXRfbWFwOiAgICAgICAgICAgICAg
ICAgUmVzZXQgZGV2aWNlIG1lbW9yeSBtYXBwaW5nIChvcHRpb25hbCkKPj4+PiArICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5lZWRlZCBmb3IgZGV2aWNlIHRoYXQgdXNpbmcgZGV2aWNl
Cj4+Pj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGVjaWZpYyBETUEgdHJhbnNs
YXRpb24gKG9uLWNoaXAgSU9NTVUpCj4+PiBUaGlzIGV4cG9zZXMgdGhlIGRldmljZSBpbnRlcm5h
bCB0byB0aGUgdXBwZXIgbGF5ZXIgd2hpY2ggaXMgbm90IG9wdGltYWwuCj4+IE5vdCBzdXJlIHdo
YXQgZG9lcyBpdCBtZWFuIGJ5ICJkZXZpY2UgaW50ZXJuYWwiLCBidXQgdGhpcyBvcCBjYWxsYmFj
awo+PiBqdXN0IGZvbGxvd3MgZXhpc3RpbmcgY29udmVudGlvbiB0byBkZXNjcmliZSB3aGF0IHZk
cGEgcGFyZW50IHRoaXMgQVBJCj4+IHRhcmdldHMuCj4gSSBtZWFudCB0aGUgYnVzIHRyaWVzIHRv
IGhpZGUgdGhlIGRpZmZlcmVuY2VzIGFtb25nIHZlbmRvcnMuIFNvIGl0Cj4gbmVlZHMgdG8gaGlk
ZSBvbi1jaGlwIElPTU1VIHN0dWZmIHRvIHRoZSB1cHBlciBsYXllci4KPgo+IFdlIGNhbiBleHBv
c2UgdHdvIGRpbWVuc2lvbmFsIElPIG1hcHBpbmdzIG1vZGVscyBidXQgaXQgbG9va3MgbGlrZQo+
IG92ZXIgZW5naW5lZXJpbmcgZm9yIHRoaXMgaXNzdWUuIE1vcmUgYmVsb3cuCj4KPj4gICAgKiBA
c2V0X21hcDogICAgICAgICAgICAgICAgICAgIFNldCBkZXZpY2UgbWVtb3J5IG1hcHBpbmcgKG9w
dGlvbmFsKQo+PiAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIGZvciBk
ZXZpY2UgdGhhdCB1c2luZyBkZXZpY2UKPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNwZWNpZmljIERNQSB0cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4gOgo+PiA6Cj4+
ICAgICogQGRtYV9tYXA6ICAgICAgICAgICAgICAgICAgICBNYXAgYW4gYXJlYSBvZiBQQSB0byBJ
T1ZBIChvcHRpb25hbCkKPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5lZWRl
ZCBmb3IgZGV2aWNlIHRoYXQgdXNpbmcgZGV2aWNlCj4+ICAgICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzcGVjaWZpYyBETUEgdHJhbnNsYXRpb24gKG9uLWNoaXAgSU9NTVUpCj4+ICAg
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbmQgcHJlZmVycmluZyBpbmNyZW1lbnRh
bCBtYXAuCj4+IDoKPj4gOgo+PiAgICAqIEBkbWFfdW5tYXA6ICAgICAgICAgICAgICAgICAgVW5t
YXAgYW4gYXJlYSBvZiBJT1ZBIChvcHRpb25hbCBidXQKPj4gICAgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG11c3QgYmUgaW1wbGVtZW50ZWQgd2l0aCBkbWFfbWFwKQo+PiAgICAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTmVlZGVkIGZvciBkZXZpY2UgdGhhdCB1c2luZyBk
ZXZpY2UKPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWNpZmljIERNQSB0
cmFuc2xhdGlvbiAob24tY2hpcCBJT01NVSkKPj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGFuZCBwcmVmZXJyaW5nIGluY3JlbWVudGFsIHVubWFwLgo+Pgo+Pgo+Pj4gQnR3LCB3
aGF0J3MgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGlzIGFuZCBhIHNpbXBsZQo+Pj4KPj4+IHNl
dF9tYXAoTlVMTCk/Cj4+IEkgZG9uJ3QgdGhpbmsgcGFyZW50IGRyaXZlcnMgc3VwcG9ydCB0aGlz
IHRvZGF5IC0gdGhleSBjYW4gYWNjZXB0Cj4+IG5vbi1OVUxMIGlvdGxiIGNvbnRhaW5pbmcgZW1w
dHkgbWFwIGVudHJ5LCBidXQgbm90IGEgTlVMTCBpb3RsYi4gVGhlCj4+IGJlaGF2aW9yIGlzIHVu
ZGVmaW5lZCBvciBpdCBldmVuIGNhdXNlcyBwYW5pYyB3aGVuIGEgTlVMTCBpb3RsYiBpcwo+PiBw
YXNzZWQgaW4uCj4gV2UgY2FuIGRvIHRoaXMgc2ltcGxlIGNoYW5nZSBpZiBpdCBjYW4gd29yay4K
SWYgd2UgZ28gd2l0aCBzZXR0aW5nIHVwIDE6MSBETUEgbWFwcGluZyBhdCB2aXJ0aW8tdmRwYSAu
cHJvYmUoKSBhbmQgCnRlYXJpbmcgaXQgZG93biBhdCAucmVsZWFzZSgpLCBwZXJoYXBzIHNldF9t
YXAoTlVMTCkgaXMgbm90IHN1ZmZpY2llbnQuCj4KPj4gICBGdXJ0aGVyIHRoaXMgZG9lc24ndCB3
b3JrIHdpdGggLmRtYV9tYXAgcGFyZW50IGRyaXZlcnMuCj4gUHJvYmFibHksIGJ1dCBJJ2QgcmVt
b3ZlIGRtYV9tYXAgYXMgaXQgZG9lc24ndCBoYXZlIGFueSByZWFsIHVzZXJzCj4gZXhjZXB0IGZv
ciB0aGUgc2ltdWxhdG9yLgpPSywgYXQgYSBwb2ludCB0aGVyZSB3YXMgc3VnZ2VzdGlvbiB0byBn
ZXQgdGhpcyBpbmNyZW1lbnRhbCBBUEkgZXh0ZW5kZWQgCnRvIHN1cHBvcnQgYmF0Y2hpbmcgdG8g
YmUgaW4gcGFyIHdpdGggb3IgZXZlbiByZXBsYWNlIC5zZXRfbWFwLCBub3Qgc3VyZSAKaWYgaXQn
cyB0b28gc29vbiB0byBjb25jbHVkZS4gQnV0IEknbSBva2F5IHdpdGggdGhlIHJlbW92YWwgaWYg
bmVlZCBiZS4KPgo+PiBUaGUgcmVhc29uIHdoeSBhIG5ldyBvcCBpcyBuZWVkZWQgb3IgYmV0dGVy
IGlzIGJlY2F1c2UgaXQgYWxsb3dzCj4+IHVzZXJzcGFjZSB0byB0ZWxsIGFwYXJ0IGRpZmZlcmVu
dCByZXNldCBiZWhhdmlvciBmcm9tIHRoZSBvbGRlciBrZXJuZWwKPj4gKHZpYSB0aGUgRl9JT1RM
Ql9QRVJTSVNUIGZlYXR1cmUgYml0IGluIHBhdGNoIDQpLCB3aGlsZSB0aGlzIGJlaGF2aW9yCj4+
IGNvdWxkIHZhcnkgYmV0d2VlbiBwYXJlbnQgZHJpdmVycy4KPiBJJ20gb2sgd2l0aCBhIG5ldyBm
ZWF0dXJlIGZsYWcsIGJ1dCB3ZSBuZWVkIHRvIGZpcnN0IHNlZWsgYSB3YXkgdG8KPiByZXVzZSB0
aGUgZXhpc3RpbmcgQVBJLgpBIGZlYXR1cmUgZmxhZyBpcyBuZWVkZWQgYW55d2F5LiBJJ20gZmlu
ZSB3aXRoIHJldXNpbmcgYnV0IGd1ZXNzIEknZCAKd2FudCB0byBjb252ZXJnZSBvbiB0aGUgZGly
ZWN0aW9uIGZpcnN0LgoKVGhhbmtzLAotU2l3ZWkKPgo+IFRoYW5rcwo+Cj4+IFJlZ2FyZHMsCj4+
IC1TaXdlaQo+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBAYXNpZDogYWRkcmVzcyBzcGFjZSBpZGVudGlmaWVyCj4+Pj4gKyAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8
IDApCj4+Pj4gICAgICogQGdldF92cV9kbWFfZGV2OiAgICAgICAgICAgIEdldCB0aGUgZG1hIGRl
dmljZSBmb3IgYSBzcGVjaWZpYwo+Pj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2aXJ0cXVldWUgKG9wdGlvbmFsKQo+Pj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBAdmRldjogdmRwYSBkZXZpY2UKPj4+PiBAQCAtMzkwLDYgKzM5Niw3IEBAIHN0cnVjdCB2
ZHBhX2NvbmZpZ19vcHMgewo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgaW92YSwg
dTY0IHNpemUsIHU2NCBwYSwgdTMyIHBlcm0sIHZvaWQgKm9wYXF1ZSk7Cj4+Pj4gICAgICAgICAg
IGludCAoKmRtYV91bm1hcCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQg
YXNpZCwKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgaW92YSwgdTY0IHNpemUp
Owo+Pj4+ICsgICAgICAgaW50ICgqcmVzZXRfbWFwKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYs
IHVuc2lnbmVkIGludCBhc2lkKTsKPj4+PiAgICAgICAgICAgaW50ICgqc2V0X2dyb3VwX2FzaWQp
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGdyb3VwLAo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFzaWQpOwo+Pj4+ICAgICAg
ICAgICBzdHJ1Y3QgZGV2aWNlICooKmdldF92cV9kbWFfZGV2KShzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkZXYsIHUxNiBpZHgpOwo+Pj4+IC0tCj4+Pj4gMS44LjMuMQo+Pj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
