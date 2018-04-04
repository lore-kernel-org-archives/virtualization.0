From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Wed, 4 Apr 2018 01:01:37 -0700
Message-ID: <CADGSJ23EkjBJ0soUYJ_5C4cXNGucHRjBCQKPhHjfLTuRnS0xKQ__43530.5312079892$1522828804$gmane$org@mail.gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
	<8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
	<20180403154210.GK3313@nanopsycho>
	<3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
	<20180404061945.GN3313@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180404061945.GN3313@nanopsycho>
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

On Tue, Apr 3, 2018 at 11:19 PM, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Apr 04, 2018 at 03:04:26AM CEST, dsahern@gmail.com wrote:
>>On 4/3/18 9:42 AM, Jiri Pirko wrote:
>>>>
>>>> There are other use cases that want to hide a device from userspace. I
>>>
>>> What usecases do you have in mind?
>>
>>As mentioned in a previous response some kernel drivers create control
>>netdevs. Just as in this case users should not be mucking with it, and
>
> virtio_net. Any other drivers?

netvsc if factoring out virtio_bypass to a common driver.

>
>
>>S/W like lldpd should ignore it.
>
> It's just a matter of identification of the netdevs, so the user knows
> what to do.
>
>
>>
>>>
>>>> would prefer a better solution than playing games with name prefixes and
>>>> one that includes an API for users to list all devices -- even ones
>>>> hidden by default.
>>>
>>> Netdevice hiding feels a bit scarry for me. This smells like a workaround
>>> for userspace issues. Why can't the netdevice be visible always and
>>> userspace would know what is it and what should it do with it?
>>>
>>> Once we start with hiding, there are other things related to that which
>>> appear. Like who can see what, levels of visibility etc...
>>>
>>
>>I would not advocate for any API that does not allow users to have full
>>introspection. The intent is to hide the netdev by default but have an
>>option to see it.
>
> As an administrator, I want to see all by default. I think it is
> reasonable requirements. Again, this awfully smells like a workaround...

If the requirement is just for dumping the link info i.e. perform
read-only operation on the hidden netdev, it's completely fine.
However, I am not a big fan of creating a weird mechanism to allow
user deliberately manipulate the visibility (hide/unhide) of a netdev
in any case at any time. This is subject to becoming a slippery slope
to work around any software issue that should get fixed in the right
place.

Let's treat IFF_HIDDEN as a means to hide auto-managed netdevices. If
it's just the name is misleading, I can get it renamed to something
like IFF_AUTO_MANAGED which might reflect its nature more properly.

Thanks,
-Siwei
