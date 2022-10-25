Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61183C38A2D
	for <virtualization@archiver.kernel.org>; Tue, 25 Oct 2022 20:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D333780DC0;
	Tue, 25 Oct 2022 20:17:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D333780DC0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=fsRSaIvu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXEDaGYq9kmb; Tue, 25 Oct 2022 20:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3294580DCB;
	Tue, 25 Oct 2022 20:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3294580DCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B052C0032;
	Tue, 25 Oct 2022 20:17:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12EA4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 20:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB00160AEB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 20:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB00160AEB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=fsRSaIvu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTbaETpihZvE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 20:17:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 059EF60A9C
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 059EF60A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 20:17:14 +0000 (UTC)
Received: from 104.47.18.110_.trendmicro.com (unknown [172.21.183.236])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 532DC1000045B;
 Tue, 25 Oct 2022 20:17:12 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666729031.903000
X-TM-MAIL-UUID: 1dfe0b24-d994-4181-b532-379ac5202046
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.110])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 DCBFA10002512; Tue, 25 Oct 2022 20:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev2ptuh7u0c6U8JrksxTzIWO6GlaRAeISuPdr8NyDOd/GM/O0XPM2IuOevNDfYz3tWh7T5zSpZjY8VbN9idKuav6lMUKKPqgX2ZZqTPV3DlA0NATKpKj0uDQ6YhizHjxrv9+QWGeWFQlSbdq+zg51oDJdi/BmUBFPRRq9nwz3g9O5g+V/p22V0E0p45iZ6Zg71uYaaxneD76K2vfrkPU/o6a/fV6SEYtCkUgZlri01E0wcdn9EaqWcPs/JjNLULuovA9y63txsu0ocj9AgFalRnuila+N90ynxJ9ZT0KG7kp8TalDA7JkHuERiYYAGRC8PmMQT2D4Y2qQihhvgw/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOjT/m3KaiDExxchJhnwCUpr+UXF3YX8ZuGxRObWEyY=;
 b=UGUeyvw0/89CibxM2/6ZUDSZCJMMh8o6/OnhYB1le/Zolt6ra3EmWqmWovDV0vY2irj0fm8Ve/FdPy47//Hip85rJfRDzrbOfKEm0mUVjkuH9ABwaj85MmdVpJ3g/j7pRJ6bFDLXT5VMZLZeaqiiybat6+fqpFTsuF66GlgWc7+rdidhJwn+crCMJJsdfc9cZlewgCIJCLBd8QEd1wD4U4FoRkPuTRFwjGvTSGSE1xJcHZeV4XpOgW1ezGC8M0H05UGqoXA9IDAVfalkH/TqxknczX6sDKYCNTll1815YsKkRbckSE6at8OPHbndukE8ilEbRVfQ5k9lG3cV98fUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a0ea56ee-8cf4-c1ef-de15-1bbdb0340da6@opensynergy.com>
Date: Tue, 25 Oct 2022 22:17:09 +0200
Subject: Re: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
 <CABBYNZKc7Y8JJ-J9+yUvnDTeVwYuqmzEZYpvfzvN0ctKGyj-Ow@mail.gmail.com>
From: Igor Skalkin <igor.skalkin@opensynergy.com>
In-Reply-To: <CABBYNZKc7Y8JJ-J9+yUvnDTeVwYuqmzEZYpvfzvN0ctKGyj-Ow@mail.gmail.com>
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To AM0PR04MB6641.eurprd04.prod.outlook.com
 (2603:10a6:208:177::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6641:EE_|PA4PR04MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: cae922c3-2d31-415c-4ba9-08dab6c5e593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlcwPqEDrbfgBneo1UFWeolhfRoEyeFiL07KitM95T51f7ie+MlujzKNHPM6MPeMosPTGztP6l4zvVbIlKFLv0qtA7u5Cyx5fCRVL7O/zJ0SYaV6J0VXZ7p9EpLSsgH4hwTPtn4K6vSUa0fUHumaAgqxkaZnuNDj/0ZmTFM3FIN0mDvEPXrQkonMFbkXbP8bW3RnNhndOlhjwqRXg/NOI516KXMWcX7XyRX6cfUZMLcJqa7sJbdNnW9uzhyP7ZEjLUn3GaAVvIleEJO16YLlhbDpOYOqT+6VjsfSIaa7Z1JBNHChQ7FOJjzf/0yEZuOUhEV2mwX8Iw3O3JkmfdlRu9uPruYRTLES3a6qLy9jbH1SaWWDc19m9V0T2lF7t7BbYV1sZhL9Uitd/q4wLEbW20CKHult8zbWFxehq8KlwIPkEZdd/gl1LltoXbpyf061juDQDhN3W2ILPU3kcRvYzWuVdkt202bfPOqi3qLgTxbE/NIi3AOtCc2p7KI5OZo1OZ6TBggSm/XIznWV2LLuvBHqRIMcURBZvmG4FhCoNcB6EILw3QHL+gWi5cRzII/iEyVTl7lWxY9KcyUU5unoro0SbnBsVsfn37xBvQACGb/22oIeGfTQN4Li8cNbxMxy3d2E10RoR3gumcjO8pSAFhjZEd/LrBA+Gwp7XjitH7O5E6KQEC1T1FYfWmNacUD8KF8Naxs4Q3OLO3sQ11BTBjGkMioNXLEpBhn47HpcWVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6641.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199015)(36756003)(31696002)(38100700002)(66946007)(86362001)(66556008)(66476007)(8676002)(4326008)(316002)(6916009)(42186006)(44832011)(2616005)(2906002)(41300700001)(5660300002)(8936002)(186003)(83380400001)(478600001)(966005)(53546011)(31686004)(66899015);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFp4Rm5nY0VzN3lPMXVrR3FLUWZ1U054OVNaYVM5aUNTaldEendTVGdDSC9G?=
 =?utf-8?B?Y1N5NmkyOGRKVW9RdVQ4RzBCVDkvWHd2QzdUTkhMcCtpTnlnTEZtbFlxWVVE?=
 =?utf-8?B?SnlDYVpjQ0R5RDc1S3BQWFcvdkcxNjArdG04WUR3d0Y0T0tWSmh4dFBLaHVF?=
 =?utf-8?B?Um9LYXNlWHgxWVZESjBQY3hwU1RtU3pUdUU1MXo3QjhGOUNhRmtWQ281NUNt?=
 =?utf-8?B?Z0g4OU03cGQyNGtYTEE5QVMzZ0dkMStTenVHVXJyS2tqTko5V1FYelRZSmp3?=
 =?utf-8?B?ZThQdDEraklYM25yUWRiSUxUSnkwN3d1TkpRYlFObUVCU1BHV0FjSGJwZ3Ev?=
 =?utf-8?B?NTFDREdKakpBd2R0d1VEQ2p0WDZSOGtHc0NNNGhXVHVxZFU1UDU0MDFmaUxw?=
 =?utf-8?B?UUgrTWxyMFI0VXMxNUwzYksrWHhRSWR0a3ZjQm1XYmtOOUpoeHZFa2cybTd4?=
 =?utf-8?B?L0ZlLzJ6NWt4aFp6MEFhZ0hCWWduNlNuUGRCOXRSZmtUSHFSNWZkRFpYMTBO?=
 =?utf-8?B?M2VrcWVaMWUzdkRweVllc3FrNnJ0Z3lxZElaQTlvNmR3SE5DVUJkUjl2ZzlK?=
 =?utf-8?B?MkV5c1RZRGkzM1JSS21xZkQ4NnE3KzNVRHgwcGg2eE0xZmR6a3FVZzNsN01V?=
 =?utf-8?B?bWtPWFZ2VUMzeDVldGFLTGFwUy8zbHBpTktQL3cvM2x0VmtIY1V2ZitQa2Uy?=
 =?utf-8?B?a2Zja3krZWZuNi9nd3phdm5tbS9uS2xYTFNxU0YwOXNpQmx5Y1podlIwTGo2?=
 =?utf-8?B?NHczSDhxa1Rocnp5VGZxdzFXaHpadnpmbkpzcjFBc2I5MWU2WE5TWkJPazls?=
 =?utf-8?B?eU9GcTgzYmVmdFp4WWlReWdLYmYvaGV4MVlZZHdPUXlVbiswREx0OG9XR3FQ?=
 =?utf-8?B?NkUzTy9mREE5VFJmelROREhzcldTY2kwZGNSOHlNRUVmaUpoUDRNV1lhY3hV?=
 =?utf-8?B?dWQzTkdZUFlpL3Mxa2c4TWRIcTlrNFJxcHh5emkzejhyRzB1YnRoMEsvQVN4?=
 =?utf-8?B?SjA1dzJLQnVkQXRMTDdrcmVYUlYvd0FlVTRHQWxoRzBkSEVlVzd4NVpZYWZI?=
 =?utf-8?B?S0ZtS2tkYW1uYUQrbXlubjhuRm9OSVJSSFd4dHNIOEJuekZUWXpJRjE0cWVh?=
 =?utf-8?B?MEtZYm05TzZTTEpVbytvTjZxTk9vcEk1clg2NHNicnFxcVRrbmhHTGJJV2Rv?=
 =?utf-8?B?emNXc1g2N0s0YXc5TkpLb2NMUEN1UTVUekxWUzlHVlF5TUdrZ1J4eXN5Qk5k?=
 =?utf-8?B?NnRlQm5kVWhyc2JtTjB6a2hHV0sxVEpyWnREdFJ5QUQ5SkFPSUtCdTRGOTJG?=
 =?utf-8?B?ZkhSNXlMUVlLUk4rd0tiWi84Y0FpRHVpOHVTQ1c2cGV2T2tKTTQ1UkZhTU5W?=
 =?utf-8?B?ekZTaW9RY2Q0SFN6bVU3dG5oMTlybEUzdG9JblFLNU90ekJac2hxMnhwU05D?=
 =?utf-8?B?K2pKNFZhVmNtaUNtSmRUR2ZpOVMwUmJwc2I2VU1sUFBtdUhVL1BXclNqTGtT?=
 =?utf-8?B?dStIQVVRQUp0UU9meHZTYk5GZVU0cUc2TWhzd2lRVVNWSDVDWnU2ckxpeHJ1?=
 =?utf-8?B?QTNvbEtFT3ZkamJkTG1pNFZDYnp1THM0VkIrcUVoTmV4RDhaN2JhaGZNSy9N?=
 =?utf-8?B?WDE3UlpYZnFpT01VTDRtempOemRFYnhGOHlYcDBnUzlxdEIyeUgvbmxaRWps?=
 =?utf-8?B?TTdpOWdaT2c1QzFYS3piSzg3NlAwUURJMlZyU0ttQ0VBQUdmaWJuRUFteE5j?=
 =?utf-8?B?ZHdQVVF4cmMzSXpaZlVvKzMxUXk1V3V4RDNudWNJSk9uRHhHbmY0ZVd5ODda?=
 =?utf-8?B?NUV1ZGw2MGpCdVl3aE9SbW5jdTJhazY1VnB0Q2I0LzNqS0pnNlNYMmx3ZCtF?=
 =?utf-8?B?TXYvcGkzWmRQZUFKZDljbmNDZ2Y0dTZFdjVvcFc4OE9jR0tMSUwyMmF0aFlD?=
 =?utf-8?B?MUl5dmdWL0F5WC9sYjR1TWYxTXhSL0NyYXlpcEtTS21CRlR4MDBsV2dOSXB5?=
 =?utf-8?B?SGNBT2F0WjJmclgxS2JXNnhtVDJlbk9KTnpaUWJSczBabkhKUzIrUzlocSt0?=
 =?utf-8?B?bzBaaERSdmVQRk04ZFNwSkZUR2M4aXZIalZJOXJ2MHRMNHErSmRSWWo5N2Z1?=
 =?utf-8?B?d1dtcG1XT0Fad3E1K1BKK0lqZjF2ekRneXdxNmI5RnlRRTZvdlZJMkROdWR5?=
 =?utf-8?Q?ByJjx0cC2C1WIUg0YP4TkizZebsCHEbKKYklMKPRhZ0E?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae922c3-2d31-415c-4ba9-08dab6c5e593
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6641.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 20:17:10.3732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RueHDNMixUGG6IgtooBu1mf2teyYK/o3FwcW2azL6xWTSOZ/gw082qyQ80amk2niBa+Yg+SVEcbIJzEKgmRo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7742
X-TM-AS-ERS: 104.47.18.110-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27224.002
X-TMASE-Result: 10--18.219500-4.000000
X-TMASE-MatchedRID: oHOSwQSJZWh5iFRzqt4l+C3U1yAFvRbw9mojSc/N3QdlEv6AItKWF/mv
 83Rzid1pHwaC0OsnVytLwDFQTTd3sMdXEHMj/oHjqhcdnP91eXEpA2ExuipmWqVfGakJxiJGhEz
 I3+mkzidvR+YJYdGScaHjmsO8FyT23PhwfmFb3phO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BBCZ0
 qjK1OhEvryp24JbYmcEPtYP+fpD6h0IEJuFpC6iB1kSRHxj+Z5/dTLQZMynhE/gf7afIrQUzHHV
 tJYAG7sN4f3qFHZ5FNGW3eWJeW/alsDqU4jjtomU/ccXDOqfBohBMJtJ3C24mvlGb+24NaZINgI
 pAA8LuM4ArZWy9JAYH/oUxY9lQ9DhXfRkPtcD+Wqh5pv1eDPz0GtB3u6sQ3KpE2w9zC3gPgjL8W
 DWZGeog5Fd3u9jwovgnCuIVtovySLNCjacuFsFZ4CIKY/Hg3AWQy9YC5qGvzKU1cWyI3gWn+NTa
 IMjjw/IAcCikR3vq+0bLzW7NJ67b51dzQ0YJf3WEQFR1jCBFSQ83TMBes+iTrWI4X+Wf7W
X-TMASE-XGENCLOUD: cf0af914-cca5-46bb-8eb0-3d64de80d47e-0-0-200-0
X-TM-Deliver-Signature: 6CFE7CB694A28CC9347557B8160657A5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1666729032;
 bh=AhZYqgoq3h/HY1wPs75NKngCVaKcTSFxWvHBhT9JZAc=; l=6104;
 h=Date:To:From;
 b=fsRSaIvuNClSpynZWVLmMRkf1050NsWJNBmfJ6XzMA3goFMSZMOa+6bbTviGAEVT6
 FUYWPlDwbTsZ2mYFbomIkLwkzud9NIpesBhg4Jdr60sRcFff+9BEKxXGX4QZOLL/NU
 0yhQMDGtAvUf3G4c2TVeIOUTuCOseTStGIaUjzDiXIg+/TrXF9JIMTvmUg6AMJ/jLW
 q+47/pP89b3Vi/wxNwfK5N/m8r2ua6Ai0Kc+ZVX89ypGvgFe8z3bg3yVd8TMcvXjq/
 IoDcbFL9HwURVPT1/RZdfKEIkohoe9jzqxnd98OvGvX2vz9tYNzInMa9Waml5j26rH
 HZkMDuP9wAyYA==
Cc: johan.hedberg@gmail.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgTHVpeiBBdWd1c3RvLAoKT24gMTAvMjQvMjIgMjI6NTQsIEx1aXogQXVndXN0byB2b24gRGVu
dHogd3JvdGU6Cj4gSGkgSWdvciwKPiAKPiBPbiBNb24sIE9jdCAyNCwgMjAyMiBhdCA2OjQxIEFN
IElnb3IgU2thbGtpbgo+IDxJZ29yLlNrYWxraW5Ab3BlbnN5bmVyZ3kuY29tPiB3cm90ZToKPj4K
Pj4gVGhlIGN1cnJlbnQgdmVyc2lvbiBvZiB0aGUgY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUgaGFz
IHVuYWxpZ25lZAo+PiAxNi1iaXQgZmllbGRzLCBidXQgYWNjb3JkaW5nIHRvIHRoZSBzcGVjaWZp
Y2F0aW9uIFsxXSwgYWNjZXNzIHRvCj4+IHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIG11c3QgYmUg
YWxpZ25lZC4KPj4KPj4gQWRkIGEgc2Vjb25kLCBhbGlnbmVkICB2ZXJzaW9uIG9mIHRoZSBjb25m
aWd1cmF0aW9uIHN0cnVjdHVyZQo+PiBhbmQgYSBuZXcgZmVhdHVyZSBiaXQgaW5kaWNhdGluZyB0
aGF0IHRoaXMgdmVyc2lvbiBpcyBiZWluZyB1c2VkLgo+Pgo+PiBbMV0gaHR0cHM6Ly9kZGVjMS0w
LWVuLWN0cC50cmVuZG1pY3JvLmNvbTo0NDMvd2lzL2NsaWNrdGltZS92MS9xdWVyeT91cmw9aHR0
cHMlM2ElMmYlMmZkb2NzLm9hc2lzJTJkb3Blbi5vcmclMmZ2aXJ0aW8lMmZ2aXJ0aW8lMmZ2MS4x
JTJmdmlydGlvJTJkdjEuMS5wZGYmdW1pZD1kYjM0ODJiYy01Yjg0LTRiZGUtYmJiMC00MWQ4Mzc5
NTVhN2EmYXV0aD01M2M3YzdkZTI4YjkyZGZkOTZlOTNkOWRkNjFhMjNlNjM0ZDJmYmVjLWQyN2E5
ZDRjMmM5NzFmOWVjYzVkMDBkNDBkNWNkOWI0NWM0YjVmNjMKPj4KPj4gU2lnbmVkLW9mZi1ieTog
SWdvciBTa2Fsa2luIDxJZ29yLlNrYWxraW5Ab3BlbnN5bmVyZ3kuY29tPgo+PiAtLS0KPj4gIGRy
aXZlcnMvYmx1ZXRvb3RoL3ZpcnRpb19idC5jICB8IDE2ICsrKysrKysrKysrKystLS0KPj4gIGlu
Y2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYnQuaCB8ICA4ICsrKysrKysrCj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2JsdWV0b290aC92aXJ0aW9fYnQuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL3ZpcnRp
b19idC5jCj4+IGluZGV4IDY3YzIxMjYzZjllMC4uMzVmODA0MTcyMmM4IDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2JsdWV0b290aC92aXJ0aW9fYnQuYwo+PiArKysgYi9kcml2ZXJzL2JsdWV0b290
aC92aXJ0aW9fYnQuYwo+PiBAQCAtMzA2LDcgKzMwNiwxMiBAQCBzdGF0aWMgaW50IHZpcnRidF9w
cm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4gICAgICAgICBpZiAodmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19CVF9GX1ZORF9IQ0kpKSB7Cj4+ICAgICAgICAgICAgICAg
ICBfX3UxNiB2ZW5kb3I7Cj4+Cj4+IC0gICAgICAgICAgICAgICB2aXJ0aW9fY3JlYWQodmRldiwg
c3RydWN0IHZpcnRpb19idF9jb25maWcsIHZlbmRvciwgJnZlbmRvcik7Cj4+ICsgICAgICAgICAg
ICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19CVF9GX0NPTkZJR19WMikp
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpb19jcmVhZCh2ZGV2LCBzdHJ1Y3Qgdmly
dGlvX2J0X2NvbmZpZ192MiwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZlbmRvciwgJnZlbmRvcik7Cj4+ICsgICAgICAgICAgICAgICBlbHNlCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHZpcnRpb19jcmVhZCh2ZGV2LCBzdHJ1Y3QgdmlydGlvX2J0X2NvbmZpZywK
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZlbmRvciwgJnZlbmRvcik7
Cj4+Cj4+ICAgICAgICAgICAgICAgICBzd2l0Y2ggKHZlbmRvcikgewo+PiAgICAgICAgICAgICAg
ICAgY2FzZSBWSVJUSU9fQlRfQ09ORklHX1ZFTkRPUl9aRVBIWVI6Cj4+IEBAIC0zMzksOCArMzQ0
LDEyIEBAIHN0YXRpYyBpbnQgdmlydGJ0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+PiAgICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0JUX0ZfTVNG
VF9FWFQpKSB7Cj4+ICAgICAgICAgICAgICAgICBfX3UxNiBtc2Z0X29wY29kZTsKPj4KPj4gLSAg
ICAgICAgICAgICAgIHZpcnRpb19jcmVhZCh2ZGV2LCBzdHJ1Y3QgdmlydGlvX2J0X2NvbmZpZywK
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2Z0X29wY29kZSwgJm1zZnRfb3Bjb2Rl
KTsKPj4gKyAgICAgICAgICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X0JUX0ZfQ09ORklHX1YyKSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgdmlydGlvX2NyZWFk
KHZkZXYsIHN0cnVjdCB2aXJ0aW9fYnRfY29uZmlnX3YyLAo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbXNmdF9vcGNvZGUsICZtc2Z0X29wY29kZSk7Cj4+ICsgICAgICAg
ICAgICAgICBlbHNlCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpb19jcmVhZCh2ZGV2
LCBzdHJ1Y3QgdmlydGlvX2J0X2NvbmZpZywKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zZnRfb3Bjb2RlLCAmbXNmdF9vcGNvZGUpOwo+Pgo+PiAgICAgICAgICAgICAg
ICAgaGNpX3NldF9tc2Z0X29wY29kZShoZGV2LCBtc2Z0X29wY29kZSk7Cj4+ICAgICAgICAgfQo+
PiBAQCAtMzg3LDYgKzM5Niw3IEBAIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgdmlydGJ0X2Zl
YXR1cmVzW10gPSB7Cj4+ICAgICAgICAgVklSVElPX0JUX0ZfVk5EX0hDSSwKPj4gICAgICAgICBW
SVJUSU9fQlRfRl9NU0ZUX0VYVCwKPj4gICAgICAgICBWSVJUSU9fQlRfRl9BT1NQX0VYVCwKPj4g
KyAgICAgICBWSVJUSU9fQlRfRl9DT05GSUdfVjIsCj4+ICB9Owo+IAo+IFNvIHRoaXMgaW50cm9k
dWNlcyBhIG5ldyBmbGFnIHdoaWNoIG11c3QgYmUgY2hlY2tlZCB3aGVuIGF0dGVtcHRpbmcgdG8K
PiBjb25maWcsIHJpZ2h0PyBCdXQgaXMgdGhpcyBiYWNrd2FyZCBjb21wYXRpYmxlPyBXaGF0IGhh
cHBlbnMgaWYgZm9yCj4gc29tZSByZWFzb24gdGhlIHVzZXJzcGFjZSBkb2Vzbid0IHVzZSB0aGUg
bmV3IHN0cnVjdCBhcmUgd2UgYWJsZSB0bwo+IGRldGVjdCB0aGF0PwoKWWVzLCBpdCdzIGJhY2t3
YXJkcyBjb21wYXRpYmxlLgoKW3FdRWFjaCB2aXJ0aW8gZGV2aWNlIG9mZmVycyBhbGwgdGhlIGZl
YXR1cmVzIGl0IHVuZGVyc3RhbmRzLiBEdXJpbmcKZGV2aWNlIGluaXRpYWxpemF0aW9uLCB0aGUg
ZHJpdmVyIHJlYWRzIHRoaXMgYW5kIHRlbGxzIHRoZSBkZXZpY2UgdGhlCnN1YnNldCB0aGF0IGl0
IGFjY2VwdHMuIFRoZSBvbmx5IHdheSB0byByZW5lZ290aWF0ZSBpcyB0byByZXNldCB0aGUgZGV2
aWNlLgpUaGlzIGFsbG93cyBmb3IgZm9yd2FyZHMgYW5kIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5
OiBpZiB0aGUgZGV2aWNlIGlzCmVuaGFuY2VkIHdpdGggYSBuZXcgZmVhdHVyZSBiaXQsIG9sZGVy
IGRyaXZlcnMgd2lsbCBub3Qgd3JpdGUgdGhhdApmZWF0dXJlIGJpdCBiYWNrIHRvIHRoZSBkZXZp
Y2UuIFNpbWlsYXJseSwgaWYgYSBkcml2ZXIgaXMgZW5oYW5jZWQgd2l0aAphIGZlYXR1cmUgdGhh
dCB0aGUgZGV2aWNlIGRvZXNu4oCZdCBzdXBwb3J0LCBpdCBzZWUgdGhlIG5ldyBmZWF0dXJlIGlz
IG5vdApvZmZlcmVkLlsvcV0KClNvLCBpbiBvdXIgY2FzZToKCm9sZCBkZXZpY2UgLSBuZXcgZHJp
dmVyOgpUaGUgZGV2aWNlIGRvZXMgbm90IG9mZmVyIFZJUlRJT19CVF9GX0NPTkZJR19WMiBmZWF0
dXJlIGFuZCB1c2VzIHRoZSBvbGQKY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUuClRoZSBkcml2ZXIg
YWxzbyB1c2VzIHRoZSBvbGQgY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUgYmVjYXVzZQpWSVJUSU9f
QlRfRl9DT05GSUdfVjIgYml0IHdhcyBub3QgbmVnb3RpYXRlZC4KCm5ldyBkZXZpY2UgLSBvbGQg
ZHJpdmVyOgpUaGUgZGV2aWNlIG9mZmVycyB0aGlzIGJpdCwgdGhlIGRyaXZlciByZWFkcyBpdCBi
dXQgY2Fubm90IHN1cHBvcnQgaXQsCnNvIGl0IGRvZXMgbm90IHdyaXRlIHRoaXMgYml0IGJhY2sg
dG8gdGhlIGRldmljZSBkdXJpbmcgZmVhdHVyZSBuZWdvdGlhdGlvbi4KVGhlIGRldmljZSB2ZXJp
ZmllcyB0aGF0IHRoaXMgYml0IGlzIG5vdCBuZWdvdGlhdGVkIGFuZCBjb250aW51ZXMgdG8gdXNl
CnRoZSBvbGQgY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUuCgoKSSB0ZXN0ZWQgdGhpcyBwYXRjaCwg
aXQKYSkgd29ya3MgZmluZSB3aXRoIGEgbmV3IGRldmljZSB0aGF0IHN1cHBvcnRzIFZJUlRJT19C
VF9GX0NPTkZJR19WMi4KYikgdXNlcyB0aGUgb2xkIGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlIHdo
ZW4gd29ya2luZyB3aXRoIGFuIG9sZCBkZXZpY2UuCiAgIE91ciBkZXZpY2UgZG9lcyBub3Qgb2Zm
ZXIgdGhlIFZJUlRJT19CVF9GX1ZORF9IQ0kgZmVhdHVyZSBiaXQsIHNvIHRoZQpkcml2ZXIgZG9l
cyBub3QgdHJpZXMgdG8gcmVhZCB1bmFsaWduZWQgInZlbmRvciIgYW5kICJtc2Z0X29wY29kZSIK
ZmllbGRzIGFuZCBldmVyeXRoaW5nIGlzIGZpbmUuCkJ1dCwgaWYgdGhlIFZJUlRJT19CVF9GX1ZO
RF9IQ0kgZmVhdHVyZSBpcyBzZXQgZm9yIHRoZSBkZXZpY2UgZm9yIHRlc3QKcHVycG9zZXMsIG91
ciBtaWRkbGUgbGF5ZXIgYXNzZXJ0cyB1bmFsaWduZWQgYWNjZXNzZXMgdG8gdGhlCmNvbmZpZ3Vy
YXRpb24gc3BhY2UuCgpQLlMuIEJ1dCwgYXMgTWljaGFlbCBTLiBUc2lya2luIHJpZ2h0bHkgc3Rh
dGVkLCBbcV1XaWxsIGEgc3BlYyBwYXRjaCBiZQpmb3J0aGNvbWluZz9bL3FdLCB0aGlzIHBhdGNo
IHJlcXVpcmVzIGEgc3BlY2lmaWNhdGlvbiB1cGRhdGUuCkkgY291bGQgbm90IGZpbmQgYW55IHZp
cnRpb19idCBzcGVjaWZpY2F0aW9uLCBkbyB5b3UgaGF2ZSBvbmU/ClRoYXQgd291bGQgYmUgZ3Jl
YXQuIE90aGVyd2lzZSwgd291bGQgeW91IG1pbmQgaWYgSSB0cnkgdG8gd3JpdGUgc29tZQppbml0
aWFsIGRyYWZ0Pwo+PiAgc3RhdGljIHN0cnVjdCB2aXJ0aW9fZHJpdmVyIHZpcnRidF9kcml2ZXIg
PSB7Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2J0LmggYi9pbmNs
dWRlL3VhcGkvbGludXgvdmlydGlvX2J0LmgKPj4gaW5kZXggYTdiZDQ4ZGFhOWE5Li5hZjc5OGY0
Yzk2ODAgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYnQuaAo+PiAr
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2J0LmgKPj4gQEAgLTksNiArOSw3IEBACj4+
ICAjZGVmaW5lIFZJUlRJT19CVF9GX1ZORF9IQ0kgICAgMCAgICAgICAvKiBJbmRpY2F0ZXMgdmVu
ZG9yIGNvbW1hbmQgc3VwcG9ydCAqLwo+PiAgI2RlZmluZSBWSVJUSU9fQlRfRl9NU0ZUX0VYVCAg
IDEgICAgICAgLyogSW5kaWNhdGVzIE1TRlQgdmVuZG9yIHN1cHBvcnQgKi8KPj4gICNkZWZpbmUg
VklSVElPX0JUX0ZfQU9TUF9FWFQgICAyICAgICAgIC8qIEluZGljYXRlcyBBT1NQIHZlbmRvciBz
dXBwb3J0ICovCj4+ICsjZGVmaW5lIFZJUlRJT19CVF9GX0NPTkZJR19WMiAgMyAgICAgICAvKiBV
c2Ugc2Vjb25kIHZlcnNpb24gY29uZmlndXJhdGlvbiAqLwo+Pgo+PiAgZW51bSB2aXJ0aW9fYnRf
Y29uZmlnX3R5cGUgewo+PiAgICAgICAgIFZJUlRJT19CVF9DT05GSUdfVFlQRV9QUklNQVJZICAg
PSAwLAo+PiBAQCAtMjgsNCArMjksMTEgQEAgc3RydWN0IHZpcnRpb19idF9jb25maWcgewo+PiAg
ICAgICAgIF9fdTE2IG1zZnRfb3Bjb2RlOwo+PiAgfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsK
Pj4KPj4gK3N0cnVjdCB2aXJ0aW9fYnRfY29uZmlnX3YyIHsKPj4gKyAgICAgICBfX3U4ICB0eXBl
Owo+PiArICAgICAgIF9fdTggIGFsaWdubWVudDsKPj4gKyAgICAgICBfX3UxNiB2ZW5kb3I7Cj4+
ICsgICAgICAgX191MTYgbXNmdF9vcGNvZGU7Cj4+ICt9Owo+PiArCj4+ICAjZW5kaWYgLyogX1VB
UElfTElOVVhfVklSVElPX0JUX0ggKi8KPj4gLS0KPj4gMi4zNy4yCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
