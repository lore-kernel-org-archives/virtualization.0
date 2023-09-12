Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99945CA0EC3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 00:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2052B80E3F;
	Tue, 12 Sep 2023 00:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2052B80E3F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=fnSfqw8T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kFHjG7cS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gcBOl4oRQqCS; Tue, 12 Sep 2023 00:28:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 881D180DB6;
	Tue, 12 Sep 2023 00:28:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 881D180DB6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45B95C0039;
	Tue, 12 Sep 2023 00:28:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12165C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFDC280E2C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:28:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFDC280E2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kgvNwVyWPGpc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:28:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C82780DB6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:28:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C82780DB6
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BJqlOs028392; Tue, 12 Sep 2023 00:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=06a0QtUDdkh5bt+i4srpICOHLHHmbNrHkD1dW02Ov38=;
 b=fnSfqw8T6pQzVWfKYO4e2RrVI9rjfv19WgdzIh0DJdOTYAUsJaF2ztoPhwBEfmS0H8Nu
 33epDs9TSr/0sL0QZjedhX33F1V3YACUxxQ8w/W7fjeheOgRh/LznEr69wO5wH7vieeL
 ViOs2Foi7abDW24D2KOcLWgyLiLNDn/RNy7rPbAfMSP2g2m1XmdtNTR5+HeiVEC1iiY5
 1JE11WHHPp3r+lzDeNP5bkL8FyAqgG3hnp0IXEMn7hXBR6oxky8oYIjXJZ2+qpqXr1Eq
 /vPirGaxcbJeIQbeiC7T/cLCoae1aLJXxYKl8tuhRIRIcDDaKk4yL1fVemmANk76My0d Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7aq3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 00:28:47 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38BMGCjR002638; Tue, 12 Sep 2023 00:28:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5b80ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 00:28:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSfrJ5KtrQ/eSGFNDuXnFR9XnYZ30YC39OegaIr9jwLqjDuisF1s9c8WCe2ONKcZaQq4fKf4d5zmXX4jjP4Secul2N5XZVI7YmlFmyiOxEf/PnSHLt04mKDUJcs0RlpzvRu6ux9hw81xlI/PkO4oDVSX8EvYdSBBwrP9tHB0s16xFtjTqw1GAiaAANcwLnpaGq52s4Ty8A5HbNDBBfynam3gW6UAoUcfQLRZtkjsjuLqR+UspCWAebbnw0EXsIGWG8aOF6I99rOCrRaPcTmyI8i4X9ED6HMOzL/XRXBGhnevuZmSua69l0C4NX86EGWDvezRzduXAZ4hmB00FJeevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06a0QtUDdkh5bt+i4srpICOHLHHmbNrHkD1dW02Ov38=;
 b=EywfaDVnoVHE/fHGWUZdCuUOaLBQMjiehvw4m0cH1Ns3NXQLqxII74w5bW86zaX0YRnHKUC7Q5LmzzhIUJSD0u2O+t2AGsuRDd1Qv0NqcNAq4x2aQUau0um2PxvR3n5t9Kzj4mJeP2zadyWLK+OYgU9P1ws424SAAmL4ZtFTxcu8OkjEI3rMXCZ+WEhrkxo2l4HoE2r1PmC3GcNdy04TyCxsDcpZmiyJ+BgyUvqHv0d2AyqxQWEdn8YXW9Gdue4FXIlOW6lRqcwQZdLOUdVHx0lDgypBtu4hbUJtAeVCQCKaN28VJEZiXpHBymDSeoN42Jvr+lme8dE+4JgTDSl+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06a0QtUDdkh5bt+i4srpICOHLHHmbNrHkD1dW02Ov38=;
 b=kFHjG7cScBx0s6q/GwiRJZIrWg/OI4NOnAVO4UD9qM21qjKgJsU2JiN88oZMqyRRajnY7t7+re4P46aeG6r3pKb9MDu7QajGy+vV60xiu0Kpw+t2yP3ba1oEZJGDZtT+lfIB7fJYbdSzhzpMeGPk4JVSg9xGW6Pb9kIzD6PSx88=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM6PR10MB4138.namprd10.prod.outlook.com (2603:10b6:5:218::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 00:28:43 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6745.035; Tue, 12 Sep 2023
 00:28:43 +0000
Message-ID: <edb0415d-efa3-5d5b-bffd-b3ccfc64faa6@oracle.com>
Date: Mon, 11 Sep 2023 17:28:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RFC v3 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1694267039-718-1-git-send-email-si-wei.liu@oracle.com>
 <1694267039-718-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEu5ey0c-541=ECv7pW7Uj68Pv1Z7TG7Cci1tHfyA4bRqg@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEu5ey0c-541=ECv7pW7Uj68Pv1Z7TG7Cci1tHfyA4bRqg@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM6PR10MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8c9fd5-a819-476f-53e8-08dbb3273849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1S/OLKHM5j4lQUOQ5Z8MWh46VH0LWKijsUR/ru2Id6za+trwmvzzjLchKlpRCYzuY+IiKqUedKsYMuzqajAb3tGOievYaT9qJq4YpUi9Lkhhl5u7CAMG7um1Zvh7YsyCGV17soINEOWPGcqATtyQFLkqiLwjLg+2nViylUOyEJuX6GktWf2rMNMe0y0iHpmgEwUomJIdEf0ZAXjy96vecSl8+YQugfNvGXfQC/Y00GrWUP70PW+5gQQls+zQWcOKqeyPjT5MrGj4fX7+WeeRubXwiab9/hUausXFeNRcwRe2MCCIb0liD2SK5uXTm868VvisFkkq6glBNamNH/6esmI2dbpj8Wm4YMiPMvHbyLBoq7phyR9Mt71Yzgzx4OUD9Ph1q/iQdchf09AdU1NaLnRJYnWSqje1mZFXvez+Xt3iqK2gJNvKMyS5/yoCLz3O0tjyN4bfZEjMj3uTuwQ1nSD6H+MZ1iKaGCy3BQLfC07UXg77T9IdlTRyOYpeDmDz3OJXzjlpe6mvUxaECD8he8aKyx7mQwZGjWhIOnKxcNlJ6SMFsC4yapVLQpBNGPR/EkarrBMQYKLtfrKIt2xChL9ljFvfu+nUZ4oZ5F8iFq3KaKWDRCY1nvDjgWAXv06pWCpx0a4D5KhrCpKtz1k2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(186009)(451199024)(1800799009)(41300700001)(31686004)(6506007)(53546011)(6666004)(36916002)(6486002)(5660300002)(36756003)(86362001)(38100700002)(31696002)(2616005)(966005)(6512007)(83380400001)(478600001)(316002)(8936002)(2906002)(8676002)(4326008)(26005)(66556008)(6916009)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlKaXhYYlp5SEN5NkZ6LzdtU1hDRHhqSE9RZ3RILzFjYWQ2UnJsRGFsQ3BL?=
 =?utf-8?B?R0ZEQnd4WFlsNGlRQlBwQ0Z3Rkp3c1lweHRTdnVSSC80TXJqam0wbVRJMUlh?=
 =?utf-8?B?ZndMSmZYU29CRGkzTzNXSkJIM3pvVzBzcm9rRmhuWlJrTHNMTkhIYlRtZ0Fn?=
 =?utf-8?B?K2FDYmtvZmVlOVdPcnhUaWpYSEk4dzNrZmpPcktVTVRaNUc5d2NlR2g3cVpj?=
 =?utf-8?B?U3NEWUJwQzY1cDVwODgzQjlKTGMyZ1pKWDVKVksvTE9qSXNYcDhYT3JyUVZL?=
 =?utf-8?B?a1VMZ2tocFJlOHQ5NlBiUllhenBvWEpCVzRwRkhWai94Rm9KdjVKUHJ1cUJq?=
 =?utf-8?B?aXoybWNFWWdkY1ZLN3U4MGhoa2R2VjR3aWp2dFlkR1RzcWdIVFBQbTR5VGJx?=
 =?utf-8?B?UDlsc2NLb2pzSHlYWHpKTVhvR29ibHhzOHpLN1Z1NzdmRWxBK3phSUF6emtl?=
 =?utf-8?B?L1JGWXpMV1BQKzFTUi9jZVJacWkyV1BKWFVKM1JzS3JtOUpaTVpmai8xbDFN?=
 =?utf-8?B?R0Q4OERGZDVKRGJtZWNKRHNDTHl0Rzgya0VxQUtFQklxL1FLWlptcjlZRDI3?=
 =?utf-8?B?NThyTWVrTGhhd1pOcmg4WGlhaDFWSmJiMC9sRWl5RzFISE1KSmNhc1ZRT2Mx?=
 =?utf-8?B?bi9RdnZ1Z1FBbWxCNmVSaUNES3BLZkR4ZzlhMlluNWNFcit3Q0dncXExQ2l0?=
 =?utf-8?B?UzdGMjFPdnYrb0FIZmxBZVNtVGhlQXRFRjB3WnZzYmpaTnhzcUdLNHRaQVJp?=
 =?utf-8?B?UlBVMVZoelJrZ3ErejVCSnM0ZzVBRkIvTzFnZmRVT3JIdndjOTJsdXJTaFJQ?=
 =?utf-8?B?SnpybmY1NWlFc1ZNaTM2SHBTN3RIemFuZ21XRmx6TGdseUoyRW9iMGxFb3BE?=
 =?utf-8?B?SFVuQW5kTnhjanl2Z284TWxpd1VFbEhOOWZTajVleTB1eUdKR2Vsb0xwZlN6?=
 =?utf-8?B?MnlPa3lpM1FSWXV6ZXlCSjU1MlJ6WWRqMTZBeDRKeVE2QXFNRTNxVWZMaHQ5?=
 =?utf-8?B?L2YrTHpxZHErZHN5SFA4TFZ4N1Z5dVpVQ3lSWUc3RkU3V0wrSHI4MXpFcCta?=
 =?utf-8?B?VHpSZ2JRejFwamNOVWp2Y3hqbkNvbjlhVVk5MXd6bnhMSElPeVBLM0VudTda?=
 =?utf-8?B?WGtLT1dxVmNjSGxJNXVtWGdESWtKd1hNR0IxdTVLQVUwTzNIZTVINU5WczJK?=
 =?utf-8?B?ZnU2bk45WFdOMTJRVkhPKzZnQ1VnN1JPK0FuVDM3MGdDbm9DU1JuYS9pd3lz?=
 =?utf-8?B?bmtoc1J5SGg5WlVVaUI0M0ZmRHdvQTZsQmpoNjNtQnFPaVRNZnVxY1VPNTZT?=
 =?utf-8?B?SW8xbk1vbkhBY1NmNDNZSnpHQW5ZR1pPYm9yTnBVUFI5NE5VMTVGZEJ4ZENn?=
 =?utf-8?B?ZnJmaTA4NzliMy9uRmdsZ1doT2RqOVFZSWEyUnhhTkRIM1QvTFdYaGRZMU55?=
 =?utf-8?B?TEFPMnc5Yk9JTVYyUUhNL0owNEJVOGd3SmllRjhUTnllQmZmb0wxeFRocXNZ?=
 =?utf-8?B?eHpkWDdqbWV4cFYxdWk1TDZNTEpZNXBWUUw2aWx5KzlSNjlGazNTdkVEd2Y0?=
 =?utf-8?B?VUs4TXI1TFl1RlZUTmJuZThuMkp1bjhMcHA2Yytna2l5MkIwTVZnQ2xpbEE5?=
 =?utf-8?B?enRqOTRzdDA3bHhkblFuaVAvYXMydXlZVVdmTi9uanNWY1dhdWpkTHEzdTgw?=
 =?utf-8?B?bEFLVEZneEVMdmc0VnZ5d0tKTCtkVnBHditrVW1EaG9SYjQrd2FiWWM3WXBK?=
 =?utf-8?B?cEZaS2xqdXYvck4zUVRwdEx3cCtyVUNmbGlleUQ4UG5VTjkybUdOMi8vWSt5?=
 =?utf-8?B?dUdkYytlT2V6WkxySk5OYk0rdE1FZjdTMFNRR0QrU2ZuNnUxNzBKcjBsbFBH?=
 =?utf-8?B?V05HNi8wQnJKTnZSYWFUdksxNi9nUzdEQW1iQU5nVk85M3RJMW9rVEJidUhj?=
 =?utf-8?B?ZHZNMmluM0RYT2MrcEtlNEhrZ01wdSsxRVJDUUFMSTdJZUQ1Nk1IWHdsUFRx?=
 =?utf-8?B?bGtlNDh6dnZuOXZQRnU4VExDUXdVUXF5UDIxNTh4SkFZRndXalUxU0RMWHhy?=
 =?utf-8?B?V2RBbkxXdXY0a0dkOWtjWTdEdlBWMFFLQ3RCWGp3NHV2WElLT01mclo4OW1W?=
 =?utf-8?Q?ATFqzY4s80QVLor0TXO98Eq0U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K4r6zsOARhCsTz88iq7nElWy+NhKP6l4rii9roafvwzMtMuv6ng11r31igqEagqHXC1sH6ZetbWP6U3aJZ1bMsKhEEKWzj4xAy5rUNdxvfemvET4u9SBf48lFEzZj2So6m8QoaNYF93ZVmc9QLU6SZ/jN1EOioCqLorqZskZi8f6Vx0XURijPclpos5IEZLiK2+DVP8YqZkgu9Ww+oiH8Lp4G9qSC6hT1QHsOnFw8eJGPWunS0xNSWPrLcj5cHBfGUggNOwkMBbNoS/GaNh1wU4RctRsfPog9jfKrTGtqVcJeVDjdPVP4vVLT3uU/FXXhTUeA1vvi5AM/iott8rc/TeXVRD+lAloE9FDMwNIFy2SBTXWV66+a987sBmziolHquf7uazrHIV8vOBql3TyusHqz0xG66rT0yiVqMG4WYz749hZBFNlkrtM/XJfarsbaaJA4PgYRHr0JQPKGDaEDvsxobcVZsmS8Up6904kIoqaP8EaLgwGsJGbLyev6VesxQymwyCHWM6IlJW57rCPwJeVZqlYsH9+oXeFu0u5GX3aJKWC7WF04rYkTp8ecUeZmbDn8M2kWFTgPku6/e6uxouazHKjF62O02gbCoso0OGvQ7GAl2aa1RL6BAujkHx4wdmyp0vAQk9g+7dECNydnh10TGJCCLogQ7N0pYCvqn2s0345nECsjBwqDH/nNu4KRD8sr4aX3KM0WnBoHZMoCtPmDtKdC+Ap/2ttuiUYRlI83X2XbKL4Gn3MxS1dZx+AkbD4Sc5Yh3uAqL02FRFZf3k/SSYO5gFThogeZv42tNh5cNQRggc3YOCmqI8yv1BYvg9ISMqerO+2ZcXyQb2jVOZujVzdrQHVlHEdo+z1RVhjUEC1hkG5i8ddXYCYYPekgEcMTY7Sk2z1h5CxR7WLOw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8c9fd5-a819-476f-53e8-08dbb3273849
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 00:28:43.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy9huvQbfF5UEw3pPiIHMk1IMZSyLP0GKeRRJ2oR1h7BHc2huqiXBwfyjvavlWphl6jSdsAGNgyyPqVfk3r6Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120003
X-Proofpoint-GUID: Z8TGtlzHDqjfzglwqCJJ623a5XoaMPdr
X-Proofpoint-ORIG-GUID: Z8TGtlzHDqjfzglwqCJJ623a5XoaMPdr
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

CgpPbiA5LzEwLzIwMjMgODo1MiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBTYXQsIFNlcCA5
LCAyMDIzIGF0IDk6NDbigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdy
b3RlOgo+PiBVc2Vyc3BhY2UgbmVlZHMgdGhpcyBmZWF0dXJlIGZsYWcgdG8gZGlzdGluZ3Vpc2gg
aWYgdmhvc3QtdmRwYQo+PiBpb3RsYiBpbiB0aGUga2VybmVsIHN1cHBvcnRzIHBlcnNpc3RlbnQg
SU9UTEIgbWFwcGluZyBhY3Jvc3MKPj4gZGV2aWNlIHJlc2V0Lgo+IEFzIGRpc2N1c3NlZCwgdGhl
IElPVExCIHBlcnNpc3RzIGZvciBkZXZpY2VzIHdpdGggcGxhdGZvcm0gSU9NTVUgYXQKPiBsZWFz
dC4gWW91J3ZlIG1lbnRpb25lZCB0aGF0IHRoaXMgYmVoYXZpb3VyIGlzIGNvdmVyZWQgYnkgUWVt
dSBzaW5jZQo+IGl0IHJlc2V0IElPVExCIG9uIHJlc2V0LiBJIHdvbmRlciB3aGF0IGhhcHBlbnMg
aWYgd2Ugc2ltcGx5IGRlY291cGxlCj4gdGhlIElPVExCIHJlc2V0IGZyb20gdkRQQSByZXNldCBp
biBRZW11LiBDb3VsZCB3ZSBtZWV0IGJ1Z3MgdGhlcmU/Ck5vdCBzdXJlIEkgdW5kZXJzdGFuZC4g
U2ltcGxlIGRlY291cGxlIG1lYW5pbmcgdG8gcmVtb3ZlIG1lbW9yeV9saXN0ZW5lciAKcmVnaXN0
cmF0aW9uL3VucmVnaXN0cmF0aW9uIGNhbGxzICp1bmNvbmRpdGlvbmFsbHkqIGZyb20gdGhlIHZE
UEEgZGV2IApzdGFydC9zdG9wIHBhdGggaW4gUUVNVSwgb3IgbWFrZSBpdCBjb25kaXRpb25hbCBh
cm91bmQgdGhlIGV4aXN0ZW5jZSBvZiAKUEVSU0lTVF9JT1RMQj8gSWYgdW5jb25kaXRpb25hbCwg
aXQgYnJlYWtzIG9sZGVyIGhvc3Qga2VybmVsLCBhcyB0aGUgCm9sZGVyIGtlcm5lbCBzdGlsbCBz
aWxlbnRseSBkcm9wcyBhbGwgbWFwcGluZyBhY3Jvc3MgdkRQQSByZXNldCAoVk0gCnJlYm9vdCks
IGVuZGluZyB1cCB3aXRoIG5ldHdvcmsgbG9zcyBhZnRlcndhcmRzOyBpZiBtYWtlIHRoZSBRRU1V
IGNoYW5nZSAKY29uZGl0aW9uYWwgb24gUEVSU0lTVF9JT1RMQiB3aXRob3V0IHRoZSAucmVzZXRf
bWFwIEFQSSwgaXQgY2FuJ3QgY292ZXIgCnRoZSB2aXJ0aW8tdmRwYSAxOjEgaWRlbnRpdHkgbWFw
cGluZyBjYXNlLgoKPiBCdHcsIGlzIHRoZXJlIGEgUWVtdSBwYXRjaCBmb3IgcmVmZXJlbmNlIGZv
ciB0aGlzIG5ldyBmZWF0dXJlPwpUaGVyZSdzIGEgV0lQIHZlcnNpb24sIG5vdCByZWFkeSB5ZXQg
Zm9yIHJldmlldzoKCmh0dHBzOi8vZ2l0aHViLmNvbS9zaXdsaXUta2VybmVsL3FlbXUKYnJhbmNo
OiB2ZHBhLXN2cS1hc2lkLXBvYwoKV2lsbCBuZWVkIHRvIGNsZWFuIHVwIGNvZGUgYW5kIHNwbGl0
IHRvIHNtYWxsZXIgcGF0Y2hlcyBiZWZvcmUgSSBjYW4gCnBvc3QgaXQsIGlmIHRoZSBrZXJuZWwg
cGFydCBjYW4gYmUgc2V0dGxlZC4KClRoYW5rcywKLVNpd2VpCgo+Cj4gVGhhbmtzCj4KPj4gVGhl
cmUgYXJlIHR3byBjYXNlcyB0aGF0IGJhY2tlbmQgbWF5IGNsYWltCj4+IHRoaXMgZmVhdHVyZSBi
aXQgb246Cj4+Cj4+IC0gcGFyZW50IGRldmljZSB0aGF0IGhhcyB0byB3b3JrIHdpdGggcGxhdGZv
cm0gSU9NTVUKPj4gLSBwYXJlbnQgZGV2aWNlIHdpdGggb24tY2hpcCBJT01NVSB0aGF0IGhhcyB0
aGUgZXhwZWN0ZWQKPj4gICAgLnJlc2V0X21hcCBzdXBwb3J0IGluIGRyaXZlcgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiBS
RkMgdjIgLT4gdjM6Cj4+ICAgIC0gZml4IG1pc3NpbmcgcmV0dXJuIGR1ZSB0byBtZXJnZSBlcnJv
cgo+Pgo+PiAtLS0KPj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDE2ICsr
KysrKysrKysrKysrKy0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8ICAy
ICsrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+IGluZGV4IDcxZmJkNTU5Li5iNDA0NTA0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBAQCAtNDE0LDYg
KzQxNCwxNCBAQCBzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX2hhc19kZXNjX2dyb3VwKGNvbnN0IHN0
cnVjdCB2aG9zdF92ZHBhICp2KQo+PiAgICAgICAgICByZXR1cm4gb3BzLT5nZXRfdnFfZGVzY19n
cm91cDsKPj4gICB9Cj4+Cj4+ICtzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX2hhc19wZXJzaXN0ZW50
X21hcChjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPj4gK3sKPj4gKyAgICAgICBzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPj4gKwo+PiArICAgICAgIHJldHVybiAo
IW9wcy0+c2V0X21hcCAmJiAhb3BzLT5kbWFfbWFwKSB8fCBvcHMtPnJlc2V0X21hcDsKPj4gK30K
Pj4gKwo+PiAgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9z
dF92ZHBhICp2LCB1NjQgX191c2VyICpmZWF0dXJlcCkKPj4gICB7Cj4+ICAgICAgICAgIHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+IEBAIC03MTYsNyArNzI0LDggQEAgc3Rh
dGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4+
ICAgICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9TVF9WRFBBX0JBQ0tFTkRfRkVB
VFVSRVMgfAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9T
VF9CQUNLRU5EX0ZfREVTQ19BU0lEKSB8Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSB8Cj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1JFU1VNRSkpKQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9S
RVNVTUUpIHwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9T
VF9CQUNLRU5EX0ZfSU9UTEJfUEVSU0lTVCkpKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FT1BOT1RTVVBQOwo+PiAgICAgICAgICAgICAgICAgIGlmICgoZmVhdHVyZXMgJiBC
SVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkgJiYKPj4gICAgICAgICAgICAgICAgICAg
ICAgICF2aG9zdF92ZHBhX2Nhbl9zdXNwZW5kKHYpKQo+PiBAQCAtNzMwLDYgKzczOSw5IEBAIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+
PiAgICAgICAgICAgICAgICAgIGlmICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRf
Rl9ERVNDX0FTSUQpKSAmJgo+PiAgICAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfaGFz
X2Rlc2NfZ3JvdXAodikpCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5P
VFNVUFA7Cj4+ICsgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9C
QUNLRU5EX0ZfSU9UTEJfUEVSU0lTVCkpICYmCj4+ICsgICAgICAgICAgICAgICAgICAgICF2aG9z
dF92ZHBhX2hhc19wZXJzaXN0ZW50X21hcCh2KSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FT1BOT1RTVVBQOwo+PiAgICAgICAgICAgICAgICAgIHZob3N0X3NldF9iYWNrZW5k
X2ZlYXR1cmVzKCZ2LT52ZGV2LCBmZWF0dXJlcyk7Cj4+ICAgICAgICAgICAgICAgICAgcmV0dXJu
IDA7Cj4+ICAgICAgICAgIH0KPj4gQEAgLTc4NSw2ICs3OTcsOCBAQCBzdGF0aWMgbG9uZyB2aG9z
dF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1JFU1VNRSk7
Cj4+ICAgICAgICAgICAgICAgICAgaWYgKHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAodikpCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tF
TkRfRl9ERVNDX0FTSUQpOwo+PiArICAgICAgICAgICAgICAgaWYgKHZob3N0X3ZkcGFfaGFzX3Bl
cnNpc3RlbnRfbWFwKHYpKQo+PiArICAgICAgICAgICAgICAgICAgICAgICBmZWF0dXJlcyB8PSBC
SVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKTsKPj4gICAgICAgICAgICAgICAg
ICBpZiAoY29weV90b191c2VyKGZlYXR1cmVwLCAmZmVhdHVyZXMsIHNpemVvZihmZWF0dXJlcykp
KQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FRkFVTFQ7Cj4+ICAgICAgICAgICAg
ICAgICAgYnJlYWs7Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlw
ZXMuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCj4+IGluZGV4IDZhY2M2MDQu
LjBmZGI2ZjAgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5o
Cj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCj4+IEBAIC0xODYsNSAr
MTg2LDcgQEAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSB7Cj4+ICAgICogYnVmZmVycyBt
YXkgcmVzaWRlLiBSZXF1aXJlcyBWSE9TVF9CQUNLRU5EX0ZfSU9UTEJfQVNJRC4KPj4gICAgKi8K
Pj4gICAjZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQgICAgMHg2Cj4+ICsvKiBJT1RM
QiBkb24ndCBmbHVzaCBtZW1vcnkgbWFwcGluZyBhY3Jvc3MgZGV2aWNlIHJlc2V0ICovCj4+ICsj
ZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUICAweDcKPj4KPj4gICAjZW5kaWYK
Pj4gLS0KPj4gMS44LjMuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
