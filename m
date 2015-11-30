From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] tools/virtio: fix byteswap logic
Date: Mon, 30 Nov 2015 11:02:15 +0100
Message-ID: <20151130110215.7a276000.cornelia.huck@de.ibm.com>
References: <1448872410-11553-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448872410-11553-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 30 Nov 2015 10:33:34 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> commit cf561f0d2eb74574ad9985a2feab134267a9d298 ("virtio: introduce
> virtio_is_little_endian() helper") changed byteswap logic to
> skip feature bit checks for LE platforms, but didn't
> update tools/virtio, so vring_bench started failing.
> 
> Update the copy under tools/virtio/ (TODO: find a way to avoid this code
> duplication).

Not to mention that it is easy to miss the code duplication...

> 
> Cc: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tools/virtio/linux/virtio_config.h | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
