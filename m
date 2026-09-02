Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8349EC62;
	Wed,  2 Sep 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354749; cv=none; b=rHrwvxzfN+s20qfWsJwFgSpwVVqQoYoyaD06hrX4EfyKQpY5p1Pxkq0cnHLICEi9Er/PFdU4Pqcl9gX9jYefeZPSLRqSAMj6qn4d2L9BNvZtoMza1GKuzfsDjt8MRgZeUupz+Ld8cI95neVnxcuj408UbyBBynHO6B9M2PiORtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354749; c=relaxed/simple;
	bh=h2Em5/uEAvqazITAjCVRj5IpwJ3AbGTPvTq34a3ySZA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cORBX/GDRnTo5hcbyUhDr2JEtdrvlSpAtw/CGMUWRCvJvhD9KZlnh3LsRz6s98r1rRpnpPd+/b4tb/+PFiga1hMGSbrODm+JM9O+VrybIHPuszNzMHVsR72aNylKVwVca+fWNskviw3HKyZYgCPJDdQFcJCwAk12RQBnyiTw1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB7XjeiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB7XjeiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FD91F00A3A;
	Wed,  2 Sep 2026 13:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354747;
	bh=bGrvsXG71KFaBMjUFkvAomtFOERcApzP2IOuDQpfaUo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RB7XjeiJ5gNi3SC5LqhrKo9CdQmLlSTdMr/JV08u2A7KLQCrjxplcX/i4wZ6eqvER
	 LoH2L5ShS4gnEUyJZAujYeBZIjWM5ET1RhMVEoneBr59Vy4Y+KEX8V2WDXickqpQSn
	 lgy7fx5/wGKFW8mRRtrC3KlNbQtRZtBgRc6qrESRSf7unIqmFDYcb+cFKcyyS1rRAL
	 ussyRe3gMy1NRVNup+n1GIWaKy3vrygIaWQ5lpBSfyDo9fEu0VWLzWWdmkt5amqle6
	 SyiSvXbfZJPQR/u4Pyib/CwvSuM4TMYgEtTB6LZsAA82ed7OS7mFEvx0kTCbLhUx71
	 hX3aStxwMEzMg==
Subject:
 Re: [net-next,v23,09/14] virtio_net: Implement layer 2 ethtool flow rules
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:25 +0000
Message-ID: <178835474594.3394541.2565255737222929894@kernel.org>
In-Reply-To: <20260831161109.2999926-10-shshitrit@nvidia.com>
References: <20260831161109.2999926-10-shshitrit@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 6 · Low: 2

- [Medium] Installed flow-filter rules are never revalidated when the
  number of active receive virtqueue pairs shrinks.
- [Medium] Rule precedence does not follow the ethtool uAPI contract.
- [Medium] virtio_net_ff_cap_data::rules_per_group_limit ("maximum number
  of rules allowed in a single group") is validated as non-zero in…
- [Medium] All user-installed ethtool flow rules are silently destroyed
  and never restored across a freeze/restore (suspend/resume) cycle.
- [Medium] Failed object-destroy admin commands are treated as success,
  leaving the device with state the driver no longer tracks.
- [Medium] New teardown paths convert device-supplied error codes into
  kernel WARN splats.
- [Low] DISCARDED AS FALSE POSITIVE (retained for policy reasons):
  'virtnet_ethtool_ops adds .set_rxnfc but no .get_rxnfc, so rules…
- [Low] validate_flow_input() returns -EOPNOTSUPP for every fs->location
  other than RX_CLS_LOC_ANY, including unrecognised RX_CLS_LOC_SPECIAL…

--

virtio_net: Implement layer 2 ethtool flow rules

This adds ethtool ntuple rule insertion and removal for ETHER_FLOW by
creating VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER and
VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative objects, tracked in two
xarrays hanging off struct virtnet_ff.  A few questions below.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 294cfd70662d3..6217c5bcfee9f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5742,6 +5722,445 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>  	.get_base_stats		= virtnet_get_base_stats,
>  };
>  

[ ... ]

> +static void destroy_classifier(struct virtnet_ff *ff,
> +			       u32 classifier_id)
> +{
> +	struct virtnet_classifier *c;
> +	int err;
> +
> +	c = xa_load(&ff->classifiers, classifier_id);
> +	if (c) {
> +		err = virtio_admin_obj_destroy(ff->vdev,
> +					       VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
> +					       c->id,
> +					       VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +					       0);
> +		WARN_ON_ONCE(err);

[Severity: Medium]
Is WARN_ON_ONCE() the right reaction to an error that the device chooses?
virtio_admin_obj_destroy() returns whatever vdev->config->admin_cmd_exec()
returns, so a non-zero command status from the device (or -EOPNOTSUPP, or
the -ENOMEM from its own kzalloc) lands directly in this WARN_ON_ONCE().
The same value is turned into a WARN in virtnet_ff_cleanup():

	xa_for_each(&ff->ethtool.rules, i, eth_rule)
		WARN_ON_ONCE(destroy_ethtool_rule(ff, eth_rule));

A device that accepts OBJ_CREATE and then fails OBJ_DESTROY therefore
produces a splat on plain teardown or suspend, and with panic_on_warn=1 that
is a guest panic.  Would a rate-limited netdev_warn() be more appropriate
for device-reported errors here?

> +
> +		xa_erase(&ff->classifiers, c->id);
> +		kfree(c);
> +	}
> +}
> +
> +static int destroy_ethtool_rule(struct virtnet_ff *ff,
> +				struct virtnet_ethtool_rule *eth_rule)
> +{
> +	int err;
> +
> +	ff->ethtool.num_rules--;
> +
> +	err = virtio_admin_obj_destroy(ff->vdev,
> +				       VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
> +				       eth_rule->flow_spec.location,
> +				       VIRTIO_ADMIN_GROUP_TYPE_SELF,
> +				       0);
> +
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +	destroy_classifier(ff, eth_rule->classifier_id);
> +	kfree(eth_rule);
> +
> +	return err;
> +}

[Severity: Medium]
Can the driver and the device diverge here when the destroy fails?  err is
saved but the xa_erase(), destroy_classifier() and kfree(eth_rule) run
unconditionally, so on failure:

  - the device keeps an armed FF_RULE that the driver can no longer list or
    delete, and virtnet_ff_cleanup() will not retry it because the xarray
    entry is gone
  - destroy_classifier() then tears down the classifier that the still-live
    rule references
  - the location id and the classifier id go back to their xa_alloc
    allocators, so a later ethtool -U can pick an id the device still has
    allocated and the following OBJ_CREATE collides with the stale object

virtnet_ethtool_flow_remove() returns that err to userspace after the record
is already gone, so the user sees a failure but has nothing left to retry
against.

Note this does not need a malicious device: virtio_admin_obj_destroy() can
fail before the command is sent, since its own kzalloc() can return -ENOMEM.

Would it be better to keep the rule record and its classifier when the
device refuses the destroy?  The same applies to the rollback in
build_and_insert(), which uses destroy_classifier() and so cannot tell that
the classifier is still allocated in the device.

> +
> +static int insert_rule(struct virtnet_ff *ff,
> +		       struct virtnet_ethtool_rule *eth_rule,
> +		       u32 classifier_id,
> +		       const u8 *key,
> +		       u8 key_size)
> +{
> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
> +	int err;
> +
> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
> +	if (!ff_rule)
> +		return -ENOMEM;
> +
> +	/* Intentionally leave the priority as 0. All rules have the same
> +	 * priority.
> +	 */

[Severity: Medium]
With every rule created at the same device priority, what decides which of
two overlapping rules wins?  include/uapi/linux/ethtool.h documents
struct ethtool_rx_flow_spec::location as ordering-significant:

 * @location: Location of rule in the table.  Locations must be
 *	numbered such that a flow matching multiple rules will be
 *	classified according to the first (lowest numbered) rule.

Since rule_priority stays 0 for all rules, and last_rule_priority from
struct virtio_net_ff_cap_data is never referenced in the driver, two
overlapping rules resolve in a device-defined order rather than in location
order.  For ETHER_FLOW alone one rule masking h_dest and another masking
h_source already match the same frame.  Should the location ordering be
mapped onto rule_priority, or should the documented ordering guarantee be
called out as unsupported?

> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
> +	ff_rule->key_length = key_size;
> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
> +					     VIRTIO_NET_FF_ACTION_DROP :
> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
> +					       cpu_to_le16(rxq2vq(fs->ring_cookie)) : 0;
> +	memcpy(&ff_rule->keys, key, key_size);
> +

[ ... ]

> +static int validate_flow_input(struct virtnet_ff *ff,
> +			       const struct ethtool_rx_flow_spec *fs,
> +			       u16 curr_queue_pairs)
> +{
> +	u8 required_action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
> +			     VIRTIO_NET_FF_ACTION_DROP :
> +			     VIRTIO_NET_FF_ACTION_RX_VQ;
> +	int i;
> +
> +	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
> +	if (fs->location != RX_CLS_LOC_ANY)
> +		return -EOPNOTSUPP;

[Severity: Low]
Should an unrecognised RX_CLS_LOC_SPECIAL value return -EINVAL rather than
-EOPNOTSUPP?  The struct ethtool_rxnfc documentation in
include/uapi/linux/ethtool.h says:

 * defined in future and drivers must return -%EINVAL for any
 * unrecognised value.

This blanket check returns -EOPNOTSUPP for every location other than
RX_CLS_LOC_ANY, including those unrecognised special values.

> +
> +	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
> +	    fs->ring_cookie >= curr_queue_pairs)
> +		return -EINVAL;

[Severity: Medium]
This is the only bound on the target queue, and insert_rule() then commits
an absolute receive virtqueue index into the device object:

	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
					       cpu_to_le16(rxq2vq(fs->ring_cookie)) : 0;

What happens to that rule when curr_queue_pairs later shrinks?  The
ethtool -L path is covered once .get_rxnfc exists later in the series, since
ethtool_check_max_channel() then refuses reductions below the highest in-use
ring, but virtnet_xdp_set() lowers the count without any such check:

virtnet_xdp_set()
	curr_qp = vi->curr_queue_pairs - vi->xdp_queue_pairs;
	...
	err = virtnet_set_queues(vi, curr_qp + xdp_qp);

So a rule inserted while an XDP program is attached, with ring_cookie in
[curr_qp, curr_qp + xdp_qp), survives program detach and then names a
receiveq the driver has just told the device to stop using via
VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.  Does matched traffic get silently dropped
while the rule is still listed as valid?

> +
> +	for (i = 0; i < ff->ff_actions->count; i++)
> +		if (ff->ff_actions->actions[i] == required_action)
> +			goto action_ok;
> +	return -EOPNOTSUPP;
> +

[ ... ]

> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
> +	if (err)
> +		return err;
> +
> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
> +	if (!eth_rule)
> +		return -ENOMEM;
> +
> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
> +		       GFP_KERNEL);

[Severity: Medium]
Where is rules_per_group_limit enforced?  Every ethtool rule is created in
the single ethtool group:

	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);

but the id allocation here is bounded only by rules_limit.  On a device that
reports rules_per_group_limit smaller than rules_limit, repeated ethtool -U
insertions keep allocating locations and issuing OBJ_CREATE past the
per-group limit, and the failure then comes back from the device as an opaque
error instead of -ENOSPC.

Later in the series this also contradicts what the driver advertises, since
virtnet_ethtool_get_flow_count() reports the table size as
min(rules_limit, rules_per_group_limit) | RX_CLS_LOC_SPECIAL while this path
can still hand out higher locations.

> +	if (err)
> +		goto err_rule;
> +
> +	eth_rule->flow_spec = *fs;
> +

[ ... ]

> @@ -5944,11 +6409,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  
>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  {
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i;
>  	int err;
>  
>  	if (!ff->ff_supported)
>  		return;
>  
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
> +		WARN_ON_ONCE(destroy_ethtool_rule(ff, eth_rule));
> +
> +	xa_destroy(&ff->ethtool.rules);
> +	xa_destroy(&ff->classifiers);

[Severity: Medium]
Are the installed rules meant to survive a freeze/restore cycle?  This
teardown is reached from the suspend path:

virtnet_freeze_down()
	rtnl_lock();
	virtnet_ff_cleanup(&vi->ff);
	rtnl_unlock();

and destroy_ethtool_rule() kfree()s the only software copy of each
flow_spec, after which both xarrays are destroyed.  On the way back up the
only flow filter work is:

virtnet_restore_up()
	err = virtnet_ff_init(&vi->ff, vi->vdev);

which ends in xa_init_flags() on two empty xarrays, with nothing replaying
the classifier and rule creates.

After resume, does userspace keep believing rules exist that the device no
longer enforces?  A rule with RX_CLS_FLOW_DISC would start delivering
traffic again, and ETHTOOL_SRXCLSRLDEL for a previously reported location
takes the !eth_rule path in virtnet_ethtool_flow_remove() and returns
-ENOENT.  Before this patch only the group object was recreated, so no
user-visible configuration was lost.

> +
>  	err = virtio_admin_obj_destroy(ff->vdev,
>  				       VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>  				       VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
