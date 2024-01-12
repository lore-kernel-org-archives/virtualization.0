Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947D1B28E
	for <virtualization@lists.linux.dev>; Fri, 12 Jan 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCycetii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axd6Lt5doVwvbJpaGhSerZ5zD5dFq7VfiphSCRoEqbFpjuETaZMNg/HPTJu78okJl1UmsAhFIVp1o32TeBynvXrk94gwxqMGAtWJIlfX22dYUgX0qhFYUmO48ANwToTb4X5XNvc1FhhcocYCPlJ0PXoBwkyE8vi2IjY0eCCKN4FZjB5AfcJzfLUnj6vfacxMXLIaBfvtGfxDjdN9NLQyxf39I0NlshQ8Kg8DbPc1ijsfZ7xlVJYdEKUXKiW3Xw1kHzk0LYoMJpfMFKETlStifbHgwEuFp++E+tfmK/AS/LHF5GtLXGCSHn3ZT4LNDDgqB0az1fMZ6NeCXSxXJyV3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rIjWVZFp30v+Cw9wH3QnRcpN3GpvNfcNg2gvMRk8QY=;
 b=W4mqDPSOXBQ0Qpl7wzSj7i12A8uVkz/XYwt+r2oBZjGQyesULnrfViYThVE+lUOOCVfHgoTltCrRXNL27UfWXijdz5Y+oQIO02lKdoBLQ1bCIuISMRVTEG4WNTz3+UCCFSHpYpZrX6czlI0TNTAqKIbv/HFCRqufuTQnzLVsweJ7qXkFok+qwvZr9VJosy0DeUl6pKXTYWlRG0PN2wXylES1Os8IxzQIMCW5hrztBW+yI3lAC4pp1Zoqw6WfpvG34Kl1kQkgdeJLRZVr9oc8s0c+DRSF1S7jHs5d1gAAjRmh9d6G0TlE0FveMOpmMsoEpn5StXzTtBQw+Rf6Rlh+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rIjWVZFp30v+Cw9wH3QnRcpN3GpvNfcNg2gvMRk8QY=;
 b=BCycetiiMI+H24MXDFvuaRWpOvb6REtcqlFO0yy6oAWCK0UkimZaj52PoqOWrb3t3wvIasHpqdQLBuhdMbf4ySYypsmCmTXQ3PmLjFejUwu0V8TMYIs3xLF+vhBLliTqxmVqLWq3KyuIJlsq8Sbd9mLwBK18s0BBA0hq+BZ0ndZ3rS6TmXlMOTRWPrFytJrs8Rd3komm4c7/9MbwbqHDaXiDoSwv9hqAhhpRE/Ud35b1Zc1SL7ALkKrGX29qjDWWsHorw/v9ZPh2tsBq4W3tMJSjTyb6mFPQrOPU3QasTUXc02Z8CRnINCdUKiCHJD296zS9kXFQGhNjXdsvNlG9Sg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 05:56:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b%7]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 05:56:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>, "Michael S.
 Tsirkin" <mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, songyang23 <songyang23@baidu.com>, liubokai
	<liubokai@baidu.com>, "Song,Zhan" <songzhan@baidu.com>
Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Topic: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48wAPSxcAABU1/AAABurT4A==
Date: Fri, 12 Jan 2024 05:56:15 +0000
Message-ID:
 <PH0PR12MB5481DE4A9137A1B3F7FD6B14DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
 <20240111111921-mutt-send-email-mst@kernel.org>
 <bb7ded91cfae43439bea555d87fa96a0@baidu.com>
In-Reply-To: <bb7ded91cfae43439bea555d87fa96a0@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6258:EE_
x-ms-office365-filtering-correlation-id: a8e2a17c-a3cf-4266-04bc-08dc13333033
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kl9h6GL9rNGH+mdWmJgD4imo+Z9ZTSjisKafvUk3zdtSLh8pg26VSNSwWmyVRQJ3b3UGFfXzgFxoz+0HY9femMHyF5wyeypCUMuvJ3UqBWWjbmfnRNF0Ee1Wnf6s9mbPXj3b12gjWaW6x+hHKqrRz3p/SAhr71IhRXqDifVDW/jrwSZZa5W4XAyyMspALc8/OxB3L/DsHcpm0LlFOgjmQCzKt5CQtXsXZ9UZhddAC/tHa8VeHA8v5ZKYqtLt5g+vUY04p0elQ2v82lsiT7FuIJhEn3KH/gxH5YYc8OFeVMz/bkLvd1uI7dNzZIv889J49BiQQinQF/0I4PNxNdgIB3qCObVlgL7tbJLJQ6YIPUCS9d24K6l3VlNAyr+yomVcQsuUBXn356R6vfy3gpacCVtumpHv/khrqEloJ040ym2dozImCcuKkCo+3YEDgr9WOBQ4KT2CoJ+b4jePbtiGSPGDzE2n9P0m6tq2My1gijwIZWkt/O8drdjt4wjSDdi3+w+OmvdTxPgnl0kksLLK07dyotKTA4wTPf/A5EXc2oDd0t+sppSdbOyQj07nRby+Fb5LOudtEMjmE6+zcZ05+qn1PYA5GzkO66a18DpS0oXMedZTyTkxLBqa/ebDhoWx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(86362001)(55236004)(26005)(9686003)(5660300002)(2906002)(8936002)(316002)(8676002)(110136005)(66446008)(66556008)(54906003)(64756008)(71200400001)(76116006)(7696005)(4326008)(66476007)(478600001)(66946007)(52536014)(6506007)(38100700002)(41300700001)(122000001)(55016003)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1V53E1CFhn88NXlbHdStMre393mBHphs8mAug/UeZuOLS5krojY290wsn3hP?=
 =?us-ascii?Q?LMWPV++Kg5aLU1l9ZnowBWa0WJu/aNJC6dmztjSTMW8MtszmlO5aHxPc0gFe?=
 =?us-ascii?Q?2ew73gP5LVmIdKnd99iXnCxf++4VULoGn4PJgXQrwb3k+vehvjQ2kMGTpnZ0?=
 =?us-ascii?Q?c2fDZWuMGdMb474BXZc50RuTmzhfHBeIy2QZJZUg1lOhSOGSrk3Y2adlyshu?=
 =?us-ascii?Q?m/fOn6lez7z/OvsqtlY25ZF9ml0hTIzORpqwBgmGiGxFVaIRQ/PV7q04OU1R?=
 =?us-ascii?Q?2EMUt8gsJJGizXzvxxT9yt6fq0gGf5D90EN52MSYBqhdm7lPeoc4pIRwXMdZ?=
 =?us-ascii?Q?LIC3Co/Z4ODywQJDammTYpWFE/XPALtZ3g6p/RA915ItpADMrWpWWjjZp4zP?=
 =?us-ascii?Q?megtRh4lnlrQfNH2aquz8U+QeK238ogXj76I6eMzFymmJHG8kd9Hz2S1sTe7?=
 =?us-ascii?Q?n3IFHqQz0Mjq+eItC922OtmMEsAG1gpkDDbC3pEcbjUc/lFF6q6Y8WoRXgpL?=
 =?us-ascii?Q?ioMx7PJqwRogHxJHtatfyoWj+V1hYHqC7gkh9IqSmmAwIakz/qjIHiu7Emhl?=
 =?us-ascii?Q?5qTym5q9KPgOgoNniNut/d7VyYL4CQ5EToqOU++L3zaRUJeucoGbvnR9SDcU?=
 =?us-ascii?Q?Oidh7A6s7dgVb0OyioEc76Qef3UE1+vYXuX1c8cOlY9bXRB4E01PpacdjU2b?=
 =?us-ascii?Q?dGvFu+Hm0dUumf6BW5LwL0V+GNfCOtQmjw4Wwf67x49Yc1irhvcPn65P+KIK?=
 =?us-ascii?Q?MFUOM4uB4SJD0rBd42s+s699q7yQTQ+ka6KrskhAcH4eRhsy9ZDlhFqUis8h?=
 =?us-ascii?Q?jIXKKdOci3gfr1GdM30fkA1BwCiIPkIs33dOr7Dk1T6VE/hHQeHkzMkws+wj?=
 =?us-ascii?Q?LFBQeZcc4kEgnRzN962nnUSOk6aVjjYFCkFjLeF3At19DIlsdwEtMhqznciO?=
 =?us-ascii?Q?ftHmmXfOSV4hewGa1bdwe6WD2ZCUOC7YTWYTnHWexYonowOEh9FXUR3AKRq1?=
 =?us-ascii?Q?BAYoWU0ljO2yYJx8LN4AA1lihFQPjPdH0N4Cdkzq3cEyNM7c42SbM+YYgLQA?=
 =?us-ascii?Q?B9vK5yXNCpmvSQE0ttEnxYkZnlgMCAdt7afqkW8PdeMQnd/lo4DUY84ew9aV?=
 =?us-ascii?Q?FnTKpVeteoQoOQd1qpyPQLj6GudvEC45MVXrwYmUn4PhAVsB4RYfHgptOqdP?=
 =?us-ascii?Q?1U2vm3effFV0sr+xpGmCKgxdzHNRPBywYL+1R0CekBIL2DAewAn1pLhKm2Rb?=
 =?us-ascii?Q?+gtczfIz/muvF/nOc6SReyjOGkZWypV6efbu/Cscrbb08HCYPgOy8KTRTUn8?=
 =?us-ascii?Q?3v4pKjYv9p0v+hP9eXTQjsarX4CzqAP+Gi+lrtCMf4NNkdfHPUSpfxAPCMZX?=
 =?us-ascii?Q?DEdXiX+NV4bI554+GKSS7TfUa5BiokuWQERRC2Utwg7TlP8fFxFHfRAt87Yn?=
 =?us-ascii?Q?uSdt0lb3vy0RxiNMXDpE+eFWyaImraUHvzDurJMLTWkOPYDk0tJ6pVjxzQN4?=
 =?us-ascii?Q?cKEzG/F/j36ESvjxBJzGWhK6xVXmaoa+9R6DEazGCUfMzoMq5QYaZUZ77R2n?=
 =?us-ascii?Q?4aLBvhGI0MM8y4rV2gM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e2a17c-a3cf-4266-04bc-08dc13333033
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 05:56:15.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+/O0ryiox18wj4jk0q6qBHt2mn3nxTl2JElkxmMlplBs6DbNxNnMr7F+ClKo8IAcWVh/xLIDjzad7KCNPUcDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258



> From: Li,Rongqing <lirongqing@baidu.com>
> Sent: Friday, January 12, 2024 7:59 AM
>=20
>=20
> > > diff --git a/drivers/virtio/virtio_pci_common.c
> > > b/drivers/virtio/virtio_pci_common.c
> > > index 7a55939..d60fe99 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -584,13 +584,6 @@ static void virtio_pci_remove(struct pci_dev
> > *pci_dev)
> > >         struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev)=
;
> > >         struct device *dev =3D get_device(&vp_dev->vdev.dev);
> > >
> > > -       /*
> > > -        * Device is marked broken on surprise removal so that virtio=
 upper
> > > -        * layers can abort any ongoing operation.
> > > -        */
> > > -       if (!pci_device_is_present(pci_dev))
> > > -               virtio_break_device(&vp_dev->vdev);
> > > -
> > >         pci_disable_sriov(pci_dev);
> >
> >
> > Maybe break device is not the right thing to do. Indeed, request
> > buffers which have been already used are not completed by driver.
>
We can possibly have a virtio_device level flag to indicate device dead/not=
 responsive.
=20
> True, break device makes virtio-blk no longer work for surprise removal
>=20
> And seems no simple method can work for all devices.

When the VQ is broken or when virtio_device is marked dead, virtblk_remove(=
) should=20
a. flush all the outstanding requests
b. inform the upper layer to not issue more requests
c. for transient requests arriving on MQ, fail them in the request queue ca=
llback.


