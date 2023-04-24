Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816B3C77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 21:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15DF640893;
	Mon, 24 Apr 2023 21:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15DF640893
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NG6838f5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Da4q2XXOAT_d; Mon, 24 Apr 2023 21:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5140C408CC;
	Mon, 24 Apr 2023 21:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5140C408CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29FBAC0036;
	Mon, 24 Apr 2023 21:49:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6380BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C58781097
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C58781097
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NG6838f5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vS6axtI6GhVT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:49:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 904F081096
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 904F081096
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp1W29L8fCjeI2sPjnOOHgoqAjDHfZPiCYIBp5H7nr/55tLO93A7XL7I2GbPWzFYx7sd4b0afNfT505cmzJ8idvrS5xpbjih/vJsbS7fmXia6YyVvboHu3VLqYQsyJAX1FUSYjS5/8YrrjkBTJ9o6bRUt49ykkVjNztOodswdqOtFrS9OZwRTYyeJ/+PylP21JQpQvzCstVug37tP8fWyFCiMLP4atdB3MAyM1TqXFizf4dwGqO+gGtPSohZRYEfnxFJYpIoUyy7gT4Cy1zRMVknxdtmLPyYjtsAsqXvP41/1Lm1zm5cbuuxxZVhWdS1qN8MhCoo75UI7yofZVnOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZzu354pZoRdstoapcajR5HVOFzpjwmssyP0H4kIeWg=;
 b=SyB0tiXZp8674M9aFbLcIGCbqv//kAB66U5DomrbWs6kXxuDwmFs2RQfy6+mDNHXM0PvAtfJvc5YoKfKgUI2ksdI4sO6aHmG27qi1E9Fmv97vfy2aZzkoRNg0pydNmA0Cnl1ZzEj7sHGjAEftO1rbDI/KIrfcyaOtA2YfKg3eo8wFrff7Axp4tCk4IhGHFY/rRitx0kY5Tkw9C50tdtQxRVBdGJpkt38aednfDbnR7l0RCV4BKTG3gXszdnbKkm+L0WBuPlMWuQkwjqlMzanHRckFErE7RmJMRw3AZr+oZyK1qKk9MZQyxy59b7m7zMH8qJIFUV8lDpR+8Jc6SUwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZzu354pZoRdstoapcajR5HVOFzpjwmssyP0H4kIeWg=;
 b=NG6838f5d6jLZUuwhxfDuSumQxXRcuIrOCEolzxWYU6i132VM+u9YP9vsxuTjMSTCOXHFT/MiQkop5XPwB83dI8lX5Ezbu0EUU5KhBc3csEUXXG3zveKAoBtWY2/gKlgyMaSA30js4Yu1FUAv0K/5zJlCCXsBfO4dds0jbv/T1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL0PR12MB4995.namprd12.prod.outlook.com (2603:10b6:208:1c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 21:49:03 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 21:49:02 +0000
Message-ID: <4401b5e5-f8e6-8fe9-7b5c-98c33e6142ad@amd.com>
Date: Mon, 24 Apr 2023 14:49:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] vhost_vdpa: support PACKED when setting-getting
 vring_base
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230421195641.391-1-shannon.nelson@amd.com>
 <20230421195641.391-4-shannon.nelson@amd.com>
 <CACGkMEt=N=aqKCwh1OjTcv5uUpkhzax4m9qGdD5OcqoBJAM0bg@mail.gmail.com>
In-Reply-To: <CACGkMEt=N=aqKCwh1OjTcv5uUpkhzax4m9qGdD5OcqoBJAM0bg@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL0PR12MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a4fef8-78e3-467f-d38e-08db450db80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VnzS+NYZoHNga4OkyHNjEtVidpUPGbciArL/+d5UIvm/CH46ZQtDYoLLheoqIjcM85visP6AxU3LJXNOn2ezRtZzQMDnOME2bxUrLMM0hHNJuv5IeG/BMFyEZVT1+d2vwk7aiVDrGYZQGFBW76N9dsAzVEWcKpJLkwrSbY4Hpkou6UG8gFXxbshhR+h0EJgJOG1CK/uL/2Mf1Ke8PUNV6stYuiwR68XqhQbI+HznUDGpy9+WRXbw0t1m9Slkcegq1MEF4ZcqFwV9ND4n1qm0pVMIo+wfxaSgr0sDqK4QqNUnc7Mfivj3gZEIWsBvA5ZoHbqhm37Nl9fIemp86f/rOsAm+CFjiDSoad6A49nTIgzEQk0WUUMrosxj3vaMzzw9U4hlUQJj6s5njjBtCAXJF+IXMKmFwaGPIcP+VpJd7oBNtY/1ViIXubjP1brqhkUx5fdk21toqXzRXNihp1ZT0xjXOEzzG8LpHMVn1J7wuWyD8aed9PJZZVtpT/W8CIPPO7yBhAL1gSgjE39JZ2iSO/YtrpFRANmar/LztIdksMmhUxbBxLDSYCvy9t8GODllh4U7UC702BNuiVk0SzmbMEL1ZVhlkDVUy4ivPgT8MjLVytpsT7xWA8mEbFDqzUQIscZzNthKNJ6XXdIJP5AZJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(478600001)(31696002)(86362001)(36756003)(186003)(53546011)(6486002)(26005)(6512007)(6506007)(4326008)(6916009)(66476007)(66556008)(316002)(44832011)(83380400001)(66946007)(2906002)(38100700002)(8676002)(41300700001)(31686004)(5660300002)(8936002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2V0Q1FoeXQ5UnJmWUlEYnJlWHpEZDliU2EwdlF3eCtlcTNoMEhHVkxNZW5h?=
 =?utf-8?B?SnRNUDlqNEtGTGUrWmlwNlNWMHdoZkpmNnFQOG1YVXZic2hBQU9la3d6c0R0?=
 =?utf-8?B?L0Q5MU5jbmJKYlB0cGRmZ050ZzB0b2NmQ00wN2dvZkU2YzNEVXIzdlhGTEtq?=
 =?utf-8?B?cm9KWlp2dTc5YkJmcXNEdFhMR3hQUEdFWjVsYVFmZk1JYWVycmZkYlZnYmZx?=
 =?utf-8?B?b3F0S3BaNzQyWWx2dndsVjA1dUZmWlZ6THhZT1o0cStqdGdxZEVDSXAwbExD?=
 =?utf-8?B?K043Y1V4VEZxMHFDOGhxS3U0Y3BENG5nbVhyeHlkTEEwQTJ1djFCN2hkZ2Vp?=
 =?utf-8?B?TkhCTFR0N1hsdkQyKzF5UVJ5RWRFRHV0dzQyODVnbGNBMUdYQU5LZi9iREVx?=
 =?utf-8?B?WElJOGFlWlF5T3pPdzIydXZqZWwrMERsR21wOE53dG5TVm1Ma1phM0NCclFj?=
 =?utf-8?B?TVA5ZVFKd3RpYkxoaVVaWHQrSTBaVFRVR2ZPS1hNUzdqTFpzU2dLQnhOUnJR?=
 =?utf-8?B?MmJzNGsxemM0RXFYSFdiSTFHdm45emRSR1l1OU5yWUNqYzZZOXZZeXJYV3Fh?=
 =?utf-8?B?NlBQb1cvR08wNW5YUzlCajJ6LzBzNjBMbmlLa1N5OFJsYTk3YUJSZDBjdWpG?=
 =?utf-8?B?KzBadE9vV2cvNkJIVDZRdmVraHBFVzNjaDB4cE0xKzdXQXQ1andldUJNKzU0?=
 =?utf-8?B?aDJueUhGMFZNSDR4bTErTnZycTVhY1hCWlc3RDVuUERiK3VmeW94OG5mVWpF?=
 =?utf-8?B?WXlaZXVRVnJpVmEzc3VsK3JFWm1QeW1qMTZidVJ4Tyt4K3BTUjBGbG95akww?=
 =?utf-8?B?VWFWVmtoaDZmWnZrSTU0c3RuMUxiY0ZQK1dGOWY0NjYrZmwvZ1dML0p1R0hC?=
 =?utf-8?B?YUp3bmR5RWgrYkk5ZXd2YWoxVGpZYmdaSnBZdkhTZnFucnNnbGdsNnJxK1RJ?=
 =?utf-8?B?MnJqTzJqN2VRMllYWm53NVQ2MVZaVDJDVlFsaTZrR1kyNEk2TGtlZlVsUTRD?=
 =?utf-8?B?RVF2U3l6Zm9jczJ1aGYwSEppVjN1OEVXWE1TaDF0TjJzSU81TGtnTmFlbVJ5?=
 =?utf-8?B?RE4zMi9iNEdpeWk3ZG1nQTI0NThuUzdSdFJLUVlxNFpIdG9yYmRBdzZVNVFx?=
 =?utf-8?B?Y0pNdnhHWTFvaHBNRmN2MzI1b29pRnpqN2ZvVE5WakpKZUZlbU83RldzVUlw?=
 =?utf-8?B?MTRyeW9vK3piblpYMDZnd0JuL25LV3hvNnlXSlFPamNpNjdSK0VadG1NK0FL?=
 =?utf-8?B?S2dPalkvY0pna3E2eUg0M3doZHFGMnBEMHJOaUtFKzlQbGdydGF1QzRWK0Zy?=
 =?utf-8?B?aWZaZEgyeEcxQmsra2x0TmtWWEdXZm9OYWlBbXBDeU95TFpKQXBBcmVoNzB6?=
 =?utf-8?B?M1FWbFlYQmhqeWQ1WVV4dnZuN0FENUVTQWJ0S05EcE9WbGhWalF2MVJ3Y1Np?=
 =?utf-8?B?RWRoSWwvTDRlNlIwN2x3eERLVHFwS2tIY0hCRm5pTjhUbysxVGxqcTNNTkhn?=
 =?utf-8?B?VHdGcU1ESnczQTZRLzNjK3dEV213bDZ6MmJMVmdqMStvWDVhZ29vVVhRRUZn?=
 =?utf-8?B?RC9TUGc1QWhqZFhVUUxLYVF5TjF6dnlHRmZ1cWpVSStocFdNZ2txOHUySllL?=
 =?utf-8?B?QXRMVXdhdnpXQ2xHSHRxMXZieTI0MmNkQ0V2ejR4dVlUaVVLd2ZObWxYcUly?=
 =?utf-8?B?eWFhei9WTkhkbmZjMkk0dWlqbUFnVWpla3JMVm05NkxXT0VTdlFPQ3UvSmJp?=
 =?utf-8?B?d014VXlIYjdhVmRaRERueXl0STV3TE9IYWladTB0NjlVSU9LTlhoeXp6Y2t4?=
 =?utf-8?B?azFnaWMyY3hTcm81Vk5nOWVJUXNkN2NpQmtNTkZHVDQ2cVN4MTJyMG1OaFFR?=
 =?utf-8?B?MW1zVFBrcnRvNUZJbVVvdm51UGRQVkxybE9XM2dNMFh2d0FEM3RrSlMzRVgx?=
 =?utf-8?B?Y0ZTK1lqSzRVRXpVazZCWk9tZkZ4bVNZYUVHZTZ3S253T3dCQ2t4OG5CQlpU?=
 =?utf-8?B?L01sM0lxS3ZZQ1ZVSDJzcXBBMUdWTGI2WFdYOXNxenJPWitQQjk2OWwyd29Q?=
 =?utf-8?B?ZDhteUl2YWd3M2xzNkc1cGNFNVdmZU5Bc1pSWGJ6TlN1VlVPeUtWSXQ0YkZn?=
 =?utf-8?Q?nDJsombLYOE4k9LZ6LWHu1o80?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a4fef8-78e3-467f-d38e-08db450db80e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 21:49:02.9062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NweQ+Fu5pt2FpaMiX5eJD/F1pXa2MvWkKkdcpRS5HdPblw2T9XFIlxWKTx6ZitJ3s/cMkhSSnCdC+SSewm4TdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4995
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org,
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

T24gNC8yMi8yMyAxMTo0MCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBTYXQsIEFwciAyMiwg
MjAyMyBhdCAzOjU34oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+
IHdyb3RlOgo+Pgo+PiBVc2UgdGhlIHJpZ2h0IHN0cnVjdHMgZm9yIFBBQ0tFRCBvciBzcGxpdCB2
cXMgd2hlbiBzZXR0aW5nIGFuZAo+PiBnZXR0aW5nIHRoZSB2cmluZyBiYXNlLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPj4gLS0t
Cj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAxOSArKysrKysrKysrKysrKystLS0tCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+
IGluZGV4IDU5OWI4Y2MyMzhjNy4uMjU0M2FlOWQ1OTM5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBAQCAtNTg1LDcg
KzU4NSwxMiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9z
dF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+PiAgICAgICAgICAgICAgICAgIGlmIChyKQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7Cj4+Cj4+IC0gICAgICAgICAgICAg
ICB2cS0+bGFzdF9hdmFpbF9pZHggPSB2cV9zdGF0ZS5zcGxpdC5hdmFpbF9pbmRleDsKPj4gKyAg
ICAgICAgICAgICAgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElPX0ZfUklOR19QQUNL
RUQpKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHZx
X3N0YXRlLnBhY2tlZC5sYXN0X2F2YWlsX2lkeDsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
dnEtPmxhc3RfdXNlZF9pZHggPSB2cV9zdGF0ZS5wYWNrZWQubGFzdF91c2VkX2lkeDsKPiAKPiBJ
IHdvbmRlciBpZiB0aGUgY29tcGlsZXIgd2lsbCBndWFyYW50ZWUgYSBwaWdneWJhY2sgZm9yIHRo
ZSB3cmFwCj4gY291bnRlciBoZXJlPyBJZiBub3QsIHNob3VsZCB3ZSBleHBsaWNpdGx5IHBhY2tp
bmcgd3JhcCBjb3VudGVyPwoKWWVzLCBnb29kIGNhdGNoLCBJJ2xsIGFkZCB0aGUgd3JhcCBjb3Vu
dGVyLgoKc2xuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
