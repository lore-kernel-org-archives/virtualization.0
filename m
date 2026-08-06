Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8324D8D87
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044621; cv=fail; b=CG2j9lrnhqTbhXduOjRVwB3xevclhJZ1Vd4Ke64vNmi3wIk80SEu881Y5tgW2OQKfVPdQ6kVfQgLcHCc32JRd92zOblYqbz8A7WMzzBGaR7+nk+BX1s9Tq6Dnz5jraGA2kr+PrCbjsLh9afrU+SOIXw04HjL6c7JTr8wDoQGVNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044621; c=relaxed/simple;
	bh=JBlIwvQ4DqSq5Ofu7UQ7S4s/Fbnk6df7defGx8opkQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KINUx+sTHQ4FLMF6JV89Y6DctCQXZNOdMFTOlPzuN0qSkZUJYq+UQGeoca86E+ppBhn/PyWINWdVAmHuVVhzfD720ka0zN1Q/k73jxuc7qogYjsXhmP1/o3ERs7Fr11RzzFYzfGoOtfCcJl6Mr/E9zg2pik4lkTtmEiGhlHiS4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bQHuId3L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sjWbz9v9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bQHuId3L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sjWbz9v9"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676FtqY13074712;
	Thu, 6 Aug 2026 19:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TJMUZx1bqoCWvy9CiE9nCtEspHPdVXcJFgqHdgL3vWw=; b=
	bQHuId3L03Rx1XgMjsls6vDThR3V0hJgav7zTrw4FyKyMe7CWLZrWHZ58UIQ+rv+
	wbUzrizB1Plyipo10+vsKFjfC3M81uV8p+tbVEvadveUp1RjQgSR6DgqkokiFRSh
	cL60RqOnRi9ss79jdTsge3fHoFzdgnWTcg2D3Us0fBNR7DVOopJjo2aNfZSYf0CF
	+7hQpf51xUknLwikcWP9Tbnw+IBDUhJsHWtbLVd1r2jJvNm8+X6O5BEc4SdZa+Z5
	x900XA9CQolZO+cJOE0zbjzKwMy+HEzWx9RBokn0Z0/YH9IwWiuqMtY/zmyvjntS
	tS6Ogux0Ff0V0v5U9IbV1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8e56n3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 19:30:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 676JPbMl035130;
	Thu, 6 Aug 2026 19:30:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78wwnjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 06 Aug 2026 19:30:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSwZeukXZdDp2d6DnYuBHrG6YJSJngpn+PgUWekYgkFDkReZ39GThei4P3+n438iMTIyfIgep7YID7pjFz/2nJH1aSs0PpA+K++PfV69Z57eQWUys5Qe2544moCLaeAZvHOjjFJzFyBAopLi7XxbRo1RvcaJ4FU04GZyFWYxXqMxMpTwrU1dMgnzuM29R7jKJFYdU6BzYNAagqrpQO23cT9kYXcdaBCl00AJNG45FbEh/7bbSZ+U69S/QAuICXQohry0HfGWoae3zSBHQcjPO+w0GXtvS/W/mG9tyPBhTRaf9mkq9vp2xFYeWoVYdci5q0qgzLVPhuzq3cZewjcjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJMUZx1bqoCWvy9CiE9nCtEspHPdVXcJFgqHdgL3vWw=;
 b=jvDzVqD4nAus05RtKE4iZ8e9xMaNxtmu6a0++ZQ5TZvkXH1q6zoT3tQG1/El637qbLDxl+COxbiMqIgpQpioPW1fTf0B2WfsXYKUDBEbgZiBnGNYnXH1528Rl6KYqRERdfUsDiKz01+D33k6EjbtP10fsV0xerjsnBujMMIiTJwRwKu+3gRweWtHpa0ABDHe87vIq5UdlPNnzKmzpXP0/eUmCyt1P4yDwM2CaGP7HwErNZ2dwkWSKYkCXd2Grc8PJavu3kJQFiYL9sht9vllgm7p3XR+SSNy8k74265DdCiJM9E38feRM0dUOD1K2wZtk6F5NquvSkXyLE1Ygwezrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJMUZx1bqoCWvy9CiE9nCtEspHPdVXcJFgqHdgL3vWw=;
 b=sjWbz9v9tGujnNrDOXfCHNX05ShdHqhM9FpLf2FADnKtl7UGdvqTuOS9+UKc0Gnn+3ZgCAcpH/FzF2+x8V0IRVugpwvW4m3Rzj8rAphY1pH0xKGYj5aYblGNwGWU86fFLZ3o79e/Mc85pEl43s5B5j3Lj1C7rxMsZNt+EbRJKTc=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by IA1PR10MB7336.namprd10.prod.outlook.com
 (2603:10b6:208:3ff::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Thu, 6 Aug
 2026 19:30:12 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 19:30:10 +0000
Message-ID: <dfb1bc22-7a44-4d19-ac13-595411cde4a5@oracle.com>
Date: Thu, 6 Aug 2026 14:30:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vhost-scsi: clamp max_io_vqs module parameter
To: Dongli Zhang <dongli.zhang@oracle.com>, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, pbonzini@redhat.com,
        stefanha@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
        joe.jin@oracle.com
References: <20260802172534.260047-1-dongli.zhang@oracle.com>
 <20260802172534.260047-3-dongli.zhang@oracle.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260802172534.260047-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:8:243::14) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdf9d4e-ef0a-4a1c-7e31-08def3f12135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lJ/j6QAY6uRDDotfZxw+fESM4KYaqH3bwINsGJoxKAr3Hak+nUtb59gJDynw5sMtmNvfBrDVuSlxol/FEMmx0hB8rNplPCHEUxOacWZG9dteYR6ubKRAyY+jFlxkTvntgFNvpVR+2Qpj2Mqx95gP6B8DhFbTUGdaedhXnVUBvi3LWIzU8MU6xvviREiVQ1yZxwUMakwwWyezp8jecHbWq3SU2qQ5yRN9xoXGHRzJuQePzGwnUsDxxLdOrZgorm5OO8wimCovyWkZcrxfg/1bpSiya+n7K0B6leFcmyqqwnXD+yoHoalMDZONxmPl8O3otX2GX/g6OpWuw8gl/LbSbZs6GO58NgCh/pEcftuaJMVDZ33aAUgc9yjrRU7+klVU54dX/rFEjaX3wSi+H2ksrrOmsi3ICjrkvgq0pKHgq763D5m66Vt7WSjiWfu6zpFijy6DBicaALjCyRdSW0ZDrf2OUU17aDlNn76HVgfFtBx6F+l93+NasQLOSgu+Exi9Coa0w2T3jLWk/ZEK+Em7Zu+ca9IMBZRHfL2apZtNJPAEP3cRXmZfYaVOU9gkYK/BjHlBDUPWs1odOS6klYlhAnZ+vRLFM53lP0KK/M8RVYm1F/9S5CVLJ+besnoTku+pmji90PzjJl9B2alwEDesxejutkKaFCPCQBWptH8XU58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjBhenlxN1dBTHpjTFJQeitVY0FMdXlSaTFsTkN1S3RXK3dVd3hoOHM1WlNQ?=
 =?utf-8?B?WXZWQ29FQVN0WG9maVJVb2YveXYwN0RDNlVYMDNOa1FmTWVWb09ReHhUdEpO?=
 =?utf-8?B?dVNuTDlqZjVMdU1oSy8zRlpnWVB3bHpOdEp3akZTenU1ekJjUFFOeW9QaFh3?=
 =?utf-8?B?VEVXWUM5YU5PeDlVNU91MitQZ0VRYlYrKzR0N2c3a3drcGhRQXRaY3E1Y1BM?=
 =?utf-8?B?VG5paGRpTWlrTEY5Ulg2R01TZjBRdThQK3I1K0ZQb3VLRmE1cmRDYnlMOUtN?=
 =?utf-8?B?OElvQUYwZEd1MkgzVjFvNDV3djdOUWxTNERINzdLb0tLSklTWUcyNFg3dGRL?=
 =?utf-8?B?dE9Oa1g5cFF3QWtvN1ltUTFuckI5L0d5TWJFcWplWFVBYWY1d2NHejVMTjRG?=
 =?utf-8?B?dk04SmpjUzlwY1lESjZaM2xHOG5EZE1ITmRUckR1a3ZhdUZWSXpwV3ZBTjlO?=
 =?utf-8?B?ZEZlMm1hQUpIdVZWelFTL3VETWt4VXVwSzIxN2w3K0QvQUF5eHJ5VjUrR0pG?=
 =?utf-8?B?OUsxdzU5b3Y1QmMyMmp2Tks5QlJlNDdFL1IxNDVuYzBtZWRrSm1aQnRjTEx0?=
 =?utf-8?B?Ly8xYVhXdDRKVGxGQWVNQ0orUFdzSlNYNWdaV0daY0o3RzBwM0lOeGlYK093?=
 =?utf-8?B?MnpCbEw4NU16d0QvVWdkZXhIYzVwUk1LeFlFQlBVak1HN3RCa0N3Y0lteGRU?=
 =?utf-8?B?TzFPNkV6K3ZVT2psZ0RJQnhrdnZQUnMvaXJBRTd5NGZ2UE1Zb3BKdzZLMTR1?=
 =?utf-8?B?TGNacHY4YmJMTzdnQVIzRjVtOXBPRXNuVVZBajM1dEwydGRZT2NrcS9nTGFI?=
 =?utf-8?B?Z28zNG5qQXpZUUdEMk1UdDA2R3IreXF4Lys3NlBLOGtxRzAzR1JjeDNGV2xx?=
 =?utf-8?B?YXJjYUJ3UGptR0wwQzB1a3ZGRXFqODNublJWWERBeGxoQzd0QTBwa3RlNzV4?=
 =?utf-8?B?bDNoc1J1MEUyb1FxRGlLWWQ1b2gvcEluZWdUTVdiSHJHNWhMQ2w2cmVselhC?=
 =?utf-8?B?UThJMlpMT2ZyUWtiTFN2REpGVEJRTG5zaEF4ZUxGUWtMODdkRmxWVlBET0R2?=
 =?utf-8?B?NFpGQVFkZjBiTUxINytiQ3FpM1pYTHZuNzBNN0VicXg0YU1vTUdWelBjbVNM?=
 =?utf-8?B?ZzBFL0R0a1BoTkVnWDVKTGs3cEhqOWlNdkcwNWdycUtLUDdNeGc1Z2dJN21w?=
 =?utf-8?B?UnRmajZ2R1pQU0Nid0IyT2EyMXdOc2FiZmtoVStUTFBCWjZyaCtGWXp3N3dl?=
 =?utf-8?B?cXAxZW1HeXA5aklXdnJtTjUwSjU3YzM5SkZaYVpJcXVRV2Y2SzJVVDc2cWdh?=
 =?utf-8?B?c0VTMUM4MGd4ajRYc1c0aC9yTDhxaktaK0xEckdHNVZvelZNbWtqLzJQY2xC?=
 =?utf-8?B?cDg4MjVoYUhaWTVHam1HK3lkOGNvdzgwc1hYWWRNb25hRXkyL2RJeDBTNGp0?=
 =?utf-8?B?bmFoc2xiY3AraGZ1bGpsR0VYOHdBOTdEcmdvTTNZKzFrTkhVY3NRYW1jeTdX?=
 =?utf-8?B?ck1tSjFGZ2lINk1PRlAxQ1FyK2o4MDlwaXpvQkRTUU9OTXBFOWxTbG1BK1lT?=
 =?utf-8?B?aHVsRExlTmtyS2JWeDVSbVF1YThIdVFpS3FVYVhqYXZxaU9tOG1FaThUN3B2?=
 =?utf-8?B?cURvQXJWRU9URzVLbWZ3OEwvUjRzMVVhV2lteENNK1NRV21jL3lERyt5K214?=
 =?utf-8?B?Q1dwV0lnTzhEZ3NwOVZHaVdXa2luZXZGUS9JQkxjRVVxZXl0b3Y2N3NpcnA3?=
 =?utf-8?B?b00zZURQcjhKSWJmWElBWjFnMk5vTEMwa3dBNHNlQzF4UDJjSDRrYUl2djZY?=
 =?utf-8?B?ZlJrMDUxbEpURllCeXo2Q0REaHBRcEFoRTVPLzRYd0dybXptcG56TkErTUhx?=
 =?utf-8?B?T3IyWStnV0xKbjc3YzRqSG9qeDFUMWJuNE84clNFYkE4TE5iTmJIRDFaQVRO?=
 =?utf-8?B?LzBJNkl0VUkwc3kzNzJPRDZrejRWcStHclZwcHplNmFBK01UMFBaSTVlYWdR?=
 =?utf-8?B?emRhK1J6S1IwUWE0aFFMMFhVM2tKS3R4VU9PSWRBMGk0OFRQOFFHWEtOUTli?=
 =?utf-8?B?Q2hSdXJhd28zdHVUTEdOZVFDaGQ4aTZ4dmxZcjY2SW9ySno3d24yK2xTV1gv?=
 =?utf-8?B?b1hSRGlHR3pKVm5jc0Frbmo0M0FWQnY4VUdraWhuQlg4WnQrNUpKUTI0bVNQ?=
 =?utf-8?B?RTR6am9Hakx3aEZSZXNnSnhpK3VVZ1VzakpOb2drQ05KejM3ZTYyK2RuNEVN?=
 =?utf-8?B?dnp5MVJiN0V4azhqMXJ0cXkvaHMzTTVseFJSUWtKSjhFVUhoUnRFUGZFWDVj?=
 =?utf-8?B?S2FWY3MydWF2VWZ4M2RpQ2pHNU00UnlEZ1hJMXhxTGR2amxhb01oWlZsalB3?=
 =?utf-8?Q?E33exH0RshKuOsaU=3D?=
X-Exchange-RoutingPolicyChecked:
	jQPFn/0XuYgMbOh7R6+rqpfF6DvlaafXCs35EgwytOM6Irh7JqytDJBrypMw/Jf8kruFmR9quRN3oOWEemo0ataGg3X0K8yR4KTGbV0zsiv8O0qgdc29rbZGGH71Ov+EkquBBiwycAf4CViS4YgbQ8vMz8FXR9CZxUY2pUdaXvLwObfdRkh8htK9q4gyoviD2Ah0YbPgP2jFYBdpIqrxpxUfoWjTyig3ldQKw9XSGKj4TVtVgf0qGq4d3W8gxNjLTWzDu49knNs5/cF9Jx0TG6trVHmSB+MpQfcWfZU8HIssLwxZa99wcYLXDe1EJVktvZXCBfQkuwkq1Ik1jb+BGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dBqNhqe44SIUTmbCO+2SkSIve4nWULPXekMv4VWPhi+I2dG7CXOSqBxRvFyI4OCe+xQNqvPb9PQUIJi5+sswReu5ZD7huMFJPTSIKmRvOAUg4Fuaik6Gmp7c6b5eMaBXE5qqhEEh0qAmeUxBaiLig6FrjIYEXZ77n5LTarGPZsnhJPBO/NnB8mIVTgbd3NYZeH29Y+s07G17h36GTQ2FL2ZWEXEnWVLL5RcVyk8CxVNsK/qutoat9flYAQlMGqHRw7nRvEfVkGgC5N91DQk1bFK154yMiDogVrU9llgX0iRtXfAN/l3IYChcqDYQ/tVpvmhHkq2O47h5q5T9CpxBG84I8pN5+CKGtTbhNOhbn+P8PKGqU9133styScSqOlKWCzQEnnmpdKS4loVh5tv/+lGDOjvsQ+pwMvepLM54Ka72HpWzYkBIHiFxS4kj4tZSiGNpDtPmM8m88740gWXVu9zISuQlga/HDB0RB6PZzclzrsSg9sJ0MDc4f2LQjzV25gszc+WiWhjmNFtkVsLi6NpcIHTK7KvPzJqJxqFs0FFt4eH1KyEWGVp4Mtv7hQakFYXMfGwGM/DoGuCiTgO+HhjPlZtySoEazsNbmbMxPCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf9d4e-ef0a-4a1c-7e31-08def3f12135
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 19:30:10.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4W9MmIWDjjtPwrp1MX7MRzw2BWoMAgxnZ6e6vVmywlej29g0bmxg7XDl3zWkGoK9l2EpcGnaS5x3YjyGr3g4cSs0jWzKGLamXEm0d78VYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608060152
X-Proofpoint-ORIG-GUID: B5YVxksJZlS5f31ySHS9N09FjwBn3eoo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1MiBTYWx0ZWRfX8S2eYWh9D+0D
 HRTxQ9HAkGC8NrkB+S67ie5mJhqRdFR1LL+SyENqLVi2XltTG078U5Dm11NN90ELHbza+ffUNpM
 8s9WS1tKuzhSntj52LfnqykpABLrGG5vXT34XTLp6njGGYxPTm7y
X-Proofpoint-GUID: B5YVxksJZlS5f31ySHS9N09FjwBn3eoo
X-Authority-Analysis: v=2.4 cv=M/t97Sws c=1 sm=1 tr=0 ts=6a74e0ca b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8
 a=O2uskBeBJfTr__M-Qf0A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1MiBTYWx0ZWRfXyJYDv0GYiG62
 ySttXtKYG9KppxFR5CiE+l00plPHYKXzhBhkq6ND9vq7lE/R2fIH321zy5CL5aP7ifhRSjzsyXI
 88YG7Din0ifBb44nKpjXxLmHDVnloINDKhfSw0Rc2ecX9X4U79I/Fh2ZDwYiwMIKRsw9M25Xu1T
 /4Rz3MeFgu/H1+dYjbfC6mzRWWd8x8/0ybUiutk8DyK5zcZAIPt0eac+c636mFKXIjecTaWglh2
 jxAtgqY7bjlOe0t8NGHsIq7Tea6+/0Tmfsvo4cEDMu6Dim5lpCgz5h9LOrQTdLvauJVqV/SphHj
 hrtAzDX3Nn7gTV1hap6pdaV61y8G44CI7Paj0DN1eo7qiDrWdh6Z4a38fPAax1jQZT6CFnQ6HyD
 tImJ/IDu1i9+teMy2d+T9qXOZMLotLr/wdMb6h56uukUKewbphV43+spQvn0bR1qGE1dPUa65Fe
 3y9OXuRmqZna1M0NySgs2+whhb9mmf40sclXADr8=

On 8/2/26 12:24 PM, Dongli Zhang wrote:
> max_io_vqs is currently validated only when a vhost-scsi device is opened.
> This allows sysfs to show values larger than the driver will actually use,
> e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
> VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
> will actually be used.
> 
> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
> 
> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
> 2048
> 
> [  315.630495] Invalid max_io_vqs of 2048. Using 1024.
> 
> Keep accepting out-of-range values for compatibility, but clamp them in the
> module parameter setter and store the effective value. This preserves the
> existing behavior that invalid values do not make module loading or sysfs
> writes fail. It also makes reads report the value that will actually be
> used.
> 
> With the parameter value kept in range, remove the duplicate validation
> from vhost_scsi_open().
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> v1->v2:
>   - Access vhost_scsi_max_io_vqs with READ_ONCE().
>   - Clamp out-of-range max_io_vqs values instead of rejecting them.
> 
Reviewed-by: Mike Christie <michael.christie@oracle.com>
