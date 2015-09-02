From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: udev PATH_ID for virtio devices
Date: Wed, 2 Sep 2015 15:09:41 +0300
Message-ID: <20150902150631-mutt-send-email-mst@redhat.com>
References: <20140327191355.GB4114@redhat.com>
	<CAPXgP12FjjRrT2bLf1pTp5APJxL2fyG1iBbbYtt3zE_XD+PLgQ@mail.gmail.com>
	<CAG-2HqWFQB2C90z4btpoEfMv25C_t7ZAXnRzyGunTGd3EcUc9A@mail.gmail.com>
	<20140327205827.GA4440@redhat.com>
	<CAG-2HqUzkk6DE776K7gH=Z5_RkdhZ90nGHVUwm7MYB-tgrj0AA@mail.gmail.com>
	<20150825144034-mutt-send-email-mst@redhat.com>
	<CAPXgP13t+bKEVbQ1M3x7_4DXMk=cKv0Bqy1KD4bKA-JaUg9cmQ@mail.gmail.com>
	<20150825145151-mutt-send-email-mst@redhat.com>
	<CAPXgP137A=CdmggtVPUZXbnpTbU9Tewq-sOjg9T8ohYktct1kQ@mail.gmail.com>
	<CAG-2HqU29JvRWmq4WJFDRcYzG=dBKuqMGtDu2eSt8gZc6eqppQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAG-2HqU29JvRWmq4WJFDRcYzG=dBKuqMGtDu2eSt8gZc6eqppQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Gundersen <teg@jklm.no>
Cc: Kay Sievers <kay@vrfy.org>, Harald Hoyer <harald@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 02, 2015 at 01:53:33PM +0200, Tom Gundersen wrote:
> On Tue, Aug 25, 2015 at 1:58 PM, Kay Sievers <kay@vrfy.org> wrote:
> > On Tue, Aug 25, 2015 at 1:52 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> On Tue, Aug 25, 2015 at 01:46:49PM +0200, Kay Sievers wrote:
> >>> On Tue, Aug 25, 2015 at 1:43 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> > On Mon, Aug 24, 2015 at 06:10:01PM +0200, Tom Gundersen wrote:
> >
> >>> >> 1) if there is a guarantee now and in the future (even if only
> >>> >> restricted to netdevs) that no virtio bus will have a direct sibling
> >>> >> bus (i.e., with the same parent device); or
> >>> >
> >>> > I think this is the case. The virtio bus is an artifact.
> >>> > There's always a single one behind each pci device.
> >>> > Is this sufficient?
> >>>
> >>> I *think* is not good enough for udev to offer such functionality.
> >>>
> >>> We need an authoritative answer that this cannot happen with today's
> >>> code, and also that there are no plans to ever make multiple virtio
> >>> devices per parent device.
> >
> >> But if virtio will make such a promise, will that be sufficient?
> >
> > Sure.
> 
> Any chance we could get such a guarantee? Anything else needed from
> our side? I have a pending patch that would be nice to get out, which
> would depend on such a guarantee.
> 
> Cheers,
> 
> Tom

I thought about this. The virtio spec makes it explicit for pci,
ccw and mmio devices. I think we can make this promise - if we
wanted to have many such buses, we can always make it something else,
not a virtio bus.

So please just check the type of the bus - if it's virtio,
you can assume there is no sibling.

-- 
MST
