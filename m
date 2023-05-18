Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D65C77B73
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 23:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18AF44063D;
	Thu, 18 May 2023 23:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18AF44063D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=RXFATEC1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=vjiQInAd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9Pwcb7d6QiK; Thu, 18 May 2023 23:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 761F6400FD;
	Thu, 18 May 2023 23:21:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 761F6400FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50D22C0035;
	Thu, 18 May 2023 23:21:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFE2CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 23:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B7E840223
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 23:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B7E840223
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2I8D7ZfEvzGO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 23:21:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 722EC400FD
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 722EC400FD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 23:21:10 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34IIx5UH032279; Thu, 18 May 2023 23:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ILEgPxbuiLlQ9/sZ5Qr+bP8nf7R8hAsZLwyHyEvFzWk=;
 b=RXFATEC1IaQeUPy3TZ4aX8nkeRJThNSZpBNL6HSpNDs8XCehsvQOvlm1dSYKogrdWwFh
 s3tqUtVp67nFDGQ0YqEMq5HYegeMV3gSxX9A0yEPFSxsQ62eRcgDc6WlrecZhO3qgBII
 4ju94/VmRpLUfBVyDE96AhvmZksTw+nZlBpU8I5DO9D1MbabWE8p+64c6P5BF07J4Y3O
 Wx8R+fuhy46rTpOxew4HcXxcP+WpEHUotG8jH/JadC1ew3QeWc6EV9EgVc74s7P7tz3d
 UDcTqsUHLvflAMGJP530HUP6+MgSagCVTw8UiCuoIEcNTWKbYd7YfPXGE22I5ZCnqQmc hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qnkux98vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 May 2023 23:21:09 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34ILGH0N025109; Thu, 18 May 2023 23:21:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj107d82u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 May 2023 23:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBiwvIHWk5PHIduylOl/2rieCp7w/fGAoSdXTf5aDT11RZedq1UR+jaq3LY8pgVYTGeVJrSIr3/eNxb35HhOZUyxeKQG1CboxbvrBFlB9LsHbsw0pTQGIPqSjjuZ4g9Yz6TswfsoUc4WMysnyurppzpatL5lGJxWjQ+ozE6m/eGOTraI/SToVsvhGzySZ1e/07eOCWq0lXGS3WmYwciHinyc+gp/KN13Tq+PXoZkhuM58PINyBqX9ziQ/4rR0KtjZg6CHWfdcqk2Zk5cFe6NPJKQyKi2+GZ4jpeJyIgFe9+j7RqwZj38I2peJIn20CmukLLqD2WMjwspa7gQQjkVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILEgPxbuiLlQ9/sZ5Qr+bP8nf7R8hAsZLwyHyEvFzWk=;
 b=I/TUzhY2eq6GVKLWy471uiZWPzO+2PrNkrVmUy2xQ9ubfV1MlUa5QMjw5MG2d4FdMZ4Wm1nFrenuPt7rKzlLk1ehmrze8PRZkMx0LDfLSBEkGZ8z6X8J/e5sa4vQ/wX85F+0+UxSgKhOLTjEdg+TPJOMqBru38dSJaOYs2RoYSSI4hI2zmLi5ArsaXFDpf4sGVF5XoiYeBc77ZYt7QvC9j1RKMVs1U00p0xiW9Gu+p6hMyxRvly4UaKCTkaNnT5LghYazGNt+cx1W6qRCBlafcoERAbCCOsBBjNo420KJDQyDXaTrmyUbNNLUFVoPmyrW9j7m2wBQjmDNc85P70BgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILEgPxbuiLlQ9/sZ5Qr+bP8nf7R8hAsZLwyHyEvFzWk=;
 b=vjiQInAdiXnpP17icYgZFIzN6wTZWvrWP01hq/zwPCEp1Cly55cIszSdHqZvcjNJP3YTbFhpEw47RdSJ4NBC73NGyTF3onuEl4l1P4ITpiVVjAQVL2Ajsu2v+7nqMsU/GBMIoVxDTjz7Ue0Wcx490OAvDDWYDkAPLZTsJph0BLU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 23:21:05 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 23:21:05 +0000
Message-ID: <967b0cbd-ca98-4ac8-c5e7-7b02d47acbef@oracle.com>
Date: Thu, 18 May 2023 18:21:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 13/14] vhost: allow userspace to create workers
To: Jason Wang <jasowang@redhat.com>
References: <20230428163131.92777-1-michael.christie@oracle.com>
 <20230428163131.92777-13-michael.christie@oracle.com>
 <CACGkMEutZEGkXPVoSjfTCofjqD7=F+=m7S-BKDX8s8BAayQa_w@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEutZEGkXPVoSjfTCofjqD7=F+=m7S-BKDX8s8BAayQa_w@mail.gmail.com>
X-ClientProxiedBy: DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: e652454d-070b-4cf0-5bf5-08db57f68d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJgTOa6Cb8cf2irPng/9JFPCeshbcESUPoWoVZ6eIQ7XVOiuuCYww3I9CH0NEszC8iwMIHVAF3R+2YCwllZHfhDl1jAEeTfACl07mGdHi2mnraNcCG8Ixp5/CjB5KU7p4EI3jjXzLZZIZMX74m7D5La9LrF2KffItq/CDOPxwpQTTJGWr4gqLzPbGx5XV/3cs2A4+yW52J9JhpJ94rGceT39cQLCkRJXGFvso/jfJWcpB76fgRPNvQMUOWSyVzib9GeDrS2L558Uoj6fo9CrDKYcpMwrLh4G+T2mWIRstpoTgPg5U6aQXmS0FSE3z93igBfcOBuMQ5gHFVYRllVtOM1u0z/+H2tfbyjEDBtqM7I0M2AWjTWU8ODDIohCZnMQysmO0fUEIAgEjVRepT4FB4AXkpvxOajMNsbp677ImtQguFPlkb1bEdUeIVA/RGBUeOcb7qtFqoPL6qdF4WihtwwHtth3LrPOII6bWxh+32/ETOcq6E7dtCmus8SLqXF+1ukW0gw6bRIqfBljJZQb64W/H3ketoUyNI3Dr3F1ezFdNdVXmFqbpfoM4Fskq4XR11Es86BVi6y2DY01pZC0i9I2l7GnbpoFmNZWhXVskj3wghiHwrXLU5KdK1HzPfOwIRbZ5rEY/sBcbc33yqMj/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(5660300002)(8676002)(8936002)(6506007)(26005)(83380400001)(6512007)(53546011)(2616005)(38100700002)(186003)(31696002)(66476007)(478600001)(66556008)(41300700001)(6486002)(86362001)(66946007)(316002)(4326008)(36756003)(6916009)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTY4SUN2S1ZHY1hPSkxNTFJUcURlQU5QNERuVHBTUUdxWGtBc280M3Nad0dW?=
 =?utf-8?B?NkpNdy9lOFNkamc0L1V2T0NKY081aldIaU01aEVMYnVpQ1grL3BrZzNMSUFk?=
 =?utf-8?B?dDQrb1FHeDF2YnZqbTFaaUxJNVhVNm1meW9waVhTamNqRWZ4RFN6TVk5eVlK?=
 =?utf-8?B?UHduTE5MUGwzWVVXTzNoYlRJWUhZaHNhanV6eFFHVHczbzArWEcra1V1UzFQ?=
 =?utf-8?B?WFljbVpvcTRudkxURGN4WkdFQ09MZ3RLbHFRZ2cvb3U5YU9sT05CWWNKTlBW?=
 =?utf-8?B?WVRqNmpzTjI1K1VsSTE3bGRZZ1BQNnNVL3l0bDRVR2gwT09tUWlSd2VGR3Z0?=
 =?utf-8?B?TlAwZjVyclFnUndyWENBQkEyMEE1bm5zaTN1UEo4RWxYcXh3TE91WmxtMHJl?=
 =?utf-8?B?RkkwT29BdjJtUjhRb3BUNDNJTnhCalEvNG5lTHVjenByWUdibFZDMEhZVE1B?=
 =?utf-8?B?RFJTeExMcWxhejVXWmdiakdyUFlZMjV6d2NBQmViaFVMVFA3SllJMDV0V2w4?=
 =?utf-8?B?a3NzQVBLd3Yvd1ovWVNYNEFFZ1g2dlVPTzBiZksrY0lRTWxiVnZPZ2xYQkxQ?=
 =?utf-8?B?dWRQSDR4Y1JTNGNjOTF6dGlWZU05ZFFvVWtKeXRQU0gycnoxNndVakUzb3gx?=
 =?utf-8?B?cU43Zmo0aUtVVEE2MDVWMXhHU0VRUVJSRGI5d2ljL2NSYTZwV3JUTmpUeUhF?=
 =?utf-8?B?U0VIRk1yNFJLMUM4N2o1NnptWXJHdkJ0SDFtbnpxa3pqdlgxaEYwSnBtQmV5?=
 =?utf-8?B?Y1ljdEw0ZXkxa2U4N0NORFRTZDhIWnBseG9ud3NRK21jTzd3UDM2dU5UajBo?=
 =?utf-8?B?UlJlb0pFVitKWW9aSUtKOVdvbmxzbjJCd0dTWWp3Q1owOCs5SmhUS0lvbWU0?=
 =?utf-8?B?MUN0Mmd1S1RIaGlUWC9iWFJYUkNPRk1zRTcxR3RPdmltcEdLSCsvc082VzZ0?=
 =?utf-8?B?enVEckZERG5Wa1RPbkhIb2gzMmRLMSt3THlySVYxZ3hPbWEyZVpkR0ZMRWlE?=
 =?utf-8?B?UWhOM3I4VGs5aFJGR0p5OWEzZ2VLRkVLaXJoMnpBOXZDSk54YnFPa2NzSDVP?=
 =?utf-8?B?alVNd2lvdDlvSUJKcTBWYW42UnNHY09MNXltZmJ1cko0Z3VqYi9lZmRhT2Zr?=
 =?utf-8?B?Sis0b21XN3pBS2JaTTJLSVlNWGFTTFR0a3Buc3BMTmY1Yzd6a1FacFpBNWRs?=
 =?utf-8?B?Qjg4bFY1MDROWjliMkRKNUFiU2l1blhQa1hnMkpEV3dnTUFxUENhUlJvZVNL?=
 =?utf-8?B?SE9NOGpkN1k2OTZlTkN0cGMwL3dPcmJXNzVUZmY2U2d1SDBVNUxHRWtiVG51?=
 =?utf-8?B?YXBvNm0wSlFTMzJKcHkxUkhyUWJUWU1WSXBKM2l4dkpUSE4ydC9KTjR0TkYz?=
 =?utf-8?B?VkdEVTB1Rk5Uc2lKWG5WVWtPbGtUYU11MUNWbmk3MmJVa1lKMWhMUk1ILzdX?=
 =?utf-8?B?cW5NVFpJYUxvV2FXSkVDeEt2aFVUSTdJVXdNV3dwREZKOVNnS3hIV1FISWFt?=
 =?utf-8?B?UVkyRWEvZ1NaWFN0SGFZbEdHdG5rRXdGQVgraFhhTytoRzNTWTEwUEZTbEV3?=
 =?utf-8?B?aU5oQmd5VmtMVGkvVmIwdnF1cElSWnZJVExOd01lN2JtOTFCUnBpUmZTUFhJ?=
 =?utf-8?B?c2JJUTg3ZFVRbklmMlcwVmdEL1h5dnVzSUU2bWNXMzJ0SW0vTzNmb1lrR0o4?=
 =?utf-8?B?Q0J2anpObU1vMnNQT09Mem1DWU5lRURjL09DaXZVZDVpMTV6SFNyZzdOaDBm?=
 =?utf-8?B?ZE1vV3oreHBaZlFWYjVKWTlqYThoYVpub3Z3MFByN2s3L1JaaGJzeldxZitp?=
 =?utf-8?B?aGpOVWc5cnpjWEhFbW1Qb1U4Y3pnNUt5VXBYejI2Rk9IaXFNblUvYVErblNh?=
 =?utf-8?B?VGFJaGZ6YndFQkdXMEJyWWNVeGVkNmxUbG1FMzlNV1VmQXk3cEdVNWtqTkhy?=
 =?utf-8?B?RlpwbUV0N3VVSkJ0TWhuR0xybFRXRU5VSDQ1c2FFaXFuMjdhT29GS2lnbGpy?=
 =?utf-8?B?clZ6bzdwU2xkV2dlZ0FFTnE3bFhmdEtxRDVaZ3NBZUk5K1M2SUlSRklMbnpW?=
 =?utf-8?B?Ty8xK0RHOHErQW9KVDU2emd4V1pVd1A2NGRHV29VQ0YyN3h1RkJrbFNJenht?=
 =?utf-8?B?bGQ3MG1idUtCdDVSMmRrR1haMmx3S1QxTWJxVy82OUxQRFJqM2dlLy9QajVX?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PQMQYVAKIibczYa+P2OQ31VFo/XZ81z0chxElBAHgDITUsqvYZKKcWHRrqFDSI04NHkag7g/qJm+xaAgfqTtdfxmpZO2YebmAwb0enLFlaVW2BtfO0AxCcM8m7cvRJ52PIx94OfCAushUeHObvWFl8n1JGgY0y6IemDLfxLEQcjzGv22/M2Y2HjyYiAjMze1/nvdgCzYiVCMkdNUK491a0g+opnvscgjSYScdt+vs0I8JoB3oHvACyb8v07PIJKrmRsbrs/c0S9Bvrd8cPt+g4v/V/cAndaMTlcDAJWwoR0sYcAfhuFUr5wb1AftaCQ2KKtayYiSs3qgZnWH303ecPpuGANsxgFgu2lJs6rJVwJXgUy6CMyqKh0GqRR+WzGQRt0NxwDRdtUsEH5fhlMgK8zl71soVeFYUR4b1+KRR6Ir/AqB53tj4rD0eXIihmBzfqKbYcj23Jg9hATGSQQoXrHLs1FL9g6UiaazwYNkyYTsIDcg7t7uVZZgRTFfHdwIIs8c58RXiaMNisNIEMP4rQd3fKZJ4l4/HEKlAiPpv4m92OTO3Q61IBIdjp/xX9nmcIQbRoL/UcPcAUkniwn8jYjfL328vdKuNPJ7q1LUDQQ80OaO1mMpqqExbhbIGzIR9kGOWFUWQw/KSNeos1J2bX6b9rxGwO755uB3LEKtVsHe5+JtOl/J/XLZ7AligFYDogpFW85fSW/El/UPqXRcJn6kxV75rm1H2qsSx62evr/eKHYD5yRdSbXba+JvMvSITwFaVRi2xflHhnT04yW5DKRdso/QFYysdk+Hz4TpFIutdhFGOZczmCLl4s+aidlT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e652454d-070b-4cf0-5bf5-08db57f68d9a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 23:21:05.4506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgPiBECPivg0bhzPLnLgUaNIkX4Pn90uXutIJ/02b/B1Fv/5dKAEzMBkHwxcVo1E0ZBgSAKOfAPa6F2b/EttZUuoGGvJEWgY75hdxXSVeyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180193
X-Proofpoint-ORIG-GUID: Ls1iANMo2ffFXqYuQtOZgitJj4ISXaw9
X-Proofpoint-GUID: Ls1iANMo2ffFXqYuQtOZgitJj4ISXaw9
Cc: mst@redhat.com, stefanha@redhat.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS8xNi8yMyAxMDoxMCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBTYXQsIEFwciAyOSwg
MjAyMyBhdCAxMjozMuKAr0FNIE1pa2UgQ2hyaXN0aWUKPiA8bWljaGFlbC5jaHJpc3RpZUBvcmFj
bGUuY29tPiB3cm90ZToKPj4KPj4gRm9yIHZob3N0LXNjc2kgd2l0aCAzIHZxcyBvciBtb3JlIGFu
ZCBhIHdvcmtsb2FkIHRoYXQgdHJpZXMgdG8gdXNlCj4+IHRoZW0gaW4gcGFyYWxsZWwgbGlrZToK
Pj4KPj4gZmlvIC0tZmlsZW5hbWU9L2Rldi9zZGIgIC0tZGlyZWN0PTEgLS1ydz1yYW5kcncgLS1i
cz00ayBcCj4+IC0taW9lbmdpbmU9bGliYWlvIC0taW9kZXB0aD0xMjggIC0tbnVtam9icz0zCj4+
Cj4+IHRoZSBzaW5nbGUgdmhvc3Qgd29ya2VyIHRocmVhZCB3aWxsIGJlY29tZSBhIGJvdHRsbmVj
ayBhbmQgd2UgYXJlIHN0dWNrCj4+IGF0IGFyb3VuZCA1MDBLIElPUHMgbm8gbWF0dGVyIGhvdyBt
YW55IGpvYnMsIHZpcnRxdWV1ZXMsIGFuZCBDUFVzIGFyZQo+PiB1c2VkLgo+Pgo+PiBUbyBiZXR0
ZXIgdXRpbGl6ZSB2aXJ0cXVldWVzIGFuZCBhdmFpbGFibGUgQ1BVcywgdGhpcyBwYXRjaCBhbGxv
d3MKPj4gdXNlcnNwYWNlIHRvIGNyZWF0ZSB3b3JrZXJzIGFuZCBiaW5kIHRoZW0gdG8gdnFzLiBZ
b3UgY2FuIGhhdmUgTiB3b3JrZXJzCj4+IHBlciBkZXYgYW5kIGFsc28gc2hhcmUgTiB3b3JrZXJz
IHdpdGggTSB2cXMgb24gdGhhdCBkZXYuCj4+Cj4+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgaW50ZXJm
YWNlIHJlbGF0ZWQgY29kZSBhbmQgdGhlIG5leHQgcGF0Y2ggd2lsbCBob29rCj4+IHZob3N0LXNj
c2kgaW50byBpdC4gVGhlIHBhdGNoZXMgZG8gbm90IHRyeSB0byBob29rIG5ldCBhbmQgdnNvY2sg
aW50bwo+PiB0aGUgaW50ZXJmYWNlIGJlY2F1c2U6Cj4+Cj4+IDEuIG11bHRpcGxlIHdvcmtlcnMg
ZG9uJ3Qgc2VlbSB0byBoZWxwIHZzb2NrLiBUaGUgcHJvYmxlbSBpcyB0aGF0IHdpdGgKPj4gb25s
eSAyIHZpcnRxdWV1ZXMgd2UgbmV2ZXIgZnVsbHkgdXNlIHRoZSBleGlzdGluZyB3b3JrZXIgd2hl
biBkb2luZwo+PiBiaWRpcmVjdGlvbmFsIHRlc3RzLiBUaGlzIHNlZW1zIHRvIG1hdGNoIHZob3N0
LXNjc2kgd2hlcmUgd2UgZG9uJ3Qgc2VlCj4+IHRoZSB3b3JrZXIgYXMgYSBib3R0bGVuZWNrIHVu
dGlsIDMgdmlydHF1ZXVlcyBhcmUgdXNlZC4KPj4KPj4gMi4gbmV0IGFscmVhZHkgaGFzIGEgd2F5
IHRvIHVzZSBtdWx0aXBsZSB3b3JrZXJzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIENocmlz
dGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy92aG9z
dC92aG9zdC5jICAgICAgICAgICAgfCAxNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQo+PiAgZHJpdmVycy92aG9zdC92aG9zdC5oICAgICAgICAgICAgfCAgIDMgKwo+PiAgaW5jbHVk
ZS91YXBpL2xpbnV4L3Zob3N0LmggICAgICAgfCAgMzMgKysrKysrKwo+PiAgaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0X3R5cGVzLmggfCAgMTYgKysrKwo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAxOTYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+IGluZGV4IDRiMGI4MjI5MjM3
OS4uZThmODI5ZjM1ODE0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4g
KysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+IEBAIC02MzAsNiArNjMwLDgwIEBAIHN0YXRp
YyBzdHJ1Y3Qgdmhvc3Rfd29ya2VyICp2aG9zdF93b3JrZXJfY3JlYXRlKHN0cnVjdCB2aG9zdF9k
ZXYgKmRldikKPj4gICAgICAgICByZXR1cm4gTlVMTDsKPj4gIH0KPj4KPj4gKy8qIENhbGxlciBt
dXN0IGhhdmUgZGV2aWNlIG11dGV4ICovCj4+ICtzdGF0aWMgdm9pZCBfX3Zob3N0X3ZxX2F0dGFj
aF93b3JrZXIoc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEsCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3Rfd29ya2VyICp3b3JrZXIpCj4+ICt7Cj4+
ICsgICAgICAgaWYgKHZxLT53b3JrZXIpCj4+ICsgICAgICAgICAgICAgICB2cS0+d29ya2VyLT5h
dHRhY2htZW50X2NudC0tOwo+PiArICAgICAgIHdvcmtlci0+YXR0YWNobWVudF9jbnQrKzsKPj4g
KyAgICAgICB2cS0+d29ya2VyID0gd29ya2VyOwo+PiArfQo+PiArCj4+ICsvKioKPj4gKyAqIHZo
b3N0X3ZxX2F0dGFjaF93b3JrZXIgLSBzZXQgYSB2aXJ0cXVldWUncyB3b3JrZXIgZnJvbSBhbiBp
b2N0bCBjb21tYW5kCj4+ICsgKiBAdnE6IHRoZSB2aXJ0cXVldWUgd2Ugd2lsbCBzZXQgdGhlIHdv
cmtlciBmb3IKPj4gKyAqIEBpbmZvOiB0aGUgd29ya2VyIHVzZXJzcGFjZSBoYXMgcmVxdWVzdGVk
IHVzIHRvIHVzZQo+PiArICoKPj4gKyAqIFdlIG9ubHkgYWxsb3cgdXNlcnNwYWNlIHRvIHNldCBh
IHZpcnRxdWV1ZSdzIHdvcmtlciBpZiBpdCdzIG5vdCBhY3RpdmUgYW5kCj4+ICsgKiBwb2xsaW5n
IGlzIG5vdCBlbmFibGVkLgo+IAo+IEkgd29uZGVyIGlmIHdlIGNhbiBtYW5kYXRlIHRoaXMgaW4g
dGhlIGNvZGUgbGlrZSBjaGVjayB0aGUgdnEgYmFja2VuZAo+IGluIHZob3N0X3ZxX3dvcmtfcXVl
dWUoKS4KCkknbGwgbG9vayBpbnRvIGl0LiBIb3dldmVyLCBmb3IgdGhlIHZzb2NrIGNhc2Ugd2Ug
YWN0dWFsbHkgZG8gd2FudCB0bwpxdWV1ZSB0aGUgd29yayBldmVuIHRob3VnaCB0aGVyZSBpcyBu
byBiYWNrZW5kIHNldCB5ZXQuIEl0IHNvcnQgb2YganVzdAprZWVwcyBxdWV1ZWluZyB3b3JrcyB1
bnRpbCBWSE9TVF9WU09DS19TRVRfUlVOTklORyBpcyBleGVjdXRlZC4gV2hlbiB0aGF0J3MKZG9u
ZSBpdCB3aWxsIHJ1biB0aGUgd29ya3MgdGhhdCBoYXZlIGJlZW4gcXVldWVpbmcgdXAuCgoKPiAK
PiAgV2UgYWxzbyBhc3N1bWUgZHJpdmVycyBzdXBwb3J0aW5nIHRoaXMgd2lsbCBub3QgYmUKPj4g
KyAqIGludGVybmFsbHkgcXVldWVpbmcgd29ya3MgZGlyZWN0bHkgb3IgdmlhIGNhbGxzIGxpa2Ug
dmhvc3RfZGV2X2ZsdXNoIGF0Cj4+ICsgKiB0aGlzIHRpbWUuCj4+ICsgKgo+PiArICogQ2FsbGVy
IG11c3QgaGF2ZSBkZXZpY2UgYW5kIHZpcnRxdWV1ZSBtdXRleC4KPj4gKyAqLwo+PiArc3RhdGlj
IGludCB2aG9zdF92cV9hdHRhY2hfd29ya2VyKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLAo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZob3N0X3ZyaW5nX3dv
cmtlciAqaW5mbykKPj4gK3sKPj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGluZGV4ID0gaW5mby0+
d29ya2VyX2lkOwo+PiArICAgICAgIHN0cnVjdCB2aG9zdF9kZXYgKmRldiA9IHZxLT5kZXY7Cj4+
ICsgICAgICAgc3RydWN0IHZob3N0X3dvcmtlciAqd29ya2VyOwo+PiArCj4+ICsgICAgICAgaWYg
KCFkZXYtPnVzZV93b3JrZXIpCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4g
Kwo+PiArICAgICAgIGlmICh2aG9zdF92cV9nZXRfYmFja2VuZCh2cSkgfHwgdnEtPmtpY2spCj4g
Cj4gSXQgbWlnaHQgYmUgd29ydGh3aGlsZSB0byBoYXZlIGEgY29tbWVudCB0byBleHBsYWluIHdo
eSB3ZSBuZWVkIHRvCj4gY2hlY2sgdnEtPmtpY2sgaGVyZS4KPiAKPiBUaGlzIGFsc28gbWVhbnMg
dGhlIGRldmljZSBzaG91bGQgbm90IHF1ZXVlIHdvcmsgd2hlbiB0aGUgYmFja2VuZCBpcyBOVUxM
Lgo+IAo+IEJ1dCBJIGZvdW5kIGl0IGlzIHByb2JhYmx5IG5vdCB0aGUgY2FzZSBmb3IgdnNvY2ss
IGl0IGNhbGxzCj4gdmhvc3RfcG9sbF9xdWV1ZSgpIGluIHZob3N0X3RyYW5zcG9ydF9jYW5jZWxf
cGt0KCkgYnV0Cj4gdmhvc3RfdnNvY2tfc3RvcCgpIGRvZXNuJ3Qgd2FpdCBiZWZvcmUgZG9pbmcg
dmhvc3RfdnFfc2V0X2JhY2tlbmQodnEsCj4gTlVMTCk7ClllYWgsIHRoZXJlIHdhcyBhbm90aGVy
IGNhc2Ugd2hlcmUgdmhvc3RfdHJhbnNwb3J0X3NlbmRfcGt0IGNhbiBjYWxsCnZob3N0X3dvcmtf
cXVldWUgYmVmb3JlIHRoZSBiYWNrZW5kIGlzIHNldC4KCkkgZW5kZWQgdXAgZG9pbmcgdGhlIG9w
dCBpbiBtZXRob2QgdGhvdWdoLiBJIGRpZCBhIHRlc3QgdG8gY29udmVydCB2c29jawphbmQgYSB3
b3JrZXIgZm9yIHRoZSByZWN2IHF1ZXVlIGFuZCBvbmUgZm9yIHRoZSB4bWl0IHF1ZXVlIGRvZXNu
J3QgaGVscC4KSXQgd2FzIGxpa2Ugd2l0aCB2aG9zdC1zY3NpIHdoZXJlIHdpdGgganVzdCAyIHZp
cnRxdWV1ZXMsIG9uZSB3b3JrZXIgY291bGQKaGFuZGxlIHRoZSBsb2FkLiBTbyBJIHRob3VnaHQg
dGhlcmUgaXMgbm8gcG9pbnQgaW4gYWRkaW5nIGV4dHJhIGNvZGUgZm9yCnZzb2NrIGlmIGl0IHdh
c24ndCBnb2luZyB0byBiZSB1c2VkLgoKCj4gCj4gTmV0IHNlZW1zIHRvIGJlIGZpbmUgc2luY2Ug
aXQgd2FpdHMgZm9yIHVidWZzIHRvIGJlIGNvbXBsZXRlZCBpbgo+IHZob3N0X25ldF9zZXRfYmFj
a2VuZCgpLgo+IAo+IENhbiB3ZSBtYWtlIHRoaW5ncyBlYXNpZXIgYnkgbWlncmF0aW5nIHRoZSB3
b3JrX2xpc3Q/IEkgYWxzbyB3b3JyeSBpZgo+IHRoZXJlIGFyZSBvdGhlciBjb3JuZXIgY2FzZXMg
d2hpY2ggbWFrZXMgbWUgdGhpbmsgaG93IGhhcmQgaXQgaXMgaWYgd2UKPiBjYW4ganVzdCBzdXBw
b3J0IHRob3NlIGlvY3RscyBhZnRlciB0aGUgYmFja2VuZCBpcyBzZXQ/CgoKSXQncyBub3QgdG9v
IGRpZmZjdWx0IHRvIHN1cHBvcnQgYXR0YWNoaW5nL2RldGFjaGluZyB3b3JrZXJzIGZyb20gcXVl
dWVzCndoZW4gSU8gaXMgcnVubmluZy4gT25lIG9mIHRoZSB2ZXJzaW9ucyBJIHBvc3RlZCB1c2Vk
IFJDVS4gSG93ZXZlciwgaXQgYWRkcwpjb21wbGV4aXR5IGFuZCBJIGRpZG4ndCBoYXZlIGEgdXNl
IGNhc2Ugc28gSSBkaWRuJ3Qgd2FudCBhZGQgY29kZSB0aGF0IG1vc3QKbGlrZWx5IHdvdWxkbid0
IGJlIHVzZWQuCgoKPj4gIHZvaWQgdmhvc3RfY2xlYXJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRl
dik7Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCBiL2luY2x1ZGUv
dWFwaS9saW51eC92aG9zdC5oCj4+IGluZGV4IDkyZTFiNzAwYjUxYy4uMTU1NzEwNTg1OTc5IDEw
MDY0NAo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAo+PiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmhvc3QuaAo+PiBAQCAtNDUsNiArNDUsMjUgQEAKPj4gICNkZWZpbmUgVkhP
U1RfU0VUX0xPR19CQVNFIF9JT1coVkhPU1RfVklSVElPLCAweDA0LCBfX3U2NCkKPj4gIC8qIFNw
ZWNpZnkgYW4gZXZlbnRmZCBmaWxlIGRlc2NyaXB0b3IgdG8gc2lnbmFsIG9uIGxvZyB3cml0ZS4g
Ki8KPj4gICNkZWZpbmUgVkhPU1RfU0VUX0xPR19GRCBfSU9XKFZIT1NUX1ZJUlRJTywgMHgwNywg
aW50KQo+PiArLyogQnkgZGVmYXVsdCwgYSBkZXZpY2UgZ2V0cyBvbmUgdmhvc3Rfd29ya2VyIHRo
YXQgaXRzIHZpcnRxdWV1ZXMgc2hhcmUuIFRoaXMKPj4gKyAqIGNvbW1hbmQgYWxsb3dzIHRoZSBv
d25lciBvZiB0aGUgZGV2aWNlIHRvIGNyZWF0ZSBhbiBhZGRpdGlvbmFsIHZob3N0X3dvcmtlcgo+
PiArICogZm9yIHRoZSBkZXZpY2UuIEl0IGNhbiBsYXRlciBiZSBib3VuZCB0byAxIG9yIG1vcmUg
b2YgaXRzIHZpcnRxdWV1ZXMgdXNpbmcKPj4gKyAqIHRoZSBWSE9TVF9BVFRBQ0hfVlJJTkdfV09S
S0VSIGNvbW1hbmQuCj4+ICsgKgo+PiArICogVGhpcyBtdXN0IGJlIGNhbGxlZCBhZnRlciBWSE9T
VF9TRVRfT1dORVIgYW5kIHRoZSBjYWxsZXIgbXVzdCBiZSB0aGUgb3duZXIKPj4gKyAqIG9mIHRo
ZSBkZXZpY2UuIFRoZSBuZXcgdGhyZWFkIHdpbGwgaW5oZXJpdCBjYWxsZXIncyBjZ3JvdXBzIGFu
ZCBuYW1lc3BhY2VzLAo+PiArICogYW5kIHdpbGwgc2hhcmUgdGhlIGNhbGxlcidzIG1lbW9yeSBz
cGFjZS4gVGhlIG5ldyB0aHJlYWQgd2lsbCBhbHNvIGJlCj4+ICsgKiBjb3VudGVkIGFnYWluc3Qg
dGhlIGNhbGxlcidzIFJMSU1JVF9OUFJPQyB2YWx1ZS4KPiAKPiBUaGlzIG1ha2VzIG1lIHRoaW5r
IGlmIHdlIHNob3VsZCBkZXN0cm95IGFuZCByZS1jcmVhdGUgdGhvc2UgYWZ0ZXIKPiBWSE9TVF9S
RVNFVF9PV05FUj8KCkRvIHlvdSBtZWFuIHdoYXQgaGFwcGVucyBpZiB3ZSBkaWQgc29tZXRoaW5n
IGxpa2Ugd2UgZGVzdHJveSB0aGUgY2dyb3VwIGFmdGVyClZIT1NUX1JFU0VUX09XTkVSPyBZb3Ug
aGF2ZSB0byBtb3ZlIHRoZSB0aHJlYWRzIGluIHRoZSBjZ3JvdXAgdG8gYW5vdGhlcgpjZ3JvdXAg
YmVmb3JlIGRlc3Ryb3lpbmcgaXQsIHNvIGl0IGRlcGVuZHMgb24gd2hhdCdzIGdvaW5nIG9uIGF0
IHRoZSB0aW1lLgoKRm9yIGV4YW1wbGUgaWYgeW91IGFyZSBhc2tpbmcgYWJvdXQgYSByYWNleSBr
aW5kIG9mIGNhc2UgbGlrZSB3ZSBoYXZlIG1vdmVkIHRoZQpwYXJlbnQvcWVtdSB0aHJlYWQgdG8g
bmV3IGNncm91cCwgdGhlbiB3ZSBkbyBWSE9TVF9ORVdfV09SS0VSIHRoZW4gdGhlIG5ldyB0aHJl
YWQKd2lsbCBlbmQgdXAgaW4gdGhlIG5ldyBncm91cCB3aXRoIHRoZSBwYXJlbnQuIFRoZSBleGlz
dGluZyB0aHJlYWRzIG1pZ2h0IHN0aWxsIGJlCml0IHRoZSBvbGQgY2dyb3VwIHVudGlsIHlvdSBo
YXZlIGZpbmlzaGVkIG1vdmluZyB0aGVtLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
