Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A48C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 11:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2557461691;
	Wed, 10 May 2023 11:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2557461691
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EuTW4/fE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id az8vt-IN2srx; Wed, 10 May 2023 11:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 16C1260BD5;
	Wed, 10 May 2023 11:54:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16C1260BD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E67CDC0037;
	Wed, 10 May 2023 11:54:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69E47C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 11:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27C7E60BE8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 11:54:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27C7E60BE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLo2AYU0ZeiI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 11:54:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E057360BD5
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E057360BD5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 11:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Usz6mtHTTIbaXQ5UYQGsmQqdmuqQgPv/AWz/ljr1R7EibBm9fkogL6c0mPOFguVHQC8t47QgKLEJsJHLx99t8KVkFd0xFrRyJAV8Iksis3ryD5Ve9uyW8w6ib+YQnVhGiDRfOhpXc4LM7ghaUKGebEiskwEkfQJ5wGlgsHMCSNMWNuLZMvg8WdtR2m1b+3UFu7LJQvslstb2a7pfT+qCbmO1cQx4g9ld2Mz7R2+zWvPAu2ApxIYvmd86OMca+DkqRKhHDdazowMAzI4eZA6b9j2psYN1/nETNgrA4tfEE0f0ZaQf+GENV2MCOzPRPxyDgv+dz/IiTr0DUe2WrbV7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24YTFnAawxJmC8TNFkdBYfeoT+QrdwGEaf6CrOD04j8=;
 b=VaGx2NhipLbFjDSh6fUzQftveuaFoAmdrFZYdO3aDn2dqZCFvwSBFoQ2gB8hhsZp7lL9ej140Y/2WfC4b4ZwcnsVmVF2Uzr6bWSJCJTFCwzyscHcktby5x4bpeTW+EIVG6YGNb2jQAVJ4IEPk2trgYwhuhFBcA5JoVF2Y89h5xG+FpYzMcUAJ6uzPzUvxsHt4UfnmaLl4I6EDYyFZ3Ye5/umQesm9B6mVUDUxdcZ3k800NFM7uXmZxu1OScAkc7OfWvgWo2FEfhMRb4+wcmUE+UNX9rmueJbogm85tIR7qLNpBzbgkw2ZHJZkXYFYCtaLMX0kZssHbNN9BqY1UKauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24YTFnAawxJmC8TNFkdBYfeoT+QrdwGEaf6CrOD04j8=;
 b=EuTW4/fEyKxz2nWCbbL9GTvtsvXTP5CWV+0mKRBwKZQccaAglZS3TLhdKla32rFD72wO+lHH98DYnsBg9uc4iDx61B6YlUC8qAuMZ9gasFDf68k6ZCbT5f2eR8o8fTi5ANReqdOFAtWaqyJgxj7825eLGxkIIOAYYxlURa4k/A6UtcRkIiuMYBGjUtX7nWWqS8fdzset07/OsEy7bz5F1fklzSG66ER3MjutMVHF1UdUwqtGg5Ge5gTanQ9XkcugVNMfCm3f0qDuhIgxjw6exdUEP6IA/Gk2iEFTxdEkUwxl674c6akRUmyFyRrRi4Mkg8LC4F4L2fnZ3rjsvE6rRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 11:54:52 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:54:52 +0000
Message-ID: <17f9d4ef-9493-3fcd-65ff-beb92f99f854@nvidia.com>
Date: Wed, 10 May 2023 07:54:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v3] virtio_net: Fix error unwinding of XDP
 initialization
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230503003525.48590-1-feliu@nvidia.com>
 <1683340417.612963-3-xuanzhuo@linux.alibaba.com>
 <559ad341-2278-5fad-6805-c7f632e9894e@nvidia.com>
 <1683510351.569717-1-xuanzhuo@linux.alibaba.com>
 <c2c2bfed-bdf1-f517-559c-f51c9ca1807a@nvidia.com>
 <1683596602.483001-1-xuanzhuo@linux.alibaba.com>
 <a13a2d3f-e76e-b6a6-3d30-d5534e2fa917@redhat.com>
In-Reply-To: <a13a2d3f-e76e-b6a6-3d30-d5534e2fa917@redhat.com>
X-ClientProxiedBy: SA0PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:806:d3::34) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abe5c1d-240e-453e-4d87-08db514d5d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kn48QLzNiDu4trRAF6XG7SBe+EPYfdKKJDf1YIA9jqL5Y0V6qAEcTK/gKgdRI2Yj2IjW2vnKTMDRuxJCYC6sLERRIXbEwoZuwA4h47dHVXueeorKfNbbjiELlDmsucPuCV7N/KXi5CFJsaXiRvLRgHvfJyhXACyM8XtJl18DdQEJM4aduvULKGOZjZgOMHFE4Qh2+CNwhyiiQoZbxVMeQnYSL1g/KjhCp43Xkxy7XUWUnQpQft+R8bk8xQo644mmhsaulGqePCxlgezWE0ej2qhH7xQsB/0HaHUZnig4oT3u4RnHeIQv2QEARPpbLK/xelCLObU8Qg5q1xKJhc5mZC6rWM94aBMBCXlpH0p9IYpUoy3A/YcP76SKZ4WkP+NGSArWiCXg/NfInkarmN86TG8S37cKloZ1tdtElaEe7Dxz5DEEPQh0ONYV4eZvwln88TKtqdLibrtqlhkTg9pKivecT75ej88fCrGUtxZ2ikdcktPqvTV27KNFttv8zYfsLU7s36d+aq8Vxz4GdgqmZ74ECvabUFOyzWI2PI9jOHxhu8/mcPg3HCnMsP7j1jGqbhNwBFKVLKgmfMTjILxB3enGCMGnoGRkEGnXHUzcVeIKbxoKk62CD6kP1/rXXoB2yz0vqo760yu2y/Ol0FA20w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(2906002)(31686004)(41300700001)(8676002)(316002)(8936002)(478600001)(66476007)(5660300002)(54906003)(4326008)(110136005)(6666004)(66556008)(66946007)(6486002)(6512007)(6506007)(26005)(186003)(2616005)(36756003)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRvVzAwTURwZ2dyTURVMmZ4Rmg5em5uVmFEMHBpT2Q0TiszY0tmRWErVEpR?=
 =?utf-8?B?UG80RkZNVm9lc0IyUGFwczJhY3dTWVI5dHE0eXpHMGpmM2gvcTE4U093UFo0?=
 =?utf-8?B?VGNsSTYva25WbWpDL3U4ckpnQ1VLeS93d2NJdlNEcU1zL09WNzNVQVlSYmI2?=
 =?utf-8?B?M2U4ME95bGcwQW4vbFNicEdIQW5iNGJweS8yYmhxa1JHSnZWdnY1YkU5TGEy?=
 =?utf-8?B?TGpnYjZOSVVMRG1JN2xBQWpLMjkxaVRUTnBIMndSQ2t0SXFpSlVaQnBaN1Ns?=
 =?utf-8?B?RDdJYXF0VGVQbkIxWVMvWHdiRkswZFdIS21SMXY0UVJYQ0R0dlV3Q1hyQVBG?=
 =?utf-8?B?SFBlbVJJWU1oS1F4ZFY5REQyUUd4eElrUHRLdlZpenBmZjJNeEc2YWFvdmdw?=
 =?utf-8?B?bjRZQU9WMVVZbVZwcVpjV3JicXRvRFBpV09SN3lqVUpTcko5VHBNbTlMckFW?=
 =?utf-8?B?aFo1WkpKZzhYSlFLcWJEdkQxaE9DWVY5VElCM2hkN0NyTWNQcmxhOVQyRER2?=
 =?utf-8?B?Uzl6OXFxZVlpSm9XbE42VGNWRmlENkxQSFpGS2ZmOURQalhLVGV0Qkg2Unhs?=
 =?utf-8?B?U2hQQmRJc0ZOU0lhTmtrdHBHRVFELyttNkF5SUl4NUZzUHpXQ1pyYS9CRjI4?=
 =?utf-8?B?RXNJLytnZEp0cWNlYjVHVEhIYWdCZVlRQTR3TTVDTUxXcUVVRXRhOXp6NU5U?=
 =?utf-8?B?cEFMZkxYT3Z4alJOSGZId1RFMkwyOUtNdlF5ZWcwR3c1Y1VjbVlib0lwbVZ0?=
 =?utf-8?B?blpyczNjUzJkY1NFMWJ0RUVMbHF0OEgwTkdlNUVwRXNScTAxcWlqZXlTREUr?=
 =?utf-8?B?OHdhRlNPLzJ6dDdpQ0VRQVhNazFsTFg3d1NqNFhSNkI4amdnZnZWb3RKcFFQ?=
 =?utf-8?B?WVJZSmRDZXlEVkNZOEFpb2NPaEEwanU2YmJneEkrTTlsNU1FNkJUbm5LSEQ0?=
 =?utf-8?B?TWpYRUdVdkJCZTBiOTZoazVQWS9IZ1N4bHZIVFlWWjI1dnk4OU5tVzlIVG9B?=
 =?utf-8?B?OHpQVXQ1SVoxaFZsS1dBeG9ESlFZV3FNMm9HTVZaT3doTnRnakJQc29tcHNZ?=
 =?utf-8?B?N2lWZk5zOUFZcTVCZnYrdW91S2gzN2tkN2hLNExBQTlhdnNkdTlyYXFjZG13?=
 =?utf-8?B?WElQRlF2aWVtU2RHUy9WOFV4QjN0eVJTMDgzcXBzdWF3TG1Jdk05OC83VU8v?=
 =?utf-8?B?MFpGYWJOMERlQUZJOHhGSGJQUm9DSFFvY1lxMER1QmM5eHROdFdIRDlrK1I2?=
 =?utf-8?B?ZnFrWFNnak9lL3hqVTkzRXFmM3J0dWppVm5YN0kvU0dkazdZR1FZTUl5SldW?=
 =?utf-8?B?OU5WZFRxeGdwL010MS84M1J3Rng4RFJ0Q0lVUUdSRzRudTk2aUFrTURhTHJo?=
 =?utf-8?B?K0VXbDFWNzdQODZMVkVmdy9LT2RHb3BsN3VtbVU3MWt4NSszMkZyZ2NmaENM?=
 =?utf-8?B?VHBLdFl6YWl0dDdxZHlMSGtwbWtJaWxhekM4Ty9MV0s1RWF2K0pDZWgzV2Nh?=
 =?utf-8?B?RWpRNlE4RUhXV3dBU2ZQMCs1RExpQWowdjhUZzRIbFc3cEVjV3R3bXVXUkxO?=
 =?utf-8?B?T29xMXowK0JEMnZxbmdYMDFLd3hzSjBxaTNVUnlFTW5zOGdQUXoxenVnQ3FN?=
 =?utf-8?B?WnNZZjVtQVJtbjAwTS80THZML1pMT0V4S3JRUWJxOERwSW1wbTN2MndQRzY1?=
 =?utf-8?B?RjcyL3g2V3RrL1RJblp0c1ZUVjRLQ3NDa2R0TUVKZzBPV24yNUkwbWl1dlFv?=
 =?utf-8?B?Wmk1V0ZCeTRyZjVjbFc2VjhjbGxNNCt5SGlraTZLVlJjak1Yb3ZKT2NlL2dU?=
 =?utf-8?B?YVh2Z3dvM0VxbFNTeGJOZWFzam5oQnptdXpuZ05XdU82U29jcjFldGplNjlp?=
 =?utf-8?B?MHFpdWpOWHFQU2JxcWFBRGwvWmZiVDVka2FsQ3lSeWMzYnFtRE1IMWljdzdr?=
 =?utf-8?B?Z2RINldIaU5VRm9xdW5CeTFJL01ERWpNSW5zZ1FLN01LZmltejBNL29nektJ?=
 =?utf-8?B?dHd2dWR1eU1GZmpESVpPMllHSCtGWUpycG5vRktMdE1CT2hURTJsdXJuTXMz?=
 =?utf-8?B?T3k2a0lGY1RuQVVxYXpxakRaK1hSRTVZUWFBSmZ3Q3AzU2poVVBJakFwbFlN?=
 =?utf-8?Q?bTrwbCCHvzckWYn3MIz6IGhGY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe5c1d-240e-453e-4d87-08db514d5d50
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:54:52.4656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6dC4+Vq6IABLEHx4go4shDcshEupPOPgkMaq2dD+haG4Kgwthm6ORTxgJA/Dx7OOpK3yxcWTzu7u0dVjaSi9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

CgpPbiAyMDIzLTA1LTEwIGEubS4xOjAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gCj4gCj4g5Zyo
IDIwMjMvNS85IDA5OjQzLCBYdWFuIFpodW8g5YaZ6YGTOgo+PiBPbiBNb24sIDggTWF5IDIwMjMg
MTE6MDA6MTAgLTA0MDAsIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPiB3cm90ZToKPj4+Cj4+
PiBPbiAyMDIzLTA1LTA3IHAubS45OjQ1LCBYdWFuIFpodW8gd3JvdGU6Cj4+Pj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4+Pgo+Pj4+
Cj4+Pj4gT24gU2F0LCA2IE1heSAyMDIzIDA4OjA4OjAyIC0wNDAwLCBGZW5nIExpdSA8ZmVsaXVA
bnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjMtMDUtMDUgcC5tLjEwOjMzLCBY
dWFuIFpodW8gd3JvdGU6Cj4+Pj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Blbmlu
ZyBsaW5rcyBvciBhdHRhY2htZW50cwo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBPbiBUdWUsIDIgTWF5
IDIwMjMgMjA6MzU6MjUgLTA0MDAsIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPiB3cm90ZToK
Pj4+Pj4+PiBXaGVuIGluaXRpYWxpemluZyBYRFAgaW4gdmlydG5ldF9vcGVuKCksIHNvbWUgcnEg
eGRwIGluaXRpYWxpemF0aW9uCj4+Pj4+Pj4gbWF5IGhpdCBhbiBlcnJvciBjYXVzaW5nIG5ldCBk
ZXZpY2Ugb3BlbiBmYWlsZWQuIEhvd2V2ZXIsIHByZXZpb3VzCj4+Pj4+Pj4gcnFzIGhhdmUgYWxy
ZWFkeSBpbml0aWFsaXplZCBYRFAgYW5kIGVuYWJsZWQgTkFQSSwgd2hpY2ggaXMgbm90IHRoZQo+
Pj4+Pj4+IGV4cGVjdGVkIGJlaGF2aW9yLiBOZWVkIHRvIHJvbGwgYmFjayB0aGUgcHJldmlvdXMg
cnEgaW5pdGlhbGl6YXRpb24KPj4+Pj4+PiB0byBhdm9pZCBsZWFrcyBpbiBlcnJvciB1bndpbmRp
bmcgb2YgaW5pdCBjb2RlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQWxzbyBleHRyYWN0IGEgaGVscGVyIGZ1
bmN0aW9uIG9mIGRpc2FibGUgcXVldWUgcGFpcnMsIGFuZCB1c2UgbmV3bHkKPj4+Pj4+PiBpbnRy
b2R1Y2VkIGhlbHBlciBmdW5jdGlvbiBpbiBlcnJvciB1bndpbmRpbmcgYW5kIHZpcnRuZXRfY2xv
c2U7Cj4+Pj4+Pj4KPj4+Pj4+PiBJc3N1ZTogMzM4MzAzOAo+Pj4+Pj4+IEZpeGVzOiA3NTRiOGEy
MWE5NmQgKCJ2aXJ0aW9fbmV0OiBzZXR1cCB4ZHBfcnhxX2luZm8iKQo+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPgo+Pj4+Pj4+IFJldmlld2VkLWJ5OiBX
aWxsaWFtIFR1IDx3aXR1QG52aWRpYS5jb20+Cj4+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBh
bmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KPj4+Pj4+PiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFu
IDxzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tPgo+Pj4+Pj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+Pj4+Pj4+IENoYW5nZS1JZDogSWI0YzZhOTdjYjdi
ODM3Y2ZhNDg0YzU5M2RkNDNhNDM1YzQ3ZWE2OGYKPj4+Pj4+PiAtLS0KPj4+Pj4+PiDCoMKgwqAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tCj4+Pj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+PiBpbmRleCA4ZDgwMzg1
MzhmYzQuLjM3MzdjZjEyMGNiNyAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+PiBA
QCAtMTg2OCw2ICsxODY4LDEzIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsKHN0cnVjdCBuYXBp
X3N0cnVjdCAKPj4+Pj4+PiAqbmFwaSwgaW50IGJ1ZGdldCkKPj4+Pj4+PiDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZWNlaXZlZDsKPj4+Pj4+PiDCoMKgwqAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gK3N0
YXRpYyB2b2lkIHZpcnRuZXRfZGlzYWJsZV9xcChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgaW50
IAo+Pj4+Pj4+IHFwX2luZGV4KQo+Pj4+Pj4+ICt7Cj4+Pj4+Pj4gK8KgwqDCoMKgIHZpcnRuZXRf
bmFwaV90eF9kaXNhYmxlKCZ2aS0+c3FbcXBfaW5kZXhdLm5hcGkpOwo+Pj4+Pj4+ICvCoMKgwqDC
oCBuYXBpX2Rpc2FibGUoJnZpLT5ycVtxcF9pbmRleF0ubmFwaSk7Cj4+Pj4+Pj4gK8KgwqDCoMKg
IHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW3FwX2luZGV4XS54ZHBfcnhxKTsKPj4+Pj4+PiAr
fQo+Pj4+Pj4+ICsKPj4+Pj4+PiDCoMKgwqAgc3RhdGljIGludCB2aXJ0bmV0X29wZW4oc3RydWN0
IG5ldF9kZXZpY2UgKmRldikKPj4+Pj4+PiDCoMKgwqAgewo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+Pj4+Pj4+IEBA
IC0xODgzLDIwICsxODkwLDI2IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9vcGVuKHN0cnVjdCBuZXRf
ZGV2aWNlIAo+Pj4+Pj4+ICpkZXYpCj4+Pj4+Pj4KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlcnIgPSB4ZHBfcnhxX2luZm9fcmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSwg
ZGV2LCAKPj4+Pj4+PiBpLCB2aS0+cnFbaV0ubmFwaS5uYXBpX2lkKTsKPj4+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyIDwgMCkKPj4+Pj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3hkcF9pbmZvX3Jl
ZzsKPj4+Pj4+Pgo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9
IAo+Pj4+Pj4+IHhkcF9yeHFfaW5mb19yZWdfbWVtX21vZGVsKCZ2aS0+cnFbaV0ueGRwX3J4cSwK
Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAo+Pj4+Pj4+IE1FTV9UWVBFX1BBR0VfU0hBUkVELCBOVUxMKTsKPj4+Pj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKSB7Cj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFbaV0ueGRw
X3J4cSk7Cj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGVycjsKPj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKQo+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3hkcF9yZWdfbWVtX21vZGVs
Owo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydG5l
dF9uYXBpX2VuYWJsZSh2aS0+cnFbaV0udnEsICZ2aS0+cnFbaV0ubmFwaSk7Cj4+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwg
dmktPnNxW2ldLnZxLCAKPj4+Pj4+PiAmdmktPnNxW2ldLm5hcGkpOwo+Pj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+
Pj4+PiArCj4+Pj4+Pj4gK2Vycl94ZHBfcmVnX21lbV9tb2RlbDoKPj4+Pj4+PiArwqDCoMKgwqAg
eGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSk7Cj4+Pj4+Pj4gK2Vycl94ZHBf
aW5mb19yZWc6Cj4+Pj4+Pj4gK8KgwqDCoMKgIGZvciAoaSA9IGkgLSAxOyBpID49IDA7IGktLSkK
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZpcnRuZXRfZGlzYWJsZV9xcCh2aSwg
aSk7Cj4+Pj4+Pgo+Pj4+Pj4gSSB3b3VsZCB0byBrbm93IHNob3VsZCB3ZSBoYW5kbGUgZm9yIHRo
ZXNlOgo+Pj4+Pj4KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRpc2FibGVfZGVsYXllZF9y
ZWZpbGwodmkpOwo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FuY2VsX2RlbGF5ZWRfd29y
a19zeW5jKCZ2aS0+cmVmaWxsKTsKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gTWF5YmUgd2Ugc2hvdWxk
IGNhbGwgdmlydG5ldF9jbG9zZSgpIHdpdGggImkiIGRpcmVjdGx5Lgo+Pj4+Pj4KPj4+Pj4+IFRo
YW5rcy4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+PiBDYW7igJl0IHVzZSBpIGRpcmVjdGx5IGhlcmUsIGJl
Y2F1c2UgaWYgeGRwX3J4cV9pbmZvX3JlZyBmYWlscywgbmFwaSBoYXMKPj4+Pj4gbm90IGJlZW4g
ZW5hYmxlZCBmb3IgY3VycmVudCBxcCB5ZXQsIEkgc2hvdWxkIHJvbGwgYmFjayBmcm9tIHRoZSBx
dWV1ZQo+Pj4+PiBwYWlycyB3aGVyZSBuYXBpIHdhcyBlbmFibGVkIGJlZm9yZShpLS0pLCBvdGhl
cndpc2UgaXQgd2lsbCBoYW5nIGF0IAo+Pj4+PiBuYXBpCj4+Pj4+IGRpc2FibGUgYXBpCj4+Pj4g
VGhpcyBpcyBub3QgdGhlIHBvaW50LCB0aGUga2V5IGlzIHdoZXRoZXIgd2Ugc2hvdWxkIGhhbmRs
ZSB3aXRoOgo+Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkaXNhYmxlX2RlbGF5ZWRf
cmVmaWxsKHZpKTsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhbmNlbF9kZWxheWVkX3dv
cmtfc3luYygmdmktPnJlZmlsbCk7Cj4+Pj4KPj4+PiBUaGFua3MuCj4+Pj4KPj4+Pgo+Pj4gT0ss
IGdldCB0aGUgcG9pbnQuIFRoYW5rcyBmb3IgeW91ciBjYXJlZnVsIHJldmlldy4gQW5kIEkgY2hl
Y2sgdGhlIGNvZGUKPj4+IGFnYWluLgo+Pj4KPj4+IFRoZXJlIGFyZSB0d28gcG9pbnRzIHRoYXQg
SSBuZWVkIHRvIGV4cGxhaW46Cj4+Pgo+Pj4gMS4gQWxsIHJlZmlsbCBkZWxheSB3b3JrIGNhbGxz
KHZpLT5yZWZpbGwsIHZpLT5yZWZpbGxfZW5hYmxlZCkgYXJlIGJhc2VkCj4+PiBvbiB0aGF0IHRo
ZSB2aXJ0aW8gaW50ZXJmYWNlIGlzIHN1Y2Nlc3NmdWxseSBvcGVuZWQsIHN1Y2ggYXMKPj4+IHZp
cnRuZXRfcmVjZWl2ZSwgdmlydG5ldF9yeF9yZXNpemUsIF92aXJ0bmV0X3NldF9xdWV1ZXMsIGV0
Yy4gSWYgdGhlcmUKPj4+IGlzIGFuIGVycm9yIGluIHRoZSB4ZHAgcmVnIGhlcmUsIGl0IHdpbGwg
bm90IHRyaWdnZXIgdGhlc2Ugc3Vic2VxdWVudAo+Pj4gZnVuY3Rpb25zLiBUaGVyZSBpcyBubyBu
ZWVkIHRvIGNhbGwgZGlzYWJsZV9kZWxheWVkX3JlZmlsbCgpIGFuZAo+Pj4gY2FuY2VsX2RlbGF5
ZWRfd29ya19zeW5jKCkuCj4+IE1heWJlIHNvbWV0aGluZyBpcyB3cm9uZy4gSSB0aGluayB0aGVz
ZSBsaW5lcyBtYXkgY2FsbCBkZWxheSB3b3JrLgo+Pgo+PiBzdGF0aWMgaW50IHZpcnRuZXRfb3Bl
bihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+PiB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+PiDCoMKgwqDCoMKgIGludCBpLCBlcnI7
Cj4+Cj4+IMKgwqDCoMKgwqAgZW5hYmxlX2RlbGF5ZWRfcmVmaWxsKHZpKTsKPj4KPj4gwqDCoMKg
wqDCoCBmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpIDwgdmktPmN1cnJfcXVldWVfcGFpcnMpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBNYWtlIHN1cmUgd2Ug
aGF2ZSBzb21lIGJ1ZmZlcnM6IGlmIG9vbSB1c2UgCj4+IHdxLiAqLwo+PiAtLT7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF0cnlfZmlsbF9yZWN2KHZpLCAmdmktPnJx
W2ldLCBHRlBfS0VSTkVMKSkKPj4gLS0+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZpLT5yZWZpbGwsIDAp
Owo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSB4ZHBfcnhxX2luZm9fcmVn
KCZ2aS0+cnFbaV0ueGRwX3J4cSwgZGV2LCBpLCAKPj4gdmktPnJxW2ldLm5hcGkubmFwaV9pZCk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0geGRwX3J4cV9pbmZvX3JlZ19tZW1fbW9kZWwoJnZp
LT5ycVtpXS54ZHBfcnhxLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
RU1fVFlQRV9QQUdFX1NIQVJFRCwgCj4+IE5VTEwpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoZXJyIDwgMCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgeGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSk7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHZpcnRuZXRfbmFwaV9lbmFibGUodmktPnJxW2ldLnZxLCAmdmktPnJxW2ldLm5hcGkpOwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aXJ0bmV0X25hcGlfdHhfZW5hYmxlKHZpLCB2aS0+
c3FbaV0udnEsICZ2aS0+c3FbaV0ubmFwaSk7Cj4+IMKgwqDCoMKgwqAgfQo+Pgo+PiDCoMKgwqDC
oMKgIHJldHVybiAwOwo+PiB9Cj4+Cj4+Cj4+IEFuZCBJIHRoaW5rLCBpZiB3ZSB2aXJ0bmV0X29w
ZW4oKSByZXR1cm4gZXJyb3IsIHRoZW4gdGhlIHN0YXR1cyBvZiAKPj4gdmlydG5ldAo+PiBzaG91
bGQgbGlrZSB0aGUgc3RhdHVzIGFmdGVyIHZpcnRuZXRfY2xvc2UoKS4KPj4KPj4gT3Igc29tZW9u
ZSBoYXMgb3RoZXIgb3Bpbmlvbi4KPiAKPiAKPiBJIGFncmVlLCB3ZSBuZWVkIHRvIGRpc2FibGUg
YW5kIHN5bmMgd2l0aCB0aGUgcmVmaWxsIHdvcmsuCj4gCj4gVGhhbmtzCj4gCj4gCk9L77yMZ290
IGl0LgpUaGFua3MgSmFzb24gJiBYdWFuCj4+Cj4+IFRoYW5rcy4KPj4KPj4+IFRoZSBsb2dpYyBo
ZXJlIGlzIGRpZmZlcmVudCBmcm9tIHRoYXQgb2YKPj4+IHZpcnRuZXRfY2xvc2UuIHZpcnRuZXRf
Y2xvc2UgaXMgYmFzZWQgb24gdGhlIHN1Y2Nlc3Mgb2YgdmlydG5ldF9vcGVuIGFuZAo+Pj4gdGhl
IHR4IGFuZCByeCBoYXMgYmVlbiBjYXJyaWVkIG91dCBub3JtYWxseS4gRm9yIGVycm9yIHVud2lu
ZGluZywgb25seQo+Pj4gZGlzYWJsZSBxcCBpcyBuZWVkZWQuIEFsc28gZW5jYXB1c2xhdGVkIGEg
aGVscGVyIGZ1bmN0aW9uIG9mIGRpc2FibGUgcXAsCj4+PiB3aGljaCBpcyB1c2VkIGluZyBlcnJv
ciB1bndpbmRpbmcgYW5kIHZpcnRuZXQgY2xvc2UKPj4+IDIuIFRoZSBjdXJyZW50IGVycm9yIHFw
LCB3aGljaCBoYXMgbm90IGVuYWJsZWQgTkFQSSwgY2FuIG9ubHkgY2FsbCB4ZHAKPj4+IHVucmVn
LCBhbmQgY2Fubm90IGNhbGwgdGhlIGludGVyZmFjZSBvZiBkaXNhYmxlIE5BUEksIG90aGVyd2lz
ZSB0aGUKPj4+IGtlcm5lbCB3aWxsIGJlIHN0dWNrLiBTbyBmb3IgaS0tIHRoZSByZWFzb24gZm9y
IGNhbGxpbmcgZGlzYWJsZSBxcCBvbgo+Pj4gdGhlIHByZXZpb3VzIHF1ZXVlCj4+Pgo+Pj4gVGhh
bmtzCj4+Pgo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+Pj4+PiDC
oMKgwqAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKgIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4
KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPj4+Pj4+PiBAQCAtMjMwNSwx
MSArMjMxOCw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAK
Pj4+Pj4+PiAqZGV2KQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgLyogTWFrZSBzdXJlIHJlZmls
bF93b3JrIGRvZXNuJ3QgcmUtZW5hYmxlIG5hcGkhICovCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oCBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnZpLT5yZWZpbGwpOwo+Pj4+Pj4+Cj4+Pj4+Pj4g
LcKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspIHsKPj4+
Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2
aS0+c3FbaV0ubmFwaSk7Cj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuYXBpX2Rp
c2FibGUoJnZpLT5ycVtpXS5uYXBpKTsKPj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW2ldLnhkcF9yeHEpOwo+Pj4+Pj4+IC3CoMKgwqDC
oCB9Cj4+Pj4+Pj4gK8KgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJz
OyBpKyspCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aXJ0bmV0X2Rpc2FibGVf
cXAodmksIGkpOwo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+
Pj4+PiDCoMKgwqAgfQo+Pj4+Pj4+IC0tIAo+Pj4+Pj4+IDIuMzcuMSAoQXBwbGUgR2l0LTEzNy4x
KQo+Pj4+Pj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
