From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] tools/virtio: build fixes for virtio_test
Date: Tue, 11 Feb 2014 08:57:57 +0200
Message-ID: <20140211065757.GA1879@redhat.com>
References: <1392100100-28193-1-git-send-email-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1392100100-28193-1-git-send-email-joel@jms.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joel Stanley <joel@jms.id.au>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2014 at 04:58:17PM +1030, Joel Stanley wrote:
> Recent changes to drivers/virtio broke compilation for the tests in
> tools/virtio. The following patches are build fixes for those changes, as well
> as a fix for a typo that would have never built.
> 
> The changes were tested on my amd64 system against 3.14-rc2.

Ah, thanks a lot for posting this.
I had this fixed in my tree but forgot to send.
For the series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Rusty, will you pick this up?

> Joel Stanley (3):
>   tools/virtio: update internal copies of headers
>   tools/virtio: fix missing kmemleak_ignore symbol
>   tools/virtio: add a missing )
> 
>  drivers/virtio/virtio_ring.c  | 1 +
>  tools/virtio/linux/kmemleak.h | 3 +++
>  tools/virtio/linux/virtio.h   | 4 ++--
>  tools/virtio/virtio_test.c    | 2 +-
>  4 files changed, 7 insertions(+), 3 deletions(-)
>  create mode 100644 tools/virtio/linux/kmemleak.h
> 
> -- 
> 1.9.rc1
