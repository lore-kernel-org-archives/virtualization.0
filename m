From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] qemu: use virtio linux headers in
	portable code
Date: Sun, 26 May 2013 15:49:53 -0500
Message-ID: <878v314gb2.fsf@codemonkey.ws>
References: <1369581694-1655-1-git-send-email-mst@redhat.com>
	<CAFEAcA9stW6xv3mr0ouMVTcDfVE=4=_OcUuZscguJkzGFY9WKg@mail.gmail.com>
	<20130526175110.GA3115@redhat.com>
	<CAFEAcA9HW6=F7QKpuof02hGTaAnLsZmoZ_-Yo98wKzeELi_zvA@mail.gmail.com>
	<20130526181017.GB3115@redhat.com> <51A253C6.7060303@redhat.com>
	<20130526183747.GB3427@redhat.com> <51A25A2D.8030700@redhat.com>
	<20130526200251.GA4305@redhat.com> <51A26E95.5000207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51A26E95.5000207@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 26/05/2013 22:02, Michael S. Tsirkin ha scritto:
>> > My fault.  I should have looked at linux/types.h (actually asm-generic/).
>> 
>> Not really, __uX appear in the headers that were posted.

Which is a problem because this is a reserved namespace in C99.

>> What I'm saying is - a chance of a conflict is very remote,
>> if it happens it's a build failure so easy to debug.
>
> I'm sure that others will complain, :) but you can go ahead.

I think we should clean up the virtio headers in the kernel first.
Seems like a good thing to do given the standardization effort too.

There are lots of headers in uapi that use the C99 int types so there
doesn't seem to be a reason they couldn't be used in virtio.  fuse.h
even has a:

    #ifdef __KERNEL__
    #include <linux/types.h>
    #else
    #include <stdint.h>
    #endif

Which seems like a reasonable thing to do.

The only other kernel dependency is linux/if_ether.h to define
ETH_ALEN.  But it seems completely reasonable to define a
VIRTIO_NET_MAC_ALEN or something like that.

This would make the virtio headers completely stand alone and includable
in userspace (without violating C99).

Perhaps it's even worth moving the headers from uapi/linux to
uapi/virtio.  Rusty, what do you think?

Regards,

Anhtony Liguori

>
> Paolo
