From: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Subject: Re: [virtio-dev] packed ring layout proposal - todo list
Date: Wed, 8 Mar 2017 15:09:48 +0800
Message-ID: <20170308070948.GC18844__41152.7453143664$1488957081$gmane$org@yliu-dev.sh.intel.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170222054336-mutt-send-email-mst@kernel.org>
	<20170228042943.GH18844@yliu-dev.sh.intel.com>
	<20170301030235-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170301030235-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, Maxime Coquelin <maxime.coquelin@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 01, 2017 at 03:07:29AM +0200, Michael S. Tsirkin wrote:
> On Tue, Feb 28, 2017 at 12:29:43PM +0800, Yuanhan Liu wrote:
> > Hi Michael,
> > 
> > Again, as usual, sorry for being late :/
> > 
> > On Wed, Feb 22, 2017 at 06:27:11AM +0200, Michael S. Tsirkin wrote:
> > > Stage 2: prototype guest/host drivers
> > > 
> > > At this stage we need real guest and host drivers
> > > to be able to test real life performance.
> > > I suggest dpdk drivers + munimal hack in qemu to
> > > pass features around.
> > > 
> > 
> > I have already done that in last Nov. I made a very rough (yet hacky)
> > version (only with Tx path) in one day while companying my wife in
> > hospital.
> 
> Any performance data?

A straightfoward implementation only brings 10% performance boost in a
txonly micro benchmarking. But I'm sure there are still plenty of room
for improvement.

> > If someone are interested in, I could share the code soon. I could
> > even cleanup the code a bit if necessary.
> 
> Especially if you don't have time to benchmark, I think sharing it
> might help.

Here it is (check the README-virtio-1.1 for howto):

    git://fridaybit.com/git/dpdk.git  virtio-1.1-v0.1

> > - Try to accelerate vhost/virtio with vector instructions.
> 
> That's interesting. What kind of optimizations would you say
> do vector instructions enable, and why?

If we have made the cache impact being minimum, the left thing could
be optimized is the instruction cycles. SIMD instructions (like AVX)
then should help on this.

	--yliu

> >   Something I will look into when above item is done. Currently,
> >   I thought of two items may help the vector implementation:
> > 
> >   * what kind of vring and desc layout could make the vector
> >     implementation easier.
> > 
> >   * what kind of hint we need from virtio spec for (dynamically)
> >     enabling the vector path.
> > 
> >   Besides that, I don't have too much clue yet.
> > 
> > 	--yliu
