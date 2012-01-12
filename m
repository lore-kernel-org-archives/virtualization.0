From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 18:03:18 +1100
Message-ID: <1326351798.23910.211.camel@pasglop>
References: <871us0om2t.fsf@rustcorp.com.au>
	<20111220113718.GF3913@redhat.com> <878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com> <8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com> <87vcoh4r2y.fsf@rustcorp.com.au>
	<1326342719.23910.199.camel@pasglop>
	<20120112060954.GD10319@redhat.com>
	<1326349714.23910.207.camel@pasglop>
	<20120112065132.GF10319@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120112065132.GF10319@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-01-12 at 08:51 +0200, Michael S. Tsirkin wrote:

> One othe rinteresting thing is that
> in practice host often runs on the same CPU as guest.

That's surprising. On Power with our huge exit cost, I would think that
would hurt more than anything else.

> This is the fastest way to run the host for when it
> does not do a lot of work as most data is cached. And there amount of sharing
> is less important than reducing cache consumption.
> 
> Again this is different from real hardware.

Yes indeed.

Cheers,
Ben.
