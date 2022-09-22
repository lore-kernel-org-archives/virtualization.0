Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFD5C6FA8B
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 10:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D7E7610CA;
	Thu, 22 Sep 2022 10:07:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D7E7610CA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TXqA5kIq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DjeOqWDmSsRo; Thu, 22 Sep 2022 10:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6CFC610C5;
	Thu, 22 Sep 2022 10:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6CFC610C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82DDEC0033;
	Thu, 22 Sep 2022 10:07:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44CFCC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DC25833AE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DC25833AE
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=TXqA5kIq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2q5CFqGaqajm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:07:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E686833A3
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E686833A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfKNK9ZADncDZA/Yhxe1o17jmM0JVKmrKyiIABYnvzJgZ5TXlIxkqVYzcTnejH7WB5NEwyng3zg/rgOXl2E35uNaf+tr2j4dYvbjO3uVPqci2vHO0hMlQGNtDVURQZk2CSoItL5w66Zz0sq404PoIs+hk3KMEEMx1n+KBGiws38/zccvvt3bQi4PE7WYTAE5JpRpLDeimHLQ/u2DCnYQ6RRrbJW+3csVdIaCHEiV+BG0RxgCQTmM4iSjoHFUVBXkeg7j2MW3s6njpm5IqCYhPh2F7K5r1hvkar4MGaDKj0oFVAg5EIYvrwv7kXyYelSJDQIuoo0xzVfTad7w89FHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2NJQbS/1RDGPIRIiJMsnnWFpFnN7bkPLS/e1EMV8oU=;
 b=jl10bAqhXTwKCM7PwFR9U5tnpRP6kS99E3vPvbZqMkyU34+Fo/LhK+16XqkRgFdQ+YEbSNQqqxfkSaIvTC4w/i9XRXPSy1gx60O+7qtXQ7oRqYiltwk+KckpV36asPtG6NklTZS/Il0SqVwhgChQG99EANNyB0IEtxY9oZHclBLS4J0gyCK1vTbHuP1fzWgPs19pYCZBQtcrc+JZrlFHlSgZsvaPlaX13SVfn9h1WfFwsHP5ySI1EJJltFrCNMQKADg+2UE7zXnlLCuu6OzWG/LXNA+0vzqIKyFWEDAPt3f/ie5PXjU+KY+Y/r0P0C/Reo1hxkUA3ihA/XHGmwVH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2NJQbS/1RDGPIRIiJMsnnWFpFnN7bkPLS/e1EMV8oU=;
 b=TXqA5kIqThLx9oR1M6CglcSpXiSHXA7tlunoahqtsqoE9+52TUeWmL6LkIxN1uVfufOrJDjC01T822lRTyxMnHha+9x0Zc+KpmnA11xnv5dLCNKb5cuA2fe3jXVcr1xcSaOLsH274r5Q1ts7ZD7YPUEpJqOOKdK0nqtUjASbt72mruwH9Ryk9mL3u0WsK6l3cnPoP2rRwnxMnZEyJ9epTDgU863+aO5bfJs08WdtlYwad4VbCKZ2LxV30qoPre/bs5ttiKjay4F0KLLRqjtssTB835eZV4QdmKpV8PYnb9aadKuG3DZV+gozytPo/tYhBfvpWzLr1sqO2MdPphdfJw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.18; Thu, 22 Sep 2022 10:07:04 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%9]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 10:07:04 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Topic: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Thread-Index: AQHYwpEbqLdY6RByfkyoSMo8wpA6EK3TsrMAgABG8oCAAA3LAIAAADnAgAACroCAABYGQIAAJjCAgAALaACAAAQwAIAAAFDQgAADKICAAACIkIAAAuAAgAAASDCAFuh1gIAACqzA
Date: Thu, 22 Sep 2022 10:07:04 +0000
Message-ID: <PH0PR12MB5481910FDC14C294979BB529DC4E9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815E541D435DDC9339CA02DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220922052233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220922052233-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6096:EE_
x-ms-office365-filtering-correlation-id: 320035fd-1f30-4c52-c06c-08da9c82330f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3AAgw88GfcDSLJTLlJsUA8rVDbSM7RjpLU+H6iEXDX9CUTAdPV0EWo+x0gxchxcuhPICeBi7CQq3b5XLTkQfyvInLUmYWmYJT5BGpPOlx1PKAjZTNM23ZhHIRjHvmWgs8HUO5zOlrlAP96GHdfzvXs12pv0BxMdPelTnKoRwbOWZoAoztv2GwTbWKjTDV1HNMtUMVqAz2mPG4w/8gqbnfXcoN7Xaa1htokRBhkwl6XrJc6i8AwGalBlwcWT2z+4XMHSeUisMOy4tBCLxW0xDf2+2qF5YzovaXMjacILrqJPzypnbfiNiwMHZDEA1ry81qI18geOY425JeV6lduHM7IY4DmtQKvSvfX5JBwf/vjngOx63va8v1dZEu73zDlgVC29+xKwcTVQmnQzGlPRXybcDq+o6xKzPk8uWx3yKa+YRvwd4Ih7EdpPzWK4T0uLLYqK8MLVYRGCguQpMrz1lgUZ7k8fJCHTjg50xvPonGT041RzMHTwgMWTGukiX3pPFMtNqapU6HkbvaWY9BKbUyL1pP8nSDSPChDjblZqUDbrDhN3g8zmR86eOCnZB3KmNtfi790aee1oUX025gpGAIu8niKDWEfpBFFArtES6m9xP8mfE7B4RSsSM3TOwyZXOkqY8AnPuZvGQusWuVX146VVJUfRRMQMaO427eQGYU38KXI+visQ2DsFxAhv5IwUJZty15LGiSw8vueJ9SAf57xp3oxxMNXUVoR5tA9DBBNEtf6SyyKwLTPiUJwl3UAYAdA6FFduqPu9pNIls3fIng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(38100700002)(71200400001)(478600001)(122000001)(33656002)(7696005)(6506007)(38070700005)(41300700001)(76116006)(55016003)(186003)(86362001)(66476007)(6916009)(7416002)(5660300002)(8936002)(8676002)(4744005)(54906003)(66946007)(4326008)(66556008)(64756008)(66446008)(9686003)(52536014)(316002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PS4jAhEYWw+rOdbOHOWrNd9eD7oKutOBSs6T13dBCADEqZxvXvW5jaQPBPlS?=
 =?us-ascii?Q?m2a8CmyfIWUuQEp7QnSV1UKSmnBaRVwqS4gt8jbDbJiHcSfqi09YB8KsGSQ6?=
 =?us-ascii?Q?4yise30UVP/UHdRjVw2oe39LtfQXJVr2n7Z8fvSSQymWNtcm5tXN+ErM5an0?=
 =?us-ascii?Q?CioAiyQVxF2X6dUKIGQ47BzzqkT0dBns1RNSI3NlsWV/Jg7pp3ypy1nMwy6P?=
 =?us-ascii?Q?95G6ffrRp41t4XYdVGm8/MKx9BPJ6zxV+BGjmmBD39OMThqe5qt3q3JF3FgH?=
 =?us-ascii?Q?nWWUXUB5iTU+pi8V6Zfbe9abwsyxJMl44tJUbpM4AKBwAX1xrgdiaLKn4uyL?=
 =?us-ascii?Q?asIzCax/nbCbgmsNE9xDreZ8aUbDQEUBXIJXfFCNewdbUBU56T3acZ/NwQ/P?=
 =?us-ascii?Q?yX8VunHFitUMLWebohoGAdbHAgNreAn95Np9ztIlvaxacVGYAq+rBqsiXa+O?=
 =?us-ascii?Q?X8YmuK7gnjW9+qLuCIO02v6dEyKNbItcmMAiZSHzueUwZtOND8+hd68yQgAU?=
 =?us-ascii?Q?RsJjxLoXLVz7rCbw2decmx8GzC2QRxQsBjpH6/STFUMcK7bo90wccmaVb4YK?=
 =?us-ascii?Q?AkbrybLMjKiBiVeYjRFYXFZ8rebnqXza9ufZr+jJ0YifXsLLbtl1l8PyQIS8?=
 =?us-ascii?Q?B7Shb8XbDniQ4OD31T7ineQs3XV7n/e/VzwqlDimfJqceG4mRS8iowIpujTK?=
 =?us-ascii?Q?Pdj7fR28+RJo3R0gBNfwHAqLyoq6SV+VfGFjC+Vjt2TKmCo7h13NXecBDOWT?=
 =?us-ascii?Q?0V2oQLGGFJZLevdg+fvHUWMjnX7opAmQcI7h/jop1dQasy4pSZahMQT+bSf2?=
 =?us-ascii?Q?Aofxb3V2xOKNqF75lxHFWWRmnQzDACDsKoqMZbjbrbbelXFpJ6LEWV3Y87iT?=
 =?us-ascii?Q?5O1+Ego6qJW+uUfmWWnx7A/79ukxXcwgiNgLK0dHiRXE8xyhZzvMKJsKdCKh?=
 =?us-ascii?Q?H0GD7Kdj/SY2yu8eW8ExhaLmdCI5WnMAttBajamhUrSCOK4ac5ckUD+pCDfY?=
 =?us-ascii?Q?FkHbGeNJH0otOThbzF/ytH/xIoLa997OE5TQS+4y0XgWDgOdpod8PDQwmodA?=
 =?us-ascii?Q?p2UTjaY/4XTRKe4Ieo1mz3skgf0cGoPhrkjkT9T0D4/ES8PRFVBsvq3B6fjh?=
 =?us-ascii?Q?f0szhqkqI70EzU9/xyDVMVI9qufpptOP+06KCXRvEpZojrm41oYu3LBGYEIR?=
 =?us-ascii?Q?pHEf9rzhCe65Hmts+JX94p5RzGP8ffpABhnUrSixmMCAkPJkttpJUHZbQjwe?=
 =?us-ascii?Q?IUP4PvSMzYntcONKnG/eoKNBXloudxrsJP1StjH4eiMedwkY7HPFgdxz+d7/?=
 =?us-ascii?Q?id+cANqb38gyo6hMpSmGm2pBdW397qQxHAFtc0ngzMjt4bgZH5IIm+aONTx+?=
 =?us-ascii?Q?EUuiRMA9JymNtluCW1msjZV9vkSmW99SoA7fnM2EhQliLQJpdclut2rK/dea?=
 =?us-ascii?Q?7X87yTmlTcDPwuTTh9zw7/iyNRnDwiPXnx3yaIigyKOH6RxyzPmuabCsJmjD?=
 =?us-ascii?Q?YipEoElBX89RRno1yhQj5UwfEgLqwij+ELKoOPWHkgJtPVdy8v2O0C00LDWu?=
 =?us-ascii?Q?tOJ+ZkcEIwrTppeh1WW0dUM+tYWF/+da1PLrUa2xyAv7psgAmmcftOe0T/Uv?=
 =?us-ascii?Q?X6uOrFLAOicDx87fJVfBxsM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320035fd-1f30-4c52-c06c-08da9c82330f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 10:07:04.2229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXhrlXx0Wi9pgT06jDhldELZ0iQdQwqGiOGENccsXTP24UGb92RJQkaJn176KKthSs2oU1MNBe8IozlB9ltwcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Gavin Li <gavinl@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 22, 2022 5:27 AM

> > >
> > > And I'd like commit log to include results of perf testing
> > > - with indirect feature on
> > Which device do you suggest using for this test?
> 
> AFAIK most devices support INDIRECT, e.g. don't nvidia cards do this?
The device of interest didn't have INDIRECT support.
But the question is no more relevant as Gavin supplied the numbers with INDIRECT in commit log of v6.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
