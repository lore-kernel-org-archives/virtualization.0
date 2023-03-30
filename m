Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BCCC7619A
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 23:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3DD6C405BB;
	Thu, 30 Mar 2023 23:46:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DD6C405BB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ICpdELqt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PS5payCa2eh4; Thu, 30 Mar 2023 23:46:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A39F40459;
	Thu, 30 Mar 2023 23:46:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A39F40459
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37BD2C0037;
	Thu, 30 Mar 2023 23:46:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CBCC002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 23:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E480D60AE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 23:46:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E480D60AE3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ICpdELqt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jX3TQcZqG2rc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 23:46:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DB6860ACC
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DB6860ACC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 23:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3XL/ZNOCyjYZcXXGisbtt9owD8NA12Quyu5SpkjnhHsfZ2D3JJLsjqWg/F7oSwIXB+Yf2+F6diTNZiiSJslPlkVMcAM90PcUiZhlnW+qAwOcDLZfLi/ntnnuTJ64qGkXDRg8+T+nDkAYeQOoDjeXZPrkIU8FXk5Uo9DZdifh+hnGIBbX/MAXFP1vsJxK7hykaPLga2aMJid2lVk5/HSd9AD89BBe/VD3Y4sd+Sob+k7bJ/OqPELAgY56CDqNz88nGZPQ5YTRBpg0pEEeIhjSv7qVoF451ZVYXljS3ZxaIf6JfgKWivX2N0opXdiBFiPDcFbwsdonQ1WStLAYRiN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO2xNmAthg562DtevGiJ+4Tv8tKhxN8vKnEZXlnd8sU=;
 b=h+UdldK122CXDM69ARhsmJp8Wxs+/XIivyCBZ5vvagmHn/n8JhA4OMl9HaWETkTXqerFhkIIvcwu1xXg/ubs90091JoydKMQzRIpA9L0qhkCyNm8/Slsyp3JKFfWZiAQbgrb7RhV+LUGuGScTgtmxExNJ0FkdbKYcoVFLR/4fl+3eTHJ8AckVOU8a016E18Wky7S0AZ6X7g0/+WjPs3JPvolyyBKxc5HDeqW2duneducKpAyf2Wiyu8VyTWh8n2PwddGTZ8L7wTbmoMAxVKVdLkC+XsFYR5zGmt7HoB10IZpxMDl6Q+PB7SB0lcWYl7dvRsxDH2tl/vBcUTQKYzP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO2xNmAthg562DtevGiJ+4Tv8tKhxN8vKnEZXlnd8sU=;
 b=ICpdELqtk/dkwK8JTMcO8+Ry/snIpCpeVKbkzI+8tZq9C6toKD7Ll8No0zU80ayAGfmZ+jK/9CkiFgIzf/eKHYQP5Mt+TB8zaok6GTypAEd+U4n2MoLT2cc574BCZY+jXqv8EXhHTKUAnkzQfvJzq0yr0a0oXSCY2egnIs5GT1GoEAoWPPirE9KhAlsfTFLQTbisfoZggnozFqAYDSrcXk/WWO+gEEulR4X9RKZ5CJ5+ybW0wZVhB9JHzjOj7YaNoj4+KW9pb+pBZcH/Gu4ZisbJA8sqPwTvUIHqPSmbzd9ogbFVwBQ7r4uQkZkJpGcwPJU1fXvxNomSaX/+NSBFzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 23:46:07 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 23:46:07 +0000
Message-ID: <ae790204-77ca-c27b-1cf5-f0f14ab66ca1@nvidia.com>
Date: Thu, 30 Mar 2023 19:46:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] virtio_ring: Use const to annotate read-only
 pointer params
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-4-feliu@nvidia.com>
 <CACGkMEtCL=fF9KEsLj-n7t3LQT0ckRXHx61FqTOiXBq02Mgk1A@mail.gmail.com>
 <7230d466-8d96-80f2-fd9a-362d965f30bd@nvidia.com>
 <20230330162641-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230330162641-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: DM6PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:5:333::34) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CH0PR12MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ed80c0-7c87-4691-260d-08db3178ee6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWzSyHM+5uOGcKjupl6xC3BC2oQLuuiSJ22csUPLyRfW9gUAntkdcrNfnuBDEzd32WpK8F6Yj8w3rt4D1RAiNjTmjFShvmkdmmSxQ/treWVMCfWt9zxjI3FHnRGqNGKe0rTLahJUDtZmj4CsUn6mbC+M+RxjaomOI9nTRr9RHYNE5tIA1B2E/MOqzQXGBLsx6TbcEcWSx4IivfSoZ/ofR27VDCnKnFLjg5cthHO3qYniUx1ni9qLGwKWMQulN6ntxBpfDoe4IbbV2X/X5haK6sCayppmcuLBxWXK5KRFfGlCFcFo4JRLxVMG9OGL+uxhqFIzx2ib//aL18BCkzC5rpGhXA5FhxBD/kVNnuZzDdmNIRkSyEyKysbpq1bJVcl1VXGYasgnZ6rVBqbRUyW1IYtzCYPcwyFkXc414YqXI6ZEAIjrepMm1q7kT4dr0uzPXRHpEpcg+y2SWG1v5poGx5YxNvisylWLVvLnqpRtHTMkq3jtxORkvs/D6e3CVwokktpO8nomrDJdyhUdrGNGiIZys0ob6G7wK70CfGjlAgsfv2BMv4Q1nxO31fGhGKyN4Q8Utx4mNYbGKyCWW6SksBheAq9xT5DtkeYOc6ujVQpbo1df2v5XU7SBEtqxtXPSdrDpaTsHeRNN+LgydX6Gxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(53546011)(26005)(6512007)(41300700001)(6506007)(186003)(6666004)(107886003)(6486002)(83380400001)(31686004)(2616005)(478600001)(54906003)(316002)(38100700002)(66476007)(4326008)(66556008)(6916009)(66946007)(5660300002)(2906002)(8676002)(86362001)(36756003)(31696002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU05cXVNM0lqODRsWTRpbDJ2QUNTQlpDWlUrc0l3emExcVd1cldESlYxeFNJ?=
 =?utf-8?B?ank4L3drSXNGanJ1UTlZN2RSWElNMlROcjJHL2xXblVTNk8xRUtpckFyTU0v?=
 =?utf-8?B?dmZwTDVoZ242WWVPRkI5L2U4N2FwbU80UkFHL0xhQlNES0k2REhWL0hVa09M?=
 =?utf-8?B?ajhWbzNDTjU2SHBSanBSU0NOdGQ2U3B5RTdwQ1IxeDhKSHRsZ0k1clVUTDRp?=
 =?utf-8?B?cGhiYTVJNTZFZlZtWXZybUJDeFpETUZjRGVmQ21UZ0pjREpiVGdNZnR5M0dF?=
 =?utf-8?B?b0I3WFZvRzN6bFY5UXJtS1paREtzQ0NjTXpxUFBwT0dhVThybitCNlB3QjNk?=
 =?utf-8?B?b0praU9uTjMxOUJEa3grdG9QS0VkS0gxcEYxVzZRTVFUc0JzOTlTYURUU0sx?=
 =?utf-8?B?UzJ6TVRudzZVUkk2VzlMSGpxdGZNK3dmUG02STg4bUJyU3RlbW1reVE3cDdi?=
 =?utf-8?B?K3Z1TVN1RS8yL3lEUnp3MFNtR2hrUFFIZFRPSUo3bFFlUXNiaGF3K2ZsU2NG?=
 =?utf-8?B?SE0ydWh3VXVtNmZQcUpBL0ZRQTlrWHc0TEl3SFpodEFHQTBOQlZIQ3BOcVVq?=
 =?utf-8?B?d0xsRys1TWFBeWI3MU9Jbyt6aFV6OVE1TWp5VUNtdVhUUVR0VzJ1OUhKUXVW?=
 =?utf-8?B?M3JWVXJEMk40RURmSjBLRlcrdEUyaWpTODBqeGFFcEFMVjAzOU83YTVlWk8r?=
 =?utf-8?B?SEh4SW81U1pvUGFza1FDOG5QMkFnYVFoRy9IQjRFelQwaW9ad2FmRGxFUXE1?=
 =?utf-8?B?VURvODdGRjM2L1duVDNXZGFKaHY3SjlUN3hRWS93MTUwSUs0OENuWmZKWDgx?=
 =?utf-8?B?RFh1bCtIaUY5TlVVL0Nlejh2YlRnMHZTcFM5eW8wWG1GdS9SUjI4cmV3R29u?=
 =?utf-8?B?SjY2cUphSlJTL3FFQkVqS1lERkw3OGhubmRTVC9aaHhVSkZJRml4Rzh0M0pL?=
 =?utf-8?B?eDFjblFQL2NYcVAxVEx3bzY3ZXdJaVAyU1FQTWFQNUVaWTNwREpVQjN1Y0p6?=
 =?utf-8?B?RStBU3NmTDZ0b0hFYXFDNE1tR0taV0FuRnhaRnlwNE5lOG55czN0SlNHOFJH?=
 =?utf-8?B?dWNFOVFUTTBXSHdWSU1xYmM3dU9GR05TUDl1VjRvdE5zaEV1YVpwak9meVc5?=
 =?utf-8?B?SEVqZmdJWDdkdDczNTU0TnQ3VkdjSFRzYllIVDlmbjhtQWorRkh6ZlNhUzg2?=
 =?utf-8?B?YVgwc0NsZ3JyUloxT3N3WFc3VXNOd2hGTEVXYmFYUDFYOHozcllnckxJZ3hP?=
 =?utf-8?B?N055SFRMYmNxelQyaWtVNTBFQmFBaHRDKzU3Zm1rd0tlY0UwalJBMW9YdHZ6?=
 =?utf-8?B?VjNzNitjSnNSMks2TWFDR3BpNUkyTi9wWnYzMlV6ZndLVFBtdmZ3cTdtZjJw?=
 =?utf-8?B?Vm84SVZvM0VsNVE4QTF2d2pKdnlpZWFRdStlbjRkSzhVa0pZYWZCOGRZRS9o?=
 =?utf-8?B?Q3BiUk5hdFdVV1U0eUtUY01CQzBYQVVuY2dNTDFwaG9HUGs2Mmxta3MvSjF6?=
 =?utf-8?B?bnpVcXNZcUJ5VXVCYmJ1bXpNV0N4U1hKM095S2xDZS9KM05XVWp4WUVCTWh6?=
 =?utf-8?B?TWtUVmVIMkFyelJXSVduSnRKc2Vka1RBdFNhM2ZQZVlhRDFocDQzNWRIRUtZ?=
 =?utf-8?B?bjRETTNabndYOVBNNXVoNmxBd0VCZGdnRFN4Q25Vc0NYSDZrUFZueTZ0Nm14?=
 =?utf-8?B?Unh6UGppb2NHTTNITmtReWptT1E5cFhpYStnTHNxMElDaE1DbXVDQXA4US9J?=
 =?utf-8?B?bFVoQnAwOE5QeVo2MWFBKzNwMk9pV2VOcnhGcUUrZTNhaG1GWUR6eDZNMkZT?=
 =?utf-8?B?VU0rZlEwUjNNc0Z4ZzhhR0crUEY4TDJtR0gvbnNCSGVoMzZ2ZjdFcVlEVnJ1?=
 =?utf-8?B?eUJxZzRaSmsvSU9TZ3FXc0plZnBIYzNrZkFKVEFGR2J0Mm1QU0VsVFlYSEFp?=
 =?utf-8?B?NVFjajlnNEJQTVhwUG5lT01xNUxldUxPd1lYQ29KQzVFOFdteU1HNlhrWC9H?=
 =?utf-8?B?bnVIZkZXbzhSbkhGcTVhNS9xcUphQUtBa0NtdGdOWXkzWmxuckdybHkxOGdi?=
 =?utf-8?B?UW85Smh1YlNBbHludCs4SU5pTmZhNUxNMXp6dVN5RWZpbndSZVdEbkJLUU1G?=
 =?utf-8?Q?7cyN0KCPLQqvBrHmJcIDbYvMV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed80c0-7c87-4691-260d-08db3178ee6d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 23:46:07.0909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69SpUPkeJbFEsq5hyC9AABHfFk7EsFMuwFnoyIxDfJ7HZ1o8E//MCTuUXz3g4IF5LPoc/fQ/KMAP20zuJIP0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

CgpPbiAyMDIzLTAzLTMwIHAubS40OjI3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPiAK
PiAKPiBPbiBUaHUsIE1hciAzMCwgMjAyMyBhdCAwMjoyMjo0NFBNIC0wNDAwLCBGZW5nIExpdSB3
cm90ZToKPj4KPj4KPj4gT24gMjAyMy0wMy0xNiBwLm0uMTE6MTcsIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cwo+Pj4KPj4+Cj4+PiBPbiBUaHUsIE1hciAxNiwgMjAyMyBhdCAyOjU14oCvQU0gRmVuZyBM
aXUgPGZlbGl1QG52aWRpYS5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gQWRkIGNvbnN0IHRvIG1ha2Ug
dGhlIHJlYWQtb25seSBwb2ludGVyIHBhcmFtZXRlcnMgY2xlYXIsIHNpbWlsYXIgdG8KPj4+PiBt
YW55IGV4aXN0aW5nIGZ1bmN0aW9ucy4KPj4+Pgo+Pj4+IFVzZSBgY29udGFpbmVyX29mX2NvbnN0
YCB0byBpbXBsZW1lbnQgYHRvX3Z2cWAsIHdoaWNoIGVuc3VyZXMgdGhlCj4+Pj4gY29uc3QtbmVz
cyBvZiByZWFkLW9ubHkgcGFyYW1ldGVycyBhbmQgYXZvaWRzIGFjY2lkZW50YWwgbW9kaWZpY2F0
aW9uCj4+Pj4gb2YgdGhlaXIgbWVtYmVycy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbmcg
TGl1IDxmZWxpdUBudmlkaWEuY29tPgo+Pj4+IFJldmlld2VkLWJ5OiBKaXJpIFBpcmtvIDxqaXJp
QG52aWRpYS5jb20+Cj4+Pgo+Pj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+Cj4+Pgo+Pj4gVGhhbmtzCj4+Pgo+PiBIaSBNaWNoYWVsICYgSmFzb24KPj4gICAgICAg
ICAgQ291bGQgeW91IHBsZWFzZSBoZWxwIHRvIHRha2UgdGhlc2UgcmV2aWV3ZWQvYWNrZWQgcGF0
Y2hlcyBmb3J3YXJkPwo+PiBUaGFua3Mgc28gbXVjaAo+IAo+IAo+IHRoaXMgaXMgbm90IGdvaW5n
IGluIHRoaXMgbGludXgsIG9ubHkgdGhlIG5leHQuCj4gCkhpLCBNaWNoYWVsCglUaGFua3MgZm9y
IHRoZSB1cGRhdGUuCgo+Pgo+Pj4+Cj4+Pj4gLS0tCj4+Pj4gdjAgLT4gdjEKPj4+PiBmZWVkYmFj
a3MgZnJvbSBNaWNoYWVsIFMuIFRzaXJraW4KPj4+PiAtIHVzZSBgY29udGFpbmVyX29mX2NvbnN0
YCB0byBpbXBsZW1lbnQgYHRvX3Z2cWAKPj4+PiAtLS0KPj4+PiAgICBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jIHwgMzYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCj4+
Pj4gICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8IDE0ICsrKysrKystLS0tLS0tCj4+
Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkK
Pj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4+IGluZGV4IGEyNmZhYjkxYzU5Zi4uNGMzYmIw
ZGRlYjliIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+Pj4gQEAgLTIzMSw5ICsyMzEs
OSBAQCBzdGF0aWMgdm9pZCB2cmluZ19mcmVlKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+Pj4g
ICAgICogSGVscGVycy4KPj4+PiAgICAgKi8KPj4+Pgo+Pj4+IC0jZGVmaW5lIHRvX3Z2cShfdnEp
IGNvbnRhaW5lcl9vZihfdnEsIHN0cnVjdCB2cmluZ192aXJ0cXVldWUsIHZxKQo+Pj4+ICsjZGVm
aW5lIHRvX3Z2cShfdnEpIGNvbnRhaW5lcl9vZl9jb25zdChfdnEsIHN0cnVjdCB2cmluZ192aXJ0
cXVldWUsIHZxKQo+Pj4+Cj4+Pj4gLXN0YXRpYyBib29sIHZpcnRxdWV1ZV91c2VfaW5kaXJlY3Qo
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4+Pj4gK3N0YXRpYyBib29sIHZpcnRxdWV1ZV91
c2VfaW5kaXJlY3QoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB0b3RhbF9zZykKPj4+
PiAgICB7Cj4+Pj4gICAgICAgICAgIC8qCj4+Pj4gQEAgLTI2OSw3ICsyNjksNyBAQCBzdGF0aWMg
Ym9vbCB2aXJ0cXVldWVfdXNlX2luZGlyZWN0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+
Pj4+ICAgICAqIHVuY29uZGl0aW9uYWxseSBvbiBkYXRhIHBhdGguCj4+Pj4gICAgICovCj4+Pj4K
Pj4+PiAtc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9hcGkoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYpCj4+Pj4gK3N0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKGNvbnN0IHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4+ICAgIHsKPj4+PiAgICAgICAgICAgaWYgKCF2aXJ0aW9f
aGFzX2RtYV9xdWlyayh2ZGV2KSkKPj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsK
Pj4+PiBAQCAtMjg5LDcgKzI4OSw3IEBAIHN0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4+ICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+
Pj4gICAgfQo+Pj4+Cj4+Pj4gLXNpemVfdCB2aXJ0aW9fbWF4X2RtYV9zaXplKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+Pj4+ICtzaXplX3QgdmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+PiAgICB7Cj4+Pj4gICAgICAgICAgIHNpemVf
dCBtYXhfc2VnbWVudF9zaXplID0gU0laRV9NQVg7Cj4+Pj4KPj4+PiBAQCAtNDIzLDcgKzQyMyw3
IEBAIHN0YXRpYyB2b2lkIHZpcnRxdWV1ZV9pbml0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZx
LCB1MzIgbnVtKQo+Pj4+ICAgICAqLwo+Pj4+Cj4+Pj4gICAgc3RhdGljIHZvaWQgdnJpbmdfdW5t
YXBfb25lX3NwbGl0X2luZGlyZWN0KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJp
bmdfZGVzYyAqZGVzYykKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3Qgc3RydWN0IHZyaW5nX2Rlc2MgKmRlc2MpCj4+Pj4gICAgewo+Pj4+ICAgICAg
ICAgICB1MTYgZmxhZ3M7Cj4+Pj4KPj4+PiBAQCAtMTE4Myw3ICsxMTgzLDcgQEAgc3RhdGljIHUx
NiBwYWNrZWRfbGFzdF91c2VkKHUxNiBsYXN0X3VzZWRfaWR4KQo+Pj4+ICAgIH0KPj4+Pgo+Pj4+
ICAgIHN0YXRpYyB2b2lkIHZyaW5nX3VubWFwX2V4dHJhX3BhY2tlZChjb25zdCBzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSwKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhKQo+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqZXh0cmEp
Cj4+Pj4gICAgewo+Pj4+ICAgICAgICAgICB1MTYgZmxhZ3M7Cj4+Pj4KPj4+PiBAQCAtMTIwNiw3
ICsxMjA2LDcgQEAgc3RhdGljIHZvaWQgdnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKGNvbnN0IHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+Pj4+ICAgIH0KPj4+Pgo+Pj4+ICAgIHN0YXRpYyB2
b2lkIHZyaW5nX3VubWFwX2Rlc2NfcGFja2VkKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxLAo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZyaW5n
X3BhY2tlZF9kZXNjICpkZXNjKQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqZGVzYykKPj4+PiAgICB7Cj4+Pj4g
ICAgICAgICAgIHUxNiBmbGFnczsKPj4+Pgo+Pj4+IEBAIC0yNzg2LDEwICsyNzg2LDEwIEBAIEVY
UE9SVF9TWU1CT0xfR1BMKHZyaW5nX3RyYW5zcG9ydF9mZWF0dXJlcyk7Cj4+Pj4gICAgICogUmV0
dXJucyB0aGUgc2l6ZSBvZiB0aGUgdnJpbmcuICBUaGlzIGlzIG1haW5seSB1c2VkIGZvciBib2Fz
dGluZyB0bwo+Pj4+ICAgICAqIHVzZXJzcGFjZS4gIFVubGlrZSBvdGhlciBvcGVyYXRpb25zLCB0
aGlzIG5lZWQgbm90IGJlIHNlcmlhbGl6ZWQuCj4+Pj4gICAgICovCj4+Pj4gLXVuc2lnbmVkIGlu
dCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICt1
bnNpZ25lZCBpbnQgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKGNvbnN0IHN0cnVjdCB2aXJ0cXVl
dWUgKl92cSkKPj4+PiAgICB7Cj4+Pj4KPj4+PiAtICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+Pj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+Pj4+Cj4+Pj4gICAgICAgICAgIHJldHVybiB2cS0+
cGFja2VkX3JpbmcgPyB2cS0+cGFja2VkLnZyaW5nLm51bSA6IHZxLT5zcGxpdC52cmluZy5udW07
Cj4+Pj4gICAgfQo+Pj4+IEBAIC0yODE5LDkgKzI4MTksOSBAQCB2b2lkIF9fdmlydHF1ZXVlX3Vu
YnJlYWsoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICAgIH0KPj4+PiAgICBFWFBPUlRfU1lN
Qk9MX0dQTChfX3ZpcnRxdWV1ZV91bmJyZWFrKTsKPj4+Pgo+Pj4+IC1ib29sIHZpcnRxdWV1ZV9p
c19icm9rZW4oc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICtib29sIHZpcnRxdWV1ZV9pc19i
cm9rZW4oY29uc3Qgc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICAgIHsKPj4+PiAtICAgICAg
IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+Pj4gKyAgICAgICBj
b25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+Pj4+Cj4+Pj4g
ICAgICAgICAgIHJldHVybiBSRUFEX09OQ0UodnEtPmJyb2tlbik7Cj4+Pj4gICAgfQo+Pj4+IEBA
IC0yODY4LDkgKzI4NjgsOSBAQCB2b2lkIF9fdmlydGlvX3VuYnJlYWtfZGV2aWNlKHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICpkZXYpCj4+Pj4gICAgfQo+Pj4+ICAgIEVYUE9SVF9TWU1CT0xfR1BMKF9f
dmlydGlvX3VuYnJlYWtfZGV2aWNlKTsKPj4+Pgo+Pj4+IC1kbWFfYWRkcl90IHZpcnRxdWV1ZV9n
ZXRfZGVzY19hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4+PiArZG1hX2FkZHJfdCB2aXJ0
cXVldWVfZ2V0X2Rlc2NfYWRkcihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+Pj4gICAg
ewo+Pj4+IC0gICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
Pj4+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92
cSk7Cj4+Pj4KPj4+PiAgICAgICAgICAgQlVHX09OKCF2cS0+d2Vfb3duX3JpbmcpOwo+Pj4+Cj4+
Pj4gQEAgLTI4ODEsOSArMjg4MSw5IEBAIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9kZXNjX2Fk
ZHIoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICAgIH0KPj4+PiAgICBFWFBPUlRfU1lNQk9M
X0dQTCh2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRkcik7Cj4+Pj4KPj4+PiAtZG1hX2FkZHJfdCB2aXJ0
cXVldWVfZ2V0X2F2YWlsX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICtkbWFfYWRk
cl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICpfdnEp
Cj4+Pj4gICAgewo+Pj4+IC0gICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192
dnEoX3ZxKTsKPj4+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0g
dG9fdnZxKF92cSk7Cj4+Pj4KPj4+PiAgICAgICAgICAgQlVHX09OKCF2cS0+d2Vfb3duX3Jpbmcp
Owo+Pj4+Cj4+Pj4gQEAgLTI4OTUsOSArMjg5NSw5IEBAIGRtYV9hZGRyX3QgdmlydHF1ZXVlX2dl
dF9hdmFpbF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4+PiAgICB9Cj4+Pj4gICAgRVhQ
T1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKTsKPj4+Pgo+Pj4+IC1kbWFf
YWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4+
PiArZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X3VzZWRfYWRkcihjb25zdCBzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEpCj4+Pj4gICAgewo+Pj4+IC0gICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEgPSB0b192dnEoX3ZxKTsKPj4+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+Pj4KPj4+PiAgICAgICAgICAgQlVHX09OKCF2cS0+d2Vf
b3duX3JpbmcpOwo+Pj4+Cj4+Pj4gQEAgLTI5MTAsNyArMjkxMCw3IEBAIGRtYV9hZGRyX3Qgdmly
dHF1ZXVlX2dldF91c2VkX2FkZHIoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4+ICAgIEVYUE9S
VF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKTsKPj4+Pgo+Pj4+ICAgIC8qIE9u
bHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4+Pj4gLWNvbnN0IHN0cnVjdCB2cmluZyAq
dmlydHF1ZXVlX2dldF92cmluZyhzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPj4+PiArY29uc3Qgc3Ry
dWN0IHZyaW5nICp2aXJ0cXVldWVfZ2V0X3ZyaW5nKGNvbnN0IHN0cnVjdCB2aXJ0cXVldWUgKnZx
KQo+Pj4+ICAgIHsKPj4+PiAgICAgICAgICAgcmV0dXJuICZ0b192dnEodnEpLT5zcGxpdC52cmlu
ZzsKPj4+PiAgICB9Cj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvLmggYi9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4+Pj4gaW5kZXggMmI0NzI1MTRjNDliLi5jNDIyNTY1M2Y5
NDkgMTAwNjQ0Cj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+Pj4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvdmlydGlvLmgKPj4+PiBAQCAtODQsMTQgKzg0LDE0IEBAIGJvb2wgdmlydHF1
ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4+Pgo+Pj4+ICAg
IHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7
Cj4+Pj4KPj4+PiAtdW5zaWduZWQgaW50IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShzdHJ1Y3Qg
dmlydHF1ZXVlICp2cSk7Cj4+Pj4gK3Vuc2lnbmVkIGludCB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3Np
emUoY29uc3Qgc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+Pj4+Cj4+Pj4gLWJvb2wgdmlydHF1ZXVl
X2lzX2Jyb2tlbihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4+Pj4gK2Jvb2wgdmlydHF1ZXVlX2lz
X2Jyb2tlbihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4+Pj4KPj4+PiAtY29uc3Qgc3Ry
dWN0IHZyaW5nICp2aXJ0cXVldWVfZ2V0X3ZyaW5nKHN0cnVjdCB2aXJ0cXVldWUgKnZxKTsKPj4+
PiAtZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2
cSk7Cj4+Pj4gLWRtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF9hdmFpbF9hZGRyKHN0cnVjdCB2aXJ0
cXVldWUgKnZxKTsKPj4+PiAtZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X3VzZWRfYWRkcihzdHJ1
Y3QgdmlydHF1ZXVlICp2cSk7Cj4+Pj4gK2NvbnN0IHN0cnVjdCB2cmluZyAqdmlydHF1ZXVlX2dl
dF92cmluZyhjb25zdCBzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4+Pj4gK2RtYV9hZGRyX3Qgdmly
dHF1ZXVlX2dldF9kZXNjX2FkZHIoY29uc3Qgc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+Pj4+ICtk
bWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihjb25zdCBzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSk7Cj4+Pj4gK2RtYV9hZGRyX3QgdmlydHF1ZXVlX2dldF91c2VkX2FkZHIoY29uc3Qgc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEpOwo+Pj4+Cj4+Pj4gICAgaW50IHZpcnRxdWV1ZV9yZXNpemUoc3Ry
dWN0IHZpcnRxdWV1ZSAqdnEsIHUzMiBudW0sCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICB2
b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikpOwo+Pj4+IEBA
IC0xNDcsNyArMTQ3LDcgQEAgaW50IHZpcnRpb19kZXZpY2VfcmVzdG9yZShzdHJ1Y3QgdmlydGlv
X2RldmljZSAqZGV2KTsKPj4+PiAgICAjZW5kaWYKPj4+PiAgICB2b2lkIHZpcnRpb19yZXNldF9k
ZXZpY2Uoc3RydWN0IHZpcnRpb19kZXZpY2UgKmRldik7Cj4+Pj4KPj4+PiAtc2l6ZV90IHZpcnRp
b19tYXhfZG1hX3NpemUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpOwo+Pj4+ICtzaXplX3Qg
dmlydGlvX21heF9kbWFfc2l6ZShjb25zdCBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4+
Pj4KPj4+PiAgICAjZGVmaW5lIHZpcnRpb19kZXZpY2VfZm9yX2VhY2hfdnEodmRldiwgdnEpIFwK
Pj4+PiAgICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSh2cSwgJnZkZXYtPnZxcywgbGlzdCkK
Pj4+PiAtLQo+Pj4+IDIuMzQuMQo+Pj4+Cj4+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
