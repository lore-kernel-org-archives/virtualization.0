From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 4/7] vhost: set vring endianness for
	legacy virtio
Date: Wed, 13 May 2015 13:22:26 +0200
Message-ID: <20150513130925-mutt-send-email-mst@redhat.com>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
	<20150506120801.8607.64278.stgit@bahia.huguette.org>
	<20150512152530.4ab0c56f.cornelia.huck@de.ibm.com>
	<20150512154127-mutt-send-email-mst@redhat.com>
	<20150512182532.62d749b8.cornelia.huck@de.ibm.com>
	<20150512183719-mutt-send-email-mst@redhat.com>
	<20150513123907.5ab86cd2.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150513123907.5ab86cd2.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 13, 2015 at 12:39:07PM +0200, Cornelia Huck wrote:
> On Tue, 12 May 2015 18:40:35 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, May 12, 2015 at 06:25:32PM +0200, Cornelia Huck wrote:
> > > On Tue, 12 May 2015 17:15:53 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > One issue with virtio 1 patches as they are is with how features are
> > > > handled ATM.  There are 3 types of features
> > > > 
> > > > 	a. virtio 1 only features
> > > > 	b. virtio 0 only features
> > > > 	c. shared features
> > > > 
> > > > and 3 types of devices
> > > > 	a. legacy device: has b+c features
> > > > 	b. modern device: has a+c features
> > > > 	c. transitional device: has a+c features but exposes
> > > > 	   only c through the legacy interface
> > > 
> > > Wouldn't a transitional device be able to expose b as well?
> > 
> > No because the virtio 1 spec says it shouldn't.
> 
> Can you point me to the part where it says that? Can't seem to find it.


What I mean is that these features can't be operated through the modern
interface.
Consider the BLK SCSI command feature. If you set it you really
expect guest to be able to e.g. use your device as a cd writer.
So, a legacy guest is able to do this, but a modern guest isn't?
Doesn't sound like an expected outcome to me.


So the principle of the least surprise dictates that we
- disable the feature by default for everyone
- add flag to enable the feature, available for legacy devices only


> > > > So I think a callback that gets features depending on guest
> > > > version isn't a good way to model it because fundamentally device
> > > > has one set of features.
> > > > A better way to model this is really just a single
> > > > host_features bitmask, and for transitional devices, a mask
> > > > hiding a features - which are so far all bits > 31, so maybe
> > > > for now we can just have a global mask.
> > > 
> > > How would this work for transitional presenting a modern device - would
> > > you have a superset of bits and masks for legacy and modern?
> > 
> > Basically we expose through modern interface a superset
> > of bits exposed through legacy.
> > F_BAD for pci is probably the only exception.
> 
> ccw has F_BAD as well.

It does but it ignores it, so I think setting that bit
in host features is a bug. PCI uses it to detect very old
guests that just acked all features without looking
at them. ccw never had such guests.

> NOTIFY_ON_EMPTY is in the MAY be offered category.

Right. Current guests simply ignore this feature bit,
so I don't much care what we do with this bit as long as
- pci exposes this on the legacy interface
- we don't spend many lines of code working around that special case

> I'm still wondering about the old legacy bits. Transitional devices not
> offering them is easiest to implement from the host side, but I'm
> wondering if all legacy devices will be able to function with missing
> bits? Is breaking some legacy drivers OK?

We should add flags to re-enable them, for legacy devices only.

-- 
MST
