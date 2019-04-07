From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net v6] failover: allow name change on IFF_UP slave
	interfaces
Date: Sun, 7 Apr 2019 08:41:52 -0700
Message-ID: <20190407084152.392955f9@shemminger-XPS-13-9360>
References: <1554267167-17561-1-git-send-email-si-wei.liu@oracle.com>
	<20190405144701.25a6b55b@shemminger-XPS-13-9360>
	<20190405175429-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190405175429-mutt-send-email-mst@kernel.org>
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
Cc: jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 5 Apr 2019 18:01:43 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> > 
> > This notifier is not really necessary, there already is a CHANGENAME
> > that gets sent.
> > NETDEV_CHANGE is used in other cases to mean that the state (flags)
> > have changed.  
> 
> The point is some existing scripts might not expect name
> change to happen without a status change afterwards (since it was
> impossible for so long). So this reports a change
> to make sure scripts do not miss it.


I don't think it matters because if device named is changed and it
is down (!IFF_UP) then only CHANGENAME is sent. The NETDEV_CHANGE is
just noise to an application.
