Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91A2F39B4
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785653593; cv=fail; b=oGlFTWLqIxLqa9ZgBCGPDJpXWtwqBiRtpb6xL5EdvQhr+YH/1Xk3lxGGCcweCWzxvBHBfDms4z/rhdtquMEPzszrLGtQJf/yEwSqyAJVnES0jtjGbNFTyXJ6QeQ4u4NkL4mrAXevbTWAlt6lU7JrU2v9np660cSkDaaLLJcAiHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785653593; c=relaxed/simple;
	bh=LKBfhDNg9wxM5oZiq1Fpbep6naSisgnTAIQSmiTiXYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9ORwQMawGyvJhN9Wwf3mgEXYJduCTzX16G0woDA4QhRsZ7cOkZAhXfGHvQe5saRGdpqebRRfWouulKHJp8lqr7F+Mk9MiBax4t8Dj+YKcRjrzIcc+rwjc2rSUHzHJMaz9KgJ/wJ6hf4vHgj7qE5oAnM6LmQ9Mg3lJ9uH8lUm1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OD0KQmNN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ELdK3q0h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OD0KQmNN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ELdK3q0h"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6726jFpZ3947345;
	Sun, 2 Aug 2026 06:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/9RpXiHn8pB43eh+lJgMyc+v3PqnnybND4ScO1/gErg=; b=
	OD0KQmNNoMYEnwD/IB5zxb/aPCoM4++Cg04hhmSlfYyOEW3PYCOHjYsCREwVymiu
	m2y35DpgiL9XKexye1TziTTtO0+8EaAtJIfWh5IPatxCiR0a+Hez8ucNm77E7DhZ
	5jhVyyzLUuTb76fNFMkFlNXgfFy7kRQ0BZuFhdcVC08cjSxrCZ9pzzBNJxCc92IH
	yvMOWa0A/r+EnMDMJq70MulElnC8XxtK+SplAA7QiW39ESZeED94MMGFMr67sBm+
	RmIrL+d19QWRluGIRuoA5UTDuS/NsJEmqZ7yqRumi0TNwobnybt7xCf3wDXdH8HD
	50K63IaUnZF9LuGQPRHVmQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9bt2a33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Aug 2026 06:53:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6726odqI030136;
	Sun, 2 Aug 2026 06:53:08 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78qyfrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 02 Aug 2026 06:53:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fef6r6LwU9X7BU6eMKl5Ag0naFYKte5ZLUHNQaIJDOEWJxZjjdQCr/l092acGX5rd0ItOULa1MZr6sSkLMfRo8suFAnGHqBwpjHDzCPJYq3RDvhKCEhYUWb0VwitG2ZU23edCW2ZCW6yxe2q00CtX5mjTfwfSloPaVmYZxrdBKsxz6Rtt49LWOJIMueaxW010K03kjvGWklyVXWS6zZ5dg6QuWTouG2vo806d2NnQjaOKempBOXhndV0dcG5guuQbXimXPD4ptLrsiT1cGfm0dw/4NSIC7v7nJH1+SVKrckpfTkkXE9ULhES9xbVhPgBPxuNZ13bqj91xS+igMwk9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9RpXiHn8pB43eh+lJgMyc+v3PqnnybND4ScO1/gErg=;
 b=kvm15srm1hHZ/qRTY2PdH5qp5ZFEAXQ6pzeKg1OfJCb5y39krqGsXr2komk8ETVIBFSlcX9rGRCVgaeDNjlu8Azqa2cLeYOjD52AaBXr3SJHIdgyynCUDDmkgcuItjrRivCNZ8h+S/bbOve9q31CN4otouP6AKs5a+Yd3+KqVBE7Sojq6FZNS3lMC3LPMEGA/VgTa4Z/UX9/xh3sVOxtHiXRixcDB4YBJo8qmCfsAzDhENsyQjINZN4A+ZMK7MFZa8Yu4b7O91km8EoTYeomG9dk5uHre1zWUfxFTBn1nTpJuJpgqUgosey9wbSybsPRtgnivsnc36GbvpyhmOtyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9RpXiHn8pB43eh+lJgMyc+v3PqnnybND4ScO1/gErg=;
 b=ELdK3q0hbUBUScdcKfOvqjmNl0sv2+ewOmiYcWpqsJjMHqh1aPaQ/WZseu3iLQvYNqDo8hB1b21jhu2NvYv4cCnd/hyEDaldmHGrsrHvuWDqreBOwYoW2tBG9NeFUfCpfdWqVKPycgJWibDL5L9cCwREyHNGRwqUTewIDwGFtqc=
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by CY8PR10MB7289.namprd10.prod.outlook.com (2603:10b6:930:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 06:53:05 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 06:53:05 +0000
Message-ID: <c094464c-9432-4d21-a82c-80c6b8104198@oracle.com>
Date: Sat, 1 Aug 2026 23:53:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com,
        michael.christie@oracle.com, pbonzini@redhat.com, stefanha@redhat.com,
        eperezma@redhat.com, kvm@vger.kernel.org, joe.jin@oracle.com
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
 <20260731195756-mutt-send-email-mst@kernel.org>
 <d24ab42f-fa00-4a5c-b987-c05f6a9898f2@oracle.com>
 <20260801055436-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260801055436-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0060.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::16) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|CY8PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e93c13-c7f3-4920-661d-08def062b3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|3023799007|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	vPs80dBymftrqwThu8zQmO1SRt6A5dgq/MI9Jcpx1cKqSCQdn8ls5fdcHDRtZj/NJrqP5PAQtaMFGZRoOS0eJsbLvL0RoVPOtbldQ6rhliqtz1ugOHPCmX0Pbn7W95E0yscE5H6AP8FJZyvO0vT8MbCNTYhaFlPvG66H0P4PghOUtjB6AbRyxYnlJRk07bV3BD1cBBIGJGRAJnY4bhUHIKB9B71QD2qM/P6vvWr+fUozXHR3sC2g7Me+yX2zH/yNTZ6khe1Jw2fNbQoTEbce1jMWTq6Aj4dQWoqQp1QOjNKuI5DDKQj7yrE7TVG47VsKrn9j9mGs7w1EtfxF+9m7kIdyNWedqiVP8+5oPryrR28p2HZ2Wd3fYSx9UbDIfwDq5FBEPiTIIDnYAw86y25S/F/DBrZcmUv2K1AqxoOylB65gtmXETCNUKi6sX/gZyu2AwViDJkvZnF+hHaMl/Ph6u0II+vDs7gC9mVlKQvoABzVjIOZ+E8XHc9EKJ5jTMYc6bfjjsvo+OcbuynLouYmwCq57zLcndIjl4dJ/e+uE79/h6bDsLv7nHYrPJMefL0QlQM66cK32WX7KTV81p1gCIl29/K82U9m3sfsSnJGWY4dHN9cxKZf9EMI/MiQrjvT9kL+Ucs8EsGFEHAk2dADuCNjMPM9/yuAF/DsoVZzGn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5506.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVUreXhkblhPTGdwRlU5ZkZGUVcwb0JhY3dvUnk1QjBZcXhsTUswcFRORk9H?=
 =?utf-8?B?bWkyNklsbTJuWjBXYWhYTk9EcHZUV1VWZG1CUm43cGY2b1U1b3hKaExxb25D?=
 =?utf-8?B?Z0J0UjFKUUYyb3lINW5udUZNdmQrelZ0MzB6MVF3WTBNcVcxVWYrdDZWSW1P?=
 =?utf-8?B?QmwyenZldkVhWUZkWGtRd3dSSmpKalFGTXRoajRvNzROT2U4ODQ4Y0JVQ2FJ?=
 =?utf-8?B?YXIzeThrd1VlVzZKUTBhRHQ0aU1ZUW4rZzRWM3FKOW5BdWY5cFBnS2ZpNita?=
 =?utf-8?B?emQreWVEdjRSb3NvQzNQeEQyUlVHTXpCVU9td3pseEVhMktObWw4Q2ZHclM0?=
 =?utf-8?B?RDIrRjlaUkowU2xjZHd4TVNxRVY3S0VZYXlNNURCdVIxeU55VEZpbm4zV2R5?=
 =?utf-8?B?YkRIMmV6OWlzTlF0VUorMUJHYU1ta2dDQWNCUnkzUGs2Y0JDcUJVbGp1V3RH?=
 =?utf-8?B?V3pnRXZaQ1crc2tRSm5MUlRWRjhQQ1lTWVpIcU4ybk4za1hGMDUrTWo1Sjl2?=
 =?utf-8?B?b3kxUUorNllrUFo5akVZY0hJQlBlUUoxVzVXRllacWNYaUxLUFYvaElibU1Z?=
 =?utf-8?B?T2FFZkRuVERhRkxXQ3hudWZHQVVQV3ZiYmpIY2ZLbzFiVzdKeWVTK01RY21r?=
 =?utf-8?B?YXY0a2pTTUdKTHhONXlFS2VRSHMrckFFUnFydGw0V2NqNExoZi85alpIa09m?=
 =?utf-8?B?aVl1cFk0dmE2dGpSZlhFRmgyVy9Pc01nRWxwRUY1Z3EzSnhRWmliK0NpMnNt?=
 =?utf-8?B?dGJZS0JkemlteDRwZ2VMV0ROc0U5WVlBR1BiNm9IdEkzYlIzT2xCQktOMXZy?=
 =?utf-8?B?VzJlNXp4dVRlR1ZNb0F4WDlNd3dDMDYxN2VRZW9FNGFDTE9vdk9HV1B3bWlX?=
 =?utf-8?B?SmF5YmJGYm5ra3hSKzFmY0JJTVowYUthK0JXZkdHRkZTTEUvTllKNStEelk5?=
 =?utf-8?B?Z0VIcThQMjg3NUJMYXgvcVdHWUIzRkRobHZGaDFVSVFFdXJ0aXNOdjZHdDdQ?=
 =?utf-8?B?ZWlndDBXU0VlNVlwdkc4eCsxWFdKTmVwZk5FYk5pNlRkQzE2QllEMVo4QnNa?=
 =?utf-8?B?N21jQW5UTUdBcHRsZytnelpjVFlPSzV5dXFta3llTlhRWDdkbG54NEtkT0h2?=
 =?utf-8?B?S1pwZ0hIQ2IrTnVLS3QvaWErM1ZxM1kvdkNLWWtPZDhVWTI3Q1gzMG93WWo5?=
 =?utf-8?B?R1dCMG8rbHk3VzkxOFByZUM3UEVPYUZUVXVzajlMUVV0Rk1RaStIZ0E1eFFa?=
 =?utf-8?B?V0ZvUzdXSllJbGlyU21wYVJWNlhuREQ3dUlBWlZ1Z2NKVU1uMk9RcEQzYllH?=
 =?utf-8?B?d3RYYXo0L3VwMVd4blFsNTFQUHlwL282SXhTNjI3Tk1xcXhsSzJDUGMvd0tu?=
 =?utf-8?B?Y1h3VFZBK0JvUmJ4clRXUTlpS2JjZTd4U1J1WXRHR2kycWFtZExwdGtYNVlz?=
 =?utf-8?B?clgrY0FJZ1loaXVySXg3dnA4L0JHUUg4ZElQbWJoQTNjcHFrWVNpMTJSWmFU?=
 =?utf-8?B?WUsvK0czT0duZjdMcHdtaUwrdy9pUnFZZWM4MnNPdkFvVDRZc3VRcStod1RX?=
 =?utf-8?B?RThmMTZWWVk3VFZaOTBXNWIwZFZMUWMvbHFrYVR4S2orbzFLYk9zWHpJU0hF?=
 =?utf-8?B?d2lMeVV6SzN4NFBkNE5PQVpyYUNjUFBtOGg3Rm83bTU5YVpUWE5iUGo1VTMx?=
 =?utf-8?B?aFNMTHVuNTFiam1yYUJTSXVQTklVUG1JaXZqTXJjQ1NvcjRIRVhEZU9qTU9t?=
 =?utf-8?B?bk5zdlRBZFI5ckdHcnNOUmR0Mmx0ZXRPemVPUFRLQ0pHU1k0bXdxSUZnaHg3?=
 =?utf-8?B?akdCS2w3Y1Vvdk42QTJrQktUQkptc2taWXhFSEdsL2lYYno2Z1Y0T3QxZVE5?=
 =?utf-8?B?bERzdjA4MXJDTkgvdEd6ZkxtTG1tODc5d1dVYkVnV1RlOUROZkZFN1l2eHlK?=
 =?utf-8?B?Tzh4RnRRdVpEU3U1SUo2NVZBb0o0Q0UrUWlPN0ZoQ0N3RlRHODU5U1E1Tlps?=
 =?utf-8?B?NlNrenpCbkZYNGt3ZE5EUjc4ZmNCbTUyUzZyZUlpcHBSd2ZrTDBweWZvQVJP?=
 =?utf-8?B?anVEbVZBckF1UXhlNXYzZzF3VTBDU25zODhrVHU1NDV6R2lnbXBtN1B1Zncx?=
 =?utf-8?B?eG5QMHdObnl2YlVvSmJVMmsyWnhHdmdDSnU0YTBYNDZ0dGlveVd1d0Y4ZEd2?=
 =?utf-8?B?NXNnQnVEZ090Vml6Sk13TVFEcnp5Y1ZpaDZoU2JSSVplK2cyYmgxOXN2Lyta?=
 =?utf-8?B?TVFCd2VLRUJuZG5Yeld4LzVLU2tTdVZ3ZFVuRFh2Rk0xREdqOXJkSTZVOE9D?=
 =?utf-8?B?TXFJK1JReUJXSXd3Z2JVVnBnM0ZCOW5VTDB6RU1zTHNENE9VT0luQ1prWlB1?=
 =?utf-8?Q?iQUDoYLaes/wc0o8=3D?=
X-Exchange-RoutingPolicyChecked:
	H7/7e6Kn9pTcZgKC3wSj+HuB0ZjUDBSYOtvV+NfaOpVRyTxn8WvogeK6useT8OIs7rszUAQcmUJepRIjGAI7hh1uPssL96OOfkFCRDkhrf8dNV778mCAcY5z10jqk6yASpsZhsfhd2b3GjXaizXXH54Vo8kJenf6xbN++UrZGtpdPUSJir+8ozevbCzClb4Eknu/aX7AMmgyBTNj9ksbh4nc0Sx7Hq6JUnvLrJCA3JNu+VclVdTASJjciyeYwE6l4Ws8sjBJfE27ORcuB4/P1rouiBKYM2O8Lx6/iO9dqpanokSyTUOazT3qZEmdKMm8M6R8tTfVi1a3DZt03rBDfw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X6n/05YbP0tbWOdZP41Fj4i+N+c4mEYANK038vcgbBC4jwSzF5TyDUUzO8/gLq2FNCEwST/2tJZIuVMF7LzzKZU10fF2LqdM8qJOhmaweGD/UE8knInGQ0QlYret96yyyCpZDUkEx3PJdsL+93GAZbn9olpYZucVIjLjJxFmOsEWph43WVRgKMwM35fvpsqs8oUrfjw3/5VTHr2OiDM0NWjgDSH08VePBYheJlnLUCV5iBIaI0EWc+hgHNjgZXTVIzofjs96RQZzAc4PnPeIQ6wW+UWCcd9d6/xElTlje4y39v7lQT9SW6d2bGYXOAOLicPB8BFJ/RdCHiu6ZOUpg1mLJiMqp+JfRKw/MovTuyAy7CIYl9OoaX84iUVNzR3JVXt2XhPRhv9+vAAdD8BqmcSjMjktzwxCHM1u3hwIN6ZxVENQoj43GRTa6pvyjimvIm+cpv5nYk9483blsz+BVwrb/23EYDImmXIgsS1tbGr51tVq41FPzKUnamZbM8N3RjmsLvwZaZBw/WBvLqvPOd2qmWdJa4ksCdemEzlexrbL+E/7ukEkUMLg3Th5kZWUiZTf3ykGOgJUd3/zR9gvmB0IKbFaA5IG9wp/jWoXZKU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e93c13-c7f3-4920-661d-08def062b3d1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 06:53:05.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppWQ0TZjViZFDSYAvddV4AaK2y27lTyiPKdVZGj2SA0f3zw9OSfZbcjhSPztzbzbwXzYV2cseoz86tHdcyAdng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7289
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608020053
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MyBTYWx0ZWRfXy7GeDBn/zTyv
 GgzLyi4GGFvF35/ZC3rps+J+Q0IWQLqJoGMbyYek2vHVQyfTqLpnrSWemEw9sjW+9jKQtqDOupX
 bG0f55KPU+LsDDl7paUPWJ4qAjUgaLFOIt2kWhCTXvoddnTvyDC/Wy3M51TrxT16taVNmVPEXSm
 v0ZlCLyWhYcFJkuk6nA8PiJcgjtldumPhFq+yesLxT0V4AFmOVLs1w6Sepw1tIhjTTmMpe6Ig4a
 Q2JKbBj9ngbPU7VvYch5daIVNQDjSk5dYsOxxZZbmHLtx1ZjyGzQgk0JdiOalgJsj5nPMzpP9ND
 Ra9WXvjmcOrse6xpRhxk8yUP6bL4XtmOjZWBKOVQb6XngCc3DoWmwyYLjv1YSc5fAYcT7pENP9H
 6m0XsQyl5OgrFjve7gzGfCTxXNZaqE+rWuGelXLat5b/to4glplO4onXKssUGsQ6W2P5Il+J8om
 d7FWM8JK8porpb/Ar5CkWO56tSZKtIxXU6gvLnHA=
X-Proofpoint-ORIG-GUID: RgwPfkRVaJGvzoPIJboLMYmtl-OD1Wds
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MyBTYWx0ZWRfX+Bo7/X2gn7kc
 brIzMq5ZfSz/lb5FqSQ5Q9rL3HH4EAbTpgZB+oe7TYh9+bFlAJnI1e2jr+UaXe+QNPcEP9QB1Fs
 xKA2CPN0xBdHXswHOG4gOl1bAmoTKDUiwss13err1ySCrDibLlqe
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a6ee955 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=V0EXK-iDosqfpCNVMv8A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: RgwPfkRVaJGvzoPIJboLMYmtl-OD1Wds



On 2026-08-01 2:55 AM, Michael S. Tsirkin wrote:
> 
> On Fri, Jul 31, 2026 at 11:59:21PM -0700, Dongli Zhang wrote:
>> 
>> 
>> On 2026-07-31 5:00 PM, Michael S. Tsirkin wrote:
>> > On Fri, Jul 31, 2026 at 03:10:24PM -0700, Dongli Zhang wrote:
>> >> max_io_vqs is currently validated only when a vhost-scsi device is opened.
>> >> This allows sysfs to show values larger than the driver will actually use,
>> >> e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
>> >> VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
>> >> will actually be used.
>> >> 
>> >> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
>> >> 
>> >> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
>> >> 2048
>> >> 
>> >> [  315.630495] Invalid max_io_vqs of 2048. Using 1024.
>> >> 
>> >> Use a module parameter callback to reject out-of-range updates when the
>> >> parameter is written. This keeps the visible parameter value consistent
>> >> with the effective queue limit.
>> >> 
>> >> With the parameter value kept in range, remove the duplicate validation
>> >> from vhost_scsi_open().
>> >> 
>> >> Invalid values now fail with -EINVAL at write/load time instead of being
>> >> accepted and silently adjusted later when the device is opened.
>> >> 
>> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> > 
>> > why should we change userspace visible behaviour now?
>> > 
>> 
>> Everything started with PATCH 1/1.
>> 
>> The original purpose was to resolve the memory allocation failure addressed by
>> PATCH 1/1.
>> 
>> To validate the bugfix, I increased max_io_vqs to see what would happen.
>> 
>> To my surprise, I was able to increase max_io_vqs to 2048 even though
>> VHOST_SCSI_MAX_IO_VQ is 1024.
>> 
>> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
>> 
>> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
>> 2048
>> 
>> However, a value of 2048 does not work when creating a guest VM with vhost-scsi
>> because vhost_scsi_open() fails.
>> 
>> This behavior is quite confusing.
>> 
>> Therefore, PATCH 2/2 was proposed to avoid confusing users. If 2048 is an
>> invalid value, then setting max_io_vqs to 2048 should fail explicitly.
>> 
>> Is this really a "userspace-visible behavior change"? Without PATCH 1/1,
>> increasing the default value to 256 could already fail because of memory
>> allocation. Perhaps this is a good opportunity to define the expected behavior
>> of max_io_vqs before more users start increasing its value.
>> 
>> This also makes the behavior of max_io_vqs consistent with inline_sg_cnt. For
>> module parameters, it may be better to perform sanity checks when the parameter
>> is configured rather than at runtime.
>> 
>> Thank you very much!
>> 
>> Dongli Zhang
> 
> 
> There's no telling if someone had a large value configured and now the
> module will start failing for them. I can accept making the read return
> the actual value, if that helps.
> 

I am not sure whether there is already any usage of max_io_vqs values greater
than 1024. In my testing, with the other parameters left at their default
values, even increasing max_io_vqs to 256 can hit a memory allocation failure
with the current kmalloc-based vq array allocation.

I will not reject out-of-range values in v2. Instead, the setter will accept
them, clamp to the supported range, and store the effective value, so reading
max_io_vqs returns what vhost-scsi will actually use.

Thank you very much!

Dongli Zhang
