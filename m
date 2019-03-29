From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net v4] failover: allow name change on IFF_UP slave
	interfaces
Date: Fri, 29 Mar 2019 08:15:12 -0700
Message-ID: <20190329081512.2f231508__40028.7453363248$1553872540$gmane$org@shemminger-XPS-13-9360>
References: <1553816847-28121-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1553816847-28121-1-git-send-email-si-wei.liu@oracle.com>
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

On Thu, 28 Mar 2019 19:47:27 -0400
Si-Wei Liu <si-wei.liu@oracle.com> wrote:

> +	if (unlikely(dev->flags & IFF_UP)) {
> +		struct netdev_notifier_change_info change_info;
> +
> +		change_info.flags_changed = 0;

Simpler to use structure initialization, which also avoid any chance
of unititialized fields.

		struct netdev_notifier_change_info change_info
			= { .flags_changed =  0 };
