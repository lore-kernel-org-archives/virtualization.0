From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Tue, 3 Apr 2018 12:23:56 -0700
Message-ID: <CADGSJ22Hj7JWM2NY7Ben0p0O_EaVD77wdybxvtcuuiXQjvnUAA__49792.2286078849$1522783321$gmane$org@mail.gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
	<8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
	<20180403154210.GK3313@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180403154210.GK3313@nanopsycho>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Si-Wei Liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 3, 2018 at 8:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Sun, Apr 01, 2018 at 06:11:29PM CEST, dsahern@gmail.com wrote:
>>On 4/1/18 3:13 AM, Si-Wei Liu wrote:
>>> Hidden netdevice is not visible to userspace such that
>>> typical network utilites e.g. ip, ifconfig and et al,
>>> cannot sense its existence or configure it. Internally
>>> hidden netdev may associate with an upper level netdev
>>> that userspace has access to. Although userspace cannot
>>> manipulate the lower netdev directly, user may control
>>> or configure the underlying hidden device through the
>>> upper-level netdev. For identification purpose, the
>>> kobject for hidden netdev still presents in the sysfs
>>> hierarchy, however, no uevent message will be generated
>>> when the sysfs entry is created, modified or destroyed.
>>>
>>> For that end, a separate namescope needs to be carved
>>> out for IFF_HIDDEN netdevs. As of now netdev name that
>>> starts with colon i.e. ':' is invalid in userspace,
>>> since socket ioctls such as SIOCGIFCONF use ':' as the
>>> separator for ifname. The absence of namescope started
>>> with ':' can rightly be used as the namescope for
>>> the kernel-only IFF_HIDDEN netdevs.
>>>
>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>> ---
>>>  include/linux/netdevice.h   |  12 ++
>>>  include/net/net_namespace.h |   2 +
>>>  net/core/dev.c              | 281 ++++++++++++++++++++++++++++++++++++++------
>>>  net/core/net_namespace.c    |   1 +
>>>  4 files changed, 263 insertions(+), 33 deletions(-)
>>>
>>
>>There are other use cases that want to hide a device from userspace. I
>
> What usecases do you have in mind?

Hope you're not staring at me and shouting. :)

I think we had discussed a lot, and if the common goal is to merge two
drivers rather than diverge, there's no better way than to hide the
lower devices from all existing userspace management utiliies
(NetworManager, cloud-init). This does not mean loss of visibility as
we can add new API or CLI later on to get those missing ones exposed
as needed, in a way existing userspace apps don't break while new apps
aware of the feature know where to get it. This requirement is
critical to cloud providers, which I wouldn't repeat enough why it
drove me crazy if not seeing this resolved.

Thanks,
-Siwei

>
>>would prefer a better solution than playing games with name prefixes and
>>one that includes an API for users to list all devices -- even ones
>>hidden by default.
>
> Netdevice hiding feels a bit scarry for me. This smells like a workaround
> for userspace issues. Why can't the netdevice be visible always and
> userspace would know what is it and what should it do with it?
>
> Once we start with hiding, there are other things related to that which
> appear. Like who can see what, levels of visibility etc...
>
>
>>
>>https://github.com/dsahern/linux/commit/48a80a00eac284e58bae04af10a5a932dd7aee00
>>
>>https://github.com/dsahern/iproute2/commit/7563f5b26f5539960e99066e34a995d22ea908ed
>>
>>Also, why are you suggesting that the device should still be visible via
>>/sysfs? That leads to inconsistent views of networking state - /sys
>>shows a device but a link dump does not.
