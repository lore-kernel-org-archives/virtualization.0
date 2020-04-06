From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio: stop using legacy struct vring
Date: Mon, 6 Apr 2020 11:57:43 -0400
Message-ID: <20200406115653-mutt-send-email-mst@kernel.org>
References: <20200406153245.127680-1-mst@redhat.com>
 <20200406153245.127680-2-mst@redhat.com>
 <20200406155602.GA160445@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200406155602.GA160445@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Vadim Pasternak <vadimp@mellanox.com>, Jason Wang <jasowang@redhat.com>, platform-driver-x86@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 05:56:02PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 06, 2020 at 11:35:23AM -0400, Michael S. Tsirkin wrote:
> > struct vring (in the uapi directory) and supporting APIs are kept
> > around to avoid breaking old userspace builds.
> > It's not actually part of the UAPI - it was kept in the UAPI
> > header by mistake, and using it in kernel isn't necessary
> > and prevents us from making changes safely.
> > In particular, the APIs actually assume the legacy layout.
> > 
> > Add struct vring_s (identical ATM) and supporting
> > legacy APIs and switch everyone to use that.
> 
> How are we going to know that "struct vring_s" is what we need/want to
> use?  What does "_s" mean?
> 
> "struct vring_kernel"?
> 
> naming is hard...
> 
> greg k-h

Hmm. I guess I can just add an ifdef so kernel doesn't see the UAPI
version anymore ...

-- 
MST
