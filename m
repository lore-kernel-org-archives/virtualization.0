Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CF7EB64D9
	for <virtualization@archiver.kernel.org>; Mon, 10 Jul 2023 15:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4F5381F1C;
	Mon, 10 Jul 2023 15:42:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4F5381F1C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nVIimpip
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJNqCB4gU7VM; Mon, 10 Jul 2023 15:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD52981EFE;
	Mon, 10 Jul 2023 15:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD52981EFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA79CC0071;
	Mon, 10 Jul 2023 15:42:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88F4EC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 15:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35E7C81F0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 15:42:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35E7C81F0B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsQGol-yihOr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 15:42:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02ADF81EFE
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02ADF81EFE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 15:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbW6AV8jkhfgVDDdx7VW0QaiVKyWH6SG792zV0IRf7qUoDAwb+j30a+LldoDrJIqzqDCXKo8oR5BcBdw0F80UFH9eU5PCBn/HZ+mu6e+J++yMDqWWFnlVvr5GSWkX3se6ZIDotgMvNODYfuJWW1R0HnryzQS8191NFoRHT4Tv2Iu2BOK9i7XOMovuCjDiySwFkk8qeXG8lD7Y6hFzbWGGIlkaMNfHdzZpqyC2g2pP2O6Jebkks8zUsDxbGIltfoQf3klePcT69vG47AhkVoZsVbDHxf+AFiLyKpGcqySHvLExYPv72S5F0vw6PJYKiqFkHwcZwPikiZS5am+vLkKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/WRwx0uKuTeMGFwCtfZ+QL30TOUUebOoq286GdU1AA=;
 b=Pp/gGKO7BcExAlgXOeYL/uOpClZumSdognOgHNs82bqBGvVAPYnKA/MJD5erkP1EAuruTmetSJrZWJoXhRexyAXI73HIiayNCF0R9dVzxGtXWs/7D9Qb1AAO9siuq/lPzuPpsAvNH8IMA4dELM0aBi6qTWM1AIkv4Z8nCOu7zDeGt1q3MT7itZwS88wUDQ37raovO//D9MvDbegaG674MIEtl63SnfHoHunrgwBHGlkaMCQ1kqMmS05gYSnuJ7PwHfESsC9jKMMBcTA7jktYR7L44l0eaAdbM8hqL0Yl/jwC9wWP2Z9lkUS8Lp7+sSWm/4djC9IeJiszjqiYmB6VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/WRwx0uKuTeMGFwCtfZ+QL30TOUUebOoq286GdU1AA=;
 b=nVIimpip/gc98vsUGcR27N1AhBDoGVfUMPNyjRXKg8C/QflvSfvNv+xrN/pzlZyLEEAfrJ7cD8TBK+UJ8Ov31PHiNq3AE1De1nZ1FAmB0ub/m70wFYs6rEH6q/kx6SLIvX79PUHiE8kwE2JYUQh5822T/umlyH8efr/KyMnDFB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 15:42:23 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:42:23 +0000
Message-ID: <82bf6210-6615-5d33-e3c5-808cfa8cba6d@amd.com>
Date: Mon, 10 Jul 2023 08:42:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-2-shannon.nelson@amd.com>
 <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
 <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
 <CACGkMEtyJajf=xTmna66CbxxaYVXmeo5+dyw__wqrB=EwfdeqQ@mail.gmail.com>
In-Reply-To: <CACGkMEtyJajf=xTmna66CbxxaYVXmeo5+dyw__wqrB=EwfdeqQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: b7388152-ade2-4b8f-859f-08db815c40d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEhzTRQkYXyySbzyM8UD2k/aAVznviaT+vgk0eGpAQ0fY+ODfH3VVMdZdu4F3Sy3vpp3plf+cbZefbdUeMeHXsJ9zwr8V1/+QZ9lvloXGHSYKboAfoapEvH41+qiACKWfQ388oc07Kv5Ep0G7pMEtPoxT9yEBH6E6AbrgsyubIDsYnPmqDW3tkwCb1YlWuf+den6rY5dlEt0rY3EGtZfyNnOiQ9vuPJyNT27tDqFAjaljjp3tqZR8gAGDvhqAVKJmOUWkOq5pLicw9oXBc2V3d5pexmNWmcTUDxo8NHM19ngTwyec/8aS0RUbq7V4lsbzqoq4fUjDeOsIauKSuIb2YPQgj4ewESEgOKla891LFI79ziOPgqH39R/BJYbQGmUiAWOpm2SAyAomZowdo0EY4Fg9JV3BJ74gaC3lPTHTf5kL/Nin95xXnJamzAKOxeJgYtpaRfA8Seb0Skv/DyshH4H1kW/okKCiuhg/xVrEaQkpPG7Z7A+wy3EzPBxk/q6+XviPzUODXof6rdifqOTH0iQHuJvgoBD+bq0MDEDtgnRVKpU5PKPVRzCfdkwmTjQc+mAegORF56jiasWx/oapE546MYkgXa23xyAh26KFn5ePiHP8tK+l+Jd9T/0vsXZ/i5SaNHNny3dY7pBDCoFEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(31686004)(4326008)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(36756003)(2906002)(44832011)(26005)(6512007)(53546011)(6506007)(6486002)(186003)(38100700002)(66946007)(66476007)(66556008)(6916009)(316002)(41300700001)(8676002)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEJUVE5Zb01sWnUwQ2pHdStDQ24wOUhkQUs2SWNlajN5RTVzbmZaZC9GcEp0?=
 =?utf-8?B?WlRpeEQxRHFaQ0JGL3FTRFlMenNXUFZ0YWVJTk13THR1UWxwdU9yWVNwbjVj?=
 =?utf-8?B?V0dUVjlRTmNib0J1VDIyL1R1RXZWQ3E2QnMvUS92d0JpWlU5RTdEMW80NVJp?=
 =?utf-8?B?R2l4cG15N3c3MkhacVZ2d3ZVa1c1dGRIZEtQRlRMRGYvMC9WRm1JK2c5TzVF?=
 =?utf-8?B?d3dpcWk0NGlQbHdGOGJVZHU1SG9Jdk5TenlKeHdtSlk1bHl1M2FXbHI4MnJS?=
 =?utf-8?B?enJJR3YvdmI1QXgyKzk4L1V4a1VNek0wKytZajFlczQ5Q01SQ2tXeVhhdnls?=
 =?utf-8?B?MU5mcSt6TjltbFBvU3FVYW5QTmRVODdiTVY1U3JFT3BWaVZLcDhzZXRwMXE1?=
 =?utf-8?B?TkM1U2pYTmpPN2JoMHJ2NXd4TklLTEZhZ1lkUHVIMXNKc0YzV0FMSFZHZFRR?=
 =?utf-8?B?TFBjVGxKUDJ5aVBwU3h5S1VlcG1XdTdWR0wya3FwbmFBTDlpUjFjZEpqRmZU?=
 =?utf-8?B?b05xSUhiOVRUSkFTb3dFbFFPSjRoVnpmRDNnTWF0YjA3UEgrV0cyOXBoOEcy?=
 =?utf-8?B?eG9kMFBqRUZ5ZmRIci9JUmlyNDV0VDVoNWVpVUh5VGJLRjVKQWhITGFPYlpn?=
 =?utf-8?B?WlJRU0duelZWZDA3WXpQa1dzS0JKcFAyU3B3VWdxc0FTMlpReks5cjdEa1RK?=
 =?utf-8?B?Vm8vTFd5UTJRSHk1b0lLQ3ArWStvN0FQS0I1UGxaRExHVGRYYmtSYmlGNEY1?=
 =?utf-8?B?SWlaYVRhZlRJeERIWmRxeEFoM1loRy95Skg4ZFRZa2NIaFp1TFRxR1FLa29o?=
 =?utf-8?B?bE5IN3RqU1hpSWp3UEFzcjF3ejRFakFXRVQ3UmlZajFYT2p3TVhPTjZOa2Zq?=
 =?utf-8?B?aFJLdVlZRVd5WEdTamMwUDlBYjJOQXN0VTJkU3RSNzYzMmZvYVhmb1FMWGQ4?=
 =?utf-8?B?SjYrNXFrRkE3TDFQT0d0TkFhc1JJSnpTL0ZUTFYrV2dZcHBESjFSSFVyUW0r?=
 =?utf-8?B?ZDNLR2FEa0Z3b29PRU00R2MyeDhkR0NQQmNwMTM5ZE5DSTNJZm9mZnZBcW5i?=
 =?utf-8?B?QXcwZ2FOTUVYbWUzekdHQ291R2VITEJFcnVuZDIzZmQzY1ZYczJLSVJDdWlo?=
 =?utf-8?B?a0czWHZ1Z0RtQXBpMEFQZ2M4Q1VlUDdYdnFCNFc5ZEkvclhxOVBKN2tVUHI0?=
 =?utf-8?B?Z2FWbW9QSXNEbnpxQzFtUittWE11OWtmS0RDRWVIVUo5UHFIS3o5NFFWSEdo?=
 =?utf-8?B?RDk2MzR2RUFNajBJblVPTHFxNy8zQXNteHl3Z0t1NXFvUjJBOUdKMEJBUnJP?=
 =?utf-8?B?T1NDR3phZU5LN2dlM0REclRUeFBpZUlMbjNqL2szZzlwWXdUSytwZk5aYzNJ?=
 =?utf-8?B?cFBSY3BER3RWZnNnMzF0UFdXeUdiZnllZmE2MGpQTHlwa3d4TXZ2T0crRUN3?=
 =?utf-8?B?ZWVmc1lIMkQyM3M1d0VuU3k0WjVsNWlYTmdKcnRiRzdUdjlQYy9ZWUdCMjc3?=
 =?utf-8?B?TmEzUjV3eFZHalRUQXBjdGpJaFZQNzRRVHFyUm10OUNEZzgzbzN4dGJQT0Uy?=
 =?utf-8?B?RmIxZXpjVEpoNVRjTzZTTjB4cHJJT1VuT1lHcVoyN1A1dUl5aE9SM3hTanpw?=
 =?utf-8?B?VVFNUVFpZXdnS3Y5Mmlkbzk2REpKbEx0bmIrbDRCaFRDVzAwaGlqbSszUis1?=
 =?utf-8?B?K3pQa2VhUktJYTZ6U20zZENmSnZuT0t6V04xQkRSSVNHTWJsNW9BYWlYekVz?=
 =?utf-8?B?SmpDZVY1ZXl3SzFsbXJIdjlSWHlYSW56aTBkUXJ6aDFIUkRLRXJXU1lISE1F?=
 =?utf-8?B?RVlnR29tdm1jNVlMK0FkRVJILzVsSnBwMHVlSXplb2VXcElXR0tnMEJDNmtV?=
 =?utf-8?B?aUVvWnUxZVY3bXN2ODFERTNFV0htOXYxU3ltUVQxUHByZHBUWDMrbkp3L1Vy?=
 =?utf-8?B?dVo1ZDV5ZnQxd0lhMGgyVWV1L3JYc2FVRkpranlsK3BIQklidU05NjJZSE4x?=
 =?utf-8?B?dEhKM241SUZNbUphS001RGRYV2tOM0RCQTN5RzgxcTQvdjE3ZXRaem52b1lE?=
 =?utf-8?B?V1daSEFjN2xCNFk1MmJ3amcxR3ZpMnM4YSthU1M1ZW9XODVzRWM5K2daYTNB?=
 =?utf-8?Q?ioy0BQ9LObU6OBMeJ4uQ1EZZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7388152-ade2-4b8f-859f-08db815c40d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:42:23.0019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3frwtlYYXOSyM9r+qCzo50IgTUcebPI2gi8nDyH6l80on8bN4DlcSSx7LvoGEqDu7PtAdgkC7rzyVwexzOPUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
Cc: brett.creeley@amd.com, mst@redhat.com, Allen Hubbe <allen.hubbe@amd.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 drivers@pensando.io
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

T24gNy85LzIzIDg6MDQgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gCj4gT24gU2F0LCBKdWwgOCwg
MjAyMyBhdCA0OjEy4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+
IHdyb3RlOgo+Pgo+Pgo+Pgo+PiBPbiA3LzcvMjMgMTI6MzMgQU0sIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNv
dXJjZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuCj4+Pgo+Pj4KPj4+IE9uIEZyaSwgSnVuIDMwLCAyMDIz
IGF0IDg6MzbigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gd3Jv
dGU6Cj4+Pj4KPj4+PiBGcm9tOiBBbGxlbiBIdWJiZSA8YWxsZW4uaHViYmVAYW1kLmNvbT4KPj4+
Pgo+Pj4+IFdoZW4gdGhlIHZkcGEgZGV2aWNlIGlzIHJlc2V0LCBhbHNvIHJlaW5pdGlhbGl6ZSBp
dCB3aXRoIHRoZSBtYWMgYWRkcmVzcwo+Pj4+IHRoYXQgd2FzIGFzc2lnbmVkIHdoZW4gdGhlIGRl
dmljZSB3YXMgYWRkZWQuCj4+Pj4KPj4+PiBGaXhlczogMTUxY2M4MzRmM2RkICgicGRzX3ZkcGE6
IGFkZCBzdXBwb3J0IGZvciB2ZHBhIGFuZCB2ZHBhbWdtdCBpbnRlcmZhY2VzIikKPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbGxlbiBIdWJiZSA8YWxsZW4uaHViYmVAYW1kLmNvbT4KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPj4+PiBSZXZp
ZXdlZC1ieTogQnJldHQgQ3JlZWxleSA8YnJldHQuY3JlZWxleUBhbWQuY29tPgo+Pj4+IC0tLQo+
Pj4+ICAgIGRyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0K
Pj4+PiAgICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggfCAgMSArCj4+Pj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jIGIvZHJpdmVycy92ZHBhL3Bkcy92
ZHBhX2Rldi5jCj4+Pj4gaW5kZXggNTA3MWE0ZDU4ZjhkLi5lMmU5OWJiMGJlMmIgMTAwNjQ0Cj4+
Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4+Pj4gKysrIGIvZHJpdmVycy92
ZHBhL3Bkcy92ZHBhX2Rldi5jCj4+Pj4gQEAgLTQwOSw2ICs0MDksOCBAQCBzdGF0aWMgdm9pZCBw
ZHNfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHU4IHN0YXR1
cykKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHBkc3YtPnZxc1tpXS5hdmFpbF9pZHgg
PSAwOwo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLnVzZWRfaWR4
ID0gMDsKPj4+PiAgICAgICAgICAgICAgICAgICB9Cj4+Pj4gKwo+Pj4+ICsgICAgICAgICAgICAg
ICBwZHNfdmRwYV9jbWRfc2V0X21hYyhwZHN2LCBwZHN2LT5tYWMpOwo+Pj4KPj4+IFNvIHRoaXMg
aXMgbm90IG5lY2Vzc2FyaWx5IGNhbGxlZCBkdXJpbmcgcmVzZXQuIFNvIEkgdGhpbmsgd2UgbmVl
ZCB0bwo+Pj4gbW92ZSBpdCB0byBwZHNfdmRwYV9yZXNldCgpPwo+Pgo+PiBwZHNfdmRwYV9yZXNl
dCgpIGNhbGxzIHBkc192ZHBhX3NldF9zdGF0dXMoKSB3aXRoIGEgc3RhdHVzPTAsIHNvIHRoaXMg
aXMKPj4gYWxyZWFkeSBjb3ZlcmVkLgo+IAo+IFllcywgYnV0IHBkc192ZHBhX3NldF9zdGF0dXMo
KSB3aWxsIGJlIGNhbGxlZCB3aGVuIHN0YXR1cyBpcyBub3QgemVybz8KClllcywgYnV0IHRoZSBz
ZXRfbWFjIGlzIG9ubHkgZG9uZSB3aXRoIHN0YXR1cz09MCwgd2hldGhlciBjYWxsZWQgYnkgCnJl
c2V0IG9yIGNhbGxlZCB3aGVuIHNvbWUgb3RoZXIgdGhpbmcgY2FsbHMgc2V0X3N0YXR1cyB3aXRo
IHN0YXR1cz09MC4KCnNsbgoKCj4gCj4gVGhhbmtzCj4gCj4+Cj4+IHNsbgo+Pgo+Pj4KPj4+IFRo
ZSByZXN0IGxvb2tzIGdvb2QuCj4+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4+ICAgICAgICAgICB9Cj4+
Pj4KPj4+PiAgICAgICAgICAgaWYgKHN0YXR1cyAmIH5vbGRfc3RhdHVzICYgVklSVElPX0NPTkZJ
R19TX0ZFQVRVUkVTX09LKSB7Cj4+Pj4gQEAgLTUzMiw3ICs1MzQsNiBAQCBzdGF0aWMgaW50IHBk
c192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5h
bWUsCj4+Pj4gICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRtYV9kZXY7Cj4+Pj4gICAgICAgICAg
IHN0cnVjdCBwY2lfZGV2ICpwZGV2Owo+Pj4+ICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7
Cj4+Pj4gLSAgICAgICB1OCBtYWNbRVRIX0FMRU5dOwo+Pj4+ICAgICAgICAgICBpbnQgZXJyOwo+
Pj4+ICAgICAgICAgICBpbnQgaTsKPj4+Pgo+Pj4+IEBAIC02MTcsMTkgKzYxOCwxOCBAQCBzdGF0
aWMgaW50IHBkc192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0
IGNoYXIgKm5hbWUsCj4+Pj4gICAgICAgICAgICAqIG9yIHNldCBhIHJhbmRvbSBtYWMgaWYgZGVm
YXVsdCBpcyAwMDouLjowMAo+Pj4+ICAgICAgICAgICAgKi8KPj4+PiAgICAgICAgICAgaWYgKGFk
ZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQUNBRERSKSkg
ewo+Pj4+IC0gICAgICAgICAgICAgICBldGhlcl9hZGRyX2NvcHkobWFjLCBhZGRfY29uZmlnLT5u
ZXQubWFjKTsKPj4+PiAtICAgICAgICAgICAgICAgcGRzX3ZkcGFfY21kX3NldF9tYWMocGRzdiwg
bWFjKTsKPj4+PiArICAgICAgICAgICAgICAgZXRoZXJfYWRkcl9jb3B5KHBkc3YtPm1hYywgYWRk
X2NvbmZpZy0+bmV0Lm1hYyk7Cj4+Pj4gICAgICAgICAgIH0gZWxzZSB7Cj4+Pj4gICAgICAgICAg
ICAgICAgICAgc3RydWN0IHZpcnRpb19uZXRfY29uZmlnIF9faW9tZW0gKnZjOwo+Pj4+Cj4+Pj4g
ICAgICAgICAgICAgICAgICAgdmMgPSBwZHN2LT52ZHBhX2F1eC0+dmRfbWRldi5kZXZpY2U7Cj4+
Pj4gLSAgICAgICAgICAgICAgIG1lbWNweV9mcm9taW8obWFjLCB2Yy0+bWFjLCBzaXplb2YobWFj
KSk7Cj4+Pj4gLSAgICAgICAgICAgICAgIGlmIChpc196ZXJvX2V0aGVyX2FkZHIobWFjKSkgewo+
Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGV0aF9yYW5kb21fYWRkcihtYWMpOwo+Pj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGRldl9pbmZvKGRldiwgInNldHRpbmcgcmFuZG9tIG1hYyAl
cE1cbiIsIG1hYyk7Cj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgcGRzX3ZkcGFfY21kX3Nl
dF9tYWMocGRzdiwgbWFjKTsKPj4+PiArICAgICAgICAgICAgICAgbWVtY3B5X2Zyb21pbyhwZHN2
LT5tYWMsIHZjLT5tYWMsIHNpemVvZihwZHN2LT5tYWMpKTsKPj4+PiArICAgICAgICAgICAgICAg
aWYgKGlzX3plcm9fZXRoZXJfYWRkcihwZHN2LT5tYWMpKSB7Cj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZXRoX3JhbmRvbV9hZGRyKHBkc3YtPm1hYyk7Cj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZGV2X2luZm8oZGV2LCAic2V0dGluZyByYW5kb20gbWFjICVwTVxuIiwgcGRzdi0+
bWFjKTsKPj4+PiAgICAgICAgICAgICAgICAgICB9Cj4+Pj4gICAgICAgICAgIH0KPj4+PiArICAg
ICAgIHBkc192ZHBhX2NtZF9zZXRfbWFjKHBkc3YsIHBkc3YtPm1hYyk7Cj4+Pj4KPj4+PiAgICAg
ICAgICAgZm9yIChpID0gMDsgaSA8IHBkc3YtPm51bV92cXM7IGkrKykgewo+Pj4+ICAgICAgICAg
ICAgICAgICAgIHBkc3YtPnZxc1tpXS5xaWQgPSBpOwo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZkcGEvcGRzL3ZkcGFfZGV2LmggYi9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPj4+PiBp
bmRleCBhMWJjMzdkZTk1MzcuLmNmMDJkZjI4N2ZjNCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJz
L3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2
LmgKPj4+PiBAQCAtMzksNiArMzksNyBAQCBzdHJ1Y3QgcGRzX3ZkcGFfZGV2aWNlIHsKPj4+PiAg
ICAgICAgICAgdTY0IHJlcV9mZWF0dXJlczsgICAgICAgICAgICAgICAvKiBmZWF0dXJlcyByZXF1
ZXN0ZWQgYnkgdmRwYSAqLwo+Pj4+ICAgICAgICAgICB1OCB2ZHBhX2luZGV4OyAgICAgICAgICAg
ICAgICAgIC8qIHJzdmQgZm9yIGZ1dHVyZSBzdWJkZXZpY2UgdXNlICovCj4+Pj4gICAgICAgICAg
IHU4IG51bV92cXM7ICAgICAgICAgICAgICAgICAgICAgLyogbnVtIHZxcyBpbiB1c2UgKi8KPj4+
PiArICAgICAgIHU4IG1hY1tFVEhfQUxFTl07ICAgICAgICAgICAgICAgLyogbWFjIHNlbGVjdGVk
IHdoZW4gdGhlIGRldmljZSB3YXMgYWRkZWQgKi8KPj4+PiAgICAgICAgICAgc3RydWN0IHZkcGFf
Y2FsbGJhY2sgY29uZmlnX2NiOwo+Pj4+ICAgICAgICAgICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
bmI7Cj4+Pj4gICAgfTsKPj4+PiAtLQo+Pj4+IDIuMTcuMQo+Pj4+Cj4+Pgo+Pgo+IApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
