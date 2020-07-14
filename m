From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v3 5/5] vhost: add an RPMsg API
Date: Tue, 14 Jul 2020 10:33:59 +0200
Message-ID: <20200714083359.wn4uoq3d7zzsddkc@axis.com>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <20200527180541.5570-6-guennadi.liakhovetski@linux.intel.com>
 <20200617191741.whnp7iteb36cjnia@axis.com> <20200618090341.GA4189@ubuntu>
 <20200618093324.tu7oldr332ndfgev@axis.com> <20200618103940.GB4189@ubuntu>
 <20200618135241.362iuggde3jslx3p@axis.com> <20200618141412.GD4189@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200618141412.GD4189@ubuntu>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 18, 2020 at 04:14:12PM +0200, Guennadi Liakhovetski wrote:
> On Thu, Jun 18, 2020 at 03:52:42PM +0200, Vincent Whitchurch wrote:
> > Note that "the Linux side" is ambiguous for AMP since both sides can be
> > Linux, as they happen to be in my case.  I'm running virtio/rpmsg
> > between two physical processors (of different architectures), both
> > running Linux.
> 
> Ok, interesting, I didn't know such configurations were used too. I understood 
> the Linux rpmsg implementation in the way, that it's assumed, that the "host" 
> has to boot the "device" by sending an ELF formatted executable image to it, is 
> that optional? You aren't sending a complete Linux image to the device side, 
> are you?

I do pack the zImage, the dtb, and the initramfs into an ELF (along with
a tiny "bootloader" with just a handful of instructions), but the
remoteproc framework is not tied to the ELF format since ->parse_fw()
and friends are overridable by the remoteproc driver.

> > virtio has distinct driver and device roles so the completely different
> > APIs on each side are understandable.  But I don't see that distinction
> > in the rpmsg API which is why it seems like a good idea to me to make it
> > work from both sides of the link and allow the reuse of drivers like
> > rpmsg-char, instead of imposing virtio's distinction on rpmsg.
> 
> Understand. In principle I'm open to this idea, but before I implement it it 
> would be good to know what maintainers think?

Certainly.
