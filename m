Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABCCC433EF
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 09:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64081841EF;
	Fri, 11 Mar 2022 09:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sK87shvS4LzB; Fri, 11 Mar 2022 09:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 091DB8415B;
	Fri, 11 Mar 2022 09:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E2AC001D;
	Fri, 11 Mar 2022 09:00:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9077CC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B9AB403B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="eMJ9g6/8";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="hC494Boz"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZmX40VkaN3C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:00:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EB0B40220
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:00:35 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22B5vZ3i023450; 
 Fri, 11 Mar 2022 09:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=h4dCZqKb6oMymknSzNaGJxoHTezJH3fpr73RMN4ShTw=;
 b=eMJ9g6/8qffM3QC1xTjrdgMgB4C0slKMipPQw9TTB94lxn4kZMhHg00zFq61FHqV11iq
 Ah935u0ClMidUBsEy4lRsD36dAaoq/WaJ7OPZ+vpuCJRbuTNC2rXLTF9LFkU5I4RWUbs
 Yms3rrAA6j0Ue7B0OO6tUTiJOralxFIZFDDo4kUF1g8tF18zcOafE6aH3XyUgjb0phst
 dwydX61Ft1XFYikj8mhv0W9O9ZRigiXu++lBbeflgf1tSrXo7rRb+vygICp3i42noGfl
 SzUHfMBkdXWrV1QCJY7XWtNSxBvEEiflJbdOvEK0DKNWp0axUwr3rIhVBp7wGr7ASZry +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2qtn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Mar 2022 09:00:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22B90Kik058058;
 Fri, 11 Mar 2022 09:00:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
 by userp3020.oracle.com with ESMTP id 3envvnyh5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Mar 2022 09:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtdUOfKTQyHPJL5o2bidDCPij8feqOS36ARMW7mwDB9T2hAXvYEKdB4F/+GhgiGTSdzc7kUcNTrmxYBDrjpAT9MxgCkAofWGUqijuRSMtSU6+kcNHqkcLpFFxS8NbyRnN6abrfjdtz7J5+MtcLie6KoyolHQKQkUZk/S5cyFcX64+E4FzoiDSztBpToPnqf2pLPswAkMMPo1+1knWQ9OsDVsjNSd9oT5C5DRLjIpyVQ5ioAZ/o0pN3dzFm5j5YQCQ558SIvMdWLnPDhmuacIOrXDK2BXnheFLkvnpdrgkF8ybAIPogJXBMhIIVbIdLXIq1VmQ9ELxLuB8wOvGXC2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4dCZqKb6oMymknSzNaGJxoHTezJH3fpr73RMN4ShTw=;
 b=a3QKqDauDK4lUgBTe6JmytL7CN0zn+aZYpomNePG2h52Y3C/qbI9Y8DSVIQMxQbpkyphH/tIfaiJlS7HcrLpCITN69Hu5i53tL+R6fEcMC4zyEmn5dkbr34PN4ZzO/Q6rveWqXdkZqeIz7cwl6D57oW+V9ZiXUwPKA8Chd+fuk7uBW+5X807SRfJ57zjtXzA1YhGeVTGE7NS+Ci1z1rkj/KfO8nyKfUbiLjhZHw+Ru1HiEROc5o7wlmZUZNS6z/e+h43NT1bY2qW+Xn3HKwgL23sX77wYIpbgA7Rtm88zv9TYqimXZS5eYgSRh5qXCEAL93H5QqrPM5/7MoD1PCkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4dCZqKb6oMymknSzNaGJxoHTezJH3fpr73RMN4ShTw=;
 b=hC494Bozf0STW+HP3jYjVC0vNMKFOObW5xrvwrO6q5sTi9tyUrcnZa2j/3BT7mvMxaCVaY3sEDpedkGFP+K+7xVvtZuFSSKRgwYuOChtwP50BhqOF7/CmpjZTQe8clcG2P2Quv4tZQKhL/pzJZS5lFjHV2IH6FYLRJw8RzILB/A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3922.namprd10.prod.outlook.com
 (2603:10b6:a03:1fd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:00:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 09:00:29 +0000
Date: Fri, 11 Mar 2022 12:00:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: lingshan.zhu@intel.com
Subject: [bug report] vDPA/ifcvf: implement shared IRQ feature
Message-ID: <20220311090013.GA7547@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0089.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2da701b-8049-4509-382e-08da033d9712
X-MS-TrafficTypeDiagnostic: BY5PR10MB3922:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3922FED3FB7BF2CFBF2C09B38E0C9@BY5PR10MB3922.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQgCvUrcY+BjkJsjeTDicb4KI5uUez9qhErj9iKg8wwcRy0tGSm3z/FDJyyGyb43EW3/vEFjF7RZNtFFOlcYfCRHKxlOBhJOvtGR6l+a+eXiIVZ0IEN/GsKMjxShPa1LvzImu/2rBMA+iKBYNNFOs6/wdhiIF70n7qluKlG2pZLczNFGYY10wQzLDgiembkpbjMsjiH6rQmt0YR9vuGRzf06AJpV4I+vkBxD9QGB8MikL6XbvCRy8BDXbajDQgZn/4RTU25o53MVgjljH5HAzZm23TuCrwuicsZX3DtPgDSwdGgvTYpI/HCZyRlbqXzZC/Rm2yO8MDrsP9jf7mQe2+hTXIJwbnaV/EdsyLqVjHYYjRdo40BZkHlMW1vb4fmd/651D3rw46Xdx5L3QbKVH/qspMUSwTPOWWTJSeACueDnBa/7tXZ18GdgNfiV8AVjRAdC+f7cbYeBC8+qx9DxRovKWSMP1YlusVAMI1mPXB7xJH9BVR+ZaHmAl1Rc6MrXffIpW5kQp1dOQiFzg3TTIjMcoN/Ej7jhh/vJ0zCkK0ex72u2MUwX0wbJj19jVWWetqlCdfqAMp16rZmqH73E3yybAZOQJFbJ4HFSER1YgJuYFdceqepky1/z5T2O654LYQlj1bFI4oS50oZ4X+IKjjVzDl+YoEnUWYqXUd5fNvrQBf3Y0H18BQwW2Xcf2tX9Z23j3+F5PBfWp1vP0VBHfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(6916009)(26005)(186003)(6666004)(33656002)(38350700002)(66556008)(33716001)(6486002)(66946007)(66476007)(8676002)(1076003)(4326008)(316002)(2906002)(86362001)(508600001)(5660300002)(83380400001)(44832011)(52116002)(6506007)(9686003)(6512007)(8936002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXFW8B5OROhJQ6QDu0yYOoxmzedPmlcEMh2GXxxF06NHKPdRFc3ZT9rvw5Xk?=
 =?us-ascii?Q?sqltrO5grF5IhiIx8PbRkIm1XzTt7UTT6oDqCDvHIXHvI8cKQ/0dRVOPe3Im?=
 =?us-ascii?Q?17CPR+EohUc3d/vVQpbj+XIJCRVauLRUIR462txdJXzQ/xcce6+HbKNxxFIw?=
 =?us-ascii?Q?EKd0XH+186CtCKFYGCZVMnuEUQzpg9BX+rWTtIQSvIivScoWQ+RvLt/WPv3i?=
 =?us-ascii?Q?SiUoAHTRKJAX/oaHlUt8dvN/JADuByQRduhoJYg0hiU2CQ8EKhoni/1TsNvl?=
 =?us-ascii?Q?DoBTP7joJOsf2R3gLUcVjbNdW6PLsUJXhwvOqcf0KHbtkCwUrH6zrCujmQ6s?=
 =?us-ascii?Q?qznXD6QqfOgWJESPDr4HNusyXaRHAcA0lO2E6N994GWMGJoB8DiXJZ6XfjSa?=
 =?us-ascii?Q?8FEJL9pcruLemdhXFLKTR69XeskmO8zmQP1N823Bunf4tWlRuE3hXpSM4UZD?=
 =?us-ascii?Q?4iTCduwCUtDyClj/lL/iiJxhgUbW7Hr3AsBH/Na+dpsnlShklpj/F7ADGSjm?=
 =?us-ascii?Q?HDI0KE4qGShp6ZygnKCpkeaLgDSt7jpsDFOy/7UfhH6Y3Z+QWofdaWxxZDcu?=
 =?us-ascii?Q?9GVRe0nuTOrkgkCXZo+elx/F53g864mUll9WkhmrKx2E4/2jGvdriM2iSQU6?=
 =?us-ascii?Q?/4QFqTzy54BvQ0ZnP7mFqCSiY5GXjeXaE7Sw9eY+FQMVfuMhh2qP7tIdjEM1?=
 =?us-ascii?Q?kaOknCredDxp0u7U1Chi9Le/DaQtF9of1iRT6jR/e6UF0L7MrOPQXZbVelmb?=
 =?us-ascii?Q?KOcAwQ3GVQnGYxSf3QKsbY4r/g4TSmVju6JWsy1OrdCy2ulRCinqcCBcyxVt?=
 =?us-ascii?Q?Uzjd+hnfsVkfMhk6o72sXsauE6k+SaZrFQ4h1MCD3m//O7L/TvYSBYrxLJmS?=
 =?us-ascii?Q?hoGkHFmzoos6BzFZvch2KH6hNxw3/92Id71t45P9OgT1w7Jk6xXXvxIELwcG?=
 =?us-ascii?Q?o5MpKYdHjnspCrRdkTf+q8fXEnbLMCou9zNVRPnrg4yA/VfIG3FnziX1AAb5?=
 =?us-ascii?Q?QHVO9jkOuo410DFzQy3A9PV3imJSGP+t0ZrN7XM+hi98Lmf3rLOY6Zqjllus?=
 =?us-ascii?Q?KJCMkBJTVJpKbUry2RI9ORdEMQvxbSZMXHmkQv3WDvzokoRGMH3cdeyigZvC?=
 =?us-ascii?Q?W/JM0DQlxOFfTs66XKLklXgAhfUF1fq88ZO+4sNo87wUO+euFSdornfJI+TK?=
 =?us-ascii?Q?xAGTVSohyyk3ImbIMSce5SPI81hz5Mg4gjDSaJwsGk+34E1iBqIR4n5TwJeR?=
 =?us-ascii?Q?Q3HRnmkFAc8gh1XdEqQu0CNxex/DZwJPr1uABnAEy/2VQSKIrVbtDdEb8uJj?=
 =?us-ascii?Q?Sfx5980hiIuvVjzn43pjNiqc4CMxNdQprzRiq1ufRPr3MoCqbr/fC6dPYwc7?=
 =?us-ascii?Q?UKZX88RkUSIZSOX3PH4m3KtLDJN75eTA5x1E6azIny2kOX9WRggWGwCKmUOl?=
 =?us-ascii?Q?IIV/Hmi+QAozHdA0FjCSLn0Aa0jt94wgqcOdgBMWrivu4z0qKefUuQ13kAEX?=
 =?us-ascii?Q?pCHRr6e5iVroMNlbN3fMiUMpSlKJJvV8ZwRQ324w4kPj1qOpIZTAN0IgZNHn?=
 =?us-ascii?Q?PLTfPZjYdVNDlrcITt0Hou3j8jICvAezerOTgGFjexYJukoCbWYPPVKyFRBj?=
 =?us-ascii?Q?eM+7+lQIOTADN1QCpQgYE7yCvdqGa86dQX+3vVjcJAeVWQz81mOp7Nv4swkx?=
 =?us-ascii?Q?Whk+qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2da701b-8049-4509-382e-08da033d9712
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:00:29.3944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsE1lRsEUiC96JsGniWfjlIdppkU2Sc8ZxDRv/9QQj2NoX0+cFLGHbK9LnmPOQifSmObLYyOQkH2f66RWihqSnYGOXCc8RhjvzZTGdlZpkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3922
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282
 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=844 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110041
X-Proofpoint-ORIG-GUID: zVnNUOnHUm2wDW-47eBkbQl78s7k13-q
X-Proofpoint-GUID: zVnNUOnHUm2wDW-47eBkbQl78s7k13-q
Cc: virtualization@lists.linux-foundation.org
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

Hello Zhu Lingshan,

The patch 79333575b8bd: "vDPA/ifcvf: implement shared IRQ feature"
from Feb 22, 2022, leads to the following Smatch static checker
warning:

	drivers/vdpa/ifcvf/ifcvf_main.c:306 ifcvf_request_config_irq()
	error: uninitialized symbol 'config_vector'.

drivers/vdpa/ifcvf/ifcvf_main.c
    287 static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
    288 {
    289         struct pci_dev *pdev = adapter->pdev;
    290         struct ifcvf_hw *vf = &adapter->vf;
    291         int config_vector, ret;
    292 
    293         if (vf->msix_vector_status == MSIX_VECTOR_DEV_SHARED)
    294                 return 0;
    295 
    296         if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
    297                 /* vector 0 ~ vf->nr_vring for vqs, num vf->nr_vring vector for config interrupt */
    298                 config_vector = vf->nr_vring;

Set here.

    299 
    300         if (vf->msix_vector_status ==  MSIX_VECTOR_SHARED_VQ_AND_CONFIG)
    301                 /* vector 0 for vqs and 1 for config interrupt */
    302                 config_vector = 1;

And here.  But no else path.

    303 
    304         snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
    305                  pci_name(pdev));
--> 306         vf->config_irq = pci_irq_vector(pdev, config_vector);
    307         ret = devm_request_irq(&pdev->dev, vf->config_irq,
    308                                ifcvf_config_changed, 0,
    309                                vf->config_msix_name, vf);
    310         if (ret) {
    311                 IFCVF_ERR(pdev, "Failed to request config irq\n");
    312                 goto err;
    313         }
    314 
    315         ret = ifcvf_set_config_vector(vf, config_vector);
    316         if (ret == VIRTIO_MSI_NO_VECTOR) {
    317                 IFCVF_ERR(pdev, "No msix vector for device config\n");
    318                 goto err;
    319         }
    320 
    321         return 0;
    322 err:
    323         ifcvf_free_irq(adapter);
    324 
    325         return -EFAULT;
    326 }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
