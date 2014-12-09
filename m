From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] virtio_ccw: minor enhancements
Date: Tue, 9 Dec 2014 23:49:07 +0200
Message-ID: <20141209214907.GA13855@redhat.com>
References: <1418133187-12436-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418133187-12436-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty, I guess you are busy.

I'd like to send all these patch series combined to Linus.  To see what
I have queued, you can check the vhost-next branch in my tree.

Will wait until tomorrow to give you a chance to respond.


On Tue, Dec 09, 2014 at 03:53:32PM +0200, Michael S. Tsirkin wrote:
> Two enhancements for virtio_ccw, on top of latest 1.0 patchset
> 
> Cornelia Huck (1):
>   virtio_ccw: finalize_features error handling
> 
> Michael S. Tsirkin (1):
>   virtio_ccw: future-proof finalize_features
> 
>  drivers/s390/kvm/virtio_ccw.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> -- 
> MST
> 
