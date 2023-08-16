Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBC4C2FC02
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 23:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9CC7613A0;
	Wed, 16 Aug 2023 23:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9CC7613A0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=AnCAM/BE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=tqYWPD4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNTd7WhsVfEk; Wed, 16 Aug 2023 23:44:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08E2461339;
	Wed, 16 Aug 2023 23:44:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08E2461339
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC57C0072;
	Wed, 16 Aug 2023 23:44:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE59C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 23:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1767283B1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 23:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1767283B1D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=AnCAM/BE; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=tqYWPD4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s5gV6zDY9WvD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 23:44:05 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 508C6834C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 23:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 508C6834C6
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GNfBb0032201; Wed, 16 Aug 2023 23:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4n0asc9xpFYyQECFHNPgd3qjtAaJtO4WP5RzeEVG+u0=;
 b=AnCAM/BEJN5F0ZEhxgfOk09VfSkJoEOFrOQeqYaqcCELUC6fC57jxMdX/wns+AghdNoR
 YaIEc9Od7QRuUwP7okewnUkVIx27a6NejOs9qikn/9/J2RR91QIuh/NtwsMctejt/o44
 iVtHXq0Hgs1ljnaWDalgvn3gw1s38UFUC7491E37DE3vQ9/M5opLa9BTGyfStnj6TOk4
 IeoJeH26xnKqnmoCrjHZll2TavQ0CPNtJa7LhkSomFqXxWK5zbAZgN5Xu/Crr0FARjCk
 0OdBxAE4oSdKYafVVhSGcV6OnkF2VEZF1u3zLd8odmure0r56OUtdHF41+7IdVtGwQoB aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwrca4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 23:44:01 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37GLACBE019811; Wed, 16 Aug 2023 23:44:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey3xdrry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 23:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLfsB7hzMxmUdmih8dGIxKT3xbxrM6qmaxWfs53eKSseg+lZo/XdWFPQrZGx6y/CK/7l6Qa4IrfR6T2NmFRQeli9r+PQbCi8YdBbo4a/as2M4L2jfRu1uc3A3cqQ9E8c71qMcCVgWYk20PA4iY9501SJK+fkZ2sVXCETgoPbcOsj1swxuue0S4v14HrojVXZUOT/15cIKVEcSIOQjVy3T4yBIZ19p+4K7Qagdev7fmeYLUG1ZYA3XmKK8yZR1fxYo/ozg+Lji2XqOtjPMnpNKj0lWxgnp9gF7Ep3UPeNWJDn+Z124tUyudi8cNhL5IreapZuygaEk2r1jngO01grgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n0asc9xpFYyQECFHNPgd3qjtAaJtO4WP5RzeEVG+u0=;
 b=JB71q3lrorVV05JcOo4mgvsp8FptiC264hlOPiDrE5wBZNe5wcN3tmOV7XdIUBLnfn5QG5FR4WO5sxgja84RFtI8MG0/aUqtBuWeN4DvaGIh819OS5iluVHgEswWFWVRLQVTUdEUUMZlZSNd9Le+XABF2+ZSKCIaplwLsbpLMzAVk+RNtsbnjhjSuIZusql7sS8ORhLLbaSEocRy2l+ZoXdi4jslx80jq12gnZ362520m2cQXL6Y/O58N+SrmqfjghIyvURUeHtMaw3l+xYGeVmLzQ16NknqwCnoeLeHNExJC0J53285Ovdjdi/Kjm+dPbbVQ3E4XoXYkVIRPUZ3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n0asc9xpFYyQECFHNPgd3qjtAaJtO4WP5RzeEVG+u0=;
 b=tqYWPD4bMI53XZKeeW3qfn7ITXuYGdo17oyQOysFOuGza3SB2iGeTPV6N4Eq77R7MVx+BhNSve7XYZrAD6HTG7upNAJyaV99TrMOOQ+g9XD9y35PzQQ9tAHAnYS07agQEXtvXbLUYKVhPtM9xKlOL7FJ7k3Xcd7x6RlTtMFPsYg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 23:43:57 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 23:43:57 +0000
Message-ID: <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
Date: Wed, 16 Aug 2023 16:43:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
 <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:806:d0::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cddc83-2f89-46b0-6c19-08db9eb2a895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uN6YoKVtZMIRPLu34rFTR6gmDaaqrfg0acHlSLiDOacOZ+3j25cbM+/WwN3jfr5jOoVIhTLmJwxkThOqAvyGw6by0dRxasUqYfyw1z8Uz8pJbJvEGxhO5PG/WKJv5svgvc80x/yui0A9soe4yEqxiOe9kpFNA7YOvaWQ6ohxCOz5P3KlWxSxeIq5JbncE+lU36LZN6oUwc5Q5LXfsFbNuJ+PaugKUrdhgxU6iFQy0QPMU4v9h+hNZ0ow6yWtY0XX/d9xlmFoizk6vNvC5Nqk8wXRHGmpqMdTh+I/Up+PRdbuE+U1kK617BC4RAdKWslKTgfxco/ztjadnJx9OVNtJ45B5RtjenDZ3JGvRRpwvQegaJO5yOhvZMx+pcwlX45ubDl+6HRaWjBdnPbzzZhkTHA+nvJ4FLJVpq3/q1aCxgMSPvCv5cM3ks2MV1lvWp0BiBWhi77ag50qVQ930S2zVZbm9oLYAq/aYzGLEW3MYgyFARUWiXQClCD/Z0ZlvmH+1/4qMFW1ZX9LZQIWTBuIecIXQvtPuWNhjGBoSMN+BEpSL9k/ck2qKArROiVrPOMjDeE2cFeWt2V5ZSJHQRh51ElJBNnU0kdKZx6+VbUDwts9LUZdalRPjr8WknPltN7DJ3s1fO8H1R6/e5bszhxmbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(31686004)(5660300002)(41300700001)(38100700002)(8676002)(4326008)(8936002)(66899024)(2906002)(83380400001)(26005)(478600001)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(36916002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29KQ1o1SnlHeTU0eDd3dDJ5eE9IcDlGSmRwYXZXckQ0bUJMdTNhYVFYVk8r?=
 =?utf-8?B?UW1OQWp5Rk1kNzdHc0VWdGQ3TU9rck9xWFJYWUpsVmpFS3ZkbTFNbmhSeS9U?=
 =?utf-8?B?MnJsdTJCUjArVnBLMTQ2V2N3NEdPaWY3NWVHSHExU0hlaWNTQWVtZ1IrcXlK?=
 =?utf-8?B?WFRzY2t1ZUZkRVM4dUV3STFYZGhESjBMa1ZGNmpHT0I3cmNQMndKcVU5VlRB?=
 =?utf-8?B?Rng5cUdwaFBkZ1kvNEtHaXBkQkwvejAwZFB2YmR1a3ZHcURvZGJ6MjZlRFBY?=
 =?utf-8?B?WGl6Ym5NUURlS1lXWDV4VWp3cU9ma0Vad1NURGFQdG9pWVdxL2JBdUgvK0JC?=
 =?utf-8?B?MHVuTmMzb1FlMVRWcjBQSXhWRnliMWRWM0ovREhEWllBaEhKQWgyUDhEclpa?=
 =?utf-8?B?R3VWV2c1SWZSanE1VFVRejJCaGhYUFlMR3hXMW1QbG5MRVNXcFk3QW1jak9s?=
 =?utf-8?B?ZFFrWkVud3gxb1VSSHl0cHJaMTJlOTg4R2dQM0dLalZqSDNrRlhRSnRrQXQ3?=
 =?utf-8?B?MW5QN3E5MWlWSnZuajNYZEhvSFFpZGF6NGZIVDh3SlFqMys1QlNIRTN3OC9U?=
 =?utf-8?B?endjekFpaTNqbDhQQ3R4aEUxRENOblZGYkNtdHh6S1UvSDY5SzA4VEs3L0cy?=
 =?utf-8?B?WDV0cmlucy85T2c4bW5iMHdXZjY0NkZ1aThRcW5RbWpBYUFCQWFCRHh0S3VI?=
 =?utf-8?B?NkRsOTRwa3AvK0FKOWhxNCtJY0lFU1N2NUNKVEo3Q052TVBaZEZkY0FaYUxL?=
 =?utf-8?B?UGI5cnlRNGlONFRXd2ZJVlhzZFdvS0tKOTRRQlg5eTNoMUUzaXFKMXAxc0Rm?=
 =?utf-8?B?em5NTk9mSGY1MWtMZmxYbWJtTFpJenJuMk9GSUZPeHp4djN2akRNN0loRHZK?=
 =?utf-8?B?NmxRUkdFZGJrc1FyYy9GR1RqZUlxcGl2aTFIazk2eVZvdjYxSkp5ZnRLbnVZ?=
 =?utf-8?B?UnBIV2kwUlhjWXZKL09LNlpUY01HVnFTOThCTjFCV01zb2JhQ1lOU2RCZXdi?=
 =?utf-8?B?bi90VXF0TEt3MzJ0bEU1cGp2ZTlObkg3NEFJVTdKNS80L2Z1MVhWdXZER3RG?=
 =?utf-8?B?bzF4TE5sOTYzTHB1dWszY1c1Z2NoNjlSak9GTDliSHRhMENaNXhtWXM3M1lp?=
 =?utf-8?B?Unp1ODh4alppQWdGeENvZVhlZ2puUWZlWDVpcFhQSGpjZk44RGQrT1BYU1Fx?=
 =?utf-8?B?Yk9SUzFJRHdNRUpJeEJuRDJxVHYydllOZXFOTWUzZVhrL25pdXpGSkFZTElN?=
 =?utf-8?B?Qy9CMmoxeTNKN0J5dDMvNzJnMTRxbjhPTGdUNlBnNEZ0Y2pYSWNVRGErV1RS?=
 =?utf-8?B?aWJYRHo2Y1RUbUJMeFhhdk5qKzhxRnJDbldmNDNHbmVVM1AzU3crdVREQWhI?=
 =?utf-8?B?SHprSUg2QUNTdUpnTE80UHVDY2JBeG1BV2RzLzlxajlRU3J5ZVpucFZJdVRr?=
 =?utf-8?B?VjNiQWc3YUV3M2Y1Qm0rMkxZSDNOYmVRNkszb1dnWElhTmZtamJQYU1xRkJo?=
 =?utf-8?B?NEVhb3lqcnQ4MUNqUlNkK0N3NmcrMzNpQ1VEWk5qdGovUitkMjNqV0pWaGFr?=
 =?utf-8?B?Uk9ucXNUS2pic3NEdno0aW1saU4wcWsraHkwdWpmTGtBK2pyTFg5dE5HU0dE?=
 =?utf-8?B?STB2eG8wWTNjMEFIekM1THJKSngxai9vbUJxYWsxQWpJTjRJcTB2bE4zWVhB?=
 =?utf-8?B?V25DKzJkUDBYNE9McXptbWV4MmJ2STdvSEdtZHRMMWNGV0hwU09UVFRydGNs?=
 =?utf-8?B?SzFCV0Z2WUlWOTZFOE12S0krTHJnbWxXa2tlcFNxUUppNUFlQ1YySWpCY1JH?=
 =?utf-8?B?azRnOFBjZWFxMkZVNEdoZDhZZlJuNFl4Uks2RldLWDh2b2NTQmtPV3Z4NzZQ?=
 =?utf-8?B?cnRDcjJad2tud28ydEcrOUFSM2xWKytTcUVrdnF1ay9xRGNaeStqVm8rWDZU?=
 =?utf-8?B?M0I5VmlFWDJjYkM3TGJDU2lxRnBUWjduQVJJREpFU0U0QzZKVnZqUzlnU0pJ?=
 =?utf-8?B?U0pvbUZ5UGlJMkhUaU9VNjhrZitIMmROWWtUZ2oxQ29ER2FKVkg1ayt3QjlF?=
 =?utf-8?B?cWlCb0dnYzV3a0ZQbG9RWU1Dck9rY1BqSWdZOUM4Y0p2alhTeGFIdEl6emhw?=
 =?utf-8?Q?ACTdSM1YynOOJBCPw41l5i3FE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a0gvQUwzODZvUkxWYmtzK21lMCtRUFhTN0lBU2YwZzM1QkJ4amFRYWQwVXcz?=
 =?utf-8?B?WW1OelBqZzIyRG9qRFp5ZFRRRUNmelNBZXBxbmsyZ0wyTUd3MC9yZHpNSkdU?=
 =?utf-8?B?dUlWcktjVE1Ubm5JMkdqbUNHSjZRclZndGpOb3dIdy9EMlZhLzVEcGxLM0lT?=
 =?utf-8?B?aEdMNDlEZElOTkFxcGkzd0prelNNTzdQTklvdEJGN2dXZDhxRGdLODZqQ2FW?=
 =?utf-8?B?NkhPUlQwcjduRHZYMml6cktzdFhKZ0VQNHRET1BZdnB4WG04U3ViTlJWVlhP?=
 =?utf-8?B?WHdSMnBING1kODNteXNCWXVBLzhYTHRvSDdKczM4azVmc1VxNlFCaEo3NU9Z?=
 =?utf-8?B?VGZjdituTEJvZHQ3S2hEbTZ0bXhrNWZkdEkxTnhER3F5RWF0bkQyN3cvVE04?=
 =?utf-8?B?aXpkZzhES1dHSjE3VkY4aXB3QWtQMCtwd1JxNDdiZTduRGtOWHZkVXNxNzF4?=
 =?utf-8?B?NDhiaUJVc3JGNnRzNi9mNG42WVVmTmp3dGl2ZmZoMlhmSjRvWGlKZ1Btbnln?=
 =?utf-8?B?MGhWZUYvOGZhbkxEWFZSVGc3VG9nU2ZRSUhQQ0R6SnNwYlJFa0tBTCtJdms2?=
 =?utf-8?B?MXA4ZkRqM0E2b3AzRkxyZTAzLy9LRFVMUmt5enpTbDh4bU0ybC9wNlVPS1BH?=
 =?utf-8?B?Y2RIajN3WWdWRWhQdERNbGNZcldLV09QZVArcUdaaENlc3ZRNXFSNnNNRk41?=
 =?utf-8?B?TlI5Zy9yTXFYK0ZSb3dwM1d2cU94OEl4cW9TZTg5SVBITmFraWJNSnhaQVZE?=
 =?utf-8?B?UG8vZE4ySHd4QlBhS2F0Z2tURGZjR0I5V1lOZEVneTBrOTU3ZjJTYnJRWmpi?=
 =?utf-8?B?SFlsMWIyclhJcXhtdlpFZjhEbERvT1lUSEtJcUJ3OFJtUzVaN1ZYcU8raWox?=
 =?utf-8?B?bE1aa2J5T2F6S1pqMDh2UGpSNkthNS9KSGpIY3gyVEVoZElCUFZ3a0NOc1Nn?=
 =?utf-8?B?QldaZDQyKzVjREtoYTVWdHJtVTZkK2VoRkNTMW5tL1BZdDd6TU42MEhOaTJW?=
 =?utf-8?B?VU1YUzZqWWpVZThyRUM2T1IrV0luOVZrWG4vNTdKbEVCUDNwTWFPMEVjSDBo?=
 =?utf-8?B?QmMwSEUxeUEvZVFhTHNlQm1qeS9vTlBDUmlSVnoveWF5MEJXL2xoaHE1cUJl?=
 =?utf-8?B?TG5qdDBtakszc3NsbmJRSU9BQmlCZ0drVE5ZbnBpRVUwVVp1ZHY2UUU5V3o2?=
 =?utf-8?B?RzUvM013d3hra29HcS92dmlRS0ZobVJ4TEt3TWpYWFQrdHpoQkNDeW4vUkJ3?=
 =?utf-8?Q?VcBfuNrYXMjK0TT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cddc83-2f89-46b0-6c19-08db9eb2a895
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:43:57.5578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEhZLD0dEdIi8Gx+zuUhxeh736qPrJM/mzR+emKw6Wc10BFEx1vBMwwQoRAZTmhm2RQme1u3uaatcXyDTHGs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160211
X-Proofpoint-ORIG-GUID: N2p5B5u87rKUvq2TItfpccl12uZc1cJh
X-Proofpoint-GUID: N2p5B5u87rKUvq2TItfpccl12uZc1cJh
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

CgpPbiA4LzE1LzIwMjMgNjo0OCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBXZWQsIEF1ZyAx
NiwgMjAyMyBhdCA2OjMx4oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3
cm90ZToKPj4KPj4KPj4gT24gOC8xNC8yMDIzIDc6MjUgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+
PiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCA5OjQ14oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxp
dUBvcmFjbGUuY29tPiB3cm90ZToKPj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy92aG9zdC92ZHBhLmMg
ICAgICAgICAgICAgfCAxNiArKysrKysrKysrKysrKystCj4+Pj4gICAgaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0X3R5cGVzLmggfCAgMiArKwo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+PiBpbmRleCA2MmIwYTAxLi43
NTA5MmE3IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4gKysrIGIv
ZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+PiBAQCAtNDA2LDYgKzQwNiwxNCBAQCBzdGF0aWMgYm9v
bCB2aG9zdF92ZHBhX2Nhbl9yZXN1bWUoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4+Pj4g
ICAgICAgICAgIHJldHVybiBvcHMtPnJlc3VtZTsKPj4+PiAgICB9Cj4+Pj4KPj4+PiArc3RhdGlj
IGJvb2wgdmhvc3RfdmRwYV9oYXNfcGVyc2lzdGVudF9tYXAoY29uc3Qgc3RydWN0IHZob3N0X3Zk
cGEgKnYpCj4+Pj4gK3sKPj4+PiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYt
PnZkcGE7Cj4+Pj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2
ZHBhLT5jb25maWc7Cj4+Pj4gKwo+Pj4+ICsgICAgICAgcmV0dXJuICghb3BzLT5zZXRfbWFwICYm
ICFvcHMtPmRtYV9tYXApIHx8IG9wcy0+cmVzZXRfbWFwOwo+Pj4gU28gdGhpcyBtZWFucyB0aGUg
SU9UTEIvSU9NTVUgbWFwcGluZ3MgaGF2ZSBhbHJlYWR5IGJlZW4gZGVjb3VwbGVkCj4+PiBmcm9t
IHRoZSB2ZHBhIHJlc2V0Lgo+PiBOb3QgaW4gdGhlIHNlbnNlIG9mIEFQSSwgaXQnIGJlZW4gY291
cGxlZCBzaW5jZSBkYXkgb25lIGZyb20gdGhlCj4+IGltcGxlbWVudGF0aW9ucyBvZiBldmVyeSBv
bi1jaGlwIElPTU1VIHBhcmVudCBkcml2ZXIsIG5hbWVseSBtbHg1X3ZkcGEKPj4gYW5kIHZkcGFf
c2ltLiBCZWNhdXNlIG9mIHRoYXQsIGxhdGVyIG9uIHRoZSAoaW1wcm9wZXIpIHN1cHBvcnQgZm9y
Cj4+IHZpcnRpby12ZHBhLCBmcm9tIGNvbW1pdCA2ZjUzMTJmODAxODMgKCJ2ZHBhL21seDU6IEFk
ZCBzdXBwb3J0IGZvcgo+PiBydW5uaW5nIHdpdGggdmlydGlvX3ZkcGEiKSBhbmQgNmMzZDMyOWU2
NDg2ICgidmRwYV9zaW06IGdldCByaWQgb2YgRE1BCj4+IG9wcyIpIG1pc3VzZWQgdGhlIC5yZXNl
dCgpIG9wIHRvIHJlYWxpemUgMToxIG1hcHBpbmcsIHJlbmRlcmluZyBzdHJvbmcKPj4gY291cGxp
bmcgYmV0d2VlbiBkZXZpY2UgcmVzZXQgYW5kIHJlc2V0IG9mIGlvdGxiIG1hcHBpbmdzLiBUaGlz
IHNlcmllcwo+PiB0cnkgdG8gcmVjdGlmeSB0aGF0IGltcGxlbWVudGF0aW9uIGRlZmljaWVuY3ks
IHdoaWxlIGtlZXAgdXNlcnNwYWNlCj4+IGNvbnRpbnVpbmcgdG8gd29yayB3aXRoIG9sZGVyIGtl
cm5lbCBiZWhhdmlvci4KPj4KPj4+ICAgIFNvIGl0IHNob3VsZCBoYXZlIGJlZW4gbm90aWNlZCBi
eSB0aGUgdXNlcnNwYWNlLgo+PiBZZXMsIHVzZXJzcGFjZSBoYWQgbm90aWNlZCB0aGlzIG5vLWNo
aXAgSU9NTVUgZGlzY3JlcGFuY3kgc2luY2UgZGF5IG9uZQo+PiBJIHN1cHBvc2UuIFVuZm9ydHVu
YXRlbHkgdGhlcmUncyBhbHJlYWR5IGNvZGUgaW4gdXNlcnNwYWNlIHdpdGggdGhpcwo+PiBhc3N1
bXB0aW9uIGluIG1pbmQgdGhhdCBwcm9hY3RpdmVseSB0ZWFycyBkb3duIGFuZCBzZXRzIHVwIGlv
dGxiIG1hcHBpbmcKPj4gYXJvdW5kIHZkcGEgZGV2aWNlIHJlc2V0Li4uCj4+PiBJIGd1ZXNzIHdl
IGNhbiBqdXN0IGZpeCB0aGUgc2ltdWxhdG9yIGFuZCBtbHg1IHRoZW4gd2UgYXJlIGZpbmU/Cj4+
IE9ubHkgSUYgd2UgZG9uJ3QgY2FyZSBhYm91dCBydW5uaW5nIG5ldyBRRU1VIG9uIG9sZGVyIGtl
cm5lbHMgd2l0aAo+PiBmbGF3ZWQgb24tY2hpcCBpb21tdSBiZWhhdmlvciBhcm91bmQgcmVzZXQu
IEJ1dCB0aGF0J3MgYSBiaWcgSUYuLi4KPiBTbyB3aGF0IEkgbWVhbnQgaXM6Cj4KPiBVc2Vyc3Bh
Y2UgZG9lc24ndCBrbm93IHdoZXRoZXIgdGhlIHZlbmRvciBzcGVjaWZpYyBtYXBwaW5ncyAoc2V0
X21hcCkKPiBhcmUgcmVxdWlyZWQgb3Igbm90LiBBbmQgaW4gdGhlIGltcGxlbWVudGF0aW9uIG9m
IHZob3N0X3ZkcGEsIGlmCj4gcGxhdGZvcm0gSU9NTVUgaXMgdXNlZCwgdGhlIG1hcHBpbmdzIGFy
ZSBkZWNvdXBsZWQgZnJvbSB0aGUgcmVzZXQuIFNvCj4gaWYgdGhlIFFlbXUgd29ya3Mgd2l0aCBw
YXJlbnRzIHdpdGggcGxhdGZvcm0gSU9NTVUgaXQgbWVhbnMgUWVtdSBjYW4KPiB3b3JrIGlmIHdl
IGp1c3QgZGVjb3VwbGUgdmVuZG9yIHNwZWNpZmljIG1hcHBpbmdzIGZyb20gdGhlIHBhcmVudHMK
PiB0aGF0IHVzZXMgc2V0X21hcC4KSSB3YXMgYXdhcmUgb2YgdGhpcywgYW5kIGlmIHlvdSBtYXkg
bm90aWNlIEkgZG9uJ3QgZXZlbiBvZmZlciBhIHdheSAKYmFja3dhcmQgdG8gcmV0YWluL2VtdWxh
dGUgdGhlIGZsYXdlZCB2aG9zdC1pb3RsYiByZXNldCBiZWhhdmlvciBmb3IgCm9sZGVyIHVzZXJz
cGFjZSAtIEkgY29uc2lkZXIgaXQgbW9yZSBvZiBhIGJ1ZyBpbiAuc2V0X21hcCBkcml2ZXIgCmlt
cGxlbWVudGF0aW9uIG9mIGl0cyBvd24gcmF0aGVyIHRoYW4gd2hhdCB0aGUgdmhvc3QtdmRwYSBp
b3RsYiAKYWJzdHJhY3Rpb24gd2lzaGVzIHRvIGV4cG9zZSB0byB1c2Vyc3BhY2UgaW4gdGhlIGZp
cnN0IHBsYWNlLgoKSWYgeW91IGV2ZXIgbG9vayBpbnRvIFFFTVUncyB2aG9zdF92ZHBhX3Jlc2V0
X3N0YXR1cygpIGZ1bmN0aW9uLCB5b3UgbWF5IApzZWUgbWVtb3J5X2xpc3RlbmVyX3VucmVnaXN0
ZXIoKSB3aWxsIGJlIGNhbGxlZCB0byBldmljdCBhbGwgb2YgdGhlIApleGlzdGluZyBpb3RsYiBt
YXBwaW5ncyByaWdodCBhZnRlciB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZSgpIGFjcm9zcyAKZGV2
aWNlIHJlc2V0LCBhbmQgbGF0ZXIgb24gYXQgdmhvc3RfdmRwYV9kZXZfc3RhcnQoKSwgCm1lbW9y
eV9saXN0ZW5lcl9yZWdpc3RlcigpIHdpbGwgc2V0IHVwIGFsbCBpb3RsYiBtYXBwaW5ncyBhZ2Fp
bi4gSW4gYW4gCmlkZWFsIHdvcmxkIHdpdGhvdXQgdGhpcyBvbi1jaGlwIGlvbW11IGRlZmljaWVu
Y3kgUUVNVSBzaG91bGQgbm90IGhhdmUgCnRvIGJlaGF2ZSB0aGlzIHdheSAtIHRoaXMgaXMgd2hh
dCBJIG1lbnRpb25lZCBlYXJsaWVyIHRoYXQgdXNlcnNwYWNlIGhhZCAKYWxyZWFkeSBub3RpY2Vk
IHRoZSBkaXNjcmVwYW5jeSBhbmQgaXQgaGFzIHRvICJwcm9hY3RpdmVseSB0ZWFyIGRvd24gYW5k
IApzZXQgdXAgaW90bGIgbWFwcGluZyBhcm91bmQgdmRwYSBkZXZpY2UgcmVzZXQiLiBBcHBhcmVu
dGx5IGZyb20gCmZ1bmN0aW9uYWxpdHkgcGVyc3BlY3RpdmUgdGhpcyB0cmljayB3b3JrcyBjb21w
bGV0ZWx5IGZpbmUgd2l0aCBwbGF0Zm9ybSAKSU9NTVUsIGhvd2V2ZXIsIGl0J3Mgc3ViLW9wdGlt
YWwgaW4gdGhlIHBlcmZvcm1hbmNlIHBlcnNwZWN0aXZlLgoKV2UgY2FuJ3Qgc2ltcGx5IGZpeCBR
RU1VIGJ5IG1vdmluZyB0aGlzIG1lbW9yeV9saXN0ZW5lcl91bnJlZ2lzdGVyKCkgCmNhbGwgb3V0
IG9mIHRoZSByZXNldCBwYXRoIHVuY29uZGl0aW9uYWxseSwgYXMgd2UgZG9uJ3Qgd2FudCB0byBi
cmVhayAKdGhlIGFscmVhZHktZnVuY3Rpb25pbmcgb2xkZXIga2VybmVsIGV2ZW4gdGhvdWdoIGl0
J3Mgc3Vib3B0aW1hbCBpbiAKcGVyZm9ybWFuY2UuIEluc3RlYWQsIHRvIGtlZXAgbmV3IFFFTVUg
Y29udGludWluZyB0byB3b3JrIG9uIHRvcCBvZiB0aGUgCmV4aXN0aW5nIG9yIG9sZGVyIGtlcm5l
bHMsIFFFTVUgaGFzIHRvIGNoZWNrIHRoaXMgSU9UTEJfUEVSU0lTVCBmZWF0dXJlIApmbGFnIHRv
IGRlY2lkZSB3aGV0aGVyIGl0IGlzIHNhZmUgbm90IHRvIGJvdGhlciBmbHVzaGluZyBhbmQgc2V0
dGluZyB1cCAKaW90bGIgYWNyb3NzIHJlc2V0LiBGb3IgdGhlIHBsYXRmb3JtIElPTU1VIGNhc2Us
IHZkcGEgcGFyZW50IGRyaXZlciAKd29uJ3QgaW1wbGVtZW50IGVpdGhlciB0aGUgLnNldF9tYXAg
b3IgLmRtYV9tYXAgb3AsIHNvIGl0IHNob3VsZCBiZSAKY292ZXJlZCBpbiB0aGUgdmhvc3RfdmRw
YV9oYXNfcGVyc2lzdGVudF9tYXAoKSBjaGVjayBJIHN1cHBvc2UuCgoKVGhhbmtzLAotU2l3ZWkK
PiBUaGFua3MKPgo+PiBSZWdhcmRzLAo+PiAtU2l3ZWkKPj4+IFRoYW5rcwo+Pj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
