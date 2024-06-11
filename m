Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE33839C
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138500; cv=fail; b=L53vUVUnt4F0eo8HyoHkkK1/yI2QEWzmKIA93hhLy5kBzjk2LoFpN6J/cub4MWoiMK4Zeb9verBUxpyZzE+ouS79XqIb2nOV4qkFrZkaBd68W0W0cBx0rEKvDUyAvHjsRIgWIRJ1Cgct/MGDA+EeTyY82cdoMj+9C54fRvVDPdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138500; c=relaxed/simple;
	bh=YNEUmFdCZxHObSZTA/FDpXkImB8iYwTmeUSj0YXepv4=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=G3BQM/zrU0JEQq7u3w39sJy1T23KKAAvh4h79LwDKBtuggXQzOK9nr3QzzdOG+A/rg+ZP5gZOeWKSypeom8qFOPRvlTi0fVSvm6frsyopOCkl1lGw6Txs6xAA5MK1D2Yh/85ZwA2IcZIHaalxl43W2b5qtPlqON9EpI4tYNjqPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=lEp70bNs; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="lEp70bNs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2E3340B03
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 20:41:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLbS7IKfK7Sd for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jun 2024 20:41:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2417::701; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=doug.miller@cornelisnetworks.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8F7C8400D1
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F7C8400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.a=rsa-sha256 header.s=selector1 header.b=lEp70bNs
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2417::701])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F7C8400D1
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 20:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLOJ2shgTNU4hcNfKKt9cRTl52MGU9izbW5wsB5Iv9/u9SAAkb82pQAOHWOoCRXlc8LUu/2Dk+hEFZvRZcEZTbV/OKD+n5gYqYLk6cw/vnjC/foUlNlRTWaPaOK21etOcKOcZSbB+NAQpn32xbcZ3rpvmZIjjIvFmf09KoCOF7E+V2tGlVjDlizxx/2aPt5y+TrWE1OlRHLWOIp2z5HEJyRjNkngVUPagi4TZvFHw+Glp5gmsyWizjCQIKcbgzbMX0iXdQ12PREf48NUtPyvwVHjDXeZMkwrIHiSeo1avEWE5Y+C8rsGm5ycbWB6lMA8dj+GT9O+ptdSoRoPTEFQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNEUmFdCZxHObSZTA/FDpXkImB8iYwTmeUSj0YXepv4=;
 b=E8oTTz3RpPgsOmP56eX/aNzaD6XDudnZ6nXF84qP0djsQGARB0RQT9UAeX7H0WuxqLKEcg8md9m4KDEvS9qt3NWcUu3eseWtv3oMihVvsgHtSdz3mtlzoCwPtdjOClmwUDKwGlY2Kt7FpbObhMjvaKjqoOTKwSIpIKUE14oW9K/H+e8IaMS/rZs1l1hKOmVnIJaF1zT3Tmo45vpOu1T0Rq3l/zz4cat6tuQplSQkoourbFZHxzAVO1wMM9tAXVUKoSSIo7XL9MPk5GioyhjOjVqDdVRLk/VXSDvQ2gdWRR8WZZazQ36gXJP8uHzmHKUf8zcyuytJI2FJq/7XueWAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNEUmFdCZxHObSZTA/FDpXkImB8iYwTmeUSj0YXepv4=;
 b=lEp70bNsl3xyppG03nXJGwDHiWK7abNeg+JHWLNOCLZXtFb+Zo4okw6Q/k92lTbXUxoXc8COsaZieIwA1KR2Tgy0Mpeil/fjQm4NWqc79Kr9YnEmdXy8Q4uDzx6ITGsyahymDWDo3lS0r2hq8GpQapUZDMsP2egynk2QUyfu9+gOOi2SSTnKZ+GL8fHfIjvGgE3oFacAi0Z3MnvcEZvfPhxyg6Bc2l1MJ3Fo7g8EYzC+4jq4kMtXxqUNiZdsjojP+AdWXbUJyr7UL1GaAm4eEiDnjcnrclzH8xWf2MbSzxmLBMB8mQXMzKxoo6Ns2PlPL9uezZZ0tn/NNk/RpbR9jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM8PR01MB6901.prod.exchangelabs.com (2603:10b6:8:12::10) by
 PH0PR01MB8021.prod.exchangelabs.com (2603:10b6:510:281::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 20:41:32 +0000
Received: from DM8PR01MB6901.prod.exchangelabs.com
 ([fe80::7850:2655:cfde:c9e0]) by DM8PR01MB6901.prod.exchangelabs.com
 ([fe80::7850:2655:cfde:c9e0%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 20:41:30 +0000
Message-ID: <4c719bee-b0f1-4320-86dc-c2be08f236a1@cornelisnetworks.com>
Date: Tue, 11 Jun 2024 15:41:28 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: virtualization@lists.linux-foundation.org
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
From: Doug Miller <doug.miller@cornelisnetworks.com>
Subject: Looking for guidance on using virtqueues and virtio devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:91::35) To DM8PR01MB6901.prod.exchangelabs.com
 (2603:10b6:8:12::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6901:EE_|PH0PR01MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e4aa34-9ed2-464b-a0d7-08dc8a56df79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE0ySU9UVTZuYkM0WExVemhwejYyRTVQcDh3TkNBaXpvTDVrdXA1TEppOVZZ?=
 =?utf-8?B?dFc1UTRrWGVubFZqTlFBQkpmN09KbktSLzlhcGYxWFVZN3Q2cUx6NUx0V2hs?=
 =?utf-8?B?SmtldndKTzBodVhaQnJKQlZOOEhQMDZjSWs3UjduKzNzbkVXVHNhZmNxRHNq?=
 =?utf-8?B?b09ReGZQb2ZveHF3aXdSb0NlMElRZEZ6c2ZiWCt1K2ZTKy93ODVVTUpWMHRp?=
 =?utf-8?B?VWFHbmt6eDV0akxOaGxEVWhqSEF2OXoxVkZudjg5REs4WGhhVWhRTS9MdmJT?=
 =?utf-8?B?Z0cwUXBicmZEejI2eVJZays3ck4zZXRHR0FkaWthVEkxRnQvMW1sMUNzV1Nt?=
 =?utf-8?B?WFYzUU9VeVg5MklQSjIzUkZnb3NqdmxGNGpYaTJoNWUvNnJUa1N4emJvWk5v?=
 =?utf-8?B?M1VaZWtvL0hSWVJhaFRMY2M0cSs4ZGprMGY2K3RTR2ZQOXhtZ29wTUNXR2k1?=
 =?utf-8?B?NnR1SksxcmZSR0JDTE05Y3pKdG9Mb3lTTUprZ21HUFd0U0pTZXVyeElIRHdX?=
 =?utf-8?B?MmZybDkzdTFuWGYrV2sxUnZ2dTZ0dlhScnBRVmFScFNiSmhqUkJnTG9aR1VH?=
 =?utf-8?B?Y1pwcm15SGI4TkZnTGtZUzJNT1RYU3hJenlOK2dySURPTUdNa2tjNldSZVFK?=
 =?utf-8?B?Mi8xaTdUOXB2b1BQSVpVK1ZEajQvZU5VaHROY2F5QmJnNzgrQ09DcncwZTVl?=
 =?utf-8?B?TXV3QzNEa0thaE14OFZOYkdyVzNvVTQvKzBoRWszRzkxY1puYWRkTE9Yay9R?=
 =?utf-8?B?QzU1K3IyRzdOd3lXakR5cEVxQXU2TEZFQ1lndkNCUUp0SW8yM2Qwdk10MU13?=
 =?utf-8?B?M3NpU28wL0U2OTZUcm82ZlR3NWw3S1FLWUVaYXNqVGhUb0pBNjhNRmQ5dVNy?=
 =?utf-8?B?T3pzZ0FKYzhZRFdQYWxpZldycUdZTERqUmtyVWsxSStpUU9LNzZ6NlBNMHJY?=
 =?utf-8?B?enNIckxJVW5kYUl5Y2hBZ0hXeDVmQndQSUhGSFRwRWV5N25ldXM1ZlpDZDRT?=
 =?utf-8?B?V3VYMUE1MENuYlRneTF4UVhEN3d4bkpGVzFPQTNobmNRUHpGc2h1Q0MvNWlo?=
 =?utf-8?B?RFozTUlMYmVzaFN5YkRMdTh3SFA5U3RKSkF2L2lYbnNNMklLd0hnajFUbjhR?=
 =?utf-8?B?QmdvTk1vRW4vUnZxUnFQcUJGd1hhZVcwZC96YnFiNmNlbkNIaTlHaEUza3l2?=
 =?utf-8?B?TEptWUd4dFNFblJUNS9MMitlQ29FZUNQc0tQa0h3bDhKWTBGOGMxeGxCU3Zz?=
 =?utf-8?B?ZFhYVW1uanVZSFFSOEZZajZMRDErU2dnd05udFJMeEFVaEp5MENtZmk4T2ZS?=
 =?utf-8?B?bzU1ckQ5U0ZZZkJjV0dhamh2TklvZEZuUEtrV3lzV2JMcGM2RHNyRnlYcHZv?=
 =?utf-8?B?VXBIYnEwaENDUzNqQlNtN0Q0MHRMSVc5OG8zNlRpOWNYMmxMYk1INktqbTlS?=
 =?utf-8?B?T2JZS1lRNER6akt4RDV0czNxd044blZWOVdmY09TVklURFRGVlEvdVdBL1Z2?=
 =?utf-8?B?TTFzZys2VTMvRWtwK21HbEJHT0ZZUkR3ZituTHhPVnVTLzhtajdwSVFHZG9N?=
 =?utf-8?B?bmtYRXpQcUR2cUVtMjB4N2htS0J0eGdVMUpuaHBYWWl4eHNlYnBxMS9WU0Nz?=
 =?utf-8?B?dWJCemEzamw0bnNUMTRvUDRkUDRrRGwyQ1VzR2pxVUMyVUlOS0tvUTVDOWgx?=
 =?utf-8?B?VUZodE9XVnVjMmx4Rnc3RFI1RG9rK3NLVFo0bXFwVEIvakhjMzdmY3MxV1Ju?=
 =?utf-8?Q?pG7rDrZ7FipGHkfVCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6901.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnpkS3NHOHJqRlZpQXVTNTVYem1yc0VWdWUwdXByVzJ4aS9jK2JETTBId1lk?=
 =?utf-8?B?bmw1b2llR3NEaFZVL0Y5S29qdUJ3NjIwVDVoWDA2UUVaZW5RekVsZWs4Z3M5?=
 =?utf-8?B?ZStoL2pQalRqTTNTNkFSVVlaRG9kNlJTYStiQTdjL1FNNVJOQjQxUCtXdzk3?=
 =?utf-8?B?WHYzb3hTbWRmUEQwOHUvTndjSlBDZVJOd2hreWZ0Z1oyeHRnNmEyT0M3Mk5L?=
 =?utf-8?B?Q0YzWks1ZEN4cDNLSmhGeks2N3NZSTBxM0szTStNM3oxR1ZJbXVtNWpYL2po?=
 =?utf-8?B?S1pWcTBXREFNMkNjakVQd3BsZHo4UlI5SlV3ZWxUdWVDc0tRUXNXcTYzNVRa?=
 =?utf-8?B?WE0wV2JJcGo3Y2ZGMEhnWG5LT1hPZUFoY21zU21XS2JrVk5vY1FsYndQZkdD?=
 =?utf-8?B?bnVvd05yMVBJWk1Dek5QSVN6cTVaNTE0QVZLcFVKK2EzZDVGNUxYTWJiYVph?=
 =?utf-8?B?ckY5U2ozZDM2OGdYSFNDaU9nNHlnRVJ3ODV2KzVSQzNoRWdKTktQcjFNWWVV?=
 =?utf-8?B?QSs5am1USGpXekhqdUZaaXJPMjg5cjJvTHprVTQwNVJIeTNtOWxyQ0RmaXRH?=
 =?utf-8?B?WkkrQ3lza3dsRXRYdGp6VlJCV2VRR3BYTUZMS3A3c1RwaFl4cTBQSGN1cyty?=
 =?utf-8?B?dlVwNkltemxXNWFjc1ZmSmNRU3c0WEtsWHFvYm5KY0VYTVhwVThsb1JDOFhF?=
 =?utf-8?B?TTJQQU1tUkVDaEJ4ZmoralVmejMreUVlWXd1ODdsQ0EySFoxeG1WckF2VnRZ?=
 =?utf-8?B?R3ZoUkVkQmNvL2xYY1dHa2hLNGJHYWlMSzZBVDlER2gvMitqOEVzejcrSjZo?=
 =?utf-8?B?Nnd2eUQvRmREajVHbDg2T3BYazJsZ2tDcXRPSXgwOEszb292d3NhSXBWVEYw?=
 =?utf-8?B?YjAyRjZFV3Q2WjVyQnZ3bFNMSEhocmJvSmp5bkNuRmhucDZYY3NiSkpBUGFS?=
 =?utf-8?B?NlI1MlExYit6eS9WVDd4OGpDRkI3L0VPVkZTbjFPa2ZJMGs0aWM4ME9XNzEx?=
 =?utf-8?B?Y051RE5GMm5IWEVVL2tKc0lPT09zanJRTmF3NUdLMkVnRk94NGYxWHU3c0xr?=
 =?utf-8?B?MS9wUks5SHBYNHd5dzVWZ2oza1JtQzNwdlRQbytpNUpuUlBKWGFvaDB6ZkxS?=
 =?utf-8?B?eFdDMUVJMEErcE1PRkE0dFEzR3hoTzFsSk1HK3Vha3BaMGFqTUx4Y3VjWnlY?=
 =?utf-8?B?YWJhT0Yxb0gxMkdkVVpKYWd2eFpDOTg2dWVocnl5MnI0S3pYcVEwUCtFdWUw?=
 =?utf-8?B?VG1SVW1BK2s4bEYzQktnSm5odmpNUnhFTG16RFBoU1JubHBid1R6ZDhhS1Ux?=
 =?utf-8?B?bi9TdGxVMTNrT1NTU1pRbGVwK201b3N4ZXErSEdpU3JEZVlTSGRTdVpXdXQw?=
 =?utf-8?B?TVF5UFByWXFsdkR6V2MxK21ULzVaSVFoQUxvOFNJWFFDZlpUMFRKa3laNjJz?=
 =?utf-8?B?TStKN01TUUFQNVc3c0ViSWlLZDcwQUxBbkFkd3o1THlYeU5TUVd4MXZMTzVy?=
 =?utf-8?B?WmpFUzNxSTNpZDh1eHVCeFVySlZDcXZtUFprZTU5bWJRaEVxcy9QZ2lqYytv?=
 =?utf-8?B?dkIvUlAxWGxZYkIzSXZXVVBOaU1QU0czYWdRY0JoZ0M0UE4yZWFFUWNvNENR?=
 =?utf-8?B?V2dUb1VJdVdWVUk3RmYwb1dQVS9QOTgrdmdqS0hsUmVmQ1JHMFd3blIrMnY2?=
 =?utf-8?B?YTZJbU8wQlBDdkowejZYbUdQVFdxeTlSSXpsVUxSK2p1STJLOXhhNkg3cG9Y?=
 =?utf-8?B?Q2hhK0dQT1drZFp1VXZyNW5GSm10T1crSG1na0w4SlBVcDlUUWdSRnEvNEJR?=
 =?utf-8?B?MnJPUys1c21UMVRYZUVJcnhldmJPMlF0UXM1THFYVU9ROWY3MkpOQ1ZXVjRM?=
 =?utf-8?B?YnhGNDVjZTY5S0lRZ0tpUHpZSFVQSG9OSlNuNGVzVVlRb1B1eXROUnl1ZUdS?=
 =?utf-8?B?VllBZElJdStrSk1JRW5zRC9OR2czVmVpSmVCTmJUWEdYbzdraGpoM1pYK2ZX?=
 =?utf-8?B?eDFEL3JBQVRMVG1aRW9LeVNxZm1lbXM4R1ovWU5SSHNRRUpCRmtsNkQvOUVh?=
 =?utf-8?B?MlM3OEl1dll2bGpjLzNRTXhFUENxbnc5N2VRYStuNnlIUWN2ay9mRDZZd3Ri?=
 =?utf-8?B?d21Wdm5GcnpWYUdpOVJFOGNhejVnaVZLYnZNWG02TDlJRm82b3RVL0UxakNV?=
 =?utf-8?Q?3gnmOo9BN31lmG58J2S5KIk=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e4aa34-9ed2-464b-a0d7-08dc8a56df79
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6901.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 20:41:30.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL/m7YN3YSdLEvOtsglWsS1qywQNCyKP9niluxAX4NQYTdWZBVLvOKaYrQIzqElrfpWanxRh64NQXeKpoG1ELPyOR9XKUYECIhdb03kgAweyI2irusBxBcxx8IjJWgxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8021

We are adding support for a new adapter to the hfi1 driver. This new
adapter supports SR-IOV and we need a way to communicate between VFs and
PFO. There are some resources that need to be requested from the VFs and
some notifications needed from PF0 to the VFs. I am looking at using
virtqueues to allow a VF running in a VM to communicate with PF0 on the
host, but am not sure how virtio devices/drivers should be used for
this. Is there a general-purpose message-passing virtio device that can
be used for this? Or do we have to create a new device specifically for
our driver to use? Or is there some other communication mechanism that
is better suited for this?

Thanks,
Doug

External recipient
