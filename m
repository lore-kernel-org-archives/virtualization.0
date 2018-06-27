From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Wed, 27 Jun 2018 11:11:43 +0200
Message-ID: <20180627111143.32651114.cohuck@redhat.com>
References: <20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
	<20180622214259-mutt-send-email-mst@kernel.org>
	<CADGSJ22e=Sa8S-HqM4XtOa6ngBKPL73SiQRPh8PUzQgRaie5oA@mail.gmail.com>
	<20180623003022-mutt-send-email-mst@kernel.org>
	<CADGSJ22oFhP955cuTmMWeSt0UOsG5K1A--c34QUSMx5z3Up2SA@mail.gmail.com>
	<20180623012934-mutt-send-email-mst@kernel.org>
	<CADGSJ21HNd4VYNcCt4H0gJ_CCx1GUFpHrDof2N=4WqhD24Zc2A@mail.gmail.com>
	<20180626170813.4db094a1.cohuck@redhat.com>
	<20180626204312-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180626204312-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 26 Jun 2018 20:50:20 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 26, 2018 at 05:08:13PM +0200, Cornelia Huck wrote:
> > On Fri, 22 Jun 2018 17:05:04 -0700
> > Siwei Liu <loseweigh@gmail.com> wrote:
> >   
> > > On Fri, Jun 22, 2018 at 3:33 PM, Michael S. Tsirkin <mst@redhat.com> wrote:  
> > > > I suspect the diveregence will be lost on most users though
> > > > simply because they don't even care about vfio. They just
> > > > want things to go fast.    
> > > 
> > > Like Jason said, VF isn't faster than virtio-net in all cases. It
> > > depends on the workload and performance metrics: throughput, latency,
> > > or packet per second.  
> > 
> > So, will it be guest/admin-controllable then where the traffic flows
> > through? Just because we do have a vf available after negotiation of
> > the feature bit, it does not necessarily mean we want to use it? Do we
> > (the guest) even want to make it visible in that case?  
> 
> I think these ideas belong to what Alex Duyck wanted to do:
> some kind of advanced device that isn't tied to
> any network interfaces and allows workload and performance
> specific tuning.
> 
> Way out of scope for a simple failover, and more importantly,
> no one is looking at even enumerating the problems involved,
> much less solving them.

So, for simplicity's sake, we need to rely on the host admin
configuring the vm for its guest's intended use case. Sounds fair, but
probably needs a note somewhere.
