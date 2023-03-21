Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C6C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 04:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EEF44176D;
	Tue, 21 Mar 2023 04:38:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EEF44176D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=B08Fh4bW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=IbbPuhxk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id He6VPfH8i69u; Tue, 21 Mar 2023 04:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A82F40357;
	Tue, 21 Mar 2023 04:38:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A82F40357
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E2D3C0071;
	Tue, 21 Mar 2023 04:38:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98065C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72C2540AD1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72C2540AD1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=B08Fh4bW; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=IbbPuhxk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6boTfK2kYMYv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:38:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CDEF400E7
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CDEF400E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 04:38:31 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4SQc019672; Tue, 21 Mar 2023 04:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Eiz/8hwjjEOf94VDEd8aq3678OqzaV9A9yyuzEj6pJ8=;
 b=B08Fh4bWenwMcerngma74EcZI8sZ6SXV8cDXe2YaJzYwm4Jlauqpx0V5Pw8NjwH7Y6Lo
 DBimMhNdUUPxVin3mP+N+tjJfm8aTpVd3SfhAghPhjtL3wzovzsZuXV7etg6hjip23zw
 c+eNurdt5sirrxldnpQkLJFqaSUFqE5kExj5hnpbBpoS1QF7pTm3ZuSGY/cFTzC1rSL3
 t8HOugNHyP6Q9LQIiBnu9gvOF9Yf9epWK4WwLUeOWOBUzFWUR9ip8Mwg/jf1SkNTyVC7
 vxN09/Lz8CxOgc9b7PZIBKLc4m3rgAtrIr+D5Nj418O81MqALKJzRHIk2dnM9XvmHUXq Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdn45a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 04:38:30 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32L2Eck1006628; Tue, 21 Mar 2023 04:38:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3pd3r55vku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 04:38:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HID965gl263UJg7TditivtEHztYZdgRsTKKUheA9zzwVFvx8Shkpa6Ys1CAWZwH0C2pSgi2BDqdXO18NKkz13r2yKn1l5NeAQ1vaGAd/wJLdNhWx1K6xAp2zxIv/VPX99sO5K7m7Fzrl+yjYUt8P9TkDnYQp57HappEggZPW2fNGPPki/M2OPZ3XyB2Pv63GgjYLac009fcv+98sBcU2boeB02OR5BfhM2ozyeGRfsGTJH2aydfSt/Xdbvv+O0GWa3e+ItT9r3wRgt6TXZT0i4zINjDbAKk4X/eB1g5Eq7kgbzZozwo9P2YUi3cmXZIR4c+EeBDFHGgMJ+MyV3p8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eiz/8hwjjEOf94VDEd8aq3678OqzaV9A9yyuzEj6pJ8=;
 b=TlpAczcjvYs+s1CSRm+sr39qbXpgKTPTrNU2ZQLOMQEQjvwT4jKh2A34Pbj08yNL1i4qe/+UbvUeWKlump0k3o6Mh0WUqole+A09HNylIDB5XjKzcqcpejCGqum5PrGUHLSYjVbDNzyno8at8oPfsHAtdq7MjUrfBKc2cuHBHktSAWnNJRNss1TO67i/7v42a/WYIfPD0W0I1ACjDYZq5Cb2bc/bMtmzZlUeM1/cFVsqPFkMHTjMMMgtkDr9ri+ESalWJYCJBMCf/Ilvo4cVnM4c+dzbfpw73Qun71Ub/GH/zgeKV+2BnyviSe8cwpmhn7cyaP5jt7FHAlVKEME1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eiz/8hwjjEOf94VDEd8aq3678OqzaV9A9yyuzEj6pJ8=;
 b=IbbPuhxk+TTwwOeTgNRNnW0OPFhSpe6hzMTCfGBtIO/B1CqfOR7Z60E9GyfjNE3r9m23CrgZp364J7jg48+cRbF66djXA0tkKuF/OrTqCSz56hogrRs09LJz/rcIh5CY43F48BSr0W8gpFbfE00Sff4uO8TTmiSMEd9xj4RJZmc=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH2PR10MB4151.namprd10.prod.outlook.com (2603:10b6:610:aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 04:38:22 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 04:38:22 +0000
Message-ID: <9d85ebb2-47f4-bb40-590f-eca337599332@oracle.com>
Date: Mon, 20 Mar 2023 21:38:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] vdpa/mlx5: Extend driver support for new features
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@mellanox.com>
References: <20230315072802.2400337-1-elic@nvidia.com>
 <20230315072802.2400337-2-elic@nvidia.com>
 <DM8PR12MB5480F5579E6305EB3A0AA61DDCBD9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <CACGkMEu-VtMPUBRbw+NYUwB85RZQ5g_psuT-dB-V6-gYcdUdrg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEu-VtMPUBRbw+NYUwB85RZQ5g_psuT-dB-V6-gYcdUdrg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH2PR10MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 378a8908-76fe-4930-d418-08db29c619d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUzvc7/k4YxAANK5XPTQHM86uf9o+upS92PjzykCfciPLudPXGf+nDfOLimcrn9CX3y4pVPUpoxih6T1ih4NBpQx0lvU0N8KNz7TPuCneinBzA+fUagGnt1XUTCNBhH1TZd823afmhM5qYryjXyTpDHEXnJkz3CgvPKkvpItI8G0fDnUGJh1raND/WyShBn3iqPpESzoXXJaxpBpwNWr3S/BFWEnGckXymDooqdy8PkIa+972YJU1IqPHUv7vIczMnUX7K8DNj9Mtt5KVedpVBOnqWwOmUhyaNYmpXuftSye6jTmxWPDfcpL55Nz1ZNgd0egRtXY/pDibFYNBK50xlxzTaRBf/Olmg1xw6H0W2ANTo0pdAxJ5IngoT4pUhXvbpw9T1t/2fshg3COdplEwYL1NYCMCPVOLaEyvaIn8tM7nOamdOAwH6HNm+IQEKCub/kr0mREG+pRCFCkCqHu4eNLeobEC7wcy/cfumfGWnsbbIJyAY1KmhCBHHRZvYADMVp+FGFB6I43oDJ+IYidEVxYV/f7Bi/sCmdSnw9rE5gU5sZvDDFAiNxyWXaGigcIQrb3G3hetQWNg4ab7voEVL4oEJhcSLbR0AutV7Z7Kbx1GV+PDDtI7s++carf0WsrZZfFl8vLhej/xqEj0CRGU6vxj+BmkLbcIeIFuBZ56P7OMjyzJeZAIOoS5nOJ0UyxDfYP+VdVHgcu0p1n/GuiRQztmsGpfNne6fDgeOig3aA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(31686004)(2616005)(6666004)(6486002)(6506007)(53546011)(186003)(6512007)(26005)(36916002)(86362001)(38100700002)(31696002)(2906002)(478600001)(316002)(54906003)(110136005)(8676002)(66946007)(4326008)(5660300002)(41300700001)(8936002)(66476007)(66556008)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGU1T0YrbWdTamRCczhtVzZqNVdBbEV5ZXRPdW1kYWd4RGdpZGVLMVhUZWk5?=
 =?utf-8?B?NU5NZXo0R0o3T3Z0Q0hxL3ZveU9pN056anBGOEwwUGhNaFFYRFplZE9BelFj?=
 =?utf-8?B?a1JPRjdRVlJoWXIwWTZrekRUYk5CVk0xS3lGc3ZOTVk4MDBpWTJ2QjlmNk9z?=
 =?utf-8?B?MmlhekpEMlYxR0JwdFVZcW9WWVMra1duUzNTRXZGYklzNDBlajJ0SU1tZkEz?=
 =?utf-8?B?ZWI4L3pTbUY0N0k5M0lsTVZnQjNmOVRDOTVHV0RTbEp1YUhGbDFaRXl6S0NF?=
 =?utf-8?B?KytnN3lIdVBGWFpvdVgzdS9HRWpTNmF2cWlWaXdxeXRpVWFHdUxhMTJacktj?=
 =?utf-8?B?ZmJXOHo5NFpJK1hRZE4zRlVZb1pZbHNXTkc3Y3h3Zm9jSlRrek93MHlJVzZj?=
 =?utf-8?B?UmtFUVhWNHVWNUlwZ1Z0U1VHeEtmMEhCL05adHFvVWNTb3V2S1Q4WmlJVmVv?=
 =?utf-8?B?d2dFUXlTSzI2bVNER1pmSzNoUThZd1ArYTFSTThxQmsyRWFTVXo0c2xrVkEr?=
 =?utf-8?B?WC85SWRjN1AxV3djTHZBMDRpTHFMbGFWUExmQ0hKd0FmRUJQb3Q1WXZPOTA3?=
 =?utf-8?B?WFM3RTV3OEZ6bXYyNnhGc0VZU0hQOEVDOGdiRUxiMWg1Q1RUODRadnh3bERH?=
 =?utf-8?B?UG1FWXc4Q2ZXUzZ5alh3WUliczdqRXYvM0NGUmJ1OG1ESmErTXJ4SU5UQnBj?=
 =?utf-8?B?WmhwNmJVbHVxQWtUQ1ROcng4c1JieFhYMURON3ZEclRTV3NGK281MlR5ZXRm?=
 =?utf-8?B?U1pWSFY0cEpZa09mdG9COWZlOWdQREJWUXlWL1AxMVRkVHlKTXROdU16ejBv?=
 =?utf-8?B?RFRzUmR1U2F4Q0xHRlFXblJTOU02Nmk4SmtBUjVyeHdKQ0lZc3dkOUZiQjla?=
 =?utf-8?B?T1k4N1RPQmk4TVdmRWtxYXlsMCt4UEw0M013MDJXZHVvOWg1RXlTZ012c1dJ?=
 =?utf-8?B?Q0NmbWNUT1pSNGJ3MDFtN1o4L2Y5R2xPMzhoYlRFNitxdTZqSlJxRnRZQ0Fw?=
 =?utf-8?B?RUpZaUVsb0xZeU1oWlZTbnVDdWVRNDg0Y1dkMERkbHcvZmlNaEZRaFZmTGhZ?=
 =?utf-8?B?bWFYdmdkZVpXOU4rcVpGRDUvVzgwZ2Fhc0E2eUFrdWV4YXRPUGdST2J1NS9M?=
 =?utf-8?B?TElyWWdiK1plRmdtSkQyOVIvSTQ4S1RsWDNlMEwyVlpvNW9VWmJneU84Wk4x?=
 =?utf-8?B?blZQa1VWMUlNbDdHZFJhODZZNnhnUHcxY09VZ1JDQy8zbHpGZFlycEp6RFlo?=
 =?utf-8?B?NmdBUWtxWG03UDcrQ0xjK0Y3aENTTU9MVXBxWnlkR3VubEFQUmlYdFdyNkNj?=
 =?utf-8?B?c2FvTmYxZEIyRFBBWjd4TDBzc20rdC9nZ0t6bjdRV0pvQ05SaWdCOTZINmhi?=
 =?utf-8?B?eGtiY3ZSS2U1b0dxY2xHbkx3N3VwMUFyQnRETHlvaDRQcVgxRkFCV0VCWmQ3?=
 =?utf-8?B?UzVGMmlwN3NjYVp5MVNlMDBCMys1dXl6TXZiVXNJZzJ3Z3kvMmw3cUR6bUxu?=
 =?utf-8?B?cjk1QTNlQTg3R29tL2MyRkRvUU4rVXFjZ3RmSFl4cGVpTXBWdG1JT3ZSeGhH?=
 =?utf-8?B?RXRFbFlla0V6SEtZbEJoTlFVaXJYN2lNRVVCTVhCZmlPWTNIazFQamxHY0sz?=
 =?utf-8?B?TEZkcktGMDZLbXh6UUtwdzZQS1gwT1JsNDRFYUg1WWt0ZUl0SDVRREcyZ3Nv?=
 =?utf-8?B?cGV6Zm4yd1ZXOWJFb3ZNeDdQVkRmOTZEK0ZFL2JYZzAwQngwaXVQNExQYlRu?=
 =?utf-8?B?djdza3ovU1E4SDJhQmQ3N3ZSZWpnbEo3aHRIOVdUSzhmY2tPRVpHbFpBaERq?=
 =?utf-8?B?aGJoN2dpckRkajE1QzhTVFg4RFJwblozL0tsSUg5aXVoNituaWZzUFZWYVFl?=
 =?utf-8?B?VTV5aW9EOWZWdGlxUURMNC8wMlY5c1RicnRoRjI5WmdOSDhlZ3hHZXAyaFlH?=
 =?utf-8?B?WEs1anN6Z2YwYUxvQWFSbk0vNHhneXMrNy83KzF0a0ZkTmJKcGtLODdqVGdB?=
 =?utf-8?B?My95NTBRUnFZODhiTVNGRFg4TGFBejRZSmhENnRuUTJlK3ZDQ215Q05GT3h0?=
 =?utf-8?B?bXk1U2JsTFN1NE9aelBhdFBrZ3UwWDMwNmZQY3VuNTFoMVMyZUhRYkJkMTRJ?=
 =?utf-8?Q?Mrpi4skluLcv0YqA/i0VWb289?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ycudLzd/ARx2xMoaPWDljgbZkuDImlBTVzGFiyXn8xUd9o5PMWMmuAWa2OhdshuDc7nvCfx8rbxbZNLrbEPClDdObCwkhvx2npooirjFBgKcv6QI5PScNnrh1VNdEQbaBED/UalBwnBxHb5WZGN/yH67tCFGGJZYoRj4r68LUf9JYvJ6CjVrc8sRlmm44DXSHMQRonBpR3o35Cxy3SzXn+sFNlQyDHHxJ6AThFrJR+KSk8rAf7dUHsNKvrL3z+SMihRcWvujR+unY/AzIaD+TQGXx/HxDD2CM6W9Ix2mBBFzqOBRz9PUl6xnlWf8HQjEMJHhhbuuKMBQ+wXHQ5lXfbL1EA0NjwWZ2pWOjFgOteb5LTq/FzuXKK3vmVPX8GcY56MwszPxhbcYgsaIG1y19Mj5QFkZZ8j2h+EWxBFjr4wLcf7Yb/zab5NE1kWtpsVydZtsLog3/wtivVk52mdrcA2ATQl1c4fWBTzWIKN0uqdOiyO1QcGCzD7ZcWu/J76V1ixuTQ6P/7Dgd7srHZJPRGzIvhnCoQ3XsrdULpo7vEw/X10HgUeJ6joM2fQAYuHHMx06PESf+D3PL0ukidRal0zaplO68J2lcEXV3XMzQKid3ZhsE3mp8pbMUWIu4CFoGSMdGgTzJFwpktijNkmpsfgLEkeAbsrsfrQ2zJCQtGJMneIMmLAVQB2oVnFnRpHYW/XnGSV4c8nptjhcXCGuIl2X4mRiIPsJK+98KZ8c755DG9xVVYZ8CbQbtoEOp6ze1emk+tZGh1V0JQaCL84vQYnEAW6VUh9dlpeDfjIAftkWn44rHqS02o9jpEilBAtu3lhTJUUDZpxnJBNK1zZJq/3Sf5Ex2umLRN4xW0neWW9KHnQkU5rQjbnwAjiaRCTx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378a8908-76fe-4930-d418-08db29c619d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 04:38:21.8774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3uykaaDG7Q+gmPxDf7DaNzRg5rP2Q8YzYNL5tJndbHIovFJKUN+63nSUvtWfSJ6TN8OdoaXsHEi/r9SAVoz9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_18,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210036
X-Proofpoint-GUID: bmMKr_u-fWcZEBqPTbwMoCCKeMzFRxxl
X-Proofpoint-ORIG-GUID: bmMKr_u-fWcZEBqPTbwMoCCKeMzFRxxl
Cc: "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

CgpPbiAzLzE5LzIwMjMgMTE6NDQgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gRnJpLCBNYXIg
MTcsIDIwMjMgYXQgOTo1OOKAr1BNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPiB3
cm90ZToKPj4KPj4KPj4+IEZyb206IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXJjaCAxNSwgMjAyMyAzOjI4IEFNCj4+Pgo+Pj4gRXh0ZW5kIHRoZSBw
b3NzaWJsZSBsaXN0IGZvciBmZWF0dXJlcyB0aGF0IGNhbiBiZSBzdXBwb3J0ZWQgYnkgZmlybXdh
cmUuCj4+PiBOb3RlIHRoYXQgZGlmZmVyZW50IHZlcnNpb25zIG9mIGZpcm13YXJlIG1heSBvciBt
YXkgbm90IHN1cHBvcnQgdGhlc2UKPj4+IGZlYXR1cmVzLiBUaGUgZHJpdmVyIGlzIG1hZGUgYXdh
cmUgb2YgdGhlbSBieSBxdWVyeWluZyB0aGUgZmlybXdhcmUuCj4+Pgo+Pj4gV2hpbGUgZG9pbmcg
dGhpcywgaW1wcm92ZSB0aGUgY29kZSBzbyB3ZSB1c2UgZW51bSBuYW1lcyBpbnN0ZWFkIG9mIGhh
cmQKPj4+IGNvZGVkIG51bWVyaWNhbCB2YWx1ZXMuCj4+Pgo+Pj4gVGhlIG5ldyBmZWF0dXJlcyBz
dXBwb3J0ZWQgYnkgdGhlIGRyaXZlciBhcmUgdGhlIGZvbGxvd2luZzoKPj4+Cj4+PiBWSVJUSU9f
TkVUX0ZfTVJHX1JYQlVGCj4+PiBWSVJUSU9fTkVUX0ZfSE9TVF9VRk8KPj4gVUZPIGlzIGRlcHJl
Y2F0ZWQgaW4gTGludXgga2VybmVsLCB0aGVyZSBhcmUgbm8ga25vd24gdXNlciBlaXRoZXIgYW5k
IHdlIGRvIG5vdCBwbGFuIHRvIHN1cHBvcnQgaXQuCj4gTm90ZSB0aGF0IHRoZXJlJ3MgYW4gZW11
bGF0aW9uIGNvZGUgZm9yIHByZXNlcnZpbmcgbWlncmF0aW9uCj4gY29tcGF0aWJpbGl0eSBpbiB0
aGUga2VybmVsLgpJIHdvbmRlciBpZiB0aGVyZSdzIGEgY29tbWFuZCBsaW5lIG9wdGlvbiB0byBw
cm9oaWJpdCBRRU1VIGZyb20gc2F2aW5nIAp0aGlzIGhvc3QgY2FwYWJpbGl0eSB0byB0aGUgbWln
cmF0aW9uIHN0cmVhbT8gSWYgbm90IEkgdGhpbmsgaXQncyBhIApuaWdodG1hcmUgZXZlcnkgdmVu
ZG9yIGhhcyB0byBzdXBwb3J0IGFscmVhZHktZGVwcmVjYXRlZCBVRk8gaW4gdGhlaXIgCmgvdyBk
ZXZpY2UuCgpUaGFua3MsCi1TaXdlaQo+Cj4+IFBsZWFzZSByZW1vdmUgdGhpcyBlbnRyeSBhbG9u
ZyB3aXRoIGJlbG93IEdVRVNUX1VGTy4KPiBJZiB0aGVyZSdzIG5vIHBsYW4gZm9yIHN1cHBvcnRp
bmcgbWlncmF0aW9uIGZyb20gZXhpc3Rpbmcgc29mdHdhcmUKPiBiYWNrZW5kcywgd2UgY2FuIHJl
bW92ZSB0aGlzLgo+Cj4gVGhhbmtzCj4KPj4+IFZJUlRJT19ORVRfRl9IT1NUX0VDTgo+Pj4gVklS
VElPX05FVF9GX0dVRVNUX1VGTwo+Pj4gVklSVElPX05FVF9GX0dVRVNUX0VDTgo+Pj4gVklSVElP
X05FVF9GX0dVRVNUX1RTTzYKPj4+IFZJUlRJT19ORVRfRl9HVUVTVF9UU080CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
