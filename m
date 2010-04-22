From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4] Add mergeable RX bufs support to vhost
Date: Thu, 22 Apr 2010 20:58:13 +0300
Message-ID: <20100422175813.GA2145@redhat.com>
References: <20100422174349.GA1926@redhat.com> <OF4D87C139.FBE240E7-ON8825770D.0061E3C3-8825770D.0062DEBC@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OF4D87C139.FBE240E7-ON8825770D.0061E3C3-8825770D.0062DEBC@us.ibm.com>
Sender: kvm-owner@vger.kernel.org
To: David Stevens <dlstevens@us.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 22, 2010 at 11:59:55AM -0600, David Stevens wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote on 04/22/2010 10:43:49 AM:
> 
> > On Mon, Apr 19, 2010 at 03:12:19PM -0700, David L Stevens wrote:
> > > This patch adds the mergeable RX buffers feature to vhost.
> > > 
> > > Signed-off-by: David L Stevens <dlstevens@us.ibm.com>
> > 
> > BTW, which userspace should I use for testing this?
> 
>         I use the qemu-kvm patch to your git tree that I posted
> a while back (also attached).

Doesn't apply, probably also corrupted.
Could you put it up on dropbox please?

> And it needs your TUNSETVNETHDRSIZE
> ioctl in the kernel as well. Also, I added the TUN ioctl
> defines to /usr/include for this to pick up (it compiles, but
> won't do the ioctl's without that); will get back
> to that patch per your comments next.
> 
> [also correction: I said 10-20% guest to host, I meant host-to-guest
>         (ie, the receiver side). h2g appears improved too, but not as
>         much)]
> 
>                                                         +-DLS


