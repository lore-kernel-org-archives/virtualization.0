Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97050A62
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674633; cv=fail; b=KJ1wuxVBEyCFIpOOInDw7yljBekXOIUNVTS/q+/3qy+Te5BkqGZUs5Tucx55sFIhq48mmwjRapS70KSO1aYzy/b/hmrlrbCgqSJMpRwz+knVd81Uv93TH1WeNC/MbNjVTFPX19INQTt1b/Duz+M4Dr3+Zhw++bz/Y7OhI6UA80c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674633; c=relaxed/simple;
	bh=GFimIr3nRgiNry0ORcp0YkV9nREkZx2043r6U8TPNMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pg2A60Q8UQxUNFJHVu/J9NNaWlo2gG9JPgH6nWpYIIdhS3azGtCRvEstr7J4qpxFi+S83x+XI7waJ3lR7cpXZrrzE/klQ9AlbK9msyeJBVW49Uo3CbhmifqrnHqP4VTOKoK9GEl1HaO4EQx8ay/uNrwkYGOsu7yJDwIjNgqtOhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FXxTent/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=olXha2hK; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FXxTent/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="olXha2hK"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F369E82013
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 14:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpjGA7elH2GY for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 14:57:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D63D481F00
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D63D481F00
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=FXxTent/;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=olXha2hK
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D63D481F00
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 14:57:08 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BYULm005163;
	Tue, 9 Apr 2024 14:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vAM2e02+FUKCtPDBpEf+LEa7qTOZbKjGwV17uhMCvck=;
 b=FXxTent/JUic7m3W0Jw0HZT+HKTXIdDxyqY6X0xjpMkCA26InmQhjp51YeGRXuQM7FbC
 D/d7ANe0kvPPCD0DqhqqgzgVuuixphboIvcSJq4TgAuxYz9kjaaYHkWqOiyR+ia4zhxY
 ruD7lIcJETpQsMf9YgQZm85D6yBMNhCUumwJWQy/giJT1EphFiHO72e/IIRdxRNovlrm
 vSRaIc77Xopg+r+ylDtq6pykRrZMnr/q7xao/oUr3L67gwlf+BlUB3wl+XtFlTnDPEHF
 VCxot06WWEYnYlM72/KPh0ZIuNlH8uwWKK1wvUQSRmPzcH+E/Z1QG6LAajwntiryDFhW qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0257tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:57:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DomSP007942;
	Tue, 9 Apr 2024 14:57:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu6uc95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 14:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JymygyrvianG2+axXo3oxr/BLgEdkDvrTBDg7ibP3txGQRfpuE+jUtbhsXzXYK0rymMByU+PMNoHr6PBGjIIQUmMweoQ6tC9uLxZF3vwfs2Xs2PyEWuPa0mIEB9bQ3I1uJOHJW2vsH3ZtEw290bZMz5e6/0JjOTJOxR6WB7Xj13HHuYBsbmSVao+8xKHd/y/8C6W9k18pTgEnBZrtlZyFPwQ9uGmhUGFR711eDi/5RFwsJPlN+DS9fVndY2MlgdOdX5TyIo9/FJkEEm7QnwykfsY0cPIAs9qnLV+6WLJCd12IX3ygz0bEEhX4DUoEwgllhsa/ZctnLvs387CUPAp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAM2e02+FUKCtPDBpEf+LEa7qTOZbKjGwV17uhMCvck=;
 b=n47wjoDwv5uIOB/4xJcjzLUGQK6UkMPHO9vDUb/C6tSWKM/ZmL5T+WgnwdSsoS+9oHXCSXpwh+saarUIoaJ78FqG2O/XsQvuperebNRB5//jFDHQuxEefVl6y/kbKLE6HvxHUBseSObxkzKFs4Fw5tKJGhdVtphQC6YtIwMa5H2WvEteyoTH1WkbpNs2bYermmB3a7/EQshTdyts8liVU+udVNWSQXY6jWwS9So6mcRQYR4ZeEHI83doDGd8VZ/0AvPRNXy+ugOnELeudYiUT5iUP+LtsiMUNOg52M2om2B15jdB3wK9n4+jppdL11sSfNlxKFi8fWK6yvXOdmCaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAM2e02+FUKCtPDBpEf+LEa7qTOZbKjGwV17uhMCvck=;
 b=olXha2hKd1/fOgaDwLF9O09xMRdoUpCZoUa+jsMn8dO7pla0IY0MX3OGdAZusdDtdausFzDzz0BffYp/9ZP8Qz71IB+3Ky0AwswD5ezFnpuyyfImQ+upvZY0kcJ73NbgIesV+LHo1RdbERC4WaMhz3TkbHK35awL/z03wsk3AjQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 14:57:02 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:57:02 +0000
Message-ID: <7044bd8c-99a9-4da8-a5ab-c2c293cdea40@oracle.com>
Date: Tue, 9 Apr 2024 09:57:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Jason Wang <jasowang@redhat.com>
Cc: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
        Laurent Vivier <lvivier@redhat.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEszFm3LZ4Xf41nnPHrsk4xzUPW-7HZf0xAgoxW9D2Sm-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:5a::39) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yEGsg9za1EmxHw9TFsB3TpazSGcINlNBK4ryACKN/w+NLONkpE8rEp+BSgamSnTVWKTPfGi7M1UP8483wn1vJGgOtWZMoEaLuBg4NPlPpScXm5sGPXHvHkhzpwQ1posg/wF7opQZfhY4B2WXWi6BvxeJF+2gZQzXANs8U7Oa02gzUaZctnkRoo/spzYn7jjsZ4Xf+WofQxteptth9HwOzfbntyAZaJe1rCtl5FFd4sIKIDvCikpLJS1v4bNdgiPdGRJrOqzZ3V+NuKEiSRBUz0l4MCsRhRzD4exWc2WpBBHa09Mfd+KQZFTM/gFO92zur71qPwaInC259WdpMZ23sBnc/9RSpvAs7puU8Xgywj0lDsuAeVZcnadvMlWGlE1UojUOtDA0/+jgpEtt89Q4XVyF6TCerQL34Mfw96JYBYzQjTalLHAf+Ld5hvHz4Gs2yo3k41TuBvMMQBUrnKSdqW+wx99IJ9P/kVPVsV8TRJDByUErCwhlhviePJH8RQxH+sjFT8KYv1VlGiYRWLVlCkW6RgqvDrCROxLIX09MlPa/+DBxmULmuGb3r63iz2Bby0EWv80sR8/SGoSSlLXRZKqiIJobihRfAQHTvQPIBtPmdNEyXbFHwpfyOGuOgPtvdjg6j6sa3AP56Z1vdBeomSCIm7LsejssWCFALFbhvg0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGkxWmlSaU1hcnpxc0pyQkF5QVhDNnc0UzlIbjdZY1JBckRBSmpxUCsrSXQw?=
 =?utf-8?B?cmlPQ1ZWTk1UNVE5aHZ0d3hndDNQeUFCVGVRWmxiZHNkQW9kU2NORitkR2Ew?=
 =?utf-8?B?Z1FvclZSMkN5VTNTTmpNTk94dEpiWVgzeEJkS1ZwS0s2YUJrQ1JMOXgwb0xl?=
 =?utf-8?B?Y1pEeVVRbCs3NzdmSzRQWHJ4eVJTYWdQNjBQSCt5bGJ5RW5PRkpyeDc5SjBV?=
 =?utf-8?B?VENSbThZTXp3dVJsK2N0VWVxcm1kTEZsVHNQT25uS0cwRXdVRW1hRTBjZFcv?=
 =?utf-8?B?UndnVEJVVDVjR2h5WkZtakNPR0FVRDBNRmVON2Z2RVdOQk1GbVc3SExBLzZO?=
 =?utf-8?B?bjlIKzJJV2JoeDR0RDdzNlNzb0pQTCtKOEh5QjhlVjFXdzRUN0FDbHp5UVE3?=
 =?utf-8?B?ZXRmQzlrQ2RSREJ6WUtCMFovRWdmYWVqcW00WFlETmFiYS9jcnlUY0taT0wv?=
 =?utf-8?B?V2xob3JtWFFJajM1a0NXSS9TVUVwNzVCeTc0dmlxcm5VcGZsenYxeHRZNUlJ?=
 =?utf-8?B?N25SWjJybFZGdG5DQ0dCL2VrMCtlZ2F5TTZlUXQzZU5qRGIyK3JWbVFJUzlW?=
 =?utf-8?B?MDIrMCt3ZStvYmp1eXBXcUxURnNCNEN0b09nVUNsYW8rd2x6M3Fnd3l3cGFp?=
 =?utf-8?B?a2lPQUlNNld5M0pjVk1aN3BJblhTQlB4OWNQa2FxQXE5M2F2UWFJNURjN0po?=
 =?utf-8?B?alJQdi9uL0JiclVwUC9waHlLcU5FY2Z1ZWR2N1JlYS9uSWVBRnIwZW5lckVT?=
 =?utf-8?B?Tis5dUxybjNVZHpBWWRJRDhqWjlHRzFBaHRTbTJPZk0wWnphREs5QWZNcE9y?=
 =?utf-8?B?MTdRVEo2TWQ5NHB3UlF3OUhUUm5HbDNnUEZrMFpFRHlsM3dZT0IvQzNmU0o4?=
 =?utf-8?B?aFJkbW43bFhTQWdGZ1dvRXpwdlRrdW1ub0hsWDNpa2RKVlBaT01xU0F0ajhO?=
 =?utf-8?B?QUdTTFpDa09aR3ppL0VQRE9PeFpSKzYwYlRUWkVuTWxpeUkwaVV2djliYWVN?=
 =?utf-8?B?VE1uOHBnOTE3T3pHeEFkY3BLbnRTSkZLOFV0VVVYbmJWNFRabUtlWnBqeGFn?=
 =?utf-8?B?ZHBUWEgzTlJrWVZrQzlzbUNaTk9SKzZmU3JDQisrd0RCYkRNaE9HeURKOEhs?=
 =?utf-8?B?anNTTW03N1dtSytXSFdUTHJNYURiaE1sNnNkTFVzaXV0YnAxRGw2K3lwL2VW?=
 =?utf-8?B?V1d2YXBSRkRYWE00YzV6Q2NaZEdHMTFPMmdLdGFUYS9oLzV5eXJYcEx0cVBt?=
 =?utf-8?B?c3V5dHMrdmhXbjZhMkNPVlNFeUNTL3NmdG1DVE9KS3dXZzJIS0tNZXZTeHFT?=
 =?utf-8?B?UlRtTGNGbEh2bEFWQXZhbFNhMzdkS1dGcmRxUnZBL2NEYTFvMUcyRCtCWDNt?=
 =?utf-8?B?SGMxdXQrYldyc240MGhNL1dKa2VmN2N3WWtMcmk1VTF4TGRscVc1c1JicUsx?=
 =?utf-8?B?SEhsb21sbXdmeWEydjZOblFqYmlNUWFGN2lvR3RlVmdVV29RQ3pwUXNaSktI?=
 =?utf-8?B?WW5uSS83aHpFKy9vdFRTK1FDc1g0VUlyZkllV1pHSlh1aTN3TzRIQnlZYmpN?=
 =?utf-8?B?MFRST1h4L2JIM21kOGthYkFpZmw4R0M5MnpnSmkzZUpKcy9hb3RHT091Q3k1?=
 =?utf-8?B?L084elJBMkxxWjB1NWhFdjQ2d0lSa0d2bDZJbTlmKzFCTlFWbHJSUjZiVExN?=
 =?utf-8?B?cFl3QkwwaTFIU1UxZGFUQStnT1RmcDd2WE5jeVQ1dUl2U3dTMVFkdWVocG52?=
 =?utf-8?B?alg2ZHpFRmhsOEViMlJkMi9MZElRc1hRTzRHeTVWVllBNHJ6cDVaY3N2cnFn?=
 =?utf-8?B?NWNDWURtMkpQSTFuN2FVTDRZTldtcDFxYTBOaEI5aHhJWVRWV2NhTzFkVXZ2?=
 =?utf-8?B?bTExenVZTDVRREhJQnFUWitRMnRhdGhHNGhvSFk3dHYvbUQwVlozUS90R2FZ?=
 =?utf-8?B?TnQ3dkZ4dTMzTFJ1VDMySWRrMEQzcVdXTnBBSkc2akl2d01RTG9tbm5mMHky?=
 =?utf-8?B?eXNvaitycTc5Rkp5SW93VTk2eWxsMTE3UENLMTFqd1lzMkRPV1UwSmZCcDhH?=
 =?utf-8?B?YjF0emM0OEVHa213LzNGaTFjRTgvUmZmKzFoOElYc1JwQUpYbjlXTlV0TGVa?=
 =?utf-8?B?QmlZaDJtVG4yd3VkSjVqb2Q1eGgwdnZDdFpqamxtOTd5TkU4WndkMnZBWFAr?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8XpIq8ztoDcuNHiJSpmAg8BQ9r6lySHF9fbYi41GeztN/YOlzXgjvtIj9qMj7mckdUzlrg/AdkOcvNpzi2MKg4j906/lIWFajIcWVAgZADVScvFn6l7GbRQrfLRcHu97TzYZU0KbLp3E068NKlnNihZd30BChw9xawqzNuwWdyL32GzQsyvgJjVRBZRIAC7p/rTIRKuHWbo/0fZhMw7FuTIopE8rH8hYb2aD7fRa6UZoZx2D+IMYH6VEg3ZlUyT4aacZm0gxd+g1ndKnFwb3lGbcnguU4EdJ7G9F1wN+ag4xbOXQktE+mJ3ScaSF6XvgH1I4A/rWgVc6w750Ud4ETu6CHpjtF+elLVep/YgEYo/o7cCQNLE7Mvtn6IIy6qwYUM8a02GkTT+xXntMtqujJbmXag+5YvMdpnsIbWB/1NIuAl8f4eP9Vd2yvrJW2cqguEoX6T1ZhKGnbcp8xZHPQ+zbfsyqP8syA4mdF8g1FQ28BxrF3Ql6QlG/lNm6YzML7dttnLm0zXXNc7w0CMLuDI6QM9ie5SD3MsEFGziF8aD4TpK/2shRn+WPjMqI6N+Dt8UyEy+AueF67g4V7rTu0NuXoa3ovN+22WY7kHWia4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a938dd4f-9044-4f3a-38f4-08dc58a55064
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:57:02.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpyG3B+hPBvlKZRgYlWrb823MTGwphZJ1K4166pGJgKQcB7vu1NC+rVS5dz4DdZR2jm6UhlwdDmLl7eROIWUIvHt8+TqGXjOl32VzCU9VJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=861 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090097
X-Proofpoint-ORIG-GUID: cF4iCGgyjH-EzbqL5exdgwhkgDacGsvf
X-Proofpoint-GUID: cF4iCGgyjH-EzbqL5exdgwhkgDacGsvf

On 4/8/24 11:16 PM, Jason Wang wrote:
>> It turns out only vhost-scsi had an issue where it would send a command
>> to the block/LIO layer, wait for a response and then process in the vhost
>> task.
> Vhost-net TX zerocopy code did the same:
> 
> It sends zerocopy packets to the under layer and waits for the
> underlayer. When the DMA is completed, vhost_zerocopy_callback will be
> called to schedule vq work for used ring updating.

I think it might be slightly different and vhost-net is ok.

Above I meant, vhost-scsi would do the equivalent of:

vhost_zerocopy_callback ->  vhost_net_ubuf_put

from vhost_task/thread.

For vhost-net then, if we get an early exit via a signal the patches will flush
queued works and prevent new ones from being queued. vhost_net_release will run
due to the process/thread exit code releasing it's refcounts on the device.

vhost_net_release will then do:

vhost_net_flush -> vhost_net_ubuf_put_and_wait

and wait for vhost_zerocopy_callback -> vhost_net_ubuf_put calls.

For vhost-scsi we would hang. We would do our equivalent of vhost_net_ubuf_put
from the vhost task/thread. So, when our release function, vhost_scsi_release,
is called we will also do a similar wait. However, because the task/thread is
killed, we will hang there since the "put" will never be done.
