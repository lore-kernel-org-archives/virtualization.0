From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 6/6] virtio: drop legacy_only driver flag
Date: Tue, 9 Dec 2014 12:24:39 +0100
Message-ID: <20141209122439.0d040b7e.cornelia.huck@de.ibm.com>
References: <1418042769-25539-1-git-send-email-mst@redhat.com>
	<1418042769-25539-7-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418042769-25539-7-git-send-email-mst@redhat.com>
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
Cc: dahi@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 8 Dec 2014 15:06:10 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> legacy_only flag is now unused, drop it from core.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h  | 2 --
>  drivers/virtio/virtio.c | 4 ----
>  2 files changed, 6 deletions(-)
> 
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
