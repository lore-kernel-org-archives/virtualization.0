Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4499EC0032E
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 23:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8078E4195F;
	Wed, 25 Oct 2023 23:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8078E4195F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2IhffpX4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=n542HWMA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dpnQXIaa7f_r; Wed, 25 Oct 2023 23:32:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2C74B418A7;
	Wed, 25 Oct 2023 23:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C74B418A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF251C0039;
	Wed, 25 Oct 2023 23:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B30B8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 23:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CFCA820E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 23:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CFCA820E1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2IhffpX4; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=n542HWMA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ExxvPbZUahB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 23:32:08 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AF8D820D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 23:32:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AF8D820D7
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PLOeuQ019309; Wed, 25 Oct 2023 23:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eb4gEGeVhGoUWrvSAesL6CT7zK0okAqp5k1oj21eilM=;
 b=2IhffpX4DbNKDZGZdS4Og4KGHB48lUQXPiYVmnX6cVbglpSx+m3ZKlZPnjTjitRG1lPB
 pfsYeBTxDYP0oTTTFK4L9YmQaeC6KeLJRbbWKM8hOjULuQW1DlZOxRoabd9vLzbC1ODx
 i1Kd3Tv/AMud4gL6yx8Snh6aG3ROKxabg1MLc1ZihqebxS0USLokHhouX4pWAQzTFvPL
 iQwQQIk79DNFKfm/OBnqrgutkhzMz3dlZvq9AYbaVwZOVpUJ86NlbOjWGj0JqcTg5SJp
 qOzqi19EsAAVLTFjrVksHpqbCAA8zZf5FH5413X51zX/dVqcuw0+K7dPpFH/iguPyvPX +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68thhb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 23:32:06 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39PM3OUh034681; Wed, 25 Oct 2023 23:32:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv537c73m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 23:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7HKfFW6l+pdr1Rpsl4j8REXh70bACg1g+k5kKtEAA0lzipfFxlEAaYwhxg0g7qx1K0w1iDkGhup/IfcfjgNHJUmY3xNEn9jE8sdmDdYxvELXWKSMwCD1sOZKbjlOdhwx9olmB3tDULJ12NNteyYWn7OlsBtBWfjMXJGYtahyb4D8SgtLZ7aGzjzTeRjfFIe1hxnIapoxffLT7MZPmKP+Lxcg+6qemAhegG3sscX2eT+z025HpThuZlS7DBxkT2dnDno/MTBUJRZzYOKJsYDMKazbRjewSUUiZQe3l7TUcRsb43eI6+w2DDKBro28YzrAJ77QL9hbco6MNtoIusW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb4gEGeVhGoUWrvSAesL6CT7zK0okAqp5k1oj21eilM=;
 b=IJKGXHylzYq4L7aSiCwq8wWrOetPjb97D4FzxtGIGyb6JaQDtEWvNnMWIzg39LNZeUaOF4iJQDsj4UwGPB7TwdMi0Rb0OWzfkJ4SqEpxQc+kK95GYg/KfYAuoR2HIP57Vf9JeFOSMWYDy7DQBFSjDkevfJj7FZYvuUIOmOwbJSZdnHp1P2qco/4STFfkzYCv7RA2dSAhbhN7bBtmViTugReXcVkugG8o0+gdjVwI3yM2US3oILKZ63oABjuFw/MEyTeERFZ7WZthKxkc70eo1qtQIQOgbOOfgaMeTNKRYU2z67+chmc6QUyn4fgc0jz/WE/FNX+07TSHzNL5yfD5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb4gEGeVhGoUWrvSAesL6CT7zK0okAqp5k1oj21eilM=;
 b=n542HWMAr0vU4UI7Xy2lMwzsaMRkLfhnXsBKA1qpv534Pr7p8vxJg2KpCwrz1CQ2gQNdC27ajeOKrj6pBjsaOO7eEsr3sWTqNgxNC+MsZVqz3sTqOUZebHUt1jBnuqG8iYL2FE+WAHdl70YnUJ5qjMxTHc/tu4Xa25KwCt6j2eI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB7291.namprd10.prod.outlook.com (2603:10b6:930:7e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 23:31:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 23:31:54 +0000
Message-ID: <d3f13f97-d5ae-4bf9-be9e-aed021fd7a7e@oracle.com>
Date: Wed, 25 Oct 2023 16:31:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Content-Language: en-US
To: Lei Yang <leiyang@redhat.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
 <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
 <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
 <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com>
 <CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: f3071a7c-b271-4a8f-cd44-08dbd5b292a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/1qaQjwI3V5OJCa+3mwnXFsQVAUFyzdn75uFirxrEG29r4lu9afqKr78DP6306IdSN4YE0eWaGqSMzrGrXTAVwPZBrPxHZISab1kV9461pi6s2AbV8700Yxie1FGcKZ/TgHzU077pZO2e0TH07oIStGafPsHRBJWtS4G4iIVhs6rGrxOdcAsNzknTsR3DQEeqT7xmMDasE+REt2LgkodOZ72pWid1vNk6wSGMt2n1z0Hi/o8DtwpENjwtKIxzzskEVBam+jaxjkIxFBy2QybEkbnX0g0II211tKfPkMvNYZ7Ul+QAAGDOoQi5w/9TiWFADdvc4xC0pwbNx8/MH2ImXpxDe02a7z/A0JWsljmIzRCJDwIHBxh3be/rv2lT27qH1SBj/VRICvhcNvWP8bjCKwOoimHhVbOZ3nX52PAhgAytm869M6fg37Oey9LjJTKfgvhRCCpsFy7eZQ1VXkzMmV3dnQmVOl9QTA4+ryYJuXd4ZjCtQxap+Uj8Utxap4RmsOhsurxFCCP07ORrJpI9uaBOPN8H5zZsp6Os5pQmbedVjIq8ZFDxUmnJvQlY2m6P4fkPLLu5sMXRAAc1q6QnjD/CqrSX2csZ2jVp+PgTpbhQdH9iO+nX3JwLShA2X3DYqJMnhxZbF/eRuBKoMPn989+T+w3RNJVbRCtJdbRIfMr/p4GEJtG2WQaDxkSJJS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(31686004)(66899024)(38100700002)(86362001)(41300700001)(2906002)(66476007)(31696002)(36756003)(2616005)(5660300002)(8676002)(8936002)(4326008)(316002)(6506007)(478600001)(36916002)(66946007)(66556008)(6916009)(966005)(83380400001)(6512007)(53546011)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tml3dHNsZi9UcHh2OWhZc0JoNUlDODNwNGNzSUxsa3pqL3RMV2FTamlWbWFD?=
 =?utf-8?B?Uk5Kb01HaTdUWU1OeVFkOE9DOWhVem84WFdJL1k1VU40ZmZzT0Z2Zk1FakJr?=
 =?utf-8?B?b25UcjlydU4wRmp0ckdlUjdKWTVrQlRqMlVOQ1VIcDBaYUVEMUhSV3o1Yysr?=
 =?utf-8?B?dFhQNFhocUlvQkVrZzNWVFdWQkJNQU5BU0ZmM1NCQUJEZElrUDVhcTQxaU1C?=
 =?utf-8?B?MlM2eFpLNldpUEh4aUxWY2hYam12SXkwZm5oTVBCV3h4b2gvdDBzYjZYSmVh?=
 =?utf-8?B?Uk9YT0VCMm8wR2hTUm54eFRKejdDQStVVWJMMFFLTHpEdVNOUFVYSE5JWnRW?=
 =?utf-8?B?a2JTdWRuNTJuM21CUTRHQXV3VDg3UXBPMFlwaGoxZDNRanE3aHFia0tkbjNK?=
 =?utf-8?B?K3ZqSVlQUStNdXR1UjBHT0w2bk5oRWc0Nmdsb282Z05lOHFmQ0pzVFErUFhu?=
 =?utf-8?B?UDVQQitNcklXV3hYQmlvYVNPUlJnRW5NNDhuRWUxSEJCTGNIcTRjNlRac0lx?=
 =?utf-8?B?bmQyTjRYUk5SaEVkTUhBVS84QzcxZXd6cHl6ZTFpNE9temhqNjkwaFZ1RDRp?=
 =?utf-8?B?VVU0dHNabDU0dnFDc0tieGtCL0M4NXp3KzBLNW9IRHpMa1ZrejhubzBoOEcr?=
 =?utf-8?B?SjdMUE40U3lyUjdMNCt2SmhXZE9GVjV3bmRibzNWWmlBeG9wSnRwOUVwVVdv?=
 =?utf-8?B?MEQxNHNmOUp0ZThycE54MUw5a3BzNHliUFdFNGdvdit5VTVKWktTQUo1TmMr?=
 =?utf-8?B?M0ZOaU83TWI2UmlFY055RjhVOW5IQlh4UTF3dWg0ZmZrQVRVUWNjMXJoMDc1?=
 =?utf-8?B?UFJYWlY1ZHc4cW9IR2F6eXZ6czBTbjhBNzNzdFZrYjdBLy9HQTczUlBUWElQ?=
 =?utf-8?B?dHhscnRSdXlndE04SG5nd0c3cFRrMFNKemJ6Y1RuRlU0RXE3cmdIaEFmdXJn?=
 =?utf-8?B?K2kzc0xLQ3NZakVJdExjN1E4bkNFbHpTZXJkTHljcnhMTCtLTjFKTFNySHpV?=
 =?utf-8?B?WHo3Y3BNWS9VY2h6RkdqajFOR3IvMzdlR251eE5lYXpJZjBDalBudFBERTAr?=
 =?utf-8?B?VExyWmZiM3VpcG9laXhPdEpJWjNjc0xvelF5YnBGcCt3YzJVOG9ZeWpqT1hq?=
 =?utf-8?B?a2EzOEVseFJIZzg5elRTZUVWcjBoSjlwY3FoakFMV0IwYVk2UHdvUjJPRVA5?=
 =?utf-8?B?bU92aUYrQnd5L1lIKzV2UFJDcHpYelpzYjVEOTF0SytjVTlpcW9xK2tpVnVZ?=
 =?utf-8?B?bkxoOFU2d0xQdDUveS9rRnVFcTlsOGJySUZmampxVVZpQjhzendoN2hlQXRI?=
 =?utf-8?B?enhGbnZGN21ROE1XK0IwQjdLaGJlYjFBN0tiYjdrMGl0NEZDS2VyKzNaR3lY?=
 =?utf-8?B?TFhlTkpQem9GNURPMm53eGwzb01vQmxJdFplMVhEV04xU09RRDk2WFp0K0hC?=
 =?utf-8?B?Ky9uRWVvN0ljVGtjRDJVeTh4b2dLWnVOaWswNXdqdmlpVHgyMmtCNXdqNld6?=
 =?utf-8?B?M3dZV0I2TGphNk55VHBFdlh6N0F0djZqOVZFcGVkQkwybUE1d21uUUdFZ3Vu?=
 =?utf-8?B?NjhQMnlkcTFYRERVV0w3bTRVbys4ZXlscjVKd25aTlpoR04rQzZJZ21RS1Rw?=
 =?utf-8?B?bjB3UTlUdmNWQjFrUGxxeXBaUjEvdGNmd0pvdUhhVmI2RVdsNnczWkhmeC9T?=
 =?utf-8?B?M0N4alRmVktVSFFLZk9Xbkx6Q2x0MGkzMUpkTk9ITWFrTGRxYmZTSTJjOEpr?=
 =?utf-8?B?Mmh6amlBSnNPVVIzZjNZdHllQm1aWXJ1VUMzVWwzZ2R4TjlXRjZxRlFlV2pw?=
 =?utf-8?B?V3BVNlRmZ240MlIzbmZ1RWQ0bjdsaWhxSGtIQjhUR3FVNWV3bFFYUFlncVNL?=
 =?utf-8?B?VW1sR3VMWnlNWGw2Q1hqRVpOMStVQWlFNUpsOEppelFRWkJKNUFGOXRkQlky?=
 =?utf-8?B?SC9Eb2VNbURnM1dpL29aenp3YmdDNjcyV1ZScmhMOUg1cFZuMmhNU04wRTRy?=
 =?utf-8?B?VFZuakloWkQ5RHZIN2VPQzU4VkU0MnZFdUYzakZQNE4vMUNoUTJpbTVQendk?=
 =?utf-8?B?aU5FbHlzYjBCbFhKbFZnbDRIUFY0c2p3Q0lTWDNvR1lHaTVpVHdaWjI5L01N?=
 =?utf-8?Q?ty9jzoJYLt362KWP46cemicWh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 07a1de9ChPBXyY4nWyWlllHoTii9iHMEPQhBnTrtKUy4lDNCpQlqyfmuZC+Vv3f0dfpeuqoHS2esjwEABI+9jsc9ocWkj7K2BBxRpVSXbd48h6c7HavLbWkOtnlZp3ng9hOZkNCtzdU0lHpkClKbVMphAITaQOhfwQnxcNWDjYNq0CI/OP6Ykc8A4NWl7JGZjm7mnhUwjVg8IWTXOPpzIUeQhA+gg4jZWiwsPzREjNrxycl7W7mOYhv/k9cv217Ui1552qv2PXzEW2ejn2Zybrn2vO/W3vtTqZZOCgPwL/QhvEEwLzomLQsipawQO6cKVnL3ntNpocMQr3T9cnS65jbRqULU+GSgdE1iUuNeFnhZMZTaRe+gxzBqGZW9DU9lSBnE6ZShLbOOq/+L/fGBbEGp53n1VxOc7dsuU/2iMwLTbBQz7DLb3307lr47JyHPJMlb0gouCCu88ysXQzGe4yiOQgUzrj+vidGvj4hjLxlnIeTqmhE2NEsAKZ8u8nqNXsDBRTjMF8OUri19LxIwO9WYWdBOQQVDPa4SXLwtGwpIZ/vn5g3XCKc1q3g9O19Sm1AZuUPzOIiRweB+u5uGPD7RI1jALVs2bP9jxHjbM5QvBkZMnIFiHEd1zftnEwULuAoeZa6BDZErSLTA8ajEjaaCBwCtholGIifrNfVxjunZH2Wm6VabdEFllTO39cX/wEWEBOvIWRHzthFuHLdX4Eh97F1VdpydRkKbr7SEqQ5nMdC+YmX4GO+cPdgKjKBd1yWqYLM5S4/U1nhj0U3dsEaRvXaEBjuhQnPFYY4xZuWc7MdYWOPPugDCFXis+Bq6wFiV09AYU5KghlFLUx4WJQ8LniBTuwAFUrDCgi8oklDU4Sgj0w9D0WAvGdKWgOuG7I64IJFqJ50YlWqiEwoteA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3071a7c-b271-4a8f-cd44-08dbd5b292a5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 23:31:54.6167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wir8x9pdS92hlkTpjlWAqyAEBhah+uZoKbKr64JRT57MJkbUP3Sh3r6gKtnTyQMFFE7MyGlkowORaR2PkI7rZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250199
X-Proofpoint-ORIG-GUID: XN4WYDCnUptGb81WQpaWh0q006C8cAQA
X-Proofpoint-GUID: XN4WYDCnUptGb81WQpaWh0q006C8cAQA
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

SGkgWWFuZyBMZWksCgpUaGFua3MgZm9yIHRlc3RpbmcgbXkgcGF0Y2hlcyBhbmQgcmVwb3J0aW5n
ISBBcyBmb3IgdGhlIGlzc3VlLCBjb3VsZCB5b3UgCnBsZWFzZSB0cnkgd2hhdCBJIHBvc3RlZCBp
bjoKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzE2OTgyNzU1OTQtMTky
MDQtMS1naXQtc2VuZC1lbWFpbC1zaS13ZWkubGl1QG9yYWNsZS5jb20vCgphbmQgbGV0IG1lIGtu
b3cgaG93IGl0IGdvZXM/IFRoYW5rIHlvdSB2ZXJ5IG11Y2ghCgpUaGFua3MsCi1TaXdlaQoKT24g
MTAvMjUvMjAyMyAyOjQxIEFNLCBMZWkgWWFuZyB3cm90ZToKPiBPbiBXZWQsIE9jdCAyNSwgMjAy
MyBhdCAxOjI34oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToK
PiBIZWxsbyBTaS1XZWkKPj4gVGhhbmtzIGEgbG90IGZvciB0ZXN0aW5nISBQbGVhc2UgYmUgYXdh
cmUgdGhhdCB0aGVyZSdzIGEgZm9sbG93LXVwIGZpeAo+PiBmb3IgYSBwb3RlbnRpYWwgb29wcyBp
biB0aGlzIHY0IHNlcmllczoKPj4KPiBUaGUgZmlyc3QsIHdoZW4gSSBkaWQgbm90IGFwcGx5IHRo
aXMgcGF0Y2ggWzFdLCBJIHdpbGwgYWxzbyBoaXQgdGhpcwo+IHBhdGNoIG1lbnRpb25lZCBwcm9i
bGVtLiBBZnRlciBJIGFwcGxpZWQgdGhpcyBwYXRjaCwgdGhpcyBwcm9ibGVtIHdpbGwKPiBubyBs
b25nZXIgdG8gaGl0IGFnYWluLiBCdXQgSSBoaXQgYW5vdGhlciBpc3N1ZXMsIGFib3V0IHRoZSBl
cnJvcgo+IG1lc3NhZ2VzIHBsZWFzZSByZXZpZXcgdGhlIGF0dGFjaGVkIGZpbGUuCj4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzE2OTgxMDI4NjMtMjExMjItMS1n
aXQtc2VuZC1lbWFpbC1zaS13ZWkubGl1QG9yYWNsZS5jb20vCj4KPiBNeSB0ZXN0IHN0ZXBzOgo+
IGdpdCBjbG9uZSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQKPiBjZCAgbGludXgvCj4gYjQgYW0gMTY5Nzg4MDMxOS00OTM3
LTEtZ2l0LXNlbmQtZW1haWwtc2ktd2VpLmxpdUBvcmFjbGUuY29tCj4gYjQgYW0gMjAyMzEwMTgx
NzE0NTYuMTYyNDAzMC0yLWR0YXR1bGVhQG52aWRpYS5jb20KPiBiNCBhbSAxNjk4MTAyODYzLTIx
MTIyLTEtZ2l0LXNlbmQtZW1haWwtc2ktd2VpLmxpdUBvcmFjbGUuY29tCj4gZ2l0IGFtIC4vdjRf
MjAyMzEwMThfZHRhdHVsZWFfdmRwYV9hZGRfc3VwcG9ydF9mb3JfdnFfZGVzY3JpcHRvcl9tYXBw
aW5ncy5tYngKPiBnaXQgYW0gLi92NF8yMDIzMTAyMV9zaV93ZWlfbGl1X3ZkcGFfZGVjb3VwbGVf
cmVzZXRfb2ZfaW90bGJfbWFwcGluZ19mcm9tX2RldmljZV9yZXNldC5tYngKPiBnaXQgYW0gLi8y
MDIzMTAyM19zaV93ZWlfbGl1X3Zob3N0X3ZkcGFfZml4X251bGxfcG9pbnRlcl9kZXJlZl9pbl9f
Y29tcGF0X3ZkcGFfcmVzZXQubWJ4Cj4gY3AgL2Jvb3QvY29uZmlnLTUuMTQuMC0zNzcuZWw5Lng4
Nl82NCAuY29uZmlnCj4gbWFrZSAtaiAzMgo+IG1ha2UgbW9kdWxlc19pbnN0YWxsCj4gbWFrZSBp
bnN0YWxsCj4KPiBUaGFua3MKPgo+IExlaQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0
dWFsaXphdGlvbi8xNjk4MTAyODYzLTIxMTIyLTEtZ2l0LXNlbmQtZW1haWwtc2ktd2VpLmxpdUBv
cmFjbGUuY29tLwo+Pgo+PiBXb3VsZCBiZSBuaWNlIHRvIGhhdmUgaXQgYXBwbGllZCBmb3IgYW55
IHRlc3RzLgo+Pgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pgo+PiBPbiAxMC8yMy8yMDIzIDExOjUx
IFBNLCBMZWkgWWFuZyB3cm90ZToKPj4+IFFFIHRlc3RlZCB0aGlzIHNlcmllcyB2NCB3aXRoIHJl
Z3Jlc3Npb24gdGVzdGluZyBvbiByZWFsIG5pYywgdGhlcmUgaXMKPj4+IG5vIG5ldyByZWdyZXNz
aW9uIGJ1Zy4KPj4+Cj4+PiBUZXN0ZWQtYnk6IExlaSBZYW5nIDxsZWl5YW5nQHJlZGhhdC5jb20+
Cj4+Pgo+Pj4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgNjowMuKAr0FNIFNpLVdlaSBMaXUgPHNp
LXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBPbiAxMC8yMi8yMDIzIDg6NTEg
UE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+IEhpIFNpLVdlaToKPj4+Pj4KPj4+Pj4gT24gU2F0
LCBPY3QgMjEsIDIwMjMgYXQgNToyOOKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xl
LmNvbT4gd3JvdGU6Cj4+Pj4+PiBJbiBvcmRlciB0byByZWR1Y2UgbmVlZGxlc3NseSBoaWdoIHNl
dHVwIGFuZCB0ZWFyZG93biBjb3N0Cj4+Pj4+PiBvZiBpb3RsYiBtYXBwaW5nIGR1cmluZyBsaXZl
IG1pZ3JhdGlvbiwgaXQncyBjcnVjaWFsIHRvCj4+Pj4+PiBkZWNvdXBsZSB0aGUgdmhvc3QtdmRw
YSBpb3RsYiBhYnN0cmFjdGlvbiBmcm9tIHRoZSB2aXJ0aW8KPj4+Pj4+IGRldmljZSBsaWZlIGN5
Y2xlLCBpLmUuIGlvdGxiIG1hcHBpbmdzIHNob3VsZCBiZSBsZWZ0Cj4+Pj4+PiBpbnRhY3QgYWNy
b3NzIHZpcnRpbyBkZXZpY2UgcmVzZXQgWzFdLiBGb3IgaXQgdG8gd29yaywgdGhlCj4+Pj4+PiBv
bi1jaGlwIElPTU1VIHBhcmVudCBkZXZpY2UgY291bGQgaW1wbGVtZW50IGEgc2VwYXJhdGUKPj4+
Pj4+IC5yZXNldF9tYXAoKSBvcGVyYXRpb24gY2FsbGJhY2sgdG8gcmVzdG9yZSAxOjEgRE1BIG1h
cHBpbmcKPj4+Pj4+IHdpdGhvdXQgaGF2aW5nIHRvIHJlc29ydCB0byB0aGUgLnJlc2V0KCkgY2Fs
bGJhY2ssIHRoZQo+Pj4+Pj4gbGF0dGVyIG9mIHdoaWNoIGlzIG1haW5seSB1c2VkIHRvIHJlc2V0
IHZpcnRpbyBkZXZpY2Ugc3RhdGUuCj4+Pj4+PiBUaGlzIG5ldyAucmVzZXRfbWFwKCkgY2FsbGJh
Y2sgd2lsbCBiZSBpbnZva2VkIG9ubHkgYmVmb3JlCj4+Pj4+PiB0aGUgdmhvc3QtdmRwYSBkcml2
ZXIgaXMgdG8gYmUgcmVtb3ZlZCBhbmQgZGV0YWNoZWQgZnJvbQo+Pj4+Pj4gdGhlIHZkcGEgYnVz
LCBzdWNoIHRoYXQgb3RoZXIgdmRwYSBidXMgZHJpdmVycywgZS5nLgo+Pj4+Pj4gdmlydGlvLXZk
cGEsIGNhbiBzdGFydCB3aXRoIDE6MSBETUEgbWFwcGluZyB3aGVuIHRoZXkKPj4+Pj4+IGFyZSBh
dHRhY2hlZC4gRm9yIHRoZSBjb250ZXh0LCB0aG9zZSBvbi1jaGlwIElPTU1VIHBhcmVudAo+Pj4+
Pj4gZGV2aWNlcywgY3JlYXRlIHRoZSAxOjEgRE1BIG1hcHBpbmcgYXQgdmRwYSBkZXZpY2UgY3Jl
YXRpb24sCj4+Pj4+PiBhbmQgdGhleSB3b3VsZCBpbXBsaWNpdGx5IGRlc3Ryb3kgdGhlIDE6MSBt
YXBwaW5nIHdoZW4KPj4+Pj4+IHRoZSBmaXJzdCAuc2V0X21hcCBvciAuZG1hX21hcCBjYWxsYmFj
ayBpcyBpbnZva2VkLgo+Pj4+Pj4KPj4+Pj4+IFRoaXMgcGF0Y2hzZXQgaXMgcmViYXNlZCBvbiB0
b3Agb2YgdGhlIGxhdGVzdCB2aG9zdCB0cmVlLgo+Pj4+Pj4KPj4+Pj4+IFsxXSBSZWR1Y2luZyB2
ZHBhIG1pZ3JhdGlvbiBkb3dudGltZSBiZWNhdXNlIG9mIG1lbW9yeSBwaW4gLyBtYXBzCj4+Pj4+
PiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2c5
NTM3NTUuaHRtbAo+Pj4+Pj4KPj4+Pj4+IC0tLQo+Pj4+Pj4gdjQ6Cj4+Pj4+PiAtIFJld29yayBj
b21wYXRpYmlsaXR5IHVzaW5nIG5ldyAuY29tcGF0X3Jlc2V0IGRyaXZlciBvcAo+Pj4+PiBJIHN0
aWxsIHRoaW5rIGhhdmluZyBhIHNldF9iYWNrZW5kX2ZlYXR1cmUoKQo+Pj4+IFRoaXMgd2lsbCBv
dmVybG9hZCBiYWNrZW5kIGZlYXR1cmVzIHdpdGggdGhlIHJvbGUgb2YgY2Fycnlpbmcgb3Zlcgo+
Pj4+IGNvbXBhdGliaWxpdHkgcXVpcmtzLCB3aGljaCBJIHRyaWVkIHRvIGF2b2lkIGZyb20uIFdo
aWxlIEkgdGhpbmsgdGhlCj4+Pj4gLmNvbXBhdF9yZXNldCBmcm9tIHRoZSB2NCBjb2RlIGp1c3Qg
d29ya3Mgd2l0aCB0aGUgYmFja2VuZCBmZWF0dXJlcwo+Pj4+IGFja25vd2xlZGdlbWVudCAoYW5k
IG1heWJlIG90aGVycyBhcyB3ZWxsKSB0byBkZXRlcm1pbmUsIGJ1dCBub3QKPj4+PiBkaXJlY3Rs
eSB0aWUgaXQgdG8gYmFja2VuZCBmZWF0dXJlcyBpdHNlbGYuIFRoZXNlIHR3byBoYXZlIGRpZmZl
cmVudAo+Pj4+IGltcGxpY2F0aW9ucyBpbiB0ZXJtcyBvZiByZXF1aXJlbWVudCwgc2NvcGUgYW5k
IG1haW50YWluaW5nL2RlcHJlY2F0aW9uLAo+Pj4+IGJldHRlciB0byBjb3BlIHdpdGggY29tcGF0
IHF1aXJrcyBpbiBleHBsaWNpdCBhbmQgZHJpdmVyIHZpc2libGUgd2F5Lgo+Pj4+Cj4+Pj4+ICAg
ICBvciByZXNldF9tYXAoY2xlYW49dHJ1ZSkgbWlnaHQgYmUgYmV0dGVyLgo+Pj4+IEFuIGV4cGxp
Y2l0IG9wIG1pZ2h0IGJlIG1hcmdpbmFsbHkgYmV0dGVyIGluIGRyaXZlciB3cml0ZXIncyBwb2lu
dCBvZgo+Pj4+IHZpZXcuIENvbXBsaWFudCBkcml2ZXIgZG9lc24ndCBoYXZlIHRvIGJvdGhlciBh
c3NlcnRpbmcgY2xlYW5fbWFwIG5ldmVyCj4+Pj4gYmUgdHJ1ZSBzbyB0aGVpciBjb2RlIHdvdWxk
IG5ldmVyIGJvdGhlciBkZWFsaW5nIHdpdGggdGhpcyBjYXNlLCBhcwo+Pj4+IGV4cGxhaW5lZCBp
biB0aGUgY29tbWl0IGxvZyBmb3IgcGF0Y2ggNSAidmhvc3QtdmRwYTogY2xlYW4gaW90bGIgbWFw
Cj4+Pj4gZHVyaW5nIHJlc2V0IGZvciBvbGRlciB1c2Vyc3BhY2UiOgo+Pj4+Cj4+Pj4gIgo+Pj4+
ICAgICAgICBUaGUgc2VwYXJhdGlvbiBvZiAuY29tcGF0X3Jlc2V0IGZyb20gdGhlIHJlZ3VsYXIg
LnJlc2V0IGFsbG93cwo+Pj4+ICAgICAgICB2aG9zdC12ZHBhIGFibGUgdG8ga25vdyB3aGljaCBk
cml2ZXIgaGFkIGJyb2tlbiBiZWhhdmlvciBiZWZvcmUsIHNvIGl0Cj4+Pj4gICAgICAgIGNhbiBh
cHBseSB0aGUgY29ycmVzcG9uZGluZyBjb21wYXRpYmlsaXR5IHF1aXJrIHRvIHRoZSBpbmRpdmlk
dWFsCj4+Pj4gZHJpdmVyCj4+Pj4gICAgICAgIHdoZW5ldmVyIG5lZWRlZC4gIENvbXBhcmVkIHRv
IG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQgd2l0aAo+Pj4+ICAgICAgICBmbGFncywg
LmNvbXBhdF9yZXNldCB3b24ndCBjYXVzZSBhbnkgZXh0cmEgYnVyZGVuIHRvIHRoZSBpbXBsZW1l
bnRhdGlvbgo+Pj4+ICAgICAgICBvZiBldmVyeSBjb21wbGlhbnQgZHJpdmVyLgo+Pj4+ICIKPj4+
Pgo+Pj4+PiAgICAgQXMgaXQgdHJpZXMgaGFyZCB0byBub3QgaW50cm9kdWNlIG5ldyBzdHVmZiBv
biB0aGUgYnVzLgo+Pj4+IEhvbmVzdGx5IEkgZG9uJ3Qgc2VlIHN1YnN0YW50aWFsIGRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGVzZSBvdGhlciB0aGFuIHRoZQo+Pj4+IGNvbG9yLiBUaGVyZSdzIG5vIHNp
bmdsZSBiZXN0IHNvbHV0aW9uIHRoYXQgc3RhbmRzIG91dCBhbW9uZyB0aGUgMy4gQW5kCj4+Pj4g
SSBhc3N1bWUgeW91IGFscmVhZHkgbm90aWNlZCBpdCBmcm9tIGFsbCB0aGUgYWJvdmUgMyBhcHBy
b2FjaGVzIHdpbGwKPj4+PiBoYXZlIHRvIGdvIHdpdGggYmFja2VuZCBmZWF0dXJlcyBuZWdvdGlh
dGlvbiwgdGhhdCB0aGUgMXN0IHZkcGEgcmVzZXQKPj4+PiBiZWZvcmUgYmFja2VuZCBmZWF0dXJl
IG5lZ290aWF0aW9uIHdpbGwgdXNlIHRoZSBjb21wbGlhbnQgdmVyc2lvbiBvZgo+Pj4+IC5yZXNl
dCB0aGF0IGRvZXNuJ3QgY2xlYW4gdXAgdGhlIG1hcC4gV2hpbGUgSSBkb24ndCB0aGluayB0aGlz
IG51YW5jZQo+Pj4+IG1hdHRlcnMgbXVjaCB0byBleGlzdGluZyBvbGRlciB1c2Vyc3BhY2UgYXBw
cywgYXMgdGhlIG1hcHMgc2hvdWxkCj4+Pj4gYWxyZWFkeSBnZXQgY2xlYW5lZCBieSBwcmV2aW91
cyBwcm9jZXNzIGluIHZob3N0X3ZkcGFfY2xlYW51cCgpLCBidXQgaWYKPj4+PiBidWctZm9yLWJ1
ZyBiZWhhdmlvcmFsIGNvbXBhdGliaWxpdHkgaXMgd2hhdCB5b3Ugd2FudCwgbW9kdWxlIHBhcmFt
ZXRlcgo+Pj4+IHdpbGwgYmUgdGhlIHNpbmdsZSBiZXN0IGFuc3dlci4KPj4+Pgo+Pj4+IFJlZ2Fy
ZHMsCj4+Pj4gLVNpd2VpCj4+Pj4KPj4+Pj4gQnV0IHdlIGNhbiBsaXN0ZW4gdG8gb3RoZXJzIGZv
ciBzdXJlLgo+Pj4+Pgo+Pj4+PiBUaGFua3MKPj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
