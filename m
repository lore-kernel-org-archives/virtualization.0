From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tpm: Add driver for TPM over virtio
Date: Fri, 22 Feb 2019 16:16:01 -0500
Message-ID: <20190222160220-mutt-send-email-mst@kernel.org>
References: <388c5b80-21a7-1e91-a11f-3a1c1432368b@gmail.com>
	<1550849416.2787.5.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1550849416.2787.5.camel@HansenPartnership.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: dgreid@chromium.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, apronin@chromium.org, David Tolnay <dtolnay@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2019 at 07:30:16AM -0800, James Bottomley wrote:
> On Thu, 2019-02-21 at 18:14 -0800, David Tolnay wrote:
> > Add a config TCG_VIRTIO_VTPM which enables a driver providing the
> > guest kernel side of TPM over virtio.
> 
> What's the use case for using this over the current non-virtio vTPM?. 
> I always thought virtio was about guest to host transport efficiency,
> but the phsical TPM, being connected over a very slow bus, is about as
> inefficient as you can get in that regard, so why do we need to use
> virtio to drive the virtual one?

I can't say for sure about TPM.

But generally there are many reasons to do virtio rather than emulating
a hardware device.

Ease of extending the device could be one. E.g. what if you want to make
an extension that hardware does not support?  You are at cross-purposes
with a hardware vendor who can happen to be the driver maintainer as
well.

A decent specification and readiness to fix bugs in the right place
(e.g.  driver violates spec? we'll fix driver not as you to work around
it in the device) is another.

You can also download the spec without clicking I agree once - and it
follows the Non-Assertion IPR Mode to help people not get sued.

Stuff like that is conductive to getting things done.

-- 
MST
