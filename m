From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/2] virtio_net: Improve the recv buffer allocation
	scheme
Date: Thu, 9 Oct 2008 08:35:46 -0700
Message-ID: <20081009153546.GA6912@sequoia.sous-sol.org>
References: <1223494499-18732-1-git-send-email-markmc@redhat.com> <1223494499-18732-2-git-send-email-markmc@redhat.com> <200810091155.59731.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759990AbYJIPgT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200810091155.59731.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mark McLoughlin <markmc@redhat.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert.xu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> On Thursday 09 October 2008 06:34:59 Mark McLoughlin wrote:
> > From: Herbert Xu <herbert.xu@redhat.com>
> >
> > If segmentation offload is enabled by the host, we currently allocate
> > maximum sized packet buffers and pass them to the host. This uses up
> > 20 ring entries, allowing us to supply only 20 packet buffers to the
> > host with a 256 entry ring. This is a huge overhead when receiving
> > small packets, and is most keenly felt when receiving MTU sized
> > packets from off-host.
> 
> There are three approaches we should investigate before adding YA feature.  
> Obviously, we can simply increase the number of ring entries.

Tried that, it didn't help much.  I don't have my numbers handy, but
levelled off at about 512 and was a modest boost.  It's still wasteful
to preallocate like that on the off-chance it's a large packet.

thanks,
-chris
