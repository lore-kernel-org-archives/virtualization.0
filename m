From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 21 Dec 2011 11:19:37 +0200
Message-ID: <20111221091937.GB31592@redhat.com>
References: <20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au> <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878vm6daqy.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 21, 2011 at 11:03:25AM +1030, Rusty Russell wrote:
> > > What does the host do
> > > if the guest screws things up?  How long do you wait for them to
> > > complete the seqlock?  Or does it save the old version for use in the
> > > duration?
> > 
> > Yes, it will have to only apply the change when seqlock is dropped.
> 
> If the seqlock is in normal memory, how does it get notified?  It would
> have to poll.  That's annoying, since you don't know when to give up and
> declare the device terminally broken.

OK, so you think all devices need a config vq then?
It actually has other benefits:
- devices don't need a design choice between configuration and vq
- minimum number of MSI vectors per device will be 1, not 2
- reduced PCI memory usage
- configuration updates become more lightweight

-- 
MST
