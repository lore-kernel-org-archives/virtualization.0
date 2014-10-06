From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 07/16] virtio-blk: drop config_mutex
Date: Mon, 6 Oct 2014 13:48:45 +0200
Message-ID: <20141006134845.157ba74f.cornelia.huck@de.ibm.com>
References: <1412525038-15871-1-git-send-email-mst@redhat.com>
	<1412525038-15871-8-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412525038-15871-8-git-send-email-mst@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 5 Oct 2014 19:07:10 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> config_mutex served two purposes: prevent multiple concurrent config
> change handlers, and synchronize access to config_enable flag.
> 
> Since commit dbf2576e37da0fcc7aacbfbb9fd5d3de7888a3c1
>     workqueue: make all workqueues non-reentrant
> all workqueues are non-reentrant, and config_enable
> is now gone.
> 
> Get rid of the unnecessary lock.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
