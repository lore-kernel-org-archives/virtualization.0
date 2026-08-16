Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B03D9529
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882893; cv=fail; b=oEouhBo4MeRSdZa0jG0hZVn23MybfdHG6PEaYV3tZzTwxFdh+EwRUDO0nZ0qp9ZDUs1532sshqpMrOVgzKxowEwtNZwp2YwWCjjYkyBVLOYJOoZejmLVLjElRhDjixMb1LZfdhIdb8KmxFN6rkFd4vn9a8LrQKHlLWzAKcb5TmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882893; c=relaxed/simple;
	bh=9wlDS1pa93NSxmfuJQ5falf25baCSNcleSPwjBfSfno=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O0YM2UzAdwhot9uPAiKRD7SnuET1hR2+2QxwcymaNaS2dVG+NLSRVEwDuSPiA/8B16//y73iSWaLfyQR/dE5Pu1ffTO+s6bAv9QaILmRGreU2F5FRPAn2qTnLl+5h3IXTCTLrSZvJe7QUyXimFzR0T2Dt4LzmX86+r05gA8Xhoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s4vNyn2R; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s4vNyn2R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz5OlXHvItuMOGACdBQ7ITCaeRcxoa+VObMenV6nIDRl4dmcQGTqANIQYCsDw3dnED+mGjMXz3HHo/eJc9l9Xum6BIMbE5b4E98DftPSfvyIt+V2jZEg1hIEMQg5yci0NiOjjKm8zzk2DVkrU7oMb3+zkI1hWYvxgIGmIyCV7mVRt46wvK4iIQDSSH81EI/js0XtCQk1sw01zy1R9ZiCYNuveTzhIYV5lhwVdgJOMxr77KDtWxwg2lI+QfFvM7MdCIZdiVwLgF4Y9LsKM2VTqTg9wMvLRVCpWSuwijQ1xOLv6JKFsiXKMliZjZKIQb7R0RchbX/NhOGtH+FEzY/xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9LkjimuGoEumZRfYhnR+XWcC+R5fVSLnWUXecs8vtA=;
 b=lUtWDdJCWxt31h3IXmkEqd/qNy+6p8b+lOzPjYMZqUSYKBd+NbFwVUCApRmKW3+WEUf/j0ttoVgauvUHA/rHgpkr8BHgbRsOOZTaVMGBL2ZEADrjuhrUMoN7k3LURgEdu1d8h3hCkCZV6eG7mvhyTAviKTGlvkDE/NhzQQ2JbUI9pbuhYP1AKfFKo+TlWWWJi9if7YyKYz/2XeHNDQMnhjqbecujWmX7sIyMlbmvT+btRsfejvsQ/A7xP+juImEALTmIY0e8/2hEqfDUXo4l1F0VMH/fA7yIX17Lj6Z+/bEHJmCcG25SxyBexmKhp/Zeyuav7Z/JFLnpDQSoSd/aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9LkjimuGoEumZRfYhnR+XWcC+R5fVSLnWUXecs8vtA=;
 b=s4vNyn2R5bry4kgt4nf2xwCtzRER1Svh76Fmi70hRjUXzBJoz1OYsPlZpxliT7HptKOgyg0ZCWeVWMGxNKGwaOqlhf/k5lFTx92KonMX5XHxlPZ2HBFW+anwx7omgnRe0Ft8Kla5NIXWfwGuX4M8qvc13Ut5Mnrqf7tqgntILPuyfeOloocqwkiu1xz+xnvIwY7gAspdNRqyCBzoPvaeYcz5PwEmREnfxPvKJjw5gqnzhJkzrxPIbFvnAoZc5Dq+CR66+lgBZwGxBe0ZrlYfCvvBzoqiAjprYN4u7b6A35yF8nr7QajfZzSt8drhjkiGrHxvFjYz9ss8mUrwuumgGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:25 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:24 +0000
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
	danielj@nvidia.com,
	gal@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH net-next v22 00/14] virtio_net: Add ethtool flow rules support
Date: Sun, 16 Aug 2026 15:20:57 +0300
Message-ID: <20260816122111.2495240-1-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: e1665b5d-4acd-4952-825a-08defb90e3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|3023799007|21046099003|21026099003|18002099003|11063799006|56012099006|5023799004|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QDBoUTIKS7LywFqh5hihuxTTMRm7lRKuvX1mr9s6cIfb/Z4H9Dr99zpujM248Wlm6BohhGAL4aXDdCoNnyTQUT2ArIqI5GwxmPIxeWSP5Lb62FvG3BH0M5+mhn5gRbL2uidhytBrIm17/ajFs7wBVCUsrLtk0day7YHddVjpvuuTNvH6cE2l1anFiCDTkYttra9vvK3wcKzY+Yv65g+rKQXMY46V8NmhUnZo8WkAEgUS5gdkBSma6mc/2sOvzA+r+1Mr1/hL+ZMwhUN0VLn3z1BXouyrm6ndr5A67IXLRGQSGP7LwVjSmU2AWbfe1XnL2DN2Do8WQqHmcxfTMYrBmuU/dFLNMAmrLS2z/zKN+UvLpi/WgzhUmHmVx/eHkuOxX3VSpItf5QrkEZ/2DiqPNkAFWJO4H7JtH4eVvLAvutd2L6JrMrtt3P8kd9rgIieZkcLMR9MiICA/hOSVudDmk7zvT2Tr0T+7OX6dhUiSFNu8X8HFGw0G8+eCj+Pl/1e5xWlBNUdxFhsxHE01E5LBe1X8iJAwOP53+gaOnfVrxf7PE4LOMwys66Mk2OqST8fH7IAJqoiDd7L7t/C5xvWlGiEs3OObE68zdpEPEvauA34/dV3TVzJqeFVG7N7dRt65momBsSV4w0JFDj/ddbVDxYjpZ3vzpSayTob2Dq2sA+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(3023799007)(21046099003)(21026099003)(18002099003)(11063799006)(56012099006)(5023799004)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qdSi3H57q/xmADtE4Fvo8yKbhf7JieMQCoRpmUKBOb9aFsmyTPxia518TfHc?=
 =?us-ascii?Q?a5FdEDyKR2FhH5b0S+wo/kZ7yzxuiiQ+4t7HsPN2w3aEJ5vtPMhE4uKV/oH3?=
 =?us-ascii?Q?Sgpt53KipmiepQGHMU7XBpZMln5vJn98lKkVZxEyIvbeWVAazSaA2hcOvogk?=
 =?us-ascii?Q?kF29Hol7zIfmnrzI7Cs5h42vcRUyn5XtcYHoPCqb1KraFQJyFKqmh0lN27lU?=
 =?us-ascii?Q?2C5Eb/+kDyKFDnxyDjb3QrTFR5/uUZ/bU5mhcF3W42ZSAF29G+XFgG3czNn3?=
 =?us-ascii?Q?j4Xln2LnhgmlKYwa+33Fd9ngMDkLf6ow3VnzTGNbOojr1BFmQbxTspMLLD+8?=
 =?us-ascii?Q?FkYdae1Iflv0/vQknM/OoIzEdRi4lon4hGGtFCHLFbXdpSYw7ul9TsE6WNQq?=
 =?us-ascii?Q?JfkVZKhGIuRmi2DvZZjo2LlP5MlY3UYcqhTj0V9Fx3qAkUnhArINJI3tfZn5?=
 =?us-ascii?Q?qCc92f7RSAokSEKSC+mSasWiZ2zZ+YJEX6Dy/7DocdKp4JAUQp0MlSgn09Fa?=
 =?us-ascii?Q?WiU9H37HPCXdoY/EpSCt0DwO5pwnT+MUq8lscLmHV5hcKfSH/3hmOC8436l5?=
 =?us-ascii?Q?UXFs5tVknkqvB5suLCDx6rPvN2ajSMfrKTfP/15+xNBuywoKIykgU/ijHGx1?=
 =?us-ascii?Q?thpEGS7Vh+KBaZlB4HKs6e6momxXj/efB8UZjS0w8/qri6mCwGksJrWv0jZs?=
 =?us-ascii?Q?NV4r1QhbKLYYP3bA067xLOWOoAsK9S6iFeIp2EfbLQb+GIOB4sGqJ/T3chyE?=
 =?us-ascii?Q?g8qXX4QKKZOI9BkXEBMPrgMmIDrHoBCZMrTErfMxJ/G606ZwNdpIPc4Mq8fT?=
 =?us-ascii?Q?jn5aaH+U+X89awz8fsT4AGIUl7E3xP26ZbG5xoasy3vLEyuZ6jtWH3BXw+me?=
 =?us-ascii?Q?rVOb0lv+EWz/UfGoIneAuXzhxp0Z+NNLPzkOpX2aF3je8ZJ3RteYu+z4zqpK?=
 =?us-ascii?Q?j2Ot4UQ9ipMzeWFnXcGKtB1XKBkNKk5mu5v8OVN6knyjqrkawSrjXbYOjp8i?=
 =?us-ascii?Q?IQQtyueJV6ckoDML7Z2vFD6QyxqHiZ/StCX5UvkXvoZI/xwtNWfG9IBcTg8P?=
 =?us-ascii?Q?Gbcc/K7dcVJS4Fssxl70MC+kgP6PLQigmC2kkUFrY6sHumIH5/eKWNXyWwJF?=
 =?us-ascii?Q?vX1IAi3JJxoAXkzwGPSWz1WM9KE9xCqeifOPkK9cnJRj01wSUwaOJzo9VYYt?=
 =?us-ascii?Q?z5PiiV4GJ0liPOdM8rWUXwGjqQ/c2KJStEL8V0cHmo8ZuKXP5i3pvIeZLEEp?=
 =?us-ascii?Q?kaqolYtHFXUZHh6j1NKHTg+9Ryttx/O67Y3kYq0hEPiz9Ylqvc49FQ4y1UGn?=
 =?us-ascii?Q?0enKChhT7D0LDTZygie2gV7O0+jveEjc1rnfZyBSBuT6+xsTD5dQSrEmlfed?=
 =?us-ascii?Q?caJPBXXy5VwqXne3HdleLYvuOa2asBmyN5K2E1cJdArNWd1XUhEpzErzaWd+?=
 =?us-ascii?Q?oG5qAQipjZGzvzMCltcwCpuewF2MYRc1GKSt3HzHzSnEJxa8GS9wzkqpmhGA?=
 =?us-ascii?Q?mblrtyfPR8YJvzIqH2Zt5aB7+ifJ3y/ZGsz+e9n6b7lNjU8/tTx3cIrQMF0m?=
 =?us-ascii?Q?liwqyBaSg4PzvsknVEqEYdGyIKqxONDb8vWoJf4BPdfaRBROBq/H2mcBvrI0?=
 =?us-ascii?Q?UWx0lyVV8sQTKL8T14IGKWzUhGtyuykeEjA1NOkesdVGz4unVWAiYNsUr/sh?=
 =?us-ascii?Q?XBmYXI7deAAB/JwA0hoMKMi/6o/g8HXzP4p4Y+eU1gJytoVxRRQuHCPJYJYt?=
 =?us-ascii?Q?B+2wkcGZlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1665b5d-4acd-4952-825a-08defb90e3a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:24.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P92ckk9hpM05g+M+kD9XHeNs1kEvbijaKCXAXugFn8a2/dhTqwvZDfvlj2g8+1zO6KvGjAxPXqbzNXuMQDDklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

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

Change-Id: I04063af28d3e7abb4e5a8a24c29f97f942a67140
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
-- 
2.49.0

