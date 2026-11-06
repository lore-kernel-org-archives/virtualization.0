Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973527;
	b=RqZnn6YYc3p0Xz0V3JlYVBTjYBEJCMRMUD+vN9a1TkOYlcsJf06V+OMw5wZ5iKS0Nv1H
	 IvSe6YOAPbDRJxRXj8LJOGtnQ5eVzdnwgURCIP77nysZ9twxdowXQ60+PgyR0fZwVijto
	 EiMF4y8n1uxzvW9RnMhIrY6D9plYeO7bnMfj9fVSIfP9jN/c+x3GB35NL/6mu/XgxrhWG
	 wdPHpZx9LQonKrKj22Mcjn8+KX0GBzvD51FmIHl6mR4JZwiRG+azU0I9NGRINPmpb7q2v
	 L8PlotMpU5kp03vyQckpIHBpBX4Lun5OqEF9mqAR2xCGnxXbVJt0R9u79OZ4ngOkEPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973527;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=ItHvNO33pb8zb9UZ+LEb6x6bQbeF4DIAGvYYNsI45U8=;
	b=3S2jh5vL0ALvz/OnqIqM/Mau898FQfif4G+o2eTKKgseMxpvJwD8RNsOSwe+B5nmG1gj
	 K1BVC3ttSYOO+2B1qX3n6ZSLo+qIxb+7TBr0Ieg/9s2LXRNuA4IUfNgbHREWXdshivvST
	 5USYeXe9pOZToqLhQrv1/dcyw9c5y79SIFa9sCtDKtwy67/uaNdzdzMtYAwdxy+eLQ1/J
	 E7zclzw+UfesxYiI8dwgV7GU3arKM+DjGmXDz0Ugr1WW5Ee5TCJF03dRklO+KjwjbrKfM
	 MrfTe0KrDwxKjwBLP/lngHIavl8zLC2aD3ScA3pKlbx9YfPvAovGVRdlc86C+d+HWxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=uiFsa2Bw;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6UCJswdK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LgjfvuMA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=X0ai5JyZ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E3606A32C
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 13:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8E3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=uiFsa2Bw;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6UCJswdK;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LgjfvuMA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=X0ai5JyZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F315122154;
	Fri,  6 Nov 2026 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793973524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItHvNO33pb8zb9UZ+LEb6x6bQbeF4DIAGvYYNsI45U8=;
	b=uiFsa2BwcYOxq2gi53CMvsQcPLhPjX3qEOfmyRG+MMW+i9UaggY9jJaa5wavXNFuLDRya0
	b9bIk7d+ZGVpmXDC5GD2K4lSWXyUMEx1Xgkq2ZbP1QBkGfhdEqjgXpD2RQsoW8lER5KjM6
	2nPPQOWWqm1KOh+/u7G+gDW1pky2kPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793973524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItHvNO33pb8zb9UZ+LEb6x6bQbeF4DIAGvYYNsI45U8=;
	b=6UCJswdK0Z/DiwhrcdamgOXwZj9ItIC+/2kw90iroytJRvaOKpNnwu36Zgri1J7K0hnpW1
	lNS/qFpJKVe0WBAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793973523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItHvNO33pb8zb9UZ+LEb6x6bQbeF4DIAGvYYNsI45U8=;
	b=LgjfvuMAU87vP+sPHVFl3AgPTWwGTRrRaQzjksp+GUoFchaJHCJWRi3C7JriPqlaDS1xv0
	xf0+UF6xyLfW5w2peCcDGzuPDj/KNox0QLmUkIz4npAwhjxdTcSyJLMVg3YL5GoQgLdgFJ
	1Wd203yEyPmbh14aWkzxWl+puCMK0x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793973523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItHvNO33pb8zb9UZ+LEb6x6bQbeF4DIAGvYYNsI45U8=;
	b=X0ai5JyZByGuYCrevlOApXcGyusGRiOAMLTwFWFDZ7nil+IaqW8n/M/kqrLHGa75L9F+9G
	ed8IDOXKbujoFXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0677134E9;
	Fri,  6 Nov 2026 13:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 67kcJxLd7WqbVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 13:58:42 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 4E5B121B72; Fri, 06 Nov 2026 14:58:27 +0100 (CET)
Date: Fri, 6 Nov 2026 14:58:27 +0100
From: Jan Kara <jack@suse.cz>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 06/14] udf: convert mmap hook to mmap_prepare
Message-ID: <6ve6dvcmmozqiv5zkkq57thm62rtsc43jlbsfoxm24qrm5bhkg@ygji3l2k2qxq>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-6-c56aadfbab8a@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-6-c56aadfbab8a@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-15.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	R_RATELIMIT(0.00)[to_ip_from(RLyerg7kx5bdf6cnfzf33td54o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[61];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -15.30

On Thu 05-11-26 21:05:37, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only updates the access time and sets the VMA operations.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'll leave it for MM guys to merge this.
								Honza

> ---
>  fs/udf/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 02e9314818dc..d5e80c6cae96 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -190,10 +190,10 @@ static int udf_release_file(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -static int udf_file_mmap(struct file *file, struct vm_area_struct *vma)
> +static int udf_file_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	file_accessed(file);
> -	vma->vm_ops = &udf_file_vm_ops;
> +	file_accessed(desc->file);
> +	desc->vm_ops = &udf_file_vm_ops;
>  
>  	return 0;
>  }
> @@ -202,7 +202,7 @@ const struct file_operations udf_file_operations = {
>  	.read_iter		= generic_file_read_iter,
>  	.unlocked_ioctl		= udf_ioctl,
>  	.open			= generic_file_open,
> -	.mmap			= udf_file_mmap,
> +	.mmap_prepare		= udf_file_mmap_prepare,
>  	.write_iter		= udf_file_write_iter,
>  	.release		= udf_release_file,
>  	.fsync			= simple_fsync,
> 
> -- 
> 2.56.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
