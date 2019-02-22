From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Date: Fri, 22 Feb 2019 17:07:19 -0500
Message-ID: <20190222170556-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
	<1550849416.2787.5.camel@HansenPartnership.com>
	<20190222160220-mutt-send-email-mst@kernel.org>
	<20190222213137.GZ17500@ziepe.ca>
	<20190222215923.GB21427@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190222215923.GB21427@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dgreid@chromium.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, apronin@chromium.org, David Tolnay <dtolnay@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2019 at 11:59:23PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 22, 2019 at 02:31:37PM -0700, Jason Gunthorpe wrote:
> > On Fri, Feb 22, 2019 at 04:16:01PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 22, 2019 at 07:30:16AM -0800, James Bottomley wrote:
> > > > On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > > > > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > > > > guest kernel side of TPM over virtio.
> > > > 
> > > > What's the use case for using this over the current non-virtio vTPM?. 
> > > > I always thought virtio was about guest to host transport efficiency,
> > > > but the phsical TPM, being connected over a very slow bus, is about as
> > > > inefficient as you can get in that regard, so why do we need to use
> > > > virtio to drive the virtual one?
> > > 
> > > I can't say for sure about TPM.
> > > 
> > > But generally there are many reasons to do virtio rather than emulating
> > > a hardware device.
> > 
> > We already have a xen 'virtioish' TPM driver, so I don't think there
> > is a good reason to block a virtio driver if someone cares about
> > it. There are enough good reasons to prefer virtio to other options,
> > IMHO.
> > 
> > Provided it meets the general requirements for new virtio stuff you
> > outlined.
> 
> Yeah, absolutely we can consider this.
> 
> For me it boils down to testing and documentation part.
> 
> No plans to merge code that I'm unable to run...
> 
> /Jarkko

I do this sometimes. One can't require samples for all supported
hardware. If I can check that code matches spec, I might settle for
that.

-- 
MST
