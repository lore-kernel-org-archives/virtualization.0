From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: virtio message framing
Date: Fri, 13 Apr 2012 10:48:18 -0500
Message-ID: <4F884AC2.9030202@us.ibm.com>
References: <CAJSP0QWPih2NmRvF3D-HXEH72t3pvvywoes-_wv2dAjHKg8Fjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QWPih2NmRvF3D-HXEH72t3pvvywoes-_wv2dAjHKg8Fjg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 04/13/2012 09:50 AM, Stefan Hajnoczi wrote:
> The virtio specification says:
>
> "The descriptors used for a buffer should not effect the semantics
> of the message,
> except for the total length of the buffer"
>
> and
>
> "In particular, no implementation should use the descriptor boundaries
> to determine the size of any header in a request"

This was the noble intention but all of the implementations actually rely on 
boundary sizes.

Both QEMU and lguest rely on boundary sizes.  We've removed some of it in 
virtio-net in QEMU but it still looks like it's there for virtio-blk.

kvm tool also makes this assumption.

> Why should descriptor layout not be specified?
>
> It seems that implementing arbitrary descriptor layout support (e.g.
> 1-byte descriptors) requires more code and makes input validation
> harder.
>
> Why bother with the flexibility of unspecified descriptor layouts?  As
> long as the layout is specified clearly it makes everyone's lives
> easier to use a strict descriptor layout.

I hate to just change the spec here but I don't see a better option.

Regards,

Anthony Liguori

>
> The only reason I can think of is that virtio should work over
> transports that do not have the concept of "descriptors" (non-vring
> transports like pipes or streams).
>
> Stefan
>
