Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795488474;
	b=qTAT3IPzoBOBOCD38lj5BC3HziJUZ7jI1uyPgcldxr8EH56dEEOFRBLH/ZYnylViMnxv
	 /nYmICMcb/MTDINElpX/t/0ClrcfiOnL2zeoe2inYFigbLu3xfFADnKgghUinNNG/75t2
	 sWzZ/zTqbh2uhdT8txqwTlVuB+wpgPmmIjoOkU2nE6e0ESbW7lpqvkrhWDHZ0sQzmJn1M
	 C1IAZBotX3swyp/or+4V9qNFw5JRj4/8QtECIq3CQW234uKPpK5HBuuPbH04FxKINx81W
	 qwccdTINj5qdsC9+QXgirecH8hAJ4L9I06biqGqwlaHnxujC4dui/qRCflq321mz/Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488474;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qnfBNf4BQ1+7cBAE3/HSb9J+OiqbfMuy9oJqwAUA/Nw=;
	b=PBDibuvtfpatJP7xfrsoqEGFJvN1PQ0pqi3Koj3pdT0QjxdUFbYI+k/GhTpZldEKCg7o
	 D2JAWZbx+3G8kQzcV+xgfTAQzZGSWJOtGPcl3TlgOmWGe6shoE068L/a+Evt7r/MJhkZI
	 GVE/GDC+v4L3QbI8YkbXgJaaWMdXCvd5JHiusTQtGS+g+svXjEkcfh2mQh/udEd16wnXK
	 C+/9j3j5i3RaNT6Ntih+cTe/VAMIkB9UqRAj97PlKah5qJIiffttFbiw6zyCoYNVTMa67
	 B9gsWPnvCW6AM4M99j70A4uy154SDEEbE8ExPGYYYe+aOAulw6MWR+o2V1Sa5u78aag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=TTWnT54c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.31
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011031.outbound.protection.outlook.com [52.103.43.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCD606A32A
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 02:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EADCD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=TTWnT54c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft9cpijhMm/Ghru33uKbtkbZ/B3xzuqtLnjLbmixCrqqyb9qC5PIC1Z9bSI3GhQoMMYAFvzEwdCc7BrcoZfkWWDqgmcE91Z6fDrcqfsOiRL/p9NjmXcB/iLM5Et6+nSfwLNT8J2/GzW6KMwd45N1QZvFJkQZaMGiXsF1wn8La5AUldg6uYcRyJkQ89WcZ7Ns8oObC5YrrQtlImSDcgwqBepQiMcbC1FJjidIaLxnLqXglba7366Zm0Bs5+v35mkBfpLUQOYy8IRp1vx6JvPkPA+LUfebp0wYvjrMjCMvHKlElRinj/H33yArpGdmsSu3v1npW2yroI0fFYFl7v0xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnfBNf4BQ1+7cBAE3/HSb9J+OiqbfMuy9oJqwAUA/Nw=;
 b=cu7K1Vcz2Z1Lr43MFBweeXzVAr8jpxUumlTwWJzmOgi/cII9EarGpHewR4qDffoHFxBODgSTaZBIP5Ak7xtb4m5u26CCPltT8LO0Cc+FdVlKg1U+yHhHVicJkQwyzHBHCgYXwCClTJB6+70TXCxG+fI3pT5POs+D+61E8zuZFak2P4ES8UA1+bTVybLLhrciTlz6W1v9TSlSvPkjUuDhc4MOZ+PGK1GV/7e++mYpGmh03tUn9vtnx4moC6gMJHlXc2MMk2aNtIYriH2jqkSFTCbxcLVuGFZFZFVqefU08Pgk7P14On7HDQNeL0OFcIAeHlqYmRb9+xnpPB6CDUmoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnfBNf4BQ1+7cBAE3/HSb9J+OiqbfMuy9oJqwAUA/Nw=;
 b=TTWnT54c11qjIJX2J1avxqHrgEjB/8OgRAkzGvBfYFvuO1A4Gd4lRz60bFBEt0x9XpQB8DKSW8yF1Ymvk3zBgscRZZUj1vVHy3kjCefBse37QvsSIfrsDPm+5DkDakq9OKTPVshlygpxuruKmCd3eLbqSPOMz83J3U7JbUv+BXr9dIfdMvcrBZVwr2d8xuSGOwyBlIy6YL5pLSnDWT8JZFPzjpLNkAgiJamD1C/AecLG6gZa5Z09w5TE1bA8rXqbRfY+QjKO1rQxGCBlIbIZai6OtLQ2fsdWHrgpxbjYrvtrPGDvChNxIJ2jXKkA/vhI2xY3hBWB64O0SQeE5N90+w==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OSOPR01MB326018.jpnprd01.prod.outlook.com (2603:1096:604:51a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 02:47:48 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:47:48 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH] virtio_console: drop device reference when DMA allocation
	 fails
Message-ID:
 <OS3PR01MB1025140B2F87FABEE5871E39AE7442@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Ziheng Wei" <zihengw03@163.com>
Cc: "Amit Shah" <amit@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>, 
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261123102321.8605-1-zihengw03@163.com>
References: <20261123102321.8605-1-zihengw03@163.com>
Date: Tue, 24 Nov 2026 02:47:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <93fab331-7679-4150-8e7e-3d14a4a47490@milk.local>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OSOPR01MB326018:EE_
X-MS-Office365-Filtering-Correlation-Id: aeba9c69-3d12-4a18-332a-08df49d55305
X-MS-Exchange-SLBlob-MailProps:
	5fu/r660v9Mj6U6kz+12O9pZy2TuKGHDY7pKN4DHaSXnZTc1+T8LgiESRmLUy7Z42Yz8GYDKPRdz8FSDhhdfw7sHeRfC4HQ0Na+FXys5iU3XpTFDGfm7RCUr+wWC/3W0s5o+I0f21OOM1YPCv0oWNzcpIQSXMmCU0bXYWLQPAvKGU4vq8dYpyN/N6ri0pvUewjO85tSJnLUoDTp/EWsofSWJfnjhmsRSSEMzQahlVUSVWeGqHNxZaOLwNmlvdpwLOO11lSYtjEBJuKHMjUNg478lVt+xV+j0oy7tFzIonRdaJ/pIaW2A5CqUe7AbN+7Ra9AwbY/wVoDFpTqD9eLhce0AY63BrtW0HjXJG5hIv2kiT9yqE61LozbJmJ8TwM/7LxCQTPcMfFi35OmgIaw3lpOsGUIBflpdnASJZxKnmx7C3BZyq9WvebS0CRxvztBknOm1nJ5ZxxGlUDKrQ8JafEBSDH134JteEaNdwNT4qqcevhMP1Fw9uMYmUqUWjyt73ZLhRhyKl2GJHSOEmHuN4e6ZF6BBk/IA2s3LPLJ4yzCR4Ge4yH12E6NB4phj5rVFr+F08E7tNcko9V59HqfbXeZrPWSkwtI9BodAQL8F2N+crE8CXDxWMYtCRQ5btDWb72RabSm5QDw8Tqp0Ov1r6cFapiMxYPfHRS+qljS/+jx59xbZtlBZSOvUeZI0O6vOsBypmPTPTbNKIEB73eHxTiUBb6WwIYafET6RmGs37Ys=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|4140399003|24021099003|6090799003|15080799012|5072599009|55001999006|22091999003|25031999004|24121999003|23021999003|16041099003|19110799012|8060799015|1602099012|10035399007|40105399003|53005399003|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEJIWTJTSXNpMTRMT0ZCM2Nmc0R2eUhiSlZxS29yemZmQzlodWVJZzZSQk9U?=
 =?utf-8?B?M2paWGhqcDJHa282MlVqdDdMYmhwd1pZSXNYRXFvWkp2Z0ZBVHI4YTBQMWpq?=
 =?utf-8?B?cGJuZm04aHFqZzYyTlMrUjBKWjFvbmloZ2x2S3pTZVhIYXd6dWE2M0lOcGRj?=
 =?utf-8?B?bmMyVXJKQThKRHhrMitXUWR6V0dGaEdER0x6Uk1pTTlyd0hSR0wreG9IYUJp?=
 =?utf-8?B?aWY5OXpiUkNFeUl1WWJTTkZkQ3ZPZFljWnIvV2Q0S21ZUTdpQlN6YTVFRmdV?=
 =?utf-8?B?cWF1UDM4UEJyVVR2VTRNUThkZlowc1pWd2JsK3Zjd3V3S0lTbkFuNllEQlFp?=
 =?utf-8?B?VXdxOHl5NDhmcWl2VDFuUWFUY1hCbU5odWNkNXVibTFmRUx4RkdPdFc5dEpE?=
 =?utf-8?B?OG9GUk9kQzVRSDQwVUNVQUNGN0ZtSmdicGhKbVhLdmovQ21BaDd4T1Fxb1hT?=
 =?utf-8?B?T0xsZTlsT0M2WjhvVFR3UU1aOUlBRXZpMlNweGNxKzVSSkpEMjNYeC9YbWg5?=
 =?utf-8?B?M1BZbkVYbHJWMFAwVndpUTRPbU9LSE1VNHZNVktXc29JU0FqT3FCa3hHZFZM?=
 =?utf-8?B?anRJSWdMYVptN2pIQnZnTDRrb2FNMjlNd0o2YlF1MHlsMnFDWXJCU3dhTW43?=
 =?utf-8?B?TXdBblZEY29sVU15YWJHTGU0NjVpVnpoQzVYV2R3d0VXbDh5blBkL3BQRFVD?=
 =?utf-8?B?L1BhZzhOY0xib2lENTBQdE5VYy9zSWNTZE1tODY3RnpFK1B6cGs0K05DdWJR?=
 =?utf-8?B?a3RucHhmWm1ZVzZYZ2dxNVdEZkFpalBwaE8velY2QUlmVENONHJHam9DQi9x?=
 =?utf-8?B?aVpRTGtjcExWckFZdllBamUzaTJtdko1VUZuVnlQSWdkdFJQVW5SbHFVUUFH?=
 =?utf-8?B?VjI2Ry9veS81MlN2cGlWMVliMlVTWlZ3V0N4MzNPN253b1JEVW9qVlhGYnYr?=
 =?utf-8?B?allLS3E0VzhSV2N6bzRDTkhXZFlmYW52RmJ4N3dyd0p3b3dJREMvNUIzdXNk?=
 =?utf-8?B?bytIYm5UVjBsWHh0cFpOOVJBNWNOSUJ6bFZWK1ZXUjhkNURYOHR4NktoK1ZM?=
 =?utf-8?B?WCtMRFc1Vi95UTAwRnRVSFBWeVFGMU9iYVlwOEcrZ0h1aDlKd3ZEVndlek5M?=
 =?utf-8?B?UHBERlRsRlRoc0tGU21kUkl1WVhWV3kxL3cwWVVLVDk4SFZidnEzTVRTdzls?=
 =?utf-8?B?aUlhdGRBZXErU3loVlJRd0ViU2owTEJoclVKVGp2d09GWEVjOTg0V2Q4cnB6?=
 =?utf-8?B?TmdLQi9BM2N4RDFDQlJOd1dNanZDZlV5bWRvNjZGUnRCTkVIQ0hUOUJkNFZq?=
 =?utf-8?B?K1NlY25CVG5KeFhSR1V4THcxaWI2eDNMU3M3MnRWS2dQVjVBTWYxb0xNTXgr?=
 =?utf-8?B?M1NPeVN2a3ZGYndzM1YrZnBpVFF4cnpKbk5XT3NpM0VMQkF1SUk5c1lPTUNT?=
 =?utf-8?B?WjA5cTA4WllQSktRYXNzc2xTZ01tMmxDdlE0R01oZmthY0E4eEwvZDZNYnlZ?=
 =?utf-8?B?VlZnRWMxZmp0dFVZK1lRRVBxb1lNRysvbi9nV3JDaTNhTWpCZWdXbUxOVklK?=
 =?utf-8?Q?XIOWmyjz6McJEnkHi4PMFSwik=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2c5SUtwZ09WdnYrUngzVzZrcW8yTUJCbnF2TWNrRGYvTjFDeXRVd2lRYUFX?=
 =?utf-8?B?MXpWTXowRTgvaHk3dytjYnV2TGIvUjViWlVQZjEzWW9XSDgyVmZCTndweWZQ?=
 =?utf-8?B?eUkzN2NUVW93bU44d21ieWZkMVUwcGlJSlVFMHBORnNkU1ZyTDVaSXhsMjZj?=
 =?utf-8?B?aTNBRjl4NWs1ZVVsZ3VKM3dBNk9FdytzRVFjL29sbFZlYVdMREZRWmM5MTJC?=
 =?utf-8?B?MlI1M011dm9SWnQ0Z2dlZFplcVNoOGI4OE9JSGd3bUNqR0lSSkpuSElxQSt6?=
 =?utf-8?B?dWtubmVUc2dud1ZuVlcxbkxrZU9qWnBWM2JhT0RscjBVeTE5Tm5SSVdIK3lq?=
 =?utf-8?B?RURaQkt5SzEyb3VvZWIvcGRrWGNtYlZXdFlZS1B1NU5IOExjaGVISDBnRkhE?=
 =?utf-8?B?bUlBOXVhTnlTNlFIcHZxVmgrRTZNL3J3ZUhieVhxVlFWREFsTUF4QlZwbVlu?=
 =?utf-8?B?OC96MVVxOThmQ0hTVW9iQWFMK2NyVDlMUitEQ0srZTNVeFNFS0h3c1hadUkz?=
 =?utf-8?B?NXpqZDVvMkZuekFIaVVjWnNYUm4vQVVGNUZQVkpWSjJYclllT2FDRm1tN0ta?=
 =?utf-8?B?dFJjTHlBQVhlZzZlZURyZnlvVGNLWFFlRU9oTDdRbXNTRFo5SVRXc3poc0hZ?=
 =?utf-8?B?RzNudjYyQWdaNm1ZMEpFU2RLQjg2N01Cc081RE9YSjR2VDZzT1F3TDBBNHF6?=
 =?utf-8?B?NDNLRUpvUUN5aG9zSU1KRjRJcS85TzdpL1pvVHkvTzRGR25ITnJDSGJObHkx?=
 =?utf-8?B?NUpjVUg5QUR3OGZPVUhyWjVRbGNQTDk4bE9BRStjNTRlMUdQOW1rMGVjN1NZ?=
 =?utf-8?B?dklZalVoa1FUejc0UnJjT2lGVmVRN2oyZnR0VHcrMW1IMmdZUDR2b29LWXoy?=
 =?utf-8?B?NXR1ckhiSmZBMkJhRktrZnViYkdnZ3JRVHYzQS9RcWJiRitkUEJCbk9lUVFQ?=
 =?utf-8?B?a0ZTVzkyTXN6T1laZDNNM2x4bjI1OXBWRVpJcklOMjhmL2dWMWFrZlY2U0hY?=
 =?utf-8?B?cXF3RzdJWUtxSFJhYTFIS2wyYklLNndHbjdVZFhiZlp0S1FkQlQrL2pBNlZ6?=
 =?utf-8?B?RDJZN2ZKZGtzSnB4TStINGlBYVBDZFROK0kvVXhJVUl2c1grK0gxMklUcHBM?=
 =?utf-8?B?UTRZOUttU1lrZEJjS3JYSFNsMlQ1Ui9JV1BsQlo1ajNpSmw0bW5JU1pNVnRn?=
 =?utf-8?B?YW9VeE5SWkdMaG1nTmNMdVhaTVk4UEk2R24xTmxJa3ZiU3owU0k3ODlpMXl3?=
 =?utf-8?B?c0labUN5QlRLemlidWk1bTR5OWhTcTBBWmM1OHZjUGJxaU5Dd2NMUmdTMitP?=
 =?utf-8?B?TjVLQ0UzbDVBNEZ3OXJuRzFqWTRJWjYrbSs3d0NuMWlYeXlzTW5YMzJGVVBp?=
 =?utf-8?B?M2dBU3RWYW1uc3dpMUJkbkpHK1V1ZEs4aDBySTJWSjdZNEwva2FsNjVxM2Qv?=
 =?utf-8?B?REN0cTI5a21teG5HaFgwQTZOQmQ0cXdHaE9iMXFrQ3hkSzlwWVRtVzVXSm1a?=
 =?utf-8?B?c3pSTGlMclRiY09wS1R6azMwYVluVitrTEI0UGVFajY0SElaVjJhTTdnUGZ4?=
 =?utf-8?B?ZlE2MktnTExoMVVvcWFsZnR0OXBhS0prTWF2NDQwbFlwcUc0UGRDVEhDcG5q?=
 =?utf-8?B?MnYvQTlzTHd5Z0k3c0RQQnpiMGNzNGRzNkpkalI0eksrTXg2OGNzdE1ZeEJw?=
 =?utf-8?B?S0hNMC9lb2pLQURpVzNYemY1ZU8xVU4zS3R1MXhIcXB2cGxIZHJsdXhMb0Uy?=
 =?utf-8?B?djVPdnA5cll4WFFvNlRzUWZ5VmdMZ2J0WDZ5MGt6RllWMVdpblZ6QXJ4T3k4?=
 =?utf-8?B?WjdnNEtocmtMcmpuck5hWFFrdEM4b1EyazNZN21TblVWS0Jrb0MwRVkrZ2cx?=
 =?utf-8?Q?z4htibPQEaiWm?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aeba9c69-3d12-4a18-332a-08df49d55305
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 02:47:48.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB326018

Is this a duplicate of https://lore.kernel.org/all/aoWK_qpSBeO6Bw0M@michali=
s-linux/?

