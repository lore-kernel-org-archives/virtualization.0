Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0916EEB64D9
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 20:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D21161108;
	Fri,  7 Jul 2023 20:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D21161108
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cNZbBXnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFQEAvMPSY-1; Fri,  7 Jul 2023 20:13:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EEB90611FB;
	Fri,  7 Jul 2023 20:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEB90611FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5CA5C0071;
	Fri,  7 Jul 2023 20:13:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6CDC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AD48611EA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AD48611EA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MjVmHZD4zbXd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:13:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EFDB60D95
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EFDB60D95
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 20:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipYDQ1CQ+Yo6h9eh075c3afOQLwuYr5aMFWK1DJ/ud6tckG0gNqIQ6j569gJQncrXVDeHqN0yq+vVvidSDZWMRzbmJOnqIdGHQbobSPtF9kWjyi5h9pYOrJu/xvNtcnI6MH79lonlz/qEfWE9Cdj1pivZoDI15SCo94AXIoYOPVuUbNablQ1zZAOqGtfQ4VXezWmomEa9K5FGbrMmehb3MwC4D/Q8v/tyMQkXDZsuww4EHBs8IOTsboDphGLLDhvDzhpXen2ZiIcXuwDmAXKKA96+1L5Gx8wbrepbdFQtVUuLW8aatW7cgk1U+dQT4UjDFdrEO6n1Zfte2qWPO9TfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwXm8e+CkPlmVfmD6Yy79Y1Oc94hzdvG82+QQbwYKgQ=;
 b=ImUHn2u2nmLl5UFsPbZ2Ecb8ijVJXZZtBwLaHPY2LhGdLAdlv26NX3NVJaj+NasyRoSqaj5tZPf6S7e3d7m8x6sm6EzBqLf2bqhQk1koMeG4yAHm1OyUF3CTjpZWGy1VD0QB9YWZGjFWbJzIuJOLDFdeFEodQba+5nMvEmn8tPICBbTMnsCyn9Vm2/eHjTe7rTOzUMFKK0pYJSFvkAUqcqCfJPcEvrDeToinKrsbvGQPaGUd2SAsuEkkr5/S5uSxgL2I47H2wJwT+/u3e2VpeLNhrDJu4GN7VTGh+rd5M64h2ai0VoGH8nHTbmvParr0TreGeTs5TUSVr6EaZw+xGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwXm8e+CkPlmVfmD6Yy79Y1Oc94hzdvG82+QQbwYKgQ=;
 b=cNZbBXnuIja/zBceq59C22dSZPTsqI2JR5RGsR8S1Pfh7pBpyW/GdBM41tlNukhh3gd6f5LvAOfEajep1s96ABVNI6YSGEYRRCoP46nujAPmeCN2irc9Exrn1ArVE6x71ugb7tevo4ichHb6a2Xjqs5bhD9qww6rdkkpW/PjBHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 20:12:57 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::818a:c10c:ce4b:b3d6%4]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 20:12:57 +0000
Message-ID: <4345f212-c919-d2fe-b47f-919629ef69b0@amd.com>
Date: Fri, 7 Jul 2023 13:12:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH virtio 3/4] pds_vdpa: clean and reset vqs entries
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-4-shannon.nelson@amd.com>
 <CACGkMEtH3u9bKD-49q1HuOaqnOkZc3=t+oirKZC6RZ622nUouQ@mail.gmail.com>
In-Reply-To: <CACGkMEtH3u9bKD-49q1HuOaqnOkZc3=t+oirKZC6RZ622nUouQ@mail.gmail.com>
X-ClientProxiedBy: PH8PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: afab2fee-db5c-44dc-ddb7-08db7f268e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNcnD8o7II/KnLKFnMxk158BkhwrI3dxbmY5VouRBU3negJ36pD94m1ZFG/qyH8HshtH+Ec6K77c1TbtxN05JiB1Y1UtQN1QaBRbLirIGIPL/JEwcomIAEqdGPCj/ID8PzyCKLYnviMTeaLmqQtHMUrXs/K/tn9TC6icZVY3dYNGg/w8bU/9T9FV0a6xBsytfkk++bC9/t2qRNJLTGf22I2tmxAddxg896M8SebYDSbV3wkGYGNWO86gMsaF1mARBH7pk43OBYElAfMs4IqGzerT8WNozWREohMdjixTCyJ4OLSsiBrCjVmcppJp2lstro1/u+x7rBiI0EQoax4vzqRdWGnUdmQOPYBnn9LLRFyGg2emoDFp93hHJa3hlvXiQjbNZWhy0+gHAU/STeT8XY9mwZDtoDCAL0C0QVqHgYxf+HK2oH/9CDo1qbfHHBEpp2jrajsVZYSsyBjzicqU+J+jA/kAyQcC1rm3z/v3n37PLWlZwUmmtX27UXb6RVVDo9VN9Q5fWqd8UIE9kFpd96pQnY0K+x7gZLl0LkkaGpIsCf76gac3vRawRk/eNwLAK9XbwLmdgU9YpWuRVcN2YpawXA0KmV/BeA1ul/fUIh6iSIJaKHP00NCjCeeGMVaQYfEC0VbFnjJWAnJcbRKWcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(478600001)(6486002)(6666004)(6506007)(53546011)(6512007)(186003)(316002)(2906002)(66556008)(66476007)(41300700001)(6916009)(66946007)(4326008)(5660300002)(44832011)(8936002)(8676002)(26005)(38100700002)(31696002)(36756003)(86362001)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFaS09tZnc2K29FbUhtODdlcFpMemNMd2ExNW96RXErQ2xiUjF5WVF6dHNE?=
 =?utf-8?B?MEFBcDJvYjB5S29yQUg1NC9UcnBYejdpS0t1cmI0d0VyQW5mMW95VHhrRXJ4?=
 =?utf-8?B?bElycWVaZ1VwTVg1SGNKTTFOcXpublNyQXBybzErRjNzcVFGcndGVWFQWFdF?=
 =?utf-8?B?Q2U1SDEzdkE5clFuYnVTaUpsaUNrcXBTTHJPWC9ZOEpHOGgvMkNJWGg1QWc3?=
 =?utf-8?B?aGo0TFBJSmo5cFNmTlBtRzR4RTJlZ0dWUVNlcHRKOHVaQUdGWE5jWkgvNnJZ?=
 =?utf-8?B?ZnRvUktTeGQ5cFc5SUk2dUI1MnZxNmdkV1J1K25mVExzeVlwWFBSWDRzYmQv?=
 =?utf-8?B?SlZBdHlOcVRZMEpEOVlheVo5RjRLU2lCYW5kcWJFUFlQRUpoNVN2eHByQnk1?=
 =?utf-8?B?USswY0ZCSUp2dVhRbENIRUJuby9SRFBFTE5yQWVJaDJnbTl3YnFLaFp0TzBG?=
 =?utf-8?B?U01ZWFFJWkdlRTNWeVN6djlkd3FYMHNCSUlkelM3WWpDYzhRcUdTcXhZSm5F?=
 =?utf-8?B?TUhOYXlRLzljRERlWkJhM3RMRVVTTkFjaTF5ODhDVys4MFh5NitGaVI1QVZy?=
 =?utf-8?B?RWNPU1NtSXlRZmszbEZiY3ozT1FseTNaODR3ZnllZ2FSYm9ON052QXYvUkhV?=
 =?utf-8?B?VkllcjUzbG5IZFF4NnZKcGo2NEs3Z1dFYmlRWExqU0piTkZQODdPcDhjTTFT?=
 =?utf-8?B?MnFuVi9QUEV3UjRZbHJjemZCYXI3MGJNaGF2UlhHOHg4OVdGTmxFaTM4RG94?=
 =?utf-8?B?cjk3cjE0YU5lTVVndDJhdFhveW9yanlhb1BQL2RmOG5lKzdmQ2h6alNGenBy?=
 =?utf-8?B?WmxvTlpJci9PaE93bzNoRmVyWThYa3pPZjdLeklwclRSMVpXYm5VOUd6Qlpx?=
 =?utf-8?B?UFJoWStMUW53eXlQL1NSNTgxdmw0bDVEdmdhdWhYZGVhRWtIc3A0SzhNRE90?=
 =?utf-8?B?aVFZcHZDVzNyM0twSXdlaWJYd005aFdtQnUyUW9XVXJyRkQyZFpjWnFaeFBi?=
 =?utf-8?B?R3hIM3doSWJxOGl3dmdzcE5vMEhnb2VlMW4vcnhpNlplYzBmTzdTeVNCUldo?=
 =?utf-8?B?Kzdka1piR3BrVE4zUDBHclUrWDBkRDBGalRNYnNZKzVJblZFZDBrUmdNcFVr?=
 =?utf-8?B?UTNMU1NYWU80dUwvdDhzcWdvVW8xNlBUeStYWTFDd0ZHSGRVWS9XemRnYzZE?=
 =?utf-8?B?L2V1eDM2ZUdwUWRWY1VqQXJIam5XVjRFWVNvckFGbGNwTnlYNjVWZXdUbjhu?=
 =?utf-8?B?Y3RLY3UvWjJrbDVjTm44bllTYkhwVWN6TzdJL3UydDhzaFVyMWw5U0V4aWJ1?=
 =?utf-8?B?Qnk5RDRqdUplOUtNMVJHVkV4c3VUNXlNQTJlWXgrdk5Qb2hwQ05FRFVHaXVC?=
 =?utf-8?B?QlEzZ1d4amwra0xQY3J0QytVS29mamhENjZGRTMyR2hhdUlXYWhXbVpvcUYx?=
 =?utf-8?B?ZUtieU5SSXM4UDdhTjlJRm5UMmlRRHpKV3FmbXc0WXo0UEE0WisxbUtNUkhS?=
 =?utf-8?B?ZkRTemVTMVNHdk12cW5EeHBQODRCVVRtNkgyMkJhNjV2OUFObFN3VSt6dUZr?=
 =?utf-8?B?MjI3SlpmM1I0czN3bUFnYlB2WVhsbXFzaERaSllOQ2Z1b1VrWG0vQW1FelhH?=
 =?utf-8?B?Wml6MjVPWmhLNE5kWGRWcnc4aTZZRlJXT1F0bjJxbkpCN2ZzWCtSSVRkWXRO?=
 =?utf-8?B?emZsZWthR0dBa05XVVozMU9pK1BuV3lmbVFlNTF3NWV2ckhlclltNUpVZzc0?=
 =?utf-8?B?eHRrVjdaaHFUenFES3hwZzdtOVp0WVdHVlpIT3JESjdKVlVyd1JNOWJIMlRR?=
 =?utf-8?B?Mlhyb2FFcVh0Tlh5VCtPM1VVTHJGZ2UwWnNZNU1NQ1hzWFJrRjlmK1BwOEl2?=
 =?utf-8?B?ei9WL3dMM2J5d3VEZDRsb0FIbjZxVjJnNThsRkZaTW5BYUVkUTJMbnhjUFE0?=
 =?utf-8?B?V0MrZVppcElBNStGS2Q1WGdOK21yVE9HZ3F3dU42c1NtbFNVQ2hpb1Q3NllS?=
 =?utf-8?B?SDNRMjMza1E5RTcwb2U5REwweDhkdGxHSnJTVEdBRTgyNlVlODlmZGNtNDVK?=
 =?utf-8?B?RmVhVEJOY1VCSVc1cDdwUHNFNkRJcE16eVRKbCsxMjNxSHhPZXFwcGpkYm9v?=
 =?utf-8?Q?N8dbBbf4UmEK8iRRuzMjuAHoi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afab2fee-db5c-44dc-ddb7-08db7f268e12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 20:12:57.3480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzKp6N/y2cBLEa6Mk1WVjz93yIeO7Sq7BoPQrzkG8XgtWsAoc3TqXxxB/GP2ZMEkqaXjtIwkl4cExbBGgjoqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
Cc: netdev@vger.kernel.org, drivers@pensando.io,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 mst@redhat.com
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

CgpPbiA3LzcvMjMgMTI6MzYgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gQ2F1dGlvbjogVGhpcyBt
ZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1
dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25k
aW5nLgo+IAo+IAo+IE9uIEZyaSwgSnVuIDMwLCAyMDIzIGF0IDg6MzbigK9BTSBTaGFubm9uIE5l
bHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4+Cj4+IE1ha2Ugc3VyZSB0aGF0
IHdlIGluaXRpYWxpemUgdGhlIHZxc1tdIGVudHJpZXMgdGhlIHNhbWUKPj4gd2F5IGJvdGggZm9y
IGluaXRpYWwgc2V0dXAgYW5kIGFmdGVyIGEgdnEgcmVzZXQuCj4+Cj4+IEZpeGVzOiAxNTFjYzgz
NGYzZGQgKCJwZHNfdmRwYTogYWRkIHN1cHBvcnQgZm9yIHZkcGEgYW5kIHZkcGFtZ210IGludGVy
ZmFjZXMiKQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25A
YW1kLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IEJyZXR0IENyZWVsZXkgPGJyZXR0LmNyZWVsZXlAYW1k
LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jIHwgMjQgKysrKysr
KysrKysrKysrLS0tLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFf
ZGV2LmMgYi9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPj4gaW5kZXggNWU3NjFkNjI1ZWYz
Li41ZTEwNDZjOWFmM2QgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYu
Ywo+PiArKysgYi9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPj4gQEAgLTQyOSw2ICs0Mjks
MTggQEAgc3RhdGljIHZvaWQgcGRzX3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGFfZGV2LCB1OCBzdGF0dXMpCj4+ICAgICAgICAgIH0KPj4gICB9Cj4+Cj4+ICtzdGF0aWMg
dm9pZCBwZHNfdmRwYV9pbml0X3Zxc19lbnRyeShzdHJ1Y3QgcGRzX3ZkcGFfZGV2aWNlICpwZHN2
LCBpbnQgcWlkKQo+PiArewo+PiArICAgICAgIG1lbXNldCgmcGRzdi0+dnFzW3FpZF0sIDAsIHNp
emVvZihwZHN2LT52cXNbMF0pKTsKPj4gKyAgICAgICBwZHN2LT52cXNbcWlkXS5xaWQgPSBxaWQ7
Cj4+ICsgICAgICAgcGRzdi0+dnFzW3FpZF0ucGRzdiA9IHBkc3Y7Cj4+ICsgICAgICAgcGRzdi0+
dnFzW3FpZF0ucmVhZHkgPSBmYWxzZTsKPj4gKyAgICAgICBwZHN2LT52cXNbcWlkXS5pcnEgPSBW
SVJUSU9fTVNJX05PX1ZFQ1RPUjsKPj4gKyAgICAgICBwZHN2LT52cXNbcWlkXS5ub3RpZnkgPQo+
PiArICAgICAgICAgICAgICAgdnBfbW9kZXJuX21hcF92cV9ub3RpZnkoJnBkc3YtPnZkcGFfYXV4
LT52ZF9tZGV2LAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWlk
LCAmcGRzdi0+dnFzW3FpZF0ubm90aWZ5X3BhKTsKPiAKPiBOaXQ6IEl0IGxvb2tzIHRvIG1lIHRo
aXMgd291bGQgbm90IGNoYW5nZS4gU28gd2UgcHJvYmFibHkgZG9uJ3QgbmVlZAo+IHRoaXMgZHVy
aW5nIHJlc2V0PwoKV2Ugc2V0IGl0IGFnYWluIGhlcmUgYmVjYXVzZSB3ZSB1c2VkIG1lbXNldCB0
byBjbGVhbiB0aGUgc3RydWN0IGFuZCBuZWVkIAp0byBwdXQgaXQgYmFjay4gIEJ1dCB3ZSBjb3Vs
ZCBncmFwIHRoZSB2YWx1ZSBiZWZvcmUgdGhlIG1lbXNldCB0aGVuIApyZXN0b3JlIGl0LCBhbmQg
ZG8gdGhlIG1hcF92cV9ub3RpZnkgY2FsbCBqdXN0IHRoZSBmaXJzdCB0aW1lLiAgSSdsbCBmaXgg
CnRoYXQgdXAgZm9yIHYyLgoKc2xuCgo+IAo+IFRoYW5rcwo+IAo+PiArfQo+PiArCj4+ICAgc3Rh
dGljIGludCBwZHNfdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+PiAg
IHsKPj4gICAgICAgICAgc3RydWN0IHBkc192ZHBhX2RldmljZSAqcGRzdiA9IHZkcGFfdG9fcGRz
dih2ZHBhX2Rldik7Cj4+IEBAIC00NTEsOCArNDYzLDcgQEAgc3RhdGljIGludCBwZHNfdmRwYV9y
ZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIiVzOiByZXNldF92cSBmYWlsZWQgcWlkICVkOiAl
cGVcbiIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5j
X18sIGksIEVSUl9QVFIoZXJyKSk7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBwZHNfdmRw
YV9yZWxlYXNlX2lycShwZHN2LCBpKTsKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgbWVtc2V0
KCZwZHN2LT52cXNbaV0sIDAsIHNpemVvZihwZHN2LT52cXNbMF0pKTsKPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcGRzdi0+dnFzW2ldLnJlYWR5ID0gZmFsc2U7Cj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHBkc192ZHBhX2luaXRfdnFzX2VudHJ5KHBkc3YsIGkpOwo+PiAgICAgICAgICAg
ICAgICAgIH0KPj4gICAgICAgICAgfQo+Pgo+PiBAQCAtNjQwLDEzICs2NTEsOCBAQCBzdGF0aWMg
aW50IHBkc192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNo
YXIgKm5hbWUsCj4+ICAgICAgICAgIH0KPj4gICAgICAgICAgcGRzX3ZkcGFfY21kX3NldF9tYWMo
cGRzdiwgcGRzdi0+bWFjKTsKPj4KPj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGRzdi0+bnVt
X3ZxczsgaSsrKSB7Cj4+IC0gICAgICAgICAgICAgICBwZHN2LT52cXNbaV0ucWlkID0gaTsKPj4g
LSAgICAgICAgICAgICAgIHBkc3YtPnZxc1tpXS5wZHN2ID0gcGRzdjsKPj4gLSAgICAgICAgICAg
ICAgIHBkc3YtPnZxc1tpXS5pcnEgPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUjsKPj4gLSAgICAgICAg
ICAgICAgIHBkc3YtPnZxc1tpXS5ub3RpZnkgPSB2cF9tb2Rlcm5fbWFwX3ZxX25vdGlmeSgmcGRz
di0+dmRwYV9hdXgtPnZkX21kZXYsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSwgJnBkc3YtPnZxc1tpXS5ub3RpZnlfcGEp
Owo+PiAtICAgICAgIH0KPj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgcGRzdi0+bnVtX3Zxczsg
aSsrKQo+PiArICAgICAgICAgICAgICAgcGRzX3ZkcGFfaW5pdF92cXNfZW50cnkocGRzdiwgaSk7
Cj4+Cj4+ICAgICAgICAgIHBkc3YtPnZkcGFfZGV2Lm1kZXYgPSAmdmRwYV9hdXgtPnZkcGFfbWRl
djsKPj4KPj4gLS0KPj4gMi4xNy4xCj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
