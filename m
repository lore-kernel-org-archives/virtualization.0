Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA3EC61DA4
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 17:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 665E141608;
	Sat, 11 Mar 2023 17:49:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 665E141608
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=IzIXD3b6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yigyPTZ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vxVvcTTjemnL; Sat, 11 Mar 2023 17:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3FFD8405E7;
	Sat, 11 Mar 2023 17:49:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FFD8405E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA212C0071;
	Sat, 11 Mar 2023 17:49:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D91DFC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F5A54046D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:49:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F5A54046D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=IzIXD3b6; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=yigyPTZ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DbQweVP9_C6T
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:49:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F00C400C4
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F00C400C4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 17:49:31 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32BFrjAr008985; Sat, 11 Mar 2023 17:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YoJC9rRYcz+rMKHKOA6Ov3enU8+Cn+FNyLlkzj4Zzi0=;
 b=IzIXD3b6z1lwdmxIjJqRJ/EsYvSJVogdUCKzs12ibM19TGvLLWmUcsUYnG9ZZtQFSkQ0
 oQcK2vSISleJWKgO2sJud9/wIDt3vKIWqHDYrmonWBz+WDlREd46AdHZ+h6vL0JK45/7
 8TkR23iCBG0bH+FuHebKCCg+8J0yzXhILzki+uOxYux+tB7qAl1/LdUx0BISmlmyQNI/
 fZkqp1sPwqS4tinPkZFZ73zFnOsyQnR9R7iNXXW6rnPG7wQowvn/IXROJcggYHifV5mn
 vaIdi7W6Gn9fK+nhCJXVTzN/IG7ur+FlppdqUN5S+x2mShzNlObrlm6Cx1OMZulZeLT4 +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8g818nkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Mar 2023 17:49:24 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32BFvwkg033640; Sat, 11 Mar 2023 17:49:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3p8g32rkg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Mar 2023 17:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZAH4Acm+YPJq1Vn6rxv8WLa4tY9GDtxqQpjVuqH2rWVRwInSoqcqenf1TM838vs8gBZYgjzqh4EMP9JCcUf4dUmLEWrUb35UAJvTgEYadwK/jj7PzIWDb6WdzTMgtBX35+T23lKktMb70tW6L+4gtsdSb7YN4XM5CvNlXsdehfES+LDn+I91NMbuzilIh03ksUVVm/3x22sln8rq4c0CSrGGUJBW7l9WsQKKSsrAWJ5bFbZv0OuBvErA31YNROFH1c5giLhOSBLGEHVhnjynUqUht98sKPTcbWYsSONoX+xByjjoAOcmpesl+AFo3i1rJ80aB1pFlBtxxMaih7lTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoJC9rRYcz+rMKHKOA6Ov3enU8+Cn+FNyLlkzj4Zzi0=;
 b=WTreWcqDrrW4w5NkxgCXAm7tN2QaKxMOBqukTZ9DjiTEBIl8cA6beMizjU7mASezgl34g+AEeB0tILYXQLgKvVGtT0Ef40Qv0dPWMplIE51fCai4MbNBEeWwVzN2EJCvpZGO+zvTb76YyVXDQOx9jwS3H2QyHqMJOojonWbAhrU+BAPCv3nEMzk1ZxzvoT2JC88W2XYnLqW9Cozx8OBqdqbHjzUlslMiSZZ9tRIGpmggjCRowt0zCLL3turOEjG5VkdUz78h6NdJitl7aZOFcuQa1KMGuIspAD7nCwuNEiWX6tutP8N85HW2AuxXc8QGzqC+2bEs3auFNxNBumGkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoJC9rRYcz+rMKHKOA6Ov3enU8+Cn+FNyLlkzj4Zzi0=;
 b=yigyPTZ1JR3IUQ0tbeBNfL/qufltWNmKG9woPuiiTJ8WfmCXSq7bUFBtzLHenucpO8ed1i9Q2EMVvysDzU3LM5KwGNytXEJd3I3H5uAEwQeWpWGglV4hW/0REi/PlV5hTbC7sIFiaji4FaVEHJqLypdyCnKI/KBCyNwP9wmvTEk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Sat, 11 Mar
 2023 17:49:10 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.022; Sat, 11 Mar 2023
 17:49:10 +0000
Message-ID: <78a679b3-42f8-09b2-d465-1220a3e05d2f@oracle.com>
Date: Sat, 11 Mar 2023 11:49:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/11] Use copy_process in vhost layer
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CAHk-=wgenic8Ba1WxNP=9YJXk78k9Sg6R7RLkhduYjtVy2gdkg@mail.gmail.com>
X-ClientProxiedBy: DM6PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:5:40::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 731603a4-8035-4568-8e92-08db2258eb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBjkt7fho3m//D9DF+KZ6v+OfDlGEkJIcKuLMD1FbjQchwMBKOUM45SXlUX01b8pS80cmEVTB4hYayK++k6t/VACFfmZxfB409Q2uGtDoIl6hR3YLOHCBO2ZI6i2jPtVm5HoqZbIvdNWZy3Q0xWDy3zFN+1j57XwHVjT9YhFZqGmEM6w4ZLRr32fTfdikjNOJWZdHFKVJ3QyN+RhFPB16mUYQIq/3LE2D7JrdK+QehsJUK/eO7jgc/oA44uEplAOTJGwN/GDTNsx2u0jIDEkrDsl6gYUvIFhrSEIMFa7jRJYeTEH4g/YrGfkmyAWeXsTuGwTD1TWk4Sz8AZgY9iUJ45ZOYHqLa00ZmTvp9Tk+UFW6+Kw07ZP+BcYyQulCCaP9G21cbHcILcNJCV5od2WpfL+V6R3yFA9xvOqbCz9aP6ZoGApyAiabKd7U2NMDYrN+tTBytc3jpBGa3PjIReQt8AoAGphip1Vqa8ZBG1fq7Jy6OmCDXzt6RPio4w90WzZpnt8QCemH8VBPIPjGbb97SmizwcUPtPzGMTLgLTCsSvC46A4DacHF/lVn3xtvXKMzrjXduaska4+WEN3R3OhHLowQ1zHVZP18o16zAmI3IpvtA3WC8CTwbnpbLKxxZ/JX/XwFSHU0APGbBSxkfq2NI6qBEsBAq1yiQVNMPtocaE+gS4mgJC71Rp/xn7EJ3QOYJ00S1Vz59cDFawr2AIci3L7+Uf3hCugt6bkcox+IO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(36756003)(4326008)(8936002)(26005)(5660300002)(7416002)(8676002)(6512007)(41300700001)(6506007)(38100700002)(53546011)(6666004)(83380400001)(2616005)(186003)(86362001)(316002)(31696002)(66556008)(66476007)(6486002)(478600001)(6916009)(31686004)(66899018)(66946007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGRFS2E4ZFFWNUVOY2FWbGJGNHBJN1NTRlBmKzVjd04xK1RtMy9Jd2pOL0hV?=
 =?utf-8?B?L2liTExvN1JnY045Y1NRNHdGV0RIeE0yM2pMMnV4NDFyNW43bmlNMU8zcFQ0?=
 =?utf-8?B?MVptakpxZVJNN2pjMnVOdGdxMGxORUJxOEVBNTFUN0Vlc0JieDdRcGhPUmZj?=
 =?utf-8?B?ZXU0a0Vlc2c2VUJkSmVlMHRqQjJHS2FyWTZ1UEpHanAxSUpPRVpzejJsbHQ1?=
 =?utf-8?B?TzZlZWY3TTBaZmNqSXhLZUhWQnc4Sk1qcXVZZ3V2Q1JtYUlSTzRsTitRZjZm?=
 =?utf-8?B?MHVhc3pBL1RVWGt3cC8wWlFIQ2duT250NmF1ZlNrdFg4bmhVMU8wN0U0TzFQ?=
 =?utf-8?B?QlB6U2diSUhMbWlGN1VobXp6bUludGR0eURCN2F4MnVNQ2tkOXVvVndvOGFH?=
 =?utf-8?B?bXZULzNYRllHNFVlaGQzQVJxKzVWd0ttVGl5Y1hPVmt2dkxMTFZFa2RNcVhO?=
 =?utf-8?B?SXRGalpsU3hDU1kzZXc3ODJObkg2c3pldFNjaERMWEQrZ2NpV0FzQkpvZHpH?=
 =?utf-8?B?dXlGREFJNTZmQlQ3anJ0dWtXdWg3MDlUc2hSRkZ3dUJIUkNYV1pJMFU2aVR0?=
 =?utf-8?B?UFFNcmJsUGFNOEdWQStjbjBCVWZVNzdXS29SdzNnWEFqbkdqb3hLSjRPRlMv?=
 =?utf-8?B?REx2emZ1OURXNGNWYWQzZEJEOXZuc1p4UElyWmNCcjFpTnJrb2d4TFBRVFpY?=
 =?utf-8?B?dXU5aHgycmxrM2pPUjRMOXlGZ1V5SUQrcGpxOFJkVFg3YnJXSnBub0sycXpZ?=
 =?utf-8?B?UFp6bWtBRmhoYVJhQ2tzZFpVNnZyUFRnM29WL3JGNEV0TEloV1hscHFyRWlu?=
 =?utf-8?B?cjRXMzhyRVoxbmxhanBtdTRvN2lQVitWRUw1NUljbXN1NkxmYUh0dDVuSXFk?=
 =?utf-8?B?RVVXNXlNUWJoR0ZYQkJkWTFKRjhUUENYbkY2VnlPYXBDTzFQTU1VSjAxZTR2?=
 =?utf-8?B?MlFSQ3JVbC9VbzgzbnVsSVVXVzlVODBEVVY1TVorbkdsNU9ZMkUyUDQzVk1l?=
 =?utf-8?B?MGZDZUdPS3BUQXl3UXR2VVp5ZkJoS0hobnFFajZ1VklTMStISGxQcjFvMEJl?=
 =?utf-8?B?am9YV1FMTTFzRS9RdTdoMUxhYjRmR05GZk0zMnJkZGRBWW5RZmZybS9laFpv?=
 =?utf-8?B?TW9lNHg3V0ZDRi8yQ1owaVZNOW55UklYTmR1VnpWMldBRHJSQm1QUEo3aEpX?=
 =?utf-8?B?cGxTR3NDZVNVQ1J5cFFKTzFjR0xNSDBvMmZkTDZPQm1FRkhDMmpDWlhiWk8r?=
 =?utf-8?B?ODUrOWovSHRmVEh2cTkwNzFCaHBWZnZhWWFTeWtOYzBVdE1hck1wcGltSVgz?=
 =?utf-8?B?MEw4WkhUY0Z2Z0ZOdGRLRVUyYzcrM0xIRStHYjNjc1RtWGJqbW9xb0ErTzZy?=
 =?utf-8?B?K3djbWhUVWpJTGhneVA3MFVjb1dvK1Uyb01aL1NmR3hUWGZNRFRlNEM1QkRZ?=
 =?utf-8?B?bFMvTkkrY1ZDUWMxKzZXN1I0R2kvU0hZNnY4ZTBPRmtUQU5rdXJrNUpvaFow?=
 =?utf-8?B?N1czdDJHUU10NSs2ZjlWRUE4MkJVSTdaTUthZ1NOaG1kSkFIZUJ5Y1daRWVN?=
 =?utf-8?B?bFhwNUl3Z2RvaU9tYy9FZlBXbmFsK1lVbmE3blZjTmd2dmw3eUtvdzBTajFQ?=
 =?utf-8?B?SzhlT3RWcE0rdStrTldabm9WWExtNDNTN1dqT3ZXN3pGU2I3RE5jbzRZNUF2?=
 =?utf-8?B?cWU5VkF3dEhaUHlqWmFDZzBldHhTZ0NsT3lyUU9kYjEyb1JTOHc0cGladnVj?=
 =?utf-8?B?L3MzellOUGtScWVEdlh6Z1o5Q1laSmRDVk85OEdYN012ci9NTFN5d3VZYlcw?=
 =?utf-8?B?QmZTTG90NlVsQXprTXlQN2tEclFQNHdWWThoSFczc2kyemJZeVgyTHd1NDR2?=
 =?utf-8?B?R3dGY0pvTHFoaW50WXNkU0c2a3IvQ1NZOVIzN01QcHFnWHA2eUZSRHdVS3ZB?=
 =?utf-8?B?MEJMVVBnQTM5aW9yWXVUYWtVRUVoUXJrUUZzZ09UUkFzQmZaNUJUY1NMODNz?=
 =?utf-8?B?UWRjeXRtMXZkcVlReWhnbW1zQVFrQmlEMjZ3TVNDbTZoR2RkZUUra0hZaEpL?=
 =?utf-8?B?OUhOdkZaOTQ0V0xvSHVRWUxMVHQyUWc0K2dZcG4yOGt2M2VzekRzY3phaFYw?=
 =?utf-8?B?TlFPSDJDUUpJUlhodjQwYnJzWEkwbDQ4bmxHWmxGUjdUS2UzcU1WTjkwMStW?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aCs4N2VqUWxRb0lqRnozL3lUNUJCSUR5V1VFVXIxQlM5RG5PSDRrT001YjQx?=
 =?utf-8?B?dzZ5UDZ6dFY1UE5yQnROb3hxeHdiK01ldTZIR2txRmlWZW5CWGlaWFRFcGdr?=
 =?utf-8?B?Vi9FZU1ic3RwaXUydlJ6MjRjYWMwZE04bFo4ZnFFOG96MmEvVVg5N3hyUlo5?=
 =?utf-8?B?Z1BJM0xFdWdjODUvamNwelVNS1kxRXcxd29CQjdSZWt4bHd0OUJMR3dZbTNI?=
 =?utf-8?B?c3FscS9zMXBOelVNKzZHMlFZc0dXSkFzZnl2emQ2QUxjUThTOWl0bkFseWRM?=
 =?utf-8?B?QTI1MmlBRHRHRlpDL2djLzFNeGUyQXdjbDkzTHc4RUxVZ1lhOUNoMnVJOHlm?=
 =?utf-8?B?MXA0WjY4bittT0dQVzY3VFdCa25UalQxRkhndVRVcWdOemw3a1haeitQcERs?=
 =?utf-8?B?RC8xTHhkR05Ic3N1ZE1LOGxVdDhBR0ZrY00zTmd0Nnl0UGhZMGI0Y3BLRXFB?=
 =?utf-8?B?QnBwMWp1OVA1MWFPcW9lZ2IraHJveklXdG5YK0pFRk4raGpVcWdmWXlCUXlF?=
 =?utf-8?B?L0R4dG1FRjVwOGQ0V0txUjdidTBnYTJJSmJWTWg5cFpkUHBrRStEa0M0VDFj?=
 =?utf-8?B?b3BuUmtoY0NiRGk2R0ZQKzA2bTFncWhDNllYRUpRYjc1eWViMms1T29Ldy9Q?=
 =?utf-8?B?eTF4VWF1YjBjVTNWUFlVclJESE1ZVnRyMzNrc01kY2RDbTFOSDV4dHFqN1hx?=
 =?utf-8?B?bjRXUnFSRU9ISGV0QnZ5OEdFeG10ZWZ0TXFRdDVTZlQyN2tXVVVsR0FlazRh?=
 =?utf-8?B?ZHEzQSswUTFqR0dhMHJQbEpscTd1TzUzSTBtb3huUVB0cUwzSFRzZUJnck5z?=
 =?utf-8?B?OXZXSjhxazlvRVBOVi90eGMxMWcrU1NCRVB4dXl4TjlOZ0pBcHhFUE8wRnZl?=
 =?utf-8?B?LzlBc2hHR05tMUt0MmJEV1dib1Mzb25pcnlTcnpMRVlqS3J3TWFxSGlCK0ZW?=
 =?utf-8?B?S3NoRWxZT3ZBdW9qQ3ludDJhZ2dKT3VMY3lkTUlhR1ZBUG1IQjlDRXE1Mlhr?=
 =?utf-8?B?ZXUrOVhtSU1kcWZyQVI2Nm9MSWdqMG9WaWNiQUt3VVl0SGp3d05KcnlHUlp0?=
 =?utf-8?B?WHhCTkxHeXhGNHl0Tm11MlNWSkRyL0hjOWsxU0JKcnowUGRFUnRsSWU2WGFs?=
 =?utf-8?B?a2xuMjFzU0wzVTBjWTFDYXRZdkNQNFhzalI1ZTVKdytxUEF6VWdJeTkxcTU3?=
 =?utf-8?B?UC82aDN2TnB0ai9aQ2lhN2FSOFpVaTl3ZGpJT1E5YVVxRG4xZGNHcFljWEE4?=
 =?utf-8?B?OC8zZFJKeHZobmplcThsR0VUck1EUVdwK2hSRUprMEd4Q05WUWwzek9PUGZP?=
 =?utf-8?B?Z1RtMmUvYjFZSGk1MmxFZ1A2VEFxaHAzajU5WElKUUw1STdWb0RZeUlOaEpZ?=
 =?utf-8?B?Nys4TjJ0Z3BBaWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731603a4-8035-4568-8e92-08db2258eb40
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 17:49:10.4274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsB2Jn6R2TXC/2ZTWlJlgS9nv98UNHLteNj2etN+l4YQWLfBiKRtbgU7Zr3CFiGcw8O+F1nWLmERUDT0n1wphfB/dsAoVqxUaYX8H3rjsI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-11_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303110161
X-Proofpoint-ORIG-GUID: KXVYA2PFkDDLsxtUfthWseMfj8gB577E
X-Proofpoint-GUID: KXVYA2PFkDDLsxtUfthWseMfj8gB577E
Cc: brauner@kernel.org, mst@redhat.com, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, ebiederm@xmission.com, stefanha@redhat.com
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

T24gMy8xMS8yMyAxMToyMSBBTSwgTGludXMgVG9ydmFsZHMgd3JvdGU6Cj4gT24gRnJpLCBNYXIg
MTAsIDIwMjMgYXQgMjowNOKAr1BNIE1pa2UgQ2hyaXN0aWUKPiA8bWljaGFlbC5jaHJpc3RpZUBv
cmFjbGUuY29tPiB3cm90ZToKPj4KPj4gVGhlIGZvbGxvd2luZyBwYXRjaGVzIHdlcmUgbWFkZSBv
dmVyIExpbnVzJ3MgdHJlZSBhbmQgYXBwbHkgb3ZlciBuZXh0LiBUaGV5Cj4+IGFsbG93IHRoZSB2
aG9zdCBsYXllciB0byB1c2UgY29weV9wcm9jZXNzIGluc3RlYWQgb2YgdXNpbmcKPj4gd29ya3F1
ZXVlX3N0cnVjdHMgdG8gY3JlYXRlIHdvcmtlciB0aHJlYWRzIGZvciBWTSdzIGRldmljZXMuCj4g
Cj4gT2ssIGFsbCB0aGVzZSBwYXRjaGVzIGxvb2tlZCBmaW5lIHRvIG1lIGZyb20gYSBxdWljayBz
Y2FuIC0gbm90aGluZwo+IHRoYXQgSSByZWFjdGVkIHRvIGFzIG9iamVjdGlvbmFibGUsIGFuZCBz
ZXZlcmFsIG9mIHRoZW0gbG9va2VkIGxpa2UKPiBuaWNlIGNsZWFudXBzLgo+IAo+IFRoZSBvbmx5
IG9uZSBJIHdlbnQgIldoeSBkbyB5b3UgZG8gaXQgdGhhdCB3YXkiIGZvciB3YXMgaW4gMTAvMTEK
PiAoZW50aXJlbHkgaW50ZXJuYWwgdG8gdmhvc3QsIHNvIEkgZG9uJ3QgZmVlbCB0b28gc3Ryb25n
bHkgYWJvdXQgdGhpcykKPiBob3cgeW91IG1hZGUgInN0cnVjdCB2aG9zdF93b3JrZXIiIGJlIGEg
cG9pbnRlciBpbiAic3RydWN0IHZob3N0X2RldiIuCj4gCj4gSXQgX2xvb2tzXyB0byBtZSBsaWtl
IGl0IGNvdWxkIGp1c3QgaGF2ZSBiZWVuIGFuIGVtYmVkZGVkIHN0cnVjdHVyZQo+IHJhdGhlciB0
aGFuIGEgc2VwYXJhdGUgYWxsb2NhdGlvbi4KPiAKPiBJT1csIHdoeSBkbwo+IAo+ICAgIHZob3N0
X2Rldi0+d29ya2VyCj4gCj4gaW5zdGVhZCBvZiBkb2luZwo+IAo+ICAgdmhvc3RfZGV2Lndvcmtl
cgo+IAo+IGFuZCBqdXN0IGhhdmluZyBpdCBhbGwgaW4gdGhlIHNhbWUgYWxsb2NhdGlvbj8KPiAK
PiBOb3QgYSBiaWcgZGVhbC4gTWF5YmUgeW91IHdhbnRlZCB0aGUgJ3Rlc3QgaWYgd29ya2VyIHBv
aW50ZXIgaXMgTlVMTCcKPiBjb2RlIHRvIHN0YXkgYXJvdW5kLCBhbmQgYmFzaWNhbGx5IHVzZSB0
aGF0IHBvaW50ZXIgYXMgYSBmbGFnIHRvby4gT3IKPiBtYXliZSB0aGVyZSBpcyBzb21lIG90aGVy
IHJlYXNvbiB5b3Ugd2FudCB0byBrZWVwIHRoYXQgc2VwYXJhdGUuLgo+IAoKVGhlcmUgd2VyZSAy
IHJlYXNvbnM6CjEuIFllYWgsIHdlIG5lZWRlZCBhIGZsYWcgdG8gaW5kaWNhdGUgdGhhdCB0aGUg
d29ya2VyIHdhcyBub3Qgc2V0dXAKZm9yIHRoZSBjYXNlcyBsaWtlIHdoZXJlIHVzZXJzcGFjZSBq
dXN0IG9wZW5zIHRoZSBkZXYgdGhlbiBjbG9zZXMgaXQKd2l0aG91dCBkb2luZyB0aGUgSU9DVEwg
dGhhdCBkb2VzIHZob3N0X2Rldl9zZXRfb3duZXIuCgoyLiBJIGNvdWxkIGhhdmUgaGFuZGxlZCAj
MSBieSBlbWJlZGRpbmcgdGhlIHdvcmtlciBpbiB0aGUgdmhvc3RfZGV2CmFuZCB0aGVuIGp1c3Qg
dGVzdGluZyB3b3JrZXIudnRzay4gSG93ZXZlciwgSSBoYXZlIGEgZm9sbG93dXAgcGF0Y2hzZXQK
dGhhdCBhbGxvd3MgdXMgdG8gY3JlYXRlIG11bHRpcGxlIHdvcmtlciB0aHJlYWRzIHBlciBkZXZp
Y2UuIEZvcgp0aGF0IHBhdGNoc2V0IEkgdGhlbiBkbzoKCi0gaWYgKHZob3N0X2Rldi0+d29ya2Vy
KQoKKyBpZiAodmhvc3RfZGV2LT53b3JrZXJzKQoKc28gSSB0aGluayBpdCBqdXN0IHNhdmVkIG1l
IHNvbWUgdHlwaW5nLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
