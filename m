From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v3] failover: allow name change on IFF_UP slave
	interfaces
Date: Wed, 27 Mar 2019 18:16:23 -0400
Message-ID: <20190327181433-mutt-send-email-mst__35687.943587412$1553724999$gmane$org@kernel.org>
References: <1553644093-10917-1-git-send-email-si-wei.liu@oracle.com>
	<20190326191342.11f0cb55@shemminger-XPS-13-9360>
	<20190327092424-mutt-send-email-mst@kernel.org>
	<f90d9dfa-f2f1-ff04-f3fe-88fa0deffdf7@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f90d9dfa-f2f1-ff04-f3fe-88fa0deffdf7@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: si-wei liu <si-wei.liu@oracle.com>
Cc: jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2019 at 01:10:10PM -0700, si-wei liu wrote:
> Another less safer option is that we just notify userspace anyway without
> sending down/up event around, as I don't see *any real application* cares
> about the link state or whatsoever when it attempts to detect rename.

How do you write a race ree handler then? ATM just detecting link up is
sufficient and covers 100% of cases. Seems like a good idea to keep it
that way.

-- 
MST
