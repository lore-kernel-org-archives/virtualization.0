Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C75C77B60
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 09:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42F5A60EC2;
	Mon,  3 Apr 2023 09:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42F5A60EC2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=h+6bwf/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FjNXy20b5MAJ; Mon,  3 Apr 2023 09:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1022605EA;
	Mon,  3 Apr 2023 09:18:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1022605EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92084C0037;
	Mon,  3 Apr 2023 09:18:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3B9C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 008A14109B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:18:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 008A14109B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=h+6bwf/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q4E0A_WWKDfm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:18:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CB8F41061
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::617])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CB8F41061
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj+oqW5TcruLEVqTVTA/ngBS/CvuKyXAAQFeFr2hVtU0D2CpoMgVxjsDIdMG6lNLOFhHLM7qtx2qIXRgzI8hfubbLVo2jNCR+adpkfwZolmqOp5HUmZsqKLGI7y1SdSK1n9rAV+/tIs1wY8RJyRJfBBs8C+ZfQBw6aTTXugSJI7R88NuM4wEuWdGnljQeUU8/WYQRtHSI7KXbrOQ+y5fNqvqh86y+mKYjJhpnPZx46TqqWzd38Oj4zzK90tDwHVCEyuJdW2hpoKbtgTC+8FWcy5WC2zqzbDvXrn9+DHul8CudyYPduKK+PsodgD5n1cn5kFumcv6/buNDbsveS/lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaCdQDeH0HaAigFaUdtLH4uEZdQs7M+GIcVFPnfkQ74=;
 b=DUlLk1SuhV9k5vYF1Na10zjOoEAlPg5c2MLlBfXHWX7aTEcIPYAUtc564qR+V20UDv8ZFD2yyUkV9PqX0Xf8nKKQNBHDRSfsbLVuIzqMiS+WjKnyCTiQx7oJtyNiup/HAhQe2uHOEaXWBx5pfg9tLJ93v8i5l+rMQRq7XENISyE3s65k/sZdMblzNKXw+uYX7EGKwITKJ8/itNQYaLmvR3JJiapEa6mw3DrXXHx3liN/9ooy1Xu+KCw6uOp4aqeJ2SfZkThBtB+ZLa525AL8PA7S+g/vpcyS5BE1t1Q0cy/9FhgBf9ap6f+Tv4+xnXzMzyOJKIjMaGgMn03YVmeloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaCdQDeH0HaAigFaUdtLH4uEZdQs7M+GIcVFPnfkQ74=;
 b=h+6bwf/drobAGc6Rib82X6Qx4VBQKEb661Dmb5ibjgcneTTu3L3WO6Fi3nlLyRq0OzrSdBoJroV2veBj7pK9SyppwrQOvpEQ3ct2SzjdJB0HmEoogy2RS2GTvRxQPiYasaheHEirIG0M38yOz4hoHbrTl+384wRxtBAHjco8xHU=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:18:38 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:18:38 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ
 state
Thread-Index: AQHZZWIBe5Qp6TTWaUKs4Mm16+1eFq8ZDo8AgAA8M1E=
Date: Mon, 3 Apr 2023 09:18:38 +0000
Message-ID: <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
In-Reply-To: <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|VI1PR04MB6957:EE_
x-ms-office365-filtering-correlation-id: ff6ecce7-ebb1-4d5a-478a-08db342468a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qGKw4UgPP8DmW0xTB9dnHVP5e6HsJcqup4a7Je8Ojv4BE6UXGSsQkQL/nat5X1ANydpd+1OwhvsfBJcuipUCBHHDCsGUTd/cUQE2cNVOKzJLfJrxfZ8uhmbWmS304vD6c18skfwC3p9swkSmu16V0wtQzTtu0ZmZPvJCo/Gg1DoY4YBA0Rs1HcvDrmmu3fN2zmohGM4fT8zjJa3eE1BQL77hCKnX5QI7Y8luy5HdP8HgVAmSRVgGkqBLVUBAmAiUCRdAhJKxJWkisEQWVjyhcMhs7nlCDewOxudiarTrfmiDa/23PnWYgSVZWA/XbeOGbJniFM1RRN2WCRGnYHlnUTtVN6/WMSuMVx7DATFq51QGVX7+uF5U1sElkUkEgNRuhVOpV5GqpMVWQOJeHdDm8Va52YLzJU2KH3x45epXFGysiNWoBEsGwaOpR8wGaWFGUGautdB+rORFhV+VLdY15pMxX2xP9WJKnpkfRqNibJ7U4BQL6Xg7sb8hOW2dFUVAHroxHNLv9lxuh7KmZ+NOuRJe+PKbecSY1Dr+Ch0Wz5VW+e4Aor25hOMSA8yxsWs1b1rCCdMJ8/W6yc9H/EwoEdyd7y1mv134YKxF+ZVF+ffJMXjlH9n/Id3ojBTbrZmZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(136003)(396003)(376002)(39830400003)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(7696005)(71200400001)(83380400001)(186003)(9686003)(6506007)(26005)(4326008)(6916009)(91956017)(8676002)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(41300700001)(5660300002)(122000001)(38100700002)(54906003)(316002)(478600001)(44832011)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jXCcNRzCkb5MHiKxDwk889CGzgYbU4097cNnrrNpw0AcbySxIhARUM5hv5?=
 =?iso-8859-1?Q?yMiW+FrUxD0jFqdABb7nY0qjeoCRkb5Xz3pUBXgHYYt4fGtAVYkSTW/rlN?=
 =?iso-8859-1?Q?1tGtcooQ9BO0+Wuv3coT1BNbUVNvDGDD+wUnJ8Ts0erCeRio4jHLeN+r5T?=
 =?iso-8859-1?Q?tC2yeV/TsGjps3I8gis16uLXM75u5wmLlIB5NDvO9xd/PKm63ClO++VOjG?=
 =?iso-8859-1?Q?j61oUH6fN0JGoOMeEB9C9VnEVyL5tk0aRFjBFBpHoyGSlg+bLoopJhPx7A?=
 =?iso-8859-1?Q?S237X2PvqG0bWJZiddF5G0JaF+gIsOKgvf06/0soNVxYKVCibwnGLrmZgQ?=
 =?iso-8859-1?Q?4LsvbyfndQSenemZQYB7C2YAA4Wb0OFZU9fa3tuxEo7XA4o4Al1dmi+KTw?=
 =?iso-8859-1?Q?4Ct+f4oTLM0/AyzM4WfzpY1iWb/prW7LJq+tyjyV2A3ACl9FXJdkOo/s3s?=
 =?iso-8859-1?Q?Eh1clcPRHKHLGolu3gZyjFzSKmLF18yWBgxdy7D/9MmI182XSHbqzx/eJj?=
 =?iso-8859-1?Q?cf8YNVjbrOOBkQl6kz7hUhON1c9uvWd+Dmkgw2Vk4ik68JYApNGIZSwiFx?=
 =?iso-8859-1?Q?oWT0NANCf+qIER/N7cvluOgNTiyBy0MHY4o7+GvEv9QSiL79keiaOtzW+E?=
 =?iso-8859-1?Q?gsEw3mZ2PgrhJaYoGPg5ghuTriymXGgUN+NebBVvnb4TSPv9xC38PXVhmw?=
 =?iso-8859-1?Q?8ctlD3HWUFV4ACqH5g3AlQme8Q6qqPWovXUklo8eCK+kACBBl5HAq4MQnC?=
 =?iso-8859-1?Q?BO3AnWN7NtJpVFJPJ+SW9Lm4JEW8lKeUTAXJ7cDEZXUi7YC1FX1mXoBI5r?=
 =?iso-8859-1?Q?TnAG6lvedzhV33Nux6W6fZlzhQt0QMzuf+m6+k0XSgggnVMFSulghZKG2g?=
 =?iso-8859-1?Q?/DOnBnFVTIwZrbzNmMyizTc4rmiPzsxsyhCtbYgRGXrAwqma2Ctdfmi0I3?=
 =?iso-8859-1?Q?hL2efnAWJPQTA/YhF0pKVzmgQMsGWA6fT/evWvvyWmMBHIFOTEJvg9clK0?=
 =?iso-8859-1?Q?NOIkWhmGwh7mDmYtSApAC8WH6YFdA/NlJv2gZvSah1QbA3q2rj7K4DT4Kx?=
 =?iso-8859-1?Q?19jbHVlWdhtFyA5kFiou9VG8VhvnUwd1qiRCcROPbpv0134rcDtw8DLP1O?=
 =?iso-8859-1?Q?4Z0nuKCgUz6EOAwQVhpZYit0KVToiPO1sB23LqkKzLLwVzRc7QGctuMx4J?=
 =?iso-8859-1?Q?rwUWH47gtFAcFtJPkTM7gYGbW/OIT1ERfrzmbpmaTQGzbMykf55vGSUYB+?=
 =?iso-8859-1?Q?JVREW5MwxHJ7bj4I+EDvWFw8LVZPtOQMrevrZzX7Z9keLhMimDfZrBlBIk?=
 =?iso-8859-1?Q?wawh6J8rq9UKvIVl1g3zTUGMxqWXwVfAJXkNAUuoS4/JIsu1XFlWmXEDwU?=
 =?iso-8859-1?Q?mxnp376h4ygg/V5fSAxlPplMq/uLPMl/sKRuSxQ1urjBLtoTlxDojV1TOb?=
 =?iso-8859-1?Q?6SiU/wan/VMueG1xnqsLuKTOyzEPyv5GonS9g1HdmRnmXMGk5R+Byvve9a?=
 =?iso-8859-1?Q?pZuW9h5iwKmXODT6ccEDDS/uin146J/mDUflH2HFTZV0wvJKsjRNXv3LVv?=
 =?iso-8859-1?Q?ojWiZxF73P5zn9dUbb+tvri2cKN1MzXMBdHYAgzjul2gWpBn2OXaKUwW3h?=
 =?iso-8859-1?Q?ICRgNw4X1sEyIJdwRqqxTZVdA9GA57M0Nz?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6ecce7-ebb1-4d5a-478a-08db342468a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:18:38.1840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mSgSiaXaOz2vCVCLqKAVQ0Bv9aqxxqkOn5gQTg6BgvPSDscYlKqbq8a1whdLLctSQAnF7LtWG9wf81qrSrNO6Lykgd9em0ERjNN0j+X2l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

Hi Jason,

> > +       /* Overwrite the control register with the new buffer size (in 4B words) */
> > +       snet_write_ctrl(regs, buf_words);
> > +       /* Use a memory barrier, this must be written before the opcode register. */
> > +       wmb();
> 
> 
> At least you need to use smp_wmb() but if you want to serialize MMIO
> writes you can simply use spinlocks after the removal of mmiowb
> work[1].
> 

I'm not sure how a spinlock can help in this case.
The entire control mechanism is protected by the spinlock snet->ctrl_lock, so multiple CPUs won't use it simultaneously.

> Note that Documentation/memory-barriers.txt said:
> 
>         1. All readX() and writeX() accesses to the same peripheral are ordered
>            with respect to each other. This ensures that MMIO register accesses
>            by the same CPU thread to a particular device will arrive in program
>            order.
> 

So it will arrive to the pci subsystem in program order, but the pci subsystem may reorder, right?
I can just issue a read after the writes, something like:

write_control
read_control
write op
read op

What do you think?

> > +       /* Clear the control register - clear the error code if previous control operation failed */
> > +       snet_write_ctrl(regs, 0);
> > +
> > +       /* Write opcode and VQ idx */
> > +       val = opcode | (vq_idx << 16);
> > +       snet_write_op(regs, val);
> 
> I guess we need to serialize two writes here as well.

Same here.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
