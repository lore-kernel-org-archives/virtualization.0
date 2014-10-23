From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v3 06/16] virtio: make endian-ness depend on virtio 1.0
Date: Thu, 23 Oct 2014 14:06:30 +0200
Message-ID: <20141023140630.0b627670.cornelia.huck@de.ibm.com>
References: <1414003404-505-1-git-send-email-mst@redhat.com>
	<1414003404-505-7-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1414003404-505-7-git-send-email-mst@redhat.com>
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

On Wed, 22 Oct 2014 21:44:34 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio 1.0 is LE, virtio without 1.0 is native endian.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_config.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Looks sane.
