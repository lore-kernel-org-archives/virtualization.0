Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E1411FBB
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766052; cv=fail; b=T65nQqR3PXkSYhv4n5Zb7FUirnouJz30DljqZbQGMv3mavoOxyCdWR8sukkX/h7+HrJ1berGXqBRvwNqeIj7sQpN7Zt4u1DX8ws+csXyCij1IZmmfc3YNc1xnkkumV04kXwgkaghZ4lHQtTijpjv+0fPXd1oedXTi6H64boPz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766052; c=relaxed/simple;
	bh=r7inYm+T3J2d0vdoZ3HDXsiG9CBEG0WtFKWrosm+Kqc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bmW759m87nuJDy7VeS3+0HLBHdXr/mcynpAF4ryAOY1yOQYB8m8t+m534fCw4meTCXFiaiAaU3Ail9EHtIigfbHdGEZf5ZHds6J5cf9e7rAW9uMZ8W1wRnnWE6SPkTCNSNZZEtxL+w3NriAkUpPvjBHXqds+AKsAjwRdGCnwLzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVpCXOeD; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVpCXOeD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8a4VYsn8Mr4soj1SYqQUUP8xsjeaxQBXiEfGMTES2RXKvEcgMl3L2/d+H3rkM7SjPrU2zbJ10EgwfJ2ktuHP2bIg2UXYix0tpkBlgXbanNQrwfZY9nR2HdjqneEkEwHlEKhT4gBLvbK8d4kXteZttvADvZCs0qMjiniwhr17Hhi4gmtj5MCnA83oJUl4HJLDGVGkjmMCSgwr/PROXbEugG8/WJj7qSyRhEv3ll2K26nO4xvD2LOHcUYIE04MVC4X/uuWZYamULqsD4OkhvFxZkTU4BHIq4iXBxstcq2KzJKAm88/Zj2T3HANwvs9ILRh1IUAJDd6qLVnm+jpr7K0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iovUH+Ca05qyTUmBTlO/Rdjk9ydZ4wxev894t1SaeqA=;
 b=ZTs+bCKIJcJzpT2BQV5VbzuXINDoEoOBD9ozi5LDzbDRuABJhf6QTLiJZAt4daCljEx7qsOVfZ/2MV5RMyPz7PcwoIuCYMOovtkFz7dRcwew51yrQClAasCqil7z+xIcYubZCn2jHbuEOgt8hegG/PRJxXmz3YKIPPVMtmVBXd4g2PmJqtCuMTKrVrpEuQLdS0HdH2QdMti/5L6Kk3N+PAUdk6J5zag3b44zEplCGrS2S/D1ZVuqUQ1vZZ7huVL+mmN5sklQfQoQ1PddqONsHkMW8hr71uLXOZ+zUD/mWFDlE55MI43KWj1dvnJ4lS5egxdgQe0dQUC0gddnGEGtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iovUH+Ca05qyTUmBTlO/Rdjk9ydZ4wxev894t1SaeqA=;
 b=UVpCXOeD0o7keQLthAJyWgkMMOob/kiEZq2DngN47sqxKkyDiZ2TsttVHmm/5UDo67YO/0TLYbsvMqmevpj5avzSp4B9bve8DHiKx2EBRr8JarTR/wjU3lg7zkg2cHHrR4YMI66Wo3bGZJ45eqr0MTJRme0zANNBd1vhNpI8xg+9db+DweKTSrryHPG0ekTPxFTJLeC0z7rvYuGsWOHoBi39KHjw+0+s38R2CO82pG+80sdBo5/wn5/lnJ1B0aeTbr7yIJk8jyR3+HxuPGOJPn+J5XV1sM1lXb6TxhZyHV9MZEPFah5d1g0eQa7491b40nwfNdEle4d7+mj3iiGoiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 14:07:24 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:24 +0000
From: Shahar Shitrit <shshitrit@nvidia.com>
To: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	parav@nvidia.com,
	shshitrit@nvidia.com,
	yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	danielj@nvidia.com
Subject: [PATCH net-next v21 00/13] virtio_net: Add ethtool flow rules support
Date: Mon,  3 Aug 2026 17:07:08 +0300
Message-ID: <20260803140721.1871678-1-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: fde5e823-c30c-4ca0-a303-08def1688a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|5023799004|21046099003|21026099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	T9bnkXXhT/S9gRFPwGJU2hlG9o8CeYjj39ox23WDf3251VK048V54FbjcSirjos+S3sfWHyA2eOCxzbJMyom08iJpeeajhuvTtOGzFezkCZxdsM9LXnC/+zWWDkZB87FrHCZ352sDitwePHN5JKNAScUo8z+GgdHVWfRN1vldDZuWcmCIY3Bhpv5OLWVdh5K1p1d3zlYPSKQXKG9VC22L3gr/kJk5RRw8Gkqc8fXuK99ApYpg3P5B2Ik9Rbn3u4creMxfUchcSK85wFs9OG7NmMH1QH7g5f9XZV5lWEjMH1JNGTZaEI9HKRpHSIuC9Hujl7bqNKk2kWlkxVVYbHp/xxSLoVKJxbF53Pb5T28plJ7/S+FyvojPjdhpTKJQhZ8+Lsii6dRMRFV1GW+bNNyXbRuh+sMtaIV0zeDAhq96eTOQHqakjlroX7fifImHBQrRhc/nnZARD+vyMYCN7bOcsliSj42En6kG+JWRDv94QxlHCjdeqwHUlsvszLdJ4ReHum88mwZEs7FUL8RtGnF4cJRr1aUyHWhU9vl8WYtcmM8FKUwEMOF1oRkAK3EnU4IPiWH+Xl5RozkmVjq34GhtS75Zl5RRMs4o2TABQ20akEoxu118aBeVofc6Jm2Spl7y6FVRUe2soWMHJaLygtRjLRxjQHgvRm3LrxFAL6rs/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(21046099003)(21026099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UnL9RSK9DeFEvgkhLVBlbonEfUda3EaDJXNKDEI153gAkCsgf2+3fEoskP1?=
 =?us-ascii?Q?P/ENv5TQjY7Qr+pjwS7AYm2jFCDso5KqBAPGUIXnxLYutFlYb/YK9JtU8PKK?=
 =?us-ascii?Q?WmiJ+svrD5vVwoYTARwE5zO2hyaGS9qbq3q7kdoXg1yaQcjJv34dMZaNv/8g?=
 =?us-ascii?Q?4nG5IDwyJtwYpMvtmY8fJFFzA4jNGaR7bQ9kCjlh0O3bBp5v9eRCHBgyEnac?=
 =?us-ascii?Q?COHz8GITMNOTU8uDeOUtwQZ3v90LbB7k8BnrmgNj3HUcJ3XPdmfLASFd81+d?=
 =?us-ascii?Q?st4K/ZxbuS0PkxKueNHaWirlyrodg6X5VGkXnmbyA/0g3meg+BFVFP1XsXpq?=
 =?us-ascii?Q?qpGmxhGX+c+v2+DBeaDOsmvBViBTr+Oh1X2I+nT/ZaKBj7i/HlM7piyP/zxQ?=
 =?us-ascii?Q?zMQ+ZYKk7bwtHZ9Fp0Msw3iwMHt/1lWi6sV90pM4gFVnQ/w70yKX9GqxpMvq?=
 =?us-ascii?Q?qj+sZIeQ37epPPY4u2nyKT4cp2uAWbacXHGJIiovbm8Mg1j9D72+yJbOhW1T?=
 =?us-ascii?Q?4RXJ7Flr/aI/ITa8853GePBCnOMoXN0Ct9bZ2X+gu6lQ94SbcE0Y9vdESuAo?=
 =?us-ascii?Q?/MyijgV+Xh5zbw+JtUscWmh8zSXFiEOKp/EGZxa4FL0wqPGj3+khBxJNh+yU?=
 =?us-ascii?Q?PtV9iDzrdY+jO/36Ddue07X3iRsa6DLHQYOtuXzJgLAn6n78v4q3LL5Sfgah?=
 =?us-ascii?Q?fZUcQkco8FawsHBR0UAJhYBBMY1MLeWdWlOGCQvhxgrw5T+jXRfRKVQvjcsx?=
 =?us-ascii?Q?evW4nnpXHkb4PFLzShLE/L/SQsK6lL9XmPp3oEGhGyM+XzyjYyafFOxcdZ+f?=
 =?us-ascii?Q?bZEzFKOIkRYBrp52dSbnfTOrh7b4srlkJ6WtJP4wv15IGqJQ2mQWRYD2DJK6?=
 =?us-ascii?Q?PRJwoF06FQzsEptsro2PxpKZ0SyIvpwxoea4L5uxe10YfjENfcKJFf2QfFeL?=
 =?us-ascii?Q?xzPlY0kvmzEWyRGcRx65NjYk8UXkkBKKGrdCDNMzDwXFHqiX2fMLLGoy8l4L?=
 =?us-ascii?Q?BGSqdJ2Wo0FyhFUd5FemooeVoq/FGzF3nP3JsCyv9wpFLwiHL5LrvZGJaMzh?=
 =?us-ascii?Q?RU8pKh3YlFppWbMs0fMuMyh+6JCj1u5BbhYfiR83nQTV42lU2UouvoY7TzQn?=
 =?us-ascii?Q?6UJ1aDD6l0+VosBkwjafuYdlfml1db6HAnwoRoQSy5TkQkGg1nsIjEzVxE7s?=
 =?us-ascii?Q?mgQdAgOj5qezRmtj1lvo8vJrQNRmKOhLPk03y1Lgzzi97iuKKPI0nKdqefJJ?=
 =?us-ascii?Q?Mu8NDdA2md56dYsEMzr9M5MIunpHPPqiQE+EhV93QYoajYNdgduYfNs6z42t?=
 =?us-ascii?Q?Rz/bIRGEs0CmQV0aradn8HQWS5EHHqcszP3KDkE8m5pmr1vnu9biSCOL8iqm?=
 =?us-ascii?Q?xWihU7cbDs3QYlPVCUMDNq2pPHHnhdY/AjkxPUfeKoZyT3HWGQejM35ZzCLR?=
 =?us-ascii?Q?N0MeNZVnDu3Q+FGg51nbvqHVV1cj5EOIchrGKqzAhz9GmF3AWCRJv3256NFa?=
 =?us-ascii?Q?Gu5iL5NBN9bGMwTXBJCH3MD/tVmP8WZMFo+qd7qt+bEzbGN+yfQYFReq/wZt?=
 =?us-ascii?Q?9uD10JCr1jzFO0t/an3Osq3RqbLdTx5d6KklsQwVMgh8wdH9IOHlH+tNryu1?=
 =?us-ascii?Q?Tvabx+C2eCBH8KbCww5FFaTIx120RmdcRduICyiAF81zObrePjxo4H+X31Co?=
 =?us-ascii?Q?rBtTA15CUaD+6jD8EA/Sr68c2GhxwELiYQUvVpeV74Fj+7OEALcuGVmW/7sH?=
 =?us-ascii?Q?HGd66d9yVQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde5e823-c30c-4ca0-a303-08def1688a9b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:23.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekA7xh+viBSy6q1Y9eirYi5Rbp5REBRfJcUX19qxa6hC+U67POqlF11vtgG7wj5iM1yhB/XmTOjWxfzcs4P6GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208

This is v21 of the series previously posted by Daniel Jurgens.
I'll be taking over from this version onward.

This series implements ethtool flow rules support for virtio_net using the
virtio flow filter (FF) specification. The implementation allows users to
configure packet filtering rules through ethtool commands, directing
packets to specific receive queues, or dropping them based on various
header fields.

The series starts with infrastructure changes to expose virtio PCI admin
capabilities and object management APIs. It then creates the virtio_net
directory structure and implements the flow filter functionality with
support for:

- Layer 2 (Ethernet) flow rules
- IPv4 and IPv6 flow rules
- TCP and UDP flow rules (both IPv4 and IPv6)
- Rule querying and management operations

Setting, deleting and viewing flow filters, -1 action is drop, positive
integers steer to that RQ:

$ ethtool -u ens9
4 RX rings available
Total 0 rules

$ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
Added rule with ID 0
$ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
Added rule with ID 1
$ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
Added rule with ID 2
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
Added rule with ID 3
$ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
Added rule with ID 4
$ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
Added rule with ID 5
$ ethtool -U ens9 delete 4
$ ethtool -u ens9
4 RX rings available
Total 5 rules

Filter: 0
        Flow Type: Raw Ethernet
        Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to queue 0

Filter: 1
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 3

Filter: 2
        Rule Type: TCP over IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 2

Filter: 3
        Rule Type: Raw IPv4
        Src IP addr: 192.168.51.101 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Direct to queue 1

Filter: 5
        Rule Type: Raw IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Drop
---
v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
  - Fix sparse warnings
  - Fix memory leak on subsequent failure to allocate
  - Fix some Typos

v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
  - Added admin_ops to virtio_device kdoc.

v4:
  - Fixed double free bug inserting flows
  - Fixed incorrect protocol field check parsing ip4 headers.
  - (u8 *) changed to (void *)
  - Added kdoc comments to UAPI changes.
  - No longer split up virtio_net.c
  - Added config op to execute admin commands.
      - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
  - Moved admin command API to new core file virtio_admin_commands.c

v5:
  - Fixed compile error
  - Fixed static analysis warning on () after macro
  - Added missing fields to kdoc comments
  - Aligned parameter name between prototype and kdoc

v6:
  - Fix sparse warning "array of flexible structures" Jakub K/Simon H
  - Use new variable and validate ff_mask_size before set_cap. MST

v7:
  - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
  - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
  - Move for (int i removal hung back a patch. Paolo Abini

v8
  - Removed unused num_classifiers. Jason Wang
  - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
  - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H

v10:
  - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
    Jason Wang/Paolo Abeni

v11:
  - Return -EINVAL if any resource limit is 0. Simon Horman
  - Ensure we don't overrun alloced space of ff->ff_mask by moving the
    real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12: Many comments by MST, thanks Michael. Only the most significant
     listed here:
  - Fixed leak of key in build_and_insert.
  - Fixed setting ethhdr proto for IPv6.
  - Added 2 byte pad to struct virtio_net_ff_cap_data.
  - Use and set rule_cnt when querying all flows.
  - Cleanup and reinit in freeze/restore path.

v13:
  - Add private comment for reserved field in kdoc. Jakub
  - Serveral comments from MST details in patches. Most significant:
        - Fixed bug in ip4, check l3_mask vs mask when setting addrs.
        - Changed ff_mask cap checking to not break on expanded
          selector types
        - Changed virtio_admin_obj_destroy to return void.
        - Check tos field for ip4.
        - Don't accept tclass field for ip6.
        - If ip6 only flow check that l4_proto isn't set.

v14:
  - Handle virtio_ff_init errors in freeze/restore. MST
  - Don't set proto in parse_ip4/6. The casted struct may not have that
    field, and the proto field was set explicitly anyway. Simon H/AI.

v15:
  - In virtnet_restore_up only call virtnet_close in err path if
    netif_running. AI

v16:
  - Return 0 from virtnet_restore_up if virtnet_init_ff return not
    supported. AI
  - Rebased over removing series to remove delayed refill.

v17:
  - Properly handle unaligned reads/writes. MST
  - Fix use after free if init fails during virtnet_restor. AI
  - Fix memory leak when validating the classifer vs caps fails. AI
  - Added missing includes. MSTA

v18:
  - Validate selector cap lengths, instead of just checking they don't
    exceed a max. AI
  - Add __count_by attribute to flexible arrays in UAPI definitions.
    Paolo A.

v19:
  - Style fixes. AI

v20:
  - Added missing include

v21:
  - Use le64_to_cpu() and BIT_ULL() instead of cpu_to_le64() for cap checking.
  - Don't use __counted_by on flexible array of flexible structs.
  - Replace UAPI header includes with kernel header includes.
  - Add missing includes for linux/types.h and linux/byteorder/generic.h.
  - Clamp the reported action count to the driver-supported maximum.
  - Clamp the reported selector count to the driver-supported maximum.
  - Validate sel->type is not 0.
  - Reduce selectors' count in case selector's type is invalid.
  - Move virtio_device_ready() before virtnet_ff_init() as the flow filter
    initialization requires the device to be in ready state to issue admin
    commands.
  - Remove forward declarations.
  - Validate action is supported before inserting rule.
  - Convert ring_cookie to vq before assigning ff_rule->vq_index.
  - reword a comment.
  - Introduce a new patch that moves flow_type_mask() to include/linux/ethtool.h.
  - Wrap __le32 limit fields in le32_to_cpu() to avoid sparse warnings.
  - Use put_unaligned() in parse_ip4() to avoid misaligned 32-bit stores on
    strict-alignment architectures.

Comments from internal Sashiko review:
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +                         u16 obj_type,
> +                         u32 obj_id,
> +                         u16 group_type,
> +                         u64 group_member_id,
> +                         const void *obj_specific_data,
> +                         size_t obj_specific_data_size)
> +{
[ ... ]
> +     obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +     obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +     memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +            obj_specific_data_size);
Can this memcpy trigger undefined behavior if callers pass NULL for
obj_specific_data and 0 for obj_specific_data_size? In C, passing a NULL
pointer to memcpy is undefined behavior even if the size is 0, which could
cause UBSAN splats.

[SS] It's the caller responsibly not to pass NULL. Current callers don't pass NULL.

> +     sg_init_one(&data_sg, data, data_size);
> +
> +     cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +     cmd.group_type = cpu_to_le16(group_type);
> +     cmd.group_member_id = cpu_to_le64(group_member_id);
> +     cmd.data_sg = &data_sg;
> +
> +     err = vdev->config->admin_cmd_exec(vdev, &cmd);
This isn't a bug introduced by this patch, but does this execution path sleep
while holding a spinlock with interrupts disabled?
If this calls into virtqueue_exec_admin_cmd() (for example via
vp_modern_admin_cmd_exec()), the call chain looks like:
virtqueue_exec_admin_cmd()
    spin_lock_irqsave(&admin_vq->lock, flags);
    virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
Since GFP_KERNEL allows direct reclaim and sleeping, can this cause a deadlock
or trigger a BUG if the virtqueue falls back to allocating indirect descriptors?

[SS] Right, but not related to this series. Can introduce a fix in a different patch.

> +void virtio_admin_obj_destroy(struct virtio_device *vdev,
> +                           u16 obj_type,
> +                           u32 obj_id,
> +                           u16 group_type,
> +                           u64 group_member_id)
> +{
> +     struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +     struct virtio_admin_cmd cmd = {};
> +     struct scatterlist data_sg;
> +     int err;
> +
> +     if (!vdev->config->admin_cmd_exec)
> +             return;
> +
> +     data = kzalloc(sizeof(*data), GFP_KERNEL);
> +     if (!data)
> +             return;
If this kzalloc() fails, does this function return without sending the
destroy command to the hardware?
Since the return type is void, the caller has no way to detect this failure
and will likely free its local software tracking objects. Will this leave
the physical device and software tracking structures permanently
desynchronized, leaking the object on the virtio device?

[SS] Not much to do here. There could be a firmware error also,
     and then what we do? Destroy flow is best effort.

> +                     break;
> +
> +             if (sel->length != get_mask_size(sel->type) ||
> +                 test_and_set_bit(sel->type, &sel_types)) {
> +                     WARN_ON_ONCE(true);
Is it safe to use WARN_ON_ONCE() for validating device input? A malicious
or buggy virtio device could intentionally trigger this by providing an
invalid length or duplicate selector types, potentially leading to a kernel
panic if panic_on_warn is enabled. Would it be better to just return the
error without the warning?
> +                     err = -EINVAL;
> +                     goto err_ff_action;
> +             }
> +             real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +             if (real_ff_mask_size > ff_mask_size) {
> +                     WARN_ON_ONCE(true);
Similarly, could this WARN_ON_ONCE() be triggered by a malicious device
providing a larger size than expected, leading to a panic if panic_on_warn
is enabled?

[SS] These WARN_ON_ONCE() were requested by MST during review.

[ ... ]
> +static const struct ethtool_ops virtnet_ethtool_ops = {
[ ... ]
> +     .get_rxfh_fields = virtnet_get_hashflow,
> +     .set_rxfh_fields = virtnet_set_hashflow,
> +     .get_rx_ring_count = virtnet_get_rx_ring_count,
> +     .set_rxnfc = virtnet_set_rxnfc,
> +};
Does this also need an implementation of .get_rxnfc to prevent invalid
channel configurations?
When .get_rxnfc is missing, the ethtool core function
ethtool_get_max_rxnfc_channel() returns -EOPNOTSUPP. This causes
ethtool_check_max_channel() to silently skip validating the new channel
count against active flow rules.
If a user adds a flow rule targeting a specific RX queue, and then reduces
the active RX queues via ethtool -L, virtnet_set_channels() will update
the queue count without checking the active rules stored in
vi->ff.ethtool.rules.
Could this leave hardware rules pointing to disabled queues and cause
silent packet drops?

[SS] .get_rxnfc exists (introduced in a later patch).

> @@ -1258,6 +1259,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>       .get_shm_region  = vp_get_shm_region,
>       .disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>       .enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +     .admin_cmd_exec = vp_modern_admin_cmd_exec,
>  };
This isn't a bug introduced by this patch, but by exposing this function to
general drivers, can a driver trigger a NULL pointer dereference or
use-after-free?
If a driver calls the newly exposed config->admin_cmd_exec() early in probe
before find_vqs(), or late in remove after del_vqs(),
virtqueue_exec_admin_cmd() unconditionally dereferences admin_vq->info:
    vq = admin_vq->info->vq;
In vp_del_vqs(), the info structure is freed via kfree(info), but
vp_dev->admin_vq.info is never set to NULL, leaving a dangling pointer.

[SS] Current code is written in correct order. Future callers are responsible
     to call this when VQs are initialized.

This isn't a bug introduced by this patch, but does this error path lead to
stack corruption?
In virtqueue_exec_admin_cmd(), if virtqueue_kick() fails, it returns -EIO
without waiting for completion or detaching the exposed buffer:
    if (!virtqueue_kick(vq))
            goto unlock_err;
If the hardware later processes the descriptor and triggers
vp_modern_avq_done(), it will call complete(&cmd->completion). Since the cmd
structure was likely allocated on the caller's stack, this can overwrite
out-of-scope stack memory.

[SS] The vq->broken flag set by virtqueue_notify() causes virtqueue_get_buf()
     to return NULL in vp_modern_avq_done(), so complete() is never called on
     the freed cmd. No stack corruption.

This isn't a bug introduced by this patch, but can this function return an
uninitialized variable?
virtqueue_exec_admin_cmd() returns cmd->ret at the end of the function:
    return cmd->ret;
However, on a successful command execution, vp_modern_avq_done() never
explicitly sets cmd->ret to 0. If a driver allocates struct virtio_admin_cmd
on the stack without zero-initializing it, could this return stack garbage
and erroneously indicate failure?

[SS] cmd is initialized in all callers struct with virtio_admin_cmd cmd = {};

If the device responds with fewer bytes than the driver's provided data
buffer, does this leave the rest of the output buffer uninitialized?
The wrapper discards cmd.result_sg_size without zero-initializing data and
returns 0, which could expose uninitialized memory to callers.

[SS] Caller's responsibility to initialize the buffer.

Second, if virtqueue_add_sgs() returns -ENOSPC, the code loops infinitely
with cpu_relax() without a timeout or sleep:
drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
...
                if (ret == -ENOSPC) {
                        spin_unlock_irqrestore(&admin_vq->lock, flags);
                        cpu_relax();
                        goto again;
                }
...
}
Can this soft-lockup the CPU if the virtqueue remains full and the device is
unresponsive?

[SS] Pre-existing, not introduced by this series, and bounded in practice by
     the virtqueue_is_broken() check. Not something to fix here.

Third, if virtqueue_kick() fails, the code jumps to unlock_err without
detaching the buffer from the virtqueue:
drivers/virtio/virtio_pci_modern.c:virtqueue_exec_admin_cmd() {
...
        if (!virtqueue_kick(vq))
                goto unlock_err;
        spin_unlock_irqrestore(&admin_vq->lock, flags);
        wait_for_completion(&cmd->completion);
        return cmd->ret;
unlock_err:
        spin_unlock_irqrestore(&admin_vq->lock, flags);
        return -EIO;
...
}
Does this leave a dangling pointer on the virtqueue?
If the device later processes the command or the virtqueue is torn down,
could it write to the freed heap memory and invoke complete() on a dangling
stack pointer?

[SS] Not a bug. vq->broken prevents complete() from firing.

> +     sg_init_one(&data_sg, data, sizeof(*data));
> +     sg_init_one(&result_sg, caps, cap_size);
> +     cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
> +     cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +     cmd.data_sg = &data_sg;
> +     cmd.result_sg = &result_sg;
> +
> +     err = vdev->config->admin_cmd_exec(vdev, &cmd);
Similar to virtio_admin_cap_id_list_query above, does this execution discard
cmd.result_sg_size without zeroing the caps buffer, potentially returning
uninitialized memory to the caller on a short response?

[SS] Standard kernel API contract, caller owns the buffer, current callers
     handle it correctly.

> +     data->id = cpu_to_le16(id);
> +     memcpy(data->cap_specific_data, caps, cap_size);
If a caller invokes virtio_admin_cap_set() to enable a capability with no
extra data (cap_size == 0 and caps == NULL), will this unconditionally pass a
NULL pointer to memcpy(), invoking undefined behavior?

[SS] Caller's responsibility.

> +/**
> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
> + * @cap_list: Pointer to capability list structure containing supported_caps array
> + * @cap: Capability ID to check
> + *
> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
> + * where each bit represents a capability. Bit 0 of the first element represents
> + * capability ID 0, bit 1 represents capability ID 1, and so on.
> + *
> + * Return: 1 if capability is supported, 0 otherwise
> + */
> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> +     (!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
Could this macro trigger an out-of-bounds read on the supported_caps array if
a caller passes a cap value greater than VIRTIO_ADMIN_MAX_CAP?
Additionally, could evaluating cap multiple times cause unexpected side effects
if passed an expression like cap++?

[SS] All callers use named cap constants defined in the uapi headers, which are all
     within bounds by construction. Passing side-effecting expressions to macros is
     standard caller responsibility. No fix needed.

>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  {
> +     struct virtnet_ethtool_rule *eth_rule;
> +     unsigned long i;
> +
>       if (!ff->ff_supported)
>               return;
>
> +     xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +             destroy_ethtool_rule(ff, eth_rule);
> +
Will this cause user-configured flow filter rules to be permanently lost
across system suspend/resume or device migration?
During suspend, device reset, or device freeze, virtnet_freeze_down() calls
virtnet_ff_cleanup(). This loop iterates over all configured flow rules,
sends the destroy commands to the hardware, and then calls kfree() via
destroy_ethtool_rule(), permanently destroying the software representation of
the rules.
Upon resume, virtnet_restore_up() invokes virtnet_ff_init(), which
initializes the flow filters as completely empty. The driver appears to make
no attempt to retain the software state of the rules during suspend or
replay them to the device during restore, meaning users must manually
recreate all flow filter rules every time the system resumes or the device
is migrated.

[SS] This is intentional for now. Could be a follow up feature.

Daniel Jurgens (11):
  virtio_pci: Remove supported_cap size build assert
  virtio: Add config_op for admin commands
  virtio: Expose generic device capability operations
  virtio: Expose object create and destroy API
  virtio_net: Create a FF group for ethtool steering
  virtio_net: Implement layer 2 ethtool flow rules
  virtio_net: Use existing classifier if possible
  virtio_net: Implement IPv4 ethtool flow rules
  virtio_net: Add support for IPv6 ethtool steering
  virtio_net: Add support for TCP and UDP ethtool rules
  virtio_net: Add get ethtool flow rules ops

Shahar Shitrit (2):
  virtio_net: Query and set flow filter caps
  ethtool: Introduce ethtool_flow_type_mask()

 .../mellanox/mlx5/core/en_fs_ethtool.c        |   17 +-
 .../mellanox/mlx5/core/ipoib/ethtool.c        |    7 +-
 drivers/net/virtio_net.c                      | 1557 +++++++++++++++--
 drivers/virtio/Makefile                       |    2 +-
 drivers/virtio/virtio_admin_commands.c        |  173 ++
 drivers/virtio/virtio_pci_common.h            |    1 -
 drivers/virtio/virtio_pci_modern.c            |   12 +-
 include/linux/ethtool.h                       |    6 +
 include/linux/virtio_admin.h                  |  124 ++
 include/linux/virtio_config.h                 |    6 +
 include/uapi/linux/virtio_net_ff.h            |  156 ++
 include/uapi/linux/virtio_pci.h               |    6 +-
 12 files changed, 1871 insertions(+), 196 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.49.0

