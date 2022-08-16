Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983B1C2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 07:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30EF940298;
	Tue, 16 Aug 2022 07:59:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30EF940298
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=QB+neVZQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=CWaEz1Rn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggISPUadUVdR; Tue, 16 Aug 2022 07:59:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4887240123;
	Tue, 16 Aug 2022 07:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4887240123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF416C0032;
	Tue, 16 Aug 2022 07:59:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7567C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74A0F8140F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74A0F8140F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=QB+neVZQ; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=CWaEz1Rn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gV3RsjMvpS-M
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E516681314
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E516681314
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 07:59:00 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G3TFXn029659;
 Tue, 16 Aug 2022 07:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RLdsckxY2d7ns+AKUYbjz36pdlFrp/+9jjyy6lU73Uk=;
 b=QB+neVZQ8rRkOC3/fignpL/TxpXKx5J3F1rEEWttI6w92C1+OVU43l3EdE4SiFuTis/z
 xHZZzgEFDkx3DqRnCEqJLt+H5u8T2ZTjXlrkHQCQJYbVTWcRALPf9eEBLU9BobAya65F
 3mDxaOLiiBeh4VgRyXeJKEDaDFu4wxwWbz2RR06ljfXGZATl7QmZZiec43IHEeMbllYK
 jDjtCjuOHVZiUArBYKz5lPlyoDRY6/2gPh6sWushAThm282zMspG7vfG5nvpC1I7/55X
 MurbXWIljbiUVVYL6tsfXdSu4Pc+MrhnbVEgBEFxTOzY4vNdXmNDXSN1EZnCc/HuLv2P qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx3js53rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 07:58:57 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27G6Wmin023494; Tue, 16 Aug 2022 07:58:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d2701t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Aug 2022 07:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqUnJzyK77bYJb13k5fsnqGtPUmaTpLUkUfTkrPdH7T6nZebLDAd+36odgXT3ouhasFYxrYk5JPKMT2WONI+bGwwpnDoBA+BmdPKiKKwrqYr47ze+EouapOns+1OgJKGgObrftVbxItCNWsdnc/oWtkmrAtX4fWVs79Com/TgI3b9PXPqdKfpLWJxnsTD2hMjLGKw9yJiKrSr2bWCc/4iBg2A2iPaV2fcpV1UhJ+3su8F4MTnVm8aRFD+KVK1WeQVZqWPflDCxJcmzXFru33FGaNyCN6WZ/uUTqqbsvG4vrzlyRHXYdiZ6B3TXSHEh6qA4dEtYnCoRpeOMepBWxHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLdsckxY2d7ns+AKUYbjz36pdlFrp/+9jjyy6lU73Uk=;
 b=KmZQkoYHaZR2WNdcYLx8K367V+f2uohGIIe4xLtL1jDYPlcQZ63mFMftpLXIBrLwgs+DemWovN0G/jOxxNSRjdQ1Tbokmq86dJAV08Bd5vv0a6/5P10HiOyDVaEIptRp8jXrLaX++Wi2wl2uyVfxa2pYGX1SAObwr1qcxPEbbmyquMIDWM5vGxmtW7mf0oJYJM9JMs6/uqDfUQJ4gxGh9N3YlZqnbP5pEeaFIOOFm6z7DJJrWyibbFjSvxNGSqClL+h4Me73lRoHkjsSRBD/+kOhqPyVrlQg3IkD6W/rMQvmyeoWxhW3k0qCIclXP5WpwUCuOSywR33aPPECLOKS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLdsckxY2d7ns+AKUYbjz36pdlFrp/+9jjyy6lU73Uk=;
 b=CWaEz1RnU5Jfw9YmskgXKl+cPMw8Sg5eVBh0w2n0tWyejC/XcaxWtVE2y1mWuMRK7QLRajjbTiuvWSDO3znlVvnrPw0CvkjyIwDusoGJiYPbM7EUOhpDz0Q8Gd2yOspFcbAHprQrs9B6ADq6lT6GtQJNR5t3IDIbnTb4OFPd5Ug=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 07:58:53 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 07:58:46 +0000
Message-ID: <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
Date: Tue, 16 Aug 2022 00:58:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
 mst@redhat.com
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
X-ClientProxiedBy: DS7PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::33) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89e315b8-f127-4052-704b-08da7f5d259b
X-MS-TrafficTypeDiagnostic: CH2PR10MB4391:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVh5d5UvK+Wo7ljX+Dws1IK1mNLgTEgspiGr9vH4dcJSsOsjzikneXN+3FcwF3C8s+Stlo3i9m03ZOqnNYWxcCsoKDJY6WtvkfnZDoxvW+1O12lgjfyJL38V8dxSr2PIs6mQ0FOO9vRJ3KmUulrK5DbE93tClMX+2rX9acZyV6R4YHVms4zoN3s/KiYxxo9xAgcZygaJQwcl8hJXwVJiYZnvZZ9D2+7W5MISHxusszhqpPydy04aRznHKlGfKUsQqpyuf8pWdtns8CNzJUr6o6Jx7yTeRL+CQQYANr3hlFj8rL9/qZo5z4vQvgapKQkBQuRHBM4bQtuv09QcJutoYni50vRo+CRd90u660ZdrNkeJS3epyvhHinisAHQ0HVWwDpmd5aQ8SisRVLbZkJWww5grP2HBGlHmoJd2zpv2fqHjIrvOH420dup8w0uKpJdycCLYzbwNQTpsMA0tkINxCzusCLbWbZPBhkYxFNzWmMQhVyzveyaVmxGdTugspRiSOkq/9yPtjUQ1GMz8/nmz+BtSYvxLJnOwQFo7EdF+EvwoDIdtaI5D9+5GVK28SBkFUsL/FD1UY04B02qMVpuGqSKQwY70btBe028ZfQUROAb7hI/8kEdjL4UtULIg9xV3PlTwDQ6YExcQOG6ionaPrnIoJd+yIJEFvwB/CsVr30lDHhsl3xVyMfJn3I9uch17cF2T/WZp/QMoiHc6QOHUjDSpoMP0k+IdzP2bW+u291PTEuvgMI5TlggXsBz5+Nk1ap3qO6Pxx6tw5xriv3QWuE5nfwC9LlepaoUemWT76D9bVRHvHyKf9Rx1NgL9ODjy7qfsLMiQ/QNSH5zOy91wAo/a0Da6pbIE/Xb9JXI6oH0JmGzIU9ySoKVp5aLU0P7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(396003)(136003)(39860400002)(346002)(376002)(6512007)(2616005)(53546011)(6666004)(86362001)(36916002)(6506007)(186003)(36756003)(26005)(83380400001)(316002)(41300700001)(4326008)(31696002)(66946007)(66476007)(66556008)(2906002)(6486002)(5660300002)(478600001)(8676002)(31686004)(8936002)(38100700002)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BXYTZid1hNOVpDYjVRVzRJNmozQUo4U29RdW1uL0VDY3p5bmtEa09Xd2hy?=
 =?utf-8?B?Q0lteTNKRk9qWEtpZVVUS1czb09FMlJqeU51UlBCTFJ5VWNVR0oyZjFwQ0F4?=
 =?utf-8?B?aXozbWhmOGdOYkl3UnZ4MWpmbzUrQktYM29QODF2eDNlekxBRFRXeFZOdFB3?=
 =?utf-8?B?K0hFaGd5N0lvbHJRNjViVmptZXZaU0hFWWsvWlRVYkozcUdzT0xVekl3NHZ6?=
 =?utf-8?B?bWt3bGJKalVybkZxaFkwTURWazJ2VGk3WW9vWXRxVEpOWlFiU3Q5alFZWHEy?=
 =?utf-8?B?ZFRxdk9PMWpYbGJ3S2NFd2xlM1V0OG02emQ2M0M1QWY0YVNaRTlnRXpBN21l?=
 =?utf-8?B?bExIZFFobzhiSEVoWGkvQ3R1eUQ0L1EwY0c3RFcrY3pVSXFkMTZ5aTNobEVG?=
 =?utf-8?B?NnV6NTdhMExodUVrM2pQQXNiOVp6UlQ3WWcyUC9sMkFPUndTNk5JREJ2eWFI?=
 =?utf-8?B?bnk0a1ZLeWRkd2xGcDdwRTFHNksvSnhJWjF2aGxyVllIUHVpVExZQmY3RjJ0?=
 =?utf-8?B?d2srWmpvcE9vMExtR3JTY2orRVE5R1pOZE9WSVlBbkpvOENrVGVPZEFPUGZN?=
 =?utf-8?B?ckxtSXZaT2hDYndmNk0vc0tIYjB3OXBxQzcrY0k3UFU2cXNWK2tnYXRZdE0r?=
 =?utf-8?B?TTVDV21wcnMxYk45d0xWY3EzM3owS3JtSi9kOW5rb29BNlNLNWZsUjJXQ3lr?=
 =?utf-8?B?aHFWZ0xRQldEcWgrWk1CYXRsMnQ5NjJxTWNWM3FFWFRuRElRQXZKcS9rQ213?=
 =?utf-8?B?UExLblYzMHR0NWlEdVJ6YUxBZ0xsUWFUTlpnMzhpbFZXQUxzS0lDcVRsU3A2?=
 =?utf-8?B?Z0pkcW5OeFV1WW45cW5GbHo3eWQ3N0pDKzU3dS96SDlQVFYwejNEUFJnUXll?=
 =?utf-8?B?c2pHczNJcHpacEJUemQ5SjI3TjFqUFg4ZjFPRXZjQ2FmZW51dUdoZWp6U2pP?=
 =?utf-8?B?dkI4OTViRVYzckdYNW95QXFKeGdOYjZiQUxZaUdFbU0vcGE2THhyZDJuaFM5?=
 =?utf-8?B?WHMzOFhsUS8wTm5ESUdrWFhBRnNOTXVZQ0hmcDZ4OEpiRGl0RFpDNzZFZHFx?=
 =?utf-8?B?S2FlWFVIQ09HWU04SGpRYlVndGZkU1AvcWRiaFNqeCtoZnZWeVMyY2dZMFhq?=
 =?utf-8?B?eWpGV3Vta3J5NHA4Nlg0ZnB3ODZRQU96dWtYcTd6S0ZPTjFPQS9uWTFIOWlD?=
 =?utf-8?B?QllrSEdSd1Vudm1JeU12SVpHazRYR0c4QVc0N2hrQ0pjSXh4UlBLdlRvNmlw?=
 =?utf-8?B?SFlKa2FwWGFiZzJ1WlZGU29ISGl3dUh4RE41a2VOVjhFVFczMkhQeEVBRkFR?=
 =?utf-8?B?T2dZTWFiVVpJank0RDRFM3BwNW5wVnFncjN2VllJSW1rWklGU0dCbVBDSzky?=
 =?utf-8?B?NDZzUEdEUXV5TGpyQ1UvSjc0OEZZOWNRQ3NzYTFpb1dVZ3R4c3diTXIrRWNW?=
 =?utf-8?B?dTNCMWMzTHNHdFJhdlArc0JFbGhMTEViYWVoNjVxOS9kN1oxTHpTNVJMOFE1?=
 =?utf-8?B?ZFFodW9MbXR6WjU2RjVnZEM2NHdVeXlQOG9TeFBocWxXbk5SOTQ1MHFobWs2?=
 =?utf-8?B?d2xMYkVmWUpVRGRwS2VWNTJvYW9rL2cvZ0xjTmh4azQ3aFc3YXdjdWM4Ymp2?=
 =?utf-8?B?bDhVdXNHNjZ4c21FcDVtTnNOaXgyWksvQ2ZIN1dmOFFIa1dlVmgrV2FSUW5W?=
 =?utf-8?B?eTFQTDVCYzhWQkVoenhKUnIwWEJON29jUDltcmhFYnBCcmp2WExQWmdtMWN4?=
 =?utf-8?B?S0Ftb0ZNdExqb21mcEZyMGE0dldYZEt4Z2dvd1dzdEdod0lFQjhwbEhBZjE0?=
 =?utf-8?B?WkxabkNSNldVVlJEemdKNVVNR3pTZGZreE11M0ZWSVErcnc1QlFNUjNOS2dE?=
 =?utf-8?B?THBZVHBFa0lKZldwVjdXN2hoY3pKdFlVQmgxUFU0a2pQVkdITURxNFJjRDB5?=
 =?utf-8?B?T0hzVDV3Z0hJUmlkaEl2VjRWQ2E0d085VjNWL3VjR2hyZnh2RjBYSFRIUnAw?=
 =?utf-8?B?b0VhMjNvZW5YRFJtYWM5emRuYkRUNXo4L1hTN2I4SFZCMU10ZUdkYmRsNmgy?=
 =?utf-8?B?Tm5UR3RHZXp5cVBWRmt5c2tGblVuWXl5NnFORW9wTFNGZG10RUVPc0l3ZWlq?=
 =?utf-8?Q?m8V3gmZFgn8DoGOZ+QnJr3XW9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NnhNVkFEZk1oejU4Y01xRi9taThQUEFyc2ZZQ2ZyVHpUZWZCSmE0V1owT2tw?=
 =?utf-8?B?YzUremdPMUZMaWdPSVhJMHovQnV4N3RCRlowZ1FMM29sNkNOYmZDU0ticVlD?=
 =?utf-8?B?dXlna2M4MEQrZURFaGdSV1dXMWRuMDdnYkJ1OFNKclVuT3FCeVFWZ2xZTzQ2?=
 =?utf-8?B?akIrUitkOGNBZnZETVlVV2Z1SDhyWDVaOGhoaXIxNTRhdENmcy9kazZUdFo3?=
 =?utf-8?B?eXRYUGVkR1hKUUE4RW5DMEdLZU9mTnd6SS9raEUyUTBtWFlrWUNyb0dZQVoy?=
 =?utf-8?B?ZTBleUh5TWRnQWZVQ2puTk83NEt5b1JSU1NsYjI1bnpBSmFYTndRbGlYc0po?=
 =?utf-8?B?Q2F6a056QWdIaUZFVURURjU0emxCN21yc0pJSXpSUDdEejlnWHQraUVmamJX?=
 =?utf-8?B?ZzNERW92VGNpK0dNWDZMdU1vSFpiTm1GN28zMCtSazhOakVqNlR6bjBQM0tO?=
 =?utf-8?B?RG5FOVhZbzkyOEtxeDNhZVp1Z3ZiazRIaFpOaVBMQ0VZa2NabVZ5TU4zbkdm?=
 =?utf-8?B?Ri9BNmYxU0FzcjVrNFNweXUzZ0RUaCtYSWVxdFdsU0hpcnNTYXczTk5uOExL?=
 =?utf-8?B?QWowbE9GVURtanRtMGFLMlN0amdKWjE1TmFoN1I1VEtoWDQ1V2QzQnRkSG5P?=
 =?utf-8?B?c21qK0d0cmxvSzdTdTFaRUxOdHU2cFYzSnk3RGV3NVppUXpNUkc0TjhjcHBM?=
 =?utf-8?B?V01IRHZ2akFEa3VHM2wyVHd5dU5KeWdRUCtJb2x0TVEzdlFoMDBYY3BmTTFZ?=
 =?utf-8?B?RnhySzBtV25lMzJaZ1BrTVhNUXo2cTVvZVBRNXIzK3dqSzNvUk5rMHd6NFVR?=
 =?utf-8?B?eldybGk2eDBIWW0yWjc4emRKWC9mbzN1WVZiVzhhSHU5MmJ1eC9WUmZKUHZm?=
 =?utf-8?B?V1VGZnZzWUtLcWw2cHlVVm00OXo4dU5QYm1XVW9pTUVUTC9qT0g5Y1I0S3ZU?=
 =?utf-8?B?T0dqMFJ0QkdtR0xyTWwrNVJuZnppWFlDZFI5YzBGVFh5aHQxL0Fxb1huaTVr?=
 =?utf-8?B?TUkwM1pFcjQyUWllOS9td1Z3V1BnZVc1SVc1N0h5OTdFTlgrZnV2VUtFM2hy?=
 =?utf-8?B?dEd1dFFIL0I2SWd4Y1dHWGxxdm45b2U2MGovbk1kNjZOcWtCZ2tvMXVVbko4?=
 =?utf-8?B?MkttOFhFZmpJYlBncE9uNkpUNlJ4VDdUNkVYQlkxdVM1elhrcU0yRnMrUDBl?=
 =?utf-8?B?dXpkRVE3SXlpYjlGaTJ1c0pKd0RFYjVkSVA3RHgrMlZQY3pvQ3JxNC84RWMr?=
 =?utf-8?B?VFJVeXJTeFBPczJGNDYzYnNiVTBrVTBXQWN4MjI4VG9DbHZ4WUY0N0lZR0F4?=
 =?utf-8?B?UUgzNUJJU2syTWVCOUpxVGFPejZ3K1dOR0pybFdQQVUxTVh0YzJxcExmSEM0?=
 =?utf-8?B?SlR3Wk10Z1FkNGQrUVVTT1pqTm5zeHhzTTBnUWFuNE0yVXc0aFFKYW5NbUVV?=
 =?utf-8?B?RWhZeVI5QnRWQU1pZENVSWZ0V3dwMExHT2lvZzFvV0M2OTFoNUJkcXNlZjBw?=
 =?utf-8?B?UDB2MTJVcmgxRnhZdW5mL2pkQU9EK0QvOFFuZVVNL1BuRWJxOXB6TmRHNmM3?=
 =?utf-8?Q?BI28VAprDkF/+ppmmfoqCHmiJc3IcnKhnEJXh6ilRvS7dg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e315b8-f127-4052-704b-08da7f5d259b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:58:46.7851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrL/frd1n6GsSdEFg64iJI0QaFcQYvNcZ2X+LdWGvFlBbK27MOhn4Spdzr3LoXi0Djk4YcUVYdM2lhi8zTJQVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_06,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160031
X-Proofpoint-GUID: 2vR1YgGDIu6H6ddlhGXmD_HyKh4za7i8
X-Proofpoint-ORIG-GUID: 2vR1YgGDIu6H6ddlhGXmD_HyKh4za7i8
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

CgpPbiA4LzE1LzIwMjIgNjo1OCBQTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24gOC8x
Ni8yMDIyIDc6MzIgQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDgvMTUvMjAyMiAy
OjI2IEFNLCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+PiBTb21lIGZpZWxkcyBvZiB2aXJ0aW8tbmV0
IGRldmljZSBjb25maWcgc3BhY2UgYXJlCj4+PiBjb25kaXRpb25hbCBvbiB0aGUgZmVhdHVyZSBi
aXRzLCB0aGUgc3BlYyBzYXlzOgo+Pj4KPj4+ICJUaGUgbWFjIGFkZHJlc3MgZmllbGQgYWx3YXlz
IGV4aXN0cwo+Pj4gKHRob3VnaCBpcyBvbmx5IHZhbGlkIGlmIFZJUlRJT19ORVRfRl9NQUMgaXMg
c2V0KSIKPj4+Cj4+PiAibWF4X3ZpcnRxdWV1ZV9wYWlycyBvbmx5IGV4aXN0cyBpZiBWSVJUSU9f
TkVUX0ZfTVEKPj4+IG9yIFZJUlRJT19ORVRfRl9SU1MgaXMgc2V0Igo+Pj4KPj4+ICJtdHUgb25s
eSBleGlzdHMgaWYgVklSVElPX05FVF9GX01UVSBpcyBzZXQiCj4+Pgo+Pj4gc28gd2Ugc2hvdWxk
IHJlYWQgTVRVLCBNQUMgYW5kIE1RIGluIHRoZSBkZXZpY2UgY29uZmlnCj4+PiBzcGFjZSBvbmx5
IHdoZW4gdGhlc2UgZmVhdHVyZSBiaXRzIGFyZSBvZmZlcmVkLgo+Pj4KPj4+IEZvciBNUSwgaWYg
Ym90aCBWSVJUSU9fTkVUX0ZfTVEgYW5kIFZJUlRJT19ORVRfRl9SU1MgYXJlCj4+PiBub3Qgc2V0
LCB0aGUgdmlydGlvIGRldmljZSBzaG91bGQgaGF2ZQo+Pj4gb25lIHF1ZXVlIHBhaXIgYXMgZGVm
YXVsdCB2YWx1ZSwgc28gd2hlbiB1c2Vyc3BhY2UgcXVlcnlpbmcgcXVldWUgCj4+PiBwYWlyIG51
bWJlcnMsCj4+PiBpdCBzaG91bGQgcmV0dXJuIG1xPTEgdGhhbiB6ZXJvLgo+Pj4KPj4+IEZvciBN
VFUsIGlmIFZJUlRJT19ORVRfRl9NVFUgaXMgbm90IHNldCwgd2Ugc2hvdWxkIG5vdCByZWFkCj4+
PiBNVFUgZnJvbSB0aGUgZGV2aWNlIGNvbmZpZyBzYXBjZS4KPj4+IFJGQzg5NCA8QSBTdGFuZGFy
ZCBmb3IgdGhlIFRyYW5zbWlzc2lvbiBvZiBJUCBEYXRhZ3JhbXMgb3ZlciAKPj4+IEV0aGVybmV0
IE5ldHdvcmtzPgo+Pj4gc2F5czoiVGhlIG1pbmltdW0gbGVuZ3RoIG9mIHRoZSBkYXRhIGZpZWxk
IG9mIGEgcGFja2V0IHNlbnQgb3ZlciBhbgo+Pj4gRXRoZXJuZXQgaXMgMTUwMCBvY3RldHMsIHRo
dXMgdGhlIG1heGltdW0gbGVuZ3RoIG9mIGFuIElQIGRhdGFncmFtCj4+PiBzZW50IG92ZXIgYW4g
RXRoZXJuZXQgaXMgMTUwMCBvY3RldHMuwqAgSW1wbGVtZW50YXRpb25zIGFyZSBlbmNvdXJhZ2Vk
Cj4+PiB0byBzdXBwb3J0IGZ1bGwtbGVuZ3RoIHBhY2tldHMiCj4+IE5vdGVkIHRoZXJlJ3MgYSB0
eXBvIGluIHRoZSBhYm92ZSAiVGhlICptYXhpbXVtKiBsZW5ndGggb2YgdGhlIGRhdGEgCj4+IGZp
ZWxkIG9mIGEgcGFja2V0IHNlbnQgb3ZlciBhbiBFdGhlcm5ldCBpcyAxNTAwIG9jdGV0cyAuLi4i
IGFuZCB0aGUgCj4+IFJGQyB3YXMgd3JpdHRlbiAxOTg0Lgo+IHRoZSBzcGVjIFJGQzg5NCBzYXlz
IGl0IGlzIDE1MDAsIHNlZSA8YSAKPiBocmVmPSJodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzg5NC50eHRfXzshIUFDV1Y1TjlNMlJW
OTloUSFNZGd4Wmp3NXNwNVF6LUdLZndUMUlXY3dfTDRKbzEtVWVrdUpQRnoxVXJHM1l1cWlyS3o3
UDlrc2RKRmgxdkI2ekhKN3o4UTA0ZnBUMC05aldYQ3RsV00kIj5odHRwczovL3d3dy5yZmMtZWRp
dG9yLm9yZy9yZmMvcmZjODk0LnR4dDwvYT4KPj4KPj4gQXBwYXJlbnRseSB0aGF0IGlzIG5vIGxv
bmdlciB0cnVlIHdpdGggdGhlIGludHJvZHVjdGlvbiBvZiBKdW1ibyBzaXplIAo+PiBmcmFtZSBs
YXRlciBpbiB0aGUgMjAwMHMuIEknbSBub3Qgc3VyZSB3aGF0IGlzIHRoZSBwb2ludCBvZiBtZW50
aW9uIAo+PiB0aGlzIGFuY2llbnQgUkZDLiBJdCBkb2Vzbid0IHNheSBkZWZhdWx0IE1UVSBvZiBh
bnkgRXRoZXJuZXQgCj4+IE5JQy9zd2l0Y2ggc2hvdWxkIGJlIDE1MDAgaW4gZWl0aGVywqAgY2Fz
ZS4KPiBUaGlzIGNvdWxkIGJlIGEgbGFyZ2VyIG51bWJlciBmb3Igc3VyZSwgd2UgYXJlIHRyeWlu
ZyB0byBmaW5kIG91dCB0aGUgCj4gbWluIHZhbHVlIGZvciBFdGhlcm5ldCBoZXJlLCB0byBzdXBw
b3J0IDE1MDAgb2N0ZXRzLCBNVFUgc2hvdWxkIGJlIAo+IDE1MDAgYXQgbGVhc3QsIHNvIEkgYXNz
dW1lIDE1MDAgc2hvdWxkIGJlIHRoZSBkZWZhdWx0IHZhbHVlIGZvciBNVFUKPj4KPj4+Cj4+PiB2
aXJ0aW8gc3BlYyBzYXlzOiJUaGUgdmlydGlvIG5ldHdvcmsgZGV2aWNlIGlzIGEgdmlydHVhbCBl
dGhlcm5ldCAKPj4+IGNhcmQiLAo+PiBSaWdodCwKPj4+IHNvIHRoZSBkZWZhdWx0IE1UVSB2YWx1
ZSBzaG91bGQgYmUgMTUwMCBmb3IgdmlydGlvLW5ldC4KPj4gLi4uIGJ1dCBpdCBkb2Vzbid0IHNh
eSB0aGUgZGVmYXVsdCBpcyAxNTAwLiBBdCBsZWFzdCwgbm90IGluIGV4cGxpY2l0IAo+PiB3YXku
IFdoeSBpdCBjYW4ndCBiZSAxNDkyIG9yIGV2ZW4gbG93ZXI/IEluIHByYWN0aWNlLCBpZiB0aGUg
bmV0d29yayAKPj4gYmFja2VuZCBoYXMgYSBNVFUgaGlnaGVyIHRoYW4gMTUwMCwgdGhlcmUncyBu
b3RoaW5nIHdyb25nIGZvciBndWVzdCAKPj4gdG8gY29uZmlndXJlIGRlZmF1bHQgTVRVIG1vcmUg
dGhhbiAxNTAwLgo+IHNhbWUgYXMgYWJvdmUKPj4KPj4+Cj4+PiBGb3IgTUFDLCB0aGUgc3BlYyBz
YXlzOiJJZiB0aGUgVklSVElPX05FVF9GX01BQyBmZWF0dXJlIGJpdCBpcyBzZXQsCj4+PiB0aGUg
Y29uZmlndXJhdGlvbiBzcGFjZSBtYWMgZW50cnkgaW5kaWNhdGVzIHRoZSDigJxwaHlzaWNhbOKA
nSBhZGRyZXNzCj4+PiBvZiB0aGUgbmV0d29yayBjYXJkLCBvdGhlcndpc2UgdGhlIGRyaXZlciB3
b3VsZCB0eXBpY2FsbHkKPj4+IGdlbmVyYXRlIGEgcmFuZG9tIGxvY2FsIE1BQyBhZGRyZXNzLiIg
U28gdGhlcmUgaXMgbm8KPj4+IGRlZmF1bHQgTUFDIGFkZHJlc3MgaWYgVklSVElPX05FVF9GX01B
QyBub3Qgc2V0Lgo+Pj4KPj4+IFRoaXMgY29tbWl0cyBpbnRyb2R1Y2VzIGZ1bmN0aW9ucyB2ZHBh
X2Rldl9uZXRfbXR1X2NvbmZpZ19maWxsKCkKPj4+IGFuZCB2ZHBhX2Rldl9uZXRfbWFjX2NvbmZp
Z19maWxsKCkgdG8gZmlsbCBNVFUgYW5kIE1BQy4KPj4+IEl0IGFsc28gZml4ZXMgdmRwYV9kZXZf
bmV0X21xX2NvbmZpZ19maWxsKCkgdG8gcmVwb3J0IGNvcnJlY3QKPj4+IE1RIHdoZW4gX0ZfTVEg
aXMgbm90IHByZXNlbnQuCj4+Pgo+Pj4gVGhlc2UgZnVuY3Rpb25zIHNob3VsZCBjaGVjayBkZXZp
Y2VzIGZlYXR1cmVzIHRoYW4gZHJpdmVyCj4+PiBmZWF0dXJlcywgYW5kIHN0cnVjdCB2ZHBhX2Rl
dmljZSBpcyBub3QgbmVlZGVkIGFzIGEgcGFyYW1ldGVyCj4+Pgo+Pj4gVGhlIHRlc3QgJiB1c2Vy
c3BhY2UgdG9vbCBvdXRwdXQ6Cj4+Pgo+Pj4gRmVhdHVyZSBiaXQgVklSVElPX05FVF9GX01UVSwg
VklSVElPX05FVF9GX1JTUywgVklSVElPX05FVF9GX01RCj4+PiBhbmQgVklSVElPX05FVF9GX01B
QyBjYW4gYmUgbWFzayBvdXQgYnkgaGFyZGNvZGUuCj4+Pgo+Pj4gSG93ZXZlciwgaXQgaXMgY2hh
bGxlbmdpbmcgdG8gImRpc2FibGUiIHRoZSByZWxhdGVkIGZpZWxkcwo+Pj4gaW4gdGhlIEhXIGRl
dmljZSBjb25maWcgc3BhY2UsIHNvIGxldCdzIGp1c3QgYXNzdW1lIHRoZSB2YWx1ZXMKPj4+IGFy
ZSBtZWFuaW5nbGVzcyBpZiB0aGUgZmVhdHVyZSBiaXRzIGFyZSBub3Qgc2V0Lgo+Pj4KPj4+IEJl
Zm9yZSB0aGlzIGNoYW5nZSwgd2hlbiBmZWF0dXJlIGJpdHMgZm9yIFJTUywgTVEsIE1UVSBhbmQg
TUFDCj4+PiBhcmUgbm90IHNldCwgaXByb3V0ZTIgb3V0cHV0Ogo+Pj4gJHZkcGEgdmRwYTA6IG1h
YyAwMDplODpjYToxMTpiZTowNSBsaW5rIHVwIGxpbmtfYW5ub3VuY2UgZmFsc2UgbXR1IDE1MDAK
Pj4+IMKgwqAgbmVnb3RpYXRlZF9mZWF0dXJlcwo+Pj4KPj4+IHdpdGhvdXQgdGhpcyBjb21taXQs
IGZ1bmN0aW9uIHZkcGFfZGV2X25ldF9jb25maWdfZmlsbCgpCj4+PiByZWFkcyBhbGwgY29uZmln
IHNwYWNlIGZpZWxkcyB1bmNvbmRpdGlvbmFsbHksIHNvIGxldCdzCj4+PiBhc3N1bWUgdGhlIE1B
QyBhbmQgTVRVIGFyZSBtZWFuaW5nbGVzcywgYW5kIGl0IGNoZWNrcwo+Pj4gTVEgd2l0aCBkcml2
ZXJfZmVhdHVyZXMsIHNvIHdlIGRvbid0IHNlZSBtYXhfdnFfcGFpcnMuCj4+Pgo+Pj4gQWZ0ZXIg
YXBwbHlpbmcgdGhpcyBjb21taXQsIHdoZW4gZmVhdHVyZSBiaXRzIGZvcgo+Pj4gTVEsIFJTUywg
TUFDIGFuZCBNVFUgYXJlIG5vdCBzZXQsaXByb3V0ZTIgb3V0cHV0Ogo+Pj4gJHZkcGEgZGV2IGNv
bmZpZyBzaG93IHZkcGEwCj4+PiB2ZHBhMDogbGluayB1cCBsaW5rX2Fubm91bmNlIGZhbHNlIG1h
eF92cV9wYWlycyAxIG10dSAxNTAwCj4+PiDCoMKgIG5lZ290aWF0ZWRfZmVhdHVyZXMKPj4+Cj4+
PiBBcyBleHBsYWluZWQgYWJvdmU6Cj4+PiBIZXJlIGlzIG5vIE1BQywgYmVjYXVzZSBWSVJUSU9f
TkVUX0ZfTUFDIGlzIG5vdCBzZXQsCj4+PiBhbmQgdGhlcmUgaXMgbm8gZGVmYXVsdCB2YWx1ZSBm
b3IgTUFDLiBJdCBzaG93cwo+Pj4gbWF4X3ZxX3BhcmlzID0gMSBiZWNhdXNlIGV2ZW4gd2l0aG91
dCBNUSBmZWF0dXJlLAo+Pj4gYSBmdW5jdGlvbmFsIHZpcnRpby1uZXQgbXVzdCBoYXZlIG9uZSBx
dWV1ZSBwYWlyLgo+Pj4gbXR1ID0gMTUwMCBpcyB0aGUgZGVmYXVsdCB2YWx1ZSBhcyBldGhlcm5l
dAo+Pj4gcmVxdWlyZWQuCj4+Pgo+Pj4gVGhpcyBjb21taXQgYWxzbyBhZGQgc3VwcGxlbWVudGFy
eSBjb21tZW50cyBmb3IKPj4+IF9fdmlydGlvMTZfdG9fY3B1KHRydWUsIHh4eCkgb3BlcmF0aW9u
cyBpbgo+Pj4gdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKCkgYW5kIHZkcGFfZmlsbF9zdGF0c19y
ZWMoKQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGlu
dGVsLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy92ZHBhL3ZkcGEuYyB8IDYwIAo+Pj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+PiBpbmRl
eCBlZmI1NWEwNmU5NjEuLmE3NDY2MGI5ODk3OSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmRw
YS92ZHBhLmMKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPj4+IEBAIC04MDEsMTkgKzgw
MSw0NCBAQCBzdGF0aWMgaW50IHZkcGFfbmxfY21kX2Rldl9nZXRfZHVtcGl0KHN0cnVjdCAKPj4+
IHNrX2J1ZmYgKm1zZywgc3RydWN0IG5ldGxpbmtfY2FsbGJhCj4+PiDCoMKgwqDCoMKgIHJldHVy
biBtc2ctPmxlbjsKPj4+IMKgIH0KPj4+IMKgIC1zdGF0aWMgaW50IHZkcGFfZGV2X25ldF9tcV9j
b25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrX2J1ZmYgKm1zZywgdTY0IGZl
YXR1cmVzLAo+Pj4gK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKHN0cnVj
dCBza19idWZmICptc2csIHU2NCAKPj4+IGZlYXR1cmVzLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCB2aXJ0aW9fbmV0X2Nv
bmZpZyAqY29uZmlnKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCB1MTYgdmFsX3UxNjsKPj4+IMKg
IC3CoMKgwqAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX01RKSkgPT0gMCkK
Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+ICvCoMKgwqAgaWYgKChmZWF0dXJlcyAm
IEJJVF9VTEwoVklSVElPX05FVF9GX01RKSkgPT0gMCAmJgo+Pj4gK8KgwqDCoMKgwqDCoMKgIChm
ZWF0dXJlcyAmIEJJVF9VTEwoVklSVElPX05FVF9GX1JTUykpID09IDApCj4+PiArwqDCoMKgwqDC
oMKgwqAgdmFsX3UxNiA9IDE7Cj4+PiArwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDCoMKgwqDCoCB2
YWxfdTE2ID0gX192aXJ0aW8xNl90b19jcHUodHJ1ZSwgCj4+PiBjb25maWctPm1heF92aXJ0cXVl
dWVfcGFpcnMpOwo+Pj4gwqAgLcKgwqDCoCB2YWxfdTE2ID0gbGUxNl90b19jcHUoY29uZmlnLT5t
YXhfdmlydHF1ZXVlX3BhaXJzKTsKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIG5sYV9wdXRfdTE2KG1z
ZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsIHZhbF91MTYpOwo+Pj4gwqAgfQo+Pj4g
wqAgK3N0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X210dV9jb25maWdfZmlsbChzdHJ1Y3Qgc2tfYnVm
ZiAqbXNnLCB1NjQgCj4+PiBmZWF0dXJlcywKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgKmNvbmZpZykKPj4+
ICt7Cj4+PiArwqDCoMKgIHUxNiB2YWxfdTE2Owo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoKGZlYXR1
cmVzICYgQklUX1VMTChWSVJUSU9fTkVUX0ZfTVRVKSkgPT0gMCkKPj4+ICvCoMKgwqDCoMKgwqDC
oCB2YWxfdTE2ID0gMTUwMDsKPj4gQXMgc2FpZCwgdGhlcmUncyBubyB2aXJ0aW8gc3BlYyBkZWZp
bmVkIHZhbHVlIGZvciBNVFUuIFBsZWFzZSBsZWF2ZSAKPj4gdGhpcyBmaWVsZCBvdXQgaWYgZmVh
dHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIG5vdCBuZWdvdGlhdGVkLgo+IHNhbWUgYXMgYWJvdmUK
Pj4+ICvCoMKgwqAgZWxzZQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHZhbF91MTYgPSBfX3ZpcnRpbzE2
X3RvX2NwdSh0cnVlLCBjb25maWctPm10dSk7Cj4+PiArCj4+PiArwqDCoMKgIHJldHVybiBubGFf
cHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIHZhbF91MTYpOwo+Pj4gK30K
Pj4+ICsKPj4+ICtzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9tYWNfY29uZmlnX2ZpbGwoc3RydWN0
IHNrX2J1ZmYgKm1zZywgdTY0IAo+Pj4gZmVhdHVyZXMsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IHZpcnRpb19uZXRfY29uZmlnICpjb25m
aWcpCj4+PiArewo+Pj4gK8KgwqDCoCBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fTkVU
X0ZfTUFDKSkgPT0gMCkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+ICvCoMKgwqAg
ZWxzZQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybsKgIG5sYV9wdXQobXNnLCBWRFBBX0FUVFJf
REVWX05FVF9DRkdfTUFDQUREUiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2l6ZW9mKGNvbmZpZy0+bWFjKSwgY29uZmlnLT5tYWMpOwo+Pj4gK30KPj4+ICsKPj4+ICsKPj4+
IMKgIHN0YXRpYyBpbnQgdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldiwgCj4+PiBzdHJ1Y3Qgc2tfYnVmZiAqbXNnKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307Cj4+PiBAQCAtODIyLDE4ICs4
NDcsMTYgQEAgc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoc3RydWN0IAo+Pj4g
dmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCBza19idWZmICptcwo+Pj4gwqAgwqDCoMKgwqDCoCB2
ZHBhX2dldF9jb25maWdfdW5sb2NrZWQodmRldiwgMCwgJmNvbmZpZywgc2l6ZW9mKGNvbmZpZykp
Owo+Pj4gwqAgLcKgwqDCoCBpZiAobmxhX3B1dChtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19N
QUNBRERSLCAKPj4+IHNpemVvZihjb25maWcubWFjKSwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNvbmZpZy5tYWMpKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+
PiArwqDCoMKgIC8qCj4+PiArwqDCoMKgwqAgKiBBc3N1bWUgbGl0dGxlIGVuZGlhbiBmb3Igbm93
LCB1c2Vyc3BhY2UgY2FuIHR3ZWFrIHRoaXMgZm9yCj4+PiArwqDCoMKgwqAgKiBsZWdhY3kgZ3Vl
c3Qgc3VwcG9ydC4KPj4gWW91IGNhbiBsZWF2ZSBpdCBhcyBhIFRPRE8gZm9yIGtlcm5lbCAodmRw
YSBjb3JlIGxpbWl0YXRpb24pLCBidXQgCj4+IEFGQUlLIHRoZXJlJ3Mgbm90aGluZyB1c2Vyc3Bh
Y2UgbmVlZHMgdG8gZG8gdG8gaW5mZXIgdGhlIGVuZGlhbm5lc3MuIAo+PiBJTUhPIGl0J3MgdGhl
IGtlcm5lbCdzIGpvYiB0byBwcm92aWRlIGFuIGFic3RyYWN0aW9uIHJhdGhlciB0aGFuIHJlbHkg
Cj4+IG9uIHVzZXJzcGFjZSBndWVzc2luZyBpdC4KPiB3ZSBoYXZlIGRpc2N1c3NlZCBpdCBpbiBh
bm90aGVyIHRocmVhZCwgYW5kIHRoaXMgY29tbWVudCBpcyBzdWdnZXN0ZWQgCj4gYnkgTVNULgpD
YW4geW91IHByb3ZpZGUgdGhlIGNvbnRleHQgb3IgbGluaz8gSXQgc2hvdWxkbid0IHdvcmsgbGlr
ZSB0aGlzLCAKb3RoZXJ3aXNlIGl0IGlzIGJyZWFraW5nIHVBQkkuIEUuZy4gaG93IHdpbGwgYSBs
ZWdhY3kvQkUgc3VwcG9ydGluZyAKa2VybmVsL2RldmljZSBiZSBiYWNrd2FyZCBjb21wYXRpYmxl
IHdpdGggb2xkZXIgdmRwYSB0b29sICh3aGljaCBoYXMgCmtub3dsZWRnZSBvZiB0aGlzIGVuZGlh
bm5lc3MgaW1wbGljYXRpb24vYXNzdW1wdGlvbiBmcm9tIGRheSBvbmUpPwoKLVNpd2VpCgo+Pgo+
Pj4gK8KgwqDCoMKgICovCj4+PiArwqDCoMKgIHZhbF91MTYgPSBfX3ZpcnRpbzE2X3RvX2NwdSh0
cnVlLCBjb25maWcuc3RhdHVzKTsKPj4+IMKgIMKgwqDCoMKgwqAgdmFsX3UxNiA9IF9fdmlydGlv
MTZfdG9fY3B1KHRydWUsIGNvbmZpZy5zdGF0dXMpOwo+Pj4gwqDCoMKgwqDCoCBpZiAobmxhX3B1
dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9TVEFUVVMsIHZhbF91MTYpKQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+PiDCoCAtwqDCoMKgIHZhbF91MTYgPSBf
X3ZpcnRpbzE2X3RvX2NwdSh0cnVlLCBjb25maWcubXR1KTsKPj4+IC3CoMKgwqAgaWYgKG5sYV9w
dXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3UxNikpCj4+PiAtwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+IC0KPj4+IMKgwqDCoMKgwqAgZmVhdHVy
ZXNfZHJpdmVyID0gdmRldi0+Y29uZmlnLT5nZXRfZHJpdmVyX2ZlYXR1cmVzKHZkZXYpOwo+Pj4g
wqDCoMKgwqDCoCBpZiAobmxhX3B1dF91NjRfNjRiaXQobXNnLCBWRFBBX0FUVFJfREVWX05FR09U
SUFURURfRkVBVFVSRVMsIAo+Pj4gZmVhdHVyZXNfZHJpdmVyLAo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVkRQQV9BVFRSX1BBRCkpCj4+PiBAQCAtODQ2LDcgKzg2
OSwxMyBAQCBzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9jb25maWdfZmlsbChzdHJ1Y3QgCj4+PiB2
ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNrX2J1ZmYgKm1zCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBWRFBBX0FUVFJfUEFEKSkKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+Pj4gwqAgLcKgwqDCoCByZXR1cm4gdmRwYV9kZXZfbmV0
X21xX2NvbmZpZ19maWxsKHZkZXYsIG1zZywgCj4+PiBmZWF0dXJlc19kcml2ZXIsICZjb25maWcp
Owo+Pj4gK8KgwqDCoCBpZiAodmRwYV9kZXZfbmV0X21hY19jb25maWdfZmlsbChtc2csIGZlYXR1
cmVzX2RldmljZSwgJmNvbmZpZykpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0la
RTsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKHZkcGFfZGV2X25ldF9tdHVfY29uZmlnX2ZpbGwobXNn
LCBmZWF0dXJlc19kZXZpY2UsICZjb25maWcpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAt
RU1TR1NJWkU7Cj4+PiArCj4+PiArwqDCoMKgIHJldHVybiB2ZHBhX2Rldl9uZXRfbXFfY29uZmln
X2ZpbGwobXNnLCBmZWF0dXJlc19kZXZpY2UsICZjb25maWcpOwo+Pj4gwqAgfQo+Pj4gwqAgwqAg
c3RhdGljIGludAo+Pj4gQEAgLTkxNCw2ICs5NDMsMTEgQEAgc3RhdGljIGludCB2ZHBhX2ZpbGxf
c3RhdHNfcmVjKHN0cnVjdCAKPj4+IHZkcGFfZGV2aWNlICp2ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAq
bXNnLAo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIHZkcGFfZ2V0X2NvbmZpZ191bmxv
Y2tlZCh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4+PiDCoCArwqDCoMKgIC8q
Cj4+PiArwqDCoMKgwqAgKiBBc3N1bWUgbGl0dGxlIGVuZGlhbiBmb3Igbm93LCB1c2Vyc3BhY2Ug
Y2FuIHR3ZWFrIHRoaXMgZm9yCj4+PiArwqDCoMKgwqAgKiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydC4K
Pj4+ICvCoMKgwqDCoCAqLwo+Pj4gKwo+PiBEaXR0by4KPiBzYW1lIGFzIGFib3ZlCj4KPiBUaGFu
a3MKPj4KPj4gVGhhbmtzLAo+PiAtU2l3ZWkKPj4+IMKgwqDCoMKgwqAgbWF4X3ZxcCA9IF9fdmly
dGlvMTZfdG9fY3B1KHRydWUsIGNvbmZpZy5tYXhfdmlydHF1ZXVlX3BhaXJzKTsKPj4+IMKgwqDC
oMKgwqAgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAs
IG1heF92cXApKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Cj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
