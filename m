From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/5] Add a vhost RPMsg API
Date: Mon, 8 Jun 2020 05:09:10 -0400
Message-ID: <20200608050757-mutt-send-email-mst@kernel.org>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <20200604151917-mutt-send-email-mst@kernel.org>
 <20200605063435.GA32302@ubuntu>
 <20200608073715.GA10562@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200608073715.GA10562@ubuntu>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 08, 2020 at 09:37:15AM +0200, Guennadi Liakhovetski wrote:
> Hi Michael,
> 
> On Fri, Jun 05, 2020 at 08:34:35AM +0200, Guennadi Liakhovetski wrote:
> > 
> > On Thu, Jun 04, 2020 at 03:23:37PM -0400, Michael S. Tsirkin wrote:
> 
> [snip]
> 
> > > Another it's out of line with 1.0 spec passing guest
> > > endian data around. Won't work if host and guest
> > > endian-ness do not match. Should pass eveything in LE and
> > > convert.
> > 
> > Yes, I have to fix this, thanks.
> 
> Just to make sure my understanding is correct: this would involve also 
> modifying the current virtio_rpmsg_bus.c implementation to add 
> endianness conversions. That's what you meant, right?
> 
> Thanks
> Guennadi

right and if there are legacy compat considerations, using _virtio16 and
friends types, as well as virtio16_to_cpu and friends functions.

-- 
MST
