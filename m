Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E1BC7EE43
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB7D540904;
	Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB7D540904
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ZHmX0aAh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=WBEbp2rU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3F1USqASgK8; Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53AF0405F5;
	Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53AF0405F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9C5C007A;
	Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3889AC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03325402B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03325402B7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ZHmX0aAh; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=WBEbp2rU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p54HbeJUOLTc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 008434029B
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 008434029B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:16 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjsH020931; Tue, 13 Jun 2023 01:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HiQNkfjDSVAtkdYuWWQJJgpO/PyBKa777Bxrn5zNmx0=;
 b=ZHmX0aAhiqAO5k2v85It2xeqPg/rsaOXg+i40zzseZVJkQleSUr8g6SJQntnFTbmumAJ
 G1cR7h1alz0k9LZxb71PbWpVuKMxve2PEyDcaV5yQ4x5xpdiGHr5qHLCTFi+DaGZe5ND
 RVI37NK84ZGhRV5gVZasNlvLkIxVQbXH147BKPOWdz27HR0BLSqf0QtPHDN5DfZBZA4O
 +TTpaxswxWjSFsmcneRLua39kCEMRtUcEK1FEyVvqEsl0Q2SQT1D8bfya5XsA62Q7Hap
 8vFlXGKxmO8V3eaGxiHqr3x8Q985B780OCxJuecZ87WZYNOAbZzursNTFxjqIXJ3lUJO 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d451c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:15 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJR9021613; Tue, 13 Jun 2023 01:33:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8IUrRwpwEw2MC0ZuUeYw4tnpw9e9JuPteWt6kj/j75ZUhI5eYE4RpYFnVpigGH4pBzbCHiXPbkjHQlH/Y0cbcuOiVPRwTDZVeWSc0pRKFgA8slOmLs+UXyZDpIoXVCTf1WnLapfOIOIMoMMOfXU55sM4LntPhnVEWYbpfJoI/bh+yvfwgn4m+RExmTF9Ir9vmrMo5rZ5EC4vmZpD0co5ShBKYDu6YXuizJg75dBcGwXpGNt5S0BDf5pNfCnqT7ITIHjnwNR01O3vi0k7PoKhM1YPK7+/nEde153jpuf5j5rRA6X5oFevDt6c5L3AFD/OvwFRiEhvQofgVYyMq/huQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiQNkfjDSVAtkdYuWWQJJgpO/PyBKa777Bxrn5zNmx0=;
 b=ePwZlqx/bgVRfAizDW67b7RwMYOPa04RyRubbMVISf5L2yAfSYd/0J0Q1IDGxUon9g2Dj/rCriWKcum1yCXx6w3LWGZxQdY6y9eJKFaFsWOgRPR7hDWqAQE7RDhnL7fAlHm1X8ytWqELtJrTUkVnCSS9vPjuXlq6BGyYMhlhLxOYDChWdyj74GSAZRHGp5Syd3fofpv9rEqKOox3Mqa9me74yxKdpI2pcusfcBFqlu6KUrbHl6Sv5thq7as0SvMUFbpKWWsjc2mxKqkGTrX73cZlH1f1BHxT3O0jWRHKPSsqV5Yudc1hFFnENCJvZ6kcDDhidsVtb7GfMWtnTjHB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiQNkfjDSVAtkdYuWWQJJgpO/PyBKa777Bxrn5zNmx0=;
 b=WBEbp2rUU4AwQYesWDR1wsNkoP+9SWfap0c3N4ojwCQURi0ZM/JFg6XIxf6faM2szVubOrbx8sJHRcPIKE41QPZibWsIMxgQBoQ+dU6B+6cm0pbtdQ06udnFwk8KYo93ov8Ssp6hCOunFETyKWIcw6utKqOgcwYG2jv6eqXQAo8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:32:53 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:32:53 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 01/17] vhost: create worker at end of vhost_dev_set_owner
Date: Mon, 12 Jun 2023 20:32:32 -0500
Message-Id: <20230613013248.12196-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR06CA0083.namprd06.prod.outlook.com
 (2603:10b6:5:336::16) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 40582b19-94a4-4ca1-6d6f-08db6bae1b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DU2A9Q2dO+7tiKlwgxlqIHwgpIYPK1MHkHL3KovDfkM7fBUL/tcKydWGRap54IJ1eUxc2ejAIoeNRDAJ99fZZ0wnqoX5j5475pKeyfzJ6qDXdWbPumJmcXToqo58CwBT+gSOzZ+1CkdZvUdte1vU1UquD8CY9n5f8dUIvMCNOhIBmmVAxdi1egmKtJ//sLfBm65H/Wl+TWkw5/T6KOJ6Tk3TNQcUhZLDsE9lkNWrR+WYArkpsxc27+NtneAfimQhKatvtQSYk5Dza60liV9t6Gb8f6gDVf+Al/Phd8n9CiIXEiCx+wpVTnVCNbtvIp/TgsKDViYxFlsYhQkXcJLGoOI5FlcxJT0dmLNGbGxYMnarFhYnig5CzCYMpTZXq+0W3NEgm7d2NDzq7lSfbLSggljPQBTPAuoYN50sq9EEO7l+vCJucrCr0V3OPUzQy4MO3QBi0F7Aj6r18duh9veZ5Ub/FjWrYP+WlFoDkrMMTFgj2fvXsa3O6RmyXLkxdVb0I3uCi9zSvfxqkoS14ZICUDuXcd6At7jgZ6OV3qWo1nozO/oNXiWk5Z6ZE6CCWcjy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drdHjCS6qsDc/6acjDtDU2wOe49GZs9ihGqNVGbPoRXk9uGjZ7L5xqdoqDAB?=
 =?us-ascii?Q?ixPYg8WgjAgsy1uGjSbsiniC+5TE2sJOFcDyvYMHRUdOopDA5ism1yM6Zgso?=
 =?us-ascii?Q?VEoJObq9FH3FSQ6HSdJKf/5Din5AcDGjB9j4a/AZOoo9lOuYVgHjwvUa9Lx0?=
 =?us-ascii?Q?hamnzsq8JoCk5evvtTh1Vz7dU9fRbORqqBcww2y4evT4hHdv7GW44HytzFVU?=
 =?us-ascii?Q?WodvUS4+pEfcrd/tDizC0qnnxW+BareRXGrcVGJynjSh0cR2tJ6E7kEsIa3S?=
 =?us-ascii?Q?x93mGl79QQdA/3vHIA2WUgDh5RcnL9bqriYeMlEuGKzIha0i8Cvpm2zraOHd?=
 =?us-ascii?Q?0MwHw5r/8Hv22FsTqhDxrl8bmQP6O3YFyPIGVnaSyBW0cL4X+nkHua8alitP?=
 =?us-ascii?Q?dk4WuhISaduUln/1EzX7loVgZFZjP5zX+JXCpx7m2mZsIUtFQfoLGB39kc01?=
 =?us-ascii?Q?cyHo+HcnOqFO/A3+vJILVpL/6pXsGunac9D4WOupoUyS5txq9tPtT7s2GyGd?=
 =?us-ascii?Q?oLJZJrHWl05AuFUOuDpu2DZghFd4oWNP0h5PC3sy/oDovKl61VJ4J6XMHOUT?=
 =?us-ascii?Q?YlmVxZE+TZ8Rz9EEHmBYtMU6Ih/iLbTHQpZGRDd4rY7wFaMVEzSSCaXVmiDI?=
 =?us-ascii?Q?xSffBOuTEWa4H5hPnH1JdgszyUa2L2NSZPHzZ0ZaPXOiG5gFJ65dsYDmsaLI?=
 =?us-ascii?Q?G0AXFTVCJb1JLmKxvTSYuYzgohdmP9PGfaZ9sFk1HheIE5lFvi5ygc5hJrK4?=
 =?us-ascii?Q?UOgQ5d63WAr30boch3gU6FUwDrw6X6yakO0rzY6/ocfrgSqg+t4flYspwHgL?=
 =?us-ascii?Q?27EXk4iUF/T661irEdm1cqcikvJLqsdfWC2OvrU6cu2HX61FkwTah8K08i2V?=
 =?us-ascii?Q?nQoWAHjEdSU6HuyVOUiu++pYf4l343lEN+XXcGlsP1FfJVGhzo+FvtuUoNCQ?=
 =?us-ascii?Q?fONvOo23XvBX8QRet+gjBto4saXdh1RcAktr1cu8I2llcnJge4egxUpzyoWU?=
 =?us-ascii?Q?zsXY9mZj544Uk5KJA6KbH1IpBSrKB57n758g+sC7z9gHUB9meMcAqxIXjyF1?=
 =?us-ascii?Q?2Z4Ukc9IGewd6OXf9jDiatr2FbFOdhr3u0zv09Hu4w4+sjO82+kexu13C0Y/?=
 =?us-ascii?Q?BycdvtBbU95Xay+hsxn3+fmfY+iZjK3UzPkeNuQU4+UPycZQ/xenWQTopOwI?=
 =?us-ascii?Q?oKJPWVa/HSxkA1/JzTbwh9TvSEWAS2BhqO1PevAcgx0lgKtBliSOEbkv/8n9?=
 =?us-ascii?Q?KztmsiXFyaFogGHmwgXagfL/Sre13+w6j4YSMOtZPMDWN/Tfur8ryAzP2QIZ?=
 =?us-ascii?Q?ix2wZ9H/JmMwpU6dlzZAyD3j5DckoZ/rZGLWP+vU+nVIBGs5AI+XoX9JiygK?=
 =?us-ascii?Q?gi6FVC/5biN5BZV4GyOL9at+7MS9XTmZcM8WOPppwhpdKSfYo6maO5qvlQdb?=
 =?us-ascii?Q?OwP0UEl0At7MlR7vs19t/PCT9YYvP7ox/pSX4qfqPOb/x5Nu5kOhlfsvnUJq?=
 =?us-ascii?Q?1RsHkZggKtpnYuV9C2i2ATBVcZgFviA8IKP2VTDc7EACixxi+O/Dk30/ITbQ?=
 =?us-ascii?Q?9oJ/sx9P8fmo7xXBUUVVhrx2zbr7NzndkGqyYA7TnBREng0lckAlEoasXS8Y?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AHPB4CGLCpECJ0ACWqLc+apG3MmrayT1SAcVhLsXF4h/V2M/POzG0UxiyUsLsaE2m+kKux6C1svwlEupHZ35m13S4/lb6qLIX0uFko6Rf4iDK2eqZ7Gb8HCQGqJnZ4+oTKGG6PPr6QZ2+YSdPUZZ6QlhPb3kT2P8mk8p3yMI9CW1RWqw7ADkiNCzaLWmLZgOCOnJ/PBUlbir84z3yc32qq5B6og5fYe5OE/nDRKR2VABtIq5c+HNSEF12JLt3r/pVJdh6Qgz06nUEWqh8HT5vyQ+cwgaz8UNTSwyUUL+VTthtrkjpLa5vrlBtl+oh11EZtopCMAXFWiBMfE1qAMVbMuQ9oVtCetbrHlM0gkt1cRix0bSTsXdUsZfqnNKJvqZmfcnvXkZIyeKI2A01ik4K57gZ+8I6Mup4moYa62wkdQHv7XrJ5eG7N0r4VNtsBVI1bHoGH7FDvyi3BJpLD7q12CGdteMldKOq/lMUX0wVFOUx1aLkmXYX/rgrJFM5NXNL7BpR/d9FDQl50MKwng1i3HeTzpVDYynOqlKTiNCyy+Y/1DDGkBhR92g6Azb5TrW+JFfeikHRZ8Am/vgNU5GChN/4S43ICsWD1ClFqmFFjdyd8TkwElyJw5ryckV8YooRQz6PBGob1ksBqr1lmKecQGYYgQ9VJL1dMhCRSfNXe0AG3scXUjGZoysmYXuFe/yjIZr7DZltGDsqzUaG9g+U0reEVH+Spq03uwwQ8lK8rAMx8caxYn79LDQpyvjRRMQMGhbx8+i7SIhcJuoLNqdMmVaLE7Qj/LI8wQyaUe8kXL57wzp2MYdkSK+Fv4tSgE3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40582b19-94a4-4ca1-6d6f-08db6bae1b5a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:32:53.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAN9tLhoVgXlw1QA0S/6yw0OJRvYtmLUL3hv+cxPoPT3fTsQKrUYPCA871epnsiX/xF0nhAy4wKP53j+hATA1brRFMe8MWXJJAgC6oTC9Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: ak__aWmQvfuUxXa1JCCl9ZwYka1tT454
X-Proofpoint-GUID: ak__aWmQvfuUxXa1JCCl9ZwYka1tT454
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

vsock can start queueing work after VHOST_VSOCK_SET_GUEST_CID, so
after we have called vhost_worker_create it can be calling
vhost_work_queue and trying to access the vhost worker/task. If
vhost_dev_alloc_iovecs fails, then vhost_worker_free could free
the worker/task from under vsock.

This moves vhost_worker_create to the end of vhost_dev_set_owner
where we know we can no longer fail in that path. If it fails
after the VHOST_SET_OWNER and userspace closes the device, then
the normal vsock release handling will do the right thing.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 60c9ebd629dd..82966ffb4a5c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -572,20 +572,27 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
+	err = vhost_dev_alloc_iovecs(dev);
+	if (err)
+		goto err_iovecs;
+
 	if (dev->use_worker) {
+		/*
+		 * This should be done last, because vsock can queue work
+		 * before VHOST_SET_OWNER so it simplifies the failure path
+		 * below since we don't have to worry about vsock queueing
+		 * while we free the worker.
+		 */
 		err = vhost_worker_create(dev);
 		if (err)
 			goto err_worker;
 	}
 
-	err = vhost_dev_alloc_iovecs(dev);
-	if (err)
-		goto err_iovecs;
-
 	return 0;
-err_iovecs:
-	vhost_worker_free(dev);
+
 err_worker:
+	vhost_dev_free_iovecs(dev);
+err_iovecs:
 	vhost_detach_mm(dev);
 err_mm:
 	return err;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
