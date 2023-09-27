Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD73E82CBB
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 18:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3888A403EA;
	Wed, 27 Sep 2023 18:09:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3888A403EA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YMozpr1J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UB82tl6lIS91; Wed, 27 Sep 2023 18:09:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AACC40154;
	Wed, 27 Sep 2023 18:09:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AACC40154
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63B3DC0071;
	Wed, 27 Sep 2023 18:09:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32164C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C32E403EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C32E403EA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yul6E3wpzhGy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:09:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 969AC40154
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 18:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 969AC40154
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvzqR+h1Bfw3VIE43QzYN9QS5NOFl7AswotihTo4nCIIkEVkX0qcWDsoJn36emHSXGl/TAz9EzSHLF3ybG1plhh488CDwO9rSwW+os6zta4vrlbqDpPJWUweXSDM8UyL4xrne5fw0CKRdD3j2rbGWmAYZnGh/lKkJ3ItqhAmp+aXwcoEJAMM5i15wGVui+eiMqpqgwt/KIXQiA+rOylTaAv3yz9qALaOQ2EfsE+DzHOqzMpEf06a2HNHUpry1dyLJIyvcfiPdm2PrMR8qpUV63mUVHm3S77atqAuV6pLNuC8kodT1Op0CRgJjCbKqfzosn8299n0iTIVjInWuD+THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmwQJnUA5aIbXUzPxgqkGYwI1jbBrV+P5ivCFZLhddo=;
 b=dg5hD4RbmKyEEBgv1xGmxoKuyvk3P7MiAvO0NGDd7t3cFfkvX4byzm36UIgay5sCG3ZVQNSH0tRPmR9WNjQD3MQSr7ti2WX2D3VuvbIzGgMn343Bisn+na9Npzj/U32PerpYuoZ3SRGZnZskOo5+jT8D3LwTg7GXWIu7FSKkq+/P3VAeYM1OJ8XbYHHlLrLF/mLHrwiUvogNNYN6lTDDlyIjM9YXYVbrc04313Zp9BYtKbpXjZZW6O8kNux1YWg1LwpdaWZ8IzFtg3NQD+zfn3tzL69aHiS3KKUmkC6XOizQTIhWkT1zObi2vOLf0VlYp3OM79UhwQO0Ghhr2Q05SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmwQJnUA5aIbXUzPxgqkGYwI1jbBrV+P5ivCFZLhddo=;
 b=YMozpr1J2bDya2cuN6pOGoDM7b6w3zXbdjlSh7y0FJxr/kUSEd2Mler65zXU9bBiFPm+0PR6NalN3puFksD/QKGeR8JJtCNFaeqAsI+H+NychiWirsFYJU5b2i9S4VH0HcKu8S578MDUQa0sEEjI4QjQusKs/glC+GYP9MhtmY1IIhV0CKU9b7doZnQeUGgSP+v8VNj2/JZGeg7DeIj3lQSBrQ4lR1G4NQqahef7TenFI79RdOF+bPAkgu5eQ+FnXr2iXm3hW6SmlwMMd7oiNbKUHSaCsOOhGrTJrTTwVNWvQvJ96y0WkjtwpvYBHs/LnoWFOl6tj7Zgt6OUy5yE8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:09:49 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::8bbf:3b92:2607:4082]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::8bbf:3b92:2607:4082%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:09:49 +0000
Message-ID: <39d8a0a5-4365-4ced-cac1-bef2bc8d6367@nvidia.com>
Date: Wed, 27 Sep 2023 14:09:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH vfio 01/11] virtio-pci: Use virtio pci device layer vq
 info instead of generic one
To: "Michael S. Tsirkin" <mst@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-2-yishaih@nvidia.com>
 <20230921093540-mutt-send-email-mst@kernel.org>
 <6eb92b47-cefe-8b00-d3d2-f15ce4aa9959@nvidia.com>
In-Reply-To: <6eb92b47-cefe-8b00-d3d2-f15ce4aa9959@nvidia.com>
X-ClientProxiedBy: DM6PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:5:120::28) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d98893-87d5-4c5d-898c-08dbbf84ef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux9BbCxaej9TCtdLOL9cPWpbtSMfRJbh2B06OJ7d49ePGlRRqLb+2DH4yIC5uXg0yb4qIogpgFNhgbj9IZdsZQyJHN2ftZjRYzP5hj06F8I+W2VF80/zLyljwteoSqgFvPRc43+c1QdD2wg22f0aQYahhDM8i5MTKnK8ip8NVXJUVoecIqeRlpoZWWaImagzi+h0MTZR6GiLFu/BWLMv4Vg6VxOQG6+MeVu5np5NfPnw4XXQJr0cxY6cHEneHeo/FQGgvBBkTf3znTymUHERXM4TJWmz8v7W5tjWYqMsJaGiWIur5fzyWLCou2W+EVdqBb/DPEUkIEYfQqNFzoJr3U2L5dAJYo4pgvcjV55E9Ci2igT8Tfr4QtmaI2PFvByc+FLocH32rQ7n4mwgqroMA7sSf/WfIyp4lV0Znc/B8Xu9aBP1hiOBkagM229sLTAGs/moNLqLZwhSuW0RYS/joVFm44iMv/qNEAoBcIbH0eG9GM7xmY/vYJ2xAysKs85VDeQio7zRBmWVBj7TqoTjc948YqtcMTwYZcf1CQfhc2CNNjlCqS7A8XF7uld6uppmpMkV68uaZGGy6Fgdw02gnas+2mkn2RWYp03/jxvmw+ygmiiNmTc0xp20DV72lTkL3z9zvNceVQgQnQiAjODMYfS6HGTnt2AhtbUNgTFBeCWr64d7hfr0CCxE7RQ1GnZu5QFQ3KydllHeXCVUB7tmGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(316002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(6636002)(110136005)(66476007)(66556008)(31686004)(66946007)(2906002)(6506007)(2616005)(6512007)(36756003)(478600001)(966005)(6486002)(26005)(107886003)(86362001)(83380400001)(31696002)(38100700002)(6666004)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlNM2djSTBpWmpqMWRYVGsrMmRkbnh6Q3BKa0xhYm1hTzdZMFZCYlpuYjh2?=
 =?utf-8?B?a2FDMElVMXgwZWY1clE3UzY1UUY5OGd0TnRDckRBQlB4OUt2djZQazJJL3N4?=
 =?utf-8?B?cElJdWlHQzNRQlFyMG15QTJKSjVMWmVsWkpBcWhKVTV3QXV2ZllVMHMwbUVM?=
 =?utf-8?B?L3gzN3FVSWFuS3ZTTjNIbVM0ZTZaK2FEMHJ3aWhVeG4vaTYwaStnSENGT0lO?=
 =?utf-8?B?azd5ck0wTzdBRTNtN2tLQ3lNRTVqbncyYTFTVlBYb3Roa1RTbE9kQkpiUVdN?=
 =?utf-8?B?R2hmOVVkRWQvL2RRSzhVdjB5dTNrV1A4VzBLOVFsZ1lTVCtTWmFsdlRXZlg5?=
 =?utf-8?B?UXAwejB1TS80MEpMY3NMQzNjWVNRaS9yaUpoM0RzdUpsZTBLMUJqTlFOajhR?=
 =?utf-8?B?Nkk1dTVNcEFpTGFTdzdJWHlLK014QUJrU0tDZnFmaUxMcUNsWVYrRE5qdFk0?=
 =?utf-8?B?ampzQ0t2R2YrZVlhSU1neDlJRGVQNEhRb3dYQ1Z0S1A2NUpYaGQzNVIwSG5T?=
 =?utf-8?B?clFIb1NKN0haaUJGWTE5TkJuRWN6c0xBbWFNRysxUUhMSFdGUGYwdzVHenQw?=
 =?utf-8?B?M1ZqcnhuRy84ZE1ScTZxelVKTVg1dlhjbXFBd1IzaWs0WHpmTWlRYWNJR2x1?=
 =?utf-8?B?cHZyTit5TkJNT2VnZmlESm51am9Wc1FyeWtCdXJTZTlFOWZ1cGhjOE5FOTN2?=
 =?utf-8?B?YkZxWWdEWTF2SEl1TUx0UlRwT3JBTVU2enY5MjF4NkZvWE9kT3R0NU1oc2Nk?=
 =?utf-8?B?WEE5dHVnQWI4Vjl1aWxhMWgzdUJHT1h5OXdKS0tEQVBqLzNERGxMSkxGU3dC?=
 =?utf-8?B?YlYrN0k2QVo4NWE3ZjJ3N2lUSUpiTHIyTWtXcS9zQm44eTlyUnBkNUIwNlYw?=
 =?utf-8?B?MXAxQ1lHRnRWbDdkelF4dFZudHN0NGNWbVYxd2NFQXpUUUZoem9oSmRFOEtO?=
 =?utf-8?B?MGZhc2FoYXdGd3dneUplTnhUZVduRmloMm9tQjZNelNUVFlEb0hBR3lpTVI3?=
 =?utf-8?B?WDJhc0hCTGMycURrOTVST21LUnorUG1tckFPb0U3YVVubU5pUG5EVXZka3Zr?=
 =?utf-8?B?R0tIVlJYUWsvaXJhRHdlZFV3TFJvTEQrdUgxdkN1aHl5VUYwQlNRamlXd24r?=
 =?utf-8?B?TVVSbFkzNTcyOUxiRTBEWDhxQXJacGRESkdBT2hocWJ3QlJHRk56OHpEQnhW?=
 =?utf-8?B?N05NVlEwZmh4OUZzYVk0QTl6MFBNc3NWZFBPTk85WGJCTDRMaC9KZ2xza3g1?=
 =?utf-8?B?NnMwODFlbWg0OW1KUDVveTNNZ2pTcEo5bmNib2NDV3h2Yk5Rc1QyU3Q5SzBt?=
 =?utf-8?B?c0Nkc21nZUJ2WFh4Y0ZjV1VMeEljcVZRTjJ3MDVsSDNEc3hPdVJRb3RlZXQr?=
 =?utf-8?B?SWVEWEJOeTFkMm8wcXlSbEpEMlp2dUxOeWZPNU8ydkxIQjQyWlZDclJrSlph?=
 =?utf-8?B?T1VZcUUzYk9zQWprNnNSOHVNQ1RxZDBXTTczd29TVmpTQUx3YmFEYlFqK3hF?=
 =?utf-8?B?anBrcjRsMFZlOWl4NTBTcGJ0cldScExiOGRsVGhRUGd2TFZ1MlpoYy84U3FV?=
 =?utf-8?B?Yjh1QjQwQmZiZUVDclJkNVNaa0NyVG1TeU5paituQSs1RHNpZS82d3luTHhj?=
 =?utf-8?B?TUNqTGlyOENiMDd5TFhhUEdyRkZ1d0FpQ3Q5dmNiekFJeGEzMjYyamgrdlRm?=
 =?utf-8?B?MVY3T0lYWStqaURmUVViUHhpUWxiNTFFNkt3cEc2UWdnZDBEYXkwb1RwUlNp?=
 =?utf-8?B?dVlFYUpjTGpENjdXRXVBWDVicEJxeFpsOHJ6QmZiVjFIc1AweS8vNUhtb2ZV?=
 =?utf-8?B?NnRUWkpUWmFkSW1kYUE1bmRPaHBTMmIvOWJsRW1HN1h3d0NsWE1Qem91S0Z6?=
 =?utf-8?B?K3RCNHpkaWVBZjRjL2ZEZjZ0Nnl0dndKRTFEbUJ4TkpLVnFlamRRTDJYVCtX?=
 =?utf-8?B?aVBWeTQ4UUxEQitPVDFiTHVpWDJuZDFwKy9EcE9nTU02TGxIVWlVOEhmR2gw?=
 =?utf-8?B?cDZZejRVQjJPMU1uT3ZoRnFWbUgyK0VKY05zK0hleUJjR1VpUWR6S2ptaDla?=
 =?utf-8?B?ZWJ0a2JiSDNibjk5aVhyNHAvL0grOXhPTlhJMGZzU2ltSW5pSzUvZUt6SGpV?=
 =?utf-8?Q?btIYPKQSKXaXH5TXDlNb/IKDM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d98893-87d5-4c5d-898c-08dbbf84ef2d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:09:49.0257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oM2k3VBoKPQUe8EM2B9zuu0bqNsV2Zm8s63tsCR04NBeTSmLrhTVkQV6zX5hcjY0xH0TqOqEC60R0BiBSsq67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

CgpPbiAyMDIzLTA5LTI2IHAubS4zOjEzLCBGZW5nIExpdSB2aWEgVmlydHVhbGl6YXRpb24gd3Jv
dGU6Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMKPiAKPiAKPiBPbiAyMDIzLTA5LTIxIGEubS45OjQ2LCBNaWNoYWVsIFMuIFRzaXJraW4g
d3JvdGU6Cj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzCj4+Cj4+Cj4+IE9uIFRodSwgU2VwIDIxLCAyMDIzIGF0IDAzOjQwOjMwUE0gKzAz
MDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4+IEZyb206IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPgo+Pj4KCj4+PiBwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYsIHYpOwo+Pj4gQEAg
LTI5NCw2ICsyOTgsNyBAQCBzdGF0aWMgaW50IHZwX2ZpbmRfdnFzX21zaXgoc3RydWN0IHZpcnRp
b19kZXZpY2UgCj4+PiAqdmRldiwgdW5zaWduZWQgaW50IG52cXMsCj4+PiDCoMKgwqDCoMKgwqAg
dnBfZGV2LT52cXMgPSBrY2FsbG9jKG52cXMsIHNpemVvZigqdnBfZGV2LT52cXMpLCBHRlBfS0VS
TkVMKTsKPj4+IMKgwqDCoMKgwqDCoCBpZiAoIXZwX2Rldi0+dnFzKQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4+ICvCoMKgwqDCoCB2cF9kZXYtPm52
cXMgPSBudnFzOwo+Pj4KPj4+IMKgwqDCoMKgwqDCoCBpZiAocGVyX3ZxX3ZlY3RvcnMpIHsKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQmVzdCBvcHRpb246IG9uZSBmb3IgY2hh
bmdlIGludGVycnVwdCwgb25lIHBlciB2cS4gKi8KPj4+IEBAIC0zNjUsNiArMzcwLDcgQEAgc3Rh
dGljIGludCB2cF9maW5kX3Zxc19pbnR4KHN0cnVjdCB2aXJ0aW9fZGV2aWNlIAo+Pj4gKnZkZXYs
IHVuc2lnbmVkIGludCBudnFzLAo+Pj4gwqDCoMKgwqDCoMKgIHZwX2Rldi0+dnFzID0ga2NhbGxv
YyhudnFzLCBzaXplb2YoKnZwX2Rldi0+dnFzKSwgR0ZQX0tFUk5FTCk7Cj4+PiDCoMKgwqDCoMKg
wqAgaWYgKCF2cF9kZXYtPnZxcykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9NRU07Cj4+PiArwqDCoMKgwqAgdnBfZGV2LT5udnFzID0gbnZxczsKPj4+Cj4+PiDC
oMKgwqDCoMKgwqAgZXJyID0gcmVxdWVzdF9pcnEodnBfZGV2LT5wY2lfZGV2LT5pcnEsIHZwX2lu
dGVycnVwdCwgCj4+PiBJUlFGX1NIQVJFRCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRldl9uYW1lKCZ2ZGV2LT5kZXYpLCB2cF9kZXYpOwo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggCj4+PiBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmgKPj4+IGluZGV4IDRiNzczYmQ3YzU4Yy4uNjAy
MDIxOTY3YWFhIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uaAo+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaAo+Pj4gQEAg
LTYwLDYgKzYwLDcgQEAgc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlIHsKPj4+Cj4+PiDCoMKgwqDC
oMKgwqAgLyogYXJyYXkgb2YgYWxsIHF1ZXVlcyBmb3IgaG91c2Uta2VlcGluZyAqLwo+Pj4gwqDC
oMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gKip2cXM7Cj4+PiArwqDCoMKgwqAg
dTMyIG52cXM7Cj4+Cj4+IEkgZG9uJ3QgbXVjaCBsaWtlIGl0IHRoYXQgd2UgYXJlIGFkZGluZyBt
b3JlIGR1cGxpY2F0ZWQgaW5mbyBoZXJlLgo+PiBJbiBmYWN0LCB3ZSB0cmllZCByZW1vdmluZyB0
aGUgdnFzIGFycmF5IGluCj4+IDVjMzRkMDAyZGNjN2E2ZGQ2NjVhMTlkMDk4YjRmNGNkNTUwMWJh
MWEgLSB0aGVyZSB3YXMgc29tZSBidWcgaW4gdGhhdAo+PiBwYXRjaCBhbmQgdGhlIGF1dGhvciBk
aWRuJ3QgaGF2ZSB0aGUgdGltZSB0byBkZWJ1Zwo+PiBzbyBJIHJldmVydGVkIGJ1dCBJIGRvbid0
IHJlYWxseSB0aGluayB3ZSBuZWVkIHRvIGFkZCB0byB0aGF0Lgo+Pgo+IAo+IEhpIE1pY2hhZWwK
PiAKPiBBcyBleHBsYWluZWQgaW4gY29tbWl0IG1lc3NhZ2UsIHRoaXMgcGF0Y2ggaXMgbWFpbmx5
IHRvIHByZXBhcmUgZm9yIHRoZQo+IHN1YnNlcXVlbnQgYWRtaW4gdnEgcGF0Y2hlcy4KPiAKPiBU
aGUgYWRtaW4gdnEgaXMgYWxzbyBlc3RhYmxpc2hlZCB1c2luZyB0aGUgY29tbW9uIG1lY2hhbmlz
bSBvZiB2cmluZywKPiBhbmQgaXMgYWRkZWQgdG8gdmRldi0+dnFzIGluIF9fdnJpbmdfbmV3X3Zp
cnRxdWV1ZSgpLiBTbyB2ZGV2LT52cXMKPiBjb250YWlucyBhbGwgdmlydHF1ZXVlcywgaW5jbHVk
aW5nIHJ4cSwgdHhxLCBjdHJsdnEgYW5kIGFkbWluIHZxLgo+IAo+IGFkbWluIHZxIHNob3VsZCBi
ZSBtYW5hZ2VkIGJ5IHRoZSB2aXJpdG9fcGNpIGxheWVyIGFuZCBzaG91bGQgbm90IGJlCj4gY3Jl
YXRlZCBvciBkZWxldGVkIGJ5IHVwcGVyIGRyaXZlciAobmV0LCBibGspOwo+IFdoZW4gdGhlIHVw
cGVyIGRyaXZlciB3YXMgdW5sb2FkZWQsIGl0IHdpbGwgY2FsbCBkZWxfdnFzKCkgaW50ZXJmYWNl
LAo+IHdoaWNoIHdsbCBjYWxsIHZwX2RlbF92cXMoKSwgYW5kIHZwX2RlbF92cXMoKSBzaG91bGQg
bm90IGRlbGV0ZSB0aGUKPiBhZG1pbiB2cSwgYnV0IG9ubHkgZGVsZXRlIHRoZSB2aXJ0cXVldWVz
IGNyZWF0ZWQgYnkgdGhlIHVwcGVyIGRyaXZlcgo+IHN1Y2ggYXMgcnhxLCB0eHEsIGFuZCBjdHJs
cS4KPiAKPiAKPiB2cF9kZXYtPnZxc1tdIGFycmF5IG9ubHkgY29udGFpbnMgdmlydHF1ZXVlcyBj
cmVhdGVkIGJ5IHVwcGVyIGRyaXZlcgo+IHN1Y2ggYXMgcnhxLCB0eHEsIGN0cmxxLiBUcmF2ZXJz
aW5nIHZwX2Rldi0+dnFzIGFycmF5IGNhbiBvbmx5IGRlbGV0ZQo+IHRoZSB1cHBlciB2aXJ0cXVl
dWVzLCB3aXRob3V0IHRoZSBhZG1pbiB2cS4gVXNlIHRoZSB2ZGV2LT52cXMgbGlua2VkCj4gbGlz
dCBjYW5ub3QgbWVldCB0aGUgbmVlZHMuCj4gCj4gCj4gQ2FuIHN1Y2ggYW4gZXhwbGFuYXRpb24g
YmUgZXhwbGFpbmVkIGNsZWFybHk/IE9yIGRvIHlvdSBoYXZlIGFueSBvdGhlcgo+IGFsdGVybmF0
aXZlIG1ldGhvZHM/Cj4gCgpIaSwgTWljaGFlbAoJSXMgdGhlIGFib3ZlIGV4cGxhbmF0aW9ucyBP
SyB0byB5b3U/CgpUaGFua3MKRmVuZwoKPj4+Cj4+PiDCoMKgwqDCoMKgwqAgLyogTVNJLVggc3Vw
cG9ydCAqLwo+Pj4gwqDCoMKgwqDCoMKgIGludCBtc2l4X2VuYWJsZWQ7Cj4+PiAtLSAKPj4+IDIu
MjcuMAo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
