Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472A0EB64D9
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 20:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5021401BC;
	Fri,  7 Jul 2023 20:12:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5021401BC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s37N7wy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nb41WlKeZzIS; Fri,  7 Jul 2023 20:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7279F40193;
	Fri,  7 Jul 2023 20:12:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7279F40193
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 363F7C0071;
	Fri,  7 Jul 2023 20:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E294C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BFC280C7A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BFC280C7A
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=s37N7wy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gn-2Qhe2kvmR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A058F80C53
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A058F80C53
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvomwDeWOgdWxj7XDsfSLs++6l386QoBS4hIgf7zuViknbs3rO/OTUsJ+7eStk3N/+sIqG0aihvf6cR26M6Ve42H8KvWtyJ+P3YWkjRloQ8/16+82voBXcOrhqmQsj/Clc5DLJub4r/Jze2xeKm1in4ePviudr6VSdl8mEQENms07TpCI+VHP+yRldZoNB1yRhOg1P41D681A+wflLMqy13djCgNEz7J41Ydow3xcqga/tbFNLHr+n3IZK8geT1Rx/8MY9MLe3SAFgzLd20+GqxB8hoY72TU4eXV6ulk5DzN59xP53o9z4qTlRygiI96wnwyUZz3TC06ZF2ge49LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBnvPuTcVOfhPyRMf/RWvANGCknSpSMZMqJONk6t2nY=;
 b=k/EJchIKRw0inEA7iGEqo8l18/gpvB0RW6+JxTvECadDTFF4+lcwGahHRzvgM3lnnCtJc+/4T/DuQIljDjycXmqciHdm4gm4jwctfeigAyTJguGPTxLkrCVwR5zFM0wPSwQ1KLsseOEHGFSxd0XFGYayxggHY74lKPf0UpZArX/uhHHs47pWVX6fU7RRYm7NfQ8JSqmAW+Q7UJuudcfRQY5EsQntELHEgZzmg/TRoRdMpdlM48b1zQIYLWIxIII81LrbKfISgDFV0z47xZdk+FlkWCHq53bVD8krCvgMluznC16avJAsAC6fPGT98K28gchK7iSWHL+ekGT5NK8wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBnvPuTcVOfhPyRMf/RWvANGCknSpSMZMqJONk6t2nY=;
 b=s37N7wy/BNInyOhHqbN5Wb4FqMCGpwShBWdklNj9gqqz8loS8ETb4r2uBYBOmWf/PpI5wg8zN6SXxTn1tnRB/XhRL6unwFJBO6jGLJ+PAf1lkfsyx/F2azRyIOns9E35m026I7rqZ0PFyP9yzPCyq1wdsThqa2JBSnJwNIHAEtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 20:12:39 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 20:12:39 +0000
Message-ID: <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
Date: Fri, 7 Jul 2023 13:12:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-2-shannon.nelson@amd.com>
 <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
In-Reply-To: <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e30d87e-0572-4fad-e026-08db7f26834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q/AZq7h+QGUydJF/DCO6OW8Jg8na+a5g6G/4lX1By+DOGX8HU/F8mtN+hNDYVlJhec8Ds2Bp4ZrfHzQKWRyo2HxqxC5zerIaBAHZG07awqN2WbpL1jvumopVQ6kOYmgM0lTFB5SogUP9Q4yi6x5lahfPM00wltfJlN7WnOQZFX7+yGM9H4rK+aYKNC28hpAWhmOCb25ns015k1aSrZv86kae7E7Twc/t0lMQRYw+2NTzX9tKB0oJZotTmJJnhQBdu576TRxQsXXl1z8+fHLtOIWiKudV9LTmx7Mqx+ghVmdlySmEwVpZrFhu3fwjDaAU+pZaS1ZhByqwVoxdQjqUXxfa6yt9TD9rlIW9xOm1NSn2+j+lawRrZzC19cf4oUDV8ku7apfOlkWL/lUHY/Yv8UReAoNvSMJQiu3VGSaAIGf1espl4tQId7IOm2SJ9v6lbNuAgbWP9V4w4HD+H/6VKNWg6i9pvMrs8rNE5w06Rc2u/JytNLHZVD3cshlrjxnst8FezoSy06Mt/CvJY/ho4wEGZi2UWatGb3KAgZ+m25y02mP9JuQm2kD8375HxYEqyv729wWmFizBxs/QB/vrOIXx76mrsjhUZf9GqFV9CjYFChlSj14N2f5AWh6YUNf+NSUyhiAV0hC4kkw7MXmsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(316002)(2906002)(66556008)(66476007)(41300700001)(6916009)(66946007)(4326008)(5660300002)(44832011)(8936002)(8676002)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUY1MVNXb3lDY1VqK0kzNDh6bmpmS08zdi9iQ3ZwM0pnWlFYOTFPY3NKNVBs?=
 =?utf-8?B?MU5RWGZlQkJYdjJHbkVLQWZoWEszbXlHUUVGOU16NEc4aEpna09tQmhTSTc5?=
 =?utf-8?B?dlNNZ1pyUEFSbGxQSFB6M2Z3cHRlVWlwdWZ3T0t6RVVFQ0pQMmo3aUxsb2pu?=
 =?utf-8?B?blROSFdyODZ2LzkzWEp1UExNVHovV0tlSGoxNzY4dkRoNFBTaVFEeHNKdGxo?=
 =?utf-8?B?YUxKUDJ5OWVmTE9KbFNaUmpialZWcjJsMDQxbUsrZlpRbSsvS1NxVlBQeWhi?=
 =?utf-8?B?b1FYUUowUVdkZU13aUhJVmk1eXNjcjJRTmZibDM5dHFVZ3RocnpzZ1JIZEVW?=
 =?utf-8?B?RnA1b0s1MGhXK0tvQi92Y09QU3hNSk51ajRvZ2dHRHRIR0htdEJIbnBPbFJV?=
 =?utf-8?B?SmNaejB4cXNNdytJejdXVkFYOFJxdmZveWl3VzlsQ1hneEl5VFJUU2ZYNEkx?=
 =?utf-8?B?S2ZTL2ZIWW5RbndMWWNncVlrOE84WVpEZnZORDQyVTBpcWJTMDRWQ1dwNFg4?=
 =?utf-8?B?K01hWmxqRzJwU1lrcjdRMFg2YmFCWUQ5ZEw3aG9mUCtpakI3OHRvTmRQSXc3?=
 =?utf-8?B?YnA2SzEzWU5UNUZSN0hPM2ZuQ0ZlT21kZkFXRldZV3NEMDBVRVl2RTBYOEFC?=
 =?utf-8?B?MGNlbkpKalRmUGsrekgzd0pOcFd6SEUzQ1p2T2ZQZ2VGME9idDJCUmoxREV1?=
 =?utf-8?B?eWx0cmJDS1ptOEh6anZYZk51YTI1ZVlRQm5yTVlHTmVPYVUvZ3g4MmZyMEZq?=
 =?utf-8?B?dWRvUU1tSU9nVlZkWnVMOERMWlZXcG1IN0gvUEI4N3JXNnkxa0ZlSWZyQ3dq?=
 =?utf-8?B?Tm01akhaNzRjOVdLd3dSenRCMDhHL1VlRWREVytqbFk2bU9ubFlFOWRVMy9w?=
 =?utf-8?B?eDhKQ1pkYVVPZkg3UFFpV3VuWG5MazN5Ri9tV3pXcE9lVERocStVcGdITk05?=
 =?utf-8?B?anFTN09KRXlaTi9KUjYxTk51L0ZtWlpReWpZWGhqT0dFa3BKVUVwbyttN2VK?=
 =?utf-8?B?YWp3RXRCdnQwZUVBMXZVWGFmSWNYTi8rd3BSRlJIV2YzQmlPNEozcTk2L3lX?=
 =?utf-8?B?RHMwUEhiYm1SZ1hEWmRIQktnUllaRlJ4R21oTWlXS2xpZVhEV3Vta0x2eG0z?=
 =?utf-8?B?RmdRUndrVnN3V2lncUh5UWtYbUdjOXg5WHVXcEF6c05zZEp5eC9pTHJxQ1dl?=
 =?utf-8?B?TElaQVhiQjQrNVU2ays3UGdORnZwcXZubFJValUxTHE1LzczQjZFK3oxcCty?=
 =?utf-8?B?TUdST0xRNVlETDVGSVpObVcwbEpQR3czWkpkN2ZwVVRwSUdqcWZ6RzlFd0JT?=
 =?utf-8?B?L0VaT0xwSGhraTd1UEJUeVRVNzFodGxiY2lhYW14cVVQTmpvS1RMam4vUXZP?=
 =?utf-8?B?ZnREMHYvdS9LK2FEaUM3NnBCMW4xYnlFbTd6YzBiM1c5Z1M0OHhMd1FJQnRy?=
 =?utf-8?B?eE1YWjZTbXY0OEpXamY3dURGdEFKbExSTVRPNkN3djlCWElPVlIzUUNlU2t1?=
 =?utf-8?B?MFRmNzg4UzhIUUViaThIYjk0aC9lODByZ3JYZW9TL0p4RE9mcWVBdEVmR2Vq?=
 =?utf-8?B?ZnRBQ1pQaCsyR1pDY3Zrem56emFGaHpWTDhyV0V1OGkzaXFlMWVBSHNKckRN?=
 =?utf-8?B?eFpwemhLWTBhQ29ZVm9FbTJjd1ZuSkhCeUZoZVkzSmVXbXdhd3ZxY0swRzg2?=
 =?utf-8?B?K0JkRk54bnYvTDRQODlEK0l1NDR3dmkwVFQxWlI0anB1dUdSRlh1MkVody96?=
 =?utf-8?B?MVdMVjJ3VHBBeVlxWFlSUHZlY1RBaUZ4YzlpMlNYTDdNcm1YQ1dMSkt2bXlr?=
 =?utf-8?B?YlJxN0VMU0NPOTQ5NzQ4cUNQWEVZeGJ2eW1NdDNGWFdMcEFDa0VBQ3kvYklr?=
 =?utf-8?B?OUhxQ2ZQZ1NXdTQ3cXlCSkhneTJ5RDNSUVFPbHlYL3BoMTZJZlNhL0czOWcw?=
 =?utf-8?B?SG9tSnl6ZTVxWkxSVW1YMDBaTkx3SWF1RXVZTTJnYkMxdzUyZkIvUStJWG1h?=
 =?utf-8?B?SXZodFMxTi9ibncvMzRzbXBXUEwyemRqdmhic2ZQdFhkbjRPWFp0VUE1OWlL?=
 =?utf-8?B?NDJGV2V6V2g4WDJFditKZGR4V1hoaDFEaCtnTkFxWWhwWnZMdjJCdEdBZEpm?=
 =?utf-8?Q?J59HqqflwVPAEdXU18h8tS0Ut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e30d87e-0572-4fad-e026-08db7f26834c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:12:39.3302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXRpvM/X+J/EQKoZLg3lsD60+OqaNkQsAGQ3gW/ltVXIXwwc6dbzEiFeyA9+ge6PpcmftyOWr3uaJ5TacQlW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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

CgpPbiA3LzcvMjMgMTI6MzMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gQ2F1dGlvbjogVGhpcyBt
ZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1
dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25k
aW5nLgo+IAo+IAo+IE9uIEZyaSwgSnVuIDMwLCAyMDIzIGF0IDg6MzbigK9BTSBTaGFubm9uIE5l
bHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4+Cj4+IEZyb206IEFsbGVuIEh1
YmJlIDxhbGxlbi5odWJiZUBhbWQuY29tPgo+Pgo+PiBXaGVuIHRoZSB2ZHBhIGRldmljZSBpcyBy
ZXNldCwgYWxzbyByZWluaXRpYWxpemUgaXQgd2l0aCB0aGUgbWFjIGFkZHJlc3MKPj4gdGhhdCB3
YXMgYXNzaWduZWQgd2hlbiB0aGUgZGV2aWNlIHdhcyBhZGRlZC4KPj4KPj4gRml4ZXM6IDE1MWNj
ODM0ZjNkZCAoInBkc192ZHBhOiBhZGQgc3VwcG9ydCBmb3IgdmRwYSBhbmQgdmRwYW1nbXQgaW50
ZXJmYWNlcyIpCj4+IFNpZ25lZC1vZmYtYnk6IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJiZUBhbWQu
Y29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1k
LmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEJyZXR0IENyZWVsZXkgPGJyZXR0LmNyZWVsZXlAYW1kLmNv
bT4KPj4gLS0tCj4+ICAgZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jIHwgMTYgKysrKysrKyst
LS0tLS0tLQo+PiAgIGRyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuaCB8ICAxICsKPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYyBiL2RyaXZlcnMvdmRwYS9wZHMvdmRw
YV9kZXYuYwo+PiBpbmRleCA1MDcxYTRkNThmOGQuLmUyZTk5YmIwYmUyYiAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9wZHMv
dmRwYV9kZXYuYwo+PiBAQCAtNDA5LDYgKzQwOSw4IEBAIHN0YXRpYyB2b2lkIHBkc192ZHBhX3Nl
dF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTggc3RhdHVzKQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLmF2YWlsX2lkeCA9IDA7Cj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICBwZHN2LT52cXNbaV0udXNlZF9pZHggPSAwOwo+PiAgICAgICAg
ICAgICAgICAgIH0KPj4gKwo+PiArICAgICAgICAgICAgICAgcGRzX3ZkcGFfY21kX3NldF9tYWMo
cGRzdiwgcGRzdi0+bWFjKTsKPiAKPiBTbyB0aGlzIGlzIG5vdCBuZWNlc3NhcmlseSBjYWxsZWQg
ZHVyaW5nIHJlc2V0LiBTbyBJIHRoaW5rIHdlIG5lZWQgdG8KPiBtb3ZlIGl0IHRvIHBkc192ZHBh
X3Jlc2V0KCk/CgpwZHNfdmRwYV9yZXNldCgpIGNhbGxzIHBkc192ZHBhX3NldF9zdGF0dXMoKSB3
aXRoIGEgc3RhdHVzPTAsIHNvIHRoaXMgaXMgCmFscmVhZHkgY292ZXJlZC4KCnNsbgoKPiAKPiBU
aGUgcmVzdCBsb29rcyBnb29kLgo+IAo+IFRoYW5rcwo+IAo+PiAgICAgICAgICB9Cj4+Cj4+ICAg
ICAgICAgIGlmIChzdGF0dXMgJiB+b2xkX3N0YXR1cyAmIFZJUlRJT19DT05GSUdfU19GRUFUVVJF
U19PSykgewo+PiBAQCAtNTMyLDcgKzUzNCw2IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2Fk
ZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPj4gICAgICAg
ICAgc3RydWN0IGRldmljZSAqZG1hX2RldjsKPj4gICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBk
ZXY7Cj4+ICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsKPj4gLSAgICAgICB1OCBtYWNbRVRI
X0FMRU5dOwo+PiAgICAgICAgICBpbnQgZXJyOwo+PiAgICAgICAgICBpbnQgaTsKPj4KPj4gQEAg
LTYxNywxOSArNjE4LDE4IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRw
YV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPj4gICAgICAgICAgICogb3Igc2V0
IGEgcmFuZG9tIG1hYyBpZiBkZWZhdWx0IGlzIDAwOi4uOjAwCj4+ICAgICAgICAgICAqLwo+PiAg
ICAgICAgICBpZiAoYWRkX2NvbmZpZy0+bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01BQ0FERFIpKSB7Cj4+IC0gICAgICAgICAgICAgICBldGhlcl9hZGRyX2NvcHkobWFjLCBh
ZGRfY29uZmlnLT5uZXQubWFjKTsKPj4gLSAgICAgICAgICAgICAgIHBkc192ZHBhX2NtZF9zZXRf
bWFjKHBkc3YsIG1hYyk7Cj4+ICsgICAgICAgICAgICAgICBldGhlcl9hZGRyX2NvcHkocGRzdi0+
bWFjLCBhZGRfY29uZmlnLT5uZXQubWFjKTsKPj4gICAgICAgICAgfSBlbHNlIHsKPj4gICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgX19pb21lbSAqdmM7Cj4+Cj4+ICAg
ICAgICAgICAgICAgICAgdmMgPSBwZHN2LT52ZHBhX2F1eC0+dmRfbWRldi5kZXZpY2U7Cj4+IC0g
ICAgICAgICAgICAgICBtZW1jcHlfZnJvbWlvKG1hYywgdmMtPm1hYywgc2l6ZW9mKG1hYykpOwo+
PiAtICAgICAgICAgICAgICAgaWYgKGlzX3plcm9fZXRoZXJfYWRkcihtYWMpKSB7Cj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGV0aF9yYW5kb21fYWRkcihtYWMpOwo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJzZXR0aW5nIHJhbmRvbSBtYWMgJXBNXG4iLCBtYWMp
Owo+PiAtICAgICAgICAgICAgICAgICAgICAgICBwZHNfdmRwYV9jbWRfc2V0X21hYyhwZHN2LCBt
YWMpOwo+PiArICAgICAgICAgICAgICAgbWVtY3B5X2Zyb21pbyhwZHN2LT5tYWMsIHZjLT5tYWMs
IHNpemVvZihwZHN2LT5tYWMpKTsKPj4gKyAgICAgICAgICAgICAgIGlmIChpc196ZXJvX2V0aGVy
X2FkZHIocGRzdi0+bWFjKSkgewo+PiArICAgICAgICAgICAgICAgICAgICAgICBldGhfcmFuZG9t
X2FkZHIocGRzdi0+bWFjKTsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2
LCAic2V0dGluZyByYW5kb20gbWFjICVwTVxuIiwgcGRzdi0+bWFjKTsKPj4gICAgICAgICAgICAg
ICAgICB9Cj4+ICAgICAgICAgIH0KPj4gKyAgICAgICBwZHNfdmRwYV9jbWRfc2V0X21hYyhwZHN2
LCBwZHN2LT5tYWMpOwo+Pgo+PiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGRzdi0+bnVtX3Zx
czsgaSsrKSB7Cj4+ICAgICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLnFpZCA9IGk7Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggYi9kcml2ZXJzL3ZkcGEvcGRz
L3ZkcGFfZGV2LmgKPj4gaW5kZXggYTFiYzM3ZGU5NTM3Li5jZjAyZGYyODdmYzQgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuaAo+PiArKysgYi9kcml2ZXJzL3ZkcGEv
cGRzL3ZkcGFfZGV2LmgKPj4gQEAgLTM5LDYgKzM5LDcgQEAgc3RydWN0IHBkc192ZHBhX2Rldmlj
ZSB7Cj4+ICAgICAgICAgIHU2NCByZXFfZmVhdHVyZXM7ICAgICAgICAgICAgICAgLyogZmVhdHVy
ZXMgcmVxdWVzdGVkIGJ5IHZkcGEgKi8KPj4gICAgICAgICAgdTggdmRwYV9pbmRleDsgICAgICAg
ICAgICAgICAgICAvKiByc3ZkIGZvciBmdXR1cmUgc3ViZGV2aWNlIHVzZSAqLwo+PiAgICAgICAg
ICB1OCBudW1fdnFzOyAgICAgICAgICAgICAgICAgICAgIC8qIG51bSB2cXMgaW4gdXNlICovCj4+
ICsgICAgICAgdTggbWFjW0VUSF9BTEVOXTsgICAgICAgICAgICAgICAvKiBtYWMgc2VsZWN0ZWQg
d2hlbiB0aGUgZGV2aWNlIHdhcyBhZGRlZCAqLwo+PiAgICAgICAgICBzdHJ1Y3QgdmRwYV9jYWxs
YmFjayBjb25maWdfY2I7Cj4+ICAgICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsKPj4g
ICB9Owo+PiAtLQo+PiAyLjE3LjEKPj4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
