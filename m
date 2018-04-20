From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Fri, 20 Apr 2018 08:46:48 -0700
Message-ID: <9cfdc30f-6018-499e-80a8-4447601944a4__19919.5987931036$1524239099$gmane$org@intel.com>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420082802.6ca37e4c@xeon-e3>
Content-Language: en-US
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org



On 4/20/2018 8:28 AM, Stephen Hemminger wrote:
> On Thu, 19 Apr 2018 18:42:04 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> Use the registration/notification framework supported by the generic
>> failover infrastructure.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Do what you want to other devices but leave netvsc alone.
> Adding these failover ops does not reduce the code size, and really is
> no benefit.  The netvsc device driver needs to be backported to several
> other distributions and doing this makes that harder.
>
> I will NAK patches to change to common code for netvsc especially the
> three device model.  MS worked hard with distro vendors to support transparent
> mode, ans we really can't have a new model; or do backport.

failover_ops are specifically added to support both 2-netdev and 3-netdev models
This patch doesn't change netvsc model. It still keeps its 2-netdev model. From
netvsc, point of view it is just moving some code from netvsc to the failover module
and also i think the eventhandling and getbymac routines are more optimal.


> Plus, DPDK is now dependent on existing model.
