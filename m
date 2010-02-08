From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] vhost-net: switch to smp barriers
Date: Mon, 8 Feb 2010 18:49:39 +1030
Message-ID: <201002081849.39512.rusty@rustcorp.com.au>
References: <20100201172101.GA10900@redhat.com> <20100207090749.GA12968@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20100207090749.GA12968@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 7 Feb 2010 07:37:49 pm Michael S. Tsirkin wrote:
> On Mon, Feb 01, 2010 at 07:21:02PM +0200, Michael S. Tsirkin wrote:
> > vhost-net only uses memory barriers to control SMP effects
> > (communication with userspace potentially running on a different CPU),
> > so it should use SMP barriers and not mandatory barriers for memory
> > access ordering, as suggested by Documentation/memory-barriers.txt
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Rusty, any feedback on this one?
> Thanks!

Yep.  barrier() is correct on UP to guard against preemption.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks,
Rusty.
