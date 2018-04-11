From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/2] vhost: fix vhost_vq_access_ok() log check
Date: Wed, 11 Apr 2018 16:24:02 +0300
Message-ID: <20180411162345-mutt-send-email-mst@kernel.org>
References: <20180411023541.15776-1-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180411023541.15776-1-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 11, 2018 at 10:35:39AM +0800, Stefan Hajnoczi wrote:
> v3:
>  * Rebased onto net/master and resolved conflict [DaveM]
> 
> v2:
>  * Rewrote the conditional to make the vq access check clearer [Linus]
>  * Added Patch 2 to make the return type consistent and harder to misuse [Linus]
> 
> The first patch fixes the vhost virtqueue access check which was recently
> broken.  The second patch replaces the int return type with bool to prevent
> future bugs.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

We need the 1st one on stable I think.


> Stefan Hajnoczi (2):
>   vhost: fix vhost_vq_access_ok() log check
>   vhost: return bool from *_access_ok() functions
> 
>  drivers/vhost/vhost.h |  4 +--
>  drivers/vhost/vhost.c | 70 ++++++++++++++++++++++++++-------------------------
>  2 files changed, 38 insertions(+), 36 deletions(-)
> 
> -- 
> 2.14.3
