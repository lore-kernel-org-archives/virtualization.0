From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/5] Add a vhost RPMsg API
Date: Mon, 8 Jun 2020 09:08:33 -0400
Message-ID: <20200608090145-mutt-send-email-mst@kernel.org>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com>
 <20200604151917-mutt-send-email-mst@kernel.org>
 <20200605063435.GA32302@ubuntu>
 <20200608073715.GA10562@ubuntu>
 <20200608091100.GC10562@ubuntu>
 <20200608051358-mutt-send-email-mst@kernel.org>
 <20200608101526.GD10562@ubuntu>
 <20200608111637.GE10562@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200608111637.GE10562@ubuntu>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 08, 2020 at 01:16:38PM +0200, Guennadi Liakhovetski wrote:
> On Mon, Jun 08, 2020 at 12:15:26PM +0200, Guennadi Liakhovetski wrote:
> > On Mon, Jun 08, 2020 at 05:19:06AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Jun 08, 2020 at 11:11:00AM +0200, Guennadi Liakhovetski wrote:
> > > > Update: I looked through VirtIO 1.0 and 1.1 specs, data format their, 
> > > > including byte order, is defined on a per-device type basis. RPMsg is 
> > > > indeed included in the spec as device type 7, but that's the only 
> > > > mention of it in both versions. It seems RPMsg over VirtIO isn't 
> > > > standardised yet.
> > > 
> > > Yes. And it would be very good to have some standartization before we
> > > keep adding things. For example without any spec if host code breaks
> > > with some guests, how do we know which side should be fixed?
> > > 
> > > > Also it looks like newer interface definitions 
> > > > specify using "guest native endianness" for Virtual Queue data.
> > > 
> > > They really don't or shouldn't. That's limited to legacy chapters.
> > > Some definitions could have slipped through but it's not
> > > the norm. I just quickly looked through the 1.1 spec and could
> > > not find any instances that specify "guest native endianness"
> > > but feel free to point them out to me.
> > 
> > Oh, there you go. No, sorry, my fault, it's the other way round: "guest 
> > native" is for legacy and LE is for current / v1.0 and up.
> > 
> > > > So 
> > > > I think the same should be done for RPMsg instead of enforcing LE?
> > > 
> > > That makes hardware implementations as well as any cross-endian
> > > hypervisors tricky.
> > 
> > Yes, LE it is then. And we need to add some text to the spec.
> 
> I found the protocol and the message format definition: 
> https://github.com/OpenAMP/open-amp/wiki/RPMsg-Messaging-Protocol#transport-layer---rpmsg 
> Don't know what the best way for referencing it in the VirtIO standard 
> would be: just a link to the source or a quote.
> 
> Thanks
> Guennadi

I wasn't aware of that one, thanks!
OK so that's good.

Ideally we'd have RPMsg Header Definition, RPMsg Channel and RPMsg
Endppint in the spec proper.

This link is informal so can't be copied into spec as is but can be used as a basis.

We'd also need approval from authors for inclusion in the spec,
sent to the TC mailing list.

-- 
MST
