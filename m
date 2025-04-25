Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638723FC49
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580231; cv=fail; b=vE8gCQsZLVCGibTHhw6hsFvKl6SD+2kbHrFXyblDNPIzbya5jnhkBwH5Dw4fFPZy4oJH0bRoHjWZjwpGyIB3SQ0uA/18cpWzwiMkQUD63eorlCAYs/PK2IdE9Op5skFIP1o3dPoNL6zsLgeoOYauGYDN0RXy82qMFNHkKSbBSzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580231; c=relaxed/simple;
	bh=8sAqRqJpmCCTgk00WRTFLLNrEgAuyWyOEpWXULTM2jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pMte/8qVwzzUJcRDTpEA1yr4Y/d80xiSs0qcXug2mIyIIZ1e6LdW9+dmUF8PyDWDsyYykZw6NZ5OmoGMgagj0BRbFbRVZ7De157HeQgubq45s6rkCxL5K1Mae83NZ/A3HZ48K29wjBQOfOucLb114QrYk80mNCtqltDX65bKxSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=S1miK4gf reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="S1miK4gf"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAZl01017122;
	Fri, 25 Apr 2025 04:23:28 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4688s3g219-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 04:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqVy9+0KWNf3MyL5Zgtcpd38sSwvXT7OCZltyIgNaZcUWwHW6sGhmC7X+g+GNjWGwMX1yn/wYBBCsh7bzSz/i3x8gZcN516Zem0KW8W5uxFtoM+d01UybvNTabarW5VTgyoMHyrQxZxPCzpdNMuzoO5ehnSI4AcS1w335fYGJVdRc1qnC2QGsneyqxG597Z/4UzTU5sQFSGM9uz57OkU/F2DLLjfGLaA1tRZw9XuctlktAPfNzbip9Ur2ktqbsj5/7lJT1m/32n/wXhlRg0Vlhv4wjsVmfNhf0YaTVx/7kas/AC9I+UKkSdinmtLo4H7FBXCUqAtSR4kLVzeokI1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8yIppgBkOsOPEZ/YaSZwMcMHUGlkSNycAS7lBh3G4w=;
 b=gK8uLKF6aRGVdG4cU3jQhLODGON1PjPq7zy/iYTFQ6mcyIX9144azgkSAWZIKesvz115JYEuDyTCz8eS0C12LsH8zhrxz77buLReGm7PlhUJyBYjHO4OcI6iZzu7vArO9VlWzwe7DRVG+UaziycUrHrwpojmcQFPROtOEO1aR6GaKYUkItEo5E9IWkUp1rp8TlOD1GAmnyaDe4F8lEaPJr6Ir6VLbGpfMYzYkdFmA4IXy7cZ8VKmgcSC9ctZJ1Mh667n4YXDHVLLdlMfkIeZNyXHnmRSa0JDTTW3VyVxorIQY9jKUQfMq2vJ/EVDVywN4iaKNUO6sY5X2gvcb+pXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8yIppgBkOsOPEZ/YaSZwMcMHUGlkSNycAS7lBh3G4w=;
 b=S1miK4gfN2PjCKIPCrBNXPQglvJK7wlB3uj/1Bkgv5DD/uXpRrArUfCAW8zjpYVMsUMaL7cI3/9RyRMVTmw7eCeuJarTlyAhXCsqyhF01YntBJNG9/NEi+TqxqellG2DUc5h5NCvqd2L7LqU8ctOQbSV2Y/Y0z3f6uEcFVzhzzo=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by SN7PR18MB3887.namprd18.prod.outlook.com
 (2603:10b6:806:105::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 25 Apr
 2025 11:23:24 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::1b28:bbfe:b5d4:9456]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::1b28:bbfe:b5d4:9456%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:23:24 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Philipp Stanner <phasta@kernel.org>, Srujana Challa <schalla@marvell.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>,
        =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Satha Koteswara Rao Kottidi
	<skoteshwar@marvell.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v3] vdpa/octeon_ep: Control PCI dev enabling
 manually
Thread-Topic: [EXTERNAL] [PATCH v3] vdpa/octeon_ep: Control PCI dev enabling
 manually
Thread-Index: AQHbtQ7nrIzJtrSZVEi//lF6d5tUI7O0Pa+g
Date: Fri, 25 Apr 2025 11:23:23 +0000
Message-ID:
 <SJ4PPFEA6F74CA26702153052BF3AD03B9AA6842@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250424114850.34045-2-phasta@kernel.org>
In-Reply-To: <20250424114850.34045-2-phasta@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|SN7PR18MB3887:EE_
x-ms-office365-filtering-correlation-id: e19ff816-9ec4-47c9-b71f-08dd83eb978d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oImedQpcUQm4D/DELklpoTbem1pPPcKFPKKUbfQlYxOcFYH2PZeDiGKe0n?=
 =?iso-8859-1?Q?xGRMo4/cZB0DtIHMaJ6ALeCIOz5fUPCrT1hQkyxFcmsNijwBozVJ4oNvMc?=
 =?iso-8859-1?Q?907W9KHp/bxTsDmx+C7ZT04RewpVF7zSl+SFIXUAxtQfDLyigRhgtGWy4e?=
 =?iso-8859-1?Q?qj+AKOU7r7ZM7KZxfpbnkLD/BDdE1eRapgCTikjZXgeQ8sptKk8Hbbf/hK?=
 =?iso-8859-1?Q?Vwyx6ANsIek+HAr+JNu47gQbPUXIjADX0z0rW1M8rub19S7Le2p0uHn6rf?=
 =?iso-8859-1?Q?D5arKCr607308liVJlpWxQb+IGzeWMabIw4q9I9BNcXTWhZvQLSGkTHtdl?=
 =?iso-8859-1?Q?u6AU520jT6bN/PyzObUKMMDPq8gDvaJFNBCWvgqp6CAEaH2/adsi9pshhl?=
 =?iso-8859-1?Q?TV03gixdtEykXeXuYFFodCK1zTxUha43/is8gdiAn3lPo6KT3AZFkE1f5j?=
 =?iso-8859-1?Q?/lPhNKe2UoMlqZLuNGMOk7SPNkDLP9s3V2G3g3y4vbMWmEQXiEGTxQfMNr?=
 =?iso-8859-1?Q?65pM6zRd+AbIPfL5ZLQPvXiWIuR/xvkelg0v/XTOC7iDxATCjB81mdACGQ?=
 =?iso-8859-1?Q?mXwgEsxCfGary3WsdB216qGHjj09bZm1OwRc9VlC7ufSCbO1h0gKOoJbmJ?=
 =?iso-8859-1?Q?ifKFW+PKvesG0BBaBVPYMPeZdGbdgjzsWHl7stHRPJb5hE2rxD5pk71Si4?=
 =?iso-8859-1?Q?wVAqnyu3/tgZJzR6Gmb5MQQjTocYGXeVCx4PsOXvJovVjs3y3OT03LOV82?=
 =?iso-8859-1?Q?ROwrCSLIz4V/hiCHYWXwCqVlPpyFgH1V+l1VF3n9r7IK1tHEWksneWGWEC?=
 =?iso-8859-1?Q?0jk/CP/+X69h7GK1XIYTH6pbEe7/pJGzHn97TIp2nNG5nz5ixJxhnDyt3J?=
 =?iso-8859-1?Q?kFKIg3JJ2laItR9Gdp4uJN5NcH6rc1tFrMOBkgiCb1pqCrIBc1GJ/UBCHX?=
 =?iso-8859-1?Q?mFjettTh5+BuBS5FVT1MMptPlJFr4ifXURnPpJu621XEyaCGMCQi9DcmeD?=
 =?iso-8859-1?Q?tdH4zzx/Qv+ig8IDp2xQavvaCjBZYe4B6CC070rDRIqbJjXMLjkWdNwSmv?=
 =?iso-8859-1?Q?nobQntFZYRUvg2gVYdYlH1dLNS4C8ZUbVDJPByXGkEB9AfxXSOYxMU7g5q?=
 =?iso-8859-1?Q?o1+hItIPP/RFLuO7tj7oypsmEsjbWIYxz2cqb5CLXDoqNYEEdfsWKTo5J+?=
 =?iso-8859-1?Q?A4L1lYV2Rng+dMvP/BMXQIJpFVSvwTeARyAk1ncWsxkyrqDgF7T9TvRBJW?=
 =?iso-8859-1?Q?k6+hyw4oyBnaI+Fz1Giq5b5faTDuM6O74MCqdD/sLkBlaDPvE20ECD02LH?=
 =?iso-8859-1?Q?zu5OQ9w/1MMuWFUOBC/zH4zVm474K6coPzPnnycwTkkIIl+SQxzToUnBz3?=
 =?iso-8859-1?Q?0shvgDejEF8/WEd8ng4estj+GjSZ9PUI4jozkj+9yHhgZrlzpEraDAXF1h?=
 =?iso-8859-1?Q?vF8wBlcyAM4Xcn9rYKrvO55GXAGkEURkKY/WrXUmxn9gPfZz+nb35DRn1p?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1F401605jT6vkiGByDOzbGRqzZ4w+os6qmwCM/77aTHX+knaCxopj9WKXH?=
 =?iso-8859-1?Q?OR5MqH1J1aDi+N/e6b4g5j5ysFHBd0ghaRESp+qF0eMk87gkPL1gI0qW1J?=
 =?iso-8859-1?Q?dqm0wY8Epq+vYpRsWDzBLxqJcgwNjuEE97Rj9uKdSg3W+o4uj4qQnuJtty?=
 =?iso-8859-1?Q?bMxL8i3oxURkkzct6qgYlzOmwGT+cGVhZc+8ENXidSZB5tz0MZ04TFKEPt?=
 =?iso-8859-1?Q?coctsC/w45dqw2y3eLVX7mnk0Vuv/YEysa+Q2tgnCmtMrso7CexyWc4rhB?=
 =?iso-8859-1?Q?aEjkpTnpt+cenUeMUFgzUzfNUf74+7J7/vtOVt9UsnOYEgyurrdlag0b/K?=
 =?iso-8859-1?Q?vG416BaqCK0YUcSHAH03KGlx6HON6Hxp9zYIw+k1Ig4XSz1fbU5f/qeymt?=
 =?iso-8859-1?Q?gwJpri42NJiU+qS/2M9+v31niF/fvQbTxI+xTEG9UT6dlLmpIpDKYHs6Rt?=
 =?iso-8859-1?Q?QFetZDOCkBiyyXBBZwtx76n5WeLz8Z12I+zShDvBEpHTuJXJjzM+Mw5f5g?=
 =?iso-8859-1?Q?o71ETrnsgltVDwDeeO6QeD/UWEk1st35sOk6k4f6uI/QtfCGgTD4Yg9eM3?=
 =?iso-8859-1?Q?P8EPT2JfrCYK6Cte0Bda1/xWHfUcjLGMJ8OzGpi9C6zq6Wm3PBIpbQ4XSP?=
 =?iso-8859-1?Q?+Wz4OfCNrfm135lBwvgmW9bgpoylExxaVhZMstq4qCMbeGQRTTHAa5YlF/?=
 =?iso-8859-1?Q?Vnooi9HRMXmU5A1hnBabRz7pXRYwC+PKLHsySGiRfktoKVYwxuGBJAd6YS?=
 =?iso-8859-1?Q?mCFx4w0nM8m8BF+FyaIqfBKMRyVOmLXRVXpaIUCgKOF2K0QvvVg9ebyD9B?=
 =?iso-8859-1?Q?Hh/0Gp80ETNGCV4lLbHi2oKoYhO+z2X7A1M17ges5mPBcMKRAuazUYfN+G?=
 =?iso-8859-1?Q?r/0OSYFLT9l3AOLT3Flwmh8msxf0M7Kggu4VItjY695ZAtVjulUkWpAeQD?=
 =?iso-8859-1?Q?d0vDB7pIGyga14KstqZLJWJL7Q6BUqTdXbdBRiBUGkDFqZqUuRNcTpFJZ+?=
 =?iso-8859-1?Q?eOGucWP4Rb50ePThMw9mtYX7FB/damd/v7/vT+lrXTByECE5yvz16PP2RB?=
 =?iso-8859-1?Q?QgquJwk07oeU+AVHcB/nFzB4CcnTUGbUWxIj3jFe/xb0T8pEeM+mHKM6d1?=
 =?iso-8859-1?Q?YlfJ0JKgFr3/cRtNO+xeUel0OsmgM1YOzs/yRha5YmyJis0JagrSvIkPcR?=
 =?iso-8859-1?Q?FhF7x2AB3I0h+4HH1ndnaRe45OkbcfLP/o/j6VjuOwtt3XznAYqvEfjdmZ?=
 =?iso-8859-1?Q?bOBI6VdwPbMiinjvvcc9Pb/Uc4aNQWd/yDPxZeeBuPiOdb+KXH57kZFGwK?=
 =?iso-8859-1?Q?j4JmLK5Wt1h6hvPG8pmJvwIyXpNiklBybMN8owObWp201BfwfedLbSCuCL?=
 =?iso-8859-1?Q?0m9wDg1572kMB6locOdInzK/d+o4fyPiLBVgeDxZu65m5T7OXM8wTvnU4N?=
 =?iso-8859-1?Q?aOJ1qZegxxfVZkBzS83TfZN1iX+cwbBvQVyD+kPnumejFRkWoImCXGEx6I?=
 =?iso-8859-1?Q?d+QYMX9wWjQMgsvaoP7nHRE/mPQB8+PhIKW/KrUMhWcIg53+LqmS5mAqJX?=
 =?iso-8859-1?Q?lnvyRe/2qZ41PtpvNysh7b/oUo1WrjilLPzr7vEUUv7wYIY0w2m0t8k5W8?=
 =?iso-8859-1?Q?iqaAKx13dEhMCroUTXdHMWEctL+PbHykpe?=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19ff816-9ec4-47c9-b71f-08dd83eb978d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 11:23:23.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEelYMcDQVKR76m6UsX1HLtqt4kwFtBIjAO7uNhI9+zD4sKhvxTFdSTe2ehKAYQ8Y5Jwvnyx5n8K1FPxl+x1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3887
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX34KE63eDgFW4 il6JQ3iKszMybQbs2kjz8UE7x/bFG6tcZOWvtb41V/S+FcF32i4B37tcIfnX3A21kCzvbgfi/M9 e4xC2DyFHe6khjZJ9aAN7hiQ6zpwhCwSljlLufAwLJRAWXpuKT/TSm+A0O0Okxy4dlXQZybnJgF
 HBHZg7XZQNoQrX7A4tcMKpUCbitBfijnqXxnilIEq1rpg1A7CNO2LOaNcUO9q/0qr9P4zKMbdT/ UdCkXtnWlyXZxbKqtGYNI8BZTiRmewljpk3JTm/v9u685+DRpFLFdXtjlqFbY8GQd+3Kicc/Qmr eZ6o/qtB6FixPg/Wv24S0pUsqziTYe6kxz5SOZf6jp5NHJQLK2ihTaRhsV1I944dHQxcfTx+7ce
 fXwr7ONcJJvWAlNMrSzvUpx6pLSsjqdK1bCpYmL7wcxOSYeTWHRcuN1An4eFZg875eKlzxNd
X-Proofpoint-ORIG-GUID: 5oqHuk3FTYWS72LH6wVI3HN8vEYKPsjE
X-Authority-Analysis: v=2.4 cv=BtOdwZX5 c=1 sm=1 tr=0 ts=680b70af cx=c_pps a=XlWNgFwcAB8XWrBhwjv7Vg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=KKAkSRfTAAAA:8 a=RpNjiQI2AAAA:8 a=IzkY0gbQLhW18KJ_ckMA:9 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5oqHuk3FTYWS72LH6wVI3HN8vEYKPsjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01



>-----Original Message-----
>From: Philipp Stanner <phasta@kernel.org>
>Sent: Thursday, April 24, 2025 5:19 PM
>To: Srujana Challa <schalla@marvell.com>; Vamsi Krishna Attunuru
><vattunuru@marvell.com>; Michael S. Tsirkin <mst@redhat.com>; Jason
>Wang <jasowang@redhat.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>;
>Eugenio P=E9rez <eperezma@redhat.com>; Shijith Thotton
><sthotton@marvell.com>; Dan Carpenter <dan.carpenter@linaro.org>;
>Philipp Stanner <phasta@kernel.org>; Satha Koteswara Rao Kottidi
><skoteshwar@marvell.com>
>Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH v3] vdpa/octeon_ep: Control PCI dev enabling
>manually
>
>PCI region request functions such as pci_request_region() currently have t=
he
>problem of becoming sometimes managed functions, if
>pcim_enable_device() instead of pci_enable_device() was called. The PCI
>subsystem wants to remove this deprecated=20
>PCI region request functions such as pci_request_region() currently have t=
he
>problem of becoming sometimes managed functions, if
>pcim_enable_device() instead of pci_enable_device() was called. The PCI
>subsystem wants to remove this deprecated behavior from its interfaces.
>
>octeopn_ep enables its device with pcim_enable_device() (for AF. PF uses
>manual management), but does so only to get automatic disablement. The
>driver wants to manage its PCI resources for AF manually, without devres.
>
>The easiest way not to use automatic resource management at all is by also
>handling device enable- and disablement manually.
>
>Replace pcim_enable_device() with pci_enable_device(). Add the necessary
>calls to pci_disable_device().
>
>Signed-off-by: Philipp Stanner <phasta@kernel.org>

Thanks, Philipp, for the patch. Patch looks good, minor nit AF --> VF
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>

>---
>Changes in v3:
>  - Only call pci_disable_device() for the PF version. For AF it would
>    cause a WARN_ON because pcim_enable_device()'s callback will also
>    try to disable.
>---
> drivers/vdpa/octeon_ep/octep_vdpa_main.c | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>index f3d4dda4e04c..9b49efd24391 100644
>--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
>@@ -454,6 +454,9 @@ static void octep_vdpa_remove_pf(struct pci_dev
>*pdev)
> 		octep_iounmap_region(pdev, octpf->base,
>OCTEP_HW_MBOX_BAR);
>
> 	octep_vdpa_pf_bar_expand(octpf);
>+
>+	/* The pf version does not use managed PCI. */
>+	pci_disable_device(pdev);
> }
>
> static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev) @@ -825,7
>+828,7 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
> 	struct octep_pf *octpf;
> 	int ret;
>
>-	ret =3D pcim_enable_device(pdev);
>+	ret =3D pci_enable_device(pdev);
> 	if (ret) {
> 		dev_err(dev, "Failed to enable device\n");
> 		return ret;
>@@ -834,15 +837,17 @@ static int octep_vdpa_probe_pf(struct pci_dev
>*pdev)
> 	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> 	if (ret) {
> 		dev_err(dev, "No usable DMA configuration\n");
>-		return ret;
>+		goto disable_pci;
> 	}
> 	octpf =3D devm_kzalloc(dev, sizeof(*octpf), GFP_KERNEL);
>-	if (!octpf)
>-		return -ENOMEM;
>+	if (!octpf) {
>+		ret =3D -ENOMEM;
>+		goto disable_pci;
>+	}
>
> 	ret =3D octep_iomap_region(pdev, octpf->base,
>OCTEP_HW_MBOX_BAR);
> 	if (ret)
>-		return ret;
>+		goto disable_pci;
>
> 	pci_set_master(pdev);
> 	pci_set_drvdata(pdev, octpf);
>@@ -856,6 +861,8 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
>
> unmap_region:
> 	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
>+disable_pci:
>+	pci_disable_device(pdev);
> 	return ret;
> }
>
>--
>2.48.1

