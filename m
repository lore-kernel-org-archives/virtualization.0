Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022125.outbound.protection.outlook.com [52.101.66.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255B2571D7
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402874; cv=fail; b=ldOxuDrNisxE5duxY9eaR1aS0wxem/vnsuZXAG0GGrEq3eTXxJSBrzJ2rWlTu0OV33CvbDZ10Q2X9aRKxmNrPNXtr6kBFFTPfRQ9JLeRNztrGxx4UhLDkqi/l/F658vR4qJEGf4K/pzavcaxNHvR5f490sEWEYeOAxwQNzE2d7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402874; c=relaxed/simple;
	bh=P9v8Fs2lxN672pn0HxSya5Q05J/FpPD4eqiKrHbmJN8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bk3FCJ7qZjFEM6Gfi6lOj5WoAtkY2qsOG1xkFhrs4aQ/YHL4KIkxPuMzkiwP01GXcPkhgoMK99d6qb3WPL7u6fT0XsF+dTpPTRJ1auNrBoD6EZ1aPNl8LdkXslxZ/N7eIaHaHRj8Z0vEf9DFm/XmJekvEpUQEkIBbmUyt/oOtOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=BanvHn+W; arc=fail smtp.client-ip=52.101.66.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BanvHn+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkNtK/pwBXrwiGCJSbjq081CgiL2hVdwPO0VUEeXnqqkkrTRYWGYzyLD15GtGFHzS564uuJiUv6vGd+Ybc5AmXzBNRLNRZxm9uQPbg5IcUVtImbCOGalQ1RQnyi7eTTALWLptJlqPK96T1qRe/lJfTEY6cFDea3vpOR63lrGjXUjPGMH1o8iPT6W4MYMEGOgo247OaiMVGRbDud2bzmmGyTwPihX18fDHzsEwXJPjXpDvjZTy4Nvy5wJPFx7uUqKvzlndq0kShXrCivKHP4fsDwtqcygvJbqICIDSeuIaWLbSATCA0fbrXKp9/1GrFs4hOiFsqJ4n+V1wnIlYSc6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBKFCEfmCQvHhePt+LD6twX7zu4dY6N0nMWFL1ely10=;
 b=TSfsKwWax1IFNFI0adLhk97PFlguZ7pXTDdM6prBoEujthS1lYqY+WkWdHrJMCrM40Gn5zFvDaV0woZw9HXjZhvyNKoCtMtUQmRo/P3/VP8BHv5QdksN7D0cziro8qirKxqxRVgnHU1xcR+/cXiqZthD15P+rXM0DTrT8aMRbDKwSibTOJ0tue4krbaONNo+i36XM1y0/lARoF/pomflEVq+wsAXT5l7JGaLJ7/2gBY7pGrl2qoIuuXYfELklXvOzkBjL2ToMDh8BD7EF3q13Ao0losZKX0m0rPs2J1GfJVgwEEnx+Yet5lNARrK7bKs9F28Gsd6ud79hcOZn1GXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBKFCEfmCQvHhePt+LD6twX7zu4dY6N0nMWFL1ely10=;
 b=BanvHn+WI9dyt/cEwZ1vpS6G6i6ZGw5IiuyKRf5wv4crdg6lx1zZYadr4oIPpFTly6h4yQMxRCD1dq9v3fKjw9EIl2S9r/ANpaRc7r60LE6s9s03v7xcxjn084jDoOTVH6dqxoZEMMBmujvmvEAXP0htMODLplFykM7+H4qXNFVUUoAaAFr/MRHil9JuIR6CwQfgzA18bidgzsGLW833Xg9RN/D36SUSyygLqbDU2h3/AR4KhUI03EFVXu3y0qpxh+2FhSrhuOW2Kq8wB50BlegAAS5WO/eH97jaPiCmjAqi8CFFUhXrcuMTkWm3Eliw6JTChnfc4UK8siD44f5ihQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6566.eurprd08.prod.outlook.com
 (2603:10a6:20b:33a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:54:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 15:54:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and CPR migration
Date: Thu, 25 Jun 2026 18:54:12 +0300
Message-ID: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8b492b-3b04-4fbf-2720-08ded2d20a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|52116014|38350700014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	rOELQV+IwdsedWtLXbN9iz7I609Bw/WpQOpIf7w+91G4JcJJzGGSa5Zg+PJqKrn9VxCO7ZAjPUeagqF7pP8kgfUxKU4BEyC9EqEe6FJJxm2nb2blkCKanyVS1P0hfJFYjd19iYiAFTXNaRwI/r3uLOOenYUxFEQMveoa8LgkkOIQpkbs+W+hruJY4XOI/3CKvAl28vuUwq9nVrn7GCaGbeJzttkmLqj9ol+JzwvW/BwpQ4zSBnuG7YtZSlD+3UvBYrBtYQGBhpN5DjSFw80JRXu1bt1iSXWDjEj+aWTnUbXbAEBvYSTqUAvkup90oHbcA5mu8ISHR9iRr/Mk6G/qPrSk8fxLeWK6neuFr6CAKOy/0JSCLcSOw7l/Ljtkv7LHJkYxcrrUEhAgxcVuf47vTYwUx1rTrnuWNOfsyZQtEcDQXzWmTB+89Ie1ImAz5kMV4HNl/xjQAP/AT6FK4Hgynp6nPa3Z9BNprjrnzGV8sHK18pUVkhCbOIII3O2kEWL+O63Ti+OQmHz1J20DeXd9NtnNAtuSeVhcH5sq90MgfqK8/Hb2HMPnUL0Q3AeGIz1izqi+CjqhUpNxE3LG7/4Tl+htLH65dBVWWoZqhtwXHjTxuK25TUzSi+m2ofOjYKj6SwIRy/++Dk9lXRMkhvevI5wD4ugN62hxY0OzGRZVKr9x63tbj4zHUaHElCFMhZPg+b4i891xt/+ZPMaLLL12QPlvzUIeaSWgudrU1L/UuBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QfMjtz/e3DwgtYJeULugmHyPIRFVx/cR3hYnPcFjbqR1vj6vmoHN1zCXdHSS?=
 =?us-ascii?Q?5qSEyWc2fERF/Sn4pdGLw4CAb8a7alL17XIxjcCzGzEa6HYIZgPEnYEHk1TC?=
 =?us-ascii?Q?bpHSyhyO61wk30IadgCSDBlLl1uBtdMo1hm1zvMBSe2Pl/dtBtnvSREYw7Vf?=
 =?us-ascii?Q?K9oscunyUvIm3R/h/zddJY+QC5MM742MEgDTSRb6qyA7jIWz2eLPo4g0B9An?=
 =?us-ascii?Q?lujO0P98dsbqsIKRLch/LYEMmIUOAvmUn74XZzHJDqc8Gwg+Zk95Hn6K0/d2?=
 =?us-ascii?Q?Qq0o4euxZwUdLVX6UnagLK3/WDjQz/Ny+VG8WT+Ur6Ne5bwMuR3xCaedbNoq?=
 =?us-ascii?Q?CXfa5dC8wpisNUNoGuJTwTo014BcrCqoJ62df38cDEsekoxt9HACo1tmh58h?=
 =?us-ascii?Q?OEh0FoO3+AUz1oDnPhXSKi6TKH9oodT/Y1YCOlKHtC8ZhFKlDt7G6r+eTlYi?=
 =?us-ascii?Q?02crQ8tOj1sBrYqvDNbUZkvMVy3qA/eTmQFT2/25J4bFbzHiVa2Nl+G1quuZ?=
 =?us-ascii?Q?k3K90G+BIAG307qgH9BPP3sSNS/sU/N8CVKhjrL1PJcqTqFZ7zrcMdgrMpTr?=
 =?us-ascii?Q?sUpBjvUXXlSXQUduck4xPywJaZ0hu3qFYbVa8uOHVGVFcfg2pg7lGDPQtfVk?=
 =?us-ascii?Q?EKtIaqagHhFI1ftGg4E78kMdDuPPTFR5I5APWoTICMruf0+eqyXgjrsoaLyz?=
 =?us-ascii?Q?tEZyEX0nL/pQX0dhjBpyOkJQz5i5Qh6jOhEokkjS9UB3LK4UCCWvDAa6xWvM?=
 =?us-ascii?Q?SghryunloBsWzi1YIXc9FBbc+0EmDQev5/WfCwLyut086/ZYllZmZOCqPoP1?=
 =?us-ascii?Q?FjkMRz0nGauJK7EaQVg+yFBM5RlOb5cHpQrtNs1l1TF/MCyy15JoaffTSBuB?=
 =?us-ascii?Q?zlcYl97xDgZOoDBe8B3gXhk73fz+KcR92l/AvYEu6evMsJf4TROpliMf2dK0?=
 =?us-ascii?Q?idMPnWCc0ZPFqoCcfCGK+TxbWnmW4yWmqJiiygCPk78Jq02/n/+HkaZEGxky?=
 =?us-ascii?Q?8rr6ifpYL8Tqwit+hDBNOcfFmKkGEm49UN+nvQ7L6ox3eM2A7A1TTZ4z7Jc5?=
 =?us-ascii?Q?9VVlYkQKRCI+O2Fhmz40HBblTKxw0SO/XDLxcaQF7NmvwxImKmFEe1DlEUbW?=
 =?us-ascii?Q?CHwCH/rvF0Ex9EvoAwg5M6D13JwQsgfboZZNOrGSI2cpbelybhCdugaYEA9M?=
 =?us-ascii?Q?yHSx0UUfqNlMVvuHuEPIISLyTGtQVTIMKcmB/Cvw8R1qO0OYK6D3/ULHt+VQ?=
 =?us-ascii?Q?R9iALP/sUun1N264Cz/oZSGgIium1RnKrRAUZl1xjeYv8T+6dsxJaFgKV1Q/?=
 =?us-ascii?Q?aGLl7dEAL1/YUyUtO6zuuSo1GShdoSIFxa5nBhZhywpyo+wfrNZPIxb4SRpF?=
 =?us-ascii?Q?EVwE/oktA8P3yLGoIdDYVX+mJRxJXM18A7wBqIfQeZGSv8KiY+6MYBoZ+1GS?=
 =?us-ascii?Q?yVP2atwWsROAuX40Znd6FsNu/qyZ+uEpSCjN4DTZS0ZV7ywoYs4doroNc2g0?=
 =?us-ascii?Q?zVtDQ+7r5DwBoCOCT/NkCuN83w/fO1lvdM6h1kSZKHJiwIYNDM6e9URk73/5?=
 =?us-ascii?Q?7bs+gf+I6CmUG/4BtDhMMRpmkbXKDIUJc7xCdhqG+GJQ7AIvPerwGWPZZ6tD?=
 =?us-ascii?Q?3NxETIwx+XJk0uEmbP1n5DiQq047CgIKU9jPzWMH8qGhu5bHw50Ga9G52YbT?=
 =?us-ascii?Q?+aXO50E1o0cHf5YN5XlL5NpiUf4vNf8YB1+iDoqDO2ZAJ3dD7hiCCQm3KCUi?=
 =?us-ascii?Q?gV2FH7+7Ui9jXSY93prmgRO/hOd3Ni8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b492b-3b04-4fbf-2720-08ded2d20a80
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:54:29.6481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRMLFqJ5q5MTWjxxxMpjSd6r2x+9172BcySy+v+XFzs5kSD3Lk+QDDAMJnKM1sju90+C3lS9c6lAWl1yoZc0WffQHNMFOcZ9NBIZjLg8qNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6566

v2 -> v3:

  * Patch 4: skip the kick of TX VQ worker once backend is gone - add
    to cancel_pkt() the same guard as in send_pkt().
    (Reported by Sashiko AI)

v2: https://lore.kernel.org/virtualization/20260622175808.508084-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (2):
  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
  vhost/vsock: re-scan TX virtqueue on device start

Pavel Tikhomirov (2):
  vhost/vsock: split out vhost_vsock_drop_backends helper
  vhost/vsock: add VHOST_RESET_OWNER ioctl

 drivers/vhost/vsock.c | 106 +++++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 21 deletions(-)

-- 
2.47.1

