Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2653AE704
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163095; cv=fail; b=LmyyZzifN0pEejDvUjj7XK4+4gkT5X49xiac1aIYRKMYhMmyHRXN84bXu5qDZkEKkjG4FkdBXocm8BMO4xK9trQtaoApSPgwzFia/3A4ulEY8qb0vkmzNm9Fa8i6Or5RV0YC/GBEx0KOYLcyxeEo0m+uyspy13GTKl3dUTR0Uug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163095; c=relaxed/simple;
	bh=xMpCTwxO390Pkn1FHYG//U+tL/2+nfMkWj9KZU+fKi4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lRx7qAIZli+I/8xEbN2bF8gTlg5+WyvSIlELkM6mBS+Vk9uXDjUDSxIrV/kxye09WnYgx7VY9pjDxNfZGguz0IxhPWDqH0+8XHCV+kXNw5Tr8t/WtObEbLKP1+fD0vm7Byz//nT6ZvCBIgmMqXrCm1wRQpWOEMmHPJaNYcAmXc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RRHUX/+H; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRHUX/+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haAWSzUCnbkt/Ai0B6AGcMz//lwiEibQMm+Z4nkCZUXpF7AtTucflctdgdwmyMpZKKr+7DoY9scGjMcoAtmyYn1KdAoOOePw+uffdzbPxxWbCgHa6kJoCK8UfbBIM1oMxwAi/eOxrSq9jpY8kqDbt5QGpaSrB4gbYRMaQ3E3ckGLx8lb/yYTGUEaaIzJBIYofurnZkfCSgB3yRqmD59zVqDuVfTSx8t7pGlHGWWCJQ0oUsXE60NvgIkUUZa29pPoIVTsakcqg6Du3YP2a0F45m78gOs6pAZH/gRXYprIsjqRFxYkgPyj2YuFlsH5jZNTBcnjvV9zu6443fCuyskElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RATu6vlig5t0ARTiNv6HfCJYnqHvQ88CM6nU/fsNyGs=;
 b=t6kYv/sxTIiZOTWMcAEcJY33OlC4Woxe4uVl87Xy1kstad09sANZkS0Mzyb2hrzthSMf4pDD3hHAx5NmmOSh4qVIFC6+gnhH1lqdLpLgcyUV9n4RVw7zyanxa01sq7pV7JTzdId+M7klAxkJq4DHBo8aVsf79aYWPl/0ue4l0haLATcR79TTSDfAUh4JcOwh1Bsdm5CUFeFsajyLC2h6G4f3MYD9tmaNbuVGTvZ0jEQf7A8AY9G9cxURHNE9wlLOYotVPwxfxAx52RRf3p+MQUXe82wpUZE+UzFQlF4Eop866kB8U9Ycm88Hk0tc2cnUbR/kzkEtW2E4xzKCSeDvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RATu6vlig5t0ARTiNv6HfCJYnqHvQ88CM6nU/fsNyGs=;
 b=RRHUX/+H/gFIUBGDTahO+efbe+OAVnSx97BekSziX+QGi70eo3YvHx6TXiVrKfND0Iq5c0lxCbVBwka0eVBvQFtVFp/QCxe5MkzZkBTcjwN3KudJLb+buRwn7K11DWOK2gSYewx6m27fyqd2IpMrielJaVcs/bznLiWqa530D9KzaDDNaBOKtLD36QifThMqIn2WL7/qze2XczhGdCZPh11UVfHxp5/3h3QJej8D8wqjOtY4mf7LBrhqpCfgmVlxZ/U75ATKZJgmfgPgyBZtJCH24CdSaKrV4SOKy2IX0kH772lTEIfzK9hsZvBPQIEI/YFveJ0SNgMnQcwSsPsVig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:08 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:08 +0000
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
Subject: [PATCH net-next v22 00/14] virtio_net: Add ethtool flow rules support
Date: Mon, 31 Aug 2026 10:57:53 +0300
Message-ID: <20260831075807.2891426-1-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d7bd73-bce4-411f-f908-08df07359845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|21046099003|21026099003|18002099003|56012099006|3023799007|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pA+4GE1MN/AFvyzEAFd9wskAbkPMReIlua0+FUSE6Joi5nCX8wBVoL9NE/4gu91mZQsy2/vHq2XeWtBiVaqAj5ajUBxVr7biHBUE4eHyVnCmBdPCnOzi5P3HZLiglCMnK5fiN21VohSeW94oERUAbL/MqmiVIU/bVdGD+vxqS/NT8wawJAMQ+QfX/69eR8jnCkkC90jH4LdyT9BOAJABcexHH8Gq6jr3XXDJLHKnI3sSV1n53bM2KAr5nraa9PwlM2YpAt8Kbdpcik/GMfx3e6jEy8C8YsBxE5BT9+volD2UVwDQx+lnn74HW14RB4dN0gsTFQccM3vI9XabW5uG0ZKwy29QoPFGVN9H326Zztc6kFAjz77Y7610dBriKyGcXN7Kze1Z2jgG5ibzwIk2PrREUZERBabCFDahDV4ZukCYM/JlexOf9qII+UAsGB4qsL4d6CszgNEce33byPFTnpb3w75QGYkLIYeEu9GzTnqG3BS/2KvpXQmyDcbRYnV+jJTJMX92JTw1y0d7wd5zYRfHx4mvCdGv/nPXerhV8OplmTfjkUoON68oQeGoo0W8dhxFzaZzfcMdH3+d4AbiTn5v9e8p6oMhVZ4jQsz9xJLBbNXc61Ai8IpPGFCZYIQDVY4UOwm5ocwK4G15Z2jLuqMPfz4ifgBbyIyff2SXz28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(21046099003)(21026099003)(18002099003)(56012099006)(3023799007)(5023799004)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YABCCaPYVTWmyScmNIvzDHwEbRVb1iQaiJs2S5urwoy/HVtNeHKsIbsjYdLk?=
 =?us-ascii?Q?4qlfjqGPxe+Cg3PmsDX5RCOy06G+rmvthSWyv+TGPovT3rSn7kfC8tEYyVTC?=
 =?us-ascii?Q?yjtVxj5rJAWhoyKirBgHkbYXsLYcnaTCOlCE9zOwNdZOSzb7HXuN3UoJPT54?=
 =?us-ascii?Q?NFt8TPcWbLpEEFUdA5ShSbaC0AqqIws5ecseHrW2HxXioU4snd6OqBCLwWQO?=
 =?us-ascii?Q?Ouwzusg449wBKP4j2U1g50E2ebJ0xvOqj37qT81lIgRJelIHJMfPTstzjnx8?=
 =?us-ascii?Q?Osi+7MSzrrUk4Dv2Os34JzW6pf29EVLmXUKxRUYC0La7YOMFjF5e4ZwD+uUU?=
 =?us-ascii?Q?gDsbhxAJJO/DbsH/qNXl+BF3JcDnTPkwYjmFnLhKLAH+hIpixroyHYbTakFE?=
 =?us-ascii?Q?eKouUZSaO10He0fmhj87FlFs5ZKVeoJX9S8pwFMdGPsKMG9uFdEw6PfzbRqa?=
 =?us-ascii?Q?RlYXVcL8PEZ/mMOkDF5p/GWDbnXrG9+5Wh3BMTd07BkJYpg8MUu1GKV4O3jD?=
 =?us-ascii?Q?fh86SH2ttXnLavhHbgZPi50RxMHbwtaFcef+6QpsKNBig6eGhKNGjEaB1kzP?=
 =?us-ascii?Q?wT02Ae9wM4nWqtXb61o/QffeeXQKsVUZXulewgZGVOB91ewQvO4U5bEiN9sS?=
 =?us-ascii?Q?SQQXMugoogzU29iKAKNMxvoEzPXNcn37XlW0rKe+OkI89vpg+AoOGFzvIR6A?=
 =?us-ascii?Q?tJwCUD4zPCRUHlvNKBlBPHxSEwkUupl6BD1O8qN5dtnPtf2gLJ3xxNGGMzGf?=
 =?us-ascii?Q?/1NH06d5ktLV2xvhAFXHTcmd1t3Na6Ujljglg/9e06107UbyL8CgMeOxOAKs?=
 =?us-ascii?Q?6MHicYAi+NuW2RqDxsUJ1BmMRxtkP8YayCmIB5+L5QyIs7LouGWq4YZByrlu?=
 =?us-ascii?Q?yvXfL7AMK7iZ09HnNZOn4jZJ2yR8OVZ7eYCDcmGv0qbw594UHpyqYkE4kT78?=
 =?us-ascii?Q?ua0St3gIjQUDwX8HSBjKTpN5+lAbWNNhS2Ha3wWRTIkT33ryejU81yl542/u?=
 =?us-ascii?Q?8ZQcf+WfmJ2f/u9IwiVEURZPtaYKlMFYt6zQg7cEp2KOSq7qjhAPedKugK6U?=
 =?us-ascii?Q?YPvb3Vhi6XdiKkqQvtpUI3Nl7wtSRQ6/WbPfvP/+MDGWM91UW8WG/jo4CIdb?=
 =?us-ascii?Q?Hz+LjAy71qndMKpDAdKETcdaCk2wD0Z+rANzqqqSBMeKkGAHmGNRINlMxkp1?=
 =?us-ascii?Q?z0ccdRUjbLCBEkQtC1eRSykDUzP+yRlI8jVedsFScqLLQCkPXd5BRrezyDIa?=
 =?us-ascii?Q?trhPjdh5UelPiMIkaR9o6rqlVJCU8OXmA9ODsqgte9/TYBv+a3Hdm+ajVDd9?=
 =?us-ascii?Q?5fQbhwTPz/gP0vna/l0ED9o1h67jHa6fRnYLuqQVmruO1o0GNaRmABZ/WbNn?=
 =?us-ascii?Q?APrIZBGI/GIQJUMmCkHbuyw5lhczioniMj8z2DhkvA1ggki4XudwTqRg7HZE?=
 =?us-ascii?Q?OtURqqaRRqXVqX3gRwAhqDHfRqstgw1dW3OcNaWcdlJGg6OZDZnHraGwrM6/?=
 =?us-ascii?Q?N2ZZdxNYntLg+7SiBUtlRSoq6P6ViEOJ0hC4Wg7BBqKOeguI6ASvgFIZ9v38?=
 =?us-ascii?Q?PfPLodtaQ/ZEIo5RVqmF1Nzi1EHPJeJtBGKMbt+zZKD4ebWIDaT7Kx+jV2yi?=
 =?us-ascii?Q?actoPSaATDahPwNbN2L9po4LzfDQfBr9NMxFcis+KUZuki41b8/B4Fx8pOG6?=
 =?us-ascii?Q?+Coo9kd+1otFO8+ya2loERZWwQXpS5Jun3qvrBsOFdN8chx9kjEkEwA7fdsX?=
 =?us-ascii?Q?ctmdL/9HZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d7bd73-bce4-411f-f908-08df07359845
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:08.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sJQc46RSdcoumQG9q8oRXCGkd/m4hwVFrHqKEof2n7QcOQGP3Q9Xfm6x25cjQ6zUMuH0J9hO1qU/6C3QRPBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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

v22:
  - Reword/fix typo in commit messages.
  - Remove include <uapi/linux/virtio_pci.h> from virtio_net.c.
  - Verify also selectors_per_classifier_limit in virtnet_ff_init().
  - Validate ff->ff_actions->count != 0.
  - Remove WARN_ON_ONCE() and replace -EINVAL with -EPROTO for errors on
    device side.
  - Use ff->ff_mask->count after it was initialized.
  - Add a patch to fix sleeping under spinlock in the admin command path.
  - Document that callers must zero-initialize the capability structure.
  - Convert macro VIRTIO_CAP_IN_LIST to be inline function.
  - Add WARN_ON_ONCE if allocation fails in virtio_admin_obj_destroy().
  - Change VIRTNET_FF_ETHTOOL_GROUP_PRIORITY to be 0.
  - Reject flow rules that require more selectors than the device supports
    (selectors_per_classifier_limit).
  - Report min(rules_limit, rules_per_group_limit) as the effective rule limit,
    since all rules reside in a single group.

Comments from internal Sashiko review:
> +int virtio_admin_obj_create(struct virtio_device *vdev,
> +			    u16 obj_type,
> +			    u32 obj_id,
> +			    u16 group_type,
> +			    u64 group_member_id,
> +			    const void *obj_specific_data,
> +			    size_t obj_specific_data_size)
> +{
[ ... ]
> +	obj_create_data->hdr.type = cpu_to_le16(obj_type);
> +	obj_create_data->hdr.id = cpu_to_le32(obj_id);
> +	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
> +	       obj_specific_data_size);
Can this memcpy trigger undefined behavior if callers pass NULL for
obj_specific_data and 0 for obj_specific_data_size? In C, passing a NULL
pointer to memcpy is undefined behavior even if the size is 0, which could
cause UBSAN splats.

[SS] It's the caller responsibly not to pass NULL. Current callers don't pass NULL.

> +	sg_init_one(&data_sg, data, data_size);
> +
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
> +	cmd.group_type = cpu_to_le16(group_type);
> +	cmd.group_member_id = cpu_to_le64(group_member_id);
> +	cmd.data_sg = &data_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
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
> +			      u16 obj_type,
> +			      u32 obj_id,
> +			      u16 group_type,
> +			      u64 group_member_id)
> +{
> +	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
> +	struct virtio_admin_cmd cmd = {};
> +	struct scatterlist data_sg;
> +	int err;
> +
> +	if (!vdev->config->admin_cmd_exec)
> +		return;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return;
If this kzalloc() fails, does this function return without sending the
destroy command to the hardware?
Since the return type is void, the caller has no way to detect this failure
and will likely free its local software tracking objects. Will this leave
the physical device and software tracking structures permanently
desynchronized, leaking the object on the virtio device?

[SS] Not much to do here. There could be a firmware error also,
     and then what we do? Destroy flow is best effort.

> +			break;
> +
> +		if (sel->length != get_mask_size(sel->type) ||
> +		    test_and_set_bit(sel->type, &sel_types)) {
> +			WARN_ON_ONCE(true);
Is it safe to use WARN_ON_ONCE() for validating device input? A malicious
or buggy virtio device could intentionally trigger this by providing an
invalid length or duplicate selector types, potentially leading to a kernel
panic if panic_on_warn is enabled. Would it be better to just return the
error without the warning?
> +			err = -EINVAL;
> +			goto err_ff_action;
> +		}
> +		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> +		if (real_ff_mask_size > ff_mask_size) {
> +			WARN_ON_ONCE(true);
Similarly, could this WARN_ON_ONCE() be triggered by a malicious device
providing a larger size than expected, leading to a panic if panic_on_warn
is enabled?

[SS] These WARN_ON_ONCE() were requested by MST during review.

[ ... ]
> +static const struct ethtool_ops virtnet_ethtool_ops = {
[ ... ]
> +	.get_rxfh_fields = virtnet_get_hashflow,
> +	.set_rxfh_fields = virtnet_set_hashflow,
> +	.get_rx_ring_count = virtnet_get_rx_ring_count,
> +	.set_rxnfc = virtnet_set_rxnfc,
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
>  	.get_shm_region  = vp_get_shm_region,
>  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
>  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> +	.admin_cmd_exec = vp_modern_admin_cmd_exec,
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

> +	sg_init_one(&data_sg, data, sizeof(*data));
> +	sg_init_one(&result_sg, caps, cap_size);
> +	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
> +	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
> +	cmd.data_sg = &data_sg;
> +	cmd.result_sg = &result_sg;
> +
> +	err = vdev->config->admin_cmd_exec(vdev, &cmd);
Similar to virtio_admin_cap_id_list_query above, does this execution discard
cmd.result_sg_size without zeroing the caps buffer, potentially returning
uninitialized memory to the caller on a short response?

[SS] Standard kernel API contract, caller owns the buffer, current callers
     handle it correctly.

> +	data->id = cpu_to_le16(id);
> +	memcpy(data->cap_specific_data, caps, cap_size);
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
> +	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
Could this macro trigger an out-of-bounds read on the supported_caps array if
a caller passes a cap value greater than VIRTIO_ADMIN_MAX_CAP?
Additionally, could evaluating cap multiple times cause unexpected side effects
if passed an expression like cap++?

[SS] All callers use named cap constants defined in the uapi headers, which are all
     within bounds by construction. Passing side-effecting expressions to macros is
     standard caller responsibility. No fix needed.

>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  {
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i;
> +
>  	if (!ff->ff_supported)
>  		return;
>
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +		destroy_ethtool_rule(ff, eth_rule);
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

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
-- 
2.49.0

