Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72009C7EE2A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 06:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66B160E73;
	Mon,  5 Jun 2023 06:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D66B160E73
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=O3t6ZP8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqHC2Lf85x65; Mon,  5 Jun 2023 06:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FC1460EAB;
	Mon,  5 Jun 2023 06:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FC1460EAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F63FC007A;
	Mon,  5 Jun 2023 06:41:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EDDBC007A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 356FD60E80
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 356FD60E80
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qf_5SzVWz75
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:41:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A58C60E73
Received: from MW2PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A58C60E73
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 06:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksqKXgE8twlUkPrjhmdxuRhZK9/WOPzYYOUytCTvWAUyWOg4tvUKmGQl83NnH9rIkp1gt2IiaExT5QKjjQeOpOyV0QmHSKuW27wiKn7lUpRnA9ah7ZLkAY7++8OV7qYGeIGn+1Ihlz0PhrDplhh+/uVlYyRsAzhMQxDxq2glw9fqBEHCGKVHZaEg3rdGbPOKuMvEsOeA7oVRMRis0qxNGn3GHhVtAYA+7CGQz2jAeM8fTTTPuh+leQBbzNIt3ZVhWBuXPCZGJC9sfi5C2Mjn3i1+lgBGkaAZFHl55sgFmRxNRpsuF49a8ziesgGcaEVAr+DlzEH/jQLjNMn4g2IdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l84pB1BF+3CMwXbfE93Gog9l4Zn6KjhOh5Naxx6yNU=;
 b=F0jjyOFLD7HnPWVdm1vrHil+Lwdv55yOIqaheFHMw4oIU3TP6eLWj2pp8fU+yWU3PTB0ThJotDUZkqpfCdADSTAimIj9s66R9suWxkl+7YLkB7bx7LpZAUboCMLzpw0tMfyROfsPeZGaum+8fHq1LJ0BGIQvOYp/wM2Rz3M6Pyau3YBZUQ75kYyTr+s+WuhWNgj0V0w0zrcc/lXu62ZaV7vU20lsQtAsUnNq30J0i72Sh3U0FxIj6uQAmPBZ3Tg5VX4kHobPjlKmB/8fbczEsKVMxW+Kec7V2O0cBGqHR+LRxScz4kxeXfgUpGCYMw3Q4Y2o92E3gzu9+l/Sddz0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l84pB1BF+3CMwXbfE93Gog9l4Zn6KjhOh5Naxx6yNU=;
 b=O3t6ZP8AZ6pDA3t0ixLGuZAtATAlsIoIUkE10J2mchFeZAFnGe1U2HCZufUMXMCkJWEi2yEoAV7CTs6pCnRG3pohjH5JfXinX86hZ9A5ceG7RFH2ULTCA1OpMVDbcMhyLyibMmpVGRk23dCc1wKCwUeKVYYMEVbgqmcVLSHNzzY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DS7PR05MB10162.namprd05.prod.outlook.com (2603:10b6:8:e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:40:54 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 06:40:54 +0000
To: Juergen Gross <jgross@suse.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: Re: [PATCH RFC 13/43] x86/paravirt: Use relative reference for
 original instruction
Thread-Topic: [PATCH RFC 13/43] x86/paravirt: Use relative reference for
 original instruction
Thread-Index: AQHZebcsO0UIioi4Kkq/QcVuF28Wwa9147CAgAYY4IA=
Date: Mon, 5 Jun 2023 06:40:54 +0000
Message-ID: <4D9D12CE-87A7-485F-B8F6-A9F77156C372@vmware.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <d0e601438f4d140c0c383c6ad09483b34c7c572e.1682673543.git.houwenlong.hwl@antgroup.com>
 <44e2fb4d-151c-dba9-9cb8-0d99c3668a6f@suse.com>
In-Reply-To: <44e2fb4d-151c-dba9-9cb8-0d99c3668a6f@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DS7PR05MB10162:EE_
x-ms-office365-filtering-correlation-id: 2546f783-a75e-48f5-32f7-08db658fcf9b
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmhnvpXnitQt9QXQTlodd4lRvXzagIRSqG8RZ3IWs5JGsH4ZkV7PsJzzDVDpVNfzHD0JqdZCqF1HvlOGmVr/OuKHmBn0dbALd2ErZFgaskNKAa+J0jpn3+D1g4Xo53Loy27+JSPUfY8i28wJ7Tb6b7RBdf6sizzatDUZ3I/G+mJj0i/G0NOTuI7EQSt5wtKfSwfZQMHJl3ufGbO4oFPaUdi7WHTPuwFk+pidltAcvh0JRv5ki4QUJpJObAvnKRMkjV8f+/lL6OyI+ukS6G33N1uO1LURfbl18ht573O5zXWzJqbuYu3tgmOBLK67Eouv7D5sN0D0eJQ/r/ALCG2Ck6yQ93Io3LtgIaZptuM1Ha8Hal8cq04vyi+JXYyhP6joCD8iHrzP2IJjCEwyc5+rmFhHHy90o8ROR7Md6SSelzR/JRKfkFrv0YiZG8EvVD9+jiug8XpgA/AW0koTBqxKXnRnrtXeLPp+SX4SLfZ9HSLRg5w/xtJNJjKk+YOSBjVM7UjSDSfX9Gc/SEoHUg4in5EjEBw71KC697xoBHxeJmYSXDywNE5SrenwKuvSql1zyiMiZo8iiqdebYGXv3G3i9AgQ9BK2bBAj0fQb73HZSIyZMKUbRHJkXLleZM+sfislfrXbV9Ej6CK7G0VFQ0Gh+Ac0YkkhtOgB0VT/DX3wjm/jG8F7B227zERjBIq7/LZ6YPZk0aEeGITEUcIycShGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(110136005)(54906003)(478600001)(8936002)(8676002)(66446008)(4326008)(76116006)(66556008)(316002)(38100700002)(66476007)(64756008)(66946007)(122000001)(41300700001)(2616005)(186003)(6486002)(71200400001)(53546011)(6506007)(6512007)(26005)(33656002)(86362001)(5660300002)(2906002)(4744005)(38070700005)(36756003)(7416002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qe9c4atXEoM73aVbMsdy2EtyXKNiMwccPIjiKMb8p3xmWPuclSePOdtoC5jT?=
 =?us-ascii?Q?xqECD6GEiRfneuYa2Kv94VDQNgRq8eG3FjnCECAC3YAwZzwaZ/uF4RbXlGKQ?=
 =?us-ascii?Q?ayQSNYGsV6KpNXpcTSNeWAbMF2mjlNUeDgiFMMl7hKsKGhF3ZMpwZ6tKEQYV?=
 =?us-ascii?Q?0XlzD/32JPejz/pSP3+KdSQTNsk5Q5v2ViJm0cRrE1YwVauwYSaczkgTSdmI?=
 =?us-ascii?Q?xPO5E2H9wWJbWqNLODjN9obrPiKgwuyoZyML5HdpWq2xDyGA78fW+S01Xoy4?=
 =?us-ascii?Q?15D6J/JZ7698yYkV6sA+sJKhIVP13lgLl+KrT1DVQ8Otwo4ueaNEwUezWkHl?=
 =?us-ascii?Q?5ceFC8alNEjE+XNY2T7YLuv4/TqtxOA/UbS+RNM66GTR2vAWfkp1c7JefbKS?=
 =?us-ascii?Q?uq3VOoIIwqUfggZ5U+4NPOixC7ccDu0yUPWx7yjj2vcCimNhRNQWlRDC8ydn?=
 =?us-ascii?Q?Y0np3sxreorg0X5DgvNwg8aK7bpI5mgTOPWYKL/Er3EDSDDnjv4xtEo9luWZ?=
 =?us-ascii?Q?JxQyNPruRkIMSLDCjhx0LSEim2DRJbAp7Sq8BCQT7NnXF1XiI7N9RZLeDwh9?=
 =?us-ascii?Q?PzqfzjGhQCk12n6K9RpHo+q5lhSUDylNurojJJXaIAhlrpPSdQAr3ZPETAJV?=
 =?us-ascii?Q?tNA93F/g2hKzg9uufYlV9GkVYGA93yFa8wbtgrSuqdoVzL5wZeHdRFXMxe1G?=
 =?us-ascii?Q?HIedGUm6a2GYrfOTTOamVTolQ2yK4/XpboRO3BY8Fn1x72TWLL1E40k8dUa6?=
 =?us-ascii?Q?/DGLkHS1sJn2BwmG9qdaHkrAY7qPn4gQswziZjtJOpfeE6otsVU+4Vp5fKNT?=
 =?us-ascii?Q?MsGkTMjyie0yYYr0Jbm1uZaFADMrVJo2aRtANPwoEPFZ6NdHwK8RFUPUn1+h?=
 =?us-ascii?Q?DeU7pCuriuGVbwKRh29npTRPLnXeIumYibHWUhhvZHCwcKGmEh58SWUzrOVs?=
 =?us-ascii?Q?LJuBnOKVXNt4MZd6pOSwGQ8Bk2oafJUShCJNiT7dMI+8EqEUoeK3Nm22tUUx?=
 =?us-ascii?Q?WjmH4MWsIsb8b7FUK05IsZIz5ztIET/Pn8hCtksN9e8paWzWRWWKicrcz92N?=
 =?us-ascii?Q?NJiCaoHTrMLAHMo2J67u/XydP1bDNf/K9An1cgWqFj+ydBPq2LB6eQOWbGZR?=
 =?us-ascii?Q?cMJ8EUvRwoRagvRcMw8aiYxLPZuj05P4sq4dCKvsQz2YiwCGLNK7Ba0sCTn8?=
 =?us-ascii?Q?zmXfTPX0kBcd/MtBhGij85DrweajKEFLNo3OtU4cagS2hzzw7JotomSoZQlp?=
 =?us-ascii?Q?MhuRMJd8pwOiNaA6Sp3RNxv6D8TKE8427azHTNL1+BZ4OfdNvkMG6F41bAPd?=
 =?us-ascii?Q?77PhARfZqcrQXVoxDumqZ0+on7ANA1UIJTF8hkuGr+DVYZogZLztb94T8FNT?=
 =?us-ascii?Q?iUzXr5lZxo+xnrUmClIv04sEgg2yjoouhbZNVrRNrK8BbgKwhkfcijRzDq6P?=
 =?us-ascii?Q?kehw9tq0Bn1FzuZs/zLZtNMQklFFro4+hmlMaIPu/DPpNF75X6dTkcFAZAXV?=
 =?us-ascii?Q?h1VEPj7cV40OSl3FJ41AUUwJlAJGjuzHG1QIzF9di+4tnrSVEPDcGsGaJVV3?=
 =?us-ascii?Q?ku2YHB23+gP7usdhKX6QY5S8a/8cix/DWoQ+ZnAw?=
Content-ID: <D379E5A3BA2FD1408D76045E0F162214@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2546f783-a75e-48f5-32f7-08db658fcf9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 06:40:54.0758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDsYi/DwJ/LLzFr0ucIccjR38sav9CfUcHJglntxJrJxmngpMAxhrI60e2sHiwEII4UuVJJJm/KVWmfMpa0/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR05MB10162
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Garnier <thgarnie@chromium.org>, Pv-drivers <Pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alexey Makhalov <amakhalov@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Song Liu <song@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> On Jun 1, 2023, at 2:29 AM, Juergen Gross <jgross@suse.com> wrote:
> 
> On 28.04.23 11:50, Hou Wenlong wrote:
>> Similar to the alternative patching, use relative reference for original
>> instruction rather than absolute one, which saves 8 bytes for one entry
>> on x86_64.  And it could generate R_X86_64_PC32 relocation instead of
>> R_X86_64_64 relocation, which also reduces relocation metadata on
>> relocatable builds. And the alignment could be hard coded to be 4 now.
>> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
>> Cc: Thomas Garnier <thgarnie@chromium.org>
>> Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>> Cc: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> I think this patch should be taken even without the series.

It looks good to me, I am just not sure what the alignment is needed
at all.

Why not to make the struct __packed (like struct alt_instr) and get rid
of all the .align directives? Am I missing something?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
