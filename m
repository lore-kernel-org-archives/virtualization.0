Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82999C76196
	for <virtualization@archiver.kernel.org>; Sun,  2 Apr 2023 08:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EECC60F62;
	Sun,  2 Apr 2023 08:36:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EECC60F62
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=WBucrrEX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ZndiPVndVpJ; Sun,  2 Apr 2023 08:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95B0A60D51;
	Sun,  2 Apr 2023 08:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95B0A60D51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77410C0037;
	Sun,  2 Apr 2023 08:36:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769F3C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43EF181F8C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43EF181F8C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=WBucrrEX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xaYpJb1DWMs
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:36:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A083481F6B
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A083481F6B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 08:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAl744SqEaLpYEiNmgxvbxDydHH5eXYKvsPAsu0JLCHZ2YqrqlslPDOFelJcrZwbRxXdCpqGv5NhF5Wkx1Jb7I6w5pa8OhmmVaZ5CCTdwo97AoKlBuCzJA/PUswBb8geObsgpch1n0J61eHicZ/aVBuREQiPPB+bGpKAtN+7dOEnYFGzbADIDA/4on6jyEwj2k/jkUSc1ng47qFbj5VHwUBStlichL4EKl8mwK9mVLe1l4ZxyZmQ5oEHs0bPjCV1XhIO0AtCmiLwUrcSKCmjNz05i2HLxzRSnE1MjV6oD3zxsIP4Z92mhDoyl8IYdZZOySaQZpiJJtHLWj2SFzXO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp1F0fMq8ibrwYexnLjTEcYwB8F2CqKfuLHDhdaDJ9Y=;
 b=g0j5LeYqtntbAS1B3jgV6tmc6EeoeRmzBQso+fH9et+j0g0bkp2YCzyi3LeDfis0cowWH5P+5NKHRjHr7XU/fG/NmytX5aM3Eb6Sl+nceSI6eAgBg6R/dqZItjhqUnv2rdfKqHOSfUC5r2BZwKx68L1dNEpZXR+Bot6OMdiew+15Sr7XdjAH52JST3G8j7AhdDYrPAJAsUhCE8mghRRZCxVfA6z9awrctNQ84Ckwa/Lya3c/EUJAATTiCk2+MT3IlT3Ue7aElY3xd6oyFrNaQrvHe2uTBBePH8mfHWYh5KQrQyia3ab4NKwKx0Fn2VoIrMYAG33CcuncELonh1IUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp1F0fMq8ibrwYexnLjTEcYwB8F2CqKfuLHDhdaDJ9Y=;
 b=WBucrrEXt3fTWM/dMlJkCLnI9EBMMU6anX34kKd6DS5juzNtXFIh9rZDOwmzY91ObAJxsPOWx+Lw3Acm78OFikgHhg3k68m5YfEggm4iyDXwfQUbDL0OEBMIhqyLY/zcUJYRm/1DLdSfQVHiRzAMEvs38j4VLqPU+pbophQ7tAY=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Sun, 2 Apr
 2023 08:36:20 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.028; Sun, 2 Apr 2023
 08:36:20 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Thread-Topic: [PATCH 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Thread-Index: AQHZWxWF/MSQE1UyOEixwM69Ey59IK8OOh8KgABgYgCACSkdVg==
Date: Sun, 2 Apr 2023 08:36:20 +0000
Message-ID: <AM0PR04MB47232709E64E84D002A5CF80D48D9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB47230415F00797EB85F0CD41D48B9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230327083313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230327083313-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DBBPR04MB7977:EE_
x-ms-office365-filtering-correlation-id: e44ca76b-8474-4ef0-f87e-08db33555587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXoA2B6N18aJDQUZa1pfTHjEZKvqOdLu3OHrbHMP7+wAiLOTq+THGHrD+a3USEDdgewJU76ijOMusAYTrpbBWeE+MMG9XgEMOo/oWur+WHAyh8Do31lHYXx3r48HKL+ge95Bei1urJcq5rloKqofi1gkGHyJnaNMroWP2p+ErtBeNLqvVSN/WXGq1zeiB2+/mfzVDZcG2FGJ0XnmYwWJJQX2dVwDYhltHNSVd5OfNyPoyt2FxtLTWh1hqUZeWHcdzGC5mpw9pZi5hieX8rgJ8uUhDAFoxI43F7r8C5fie0O1QDh/rOSlLpHUpFfWWw+OGQEFWWdsPXUkBC15S5b11cK6HHL7dePPkzYf1zZ7PtYt0/94qe/KM9x1grhNmXENlz6R/1wak00/DlilghF74dZxuOnQMFlxfPXW7h7njvtyDDBS9lL4x7vAwfIe1DEK6aV1uVcTn/F1AXbmRbyfTWa91EmgV7f9orjVQ+Yq0QmA8hY8ScK204PIoLzb8tGa/Q4A7bJ6QD+VAbuJfw9MMOQR4fJ8a2ZSlxqsOO3uJgfNDNNJ6b69VR/BtzWfUvVtB7TRvtR30pvMdmpLUbJbzZVp40e5uD+F/JfNKp/3jLz5wrGTPboaSKSWaK10Exqs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39830400003)(451199021)(55016003)(41300700001)(91956017)(8676002)(6916009)(4326008)(66476007)(64756008)(76116006)(66946007)(66556008)(66446008)(478600001)(316002)(54906003)(8936002)(52536014)(122000001)(5660300002)(38100700002)(186003)(7696005)(71200400001)(44832011)(26005)(9686003)(6506007)(86362001)(2906002)(33656002)(558084003)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H0WysRMgY1VLkygw7+x+ShOCwWLXXMX7EHb9XQJebhrpoy6LB5sPnO93XP?=
 =?iso-8859-1?Q?MS7bhUn+wVUKeuAgbcUrW2Ip/4QjIlZSVAve9wisqjrrdtqiE6U0t7Nfbz?=
 =?iso-8859-1?Q?EaYWwsoscL4HAEoBIY9KafE8kCdvqLR7G1uxzV51jieMsjbLO7IUdyIBkl?=
 =?iso-8859-1?Q?Ws9gImBaTGBPmeir5+fmvZgVnwiQSjyFo18m9RPWzxkSR10xiDzWo68c/4?=
 =?iso-8859-1?Q?inwsO9pFc1OTnPg0OscFURJxKmxHt9LBvMMeJHH6cyRmCy6K1wfXxrKNjY?=
 =?iso-8859-1?Q?9Y/+CP5dXb4p+jQnuU2DpNiBrxL44lphl9YCBANLaNrzRezWvTOUoQKP8K?=
 =?iso-8859-1?Q?R9+AylyDR59uy1x/cnKcglxRhOt2sI8J7cvNs3LsILS7bvgU0qWdabzlK/?=
 =?iso-8859-1?Q?kwrvAhHWqNjwPic+w7K98HRv/WWruvDACKdKJc+ttxPnMGGQykeIbHDMBd?=
 =?iso-8859-1?Q?Vdr16dgNdFJ2qw5QBsQdZ0K1nFh9s620VLI+NTGKHBEvagx/t2A/cg+nT+?=
 =?iso-8859-1?Q?uY6vzQ1GtpYKF0+V4rfPzmOH5Y4lpdMF7tdr47m3KeoTeB9NxGHfoCgZbx?=
 =?iso-8859-1?Q?zFZ0VtzJtzjiUKri4dRvdXwPy5mwLdUkrAybvW3gkZLPk5/XhADFRm6yT5?=
 =?iso-8859-1?Q?6miHYq2y6I3CecR0zMMHsMB0nJjviVNACihL8ZPeV60YVVbgIquXTwa15/?=
 =?iso-8859-1?Q?FlbWB4xQpx7CNknUpJknCnIH7Qalq59RNERPMNdFq8eT9LJdc0fb1JGthi?=
 =?iso-8859-1?Q?PpvwF6p2OPiJIjek5WZuqhUo2A9rnrc/M3ETsoK2q0VTjSfLO30N+y0FBM?=
 =?iso-8859-1?Q?x8IN4Ot0Oru3lzeR4MP0Q5tOxrj2RKLKwg0NwKrs/rM4v5l4beERyc7ZCQ?=
 =?iso-8859-1?Q?Et+6emJmHz2FF94T18NhBD6x1GgnQHSHfBaqcpX870cfzUnKe+pG453zet?=
 =?iso-8859-1?Q?JseaUdF7DW0n6eqaf2sWeWB84RgFDPOyrGReUfttVdanf5j5ElF7CNfovJ?=
 =?iso-8859-1?Q?NDVGyxAmit98T0kKuVfz9sNn/DBxFPvQCa4XaUL9785D1GzOWyAJuVL6NO?=
 =?iso-8859-1?Q?vb7fUM5a34I6qCB2Pjc1rhXjK71B+p64+w+Z9Wm1M+PH/bZ83gHzc/29CP?=
 =?iso-8859-1?Q?mLanbA2vigzEVfjb4cEvv90pZ3jpB+Jz71CPr5TvEGFBAD5L6BLGAzpza+?=
 =?iso-8859-1?Q?9KLApGHWRfeEyC21qdVlYHQBOE7Gz4FDSiVaO8TeeSsHXpKkBOLREO7w4Q?=
 =?iso-8859-1?Q?OuQAuXsc2vmIzWTUadZAV9hz4qw9Xe0dVK/XcYju9HCLkMkCeLGk5e0IAJ?=
 =?iso-8859-1?Q?y4yXP1xdDiPZUI+sM/OtivQpkRvHqGLSKgEM3URX10TTJJ5rS/DHvU9swP?=
 =?iso-8859-1?Q?r46cN/CClAh14GfG9WaFPulgRFFXga5eUPfcaAIYTp5IL5iX1WENc7PaPs?=
 =?iso-8859-1?Q?94n90EYstW5sw5QlgTrAhtzAVpZIjxVe/mOu7EyBPnSWVqv30qaYAeoGgs?=
 =?iso-8859-1?Q?8zneTrRjeVNbveMOI9WF1b21jVKnS74Gy1diN5FTcdSL8xMABlX8dXkjb8?=
 =?iso-8859-1?Q?IvCDBWNKqyOIrmFijh3nhZLcuYEoAcslSF7qqlrUUNz7N45oFzWvW9j598?=
 =?iso-8859-1?Q?eSbrpeQ6H7yM2ck/6GaXz8SqG5lWBY+xzN?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44ca76b-8474-4ef0-f87e-08db33555587
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2023 08:36:20.3164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoKVgNycHtBnsHxNAZOBwGgaykAaTAEMrS5dKxQw58DWkByWXLo+rgbcqnUIFmK7OhXaIGDIS+CRYjiGCEQP8dItzyAJVzXoGpjL3GHT0ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> tagged. in the future pls CC everyone on the cover letter too.

Ok, thanks.

I'm not getting responses, should I resend it?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
