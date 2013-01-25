From: Andy King <acking@vmware.com>
Subject: Re: [Pv-drivers] [PATCH 0/6] VSOCK for Linux upstreaming
Date: Fri, 25 Jan 2013 13:33:34 -0800 (PST)
Message-ID: <362258122.36962636.1359149614436.JavaMail.root__9938.85356369919$1359149649$gmane$org@vmware.com>
References: <1426158581.24554896.1357785777229.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1426158581.24554896.1357785777229.JavaMail.root@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> > > Our position is that VSOCK feature set is more complete and that
> > > it
> > > should be possible to use transports other than VMCI for VSOCK
> > > traffic, should interested parties implement them,
> > 
> > Implementing other transports requires restructing vsock (and vmci)
> > first as the current vsock code is not a hypervisor neutral
> > service.
> 
> I'm going to bite the bullet and spend the next couple of days doing
> just that: factoring out the VMCI bits and hiding them behind a
> transport layer.  It'll be a bit rough, but it'll be a start.  We'll
> submit another patch series next week with that.  I'm hoping that'll
> get us over this hump, since it should by hypervisor agnostic at
> that point.  It'll be up to you guys to add virtio, though :)

I sent out a patch series this morning that splits out our code into a
core part, containing the socket family/operations, and a VMCI-specific
part.  The core makes callbacks via a new transport layer into VMCI.
It's not perfect -- there's still some cruft in the core socket
structure -- but it lays the foundation of a hypervisor-neutral channel,
and hopefully we can build on this with your help.  It'd be great if
you could take a look.

Thanks!
- Andy
