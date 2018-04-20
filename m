From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 net-next 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Fri, 20 Apr 2018 05:46:15 +0300
Message-ID: <20180420054538-mutt-send-email-mst__45558.340175967$1524192277$gmane$org@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-4-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524188524-28411-4-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 19, 2018 at 06:42:03PM -0700, Sridhar Samudrala wrote:
> @@ -3010,6 +3043,7 @@ static __init int virtio_net_driver_init(void)
>          ret = register_virtio_driver(&virtio_net_driver);
>  	if (ret)
>  		goto err_virtio;
> +
>  	return 0;
>  err_virtio:
>  	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);

I'd rather you didn't let's not mix in whitespace changes.

> -- 
> 2.14.3
