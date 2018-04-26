From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v8 4/4] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Wed, 25 Apr 2018 17:08:37 -0700
Message-ID: <20180425170837.6520a577__32357.5239199728$1524701213$gmane$org@xeon-e3>
References: <1524700768-38627-1-git-send-email-sridhar.samudrala@intel.com>
	<1524700768-38627-5-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1524700768-38627-5-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 25 Apr 2018 16:59:28 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> Use the registration/notification framework supported by the generic
> failover infrastructure.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

NAK unless you prove this works on legacy distributions and with DPDK 18.05
without modification.
