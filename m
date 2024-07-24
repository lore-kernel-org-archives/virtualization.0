Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66290134B1
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787168; cv=none; b=YAUIUtWpWmLOlFSBVfiXuSoAgulf+KM5rtbRjibbeL6wwxRrdPEocCbvsbnbdXWV+W62QdUwpUnuYCuvsA1qZ4186fZRuefuVHgAcLAK9AL1SA99zHiV50f2yT6wDNNgMZ0pafr5qkk62RlDN5XbTT9benc5rFEPbs0w8jqFod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787168; c=relaxed/simple;
	bh=HqQhCLi2BNPd/ZrfrrIBuLEUl8XjR1USS5+f0zaa3a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roQQXunJutqG94vpjJqULA3AEcQov814+VmiNuEC7gyyLCchN8S1bMWmZKM8sB4xyxBBfNH91qR/JyDVtDOG145+o9H31Co5+nVaB57zM+nmoOG0wMBG8fVMe4aSfKJIs1KBB2EiVQYx9V9rMxg35fNqfOBsop6ON47zbDq2sUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLPB2ig6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLPB2ig6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13C7981372
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOhEA--2UxU5 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Jul 2024 02:12:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3892E81371
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3892E81371
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CLPB2ig6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3892E81371
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jul 2024 02:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721787164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/CDtEBkZLf1xoU0C7ksliBZOQvRtEzxEPf2Wwd79pU=;
	b=CLPB2ig6c+8gZnvZxKN7w7JtlNU+SVdW9tvSNbKtfhGgjTLx2+S5Hih7rRBiehz2rT07IA
	O1LZtuh03VzgswVBMaf7egfqWDP1C98uvcxPXMJKsirxv5xUfuaCo+gx7By17EsP6xLRQ8
	BzMOaialSOcVdggBDa+T6AKcsvOGcB4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ghJp9LHxOTaZ7oID-iRhRQ-1; Tue, 23 Jul 2024 22:12:42 -0400
X-MC-Unique: ghJp9LHxOTaZ7oID-iRhRQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a534faa028so2810578a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 19:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787161; x=1722391961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/CDtEBkZLf1xoU0C7ksliBZOQvRtEzxEPf2Wwd79pU=;
        b=S2JuaPhbmCbBAQCFRIDI5FVTqqBxPQsDB8yS4prLAc/A1XJOefMGHfUC5Wq8ChVkRb
         YGweFJKjlLZqXtDmEjHjp+tKYuUIK4nVm0o9BHN2EvjceMe1ms0HKp1UBeGPGxph17LR
         MQ0TMOgMFe9W6N3YtNqBN71paXI178J3je7L26LGTh+oBVBuG1nuQgwkHo7ONwkownSj
         3CLWvVEudUXIIlg6nlwMrdFen59Kh7fYLfN/kk/UbRu5puwdx2vWSvjEKI1Ccn9gGVgx
         qT+gyraBsTPMHY91TY9R1R4wGlcnD3AzzQgFkXToyQ6GxhHR/9b0Yj1Xt0v6v8s2ku8E
         Or4w==
X-Forwarded-Encrypted: i=1; AJvYcCXEI2V3/3eN/+QDbjmF9mjdh2hy0zt3feZGZCcS4X/ke63doepiwk2LLv4+iUEPSODL/aOZx35MnY3MDFZ+XzbjsocXHgmWWCkQVmeBK96Gyv8wAgRREkoDDQ==
X-Gm-Message-State: AOJu0YxoVeyv+rCPoT5f5XlmCnaQ//cIM20WWYMwGLAwyJ2SdVkMKzVo
	7o4wdOBZpl04pSzNX1t4WupFs3nyQGpSdo8Y5DjmFYbkeoHxOZy+If9JdOaD6J5QlLzsGU223iJ
	psG5jXoGEd7iB0o0Y14IyrLz/gxyV7SCNW0mtpRo6x24agRhoraMcM1CGx4TIFh6a4A66q7rIYz
	zI7Oh8EnkECV0Qavw0tCQgdLVuctH6ZUbIdNUFigjfKRDFF3htooVWPA==
X-Received: by 2002:a05:6402:234c:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5aaece39c30mr562175a12.22.1721787160870;
        Tue, 23 Jul 2024 19:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgP3SMHABHLAK1ShSJyuqULWrGb17ytiwZhc3mKrBjTl8ITd2JHGrsgEsjrJDBGLVMXv7Gi/wR2c5DVGWvAaQ=
X-Received: by 2002:a05:6402:234c:b0:5a2:abcb:c4cf with SMTP id
 4fb4d7f45d1cf-5aaece39c30mr562165a12.22.1721787160493; Tue, 23 Jul 2024
 19:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723054047.1059994-1-lulu@redhat.com> <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
In-Reply-To: <66239ba4-d837-48da-aaba-528c6ab05ce9@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 24 Jul 2024 10:12:03 +0800
Message-ID: <CACLfguVQT2bpzA6zTyAV4pDRdFttCMXCZc179HqxvjCVRPNnkQ@mail.gmail.com>
Subject: Re: [PATH v5 0/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 02:45, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 23, 2024 at 01:39:19PM +0800, Cindy Lu wrote:
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address
> > to the config space. However, for other drivers, they can implement their
> > own function, not limited to the config space.
> >
> > Changelog v2
> >  - Changed the function name to prevent misunderstanding
> >  - Added check for blk device
> >  - Addressed the comments
> > Changelog v3
> >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> >  - Add a lock for the network device's dev_set_attr operation
> >  - Address the comments
> > Changelog v4
> >  - Address the comments
> >  - Add a lock for the vdap_sim?_net device's dev_set_attr operation
> > Changelog v5
> >  - Address the comments
>
> This history is to help reviewers of previous versions know if there
> comments have been addressed. Just saying 'Address the comments' is
> not useful. Please give a one line summary of each of the comment
> which has been addressed, maybe including how it was addressed.
>
>       Andrew
>
will change this
Thanks
cindy

