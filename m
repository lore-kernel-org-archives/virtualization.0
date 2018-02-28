From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Wed, 28 Feb 2018 20:25:01 +0100
Message-ID: <20180228192501.GB2389@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180220104224.GA2031@nanopsycho>
	<CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
	<20180227084959.GB2005@nanopsycho>
	<CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
	<20180227134149.2bff667e@cakuba.netronome.com>
	<20180228070839.GA19654@nanopsycho>
	<20180228160647-mutt-send-email-mst@kernel.org>
	<20180228151131.GF19654@nanopsycho>
	<20180228174449-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180228174449-mutt-send-email-mst@kernel.org>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Wed, Feb 28, 2018 at 04:45:39PM CET, mst@redhat.com wrote:
>On Wed, Feb 28, 2018 at 04:11:31PM +0100, Jiri Pirko wrote:
>> Wed, Feb 28, 2018 at 03:32:44PM CET, mst@redhat.com wrote:
>> >On Wed, Feb 28, 2018 at 08:08:39AM +0100, Jiri Pirko wrote:
>> >> Tue, Feb 27, 2018 at 10:41:49PM CET, kubakici@wp.pl wrote:
>> >> >On Tue, 27 Feb 2018 13:16:21 -0800, Alexander Duyck wrote:
>> >> >> Basically we need some sort of PCI or PCIe topology mapping for the
>> >> >> devices that can be translated into something we can communicate over
>> >> >> the communication channel. 
>> >> >
>> >> >Hm.  This is probably a completely stupid idea, but if we need to
>> >> >start marshalling configuration requests/hints maybe the entire problem
>> >> >could be solved by opening a netlink socket from hypervisor?  Even make
>> >> >teamd run on the hypervisor side...
>> >> 
>> >> Interesting. That would be more trickier then just to fwd 1 genetlink
>> >> socket to the hypervisor.
>> >> 
>> >> Also, I think that the solution should handle multiple guest oses. What
>> >> I'm thinking about is some generic bonding description passed over some
>> >> communication channel into vm. The vm either use it for configuration,
>> >> or ignores it if it is not smart enough/updated enough.
>> >
>> >For sure, we could build virtio-bond to pass that info to guests.
>> 
>> What do you mean by "virtio-bond". virtio_net extension?
>
>I mean a new device supplying topology information to guests,
>with updates whenever VMs are started, stopped or migrated.

Good. Any idea how that device would look like? Also, any idea how to
handle in in kernel and how to pass along this info to userspace?
Is there anything similar out there?

Thanks!
