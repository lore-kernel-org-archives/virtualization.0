From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 3/3] virtio_ccw: rev 1 devices set VIRTIO_F_VERSION_1
Date: Thu, 4 Dec 2014 18:59:14 +0100
Message-ID: <20141204185914.4e989a7a.cornelia.huck@de.ibm.com>
References: <1417713984-23771-1-git-send-email-mst@redhat.com>
	<1417713984-23771-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417713984-23771-3-git-send-email-mst@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 4 Dec 2014 19:26:50 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> What does it mean if rev 1 device does not set
> VIRTIO_F_VERSION_1? E.g. is it native endian?
> 
> Let's not even try to drive such devices:
> skip attempts to finalize features or set status.

Why not set status_failed?

> virtio core will detect this and bail out.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

I'm not sure yet whether I like this approach. I'll think about it over
the weekend.
