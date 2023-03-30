Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA638C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 18:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5839584450;
	Thu, 30 Mar 2023 18:22:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5839584450
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g/A3uudp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwZROAyR69xm; Thu, 30 Mar 2023 18:22:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB96B84454;
	Thu, 30 Mar 2023 18:22:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB96B84454
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E519C0036;
	Thu, 30 Mar 2023 18:22:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5D9C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A77084454
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A77084454
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4rw0-zcEuYyt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3CEC84450
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3CEC84450
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5KNOu6xM4d82FxUxv6vjpwZwEIc5WsuIn/stck0fRGJfyK2xA/eNxK0DPP6k994xmB88PqOBXzf1aq+PAUKnEZJZT+aYLqJpnTVsdevEYSV1MgGVLbRxzVAGvEl5IvBIF5k/zft6ciBYiTdxDIbSi6rC5SHDh6JjwHUG2ky1EHgCfPTAhU01g8E4NQd0XF8gVl3KX+uJ+bafgdvbWvwMSs5bL/inUfYa2WX4E71cC3NBqChMMmqwcYL91oHJxHvRLx6ghNPvSZ+/CUQfJhOBq4RU6cU6xOeoLRQoKkmzxW6tTN+ziLtiOlLTFjAalVdSXHBqM8vjp0AbEtWiE51jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf/jw0aOXlPZJYnK137YdenmhQNXBn1xZ9DIbi4+aoE=;
 b=WZG2AFfzYR/HUHa8aY75N2U4ZaHjhSszm82I4B+zKdti3A9M0mF9ewOzL+DyGQSUK7A3fhQ9l8Uklx/HXbuBA2wBfLi/JVOZQY6VM+IXGnqKkklr3AHm9zLtIQxwEkNX3FCmto91IsbOUctxoEm3o4P7BtjE9VjMwusQJxXonsn+60CHob5fRBRjkrGUSIT8h1FgWcYSeZwMCiSmna0TyTw25QR+tHlJOVHWGSy+4PDtKyq8CEJqEQGT9aW414aQXnlTjCZgiu4nprK6QqbniE02n+uEIrikx1WLUhkfDv+2WLfqivevFWYrA5nzpXxWsx5Id30wcVA0x2hITkl6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf/jw0aOXlPZJYnK137YdenmhQNXBn1xZ9DIbi4+aoE=;
 b=g/A3uudp6Lp7jv/BgMbf4XGohkYByBqjyUAaAI7uR6NJrqeF2Q1bqx/4Oghztt8bS2y5auIU3qDrBSsb7gIWpUlI7wW46c8azrVx47QmTyS5J4oUYrZCa3oZ998zFAW88cXU5/8IZtDIyp9fZgWBSKiS1jlIZvBMJrla371dn08hX6FoWI4viuaetSQ+9nxrQZs7cnqNbr/uuZkOggcgh+abCptNdbH2HgE5nuSBxmieWgQ6aVSFOkEhwRMoxXH4boC+3VmtQqa09swzKwAQNo2YP1Rgm/4mOU4jsWj/3XAFb0lh+yPFmwWaLusKAJ/kQ/loDbzxQ6j2DcG7u7OMAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 18:22:25 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 18:22:24 +0000
Message-ID: <16bc79b9-94a2-6c7f-3019-565581874cd0@nvidia.com>
Date: Thu, 30 Mar 2023 14:22:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] virtio_ring: Avoid using inline for small functions
To: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-3-feliu@nvidia.com>
 <CACGkMEv6qG-9-A2cmOo00E=pPY2p0dnC3SoM8AVV5xLNMA9YCw@mail.gmail.com>
In-Reply-To: <CACGkMEv6qG-9-A2cmOo00E=pPY2p0dnC3SoM8AVV5xLNMA9YCw@mail.gmail.com>
X-ClientProxiedBy: DS7PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:8:2a::25) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e818bb-93d0-4775-e808-08db314bb5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DutwkUzVr+J3dRNaEGKwBw9PQdM7UR89H73JhYr/LUH7lWosfqrN6oIEt1WdRKiSk0f0/NA6jbYYR3VIob+AQ9NzBcONb1ze/xWSDscXJiSGJYKVKFj7DieRR4u3HV6N22EKEhWBV2FT612sD21xC4Q/fNt2GuZqbr0gvlgxGa767ZnnDLgDO3eLXHaRe7LwfxgzFjmKQkc+EKnHqfNVa3XyO/Kvu9ZaeR/y01Asb3u0DULqAjjyTIMfVXXMUmna46fN6kxys3mvMeQEt+5tZVweHCLouCnaMcXd9vdkkXeK1y/Yq0btsBlEfKy/6QjFWFUX+EwcUk5LBSxq/Tvxdl8gmvgKJYnPvrzRWg15lvCeO5Hn+KaV+mUW7XmsVWKVZFZDOs6TPDtrlWpe4bkfXGLkvQv4BgaUFwgCU9H4BMuGBMZ9Ly8A7tyBjUisKGGoLkF20mZ2ZR7tM0/Dg9+sff2VHgRs4/XpfnkCiTcK284eRHgFU9rSoUARJbENIvxL2Ati6m/7Vi7/gKDGH1xYwEFmzUc/xFaUmshLa/d0kV1AF7Ven2775x0Vx5YyHwv30XVu68JChKyGgBEV8XJ8DORKM2BSxUII7SDDs0dxlVIzcqkEPI0R1LESdJ17CXo/SUpTxeL4K4h6mCTDt4/iSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(66946007)(66476007)(8676002)(66556008)(41300700001)(4326008)(38100700002)(2906002)(5660300002)(8936002)(53546011)(6512007)(6486002)(966005)(107886003)(6666004)(36756003)(83380400001)(186003)(31686004)(2616005)(110136005)(54906003)(6506007)(26005)(316002)(86362001)(31696002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXcxZExmS0dQR0g2Y0w0c3MvOHdsdWZWcStuKzdxNm1iUkcvaU1VU3VFQ2s5?=
 =?utf-8?B?ZkY0WGw0b09vc0hrVWxMaVdJaVVLdmN1bTVSMG5Ja3dOVENPNmQ2RzFvUS9L?=
 =?utf-8?B?ekRqeWdBMmMxTVBDMnJrc2prNTREMEJ5ZVRFNXN6ZHJwT2NKRllVSDRhTVIz?=
 =?utf-8?B?WlowZWxyWFd4OG1FYkpyK290bXBpZFRqTC9zQWQwNXBzVElzWTV2dFpDc01m?=
 =?utf-8?B?Q05wcTdpbHU0TlBCUnJ5UFdseGc2RytiU2Q4b1FScnplMmU5dDVaLy93bDhv?=
 =?utf-8?B?WlZoQy95N2VsUHV3a0tYRHIzaXUxNXJiZ1lsbTg3NExNNTljN1orZHFrTmlB?=
 =?utf-8?B?VHBOUThoQjhMeGdpdXY1NzJSNWhKaUVGcXVDeVF3a0hRcWJjVitMT3VCK0JS?=
 =?utf-8?B?djg2MzY2WDRWZitJU0d1RTIzTCt1S2VjT0hrZ1UvcEpXR29zME8yVENrcXdl?=
 =?utf-8?B?dEQ0SEhweFhsRFdxd1AvY1NSVUZPTUo0bmh5amE4QXVBcm1KNmRlV0NLWjZ4?=
 =?utf-8?B?VHpTTi9tUW1lQmtVNnlIR2VYZEpKdk5KcVBQSWJnd3dqK2RhS3d6UGVIVDg0?=
 =?utf-8?B?cEt3YUdxamZaeHo5cDlPOFIzVXd2bmhSV0x6VDlsNExBb1Zjc1Q3Q2M2WUxw?=
 =?utf-8?B?aGlnRjlBdWd2U0VJbEhkamRZSVVORWRzVURJNlVrRDBMQUtBVDhkSjV6K1Va?=
 =?utf-8?B?UVVNbHJNSXJaYnpkMS85K2dHNXVXR2U4dUZCbU00bVU0b09wYjZ3SlBYMzN3?=
 =?utf-8?B?WVZ4K0NQM2Fic0pSaW5ZelFNVUtnS1U1dlRCOWZaSEpyWEJuYm9ML2JRMkxM?=
 =?utf-8?B?K1JLZVI2cmc5dlZKSWErR1pjNjlOeGNFblMvSEl4dVZZOVlpdVZGMEJlVEV2?=
 =?utf-8?B?TXhWaWo1M0M2bUt3aFdFMU9VYjRYeG0zcGhzNmRlQnA5MnQyQ2ppNVQ5Z3Zy?=
 =?utf-8?B?TXBEN3loMGZBM0xZcnF5bmJEeFJ3ZVlaRWNnbHRiQmNjb3pTY2kwQ2wxc2tz?=
 =?utf-8?B?NXZnd1pWQUFMMmhzSk5uWUZQSGdMTGlOMTRTN0tlMGYwajBMd2JYc1lLRUlj?=
 =?utf-8?B?TE1aTDlpNnRkU2plYkk1MnFsMkVOZWd3Z3p1YnBueWRMRk5ZbGphSFV1WUZz?=
 =?utf-8?B?UEF3YXVIWGxRSkhLQysxdDBaZG5hSlNtaXdGRlA2OVNCdzFEV0k1R3hPSU1w?=
 =?utf-8?B?ZzdUMFBTWEFEMDFFbnJQUGJjZ090bkV3cGlhaEI5UkNDZkJnWmc3WFdHcGZu?=
 =?utf-8?B?a2czZzEzT3JwdTZEMWNFTDJTSWtCOUh4VEJkdm9ZTWhqWlBsRHBFZkxVdXpY?=
 =?utf-8?B?a3MrT1ZONEkrRTBlL05ZWUFMTTYrakpJb1Q1d3JHSCswdUpQMW13MzFaV3cz?=
 =?utf-8?B?cGNhVFdJRHc5TW5tbmh6b2NPeFVQTzRPUm02ZnF4UVBXRGJBYktLZVZzNXc4?=
 =?utf-8?B?TDlnVW5hVFA4ZUlnRXF1eEt0a2ljemhzV3Zrd25aS1RiNG9WSUJNV1F0MlZl?=
 =?utf-8?B?VHR0N2h4NXlTM2Y3ZzlRUFg2OFpqeGdHRzhKQytTM2ZWYlRGZXZGUmN2RkZv?=
 =?utf-8?B?b0F2eG5KRE1rR0RDWEdiVjdWMCttVW1uVXBTazNNVG10ZU8vbGRNVGNnM0R2?=
 =?utf-8?B?Q1FGVVBiZm9sN0lUd1dFaytjdTVCQWUvdmFYbWJDdE1Xemp5NURBcThFSlUx?=
 =?utf-8?B?VVB2bkh3Zjg0WjF2ZUtDNU96elBmOE41UlMzNWtWQlEwMWRXaXRYTmRjR2FM?=
 =?utf-8?B?S3lrUGxRck9YOHoyVVVsT3NDWHBsUFNYRTlrWXI0bjRkSVdiVnZNZlE1MGcy?=
 =?utf-8?B?eStkSlp4YXVtb0xPUE5pckhHRHhGSVVkQ1JCN2JwVXd4amNZWStGdzcxdloy?=
 =?utf-8?B?OGtSanB0Nk8wbkRNTW5mRlJNbVBzL3ZOenlPVU9JcGVvczhnb1RKMmloZHNT?=
 =?utf-8?B?Mmt4Vi9sNUF5T0pLSlh2R0kxdllZRHMwTDdSUjRWK3NWcE9LK1I1VUFLNXB5?=
 =?utf-8?B?WmFlbmZMZFROakxVa3VSVGNZclduNko2SHNSMHU3K0o1cCtncEY5clBkQi9r?=
 =?utf-8?B?aEloWGo3ZDlPVU55SUNWbGJOV2xRb3lSdUY0UDk0NVhSZVZ3b3dDMU1DeWJu?=
 =?utf-8?Q?qdfJNQOwc3Yy7nnCWXvOj1Msv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e818bb-93d0-4775-e808-08db314bb5c6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:22:24.6562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMFvxY0cW99KH4ALEsNqR9nurcf9WAAFABPWU4F2AYOkVOUZa6f3tnNahg9JMo/NfY5rzUpvh5pdnltz5ajJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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

CgpPbiAyMDIzLTAzLTE2IHAubS4xMToxNiwgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IFRodSwgTWFyIDE2LCAyMDIzIGF0IDI6NTXigK9BTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4+Cj4+IFJlbW92ZSB0aGUgaW5saW5lIGtleXdvcmQsIGFjY29yZGluZyB0byBr
ZXJuZWwgY29kaW5nIHN0eWxlIFsxXSwgZGVmaW5pbmcKPj4gaW5saW5lIGZ1bmN0aW9ucyBpcyBu
b3QgbmVjZXNzYXJ5IGZvciBzYW1sbCBmdW5jdGlvbnMuCj4+Cj4+IEl0IGlzIHZlcmlmaWVkIHdp
dGggR0NDIDEyLjIuMCwgdGhlIGdlbmVyYXRlZCBjb2RlIHdpdGgvd2l0aG91dCBpbmxpbmUKPj4g
aXMgdGhlIHNhbWUuIEFkZGl0aW9uYWxseSB0ZXN0ZWQgd2l0aCBrZXJuZWwgcGt0Z2VuIGFuZCBp
cGVyZiwgYW5kCj4+IHZlcmlmaWVkIHRoZSByZXN1bHQsIHBwcyBvZiB0aGUgcmVzdWx0cyBhcmUg
dGhlIHNhbWUgaW4gdGhlIGNhc2VzIG9mCj4+IHdpdGgvd2l0aG91dCBpbmxpbmUuCj4+Cj4+IFsx
XQo+PiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y2LjItcmMzL3Byb2Nlc3MvY29k
aW5nLXN0eWxlLmh0bWwjdGhlLWlubGluZS1kaXNlYXNlCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZl
bmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPgo+PiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amly
aUBudmlkaWEuY29tPgo+IAo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+IAo+IFRoYW5rcwo+IApIaSBNaWNoYWVsICYgSmFzb24KICAgICAgICAgQ291bGQgeW91
IHBsZWFzZSBoZWxwIHRvIHRha2UgdGhlc2UgcmV2aWV3ZWQvYWNrZWQgcGF0Y2hlcyBmb3J3YXJk
PwpUaGFua3Mgc28gbXVjaAoKCj4+IC0tLQo+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMgfCAxNCArKysrKysrLS0tLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiBpbmRleCA0MTE0NGI1
MjQ2YTguLmEyNmZhYjkxYzU5ZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+IEBAIC0yMzMs
OCArMjMzLDggQEAgc3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEp
Owo+Pgo+PiAgICNkZWZpbmUgdG9fdnZxKF92cSkgY29udGFpbmVyX29mKF92cSwgc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSwgdnEpCj4+Cj4+IC1zdGF0aWMgaW5saW5lIGJvb2wgdmlydHF1ZXVlX3Vz
ZV9pbmRpcmVjdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHRvdGFsX3NnKQo+PiArc3Rh
dGljIGJvb2wgdmlydHF1ZXVlX3VzZV9pbmRpcmVjdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2
cSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgdG90
YWxfc2cpCj4+ICAgewo+PiAgICAgICAgICAvKgo+PiAgICAgICAgICAgKiBJZiB0aGUgaG9zdCBz
dXBwb3J0cyBpbmRpcmVjdCBkZXNjcmlwdG9yIHRhYmxlcywgYW5kIHdlIGhhdmUgbXVsdGlwbGUK
Pj4gQEAgLTM0OSw3ICszNDksNyBAQCBzdGF0aWMgdm9pZCB2cmluZ19mcmVlX3F1ZXVlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCBzaXplX3Qgc2l6ZSwKPj4gICAgKiBtYWtpbmcgYWxsIG9m
IHRoZSBhcmNoIERNQSBvcHMgd29yayBvbiB0aGUgdnJpbmcgZGV2aWNlIGl0c2VsZgo+PiAgICAq
IGlzIGEgbWVzcy4KPj4gICAgKi8KPj4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IGRldmljZSAqdnJp
bmdfZG1hX2Rldihjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPj4gK3N0YXRpYyBz
dHJ1Y3QgZGV2aWNlICp2cmluZ19kbWFfZGV2KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxKQo+PiAgIHsKPj4gICAgICAgICAgcmV0dXJuIHZxLT5kbWFfZGV2Owo+PiAgIH0KPj4gQEAg
LTc4NCw3ICs3ODQsNyBAQCBzdGF0aWMgdm9pZCBkZXRhY2hfYnVmX3NwbGl0KHN0cnVjdCB2cmlu
Z192aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgaGVhZCwKPj4gICAgICAgICAgfQo+PiAgIH0K
Pj4KPj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBtb3JlX3VzZWRfc3BsaXQoY29uc3Qgc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEpCj4+ICtzdGF0aWMgYm9vbCBtb3JlX3VzZWRfc3BsaXQoY29uc3Qg
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4+ICAgewo+PiAgICAgICAgICByZXR1cm4gdnEt
Pmxhc3RfdXNlZF9pZHggIT0gdmlydGlvMTZfdG9fY3B1KHZxLT52cS52ZGV2LAo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LnZyaW5nLnVzZWQtPmlkeCk7Cj4+IEBAIC0xMTcy
LDEyICsxMTcyLDEyIEBAIHN0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4+ICAgLyoKPj4gICAgKiBQYWNrZWQgcmluZyBzcGVj
aWZpYyBmdW5jdGlvbnMgLSAqX3BhY2tlZCgpLgo+PiAgICAqLwo+PiAtc3RhdGljIGlubGluZSBi
b29sIHBhY2tlZF91c2VkX3dyYXBfY291bnRlcih1MTYgbGFzdF91c2VkX2lkeCkKPj4gK3N0YXRp
YyBib29sIHBhY2tlZF91c2VkX3dyYXBfY291bnRlcih1MTYgbGFzdF91c2VkX2lkeCkKPj4gICB7
Cj4+ICAgICAgICAgIHJldHVybiAhIShsYXN0X3VzZWRfaWR4ICYgKDEgPDwgVlJJTkdfUEFDS0VE
X0VWRU5UX0ZfV1JBUF9DVFIpKTsKPj4gICB9Cj4+Cj4+IC1zdGF0aWMgaW5saW5lIHUxNiBwYWNr
ZWRfbGFzdF91c2VkKHUxNiBsYXN0X3VzZWRfaWR4KQo+PiArc3RhdGljIHUxNiBwYWNrZWRfbGFz
dF91c2VkKHUxNiBsYXN0X3VzZWRfaWR4KQo+PiAgIHsKPj4gICAgICAgICAgcmV0dXJuIGxhc3Rf
dXNlZF9pZHggJiB+KC0oMSA8PCBWUklOR19QQUNLRURfRVZFTlRfRl9XUkFQX0NUUikpOwo+PiAg
IH0KPj4gQEAgLTE2MTIsNyArMTYxMiw3IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc191c2VkX2Rl
c2NfcGFja2VkKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+PiAgICAgICAgICBy
ZXR1cm4gYXZhaWwgPT0gdXNlZCAmJiB1c2VkID09IHVzZWRfd3JhcF9jb3VudGVyOwo+PiAgIH0K
Pj4KPj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBtb3JlX3VzZWRfcGFja2VkKGNvbnN0IHN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxKQo+PiArc3RhdGljIGJvb2wgbW9yZV91c2VkX3BhY2tlZChjb25z
dCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPj4gICB7Cj4+ICAgICAgICAgIHUxNiBsYXN0
X3VzZWQ7Cj4+ICAgICAgICAgIHUxNiBsYXN0X3VzZWRfaWR4Owo+PiAtLQo+PiAyLjM0LjEKPj4K
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
