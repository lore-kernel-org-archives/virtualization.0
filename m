From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Tue, 12 May 2009 22:33:14 +0930
Message-ID: <200905122233.15099.rusty__12789.5153630108$1242133593$gmane$org@rustcorp.com.au>
References: <cover.1241700929.git.mst@redhat.com>
	<200905101337.06836.rusty@rustcorp.com.au>
	<20090510072538.GA5335@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090510072538.GA5335@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 10 May 2009 04:55:38 pm Michael S. Tsirkin wrote:
> On Sun, May 10, 2009 at 01:37:06PM +0930, Rusty Russell wrote:
> > Yes, and in fact a rough look at your patch reveals that we don't
> > actually need del_vq: now we track them, we can just do that as part of
> > vdev destruction, right?
>
> Let's assume that a driver encounters an error in probe
> after it calls find_vq. It would need a way to revert
> find_vq, won't it?
>
> It seems to me that bus->remove does not get called
> on probe failure. Isn't that right?

Yep, I looked too fast.

Thanks,
Rusty.
