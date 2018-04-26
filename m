From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v8 4/4] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Thu, 26 Apr 2018 05:30:05 +0300
Message-ID: <20180426052908-mutt-send-email-mst__35953.6896147349$1524709696$gmane$org@kernel.org>
References: <1524700768-38627-1-git-send-email-sridhar.samudrala@intel.com>
	<1524700768-38627-5-git-send-email-sridhar.samudrala@intel.com>
	<20180425170837.6520a577@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180425170837.6520a577@xeon-e3>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 25, 2018 at 05:08:37PM -0700, Stephen Hemminger wrote:
> On Wed, 25 Apr 2018 16:59:28 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > failover infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> NAK unless you prove this works on legacy distributions and with DPDK 18.05
> without modification.

It looks like it should work. What kind of proof are you looking for?

-- 
MST
