Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C8BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 09:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9E38410D2;
	Tue, 11 Jan 2022 09:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRSRmTSJZJ7r; Tue, 11 Jan 2022 09:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49F7D4092B;
	Tue, 11 Jan 2022 09:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F34DC0030;
	Tue, 11 Jan 2022 09:23:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C15C7C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABCA583E29
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="XIAVDirC";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="B0JEofkg"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W-22aSTqrilO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB9DB82F11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:44 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8cbTN008952; 
 Tue, 11 Jan 2022 09:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G7aLrgyODNFlZhR1gz2qFGJ5QFurXXANX1WsvdmNDBQ=;
 b=XIAVDirCzWt3XN5U0CuH+bpbQtCbdDrSZY6uT/VmHUma2dveHJ6PyOkESlhq5PKzmj4g
 LnL6EgRMxuCa8plefsJE++VLWfinGXsoL3HFaioGIok+Gmsq0p3MtsLxjH0ggVU1SqqS
 t7M/+aoPn7NndVjN+/y3V3bKa+PKRja/MmQc8vHuNU8oX3rIQqapQ4DD6Aq1PdE3MPzZ
 CsmaHRH7V4WgmOSufYsvUHulo9gjzhfuhfKQ/i6zF9IMFsVMar+mzDSKJ2vWEsoduvKz
 05ZnN/aCS5M4OfjkDJPYKXwhhYZBvRA+PKga1yIpiYa3s9Ww6/UI46X/2QiO6sFwQUgr Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgatsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:23:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B9ARwS017633;
 Tue, 11 Jan 2022 09:23:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by aserp3030.oracle.com with ESMTP id 3df0ndsnnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 09:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzqNVJU+iiweG+irChqJfQ+WadhfLPJsBF4v7Op/ZYqz0ZUiC/biuIiPDF2TI2GrsKLpxVhSqyk1mbAZTwOk2VZPaF0dx+HaIJVgKofPzsAge9LdCV2koYzHa6x15i/M6kWShfSS0VvqfUYcpFXhp3Wk8bXdPoA50Ap1+W1GAiFsF7h6VNBvPeGBSDI/w5uxuIQlctL5PcmjbD6OSjVTdIXyn2B1LGLFdDssBu/r5YuhjwKfxaH3HJ2ES5kYWKDNU09VhPgKYh3/x08ECWeZM8LDymJqqzjIDj7ZWoYj1lsi/NRe4OrLBJ5eORGf1lE9NpCtk+X/sLULcXICSvIf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7aLrgyODNFlZhR1gz2qFGJ5QFurXXANX1WsvdmNDBQ=;
 b=G//5Z4IF/8GP7sRIWfaQaxCBW7kCQrc7VXKsQyK35NTArN2KW8oNDbQsRzzofUP36mRk43mjwX3MHXT0MPytu96EYSmE892lt+FdRKE3YPwpmR2qZ6kSdMn9rFZEOJ9G8COlo5P5l/tA3T4VoMTOlGuIdhnXhb21sOmiYw6CDCiWPXDbEBCUB2hHm1gfRMQfYAoqjeCr2QmCZTNnkwnlt8tfCS75dc/Bw8lnxDWq/LdyBiEdlfD85xdBOxi9wcLbPKkYLId2qnZUxUo5K7+SzXaja2ChZwn8Io2SNBMkrq2V8sneKA6hYxpFiopn9CEPdD29+HCnDOqgrELccHm2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7aLrgyODNFlZhR1gz2qFGJ5QFurXXANX1WsvdmNDBQ=;
 b=B0JEofkguQ+GOHCk/gB+EwZwWFVOUxvb6mbcjC5zVbRPBwlpx4kX9mLsfjjoRLxXs8XUpscbk7xfls2AnwNRu1NjncinolSuYJ0IX9Is7foL+rmdhlNz7UfkVoa6bDBR/3W7LAxKMxmTK9zDjCoIh5lpra3arE8QG2gj8p/Q5fs=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3703.namprd10.prod.outlook.com (2603:10b6:a03:122::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 09:23:40 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:23:40 +0000
Message-ID: <3843979e-3bb0-2bd1-475d-646b62c1a909@oracle.com>
Date: Tue, 11 Jan 2022 01:23:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
 <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
 <3af55c17-49ad-bc9f-1b96-0a59b2ba1856@redhat.com>
 <a4fefb05-958b-743c-87da-652420b98e70@oracle.com>
 <CACGkMEvgQ-Qq36Ldgu7aNBaZ85ERQbaFfW4CY0i3so8NzpcAGA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvgQ-Qq36Ldgu7aNBaZ85ERQbaFfW4CY0i3so8NzpcAGA@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0195.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::20) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b03d7af7-462f-4e8e-859a-08d9d4e40def
X-MS-TrafficTypeDiagnostic: BYAPR10MB3703:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37036B22009C8697EDA8B335B1519@BYAPR10MB3703.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiRR4i6kwzsMPxDz91cN6d+os6K0v2O4Pzho5TM8GHmYWZ0WU1CjSCYXTE2ohGuf8154HObBUF3ew8aFK0Er4vzDcuKAsjjRc21pjYN1LrvN9/HDZI62/1Cb/qz8C/6NFg/+HOrsWk4lxI3opcl+ZtUGhgcVxZPxTgnx5UUQZpu0E8ceDT37+I0gb8t3I75O4V08uSeGOxuqX9yTWp6a1g1gMY7GffundQ4UP+FDUniJoRUxFd4WVo3StRIrErLY6ouhhQ2WBS8BMnbwafJMW20jW/j627QeEL3F6k7KecLPPZmQbD642n5MJp5zc5AdhrrGyaOjv9aeresrpWgtTjStupe3MHlfZE4daoNtwojyeZsuLefqaX5VQYOY634utrJnhhxel3mmdK4w5nycS5IurkjoSyZYKdB1v35YFUevMMwabJESTxtB7ZDbSytkMA91feUhwE3xmsI71wlQZZcQjkY6DQwF4yVd+9T8VyGmhcATsyfAQ6Gay1gDiC1xcdxsXkD7JPCo9ddE6ut69dGc2V0uxKvY/ucF7SFhS+QpukDC5bJPUDHOzKRXgZZll3lSWplvQreRsvQTYtm+KBTWUjkMJKpzNU5EgjphRQauz/mB03hC2KOaW5lVjhIRThSnDWE37tZzVjmZDwWmSf1NEXD9GyH8qRempYtdCXh4X2B/bhRVjM09NV/jpyvndxfWucrLJ+jknAYfYCEii7mR/DDpEhoI4qmXi1TrJQhmpOEM3s2klswavtRknssR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6916009)(26005)(6666004)(186003)(66946007)(5660300002)(8676002)(36916002)(66476007)(53546011)(6506007)(66556008)(316002)(83380400001)(36756003)(31696002)(38100700002)(54906003)(6486002)(4326008)(2616005)(86362001)(6512007)(31686004)(2906002)(508600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2w4dHQ2ZDBBblVKdGpJaGFWUU53ems0c2lSNzBDUnkzSlcra3F2cVhkb3J1?=
 =?utf-8?B?NldHSS9FMWtCZlVLT1AxUXBjYkVmcVlzbUhMNEQwbHlpekNod0p0eENJS2Zo?=
 =?utf-8?B?MFN6OEZ4THB6RmZVcjdCSnl0Tm51eUJUamhWYmUrWkhJOC9QQnV3a0N1TS92?=
 =?utf-8?B?cWw3ZkhPSENUL2xHVFU1ejNhZUFaajhnV0NrbnUzaGgxNTEyOTVnMENjdW9Z?=
 =?utf-8?B?N0wvNXFueW84S3MrOG9KR3E5YmgvT2dLWFNid21EV1F2YlQvZERiT2VaSVNZ?=
 =?utf-8?B?bFA2dFk2M05Kai9TV1lFK0wyRUE0VXc4NkMrWUIyRWNwRGVvdE9MWWEvVlNC?=
 =?utf-8?B?Z0V5NEpId2Q1UmRjdk5Cd0ZNVFNpK2tqVjhST1Zxa2JDNDZnanQ0M0VNalZE?=
 =?utf-8?B?d2pBaXYveUdaSkR2MFl6eUd2cVh5c2xwQ1RTb1UrOC9Kd3BDbW00MmNnQWVR?=
 =?utf-8?B?SCsvOWZwUkdpRXRkSkFITC9XQlB6dHVPZmVmc1RUNDhUYVZxTzNRcTE4Y01j?=
 =?utf-8?B?LzZXY2J0QVM4eWZxdHE1dEovaFpULzBWbHpIRkV0MCsvSFUycGVsNVpHUXVE?=
 =?utf-8?B?ckl1amxvTmx2dzVzdVlBa0dZaFZtc0laeDlCam94ZmRCM1NwL2Y5RGk4R0ZV?=
 =?utf-8?B?QUd3RlhUWU1jS2lRV2h3OTBMWlVsOGJPOCtEbzA1SSsxSTZyeHVETUd0alF1?=
 =?utf-8?B?ZkpXbnVnUU02cFZlWWdFYkJsZkhJYmpJcjZBOGtsYTdITmlKSDk5Vm8rRGYz?=
 =?utf-8?B?M2pRU2JOQ3FJTWVvL0VIaTREdm9xS0VCM1FwRk9DTTVOVTduVzgxTjhhSkZQ?=
 =?utf-8?B?U3VhR2lPbW8rcDhuMVY5WXhoUklFVmZnNGhBS3JOS3BPVlE2dVBnS2NkUG1N?=
 =?utf-8?B?enJhU004SC9TTnhNUGtEMmRPcVJOa1lXUWs1NVhrRnhqVVlvSkpLVUJQNlg0?=
 =?utf-8?B?VDhNamZZY29sVlJKT3dObUpIcGFQQ011YnNtbml4TzhmZVRnSVM2SlBaK1pt?=
 =?utf-8?B?bDZPOFBNOGNNcXZMMGJ5RjZ3NzRwVEd3ZXNpNEpIR0d2aVY2Yy8rL3BrNitZ?=
 =?utf-8?B?ak51Y0x0bEtWcE9PZ094N3J1SXJyblpkTldJTFFkREJUa2ZhMDZBQlM1T1RT?=
 =?utf-8?B?Z2hMWmRXVjNRdERYeFRRZzIyY3pmVkFtelRyTEMvZlVDUVU1WFVjYWh3S01J?=
 =?utf-8?B?UU5seDVjOFl3cktmc0U5aDdoL3FBbG52MEhoVTMxZkJsTjR3Z2tqQTJ4azFZ?=
 =?utf-8?B?MlR3VjdFRTZEUUJMOWs2aXk2NzVzSVJSUEUzektoV1dSbUo1QmM1bUU4VzI4?=
 =?utf-8?B?NDdGUldFaWZIU3lhZk1LaHp5aW5KZGE4WXlib09QcVlpcGtSOTFvOUFlNThH?=
 =?utf-8?B?MjlzY3lIR1dYMC9QTDlFRGlHVU1DNGlHL1A5aEVNdkV5NS9UM1RjQ3Rub2t5?=
 =?utf-8?B?aGY1aStYd3hQZmhKMW0vTXJYY0RNNG05dmpsYU50Z2J1OU5ZWWgvNTZHTG0x?=
 =?utf-8?B?eXU0Ky8wY3FyUW93c1pPcWRtdXYwaDZvN21yd09qNTUySGdPdFlYSGFKdFFF?=
 =?utf-8?B?Z2lVR1VibldUS0UvZlZkMG0wYjFRd2RuOS9iZmtQb2RRSTlvR0RSODRocmZi?=
 =?utf-8?B?TUlwM1hMdVBwQzB2dzdBV2ZzWkppc2hJSWUvVzlMazhFb2wvMmoyVDZreXJj?=
 =?utf-8?B?elIzdWwwQ2E0NjNUb0F1bURBb1VCcXJqQWtRZkQ1MUl6UE9sQlAyN2VVMk9I?=
 =?utf-8?B?WFY4RnBIbjNLZnBUZ3JTOG5yTW0veDloMkdBR3hmV3Z1cWhITndZazVQK3ZB?=
 =?utf-8?B?Mi9GQk15UlR6b2Z0eDNYaFlsTFlWTmFHUG8vUU95VC9aR2UvTmVEdFpsdVNV?=
 =?utf-8?B?S2VZVVp2ZGFxWnpwZVpWZmV2dHM3VmpCd00zVGdiK1RFalpFQkZFUWNQOVlL?=
 =?utf-8?B?VG42TWlMMU91cXFJTDE3VTZES0ZDNnkyVEFZaEZkV0FUbmVyME9pbGN3RVlm?=
 =?utf-8?B?MDFoQVFLUUJ1cEMycDdDY0hNNUdOTVcyTzVkWnU4cjVvaCtyK3BNb1MwMTF1?=
 =?utf-8?B?dnRGYUFUMDBMNmZtUUdyQkMvWGNucEFIK0RiN0srUVNuTHFMT01kMGFZMzZE?=
 =?utf-8?B?MUdBUlh4L0RzZS93dmZ0R0IwT1Bna09ZazYzVFYweVpNVHM2eGExWlF1QlhD?=
 =?utf-8?Q?YyCicV+jk1AC5ZTJESRZe1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03d7af7-462f-4e8e-859a-08d9d4e40def
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:23:40.4193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLyvnZx4W9KADzDUJIOdhYXqTtbxpKpOsfJORI4lj30IMBTd2R6z3zixBMGwC9PMtbk209RVHbqEG3tgu1AA1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3703
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110053
X-Proofpoint-GUID: 1OfuKgjJQufsP-ZBU0QlK6MngNtqWVMH
X-Proofpoint-ORIG-GUID: 1OfuKgjJQufsP-ZBU0QlK6MngNtqWVMH
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

CgpPbiAxLzEwLzIwMjIgODo0NiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUdWUsIEphbiAx
MSwgMjAyMiBhdCA5OjMwIEFNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3Jv
dGU6Cj4+Cj4+Cj4+IE9uIDEvOS8yMDIyIDEwOjA1IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4g
5ZyoIDIwMjIvMS84IOS4iuWNiDk6MjMsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pj4+Cj4+Pj4gT24g
MS82LzIwMjIgOTowOCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4g5ZyoIDIwMjIvMS83IOS4
iuWNiDg6MzMsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pj4+Pj4KPj4+Pj4+IE9uIDEvNS8yMDIyIDM6
NDYgQU0sIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4+PiBBZGQgd3JhcHBlcnMgdG8gZ2V0L3NldCBz
dGF0dXMgYW5kIHByb3RlY3QgdGhlc2Ugb3BlcmF0aW9ucyB3aXRoCj4+Pj4+Pj4gY2ZfbXV0ZXgg
dG8gc2VyaWFsaXplIHRoZXNlIG9wZXJhdGlvbnMgd2l0aCByZXNwZWN0IHRvIGdldC9zZXQgY29u
ZmlnCj4+Pj4+Pj4gb3BlcmF0aW9ucy4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVs
aSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+ICAgIGRyaXZlcnMv
dmRwYS92ZHBhLmMgICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4+Pj4+Pj4gICAg
ZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAgICB8ICA3ICsrKy0tLS0KPj4+Pj4+PiAgICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgIDMgKy0tCj4+Pj4+Pj4gICAgaW5jbHVkZS9saW51
eC92ZHBhLmggICAgICAgICB8ICAzICsrKwo+Pj4+Pj4+ICAgIDQgZmlsZXMgY2hhbmdlZCwgMjYg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+IGluZGV4
IDQyZDcxZDYwZDVkYy4uNTEzNGM4M2M0YTIyIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMv
dmRwYS92ZHBhLmMKPj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4+Pj4gQEAg
LTIxLDYgKzIxLDI1IEBAIHN0YXRpYyBMSVNUX0hFQUQobWRldl9oZWFkKTsKPj4+Pj4+PiAgICBz
dGF0aWMgREVGSU5FX01VVEVYKHZkcGFfZGV2X211dGV4KTsKPj4+Pj4+PiAgICBzdGF0aWMgREVG
SU5FX0lEQSh2ZHBhX2luZGV4X2lkYSk7Cj4+Pj4+Pj4gICAgK3U4IHZkcGFfZ2V0X3N0YXR1cyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArICAgIHU4IHN0YXR1
czsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgICBtdXRleF9sb2NrKCZ2ZGV2LT5jZl9tdXRleCk7Cj4+
Pj4+Pj4gKyAgICBzdGF0dXMgPSB2ZGV2LT5jb25maWctPmdldF9zdGF0dXModmRldik7Cj4+Pj4+
Pj4gKyAgICBtdXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4KTsKPj4+Pj4+PiArICAgIHJldHVy
biBzdGF0dXM7Cj4+Pj4+Pj4gK30KPj4+Pj4+PiArRVhQT1JUX1NZTUJPTCh2ZHBhX2dldF9zdGF0
dXMpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArdm9pZCB2ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArICAgIG11dGV4X2xv
Y2soJnZkZXYtPmNmX211dGV4KTsKPj4+Pj4+PiArICAgIHZkZXYtPmNvbmZpZy0+c2V0X3N0YXR1
cyh2ZGV2LCBzdGF0dXMpOwo+Pj4+Pj4+ICsgICAgbXV0ZXhfdW5sb2NrKCZ2ZGV2LT5jZl9tdXRl
eCk7Cj4+Pj4+Pj4gK30KPj4+Pj4+PiArRVhQT1JUX1NZTUJPTCh2ZHBhX3NldF9zdGF0dXMpOwo+
Pj4+Pj4+ICsKPj4+Pj4+PiAgICBzdGF0aWMgc3RydWN0IGdlbmxfZmFtaWx5IHZkcGFfbmxfZmFt
aWx5Owo+Pj4+Pj4+ICAgICAgc3RhdGljIGludCB2ZHBhX2Rldl9wcm9iZShzdHJ1Y3QgZGV2aWNl
ICpkKQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4+Pj4+Pj4gaW5kZXggZWJhYTM3M2U5YjgyLi5kOWQ0OTk0NjVlMmUgMTAw
NjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+Pj4+PiArKysgYi9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+Pj4+IEBAIC0xNDIsMTAgKzE0Miw5IEBAIHN0YXRpYyBsb25n
IHZob3N0X3ZkcGFfZ2V0X2RldmljZV9pZChzdHJ1Y3QKPj4+Pj4+PiB2aG9zdF92ZHBhICp2LCB1
OCBfX3VzZXIgKmFyZ3ApCj4+Pj4+Pj4gICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfc3Rh
dHVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1OAo+Pj4+Pj4+IF9fdXNlciAqc3RhdHVzcCkKPj4+
Pj4+PiAgICB7Cj4+Pj4+Pj4gICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZk
cGE7Cj4+Pj4+Pj4gLSAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBh
LT5jb25maWc7Cj4+Pj4+Pj4gICAgICAgIHU4IHN0YXR1czsKPj4+Pj4+PiAgICAtICAgIHN0YXR1
cyA9IG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKTsKPj4+Pj4+PiArICAgIHN0YXR1cyA9IHZkcGFfZ2V0
X3N0YXR1cyh2ZHBhKTsKPj4+Pj4+IE5vdCBzdXJlIHdoeSB3ZSBuZWVkIHRvIHRha2UgY2ZfbXV0
ZXggaGVyZS4gQXBwZWFycyB0byBtZSBvbmx5Cj4+Pj4+PiBzZXR0ZXJzIChzZXRfc3RhdHVzIGFu
ZCByZXNldCkgbmVlZCB0byB0YWtlIHRoZSBsb2NrIGluIHRoaXMgZnVuY3Rpb24uCj4+Pj4+Cj4+
Pj4+IFlvdSBtYXkgYmUgcmlnaHQgYnV0IGl0IGRvZXNuJ3QgaGFybSBhbmQgaXQgaXMgZ3VhcmFu
dGVlZCB0byBiZQo+Pj4+PiBjb3JyZWN0IGlmIHdlIHByb3RlY3QgaXQgd2l0aCBtdXRleCBoZXJl
Lgo+Pj4+IElzIGl0IG1vcmUgZm9yIGZ1dHVyZSBwcm9vZj8KPj4+Cj4+PiBJIHRoaW5rIHNvLgo+
PiBJIGd1ZXNzIGluIHRoaXMgc2l0dWF0aW9uIGl0IHdvdWxkIGJlIGJldHRlciBkZWZlciB0byB0
aGUgZnV0dXJlIHBhdGNoCj4+IHRvIGFkZCBzdWNoIGxvY2tpbmcgb3Igd3JhcHBlciwgYWx0aG91
Z2ggcmlnaHQgbm93IHRoZXJlIGFyZSBqdXN0IHR3bwo+PiBhZGRpdGlvbmFsIGNhbGxzIHRha2lu
ZyB0aGUgbG9jayBuZWVkbGVzc2x5IHdoZW4gdmhvc3RfdmRwYV9nZXRfc3RhdHVzCj4+IGlzIGNh
bGxlZC4gTWF5YmUgaXQncyBqdXN0IG1lIGJ1dCBJJ20gd29ycmllZCBzb21lIGZ1dHVyZSBwYXRj
aCBtYXkKPj4gY2FsbHMgdGhlIGxvY2tlZCBBUEkgd3JhcHBlciB0aG91c2FuZHMgb2YgdGltZXMg
dW5pbnRlbmRlZGx5LCB0aGVuIHRoZQo+PiBvdmVyaGVhZCBiZWNvbWVzIHF1aXRlIG9idmlvdXMu
Cj4gSSdtIGZpbmUgdG8gcmVtb3ZlIHRoaXMgaWYgb3RoZXJzIGFncmVlIG9uIHRoaXMuCkl0IGxv
b2tzIFBhcmF2IGFja2VkIG9uIHRoaXMuIEFueW9uZSBlbHNlPwo+Cj4+Pgo+Pj4+IE9rLCBidXQg
SU1ITyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gZ2V0IHNvbWUgY29tbWVudCBoZXJlLCBvdGhlcndp
c2UKPj4+PiBpdCdzIHF1aXRlIGNvbmZ1c2luZyB3aHkgdGhlIGxvY2sgbmVlZHMgdG8gYmUgaGVs
ZC4gdmhvc3RfdmRwYSBoYWQKPj4+PiBkb25lIGl0cyBvd24gc2VyaWFsaXphdGlvbiBpbiB2aG9z
dF92ZHBhX3VubG9ja2VkX2lvY3RsKCkgdGhyb3VnaAo+Pj4+IHZob3N0X2RldmBtdXRleC4KPj4+
Cj4+PiBSaWdodCwgYnV0IHRoZXkgYXJlIGRvbmUgZm9yIGRpZmZlcmVudCBsZXZlbHMsIG9uZSBp
cyBmb3Igdmhvc3RfZGV2Cj4+PiBhbnRvaGVyIGlzIGZvciB2ZHBhX2Rldi4KPj4gVGhlIGNmX211
dGV4IGlzIGludHJvZHVjZWQgdG8gc2VyaWFsaXplIHRoZSBjb21tYW5kIGxpbmUgY29uZmlndXJl
Cj4+IHRocmVhZCAodmlhIG5ldGxpbmspIGFuZCB0aGUgdXBzdHJlYW0gZHJpdmVyIGNhbGxzIGZy
b20gZWl0aGVyIHRoZQo+PiB2aG9zdF9kZXYgb3IgdmlydGlvX2Rldi4gSSBkb24ndCBzZWUgYSBj
YXNlLCBldmVuIGluIGZ1dHVyZSwgd2hlcmUgdGhlCj4+IG5ldGxpbmsgdGhyZWFkIG5lZWRzIHRv
IHVwZGF0ZSB0aGUgdmlydGlvIHN0YXR1cyBvbiB0aGUgZmx5LiBDYW4geW91Cj4+IGVubGlnaHRl
biBtZSB3aHkgdGhhdCBpcyBhdCBhbGwgcG9zc2libGU/Cj4gQWZ0ZXIgc29tZSB0aG91Z2h0IEkg
ZG9uJ3Qgc2VlIGEgY2FzZS4gSSBjYW4gdGhpbmsgb2YgTkVFRFNfUkVTRVQgYnV0Cj4gaXQgc2hv
dWxkIGNvbWUgd2l0aCBhIGNvbmZpZyBpbnRlcnJ1cHQgc28gd2UncmUgcHJvYmFibHkgZmluZSB3
aXRob3V0Cj4gdGhlIG11dGV4IGhlcmUuClRydWUsIGl0J3MgcXVpdGUgdW5saWtlbHkgZm9yIG5l
dGxpbmsgdG8gYWx0ZXIgdGhlIHN0YXR1cyBkaXJlY3RseSB3aGlsZSAKZHJpdmVyIGlzIHJ1bm5p
bmcuIE1vcmUgbGlrZWx5IHRoZSBvdXQgb2YgYmFuZCByZXNldCBoYXMgdG8gcmVhY2ggdGhlIApn
dWVzdCBkcml2ZXIgZmlyc3QgZm9yIGl0IHRvIGJlIGF3YXJlLCB3aGljaCB3b3VsZCB0aGVuIGlu
aXRpYXRlIHRoZSAKdmhvc3QgY2FsbCBkb3duIHRvIHZob3N0LXZkcGEgdGhyb3VnaCB0aGUgc2Ft
ZSBwYXRoLgoKLVNpd2VpCj4KPiBUaGFua3MKPgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pj4gVGhh
bmtzCj4+Pgo+Pj4KPj4+PiAtU2l3ZWkKPj4+Pgo+Pj4+PiBUaGFua3MKPj4+Pj4KPj4+Pj4KPj4+
Pj4+PiAgICAgICAgICBpZiAoY29weV90b191c2VyKHN0YXR1c3AsICZzdGF0dXMsIHNpemVvZihz
dGF0dXMpKSkKPj4+Pj4+PiAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+Pj4+Pj4+IEBAIC0x
NjQsNyArMTYzLDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdAo+
Pj4+Pj4+IHZob3N0X3ZkcGEgKnYsIHU4IF9fdXNlciAqc3RhdHVzcCkKPj4+Pj4+PiAgICAgICAg
aWYgKGNvcHlfZnJvbV91c2VyKCZzdGF0dXMsIHN0YXR1c3AsIHNpemVvZihzdGF0dXMpKSkKPj4+
Pj4+PiAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+Pj4+Pj4+ICAgIC0gICAgc3RhdHVzX29s
ZCA9IG9wcy0+Z2V0X3N0YXR1cyh2ZHBhKTsKPj4+Pj4+PiArICAgIHN0YXR1c19vbGQgPSB2ZHBh
X2dldF9zdGF0dXModmRwYSk7Cj4+Pj4+PiBEaXR0by4KPj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICAg
LyoKPj4+Pj4+PiAgICAgICAgICogVXNlcnNwYWNlIHNob3VsZG4ndCByZW1vdmUgc3RhdHVzIGJp
dHMgdW5sZXNzIHJlc2V0IHRoZQo+Pj4+Pj4+IEBAIC0xODIsNyArMTgxLDcgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdAo+Pj4+Pj4+IHZob3N0X3ZkcGEgKnYsIHU4
IF9fdXNlciAqc3RhdHVzcCkKPj4+Pj4+PiAgICAgICAgICAgIGlmIChyZXQpCj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsKPj4+Pj4+PiAgICAgICAgfSBlbHNlCj4+Pj4+Pj4gLSAg
ICAgICAgb3BzLT5zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+Pj4+Pj4gKyAgICAgICAgdmRw
YV9zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+Pj4+PiBUaGUgcmVzZXQoKSBjYWxsIGluIHRo
ZSBpZiBicmFuY2ggYWJvdmUgbmVlZHMgdG8gdGFrZSB0aGUgY2ZfbXV0ZXgsCj4+Pj4+PiB0aGUg
c2FtZSB3YXkgYXMgdGhhdCBmb3Igc2V0X3N0YXR1cygpLiBUaGUgcmVzZXQoKSBpcyBlZmZlY3Rp
dmVseQo+Pj4+Pj4gc2V0X3N0YXR1cyh2ZHBhLCAwKS4KPj4+Pj4+Cj4+Pj4+PiBUaGFua3MsCj4+
Pj4+PiAtU2l3ZWkKPj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICAgaWYgKChzdGF0dXMgJiBWSVJUSU9f
Q09ORklHX1NfRFJJVkVSX09LKSAmJiAhKHN0YXR1c19vbGQgJgo+Pj4+Pj4+IFZJUlRJT19DT05G
SUdfU19EUklWRVJfT0spKQo+Pj4+Pj4+ICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG52cXM7
IGkrKykKPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+
Pj4+Pj4+IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+Pj4+Pj4+IGluZGV4IGE4NGIw
NGJhMzE5NS4uNzY1MDQ1NTliYzI1IDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb192ZHBhLmMKPj4+Pj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5j
Cj4+Pj4+Pj4gQEAgLTkxLDkgKzkxLDggQEAgc3RhdGljIHU4IHZpcnRpb192ZHBhX2dldF9zdGF0
dXMoc3RydWN0Cj4+Pj4+Pj4gdmlydGlvX2RldmljZSAqdmRldikKPj4+Pj4+PiAgICBzdGF0aWMg
dm9pZCB2aXJ0aW9fdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+
Pj4+Pj4+IHU4IHN0YXR1cykKPj4+Pj4+PiAgICB7Cj4+Pj4+Pj4gICAgICAgIHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZkZXYpOwo+Pj4+Pj4+IC0gICAgY29uc3Qgc3Ry
dWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+Pj4+Pj4+ICAgIC0gICAg
cmV0dXJuIG9wcy0+c2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+Pj4+Pj4+ICsgICAgcmV0dXJu
IHZkcGFfc2V0X3N0YXR1cyh2ZHBhLCBzdGF0dXMpOwo+Pj4+Pj4+ICAgIH0KPj4+Pj4+PiAgICAg
IHN0YXRpYyB2b2lkIHZpcnRpb192ZHBhX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGlu
dXgvdmRwYS5oCj4+Pj4+Pj4gaW5kZXggOWNjNDI5MWE3OWIzLi5hZTA0N2ZhZTI2MDMgMTAwNjQ0
Cj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+Pj4+PiArKysgYi9pbmNsdWRl
L2xpbnV4L3ZkcGEuaAo+Pj4+Pj4+IEBAIC00MDgsNiArNDA4LDkgQEAgdm9pZCB2ZHBhX2dldF9j
b25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+Pj4+Pj4+IHVuc2lnbmVkIGludCBvZmZz
ZXQsCj4+Pj4+Pj4gICAgICAgICAgICAgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbik7
Cj4+Pj4+Pj4gICAgdm9pZCB2ZHBhX3NldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICpkZXYs
IHVuc2lnbmVkIGludCBvZmZzZXQsCj4+Pj4+Pj4gICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQg
KmJ1ZiwgdW5zaWduZWQgaW50IGxlbmd0aCk7Cj4+Pj4+Pj4gK3U4IHZkcGFfZ2V0X3N0YXR1cyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+Pj4+Pj4+ICt2b2lkIHZkcGFfc2V0X3N0YXR1cyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cyk7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICAg
IC8qKgo+Pj4+Pj4+ICAgICAqIHN0cnVjdCB2ZHBhX21nbXRkZXZfb3BzIC0gdmRwYSBkZXZpY2Ug
b3BzCj4+Pj4+Pj4gICAgICogQGRldl9hZGQ6IEFkZCBhIHZkcGEgZGV2aWNlIHVzaW5nIGFsbG9j
IGFuZCByZWdpc3RlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
