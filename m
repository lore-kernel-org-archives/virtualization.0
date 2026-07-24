Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021119.outbound.protection.outlook.com [52.101.65.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1993F327E
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893562; cv=fail; b=GZWWPAwYQxuHNJGKDAx6yykoQN91qEqm8rwHXJZqHm+nwGrPwyKoPtP7ajSHJdGHHcHUkLfem9BieET+4mOczXEt5HVzZfTH5IVsF2QwAWUXJmyHIEIVYOxW5AQSySFqK8SIpU8P5a7P4HlAeYx+eseFi05lmaGDleb61soAuKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893562; c=relaxed/simple;
	bh=5tWMT/eHwstytUBwaJkIBU9kWzMznSeLsDDMxWaY04o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UdEhcNYZpGj0iSHwBrRYmBgo2gB9YZ3kUmEgZCV7lgrLhD/Z5ZFUicK3eM/OHZgA+UoatpMWsbac0JkiBOOJkO9ujkwzHhRz5hQLFc/wMm+cU58fMXe0mQnO4OAGj9KMskSTzDlV5ib1QURXZimCeWftQfzeXAAlIlcJmVLcHGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iBKD0hp8; arc=fail smtp.client-ip=52.101.65.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iBKD0hp8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKQg403LrF8oa1iVpmhTeXNLIq/8VcO09rsY+j7Kq6l8HKvYsaRZk077sAiMOpYNQ88/4eLOqE8PDGR/no9Wn01HUtRihiYy15x2Teqq2B+uU955zfSf9N5Got5VxRwotZmfEMJBccIny70Mv2/xlSbxfbgSOswzJasn4PcXzEhxNSY3gI13cbkV8iDoBr5kxl/50DIDKc44kxgSJuryaNNYseeRlJJPwB6nBQFL+oiwN+n8PFKMv9CzsDPYv/VhMQEucfR23OzjG0iUAuhtMmgWoZwxhiKSWEUssYAInzn/YmyRhicNt5xB+yFsbruhESZIKVdLEROJJ2i4WI80pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I99/fXRTh6PBsfikJse4Vli9N6zT8wmzzFmscsAgmVA=;
 b=tbcXjwN9HIxEgSAe8K3KUH63PVS6vmAE/FyJF6pT0q4XA2KTVbkx1MdAHXq/3cmXS4SLBGqQzBZVNc7SYpA6GtzomWEbO1la/DCLIESHHFPjpV4OSDaURudqZmzTwwn+dA39MpzSi4mjmk0hrE/w4KoCCgWyrEYoBvD4svRP9CxpzATdlzhWrNOiYPadbxnfsx6y3NrmqzB1uPcB6Kz5fs2O2dFFIfXYl08kk0XThxwZVibfsOs9R9gHTKoqwOLXs0FwSToO+DVi83OJEEecTlGQPPX7wsgv0qJ7pPJOXxRHbfrQOq4a675DwQZbCijzM+yQHW8GFgiW/TmSDufxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I99/fXRTh6PBsfikJse4Vli9N6zT8wmzzFmscsAgmVA=;
 b=iBKD0hp8jwZzH2PGCsXtJ3L7oTGjZivA3liwKezTyel9xMncFcW5K4s7J4NTyfBUBPMp0NdK591RZO9sPrXF4Nz2RemHhY0rLKRq+SlTwLJhu9MXhRTqzO8/L7Y1xavYhFtaN5cVSvwhbbT3B4iu9fdJ8meHIiJBIqyz7UD7ZFZbXejtElx3h3TEHfhLGZGY8rTGOq5iYR6lPWsEmGbKV+9N9nuqBot+G3Fbtc70479YbEul0xxFN65wOsH70431gIf4W0qCZg4nA7FXw5O7osvPkXhIfUnkiBG+bEB7NnzLD+7hw/dttDi5K4SzWn7tFESwRc4UIYwRVw5ntOihww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11775.eurprd08.prod.outlook.com
 (2603:10a6:800:311::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:45:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 11:45:51 +0000
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
Subject: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER and CPR migration
Date: Fri, 24 Jul 2026 14:45:37 +0300
Message-ID: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI0PR08MB11775:EE_
X-MS-Office365-Filtering-Correlation-Id: 47babc9a-28d3-45a0-b9fc-08dee9791c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|1800799024|366016|56012099006|10067099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	t2e9AUGNjNgkj/YHKYtTnS9U6bSMW4gPFLWhndpwx3zWB8tGI0LSZHO8fhvW5i5P7lizV+5gQcWdYcviuOdKueNpXQgNj0m+GI8k37rqjyhwzXlKLMr8dx43ci9g9Fa58zfcdTCFdsdXVCIE2bGHNp4w3Dcwa+HK4xVnRLG4N6KZbpUfHDd0pkPca4wQNGku+Aw+If9YxA/yDXN2rSgCw5K67o/K/ciSBCtEEcPmQb6wOf7wv7SW6BLY5bNQiyTbLndzaVD9lttFZ/dqPyyyR+gyISEimzNsut6rWkf/ntIrlvB8C3+HiF+4YrUweoGqeRAGGlYYePaD57TiRcqyM83wTtyJ0+W1tj5YnX8HqgTv/CRM6w5m3dIfeKtsC4b2fbZclLr9OgZEXh0tLcijwLWyh+mSbjabjm79aLmcDAj/R7LPCUXCihVyePyCzcNH5aLehcwgRdZi92wtRTAX/BtbpXCVEByITk0SEIcrySrsNgoZtCQY+UMyfbhhxwHSDMp9oLs+VNL+Lx3/xbzCiu47xgtJrMbPzvxYTQ4pZ+l67GXak1qe39NQoEWkGqaikdzCyQF44G+8fmvxRag7goQt1AokF9HEGJ058qjS4WGYLppxkoIi9uTTF81KuCd6GRUvFxzP/HfzwlItYrWACP0gErgsxSMzwx8b9tmDevM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5RqXO2zNDBHlCyDCvv0zqPzqOxQp8QanIDdz/shNfK2h087zMagu95hvVbI?=
 =?us-ascii?Q?HLpPrF8L2qM2k6uHeYLwhMjUvFzFEwhabPgAmN1DC/vXV+n6xuBWEZv4iT+U?=
 =?us-ascii?Q?sSWKwcJR9A1O0phBnC8PJFBWmKgJKOhnAIc5M6us5JmKgqp5l7HEmDWVYL9K?=
 =?us-ascii?Q?+3UdbVyIdUCZ85EoP1pQ69Nt2qUwlNlgzaho+asNy5XY+hKWHVB+QITEk/x3?=
 =?us-ascii?Q?5n/HQXEV/m0SK8qbyCnduZA3LGsKEorU0FNl1D04qwJ47bEoxNwZ95fzy6LQ?=
 =?us-ascii?Q?HLATNhvyZbi453CYE/R8caceUmn44gNn655he9DRuHCcHFMhvfBL7fgOVGEc?=
 =?us-ascii?Q?EG9zREIZU+JDd9Hl05Cy/zqGSQgIzAf7rJgCyWI3q4XX5aKHIDYOT8hVlvrQ?=
 =?us-ascii?Q?DFRfZL01ZfovZdFN+G0Fmvgn2aGFrRgtontvq5fk0AWn6BzdyE/lf/B7v9zU?=
 =?us-ascii?Q?GhFpUaBod+9K3nVAQ57BnQr/HJ/d/CNkl5h2pbgo66JplTdH/usw6IfI7rWv?=
 =?us-ascii?Q?bhJ85GBZj7NspNaVq1OQIbZjKTM/lE9okt9uGQ98O18JKGNqUv6E+Z2IFsDg?=
 =?us-ascii?Q?0pB25wBhGGBqRItM/Vk6lbB3wo/A+hfxnHqpDejqMplxWi4eHqcYVVy3fs04?=
 =?us-ascii?Q?saUomRmcHehItsCl3hVig9HVyjGvY4Eo23cIhvWz3rlhGLdlv0UByjM0Dfwl?=
 =?us-ascii?Q?yJV2/WITejpKuwkpgY5gjngB9cAjks3H3Fj3o1DJJzC23KgbeuGfdLYqmVDp?=
 =?us-ascii?Q?PscsqGK8vMkq3hAQManUKn6V+mLNxAhEey2RDvrplCGmErLCFlGxgL4Un2ov?=
 =?us-ascii?Q?FUm10Q8bWao/UPGWXCCJ5aN0UhH01XckV+vfAM2/yLQZGr1FNgZO3SRjCtyP?=
 =?us-ascii?Q?DTgJT9sYRBhIhM4Z92yRoBD333DvwHwtiTTY/19E+osV5+5slaReHdqO+LPA?=
 =?us-ascii?Q?bgMxh7pbqHfhnS4tONtHP8onVkcjfGvkCiiXM8+SmwaNtKo0rEKq3f1N7nc5?=
 =?us-ascii?Q?0DviFgPQOzQtwj6AHaMM1aPVjMy2JHPevOqkmczevRyrzZiiqKnNGLkdUCYG?=
 =?us-ascii?Q?C7IEeRmF26j5ErWL1scgYFryooZQiPDiEF0NUC6LT9SZmO59V5hKlZ2s8SVz?=
 =?us-ascii?Q?dxf0Xf7jCxhvVOpbzIQRZIx1HnWyzumP3udPnk3JlazFNfgNnxucqHrYcjwb?=
 =?us-ascii?Q?PfBSB0D+bxZjshQh/aRZzG76oSoLpyposNiGLUPMSRyz5OW7Rbt6+GDPYcGt?=
 =?us-ascii?Q?w+VbBWOwNTqtfi3jryAJDOOQhrIDOV70oftFHmGuhXWShgShouExZYIz5ZlA?=
 =?us-ascii?Q?DtJoSziT5FLEYn0zRYZn8AAsosUq1GRNntq4Sz+p5+tk44CIVGmVU/0tHgXi?=
 =?us-ascii?Q?1b7k9SHB1K7+MFqwNmIV0zYNiqbnmOltVJto5jROHiQDAiOA1ZhcLJDAeUvw?=
 =?us-ascii?Q?ESEVHZnezIq0bBZkX280c6ytSsDQtKqaSYZb9SBQRJPGY34IRRMZo3s5/Anv?=
 =?us-ascii?Q?rPzAnBfL/36A4hvBte/BnVnHG5Dl5FRpaIG9IrR7sjU30gewCtyxbTNFoI0H?=
 =?us-ascii?Q?kXe/Acnq7xKOEqpay+C7s2VbPvj9GuK1GS0VIMSBsiKayqxENrHbyynZUJmY?=
 =?us-ascii?Q?q5SNNJlMjZNko+Y1bShZUXj+VTL0tdSlg2dFZlC5EcaPwLNNAENqC7Jm//pt?=
 =?us-ascii?Q?9pt5SJxcfUUQNo7TtCUL9j4o48+Hxi6LFz+VdBSTPhUFqn+SgVkm4hJGCVXn?=
 =?us-ascii?Q?Y3nYSWapZNr2FeDXjgBopcA0Phhw9vo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47babc9a-28d3-45a0-b9fc-08dee9791c87
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 11:45:51.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pCceeWix1CC+arFh+W0Yn+hKYdK01bqA3HGehrRQxKcpR5iA39SH8oOHGfKWjoGyi1Gu09aBLG3SlBOLmut0dd9/WlmpaoHBgTcqYyduZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11775

v5 -> v6:

  * Patch 4:
    - make sync+flush conditional by adding a bool 'sync' param to the
      chain, as suggested by Michael:
        vhost_dev_reset_owner()
          vhost_dev_cleanup()
            vhost_workers_free()

    - reword commit message and comment;
    - drop Fixes;

  * Patch 5:
    - add 'sync' param to vhost_dev_reset_owner() call.

v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (3):
  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
  vhost/vsock: re-scan TX virtqueue on device start
  vhost: synchronize with RCU readers when freeing workers

Pavel Tikhomirov (2):
  vhost/vsock: split out vhost_vsock_drop_backends helper
  vhost/vsock: add VHOST_RESET_OWNER ioctl

 drivers/vhost/net.c   |  4 +-
 drivers/vhost/scsi.c  |  2 +-
 drivers/vhost/test.c  |  4 +-
 drivers/vhost/vdpa.c  |  4 +-
 drivers/vhost/vhost.c | 26 ++++++++++---
 drivers/vhost/vhost.h |  5 ++-
 drivers/vhost/vsock.c | 89 +++++++++++++++++++++++++++++++++----------
 7 files changed, 100 insertions(+), 34 deletions(-)

-- 
2.47.1

