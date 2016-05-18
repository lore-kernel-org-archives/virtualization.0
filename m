From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] virtio_balloon: fix PFN format for virtio-1
Date: Wed, 18 May 2016 15:27:46 +0200
Message-ID: <20160518152746.1d6abdc2.cornelia.huck@de.ibm.com>
References: <1463574848-15630-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1463574848-15630-1-git-send-email-mst@redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 18 May 2016 15:38:53 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Everything should be LE when using virtio-1, but
> the linux balloon driver does not seem to care about that.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Keeping the pfns in proper byte order seems less hacky than my
approach, and it fixes the crash for my setup as well.

Tested-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
