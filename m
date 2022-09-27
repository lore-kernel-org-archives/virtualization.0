Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE9C32771
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 01:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E03B404C8;
	Tue, 27 Sep 2022 01:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E03B404C8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=svwp+Z/3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0EXIG3mP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5osQV6ZUF9f; Tue, 27 Sep 2022 01:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 48E6C400D2;
	Tue, 27 Sep 2022 01:02:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48E6C400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C87EC0032;
	Tue, 27 Sep 2022 01:02:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C2EBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 01:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08DB360E03
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 01:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08DB360E03
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=svwp+Z/3; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=0EXIG3mP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pzORnDpqKOP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 01:02:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 166D360DFE
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 166D360DFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 01:02:25 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QNxBlu022392;
 Tue, 27 Sep 2022 01:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8RJoZuAnuiea3H4XW8ECMRhLfLe9PowwlmpZJlGVo4U=;
 b=svwp+Z/3/A4VZ+s3bipHdVT81Vc/WMsW3EtDn6mtPsvoWEEniz4lBBMvyaUzzK4ItZlI
 A/PkkMv/OdUuQrWdlhmZgZLjdsEturHH/6odeKaV3HU6QdmfujjVHcMCOHIi2w4xyOiH
 R7j8hpAkOrS6VT9dKwajeehe2hdGR0V3xwY8JY5ZuqEvsVXPMd/zDVOhqRbz3KAdArZq
 mfBNc7pgyl0FC7j79deaTL8ZnmxRplcdwflZtt8CHVewgVIuwOddT9dU/DQ3TnGPr00X
 1y08llX/3XvpYsouvg/m18gUsbgED/FNVTkDCfLS9i/DS7+Fs732p+SGJVDJLfyXEtQk LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst13d6ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Sep 2022 01:01:50 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 28QNtWFq019839; Tue, 27 Sep 2022 01:01:50 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3jtpvdrtc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Sep 2022 01:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWoWK5aOs39mmJaI45tTYEm82/ezM7ls2BADCXHRdnBRd+6DIqwo8X7INQ2F3kKFIIHghpUOSWFnj1mhRdbmfYp8/36Zq12upg3XHQRB09Ptfst6K+EG1GzOM3PDDeSzRTdK3YbW2uQ0wAFhOQBuMtSHH7XfnveXpfRbM0zWU37gqGOyzS3hChadjrcBQPF/Q8sHQOyrECvzc62D768yqYf6BkaYFU3V8CnmXNhHi5xKQMo5Z9FKvuPkXPywhdzBAnBZIyXWZNw2VwsxErj6rDm5fNOFCaKNvqqc/0rF679g6SA8MyAWeJu4dQA8yTr3duKrU35Zye5ZTpqHVBL8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RJoZuAnuiea3H4XW8ECMRhLfLe9PowwlmpZJlGVo4U=;
 b=RWfFRSXw2JjOUllrKcWw6QBKPthT8ZtDkwCsYNI6wcK71rHNO8LHmED0XWO8su08iXFfvoB7VtUTv1w3LuTNY2rBraHyfPrL9VI+tFYt2KNPoxcIgviDvrnzIQLvN/VLRlanoqOlXk7LyPjEeh8ELNtNhzzOt86D0koMoWzjegU0tv1q2ynnFoPJpO8akCbC+xF67dzGgDerN2WtPyAN6lBF/HTh5X1qrGAWEbncJB16KL0pGKAFfdiOO65sr2mja0XXX/APJB02T2SKHzi7t3ZmC2rD2DiqnOI7imJxDCdU4nI1KgYB9ovonNm8M/sxI/rh02VD6Qp0U8+Q034sVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RJoZuAnuiea3H4XW8ECMRhLfLe9PowwlmpZJlGVo4U=;
 b=0EXIG3mPFV1bRUj6gpk1EG9QJmKepY1d61wU9HZA/8MG6g6ge9V1D9SKtpyEBkQzWGQHDB0RpypK3VQ6l7Uzvg8CNFzuJ5fYF+dO59Njx6CvncYn/kswfXA5k25tPjvgKYkTaPAqI6nog+V9C2jWp0MULOcEcFQ7LCJO4SQI8qA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 01:01:47 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13%8]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 01:01:47 +0000
Message-ID: <afe960d3-730a-b52c-e084-40bf080b27fa@oracle.com>
Date: Mon, 26 Sep 2022 18:01:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <a1e98754-114e-b401-e927-5f2b71c3c641@oracle.com>
 <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:806:126::19) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ebc12a-0f46-4645-a64b-08daa023da57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2lQFs2Q0Ipmwrm8hCzvKnWLk50dqWKfwBcHavytitGgTx0B++07AaWI3qFXrUq1c5zdhSvI6lHC2gukyQANpxfYExHFHM48cRgh8AqxqrsuCtrb9RlCFFkj/8yxW8hosTyuc3QzGJTAVMxeI+vvSxvvF/rN+5z8EzeaQCWds5H86b4oU1MVJ7OhZ3FuMq+jehSvQzE8S0Ms/5C7eauVvkjiw11K1rSl6HgiDkLtZBvtgEYeVlgZyPVNbu33v+06ugKbq8uVJSWoTlXAoofaK/BrGgpCrCTcOnaa0/6hNtnQ3r+cpAaigu5uNKAXwKRFkFb3ugfXeSIJEqoOIX8aFwUb/BRp7lcOKBztzUEvcMDX38W0OqFLqxsBiYJt5w4YnrogIgq9K1tKMnW+/bbko3iagSN0nvqX5Ch94vGRdNFhWHdw6ifjINKVq0crQm8OeMwozAtQP6v/PPw4s9L33uW1qlknQHfQVxSbiUEaaOBHtdLsa+ida4YPaejjvVfQNhQb+xRBdfDHI+CyMg5m2BlHj1cqflFp7qhPfqfGzRO6QY9AjLS+M13eigj3d9dx3Ybg0Z5RqQrMZI4PEGVjTkMDuQh6H7l+WKgl6JYxDK3yvyuIW/FFaY0J1v9LpPk+v3a2WS6f8EeHu4Qzk/QIS49nT4W1rjPag2Rb0aVjEQGHCADtm70GLLxe8gjvViiafqJlxuKBWrCutfe7gGyxbERjEvgSoAuxK6Lyzf2GZ3xuLUJRK6YWlScMuSz68lMksyQacId1EJF+H/Yl02o3aOug2XZDmFNPepaKB8dy64s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(5660300002)(66556008)(8936002)(30864003)(31696002)(7416002)(86362001)(2906002)(6666004)(26005)(6486002)(41300700001)(83380400001)(186003)(36916002)(6512007)(478600001)(53546011)(6916009)(4326008)(66946007)(6506007)(2616005)(66476007)(316002)(8676002)(33964004)(38100700002)(54906003)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3BwcEFpM1NRNmlSbHlodDZwaiszQVJ4TWJRekh6YnM1V0Z5czNDaHl5N0Ru?=
 =?utf-8?B?a2VpWmpPeFljbVdYQlpXN2QxKzl4Q3ovbTdvdWtUU0JyRmt2eklVN1B5eFU3?=
 =?utf-8?B?MGJoTFdYaFdKV3Z4MlhRVTVOT3o4N1pnNEJGUUY2ZU8wSWw0QnY5TzNnQTB3?=
 =?utf-8?B?ZEpMNFk2cXMwUndHZ04vTTRVOWRPOS9DN3lHeTFXZXJBempCRTNtRWRmbVlR?=
 =?utf-8?B?L2s2dklsNHJ4Ym5OeVpSMmkxS3d0eDZ6M0pwbEtqK2lwM1plYkZpcTYySG9r?=
 =?utf-8?B?eGt0NXM5ZVpoMW1NQ2N5Q0pkM0FVNXlmRDJZZTJkVFZHM1JsSVlaLzBXOVBG?=
 =?utf-8?B?b0VkcjdWbWZDNDNBR3Axa3I5Z0tpeFl2YUhHRUFmY3F2V3R1SnhlWDdHWjNt?=
 =?utf-8?B?V2JZSnAzcndkL0I2YVM2endESUo5WEF6eXR2OWE0S2JRelpTUFJ5UHVwTUJ1?=
 =?utf-8?B?cHg1WDBCU0lsVU1lMXFFV1Q3dVFiUHlEb3hydGNxdXlVR0ZrT0MrQW9RS1I1?=
 =?utf-8?B?T0M1N1ZodTloUDc3NDByMnQ5WDhuL21hQUY3UGJUMHEySlNKTDBFU3Bhc3F0?=
 =?utf-8?B?RlJteldKM3dyb3pzSDdCMUtHV3Axb0dVY0VkNVpSWGhINFJTbVJuNzNPSkJ5?=
 =?utf-8?B?MGhKRlJ1eC9CNHZHek9jakpvMDRmVVo4YUdleXpsemtTdzlzWXp5dTNOaHhF?=
 =?utf-8?B?cFJqemx5a0FYVmIySGUyOG5qVkNLcnpVNzRCbUFVZWRZODB4VVppbEo0cTdX?=
 =?utf-8?B?Z2MwUEx6NmIzTXMxVzgvaDQ4ejVjOXNaSXBZVm5SalZNcThHR0N1bmhEUWN1?=
 =?utf-8?B?WDJkSTUrYXd5Ulg3OGxlV3N2c0MyN0FhcVY4MmRFbDNRSy83eG5EalNCMEt2?=
 =?utf-8?B?aFdoMStIanpPSGN4Zm1qenppeEpHVysxUHVKSlIvclZhdHJ2NkpTQUpCQVFi?=
 =?utf-8?B?QnVjaW00bG1QclJZTU9JYzB6aHI0MFhNdThpVTJBVFdadWdQb0JsOGdMc3M3?=
 =?utf-8?B?SVh2bWNELzF0UEtHbnRVOGtmeGhTaTg0MnNmNmI4NlBVUTExOE1Dd3dxMFlP?=
 =?utf-8?B?RGdaYUZxRmFqcUo5Yk1rNWhjMW5hM1V5SDZDM1U1MmRSUk1BQndnWWNtWVEz?=
 =?utf-8?B?V053bFlqaldwV0lTM2g3Mmo4Uno0NFdpbDA5MXFvRzZ3cytMTlIrTHdsTW9T?=
 =?utf-8?B?bFJTUHIvd1cyUlZoN04rN2xCMithalEvUlM3Vkc1RmxQSWplR05LVjc1ZnZH?=
 =?utf-8?B?ai8yMXFqUnRVVGZ1Q2xOMThWWTZYMnJZcUNFTFMveTBWZTljV21hcC80ZDFr?=
 =?utf-8?B?ZzNxM2hySmdPODVXcXFYOTJmbG1DS2NvVUY4U0kra1hBVTdEdGRFMURsVith?=
 =?utf-8?B?Vk0xZ3VhNm85bXRVOXRYOTBMblR1Y3V5Z2FESGdQdkNnaW1uOWJXNHExWHIy?=
 =?utf-8?B?dUsrSE5uTCtpeG50clpEY2lWczdlbVpkVFQvZnZUYnoxQUNEd2xUNTRjRDdr?=
 =?utf-8?B?ajZ4VHdmRGhYMW1PbGJxVURlWGkzSzIxQkxKUjBrS0tXVFlXN29XNm5pU2lo?=
 =?utf-8?B?SnptQTY1UHRZTlUxcUJpWDBuTlc1cnJOTXB0SHh3UzRUSjNZUGRVekNQMjhU?=
 =?utf-8?B?aWlXMEZPWTJjN0Q5QUdEd3puODZFT3BGODV4Qis5Z3ZUOFZleGRxWlp4MjBF?=
 =?utf-8?B?Vzc3TlJIdnRZcUlGU0NCaVpxQVVMUTRHNm16WVNBL25MOGVHZzlacFFuUlBG?=
 =?utf-8?B?VFp2MzR3dm9GZnFwbkpKbk5oekJYZUtpb20yeVlrWTQzZm5CejJMaEdUZ0E4?=
 =?utf-8?B?bFJHbjlVWWRSQytBU1pPbUp2RmRTOVBTam9pMzIxU0hlNjhEa2lOKy9aSjhy?=
 =?utf-8?B?VnZFWEtqUHA0SGVpK2ZFK3JCQ1BFTG0wTFJmL2xUZVVoM0pXSXZYZ2VSQ3Ax?=
 =?utf-8?B?UkZOcVdwMTBYNXdHNWNmT1NFYU5Pa0cvblhNRFY2cjB0WmZSVXFFNzBpbi8y?=
 =?utf-8?B?amZOYlFqaDM1VGpCQ0hVTDZMWExyMUkwUGpDYkxsV2thcHEvYkdWc1UwRXJj?=
 =?utf-8?B?RWlaWTFHNGN2N1ZUVUtaNUtZdXZmN3NjdEFwclZ3UkMzY09Xd3EyRm1TblpD?=
 =?utf-8?Q?ZBH7lNniHc5qDr+b8SFWpo8Wn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ebc12a-0f46-4645-a64b-08daa023da57
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 01:01:47.5833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2WOZSEhr5Uwxe9odg69JGAJAyJTMnsKtP9NaA1gR6yKGYsU2WzNWxfScSlpHr9gd+vRE9pZJRu5nnFo2tUcBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_11,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270004
X-Proofpoint-ORIG-GUID: V9J_XL_vVa18OG8tJ-LXa2CuyhfGBYoT
X-Proofpoint-GUID: V9J_XL_vVa18OG8tJ-LXa2CuyhfGBYoT
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 Yongji Xie <xieyongji@bytedance.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Eli Cohen <elic@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============4216739266290709438=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4216739266290709438==
Content-Type: multipart/alternative;
 boundary="------------aKWTa2H2ZkvpRZ0R0EjUBTiU"
Content-Language: en-US

--------------aKWTa2H2ZkvpRZ0R0EjUBTiU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/26/2022 12:11 AM, Jason Wang wrote:
> On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu<si-wei.liu@oracle.com>  wrote:
>>
>>
>> On 9/21/2022 7:43 PM, Jason Wang wrote:
>>> This patch implements features provisioning for vdpa_sim_net.
>>>
>>> 1) validating the provisioned features to be a subset of the parent
>>>      features.
>>> 2) clearing the features that is not wanted by the userspace
>>>
>>> For example:
>>>
>>> # vdpa mgmtdev show
>>> vdpasim_net:
>>>     supported_classes net
>>>     max_supported_vqs 3
>>>     dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>> Sighs, not to blame any one and it's perhaps too late, but this
>> "dev_features" attr in "mgmtdev show" command output should have been
>> called "supported_features" in the first place.
> Not sure I get this, but I guess this is the negotiated features actually.
Actually no, that is why I said the name is a bit confusing and 
"supported_features" might sound better. This attribute in the parent 
device (mgmtdev) denotes the real device capability for what virtio 
features can be supported by the parent device. Any unprivileged user 
can check into this field to know parent device's capability without 
having to create a child vDPA device at all. The features that child 
vDPA device may support should be a subset of, or at most up to what the 
parent device offers. For e.g. the vdpa device dev1 you created below 
can expose less or equal device_features bit than 0x308820028 (MTU MAC 
CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but 
shouldn't be no more than what the parent device can actually support.

>
> I think Ling Shan is working on reporting both negotiated features
> with the device features.
Does it imply this series is connected to another work in parallel? Is 
it possible to add a reference in the cover letter?

>
>>> 1) provision vDPA device with all features that are supported by the
>>>      net simulator
>>>
>>> # vdpa dev add name dev1 mgmtdev vdpasim_net
>>> # vdpa dev config show
>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>     negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>> Maybe not in this patch, but for completeness for the whole series,
>> could we also add device_features to the output?
> Lingshan, could you please share your thoughts or patch on this?
Noted here the device_features argument specified during vdpa creation 
is introduced by this series itself, it somehow slightly changed the 
original semantics of what device_features used to be.

>
>> When simply look at the "vdpa dev config show" output, I cannot really
>> tell the actual device_features that was used in vdpa creation. For e.g.
>> there is a missing feature ANY_LAYOUT from negotiated_features compared
>> with supported_features in mgmtdev, but the orchestration software
>> couldn't tell if the vdpa device on destination host should be created
>> with or without the ANY_LAYOUT feature.
> I think VERSION_1 implies ANY_LAYOUT.
Right, ANY_LAYOUT is a bad example. A good example might be that, I knew 
the parent mgmtdev on migration source node supports CTRL_MAC_ADDR, but 
I don't find it in negotiated_features. On the migration destination 
node, the parent device does support all features as the source offers, 
including CTRL_MAC_ADDR. What device features you would expect the mgmt 
software to create destination vdpa device with, if not otherwise 
*requiring mgmt software to remember all the arguments on device creation*?

SOURCE# vdpa mgmtdev show
vdpasim_net:
    supported_classes net
    max_supported_vqs 3
    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
ACCESS_PLATFORM
SOURCE# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
    negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM

DESTINATION# vdpa mgmtdev show
vdpasim_net:
    supported_classes net
    max_supported_vqs 3
    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 
ACCESS_PLATFORM

>   But it should be sufficient to
> use features_src & feature_dst in this case. Actually, it should work
> similar as to the cpu flags, the management software should introduce
> the concept of cluster which means the maximal set of common features
> is calculated and provisioned during device creation to allow
> migration among the nodes inside the cluster.
Yes, this is one way mgmt software may implement, but I am not sure if 
it's the only way. For e.g. for cpu flags, mgmt software can infer the 
guest cpus features in use from all qemu command line arguments and host 
cpu features/capability, which doesn't need to remember creation 
arguments and is easy to recover from failure without having to make the 
VM config persistent in data store. I thought it would be great if vdpa 
CLI design could offer the same.

Thanks,
-Siwei

>
> Thanks
>
>> Thanks,
>> -Siwei
>>
>>
>>> 2) provision vDPA device with a subset of the features
>>>
>>> # vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
>>> # vdpa dev config show
>>> dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>>>     negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>>>
>>> Reviewed-by: Eli Cohen<elic@nvidia.com>
>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>> ---
>>>    drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> index 886449e88502..a9ba02be378b 100644
>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>>        dev_attr.work_fn = vdpasim_net_work;
>>>        dev_attr.buffer_size = PAGE_SIZE;
>>>
>>> +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>>> +             if (config->device_features &
>>> +                 ~dev_attr.supported_features)
>>> +                     return -EINVAL;
>>> +             dev_attr.supported_features &=
>>> +                      config->device_features;
>>> +     }
>>> +
>>>        simdev = vdpasim_create(&dev_attr);
>>>        if (IS_ERR(simdev))
>>>                return PTR_ERR(simdev);
>>> @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>>>        .id_table = id_table,
>>>        .ops = &vdpasim_net_mgmtdev_ops,
>>>        .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>>> -                          1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>>> +                          1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>>> +                          1 << VDPA_ATTR_DEV_FEATURES),
>>>        .max_supported_vqs = VDPASIM_NET_VQ_NUM,
>>>        .supported_features = VDPASIM_NET_FEATURES,
>>>    };

--------------aKWTa2H2ZkvpRZ0R0EjUBTiU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 9/26/2022 12:11 AM, Jason Wang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Sat, Sep 24, 2022 at 4:01 AM Si-Wei Liu <a class="moz-txt-link-rfc2396E" href="mailto:si-wei.liu@oracle.com">&lt;si-wei.liu@oracle.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">


On 9/21/2022 7:43 PM, Jason Wang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">This patch implements features provisioning for vdpa_sim_net.

1) validating the provisioned features to be a subset of the parent
    features.
2) clearing the features that is not wanted by the userspace

For example:

# vdpa mgmtdev show
vdpasim_net:
   supported_classes net
   max_supported_vqs 3
   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Sighs, not to blame any one and it's perhaps too late, but this
&quot;dev_features&quot; attr in &quot;mgmtdev show&quot; command output should have been
called &quot;supported_features&quot; in the first place.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Not sure I get this, but I guess this is the negotiated features actually.</pre>
    </blockquote>
    Actually no, that is why I said the name is a bit confusing and
    &quot;supported_features&quot; might sound better. This attribute in the
    parent device (mgmtdev) denotes the real device capability for what
    virtio features can be supported by the parent device. Any
    unprivileged user can check into this field to know parent device's
    capability without having to create a child vDPA device at all. The
    features that child vDPA device may support should be a subset of,
    or at most up to what the parent device offers. For e.g. the vdpa
    device dev1 you created below can expose less or equal
    device_features bit than 0x308820028 (MTU MAC CTRL_VQ CTRL_MAC_ADDR
    ANY_LAYOUT VERSION_1 ACCESS_PLATFORM), but shouldn't be no more than
    what the parent device can actually support.<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

I think Ling Shan is working on reporting both negotiated features
with the device features.</pre>
    </blockquote>
    Does it imply this series is connected to another work in parallel?
    Is it possible to add a reference in the cover letter?<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
1) provision vDPA device with all features that are supported by the
    net simulator

# vdpa dev add name dev1 mgmtdev vdpasim_net
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Maybe not in this patch, but for completeness for the whole series,
could we also add device_features to the output?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Lingshan, could you please share your thoughts or patch on this?</pre>
    </blockquote>
    Noted here the device_features argument specified during vdpa
    creation is introduced by this series itself, it somehow slightly
    changed the original semantics of what device_features used to be. <br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
When simply look at the &quot;vdpa dev config show&quot; output, I cannot really
tell the actual device_features that was used in vdpa creation. For e.g.
there is a missing feature ANY_LAYOUT from negotiated_features compared
with supported_features in mgmtdev, but the orchestration software
couldn't tell if the vdpa device on destination host should be created
with or without the ANY_LAYOUT feature.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think VERSION_1 implies ANY_LAYOUT.</pre>
    </blockquote>
    Right, ANY_LAYOUT is a bad example. A good example might be that, I
    knew the parent mgmtdev on migration source node supports
    CTRL_MAC_ADDR, but I don't find it in negotiated_features. On the
    migration destination node, the parent device does support all
    features as the source offers, including CTRL_MAC_ADDR. What device
    features you would expect the mgmt software to create destination
    vdpa device with, if not otherwise <b>requiring mgmt software to
      remember all the arguments on device creation</b>?<br>
    <br>
    SOURCE# vdpa mgmtdev show<br>
    vdpasim_net:<br>
    &nbsp;&nbsp; supported_classes net<br>
    &nbsp;&nbsp; max_supported_vqs 3<br>
    &nbsp;&nbsp; dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1
    ACCESS_PLATFORM<br>
    SOURCE# vdpa dev config show<br>
    dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500<br>
    &nbsp;&nbsp; negotiated_features MTU MAC CTRL_VQ VERSION_1 ACCESS_PLATFORM<br>
    <br>
    DESTINATION# vdpa mgmtdev show<br>
    vdpasim_net:<br>
    &nbsp;&nbsp; supported_classes net<br>
    &nbsp;&nbsp; max_supported_vqs 3<br>
    &nbsp;&nbsp; dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1
    ACCESS_PLATFORM<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap=""> But it should be sufficient to
use features_src &amp; feature_dst in this case. Actually, it should work
similar as to the cpu flags, the management software should introduce
the concept of cluster which means the maximal set of common features
is calculated and provisioned during device creation to allow
migration among the nodes inside the cluster.</pre>
    </blockquote>
    Yes, this is one way mgmt software may implement, but I am not sure
    if it's the only way. For e.g. for cpu flags, mgmt software can
    infer the guest cpus features in use from all qemu command line
    arguments and host cpu features/capability, which doesn't need to
    remember creation arguments and is easy to recover from failure
    without having to make the VM config persistent in data store. I
    thought it would be great if vdpa CLI design could offer the same.<br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:CACGkMEu9JfBDP4VkK76jdAnH225yUfTF+xMnqmy7_yDW3P0rKA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Thanks,
-Siwei


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
2) provision vDPA device with a subset of the features

# vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
# vdpa dev config show
dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Reviewed-by: Eli Cohen <a class="moz-txt-link-rfc2396E" href="mailto:elic@nvidia.com">&lt;elic@nvidia.com&gt;</a>
Signed-off-by: Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a>
---
  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 886449e88502..a9ba02be378b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
      dev_attr.work_fn = vdpasim_net_work;
      dev_attr.buffer_size = PAGE_SIZE;

+     if (config-&gt;mask &amp; BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+             if (config-&gt;device_features &amp;
+                 ~dev_attr.supported_features)
+                     return -EINVAL;
+             dev_attr.supported_features &amp;=
+                      config-&gt;device_features;
+     }
+
      simdev = vdpasim_create(&amp;dev_attr);
      if (IS_ERR(simdev))
              return PTR_ERR(simdev);
@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
      .id_table = id_table,
      .ops = &amp;vdpasim_net_mgmtdev_ops,
      .config_attr_mask = (1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MACADDR |
-                          1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MTU),
+                          1 &lt;&lt; VDPA_ATTR_DEV_NET_CFG_MTU |
+                          1 &lt;&lt; VDPA_ATTR_DEV_FEATURES),
      .max_supported_vqs = VDPASIM_NET_VQ_NUM,
      .supported_features = VDPASIM_NET_FEATURES,
  };
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------aKWTa2H2ZkvpRZ0R0EjUBTiU--

--===============4216739266290709438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4216739266290709438==--
