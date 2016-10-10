From: Will Deacon <will.deacon@arm.com>
Subject: Re: VIRTIO_F_IOMMU_PLATFORM
Date: Mon, 10 Oct 2016 17:59:03 +0100
Message-ID: <20161010165903.GH14561@arm.com>
References: <20160927085713.GB3489@arm.com>
	<20161007042434.jpu7ql3djfo6o6kd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20161007042434.jpu7ql3djfo6o6kd@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 07, 2016 at 07:24:34AM +0300, Michael S. Tsirkin wrote:
> On Tue, Sep 27, 2016 at 09:57:14AM +0100, Will Deacon wrote:
> > Hi Michael,
> > 
> > In commit 1a937693993f ("virtio: new feature to detect IOMMU device quirk"),
> > you added a new feature bit (VIRTIO_F_IOMMU_PLATFORM) to describe whether
> > or not a given virtio device requires physical address or bus addresses.
> > 
> > Is there a plan to get this incorporated into the virtio spec [1]? At the
> > moment, I can't see a working draft that includes the new bit. Having it
> > in the spec would help convince implementors that it's not just a Linux
> > thing.
> > 
> > Thanks,
> > 
> > Will
> > 
> > [1] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html
> 
> Absolutely. Want to contribute a patch?

I could have a look. Is there a git repo for the sources to the working
draft?

Will
