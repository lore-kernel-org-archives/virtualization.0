Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85392C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 03:59:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9E064E7C
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 03:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9E064E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6603E431E1;
	Wed,  3 Mar 2021 03:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYoygydB2v79; Wed,  3 Mar 2021 03:59:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA0AC43192;
	Wed,  3 Mar 2021 03:59:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4C30C000B;
	Wed,  3 Mar 2021 03:59:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A81CC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 03:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0EA9838C0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 03:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tn2rsvLya2NF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 03:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDA8483478
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 03:59:52 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603f09b80000>; Tue, 02 Mar 2021 19:59:52 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 03:59:51 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Mar 2021 03:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLSKCnMJ/uwZMDTOM4UVmifszKt7OKROCA10ia/iAckGmtI6zHtl1NE4yzDIgk+pPzI8SYGhm667vyUuWN5Cf3zQwO2olQF7QXeTg16FQ2MKXN0YiHhP+0Mq0Rz6C0I+jQID9QylMmthY5jx4jlAxysRQLWmPjQ/H0YKg78H2AEVWGmg80E9J1Ae/oo7xwsm49nAghmh4V1f5YRoP7BA5qvFcZHKX0g9PIh3j3BYqzkLOJW9GKknL/2NzMXo7bKtAyBch8vq1F/KHbITHeEjifVwSkK/bCGA4geF8GSHfbvO+GwI7N4Ybepnsfq+chRUfwqoD9UB/DBke6Ny+6GMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+iZTN48vkEwEeJmqZOCTItl2026t0NdMuLjzUBpAIA=;
 b=oIIN63dEiDbPVDvrRp++VGnS6ElMFK9M+lFnxkJ2Bz1WvVw21tf3Kkk5Btwikyh8W7j56UuKCYhH9y3BG8/ukwwoFc1fkFbV14yB4AviZPp6taSmHIpzzRNK15WuKI3SCp5x2ebD8Mm+ZFCao2eGlkCl5Ohg6O2jWUbT1krUvCrjpmSrVTGt397Wl3xkrE0j5G+SmuaYQAKpnWi1LuR+MXcY8f4KQEaEeIh1rwNDC91xyImRMxEAun+xMBOIXUQEZrrl1MiyjoEU/vRILPRpypO7R9QAETX1whahiv2FCfwPlUx4VM248WOWKdcFezrNg0vTQK3qsOdtyYqLFvomMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Wed, 3 Mar
 2021 03:59:50 +0000
Received: from DM6PR12MB4330.namprd12.prod.outlook.com
 ([fe80::f432:454e:1731:2a1d]) by DM6PR12MB4330.namprd12.prod.outlook.com
 ([fe80::f432:454e:1731:2a1d%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 03:59:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated random
 MAC address
Thread-Topic: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated
 random MAC address
Thread-Index: AQHXCnT6NMq2tnbxrE2zArEnohdFyKpnBSGAgAe5UACAAGT1AIAAAs6AgAAwQYCAAOFogIABdMOw
Date: Wed, 3 Mar 2021 03:59:50 +0000
Message-ID: <DM6PR12MB43302B0E28AEFDD8A1620D11DC989@DM6PR12MB4330.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
 <20210301080731-mutt-send-email-mst@kernel.org>
 <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
 <20210301110937-mutt-send-email-mst@kernel.org>
 <20210302053919.GB227464@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210302053919.GB227464@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c58fa9bd-e9f4-4be4-53dd-08d8ddf8cb3f
x-ms-traffictypediagnostic: DM6PR12MB4073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4073DC3411D141F046896CFADC989@DM6PR12MB4073.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6EaQfzLjf+VfePY3tgpgLW7FRSOG31TTQpnguxqP0k4dglkPI3+j1li47qqVpgqkyLQohPrfDDbJTVbJGDaB31foiBY6ekO9mTVggBH4ey0CiBWBf6LdxdJv5k05x0eEbU7b2kjUc1cPwSxdbdU6xaqU7EFJUeIlDMvBojtRWd/zpCGWi2R304ytLAL0wn5EhasomZAJKf9iYRnp1rUq0ycaztuWaRgYtyZF0EEJiZv+gw24C4i5BCFG9GHkMwudbMksLvEwgQQhNSaDjAznY51ow/93teq2yJt8b0gaiU5pXvfHfcmpvxY5uiUVvyDChbZMPlfXTYHaxHia1e29Hw0PHuZff8syiHNSVn5gCg3uHoEiV2xiwqi0PbqK1jxPkLjwfB/sef30L6COeubcVDYZjqKNo05/ZNvBiskfjB9B9wIc+3jpt8N1hek+aMXclgnN3AHyVDzvClza+bYDTx2u/IlZWDmuRZ9G9E+tapBzmng3nu3SFZU6iy+ybOjeNAciW12Smj9TjJap1wrBEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4330.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(186003)(52536014)(53546011)(8676002)(110136005)(55016002)(4326008)(6506007)(26005)(9686003)(7696005)(478600001)(54906003)(2906002)(316002)(5660300002)(71200400001)(76116006)(86362001)(33656002)(66476007)(66946007)(8936002)(83380400001)(64756008)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UEd4SWp2SmRUaHk2L3l2UG92azdkL2Q1Zkt1NnVTa1lBMGdHN0prd0ZlbHVT?=
 =?utf-8?B?WXhvMGFlUmFwNUpDNHpNZDFPdGJCM3hwd1ZKcmNWRE1yM0pUaStMWjNxeVJH?=
 =?utf-8?B?Mndud1VDRWxzRXhsTWN1dXlNZ0NqOWNoVklZaVNBcElDUTRMdW9KZzNRT242?=
 =?utf-8?B?bk50cE5DaURoSUhSWHpkZFJsaWg5OU9JRXdEMGJyVVgwMXRQekgvNGJoVmM1?=
 =?utf-8?B?c0FTcXUvYk51NC9JaUFiZThjWWIyS0IzSUNWMzc0c1c0emM5V1IyWmZCK0li?=
 =?utf-8?B?UisvbFdGY2RaUXRmRkgyYmZQcWpKTE1yNUxiM3Q2L0JSWUxWZ0ZCeHkzanpH?=
 =?utf-8?B?WW5ia0ZQenl0dXlBbWRsV0JxMEFtRnBWNFdqTGVOWUFMNGc0am9aSFpqanNz?=
 =?utf-8?B?bHRiVmVTWkVNKy9xUkFwSDVaaTVueSs0MWZtWDQ1WTNadTZ2UXU5dXQyay9p?=
 =?utf-8?B?dktIQzhyZGRJSnA5UnlxMjllY0ZTblhVNE14WkE1eEFNTGRJZHA3UHdrdjRY?=
 =?utf-8?B?QkdCbmc2bkpITHNqNDhsVzRuNzV1REpvbE1XM3EwY244eUlNV3gwa2d3YUJK?=
 =?utf-8?B?R0lOc2lkSFlPQkg3WE90Z0I2aXhTTTdsOS9XRnByTEZhYlYxYnZYN3dnMnlN?=
 =?utf-8?B?Z3Z3QS9FbENaZytBcjQrcjd0eFJEdlRzUm56QzgxeE5OQ0p4OHV2Z0FFNGJB?=
 =?utf-8?B?SWJoelpFZEVPQktlTXZPa2ZlbW9DV09zVTd3dmhGOEl6RHZRZEZSZVorbWJK?=
 =?utf-8?B?WUw4WFpWS29GcE1rTGZlUWhjT3hXNGc0MnFYMlVxNHlXdXlhaTlvcnYvWXMw?=
 =?utf-8?B?RW01UUZ0NHBDaXA2T2YwV0Y2TXhwK2hpa1BiMHphc1FtbERPTzFuclRvSVdD?=
 =?utf-8?B?c0lpMlF3aStOclE5aUNja3U2bllDSVJGUnQyY25wemEvelBhblYxdDlUbHIv?=
 =?utf-8?B?ZFR6V0M5NkViZUVNckNzcEZwTEtNWnFjNFBmUjVEOERGWEE1NVYyYmg3OUlR?=
 =?utf-8?B?NnlkTHEwZjlXWWhiZ0Rud3RrWDVGbXNIeXJicisyYW1WSWMxVU4rREhtRDlE?=
 =?utf-8?B?cHZsMGsyb1J0UWdTY29xK1pXMm4ySjZsT2Y3aFZOM1U5WktLS0RNMm9GNGNC?=
 =?utf-8?B?TmFtYVV5SU1aNUEvdGRJbHBSMFJMVWVUbDJ5cUl5eXkwWGd5ZHNlM0tHWmVi?=
 =?utf-8?B?S0xBOURHRkxzRnJOSUxQUGVMOE03V05jcHN0TE1lbDVnZWpNeUZwTWM4YUFU?=
 =?utf-8?B?VDcxN25nRGxUV0NvcnQ5dWU3eFpycnRvYmhvdzRoNHhXR0kwM0JXWnkrUGp2?=
 =?utf-8?B?MW9OQ0tjdHNWcVh1cGdjd3lPS3dXL0ZhNHJ2a0dwbHVMRFI1UzhMVGxxeGU0?=
 =?utf-8?B?S2R0YkdDaWpWSUNPZUg2ZTgycEVaUTJWWTB6aFh1YmpNQncwNVoybWhnUyty?=
 =?utf-8?B?UmV2cVdxM1V6cXRPWWpTQ0dRNk1NczZrSHFYUzRzaTdLYlFNL0s2dHFsTVVj?=
 =?utf-8?B?RTRqd2MwUGxHaE9DOFlIZUo1SHhteEZ3UWE1dWVkQ01oQThLN1ZVbC85cEZr?=
 =?utf-8?B?c2FaZWRLUC9uQk9aUG5OUHloaTQ1LzZ3UGhIcjhrOGhpMlc1VU1MTzVGZWFO?=
 =?utf-8?B?RDFWWXEwY3BoQzZLcC9NRk5OSnJhQ0lGOVNOb1ZOK0xOWTRZVFF5ci9GTmlY?=
 =?utf-8?B?NFhlSVU3KzJPNXlDNGxLenlrMktJMm1MMUhtdWVoS3VMVzhZZituNDhQWW5K?=
 =?utf-8?Q?nEBJJtms39KkNRTZSE0tB5LTEHCcTTK8h+e3eCf?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58fa9bd-e9f4-4be4-53dd-08d8ddf8cb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 03:59:50.3303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ESOd3HXlh2i1twDScDXkXV9pu2tD5tqakf0X5F5tUp0uuA3OYi2iILQLhrJwW8A6vtSAcv7WM+dqSITnJY7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614743992; bh=z+iZTN48vkEwEeJmqZOCTItl2026t0NdMuLjzUBpAIA=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=JbTstCZVcTiOb5u5GbTeKZTwo7inMMrMu8+kip+XbtV50/OW76OqpocR/j6AmM8gI
 3FujhXUOLsz832YivvYyNQbgHGmJL9gPuQKVp4Ufqlo9vLuCyWuPsvgExJxurLPRpG
 wXnVqEt8xsOKg9ln8no+lIQe+QDILnwrGZFUFFX2C0S5EtOlPfX4/bu/LtarQZevEo
 fqDefI90S5AzWb6KWMaw0vNOFsbKlKecdNZp6K/HKyq/kOEqqY9i3LkQ/O0nplpTZz
 mt8a+svdVIyT7CRI8veEqRr0zNJqGV2HmeQA2UPWVdewVo192MxWdvGtsyUru1mMCn
 TNnipjcg1K7FA==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgRWxpLA0KDQo+IEZyb206IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBNYXJjaCAyLCAyMDIxIDExOjA5IEFNDQo+IA0KPiBPbiBNb24sIE1hciAwMSwgMjAy
MSBhdCAxMToxMjozM0FNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4gT24g
TW9uLCBNYXIgMDEsIDIwMjEgYXQgMDM6MTk6NTFQTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOg0K
PiA+ID4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDg6MDk6NDhBTSAtMDUwMCwgTWljaGFlbCBT
LiBUc2lya2luIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAwOTowODoy
OEFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gV2VkLCBGZWIgMjQsIDIw
MjEgYXQgMDU6MTE6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToNCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBPbiAyMDIxLzIvMjQgMjoxOCDkuIvljYgsIFBhcmF2IFBhbmRpdCB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFVzZSBhIHJhbmRvbWx5IGdlbmVyYXRlZCBNQUMgYWRkcmVz
cyB0byBiZSBhcHBsaWVkIGluIGNhc2UNCj4gPiA+ID4gPiA+ID4gaXQgaXMgbm90IGNvbmZpZ3Vy
ZWQgYnkgbWFuYWdlbWVudCB0b29sLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBUaGUg
dmFsdWUgcXVlcmllZCB0aHJvdWdoIG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKCkN
Cj4gPiA+ID4gPiA+ID4gaXMgbm90IHJlbGVsYXZudCB0byB2ZHBhIHNpbmNlIGl0IGlzIHRoZSBt
YWMgdGhhdCBzaG91bGQgYmUNCj4gPiA+ID4gPiA+ID4gdXNlZCBieSB0aGUgcmVndWxhciBOSUMg
ZHJpdmVyLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFBhcmF2
IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ICAg
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNSArLS0tLQ0KPiA+ID4gPiA+ID4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYw0KPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYw0KPiA+ID4gPiA+ID4gPiBpbmRleCBiNjdiYmE1ODFkZmQuLmVjZTIxODNlN2IyMCAx
MDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Yw0KPiA+ID4gPiA+ID4gPiBAQCAtMjAwNSwxMCArMjAwNSw3IEBAIHN0YXRpYyBpbnQgbWx4NV92
ZHBhX2Rldl9hZGQoc3RydWN0DQo+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAq
bmFtZSkNCj4gPiA+ID4gPiA+ID4gICAJaWYgKGVycikNCj4gPiA+ID4gPiA+ID4gICAJCWdvdG8g
ZXJyX210dTsNCj4gPiA+ID4gPiA+ID4gLQllcnIgPSBtbHg1X3F1ZXJ5X25pY192cG9ydF9tYWNf
YWRkcmVzcyhtZGV2LCAwLCAwLCBjb25maWctDQo+ID5tYWMpOw0KPiA+ID4gPiA+ID4gPiAtCWlm
IChlcnIpDQo+ID4gPiA+ID4gPiA+IC0JCWdvdG8gZXJyX210dTsNCj4gPiA+ID4gPiA+ID4gLQ0K
PiA+ID4gPiA+ID4gPiArCWV0aF9yYW5kb21fYWRkcihjb25maWctPm1hYyk7DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgbWlzc2luZyBzZXR0aW5nIFZJUlRJT19O
RVRfRl9NVFUuIEkgd2lsbA0KPiA+ID4gPiA+IHBvc3QgdjIgd2l0aCB0aGUgb3RoZXIgZml4ZXMg
aW4gdGhpcyBzZXJpZXMuDQo+ID4gPiA+DQo+ID4gPiA+IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3Rh
bmQgd2h5IHRoaXMgaXMgYSBnb29kIGlkZWEuDQo+ID4gPiA+DQo+ID4gPiA+IElmIHVzZXJzcGFj
ZSB3YW50cyBhIHJhbmRvbSBtYWMgaXQgY2FuIHNldCBpdCwgd2l0aCB0aGlzIHBhdGNoIGl0DQo+
ID4gPiA+IGlzIGltcG9zc2libGUgdG8ga25vdyB3aGV0aGVyIHRoZSBtYWMgaXMgYSBoYXJkd2Fy
ZSBvbmUgKHdoaWNoDQo+ID4gPiA+IHdpbGwgYmUgcGVyc2lzdGVudCBlLmcuIGFjcm9zcyByZWJv
b3RzKSBvciBhIHJhbmRvbSBvbmUuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gWW91IGNhbiBzdGls
bCBnZXQgYSBwZXJzaXN0ZW50IE1BQyBzZXQgYnkgdGhlIHZkcGEgdG9vbC4gZS5nDQo+ID4gPg0K
PiA+ID4gdmRwYSBkZXYgY29uZmlnIHNldCB2ZHBhMCBtYWMgMDA6MTE6MjI6MzM6NDQ6NTUNCj4g
PiA+DQo+ID4gPiBJZiB5b3UgZG9uJ3QgdXNlIHZkcGEgdG9vbCwgdGhlIGRldmljZSBhc3NpZ25z
IGEgcmFuZG9tIE1BQy4gVGhpcw0KPiA+ID4gTUFDIGlzIHVzZWQgdG8gZmlsdGVyIGltY29taW5n
IHVuaWNhc3QgdHJhZmZpYyAoZG9uZSBpbiBhIHN1YnNlcXVlbnQNCj4gcGF0Y2gpLg0KPiA+DQo+
ID4gV2VsbCBwcmV2aW91c2x5IGRldmljZSBsZWFybmVkIHRoZSBNQUMgZnJvbSBvdXRnb2luZyB0
cmFmZmljIGFuZCB1c2VkDQo+ID4gdGhhdCBmb3IgdGhlIGZpbHRlci4NCj4gDQo+IE5vLCB3YXMg
aXMgYWRkZWQgb25seSBpbiB0aGUgbGFzdCBzZXJpZXMgdGhhdCBQYXJhdiBzZW5kLiBCZWZvcmUg
dGhhdCB0aGUNCj4gZGV2aWNlIGRpZCBub3QgZmlsdGVyIGFuZCBmb3J3YXJkZWQgYW55IHBhY2tl
dCB0aGF0IHdhcyBmb3J3YXJkZWQgdG8gaXQgYnV5DQo+IHRoZSBlc3dpdGNoLg0KPiANCj4gPiBJ
cyBjaGFuZ2luZyB0aGF0IHRvIGEgcmFuZG9tIHZhbHVlIHJlYWxseSBhbGwgdGhhdCB1c2VmdWwg
YXMgYQ0KPiA+IGRlZmF1bHQ/ICBXaHkgbm90IGRvIHRoZSByYW5kb21pemF0aW9uIGluIHVzZXJz
cGFjZT8NCj4gPg0KPiANCj4gSSB0aGluayB3ZSB3YW50IG1hbmFnZW1lbnQgZW50aXR5IHRvIHNl
dCB0aGUgTUFDLCB0aGF0J3MgdGhlIFZEUEEgdG9vbC4NCj4gU28gYXMgdGhpbmdzIGFyZSByaWdo
dCBub3cgKHdpdGggdGhlIGxhc3Qgc2VyaWVzIGFwcGxpZWQpLCB0aGUgdmRwYSB0b29sIGlzIHRo
ZQ0KPiB0b29sIHRvIGFzc2lnbiBNQUMgYWRkcmVzc2VzIGFuZCBpZiBpdCBkb2Vzbid0LCBhIGRl
dmljZSByYW5kb21seSBnZW5lcmF0ZWQNCj4gTUFDIGFwcGxpZXMuIEN1cnJlbnRseSBNQUMgYWRk
cmVzc2VzIHNldCBieSBxZW11IGNvbW1hbmQgbGluZSBhcmUNCj4gaWdub3JlZCAoc2V0X2NvbmZp
ZyBpcyBub3QgaW1wbGVtZW50ZCkuIFdlIGNhbiBhbGxvdyB0aGlzIGJ1dCB0aGlzIHdpbGwNCj4g
b3ZlcnJpZGUgdmRwYSB0b29sIGNvbmZpZ3VyYXRpb24uDQoNCkkgYmVsaWV2ZSBpdHMgaW5jb3Jy
ZWN0IHRvIGFsd2F5cyBkbyByYW5kb20gZ2VuZXJhdGVkIG1hYyBhcyBvZiB0aGlzIHBhdGNoLg0K
VGhpcyBpcyBiZWNhdXNlLCBkb2luZyBzbyBpZ25vcmVzIGFueSBhZG1pbiBjb25maWcgZG9uZSBi
eSB0aGUgc3lzYWRtaW4gb24gdGhlIHN3aXRjaCAob3ZzIHNpZGUpIHVzaW5nIFsxXS4NCg0KU28g
aWYgdXNlciBjaG9vc2UgdG8gY29uZmlndXJlIHVzaW5nIGVzd2l0Y2ggY29uZmlnLCBtbHg1X3Zu
ZXQgdG8gaG9ub3IgdGhhdC4NCkFuZCBpZiB1c2VyIHByZWZlcnMgdG8gb3ZlcnJpZGUgaXMgdXNp
bmcgdmRwYSB0b29sIG9yIHNldF9jb25maWcgZnJvbSBRRU1VIHNpZGUsIHNvIGJlIGl0Lg0KSGVu
Y2UsIGluc3RlYWQgb2YgcmVwb3J0aW5nIGFsbCB6ZXJvcywgbWx4NSBzaG91bGQgcXVlcnkgb3du
IHZwb3J0IGNvbnRleHQgYW5kIHB1Ymxpc2ggdGhhdCBtYWMgaW4gdGhlIGNvbmZpZyBsYXlvdXQg
YW5kIHJ4IHN0ZWVyaW5nIHNpZGUuDQoNCklmIHVzZXIgY2hvb3NlIHRvIG92ZXJyaWRlIGl0LCBj
b25maWcgbGF5b3V0IGFuZCByeCBydWxlcyB3aWxsIGhhdmUgdG8gdXBkYXRlZCBvbiBzdWNoIGNv
bmZpZy4NCg0KWzFdIGRldmxpbmsgcG9ydCBmdW5jdGlvbiBzZXQgcGNpLzAwMDA6MDM6MDAuMC88
cG9ydF9pZF9vZl9zZi92Zj4vIGh3X2FkZHIgMDA6MTE6MjI6MzM6NDQ6NTUNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
