From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
Date: Tue, 17 Apr 2018 17:26:28 -0700
Message-ID: <CADGSJ21nQ1BQctfZcThpmOcOUrpqLfG71jsh2trb1utVjNQH=Q__38859.6061071896$1524011095$gmane$org@mail.gmail.com>
References: <54accf73-e6cc-e03f-6a1c-34e1bbd78047@gmail.com>
	<20180404.133749.1802514210170809419.davem@davemloft.net>
	<CADGSJ206RKi704uoLe3xVs6PyWpURPLb75OPCM_YO9DfnnEzpw@mail.gmail.com>
	<20180408.123207.2294740686493951200.davem@davemloft.net>
	<CADGSJ233AmbBrTP-A_u3-5fkr=HUJka_xcSNWxO1HWGua1J92Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ233AmbBrTP-A_u3-5fkr=HUJka_xcSNWxO1HWGua1J92Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, si-wei liu <si-wei.liu@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

I ran this with a few folks offline and gathered some good feedbacks
that I'd like to share thus revive the discussion.

First of all, as illustrated in the reply below, cloud service
providers require transparent live migration. Specifically, the main
target of our case is to support SR-IOV live migration via kernel
upgrade while keeping the userspace of old distros unmodified. If it's
because this use case is not appealing enough for the mainline to
adopt, I will shut up and not continue discussing, although
technically it's entirely possible (and there's precedent in other
implementation) to do so to benefit any cloud service providers.

If it's just the implementation of hiding netdev itself needs to be
improved, such as implementing it as attribute flag or adding linkdump
API, that's completely fine and we can look into that. However, the
specific issue needs to be undestood beforehand is to make transparent
SR-IOV to be able to take over the name (so inherit all the configs)
from the lower netdev, which needs some games with uevents and name
space reservation. So far I don't think it's been well discussed.

One thing in particular I'd like to point out is that the 3-netdev
model currently missed to address the core problem of live migration:
migration of hardware specific feature/state, for e.g. ethtool configs
and hardware offloading states. Only general network state (IP
address, gateway, for eg.) associated with the bypass interface can be
migrated. As a follow-up work, bypass driver can/should be enhanced to
save and apply those hardware specific configs before or after
migration as needed. The transparent 1-netdev model being proposed as
part of this patch series will be able to solve that problem naturally
by making all hardware specific configurations go through the central
bypass driver, such that hardware configurations can be replayed when
new VF or passthrough gets plugged back in. Although that
corresponding function hasn't been implemented today, I'd like to
refresh everyone's mind that is the core problem any live migration
proposal should have addressed.

If it would make things more clear to defer netdev hiding until all
functionalities regarding centralizing and replay are implemented,
we'd take advices like that and move on to implementing those features
as follow-up patches. Once all needed features get done, we'd resume
the work for hiding lower netdev at that point. Think it would be the
best to make everyone understand the big picture in advance before
going too far.

Thanks, comments welcome.

-Siwei


On Mon, Apr 9, 2018 at 11:48 PM, Siwei Liu <loseweigh@gmail.com> wrote:
> On Sun, Apr 8, 2018 at 9:32 AM, David Miller <davem@davemloft.net> wrote:
>> From: Siwei Liu <loseweigh@gmail.com>
>> Date: Fri, 6 Apr 2018 19:32:05 -0700
>>
>>> And I assume everyone here understands the use case for live
>>> migration (in the context of providing cloud service) is very
>>> different, and we have to hide the netdevs. If not, I'm more than
>>> happy to clarify.
>>
>> I think you still need to clarify.
>
> OK. The short answer is cloud users really want *transparent* live migration.
>
> By being transparent it means they don't and shouldn't care about the
> existence and the occurence of live migration, but they do if
> userspace toolstack and libraries have to be updated or modified,
> which means potential dependency brokeness of their applications. They
> don't like any change to the userspace envinroment (existing apps
> lift-and-shift, no recompilation, no re-packaging, no re-certification
> needed), while no one barely cares about ABI or API compatibility in
> the kernel level, as long as their applications don't break.
>
> I agree the current bypass solution for SR-IOV live migration requires
> guest cooperation. Though it doesn't mean guest *userspace*
> cooperation. As a matter of fact, techinically it shouldn't invovle
> userspace at all to get SR-IOV migration working. It's the kernel that
> does the real work. If I understand the goal of this in-kernel
> approach correctly, it was meant to save userspace from modification
> or corresponding toolstack support, as those additional 2 interfaces
> is more a side product of this approach, rather than being neccessary
> for users to be aware of. All what the user needs to deal with is one
> single interface, and that's what they care about. It's more a trouble
> than help when they see 2 extra interfaces are present. Management
> tools in the old distros don't recoginze them and try to bring up
> those extra interfaces for its own. Various odd warnings start to spew
> out, and there's a lot of caveats for the users to get around...
>
> On the other hand, if we "teach" those cloud users to update the
> userspace toolstack just for trading a feature they don't need, no one
> is likely going to embrace the change. As such there's just no real
> value of adopting this in-kernel bypass facility for any cloud service
> provider. It does not look more appealing than just configure generic
> bonding using its own set of daemons or scripts. But again, cloud
> users don't welcome that facility. And basically it would get to
> nearly the same set of problems if leaving userspace alone.
>
> IMHO we're not hiding the devices, think it the way we're adding a
> feature transparent to user. Those auto-managed slaves are ones users
> don't care about much. And user is still able to see and configure the
> lower netdevs if they really desires to do so. But generally the
> target user for this feature won't need to know that. Why they care
> how many interfaces a VM virtually has rather than how many interfaces
> are actually _useable_ to them??
>
> Thanks,
> -Siwei
>
>
>>
>> netdevs are netdevs.  If they have special attributes, mark them as
>> such and the tools base their actions upon that.
>>
>> "Hiding", or changing classes, doesn't make any sense to me still.
