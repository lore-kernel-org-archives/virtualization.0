Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2991EC61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 06:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8957F60BD9;
	Wed, 15 Mar 2023 06:56:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8957F60BD9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cCy9acO3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qy7QOp62
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFqjYjhTCcW3; Wed, 15 Mar 2023 06:56:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D299360BC3;
	Wed, 15 Mar 2023 06:56:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D299360BC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FEB7C0035;
	Wed, 15 Mar 2023 06:56:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1895CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 06:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA7D6404DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 06:56:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA7D6404DA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=cCy9acO3; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=qy7QOp62
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sMgAi7dJjPKh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 06:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBF8140139
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBF8140139
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 06:56:25 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32F6mqcU016584; Wed, 15 Mar 2023 06:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bIK4FYaLzZ4I2o9qktyaPTrwaZX2m7/GlXRnTYqw2fY=;
 b=cCy9acO34R9X19KV/tUZ9OOCmoEmzTaJQSwuDvdgNEINPo33XgyhwyIdeD/oicn46/x4
 qUbtlDChd0lygg5o1kvmaITfo9i6MdkGC2KDguQJ0FXLo6z80vQnLUZabJ3/BNtKii5l
 eb14zUGxNuEDOavsd7Gr5tSbTJuW5q/0mPATT7mIpMhV6rWns8EhT6faTazbSy9WA22Y
 l82hRqIwN5k83f3lSkAF5uRxuSSMQDKOs4sSAwiZxB/BKC3bgBktIK/dVNTGJSg5h/+K
 kiVNr2Zo6YF4NFVJ2azdsOD485LJm1umYm+KDdTEGkKeYUgFQCWoGSJzFB71HcXt3yfP /g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pb2c1rk08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Mar 2023 06:56:24 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32F4XPHs012053; Wed, 15 Mar 2023 06:56:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3pb32svjej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Mar 2023 06:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CErBY9XtD4u+5fuU1tMEXMTO1dWznfBivA+gyIpT1pB+tYQGgjULxpVlyMo4Crd9+HvJMkBOjZJmSssGz8cruq/BoFK8Ju6yWGXP09SMoMVQg/88YkPjHZG7Am8pDgCStTn29BANiuQthNXfcAAA7/BX5dIFqHbNQgWOlpehQ3ESU8rV33OlStp/UYRvLqBJdVQu2n6RAldtwm4ZrxIENSyRbTvsIyBMx+40TkZzDeTFb94/Pw8KYk/qm0IFC/0y+ZB/lRMi/0WGjcnjxYIOoKhRt86JFmjf1w6f0wfyD55MPvfE/YfxMRPOpi8UsuR81Hqi1LWQgvsda/56XWFxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIK4FYaLzZ4I2o9qktyaPTrwaZX2m7/GlXRnTYqw2fY=;
 b=YG75E6JYax5OwFdpFO3zW7p4TZwnjNarGHU1EvHm/N3iq0LnSSK5JhhT10sB6yA6f4Cnh3ASizhKLmTyTOfx1l+/35wu8tsXIn+cpnJxZIMUgIeLKniOsF2Iyca7573C0Z7NePd+UsNRxZqoE6ORsk4eUEuYvHUfGMLRSWUmPdzbVlT174lN5jiznW746rliQf5F8ATNMBwLtCFjO8nUt6Apw2GVkE4g7rRTijtTadPxaqCnY839H4OTwc6jCLsDo/Q1VNGDcqig0uhi5m4GqQlBtI8y/ze/PJ8ffw2aMy/8MRRmECXY7+KWC4n9lVa8QedDviFVnqBERwCHdWS+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIK4FYaLzZ4I2o9qktyaPTrwaZX2m7/GlXRnTYqw2fY=;
 b=qy7QOp62tU6jMkY1b9vGML1wkyNWQy6rtyW3yf3rLF7QJyY5JVbUvOEGiSujLXJOMpihf0SuJV/p35vfd3jjRLytdYTGc7jJo12LybAOSt/qWPXhQkJfMw28oqpWAem1s+HJeqpVHQLzHAlqHoYyo11VXa5v8cNHpno52cmxImQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB6945.namprd10.prod.outlook.com (2603:10b6:8:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 06:56:22 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%7]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 06:56:22 +0000
Message-ID: <f969e826-72d2-8284-802c-82c857ba68ef@oracle.com>
Date: Tue, 14 Mar 2023 23:56:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Content-Language: en-US
To: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f269688b-8392-406c-e070-369b25acc252@oracle.com>
 <PH0PR12MB5481A0629C479A030C8A8EDEDCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313233638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DE6E7A0594D38019305DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8952f08f-cc61-cf5f-7ffe-3f2a80891d28@oracle.com>
 <PH0PR12MB5481F776D35247E6BF3F115EDCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB5481F776D35247E6BF3F115EDCBF9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 880be3ae-a18f-4a63-8b9d-08db252262b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPtPTKI6MVda7QUiDuM8fib6mnRl0gaZm84xb+pB6SwCsrCrbvq0fhTkUgKQyIpiVuh5P6TgY6ohIVor5FDT8/yMXEky3+aDlKAHogjNT0ynbhd0IPTY1fT1PRFciDFUcWiLCaPgO405YSuB1sxP7Tr57U1tnbmSLZPUicWHeLMp+ygzHHKiU5tyuoCleABOym9KYET3PYQ229GEHzNZf6y2ep6dG5Ew0c5IHlBkI/I2V7wi/w4G0k7cLZIRFBVGKLKYOOzK63kyoHf+X5k6ly5/Sul+HYPQR4ZJrFa/8ad15Y72SwlWlu+cywai5D09McZj5N9dDojLuEv8hp1NqWfdSU+8Nw2tlrx9W662qp8QwuxhOKUV0p/ksl72F/wPooZwtaSIkJ1IVVmy/YQUebp686TnvLZTFy0Tysdzd+SENxWh/PcNcrtakd2lhPWN2av91xeqoZ3yvwpI96qRA9YOCgFS7XfXQzBKrDVkpuu5nsa5O8RfFaZaM37slEI/TcMqvTvnTceTDJ/2mDjAEY+1nKLFVGB+BDxgNoK9ACYgvc1tn8uChi5TPQ/x4W8SZ8EIPZfu4lp0L1q8DsKXkN+JwpgzRwMy+5tcGL3iMSmF1GP7YYiBxLbnsQK9gVelq+tAJNRhaIVUErVrp7nJh63cINvvb7eEWJq2gaNr7XO96PhtAeJZj1C6GwN1AfV3jhkx2GfpOtW59nAQhUKbFk16ScMKbDoPgPq+wuFRrQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199018)(86362001)(31696002)(38100700002)(41300700001)(8936002)(36916002)(2906002)(36756003)(5660300002)(4326008)(83380400001)(6512007)(316002)(186003)(26005)(6506007)(2616005)(53546011)(54906003)(66946007)(66556008)(6486002)(66476007)(6666004)(478600001)(110136005)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2lMRmtkUFcxaTFQa2FxTEIzdlMvU2xSa216WkRuNjVZV0dHMDlEWjl1WUQv?=
 =?utf-8?B?ejhvbUo4SDJ2cUIwaFZWY1VYZWZBWUo1UEFrT2NUbnc5Uzc5QlJqbkljaFpu?=
 =?utf-8?B?bU5DcmIxY1MxNmZCZU5WckRsUFBxRTNGVkc5bkpxb2JQZXQyUlpmK1M5YzJt?=
 =?utf-8?B?Uk85bS9DOXZOWW9xQ2MvQndQL3RXVEpGYlA4SS9mL1dUSmY3V0JyLzJGekdB?=
 =?utf-8?B?TXBiZVVOUC9pZ0VHeTVKUnVCVkRIR0FFcEplTWVBeFU5M0Rqd3BMeWhuTWtr?=
 =?utf-8?B?bnhzOUhhcHhVWm1EeFgvU3pkSUcyUjVJUkdWa1dNbXAzeFAxYmN1S0tZSGE5?=
 =?utf-8?B?SSs2eHk2dTJ2TmRzVzBybjZ3VGxBZFNZMVdHcWhTbEx3Q1BPSEVrRUQ3U3ls?=
 =?utf-8?B?M3BUbnM3eVBRWkwzN2RsdjBuemxBYU1hRWxMc3lqOXNpekpPZ3poUTRsZWZm?=
 =?utf-8?B?b0p0SFJWUWJJdXpVUUtmRVNJMmxGdlVjeTNmQnhtRVdDTXlrRDZ0Y0xMeEEr?=
 =?utf-8?B?bE1xSnEyRVVUV1BsK2VTcjhSd3p2SzlYVlc3dEdnUWpMZVdaYlYwamNxTEp1?=
 =?utf-8?B?M3l1RnZnTmplUEJrelB3M0JCRE1objQxUnZuc3VMT1Y0Wk5PSGQxZE9MNEZY?=
 =?utf-8?B?d09jcmhhN1ZjYloyY0VKZk5ZVm5KVDZ6S0NYSVA3SnRkUGdOSWUzdlJHaGJm?=
 =?utf-8?B?aGFYWE4wSlQ4WjBnZ0hFWUhIME9MQnphYlJ2ZzdZTGY2MjJEU2hIaDhqTVNs?=
 =?utf-8?B?OEdJMDEvQjZUL1BhL1RGOEYrYm9EdnEvd1NNdFQ5MlJoaC8yZCtFRGhRS3cy?=
 =?utf-8?B?VTFLWExBOExWVGN4c00xMHV3aVAvMUdOb3BHKzhYa1Mwb3preTJFSlUvajB3?=
 =?utf-8?B?cWFNTDloVkZKelNscVc1a2dBWSs5NVE0b0ZvY2RWRGZXbDhhM0kyVjU0THdI?=
 =?utf-8?B?YnNZanVhQ2xyTnJ4cFFCdTdHck0zZFlUdXFySEZEV1IycmVUdGl4LzNKZVdL?=
 =?utf-8?B?ZGtTTEhNNWlWVEVGbzBtUE1rRks4QWZiWkEvM0RqUkZET2c5WlRwVnJoZ0NK?=
 =?utf-8?B?aVVnaHBDZUhydWVVRFhkQlRQcDUwLzZOZ0RObGlYYzR4UDRDK3RWbFQ2aDBB?=
 =?utf-8?B?VHZTK0tXekh2d2FjK3JYOVYraUxKVUFFVHVRRG1MZG01ZCtOa0syVVp5WC83?=
 =?utf-8?B?WlUrQXAwR01MYURJWUhLQW5QeFVFaWZOR05CSysvM1VzSmVJS1JCYWFzSWJm?=
 =?utf-8?B?WWNQUENkWkZ4RndlTUFNM2VPbmlNekdEMGhwaWowdGo4NXUvRGxSVFlnbHZk?=
 =?utf-8?B?WGxNdkxISXk5bEo3NXJiUzR1TVJUd1NTNGs1ck83R1BpSXpXZnVWeXFvcE1l?=
 =?utf-8?B?ZDhubWUrdGE0UWo2amxYMWFBNTZOYk5CQ2pnNkxPcEEvaGVyM0dXeUZkZFBN?=
 =?utf-8?B?VjhZSkZJWUh3YkJLK3J5UVMvK200OWxDT2NNa2JhL1p4VDdjRjIvQ1VBU2pH?=
 =?utf-8?B?YlNRb1gxU2VuemZJd1ZNejlFdE8rMlFhWVZXMHB6U3UxL0d4eXMwc3FwQ0JZ?=
 =?utf-8?B?NFBJanByeEtMYVFnenNXd2JwS1MwZ0J3MVF2VC9wQmdiNDNTVjFFWjZmR0Yz?=
 =?utf-8?B?NkVjNTN5dFRwNDQyaGhvSURYT3VDbjdCZDA1aFMvTmZIOGltNExUb0gxV2FX?=
 =?utf-8?B?eXZBaTdKVjArWm1JR1ZiaTF6NVJOdFJqblVMNjhndi8zRFc2V3R2Vzh1TTVE?=
 =?utf-8?B?cFpYUzM4UHhMRzYrWkFza3RLeW9RVWV1NXI1d3M0TzhsWlpUczVJV0wwcEFG?=
 =?utf-8?B?R3lTN0phdnlOVnVldng5d0o4L3JiSjJBd3RDTHFHWmZwVXpOenZ0YlhRZnd5?=
 =?utf-8?B?Q0l2Nmdoc3hwY0hyck5rSE9KSFpNMmhJeDBPZEN1M1RWdG02M1ZxaUlCQkht?=
 =?utf-8?B?K3F6RFNndWNTNnpMZ2xJVTdGL0crRGxjeWdmVXVic2U3eXBKeTV5YXowSHRn?=
 =?utf-8?B?TXFzckwvMGw1YWttTGZ5RUIrVmxsMEJMZlJocnVHeXk5K3IxTnN5T05lbjRW?=
 =?utf-8?B?ZTVVdXZvU2RNbmpmejhuWWRlenBJR1E4S1Q5R0tkaEd5eTZDSVJzanNOdGxo?=
 =?utf-8?Q?swvj09ZoYUoIM52ooPAgpHAg2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y1Vonee0GB13udIn0v6nH1jzFFUuk8swzGXaRLyVVj+ZyG7HnZMHZC/I9WoXFc20/lmT1u/CpiszpiepQdE+LdrrrggNnaey8wQQVxbcIhC9NWVmthFifd7ax/u82gBygCw8zz+cTRgZOazurnzGCt03t9ye8uVp0IMupntmfOdPmtfcOED43rreW61Xxmj/XqJ703k/enAZ7fZkKyYZHryR73V99cfXCUwTIzLqe7MA90/voUlRqAXYVg0Ydgag1wW/rhAJ12Ra1OMuRiphvk1F8TOEKQ6CO/4Mc2nKfG4o7mOFz+DsXIoe5K55SbUZrw9K7wCClhg6K2XMLcoWzH3rIxQt52z8VpvfBNN2/3ZI2P5YkBYIMBpZDlO6X1b+t2Mxi2NGekSkualjjBQz8vHHE3SxUfHjRkNim9ue3jvoTLn+pj7OIEJW6AcDLhmyE8hJdig/O6+Sg5RFjY9BcjELZ+jx6q6m/f0OtRfZ8wu1xY40M53H+PjW8cyPIQVSCWHO9DJNGaj+E3dESclCTm1LAGbU8ZOkMq3ake53xL4WHhkvZas9pyI2YgNY/J9k0UNRi2CORYKu08PZnAZi6gxFDin9o2El/512XPr7XA1WgV79tjFXcywoxa7MBOf9DprVmHxHruNezNRgiG/xx0uBhfeqFiBd94+/+pzukzLEbZMWyjjUovA09CUovHqV3DmhBVNAb3y3uEWTVSULURS2jw0/RCgS31s47Ul5kTaCdyRq8tlmPeE4WgvN0GJoskxBreKYXkxR8UWjptAgL5iuwUEu0LPZNdPeBfhs0oZ0X2oAjJWK54OozYpg6oB/XOY17C3sTo+gWe9EH9cBEzkJxNquu9IwCCeZ4tYAAzoO51uGUOnMcAxLhqPtWz3v
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880be3ae-a18f-4a63-8b9d-08db252262b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 06:56:21.9996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYfLRo7zx6lxxAmFktHN/XbBo14wSuwfJ4z1peGHJmT6yQV9WYm4t0O1oEv3UAFtgUlfxiNbXG0b8LIy5FOfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_02,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=724
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2302240000
 definitions=main-2303150059
X-Proofpoint-GUID: BQ1Bpu9S_ea2mZHOi9rC4sGAvz4jf_1y
X-Proofpoint-ORIG-GUID: BQ1Bpu9S_ea2mZHOi9rC4sGAvz4jf_1y
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "perezma@redhat.com" <perezma@redhat.com>
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

CgpPbiAzLzE0LzIwMjMgNzowOSBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+PiBGcm9tOiBTaS1X
ZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE0
LCAyMDIzIDM6MjkgUE0KPj4+IElmIHVzZXIgc3VwcGxpZWQgZmVhdHVyZSBiaXRzIGFuZCBkZXZp
Y2UgZG9lc27igJl0IHN1cHBvcnQgc29tZSBvZiB0aGUgZmVhdHVyZQo+PiBiaXRzIC0+IGFkZCBj
b21tYW5kIGZhaWxzLgo+Pj4gSWYgdXNlciBzdXBwbGllZCBmZWF0dXJlIGJpdHMsIHRoYW4gdXNl
IG9ubHkgdGhlIGZlYXR1cmUgYml0cy4gRG8gbm90IE9SIHVzZXIKPj4gc3VwcGxpZWQgZmVhdHVy
ZSBiaXRzIHdpdGggZGV2aWNlIHN1cHBvcnRlZCBmZWF0dXJlIGJpdHMuCj4+IEkgdGhpbmsgdGhh
dCBpcyB0aGUgbm90IHRoZSBjdXJyZW50IGJlaGF2aW9yIGZvciBtbHg1X3ZkcGE/IEFzIGZhciBh
cyBJIGNhbiBzZWUgaXQKPj4gd291bGQgQU5EIHVzZXIgc3VwcGxpZWQgZGV2aWNlX2ZlYXR1cmVz
IGJpdHMgd2l0aCB0aGUgZGV2aWNlIHN1cHBvcnRlZAo+PiBmZWF0dXJlIGJpdHMgKGZpbmQgdGhl
IGNvbW1vbiBwYXJ0IG9mIGJvdGggZmVhdHVyZSBiaXRzKSB0aGVuIHByb2NlZWQuCj4gUmlnaHQu
Cj4gSXQgaXMgbm90IGEgcHJvYmxlbS4gSXQgaXMgQU5EIG9wZXJhdGlvbi4gTXkgYmFkLgpUaGFu
a3MgZm9yIGNvbmZpcm1pbmcgaXQuCj4KPiBXaGVuIHRoZSB1c2VyIGRpZG7igJl0IHN1cHBseSB0
aGUgZmVhdHVyZSBiaXRzLCB0aGlzIHBhdGNoIGF2b2lkcyBNUkdfUlhCVUYgYmVpbmcgb24gYXMg
ZGVmYXVsdC4KVGhpcyBzaG91bGQgYmUgZmluZSwgdGhlIGRyaXZlciBzaG91bGQgaGF2ZSB0aGUg
ZnJlZWRvbSB0byBkZWZpbmUgaXRzIApvd24gc2V0IG9mIGRlZmF1bHQgZmVhdHVyZXMgd2hlbiB1
c2VyIGRpZG4ndCBleHBsaWNpdGx5IHByb3Zpc2lvbiB0aGVtIAp0aHJvdWdoIHRoZSBkZXZpY2Vf
ZmVhdHVyZXMgYXR0cmlidXRlLiBCdXQgYmV0dGVyIHRvIGV4cG9zZSBhIHJlYWQtb25seSAKZmls
ZWQsIGUuZy4gImRlZmF1bHRfZmVhdHVyZXMiIHRvIHRoZSAidmRwYSBtZ210ZGV2IHNob3ciIGNv
bW1hbmQgCm91dHB1dCwgb3RoZXJ3aXNlIHVzZXJzIGhhdmUgbm8gd2F5IHRvIGluZmVyIHdoeSBN
UkdfUlhCVUYgZGlzYXBwZWFycyAKbXlzdGVyaW91c2x5IGJ5IGp1c3QgdGVsbGluZyBpdCBmcm9t
IHRoZSBjdXJyZW50ICJkZXZfZmVhdHVyZXMiIGZpZWxkLiAKQnkgZGVmaW5pdGlvbiwgcGFyZW50
IG1nbXRkZXYgY2FuIGhhdmUgZGlmZmVyZW50IGRlZmF1bHQgdmFsdWUgYmV0d2VlbiAKZGlmZmVy
ZW50IGRldmljZXMuCj4gVGhpcyBpcyBiZWNhdXNlIGNlcnRhaW4gZGV2aWNlcyBzdXBwb3J0IGl0
IGFuZCBjZXJ0YWluIGRldmljZSBkb27igJl0Lgo+IFNvIHRoaXMgcGF0Y2gga2VlcHMgaXQgYmFj
a3dhcmQgY29tcGF0aWJsZSB0byBiZSBhbHdheXMgb2ZmIGJ5IGRlZmF1bHQsIHdoaWNoIHRoZSBk
ZXZpY2UgY291bGRu4oCZdCBkby4KQXMgcHJldmlvdXNseSBkaXNjdXNzZWQgd2l0aCBKYXNvbiBh
bmQgSSBteXNlbGYgYWxzbyBhZ3JlZWQsIGl0J3MgbmV2ZXIgCmEgcmVxdWlyZW1lbnQgZm9yIGRy
aXZlciB0byBrZWVwIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgZm9yIHRoZSBkZWZhdWx0IApmZWF0
dXJlIGJpdHMgd2hlbiBkZXZpY2VfZmVhdHVyZXMgaXMgbm90IHN1cHBsaWVkLiBUaGUgb25seSB3
YXkgZm9yd2FyZCAKdG8ga2VlcCBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGlzIHRvIHBlcmZvcm0g
ZXhwbGljaXQgcHJvdmlzaW9uaW5nIAp0aHJvdWdoIGRldmljZV9mZWF0dXJlcy4gQnV0IEkgdGhp
bmsgeW91ciBwb2ludCBpcyB0byBrZWVwIHRoZSAKcGVyZm9ybWFuY2UgcHJvbWlzZSBmb3IgcGFj
a2V0IHJhdGUgZm9yIHRoZSBkZWZhdWx0IGRldmljZSBjcmVhdGlvbiwgCnRoYXQgaXMgYW5vdGhl
ciBzdG9yeSBhbmQgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBiYWNrd2FyZCBjb21wYXRpYmls
aXR5LgoKClRoYW5rcywKLVNpd2VpCj4KPj4gTm90ZWQsIHdlIGRvbid0IGhhdmUgdGhpcyBkZXZp
Y2UgZGVmYXVsdHMgZXhwb3NlZCB0byB1c2VycyB5ZXQgb3RoZXIgdGhhbgo+PiB3aGF0J3Mgc2hv
d24gaW4gdGhlIHBhcmVudCBtZ210ZGV2IChkZXZfZmVhdHVyZXMpLiBBbmQgdGhlIGN1cnJlbnQg
YW5kIHRoZQo+PiBvbmx5IHNhZmUgYmVoYXZpb3IgZm9yIG1seDVfdmRwYSBpcyB0byBpbmhlcml0
IGFsbCBkZXZpY2Ugc3VwcG9ydGVkIGZlYXR1cmVzCj4+IGZyb20gcGFyZW50IG1nbXRkZXYsIG90
aGVyd2lzZSB1c2VyIGNhbid0IGtub3cgaW4gYWR2YW5jZSB3aGF0IGRlZmF1bHQKPj4gZmVhdHVy
ZXMgdGhlIGRldmljZSBtaWdodCBjb21lIHVwIHdpdGggaW1wbGljaXRseSB1bmRlcm5lYXRoLgo+
IFJpZ2h0LiBUaGlzIGlzIGZpbmUuCj4gRm9yIG1seDVfdmRwYSBNUkdfUlhCVUYgYXMgZGVmYXVs
dCBvZmYgaXMgb3B0aW1hbCBhcyBiZWZvcmUgdGhhdCBtYWludGFpbnMgdGhlIGJhY2t3YXJkIGNv
bXBhdGliaWxpdHkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
