Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2191C76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 07:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40F1981EE7;
	Mon, 10 Apr 2023 07:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40F1981EE7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=jQW5g2Py
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0jDo0vc8l1c; Mon, 10 Apr 2023 07:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC4E281E72;
	Mon, 10 Apr 2023 07:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC4E281E72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCA99C0037;
	Mon, 10 Apr 2023 07:09:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE2C0C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A170160ACE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A170160ACE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=jQW5g2Py
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sh7fA-gwgxXV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:09:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A674860803
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A674860803
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKnKG2pMMUmY4bNxTSkuFaLmYqcZyxhcgBPEny1zm702r6Zyrx+q9jbvFZLbrTY3wHAHIfwydaZ3H4fQfNDVD82Lgl0hz9TTePHmaH8uWtk72s+qz4XMwCw/BSa4a58ufKi4XGXG1C15dJReUp41uUl7IbGRnmOC6DXgjQJTylRWpfQvuZfydq+hSoVJsh7znD3HW7QnskjPkeDxV/TGFxhjAhLYE9QAjc5kf5vvyDKuplzJyiq5igYW0cY2nkFrlTyMVwvy3OjxtiTvgRqP4GSz4tR6VqtaKHgUfHpZ8Sp3rRuEQ9bK+Pcixk6qITel52jIBP0e8m+9Qmo2cLcWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDFyokHX6KwoAtsdlHfY2Nf/66wz0Tzy2bFvMPA8YRY=;
 b=Gh/zF8CPxyCb+AXD82DEWWaMDXucHfksN6hnTciyOJmmeRiploDQA0Zd6sl+tKqVpzxkN3jlrpgp8eGQShK3JVLcwXnp329NVS+WOE4JYcIjtnVgfcVoZIlDrvY8SPaG01kIxALMDmkVfp60hjMTOPDix8R8Q+V0O/z9ZbqfPCLXUPPf5SllK5BbZtf826eyx9kw+bkrHuVFElT5AR+O0Zb8EWt5s876/HggaAmpFBh3B6BM7A8CsFWvDM+vEpKbJZO1b2kyAbqHva4MIRux+54E1zNpUWc/yrizZuNLtIGtfHrGFmAtYbdKfUFEnv2AHH/qdUW5sBjJEgSjwOo2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDFyokHX6KwoAtsdlHfY2Nf/66wz0Tzy2bFvMPA8YRY=;
 b=jQW5g2Py9qsN9ZWTmJ+wjxZwZ4Ed8y1IFDwfjJmLhUBQ99hAGuNOxvj1JajenQKnupFPC95UcJe9ymaIDON9jskxjY9/gO9np24w+uG8g05dPFBME1gCtg/QA0xejRMz53OR9JF2OI3e9TqsoUqF3mb+G9GnrlgRSHoDK6Pw7WY=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 07:09:09 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 07:09:09 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ
 state
Thread-Index: AQHZZWIBe5Qp6TTWaUKs4Mm16+1eFq8ZDo8AgAA8M1GAAU25AIAAK+0pgAkPWYCAAFDk5g==
Date: Mon, 10 Apr 2023 07:09:09 +0000
Message-ID: <AM0PR04MB4723CD9EAC42CC7CA2381EBDD4959@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEvOcaRB4eUOUy=GzuGnfeba3wWHWFDNdOgxXVbqyX+wkA@mail.gmail.com>
 <AM0PR04MB4723EA323FFB308A290725FFD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEsFVidKuqmKghZyQv=YnmcfaUt=ZFwv3Wf=MXs0ypCggA@mail.gmail.com>
In-Reply-To: <CACGkMEsFVidKuqmKghZyQv=YnmcfaUt=ZFwv3Wf=MXs0ypCggA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DB8PR04MB6923:EE_
x-ms-office365-filtering-correlation-id: e75bfbfd-13e3-4a57-ba10-08db39927afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddBsHPq0+7qCIg9C0zERKjGtd81J1taawQITPcPExGbdh+ZCKA4/gJTTzRP9JiUJXLMQ6ZHFKM5toKm3ShqQ7GsjvlvsZBmU6piZC2yQLnTRdqmsdU0IcFZayrmv4gR4MfX0Ol3ybZMSZYBHS5ZIDsj6bvculxkip2eCXMlOyOeE7W1mCN5yefAqUsLmrPriIs0sG+KEsPc4QTDty32XDHWqyjhusw+PGS0drgtb+nr2mXX6lh4VTA1jJ4smz1rakHVRFvWCs3Ul6At54gkRuEzXdxf+pPHq3R/OlAKGgQPyxwxUXBaVgkqtCYi1IZEK0O3i9JJ0rY9EBx9sil3NiKCVVzBAR4ip6JuB+joxqAuBenzSBc4QBmJewUuEseReqoTm2Z3Iy+xO8pupmNlGfqdpthj9brcTYMBxfXgR612WbfXs3F+k9a6dpB7yTydG2ijFoqt068RvjAp6Wj6fkNGOb1rp/H0AzJ3a6d7PsMz74vULWGYHbmhug71TgevDvqywJrqKwNs4FpSa2M/OMBEcTMtPssLLn2wFjx9ThLCrd6nGlvu93nUBJmeQ9cf3CEF3QA9CNLmCpUp0RUdkT5Xtn5GnJc/YhVTNa0DK2z3ioCrjiqHJ5mm1SrrThHvL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39840400004)(451199021)(478600001)(7696005)(71200400001)(316002)(54906003)(9686003)(6506007)(26005)(186003)(44832011)(91956017)(2906002)(5660300002)(4326008)(76116006)(66946007)(6916009)(41300700001)(66446008)(8936002)(8676002)(66476007)(52536014)(64756008)(66556008)(38070700005)(122000001)(38100700002)(558084003)(55016003)(86362001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cp0jcVz1R602mcFFca9canqOAFU68CPfXZVRmb+Ru5LbJ4fJ2dx9EM9sdz?=
 =?iso-8859-1?Q?cIFQwmIbpwCPLAHkMVKirL5qyrgWm6kaO+zawCavHH2jN5eACiuiKsFIxN?=
 =?iso-8859-1?Q?4UWc2KsGHC3F9+jWd7PtXWDfpzdaS3kRW6Mur6udiMIwTY210cuA7U0d+t?=
 =?iso-8859-1?Q?2qee6OyBG9NLcWGV8dQmfbSwMDq4K4USgvj9BF1KrTc7O3M08J7BWvBRxY?=
 =?iso-8859-1?Q?0LZLOtMARP5Isi5v6PV4eZrgbOKs6Gy2Y5O4VUNDd/wiWTgYaGbw3YkpWp?=
 =?iso-8859-1?Q?CZX4COZ5Dwwqodx9iJjbpOpcwIKOPFibyziZwlRNq4JG3Oi0SAZ/FfH7QV?=
 =?iso-8859-1?Q?kXkv6AtoewG7s7vQeNXxJQ5mwBw8BSvPhbKHH1CNx+sNzYbmjX6vgTza4H?=
 =?iso-8859-1?Q?ojSzUd+2jvO42fECBDAkrEu1tXb7eNLlAnCL5AlUv/EtxGB08MXGeq4W55?=
 =?iso-8859-1?Q?0VaQeI9zjfmwtDrRVD439DyWvdxf6FyJ0Wi0triSHMMW2kChUyaCRckgGI?=
 =?iso-8859-1?Q?Uu5oXvTTfDK1Lnp9fYNkuSQKJEPRvzz3rVlGUrtDNAe5PBI8GYEAHLmozL?=
 =?iso-8859-1?Q?1pFA9+usvLv8pAfIWdYfU7yreDCFJROGuxNlFKAwbba1sH9zYfmtdVloKC?=
 =?iso-8859-1?Q?SYKIPhJjXPhHj3XhYHAWaEGnZHwxRfinTYpsNHLjdqfCjlEb/0RVEQNA8x?=
 =?iso-8859-1?Q?pTjYJCaWxeWyYJdkW/Xsbb5+6W9l2CV/NBZuPcph8OWehenZDgY+QpzE1T?=
 =?iso-8859-1?Q?A3jjgcIv/Mmw5VtB4zxwNSyf5GsM4kBMgXXu6GRotIez8UCQ7adQ4mkhzU?=
 =?iso-8859-1?Q?DxptEOWSI6hge0dHVhRqEmB6ZoGuMmq5ZdL6Jq/GQ1IpqxR778AooEspcW?=
 =?iso-8859-1?Q?Ec6LMSjuV94ttrmoklNIVecennZPI0iG+RzVKvHcUOKqB7LfAXcIYwBQN4?=
 =?iso-8859-1?Q?M1QNSZNgm9aSp0HhDhooIVMQiuqPsLlkPl5sY6qzDcww9zWjG+UEC1OGQ9?=
 =?iso-8859-1?Q?ABjj9aPYxO60q7VXY2JfPxRmrlaI64ldouzyc4W9VK5kzGaxpMk7/YbmI5?=
 =?iso-8859-1?Q?AYzaM0itnfj/vXj+6d6gpK3YIyo9NRK8Qj+bCYaDwHgfDFX+2EHj7xZ5HN?=
 =?iso-8859-1?Q?PTHmoZAvJ0Ru6KgG1z5FI3bUPP5H1X5Y5HMcdWAm4ZrHREvzbeD7rpss0F?=
 =?iso-8859-1?Q?F6tdioqc0YNxweM05RBYgPg4008ABHCWdxMnmHiC1gCJKfWq0qrcbu7gNK?=
 =?iso-8859-1?Q?eA+je5s2oDjV2vtvk5SGDvW2pR68QP+7SYliOQeC1YCrI3KC9w8KnR8NWP?=
 =?iso-8859-1?Q?vCmVjo7a5lS5fNJJQvtJlc/FWTnA3d4Cz9h8DHBbKUHdpsRXCi79rwZLPU?=
 =?iso-8859-1?Q?zF8kpaf+d8C53hbnYj4z1/NDMMh7NNCv1hluDIp9pCOCydOq53hUMRLoJm?=
 =?iso-8859-1?Q?mPfY6EadzP7LaeWzvfZemiRngakkrYSwFq7bQBmHlqwr2hCVyYiDe+bl9w?=
 =?iso-8859-1?Q?kqMXLGJTXX80DMn7WDauyFT+yRHFAzSy3JzDlwJp0S+iZ/p8hbQp3wmiCr?=
 =?iso-8859-1?Q?QU/dE6SP2ZmWs3vrf2X0ELb5RlQyyIxjRMS02ySo/+fqH/SiOnW1wfVvD2?=
 =?iso-8859-1?Q?zfejENRaWgl5lOFv+rJ8hStsRFsUCmMZR1?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75bfbfd-13e3-4a57-ba10-08db39927afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 07:09:09.4222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CO1k4TDVhxPwm8tNXSLgDdDWzs3DxF5eHdVkYDJUqvHJwMWayP0Y2oUeE0kSFCBLfoJTP3H7PBOZ4Eu2c+fg/t3dVAzj60//tlsLHOIox5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

> > In this case, I can just remove the wmb and that's it, right?
> 
> But who or how to prevent the preemption?

We use a mutex to protect the control mechanism (snet->ctrl_lock).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
