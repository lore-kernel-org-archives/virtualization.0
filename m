From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Wed, 20 Dec 2017 14:33:34 -0800
Message-ID: <20171220143140.0a3dc7f1__48995.1311996721$1513809127$gmane$org@cakuba.netronome.com>
References: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, alexander.duyck@gmail.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 Dec 2017 16:40:36 -0800, Sridhar Samudrala wrote:
> +static int virtio_netdev_event(struct notifier_block *this,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +
> +	/* Skip our own events */
> +	if (event_dev->netdev_ops == &virtnet_netdev)
> +		return NOTIFY_DONE;

I wonder how does this work WRT loop prevention.  What if I have two
virtio devices with the same MAC, what is preventing them from claiming
each other?  Is it only the check above (not sure what is "own" in
comment referring to)?

I'm worried the check above will not stop virtio from enslaving hyperv
interfaces and vice versa, potentially leading to a loop, no?  There is
also the fact that it would be preferable to share the code between
paravirt drivers, to avoid duplicated bugs.

My suggestion during the previous discussion was to create a paravirt
bond device, which will explicitly tell the OS which interfaces to
bond, regardless of which driver they're using.  Could be some form of
ACPI/FW driver too, I don't know enough about x86 FW to suggest
something fully fleshed :(
