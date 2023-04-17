Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E04BC77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 11:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2659641CB5;
	Mon, 17 Apr 2023 11:51:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2659641CB5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=jBWUNcVV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNJsUKlFcRqD; Mon, 17 Apr 2023 11:51:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E113405B3;
	Mon, 17 Apr 2023 11:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E113405B3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70CC6C0036;
	Mon, 17 Apr 2023 11:51:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E34C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07EBC41CB5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07EBC41CB5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUMBBoksv_gR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:51:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A66D405B3
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::605])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A66D405B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScAp0HJM6fur7J2rcD9eVA6OjkUuIziF0HGYgGzFkOb9zucZqzt6JlLiGFk6cQ3xEnPw7pGHaCYnOVfSAYYAbxbYgSMIOXRIlSCaYLmoVq9lgJK1OVamZUBMwG9M6GUyjLTYg3hWo94Ge9OcXSI0ittOt30jAE+Qau/tA/nhYh6fxUWhAtvRThXSs8RG626bTnKR37oQIz6ylIPWD0sfpK0ISj6nrnLfbtQUgQfonDlubtoZ3KAjieAyDE0r5ANvwLY54jlBXvtMvGSKhUu425xwZH2WRxSsqCfNI6SVkHzI3YNlmsJ9ReYIR65Zij6Kd2PbjePnAhnAu8BvViddTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+7EPBs6PFM45LKDam3m8b/fAvKaiKLqxzG0NDHAQ1E=;
 b=ZYCKshzUdvhhINFCpwigROGFl6HNJqtwV5FUjq+KccIqhBZjH7wpsPZeHQfykBqB6fj8Jmmj8hBx8taplpn9/JPjaAIvcRiwMb/o2ezWHlLT4xlcU9v3H9jv3yypCrjrLMlZorl8Ou3H/OlIVZ+pstVkYwFH6jHnHmFbMgt6LyLqpwc6JZrRH5TT8bKSK4Gu2LPDkf1a6z2OP6x82rpjbcqKmmE/ITnqz//jEJGvfmv3ZIRQCZdPcUzpdA5JhpFMKzT+cMpb+RuiX7icYlfLT3EWguaPXrfrbPSi/MYWwpq9Wyju59idNhaU/sBYGh9lMgZSkT4EAi8mriGoZfRf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+7EPBs6PFM45LKDam3m8b/fAvKaiKLqxzG0NDHAQ1E=;
 b=jBWUNcVVtTy5siyWo3GiIQY1lUwFK0BiilU6GljI6+TMcoxzzj7aqPypA5MjtGnu84wiC233Its+WYPsyLdp4c3KeXOIdXRdIyy1TnZy0/r4KVLYOP8oN8RuHLoK+DwFusyDL9Q66yGnqHvrno6+hX+QmK79n6uZmsHPszwfcGs=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS8PR04MB8037.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 11:51:22 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 11:51:22 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATIgAAENICAAAM4M4AAIQOAgAALfyGAABuqgIAAAQKH
Date: Mon, 17 Apr 2023 11:51:22 +0000
Message-ID: <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230417073830-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS8PR04MB8037:EE_
x-ms-office365-filtering-correlation-id: 6c7eeabb-3ae8-49c0-58a0-08db3f3a10f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMc1SBHOvrcNVINToq1aLBJkZbmOmHvwufHDQ8lFFJQp1CjcPJLWkO+RnqresRXDKaBAb3ENMVHytE7imEuvsHjcToUtDwns34moesdlv1VDW2vZuNo7W4618reUyksJunWnuFeZGyZ3LyjlVlKf+g01QCFATHNQfItECofWLP6c0JJlcG4vVInmGvKo6jpQW2R63oq/QwzFjbNESXJzPITE1GoAktm56/JNWV8O1tyohInUlr7TxuZuMsG1vHvItX3R8TYG4UxtSssCokT58TIRijmNaEVtIBxv+5rR3HNwOepf0psoqOEjZv8U3zp3/A9DZb+3t8yWruE224k0HWWxn55A0HK9bZHTqh5ZsHiDLaIhgOgbFRQ3KXQohS8yDPel+ZqV6Nv0l4rFTC8jgKMXm5y5Lq7hYHdcIOCRO6Ix8Z8bpZugYg9Ds3KsR5YMPjDHZn6H4jL9dEI9GTb2E9vV4Z1RgQIQH2cx+cVRc3UFLlTaJOljIzWIstx+sNQDikLfahZ4ze9HlFxzV48jz7Cs7cWnYPhiUXH0QdMyfnfSlz0e1uEUPvguQdnZzhxBk1pdMTZujdbS2F7dcDp4kjUtuD41a+QF+FgOSffa03U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(366004)(39840400004)(136003)(346002)(451199021)(54906003)(55016003)(7696005)(71200400001)(478600001)(41300700001)(316002)(91956017)(6916009)(4326008)(64756008)(66556008)(186003)(66446008)(9686003)(26005)(6506007)(66946007)(76116006)(66476007)(52536014)(5660300002)(44832011)(4744005)(2906002)(8936002)(8676002)(38100700002)(38070700005)(122000001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OrIlot2aMSkxr9ayCZbydcf07c2018LBSOBnsVvodyiTvU3MM8BO73WO5E?=
 =?iso-8859-1?Q?2kvn3V2vmFtGcxpxybKmItoCET3bfoQwpfGVX/fRpqVBHTWA7qcWtYTrKs?=
 =?iso-8859-1?Q?ZIMVY8jXDRJXwoCEohkEUJRD/kUUSfYgTXfL2nuTOvl0mqXB4AjZhElQOZ?=
 =?iso-8859-1?Q?fsVlqRNPcyk74pVrla72PC0r3ZztPcaHLzPyG5aJX9fzzqcCFfVhJ2WIZy?=
 =?iso-8859-1?Q?s438EgcHCSnCzQldhSiSnmqNmfoLiDVC8qWkT1tFWfIfVs5tmmWsC6zCnd?=
 =?iso-8859-1?Q?4Rrop3LTyVbEMHNxCRpwBRUlgj+SaaSn54L9OukQTGMVPVhgkeRRY58qOf?=
 =?iso-8859-1?Q?3slL4tfC5U7BPOFb766YgXZko1qcnCz9gvRCU+oPieXculiX6SsS3njwSH?=
 =?iso-8859-1?Q?l8MtO1fODUN0hASMn2uxCb+Yw2Yj5DG+VngXLHkjEa+zt7aCHsJ0rbNNFZ?=
 =?iso-8859-1?Q?3MLiO4gQgCEfYYqIFJb/wxElYhXoOPbGdOBU43ANdw0WtLJM+1kLQRf12u?=
 =?iso-8859-1?Q?Io43Z/od6yqVMzu/c84XOFBXateuc9nCyYWgtUmI7XZB2M8SHDRFgihbdz?=
 =?iso-8859-1?Q?z8Dt+zlZaMfz6k1/hcsfvvSObOqyXsAkB8OQ5Q2eVoIQtm8lOxt21UYr8E?=
 =?iso-8859-1?Q?uDsBDMYr2EiS1C1EuIk67dbfi18YQ0QBZ48b7ANKT4Z4118uO3FCLsf9Xb?=
 =?iso-8859-1?Q?0OvH4HBYAB9um498CIUgMhIlcaKSGmVhN9jwTFQHna/6O/rlOY2FqTKbLb?=
 =?iso-8859-1?Q?pA300qgxcSuaH1RWZ0OGGUjTg3yyEU/qJyGr3wSOcpN6NRy4z83LAIvg/Y?=
 =?iso-8859-1?Q?frJx+WaCwVNUehfR3hcOFbq6f2UaOfCStKrxDvNGMA60cgTynrH5ONILgP?=
 =?iso-8859-1?Q?syVr+0GDvsK2o7Sdym9Tc/m4ExtV5ZoDqr4UfQtHvMMcd0jCa5/+L+INv/?=
 =?iso-8859-1?Q?/JN4yZBz52YqZ1+puZVqm8qBkd1LVfn1feK7wwEdH8LcyZCkDOyE75JHsm?=
 =?iso-8859-1?Q?hXAZBHdfOKuhYxoJu+5xzI0XtnY1jZwN0S8edpuX8VgQ5Usq32W+wu9aw+?=
 =?iso-8859-1?Q?3QNh5IZyBSuZfThtogzJN8QSx7IpOlZjstte1henfco03bepIHxm1dp1Ot?=
 =?iso-8859-1?Q?jGv0yK+lKl6igKB4iDMOdhOk1+bPY14+x/7dbKaSo1TTZU2c5sp64nxt5R?=
 =?iso-8859-1?Q?5TJPZdArSxDOfCD97Ndw6c8lI+UaQryOsZf/onZTeA0IR9qMcDV7dnIbqd?=
 =?iso-8859-1?Q?iwrBnOkcWvdQyfrDLJkJa4GcRO6G/uIWrTq62tAa6uHHewEh8o67oGM5tw?=
 =?iso-8859-1?Q?3J29vK49TcTZmi1uXT1QvB7VPOpIqtzFy15Af1X32tPz/CrBxUyhMxekOC?=
 =?iso-8859-1?Q?dD4PjENTFPyOVJt3JBmRHe31kWt0k5HGrt5ktQVGfnTdAEh9anhQjPcZk7?=
 =?iso-8859-1?Q?P9sGeN5Ztm762Quyl+cQWr1jI+AstpxzHwyiMLfR2AAdduAWgdzaer4Xj0?=
 =?iso-8859-1?Q?ioNRrj8VG3wJRDII5Y8KKN6+5cOCPpjndW16HCtrWM7X3QvVFgQ/svKXwH?=
 =?iso-8859-1?Q?u/l8gvHqkNEdBwJP8GYauJi52FL0t5bgg0xLnATKr6lVROQ4WL9V3mnZ+p?=
 =?iso-8859-1?Q?yLSEhbbJ8vvmjI1oIa69zvl5JZDUIbkuAq?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7eeabb-3ae8-49c0-58a0-08db3f3a10f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 11:51:22.7999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oV3FazxrFm83Bp4JPwDrKUZ4KpPaxqSFPr1+sfccSkDgeKEfHTrQhE3PUBjVQzNgYGxMfY1w7bptnFEKgtiayJl4bpZiqJAvZDk5Xgj3Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8037
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

> > I see your point.
> > Regardless, we'll need to fail probe in some cases.
> > ring size of 1 for example (if I'm not mistaken)
> 
> Hmm. We can make it work if we increase hard header size, then
> there will always be room for vnet header.
> 
> > control vq even needs a bigger ring.
> 
> Why does it?

At the moment, most of the commands chain 3 descriptors:
1 - class + command
2 - command specific
3 - ack

We could merge 1 and 2 into a single one, both are read only for the device, so I take it back, it won't need a bigger ring.
But it will need 2 descriptors at least(1 read only for the device and 1 write only for the device), so we still need to fail probe sometimes.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
