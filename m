Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A542AC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 10:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31F2641BEF;
	Tue,  7 Dec 2021 10:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d1zUgmnPJyHc; Tue,  7 Dec 2021 10:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 85167410A7;
	Tue,  7 Dec 2021 10:46:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62BE4C002F;
	Tue,  7 Dec 2021 10:46:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1E6C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5622D607E0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="0w2f6DlI";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="tjyfBcgQ"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thcqEp4smwB4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:46:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D7A4607DC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 10:46:31 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79DwWJ019296; 
 Tue, 7 Dec 2021 10:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Nb/Z9gO0HZbJTF39K94TUgl8ndQr6TLCHjH0R458HB0=;
 b=0w2f6DlIP0xSpzBJiufceTsT/4K1uyxUqHgxcTDTUTS6tSvc6Ilz/1e4CuSZGLr2EINE
 CBGz7RlaE8Dm5fx30UzchyDVMewIAzp5dZgO1PCE0A8T/qZqvavWAh4FFUsXWqgTk6Kz
 OISt00Ao8zdT4MNK6mVvj1fTAQADoY4l+TIRpRCBHnglq3XKDRP8KTiLWrgTfxkRiZEv
 umJKcliAsw0Xumo/rmyKxmJQta0Zi7yUEvQxwtV0B9uq+o9rxZ5SPEKjBKA5tFPQZE6I
 jdPxaVf6wkoKwSHWqJiic8WskpzemTNRT7OZMLg6ZKB4fBQnk3V5ssygtDjumaEkyfYP KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqncrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 10:46:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7AfJaR169052;
 Tue, 7 Dec 2021 10:46:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3csc4t3fdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 10:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUp+I1CB+8o/YRxw/9I6HuMT4fMKTNzClBkZpFx2w1R07n9OoHN4sBnitEtg8u0Hif9wS8Htb2lAkt6fPglrW6ro/jFjt3KVw9dXR4RF31HU4DyEyQEs6i1P/tJQTYpgjvy2XE/XliYEHJ6CnWOO7GxwZxmD24tltA/6KGk7p3EsNE3WmjUgzFZD6yr78ucMLzYPIr4vtbghbKKFLhMrr6zEGH7ZmBm8ko4BfS8p7ZSq0UNoY42W3WxEITbmFjLfLeBpRFQOoZp1945l7D/29oVQrRnKshgkI/zw2irJXtVsllMlcyI6ea14wIg5b1FlKUVQy7rgVX0fc1BJv3WWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb/Z9gO0HZbJTF39K94TUgl8ndQr6TLCHjH0R458HB0=;
 b=d1K7v9qQ/WHSjC8BMvBoCLVJuyfqtmiNlydS5Le6crXAPNPGaqjYViA04Al1QXVm/vFjfU0T/ObQscvy0eifQoVsdBpzxMSm7/DYfcoWZOiL6kWzs3G0uHq/4aYzFVNYHET5Rm8h0sxPbUFI6XxwavyhsAiSU8d5gKiabYYzfgA+iVY/88wDzBNvWzjMlicVVHbs15wjp3eZ44fkw3odFqLs7NZvRVJ4PdEZWBgYYtmcIKP/Ff8TRDbC86rCeY+ypn3G8owIoUM6F+/NQYlQDu0XnUIv/sdn/OC7M+ItLEwdVATnLh+I9bgczU6UiYR7VU0DG4Lo7qP4opvY3/PDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb/Z9gO0HZbJTF39K94TUgl8ndQr6TLCHjH0R458HB0=;
 b=tjyfBcgQ9sXFWv4XoGJ8btver4V4tJl4MXwF62olIko7Y5JwvdnbfT0jPNnI5faGaZNcEfuJ5/eIJEucNqFlKQXNfhGEpSXGgu0FsZbyLAw+TBzVwymdR3SksCD/bIKnhUkYMz1gTpG6oTJKHH6+jgg7bCwQu9VSRvs0VZrJq0s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1487.namprd10.prod.outlook.com
 (2603:10b6:300:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 10:46:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 10:46:26 +0000
Date: Tue, 7 Dec 2021 13:46:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] vduse: fix memory corruption in vduse_dev_ioctl()
Message-ID: <20211207104614.GA21381@kili>
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0150.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0150.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Tue, 7 Dec 2021 10:46:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74e0950-6e47-4eab-ab6f-08d9b96ed136
X-MS-TrafficTypeDiagnostic: MWHPR10MB1487:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1487F933B21E4C88EB1AF1648E6E9@MWHPR10MB1487.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+OSJ7LQRREref7ZPpvoOBJI3ylf8kuPJDcGK0nucdluKro8Co5lu1kNzo7219WD5huaackT+D3qVWRUWkUUhLot/p2YDuaNW2F2gqyR4vLg1hbvY8+srSXBH8ivjEr4UNJewj6lveUNFmlNNkety97/GxGXK5GyySEvw0p/8yi5oxodJ/l8uBfv08/JkVNG5MqTKd2Ab5YbqTsrC+I+f+G+CPqSowqFuM356d38/l4oMShP7xAeilVMuoCyyVPYyE8lyMcBJ0KPLDIrJS5ssoAYDTnc6leWWLMlu/UzcryERIPe27jV9dep0Gro5u4DTeA0rdPRLzQt+6j1aqGVhug+rnV1n9xJ45O1Oc2b2BP6aZSN7dg/ioCbaARuu9SAESHCbWODHKuRqtHh7SHPTEdDmuc/8Tfd7w8IVx4XScivKEr+FMSZhbw7wZVwWx/YlvCmogtEKZsBM8kd29K9KNPIRlPHA/yr+mjjVsIEUAG88djGQ9kw6wJCn1k5AEUHy/WEA0nQuYLo/2RnqFDWEPtJHpwpPRgtjsY55wKQake+oRwgNsoWoGtyRrvArRXVPs57RRCSfXC9UxRftaqdDDzI5kFfqCvpFcsalZRzM4Ls0YPSb9szHooGfuWXFhsWLj+VK1a+lTXp3E74Z9W2BWq5BYE+71QUrxDSVkZWCg2mathNg++3EFhm5SjeaePqTKTVCfyNkTqsVCwXIh4ECg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(9686003)(86362001)(66476007)(2906002)(5660300002)(9576002)(508600001)(956004)(6496006)(55016003)(52116002)(8936002)(66946007)(316002)(26005)(186003)(8676002)(33656002)(110136005)(66556008)(38350700002)(83380400001)(38100700002)(4744005)(4326008)(6666004)(1076003)(33716001)(44832011)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8K7RQ3nVKNFnKVIelok+QEzNPfRgE6uswFS+OfGfbfVB2VHyAz8KBDy4miYN?=
 =?us-ascii?Q?YV0goaeuaHJZAk/gRtz6PgiF2mcqFGVkW9T0rDd4utQHeRR7rrKSj17Ty3Z4?=
 =?us-ascii?Q?M6tIrFgTTKT0XgwSSsINTxWFi5iv8qWThani8O7EF6sSpyjXXq8abmpwELWa?=
 =?us-ascii?Q?F7qYBY3VBxWnxgzV6N2QbIeqdlhv9vI3CKK2ZM3jjzyMxO4hPPho1gN2gRr4?=
 =?us-ascii?Q?htbcQ/sc9G5zxs4deL1JDuaDe3hPBFfKHEhUz15gZlenhAq5evmc9hfKoPN+?=
 =?us-ascii?Q?QyzK+2v6SybF1BDhJWXNCGHTvgczV9ljtBODBewpS3LpQ0JIe3gHRMOoslgS?=
 =?us-ascii?Q?V1FHWXAHT5OuYKucxFXcqaYL406nhLO+11h6yLhGDEN9PzIEHComJMDiKsE6?=
 =?us-ascii?Q?FToOskUWVRMYY6orvtgl56OaEqKCaiDcV+GCx4d9Hy4/zIraQmaqu966HGM4?=
 =?us-ascii?Q?4217IJgbWnz+nFyWZPf3cRWzAo+G6pHkrII1Bt0Zq+BWPmP4w06m88/G9s3M?=
 =?us-ascii?Q?QRLw0b3nyU0cyTCmBKaWilMioN4Vl6cJMSZCfYzi2iZoUtx39x8SJJZLXTAz?=
 =?us-ascii?Q?P1tf3kkoo3/nEEAvW7FxAxhxucq2CJLsuT01OFrWPaGU7+DGEu2VkrSlWxd/?=
 =?us-ascii?Q?IDIqlyz1t7FeCT5Jgp3kma93SXAurg/5C8rt0fxfsl5fMXe7N5P2mB/m59F4?=
 =?us-ascii?Q?YjjqXnfM8Tu2vItopmRKLVfrZU1jqL0VzyCu/stbOfHdlxo+N0hx4aj+5ezZ?=
 =?us-ascii?Q?CwBQn9/nyFGYSdafl3NvVt0o91tKTpFlRJAYGo0mWQTSCNZ/m/xrKiFH4PXP?=
 =?us-ascii?Q?/DXbw7QWpL2H845MNe/2AGUNLptATn59uhwkRMY8jlVQt4MraM76ogOoOFC6?=
 =?us-ascii?Q?tKCTFtou/m7jlihhf3S7HOuAsYwT8Y6jFp08IhY4F2+jSILo+ZC3tI8Ifxf+?=
 =?us-ascii?Q?DMStChB37oM/t5fAR1ubAllBi6zQI6TH7ZQPsouRw3UpKa9wKLe/OYWFU1pj?=
 =?us-ascii?Q?yF1NzTdHa7GbMttT7ZX1AwAN1CboJj0UJN5abFMPbsCnbBeCwtENOJCB7iZK?=
 =?us-ascii?Q?T6mLWXndbbt/HdLnpJayEd8CPo/IdxCt2YuvU3hsBso69fYAGKIUuQ20Z14Q?=
 =?us-ascii?Q?5pmr/7hVe7NUi/j2R4xxFNpMBrun7223FpNcKN4TrktVwjOANk/WFwEA1xqn?=
 =?us-ascii?Q?xrRwK2MnfJn81+pSeGslIWg4NcOQ/pokHN0/WyqyqkqWRGR8L93VfoQG5WNt?=
 =?us-ascii?Q?6SUgvXfXCZ4R0I8PTPWk0WMGhTF3y8GN7ovbM5z7ajnQ2LBgVYAKrCPAMk42?=
 =?us-ascii?Q?VB2ShaQ/UVNmxkYqaWgOno0gBCBmkO61z/ucsGdYota6J0cNKcPxIsS8mVhP?=
 =?us-ascii?Q?+l7hSmTN7wmfXBA1DG4EYS3kMzVF+ar43YIhcjwP/EXwPdQJ4QW0kqXAXbGF?=
 =?us-ascii?Q?mOEsnMdqeR5cTCY4CEONTinGnqBUeREUS3aGVb+W4QeF4iWiiHaWwqAQuBI/?=
 =?us-ascii?Q?Sy4w1eNfP8WpOoMjYOFPzwNUn8Nl+LZ1BNEwAmKnIxrc/H9rGt2vDstRieXO?=
 =?us-ascii?Q?Dx1JAeamtFy3GYq31reCWh2LDA8X5HtfZDWx6uH4u1DzPBdbXASPYyV8gGzz?=
 =?us-ascii?Q?EEP3+WtkH9VfXlf1Yt7/ktBJK5s5DKbZbRGQgQOoRggzPquu9g+9d3vjrOf7?=
 =?us-ascii?Q?EzAT2JMJhv6kOvc8fY1pML6JTf8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74e0950-6e47-4eab-ab6f-08d9b96ed136
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 10:46:26.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymSCpCYWrMS9iWfd6q7A+TpUqXjaoQQt1iFC236Fo65dY3x7b+fOS6Gc3W5mufLf3OiYjk/N6aQVkjqpGnUAUbTAr4bnWy61yTyyLfw1RU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1487
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070062
X-Proofpoint-GUID: AVmCwQLy8_JqaflC-JVF5jIV3yc6Ii88
X-Proofpoint-ORIG-GUID: AVmCwQLy8_JqaflC-JVF5jIV3yc6Ii88
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
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

The "config.offset" comes from the user.  There needs to a check to
prevent it being out of bounds.  The "config.offset" and
"dev->config_size" variables are both type u32.  So if the offset if
out of bounds then the "dev->config_size - config.offset" subtraction
results in a very high u32 value.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c9204c62f339..2f789dca0c0b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -975,7 +975,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (config.length == 0 ||
+		if (config.offset < dev->config_size ||
+		    config.length == 0 ||
 		    config.length > dev->config_size - config.offset)
 			break;
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
