Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF516C7EE24
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 18:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F9F8613E3;
	Mon, 15 May 2023 18:33:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F9F8613E3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fdDVXkNH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htq68FdjUPaV; Mon, 15 May 2023 18:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80E3A60BF5;
	Mon, 15 May 2023 18:33:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80E3A60BF5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7C9CC0037;
	Mon, 15 May 2023 18:33:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 498ACC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22936404B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:33:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22936404B1
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fdDVXkNH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTCiC_D-Lf4T
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:33:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CF64400DD
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::619])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CF64400DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eaf4ENjWYU6enlLjsSbG+svKQQR/bHZMcfOle8P2BO7cCodE1SDH7yaBeQqSv4iL95rddhQWkwc3VnB3uAN5h3kUjiiB10bQFLUkc4LfTPZEsPemzS8XJ4b8hS9p2hqncm/iqOgE9cysHTDAuMFXtz99/4lDXkZUiqP1oCwC0Ewzgm17RibgNx1ClXx7oHyFnxsj6wD+6FFx2D9V1+Iov+ho0WCeFAY4HPQvUrtN0WQp3dVnKW0Lc9t40+O+2am8zm/KXBw6Nr27rMUhIyxWO6OaLjvq3t8E3xHdDAGKdhQoc2wfMv9IGx4mvTubZZrLiuyWo+JQutK9P4/I45pkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71VFcf0BdKYnMntw9FB4+DeJdkwr0QJfHSNOY+B6fgQ=;
 b=Lq6Qw8NI0jol4YRBrnpHR3Zl621NU+1eQqf0khM0z7NPGIz+Er2ZBZkYgKDoL5csSAX+4wJyihJRLXCTzw3m7baDBcBleC0ouHJ72N364tdM4OPXQwgY7hqZfr44BXYy0ppLZOFk9EMEqojNYkecZwz6R04HxthNI54SOj8Ya+PZatrPDBV/XkqkIFYd5P2jEBN7btqL3xd8C6SSFCT+JOgdeCgRgBOj69yww5gx9UnrdMZK/KLtdPh0tzHU/VQPWoLZBleNIoE2mkOq73BZ+hk5jxLn6XA9JZXy3eQpZoisdomjBkOT/4+dMi08mXQpobkOkNyJmpFehH1Jfanbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71VFcf0BdKYnMntw9FB4+DeJdkwr0QJfHSNOY+B6fgQ=;
 b=fdDVXkNHLVR8tHbgXO7rQ+d8VZteqio15zW+kRUV+ZYtn3Y8eh/3jNcZD5sRjGNl985B1971Y3lBAUs+ovkWpJ7hDwzqH9QOYAQuMjkpFN5H9tsFuF7RAgcnoPDzeVxj+LxDS0S+pKrBeSauAVTYznglFD/HBy7rfbtSiw/rAEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 18:33:07 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:33:07 +0000
Message-ID: <d6281472-b107-6128-4004-5a7a43f37ee8@amd.com>
Date: Mon, 15 May 2023 11:33:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v5 virtio 11/11] pds_vdpa: pds_vdps.rst and Kconfig
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-12-shannon.nelson@amd.com>
 <CACGkMEvxzRuW2i=3=wv=B7J8UfytxwRoA3SJRexuOgLzJtmZ3Q@mail.gmail.com>
In-Reply-To: <CACGkMEvxzRuW2i=3=wv=B7J8UfytxwRoA3SJRexuOgLzJtmZ3Q@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: a8edbd05-dcc4-4453-180f-08db5572d414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgQclKTSahH4baqj9dLzpjIC2vKaAzDOF7UPWf/Uqa3hcJT7+ex9Y0I3/1yzmatVthJfbS5zhFQVCmstchYUYaMBLqp0KN6fKXuZleRZ94NciK0Q70xpI6qO2tWde2PPi5W62lfJXTCIh7JLT6oCT/FtB2gf88M9LIaEyu27upp3I6MQcSNK82JmxIbC/RBuJJ/4qundWzpQ3HRLlNRgP+i3C/X5Fj6myob3C64v9tzTiSYYS91yrb6fo6s2K9IAmMZv4LXIEROWOLQX0/t1YwOT2ANRdZ6RKJf/Z95EHwN2rw0moVaUJIcmF6XHRzSo7qFhKXPppMefigpVzk2u4hxiP4P8ll1IzAkAMddO6Omme7Jx/+3KAWfPKHAB3QFr5UHQScTTpJDWbSWROdW4kHdPYF9WLbUC2PeTeFgXqpnsrBQGDiNVVl0tO3cD8m0TSOkmGodaMdF4z/c4+SgZJd1+CRFa0wvOkgg5GDvughLv3PpdnVDTANmAgwcZkM5ZugYEJc8oGcvfejEEPeJjeDrrydhbjyd3ItNWQdX7CPVIPCorPs4CAVEw+TQm1YZpnxxt38phLjhCO7790PdjrD9WB+aqvk3g5lmHgB2ArzZG4Eo5Gve9XEDLkwhgc4JuHJB5zAzxfvMDrGDng6gGAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(86362001)(2906002)(66899021)(31696002)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(38100700002)(6666004)(36756003)(478600001)(54906003)(83380400001)(53546011)(31686004)(8676002)(26005)(186003)(8936002)(6506007)(44832011)(6512007)(41300700001)(2616005)(6486002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNyYjNZN1NUVU8waS85SHN5UlpKaHc3SEZxRk5DRkp5U0VheEFzTlphdVZZ?=
 =?utf-8?B?S0NORGxFWWkxUis3Q0J5Y0QvSkUxVFhRd1NwbmpYWFlmdG15Qjl6dFRscDdG?=
 =?utf-8?B?M1NDWEdEY09HK0hwZjZvb01uZWtSVEZKNENiV0pmMWVsL3Nzby9BdGpPMUhG?=
 =?utf-8?B?dFV1RlR2Q1RTa2M5VWF4eHoxaXJtaGdQb09mbTRPMnZ0NFBUdWhDd0pHUXdz?=
 =?utf-8?B?N1NXbWFsajRpbzNBQ21jOFU0akw2azhQMjBYRUNhd3lmam1FZlk0MjFFMWpC?=
 =?utf-8?B?NUthQjc2R1cxd3lNYms3TFpRTVNYMDU5cExuRkVxVkRibGdhWk15bUtuYzdq?=
 =?utf-8?B?d09CeCs4dS9JVDB5UzBKaEtBSXZKQjZHT0tJcTN0UXRMTlNKSTNjT1RIRmxz?=
 =?utf-8?B?dDhUekpRbEpzYUhsMTNGZktHNTNGTjdDQnYzZUlGdXV6cm0ycHJ5VVpENjBw?=
 =?utf-8?B?SGxZcEJ4MDV5TFhnYWhJMnB1MzBiTEh0Mi9RRXAxM3ozMyt0OHpNZjVaa2VP?=
 =?utf-8?B?L1dLcTJaNDgvSy92K1RmVjFCWlBnODg0NUsrbjBsd3RtWWllY0VSTnZ6TEJs?=
 =?utf-8?B?SlRnMEZ3YTdwZHZXTFZJZXFNV05VNHA4OXJZTUp2UmZXcVFsK3l2UVBFdlJ0?=
 =?utf-8?B?R3A0SG5RTjUvYTFOazU2eHpxTXR5SzBkQ0UwMXVhQzF4MHBlck94OWJOTi95?=
 =?utf-8?B?NjZ1RUNEY3RWenQ4Q3lGQmNlc0tXUGJXS0pvc0VmMGhYa0tiWE5pKzJORG5w?=
 =?utf-8?B?Z0RieGRlZFJZU05UemJoMFFEVGFqcmxIOGtzNHVzUmJzOUtQY0xMZDRHeDl4?=
 =?utf-8?B?bXRzaDZVdGdXOU9XWXU5RGRVdGM3QjBoYi9UN0FkRkFjVVA2OUFBVHZZNDMv?=
 =?utf-8?B?TGZvMGlyVW5HVXNpNHpMU1JxdzVBSkpyNTh6VGxNK1QxdTZtTXZZSmhqckpZ?=
 =?utf-8?B?STVUOUNQZHgwd0tpT2VYTDgyK0VUdnp3eVFuYzZUd1V5M3A1R3F0Q0h3ZGx5?=
 =?utf-8?B?M3p0WnVpdkd0a3huNDQ5UTk2VFZHWWZQUVQrODlnYm1STkRVbHVjY3BYRlZ3?=
 =?utf-8?B?YkJibi9yMURMMjJWU2pjVVhlc09MUW9DSWpJTVRZVkZFMFh0cXROckd6TGg5?=
 =?utf-8?B?ckJZM2dlcUx3Z1hvanZLbXUvZEtROSthek1XY3FXVFdDdXR6c1d3eFkvcFl5?=
 =?utf-8?B?THJxSHJROGdKc1Q4VExXWnRDdHVqVnZlbGdrSFExS240RnhpaTBKTmJIUndV?=
 =?utf-8?B?bVZIOHIza2pBcTVDL01nTnIxc3V2VmEzNHRycktBelRtYUUzQ1g4SzJUZnp3?=
 =?utf-8?B?QlJwV3JQZEZkYjlIbHlTSkFUSW51WXZrd0VqWWpBWlNuY0hkUlppdUx4UlNY?=
 =?utf-8?B?WGtjd3lEemlkeldIckVhWExzcFNvWDJhOW9haGZrYTUveWk4ZFF5WUhtTVJF?=
 =?utf-8?B?T1ZtNWErSXNvT3VGSU5ObUlxVkFVSE9LUERTVjUvUjNTYWVFMWFqWmJ4eFBC?=
 =?utf-8?B?WjhDenJIZjVSbTNmUEtmM1duc1BjNFdTTCtLVGxyb3R5OEQ4aDM5OEQ3Mkdq?=
 =?utf-8?B?WGZwdmxoMmM4VmR5bllqeGxBQTlQaEUvTzNML21iWDhxNTE4d0dCMDBpQm5M?=
 =?utf-8?B?eURmYnBFV29NTEhzUEZPUHhsTTRUbXRHMmVETWxxc0UzZThsNkVUZTNPOGxa?=
 =?utf-8?B?Wm5KdjlDLzBBelp0ZUhFc1hJKzdtbEozTWNqRS9rSlhlYk9CZUdtd0czTzdG?=
 =?utf-8?B?NFJCekdPWVN1bFpHaWxpTThISVRTTnRQVmVVOFhETzVzaVJGK0VGOEo0NUxE?=
 =?utf-8?B?Z240eXQrREhiL1p5Q2JwalUxY1RLVzJsM3l4TkNrMHFoR3pQcUpLUTlNS0RF?=
 =?utf-8?B?RjZMT0FVc1MzQVA5UmFYaDN4ZjVvNktkdHFnTk5OMjZDMzhRYmlGWVlzVStw?=
 =?utf-8?B?aGMxVVRLNUlhTk9lbjVBUVB1U2VqL3dTQThMMTdnYW00aURSaEdmYTQyMmlB?=
 =?utf-8?B?Q3NDaGN6a0NBWU1sMnZaNnRFMlhobGRtekpmczJHWWdVQk5vMThuanJheFFI?=
 =?utf-8?B?N3F3QTBaMVE1amM1VnRMWGQxMHF1bGpma2RCYm1vUU5Bd2wvZWxNalRtbFAy?=
 =?utf-8?Q?0GYsCTkPmHYFCyoe+xaYzOVSZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8edbd05-dcc4-4453-180f-08db5572d414
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:33:07.7332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00pgwf+tWlm76O/yuzSfNGGHrAbirLPxNR/IuQlH34mc8pjEAYQ8hmoVBz+JvmeIH+Gv3RMz9ni0OvHtOK/6Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
Cc: "Creeley, Brett" <Brett.Creeley@amd.com>, "mst@redhat.com" <mst@redhat.com>,
 "simon.horman@corigine.com" <simon.horman@corigine.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "drivers@pensando.io" <drivers@pensando.io>
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

T24gNS8xNC8yMyAxMDowNyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUaHUsIE1heSA0LCAy
MDIzIGF0IDI6MTPigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4g
d3JvdGU6Cj4+Cj4+IEFkZCB0aGUgZG9jdW1lbnRhdGlvbiBhbmQgS2NvbmZpZyBlbnRyeSBmb3Ig
cGRzX3ZkcGEgZHJpdmVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hh
bm5vbi5uZWxzb25AYW1kLmNvbT4KPj4gLS0tCj4+ICAgLi4uL2RldmljZV9kcml2ZXJzL2V0aGVy
bmV0L2FtZC9wZHNfdmRwYS5yc3QgIHwgODUgKysrKysrKysrKysrKysrKysrKwo+PiAgIC4uLi9k
ZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbmRleC5yc3QgICAgICAgICB8ICAxICsKPj4gICBNQUlO
VEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArCj4+ICAgZHJp
dmVycy92ZHBhL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysKPj4gICA0
IGZpbGVzIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKykKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2FtZC9wZHNf
dmRwYS5yc3QKPj4KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZp
Y2VfZHJpdmVycy9ldGhlcm5ldC9hbWQvcGRzX3ZkcGEucnN0IGIvRG9jdW1lbnRhdGlvbi9uZXR3
b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2FtZC9wZHNfdmRwYS5yc3QKPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi41ODc5MjdkM2RlOTIKPj4gLS0t
IC9kZXYvbnVsbAo+PiArKysgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2aWNlX2RyaXZl
cnMvZXRoZXJuZXQvYW1kL3Bkc192ZHBhLnJzdAo+PiBAQCAtMCwwICsxLDg1IEBACj4+ICsuLiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsKPj4gKy4uIG5vdGU6IGNhbiBiZSBlZGl0
ZWQgYW5kIHZpZXdlZCB3aXRoIC91c3IvYmluL2Zvcm1pa28tdmltCj4+ICsKPj4gKz09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4gK1BD
SSB2RFBBIGRyaXZlciBmb3IgdGhlIEFNRC9QZW5zYW5kbyhSKSBEU0MgYWRhcHRlciBmYW1pbHkK
Pj4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KPj4gKwo+PiArQU1EL1BlbnNhbmRvIHZEUEEgVkYgRGV2aWNlIERyaXZlcgo+PiArCj4+
ICtDb3B5cmlnaHQoYykgMjAyMyBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMKPj4gKwo+PiAr
T3ZlcnZpZXcKPj4gKz09PT09PT09Cj4+ICsKPj4gK1RoZSBgYHBkc192ZHBhYGAgZHJpdmVyIGlz
IGFuIGF1eGlsaWFyeSBidXMgZHJpdmVyIHRoYXQgc3VwcGxpZXMKPj4gK2EgdkRQQSBkZXZpY2Ug
Zm9yIHVzZSBieSB0aGUgdmlydGlvIG5ldHdvcmsgc3RhY2suICBJdCBpcyB1c2VkIHdpdGgKPj4g
K3RoZSBQZW5zYW5kbyBWaXJ0dWFsIEZ1bmN0aW9uIGRldmljZXMgdGhhdCBvZmZlciB2RFBBIGFu
ZCB2aXJ0aW8gcXVldWUKPj4gK3NlcnZpY2VzLiAgSXQgZGVwZW5kcyBvbiB0aGUgYGBwZHNfY29y
ZWBgIGRyaXZlciBhbmQgaGFyZHdhcmUgZm9yIHRoZSBQRgo+PiArYW5kIFZGIFBDSSBoYW5kbGlu
ZyBhcyB3ZWxsIGFzIGZvciBkZXZpY2UgY29uZmlndXJhdGlvbiBzZXJ2aWNlcy4KPj4gKwo+PiAr
VXNpbmcgdGhlIGRldmljZQo+PiArPT09PT09PT09PT09PT09PQo+PiArCj4+ICtUaGUgYGBwZHNf
dmRwYWBgIGRldmljZSBpcyBlbmFibGVkIHZpYSBtdWx0aXBsZSBjb25maWd1cmF0aW9uIHN0ZXBz
IGFuZAo+PiArZGVwZW5kcyBvbiB0aGUgYGBwZHNfY29yZWBgIGRyaXZlciB0byBjcmVhdGUgYW5k
IGVuYWJsZSBTUi1JT1YgVmlydHVhbAo+PiArRnVuY3Rpb24gZGV2aWNlcy4gIEFmdGVyIHRoZSBW
RnMgYXJlIGVuYWJsZWQsIHdlIGVuYWJsZSB0aGUgdkRQQSBzZXJ2aWNlCj4+ICtpbiB0aGUgYGBw
ZHNfY29yZWBgIGRldmljZSB0byBjcmVhdGUgdGhlIGF1eGlsaWFyeSBkZXZpY2VzIHVzZWQgYnkg
cGRzX3ZkcGEuCj4+ICsKPj4gK0V4YW1wbGUgc3RlcHM6Cj4+ICsKPj4gKy4uIGNvZGUtYmxvY2s6
OiBiYXNoCj4+ICsKPj4gKyAgIyEvYmluL2Jhc2gKPj4gKwo+PiArICBtb2Rwcm9iZSBwZHNfY29y
ZQo+PiArICBtb2Rwcm9iZSB2ZHBhCj4+ICsgIG1vZHByb2JlIHBkc192ZHBhCj4+ICsKPj4gKyAg
UEZfQkRGPWBscyAvc3lzL21vZHVsZS9wZHNfY29yZS9kcml2ZXJzL3BjaVw6cGRzX2NvcmUvKi9z
cmlvdl9udW12ZnMgfCBhd2sgLUYgLyAne3ByaW50ICQ3fSdgCj4+ICsKPj4gKyAgIyBFbmFibGUg
dkRQQSBWRiBhdXhpbGlhcnkgZGV2aWNlKHMpIGluIHRoZSBQRgo+PiArICBkZXZsaW5rIGRldiBw
YXJhbSBzZXQgcGNpLyRQRl9CREYgbmFtZSBlbmFibGVfdm5ldCBjbW9kZSBydW50aW1lIHZhbHVl
IHRydWUKPj4gKwo+PiArICAjIENyZWF0ZSBhIFZGIGZvciB2RFBBIHVzZQo+PiArICBlY2hvIDEg
PiAvc3lzL2J1cy9wY2kvZHJpdmVycy9wZHNfY29yZS8kUEZfQkRGL3NyaW92X251bXZmcwo+PiAr
Cj4+ICsgICMgRmluZCB0aGUgdkRQQSBzZXJ2aWNlcy9kZXZpY2VzIGF2YWlsYWJsZQo+PiArICBQ
RFNfVkRQQV9NR01UPWB2ZHBhIG1nbXRkZXYgc2hvdyB8IGdyZXAgdkRQQSB8IGhlYWQgLTEgfCBj
dXQgLWQ6IC1mMWAKPj4gKwo+PiArICAjIENyZWF0ZSBhIHZEUEEgZGV2aWNlIGZvciB1c2UgaW4g
dmlydGlvIG5ldHdvcmsgY29uZmlndXJhdGlvbnMKPj4gKyAgdmRwYSBkZXYgYWRkIG5hbWUgdmRw
YTEgbWdtdGRldiAkUERTX1ZEUEFfTUdNVCBtYWMgMDA6MTE6MjI6MzM6NDQ6NTUKPj4gKwo+PiAr
ICAjIFNldCB1cCBhbiBldGhlcm5ldCBpbnRlcmZhY2Ugb24gdGhlIHZkcGEgZGV2aWNlCj4+ICsg
IG1vZHByb2JlIHZpcnRpb192ZHBhCj4+ICsKPj4gKwo+PiArCj4+ICtFbmFibGluZyB0aGUgZHJp
dmVyCj4+ICs9PT09PT09PT09PT09PT09PT09Cj4+ICsKPj4gK1RoZSBkcml2ZXIgaXMgZW5hYmxl
ZCB2aWEgdGhlIHN0YW5kYXJkIGtlcm5lbCBjb25maWd1cmF0aW9uIHN5c3RlbSwKPj4gK3VzaW5n
IHRoZSBtYWtlIGNvbW1hbmQ6Ogo+PiArCj4+ICsgIG1ha2Ugb2xkY29uZmlnL21lbnVjb25maWcv
ZXRjLgo+PiArCj4+ICtUaGUgZHJpdmVyIGlzIGxvY2F0ZWQgaW4gdGhlIG1lbnUgc3RydWN0dXJl
IGF0Ogo+PiArCj4+ICsgIC0+IERldmljZSBEcml2ZXJzCj4+ICsgICAgLT4gTmV0d29yayBkZXZp
Y2Ugc3VwcG9ydCAoTkVUREVWSUNFUyBbPXldKQo+PiArICAgICAgLT4gRXRoZXJuZXQgZHJpdmVy
IHN1cHBvcnQKPj4gKyAgICAgICAgLT4gUGVuc2FuZG8gZGV2aWNlcwo+PiArICAgICAgICAgIC0+
IFBlbnNhbmRvIEV0aGVybmV0IFBEU19WRFBBIFN1cHBvcnQKPj4gKwo+PiArU3VwcG9ydAo+PiAr
PT09PT09PQo+PiArCj4+ICtGb3IgZ2VuZXJhbCBMaW51eCBuZXR3b3JraW5nIHN1cHBvcnQsIHBs
ZWFzZSB1c2UgdGhlIG5ldGRldiBtYWlsaW5nCj4+ICtsaXN0LCB3aGljaCBpcyBtb25pdG9yZWQg
YnkgUGVuc2FuZG8gcGVyc29ubmVsOjoKPj4gKwo+PiArICBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
Cj4+ICsKPj4gK0ZvciBtb3JlIHNwZWNpZmljIHN1cHBvcnQgbmVlZHMsIHBsZWFzZSB1c2UgdGhl
IFBlbnNhbmRvIGRyaXZlciBzdXBwb3J0Cj4+ICtlbWFpbDo6Cj4+ICsKPj4gKyAgZHJpdmVyc0Bw
ZW5zYW5kby5pbwo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2Rldmlj
ZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJzdCBiL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9k
ZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9pbmRleC5yc3QKPj4gaW5kZXggNDE3Y2E1MTRhNGQwLi45
NGVjYjY3YzA4ODUgMTAwNjQ0Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZp
Y2VfZHJpdmVycy9ldGhlcm5ldC9pbmRleC5yc3QKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3
b3JraW5nL2RldmljZV9kcml2ZXJzL2V0aGVybmV0L2luZGV4LnJzdAo+PiBAQCAtMTUsNiArMTUs
NyBAQCBDb250ZW50czoKPj4gICAgICBhbWF6b24vZW5hCj4+ICAgICAgYWx0ZXJhL2FsdGVyYV90
c2UKPj4gICAgICBhbWQvcGRzX2NvcmUKPj4gKyAgIGFtZC9wZHNfdmRwYQo+PiAgICAgIGFxdWFu
dGlhL2F0bGFudGljCj4+ICAgICAgY2hlbHNpby9jeGdiCj4+ICAgICAgY2lycnVzL2NzODl4MAo+
PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwo+PiBpbmRleCBlYmQyNmIz
Y2E5MGUuLmM1NjViNzFjZTU2ZiAxMDA2NDQKPj4gLS0tIGEvTUFJTlRBSU5FUlMKPj4gKysrIGIv
TUFJTlRBSU5FUlMKPj4gQEAgLTIyMjAwLDYgKzIyMjAwLDEwIEBAIFNORVQgRFBVIFZJUlRJTyBE
QVRBIFBBVEggQUNDRUxFUkFUT1IKPj4gICBSOiAgICAgQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4KPj4gICBGOiAgICAgZHJpdmVycy92ZHBhL3NvbGlkcnVuLwo+Pgo+
PiArUERTIERTQyBWSVJUSU8gREFUQSBQQVRIIEFDQ0VMRVJBVE9SCj4+ICtSOiAgICAgU2hhbm5v
biBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4+ICtGOiAgICAgZHJpdmVycy92ZHBh
L3Bkcy8KPj4gKwo+PiAgIFZJUlRJTyBCQUxMT09OCj4+ICAgTTogICAgICJNaWNoYWVsIFMuIFRz
aXJraW4iIDxtc3RAcmVkaGF0LmNvbT4KPj4gICBNOiAgICAgRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZyBiL2Ry
aXZlcnMvdmRwYS9LY29uZmlnCj4+IGluZGV4IGNkNmFkOTJmM2YwNS4uMmVlMWIyODg2OTFkIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+PiArKysgYi9kcml2ZXJzL3ZkcGEv
S2NvbmZpZwo+PiBAQCAtMTE2LDQgKzExNiwxMiBAQCBjb25maWcgQUxJQkFCQV9FTklfVkRQQQo+
PiAgICAgICAgICAgIFRoaXMgZHJpdmVyIGluY2x1ZGVzIGEgSFcgbW9uaXRvciBkZXZpY2UgdGhh
dAo+PiAgICAgICAgICAgIHJlYWRzIGhlYWx0aCB2YWx1ZXMgZnJvbSB0aGUgRFBVLgo+Pgo+PiAr
Y29uZmlnIFBEU19WRFBBCj4+ICsgICAgICAgdHJpc3RhdGUgInZEUEEgZHJpdmVyIGZvciBBTUQv
UGVuc2FuZG8gRFNDIGRldmljZXMiCj4+ICsgICAgICAgZGVwZW5kcyBvbiBQRFNfQ09SRQo+IAo+
IE5lZWQgdG8gc2VsZWN0IFZJUlRJT19QQ0lfTElCPwoKVGhhdCdzIGEgZ29vZCBpZGVhIC0gSSds
bCBhZGQgdGhhdC4KCnNsbgoKPiAKPiBUaGFua3MKPiAKPj4gKyAgICAgICBoZWxwCj4+ICsgICAg
ICAgICB2RFBBIG5ldHdvcmsgZHJpdmVyIGZvciBBTUQvUGVuc2FuZG8ncyBQRFMgQ29yZSBkZXZp
Y2VzLgo+PiArICAgICAgICAgV2l0aCB0aGlzIGRyaXZlciwgdGhlIFZpcnRJTyBkYXRhcGxhbmUg
Y2FuIGJlCj4+ICsgICAgICAgICBvZmZsb2FkZWQgdG8gYW4gQU1EL1BlbnNhbmRvIERTQyBkZXZp
Y2UuCj4+ICsKPj4gICBlbmRpZiAjIFZEUEEKPj4gLS0KPj4gMi4xNy4xCj4+Cj4gCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
