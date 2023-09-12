Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B1CA0EC3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 00:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69A8141798;
	Tue, 12 Sep 2023 00:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69A8141798
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=O7JnQZLx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=CLLR1Arw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kdSJMVZey5xk; Tue, 12 Sep 2023 00:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D0F541732;
	Tue, 12 Sep 2023 00:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D0F541732
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C39C0039;
	Tue, 12 Sep 2023 00:34:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 806D2C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5145C6105F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5145C6105F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=O7JnQZLx; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=CLLR1Arw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0p-EV5HL5bs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:34:04 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D2D76102D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D2D76102D
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BJuEA0021351; Tue, 12 Sep 2023 00:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=huQcMGTE5G8FtHqVDsddIokFpWTbIIXTNM/l7PqtoAE=;
 b=O7JnQZLxcmfJZuAunZCqrG0Qy8W46eAeaDHouY8Z8sWOtDAMQivgSeijgk+2my5YCDkB
 9y8QksBcyOxAzPhmHKrzsagJ1JDErufNgEKBSW17Lr76BSJE1eMaf0rflPSgzBQ8eQdI
 hO+VIM+evYInj82T/OQeEyFLkjGT9mwjan7V/tQCdHcj1hFXu6wOPH7ZWVGsnLZDP8bf
 fBoSOYHZJeRQ7Jn0hu8GeNvg+F5OTdy5cDgRBu78+DF4ROHdhLZPp9kwBpg4A/z2Cgxg
 lp9TyRELl5Gha2xGr3K4rUi5oYwuvb8076tuK8e9Yqg4hoAGPEU+5/hEKf57uKvddxGw Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqtqjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 00:33:59 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38C07Unp023051; Tue, 12 Sep 2023 00:33:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f55863n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 00:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHy87PNnky+Bgxfa5ZoT70lTEiSIRHqI+bjYvShnlEmdXZ/baMQj5JNNujeK791D/VPTMndFy/cz2yNVcqtEYL/qO2PS1j32r6UX16+ar5Zgz5J89eiVecSjZDozzekBsXZd/iDU0OBCp+XEWPmpoe6Wv4ACe/202Gfeb0gKoDGb0t+wu5YgLzc6ZlDkby5OxnBSDODaRdlEg5bya0ulKCXnLWYenGjSfogdqAZefziHIoRgCmfhTD3N0VTksQ6V9qx4eDmzLsfs4Chzwv1oWtk26dETfvn8HpiaBzKTDnxl2U0LCmhqpntr7vAEHFKRuLWNpCISVz+gtcccjXPkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huQcMGTE5G8FtHqVDsddIokFpWTbIIXTNM/l7PqtoAE=;
 b=D1mJt3hCMupSLsxBu2RWGTrmQKleZZODzqYQ1IOXUdOxvbDplL4oTrFqTaTrrztDLg4tvM8N+p/HIt2yfHjhRGWoANYs+rFvDlqF5jlNdmoalX2MR+hokCP4sJuoYBTrS0XR2AjFKWTOTsZdG7bbGv4FqXtX+LzHmDvaEoiwauZAIjOEU7mL56F3tcFUK870R0sItRu2oiOoaMXtqj+QgWPFA4QXoJbMQeHJUrUWL2dsKVJz1dA/k4bOtYuSxf9QmHdhEvmziR4SyEhHvRqeqqRBQopG+pD1xcUmCL48blCJrb7H7LYWm4R9JZWHIYch7XKIJXuSK53PeFJmscD3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huQcMGTE5G8FtHqVDsddIokFpWTbIIXTNM/l7PqtoAE=;
 b=CLLR1ArwR1lSDCblT18cmAbI3Yd8rovZBA7scVItJWLsefgkWsNnmxUJO1zAa2B06nvTgE3SG05wswRTIeZNjhW7KAYVfSgzzfkteUKEUoKcjx+oA2bIVvAjVdsN/cn+LvsHEesRw0tQL0TMx17BdGqY+BohfJz6KxJm4/6rhfQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB6199.namprd10.prod.outlook.com (2603:10b6:8:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 00:33:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6745.035; Tue, 12 Sep 2023
 00:33:56 +0000
Message-ID: <d66a6bdf-e4c4-503c-fbd2-9299f0859127@oracle.com>
Date: Mon, 11 Sep 2023 17:33:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] vdpa: consume device_features parameter
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
 <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
 <060ee8d4-3b78-c360-ac36-3f6609a5da89@kernel.org>
 <b4014822-48af-ea9e-853f-0a0af3fc47ed@oracle.com>
 <27fa265e-eb89-7438-7796-9fc39bc63f5c@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <27fa265e-eb89-7438-7796-9fc39bc63f5c@kernel.org>
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d4f413-6979-489a-c3ab-08dbb327f2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYe51KIk0l19gcO1cf1OHydrO/3DXR8E2GhAo+7x/coMmMoabDHYqOr52MrK6FI49DlxroJBo1GxnQQVQd28D5OUn/aDZ2bh+fHagwqDghKa2v3gMipgC7IawtDvahPsxtpK5JTDB2WICrk5gQ3uNHPvHOUnR2Y38zx9UBhkyoMJIzbB0kaTTUVPMOaCEYzsusf7LNIN08bFueq3JUX5PH4B3Jyjni/AVKpvu17NOiuIC7vrMOpROBybC6L5shDIsvwR7MCD6pARo6ypTLJRsXNehtX3eecieyuhQ97F4AsvzCShGlbcxqr3oB2uSVk/MCWt9XfakNCr11gt5uhwxSh8VBqiN/pRoSvieaOo0AzZW05lxrs79ELKCkE/kmidLTIyFGMxmXMhcuUaV2xIDHQybud85+NgE97mcKrkwiiCXexAOx+eKAeu9vtj9/3ZBtoyjz86aOg201MaBq4mLYUwf1LuwbcAuibFHjvFFGYpyjADzidDprwAwQ8BeDwE7KA3ILka7+ICiQG22xWWOKYNbwrfJ9yoVrrT2p9QtvaKAkWBsbO2CIIvtBu4Fk6TRQPUczqcvcBF1+PTSz9aVN6sxVddwsOzKvjBCU1pmSHM46mkOv1iykhbtoz8SYBp2x676QWgBwRYg7aUXx5/dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(1800799009)(186009)(451199024)(53546011)(36916002)(6486002)(6506007)(6666004)(6512007)(478600001)(4744005)(2616005)(26005)(66476007)(66946007)(316002)(6916009)(66556008)(41300700001)(2906002)(5660300002)(8936002)(8676002)(36756003)(31696002)(86362001)(38100700002)(31686004)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWNzZGt0NGwvL2hYaTBqT1VZRHR4bkdyWkJ1UzlvWjZKcGlua3lSZ3FWbVMr?=
 =?utf-8?B?WWt6ekN4c29FVGF3R04wMUllK2ZGbzZibUR5bDFzcTRKcWxyVWoxa2t6b1JL?=
 =?utf-8?B?NjBFM2RzZGc0cjJQbGFEZHdUSjc5L3ZZU1ZmZWgwU3JZWkZNN1dJY3dFdXNY?=
 =?utf-8?B?bjlVUnZSdjRKMHZXTTNTYXhpWThMQlYyQmNjS2g4MmlMYzBFMitWT3lCQks2?=
 =?utf-8?B?NWVMWjQzKzhlRjVYaDhhOG5IbUQrby8ybWprUVk1WmxJSVhKeENEK0RHbVFQ?=
 =?utf-8?B?cTFJT3dxdms3Z2toTXNlZEUvNXlZNEpDMHEwVkRMRG1oVFN1Q0VFOFhKMnBq?=
 =?utf-8?B?M1YrcGFrak05amVwTDlxcWJRQWxxZ3VXN2VyTlluZzdHTmZ0YjBLNVlhYzZ2?=
 =?utf-8?B?dW0xSXd1eWtIK1NtSkdYWEVhQVF5RnplbTNhQnpPWjhCWjdQSnZIMUNkOHU4?=
 =?utf-8?B?T2ZMTmtyVkN3bXIwV3JvYWR0TlJkVkhjdjZGSkl3b29ST3RXWEVLdmhHSE9h?=
 =?utf-8?B?MkhHdnFaR2UvY3o1WGJWUm1XTUZGaW9PejF2WmNtNlVXMnVoT2N5R3ltVDJS?=
 =?utf-8?B?S3hSWEF6aUhHZ1U4TmpkTWx5K2RwTCtFcXM5dHFSZ2c3OFJJVzViRStHTGlH?=
 =?utf-8?B?eTNtd08wc3h0YW82K3c5SGN4VXRmVUdPZC9BdlFDYlVERjBmeFpFSzZRaWk3?=
 =?utf-8?B?b3BjRlpkQ2FJYkdubFg3dWxNRmJoRk9BakVmNUtYMGRXVngzaDFCQ0NJVmFt?=
 =?utf-8?B?dmpwYUFSWHlVcEJaS1pkcFVLNWk1aGdDNDJBakFUUzM5Q3hJVzJCTEZBc2or?=
 =?utf-8?B?ZlRuR21GclovOUxJbE5Db1NVVEZNUktDQjBCZlJTK2tDM3c5L1ZUTFo3Z09Z?=
 =?utf-8?B?eVNUTGMrdGZOajJ1d3RRdGVYUHgyblVtRTBseGljVDVLVmFLeGtwM2s5SERm?=
 =?utf-8?B?UjFvTXZTeVhHRmhoYkQ0QnM1MmxQZk1vN0hSOVZlMWloOHEzT0huTmxTaDdD?=
 =?utf-8?B?VHNQdlh2K01QMkp4ZXhORjg5RzloYTJFcXEyelB3WG84OE40MVN1aFhVK0o0?=
 =?utf-8?B?L2VHdE8zY3N4NjZwTnlSVGQ2QzQ4SzE2YVpnOXJha2REN3FlRlRuMTIxNERL?=
 =?utf-8?B?WXExRTRXVTVBSGN1andabUFWUDJVbUpsWVh2SHJWM01FV1QwMEsxR2xrODc5?=
 =?utf-8?B?blNCTWNHNUhoYWw5Y2MxTFRMUFpNRnNUQTZCVVFyTW9FS3RnZ1QxWk5VWDhN?=
 =?utf-8?B?ekZUQzZzV1FhNk8wSzhPLzJ1QVMxb3VsR2xBSkdGQmZaOFlDSEl1alBhZENF?=
 =?utf-8?B?UVluM1JoYmhzdWpVZVJBUmdBYTYraXMxTmlJOVN6dUYxL25RZC9lUmIyWXpt?=
 =?utf-8?B?VjNaMUNHTVlGcytBSzFkOGNMTFJDeWdzdHdXcE5TZ1dFMnVrK3lOZDViMjFL?=
 =?utf-8?B?YzRVLyt0ZEFtallJRUl3cUgveXp6RXJ5SE9sb1BHeEdUNlVaREhHYTBOcUlK?=
 =?utf-8?B?MlU4U2JNd1JBNDN5SG9taUlWQ3Z3VHZGQmJrTXQ0dG5teDZkWnp6Szhkc2R3?=
 =?utf-8?B?WmVVazAvY3REVkVaV2s4b3BHUm1WYnBnSk51aGhxVEVrRFBETUZQMkE4bEp3?=
 =?utf-8?B?cjJKM2o0KzB1TTZOd25hNW1hZjQvQ2xJM2VFcHRGTWQ4eGd3VXVncDRxRFk0?=
 =?utf-8?B?MlF0QU8yOWtwL295cFNLTHFSTHhxN0xGZzkxaUJ5NG9VdytxODBrOUtLN2E3?=
 =?utf-8?B?WjdBalIybzgvWFUwN1BNSVdWZUJBd3ZjNUVQRTJIWWU1RUtTRkgrOWh3SWZz?=
 =?utf-8?B?QzJlMklOUmZiRmFjYk5Zc3lLUHprNEJMNFpjMlRmYWVhcXpINThkdVdjOExk?=
 =?utf-8?B?NGt3d0FnUEFyVWFSbVJ0TGJRTHpua1gwUHhhRUZaSUFBTTBhVC9uRDNMd2pw?=
 =?utf-8?B?ckJ5Q1Arbk9vRURUZ1Y1Zldmbmx6aGFlSCtsdGhNclpITERZVnl3TWVSbFBT?=
 =?utf-8?B?TDhicXFOR3FwWVNQbnovUndIZmpUM2liaUpuK3lFSkp2UzVXYmdmdnZHcUpx?=
 =?utf-8?B?ZlN4MEFLcmV2T1E3a0tmaENHeVlqblVvYUZVUFAvQzlYYjNmVEdZT1NWa3JD?=
 =?utf-8?Q?+LcyXjSZO8kSBX8qqrzud13QD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWJ6TVhodGZRdU9DMzUrVHdIbGlrMU53TzVsODNLd2pmLytQMWtTVHRyZWs2?=
 =?utf-8?B?M3pLc3hZYnlIN1FMaUtwWEhRSzlSWFNITVhlb3lkTXc5aXVpTEZ5cjlOVE40?=
 =?utf-8?B?RkZQRlh6em14UlloU1dHTUtCOU9uVjAzNVdwcTkyaEFVbVVVUG1sZUsxVkV3?=
 =?utf-8?B?ZUZUNEl1Y1Bnb1doT1EzOUt2aDFpTnoxNGJQMmZueXdSZ0RkejVITFdWTHJT?=
 =?utf-8?B?VXREUGczNHFWYVQ4QTVSTlRCN0xGUE9haE5RbXFZSkd1OUNERDZKZ0JXWmNx?=
 =?utf-8?B?QjF5djNBK0FtN1lMMVNMeEhwRG1SMjBQRUhzSFBjaU5sVHZuVTU1UlFHb21Y?=
 =?utf-8?B?WS9QVkQ3dnR0VUlNdGF6M0JsTTR0UWpPOEkzeGFKWUdhYU1DOHcxWnRpai9N?=
 =?utf-8?B?NVJGVnZ6TVAyUkhEUFpTYUJnOWdyeENCbk83WnU0SnBVMGlYZENJSU1WMHd0?=
 =?utf-8?B?b2NnY1BPcXBtcnRGdUdoL0J5K0daU250bjhBREJtenFsUGZsY1VGd0lTeDg5?=
 =?utf-8?B?TTl2YVVZZlJVazUrcFV4eU1KTVNXU3JzUXBkWkorYVhUQ00rRDcyTGd5RXRa?=
 =?utf-8?B?ME95RWdYbmRkTUZtUjE0RE0wa2xqbGlQTVk5TWQ5UXpnNHlqQzlWTGpuQThr?=
 =?utf-8?B?RWw1ZDlqZVY5N0pDOXRkTVVkeUxZUUNoMlZDOG84WEovcGxVc2g5djFnVElm?=
 =?utf-8?B?THBxZWNpQkgzSG5kSzYwTHRudUxoZ0k2S1JOVGNpeG9BMXkxOGVsRVgyVWt3?=
 =?utf-8?B?aHFBbk5GU2cycnZpQ3ZlQUpKeXNpMUpIUFRycnJ0SUR0T0JGY25wdVB2aHpN?=
 =?utf-8?B?TWplbmQwNC93b1NCNDlydm1XOGpPY3cwbUJCT1Y4aUFJY0VxbWZ3UFk1ZXAy?=
 =?utf-8?B?VDdFaXhKVkZMSXE3eUlMeUNEaDBTQVJ2Y2JNQVRDTHVKb2NWQkY0WVFoc1Qz?=
 =?utf-8?B?R3pYL2UyVGRxRDNkK0xGYkF3RUtUUUF5aHBOa2hvOXluczhLTnRQbml3eTJz?=
 =?utf-8?B?RWU5T3dDV1N3VndBU3BkQ21BSlhZRzlmQ0hvS3cwSUY2MXV1dUI5b1JRUFZn?=
 =?utf-8?B?NmFvMXlvbTdtV0dWRGZKTTY3UUFtcTN6SHp5SnBvbGp3N2ZDcm5nQ3JmeDdU?=
 =?utf-8?B?Z3Z6OElhb2ZtS2pTU1gxS0hrTDJvVDlRVjNzY09BcmU2aTVKQkpxU2ZGMDVT?=
 =?utf-8?B?TGd2MWNGand2dktWUlNsaEx4dldzelZGSEozbTdkSFpDYmxNRWd1c0dLR0JI?=
 =?utf-8?Q?B+NRkhdUObux3IF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d4f413-6979-489a-c3ab-08dbb327f2d2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 00:33:56.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJhgJfIzp4C4d/2acJupuR7CSK65OeNL3JV6QySEa6Q1Yoab5zDwKOSVnB9/tngBNMwroWBnxSYKOkk1R2zkYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=735 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120003
X-Proofpoint-ORIG-GUID: Ccy5EEhX8FKF5uxXX2skos9IeeN9zg3I
X-Proofpoint-GUID: Ccy5EEhX8FKF5uxXX2skos9IeeN9zg3I
Cc: mst@redhat.com, allen.hubbe@amd.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Thanks David, for clarifications. Now I see the patch just got posted by 
Shannon (thanks!) with the correct iproute2 label in the subject line. 
We may expect to see this land on iproute2 repo soon?

Thanks!
-Siwei

On 9/9/2023 1:36 PM, David Ahern wrote:
> On 9/8/23 12:37 PM, Si-Wei Liu wrote:
>> Just out of my own curiosity, the patch is not applicable simply because
>> the iproute2 was missing from the subject, or the code base somehow got
> most likely missing the iproute2 label in the Subject line
>
>> changed that isn't aligned with the patch any more?
>>
>> Thanks,
>> -Siwei

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
