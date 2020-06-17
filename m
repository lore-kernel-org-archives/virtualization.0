From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v3 5/5] vhost: add an RPMsg API
Date: Wed, 17 Jun 2020 21:17:42 +0200
Message-ID: <20200617191741.whnp7iteb36cjnia@axis.com>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <20200527180541.5570-6-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200527180541.5570-6-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 27, 2020 at 08:05:41PM +0200, Guennadi Liakhovetski wrote:
> Linux supports running the RPMsg protocol over the VirtIO transport
> protocol, but currently there is only support for VirtIO clients and
> no support for a VirtIO server. This patch adds a vhost-based RPMsg
> server implementation.

This looks really useful, but why is it implemented as an API and not as
a real vhost driver which implements an rpmsg bus?  If you implement it
as a vhost driver which implements rpmsg_device_ops and
rpmsg_endpoint_ops, then wouldn't you be able to implement your
vhost-sof driver using the normal rpmsg APIs?

I tried quickly hooking up this code to such a vhost driver and I was
able to communicate between host and guest systems with both
rpmsg-client-sample and rpmsg-char which almost no modifications to
those drivers.
