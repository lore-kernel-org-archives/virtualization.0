Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F46C77B7C
	for <virtualization@archiver.kernel.org>; Thu,  4 May 2023 17:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39B2640C1A;
	Thu,  4 May 2023 17:46:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39B2640C1A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V97VOR3u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3VvLF60YGZqN; Thu,  4 May 2023 17:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A961740C01;
	Thu,  4 May 2023 17:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A961740C01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B889C0037;
	Thu,  4 May 2023 17:46:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA24AC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 17:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A06DA60BAC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 17:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A06DA60BAC
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=V97VOR3u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5VM_FBWyxJA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 17:46:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0270E60709
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0270E60709
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 17:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/zsecVtirusOqmGUHNfqQf0CTVCyETieC/LnJU447rqy6kE/pY7iY2XPsL00aVlfvxFhK/FuBmggNmpvK4sDS6gwCqrCFpDpEsudfilpeSx1WJDOr5tsbSFk+a5kaUwLWO7T0Y4gc9t0Mc/uC3ME7vExs6mzPBCcQ0cxw1tIr71HCXDlytG92KaKFYZLjxgDzZzu9lDe7RyPQqTYKvgC1s57+jwZnQHL55i5e0CHrJ1r/Mudvp4ArSUF1GpqhUvDmyFN9VISBOK/pV31whh8Z1UzthXtZRs1YA4nYvlgw0k5uKvcGoFOoCVYYf1dIBJx5ll9Msq7W3hFfscrYpWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9QJjqzYF/hWCPzYfBj9M93NtdrC0Qsz+j+pJGzgV4E=;
 b=II3+JKf5oYju8njHbLsUH/5vhgeqRluB4dqLgAQpiy4C2ZQ726H52P6TxXtq4YCdMhEOpjNaSO2O8szKyhe2f4nMePmlWvoPiwtIMaNlNkpzcUM4AgR8fKht+lUcpWZuh9hYarvEqDLmeV5DzigR2hurmIhtbjOK4rh/fI5D6KK7crYRGNDMrFL22CqfTNnAOWAQQ6pCnRwVW13/wR0Ipr+v+cIjcq4/FFkucs0+bbB5MIxCUl8phUFwMKrVLrfk5qXhATOia8H3OgknL6wHi7zFC3HPQOkqHcq/iyX8sXjoGm/XJ5ZG+0F3IMayAF1ukHJuah6DfJDFHx0+2Uf0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9QJjqzYF/hWCPzYfBj9M93NtdrC0Qsz+j+pJGzgV4E=;
 b=V97VOR3uZFo/CnDe3rKDRpTXQMKKembivJm22Cq+qOlAhtLP5af6wx7fh/TIayI/D3aoXb2HhoJF1mOmTPhCNwwH+ciz8kdM2ktTC9pmueWnRixFPA+Ty7hI6LkT0LCt2NNVG9st4oXabz/yCjEUaMGbTObkFhKIRzzT3uhk6H9u0DWTPIDBHOuhRza972Zir5YsD1WTqIwjmnwIP23KLRNY27Wvx9hUhLqWhZYyaMdUD68RY5Z05DQnNEFkbfVhGaG1Ij4z3gHOcVa9EGFdgmRLkmonsuXMBVgrwVNRjdK+LXZh+eH4Ed7rOhc6X3PTYw9aERSkWqiF0868JtS7cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:46:15 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 17:46:15 +0000
Message-ID: <3465c9cb-670a-cf9c-c366-50dc6c9ae930@nvidia.com>
Date: Thu, 4 May 2023 13:46:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
To: Dragos Tatulea <dtatulea@nvidia.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
 <209b4b364facec3cc26f3d12acd4b466b9278b47.camel@nvidia.com>
In-Reply-To: <209b4b364facec3cc26f3d12acd4b466b9278b47.camel@nvidia.com>
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c424bf-b2dc-43f7-eb07-08db4cc77573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN3co7dgSVdK+Qn/NBAIOCNNINIG0hT07XrJYWxbEHCx/3feMqOV3jlz7Dw7YB1hwCY6tJHbxdDKmnYYNb3MqakxjXhArPeEHbSS8904HFLQC2e6FsVKnrKeGNDF9w+sl2HL141TXl+dtQxzEQrNady/c3MH6MTp5t/yuC2e8bKvq+0A2fiyR80duo4cv6jivnoePEQfZeO/ud28sYiRMLqZYyg9+v0H+JxW8+FmKVk/wWI9GTKXz5Sgc/XKsxQkAoNfKnDca+EQRW0JmytKIjeAEzQBrRUo3TAGY8+dYgUDdLN33kdgh+vjA2PMNdemxicEiBarhIGmKkhlF6KRS57HWJM6I2Lh+Lp25KDiCbl8t3FB7lgQ7wy/rDinJmXZ+sr6e0kksB6YvQs4c20BMIGPYP8jm2BWIIQpqQbuJaDeNoYVx8TyPm+4vJX/nVBkbMrepruPpaKR7dD2JOiFI67NaNQQ6aJknTc24eMaNXSOuDWiV8yH/KfQEWRpsXfKSsUaY8fONI2Hlr1VQ/rgSTfwydYkdlpiKOLGnd31taJtaRXp/4dVut1n/rHCNcKj5XW2wPYNsvJSLoyHs+K0ovaH0TitGX175OE7OcxlDJXBSnVtjOacPWdpSPwMWtDuTdYo7gsLGaSpRdXliwqY1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6666004)(6486002)(83380400001)(6512007)(36756003)(186003)(2616005)(31696002)(38100700002)(86362001)(6506007)(26005)(5660300002)(54906003)(110136005)(2906002)(66556008)(4326008)(8676002)(66476007)(66946007)(316002)(8936002)(478600001)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRCVkRuVDl5VFc4QzJmT0RVUlorZk9BNjdyclZZY0FoNVNBZG96bTFNeUVj?=
 =?utf-8?B?Lzl4dnQwdDY0N0VKekQzcEViKzRmNHhtMm01SjhvWDhaNGVOSUdBL0c1b1pm?=
 =?utf-8?B?eVJWczVyQjk4RlJoNWlwdUxqUDhSZzFCNFR5MlJ0SGZHb2tqRmY3V2VVWkc3?=
 =?utf-8?B?eXdpaC96TzlJdUIyYkFrQ1RhaEthMWRvMWpwTW9ObWVmcHBxcFYzQjloa0w5?=
 =?utf-8?B?OS9LS0EwY29vdDVRa0JCYys3WW4zWXZyUEpFaGpreDRRZWltM2RyUU15bG1r?=
 =?utf-8?B?cnpMeWZiRC9sZjdBSEh6am5RT0ZDem5BamthOGF1clZqZmp5MFl5WXNGTEo5?=
 =?utf-8?B?YnlaaFZCdWdGL29RcklSNWwyK05VUURkTHBSUFh6M0NYVDNlOHZOU0JwR0ky?=
 =?utf-8?B?UWY0dUFySG9WRDRSSHlkM1R3eDBCS04zL0pvNXNPU0g3dzI2VXZSRHlzNzJN?=
 =?utf-8?B?OTNyblorOGZET3RWK1pRYW1pbjZMZnJ2NG9kbFIybGVPY2o0cFNMc3h0bWND?=
 =?utf-8?B?WGg3Q2gydW4rbXFOZy8xUWkvcnJXU0ZOZnlCaEtacTdzUmtSL3ROeWpTRU1p?=
 =?utf-8?B?UlJGVUw3b0p0VkZaKzF6dmJBbTNGY09Tamw4K3F5ditxNmRtWE5CbUI0c2Ex?=
 =?utf-8?B?RVltQU1OYVhFeWVPZXYxQmdNdmRxNUNGTTVDSFZTYVdTNTkxbFJ3TlJXTzdM?=
 =?utf-8?B?TXJleE1MS3FUZWE5R21KSGtITUI4Njh3YThwM2NoRThBTzNjNW15ajRTZzEr?=
 =?utf-8?B?ZmVNMXhRL05MMkdoUUtRQTBuTjRPQTZ4bUk1d1I4YzBZSElSaUMyZHNtMStL?=
 =?utf-8?B?QWJneXZNa0RVSzJTMTFSaWI3YmI0T2JmYTlpMUNCYlp6UlJUY2Rqd3pKWVhE?=
 =?utf-8?B?bVBCWldOWnFtVFphbFdzMFdpOGxkODhwVE9Zb0ZZeVppWEpZTnE1TGpWeVBU?=
 =?utf-8?B?NXRROFIreG55Q2x0cnNJU25MUkZzWGlvaVUvUXVqYlhWa0ZHZ2hRKzFwYU1s?=
 =?utf-8?B?eTVTY0R2eFlJcU1JMEMvcUdnZkpzMEg3VHovUVA4UU5TUzJKc09YbjNLa0F6?=
 =?utf-8?B?N1llbi9JQ0sxdmcyZE1nY3poeWNObnM1bU9Kb0g1YjBORFNGYTlCUGNFeG1Y?=
 =?utf-8?B?dW40TisyeGdkZ2c0VkM5eVQ5dWtsRVdpSkdWaDRwYWxvWUlLQUROSTFPZFpR?=
 =?utf-8?B?ZHFtUGR4aDZxeDg3QXN3UVFvakh1NkRNZlYrNGt5aHR1YlgwOHh6MXA4c1dy?=
 =?utf-8?B?aGdQTFdvN3RVVnB1U3J0VVk3MUliODhocU9FRDQ4SEppbHdpOFJweUpoYUtV?=
 =?utf-8?B?a0hqckNNUENxNDZxb0dWVnVXNTU0YkJPZE1hZ1hoUEtyRVlNYUN2alVVenk3?=
 =?utf-8?B?akVnOGNoZGJUTlkwanorVVlyeHRjbGJOTGxLVFlqY3UxaER2bFhNUjhmMjgr?=
 =?utf-8?B?VmJ2MXBabG5GR2RkNWREdnpIZUVrYTRFVjFGNGtLeENmNHZ6dVFaeUdMRXRr?=
 =?utf-8?B?UXZGdWw4YkkvT1QvNVJzcVpVVWpqZG9mVzZCaExVZWI0aGhjcmpsdzByaXM2?=
 =?utf-8?B?WElIS1E4cm51dFlleWxNc2xIaVY2cHlSTm9id2cwSTc1UDBFNmo4bFhZQlBp?=
 =?utf-8?B?YjBpeHJ2eFJyS0ZhUEJiQklIc2lGYUZKUUJONXFVcTRIYXc0L3F2VDVrekJM?=
 =?utf-8?B?Y2JWVUxoUmVDZit6Mjc1YU9hTGdIQWV6eUlqZ3JVTElIc3dyZitlR2RSVlFu?=
 =?utf-8?B?cmtCWUhSbGhxNVc1SWtrR3daNjRKcXZFNndLYW1jUjBDdXZOVWRRZUlJTlJ5?=
 =?utf-8?B?NjZxZFY5RTJnVWJUVVRKbEdnWnAyUjYrVDRsdFVnRkV0OE1ORkdoL2QzWVpT?=
 =?utf-8?B?eVdnWVltb2tmVEt4REpBOGxXVHlqZEUramZLb2RTVkFYODlvbWRodFdmdWNm?=
 =?utf-8?B?SDhLQi9SVmdWa2ZSM1ZrRzBGSTQ0WVZHbmtoNko3aVJJWkVsWm1xR3d6MmZZ?=
 =?utf-8?B?amVVT2kzek82YS9VWjhZTWFoaWRzcXVSODB6RXhZbkE2Z1VSUldWU2wwRVEy?=
 =?utf-8?B?bHZWQXd2NzBibkpmZEd5d2NxRGhwM0VnZENvcVJ5cVdtREU2MzQyK0x5SXho?=
 =?utf-8?Q?2e3l1NBkHnK/Qkwgr+xCOump2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c424bf-b2dc-43f7-eb07-08db4cc77573
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:46:15.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+lC3JWMfGVP4dtlulyBQOf6lchHug0vferAnmvlXTkInDENGo0nuKiz24AcBa6DyNlGHzCqM8/EUdBCj5QG3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
Cc: Gal Pressman <gal@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiAyMDIzLTA1LTA0IHAubS4xOjE5LCBEcmFnb3MgVGF0dWxlYSB3cm90ZToKPiBPbiBUaHUs
IDIwMjMtMDUtMDQgYXQgMTM6MDggLTA0MDAsIEZlbmcgTGl1IHdyb3RlOgo+Pgo+Pgo+PiBPbiAy
MDIzLTA1LTA0IGEubS45OjUwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToKPj4+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4+Pgo+Pj4KPj4+
IFRoZSByZWZlcmVuY2VkIHBhdGNoIGNhbGxzIHNldF92cV9hZmZpbml0eSB3aXRob3V0IGNoZWNr
aW5nIGlmIHRoZSBvcCBpcwo+Pj4gdmFsaWQuIFRoaXMgcGF0Y2ggYWRkcyB0aGUgY2hlY2suCj4+
Pgo+Pj4gRml4ZXM6IDNkYWQ1NjgyM2I1MyAoInZpcnRpby12ZHBhOiBTdXBwb3J0IGludGVycnVw
dCBhZmZpbml0eSBzcHJlYWRpbmcKPj4+IG1lY2hhbmlzbSIpCj4+PiBSZXZpZXdlZC1ieTogR2Fs
IFByZXNzbWFuIDxnYWxAbnZpZGlhLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1
bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPgo+Pj4gLS0tCj4+PiAgwqAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYyB8IDQgKysrLQo+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+IGluZGV4IGVi
NmFlZThjMDZiMi4uOTg5ZTJkNzE4NGNlIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+Pj4g
QEAgLTM4NSw3ICszODUsOSBAQCBzdGF0aWMgaW50IHZpcnRpb192ZHBhX2ZpbmRfdnFzKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlCj4+PiAqdmRldiwgdW5zaWduZWQgaW50IG52cXMsCj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IFBUUl9FUlIo
dnFzW2ldKTsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBlcnJfc2V0dXBfdnE7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3BzLT5zZXRfdnFfYWZm
aW5pdHkodmRwYSwgaSwgJm1hc2tzW2ldKTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChvcHMtPnNldF92cV9hZmZpbml0eSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvcHMtPnNldF92cV9hZmZpbml0eSh2ZHBhLCBp
LCAmbWFza3NbaV0pOwo+PiBpZiBvcHMtPnNldF92cV9hZmZpbml0eSBpcyBOVUxMLCBzaG91bGQg
Z2l2ZSBhbiBlcnJvciBjb2RlIHRvIGVyciwgYW5kCj4+IHJldHVybiBlcnIKPj4KPiBJIGRvbid0
IHRoaW5rIHNvOiB0aGUgc2V0X3ZxX2FmZmluaXR5IGlzIG1hcmtlZCBhcyBvcHRpb25hbC4KPiAK
WWVzLCBJIHNlZQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4KPj4+ICDCoMKgwqDCoMKgwqDC
oMKgIGNiLmNhbGxiYWNrID0gdmlydGlvX3ZkcGFfY29uZmlnX2NiOwo+Pj4gLS0KPj4+IDIuNDAu
MQo+Pj4KPiAKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
