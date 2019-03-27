From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net v3] failover: allow name change on IFF_UP slave
	interfaces
Date: Wed, 27 Mar 2019 12:11:32 +0100
Message-ID: <20190327111132.GI6979__35839.499980078$1553685107$gmane$org@nanopsycho>
References: <1553644093-10917-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1553644093-10917-1-git-send-email-si-wei.liu@oracle.com>
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
Cc: mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Wed, Mar 27, 2019 at 12:48:13AM CET, si-wei.liu@oracle.com wrote:
>When a netdev appears through hot plug then gets enslaved by a failover
>master that is already up and running, the slave will be opened
>right away after getting enslaved. Today there's a race that userspace
>(udev) may fail to rename the slave if the kernel (net_failover)
>opens the slave earlier than when the userspace rename happens.
>Unlike bond or team, the primary slave of failover can't be renamed by
>userspace ahead of time, since the kernel initiated auto-enslavement is
>unable to, or rather, is never meant to be synchronized with the rename
>request from userspace.
>
>As the failover slave interfaces are not designed to be operated
>directly by userspace apps: IP configuration, filter rules with
>regard to network traffic passing and etc., should all be done on master
>interface. In general, userspace apps only care about the
>name of master interface, while slave names are less important as long
>as admin users can see reliable names that may carry
>other information describing the netdev. For e.g., they can infer that
>"ens3nsby" is a standby slave of "ens3", while for a
>name like "eth0" they can't tell which master it belongs to.
>
>Historically the name of IFF_UP interface can't be changed because
>there might be admin script or management software that is already
>relying on such behavior and assumes that the slave name can't be
>changed once UP. But failover is special: with the in-kernel
>auto-enslavement mechanism, the userspace expectation for device
>enumeration and bring-up order is already broken. Previously initramfs
>and various userspace config tools were modified to bypass failover
>slaves because of auto-enslavement and duplicate MAC address. Similarly,
>in case that users care about seeing reliable slave name, the new type
>of failover slaves needs to be taken care of specifically in userspace
>anyway.
>
>It's less risky to lift up the rename restriction on failover slave
>which is already UP. Although it's possible this change may potentially
>break userspace component (most likely configuration scripts or
>management software) that assumes slave name can't be changed while
>UP, it's relatively a limited and controllable set among all userspace
>components, which can be fixed specifically to listen for the rename
>and/or link down/up events on failover slaves. Userspace component
>interacting with slaves is expected to be changed to operate on failover
>master interface instead, as the failover slave is dynamic in nature
>which may come and go at any point.  The goal is to make the role of
>failover slaves less relevant, and userspace components should only
>deal with failover master in the long run.
>
>Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
>Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>Reviewed-by: Liran Alon <liran.alon@oracle.com>
>
>--
>v1 -> v2:
>- Drop configurable module parameter (Sridhar)
>
>v2 -> v3:
>- Drop additional IFF_SLAVE_RENAME_OK flag (Sridhar)
>- Send down and up events around rename (Michael S. Tsirkin)
>---
> net/core/dev.c | 37 ++++++++++++++++++++++++++++++++++---
> 1 file changed, 34 insertions(+), 3 deletions(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 722d50d..3e0cd80 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -1171,6 +1171,7 @@ int dev_get_valid_name(struct net *net, struct net_device *dev,
> int dev_change_name(struct net_device *dev, const char *newname)
> {
> 	unsigned char old_assign_type;
>+	bool reopen_needed = false;
> 	char oldname[IFNAMSIZ];
> 	int err = 0;
> 	int ret;
>@@ -1180,8 +1181,24 @@ int dev_change_name(struct net_device *dev, const char *newname)
> 	BUG_ON(!dev_net(dev));
> 
> 	net = dev_net(dev);
>-	if (dev->flags & IFF_UP)
>-		return -EBUSY;
>+
>+	/* Allow failover slave to rename even when
>+	 * it is up and running.
>+	 *
>+	 * Failover slaves are special, since userspace
>+	 * might rename the slave after the interface
>+	 * has been brought up and running due to
>+	 * auto-enslavement.
>+	 *
>+	 * Failover users don't actually care about slave
>+	 * name change, as they are only expected to operate
>+	 * on master interface directly.
>+	 */
>+	if (dev->flags & IFF_UP) {
>+		if (likely(!(dev->priv_flags & IFF_FAILOVER_SLAVE)))
>+			return -EBUSY;
>+		reopen_needed = true;
>+	}
> 
> 	write_seqcount_begin(&devnet_rename_seq);
> 
>@@ -1198,6 +1215,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
> 		return err;
> 	}
> 
>+	if (reopen_needed)
>+		dev_close(dev);

Ugh. Don't dev_close/dev_open on name change.


>+
> 	if (oldname[0] && !strchr(oldname, '%'))
> 		netdev_info(dev, "renamed from %s\n", oldname);
> 
>@@ -1210,7 +1230,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
> 		memcpy(dev->name, oldname, IFNAMSIZ);
> 		dev->name_assign_type = old_assign_type;
> 		write_seqcount_end(&devnet_rename_seq);
>-		return ret;
>+		if (err >= 0)
>+			err = ret;
>+		goto reopen;
> 	}
> 
> 	write_seqcount_end(&devnet_rename_seq);
>@@ -1246,6 +1268,15 @@ int dev_change_name(struct net_device *dev, const char *newname)
> 		}
> 	}
> 
>+reopen:
>+	if (reopen_needed) {
>+		ret = dev_open(dev);
>+		if (ret) {
>+			pr_err("%s: reopen device failed: %d\n",
>+			       dev->name, ret);
>+		}
>+	}
>+
> 	return err;
> }
> 
>-- 
>1.8.3.1
>
