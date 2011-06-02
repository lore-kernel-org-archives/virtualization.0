From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Thu, 2 Jun 2011 13:34:06 +0300
Message-ID: <20110602103406.GD7943__26210.3797089823$1307010888$gmane$org@redhat.com>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
	<4DE5F78C.1010102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4DE5F78C.1010102@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Wu <dwu@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 01, 2011 at 04:25:48AM -0400, Mark Wu wrote:
> On 06/01/2011 03:24 AM, Mark Wu wrote:
> >-	if (index_to_minor(index)>= 1<<  MINORBITS)
> >-		return -ENOSPC;
> >+	do {
> >+		if (!ida_pre_get(&vd_index_ida, GFP_KERNEL))
> >+			return err;
> >+
> There's a problem in above code: err is not initialized before
> using, so change it to return -1;
> +       do {
> +               if (!ida_pre_get(&vd_index_ida, GFP_KERNEL))
> +                       return -1;

Not -1. Pls return -ENOMEM.
