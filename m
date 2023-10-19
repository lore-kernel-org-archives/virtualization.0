Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008FCDB47E
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 01:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E4938374F;
	Thu, 19 Oct 2023 01:39:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E4938374F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=HNGkwPNg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWJ256dssDgF; Thu, 19 Oct 2023 01:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 861AD83705;
	Thu, 19 Oct 2023 01:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 861AD83705
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 667FFC0039;
	Thu, 19 Oct 2023 01:39:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 973F2C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E9DE60F36
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:39:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E9DE60F36
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=HNGkwPNg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MvGPkRyoD9Fc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:39:30 +0000 (UTC)
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AF2060B8F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:39:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AF2060B8F
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.187.19])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 1DD5210000079;
 Thu, 19 Oct 2023 01:39:27 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1697679566.159000
X-TM-MAIL-UUID: 5eeecf30-b4e9-490c-9d13-879f515c6496
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown
 [104.47.7.168])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 26F4B10006A5F; Thu, 19 Oct 2023 01:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxNpZAMXw4ddvDBv7glcb+jMjEwb57uiyso7jh2ZclrmbgqRoizpmNNLC7YHcjJyYNwgHNER2AlyqPDUAgT1Yed5MMXHiG8TTLUymhqqYJLClN6uRrDX5VKlO7ftbLJVeiYwENER/zekaslxZ9O+UZYywd2xghALeBHXK9DZk9QAQIfGOr06k69JZkEV3RDnJecmZoU9F0Axr/Yy8AWPVFA2v94+KWemNoZNnqd0y1yTFAGP9zdNaXjnB4DcMRXmPp6Rcq0NyJckooksIQmgzAVVME+TA8RsWz/kBTAfXvfwSPLfvcQASGXVsddrtT//YsWePlPtxRl97BsLfvBAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPdJUhKbcqJkqZsEnT8/Jcs6JfSRtpleVgI9nXWUWpM=;
 b=l8eNlW2hOsBp34DSvTnIWZY49AdhlrNR96gwXqd8V4zhMVVQ3UZCTWkEnfMQtn3LirRZ4iVB4YI+uaIlrsArZl18/0wm+LXWF0dOMixC+GP4J4AxDdGPi1YWiVxRpU3tyJDeKRod2Zn5vpu3ufE1+suyD1aXd8gAfJDLEQUePBpLIaLDQ0CNxNIWpF3ukGk8co/axQBD/gE26obu9hBF/MlS30os0EslGGBgsV8peIcvN/6GPqTw3MD79gsFSL7PIRj83tF9ZLyd63cGVdmqdiUGVXQn2VTfYK2D0HGeJraODlhYPBUBrd84ugpXpWe0OEShuKUKp/UhwZnKdK+qGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <58aa1223-0505-421d-9849-b4e9344cb48e@opensynergy.com>
Date: Thu, 19 Oct 2023 10:39:12 +0900
Subject: Re: [virtio-comment] Re: virtio-sound: release control request
 clarification
Content-Language: en-US
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
References: <ZS6mA6/EsmvDVlTC@fedora>
 <1a54feab-5de9-4b39-a4ce-7ff22e23cf52@opensynergy.com>
 <ZS/eDMsOCSatnX90@fedora>
In-Reply-To: <ZS/eDMsOCSatnX90@fedora>
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:22::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR0P281MB2382:EE_|BE1P281MB2356:EE_
X-MS-Office365-Filtering-Correlation-Id: aa49fb0a-c1cd-4212-3a75-08dbd0443969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmItJRZaitrabZpGkl8JB0+HAN5HkGygm9gyfWtlJKccODobCvGPAgo1YyYLzcKi2gCFll9oASrRSxhK3wAndo+UgYW06+Kizp4bcDRfYB3Vj2NwCSeXQZnsWMBAuB0yh78IWm8F8ta7NlyfuWclVYr2Wr9YhfwGhAy4osEOAajq7SOChVwP53jNp4zF5VO7oSDfOs1nsvEXVx+C8PpfEeVYRL09ccpwtuGRi+s3D1/XBscUIghThRD5uJAjlewwmw/moEAOwdfwhjzIlhkwzybX7AlIVAip3NbjokRJkXl/4QOJzdLUWr73+OHWGSdjA1vwPlA8kXlsd4Rjn/Fx2m3I6DHQ1852e8bej2pW1c2ivjYpAQAMf7NJ0ifZxNEHc7fvXyI+oM6H7+97ADwt6mvDAlgTTUhgGeml2Y+icr1cvIIbZpFt2vi0wHSQOakXjPaXM0FcYhPqdpJoM5CJdEwSnxAyFYkW9MwCo7Yxgdh1ZlxeaDyi2X78IQEXKcOJL2Au0wySASiqY425KuxyPfHneL5jZpMagqwWM7+inOSkP7TgMiGve/veTOFw7wDUM9kGAht1M8Znwhmtn0x8yZ8THwaTOv+JoJ6e3v2W8zTpPd5dELnMbHZ+a3gqL4nsk5ZjX0+4EIt2E3YDavEamhRCVf3tH8QRXA1YpymhTSkwzZlBmQQC7LSuLdhwoWWw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(39840400004)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(42186006)(66556008)(66476007)(316002)(6916009)(66946007)(966005)(478600001)(2906002)(31696002)(86362001)(36756003)(5660300002)(4326008)(8676002)(8936002)(41300700001)(44832011)(2616005)(26005)(38100700002)(53546011)(31686004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZ3NG5TZm1rSE02WTg0QzhEVzJpSFA0dWV5bWh3NVBnMVZZWXkzck54d0Jr?=
 =?utf-8?B?SkRxVDZ2STRzOEVSb3J4OWErajRxUUJhRnl6dXNYejJLcCs4OEtEMEUvMnQx?=
 =?utf-8?B?bEtXYlNWcWZHNGd1RVZzWWtCVEJ5Tyt3RVVuOUpyM1h5VHdKREZlUlZ1KzQx?=
 =?utf-8?B?VTR6MHlwQW9zTjd4RkNFTzcySlFrTUM3RThoeWFVc04rR1RCRm1DanpMTS9J?=
 =?utf-8?B?QW5uZVVBT1A2d1pLWjZPdG0wR1lIYmxPQmI3V2JxR2VZdGRYbHdYSXhjNWM1?=
 =?utf-8?B?alp2am0wZGhpM1hhakpiTmliRHdqUk5vQk1UZkp4bGZCMTRXVmVmZTF4VG1m?=
 =?utf-8?B?UzQ2a2RQOFU5V0h3aml4d1dhR0pXY1N1V1FvR1dIMEYyMklsVHlLQ3VpNzlk?=
 =?utf-8?B?TXc2K2F6WCtGTDAvY2FzVVdyWko0L1VOSkwwWE9CZ2FsRnFkNHpybkN1Y2ho?=
 =?utf-8?B?bVVBT1l2TmlDVGdmeVRTYUljVytWdUtDK1pQSVRiTXRjYXBibU4rVy9QRWk5?=
 =?utf-8?B?RytxckIzTDRYUFozZTVDMTZPb0NMa2dsa29ENEFJbklxazdnZDdNclpYWm1p?=
 =?utf-8?B?SnIwR21KREhHOUJnQ3FFTk5sWWMwZk93eEZuVk1UNERaVk5VVFFXUlYvcXND?=
 =?utf-8?B?RFZxTDI4T0ZBRUNralhtUGRuWjVwbi81NFlBNGp4dU5DSFZsbUtZSXlvWnBZ?=
 =?utf-8?B?Zjk0bzBWWm5DZldrNk5oMUJxM1RpTmsrbmx3THR3L1dGMDNlWUJ3VVlSbGdv?=
 =?utf-8?B?NjdoSzVoajEza2Y0U0lSdVNKa2h0TVBZQnhYaGRqa0FadjY5QU5OcTY5cVJ5?=
 =?utf-8?B?Ny9udkI3NG1qakR0Tk9jY0N2L2RZLzdwQ1RBYTdENjEwamVKZ3lOQURUbTRv?=
 =?utf-8?B?VlpIN1FHaW1qUVBDV1AxNmkwK3h5RWtZZTBkZElDcnVRaGJpaWlxR25INkk3?=
 =?utf-8?B?a2dJRFMrdVZWMmI3VFo5ZHNtbDI1Ky8xMCtnTnE4eHozVU9xeW1IdCtpZ2JT?=
 =?utf-8?B?blhnSEZXYzF4YWlDbE1FNlkvWEVDMFFQak1lRnhSVllVTjU4ZVZFZlZuK3Rh?=
 =?utf-8?B?Q0NKN2RxR2hlRVZRMGVkYmd3Qm44WHY4aTk5Sk8wMjc3MWt1OHRPbFlBTU1t?=
 =?utf-8?B?SGdqdWtsYlE4OXVqY3F1ZzRzbUhXMkkzMGRuWU9EWEdSK3JFS1NSZzExS0Fk?=
 =?utf-8?B?b1lEeWQ5MXZGa3ZhM0wybXoydzFCUUwzUThteVRGWHNIbFNLYUNNTFI0SFZX?=
 =?utf-8?B?eXU5cWh2UTg0d0lLVlp6anRFRjZHZHpEa1BpZUluUG5aZ2ZsYWYxZFJ6TldQ?=
 =?utf-8?B?SmpKZ29TWWloRDF1ZXh6WktTVlY4VTdkT3lHak1WcmhGRUg5b1RCeHlMTzE0?=
 =?utf-8?B?Q1ZQckR6UTBPbS9Rd0FiVHRreG8wTWJSbVN0blBMa2QzOEtXbnBnQmN2TFpL?=
 =?utf-8?B?MWp2TlNuVjU3M2RuSlJzY0RGMzNoWGhkMmwzdnNiTU84U0RROXBIb1pkWExR?=
 =?utf-8?B?emdBS1lWdlJma1NEZitoVkVIL29GWXFoQnpOYVhaR0pjMlV0ZEE5eFNuWC90?=
 =?utf-8?B?OVZ3WnI5d2lpTXg3TTcwU004eXV1UFhqemRSM0xGYmkycjgzQkFkMWQ5SDF6?=
 =?utf-8?B?dGJmdlJSSUhCRnQvbFl2Uzg2ZDFhS2ZFMHlaTjdYdHY4STQ4MjdGOEk1NHc3?=
 =?utf-8?B?RllncGVnUHQwWVFYUEhwQVRMdm5LU0QxRmMwdlI5d0xSc05ETWpGQllla3hI?=
 =?utf-8?B?RjVBY2hzdEpOZ20rN2VwWjFiMktNemtVTWNxRzMzanY2SkZSU2ZZeHRpQndR?=
 =?utf-8?B?ZGFkVGdxYy9tRGhtcnJ2cnBoSHdOZ2hvVDdyTFFTZ2pMZmcvV2gvNmxKZHd5?=
 =?utf-8?B?OWFubnRIeTVqV2picjRIYmpyRzhPWUhIMzduK0FuNCsxZTF1RUgwVUxlMmN4?=
 =?utf-8?B?dkFIREhXeUVZaUd6VDJHdk8yUGNhTjI2ajFhTklRSHE3ZVpCWW9YblZodHRy?=
 =?utf-8?B?WlZMcXVPdWMwWHA5Q3BuV3Mramkxdm1sdmFHM1MzazNNcmpwMTFFMzZGVWVl?=
 =?utf-8?B?OHdBUjUvV1R4SUFickJURUxja0FQZTc5WG1MSGduUGU1ODlMUWRRZGgyQWRO?=
 =?utf-8?Q?1OL5l6LX4K/et6KnA10HZwTlV?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa49fb0a-c1cd-4212-3a75-08dbd0443969
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:39:24.3403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJwB4JcGPbMMcooQ76qcFDnwcN+Jiw0ZgFpZ5vcPs0hR4EBCaQMcUEJTm7xWJV8PTt0x+yQc4Kj1bDPZ7aFAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2356
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27944.003
X-TMASE-Result: 10--35.247300-4.000000
X-TMASE-MatchedRID: B0+RG8xpjtRTzAVQ78TKJRhvdi92BBAu+HAk4j3F9/Q32MNYHthSkwZz
 +fefjHSkd8BegXzERwu1KXAvR/p0L5BRGqI1sleG7PuxPfP7XCDn0oaU6WM++z4/QEVYRSrU5TY
 gPdEFG8nYEvcMGOKsuuqDZoOj0iDIswRgP3pwMhJKZ5/rkg+kiIHV87ajhAZwgP0eEH5XmXOZ/c
 ElhY3jtkUW/HQdfZuXHrdltiBAOOYseEVv9y7iCqniWcyxO9yFOteHVGUMZ+CLqBSGNAUF/jRGJ
 noK3ysiVcxKuLJmfajKGm4i8OqQ4MnKzQVv22Mmn8oyfmwYuiASlFBwyvSaLjnirt1Adl4grhHk
 j0hiSu3ze8xLKFK1Aru1kW+n07sPJ7YYCxl68IEF7eh/bG4q+BNyPXhHYGDrQg/DWi2s2tEojxA
 NJtkcjuxOIXDujLQWBPCWjDMeq+3WUlSIdhd0iUF4BLa02hGBFQ/jDVQKXn4zf8BjZjQSE01w0v
 HMvWkXlY8Ey34RTAyq+oRn9TlAHE3CnMPBXN22+wgn0U2OrUj2TdaXZpTzp6FRWC8HCKx2feEys
 Ju+yTLDo6MsU9GwCtT0W8Wz+F3lSG9DTGXldcC6CwqDeGCczAGKwuA7BUnHxW5XYZNHONrZv66s
 fcfywy1UkG2v3wxhQXYl80lP/n/NbHr9UzU803EayD3+TWEcMBiUeMdCj3Ypw3Xj/9GnTKZz8GE
 Wk+EwC3kRdPWoAzF0lxBjNKrrc4n8kUCxEWNKQj0AQ98QP92jg0lrtKMWyg2h/xVLZG6HTvOSXK
 E9MP3p9F0NCWHmGKuJLXQ+r452oli4ZoiOHT/pP8tMOyYmaA==
X-TMASE-XGENCLOUD: 9f146a65-a0a6-4f9e-83b0-4bf1f5f85d34-0-0-200-0
X-TM-Deliver-Signature: D110E3E71C2B10A5BBD63F112A3FF82A
X-TM-Addin-Auth: IlzwLTcs0tO/eU0rVYZ9N2g3k1IEFMC9ycI03ympCrF2yyKeYERwQmQUe8X
 UazheOcnymTj1esIcPMd6wg0pk98Kx84YkBcn+8fEREKoPlUl7zw/CRdrthwcT93MvwaOvkXW1F
 v2Nth7CVA/Ie+sSk+tA51cg9kRckWN9A5bor0Tvyms2y/spGVksozgGptQad1eTMLDlng2blze9
 zYHk4m8OBb9esnOKAwrZ56mpEd/yXcQjbxrZ2WizEK/Fqo7pAY2a5D8pr8XeL0iTmYXAG2Gnls/
 7Lx57eY8GT0HFAQ=.pnzkaKyuconswhrPKz/1Z0MtKo3XvfW4Uw7nIEUG+MK+f6k8JnXg3Hn+So
 +gJ8DibqiVVvIaaMhZ9CkpKLdbShD1HpaNqUT9RWVhRwhxI2jEfWCTKeuVwdqD4NyXf759aez/h
 L3DYIGysMeB6/U6j6vdQJ/8VxA8n6EcXMOpFWZJyj/+4LZVa6CAXCcivOo8KxXlfh+/bKRuIy8E
 /g2vQpUFSgPr9VqmB9eWWhAO9FH4ny9rO9mq3Eoy/L53d6PPrYBEedVbDpVJLakHc1ZDOYoMgGH
 +NqWZSDemGHE0UK9nXsHsYrDRR30WemH8iTpbRxaytvtqmqvVOjRGrTSuQA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1697679567;
 bh=Mg7YqcynHHlfyBHjo2bV/aho2b8B8QTAEKBm6Ndv8tQ=; l=7823;
 h=Date:To:From;
 b=HNGkwPNgkWCcJoQhoUaTuC5BAUMbYa5T8RHgqEaXUDg9wxEWMXBLTM+r7Hv9p44hB
 xBwoy1wfBRwfnBnZlZ+Ze9mwjm/IbyNFWS4vnl/486Bo4KH6nke4Baai2+4vFdhErf
 J1/0UWNeM/uVp0W5tRvuZEyI/kb7xcOeZrgi4oDvMgHJ/V6Px5vG67GAfpqhsWDt89
 zBA9BjMpR5ZOd+YXvavLnH+x/B70oCZuzgy2Oso5C49JFCHzItW0DQL/y7bxqYMpv6
 40sszW1/nVZdERTXsIiQosIaIhU4XlC8HxLh7GBiP/cUzZIckz1Kq/M6ogxMXov/RR
 SvRacRfydlU5A==
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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
From: Anton Yakovlev via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Matias,

On 18.10.2023 22:30, Matias Ezequiel Vara Larsen wrote:
> Hello Anton,
> 
> thanks for the response. I added some inline comments.
> 
> On Wed, Oct 18, 2023 at 10:06:05AM +0900, Anton Yakovlev wrote:
>> Hi Matias,
>>
>>
>> On 18.10.2023 00:19, Matias Ezequiel Vara Larsen wrote:
>>> Hello,
>>>
>>> This email is to clarify the VirtIO specification regarding the RELEASE
>>> control request. Section 5.14.6.6.5.1 [1] states the following device
>>> requirements for the RELEASE control request:
>>> 1. The device MUST complete all pending I/O messages for the specified
>>> stream ID.
>>> 2. The device MUST NOT complete the control request while there are
>>> pending I/O messages for the specified stream ID.
>>>
>>> The 1) requirement does not indicate what "complete" means. Does it mean
>>> that the pending I/O messages in the tx queue shall be outputted in the
>>> host, i.e., consumed by the audio backend? Or, completion means simply
>>> to put the requests in the used-ring without consuming them?
>>
>> Here "to complete" means moving the buffers to the used list in vring.
>> Technically, the specification only requires that the device "return" all
>> referenced DMA memory to the guest before completing the RELEASE control
>> request. What the device actually does with these I/O messages is
>> implementation dependent and is not within the scope of the specification.
>> Thus...
>>
>>
> 
> Thank you, I got it. If I correctly understand you, after RELEASE is
> issued, the specs specify only that the device should "return" all
> buffers or "complete" them. Device implementations MAY or MAY NOT
> playback them. In other words, the specification does not specify if
> consumption should occur. I had interpreted this to mean that the guest
> intended to output those buffers, leaving the device implementation with
> no option but to do so.
> 
>>> Regarding 2), I interpret it as "the device shall wait until all I/O
>>> messages are proceeded to complete the RELEASE control request".
>>
>> ...you can do this way if you really need to.
>>
>>
>>> Currently, the kernel driver seems not expecting such a delay when the
>>> RELEASE command is sent. If I understand correctly, the kernel driver
>>> first sends the RELEASE command and waits a fixed amount of time until
>>> the device can process it. Then, the driver waits a fixed amount of time
>>> until all pending IO messages are completed. If the device follows the
>>> specification and waits until all messages IO are completed to issue the
>>> completion of the RELEASE command, the kernel driver may timeout. The
>>> time to complete N IO messages in the TX queue could be proportional
>>> with the number of pending messages.
>>
>> The default timeout for control requests in the ALSA driver is 1 second. In
>> theory, this time should be enough to completely reproduce/fill the 500ms
>> buffer, and complete all requests, including the RELEASE control request. If
>> the device fails to do this, then most likely there are some problems with the
>> implementation.
>>
> 
> Thanks for clarifying. Sorry to repeat myself, the point I want to make
> is that the virtsnd_pcm_sync_stop() function that sends the RELEASE
> control request uses virtsnd_ctl_msg_send_sync(). Message timeouts are
> set up by the "msg_timeout_ms" module parameter. The timeout is the same
> as for other control requests, such as SET_PARAM and PREPARE, but these
> commands do not require flushing a queue, so I wondered how the timeout
> could be the same.

In general, I don't think it's possible to scale/adjust the timeout value for
any of the control requests at runtime. You pointed only at the RELEASE
request, but depending on the device implementation, other requests may also
take an unpredictable amount of time. For example, if the device communicates
with an audio server over the network.

Therefore, in order not to overcomplicate things, a single more or less
reasonable default value was chosen. Which is also suitable for RELEASE (see
my thoughts above).


Best regards,

>>
>>> In our device implementation [2], RELEASE is handled as follows:
>>> - Drop all messages in the TX queue without outputting in the host.
>>> - Complete the RELEASE control request.
>>>
>>> This seems to be working, however, I can observe that sometimes there
>>> are still requests in the TX queue when we get RELEASE. Those requests
>>> are never reproduced in the host.
>>>
>>> My questions are:
>>> - In the specification, should we modify it to clarify that all pending
>>>     IO messages in the device are discarded during RELEASE, that is, not
>>>     output to the host, but signaled to the guest as completed?
>>
>> No, we shouldn't. See comment above.
>>
>>
>>> - According to the specification, should the driver wait in RELEASE an
>>>     amount of time proportional to the number of periods yet to be
>>>     reproduced?
>>
>> This is purely a matter of driver implementation. It is possible to implement
>> the driver without timeouts, but this would be a bad idea. Because bugs in the
>> device could lead to an infinite wait in the kernel.
>>
>>
> 
> I agree, thanks.
> 
> Matias.
> 
>> Best regards,
>>
>>>
>>> Thanks, Matias.
>>>
>>> [1]
>>> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.2%2fcsd01%2fvirtio%2dv1.2%2dcsd01.html&umid=d5297ffc-9da6-41eb-a09f-b57cd7282232&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-411b9d1d7b38e7727e6478284b6313d5ad82f5a5
>>> [2]
>>> https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-sound
>>
>> -- 
>> Anton Yakovlev
>> Senior Software Engineer
>>
>> OpenSynergy GmbH
>> Rotherstr. 20, 10245 Berlin
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>> List help: virtio-comment-help@lists.oasis-open.org
>> List archive: https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flists.oasis%2dopen.org%2farchives%2fvirtio%2dcomment%2f&umid=d5297ffc-9da6-41eb-a09f-b57cd7282232&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-a481d373f80a6c1b5882e1f0170a0687329391b1
>> Feedback License: https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.oasis%2dopen.org%2fwho%2fipr%2ffeedback%5flicense.pdf&umid=d5297ffc-9da6-41eb-a09f-b57cd7282232&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-9797dad096ce101e2ddeccc4601649f954e89c09
>> List Guidelines: https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.oasis%2dopen.org%2fpolicies%2dguidelines%2fmailing%2dlists&umid=d5297ffc-9da6-41eb-a09f-b57cd7282232&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-e529fd6878ce2da5bc6d951687d9f90e34808b1b
>> Committee: https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.oasis%2dopen.org%2fcommittees%2fvirtio%2f&umid=d5297ffc-9da6-41eb-a09f-b57cd7282232&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-afc2604472b6094aee00bdd9a5aa0a65d12f7e19
>> Join OASIS: https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.oasis%2dopen.org%2fjoin%2f&umid=d5297ffc-9da6-41eb-a09f-b57cd7282232&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-cae044bc06deaf94443835e5f72f10909d5abeec
>>

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
