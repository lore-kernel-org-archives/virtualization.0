Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015DEC00528
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 04:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 737BF40441;
	Tue, 25 Jul 2023 04:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 737BF40441
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TuJ3sHvG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zc4MUtv8PQfQ; Tue, 25 Jul 2023 04:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBF5B400FE;
	Tue, 25 Jul 2023 04:18:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBF5B400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82F4DC0071;
	Tue, 25 Jul 2023 04:18:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A257C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 04:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23619408C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 04:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23619408C3
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=TuJ3sHvG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DzcL5rkb8smg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 04:18:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::604])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8EECB405A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 04:18:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EECB405A4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7+gvPGRkK/jNe1uwlL3Z5N5mw6agSvQ83LM1orsDau7XpShUz3ffgEjPu+F1V/rJVPapAaC0uToFn/zGN81lC70AD7g/NJlwBtpaaBuSFAoF0i0p8zYcTtF8EbPwZ07UTAH2FtuAdo1EGh7ryMMwoNHbe7JKDKHBnsU7Hfvi6ijxv/6SqNUTMUFAr15Ch3IWSRx+EvDVMOhXpxryuqQU/gFHSqs8GOxSdADoD7RTlO2sOjFde5hlUahYZN4xt0tWjge0AX+m3e26HNWATr8LwcQwX7BxgtQNXJbhvlEHKgeGAW4FGvssewDRP7mdrDGxa+IBn8aMu/hvlQOkipYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+rZtYTckji8hLYuKss5BkixsMVRbimqeOgkurUK1uc=;
 b=N8ooT7sktk1cvpPI6L+X6HGma4VQWN61KcEqzcDs2bG/8+yscZG/YFRmU1ofZgUi0o8+7sWCmZRhpmnf463i1tLvaI2TctR51dKWkJp6+qZU5pVmB4tdCs805Zf9vCK0Z9mklUuoOky50fCkZcRbp3P4MBmzU97vVbmATJGXLylZWhiHS5NiWOMRwZZpYHGfHPI0+lLhD9qKH1MewVLubwlMhWDAVCVLJUehEqQjwvWubGYYT33c/yg+9q1cyFkgGnX12/06YYAx5k4u4iol+P6SEWF0XjW83vEd8vKP1cEM8eB+9RgPMiX28kIFO5ZehherFazu7IzUHjQivj4VkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+rZtYTckji8hLYuKss5BkixsMVRbimqeOgkurUK1uc=;
 b=TuJ3sHvG5qDSQFEH4J9RvvXwokwJPr16q/BSQ+p3rMt1qw87C+zfNgfOBHbGRP+M5J7Szjq+V+VFooNhJH3QlbITDADz/Czga0u6dK+/+BYcuprnCRa1ryTjbJrjuxvtne8z6YH+3LSAQl647tBE07APtQZjLX9ExXPY+2nCGMw4/Z0m4Vyv4hMVxcDRMCa1KhIAO+hdS8dZiHO4nTXfRd4J26IyafFiloqCTtRKOUXsQPxLwfdJBIkzK3vWB1dpi44AidpwbjDZIk2LTSZlZ2B65cOOECetqs3y1wBjFv27SICa96L/twzV5rGEsQ1fPwYyWNaVmY4+GU+KTHTpoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 04:18:27 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 04:18:27 +0000
Message-ID: <863c6e42-09ec-23cb-6b71-cb9bf4b564fb@nvidia.com>
Date: Tue, 25 Jul 2023 00:18:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To: Jason Wang <jasowang@redhat.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
 <20230720131423-mutt-send-email-mst@kernel.org>
 <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
 <CACGkMEuk2aBhnViZkAi8tbNc8AnJ1FY9uk9rCnmmiWVGwYsLUA@mail.gmail.com>
In-Reply-To: <CACGkMEuk2aBhnViZkAi8tbNc8AnJ1FY9uk9rCnmmiWVGwYsLUA@mail.gmail.com>
X-ClientProxiedBy: SN4PR0501CA0097.namprd05.prod.outlook.com
 (2603:10b6:803:42::14) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcd2d61-0544-4ae6-f6d9-08db8cc631cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKgNaRDPOisSAwST3QiwiZeJX3u7YAxrO74erIl4ivivYNCW+RDinBsQ223i3d3EIN7wXLaIYPq5fEHgC61gmpON/J4/uhf8hKK6Ht6/aGhU2Rii+GWGheYo92l3PBBc4r+vr98wVNU+3OjmDsmn/LIn/C6VKSddgsIRw9epnl2cZ3P4M67hYO1F1+CNXU7XMnyyDbTgOEaERCwZ/ixabEJwESUh9o9iZVuBKfYkjJJ1X6WUrdYVDsqZmz/GD1Z07zxn1PnaJMwB3ojQlL5OYb2HT+7rXtBdRia9OKmMG6quq6o2FKItrsLox7P6ARXVMlg1rNLnQND84VltgcacAbHEZNN4KY0NAxwauaqx2LvPmibbYTepYCkEG2JEAx8hTYwH5dnCL77si+XJ8vgPVmuDX1gofzlwTmjcDsntkf7kM34DN4Orb3+V1IR6KACpGzJeSeKmyXp2LqTtaMqYYf1bqUtqcla4vo816p7NaCH/kdgmvXJdvZWNseYu4SUzdoIKv7NqAArlrbujD89XLdnf8//ARunFHsdngsErqww5FWKKUBsJxX5zO8ejGydZ7GL9nE/XPB0HVj2+Dts1I/bNvF0pXnRA5TKoQp7FYhbNxXXt8Htdaybry+K/N+Vl3Ds/DFVIjbGVoj5UaMfI0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(66476007)(66946007)(66556008)(6916009)(4326008)(316002)(478600001)(38100700002)(6486002)(6666004)(6512007)(83380400001)(41300700001)(31686004)(54906003)(36756003)(8676002)(8936002)(6506007)(186003)(26005)(53546011)(5660300002)(31696002)(86362001)(107886003)(2906002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dtOHp2UnltaTl6SzdubE1vc0NUMXN0Z0hrTTY3UXl3ZEdYVW54dFlnbysv?=
 =?utf-8?B?SklQSWtmR0ZGUkcwdUFSd3c3N3dvdFlQdVNqZ3U5MS9vRElpd29vWWhTMThm?=
 =?utf-8?B?UVJ2L0pibFM1YitOd3NoYXI3d3NGWkNwNm92U21iVU81SWY3MEVTWWdJWWd0?=
 =?utf-8?B?MFhCU3ZkRWw3elRjdDk3UjhUTit1MVRPTE9vejVaREdqczR5MGx5bXdDSmFF?=
 =?utf-8?B?ZUI0ckxXVE5kQWdpaGkyN2ZuVk1ld3hlb09zd1J6dUdUTDBMVkptME1SVXlm?=
 =?utf-8?B?SERHZWdKNTg4ZC9PZjRnaEJZeXg1cXBnZmZuOVAwT2ZlbHJsVGZ1clJaZ1NR?=
 =?utf-8?B?VUpyWFRPejcyZnJzNnZrdmlnKzRNb2ZObkJHZUl6bGRxYnZWRk9aOFN3ZC9y?=
 =?utf-8?B?SDlSaGV5S1lVYzltMDAya3hhMmRLOGo3aHdYWnlVRnAxcnZ2NnRvN2JxcXZI?=
 =?utf-8?B?Q244Y0hBaUpETTlmNUg2eUNjcFRYOFB2L2Rjb1kzTHZua01CREYxSndUYVZp?=
 =?utf-8?B?SUk1eVNMMDcyUVJHUXhGQWE3djdtUk1JOXhBSVhUbk5CQTY3bWFpZ25nUzNM?=
 =?utf-8?B?am9vKzJjRHF3TjBPWmVyVzNQdEFxQTBsRUpIditqUmFKYm5BN3I4cHpEdnM5?=
 =?utf-8?B?UXM2WW5MejVJalVVc25CNzVEQ1A5VTdDaHpQMmI1WDFzWTlPQjgwdGhURDd1?=
 =?utf-8?B?eExOYTlBWWFRQXFoRllROVduMnltNDhFNzZmbFd2b1BXQ0pRWFZSSHYwQndR?=
 =?utf-8?B?d1pVbWdWSTJRK2VDWURWRU1yeU02OWpRZ1BIR2VsVlJWNmpWaEFyTVlqTUpE?=
 =?utf-8?B?RnRYSDRVcmNjR281SE91K3JidE0vcVUyM2djTHBUTUo3VDRLeWpFNFJyaWJi?=
 =?utf-8?B?dHJGMEp4R1JVTGJSRUFsRjlYdithd3V4c0trNmsvM0FFSEVUZGtZTldUS25J?=
 =?utf-8?B?MHhuT1BxUFlNRTRZUjJkWjdDRkkwamRJK2s0S0VBRi8yTmhtOVpzWkY4a01q?=
 =?utf-8?B?U09WVkRIYk1MYitQcXlpZlV5T2RLSmRKNUlGTy9YYUpRR0p3dVh1azFTUWFE?=
 =?utf-8?B?TWRsU0RpR3p6OWhwbkxlKzV0emNZVkxqK3V5dzRSRkRhMmJIOWFFSVUwVlQ1?=
 =?utf-8?B?dGNuQ1B0L1loYTlDMDNnaERPMGVUSi81YnpEeWN2V2g2RDE3b2dVNWhXMFd6?=
 =?utf-8?B?aEdZTDUwaHpQME9yVjl6YU56elNDOGl5VmhoVVM2ajY4YURpQzFNWEVBT2tL?=
 =?utf-8?B?OG16UFdzTFlUci9Rb0FJb3Zib0ozRjhxMExvNlFLTnBMTVU3TGZkUkcyV3I1?=
 =?utf-8?B?TEhzeHJSNEJsVVZaeUxrWlZaZUVOS1c5eFd0QjI0RUdPR2NyVVErY1J1N0Ew?=
 =?utf-8?B?RlR6TUp1L0h1Z3lpSHo1c1VYTmU5KzFFa1hDNU01UnoxVFdPbksyRjlsRnZG?=
 =?utf-8?B?My9SZDZxMDhIM0lHd0FBdjdlMFFUVGhFQVNCdnBlSDlldVplNlFRMktQUmlW?=
 =?utf-8?B?UzJVRlhQbzZ0clRiZDBKbTNVMkRDd1lPZEEvYWMrY09UQmoycW1IUmJ3UC9o?=
 =?utf-8?B?MkNlU2xZdXl1Mm1oc1pWbHE1NmdPTDdNOTkzdkE1ZE5ZNG1PT2tBT3p3YWZX?=
 =?utf-8?B?aFFIQ2E2YndoWlAzdEpXN1NiUEhFaTA2cEV3VGNxcFBqQlFYYlNxanZmMXJR?=
 =?utf-8?B?TFlQSTNNSnZJWVMxM2QwUVgxM09tY1l4V2JDZkppSG5mOUJRNSswcnJlK2s3?=
 =?utf-8?B?ZWpDNS9lYVkwRExtcXpPY2w5ejZzR1QvanY5NjNkbjFNdFBVSUh4Z3JqSFY5?=
 =?utf-8?B?Y3Vzb1F5ZVplQ2E1MzA4NFhGbVkzZ2xJOUpkL01kOXJSSEdVZy9LYUtoN1Nj?=
 =?utf-8?B?TVhKaDU3ck9PSk1tVDRGellUeUp3WHZ0UUtkYzFKTFg1aVBYaHZGaTA4cXNk?=
 =?utf-8?B?TWVZRHF0ekVSWDNRUHk4bFNsZ21aVnRCOHFZcUtRUDZnemk2TGdsM0w0WnJN?=
 =?utf-8?B?K1ltdlBMYlFtZkE4T2VCa2RvcC85aUtQaXhML0JMKysrSDhsanMwRkMyTEZ5?=
 =?utf-8?B?SmtxZWZpQUFoWU1HVnI1MUsxVXFBVWxqSmN2UlVUa0lLWjdhQmJMRERlNzRs?=
 =?utf-8?Q?7z2lrPPmj+LpGmlpO5/Qx4Ekh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd2d61-0544-4ae6-f6d9-08db8cc631cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 04:18:27.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxrbkmfHli+0GIQ42QcX+88PM6jHHp90iZsf8YIEqE3KZHU7OEIx4xwbCZWwrbM/4xiEhBaC4DDpnK4vtuxbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

CgpPbiAyMDIzLTA3LTI0IHAubS4xMTo0MSwgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IE1vbiwgSnVsIDI0LCAyMDIzIGF0IDk6MTTigK9QTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4+Cj4+Cj4+Cj4+IE9uIDIwMjMtMDctMjAgcC5tLjE6MTQsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxp
bmtzIG9yIGF0dGFjaG1lbnRzCj4+Pgo+Pj4KPj4+IE9uIFRodSwgSnVsIDIwLCAyMDIzIGF0IDEw
OjI3OjA0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4gT24gV2VkLCBKdWwgMTksIDIw
MjMgYXQgMTE6NDbigK9QTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4gd3JvdGU6Cj4+Pj4+
Cj4+Pj4+IFRoZSAnaXNfbGVnYWN5JyBmbGFnIGlzIHVzZWQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3
ZWVuIGxlZ2FjeSB2cyBtb2Rlcm4KPj4+Pj4gZGV2aWNlLiBDdXJyZW50bHksIGl0IGlzIGJhc2Vk
IG9uIHRoZSB2YWx1ZSBvZiB2cF9kZXYtPmxkZXYuaW9hZGRyLgo+Pj4+PiBIb3dldmVyLCBkdWUg
dG8gdGhlIHNoYXJlZCBtZW1vcnkgb2YgdGhlIHVuaW9uIGJldHdlZW4gc3RydWN0Cj4+Pj4+IHZp
cnRpb19wY2lfbGVnYWN5X2RldmljZSBhbmQgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2Rldmlj
ZSwgd2hlbgo+Pj4+PiB2aXJ0aW9fcGNpX21vZGVybl9wcm9iZSBtb2RpZmllcyB0aGUgY29udGVu
dCBvZiBzdHJ1Y3QKPj4+Pj4gdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlLCBpdCBhZmZlY3RzIHRo
ZSBjb250ZW50IG9mIHN0cnVjdAo+Pj4+PiB2aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UsIGFuZCBs
ZGV2LmlvYWRkciBpcyBubyBsb25nZXIgemVybywgY2F1c2luZwo+Pj4+PiB0aGUgJ2lzX2xlZ2Fj
eScgZmxhZyB0byBiZSBzZXQgYXMgdHJ1ZS4gVG8gcmVzb2x2ZSBpc3N1ZSwgd2hlbiBsZWdhY3kK
Pj4+Pj4gZGV2aWNlIGlzIHByb2JlZCwgbWFyayAnaXNfbGVnYWN5JyBhcyB0cnVlLCB3aGVuIG1v
ZGVybiBkZXZpY2UgaXMKPj4+Pj4gcHJvYmVkLCBrZWVwICdpc19sZWdhY3knIGFzIGZhbHNlLgo+
Pj4+Pgo+Pj4+PiBGaXhlczogNGYwZmMyMjUzNGUzICgidmlydGlvX3BjaTogT3B0aW1pemUgdmly
dGlvX3BjaV9kZXZpY2Ugc3RydWN0dXJlIHNpemUiKQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBGZW5n
IExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4KPj4+Pj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8
cGFyYXZAbnZpZGlhLmNvbT4KPj4+Pj4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZp
ZGlhLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29t
bW9uLmMgfCAyIC0tCj4+Pj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMg
fCAxICsKPj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlv
bnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
Y29tbW9uLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+Pj4+IGluZGV4
IGE2Yzg2ZjkxNmRiZC4uYzI1MjRhNzIwN2NmIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfY29tbW9uLmMKPj4+Pj4gQEAgLTU1Nyw4ICs1NTcsNiBAQCBzdGF0aWMgaW50IHZpcnRp
b19wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBjaV9kZXYsCj4+Pj4+Cj4+Pj4+ICAgICAgICAg
ICBwY2lfc2V0X21hc3RlcihwY2lfZGV2KTsKPj4+Pj4KPj4+Pj4gLSAgICAgICB2cF9kZXYtPmlz
X2xlZ2FjeSA9IHZwX2Rldi0+bGRldi5pb2FkZHIgPyB0cnVlIDogZmFsc2U7Cj4+Pj4+IC0KPj4+
Pj4gICAgICAgICAgIHJjID0gcmVnaXN0ZXJfdmlydGlvX2RldmljZSgmdnBfZGV2LT52ZGV2KTsK
Pj4+Pj4gICAgICAgICAgIHJlZ19kZXYgPSB2cF9kZXY7Cj4+Pj4+ICAgICAgICAgICBpZiAocmMp
Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+Pj4+PiBpbmRleCAyMjU3ZjFiM2Q4
YWUuLmQ5Y2JiMDJiMzVhMSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9sZWdhY3kuYwo+Pj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2Fj
eS5jCj4+Pj4+IEBAIC0yMjMsNiArMjIzLDcgQEAgaW50IHZpcnRpb19wY2lfbGVnYWN5X3Byb2Jl
KHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2KQo+Pj4+PiAgICAgICAgICAgdnBfZGV2
LT5jb25maWdfdmVjdG9yID0gdnBfY29uZmlnX3ZlY3RvcjsKPj4+Pj4gICAgICAgICAgIHZwX2Rl
di0+c2V0dXBfdnEgPSBzZXR1cF92cTsKPj4+Pj4gICAgICAgICAgIHZwX2Rldi0+ZGVsX3ZxID0g
ZGVsX3ZxOwo+Pj4+PiArICAgICAgIHZwX2Rldi0+aXNfbGVnYWN5ID0gdHJ1ZTsKPj4+Pgo+Pj4+
IFRoaXMgc2VlbXMgYnJlYWsgZm9yY2VfbGVnYWN5IGZvciBtb2Rlcm4gZGV2aWNlOgo+Pj4+Cj4+
Pj4gICAgICAgICAgIGlmIChmb3JjZV9sZWdhY3kpIHsKPj4+PiAgICAgICAgICAgICAgICAgICBy
YyA9IHZpcnRpb19wY2lfbGVnYWN5X3Byb2JlKHZwX2Rldik7Cj4+Pj4gICAgICAgICAgICAgICAg
ICAgLyogQWxzbyB0cnkgbW9kZXJuIG1vZGUgaWYgd2UgY2FuJ3QgbWFwIEJBUjAgKG5vIElPIHNw
YWNlKS4gKi8KPj4+PiAgICAgICAgICAgICAgICAgICBpZiAocmMgPT0gLUVOT0RFViB8fCByYyA9
PSAtRU5PTUVNKQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmMgPSB2aXJ0aW9fcGNp
X21vZGVybl9wcm9iZSh2cF9kZXYpOwo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pgo+Pj4gZG9uJ3Qgc2Vl
IHRoZSBicmVha2FnZSBoZXJlIC0gY2FuIHlvdSBleHBsYWluIGEgYml0IG1vcmU/Cj4+Pgo+PiBI
aSwgSmFzb24KPj4KPj4gSSBhbHNvIHRoaW5rIHRoZXJlIGlzIG5vIGJyZWFrYWdlIGhlcmVhIGFu
ZCBnYXZlIGFuIGV4cGxhbmF0aW9uIGluCj4+IGFub3RoZXIgZW1haWwsIHBsZWFzZSBoYXZlIGEg
c2VlLgo+IAo+IEkgdGhpbmsgSSd2ZSBtYWRlIGEgbWlzdGFrZSwgdGhlIHBhdGNoIHNob3VsZCBi
ZSBmaW5lLgo+IAo+Pgo+PiBTbyBhcmUgdGhlcmUgYW55IGNvbW1lbnRzIGFib3V0IHRoaXMgYnVn
IGZpeCBwYXRjaD8gQ2FuIHRoaXMgcGF0Y2ggcGFzcwo+PiB0aGUgcmV2aWV3Pwo+IAo+IFllcy4K
PiAKPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAKPiBUaGFu
a3MKPiAKClRoYW5rcyBKYXNvbgoKPj4KPj4gVGhhbmtzCj4+IEZlbmcKPj4KPj4+Pj4KPj4+Pj4g
ICAgICAgICAgIHJldHVybiAwOwo+Pj4+PiAgICB9Cj4+Pj4+IC0tCj4+Pj4+IDIuMzcuMSAoQXBw
bGUgR2l0LTEzNy4xKQo+Pj4+Pgo+Pj4KPj4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
