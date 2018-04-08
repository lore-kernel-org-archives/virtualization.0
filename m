From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Sun, 08 Apr 2018 12:32:07 -0400 (EDT)
Message-ID: <20180408.123207.2294740686493951200.davem__44701.0476062589$1523205020$gmane$org@davemloft.net>
References: <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
	<20180404.133749.1802514210170809419.davem@davemloft.net>
	<CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: loseweigh@gmail.com
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, dsahern@gmail.com, si-wei.liu@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 6 Apr 2018 19:32:05 -0700

> And I assume everyone here understands the use case for live
> migration (in the context of providing cloud service) is very
> different, and we have to hide the netdevs. If not, I'm more than
> happy to clarify.

I think you still need to clarify.

netdevs are netdevs.  If they have special attributes, mark them as
such and the tools base their actions upon that.

"Hiding", or changing classes, doesn't make any sense to me still.
