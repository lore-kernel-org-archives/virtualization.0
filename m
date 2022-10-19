Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3D6C4321E
	for <virtualization@archiver.kernel.org>; Wed, 19 Oct 2022 11:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1565283F12;
	Wed, 19 Oct 2022 11:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1565283F12
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=qw1mMQur
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9vzM-CmvCWV; Wed, 19 Oct 2022 11:06:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2ED383F11;
	Wed, 19 Oct 2022 11:06:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2ED383F11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE02C0032;
	Wed, 19 Oct 2022 11:06:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDCF8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 11:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A289C60C17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 11:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A289C60C17
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com
 header.a=rsa-sha256 header.s=selector2 header.b=qw1mMQur
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlWEWxS1ArRo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 11:06:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EF3060B4D
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140094.outbound.protection.outlook.com [40.107.14.94])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EF3060B4D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 11:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJhmopj2H7hFOJsYd2E+z4cIaukNLQ4DxPfDcQAR2UXZoEOUG73446xgNGFOxKIlJzQ3PZ+m/FvVtIWDrAJteGmXcp6eH2Q5lbKRcl+AWp839w5mY78LvLUwZFn68mI9l6AfA7uFnb1yx5oXqEHaIh1tJbEL4lMRy6NfHnEVmrDb2pdVyDI+JZuera0YyCjr3XceysDz7dl5fQ6FI7/1yA6EPoIzbSJgk8bEicd8adBb4ZNgLlZ6buyG/zzPMemor49JXko7+UlFYZK5PbA+sY+ZLewSLTWQJRNygobqord+2m8VJfTGpVpAIQgqW7IwgjzPVbDiQdI3rH15nJPcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhltnm+rSwr6w0Xbd8xf08MBurU4Rs3LaoB4CsMhb5M=;
 b=nRmS2xIpIIWWRBpQIvHAC/VNTeREoEdX5EOHR5G/zB76KMiBuXDlJSSsUF2HHgFA6j+gnl9JX1ks+cElwwyePFwW9hU6nYWJLUaGv6P/DpJxTsr1OI4UBeYQ7UyKsgMjbFLcgzHjen38JjwSCjhgYlc7fzuDpIRcDg62kO/PuJ7xYnIxD/3KwViFaTFsPGswv/NWDtuS7tqf+PFKGEc4hqBG36lej44XBmsZXYktZiER6XPR4bZhG9k7ccshOS1xI02BOQEsB+wcvMP7YljXteyq42ZXBzOyV73/SdhENNjPEwJGqNr19DHuhFoFn+hD4IBJZzlgZSJPE1iNQ0HElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhltnm+rSwr6w0Xbd8xf08MBurU4Rs3LaoB4CsMhb5M=;
 b=qw1mMQurUqW4KCJL803lSNYsN6kH9ln8D439d/qZTWUjX9MzE0EjSXzpw46m/ZeiQMCqYrg9s+ieJJAB/62m/7nRqnxw2uLdiAsa+hx5P+LZWOfLlU0KXEDG2kSGPnC05b7SqjI1/5rDLOdzIzmpoOxEhYsoUam1jkk3KZZvQSDsZ/rQdaFxhwlF2dHKpU51CEIoHQo7f+wQRMyPIse1ehcyxIXXlpZ43y1kh1qtxn6t500ocP6+vtuLM7Qx4Z8qUKRJlMHCrh7Y0o8++rf5G5Z8tYcSq9S9nx5CeUC9zYamIfA0MSu3VQC8xKwBI3u00fzvVxsbDhvve7ZN0SAtZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9473.eurprd08.prod.outlook.com (2603:10a6:20b:5ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 11:06:05 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c82b:333d:9400:dbc9]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::c82b:333d:9400:dbc9%5]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 11:06:04 +0000
Message-ID: <1c69ff97-831d-ece3-7a52-bb7659fc8dd4@virtuozzo.com>
Date: Wed, 19 Oct 2022 13:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH v5 0/8] Make balloon drivers' memory changes known to
 the rest of the kernel
Content-Language: en-US
To: Konstantin Khlebnikov <koct9i@gmail.com>,
 Alexander Atanasov <alexander.atanasov@virtuozzo.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <CALYGNiONv3au6hbAva60jWurwkU5ancWo-o2v7tpSzwguqzD9g@mail.gmail.com>
In-Reply-To: <CALYGNiONv3au6hbAva60jWurwkU5ancWo-o2v7tpSzwguqzD9g@mail.gmail.com>
X-ClientProxiedBy: VI1PR09CA0112.eurprd09.prod.outlook.com
 (2603:10a6:803:78::35) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3f68f1-5ba8-475c-7d93-08dab1c1ea21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGf7Hq+IzikwzXW1di0MGYMno4UujJoHWEWKAy8hqrAGi+dLfqOTkwwSGSYwRbKNi2daon24CGDvg8qUwXVcwxCksIYGnu3G4dckVm75hpkbBuCU+BXSXzw8ZJSqL0VCjdiP7y6EsszNlLfghLB1aXsQlr3Rirj1/ju5y/tOUdn5Hao8ogBNUhEZOC92CUJU4Ljnlvi/PeBJRTeuG7R1AsTu9cAj4MLov4MvfuYIX0tGDkfCJL955TghoLXhyXnncC8upO9XmOqyWvo7x20F1nPFoxnks+5ZmcVxW6zBW2rVeAZDl9fwI2/wz4zT3s7+4U26YIIil0sPf9QEpzU8i3U1w24ddabKAS6L7BAD/MwpFtps1/lClYKN4sy2+VsrmuZ4sozExGfE2Pi0OdKBQI4arEOdeydknHSSDbj5uoNrDfS8V46jR1Qv1neTWd6ILriiNy/KFp5+jEze2R2F1LYGautSTW/mESqqbUZAQ2A0R6QKeStaXMP2JfInEaR/DvNaK0q0s4QN93bNqnj6GDfpl+ZW/rN9VtYXDq1EbDSX9qA9ONLS5L9iDj8fJQMJNJgTTYZhIfykhkM2H9+/n0pMy2qFx6g3q0ek0p12hNEXnkhk28/+qwAlhH+e3PJqqChbBdA0iH7XXAMZA0zBKh43GlVWwwWOsvbmQnGIIbBEKd3az0sMtoGdGTk8MSBtBrd73ji8s1sDnBUcBFWE731BwauCmeDVCYWpUZ3IqWrMTrq2itVB7DJoyg09jQ2XOUJNFr6Z0VbyiZUoLn6cqVUD6EKJbCnRoNT9UeLYbdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39850400004)(346002)(136003)(376002)(366004)(396003)(451199015)(2906002)(186003)(38100700002)(2616005)(6486002)(478600001)(45080400002)(54906003)(6636002)(86362001)(66476007)(66946007)(8676002)(66556008)(4326008)(110136005)(8936002)(31686004)(6512007)(6506007)(26005)(36756003)(53546011)(31696002)(83380400001)(41300700001)(7416002)(316002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJxd243Ymd2czA3Qy9pYnVhUlNRbWthL1hNaG5rb2oyZFRvNTNlK2xCUkZM?=
 =?utf-8?B?OU1UYTZ3a2w1cU5yM2tOOC9jdmw0SkpVa04remRZK1dWc3lGdWorcGloaWVv?=
 =?utf-8?B?SUdLeVZzQVNib2NYSmVkdkJYbExlY3RQcGdHR0V4S1pSVmZVcEZnVHNaRDR5?=
 =?utf-8?B?dGs1Mktpb3VlR1VGdllrQlVlZmoxZkNjL2oydU13UFRUU1VQZGhpTlF1Q2pC?=
 =?utf-8?B?d1ZhdVpaS2ppdFFRbnRjQTJLZFNTWkhtSU9zNkxzOUt1UXhOc25WWXU4eS9I?=
 =?utf-8?B?TnJrd1BaMWg0SjR2UlIvTVRVYTZ1djFUaU5TTlVIbTlTMXFOSXFyUmpMOFk0?=
 =?utf-8?B?YUFnZGUzd0szRnBVRTVjMmNVZUl0Z3NPRUdGaUNwOWx5RnF0aUg3OG9TVjVi?=
 =?utf-8?B?ZEwxRG4reWV4YThLb2o4SzNlN2VyaHJqQW5GTVRDd1VpS2FJZWlzUlBXWnNL?=
 =?utf-8?B?bUZYdHluZWpmV3dqZFVqZ0Vid2ExYkxNcnhXcE84Nk13UXRKVWJVL1E4eUc4?=
 =?utf-8?B?V3dKQWZERzZzY1RNTjd6L2VKeVk5NGsrRzIrSFRHS2hhSm9BVVJUTEpIMW43?=
 =?utf-8?B?QWxPcE1jVjREVkNnYXJ5Qkh0eFVod2J3TDJqaGQ4TUNOeHdPYVJoR0t1Y2JG?=
 =?utf-8?B?QVlqMDczRXNyekRyUmhsQUlYbkxIOXkxTnQ3YkJBYUoyTk5xWC9BZlNJU1Iw?=
 =?utf-8?B?eENUM2RKbzZzK3RBU2xCYWV5N0E3K3hVd1RFSzdoNE4xNDJWKzducGlNbUFa?=
 =?utf-8?B?TFU5bktnS3owQ2dBUXAwMHRmVGVaRVptL3g5SVBwVGI3U1BORHpYT0lNZS9D?=
 =?utf-8?B?c3hrK1N3YlpwcHk5ZzJYUVNaZkZBcHJxVXRuNFJIaWFWR05lNS9PQ0FjMENP?=
 =?utf-8?B?VjZkNjR2TW1zZzFGRytZMjRLT2RLZW05UTZrS08yUWszZXNVWE1USHFlUXo1?=
 =?utf-8?B?a0hQb2dFbmhPTkZaZFdqUG1XczVsdFZsSHZ0RllJVS9MK1FjSENaa0JOSkJl?=
 =?utf-8?B?QVJWNkE1WmZkUlhqWmxxby9iYmFRelB0R29SUXlySDNhc2ZkUnRFOXhnMysr?=
 =?utf-8?B?STVwT2NyUWMweXNJdFpGS2xJRFUrcnhmaU9HbURMaG1wOWZUWkp4T2piWE1Z?=
 =?utf-8?B?K1ZPZFp6YTVnTEY4V3dscmlQenFnZGpra0hUdkFDTnVXb3pYeldnOU5xWjN5?=
 =?utf-8?B?MkVBVXZtdWx3ZzJNeGFFcmtmNkdpMVUwZXFVaGpzbFBDZUhuZnN3N3VoSndT?=
 =?utf-8?B?dS90VW4vUXUrTzBWZUtiOTcwZ3hoNWtRYXJwazdNR1hGV2ZzaEs4SWNFa3RS?=
 =?utf-8?B?cGFyVjlwQXZxbndFaE1IU2t1ZHBES1UzYklHTFl6bm40U3FIQmlNRU91V1hM?=
 =?utf-8?B?ZEsyTFRNR00zQzVNSFdmRTRCU2RsQW5yUkNLU0U2NXI4T29IWWg0S2VSdFdS?=
 =?utf-8?B?a1c2Q3pUeFhTT1BsWEZNVmpMM1I3Q3llV0xKVUo3WFVuRE9XT2VOMkFyZTNh?=
 =?utf-8?B?UEMvL0xnUXArSWpteUpPYi9DVnZpL1RhRG40Y0tRdHE2Mi9sbmNBNEx2YmVY?=
 =?utf-8?B?Y0Jhbml3TW80dWdnMnF4VjlsNUVrVVVJUEF6ZmpaTzJITUFuWUpxSFFMSTN6?=
 =?utf-8?B?dzgxTmxHWHhYVTVWM1V0S3VhdEdINENqUVVRTm9reDlSaEZkbWJsTTJaQVFk?=
 =?utf-8?B?Nnc3MHpOckVacWJCUXRXeVFpYTV3OS91djVDMU1iZHZMb1FadHlwdFBvNFkv?=
 =?utf-8?B?WklwMFFaM25tanVVZUdtb1l5dmw1aFRoTEpFVkVhMmRSWEdGcGsxWHNVSkMw?=
 =?utf-8?B?bko1ams0ZUhoL0NBendJMzdvd0d3Z2lwWGlRQ0VsdHZGTnNWeGVxUmtxVEtL?=
 =?utf-8?B?RFZ2SllnM3F3UnJrVWVRTjlyc2xOMUZVM2M5TFdpVDZna2xBczFMcjlZUE1Q?=
 =?utf-8?B?RlFIcUdhYzcxMkYrd2FkZGNVT2dxbDMva1lJbXNQeWtJT0xSVHZzelQ0Qk8z?=
 =?utf-8?B?TWtZcUVzaSt5SVR4eHMzSVJWeW5wNFY5dkZLTnhNU0syWmZxL2V3YlRSVElE?=
 =?utf-8?B?T3B5MjFCYXVMYVl4SWNBNlJORGNOTDlMKzRhZ3BzZWozVjJ5NHY0QXgzL1lD?=
 =?utf-8?Q?+VLJ13tbOqXPNqLUgFkIqL9q0?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3f68f1-5ba8-475c-7d93-08dab1c1ea21
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 11:06:04.2621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNpPyzKz/pYmBgwzYw4U3PGQIpQE6wKhel0T6Wy+mzKGqdVOLvkFM0rFkradIuyPKNd782iMdkj1xYn11KZEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9473
Cc: Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, kernel test robot <lkp@intel.com>,
 pv-drivers@vmware.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nadav Amit <namit@vmware.com>, xen-devel@lists.xenproject.org,
 kernel@openvz.org, Haiyang Zhang <haiyangz@microsoft.com>
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
From: "Denis V. Lunev via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Denis V. Lunev" <den@virtuozzo.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTAvMTkvMjIgMTI6NTMsIEtvbnN0YW50aW4gS2hsZWJuaWtvdiB3cm90ZToKPiBPbiBXZWQs
IDE5IE9jdCAyMDIyIGF0IDEyOjU3LCBBbGV4YW5kZXIgQXRhbmFzb3YgCj4gPGFsZXhhbmRlci5h
dGFuYXNvdkB2aXJ0dW96em8uY29tPiB3cm90ZToKPgo+ICAgICBDdXJyZW50bHkgYmFsbG9vbiBk
cml2ZXJzIChWaXJ0aW8sWEVOLCBIeXBlclYsIFZNV2FyZSwgLi4uKQo+ICAgICBpbmZsYXRlIGFu
ZCBkZWZsYXRlIHRoZSBndWVzdCBtZW1vcnkgc2l6ZSBidXQgdGhlcmUgaXMgbm8KPiAgICAgd2F5
IHRvIGtub3cgaG93IG11Y2ggdGhlIG1lbW9yeSBzaXplIGlzIGNoYW5nZWQgYnkgdGhlbS4KPgo+
ICAgICBNYWtlIGl0IHBvc3NpYmxlIGZvciB0aGUgZHJpdmVycyB0byByZXBvcnQgdGhlIHZhbHVl
cyB0byBtbSBjb3JlLgo+Cj4gICAgIERpc3BsYXkgcmVwb3J0ZWQgSW5mbGF0ZWRUb3RhbCBhbmQg
SW5mbGF0ZWRGcmVlIGluIC9wcm9jL21lbWluZm8KPiAgICAgYW5kIHByaW50IHRoZXNlIHZhbHVl
cyBvbiBPT00gYW5kIHN5c3JxIGZyb20gc2hvd19tZW0oKS4KPgo+ICAgICBUaGUgdHdvIHZhbHVl
cyBhcmUgdGhlIHJlc3VsdCBvZiB0aGUgdHdvIG1vZGVzIHRoZSBkcml2ZXJzIHdvcmsKPiAgICAg
d2l0aCB1c2luZyBhZGp1c3RfbWFuYWdlZF9wYWdlX2NvdW50IG9yIHdpdGhvdXQuCj4KPiAgICAg
SW4gZWFybGllciB2ZXJzaW9ucywgdGhlcmUgd2FzIGEgbm90aWZpZXIgZm9yIHRoZXNlIGNoYW5n
ZXMKPiAgICAgYnV0IGFmdGVyIGRpc2N1c3Npb24gLSBpdCBpcyBiZXR0ZXIgdG8gaW1wbGVtZW50
IGl0IGluIHNlcGFyYXRlCj4gICAgIHBhdGNoIHNlcmllcy4gU2luY2UgaXQgY2FtZSBvdXQgYXMg
bGFyZ2VyIHdvcmsgdGhhbiBpbml0aWFsbHkKPiAgICAgZXhwZWN0ZWQuCj4KPiAgICAgQW1vdW50
IG9mIGluZmxhdGVkIG1lbW9yeSBjYW4gYmUgdXNlZDoKPiAgICAgwqAtIHRvdGFscmFtX3BhZ2Vz
KCkgdXNlcnMgd29ya2luZyB3aXRoIGRyaXZlcnMgbm90IHVzaW5nCj4gICAgIMKgIMKgIGFkanVz
dF9tYW5hZ2VkX3BhZ2VfY291bnQKPiAgICAgwqAtIHNpX21lbWluZm8oLi4pIHVzZXJzIGNhbiBp
bXByb3ZlIGNhbGN1bGF0aW9ucwo+ICAgICDCoC0gYnkgdXNlcnNwYWNlIHNvZnR3YXJlIHRoYXQg
bW9uaXRvcnMgbWVtb3J5IHByZXNzdXJlCj4KPgo+IFNvcnJ5LCBJIHNlZSBubyByZWFzb24gZm9y
IHRoYXQgc2VyaWVzLgo+IEJhbGxvb24gaW5mbGF0aW9uIGFkanVzdHMgdG90YWxyYW1fcGFnZXMu
IFRoYXQncyBlbm91Z2guCj4Kbm8sIHRoZXkgYXJlIG5vdCBhdCBsZWFzdCB1bmRlciBzb21lIGNp
cmN1bXN0YW5jZXMsIGYuZS4KdmlydGlvIGJhbGxvb24gZG9lcyBub3QgZG8gdGhhdCB3aXRoIFZJ
UlRJT19CQUxMT09OX0ZfREVGTEFURV9PTl9PT00Kc2V0Cgo+IFRoZXJlIGlzIG5vIHJlYXNvbiB0
byBrbm93IHRoZSBhbW91bnQgb2Ygbm9uLWV4aXN0ZW50IGJhbGxvb25lZCBtZW1vcnkgCj4gaW5z
aWRlLgo+IE1hbmFnZW1lbnQgc29mdHdhcmUgd2hpY2ggd29ya3Mgb3V0c2lkZSBzaG91bGQgY2Fy
ZSBhYm91dCB0aGF0Lgo+ClRoZSBwcm9ibGVtIGNvbWVzIGF0IHRoZSBtb21lbnQgd2hlbiB3ZSBh
cmUgcnVubmluZwpvdXIgTGludXggc2VydmVyIGluc2lkZSB2aXJ0dWFsIG1hY2hpbmUgYW5kIHRo
ZSBjdXN0b21lcgpjb21lcyB3aXRoIGNyYXp5IHF1ZXN0aW9ucyAid2hlcmUgb3VyIG1lbW9yeT8i
LgoKPiBGb3IgZGVidWdnaW5nIHlvdSBjb3VsZCBnZXQgY3VycmVudMKgYmFsbG9vbsKgc2l6ZSBm
cm9tIC9wcm9jL3Ztc3RhdCAKPiAoYmFsbG9vbl9pbmZsYXRlIC3CoGJhbGxvb25fZGVmbGF0ZSku
Cj4gQWxzbyAoSSBndWVzcykgL3Byb2Mva3BhZ2VmbGFncyBoYXMgYSBiaXQgZm9yIHRoYXQuCj4K
PiBBbnl3YXkgaXQncyBlYXN5IHRvIG1vbml0b3IgYmFsbG9vbsKgaW5mbGF0aW9uIGJ5IHNlZWlu
ZyBjaGFuZ2VzIG9mIAo+IHRvdGFsIG1lbW9yeSBzaXplLgpmb3IgbW9uaXRvcmluZyAtIG1heSBi
ZS4gQnV0IGluIG9yZGVyIHRvIHJlcG9ydCB0b3RhbCBhbW91bnQKdGhlcmUgaXMgbm8gaW50ZXJm
YWNlIHNvIGZhci4KCj4KPiAgICAgQWxleGFuZGVyIEF0YW5hc292ICg4KToKPiAgICAgwqAgbW06
IE1ha2UgYSBwbGFjZSBmb3IgYSBjb21tb24gYmFsbG9vbiBjb2RlCj4gICAgIMKgIG1tOiBFbmFi
bGUgYmFsbG9vbiBkcml2ZXJzIHRvIHJlcG9ydCBpbmZsYXRlZCBtZW1vcnkKPiAgICAgwqAgbW06
IERpc3BsYXkgaW5mbGF0ZWQgbWVtb3J5IHRvIHVzZXJzCj4gICAgIMKgIG1tOiBEaXNwbGF5IGlu
ZmxhdGVkIG1lbW9yeSBpbiBsb2dzCj4gICAgIMKgIGRyaXZlcnM6IHZpcnRpbzogYmFsbG9vbiAt
IHJlcG9ydCBpbmZsYXRlZCBtZW1vcnkKPiAgICAgwqAgZHJpdmVyczogdm13YXJlOiBiYWxsb29u
IC0gcmVwb3J0IGluZmxhdGVkIG1lbW9yeQo+ICAgICDCoCBkcml2ZXJzOiBoeXBlcnY6IGJhbGxv
b24gLSByZXBvcnQgaW5mbGF0ZWQgbWVtb3J5Cj4gICAgIMKgIGRvY3VtZW50YXRpb246IGNyZWF0
ZSBhIGRvY3VtZW50IGFib3V0IGhvdyBiYWxsb29uIGRyaXZlcnMgb3BlcmF0ZQo+Cj4gICAgIMKg
RG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9wcm9jLnJzdMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDC
oDYgKwo+ICAgICDCoERvY3VtZW50YXRpb24vbW0vYmFsbG9vbi5yc3TCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8IDEzOAo+ICAgICArKysrKysrKysrKysrKysrKysKPiAgICAgwqBNQUlOVEFJ
TkVSU8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgNCArLQo+ICAgICDCoGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9jbW0uY8Kg
IMKgIMKgIMKgIMKgIHzCoCDCoDIgKy0KPiAgICAgwqBkcml2ZXJzL2h2L2h2X2JhbGxvb24uY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDEyICsrCj4gICAgIMKgZHJpdmVy
cy9taXNjL3Ztd19iYWxsb29uLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAz
ICstCj4gICAgIMKgZHJpdmVycy92aXJ0aW8vdmlydGlvX2JhbGxvb24uY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfMKgIMKgNyArLQo+ICAgICDCoGZzL3Byb2MvbWVtaW5mby5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTAgKysKPiAgICAgwqAuLi4vbGlu
dXgve2JhbGxvb25fY29tcGFjdGlvbi5oID0+IGJhbGxvb24uaH0gfMKgIDE4ICsrLQo+ICAgICDC
oGxpYi9zaG93X21lbS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfMKgIMKgOCArCj4gICAgIMKgbW0vTWFrZWZpbGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy0KPiAgICAgwqBtbS97YmFs
bG9vbl9jb21wYWN0aW9uLmMgPT4gYmFsbG9vbi5jfcKgIMKgIMKgIMKgIHzCoCAxOSArKy0KPiAg
ICAgwqBtbS9taWdyYXRlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgwqAxIC0KPiAgICAgwqBtbS92bXNjYW4uY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSAtCj4gICAgIMKgMTQg
ZmlsZXMgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+ICAgICDC
oGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL21tL2JhbGxvb24ucnN0Cj4gICAgIMKg
cmVuYW1lIGluY2x1ZGUvbGludXgve2JhbGxvb25fY29tcGFjdGlvbi5oID0+IGJhbGxvb24uaH0g
KDkxJSkKPiAgICAgwqByZW5hbWUgbW0ve2JhbGxvb25fY29tcGFjdGlvbi5jID0+IGJhbGxvb24u
Y30gKDk0JSkKPgo+ICAgICB2NC0+djU6Cj4gICAgIMKgLSByZW1vdmVkIG5vdGlmaWVyCj4gICAg
IMKgLSBhZGRlZCBkb2N1bWVudGF0aW9uCj4gICAgIMKgLSB2bXdhcmUgdXBkYXRlIGFmdGVyIG9w
IGlzIGRvbmUgLCBvdXRzaWRlIG9mIHRoZSBtdXRleAo+ICAgICB2My0+djQ6Cj4gICAgIMKgLSBh
ZGQgc3VwcG9ydCBpbiBoeXBlclYgYW5kIHZtd2FyZSBiYWxsb29uIGRyaXZlcnMKPiAgICAgwqAt
IGRpc3BsYXkgYmFsbG9vbiBtZW1vcnkgaW4gc2hvd19tZW0gc28gaXQgaXMgbG9nZ2VkIG9uIE9P
TSBhbmQKPiAgICAgb24gc3lzcnEKPiAgICAgdjItPnYzOgo+ICAgICDCoC0gYWRkZWQgbWlzc2Vk
IEVYUE9SVF9TWU1CT0xTCj4gICAgIFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtw
QGludGVsLmNvbT4KPiAgICAgwqAtIGluc3RlYWQgb2YgYmFsbG9vbl9jb21tb24uaCBqdXN0IHVz
ZSBiYWxsb29uLmggKHllcywgbmFtaW5nIGlzCj4gICAgIGhhcmQpCj4gICAgIMKgLSBjbGVhbmVk
IHVwIGJhbGxvb24uaCAtIHJlbW92ZSBmcm9tIGZpbGVzIHRoYXQgZG8gbm90IHVzZSBpdCBhbmQK
PiAgICAgwqAgwqByZW1vdmUgZXh0ZXJucyBmcm9tIGZ1bmN0aW9uIGRlY2xhcmF0aW9ucwo+ICAg
ICB2MS0+djI6Cj4gICAgIMKgLSByZXdvcmtlZCBmcm9tIHNpbXBsZSAvcHJvYy9tZW1pbmZvIGFk
ZGl0aW9uCj4KPiAgICAgQ2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4g
ICAgIENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KPiAgICAgQ2M6IFdl
aSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz4KPiAgICAgQ2M6IE5hZGF2IEFtaXQgPG5hbWl0QHZt
d2FyZS5jb20+Cj4gICAgIENjOiBwdi1kcml2ZXJzQHZtd2FyZS5jb20KPiAgICAgQ2M6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gICAgIENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ICAgICBDYzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNA
bWljcm9zb2Z0LmNvbT4KPiAgICAgQ2M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29m
dC5jb20+Cj4gICAgIENjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNv
bT4KPiAgICAgQ2M6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+Cj4gICAgIENjOiBs
aW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnCj4gICAgIENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+Cj4gICAgIENjOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtl
cm5lbC5vcmc+Cj4gICAgIENjOiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hj
aGVua29AZXBhbS5jb20+Cj4gICAgIENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcK
Pgo+ICAgICBiYXNlLWNvbW1pdDogOWFiZjIzMTNhZGMxY2ExYjYxODBjNTA4YzI1ZjIyZjkzOTVj
Yzc4MAo+ICAgICAtLSAKPiAgICAgMi4zMS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
