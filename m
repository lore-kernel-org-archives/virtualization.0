Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4FEC433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96944415E5;
	Tue, 15 Mar 2022 08:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbIC9HWaAcz2; Tue, 15 Mar 2022 08:11:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D725E415E3;
	Tue, 15 Mar 2022 08:11:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A36A4C0012;
	Tue, 15 Mar 2022 08:11:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7268EC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E38660B2C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="tCmBQPD1";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="f7sFlfqB"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 80qq1GCwhiWv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:11:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D3AA60B12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:11:11 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F35lDE000803; 
 Tue, 15 Mar 2022 08:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BopKf40LdcasxKDuRL7u0Dwu1AZNv2yLBJyLc1z/M/U=;
 b=tCmBQPD1hhhGNY2unnhAXVkCn4xbZwDJeaESYwmXf5gajOFX4L5wr0RkW5Mr724Ol5dq
 65FaQT8NVNbbPa1NT1RDPRTYBiMXDiWN8LPLZG6j+vazBk81A/drwueEOD2eK1uTnHyX
 rcYsc195Bu2FSJhh5wVRPk5loWfQaYEtArwbSILqjNuD2niLEP4jFqa3h42Lq4EK15/g
 E3uXRr2vd0BTK+AQa33tV+qkN+yKBZnR6Vp02hGoCeXBfVJd/OLopgNzu/4P6gGmbvAh
 HpQ96UE/UQ9xZxb1SlO5HdUvtldzd8G67OBGg7LUdTCtU5+qJpW0RPrQBv1Kmbd3fgjK YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3et52ptevx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 08:11:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F8640F066172;
 Tue, 15 Mar 2022 08:11:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by aserp3030.oracle.com with ESMTP id 3et64tf9bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Mar 2022 08:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ4Ayb+nJcPbTz5MmVFJ9uU/cRrD9nfVSI/dPwLJMSG55l2MeRWdAhQ3+R1kMASpQF5BcKocVnFDaefUORJ25DfUfBd31cLqtu20I89z41DEjiZFfp6aeK1unbd251rAssjClZ9HygoIG9mM7yp/W+7aCKifjQretjH6UqoDqdtperSUg2Jh7U7vKl/2C4REq8cF/1kNSTNvfrgUgg7HSnwvajA8Wywqy71U4JH5C7ct4KEEe/qYeV6H+85NsFEytCp2xq4n8IA7wZp4/yTa7364CZHhRNPMwomkCtS5HcvDqsydBUziimIIWOnPZNFxGNEyEWR0K7g3zZGMALQMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BopKf40LdcasxKDuRL7u0Dwu1AZNv2yLBJyLc1z/M/U=;
 b=B8p9WLLADmLXYVny1iOPmEX9ClcaLh3zTcn6mvb/bALSGFtZ9eLbylfflJSVh+1YwGsCLGDxmNGejbCwzB80KMZvcTcAY+Wk2IBSBkgvJFubKW5leRwJN+ZO+ZNIC2vemOp5KxfACPbJvIRjEMOxjx5HJYGnA+s9CU7qFzAfYQtv9yp5B90JHdxRYnyv1QG9WT5baf+2Aci9ReOCAADHMkLNUf4DpYG7Dnp131RDGr7I8jgRH/QBMzUjEdQgcfP9SzMTmly3VqSPPitGwZMkatmxdWUhFTT5CnwSPZE/jRyzNoz2Xils1Zr2pPet88ZBx/VacDH6XaR6+5LHhJ5GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BopKf40LdcasxKDuRL7u0Dwu1AZNv2yLBJyLc1z/M/U=;
 b=f7sFlfqBFiLxxYyRUbpt32ooZiWKywBWwdUYZX79KqbgNu97HXnCaCuM8Rc6VdJJaBsBkp6xGqSKGtNTVGF/z5yrvNUtl5Yum71Vi4R7m96MEbGS0XC1cK0rRtWR/ZtfFG65s2jT/lwtAeoSL6Ec+0SJLEWhMVwf/Da/E1onW7M=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 08:11:05 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 08:11:04 +0000
Message-ID: <29cbfaba-5589-ac07-b244-d845de3a0fcc@oracle.com>
Date: Tue, 15 Mar 2022 01:11:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220216080022.56707-1-elic@nvidia.com>
 <20220216080022.56707-2-elic@nvidia.com>
 <22f77b5c-2003-c963-24c9-fce9cb53160d@oracle.com>
 <20220217064619.GB86497@mtl-vdi-166.wap.labs.mlnx>
 <8e834c04-47d2-1286-117d-28caa3e84606@oracle.com>
 <DM8PR12MB5400E80073521E898056578BAB089@DM8PR12MB5400.namprd12.prod.outlook.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
 <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
 <DM8PR12MB540086CCD1F535668D05E546AB0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <a30ac3c0-059d-4588-c5ac-599c060f6bbf@oracle.com>
 <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEsjv+Yz0W=-V=My3E7i7+sMSJhZAZrN+vSs_Bdh9nVdHA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsjv+Yz0W=-V=My3E7i7+sMSJhZAZrN+vSs_Bdh9nVdHA@mail.gmail.com>
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f171b012-5c32-419f-ca12-08da065b59d3
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4290290C7D5EBECEBCD6B4F1B1109@BY5PR10MB4290.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07gfW3bMPGE1F/lwj2acZ3xugMVjwcXXmlSw7FntvjMVx1YTG6hFiBQHWi+P1/yzyG8DV1t16PceJFevMJA1pR+0kTCHehdRPxKZ9Jgid9+RoorUMB24MHA3VXagc0PycRRrR+4mEnANIGIeex0OmFnAe33cjlLd+dOj91gsRsYS+l78oI3t9R0vcgwuiVQToGY3rx4kp0FT49kgFI3QPtrfq5h/bv+uxi6flgLC2sR5T/N9XIkRDIYUv6bZp60Rk6/t/GLoMo85dbc3y1aBIOe45rrYWSGPXw8t7PUXo3IK14zbmDaPLUZRE4R35Iy8gU+/JoE2y3/0BHaXYycEtEAPx/kBI7gZcOdA85lr1yWUhbU9KZJZIIEHM5P10vMCaUBecopfa8FWwPxSakcX1fkuhxKS3QSGDMFCEtk7Gjfk8AF8oNGeYeDDmEAYAu495SkMkB3pH+YnbWweBHZ6TcMnhysSCN6O9nzLvfj2PWrdSDzFONNO9zteeMOGz3mjhrX9MrTOLfovL+F8ANdBOao87veAQrN4DCXqme8RuAF46TOQny7SzpeY+jyYYMidgDme+vsT3pszg2zemZASPqd41thJCcT09pXh/6MlbkFuSq1nV7UMx7Yo9vgFFFdNwVbBPcWSCXJ3iIW1BR2q5uEkjYiU30M8q++YPngY5XI2jXjkeB3abQPFKPSgXQ7MycgKD19WZTqV5hqpEYWk4KhYudX37sU7vwCiTvzGlW9nnDohjuTzvAQwplsyMMSOUaZHIRgjUh/y2HFa2K4ldJ5nYEWBo/J95RJnwdCPnR1FsRps5pQt5hBJRm3nqlP8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(2616005)(6506007)(33964004)(38100700002)(53546011)(36916002)(30864003)(8936002)(5660300002)(6666004)(6512007)(86362001)(31696002)(166002)(186003)(26005)(83380400001)(66556008)(66476007)(316002)(54906003)(110136005)(66946007)(31686004)(6486002)(8676002)(36756003)(4326008)(508600001)(43740500002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9YQlRyZ2RFMkRnQUhXZ2JvRG1qOUYxMEhGektEVGhVVUNlTmVaa3VkRE1U?=
 =?utf-8?B?MEdKcXRsVU43cmxNQmNwRC80UFdNMXJLZlhoWWc0T0RnMDJTK05kL2h5WDFs?=
 =?utf-8?B?OWkxWjdkUjFnNk5wOUtiTUVjL0NhL1N4Vi84UDJyME1WTXBjZXZOR3JQU1Bi?=
 =?utf-8?B?VktDNkEveUZHZDVUZkR6bytNdDd4SHN5S01TV2RZNVY2SDB2dXR3SkIyNzY3?=
 =?utf-8?B?bmxBODhnMUg5YkZBbnZpYmpheUtiWkplSFRDbEM1MUh3Y3h1bmFLVTVMd0xn?=
 =?utf-8?B?UnU2aFZLYWFRUHRkTVF6dE4vTzFnTUJNenFVZlplRHVoRDdYa052cHhGMkly?=
 =?utf-8?B?TjZwRWNmUGZ5dzNld0hYcGZOOTFESUtEWnViVUQ1UUFqQWRmOWtjR1E1bW9O?=
 =?utf-8?B?UlUwRmhxcEY3Nk0xQklUTG5hMnllbXg1UE9ZbjNkTHdxRmhXZXFhbkg4Qjkz?=
 =?utf-8?B?QzluYStTTG1MS3VYZXRWZXYyalc4UG13eFdIeEw3dzNXVGp6cFl4VzZtMlQ5?=
 =?utf-8?B?SDgzd0V2RkZwd1dtZURVSnhPM0ZHK0l5VFdoOEduRUNyYWFtTWZFa2hUOVhW?=
 =?utf-8?B?Qk1vRFBZT1NsanNTM2psdk4rS0liTG95SkQrN2pzM0gxTmhQKzkwTVZWajBi?=
 =?utf-8?B?OXgzTnErOFJuU09VdkMxdXk3Ym9qSFFhemhuaFRIc1FFeDBGM2hjZVYrUkkv?=
 =?utf-8?B?MGx1dDh5Ympyd2hRaDdYajdISVdRK2lmV3JXK0RjZFRvZDJDaG9ibGNUVWNV?=
 =?utf-8?B?S2U4TGhiMS9rcnp6aHpMWjF6UDh0a2VkTFBibGVzR09nMThQOStYV01jRGxV?=
 =?utf-8?B?bHNFU3RQQXdRajhyckVoWHpETW1JdWtYdVFWaEw2eC9lSW9OK2FkelZYc1c5?=
 =?utf-8?B?MWo1Z2w1TzFUbHplREhDKy9SZEFwNzNYRzVwelJSa3hKNmpBSG4xOTZJU3la?=
 =?utf-8?B?RkdzY0E4VDFpSVRzRzNJUzRPaDBDT2ltTTIrYmdXZUNVRHBsa1hzRnZ5ajZD?=
 =?utf-8?B?VXJTSXVHRXB5NmxnRklaQmNmeEs2SXcvVHpkbzVVU2dUcEpvN1VwV1F1K2xC?=
 =?utf-8?B?NmFVV3FiUzJIS1lVTndmTWxOWjRpQUVQRzZ1ZHFrbW9XNG90VWlQSHF4eEtq?=
 =?utf-8?B?MlhvRDlyMUlLM3oxVmJxOEUxZTl4Ti9FQWxQZ0NZOGExRGk1cDFxUjBHMExw?=
 =?utf-8?B?N3dOYWtzNUdmRjZ6Nm4zc2NuTUZsdGJYY2UvYkJQeitmUkt3bFdBRVBJSU84?=
 =?utf-8?B?UURQSEEzRXVKSFJiM2FWK2FodThLSEt4RDFWS1BROTQrMExCKzduSStWdVhF?=
 =?utf-8?B?Q1djMlNtMmFzMUZweXhtK3pMRXRTUW44VVFLTmxHb1I2WDR3T0RBbzhlTzJH?=
 =?utf-8?B?b25LN2FYcVhVZDJPOEpxMDFjNzRkUmJSdVZsRXNrTmQvWmtjMEhSMDl1RTV2?=
 =?utf-8?B?YWZkZlY4NEhGK08yOWNVUHhUVkxTR0hYTVdsVExMSmhoamk0VDJZK1RpRUNq?=
 =?utf-8?B?cTVtWktjSEc3NDllSCtXQmswUllsblJiZk1aaENYVWdaQ3hhMFlPUjl0WnFh?=
 =?utf-8?B?b05jNTQ1TkhFa2NNbThYdDJNZlQzdG0yUUFvMU9HNGlXTmx4RFpwcUNOTU9l?=
 =?utf-8?B?WmpSd3J4NFBUMS8zRUVtdEJMaXZQdisyeEM1SXNHWEhFdEF5aGlHSUFTYXBR?=
 =?utf-8?B?cUsxekxybkJuOHFCS3BBZjBhZ0VESnczbFlEdDVzcHJ3MjIxdUdxNjJHSThv?=
 =?utf-8?B?Sk1Cb0NBV1Q0aG1DcEQweCtXTXp4djZjR1E4eDZnK1VBUXIrY0xXTXJjVWlp?=
 =?utf-8?B?ZXZvVVJDck9ndkh4d2hjQWg1QmtVNkxXczJOaVRlM0hQOGVwdmVvZUNXWHhk?=
 =?utf-8?B?aEdSU0RWMWFzaVA2alJIV3BqRHVwMTNZR0JCbWQxOUI4MGhqOGNyMlRPeEJu?=
 =?utf-8?B?NWllbWkrVncwbTFzL1RtTStISUVnRVNuN2tYalhjV3NTVlZ0VUJEeXg4SUYx?=
 =?utf-8?B?TndRME0ySGFBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f171b012-5c32-419f-ca12-08da065b59d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 08:11:04.7688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RLD/qhvQWx3e0KwZ7LVgd8ogOw9Kq+AsHHz9OYQAmxN8JQTkngBDJhX3Lk3VjisVTWOhubsEl4DAUWxLfAV0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286
 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150053
X-Proofpoint-GUID: zzxqTte_wRlWXj3XPq07d0L3Fwf5SguL
X-Proofpoint-ORIG-GUID: zzxqTte_wRlWXj3XPq07d0L3Fwf5SguL
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============5228127016160222074=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5228127016160222074==
Content-Type: multipart/alternative;
 boundary="------------WeU8dqHDONOV0cUrvkXA6TxP"
Content-Language: en-US

--------------WeU8dqHDONOV0cUrvkXA6TxP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/13/2022 11:25 PM, Jason Wang wrote:
>
>
> On Sun, Mar 13, 2022 at 11:26 PM Eli Cohen <elic@nvidia.com> wrote:
>
>     > On 3/8/2022 9:07 PM, Eli Cohen wrote:
>     > >
>     > >> -----Original Message-----
>     > >> From: Si-Wei Liu <si-wei.liu@oracle.com>
>     > >> Sent: Wednesday, March 9, 2022 5:33 AM
>     > >> To: Eli Cohen <elic@nvidia.com>
>     > >> Cc: mst@redhat.com; jasowang@redhat.com;
>     virtualization@lists.linux-
>     > >> foundation.org
>     <https://urldefense.com/v3/__http://foundation.org__;!!ACWV5N9M2RV99hQ!YPMORFmIws8PtrpKEDUfF-5a3cXRrZiABBLXYHHuLKRi3vHz9Uw2vznSWKi79mpV$>;
>     eperezma@redhat.com; amorenoz@redhat.com;
>     > >> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit
>     <parav@nvidia.com>
>     > >> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying
>     vendor statistics
>     > >>
>     > >>
>     > >>
>     > >> On 3/8/2022 6:13 AM, Eli Cohen wrote:
>     > >>>> -----Original Message-----
>     > >>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>     > >>>> Sent: Tuesday, March 8, 2022 8:16 AM
>     > >>>> To: Eli Cohen <elic@nvidia.com>
>     > >>>> Cc: mst@redhat.com; jasowang@redhat.com;
>     virtualization@lists.linux-
>     > >>>> foundation.org
>     <https://urldefense.com/v3/__http://foundation.org__;!!ACWV5N9M2RV99hQ!YPMORFmIws8PtrpKEDUfF-5a3cXRrZiABBLXYHHuLKRi3vHz9Uw2vznSWKi79mpV$>;
>     eperezma@redhat.com; amorenoz@redhat.com;
>     > >>>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit
>     > >>>> <parav@nvidia.com>
>     > >>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying
>     vendor
>     > >>>> statistics
>     > >>>>
>     > >>>>
>     > >>>>
>     > >>>> On 3/6/2022 11:57 PM, Eli Cohen wrote:
>     > >>>>>> -----Original Message-----
>     > >>>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>     > >>>>>> Sent: Saturday, March 5, 2022 12:34 AM
>     > >>>>>> To: Eli Cohen <elic@nvidia.com>
>     > >>>>>> Cc: mst@redhat.com; jasowang@redhat.com;
>     > >>>>>> virtualization@lists.linux- foundation.org
>     <https://urldefense.com/v3/__http://foundation.org__;!!ACWV5N9M2RV99hQ!YPMORFmIws8PtrpKEDUfF-5a3cXRrZiABBLXYHHuLKRi3vHz9Uw2vznSWKi79mpV$>;
>     eperezma@redhat.com;
>     > >>>>>> amorenoz@redhat.com; lvivier@redhat.com; sgarzare@redhat.com;
>     > >> Parav
>     > >>>>>> Pandit <parav@nvidia.com>
>     > >>>>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for
>     querying vendor
>     > >>>>>> statistics
>     > >>>>>>
>     > >>>>>> Sorry, I somehow missed this after my break. Please see
>     comments in
>     > >> line.
>     > >>>>>> On 2/16/2022 10:46 PM, Eli Cohen wrote:
>     > >>>>>>> On Wed, Feb 16, 2022 at 10:49:26AM -0800, Si-Wei Liu wrote:
>     > >>>>>>>> On 2/16/2022 12:00 AM, Eli Cohen wrote:
>     > >>>>>>>>> Allows to read vendor statistics of a vdpa device. The
>     specific
>     > >>>>>>>>> statistics data is received by the upstream driver in
>     the form
>     > >>>>>>>>> of an (attribute name, attribute value) pairs.
>     > >>>>>>>>>
>     > >>>>>>>>> An example of statistics for mlx5_vdpa device are:
>     > >>>>>>>>>
>     > >>>>>>>>> received_desc - number of descriptors received by the
>     virtqueue
>     > >>>>>>>>> completed_desc - number of descriptors completed by the
>     > >>>>>>>>> virtqueue
>     > >>>>>>>>>
>     > >>>>>>>>> A descriptor using indirect buffers is still counted
>     as 1. In
>     > >>>>>>>>> addition, N chained descriptors are counted correctly
>     N times as
>     > >>>>>>>>> one
>     > >>>>>> would expect.
>     > >>>>>>>>> A new callback was added to vdpa_config_ops which
>     provides the
>     > >>>>>>>>> means for the vdpa driver to return statistics results.
>     > >>>>>>>>>
>     > >>>>>>>>> The interface allows for reading all the supported
>     virtqueues,
>     > >>>>>>>>> including the control virtqueue if it exists.
>     > >>>>>>>>>
>     > >>>>>>>>> Below are some examples taken from mlx5_vdpa which are
>     > >>>>>>>>> introduced in the following patch:
>     > >>>>>>>>>
>     > >>>>>>>>> 1. Read statistics for the virtqueue at index 1
>     > >>>>>>>>>
>     > >>>>>>>>> $ vdpa dev vstats show vdpa-a qidx 1
>     > >>>>>>>>> vdpa-a:
>     > >>>>>>>>> queue_type tx queue_index 1 received_desc 3844836
>     > >> completed_desc
>     > >>>>>>>>> 3844836
>     > >>>>>>>>>
>     > >>>>>>>>> 2. Read statistics for the virtqueue at index 32 $
>     vdpa dev
>     > >>>>>>>>> vstats show vdpa-a qidx 32
>     > >>>>>>>>> vdpa-a:
>     > >>>>>>>>> queue_type control_vq queue_index 32 received_desc 62
>     > >>>>>>>>> completed_desc
>     > >>>>>>>>> 62
>     > >>>>>>>>>
>     > >>>>>>>>> 3. Read statisitics for the virtqueue at index 0 with json
>     > >>>>>>>>> output $ vdpa -j dev vstats show vdpa-a qidx 0
>     > >>>>>>>>> {"vstats":{"vdpa-a":{
>     > >>>>>>>>>
>     > >>>>>>
>     "queue_type":"rx","queue_index":0,"name":"received_desc","value":41
>     > >>>>>> 77
>     > >>>>>> 76,\
>     > >>>>>>>>>  "name":"completed_desc","value":417548}}}
>     > >>>>>>>>>
>     > >>>>>>>>> 4. Read statistics for the virtqueue at index 0 with
>     preety json
>     > >>>>>>>>> output $ vdpa -jp dev vstats show vdpa-a qidx 0 {
>     > >>>>>>>>>          "vstats": {
>     > >>>>>>>>> "vdpa-a": {
>     > >>>>>>>>>
>     > >>>>>>>>> "queue_type": "rx",
>     > >>>>>>>> I wonder where this info can be inferred? I don't see
>     relevant
>     > >>>>>>>> change in the patch series that helps gather the
>     > >>>> VDPA_ATTR_DEV_QUEUE_TYPE?
>     > >>>>>>>> Is this an arbitrary string defined by the vendor as
>     well? If so,
>     > >>>>>>>> how does the user expect to consume it?
>     > >>>>>>> The queue tupe is deduced from the index and whether we
>     have a
>     > >>>>>>> virtqueue. Even numbers are rx, odd numbers are tx and
>     if there is
>     > >>>>>>> CVQ, the last one is CVQ.
>     > >>>>>> OK, then VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in
>     this
>     > >>>>>> patch might not be useful at all?
>     > >>>>> Right, will remove.
>     > >>>>>
>     > >>>>>> And how do you determine in the vdpa tool if CVQ is
>     negotiated or
>     > >>>>>> not?
>     > >>>>> I make a netlink call to get the same information as "
>     vdpa dev config
>     > >> show"
>     > >>>> retrieves. I use the negotiated features to determine if a
>     CVQ is
>     > >>>> available. If it is, the number of VQs equals the control
>     VQ index.
>     > >>>> So there are two netlink calls under the hood.
>     > >>>> The lock vdpa_dev_mutex won't hold across the two separate
>     netlink
>     > >>>> calls, and it may end up with inconsistent state -
>     theoretically
>     > >>>> things could happen like that the first call gets CVQ
>     negotiated, but
>     > >>>> the later call for
>     > >>>> get_vendor_vq_stats() on the cvq might get -EINVAL due to
>     device
>     > >>>> reset. Can the negotiated status and stat query be done
>     within one single
>     > >> netlink call?
>     > >>> I see your concern.
>     > >>> The only reason I do the extra call is to know if we have a
>     control VQ
>     > >>> and what index it is, just to print a descriptive string
>     telling if it's a either rx,
>     > >> tx or control VQ.
>     > >>> So the cure can be simple. Let's have a new attribute that
>     returns the
>     > >>> type of virtqueue.
>     > >> I am not sure I follow the cure. Wouldn't it be possible to
>     get both negotiated
>     > >> status and the queue stat in vdpa_nl_cmd_dev_stats_get_doit()
>     under the
>     > >> same vdpa_dev_mutex lock?
>     > > Yes we can, but I suggested to get only the type of the queue
>     as a new attribute.
>     > > The kernel will do the digest and decide per a given VQ if
>     it's rx, tx or control and
>     > > return the result in that new attribute.
>     > The rx, tx and control queue type is net specific, while the
>     vdpa core
>     > is currently agnostic to the vdpa class.
>     >
>     > >
>     > >> And I am not even sure if it is a must to display
>     > >> the queue type - it doesn't seem the output includes the vdpa
>     class info, which
>     > >> makes it hard for script to parse the this field in generic way.
>     > > I don't get you. You say you don't think you need the queue
>     type and at the same
>     > > time you're concerned lack of information makes it hard for
>     scripts.
>     > > BTW, class info is something you can get for the device
>     through "vdpa dev show"
>     > > so your know the class of your device.
>     > Stepping back, may I ask if there's a case that queue type
>     specific stat
>     > may be defined by vendor, such that deciphering of certain
>     vendor stat
>     > would need type specific knowledge? So far the received_desc and
>     > completed_desc stats offered through the mlx5_vdpa patch look to be
>     > general ones and not associated with any queue type in
>     particular. Is
>     > there some future stat in your mind that needs specific knowledge of
>     > queue type and vdpa class?
>
>     No, the only reason for displaying the queue type is to help users
>     know kind of queue they're looking at.
>
>     >
>     > I'd prefer the vstat output to be self-contained and
>     self-descriptive.
>     > You may argue the class of vdpa never changes in "vdpa dev show"
>     after
>     > creation. This is true, however the queue type is not - say you
>     got a
>     > control queue for qindex 2, but the next moment you may get a rx
>     queue
>     > with the same qindex.
>
>     I don't think this is possible unless you destroyed the device and
>     re-created it.
>     What operation do you think could cause that?
>
>     > Particularly you seem want to tie this with queue
>     > index in the guest view, which is quite dynamic for host admin
>     or script
>     > running on the host to follow.
>
>     For rx and tx queues, some index may become invalid if the user
>     changed
>     the number of queues with ethtool -L but I don't think this is an
>     issue.
>     >
>     > >
>     > >>>    I think Jason did not like the idea of communicating the
>     kind of VQ
>     > >>> from kernel to userspace but under these circumstances,
>     maybe he would
>     > >> approve.
>     > >>> Jason?
>     > >>>
>     > >>>> What worried me is that the queue index being dynamic and
>     depended on
>     > >>>> negotiation status would make host admin user quite hard to
>     follow.
>     > >>>> The guest may or may not advertise F_MQ and/or F_CTRL_VQ across
>     > >> various phases, e.g.
>     > >>>> firmware (UEFI), boot loader (grub) till OS driver is up
>     and running,
>     > >>>> which can be agnostic to host admin. For most of the part
>     it's not
>     > >>>> easy to script and predict the queue index which can change
>     from time
>     > >>>> to time. Can we define the order of host predictable queue
>     index,
>     > >>>> which is independent from any guest negotiated state?
>     > >> Here I think we can just use the plain queue index in the
>     host view - say if vdpa
>     > >> net has 4 pairs of data vqs and 1 control vq, user may use
>     qindex 8 across the
>     > >> board to identify the control vq, regardless if the F_MQ
>     feature is negotiated
>     > >> or not in guest.
>     > > Right, but the idea that a userspace tool should provide
>     useful information to the
>     > > user so it does not need to do complex logic to infer that
>     from bare data.
>     > The host side qindex and qtype would never change regardless of
>     guest
>     > feature negotiation, by nature it reflects the real construct
>     and object
>     > in the hardware.
>
>
> This should be possible for vendor specific stats. But I'm afraid it 
> may cause more confusion since the spec doesn't have the concept like 
> "host queue index".
I am not sure if worth involving spec changes, but thinking it as a host 
side handle that can be constantly used to identify a certain vdpa 
device queue. Which should be vdpa specifics. Typically host admins 
would need a consistent handle without having to know or blindly guess 
the guest qindex, or query the negotiated features using another command 
upfront (which as said can be racy and problematic).

> And to be self descriptive the vendor need also display the mappings 
> between virtqueue index and host(vendor) queue index.
That's exactly what I had in mind. To ensure atomicity and 
self-describablity, it's a must to display both queue indexes in single 
vstat query output for a specific queue. See the example at the bottom 
of my early reply to Eli's email.

Thanks,
-Siwei

>
> Thanks
>
>     I don't feel it's a simple task for host users to
>     > figure out the correct guest side qindex for the control queue
>     -  it's
>     > always racy for one to check some other vdpa command output if
>     the vstat
>     > output is not self-contained.
>
>     So what are you actually proposing? Display received and completed
>     descriptors
>     per queue index without further interpretation?
>
>     >
>     > Thanks,
>     > -Siwei
>     >
>     > >
>     > >>
>     > >> Regards,
>     > >> -Siwei
>     > >>
>     > >>>>>> Looks to me there are still some loose end I don't quite yet
>     > >>>>>> understand.
>     > >>>>>>
>     > >>>>>>
>     > >>>>>>>>> "queue_index": 0,
>     > >>>>> I think this can be removed since the command is for a
>     specific index.
>     > >>>>>
>     > >>>>>>>>> "name": "received_desc",
>     > >>>>>>>>> "value": 417776,
>     > >>>>>>>>> "name": "completed_desc",
>     > >>>>>>>>> "value": 417548
>     > >>>>>>>> Not for this kernel patch, but IMHO it's the best to
>     put the name
>     > >>>>>>>> & value pairs in an array instead of flat entries in json's
>     > >>>>>>>> hash/dictionary. The hash entries can be re-ordered
>     deliberately
>     > >>>>>>>> by external json parsing tool, ending up with
>     inconsistent stat values.
>     > >>>>>> This comment is missed for some reason. Please change the
>     example
>     > >>>>>> in the log if you agree to address it in vdpa tool. Or
>     justify why
>     > >>>>>> keeping the order for json hash/dictionary is fine.
>     > >>>>> Sorry for skipping this comment.
>     > >>>>> Do you mean to present the information like:
>     > >>>>> "received_desc": 417776,
>     > >>>>> "completed_desc": 417548,
>     > >>>> I mean the following presentation:
>     > >>>>
>     > >>>> $ vdpa -jp dev vstats show vdpa-a qidx 0 {
>     > >>>>        "vstats": {
>     > >>>>            "vdpa-a": {
>     > >>>>                "queue_stats": [{
>     > >>>>                    "queue_index": 0,
>     > >>>>                    "queue_type": "rx",
>     > >>>>                    "stat_name": [
>     "received_desc","completed_desc" ],
>     > >>>>                    "stat_value": [ 417776,417548 ],
>     > >>>>                }]
>     > >>>>            }
>     > >>>>        }
>     > >>>> }
>     > >>>>
>     > >>>> I think Parav had similar suggestion, too.
>     > >>>>
>     > >>>> Thanks,
>     > >>>> -Siwei
>     > >>>>
>     > >>>>>> Thanks,
>     > >>>>>> -Siwei
>     > >>>>>>
>     > >>>>>>>> Thanks,
>     > >>>>>>>> -Siwei
>     > >>>>>>>>>              }
>     > >>>>>>>>>          }
>     > >>>>>>>>> }
>     > >>>>>>>>>
>     > >>>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>     > >>>>>>>>> ---
>     > >>>>>>>>>  drivers/vdpa/vdpa.c       | 129
>     > >>>>>> ++++++++++++++++++++++++++++++++++++++
>     > >>>>>>>>>  include/linux/vdpa.h      |   5 ++
>     > >>>>>>>>>  include/uapi/linux/vdpa.h |   7 +++
>     > >>>>>>>>>       3 files changed, 141 insertions(+)
>     > >>>>>>>>>
>     > >>>>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>     index
>     > >>>>>>>>> 9846c9de4bfa..d0ff671baf88 100644
>     > >>>>>>>>> --- a/drivers/vdpa/vdpa.c
>     > >>>>>>>>> +++ b/drivers/vdpa/vdpa.c
>     > >>>>>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct
>     vdpa_device
>     > >>>>>>>>> *vdev,
>     > >>>>>> struct sk_buff *msg, u32 portid,
>     > >>>>>>>>>             return err;
>     > >>>>>>>>>       }
>     > >>>>>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device
>     *vdev, struct
>     > >>>>>>>>> +sk_buff
>     > >>>>>> *msg,
>     > >>>>>>>>> +         struct genl_info *info, u32 index) {
>     > >>>>>>>>> +   int err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX,
>     index))
>     > >>>>>>>>> +           return -EMSGSIZE;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   err = vdev->config->get_vendor_vq_stats(vdev,
>     index, msg,
>     > >>>>>>>>> +info-
>     > >>>>>>> extack);
>     > >>>>>>>>> +   if (err)
>     > >>>>>>>>> +           return err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   return 0;
>     > >>>>>>>>> +}
>     > >>>>>>>>> +
>     > >>>>>>>>> +static int vendor_stats_fill(struct vdpa_device
>     *vdev, struct
>     > >>>>>>>>> +sk_buff
>     > >>>> *msg,
>     > >>>>>>>>> +       struct genl_info *info, u32 index) {
>     > >>>>>>>>> +   int err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   if (!vdev->config->get_vendor_vq_stats)
>     > >>>>>>>>> +           return -EOPNOTSUPP;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   err = vdpa_fill_stats_rec(vdev, msg, info, index);
>     > >>>>>>>>> +   if (err)
>     > >>>>>>>>> +           return err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   return 0;
>     > >>>>>>>>> +}
>     > >>>>>>>>> +
>     > >>>>>>>>> +static int vdpa_dev_vendor_stats_fill(struct
>     vdpa_device *vdev,
>     > >>>>>>>>> +                struct sk_buff *msg,
>     > >>>>>>>>> +                struct genl_info *info, u32 index) {
>     > >>>>>>>>> +   u32 device_id;
>     > >>>>>>>>> +   void *hdr;
>     > >>>>>>>>> +   int err;
>     > >>>>>>>>> +   u32 portid = info->snd_portid;
>     > >>>>>>>>> +   u32 seq = info->snd_seq;
>     > >>>>>>>>> +   u32 flags = 0;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   hdr = genlmsg_put(msg, portid, seq,
>     &vdpa_nl_family, flags,
>     > >>>>>>>>> +    VDPA_CMD_DEV_VSTATS_GET);
>     > >>>>>>>>> +   if (!hdr)
>     > >>>>>>>>> +           return -EMSGSIZE;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   if (nla_put_string(msg, VDPA_ATTR_DEV_NAME,
>     > >> dev_name(&vdev-
>     > >>>>>>> dev))) {
>     > >>>>>>>>> +           err = -EMSGSIZE;
>     > >>>>>>>>> +           goto undo_msg;
>     > >>>>>>>>> +   }
>     > >>>>>>>>> +
>     > >>>>>>>>> +   device_id = vdev->config->get_device_id(vdev);
>     > >>>>>>>>> +   if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>     > >>>>>>>>> +           err = -EMSGSIZE;
>     > >>>>>>>>> +           goto undo_msg;
>     > >>>>>>>>> +   }
>     > >>>>>>>>> +
>     > >>>>>>>>> +   err = vendor_stats_fill(vdev, msg, info, index);
>     > >>>>>>>>> +
>     > >>>>>>>>> +  genlmsg_end(msg, hdr);
>     > >>>>>>>>> +
>     > >>>>>>>>> +   return err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +undo_msg:
>     > >>>>>>>>> +  genlmsg_cancel(msg, hdr);
>     > >>>>>>>>> +   return err;
>     > >>>>>>>>> +}
>     > >>>>>>>>> +
>     > >>>>>>>>>       static int
>     vdpa_nl_cmd_dev_config_get_doit(struct sk_buff
>     > >>>>>>>>> *skb, struct
>     > >>>>>> genl_info *info)
>     > >>>>>>>>>       {
>     > >>>>>>>>>             struct vdpa_device *vdev;
>     > >>>>>>>>> @@ -990,6 +1058,60 @@
>     > >> vdpa_nl_cmd_dev_config_get_dumpit(struct
>     > >>>>>> sk_buff *msg, struct netlink_callback *
>     > >>>>>>>>>             return msg->len;
>     > >>>>>>>>>       }
>     > >>>>>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct
>     sk_buff *skb,
>     > >>>>>>>>> +                    struct genl_info *info)
>     > >>>>>>>>> +{
>     > >>>>>>>>> +   struct vdpa_device *vdev;
>     > >>>>>>>>> +   struct sk_buff *msg;
>     > >>>>>>>>> +   const char *devname;
>     > >>>>>>>>> +   struct device *dev;
>     > >>>>>>>>> +   u32 index;
>     > >>>>>>>>> +   int err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   if (!info->attrs[VDPA_ATTR_DEV_NAME])
>     > >>>>>>>>> +           return -EINVAL;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>     > >>>>>>>>> +           return -EINVAL;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>     > >>>>>>>>> +   msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>     > >>>>>>>>> +   if (!msg)
>     > >>>>>>>>> +           return -ENOMEM;
>     > >>>>>>>>> +
>     > >>>>>>>>> +   index = nla_get_u32(info-
>     > >>> attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>     > >>>>>>>>> +  mutex_lock(&vdpa_dev_mutex);
>     > >>>>>>>>> +   dev = bus_find_device(&vdpa_bus, NULL, devname,
>     > >>>>>> vdpa_name_match);
>     > >>>>>>>>> +   if (!dev) {
>     > >>>>>>>>> +  NL_SET_ERR_MSG_MOD(info->extack, "device not
>     > >> found");
>     > >>>>>>>>> +           err = -ENODEV;
>     > >>>>>>>>> +           goto dev_err;
>     > >>>>>>>>> +   }
>     > >>>>>>>>> +   vdev = container_of(dev, struct vdpa_device, dev);
>     > >>>>>>>>> +   if (!vdev->mdev) {
>     > >>>>>>>>> +  NL_SET_ERR_MSG_MOD(info->extack, "unmanaged
>     > >> vdpa
>     > >>>>>> device");
>     > >>>>>>>>> +           err = -EINVAL;
>     > >>>>>>>>> +           goto mdev_err;
>     > >>>>>>>>> +   }
>     > >>>>>>>>> +   err = vdpa_dev_vendor_stats_fill(vdev, msg, info,
>     index);
>     > >>>>>>>>> +   if (!err)
>     > >>>>>>>>> +           err = genlmsg_reply(msg, info);
>     > >>>>>>>>> +
>     > >>>>>>>>> +  put_device(dev);
>     > >>>>>>>>> +  mutex_unlock(&vdpa_dev_mutex);
>     > >>>>>>>>> +
>     > >>>>>>>>> +   if (err)
>     > >>>>>>>>> +  nlmsg_free(msg);
>     > >>>>>>>>> +
>     > >>>>>>>>> +   return err;
>     > >>>>>>>>> +
>     > >>>>>>>>> +mdev_err:
>     > >>>>>>>>> +  put_device(dev);
>     > >>>>>>>>> +dev_err:
>     > >>>>>>>>> +  mutex_unlock(&vdpa_dev_mutex);
>     > >>>>>>>>> +   return err;
>     > >>>>>>>>> +}
>     > >>>>>>>>> +
>     > >>>>>>>>>       static const struct nla_policy
>     vdpa_nl_policy[VDPA_ATTR_MAX + 1]
>     > >> = {
>     > >>>>>>>>>  [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =
>     > >>>> NLA_NUL_STRING },
>     > >>>>>>>>>  [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING
>     > >>>> }, @@ -
>     > >>>>>> 997,6
>     > >>>>>>>>> +1119,7 @@ static const struct nla_policy
>     > >>>>>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>     > >>>>>>>>>  [VDPA_ATTR_DEV_NET_CFG_MACADDR] =
>     > >>>> NLA_POLICY_ETH_ADDR,
>     > >>>>>>>>>             /* virtio spec 1.1 section 5.1.4.1 for
>     valid MTU range */
>     > >>>>>>>>>  [VDPA_ATTR_DEV_NET_CFG_MTU] =
>     > >>>> NLA_POLICY_MIN(NLA_U16, 68),
>     > >>>>>>>>> +  [VDPA_ATTR_DEV_QUEUE_INDEX] =
>     > >> NLA_POLICY_RANGE(NLA_U32, 0,
>     > >>>>>> 65535),
>     > >>>>>>>>>       };
>     > >>>>>>>>>       static const struct genl_ops vdpa_nl_ops[] = {
>     @@ -1030,6
>     > >>>>>>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>     > >>>>>>>>>  .doit = vdpa_nl_cmd_dev_config_get_doit,
>     > >>>>>>>>>  .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>     > >>>>>>>>>             },
>     > >>>>>>>>> +   {
>     > >>>>>>>>> +           .cmd = VDPA_CMD_DEV_VSTATS_GET,
>     > >>>>>>>>> +  .validate = GENL_DONT_VALIDATE_STRICT |
>     > >>>>>> GENL_DONT_VALIDATE_DUMP,
>     > >>>>>>>>> +           .doit = vdpa_nl_cmd_dev_stats_get_doit,
>     > >>>>>>>>> +           .flags = GENL_ADMIN_PERM,
>     > >>>>>>>>> +   },
>     > >>>>>>>>>       };
>     > >>>>>>>>>       static struct genl_family vdpa_nl_family
>     __ro_after_init =
>     > >>>>>>>>> { diff --git a/include/linux/vdpa.h
>     b/include/linux/vdpa.h index
>     > >>>>>>>>> 2de442ececae..274203845cfc 100644
>     > >>>>>>>>> --- a/include/linux/vdpa.h
>     > >>>>>>>>> +++ b/include/linux/vdpa.h
>     > >>>>>>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
>     > >>>>>>>>>              const struct vdpa_vq_state *state);
>     > >>>>>>>>>             int (*get_vq_state)(struct vdpa_device
>     *vdev, u16 idx,
>     > >>>>>>>>>              struct vdpa_vq_state *state);
>     > >>>>>>>>> +   int (*get_vendor_vq_stats)(struct vdpa_device
>     *vdev, u16 idx,
>     > >>>>>>>>> +             struct sk_buff *msg,
>     > >>>>>>>>> +             struct netlink_ext_ack *extack);
>     > >>>>>>>>>             struct vdpa_notification_area
>     > >>>>>>>>>  (*get_vq_notification)(struct vdpa_device *vdev, u16
>     idx);
>     > >>>>>>>>>             /* vq irq is not expected to be changed
>     once DRIVER_OK is
>     > >>>>>>>>> set */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
>     > >>>>>>>>>       int vdpa_mgmtdev_register(struct vdpa_mgmt_dev
>     *mdev);
>     > >>>>>>>>>       void vdpa_mgmtdev_unregister(struct
>     vdpa_mgmt_dev *mdev);
>     > >>>>>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>     > >>>>>>>>> +
>     > >>>>>>>>>       #endif /* _LINUX_VDPA_H */
>     > >>>>>>>>> diff --git a/include/uapi/linux/vdpa.h
>     > >>>>>>>>> b/include/uapi/linux/vdpa.h index
>     1061d8d2d09d..c5f229a41dc2
>     > >>>>>>>>> 100644
>     > >>>>>>>>> --- a/include/uapi/linux/vdpa.h
>     > >>>>>>>>> +++ b/include/uapi/linux/vdpa.h
>     > >>>>>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>     > >>>>>>>>>  VDPA_CMD_DEV_DEL,
>     > >>>>>>>>>  VDPA_CMD_DEV_GET,               /* can dump */
>     > >>>>>>>>>  VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
>     > >>>>>>>>> +  VDPA_CMD_DEV_VSTATS_GET,
>     > >>>>>>>>>       };
>     > >>>>>>>>>       enum vdpa_attr {
>     > >>>>>>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
>     > >>>>>>>>>  VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>     > >>>>>>>>>  VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /*
>     > >>>> u32 */
>     > >>>>>>>>>  VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
>     > >>>>>>>>> +
>     > >>>>>>>>> +  VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
>     > >>>>>>>>> +  VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
>     > >>>>>>>>> +  VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /*
>     > >> string */
>     > >>>>>>>>> +  VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>     > >>>>>>>>> +
>     > >>>>>>>>>             /* new attributes must be added above here */
>     > >>>>>>>>>  VDPA_ATTR_MAX,
>     > >>>>>>>>>       };
>

--------------WeU8dqHDONOV0cUrvkXA6TxP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 3/13/2022 11:25 PM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEsjv+Yz0W=-V=My3E7i7+sMSJhZAZrN+vSs_Bdh9nVdHA@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Sun, Mar 13, 2022 at
            11:26 PM Eli Cohen &lt;<a href="mailto:elic@nvidia.com" moz-do-not-send="true" class="moz-txt-link-freetext">elic@nvidia.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">&gt; On 3/8/2022 9:07 PM,
            Eli Cohen wrote:<br>
            &gt; &gt;<br>
            &gt; &gt;&gt; -----Original Message-----<br>
            &gt; &gt;&gt; From: Si-Wei Liu &lt;<a href="mailto:si-wei.liu@oracle.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">si-wei.liu@oracle.com</a>&gt;<br>
            &gt; &gt;&gt; Sent: Wednesday, March 9, 2022 5:33 AM<br>
            &gt; &gt;&gt; To: Eli Cohen &lt;<a href="mailto:elic@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">elic@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt; Cc: <a href="mailto:mst@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">mst@redhat.com</a>; <a href="mailto:jasowang@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">jasowang@redhat.com</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:virtualization@lists.linux">virtualization@lists.linux</a>-<br>
            &gt; &gt;&gt; <a href="https://urldefense.com/v3/__http://foundation.org__;!!ACWV5N9M2RV99hQ!YPMORFmIws8PtrpKEDUfF-5a3cXRrZiABBLXYHHuLKRi3vHz9Uw2vznSWKi79mpV$" rel="noreferrer" target="_blank" moz-do-not-send="true">foundation.org</a>;
            <a href="mailto:eperezma@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">eperezma@redhat.com</a>;
            <a href="mailto:amorenoz@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amorenoz@redhat.com</a>;<br>
            &gt; &gt;&gt; <a href="mailto:lvivier@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">lvivier@redhat.com</a>; <a href="mailto:sgarzare@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">sgarzare@redhat.com</a>;
            Parav Pandit &lt;<a href="mailto:parav@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">parav@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add support
            for querying vendor statistics<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt; On 3/8/2022 6:13 AM, Eli Cohen wrote:<br>
            &gt; &gt;&gt;&gt;&gt; -----Original Message-----<br>
            &gt; &gt;&gt;&gt;&gt; From: Si-Wei Liu &lt;<a href="mailto:si-wei.liu@oracle.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">si-wei.liu@oracle.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt; Sent: Tuesday, March 8, 2022 8:16 AM<br>
            &gt; &gt;&gt;&gt;&gt; To: Eli Cohen &lt;<a href="mailto:elic@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">elic@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt; Cc: <a href="mailto:mst@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">mst@redhat.com</a>; <a href="mailto:jasowang@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">jasowang@redhat.com</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:virtualization@lists.linux">virtualization@lists.linux</a>-<br>
            &gt; &gt;&gt;&gt;&gt; <a href="https://urldefense.com/v3/__http://foundation.org__;!!ACWV5N9M2RV99hQ!YPMORFmIws8PtrpKEDUfF-5a3cXRrZiABBLXYHHuLKRi3vHz9Uw2vznSWKi79mpV$" rel="noreferrer" target="_blank" moz-do-not-send="true">foundation.org</a>;
            <a href="mailto:eperezma@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">eperezma@redhat.com</a>;
            <a href="mailto:amorenoz@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amorenoz@redhat.com</a>;<br>
            &gt; &gt;&gt;&gt;&gt; <a href="mailto:lvivier@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">lvivier@redhat.com</a>; <a href="mailto:sgarzare@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">sgarzare@redhat.com</a>;
            Parav Pandit<br>
            &gt; &gt;&gt;&gt;&gt; &lt;<a href="mailto:parav@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">parav@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt; Subject: Re: [PATCH v1 1/2] vdpa: Add
            support for querying vendor<br>
            &gt; &gt;&gt;&gt;&gt; statistics<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt; On 3/6/2022 11:57 PM, Eli Cohen wrote:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; From: Si-Wei Liu &lt;<a href="mailto:si-wei.liu@oracle.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">si-wei.liu@oracle.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Sent: Saturday, March 5, 2022
            12:34 AM<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; To: Eli Cohen &lt;<a href="mailto:elic@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">elic@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Cc: <a href="mailto:mst@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">mst@redhat.com</a>;
            <a href="mailto:jasowang@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">jasowang@redhat.com</a>;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:virtualization@lists.linux">virtualization@lists.linux</a>- <a href="https://urldefense.com/v3/__http://foundation.org__;!!ACWV5N9M2RV99hQ!YPMORFmIws8PtrpKEDUfF-5a3cXRrZiABBLXYHHuLKRi3vHz9Uw2vznSWKi79mpV$" rel="noreferrer" target="_blank" moz-do-not-send="true">foundation.org</a>;
            <a href="mailto:eperezma@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">eperezma@redhat.com</a>;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; <a href="mailto:amorenoz@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amorenoz@redhat.com</a>;
            <a href="mailto:lvivier@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">lvivier@redhat.com</a>;
            <a href="mailto:sgarzare@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">sgarzare@redhat.com</a>;<br>
            &gt; &gt;&gt; Parav<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Pandit &lt;<a href="mailto:parav@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">parav@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: [PATCH v1 1/2]
            vdpa: Add support for querying vendor<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; statistics<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Sorry, I somehow missed this
            after my break. Please see comments in<br>
            &gt; &gt;&gt; line.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; On 2/16/2022 10:46 PM, Eli
            Cohen wrote:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Wed, Feb 16, 2022 at
            10:49:26AM -0800, Si-Wei Liu wrote:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On 2/16/2022 12:00 AM,
            Eli Cohen wrote:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Allows to read
            vendor statistics of a vdpa device. The specific<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; statistics data is
            received by the upstream driver in the form<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; of an (attribute
            name, attribute value) pairs.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; An example of
            statistics for mlx5_vdpa device are:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; received_desc -
            number of descriptors received by the virtqueue<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; completed_desc -
            number of descriptors completed by the<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; virtqueue<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; A descriptor using
            indirect buffers is still counted as 1. In<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; addition, N
            chained descriptors are counted correctly N times as<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; one<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; would expect.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; A new callback was
            added to vdpa_config_ops which provides the<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; means for the vdpa
            driver to return statistics results.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The interface
            allows for reading all the supported virtqueues,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; including the
            control virtqueue if it exists.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Below are some
            examples taken from mlx5_vdpa which are<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; introduced in the
            following patch:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 1. Read statistics
            for the virtqueue at index 1<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; $ vdpa dev vstats
            show vdpa-a qidx 1<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vdpa-a:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; queue_type tx
            queue_index 1 received_desc 3844836<br>
            &gt; &gt;&gt; completed_desc<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 3844836<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2. Read statistics
            for the virtqueue at index 32 $ vdpa dev<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vstats show vdpa-a
            qidx 32<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; vdpa-a:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; queue_type
            control_vq queue_index 32 received_desc 62<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; completed_desc<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 62<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 3. Read
            statisitics for the virtqueue at index 0 with json<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; output $ vdpa -j
            dev vstats show vdpa-a qidx 0<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
            {&quot;vstats&quot;:{&quot;vdpa-a&quot;:{<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;
            &quot;queue_type&quot;:&quot;rx&quot;,&quot;queue_index&quot;:0,&quot;name&quot;:&quot;received_desc&quot;,&quot;value&quot;:41<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; 77<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; 76,\<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;
            &nbsp;&quot;name&quot;:&quot;completed_desc&quot;,&quot;value&quot;:417548}}}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4. Read statistics
            for the virtqueue at index 0 with preety json<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; output $ vdpa -jp
            dev vstats show vdpa-a qidx 0 {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;vstats&quot;:
            {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;vdpa-a&quot;: {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;queue_type&quot;: &quot;rx&quot;,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I wonder where this
            info can be inferred? I don't see relevant<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; change in the patch
            series that helps gather the<br>
            &gt; &gt;&gt;&gt;&gt; VDPA_ATTR_DEV_QUEUE_TYPE?<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is this an arbitrary
            string defined by the vendor as well? If so,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; how does the user
            expect to consume it?<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; The queue tupe is deduced
            from the index and whether we have a<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; virtqueue. Even numbers
            are rx, odd numbers are tx and if there is<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; CVQ, the last one is CVQ.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; OK, then
            VDPA_ATTR_DEV_QUEUE_TYPE attribute introduced in this<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; patch might not be useful at
            all?<br>
            &gt; &gt;&gt;&gt;&gt;&gt; Right, will remove.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; And how do you determine in
            the vdpa tool if CVQ is negotiated or<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; not?<br>
            &gt; &gt;&gt;&gt;&gt;&gt; I make a netlink call to get the
            same information as &quot; vdpa dev config<br>
            &gt; &gt;&gt; show&quot;<br>
            &gt; &gt;&gt;&gt;&gt; retrieves. I use the negotiated
            features to determine if a CVQ is<br>
            &gt; &gt;&gt;&gt;&gt; available. If it is, the number of VQs
            equals the control VQ index.<br>
            &gt; &gt;&gt;&gt;&gt; So there are two netlink calls under
            the hood.<br>
            &gt; &gt;&gt;&gt;&gt; The lock vdpa_dev_mutex won't hold
            across the two separate netlink<br>
            &gt; &gt;&gt;&gt;&gt; calls, and it may end up with
            inconsistent state - theoretically<br>
            &gt; &gt;&gt;&gt;&gt; things could happen like that the
            first call gets CVQ negotiated, but<br>
            &gt; &gt;&gt;&gt;&gt; the later call for<br>
            &gt; &gt;&gt;&gt;&gt; get_vendor_vq_stats() on the cvq might
            get -EINVAL due to device<br>
            &gt; &gt;&gt;&gt;&gt; reset. Can the negotiated status and
            stat query be done within one single<br>
            &gt; &gt;&gt; netlink call?<br>
            &gt; &gt;&gt;&gt; I see your concern.<br>
            &gt; &gt;&gt;&gt; The only reason I do the extra call is to
            know if we have a control VQ<br>
            &gt; &gt;&gt;&gt; and what index it is, just to print a
            descriptive string telling if it's a either rx,<br>
            &gt; &gt;&gt; tx or control VQ.<br>
            &gt; &gt;&gt;&gt; So the cure can be simple. Let's have a
            new attribute that returns the<br>
            &gt; &gt;&gt;&gt; type of virtqueue.<br>
            &gt; &gt;&gt; I am not sure I follow the cure. Wouldn't it
            be possible to get both negotiated<br>
            &gt; &gt;&gt; status and the queue stat in
            vdpa_nl_cmd_dev_stats_get_doit() under the<br>
            &gt; &gt;&gt; same vdpa_dev_mutex lock?<br>
            &gt; &gt; Yes we can, but I suggested to get only the type
            of the queue as a new attribute.<br>
            &gt; &gt; The kernel will do the digest and decide per a
            given VQ if it's rx, tx or control and<br>
            &gt; &gt; return the result in that new attribute.<br>
            &gt; The rx, tx and control queue type is net specific,
            while the vdpa core<br>
            &gt; is currently agnostic to the vdpa class.<br>
            &gt; <br>
            &gt; &gt;<br>
            &gt; &gt;&gt; And I am not even sure if it is a must to
            display<br>
            &gt; &gt;&gt; the queue type - it doesn't seem the output
            includes the vdpa class info, which<br>
            &gt; &gt;&gt; makes it hard for script to parse the this
            field in generic way.<br>
            &gt; &gt; I don't get you. You say you don't think you need
            the queue type and at the same<br>
            &gt; &gt; time you're concerned lack of information makes it
            hard for scripts.<br>
            &gt; &gt; BTW, class info is something you can get for the
            device through &quot;vdpa dev show&quot;<br>
            &gt; &gt; so your know the class of your device.<br>
            &gt; Stepping back, may I ask if there's a case that queue
            type specific stat<br>
            &gt; may be defined by vendor, such that deciphering of
            certain vendor stat<br>
            &gt; would need type specific knowledge? So far the
            received_desc and<br>
            &gt; completed_desc stats offered through the mlx5_vdpa
            patch look to be<br>
            &gt; general ones and not associated with any queue type in
            particular. Is<br>
            &gt; there some future stat in your mind that needs specific
            knowledge of<br>
            &gt; queue type and vdpa class?<br>
            <br>
            No, the only reason for displaying the queue type is to help
            users<br>
            know kind of queue they're looking at.<br>
            <br>
            &gt; <br>
            &gt; I'd prefer the vstat output to be self-contained and
            self-descriptive.<br>
            &gt; You may argue the class of vdpa never changes in &quot;vdpa
            dev show&quot; after<br>
            &gt; creation. This is true, however the queue type is not -
            say you got a<br>
            &gt; control queue for qindex 2, but the next moment you may
            get a rx queue<br>
            &gt; with the same qindex.<br>
            <br>
            I don't think this is possible unless you destroyed the
            device and re-created it.<br>
            What operation do you think could cause that?<br>
            <br>
            &gt; Particularly you seem want to tie this with queue<br>
            &gt; index in the guest view, which is quite dynamic for
            host admin or script<br>
            &gt; running on the host to follow.<br>
            <br>
            For rx and tx queues, some index may become invalid if the
            user changed<br>
            the number of queues with ethtool -L but I don't think this
            is an issue.<br>
            &gt; <br>
            &gt; &gt;<br>
            &gt; &gt;&gt;&gt;&nbsp; &nbsp; I think Jason did not like the idea of
            communicating the kind of VQ<br>
            &gt; &gt;&gt;&gt; from kernel to userspace but under these
            circumstances, maybe he would<br>
            &gt; &gt;&gt; approve.<br>
            &gt; &gt;&gt;&gt; Jason?<br>
            &gt; &gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt; What worried me is that the queue
            index being dynamic and depended on<br>
            &gt; &gt;&gt;&gt;&gt; negotiation status would make host
            admin user quite hard to follow.<br>
            &gt; &gt;&gt;&gt;&gt; The guest may or may not advertise
            F_MQ and/or F_CTRL_VQ across<br>
            &gt; &gt;&gt; various phases, e.g.<br>
            &gt; &gt;&gt;&gt;&gt; firmware (UEFI), boot loader (grub)
            till OS driver is up and running,<br>
            &gt; &gt;&gt;&gt;&gt; which can be agnostic to host admin.
            For most of the part it's not<br>
            &gt; &gt;&gt;&gt;&gt; easy to script and predict the queue
            index which can change from time<br>
            &gt; &gt;&gt;&gt;&gt; to time. Can we define the order of
            host predictable queue index,<br>
            &gt; &gt;&gt;&gt;&gt; which is independent from any guest
            negotiated state?<br>
            &gt; &gt;&gt; Here I think we can just use the plain queue
            index in the host view - say if vdpa<br>
            &gt; &gt;&gt; net has 4 pairs of data vqs and 1 control vq,
            user may use qindex 8 across the<br>
            &gt; &gt;&gt; board to identify the control vq, regardless
            if the F_MQ feature is negotiated<br>
            &gt; &gt;&gt; or not in guest.<br>
            &gt; &gt; Right, but the idea that a userspace tool should
            provide useful information to the<br>
            &gt; &gt; user so it does not need to do complex logic to
            infer that from bare data.<br>
            &gt; The host side qindex and qtype would never change
            regardless of guest<br>
            &gt; feature negotiation, by nature it reflects the real
            construct and object<br>
            &gt; in the hardware.</blockquote>
          <div><br>
          </div>
          <div>This should be possible for vendor specific stats. But
            I'm afraid it may cause more confusion since the spec
            doesn't have the concept like &quot;host queue index&quot;.</div>
        </div>
      </div>
    </blockquote>
    I am not sure if worth involving spec changes, but thinking it as a
    host side handle that can be constantly used to identify a certain
    vdpa device queue. Which should be vdpa specifics. Typically host
    admins would need a consistent handle without having to know or
    blindly guess the guest qindex, or query the negotiated features
    using another command upfront (which as said can be racy and
    problematic).<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsjv+Yz0W=-V=My3E7i7+sMSJhZAZrN+vSs_Bdh9nVdHA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> And to be self descriptive the vendor need also display
            the mappings between virtqueue index and host(vendor) queue
            index.</div>
        </div>
      </div>
    </blockquote>
    That's exactly what I had in mind. To ensure atomicity and
    self-describablity, it's a must to display both queue indexes in
    single vstat query output for a specific queue. See the example at
    the bottom of my early reply to Eli's email.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEsjv+Yz0W=-V=My3E7i7+sMSJhZAZrN+vSs_Bdh9nVdHA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Thanks</div>
          <div>&nbsp;<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex"> I don't feel it's a
            simple task for host users to<br>
            &gt; figure out the correct guest side qindex for the
            control queue -&nbsp; it's<br>
            &gt; always racy for one to check some other vdpa command
            output if the vstat<br>
            &gt; output is not self-contained.<br>
            <br>
            So what are you actually proposing? Display received and
            completed descriptors<br>
            per queue index without further interpretation?<br>
            <br>
            &gt; <br>
            &gt; Thanks,<br>
            &gt; -Siwei<br>
            &gt; <br>
            &gt; &gt;<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt; Regards,<br>
            &gt; &gt;&gt; -Siwei<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Looks to me there are still
            some loose end I don't quite yet<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; understand.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;queue_index&quot;: 0,<br>
            &gt; &gt;&gt;&gt;&gt;&gt; I think this can be removed since
            the command is for a specific index.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;name&quot;: &quot;received_desc&quot;,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;value&quot;: 417776,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;name&quot;: &quot;completed_desc&quot;,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &quot;value&quot;: 417548<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Not for this kernel
            patch, but IMHO it's the best to put the name<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &amp; value pairs in
            an array instead of flat entries in json's<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; hash/dictionary. The
            hash entries can be re-ordered deliberately<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; by external json
            parsing tool, ending up with inconsistent stat values.<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; This comment is missed for
            some reason. Please change the example<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; in the log if you agree to
            address it in vdpa tool. Or justify why<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; keeping the order for json
            hash/dictionary is fine.<br>
            &gt; &gt;&gt;&gt;&gt;&gt; Sorry for skipping this comment.<br>
            &gt; &gt;&gt;&gt;&gt;&gt; Do you mean to present the
            information like:<br>
            &gt; &gt;&gt;&gt;&gt;&gt; &quot;received_desc&quot;: 417776,<br>
            &gt; &gt;&gt;&gt;&gt;&gt; &quot;completed_desc&quot;: 417548,<br>
            &gt; &gt;&gt;&gt;&gt; I mean the following presentation:<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt; $ vdpa -jp dev vstats show vdpa-a qidx
            0 {<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &quot;vstats&quot;: {<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;vdpa-a&quot;: {<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;queue_stats&quot;: [{<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;queue_index&quot;: 0,<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;queue_type&quot;: &quot;rx&quot;,<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;stat_name&quot;: [
            &quot;received_desc&quot;,&quot;completed_desc&quot; ],<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;stat_value&quot;: [
            417776,417548 ],<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }]<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
            &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; }<br>
            &gt; &gt;&gt;&gt;&gt; }<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt; I think Parav had similar suggestion,
            too.<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt; Thanks,<br>
            &gt; &gt;&gt;&gt;&gt; -Siwei<br>
            &gt; &gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; -Siwei<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Thanks,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; -Siwei<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; }<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Eli
            Cohen &lt;<a href="mailto:elic@nvidia.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">elic@nvidia.com</a>&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;
            &nbsp;drivers/vdpa/vdpa.c&nbsp; &nbsp; &nbsp; &nbsp;| 129<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;
            ++++++++++++++++++++++++++++++++++++++<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;
            &nbsp;include/linux/vdpa.h&nbsp; &nbsp; &nbsp; |&nbsp; &nbsp;5 ++<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp;
            &nbsp;include/uapi/linux/vdpa.h |&nbsp; &nbsp;7 +++<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;3 files
            changed, 141 insertions(+)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git
            a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
            9846c9de4bfa..d0ff671baf88 100644<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
            a/drivers/vdpa/vdpa.c<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++
            b/drivers/vdpa/vdpa.c<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -909,6 +909,74
            @@ vdpa_dev_config_fill(struct vdpa_device<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; *vdev,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; struct sk_buff *msg, u32
            portid,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int
            vdpa_fill_stats_rec(struct vdpa_device *vdev, struct<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +sk_buff<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; *msg,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; struct genl_info *info, u32 index) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;int err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            -EMSGSIZE;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;err =
            vdev-&gt;config-&gt;get_vendor_vq_stats(vdev, index, msg,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +info-<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; extack);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (err)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;return 0;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int
            vendor_stats_fill(struct vdpa_device *vdev, struct<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +sk_buff<br>
            &gt; &gt;&gt;&gt;&gt; *msg,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; struct genl_info *info, u32 index) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;int err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (!vdev-&gt;config-&gt;get_vendor_vq_stats)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            -EOPNOTSUPP;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;err =
            vdpa_fill_stats_rec(vdev, msg, info, index);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (err)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;return 0;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int
            vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct sk_buff *msg,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct genl_info *info, u32 index) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;u32 device_id;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;void *hdr;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;int err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;u32 portid =
            info-&gt;snd_portid;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;u32 seq =
            info-&gt;snd_seq;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;u32 flags = 0;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;hdr =
            genlmsg_put(msg, portid, seq, &amp;vdpa_nl_family, flags,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp;VDPA_CMD_DEV_VSTATS_GET);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (!hdr)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            -EMSGSIZE;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (nla_put_string(msg, VDPA_ATTR_DEV_NAME,<br>
            &gt; &gt;&gt; dev_name(&amp;vdev-<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; dev))) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err =
            -EMSGSIZE;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto
            undo_msg;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;device_id =
            vdev-&gt;config-&gt;get_device_id(vdev);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err =
            -EMSGSIZE;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto
            undo_msg;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;err =
            vendor_stats_fill(vdev, msg, info, index);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;genlmsg_end(msg, hdr);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;return err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +undo_msg:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;genlmsg_cancel(msg, hdr);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;return err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;static int
            vdpa_nl_cmd_dev_config_get_doit(struct sk_buff<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; *skb, struct<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; genl_info *info)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;{<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
            vdpa_device *vdev;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -990,6 +1058,60
            @@<br>
            &gt; &gt;&gt; vdpa_nl_cmd_dev_config_get_dumpit(struct<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; sk_buff *msg, struct
            netlink_callback *<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            msg-&gt;len;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +static int
            vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct genl_info *info)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +{<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;struct
            vdpa_device *vdev;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;struct sk_buff
            *msg;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;const char
            *devname;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;struct device
            *dev;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;u32 index;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;int err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (!info-&gt;attrs[VDPA_ATTR_DEV_NAME])<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            -EINVAL;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (!info-&gt;attrs[VDPA_ATTR_DEV_QUEUE_INDEX])<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            -EINVAL;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;devname =
            nla_data(info-&gt;attrs[VDPA_ATTR_DEV_NAME]);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;msg =
            nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (!msg)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
            -ENOMEM;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;index =
            nla_get_u32(info-<br>
            &gt; &gt;&gt;&gt; attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;mutex_lock(&amp;vdpa_dev_mutex);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;dev =
            bus_find_device(&amp;vdpa_bus, NULL, devname,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; vdpa_name_match);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (!dev) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;NL_SET_ERR_MSG_MOD(info-&gt;extack, &quot;device not<br>
            &gt; &gt;&gt; found&quot;);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err =
            -ENODEV;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto
            dev_err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;vdev =
            container_of(dev, struct vdpa_device, dev);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if
            (!vdev-&gt;mdev) {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;NL_SET_ERR_MSG_MOD(info-&gt;extack, &quot;unmanaged<br>
            &gt; &gt;&gt; vdpa<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; device&quot;);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err =
            -EINVAL;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto
            mdev_err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;err =
            vdpa_dev_vendor_stats_fill(vdev, msg, info, index);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (!err)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;err =
            genlmsg_reply(msg, info);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;put_device(dev);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;mutex_unlock(&amp;vdpa_dev_mutex);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;if (err)<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;nlmsg_free(msg);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;return err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +mdev_err:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;put_device(dev);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +dev_err:<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;mutex_unlock(&amp;vdpa_dev_mutex);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;return err;<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +}<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;static const
            struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1]<br>
            &gt; &gt;&gt; = {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =<br>
            &gt; &gt;&gt;&gt;&gt; NLA_NUL_STRING },<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING<br>
            &gt; &gt;&gt;&gt;&gt; }, @@ -<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; 997,6<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +1119,7 @@ static
            const struct nla_policy<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; vdpa_nl_policy[VDPA_ATTR_MAX +
            1] = {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;[VDPA_ATTR_DEV_NET_CFG_MACADDR] =<br>
            &gt; &gt;&gt;&gt;&gt; NLA_POLICY_ETH_ADDR,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*
            virtio spec 1.1 section 5.1.4.1 for valid MTU range */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;[VDPA_ATTR_DEV_NET_CFG_MTU] =<br>
            &gt; &gt;&gt;&gt;&gt; NLA_POLICY_MIN(NLA_U16, 68),<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;[VDPA_ATTR_DEV_QUEUE_INDEX] =<br>
            &gt; &gt;&gt; NLA_POLICY_RANGE(NLA_U32, 0,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; 65535),<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;};<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;static const
            struct genl_ops vdpa_nl_ops[] = { @@ -1030,6<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +1153,12 @@ static
            const struct genl_ops vdpa_nl_ops[] = {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;.doit = vdpa_nl_cmd_dev_config_get_doit,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;},<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;{<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.cmd =
            VDPA_CMD_DEV_VSTATS_GET,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;.validate = GENL_DONT_VALIDATE_STRICT |<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt; GENL_DONT_VALIDATE_DUMP,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.doit
            = vdpa_nl_cmd_dev_stats_get_doit,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.flags
            = GENL_ADMIN_PERM,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;},<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;};<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;static
            struct genl_family vdpa_nl_family __ro_after_init =<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; { diff --git
            a/include/linux/vdpa.h b/include/linux/vdpa.h index<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
            2de442ececae..274203845cfc 100644<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
            a/include/linux/vdpa.h<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++
            b/include/linux/vdpa.h<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -275,6 +275,9
            @@ struct vdpa_config_ops {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;const struct vdpa_vq_state *state);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int
            (*get_vq_state)(struct vdpa_device *vdev, u16 idx,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct vdpa_vq_state *state);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp;int
            (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct sk_buff *msg,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct netlink_ext_ack *extack);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
            vdpa_notification_area<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* vq
            irq is not expected to be changed once DRIVER_OK is<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; set */ @@ -466,4
            +469,6 @@ struct vdpa_mgmt_dev {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;int
            vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;void
            vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +#define
            VDPA_INVAL_QUEUE_INDEX 0xffff<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;#endif /*
            _LINUX_VDPA_H */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git
            a/include/uapi/linux/vdpa.h<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
            b/include/uapi/linux/vdpa.h index 1061d8d2d09d..c5f229a41dc2<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 100644<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---
            a/include/uapi/linux/vdpa.h<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++
            b/include/uapi/linux/vdpa.h<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -18,6 +18,7 @@
            enum vdpa_command {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_CMD_DEV_DEL,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_CMD_DEV_GET,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* can dump */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_CMD_DEV_CONFIG_GET,&nbsp; &nbsp; &nbsp; &nbsp; /* can dump */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;VDPA_CMD_DEV_VSTATS_GET,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;};<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;enum
            vdpa_attr {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -46,6 +47,12 @@
            enum vdpa_attr {<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_ATTR_DEV_NEGOTIATED_FEATURES,&nbsp; &nbsp; &nbsp; /* u64 */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*<br>
            &gt; &gt;&gt;&gt;&gt; u32 */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_ATTR_DEV_SUPPORTED_FEATURES,&nbsp; &nbsp; &nbsp; &nbsp;/* u64 */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;VDPA_ATTR_DEV_QUEUE_INDEX,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* u16 */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;VDPA_ATTR_DEV_QUEUE_TYPE,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* string */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;VDPA_ATTR_DEV_VENDOR_ATTR_NAME,&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
            &gt; &gt;&gt; string */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;
            &nbsp;VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,&nbsp; &nbsp; &nbsp; &nbsp; /* u64 */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* new
            attributes must be added above here */<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;VDPA_ATTR_MAX,<br>
            &gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;};<br>
            <br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------WeU8dqHDONOV0cUrvkXA6TxP--

--===============5228127016160222074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5228127016160222074==--
