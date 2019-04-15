From: Yuval Shaia <yuval.shaia@oracle.com>
Subject: Re: [RFC 0/3] VirtIO RDMA
Date: Mon, 15 Apr 2019 13:35:47 +0300
Message-ID: <20190415103546.GA6854__17816.1869685695$1555718263$gmane$org@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190411190215.2163572e.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, jgg@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> On Thu, 11 Apr 2019 14:01:54 +0300
> Yuval Shaia <yuval.shaia@oracle.com> wrote:
> 
> > Data center backends use more and more RDMA or RoCE devices and more and
> > more software runs in virtualized environment.
> > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > 
> > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > technology and also because the Virtio specification
> > allows Hardware Vendors to support Virtio protocol natively in order to
> > achieve bare metal performance.
> > 
> > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > Virtio Specification and a look forward on possible implementation
> > techniques.
> > 
> > Open issues/Todo list:
> > List is huge, this is only start point of the project.
> > Anyway, here is one example of item in the list:
> > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> >   in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> >   that this is reasonable so one option is to have one for all and
> >   multiplex the traffic on it. This is not good approach as by design it
> >   introducing an optional starvation. Another approach would be multi
> >   queues and round-robin (for example) between them.
> > 
> > Expectations from this posting:
> > In general, any comment is welcome, starting from hey, drop this as it is a
> > very bad idea, to yeah, go ahead, we really want it.
> > Idea here is that since it is not a minor effort i first want to know if
> > there is some sort interest in the community for such device.
> 
> My first reaction is: Sounds sensible, but it would be good to have a
> spec for this :)
> 
> You'll need a spec if you want this to go forward anyway, so at least a
> sketch would be good to answer questions such as how many virtqueues
> you use for which purpose, what is actually put on the virtqueues,
> whether there are negotiable features, and what the expectations for
> the device and the driver are. It also makes it easier to understand
> how this is supposed to work in practice.
> 
> If folks agree that this sounds useful, the next step would be to
> reserve an id for the device type.

Thanks for the tips, will sure do that, it is that first i wanted to make
sure there is a use case here.

Waiting for any feedback from the community.

> 
> > 
> > The scope of the implementation is limited to probing the device and doing
> > some basic ibverbs commands. Data-path is not yet implemented. So with this
> > one can expect only that driver is (partialy) loaded and basic queries and
> > resource allocation is done.
> > 
> > One note regarding the patchset.
> > I know it is not standard to collaps patches from several repos as i did
> > here (qemu and linux) but decided to do it anyway so the whole picture can
> > be seen.
> > 
> > patch 1: virtio-net: Move some virtio-net-pci decl to include/hw/virtio
> > 	This is a prelimenary patch just as a hack so i will not need to
> > 	impelement new netdev
> > patch 2: hw/virtio-rdma: VirtIO rdma device
> > 	The implementation of the device
> > patch 3: RDMA/virtio-rdma: VirtIO rdma driver
> > 	The device driver
> > 
> 
