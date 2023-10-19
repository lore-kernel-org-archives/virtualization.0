Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D98CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 06:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8E083AFA;
	Thu, 19 Oct 2023 06:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F8E083AFA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=tesgqGp3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=zK7hJjMN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1wBc0y8NVYv; Thu, 19 Oct 2023 06:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAC7583AD9;
	Thu, 19 Oct 2023 06:46:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAC7583AD9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8110AC0071;
	Thu, 19 Oct 2023 06:46:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94B95C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60A8142498
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:46:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60A8142498
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=tesgqGp3; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=zK7hJjMN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r88arWGZMYwl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:46:48 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A769400A6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 06:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A769400A6
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39J3TuVF022581; Thu, 19 Oct 2023 06:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kEWFKnHJ4JeJj1gnMEQnam9SE5eTp9C2iRP8xKn+f8A=;
 b=tesgqGp3XnlQ1mra7ZZ2tAZu8u5kw0OuiCiDXGM7UqSpN5EcIU+PrS7jQPD+OEWSOsJI
 0I+pSeQH/wwRZxh0aseFgJ1iVKoIL/SrO2HJYWwbCVZH/ZBLhrhUnydcZcxFHJH4cp9Q
 qZTQIhH8x2RlD9J797iDug3q67tIyH+Cb/RkpxbQJmqbyXypEqzh73i/cjbdo4/ktYcX
 +huWsc9s2z8Bhyqhy0sm5/3b4w1tXrxxoCUMqYhND+fhaEIBNpFY5XqAXCFkpIJOcZcw
 WuJSmg3GGnAwsz1Y/Atv7ByFlAYPB/m3Za4ii/Lf1T2OQ1sq+Brz9MV1drOjrOSMP2Mm KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28spqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 06:46:43 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39J4XZmo010606; Thu, 19 Oct 2023 06:46:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg0q9ujm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 06:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0UwAk6TtVk7peA65l+zXZlPNuEDVPaisPjOR6lUJcMh25xooHKu6krJuQo3AA+E0qrKuaXOnrMUReysXn7iC4KR+etPXaQeXnn8Z9U/i9qyWD3D23PiE8Jxx5SF7/oD9j2uY6CMRl56cp5LsK5Pa4NvM6IKxZMSTvUdbuFxjZQoq/S9ckjtUQcWJKHAgpsBP1gSUW/I77QeY7ceMNEnNuEE3gM0K2XuCg1WYTW9iC9Gjbynq3ydg+WLcYMU0VWhJJNpunRwNSsY20Xh08X9CjWmimfXoqNcUgB3BNB+XXdbI7TvXz10t+DCQIStw9+9G5C5Sih6nODKqsg92BXqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEWFKnHJ4JeJj1gnMEQnam9SE5eTp9C2iRP8xKn+f8A=;
 b=PkLKR9OfHyTmA610sWdWavxNpt8low02zmdS1pvJuWerJqTmZelQSx9X8X01rU0lF4wTENP2ItdC2H8HMv9OD6RqmDiJ2HxG+frGdFXYQBheMiAz9d0Jvqtd+z6xiq8vceZ7grKnOgUvnf4mYRLALrqI/rNbyBOvoxRcCp9ZZuzQv/V7bk71dK4dPv+qjy9lSuE260+mb7cLwhgIBYTQdQWJFkzrT8tFqrVCybR1hdDr+L2sJCQ6V79ROUZu/fqblvkjL73JFLQXSSqrvp01dFPjTS4IDg7h3CNPj/eWYO2ulf7Ud4KpbSh9J+YN+FXu2CGOzqtAWYFVSBmr9G/CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEWFKnHJ4JeJj1gnMEQnam9SE5eTp9C2iRP8xKn+f8A=;
 b=zK7hJjMNRt/3QGCs54pE/Xl1+FAoJ5w3lkObjnFuDqsoODkBZBljGsq/jodemQbyx36YF2CMw02h7qT6JxiKBRzd7r43IcSKOBKFBHViWoW9OoEODuka+j0wh1TXdIvrAQFlQZCPrVK+Q7hM9fOvq/tEeV7aJDsHiP2gJH8s0yE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BLAPR10MB5330.namprd10.prod.outlook.com (2603:10b6:208:333::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 06:46:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 06:46:39 +0000
Message-ID: <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com>
Date: Wed, 18 Oct 2023 23:46:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
 <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
 <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BLAPR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffc1611-f0b1-44ea-165c-08dbd06f2556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88bWHIAMp3T1P8chAN4dr9opIbjaDC9pdtbrgEAZ3hjykrz4XY2LLaXxorQ0qV9xInLELQlCXh7VZbpdpaoT97jvP5EdhQAa3BI9ZbO0LTmk2NahIsRcBcWf8CxGq86SDFpLSf9IehIUBqerUHn5a0HBHXlJqLsOdCbe280LV38OdzvdbN4kUdNeRuhAlG755IrpdOGqhwc2d2ShHy8RbpMvDtjBoe1i4B3g35/oNkWuvY47hy3dAVwcd5Ndj3XSzDL4NyC5+d6u9cX76VyuJ4wVEuaqGhVsadAZKlIFkiU4LvK/v5APhCVl7xgeyt2bADgXcU6Ob7+QshDGjYChm+mIp9T07qKriH8/xtIiX0oyTMBjooKjtRKhuUr7DfnXNugqTUnTsFitNyk7JnjQxt991caFRn2phA70h9KFMaqFG0DW0X4ubUmtTecvn4ThTj0XjubMSHqrP9i3Usq6xAyk+EG8NJNqoCHreG4iyOokwRU1IQ0zEmx0Je7zdY7fc4ABcHLBBb1YZ32RD5vsjdpUOOyJM9bV5SCRtEST74o7wl0Ayv7FRobF+yqXNAbiXeMcAA3CPKA3vq6QmlawrDDserUnLGvc/MqWyljdnsIF+IU6a16+5kPNyOfLq97sHRxIlebC2gCx7mLUf+uzLMxR7Ei4F+vLeP/FXHyiHQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66899024)(2616005)(2906002)(4326008)(41300700001)(26005)(31696002)(86362001)(36756003)(53546011)(38100700002)(478600001)(6486002)(966005)(6512007)(36916002)(6506007)(6666004)(6916009)(316002)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(83380400001)(31686004)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tiMHhzaElpUVFqUU9ZWFJLSjJNeWRTM3hBdE1aRkUremFEN2lOY2Jic0Zy?=
 =?utf-8?B?c2VmRDRYZjB6SnAvemxCQ2JtdjBZeFlBSzIxOW5mWUFsYmRxSlhXT0JXcC9T?=
 =?utf-8?B?UFpKOThRbTR1a00yN2pYQzNyZnZQVWZMSXRYMWVPV2cvS01ySW5scHBRNjdV?=
 =?utf-8?B?WFRCbzhTellFRTNqalNyZVpsYzM5VTVQRzVJSU00bTRqQ0dNTm1SOXVhdDNU?=
 =?utf-8?B?ZVdjdjRhZDBOTXIrOXc5T1p5eFBNdkdLVEtmanAzVjNFT0U1NlV2TDBNYWtU?=
 =?utf-8?B?MExXQUVJVENORzlDUVNtclNZZjA3RStWODRBbzFUUnFJNVNvT2xpQUtoRElU?=
 =?utf-8?B?dVY4ZVZWTUpUNFFZdlR5dnNFVVBJUWpWbWtBWWx3S1NVN1daSWI2ZXBLQnZE?=
 =?utf-8?B?bkd4QVpSMFdkQWErN1YxODl3aEIwdGRRRUJmUDZqc1hud09jMkZ5dmVvM1lr?=
 =?utf-8?B?aHdkSjQxRUNlYzMvbGZBUU0wLzNlY3ZFWC8xa2NTMCtIeSt5bS8raVJsMlFx?=
 =?utf-8?B?N0l0VlRsNkMrQlpYRDVyVSt2bmpMelpZWTVhRUhyNU50Y0dic0pLN05OOGRJ?=
 =?utf-8?B?YnlFTGlJaGFTQktaS3c1N25ZNGlkbFlzR1Ivak5zRk85eEc5Y1pUTkFRRXNw?=
 =?utf-8?B?SlEyU2ZYUjk2S1NrT0RxY1ZTYzh2bFdyL3BsckswV2tQY2QxbmJ4dEwxZmxN?=
 =?utf-8?B?emwweUthWkk0N25MOHNIZ0s4N2orOCtycjhCKzVCZEpkWGhpTjIrdmduaW83?=
 =?utf-8?B?aTNYSnl6RWxoRXRPTWExV2V5RS9WM21qeFVZUkNaRXpDTmthZk1GSUk3Rnc2?=
 =?utf-8?B?OWFiWnZxS2VweDQ2d1R1VmNWb0IrYWNOTWRIL1crRUNMMzhCbmR4SFA1bjBU?=
 =?utf-8?B?dlJWZVU2akhSbVdCTmh4cnNiY0FudnU5WGNpalRBUEMrSWlyOEo2NVBLeFNX?=
 =?utf-8?B?ZjA5OElJQlRpOWloY1plUGxNTFpIazk4ZGt0MCtRaFNUNWorSkpTdmxicDlT?=
 =?utf-8?B?YzFSQ1FBRy95akFEQUZvdDdFQ2I3VUdyNXVRWm9td08rL0RvTkd2NTJVK0RP?=
 =?utf-8?B?VG5udTVkUDVnc2xRY2pmRTkzUVpYSjhSb20rQ24xN3luQnNnYVYxOGhpVlRa?=
 =?utf-8?B?S0dZYTlvZkpZL1ZmNTlhWllMOHdwcmJ4VE9yUnNWYnY0Qk1hTE1QMGdzNWxh?=
 =?utf-8?B?a2hxcmk3RGdldUxMdjBLVFNQcGh4RU8rNzh4SU54dkpQS28rNS9mK2dsOTVN?=
 =?utf-8?B?V2RsN29FcDdFT09rYy9TNFlqY3BBSHFmbmZNZCtVS25hK3ZNeHdEZ1ZQeVVm?=
 =?utf-8?B?bi9xZjE4dDF6TVVQTzhWOTM5MUZaTlFtM1lES211NFV5aXVkVjJjY0ZBV29i?=
 =?utf-8?B?bHo3T0lzL1Zzd2ZJdGg1dHYyUThvQWdPYlVRekx3SG9yekZReFUzSHNqWHZu?=
 =?utf-8?B?bm50SVFkYTlaY0N6bm1sVExVUTExVk9GRmE3QkFKM2d4cVZPVVZhaHd5WDhi?=
 =?utf-8?B?bGQxQ294RXBTQjRpYzFjUjF6RG1CbU01YjNKU2RzVWhaOWFHcFJJcWdUNnha?=
 =?utf-8?B?dFpyWW9YT283WTRPWXVRMC9UcjU2WnkrS2hwSTN1WThTaEFHcGdzVTNCNS81?=
 =?utf-8?B?UTUzTEVRTHAwcDR0K3FJaStaZ3VjNDJaNnZEM2hKU0Z4Q0NjMXI5Ukp1NTRS?=
 =?utf-8?B?bStNRTJKMWFaeDlqeEJIN29pRWNBUHlLQlp1bE9OUmwzdUpVdk93NUdncG4y?=
 =?utf-8?B?TWQzQ3N0ZHNGbXVsNCtiaXpiNU0zZEM2V3dpMnpMczU3WGZtT2MxU1IzdHlr?=
 =?utf-8?B?NEdTOVprd3RVdVZFMzdXK05vdGFBdytjbldEekpNcE5tU01GaEF4UE1McUdz?=
 =?utf-8?B?RUUrVjdlVS9CL29rVEdiSzQ3b3g2cWxOVEROcEpWQzdpc0RVVmxNRFZmSlNw?=
 =?utf-8?B?QTY1UERvekFjd0lDNm1MdzBQUDhZd1Uzamk2eDVsMnZWLzJkNU1BSnhpMnVF?=
 =?utf-8?B?dEJDUGRkNlVUUFQyaHhwc0JyUURDQzBPSm94TWRaRWIvbnBQV2hNcFlSM1pp?=
 =?utf-8?B?d0MwRVlBMzlzWk8zTFBHRUNyazdxUDc1Q28yS21wYWtZbWxpdVhUM3JGUU5t?=
 =?utf-8?Q?XPGz6SZYfjW8jBKyg8cbNWsR/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NFZjajJmN3k2dnBQejFTSG1aYytmZS84bVpPTGNYQVpRR3l5WHVMZUs0VlUv?=
 =?utf-8?B?UUFNZVNIV1c5L0o4SEl4MnBEV0RyWkYxU1lPaERMU2d4dURrUVoxOEVRRG4z?=
 =?utf-8?B?Uy9kRVJPaVovSXNSYW4ybFZDbWVrTFQwSTRuVUtrckJrMGQvaGk4QlIxZnM3?=
 =?utf-8?B?Nzl4T1AwbjJxczZSakRpaVFORlNhcHMwUWNTU1lidDlhOGxHUG1SUWF2VzFt?=
 =?utf-8?B?cTVxcUFwbzM1RzY5TWt3UHZTSkZKOHdWdDFhY1hNd0FPeHV6aFFQaUdBS2tV?=
 =?utf-8?B?b0RiYjRsQ3lLcGE2QkxBZmY4b2hyWGdWUmlseURUcTgvL2k2cUQvSFBuN05O?=
 =?utf-8?B?RXVCL3pOOHZzYlNFZmIyVVZoUk56cnpKdkY0RWVvNDBYNDg1dWpTNXpvTzho?=
 =?utf-8?B?NHArL3dvQ1U2MytkL013QzlsbjgwN1BNUVYxZ3VNQndjU1JFbHNmQ0p5NWV5?=
 =?utf-8?B?ajBsNHdoU1JoVFpMTkQ0cDNEK2xVVXp0Q1piT2V1ejBSSFphMmxFbXJVRFdU?=
 =?utf-8?B?L2JEZ3ZFODlBMkpRdnVvUTZzdkdBKzVvUnNaMkswYUExOHdTTU81NDFyOFE1?=
 =?utf-8?B?cTBvTEJ0VmcvRkxMNlRpWlJNOTA2SWtiWFJqMVhkai81QzRRRm9QSytNNGtK?=
 =?utf-8?B?VTV6aFN3elFTQURhZDM4UnFnbU9WdlVZdlFNckwrK2NySnNRSldTeWJMbkJS?=
 =?utf-8?B?cy9OSjZIQUJMOUZCQ21SaFp1K2hkTTFGTDJ3djFRTUtXWjh4Z3ZWTFp6YjE2?=
 =?utf-8?B?eVVmb04rUDdwRUdiRWlKb3cyaE5EZ094WGtUK0VUV3k5amF1Y2VucU1BQmxx?=
 =?utf-8?B?TDArUGFGNFN0WlVHV2gyY2ZVNS95QjNXbkhDN0RERHdoeERtbWNxVW42bmgr?=
 =?utf-8?B?RWJidDlzL0ZTYVZtNnJnZUgzN0UvU0JZL1dEZzEyN0hSa0Fyeno3dEg5N0hP?=
 =?utf-8?B?elRGT2d2bExmQ1psVlhvREgveWN3UmdyRlZxTUNGRzdYNFpBN2NQaVlqSHU0?=
 =?utf-8?B?Vmx1Y0VqV1BFUXh6MVU3STJiS2JOODBoc2JJQ3FNaW9LejZNVHplZFY1RWFZ?=
 =?utf-8?B?UXJZZTBWOFgrWFU0aVpSRU5ld3Z2bWpqallLK0VoZXRFUXpvZ3VHTzdzTm9w?=
 =?utf-8?B?S21zRjRhWnBiMDdYQzZLemlvRWhKeDBzR3Rqbkxidzcwem83T2RhOUQzbmt0?=
 =?utf-8?B?WnBjekJzZFI3UHJIVHoxR3FRMjNHM2gyczU0OVlqa21QRDBiMU1rZHZ2K0FI?=
 =?utf-8?Q?c8VNupd3IfXzYAs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffc1611-f0b1-44ea-165c-08dbd06f2556
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:46:39.2403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRgm2LWBZitss6xTmTfGmXDMniTEJCE2+nSXCBQJykR3XKPy36YBQJYx2xlbEaL3r2dK4BIazNXP84x8+RO+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190057
X-Proofpoint-ORIG-GUID: 5lVNoExy9np3SmB_pMQ4eNEBVdIESCqr
X-Proofpoint-GUID: 5lVNoExy9np3SmB_pMQ4eNEBVdIESCqr
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>
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

CgpPbiAxMC8xOC8yMDIzIDc6NTMgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gV2VkLCBPY3Qg
MTgsIDIwMjMgYXQgNDo0OeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4g
d3JvdGU6Cj4+Cj4+Cj4+IE9uIDEwLzE4LzIwMjMgMTI6MDAgQU0sIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4gVW5mb3J0dW5hdGVseSwgaXQncyBhIG11c3QgdG8gc3RpY2sgdG8gQUJJLiBJIGFncmVl
IGl0J3MgYSBtZXNzIGJ1dCB3ZQo+Pj4+IGRvbid0IGhhdmUgYSBiZXR0ZXIgY2hvaWNlLiBPciB3
ZSBjYW4gZmFpbCB0aGUgcHJvYmUgaWYgdXNlcnNwYWNlCj4+Pj4gZG9lc24ndCBhY2sgdGhpcyBm
ZWF0dXJlLgo+Pj4gQW50b2hlciBpZGVhIHdlIGNhbiBqdXN0IGRvIHRoZSBmb2xsb3dpbmcgaW4g
dmhvc3RfdmRwYSByZXNldD8KPj4+Cj4+PiBjb25maWctPnJlc2V0KCkKPj4+IGlmIChJT1RMQl9Q
RVJTSVNUIGlzIG5vdCBzZXQpIHsKPj4+ICAgICAgIGNvbmZpZy0+cmVzZXRfbWFwKCkKPj4+IH0K
Pj4+Cj4+PiBUaGVuIHdlIGRvbid0IGhhdmUgdGhlIGJ1cmRlbiB0byBtYWludGFpbiB0aGVtIGlu
IHRoZSBwYXJlbnQ/Cj4+Pgo+Pj4gVGhhbmtzCj4+IFBsZWFzZSBzZWUgbXkgZWFybGllciByZXNw
b25zZSBpbiB0aGUgb3RoZXIgZW1haWwsIHRoYW5rcy4KPj4KPj4gLS0tLS0tLS0tLS0tLS0tLSU8
LS0tLS0tLS0tLS0tLS0tLSU8LS0tLS0tLS0tLS0tLS0tLQo+Pgo+PiBGaXJzdCwgdGhlIGlkZWFs
IGZpeCB3b3VsZCBiZSB0byBsZWF2ZSB0aGlzIHJlc2V0X3ZlbmRvcl9tYXBwaW5ncygpCj4+IGVt
dWxhdGlvbiBjb2RlIG9uIHRoZSBpbmRpdmlkdWFsIGRyaXZlciBpdHNlbGYsIHdoaWNoIGFscmVh
ZHkgaGFzIHRoZQo+PiBicm9rZW4gYmVoYXZpb3IuCj4gU28gdGhlIHBvaW50IGlzLCBub3QgYWJv
dXQgd2hldGhlciB0aGUgZXhpc3RpbmcgYmVoYXZpb3IgaXMgImJyb2tlbiIKPiBvciBub3QuCkhv
bGQgb24sIEkgdGhvdWdodCBlYXJsaWVyIHdlIGFsbCBhZ3JlZWQgdXBvbiB0aGF0IHRoZSBleGlz
dGluZyBiZWhhdmlvciAKb2YgdmVuZG9yIGRyaXZlciBzZWxmLWNsZWFyaW5nIG1hcHMgZHVyaW5n
IC5yZXNldCB2aW9sYXRlcyB0aGUgdmhvc3QgCmlvdGxiIGFic3RyYWN0aW9uIGFuZCBhbHNvIGJy
ZWFrcyB0aGUgLnNldF9tYXAvLmRtYV9tYXAgQVBJLiBUaGlzIGlzIAoxMDAlIGJ1Z2d5IGRyaXZl
ciBpbXBsZW1lbnRhdGlvbiBpdHNlbGYgdGhhdCB3ZSBzaG91bGQgZGlzY291cmFnZSBvciAKZWxp
bWluYXRlIGFzIG11Y2ggYXMgcG9zc2libGUgKHRoYXQncyBwYXJ0IG9mIHRoZSBnb2FsIGZvciB0
aGlzIHNlcmllcyksIApidXQgaGVyZSB5b3Ugc2VlbSB0byBnbyBleGlzdGVudGlhbGlzbSBhbmQg
c3VnZ2VzdHMgdGhlIHZlcnkgb3Bwb3NpdGUgCnRoYXQgZXZlcnkgLnNldF9tYXAvLmRtYV9tYXAg
ZHJpdmVyIGltcGxlbWVudGF0aW9uLCByZWdhcmRsZXNzIGJlaW5nIHRoZSAKY3VycmVudCBvciB0
aGUgbmV3L3VwY29taW5nLCBzaG91bGQgdW5jb25kaXRpb25hbGx5IHRyeSB0byBlbXVsYXRlIHRo
ZSAKYnJva2VuIHJlc2V0IGJlaGF2aW9yIGZvciB0aGUgc2FrZSBvZiBub3QgYnJlYWtpbmcgb2xk
ZXIgdXNlcnNwYWNlLiBTZXQgCmFzaWRlIHRoZSBjcml0ZXJpYSBhbmQgZGVmaW5pdGlvbiBmb3Ig
aG93IHVzZXJzcGFjZSBjYW4gYmUgYnJva2VuLCBjYW4gCndlIHN0ZXAgYmFjayB0byB0aGUgb3Jp
Z2luYWwgcXVlc3Rpb24gd2h5IHdlIHRoaW5rIGl0J3MgYnJva2VuLCBhbmQgd2hhdCAKd2UgY2Fu
IGRvIHRvIHByb21vdGUgZ29vZCBkcml2ZXIgaW1wbGVtZW50YXRpb24gaW5zdGVhZCBvZiBkaXNj
dXNzIHRoZSAKaW1wbGVtZW50YXRpb24gZGV0YWlscz8gUmVhZGluZyB0aGUgYmVsb3cgcmVzcG9u
c2UgSSBmb3VuZCBteSBtYWpvciAKcG9pbnRzIGFyZSBub3QgaGVhcmQgZXZlbiBpZiB3cml0dGVu
IGZvciBxdWl0ZSBhIGZldyB0aW1lcy4gSXQncyBub3QgCnRoYXQgSSBkb24ndCB1bmRlcnN0YW5k
IHRoZSBpbXBvcnRhbmNlIG9mIG5vdCBicmVha2luZyBvbGQgdXNlcnNwYWNlLCBJIAphcHByZWNp
YXRlIHlvdXIgcXVlc3Rpb25zIGFuZCBleHRyYSBwYXRpZW5jZSwgaG93ZXZlciBJIGRvIGZlZWwg
dGhlIAoiYnJva2VuIiBwYXJ0IGlzIHZlcnkgcmVsZXZhbnQgdG8gb3VyIGRpc2N1c3Npb24gaGVy
ZS4KCklmIGl0J3MgYnJva2VuIChpbiB0aGUgc2Vuc2Ugb2Ygdmhvc3QgSU9UTEIgQVBJKSB0aGF0
IHlvdSBhZ3JlZSwgSSB0aGluayAKd2Ugc2hvdWxkIGF0IGxlYXN0IGFsbG93IGdvb2QgZHJpdmVy
IGltcGxlbWVudGF0aW9uczsgYW5kIHdoZW4geW91IHRoaW5rIAphYm91dCB0aGUgcG9zc2liaWxp
dHkgb2YgdGhvc2UgdmFsaWQgZ29vZCBkcml2ZXIgY2FzZXMgCiguc2V0X21hcC8uZG1hX21hcCBp
bXBsZW1lbnRhdGlvbnMgdGhhdCBkbyBub3QgY2xlYXIgbWFwcyBpbiAucmVzZXQpLMKgIAp5b3Ug
bWlnaHQgYmUgYWJsZSB0byBzZWUgd2h5IGl0J3MgY29kZWQgdGhlIHdheSBhcyBpdCBpcyBub3cu
Cgo+ICAgSXQncyBhYm91dCB3aGV0aGVyIHdlIGNvdWxkIHN0aWNrIHRvIHRoZSBvbGQgYmVoYXZp
b3VyIHdpdGhvdXQKPiB0b28gbXVjaCBjb3N0LiBBbmQgSSBiZWxpZXZlIHdlIGNvdWxkLgo+Cj4g
QW5kIGp1c3QgdG8gY2xhcmlmeSBoZXJlLCByZXNldF92ZW5kb3JfbWFwcGluZ3MoKSA9IGNvbmZp
Zy0+cmVzZXRfbWFwKCkKPgo+PiBCdXQgdG9kYXkgdGhlcmUncyBubyBiYWNrZW5kIGZlYXR1cmUg
bmVnb3RpYXRpb24KPj4gYmV0d2VlbiB2aG9zdC12ZHBhIGFuZCB0aGUgcGFyZW50IGRyaXZlci4g
RG8gd2Ugd2FudCB0byBzZW5kIGRvd24gdGhlCj4+IGFja2VkX2JhY2tlbmRfZmVhdHVyZXMgdG8g
cGFyZW50IGRyaXZlcnM/Cj4gVGhlcmUncyBubyBuZWVkIHRvIGRvIHRoYXQgd2l0aCB0aGUgYWJv
dmUgY29kZSwgb3IgYW55dGhpbmcgSSBtaXNzZWQgaGVyZT8KPgo+IGNvbmZpZy0+cmVzZXQoKQo+
IGlmIChJT1RMQl9QRVJTSVNUIGlzIG5vdCBzZXQpIHsKPiAgICAgICAgY29uZmlnLT5yZXNldF9t
YXAoKQo+IH0KSW1wbGVtZW50YXRpb24gaXNzdWU6IHRoaXMgaW1wbGllcyByZXNldF9tYXAoKSBo
YXMgdG8gYmUgdGhlcmUgZm9yIGV2ZXJ5IAouc2V0X21hcCBpbXBsZW1lbnRhdGlvbnMsIGJ1dCB2
ZW5kb3IgZHJpdmVyIGltcGxlbWVudGF0aW9uIGZvciBjdXN0b20gCklPTU1VIGNvdWxkIHdlbGwg
aW1wbGVtZW50IERNQSBvcHMgYnkgaXRzZWxmIGluc3RlYWQgb2YgLnJlc2V0X21hcC4gVGhpcyAK
d29uJ3Qgd29yayBmb3IgZXZlcnkgc2V0X21hcCBkcml2ZXIgKHRoaW5rIGFib3V0IHRoZSB2ZHVz
ZSBjYXNlKS4KCkJ1dCB0aGlzIGlzIG5vdCB0aGUgdGhlIHBvaW50IEkgd2FzIG1ha2luZy4gSSB0
aGluayBpZiB5b3UgYWdyZWUgdGhpcyBpcyAKcHVyZWx5IGJ1Z2d5IGRyaXZlciBpbXBsZW1lbnRh
dGlvbiBvZiBpdHMgb3duLCB3ZSBzaG91bGQgdHJ5IHRvIGlzb2xhdGUgCnRoaXMgYnVnZ3kgYmVo
YXZpb3IgdG8gaW5kaXZpZHVhbCBkcml2ZXIgcmF0aGVyIHRoYW4gb3ZlcmxvYWQgdmhvc3QtdmRw
YSAKb3IgdmRwYSBjb3JlJ3Mgcm9sZSB0byBoZWxwIGltcGxlbWVudCB0aGUgZW11bGF0aW9uIG9m
IGJyb2tlbiBkcml2ZXIgCmJlaGF2aW9yLiBJIGRvbid0IGdldCB3aHkgLnJlc2V0IGlzIHNwZWNp
YWwgaGVyZSwgdGhlIGFidXNlIG9mIC5yZXNldCB0byAKbWFuaXB1bGF0ZSBtYXBwaW5nIGNvdWxk
IGFsc28gaGFwcGVuIGluIG90aGVyIElPTU1VIHVucmVsYXRlZCBkcml2ZXIgCmVudHJpZXMgbGlr
ZSBpbiAuc3VzcGVuZCwgb3IgaW4gcXVldWVfcmVzZXQuIElmIHNvbWVkYXkgdXNlcnNwYWNlIGlz
IApmb3VuZCBjb2RlZCBhcm91bmQgc2ltaWxhciBidWdneSBkcml2ZXIgaW1wbGVtZW50YXRpb24g
aW4gb3RoZXIgZHJpdmVyIApvcHMsIGRvIHdlIHdhbnQgdG8gZm9sbG93IGFuZCBkdXBsaWNhdGUg
dGhlIHNhbWUgZW11bGF0aW9uIGluIHZkcGEgY29yZSAKYXMgdGhlIHByZWNlZGVudCBpcyBhbHJl
YWR5IHNldCBoZXJlIGFyb3VuZCAucmVzZXQ/ClRoZSBidWdneSBkcml2ZXIgY2FuIGZhaWwgaW4g
YSBsb3Qgb2Ygb3RoZXIgd2F5cyBpbmRlZmluaXRlbHkgZHVyaW5nIApyZXNldCwgaWYgdGhlcmUn
cyBhIGJ1Z2d5IGRyaXZlciB0aGF0J3MgYWxyZWFkeSBicm9rZW4gdGhlIHdheSBhcyBob3cgaXQg
CmlzIGFuZCBoYXBwZW5zIHRvIHN1cnZpdmUgd2l0aCBhbGwgdXNlcnNwYWNlIGFwcHMsIHdlIGp1
c3QgZG9uJ3QgY2FyZSAKYW5kIGxldCBpdCBiZS4gVGhlcmUncyBubyB3YXkgd2UgY2FuIGVudW1l
cmF0ZSBhbGwgdGhvc2UgYnVnZ3kgYmVoYXZpb3JzIAppbiAucmVzZXRfbWFwIGl0c2VsZiwgaXQn
cyBvdmVybG9hZGluZyB0aGF0IGRyaXZlciBBUEkgdG9vIG11Y2guCj4+IFNlY29uZCwgSU9UTEJf
UEVSU0lTVCBpcyBuZWVkZWQgYnV0IG5vdCBzdWZmaWNpZW50LiBEdWUgdG8gbGFjayBvZgo+PiBi
YWNrZW5kIGZlYXR1cmUgbmVnb3RpYXRpb24gaW4gcGFyZW50IGRyaXZlciwgaWYgdmhvc3QtdmRw
YSBoYXMgdG8KPj4gcHJvdmlkZSB0aGUgb2xkLWJlaGF2aW91ciBlbXVsYXRpb24gZm9yIGNvbXBh
dGliaWxpdHkgb24gZHJpdmVyJ3MKPj4gYmVoYWxmLCBpdCBuZWVkcyB0byBiZSBkb25lIHBlci1k
cml2ZXIgYmFzaXMuIFRoZXJlIGNvdWxkIGJlIGdvb2QKPj4gb24tY2hpcCBvciB2ZW5kb3IgSU9N
TVUgaW1wbGVtZW50YXRpb24gd2hpY2ggZG9lc24ndCBjbGVhciB0aGUgSU9UTEIgaW4KPj4gLnJl
c2V0LCBhbmQgdmVuZG9yIHNwZWNpZmljIElPTU1VIGRvZXNuJ3QgaGF2ZSB0byBwcm92aWRlIC5y
ZXNldF9tYXAsCj4gVGhlbiB3ZSBqdXN0IGRvbid0IG9mZmVyIElPVExCX1BSRVNJU1QsIGlzbid0
IHRoaXMgYnkgZGVzaWduPwpUaGluayBhYm91dCB0aGUgdmR1c2UgY2FzZSwgaXQgY2FuIHdvcmsg
d2l0aCBETUEgb3BzIGRpcmVjdGx5IHNvIGRvZXNuJ3QgCmhhdmUgdG8gaW1wbGVtZW50IC5yZXNl
dF9tYXAsIHVubGVzcyBmb3Igc29tZSBzcGVjaWZpYyBnb29kIHJlYXNvbi4gCkJlY2F1c2UgaXQn
cyBhIGNvbmZvcm1pbmcgYW5kIHZhbGlkL2dvb2QgZHJpdmVyIGltcGxlbWVudGF0aW9uLCB3ZSBt
YXkgCnN0aWxsIGFsbG93IGl0IHRvIGFkdmVydGlzZSBJT1RMQl9QRVJTSVNUIHRvIHVzZXJzcGFj
ZS4gV2hpY2ggYmVsb25ncyB0byAKdGhlIDNyZCBidWxsZXQgYmVsb3c6CgpodHRwczovL2xvcmUu
a2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8xNjk2OTI4NTgwLTc1MjAtNC1naXQtc2VuZC1lbWFp
bC1zaS13ZWkubGl1QG9yYWNsZS5jb20vCgpUaGVyZSBhcmUgMyBjYXNlcyB0aGF0IGJhY2tlbmQg
bWF5IGNsYWltIHRoaXMgZmVhdHVyZSBiaXQgb246CgotIHBhcmVudCBkZXZpY2UgdGhhdCBoYXMg
dG8gd29yayB3aXRoIHBsYXRmb3JtIElPTU1VCi0gcGFyZW50IGRldmljZSB3aXRoIG9uLWNoaXAg
SU9NTVUgdGhhdCBoYXMgdGhlIGV4cGVjdGVkCiDCoCAucmVzZXRfbWFwIHN1cHBvcnQgaW4gZHJp
dmVyCi0gcGFyZW50IGRldmljZSB3aXRoIHZlbmRvciBzcGVjaWZpYyBJT01NVSBpbXBsZW1lbnRh
dGlvbgogwqAgdGhhdCBleHBsaWNpdGx5IGRlY2xhcmVzIHRoZSBzcGVjaWZpYyBiYWNrZW5kIGZl
YXR1cmUKCj4KPj4gd2UKPj4gc2hvdWxkIGFsbG93IHRoZXNlIGdvb2QgZHJpdmVyIGltcGxlbWVu
dGF0aW9ucyByYXRoZXIgdGhhbgo+PiB1bmNvbmRpdGlvbmFsbHkgc3RpY2sgdG8gc29tZSBzcGVj
aWZpYyBwcm9ibGVtYXRpYyBiZWhhdmlvciBmb3IgZXZlcnkKPj4gb3RoZXIgZ29vZCBkcml2ZXIu
Cj4gVGhlbiB5b3UgY2FuIGZvcmNlIHJlc2V0X21hcCgpIHdpdGggc2V0X21hcCgpIHRoYXQgaXMg
d2hhdCBJIHN1Z2dlc3QKPiBpbiBhbm90aGVyIHRocmVhZCwgbm8/ClRoaXMgaXMgZXhhY3RseSB3
aGF0IEkgd2FzIGFmcmFpZCBvZiB0aGF0IGJyb2tlbiBiZWhhdmlvciBlbXVsYXRpb24gbWF5IApi
ZWNvbWUgYSBkYW5nZXJvdXMgc2xpcHBlcnkgc2xvcGUgLSBpbiBwcmluY2lwbGUgd2Ugc2hvdWxk
IGVuY291cmFnZSAKZ29vZCBkcml2ZXIgaW1wbGVtZW50YXRpb24sIGFzIHRoZXkgY2FuIHdvcmsg
dG90YWxseSBmaW5lIHdpdGggb2xkZXIgCnVzZXJzcGFjZS4gV2h5IGRvIHRoZXkgaGF2ZSB0byBi
b3RoZXIgZW11bGF0aW5nIGJyb2tlbiBiZWhhdmlvciBqdXN0IApiZWNhdXNlIHNvbWUgb3RoZXIg
ZHJpdmVyJ3MgbWlzYmVoYXZpbmc/IEFuZCB3aGF0J3MgdGhlIGJvdW5kYXJ5IGZvciAKdGhpcyBo
YWNrLCBkbyBkcml2ZXJzIGJhY2tlZCBieSBwbGF0Zm9ybSBJT01NVSBldmVuIGhhdmUgdG8gZW11
bGF0ZSAoaWYgCm5vdCB3aHkgbm90LCBhbmQgaXMgdGhlcmUgc3Vic3RhbnRpYWwgZGlmZmVyZW5j
ZSBpbiBiZXR3ZWVuKT8gQWZ0ZXIgCmdldHRpbmcgdGhyb3VnaCBhbGwgb2YgdGhpcywgZG8geW91
IHN0aWxsIGJlbGlldmUgZXZlcnl0aGluZyBpcyBqdXN0IGFzIAplYXN5IGFuZCBzaW1wbGUgYXMg
d2hhdCB0aG91Z2h0IHRvIGJlPwoKQnR3LCBJIHRob3VnaHQgSSB3YXMgZXhwZWN0aW5nIGJ1dCBz
dGlsbCBoYXZlbid0IGdvdCB0aGUgY2xlYXIgYW5zd2VycyAKdG8gd2hhdCB3YXMgdGhlIGdvYWwg
dG8gZG8gYWxsIHRoaXMsIHdlIHNwZW50IGEgbG90IG9mIHRpbWUgdHJ5aW5nIHRvIAp1bmJyZWFr
IHVzZXJzcGFjZSwgYnV0IGxvb2tzIHRvIG1lIGFzIGlmIHdlIHdlcmUgdHJ5aW5nIGV2ZXJ5IHBv
c3NpYmxlIAp3YXkgdG8gYnJlYWsgdXNlcnNwYWNlIG9yIHRyeSB0byBhcHByb3hpbWF0ZSB0byB0
aGUgc2FtZSBicm9rZW5uZXNzIAptbHg1X3ZkcGEgbWF5IGhhdmUgY2F1c2VkIHRvIHRoZSB1c2Vy
c3BhY2UuIFdoYXQgd2Ugd2lsbCBnZXQgZXZlbnR1YWxseSAKZnJvbSB0aGVzZSBsZW5ndGh5IGRp
c2N1c3Npb25zPyBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgeW91IHRoaW5rIGl0IGZyb20gCnZob3N0
LXZkcGEgdXNlciBwZXJzcGVjdGl2ZSwgeW91J2xsIGNsZWFybHkgc2VlIHRoZXJlJ3MganVzdCBh
IGNvdXBsZSBvZiAKd2F5cyB0byB1bmJyZWFrIHVzZXJzcGFjZSBmcm9tIHRoZSBpbnRlcm5hbCBi
cm9rZW4gbWFwIHdoaWNoIGlzIG91dCBvZiAKc3luYyB3aXRoIHZob3N0LXZkcGEgaW90bGIgYWZ0
ZXIgZGV2aWNlIHJlc2V0LiBJZiB0aGlzIGJyb2tlbm5lc3Mgd2FzIApzb21ldGhpbmcgdW5pdmVy
c2FsbHkgZG9uZSBmcm9tIHRoZSB2aG9zdC12ZHBhIGxheWVyIGl0c2VsZiwgSSdkIGZlZWwgCml0
J3MgbW9yZSBvZiBhIHNoYXJlZCBwcm9ibGVtLCBidXQgdGhpcyBpcyBub3QgdGhlIGNhc2UgSSBz
ZWUgaXQgaGVyZS4gCldoaWxlIHRoZSBsb25nIHN0YW5kaW5nIG1seDVfdmRwYS92ZHBhX3NpbSBp
c3N1ZSBpcyAxMDAlIG1pc3VzZSBvZiAKLnJlc2V0IG9wIGluIGEgd3Jvbmcgd2F5IHBlciBJT01N
VSBBUEkgZGVmaW5pdGlvbi4gV2h5IGxlYXZpbmcgdGhpcyAKZGlzY3JlcGFuY3kgdG8gdGhlIGlu
ZGl2aWR1YWwgZHJpdmVyIGlzIG5vdCBldmVuIGFuIG9wdGlvbiwgSSdtIHN0aWxsIApub3Qgc3Vy
ZT8KCgpUaGFua3MsCi1TaXdlaQoKPgo+PiBUaGVuIHdlIG5lZWQgYSBzZXQgb2YgZGV2aWNlIGZs
YWdzIChiYWNrZW5kX2ZlYXR1cmVzCj4+IGJpdCBhZ2Fpbj8pIHRvIGluZGljYXRlIHRoZSBzcGVj
aWZpYyBkcml2ZXIgbmVlZHMgdXBwZXIgbGF5ZXIncyBoZWxwIG9uCj4+IG9sZC1iZWhhdmlvdXIg
ZW11bGF0aW9uLgo+Pgo+PiBMYXN0IGJ1dCBub3QgbGVhc3QsIEknbSBub3Qgc3VyZSBob3cgdG8g
cHJvcGVybHkgZW11bGF0ZQo+PiByZXNldF92ZW5kb3JfbWFwcGluZ3MoKSBmcm9tIHZob3N0LXZk
cGEgbGF5ZXIuIElmIGEgdmVuZG9yIGRyaXZlciBoYXMgbm8KPj4gLnJlc2V0X21hcCBvcCBpbXBs
ZW1lbnRlZCwgb3IgaWYgLnJlc2V0X21hcCBoYXMgYSBzbGlnaHRseSBkaWZmZXJlbnQKPj4gaW1w
bGVtZW50YXRpb24gdGhhbiB3aGF0IGl0IHVzZWQgdG8gcmVzZXQgdGhlIGlvdGxiIGluIHRoZSAu
cmVzZXQgb3AsCj4gU2VlIGFib3ZlLCBmb3IgcmVzZXRfdmVuZG9yX21hcHBpbmdzKCkgSSBtZWFu
dCBjb25maWctPnJlc2V0X21hcCgpIGV4YWN0bHkuCj4KPiBUaGFua3MKPgo+PiB0aGVuIHRoaXMg
ZWl0aGVyIGJlY29tZXMgZWZmZWN0aXZlbHkgZGVhZCBjb2RlIGlmIG5vIG9uZSBlbmRzIHVwIHVz
aW5nLAo+PiBvciB0aGUgdmhvc3QtdmRwYSBlbXVsYXRpb24gaXMgaGVscGxlc3MgYW5kIGxpbWl0
ZWQgaW4gc2NvcGUsIHVuYWJsZSB0bwo+PiBjb3ZlciBhbGwgdGhlIGNhc2VzLgo+Pgo+PiAtLS0t
LS0tLS0tLS0tLS0tJTwtLS0tLS0tLS0tLS0tLS0tJTwtLS0tLS0tLS0tLS0tLS0tCj4+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
