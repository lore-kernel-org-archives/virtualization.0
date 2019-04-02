From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net v5] failover: allow name change on IFF_UP slave
	interfaces
Date: Tue, 2 Apr 2019 14:53:59 -0700
Message-ID: <20190402145359.55814e11__1446.49745650298$1554242057$gmane$org@shemminger-XPS-13-9360>
References: <1554159893-29704-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1554159893-29704-1-git-send-email-si-wei.liu@oracle.com>
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

On Mon,  1 Apr 2019 19:04:53 -0400
Si-Wei Liu <si-wei.liu@oracle.com> wrote:

> +	if (dev->flags & IFF_UP &&
> +	    likely(!(dev->priv_flags & IFF_FAILOVER_SLAVE)))

Why is property limited to failover slave, it would make sense for netvsc
as well. Why not make it a flag like live address change?
