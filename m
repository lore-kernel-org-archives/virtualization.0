Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013050.outbound.protection.outlook.com [40.107.44.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CB310647
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511268; cv=fail; b=tXyiNiaJ7ZXHEQaCZjcqeslk1AjAUSjrHw9LKlYpuSlal/uW7XwM0LXvYSKitxmVx3t6+ATDXy5THnmHYd1ObMtsUDvkPVM0M3/ZwQkJk59bZ3hqVuxTsUekrpIf6pkmbrKiMU3k0agNwuInyZjMSmgta+oFWUP3pUjLe46wMTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511268; c=relaxed/simple;
	bh=s95CwWm1A+JCeiF422kE1/rIIOvXme/lQJ+iq5MNa+A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jp9hROXTO2g2As5x2wrJthPI1qlUYR3kXmXcXzcwRU8TZwkzzyAGg6ULlPgLwaUxZ8b5yIlCdDlAQhcRJkrghcNcl1wgiDEmvoA/C2iuhG8xwrl7TB7MlcNkp77nAPXVg9Gd5J1H2n8vu/dEWIHXkN/YLdmtrj3N16epvbQpbW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IbIz6ZI6; arc=fail smtp.client-ip=40.107.44.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IbIz6ZI6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFEx6I7/m5HVmwH13SRUd0LzK3mb3vfku1YtTXRfzhF4oxTayfUDsjYjVWKIk9iz95VUPKvxjOiG0Y+EvGCBKnXIxT1ZTjqpxabQxJS3kvoIcDSD6wg99ApNeo6erNSwk/ndkGABDn6waK4+BlWIH/BYEszx5znIc4VpNixpLNsyPVDhl02HJcuj4o/2EAxcshd3b0qv49vXwpXbcEVQBpqrmZfekMAq7womOruZwe/wXJ0TXKApEV/hmNKXqJwzXVL32xnSiVwxmfaLDvugNxF/qKEiScWUdeWbEbJoxHPqTZ/tElN0wz7QZEpmeaEOwG7as8h1PxM16E9xMln1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azjECE0WWyu9z6KYx+0Rl9t19xj4nxbf+/G7sWBOwDY=;
 b=NsY6jtJq82jvufVfSaQQcfVKg7Q1g/a4FEXDqY9zs1/vGmosbUGR+34yFnDz5DiJ11VrpkCMo4JFrqp85Pcsvo4zLXo6zsgGo8DBxwF/+Iir1ZiC8iK9hx1dVIwk1rZma8HNn+6i3VujiEjZ+TCqqq6GDqUXbyUPpHSFP0cle3zskqnpVgwB0kQHewxfY3RV3mH3TgYhfcmRHZek0vbnqp3iwbY2KL8M8P4FnV6c8P/PJoYRtzgbIEdvOJVcR+aI1ikcq8AkGSMrmKj/NNH21qPvCDV2Kkfj2Wa+/UzycsGLlsJ9v2x+SUUBWNxFRNDf2TfAkTcTkkl39kogYOvQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azjECE0WWyu9z6KYx+0Rl9t19xj4nxbf+/G7sWBOwDY=;
 b=IbIz6ZI69RjIc5JsEeaYaFBrFvrniJn3WaYq2cl0MnnCv7p+N46c3PT0atXxbuWBdyG89fYAFnww7dTVDQqKt/LThY+yxYLhddkipLk0Jxyp/X4p9+/Lj1BgQxs1BMRdCUpO5rYWjxSDpdZwsO08sz9859zGVWMq0DuMRzbb8EesXGT83elUFHAADzG1eUP0b65bJJP548u/KP0sZ2p4Fpf2HgnTrE/qpDIWxs3INuiYIfR1bPZZHyp9tvPt1pEkKXFhudhKhOBAi//jYuCxYmUY25DRfdo2vVoetPPo75osm7pFQZWurN523DfPmLvicL1KRzcFneoMcN7AQ86AcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by PUZPR06MB5674.apcprd06.prod.outlook.com (2603:1096:301:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:01:01 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 10:01:01 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] virtio-vdpa: Drop redundant conversion to bool
Date: Mon, 18 Aug 2025 18:00:28 +0800
Message-Id: <20250818100028.571372-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|PUZPR06MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bc4cf6-0b46-4bf1-3955-08ddde3e230b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSlLhXOQKtUYXF6app6jbMMQAvJsX+FSTTGIgsjE4hlf7Fy8dVmnywxvxqgr?=
 =?us-ascii?Q?0/67c3GUs2HPOyXHSMVwn/8CBaBKh3mioRrVXF77/9l01Jd6aeR0UGTsWiUj?=
 =?us-ascii?Q?zO9MGux3NGzJ1/9IsQaY5dC4uBdTb9VOUUuGoxNNyjlMCWsBJgkmFDwZJA9G?=
 =?us-ascii?Q?qbLwS+tjYXounzJgfXEGn5Rj27P0rGa+b4+kGRMFbgyHuGvOIOQ1iranq0CQ?=
 =?us-ascii?Q?PtJ23hgSNW7rg80v8+FAZTD8h9jBclgeaisXNWKkeO/YL0mnytivC7BrgngG?=
 =?us-ascii?Q?Ksj7VK4bQuSESfSVwbdqF+npeSsFFTWPwQFMeVD711oZiCkY8wYgKNXrFp8g?=
 =?us-ascii?Q?4NR68MaAEWpqwKebhbRYzqG9ZJoaTzK7jmz/WqkDc4Hbpoy5SJ8Gf8j09nPp?=
 =?us-ascii?Q?mYKnqztSoXbN3NPBF7UVJ9hSVQdBsc/sxt6mIUaXPuPjzHyKx6BSCQYhw1+s?=
 =?us-ascii?Q?78jtGfaxlz3nMX0Yltq5I6IIfg7CAD/v3Ww7besbuNDXuOJMEhRgLV29flEn?=
 =?us-ascii?Q?PqD2vN3cDjvOvTCy7OHfX0Z9AknC4IQYoJ12MpQmotxZfVcWFPRzXADGDLh4?=
 =?us-ascii?Q?KI9CC8In3Fa+zG7w/QwVzuhGVp12T2SC+DtFIYYP3Jzcj12hL2/dWP6zYrxO?=
 =?us-ascii?Q?uvx/wR/lKg09cc1FWVn8ylQQ2sr+ERuyEccqWWnJYGE9yLL7LzM4ezlTi05C?=
 =?us-ascii?Q?ubiXphmQrwCfqnK3EmH87tRkDO2bgWBlIaiu10NlQAnBlASx4ttOl8E/P0K3?=
 =?us-ascii?Q?EPtpxw2onibV+sHRM8OmOSwijTDWtx0kZ5R0AZgmDbhZ0hOdlHBGOvMc70oB?=
 =?us-ascii?Q?SnUGTVVoKdYLOd0h2h4HSXWEBKWNjT+S36g2YKks0bG99orOjKchR/6EJ6eI?=
 =?us-ascii?Q?EVKCLJSlwsHOnr+puZzCy6b7PDTkat6+3sYRjcJGCcyQtX/8S4l/AHzwmoSi?=
 =?us-ascii?Q?ZNEO0apgzNhQtIG4A62w5OyjR/+xz8M3moXfFErvqbb119M4nPZFootnY1Xr?=
 =?us-ascii?Q?TAcxrD4udnrf5r+O9lbpXBXVjF1u44lTt05n6s5gdWdB0mwWyLT16K4+tuha?=
 =?us-ascii?Q?dXkz4rYD0gQ2R/V15FgAqf7mj2zurIJJXzsmzYdgkdm5X07aCO0dFZJf7xa1?=
 =?us-ascii?Q?kw4jQwrS/QULPQk/B2Q95rHnEniRTIacSeP4CUonZzPgO2PJojdodNLIawIB?=
 =?us-ascii?Q?VBTntp+47a1UKXS8OdFpVLHek0xNMYVJX9sNX6lOUDU0jmj+bkdlk2VUm6nn?=
 =?us-ascii?Q?hpQwNDVXnBhMimDmFjKJdXnIqgQr+SfFM/ZUV6Wggb30uljcR9JE4RPjLpx9?=
 =?us-ascii?Q?cWjg++jng7enawoS5xYUu5qHMVxVx44687E6F5SOV0RDUUvIGPVkQhmS+cGO?=
 =?us-ascii?Q?DowASR6f9p0q5t6WTJvAqzhU+/5z7zRnm+u4oURBj819nxVROZ7V3jhgV7yh?=
 =?us-ascii?Q?zGRZiXxJm+8u7EO398RHZ5AUKUIJGL2SEkIBpOBlZTZJlS+cyktTjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hY6Opjvcfj/lDeFenuwaPGDqjfSgzLnUXGbSUjsIuS1kxgBln2yGu0fc0Fdc?=
 =?us-ascii?Q?67dRsB7W2ksiURrEo+BkF9zLyA/2TMSe0xS/TqMbHlxFQxF1B+y4BRnLR27G?=
 =?us-ascii?Q?C7uSKATr62jEfYz4LRAd/MyPoWRC0E6NGDl9DqdooGyb/f7dObQ1HtMo8IOc?=
 =?us-ascii?Q?66m/9tGtZcNYgMKGBKz49lvTNkNRHwAFQ7g/DFGnBg7tazVJLM3qa4iLbHNP?=
 =?us-ascii?Q?R+x25ib+PpWE20awKSVQpmG9IFdxWgDURKOkZgFiSUYwBM5CSJkV7Zv+lExn?=
 =?us-ascii?Q?wHEfgtcBzOIaEP6qyd2l1TudKwqRRI/BMBqMjDhejZwzblgfuYV9m7cQbqQ5?=
 =?us-ascii?Q?yIQDBOJvZmt7i27TMBaBBR4CCvgDuVM/inMmRuJoJOlFkgzP3wV+b4dw1N75?=
 =?us-ascii?Q?0V4GLQbY4AZSzMaUM7B1Y6VtF7/GhIvZXlqfK7fVHUvEYNwjqJwEe/mi+0Nr?=
 =?us-ascii?Q?4Exq1dSQWTBu9d4I+kQeh71JFTCYHdxxGFmcHUpV4YlPZO6IPA05SDzcEJax?=
 =?us-ascii?Q?s7FBa/FELLiL5oLdlz45kFfqvYdXuRGXCXYk7buIq/3vdj1PN2avl3hgpQa8?=
 =?us-ascii?Q?N9+h8zqP9otyiMzU04bFI2f+VHeMkrp3rXoG+buaUiTzLa1t534/DJnHToLv?=
 =?us-ascii?Q?mTMGK6nUVaiHW5nY+ywqvpdFnH9VEm0v2BK2/RwKhcLL3gIh4dXXHBZR/3US?=
 =?us-ascii?Q?T3S1svHBjBmMsQf3/y8AeK7tRv2FRK3MGCVPAXWIjYnSilQSgr8+9E969bQQ?=
 =?us-ascii?Q?IwJh+40ZplhTkzZ+7j0LkwSUDrYEgSTz8RydGPKhTyTMBhfJGLjiMoE8R4qM?=
 =?us-ascii?Q?/Mjm3m75l3oDVnqx2ilMfNb1iQaes2PVb40uGbVsKObYBueqLSB4A7kZhnVq?=
 =?us-ascii?Q?Bq8kgw1Sc27zRKOHVdCkpxiZiWBRcwpZD/fq+zDSXxoW/iPWHLnSxQQWZ7vq?=
 =?us-ascii?Q?gbNVjhRnMO2mWZ3E3O6STf9VbHUPp0X8zop7XzOjnlGd4es6NvWXDfOwZM2g?=
 =?us-ascii?Q?lAqJ4G8jss9kvycRdTW5YV4ceTHV3/DcP2GS45bp/AHhwh/oJuWgkJ/wOlmY?=
 =?us-ascii?Q?94XIznZM/3nmmqx/JNHvi3o5mfAnwCL/e+v1/UsbbNhVhgFJN9cpbXDyQFf/?=
 =?us-ascii?Q?81GTO86lSWyMl7+4qITwnN8oIaCcXL5jMrTUVRcNwA2EfBOr5fOapbY4HFrr?=
 =?us-ascii?Q?qjjhPYbOGZBGbifIuJxKsoIPs8K4vm//gR4KtHqp3vCYz1jq68Sg0a+VcYBA?=
 =?us-ascii?Q?VwUJRNkrgS4eKlstR0ACkZSa6MTwFt85mgF9ddfTVckAzR00f90OEGNcVF/S?=
 =?us-ascii?Q?8G7JDWdamW6YLZRMKCueIooZfCAl4zU23EVrzJAWzAXy9ma1TPjVsEwvnpwb?=
 =?us-ascii?Q?tkinJSYh0JHZC5BXRAIc4hLpnV4jHKFQxKUReDXjyvc0qg9Jer0YZNyDQciO?=
 =?us-ascii?Q?XqHDFk9u5aJEtqTEnbXrJDByXFm+dipSkW1Al2T3qUrWzYS+OtnM69UL/24e?=
 =?us-ascii?Q?JpqlOd4rPxnykvTy5ayM7lErhJXUwDbWQtMe6+9bPKbTaGO5yMtkEaJvHs82?=
 =?us-ascii?Q?MyrF/2Mt7Ogeo2Pdnzd7Y4fH9AKPYCX7pqXRpDiN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bc4cf6-0b46-4bf1-3955-08ddde3e230b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:01:01.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE2GsHefw2MdsDGPhLGszulxajdw2kvQ9VY+fPxnhV2UdO1dPkj/9aEWeXL69WfllvQmNoyVbLcWTmG0wBZyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5674

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/virtio/virtio_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 657b07a60788..09ee81470323 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -176,7 +176,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdpa);
 
-	may_reduce_num = (max_num == min_num) ? false : true;
+	may_reduce_num = !(max_num == min_num);
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-- 
2.34.1

