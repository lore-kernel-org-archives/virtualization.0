From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v3] failover: allow name change on IFF_UP slave
	interfaces
Date: Wed, 27 Mar 2019 09:25:39 -0400
Message-ID: <20190327092424-mutt-send-email-mst__19995.7916092657$1553693154$gmane$org@kernel.org>
References: <1553644093-10917-1-git-send-email-si-wei.liu@oracle.com>
	<20190326191342.11f0cb55@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190326191342.11f0cb55@shemminger-XPS-13-9360>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 26, 2019 at 07:13:42PM -0700, Stephen Hemminger wrote:
> On Tue, 26 Mar 2019 19:48:13 -0400
> Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> 
> > When a netdev appears through hot plug then gets enslaved by a failover
> > master that is already up and running, the slave will be opened
> > right away after getting enslaved. Today there's a race that userspace
> > (udev) may fail to rename the slave if the kernel (net_failover)
> > opens the slave earlier than when the userspace rename happens.
> > Unlike bond or team, the primary slave of failover can't be renamed by
> > userspace ahead of time, since the kernel initiated auto-enslavement is
> > unable to, or rather, is never meant to be synchronized with the rename
> > request from userspace.
> > 
> > As the failover slave interfaces are not designed to be operated
> > directly by userspace apps: IP configuration, filter rules with
> > regard to network traffic passing and etc., should all be done on master
> > interface. In general, userspace apps only care about the
> > name of master interface, while slave names are less important as long
> > as admin users can see reliable names that may carry
> > other information describing the netdev. For e.g., they can infer that
> > "ens3nsby" is a standby slave of "ens3", while for a
> > name like "eth0" they can't tell which master it belongs to.
> > 
> > Historically the name of IFF_UP interface can't be changed because
> > there might be admin script or management software that is already
> > relying on such behavior and assumes that the slave name can't be
> > changed once UP. But failover is special: with the in-kernel
> > auto-enslavement mechanism, the userspace expectation for device
> > enumeration and bring-up order is already broken. Previously initramfs
> > and various userspace config tools were modified to bypass failover
> > slaves because of auto-enslavement and duplicate MAC address. Similarly,
> > in case that users care about seeing reliable slave name, the new type
> > of failover slaves needs to be taken care of specifically in userspace
> > anyway.
> > 
> > It's less risky to lift up the rename restriction on failover slave
> > which is already UP. Although it's possible this change may potentially
> > break userspace component (most likely configuration scripts or
> > management software) that assumes slave name can't be changed while
> > UP, it's relatively a limited and controllable set among all userspace
> > components, which can be fixed specifically to listen for the rename
> > and/or link down/up events on failover slaves. Userspace component
> > interacting with slaves is expected to be changed to operate on failover
> > master interface instead, as the failover slave is dynamic in nature
> > which may come and go at any point.  The goal is to make the role of
> > failover slaves less relevant, and userspace components should only
> > deal with failover master in the long run.
> > 
> > Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Reviewed-by: Liran Alon <liran.alon@oracle.com>
> 
> 
> Why do you need to do dev_close/dev_open which will bounce
> the link?

What we need is notify userspace that link went up/down.
close/open will do that but just sending notifications
would do that as well without playing with link states.

-- 
MST
