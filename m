From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] kvm "virtio pmem" device
Date: Sat, 12 Jan 2019 17:43:26 -0800
Message-ID: <CAPcyv4hwcgTUpgNCefCGu4DvgkYBp5b=f+hJ+FC=s5APYKoycg__14153.6036543132$1547693172$gmane$org@mail.gmail.com>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190110012617.GA4205@dastard>
	<20190110101757.GC15790@quack2.suse.cz>
	<1354249849.63357171.1547343519970.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1354249849.63357171.1547343519970.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Dave Chinner <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Eric Blake <eblake@redhat.com>, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com, Nitesh Narayan Lal <nilal@redhat.com>, Theodore Ts'o <tytso@mit.edu>, xiao
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 12, 2019 at 5:38 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
>
> >
> > On Thu 10-01-19 12:26:17, Dave Chinner wrote:
> > > On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
> > > >  This patch series has implementation for "virtio pmem".
> > > >  "virtio pmem" is fake persistent memory(nvdimm) in guest
> > > >  which allows to bypass the guest page cache. This also
> > > >  implements a VIRTIO based asynchronous flush mechanism.
> > >
> > > Hmmmm. Sharing the host page cache direct into the guest VM. Sounds
> > > like a good idea, but.....
> > >
> > > This means the guest VM can now run timing attacks to observe host
> > > side page cache residency, and depending on the implementation I'm
> > > guessing that the guest will be able to control host side page
> > > cache eviction, too (e.g. via discard or hole punch operations).
> > >
> > > Which means this functionality looks to me like a new vector for
> > > information leakage into and out of the guest VM via guest
> > > controlled host page cache manipulation.
> > >
> > > https://arxiv.org/pdf/1901.01161
> > >
> > > I might be wrong, but if I'm not we're going to have to be very
> > > careful about how guest VMs can access and manipulate host side
> > > resources like the page cache.....
> >
> > Right. Thinking about this I would be more concerned about the fact that
> > guest can effectively pin amount of host's page cache upto size of the
> > device/file passed to guest as PMEM, can't it Pankaj? Or is there some QEMU
> > magic that avoids this?
>
> Yes, guest will pin these host page cache pages using 'get_user_pages' by
> elevating the page reference count. But these pages can be reclaimed by host
> at any time when there is memory pressure.

Wait, how can the guest pin the host pages? I would expect this to
happen only when using vfio and device assignment. Otherwise, no the
host can't reclaim a pinned page, that's the whole point of a pin to
prevent the mm from reclaiming ownership.

> KVM does not permanently pin pages. vfio does that but we are not using
> it here.

Right, so I'm confused by your pin assertion above.
