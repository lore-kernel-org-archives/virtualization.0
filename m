Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAECC77B75
	for <virtualization@archiver.kernel.org>; Sat,  6 May 2023 12:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09AA383AE4;
	Sat,  6 May 2023 12:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09AA383AE4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oLMmTQrX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezv0KgrGUfBF; Sat,  6 May 2023 12:08:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C9C08210E;
	Sat,  6 May 2023 12:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C9C08210E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31D90C0037;
	Sat,  6 May 2023 12:08:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D571AC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 12:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A17FF82115
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 12:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A17FF82115
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUXHF_cHJ5-a
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 12:08:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75E298210E
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::611])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75E298210E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 May 2023 12:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXE8ff3hUPEGyTimDfKA/IpTq3WpPU6jIGYmxydZP+gfEyNJAvtrm4wCAGvnCP0GRa3m03vKYPqp83USZtCR7U7jA+NrZIDoc2/npcxi4SrP/aq2uVmslsPuHhiQODje6jDWdBuoxTqS9AF/XDu5/hKgZKniVh1rM1ygIYKRO3Izix9viq/ZECyo457kveLFpM86YRDcHETq28iHeAxDc3bHf3O0UjdeL9Uhae4mqiOv7YCZuG7OTXxdsXF3xSoYza/1X7lkqagCwO9HUBsTwtO+gOMsgaJEM2qgmvOXU/FntDAQI5ZOZCSiU5gO4/VXZ95Xi6sBUh9dJ/C5TMO96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0uZbdqij7ky3yBnJTqb6eXQqTAglrPVfDaC43XBFx4=;
 b=QUzDFbOchl2RDaiDr6132Zq8iEJDl8LhkQUmwScjiu8sanKGjqRGA6/bjSxfiKsMt9/1bYwHMHDylB0xwiy2Mj5eBYDQI8USmG2WfwHPraH8aC6n8AFV0/ACRx6bIn1eztJchGvCMphk/klIqGLs7YMGYr2dMgsuBnr4vG9wnFLN/XBuikGefkp09bJ8zsLWivjOg9WWhQgBiumUUmjXzyjSK8rIAtTRKef9xtvESvkO6vHqk1nuRrj8elnu25RUKUGa52UViI3LTOxjwoUn1j4fkyNTq1qFa8K9tug8HqntqRl8RFMMHBBJT8vrAQ/OvXIRaLxTFu2wErWHCOK/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0uZbdqij7ky3yBnJTqb6eXQqTAglrPVfDaC43XBFx4=;
 b=oLMmTQrXo8oHOU6aDEQWU6MHr6nG265RnKTQZYBnUjnQywraNz/qPAiElYPe6q1ELujMv+ct5J7mWnu8+Pzehp+5H0sOqyxP6QY/m47tDXlyeVd4GqUH2k0e63euw0HfCHI1gFEEVOMieTIpYPSvs9cCxx17rU53tbo42SABcx7cN6YhbK52D6Y8iaGOPSJCStVV7CBfMqAouTPwgT8+VwqvDaCWNomqdIWui1chKw7g9gelLwnAunqfWgBi8ISmCd6bU97b1C6IyABBps6dQ92DpqtWurTTYeKiwev/3zJ5ZaDkXHVXP2Z3AIs/fQoTtxnE9WnoWng+kK1wSJATuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 12:08:06 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 12:08:06 +0000
Message-ID: <559ad341-2278-5fad-6805-c7f632e9894e@nvidia.com>
Date: Sat, 6 May 2023 08:08:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v3] virtio_net: Fix error unwinding of XDP
 initialization
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230503003525.48590-1-feliu@nvidia.com>
 <1683340417.612963-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1683340417.612963-3-xuanzhuo@linux.alibaba.com>
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f90a787-3e77-4643-d04a-08db4e2a8ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGSwnioJ5yDT+VoD77EL1OodEFumLf4+RN1InXfr/C5jbs3g6gv/B077h8s7AVaKh1r666ZMtsaSiB2rwxbAmjLfSCUTjp8vAEBlmgvVr4+jf89p6Q2ttRW8gV82NgPdzvxRv5Q9v+GyJ5prG+bGdyXxJTyLfOiV7mbl+RqSW7lbvFzeRNWmwF31xZ+UAVDKpdC2Gc6zs5bwe+nKViDfbGrJMyqL6JiCR5iRwUptUv/r6lz1oZ82vMpyrFNnFNG5sNlCYCbae4RX1ixnG+K1+0hUON9vU7DXnNIT80zWOEm7vBCPuylLgE/7gs7CaRxiWX+8y/FxSOuNeF9T2ySNXB1poN0cYBxyq/wAO7UGFruZyw60skHP8EOCU/p+10YBkkzIRbtfFfAmi8jRi9BYQT1hOnLngZpk0iiJ4Cn4AfKB3x/q/hYAaaL8c4zHjYGkIzUeq7Opf04kuRYGjXUeNLqnNOgmz1uDZ1gBZE+fLUIUJ8biscYAJk+B/7S+CCJhodFbMfDNQdoK3kFfjUIVTw0BnDc47xhP7Uz8WXKWPBnbX4A5/ZyipO1g+xBzbBo6XWLrC6RafrRmNjAW667fFEWMf4YvH+LoVDf+f33Udzf6qtC3Pinwli3ffJaIpLAoB3emeXOUKd0QOHgIi1wpBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(86362001)(8676002)(8936002)(6916009)(6486002)(66946007)(66476007)(66556008)(4326008)(5660300002)(31696002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(26005)(41300700001)(2906002)(186003)(316002)(6512007)(6506007)(54906003)(31686004)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFzQkVDMU9tNzMwKy9DM2tIUEJsWHhwRCtnQ0dGNXRmR2VPZG1DbkVySzRq?=
 =?utf-8?B?QUszNDE4b1NDemNsd3VaNU1XMFQxaXB6NytxRWdLMUdKbEdiTWFoL1lCbTUv?=
 =?utf-8?B?RGQrT0JuZGpZQVN3Si9sMTFpemxNc0h5TS9MU1dZMmhTK2ErRzBnYlR1cEMx?=
 =?utf-8?B?SFBqdVp6eGxEeUo5WkdIU3J3MWVWeWxoMk9KQitjc1lnK2hqM1AvWG5KVFY4?=
 =?utf-8?B?WG5rc29CQWFab2xPU09HTytMVUFQVVpObnBIdHg1MUxrRDRmRDBjSTQ0TTF4?=
 =?utf-8?B?ak03L1hrTHJ6S3BTVCt0elRvQVhmd1MzRHBJT0Y5YjNjN0w4Q0FKbFEwRDBt?=
 =?utf-8?B?LzBsMDJkaTdzUnpScjV1a2VrWGRhak9SVEJQczBjREFrckF4R2laOXg4Z2xB?=
 =?utf-8?B?TUdPbXBsUktKSHFKL1hPYW4yWk8wVkQwN0o2cFNTRSs3UUxLWmgyUmgyNllP?=
 =?utf-8?B?ZzByNkNuM2JDYjQ1RlVjTE9taG1kNUlsd1hSaVdiVE1TenJYZUhrdURUZUdN?=
 =?utf-8?B?emp5czNUOERTTStuMmZLMnYyUVd6NkZEVS9hQ1JFQS8xQWEvT1A0QW5CeXdr?=
 =?utf-8?B?Q2xOWk4vS2FWcmJRZXIyNjltQ05aNWpicDEreFR6SExBWDNtbEp5QzZ0ZGIx?=
 =?utf-8?B?K25WS2MwOFA4dWc5T05ra2x2NGtCc3YycWtVdUY1aE5hYWJpMTQzclpIaUx3?=
 =?utf-8?B?UVpMbjhBSVhDTm1GNUc4NE5DK2swc0VNK2hFWUlPeVFzUnRzZ1dZaDhFSjYw?=
 =?utf-8?B?VDduVXdSakw3Rlh4eUJkZFVDZjhJUmlmN25IOWRpZjFHeGo2eHllZmNzVnFN?=
 =?utf-8?B?cjFSM2FjN1hwNDJSRldnZEhrTmh4Ri9xRU43dlFnbiszM2VuV0FpQWc1Mklu?=
 =?utf-8?B?OTRLQldySzAvVHl2UHVITkF0Qm5OZFpFdTJ0TUxvYllvOWMxaHRiRmtycEto?=
 =?utf-8?B?K05mckZDWEVRYXBYWTFKZ3JROWxNVWJoUVdENHIrcXREbXRaZldkaWJlLzlx?=
 =?utf-8?B?RFZLcVFGWDk1cTZrYkt2c3dqOElHSC96TE1jYTVSQVlpUkQ5Q053NkFma2Q0?=
 =?utf-8?B?dlV4emhKekZhaHVneEh2ZCtqSG1tdm8wSG1qbTlaQ3FWSTMzRGlRa3VZOXQ5?=
 =?utf-8?B?dnNacy9ZRjIxeDluenQ3aTNTTW01dGNvVGxjaTZSNHdLNm5ZMTluNVVPbVRr?=
 =?utf-8?B?bldENE1Yc2s5eDJ2MEswcENIVktUNDJIcW9wWjE3RjZjb0srTlEwdkNCVG5H?=
 =?utf-8?B?OGw2UFRGWVZGNWtiakZBM1J3NjV0TTJ0bVorQnJucjhyVjlDbWlOc1NPNGtC?=
 =?utf-8?B?Ti9HM1B5NkI5aXQraEJwVkU1MCszOCtIdTI4NmlBM1NzRnkrTXdmbUNCWlRn?=
 =?utf-8?B?YzhvQmgxaUN4ZDEveURqNjQwMmhlVzBCLzArRFZmdHQzZktsOC95VlVtWEtG?=
 =?utf-8?B?ZVFtOXZWdnE5aFdHcVUza040UjJFcVJEdTZrQ0xPcjB3Uk16THh1ZTlObWpa?=
 =?utf-8?B?dWFBS3hvNVFIREp5RXM3Q0w4cVFWOEYvUk1yM2laSTV1ekVXVmg5b0M4Ukhv?=
 =?utf-8?B?MUhldDhhWVRuOFJSZm1JNVdabGZ0RGtmV0Fob1NqMkFpODJsUklBdWd3UDNJ?=
 =?utf-8?B?WEtTSlJlVmlOVTJUV2VtSk5UbnJsZHJ1WXNEdUlIMUlNNkdEZEFBS09jSDNo?=
 =?utf-8?B?OUZkNnJ0Y2wrUkJmQUptY2J6WDErUWRva0hURmVueFhCTExwWHRkQlFKc1hq?=
 =?utf-8?B?cXpJbjdUR09hTzM5YThkYmNxWmp5RktxamIxdDJ0WThjOXFLb29JM3ltbmEr?=
 =?utf-8?B?MzBoNG1IdWdjWHlSSHV4cFNmUHVOQVlpamZ5SlluMWRidnpHeVZKb2NRTzhn?=
 =?utf-8?B?emRxZ3RxTkxoS0t4MnJOOGdiSzQ4MWREUUM5SG0rRDZZWGMyRmphd21iSkhY?=
 =?utf-8?B?NzdpNHZOcVJMQmtNOWd1WFpFSmpORHdXZUxZVGt5cjA1V1lJYUVkOE1JZEt1?=
 =?utf-8?B?STNjWTArMGIyU05WMGN0bTdXQnpnWS8yS3dKV2FCNFpYcnBkd01adGpPWVZn?=
 =?utf-8?B?ekhpQWxiRm5lRU5mMTAxeFdXWDRTVEFRVG1sc0JxU0FVVU9ZVW45MTVmRDE5?=
 =?utf-8?Q?wESGpbZqGFiDUGAceedy00Qwn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90a787-3e77-4643-d04a-08db4e2a8ced
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 12:08:06.6772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMXt3A6k1oOmPTGnSdHcg0g5iyH6nTCqpdNbX9gv0/r7s3uv5wndoF0PHHDjyRvQH13OsvVahoSO1MBOn8ZJIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, William Tu <witu@nvidia.com>,
 netdev@vger.kernel.org, Bodong Wang <bodong@nvidia.com>, bpf@vger.kernel.org
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTA1LTA1IHAubS4xMDozMywgWHVhbiBaaHVvIHdyb3RlOgo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gCj4gCj4gT24g
VHVlLCAyIE1heSAyMDIzIDIwOjM1OjI1IC0wNDAwLCBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4+IFdoZW4gaW5pdGlhbGl6aW5nIFhEUCBpbiB2aXJ0bmV0X29wZW4oKSwgc29t
ZSBycSB4ZHAgaW5pdGlhbGl6YXRpb24KPj4gbWF5IGhpdCBhbiBlcnJvciBjYXVzaW5nIG5ldCBk
ZXZpY2Ugb3BlbiBmYWlsZWQuIEhvd2V2ZXIsIHByZXZpb3VzCj4+IHJxcyBoYXZlIGFscmVhZHkg
aW5pdGlhbGl6ZWQgWERQIGFuZCBlbmFibGVkIE5BUEksIHdoaWNoIGlzIG5vdCB0aGUKPj4gZXhw
ZWN0ZWQgYmVoYXZpb3IuIE5lZWQgdG8gcm9sbCBiYWNrIHRoZSBwcmV2aW91cyBycSBpbml0aWFs
aXphdGlvbgo+PiB0byBhdm9pZCBsZWFrcyBpbiBlcnJvciB1bndpbmRpbmcgb2YgaW5pdCBjb2Rl
Lgo+Pgo+PiBBbHNvIGV4dHJhY3QgYSBoZWxwZXIgZnVuY3Rpb24gb2YgZGlzYWJsZSBxdWV1ZSBw
YWlycywgYW5kIHVzZSBuZXdseQo+PiBpbnRyb2R1Y2VkIGhlbHBlciBmdW5jdGlvbiBpbiBlcnJv
ciB1bndpbmRpbmcgYW5kIHZpcnRuZXRfY2xvc2U7Cj4+Cj4+IElzc3VlOiAzMzgzMDM4Cj4+IEZp
eGVzOiA3NTRiOGEyMWE5NmQgKCJ2aXJ0aW9fbmV0OiBzZXR1cCB4ZHBfcnhxX2luZm8iKQo+PiBT
aWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6
IFdpbGxpYW0gVHUgPHdpdHVAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IFNpbW9uIEhvcm1hbiA8c2ltb24u
aG9ybWFuQGNvcmlnaW5lLmNvbT4KPj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+Cj4+IENoYW5nZS1JZDogSWI0YzZhOTdjYjdiODM3Y2ZhNDg0YzU5M2RkNDNh
NDM1YzQ3ZWE2OGYKPj4gLS0tCj4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzAgKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+IGluZGV4IDhkODAzODUz
OGZjNC4uMzczN2NmMTIwY2I3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+IEBAIC0xODY4LDYgKzE4Njgs
MTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGwoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBp
bnQgYnVkZ2V0KQo+PiAgICAgICAgcmV0dXJuIHJlY2VpdmVkOwo+PiAgIH0KPj4KPj4gK3N0YXRp
YyB2b2lkIHZpcnRuZXRfZGlzYWJsZV9xcChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgaW50IHFw
X2luZGV4KQo+PiArewo+PiArICAgICB2aXJ0bmV0X25hcGlfdHhfZGlzYWJsZSgmdmktPnNxW3Fw
X2luZGV4XS5uYXBpKTsKPj4gKyAgICAgbmFwaV9kaXNhYmxlKCZ2aS0+cnFbcXBfaW5kZXhdLm5h
cGkpOwo+PiArICAgICB4ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtxcF9pbmRleF0ueGRwX3J4
cSk7Cj4+ICt9Cj4+ICsKPj4gICBzdGF0aWMgaW50IHZpcnRuZXRfb3BlbihzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQo+PiAgIHsKPj4gICAgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0
ZGV2X3ByaXYoZGV2KTsKPj4gQEAgLTE4ODMsMjAgKzE4OTAsMjYgQEAgc3RhdGljIGludCB2aXJ0
bmV0X29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPj4KPj4gICAgICAgICAgICAgICAgZXJy
ID0geGRwX3J4cV9pbmZvX3JlZygmdmktPnJxW2ldLnhkcF9yeHEsIGRldiwgaSwgdmktPnJxW2ld
Lm5hcGkubmFwaV9pZCk7Cj4+ICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3hkcF9pbmZvX3JlZzsKPj4KPj4gICAgICAgICAgICAgICAgZXJyID0geGRwX3J4cV9pbmZv
X3JlZ19tZW1fbW9kZWwoJnZpLT5ycVtpXS54ZHBfcnhxLAo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1fVFlQRV9QQUdFX1NIQVJFRCwgTlVMTCk7
Cj4+IC0gICAgICAgICAgICAgaWYgKGVyciA8IDApIHsKPj4gLSAgICAgICAgICAgICAgICAgICAg
IHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW2ldLnhkcF9yeHEpOwo+PiAtICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsKPj4gLSAgICAgICAgICAgICB9Cj4+ICsgICAgICAgICAgICAg
aWYgKGVyciA8IDApCj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfcmVnX21l
bV9tb2RlbDsKPj4KPj4gICAgICAgICAgICAgICAgdmlydG5ldF9uYXBpX2VuYWJsZSh2aS0+cnFb
aV0udnEsICZ2aS0+cnFbaV0ubmFwaSk7Cj4+ICAgICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV90
eF9lbmFibGUodmksIHZpLT5zcVtpXS52cSwgJnZpLT5zcVtpXS5uYXBpKTsKPj4gICAgICAgIH0K
Pj4KPj4gICAgICAgIHJldHVybiAwOwo+PiArCj4+ICtlcnJfeGRwX3JlZ19tZW1fbW9kZWw6Cj4+
ICsgICAgIHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW2ldLnhkcF9yeHEpOwo+PiArZXJyX3hk
cF9pbmZvX3JlZzoKPj4gKyAgICAgZm9yIChpID0gaSAtIDE7IGkgPj0gMDsgaS0tKQo+PiArICAg
ICAgICAgICAgIHZpcnRuZXRfZGlzYWJsZV9xcCh2aSwgaSk7Cj4gCj4gCj4gSSB3b3VsZCB0byBr
bm93IHNob3VsZCB3ZSBoYW5kbGUgZm9yIHRoZXNlOgo+IAo+ICAgICAgICAgIGRpc2FibGVfZGVs
YXllZF9yZWZpbGwodmkpOwo+ICAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmdmkt
PnJlZmlsbCk7Cj4gCj4gCj4gTWF5YmUgd2Ugc2hvdWxkIGNhbGwgdmlydG5ldF9jbG9zZSgpIHdp
dGggImkiIGRpcmVjdGx5Lgo+IAo+IFRoYW5rcy4KPiAKPiAKQ2Fu4oCZdCB1c2UgaSBkaXJlY3Rs
eSBoZXJlLCBiZWNhdXNlIGlmIHhkcF9yeHFfaW5mb19yZWcgZmFpbHMsIG5hcGkgaGFzIApub3Qg
YmVlbiBlbmFibGVkIGZvciBjdXJyZW50IHFwIHlldCwgSSBzaG91bGQgcm9sbCBiYWNrIGZyb20g
dGhlIHF1ZXVlIApwYWlycyB3aGVyZSBuYXBpIHdhcyBlbmFibGVkIGJlZm9yZShpLS0pLCBvdGhl
cndpc2UgaXQgd2lsbCBoYW5nIGF0IG5hcGkgCmRpc2FibGUgYXBpCgo+PiArCj4+ICsgICAgIHJl
dHVybiBlcnI7Cj4+ICAgfQo+Pgo+PiAgIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVj
dCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPj4gQEAgLTIzMDUsMTEgKzIzMTgsOCBA
QCBzdGF0aWMgaW50IHZpcnRuZXRfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPj4gICAg
ICAgIC8qIE1ha2Ugc3VyZSByZWZpbGxfd29yayBkb2Vzbid0IHJlLWVuYWJsZSBuYXBpISAqLwo+
PiAgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxsKTsKPj4KPj4gLSAg
ICAgZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+PiAtICAgICAg
ICAgICAgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2aS0+c3FbaV0ubmFwaSk7Cj4+IC0gICAg
ICAgICAgICAgbmFwaV9kaXNhYmxlKCZ2aS0+cnFbaV0ubmFwaSk7Cj4+IC0gICAgICAgICAgICAg
eGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSk7Cj4+IC0gICAgIH0KPj4gKyAg
ICAgZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykKPj4gKyAgICAgICAg
ICAgICB2aXJ0bmV0X2Rpc2FibGVfcXAodmksIGkpOwo+Pgo+PiAgICAgICAgcmV0dXJuIDA7Cj4+
ICAgfQo+PiAtLQo+PiAyLjM3LjEgKEFwcGxlIEdpdC0xMzcuMSkKPj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
