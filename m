Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F71C2D
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550048; cv=fail; b=L9x36afvIPujVDpR0PYEf3PdqrxcIg9wNlTkDyVS3TldLeVxZJH8WcIvxTBDASAUQA+9jI7goHTSciw8ZUsgp0WaKasxTLaN9nCcXAUk8tgOc5FJ55vvrd2B33B1VUaw5K67qLqDX1aY3LJdmjeiSyPrr7ewOfZHgnDi4pTlG1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550048; c=relaxed/simple;
	bh=CVBzBBXi+vN6G9YmEugDw8DGpzsJHCeCkOCVjdmrLAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9YnbJ6KNUKor5XUWqMGWy2T1yOuAHDbvoZOxGQJ6CeljhdkMmJiraHxM1dk+jKre11ixWbtBXxkA1705fzexUPdXrpB7UcWvQmR4KlEda/tQESrIsfLah5RFZfqXo2mK20aIlEn+TvLhK644CmuMaHj2gAuCqrZBSo3+nJz/5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h5ew8TCN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZB6zM14I; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5ew8TCN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZB6zM14I"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D6D741823
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U2k8wB_TbIc0
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 513FE41812
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 513FE41812
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=h5ew8TCN;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=ZB6zM14I
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 513FE41812
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9FRN014781;
	Sat, 16 Mar 2024 00:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=gyGahJ81nGozA37p+xFGgYm4z54C95f59a23fg3PEdI=;
 b=h5ew8TCNeO0txOV54r1FgrfWAxZCIb4X6zZW6b9/x/73mqkulnIF6NTh/VAglnMi6KYp
 6r8TGM2jU/EyIHocK5+J3zCOVYbyOSK0m9T20oe6EO/T1P9u+sNW2+vsJb6qigcSU/lR
 bx5iuG9aNB5EWbKXfSL3IZn7sCGKXb6v94XS/KhnqEuc5cLhpUD2hbVmt+K7kyQQ+66l
 DoZWn0yfxs2ybrbUcbUrs7j8V9mnw6mtE8RFTk6cwWUnNJMy1NO0Oz1GCS6fmdjJ/7pG
 VHXBsnnjiRfgJng6R/WAmWihgUDEg9bHJq6GDIwHrlaLRYb+ie3NQdNsubpfD9eq//nj NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxk0sg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FNCAdN033729;
	Sat, 16 Mar 2024 00:47:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtpmxexb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L35nwUGd2/XDxmg3McqgSaN19b35yYvHzLOfdRYZEu4ySYkUG5hJlbp3jOFLyu+sHbrfm8YOCO1vrxPelCctf1gNsr2xhzw/Tc4kw2eDAkBPUo0H8Mf4lw0QDSyCvCh6u5NwkDBA4bT0ENRtZxQI4t1KJ9IwzMt7FyIlFkqzg3ZFzbtihTLMAdHxPysSg7abfjiT3g5KCUL0Lfj6q6JEDSSirmoBV6yWnCAA+Lf+pNyRBJBHB9dI0LXM25REYnG+oTZx9XrMPfwP+0dT0e6HaK50CD6GibtoY3R7v3q40dMvaTL3HuhJFMWHmwzdxXxXjzjQMv8NNuCzxGud/WRJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyGahJ81nGozA37p+xFGgYm4z54C95f59a23fg3PEdI=;
 b=S0LY3T8mg4l2BXnA1IN/GZlZbdmPGk+5Ebg7LwWg2sPLin8gsigItrZ+YCT9arw8KNMpuYabl01DuvuABw9TY1cLQW2+XbFI1yWuKhhFbg2iUzuzS1v1I9XOQVIktu1Nylv+14XeAMHM0eaSos0vj+0ljmNTCZ7u85HMNP15LFk//zNENLyUe30wUICikPK4XyVDqYGahaGmlDMIaBjOd/PIK4Fo0yQSVXnwYHh90qXjnYlT6sK1FPLw1gr1DudpDFzpLBz+ke8Ae3J2HBWf85Ao65PQdmQ7NB+Ae0mOutYA2bg/l91lUTi78mQ7p3wXIUv3iYjPx2QblgIYxNuXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyGahJ81nGozA37p+xFGgYm4z54C95f59a23fg3PEdI=;
 b=ZB6zM14Iu+Kmg1U9RgL9WokNVYUqZextshUZJwdNHPj5TQW+r37fG0/n/rZOhUCJ19fgROhy/g/RgMvYuo5PFbQ0Hcrf3kSb14/He1CFQ6f3UIAVOgZQ4/G7xE5FHKmlqvDfaZq+g8mHH36HFNjqJfCjvE9EVDqljQAMSmWRV6I=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:14 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:14 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 3/9] vhost-scsi: Use system wq to flush dev for TMFs
Date: Fri, 15 Mar 2024 19:47:01 -0500
Message-Id: <20240316004707.45557-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f4fcbb-b586-436f-9b80-08dc45529f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	w190eLlS93P2ZCqz4NPglBFu3uA7ABPw4sOt7svl5Fpm08/5i9IpluBwJtTly/JsGgvHRChvzq73NerZpQc1SaI2xpfCpAoMokKJqCPU0wTtvyuXS1IfSBjKY1qy8vohdq/elN0eqJeTunwTI6OTSduzaW5vNogpa3srSOvgSeggggCkCPYoo+XkU/IAp+9Rf1Ooq6BA9yhDa/9EhSuLpBpJvr+WC6ZhAJ0gQA7udeTvXYRtSv/m4lBe/6kFV/pPyfQK+/fQokv4ih8TJ6ABqj6SW7bhj9FzfDsyOm1n9YH+FOet/UbmSoSAuDGgh0xAMzs60RBbRf1GCg7dDbIxpehtPvxhNRoNO44DdrOX+2v4toEznBb7JePZ7vwdvktTwIQArzkoOy7LKGRBx7nEBrcGsTxAk0K3vcstCivtCK18wfF2u/gnA5YOny4qC0pz/n1r+NIpRYpcpp4I620eTwgseKW5QHjo/MxAJv7GhK75lUtvIrhrzcEOg6w1oSgAPM+xiOvARSvSpX4fc1wTNH1xTE9RtqETqlzPAkjEGW9Uf30nRDdk0gsQiMuIFB0r4AMC2UELYu23Rog9Zv5YGhdgRRxlqVD+5BeVhAbI/fDp51dELpqhefl1On2whD9wLWbHlRkvcP5J0vPHTmWPq5Ue05UR7pTyjtX6SOVqR60=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nTotTkQ8K2Bjio3D9QzB1fxXecPilHulLN4nzfOD9Mg4cB7rzLS+gUJVsUkN?=
 =?us-ascii?Q?Xig0EQIwiWe1oD/RXCjOFsd5pTsqvNeAcBirkpi5cFejWSk974j+BKxAAbKB?=
 =?us-ascii?Q?Ng1YmZc5L8gTe7nsmWV0NqwA527yVDzEa9mL7IEGgzHr6X1Xdf8ZCoVsJ+/1?=
 =?us-ascii?Q?jFMHjM3hho3QANf3v9u0JyNllClxMH7w7S9c+NnFyrk61dXWPG2OXi/4t9yD?=
 =?us-ascii?Q?YfvrRLQ2+FNCXLLGBQkxOjQK0jUqlmiF4D30oqu6kedLVapkXnmfcmqT3mAW?=
 =?us-ascii?Q?3HTLngBvHQgpr6lobQgfDFO1NtkVSkQDQB/a/E0qjvXJgXuXIO5snF/XY4mQ?=
 =?us-ascii?Q?ZstSme2wofxCAFA137FO9X3dr5WyJbtcoYL/6T2mYhKI7Hl1ND1ZtCYHSfcv?=
 =?us-ascii?Q?O8I+KnxmrdG6XXRxTj4x5Bb18qCfkLZhjdTxMFXZPFXFh40KQvus46THs+K9?=
 =?us-ascii?Q?KIOIjOwObnImca4WNsUeHHnGyslnkGCwZYENilKE3BvaUFcg5E31GnWvM8d5?=
 =?us-ascii?Q?wsGZbc65baBCopE41SRWqc1ql8VSq6l1pAChSjJUxyKF6SvgFKhIrJAHGfnN?=
 =?us-ascii?Q?lG0z6pnY+rHbhA9HjT6eS5PP5CW0sez5VFwo8078Au58V7Ay1W/0ZCcDGG+z?=
 =?us-ascii?Q?n4z/ha+MBYEGEJCTxSkz+0arkNmEoh+VaxSzEaxjFcRRYFTmtKzMkFn47LYe?=
 =?us-ascii?Q?pyRqBpI3lNzMFdsHxBvwzZ6sA3HQvITfq4D+uRs2Eeh3O6MR1yTRaWdChzVd?=
 =?us-ascii?Q?lN0S9OV0JYE5Av/2VG2pS97vCylieyngidgjZUK1PFWtn9a/i90WY5rqVnvj?=
 =?us-ascii?Q?7nmm/mdROBUjpeJOwhtaIVKq0zz8KMNGCnvU5m9xi/iyu6AbLTvg4pmEvtqu?=
 =?us-ascii?Q?/zHwoZw1imTJOZI2g9/81YHudz7kFIgs7TJpPyX+mSQpUQubZ8mZigVEyOEk?=
 =?us-ascii?Q?RtlL2nsGaTrU/Z3B+V3fhuExD0MFbD6g1JvDFrSWiT+Ihww9Yv6owaffV8fw?=
 =?us-ascii?Q?/ofW8sFDUV7bNHBmC2TB+NHkI6MBj53W1TmL3EWbLFjffy65bu7XrlwCsGNv?=
 =?us-ascii?Q?Do68A0n2E1u11Djc9C/b/u3bgARuHtfompL42R6WJvHqu6KNhzRaTFeLaReo?=
 =?us-ascii?Q?RjawIgL/jXkWdSEgfEaQ95QN9bdANNgeEmDqBpOdTOUSXSORsZiWd/w+sz1B?=
 =?us-ascii?Q?XJY4ED/WL+Z7IX74KRkPh/BHYhVh4fUUPSPUVFRafptBEUKIdnNW0eM5t3Sv?=
 =?us-ascii?Q?ngBi6vk+2xDSN4zRF++ZTMKMBNqIRdM6WFJQDFW83uTmFDfZ4sjPpqwDaH2K?=
 =?us-ascii?Q?kTDgrmtPB3OfHWvcF4L+T3ZJ0l+w2Tmd6920MmC5oOzhRfr34jnSQazvPTpG?=
 =?us-ascii?Q?EUCYnKN6mKp17ykOyFYH3nc0TNIqUnWjwdfp7+A2bsCbmY8GSIRq7W2NneaN?=
 =?us-ascii?Q?oyxJXPfP/RGl5ZFAaCE+x0ZuM66LNZ/X5jEfHWypt/IJJKC/ufwYhyOWPrfd?=
 =?us-ascii?Q?S7I3XlnlIVc83EXA/54xqxil406TFR0HF2BB9VZLZy6UDWGBl6bKrq86JAMw?=
 =?us-ascii?Q?kHxjQ5SKimP1/eHqv1RnWyg6znTOssFK04bsiqnEK8O5UpwFkBqkAlbP/+wz?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fZ0/TTGJT3s+bvCw9GpWXr+Ak/Bo3vqhJKYRIS+m6HnidnHirWJS7Cva9n4OUE+QkN20lCNBnbKH/D6F4sQGJRHeUWRfc3lJ1v+SA2/UqMspVp05h959whw/8X/oS7z98VVWGW9+bJzb2KTShE9WyS6JIlrGpKRn0EWWl2Gi8ZJWJ9Ujmh4XpI+sWN6uavSeev9zevkdBUjzL5mIxKTcXAuF2CcR8jfs11cdWn4jWioV5wf/mWsPCXEavT7oPQkdTCTZjw7ixVfvnh0OyPdruOKjYhPgE6T+6PjmXppfNEUty2FXH6Xzl3mqakjqXLEdmdaYd4qXHBPUHSuPq6IbwNpOc/uZG8hpEqSBQMl7PTmuV1ZYdocUm7t/mdsWwvic/Il0nTnHkT5bTdIQ0Hs6AwjeEyj6VKcjTqyiso4B3st7gjv57UHdDDIzRzaEeYL3QION5OS28BIoRxpE+X7fJuf1G6qhr/31Fy2GqRivN16Hv0lWTvJKPUi3RoT2Ox7x+JBy6Izzn6GOQQU4YySXxgBnZTcQSMHxQ7GgXy8Zx4I57gyzdO76V7o6pw4JdwpFVZS+LhKLSgoaJlT8lrWhBooIEA9fwn7F3xg5aZ79Vck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f4fcbb-b586-436f-9b80-08dc45529f47
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:14.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbhG202obYLACCY67+i77/nlWOZr3je76HxgGhgpF3z/6Dma+yh3+eGLwJtrvEl/6AakkPAi9Y4K4CRGwfpp2qwg2EBbI7P5IkPry1hX3ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160003
X-Proofpoint-GUID: ucTiObGyNBmmZErv3aY0S7vDeKEm448a
X-Proofpoint-ORIG-GUID: ucTiObGyNBmmZErv3aY0S7vDeKEm448a

We flush all the workers that are not also used by the ctl vq to make
sure that responses queued by LIO before the TMF response are sent
before the TMF response. This requires a special vhost_vq_flush
function which, in the next patches where we handle SIGKILL killing
workers while in use, will require extra locking/complexity. To avoid
that, this patch has us flush the entire device from the system work
queue, then queue up sending the response from there.

This is a little less optimal since we now flush all workers but this
will be ok since commands have already timed out and perf is not a
concern.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 6ec1abe7364f..04e0d3f1bd77 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -210,6 +210,7 @@ struct vhost_scsi {
 
 struct vhost_scsi_tmf {
 	struct vhost_work vwork;
+	struct work_struct flush_work;
 	struct vhost_scsi *vhost;
 	struct vhost_scsi_virtqueue *svq;
 
@@ -373,9 +374,8 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
 		struct vhost_scsi_tmf *tmf = container_of(se_cmd,
 					struct vhost_scsi_tmf, se_cmd);
-		struct vhost_virtqueue *vq = &tmf->svq->vq;
 
-		vhost_vq_work_queue(vq, &tmf->vwork);
+		schedule_work(&tmf->flush_work);
 	} else {
 		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
@@ -1287,33 +1287,31 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 {
 	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
 						  vwork);
-	struct vhost_virtqueue *ctl_vq, *vq;
-	int resp_code, i;
-
-	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE) {
-		/*
-		 * Flush IO vqs that don't share a worker with the ctl to make
-		 * sure they have sent their responses before us.
-		 */
-		ctl_vq = &tmf->vhost->vqs[VHOST_SCSI_VQ_CTL].vq;
-		for (i = VHOST_SCSI_VQ_IO; i < tmf->vhost->dev.nvqs; i++) {
-			vq = &tmf->vhost->vqs[i].vq;
-
-			if (vhost_vq_is_setup(vq) &&
-			    vq->worker != ctl_vq->worker)
-				vhost_vq_flush(vq);
-		}
+	int resp_code;
 
+	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-	} else {
+	else
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
-	}
 
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
 	vhost_scsi_release_tmf_res(tmf);
 }
 
+static void vhost_scsi_tmf_flush_work(struct work_struct *work)
+{
+	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
+						 flush_work);
+	struct vhost_virtqueue *vq = &tmf->svq->vq;
+	/*
+	 * Make sure we have sent responses for other commands before we
+	 * send our response.
+	 */
+	vhost_dev_flush(vq->dev);
+	vhost_vq_work_queue(vq, &tmf->vwork);
+}
+
 static void
 vhost_scsi_handle_tmf(struct vhost_scsi *vs, struct vhost_scsi_tpg *tpg,
 		      struct vhost_virtqueue *vq,
@@ -1337,6 +1335,7 @@ vhost_scsi_handle_tmf(struct vhost_scsi *vs, struct vhost_scsi_tpg *tpg,
 	if (!tmf)
 		goto send_reject;
 
+	INIT_WORK(&tmf->flush_work, vhost_scsi_tmf_flush_work);
 	vhost_work_init(&tmf->vwork, vhost_scsi_tmf_resp_work);
 	tmf->vhost = vs;
 	tmf->svq = svq;
-- 
2.34.1

