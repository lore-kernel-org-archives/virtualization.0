From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v12 0/5] Enable virtio_net to act as a standby
	for a passthru device
Date: Mon, 28 May 2018 23:00:28 -0400 (EDT)
Message-ID: <20180528.230028.115699846124143924.davem__23828.7216904157$1527562731$gmane$org@davemloft.net>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sridhar.samudrala@intel.com
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com
List-Id: virtualization@lists.linuxfoundation.org

From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 24 May 2018 09:55:12 -0700

> The main motivation for this patch is to enable cloud service providers
> to provide an accelerated datapath to virtio-net enabled VMs in a 
> transparent manner with no/minimal guest userspace changes. This also
> enables hypervisor controlled live migration to be supported with VMs that
> have direct attached SR-IOV VF devices.
 ...

Series applied, thank you.
