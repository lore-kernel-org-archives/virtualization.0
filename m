Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA21C64E7A
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:41:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FF620644
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jPz42VoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FF620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 28F538812B;
	Tue,  1 Dec 2020 10:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlkUB8lV8-qF; Tue,  1 Dec 2020 10:41:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA7CE88087;
	Tue,  1 Dec 2020 10:41:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF833C163C;
	Tue,  1 Dec 2020 10:41:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 204B0C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 07BB986B68
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCfHKd3WddKR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:41:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DD19086AC8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeNaDrUANnZPOqJeUM6I0u+jNc6Zri7zOAfjA/W4Yeiw+gNmppQ5M+S6C+7jhALdgK/MPOMQDY/IlQZ/M1YNCUIDA07vQLEZYbIVJBz7G+WDx/JfHhINuhfr0bjD2UjuFyYdH/4aMyp4Znjriqh3FPeBCON9D3riwmXxTjqEqgb/7VjwoDLj+RtHyPl/Fl2fViGg7U3scEU/+tApTQ9xXr1oO6T30rBWioZ9EZa71WCdPbhLD7UiIjto08dx3DtBwb9QuEMLgW+JGT+Vdjq1Vv9QEq8rCmVDsONm7UuJDaoTDXZ7lCgY2soU5kV0x6U2WwrQiCdiYkjfloFU70GzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHsRdPxRBjysxtTWx7jFJq8hJpxJMDx1LK5hSESNTIE=;
 b=TSuyCtA8Frtvd8TYRpDQuGqR8khBvFopy4NtODDRyxfqvDaM68uFfIfMqGzZ/Ui92UPO/cX03MmPkMFilE5hxc28ZbktUG87biWEs1G1jSFU8pfuGf+JutqRrhc7bO/yIW3nFxjqWFkcZ7s5c7zNLLuf5iDP8CuqIpvoE3bhlm+TJDzRn22pTpUGxAkZD0EES90WtMFVnOhDg3Mjv6E0uE0C4wUZ/CmsNIJLrw3pQCU9fg8dp6ZtcEnNhNdWjng/7TycJKzYu1Dho+qfOqGVDPa8OkI2hBEpTSGT5oAk5fenk4hF1hK41MZ6AQvvdcsBFNn4jQFpCF/sml1RXTfzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHsRdPxRBjysxtTWx7jFJq8hJpxJMDx1LK5hSESNTIE=;
 b=jPz42VoJizZb/Fu9pyA1WSSgSiVWcVgJLQjNeBNVLq6zQa5ORAbPOLsxTRUa4CnEu12LEyzqB92zmfvKqqgavaLYdLaqKygNSyFx2XYHlWR1+QKzpHXHNJ3z4ny0+DOXFel4dDPyNCt3DSzf3HWLyqmlFXsY3Lc9Y60dTXapkF8=
Authentication-Results: ravnborg.org; dkim=none (message not signed)
 header.d=none;ravnborg.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 10:40:58 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 10:40:58 +0000
Subject: Re: [PATCH v2 01/20] drm/amdgpu: Fix trailing whitespaces
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie, daniel@ffwll.ch
References: <20201201103542.2182-1-tzimmermann@suse.de>
 <20201201103542.2182-2-tzimmermann@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d79aa7c0-9b0b-4f1b-c4e5-54f53a8d2931@amd.com>
Date: Tue, 1 Dec 2020 11:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201201103542.2182-2-tzimmermann@suse.de>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0701CA0031.eurprd07.prod.outlook.com
 (2603:10a6:200:42::41) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0701CA0031.eurprd07.prod.outlook.com (2603:10a6:200:42::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6 via Frontend
 Transport; Tue, 1 Dec 2020 10:40:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ae82f56-5917-40bd-7cfe-08d895e59699
X-MS-TrafficTypeDiagnostic: BL0PR12MB4932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4932600BC6B1FDE0F331A2FE83F40@BL0PR12MB4932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r2D8feyOVloDbbEuIIMw6Duam8wzPp49XhX7P3NFpB6Z3QrtMeS/zylp/eKOLLA62x5TD5JiqjpwLjU+vZE22/1HBH7tvYT8Pz5him+8ZuPX5z7lny2Jm8oPGgd2GHStwAUElUUllXSqG89z1itq2cFq/MCVRgJ+XkALckUWpDWB4gZ6ps+tASlPtV2/G2RqQ7Wy1LS+1X8UfIHI9lfoWPW024g2g238nmgPDll1aBJf0/cWkqJHji5BfI69ZlxiV2CYj/nwc32wxGkXiz80L2Z3cMkB3Z1lPkwCL6yowC+VSAi+3Y8t/wMrtvfUrodObG4WstUEZiA7jJUEyMoBFvyDc4Ey3c3NZs0+nFJQl0lW5t2OgkCN4EGmLtiH02g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(66574015)(2906002)(316002)(8936002)(54906003)(52116002)(66556008)(2616005)(66946007)(8676002)(4326008)(36756003)(186003)(83380400001)(6486002)(16526019)(7416002)(31696002)(86362001)(31686004)(5660300002)(478600001)(66476007)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dW1lOXZDRFVVa3ozaGdyUjZ3dGtGV1JYMXVyZkJFemRMdnpqZEN3UlU2aEto?=
 =?utf-8?B?bE5SeEYrem5WNEMyVzdVN0lLd2hNdjl4cVoyZHhUZUFHT1JwV3Rmc00veGhR?=
 =?utf-8?B?YWVjd0dzZUFkR2ttdkhuMG0vNHV3WVptRzVnUUdrd1owQ3l2bEVwZENVOWox?=
 =?utf-8?B?SkJzcXk5U1k0WVB3cDNoQjRZRCtVSit6ZEhvUnF6TUduWitIWTF5VlZpQ2hX?=
 =?utf-8?B?dVlvOUdZODBhRy9CTEkzSXVzeW1Wb0lYN0dOa0Z3ZTJKV29TeUpyU0Mram5i?=
 =?utf-8?B?TGtJY3A1MERMSWl6QzRlZVhPRUc3eGo2M0NNeFBPcFN0T2hKQUtxNG10QWo5?=
 =?utf-8?B?c0kvSHdoOHE4clQxSHVvSmZEWFlSWTFDVEtrWHR3d3FWcGhiQVE0aEpzUDlj?=
 =?utf-8?B?M25xa0ZhZjZJRU1VZVB5TVg0QXhRRit5ZjVRVHk0aFpxQmdvRWU3MHh6YmZO?=
 =?utf-8?B?ZW9zYUhwWTdBT1lpSnJ5VU0xZk5iWVBiZk1hQk5xUERQMS91VTR2SVdsZmxC?=
 =?utf-8?B?S1lhUUVLdGVjV2RQdk5CL05tYkdFT01ldHYycTBBQTJpSGxzNE9WQzRoeVhw?=
 =?utf-8?B?aVRxdG5jYWt6cVVzRVNhc0V2R01HazNnbjdnTEJjNm45Y0RONjdlUDJaTk5I?=
 =?utf-8?B?cEM2ZzdCNGNTK3dEVjhwYVBTMGVNejg5Z09qTHI3R2tTcGpLNDFXaWtyR3g4?=
 =?utf-8?B?ZFl2VWp1V1NXWUFseXRXcW9TQUdMRUlxR090aTlTUTJEbHV5ZHVnbnVoaEJr?=
 =?utf-8?B?eUZpZThWNmtIbk95Q0ZNbHFmcVlBZFY4R3dWSmFwNDVTaFFxbXFJL0lpT0Rk?=
 =?utf-8?B?cksycEhCMGVHSHJ2dkJaVEI5NmIrMU1HOTdMdEhuaXhCdC9scTMySGx1bVNv?=
 =?utf-8?B?RitVK2dCeTBTWjduWVhxcUhTc2hTRUFQMWwvdmVPNzQ1NHdnZ2RSV0JmdGVU?=
 =?utf-8?B?RG8ydGc2NXRzM3BXY3JFdzZsMVpaUXBvaDl4UHc4T2szK2xWNHlyV0pWZyty?=
 =?utf-8?B?RmN3Vm1PcXM2Qks0MUIyaGJtcTljcEs2OE9lMUlacVJXQTRrNk9zVGdTWk9r?=
 =?utf-8?B?Z2VpUGpVSjdKakpGcGtnQlJ4dVZ3MEZpbFNkaGZWc0c2anRZRkNFc3B0ZXpk?=
 =?utf-8?B?UDkzekJvb3prWGNubVRRSE1vQ1ZoMzJBMkNOaWtKYVFWWEVSTXE0bXlFRUtX?=
 =?utf-8?B?WHNVSFNzSFoxcTN0N1dHTjkxKzZtV2c1RDNoZzV1NTAzdnRwbGJ1Uy92ekd2?=
 =?utf-8?B?MjRjaGxCRFRmVktpMnFtdnNEMzAzMFF6RWYvTjJYNTZvSmpiVFFES1JkQVd5?=
 =?utf-8?B?NFdhSlJjSzJnWEc0MjFxRm5QcDRISnhxU0tYYk8ydkwzWklnWEVPWGF1R0tU?=
 =?utf-8?B?MmdDamlmajJJSWp5dElvbDd0V1Mzc2wrZGhMNktIL1p6NHM5TEI1eGtQZGdu?=
 =?utf-8?Q?N6Do7Ue5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae82f56-5917-40bd-7cfe-08d895e59699
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 10:40:58.2414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Fc34EPELlxXSULHLuYDCWSamT4D9bmBwxwHq5XoJrdOBkH7qMi2uPgiM9xogCK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
Cc: Sam Ravnborg <sam@ravnborg.org>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, spice-devel@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
b24gcGF0Y2ggIzEgYW5kICMxNS4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IG9uIHBhdGNoICMyIGFuZCAjMTYuCgpSZWdhcmRzLApDaHJpc3Rp
YW4uCgpBbSAwMS4xMi4yMCB1bSAxMTozNSBzY2hyaWViIFRob21hcyBaaW1tZXJtYW5uOgo+IEFk
aGVyZSB0byBrZXJuZWwgY29kaW5nIHN0eWxlLgo+Cj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFpp
bW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBBY2tlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1A
cmF2bmJvcmcub3JnPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDYgKysr
LS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IDVm
MzA0NDI1Yzk0OC4uZGEyM2MwZjIxMzExIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC00OTIyLDggKzQ5MjIsOCBAQCBwY2lfZXJzX3Jlc3Vs
dF90IGFtZGdwdV9wY2lfZXJyb3JfZGV0ZWN0ZWQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHBjaV9j
aGFubmVsX3N0YQo+ICAgCWNhc2UgcGNpX2NoYW5uZWxfaW9fbm9ybWFsOgo+ICAgCQlyZXR1cm4g
UENJX0VSU19SRVNVTFRfQ0FOX1JFQ09WRVI7Cj4gICAJLyogRmF0YWwgZXJyb3IsIHByZXBhcmUg
Zm9yIHNsb3QgcmVzZXQgKi8KPiAtCWNhc2UgcGNpX2NoYW5uZWxfaW9fZnJvemVuOgkJCj4gLQkJ
LyoJCQo+ICsJY2FzZSBwY2lfY2hhbm5lbF9pb19mcm96ZW46Cj4gKwkJLyoKPiAgIAkJICogQ2Fu
Y2VsIGFuZCB3YWl0IGZvciBhbGwgVERScyBpbiBwcm9ncmVzcyBpZiBmYWlsaW5nIHRvCj4gICAJ
CSAqIHNldCAgYWRldi0+aW5fZ3B1X3Jlc2V0IGluIGFtZGdwdV9kZXZpY2VfbG9ja19hZGV2Cj4g
ICAJCSAqCj4gQEAgLTUwMTQsNyArNTAxNCw3IEBAIHBjaV9lcnNfcmVzdWx0X3QgYW1kZ3B1X3Bj
aV9zbG90X3Jlc2V0KHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICAgCQlnb3RvIG91dDsKPiAgIAl9
Cj4gICAKPiAtCWFkZXYtPmluX3BjaV9lcnJfcmVjb3ZlcnkgPSB0cnVlOwkKPiArCWFkZXYtPmlu
X3BjaV9lcnJfcmVjb3ZlcnkgPSB0cnVlOwo+ICAgCXIgPSBhbWRncHVfZGV2aWNlX3ByZV9hc2lj
X3Jlc2V0KGFkZXYsIE5VTEwsICZuZWVkX2Z1bGxfcmVzZXQpOwo+ICAgCWFkZXYtPmluX3BjaV9l
cnJfcmVjb3ZlcnkgPSBmYWxzZTsKPiAgIAlpZiAocikKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
