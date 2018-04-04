From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Wed, 4 Apr 2018 01:28:27 -0700
Message-ID: <CADGSJ22qmdzY8AiOfQdFdmR7T6rehTp-hHHj1U10XGad0bTb8A__25681.0828614563$1522830412$gmane$org@mail.gmail.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
	<1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
	<8b589cd2-1abc-59c2-99f1-96df8174bb6b@gmail.com>
	<20180403154210.GK3313@nanopsycho>
	<3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3bdfc39f-4935-2433-7982-9ce28c3aa166@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Ahern <dsahern@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 3, 2018 at 6:04 PM, David Ahern <dsahern@gmail.com> wrote:
> On 4/3/18 9:42 AM, Jiri Pirko wrote:
>>>
>>> There are other use cases that want to hide a device from userspace. I
>>
>> What usecases do you have in mind?
>
> As mentioned in a previous response some kernel drivers create control
> netdevs. Just as in this case users should not be mucking with it, and
> S/W like lldpd should ignore it.

I'm still not sure I understand your case: why you want to hide the
control netdev, as I assume those devices could choose either to
silently ignore the request, or fail loudly against user operations?
Is it creating issues already, or what problem you want to solve if
not making the netdev invisible. Why couldn't lldpd check some
specific flag and ignore the control netdevice (can you please give an
example of a concrete driver for control netdevice *in tree*).

And I'm completely lost why you want an API to make a hidden netdev
visible again for these control devices.

Thanks,
-Siwei


>
>>
>>> would prefer a better solution than playing games with name prefixes and
>>> one that includes an API for users to list all devices -- even ones
>>> hidden by default.
>>
>> Netdevice hiding feels a bit scarry for me. This smells like a workaround
>> for userspace issues. Why can't the netdevice be visible always and
>> userspace would know what is it and what should it do with it?
>>
>> Once we start with hiding, there are other things related to that which
>> appear. Like who can see what, levels of visibility etc...
>>
>
> I would not advocate for any API that does not allow users to have full
> introspection. The intent is to hide the netdev by default but have an
> option to see it.
