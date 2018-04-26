From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v8 4/4] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Thu, 26 Apr 2018 15:33:26 -0700
Message-ID: <20180426153326.16388dfd__34706.6609458581$1524781899$gmane$org@xeon-e3>
References: <1524700768-38627-1-git-send-email-sridhar.samudrala@intel.com>
	<1524700768-38627-5-git-send-email-sridhar.samudrala@intel.com>
	<20180425170837.6520a577@xeon-e3>
	<20180426052908-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426052908-mutt-send-email-mst@kernel.org>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 26 Apr 2018 05:30:05 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 25, 2018 at 05:08:37PM -0700, Stephen Hemminger wrote:
> > On Wed, 25 Apr 2018 16:59:28 -0700
> > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> >   
> > > Use the registration/notification framework supported by the generic
> > > failover infrastructure.
> > > 
> > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>  
> > 
> > NAK unless you prove this works on legacy distributions and with DPDK 18.05
> > without modification.  
> 
> It looks like it should work. What kind of proof are you looking for?
> 


I tried this with working Ubuntu 17 on WS2016.
It boots if the failover driver is configured in (as module).
But if the configuration has:

$ grep FAILOVER .config
# CONFIG_NET_FAILOVER is not set
CONFIG_MAY_USE_NET_FAILOVER=y


The netvsc driver fails on boot with:

[    0.826447] hv_vmbus: registering driver hv_netvsc
[    0.829616] scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
[    0.836291] input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:045E:0621.0001/input/input1
[    0.839139] hid-generic 0006:045E:0621.0001: input: <UNKNOWN> HID v0.01 Mouse [Microsoft Vmbus HID-compliant Mouse] on
[    0.964897] hv_vmbus: probe failed for device 849a776e-8120-4e4a-9a36-7e3d95ac75b3 (-95)
[    0.968039] hv_netvsc: probe of 849a776e-8120-4e4a-9a36-7e3d95ac75b3 failed with error -95
[    1.112877] hv_vmbus: probe failed for device 53557f8e-057d-425b-9265-01c0fd7e273e (-95)
[    1.116064] hv_netvsc: probe of 53557f8e-057d-425b-9265-01c0fd7e273e failed with error -95

The system has two virtual networks. eth0 is on vswitch for management.
eth1 is on vswitch with SR-IOV for performance tests.

You probably need to just put the failover part in net/core and select it.


It is trivial to get an evaluation version of Windows Server 2016 and setup a Linux VM.
Please try it.
