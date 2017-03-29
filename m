From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal - todo list
Date: Wed, 29 Mar 2017 15:39:20 +0300
Message-ID: <20170329123920.GA21803@redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170222054336-mutt-send-email-mst@kernel.org>
	<20170228042943.GH18844@yliu-dev.sh.intel.com>
	<20170301030235-mutt-send-email-mst@kernel.org>
	<20170308070948.GC18844@yliu-dev.sh.intel.com>
	<20170308075624.GF18844@yliu-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170308075624.GF18844@yliu-dev.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: virtio-dev@lists.oasis-open.org, Maxime Coquelin <maxime.coquelin@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 08, 2017 at 03:56:24PM +0800, Yuanhan Liu wrote:
> On Wed, Mar 08, 2017 at 03:09:48PM +0800, Yuanhan Liu wrote:
> > On Wed, Mar 01, 2017 at 03:07:29AM +0200, Michael S. Tsirkin wrote:
> > > On Tue, Feb 28, 2017 at 12:29:43PM +0800, Yuanhan Liu wrote:
> > > > Hi Michael,
> > > > 
> > > > Again, as usual, sorry for being late :/
> > > > 
> > > > On Wed, Feb 22, 2017 at 06:27:11AM +0200, Michael S. Tsirkin wrote:
> > > > > Stage 2: prototype guest/host drivers
> > > > > 
> > > > > At this stage we need real guest and host drivers
> > > > > to be able to test real life performance.
> > > > > I suggest dpdk drivers + munimal hack in qemu to
> > > > > pass features around.
> > > > > 
> > > > 
> > > > I have already done that in last Nov. I made a very rough (yet hacky)
> > > > version (only with Tx path) in one day while companying my wife in
> > > > hospital.
> > > 
> > > Any performance data?
> > 
> > A straightfoward implementation only brings 10% performance boost in a
> > txonly micro benchmarking. But I'm sure there are still plenty of room
> > for improvement.
> > 
> > > > If someone are interested in, I could share the code soon. I could
> > > > even cleanup the code a bit if necessary.
> > > 
> > > Especially if you don't have time to benchmark, I think sharing it
> > > might help.
> > 
> > Here it is (check the README-virtio-1.1 for howto):
> > 
> >     git://fridaybit.com/git/dpdk.git  virtio-1.1-v0.1
> 
> Well, I was told it maybe not proper to share code like this way. So
> this channel is closed. I will check how to find a proper way. Sorry
> for the inconvenience!
> 
> 	--yliu

Where you going to re-post it?
I don't see what the issue could be frankly.
Care to elaborate?

-- 
MST
