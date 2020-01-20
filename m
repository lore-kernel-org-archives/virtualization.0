From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Date: Mon, 20 Jan 2020 11:17:35 +0100
Message-ID: <20200120101735.uyh4o64gb4njakw5@steredhat>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200120.100610.546818167633238909.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhansen@vmware.com, jasowang@redhat.com, kvm@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, mst@redhat.com, decui@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Thu, 16 Jan 2020 18:24:26 +0100
> 
> > This patch adds 'netns' module param to enable this new feature
> > (disabled by default), because it changes vsock's behavior with
> > network namespaces and could break existing applications.
> 
> Sorry, no.
> 
> I wonder if you can even design a legitimate, reasonable, use case
> where these netns changes could break things.

I forgot to mention the use case.
I tried the RFC with Kata containers and we found that Kata shim-v1
doesn't work (Kata shim-v2 works as is) because there are the following
processes involved:
- kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
  passes it to qemu
- kata-shim (runs in a container) wants to talk with the guest but the
  vsock device is assigned to the init_netns and kata-shim runs in a
  different netns, so the communication is not allowed

But, as you said, this could be a wrong design, indeed they already
found a fix, but I was not sure if others could have the same issue.

In this case, do you think it is acceptable to make this change in
the vsock's behavior with netns and ask the user to change the design?

> 
> I am totally against adding a module parameter for this, it's
> incredibly confusing for users and will create a test scenerio
> that is strongly less likely to be covered.
> 

Got it, I'll remove the module parameter!

Thanks,
Stefano
