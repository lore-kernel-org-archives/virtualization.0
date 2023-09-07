Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498CAEC875E
	for <virtualization@archiver.kernel.org>; Thu,  7 Sep 2023 23:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC761612F0;
	Thu,  7 Sep 2023 23:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC761612F0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lwk13P6m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H7zXnmykkAbN; Thu,  7 Sep 2023 23:02:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CF876059F;
	Thu,  7 Sep 2023 23:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CF876059F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDA3CC0039;
	Thu,  7 Sep 2023 23:02:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94924C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 23:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4516A41A05
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 23:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4516A41A05
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Lwk13P6m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TtHGFNZ8Vjdg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 23:02:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9301F41953
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Sep 2023 23:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9301F41953
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zokx/VU556Zti0FdPDI+Ktg4KKi/hznrzlHrDo06oW8LX/7ZfmOBJnXCsapLuYb9b36EfsqYwRRTet2kgxoS90Zzl3zDEo0civNZf2QFy5kdCId2VHSjE/sMbJjzpAo5KVWN+dti+ZbUU5/wEOwCP1FpuIU8Pq3ZdMm9CAxwasoHnrJ419FZRG25jM+ARnJuZcbIj/TrvS55OHTks76p4Vvz0xdAlroOOkeCGzTz2dhJ8Yc0gehGvqXHxcja3L+fwlwpcXg1A2hV4xzSnsaRMHtOz8Q0C4UJSdwTUGn6+oKiodjSbMuYuQiIJ9EUk+dYAU69v8Gh8vgi8TnUBDgawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nJqGfjaSFm/kmP5MlA7Y1xw8FqIycMk7c8sSa9vw88=;
 b=DgTKv6XRi6rKQZkBZ4FvBQAVUdwq6lcSZoqhTlblNmeR5zPphONes4h8+Zocmua/sTo/3WLAtW4AgZagyRUgHtkMaaRVdhs8WueNWAxelPkQ7El1uj0YPYV08sLmey1wdthx0yxq5h65DE/O+Czc47G3BlTKLbVv13SkYuf2fYOWum26gB7UZQ7sdhUXudhMek65bQ/oZwyE276Sr8c85M5OIXoxiuKgJQ7TIUPlnr3mcq/uw4skKlNUD7OacjTXryWMV+emIRfm4UbRPHl7E7dXFodNFvwzrmooP1W4Istn1o53BS4lbyuVY/UCfGWjKmPEzFWWcMBgCa1SRY6ARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nJqGfjaSFm/kmP5MlA7Y1xw8FqIycMk7c8sSa9vw88=;
 b=Lwk13P6myPc0WildK8oWWT6NNCQrgMKWQBhClFVjFesImyOgKFP3RxeHopVl4RXrbUEBiNcQ1YKmxthuXTIPfDc/Rc2i2EboPFuYK3TvdHBL7/MVG1Uhz05KI9y9Roy/k61IJA14NQHX68fba36uB73JkyDocbp2e2NNSumwHXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Thu, 7 Sep 2023 23:02:06 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::5c9:9a26:e051:ddd2%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 23:02:06 +0000
Message-ID: <71c187a5-337c-46e9-8d88-35d288795fc8@amd.com>
Date: Thu, 7 Sep 2023 16:02:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: consume device_features parameter
To: Si-Wei Liu <si-wei.liu@oracle.com>, dsahern@kernel.org,
 stephen@networkplumber.org
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
 <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
Content-Language: en-US
In-Reply-To: <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: bee4d1ed-43c4-4eb0-75bc-08dbaff674ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dW24+3jv43Ggwc0AiY5MHGVsMBt6yt8ikI5vfW4IN7gTcQ//pB1phVlI7zCr6B8xC8kCghT36HzFQ4Rsth5bl3YxkuSp+pcWwbrKaHodSGPQKPet/+X+oUpnv9sW7CA0rt0AmS+p2dFyoVyIGhKB4R6BOJZ4LOMpoh+c0MBFlRXJnAPJ/ONQU/O9bcZQ0oYjNWl70vh7H9Z0uZpt0ezm4s4sTLm+14xZ/ZzErEZFLfie8kgdnxCCU/VefFWmwEtKIFJVl3bCRs+9lW0NNS7IKUl1Eo6WeqxlreSEDwKbUx+sbjG10kqnuLmO5ZPvTOL0695vxLHHDkOvOuini73GtKUCNst7t06t7FvN5TvnKRDR20cL4VikEdEwxv/vm1Y2atYdsZVWT+rV8JzIqxPQaAX6HOtNGBhGWKs6UPC/03n9LT97w9mrdX+KBRsT82WjTQOoQkvm6dndwOwV+53R6/uzRuA29p+1XQMgw0hfvF055LPf8mxbgj2w6nSJaputq/RjILKvOnh1o+EDvs9k+2AdB7B9KNUKpr/xfIpX3xyTJgP4Tm81/q9QQcLIRPI+485RlimdyfgwrQX2QJg2tPwHiSYOTsQaylJalUDsnYbzTJl/TxGFmyRTMFyitd/XU0FplSHvYsFm1U5Gr7Npg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(186009)(1800799009)(451199024)(6486002)(6506007)(53546011)(966005)(478600001)(2616005)(26005)(2906002)(66946007)(316002)(41300700001)(66556008)(66476007)(8936002)(5660300002)(4326008)(8676002)(6512007)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhaOFJBaTlsZHV0KzBGS3orNmkrSnFXTkIyT1M5d3VyVXZ5aVk1UkxmZjBj?=
 =?utf-8?B?RDVIcEFKT0swWWRrYUp2RnUwSkNWNWJJeDZ4bmtlR0oxdHdOYWI1WC9McHY1?=
 =?utf-8?B?RmtjLzhqUFpZc3lvSUZOQWg0am9BVE5SS0Qzd01memxkaXY1dWlUeTBPaEdx?=
 =?utf-8?B?ZG5aRGtLMGRGTjNyd2ZyWG10LzczMlNOakg0a2QzZGhURXNRT3hONGxOLzIy?=
 =?utf-8?B?WC9Ka0ZrUmR2WmR6dUhhQWxXVVpZbm9tZWE3elFTdVJqS0RuTmlzYW0zNVNt?=
 =?utf-8?B?UlZ1S0FhdnBYb0IrMnY1QXpYQVZOQUpOUzk3aFN0SDBXbVlwb2pEdENTVFU4?=
 =?utf-8?B?WFk3dnBPZWtqaGM3UnpocUNxaDNsa3p2S3lranhGa1JCWUVCbG1wbmJwb3Bl?=
 =?utf-8?B?eWlTTFk5SExzd3NOa0p3OGpKZ1ovdGdCNmtlb2tQcVFPSWxhZkE0aTNIUGlB?=
 =?utf-8?B?ek1XTFhXMTc2VXdHRzVqQWpYbktzRVk0Mk9wbitqaHV6cW1wTlBqbTRXVldJ?=
 =?utf-8?B?LzNqbW9tUjF0VkJ3bXVNUzFTZjBOb3dtYk1ZRXM4NWNlVXZvU3F4KzAwcnZK?=
 =?utf-8?B?NVZwQzNadHRmb2xneUo3c1BXQ0JBci92WWNGU2tZUkJYaG9YY0U2ODgraUpG?=
 =?utf-8?B?Nk5qK2RpUVNTb1hDVUJpb2J6OVY0dGE4ZVhGaHFmVFZyWWZna09jTVZQWTEz?=
 =?utf-8?B?MmNuQlJHaG5yM3VmVk43aXk3NUk4MWcwNkZIWktwaUFKbFlZK1pmSnlOd1ZU?=
 =?utf-8?B?L2Z5d3Bpb01MeUZqdjRGc0FWY3Z0dmdQWCtoQTZzVHU2THlJNzhEeWUzYk9W?=
 =?utf-8?B?ODhhRnNtMGV2aXRrdEVrcEJ6aW43VmZPVlhTRFdlbFJOaUdpb3M5NGJ5R1pT?=
 =?utf-8?B?L0pCNnUwRW5DR2w4bHpFTlM4cXptcWpiMGhRc1FaTVRmVk1vcDIyNWdHWE8v?=
 =?utf-8?B?RVNpVlcwN2lwUnJuUFRGQkpxMEJLWlhmNTBjaXNuanpaSjF5WWxHNzErazNY?=
 =?utf-8?B?OFNoVk5ZeExsSXdxc0lGZDdkYXhTQ3dOdk8zdDI5dzFYNTdSV3NraktydlpH?=
 =?utf-8?B?cm1lU3dXWHIxbG9YcVVtNEpxSTU4U3ZNL3RpQnFNUDh5ZzgzS1d1RzJwbjd3?=
 =?utf-8?B?dndBNkNuY25iRXNoY3NzQWFETVZJVGpkb2Erd0M5YmF1d0tocmJqcmFsTnlL?=
 =?utf-8?B?WGlESm1EZW9LT21kTkxKSTN2d3VCK0lNMmZVcmtoazJLQ3FYUlE0cGptNndJ?=
 =?utf-8?B?SGJ1c1BQVHJ6Q2RkajZkTnNXUDkwcnEvbWdnQzFRdUg3Q3ZydE5VWGtSMVNt?=
 =?utf-8?B?cys0dEp2TFNxbzlOSTloQ095TVM5SVpIT3ppanRsejF1TStvSVpnR0JDc2tX?=
 =?utf-8?B?cFJqZUVJd0tDV1hST09keVp3L1RtNU5SMXRrOTlOVlMrQ1R6cUc1VWpEeVUr?=
 =?utf-8?B?S1F6aXU3SG9OQU5MekdFTFFNc3B6blB2Y1F2QnFjWXhYOTNsclYwNDFFRkQ2?=
 =?utf-8?B?MFdURDlkZE4vL25ZNFZpSXdvNXplSkZuMlJnVDdKRXBHVEZ3Vm5sWEV6b1pi?=
 =?utf-8?B?TkRDTm1uWnpXMW1iTU5hZ2xwTWVyUm5qUHRjZVhGSTVYaEc3UnJwUjVsNndC?=
 =?utf-8?B?RS9BM0VIb0tXUEczWHBXN1RmQVphenlvZHZvVGlNSXRaaDRFN3RjWlJZYWZ5?=
 =?utf-8?B?VFVUR0tUcWM3TG1qdmNubEVTV1RXcEpvZ2NkMWpKWGx3a3BkWFl6OURIVG42?=
 =?utf-8?B?aW9qQ3VpYXJ6aE15YmZyWjVsTkRBT1p0SUFKKzlOdk16UlN3VzhhVDZMcjRC?=
 =?utf-8?B?RDk0bVFxREhjQmdYcE91a2xkS3k5dUwrR09KUkJyWDRoL2lxb0VoWkY0emht?=
 =?utf-8?B?SHRqeFdHVUdJOGV0S0poUnBWaWtaSlp5ZzV5YmZxbUtKbVdIVmtJbWtWTXZN?=
 =?utf-8?B?MmhWWkw5OGZoMWROcHFCNUtQUVRQNzdodEw4ekhCV1VpWlNUVUVscE91TlBO?=
 =?utf-8?B?YjBJcldILy9TM2czUlVFeVFRMG1Xam55K0Y1RFNsb01YYWx4OFVRTnAvTmZP?=
 =?utf-8?B?SjJYZjMrNzEra21aVURYYlE4VVIxdmozdzdHbWZDZ1VuZmxMSlRFMEhZeFVM?=
 =?utf-8?Q?Bi05LR0PQHtjzJy9cI27uTNkO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee4d1ed-43c4-4eb0-75bc-08dbaff674ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:02:06.3298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQqZxwyVLwLwVCn8PJnfrchfgqx0QOwiMqGGDqiN8+i4S/1pOfhzzICWoht3W98hZttmOFgThPbvtXArGHHhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
Cc: mst@redhat.com, allen.hubbe@amd.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io
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
From: "Nelson,
 Shannon via Virtualization" <virtualization@lists.linux-foundation.org>
Reply-To: "Nelson, Shannon" <shannon.nelson@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gOS83LzIwMjMgMTo0MSBQTSwgU2ktV2VpIExpdSB3cm90ZToKPiAKPiBIaSBEYXZpZCwKPiAK
PiBXaHkgdGhpcyBwYXRjaCBkb2Vzbid0IGdldCBwaWNrZWQgaW4gdGhlIGxhc3QgNCBtb250aHM/
IE1heWJlIHRoZQo+IHN1YmplY3QgaXMgbm90IGNsZWFyLCBidXQgdGhpcyBpcyBhbiBpcHJvdXRl
MiBwYXRjaC4gV291bGQgaXQgYmUKPiBwb3NzaWJsZSB0byBtZXJnZSBhdCB5b3VyIGVhcmxpZXN0
IGNvbnZlbmllbmNlPwo+IAo+IFBTLCBhZGRpbmcgbXkgUi1iIHRvIHRoZSBwYXRjaC4KCk1heWJl
IEkgYWltZWQgdGhpcyBhdCB0aGUgd3JvbmcgcGVyc29uPyAgSSBzZWUgdGhhdCBTdGVwaGVuIGp1
c3QgCmFubm91bmNlZCB0aGUgbGF0ZXN0IGlwcm91dGUyCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L25ldGRldi8yMDIzMDkwNjA5MzkxOC4zOTRhMWIxZEBoZXJtZXMubG9jYWwvCgpJIHByb2JhYmx5
IGFsc28gc2hvdWxkIGhhdmUgbWFkZSBzdXJlIHRoYXQgImlwcm91dGUyIiB3YXMgaW4gdGhlIHN1
YmplY3QgCnByZWZpeC4KCkhpIFN0ZXBoZW4sIHBlcmhhcHMgeW91IGNhbiBoZWxwIHdpdGggdGhp
cz8KClRoYW5rcywKc2xuCgoKPiAKPiBUaGFua3MsCj4gLVNpd2VpCj4gCj4gCj4gT24gU2F0LCBN
YXkgMTMsIDIwMjMgYXQgMTI6NDLigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25A
YW1kLmNvbT4KPiB3cm90ZToKPiAgPgo+ICA+IEZyb206IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJi
ZUBhbWQuY29tPgo+ICA+Cj4gID4gQ29uc3VtZSB0aGUgcGFyYW1ldGVyIHRvIGRldmljZV9mZWF0
dXJlcyB3aGVuIHBhcnNpbmcgY29tbWFuZCBsaW5lCj4gID4gb3B0aW9ucy7CoCBPdGhlcndpc2Ug
dGhlIHBhcmFtZXRlciBtYXkgYmUgdXNlZCBhZ2FpbiBhcyBhbiBvcHRpb24gbmFtZS4KPiAgPgo+
ICA+wqAgIyB2ZHBhIGRldiBhZGQgLi4uIGRldmljZV9mZWF0dXJlcyAweGRlYWRiZWVmIG1hYyAw
MDoxMToyMjozMzo0NDo1NQo+ICA+wqAgVW5rbm93biBvcHRpb24gIjB4ZGVhZGJlZWYiCj4gID4K
PiAgPiBGaXhlczogYTQ0NDJjZTU4ZWJiICgidmRwYTogYWxsb3cgcHJvdmlzaW9uaW5nIGRldmlj
ZSBmZWF0dXJlcyIpCj4gID4gU2lnbmVkLW9mZi1ieTogQWxsZW4gSHViYmUgPGFsbGVuLmh1YmJl
QGFtZC5jb20+Cj4gID4gUmV2aWV3ZWQtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNv
bkBhbWQuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNs
ZS5jb20+Cj4gCj4gID4gLS0tCj4gID7CoCB2ZHBhL3ZkcGEuYyB8IDIgKysKPiAgPsKgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAgPgo+ICA+IGRpZmYgLS1naXQgYS92ZHBhL3Zk
cGEuYyBiL3ZkcGEvdmRwYS5jCj4gID4gaW5kZXggMjc2NDdkNzNkNDk4Li44YTJmY2E4NjQ3YjYg
MTAwNjQ0Cj4gID4gLS0tIGEvdmRwYS92ZHBhLmMKPiAgPiArKysgYi92ZHBhL3ZkcGEuYwo+ICA+
IEBAIC0zNTMsNiArMzUzLDggQEAgc3RhdGljIGludCB2ZHBhX2FyZ3ZfcGFyc2Uoc3RydWN0IHZk
cGEgKnZkcGEsIGludAo+IGFyZ2MsIGNoYXIgKiphcmd2LAo+ICA+ICZvcHRzLT5kZXZpY2VfZmVh
dHVyZXMpOwo+ICA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChlcnIpCj4gID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4gID4gKwo+ICA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBORVhUX0FSR19GV0QoKTsKPiAg
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvX2ZvdW5k
IHw9IFZEUEFfT1BUX1ZERVZfRkVBVFVSRVM7Cj4gID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9IGVsc2Ugewo+ICA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGZwcmludGYoc3RkZXJyLCAiVW5rbm93biBvcHRpb24gXCIlc1wiXG4iLAo+
ICphcmd2KTsKPiAgPiAtLQo+ICA+IDIuMTcuMQo+ICA+Cj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
