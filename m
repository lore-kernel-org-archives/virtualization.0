Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE31465A8
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300360; cv=fail; b=BCjWNnX5iZ3KygupuwGyug6adXlFCpgoE8PYOAqW5y/61RS/0gozcvGL77mjKvWNhWEhKyTqqM90KjFSUqIY3wROccMr/G9C2kLYXyhx6RDXVWf8nCfIaM1wdA3bTf+i3mBWf7KYfDC5MT+Msp6t2F+xnUkLim4I5+rwDux3iLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300360; c=relaxed/simple;
	bh=3I7A0nLcIcJMmhXfQ72KWPZIcp0+tXf69/uPDIYKgsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sGIAu7lr3OPmwNonnzKDYTwcYuAJyN6m4eabtuBKdiK1GcIUia3BkWexW8pog9cbhYEENJd8ILhhIj06ShX+vFqJWSns9SVA+47JWoezhPhbQh2hZFSWDChdIHxasbl4PrvwHK7EhLnUFqjADQjRQlMPTAkimxM0nhsG973evW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGvvuxhJ; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGvvuxhJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVw0MAA7trDX2/hDtKboniwX3pstjjiirxBsW+nJQxQQbtJTXC73Ev6zZHMF6TComkKh14v8wDGz398tXfldoPibvVrEhUBcDILCN6+7y4F1s6T1m/lxhfGZmJUKHO6fQvLeU1pcqBjgwXqzt+ctipsuHkoJwcRUWXo4UMmm6YRgX5WmMbUAn0QHXdA29YJoCZT3Wu1TIMxYm0AtysF87NFRZI2iaBsoFeLOI0NXOyk52Er5DZ4U/uec02MKwN5x8Z2kbWN1ZIWIi6CiLTY81tR6SuPPjPkliicQYto+U5MYo6LR5JTxPAiCQhVe6jPs0z1shyw72T5bWI5IdX14yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg6UEFbmeJ/7Cg0HMLXl4dT47Op71nAWu4pgNQuEOro=;
 b=OUHmJwVPhfJrX8LdqgJbLATeKy1jUmeHcr0j/e+VJxWu+wQz1sa1Thza6pQUpbRuU+15r84HG9K7OJW8tvrt261mCz19XL1AlEdrk2fwIl2n7T/NnoNd6qpHLOnFVm6KkVRz3fhtWg8N9p/5I03X3CDOM5kfDUtUaarZcM4WRKHM++Hr9uTtg2sPiak/FaClWtwVA8wWPfhz6ysW6pfaxQL0g775w0BsrsyGAnw+ZIa6qZnQtwSiJg6tb7Asa2uDiuY/o2YAsnueu2Wqu4a9KppgjjQEgrRIKGzkpcP2E3wt9V8FH3GNa1aE6I6jPQBDyFjbi53pHsIQNKHNuJEgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg6UEFbmeJ/7Cg0HMLXl4dT47Op71nAWu4pgNQuEOro=;
 b=GGvvuxhJnaQ1N4Yf8s12VKVjgBWyCSw7UTj5uSneOENIpUfcr6v0zrE7OoMEbN5682paYd9P7G/etLgahXdfEybfzAWNdbi8LK8mGlO27MWNJiPOMTz1glYNdz3bHfH0BTX2U4VgbyOMLlFyQP1JdDr7OffkkYXDNc8+nodQLIqYm4fnWD0oSN8umZdzAnfU+icYzEMPK7vmynEY42fh4ikFzpMiI4DdbTSDuOnyAJpiVtcqGq7+NKTLfadPyjD7hb2lnTG2ZIbLoduBgyjas7Wxdbcnpmu8Mz9waH9go2DNrxhsysxf0bzSZekImWHphtEoUUvnVo20ubNHemW98A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:25:55 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:25:55 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Jiri Pirko <jiri@resnulli.us>
Subject: RE: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Thread-Topic: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Thread-Index:
 AQHaxhWYDh9AqSDb90uEf0IIROIBL7HWrKsAgAAY6ICAACgKgIAAAqyAgAAPkoCAAAcGgIAAtusAgABWXwCAAAEWEA==
Date: Tue, 25 Jun 2024 07:25:55 +0000
Message-ID:
 <PH0PR12MB5481037C32CA475326A9E8BDDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
 <1719281486.8829272-20-hengqi@linux.alibaba.com>
 <20240625031633-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625031633-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4463:EE_
x-ms-office365-filtering-correlation-id: c546c77a-dc4f-437b-1557-08dc94e80d08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xs2HVYru4p4R9vjsWchPIGd4yicmi7Do+Yiy4zPsb3Z1OzomM0a4us9FpQI4?=
 =?us-ascii?Q?tltn/vfU6gjHzEBff1JG3ifwZ6WLUmYdE18Jzz756bKF8RgNiy34I9Bg/fMk?=
 =?us-ascii?Q?X/VoPpdLifGel6f0ERuBKq1YibSoVBVICjJOmm3iuUFzgdRyyOJP8PT73ycA?=
 =?us-ascii?Q?dwQ4nzGwo2Xyc4z8pXrfoBm+pLdejA9RqsWw/hfiEG8td670mDmv8YeLAOVn?=
 =?us-ascii?Q?8Mb+FCfFsvX7g7UASZzPnQ2t67uyPWTirbwhWEWSDAGszRM30WKaE+7NJuuz?=
 =?us-ascii?Q?93jPpbJS391d/ip89gxugdN1Z3s4VEeEyVTZS5EbIkVZeBr9vj0GaXoe06CO?=
 =?us-ascii?Q?Ju7meHJ0iEbr2HtRp07AIC+b7vxklWB0NiRMNX3wix8m0RVf2lDxOsBXOUIf?=
 =?us-ascii?Q?njBQYvMg90FpweMBCxjiNU1jrv0aQnV43R8Vcthn3RRrBpSgaEcVQ6YRhyM9?=
 =?us-ascii?Q?k4ozAOAfNpcyX4qM/I+AWncMCeVjlzxRrWerv92PBH0CBs7Is14NGzu10VtU?=
 =?us-ascii?Q?3wFZGQMZgnHJjHC6pWG5wlOhRYSZHTIg4JKJ6FP1is6SFu7tI5xKFpa8E9UZ?=
 =?us-ascii?Q?HuDmRwmfG64t35xQfa7ujsWm7Z68dmUe538tAJS3I25P4l80yn4X9ZLIMHEj?=
 =?us-ascii?Q?tI9kgr/yWOhCBWa7pPpPX2yy6AIQ8n6TTvRMc5FHkOirdqtm4AIYePtoQnWM?=
 =?us-ascii?Q?fH6Ked9lT1yjFfciH2daTb//v4wiia5hNDcDj4x1KLti5nP1alvUmvq/OkKI?=
 =?us-ascii?Q?+dOYhoteThqL+8qlB18icHO6c+sWw68okU5daGkAEJKJXhRWXjK7OlzPR0Gi?=
 =?us-ascii?Q?HA2HpvBpgmEUZNQc7fFOdwXkjy7ipfOhKO+WbrmZ3Hb/vxfdeGGdUxqujry3?=
 =?us-ascii?Q?STAm8fQS+1CpyvuUg7E4ciBIo/byqQgQdJmsg6zCKb+c0uh6cPoHTuUdztKG?=
 =?us-ascii?Q?Vo0g5OMbd2XJOA+pQqkH2SRWSA+Pq8AHvcCnBNnX8u1xK4asNv3YpHp5hyxJ?=
 =?us-ascii?Q?OsVXkFFLltR+mQXGz25fAmzjoghx8RDyy0MistO/ngOtrXfTvoubrbf8PMHx?=
 =?us-ascii?Q?spu6K8Wwo4zoz0WXuZIENfKWMtDWgXuVlJ8A8pKxuS6kJPPuet9faPBUmiWl?=
 =?us-ascii?Q?TezLIdSWkQoc0sGd7K3eOvVslQb5CI670Vc/GiR/gBFQrwglSTC9vwLZOqgX?=
 =?us-ascii?Q?wq1wDOY05ZwLqBAZUB3RD8Db5Pm5wxSa/SPAssp1YgKZpH8vLQ+M2Hu6AZGk?=
 =?us-ascii?Q?Ke77/X8u96fw+QqcwZOhwnFqRKhzGDZBd308yIGR9X7N5O2FCZwZpaCuBYMd?=
 =?us-ascii?Q?6bL7Y5BucWELLQ6aZGX9ettGuexnHeH86TdN2oIaaEFhTe46Hh8ZhEjIoAbK?=
 =?us-ascii?Q?VI+7HRE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9RKoXA/uhLniaNhrPhOqw1lMYYWmbx8o48jnea8KFwghABN9DVdctHnLqC/7?=
 =?us-ascii?Q?RDx4G6bi+5DBWpTdrsC3bI2GILIHoJvYFTwe6Ep1+CjUfasluU11W/j0LqVT?=
 =?us-ascii?Q?fDvTnpenQ/zm3cSn/CHGaIXGW/ie1P+AInUbR36UHkz5QaHipO7Ax7DF5Xgp?=
 =?us-ascii?Q?0CmBrc7IoMzCG9Y88LnDS4qLGSZx9C/0/rm2QPokKe4BPNQ8muXhm0Y+CaWn?=
 =?us-ascii?Q?CE0k1Sd7vTdW8ixciAoc7hGuJV8rBFw4qnXQ0FqH/w3t4AbjhEY7NoAYkd4k?=
 =?us-ascii?Q?FnrrUOSeDSCNDh6teYTAfJM3G1GKqnGcadQjGsgbzTRRhZ7DSBZL9AoxaSzC?=
 =?us-ascii?Q?I6KPYVLOAnL71SZMRTwAtKCwuxXDrvIBKxu0CiP5S1EEOvwwa+MII90EsZMh?=
 =?us-ascii?Q?mNlEkjg+UvfwtZc1GATbp+Nkfx9hQiGxUfejFCrDvgBCqo5aAaAI1xwO1o8Y?=
 =?us-ascii?Q?zrB5znp0IjTD4ztD00UnurOArPKPGC52lZqA+7PewLAETGnjJRu4ELohLWja?=
 =?us-ascii?Q?5Jte2qGRYNaPFigBJmc0TkZWwOXe+OHGogreWDBaY0r52WMUGJQ1i1DQ49ZQ?=
 =?us-ascii?Q?hKV+5MDxo3mNLgPWa6dAgy6ABOdYvmSsia1gwlrBoQvIjOW7w1zmbFT4bakZ?=
 =?us-ascii?Q?29/7b+1cu5ylnvoWRyfo4uFYv4utgG4uob6dYCKgillmgnW+PtY9wjCXU14t?=
 =?us-ascii?Q?MXBbD0/y9z3VyqOXSKuKVvAFdgaA7rD2bGavTGK5UwY0P+9IMJYem42JaVj6?=
 =?us-ascii?Q?q9qGFy4JTRNW5oNFV+q4EU2scD1Wp7wkv9Qgyvha4CmpxXvkP1ZozInZPIm5?=
 =?us-ascii?Q?FBmJj3Dl4qyPadz1HYiFkHJt1et/SePCW+zP9m86xtQPXqON4pB4uniWJdN+?=
 =?us-ascii?Q?YFCq85vQNDOWrjGTVEsgzSlHVpPcX7FPUdWnEVsfYWbEaj5fjQ/P3CTUmN4S?=
 =?us-ascii?Q?PD4t1vnHBRjCn4UC41hzxjy6c2O/9B8SJaArt2RhS/6UcA3wnu6wpJiytNXD?=
 =?us-ascii?Q?uPCK+Ao38rcZu81K0kly4blJVJqn3CLDOiMi94hdjlRqPQCAGK7gPI1Tk0Fv?=
 =?us-ascii?Q?KjtFMXpzaTkLcE9x/h60JtQcIHxXdnV8qer4yxjp2FOH1Trq/0PbzLQCo4Wu?=
 =?us-ascii?Q?MKEbq4+55YLczLHMgU3orvq6G1Q0MLxQzAEf9HTTD9FUs2YRnIMeXBoh1u9c?=
 =?us-ascii?Q?tTGgyHIL8sfv5OeQxqVQCzqpB087m9pT1ijkngwdfMnmK8LG1aNvTnBfgIO7?=
 =?us-ascii?Q?ZnRNJK5PPm8ZbVC6afvjf4APIIfPvB0wGokOF5m83+0K3WHNEV7/7y8/F+K9?=
 =?us-ascii?Q?BGVUSdYB2DJ4TQZhX+/Txwpdfgcd7Oas6F5e9ZEDOWEUuQN4f5UfRLpE+yDj?=
 =?us-ascii?Q?kgewqA/zI0hhI7ST87ZMxrj2csYTe8ckgzlwpDvFUsuG4EKEWlcCloAWACcl?=
 =?us-ascii?Q?bhFh49Z3ZEZy9ZSs+Q9IrTpwuVfpRe6eW75QadMkEQBQ4Kyl+CbpT5LDrdOn?=
 =?us-ascii?Q?K/bdQDC7XlSunxb9GwvsiHnv7vttF4AP0ZBY8zSsMrj+VK/o9ELuALZuR5FO?=
 =?us-ascii?Q?bV0IQbpYHc/MdMeDJA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c546c77a-dc4f-437b-1557-08dc94e80d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 07:25:55.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NENc5R/fXmurfqI+RjxIdZVciV5lzCor6wgF5iTRhCUDbW1E8rBUPmREQIdCFBbJMayT/9aK+ASXEWAMhuySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, June 25, 2024 12:51 PM
>=20
> On Tue, Jun 25, 2024 at 10:11:26AM +0800, Heng Qi wrote:
> > On Mon, 24 Jun 2024 11:16:45 -0400, "Michael S. Tsirkin"
> <mst@redhat.com> wrote:
> > > On Mon, Jun 24, 2024 at 04:51:37PM +0200, Jiri Pirko wrote:
> > > > Mon, Jun 24, 2024 at 03:55:53PM CEST, mst@redhat.com wrote:
> > > > >On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
> > > > >> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
> > > > >> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
> > > > >> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli=
.us>
> wrote:
> > > > >> >> > From: Jiri Pirko <jiri@nvidia.com>
> > > > >> >> >
> > > > >> >> > Currently the admin queue command execution is serialized b=
y a
> lock.
> > > > >> >> > This patchsets lifts this limitation allowing to execute
> > > > >> >> > admin queue commands in parallel. To do that, admin queue
> > > > >> >> > processing needs to be converted from polling to interrupt =
based
> completion.
> > > > >> >> >
> > > > >> >> > Patches #1-#6 are preparations, making things a bit smoothe=
r as
> well.
> > > > >> >> > Patch #7 implements interrupt based completion for admin
> queue.
> > > > >> >>
> > > > >> >> Hi, Jiri
> > > > >> >>
> > > > >> >> Before this set, I pushed the cvq irq set [1], and the
> > > > >> >> discussion focused on the fact that the newly added irq
> > > > >> >> vector may cause the IO queue to fall back to shared interrup=
t
> mode.
> > > > >> >> But it is true that devices implemented according to the
> > > > >> >> specification should not encounter this problem. So what do y=
ou
> think?
> > > > >>
> > > > >> Wait. Please note that admin queue is only created and used by
> > > > >> PF virtio device. And most probably, this is on hypervisor
> > > > >> managing the VFs that are passed to guest VMs. These VFs does no=
t
> have admin queue.
> > > > >>
> > > > >> Therefore, this is hardly comparable to control vq.
> > > > >
> > > > >
> > > > >Well Parav recently posted patches adding admin queue to VFs,
> > > > >with new "self" group type.
> > > >
> > > > Right, but even so, when device implementation decides to
> > > > implement and enable admin queue, it should also make sure to
> > > > provide correct amount of vectors. My point is, there should not
> > > > be any breakage in user expectation, or am I missing something?
> > >
> > >
> > > Hmm, I think you are right that cvq is an existing capability and
> > > adminq is newer.
> >
> > admin vq has been supported in the kernel for more than half a year,
> > and if at this point you think that the device must provide interrupt
> > vectors for it, then I think this is also true for cvq.
>=20
> There's a big difference between 15 years and half a year.  I don't think=
 any
> hardware devices have been released with the capability just yet, and yes
> allocating a vector for each queue is a good idea for hardware devices.

We have released the hw with admin capability set.
And device not supporting the irq for AQ is just inefficient device.
So it should be treated as device bug to be fixed by device fw upgrade per =
say.
I agree with Michael's point.
