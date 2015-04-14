From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] virtio_balloon: drop virtio_balloon_stat_modern
Date: Tue, 14 Apr 2015 12:13:27 +0200
Message-ID: <20150414121327.4caacfba.cornelia.huck__7240.38702105663$1429006434$gmane$org@de.ibm.com>
References: <1429005625-23181-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1429005625-23181-1-git-send-email-mst@redhat.com>
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Apr 2015 12:01:13 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Looks like we are better off sticking with the misaligned stat struct,
> to reduce the amount of virtio 1 specific code in balloon.  So let's do
> it.
> 
> Add a detailed comment to reduce the chance people copy this bad example.
> 
> This also fixes a bug on BE architectures: tag should use
> cpu_to_le16, not cpu_to_le32.
> 
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Just reposting so it's easier to apply.
> Feel free to squash into previous patch if you think it's
> neater.

+1 for squashing from me. My A-b would also apply to the squashed patch.
> 
>  include/uapi/linux/virtio_balloon.h | 33 +++++++++++++++++++++++++--------
>  drivers/virtio/virtio_balloon.c     | 19 ++++---------------
>  2 files changed, 29 insertions(+), 23 deletions(-)
