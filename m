From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Date: Tue, 21 Jan 2020 09:31:42 -0500
Message-ID: <20200121093104-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
 <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
 <20200120170120-mutt-send-email-mst@kernel.org>
 <CAGxU2F4uW7FNe5xC0sb3Xxr_GABSXuu1Z9n5M=Ntq==T7MaaVw@mail.gmail.com>
 <20200121135907.GA641751@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200121135907.GA641751@stefanha-x1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 21, 2020 at 01:59:07PM +0000, Stefan Hajnoczi wrote:
> On Tue, Jan 21, 2020 at 10:07:06AM +0100, Stefano Garzarella wrote:
> > On Mon, Jan 20, 2020 at 11:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Mon, Jan 20, 2020 at 05:53:39PM +0100, Stefano Garzarella wrote:
> > > > On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> > > > > > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > > > > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > > > > > >
> > > > > > > > > > This patch adds 'netns' module param to enable this new feature
> > > > > > > > > > (disabled by default), because it changes vsock's behavior with
> > > > > > > > > > network namespaces and could break existing applications.
> > > > > > > > >
> > > > > > > > > Sorry, no.
> > > > > > > > >
> > > > > > > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > > > > > > where these netns changes could break things.
> > > > > > > >
> > > > > > > > I forgot to mention the use case.
> > > > > > > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > > > > > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > > > > > > processes involved:
> > > > > > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > > > > > > >   passes it to qemu
> > > > > > > > - kata-shim (runs in a container) wants to talk with the guest but the
> > > > > > > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > > > > > > >   different netns, so the communication is not allowed
> > > > > > > > But, as you said, this could be a wrong design, indeed they already
> > > > > > > > found a fix, but I was not sure if others could have the same issue.
> > > > > > > >
> > > > > > > > In this case, do you think it is acceptable to make this change in
> > > > > > > > the vsock's behavior with netns and ask the user to change the design?
> > > > > > >
> > > > > > > David's question is what would be a usecase that's broken
> > > > > > > (as opposed to fixed) by enabling this by default.
> > > > > >
> > > > > > Yes, I got that. Thanks for clarifying.
> > > > > > I just reported a broken example that can be fixed with a different
> > > > > > design (due to the fact that before this series, vsock devices were
> > > > > > accessible to all netns).
> > > > > >
> > > > > > >
> > > > > > > If it does exist, you need a way for userspace to opt-in,
> > > > > > > module parameter isn't that.
> > > > > >
> > > > > > Okay, but I honestly can't find a case that can't be solved.
> > > > > > So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> > > > > > a real case to come up.
> > > > > >
> > > > > > I'll try to see better if there's any particular case where we need
> > > > > > to disable netns in vsock.
> > > > > >
> > > > > > Thanks,
> > > > > > Stefano
> > > > >
> > > > > Me neither. so what did you have in mind when you wrote:
> > > > > "could break existing applications"?
> > > >
> > > > I had in mind:
> > > > 1. the Kata case. It is fixable (the fix is not merged on kata), but
> > > >    older versions will not work with newer Linux.
> > >
> > > meaning they will keep not working, right?
> > 
> > Right, I mean without this series they work, with this series they work
> > only if the netns support is disabled or with a patch proposed but not
> > merged in kata.
> > 
> > >
> > > > 2. a single process running on init_netns that wants to communicate with
> > > >    VMs handled by VMMs running in different netns, but this case can be
> > > >    solved opening the /dev/vhost-vsock in the same netns of the process
> > > >    that wants to communicate with the VMs (init_netns in this case), and
> > > >    passig it to the VMM.
> > >
> > > again right now they just don't work, right?
> > 
> > Right, as above.
> > 
> > What do you recommend I do?
> 
> Existing userspace applications must continue to work.
> 
> Guests are fine because G2H transports are always in the initial network
> namespace.
> 
> On the host side we have a real case where Kata Containers and other
> vsock users break.  Existing applications run in other network
> namespaces and assume they can communicate over vsock (it's only
> available in the initial network namespace by default).
> 
> It seems we cannot isolate new network namespaces from the initial
> network namespace by default because it will break existing
> applications.  That's a bummer.
> 
> There is one solution that maintains compatibility:
> 
> Introduce a per-namespace vsock isolation flag that can only transition
> from false to true.  Once it becomes true it cannot be reset to false
> anymore (for security).
> 
> When vsock isolation is false the initial network namespace is used for
> <CID, port> addressing.
> 
> When vsock isolation is true the current namespace is used for <CID,
> port> addressing.
> 
> I guess the vsock isolation flag would be set via a rtnetlink message,
> but I haven't checked.
> 
> The upshot is: existing software doesn't benefit from namespaces for
> vsock isolation but it continues to work!  New software makes 1 special
> call after creating the namespace to opt in to vsock isolation.
> 
> This approach is secure because whoever sets up namespaces can
> transition the flag from false to true and know that it can never be
> reset to false anymore.
> 
> Does this make sense to everyone?
> 
> Stefan

Anything wrong with a separate device? whoever opens it decides
whether netns will work ...

-- 
MST
