Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECF44A3E2;
	Wed,  9 Sep 2026 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944334; cv=fail; b=cwNb+MVLymlvWvjOPT4a8f0Wj4/8ystegTIVDtsRQmY8qWrYmweOeDFQ/7naOUUwcX5k+yENNa7Jd2Op7t9idGoivUQT34FZzYxJOe0QndoD2x5cELzIQi/aF6iQ0+AJEK8BsokwJWdQgrwlLitdwd33DPHExYULeyzozx1+QJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944334; c=relaxed/simple;
	bh=Cf8eTbyNjrFxrOda9Zc+jkVoBXSa1OiQgWbCpYpMTD8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NXsbKyzfOVGbACZqiWTUAmKFJJOvmKfhQ7M2dbmhlx6CRRuwSkiQkG6KfgQwYaXZws51LlmDb2dVCTdtJGHyN5+XgwSDXtOmk6D92adW0itosSLqJ4xBZidb8+TlbIgnhFXlZsKAOzcyMSC3uec5SnOEDfOdjd0axsDJFDRLGI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YuKWt6C5; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YuKWt6C5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqMsQ9M/bbVGD1XcY3yuQipE0mo/BIv/u/5EyHmSF95gBaz//XDc5jwPyAjwI1E5wRds4Pg2m/N9xADqTAFr+8Pi1LLFmKqjAzIA+xiLhpyQSzlx6vlW02CiugHbC+DN9W5+ubW2N7ZSQfetRiI7NLc+wNA64FZVpaEjdqe85YNHI6A0FdDgag6AZHVUFMPTZkjaNzy9FRVaL+eQAE8DxAqDS2OsiSun+Ai+ly/QHTvgYZ5QC01h1h+c6Jz6HUjArpeEqcF1ibEHMvEu8/2kYvzM71SxwZCcU4vjy0Ln8C22396h9/ZWPe3AWNIUns/j4S7JDAVKNeH16Tce8PPUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJsjxfspxxTGbQt6XXjtu4VB6eSG123JdzGoxgj4qoc=;
 b=ejRBp5IE2Mqyvkz4rB+JV9JFDXLbsxF9yqYlFCAmjK4gei6/ntzhuMdxe8pbb9656TEzD0jyNn4XRt/jiq2QmP5HDwnGJT6JlzoUNk9A4zspgw+7VtWhSBaWQeO+sidX+YU6P2IuIaSkZ1rghVaeNlFM3EfGLIcz43CknG4OeYjZmcgEebfiDdqJJ8P3zdsYruDH3Ymej/5bqMmvgnZ0lwsZq7Ng4XYESWXy8vDU2U7mwTy+XcrnxMGmqDurAKzCbI6K2F/E7nVUisjwVPrdxW3BGBgXX5qBr3xSa7kkbOYMuot9kVNfYUjkhV5dSCHdbtqdUZas+B5sESTrIRvX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJsjxfspxxTGbQt6XXjtu4VB6eSG123JdzGoxgj4qoc=;
 b=YuKWt6C5KDBbu/gXerNe5uIfB04FJhhRwj6wS2wYZuIRJGho2PgGD0ufkeCVvks9oQCRE4CwrD46QTk4IxsiQHZV239N06Fphg7KxHhLb3Vx+0w+atGnJr/7bGcAqSrbkc7le/aG1+/qzHom+FU0BWA9M5Ws+VI3p4WNS4NsiBQ=
Received: from SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 9 Sep
 2026 08:58:38 +0000
Received: from SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::d6c8:69ed:eea1:1797]) by SA1PR12MB9491.namprd12.prod.outlook.com
 ([fe80::d6c8:69ed:eea1:1797%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 08:58:38 +0000
From: "Huang, Lei" <Lei.Huang@amd.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>
CC: "airlied@redhat.com" <airlied@redhat.com>, "kraxel@redhat.com"
	<kraxel@redhat.com>, "dmitry.osipenko@collabora.com"
	<dmitry.osipenko@collabora.com>, "gurchetansingh@chromium.org"
	<gurchetansingh@chromium.org>, "olvaffe@gmail.com" <olvaffe@gmail.com>,
	"mst@redhat.com" <mst@redhat.com>
Subject: [RFC] virtio-gpu: guest request for host-managed HDCP
Thread-Topic: [RFC] virtio-gpu: guest request for host-managed HDCP
Thread-Index: Ad1AONHpC2P9NZ8VTkyKBnXGVCl6Pg==
Date: Wed, 9 Sep 2026 08:58:38 +0000
Message-ID:
 <SA1PR12MB9491792A2649FE3DD576B8C7E6B02@SA1PR12MB9491.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T08:40:06.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB9491:EE_|SA0PR12MB4349:EE_
x-ms-office365-filtering-correlation-id: 1d24396a-54fa-4799-6283-08df0e508a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|6133799003|3023799007|10067099003|5023799004|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 CO5+m+H88Xvi6KXqt3MZl9+2J4OyBwjOusPoIjSG47F7UGxRFHzDXHTN3qNiojpTltfWEWlOa7a2dFVlIX1mvQZPsbJlmgTYsmi0bjoxthu2fyh9fW4lFMYOBPC5r6N75vPbiiJeqohJUuckVdlIugSYwaG3adoC90JdpfENuwsPNoqXZ2fjpELyJuQjVcxUj89pE02zUC+DhHpyk88EopA6Vd/LYEdscm1Z936OgZXy1T/EoFTX1wks1V5Sg0b54rVGTNjhfzlLoPNKz8ICO/HQl+rggHgjqWgHFKZ8Hl1KxcdEtC7xCaPsXL9jHzeSrLD+g9pv0yH+8KSEhBWx2SPbPwSiEjzr16/VJhS1XpgXfXZmardeuS0LD9Blz9iYOaJwJl84UMnmKI/16bMKs7QJtCfmbqSDm/dLaf/vAeqJcvbZFuHPPnhGTENjAS4RLb+VqVwnQia0KVBYWNkrNNuvjajK6ur0/JIV4nx0u0eFgUo5Ypi5F+Wet0F1r7CqnMCqtUd1gykkCH87U2fN8x6HZf4kNN0IFQ3vrOzgfQOjjPjLFRe3m+bgQLEwZCDZnulB9R3F59Z3NnpMW/NJDUuKiJgRDoXdXtMUyO+ldY73h8Blm70KC+jlKuEHJ+YUCpBjYzjQkPtfFnw2IwZNccAiasUnNr1FnQwZji/uFoJuaAU4wjQjR9YPeaa9cnHQ3FVQf1UswP568u2xvSrcky/gqWZD8f0gLFGiERBqprg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9491.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?99xjtO/IkjRe+UpUULjli5yXjtxEB9KXqU8EJL+36BL55sbpzYYExf3iXZGQ?=
 =?us-ascii?Q?jWVWAatTG/S61Bl2w8SfgB7kV35TsoOMMjj0+dlF6uemvCb4o0haKaz8DODu?=
 =?us-ascii?Q?zIPJFS9/o+J5CaXHwmyldfHaUd5TUIFPS0Yp0jLL2VLqs44oBfrBimU0yZkn?=
 =?us-ascii?Q?laOSe3bnzpL0ypiKJsCB6Eic8sorzKuad4DodE28Udfhs/YnskWe7XdeEssU?=
 =?us-ascii?Q?hfZ249s0geTgrDduA04lPYOjbB0CGD/aulu7sruk1DkQZGrtkQiHWlxZmNrY?=
 =?us-ascii?Q?rAzEIJ7KFZ5Sm/WCE2Sw4E0coSyfAeA4Wf7X5op0MOqZkOygmsmgeNV9EoS6?=
 =?us-ascii?Q?zoYTs6cIBTmjuOYYquxD19BIzJfzmJl8VCgKywo/H4pEMBhu5KIhYBBwG9Ft?=
 =?us-ascii?Q?PhxJF9qvnPuFGiKVRzKsWuBY4s5tdCcWgd+FOW1Plo5ACnVdwqMNi51WSIfE?=
 =?us-ascii?Q?19f5g0ehmvzYd62rWqYPQhmGNUhfqZB/+GN8cM1dmK5d2AbVSKubHtn3LXCO?=
 =?us-ascii?Q?9XILL3zxQjwiUW+T52Vp1K+5WV/wrticndH2W41cdP/JN2Ts5Xc14hCNG9L+?=
 =?us-ascii?Q?Q7g1Ox/18WIzEcQWEhc9Dqmviq6pc22An0T2TicnkZCWdp7mBir3FZRrFaTS?=
 =?us-ascii?Q?6RqNbBuxm3iawpW58sn9bgAMnCI3Gc7B1kbOJshlK4EDRP/cj1DyjBOFSLYR?=
 =?us-ascii?Q?KuVOVb+HRuiFDvEocuMjYcbDnAEF7YrKk5KnxsifMnMeF28G/DDF7t7W85mw?=
 =?us-ascii?Q?Zd4u69GvMlO4mrhyjhxjZU/WTtFwPln9D91i+zIqwWFAoL+02h1Q3M7k1uDi?=
 =?us-ascii?Q?rKXbG5tr7/63WFk1Rkc1rte3YCQgHHx0A//JiBNFViCjGv9ol/JD8MTs434b?=
 =?us-ascii?Q?KbTNcZo4AX6Nq5XciJTCG+zeOzYUif9UzCJXvyReJhhV8TymLfHVeib4CxSW?=
 =?us-ascii?Q?xwOXUzgy2KkR7/psoqy2aRkYrTgyzq5OdZhUDLBMsr7vTYyjUknPyWdoQpcY?=
 =?us-ascii?Q?iYwMG8US5I18o+T6y/Vux1GQqCERwfjqhLd1aY48R0yBvd5oEzCIMAzc+NHF?=
 =?us-ascii?Q?y1TrSJCWeFtA0O6LtYzPD3uZJMu4QlMrnHeZm20iZ8aa/jNov85yMPgfRunG?=
 =?us-ascii?Q?ilHQzKpKhDy9x1l252FzgiDmEyewSQB/n1fq0DxMVYXwLm4R9ferhJCewjsv?=
 =?us-ascii?Q?uC2DumLepQ8yDGVmbr2myqvVdmhtMq5B2lV0i/C/I8uzMDio1hlgLL20xVHO?=
 =?us-ascii?Q?ongbdaPSsgYWkHZ4gW+e7U9kGub7z3B3nI+dUI/CSyWmu3ivP8IBDJCyAHzB?=
 =?us-ascii?Q?BXSNkQBIGnqeAjhXR+PMOlzpvtz9njPJidbxTkmNtrq7IFjGQKRueEhZpZ/W?=
 =?us-ascii?Q?9+YL/YXi6XQi4SyRw7oZRXV3XxuieFgRsmOttefQ5i3PcPpCTdgF/SAFlqJR?=
 =?us-ascii?Q?uyq+hjsqYgoD7Uonpj/oOPv/d1vgnUNE/YnIIetDwgbnBp5Jpk+2wIqbDnDh?=
 =?us-ascii?Q?tsU2jA5Ri/Bv4cSv0zAIWX0ANPCICY1PHhdFOt4J7buU1kwCo9J1WSr+cJIY?=
 =?us-ascii?Q?2URMFFsjDuD5CKfYRNX5kpTcc6+XXW7bRkCo6DLmN8KGuELxO7UrcH6vfUKD?=
 =?us-ascii?Q?URcdPmHYQUzwAD7Hi7OcVTi6TwuEL/zzl2NW6+NsD61jScOeo/0LAr7cxaZW?=
 =?us-ascii?Q?3vmWwgKCyMLPUZqpMWC7zmMGLLMzbB+xA9dF7RRjdpUl3Xzr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d24396a-54fa-4799-6283-08df0e508a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 08:58:38.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hl6rb/9ZVJ2DQ++zQwj1zJYMAFKXkcFR4F4ubRVTq45tXzSV0qAgLj3FC9IYrl2Dc2+OKHi+MXTCI1usCeqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

AMD General

  Hi,

  We would like to discuss adding an interface that allows a
  virtio-gpu guest to request HDCP on the host connector associated
  with a guest display output.

  Our use case has a trusted host and a fixed one-to-one mapping between
  a virtio-gpu output and a physical host connector dedicated to that
  guest display output. An Android guest uses the standard DRM Content
  Protection and HDCP Content Type properties, while the host owns the
  physical connector and performs HDCP authentication.

  The intended flow is:

  1. The feature is negotiated at the device level, and the host reports
     for each guest display output whether it can service HDCP requests
     and which request parameters, such as HDCP Content Type, it
     supports.

  2. The guest driver exposes the corresponding DRM content-protection
     properties only on outputs for which the host can service such
     requests. Whether the currently connected sink can establish the
     requested protection is reflected in the resulting state rather
     than by dynamically adding or removing the properties.

  3. Guest userspace sets the DRM Content Protection property to DESIRED
     or UNDESIRED. DESIRED requests protection, while UNDESIRED withdraws
     the guest's request. When applicable, the HDCP Content Type property
     is included in the request.

  4. The virtio-gpu guest driver sends the request to the host.

  5. The host validates the request against its policy and either applies
     it to the corresponding physical connector or rejects it. The host
     remains responsible for access control, HDCP key handling, and
     authentication.

  6. The host reports the effective HDCP state for that guest display
     output.

  7. The guest driver reports ENABLED only after the host confirms that
     HDCP authentication has completed successfully. If protection is
     subsequently lost while the requested state remains DESIRED, the
     guest property returns from ENABLED to DESIRED.

  After hotplug or a virtio device reset, the guest would stop reporting
  ENABLED until the host reports that protection is active again.

  A request response would indicate whether the host accepted or
  rejected the request. Acceptance would not mean that HDCP
  authentication had completed successfully. The guest would therefore
  also need a way to query the effective state and to be notified when
  that state changes.

  This interface assumes a trusted host. It does not protect guest
  framebuffers from the host and does not claim to provide a complete
  protected media path. Hosts without a fixed mapping to a dedicated,
  controllable physical connector, such as normal windowed, VNC, or
  SPICE display backends, would not offer this feature.

  Before preparing a virtio specification proposal, we would appreciate
  feedback on the following questions:

  1. Is a fixed guest-output-to-dedicated-host-connector mapping an
     acceptable model for an optional virtio-gpu HDCP feature?

  2. Should the host expose per-output request support and current HDCP
     state through control commands, or is another virtio-gpu mechanism
     preferred?

  3. What is the preferred way to notify the guest when authentication
     completes or when an enabled HDCP link subsequently loses
     protection?

  4. Should the protocol expose HDCP-specific values, or generic
     content-protection request and state values which the guest driver
     maps to DRM properties?

  If this model is acceptable, we can follow up with a virtio
  specification RFC, a host implementation, and Linux virtio-gpu driver
  patches.


BRs,
Lei





