From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC 0/3] VirtIO RDMA
Date: Thu, 11 Apr 2019 17:24:08 +0000
Message-ID: <20190411172402.GA14509__40208.3226524823$1555718135$gmane$org@mellanox.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190411190215.2163572e.cohuck@redhat.com>
Content-Language: en-US
Content-ID: <D48BEB556881BA44BDF61657FE88A114@eurprd05.prod.outlook.com>
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
Cc: "mst@redhat.com" <mst@redhat.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
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

I'm unclear why you'd want to have a virtio queue for anything other
that some kind of command channel.

I'm not sure a QP or CQ benefits from this??

Jason
