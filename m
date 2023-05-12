Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A5C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 01:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DC46405EC;
	Fri, 12 May 2023 01:54:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DC46405EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=COzywk3Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jnus5OyymiA5; Fri, 12 May 2023 01:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3343B40101;
	Fri, 12 May 2023 01:54:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3343B40101
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF8AC0036;
	Fri, 12 May 2023 01:54:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B0CC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 01:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CFB1822A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 01:54:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CFB1822A4
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=COzywk3Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V_EOQoQAwwKC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 01:54:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA47F82292
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::603])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA47F82292
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 01:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkO74yVTGFncmaXmjXg6mD6Lr+3dMPsnb4ByRgrZJxnNpPkRkH0e16srf15Vgm6dBXAXKeYvBqP0JFbZEocJ5i7RExQFOawejhhpsa7ODcHQfAtEFSJSDNbmXr2RdFoA3JEGnElAaMWQGZ3GAorkaw30nybKbdCLx7bDpF0fMCgfIQ0xDzpyHLn5Hu6h+1RCQWUQ8pGLitK6tgheP+NNUmS/CFVn0dlOavJdYjz2+IZtUUDTJMZYw7w6FYJ9tIMjO5L609pSGYltsVBndZ5JiNOL1v0qj93zeSKsnFqNqOT4pYLI/YbJzv7cCJGOQDbxAlhjy5mtyoISQLYyWlMrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFJCOwLfaEsBeDfMW38N6UO6M/iNKabrOf5p3/gnH5Q=;
 b=JBK6Dq7FpmdH6y5ZSc2GqCiRwcLIw7V8A10dLOrX2mba+tMRJ+Xkv/5kH2fLFVaWvUYEFk5NVuXRFTk5usk4ZWlTS7AlPl0HZElve1IRnEQl/Sq1MLQkxl1Jq8pi6hKBL4dsP6wmwKKjOsHJC+5wcGSKOdeAAePR7lGfrkSHP9ueyv4EjhM8Xcd1RShAHdHRozOmSMCBJR1BupxyfArnB9u/Tl2RuW0TqJIAtK1w98aBOpY8yYomfm5Ho0JbvUqbcD6AZOp1Af1jmc84goWuodZQtOzxC+1WRTNUyVSN+9vzhEhzhe7I7Mis515Kte14wwndri0j72mb5S4GWwqdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFJCOwLfaEsBeDfMW38N6UO6M/iNKabrOf5p3/gnH5Q=;
 b=COzywk3YxyCBEgJnXvyBJg1tl7HI7nGT8U3b8KkFJUPX7capLlO/rhCBBXaEjbk62ddXyWPr9QaVW+vdPupu5hL2J+HZQll8qipnGTir5bVTp2o3CxAa2lhOVs5YiXjAlw/jCdKwkW+LRxIR3y+7TxxbV+xQ5jfPzDtc7OIk0S3UdGxuawxvGpdkoGFpNYdyJCtRR3v/w0iZ3czZiIxQ5XEPMWeiP4jsC3Fd6if9YESXfRqc1Zo9DIpDcM4tp/KT6m1V+jBQFHPfoCWXTLWAZotnp4dY7GzHNQvDJoWroV1Z0sdG8pnVAe0noXBNp0wBjtMvAWtDZWL3vcKRPk7udA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) by
 IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Fri, 12 May 2023 01:54:45 +0000
Received: from DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::b886:ed22:51ce:fd53]) by DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::b886:ed22:51ce:fd53%6]) with mapi id 15.20.6363.033; Fri, 12 May 2023
 01:54:45 +0000
Message-ID: <af272d2c-e952-1c13-80da-b5ce751e834b@nvidia.com>
Date: Thu, 11 May 2023 21:54:40 -0400
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
X-ClientProxiedBy: SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::28) To DM4PR12MB6207.namprd12.prod.outlook.com
 (2603:10b6:8:a6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6207:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c95a171-76bd-4c11-84d0-08db528bdbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbsfmNN+R6IJas2UvUOb4GYYM8v9Poc/vR1WUg5HnpP6XNVDhLSUlFaghNm4VklAMNB7cgBecF3a3+LHaJvJ6VznkOwxVHtf7eNWCzyYBOrNj5NyOdlfs+yAfMyLVL4oDXipvC6OBiFw47sgxlG2Q1/+qBwqqBV/Vlt2vSETDbhdZIF8kG15PmWUiaFE+ZAw0f8sFAtnLgr5UXnw2vT18gJGN2egSvxoADyD8x5w+VRMG4oZIFodf9+/Ww1rGnku5Ci7xp2CAbmKCNHy3Xhu59ZsXtZtaqR/YoEAeRbwsxMp1BUGw+O/gdZTLfMXA4YK8MQTu9kfQZXUynYn7J6D7lQQUH5oOPiQ97LsFL4AMdu5aWsSgYNxkumJc3iIj4A7DVNFVYz6vJ3SNmSGg7DdxtOdOOD7A14qCeZhMekk7woaa4voNFSF6YtVzT2c7e8/pomVOQfE5rajdw2nIF93FF2clLRaW3YBWytQtxUMdUc3esYi83cImtR3zzV1vbJWtgCxVC0TnK949j9b7ytLhjh5ktoXtEEfkOITLUeV5FZi+1SHsHkVbwvIEFLcXkxAWarDTQ0lO2yE+7Xj3d3c3j/DMgpRJRcY7F2KTW6vPuLPvYjx58pRttrOF8VnsGL5hAtgd1gzsslSPr21PmtMgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6207.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(36756003)(478600001)(6486002)(2616005)(83380400001)(38100700002)(41300700001)(4326008)(31696002)(5660300002)(6506007)(110136005)(66556008)(6512007)(54906003)(66946007)(66476007)(86362001)(26005)(6666004)(316002)(8936002)(8676002)(31686004)(186003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNTN0Myb0EybVZjbUkvTVlMMDF5aDVxcUdsQUpuSUVydEZsaXAvQjNIWWdu?=
 =?utf-8?B?N2gxbTBMS3F4TjZhUWtudHpzcXBwajhnc1ZkY0NjNklpaEtKNWc4VmhTTVU4?=
 =?utf-8?B?NVc1c3lhcmR5a3BUb2gxVk90NHFoM3M3bHlkS2VJbXRzZnd4cnBjZS9lMVMr?=
 =?utf-8?B?M0NzbENTL2VBOGVoSWJhZmF0TTgzUnFwWlI1dnl6VDhEZGdNRC8rUmZkSlFl?=
 =?utf-8?B?eW93a3Z6QUVsYVF3UGM5elcxUklYOWRSVHhzenl5NE9FTE41c1poWlNiOERF?=
 =?utf-8?B?MWVtSk8yQ0diT21ZTkFGQUZKY2xtMEhScU5lT20vVkFSa2hSZkdsTks0WnhV?=
 =?utf-8?B?OFZObDIyUUxicnVuQVZLdCt1TDNHQzhxYkZvckJqdjJ2allpbmcwQWkyaEpx?=
 =?utf-8?B?VUR0c3FVcDhOVzF0R3BGMUVoc1kyQzQ4MEVZR2NYSWdjZHI1Z081anFxenli?=
 =?utf-8?B?d3pFVlErbjd3dUw0RWpIcnlXOU5DRDRCdlIwR1ZPUzBCMXkvYzd6OUErMXNV?=
 =?utf-8?B?bmN4eHRSS0tKWUxwTk93SWxuTzZvME9KbkpIZFQ5RFozOG12VDVtTG1yQkRS?=
 =?utf-8?B?ZDM3djRzRzZtTmpwYWtPczZsbFZmWjRqZVFibDRCbS9La0RNOEF3bGRhK01E?=
 =?utf-8?B?UGpKZU9NWW1sakF4NFo3SmRzSlp4NmgvQ3hDN0JtZ1VaSXRoT3lWcUI4cEJH?=
 =?utf-8?B?VXBTb3VSYlR2Yzl6VHNVUklCMEhaSHU0SXBJMndJZnNIMDZXN0hUVGw2TW5r?=
 =?utf-8?B?aElRdVVxQ2hXTVdjUnM0SERHOW9yWFVtTlFtWWZJc2k0bUdVdnVVTGdrWWVx?=
 =?utf-8?B?SG1Yb1pndVJ6aENzQ3RySTRPNGFQNjkzK1ZCUks2dHYzR2JPWXNjd2h5UitI?=
 =?utf-8?B?dnhwOHVuL0djM0F1MjVMU1prVXFCRElWK2xiSWo0eGJYSzFZeGM1a0hNcjdq?=
 =?utf-8?B?MzZDelJpVXlTeUxpUkJPS0daZVFJK2xQVE56NkUrcDUxb1R1TEV2MkxiV1JM?=
 =?utf-8?B?cHlrcEl4cVpjdi84c0pSajdQdmphSVRlQko5eWhickJ1dUdCTmlnY2FJdnEy?=
 =?utf-8?B?TDhYS0E2dC94Y3JaZmVEc2gyVmhKSUh3ZHYzZTVGdTg3Qm9ZWHJxYk9FbXEv?=
 =?utf-8?B?R1FCdG1vNG0zbWRGSzJkMXRma1pGbWRvYUtZQmRaYUYwMTlIWDJ5TlEyK01m?=
 =?utf-8?B?di9mQ3djaHpnZW1pVXUvVHJsNEs5SHRwWEx5cFhOeVM3Y0pZY1kxSUxESTN3?=
 =?utf-8?B?YXluMmZLRXRCK29EMHVJWVhkaTM5UXg4YnZsdjdqS1p6RHhEQVJHUFplRGM0?=
 =?utf-8?B?a09CaEFiU3ZaMEhUVjRrM1pKUThnYm5QKzBlUTFKLzY5azJCSHlKMFZGVTU3?=
 =?utf-8?B?ZW90RFdCSEZ2VTFXZkhqQThoVGp6aGh0dW90TzJITGlWc1NFdU1aQ0J1R2Yw?=
 =?utf-8?B?NnR5T3BwOWFFNVd4Y2RBdzdzN25kQUg1UGd2MzJFTjRNczdGY0JETEZSdWFo?=
 =?utf-8?B?N2IxcnlaN1JUVVdwRzdRUWpub3lJNyt4YXJNR2wyNEsyaFF0dnlOQmg4WkNy?=
 =?utf-8?B?Z0FkWmFsOUZUanA4UEpLTUxna1Fod2dQdngzbE1YMWk0NGowZUJHNmFzU0xI?=
 =?utf-8?B?Y01Qcm1lUFhZaWV0NnVpcnFNWU1QSmFtdlkzdklycnBQWlpJU0syc3V5dHNR?=
 =?utf-8?B?bEZBS2J3TWRHbGVWSlNac08ycGs0cHVDWlVWeTFIVVU5MGVEQk9hL2V4MDFZ?=
 =?utf-8?B?MklMVFl0UkptWkI4ZWZ6eERMUGpkNys2QWF2N0diejVZNURQbENGK3lYVkZY?=
 =?utf-8?B?Vkp3N3JBc2hJemVsQXE3WDJjVm0ybkV5dmY0amVSZDNQdldCalFOUmF5dlQz?=
 =?utf-8?B?cEF5NlVIalJPcy9sa2VzZFNYUHdmbVJvVXdSTEZWUW8zT0hnU0NlMU12aUlJ?=
 =?utf-8?B?TnlzRytyaWJXY2wzQlFWaTJCVTlwL0JGNXdFNTFjL1VSRktaUml6eXoyaFA3?=
 =?utf-8?B?RkVVSmtUajErTklSUGlUOHRoVm54bmx6UG1DMk9uVW0vUE52QXQ2ckNtVDE3?=
 =?utf-8?B?em1uQ28yZWU1UEhRSFNLNG5RT0h1TDdtdXg0TmovTmRyRXdEQWtpOStmRFpw?=
 =?utf-8?Q?dxP8sFAWXdh15vbJ4rW8cJWuD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c95a171-76bd-4c11-84d0-08db528bdbef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 01:54:44.8814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul/V1/K5CRhyWzR1hXDOJDkpZZ/zUO9b1y/hCnz6nePbxTriUx++asTFnso0dw/cNvLfqRv4muu7hxuiYdkOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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
YW5kIHN5bmMgd2l0aCB0aGUgcmVmaWxsIHdvcmsuCj4gCj4gVGhhbmtzCj4gCj4gCkhpLCBKYXNv
biAmIFh1YW4KCkkgd2lsbCBtb2RpZnkgdGhlIHBhdGNoIGFjY29yZGluZyB0byB0aGUgY29tbWVu
dHMuCgpCdXQgY2Fubm90IGNhbGwgdmlydG5ldF9jbG9zZSgpLCBzaW5jZSB2aXJ0bmV0X2Nsb3Nl
IGNhbm5vdCBkaXNhYmxlIApxdWV1ZSBwYWlycyBmcm9tIHRoZSBzcGVjaWZpZWQgZXJyb3Igb25l
LiBzbyBzdGlsbCBuZWVkIHRvIHVzZSBkaXNhYmxlIApoZWxwZXIgZnVuY3Rpb24uIFRoZSByZWFz
b24gaXMgYXMgbWVudGlvbmVkIGluIHRoZSBwcmV2aW91cyBlbWFpbCwgd2UgCm5lZWQgdG8gcm9s
bCBiYWNrIGZyb20gdGhlIHNwZWNpZmllZCBlcnJvciBxdWV1ZSwgIG90aGVyd2lzZSB0aGUgcXVl
dWUgCnBhaXJzIHdoaWNoIGhhcyBub3QgYmVlbiBlbmFibGVkIG5hcGkgd2lsbCBoYW5nIHVwIGF0
IG5hcGkgZGlzYWJsZSBhcGkuCgpBY2NvcmRpbmcgdG8gdGhlIGNvbW1lbnRzLCBJIHdpbGwgY2Fs
bCBkaXNhYmxlX2RlbGF5ZWRfcmVmaWxsKCkgYW5kIApjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
KSBpbiBlcnJvciB1bndpbmRpbmcsIHRoZW4gY2FsbCB0aGUgZGlzYWJsZSAKaGVscGVyIGZ1bmN0
aW9uIG9uZSBieSBvbmUgZm9yIHRoZSBxdWV1ZSBwYWlycyBiZWZvcmUgdGhlIGVycm9yIG9uZS4K
CkRvIHlvdSBoYXZlIGFueSBvdGhlciBjb21tZW50cyBhYm91dCB0aGVzZT8KClRoYW5rcwoKPj4K
Pj4gVGhhbmtzLgo+Pgo+Pj4gVGhlIGxvZ2ljIGhlcmUgaXMgZGlmZmVyZW50IGZyb20gdGhhdCBv
Zgo+Pj4gdmlydG5ldF9jbG9zZS4gdmlydG5ldF9jbG9zZSBpcyBiYXNlZCBvbiB0aGUgc3VjY2Vz
cyBvZiB2aXJ0bmV0X29wZW4gYW5kCj4+PiB0aGUgdHggYW5kIHJ4IGhhcyBiZWVuIGNhcnJpZWQg
b3V0IG5vcm1hbGx5LiBGb3IgZXJyb3IgdW53aW5kaW5nLCBvbmx5Cj4+PiBkaXNhYmxlIHFwIGlz
IG5lZWRlZC4gQWxzbyBlbmNhcHVzbGF0ZWQgYSBoZWxwZXIgZnVuY3Rpb24gb2YgZGlzYWJsZSBx
cCwKPj4+IHdoaWNoIGlzIHVzZWQgaW5nIGVycm9yIHVud2luZGluZyBhbmQgdmlydG5ldCBjbG9z
ZQo+Pj4gMi4gVGhlIGN1cnJlbnQgZXJyb3IgcXAsIHdoaWNoIGhhcyBub3QgZW5hYmxlZCBOQVBJ
LCBjYW4gb25seSBjYWxsIHhkcAo+Pj4gdW5yZWcsIGFuZCBjYW5ub3QgY2FsbCB0aGUgaW50ZXJm
YWNlIG9mIGRpc2FibGUgTkFQSSwgb3RoZXJ3aXNlIHRoZQo+Pj4ga2VybmVsIHdpbGwgYmUgc3R1
Y2suIFNvIGZvciBpLS0gdGhlIHJlYXNvbiBmb3IgY2FsbGluZyBkaXNhYmxlIHFwIG9uCj4+PiB0
aGUgcHJldmlvdXMgcXVldWUKPj4+Cj4+PiBUaGFua3MKPj4+Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICvC
oMKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+Pj4+IMKgwqDCoCB9Cj4+Pj4+Pj4KPj4+Pj4+PiDCoMKg
wqAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBp
bnQgYnVkZ2V0KQo+Pj4+Pj4+IEBAIC0yMzA1LDExICsyMzE4LDggQEAgc3RhdGljIGludCB2aXJ0
bmV0X2Nsb3NlKHN0cnVjdCBuZXRfZGV2aWNlIAo+Pj4+Pj4+ICpkZXYpCj4+Pj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoCAvKiBNYWtlIHN1cmUgcmVmaWxsX3dvcmsgZG9lc24ndCByZS1lbmFibGUgbmFw
aSEgKi8KPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygm
dmktPnJlZmlsbCk7Cj4+Pj4+Pj4KPj4+Pj4+PiAtwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHZp
LT5tYXhfcXVldWVfcGFpcnM7IGkrKykgewo+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUoJnZpLT5zcVtpXS5uYXBpKTsKPj4+Pj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hcGlfZGlzYWJsZSgmdmktPnJxW2ldLm5hcGkpOwo+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFb
aV0ueGRwX3J4cSk7Cj4+Pj4+Pj4gLcKgwqDCoMKgIH0KPj4+Pj4+PiArwqDCoMKgwqAgZm9yIChp
ID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkrKykKPj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHZpcnRuZXRfZGlzYWJsZV9xcCh2aSwgaSk7Cj4+Pj4+Pj4KPj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+IMKgwqDCoCB9Cj4+Pj4+Pj4gLS0gCj4+
Pj4+Pj4gMi4zNy4xIChBcHBsZSBHaXQtMTM3LjEpCj4+Pj4+Pj4KPiAKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
