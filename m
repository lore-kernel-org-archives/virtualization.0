From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v3 5/5] vhost: add an RPMsg API
Date: Thu, 18 Jun 2020 11:03:42 +0200
Message-ID: <20200618090341.GA4189@ubuntu>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <20200527180541.5570-6-guennadi.liakhovetski@linux.intel.com>
 <20200617191741.whnp7iteb36cjnia@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200617191741.whnp7iteb36cjnia@axis.com>
Sender: kvm-owner@vger.kernel.org
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Vincent,

On Wed, Jun 17, 2020 at 09:17:42PM +0200, Vincent Whitchurch wrote:
> On Wed, May 27, 2020 at 08:05:41PM +0200, Guennadi Liakhovetski wrote:
> > Linux supports running the RPMsg protocol over the VirtIO transport
> > protocol, but currently there is only support for VirtIO clients and
> > no support for a VirtIO server. This patch adds a vhost-based RPMsg
> > server implementation.
> 
> This looks really useful, but why is it implemented as an API and not as
> a real vhost driver which implements an rpmsg bus?  If you implement it
> as a vhost driver which implements rpmsg_device_ops and
> rpmsg_endpoint_ops, then wouldn't you be able to implement your
> vhost-sof driver using the normal rpmsg APIs?

Sorry, not sure what you mean by the "normal rpmsg API?" Do you mean the 
VirtIO RPMsg API? But that's the opposite side of the link - that's the 
guest side in the VM case and the Linux side in the remoteproc case. What 
this API is adding is a vhost RPMsg API. The kernel vhost framework 
itself is essentially a library of functions. Kernel vhost drivers simply 
create a misc device and use the vhost functions for some common 
functionality. This RPMsg vhost API stays in the same concept and provides 
further functions for RPMsg specific vhost operation.

> I tried quickly hooking up this code to such a vhost driver and I was
> able to communicate between host and guest systems with both
> rpmsg-client-sample and rpmsg-char which almost no modifications to
> those drivers.

You mean you used this patch to create RPMsg vhost drivers? Without 
creating a vhost RPMsg bus? Nice, glad to hear that!

Thanks
Guennadi
