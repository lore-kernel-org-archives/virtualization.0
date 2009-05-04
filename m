From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/8] virtio: add request_vqs/free_vqs operations
Date: Mon, 4 May 2009 14:51:43 +0300
Message-ID: <20090504115143.GA30001__25054.7959273264$1241438161$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
	<20090427123153.GA1156@redhat.com>
	<200905042102.21218.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905042102.21218.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 04, 2009 at 09:02:20PM +0930, Rusty Russell wrote:
> On Mon, 27 Apr 2009 10:01:53 pm Michael S. Tsirkin wrote:
> > This adds 2 new optional virtio operations: request_vqs/free_vqs. They will be
> > used for MSI support, because MSI needs to know the total number of vectors
> > upfront.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi Michael,

Hi Rusty,

>   Thanks for this work!  But this interface is horrible.  Either probe for the
> number of vqs in virtio_pci, or change find_vq to
> 
> 	int (*find_vqs)(struct virtio_device *, unsigned max,
> 						     struct virtqueue *vqs[]);

I'm happier with the later option: it's easy for a host to expose
support for a very large number of vqs, and I don't want them to
waste resources if guest does not use them.

Thanks for the feedback!

> Thanks,
> Rusty.

-- 
MST
