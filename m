Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53A2C7EE26
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 08:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F3D981F1E;
	Tue, 23 May 2023 08:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F3D981F1E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gIpbQWNY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aAKI0lKnyUL1; Tue, 23 May 2023 08:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E771581B7B;
	Tue, 23 May 2023 08:38:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E771581B7B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66EC4C0035;
	Tue, 23 May 2023 08:38:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88E3BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31EEA418A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31EEA418A1
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=gIpbQWNY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3eOTY_cCVNRe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:38:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E44DA41604
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E44DA41604
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrxNI3AczfoT/8y4bdJ6oEhHIF7tE1gSmA+0wfwtNWmvb+0zhbaNrAnWz6dTbvfoc/T24RfDqwssxHq6GcNhbuAs+c+clvD5MNiIlguYUC72WEHzxW2ZCe2ppWAl6JdgMsiLNApqkYNLhsMqN481UU8U7i0Xf4Zl2qSvvLbz26E/q2sntiR522oNCuVtBF1CIGxkshIp8fXKZUEqXDuQc6+jlTPCr3mvAYIl+JL9GQz+/dwK8oEcE+NlAu5+gTg9dFVWMAeyBEPboODAOI3eqje5AS8XiRI438qOKqCckYRAT5xOmOkc4bSih0lTxBEzYuRF3tKNIv8U2c2Nj0zu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqQNOTVkEi1jwn8fG6FEgaGrhKLiXOj5LlZKUg9SShs=;
 b=X9mq08+N+cw7eGPuQnJe6wzuMrl7Sqg64QWXDvdS4h3Crc76rvq+/KgxegtEOp6MFz7KfF7mWJ/YMAcoayAtZbz5iEujLjaCo/9AewOzZBqncRFz47O87hLPj0cZ0OMb5moDPFZhfiZZANI4RE0NQCiZKhc1eo7LcqE8aXikCzvL7WwfNlxwoxL2DbXpeCZOhu0V/A9d4D5JsAueR7L+CZzjFhKTgJCO/nfmpLUo+5txQyN2C/3+wFE8u3JCkkVYZ0QtYwJbYq5MxdW6jdQKZtnWqQTBbW5ingwZeI9MWG5ENghx+ZI3Qodg1kiDEOqCOEXP4qNcihU/+JIvGknDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqQNOTVkEi1jwn8fG6FEgaGrhKLiXOj5LlZKUg9SShs=;
 b=gIpbQWNYhUYt+4WrMcKz206LioUoY5NyNSY4hOiH9cn4384iTXpKgNwcdab45o/Wk2+pGNX33LmWen9WjrYU16Qvz25Ls46tp3zvp8vJfMj1afyXRL8LD/iSmEYh6nLaurKDFVrB52Y+F0LkXvhHOLV5uxr23czUQWO9ONB/FM6GiiJ6Kv5CFPljh6N4jw8AHM5N8yxceddSgZCUk2BrIf1SKaOE+buUAjukZ1njulyrAekWMpMKHoolN2fHV5GV66MqsjtGzPtGz0qsPn19oY+5SXYn16WrizXZvzJoMxsfh3Y5Gy9R+dI60UFNh+EQ+mCea6kAxqQIY2NO3iQdxw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:38:47 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:38:47 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: vhost stable branch
Thread-Topic: vhost stable branch
Thread-Index: AQHZjUaQ6njl1MGLGE2KPtgjGhYoLK9ng98AgAAFjQA=
Date: Tue, 23 May 2023 08:38:47 +0000
Message-ID: <32fcc93a6c41abb17cabcf44add12fcabad34366.camel@nvidia.com>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
 <20230523041714-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230523041714-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA1PR12MB7542:EE_
x-ms-office365-filtering-correlation-id: d1c6c0f5-95dc-4939-902f-08db5b69204e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1EVX9K+VVXcqR8VrJ5g3uy9SPNIggYn2dkYz7WnaCDldvq/NxnQfRQce9/FjKY2EtMIaHtYjfJVWG+i7gDaOIjIa+0W45PrigYFR1HZR2sYuOq75hWdHnA04YOVCJVFw6r3p60/6pBsTIQr8ZurOvWJKY8fsTdW4d87kQh7frkEWSBaj30YB9SXJOTh73/e4RXmiqQPl1UywkKJDFBOgbI1UBuM5kLX/cp5w0JOGIP4TOcRX/b40pZ4gG0JoKd5gUnFuTifhf9jxik787j650JNJ0Ad8IzFpyeQnp9nq7/AG/reCnR8IhhLAWXvpBocZA3y0DfljuVpvMp9aR4390aaGGnDpubDidvxiZAVMTVeHSLSeuMFySM95DpbxdZ5C4mEuexiWBzF26mitYnrD3DlmaUS6Y9PXH0W9AenPAgQAxychhWuXSSz80oAIKfQZ4k1+njuXuO5wDD4hRWlT6Xv0l1Q1FTgZBfVG9Qd+0LysjPZnTnD53aNYOrjsWHJHxtq2ZSXIy7jDEgiajFBOz+JNJYlLmPMp9Q2klOmuCloeSnvwyXh0RtCiTFfgNZJWuPsx/AHmh4BJ+EFTSmJb6CaMH1BnH3LsMC03iLRq1c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(2906002)(4744005)(5660300002)(7116003)(8676002)(8936002)(41300700001)(66476007)(4326008)(76116006)(91956017)(66446008)(66556008)(6916009)(64756008)(316002)(36756003)(71200400001)(6486002)(966005)(66946007)(478600001)(2616005)(122000001)(6506007)(86362001)(3480700007)(186003)(6512007)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3BvRFRzNmd6QWlIZ3BNcFpQd3JCb2hxemZVcWk0RytHTFhyaCtXdHh4MVhB?=
 =?utf-8?B?STNiRVR2OGV6M1NQciswMFFMc2RWdW93NzBlaERnb284TmV4djdhalY4aHRx?=
 =?utf-8?B?MXRLRTNSbVVsWW9vUzF0UWFzMXp4R1d2Z1RGdHRySGx6YS82SGlablR1Q29p?=
 =?utf-8?B?bHducEdqVWYvL24xeVEwVUxMOGcrSmt1Z2xsS2JBUnJlMWowbWxKWFNKOWFH?=
 =?utf-8?B?d05JQUV2THFGa09tV1N2YXhNS3kvVWp0bEdlWlN1QVRhVzljbE0vTFFBTElQ?=
 =?utf-8?B?QlhhdUlpaHp4QVB2SUVodXJsNjh2WldvMG1FbDFIZGQ2dHY1dEt6Z1R0TTZJ?=
 =?utf-8?B?TlpwNTZMMElPUERzZ21Bbzl1dngvU2J2am84SlpPK0ZUV0ZIbVV0RWNVWVVJ?=
 =?utf-8?B?NWRDZWoxKzBmeHorQ1YzU1pSMDVvUlZILzFLak9mZTA5RGQ2SkEwUHRXQUdy?=
 =?utf-8?B?WCtmNTFUdmlqOXU1OElSM2FlcDh6b1Y2RkY1VzBCa1VaZERESkdYMGdZbmN5?=
 =?utf-8?B?d1dWMWJRVFRlNGlyUlFKcFR2ZTVOZjRQMEF3ajJjcTEzdThDNmYxSWZXUktz?=
 =?utf-8?B?eU5zajFBMUJINWdGeDN0K2FKL3J2YlRYcDQ0RExxc21UQk1IWkc5UDc3VzE4?=
 =?utf-8?B?WkFPd0l6SmVkTDNWUVBtUWNJQVlvMUU4WElSSTAyQlNoVlNiSlcvcWJNejcx?=
 =?utf-8?B?cTg0c1lSTXZNK3lweE4xUmRQcG1SaFBMelBVUmh4R1RlQmIzWGVCNW1KRncw?=
 =?utf-8?B?NkJTaWFJaXAwZ1Y3ZXkzUTM4a3FqSW5zV0JnN2VLM2d4dXhXMjhMZmdUZ0k1?=
 =?utf-8?B?WUcwdVh1NjNKbFB4UHlHODM1NEgwdzVFRWhCSStTa2oyWDBUQVFBYXNpa0cr?=
 =?utf-8?B?VXRXSmpTcDJTWVVqRGlHWTRKWjBlejhsbXY3aWFXMXBUa09tMGZ5djNJMGxH?=
 =?utf-8?B?Z0hsSS91S2M3dmJMTU9qU1plSDBNZ2pDc2JNT3lhWjhBbFpjOE1nNGUzOGdP?=
 =?utf-8?B?Q0tqdmVWaStMQ1ZGcjFlbUp1Q2FBOHZDT05iOWc5TEQvbkFOOTlaYlV3UWdN?=
 =?utf-8?B?QTRJS2QyMGJPY0IxUDFqeFJzNVUwazloenV6bUdyYTNGV3Uxb2F5NjZGVG5k?=
 =?utf-8?B?dEEwcDEwSGcwT3BxRGhNUHVEZzgyR1NIQllDcnJjakJmNEVxYjUyZndCRmdq?=
 =?utf-8?B?MjF6UVJsL283MHd6cHd1S1pTYjZuVkZyUzVHUUp0d0FlYkRIY1pub3hHSlhH?=
 =?utf-8?B?RW1Ya0hhVlJOZU52UmtvbVRJVWFRZGdpKzE0ck5tbmU2TDhiZ3RoWjd3cUgy?=
 =?utf-8?B?R3AzdCtPMzNITzNFYk8xQVJBVWVWZWx0TUNTbXdlM0NhNElJdm51dThVZEUv?=
 =?utf-8?B?RzBuNTVXcm9tckR5MTQ1TlJZYis2Ym1NTkhpN3QrNVhsSjV3TjlrTkZVTlFN?=
 =?utf-8?B?MER2M083Z3JBRGtSRURxaVovdXF1eE9WNXNmYnNpRTFhakNPRjRvbWcvRlNo?=
 =?utf-8?B?MklWR1Y3aVk2blR4dnVRL0dRYzM3dDhKOXJvVlNYaUVYemx5MkFEM0ZxRU1h?=
 =?utf-8?B?bnIwL2NnejFqZlpMQklZZ2NVZFRPbU1BSGtDMVZKckMrMDJuaytVb3F0QWJ1?=
 =?utf-8?B?OXNrWFYzS0V3WUdsTkVpcERRQzBJYzBZckVKZytYZ3FnMzZuU1JqNGQ1Vldx?=
 =?utf-8?B?K2lOVnhHM1lnZzNITGtxeHBqWkg2Um9KRlZoQUNtK2NOUjJtKzZaYzFTbERl?=
 =?utf-8?B?dEwzVllxbXJFWlRhUmRQb0EvMDdmY0VNRityTjdRRmFXa3hiOVQ1VmFybm96?=
 =?utf-8?B?NXBEZ3pNQVdrMHJNR2h2bzYrcjBiUnlBc3ExclFQQmh4RHVvWVhmRHhJYXhR?=
 =?utf-8?B?YVQyZ3dFY3ZyNmVBdnZDOEVKdkdjYzNPbldQV2dObFVLTTVOcW85LzFHV1cz?=
 =?utf-8?B?Nk00ejJicU90MXAvc0JSOXZ4ZWRwKzFpU0RWTHRpbDJGVldWbkRadnI0L3Vi?=
 =?utf-8?B?bnZXSHRobldzZ2l6TW9ha2pqL2VSaUJKWGl6NWgvK29TckxQZUpZd0NKQVRH?=
 =?utf-8?B?cmYrSGhNSS9rSXVGV3l6dDhvcVZJTnc4bndjSFlHVFhoU0xoRG9NaFlUTUxY?=
 =?utf-8?B?K0wvZ1FxVWgzYkFJOFhFOHQzT2VjOW10WmZnL20vTzNxYTRUNjlEajlDdmJk?=
 =?utf-8?Q?wQDjLShUIE/+L/oTTmulLDknggsfVY6sGrdEiH5u6+WL?=
Content-ID: <856C449BAA52FD4490A459A69D978370@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c6c0f5-95dc-4939-902f-08db5b69204e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 08:38:47.4423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: duYWCE15ImTqFxXfJ9LESAqalHxVXQvj2NZnKnhhRngzaSdtVWjf9FNRPH8uG88GyzgSCecUi2j8jYYcMolotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 2023-05-23 at 04:18 -0400, Michael S. Tsirkin wrote:
> On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> > Hi,
> > 
> > I am looking for the stable branch for vdpa fixes in the vhost tree [1].
> > There
> > are 3 branches that seem identical: linux-next, test and vhost. linux-next
> > seems
> > to be -next branch. Which one would be the stable branch?
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > 
> > Thanks,
> > Dragos
> 
> I don't publish one until I am ready to send patches to Linus.
> Which should be today or tomorrow.
> 
Understood. Is it the same with patches for -next? Are they published only once
the patches are sent to Linus?

Thanks,
Dragos

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
