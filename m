From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Thu, 31 May 2018 21:35:59 +0300
Message-ID: <20180531212356-mutt-send-email-mst__8649.20854005522$1527791779$gmane$org@kernel.org>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
	<20180530220635.206ee6d7@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180530220635.206ee6d7@shemminger-XPS-13-9360>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 30, 2018 at 10:06:35PM -0400, Stephen Hemminger wrote:
> On Thu, 24 May 2018 09:55:14 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > failover infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Why was this merged? It was never signed off by any of the netvsc maintainers,
> and there were still issues unresolved.
> 
> There are also namespaces issues I am fixing and this breaks them.
> Will start my patch set with a revert for this. Sorry

As long as you finish the patch set with re-integrating with failover,
that's fine IMHO.

I suspect it's easier to add the code to failover though - namespace
things likely affect virtio as well. Lookup by ID would be an optional
feature for virtio, but probably a useful one - I won't ask you
to add it to virtio but it could be a mode in failover
that virtio will activate down the road. And reducing the number of
times we look cards up based on ID can only be a good thing.

-- 
MST
