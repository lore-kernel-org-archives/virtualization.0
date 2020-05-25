From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH 5/6] vhost: add an rpmsg API
Date: Mon, 25 May 2020 15:53:36 +0200
Message-ID: <20200525135336.GB6761@ubuntu>
References: <20200516101109.2624-1-guennadi.liakhovetski@linux.intel.com>
 <20200516101109.2624-6-guennadi.liakhovetski@linux.intel.com>
 <9737e3f2-e59c-0174-9254-a2d8f29f30b7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9737e3f2-e59c-0174-9254-a2d8f29f30b7@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Pierre,

On Sat, May 16, 2020 at 12:00:35PM -0500, Pierre-Louis Bossart wrote:
> 
> > +config VHOST_RPMSG
> > +	tristate
> > +	depends on VHOST
> 
> depends on RPMSG_VIRTIO?

No, RPMSG_VIRTIO is used on the guest side, VHOST_RPMSG (as well as 
all other vhost drivers) on the host side.

> > +	default n
> 
> not needed

Ok, will remove.

Thanks
Guennadi
