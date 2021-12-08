Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D41C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 17:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70DDD409AD;
	Wed,  8 Dec 2021 17:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TfeGLWZ6RmHL; Wed,  8 Dec 2021 17:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0AE9F409A6;
	Wed,  8 Dec 2021 17:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEE9CC002F;
	Wed,  8 Dec 2021 17:35:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D10BC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 17:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEE5C403E7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 17:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="WVYYutnw";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="S6eWqlVY"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtXzgRGojlsJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 17:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E829B40196
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 17:35:47 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8HZhV5025581; 
 Wed, 8 Dec 2021 17:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Rheh4E/VrWPvFRbUsEzlTyDWI3UzOESSDjgN46q/ijg=;
 b=WVYYutnwALpGoMM+dAopQx8jPsxWGHVqs2rUxyQ6IRJcDcV5tsnAAs/QgS4X6TYvwFII
 p1wt4udnNhTTLgNRZr1BEkW8V+t5g+qVUmGG9L44MP1IKwgn8lCH/0JKn3LU2ztZxfTs
 2Hx/wozDAEKXZbfQX7Bc5XR80X1LOYEnHS78D66UsMvuTByZxkY3SSiy5b/z+Y/Y0A1q
 xUBd6S6S35ymhPtOJfWI0rhdfweuSbuzLJPQQsFE+L9VOVtQEVxtXZ0HfxFmU3T5jcf0
 yOMuBmhch/clelBE8u941/XLSIqIZGUSPKswe3Xm9ivJCoVjnYWM7kZPtDyF6XkY5JUs kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9ms5fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 17:35:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8HV235083915;
 Wed, 8 Dec 2021 17:35:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by userp3020.oracle.com with ESMTP id 3cr1sr2hu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 17:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEqUctS3qLY8dmH+ppYu8AZIAqk9er2BBi7S9pE4nWOlSuNYSXqFPOoHhUHj0PTA4zD3CySSEQUxe34EhA8us2zojaveTlvJ/7eNwCGJKfeLn+V5slvdM1J7jpsRQBV0C3zC5rrfS9TcJBGVH4LcbJF5yDsQN20UtxLdro/Aiz/hlmjHvD+LzCUMGscOGCWIlg0EiOARmQyRq6kaEZWAa8in/zJyWlQ7JdGoSfHHcnyoAYYOiXb+isGdhZXzuLhW7cmsUdOBuBNy1zkSkHbLTVNZ125SqmQRae1zJLSol1o+3ksoLQr3NZEEGh3+DDmwhS+PJ7rpgF7KPsPqy+X5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rheh4E/VrWPvFRbUsEzlTyDWI3UzOESSDjgN46q/ijg=;
 b=oXQ+Y3YWaUaJzfOzqvMXnuHbGvjxFbbmp6N6tapl4ZtyIU+035cMCYLz39EvgLuG5yDIoVJnscZP65S6XEtma1oKtdHZ0frwNXWwCdNfGnYchNvQbVvu41lALqvd/x1GHkQJWmgD6Feyyh45XNugzF2wuLt9/W2CinrpioV+ZJi+bBoPmZu4eL96CXt5Wx07CXoPnRZOS+t2WF7QpSdQaYAQYYtEh3Jm8BJdhJHXoDjTLW9cSHGwTZ53e5DyFI7eM4JN0qedQmogTbp9PijVxuR7kNGbcb3DR0j/uCwhVcVT+Mrkkt/RDum9J754u7dtl3pHkcCNjcVX/x4EkGYVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rheh4E/VrWPvFRbUsEzlTyDWI3UzOESSDjgN46q/ijg=;
 b=S6eWqlVYNM3RY3RlV1y8a3H7ikULAf3Elu8Fb8Kgy54CW4wgj5a88E62g97GBXI3TY6NCzCGfyVd780XaCmfG7CFXvbb9203DldyidYxRR2XSX9qNANFPh60YpqrJ0MlkpBOsxY5Peuy78Yiry07ftQ2OKJv/GEJs8QGSd6CSe8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2748.namprd10.prod.outlook.com (2603:10b6:5:b1::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 17:35:43 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 17:35:43 +0000
Message-ID: <6dfa3975-54a7-5389-b593-e6269681e94b@oracle.com>
Date: Wed, 8 Dec 2021 11:35:41 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 5/7] vhost_vsock: simplify vhost_vsock_flush()
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-6-michael.christie@oracle.com>
 <CACGkMEu20xRvunwv=h-rWhRcnmmn4rDPqp1uMKMSBrZrtixu9w@mail.gmail.com>
From: michael.christie@oracle.com
In-Reply-To: <CACGkMEu20xRvunwv=h-rWhRcnmmn4rDPqp1uMKMSBrZrtixu9w@mail.gmail.com>
X-ClientProxiedBy: CH0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:76::11) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.7] (73.88.28.6) by
 CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Wed, 8 Dec 2021 17:35:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 368e7c11-774a-4dc0-7be6-08d9ba7128e0
X-MS-TrafficTypeDiagnostic: DM6PR10MB2748:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2748819F93C8B0CD992AEDBFF16F9@DM6PR10MB2748.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMCGxMRnBC8y4b2r3u1ciQrUrlXiWD+sFf+p3/KbB6+2dgcRx/FiriVmP+hKc/GngS5i3rkSjyLEwnwZuLrZx3DjCq/Rw50ZnYKAxdqsEc365yYMCkJgizuUCZsmkQVVP3yU/TSpwTbVcWiwoc/Fb4DbbjL8kv2xdqYl2yamOzTNkzSBqv25V5X71E/itiy+saDZlytIChEuwJe+XMWDr/649YOA1wI9j0Jx9xylQpmBWh9jui5IZJM82NrdEJAw76COkOE7XVTcfJ7P7yeSqQS4AkYxjmQ3dZUYHZOp5/T6tudoCw6hzxGREmkW1uEYwRkexBWKcktLrtND+PQ4YprU1fKSg84IIMgkX40Een5xGzNtB+cCeM3JvivheCpFNQS975CYbO060Q00sVWiMpDK0cIyZghBc/bsAryQn1YP20B55nE4ED0b40MNpuYzMPAyl/KZHNwy/zkTbSQAc4z7oSBNGapDZejZ4hNKx0+v2MqNmCEFNeapY62cGinDSK/kDebstYMbZw0Q1Y4V7lydQQA5nocvnpMvIHiapkjRuUdPOFYzIz+Kf8JxS90tWh6lfRhY4canr0vYar1QOdPp0N95TmYocqvOxPDJ4gvfLuxjfYoPzPNslfFEA9tUI1XEYZZ/76U98+J2hzJUZ5h3OWXsx9Udqq0aj9F348UzmbNasIovPhHqhwAMxkak0RGj6WAaudRsCB20qUd3uBixDvXfq6oyIhA1UQpa+nY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(31686004)(186003)(6486002)(956004)(2616005)(53546011)(8676002)(36756003)(8936002)(66946007)(86362001)(26005)(31696002)(66476007)(66556008)(16576012)(4326008)(83380400001)(38100700002)(9686003)(6916009)(6706004)(5660300002)(54906003)(316002)(2906002)(78286007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnh6NHppV1FMNmxlUlFacUtpcDlDdVlyQkJHR0laZzF4R3BwVXRCWUNuZE44?=
 =?utf-8?B?emd3NXRYU3BMdHkwTVpuYVdhaWhtOGdHZmEzQTVIT0prU0VrY2FoNzgyNERo?=
 =?utf-8?B?dEJrWmZVOUkzSXNlby9FNnBaWm83VFpuOE9RdTFPQ1dRYTBVZnBUZnpwcGwv?=
 =?utf-8?B?M1c0eGVGaTBLK2ptbFNzcTBCNXEwY215a2doeWFYazNpMTdza0hBcTBMRy9m?=
 =?utf-8?B?S2NSVGlBSDhOaHFlYndxQk92MWE5MUMrNWd3MVZLbTBHTVZiNUI0Wnk1UlJ3?=
 =?utf-8?B?dHp2aUZIaFFZMkpuWnVvUVp2aFYvcFdRdEV3L3VuNmpqUUFQS0dFaFBEWmRE?=
 =?utf-8?B?SjYycUxUUFpkMllhMXJWYjFmNTQxamlDR1FVeVRmRytRbXNzR1lWbEFvdWVS?=
 =?utf-8?B?aDlhYkNpa2xYNVJOTkl5RUg5d1JmYXR4SHRtVHN0b3NTNUE1c0FiVlpHc1pZ?=
 =?utf-8?B?VDBTZy9YR1czRUFPWk8wd01Sd2VCajhLdFBxeUorUXdmVlpTMDZoTUZkNVdr?=
 =?utf-8?B?T2FkaTIreTNlR0ZhZmE4NzJVenlBMFFzS2UraHZNeVNBVHNPWUg3NUtKbFpY?=
 =?utf-8?B?WExmWE9ucHhaNUd0SHNKZ3EwS1BXc1VwSGx3ZHdWNkRqS3VCMDJzeDE1RVE5?=
 =?utf-8?B?bU5reXhNOVdrVkllbnVteVFqWkhCR1NjV3RNWUF5TWJDUUFZY2NWZ05TM3Q0?=
 =?utf-8?B?WUZ3UWhQYUppb3Vmd3o2RGdXdEFkbHJ6TDJXSTNDcmtOZlprcitHejFOZTlS?=
 =?utf-8?B?emwwTUJKMTAwUjAwTE0weUNrZnI4djBneDRuL25VdlA5QVVFTDRLRDBWc2da?=
 =?utf-8?B?dHludytsNUVkTGYxSWpKTUtTV2dlQ0gvNFU1aTg5WHcyU1U4enhveTY5SVp4?=
 =?utf-8?B?VHkyL3RQclJZNkFONUQ0bUdGWDFDQXgyUFc1OVBrcG9nRFNkNHBsejdqWjVO?=
 =?utf-8?B?ZlI3MkJvNkx1V3NmZ29PelUyYUt5ZDczNEFLbjVWelU4SnB0THBvclJOZ3p2?=
 =?utf-8?B?RDNTNXZBWmU3bUo5Mm5uV2hadzJJaEY4VmxUZWxhekhHL0htdnprWG5jUHp1?=
 =?utf-8?B?em94cFUvdkZBdVVOY1QrNGdBcFl5d21SMUM5bndUZ29aNkcyNGc2TnJSRWRZ?=
 =?utf-8?B?bUwwZ1FJOXBXQ2w1QURuTm1mb2Q0d1g2V3g3NHUxRnY4YkFPdTZ6RGI4STd0?=
 =?utf-8?B?K25NUG1hTTFNUjNhc0c5b0s0U3lNTlpnM2FQeVRqc1dIWk5tMkxuS3VYemoz?=
 =?utf-8?B?OUlCY21rd2FaYW9pcGsyQUplTVhlTndnUThLa3pVcURZdWdDd0JQTDh6Mjg5?=
 =?utf-8?B?M3FIVHppcDJuL1l3SXpEQmtlek54cnV6WGUycEZ0OEtTTlhoRFZ2U3ZLUzkx?=
 =?utf-8?B?WUVYYkpITWFEempZeHEvbHhtUlA0N2djVHErT2pPWndGdVltN0Y5TGVNejJ1?=
 =?utf-8?B?ZmVLOG9yUjVUazQ1Q1VFSXdDejRUVHV6dFp3ZVVwbEFRT2VrOXZaQzd2Vy9W?=
 =?utf-8?B?NzlTRU0rVWN1UTFWZWh0amVyN1MrV3BsWVFsaFdKbWtMUzEzNy9LdjUrWDhE?=
 =?utf-8?B?eTFhL0xDdU5XdGhsWld4Um5FbFR5RWVZS2MxcXAyU2grdG03VWp0Z0U0bWVv?=
 =?utf-8?B?VFZnY0MxWWp1Vm5aSHc3eUJVVHVncjc2ekdzUkx4WnRzNzJ0R3hMMVpYbUVt?=
 =?utf-8?B?emVwVmFkRjNWSXMyNXJDMDJ3YU9tSERGdk9aWkRaeGwrUnRXSmlMaVU0Wmxo?=
 =?utf-8?B?L0tUWktRMUtScVVwQWJxRXp1aHRnUlNqQVBuTFROZHRSR2lhaHZvT1NJeUR3?=
 =?utf-8?B?dkFLby9UcDF5NUhJWDAvZlJ4M1hyMjFTQXh1T0JkQjNON1preTBETk5HcUJK?=
 =?utf-8?B?N29pUXZJSUpnRTB4UHBVaEtoZ2lvQ1AzcFVWYjc3Zi9uaDV3endFRFl3MlNl?=
 =?utf-8?B?MTlSWFZXZzRCTDJPK2NtQmo2TGozdm9lcUdoS1ZBVEc3OHJDQndsTkJLN3I3?=
 =?utf-8?B?aGM5VmQrQUx0TEtYeUNlYmFCdmVIdXpPa3JscVkvK1RKYjN0cHJ5TmpXQUM2?=
 =?utf-8?B?RktrNHViY0NMb25pcVhTendrSkc5ZFpGSnZYS05uNk5LS1NnWGM5MU9od0h3?=
 =?utf-8?B?R2Q0NTdJSjFWb1Nvd0JZRDVOZExrV0tZdEJsYy9KbS9LN1oxN29XZ0hrKzdv?=
 =?utf-8?B?VDduSms2ZFhRaStGZ2EvaU5GRit4OEVsTVhRN0NWaVpVaU1EVVp0MWluZjJn?=
 =?utf-8?B?RTFyT0g0dm42Q3BhbStoUHBZQS93PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368e7c11-774a-4dc0-7be6-08d9ba7128e0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:35:43.0836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8cP0/x9Teu8msvCKeOqnNqPhqcEletQ4yqZjGXc8BTbVXS7dnO7RW2rj6beKxDifW/s01U/EUAJ+lmu5BAiC/+sQGRZAMcX3+P+oP9lcnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2748
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080100
X-Proofpoint-GUID: AllrqXyXv64KJNNgwhMUZ31VkcH3DVRR
X-Proofpoint-ORIG-GUID: AllrqXyXv64KJNNgwhMUZ31VkcH3DVRR
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 12/7/21 9:53 PM, Jason Wang wrote:
> On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> From: Andrey Ryabinin <arbn@yandex-team.com>
>>
>> vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
>> before vhost_work_dev_flush(&vsock->dev). This seems pointless
>> as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
>> in a row doesn't do anything useful, one is just enough.
>>
>> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  drivers/vhost/vsock.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 2339587bcd31..1f38160b249d 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -703,11 +703,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>>
>>  static void vhost_vsock_flush(struct vhost_vsock *vsock)
>>  {
>> -       int i;
>> -
>> -       for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
>> -               if (vsock->vqs[i].handle_kick)
>> -                       vhost_work_dev_flush(vsock->vqs[i].poll.dev);
>>         vhost_work_dev_flush(&vsock->dev);
>>  }
> 
> Is this better to be consistent with vhost-net so that we can simply
> remove the vhost_vsock_flush() wrapper here.
> 

I didn't understand that comment.

Did you mean consistent as they both have vhost_vsock/net_flush functions
or as in they prefer to not have one line wrappers?

Before and after this patchset, both net and vsock have a vhost_vsock/net_flush
function, so maybe you didn't mean that.

I think the wrapper is not very useful and could be removed. However,
I thought vsock preferred wrappers because we have vhost_vsock_free
which is just a wrapper around kfree. I also noticed test.c is a
fan of one line wrappers, but I see net and scsi do not do that.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
