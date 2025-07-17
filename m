Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599A42049
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733874; cv=none; b=Nd2Kd70Gjc9yTS3rtPz7ywpTdSfqqyGhdkVtvKgdjvOVvXNtydrpL0FK2WnTW2IeFZihq/9E4ess7p4J+HG192jntCrZOKcMNMlLMCy+6EpTVzuE9C4bgQzh8CSfyO+2iRHELOMGLhJsId54YLZIK4FqB+OloaRQGb6SZJkk5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733874; c=relaxed/simple;
	bh=nGt6mjY502NYQJQNLQHOqJ0cX0q0+Ew5UUFrSaN7eOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WGKB4JsYUN16aAvD7uFQTnu5wI0jLybQM9thXw5Vxb2PjCJOifLQUwTE8UzMoU7RUQlaBgSGM099SPRihUHeYGCqYeudO8j21yZxHEEEmMOkJ0YsdpI9yIyKpYHNzNH2/5+GJRsDIVu6OM2Ype7nxgqvtx7/fFpzEaukeA8PH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1pPHusI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1pPHusI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752733871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvK5vwyLkiwd45XXL+NYQb7X8wlfzvJMgGcpvl9Wm5M=;
	b=S1pPHusIkIPXMBHA9XGAuP/VSQsXuEfuUNLzc8uFrIOBjoC/sSBDuR/OeRe//flv2sq3yW
	YSqY+471IFOM5Tl/Dr5PCPVVuvB8BX/kkzjt9l/qrmNZp0lD+rXzmJ36aONrOXjcuJmcZ5
	6EOSliMGybOwho70twKyirwK7DZI2Bc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ti9aZLjoP9atSU7iMe3Rhg-1; Thu, 17 Jul 2025 02:31:10 -0400
X-MC-Unique: ti9aZLjoP9atSU7iMe3Rhg-1
X-Mimecast-MFC-AGG-ID: ti9aZLjoP9atSU7iMe3Rhg_1752733869
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso461379f8f.0
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 23:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733868; x=1753338668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvK5vwyLkiwd45XXL+NYQb7X8wlfzvJMgGcpvl9Wm5M=;
        b=S71HJN30CXVrGFro9B2fMUQn5zn48b4dbn09GbADAdUbOCnmGGcopP8vtIotmZVUhA
         XaZ1ph1W4f82mKGQ07NlRn81VZpfM0JZDgDinlu3+VscZONa4nJOyVBR0glqoFRRNnMh
         ym2jiTRBp+tj0N9giDbXczWl9bcE/egI1uPdZZkMTQKuzVK7YyWRe3jS5GBoRS1JFOBV
         kQkqRJiWLn4bEvuw0Klf7KaQBEtMa0nvROJ0oCokFKtmH9rQFeig0uBqWp3Trncay2o7
         Gq+m6Gy3Dc60R/xsECktmkzL/qAGPrGJeDnc9IrPN30VyddYJqaHD5SLkLFkcTeRbke1
         13zA==
X-Forwarded-Encrypted: i=1; AJvYcCVOKlRXRDhQnaUj4ucc3IpdGaibvTYJIHeatUz09Z01RKHiMQ7HD/n44LUGiLjGop3AsPG/bl2xbPuz/Qf++A==@lists.linux.dev
X-Gm-Message-State: AOJu0YygiXljImX9H1Fwoai8OnXKZhbNOApqfJXXxbfL3mA2EuguQjew
	Uu9t0ZNHNpCCHibhIFwJSWIJnEqIKp7yfG6PfzlgEprV1UrFR6V996pb92RVpzB/L75V5tg9fSl
	VJKaqsPUy4JU/4Q5nMvsn+0L5oUdVXSyoXhAagcebv7VTGdpM/dwbfYeGipT2cdVvYh51VafGjo
	OZ
X-Gm-Gg: ASbGncvnKeFSUz2Eo3IHzXDp+jKXr/XL3mqOhv7mZoRWIqaYsk3I6BrbrAeQJ/Kd31j
	ap0xQ7voPe7unJ/xmjHieojN9CHnDTMXWhsiGG6f8d6UNtHs936GfoWb9mFIA7gz4DXXKKpq3hd
	9wzoecYTHxFpUagtun92cccu8ii8Nl3JVxwNnBOXte+zPmKDKc7vmeZl9pJ3ff8S0t6kz+aMbGW
	fg8CMiP+dUUNjM/niv0msDaf6Rg4NUCUm5DGAQaG3gzbETZGXv0XhCXZJV2cKm8pfjdgmVzCyi1
	FhiexB7tfzaLDqUJceVi8Yp48wTKbJgB
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b60dd827a9mr5402532f8f.48.1752733868527;
        Wed, 16 Jul 2025 23:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDhNrlMdoGwMnp3S2sOg05qA/z2rX+K2yXyqiJ23p15NQvqO+DN/Tziiqc7jgSgj6yaxfLA==
X-Received: by 2002:a05:6000:4a06:b0:3b3:a6b2:9cd3 with SMTP id ffacd0b85a97d-3b60dd827a9mr5402502f8f.48.1752733868012;
        Wed, 16 Jul 2025 23:31:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm19679812f8f.40.2025.07.16.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:31:07 -0700 (PDT)
Date: Thu, 17 Jul 2025 02:31:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonah.palmer@oracle.com
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
Message-ID: <20250717020749-mutt-send-email-mst@kernel.org>
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JCkKC2VycaYPB-P0DftI07tqhAbqVVDWWQQkZUzjHqE_1752733869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jul 17, 2025 at 02:01:06PM +0800, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> > > On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> > > > > This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
> > > > > feature is designed to improve the performance of the virtio ring by
> > > > > optimizing descriptor processing.
> > > > >
> > > > > Benchmarks show a notable improvement. Please see patch 3 for details.
> > > >
> > > > You tagged these as net-next but just to be clear -- these don't apply
> > > > for us in the current form.
> > > >
> > >
> > > Will rebase and send a new version.
> > >
> > > Thanks
> >
> > Indeed these look as if they are for my tree (so I put them in
> > linux-next, without noticing the tag).
> 
> I think that's also fine.
> 
> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> 
> (Note that the reason for the conflict is because net-next gets UDP
> GSO feature merged).

Whatever is easier really. Generally I do core vhost but if there is a
conflict we can do net-next.

> >
> > But I also guess guest bits should be merged in the same cycle
> > as host bits, less confusion.
> 
> Work for me, I will post guest bits.
> 
> Thanks
> 
> >
> > --
> > MST
> >

