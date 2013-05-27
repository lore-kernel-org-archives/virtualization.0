From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] qemu: use virtio linux headers in
	portable code
Date: Mon, 27 May 2013 20:45:31 +0930
Message-ID: <87ehcsptbg.fsf@rustcorp.com.au>
References: <1369581694-1655-1-git-send-email-mst@redhat.com>
	<CAFEAcA9stW6xv3mr0ouMVTcDfVE=4=_OcUuZscguJkzGFY9WKg@mail.gmail.com>
	<20130526175110.GA3115@redhat.com>
	<CAFEAcA9HW6=F7QKpuof02hGTaAnLsZmoZ_-Yo98wKzeELi_zvA@mail.gmail.com>
	<20130526181017.GB3115@redhat.com> <51A253C6.7060303@redhat.com>
	<20130526183747.GB3427@redhat.com> <51A25A2D.8030700@redhat.com>
	<20130526200251.GA4305@redhat.com>
	<51A26E95.5000207@redhat.com> <878v314gb2.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <878v314gb2.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Bryan Venteicher <mr.kodiak@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <anthony@codemonkey.ws> writes:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> Il 26/05/2013 22:02, Michael S. Tsirkin ha scritto:
>>> > My fault.  I should have looked at linux/types.h (actually asm-generic/).
>>> 
>>> Not really, __uX appear in the headers that were posted.
>
> Which is a problem because this is a reserved namespace in C99.

Personally, I find it hard to care.  What matters is not what the
standard has carved out, but whether we have clashes, reserved namespace
or no.  And that won't happen for these.

If someone wants to convert all the kernel headers, I won't NAK it
though.

> Perhaps it's even worth moving the headers from uapi/linux to
> uapi/virtio.  Rusty, what do you think?

Hmm, #include <virtio/virtio_net.h> etc would be worthwhile if that also
worked on FreeBSD.  Bryan CC'd...

Cheers,
Rusty.
