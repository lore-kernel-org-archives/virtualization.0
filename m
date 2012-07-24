From: Dor Laor <dlaor@redhat.com>
Subject: Re: [RFC 0/2] virtio: provide a way for host to monitor critical
	events in the device
Date: Tue, 24 Jul 2012 11:26:30 +0300
Message-ID: <500E5C36.2070601@redhat.com>
References: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
	<87a9yprc4v.fsf@rustcorp.com.au>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87a9yprc4v.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: wency@cn.fujitsu.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, penberg@kernel.org, Sasha Levin <levinsasha928@gmail.com>, anthony@codemonkey.ws, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/24/2012 07:55 AM, Rusty Russell wrote:
> On Mon, 23 Jul 2012 22:32:39 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
>> As it was discussed recently, there's currently no way for the guest to notify
>> the host about panics. Further more, there's no reasonable way to notify the
>> host of other critical events such as an OOM kill.
>
> I clearly missed the discussion.  Is this actually useful?  In practice,

Admit this is not a killer feature..

> won't you want the log from the guest?  What makes a virtual guest
> different from a physical guest?

Most times virt guest can do better than a physical OS. In that sense, 
this is where virtualization shines (live migration, hotplug for any 
virtual resource including net/block/cpu/memory/..).

There are plenty of niche but worth while small features such as the 
virtio-trace series and other that allow the host/virt-mgmt to get more 
insight into the guest w/o a need to configure the guest.

In theory guest OOM can trigger a host memory hot plug action. Again, I 
don't see it as a key feature..

>
> Guest watchdog functionality might be useful, but that's simpler to

There is already a fully emulated watchdog device in qemu.
Cheers,
Dor

> implement via a virtio watchdog device, and more effective to implement
> via a host facility that actually pings guest functionality (rather than
> the kernel).
>
> Cheers,
> Rusty.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
