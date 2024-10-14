Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF1231C92
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939737; cv=fail; b=RaumgxPolG2fNEI9C8JUAGSvA1WqhAjF9meffKDrOzgsdR/b1muzFRD0k+HjLWCMohzwyAjstQYWLkLGwJ45w9zOqOl5zg6p0kVZ4ZC9ffFXXTrFis95vbK5fOO9hXSN1aMW64DR8fS/dAb2ZqRXSUCl99TUx53IhsYu/y0MH1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939737; c=relaxed/simple;
	bh=9QbJ63DFDG7zZJtauMDT9wPGkGZRGi63fYA01VaEb/I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kg46dIDt4BS5AcQ8q3EeBbVuuauaxWy3FIHj3Foh2iZyHBQXJXlcP/rKzCln2I+XsdJ2sk1qOMj4HMXcWh6OM2bVeMj/OPkRPeClmlzO0UJLe9r0xcIzFZftR78kkN3zVQOjdLBrzVhdwh+UBZFbxHCBvPtOYJnS+eWRJVN3IMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KXXyc1hL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bQL9Bf4h; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KXXyc1hL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bQL9Bf4h"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B01E540129
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 21:02:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ASXCLlnewNC for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 21:02:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB92F4000B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB92F4000B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=KXXyc1hL;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=bQL9Bf4h
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB92F4000B
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 21:02:14 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EKtbPD014765;
	Mon, 14 Oct 2024 21:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+PzZjSyZUL68WPD0FYepA5p9nNZj+h1fSXy9GAETHDs=; b=
	KXXyc1hLGfO5FIPZ6LCqWL3vg5aU8PPdLYs9b5fwFuTO3KUyf3RhMstkFJ3TL5lJ
	PagCM4IeZIH9kQR7oGZX7I3bYPAPjtPskBoJKbF0sTC0+wnCHBjMW6u/4YyhFdTF
	j1dlyUvit/Ih4/FIBWx+NMdHHrO8+vJwizWftvTkEKwC+0VFrBwXQIUdmeGJGMpl
	yP/MWnr9fr2xyCkP/wrJJwi8Th6Tv9GLkns82f1S9VnOuHSVU32KC0AIsFmvPWmv
	0YHly6uozwceA2p+pNcy4oq/H+sF9Li/rlzZhU+m35Tv52fxpyh8Tv4HsghCZja0
	FTfxjeCZJd+Z1jtO5TRm2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt7dc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:02:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJgAJk027322;
	Mon, 14 Oct 2024 21:02:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjd3rht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAUocSUqShArcZEBzZ3ozDt99Z5Qm/Nv4XfaStOzqPr9DJd9RVZiLjS8J5Y9bVDe0sgl1pWO7AdifONTxWRkqPaxxyKgsKEWo6UNeAnbxsIjd2blbFn4OX9viyeOlYdPFWXlm1ZTzR779PfiunPjPCETFGnzTMGh1SCZ6a9dCO9NaH39Qn8rpmvC7lW5048018LlGpyrJ/OdZ2b9QQTJA1xJlKoZRwWOVihwCbBZPGvT6qbXRXxVWHULcsarGExy3we4ujgu9XLM1LRF4TytsBDL+W96O7e3lPoRqJwhazdBY9S9PwXFA3+30JkLP8NLNI5HHcnAWYhaObqpWoqjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PzZjSyZUL68WPD0FYepA5p9nNZj+h1fSXy9GAETHDs=;
 b=E0ybRMsUlUcf3uTrQziMcgrLZqJB5/VdS/sRgA0Oviwwliy6b3gMevXkQbnh+F/qiQ5THP0qpXHxggInlxpu3hy9Ugsn/vW06fcG5eywfOfV2rkoFBJ493Al1zFVUv4jg8Q7yuqa+KAp5CxgZ6Q/foETVSpYXN8lRhBpmgFdyqASokFJFW95Zt3EsWqTJYI9cEi0rBoJZXOJ4h+vbW4uONoQpj4iL7h69d6FbPmB9GkMl63sjGk9DO9H3GVfHftqYAB68ha1XLpYQ/0RJ5S2qHFHcwTsbbxdNADTWacT2WNjWERMMfPfdM1qAQnMbUzKwmcQSvY/1Oxd/qll6ZvqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PzZjSyZUL68WPD0FYepA5p9nNZj+h1fSXy9GAETHDs=;
 b=bQL9Bf4hNVj8JPxGfKq6UpFYfd1+dWXVT1Jkc+6kElFPudX/n/0H4GVtHgdl9tBLQhDsiICesFSOOezPgZCTswNzSPQcNhsKBsLmYCR9Ht9t9yEHdK979Vqp2re90L9ukLOmgUFkTOFaolizDlMAYjKW2+uckALRgCgP686Md9I=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 21:02:10 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 21:02:10 +0000
Message-ID: <a317b7f1-b593-4cf0-a58a-8f375ad64f72@oracle.com>
Date: Mon, 14 Oct 2024 16:02:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] vhost: Add kthread support in function
 vhost_worker_create
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-7-lulu@redhat.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20241004015937.2286459-7-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:610:60::38) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d87ee9-4a97-481d-94bc-08dcec93784f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3NTTmdkVllPQ2R4U2psODVMU0FGVytHN1BpNDhhdElmdUNPdzZRcmphRDJI?=
 =?utf-8?B?TzMwaEdSN3VTQWNLQWE1MlBXT09NRGQrSyt6bmhRM2tkMW5WNFhlMXVCN1li?=
 =?utf-8?B?UytaakxwanpWUnhjNTVzeDBMVHllYWI0RDltSlFHeEdpTGsybzlrVHFWbGJN?=
 =?utf-8?B?K2dINytlZldKT211NnVLYVFuMFExOFlxclZMVTI0ckxldStXdnJVdTQrN0NM?=
 =?utf-8?B?Mm4yV2t2RFJDQzVyMVNCNjdPdE9aU2NOd0xDWjJPN3pIc2hQWnNEZmFWRHJE?=
 =?utf-8?B?UittaksraWlYdmhWYVJscW1DVUt5TW9ja3dUWThrTkdqTzExSFpGNXFRK1Ru?=
 =?utf-8?B?ckdJYXhGMjNVVGtZWmZ6UFg1bE5ldVdrVkJxM1MvMlBEYXhhUDhxZEZBb1d3?=
 =?utf-8?B?ZVczTElwRnpmNk1CMFFEbTNjSzVIa0NLRWlINXdBMWx5T2xsVmdISjYvZnFq?=
 =?utf-8?B?QjNGU0xhUENCQkVWbElNU0NrbDFDa1VpUGhHVHh0eEJFR2tTbm0vazBOMnQr?=
 =?utf-8?B?WElscmdXd0I2ZEhRUS9Mbzh3UDg3eEpBUmFqd2tPSTdhSmcvZytYTTlHaHhl?=
 =?utf-8?B?U1FQNGcrQkVMeWM0ZEwrTWdxNGtUZUNrcXFULzJDNzJPQkJHcjhDK09SVThp?=
 =?utf-8?B?dkd1ZU1SN0trNXlmVitvYjdVZGEyWnNNNzhDNmRkUzIrQkYwNkYrVmtxRGJM?=
 =?utf-8?B?azRFWGtWcHdJZ2wyTXJ6VFExNG1YM3BDOW9KcXlJRUYxbDdDa2xXOS9iNk01?=
 =?utf-8?B?QVVCZ1dxM1lHVFdDODhIMzRKZmQ5WWF0c2xEOWk2eEN2Z005VU5ReDFoakZV?=
 =?utf-8?B?WkZPQ29ILzBmYm9wbDlzUURaM0h6ZVR6aGt3M0hrOHZpSk5zUjErZFpVa05P?=
 =?utf-8?B?UkVhN2UySmRCallLZHlRMkl2MERwVU0vU0x6d3pIcXRFeUtmMUdXWjhidldT?=
 =?utf-8?B?akR2TjE4Qll0aXNuMGRrdzRVVWkxczkvVEFQSVJscmp0K1lRdmpzQmc0dDVD?=
 =?utf-8?B?Qmpaa0NFOU1Ea2FTekYvRWU5K2JFUW9WM055MWtleStOTTJjT0JzL3EzYWpw?=
 =?utf-8?B?RGtxQ2FtWmJHL01DanFJNkNqN2lqNkxFdVlOTGR0WWtjS0wvWXM5M3ZQYkJl?=
 =?utf-8?B?dTNqb0UzcldSOVVRYUdPL3dWdlVrNmNicFJOQlN0U3FZQUR2eEJqTGx1dVY2?=
 =?utf-8?B?YWxTL1A5TnNaK3ZkRHBCT2pBNWI5aEVId1FycFNhSmI1eWM3dktUSGxyNnYx?=
 =?utf-8?B?a0NUQmFmQ0pGOW82ckNMcUl2TC9NNk9iWE9Nb3FJMGV2MGRFZm1qQSs3S01Q?=
 =?utf-8?B?N21UQlh3bEtrR0Y0eU4vODI0TnpFQ0I1cDNqSFU4cEdNaEJpVTVzbDZSeWZa?=
 =?utf-8?B?L1VKNW1JYU8vK2I3Q09JS29zbGFNMkVxMXFpZk1QM3NSSnRFdkNEa29PWjI2?=
 =?utf-8?B?aC9OT2ZFeS9rRnhZUVpUSEljaXhYV080cTEyejBGaEk4UVJoM1hXQVlPN3lW?=
 =?utf-8?B?Y1NNUVAyeHdZMlZYOTI0bDFZRFJkWTB0d0swMnFsejhWc1VOc2VSNWorK3p4?=
 =?utf-8?B?enhaanRnY00xNk1SSkJuVmlMWlBITnM2N3ZXZGVIb3A2aXh1RUJzZnBMMSt3?=
 =?utf-8?B?S3FUL0JTeVFjU3BGbE5qZG1udWpxOEJtanplYVFqb2dyNW5HTTZpSVh1Vko1?=
 =?utf-8?B?ZE5qQVZvMzcvc3d5VFR5elllMEFxaGVEcDJza0FRdFNYRG9yL25iYnJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M21Ocmc0KzBkUTJyRW1CdktSaXdycFVpbmNncnVENzJWSjR1OWlac0Q5Y0Zs?=
 =?utf-8?B?ZmZXTnMvdWVpbEJFVndncFRvT0xKY3NBekZ2N2o0U3FBTityajlmZkMwbWlK?=
 =?utf-8?B?Um9jUVdocGVYcllkWG83ZmkvTEROQktMbTVFK1pvMjBkWVRqUC94Z2dwRUdr?=
 =?utf-8?B?eE5PMUQvN001d0FDQmFUN0JPTmFWMTZUc2pwMDJodFVSME5VL1JQbWppK213?=
 =?utf-8?B?SnBPSjN2OXRrNnhsUkcycXh2Z1VzNWx1NFh2Q3JFR1BCS2lHcUp0cS9vYmxx?=
 =?utf-8?B?ekFwTU1TSjArZm40Q0tLYlpRMkVTTXk1NUJmcnFmTjFramFWbUJGWjVSMlZ4?=
 =?utf-8?B?U3Yzb2E5TWp6RzBqamZPMFFPTVlhSHNPNFJlOVRLTjBCYlc2YUFrOTNZRHRI?=
 =?utf-8?B?OEV5MHBrdFVHV1BGeTRYaHQralVNdUViejlaNEJOa2gwaUZlMEJvRG9rVFZ4?=
 =?utf-8?B?THhSZW90TGl1c3RXaUhza1JsMG10MzJFN3UxenVtempTUXYzY3RaLzNFUXM3?=
 =?utf-8?B?K241TUgva2lVeFljbUpKN3g0RkxJb29zR2ozdWhqQ1NycFZJUXFoNnozUVBk?=
 =?utf-8?B?QzhwZlhPVEZHOFphRFBOOEp0a1F5eWVSUG1HaFh3M3R4RDI4VWJqWmxsK0hq?=
 =?utf-8?B?TlFMMDBaUVpDTEsrWVdsUC9PU25UVllxRFl0SmoxR1Y1SUREU3BuTy95WXEx?=
 =?utf-8?B?bXlJem1qYmNIQWJnY1dnK0txMVFmbnFIMmlVUDk5YUZuUTZPdWtpWmRpbkpQ?=
 =?utf-8?B?UDY4ZXNQYzk2bmJBZktvQ0E0Zzd0b1ZLWmphaTFjbHdDaVJUcEN6aUo2NGgr?=
 =?utf-8?B?TkJNY24yQXUrQm9nOGdJWjVPUHRwL0lTVHk2dzloRGRGRmpNZFZCdXdwM3Zu?=
 =?utf-8?B?TTB2YUdWNmpUUHBQTHc0RUN1ZUpJQXcyanhaUVJuWm1EQy9NMEV0R0lQdmQ0?=
 =?utf-8?B?MmNGYXNTOWt2UFNqdFpUZTZobFFuOXREQjBRYkN4RHhjc2NzeEd2Q3ZJRlIy?=
 =?utf-8?B?VjIrbUZ0VmJnYTRncUFNWldUQUFGZlVnVVlvUHM1RDNXazYyTWxmRjNlaDlB?=
 =?utf-8?B?eElyaVRWRGhhdlA4Z1hkRW1HcUFzR3dQVEdqamJ5dGZXcGx0M2IvM25Bamll?=
 =?utf-8?B?Rkd1cjlVa2huQWJ2MnlvQzVTbWNXMmN5ZEdQK1hUcCtSV3V2cTF2dVhFVHZ0?=
 =?utf-8?B?cTFjQTFoeWlFaGpnL1MwZW50L1Jrcko2dFUxTnlTY3dVWjdqSkNaYXhVVGZo?=
 =?utf-8?B?WXh1bXBTMytMWjdzcVd4a1o2NEFITERPOHlCc0hzcmI4M0NlSWV0ajVjdWw0?=
 =?utf-8?B?cUZreUF4QURGaVgvWmZ6bnRLQXNka2huT2hzVXFpTWE3TVY1ODV5dDdDVWda?=
 =?utf-8?B?SnpGN0hJMVRBVGtKV1JzK2VzQUFoQzE4YUNLaE9rNm40aGlMM2JLQmFBV08v?=
 =?utf-8?B?a1d1cEZWSUxXa3krSFZEZzd0QkpjVGNyUDVJUUpVbUFrbVVKYkNDckFpcGVX?=
 =?utf-8?B?b0JtS0hsdm5iWG5wV05CdkNTV2hXQ2xIY2JZR0N1LzR0Q1dKYzFjeW85UHhI?=
 =?utf-8?B?WlVLZUpJMWdwTkN4dmEvM25LeFNLZXBTL1N6L3RKckZ2cDJHdW0rS1RqcHpP?=
 =?utf-8?B?WE40c2ZqOVE1SFpvbXNtVU5GdU1PVnVkK2tJT1F4MVJLRWdIa0NQeUVBMHJw?=
 =?utf-8?B?UlpCTDVmWlpjWW9ER24yeFdCbUNad1J0ODQ5SDM1cm5ZYnNXNE5NRlk5elYz?=
 =?utf-8?B?RHhWcEdmdE5WQU5rVnJpY3g2R1M1MUhNaU9DQVhPZXhETGpnbmJIb20vZWY5?=
 =?utf-8?B?QjdKU0FtV0ViSVdGVk1IWnVjelR2U3VoR1Y1RWFxS1FCSWM3TW1waGNhb2Vv?=
 =?utf-8?B?QmxmMHk5ejcyR3RIQVJYM2lwQm1wcGhIYUVOYlJFR0FuVVFBWjJhVndpalRU?=
 =?utf-8?B?RkV5YW1veHBNa1kyOTdrdG1ZLzZUU2JoWU9ueVR5cUdkMi9kdnlzdDdjMEc5?=
 =?utf-8?B?VDVmbUJLVkcrdWdQd3dOUXlxY3RZeVBnNDN1YnlBd3FYZHIwMVpFQUhBQ3ZN?=
 =?utf-8?B?K0NXRXFuMlNZL0JEQ2hXSGhMU2g1MEQydlBOUnVBV3lUYjc2TmtwNWVUU1hK?=
 =?utf-8?B?M2lsWWdRZ3hHK3Qwamp5SnZteDE5Rnd1MWxHbkNhNkJNU3h0SG1kbndhYm5S?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ip97VaRwI3HzAnoSf4EA6VjQJxMnPdP1BN1v1pfPFOrBAKXghvW+s7SHT9J8GKu6LAHhoOZ7GaxnfGVTCrS2zpPATDH1Zj9T6GhfAqLvG705OS0g+9JjSDI+h1pebRcpn0O8E7rPJkR/+7vEXUMXFFERlTj/ZJfM8JUegl/LQHBylaJlrXwrrw0EO0RYWD39KkXESogtx6ORDGwCBkHSmu+JM1sZcxoj2UZMrp0nTL9U+fMGR0VIquOqFFSDab3ML9Z6y/h8WFDBfHR/v8tZyBDU5rqomXUoWjdDNz3fshUIh7ra2pN+yipucN7JlxFsS3Qhx49QXYolbP5hFP6T6slQOO1VTc+/y97jKltl3WKr6/sIo0BiYDNsDjZk5ekVbr6PlcebzEGjkskXTCBPehAtoleJH+xYyFtjMUjQm5T5SQpsTkSmzsafjBqUVvDGZ/o1FotR8aDVFRh9xHGKkOhYPVfdEtvv/AO+t/rYS4LGMlkhd/uh0bfofO5RZad1LKxHqAC2GnZPNSbZiHTcJ6u9/0hE9mePT0B4zq1Pp716ZfyQLSXirj/8X9yDiZ8SIC+QJ5owta0HLZzWWIsmHfIlJ55Bjjkef5BRX+rV10I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d87ee9-4a97-481d-94bc-08dcec93784f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 21:02:10.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgIztCB64yO0jKyKxGI2aQbza8VmwU9XrGxrvQ73FfaYlAOhwdAvxX2Qi0d3O9sOdJzvlOAbZDgEGCDUe5FPLDElfKdKfU9JEF/dDUTQOTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140149
X-Proofpoint-ORIG-GUID: YqK6y3KtiskVnf6rBHp1q7kgaMo66GKn
X-Proofpoint-GUID: YqK6y3KtiskVnf6rBHp1q7kgaMo66GKn

On 10/3/24 8:58 PM, Cindy Lu wrote:
> +static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> +{
> +	if (enforce_inherit_owner)
> +		return vhost_worker_create_task(dev);
> +	else
> +		return vhost_worker_create_kthread(dev);
> +}

The reason we are in this whole mess is because for vhost-scsi
we wanted to create multiple worker threads as the single thread
became a bottleneck. We couldn't use kthreads because they were
not accounted for under thread that created it and we could
exceed the NPROC_LIMIT.

So with the above code, we could hit that problem again if userspace
did the VHOST_NEW_WORKER ioctl and enforce_inherit_owner=false.

You would want a check for enforce_inherit_owner in vhost_worker_ioctl.
