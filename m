From: Sasha Levin <levinsasha928@gmail.com>
Subject: RE: [PATCH 097/117] Staging: hv: storvsc: Add code to handle IDE
 devices using the storvsc driver
Date: Sat, 16 Jul 2011 16:01:39 +0300
Message-ID: <1310821299.1976.2.camel@lappy>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	 <1310752065-27895-1-git-send-email-kys@microsoft.com>
	 <1310752065-27895-97-git-send-email-kys@microsoft.com>
	 <20110716020447.GB7199@infradead.org>
	 <6E21E5352C11B742B20C142EB499E0480817A4DA@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480817A4DA@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2011-07-16 at 12:57 +0000, KY Srinivasan wrote:
> 
> > -----Original Message-----
> > From: Christoph Hellwig [mailto:hch@infradead.org]
> > Sent: Friday, July 15, 2011 10:05 PM
> > To: KY Srinivasan
> > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> > Subject: Re: [PATCH 097/117] Staging: hv: storvsc: Add code to handle IDE devices
> > using the storvsc driver
> > 
> > Thanks, this looks much cleaner than the initial variant.
> > 
> > > +	if (dev_is_ide) {
> > > +		storvsc_get_ide_info(device, &target, &path);
> > > +		host_dev->path = device_info.path_id;
> > > +		host_dev->target = device_info.target_id;
> > > +	} else {
> > > +		host_dev->path = device_info.path_id;
> > > +		host_dev->target = device_info.target_id;
> > > +	}
> > 
> > Is using the device_info values in both branches intentional?  If so
> > there's no need to have these assignments duplicated.
> 
> While we set the values in both the branches, the value set is different;
> The IDE side encodes the bits differently and is appropriately parsed in the
> function storvsc_get_ide_info().

Is think that what Christoph meant was simplifying it to:

	if (dev_is_ide)
		storvsc_get_ide_info(device, &target, &path);
	
	host_dev->path = device_info.path_id;
	host_dev->target = device_info.target_id;

-- 

Sasha.
