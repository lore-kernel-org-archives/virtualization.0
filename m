From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH 5/6] vhost: add an rpmsg API
Date: Tue, 26 May 2020 20:55:22 +0200
Message-ID: <20200526185522.GA6992@ubuntu>
References: <20200516101109.2624-1-guennadi.liakhovetski@linux.intel.com>
 <20200516101109.2624-6-guennadi.liakhovetski@linux.intel.com>
 <9737e3f2-e59c-0174-9254-a2d8f29f30b7@linux.intel.com>
 <20200525135336.GB6761@ubuntu>
 <59029e07-f49b-8d1a-4eb4-2f6d5775cf54@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59029e07-f49b-8d1a-4eb4-2f6d5775cf54@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, sound-open-firmware@alsa-project.org, linux-remoteproc@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Pierre,

On Tue, May 26, 2020 at 01:30:24PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 5/25/20 8:53 AM, Guennadi Liakhovetski wrote:
> > Hi Pierre,
> > 
> > On Sat, May 16, 2020 at 12:00:35PM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > > +config VHOST_RPMSG
> > > > +	tristate
> > > > +	depends on VHOST
> > > 
> > > depends on RPMSG_VIRTIO?
> > 
> > No, RPMSG_VIRTIO is used on the guest side, VHOST_RPMSG (as well as
> > all other vhost drivers) on the host side.
> 
> I vaguely recalled something about sockets, and was wondering if there isn't
> a dependency on this:
> 
> config VHOST_VSOCK
> 	tristate "vhost virtio-vsock driver"
> 	depends on VSOCKETS && EVENTFD && VHOST_DPN
> 	select VHOST

You probably are thinking about the first patch in the series "vhost: convert 
VHOST_VSOCK_SET_RUNNING to a generic ioctl." But no, this RPMsg driver 
doesn't depend on vsock, on the contrary, it takes a (albeit tiny) piece of 
functionality from vsock and makes it global.

Thanks
Guennadi
