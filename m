Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74600142625
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369813; cv=fail; b=jpUW9ECjsBHuAtyFvTbsdFxaoUpx1U1pzlnUAbiNGzH94zgAFrEppp6h/mOP7L9fgCy/7nrhhc0uGLc5EMLsitBqwND+gosjMuRGotqvPtWjRWlhxhM7w0sDNyIiK06glIB3oJNL8ocNyU2qbdb47mS88OTyDG8Aih8B+Ls+wGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369813; c=relaxed/simple;
	bh=K3AiKkG1/ZmKY698ISxPKdlluJ71p1yLO8LbfqfX5fw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tm0NaWt9k+FlXEokT1uRqkmIC0FUDKDyuFOuAi4K9BR+VhAOD60FWa8rkiIVT3wPBsmzBbDgVwmTFAVmhuyzJYroL+lh0bxCnx/zCCHh86YC8nxbGBRACJuc5r1y3WKMXFhRqx2KkIBbNIRKiSHTVXX4wgEpMgcuS2Jpf8Dmgyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cZ5t8UNi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TGPOgonM; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZ5t8UNi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TGPOgonM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 265A760894
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 16:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1elj-NoVUsFP for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Apr 2024 16:03:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C410E608E0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C410E608E0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=cZ5t8UNi;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=TGPOgonM
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C410E608E0
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 16:03:23 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFNqOW001271;
	Wed, 17 Apr 2024 16:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+a8cH9e7lKOIOxanPjMagE6yWQAtegXP325GKjJkBsM=;
 b=cZ5t8UNidmfpYyc6S/XMJjP0OdAf1zLWgevuIv5hQBiuKrv9cmoWYUBaDbcnD232K55F
 tBrMgNiYs2DOdaeR8Q8SHxELwqmdzcEzthL/yYwHkEcE2okws1uoDkAzrL0EF/aybdy7
 dlL/lfaahbSCDD0njVWe6UTm18i4xTjXkQYUW5Y+Wi/jt/58NfEd3e6+MTRpf1nYxfKp
 uY3K5UX7Pb1t9TwEerWhfDvbQHkdIA+lIIC5QnqlKhPaNXviHGb0HwQuhGX2u3/FISXk
 aDNJ/EEXWPrNCNnYcbrFFyRiIWeHzUin+l/S3I/OdGwJ0WF6d86N/5Y7tQ3ZOhRA6mqR jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e8du2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:03:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HEVm7m029342;
	Wed, 17 Apr 2024 16:03:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg91xga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAvZGXckZFjGkcyjk12eegWry15pV/C6Vt9EUPS6dvLpyel/2/wWQr6ttj0W1wue0nP/Gi3G4X05m84+pN8+gt2hpfeJUPShQHCFiSr+C5Nj9+hS7NjGX9iDrBmRuea32t9v3vbvMU+OL3LLqByULodcf4tC0QkYrgYaWLozfcD3fe5LImDziUKZIzWj9bTAi+rPMIhc9Zsu+XSPke0W03EBMJgvU0mLq76J9sXo3Woa5FVSD3QOwN+LSNP1GAPQFSlZm02CO/zwmfkihnB6vcfrajc4I/XOFGVcGD3YocM4hjEDEu27nxdfr/qbSvnJBzgy+aaim2Ga9T8V4snnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a8cH9e7lKOIOxanPjMagE6yWQAtegXP325GKjJkBsM=;
 b=VCyB+srwZAKRhYhN6foN42oBiJyigPOnLK92bj9t+1klLB9NwR2Wk0monYERcKt9rGJX52qJ4rqJWKnf6KhSVDgdoW3ztXK3nBdlkW3ycmsbsc+ppKUo936gwp8NJVw9XnOiPkUPfiAutZxi9z+yQNWW1PCLqt/nAlZX+j+Re6uZiCFWGlJKBkSm8asMT0Bfu+IcNXZxL6g3ZasWuF26v3jiEvQ/7hC9YdMgGLaWPzd7cHYG5CtiTUMmYz3nvcu4m4669ErbIZX0k9ZYdGpHL9jq0tLlrIiPbGjmSk7lXBVwp3bEsSgm3TpOcBBTmIfXwQdJEmA660Vu27BjSD0wNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a8cH9e7lKOIOxanPjMagE6yWQAtegXP325GKjJkBsM=;
 b=TGPOgonMUsKBF2zv+pS0xJACR0/4vrSlgcOfnpJnvPbXPd4BuRGkb29XSVOoCXGq9ZFJ3UMoinDqjJ84GeObHL0uDGSej7jB5HfqDRaHb4G2r8mvPMBnu8T46WyybDyO7VjVcc7o5/4pm9yqrfZ+Y83QNUjneJC61YKWg+xY4e4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA1PR10MB6344.namprd10.prod.outlook.com (2603:10b6:806:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:03:10 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:03:10 +0000
Message-ID: <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
Date: Wed, 17 Apr 2024 11:03:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Jason Wang <jasowang@redhat.com>
Cc: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
        Andreas Karis <akaris@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
 <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
 <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
 <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
 <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
 <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:610:4c::36) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA1PR10MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8e7b56-988e-460d-f53a-08dc5ef7e0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6sFZ/QikfZ3Q6n73VpH4NNq1VbpPgYlKQi/DCeEAjKTTXg4Jmilu4k6jHx6SFp3AdpV6m2/3JaBnEjEeJSJMM8NYkwop02OTZ4Oi8CD3fLX1URJzBQHPmry3xB3NVKOpTaUrdpT0m9qZ5PnVdUDFCkFxvbIwV6rgcUW7sJWfEh2K9/6jmkVl1iq9g9dGdWa4G5wF7zPKt2N3dv7exPfIrZmcVe1jdtxUB4/Oms9/uA0SeSSgxexjdPkRJjUYZ0Qa+8bYkkcBz76VBM+iOjb4QJ1ea8d3t0dkkK1LeLCsS2ez1pFT/dWMyGUqNpa0AlPWJtshq76wlpn+ktOBgCM/54Jeoo/yKk0Iff828ANUu/xsCYUr2kYvNJm59sbAafk6t3HrjJujPS5Uo9rhKukOczbMO9CY3mAvZXgq080feIGAi8RPtUbSrk80rapA9mOrbSoOnFijIUNiYPQP++K+esRzw/NBWI0gx9wYj7gnMv96vJl8p5V5DIVkpXXvt+SHCeuuHlCEj/wAPPk3ZJKAHTt4vzpA/9OrXAD8pzaWYWIybMvZ+p00OVId0Xfqtu4+4nuMU1DR7G8vSpkMKo30fAUVICx60JNQQ7jECyhUDZFD6jWOyGMn8IUS2F7xPzLv610xFH5w3zmY4w8xuZsHM9Tv1RRg6WIz1iGcpRyf8Hg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEIwcFVHeEluUTRXTEdMVHZmRUFKVU9rQU5aOXRUcXE2RHRWc1ZQQ0ZkZTNS?=
 =?utf-8?B?N1pKNTRlWVFuWDBib0g0V2ljMjBwV1ZSK0t6MzFQNlBlUk1DSEhBWEtVd0JJ?=
 =?utf-8?B?Q3h6R0xZWitiRGFTdS8rdTl4SGh5Rk9sVXR5aTRjcElETlVEQ2FUVUVlODBF?=
 =?utf-8?B?UjEyTjBVei9kV2ZmOFZTSm45eHpFZG9oNTRNOFl2LzJjR2NjUUpVenA0TG8w?=
 =?utf-8?B?ZEovQkF4SGpsREhHY0NuVDBEeTJhK0I5cmlpdnlja1VNMjRTNVU3anhDV0p5?=
 =?utf-8?B?aWJqbmNlYzJCNG1RMkE0WG1LTFg1TmMxcEFlQkg4cU1FbllmRXNJMXRJMW5o?=
 =?utf-8?B?d0wvbnJqQTFRUTJwVzRhNzlPNUhmQWNuNk5qRGl4RTRQK3BNbjRFZE4xZVlh?=
 =?utf-8?B?bHM1NFRJT1BYS084NzhrQmhkelBKVVBidlN6WjBET3l5YUJKa1AybE5mZEpw?=
 =?utf-8?B?YlBOS0E4cTBhUDF0SHhWdlpLNDlBZ3ZvOVZlMElaWFl5MUxRT1UxOVpKMU5s?=
 =?utf-8?B?aFlKb2cwN2lSaEhMclBlcGJrUDJrczViWlN3Q1pDZjRSUWx2RUxDa2szYWcx?=
 =?utf-8?B?c2N6Qlc4NXVPNytQcmVLZEZGSVNlMGtkTzRQR3YxNVhBUWhZVTNWc1BlL2tu?=
 =?utf-8?B?eHpxU1c3WWtUMUR6ODRaZmV5S3h3a2h2K043TGJaL3d5WkVzYnB5RWRvYWVK?=
 =?utf-8?B?N0RmZHgwdUY4cEx3cWc1TlBrSDRiZTRVdUZxVWxsSk80MEtFUWJVRFpweFAx?=
 =?utf-8?B?NHdRZzc2Qm9VVkptOGdrQkErSjhsVTNtQmtXQ0Z6SXRYcTJsZnE0WXR1YVNQ?=
 =?utf-8?B?am9LTnFYNll3WkdwbWp1WEtnVWpNdXlzRVJUSGlsLzZURXAvYWhMSVNNVnpx?=
 =?utf-8?B?VXUrMURITmJoQWQzYXZiZVk3emZPNlNaUHVQVHQ4OUQ1MVBlRG9yeVlrcEV2?=
 =?utf-8?B?ZmZ1ejhCOG5XVm82YmxSSGVLbXh3UWRyY2cwWU9veHlpaEZKejQyQlJjdWFG?=
 =?utf-8?B?TnJITGhXYWlzV1lNWXV4U2hqcUJQSVhJWUJSbUNieW0yMGd3Y0J0c1pwWWY5?=
 =?utf-8?B?dHhLclh0VkFWT3o5TXJTTmRKZ1Z0djZLR1hUbEo1ZnNkQzlmK0Z4TDZLT0dJ?=
 =?utf-8?B?bzJZdHJjSFRxbEJadFFQaXlFdmhvb3hFekFGQkVpTmZjdDFXRTY4SXpIV1ha?=
 =?utf-8?B?cnlwTk82RzF3UzR5RTJIbzlHNGtwckgwaXZyNTJ2RnVqOXNjaVc1OTdMbUVY?=
 =?utf-8?B?U2kyTzFoZVdNNUJxejUyczBQbmhBWWpURmNHUHBzREFnZjJVNHEydFdZeTl0?=
 =?utf-8?B?MnlBdUhGUnlzdXp6SmZDelBxcC9lQXhVUE1Tb0hjSFdyZXZDSk1qNzRKZWpL?=
 =?utf-8?B?S0lHKy9kRjQ5aEpzcFdWWUNCT0U2L0UvQU1HNDZrNVFUUEFlZ3lkQWhJOCtQ?=
 =?utf-8?B?UFUxRlhYTmIxTkE0WWsxTVZ2ald3L1gxYkFjMTZCWkpTS3dnQjQ2NGlsNy9I?=
 =?utf-8?B?eTRacmNrUmM3S2huU0xETjZWS3ltWWZKL2dpS0xDK0FVWTFrem5zeEJQQTY3?=
 =?utf-8?B?RXdOdGpsYm9ReVRvSEtrcWRPbG1GaXVzOERXYVM0SCtBYXVZaGVSWGJTN0hL?=
 =?utf-8?B?aHFMKzVIV1BOZmdvbmRBY1R2MkdMN2N2a1ZuUHFkaFBqdFhMbkdtSEU3ZjM5?=
 =?utf-8?B?bXdmYUkyaGdrRTVtcTBMZHF6VnV5LzlTYmFVRUlzb3JzRmx0c3NDUkNvKzdz?=
 =?utf-8?B?eVp6dzVhOUhYY2xkWFFZc1RQYWx6QU1qNFloWmZoTHhyWWxzYzVWMDI1NGVK?=
 =?utf-8?B?Vm4rQzlqcmRhN0o0Y1A3dnh1SWxzVkNzTVNPWHdvSDNHaFEzekhTWUpINSt1?=
 =?utf-8?B?RHVtNG1YczQ3SG5lUWJOVzg2ZExpVFdMYTFRSHBmMnpXYXMxNkYxblFIWUZ3?=
 =?utf-8?B?cVdxVWR2eHZSWGRNMHVTWHVSZS81MHp0TEZoTjZNQ0ZabHgrRnVvTjkrRlRJ?=
 =?utf-8?B?T0JZanVGVkFiV2tndkE0ZmNNT3RPMVhOOFRSYzAwSGp6c2RXSllabGJ1SUpL?=
 =?utf-8?B?cVVSei96UU4zMk1ZMUpRdUpWNVhIRm13RFNaZjFGYlp1Y0lzM1ExZ3ZkaDFB?=
 =?utf-8?B?UE0zNUxuYjdQd204bW1EUm5uQSt5QzZYeWJFYkVpNTNkNGhZaHpvTllmYWl1?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0hiUZYCpnOr5yXSrmkMyxzDvz7TRAzWvpQFMUVNAVzBqrCSc7AnsRH6g+1OuNoMNoBdbcljdMpObP2G+lFYObl49bJH0XRMtnJk3Zw+g7IKksmaWaMN0WrJbVL5a34NWWEXMChIb52ObgwhLid935gmDX4ze/gmosvswS9GJ8BrdQ8c04eqyAgFmx+FhfmDqS4+kPTV+4cENr9/PYF6cINLXBksS+ll7DMLwrXqHnlCud+PCnJdRrRigwnhM4I4eRPubHxGko+SLpIF5JXiVD4kfCbVZ40ilfSZ3E63jqYgFhxS5dLThPRFJsN7A4hqYZZh3bg9qWnSLdipEuXoWQAw+V2gw21TH+Rh+2Mn2Tcu2YNmM/93svfYi25UbFNu4jv/nQKFPMAqZ6HwW8yvy5IjjXkZiyjig7G19EFmtiCoZp1eVusGpc4wbOk9x2cM9ATvOdV7jY907GmpmCZEGsT4G+1DB3veMoad0LzChp8w8ecx8JrMBNmrqP+9NeQJjFraVtVc0rCkpKbmwEUsRSH0ZeXZu6aSga3kS5bbLqjkxREFTXQoOCGNWTg1WINQdNV9CNijeGHIxX4f8UC+5Wap7g7kd7vRTAewEWvFaZLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8e7b56-988e-460d-f53a-08dc5ef7e0a6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:03:10.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGyCL+7Po/0XxSINYtIiI8mgDakpp92ozIXT05Dzw94esStMbx5beWisa9jr2PRcZapF3OKfJWIcxSJjPMgC1ZsVMuaKk9cBf6GrstmnOB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170111
X-Proofpoint-GUID: nzx6uNnCXxx46av4Z63-sAkCPTeNzti6
X-Proofpoint-ORIG-GUID: nzx6uNnCXxx46av4Z63-sAkCPTeNzti6

On 4/16/24 10:50 PM, Jason Wang wrote:
> On Mon, Apr 15, 2024 at 4:52 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Sat, Apr 13, 2024 at 12:53 AM <michael.christie@oracle.com> wrote:
>>>
>>> On 4/11/24 10:28 PM, Jason Wang wrote:
>>>> On Fri, Apr 12, 2024 at 12:19 AM Mike Christie
>>>> <michael.christie@oracle.com> wrote:
>>>>>
>>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
>>>>>> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
>>>>>> <michael.christie@oracle.com> wrote:
>>>>>>>
>>>>>>> The following patches were made over Linus's tree and also apply over
>>>>>>> mst's vhost branch. The patches add the ability for vhost_tasks to
>>>>>>> handle SIGKILL by flushing queued works, stop new works from being
>>>>>>> queued, and prepare the task for an early exit.
>>>>>>>
>>>>>>> This removes the need for the signal/coredump hacks added in:
>>>>>>>
>>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
>>>>>>>
>>>>>>> when the vhost_task patches were initially merged and fix the issue
>>>>>>> in this thread:
>>>>>>>
>>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
>>>>>>>
>>>>>>> Long Background:
>>>>>>>
>>>>>>> The original vhost worker code didn't support any signals. If the
>>>>>>> userspace application that owned the worker got a SIGKILL, the app/
>>>>>>> process would exit dropping all references to the device and then the
>>>>>>> file operation's release function would be called. From there we would
>>>>>>> wait on running IO then cleanup the device's memory.
>>>>>>
>>>>>> A dumb question.
>>>>>>
>>>>>> Is this a user space noticeable change? For example, with this series
>>>>>> a SIGKILL may shutdown the datapath ...
>>>>>
>>>>> It already changed in 6.4. We basically added a new interface to shutdown
>>>>> everything (userspace and vhost kernel parts). So we won't just shutdown
>>>>> the data path while userspace is still running. We will shutdown everything
>>>>> now if you send a SIGKILL to a vhost worker's thread.
>>>>
>>>> If I understand correctly, for example Qemu can still live is SIGKILL
>>>> is just send to vhost thread.
>>>
>>> Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL.
>>> We used kthreads which are special and can ignore it like how userspace
>>> can ignore SIGHUP.
>>>
>>> 6.4 and newer kernels cannot survive. Even if the vhost thread sort of
>>> ignores it like I described below where, the signal is still delivered
>>> to the other qemu threads due to the shared signal handler. Userspace
>>> can't ignore SIGKILL. It doesn't have any say in the matter, and the
>>> kernel forces them to exit.
>>
>> Ok, I see, so the reason is that vhost belongs to the same thread
>> group as the owner now.
>>
>>>
>>>>
>>>> If this is correct, guests may detect this (for example virtio-net has
>>>> a watchdog).
>>>>
>>>
>>> What did you mean by that part? Do you mean if the vhost thread were to
>>> exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
>>> the guest (virtio-net driver in the guest kernel) would detect that?
>>
>> I meant this one. But since we are using CLONE_THREAD, we won't see these.
>>
>>> Or
>>> are you saying the watchdog in the guest can detect signals that the
>>> host gets?
>>>
>>>
>>>>>
>>>>> Here are a lots of details:
>>>>>
>>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signal
>>>>> to a vhost worker, we ignore it. Nothing happens. kthreads are special and
>>>>> can ignore all signals.
>>>>>
>>>>> You could think of it as the worker is a completely different process than
>>>>> qemu/userspace so they have completely different signal handlers. The
>>>>> vhost worker signal handler ignores all signals even SIGKILL.
>>>>
>>>> Yes.
>>>>
>>>>>
>>>>> If you send a SIGKILL to a qemu thread, then it just exits right away. We
>>>>> don't get to do an explicit close() on the vhost device and we don't get
>>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exit
>>>>> code runs and releases refcounts on the device/file, then the vhost device's
>>>>> file_operations->release function is called. vhost_dev_cleanup then stops
>>>>> the vhost worker.
>>>>
>>>> Right.
>>>>
>>>>>
>>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
>>>>> can be thought of as a thread within the userspace process. With that
>>>>> change we have the same signal handler as the userspace process.
>>>>>
>>>>> If you send a SIGKILL to a qemu thread then it works like above.
>>>>>
>>>>> If you send a SIGKILL to a vhost worker, the vhost worker still sort of
>>>>> ignores it (that is the hack that I mentioned at the beginning of this
>>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
>>>>> then just continue to process works until file_operations->release
>>>>> calls
>>>>
>>>> Yes, so this sticks to the behaviour before vhost_tasks.
>>>
>>> Not exactly. The vhost_task stays alive temporarily.
>>>
>>> The signal is still delivered to the userspace threads and they will
>>> exit due to getting the SIGKILL also. SIGKILL goes to all the threads in
>>> the process and all userspace threads exit like normal because the vhost
>>> task and normal old userspace threads share a signal handler. When
>>> userspace exits, the kernel force drops the refcounts on the vhost
>>> devices and that runs the release function so the vhost_task will then exit.
>>>
>>> So what I'm trying to say is that in 6.4 we already changed the behavior.
>>
>> Yes. To say the truth, it looks even worse but it might be too late to fix.
> 
> Andres (cced) has identified two other possible changes:
> 
> 1) doesn't run in the global PID namespace but run in the namespace of owner

Yeah, I mentioned that one in vhost.h like it's a feature and when posting
the patches I mentioned it as a possible fix. I mean I thought we wanted it
to work like qemu and iothreads where the iothread would inherit all those
values automatically.

At the time, I thought we didn't inherit the namespace, like we did the cgroup,
because there was no kernel function for it (like how we didn't inherit v2
cgroups until recently when someone added some code for that).

I don't know if it's allowed to have something like qemu in namespace N but then
have it's children (vhost thread in this case) in the global namespace. I'll
look into it.

> 2) doesn't inherit kthreadd's scheduling attributes but the owner

Same as above for this one. I thought I was fixing a bug where before
we had to manually tune the vhost thread's values but for iothreads they
automatically got setup.

Just to clarify this one. When we used kthreads, kthread() will reset the
scheduler priority for the kthread that's created, so we got the default
values instead of inheriting kthreadd's values.  So we would want:

+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);

in vhost_task_fn() instead of inheriting kthreadd's values.

> 
> Though such a change makes more sense for some use cases, it may break others.
> 
> I wonder if we need to introduce a new flag and bring the old kthread

Do you mean something like a module param?

> codes if the flag is not set? Then we would not end up trying to align
> the behaviour?
>

Let me know what you guys prefer. The sched part is easy. The namespace
part might be more difficult, but I will look into it if you want it.

