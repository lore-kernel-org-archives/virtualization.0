From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net v6] failover: allow name change on IFF_UP slave
	interfaces
Date: Fri, 5 Apr 2019 14:47:01 -0700
Message-ID: <20190405144701.25a6b55b__26632.1388933406$1554500891$gmane$org@shemminger-XPS-13-9360>
References: <1554267167-17561-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1554267167-17561-1-git-send-email-si-wei.liu@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  3 Apr 2019 00:52:47 -0400
Si-Wei Liu <si-wei.liu@oracle.com> wrote:

>  
> +	if (unlikely(dev->flags & IFF_UP)) {
> +		struct netdev_notifier_change_info change_info = {
> +			.info.dev = dev,
> +		};
> +
> +		call_netdevice_notifiers_info(NETDEV_CHANGE,
> +					      &change_info.info);
> +	}

This notifier is not really necessary, there already is a CHANGENAME
that gets sent.

NETDEV_CHANGE is used in other cases to mean that the state (flags)
have changed.
