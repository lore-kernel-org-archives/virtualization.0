Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92C63CB
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560112; cv=none; b=sFNgNe5rzALMWxdaINnBJad/k/D/4Tb1KOwLrQwdpk1jrWHi6GhN0kx1d3Ew/YF6v8ugdUpa/SuPAtSlZ/4dVMHG/r2rtoE4ytDYqQr643+fTuw1KYKD27jyMZ3y5IMZh+ODnhq28wwsbgAjELfqd/heovnHJWozN+2iD4o0VPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560112; c=relaxed/simple;
	bh=Xks612s/7rT6Q6ukp30bszt+1cZ8l1ePIW1QRk5v5F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/2HldwHGfK1R9+XFamCZDhqKyZjbRL+VesqD0ljnj1ORFk15AC8/6jgP0QWq+taipbKF2tLympHinIXXKfYJSUz8MZKoT445prpHPO7RGnZRXzD5p6dkXwxpDG2TPoWCT8khiyikV/RZe7ddeCEH5X5BGue8gW4iALdvan/Akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OUssEjSl; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OUssEjSl"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D14C60B5C
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vmSK1kADSTZY for <virtualization@lists.linux-foundation.org>;
 Fri, 24 May 2024 14:15:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8AED260B5E
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AED260B5E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=OUssEjSl
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AED260B5E
	for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 14:15:09 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6ab9ce64683so5613426d6.0
        for <virtualization@lists.linux-foundation.org>; Fri, 24 May 2024 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716560108; x=1717164908; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3mcx1/Tv2PzlpsLjModpuSvG006O6sdr/ydjXYZrw=;
        b=OUssEjSlQJRz3ds+HS9Hv5yz4PA6LvQrU+leKWJoKt6QalsYRdB1vqxoKWewjnc60w
         unLwHCUBlzUmFcEjl/oQKu3SnxZotVhroEnF09NUhLvhGTgRwk+a7ByBCAubVagjrQ2I
         3FSNoeei4LuVwVL7hN9gEsqJHA3ukbLGEVvCBCYGxTS7kNM0OoL83u+1givwcjvMeRIo
         0Orb5rZUKdugbIKFSIOIiPwmB8q6AIwhyXDoIXsQaC4zUTXV04TcAcgwS53XifRGLpwW
         reNT2lUXA6dcao60PkCmq0dTjWZiIlYwTvaP0RrVsv8hQEqse1YNqI4+psIxL2x3EQj6
         6ReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560108; x=1717164908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3mcx1/Tv2PzlpsLjModpuSvG006O6sdr/ydjXYZrw=;
        b=f9IO6X+/zIIRyURUXysAv2poJrbdZRcGbfgkBMVF4QVBaS4CJekBmy/bzcwzS8mjlq
         HlW8/QCOIn+w50tr/ma7CDIwiIUo+N+22ys6nEz0KnnQpUWxjjYN6Ns6ZoYadjGl1ahM
         7hgzt3LDQaJGBoZuYAX4trIOLcdwb2Hboa4k3gwkUfRudbxTYeU5XzG4x5cB8Ph4kVO4
         HZQqT+KvH+DyucRKJMR/SlOl4jnm3ZWzvI3HlbN1PmWNyP1o+vodH9mmoOAih9i9Ew6g
         MwXr3snrrlRvsLjqDrBnNo5Bw9ESpQuVzlrICAfy072s9RI3IpMczsnkh1sYj3jXNFnE
         5ANA==
X-Forwarded-Encrypted: i=1; AJvYcCXOmW9R++uCtxNSFrZ6QNG5i6DyOH+0P4o/N8p0GVKu4KDmBDHvX0XTr9o5h6OeFu85vbwyY0mV6/J8H9G5UBtXJBiUK2gwrpz/zkrcjU3nb+5Bf/51wpfG1Q==
X-Gm-Message-State: AOJu0YzcDu3AdnOy0Weaf4m6oNNqEqybU5eXBQnMoPNbZyUFUslGs0HA
	wFuhxaQww5N9u2lubD2LnXaFMwfXdHusDyqV9zeCj1CFWYgcXkSP6s/JkhNfYJM=
X-Google-Smtp-Source: AGHT+IH6Ac9WsdsUZJ58JI8yWFb4+VExingKf2US7XYudAGfc/E7XKaMftG4JYXDj6Yn+MrOVUjI+A==
X-Received: by 2002:a05:6214:4981:b0:6aa:3dc9:4b2 with SMTP id 6a1803df08f44-6abbbca5e8amr26530426d6.5.1716560108113;
        Fri, 24 May 2024 07:15:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac071048a3sm7543566d6.69.2024.05.24.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:15:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sAVhK-001JcU-UZ;
	Fri, 24 May 2024 11:15:06 -0300
Date: Fri, 24 May 2024 11:15:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Message-ID: <20240524141506.GN69273@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
 <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
 <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, May 20, 2024 at 04:59:18AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, May 20, 2024 11:33 AM
> > 
> > On 5/20/24 11:24 AM, Tian, Kevin wrote:
> > >> From: Baolu Lu <baolu.lu@linux.intel.com>
> > >> Sent: Sunday, May 19, 2024 10:38 PM
> > >>
> > >> On 2024/5/15 15:43, Tian, Kevin wrote:
> > >>>> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >>>> Sent: Tuesday, April 30, 2024 10:57 PM
> > >>>>
> > >>>> + * @length: a hint of how much data the requestor is expecting to
> > fetch.
> > >> For
> > >>>> + *          example, if the PRI initiator knows it is going to do a 10MB
> > >>>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
> > >>>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> > >>>
> > >>> This is not clear to me and I don't remember PCIe spec defines such
> > >>> mechanism.
> > >>
> > >> This came up in a previous discussion. While it's not currently part of
> > >
> > > Can you provide a link to that discussion?
> > 
> > https://lore.kernel.org/linux-iommu/20240322170410.GH66976@ziepe.ca/
> > 
> 
> We can always extend uAPI for new usages, e.g. having a new flag
> bit to indicate the additional filed for carrying the number of pages.
> But requiring the user to handle non-zero length now (though trivial)
> is unnecessary burden.

It is tricky to extend this stuff since it comes out in read().. We'd
have to have userspace negotiate a new format most likely.

> Do we want the response message to also carry a length field i.e.
> allowing the user to partially fix the fault? 

No, the device will discover this when it gets another fault  :)

Jason
