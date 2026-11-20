Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189671;
	b=IDKZUHmhXnl+FdvfPyouXvEq7USKQBL+sDJKJNx04w0efveiWcunVj7WSRRCGqEcuP+J
	 Ah6dVnK9YsgcT93/wY9Wy2Ya5FbdX8naqfAk2vdTG6kuSczNmKk2FtSE/IKuyp4HQp2ZO
	 +PUcmd2fXh5OyGySgBvD9CoL9rCO2KrSysa0qRUd3zt8YVVumQTBKiCltZzVoqfMNiM65
	 Cua0Xb5xCDVDDgg6uGHSjp0NwuRSc4PdGIZ+h6Vqi5eltKdFv594VQICIIJ+xnKAPlxSH
	 guZDMRo4QcW7gQpbbJog2J/hK539rig7vMkYfzS2PDuOksARrHxjdojMTMyk5sHuYlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189671;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jqEEx+ORodlha8nW63oHiuoWJ/8X7OG7iLx5alh0kUY=;
	b=0yPDmnPyYhhrAtw/E3dvyim9+4uTBeak2HYZGE79PhiKskRkHY2ItnyWo+UWHu+Kx6ZF
	 kIZTx7vLSxzYTqXuFpNVU98mfkZ4b3pl6TDOrRQvNfRx1OqOG/Pt6jnyiwJSNEjfMPrjB
	 bZF8QynDKmOZKLKbEQfVoFQq0rS77o6mJycVDaYXFHFa9zLZBtRvdVQ8esZ8/V6I5SXwZ
	 hYub5gQlE3dQAwhtmHwKyYf/+htJmTuJP8+9Z2/yYo+FbQXOp/YSe3YmCK+6wxaU4nrDm
	 YNQhDnTGhdHE0dP+UcKZYAshPp2b9ibo4fP61bLbtNmjHcpCjZ5H0M1BXKI5AYxHq+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=JnHat4r7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.112
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023112.outbound.protection.outlook.com [40.107.159.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0D606A332
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 15:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84E0D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=JnHat4r7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6hpo+HN9NIkpte5/joSu7f9Tqe2EYY03GWh4IwCTNVj0lZQkLP2OJtn5xfHfmXZcPSG1AiY7/YLDcKZdApOsOoS27jHnLpY1TBT2/TRall21OZC0McVS9aZpA4Qmk6EGELj5TQ2KrCZ39kpW/Zg3oDrZZZVWXX/rxpIJBiSWEO0qjSFgaq4VYmA7ALDgQyCk+Yk5G/Pt2Vb6Z4C0SI8dzdwGDFzciJR3PWUbDcZWAvTNti1ogmoRc9iHWv3caj9Gy2JSnHX1VEu+OSJFNaGIx4/WME4e4UOTPRfjG8XHERcMtkacXPl1EJ5hKtJzLWyfW+qWl0MnuPgl3KQ5QMEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqEEx+ORodlha8nW63oHiuoWJ/8X7OG7iLx5alh0kUY=;
 b=GH9vADEw9hPa5i0OUVnlhASB0UNtgn+WpSKFU6InJBo/nzktTo3Iu1X25OEQj7npUBzIveopw8J8XKV0W7ETFx2x6Gt6PjvhEujC4QUzQ4pu7UoffLMRQsFsmyP1vwFfW7ryzKVZzlxEVJ5O7zbitSO7qNwI3yIFDUEwVftJNKpgcWMgwZXn8KgD33o4P6v04oww4DQGEidpELZYmwhZy63tzG4EM3XmCStIeAHPCOjNuji/OpGVK4TzTta4sYKOQl3GHepBjRbtKLm9IWmzbzsjX1D+E5RuaewjBM9cTG5rv+lQT6A4UgwfXz9OHHmagehk2GbQefgbRHwmF8Ftzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqEEx+ORodlha8nW63oHiuoWJ/8X7OG7iLx5alh0kUY=;
 b=JnHat4r7JsgTUjexfzmAtKi7J/X4D//V/1vJj5tEJuSzy1wgxykggTZSCjU+pll9AUNAongVU2FSsXGSpGf+y7OrMHoTLC+5lZVSbTAILoeJD8rOtvOp0U8tphIo5sB7e136nAMvF8AuVmBWHDirjNngUT8mHlLDy1DnC2k6bYRA/NpSoZ7r4lfILhB/w9roj9HwGoZpsxe+NuQcefYR65wB6mdxilMwd+/H2q/vJuOjxSPcEh8U8YzWkr8O3bCWpLlgCgAeIZ0rdysdlW3t/xqr4wIj8nKU/AEgbB+obwOs8/TSO4nSxb4mg1tP/fdAKX8Bq+G9ZJIavoEJ4CqhTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8137.eurprd08.prod.outlook.com
 (2603:10a6:10:3ec::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 15:47:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 15:47:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	alex@shazbot.org,
	den@openvz.org,
	khorenko@virtuozzo.com,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH 0/1] vfio: fix KVM reference leak on QEMU CPR
Date: Fri, 20 Nov 2026 17:47:29 +0200
Message-ID: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::45) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a7ac31-fc54-462e-d09f-08df471d9f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|52116014|376014|18002099003|3023799007|261009223027099003|56012099006|261022105027099003|261026140227099003|10067099003|261021123027099003|38350700014|261026121527099003|261028144727099003|261022075727099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	q8WZ9/oe+2lJCSlsiOR6qJgaJDC+5rT5mY6Yfzk3XJUWlURG7b/HWOgb7p/cqblsR6GI4lXoQSYLRSnGPFxjuSBn6vomED4Sj5bem3VxggjG/nr2N6vxeW96pb8NWnOdolKKhT+bXWVZGpIHKPOLxsdOd5VO1L5YSmuSHVSZ8PjkInPkhuGBuXZSmbUcFRShdwZbFIC0ZeLbbjBfYL4l9dnA2V+1X7y7a0hdKhzL87ajFcsFAHWx+nj/5cKGKWZBRnx4hz69F3YQ5bJSuVZWf9tkflOBHNP9Wii6LSBLDDWUclE0857lwlIMvBHIbBTMBayc+RnWHaz9laJgj6Kv7mBIT4S88rKcG1s01qz4chjWiIiaP3jAafZVPvuZ+a81ee07Nx4jAwRJIKZRqIOt9/b91zv0vEbDqD++7IYNaJgTfHB7AUImjvcE5XGHCzZapGMVn1maibGFAeq3iW5ya74lXV7YJsEFDyw10772ZzFeeMSu2H5P188wEG2eSXu1trwM3tmm6vfHfChPo+vN19hHGcOy4ZACvzS/JKNwxq+tBpZawKnFnF9hubD44R/QnGjL1vLgVg24saxBCfsAYKQbGZXEqIUSyvG7vtqK6/3ppJXpYJrwnQ5GuMKwsAZZuKjs5Pg5LjkwCoYggmtexpMcOJ7PzATM3F6YqgeH+qb7FOWFbMzlXpjd6FlprPjxUTTlsNs24wwJ4IBWg1EhDFBS/Bq+fq6iIEJVI7jzsDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(52116014)(376014)(18002099003)(3023799007)(261009223027099003)(56012099006)(261022105027099003)(261026140227099003)(10067099003)(261021123027099003)(38350700014)(261026121527099003)(261028144727099003)(261022075727099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/N2KwY4mJsBhGwkASiA/BfksyPNk30zsviPp5fL0vJ2emKrpRkRV43r4QXXC?=
 =?us-ascii?Q?o9KTVPMEpgG/C/L+LVfb1WybEteo2RUAHSqK5gx6A3dtOaH4hR6DWeKwBqKo?=
 =?us-ascii?Q?yjLwA/v1j6TfU9lseyThWPy0nsVn9Cy4SFNrlTb9qWk+M+ZAnyvuTs5DuWC2?=
 =?us-ascii?Q?8P97KD63Z9eLvKyhJmFZUdDs2AwUa8aMiOcMRhWM/J/tq85jGJFyPilX24dR?=
 =?us-ascii?Q?IfZWleJAcCUtdIQPPBA5OJFbKwEykP4iLSOuSMWciBX0IwVd/QmxkU4bcF5H?=
 =?us-ascii?Q?+MAN05vAeF6AZnvtCVdZQgdWQGGrvqr0qg53phoXZYaO0ZlFi8pxPzp6e/oy?=
 =?us-ascii?Q?tHVXWEz5AdCYFiMP921LASuXNpOhrF/Z3nemd1KjuVIRGftlh94YCYsiuBum?=
 =?us-ascii?Q?JgYyRfYK2rHPw7p4RSCuJBlfM40chx3VT7Jx16pyp2kQ78WTLSrbvlQ0KhK3?=
 =?us-ascii?Q?T9UFzIDV02VGaLfIQc43XX8jOsQj8FTD3uhIuwWf5Rr0bxZwY8rR3BOuWngI?=
 =?us-ascii?Q?BNXVe4T41gtRTkRh70qHDdZVkcRQf/x+kgWXCfn53fBZN+9kl/jfAamD3UQT?=
 =?us-ascii?Q?/4g+ePwOWoJliK77ceaEGVl6HNSbVzIvJHwSe0gdrwD5oc6ggw6GvSBT61gX?=
 =?us-ascii?Q?jovZSrPd2RqI0rOHsfuxXHsxlBaUMJWQezmE7AFgWZym4OZi+dxk0thb+jcE?=
 =?us-ascii?Q?ecmsw2WNhm6jULeZ+pNTc/WS7IflNZAQacTBw16+QxtwPrb5hOwTEE2SEvCt?=
 =?us-ascii?Q?5OiqZt8rWkTnllyTvJvbDhiGxXXZ3KFYNgbHoUmwY6EQUNGTm8EXcMSRXQbz?=
 =?us-ascii?Q?0+bza5r+/mmHqGfx7pKZbZ7QaMyLaRXamwb/AhfhJEwOApPCOea/6wWFYpE/?=
 =?us-ascii?Q?Fj9ud3ikGqwmYICbT11PruYF+pT3mzHrHzh28/HtQo9lFWmzGHqDGWakF9GE?=
 =?us-ascii?Q?SVb5apS2r3RWJaMpar3903SOxur689//HuRe1kHjPgmXGMD1W1rAVoDVQb6Z?=
 =?us-ascii?Q?wkq15IllNG283BFG/ndwyb98kDoDxNKfXbab4Y52c0Y8Fb106UFGVlHiShjw?=
 =?us-ascii?Q?9HwuHNwfYFLGhEEIiZo8ELX9Q9Cw6MUOidyH3NkOFEsRyKkZQVDqTZ0v+wR6?=
 =?us-ascii?Q?g7+fpWyWyNGdSWomtJFUGE5u7EmLuyW0f6VIWiYBH7axOWJx1guio/89c8lc?=
 =?us-ascii?Q?cEVRNnimmY64RW3mp4W+bb2wGUL3tVMcEuxe6+/XFSkrBPUNoBPMLlgcdAI3?=
 =?us-ascii?Q?pA9NWGzLcqaZPZI9okyk3JQpBPo2J8lLxyELv5e+jJH48lhYKcwXcLnYu9Df?=
 =?us-ascii?Q?UdbJFzclrrAY8UWLwKJUfC1Q3v3wtpTIgpxUqcfdQoLXd1SH8vmUt+uInZVE?=
 =?us-ascii?Q?nr4/Pco4Tr5lRBagIhb3DFTTXoe2wam4AylZAK4fNJpG56srOwUB7GWuPGg3?=
 =?us-ascii?Q?Uilvf711YdVkgg3ALxiTyF9F01b17+uN5K1A1spOvBK+GJaIxXyTFPBH9GHK?=
 =?us-ascii?Q?yaWPFI8BfRzXGTqefFAhDry/jPO4ZUVXvfGJR7oRBb+XTmIUICvE3xapefKY?=
 =?us-ascii?Q?m3FCortsTF8EJA0tpwPfUjCJF6Rd8R57RnVC+v573YMTRYkv8D7JjIgCtynb?=
 =?us-ascii?Q?GLPSLSol9/eutg6JlxPNK44hhmQc/bA7a/SNSDBXWtIy3+aR7aN2EbuS4hY/?=
 =?us-ascii?Q?HwSYBcKcqLmTEo6wzlUhYq3Ce2/OqkPVTYXuPJdt3ODuSyVcPkCKQhbHEf6o?=
 =?us-ascii?Q?GgBx7dqAML0h8JReKZNss8ZylHhNGKE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a7ac31-fc54-462e-d09f-08df471d9f65
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:47:46.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JB3rrHDudjYF03gotsWhW4a7EQWT6Sjtm/MdJyT8L8oiE+e0CSTMmkKBVMTaRQfUrAvmN6cVItohfVuyDd+CcIiTEczc2azrCCS5bQJz4jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8137

When a VM has a VFIO device and QEMU does a CPR (CheckPoint and Restart)
live update, QEMU creates a new VM and keeps the device open.  The
device holds a reference to the VM it was opened with, so the old VM is
not destroyed.  It stays until the device is closed, which usually means
for as long as the guest runs.

It is one stale VM, not one per update.  It is also visible: after
cpr-exec the kernel logs "kvm: debugfs: duplicate directory <pid>-<fd>",
and the new VM gets no debugfs directory.

This patch makes the device take that reference only if its driver uses
it.

Tested on v7.4-rc3 with QEMU 11.1.50, cpr-exec and the legacy VFIO
container, in a nested setup: the L1 VM has a spare virtio-net device
behind a virtual IOMMU and passes it to an L2 VM with vfio-pci.  The
script below runs cpr-exec and counts the kvm_create_vm() and
kvm_destroy_vm() calls:

$ cat kvmref.sh

> #!/bin/bash
> 
> QEMU=/path/to/build/qemu-system-x86_64
> DEV=0000:08:00.0
> MON="/var/tmp/mon.sock"
> STATE="/var/tmp/vm.state"
> TRACING=/sys/kernel/tracing
> 
> hmp() {
>   echo "$1" | socat - "UNIX-CONNECT:${MON}" | tr -d '\r' \
>     | grep -v -e '^QEMU ' -e '^(qemu)'
> }
> 
> bind_vfio() {
>   dev="/sys/bus/pci/devices/${DEV}"
>   modprobe vfio-pci
>   echo vfio-pci > "${dev}/driver_override"
>   [[ -e "${dev}/driver" ]] && echo "${DEV}" > "${dev}/driver/unbind"
>   echo "${DEV}" > /sys/bus/pci/drivers_probe
> }
> 
> trace_off() {
>   echo nop > "${TRACING}/current_tracer"
>   echo > "${TRACING}/set_ftrace_filter"
> }
> 
> trace_on() {
>   trace_off
>   echo 'kvm_create_vm kvm_destroy_vm' > "${TRACING}/set_ftrace_filter"
>   echo function > "${TRACING}/current_tracer"
>   echo > "${TRACING}/trace"
> }
> 
> # How many VMs were created and destroyed so far
> report() {
>   created="$(grep -c 'kvm_create_vm' "${TRACING}/trace")"
>   destroyed="$(grep -c 'kvm_destroy_vm' "${TRACING}/trace")"
>   printf '%-22s created %s, destroyed %s, alive %s\n' \
>     "$1:" "${created}" "${destroyed}" "$((created - destroyed))"
> }
> 
> main() {
>   mode="${1:-vfio}"
>   cycles="${2:-1}"
> 
>   local -a args=(
>     "${QEMU}" -accel kvm -display none
>     -machine q35,aux-ram-share=on,memory-backend=ram
>     -object memory-backend-memfd,id=ram,size=512M,share=on
>     -monitor "unix:${MON},server=on,wait=off"
>   )
> 
>   if [[ "${mode}" == vfio ]]; then
>     bind_vfio
>     args+=(-device "vfio-pci,host=${DEV}")
>   fi
> 
>   trace_on
>   "${args[@]}" &
>   pid=$!
>   sleep 2
>   report 'QEMU started'
> 
>   for ((i = 1; i <= cycles; i++)); do
>     hmp 'migrate_set_parameter mode cpr-exec'
>     hmp "migrate_set_parameter cpr-exec-command ${args[*]} -incoming file:${STATE}"
>     hmp "migrate file:${STATE}"
>     sleep 3
>     report "after cpr-exec ${i}"
>   done
>   echo "pid ${pid} is still $(readlink "/proc/${pid}/exe"), $(hmp 'info status')"
> 
>   hmp quit
>   wait "${pid}"
>   sleep 1
>   report 'QEMU exited'
>   trace_off
> }
> 
> main "$@"

Control run:

$ ./kvmref.sh novfio 3
QEMU started:          created 1, destroyed 0, alive 1
after cpr-exec 1:      created 2, destroyed 1, alive 1
after cpr-exec 2:      created 3, destroyed 2, alive 1
after cpr-exec 3:      created 4, destroyed 3, alive 1
pid 6057 is still /path/to/build/qemu-system-x86_64, VM status: running
QEMU exited:           created 4, destroyed 4, alive 0

Before patch:

$ ./kvmref.sh vfio 3
QEMU started:          created 1, destroyed 0, alive 1
after cpr-exec 1:      created 2, destroyed 0, alive 2
after cpr-exec 2:      created 3, destroyed 1, alive 2
after cpr-exec 3:      created 4, destroyed 2, alive 2
pid 7607 is still /path/to/build/qemu-system-x86_64, VM status: running
QEMU exited:           created 4, destroyed 4, alive 0

After this patch:

$ ./kvmref.sh vfio 3
QEMU started:          created 1, destroyed 0, alive 1
after cpr-exec 1:      created 2, destroyed 1, alive 1
after cpr-exec 2:      created 3, destroyed 2, alive 1
after cpr-exec 3:      created 4, destroyed 3, alive 1
pid 6164 is still /path/to/build/qemu-system-x86_64, VM status: running
QEMU exited:           created 4, destroyed 4, alive 0

Andrey Drobyshev (1):
  vfio: Take the KVM reference only for drivers that read device->kvm

 drivers/gpu/drm/i915/gvt/kvmgt.c  | 1 +
 drivers/s390/crypto/vfio_ap_ops.c | 1 +
 drivers/vfio/device_cdev.c        | 3 ++-
 drivers/vfio/group.c              | 3 ++-
 drivers/vfio/pci/vfio_pci_core.c  | 1 +
 drivers/vfio/vfio_main.c          | 6 ++++--
 include/linux/vfio.h              | 2 ++
 7 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.47.1

