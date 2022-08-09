Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D383DC25B06
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A6EC60DFF;
	Tue,  9 Aug 2022 21:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A6EC60DFF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dmMPP9F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mE1ekUT4hPL; Tue,  9 Aug 2022 21:13:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D4D760BCF;
	Tue,  9 Aug 2022 21:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D4D760BCF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E93EC0032;
	Tue,  9 Aug 2022 21:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6912CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEFA260DB7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:13:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEFA260DB7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E9pLxc_8DAL0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:13:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3924A60BCF
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3924A60BCF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXUgqFPFoHJqnOiKt6o5HadHPbsIa/dhcF8vc4iwsxhv4maapimUDY2K4t2vosfKegc6lutudI5nXIRmHUHfaYqTQ+8TQC+mLlAcnUtiviBZ1ixURu1d4uxCpmCn/vXeha8hb6vndNRrhAe7a7B9gw0nyPtNMXyVgHb9/JgE4ZeiHTsqzNEc1Fh2DrQM7W2eWdqjyjpLwcgB1R3gMuLnWQ1gp9QeLxFt1hVGc2leQhkVPGm7fAusuK8qexFjt35Fy6kG9wmjeDIqn9HtDwkJzRWrqzRqU468FyFCEhK37w9lxzmGy3sE94dEWOV2ZK6qoSBdv+VODeqdKUqs5ytgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZlv28htwVsLSvzouUt71/wP9RDpy9dcBqJoaEKEygQ=;
 b=PhoIYtyLoBloo9UYHxAdgeXuLughmmDuKF7mFi01bjt7URK/QoL4hQLrtz8s4ayL4nqC1LtF7AqyAhsPho2UKBIppdsFbAD6eI/DBs9prO9jfUM07QeOR4Q3kf9yzQZZJNOWfxk/i25W5ZUNf29VRLzQ58qV2tAs3Cw/o3yjmMvV8Yko2tpy+KhaV3cibVrdIsukKqeeD2Ev0+pTtxc9o8/IN2WkmFC2EMG7xSPM+Zum6/fNsERoaa+8yKDmpWF7ioOYBBzx6LW+wUaMvgRwgZ9UvQZIym70u18ajZNsVxnVpa7UpqKUTf7ilzocYsGXiAt0VPnbLifVU0voj2g4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZlv28htwVsLSvzouUt71/wP9RDpy9dcBqJoaEKEygQ=;
 b=dmMPP9F9txnCSZn2c7aTYqcYlxsPun2A81NPM+ef14eVIERnaZPLuMvdrBkR5Wss7QkEItSf5HlUQlJMveZyBiv2h4wvygQCUxIjTBWIc1Pr7aJTkZNXMfDv+BitA8KWb6IWuGeFVRiBe+W0rg1ytGEqXpybm1lO0of4MaUYvcCv3KDoSIIC1+M/Te+oQ7yaKMyW0ztfMFC81K7DpeuZd8hGzeGGYJ6SXTkqD63ah2nISJmyGg//m5Z68mg4hPXQqgIJ/xl5FKQ27KwELJUGtPsE+76YnbKNwDjKjgHBbLP8cjSHmGmIudBB1EXEmbzX5RCw1KFaObbSqfKxBhhHiQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BY5PR12MB3940.namprd12.prod.outlook.com (2603:10b6:a03:1a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 21:13:43 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:13:42 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>,
 Gavin Li <gavinl@nvidia.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUIAAFuOAgAAKk+A=
Date: Tue, 9 Aug 2022 21:13:42 +0000
Message-ID: <PH0PR12MB5481B4552000CF20B0F73B4BDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
In-Reply-To: <b4fc5098-ec90-01f6-5c96-abb2632e58c7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 620fc7a1-d2df-45f3-82b1-08da7a4c09ef
x-ms-traffictypediagnostic: BY5PR12MB3940:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQbkMQqXuPS17TD0q9WUyg5kyKUZzpHmR3HsEJy8DcF9bWZmbQT/g4E+sRPwB0ffb1Oaf4skMYI+TMBkAgCSYx7suYSI4r/ByseDRwLlFrz5+CenP/0WaEtq/74rJwuPjymYocRgOYY5Le/V223bOGmF8cpC8qLTptvySci63pE0bITQyyXQzJYXqpRP5jCUyENMsJSXbEU0jxP6vorIyxPf+qlQgeq3uWWQ1vO1NE19Syq+zTb44MnV8KAdwXlyYWVqrKHEwSOTfdrJ5r2ypq7LaSTDJU8uoWSNAY7GuTx4aQG16nzJuzOJCRI2YYt7ysWQ2y4Bl3Vs2BaQJAEsGUHSashmyY765mMJgWrXcsv/K0F/AIhdefUuteqDkS0/LYAuKXtlxeBikOpRODBh6l3XkZnh2q9Sgxn9gW2q6EPpct0nEjY7h4W7AzjsuIuoM60DUtzZwvZPoVnr4cQkE7cMW9WzSzZ1U3v91O/4YDrTkiYHG7U257o0TrIeBfJdHLmmlvSXj9QX8hrt27j9iHAvncmZFcZRX1h/9HsyOgJjw6msc+rcnCr9lfPlaLFiFfavyCt0C3As+UFNd8Prgv1RyNJZdfw3kH7S12VP00mvRQ7vkFHJGaLX+2mCsr5rjzX7HCq0GVe3kW62Z/rg10zkYcsGDMZO4JdI0OCOPgy290Ie3YdyWSTkWGIlQbgIRzT1SBsj9vsK5bMlRPYbYrMf8U5pDVQAROZV17MvBzf+uxbLpwsluh66EGvCDmsrULoIOBQCY5vnnSpK6Cts8MfEDOqLgL+hDI6AO1RqHghMVRX2YMCNJrqTcfvdSphT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(8676002)(66556008)(5660300002)(66446008)(64756008)(66946007)(66476007)(316002)(4326008)(6636002)(76116006)(55016003)(7416002)(8936002)(52536014)(38100700002)(2906002)(54906003)(122000001)(86362001)(33656002)(38070700005)(41300700001)(26005)(6506007)(71200400001)(478600001)(7696005)(110136005)(9686003)(83380400001)(53546011)(107886003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTlNUkJhK0xnS25td25EK2Y3WGQxVFJmNlpWbVR6WExNYS9ZTUdHcjNCZnNI?=
 =?utf-8?B?eFUrOEF4cXhsRXJiLzlVU1FYd3JwRSsra3pFZ2tSeERkTHdNQ2FVbXpLdlFJ?=
 =?utf-8?B?TGhDSFNhR0ZOM2FOcHZMZm9CVkpnNlc1WFd0TURFdmI3dXJob0ExYVNTdkN5?=
 =?utf-8?B?ejJGOFovVGx3VWlWWUlIb1JLQ3RJWHFZbDllaWJTbWt2bmlsdUN1UkNjUkhp?=
 =?utf-8?B?TG9aQStKd3QyZS9SYnZsUGJzblZGVk1waTVzWFUvZDJJc1dnSmR1WHlVbUsz?=
 =?utf-8?B?ZEp2dlRPT1NRRXlzRjF3eXR6SE83aUhVcXh3aVlMejRwZDhFSWR6NXFRbGJV?=
 =?utf-8?B?SWI0UWU3RjFWQ0EwRzQzL3p0azl0RFZjcFJPc3ZWMVdTZ29hQ3c3U0tRQ2p0?=
 =?utf-8?B?dTFVbXhQNjVFb3NacmU2OVc2VDVGbGxVaVFaeE5vYUxwSTAwWkJicXdUYXAy?=
 =?utf-8?B?Z25QVzMxWjhQcGtjY0RFWUVLdC9GbXJ5M09YWktQYTcyaFI4SHA5RjZGTjgv?=
 =?utf-8?B?eTFKQVpiTFg2bU0vd1BDTWRnMVFiejM3bnd6ZlAzRHNpVWVlRTNsVTRJTFJS?=
 =?utf-8?B?R2ZTMzFOeHNYNDdwTUVLU0JPSis1L2g1d0F0czZQK0d4bmozTFFMVGQ4R1Vq?=
 =?utf-8?B?Yy8yZXMxMWE4NUlDYWFtdTErVWNZN29acGtSRkVFS1MrRFBpRnhtVlNta3cr?=
 =?utf-8?B?S3JvSkdURUREZW9ycmYrT2RmZzBRbTRDTUdqOUVEUk94Q3NTU1RZcGRRQzNm?=
 =?utf-8?B?M1UzMnp3MHl1OXk1SnRuampiYmFoNUdLc0pjVXcwYURpVjZRZEpDallwNTBZ?=
 =?utf-8?B?Tk0xSnQzMFpVZkJGakl2c0w1dXR1ZXFKVXhBS1FxSW53c3dzYk5TNUhWcUxM?=
 =?utf-8?B?Y1JWNWlkTHdFOXdRK09qUjhiWlB3dGl1VzlENkwrb2FNY3Y5a3Y5OEI3TDYw?=
 =?utf-8?B?by9BZGVBY2ZXUUJsUElQdzZBRFZrMllWQUJMMFRiMUF1SVNyUmtKWVNSWFRw?=
 =?utf-8?B?cEZ0Z1JaY3RHMWFRVzB4TmFNNVVqaE9RSUg5T1p2blhjMG1XNG5WMzFmY1Vm?=
 =?utf-8?B?aXVDOGNRQkE1dFRRTjZJVTY1VkFxaFQ5NHJRaktYMThPWkFnL1d6aTVkYU84?=
 =?utf-8?B?RVV4MVgrcFpobzNBeDJCYlBkMHNEeHVqQnA0ay90dS9zN1lMcDNUREQ5ayt5?=
 =?utf-8?B?UGwwV2ZZaTFVdmZLTWVlKzJXVTlBaE5vVWFRcGQ1NlRtZ0lWUWlvUGFuYUc4?=
 =?utf-8?B?YVlQT0pHVzlZL0FLRHhUUmI5Q3NJQno0enZOM0xZM1A1MVc2dGRua0ZuRjJs?=
 =?utf-8?B?SzQ0L3hXNXcvYTV6MFY5N1Q2U2JxRzJYWSsrV0tBVmg4N2lSMUN3VG4yTkNl?=
 =?utf-8?B?UVRhdE9sRTRlUG11L0pRejJPVXpaWldwM3ZDVlVhTUg1dDFRYUx6akc1UTNL?=
 =?utf-8?B?WHY2Z0pjU2E4NklJbTV2VmhWekdUOXFRZWVteXpBSm43QzJMcWJ5eUxaL2ZN?=
 =?utf-8?B?cXVsZjhhcm5KNFVZeEhISkhKVk5OQTJIZlY5dlorbEp6NHNRU1R0aTM5Rllq?=
 =?utf-8?B?a0xzYmVPdGF2ZlA3YXFHVDFSaEFKMnl0QmV0NmxxaUROTWZ1aWJCV09temtz?=
 =?utf-8?B?UVNGUnpwUmpmYkVQZThvdWRJc0RRVFFERnpmWWpJczY0UmM5cGtabzRyS1Ax?=
 =?utf-8?B?eElNN2lLR2tCaGlRWXZ4SjBNODJPT21zZGs3aENVNy9Gd3RoUGpDRkhxOVZ5?=
 =?utf-8?B?NEVHU24vUHRMMlMyYndsQ2I3dFpLdFNEeTlBK1Q3ZXFxU1ZISDRBcE1KOG1x?=
 =?utf-8?B?eEFOZnM2cWtBT2JwR0VqamVVY3A0MFdpMlQ2QXdtNG5PNTd5R09mRktEZVRj?=
 =?utf-8?B?bVlBRmpxV0JjTVlVQ2QwT1Y2SlVEMFJaRDd4NEJiZ2wvbW1NS0hhUFVuZ3VP?=
 =?utf-8?B?aG54WFN4U2lQWkF3eXo3ekRzT3dUcUVtN21RanJESnNVaUV3YWNnaE5OQjd6?=
 =?utf-8?B?MFY0YW1nSTI4RTNNL3diU3VSY0ZIdGtZT3c3bmQxM0lKck1sNnF2WDZ5bkxr?=
 =?utf-8?B?S2xsMWxHWXJpY3hWMHdKNno2QUpCWUFGTmpkbzQreTNHSlhneUtDejlsV1BS?=
 =?utf-8?Q?8Ito=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620fc7a1-d2df-45f3-82b1-08da7a4c09ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:13:42.8672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BquTX4zz4uP4b/ykubCLaNn+FkzCdjuy0lfrwCmUmoRVNB0FTxHOppOmXgHL0HYPpzoCePBl5NaXy7IyJ9gcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3940
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCA5LCAyMDIyIDQ6MzMgUE0NCj4gDQo+IE9uIDgvOS8yMDIyIDEyOjE4IFBNLCBQ
YXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXVndXN0IDksIDIwMjIgMzowOSBQTQ0KPiA+
Pj4+IEZyb206IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4NCj4gPj4+PiBTZW50
OiBUdWVzZGF5LCBBdWd1c3QgOSwgMjAyMiAyOjM5IFBNIEN1cnJlbnRseSBpdCBpcyBub3QuIE5v
dCBhDQo+ID4+Pj4gc2luZ2xlIHBhdGNoIG5vciB0aGlzIHBhdGNoLCBidXQgdGhlIGNvbnRleHQg
Zm9yIHRoZSBldmVudHVhbCBnb2FsDQo+ID4+Pj4gaXMgdG8gYWxsb3cgWERQIG9uIGEgTVRVPTkw
MDAgbGluayB3aGVuIGd1ZXN0IHVzZXJzIGludGVudGlvbmFsbHkNCj4gPj4+PiBsb3dlciBkb3du
IE1UVSB0byAxNTAwLg0KPiA+Pj4gV2hpY2ggYXBwbGljYXRpb24gYmVuZWZpdCBieSBoYXZpbmcg
YXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0bw0KPiA+Pj4gMTUwMA0KPiA+PiB0byBzZW5kIHBh
Y2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2ZSA5SyBwYWNrZXRzPw0KPiA+IEJlbG93IGRldGFpbHMg
ZG9lc27igJl0IGFuc3dlciB0aGUgcXVlc3Rpb24gb2YgYXN5bW1ldHJ5LiA6KQ0KPiA+DQo+ID4+
IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1UVSBhbmQg
TVJVLCBpbiB3aGljaA0KPiA+PiBjYXNlIHRoZSByZWNlaXZlIGJ1ZmZlciB3aWxsIGJlIHJlZHVj
ZWQgdG8gZml0IHRoZSAxNTAwQiBwYXlsb2FkIHNpemUNCj4gPj4gd2hlbiBtdHUgaXMgbG93ZXJl
ZCBkb3duIHRvIDE1MDAgZnJvbSA5MDAwLg0KPiA+IEhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1Y
dSB0byAxNTAwLCBzYXkgaXQgaXMgaW1wcm92ZWQgdG8gcG9zdCBidWZmZXJzIG9mDQo+IDE1MDAg
Ynl0ZXMuDQo+IEZvciBiaWdfcGFja2V0IHBhdGgsIHllcywgd2UgbmVlZCBpbXByb3ZlbWVudDsg
Zm9yIG1lcmdlYWJsZSwgaXQncw0KPiBhZGFwdGFibGUgdG8gYW55IGluY29taW5nIHBhY2tldCBz
aXplIHNvIDE1MDAgaXMgd2hhdCBpdCBpcyB0b2RheS4NCj4gPg0KPiA+IERldmljZSBkb2Vzbid0
IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29uZmlnIHNwYWNlIGlzIFJPIGZpZWxkLg0K
PiA+IERldmljZSBrZWVwIGRyb3BwaW5nIDlLIHBhY2tldHMgYmVjYXVzZSBidWZmZXJzIHBvc3Rl
ZCBhcmUgMTUwMCBieXRlcy4NCj4gPiBUaGlzIGlzIGJlY2F1c2UgZGV2aWNlIGZvbGxvd3MgdGhl
IHNwZWMgIiBUaGUgZGV2aWNlIE1VU1QgTk9UIHBhc3MNCj4gcmVjZWl2ZWQgcGFja2V0cyB0aGF0
IGV4Y2VlZCBtdHUiLg0KPiBSaWdodCwgdGhhdCdzIHdoYXQgaXQgaGFwcGVucyB0b2RheSBvbiBk
ZXZpY2Ugc2lkZSAoaS5lLiB2aG9zdC1uZXQsIGJ0dw0KPiBtbHg1IHZkcGEgZGV2aWNlIHNlZW1z
IHRvIGhhdmUgYSBidWcgbm90IHByby1hY3RpdmVseSBkcm9wcGluZyBwYWNrZXRzIHRoYXQNCj4g
ZXhjZWVkIHRoZSBNVFUgc2l6ZSwgY2F1c2luZyBndWVzdCBwYW5pYyBpbiBzbWFsbCBwYWNrZXQg
cGF0aCkuDQo+ID4NCj4gPiBTbywgSSBhbSBsb3N0IHdoYXQgdmlydGlvIG5ldCBkZXZpY2UgdXNl
ciBhcHBsaWNhdGlvbiBpcyB0cnlpbmcgdG8gYWNoaWV2ZSBieQ0KPiBzZW5kaW5nIHNtYWxsZXIg
cGFja2V0cyBhbmQgZHJvcHBpbmcgYWxsIHJlY2VpdmUgcGFja2V0cy4NCj4gPiAoaXQgZG9lc27i
gJl0IGhhdmUgYW55IHJlbGF0aW9uIHRvIG1lcmdlYWJsZSBvciBvdGhlcndpc2UpLg0KPiANCj4g
VXN1YWxseSwgdGhlIHVzZSBjYXNlIEknbSBhd2FyZSBvZiB3b3VsZCBzZXQgdGhlIHBlZXIncyBN
VFUgdG8gMTUwMCAoZS5nLiBvbg0KPiBhIHZpcnR1YWwgbmV0d29yayBhcHBsaWFuY2UpLCBvciBp
dCB3b3VsZCByZWx5IG9uIHBhdGggbXR1IGRpc2NvdmVyeSB0byBhdm9pZA0KPiBwYWNrZXQgZHJv
cCBhY3Jvc3MgbGlua3MuDQpPay4gU29tZWhvdyB0aGUgYXBwbGljYXRpb24ga25vd3MgdGhlIG10
dSB0byBzZXQgb24gKGFsbCkgcGVlcihzKSBhbmQgaG9wZSBmb3IgdGhlIGJlc3QuDQpVbmRlcnN0
b29kLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
