From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 09:16:25 +1100
Message-ID: <1326320185.23910.157.camel@pasglop>
References: <4F0DA7A5.7050600@codemonkey.ws>
	<20120111152129.GB20570@redhat.com> <4F0DAA9B.7060703@codemonkey.ws>
	<20120111154515.GD20570@redhat.com> <4F0DB2AB.8030506@codemonkey.ws>
	<20120111170859.GA22310@redhat.com> <4F0DE62F.6030805@codemonkey.ws>
	<20120111201436.GA27292@redhat.com> <4F0DF08F.7010706@codemonkey.ws>
	<1326315726.23910.143.camel@pasglop>
	<20120111220232.GC27292@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111220232.GC27292@redhat.com>
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
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-01-12 at 00:02 +0200, Michael S. Tsirkin wrote:
> > We could probably have a helper library for sending control messages
> > which could handle waiting for a ring slot to be free (practically
> > always the case on control queues), writing the message, sending it
> and
> > waiting for a status queue confirmation message.
> > 
> > Cheers,
> > Ben.
> > 
> 
> Look, we have a race currently. Let us not tie a bug fix to a huge
> rewrite with unclear performance benefits, please.

Well, if we change endian, change the way config works, I think we are
doing enough dramatic changes to go all the way and change the ring
format too.

I don't think there's anything "unclear" about improving the rings in
the direction that all network cards have been chosing so far :-) But
for the control ring, performance is clearly not an issue.

I also like the simplicity of immediate data, it limits the failure
path, no allocation -does- make it easier, not having to wait for the
previous buffer to be complete if you pre-allocate etc...

In any case, if we do a lot of changes at the same time, we are probably
better off cutting the cord and making an incompatible vfio v2 with a
new set of drivers.

Having to deal with all the variants in a single driver will result in
unmaintainable drivers imho.

Cheers,
Ben.
