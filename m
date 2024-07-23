Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3349634
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760323; cv=none; b=GL2Qhn6PD6RTN2QFfxkSl3oXRsFB+LcIkjV60Y5S8weN5LTVe9vhcPbTIm0fkc1hLdpv9OZKaaIVhG3Venp4Q7YcXFWsn3JRXUlZjjcrrzpcNZtoFDaCnoGxz9bVlSCxo4HzyZSFgKEgrB6bCJ72dThWJszllhaTndujT24ghVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760323; c=relaxed/simple;
	bh=jnOBruHviiMeh3pNnPGssWCltycJrT40IYLXoFFlhlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwhkEqvS/H52uCrflaltRaQucEmf8Rg3AvKquZypawgpKOtIlzoAqX/fn1Hj6w3SwnR0zf39dyx1qS+zlNmaqGcUdI1ro9oVK+4phU8oI65jrdajospTatDJaEfmfAMK14HuE9QkUVLCZ1ONmeUuczhrRsyArhPcilZqP8OVQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wbolrxaj; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wbolrxaj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61B3B401FD
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 18:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lG5P6mIRgJcC for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 18:45:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 41AA8401D8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41AA8401D8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wbolrxaj
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41AA8401D8
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=olTVMxjXOsU8mUVMWV8+A1UMYa9QIDnG8q/CEGjAZw8=; b=Wbolrxaj2GFm7onLCwu2ynt2th
	1wAHNlOmz85RQQApeumtJ9mX3dQt11FeraN0x9Tbw65kVFBcdrE/Uau24+4krpDw4+oHmfpnlETyd
	8dDUTj7RLzdqmApTsOenP+GZ4mkTiTidGt7Ltj6bQyq2u85YOrFsk32FefV81ZEFzPP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWKVd-0035J8-6w; Tue, 23 Jul 2024 20:45:13 +0200
Date: Tue, 23 Jul 2024 20:45:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v5 0/3] vdpa: support set mac address from vdpa tool
Message-ID: <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
References: <20240723054047.1059994-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723054047.1059994-1-lulu@redhat.com>

On Tue, Jul 23, 2024 at 01:39:19PM +0800, Cindy Lu wrote:
> Add support for setting the MAC address using the VDPA tool.
> This feature will allow setting the MAC address using the VDPA tool.
> For example, in vdpa_sim_net, the implementation sets the MAC address
> to the config space. However, for other drivers, they can implement their
> own function, not limited to the config space.
> 
> Changelog v2
>  - Changed the function name to prevent misunderstanding
>  - Added check for blk device
>  - Addressed the comments
> Changelog v3
>  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
>  - Add a lock for the network device's dev_set_attr operation
>  - Address the comments
> Changelog v4
>  - Address the comments
>  - Add a lock for the vdap_sim?_net device's dev_set_attr operation
> Changelog v5
>  - Address the comments

This history is to help reviewers of previous versions know if there
comments have been addressed. Just saying 'Address the comments' is
not useful. Please give a one line summary of each of the comment
which has been addressed, maybe including how it was addressed.

      Andrew

