From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/3] virtio: set VIRTIO_CONFIG_S_FEATURES_OK on restore
Date: Thu, 11 Dec 2014 18:23:34 +0100
Message-ID: <20141211182334.2ac1897b.cornelia.huck@de.ibm.com>
References: <1418317279-13915-1-git-send-email-mst@redhat.com>
	<1418317279-13915-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418317279-13915-2-git-send-email-mst@redhat.com>
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

On Thu, 11 Dec 2014 19:01:31 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio 1.0 devices require that drivers set VIRTIO_CONFIG_S_FEATURES_OK
> after finalizing features.
> virtio core missed doing this on restore, fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
