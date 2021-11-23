Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF59C433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 09:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F30F140261;
	Tue, 23 Nov 2021 09:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 589dZtWc4qHY; Tue, 23 Nov 2021 09:35:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F3B24018E;
	Tue, 23 Nov 2021 09:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5128DC002E;
	Tue, 23 Nov 2021 09:35:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2E2AC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C088A401E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d10uCM1OvRAH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:35:32 +0000 (UTC)
X-Greylist: delayed 00:06:19 by SQLgrey-1.8.0
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BCFE4018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1637660130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTYAYuLz6LAlov0c7VATxEhevQeVZB3JJ/DFDrRk7WQ=;
 b=L7m1p8HZDJC9rgXwn3xAhB4VIDyK1EEf3NhWI5JgeGae4d0JYbu7eBV6vNXGj//OCs/Nm5
 frfUAIIVWYeOny/r0nm0teEJSO3pvVEF2Xnnbcrxx8ELjL/2YhjmUEZAxngue0XJPcCbvG
 5fhIEDFC+n5yRbZutrZZtMWyxCFTD/g=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-YVdqmY7RMtSvQjidHeNcmw-1; Tue, 23 Nov 2021 10:29:10 +0100
X-MC-Unique: YVdqmY7RMtSvQjidHeNcmw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/GEd4Bqs8nhEfORwz35+fVvQ4yIfoDfQQ3ESeMXP047RtOa9dU7bSK7HdQ8M7g8jY/hqeNGblnMH5LI1fS9FublD9oc+0XQv5h2W+QK9sUTtm7Cnotcjo+Eav2QX11IVST9vRYxL1piu/hDAaw3TI5CswRKbktyvTK6FTZnbiS8V2UvFE3dc3YESfr6VR3GOM1PL2gyhn4cMyzrpBvZURizV9XKnLhI9hVlkvxtJmLG8Tgs8OzMRFYONt85eCSm3OsxAkqIMZy3jhpf40eznhHo2LRfAaOeUS+zusyhC5OvUIEe+xtK5ol/UHo4OdBDJabiRPI1QltLbDBdNSOO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTYAYuLz6LAlov0c7VATxEhevQeVZB3JJ/DFDrRk7WQ=;
 b=gdpiCjoMyVl5AVjcwaePg96MAll9FwvTUoTbf6JGPY10eixMwMv9miahLUDg2D6rDEnA1+Ehn2IIcFsiS+uPCdpuzgiaUT5OPC6FNhZErXnBp3/pIkpiV0c2cZBbO+J1RWoK/dnD6RJ7WQrOoLOTDbdRyua1ow4iRSUWtW2iOGlmUVrxaICdSqAuNwrRCUETt+NK7i6R2+emS21CXX+GZ6tpkmqhYUZCwqrfpxUJSeB0LVI97C/+lrh104MwGP1GXudW7ZOQIm3st0hKJbQdaBLqz/Ry0InFvvR1M1Va8OfUPf00r8ATeBc4nlD+fhKpgQ/FVL9ZTsEuCHmsWJFOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB4351.eurprd04.prod.outlook.com (2603:10a6:803:49::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 09:29:07 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::8062:d7cb:ca45:1898]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::8062:d7cb:ca45:1898%3]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 09:29:07 +0000
Message-ID: <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
Date: Tue, 23 Nov 2021 10:29:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
Content-Language: en-US
To: Juergen Gross <jgross@suse.com>
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
 <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
In-Reply-To: <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
X-ClientProxiedBy: AS8P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::7) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
Received: from [10.156.60.236] (37.24.206.209) by
 AS8P251CA0007.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 09:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bf8c13-b10b-411a-b00b-08d9ae63b2cd
X-MS-TrafficTypeDiagnostic: VI1PR04MB4351:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB4351E3A856C1515AE4054A26B3609@VI1PR04MB4351.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EicWoz0ng6Tg4s1JxpmhyXTTgrHUTYC7UlUWb3lNHdD6KdEdiYQzDX7GwQxRvoCgJ5ExDEQTXW45P55W1N/X0Y233/gb32eHVE0l44KM1svLnc5zpCpPvSl4XouO1+cHihatdtBcfN303WpCphLshBhOzRywUf2R5JA5ZWVYxISor3zi8geOSrXcvNqjU4FU9PBs8iVexUoBp/GuBD7fIL2bz9P1JVXkEDRO/BneWuqxGiOFqGo81qga/+rkLCDbigj2sIzlllXHpUA7tPcGBT0M4vbS3r6NIESpp6g1OBIYgqxCE6TS/l9zaesw+gIef1o5Be6sYt2vJhcL21gRcYOpwL84I8SV6SQBJA+nbzq2xFOrM7hKf2Vg1Cy+KWY0qeW+LZOLYXv8mAGEb+J80mtD9+cWp67RjvUim58jQyuYksZ6zFsJyJ86dbzZZGlu04WnLLSmXNyyLCel2Z2z7VLDDLkah7ZS/vU3QC1iHvl8SJ0o/baObfbG8Rq5pmV5mKO7jipf3iFybD4zrfr2cBLOSXL0SUacrsn9OPSmjEmlzYcvFl1ZKMLsMA7kzCrBKMlMM2i8UJGwdNAZVEQ4Zs3AgrPaGvuoQGCt5W6avFvTbD/TZmGx9jkj80ITf5O1xNhVDO7AyWZOJOc6wH8KnAYB9bdwoqgFTecsbderBd5t7ErPy251Zh8wyjVQTbkvKVZ47PG5EyLgYARh4wtHls1LXGfXR5HRFNSMaaryACk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB5600.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(4744005)(26005)(2906002)(37006003)(54906003)(31696002)(8936002)(66946007)(66476007)(956004)(31686004)(66556008)(6862004)(16576012)(4326008)(38100700002)(6486002)(5660300002)(53546011)(2616005)(8676002)(316002)(508600001)(186003)(83380400001)(86362001)(6636002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVvK2hwemFpS2ZGQkNFT01UdzVoZVhkMWdGd2lHUFFMMmJ2RmtqUEtVMkpi?=
 =?utf-8?B?SmkxZnF6dyswN29JamlHZDRjL1NTNEpheE9vWXNGQThKR3FKUHVGZm9tZ0Vk?=
 =?utf-8?B?WnNWL2wyajBNaEI1TVZiUUs3bm56MlpveEpkeWgrdGRXaG9ZV0JlU0V3b1Bv?=
 =?utf-8?B?MGE1R29nODQ4T2dSY1dIZ2R6a1ljdDVSV2k5OGNVK3BvbHlFSWl2dWN4Vjdk?=
 =?utf-8?B?ekhVNmZVUklUZTV1bWliajVJZm0zc20zSTN2bXFleHNnTnBLa1d6WnlVb2pz?=
 =?utf-8?B?SG9CWk5HVEtOUzdEMkk3T1pQa0Qwdkt3a0lPaExyQVVLMHNEWm91MFFUSXlz?=
 =?utf-8?B?eEdLS3l0R09VUWZTZzE1ZDhWZGlET0RVNWtkNlNqNmRsN0dzd1IwRG1uMWc5?=
 =?utf-8?B?ajIvNWRNWDB1QkFDaE1zYVdjYVlvR0VlZjJ1VHg4WDJlN0JSaVd6YWkwM3c0?=
 =?utf-8?B?bWE2UHREbHlRRGdoa1JQbTFCR1Z4K0dGY01MODBHaHE5cEdPdmMzb2ZDL2p2?=
 =?utf-8?B?S2FOUEhpcHV4eE82bUZqN3daem9UNDhLc1hNeDZUWXg2N0Y4MFhIWDVidnd0?=
 =?utf-8?B?Y2lHY3RiU2tMbkVtc0lkRFM1dHQ0dTIvWW9nYW1JK29oY1lxYVErSzJxWWNT?=
 =?utf-8?B?dGsyRStaUTloMXJEbGt1Uk1saE9WK2tETUtGSjd3SjYvWnRJdTJBL3dRTXRM?=
 =?utf-8?B?S1BQRGQzVFBZajZmby9hb21MaDRPTFdzdkZGOUZ3RGpIdXZXVm5BSk9XMitv?=
 =?utf-8?B?cVBuN1FNdzZYaGtVcWNoeWFZQ1dUaDEvbmFRc1MvYzFJdUE0T0lqakptUDJO?=
 =?utf-8?B?K3psb21IZVkvUk9wcGZ6UTcrQmJmY0VSYmdMa1RlS3h1eEJXU3R1RDNyUVlm?=
 =?utf-8?B?ZjZyV01TK2F5ZGlXdDJFOVExYXhIVmJIRGlFUS80MFNvYWRpQ3EwZzBNVWV5?=
 =?utf-8?B?SHZ0UTV0cno3NVMyYlhFc1E5Z0hUekx2SEtqcER2TVk1RGZwWjBqbTgzb3RR?=
 =?utf-8?B?Ym9LTkdiRXFNM01VMC9TSVowK0FrUmlNZTdDbXV1U0pxdWRPNnBBbDlVWnNw?=
 =?utf-8?B?ekRha1FVRDAzVEN3QlZFOURJQVIvd1FHM1pTYWV0ZXNSRFN2RXNIelRwZk95?=
 =?utf-8?B?UHZxY3BnM2ZNM2ZyYTFiVksrbU04TkhoRk40WGN2ZWpjR0FBSGFwZnU3MXZO?=
 =?utf-8?B?cDMzMlhVaHR0ZmVmbEQvQVc0cSs5Y01NUmhXQTk1VlRwblB5K0lQNGtMWHBz?=
 =?utf-8?B?c0V5U2dXSVZCS2VNTUVMWE1aZmt3b3o2RjMrTzVKUHd1YW9pVGVCVk1KVGRP?=
 =?utf-8?B?RmhxakxuNHAxbjdCSmQ2Q3M0QWhGQkNOejlFVDY0MzEzc0pYVkdzZ0phOFlF?=
 =?utf-8?B?enlqV25XdlNTb1dCQVVnMlovN25JMG5xaFM4U0VJWDdTZXRRUWNhUHhSb2t5?=
 =?utf-8?B?bG1BWGViVmdqTkRiM0xmcnJtQnM1WkgrRUNZUmtPRldLaG1UTkQ5NUtiSTI2?=
 =?utf-8?B?TUZiU3JuMHZKMXJXNmRnRDNxbWNCVkZQQUl2RnE3bmdWd2hxNEljckNWTDla?=
 =?utf-8?B?cGpzZ1JQM2R2U2k5cmJVa0FiMHJFUndweXZDWGhWSndlREt1ZzYwVDlkS1l2?=
 =?utf-8?B?MzhmNUloamZ3dnRtQ2RwNWEzV28zUWdZNG5DKytkSjhaSDliMzUvb1l3SU1B?=
 =?utf-8?B?Qk9zTUdzY0tzblpLa2txTU1pY1h0ZkdMRWVyVldxcVo4YjUvVkRBdHIyU2pU?=
 =?utf-8?B?ZklCcHpnbHpLazJHYktXdWVKVkJxTFZEdEFLUXVJdWp3Wnp1dVRiVUVEQTM0?=
 =?utf-8?B?aHd4RVpkSkF1Umt0WmZoZGtDSVY2T2puM29pejNlTFIyQnoyN2xDd2JnUmRo?=
 =?utf-8?B?VkdxaXo4VTloS294aTlCODBkVDhKT0lIb0JYUncvQWxUbzBydHVtZ0F2dWRT?=
 =?utf-8?B?dHR6YWg5Q1RjdU43YUN0WGNxTzdXZDNpZUd1S0E0cjE3UGxLdlNxeHBMWGV6?=
 =?utf-8?B?V2ZrUG9seWlJQ3M3UytvWTk4Z2ZKVllZa3RpVDYvRXNtb2lyWW9HLzVLZGpI?=
 =?utf-8?B?ZVlMcm1qV1BoWUJ3ZllxeE1sa1BxNnhHbTI5ZFZGNGZpa2lDbXNERWFtVERE?=
 =?utf-8?B?T3FhSEFoNUsyRzM2WGhGbTJ1TGRISmx4UEFBeUdrZHA4RVVCckhqMXh3VFdi?=
 =?utf-8?Q?+RQ9wT+7C8DH0tTpvZzKQvc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bf8c13-b10b-411a-b00b-08d9ae63b2cd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 09:29:07.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6qsVZaW0/OIMUJxDWuaT4gwbiXMVDWViChLVzOZt4WkeEPFijK8rd4zYw6qn/3mKCYZ70bcgNzWvR8b+n6ofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4351
Cc: "VMware, Inc." <pv-drivers@vmware.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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
From: Jan Beulich via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jan Beulich <jbeulich@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 05.10.2021 09:43, Juergen Gross wrote:
> On 30.09.21 14:40, Jan Beulich via Virtualization wrote:
>> While using a plain (constant) address works, its use needlessly invokes
>> a SIB addressing mode, making every call site one byte larger than
>> necessary. Instead of using an "i" constraint with address-of operator
>> and a 'c' operand modifier, simply use an ordinary "m" constraint, which
>> the 64-bit compiler will translate to %rip-relative addressing. This way
>> we also tell the compiler the truth about operand usage - the memory
>> location gets actually read, after all.
>>
>> 32-bit code generation is unaffected by the change.
>>
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks. I notice this wasn't part of your 5.16-rc1 pull request, nor
did it make it into Linus'es tree via any other route. May I ask what
the plans here are?

Jan

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
