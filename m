Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC01482E7
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729082; cv=none; b=ls3UpZJki4nvIFSapnTh7D24bFT+PiXPrhQuKaWhuO2KdfEvahvpzg/gGZ7e2G3tagdXIqptO3NxF6TQEYtbNNaONKyT6WgOt2n5UTlVRY3SesUHraWRUf1st2SMPsPTFPP98dmcJ6KxgKw2m+MEPFrj2iIsvwFpSrSRruJ6RK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729082; c=relaxed/simple;
	bh=Mohe1Dd/6K/3BFtg31FKaPqkoKf9+WZow/yu2pkvYRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbev93X/yaS0GHgSk4oVvQslzPu/ntpObQCv+nOebuf3zExlFS/ww1ighk2urZnp37KLEJ8QIdVdTBZiYRkjvgmO/2c0jJjqVMKKs6Uek2BcoteVARdwh8fhVPAwBFokzW6XWNwNgnscHXUvmrCZQJmtuwy0/50kfQE6paFzx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o72Yoy/F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o72Yoy/F"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SEcbrw010002;
	Mon, 28 Jul 2025 18:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BYKGvt
	/wY03UWVRFHCr40IUjUOGGIRtSYBWOceikVYQ=; b=o72Yoy/FQhpfTC9WrAkQMb
	MFPppv9xpua9HXJmbL0nZ3aiw1hra0WqmDOn1FWydf/G6I9eruJBTZVuF+eIWejc
	7N1YgxZK+/IuT0L7gXSB6nI7SzUQcb/Sh6GeoanwVxoTmQd0yeogfve3okYDfDyO
	uF8SGaQLD+CXwseqYVg9/GcdogMOAsZFLcFWuDeaRcHXl4mWmfik1bnZx6DBYTnI
	NsdsJ/p+YQafI0NLKk2mh1YL7Sz+n5GZPw60p8HIefWL2ZfQiZQZO1sOk9gaiiCR
	mBx3O/UmwTzY16rORFCswXZM9C7gPPLxlX3hCbvoreUe7T7iEqmmHhX6az84goxQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcftr8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 18:57:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56SIvvpo029181;
	Mon, 28 Jul 2025 18:57:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcftr87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 18:57:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFvPOk028748;
	Mon, 28 Jul 2025 18:57:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c22ergb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 18:57:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56SIvtjB52822430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 18:57:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D15BC5805D;
	Mon, 28 Jul 2025 18:57:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D7BD58057;
	Mon, 28 Jul 2025 18:57:55 +0000 (GMT)
Received: from [9.61.245.133] (unknown [9.61.245.133])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Jul 2025 18:57:55 +0000 (GMT)
Message-ID: <7ac8d054-c08b-4b8d-9875-4c0b1e41913c@linux.ibm.com>
Date: Mon, 28 Jul 2025 13:57:55 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux.dev,
        qemu-stable@nongnu.org, Lei Yang <leiyang@redhat.com>
References: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEzOCBTYWx0ZWRfX7qhnSK8Ep3m8
 bXWtK7B1nC/kCqrz5SKQNEm9nNVZGb4GrdnT3xYIPEapf6h8DakeTmOkgYlbTPhGCsT1cbaWrRp
 rLYpB0O1PVRG9MTnp4w8JOycxKeGb5utfj6PWZBjBt8JZ7gHboGn+l4Rtjo+vO+i5YwW78eBn7B
 tiDukCHQtHHjHSJIeFG3eodkXIhzwdzTRzk5WVuBNHFGkbj3dQu+L8T6XH4JCfXuPQpSTXAfCKs
 4FJ3NSA2obf/NVr5i3zzlLJySh5hpN2alAn7otFD55wPUW2SQ3SoTMC3vulkdsVpIPE3WS6wmrd
 Z2PjFc0HsGlKaPcnltlQzT5KgL0a3VzzqdrUmAWnFQsMH+Rbo4jBUvACvJVjEXfca0fvAIeHLwW
 rzNhWQIkYM7YHyCzWNT+FhOsU0lF37V9LdABAKMsXYQAZ4pipKnmXwMqi6w0yotZxIQMh3eh
X-Proofpoint-ORIG-GUID: uaaTTsnsUNJNjndRu-8IOloHGIldfycu
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=6887c835 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=nCStMBF-d0Rx8aKyhB8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Ux0M8V0TLIwNBsN8Dr9IaXFksxp1lNFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280138

On 27-Jul-25 01:22, Akihiko Odaki wrote:
> Problem
> -------
> 
> The expected initial state of the table depends on feature negotiation:
> 
> With VIRTIO_NET_F_CTRL_VLAN:
>    The table must be empty in accordance with the specification.
> Without VIRTIO_NET_F_CTRL_VLAN:
>    The table must be filled to permit all VLAN traffic.
> 
> Prior to commit 06b636a1e2ad ("virtio-net: do not reset vlan filtering
> at set_features"), virtio_net_set_features() always reset the VLAN
> table. That commit changed the behavior to skip table reset when
> VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
> properly cleared during device reset and remain stable.
> 
> However, this assumption breaks when a driver renegotiates features:
> 1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
> 2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)
> 
> The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
> set_features during reset"), which triggered virtio_net_set_features()
> during device reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN
> was negotiated after a device reset.
> 
> Solution
> --------
> 
> Fix the issue by initializing the table when virtio_net_set_features()
> is called to change the VIRTIO_NET_F_CTRL_VLAN bit of
> vdev->guest_features.
> 
> This approach ensures the correct table state regardless of feature
> negotiation sequence by performing initialization in
> virtio_net_set_features() as QEMU did prior to commit 06b636a1e2ad
> ("virtio-net: do not reset vlan filtering at set_features").
> 
> This change still preserves the goal of the commit, which was to avoid
> resetting the table during migration, by checking whether the
> VIRTIO_NET_F_CTRL_VLAN bit of vdev->guest_features is being changed;
> vdev->guest_features is set before virtio_net_set_features() gets called
> during migration.
> 
> It also avoids resetting the table when the driver sets a feature
> bitmask with no change for the VIRTIO_NET_F_CTRL_VLAN bit, which makes
> the operation idempotent and its semantics cleaner.
> 
> Additionally, this change ensures the table is initialized after
> feature negotiation and before the DRIVER_OK status bit being set for
> compatibility with the Linux driver before commit 50c0ada627f5
> ("virtio-net: fix race between ndo_open() and virtio_device_ready()"),
> which did not ensure to set the DRIVER_OK status bit before modifying
> the table.
> 
> Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
> Cc: qemu-stable@nongnu.org
> Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
> Not tested.
> 
> Konstantin, I would also want you to test this new version. Please also
> give it Tested-by, and, if possible, Reviewed-by.
> ---
> Changes in v3:
> - Dropped RFC.
> - Rebased.
> - Link to v2: https://lore.kernel.org/qemu-devel/20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp
> 
> Changes in v2:
> - Addressed a concern with old drivers that do not properly set
>    DRIVER_OK (pointed out by Michael S. Tsirkin).
> - Noted that this change does not simply revert commit 06b636a1e2ad
>    ("virtio-net: do not reset vlan filtering at set_features") but
>    preserves its goal.
> - Added Cc: qemu-stable@nongnu.org.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp
> ---
>   hw/net/virtio-net.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index c4c49b0f9caa1e8f26fa2e03acc8786936877eba..6b5b5dace334af12e9b77a8a2765c88443cee235 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -929,8 +929,9 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>           vhost_net_save_acked_features(nc->peer);
>       }
>   
> -    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> -        memset(n->vlans, 0xff, MAX_VLAN >> 3);
> +    if (virtio_has_feature(vdev->guest_features ^ features, VIRTIO_NET_F_CTRL_VLAN)) {
> +        bool vlan = virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN);
> +        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
>       }
>   
>       if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
> @@ -3942,6 +3943,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>       n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
>   
>       n->vlans = g_malloc0(MAX_VLAN >> 3);
> +    memset(n->vlans, 0xff, MAX_VLAN >> 3);
>   
>       nc = qemu_get_queue(n->nic);
>       nc->rxfilter_notify_enabled = 1;
> @@ -4041,7 +4043,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
>       memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
>       memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
>       qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> -    memset(n->vlans, 0, MAX_VLAN >> 3);
>   
>       /* Flush any async TX */
>       for (i = 0;  i < n->max_queue_pairs; i++) {
> 
> ---
> base-commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb
> change-id: 20250713-vlan-8c107a65ad91
> 
> Best regards,

It works on s390.
Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

(I can't give a reliable Reviewed-By as I lack good understanding of 
this code, but the change makes sense to me.)

