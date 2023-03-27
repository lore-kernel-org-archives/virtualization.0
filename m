Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D68C76195
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 06:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DA2681A3E;
	Mon, 27 Mar 2023 06:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DA2681A3E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=kZoJCnox
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mxPZfOQTduZa; Mon, 27 Mar 2023 06:49:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BC3C81678;
	Mon, 27 Mar 2023 06:49:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BC3C81678
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F55BC0035;
	Mon, 27 Mar 2023 06:49:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57F52C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 221484057C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 221484057C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=kZoJCnox
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYDjaix4ptds
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:49:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1464F40220
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::602])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1464F40220
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhERTSEc1FafAMrubp03TXB7caBAHiVi+f/0RhHSjuYHKhm8pc+CAuecjumYCEyWGmlbJ3XP+NlOYnHA450+zIj19PwfvniWjiWunewebLmwenooS403rC+tHG5Vh9U1ljLfMB/L95YHjuaQPoeLXbOvPuccU6Cj3asG+DgYUrBh7ylEJnB5upKf/Yg6ZByD14Uw/lHB5raYr7CpCyZxvyn5EcvtdenZyRmpHYFTT7BLbjzXQeMGnHG5SLrC6LjiEfcNIB1gH5n9shp9MnmZCydnB4o2HdEnfIDoNACvS06R9EnH8QnztENmQ8D42aTsFzuS3owByPrTBpvUItvz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09P51reyJ54/HYlUBtpRo1dhcRtWQr1EpELzAV/HVwM=;
 b=X8ofFABUL4scv5KUN5gscxi2Pk0HPRPFbwV6WZjPjp9jcDnDe8M0/NgKABtyKqSvFGW58crIpz+7DGyu24dsu/r65R/EmcrQUguo+5e9s02TuG+r7xO6YWPb5IIJp0LQ0nwaFZ6OvB2GZAUFTXmWphMiFovYGreUy+DjniH99s3OjLedUsQSA9P9/9sECQ1lzYBeiuzPVYdfk/MWv4B0nW9/ENuhW0UBQPoL1J2dFCTqWDyIPqLjCtIP1x8cWpY2yipzKCKQ/0v29T0DEQKB2+7NF8O2nIweWOgZqtJk2cq3sJQEnPDWVhKiK0WZr78p24WstaffWaVRTP5RdtIdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09P51reyJ54/HYlUBtpRo1dhcRtWQr1EpELzAV/HVwM=;
 b=kZoJCnoxRXaqUZK0DnakOj8oO1eB8gZGIjvlydxTvZ6UJOFeu8t62uYM2k02Vl5w2U2VDVTIZpyoc/bDXq7s0axocw2q4C6j8g7lkdGOxeIOzAxigI1z2NRgoh17Zhxaac0xML2Wk4or3MD7Bpo6RAd6uz0vetv2YthKefOFcCQ=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS5PR04MB9971.eurprd04.prod.outlook.com (2603:10a6:20b:67f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 06:49:32 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 06:49:32 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Wang
 <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Thread-Topic: [PATCH 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Thread-Index: AQHZWxWF/MSQE1UyOEixwM69Ey59IK8OOh8K
Date: Mon, 27 Mar 2023 06:49:32 +0000
Message-ID: <AM0PR04MB47230415F00797EB85F0CD41D48B9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS5PR04MB9971:EE_
x-ms-office365-filtering-correlation-id: 8e39535b-fd02-4b33-3a2d-08db2e8f6b7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6CmqN28RzekVGhKnU0rRxVSnU3WBJqStg68XunoGBV+JUAkMC3RvmSa5HvS6n/GX3WoXFh84ujqLDQcPf7hDdaZvdkG6P2vS8uorO9U2UNB84rGybEF+MNXL5H6ykMRyrgOcKKZmfuN1vxY+SDpRJDpDPSAlKmdo8fsX88qShfdhfdhCurzFi+u+kqbJFNdSqw10CwKzzqOiMOX+SyY5ybAFY/uwskJDqGG5wh4FeQ6jKcfo6qLvTS8JCqguu/TLM87T3LLZAurWa+HuaN1cbXx3IXK1vaJtN4dUeA3j//5obcanPsx4m3deVcWe7v0Jadwu3GRnWsS32Axex/+GanZ3mhIBxVcyLVF4iSrz9OSKXD3olJgkDRjocbm/1rsPoKx5Smll3DGMjPPAYYBUQCfMJrHnQgdLLRdKl6rq1+Coj5ZEUv2zjLBI9TqKJVORX0g+amIKgTy+9lVNF9auzILl5J0Gp7l08aclVYjACY1WF2YiL5h/zyReYHa5NMhA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(136003)(376002)(396003)(366004)(346002)(451199021)(91956017)(38100700002)(44832011)(66446008)(76116006)(316002)(8936002)(122000001)(52536014)(66476007)(66556008)(66946007)(110136005)(2906002)(41300700001)(64756008)(8676002)(19618925003)(33656002)(558084003)(38070700005)(478600001)(6506007)(7696005)(86362001)(9686003)(186003)(71200400001)(26005)(55016003)(338634005)(558944008)(1903315002)(15288005002)(19559445001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2Z3TdT0JuyuGp0EpkVKqYJzkWVXhZ2A31qiFa7KxjLizTeu22i0o4AwydO?=
 =?iso-8859-1?Q?sMg4oHT8T/i/LI7EUXboLbvRwtgqVqtseclGbHaaaRIu8AJKM6RkIHAcnb?=
 =?iso-8859-1?Q?T3UNy4qTvrBjwIX+oKYq1ZTDV/lxlsAAHb2LJ8ol8QZupYo/c8SOp9xDq+?=
 =?iso-8859-1?Q?Ob+5z9ym8Z4PypwrJ23DyhMKq3q7p4rfi3Q0PYHS8hi3V00GgeS6VtV+Ti?=
 =?iso-8859-1?Q?j++kGZuxDZUsS7u9fk1VR6mulKN28CoAl4AqQwqmToHL1Z4eME0rkiZAxc?=
 =?iso-8859-1?Q?hoFhOfmX0ukUH4xz4cunmoPCRdtD2OU3W7vsjwxHEWKBCJVZOLEG9DCRCH?=
 =?iso-8859-1?Q?Gnqm3X0xlQoECtkOOhSDp0VBnwiSagns4x3mAib/e2A8O4c9XZieHmy+47?=
 =?iso-8859-1?Q?N9F6UQoASSKWEkdALlBIuCZL6FyxhS7XYPVn4/eiAstSFxrE5bzJdXE+U5?=
 =?iso-8859-1?Q?ZAP81nhtlOPo/EMiQsYSdxqrXPJUKFErzCYYE21pbaZ1XSAPNktFBGerjO?=
 =?iso-8859-1?Q?MZrSS25b9gvu60ilwQvu7hhytPc/ZcaFTGYo4tNSnDfgAdS+cHdvwRSAaX?=
 =?iso-8859-1?Q?F3tbIE/E5XryxyCwz/YnSO2uTKLyiINPgWVzgaa5ILI2dbBsMR01NiSiVv?=
 =?iso-8859-1?Q?J1nQzjHjSliKJJBzmYkIf6M1xCkpgaBN7qp2Er4+2wE5vLrezOUAqQSFd+?=
 =?iso-8859-1?Q?t7z680whkRujijp5bQttYJ4t3BFlvpb5mGwva6SkY/xjvhGg6Yyd8YNgRX?=
 =?iso-8859-1?Q?riEItMey+BKgoDniUlkeEnOKYuU+/J+gecRKrD8oXwVYmUQVCOXVrOYDYU?=
 =?iso-8859-1?Q?5WXzGixopFgmUv6Ol9hlEKTXJNvttyvdRIPCLhRYyTAERcGhX8ptLyOYTy?=
 =?iso-8859-1?Q?Ocejbukr5DYPnAR6l9T5MWbuagXjZBBiZ2c2ksMqru9rMnX1iSXOmO3ytn?=
 =?iso-8859-1?Q?aZFd6oTGzr+UXS0Jd+kB2Z8+c0xL1y7vBPosPJVJFhn45CHtxrG6++dsOu?=
 =?iso-8859-1?Q?If6lLO9ZJHrUQgQT0JhOd+frJmZI7x1R6K7QUWJLI7vjRtsPLIWL2XXnTJ?=
 =?iso-8859-1?Q?m1aALXRB0RrT5RGgEqkep7VAn4wJp6Ggep+m4qFcEGKIxAEQsJHq2NI1NA?=
 =?iso-8859-1?Q?7pjPWEJyfYZiv3pgsWVJ2Li0GAhl9GY3qQKRZyUBGwLNkqxAdS7W1GXslP?=
 =?iso-8859-1?Q?VQqhZ2wjiaV6W7uAyJ0sgR3IY4saYRZI+4nykm42icZ2Ph2FsbEOv5WymA?=
 =?iso-8859-1?Q?kOqjBuqeMuqxAgL3bQhAu17ZB7EK68qtfOIsCjaZIjeEVZn9TNr6Zg0mME?=
 =?iso-8859-1?Q?V703XR6tHStQYR1kswhqx3d55iVbO5btF41I6ganEjMWTK9GngxswFIvr6?=
 =?iso-8859-1?Q?+Dwjldft3ti/m7lB9ft+VVSMXtmA5Z3w5/S4vQ80dKtfKm7Quesd20Wl5Y?=
 =?iso-8859-1?Q?rZpmB4iQx5MY2EL3DOzlemFC3K7UCCP7wDsNWUzQUvPPe5H1YS6KZRILo4?=
 =?iso-8859-1?Q?rQlxUvbpsbh5f5+g6RZWtGHFJzmxbPYQj0vFPmetazj1IdN/xohpnDb74b?=
 =?iso-8859-1?Q?m+0BXenmqeo5MGLA9AulHAcRKedaCj+ImRglPEjp3VYNkBqsLBDmaRjbiI?=
 =?iso-8859-1?Q?IiSojk+hyGrCQ/VG36rvIrnASaL+JAa4+1?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e39535b-fd02-4b33-3a2d-08db2e8f6b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 06:49:32.1380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ji/MMq+2zoBSvE4wxNCjtwAE67QUMrYNZ96R6piCJ9+LrktFsSuwSBllogF+lO64ApwH0Ffgzv5TaGmz8n5of26uy4r6uK7YVy/jdDKL8a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9971
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

ping
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
