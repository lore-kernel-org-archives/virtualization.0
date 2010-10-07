From: devi thapa <devi.thapa@gmail.com>
Subject: Re: vhost_net_ioctl
Date: Thu, 7 Oct 2010 15:23:29 +0530
Message-ID: <AANLkTi==+Ay8d_Cor9YZzMHWFoSxixictgQui2QzXTXn@mail.gmail.com>
References: <AANLkTimzGqmS=YOsJjdM_-d1sJDd4w1t2Cyjk57xrQZo@mail.gmail.com>
	<AANLkTikMK3fsoY5urLEoOT7XEj+03x2qMNO_h2EmSJFD@mail.gmail.com>
	<AANLkTik2kogJ1ibqwOt7RhUPev9ANHYaixr9dm7b7-zZ@mail.gmail.com>
	<AANLkTin+z-Kb9+F4Mj5G8V5fq6X_X3CdSC_HCsRw6sz5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin+z-Kb9+F4Mj5G8V5fq6X_X3CdSC_HCsRw6sz5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks!!!!  I will surely follow as you guided.

On Wed, Oct 6, 2010 at 5:45 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Oct 6, 2010 at 12:34 PM, devi thapa <devi.thapa@gmail.com> wrote:
>> I am actually going only through net.c =A0and in this module they
>> haven't specified anywhere, where this value is coming from.
>
> In order to understand net.c it will be necessary to read other code
> too. =A0Make sure you have an environment that makes it easy to jump to
> function and variable definitions and switch between source files.
> For example, use ctags, cscope, or even Eclipse to navigate the kernel
> source tree.
>
>> So, you mean that kernel vhost code is connected =A0to QEMU userspace co=
de.
>
> QEMU userspace makes use of the vhost interface. =A0If you get stuck
> understanding the kernel side, you can jump to the relevant place in
> QEMU and see what userspace is doing. =A0This will be useful especially
> for the part of the code that sets up a vhost-net device.
>
>> I request to guide me in following the code.
>
> In order to understand the code, you need to put in the effort to dig
> through the source for yourself.
>
> The strategy I follow is to read the code (you've already started with
> the kernel vhost-net code). =A0Much of it will be unclear on the first
> pass.
>
> Now switch to QEMU and read the vhost code there. =A0Patterns will
> become clearer but there will still be unanswered questions.
>
> Go back to the kernel and study it again with the insight you've
> gained from the userspace side.
>
> Iterate a few times. =A0That's how I understand new systems.
>
> Some other ideas to try if you get stuck:
>
> 1. Check the virtio specification for details on vring and the
> virtio-net device:
> http://ozlabs.org/~rusty/virtio-spec/virtio-spec-0.8.9.pdf
>
> 2. Use strace to see how QEMU uses the vhost file descriptor.
>
> 3. Look at related code like the virtio-net guest driver, the tap
> driver, KVM's ioeventfd and irqfd.
>
> Good luck!
>
> Stefan
>
