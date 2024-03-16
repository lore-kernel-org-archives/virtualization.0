Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EA1373
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550052; cv=fail; b=eyrCTs8d6JuvRHn6zfj5ciYU4yYRWhY6Ujpu6jIZBustlzpqCFn+jNc0hbaDrS8yUsI8Yh68JqIDtmipusw72HaHdhMnPYxz5f/302+CjRzjfwGUjkk/sfgjbXW3VGzmRsPcpwMwXvrUscmYyfmfmLfUAWDqvT0RCILTDZl2hFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550052; c=relaxed/simple;
	bh=KMhhFjZUxIr9Elur/62So+cydQY1wXsoopb+4HovA0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=faG/62oJufWvIZqSlkTCtbWtJCVMCSguAnziIHitucdfqXiBohK49XPw0YUW6CKyxjJ2WW5TIyWK2uVwUYdnQ2v6NjXx+42f7afJwG4DGqy533vIQnE+rvIWfjrKZC/yrxhTZqliKwbagLBR+y86KxHms3J6W1gTPpP0YrxDeNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n8Zzmmj4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rQGkiyM0; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8Zzmmj4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rQGkiyM0"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCBBE403BE
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GpOlF-eOtMEo
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ED0DA40191
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED0DA40191
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=n8Zzmmj4;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rQGkiyM0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED0DA40191
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:27 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9Rwr008442;
	Sat, 16 Mar 2024 00:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ZNJcxDjjg0PfpiYiA0ka9fLBYNIDnFNg4gr5Clqgjoc=;
 b=n8Zzmmj4gcGD6QeP/Kvo5EBNdCslOGbBO7whjsz2rzf64ue9zvXmb2DSd3vQrluCgfeC
 JL6CtlMHhFKjELIbKtj5DeuqDR1Otj/9cRiwv6pZ1k8xhVxcZ6fxf7j8JlspovAE4uy6
 0zYF196uLMevuuhp+WcnLmjME0gkZfKTs9VKNCLaOJuk8jVzoIHJdNKWfU3XhLawIML3
 Ca+86wOZgurt6EHMNtTeMeTux208ZN3SGO50yzrGKE9RyicSMDnTG+Cx6vq2gWJWYK06
 YXreT2PojdGuLaSfNxSLY90hB13xQnQakJ/i0h8N8Z4qIVYL3gSOZsit0u1B5CCKku1R yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxh8s7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FMe7mE033745;
	Sat, 16 Mar 2024 00:47:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wvta1r90j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T45Y31DEiEs4TxKkFTlskbeei4nE2hoK/gpr0zxyz9dQR1FoZCMxvxdAQyi/Smhbr32axDrLSdwznxU8cHrRW6ycAOXxYMFQ+t63G5qTRNhrLq9cEcQa8wTwhqFZVn7T9x7FWqJA7kM6/TLZkK/ZtH2SInQaOKoBbugyp1u1NpJ7BAOIHg0e+YpdGwAhe/VrBMgmEMB3v8SeaL22uZX9rqHp3xdgMuSq1jNeF+2e/rF7Jp6tYpVZGO5H8NJkB601A+a4Dk057DnrprJG5U9j1JLVIp5GeN3Vq++pl4a7LztjBx1YDkNlLRjGGgRYNeDa9pKFojQdXiza+bTEoXTdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNJcxDjjg0PfpiYiA0ka9fLBYNIDnFNg4gr5Clqgjoc=;
 b=aty3/nhqKUaFxGUO4PTJmZtV7lvR2VCW4BkJCe2fjnKXPNH4KKGb4umVU4xg9zIvTsmB8eohai3Striuzi+A5e6KxOFula+I+HiJHt74eLr4AajifLEUc6zAfSzRWr0Hif/CLHRZ+WaJMC6l36ZsNZJksSNgOI3hOV1PIfU5UHzPt8573ay+/DuCayLxL/Bmh3Fl52EAeEldhLPI1Fv6PBx7+sWt1LclHJc6w/dMVO2BzjISLIt2NiZLhARfDijE7r0iLYUkS+s9OsNnx+m4L/zjS5J3EVBKCCFWo5yXvSDAVw3tioYgQeZgK+EUdGzUToqab7honv71rtB7CfvMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNJcxDjjg0PfpiYiA0ka9fLBYNIDnFNg4gr5Clqgjoc=;
 b=rQGkiyM0kI8H1RPP4Axrlu0QBREBxLltGbjWSKFGKm3vrHWFQfFa70hnghw3xxu4IJv9MHisq0RIlPDVvF1ooekmquDOuULGNH4ZLQa/QH42Dqwt8wl5DYBMuQgcqr+Lk9PiN7i6s2NsOs586pjq7C7m3LZRHw4KA6vOGAdcfjk=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:22 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:22 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 9/9] kernel: Remove signal hacks for vhost_tasks
Date: Fri, 15 Mar 2024 19:47:07 -0500
Message-Id: <20240316004707.45557-10-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:5:15b::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b88cd3a2-d847-4cf6-5406-08dc4552a3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CSXE1OQvURPfLzSj7/89nTUM0hnq2e6T8mFBKXifrfqvEr60feLWHePtu12caRZarIJlZ9JXb3dHJCddi4Y0uXe0roclvi6J6ex+A9jNf0nu4xXYE0iN0IGYltj7Fn/OkiuS4O1mjr4gft9ZSqjx9SpHUSq/Y3Fe8qG0yjwyjpcJhw31fMX3dd5dmBx8ydBZQ0H7zuKlH2vLtTQOJrn++7+s0Wi5ouhpm94uaz81APUpEagkNNjOHCYDP+ZSGFxiebYm8QmG8SstVWcJ2lLTUsQRgCreM7QhmdGPrwPnrvUjtVNJy6bsOI9WsLOZB0l2YSRDBOYDZjaCjcrJ0ZKpOfgHr1ANx7oJyVC4HFGTdYR9GG/3WrnNOB1OSRgGjIs9CmKAdwyhv1FszEVFWapN9miEXNmbmBaqE3uEdikjfSi7qadu6g/iYwCV34B4BAQgQU9fwOWPqBN6h5M0+aIS6C+KrGZQ+SeqtfcwFr7EvSvcS/6qGB3mG9e1b5U8LruVQZyBNS3FxHMs4us8cZI4Srr9tCk1NJsGVVaApgWrDOvbBDmSzOTqOb0SmopcpyZccOZp5EYt0QK2Mr4/Qbo5ke6A8B8xdmLQGJiuNYTT+672SlfxffGDV0upyp/AVmUmoghM0vW/M5tox2XZGLSdaumTFGZ24C6Qks5CzAjqFJo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gakm3kvnYdizqvTm49/T4xOmKouFiB/V5YCId1rQtaaspepu5altQDUht69K?=
 =?us-ascii?Q?4Txa1FOHYtQhj9hIQUmJuy0LYMY1nquBbt4jXyOrcCTsShg52kfaXLS1vbzN?=
 =?us-ascii?Q?Cl6O2/bRZImihQM/YrnIGTZPiTq+76d4qTchC2EHuxuuBPnNkHSzvxnoq/Am?=
 =?us-ascii?Q?rL/xE1Rtu3AU7EW27jrWE+BvWmEALY5wW0Irxn9qg1ppTTIQLsdFzgwmxDDa?=
 =?us-ascii?Q?NTe/AoF06vWing/2THeHsdv1JjcFWO7WZrRNTaIfWttL6DTqxb8rzpp3ZpbE?=
 =?us-ascii?Q?osBrUAEJGdvYnXuTPCwstTsrlVtsgpbB0II3JZfcjFr6Rl5BCTDTtH5iJr9X?=
 =?us-ascii?Q?l5RiX7ymq+gxWUsEZHUwKCCq2F233e5tJY0/Ies9niNImOuaqZQY8EqpevcE?=
 =?us-ascii?Q?ceL1JwMEElD3aNBaTmd9He5rvxlayiX7h1Sxu1AtAbBIw6o0WLEb7uyNu0UI?=
 =?us-ascii?Q?hn2qzmPIKFrbD73t/8uI8WrQZU6BFL39bFd/nsftcnS3/7TLlImRiwIK4uGH?=
 =?us-ascii?Q?84+w1L/fBrWB9b41VIWU0UgVlT8MByVkbgF/vxYCQNotvFX2ElAaM0EOhJSF?=
 =?us-ascii?Q?buju6zAeJ8aJF4iNP2oYVzK+L2RfpeSu3Ek890NGMuSbP8zydR9WT2HK8V5N?=
 =?us-ascii?Q?wPagBwclAwAXHHV9qtHr+Ew4R/1j7xv8QTrLbJWOERD3iHPVF6idIDrOR/Lt?=
 =?us-ascii?Q?Ob8ye3rbYs8kNmGTyQLUJJK0QpDSwTgqL6CXhGtmoP/ODhxLgwGlrdVQpXfH?=
 =?us-ascii?Q?FjQv7jkLmQx2fmtNZ+sn6JoBNb9S/DjBWCVYk8mwr/ZujFQNIz2MXgTunhWt?=
 =?us-ascii?Q?DAC+Ug2JqQOMDZiJyv7uTIOSZjaX2eHtIUjCHEJEqLKrmzDawxB9kS5W3XOH?=
 =?us-ascii?Q?KE2ZMvYTe8UqhR1Iwucfda4Ct3OrWJ6TQYP8TNFhw2PBUFxuH2xlP0qV85yi?=
 =?us-ascii?Q?yVeqeHTdrTS6zUeG6vj7cqVuuANYlAKICu8v276mwg4W12nQfQz6lbria9Ww?=
 =?us-ascii?Q?k4cpVVo4Xs8zFCgYxRzid373DYaW9Fsv1TD4DUqsbUtLgdb2DgXHeHXiv6f+?=
 =?us-ascii?Q?Z3RT1THQ2XBe45lM6CIChNQP5/nDqWQlsDO3x3X4VuMEzGdY547GU1extX0x?=
 =?us-ascii?Q?NYsv+eFuC5VPoBbSzHag16TDCfib4czto0FCEMFnjh7TmILMbpI83Rf6coet?=
 =?us-ascii?Q?4mKbwC4Un4xh09KHEPuAGY4yWHEg/tWLWG0mUqiGS0FPWxzNw7mNZ5kg7E18?=
 =?us-ascii?Q?hVKPD6LwiqFNqAQI1Ha1TD36LPAAN6rHy5Rt06VsXmQ3EYjTXrf8WhpVZb+4?=
 =?us-ascii?Q?T8BrnHwubImaUObmRFPEdfTaShOR4GmoNFRTxE2P4DQrj2Wqtd07wxruTQlm?=
 =?us-ascii?Q?0TS9Gm0PfIXH8myZAYOCPrxb+lBRmh7vgpfGIINvfVUO0fGvQW7RhUG+Q8KV?=
 =?us-ascii?Q?6wS1QRuX0Xdi0UrrFADedgdXP/AyMDeaz81JfW3QOtT8ewu4smR01HqxBL+M?=
 =?us-ascii?Q?voPA23NYNK71u25nGSwcntzqjh9KSo6n0bRQkHbgS0tqiyYkfzUds2DvsD37?=
 =?us-ascii?Q?kFAkk1MPjtq8vjOr/R8m6Jks8CVSXDLzZ1PwOsQ0WGWmY1VtKqlJ408DAdW1?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aEYshzVX8wRw8xv/6d7mTVU40aDv127f0ceTUaYiqWHyRXyDi4NV162shV+zLFKmMx8BUmEw5zpkhesOMInkvu+bQX6y3WcXpbTvIaMARUCyYvEpGVAiLW4uAjeoV2UHGgoc7NUT8y/pQyyqLDZjQew4TMj7gZa7+B+OIkT6W350ziiM9A9jzp3klO7rtxmtp9vy8x8gtYSzSoQH4n6KZiQYOdbgr+4wM2JFNl4JsFC7TWC97mSBYrs23NpI5NyQW0n3fWZOP2sz0mQJcJYfYo8DqexmBChXNK1hQOOfrdi5KmPbLZjFTriGlhC+v4mRCYQX0+5CPw+xK3fCaMrdCatreSSUgq3Iq4yCo5sMqlA1XzFFwxZ3h8AWa9d7jCeOd4qsufxqRX0+qm3YOeLuP0W3mRIBTSABE09gqTjv+brGeQZAG9533Ne3p7+zLaONd5Wn5zsb7WK6t0t5bDLUUuUZPNRqWs/tUoE4hOh6zKcQZ7nrfg9pduqlJu0ZE9m9f5UNxyevFIMC8P8lOqLbdWEgG/twSh9s2dPjkcurmPgwz9UV5O3soKV2sMDleThOp8eq/S1ddC52oLBJdU3ZD0gMcZ1B5zAmOfduErdQpgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88cd3a2-d847-4cf6-5406-08dc4552a3d6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:21.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSFOFMULrR7edMOouQtgYS0b7VMTima9FKV9PavqG1dUGGYrFO4gxEGBl7p7j85Rmw5hk43Tn13SNSlfPZn+Y+KreiLrK04w/aDVN3HHMmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160003
X-Proofpoint-ORIG-GUID: 7ZDW_Rv8JhfUdCZSjjBMKEk5nkM6iR8K
X-Proofpoint-GUID: 7ZDW_Rv8JhfUdCZSjjBMKEk5nkM6iR8K

This removes the signal/coredump hacks added for vhost_tasks in:

Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")

When that patch was added vhost_tasks did not handle SIGKILL and would
try to ignore/clear the signal and continue on until the device's close
function was called. In the previous patches vhost_tasks and the vhost
drivers were converted to support SIGKILL by cleaning themselves up and
exiting. The hacks are no longer needed so this removes them.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 fs/coredump.c   | 4 +---
 kernel/exit.c   | 5 +----
 kernel/signal.c | 4 +---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..8eae24afb3cb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -371,9 +371,7 @@ static int zap_process(struct task_struct *start, int exit_code)
 		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
 			sigaddset(&t->pending.signal, SIGKILL);
 			signal_wake_up(t, 1);
-			/* The vhost_worker does not particpate in coredumps */
-			if ((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)
-				nr++;
+			nr++;
 		}
 	}
 
diff --git a/kernel/exit.c b/kernel/exit.c
index dfb963d2f862..a8098b29a722 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -414,10 +414,7 @@ static void coredump_task_exit(struct task_struct *tsk)
 	tsk->flags |= PF_POSTCOREDUMP;
 	core_state = tsk->signal->core_state;
 	spin_unlock_irq(&tsk->sighand->siglock);
-
-	/* The vhost_worker does not particpate in coredumps */
-	if (core_state &&
-	    ((tsk->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)) {
+	if (core_state) {
 		struct core_thread self;
 
 		self.task = current;
diff --git a/kernel/signal.c b/kernel/signal.c
index c9c57d053ce4..0fdca333207b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1374,9 +1374,7 @@ int zap_other_threads(struct task_struct *p)
 
 	for_other_threads(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		/* Don't require de_thread to wait for the vhost_worker */
-		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
-			count++;
+		count++;
 
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
-- 
2.34.1

