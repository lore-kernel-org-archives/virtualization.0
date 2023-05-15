Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE223C7EE24
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 22:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DE0961528;
	Mon, 15 May 2023 22:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DE0961528
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=TyLgZXlN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=v5+c3mzo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aRtTZgO389MB; Mon, 15 May 2023 22:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4D46F613AF;
	Mon, 15 May 2023 22:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D46F613AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25089C0037;
	Mon, 15 May 2023 22:23:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76098C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39175613AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39175613AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvSP8MGyhinY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D55E360B6F
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D55E360B6F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 22:23:40 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FJsNZe031483; Mon, 15 May 2023 22:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vlzLv6gsp9T2zRS7Zq6uiXBFgIPV6c3B6mh4h0Zn1zg=;
 b=TyLgZXlNcLOlhUDKEtGseuV+hCx8KmOPPalLd4qIULbyFIeAxSqAkW+Q9FTaVUZWMg3Q
 Dn5LfgVY/D923YDbHBNT1MRiHiuvpE45Q6Q5W/JFogDyi0kbp5dYImPAjHAIbgBJb9ZQ
 z7BSO1hwxesIScWIRzKmIGPsCtW6dPHi/43eDFf2zw27FMF6WY+cYrokDJnyRcNe2rX4
 xUXS3fhOYseW6FxXUqPyI0h4snrwt2AwXvfgKCIHw7k66mP0LEJM6Yzz2ExaIzXxJKC7
 pdFIVpmBMKI7WQwk+bRaEToMIx10iZPxCBlqFx5uvFR4ocoRvWRo2UKRyIU2T3Y5UXR4 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1521dqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 22:23:23 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34FM1n6e038886; Mon, 15 May 2023 22:23:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10998g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 22:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPpPpr3iA/mpsZISfeNSGAfQAg5sdvmK8m2juU+p/rnI+diBCNGJOFkF7J29kd4mY/sS7R6YKplYw5E6UdJlzNftDvPd9vF7JolFTJx1IEPF57Mm1Y2X4t2V1lmyl34geOnhpWi/gAmA422BjlJZNpKfo+fnwHX07E17rQohWz/BOno+sUXvtIAW5Uso51K7NC7E/eJ/ZYhZYrS5Js+Fs1+q/awu55JT8vYoKsNVyIYvgxrhh/mTVsWoWFCt8scSBTcEMGfeTXZ/lPb0pza7JDicIC0jBAHlsV+7EcMwVckFwc1T2j7RrcDX77SfCk2Yy+eAh+vX7UbrPHRIRADGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlzLv6gsp9T2zRS7Zq6uiXBFgIPV6c3B6mh4h0Zn1zg=;
 b=UsrhLJltT33IrW5rytLDS5qceO7H34wjxPYkH7owJAq11wXbj/kQaYKDKhdcsvf9l+Joc6BpdCk0Yltf4tUvc1dJAjWdTneKeG0J+F4jGi8qvYTbe21hSnDtsvcSvdnwj9EbU7vRowGhpPV3SWAq2Oib7e1kWzU3NMjxaj9eUWb8DpCCCe9NGplDBb2F/GGqmGIe+Ts04fvOA4qlMOqE5U9BjzSCBAotPQhn4yT+Y8LqHiI4KyR+dcBAW6qe4FW7E2OFu8xXNkKISeQDFVQoSZk8ioc+mjfYl+srChm/jhL5I/Dfm/UjI/NVK5bBkUJspkjViGikAwsppRWPle3hlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlzLv6gsp9T2zRS7Zq6uiXBFgIPV6c3B6mh4h0Zn1zg=;
 b=v5+c3mzotKF5ayDYMGHsrAXuiJAWE0v7mUSrDfP7WeZ+55oauvxXpfRnjH3HtWd+PYJ5E0tyPGiHUuC9U6UfT3ARNGCUc4POD+xZqqZjD+UBs9nOLxxrhXd/oGARaeta12BMdufne6WlJk3bZu9B0R1QsNMSuwT8X1gkL1zFJ6Q=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by IA1PR10MB7142.namprd10.prod.outlook.com (2603:10b6:208:3f4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 22:23:15 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 22:23:14 +0000
Message-ID: <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
Date: Mon, 15 May 2023 17:23:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
X-ClientProxiedBy: DM6PR06CA0080.namprd06.prod.outlook.com
 (2603:10b6:5:336::13) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|IA1PR10MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ca3ead-fa3d-4add-cfda-08db5592f9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sWe8g20k1fFPQz/tP6PfF8MsXF2VptYsQOYZ0LuoPFPny7017N9I0fPH/2Y5/wghYUK0IZttKVnuTnDFTAJXh2qlrpWSEK3U9N6E+PWnJkR2a9oc3LGJV6B+VS0oFWnbtPg2geQ1hWKpEkc70aYoq+AR0EDGNuSiJ/lNJsPSEulWBUESGLuohDby2U5k90fNRotodZw8fgvr3haigI4vJIx2X+flSYTSAv6K8YtmTtdznBnpo/zLjk1Zw53UyOAopjgf7ItDNo+VoHKwVRqy4/2pAZJVd/UytLA7/tHJSCOtu3Ah4Es5LNAb2jWczcclSMsYwm6/Jm+XFmtJVZgVJYCnUPSM8NhRngLxevW5ko+Fj9nNSDuhlyGqfrUAqCuWq7p85L1L8oMz1vuuVthHKRi7a3+wVGt/nNS4zoGdgj7gxVYic7qQWIaXvyci+JufGWE/qrNzyhjUII83O29bprG1YGbaz+lNpE3yRDJVmviiHchAJO90Z5E2zSInAuGVnG8vMVm0iqRRig8eK/8sTgG6VwohunLhZJsKeogq+lvekGhXFL52Dt4l6u8Drhj74fv+PV8Ta0SZZVd88R2+NMYDnlaZJ8QeNYSfEvivu1/4d1y5/4d/5WcTvuuTlvkSF/P9yfC1M5BooA1Z7xxzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(36756003)(110136005)(54906003)(8936002)(8676002)(478600001)(316002)(66556008)(66946007)(66476007)(38100700002)(41300700001)(4326008)(7416002)(5660300002)(2906002)(31696002)(26005)(53546011)(6506007)(6512007)(86362001)(186003)(31686004)(83380400001)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anQwM3ZERGdhcDI1dm1tc1NCVGV2WXlnNjVaUmtWb3Q2Q0pzVjVaSEhVOFJ4?=
 =?utf-8?B?cmJTM1l1NHRLdCtNMnBpSFNXWGlQMXBPRGlsWDFaeHhGTGNma0l1WEh3ZWZx?=
 =?utf-8?B?dHk5L0lDV0dHSUljMmtidC9hM3F5dDVoMmcvbm1hSkxtaU03UkFlODhhKzBZ?=
 =?utf-8?B?cEs3bllhcmdYdElkOWUwVGZjMlRLeFZ4MFp3QS9jcHhxUDdkckJiblQ1QW9r?=
 =?utf-8?B?bjg3aXN4OEdTenZZTDRiRVMrSkFKUEZTQkw3THZQYnRUV1lwMjREYWZtUXBn?=
 =?utf-8?B?Q09FL2FZZWtWRlcxaWMyZENQZEVzdWRhR0pxbzRjWmxrOHVuQW0wb1N4QXpS?=
 =?utf-8?B?WUhWRG00K20rZHdDYy9wWHBPMk5UbjNNVUxSQ2g4RDJXdlcwMEtrTGhIbVlS?=
 =?utf-8?B?aE1pV0RUOU1JeU1OcmxaWVdyN0xCblg5bUtBalpzWVFGMUlybWwwelJvdm42?=
 =?utf-8?B?S2Q2d2djZ2d4TDlOMjd5aHdWSVRNK3R2NUlnRldSaFAvMFRVZ24wL1Z3R21v?=
 =?utf-8?B?SERWYWZ2ZnZlN0xWUGhZNG4ybHhSZzEzdHdCcjBWUGVNT0UxWkpLbkxLU1lh?=
 =?utf-8?B?azJ0clVEa1UxSVU0cXY1WmVCb2c5SFR6RVJQVmlVRDdCcHROVDNoUlcxRk1E?=
 =?utf-8?B?QXBBSDlWZ3ZCK1VNM0hMVGtTeTk2a2I3ekR2S2x1bGwyYmF4OUFBQ3orVHlk?=
 =?utf-8?B?QlYybFFTZ2RJNmtVRHErVDN4UFZDc3dWcHFOdU9lME1OeUlSQTNJWEhzQmda?=
 =?utf-8?B?K2huY0lNNC9LbnBTRHFSTlQ0L0NCbEE5dXI4RlBKTFo0UFhJUUpEYVdaUkNY?=
 =?utf-8?B?Z25KN24zTjlTN0pXL0hsWnJlWkZyb3hkNTNGVmh3R3VYRG14U3BQcDF4ODRG?=
 =?utf-8?B?bklMbXdLMEF2TWNXdW9mSVk0YU5HMzhzRFVwZDlYSk5sRGFad2gyY0FNYURO?=
 =?utf-8?B?dEVvaURzMmdnd2dqS3dsWUIvTGpWOTRmS091K0tuamFVQTUydlpPMEt6aWZq?=
 =?utf-8?B?M0c1R1dHVnJXV3pFeC9YSGFHTTJtY2pVWDBHVmEwUEE4N1NlTFJXMjZuc2lU?=
 =?utf-8?B?TElrdkM3YXJkb1NadlVCUnd6Mkc4WTF4b0kyNEJSS0g0ajB1RGtHdG1UR0JR?=
 =?utf-8?B?V0RYN2lTTURKUzVLaWVGNmwxZ0ErMUNkb0ptTE44SnRvdjZua2RIZU5sdUE0?=
 =?utf-8?B?cDQvK1R6ckFRL2hiSW5lNldjOXkvSDIrb3JDWnFXNFliWGJ5QkI2NzhWdGxP?=
 =?utf-8?B?b2RvdlYxbGF3Vmt0VTVGQ3o3N3NneHFmbFhqWEF2RmxweUpFTWJoNG9mNmR2?=
 =?utf-8?B?ZTFEem0xZVE5UksxaDJHdjVJMUNoQ1Fwcjk0Ti9HbC91dWcwU2VJSUNyc1ZX?=
 =?utf-8?B?THRCdWV3M1dGRi9BamZ6SGhJMnNwUG82WG9QMUozZStxeFA5OTJNc3EyR0Jv?=
 =?utf-8?B?QTkyM1B4MlJmSjBPU3JqUXFtOUwvcHRGbkFKb01EMWpDZ1NRL01zVWIrcjdY?=
 =?utf-8?B?U2pkcHpZcThER1VxL2RoSjBiN01EZ1pvSnYzYkZyNTgrVjFmSGhjQ203bzdB?=
 =?utf-8?B?M1pVN1ZyUGtVNTdMTEdWWjJRaXZvY3Z4WXA4WllyK3A1SWNUaU95VUhvWFhV?=
 =?utf-8?B?T3Q0ZE51Vnc5eHVhMngwTkdkb3JPdXZsdmpRa1drYk9tb0VkRGkzR0EyUUQx?=
 =?utf-8?B?MlFpSzNYbytFa0F6b01wNVZtRnFzeVNoRWJhTWQyTHNIdkhYSEh0SzhBUXNK?=
 =?utf-8?B?R3V2U2FHek1zTUhHL0FTTGhueTVEcnZkTDIwZldLaDhWdTFYSko3bExjSzRY?=
 =?utf-8?B?MjZFTlBYdzIyK2Fsem12dGw3T3NhS2pYNmxBTUpOWGJpUzN1ZGc5Rmc0c2hv?=
 =?utf-8?B?TVh0K2FwMnlRMWtYTGdIcXF2bUxnalhkZHJ0U2w1RkVUV3hYZWF1SmU4SnV3?=
 =?utf-8?B?OXVvREF3eW54bVQ2Mi9EM0tKTEttRXBPMUJQY2d6QVFRUU9zSEVRWG4xblJp?=
 =?utf-8?B?NEFuTWhpMDRBTVoydXB2NTByWUR5N2R1T21Kb0JuWkxGVlAzOTE3TlN0ZVZa?=
 =?utf-8?B?SHVCT1RCSUMrQWVYUTQyRHN2aTB4SENSNXVaWW5xY1RHRUpsdVB1UTNYUlZB?=
 =?utf-8?B?ZHBDeXU5Yk1ZNzl4Q2JabDFuOWUrQ3VsZE5jVXpvOURpZi9RcDNhcEVXdERK?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q1RxYWZJTnhHa2U0SlJaTEd0TEpJN0ozblFZVmtUN3kza1lBaFRsazVoZWcy?=
 =?utf-8?B?TUIwcExwTndYdUhCeDdZc0l3dkM3TW5PU0duNGptUm0vTWQvVlZ6bEpGTXcv?=
 =?utf-8?B?SFNYZ0cvSHU5anJqRTV1ZnVHNEsvekpOMFNDMTNlc2VacUtDakNwTDBCRzVN?=
 =?utf-8?B?ZDFXMHFRRno2dkp1WXZjMk1zd3JsYTQ2aTVxWElCNC9JSUFER3VBUUtubHdm?=
 =?utf-8?B?WXg4eVVwbWhzZVg5WkZpU0F4M1Nza0xQNnZ5RU1WT3BaRUJYZjdaOEFSc21D?=
 =?utf-8?B?eThROWcrVVoxVW9pdy9RQXUxZHVldldXTWhCeEV5bWdvSTJkSjlCRnNON2VP?=
 =?utf-8?B?NlZBMU56YXJpa3pQMERnYUU5eTdaeU40enowczd1QkJmVnRBOEJ1Ni8rZHVx?=
 =?utf-8?B?OTR4VE9jRlkwcTBOYkU3d2JvdlNlSkg0ay9Ca0J3YWI1UExRVi96SEJoSXZR?=
 =?utf-8?B?VCtyVXQ5R0xMRDd3T2QzbjRvOWtSTnFZSzl4cUxTdExuSkIyR21xSHRuYUhs?=
 =?utf-8?B?U1B6OStvS0VzSDZ2bkYrVUpYU0hmZ0d6RkNKRmM1aWo2MFZFcFgzYTk0TXBE?=
 =?utf-8?B?Umk2UktXU0tMbUVxL3Y5NmdyeW8zcnFLVHVKRE5BNXY1eHN3N3plRTdRcldL?=
 =?utf-8?B?L1QxN3NINmQ4K0hyRVYzZ2xnT2ZXMVkrUkJ4ckwyRUVJdlYrdkpFSlJkRkVu?=
 =?utf-8?B?aEZQdVJjSmMxOTRQZThHcGRuVG9WSkxNbXR4SXFTVU42ZTR0cml4dlVZci9y?=
 =?utf-8?B?ZDJPODFsRjUwckJRaUJlaHU0TGN5V0xGaVArSTBRaGJMZFVjVmU0KzRVc0JT?=
 =?utf-8?B?SlZnUk9GcWZuakhFVUNQSmdXaEF4VTZIK2RPdkRINE5VN2NqWWNvQWE1NnR1?=
 =?utf-8?B?UGJOaUxkc2xLZTlJQm5jR1RpVjZabm5USW1IMHBxSjRxRlk2YnBqRDN0cE9v?=
 =?utf-8?B?dzFoSVlFNzR5OUY4WXAwZWFleHhSL3RwRUtBUlNSKzVPa1VXMy9GNUtzODRI?=
 =?utf-8?B?OW11RSsyWk5ucDErNW9NcTA0Q2lmT0QxRHBhYWovL3diVWZzNUliQlYvaXVN?=
 =?utf-8?B?REV6aUlranFPZ1pZZ3VMcTllOG5qeHQ3c25JcFdLS3QxSzNjYURhVnV2SXpT?=
 =?utf-8?B?UTlPRkROVVdrZmMreW84ejBoK2phQ0VLd2hUVVhoc1diZHZjVlRUMytZM3FB?=
 =?utf-8?B?bUQ4bW1QbzZDTDJjVXJRUHV2NjZxS2dCbTdGNlRrQ1JualBOY1VJaksydVlT?=
 =?utf-8?B?NXBLYm5oTlhINzkzTVh3ZlJ0TlhjZWRoMDE5VnV3RUJBNzM4bldGR3VnUTFG?=
 =?utf-8?B?WVpGTE1TMWVGd3VaOFhMb1JjZVpQSzA4eEZTZXNNclpDQVpHL2dvczJIWHpF?=
 =?utf-8?B?dkZjbmljU3dIa1Q5TzFhV0graG5wc1R4eXdBSndiUllSeWk5OHNaMjJRZld6?=
 =?utf-8?B?clNPcGEraFZtUUI1Q3NNa2p3UDE2SHgvaFJDdlNvUzkwMU5FZG4vdVFObkF1?=
 =?utf-8?B?aTJZWDhxZWErSEdNMGhFOURyQXF2R3BrOGx0Z0xQZE1oN0NDK00xTkpDanNa?=
 =?utf-8?B?cjd2Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca3ead-fa3d-4add-cfda-08db5592f9aa
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 22:23:14.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcn/f5Zp6p2NSEtDdLgsjk7VITcVKCZ3Dzdws3a3h+Q/w1zWOJ6PLXoAxaV3vdOQBSx/Oq1WXttYhj8/2eNoZQjERnbv/H3HRivo+pP37E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=815
 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150183
X-Proofpoint-GUID: qKBO2LwOEaFLHCuY-BZAXKZ-MupojDxj
X-Proofpoint-ORIG-GUID: qKBO2LwOEaFLHCuY-BZAXKZ-MupojDxj
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

T24gNS8xNS8yMyAxMDo0NCBBTSwgTGludXMgVG9ydmFsZHMgd3JvdGU6Cj4gT24gTW9uLCBNYXkg
MTUsIDIwMjMgYXQgNzoyM+KAr0FNIENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Pgo+PiBTbyBJIHRoaW5rIHdlIHdpbGwgYmUgYWJsZSB0byBhZGRyZXNzICgx
KSBhbmQgKDIpIGJ5IG1ha2luZyB2aG9zdCB0YXNrcwo+PiBwcm9wZXIgdGhyZWFkcyBhbmQgYmxv
Y2tpbmcgZXZlcnkgc2lnbmFsIGV4Y2VwdCBmb3IgU0lHS0lMTCBhbmQgU0lHU1RPUAo+PiBhbmQg
dGhlbiBoYXZpbmcgdmhvc3QgaGFuZGxlIGdldF9zaWduYWwoKSAtIGFzIHlvdSBtZW50aW9uZWQg
LSB0aGUgc2FtZQo+PiB3YXkgaW8gdXJpbmcgYWxyZWFkeSBkb2VzLiBXZSBzaG91bGQgYWxzbyBy
ZW1vdmUgdGhlIGluZ29yZV9zaWduYWxzCj4+IHRoaW5nIGNvbXBsZXRlbHkgaW1oby4gSSBkb24n
dCB0aGluayB3ZSBldmVyIHdhbnQgdG8gZG8gdGhpcyB3aXRoIHVzZXIKPj4gd29ya2Vycy4KPiAK
PiBSaWdodC4gVGhhdCdzIHdoYXQgSU9fVVJJTkcgZG9lczoKPiAKPiAgICAgICAgIGlmIChhcmdz
LT5pb190aHJlYWQpIHsKPiAgICAgICAgICAgICAgICAgLyoKPiAgICAgICAgICAgICAgICAgICog
TWFyayB1cyBhbiBJTyB3b3JrZXIsIGFuZCBibG9jayBhbnkgc2lnbmFsIHRoYXQgaXNuJ3QKPiAg
ICAgICAgICAgICAgICAgICogZmF0YWwgb3IgU1RPUAo+ICAgICAgICAgICAgICAgICAgKi8KPiAg
ICAgICAgICAgICAgICAgcC0+ZmxhZ3MgfD0gUEZfSU9fV09SS0VSOwo+ICAgICAgICAgICAgICAg
ICBzaWdpbml0c2V0aW52KCZwLT5ibG9ja2VkLCBzaWdtYXNrKFNJR0tJTEwpfHNpZ21hc2soU0lH
U1RPUCkpOwo+ICAgICAgICAgfQo+IAo+IGFuZCBJIHJlYWxseSB0aGluayB0aGF0IHZob3N0IHNo
b3VsZCBiYXNpY2FsbHkgZG8gZXhhY3RseSB3aGF0IGlvX3VyaW5nIGRvZXMuCj4gCj4gTm90IGJl
Y2F1c2UgaW9fdXJpbmcgZnVuZGFtZW50YWxseSBnb3QgdGhpcyByaWdodCAtIGJ1dCBzaW1wbHkg
YmVjYXVzZQo+IGlvX3VyaW5nIGhhZCBhbG1vc3QgYWxsIHRoZSBzYW1lIGJ1Z3MgKGFuZCB0aGVu
IHNvbWUpLCBhbmQgd2hhdCB0aGUKPiBpb191cmluZyB3b3JrZXIgdGhyZWFkcyBlbmRlZCB1cCBk
b2luZyB3YXMgdG8gYmFzaWNhbGx5IHpvb20gaW4gb24KPiAidGhpcyB3b3JrcyIuCj4gCj4gQW5k
IGl0IHpvb21lZCBpbiBvbiBpdCBsYXJnZWx5IGJ5IGp1c3QgZ29pbmcgZm9yICJtYWtlIGl0IGxv
b2sgYXMgbXVjaAo+IGFzIHBvc3NpYmxlIGFzIGEgcmVhbCB1c2VyIHRocmVhZCIsIGJlY2F1c2Ug
ZXZlcnkgdGltZSB0aGUga2VybmVsCj4gdGhyZWFkIGRpZCBzb21ldGhpbmcgZGlmZmVyZW50LCBp
dCBqdXN0IGNhdXNlZCBwcm9ibGVtcy4KPiAKPiBTbyBJIHRoaW5rIHRoZSBwYXRjaCBzaG91bGQg
anVzdCBsb29rIHNvbWV0aGluZyBsaWtlIHRoZSBhdHRhY2hlZC4KPiBNaWtlLCBjYW4geW91IHRl
c3QgdGhpcyBvbiB3aGF0ZXZlciB2aG9zdCB0ZXN0LXN1aXRlPwoKSSB0cmllZCB0aGF0IGFwcHJv
YWNoIGFscmVhZHkgYW5kIGl0IGRvZXNuJ3Qgd29yayBiZWNhdXNlIGlvX3VyaW5nIGFuZCB2aG9z
dApkaWZmZXIgaW4gdGhhdCB2aG9zdCBkcml2ZXJzIGltcGxlbWVudCBhIGRldmljZSB3aGVyZSBl
YWNoIGRldmljZSBoYXMgYSB2aG9zdF90YXNrCmFuZCB0aGUgZHJpdmVycyBoYXZlIGEgZmlsZV9v
cGVyYXRpb25zIGZvciB0aGUgZGV2aWNlLiBXaGVuIHRoZSB2aG9zdF90YXNrJ3MKcGFyZW50IGdl
dHMgc2lnbmFsIGxpa2UgU0lHS0lMTCwgdGhlbiBpdCB3aWxsIGV4aXQgYW5kIGNhbGwgaW50byB0
aGUgdmhvc3QKZHJpdmVyJ3MgZmlsZV9vcGVyYXRpb25zLT5yZWxlYXNlIGZ1bmN0aW9uLiBBdCB0
aGlzIHRpbWUsIHdlIG5lZWQgdG8gZG8gY2xlYW51cApsaWtlIGZsdXNoIHRoZSBkZXZpY2Ugd2hp
Y2ggdXNlcyB0aGUgdmhvc3RfdGFzay4gVGhlcmUgaXMgYWxzbyB0aGUgY2FzZSB3aGVyZSBpZgp0
aGUgdmhvc3RfdGFzayBnZXRzIGEgU0lHS0lMTCwgd2UgY2FuIGp1c3QgZXhpdCBmcm9tIHVuZGVy
IHRoZSB2aG9zdCBsYXllci4KCmlvX3VyaW5nIGhhcyBhIHNpbWlsYXIgY2xlYW51cCBpc3N1ZSB3
aGVyZSB0aGUgY29yZSBrZXJuZWwgY29kZSBjYW4ndCBkbwpleGl0IGZvciB0aGUgaW8gdGhyZWFk
LCBidXQgaXQgb25seSBoYXMgdGhhdCBvbmUgcG9pbnQgdGhhdCBpdCBoYXMgdG8gd29ycnkKYWJv
dXQgc28gd2hlbiBpdCBnZXRzIFNJR0tJTEwgaXQgY2FuIGNsZWFuIGl0c2VsZiB1cCB0aGVuIGV4
aXQuCgpTbyB0aGUgcGF0Y2ggaW4gdGhlIG90aGVyIG1haWwgaGl0cyBhbiBpc3N1ZSB3aGVyZSB2
aG9zdF93b3JrZXIoKSBjYW4gZ2V0IGludG8KYSB0aWdodCBsb29wIGhhbW1lcmluZyB0aGUgQ1BV
IGR1ZSB0byB0aGUgcGVuZGluZyBTSUdLSUxMIHNpZ25hbC4KClRoZSB2aG9zdCBsYXllciByZWFs
bHkgZG9lc24ndCB3YW50IGFueSBzaWduYWxzIGFuZCB3YW50cyB0byB3b3JrIGxpa2Uga3RocmVh
ZHMKZm9yIHRoYXQgY2FzZS4gVG8gbWFrZSBpdCByZWFsbHkgc2ltcGxlIGNhbiB3ZSBkbyBzb21l
dGhpbmcgbGlrZSB0aGlzIHdoZXJlIGl0CnNlcGFyYXRlcyB1c2VyIGFuZCBpbyB3b3JrZXIgYmVo
YXZpb3Igd2hlcmUgdGhlIG1ham9yIGRpZmYgaXMgaG93IHRoZXkgaGFuZGxlCnNpZ25hbHMgYW5k
IGV4aXQuIEkgYWxzbyBpbmNsdWRlZCBhIGZpeCBmb3IgdGhlIGZyZWV6ZSBjYXNlOgoKCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2hlZC90YXNrLmggYi9pbmNsdWRlL2xpbnV4L3NjaGVk
L3Rhc2suaAppbmRleCA1MzdjYmY5YTJhZGUuLmUwZjVhYzkwYTIyOCAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9zY2hlZC90YXNrLmgKKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC90YXNrLmgK
QEAgLTI5LDcgKzI5LDYgQEAgc3RydWN0IGtlcm5lbF9jbG9uZV9hcmdzIHsKIAl1MzIgaW9fdGhy
ZWFkOjE7CiAJdTMyIHVzZXJfd29ya2VyOjE7CiAJdTMyIG5vX2ZpbGVzOjE7Ci0JdTMyIGlnbm9y
ZV9zaWduYWxzOjE7CiAJdW5zaWduZWQgbG9uZyBzdGFjazsKIAl1bnNpZ25lZCBsb25nIHN0YWNr
X3NpemU7CiAJdW5zaWduZWQgbG9uZyB0bHM7CmRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIv
a2VybmVsL2ZvcmsuYwppbmRleCBlZDRlMDFkYWNjYWEuLmZkMjk3MGI1OThiMiAxMDA2NDQKLS0t
IGEva2VybmVsL2ZvcmsuYworKysgYi9rZXJuZWwvZm9yay5jCkBAIC0yMzM2LDggKzIzMzYsMTUg
QEAgX19sYXRlbnRfZW50cm9weSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNvcHlfcHJvY2VzcygKIAlw
LT5mbGFncyAmPSB+UEZfS1RIUkVBRDsKIAlpZiAoYXJncy0+a3RocmVhZCkKIAkJcC0+ZmxhZ3Mg
fD0gUEZfS1RIUkVBRDsKLQlpZiAoYXJncy0+dXNlcl93b3JrZXIpCisJaWYgKGFyZ3MtPnVzZXJf
d29ya2VyKSB7CisJCS8qCisJCSAqIFVzZXIgd29ya2VyIGFyZSBzaW1pbGFyIHRvIGlvX3RocmVh
ZHMgYnV0IHRoZXkgZG8gbm90CisJCSAqIHN1cHBvcnQgc2lnbmFscyBhbmQgY2xlYW51cCBpcyBk
cml2ZW4gdmlhIGFub3RoZXIga2VybmVsCisJCSAqIGludGVyZmFjZSBzbyBldmVuIFNJR0tJTEwg
aXMgYmxvY2tlZC4KKwkJICovCiAJCXAtPmZsYWdzIHw9IFBGX1VTRVJfV09SS0VSOworCQlzaWdp
bml0c2V0aW52KCZwLT5ibG9ja2VkLCAwKTsKKwl9CiAJaWYgKGFyZ3MtPmlvX3RocmVhZCkgewog
CQkvKgogCQkgKiBNYXJrIHVzIGFuIElPIHdvcmtlciwgYW5kIGJsb2NrIGFueSBzaWduYWwgdGhh
dCBpc24ndApAQCAtMjUxNyw4ICsyNTI0LDggQEAgX19sYXRlbnRfZW50cm9weSBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKmNvcHlfcHJvY2VzcygKIAlpZiAocmV0dmFsKQogCQlnb3RvIGJhZF9mb3JrX2Ns
ZWFudXBfaW87CiAKLQlpZiAoYXJncy0+aWdub3JlX3NpZ25hbHMpCi0JCWlnbm9yZV9zaWduYWxz
KHApOworCWlmIChhcmdzLT51c2VyX3dvcmtlcikKKwkJcC0+ZmxhZ3MgfD0gUEZfTk9GUkVFWkU7
CiAKIAlzdGFja2xlYWtfdGFza19pbml0KHApOwogCkBAIC0yODYwLDcgKzI4NjcsNiBAQCBzdHJ1
Y3QgdGFza19zdHJ1Y3QgKmNyZWF0ZV9pb190aHJlYWQoaW50ICgqZm4pKHZvaWQgKiksIHZvaWQg
KmFyZywgaW50IG5vZGUpCiAJCS5mbgkJPSBmbiwKIAkJLmZuX2FyZwkJPSBhcmcsCiAJCS5pb190
aHJlYWQJPSAxLAotCQkudXNlcl93b3JrZXIJPSAxLAogCX07CiAKIAlyZXR1cm4gY29weV9wcm9j
ZXNzKE5VTEwsIDAsIG5vZGUsICZhcmdzKTsKZGlmZiAtLWdpdCBhL2tlcm5lbC9zaWduYWwuYyBi
L2tlcm5lbC9zaWduYWwuYwppbmRleCA4ZjYzMzBmMGU5Y2EuLmYyZjFlNWVmNDRiMiAxMDA2NDQK
LS0tIGEva2VybmVsL3NpZ25hbC5jCisrKyBiL2tlcm5lbC9zaWduYWwuYwpAQCAtOTk1LDYgKzk5
NSwxOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgd2FudHNfc2lnbmFsKGludCBzaWcsIHN0cnVjdCB0
YXNrX3N0cnVjdCAqcCkKIAlyZXR1cm4gdGFza19jdXJyKHApIHx8ICF0YXNrX3NpZ3BlbmRpbmco
cCk7CiB9CiAKK3N0YXRpYyB2b2lkIHRyeV9zZXRfcGVuZGluZ19zaWdraWxsKHN0cnVjdCB0YXNr
X3N0cnVjdCAqdCkKK3sKKwkvKgorCSAqIFVzZXIgd29ya2VycyBkb24ndCBzdXBwb3J0IHNpZ25h
bHMgYW5kIHRoZWlyIGV4aXQgaXMgZHJpdmVuIHRocm91Z2gKKwkgKiB0aGVpciBrZXJuZWwgbGF5
ZXIsIHNvIGRvIG5vdCBzZW5kIHRoZW0gU0lHS0lMTC4KKwkgKi8KKwlpZiAodC0+ZmxhZ3MgJiBQ
Rl9VU0VSX1dPUktFUikKKwkJcmV0dXJuOworCisJc2lnYWRkc2V0KCZ0LT5wZW5kaW5nLnNpZ25h
bCwgU0lHS0lMTCk7CisJc2lnbmFsX3dha2VfdXAodCwgMSk7Cit9CisKIHN0YXRpYyB2b2lkIGNv
bXBsZXRlX3NpZ25hbChpbnQgc2lnLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGVudW0gcGlkX3R5
cGUgdHlwZSkKIHsKIAlzdHJ1Y3Qgc2lnbmFsX3N0cnVjdCAqc2lnbmFsID0gcC0+c2lnbmFsOwpA
QCAtMTA1NSw4ICsxMDY4LDcgQEAgc3RhdGljIHZvaWQgY29tcGxldGVfc2lnbmFsKGludCBzaWcs
IHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgZW51bSBwaWRfdHlwZSB0eXBlKQogCQkJdCA9IHA7CiAJ
CQlkbyB7CiAJCQkJdGFza19jbGVhcl9qb2JjdGxfcGVuZGluZyh0LCBKT0JDVExfUEVORElOR19N
QVNLKTsKLQkJCQlzaWdhZGRzZXQoJnQtPnBlbmRpbmcuc2lnbmFsLCBTSUdLSUxMKTsKLQkJCQlz
aWduYWxfd2FrZV91cCh0LCAxKTsKKwkJCQl0cnlfc2V0X3BlbmRpbmdfc2lna2lsbCh0KTsKIAkJ
CX0gd2hpbGVfZWFjaF90aHJlYWQocCwgdCk7CiAJCQlyZXR1cm47CiAJCX0KQEAgLTEzNzMsOCAr
MTM4NSw3IEBAIGludCB6YXBfb3RoZXJfdGhyZWFkcyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApCiAJ
CS8qIERvbid0IGJvdGhlciB3aXRoIGFscmVhZHkgZGVhZCB0aHJlYWRzICovCiAJCWlmICh0LT5l
eGl0X3N0YXRlKQogCQkJY29udGludWU7Ci0JCXNpZ2FkZHNldCgmdC0+cGVuZGluZy5zaWduYWws
IFNJR0tJTEwpOwotCQlzaWduYWxfd2FrZV91cCh0LCAxKTsKKwkJdHJ5X3NldF9wZW5kaW5nX3Np
Z2tpbGwodCk7CiAJfQogCiAJcmV0dXJuIGNvdW50OwpkaWZmIC0tZ2l0IGEva2VybmVsL3Zob3N0
X3Rhc2suYyBiL2tlcm5lbC92aG9zdF90YXNrLmMKaW5kZXggYjdjYmQ2NmY4ODllLi4yZDhkM2Vi
YWVjNGQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC92aG9zdF90YXNrLmMKKysrIGIva2VybmVsL3Zob3N0
X3Rhc2suYwpAQCAtNzUsMTMgKzc1LDEzIEBAIHN0cnVjdCB2aG9zdF90YXNrICp2aG9zdF90YXNr
X2NyZWF0ZShpbnQgKCpmbikodm9pZCAqKSwgdm9pZCAqYXJnLAogCQkJCSAgICAgY29uc3QgY2hh
ciAqbmFtZSkKIHsKIAlzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3MgYXJncyA9IHsKLQkJLmZsYWdz
CQk9IENMT05FX0ZTIHwgQ0xPTkVfVU5UUkFDRUQgfCBDTE9ORV9WTSwKKwkJLmZsYWdzCQk9IENM
T05FX0ZTIHwgQ0xPTkVfVU5UUkFDRUQgfCBDTE9ORV9WTSB8CisJCQkJICBDTE9ORV9USFJFQUQg
fCBDTE9ORV9TSUdIQU5ELAogCQkuZXhpdF9zaWduYWwJPSAwLAogCQkuZm4JCT0gdmhvc3RfdGFz
a19mbiwKIAkJLm5hbWUJCT0gbmFtZSwKIAkJLnVzZXJfd29ya2VyCT0gMSwKIAkJLm5vX2ZpbGVz
CT0gMSwKLQkJLmlnbm9yZV9zaWduYWxzCT0gMSwKIAl9OwogCXN0cnVjdCB2aG9zdF90YXNrICp2
dHNrOwogCXN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrOwpkaWZmIC0tZ2l0IGEvbW0vdm1zY2FuLmMg
Yi9tbS92bXNjYW4uYwppbmRleCBkMjU3OTE2ZjM5ZTUuLjI1NWEyMTQ3ZTVjMSAxMDA2NDQKLS0t
IGEvbW0vdm1zY2FuLmMKKysrIGIvbW0vdm1zY2FuLmMKQEAgLTEyMDcsMTIgKzEyMDcsMTIgQEAg
dm9pZCByZWNsYWltX3Rocm90dGxlKHBnX2RhdGFfdCAqcGdkYXQsIGVudW0gdm1zY2FuX3Rocm90
dGxlX3N0YXRlIHJlYXNvbikKIAlERUZJTkVfV0FJVCh3YWl0KTsKIAogCS8qCi0JICogRG8gbm90
IHRocm90dGxlIHVzZXIgd29ya2Vycywga3RocmVhZHMgb3RoZXIgdGhhbiBrc3dhcGQgb3IKKwkg
KiBEbyBub3QgdGhyb3R0bGUgSU8vdXNlciB3b3JrZXJzLCBrdGhyZWFkcyBvdGhlciB0aGFuIGtz
d2FwZCBvcgogCSAqIHdvcmtxdWV1ZXMuIFRoZXkgbWF5IGJlIHJlcXVpcmVkIGZvciByZWNsYWlt
IHRvIG1ha2UKIAkgKiBmb3J3YXJkIHByb2dyZXNzIChlLmcuIGpvdXJuYWxsaW5nIHdvcmtxdWV1
ZXMgb3Iga3RocmVhZHMpLgogCSAqLwogCWlmICghY3VycmVudF9pc19rc3dhcGQoKSAmJgotCSAg
ICBjdXJyZW50LT5mbGFncyAmIChQRl9VU0VSX1dPUktFUnxQRl9LVEhSRUFEKSkgeworCSAgICBj
dXJyZW50LT5mbGFncyAmIChQRl9VU0VSX1dPUktFUnxQRl9JT19XT1JLRVJ8UEZfS1RIUkVBRCkp
IHsKIAkJY29uZF9yZXNjaGVkKCk7CiAJCXJldHVybjsKIAl9CgoKCgoKCgoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
