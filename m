Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AB49F13E;
	Wed,  2 Sep 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354754; cv=none; b=ocobnPIBxG9jyOUq2RFLaZ31jeRD41QW8Ip9CSyz9WwfPAmIsxZhZLJTvnnHWUBamk44MMfA5YmI6aHioaPlhtUTYKksnoLlEBECqq7DWU79G3S8eUFIdcdSqn3mGLSNVQqrZ529KatxtI4JvHtyu7B26MJVWSRrU//QCFwQbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354754; c=relaxed/simple;
	bh=qEVtuTGkqMRiC3Sh9Gf/iKkxkp0xy1di4hFSx4L5F0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NPLfPQO1Rls1mrIhdvh9pKP6cBYZhJN9O90b+82v4+fDAUKI0MeylI5bPNthz0uDylHGPmKV2XB+qyrQPqM8dqDjgLt3+0+iS0FGmJWOKtZRbxMFX3vpgAfwuCJYaSuDmgUlEyRasm9cco3+8GrEf7MpdX8cMk76gcIdb8hw334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqX9mFN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqX9mFN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234011F000E9;
	Wed,  2 Sep 2026 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354752;
	bh=vj6v6mFAUT1Tp4CnHcN5FDUpYOKvsv3FsnRiWJGMGqs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HqX9mFN2K7v4yZHufhWXMeyWuyc37lQ8DprYTu3JLAy+B9eCcT4wxhwuTvDJyKftN
	 TX8Q94uDjTAhZupLLLq273iYBlqWv+TAM4x9H0n6JHkUXBl3RzOPRd1igjNtbCDtRU
	 eZFYw6EcoP5NMZIUuC4VL1cXB4HvszTfP9D25ybNs10gz6Kpz4SDcSntiAeNIuirze
	 aUhOj2lErkG8DQSucFPiXLrBk5SjnkEEM2x6Rg8MtKrykaHpU0WHYydjsfKFPOqd5z
	 SzjEwxtDlrkyLH495rIp6XjCNPr6IVMcC/m9HETloz9gcoNHG8kOMh8jxlxciGwh6h
	 2wYo9j9nL8dNQ==
Subject: Re: [net-next,v23,14/14] virtio_net: Add get ethtool flow rules ops
From: netdev-bot+sashiko@kernel.org
To: shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
Date: Wed, 02 Sep 2026 13:12:31 +0000
Message-ID: <178835475172.3394541.12012371134538467117@kernel.org>
In-Reply-To: <20260831161109.2999926-15-shshitrit@nvidia.com>
References: <20260831161109.2999926-15-shshitrit@nvidia.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The two new getters report the UAPI-documented "size of the
  rule table" (struct ethtool_rxnfc::data) with two contradictory values.

--

virtio_net: Add get ethtool flow rules ops

This adds a get_rxnfc ethtool op to virtio_net handling
ETHTOOL_GRXCLSRLCNT, ETHTOOL_GRXCLSRULE and ETHTOOL_GRXCLSRLALL, so
userspace can query the rule count, a single rule, and the list of rule
locations.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a1e042f356f5e..911a5142605bd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6575,6 +6575,60 @@ static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
>  	return err;
>  }
>  
> +static int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
> +					  struct ethtool_rxnfc *info)
> +{
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	info->rule_cnt = ff->ethtool.num_rules;
> +	info->data = min(le32_to_cpu(ff->ff_caps->rules_limit),
> +			 le32_to_cpu(ff->ff_caps->rules_per_group_limit)) |
> +		     RX_CLS_LOC_SPECIAL;
> +
> +	return 0;
> +}
> +

[ ... ]

> +static int
> +virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
> +			      struct ethtool_rxnfc *info, u32 *rule_locs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	unsigned long i = 0;
> +	int idx = 0;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	xa_for_each(&ff->ethtool.rules, i, eth_rule) {
> +		if (idx == info->rule_cnt)
> +			return -EMSGSIZE;
> +		rule_locs[idx++] = i;
> +	}
> +
> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit);

[Severity: Medium]
Should these two handlers report the same value in info->data?

include/uapi/linux/ethtool.h documents the field the same way for both
commands:

 * For %ETHTOOL_GRXCLSRLCNT, ... If @data is non-zero on return then it is the
 * size of the rule table, plus the flag %RX_CLS_LOC_SPECIAL ...
 * For %ETHTOOL_GRXCLSRLALL, ... On return, @data is the size of the rule table

virtnet_ethtool_get_flow_count() reports:

	info->data = min(le32_to_cpu(ff->ff_caps->rules_limit),
			 le32_to_cpu(ff->ff_caps->rules_per_group_limit)) |
		     RX_CLS_LOC_SPECIAL;

while virtnet_ethtool_get_all_flows() reports the unclamped
ff_caps->rules_limit.  On a device that advertises
rules_per_group_limit < rules_limit these two answers differ for the same
table.

Since every ethtool rule goes into one group (VIRTNET_FF_MAX_GROUPS is 1
and insert_rule() hardcodes the group), isn't the usable capacity
min(rules_limit, rules_per_group_limit)?

	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);

If so, does ETHTOOL_GRXCLSRLALL overstate the table size here, so that
inserts past rules_per_group_limit get refused by the device?

There is a related question about the location space itself.
virtnet_ethtool_flow_insert() allocates locations from the unclamped
limit:

	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
		       GFP_KERNEL);

so locations handed back in fs.location, and then reported in
rule_locs[] by virtnet_ethtool_get_all_flows(), can exceed the table size
now advertised by ETHTOOL_GRXCLSRLCNT.  Should all three sites use the
same limit?

> +	info->rule_cnt = idx;
> +
> +	return 0;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831161109.2999926-1-shshitrit%40nvidia.com
