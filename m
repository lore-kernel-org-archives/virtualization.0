From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 04/42] virtio: disable virtio 1.0 in transports
Date: Thu, 27 Nov 2014 12:02:52 +0100
Message-ID: <20141127120252.27021c54.cornelia.huck@de.ibm.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-5-git-send-email-mst@redhat.com>
	<20141125182942.3890fe7b.cornelia.huck@de.ibm.com>
	<20141125212011.GA22343@redhat.com>
	<20141126100954.3811e594.cornelia.huck@de.ibm.com>
	<20141127105434.GA10037@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141127105434.GA10037@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Nov 2014 12:54:34 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Nov 26, 2014 at 10:09:54AM +0100, Cornelia Huck wrote:

> > The old s390 virtio transport in kvm_virtio.c is not part of virtio 1.0.
> 
> It might or might not be a good idea to add code in kvm_virtio.c
> blacklisting VIRTIO_F_VERSION_1, just in case there's a buggy device
> that sets it.
> As correct devices won't set it, I don't think we need to
> worry about it too much. We can make it a patch on top later
> if we want.
> 

I'd want to blacklist it, just to make sure nothing weird happens. I
don't want to spend effort on the old transport beyond that :)
