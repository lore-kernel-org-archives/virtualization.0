Return-Path: <SRS0=6mDK=MM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04382C07E95
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 18:04:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CC261029
	for <virtualization@archiver.kernel.org>; Tue, 20 Jul 2021 18:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CC261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E0ED403DF;
	Tue, 20 Jul 2021 18:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRqXiJcjxp5d; Tue, 20 Jul 2021 18:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEAB4402DB;
	Tue, 20 Jul 2021 18:04:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B023CC0010;
	Tue, 20 Jul 2021 18:04:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF55C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D89F402DB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmC5G1NqGl0c
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:04:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::600])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CF87403EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 18:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA4rksMwrErfUZ245RlC0Jnuyn52zXIQI0iGA4xuULAu0v6+dtBODb6rTfS4HERG8MKj61Csa/yl4EWIdQUZznzKRUUa8Ut7/ZNCIt+P0tEmv9JaHD7mJwuo/fS/bCokgPIBuIKtBB9qp7Vyw5AM5z7kOlFJgryiVYQ6WNZ39g+eGMSifBFCBTFcNNSumdk7LkKPVsj9cdIDYv7KA+cf0EG6IiNW7UgUK/Ozk3YfLp54W14Z/pfv5m1eOgb6FQb1woER3heKtUQfVH5ROrwSnfKntF8M7k7/J6svMQtgYYHRZyR35snB3oTCDkh0P1i5Gw2sblKYwnHPFD4QruadLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSTHZXW22OqHL3vPfsU9CZk+mEYAP1jErpfRGQpGdRU=;
 b=J6yhYqJ3+JPhCDJSowxMKuyHBjcAuwjjX9kB7s3pytwRbfEqSrvrF6friLvOGIGGwZnlHYAOKd+eY0xvAadsm/ep+YoGP3cCJqnV/Dd+p+Hd2ZxlIy+RALTg8EZ5iUEQ085o+QxpKVb1SROeome7l+DLVfnc+gQHDgUmGQMFth3la78U6vd2ATgGkOXgszKVoznkQ75RQmEwVwRweng3DQYC1yig/jJLCEadIbzmGekRspgFGhl90dwLj3PcrZY6r0E2pfQWjAImKcbhLvSG5IKSBxfN5Zuh7j3N/UBP99jWVBjM/z0XluWbwoniVAeA807I1W3Q0L+aNT4veRqN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSTHZXW22OqHL3vPfsU9CZk+mEYAP1jErpfRGQpGdRU=;
 b=EA35afrkJCo3/sEBGq8ShyQ2N2eBrneq/2OIq+OMrrr1HCIuAVSbzmhLeOo/4pHQnKEqX+F58OADYXd/vNyua1FjRM+Spp132yeYtzFkBJiKC5J7remyuGo0Yexg9j1E9l0d9UZc6bdgFst1cEB0jf8DdbW3szbzWQBNwh/r7VE=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by SJ0PR05MB8182.namprd05.prod.outlook.com (2603:10b6:a03:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Tue, 20 Jul
 2021 18:04:15 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::10a2:f19c:89af:6bdd]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::10a2:f19c:89af:6bdd%6]) with mapi id 15.20.4352.024; Tue, 20 Jul 2021
 18:04:15 +0000
From: Vishnu Dasa <vdasa@vmware.com>
To: Greg KH <gregkh@linuxfoundation.org>, Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Thread-Topic: [PATCH] MAINTAINERS: Update for VMCI driver
Thread-Index: AQHXfVOCEOs/AB90LkO0Z+424hB00qtMKKUA
Date: Tue, 20 Jul 2021 18:04:15 +0000
Message-ID: <0DE37084-185C-4144-AF9E-22EC044B0CB5@vmware.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
In-Reply-To: <YPan14jucU9/u6JL@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aba5f0e8-c04a-43ed-e4ab-08d94ba8c930
x-ms-traffictypediagnostic: SJ0PR05MB8182:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR05MB8182005BA6563A1EA63594A4CEE29@SJ0PR05MB8182.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlqJAPEMQa+3HLWBqc4OySYf+ItEmqmHXBVNLEnxDV9FREAnV6tMETdrB3ZfWsKAKtD9xECcE/+KB6uQJvmRvmSxaVtIKHwzuZxpylt1jeIaCmu7Dyliby4ebCQJDEbMKkewQu76XH6NaKK2KIyKSBgh5evEGcp9P+0xJE2X/H9juthgydZzC+WBwmGGLbONCca0TQCQH43htYrqRwceUNIcQp6ZM3xXhscBHJ6AZ3Mqo+rN0zXcLTtJVOyKv6RIGqWhmfbyckQ0f/+0cqxeENv7yZqtzqPAKIu3qa4vA12QOO8a4KKZxD2FrFtwV5ph7eOi70RkCiVqHYc/dDmW3/ZIv/yvHBrRGWgXoCfKQZiVNc4ggXhFysK6etfoYnfPcWVOoKzsolcTEykK5AFAH4ag+b6awtb7iPqcURH7bZEJtOAPBjQvdQo9r+IXvG85RTvHAVkkxY8x5hOHgI485BGq+gLuIM+wGq5Ce+dHIBu7ztB02Zw291zev6n3AvDERwOi2tHvbls+uygeT/3shC5ONQBOjGpPTi6KFM4dDC5XlyWC3RZYwKYOSJhraUN5+C8KlZHlIMjbuIX+uN+/WdqlUS2EPJ1iVRuqzQdTIIdYnLNN1D6GtQS56AKgENau58gFnDXgSDZ3h/5+H7/lT5rsVRYt8hGzmDpC7c9AoJT6czxm7uol7oImt1JWjBEZL3gyEfpef7MdPhkWgzakxdrZ4UdAZmweNHixvTuVQ9c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(2906002)(71200400001)(33656002)(36756003)(4326008)(66946007)(76116006)(64756008)(6512007)(66476007)(86362001)(508600001)(66446008)(107886003)(6486002)(122000001)(558084003)(6636002)(66556008)(54906003)(6506007)(316002)(2616005)(8676002)(110136005)(53546011)(5660300002)(8936002)(186003)(45980500001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b97ADOdlqLfJ9qVHi3xD7cKXa2h/kQY/Uh+EoGrJF9rAoynhmWu5WyVMn9xv?=
 =?us-ascii?Q?HucJDTBtDKxnrRmEimgEqROe1v2UpwHnNssOCuNxCcdTEd/7dEhzVHX/NP9n?=
 =?us-ascii?Q?Uupc2M5gVpXZ/SpxXEetn5vgb++r0hOg6g69YkNFnAQxBIwGQeNCz0cngcc/?=
 =?us-ascii?Q?oXnYf9smYstv5gI3l8AmVxXyDRiDNCFw91P7Ivy5G05uF986o6cwVSA+fXIg?=
 =?us-ascii?Q?0+D5+2Wdmi7cpxoODHxALHZXA4k7K0WIkKHrKSzLRIOu4Nq3Tef2ha+5RUX/?=
 =?us-ascii?Q?EH8BB8vvU6K4AIVGx6UCWrswTfHZvQc3HgCVlEE2DJYODzeo8Rp2IefwPMX8?=
 =?us-ascii?Q?bXMfUWElHQt8rRzsI6JaD3YVrRD3aJW2oBULyzZHYRtPbg54YKq+XRIWAbNd?=
 =?us-ascii?Q?813LP0t0j6+FCPRizDH5jFpPAgXL2BbCyTAAghoMYswMWfTErphHbsS7Mx7w?=
 =?us-ascii?Q?wjhq1tmvRddj1zjJKjcThFnnO9B08pJNzfigIryg/dMDHOX8ZW7VPl0v1xAX?=
 =?us-ascii?Q?XL0LHheqMUVB8gtxTsY1q0T09HBHs+k/BRU0UNl/Xxxq8igYB90J/wBqd2YB?=
 =?us-ascii?Q?thfrAssYOaP2h6SySmoocJ1sQLMiugPcEsa+kgd9H71B+4P8uzOIqF6zPnrw?=
 =?us-ascii?Q?pcg+cSRd1M1oTS+gCDsu2fOjfAsNOjN1oHkn5mXqLlD27nCOLhdvOVu3h6Xz?=
 =?us-ascii?Q?oiopVjMGjtwKQ81XLCDo8TuLdW4NrEmxN0igK33BBcJgPyJ2FxaZVeq0psiF?=
 =?us-ascii?Q?qAcqLtBKKqTzs5lwVN5T5vPiaTDV3WKuuN8ifv4wF5driirJtsL9zPA87sM7?=
 =?us-ascii?Q?0BOfeV+vIIjL5w5FAFEt2aPzsb0J1bmuSWVIs5hQxm0yfBbjVqebah7pQQdq?=
 =?us-ascii?Q?sMu1qVqHtT88wo3hdEmtyIxU3W12sECJSQlEWwopfRDYX32vRh8JZzgfY6hB?=
 =?us-ascii?Q?w0tTj4AbgrQjCeaG3hERIQhMWAN9rCXREnP4tS+B7Jshc5QNzEWslt5dYaXs?=
 =?us-ascii?Q?9oBnsV2gyQHsW29hG7ZptCgRs86cIjYCeBvREwGOpG0foHbuBL3EvYCYoJM9?=
 =?us-ascii?Q?FaAVyhTR+Dvt9ggYL9zFQStM3U67J6vnxRr4fIJcmtZCRq8IlPxl69QEnI68?=
 =?us-ascii?Q?2q4xRpGs5ElWqDidOgW8o/KOig6x6T7XjtgzE9TOUOHjohJ9FXOQW9fub6cF?=
 =?us-ascii?Q?Avg4QtFg+26l9rmTKMyWmO2CJ/R5v0UCYMddCh2XFOKovOgn7AG0aGs5Swdw?=
 =?us-ascii?Q?TPOwMnV8A3GD47MMLf0WozGCVGvn8kF5SbHKWnELCe27QDSXmNyeAKtlf4dT?=
 =?us-ascii?Q?HRgLiHSBY/6qBzS8qJtJS3cBZxQYve7fUbBswrixbTtAAaldP/YA1UmLda3Q?=
 =?us-ascii?Q?XhsAmnvpZgt5mpGu5gmfao6hQHUY?=
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba5f0e8-c04a-43ed-e4ab-08d94ba8c930
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 18:04:15.0660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coqDh81DOGwNn88w2BcmYUTdCj4sCIYiCMKV9sk3yWdO0GdlWkmRrn0dUJd8HhYB6jZt6bQNImmmFqOAXj2WIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8182
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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
Content-Type: multipart/mixed; boundary="===============4581404422103924218=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4581404422103924218==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0DE37084185C4144AF9E22EC044B0CB5vmwarecom_"

--_000_0DE37084185C4144AF9E22EC044B0CB5vmwarecom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


On Jul 20, 2021, at 3:39 AM, Greg KH <gregkh@linuxfoundation.org<mailto:gre=
gkh@linuxfoundation.org>> wrote:

Also I would need an ack from Vishnu.

Acked-by: Vishnu Dasa <vdasa@vmware.com<mailto:dasa@vmware.com>>

Thanks,
Vishnu


--_000_0DE37084185C4144AF9E22EC044B0CB5vmwarecom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <97FA241B2C7BEE47A7CE7E5D37307203@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; line-break:=
 after-white-space;" class=3D"">
<br class=3D"">
<div>
<blockquote type=3D"cite" class=3D"">
<div class=3D"">On Jul 20, 2021, at 3:39 AM, Greg KH &lt;<a href=3D"mailto:=
gregkh@linuxfoundation.org" class=3D"">gregkh@linuxfoundation.org</a>&gt; w=
rote:</div>
<div class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 12px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D"">
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 12px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">Also
 I would need an ack from Vishnu.</span><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D"">
</div>
</blockquote>
</div>
<div><br style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D=
"">
<span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=3D"">=
Acked-by: Vishnu Dasa &lt;v</span><a href=3D"mailto:dasa@vmware.com" class=
=3D"">dasa@vmware.com</a><span style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0);" class=3D"">&gt;</span></div>
<div><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=
=3D""><br class=3D"">
</span></div>
<div><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=
=3D"">Thanks,</span></div>
<div><span style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);" class=
=3D"">Vishnu</span></div>
<br class=3D"">
</body>
</html>

--_000_0DE37084185C4144AF9E22EC044B0CB5vmwarecom_--

--===============4581404422103924218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4581404422103924218==--
