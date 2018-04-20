From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Fri, 20 Apr 2018 11:46:24 -0400 (EDT)
Message-ID: <20180420.114624.2233758174346347966.davem__16225.5527022809$1524239088$gmane$org@davemloft.net>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420082802.6ca37e4c@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stephen@networkplumber.org
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 20 Apr 2018 08:28:02 -0700

> On Thu, 19 Apr 2018 18:42:04 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
>> Use the registration/notification framework supported by the generic
>> failover infrastructure.
>> 
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Do what you want to other devices but leave netvsc alone.
> Adding these failover ops does not reduce the code size, and really is
> no benefit.  The netvsc device driver needs to be backported to several
> other distributions and doing this makes that harder.
> 
> I will NAK patches to change to common code for netvsc especially the
> three device model.  MS worked hard with distro vendors to support transparent
> mode, ans we really can't have a new model; or do backport.
> 
> Plus, DPDK is now dependent on existing model.

Stephen, I understand your situation.

But the result we have now is undesirable and it happened because MS
worked with distro vendors on this rather than the upstream community
and entities with other device with similar needs.

Please next time do the latter rather than the former.

Thank you.
