Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1156C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 15:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 358BB80C65;
	Wed,  8 Mar 2023 15:47:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 358BB80C65
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FxgKyq+/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08jJozYh3-K0; Wed,  8 Mar 2023 15:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A20C280C3F;
	Wed,  8 Mar 2023 15:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A20C280C3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7860AC0035;
	Wed,  8 Mar 2023 15:47:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E44CDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 15:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE50B80C42
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 15:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE50B80C42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zcIvqEoCcPse
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 15:47:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B76FB80C2C
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B76FB80C2C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 15:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et2YIxQzQpFZoB1n1kaf2ykOuAv38LD4Ko2vke66fkxQyNLl/fg5QygXzTvoiefl++v5R1m7faWop4rVNi0vQGIJ+aY5imVvHV6oLmZYGZVCQvyP7dxxzax7xdbvX9e23chyyMYBFhGGGtidj6NpATQ8T05KrQEdGVJE78WnIdAxj5PrcVGq8DSaeBGp5prJ30m5VVBHPSdwU9bNshlNlaLpo5eoeCT5GO6kXjiqJh3E3ylrRE2YtHJN2A6owghM5j6Qs8URYXCJrV91qCOcrCuDrVYfEMDKHhUoxZmco2i/yU4KBcabL3cthjONQDDeRK9yzd4yK9E0JOO5BI9WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyszeK8fBupVfC4Ex6eK+vO+3DjcU/26tutYn6GvRTc=;
 b=PvW42b2Nn+Ez8xQM86U9elyV7Gxvd83RXeEPW6X9lQ2D0qkjvBMpDt3vO1Bx1iHH20aSWfuZRHM5LXNuiXwjhLZBGg0Cd4Dg2rMlYkhgtWCaAkF8wMi9d+pTlRdv6En9onMGsuO51TqYKIi3DRctr9WJGgA9ocYnzOqRsbC2aAO4EllmwuSBS36zZjuyKCIRObcDSHvn1opjUxHcMrStKAgecy47BdB7/MkUs6j78GCnlQij8fLqHhh74oS95uhte0HdDRGsbqRY67tJ8gJ5Jyc5V5+Gx7bAVkCg2TMBECj90WQ+HImJvSFuwsK4WcFywXQE0Rwcw5d6MNyn6Sfh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyszeK8fBupVfC4Ex6eK+vO+3DjcU/26tutYn6GvRTc=;
 b=FxgKyq+/ZphVjTNcKkzBtZkLlMcH48+antTJSbcmX2/8XkkImBThxReRfodrw3IHcwe0upnNnjLgTXluzlHWJiWVQmEXw3ZXpXn+kTw+u0MYSNB3Rh7x3Gi4O97BQrILOJNX03HWYzCHSDT0HVL261YEbrVE78xDXoLkral8+w0B302DVkMeXG0HA6InWahuzllvU8E/BkJGskCfjdzEPKBXTDLsdZULdFZA9bkWAQU5zafTaM2ZGWnieUW59m9jLmMm81E2MaqvxgyeIbi1Ri90FuhjOm+tjHJkPwW08H2e4FddhYULusuDJgyGeRrd2mDa5NGAQ3UPBWScGH4O3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 15:47:42 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 15:47:42 +0000
Message-ID: <29414220-cdb1-0fb5-03d9-f928055fe4e4@nvidia.com>
Date: Wed, 8 Mar 2023 10:47:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
 <20230308091442-mutt-send-email-mst@kernel.org>
 <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
 <20230308092541-mutt-send-email-mst@kernel.org>
 <cc5de402-ad79-7bce-74d3-77356a6fb66a@nvidia.com>
 <20230308094115-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308094115-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|BY5PR12MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc90cfe-b429-4576-019b-08db1fec740d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlrSqnF0hf65kDP5/S+GxCMp3bjWe9Mb71gauoJlx78nsA+ryCIfp5gTseCYfCGSbes9SX9dBpKXLE5ShY9j+7irKDzECaiUoqd91mquFJEkVjXGxyZrM4x5Cr/V8gmOQFAHvQRhGu/dnP+IEOx5UuQ6siAVGjqbwngcqV9v1DpdnMbK/eA21f5jDSMbkllQ3bj3/MPMEe/w2hRD1d8UIqtLquLm8EKjM9659dsAv9mff9BoDXVaDU4MvceBrtTBLbtXjstmLHEkbCUvHFoux28xOrMv25WRKC+2FtYKTYUPkhkKUCv+wsx1naypslgRrnD4I9e1ZDBIwZlzqabQO42IbV0JyDN2fiNByg+5RhQm94XAPwlmNrG5uxe/J5uZ4sii3Tm6oi6X8ycJYcbnZ1GP5PG3+XJwG9SD7zp07K8jFwHwD7jcjZiwQrch7aO7x1FyuNq8ZkH2RRM9HsMHLh8tjjKwyr01A90CnKJRbkvnb9GaRJLdyKM0IPbXB8lFf4DFvJdzasWlHgA2hqaNyr/6IyGNmtngdvvtISLi8olhPjmWhmwR/wJrgx1D28KMdDl/579PEGeYw/cmpRy/NANab2ZbtsshHxTIf11iZzGx3iWx3O8uTb0kbbXzqpUaiVaCBKbJ2dqvM5u1YrIUmkWDICnIVUhhRReU3K53dZcj4ft82YJM5gixtZtUVoLBtdfF9cJdRJGi+C8MBgEzyvSo86K9rdhzf40MczZaXYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199018)(6666004)(107886003)(54906003)(31696002)(41300700001)(8676002)(86362001)(83380400001)(6916009)(36756003)(4326008)(316002)(8936002)(66946007)(66476007)(66556008)(478600001)(6486002)(5660300002)(186003)(26005)(2906002)(38100700002)(2616005)(31686004)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZIaXlkR2lRWEg2WEY2cHRBQnlMQzZ6VVpmdkowRHRjWTIxa0w4RDhIaGxr?=
 =?utf-8?B?OUdVL1hPQ2o5ZENCRHNEcFNpTFZ1OUVjSnZtcmt1WnlKZmlHeDM1Nm5takVn?=
 =?utf-8?B?MXJpL1JYSmRadThIb0hnWW5WaW84ZXdrM2NhY2VRM3dNcnZ3dWZNTDZDcDVx?=
 =?utf-8?B?WkpZVXZ0blMwaVFTUm82eExTbVI0V1MycFo4ekhzNnZJTXlnN1pnNVBzcUFv?=
 =?utf-8?B?NVNkZnhIYTNtREl1amhiV2o0MW5aMCsrZi9Kd3N5TDN3VnBBcnUwNDdiSXEz?=
 =?utf-8?B?MHY4WDNMSVV0NmR2TUpsZzZOR1FVUTlFTFJ3ZUtYa1FUSVBab1RuTHFqTFlE?=
 =?utf-8?B?V1NDRUZLV3EyakRrWmE1QUJoeHhiWVJHc3VVbzVuUXlQRzdjSndZTGJBRWlm?=
 =?utf-8?B?YllBRUZGQi9PK2h3dWZGSkRUckxQZ0k5TTVXYnpibExQUjlEcHhZcGxla0ho?=
 =?utf-8?B?Qk8xUUtZaXB1bkh6UVJaMGdBYnVUbEN1bFdlOVRsaUo2MDcreXJlVnI3SmtU?=
 =?utf-8?B?dkh5UjlKOEIvbVNkVjlwc1BIYlZCUHRjTzlBR3R6eVBLaVY4RDBzWVVabm90?=
 =?utf-8?B?SzZZSEVyVzdmQmUwL3JzYy9oRFhBOE1MV21IQkJWSHVCeSsrWjU0RE1vTnZ3?=
 =?utf-8?B?Y3pXdmdQNjErWDBNNllJM2NvTjBzTGhwdDNqTEt2NkRiRkJJR0EwSHE0ZW5G?=
 =?utf-8?B?ckdhSkZQQTlOanlweEVGd3FucTI5a1Rhb0E4b0x5azI4YWNpK0NYSnlNMlVK?=
 =?utf-8?B?STR0cE91dUs1U0c4YjFGVUo1aDB4SjRtYTU4VjhiMnk0Ris5c2RQU2JPRCtL?=
 =?utf-8?B?UHl3aUNJcUs5azRuMkRiQmZGVTNzNXUxOFBxY0FZZGk3YTlpbUJyWVhJNlBi?=
 =?utf-8?B?UEVkUFkwcDUwdmpUUWlMaGlQcS92NnE2MHZpeVZSNmpsbS9aQUladFAvVkRM?=
 =?utf-8?B?amV5bDZPazN1aDErYW80N1pDZmNNQlBPUW5STmY5Sk04eUJISnRtdDVrWXA1?=
 =?utf-8?B?U3ltM3ZRVWJQdTV3UGt4bmpYSDlHL1V6eGdCQlVsK1hkNzRralFKVzVkZXRW?=
 =?utf-8?B?YWgvYmdmMW1rQjZuYldzc1pqMTJ2Rm8wdVNvbU5DTzBzdjRqaGVWN2RUNG5H?=
 =?utf-8?B?ZU5mbmZZcnF4VUdmU2tkSzhKREt2ekpoM3Y0OTdINXdQVGx1ejIyd2VpTG5w?=
 =?utf-8?B?OEh2K1M3L1hhZEw4RFl6d1R2a2xzY1JxVVkwYmdVVjV3VEdnM29nSEdqcWZH?=
 =?utf-8?B?c290eThkYTZ2a0dibXB2TnJGcVR0NFhzVktZYjZmU2tuQWh3UE1maG9TVmVk?=
 =?utf-8?B?UVNLTzczNWYvdkpXeWpML3F5ckNURWNGV3N3WEJ0RnJjVGJ1RWhaVXlNREMx?=
 =?utf-8?B?VXU5enc0bllkQ2JEWEdMSEppckRySXloRlVkdzNYOFJKeWFxTEVFQ0dUNkpO?=
 =?utf-8?B?TFJFWXNjZUN0OHcrV0s2aUdIaEtHTFl5cW05SW8zUFNNdk9JL2NFS2czc1dS?=
 =?utf-8?B?L3FPdm5WbTRnR0RZWWhXQW5xSGdpZkF2K1B1cVo3aytYT3BOd0FNOFBwY2xl?=
 =?utf-8?B?M0dDU3piV3JZdEVRVXlXYTJjenlnVkxqeWQ0VHY5OG9NQ00xMGZkcGw3MmRM?=
 =?utf-8?B?bWJWOUZYRVh0bzZzeGRCc3JDVjUwNDhMZXY2S01KUXRreThKdHhsOXM1OHZ2?=
 =?utf-8?B?WkovN05zYUpkT0JWTDdpM3dYc3loTUVXS2VBTjRxUFRvcDNWVW4vR1htUDBC?=
 =?utf-8?B?UjVpR3IycG9pTjkvT0ZWd2FnMG1IZzBDRkZXK2xjK0pkaGk1SzE1SzdNVENG?=
 =?utf-8?B?RjdDWXJsRDJNRmR2WjZXN1FVZ1VNSnQzYlVXVVNHYXp1S3RId0h4c2xFdzY5?=
 =?utf-8?B?REZKT2oxZW1KbnJaK2dFUGM4N1JFaTF1U2ZhU0VuYTM0TW05cXI0QTRWUnR1?=
 =?utf-8?B?ZHlubkk5SUhYMExRY0dlVHp4cGZCM09JN25ORlk1VlBZZnNUYXBWL1RVa2tZ?=
 =?utf-8?B?b3pYOW1KMlhWdGNQM2VBdDNSeVNCYng5YnJ4eSs2YnVSSTc3Wnh3cDFEVFhs?=
 =?utf-8?B?UXJiME43U0MzVHUvVVc5N2FiZklkWlFJL3ZtZFVodlNmODBvRlBmOG5vZXBX?=
 =?utf-8?Q?dG82zNOu0gtf2ZCLjpVCixyXy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc90cfe-b429-4576-019b-08db1fec740d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:47:42.4215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sfI7b0H83igPgHd19WJP7cHr6AIfHXM1ZpwKrQlWgZBn/xB6AN974x4YLLyEfDkpuv/S4VjkT/KrHw1m/wxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966
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

CgpPbiAyMDIzLTAzLTA4IGEubS45OjQ3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPiAK
PiAKPiBPbiBXZWQsIE1hciAwOCwgMjAyMyBhdCAwOTo0MDowM0FNIC0wNTAwLCBGZW5nIExpdSB3
cm90ZToKPj4gSW4gZmFjdCwgSSBjb21waWxlZCBhbmQgdGVzdGVkIGxvY2FsbHkuIEkganVzdCBs
b29rZWQgaXQgdXAgYW5kIGl0IG1pZ2h0IGJlCj4+IHRoYXQgSSB3YXMgbWlzc2luZyBhIOKAnGdp
dCBhZGTigJ0gYWN0aW9uIHdoaWNoIGNhdXNlZCB0aGUgcHJvYmxlbS4gQmVmb3JlIEkKPj4gcG9z
dCB0aGUgcGF0Y2ggaW4gZnV0dXJlLCBJIHdpbGwgZmluZCBhIGNsZWFuIGtlcm5lbCBzb3VyY2Ug
YW5kIGFwcGx5IG15Cj4+IHBhdGNoIGZvciB0ZXN0aW5nIGluc3RlYWQgb2Ygb24gdGhlIGJyYW5j
aCB3aGVyZSB0aGUgY29kZSBpcyBtb2RpZmllZCwgc28gYXMKPj4gdG8gYXZvaWQgdGhpcyBraW5k
IG9mIHByb2JsZW0gZnJvbSBoYXBwZW5pbmcgYWdhaW4uIFZlcnkgc29ycnkgZm9yIHRoaXMKPj4g
cHJvYmxlbSwgSSB3aWxsIGJlIGNhcmVmdWwgYW5kIHBheSBhdHRlbnRpb24gdG8gaXQgbGF0ZXIK
PiAKPiBJIGhhdmUgYSBwcmUtcHVzaCBob29rIHNpbmNlIGl0IHdhcyBoYXBwZW5pbmcgdG8gbWUg
YSBsb3Qgd2l0aCBwdXNoZXM6Cj4gCj4gCj4gIyEvYmluL3NoCj4gCj4gIyBBbiBleGFtcGxlIGhv
b2sgc2NyaXB0IHRvIHZlcmlmeSB3aGF0IGlzIGFib3V0IHRvIGJlIHB1c2hlZC4gIENhbGxlZCBi
eSAiZ2l0Cj4gIyBwdXNoIiBhZnRlciBpdCBoYXMgY2hlY2tlZCB0aGUgcmVtb3RlIHN0YXR1cywg
YnV0IGJlZm9yZSBhbnl0aGluZyBoYXMgYmVlbgo+ICMgcHVzaGVkLiAgSWYgdGhpcyBzY3JpcHQg
ZXhpdHMgd2l0aCBhIG5vbi16ZXJvIHN0YXR1cyBub3RoaW5nIHdpbGwgYmUgcHVzaGVkLgo+ICMK
PiAjIFRoaXMgaG9vayBpcyBjYWxsZWQgd2l0aCB0aGUgZm9sbG93aW5nIHBhcmFtZXRlcnM6Cj4g
Iwo+ICMgJDEgLS0gTmFtZSBvZiB0aGUgcmVtb3RlIHRvIHdoaWNoIHRoZSBwdXNoIGlzIGJlaW5n
IGRvbmUKPiAjICQyIC0tIFVSTCB0byB3aGljaCB0aGUgcHVzaCBpcyBiZWluZyBkb25lCj4gIwo+
ICMgSWYgcHVzaGluZyB3aXRob3V0IHVzaW5nIGEgbmFtZWQgcmVtb3RlIHRob3NlIGFyZ3VtZW50
cyB3aWxsIGJlIGVxdWFsLgo+ICMKPiAjIEluZm9ybWF0aW9uIGFib3V0IHRoZSBjb21taXRzIHdo
aWNoIGFyZSBiZWluZyBwdXNoZWQgaXMgc3VwcGxpZWQgYXMgbGluZXMgdG8KPiAjIHRoZSBzdGFu
ZGFyZCBpbnB1dCBpbiB0aGUgZm9ybToKPiAjCj4gIyAgIDxsb2NhbCByZWY+IDxsb2NhbCBzaGEx
PiA8cmVtb3RlIHJlZj4gPHJlbW90ZSBzaGExPgo+ICMKPiAjIFRoaXMgc2FtcGxlIHNob3dzIGhv
dyB0byBwcmV2ZW50IHB1c2ggb2YgY29tbWl0cyB3aGVyZSB0aGUgbG9nIG1lc3NhZ2Ugc3RhcnRz
Cj4gIyB3aXRoICJXSVAiICh3b3JrIGluIHByb2dyZXNzKS4KPiAKPiByZW1vdGU9IiQxIgo+IHVy
bD0iJDIiCj4gCj4gZWNobyAiUHJlIHB1c2ggaG9vayBmb3IgcmVtb3RlICR1cmwiCj4gCj4gI2lm
Cj4gIyAgICAgICBlY2hvICR1cmwgfGdyZXAgXnJvb3RAdmlydGxhYiA+IC9kZXYvbnVsbAo+ICN0
aGVuCj4gIyAgICAgICBlY2hvICJMYWIgcHVzaCBubyBuZWVkIHRvIGNoZWNrIgo+ICMgICAgICAg
ZXhpdCAwCj4gI2ZpCj4gIwo+ICNpZgo+ICMgICAgICAgZWNobyAkdXJsIHxncmVwIF4vID4gL2Rl
di9udWxsCj4gI3RoZW4KPiAjICAgICAgIGVjaG8gIkxvY2FsIHB1c2ggbm8gbmVlZCB0byBjaGVj
ayIKPiAjICAgICAgIGV4aXQgMAo+ICNmaQo+IAo+IGNoZWNrZWQ9MAo+IEhFQUQ9YGdpdCByZXYt
bGlzdCAtMSBIRUFEYAo+IElGUz0nICcKPiB3aGlsZSByZWFkIGxvY2FsX3JlZiBsb2NhbF9zaGEg
cmVtb3RlX3JlZiByZW1vdGVfc2hhCj4gZG8KPiAgICAgIGlmIFsgJGNoZWNrZWQgPSAwIF0KPiAg
ICAgIHRoZW4KPiAgICAgICAgICBpZiBbICIkbG9jYWxfc2hhIiA9ICRIRUFEIF0KPiAgICAgICAg
ICB0aGVuCj4gICAgICAgICAgICAgICAgICBlY2hvICJQdXNoaW5nIEhFQUQgdG8gcmVtb3RlLiBD
aGVja2luZyB0aGF0IHRyZWUgaXMgY2xlYW4uIgo+ICAgICAgICAgICAgICAgICAgaWYKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2l0IGRpZmYtaW5kZXggLS1xdWlldCBIRUFECj4gICAgICAg
ICAgICAgICAgICB0aGVuCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGVjaG8gLW4gIyBObyBk
aWZmZXJlbmNlcwo+ICAgICAgICAgICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBlY2hvICJESUZGIGluIEhFQUQuIE5vdCBwdXNoZWQsIHN0YXNoIG9yIC1uby12ZXJpZnkh
Igo+ICAgICAgICAgICAgICAgICAgICAgICAgICBleGl0IDEKPiAgICAgICAgICAgICAgICAgIGZp
Cj4gICAgICAgICAgICAgICAgICBjaGVja2VkPTEKPiAgICAgICAgICBmaQo+ICAgICAgZmkKPiBk
b25lCj4gCj4gZXhpdCAwCj4gCj4gCj4gCj4gQ29uc2lkZXIgc3RpY2tpbmcgdGhpcyBpbiBhIHBv
c3QgY29tbWl0IGhvb2sgbWF5YmU/Cj4gCgpPSyx0aGFua3MsIHdpbGwgZG8KCj4gLS0KPiBNU1QK
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
