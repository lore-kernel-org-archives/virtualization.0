Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62331373
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550045; cv=fail; b=Q69c+X0fjQVIyXu1G7VC1gPp6k6pdRaIKYR/txhmqe1/Tv94VQ21oipvMdSP3MzdFdrDSHZprxIIYDgDKkkUxkFpuRwNkZTGhSPrzxj7Uqj9JH2Hbpe3Z05Iz6Wx5dCmCiPqYSOeU0mfHW5Fm/wYtMAVjXHdIIkNNF5EQaOH4ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550045; c=relaxed/simple;
	bh=VRlqpNoIjsd3nFZmxsoYNsVb/lbpIvjyvMgdHzAVXa0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Htxe4LMzsQDUTlhjHkQw2raHhQY4iscYOp53th28XQwigSv9cz5zNcwt8soBjRimYpXhD9ceLGK6iP+OkzL+vVHwZYv/j6Zt0KzUplYCG+H22g7ocD88ZK+/VID5wh2lzhUa2K8/SIiE9FeAY7gKh8sW+GWxRboT3SPUevqwDtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O3htGzsM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t0h3Dsyd; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O3htGzsM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t0h3Dsyd"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EF6060F36
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rS7Feg4Ple1g
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7829D60608
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7829D60608
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=O3htGzsM;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=t0h3Dsyd
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7829D60608
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:21 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9f1I016937;
	Sat, 16 Mar 2024 00:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=VRlqpNoIjsd3nFZmxsoYNsVb/lbpIvjyvMgdHzAVXa0=;
 b=O3htGzsMNcgetbR+nsGszHZElOS2xvpBqiV46T8ENm/QuXGPIf5abeH5t8q6XEsvUgWb
 qQGL4LHr+/HOkq7XX1dWVLpooOz3i7YFg45biuVQvZr1Wn13uh+0KMU+KAAl2gGZAReF
 bC44URrUPKObj12TBdMbcFfpYDdczjm6HC2E2i4T6wfzhhw/gOvJW6o6plLVi86uddCv
 pW3oIEJ3Mplc279N+3779Btf5RK+/11tA9sNf9S9nJF0WozzP+OjccN2zv0fCAggl2xu
 9DxB1K2TwmThMTRMq1bnNgvcKPVj6e+/r4/OiBo8YRRNWD6VKE2L2qbOoi2BLTh4ISVp JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsyggs94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FNAvi4037704;
	Sat, 16 Mar 2024 00:47:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtmmy3ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4qUFgWE0ZbXQIhy4O2f3+He9cvwciEbBVVTHpty2/FytoNDCmgV/yOuR7Q3+BLNiP2hfo6ICOC1m0OKRvhvSvftsELvJ23u+wodhpHRuAozCK2FpPbSz84umR6pdkRAHu5f4UdurBQ/nWMR6aKh9vIhbFoc4K80o2HQBKkmx8t8Z3dj/jCQA3fI5E6MVu+jAwuhVWPyRMZGRh9LOsRlXmXU4kUcUCZoHMsbd9mMDDffsSmE7fJCz3lJHl10eilBNxut5tfax0fXeExJvc83XyjlpxP74zM0gJOxOWUWLDjmC/FgSLlGl49joPSHUykmfkFKoPQnmCSev2S8bJNpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRlqpNoIjsd3nFZmxsoYNsVb/lbpIvjyvMgdHzAVXa0=;
 b=ImqlH8qeCQFG3AekWqM54GGxnTy6O8u+x/oIMNvpypxw0nJWBgE6wLDUVG9mP5RzLU7mEvzHUgVukoNDvgmOgakDWhUdIv5kMXKbfMZeCTtlFt8v24mQptc4L7BMzHYrEO75i6y+LqQXGRJ+cLCzVI/hDYeHa61KLNseNgP/6JalC0vm/KXD0XfubXZMrR9VSn+nz1onTxyTiTt5x7pHOczc4b3FS6008Akv2KeJAljwE6mrtfToUy/WGN1IgcP45AOVPXTrJE6vxaqBMTL5cgpRt1QOumidytoym0wOLdreZXUJ0EAymg3Doxei/Ccpg5VoYuVcTTStabRst/+G0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRlqpNoIjsd3nFZmxsoYNsVb/lbpIvjyvMgdHzAVXa0=;
 b=t0h3DsydVihZrLqEzDE6h7QTYlUMP4+CdPZsPiz8BZzEl9zgZWpoRbAh3/fPC2eDdxkDIbC4YbkHcFvUGOZMU7TJdzwhCiAPcaMiX7lyJMaoSQsa8a57mJeWHWxuvBjfqYMrZ71rbgsTmvcvYTW7ifd6qiqRtASF7hcdPIyztLk=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:10 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:09 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Date: Fri, 15 Mar 2024 19:46:58 -0500
Message-Id: <20240316004707.45557-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:4:ae::41) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efca864-66eb-4699-a3d5-08dc45529c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bCYHM1A0dD5Y7IZTXKBPr+5uf/mFX+Do84F7Ll36wJUycEwnYR1s2LWLy5MbWos6xzxiHQx3wAuU+qJaFn9ovKKip2XycgP2J8PjU5f43nkvF8/DVPsTFMUX1XvLHTPliXyjmSDQk9dJjDmWA9HZ6XrXAB79XDL1ndpEmoZVmslPuS9JXaA8b2/kYvJv0DVvfoSxdHudk+a2U9rLndb1b2OguL5lZm+kJf7xA6t2JFvR+jVZHQ3gR6lfNiU5rWHtoJlky6qiPmdfcixUoQuWfIB9d9QnPptXdRdfm0q0Pqcz22kMIENrHTPOFoAWCRyJHB2n8+bRZXyoKr6rlg1XDrFAYCSDFQ0W7Se4qxK3MqBY/WxqtrkGFpzg0r4LR5j6Y9SOJDTJHg+w8Pwkyqcnn28DmunqIE4oreyNRVaPKf9FuKNtd6stzc8dG2E8GjYe5nDEvn8xeW/sFmhEuwTlz1BCdTK+pnEJsRWIi4XkvBt2LnXBQGV428y+XqTESZx2lTy47Emo8LAp2H+5vYDrE3u/MlRevPG8HbBEKwbNGv5NRTgl9gSQ/sKq/GBAMh5b4oVMu9z2D2fF9UbJk+sOjrrZfeJPJcM50xSYJ2XA8d0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fLtfu7wYCPJet4Fmz73MYG28tdYaEuLb3vr1tWlVGJOTpEzDJEL4TMN2ayE2?=
 =?us-ascii?Q?yJ/U4JAZr2mjAlzi6Gd9B5rG8Pj0WpQaQxzKIRa7ZG+s18V6bMjFlpImjdxf?=
 =?us-ascii?Q?46wYvBx9U8GKPHv31SGQS57F3+h8KkM7a5CtI+KfnnFd8j93rTsyr5wujVwb?=
 =?us-ascii?Q?bqE2PN/CyFlhvJlJS/2dXNjoyAW+THlA6QIidXBsRbuEwacQP60hxBGyJaFH?=
 =?us-ascii?Q?Lfg63pmwiQDhWHMiPU6EFcxPn4TdwK6BW8MtR8GJ18Qf3JGspC4muqG62Kwu?=
 =?us-ascii?Q?i4H/n/CMuMZ52ghZ4vRsXxF333VyvH3xGfyTMmIQtnjEB2bMdRD3I5d4B5ye?=
 =?us-ascii?Q?Sak60MpTBN+mTmnwW3IJ+NeYODN6j7CzZeZVKMXeQ1ul6ywgDcRKo1B4sJfw?=
 =?us-ascii?Q?rSUioByfFGvJZ6x2YnUKV4oksXZxUsdbKHxmMUgcNpbO+J2Bj4NaAzgrTLjV?=
 =?us-ascii?Q?nRF5eIO8DCXgLQRMBAxfBtRZWTpYr2jNgBLWiQGYPjPG2dkOnSlfiNRcxjPL?=
 =?us-ascii?Q?+d1CvnlJS4VL6ykJjv8MN1j1T5pO8O8YuRSgfZiEypJwHkCiTrT75XAohR6l?=
 =?us-ascii?Q?4a99u1lPpDSdKkaomaCgB8SIOAIVbrVLVEpJSQ5/FFLo1E2Kotfk6cEQUykU?=
 =?us-ascii?Q?yqY5PcjvGEyr36fdDyXx41gfzprWAukzmJ/3UWlh610/snRZ92Aq5vQLF/KY?=
 =?us-ascii?Q?BTI59Wmr3FqSl89qLo+EKsaIZeOBSqpn6GSUo6bcX4drFsYl6jpw3hgsYqCG?=
 =?us-ascii?Q?dUfPazlBoh6r6IS69eawpaAq4lf5MEKacsJ0cTksTGQB+/KE7W3gGPbeaWIh?=
 =?us-ascii?Q?Xz11WJyqOoBAxrBdEwZ5AAEoLzGS1mvQ6BAB8HIJ04C4nnt/CsvOq+Vvfgk8?=
 =?us-ascii?Q?wMU1KCrcJsef+oRGKGfRLqkdmo5PfrIbi3NC9fWn3Penue8pM6q6P3U8nEu1?=
 =?us-ascii?Q?+Sd6bV7Kx3tY5uy8X0ZIUY3aJ9ooFZMzvrHv/JSb0j54Fr526gbdDas6kpPP?=
 =?us-ascii?Q?snhPFdQtY2af1wnGj8jyujawywZHdnp48bNP5ZvcwQztkbkRWVjLl7HDDMz/?=
 =?us-ascii?Q?cCcQ8V+PiL7Ob+7lc0qYyZR0QQCgTTZKYQE8HEj9Y5eNFTNEtSBgS5LZ16XK?=
 =?us-ascii?Q?NVGcLeb5O8es/if5d6oa+qitsPXRseL70yt9AljPfs+8uN+mXdykj/R4SC7s?=
 =?us-ascii?Q?c4cWq1V/sVXDkgF/JWkJhyMk7iYmvUUXMBy+8G/Sw3nn59vNovT9RdyxLqAT?=
 =?us-ascii?Q?ZTiJtoG/Qq0YA9oDpnvZtlfwtclW7UjyLPXr3epzAC5WagEsNALI0bn6jRHg?=
 =?us-ascii?Q?3vGacXaJMXXK+haT9hJiGi9mcQa4NIBVyHvMLB+gK/0wkRBU1pMLrqu2Ho1S?=
 =?us-ascii?Q?iaLZ+xzSZ34yUvLn1rMn9h+jR9V5+2nLCCjuqU+M8tRT6rTD/k6p6wg3BDMC?=
 =?us-ascii?Q?WL7CsKGrnWz4L53Y/oSAPS+nFg0eUHaK0swmST6AZXuOAFmPwggpuqt4vpOL?=
 =?us-ascii?Q?GDbD2BTVBPxyFDAwFGvbR63+d9XCkNrqbQ81l7h+SyzKxwP38ODXNq2yylyH?=
 =?us-ascii?Q?bn+RellS2vzkN2+43ENX/J4COpEAoq2F7uhEoZgMeFMmOqbuadmWHFNiWXkd?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+f/S53Ifn0imjbQ8cbUE+8X9NXo/3QZDvEDESbKZqt7wKWY+Z7yi1CpQ7HOSe+sQxo5YgQT8K+1/iF+IqpWtb5SjgPQfHnwE2YOhw20KRbsAzGfDemCZCPEtG7c+bO6kKrOB+uYruFfC3tkIs4TiN5iLSHQwGn+471ZV5oS3FPj9lmdcT2yv6zjqt6JvFWhV5Rro6RW+HVrW1YV1yzJNPiuw7VkX2sJzaFjkfbIQGX6FypL/+oNdiRpWljoTRLTIHhX+MG4xeXCrlMikxb7KYJ7Twh5Q6nUk5jiuXpoSkLJ7Q3DbHJ2dhKgovfcxDLODgtJ2DmD2ZAkq0mhWIiePZoYqsm0CAaV9zwdlx+EdcioWjgAejY6vm6ZTMjxg2rI2Ggs9Ie61krDmgWWL8seqowNUIJoQQyu6EI0F9w4OPW2UT3Ycxwr+Rdg845qmpx2M2fUYwS6k/Tk76im9sc9XMfJpinR2btd7P+5Y5qkRsef/Qjbn4Tzs6xK/SkJHvtvU/TC+oUhhUKnB490zrg0O7kBGlBr93O+dTx9Smtw69BATnvXj8TAIQzzh5OkBGUJi0mSGbJDRYq0a5rMnxvwSP71HB7YDTbMf27jxsYi3QWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efca864-66eb-4699-a3d5-08dc45529c9f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:09.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWFFY7MAu3XnX2MI0vzLcq15xCidDvDyRgrNY4E+b4u9fAGOzLTk1DgAB2ojHinStG2G/w9AD5YZ1rZRohGbjYlVcF4fkJZSW2mIkSRLtfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=669 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160003
X-Proofpoint-ORIG-GUID: ixxh7xe2ewhhdxFtWCji1rxJ14WZE9ob
X-Proofpoint-GUID: ixxh7xe2ewhhdxFtWCji1rxJ14WZE9ob

The following patches were made over Linus's tree and also apply over
mst's vhost branch. The patches add the ability for vhost_tasks to
handle SIGKILL by flushing queued works, stop new works from being
queued, and prepare the task for an early exit.

This removes the need for the signal/coredump hacks added in:

Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")

when the vhost_task patches were initially merged and fix the issue
in this thread:

https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/

Long Background:

The original vhost worker code didn't support any signals. If the
userspace application that owned the worker got a SIGKILL, the app/
process would exit dropping all references to the device and then the
file operation's release function would be called. From there we would
wait on running IO then cleanup the device's memory.

When we switched to vhost_tasks being a thread in the owner's process we
added some hacks to the signal/coredump code so we could continue to
wait on running IO and process it from the vhost_task. The idea was that
we would eventually remove the hacks. We recently hit this bug:

https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/

It turns out only vhost-scsi had an issue where it would send a command
to the block/LIO layer, wait for a response and then process in the vhost
task. So patches 1-5 prepares vhost-scsi to handle when the vhost_task
is killed while we still have commands outstanding. The next patches then
prepare and convert the vhost and vhost_task layers to handle SIGKILL
by flushing running works, marking the vhost_task as dead so there's
no future uses, then exiting.



