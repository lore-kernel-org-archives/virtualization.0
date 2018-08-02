From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Thu, 2 Aug 2018 18:18:49 +0300
Message-ID: <20180802181309-mutt-send-email-mst__10983.6444994018$1533223011$gmane$org@kernel.org>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
	<1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
	<20180730090041.GC24267@dhcp22.suse.cz>
	<5B619599.1000307@intel.com>
	<20180801113444.GK16767@dhcp22.suse.cz>
	<5B62DDCC.3030100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5B62DDCC.3030100@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 02, 2018 at 06:32:44PM +0800, Wei Wang wrote:
> On 08/01/2018 07:34 PM, Michal Hocko wrote:
> > On Wed 01-08-18 19:12:25, Wei Wang wrote:
> > > On 07/30/2018 05:00 PM, Michal Hocko wrote:
> > > > On Fri 27-07-18 17:24:55, Wei Wang wrote:
> > > > > The OOM notifier is getting deprecated to use for the reasons mentioned
> > > > > here by Michal Hocko: https://lkml.org/lkml/2018/7/12/314
> > > > > 
> > > > > This patch replaces the virtio-balloon oom notifier with a shrinker
> > > > > to release balloon pages on memory pressure.
> > > > It would be great to document the replacement. This is not a small
> > > > change...
> > > OK. I plan to document the following to the commit log:
> > > 
> > >    The OOM notifier is getting deprecated to use for the reasons:
> > >      - As a callout from the oom context, it is too subtle and easy to
> > >        generate bugs and corner cases which are hard to track;
> > >      - It is called too late (after the reclaiming has been performed).
> > >        Drivers with large amuont of reclaimable memory is expected to be
> > >        released them at an early age of memory pressure;
> > >      - The notifier callback isn't aware of the oom contrains;
> > >      Link: https://lkml.org/lkml/2018/7/12/314
> > > 
> > >      This patch replaces the virtio-balloon oom notifier with a shrinker
> > >      to release balloon pages on memory pressure. Users can set the amount of
> > >      memory pages to release each time a shrinker_scan is called via the
> > >      module parameter balloon_pages_to_shrink, and the default amount is 256
> > >      pages. Historically, the feature VIRTIO_BALLOON_F_DEFLATE_ON_OOM has
> > >      been used to release balloon pages on OOM. We continue to use this
> > >      feature bit for the shrinker, so the shrinker is only registered when
> > >      this feature bit has been negotiated with host.
> > Do you have any numbers for how does this work in practice?
> 
> It works in this way: for example, we can set the parameter,
> balloon_pages_to_shrink, to shrink 1GB memory once shrink scan is called.
> Now, we have a 8GB guest, and we balloon out 7GB. When shrink scan is
> called, the balloon driver will get back 1GB memory and give them back to
> mm, then the ballooned memory becomes 6GB.
> 
> When the shrinker scan is called the second time, another 1GB will be given
> back to mm. So the ballooned pages are given back to mm gradually.

I think what's being asked here is a description of tests that
were run. Which workloads see improved behaviour?

Our behaviour under memory pressure isn't great, in particular it is not
clear when it's safe to re-inflate the balloon, if host attempts to
re-inflate it too soon then we still get OOM. It would be better
if VIRTIO_BALLOON_F_DEFLATE_ON_OOM would somehow mean
"it's ok to ask for almost all of memory, if guest needs memory from
balloon for apps to function it can take it from the balloon".


-- 
MST
