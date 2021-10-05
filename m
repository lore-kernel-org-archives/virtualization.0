Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5830C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 17:11:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814D9611CC
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 17:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 814D9611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E31060C0B;
	Tue,  5 Oct 2021 17:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20J4WWDm3atf; Tue,  5 Oct 2021 17:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7DDC660C09;
	Tue,  5 Oct 2021 17:11:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3712EC000F;
	Tue,  5 Oct 2021 17:11:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5C65C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 17:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C705E40284
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 17:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="EYwfp3G/";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="p5vsWoBH"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TFzpHBMtPVQh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 17:11:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EF81401F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 17:11:20 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195GvlTS024351; 
 Tue, 5 Oct 2021 17:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mQZjhNQ83/yZ2aAA2sh7fZe5daLz//oC/8G+mrMRKwk=;
 b=EYwfp3G//1X2faidx0jKeDWvlGY6KEvJ+0CE8mgt9OnSUxxcQbRX9hNnhEWYmSBpBmeC
 rnhMH5HQXk7dSGXePIsxE5wSz+caoAI4Ey31khHrCu8uWo+2K+EJo68faLhNArZ8vZ0m
 3fNoRqIcWtQKRqyEs3hOdtJRjm9tCF0HEqEleAb4JowhT4/HX135kTzz8B+JhFdoiRuW
 Q+BfermH2CTY0IH0qv0XQOIxB406gGsuhvwkz9u4ARQtaX+VOGXzgJ6/4TtUOaF80Vwz
 gOBxUXXJ8mq3h1sr0wFlsJH9CSSRVHIbpMwN/2JzT6++3Se6Sujaa2MiwIA5IV3l5726 Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg454ha9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Oct 2021 17:11:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195H9xIf065167;
 Tue, 5 Oct 2021 17:11:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by aserp3030.oracle.com with ESMTP id 3bev7tjdda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Oct 2021 17:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtdH93LS5ikG0LZz2qxiTlCl73gECy6qwBa30sEsHjYJoJqobVYTMnVB3qhi9TvgT4Y8fygaZHYxksaANpIBnRzj/BfRqk2NYENS7ERIWM9oz1TlXUrBHPaQBH4Usys+wn3DzVBuldisVZPTegcFe3Mp2ZMzd15coj28/Quf++azsjvskrMmZNkaH9kx0DRB6hG2diNz4lZ1vf9RYRJIC1SmX1cIfyYJjq03SeoyvhKwFT6zy2/faBeHq1V17L9KVCK6alnCNkaGT9zMrPuV9iZAsGYWLljGRSxoq2rhOkyn0P4nTVaV8eXofPC/TfstxzqTfnC7xefY5VeZFxZCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQZjhNQ83/yZ2aAA2sh7fZe5daLz//oC/8G+mrMRKwk=;
 b=n0R5XFJkRK9HO7A8cGf/HOmY8VwuLclarMHDPQafLforf9VwasWEHB2HTZwsQxewwuoLJeF/2CbGJ6Cm5gPBLzRTDpQWlx/tIEC5/Jgp/sUmTuA2N79xpF1nPdMWcnrJnB927GaUsAMxrx1bJo3ANcmF8yWfcCniSlSL6BtMzRlEeIozhoBjC3h6QW+3dVzErUP8W1HTedzXhfy6hIAuXI9COEChYqbACAupSU9eB79KLhBkBg2VTSYJYSPrBrBDgQrT/E9fQAOvVWCegX46gN+wxTM5yFgcqLiZHJxfdejZCPs+wwaKMaXg+2xvi3T20qU0/yOzEiYVv9qJa0JYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQZjhNQ83/yZ2aAA2sh7fZe5daLz//oC/8G+mrMRKwk=;
 b=p5vsWoBHWKRAs5b+pIOw2AydRBPduELDGnM2zShv8DjskRzNxtk6Sl7qjDAHZfVGIn3YHUvMpnJtvcCcBqdJ7uzQ95omM0XKg7vyIk17PdBd9zyclYKx7Q/nt5deDMVO1tp7vcWHATGSEMM55u5SxeqaMAEZwkk9Cp3GhYNuEG0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5293.namprd10.prod.outlook.com (2603:10b6:5:3a3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Tue, 5 Oct 2021 17:10:58 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 17:10:58 +0000
Subject: Re: [PATCH V3 5/9] fork: add helper to clone a process
To: Christian Brauner <christian.brauner@ubuntu.com>
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-6-michael.christie@oracle.com>
 <20211005125018.5nzmhwdxivyye5on@wittgenstein>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <00d724df-5781-035f-54ad-e0432ec92646@oracle.com>
Date: Tue, 5 Oct 2021 12:10:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211005125018.5nzmhwdxivyye5on@wittgenstein>
Content-Language: en-US
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.204] (73.88.28.6) by
 CH0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:610:b3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 17:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33cf1541-ee83-4671-7f66-08d988231936
X-MS-TrafficTypeDiagnostic: DS7PR10MB5293:
X-Microsoft-Antispam-PRVS: <DS7PR10MB52934B877D5493ABE5C5CB24F1AF9@DS7PR10MB5293.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fz4iGtC5yKww1LnBqMZhnEbCfR585Ve7bhmEyEKzvItnecnRvwS6+qKQ9Zt6nUVspR05VnycIgtbkhU1zj9CthoWsDebdydbvsSGRH7mmFmbWCSFglaC/zn4jEa5DuGwwYpIMdyS6s8HO1m3T2n3mVR+Oe9c8koK8RDAM5OKyo6LoIfocVPJ8WpCKKkzN+rfwkEp7qSXd65BWRQL31IeHqf4zlVYBASXok356otYwTADuBocxUn8EYC6nRIdQ3eQ9e/+h/cLmYMZVDXlOQdyNoEG88/4N20OjB3c/6MjRk+0appwHXqzvP5qLZZxEOi1wxyl67o/39y0WypE59NvbMfjxD6qDDntthshntfLd/+tCByXqe1qJXiZSuLQhS4IeSJ1t7x7q7HSEet5Wkovc8y6156phujWvSfZWjViKNxuoItVQm0SJ7z9OtuonDqvTKiDf4OxMxIQSlF8UyNd6J1U+2DAFDwoDVxdpFpb7q9ErRsM73kcxeNbrMXP6SuWz4rqZ7oKevC5w2iV6tuffIAqcf8JDh4Of+21U0jZGSODow22PyE94fW09jNlTkCyU/f6+wl29wp3mOrpeZ8K2J8xOhGUNxBC9qKrdxwhbN7C8ZXNys4aVtIGVGA7J0AUAg4N2AwIeghFNfq8CHb3AbPisjmLBX1VHp2/4yfI2O3OGvjDoHOIb3hGOK/5xkiBUaWFwzknv+Fv/UTiYM3iWnmoQKM1B8zTAXjpIuOWMR8Nvle5WgX/12bspzQwov3g+JQclQqWjPdc/81FV8KvEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6486002)(186003)(8936002)(508600001)(83380400001)(38100700002)(26005)(6706004)(8676002)(53546011)(6916009)(36756003)(31686004)(66556008)(956004)(31696002)(316002)(7416002)(66946007)(16576012)(2616005)(86362001)(5660300002)(2906002)(66476007)(4326008)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skw5aG8xK0ovODFFNkcvTEVGZ0pyZEdQNFlhdVZmZlhqWU43djVPclN3V2Jn?=
 =?utf-8?B?NmxLUnp0VDZiZFFOTlcvSWNrUXpHMDZYTm9TWnRaM1VXUGRXREkxVkUwdWpy?=
 =?utf-8?B?MTJ3Wk1ScmtyTG9YRHJ4OWt5eG5oVkhzMTdpUTY1alJ3MUtwUGd1TnN0RVo2?=
 =?utf-8?B?b2c2QWZCamIxVVpqMGFDcjhUdzBDSUJnVDlJaEt3azlWQlpvZThKSFVxd0lF?=
 =?utf-8?B?RzhReUk2Y1NYdG5oMEQrckxURmczWllPaUg0V1B4Q2dZaEpRUTdrb1pWK2NL?=
 =?utf-8?B?VS9haVU4a0ZWRHdkbFVyTUluUmdqSDVhS0RxRnhONXg2RnBXQWxXUlAyWGEv?=
 =?utf-8?B?K1M5ZGdyQWRRODZuOUh6NDZKcVRtSlFybzRtYktReDJuNTVGdXFjUlF1TDdL?=
 =?utf-8?B?UGlpOWl3T0ZUT3lwSUhoVkk2L1I4L28wMzhvSldGaVJJMlY1aW9RMGZlOFdF?=
 =?utf-8?B?Sk5leGQ4MlkrNTZzVlhNK05majhuYXFqek9PV09uYVZ5S0xoSmtrTS83VU9E?=
 =?utf-8?B?WVFIL0hUNkR5TW1iS3JtUnA0Z3Y1c0NPWFM5eXpOZCtSVGZoMnZnMlVCVFZD?=
 =?utf-8?B?dldxMk94Njl5YjFTcUFQZWFwekxwbk8yQWg0RmhmaGlpbXdIbkRtWkFOSU9C?=
 =?utf-8?B?ZGtrMDR0a1hEcVhGUXpib29nZkZHRjJaU0Y3T01xeHFsaTk4MThFNHV5Q3Yw?=
 =?utf-8?B?NjRtMEh4VHZsTzZhZmx5cndHMHZRZHhHeHVtRUpzbHVyZDFObHpmeS84N2ZK?=
 =?utf-8?B?SVdKSjI0RVRKYkhRT1NjajBaK3JEclBIQzE3THVSTnY2TXlNOStQSjNoUmVw?=
 =?utf-8?B?UkNZNGp1ZE0xQ29HMjFtY05vSEIyTE5CUnc2OUU1dVZFcHJrUUZONjcwNjhG?=
 =?utf-8?B?NVFnQnR1aEkwN0hWYS91emd2elB0QmNQV2pCcEszOFhFR2V3UGplUzNXR3FR?=
 =?utf-8?B?TWg0V0FuSmVaUWNNRzNCMFJ4UTFjTUhxQ29FcGsxd0NmaHgycEJKSjlVN1Q1?=
 =?utf-8?B?WjIyVm1kc20wUWIwRWllT0FKeUF5SlUxeXdIL1B0eFBMUEk3Z2R1c0xDNmts?=
 =?utf-8?B?Y3ZrYXVYRUNWTkhjZGxjSW42Q2Y4SmRIRDdueTN3eGFqRnRxNXBMdU5CVGxQ?=
 =?utf-8?B?TW5VMVBBTHhmbUdia2NiK1Y0UVFkd2Y3bXlJTUJlcGhwMG5Vd0JqeVdvc2Ft?=
 =?utf-8?B?Q3E1bjBLZGUrMzNuejV0WEJLL1BqZVdPSkN4NVdncjdjSDR6VDJsQ0pPZk4x?=
 =?utf-8?B?N1E4RVZObFJqSG9zUGo5SlFGc0xTOTFKMFFsZVpTM2RjZjlNOHQwc1RKWVA0?=
 =?utf-8?B?TFFJbW9jRXRJQnVUbjk2dzRFVmJUSFVhNUNybGdDTkhFdWxGUHdYRmpjNFpV?=
 =?utf-8?B?U1hXNGhWVDliZEVwaGpPUk1CbE9JWHAwalBoMjF2Uks1R3JNVjhzbGg1QzlJ?=
 =?utf-8?B?WEIwMno3ZkFwcm41WVJkbjIxOXhZUmlyWjN4ZWJzRHpBLzBVT3pUbEdrVlA0?=
 =?utf-8?B?dWswQVVIYVV3bklDSkI5UnFUV25SU0Y3b2FMWDRFc3E2ekp1cnN0Qlk1SzhQ?=
 =?utf-8?B?U3grRmsyNjV4Wk8rYlZoa05MR0wxbWlPdy9KSXJwTkpkdENFL1FtYTZkbysz?=
 =?utf-8?B?TWFoa2ZKK0RBL3RFRGRHbDFiL2daRUgxeEk5NW9kWTZZUkFYeng0SXl2ZTB5?=
 =?utf-8?B?OHFLZklPUm9YUitseTgvMHJCMWM2Wk1vM09CSkxHZHg1SXZUTlBZY3VsTDRx?=
 =?utf-8?Q?Nd5zOEoJL9vj7pC1SSqUUgPsLge9KNWs1ObjT9F?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cf1541-ee83-4671-7f66-08d988231936
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:10:58.0229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVfqzO6n47XYqDPlazFF8XMzjLMvn7ICGn5ZMcxrrdidn3WzOCMkTmlHOBh3vX+2KcIm3tgXWsgey01TP9QI+9gfknl04FZt0HrgiIJISxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5293
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050103
X-Proofpoint-GUID: NDwOHYm8kU_m_O9qk6ulGo5vcr5KACZx
X-Proofpoint-ORIG-GUID: NDwOHYm8kU_m_O9qk6ulGo5vcr5KACZx
Cc: axboe@kernel.dk, hdanton@sina.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, vverma@digitalocean.com, geert@linux-m68k.org,
 stefanha@redhat.com
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

On 10/5/21 7:50 AM, Christian Brauner wrote:
> On Mon, Oct 04, 2021 at 02:21:24PM -0500, Mike Christie wrote:
>> The vhost layer has similar requirements as io_uring where its worker
>> threads need to access the userspace thread's memory, want to inherit the
>> parents's cgroups and namespaces, and be checked against the parent's
>> RLIMITs. Right now, the vhost layer uses the kthread API which has
>> kthread_use_mm for mem access, and those threads can use
>> cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
>> other items.
>>
>> This adds a helper to clone a process so we can inherit everything we
>> want in one call. It's a more generic version of create_io_thread which
>> will be used by the vhost layer and io_uring in later patches in this set.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>> ---
>>  include/linux/sched/task.h |  6 ++++-
>>  kernel/fork.c              | 48 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
>> index e165cc67fd3c..ba0499b6627c 100644
>> --- a/include/linux/sched/task.h
>> +++ b/include/linux/sched/task.h
>> @@ -87,7 +87,11 @@ extern void exit_files(struct task_struct *);
>>  extern void exit_itimers(struct signal_struct *);
>>  
>>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
>> -struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
>> +struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);
>> +struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>> +				  unsigned long clone_flags, u32 worker_flags);
>> +__printf(2, 3)
>> +void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...);
>>  struct task_struct *fork_idle(int);
>>  struct mm_struct *copy_init_mm(void);
>>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 98264cf1d6a6..3f3fcabffa5f 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2540,6 +2540,54 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>>  	return copy_process(NULL, 0, node, &args);
>>  }
>>  
>> +/**
>> + * kernel_worker - create a copy of a process to be used by the kernel
>> + * @fn: thread stack
>> + * @arg: data to be passed to fn
>> + * @node: numa node to allocate task from
>> + * @clone_flags: CLONE flags
>> + * @worker_flags: KERN_WORKER flags
>> + *
>> + * This returns a created task, or an error pointer. The returned task is
>> + * inactive, and the caller must fire it up through kernel_worker_start(). If
>> + * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
>> + */
>> +struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>> +				  unsigned long clone_flags, u32 worker_flags)
>> +{
>> +	struct kernel_clone_args args = {
>> +		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
>> +				   CLONE_UNTRACED) & ~CSIGNAL),
>> +		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
>> +		.stack		= (unsigned long)fn,
>> +		.stack_size	= (unsigned long)arg,
>> +		.worker_flags	= KERN_WORKER_USER | worker_flags,
>> +	};
>> +
>> +	return copy_process(NULL, 0, node, &args);
>> +}
>> +EXPORT_SYMBOL_GPL(kernel_worker);
>> +
>> +/**
>> + * kernel_worker_start - Start a task created with kernel_worker
>> + * @tsk: task to wake up
>> + * @namefmt: printf-style format string for the thread name
>> + * @arg: arguments for @namefmt
>> + */
>> +void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...)
>> +{
>> +	char name[TASK_COMM_LEN];
>> +	va_list args;
> 
> You could think about reporting an error from this function if
> KERN_WORK_USER isn't set or only call the below when KERN_WORK_USER is
> set. Both options are fine.
> 

I'm not sure how to handle this comment, because I might have misread
an older comment or made it up in my head.

KERN_WORK_USER is only set on the kernel_clone_args, so at this point we
don't have that struct available anymore.

I didn't add a new PF_KTHREAD_WORK_USER flag to sched.h, because I thought
I had got a review comment to not add another PF flag for this. However, I
can't seem to find that comment now so I'm not sure if maybe I misread a
comment or made it up.

If it's ok I could add a PF_KTHREAD_WORK_USER, then do a:

WARN_ON(!(tsk->flags & PF_KTHREAD_WORK_USER)

so future developers get loud feedback they are doing the
wrong thing right away.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
