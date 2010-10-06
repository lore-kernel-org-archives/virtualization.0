From: devi thapa <devi.thapa@gmail.com>
Subject: Re: vhost_net_ioctl
Date: Wed, 6 Oct 2010 17:04:39 +0530
Message-ID: <AANLkTik2kogJ1ibqwOt7RhUPev9ANHYaixr9dm7b7-zZ@mail.gmail.com>
References: <AANLkTimzGqmS=YOsJjdM_-d1sJDd4w1t2Cyjk57xrQZo@mail.gmail.com>
	<AANLkTikMK3fsoY5urLEoOT7XEj+03x2qMNO_h2EmSJFD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikMK3fsoY5urLEoOT7XEj+03x2qMNO_h2EmSJFD@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The arg value is being used to get the fd of the backend, in my case,
I prefer tap as a backend device.

And the same arg value is being used to get the features of backend device.

I am actually going only through net.c  and in this module they
haven't specified anywhere, where this value is coming from.

So, you mean that kernel vhost code is connected  to QEMU userspace code.

I request to guide me in following the code.

With hope,
Devi.






On 10/6/10, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Oct 6, 2010 at 11:16 AM, devi thapa <devi.thapa@gmail.com> wrote:
>>           What's the role or value of the third argument in the
>> vhost_net_ioctl function in /drivers/vhost/net.c .
>
> Read the code.  There is the kernel vhost code and the QEMU vhost
> userspace code to look at.  By studying both sides you can figure this
> out.
>
> Look at how arg is used in vhost_net_ioctl().
>
> Please spend more time learning how things work before sending
> questions to the mailing list.
>
> Stefan
>
