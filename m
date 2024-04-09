Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E513158A35
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699739; cv=fail; b=tbofRE/7ZQhr8rIh5VjBWneGj/fDmCvs0OYfpGci34edZZCnSmw6Nu/g7edEffkTQCT005TDYzbQfFbSLHojVjv3wU19CFlZSyk7dOtMZiFoLT5rP5SLQKfum1pPmDZVXc1Gt+geNEhE7c1FVLUW0GN1pPyimzK1zRqHQY+xdqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699739; c=relaxed/simple;
	bh=A6DwalaDZDYt03XQPveoR/qRAPWkDYYZ/gZRPPntwsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tjXFr6v6rjUdBDXJQx6z3blejz/8fdkOkXD6Tx15ceNEyDhj9Z/3tuUZ+IFikIzd42jYiqYy6V50cM8Cd9e7htMAWhR6rrQMTEhiVrmgk86XuNdV4v65Nc1vt9wqKg44OcUqPhR16vxTbVLxS4467FWF9yYr0RSAzphNzNd1JWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gOPua9ws; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5Vs/2fz; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOPua9ws";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5Vs/2fz"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05DBF4061F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 21:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qVzywjuJADqh for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 21:55:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9AD2A40611
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AD2A40611
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=gOPua9ws;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=O5Vs/2fz
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AD2A40611
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 21:55:35 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439LZOUh015443;
	Tue, 9 Apr 2024 21:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DgIGjuobnpl9xbsQapAiS3E2YGnYrwLqeQigBe7lyU0=;
 b=gOPua9wsaKzXRNPv8Fc661WbeQuq+yWzixlilksJAB2H+NcdMFaH//QnRUcBWfG3grWI
 9jKMrKPPTZ2ZVQ0313C2x3xnZd+BlvZuU3SbAz0Y8RGcY/3V7DzSvj3IQEvGzwSAfLH1
 PAR5mtcpCptu6sSBFFo3WHsAPxSLTmOFsqg6x5sVBPrVtiTLrRtuHNjf7aJEMNTlb028
 mNmK/IeyiIePVTryn3p8jbJVHMD3SdwzxmMC+NaNngRWYMtGU3F1nWPahqyVk9LHAYUQ
 IVeM7gBVtyWQSMzOiCh9XcXZsPbDDx8Ao53ovOHIadAQiDOWKVSbsfQC5fK4nCJQ5YbI lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacp4m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 21:55:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439LjPdF010486;
	Tue, 9 Apr 2024 21:55:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu7ak1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 21:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGNPdRv1u2rj2OVCIukCQWcyyTMP7M30kFEqGf66sNy4ddKmW7WGuQF+DC3CPQsID3GhMcESokhU2qOKGgHhFNNHTB32dtc89Vw+wEVEVeUEH7YlqJM2euU6BRDQLD1rOWBOckl9dJa2rlNQrRxmkeAVm+SIJQP7+8g9N8D/Naslwx89YoKYdg7xz2RdMBASWlJhu9XKa0SfPqeOaXXLSRzJwlpf431dmiKWM/kkTNctviMatuAN/y5b/SD5j9nZO1SIJr2+62hwc7FpVcOIPzMb2ieXfKFSOy+p5z0T3SjKu3metZjMGtGgNPzbwe55DjaRyM59ZJIjfXFaw+4JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgIGjuobnpl9xbsQapAiS3E2YGnYrwLqeQigBe7lyU0=;
 b=YGxUZjPStIUwNj1Cn/Q3bmlKg+uSRSC6FRtfd87W7kgXDvLDguiEvkwvngbyQuKdZhM4b5YsDVzN5zvZws8w8SuSeG5Qew99JiYZ6D3ytXVIteM2DJ1dDJSEZdGMCwQN/fs+QIRlm1oRoOb/4hbr5p+Au1xzZzsrUMT+tzNbIPTydI5pHOxum/XB/zbGqs26bfjSKiQ4xyPAysWbBBrgkKBjuAM6SRA+THWNiQDjZT8dNwgxpMCTaml9vXoHLVH2AqOFOaZ71Z9IrQJjMaS+s8+ZyhUTmyRNyFWbbVySzmH/0EMSs0FkPj02RUDbQl1UxBs0cimqm/epeU2csn1TdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgIGjuobnpl9xbsQapAiS3E2YGnYrwLqeQigBe7lyU0=;
 b=O5Vs/2fzvVUpzg2Ts89rrEih7ITMjK+G6LTR+ZAZ1KCJ1dn31SPWrugGHSNHLfwhZr3yboZ36fFj0Rn+EgSoFiLMRaFKdCueBun3x7P/V1A//nW/pISHLtgqz9eCtXX5IwJt7MwBI6VKZ094kImFVt9j/quF4UTRk0ApOmPjN+E=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ2PR10MB7707.namprd10.prod.outlook.com (2603:10b6:a03:578::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.48; Tue, 9 Apr
 2024 21:55:28 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 21:55:28 +0000
Message-ID: <f7ec68a6-86de-4f3e-abc0-bc3e87f5f5a9@oracle.com>
Date: Tue, 9 Apr 2024 16:55:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        stefanha@redhat.com, brauner@kernel.org,
        Laurent Vivier <lvivier@redhat.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
 <7044bd8c-99a9-4da8-a5ab-c2c293cdea40@oracle.com>
 <20240409110947-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: michael.christie@oracle.com
In-Reply-To: <20240409110947-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:610:e7::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ2PR10MB7707:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aTGNY76NxFgqSBdCLDea7mDan1MWEB56oOBAxlPb7UAymyAcjIA9Ox6W1x6YqLilafAa/4OqawrNRe5X3yjMXizS2zN6HEt8w/VeuZRSimf2g1HX31Fj0wpSqWCnxDMQ1z831b8LK4TsBND+5om0y344ZIUtG+k4KMdiLiFfdMHEiZ7ip+CEF6DF58mspyhI00M/WG6t2ZsUT6vqKGdIpvkdF6xP5ASnV80KROees1OdR1hUoj7VGnsWHaE6ciuC9fC8NA/7AefPlUREQWT33cJQA6lFKDeCyFwIVkS65UBrQE4XIH85YV51/7rqXymPGsbeJupwl1B3C5KZ3Oo0HHVi34wUVR7NPwpTBypvP2jDUoUty0ihbM/koWnvblo6wLsbEhLlKWjiyada7y/vJ76DMk2Q/hrcrcNjuwUqAH22GxxqwOG4xjRkPSBK0KnM34hM9qV7SuRfT7LzqkUFS05NnvN3AsKy6PLNVj+lV0l65JyrkZKdbzP5ej28j7sDtfyAFSfLOIxQrnUot5j6Q5Jl2v/Lq93wkqpd+iYkz0JIp1eaY9ir8YVeRNMq97NMlZchnDvcKd5BGGrrtRoPf0x5RE1drw8iEZ2xdam+Z/JZQ9i4vCt1MXM8Q87Gfm8xcsSJB6BaaLID//tmkMaA0vrfSFU1s+HEUZuoSU8NNPE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cEhWL3FJMUtadkhtc3d4QkJkN1FkQzRJak9vUU5UQU16RjdkSXd0bTl2Yjdn?=
 =?utf-8?B?bzBwQTkzYkF2Um9nTzdBV1Fla1RuZmM5UnMveGlCTUZGaXhIN2FtRnFvQVZV?=
 =?utf-8?B?NWNPT3JGWFBDQlE1dE1FamxON3ExVlZHQW9qQjBKVXIzUy9CeXNCWkxCa3A1?=
 =?utf-8?B?Ym9aUDE1OWR6UjJSRFQxZitKVDIwc3ZHSWd5MlJqRlczSC9vRXRmKzVLcnhn?=
 =?utf-8?B?NjJHN1I0VzdiUnFESy96RXB6VXVaQmxlN0ZtSlV1VVNLYVRtTVVMSjNOSkRE?=
 =?utf-8?B?ZUdRVW13Y0VUOXlBbVNoSDJlejByRjV6Z3lkYjNRVFBjK3FFYXhNRXZKblk1?=
 =?utf-8?B?Y1hadjZzUWpkZlp5VzR3Ky8ra1BhZVM0d2RhdzBvYTFzZHY1NG5oVlhJS1pP?=
 =?utf-8?B?dGJ0WEM3NjIvSW5jOFVzYnltZkFTTVlaaEFKSDUyWVcrZVdYS3J4UFdIellr?=
 =?utf-8?B?cnplaHFuTFFtNlBlbFpaci9hWUVyZ2I3WGJZS2FoNDYyWjR5eGpIWXB3NUph?=
 =?utf-8?B?ZCtjL2p6dWF5MUh5cTRjSlg4c1JMVjVTKzl0Zzc5UlBLakNZeFg5QnNHbEhs?=
 =?utf-8?B?TGM4RENIQld3Tkx2bWI0cUhxKzRTU0lON05YaUFNeDNqREd5OUZNYUp3aUVo?=
 =?utf-8?B?cjU1ckJkUVhRc2s4SVV4VnZjYytsNTdWT0Y2NlhuNVFRek9FVG1lRGVndTgz?=
 =?utf-8?B?QVVTY1J5ZUpNd0hJdzBwZVFqdEVWdy9hS1NoM2lxaFV1Y3E3bENPZUFLZDRP?=
 =?utf-8?B?dlh5eCtrSVRFUkNuT1NzcHhKOGhkb3dleG5XcmxmYnpwbTZHUTIzcW9rTitC?=
 =?utf-8?B?QkJUNWs3WjQ4RDFzK2ZRT3hXdVVvdm9OQXVha0ZRVXo3MEJCTVVuK3FxMk02?=
 =?utf-8?B?RDB5akNQdFBweE5mQnhTMVdoYWU5MFFQWGp2Z1lOV3ZqZmV4VzNORkxTMGtv?=
 =?utf-8?B?WDNvZllicnpkVnREWXhOSWdnRXVhQzlpZlNvbFZ1b1ZCM3IrSU5lWkVPUlVr?=
 =?utf-8?B?aS9zOU5mSFp3OTNhd0RiWVhVNko0dE15Q3UwMzEzYkNTd1dVeE84QmFkOGFX?=
 =?utf-8?B?WUg0VzYxVEFONE9FWll3MzRvZWJESDYvSFFyWmxpSng3L0IvM1NGaUlXdWll?=
 =?utf-8?B?VTJ4ek9adUZ1UDBIZzBvaEZzMjZpNGpFMVBWUmlzQUd5S0Nlalo5Zis5blpH?=
 =?utf-8?B?LzN1MlQvZ0lXN0VIYTJiUmhBUWZNbTVWQmU3Q3hXSjlzcTFDZXBZNlNmOUl2?=
 =?utf-8?B?MjdMOWVqZU5ycGo2YjRrcWNKNG01eEhlTjBNRURPQjcwZldiM1Qvdkg2blFn?=
 =?utf-8?B?cG0vczFtZi9YRDNqcTVFaFBQV2t2Z1dvOERlcUw0SGlpZ2dMdGVTWmliekVl?=
 =?utf-8?B?aEZKZzMwVmlkaE8zQkJKa24zMmZVbEw1UjF6NHBUSGZRSk9aUXk2Uzg3UXJH?=
 =?utf-8?B?WWJEcVY4N25QVWRMYktpaEZ4eEdhZFNEU0NxWDZvd0UxaGYyNFV6RkZZaWNv?=
 =?utf-8?B?QmwwSThRZ3VybVcycmlCbUx6Y1hvQnRSMVVSRkIycDFMbG5rUWZMVit0eVZy?=
 =?utf-8?B?MmdOd09PZ0oyaCs1VFg4QjB0TFVSMjU2VWtQVDgxTzZNdEtOR1lUQUVZM3hL?=
 =?utf-8?B?dm5OUkk3eE5vMXllV09oa3FxMGt4VVM2cVRrZy9QdVRGYVVNeGRrWXl6T1VH?=
 =?utf-8?B?YlBVSi9XWFZNTDk0ZVEwOU1YbVJpek5CdUx0MTJsckpUc1BQbEJlNktJSmhj?=
 =?utf-8?B?RFVtTTRNN3k4aHhQbXIycEczWUcwdDlDb2tqYWp0Z3RsdFpYRXJFb2gxeVUy?=
 =?utf-8?B?NDh2bTErUDZac2tyVTlETXNnRG91c25EUTdRc2NzQmRtWFRhclVLMEsrcEZt?=
 =?utf-8?B?YTgxMXYvekwzditTTHFoUzE2Yy9QMDZnT1luMDM3UW01RFJ4N3ZJWmFNd1Fv?=
 =?utf-8?B?T09JMXAvbXB5cHBWMXRqblFaYUVlck5yR0lrbzZhVUx4OUxkdHBjRTF0L04z?=
 =?utf-8?B?eVd0b0NlY0pnMVFVc2p6NjcrM2Y1SG9jTGs2b3JIM1BGQWltZ0QybnZuSGZZ?=
 =?utf-8?B?V051YzNISzJScmE0TENZTS8yMk5Hc2dHbU5oM1h6TVpXVVYxdnBQSzlkd2RZ?=
 =?utf-8?B?amMrQzdDb2V6WFFaOEVUdDR2WVVNcnlJOGg4cHMrbDMrbXB1L25CREtvbEFN?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t6DLEhVX/3w8HE0fm+8DWSbbzSkI6fbxp3zzZVIHnINRonnVVKYjcPVhhIzSN5g2wJ8aYW0wsAEoJKNaC66iPLc5YXl5e8fffAgcvt8pSmw/9OCwOkeQaDvWSOz5kpAil0Wv/LV/pzMhhlnZ7d/vLd3P+y6KLDRxntQ+2Da3qqHLtDysP5tqibbi8uNab2yaZWI45yUcahtX2eZE3fkZxwlGghoc3bguDXe7Wv/SGXxCLXg4OiLetzw77FIPBFDiBpfcTszubRgyLML7cggWP5oNHdlVdTUm/BF/Ql78tU0MXG11UeZWA6c6FydzGg01zhL/kUOfTllx69fvG981f+J+yAFueecba6uZbMz7leg26Ao5ztEMmWBv9vngjN3/FL+mtcPC+rYgBPZYv2ZisCrdr+8Ax8W1Qgy8K1GZ5caFq1Y4iw92E5qMh+NFoAVlzobh7sE8EnCnCebNjQoatnxf9qv7RUFytswpibYySUO5cBatGkqfs6gggbwwMvglDXx5cSUMLL5whEFlwsgdm9r08NVKbSsATQOanZcqbb8xviOEVaZuJ0oycmI6kyEs4CTSiE4dIR59mcmL0McAC/O+WpvlrsBeMn6P3qKLg70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21c6ef5-2384-40c8-2490-08dc58dfc48a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 21:55:27.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7T2b+L4WNzVyT1bFQaek4SkR5+mtZ5Kl8yVOqdSWwvAr9c7/jDLy59+az3O6CEntr5UDbMMDv4zwR7UXRdutPzbZpeKYCjTQAkaTH2E9kU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090149
X-Proofpoint-GUID: 0rMqlJLUK0E72wMu4G_dBV-nrQ9mB1gC
X-Proofpoint-ORIG-GUID: 0rMqlJLUK0E72wMu4G_dBV-nrQ9mB1gC

On 4/9/24 11:40 AM, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2024 at 09:57:00AM -0500, Mike Christie wrote:
>> On 4/8/24 11:16 PM, Jason Wang wrote:
>>>> It turns out only vhost-scsi had an issue where it would send a command
>>>> to the block/LIO layer, wait for a response and then process in the vhost
>>>> task.
>>> Vhost-net TX zerocopy code did the same:
>>>
>>> It sends zerocopy packets to the under layer and waits for the
>>> underlayer. When the DMA is completed, vhost_zerocopy_callback will be
>>> called to schedule vq work for used ring updating.
>>
>> I think it might be slightly different and vhost-net is ok.
>>
>> Above I meant, vhost-scsi would do the equivalent of:
>>
>> vhost_zerocopy_callback ->  vhost_net_ubuf_put
>>
>> from vhost_task/thread.
>>
>> For vhost-net then, if we get an early exit via a signal the patches will flush
>> queued works and prevent new ones from being queued. vhost_net_release will run
>> due to the process/thread exit code releasing it's refcounts on the device.
>>
>> vhost_net_release will then do:
>>
>> vhost_net_flush -> vhost_net_ubuf_put_and_wait
>>
>> and wait for vhost_zerocopy_callback -> vhost_net_ubuf_put calls.
>>
>> For vhost-scsi we would hang. We would do our equivalent of vhost_net_ubuf_put
>> from the vhost task/thread. So, when our release function, vhost_scsi_release,
>> is called we will also do a similar wait. However, because the task/thread is
>> killed, we will hang there since the "put" will never be done.
> 
> If you can find a way to cancel them instead of flushing out,
> I think it would be better for net, too.

I don't think canceling block requests will be possible any time soon.
It's one of those things that people have wanted for decades but it gets
messy when you are dealing multiple layers (fs, md/md, request queue,
device driver, etc) that some don't even use the same struct sometimes
(bios vs requests) and you don't want to hurt performance.

So for vhost-scsi we can't cancel running block layer IOs because there
is no interface for it. We have to sit around and wait for them to
complete or timeout.

If you are saying cancel at just the vhost/vhost-net/vhost-scsi layers
then I can do that. However, I think it might be messier. We would clean
up some of the vhost related resource, then return from the
file_operations->release functions. Then we would have to have some
workqueue that just waits for driver specific responses (block layer
responses for vhost-scsi). When it gets them, then it does "puts" on
it's structs and eventually they are freed.
