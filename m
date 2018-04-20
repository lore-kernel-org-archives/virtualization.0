From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Fri, 20 Apr 2018 11:47:53 -0400 (EDT)
Message-ID: <20180420.114753.508240232662001454.davem__49535.2777689279$1524239165$gmane$org@davemloft.net>
References: <1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
	<20180420183505-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420183505-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 20 Apr 2018 18:43:54 +0300

> On Fri, Apr 20, 2018 at 08:28:02AM -0700, Stephen Hemminger wrote:
>> Plus, DPDK is now dependent on existing model.
> 
> DPDK does the kernel bypass thing, doesn't it? Why does the kernel care?

+1
