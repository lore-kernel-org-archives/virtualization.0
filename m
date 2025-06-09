Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8338385
	for <virtualization@lists.linux.dev>; Mon,  9 Jun 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459794; cv=fail; b=g/+glFdwKKXbXlXFYGavHxRAm7+zgE2w1qFaq0R11h7UKXnUpTj/8FGRU/C8yqIK4vSgs9+yilnBG2/N3Qw2ubnj2qipc4xBAsLzEUGNDWfMnwsZkzM6+Ilg4aOjE0b3f2gWoqipgkKMzYuaWGO57yYaUQW97OL2LKIk8SqXD8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459794; c=relaxed/simple;
	bh=XiLXTsvfPx0yiDdfd+oWEiDDUeLMEbEhsyskj3Q9+q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nDtXhq9nM7U6VsUtxdZU1nrKZ/TbgfdtFyxcyoRqb5MTgj2se8ojfX47hXRsf2Sze/SCj45fKAKxqEnVU8j3qiwUdLr7XrKlVPTQ7RMhpSnjjU49qIrIxU62uiA1oxTMceUvvt9F2Hag3J7k+T49RUAS4FhLWCVyDPEVQb29ObQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QPHM8KiA; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QPHM8KiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjOrBT6k496VSXV07gRxGE3Jrb5LsRcd9lS56P0mvqp0RE89NP3gsf3/Vzc4ozOfyJ2u93Gd5BsVXWM4snJqvJ2SuHZ5cu2ocr/KcIIOJk4M/NvBiBJM0ScrUxlU+MSx8wqNwz+zytIzoxW3wfEeZp2kpB8KJLcbRmMfluC39rSGrcB1/XYriQ1CrmUNhsVt0ttykyA4KEgzVpnC2cuSf0W4QlS72C6a7teXOq47aJzmR8RQiiWQ0n+TNDk37U9Mc07Q883g2mc1cGx6nG5E2wcv9FgvCuhDH6g6h5znb+RkzClcUY6VjYrn6cVgRc+rQqZDtnzCg8nSvYmE+TrhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiLXTsvfPx0yiDdfd+oWEiDDUeLMEbEhsyskj3Q9+q0=;
 b=ENQAG/Dl0tWCgy+9z6Sm7tpkK/IogbBioJyOQLqI5FDlLJak7zIuTzfCGfV4ccf84DLwz2N8Q8YVvRFkmZEjrtnFSeVJsVx1lKMvSEI3u3KOmoHJgFsgH2HgOpcovJ5MsAxmPC4IyNAfJEESLqtmljV66hi3AcjkMIT5mykZIIoCC8BVBViZpR/ix8/+MM+hbwsYSjw3gnkZn+GCoOJX2P+55RBw5V2CrPCmveFuK0wVRWBNBatrgLXNJ+UPy6rXxvPZweyqwM5T7cxhGn7JBDT/GDbkhluuyXsy/UE6aSjEw8dyQclCU955n93UUBvFK7R/hHi0R5goihWPQ//AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiLXTsvfPx0yiDdfd+oWEiDDUeLMEbEhsyskj3Q9+q0=;
 b=QPHM8KiAmBqsZHm2fLSSLoQLE1dPPRgm+t6osyErgYOVjr54Ehh1NNUJ3/mDtaZk/G6dKFxHFNpc8plm5Tyr143JJngtLRti5nIReO0GOT3J4h7AH9g3ft4WbDMJAr+WPw1JxwF/fFoweU3YpkDhatbIjKbDYPTvSddZ88wTU8gFUrJOMnhhbIAQOPa47mcQbrcEHpp4zy5/w7BgppogS8Yg+t4DukmSL/r3zomwY0y6ahU3ZGQcrxyb+zX55/bn5zkJyu6PKLD8nrWuamQLdCdNvRz81e9J5FVmzRlVdu/0IQ9lyCZfTV6hF+wx+OOjG6t/ebhJtTHsgBRuFdIQ1g==
Received: from CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Mon, 9 Jun
 2025 09:03:09 +0000
Received: from CYYPR12MB8731.namprd12.prod.outlook.com
 ([fe80::424b:57bc:9200:4d8c]) by CYYPR12MB8731.namprd12.prod.outlook.com
 ([fe80::424b:57bc:9200:4d8c%7]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 09:03:09 +0000
From: Eli Elbaz <eelbaz@nvidia.com>
To: "mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Darshan
 Hassan Shashikumar <dshashikumar@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Odi Assli <odia@nvidia.com>
Subject: Re: virtio-net: hash-report feature enabled on driver load
Thread-Topic: virtio-net: hash-report feature enabled on driver load
Thread-Index: AQHb2HIedbpTgh8BSkKw+9CdzgOBzrP6iGv6
Date: Mon, 9 Jun 2025 09:03:09 +0000
Message-ID:
 <CYYPR12MB87315DDE2FCF53FE99E797AFBD6BA@CYYPR12MB8731.namprd12.prod.outlook.com>
References:
 <CYYPR12MB87318FD322F11F9FE7465307BD68A@CYYPR12MB8731.namprd12.prod.outlook.com>
In-Reply-To:
 <CYYPR12MB87318FD322F11F9FE7465307BD68A@CYYPR12MB8731.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8731:EE_|CY5PR12MB6059:EE_
x-ms-office365-filtering-correlation-id: e714fdd0-372c-4499-e959-08dda734748a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FI3eZujPBf8USUqGLyQ7bYJFWXA7wAnkyCiHiax+++hiHyiuVrXIGH4Jkx?=
 =?iso-8859-1?Q?hJ5vj6JFN0k8oicfe84q/v9hA1hN4h5cBjuL5/bBkC7PBy0yNnjdBfA4PL?=
 =?iso-8859-1?Q?RgRIHOrQDDeAJSlMVOnnPy4kiA00G9Ww0bQxUqsB875wQBb63cKlFlJ+nc?=
 =?iso-8859-1?Q?s/SwDzu7UbnOFu3kzdzGDH7Ln2JT+yDr1hQoB0C1pKdyIhdjDwm1MWBmDl?=
 =?iso-8859-1?Q?W17UibPjC+Xa5r6r7d1pSqoOxtCWDdiUSmRoWG1l0jaRNn1kdUJCmRhjUw?=
 =?iso-8859-1?Q?NFzkp0jxORCzM34BGWG7azY8XB2IaCKcs10Zs/2aD9/1FXXjqcTv4wchRi?=
 =?iso-8859-1?Q?cQgLHJC71+pH316wRyGwfzGjs1fyHWLcTmudwQCsKC/R4nyB59NDA8wQtI?=
 =?iso-8859-1?Q?r7He5pPeJGfOWZ7CUyHsrMgJc1j2YnKwN/qk/IQNoElJuzQUp6WkAZzc0P?=
 =?iso-8859-1?Q?rz/YRE14M1lPDU3LLCz3qMXDRAHiY5bAGpCP0Vm1kO9XifhvqYI+odDtKO?=
 =?iso-8859-1?Q?PMJY4ciL4kbH8wPcHWwo/lYx0kX4nkXKsmp7HmffLfZZxsKTmi6VZo1CDb?=
 =?iso-8859-1?Q?aR8sx9ghhf4DEnwtFBC6zdBsv/UxjGSK4ePkf+YKR34JsTkxLX1XD4CRHn?=
 =?iso-8859-1?Q?OLw0kRteJnUlLCiC8eLL/SduD/4wyFsemzc0rZVHTgFzD1E8AOYdGoOk2U?=
 =?iso-8859-1?Q?5QMgoV/CHg8pQ+0TefRnRLhUHfLbOCdbIQU/DqtfU+QVaoMf6oqxUthVoh?=
 =?iso-8859-1?Q?Fbv6ZzGpi3jrGQKGyZrfLpxATqvz9Ks44onG2Rx6r/QjEXUxNo3uyMVVMY?=
 =?iso-8859-1?Q?pUWbsWrVENyxi+K9jsERZp7j2/SU0xnAo8qK9ld4px2qnC2odiuXw5UneU?=
 =?iso-8859-1?Q?YHBMenmUoDNjAO+zPbzDfXViIkBNqUmhasPPTii04PZd7LCXSiHB6Cx/QD?=
 =?iso-8859-1?Q?m4Reo+VRUogmHOMY6MmsdpH+tifIWdpevaR5og8smJNRi/dVbbQ8LbVY9e?=
 =?iso-8859-1?Q?aAlQckCHauYAe0wKRUFT4dk1plEMm6U955qMQq5MbT4AFwgj0uDRF3U6BJ?=
 =?iso-8859-1?Q?JLavd4LjKXrceDFqB0LhCd4j+l5DUZqj4zvnllscMS25woxz3GoJQsCQHA?=
 =?iso-8859-1?Q?IpsOIvxCDvjXzKWS3/pOaJ8GJYoYP5uM7zE0mIWZmTcAM0FzF2pUZFJnCm?=
 =?iso-8859-1?Q?T6/m5lQ5BR6dgvi8LGCgplUuZbThAa6oaBHXwDFB59KJImqFU35Tj7Gg7P?=
 =?iso-8859-1?Q?rvEVkp1Blx4w7WOikzCa7GmbqeH8nGXF17tQb7W9Q8g35thNAW2LHSFvfw?=
 =?iso-8859-1?Q?A0AV/8p9WYQvjdwho202mZ2bCY+a18kWPBUcnR6QTrhCtE27IuD6Ydvs+U?=
 =?iso-8859-1?Q?AZcEIKMtlnFu9G3OpQUj5F+GL3ebuPPyIems7hTMNTD3KF8HUw+Zh6u6ca?=
 =?iso-8859-1?Q?d9sB/G46FNvnq0p4zmzGuyePobDlDPoxB6eAKvVPiSwiWad2ONtR9GXtOz?=
 =?iso-8859-1?Q?qTlAl1aSoTNLkJG+2oNr6iXfLJVGcBR+sv+ssyA8KEZw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8731.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sTLsHqfdRmkO5LQnC24mStp53bz35Rod5rplb4UPwOt5QrEz91ykYYu4CH?=
 =?iso-8859-1?Q?uRmWxUs1iT/2pCOQBRIUEWDnvYEMhzyryzOpZxveR1qlCDyryj7VK9TITA?=
 =?iso-8859-1?Q?8L9nTkK/xRQl3tx0TT+lfIVpH5xTAX0jMGbCxvxxxjTBUXOoaG8Yz8zN9T?=
 =?iso-8859-1?Q?wbdrSqPerfJ181IOG9hlgq3f5e5GWhhm1JdPO0911h5uhRqpEeUyerYsbj?=
 =?iso-8859-1?Q?9433dcsOHDjW9Sp7PvOivwnQKVgeRe5yqMK8X+gFAUZt22Zk+c15fuXtou?=
 =?iso-8859-1?Q?Lj1UtH0neZa39hhARzgkBP3A/OKfs/GAuPLE+9aT3SF7rJOkazQXrbUSki?=
 =?iso-8859-1?Q?s8DV12vSCm40rwKIa4nTr4bPnH8TDO5lzl40SdSUyvV/6TwKx6tGAXbGJS?=
 =?iso-8859-1?Q?vGdn7K007RwO8Lp//6WAdJVjFE3FattODX5/IketMhF3nuIMsW7MNBSQPJ?=
 =?iso-8859-1?Q?TuAiK8U32z+Tnfkl6f0qWwPIYWdes+6k7DCNdngn87c0UO/g2s2M0QMSg7?=
 =?iso-8859-1?Q?YjMyB7OT32u6tngcah4HVVIVzS8VxsvbbepFdhw4yvVBsq3wZjmEV2vTbt?=
 =?iso-8859-1?Q?3t8Ri0iEVpmhcOrui0sM3rR3uP2dFB5J52b/RPa8RPgxgib2qndMqQuiwf?=
 =?iso-8859-1?Q?9fEjY/B+pkZeB5rvoPlfhcQPoTToRgw+rFI+7hdgCu2p6yrnychataspBd?=
 =?iso-8859-1?Q?YaLXzMPk9LHtqripmwcF4B176G7ro24hbmrULjauvzL0jGJKS57aOHTtL2?=
 =?iso-8859-1?Q?uf719EO5QjkMxEVWoLaenzopvA87/IfPDSVGIr61g9caP69no9Y4PsWUE/?=
 =?iso-8859-1?Q?v2xegaFElFn3t4yh5UHkzRZPlsL+WTXFAB2vyUAW4icKKCDgJKMw7eJVYP?=
 =?iso-8859-1?Q?4j+cXl7jkI3lrfwJGCcyGiOAnWWtkDocmbFt/eRd5Hnqg2f+PssmTM9s8D?=
 =?iso-8859-1?Q?Lr8vWVp6KKBzC+U96PlRQTBv9yY9IHT8FdaRL5185IBDtlQgP7bGlcLMPG?=
 =?iso-8859-1?Q?jgNFYnKBA5tB7rUGoRpR6qXZ68WZnVcENWGUlYr8DKqu7+vL+Dozd2y97e?=
 =?iso-8859-1?Q?8Vkq19vYY8uRUlUJLxOUgh7se1NV0c2jYkHJMiW//5mucOBN61RFmZdRdQ?=
 =?iso-8859-1?Q?jecWjffBJ+6MZOhX/wWtemHpKyvX5kBIzBhr8SijHNOQCJQ2VXsuxGzmW6?=
 =?iso-8859-1?Q?9WdGeFQzI32R7TgcsBPjyeEQpHrbWCpOL8VOEGGowS0Zv664Op+VEnGuXh?=
 =?iso-8859-1?Q?au7yqpTNOlx/GDYsCUJZaIghqjHYf3xaIkBSdEM7SBt7U22G4CatVFMtKC?=
 =?iso-8859-1?Q?UFb44Kf5Gk0LnyZs/fNdZHm0htUb/mardYIbu+oefKr8ozuLxlxCXpv6XG?=
 =?iso-8859-1?Q?0CV9lbh0Pv0Yc36CkhlqFGau9B2IQgNsN70i+DZSp/STR90s3rAQLNPq0t?=
 =?iso-8859-1?Q?Y/MOE14cj3dA9ZZOBnsZIyJQTozRR1/BC9JypvGDmQfYdqk0U6Wpbpr59s?=
 =?iso-8859-1?Q?jLIGb+PsAHOTrMXGPf+XrHF8ov/8LV571YMxxNLdwBCy/7YomxfMl8Sow7?=
 =?iso-8859-1?Q?klSnRCN8L+lyfqeW6KQ6xKWh35y26sU8nMEtQkSONQUcoWieSu8urNZC5O?=
 =?iso-8859-1?Q?2NkmH+KJfeQlc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8731.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e714fdd0-372c-4499-e959-08dda734748a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 09:03:09.1419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0WqxDkVaz0x3q4QZXgAStHUrAetl2x2HjXY3S+tLHQj3i9dXYQQsY8zWQVNB1RheZQPk1YWtknBIiqCZHS8yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

When the=A0virtio-net driver loads, it enables the hash report=A0feature on=
 the device=A0side.=0A=
However, on the driver=A0side, the feature remains disabled (we can check i=
t with=A0ethtool):=0A=
$ sudo ethtool -k ens9 | grep hash=0A=
receive-hashing: off=0A=
This means the driver does not reflect the enabled state of the feature, ev=
en though the device does.=0A=
I would expect the feature to be enabled or disabled on both sides.=0A=
=0A=
kernel version: 6.15+=0A=
=A0=0A=
example:=0A=
=0A=
STATE: driver load=0A=
DEVICE: hash_types=3D3f (IPV4 | TCPV4 | IPV6 | TCPV6 | UDPV6)=0A=
DRIVER: rxhash feature off=0A=
=A0=0A=
STATE: user enabled feature with ethtool=0A=
DEVICE: hash_types=3D3f (IPV4 | TCPV4 | IPV6 | TCPV6 | UDPV6)=0A=
DRIVER: rxhash feature on=0A=
=A0=0A=
STATE: user disabled feature with ethtool=0A=
DEVICE: hash_types=3D0=0A=
DRIVER: rxhash feature off=0A=
=0A=
Regards=0A=
