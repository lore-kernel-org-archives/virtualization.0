Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F9FC77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 18:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A211613C8;
	Mon, 15 May 2023 18:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A211613C8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tErNTvZf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-rhDNfMuFCs; Mon, 15 May 2023 18:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9141260BF5;
	Mon, 15 May 2023 18:30:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9141260BF5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 642F6C0037;
	Mon, 15 May 2023 18:30:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D2BAC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADBB760FEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADBB760FEB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmTGATeuUNTR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:30:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E734F60BF5
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::611])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E734F60BF5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 18:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cxg6P6icx+nQkDPWVS8XbIOjoTsmUBCoM+638ICqckL9fVryRuoQCwfAoYIGWi2+anDh3HUpLZnHn1jtSlAUDSvECxkCxe+DfsC/D5RbO2g+9jnAj/EA8O16LX0iE43zgpGl5RjU6VQXHqjzTHKpG8xSpqWrdsy8kX4UQvJoUa/R6wwRcmQW7LgNKlOeqjG2DVxd2YujkcCNEfa2R72ODpkVmC/59ZfdLNc37duE2wtJp2pE0EHDb17AuTX1U+1reV6hK1frIzlJcYpa3Exd1xhL2fBVUSKyW+eFs+XlXJQe6EvD/xxJ2WyATiN9ilEIuptGHpzfRFc9nwSFF4Sm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q711ubYKFPcGk+ZtOZtXhPLA/r3fdhXk1taCpUXS+Fo=;
 b=eFd7lTNt1JmAiQiImDdrFlWRIfHc2lHO250dK0r7W1ckjIvS0KZl/EFoKyqd95XbxZL+lSG8a5FdHeZHcw4cL0BF5vNJeDEroKFFCnL/U6aIYrYckmKrRO3lJNI7sCXarEeaDnmVrPVdYd+0z0Vdzup2ooDuLM++ju2W0gI1Ix14tWAMEvPPotlJT4pCvrMBtXQYcTNuLTCcRBsWLfdJ1FGAs7xbT8qzGKJ8pjVF1oOEpCseerJKuWRza0olGk+tyFvHIWelaQyGMYp6CCpgwTfVsijLOHgAd/qWiU1onSGfY2Ihyxms9YMdwZsG8R8xQEz9LddBL6g6IeOSV3pL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q711ubYKFPcGk+ZtOZtXhPLA/r3fdhXk1taCpUXS+Fo=;
 b=tErNTvZf9TFTNPpvCn9+MK/CZCQeIZAdg6KHtDYH5ZX335XgoEKrh74AJphRssIlYMMIA1UszM9/xhmwDPRXa+D1YZ3PQZ4fm9MFt6TSVwKY13go3E6FEbeJv7qAaCyTeb5Tpg7DQ9R/oPn8Q3HDlvgEcMURDtuSo79skRoPtLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 18:30:39 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:30:39 +0000
Message-ID: <429e42a9-c478-6951-2661-d3fa569a6e83@amd.com>
Date: Mon, 15 May 2023 11:30:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v5 virtio 10/11] pds_vdpa: subscribe to the pds_core events
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-11-shannon.nelson@amd.com>
 <CACGkMEuytKwDp3GLcaQmU1CtWSmb2RZRaGdgFyXoCqveruJBpA@mail.gmail.com>
In-Reply-To: <CACGkMEuytKwDp3GLcaQmU1CtWSmb2RZRaGdgFyXoCqveruJBpA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 869c13be-9bb6-4f77-0127-08db55727bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVFDPP10cGVO6UTG1MkjIbQyuV+bHaHSB7Rw7bfmza5Toq23k57qnS9Ro2PYoDso9WVQV9IKatoce7JGTx0mIkM9o44wp3ySWSxSpQCkSQDKTlI3//G8BqB8hL4XYH1LCzMamW9TE/YGaIEykIZYHXMsmGzpYCyjMPzmVnQINCJrX1nPPdioLwiv3E6971y+X0ACjh3PtjCG/B2fDy6aC8gfHojfy2Z81BSwzwH8LzBaZTsPphml8aNxRbEaL1lYSZZ4EKmyOLuoK/XTp6UKj05XyF2PEmGr+9FLlKFGDHox8rJBetdbZnH80nzg2WLTSWQHZGqWR9tnt3TaiN5ewQjjmiK++2CCnEJyRZvuASviUzL3J3qDKKnjZQsyx1G0hRLDadjh0RGYGSg4sE01hMRo40G/XfSJAftm50Zh9C71lBWmZGNKjyArtWhf6jVwoitezbnZPHKU1pMXEqoJVeni6x7Y+XYqMXuqIlCNU6jabPeGjSdhhzz4+uJa47wfldy4FPwX/Ku1Tvykvliv6MTHtshItP7bSmssEJXExQMYw+KnlBeVRETWD5/mNLI03ksIRaUHw20MnHnZV8XYdWA6Xu+4dhYOVqlQK1PxUIqhXGGrJB656OubZe7zRuq67agbF+LoQEmrRQo9r9PNIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(86362001)(2906002)(31696002)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(38100700002)(6666004)(36756003)(478600001)(54906003)(83380400001)(53546011)(31686004)(8676002)(26005)(186003)(8936002)(6506007)(44832011)(6512007)(41300700001)(2616005)(6486002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdBZ1BZSDR1dG14VlozeVNKcjVpSXhLR0xjbCtlQVBCcW5kdU9uRUFOeTQ2?=
 =?utf-8?B?REJyUHpNbXlaa2FGdmF1RWFEVjZ1QWtxM3h6TVZ5R1hkenJHbEg0Y2MrdWNJ?=
 =?utf-8?B?dzlYcmttZjdUWkdkVld6R3FmK25RbWNLcXRKMjNnQklCcHJpL1BTVlhHaE9O?=
 =?utf-8?B?UlRuMXJVdzJoQUFkUUZZd2xEQndXUzh0b1U1NXcvaENNZ1MwTGxGekVuaGtX?=
 =?utf-8?B?ZGhnVXhZeWhud1BnSVVSUEg0ZVlleHVhTEtGTXV5QTV6RFJtUmJHS1lZRnds?=
 =?utf-8?B?RThDblpsVEtyTWZBUHZDRjduYTk5dGJ6eGFvQ3J5SFZpMHpHUGM5ejEyUGlN?=
 =?utf-8?B?QWQ3L0swZHlXdmliaTRxZVNWa1U5SlpBZ3FHa1YyWi9uTExUakNob2YzSFJG?=
 =?utf-8?B?YjNjd3NvUmVoYnhQUzl0ZkNlR2lQTllhZVB1V2NIa0R6MkFaM2FybFFBMldJ?=
 =?utf-8?B?TzlaMWRXaUlkcGU3K3NaSm9odkhFRjJLc0RhY0pDSmQvS1NGRk5BTW5XQ3oy?=
 =?utf-8?B?a0xqeVVRazEwL1IrTGZvMGVQdkZoMERrZ2hnN05MTGswUWg4Q1RkSlpPQkZQ?=
 =?utf-8?B?QVBhZWNZWDNDMHU1a29WbFZLQ3lVMFdiT1FHZ1VWVFpaM0UvejNOVGFLUHlV?=
 =?utf-8?B?bXRMcnBIejB1OVUyZEFNRFEvUW5XQ2hlK0kxV1ViY2xMZyt4SjFWT0V0M3F5?=
 =?utf-8?B?Y3JKWS95R2dLeXJWeDFSa29VTk4yUVZKNElnakpSMmhvWXFicWtkV1QyejJS?=
 =?utf-8?B?a2E5ZjFqVm84MFBpdDJ1ZXQ0RGpucmRWZ3JqcHBodTN5NnhhQW1uMi85TDNl?=
 =?utf-8?B?Zm1ZaTRmanMyWldWQmRvM0kxa1Z0azBEWjlRS1VPb1JOZHR2c3IvSWVXSjZa?=
 =?utf-8?B?WEw5cERJc3pmb3BkbHo1Yk1ualVMNzVzUkgyN2U0cjkzMi9qcm1tSlBxSm5z?=
 =?utf-8?B?N053enowbTNUSXNhWkE4MUJIZ3dBazE3ZU9idkVzU241OXFHSTdhSUxyRjhj?=
 =?utf-8?B?UTc0eXFvN0lvcStnYmpGKzVwL2ErTWZsMUxRdjVoeHVTajVjREVGd2FjUEQv?=
 =?utf-8?B?YXRUN0dwczc5a0tYNE13T0NwUkRvd3N2YzRJZ2N5eHJPSHlLajdKcnVTcGEy?=
 =?utf-8?B?RmFxaERVU0IrNnJIOFd2aGxncVR3WDVwdlE3bGwxQlg5TkZRL0tBbm5yVEZj?=
 =?utf-8?B?ci9jS21mSFJ0QmcydC83T21VTld2UHFHOVFzU1FPd01nMzdGeHk2eG0ra0Vj?=
 =?utf-8?B?L040Tm1NMFBDRkYvWEp4cnRPZlVEUnFSRjMyRVhNN1d4T3gwUTgxMEhYY2NH?=
 =?utf-8?B?cUlFdGdkcVM1TER0amN6OEQ5VEF0aVJLM25TeFcxMEtMNUx2bWQyaHl4RXVN?=
 =?utf-8?B?RmhRNno0TW5xWDI0dVd2ZzduTHBnSFljOG5Obk13elJEbW9ydDhSRlo4Z0xo?=
 =?utf-8?B?cXpGVE5rZ2JXaWxMLzZOSDMyMm1nbzVBZ1JneVQyNk5yOWx2MTFjSlhNWW4w?=
 =?utf-8?B?a3hSVk5ibENvTTZnMHpsU1EvbC9OY3g3bUxPdjVyaE1uenQ0SmNqQ1VwMUV3?=
 =?utf-8?B?K2d3MGJsNHV1MXJKRnNEaFhvalFOdGFuT3drWUtad01QN3lEbEsyM3BhVTdh?=
 =?utf-8?B?bWlyN3JhTWhuOHViZEI2Z1RhTG9VRzNBNWVSUndFZk8wT1pxRWVraEdhREF6?=
 =?utf-8?B?ekJOZXU4UE5DZ1VJOU5Lc01sNHA3dlJEQ3VZS0haREkrZi9wdzFMUnhxZmFM?=
 =?utf-8?B?czhxUmQ3TzRjcERzOEVTUTBmZXREK1g5b282NXhlZURwRkthN1ljdTRXL2VV?=
 =?utf-8?B?eVFSWnZ0YW1aMUhpd1pZMVdMQ0dSMlJIOURYVUsxdkR4ZVpxaDVZZVlIZ3Vs?=
 =?utf-8?B?NzNsVTBadldmanB3MklYMjNwSFJCQU11UkVBdytNam9ZbmxkSnZobHhUNFVX?=
 =?utf-8?B?OTR3VFJWSU8zMjluMkJuYW9NR200dVZ6cThOUHVtaWtVTHlRS2duQXNDNFZO?=
 =?utf-8?B?VElRWW1FVGs3cW90UjB0OVFQN0ViLzlEYmYrOWdvUG41ekN5WEZZSEhyTFhZ?=
 =?utf-8?B?ak1nMTZZcElxVmYrejRlSW5ZUW0xd0t5SUthZjU2Z0JvdFY4UjFocjlHTXMz?=
 =?utf-8?Q?fcz4U5qB8y7/YlRjv6KwLWh9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869c13be-9bb6-4f77-0127-08db55727bb4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:30:39.5086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1TyBYQryJV6scWYo4XmH0W6CIT8p+JZFmi+pvznTS8MX2jClegE4fSRCruyWcIWP0b73WG8VNa/GUq27QqAhA==
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

T24gNS8xNC8yMyAxMDowMiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUaHUsIE1heSA0LCAy
MDIzIGF0IDI6MTPigK9BTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4g
d3JvdGU6Cj4+Cj4+IFJlZ2lzdGVyIGZvciB0aGUgcGRzX2NvcmUncyBub3RpZmljYXRpb24gZXZl
bnRzLCBwcmltYXJpbHkgdG8KPj4gZmluZCBvdXQgd2hlbiB0aGUgRlcgaGFzIGJlZW4gcmVzZXQg
c28gd2UgY2FuIHBhc3MgdGhpcyBvbgo+PiBiYWNrIHVwIHRoZSBjaGFpbi4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+Cj4+IC0tLQo+
PiAgIGRyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYyB8IDY4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0KPj4gICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggfCAgMSAr
Cj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgYi9kcml2ZXJzL3Zk
cGEvcGRzL3ZkcGFfZGV2LmMKPj4gaW5kZXggOTk3MDY1N2NkYjNkLi4zNzdlZWZjMmZhMWUgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYwo+PiArKysgYi9kcml2ZXJz
L3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPj4gQEAgLTIxLDYgKzIxLDYxIEBAIHN0YXRpYyBzdHJ1Y3Qg
cGRzX3ZkcGFfZGV2aWNlICp2ZHBhX3RvX3Bkc3Yoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2Rl
dikKPj4gICAgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9vZih2ZHBhX2Rldiwgc3RydWN0IHBkc192
ZHBhX2RldmljZSwgdmRwYV9kZXYpOwo+PiAgIH0KPj4KPj4gK3N0YXRpYyBpbnQgcGRzX3ZkcGFf
bm90aWZ5X2hhbmRsZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwKPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGVjb2RlLAo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEpCj4+ICt7Cj4+ICsgICAgICAgc3Ry
dWN0IHBkc192ZHBhX2RldmljZSAqcGRzdiA9IGNvbnRhaW5lcl9vZihuYiwgc3RydWN0IHBkc192
ZHBhX2RldmljZSwgbmIpOwo+PiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZHN2LT52
ZHBhX2F1eC0+cGFkZXYtPmF1eF9kZXYuZGV2Owo+PiArCj4+ICsgICAgICAgZGV2X2RiZyhkZXYs
ICIlczogZXZlbnQgY29kZSAlbHVcbiIsIF9fZnVuY19fLCBlY29kZSk7Cj4+ICsKPj4gKyAgICAg
ICAvKiBHaXZlIHRoZSB1cHBlciBsYXllcnMgYSBoaW50IHRoYXQgc29tZXRoaW5nIGludGVyZXN0
aW5nCj4+ICsgICAgICAgICogbWF5IGhhdmUgaGFwcGVuZWQuICBJdCBzZWVtcyB0aGF0IHRoZSBv
bmx5IHRoaW5nIHRoaXMKPj4gKyAgICAgICAgKiB0cmlnZ2VycyBpbiB0aGUgdmlydGlvLW5ldCBk
cml2ZXJzIGFib3ZlIHVzIGlzIGEgY2hlY2sKPj4gKyAgICAgICAgKiBvZiBsaW5rIHN0YXR1cy4K
Pj4gKyAgICAgICAgKgo+PiArICAgICAgICAqIFdlIGRvbid0IHNldCB0aGUgTkVFRFNfUkVTRVQg
ZmxhZyBmb3IgRVZFTlRfUkVTRVQKPj4gKyAgICAgICAgKiBiZWNhdXNlIHdlJ3JlIGxpa2VseSBn
b2luZyB0aHJvdWdoIGEgcmVjb3Zlcnkgb3IKPj4gKyAgICAgICAgKiBmd191cGRhdGUgYW5kIHdp
bGwgYmUgYmFjayB1cCBhbmQgcnVubmluZyBzb29uLgo+PiArICAgICAgICAqLwo+PiArICAgICAg
IGlmIChlY29kZSA9PSBQRFNfRVZFTlRfUkVTRVQgfHwgZWNvZGUgPT0gUERTX0VWRU5UX0xJTktf
Q0hBTkdFKSB7Cj4gCj4gVGhlIGNvZGUgaGVyZSBzZWVtcyB0byBjb25mbGljdCB3aXRoIHRoZSBj
b21tZW50IGFib3ZlLiBJZiB3ZSBkb24ndAo+IHNldCBORUVEU19SRVNFVCwgdGhlcmUncyBubyBu
ZWVkIGZvciB0aGUgY29uZmlnIGNhbGxiYWNrPwoKWWVzLCB0aGF0J3MgYW4gb3V0LW9mLWRhdGUg
Y29tbWVudCB0aGF0IHNob3VsZCBiZSByZW1vdmVkLiAgSSB0aGluayB3ZSAKcmVhbGx5IGp1c3Qg
bmVlZCB0byBwYXNzIHVwIHRoZSBzdGFjayB0aGUgaGludCB0aGF0IHNvbWV0aGluZyAKaW50ZXJl
c3RpbmcgbWF5IGhhdmUgaGFwcGVuZWQgYW5kIGxldCB0aGUgdXBwZXIgbGF5ZXJzIGRlY2lkZSB3
aGF0IHRoZXkgCndhbnQgdG8gZG8gd2l0aCB3aGF0ZXZlciBpbmZvIHRoZXkgaGF2ZSBhdmFpbGFi
bGUuCgpJJ2xsIGNsZWFuIHVwIHRoaXMgY29tbWVudCBibG9jay4KCnNsbgoKCj4gCj4gVGhhbmtz
Cj4gCj4+ICsgICAgICAgICAgICAgICBpZiAocGRzdi0+Y29uZmlnX2NiLmNhbGxiYWNrKQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBwZHN2LT5jb25maWdfY2IuY2FsbGJhY2socGRzdi0+Y29u
ZmlnX2NiLnByaXZhdGUpOwo+PiArICAgICAgIH0KPj4gKwo+PiArICAgICAgIHJldHVybiAwOwo+
PiArfQo+PiArCj4+ICtzdGF0aWMgaW50IHBkc192ZHBhX3JlZ2lzdGVyX2V2ZW50X2hhbmRsZXIo
c3RydWN0IHBkc192ZHBhX2RldmljZSAqcGRzdikKPj4gK3sKPj4gKyAgICAgICBzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmcGRzdi0+dmRwYV9hdXgtPnBhZGV2LT5hdXhfZGV2LmRldjsKPj4gKyAgICAg
ICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iID0gJnBkc3YtPm5iOwo+PiArICAgICAgIGludCBl
cnI7Cj4+ICsKPj4gKyAgICAgICBpZiAoIW5iLT5ub3RpZmllcl9jYWxsKSB7Cj4+ICsgICAgICAg
ICAgICAgICBuYi0+bm90aWZpZXJfY2FsbCA9IHBkc192ZHBhX25vdGlmeV9oYW5kbGVyOwo+PiAr
ICAgICAgICAgICAgICAgZXJyID0gcGRzY19yZWdpc3Rlcl9ub3RpZnkobmIpOwo+PiArICAgICAg
ICAgICAgICAgaWYgKGVycikgewo+PiArICAgICAgICAgICAgICAgICAgICAgICBuYi0+bm90aWZp
ZXJfY2FsbCA9IE5VTEw7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAi
ZmFpbGVkIHRvIHJlZ2lzdGVyIHBkcyBldmVudCBoYW5kbGVyOiAlcHNcbiIsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRVJSX1BUUihlcnIpKTsKPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsgICAgICAgICAgICAgICB9Cj4+ICsgICAgICAg
ICAgICAgICBkZXZfZGJnKGRldiwgInBkcyBldmVudCBoYW5kbGVyIHJlZ2lzdGVyZWRcbiIpOwo+
PiArICAgICAgIH0KPj4gKwo+PiArICAgICAgIHJldHVybiAwOwo+PiArfQo+PiArCj4+ICtzdGF0
aWMgdm9pZCBwZHNfdmRwYV91bnJlZ2lzdGVyX2V2ZW50X2hhbmRsZXIoc3RydWN0IHBkc192ZHBh
X2RldmljZSAqcGRzdikKPj4gK3sKPj4gKyAgICAgICBpZiAocGRzdi0+bmIubm90aWZpZXJfY2Fs
bCkgewo+PiArICAgICAgICAgICAgICAgcGRzY191bnJlZ2lzdGVyX25vdGlmeSgmcGRzdi0+bmIp
Owo+PiArICAgICAgICAgICAgICAgcGRzdi0+bmIubm90aWZpZXJfY2FsbCA9IE5VTEw7Cj4+ICsg
ICAgICAgfQo+PiArfQo+PiArCj4+ICAgc3RhdGljIGludCBwZHNfdmRwYV9zZXRfdnFfYWRkcmVz
cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1MTYgcWlkLAo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1NjQgZGVzY19hZGRyLCB1NjQgZHJpdmVyX2FkZHIsIHU2
NCBkZXZpY2VfYWRkcikKPj4gICB7Cj4+IEBAIC01MjIsNiArNTc3LDEyIEBAIHN0YXRpYyBpbnQg
cGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAq
bmFtZSwKPj4KPj4gICAgICAgICAgcGRzdi0+dmRwYV9kZXYubWRldiA9ICZ2ZHBhX2F1eC0+dmRw
YV9tZGV2Owo+Pgo+PiArICAgICAgIGVyciA9IHBkc192ZHBhX3JlZ2lzdGVyX2V2ZW50X2hhbmRs
ZXIocGRzdik7Cj4+ICsgICAgICAgaWYgKGVycikgewo+PiArICAgICAgICAgICAgICAgZGV2X2Vy
cihkZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgZm9yIFBEUyBldmVudHM6ICVwZVxuIiwgRVJSX1BU
UihlcnIpKTsKPj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3VubWFwOwo+PiArICAgICAgIH0K
Pj4gKwo+PiAgICAgICAgICAvKiBXZSB1c2UgdGhlIF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpIGNh
bGwgcmF0aGVyIHRoYW4gdGhlCj4+ICAgICAgICAgICAqIHZkcGFfcmVnaXN0ZXJfZGV2aWNlKCkg
dG8gYXZvaWQgYSBkZWFkbG9jayBiZWNhdXNlIG91cgo+PiAgICAgICAgICAgKiBkZXZfYWRkKCkg
aXMgY2FsbGVkIHdpdGggdGhlIHZkcGFfZGV2X2xvY2sgYWxyZWFkeSBzZXQKPj4gQEAgLTUzMCwx
MyArNTkxLDE1IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210
X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPj4gICAgICAgICAgZXJyID0gX3ZkcGFfcmVn
aXN0ZXJfZGV2aWNlKCZwZHN2LT52ZHBhX2RldiwgcGRzdi0+bnVtX3Zxcyk7Cj4+ICAgICAgICAg
IGlmIChlcnIpIHsKPj4gICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBy
ZWdpc3RlciB0byB2RFBBIGJ1czogJXBlXG4iLCBFUlJfUFRSKGVycikpOwo+PiAtICAgICAgICAg
ICAgICAgZ290byBlcnJfdW5tYXA7Cj4+ICsgICAgICAgICAgICAgICBnb3RvIGVycl91bmV2ZW50
Owo+PiAgICAgICAgICB9Cj4+Cj4+ICAgICAgICAgIHBkc192ZHBhX2RlYnVnZnNfYWRkX3ZkcGFk
ZXYodmRwYV9hdXgpOwo+Pgo+PiAgICAgICAgICByZXR1cm4gMDsKPj4KPj4gK2Vycl91bmV2ZW50
Ogo+PiArICAgICAgIHBkc192ZHBhX3VucmVnaXN0ZXJfZXZlbnRfaGFuZGxlcihwZHN2KTsKPj4g
ICBlcnJfdW5tYXA6Cj4+ICAgICAgICAgIHB1dF9kZXZpY2UoJnBkc3YtPnZkcGFfZGV2LmRldik7
Cj4+ICAgICAgICAgIHZkcGFfYXV4LT5wZHN2ID0gTlVMTDsKPj4gQEAgLTU0Niw4ICs2MDksMTEg
QEAgc3RhdGljIGludCBwZHNfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2
LCBjb25zdCBjaGFyICpuYW1lLAo+PiAgIHN0YXRpYyB2b2lkIHBkc192ZHBhX2Rldl9kZWwoc3Ry
dWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+ICAgewo+PiArICAgICAgIHN0cnVjdCBw
ZHNfdmRwYV9kZXZpY2UgKnBkc3YgPSB2ZHBhX3RvX3Bkc3YodmRwYV9kZXYpOwo+PiAgICAgICAg
ICBzdHJ1Y3QgcGRzX3ZkcGFfYXV4ICp2ZHBhX2F1eDsKPj4KPj4gKyAgICAgICBwZHNfdmRwYV91
bnJlZ2lzdGVyX2V2ZW50X2hhbmRsZXIocGRzdik7Cj4+ICsKPj4gICAgICAgICAgdmRwYV9hdXgg
PSBjb250YWluZXJfb2YobWRldiwgc3RydWN0IHBkc192ZHBhX2F1eCwgdmRwYV9tZGV2KTsKPj4g
ICAgICAgICAgX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UodmRwYV9kZXYpOwo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5oIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBh
X2Rldi5oCj4+IGluZGV4IGEyMTU5NmY0MzhjMS4uMTY1MGEyYjA4ODQ1IDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPj4gKysrIGIvZHJpdmVycy92ZHBhL3Bkcy92
ZHBhX2Rldi5oCj4+IEBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBwZHNfdmRwYV9kZXZpY2Ugewo+
PiAgICAgICAgICB1OCB2ZHBhX2luZGV4OyAgICAgICAgICAgICAgICAgIC8qIHJzdmQgZm9yIGZ1
dHVyZSBzdWJkZXZpY2UgdXNlICovCj4+ICAgICAgICAgIHU4IG51bV92cXM7ICAgICAgICAgICAg
ICAgICAgICAgLyogbnVtIHZxcyBpbiB1c2UgKi8KPj4gICAgICAgICAgc3RydWN0IHZkcGFfY2Fs
bGJhY2sgY29uZmlnX2NiOwo+PiArICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsKPj4g
ICB9Owo+Pgo+PiAgIGludCBwZHNfdmRwYV9nZXRfbWdtdF9pbmZvKHN0cnVjdCBwZHNfdmRwYV9h
dXggKnZkcGFfYXV4KTsKPj4gLS0KPj4gMi4xNy4xCj4+Cj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
