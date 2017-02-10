From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Fri, 10 Feb 2017 11:17:30 -0500 (EST)
Message-ID: <150348311.20329795.1486743450189.JavaMail.zimbra@redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com>
	<20170208214435-mutt-send-email-mst@kernel.org>
	<cc075b18-0913-ef89-96a8-a29869abd73e@redhat.com>
	<20170209202203-mutt-send-email-mst@kernel.org>
	<c229269b-1702-ffec-62e8-002c7c142904@redhat.com>
	<20170210170548-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170210170548-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> From: "Michael S. Tsirkin" <mst@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
> Sent: Friday, February 10, 2017 4:20:17 PM
> Subject: Re: [virtio-dev] packed ring layout proposal v2
> 
> On Fri, Feb 10, 2017 at 12:32:49PM +0100, Paolo Bonzini wrote:
> > 
> > 
> > On 09/02/2017 19:24, Michael S. Tsirkin wrote:
> > >> I don't know.  Power of 2 ring size is pretty standard, I'd rather avoid
> > >> the complication and the gratuitous difference with 1.0.
> > >
> > > I thought originally there's a reason 1.0 rings had to be powers of two
> > > but now I don't see why. OK, we can make it a feature flag later if we
> > > want to.
> > 
> > The reason is that it allows indices to be free running.
> 
> Well what I meant is that with qsize not a power of 2 you can still do
> this but have to do everything mod N*qsize as opposed to mod 2^16. So
> you need a branch there - easiest to do if you do signed math.
> 
> int nheads = avail - last_avail;
> /*Check and handle index wrap-around */
> if (unlikely(nheads < 0)) {
> 	nheads += N_qsize;
> }
> 
> if (nheads < 0 || nheads > vdev->vq[i].vring.num) {
> 	error_report(...);
> 	return -1;
> }
> 
> This can only catch bugs if N > 1

Agreed.

> > This is an example of QEMU code that requires that:
> 
> Same thing here, this never triggers if vring.num == 2^16

Free running indices require the counter range to be bigger than the
size of the vring (otherwise you confuse an empty vring with a full
one), so the maximum size of the vring in virtio <=1.0 is 2^15.

Paolo
