Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEEEEB64D9
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 20:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47FF381F71;
	Fri,  7 Jul 2023 20:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47FF381F71
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2u8n/sgt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjaYdC4VA2kz; Fri,  7 Jul 2023 20:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9C4781E0D;
	Fri,  7 Jul 2023 20:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9C4781E0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80695C0071;
	Fri,  7 Jul 2023 20:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 050D2C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D475660C1C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D475660C1C
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2u8n/sgt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Z2wiVIfIQwl
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D89F660ACF
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D89F660ACF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0ciYwcP48d1RoDC8394KvZEEyZQgkKSjUhhWoLIP7DQW1xLNVF3ANGVB0gfJ54kjrItYnrMkCJePvqOiW1anGS1M6yP4WvOO1KNpQqSfY0ow/bFro32Vv1cJsNr0dMLAExV447ZH2c7mnn+O38/n4Nx3UKAYCF9txHEtpxcmkD1YIz1rweSUqLycVsgLfhEPTAu95rWcJl4xscs/T9sfsmZ9ofqTMpj7TLaX558lXyXn3ee6rq+ZbEs1PyyIUvjZPP2wSAHW7gbIOMOcKkUj06H9MRoTykQGfoLonK5Er6CMMqX2MEeqFr1cq3GdL+WKq6p/xjxx2yb3LpW+FIKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1E6xDSPstYvkHKd+32GjOE3+EN29AZqzq5zr6b18jU=;
 b=TuxUQtsNHU/ZrESPeGYhxK2AM9MJiovzIWrz8XLyb0ZsMELtUjMhbGhJ5UoY4VFLs4+Wtrz/SHR5uJvAXi1Wi8c9wlKfZhwliSLvjRCyoH6QavxjMie7tcra09bYWA7UW8z07SJGDbk8c9qX3OFnFVN+BuRKuBcbbo/SyqXL9+g4KIehq/+swkCbFDKDWoZLQ8GIlkYZfa/chVL71p7xp5zWP55tMETS/dGZsOGAStWe4T1S+v7hVVZvbbUtlwmyAHqG6zwc0H54zxrJBLS+436QrUkWPEm/qtCyfGi7eGJQI2EEfsP8bbcQ3wkmAhaExYXzFhgjKlrSTZmW9mzoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1E6xDSPstYvkHKd+32GjOE3+EN29AZqzq5zr6b18jU=;
 b=2u8n/sgtEgeMhugjuBLZjdaYJd5pz4fMBawLOHs1n8+XlhFQwzCW4afyaGHHdXkK1rYPIVcZKlbw9SP9SOmPBd9GCtl+BV4yg4TZb/Trm+gUte4x1zdDm9ffPMFX5HYtr18k39YS0deh5PF4CRA5lG7Tp6d2llhBCZSUnufPYFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 20:12:48 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 20:12:48 +0000
Message-ID: <155e0b8f-7d80-4d2d-a487-46ab9d760771@amd.com>
Date: Fri, 7 Jul 2023 13:12:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 2/4] pds_vdpa: always allow offering
 VIRTIO_NET_F_MAC
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-3-shannon.nelson@amd.com>
 <CACGkMEvszXdPy9esfXLNsgjE8OQMX8UQ9HNQ2JVT87xwuOH+LQ@mail.gmail.com>
In-Reply-To: <CACGkMEvszXdPy9esfXLNsgjE8OQMX8UQ9HNQ2JVT87xwuOH+LQ@mail.gmail.com>
X-ClientProxiedBy: PH8PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: bebaf1ce-442c-4919-5c65-08db7f2688de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5trdtJ+LjorOtv7jB5xHCN15oQ33Efjt49t5JMyZ9bYK0530FUMKBhtwFVxi5t5Mo0pPjs1oSLz5NlrDzz5NTQPWB9GixtE331ZxuyABoE7YCiQi/Na6nKgNoXeIIuuuXZbQWgx/WtvEzpV5MeW8KEZWtssZlm0/OxHoR9qYMuwCya8fMnpamt5rTRJTMPTZYroPif9N4+ZaFTtuDqb7KQuyX81VOhk95++QM0f5n41FAO8WwkNdIks6GgiioCCijzU9Me6XbfzoCNOdwlMCUbwqkNsBjPE3PVNP0CjilBGz8wezgAmbdxvs1zfljBumOcqu2FiM0HSZLUKoOQNwhrzq2K9cCPhjpBHHLL1DLQOVmEDAoO9Nl5I3J5veMQbhbwLqrlNmqXNrCY+OuH+y7bO6TJFFf55ygF3Z/jHSHOukMV510XIQgrw0orMtuD6vA+shL1KHdouCOlvd/GMENZgOzs/9E9ZhpKoS0D7XLIQJHsAtyXqpZO+zJsxGtqDzOu3LDXT9kaOJY/+S32ZQTxF+ATDTYwg2LwBNdGu62pwg/BAVSy7O2NDOrBJpNZ5mUCeicu10aLtwI1YFdbvGikZPaXrv9Kwf34Ymbk7Cm4TnynxHzHn2cRwHQuDqvhnJ9dZDKubkkfFgciA1gyazw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(316002)(2906002)(66556008)(66476007)(41300700001)(6916009)(66946007)(4326008)(5660300002)(44832011)(8936002)(8676002)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlCcnJ1Y2FhOU1uc0dVZk5PbWVvb2lDQVZBM2NVZXBYNXEzWlBVK0E3akJ6?=
 =?utf-8?B?cTcyWll4QzQ1dllDWkFMWUx4MjZDOThRNXVUbmdsKy84bENMcHB1bkZtYi80?=
 =?utf-8?B?dFNETjhYUmpmQXp1QmZsY2ZXWEpGQzhsaEcyOGpWU0dEeTVCRnNyc013Njhp?=
 =?utf-8?B?U09oYVZkL1RiSUVPdnlYazRvNkwxNUtEOWNQMHZSK2NGVmRldUJseDVQU1Fi?=
 =?utf-8?B?U0tTK05hU2JQMnBjR3lscnJMSEpMWVVod1FBT3VtOFVlVHdITjdhb3pKOWxh?=
 =?utf-8?B?NlVBV3BTN1R6SXFwRUFrT0FIcmxSaGNuNU9hWjZSaDlWbkxIYVJSMkVzcVFF?=
 =?utf-8?B?V2t3SUxtMm85KzJNR1AxM3pVdFVUZlQwcjdJc1RJR3Z3Zy9rc1h0NjMwZFY4?=
 =?utf-8?B?WktTa0V1Qm90WTJSVDg5NGlQQk1xaEJrYmpzSm9qRDRWOTNyVlNYczFhWmNl?=
 =?utf-8?B?QStWK0NESnpSZEhjK2VGWnFZMDBEbjBrUUhnRWEyekZRR2VJT3Q3T1pJNHIz?=
 =?utf-8?B?ZnhXb3dON01mU1FVajM0aTRnUzltaC9hUXMwNUN6RlJvcXRYRHJlaW5RRVpo?=
 =?utf-8?B?S2VBMnVXNFRmRGNUNi9vSnI5ZHYyNllYZmE1cDE3TlZBdkVYbHdYWUdDMEg1?=
 =?utf-8?B?K3RhTWZqaE52Mm11MGtGeTRLQjJQTUFudjVOMnFzeThYRnV0alZsc3RVd1VP?=
 =?utf-8?B?TFozMjlBTnNwN0J0eGJIL1VSUDRTdHZnTjc2T000dEZBU2lqNjE0NmFKYWxu?=
 =?utf-8?B?dTZ1SlJKM3BmZjAzT2dMZTlRbVV6QWJBeDg0ejNNVzV3aThtYVZvbzRaQWwv?=
 =?utf-8?B?SnRLS3AyQi9JVmdKanlTMXRWRGQvUmZWeGcxTGFCcCtOTzlUTzU1dlowSGc3?=
 =?utf-8?B?bjBRaFgzM0IwYnFidkpaN1RuY2svVy9UcGcwL09ETTRVc1U2cGVZSWEyVHda?=
 =?utf-8?B?aktTd0pmcWdIL3A0WXpQNnlWWlRobitGaWZjQXV1Mk53WkJIOVFnRzFtVDIx?=
 =?utf-8?B?cHQrL1ZOcngza2MrTmNVQjZUd01VVTN2N1JDdUdPYWJUVUwrWjNvSFIzYkpJ?=
 =?utf-8?B?d1ArejdLN0xKV2FheXdJWTZESHBqNnBWcG5zd3ZYS0U0bzhrS1BMejVTQmJn?=
 =?utf-8?B?SEZ0VGxxNkVSMHV3alVnQ2tmNDB3d2hEUGZUSW1MU3dwdEZQOFZJaXRqN1I1?=
 =?utf-8?B?V2NETE8yZXZNd3BIcnFZMWU1Y3o5d0Z3YjFhZ2d2WlE1bGVxZU5iMjJhR1Mx?=
 =?utf-8?B?M1k3V08vWEtXalFOMlhCd1M1alJPdXdIclVWL3BDRnVTeUJFeUwzYTBCMlE1?=
 =?utf-8?B?S2pDVE04Z1dYcjJSZGVjdE9uZ2xKYUpxeCt3MnZLK1BvVFl1WVVrNElkQ3p5?=
 =?utf-8?B?ZTI4a2ZqaER1V0dUNXFJY214S05BQWtoems5N2Jwc2tZcklucVVmYlRCQkEr?=
 =?utf-8?B?bGxKRllqVW1VODZ4Tnl2Q0NMc0J0bjQrc1VEV1NURU5KbVA3N3VwU3hoY25v?=
 =?utf-8?B?UnUxWkJsVlpINSt3T0h1OWs4dkhiMlhhZUM0SHg3bDlPRTVCQk9RMDYrWkFT?=
 =?utf-8?B?T1ZnTS8zRi8vRGtUSG0zeTQxTHJDT2FwVjRRbWxEQiswYmtNNWswdUpIelBV?=
 =?utf-8?B?aVBSRExDQ0xabmtQSTkrLzFXQUxJM0tRQTgxaGk4eHV2aHhlVnloRjRPQ2sv?=
 =?utf-8?B?NHhja0E1SXB0WFJYK3I4dkVialFlOGdmQmc1WnY1S1Q2QTNQenVMcjN4dk1Y?=
 =?utf-8?B?SVVLWWcycndhQWI3QkpxNlVwM0I5aFh0bTVNMHR2b0ZQZStXbDM0NG8wcC85?=
 =?utf-8?B?TUJqNW1CQ2VZVjZsTTlMMkkrUnNaZER3Z1MwSU5DUnA2djRYbVpxUkVEVlpM?=
 =?utf-8?B?L1A0OHNUTzNETTFHYnVpZ29NR1AxeHROYzE0TFNDSXE5MDNpMVpkSExJc2xN?=
 =?utf-8?B?Tjg5dFVCajdObnJGRmRNNFJiSkZab1g4RTB3QTVZdVRpSzRCYndVWGVYY0Jm?=
 =?utf-8?B?Mk5zdmJjNVhaS3RFQ0lKUG8zRlFSVUdxMTdLYUQ1M3ozTTZ4dmcxaldOcU55?=
 =?utf-8?B?VnlNY09IRk9BOUJ4NnNkUVYvSitVeEdQcUphSUxyY2VEdFNBOWl0TnM1V0Vj?=
 =?utf-8?Q?zWwyLWnKijdqZAI/pnIoXAKbz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebaf1ce-442c-4919-5c65-08db7f2688de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:12:48.6275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceHq0CRJWkBA8jXQR/jJCdCP99gTewkLVRAiizFVALWYy5xwQUi7TuzaF0TW92lgOP/V0tDH0SYYnLB3CGSAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
Cc: netdev@vger.kernel.org, drivers@pensando.io,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 mst@redhat.com
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNy83LzIzIDEyOjQ0IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IAo+IE9uIEZyaSwgSnVuIDMw
LCAyMDIzIGF0IDg6MzbigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNv
bT4gd3JvdGU6Cj4+Cj4+IE91ciBkcml2ZXIgc2V0cyBhIG1hYyBpZiB0aGUgSFcgaXMgMDA6Li46
MDAgc28gd2UgbmVlZCB0byBiZSBzdXJlIHRvCj4+IGFkdmVydGlzZSBWSVJUSU9fTkVUX0ZfTUFD
IGV2ZW4gaWYgdGhlIEhXIGRvZXNuJ3QuICBXZSBhbHNvIG5lZWQgdG8gYmUKPj4gc3VyZSB0aGF0
IHZpcnRpb19uZXQgc2VlcyB0aGUgVklSVElPX05FVF9GX01BQyBhbmQgZG9lc24ndCByZXdyaXRl
IHRoZQo+PiBtYWMgYWRkcmVzcyB0aGF0IGEgdXNlciBtYXkgaGF2ZSBzZXQgd2l0aCB0aGUgdmRw
YSB1dGlsaXR5Lgo+Pgo+PiBBZnRlciByZWFkaW5nIHRoZSBod19mZWF0dXJlIGJpdHMsIGFkZCB0
aGUgVklSVElPX05FVF9GX01BQyB0byB0aGUgZHJpdmVyJ3MKPj4gc3VwcG9ydGVkX2ZlYXR1cmVz
IGFuZCB1c2UgdGhhdCBmb3IgcmVwb3J0aW5nIHdoYXQgaXMgYXZhaWxhYmxlLiAgSWYgdGhlCj4+
IEhXIGlzIG5vdCBhZHZlcnRpc2luZyBpdCwgYmUgc3VyZSB0byBzdHJpcCB0aGUgVklSVElPX05F
VF9GX01BQyBiZWZvcmUKPj4gZmluaXNoaW5nIHRoZSBmZWF0dXJlIG5lZ290aWF0aW9uLiAgSWYg
dGhlIHVzZXIgc3BlY2lmaWVzIGEgZGV2aWNlX2ZlYXR1cmVzCj4+IGJpdHBhdHRlcm4gaW4gdGhl
IHZkcGEgdXRpbGl0eSB3aXRob3V0IHRoZSBWSVJUSU9fTkVUX0ZfTUFDIHNldCwgdGhlbgo+PiBk
b24ndCBzZXQgdGhlIG1hYy4KPj4KPj4gRml4ZXM6IDE1MWNjODM0ZjNkZCAoInBkc192ZHBhOiBh
ZGQgc3VwcG9ydCBmb3IgdmRwYSBhbmQgdmRwYW1nbXQgaW50ZXJmYWNlcyIpCj4+IFNpZ25lZC1v
ZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+PiBSZXZpZXdl
ZC1ieTogQnJldHQgQ3JlZWxleSA8YnJldHQuY3JlZWxleUBhbWQuY29tPgo+PiAtLS0KPj4gICBk
cml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgfCAyNSArKysrKysrKysrKysrKysrKysrLS0tLS0t
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgYi9kcml2ZXJzL3Zk
cGEvcGRzL3ZkcGFfZGV2LmMKPj4gaW5kZXggZTJlOTliYjBiZTJiLi41ZTc2MWQ2MjVlZjMgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYwo+PiArKysgYi9kcml2ZXJz
L3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPj4gQEAgLTMxNiw2ICszMTYsNyBAQCBzdGF0aWMgaW50IHBk
c192ZHBhX3NldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2Rldiwg
dTY0IGZlYXR1cgo+PiAgIHsKPj4gICAgICAgICAgc3RydWN0IHBkc192ZHBhX2RldmljZSAqcGRz
diA9IHZkcGFfdG9fcGRzdih2ZHBhX2Rldik7Cj4+ICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRl
diA9ICZwZHN2LT52ZHBhX2Rldi5kZXY7Cj4+ICsgICAgICAgdTY0IHJlcXVlc3RlZF9mZWF0dXJl
czsKPj4gICAgICAgICAgdTY0IGRyaXZlcl9mZWF0dXJlczsKPj4gICAgICAgICAgdTY0IG5lZ29f
ZmVhdHVyZXM7Cj4+ICAgICAgICAgIHU2NCBtaXNzaW5nOwo+PiBAQCAtMzI1LDE4ICszMjYsMjQg
QEAgc3RhdGljIGludCBwZHNfdmRwYV9zZXRfZHJpdmVyX2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYV9kZXYsIHU2NCBmZWF0dXIKPj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVP
UE5PVFNVUFA7Cj4+ICAgICAgICAgIH0KPj4KPj4gKyAgICAgICAvKiBzYXZlIG9yaWdpbmFsIHJl
cXVlc3QgZm9yIGRlYnVnZnMgKi8KPj4gICAgICAgICAgcGRzdi0+cmVxX2ZlYXR1cmVzID0gZmVh
dHVyZXM7Cj4+ICsgICAgICAgcmVxdWVzdGVkX2ZlYXR1cmVzID0gZmVhdHVyZXM7Cj4+ICsKPj4g
KyAgICAgICAvKiBpZiB3ZSdyZSBmYWtpbmcgdGhlIEZfTUFDLCBzdHJpcCBpdCBmcm9tIGZlYXR1
cmVzIHRvIGJlIG5lZ290aWF0ZWQgKi8KPj4gKyAgICAgICBkcml2ZXJfZmVhdHVyZXMgPSBwZHNf
dmRwYV9nZXRfZHJpdmVyX2ZlYXR1cmVzKHZkcGFfZGV2KTsKPj4gKyAgICAgICBpZiAoIShkcml2
ZXJfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NQUMpKSkKPj4gKyAgICAgICAgICAg
ICAgIHJlcXVlc3RlZF9mZWF0dXJlcyAmPSB+QklUX1VMTChWSVJUSU9fTkVUX0ZfTUFDKTsKPiAK
PiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhlcmUsIGFzc3VtaW5nIHdlIGFyZSBkb2luZyBm
ZWF0dXJlCj4gbmVnb3RpYXRpb24gaGVyZS4gSW4gdGhpcyBjYXNlIGRyaXZlcl9mZWF0dXJlcyB3
ZSByZWFkIHNob3VsZCBiZSB6ZXJvPwo+IE9yIGRpZCB5b3UgYWN0dWFsbHkgbWVhbiBkZXZpY2Vf
ZmVhdHVyZXMgaGVyZT8KClllcywgdGhpcyBuZWVkcyB0byBiZSBjbGVhcmVkIHVwLiAgSSdsbCBh
ZGRyZXNzIGl0IGluIHYyLgpzbG4KCj4gCj4gVGhhbmtzCj4gCj4+Cj4+ICAgICAgICAgIC8qIENo
ZWNrIGZvciB2YWxpZCBmZWF0dXJlIGJpdHMgKi8KPj4gLSAgICAgICBuZWdvX2ZlYXR1cmVzID0g
ZmVhdHVyZXMgJiBsZTY0X3RvX2NwdShwZHN2LT52ZHBhX2F1eC0+aWRlbnQuaHdfZmVhdHVyZXMp
Owo+PiAtICAgICAgIG1pc3NpbmcgPSBwZHN2LT5yZXFfZmVhdHVyZXMgJiB+bmVnb19mZWF0dXJl
czsKPj4gKyAgICAgICBuZWdvX2ZlYXR1cmVzID0gcmVxdWVzdGVkX2ZlYXR1cmVzICYgbGU2NF90
b19jcHUocGRzdi0+dmRwYV9hdXgtPmlkZW50Lmh3X2ZlYXR1cmVzKTsKPj4gKyAgICAgICBtaXNz
aW5nID0gcmVxdWVzdGVkX2ZlYXR1cmVzICYgfm5lZ29fZmVhdHVyZXM7Cj4+ICAgICAgICAgIGlm
IChtaXNzaW5nKSB7Cj4+ICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJDYW4ndCBzdXBw
b3J0IGFsbCByZXF1ZXN0ZWQgZmVhdHVyZXMgaW4gJSNsbHgsIG1pc3NpbmcgJSNsbHggZmVhdHVy
ZXNcbiIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBwZHN2LT5yZXFfZmVhdHVyZXMsIG1p
c3NpbmcpOwo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4gICAgICAg
ICAgfQo+Pgo+PiAtICAgICAgIGRyaXZlcl9mZWF0dXJlcyA9IHBkc192ZHBhX2dldF9kcml2ZXJf
ZmVhdHVyZXModmRwYV9kZXYpOwo+PiAgICAgICAgICBkZXZfZGJnKGRldiwgIiVzOiAlI2xseCA9
PiAlI2xseFxuIiwKPj4gICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgZHJpdmVyX2ZlYXR1cmVz
LCBuZWdvX2ZlYXR1cmVzKTsKPj4KPj4gQEAgLTU2NCw3ICs1NzEsNyBAQCBzdGF0aWMgaW50IHBk
c192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5h
bWUsCj4+Cj4+ICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNrICYgQklUX1VMTChWRFBBX0FU
VFJfREVWX0ZFQVRVUkVTKSkgewo+PiAgICAgICAgICAgICAgICAgIHU2NCB1bnN1cHBfZmVhdHVy
ZXMgPQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVy
ZXMgJiB+bWdtdC0+c3VwcG9ydGVkX2ZlYXR1cmVzOwo+PiArICAgICAgICAgICAgICAgICAgICAg
ICBhZGRfY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJiB+cGRzdi0+c3VwcG9ydGVkX2ZlYXR1cmVz
Owo+Pgo+PiAgICAgICAgICAgICAgICAgIGlmICh1bnN1cHBfZmVhdHVyZXMpIHsKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiVW5zdXBwb3J0ZWQgZmVhdHVyZXM6ICUj
bGx4XG4iLCB1bnN1cHBfZmVhdHVyZXMpOwo+PiBAQCAtNjE1LDcgKzYyMiw4IEBAIHN0YXRpYyBp
bnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hh
ciAqbmFtZSwKPj4gICAgICAgICAgfQo+Pgo+PiAgICAgICAgICAvKiBTZXQgYSBtYWMsIGVpdGhl
ciBmcm9tIHRoZSB1c2VyIGNvbmZpZyBpZiBwcm92aWRlZAo+PiAtICAgICAgICAqIG9yIHNldCBh
IHJhbmRvbSBtYWMgaWYgZGVmYXVsdCBpcyAwMDouLjowMAo+PiArICAgICAgICAqIG9yIHVzZSB0
aGUgZGV2aWNlJ3MgbWFjIGlmIG5vdCAwMDouLjowMAo+PiArICAgICAgICAqIG9yIHNldCBhIHJh
bmRvbSBtYWMKPj4gICAgICAgICAgICovCj4+ICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNr
ICYgQklUX1VMTChWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUikpIHsKPj4gICAgICAgICAg
ICAgICAgICBldGhlcl9hZGRyX2NvcHkocGRzdi0+bWFjLCBhZGRfY29uZmlnLT5uZXQubWFjKTsK
Pj4gQEAgLTYyNCw3ICs2MzIsOCBAQCBzdGF0aWMgaW50IHBkc192ZHBhX2Rldl9hZGQoc3RydWN0
IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4+Cj4+ICAgICAgICAgICAg
ICAgICAgdmMgPSBwZHN2LT52ZHBhX2F1eC0+dmRfbWRldi5kZXZpY2U7Cj4+ICAgICAgICAgICAg
ICAgICAgbWVtY3B5X2Zyb21pbyhwZHN2LT5tYWMsIHZjLT5tYWMsIHNpemVvZihwZHN2LT5tYWMp
KTsKPj4gLSAgICAgICAgICAgICAgIGlmIChpc196ZXJvX2V0aGVyX2FkZHIocGRzdi0+bWFjKSkg
ewo+PiArICAgICAgICAgICAgICAgaWYgKGlzX3plcm9fZXRoZXJfYWRkcihwZHN2LT5tYWMpICYm
Cj4+ICsgICAgICAgICAgICAgICAgICAgKHBkc3YtPnN1cHBvcnRlZF9mZWF0dXJlcyAmIEJJVF9V
TEwoVklSVElPX05FVF9GX01BQykpKSB7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBldGhf
cmFuZG9tX2FkZHIocGRzdi0+bWFjKTsKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9p
bmZvKGRldiwgInNldHRpbmcgcmFuZG9tIG1hYyAlcE1cbiIsIHBkc3YtPm1hYyk7Cj4+ICAgICAg
ICAgICAgICAgICAgfQo+PiBAQCAtNzUyLDYgKzc2MSwxMCBAQCBpbnQgcGRzX3ZkcGFfZ2V0X21n
bXRfaW5mbyhzdHJ1Y3QgcGRzX3ZkcGFfYXV4ICp2ZHBhX2F1eCkKPj4gICAgICAgICAgbWdtdC0+
aWRfdGFibGUgPSBwZHNfdmRwYV9pZF90YWJsZTsKPj4gICAgICAgICAgbWdtdC0+ZGV2aWNlID0g
ZGV2Owo+PiAgICAgICAgICBtZ210LT5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBsZTY0X3RvX2NwdSh2
ZHBhX2F1eC0+aWRlbnQuaHdfZmVhdHVyZXMpOwo+PiArCj4+ICsgICAgICAgLyogYWR2ZXJ0aXNl
IEZfTUFDIGV2ZW4gaWYgdGhlIGRldmljZSBkb2Vzbid0ICovCj4+ICsgICAgICAgbWdtdC0+c3Vw
cG9ydGVkX2ZlYXR1cmVzIHw9IEJJVF9VTEwoVklSVElPX05FVF9GX01BQyk7Cj4+ICsKPj4gICAg
ICAgICAgbWdtdC0+Y29uZmlnX2F0dHJfbWFzayA9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01BQ0FERFIpOwo+PiAgICAgICAgICBtZ210LT5jb25maWdfYXR0cl9tYXNrIHw9IEJJVF9V
TEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApOwo+PiAgICAgICAgICBtZ210LT5jb25m
aWdfYXR0cl9tYXNrIHw9IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9GRUFUVVJFUyk7Cj4+IC0tCj4+
IDIuMTcuMQo+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
