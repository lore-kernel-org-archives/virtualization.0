From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
	ring
Date: Thu, 11 Oct 2018 10:17:15 -0400
Message-ID: <20181011101656-mutt-send-email-mst__21356.836523819$1539267322$gmane$org@kernel.org>
References: <20180910030053.GA15645@debian>
	<f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
	<20180911053726.GA7472@debian>
	<20180912121457-mutt-send-email-mst@kernel.org>
	<20180913085919.GA42049@fbsd1.sh.intel.com>
	<98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
	<20181010103335-mutt-send-email-mst@kernel.org>
	<20181011121221.GA27106@debian>
	<20181011094705-mutt-send-email-mst@kernel.org>
	<20181011141331.GA11650@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181011141331.GA11650@debian>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 11, 2018 at 10:13:31PM +0800, Tiwei Bie wrote:
> On Thu, Oct 11, 2018 at 09:48:48AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Oct 11, 2018 at 08:12:21PM +0800, Tiwei Bie wrote:
> > > > > But if it's not too late, I second for a OUT_OF_ORDER feature.
> > > > > Starting from in order can have much simpler code in driver.
> > > > > 
> > > > > Thanks
> > > > 
> > > > It's tricky to change the flag polarity because of compatibility
> > > > with legacy interfaces. Why is this such a big deal?
> > > > 
> > > > Let's teach drivers about IN_ORDER, then if devices
> > > > are in order it will get enabled by default.
> > > 
> > > Yeah, make sense.
> > > 
> > > Besides, I have done some further profiling and debugging
> > > both in kernel driver and DPDK vhost. Previously I was mislead
> > > by a bug in vhost code. I will send a patch to fix that bug.
> > > With that bug fixed, the performance of packed ring in the
> > > test between kernel driver and DPDK vhost is better now.
> > 
> > OK, if we get a performance gain on the virtio side, we can finally
> > upstream it. If you see that please re-post ASAP so we can
> > put it in the next kernel release.
> 
> Got it, I will re-post ASAP.
> 
> Thanks!


Pls remember to include data on performance gain in the cover letter.


> 
> > 
> > -- 
> > MST
