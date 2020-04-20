From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] vhost: disable for OABI
Date: Mon, 20 Apr 2020 01:29:09 -0700
Message-ID: <20200420082909.GA28749@infradead.org>
References: <20200416221902.5801-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416221902.5801-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 16, 2020 at 06:20:20PM -0400, Michael S. Tsirkin wrote:
> vhost is currently broken on the some ARM configs.
> 
> The reason is that that uses apcs-gnu which is the ancient OABI that is been
> deprecated for a long time.
> 
> Given that virtio support on such ancient systems is not needed in the
> first place, let's just add something along the lines of
> 
> 	depends on !ARM || AEABI
> 
> to the virtio Kconfig declaration, and add a comment that it has to do
> with struct member alignment.
> 
> Note: we can't make VHOST and VHOST_RING themselves have
> a dependency since these are selected. Add a new symbol for that.

This description is horrible.  The only interesting thing for ARM OABI
is that it has some strange padding rules, but that isn't something
that can't be handled.   Please spend some time looking into the issue
and add te proper __padded annotations, we've done that elsewhere in
the kernel and it isn't too bad - in fact it helps understanding issues
with implicit alignment.

And even if you have a good reason not to fix vhost (which I think you
don't have) this changelog is just utter crap, as it fails to mention
what the problem with ARM OABI even is.
