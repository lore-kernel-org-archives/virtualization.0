From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Thu, 28 Feb 2019 09:26:06 -0500
Message-ID: <20190228091119-mutt-send-email-mst__27709.1645448067$1551364655$gmane$org@kernel.org>
References: <20190222100753-mutt-send-email-mst@kernel.org>
	<e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
	<20190225210529-mutt-send-email-mst@kernel.org>
	<d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
	<20190227173710-mutt-send-email-mst@kernel.org>
	<c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
	<20190227184601-mutt-send-email-mst@kernel.org>
	<a617ce13-4114-469d-ef33-a1c91150eeca@oracle.com>
	<20190227193923-mutt-send-email-mst@kernel.org>
	<36901346-e3d5-4e51-6a8d-678eb5b9e352@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <36901346-e3d5-4e51-6a8d-678eb5b9e352@oracle.com>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 28, 2019 at 01:32:12AM -0800, si-wei liu wrote:
> > > Will the
> > > change break userspace further?
> > > 
> > > -Siwei
> > Didn't you show userspace is already broken. You can't "further
> > break it", rename already fails.
> It's a race, userspace tends to give slave a user(space) desired name but
> sometimes may fail due to this race. Today if failover master is not up,
> rename would succeed anyway. While what you proposed prohibits user from
> providing a name in all circumstances if I understand you correctly. That's
> what I meant of breaking userspace further. On the other hand, you seem to
> tighten the kernel default naming to udev predictable names, which is
> derived from only recent systemd-udevd, while there exists many possible
> userspace naming schemes out of that. Users today who deliberately chooses
> to disable predictable naming (net.ifnames=0 biosdevname=0) and fall back to
> kernel provided names would expect the ethX pattern, with this change
> admin/user scripts which matches the ethX pattern could potentially break.

Whatever crashes with a name not matching ethX will crash on the
standby interface *anyway*.

So I think what you are saying is that someone might have already
written scripts and gotten them to work on v4.17 when STANDBY was
included and these scripts rely on ethX. Now these scripts
will break.

Maybe it is still early enough (just half a year passed) that the
number of these users would be small.  So how about a kernel config
option and maybe a module parameter to rename the primary?  People can
then opt in to the old broken behaviour.

-- 
MST
