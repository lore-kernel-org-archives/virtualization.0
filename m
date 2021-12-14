Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D87EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 01:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E88F34012D;
	Tue, 14 Dec 2021 01:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4fghgJpm2zl; Tue, 14 Dec 2021 01:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A21A1400E9;
	Tue, 14 Dec 2021 01:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 680E0C001E;
	Tue, 14 Dec 2021 01:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE90C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32022402FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ucbgQTcJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="OzvclFjq"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fnurQCqxIZGl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00703402C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 01:14:07 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLKoE9005506; 
 Tue, 14 Dec 2021 01:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2cL/jo5XIVZwXWnG6Wmy4DscN0cHslVVZRKpROk7nHs=;
 b=ucbgQTcJLCRl0apMNRpuWCXcI1oly8LDFiknmt4gMNKAnsrQj7VcYJOntSMbKEMY/H4d
 2mjoB9X+A+Lk89PPZFNHAsBzle5Rd14mMdLWoyRqXnCIUsDECODoXTaRGLCZT7nSHUvh
 huO4lY450mjTCvlpUInsrm9nQFqT35jMBdyPWJSXyEUT7mGI//Yu72nvWA1kS+2E3baX
 ZarSH7ndI23wr6j3Oq2Jl4Z2LO1bV9YmJdN3oy/jsoyGF6v/Il2uObCQXLVaOHRG9J3i
 5MW+AhtASVTK1SwnXwQrw9Eq19u9HT9jlrtfkuaY0SqOYGeFapxdoeQH6UtB/t2RX8+L Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u22tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 01:14:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE1B30X041862;
 Tue, 14 Dec 2021 01:14:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by userp3020.oracle.com with ESMTP id 3cvnep2f4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 01:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGgPOh3RmItKwJvSuHIZYlgY1/4rfPTZMh2hBQRo5FHaX5rH8EeZgOz719nvG4Z9xZYe69oY6kNlL/UvYX7tj6rlVew9daP05EagXd9Bsa9Yo4JBclVDaFLcamfE39VBwRiPTk6ljlZLsdGAlKoU3/f94di5EK7h15hDYsnDWo80N1sEgjlbzidUUrO4huDol06/K/c7PfNnfscG/Ek0UIzbfWmvnBdSQV1qQ18EugHvVqbrequvJ5VcjkZngyg0EntFvXy7R3Cwh4HftMUj9HNRn0rmeePGxgSfCTOwg022QosUNX+yUh1ahvnMYK9q0IHw0p39mzPEw3dg+4ja6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cL/jo5XIVZwXWnG6Wmy4DscN0cHslVVZRKpROk7nHs=;
 b=LwQXDTHY2v74DxCkRWf2JbTXaY2oqzzym+oLmxwjCoaP2zhfKdDWGAvD87DtvaYwri/k0xCvCUP10lSHJDWAliq50FiUIYIwd3s2I3ZFrnMqTqw6i6OIJyHSU+i/xSkBaCF0gHw/aG1DURl0poW09pB71TBahkpiDhVmzeEYKzdjPWzWbTtFQe/4Pq6WiBvbRCuHC87KvqjieTGJXqEkhhR7JcRXfSOehLdsOu9khvW1alWNuthlyhjRUODWmw2UDzjawObVqBC5NbBXzH5lYS8k7nix3mvYFGd3mzn1nWiMuE+EGgXL6t8nND1HStl0AQDGgzr2ocZvjOWJCnlnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cL/jo5XIVZwXWnG6Wmy4DscN0cHslVVZRKpROk7nHs=;
 b=OzvclFjqjBa0Uy+qydtKGiwxu/rQMtbIXyS7gs4OjVAFP0ja0WjzXyd6U4d/cFONs4bXS69KiqExhEw3PrkJyylzz3F4bSokfh+TxzdN6xkY0EkDKq1ElwdTo1A89C6VKDLVrTtvBN44/CXay5TdHCqU6JDItMNfgupRfEqvJQg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4767.namprd10.prod.outlook.com (2603:10b6:a03:2d1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 01:14:02 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 01:14:02 +0000
Message-ID: <d9dbb500-a7e2-2f30-2f5a-b700f25eda7b@oracle.com>
Date: Mon, 13 Dec 2021 17:13:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec904fd0-a963-4700-c42a-08d9be9f03cf
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4767:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47676102DCC09885D827E636B1759@SJ0PR10MB4767.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLE+1JEJpGHZ2YQhWaLUA/kgpyqN163v13t4NiW7L4e6kXbvuCNvDRRYUg95sY+aeLxICilRw0vWbWO89/Od1t291P0YLSZjByAp+Fmi7uQISeXOsOqU3hHY6QnP2xh4iYFLNIuGcXerJWVGsTlB2AQ/X4GZPxjiP3NUi+Q3+so+cy9rZKrw0sOmgTb1t64Mm8J1fis8/3JyYdMuXem4t6If0XiBFi7gC3ePKVHOP6R5LC01dFo0OkiR98XNRxeosBISPJ/ZV5f65xlweq2rbCVNXNph6oFP5w4T2DSOlkpsDmSRrGoulLkPxvw4+UBgyLrGlq7rO90bWu9bUBBeZSUYp4aQgploaoi+asDaWW4ep4KwFA+heBfpNNSvpX0SMHpmf2bPVM/Qvv4wzr57rYO+VYc+blEVt+87zXSUTB/KMQFgqjEU8bHar3JFpME54z4b7C8qBJ7o5ZyrMgmpBO8AbHSHn8xaCqkwwcEQtttGPN3zwiVYl39Rd0XED6ltKFprsht+6XUYv/ihgFxnCAHBQC1Gk2+8iKpa13F3IqoQ1sw4Phmey+PPqBcxD/p1Q+mWJA+Or3iAKt0Z5SGHN6sgAasmTqcSBO81O8oO8+QaNdD7noADmkCcMnuJPKDGHxvSzlT352cdkQGVXkM8vUgxi+Xat3h3WQVGkxWA7uZVSCJuFZnkjnInVQGbjAMTS3qv3iLKlDxQw8frx2c/AIEe+GP+NqZQGt/7taxuWmPo20sgn88+qXRGz1RuISkWDc2YcbtAUsLV1sNZ7dx8yZonUIvjxF0d1d2NI8qqFKIhhQXLPZ7xxftfE/N6KnTb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(8936002)(38100700002)(2616005)(5660300002)(31686004)(86362001)(31696002)(110136005)(83380400001)(54906003)(36916002)(316002)(186003)(2906002)(36756003)(6666004)(6486002)(6512007)(66556008)(66476007)(4326008)(66946007)(6506007)(26005)(53546011)(508600001)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkpDNGdNaDZ0UklsSHJOakoxc3lLanJsai9MMHZJM1FqRVFCUHdZSE1JdzIy?=
 =?utf-8?B?dVgvM1hvcnh4RzA2NURINFdGYk9saDlQbHZiTTMrb3BHb1dtNHVhN0R1ZnJY?=
 =?utf-8?B?OW4rd3E1VXdtWHJZMW85b09Rcm9uVFN3dGUrRzRjRlhaVFJSV0txam5adXY4?=
 =?utf-8?B?endha1BSVFc5OWQwOEcxU0hRM3N4eFd3QU9CaUVhd1JRVGdjUXZ4Q2xicEg0?=
 =?utf-8?B?NS9HT2NFMHYvZlBXSGE3NUozR2VQbkVWYTVvVUREbHo3YVRSTUw5U3l1U1pw?=
 =?utf-8?B?Vlg5Q2pUT1lWSlErZHFUSTN5NmxKaHplN2hyaGJobVhQcU9PTko1WlBpTzhj?=
 =?utf-8?B?MW16OTJmQjBjWjJHVFlUNUF0QUgvRGlPcy9Oa0JYV1V5QUdyM05aZUp0NHFB?=
 =?utf-8?B?VmdoSmZ3Y0JvL0ZVdDFPU0xZL2t2dWg3UDhJeWVlbkhISFJ6Y2lmTjZNY1Qw?=
 =?utf-8?B?eUdYSHhSQ2lOQU5mdTNnWG9FNkxtOUw3MFczV3hOa2pBaGE3WjhLVkRVRmhh?=
 =?utf-8?B?YXRYc3ltTmh0RnJSWU5NVFVZWS9VY284ZnB6eWd6MkttdWUvaVFIZU5hbGNI?=
 =?utf-8?B?d1g2dzJmTHJRQWtyTVBGcURqZmhlZ0xleElDT1pZbnNtMTIyOFdLUHJCaE9Z?=
 =?utf-8?B?ejZVcGk3K1d1eEcyZy91aWVzY09abnJQK3ZVcmY3dG5xZlo3NW10QXJuQmxE?=
 =?utf-8?B?eC81YU93T0FWOHFSdlZvLzBzZDNXeUErUkdQSGVhTTBoVlY5aXJ6R1JkUW1Z?=
 =?utf-8?B?c0l6TGE1RlVTRnhXNlk5Q2ZlQzEzbVgyZWRHRmxlQmlFTFFCejd3R0lSYVZI?=
 =?utf-8?B?M2E2VDMzZkhzcXB6aVhWQTdna0thTE1IeFo0K083aVpjSjBoYk4xMGs2ZFJw?=
 =?utf-8?B?R2Z6Zk9XMWxoWnRMQjdZTGpGQ1UxNzdXYlo0QzRCU252ZDJIRTFURWFzT3N3?=
 =?utf-8?B?elZ3c2V6OXBqMWhJZzFkWTVFY3cwWExOV2F2YzZSdDVMMkowSXF1NnlVdWpS?=
 =?utf-8?B?Y2Y4ZTQ0WWovUjFKQng0MVAzRXhjKzhBNDlEbW1UZ2M2UDB0SXV2MThZdGY2?=
 =?utf-8?B?YWJVYk5xb1hYb0VjZjhoMUllNC9abEVocERqODJXb0VtNnRRYjNabnNoeDM1?=
 =?utf-8?B?STZreHpYeTRHdTNiVXpQem85aHVOVU93VEFwNTNrTm9KTWlUdC96d1c1bUJC?=
 =?utf-8?B?OVoyVUdnWktVRTF0OCt1Um55L0hzNUFsKzV0M0QxU25Kck5qSUM4Vjg2cUxJ?=
 =?utf-8?B?QnE1RUJWZFBPR2tpcGpOclpQS0hPb0NtWFFXS1pqMytJNGdOWlB3MWVzOFAv?=
 =?utf-8?B?azNHbnVxVFlLUzdtTGtHakZhZU1FQkt5dFh4NU9yaHRsM2h1VHlRb2lpN1Bq?=
 =?utf-8?B?MHoyM05MK1poM0QydzVwWXFBZEE3R1VaU2xpK1NoL1phODF5TUtBLzdEenVn?=
 =?utf-8?B?UWNTVmFkKzZISGtSVnpQdllhOWFIL1EvVkZYd1VrUUZnaEFBaGM2bEMxUkNV?=
 =?utf-8?B?ZWgzdkkrOGZRT0Z2NzNFUTgvaG5nUCtVU3J3VGhEa0hLb0Y5bE1TMlcraHRP?=
 =?utf-8?B?ZmVORXFNTVlPVVdtTHBoUlBzS1N5aUl0WUhxemQzdFhVRkd3eWUyeG92Vm4y?=
 =?utf-8?B?WG9tcUJQclFUanhIM2tkNU9GaGR5Z1M4OGVzVmlCdURFcUxWMUVEZTlJeEFD?=
 =?utf-8?B?OHdDOGRNZXk1UklXM2JVY09XYi84QnNCdHYzcEEwcEMya3JyV0RFQ1NvV2dK?=
 =?utf-8?B?WDYzcmxTb3F0MjhFRHN3MjhxSW9qTHVacTVGcXpDUHZ5OHYzRnJnb1d3T0FQ?=
 =?utf-8?B?SzZLWmM1LzMvYkdhellvR0QvVGd2TDB6dk52WE1hTzB5cWNxQksvWjBBN3E1?=
 =?utf-8?B?OVB4aVNYeDJqY3BCRTZ6ZDlmYVc5ckM2YXdkMFh1YTcyWXcrNGhwZVAzby9h?=
 =?utf-8?B?M0hNZUgrSXRZR3kwT1lpRHBLckFrNThwZzlUbkhyTE13UlZtc1Q0eU1hSVdE?=
 =?utf-8?B?amE2aU5NcVdCdFZFOXFJV2ZtVnFRQ0h2R3RTOVdMcVBpbm9tT1dqUlpnd2Jm?=
 =?utf-8?B?WXAxNEhRdVlxalhiS1ZNUTRLcmUvUnIrcWRVYXNIL2k0OWlYeW82RlUxZWV2?=
 =?utf-8?B?YlNaZ0JLZExMRlZVTGxxOFZtNWxhQmNHeGpFOHVaeElHR3FaeElXcG9sZG5l?=
 =?utf-8?Q?f3VXDOZC4qaxP5pvVxKf7tk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec904fd0-a963-4700-c42a-08d9be9f03cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:14:02.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR4Wds7CWFFTkZgOeXic7OqaRhq1qmyIhOJ4dfw4luunucbQlFSfP06TF8ZGDViAvveAZZBhbrKh7I8WZNGZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4767
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140003
X-Proofpoint-ORIG-GUID: QR03XNv6uBmnnQJkCXbA9GhKTe6KeLQT
X-Proofpoint-GUID: QR03XNv6uBmnnQJkCXbA9GhKTe6KeLQT
Cc: netdev <netdev@vger.kernel.org>, Eli Cohen <elic@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxMi8xMi8yMDIxIDc6MDIgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gU3VuLCBEZWMg
MTIsIDIwMjEgYXQgNToyNiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPj4gT24gRnJpLCBEZWMgMTAsIDIwMjEgYXQgMDU6NDQ6MTVQTSAtMDgwMCwgU2ktV2Vp
IExpdSB3cm90ZToKPj4+IFNvcnJ5IGZvciByZXZpdmluZyB0aGlzIGFuY2llbnQgdGhyZWFkLiBJ
IHdhcyBraW5kYSBsb3N0IGZvciB0aGUgY29uY2x1c2lvbgo+Pj4gaXQgZW5kZWQgdXAgd2l0aC4g
SSBoYXZlIHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zLAo+Pj4KPj4+IDEuIGxlZ2FjeSBndWVzdCBz
dXBwb3J0OiBmcm9tIHRoZSBwYXN0IGNvbnZlcnNhdGlvbnMgaXQgZG9lc24ndCBzZWVtIHRoZQo+
Pj4gc3VwcG9ydCB3aWxsIGJlIGNvbXBsZXRlbHkgZHJvcHBlZCBmcm9tIHRoZSB0YWJsZSwgaXMg
bXkgdW5kZXJzdGFuZGluZwo+Pj4gY29ycmVjdD8gQWN0dWFsbHkgd2UncmUgaW50ZXJlc3RlZCBp
biBzdXBwb3J0aW5nIHZpcnRpbyB2MC45NSBndWVzdCBmb3IgeDg2LAo+Pj4gd2hpY2ggaXMgYmFj
a2VkIGJ5IHRoZSBzcGVjIGF0Cj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9vemxhYnMub3JnLypydXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmX187ZmchIUFD
V1Y1TjlNMlJWOTloUSFmNjRScVBGYllXV1RHQmdmV0x6amxwSlJfODlXZ1g5S1FUVHoydmQtOVV2
TXVmTXpxRWJzYWpzOGR4U2ZnMEc4JCAuIFRob3VnaCBJJ20gbm90IHN1cmUKPj4+IGlmIHRoZXJl
J3MgcmVxdWVzdC9uZWVkIHRvIHN1cHBvcnQgd2lsZGVyIGxlZ2FjeSB2aXJ0aW8gdmVyc2lvbnMg
ZWFybGllcgo+Pj4gYmV5b25kLgo+PiBJIHBlcnNvbmFsbHkgZmVlbCBpdCdzIGxlc3Mgd29yayB0
byBhZGQgaW4ga2VybmVsIHRoYW4gdHJ5IHRvCj4+IHdvcmsgYXJvdW5kIGl0IGluIHVzZXJzcGFj
ZS4gSmFzb24gZmVlbHMgZGlmZmVyZW50bHkuCj4+IE1heWJlIHBvc3QgdGhlIHBhdGNoZXMgYW5k
IHRoaXMgd2lsbCBwcm92ZSB0byBKYXNvbiBpdCdzIG5vdAo+PiB0b28gdGVycmlibGU/Cj4gVGhh
dCdzIG9uZSB3YXksIG90aGVyIHRoYW4gdGhlIGNvbmZpZyBhY2Nlc3MgYmVmb3JlIHNldHRpbmcg
ZmVhdHVyZXMsCj4gd2UgbmVlZCB0byBkZWFsIHdpdGggb3RoZXIgc3R1ZmZzOgo+Cj4gMSkgVklS
VElPX0ZfT1JERVJfUExBVEZPUk0KPiAyKSB0aGVyZSBjb3VsZCBiZSBhIHBhcmVudCBkZXZpY2Ug
dGhhdCBvbmx5IHN1cHBvcnQgMS4wIGRldmljZQpXZSBkbyB3YW50IHRvIGludm9sdmUgdmVuZG9y
J3Mgc3VwcG9ydCBmb3IgYSBsZWdhY3kgKG9yIHRyYW5zaXRpb25hbCkgCmRldmljZSBkYXRhcGF0
aC4gT3RoZXJ3aXNlIGl0J2QgYmUgdG9vIGRpZmZpY3VsdCB0byBlbXVsYXRlL3RyYW5zbGF0ZSBp
biAKc29mdHdhcmUvUUVNVS4gVGhlIGFib3ZlIHR3byBtaWdodCBub3QgYmUgYW4gaXNzdWUgaWYg
dGhlIHZlbmRvciBjbGFpbXMgCjAuOTUgc3VwcG9ydCBpbiB2aXJ0cXVldWUgYW5kIHJpbmcgbGF5
b3V0LCBwbHVzIGxpbWl0aW5nIHRvIHg4NiBzdXBwb3J0IAooTEUgd2l0aCB3ZWFrIG9yZGVyaW5n
KSBzZWVtcyB0byBzaW1wbGlmeSBhIGxvdCBvZiB0aGVzZSByZXF1aXJlbWVudHMuIEkgCmRvbid0
IHRoaW5rIGVtdWxhdGluZyBhIGxlZ2FjeSBkZXZpY2UgbW9kZWwgb24gdG9wIG9mIGEgMS4wIHZk
cGEgcGFyZW50IApmb3IgdGhlIGRhdGFwbGFuZSB3b3VsZCBiZSBhIGdvb2QgaWRlYSwgZWl0aGVy
LgoKPgo+IEFuZCBhIGxvdCBvZiBvdGhlciBzdHVmZiBzdW1tYXJpemVkIGluIHNwZWMgNy40IHdo
aWNoIHNlZW1zIG5vdCBhbgo+IGVhc3kgdGFzay4gVmFyaW91cyB2RFBBIHBhcmVudCBkcml2ZXJz
IHdlcmUgd3JpdHRlbiB1bmRlciB0aGUKPiBhc3N1bXB0aW9uIHRoYXQgb25seSBtb2Rlcm4gZGV2
aWNlcyBhcmUgc3VwcG9ydGVkLgpJZiBzb21lIG9mIHRoZXNlIHZEUEEgdmVuZG9ycyBkbyBwcm92
aWRlIHRoZSAwLjk1IHN1cHBvcnQsIGVzcGVjaWFsbHkgb24gCnRoZSBkYXRhcGF0aCBhbmQgcmlu
ZyBsYXlvdXQgdGhhdCB3ZWxsIHNhdGlzZmllcyBhIHRyYW5zaXRpb25hbCBkZXZpY2UgCm1vZGVs
IGRlZmluZWQgaW4gc2VjdGlvbiA3LjQsIEkgZ3Vlc3Mgd2UgY2FuIHNjb3BlIHRoZSBpbml0aWFs
IHN1cHBvcnQgCnRvIHRoZXNlIHZlbmRvciBkcml2ZXJzIGFuZCB4ODYgb25seS4gTGV0IG1lIGtu
b3cgaWYgSSBtaXNzIHNvbWV0aGluZyBlbHNlLgoKVGhhbmtzLAotU2l3ZWkKCgo+Cj4gVGhhbmtz
Cj4KPj4+IDIuIHN1cHBvc2Ugc29tZSBmb3JtIG9mIGxlZ2FjeSBndWVzdCBzdXBwb3J0IG5lZWRz
IHRvIGJlIHRoZXJlLCBob3cgZG8gd2UKPj4+IGRlYWwgd2l0aCB0aGUgYm9ndXMgYXNzdW1wdGlv
biBiZWxvdyBpbiB2ZHBhX2dldF9jb25maWcoKSBpbiB0aGUgc2hvcnQgdGVybT8KPj4+IEl0IGxv
b2tzIG9uZSBvZiB0aGUgaW50dWl0aXZlIGZpeCBpcyB0byBtb3ZlIHRoZSB2ZHBhX3NldF9mZWF0
dXJlcyBjYWxsIG91dAo+Pj4gb2YgdmRwYV9nZXRfY29uZmlnKCkgdG8gdmRwYV9zZXRfY29uZmln
KCkuCj4+Pgo+Pj4gICAgICAgICAgLyoKPj4+ICAgICAgICAgICAqIENvbmZpZyBhY2Nlc3NlcyBh
cmVuJ3Qgc3VwcG9zZWQgdG8gdHJpZ2dlciBiZWZvcmUgZmVhdHVyZXMgYXJlCj4+PiBzZXQuCj4+
PiAgICAgICAgICAgKiBJZiBpdCBkb2VzIGhhcHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kgZ3Vlc3Qu
Cj4+PiAgICAgICAgICAgKi8KPj4+ICAgICAgICAgIGlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQp
Cj4+PiAgICAgICAgICAgICAgICAgIHZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+Pj4gICAg
ICAgICAgb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+Pj4KPj4+IEkg
Y2FuIHBvc3QgYSBwYXRjaCB0byBmaXggMikgaWYgdGhlcmUncyBjb25zZW5zdXMgYWxyZWFkeSBy
ZWFjaGVkLgo+Pj4KPj4+IFRoYW5rcywKPj4+IC1TaXdlaQo+PiBJJ20gbm90IHN1cmUgaG93IGlt
cG9ydGFudCBpdCBpcyB0byBjaGFuZ2UgdGhhdC4KPj4gSW4gYW55IGNhc2UgaXQgb25seSBhZmZl
Y3RzIHRyYW5zaXRpb25hbCBkZXZpY2VzLCByaWdodD8KPj4gTGVnYWN5IG9ubHkgc2hvdWxkIG5v
dCBjYXJlIC4uLgo+Pgo+Pgo+Pj4gT24gMy8yLzIwMjEgMjo1MyBBTSwgSmFzb24gV2FuZyB3cm90
ZToKPj4+PiBPbiAyMDIxLzMvMiA1OjQ3IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+Pj4+PiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAxMTo1Njo1MEFNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+Pj4+Pj4gT24gMjAyMS8zLzEgNTozNCDkuIrljYgsIE1pY2hhZWwgUy4gVHNp
cmtpbiB3cm90ZToKPj4+Pj4+PiBPbiBXZWQsIEZlYiAyNCwgMjAyMSBhdCAxMDoyNDo0MUFNIC0w
ODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+Pj4gRGV0ZWN0aW5nIGl0IGlzbid0IGVub3Vn
aCB0aG91Z2gsIHdlIHdpbGwgbmVlZCBhIG5ldyBpb2N0bCB0byBub3RpZnkKPj4+Pj4+Pj4+IHRo
ZSBrZXJuZWwgdGhhdCBpdCdzIGEgbGVnYWN5IGd1ZXN0LiBVZ2ggOigKPj4+Pj4+Pj4gV2VsbCwg
YWx0aG91Z2ggSSB0aGluayBhZGRpbmcgYW4gaW9jdGwgaXMgZG9hYmxlLCBtYXkgSQo+Pj4+Pj4+
PiBrbm93IHdoYXQgdGhlIHVzZQo+Pj4+Pj4+PiBjYXNlIHRoZXJlIHdpbGwgYmUgZm9yIGtlcm5l
bCB0byBsZXZlcmFnZSBzdWNoIGluZm8KPj4+Pj4+Pj4gZGlyZWN0bHk/IElzIHRoZXJlIGEKPj4+
Pj4+Pj4gY2FzZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUgaW9jdGxzIGxhdGVyIGlmIHRo
ZXJlJ3MgaW5kZWVkCj4+Pj4+Pj4+IGRpZmZlcmVudGlhdGlvbiAobGVnYWN5IHYucy4gbW9kZXJu
KSBuZWVkZWQ/Cj4+Pj4+Pj4gQlRXIGEgZ29vZCBBUEkgY291bGQgYmUKPj4+Pj4+Pgo+Pj4+Pj4+
ICNkZWZpbmUgVkhPU1RfU0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+Pj4+
Pj4+ICNkZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+
Pj4+Pj4+Cj4+Pj4+Pj4gd2UgZGlkIGl0IHBlciB2cmluZyBidXQgbWF5YmUgdGhhdCB3YXMgYSBt
aXN0YWtlIC4uLgo+Pj4+Pj4gQWN0dWFsbHksIEkgd29uZGVyIHdoZXRoZXIgaXQncyBnb29kIHRp
bWUgdG8ganVzdCBub3Qgc3VwcG9ydAo+Pj4+Pj4gbGVnYWN5IGRyaXZlcgo+Pj4+Pj4gZm9yIHZE
UEEuIENvbnNpZGVyOgo+Pj4+Pj4KPj4+Pj4+IDEpIEl0J3MgZGVmaW5pdGlvbiBpcyBuby1ub3Jt
YXRpdmUKPj4+Pj4+IDIpIEEgbG90IG9mIGJ1ZHJlbiBvZiBjb2Rlcwo+Pj4+Pj4KPj4+Pj4+IFNv
IHFlbXUgY2FuIHN0aWxsIHByZXNlbnQgdGhlIGxlZ2FjeSBkZXZpY2Ugc2luY2UgdGhlIGNvbmZp
Zwo+Pj4+Pj4gc3BhY2Ugb3Igb3RoZXIKPj4+Pj4+IHN0dWZmcyB0aGF0IGlzIHByZXNlbnRlZCBi
eSB2aG9zdC12RFBBIGlzIG5vdCBleHBlY3RlZCB0byBiZQo+Pj4+Pj4gYWNjZXNzZWQgYnkKPj4+
Pj4+IGd1ZXN0IGRpcmVjdGx5LiBRZW11IGNhbiBkbyB0aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hl
biBuZWNlc3NhcnkKPj4+Pj4+IGluIHRoaXMKPj4+Pj4+IGNhc2U/Cj4+Pj4+Pgo+Pj4+Pj4gVGhh
bmtzCj4+Pj4+Pgo+Pj4+PiBPdmVyYWxsIEkgd291bGQgYmUgZmluZSB3aXRoIHRoaXMgYXBwcm9h
Y2ggYnV0IHdlIG5lZWQgdG8gYXZvaWQgYnJlYWtpbmcKPj4+Pj4gd29ya2luZyB1c2Vyc3BhY2Us
IHFlbXUgcmVsZWFzZXMgd2l0aCB2ZHBhIHN1cHBvcnQgYXJlIG91dCB0aGVyZSBhbmQKPj4+Pj4g
c2VlbSB0byB3b3JrIGZvciBwZW9wbGUuIEFueSBjaGFuZ2VzIG5lZWQgdG8gdGFrZSB0aGF0IGlu
dG8gYWNjb3VudAo+Pj4+PiBhbmQgZG9jdW1lbnQgY29tcGF0aWJpbGl0eSBjb25jZXJucy4KPj4+
Pgo+Pj4+IEFncmVlLCBsZXQgbWUgY2hlY2suCj4+Pj4KPj4+Pgo+Pj4+PiAgICBJIG5vdGUgdGhh
dCBhbnkgaGFyZHdhcmUKPj4+Pj4gaW1wbGVtZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9y
IGxlZ2FjeSBleGNlcHQgb24gcGxhdGZvcm1zIHdpdGgKPj4+Pj4gc3Ryb25nIG9yZGVyaW5nIHdo
aWNoIG1pZ2h0IGJlIGhlbHBmdWwgaW4gcmVkdWNpbmcgdGhlIHNjb3BlLgo+Pj4+Cj4+Pj4gWWVz
Lgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+PgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
